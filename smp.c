/* smp.c : Provides the implementation for symmetric multiprocessing.
 * */

#include "kernel.h"
#include "kdata.h"

/* all pointers are 32-bit as this standard is from 1994. */
typedef uint32_t mp_ptr;
#define mp2ptr(p) ((void*)p)

struct mp_fps {
		char sig[4];
		mp_ptr mp_config;
		uint8_t length;
		uint8_t spec_rev;
		uint8_t checksum;
		uint8_t features[5];
};

struct mp_pcmp {
		char sig[4];
		uint16_t length;
		uint8_t spec_rev;
		uint8_t checksum;
		char oem_id[8];
		char product_id[12];
		mp_ptr oem_table;
		uint16_t oem_table_size;
		uint16_t entry_count;
		mp_ptr lapic_addr;
		uint16_t ext_table_length;
		uint8_t ext_table_checksum;
		uint8_t res;
};

struct mp_proc {
		uint8_t type;
		uint8_t lapic_id;
		uint8_t lapic_ver;
		uint8_t cpu_flags;
		uint32_t cpu_signature;
		uint32_t cpu_features;
		uint32_t res1;
		uint32_t res2;
};

struct mp_bus {
		uint8_t type;
		uint8_t bus_id;
		char bus_type[6];
};

struct mp_ioapic {
		uint8_t type;
		uint8_t id;
		uint8_t ver;
		uint8_t flags;
		mp_ptr addr;
};

struct mp_iointr {
		uint8_t type;
		uint8_t intr_type;
		uint16_t intr_flags;
		uint8_t src_bus_id;
		uint8_t src_bus_irq;
		uint8_t dest_apic_id;
		uint8_t dest_apic_inp;

};

struct mp_locintr {
		uint8_t type;
		uint8_t intr_type;
		uint16_t intr_flags;
		uint8_t src_bus_id;
		uint8_t src_bus_irq;
		uint8_t dest_lapic_id;
		uint8_t dest_lapic_linp;
};

#ifndef __clang__
STATIC_ASSERT(sizeof(struct mp_fps)==16, mp_fps_not_16_bytes);
STATIC_ASSERT(sizeof(struct mp_pcmp)==44, mp_pcmp_not_32_bytes);
STATIC_ASSERT(sizeof(struct mp_proc)==20, mp_proc_not_20_bytes);
STATIC_ASSERT(sizeof(struct mp_bus)==8, mp_bus_not_8_bytes);
STATIC_ASSERT(sizeof(struct mp_ioapic)==8, mp_ioapic_not_8_bytes);
STATIC_ASSERT(sizeof(struct mp_iointr)==8, mp_iointr_not_8_bytes);
STATIC_ASSERT(sizeof(struct mp_locintr)==8, mp_locintr_not_8_bytes);
#endif

/* shared init data (x2APIC compatible, but needs APCI) */
uint32_t nproc = 1;
struct {
		uint32_t bp_id;
		struct apid {
				uint32_t ap_id;
				struct apid* next;
		} * ap_ids;
} apic_ids = {0};
struct busid {
		uint8_t id;
		uint8_t type;
		struct busid* next;
} * bus_ids = NULL;
struct io_apic {
		uint8_t id;
		void* addr;
		struct io_apic* next;
} * io_apics = NULL;
#define BT_ISA 0
#define BT_EISA 1
#define BT_PCI 2
#define BT_UNKNOWN 0xff

/* find the MP FPS with signature _MP_ */
void* search_mp_fps(void* mem, size_t ct)
{
		while (ct >= 16) {
				if (*(uint32_t*)mem == 0x5f504d5f) {
						struct mp_fps* fps = mem;
						/* perform the checksum */
						if (checksum_memory(mem, 16 * fps->length) == 0)
								return mem;
				}
				mem += 16;
				ct -= 16;
		}
		return NULL;
}

/* check three memory ranges for the MP FPS */
void* find_mp_fps()
{
		void* rv;

		/* first KiB of BIOS EBDA */
		rv = (void*)((size_t)*(uint16_t*)0x040e << 16);
		if ((size_t)rv < 0x000a0000 && (0x000a0000 - (size_t)rv) <= 128 * 1024) {
				rv = search_mp_fps(rv, 1024);
				if (rv)
						return rv;
		}

		/* last KiB of system memory */
		rv = search_mp_fps((void*)0x7fc00, 1024);
		if (rv)
				return rv;
		rv = search_mp_fps((void*)0x9fc00, 1024);
		if (rv)
				return rv;

		/* BIOS ROM */
		rv = search_mp_fps((void*)0xf0000, 64 * 1024);
		return rv;
}

