/* ahci.c : Contains the implementation of the AHCI HBA driver.
 * */

#include "kernel.h"
#include "kdata.h"
#include "pci_regs.h"
#include "pci.h"
#include "ahci.h"
#include "module.h"

#define AHCIBABBLE
#ifdef AHCIBABBLE
#define abprintf printf
#define abiprintf iprintf
#else
#define abprintf noprintf
#define abiprintf noprintf
#endif

struct ale {
		struct list_head devs;
		struct ahci_device* dev;
} ahci_dl = { .dev = NULL, .devs = LIST_HEAD_INIT(ahci_dl.devs) };

/* BITFIELDS GENERAL: writing to lower 8/16 bits can cause BYTE/WORD access
 * which is invalid -> use for reading. */

#ifndef __clang__
STATIC_ASSERT(sizeof(struct ahci_port)==0x80, ahci_port_not_80h_bytes);
STATIC_ASSERT(sizeof(struct ahci_hba)==0x180, ahci_hba_not_180h_bytes);
STATIC_ASSERT(sizeof(struct ahci_cmdlst)==0x400, ahci_hba_not_400h_bytes);
STATIC_ASSERT(sizeof(struct ahci_cmdtbl)==0x80, ahci_cmdtbl_not_80h_bytes);
STATIC_ASSERT(sizeof(struct ahci_prdt)==0x10, ahci_prdt_not_10h_bytes);
STATIC_ASSERT(sizeof(struct ahci_fis)==0x100, ahci_prdt_not_100h_bytes);
STATIC_ASSERT(sizeof(struct sata_reg_h2d)==0x14, sata_reg_h2d_not_14h_bytes);
STATIC_ASSERT(sizeof(struct ata_identify)==0x200, ata_identify_not_200h_bytes);
#endif

/* this is the concat of three structs pending/proc/ctx */
struct cmd_ctx {
		struct list_head lst;
		enum port_cmd c;
		/* pending cmd: initial values */
		uint64_t lba;
		uint64_t ct;
		void* ptr;
		uint16_t pmprt;
		/* proc cmd: during execution */
		struct wait_queue_head* wq_wake;
		struct cmd_status* status; /* consumer info */
		uint16_t port;
		uint16_t slot;
		void* cur_buf;
		void* cont_ctx; /* specific continuation context */
		uint64_t bts_left;
		/* cmd_ctx: command build context */
		struct {
				uint16_t prdtl;
				uint16_t flg; /* PMP R C B R P W A CFL */
		} clh;
		struct ahci_ct_e* entry;
		uint32_t max_prdtl;
}; /* 70bt size -> slab allocator? DONE */

struct ahci_ct_pool {
		uint32_t prdt_cap;
		struct ahci_ct_pool* next;
		uint32_t mask; /* not alloc always 1 */
		struct ahci_ct_e {
				uint16_t port, slot; /* dbg info? */
				struct ahci_cmdtbl* ptr;
				uint64_t pmem;
		} tables[32];
};

/* Forward declarations:
 * */
void ahci_issue_command(struct ahci_device* ad, int port, int pmprt, enum port_cmd cmd,
				uint64_t lba, uint64_t ct, void* ptr, struct wait_queue_head* wq_h, struct cmd_status* st);
void ahci_reissue_command(struct ahci_device* ad, struct cmd_ctx* cc);
int ahci_handle_command_error(struct ahci_device* ad, struct cmd_ctx* cc, uint32_t tfd);
struct cmd_ctx* ahci_allocate_context(struct ahci_device* ad);
void ahci_destroy_context(struct ahci_device* ad, struct cmd_ctx* cc);
void ahci_release_cmdtbl(struct ahci_device* ad, struct ahci_ct_e* entry);
void ahci_reset_port(struct ahci_hba* h, struct ahci_port* p);

/* The IDENTIFY (PACKET) commands
 * */

/* will (almost) always succeed */
int ata_build_device_identify(struct ahci_device* ad, struct cmd_ctx* ctx)
{
		struct ahci_cmdtbl* t = ctx->entry->ptr;
		struct sata_reg_h2d* r = &t->cfis.rh2d;
		void* ptr = ctx->ptr; uint64_t b1, b2 = 0;
		uint16_t bc1 = 512, bc2 = 0;

		/* we use exactly one PRD except someone manages
		 * to send two pages in ptr for 512 bytes */
		if (ctx->max_prdtl < 1)
				return -1;

		/* build the FIS */
		bzero(t, sizeof(*t) + ctx->max_prdtl * sizeof(*t->prdts));
		r->fis_type = FIS_REG_H2D;
		r->pm_port = ctx->pmprt;
		r->res0 = 0;
		r->c = 1;
		r->command = ATA_CMD_IDENTIFY_DEVICE;
		r->feat_high = r->feat_low = 0; /* N/A */
		r->lba_high = r->lba_low = 0; /* N/A */
		r->count = 0; /* N/A */
		r->device = 0; /* bit4 is transport dependent */
		r->icc = 0;
		r->control = 0;
		r->res1 = 0;

		/* get the target memory */
		if (!ptr) {
				/* we use the device buffers */
				ptr = ad->identify_data[ctx->entry->port].ptr;
				b1 = ad->identify_data[ctx->entry->port].pm;
		} else {
				size_t ofs = (size_t)ptr % 4096;
				/* we have to get the offset ourself */
				b1 = mm_page_get_pmem(&mm_kernel, ptr);
				if (4096 - ofs < 512) { /* across pages */
						bc1 = 4096 - ofs;
						bc2 = 512 - (4096 - ofs);
						b2 = mm_page_get_pmem(&mm_kernel, ptr + bc1);
						/* but contiguous */
						if (b2 == b1 + 4096) {
								bc1 = 512; bc2 = 0;
								b2 = 0;
						}
				}
				b1 += ofs;
		}

		/* fill the cmdtbl */
		abprintf("IDENTIFY: %016llx %p\n", ctx->entry->pmem, t);
		abprintf("b1: %016llx\n", b1);
		t->prdts[0].dba64 = b1;
		t->prdts[0].dbc = bc1 - 1; /* IDENTIFY returns 512bt */
		t->prdts[0].I = 1; /* interrupt on completion */
		if (b2) {
				if (ctx->max_prdtl < 2)
						return -1; /* TODO: word alignment */
				t->prdts[1].dba64 = b2;
				t->prdts[1].dbc = bc2 - 1; /* IDENTIFY returns 512bt */
				t->prdts[1].I = 1; /* interrupt on completion */
				t->prdts[0].I = 0; /* not too early */
		}

		/* and set the context */
		ctx->clh.prdtl = b2 ? 2 : 1;
		/* PMP; C (clear BSY,CI); 14h bt=5dw length*/
		ctx->clh.flg = 0x0405 | ((ctx->pmprt & 0xf) << 12);
		/* no further actions required, save for cleanup and waking */
		ctx->cont_ctx = NULL;
		ctx->cur_buf = NULL;
		ctx->bts_left = 0;
		/* inform consumers */
		if (ctx->status) {
				ctx->status->bts_cur = 0;
				ctx->status->bts_left = 512; /* bts_left in ctx is internal */
		}
		return 0;
}

/* will (almost) always succeed */
int atapi_build_packet_device_identify(struct ahci_device* ad,
				struct cmd_ctx* ctx)
{
		printf("ATAPI IDENTIFY PACKET DEVICE %p %p\n", ad, ctx);
		return -1;
}

/* The READ_DMA_EXT commands
 * */

