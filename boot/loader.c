/* loader.c : Loads the kernel images and modules into high memory.
 * */

#include "fixmem.h"
#include "basedefs.h"

typedef struct {
	uint8_t dat1[3];
	char acOEM[8];
	uint16_t iSectSize;
	uint8_t iClustSize;
	uint16_t iResSect;
	uint8_t iFatCnt;
	uint16_t iRootSize;
	uint16_t iTotalSect;
	uint8_t iMedia;
	uint16_t iFatSize;
	uint16_t iTrackSect;
	uint16_t iHeadCnt;
	uint32_t iHiddenSect;
	uint32_t iSect32;
	uint8_t iBootDrive;
	uint8_t iReserved;
	uint8_t iBootSign;
	char iVolID[4];
	char acVolumeLabel[11];
	char acFSType[8];
	uint8_t boot_code[378];
	uint32_t disk_signature;
	uint16_t zero;
	struct {
			uint8_t bootable;
			uint8_t chs_first[3];
			uint8_t type;
			uint8_t chs_last[3];
			uint32_t lba_first;
			uint32_t lba_count;
	} partition_table[4];
	uint16_t iSignature;
} __attribute__((aligned(1),packed)) BPB;

struct ptble { /* partition table entry */
		char flag;
		char s_c, s_h, s_s;
		char type;
		char e_c, e_h, e_s;
		uint64_t lba;
		uint64_t lba_ct;
} *p0 = (void*)0x7dbe; /* +1be 16bts each */

void* const data = FM_SECTOR_DATA;
uint64_t loaded_sector = 0xffffffffffffff;
extern void* rm_read_sector;

int read_lba_sector(uint64_t ofs)
{
		if (loaded_sector == ofs)
				return 0;
		else {
				register int rv;
				__asm__ volatile("push %1\n"
								 "push %2\n"
								 "call rm_read_sector\n"
								 "mov %%eax, %0\n"
								 "add $8, %%esp"
					: "=rm" (rv)
					: "irm" ((uint32_t)(ofs & 0xffffffff)),
					"irm" ((uint32_t)(ofs >> 32)));
				if (rv == 0)
						loaded_sector = ofs;
				return rv;
		}
}

void put16s(uint16_t num)
{
		char buf[] = "0000 ";
		for (int i = 0; i < 4; i++) {
				char c = (num >> 12);
				if (c > 9)
						c = 'a' + (c - 10);
				else
						c = '0' + c;
				buf[i] = c;
				num <<= 4;
		}
		putstr(buf);
}

BPB* bpb = (void*)FM_FAT16_BPB;

uint16_t get_next_cluster(uint16_t clst)
{
		uint64_t fat1_ofs;

		/* calculate the sector offset into the first FAT */
		fat1_ofs = p0->lba + bpb->iResSect + (((uint32_t)clst * 2) / bpb->iSectSize);
		/* read the FAT sector if necessary */
		read_lba_sector(fat1_ofs);

		/* return the next cluster number found at FAT sector + offset */
		return *(uint16_t*)((char*)data + ((size_t)clst * 2) % bpb->iSectSize);
}

int fat16_read(uint16_t* clst, int cct, uint32_t sz, struct page_range* pr, int prc)
{
		uint64_t data_ofs; int i; void* dst = 0;
		size_t dst_sz = 0;

		/* calculate the data offset */
		data_ofs = p0->lba + bpb->iResSect + bpb->iFatCnt * bpb->iFatSize;
		data_ofs += (i = bpb->iRootSize * 32) / bpb->iSectSize;
		if (i % bpb->iSectSize)
				data_ofs++;

		/* read the data */
		for (i = 0; i < cct; i++) {
				uint32_t j;
				uint64_t lba = data_ofs + (clst[i] - 2) * bpb->iClustSize;
				for (j = 0; j < bpb->iClustSize; j++) {
						size_t ct = sz > bpb->iSectSize ? bpb->iSectSize : sz;
						char *p1 = dst, *p2 = data;
						read_lba_sector(lba + j);
						while (ct--) {
								if (!dst || !dst_sz) {
										if (!prc)
												return -1;
										dst = (void*)pr->base;
										dst_sz = pr->count * 4096;
										pr++; prc--;
										p1 = dst;
								}
								*p1++ = *p2++;
								dst_sz--;
								sz--;
						}
						dst = (void*)p1;
				}
		}

		return 0;
}

int fat16_fill_cluster_table(uint16_t* clst, uint16_t clust, uint32_t sz, size_t* ct)
{
		size_t i = 0;
		while ((clust & 0xfff0) != 0xfff0) {
				clst[i++] = clust;
				if ((i - 1) * bpb->iSectSize * bpb->iClustSize > sz)
			   			return 1;
				else if (i + 1 == 0xffff && ((clust & 0xfff0) != 0xfff0))
						return 2;
				else if (i * bpb->iSectSize * bpb->iClustSize < sz && ((clust & 0xfff0) == 0xfff0))
						return 3;
				clust = get_next_cluster(clust);
		}

		*ct = i;
		for (i = 0; i < *ct; i++)
				put16s(clst[i]);
		put_nl();
		return 0;
}