void* build_configuration_table_from_default(uint8_t tp)
{
		return NULL + tp - tp;
}

void parse_processor_entry(struct mp_proc* p)
{
		static int hdr = 0;
		if (!hdr++) {
				printf("Processors from MP list:\n");
				printf("TYPE  STATUS    APIC ID  SIGNATURE  FLAGS\n");
		}
		printf("%4s  %-8s  %7u  %08x   %08x\n",
				(p->cpu_flags & 2) ? "BP" : "AP",
				(p->cpu_flags & 1) ? "enabled" : "disabled",
				p->lapic_id, p->cpu_signature, p->cpu_features);

		/* only add non-disabled APs and the BP's id */
		if (!(p->cpu_flags & 1))
				return; /* disabled any */
		else if (p->cpu_flags & 2) { /* BP */
				apic_ids.bp_id = (uint32_t)p->lapic_id << 24;
				if (cpu.has_htt)
						goto htt_proc;
		} else { /* AP */
				struct apid* pi = kmalloc(sizeof(struct apid));
				pi->ap_id = (uint32_t)p->lapic_id << 24;
				/* enlist at front */
				pi->next = apic_ids.ap_ids;
				apic_ids.ap_ids = pi;
				/* TODO: UNTIL APIC DEBUG: */
				if (cpu.has_htt) {
htt_proc: /* mark as speculative */
						pi = kmalloc(sizeof(struct apid));
						pi->ap_id = ((uint32_t)p->lapic_id + 1) << 24 | 1;
						pi->next = apic_ids.ap_ids;
						apic_ids.ap_ids = pi;
				}
		}
}

void parse_bus_entry(struct mp_bus* b)
{
		struct busid* id;
		printf("Bus with id %u is %.6s\n", b->bus_id, b->bus_type);
		/* add every bus, but flag unrecognized ones */
		id = kmalloc(sizeof(struct busid));
		id->id = b->bus_id;
		id->next = bus_ids;
		if (strncmp(b->bus_type, "ISA   ", 6) == 0)
				id->type = BT_ISA;
		else if (strncmp(b->bus_type, "EISA  ", 6) == 0)
				id->type = BT_EISA;
		else if (strncmp(b->bus_type, "PCI   ", 6) == 0)
				id->type = BT_PCI;
		else {
				cprintf(KFMT_WARN, "bus type is unrecognized and will be ignored.\n");
				id->type = BT_UNKNOWN;
		}
		bus_ids = id;
}

void parse_io_apic(struct mp_ioapic* i)
{
		struct io_apic* io;
		printf("I/O APIC version %u with id %u at %p is %s.\n",
						i->ver, i->id, mp2ptr(i->addr),
						(i->flags & 1) ? "enabled" : "disabled");
		/* don't add disabled I/O APICs */
		if ((i->flags & 1) == 0)
				return;
		io = kmalloc(sizeof(struct io_apic));
		io->id = i->id;
		io->addr = mp2ptr(i->addr);
		io->next = io_apics;
		io_apics = io;
}

const char* find_bus(uint8_t id)
{
		struct busid* bi = bus_ids;
		const char* bts[4] = { "ISA", "EISA", "PCI", "Unknown" };
		if (!bus_ids)
				return "";
		do {
				if (bi->id == id)
						return bts[min(bi->type, 3)];
		} while ((bi = bi->next));
		return "";
}

void parse_io_interrupt(struct mp_iointr* i)
{
		const char* tps[5] = { "INT", "NMI", "SMI", "ExtINT", "Unknown" };
		const char* pol[4] = { "Bus", "hi", "res", "lo" };
		const char* el[4] = { "Bus", "edge", "res", "level" };
		static int prt = 0;
		if (!prt++) {
				printf("I/O interrupt assignments:\n");
				printf("TYPE     BUS (NAME)   IRQ  IOAPIC  INP#  POL    TRIG\n");
		}
		printf("%7s  %3u %-7s  %3u  %6u  %4u  %-5s  %-5s\n",
				tps[max(i->type, 4)], i->src_bus_id, find_bus(i->src_bus_id),
			   	i->src_bus_irq, i->dest_apic_id, i->dest_apic_inp,
				pol[i->intr_flags & 0x03], el[(i->intr_flags >> 2) & 0x03]);
		/* TODO: for now do nothing with this info */
}