int ata_build_read_dma_ext(struct ahci_device* ad, struct cmd_ctx* ctx)
{
		struct ahci_cmdtbl* t = ctx->entry->ptr;
		struct sata_reg_h2d* r = &t->cfis.rh2d;
		void* ptr = ctx->ptr; uint64_t b1, b2 = 0;
		uint16_t bc1 = 512, bc2 = 0;

		// TODO: build scatter list

		/* build the FIS */
		bzero(t, sizeof(*t) + ctx->max_prdtl * sizeof(*t->prdts));
		r->fis_type = FIS_REG_H2D;
		r->pm_port = ctx->pmprt;
		r->res0 = 0;
		r->c = 1;
		r->command = ATA_CMD_READ_DMA_EXT;
		r->feat_high = r->feat_low = 0; /* reserved */
		r->lba_high = (uint32_t)((ctx->lba >> 24) & 0x00ffffff);
		r->lba_low = (uint32_t)(ctx->lba & 0x00ffffff);
		r->count = 1/*ctx->ct / 512*/; /* log sector count (first identify )*/
		r->device = (1 << 6); /* bit6 shall be set to one */
		r->icc = 0;
		r->control = 0;
		r->res1 = 0;

		/* get the target memory */
		if (!ptr) {
				/* we use the device buffers */
				ptr = ad->identify_data[ctx->entry->port].ptr;
				b1 = ad->identify_data[ctx->entry->port].pm;
		} else {
				die("not there yet!\n");
				size_t ofs = (size_t)ptr % 4096;
				/* we have to get the offset ourself */
				b1 = mm_page_get_pmem(&mm_kernel, ptr);
				if (4096 - ofs < 512) { /* across pages */
						bc1 = 4096 - ofs;
						bc2 = 512 - (4096 - ofs);
						b2 = mm_page_get_pmem(&mm_kernel, ptr + bc1);
						/* but contiguous */
						if (b2 == b1 + 4096) {
								bc1 = 512; bc2 = 0;
								b2 = 0;
						}
				}
				b1 += ofs;
		}

		/* fill the cmdtbl */
		abprintf("READ DMA EXT: %016llx %p\n", ctx->entry->pmem, t);
		abprintf("b1: %016llx\n", b1);
		t->prdts[0].dba64 = b1;
		t->prdts[0].dbc = bc1 - 1; /* IDENTIFY returns 512bt */
		t->prdts[0].I = 1; /* interrupt on completion */

		/* and set the context */
		ctx->clh.prdtl = 1;
		/* PMP; C (clear BSY,CI); 14h bt=5dw length*/
		ctx->clh.flg = 0x0405 | ((ctx->pmprt & 0xf) << 12);
		/* no further actions required, save for cleanup and waking */
		ctx->cont_ctx = NULL;
		ctx->cur_buf = NULL;
		ctx->bts_left = 0;
		/* inform the consumers */
		if (ctx->status) {
				ctx->status->bts_left = 122123;
				ctx->status->bts_cur = bc2;
		}
		return 0;
}

/* The WRITE_DMA_EXT commands
 * */

/* The SATA TRIM command
 * */

const char* capstr(int idx, int limit, ...)
{
		const char** rv = (const char**)(&limit + 1);
		return rv[min(idx, limit)];
}

struct cmd_ctx* ahci_allocate_context(struct ahci_device* ad)
{
		struct cmd_ctx* rv;
		rv = list_cut_first_entry(&ad->ctxs, struct cmd_ctx, lst);
		if (!rv)
				rv = kzalloc(sizeof(*rv));
		return rv;
}

void ahci_destroy_context(struct ahci_device* ad, struct cmd_ctx* cc)
{
		bzero(cc, sizeof(*cc));
		list_add_tail(&cc->lst, &ad->ctxs);
}


int ahci_handle_command_error(struct ahci_device* ad,
				struct cmd_ctx* cc, uint32_t tfd)
{
		if (cc->c == disk_cmd_identify) {
				/* TODO: send ATAPI command instead */
				return -1;
		} else { /* delete the command and inform the consumer */
				if (cc->status)
						cc->status->state = cmd_state_abort;
				if (cc->wq_wake)
						wake_up_external_event(cc->wq_wake);
				return -1;
		}
}

/* we're not performing the reset in the interrupt handler
 *  --> only issue a reset host command and reissue the valid commands. */
void ahci_port_handle_tfes_regular(struct ahci_device* ad,
				struct ahci_port* p, int pt)
{
		uint32_t ci = p->pXci; /* all pending commands */
		uint16_t slt = p->cmd.ccs; /* the offending one */
		struct cmd_ctx* cc2;

		/* clearing ST is still possible (reduces wait time) and
		 * prevents worker from issuing further commands */
		p->cmd.st = 0;

		/* the decision to do a full reset will be undertaken
		 * in the processing of the host command, as the clearing
		 * of CR has to be waited for. */

		/* now do the bookkeeping */
		abiprintf("slot which caused task file error: %u\n", slt);
		list_for_each_entry(cc2, &ad->proc_cmds[pt], lst) {
				struct cmd_ctx* cc = cc2; /* we're clearing the list */
				list_del_and_prepare_continue(cc2, &ad->proc_cmds[pt], lst);
				abiprintf("inside slt: %u\n", cc->slot);

				/* is it the offending one? */
				if (cc->slot == slt) {
						/* show some diagnostics */
						abiprintf("command in slot %u of port %d failed: err=%x, sts=%x\n",
								slt, pt, p->tfd.err, p->tfd.sts);
						/* handle the error */
						if (-1 == ahci_handle_command_error(ad, cc, p->pXtfd)) {
								/*  cleanup */
								ahci_release_cmdtbl(ad, cc->entry);
								ahci_destroy_context(ad, cc);
						} else {/* issue the fixed/new command */
								abiprintf("command reissued.\n");
								ahci_reissue_command(ad, cc);
						}
				} else {
						/* check presence in CI (maybe already finished?) */
						if (ci & (1 << cc->slot)) {
								/* reissue */
								ahci_reissue_command(ad, cc);
						} else {
								/* TODO: notify consumers */
								die("not implemented\n");
						}
				}
		}

		/* issue the reset host command */
		ahci_issue_command(ad, pt, 0 /* TODO: handle pmport */, host_cmd_reset,
				0, 0, NULL, NULL, NULL);
}

void ahci_port_handle_tfes_ncq(struct ahci_device* ad,
				struct ahci_port* p, int pt)
{
		(void)ad; (void)p; (void)pt;
		die("not implemented!\n");
}

void ahci_port_handle_pcs_cominit(struct ahci_device* ad,
				struct ahci_port* p, int pt)
{
		(void)ad; (void)p; (void)pt;
		die("not implemented!\n");
}