/* write 8.3 fn */
void write_fn(void** pp, const char* fn)
{
		char* str = *pp;
		size_t i;
		for (i = 0; i < 11; i++) {
				if (i == 7)
						*str++ = '.';
				if (fn[i] != ' ')
						*str++ = fn[i];
		}
		*str++ = '\0';
		*pp = str;
}

void fill_cluster_table(uint16_t* clst, uint16_t start, uint32_t size, size_t* j)
{
		int rv;
		rv = fat16_fill_cluster_table(clst, start, size, j);
		if (rv == 1) {
				puts("damaged FAT. unable to read file.");
				while (1);
		} else if (rv == 2) {
				puts("file is larger than allowed. unable to continue loading.");
				while (1);
		} else if (rv == 3) {
				puts("file ends prematurely. damaged FAT likely. halting.");
				while (1);
		}
}

/* we're still w/o paging in 32-bit PM and can switch easily to BIOS */
uint64_t fl_load_images(int mode)
{
		uint64_t rv;

		/* read the BPB of the first partition */
		read_lba_sector(p0->lba);
		__builtin_memcpy(bpb, FM_SECTOR_DATA, 512);

		/* and then load the kernel and the modules */
		uint64_t early_entry(int mode);
		rv = early_entry(mode);

		/* and then jump into rv */
		return rv;
}

struct fdat {
		char fn[11];
		uint32_t size;
		uint16_t clst;
		struct fdat* prev;
		struct fdat* next;
} *fils = 0, *mods = 0;

void* get_f()
{
		static void* ptr = (void*)FM_FAT16_FILES;
		void* rv = ptr;
		ptr += sizeof(struct fdat);
		return rv;
}