void parse_local_interrupt(struct mp_locintr* l)
{
		printf("local interrupt assignment:\n");
		const char* tps[5] = { "INT", "NMI", "SMI", "ExtINT", "Unknown" };
		const char* pol[4] = { "Bus", "hi", "res", "lo" };
		const char* el[4] = { "Bus", "edge", "res", "level" };
		printf("\tType: %7s Bus: %3u %7s IRQ: %3u\n", tps[max(l->type, 4)],
				l->src_bus_id, find_bus(l->src_bus_id), l->src_bus_irq);
		printf("\tLocal APIC: %3u INP# %3u P: %5s T: %5s\n",
				l->dest_lapic_id, l->dest_lapic_linp,
				pol[l->intr_flags & 0x03], el[(l->intr_flags >> 2) & 0x03]);
		/* TODO: for now do nothing with this info */
}

void mp_sanitize_table()
{
		struct apid *ps, **pt;
		/* removes duplicate speculative processor entries */
		if (!cpu.has_htt)
				return;
		if (!(ps = apic_ids.ap_ids))
				return;
		pt = &apic_ids.ap_ids;
		do {
				int psu = 0;
				if (ps->ap_id & 1) {
						struct apid* p2 = apic_ids.ap_ids;
						/* entry is speculative */
						do {
								if (p2->ap_id == (ps->ap_id & 0xfffffffe)) {
										/* a real entry exists -> unlist */
										*pt = ps->next;
										kfree(ps);
										psu = 1;
										break;
								}
						} while ((p2 = p2->next));
						if (!psu)
								ps->ap_id &= 0xffffffe;
				}
				if (!psu)
						pt = &ps->next;
		} while ((ps = *pt));
}

void mp_parse_config_table(void* ptr)
{
		/* first map the table to VM */
		struct page_range pr = {(uint64_t)(size_t)ptr / 4096 * 4096, 1};
		struct mp_pcmp* mp = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
		uint16_t ec; void* e;

		if (!mp) {
				cprintf(KFMT_WARN, "unable to map MP configuration table to virtual memory. Continuing with UP init.\n");
				return;
		}
		/* fix the mmap alignment */
		mp = (void*)mp + ((uint32_t)ptr % 4096);

		/* now check for gigantic base tables */
		if (mp->length > 4096) {
				void* mem;
				pr.count = rdiv(mp->length, 4096);
				mem = mm_map(&mm_kernel, NULL, &pr, 1, MMGR_MAP_KERNEL);
				if (!mem)
						die("mmap fails very early!\n");
				mm_unmap(&mm_kernel, mp, 1);
				mp = mem + (uint32_t)ptr % 4096;
		}

		/* and do the checksum */
		if (checksum_memory(mp, mp->length) != 0) {
				cprintf(KFMT_WARN, "MP configuration table checksum error resulting in UP init.\n");
				while (1);
				mm_unmap(&mm_kernel, mp, pr.count);
				return;
		}

		/* now print some info */
		printf("MP configuration table version 1.%u for machine %.12s from vendor %.8s\n",
				mp->spec_rev, mp->product_id, mp->oem_id);

		/* print the entries */
		e = mp + 1;
		ec = mp->entry_count;
		while (ec--) {
				switch (*(uint8_t*)e) {
					case 0: /* processor */
						parse_processor_entry(e);
						e += 20;
						break;
					case 1:
						parse_bus_entry(e);
						e += 8;
						break;
					case 2:
						parse_io_apic(e);
						e += 8;
						break;
					case 3:
						parse_io_interrupt(e);
						e += 8;
						break;
					case 4:
						parse_local_interrupt(e);
						e += 8;
						break;
					default:
						cprintf(KFMT_WARN, "encountered an unknown entry in the MP table with unkown length. Further parsing is impossible.\n");
						if (ec > 0) /* only ignore last entry */
								goto cleanup;
				}
		}
		/* sanitize the results */
		mp_sanitize_table();

		/* cleanup */
cleanup:
		mm_unmap(&mm_kernel, mp, pr.count);
}