void ahci_port_check_finished_commands(struct ahci_device* d, int pt, uint32_t ci)
{
		struct cmd_ctx* cc;
		list_for_each_entry(cc, &d->proc_cmds[pt], lst) {
				/* check all slots (for parallel completion) */
				if (!(ci & (1 << cc->slot))) { /* slot was cleared */
						/* are all PRDTs are processed? */
						uint16_t prdtl; uint32_t bc = 0, bc0 = 0;
						/* TODO: dangerous as new cmd could already
						 * have been issued & finished --> use local
						 * copy of ci and prevent reissue via find_slot
						 * until this point. */

						/* get the PRDT info on byte count, if we have such. */
						if ((prdtl = d->command_lists[pt]->chdrs[cc->slot].prdtl)) {
								bc0 = d->command_lists[pt]->chdrs[cc->slot].prdbc;
								struct ahci_prdt* pr = cc->entry->ptr->prdts;
								while (prdtl--)
										bc += pr->dbc;
						}
						if (!cc->cont_ctx && !cc->bts_left) {
								/* command has finished */
								if (cc->c == disk_cmd_identify) {
										struct cmd_ctx* cc2 = cc;
										/* issue the host command */
										abiprintf("identify host command issued\n");
										cc->c = host_cmd_process_identify;
										list_del_and_prepare_continue(cc, &d->proc_cmds[pt], lst);
										ahci_reissue_command(d, cc2); /* worker has to work */
										continue;
								} else {
										if (cc->status) {
												cc->status->state = cmd_state_completed;
												/* TODO: mutli-command, single status (large transfers) */
												cc->status->bts_cur = bc;
												cc->status->bts_left = bc0 - bc;
										}
										if (cc->wq_wake)
												wake_up_external_event(cc->wq_wake);
								}
								/* else die */
								die("command w/o info finished.\n");
						} else {
								/* needs continuation */
								if (bc0 == bc) {
										/* everything there */
										if (cc->status) {
												cc->status->bts_cur += bc;
												cc->status->bts_left -= bc;
										}
								} else {
										/* TODO: think about incomplete tranfers */
										die("incomplete transfer\n"); /* possible by design of intr? */
								}
								die("not implemented yet!\n");
						}
				}
				else { /* command still running, i.e. transfer not finished or error */
						iprintf("slot %u still active\n", cc->slot);
				}
		}
}

void ahci_port_intr(struct ahci_device* d, int pt)
{
		struct ahci_port* p = &d->ptr->port[pt];
		uint32_t is = p->pXis, cm = 0; /* unaffected by mask */
		uint32_t ci = p->pXci; /* check if still set */

		/* 22 31 6 <- listen mode */
		/* else: Change in PhyRdy, CPS, TFS.err, PCS, DPS(I=1),
		 * UFS, HBFS, HBDS, IFS */

		/* TODO: possibly merge handlers for DPS & D2H */
		/* first collect transferred data */
		if (is & (1 << 5)) { /* DPS: data processed (PRD&I), commands must use C bit */
				ahci_port_check_finished_commands(d, pt, ci);
				cm |= (1 << 5);
		}

		/* check finished non-exhausted commands */
		if (is & (1 << 0)) { /* D2H FIS (more reliable) */
				ahci_port_check_finished_commands(d, pt, ci);
				cm |= 1;
		}

		/* check for unsolicted COMINIT */
		if (is & (1 << 6)) { /* PCS */
				/* see and clear pXser.diag, cm RO */
				abiprintf("PCS on port %d received, resetting...\n", pt);
				p->pXserr = 0xffffffff;
				//ahci_port_handle_pcs_cominit(d, p, pt);
				ahci_reset_port(d->ptr, p);
		}

		/* check TFES */
		if (is & (1 << 30)) { /* we need to restart the command engine */
				/* ATAATAPI-ACS3: error indicates device0/1 (from PATA times).
				 * For DEVICE RESET field is reserved. For
				 * READ SECTOR(S), IDENTIFY DEVICE and EXECUTE
				 * DEVICE DIAGNOSTICS commands, bit 2 signifies ABORT. */

				/* non-NCQ */
				ahci_port_handle_tfes_regular(d, p, pt);
				/* TODO: NCQ */
				//ahci_port_handle_tfes_ncq(d, p, pt);
				cm |= (1 << 30);
		}

		/* DEBUG: clear the others enabled <- i.e. prevent infinite intrs */
		cm |= p->pXie;
		abiprintf("port cm: %x\n", cm);

		/* clear the status */
		p->pXis = cm;
}

void ahci_handle_interrupt(struct ahci_device* d, unsigned int irq)
{
		(void)irq;
		/* TODO: MSI supp (irq is for MSI support /w base) */
		uint32_t is = d->ptr->intr, clm = 0;

		/* we trust IS */
		for (int i = 0; i < 32; i++) {
				if (is & (1 << i)) {
						ahci_port_intr(d, i);
						clm |= (1 << i);
				}
		}

		/* clear handled IS (in case of parallel updates) */
		d->ptr->intr = clm;
}

int ahci_irq(unsigned int irq)
{
		struct ale* d; int rv;

		/*lock_list(ahci_dl.devs);*/
		list_for_each_entry(d, &ahci_dl.devs, devs) {
				if (d->dev->dev->intr_line == irq) {
						if (pci_check_interrupt(d->dev->dev)) {
								ahci_handle_interrupt(d->dev, irq);
								return 1;
						} else { /* somehow it is not always set: poll the device */
								if (d->dev->ptr->intr) {
										ahci_handle_interrupt(d->dev, irq);
										rv++;
								}
						}
				}
		}
		/*unlock_list(ahci_dl.devs);*/
		if (!rv)
				abiprintf("ignored non AHCI interrupt\n");
		return rv;
}

/* TODO: Impelemnt local persistent copy to reuse slot for multiple commands */
int ahci_find_slot(volatile struct ahci_port* p, int cmd_ct)
{
		uint32_t bitmask = (p->pXci/* NCQ: | p->pXsact*/);
		for (int i = 0; i < cmd_ct; i++) {
				if (!(bitmask & 1))
						return i;
				bitmask >>= 1;
		}
		return -1;
}

void ahci_release_cmdtbl(struct ahci_device* ad, struct ahci_ct_e* entry)
{
		struct ahci_ct_pool* ctp = ad->ctbl_pool;

		while (ctp) {
				ptrdiff_t ofs = ctp->tables - entry;
				if (ofs >= 0 && ofs < 32) {
						uint16_t p = entry->port, slt = entry->slot;
						/* we've found the entry */
						entry->port = entry->slot = 0xffff;
						if (!((1 << ofs) & __sync_fetch_and_and(&ctp->mask,
								~(1 << ofs)))) {
								/* already cleared */
								abprintf("attempt to release command table at %p"
										" for port %u slot %u which was not "
										" acquired. Its offset is %ld.\n",
										entry->ptr, p, slt, ofs);
						}
						break;
				}
				ctp = ctp->next;
		}
}

struct ahci_ct_e* ahci_find_cmdtbl(struct ahci_device* ad, uint32_t prdt_ct)
{
		struct ahci_ct_pool* ctp = ad->ctbl_pool;

		while (ctp) {
				if (ctp->prdt_cap >= prdt_ct) {
						int bit;
Pos1:
						bit = bsf(~ctp->mask); /* 1 based */
						if (bit--) {
								/* one set (i.e. unset bit) */
								if (!((1 << bit) & __sync_fetch_and_or(&ctp->mask, 1 << bit))) {
										/* we have a slot */
										return &ctp->tables[bit];
								} else /* already set by a competitor */
										goto Pos1;
						}
				}
				/* advance */
				ctp = ctp->next;
		}

		/* no tables avaiable despite there being slots free */
		/* maybe we should ask for more tables? */
		static uint64_t warn_time = 0;
		if (jiffies - warn_time > HZ * 300) {
				/* warn every 5 minutes with continuous exhaustion */
				warn_time = jiffies;
				cprintf(KFMT_INFO, "Command table pool exhausted.\nI/O performance"
								" could suffer from this.\n");
		}

		return NULL;
}

/* command gets automatically removed from list so lh not needed. Also
 * cc->lst is invalid, i.e. trying to remove it from list results in despair.  */