uint64_t early_entry(int mode)
{
		char* ptr = FM_SECTOR_DATA, *fn; uint16_t* clst = FM_FAT16_CLSTRS;
		uint32_t i, bs, ct; uint64_t rv = 0;
		struct fdat *mf = 0, *kf = 0;
		void call_int15(uint32_t mus);

		puts("MyOS built on " __DATE__ " " __TIME__ );
		puts("listing root directory contents of boot drive:");
		call_int15(1000000); /* delay 1000ms */
		//for (i = 0; i < 0xffffffff / 4; i++); /* mega dangerous */

		puts("SIZE       CLSTR NAME    EXT");
		ct = bpb->iRootSize * 32; /* normally FAT16 224*32 */
		ct = ct / bpb->iSectSize + (ct % bpb->iSectSize) ? 1 : 0; /*  */
		bs = bpb->iResSect + bpb->iFatCnt * bpb->iFatSize;
		nput32(bpb->iSectSize, 10);
		/* reads every root directory sector */
		for (i = 0; i < ct; i++) {
				puts("r");
				read_lba_sector(p0->lba + bs + i);
				puts("d");
				/* and iterates over the entries */
				for (fn = ptr; fn < ptr + 0x200; fn += 32) {
						if (fn[11] == 0x0f) { /* LFN */
								continue;
						}
						if (*fn) { /* which are present */
								struct fdat* f;
								f = get_f();
								fn[11] = '\0';
								__builtin_memcpy(f->fn, fn, 11);
								f->clst = *(uint16_t*)(fn + 0x1a);
								f->size = *(uint32_t*)(fn + 0x1c);
								if (fils) {
										f->next = fils;
										f->prev = fils->prev;
										f->prev->next = f;
										fils->prev = f;
								} else {
										f->prev = f->next = f;
										fils = f;
								}
								nput32(f->size, 10);
								putstr(" ");
								put16s(f->clst);
								putstr(" ");
								puts(fn);
								//printf("%11u %5u %s\n", f->size, f->clst, fn);
						} else {
								i = ct;
								break;
						}
				}
		}
		put_nl();
		call_int15(1000000); /* delay 1000ms */

		if (!fils)
				goto abrt;
		/* now check for the presence of MODULES.MOD and K64.ELF */
		for (struct fdat* f = fils; ; f = f->next) {
				if (strncmp(f->fn, "MODULES MOD", 11) == 0)
						mf = f;
				else if (!mode && strncmp(f->fn, "KERNEL32ELF", 11) == 0)
						kf = f;
				else if (mode == 1 && strncmp(f->fn, "KERNEL36ELF", 11) == 0)
						kf = f;
				else if (mode == 2 && strncmp(f->fn, "KERNEL64ELF", 11) == 0)
						kf = f;
				if (f->next == fils || (mf && kf))
						break;
		}
		/* and abort if missing */
		if (!kf || !mf) {
abrt:
				puts("Unable to locate boot files in root directory. Halting...");
				while (1);
		}

		/* read the kernel image */
		{
				size_t cct; uint32_t sz, pc;
				struct page_range prs[32];

				fill_cluster_table(clst, kf->clst, kf->size, &cct);
				/* get the memory */
				sz = kf->size / 4096 + ((kf->size % 4096) ? 1 : 0);
				pc = mm_alloc_pm(sz, prs, 32);
				if (pc != sz) {
						puts("unable to allocate memory for kernel image.");
						while (1);
				}

				if (fat16_read(clst, cct, kf->size, prs, 32)) {
						puts("failed reading kernel. halting...");
						while (1);
			 	} else
						puts("done reading kernel.");

				/* and map it correctly */
				uint64_t map_elf_image(int, uint32_t, struct page_range*, int);
				rv = map_elf_image(mode, sz, prs, 32);
		}

//		/* move lf to the modules */
//		lf->prev->next = lf->next;
//		lf->next->prev = lf->prev;
//		lf->prev = lf->next = lf;
//		mods = lf;
//
//		/* now first read the module list */
//		{
//				size_t cct = 0; char* c = fofs + 4;
//				printf("reading module list...\n");
//				fill_cluster_table(clst, mf->clst, mf->size, &cct);
//				if (fat16_read(clst, cct, mf->size, fofs)) {
//						printf("failed\nhalting...\n");
//						while (1);
//				} else
//						printf("done\n");
//				/* and interprete the contents */
//				c[mf->size] = 0;
//				cct = 1;
//				printf("modules specified (in load order):\n");
//				while (c < (char*)fofs + mf->size) {
//						char* end = strchr(c, '\n');
//						char fi[12];
//						printf("%4u %.11s\n", cct++, c);
//						if (end) {
//								*end = 0;
//								if (end > c) {
//										int nc = 0;
//										if (end[-1] == '\r') /* win compat */
//												end[-1] = 0;
//										while (*c) {
//												fi[nc++] = *c++;
//												if (nc == 11) /* abort at 8.3 limit */
//														break;
//										}
//										for (int k = nc; k < 11; k++)
//												fi[k] = ' '; /* fill with spaces */
//										fi[11] = 0;
//										if (nc) { /* find the module file and add it to list */
//												int fnd = 0;
//												for (struct fdat* f = fils; ; f = f->next) {
//														if (strncmp(f->fn, fi, 11) == 0) {
//																/* we're stealing files /w updating the refs */
//																f->prev->next = f->next;
//																f->next->prev = f->prev;
//																/* mods in non-empty */
//																mods->prev->next = f;
//																f->next = mods;
//																f->prev = mods->prev;
//																mods->prev = f;
//																fnd = 1;
//																break;
//														}
//														if (f->next == fils)
//																break;
//												}
//												if (!fnd) {
//														printf("Module \"%s\" specified in MODULES.MOD"
//																" missing in root directory!\n", fi);
//														while (1);
//												}
//										}
//										c = end + 1;
//								} else { /* empty line */
//										c = end + 1;
//								}
//						} else /* we don't recognize line w/o newline */
//								break;
//				}
//		}
//
//		/* first free other fns */
//		if (fils) { /* mf should still be there */
//				struct fdat* f = fils, *f2;
//				fils->prev->next = NULL;
//				while (f) {
//						f2 = f->next;
//						kfree(f);
//						f = f2;
//				}
//		}
//		
//		/* now iterate over the modules to load */
//		{
//				struct fdat* f = mods, *f2;
//				f->prev->next = NULL; int ct = 0;
//				while (f) {
//						size_t j;
//						fill_cluster_table(clst, f->clst, f->size, &j);
//						write_fn(&fofs, f->fn);
//						if (fofs + 4 + f->size > (void*)0x300000) {
//								printf("unable to load file %.11s into memory\n", f->fn);
//								printf("only files with sum smaller than 1MiB supported\n");
//								printf("aborting...\n");
//								while (1);
//						}
//						/* now read the file */
//						printf("Reading file %.11s to %p...\n", f->fn, fofs + 4);
//						if (fat16_read(clst, j, f->size, fofs)) {
//								printf("failed\nhalting...\n");
//								while (1);
//					 	} else
//								printf("done\n");
//						fofs += 4 + f->size;
//
//						/* goto next entry */
//						f2 = f->next;
//						kfree(f);
//						f = f2;
//						ct++;
//				}
//
//				*(uint32_t*)(0x200000) = ct; /* ct files read from disk */
//		}
//
//		/* now select the video mode */
//		void vga_init();
//		vga_init();
		return rv;
}