extern volatile uint8_t ap_start, ap_fail; extern uint8_t ap_mode;
extern volatile void* ap_gdtp; extern uint64_t ap_cr3;
void** pcp_data; /* pointers to per-processor data blocks */
size_t pcp_ofs = 0;
extern void* bp_apic_base;

void set_fs_offset(void* ofs, uint64_t* gdte)
{
		uint32_t o = (uint32_t)ofs;
		*gdte = (*gdte & 0x00ffff000000ffff) | ((o & 0xffff) << 16)
				| ((uint64_t)(o & 0xff0000) << 16) | ((uint64_t)(o & 0xff000000) << 32);
}

void update_fs()
{
		asm volatile (
				"movw %[seg], %%ax\n"
#ifdef __x86_64__
				"movw %%ax, %%gs\n"
#else
				"movw %%ax, %%fs\n"
#endif
				: : [seg] "i" (SEG_DATA_PROC)
		);
}

uint64_t apic_get_base()
{
		extern void* cpu_get_msr(uint32_t, uint32_t*, uint32_t*);
		uint32_t eax, edx;
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
		return ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
}

extern volatile void* ap_stack;
void pcp_init()
{
		uint64_t pm;
		struct processor_data* pd;
		struct mm_cpu_ctx mm_create_ctx();
		void* mm_alloc_page(uint64_t* b);
		void* ptr;
		pcp_data = mm_alloc_page(&pm);
		ap_stack = (void*)0x06000; // FM_AP_STACK top down (6->5)
		ap_cr3 = mm_kernel.cr3;
#ifdef __x86_64__
		ap_mode = 2;
#else
		if (cpu.has_pae)
				ap_mode = 1;
		else
				ap_mode = 0;
#endif
		pcp_data[0] = pd = kmalloc(sizeof(struct processor_data));
		pcp_ofs++;
		pd->proc_index = 0;
		pd->apic_id = apic_ids.bp_id;
		pd->apic_addr = bp_apic_base;
		pd->apic_phys = apic_get_base();
		pd->ticks = bp_tick;
		pd->mm_ctx = mm_create_ctx();
		/* now reload fs */
		set_fs_offset(pcp_data, (uint64_t*)(ap_gdtp + 0x40));
		update_fs();
		/* test it */
#ifdef __x86_64__
		asm volatile ("movq %%gs:0, %%rax" : "=a" (ptr));
#else
		asm volatile ("movl %%fs:0, %%eax" : "=a" (ptr));
#endif
		if (ptr != pd)
				die("per-cpu data through fs/gs segment selector not working!\n");
}

struct processor_data* get_cpu_data(uint32_t smp_index)
{
		return pcp_data[smp_index];
}

extern volatile uint8_t ap_start, ap_fail;