void ahci_process_host_command(struct ahci_device* ad,
				struct ahci_port* p, struct cmd_ctx* cc)
{
		switch (cc->c) {
				case host_cmd_process_identify: {
						struct ata_identify* id = ad->identify_data[cc->port].ptr;
						int comp = 1, su = 0, pt = cc->port;
						/* check if complete and valid */
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC
								|| id->specific_configuration == ATA_SC_NO_SPIN_UP_INC)
								comp = 0;
						if (id->specific_configuration == ATA_SC_NEED_SPIN_UP
								|| id->specific_configuration == ATA_SC_NEED_SPIN_UP_INC)
								su = 1;
						/* do the checksum */
						if (comp && id->checksum_validity == 0xa5) {
								if (checksum_memory(id, sizeof(*id))) {
										/* invalid data, retry? */
										cc->c = disk_cmd_identify;
										cc->ptr = NULL;
										cc->cur_buf = NULL;
										printf("Invalid IDENTIFY received: reissuing...\n");
										ahci_reissue_command(ad, cc);
										return; /* we reuse cc */
								}
						}
						/* don't spin up if we don't have to? */
						if (comp) {
								uint64_t max_sec = 0; uint32_t lpp = 1, lls = 512, lof = 0;
								/* TODO: use the identify data */
is_comp:
								convert_ata_string(id->model_number, 20);
								convert_ata_string(id->additional_product_identifier, 4);
								convert_ata_string(id->current_media_manufacturer, 10);
								convert_ata_string(id->current_media_serial_number, 20);
								convert_ata_string(id->firmware_rev, 4);
								convert_ata_string(id->serial_number, 10);
								/* get the size */
								if (!id->lba_supp) {
										max_sec = -1; /* CHS? ATAncient */
								} else if (id->has_lba48 || id->has_lba48_alt)
										max_sec = id->num_logical_sectors;
								else
										max_sec = id->max_lba28;
								/* sector size */
								if (id->has_multiple_logical_per_physical_sectors) {
										lpp = 1 << id->num_pwr2_logical_per_phys;
								}
								if (id->logical_sector_longer_than_512bt) {
										lls = 2 * id->logical_sector_size;
										lof = id->logical_sector_offset;
								}
								/* print a bit */
								printf("IDENTIFY on port %u: %.40s %.8s %.20s %.8s\nMedia: %.20s %.40s\n",
												pt, (char*)id->model_number, (char*)id->additional_product_identifier,
												(char*)id->serial_number, (char*)id->firmware_rev,
												(char*)id->current_media_manufacturer, (char*)id->current_media_serial_number);
								printf("(S)ATA v%u.%u disk with properties: %s %s max sector: %llx\n",
										id->ata_version_major, id->ata_version_minor,
										(id->lba_supp ? (id->has_lba48 ? "LBA48" : "LBA28") : "CHS"),
										capstr(id->form_factor, 6, "", "5.25\"", "3.5\"", "2.5\"", "1.8\"", "<1.8\"", ""),
										max_sec);
								printf("Logical sectors: size: %u offset: %u num_per_phys: %u\n", lls, lof, lpp);
								/* LBA48 -> max_sec*lls (lls is 16bt no 64bt overflow) */
								printf("Capacity: %llu bytes, %lluK, %lluM, %lluG, %lluT\n",
										lls * max_sec, max_sec * lls / 1024, max_sec * lls / 1024 / 1024,
										max_sec * lls / 1024 / 1024 / 1024, max_sec * lls / 1024 / 1024 / 1024 / 1024);
								if (!id->is_not_ata) {
										extern int register_ata_device(struct ahci_device* ad, struct ahci_port* p,
														uint16_t pmprt, struct ata_identify* id);
										if (register_ata_device(ad, p, 0, id))
												printf("Registered device in file system.\n");
										else
												printf("Failed to register device.\n");
								}
						} else if (su) {
								/* we would have to spin-up to read everything */
								die("spin-up by SET FEATURES not supported yet!\n");
						} else /* assume the best */
								goto is_comp;				
						break;
				}
				case host_cmd_reset: { /* TODO: should we burden the worker with this? -> up to 500ms no new commands on other ports. */
						int timeout = 50; /* up to 500 ms */
						/* ST already cleared follow procedure in 6.2.2.1-3 */
						/* 0. clear ST again */
						p->cmd.st = 0;
						/* 1. wait for CR to clear */
						while (p->cmd.cr && timeout--)
								mdelay(10);
						/* check CR and do full reset if needed */
						if (p->cmd.cr) {
								/* even more time consuming
								 * -> both function will be merged */
full_reset:
								abprintf("performing full port reset on port %zd\n",
										p - ad->ptr->port);
								ahci_reset_port(ad->ptr, p);
						} else {
								/* TODO: prevent clearing of unhandled errors? */
								p->pXserr = 0xffffffff;
								p->pXis = 0xffffffff; /* likewise */
								if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
										goto full_reset;
								/* and reenable the port */
								p->cmd.st = 1;
								abprintf("reenabled command processing on port %zd (after %d ms)\n",
										p - ad->ptr->port, 10 * (50 - timeout));
								/* for NCQ we need to issue READ LOG EXT to find
								 * the culprit (as no reset was needed) */
								;
						}
						break;
				}
				default:
						die("someone messed up! command=%x\n", cc->c);
		}

		/* free the resources */
		ahci_release_cmdtbl(ad, cc->entry);
		ahci_destroy_context(ad, cc);
}

void ahci_process_command(struct ahci_device* ad,
				struct ahci_port* p, struct list_head* lh)
{
		struct cmd_ctx* cc; int slt, rv, pt = p - ad->ptr->port; uint32_t ct;
		struct ahci_cmdlst* cl = ad->command_lists[pt];

		/* sending a command to a device with CR=0? */
		if (!cl)
				abprintf("Ignoring command on port %d as it's command"
						" engine is not running.\n", pt);

next_cmd:
		slt = ahci_find_slot(p, ad->num_cmd); /* does not reserve -> no cleanup */
		if (slt == -1) /* still full */
				return;

		/* we've acquired a slot -> check for ST */
		if (!p->cmd.st) {
				/* wait for a reset host command */
				abprintf("waiting for reset host command on port %d\n", pt);
				cc = list_cut_first_entry_where(lh, struct cmd_ctx, lst,
						var, var->c == host_cmd_reset);
		} else { /* process regular commands in order */
				abprintf("processing command in slot %d on port %d\n", slt, pt);
				cc = list_cut_first_entry(lh, struct cmd_ctx, lst);
		}
		if (!cc) { /* the command vanished?/or isn't posted yet */
				abprintf("command vanished\n");
				return;
		}

		/* process host commands */
		if (cc->c == host_cmd_resend) {
				/* slot is valid, entry likewise */
				/* clear rv (command built successfully)
				 * and do the regular issue cycle */
				rv = 0;
				goto issue;
		} else if (cc->c >= host_cmd_process_identify) {
				ahci_process_host_command(ad, p, cc);
				/* next one */
				goto incr;
		}

		/* get the PRDT count needed */
		if (cc->ptr) {
				/*void* ptr2; */uint64_t s = cc->ct;
				/* we'll build a scatter list and then get a
				 * count and throw the results away? insane! */
				ct = rdiv(s, 4096) + 1; /* first guess */
				if (ct > 8) {
						/* now we do this */
						die("implement this later.\n");
				}
		} else if (cc->c == disk_cmd_identify) {
				ct = 1;
		} else
				ct = 0;

		/* now acquire a command table with the matching requirements */
		/* limit is 4MiB per PRDT (BUT! PM!=contiguous) */
find:
		if (!cc->entry) /* else: max_prdtl still valid */
				cc->entry = ahci_find_cmdtbl(ad, ct);
		if (cc->entry) {
				cc->entry->port = cc->port;
				cc->entry->slot = slt;
				cc->slot = slt;
		} else
				abprintf("no cmdtbl with %u PRDTs capacity found.\n", ct);

		if (!cc->entry && ct > 8) { /* divide by twoish */
				int log = bsr(ct) - 1;
				uint32_t new_ct = (1 << log);
				if (new_ct == ct)
						new_ct >>= 1;
				ct = new_ct;
				goto find;
		} else if (!cc->entry) { /* none available */
				/* skip command processing on this port */
				abprintf("waiting for cmdtbl to become available.\n");
				list_add(&cc->lst, lh);
				return;
		}

		abprintf("building command in cmdtbl at %p for port %u slot %u\n",
				cc->entry->ptr, cc->entry->port, cc->entry->slot);
		/* now build the command */
		cc->max_prdtl = max(ct, 8); /* min 8 supp */
		if (p->cmd.atapi) { /* ATAPI */
				switch (cc->c) {
						case disk_cmd_identify:
								rv = atapi_build_packet_device_identify(ad, cc);
								break;
						case disk_cmd_read:
						case disk_cmd_write:
						case disk_cmd_trim:
								die("not implemented yet!\n");
								break;
						default:
								die("The command %x should not end up here.\n", cc->c);
								break;
				}
		} else {
				switch (cc->c) { /* ATA */
						case disk_cmd_identify:
								rv = ata_build_device_identify(ad, cc);
								break;
						case disk_cmd_read:
								rv = ata_build_read_dma_ext(ad, cc);
								break;
						case disk_cmd_write:
						case disk_cmd_trim:
								die("not implemented yet!\n");
								break;
						default:
								die("The command %x should not end up here.\n", cc->c);
								break;
				}
		}

		/* only issue if rv==0 */
issue:
		if (rv) { /* cleanup */
				abprintf("ignored malformed command on port %u\n", cc->port);
				if (cc->status)
						cc->status->state = cmd_state_abort;
				ahci_release_cmdtbl(ad, cc->entry);
				ahci_destroy_context(ad, cc);
		} else if (!(p->pXci & (1 << slt))) {/* issue it on the port p slot slt */
				struct ahci_cmdhdr* ch = &ad->command_lists[cc->port]->chdrs[slt];
				bzero(ch, sizeof(*ch));
				ch->ctba64 = cc->entry->pmem;
				ch->prdtl = cc->clh.prdtl;
				ch->flags = cc->clh.flg;
				/* now enable the slot (don't use |=) 
				 * but first check if ST still set */
				if (p->cmd.st) {
						p->pXci = (1 << slt);
						if (cc->status)
								cc->status->state = cmd_state_issued;
				}
				/* also protects against clearing in-between */
				if (!p->cmd.st) {
						abprintf("command will be sent later\n");
						cc->c = host_cmd_resend;
						ahci_reissue_command(ad, cc);
						goto incr; /* skip putting into proc_cmds */
				}

		//		/* print the STATUS */
		//		cprintf(KFMT_WARN, "STATUS: diag=%x err=%x cmd=%x clb=%x\n",
		//						p->scr1.diag, p->scr1.err, p->pXcmd, p->pXclb);

				/* and tell the IH about it */
				list_add_tail(&cc->lst, &ad->proc_cmds[cc->port]);
				abprintf("issued the command successfully.\n");
		} else {
				/* slot became used: parallel access to
				 * inherently single threaded structure? */
				die("error posting command\n");
		}

		/* process next command */
incr:
		__sync_fetch_and_sub(&ad->pending_ct, 1);
		if (!list_empty(lh))
				goto next_cmd;
}

void ahci_worker(void* dat)
{
		struct ahci_device* ad = dat;

		printf("AHCI worker is running\n");
		while (1) {
				uint32_t ps = ad->ptr->ports;
				printf("IS: %x ae: %u ie: %u\n", ad->ptr->intr,
						ad->ptr->ctrl.ae, ad->ptr->ctrl.ie);
				for (int i = 0; i < 32; i++)
						if (ps & (1 << i)) {
//								printf("P%d det: %u ipm: %u serr: %x\n", i,	ad->ptr->port[i].scr0.det,
//										ad->ptr->port[i].scr0.ipm, ad->ptr[i].port[i].pXserr);
								printf("P%d st: %u cr: %u is: %x ie: %x sts: %x err: %x ci: %x sa: %x\n",
										i, ad->ptr->port[i].cmd.st, ad->ptr->port[i].cmd.cr,
										ad->ptr->port[i].pXis, ad->ptr->port[i].pXie,
										ad->ptr->port[i].tfd.sts, ad->ptr->port[i].tfd.err,
										ad->ptr->port[i].pXci, ad->ptr->port[i].pXsact);
//								/* print the cmdlst */
//								printf("CL: %016llx %016llx %p\n", ad->ptr->port[i].pXclb64,
//										mmgr_page_get_pmem(ad->command_lists[i], NULL), ad->command_lists[i]);
//								/* print CH0 */
//								printf("CH0: %016llx flg: %x prdtl: %u bc: %u\n", ad->command_lists[i]->chdrs[0].ctba64,
//										ad->command_lists[i]->chdrs[0].flags, ad->command_lists[i]->chdrs[0].prdtl,
//										ad->command_lists[i]->chdrs[0].prdbc);
//								/* Identify data */
//								uint32_t* pti = ad->identify_data[i].ptr;
//								printf("ID: %08x %08x %08x %08x\n", pti[5 + 0], pti[5 + 1],
//										pti[5 + 2], pti[5 + 3]);
//
						}
				/* print global IS */
				void ioapic_print_is();
				int pci_print_is(union pca);
				ioapic_print_is();
				pci_print_is(ad->dev->addr);

				/* poll for FIS transfer */
//				if (ad->ptr->intr & 1) {
//						for (int i = 0; i < 32; i++) {
//								if (!(ps & (1 << i)))
//										continue;
//								if (ad->ptr->port[i].is.dhrs) {
//										/* check D2H FIS */
//										struct sata_reg_d2h* rd = (void*)ad->recv_fis[i]->rfis;
//										printf("received D2H FIS on port %d: stat=%x err=%x count=%u\n",
//												i, rd->status, rd->error, rd->count);
//										/* R1C (dont use |=)*/
//										ad->ptr->port[i].pXis = 1;
//								}
//						}
//						/* R1C */
//						ad->ptr->intr = 1;
//				}

				wait_on_event(&ad->wh);
				//sleep(1);

				/* there are pending commands */
				if (ad->pending_ct) {
						for (int i = 0; i < 32; i++) {
								if (!(ps & (1 << i)))
										continue;
								if (list_empty(&ad->pending_cmds[i]))
										continue;
								/* we have commands to process */
								ahci_process_command(ad, &ad->ptr->port[i],
										&ad->pending_cmds[i]);
						}
				}
		}
}