int launch_ap(uint32_t id)
{
		struct processor_data* pd;
		uint64_t ct = 10, timeout;
		ap_start = ap_fail = 0;

		/* check for cpu-data limit */
		if (pcp_ofs >= 1023) {
				cprintf(KFMT_WARN, "cpu-data limit reached, skipping processors.\n");
				return -1;
		}
		preempt_disable();
		pcp_data[pcp_ofs] = pd = kzalloc(sizeof(struct processor_data));
		pd->apic_id = id;
		pd->apic_addr = bp_apic_base - 4096;
		pd->apic_phys = 0;
		pd->proc_index = pcp_ofs;
		pd->ticks = kzalloc(sizeof(struct perf_ctrs));
		/* copy GDT template */
		ap_gdtp = kmalloc(GDT_SIZE);
		memcpy(ap_gdtp, &gdt, GDT_SIZE);
		/* set fs segment descriptor */
		set_fs_offset(pcp_data + pcp_ofs, (uint64_t*)(ap_gdtp + SEG_DATA_PROC));

		/* clear error */
		apic_reg(APIC_REG_ESR) = 0;

		/* assert INIT */
		apic_reg(APIC_REG_ICRH) = id;
		apic_reg(APIC_REG_ICRL) = 0x0000c500; /* edge assert level init */
		while (apic_reg(APIC_REG_ICRL) & (1 << 12)); /* send pending */
		mdelay(20);

		/* de-assert init */
		apic_reg(APIC_REG_ICRH) = id;
		apic_reg(APIC_REG_ICRL) = 0x00008500; /* edge de-assert init */
		while (apic_reg(APIC_REG_ICRL) & (1 << 12));

		barrier();

		/* SIPI loop */
resend:
		timeout = jiffies + HZ * ct / 1000;
		apic_reg(APIC_REG_ESR) = 0;
		apic_reg(APIC_REG_ICRH) = id;
		apic_reg(APIC_REG_ICRL) = 0x00004600 | 6; /* pseudo-vector 6 <-> 0x6000 */
		while (!ap_start)
				if (time_after(jiffies, timeout))
						break;
		if (!ap_start && ct < 1000) {
				ct *= 10; /* 1000ms */
				goto resend;
		}

		/* report if failure */
		if (!ap_start)
				goto failure;
		while (ap_start); /* trampoline is in use */
		if (ap_fail)
				goto failure;
		pcp_ofs++;
		bp_apic_base = pd->apic_addr; /* decrement next allocation base */
		preempt_enable();
		return 0;
failure:
		kfree(ap_gdtp);
		kfree(pd);
		preempt_enable();
		return -1;
}

void imcr_pic_to_apic()
{
		/* select IMCR register */
		outb(0x70, 0x22);
		/* NMI and 8259 INTR go through APIC */
		outb(0x01, 0x23);
}

void imcr_apic_to_pic()
{
		/* select IMCR register */
		outb(0x70, 0x22);
		/* NMI and 8259 INTR go directly to BSP */
		outb(0x00, 0x23);
}

void ioapic_init(int imcr)
{
		struct io_apic* io = io_apics;

		/* imcr is set */
		if (imcr)
				imcr_pic_to_apic();

		while (io) {
				extern void init_ioapic(uint8_t id, void* addr);
				/* call the kernel init function */
				init_ioapic(io->id, io->addr);
				/* advance */
				io = io->next;
		}
}

/* works on the mp init tables build up by the parser */
int mp_init(int imcr)
{
		struct apid* id = apic_ids.ap_ids;
		/* allocate per-processor pointers */
		pcp_init();
		/* we just start all reported APs */
		while (id) {
				printf("attempting to start AP %x\n", id->ap_id);
				if (launch_ap(id->ap_id) == 0) {
						cprintf(KFMT_OK, "started AP %08x successfully\n", id->ap_id);
						nproc++;
				} else
						cprintf(KFMT_WARN, "AP %08x refused to start\n", id->ap_id);
				id = id->next;
		}
		/* and setup the I/O APICs */
		ioapic_init(imcr);
		return (nproc > 1) ? 0 : -1;
}

void mp_entry()
{
		struct mp_fps* fps = find_mp_fps();
		if (fps) {
				void* ptr;
				printf("This machine conforms to the MP specification version 1.%u\n", (uint32_t)fps->spec_rev);
				if (!fps->features[0]) { /* table present */
						printf("It has a MP configuration table at %p\n", ptr = mp2ptr(fps->mp_config));
				} else {
						printf("It uses a default MP configuration defined by feature bits. "
								"Therefore there is no MP configuration table expected. (%p)\n", ptr = mp2ptr(fps->mp_config));
						printf("The default configuration has ID %u\n", fps->features[0]);
						if (!ptr)
								ptr = build_configuration_table_from_default(fps->features[0]);
						if (!ptr) {
								printf("and is unrecognized, resulting in UP init.\n");
								return;
						}
				}
				mp_parse_config_table(ptr);
				cprintf(KFMT_INFO, "attempting MP init...\n");
				if (mp_init(!!(fps->features[1] & 0x80)))
						cprintf(KFMT_WARN, "MP init failed continuing with UP.\n");
				else
						cprintf(KFMT_OK, "MP init successful, now there are %u processors active.\n", nproc);
		} else {
				printf("This machine does not conform to the MP specification but "
						"the CPU reports itself as MP system. A default (error prone) "
						"MP initialization could be performed, but this system will be run in UP mode.");
		}
}