void* ahci_allocate_command_table_pool(uint32_t ct, uint32_t prdt_cap, int bit64)
{
		/* 128bt aligned size (8 PRDT/128 bt) */
		struct ahci_ct_pool* rv; uint32_t i = 0;
		size_t byte_ct, page_rest, indiv_ct, pg_pe, pg_ct, epa;
		struct page_range pr; int flg = MMGR_ALLOC_CONTIGUOUS;
		if (!bit64)
				flg = MMGR_ALLOC_32BIT;
		if (!(rv = kzalloc(sizeof(*rv))))
				return NULL;
	   
		/* bitmask limit */
		if (ct > 32)
				ct = 32;
		/* enforce alignment */
		if (prdt_cap % 8)
				prdt_cap += 8 - prdt_cap % 8;
		indiv_ct = 128 + 16 * prdt_cap;
		byte_ct = ct * indiv_ct;
		pg_pe = rdiv(indiv_ct, 4096);
		page_rest = pg_pe * 4096 - indiv_ct;

		/* pg_pe allocs must be contiguous, but if page_rest is low
		 * individual tables can be split up to different locations */
		if (!page_rest || (page_rest % indiv_ct == 0)) {
				epa = pg_pe * 4096 / indiv_ct; /* entries per allocation */
				pg_ct = rdiv(ct, epa) * pg_pe;
		} else {
				pg_ct = rdiv(byte_ct, 4096);
				epa = ct;
				pg_pe = pg_ct;
		}

		/* allocate the physical memory */
		while (pg_ct) {
				void* ptr; size_t epa2 = epa, rem;
				mm_alloc_pm_flg(pg_pe, &pr, 1, flg);
				if (pr.count != pg_pe)
						die("Out of contiguous memory\n");
				rem = pg_pe * 4096;
				/* pg_pe zeroed contiguous memory at pr.base */
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL |
						MMGR_MAP_WRITE | MMGR_MAP_NO_CACHING);
				if (!ptr)
						die("mmap not working\n");

				/* assign the entries */
				while (epa2--) {
						rv->tables[i].pmem = pr.base;
						rv->tables[i++].ptr = ptr;
						/* advance */
						pr.base += indiv_ct;
						ptr += indiv_ct;
						rem -= indiv_ct;
						if (rem < indiv_ct && epa2 > 1)
								die("algo error\n");
				}
				pg_ct -= pg_pe;
		}

		/* assign the other values */
		rv->prdt_cap = prdt_cap;
		rv->next = NULL;
		rv->mask = 0xffffffff << prdt_cap;

		/* print it */
		for (i = 0; i < ct; i++)
				printf("%016llx %p\n", rv->tables[i].pmem, rv->tables[i].ptr);

		return rv;
}

void ahci_reissue_command(struct ahci_device* ad, struct cmd_ctx* cc)
{
		iprintf("  REISSUE: %d %u\n", cc->port, cc->c);
		if (cc->status)
				cc->status->state = cmd_state_pending;
		iprintf("lh: %p %p %u\n", ad->pending_cmds[cc->port].prev,
						ad->pending_cmds[cc->port].next, cc->port);
		list_add_tail(&cc->lst, &ad->pending_cmds[cc->port]);
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
				/* wake worker */
				wake_up_external_event(&ad->wh);
		}
}

void ahci_issue_command(struct ahci_device* ad, int port, int pmprt, enum port_cmd cmd,
				uint64_t lba, uint64_t ct, void* ptr, struct wait_queue_head* wq_h, struct cmd_status* st)
{
		iprintf("  ISSUE: %d %u\n", port, cmd);
		struct cmd_ctx* cc = ahci_allocate_context(ad);
		cc->c = cmd;
		cc->lba = lba;
		cc->ct = ct;
		cc->ptr = ptr;
		cc->wq_wake = wq_h;
		cc->pmprt = pmprt;
		cc->port = port;
		cc->status = st;
		if (st) {
				bzero(st, sizeof(*st));
				st->state = cmd_state_pending;
		}
		list_add_tail(&cc->lst, &ad->pending_cmds[port]);
		if (!__sync_fetch_and_add(&ad->pending_ct, 1)) {
				/*  wake worker */
				wake_up_external_event(&ad->wh);
		}
}

int ahci_do_bohc(struct ahci_device* ad)
{
		struct ahci_hba* hba = ad->ptr;
		if (hba->cap2.boh) {
				abprintf("performing AHCI BIOS handover...\n");
				preempt_disable();
				hba->bohc |= BOHC_OOS;
				/* SMI is issued */
				if (hba->bohc & BOHC_BOS) { /* we have to wait */
						mdelay(25);
						if (hba->bohc & BOHC_BB) { /* BIOS does it */
								int to = 30;
								while (hba->bohc & BOHC_BOS) {
										mdelay(100);
										if (!to--) /* abort after 3 seconds */
												break;
								}
						} else {;} /* we have to clean up */
				}
				/* we're done */
				preempt_enable();
		}
		/* always acquire (we're only nice to inform the bios) */
		return 0;
}

void ahci_reset_port(struct ahci_hba* h, struct ahci_port* p)
{
		/* cap.sclo? */
		die("not impl %p %p\n", h, p);
}

void ahci_port_activate_device(struct ahci_hba* h, struct ahci_port* p)
{
		abprintf("activate port %zd:\n", p - h->port);
		/* first check the presence flag */
		if (p->scr0.det == DET_NOT_PRESENT) {
				abprintf("activate: DET_NOT_PRESENT\n");
				/* nothing attached? */
				if (p->cmd.cpd) { /* we rely on CPD */
						if (!p->cmd.cps) {
								abprintf("confirmed by CPD\n");
								return;
						}
						/* there's something */
						if (!p->cmd.pod) {
								p->cmd.pod = 1; /* power it */
								ndelay(20);
						}
						if (p->scr0.det != DET_NOT_PRESENT)
								goto next_step;
				}
				/* spin-up? */
				if (!p->cmd.sud) { /* always !1 if cap.sss == 0 */
						abprintf("not spun-up yet?\n");
						if (p->pXserr & (1 << 26)) /* eXchange bit */
								p->pXserr |= (1 << 26); /* RWC */
						if (p->scr2.det != 0) { /* set to 0 prior sud */
								p->scr2.det = 0;
								ndelay(20);
						}
						p->cmd.sud = 1;
						udelay(50); /* wait 50 mus */
						if (p->pXserr & ((1 << 26) | (1 << 18))) { /* received sth. */
								/* COMRESET, COMWAKE */
								goto next_step;
						}
						/* send the reset */
						p->scr2.det = 1;
						mdelay(1);
						p->scr2.det = 0;
						udelay(50);
						if (p->scr0.det != DET_NOT_PRESENT)
								goto next_step;
						p->cmd.sud = 0; /* we're done enter listening mode */
						abprintf("not present\n");
						goto exit;
				}
				/* just try ICC */
				if (p->scr0.ipm != 1) {
						abprintf("IPM != ACTIVE\n");
						int ct = 50;
						while (p->cmd.icc && ct--)
								udelay(10);
						p->cmd.icc = 1;
						mdelay(10);
						if (p->scr0.det != DET_NOT_PRESENT)
								goto next_step;
						abprintf("unable to set to active\n");
						goto exit;
				}
		}

		/* det != 1*/
next_step:
		if (p->scr0.det == DET_PRESENT) {
				/* almost done */
				if (p->scr0.ipm != IPM_ACTIVE) {
						int ct, wc;
						abprintf("Present but not active.\n");
activ:
						ct = 50, wc = 0;
rewait:
						while (p->cmd.icc && ct--) /* 500ms */
								mdelay(10);
						if (p->scr0.ipm != IPM_ACTIVE && !wc) {
								p->cmd.icc = 1;
								ndelay(50);
								wc++; ct = 50;
								goto rewait;
						}
						if (wc) {
								/* reset */
								p->scr2.det = 1;
								mdelay(1);
								goto next_step;
						}
				}
				abprintf("Device at port %zd is active and present.\n",
						p - h->port);
				abprintf("details: %x %x %x %u %u\n", p->pXserr, p->tfd.sts,
						p->tfd.err, p->scr0.det, p->scr0.ipm);
				return;
		} else if (p->scr0.det == DET_PHY_OFFLINE) {
				/* just deactivated */
				abprintf("PHY offline mode\n");
				goto activ;
		} else if (p->scr0.det == DET_PRESENT_NO_PHY) {
				abprintf("PRESENT_NO_PHY mode\n");
				goto activ; /* try the same */
		}
exit:
				/* we're really done */
				abprintf("Not present at port %zd\n", p - h->port);
				return;
}

void ahci_enable_port(struct ahci_device* ad, int pt)
{
		struct ahci_port* p = &ad->ptr->port[pt];
		int reset_ct = 0;

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
				return;

Pos1:
		/* clear old data */
		p->pXserr = 0xffffffff; /* 10.1.2 -> 6. */
		p->pXis = 0xffffffff; /* clear all pending interrupts */

		/* first allow for the reception of FISes */
		p->cmd.fre = 1;
		ndelay(20); /* wait for BSY to show up */
		while (1) {
				uint8_t sts = p->tfd.sts;
				if (sts & TFS_ERR) {
						/* something went wrong! */
						if (sts == 0x7f) /* no device */
								break;
						else if (sts == 0x41 && p->tfd.err == 0x20) {
								if (p->pXsig == SIG_ATAPI)
										break; /* no medium */
						}
						cprintf(KFMT_WARN, "port%d indicated task file error %x"
								" while starting up.\n", pt, p->tfd.err);
						abprintf("scr1: %x %x\n", p->scr1.diag, p->scr1.err);
						abprintf("tfd: %x %x\n", p->tfd.sts, p->tfd.err);
						p->pXserr = 0xffffffff;
						if (!reset_ct++) {
								ahci_port_activate_device(ad->ptr, p);
								goto Pos1;
						} else if (reset_ct == 1) {
								/*ahci_reset_port(ad->ptr, p);*/
								goto Pos1;
						} else
								goto defer;
				}
				if (!(sts & (TFS_BSY | TFS_DRQ)))
						break;
				udelay(50);
		}

		/* set ST only if BSY,DRQ and DET=3h or IPM=2,6,8 */
		if (p->scr0.det != 3)
				ahci_port_activate_device(ad->ptr, p);
		if (p->tfd.sts & (TFS_BSY | TFS_DRQ))
				goto defer; /* listen */
		if (!((p->scr0.det == 3) || (p->scr0.ipm == 2) ||
				(p->scr0.ipm == 6) || (p->scr0.ipm == 8)))
				goto defer;
		/* we're allowed so set it */
		p->cmd.st = 1;
		/* Change in PhyRdy, CPS, TFS.err, PCS, DPS(I=1), UFS, HBFS, HBDS, IFS, D2HFIS */
		p->pXie = (1 << 22) | (1 << 6) | (1 << 31) | (1 << 30) | (1 << 0)
				| (1 << 5) | (1 << 4) | (1 << 29) | (1 << 28) | (1 << 27);

		/* issue the IDENTIFY_(PACKET)_DEVICE command */
		ahci_issue_command(ad, pt, 0, disk_cmd_identify, 0, 0, NULL, NULL /* wq_worker_ad*/, NULL);

		printf("port %d is now processing commands\n", pt);
		return;

defer: /* we're interested in status changes only */
		abprintf("port %d set to listening mode\n", pt);
		p->pXie = (1 << 22) | (1 << 31) | (1 << 6); /* PhyRdy change, CPS, CCS */
}

void ahci_stop_port(struct ahci_device* ad, int pt)
{
		struct ahci_port* p = &ad->ptr->port[pt];
		int ct;

		/* skip non-implemented ports */
		if (!(ad->ptr->ports & (1 << pt)))
				return;

		/* print the BIOS provided status */
		abprintf("BIOS initial state of port %d:\n", pt);
		abprintf("\t%s%s\n", p->cmd.fre ? "FRE " : "",
				p->cmd.st ? "ST" : "");
		/* print the pointers */
		abprintf("BIOS command list located at %016llx\n", p->pXclb64);
		abprintf("BIOS FIS received buffer at  %016llx\n", p->pXfb64);

		/* check if already off */
		if (!p->cmd.fre && !p->cmd.st)
				return;

		/* Now turn it off (2x500ms max else reset) */
		ct = 50;
		p->cmd.st = 0;
		while (p->cmd.cr && ct--)
				mdelay(10);
		if (ct == -1)
				goto reset;
		ct = 50;
		p->cmd.fre = 0;
		while (p->cmd.fr && ct--)
				mdelay(10);
reset:
		if (ct == -1) {
				printf("Port %d: reset needed!\n", pt);
				/* TODO implement this */
				//ahci_reset_port(ad, pt);
				while (1);
		}
		/* The port is now off innit? */
}

/* we have ad->num_ports active ports needing num_cmd
 * command slots and one FIS receive buffer each.
 * The command lists are held in a shared pool. */
void ahci_assign_buffers(struct ahci_device* ad)
{
		size_t bt_ct, pg_ct; int flg = MMGR_ALLOC_COMPLETE;
		struct page_range pr; int cc, fc, ic;
		/* Total size: 256*np+1024*np+512*np */
		bt_ct = ad->num_ports * (sizeof(struct ahci_fis)
				+ sizeof(struct ahci_cmdlst) + 512);
		pg_ct = rdiv(bt_ct, 4096);

		/* allocate and map the physical memory */
		ic = cc = fc = ad->num_ports;
		if (!ad->ptr->cap.is_64bit)
				flg = MMGR_ALLOC_32BIT;
		while (pg_ct) {
				void* ptr; size_t nb;
				/* we don't need contiguous memory */
				pg_ct -= mm_alloc_pm_flg(pg_ct, &pr, 1, flg);
				if (!pr.count)
						goto quit;
				nb = 4096 * pr.count;
				ptr = mm_map(&mm_kernel, NULL, &pr, 1, /*MMGR_MAP_MMIO | <- 0xe nope */
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!ptr)
						goto quit;

				/* now first process the command lists with 1K-alignment */
				while (cc && nb >= 1024) {
						int pt = ad->num_ports - cc--;
						if (ad->ptr->ports & (1 << pt)) {
								/* assign for implemented port */
								ad->ptr->port[pt].pXclb64 = pr.base;
								ad->command_lists[pt] = ptr;
								/* advance */
								pr.base += 1024;
								nb -= 1024;
								ptr += 1024;
						}
				}

				/* then the FIS buffers (256bt-aligned) */
				while (fc && nb >= 256) {
						int pt = ad->num_ports - fc--;
						if (ad->ptr->ports & (1 << pt)) {
								/* as above */
								ad->ptr->port[pt].pXfb64 = pr.base;
								ad->recv_fis[pt] = ptr;
								/* advance */
								pr.base += 256;
								nb -= 256;
								ptr += 256;
						}
				}

				while (ic && nb >= 512) {
						int pt = ad->num_ports - ic--;
						if (ad->ptr->ports & (1 << pt)) {
								/* as above */
								ad->identify_data[pt].pm = pr.base;
								ad->identify_data[pt].ptr = ptr;
								/* advance */
								pr.base += 512;
								nb -= 512;
								ptr += 512;
						} else
								ad->identify_data[pt].sig = 0;
				}

				/* exit early if we have non-impelented ports */
				if (!fc && !cc && !ic) {
						/* also deallocate if possible */
						if (nb >= 4096) {
								ptr += (size_t)ptr % 4096;
								mm_free_vmem(&mm_kernel, ptr, nb / 4096);
						}
						break;
				}
		}
		/* Now all implemented buffers are set */
		return;

quit:
		die("Out of memory!\n");
}

/* also disables interrupts */
void ahci_clear_interrupts(struct ahci_device* ad)
{
		struct ahci_hba* h = ad->ptr;

		/* disable interrupts */
		h->ctrl.ie = 0;

		/* clear them in every port implemented */
		for (int i = 0; i < ad->num_ports; i++) {
				struct ahci_port* p;
				if ((h->ports & (1 << i)) == 0)
						continue;
				p = &h->port[i];
				/* disable and clear all */
				p->pXie = 0;
				p->pXis = 0xffffffff;
		}

		/* clear the global status */
		h->intr = 0xffffffff; /* W1C */
}

int ahci_device_init(struct pci_device* d)
{
		int rv;

		/* Check progIf */
		if (d->device_interface != 1) {
				cprintf(KFMT_WARN, "Unsupported SATA program interface: %u\n",
						d->device_interface);
				return -ENOSYS;
		}

		/* Setup and map BAR5 if neccessary */
		if (d->ressources[5].type == PCI_BAR_PIO)
				return -ENOTSUP; /* AHCI requires MMIO at BAR5 */
		if (!d->ressources[5].mmio.base) {
				int atl = 0; uint64_t m;
				/* we first need pmem for the device */
				if (!d->ressources[5].mmio.size) {
						/* Ask PCI */
						d->ressources[5].mmio.size = pci_bar_get_size(d, 5);
						if (!d->ressources[5].mmio.size) {
								d->ressources[5].mmio.size = 0x1100; /* 32 ports */
								atl = 1; /* about to leave */
						}
				}
				/* Now we want to get some address */
				m = mmio_allocate_range(d->ressources[5].mmio.size,
						0x3 & (d->ressources[5].type >> 1));
				if (!m)
						return -ENOMEM;
				/* and assign it */
				pci_set_bar(d, 5, d->ressources[5].type, m);
				if (d->ressources[5].mmio.base != m) {
						/* we can't */
						mmio_free_range(m, d->ressources[5].mmio.size);
						if (atl)
								d->ressources[5].mmio.size = 0;
						return -ENOTSUP;
				}
		}

		/* Now we possibly have to map the memory */
		if (!d->ressources[5].mmio.mapping) {
				void* mem; struct page_range pr;
				pr.base = d->ressources[5].mmio.base;
				pr.count = rdiv(d->ressources[5].mmio.size, 4096);
			   	mem = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_MMIO |
						MMGR_MAP_WRITE | MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!mem)
						return -ENOMEM;
				d->ressources[5].mmio.mapping = mem;
		}

		/* we now have a working mapping */
		struct ahci_hba* h = d->ressources[5].mmio.mapping;
		struct ahci_device* ad = kzalloc(sizeof(*ad));
		if (!ad)
				return -ENOMEM;

		/* check for AE (access to other registers is disallowed before) */
		if (!(h->control & GHC_CNT_AE)) {
				abprintf("switching to AHCI mode\n");
				h->control |= GHC_CNT_AE;
		}

		/* fill the descriptors */
		ad->ptr = h; /* D2H is set but masked */
		ad->dev = d;
		ad->num_ports = min(h->cap.num_ports + 1, bsr(h->ports));
		ad->num_cmd = h->cap.num_cmd + 1;
		for (int i = 0; i < 32; i++) {
				ad->pending_cmds[i] = LIST_HEAD_INIT(ad->pending_cmds[i]);
				ad->proc_cmds[i] = LIST_HEAD_INIT(ad->proc_cmds[i]);
		}
		ad->ctxs = LIST_HEAD_INIT(ad->ctxs);
		ad->wh = WAIT_QUEUE_HEAD(ad->wh);

#ifdef AHCIBABBLE /* Tell the world about it */
		printf("AHCI %.0x%x.%x%x conforming HBA detected\n",
				h->ahci_ver >> 24, 0xff & (h->ahci_ver >> 16),
				0xff & (h->ahci_ver >> 8), h->ahci_ver & 0xff);
		/* and print the capablilities */
		printf("Features: %s%s%sspeed: %s\n",
				capstr(h->cap.ncq_supp, 1, "", "NCQ  "),
				capstr(h->cap.ahci_only, 1, "Legacy support  ", "AHCI only  "),
				capstr(h->cap.is_64bit, 1, "32-bit  ", "64-bit  "),
				capstr(h->cap.if_speed, 4, "res", "1.5 Gbps", "3 Gbps", "6Gbps", ">6Gbps"));
		printf("AHCI HBA has %u ports and %u command slots\n",
				ad->num_ports, ad->num_cmd);
#endif

		/* transfer ownership (incl NMI) */
		if (h->cap2.boh) {
				rv = ahci_do_bohc(ad);
				if (rv) {
						kfree(ad);
						return rv;
				}
		}

		/* disable every possible interrupt */
		if(pci_disable_interrupts(d))
				die("not possible!\n");

		/* Stop the running ports */
		for (int i = 0; i < ad->num_ports; i++)
				ahci_stop_port(ad, i);

		/* clear all interrupts and install the handler */
		ahci_clear_interrupts(ad); /* PCI disabled MSI and we're currently */
		install_irq_handler(ad->dev->intr_line, ahci_irq); /* not using it */
		/* TODO: do proper assigment */

		/* assign the command lists and the FIS buffers */
		ahci_assign_buffers(ad);

		/* print them */
		for (int i = 0; i < ad->num_ports; i++) {
				printf("port%d: %016llx %016llx %p %p\n", i,
						ad->ptr->port[i].pXclb64,
						ad->ptr->port[i].pXfb64,
						ad->command_lists[i],
						ad->recv_fis[i]);
				printf("       %016llx %p\n", ad->identify_data[i].pm,
						ad->identify_data[i].ptr);
		}

		/* allow the device to write to our memory */
		pci_set_master(d);

		/* reenable the ports */
		for (int i = 0; i < ad->num_ports; i++)
				ahci_enable_port(ad, i);

		/* add the device to the list */
		struct ale* le = kzalloc(sizeof(*le));
		le->dev = ad;
		list_add_tail(&le->devs, &ahci_dl.devs);

		/* allocate the pool */
		ad->ctbl_pool = ahci_allocate_command_table_pool(
				32, 8, h->cap.is_64bit);

		/* launch the worker */
		task_spawn(ahci_worker, ad, PRIORITY_ELEVATED);

		/* reenable interrupts */
		/* The port_enable function already set the per-port values */
		h->ctrl.ie = 1;
		pci_enable_interrupts(d);

		return 0;
}

int MODENTRY module_init()
{
		printf("AHCI initialization...\n");
		struct pci_device* dev; int ct = 0, nc = 0, nf = 0;
		while ((dev = pci_find_device(1, 6, 1, ct++))) {
				int rv;
				printf("Found AHCI device at %02x:%02x.%x\n", dev->addr.bus_no,
						dev->addr.device_no, dev->addr.func_no);
				printf("Attempting initialization...\n");
				rv = ahci_device_init(dev);
				if (rv) {
						cprintf(KFMT_ERROR, "Initialization of this device failed.\n");
						nf++;
				} else {
						cprintf(KFMT_OK, "Initialization of AHCI HBA succeeded.\n");
						nc++;
				}
		}
		/* Summary */
		cprintf(nf ? KFMT_WARN : KFMT_OK, "Initialized %d AHCI Host Bus Adapters. (%d failed)\n", nc, nf);
		return 0;
}

void MODENTRY module_cleanup()
{
}

