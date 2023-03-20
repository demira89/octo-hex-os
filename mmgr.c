/* mmgr.c : Implements the memory management of the OS
 *          managing physical and virtual memory
 * */

#include "limits.h"
#include "kernel.h"
#define MMGR
#include "kdata.h"
/*#define MEMBABBLE*/
#ifdef MEMBABBLE
#define mbprintf printf
#else
#define mbprintf noprintf
#endif

#define FIXED_START ((void*)0x48000)
#define FIXED_END ((void*)0x60000)
/* Initial available low memory layout
 * 0x500-0x7bff (contains memory map and old realmode stack, 30KiB)
 * 0x7e00+X-0x7ffff (~480KiB, kernel stack from 0x80000 down)
 * USAGE by MMGR:
 *   0x400-0x500 BDA (EBDA segment at 0x50e)
 *   0x500-0xb00 (1536, 1.5KiB) memory map from BIOS
 *   0xb00-0x1000 (1280, 1.25KiB) list of usable memory <- NO LONGER
 *   0x1000-0x7c00 (8x4096+3x1024, 27KiB) start of physical memory usage map
 *                 contains enough memory for 27 maps covering 27x16=432MiB
 *   0x7c00-0x47c00 [endrest] memory used by the program
 *   0x48000-0x60000 Free FIXED (IDENTITY MAPPED) memory w/o PMU/RCP (48 Pgs)
 *   TODO: Merge all previous into fixed allocator
 *   0x60000-0x61000 free memory areas
 *   0x61000-0x62000 reserved memory areas
 *   0x62000-0x6???? FAT16 directory etc. temporary data
 *   0x60000-0x7ffff Initial kernel stack
 *   0x80000-????? FAT16 directory etc. temporary data
 *
 *   PAGE-Mapping: MAP 0x0-0x80000 as kernel page
 *     ALL  WITH   MAP 0xb8000-? as (possibly write-cached) VGA memory
 *     VIRT=PHYS   MAP 0x100000-0x200000 as first kernel heap (1 MiB)
 *     !!!ELF!!!   MAP 0x200000-0x300000 for preloading ELF files <------- not at 80000
 *      NONE       RES Virt 0x300000-0x500000 reclaimable for easy heap extension/etc.
 *     VARIABLE    top_vm_ptr for values in last PD w/o allocating PT
 *     VARIABLE    "USER" VM from 0x01000000-0x9fffffff
 *     VARIABLE    Module loading from 0xa0000000-0xdfffffff
 *     POSSIBLY    MAP MMIO into 0xe0000000-0xefffffff (APIC: 0xefff000 down until bp_apic_base)
 *     VARIABLE    MAP 0xfffff000 pointing to scrubbing page
 *     VARIABLE    MAP 0xfe000000-0xff000000 for stacks (interrupt etc., 4096Pg, 16MiB)
 * */
/* TODO: USER VMEM allocator & context switch table exchange PT[PID]
 * w. PAE (easy) 2 center PDPE user -> n*24bt cr3
 * w/o PAE: fill n PDs?
 * */

/* dirty/clean pages also need to be handled here
 * */

static struct pde
{
		uint32_t present : 1;
		uint32_t writable : 1;
		uint32_t user_page : 1;
		uint32_t wt_cache : 1;
		uint32_t no_cache : 1;
		uint32_t pt_accessed : 1; /* cpu sets (!) it when accessing table */
		uint32_t lp_write : 1; /* written bit for large pages */
		uint32_t s_bit : 1; /* is large parge 1=4MB/2MB (PAE) */
		uint32_t g_bit : 1; /* for large pages */
		uint32_t user : 3;
		uint32_t pt_ptr : 20;
} *page_directory = NULL;

static struct pae_pde
{
		uint64_t present : 1;
		uint64_t writable : 1;
		uint64_t user_page : 1;
		uint64_t wt_cache : 1; /* use wt on PTs pointed to */
		uint64_t no_cache : 1;
		uint64_t pt_accessed : 1; /* set when used for address translation */
		uint64_t lp_write : 1; /* used only on 2MiB-Pages */
		uint64_t s_bit : 1; /* determined large/regular page */
		uint64_t g_bit : 1; /* global (for large pages) */
		uint64_t user : 3;
		uint64_t pt_ptr : 40;
		uint64_t res : 11;
		uint64_t nx_enable : 1; /* if set no instruction fetches allowed */
} *pae_pds[4] = {0};

static struct pae_pdpe
{
		uint64_t present : 1;
		uint64_t res1 : 2;
		uint64_t wt_cache : 1; /* use wt to access PD pointed to */
		uint64_t no_cache : 1;
		uint64_t res2 : 4;
		uint64_t user : 3;
		uint64_t pd_ptr : 40; /* 36 up to 52 (ext. cpuid 8) */
		uint64_t res3 : 12;
} pae_pdp[4] __attribute__ ((aligned(0x20))); /* .bss */

struct pae_pte
{
		uint64_t present : 1;
		uint64_t writable : 1;
		uint64_t user_page : 1;
		uint64_t wt_cache : 1;
		uint64_t no_cache : 1;
		uint64_t mem_accessed : 1;
		uint64_t mem_write : 1;
		uint64_t reserved : 1; /* or PAT bit */
		uint64_t g_bit : 1;
		uint64_t user : 3;
		uint64_t mem_ptr : 40;
		uint64_t reserved2 : 11;
		uint64_t nx_enable : 1; /* or reserved if unsupported */
};

struct pte
{
		uint32_t present : 1;
		uint32_t writable : 1;
		uint32_t user_page : 1;
		uint32_t wt_cache : 1;
		uint32_t no_cache : 1;
		uint32_t mem_accessed : 1; /* cpu sets (!) it when reading the memory */
		uint32_t mem_write : 1; /* written bit for memory pointed to */
		uint32_t reserved : 1; /* is usually 0 */
		uint32_t g_bit : 1; /* no TLB reload when changing cr0 for this page */
		uint32_t user : 3;
		uint32_t mem_ptr : 20;
};

struct pmu /* physical memory usage */
{
		uint32_t lvl0[128]; /* 4096 bits for covering 16MiB */
		uint32_t lvl1[64]; /* 2048 bits for 8K blocks */
		uint32_t lvl2[32]; /* 1024 bits for 16K blocks */
		uint32_t lvl3[16]; /* 512 bits for 32K blocks */
		uint32_t lvl4[8]; /* 256 bits for 64K blocks */
		uint32_t lvl5[4]; /* 128 bits for 128K blocks */
		uint32_t lvl6[2]; /* 64 bits for 256K blocks */
		uint32_t lvl7; /* 32 bits for 512K blocks */
		struct pmu* pmu_next;
} *pmu_allocator = (struct pmu*)0x1000, *pmu_limit = (struct pmu*)0x7c00;

struct pte* pt_allocator = NULL;
uint64_t pt_pmem = 0;
size_t pt_all_cap = 0;
void* top_vm_ptr = (void*)0xfffff000;
void* fixed_allocator = FIXED_START;
void** pd_pt_ptr = NULL;
/* VM mapping of PTs (1024 or 2048) */
char paging_enabled = 0;

uint32_t flush_ct = 0;

static inline void flush_tlb_single(uint32_t addr)
{
		__sync_fetch_and_add(&flush_ct, 1);
		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
}

static inline void flush_tlb_full()
{
		asm volatile("mov %%cr3, %%eax\nmov %%eax, %%cr3\n" : : : "%eax");
}

/* allocate pg_ct identity-mapped pages (for processor data neeeded before paging) */
void* identity_num(size_t pg_ct)
{
		struct page_range pr; void* rv;
		/* for now just assume availability */
		mmgr_pmem_allocate(&pr, 1, pg_ct, /* 32bit for lack of PAE w/o paging */
				MMGR_ALLOC_CONTIGUOUS | MMGR_ALLOC_32_BIT);
		if (pr.count != pg_ct)
				die("no %u contiguous pages for identity mapping available!\n", pg_ct);
		rv = mmgr_map_pmem((void*)pr.base, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
		if (!rv)
				die("Identity mapping of %016llx not possible\n", pr.base);
		return rv;
}

void* fixed_num(size_t pg_ct)
{
		void* rv = fixed_allocator;
		if (fixed_allocator + pg_ct * 0x1000 >= FIXED_END) {
				cprintf(KFMT_WARN, "Can't allocate %u fixed pages\n", pg_ct);
				return NULL;
		} else
				fixed_allocator += pg_ct * 0x1000;
		return rv;
}

void fixed_next()
{
		fixed_allocator += 0x1000;
		if (fixed_allocator == FIXED_END) {
				cprintf(KFMT_WARN, "Out of fixed mapped memory\n");
				fixed_allocator = NULL;
		}
}

void pmu_next()
{
		pmu_allocator++;
		if (pmu_allocator == pmu_limit) {
				size_t np; struct page_range pr[8];
				mbprintf("Out of PMU slots\nAllocating new ones...\n");
				np = mmgr_pmem_allocate(pr, 8, 16, 0);
				//np = mmgr_pmem_allocate(pr, 8, 16, 0);
				if (np) {
						if (!paging_enabled) {
								cprintf(KFMT_ERROR, "Ran out of initial PMUs before paging was enabled\n");
								while (1);
						}
						mbprintf("%u pages allocated, mapping...\n", np);
						pmu_limit = (struct pmu*)top_vm_ptr;
						top_vm_ptr = (void*)((size_t)top_vm_ptr - np * 4096);
						if (mmgr_map_pmem(top_vm_ptr, pr, 8, MMGR_MAP_WRITE | MMGR_MAP_KERNEL) == NULL) {
								cprintf(KFMT_ERROR, "Unable to map PMUs at %p\n", top_vm_ptr);
								while (1);
						}
						pmu_allocator = (struct pmu*)top_vm_ptr;
						mbprintf("%u pages mapped for PMUs at %p\n", np, top_vm_ptr);
				} else {
						cprintf(KFMT_ERROR, "Unable to allocate further PMU slots\n");
						while (1);
				}
		}
}

void pt_alloc_init()
{
		struct page_range pr;
		if (mmgr_pmem_allocate(&pr, 1, 8, 1) == 8) {
				/* Test NO vs. WRITE_BACK */
				pt_pmem = pr.base;
				top_vm_ptr = (void*)((size_t)top_vm_ptr - 8 * 4096);
				/* is no identity map (could use a separate mapping or a temporary mapping range) */
				pt_allocator = (struct pte*)mmgr_map_pmem(top_vm_ptr,
							   &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL /* | MMGR_MAP_NO_CACHING*/);
				if (!pt_allocator) {
						cprintf(KFMT_ERROR, "Unable to map page tables into virtual memory!\n");
						while (1);
				}
				pt_all_cap = 8;
				mbprintf("memory for %u page tables at %p allocated\n", pt_all_cap, pt_allocator);
				mbprintf("%p maps to physical memory %p\n", pt_allocator, (void*)(size_t)pt_pmem);
			
		} else {
				cprintf(KFMT_ERROR, "No pages for page tables available!\n");
				while (1);
		}
}

/* returns a scrubbed page-table */
struct pte* pt_allocate(uint64_t* pm)
{
		if (!pt_all_cap)
				pt_alloc_init();
		else
				mbprintf("using existing PT cache at %p\n", pt_allocator);
		pt_all_cap--;
		*pm = pt_pmem;
		pt_pmem += 4096;
		pt_allocator += 1024; /* 1024 PTEs per PT */
		return pt_allocator - 1024;
}

#ifndef __clang__
STATIC_ASSERT(sizeof(struct pmu)==1024, pmu_not_1024_bytes);
#endif

void mmgr_init_tss();

//void mmgr_init_pd_pae()
//{
//		size_t i; struct pae_pde* pd; /* 512 entries each */
//		/* allocate the page directories */
//		pae_pds[0] = fixed_allocator;
//		bzero(fixed_allocator, 4096);
//		fixed_next();
//		pae_pds[3] = fixed_allocator;
//		bzero(fixed_allocator, 4096);
//		fixed_next();
//		/* first fill the page-directory-pointer-table */
//		for (i = 0; i < 4; i++)
//				if (pae_pds[i]) {
//						pae_pdp[i].present = 1;
//						pae_pdp[i].pd_ptr = ((uint64_t)(size_t)pae_pds[i]) / 0x1000;
//						printf("PAE PDE %u: %llu\n", i, pae_pdp[i].pd_ptr);
//						/* and mark all as not present */
//						for (size_t j = 0; j < 512; j++)
//								pae_pds[i][j].present = 0; /* .bss normally */
//				}
//		/* and set the VM PT pointer container */
//		pd_pt_ptr = fixed_num(2);
//		printf("PAE PT ptr: %p\n", pd_pt_ptr);
//		/* now initialize the first two and last two page directory entries */
//		pd = pae_pds[0];
//		pd->present = pd->writable = 1;
//		pd->wt_cache = pd->no_cache = pd->pt_accessed = pd->lp_write = 0;
//		pd->s_bit = pd->g_bit = 0;
//		pd->user_page = 1; /* TEST: all user pages (and don't restrict) */
//		pd->user = 0;
//		pd->pt_ptr = (uint64_t)(size_t)fixed_allocator / 0x1000; /* First PT */
//		bzero(fixed_allocator, 4096);
//		pd_pt_ptr[0] = fixed_allocator;
//		printf("PAE PT0: %p\n", fixed_allocator);
//		fixed_next();
//		pd[1] = pd[0];
//		pd[1].pt_ptr = (uint64_t)(size_t)fixed_allocator / 0x1000;
//		bzero(fixed_allocator, 4096);
//		pd_pt_ptr[1] = fixed_allocator;
//		printf("PAE PT1: %p\n", fixed_allocator);
//		fixed_next();
//		pd = pae_pds[3] + 511;
//		*(uint64_t*)pd = 0;
//		pd->present = pd->writable = 1;
//		pd->pt_ptr = (uint64_t)(size_t)fixed_allocator / 0x1000; /* Last PT */
//		bzero(fixed_allocator, 4096);
//		pd_pt_ptr[2047] = fixed_allocator;
//		printf("PAE PT2047: %p\n", fixed_allocator);
//		fixed_next();
//		pd[-1] = *pd;
//		pd[-1].pt_ptr = (uint64_t)(size_t)fixed_allocator / 0x1000;
//		bzero(fixed_allocator, 4096);
//		pd_pt_ptr[2046] = fixed_allocator;
//		printf("PAE PT2046: %p\n", fixed_allocator);
//		fixed_next();
//		/* possibly map the video memory to 0xe0000000 */
//		if (vga_pmem >= (void*)0x100000) {
//				void* pm = vga_pmem; uint16_t pt_ofs = 1792;
//				size_t pg_ct = vga_pmem_size / 4096 + (vga_pmem_size % 4096 ? 1 : 0);
//				size_t num_pts = pg_ct / 512 + (pg_ct % 512 ? 1 : 0);
//				if (mmio_get_vmem(pg_ct) != (void*)0xe0000000)
//						die("impossible!\n");
//				printf("PAE VideMemory mapping:\n");
//				/* allocate and fill the page tables */
//				/* an put them in the directory */
//				pd = pae_pds[3] + 256; /* 0xe0000000 */
//				printf("using %u PTs and %u pages\n", num_pts, pg_ct);
//				while (num_pts) {
//						*(uint64_t*)pd = 0; struct pae_pte* pt;
//						pd->present = pd->writable = 1;
//						pd->wt_cache = 1; /* write though as HWmem */
//						pd->user_page = 1; /* TEST: all user pages */
//						pd->pt_ptr = (uint64_t)(size_t)fixed_allocator / 0x1000;
//						bzero(fixed_allocator, 4096);
//						pt = fixed_allocator;
//						pd_pt_ptr[pt_ofs++] = fixed_allocator;
//						printf("filling PT%d at %p\n", pt_ofs, fixed_allocator);
//						fixed_next();
//						/* fill the entries already here (easier) */
//						for (size_t i = 0; i < 512; i++) {
//								pt[i].present = 1;
//								pt[i].writable = 1;
//								pt[i].wt_cache = 1;
//								pt[i].mem_ptr = (uint64_t)(size_t)pm / 0x1000;
//								if (!--pg_ct)
//										break;
//								pm += 4096;
//						}
//						num_pts--;
//						pd++;
//				}
//		}
//}
//
//void mmgr_init_pd()
//{
//		size_t i;
//		/* allocate the PT VM pointer container */
//		pd_pt_ptr = fixed_allocator;
//		bzero(fixed_allocator, 4096);
//		fixed_next();
//		/* allocate the page directory */
//		page_directory = fixed_allocator;
//		bzero(fixed_allocator, 4096);
//		printf("page_directory set to %p\n", page_directory);
//		fixed_next();
//		/* point first entry to first page table*/
//		page_directory->present = 1;
//		page_directory->writable = 1;
//		/* don't restrict caching options of contained pages */
//		page_directory->wt_cache = 0;
//		page_directory->no_cache = 0;
//		page_directory->pt_accessed = 0;
//		page_directory->lp_write = 0;
//		page_directory->s_bit = 0; /* no large page */
//		page_directory->g_bit = 0;
//		page_directory->user_page = 1; /* TEST: ALL USER PAGES */
//		page_directory->user = 0; /* currently no user data */
//		page_directory->pt_ptr = (uint32_t)fixed_allocator / 0x1000; /* First PT */
//		pd_pt_ptr[0] = fixed_allocator;
//		bzero(fixed_allocator, 4096);
//		fixed_next();
//		/* point the last entry to the last PT */
//		*(uint32_t*)(page_directory + 1023) = 0;
//		page_directory[1023].present = 1;
//		page_directory[1023].writable = 1;
//		page_directory[1023].pt_ptr = (uint32_t)fixed_allocator / 0x1000; /* Last PT */
//		pd_pt_ptr[1023] = fixed_allocator;
//		bzero(fixed_allocator, 4096);
//		fixed_next();
//		/* possibly map the video memory to 0xe0000000 */
//		if (vga_pmem >= (void*)0x100000) {
//				void* pm = vga_pmem; uint16_t pt_ofs = 896; struct pde* pd;
//				size_t pg_ct = vga_pmem_size / 4096 + (vga_pmem_size % 4096 ? 1 : 0);
//				size_t num_pts = pg_ct / 1024 + (pg_ct % 1024 ? 1 : 0);
//				/* allocate and fill the page tables */
//				/* an put them in the directory */
//				pd = page_directory + 896; /* 0xe0000000 */
//				while (num_pts) {
//						*(uint32_t*)pd = 0; struct pte* pt;
//						while (num_pts);
//						pd->present = pd->writable = 1;
//						pd->wt_cache = 1; /* write though as HWmem */
//						pd->user_page = 1; /* TEST: all user pages */
//						pd->pt_ptr = (uint32_t)(size_t)fixed_allocator / 0x1000;
//						bzero(fixed_allocator, 4096);
//						pt = fixed_allocator;
//						pd_pt_ptr[pt_ofs++] = fixed_allocator;
//						fixed_next();
//						/* fill the entries already here (easier) */
//						for (size_t i = 0; i < 1024; i++) {
//								pt[i].present = 1;
//								pt[i].writable = 1;
//								pt[i].wt_cache = 1;
//								pt[i].mem_ptr = (uint64_t)(size_t)pm / 0x1000;
//								if (!--pg_ct)
//										break;
//								pm += 4096;
//						}
//						num_pts--;
//						pd++;
//				}
//		}
//}
//
//void mmgr_init_pt_pae()
//{
//		size_t i; struct pae_pte* pt;
//
//		extern void* endtext;
//		extern void* rest;
//		cprintf(KFMT_INFO, "protecting .text section from %p to %p\n", &rest, &endtext);
//		/* configure first page table */
//		pt = (struct pae_pte*)pd_pt_ptr[0];
//		/* mark the first entries up to 0x80000 */
//		for (i = 0; i < 128; i++) {
//				*(uint64_t*)(pt + i) = 0;
//				pt[i].present = 1;
//#ifdef NO_GDB
//				if (i * 0x1000 >= (size_t)&rest && i * 0x1000 < (size_t)&endtext) {
//						pt[i].writable = 1; /* <-- for TSS access*/
//				} else /* V- FOR GDB support */
//#endif
//				{
//						pt[i].writable = 1;
//						if (cpu.e_has_nx)
//								pt[i].nx_enable = 1;
//				}
//				pt[i].mem_ptr = i;
//				/* TEST: ALL USER PAGES */
//				pt[i].user_page = 1;
//		}
//		/* now map the VGA&ISA&... MMIO pages with write-through */
//		for (i = 128; i < 256; i++) {
//				*(uint64_t*)(pt + i) = 0;
//				pt[i].present = 1;
//				pt[i].writable = 1;
//				pt[i].wt_cache = 1;
//				pt[i].mem_ptr = i;
//				/* TEST: ALL USER PAGES */
//				pt[i].user_page = 1;
//				if (cpu.e_has_nx)
//						pt[i].nx_enable = 1;
//		}
//		/* map the 1MiB kernel heap */
//		for (i = 256; i < 512; i++) {
//				*(uint64_t*)(pt + i) = 0;
//				pt[i].present = 1;
//				pt[i].writable = 1;
//				pt[i].mem_ptr = i;
//				/* TEST: ALL USER PAGES */
//				pt[i].user_page = 1;
//				if (cpu.e_has_nx)
//						pt[i].nx_enable = 1;
//		}
//		/* the second "half" */
//		pt = (struct pae_pte*)pd_pt_ptr[1];
//		/* map the 1MiB ELF loadspace read-only */
//		for (i = 0; i < 256; i++) {
//				*(uint64_t*)(pt + i) = 0;
//				pt[i].present = 1;
//				pt[i].writable = 1; /* NOPE! using Elf32_Addr-field in loading */
//				pt[i].mem_ptr = 512 + i;
//				/* TEST: ALL USER PAGES */
//				pt[i].user_page = 1;
//				if (cpu.e_has_nx)
//						pt[i].nx_enable = 1;
//		}
//		/* keep the  last 1MiB protected */
//		for (i = 256; i < 512; i++) {
//				*(uint64_t*)(pt + i) = 0;
//				/*pt[i].present = 0;*/
//		}
//
//		/* configure the last two page tables */
//		pt = (struct pae_pte*)pd_pt_ptr[2046];
//		for (i = 0; i < 512; i++)
//				pt[i].present = 0;
//		pt = (struct pae_pte*)pd_pt_ptr[2047];
//		for (i = 0; i < 512; i++)
//				pt[i].present = 0;
//
//		/* load the directroy address and enable paging */
//		__asm__ volatile (
//				"cli\n"
//				"mov %%cr4, %%eax\n"
//				"or $0x00000020, %%eax\n"
//				"mov %%eax, %%cr4\n"
//				"mov %0, %%eax\n"
//				"mov %%eax, %%cr3\n"
//				"mov %%cr0, %%eax\n"
//				"or $0x80010000, %%eax\n"
//				"mov %%eax, %%cr0\n"
//			   	:
//			   	:
//			   	"r" (&pae_pdp[0]) :
//			   	"%eax"
//		);
//
//		/* keep printf working */
//		if (vga_pmem >= (void*)0x100000)
//				vga_mem_ptr = (void*)0xe0000000;
//		paging_enabled = 1;
//		__asm__ volatile ("sti");
//
//		cprintf(KFMT_INFO, "Paging (PAE) is now enabled\n");
//		/*printf("Reading char from 0x1fffff ...");
//		i = *(char*)0x1fffff;
//		printf(" yields %d\n",  i);
//		printf("Reading word from 0x1fffff results in ...\n");
//		i = *(short*)0x1fffff;
//		printf("value %d\n", i);*/
//		printf("Allocating page frame for additional page tables\n");
//}
//
//void mmgr_init_pt()
//{
//		size_t i; struct pte* pt;
//
//		extern void* endtext;
//		extern void* rest;
//		cprintf(KFMT_INFO, "protecting .text section from %p to %p\n", &rest, &endtext);
//		/* configure first page table */
//		pt = (struct pte*)pd_pt_ptr[0];
//		/* mark the first entries up to 0x80000 */
//		for (i = 0; i < 128; i++) {
//				*(uint32_t*)(pt + i) = 0;
//				pt[i].present = 1;
//#ifdef NO_GDB
//				if (i * 0x1000 >= (size_t)&rest && i * 0x1000 < (size_t)&endtext)
//						pt[i].writable = 1; /* <-- for TSS access*/
//				else /* V- FOR GDB support */
//#endif
//						pt[i].writable = 1;
//				pt[i].mem_ptr = i;
//				/* TEST: ALL USER PAGES */
//				pt[i].user_page = 1;
//		}
//		/* now map the VGA&ISA&... MMIO pages with write-through */
//		for (i = 128; i < 256; i++) {
//				*(uint32_t*)(pt + i) = 0;
//				pt[i].present = 1;
//				pt[i].writable = 1;
//				pt[i].wt_cache = 1;
//				pt[i].mem_ptr = i;
//				/* TEST: ALL USER PAGES */
//				pt[i].user_page = 1;
//		}
//		/* map the 1MiB kernel heap */
//		for (i = 256; i < 512; i++) {
//				*(uint32_t*)(pt + i) = 0;
//				pt[i].present = 1;
//				pt[i].writable = 1;
//				pt[i].mem_ptr = i;
//				/* TEST: ALL USER PAGES */
//				pt[i].user_page = 1;
//		}
//		/* map the 1MiB ELF loadspace read-only */
//		for (i = 512; i < 768; i++) {
//				*(uint32_t*)(pt + i) = 0;
//				pt[i].present = 1;
//				pt[i].writable = 1; /* NOPE! using Elf32_Addr-field in loading */
//				pt[i].mem_ptr = i;
//				/* TEST: ALL USER PAGES */
//				pt[i].user_page = 1;
//		}
//		/* keep the  last 1MiB protected */
//		for (i = 768; i < 1024; i++) {
//				*(uint32_t*)(pt + i) = 0;
//				/*pt[i].present = 0;*/
//		}
//
//		/* configure the last page table */
//		pt = (struct pte*)pd_pt_ptr[1023];
//		for (i = 0; i < 1024; i++)
//				pt[i].present = 0;
//
//		/* load the directroy address and enable paging */
//		__asm__ volatile (
//				"cli\n"
//				"mov %0, %%eax\n"
//				"mov %%eax, %%cr3\n"
//				"mov %%cr0, %%eax\n"
//				"or $0x80010000, %%eax\n"
//				"mov %%eax, %%cr0\n"
//			   	:
//			   	:
//			   	"m" (page_directory) :
//			   	"%eax"
//		);
//
//		/* keep printf working */
//		if (vga_pmem >= (void*)0x100000)
//				vga_mem_ptr = (void*)0xe0000000;
//		paging_enabled = 1;
//		__asm__ volatile ("sti");
//
//		cprintf(KFMT_INFO, "Paging (no PAE) is now enabled\n");
//		/*printf("Reading char from 0x1fffff ...");
//		i = *(char*)0x1fffff;
//		printf(" yields %d\n",  i);
//		printf("Reading word from 0x1fffff results in ...\n");
//		i = *(short*)0x1fffff;
//		printf("value %d\n", i);*/
//		printf("Allocating page frame for additional page tables\n");
//		pt_alloc_init();
//}

void mmgr_init_nx(int print)
{
		/* we have to set bit nxe (11) in the extended feature enable msr */
		/* wich is at c000 0080h and exists if nx || longmode */
		__asm__ volatile (
				"mov $0xc0000080, %%ecx\n"
				"rdmsr\n" /*into edx:eax */
				"or $0x00000800, %%eax\n" /* set bit 11 */
				"wrmsr"
				: : : "%ecx", "%eax", "%edx");
		if (print)
				cprintf(KFMT_INFO, "NX feature is now enabled\n");
		cpu.e_has_nx = 1; /* for the case of lm=1 and nx=0 (nx=1 is arch) */
}

/* VM is only 4GiB and smallest level is the 4KiB page
 *      --> up to 1024*1024 entires/bits
 *      --> use two level structure: 2048 2MiB lvl1
 *                                    512 4KiB lvl0
 *          as in PAE paging (regular is compatible)
 *      --> two bits per entry: 00 np
 *                              01 kernel
 *                              10 user
 *                              11 swap (np but used!, raison d etre)
 *      --> for lvl1: three bits:
 *               000 np     100 hnp <- huge pages
 *               001 kno    101 hkn
 *               010 uso    110 hus
 *               011 mix    111 hsw
 *      --> yields 6192 bits -> 768 bts and 128 bts structures
 *      --> uses up to 256KiB /w full population
 *      Alt: tree avec size ordering start,size AVL
 *  */
/* STACK:
 * allocateVirtualPage(virtual_address) {
 *     lock_free_page_stack();
 *     map_physical_into_virtual(virtual_address, address_of_first_page_on_stack);
 *     address_of_first_page_on_stack = *virtual_address;
 *     unlock_free_page_stack();
 * }
 *
 * freeVirtualPage(virtual_address) {
 *     lock_free_page_stack();
 *     *virtual_address = address_of_first_page_on_stack;
 *     address_of_first_page_on_stack = convert_virtual_to_physical(virtual_address);
 *     unlock_free_page_stack();
 *     set_page_table_entry(virtual_address, 0);
 * }
 * */
struct vmm_lv0
{
		uint32_t bits[16];
};

void mmgr_build_vm_bitmap()
{
		/* first get some memory */
		/*TODO: needed for better VM allocator */
}

void mmgr_init_ap()
{
		/* cli'd */
		/* TODO: theoretically cpuid is per-processor */
		/* variables referenced are identity mapped */
		if (cpu.has_pae) {
				if (cpu.e_has_nx || cpu.e_has_longmode)
						mmgr_init_nx(0);
				__asm__ volatile (
						"mov %%cr4, %%eax\n"
						"or $0x00000020, %%eax\n"
						"mov %%eax, %%cr4\n"
						"mov %0, %%eax\n"
						"mov %%eax, %%cr3\n"
						"mov %%cr0, %%eax\n"
						"or $0x80010000, %%eax\n"
						"mov %%eax, %%cr0\n"
					   	:
					   	:
					   	"r" (&pae_pdp[0]) :
					   	"%eax"
				);
		} else {
				__asm__ volatile (
						"mov %0, %%eax\n"
						"mov %%eax, %%cr3\n"
						"mov %%cr0, %%eax\n"
						"or $0x80010000, %%eax\n"
						"mov %%eax, %%cr0\n"
					   	:
					   	:
					   	"m" (page_directory) :
					   	"%eax"
				);
		}
		/* TODO: per-processor gdt & tss */
}

void mmgr_init_paging()
{
		if (cpu.has_pae) {
				/* enable NX before using mmap */
				if (cpu.e_has_nx || cpu.e_has_longmode) /* 5.13.1 intel _or_ */
						mmgr_init_nx(1);
				//mmgr_init_pd_pae();
				//mmgr_init_pt_pae();
		} else {
				//mmgr_init_pd();
				//mmgr_init_pt();
		}
		mmgr_build_vm_bitmap();
}

const char* elf_get_closest_symbol(void* ptr, size_t* offset);
void print_stacktrace()
{
		struct sf {
				struct sf* prev;
				void* ret_addr;
				void* args[4];
		} __attribute__((packed)) *fp;
		static int stc = 0;
		stc++;
		if (stc == 1) {
print_st:
				/* get ebp into C code */
				__asm__("movl %%ebp, %[fp]" : /* output */ [fp] "=r" (fp));
				/* do the backtrace from ebp to ebp */
				printf("performing stacktrace:\n");
				printf("EBP      ARG-1     ARG-2     ARG-3     ARG-4    FROM\n");
				do {
						size_t of; const char* sym;
						printf("%p %p %p %p %p %p\n", fp, fp->args[0], fp->args[1],
										fp->args[2], fp->args[3], fp->ret_addr);
						sym = (const char*)elf_get_closest_symbol(fp->ret_addr, &of);
						cprintf(KFMT_INFO, "called from %p (%s%+#x)\n", fp->ret_addr, sym, of);
						extern void _start();
						if (fp->ret_addr - 5 == (void*)&_start)
								break; /* only until call to kmain */
						else if (!fp->ret_addr)
								break;
						fp = fp->prev;
				} while (fp);
				framebuffer_redraw(&fb_initial);
		} else
				die("stacktrace loop!\n");
		/* now offer basic diag */
print_help:
		printf("Debug diagnostics mode with following commands:\n"
				"\tdb Address          Dump memory at Address\n"
				"\tr                   Show register contents\n"
				"\tm                   Display symbol map\n"
				"\tk                   Reprint the stack trace\n"
				"\th(elp)              Display this help message\n"
				"\th(a)lt              Turns off the computer\n"
				"\tl Address           Find symbol below/at Address\n");
		framebuffer_redraw(&fb_initial);
		while (1) {
				char* str = 0; size_t n = 0;
				printf("enter command:\n");
				framebuffer_redraw(&fb_initial);
				getline(&str, &n);
				if (str) {
						if (strlen(str))
								str[strlen(str) - 1] = '\0';
						if (strcmp(str, "r") == 0)
								printf("registers: \n");
						else if (strcmp(str, "k") == 0)
								goto print_st;
						else if (strcmp(str, "m") == 0)
								printf("Symbol map: \n");
						else if (strncmp(str, "l ", 2) == 0) {
								long int addr = strtol(str + 2, NULL, 0);
								const char* sym; size_t of;
								sym = (const char*)elf_get_closest_symbol((void*)addr, &of);
								printf("Address is located at %s%+#x\n", sym, of);
						} else if (strncmp(str, "db ", 3) == 0) {
								char* end;
								long int addr = strtol(str + 3, &end, 0), cap = 512;
								if (*end == ' ')
										cap = strtol(end + 1, NULL, 0);
								memdump((void*)addr, cap);
						} else if (strcmp(str, "dpt") == 0) {
								printf("dumping page table\n");
						} else if (strcmp(str, "help") == 0 || strcmp(str, "h") == 0)
								goto print_help;
						else if (strcmp(str, "halt") == 0 || strcmp(str, "hlt") == 0)
								pc_shutdown();
						else
								printf("unknown command \"%s\"\n", str);
						kfree(str);
				}
		}
		stc--;
}

int mmgr_handle_pagefault(void* eip, uint32_t seg_error, void* cr2)
{
		size_t idx;
		struct pde* pd = NULL; struct pae_pde* pdp = NULL;
		if (cpu.has_pae) {
				idx = (size_t)cr2 / 0x200000;
				pdp = pae_pds[(size_t)cr2 / 0x40000000];
				if (pdp)
						pdp += ((size_t)cr2 % 0x40000000) / 0x200000;
		} else {
				idx = (size_t)cr2 / 0x400000;
				pd = page_directory + ((size_t)cr2 / 0x400000);
		}
		/* we have PDE and PT index so let's see */
		if (seg_error & 1) { /* page is present, i.e. protection error */
				struct pte* pt = NULL; struct pae_pte* ptp = NULL;
				const char* errstr = "UNKNOWN"; char is_huge = 0;
				is_huge = (cpu.has_pae ? pdp->s_bit : pd->s_bit);
				/* only check for table on small pages */
				if (!is_huge) {
						ptp = pd_pt_ptr[idx];
						pt = pd_pt_ptr[idx];
						if (!pt) { /* we have to map the page table */
								/*struct page_range pr;
								pr.base = (uint64_t)(pd->pt_ptr * 0x1000);
								pr.count = 1;*/
nomap:
								die("unmapped PT!\n");
						}
						if (cpu.has_pae) {
								ptp += ((size_t)cr2 % 0x200000) / 0x1000;
								/* use common data */
								pt = (struct pte*)ptp;
						} else
								pt += ((size_t)cr2 % 0x400000) / 0x1000;
				}
				/* get the PMEM */
				uint64_t pm;
				if (is_huge)
						if (cpu.has_pae)
								pm = pdp->pt_ptr * 0x1000;
						else
								pm = pd->pt_ptr * 0x1000;
				else
						if (cpu.has_pae)
								pm = ptp->mem_ptr * 0x1000;
						else
								pm = pt->mem_ptr * 0x1000;
				if (seg_error & 8) {
						cprintf(KFMT_ERROR, "Page lookup through %p contained entries"
								" which have reserved bits set. This indicates"
								" either page table corruption or sloppy programming.\n", cr2);
						if (cpu.has_pae) {
								uint32_t hi, lo;
								if (ptp) {
										printf("PTE:  %032b\n", *((uint32_t*)ptp + 1));
										printf("      %032b\n", *(uint32_t*)ptp);
								}
								if (pdp) {
										printf("PDE:  %032b\n", *((uint32_t*)pdp + 1));
										printf("      %032b\n", *(uint32_t*)pdp);
								}
								printf("PDPE: %032b\n", *((uint32_t*)(&pae_pdp[(size_t)cr2 / 0x40000000]) + 1));
								printf("      %032b\n", *(uint32_t*)(&pae_pdp[(size_t)cr2 / 0x40000000]));
								printf("And the extended features MSR reads as:\n");
								__asm__ volatile (
										"mov $0xc0000080, %%ecx\n"
										"rdmsr\n"
										: "=d" (hi), "=a" (lo) : : "%ecx");
								printf("hi:   %032b\n", hi);
								printf("low:  %032b\n", lo);
						} else {
								if (pt)
										printf("PTE: %032b\n", *(uint32_t*)pt);
								if (pd)
										printf("PDE: %032b\n", *(uint32_t*)pd);
						}
						printf("seg_error: %032b\n", seg_error);
				} else {
						if (seg_error & 16) { /* only in PAE */
								if (!is_huge && !ptp->nx_enable)
										errstr = "no execute in the directory";
								else
										errstr = "no execute";
						} else if (seg_error & 4) { /* kernel/user problem */
								if (!is_huge && pt->user_page)
										errstr = "kernel page in the directory";
								else
										errstr = "kernel page";
						} else if (seg_error & 2) { /* write access error */
								if (!is_huge && pt->writable)
										errstr = "read-only in the directory";
								else
										errstr = "read_only";
						}
						cprintf(KFMT_ERROR, "code at %p tried to %s to/from virtual address %p"
							   " but is not allowed to do so as page is marked as %s\n",
							   eip, (seg_error & 2) ? "write" : ((seg_error & 16) ? "fetch instructions": "read"),
							   cr2, errstr);
				}
				printf("The page is %s and present\n", is_huge ? "huge" : "regular");
				printf("it points to physical memory at %#.16llx\n", pm);
				//die("acc violation\n");
				//print_stacktrace();
		} else if (pd || pdp) { /* page is swapped out with ID */
				if ((pdp && pdp->present) || (!pdp && pd->present)) {
						/* swapped on 4k-page level */
						struct pte* pt = pd_pt_ptr[idx];
						struct pae_pte* ptp = pd_pt_ptr[idx];
						if (!pt) {
								cprintf(KFMT_ERROR, "swapped out 4K page but with\n");
								goto nomap;
						}
						if (cpu.has_pae)
								ptp += ((size_t)cr2 % 0x200000) / 0x1000;
						else {
								ptp = NULL;
								pt += ((size_t)cr2 % 0x400000) / 0x1000;
						}
						if ((ptp && ptp->present) || (!ptp && pt->present)) {
								{
										extern struct kio_region kb_reg;
										uint8_t id = 0;
										if (nproc > 1)
												id = smp_processor_id();
										rprintf(&kb_reg, "[%u] TLB fl: %p\n", id, cr2);
								}
								//flush_tlb_single((uint32_t)cr2);
								flush_tlb_full();
								/*while (1);*/
								return 0;
						} else if (*(uint32_t*)pt != 0 || (cpu.has_pae && (*(uint64_t*)ptp != 0))) { /* swap with ID */
								cprintf(KFMT_INFO, "Swapping in single page with id %llu\n",
												cpu.has_pae ? *(uint64_t*)ptp : *(uint32_t*)pt);
								cprintf(KFMT_ERROR, "which is not implemented\n");
								//die("noswap\n");
								//print_stacktrace();
								//while (1);
						} else
								goto rand_acc_err;
				} else { /* complete 4MiB area missing */
						/* TODO: fetch page from file */
						cprintf(KFMT_ERROR, "Encountered a swapped page w/o having implemented swapping\n");
				}
		} else { /* random access into unallocated memory */
rand_acc_err:
				cprintf(KFMT_ERROR, "code at %p erroneously tried to %s to/from virtual address %p"
					   " which is not mapped to any physical memory\n",
					   eip, (seg_error & 2) ? "write" : ((seg_error & 16) ? 
					   "fetch instructions" : "read"), cr2);
				//die("rand_acc\n");
				//print_stacktrace();
		}
		return 1;
}

void mmgr_add_free(uint64_t b, uint64_t s)
{
		if (!s)
				return;
		bzero(&free_mem_map[fm_ofs], sizeof(*free_mem_map));
		free_mem_map[fm_ofs].base = b;
		free_mem_map[fm_ofs++].size = s;
}

/* for providing valid MMIO ranges */
void mmgr_add_reserved(uint64_t b, uint64_t s)
{
		res_mem_map[rm_count].base = b;
		res_mem_map[rm_count++].size = s;
}

/* size alginment */
uint64_t mmio_allocate_range(uint64_t size, int flags)
{
		die("not implemented\n");
		if (flags == 1) { /* ISA */
		} else if (flags == 2) { /* 64-bit */
		} else { /* 32-bit */
		}
		return 0;
}

void mmio_free_range(uint64_t pm, uint64_t s)
{
		die("not implemented\n");
}

/* check for overlap from the BIOS assigments (i.e. in real memory) */
int mmio_check_range(uint64_t b, uint64_t s)
{
		size_t i;
		for (i = 0; i < fm_ofs; i++)
				if (b + s > free_mem_map[i].base &&
					free_mem_map[i].base + free_mem_map[i].size > b)
						return -1;
		for (i = 0; i < rm_count; i++)
				if (b + s > res_mem_map[i].base &&
					res_mem_map[i].base + res_mem_map[i].size > b)
						return -1;
		return 0;
}

void mmgr_sub_block(uint64_t b, uint64_t s)
{
		size_t ofs;
		if (!s)
				return;
		/* search for conflicting entries */
		for (ofs = 0; ofs < fm_ofs; ofs++)
				if ((b + s > free_mem_map[ofs].base)
					&& (b < free_mem_map[ofs].base + free_mem_map[ofs].size)) {
						if (b <= free_mem_map[ofs].base) {
								/* overlap below */
								if (b + s >= free_mem_map[ofs].base + free_mem_map[ofs].size) {
										/* complete overlap */
										if (ofs + 1 < fm_ofs) {
												free_mem_map[ofs--] = free_mem_map[--fm_ofs];
												free_mem_map[fm_ofs].base = 0;
												free_mem_map[fm_ofs].size = 0;
										} else
												break;
								} else {
										/* only reduce size */
										free_mem_map[ofs].size = free_mem_map[ofs].base + free_mem_map[ofs].size - (b + s);
										free_mem_map[ofs].base = b + s;
								}
						} else if (b + s >= free_mem_map[ofs].base + free_mem_map[ofs].size) {
								/* overlap on top end */
								free_mem_map[ofs].size = b - free_mem_map[ofs].base;
						} else {
								/* overlap in center */
								free_mem_map[fm_ofs].base = b + s;
								free_mem_map[fm_ofs++].size = (free_mem_map[ofs].base + free_mem_map[ofs].size) - (b + s);
								free_mem_map[ofs].size = b - free_mem_map[ofs].base;
						}
				}
}

void mmgr_sort_and_merge()
{
		size_t n = fm_ofs, i; int new_n;
		/* bubble sort */
		do {
				new_n = 1;
				for (i = 0; i < n - 1; i++) {
						if (free_mem_map[i].base > free_mem_map[i + 1].base) {
								struct fme fm = free_mem_map[i + 1];
								free_mem_map[i + 1] = free_mem_map[i];
								free_mem_map[i] = fm;
								new_n = i + 1;
						}
				}
				n = new_n;
		} while (n > 1);
		/* do the same with the reserved entries */
		do {
				new_n = 1;
				for (i = 0; i < n; i++) {
						if (res_mem_map[i].base > res_mem_map[i + 1].base) {
								struct rme rm = res_mem_map[i + 1];
								res_mem_map[i + 1] = res_mem_map[i];
								res_mem_map[i] = rm;
								new_n = i + 1;
						}
				}
		} while (n > 1);

		/* merge adjacent elements */
		for (i = 0; i < fm_ofs - 1; i++)
				if (free_mem_map[i].base + free_mem_map[i].size >= free_mem_map[i + 1].base) {
						free_mem_map[i].size = (free_mem_map[i + 1].base + free_mem_map[i + 1].size) - free_mem_map[i].base;
						if (i + 1 < fm_ofs) {
								size_t n;
								for (n = i + 1; n < fm_ofs - 1; n++)
										free_mem_map[n] = free_mem_map[n + 1];
						}
						fm_ofs--;
						free_mem_map[fm_ofs].base = 0;
						free_mem_map[fm_ofs].size = 0;
				}
}

const char* get_map_str(uint32_t v)
{
		switch (v) {
				case 1: return "Free memory";
				case 2: return "Reserved memory";
				case 3: return "ACPI reclaimable memory";
				case 4: return "ACPI NVS area";
				case 5: return "Bad memory";
				default: return "Unknown area";
		}
};

struct pmu* mmgr_initial_pmu(uint16_t page_ct);
struct pmu* mmgr_initial_rcp(uint16_t page_ct);

void pmu_dump(struct pmu* pu, int level)
{
		size_t i, ne; uint32_t* lv;
		if (level >= 0 && level <= 7) {
				if (level == 0)
						(lv = pu->lvl0), ne = 128;
				else if (level == 1)
						(lv = pu->lvl1), ne = 64;
				else if (level == 2)
						(lv = pu->lvl2), ne = 32;
				else if (level == 3)
						(lv = pu->lvl3), ne = 16;
				else if (level == 4)
						(lv = pu->lvl4), ne = 8;
				else if (level == 5)
						(lv = pu->lvl5), ne = 4;
				else if (level == 6)
						(lv = pu->lvl6), ne = 2;
				else
						(lv = &pu->lvl7), ne = 1;
		} else
				return;
		printf("pmu/rcp (at %p) lvl%d entries:\n", pu, level);
		for (i = 0; i < ne; i += 6) {
				if (ne - i >= 6) {
						printf("%08x %08x %08x %08x %08x %08x\n",
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
						lv += 6;
				} else {
						size_t j;
						for (j = 0; j < ne - i; j++)
								printf("%08x ", lv[j]);
						putchar('\n');
				}
		}
}
void mmgr_dump_pmu(size_t fm, size_t n, int is_rcp)
{
		struct pmu* pu;
		if (is_rcp == 2) {
				/* user talk */
				printf("Free mem map contains %u entries\n", fm_ofs);
				printf("Enumerating maps:\n");
				for (n = 0; n < fm_ofs; n++) {
						size_t cr = 0, cu = 0;
						struct pmu* pu;
						printf("Map %u: %016llx-%016llx\n", n,
								free_mem_map[n].base,
								free_mem_map[n].base + free_mem_map[n].size);
						pu = free_mem_map[n].pmu;
						do cu++; while (pu && (pu = pu->pmu_next));
						pu = free_mem_map[n].rcp;
						do cr++; while (pu && (pu = pu->pmu_next));
						printf("\tPMU count: %u\n", cu);
						printf("\tRCP count: %u\n", cr);
				}
				return;
		}
		if (fm > fm_ofs) {
				printf("FM out of range\n");
				return;
		}
		printf("FM %u: free=%u, reclaimable=%u\n", fm,
						(uint32_t)free_mem_map[fm].free_pages,
						(uint32_t)free_mem_map[fm].reclaimable_pages);
		if (is_rcp)
				pu = free_mem_map[fm].rcp;
		else
				pu = free_mem_map[fm].pmu;
		while (pu) {
				if (--n == 0) {
						pmu_dump(pu, 0);
						if (is_rcp)
								pmu_dump(pu, 2);
						return;
				} else
						pu = pu->pmu_next;
		}
		printf("PMU index out of range\n");
}

/* the only function which needs exclusive access */
void pmu_set_range(struct pmu* pm, uint16_t start, uint16_t end, int unset, int is_rcp)
{
		void psr(uint32_t* lv, uint16_t div) {
				size_t i, j;
				for (i = start / div; i <= end / div; i++) {
						if ((i * div - start >= div) && (end - i * div >= div)) {
								lv[i] = unset ? 0 : 0xffffffff;
								continue;
						}
						for (j = 0; j < 32; j++) {
								uint16_t pos = i * div + j * div / 32;
								if (pos < start)
										continue;
								else if (pos > end)
										break;
								if (unset)
										lv[i] &= ~(1 << j);
								else
										lv[i] |= (1 << j);
						}
				}
		}
		mbprintf("set_range(%u, %u, %d, %d)\n", start, end, unset, is_rcp);
		psr(pm->lvl0, 32);
		if (!is_rcp)
				psr(pm->lvl1, 64);
		psr(pm->lvl2, 128);
		if (!is_rcp) {
				psr(pm->lvl3, 256);
				psr(pm->lvl4, 512);
				psr(pm->lvl5, 1024);
				psr(pm->lvl6, 2048);
		}
		psr(&pm->lvl7, 4096);
}

void pmu_update_buddies(struct pmu* pu)
{
		void sfn(uint32_t* l0, uint32_t* l1, size_t ct)
		{
				size_t i, j;
				/*printf("cmp from %p to %p for %u values\n", l0, l1, ct);*/
				for (i = 0; i < ct; i++) {
						uint64_t vl = l0[i * 2] | ((uint64_t)l0[i * 2 + 1] << 32);
						uint64_t hg = vl & 0xaaaaaaaaaaaaaaaa;
						uint64_t lw = vl & 0x5555555555555555;
						uint32_t val = 0;
						vl = (hg >> 1) | lw; /* mark as used if eiher one is set */
						/*printf("%08x%08x %08x%08x -> ", hg, lw);*/
						/* now get 32 values out of it 01010101 -> 1111 */
						for (j = 0; j < 32; j++)
								val |= ((uint32_t)(vl >> j) & (1 << j));
						/*cprintf(KFMT_INFO, "%08x\n", val);*/
						l1[i] = val;
				}
		}
		sfn(pu->lvl0, pu->lvl1, 64);
		sfn(pu->lvl1, pu->lvl2, 32);
		sfn(pu->lvl2, pu->lvl3, 16);
		sfn(pu->lvl3, pu->lvl4, 8);
		sfn(pu->lvl4, pu->lvl5, 4);
		sfn(pu->lvl5, pu->lvl6, 2);
		sfn(pu->lvl6, &pu->lvl7, 1);
}

size_t mmgr_entry_get_pages(struct fme* fm, struct page_range* dst, size_t pr_ct, size_t num_pages, int flg)
{
		uint64_t ofs = fm->base, rem = fm->size, limit = 0;
		struct pmu* pu = fm->pmu; int cont = !!(flg & MMGR_ALLOC_CONTIGUOUS);
		struct pmu* rc = fm->rcp;
		size_t np = 0; 
		mbprintf("entry_get_pages(%d, %d, %d)\n", pr_ct, num_pages, cont);
		mbprintf("pr_ct=%d\n", pr_ct);
Pos1:
		if (!pu || !rc) {
				uint16_t pc = fm->size / 4096;
				if (pc > 4096)
						pc = 4096;
				if (!pu) {
						pu = fm->pmu = mmgr_initial_pmu(4096);
						mbprintf("assigned PMU at %p to FM with base %p\n", pu, (void*)(size_t)ofs);
				}
				if (!rc)
						rc = fm->rcp = mmgr_initial_rcp(pc);
		}
		/* lazy sanity check (don't allocate more than 32MiB contigously) */
		if (num_pages > 4096 && cont)
				return 0;
		/* only look for use=0 pages (present & clean) */
		do {
				/* check offset */
				if (flg & (MMGR_ALLOC_32_BIT | MMGR_ALLOC_ISA)) {
						if (flg & MMGR_ALLOC_ISA) {
							if (ofs >= 0x100000)
									break;
							limit = 0x100000;
						} else {
								if (ofs >= 0x100000000ull)
										break;
								limit = 0x100000000ull;
						}
				}
				if (cont) {
						uint32_t* lv = NULL; size_t lvl = 0, lv0r = 0;
						size_t elem_ct = 0, i, j, nc = 0;

						uint32_t* ptrs[] = {
								pu->lvl0, pu->lvl1, pu->lvl2, pu->lvl3,
								pu->lvl4, pu->lvl5, pu->lvl6, &pu->lvl7
						};

						/* calculate the level and the pages-per-bit */
						size_t lev = bsr(num_pages), ppb;
						if (lev > 8)
								lev = 8;
						ppb = (1 << (lev - 1));
						lvl = num_pages / ppb;
						lv0r = num_pages % ppb;
						/* set the upper-level pointer lv */
						lv = ptrs[lev - 1];
						/* and the number of elements in each array */
						elem_ct = (256 >> lev); /* 1 for lvl7, 128 for lvl0 */

						mbprintf("cont: np=%u lvl=%d, lv0r=%d, elem_ct=%d lev=%u ppb=%u\n",
								num_pages, lvl, lv0r, elem_ct, lev, ppb);
						mbprintf("checking %d values of pmu at %p:\n", elem_ct, pu);
#ifdef MEMBABBLE
						for (i = 0; i < elem_ct; i++) {
								printf((i % 8 == 7) ? "%08x\n" : "%08x ", lv[i]);
						}
						printf("\n");
#endif
						for (i = 0; i < elem_ct; i++) {
								for (j = 0; j < 32; j++) {
										if (!((1 << j) & lv[i]))
												nc++;
										else
												nc = 0;
										/* enough upper level cont. */
										if (nc == lvl) {
												uint16_t b, e;
												size_t k, l, div = ppb;
												/* almost done, check the end */
												b = i * div * 32 + j * div;
												if (!lv0r)
														goto done;
												e = b + lv0r - 1; /* inclusive -> 4095 max */
												mbprintf("end-check: b=%d, e=%d, div=%d\n", b, e, div);
												for (k = b / 32; k <= e / 32; k++)
														for (l = 0; l < 32; l++) {
																uint16_t pos = k * 32 + l;
																if (pos < b)
																		continue;
																if ((pu->lvl0[k] & (1 << l)) != 0) {
																		/* blocked so look for sth new. */
																		nc = 0;
																		k = 128; /* guranteed exit */
																		break;
																} else if (pos == e) { /* free until e -> we're done */
																		k = 128;
																		break;
																}
														}
done:
												if (nc) {
														/* search was successful */
														mbprintf("success: nc=%d, b_old=%d, e=%d, i=%d, j=%d, div=%d\n", nc, b, e, i, j, div);
														b -= (nc - 1) * div;
														e = b + nc * div + lv0r - 1;
														dst->base = ofs + b * 4096;
														dst->count = (e - b) + 1;
														/* check for limit */
														if (limit) {
																if (dst->base >= limit) {
																		dst->count = 0;
																		return 0;
																} else if (dst->base + 4096 * dst->count > limit) {
																		dst->count = (limit - dst->base) / 4096;
																		e = b + dst->count - 1;
																}
														}
														mbprintf("set_range(%d, %d)\n", b, e);
														pmu_set_range(pu, b, e, 0, 0);
														if (pr_ct > 1) /* null-terminate if wanted */
																dst[1].count = 0;
														fm->free_pages -= (e - b + 1);
														return e - b + 1;
												}
										}
								}
						}
				} else {
						size_t i, j, nc = 0, ob = 0;
						/*pmu_dump(pu, 0);-------------------------------*/
						for (i = 0; i < 128; i++) {
								for (j = 0; j < 32; j++) {
										if ((pu->lvl0[i] & (1 << j)) == 0) {
												nc++; np++;
												if (nc == 1)
														ob = i * 32 + j;
										} else if (nc) {
												/* commit previous pages */
												goto PosComm;
										}
										if (np == num_pages) {
												int exit;
PosComm:
												exit = 0;
												dst->count = nc;
												dst->base = ofs + ob * 4096;
												if (limit) {
														if (dst->base >= limit) {
																dst->count = 0;
																fm->free_pages -= np;
																return np;
														} else if (dst->base + 4096 * dst->count > limit) {
																dst->count = (limit - dst->base) / 4096;
																nc = dst->count;
																exit = 1;
														}
												}
												mbprintf("set_range(%d, %d)\n", ob, ob + nc - 1);
												pmu_set_range(pu, ob, ob + nc - 1, 0, 0);
												dst++; pr_ct--;
												if (!pr_ct) /* no more space left so return what we have */ {
														fm->free_pages -= np;
														return np;
												}
												nc = 0;
												if ((np == num_pages) || exit) {
														fm->free_pages -= np;
														/* null terminate */
														if (pr_ct)
																dst[1].count = 0;
														return np; /* everything allocated */
												}
										}
								}
						}
				}
				/* advance to the next one */
				pu = pu->pmu_next;
				rc = rc->pmu_next;
				ofs += 4096 * 4096;
				if (rem >= 4096 * 4096)
						rem -= 4096 * 4096;
				else
						break; /* we're in the last pmu */
				if (!pu || !rc)
						goto Pos1;
		} while (rem);
		fm->free_pages -= np;
		return np;
}

size_t mmgr_scrub_pages(size_t idx, size_t limit);
size_t mmgr_pmem_allocate(struct page_range* dst, size_t pr_ct, size_t num_pages, int flags)
{
		size_t i, na = 0, prO = 0; int no_free_left = 0, contiguous = !!(flags & MMGR_ALLOC_CONTIGUOUS);
		mbprintf("pmem_allocate(%d, %d, %s)\n", pr_ct, num_pages, contiguous ? "cont" : "nc");
		for (i = 0; i < pr_ct; i++)
				dst[i].count = 0;
Pos0:
		for (i = fm_begin; i < fm_ofs; i++) {
				struct fme* fm;
				fm = free_mem_map + i;
				if (flags & (MMGR_ALLOC_32_BIT | MMGR_ALLOC_ISA)) {
						/* restrictions apply */
						if (flags & MMGR_ALLOC_ISA) {
								if (fm->base >= 0x100000)
										continue;
						} else if (fm->base >= 0x100000000ull)
								continue;
				}
				mbprintf("FM %d: free=%d recl=%d\n", i, (size_t)fm->free_pages, (size_t)fm->reclaimable_pages);
				if (contiguous && fm->free_pages <= num_pages) {
						if (no_free_left && fm->reclaimable_pages >= num_pages) {
								size_t ns;
								/* scrub NOW and check */
								if (no_free_left == 2)
										mbprintf("scrubbing without limit in entry %d\n", i);
								else
										mbprintf("scrubbing a limited anmout of pages in entry %d\n", i);
								ns = mmgr_scrub_pages(i, num_pages * 2);
								mbprintf("%d pages scrubbed\n", ns);
								goto Pos2;
						}
						if (i + 1 >= fm_ofs) {
								printf("no free pages found\nin-place scrubbing now enabled\n");
								if (no_free_left == 2) {
										printf("no contiguous memory available\n");
										return 0; /* no contiguous memory av. */
								} else if (no_free_left == 1)
							  			no_free_left = 2; /* now enable limitless scrubbing */
								else {
										no_free_left = 1;
										i = fm_begin;
										goto Pos0;
								}
						}
						continue;
				}
				if (fm->free_pages) {
Pos2:
						mbprintf("%u free pages found in FM %u\n", (size_t)fm->free_pages, i);
						mbprintf("with pmu at %p\n", fm->pmu);
						na += mmgr_entry_get_pages(fm, dst + prO, pr_ct - prO, num_pages - na, flags);
						while ((prO < pr_ct) && dst[prO].count)
								prO++;
						if ((na == num_pages) || (prO == pr_ct)) {
								return na;
						}
				} else if (no_free_left && fm->reclaimable_pages) {
						/* scrub pages NOW */
						mmgr_scrub_pages(i, num_pages);
						goto Pos2;
				} else if (i + 1 == fm_ofs && !no_free_left) {
						mbprintf("no free pages found\nin-place scrubbing now enabled\n");
						no_free_left = 1;
						i = fm_begin;
						goto Pos0;
				}
		}
		cprintf(KFMT_WARN, "No free or reclaimable pages\n");
		printf("dumping PMUs:\n");
		for (i = 0; i < fm_ofs; i++) {
				struct pmu* pu = free_mem_map[i].pmu;
				size_t ct = 1;
				if (i < fm_begin)
						printf("information only:\n");
				printf("FM %u pmu=%p rcp=%p\n", i, pu, free_mem_map[i].rcp);
				if(pu) {
						do {
								printf("FM %u PMU %u:\n", i, ct++);
								pmu_dump(pu, 0);
						} while ((pu = pu->pmu_next));
				} else
						printf("free_mem_map %u has no PMU!\n", i);
		}
		return 0;
}
/* :copen for clang errors preventing completion */

/* marks the pages for scrubbing which will do the real deallocating */
void mmgr_pmem_free(struct page_range* prs, size_t pr_ct)
{
		size_t i;
		for (i = 0; i < pr_ct; i++) {
				struct fme* fm; struct pmu *pu, *rc;
				uint64_t ofs;
				for (fm = free_mem_map + fm_begin; fm < free_mem_map + fm_ofs; fm++)
						if (prs->base >= fm->base && prs->base < fm->base + fm->size)
								break; /* just assume integrity */
				ofs = fm->base;
				pu = fm->pmu;
				rc = fm->rcp;
				do {
						if (prs->base < ofs + 4096 * 4096 &&
							prs->base + 4096 * prs->count > ofs) {
								/* some overlap */
								uint16_t s, e;
								s = (prs->base <= ofs) ? 0 : ((prs->base - ofs) / 4096);
								e = (prs->base + 4096 * prs->count >= ofs + 4096 * 4096) ? 4096
									   	: ((prs->base + 4096 * prs->count - ofs) / 4096);
								pmu_set_range(rc, s, e, 0, 1);
								fm->reclaimable_pages += (e - s) + 1;
						}
						/* advance in list */
						pu = pu->pmu_next;
						rc = rc->pmu_next; /* rc always >= pu */
						ofs += 4096 * 4096;
				} while (pu);
		}
}

void* mmgr_res_vmptr(size_t pg_ct)
{
		void* rv;
		/* TODO: QnD currently avaiable 1<x<a0 */
		static void* qnd_base = (void*)0x01000000;
		rv = qnd_base;
		qnd_base += pg_ct * 4096;
		if (qnd_base >= (void*)0xa0000000) {
				die("out of virtual memory slots!\n");
		}
		return rv;
}

void* mmio_get_vmem(size_t pg_ct)
{
		void* rv; extern void* bp_apic_base;
		static void* mmio_base = (void*)0xe0000000;
		rv = __sync_fetch_and_add(&mmio_base, pg_ct * 4096);
		if (rv + pg_ct * 4096 > bp_apic_base) {
				die("out of virtual memory for MMIO!\n");
		}
		return rv;
}

char mmgr_check_pd_present(size_t i)
{
		char is_present = 0;
		if (cpu.has_pae) {
				/* check for existence of PD first */
				if (pae_pds[i / 512])
						is_present = pae_pds[i / 512][i % 512].present;
				else if (pae_pdp[i / 512].pd_ptr) {
						/* somehow not mapped */
						cprintf(KFMT_ERROR, "Encountered unmapped PAE PD\n");
						while (1);
				} else { /* allocate new PD table */
						/* TODO: possible user page range */
						size_t j;
						pae_pds[i / 512] = fixed_allocator;
						bzero(fixed_allocator, 4096);
						fixed_next();
						for (j = 0; j < 512; j++)
								pae_pds[i / 512][j].present = 0;
						/* set PDPTE */
						*(uint64_t*)&pae_pdp[i / 512] = 0;
						pae_pdp[i / 512].pd_ptr = (uint64_t)(size_t)pae_pds[i / 512] / 0x1000;
						pae_pdp[i / 512].present = 1;
						/* we have to reload cr3 */
						__asm__ volatile (
										"mov %%cr3, %%eax\n"
										"mov %%eax, %%cr3"
										: : : "%eax");
				}
		} else
				is_present = page_directory[i].present;
		return is_present;
}

void* mmgr_map_pmem(void* virt_address, const struct page_range* prs, size_t pr_ct, int flags)
{
		size_t pg_ct = 0, pg_mp = 0;
		size_t i; int commit = flags & MMGR_MAP_ALLOW_REMAP;
		size_t pd_ofs, pd_end; size_t pr_pc = prs->count; uint64_t pr_bs = prs->base;
		void* endptr;

		/* calculate the number of consecutive virtual pages needed */
		for (i = 0; i < pr_ct; i++)
				if (prs[i].count)
						pg_ct += prs[i].count;
				else {
						pr_ct = i;
						break;
				}
		if (!virt_address) {
				/* we have to find a free spot automatically */
				if (flags & MMGR_MAP_MMIO)
						virt_address = mmio_get_vmem(pg_ct);
				else
						virt_address = mmgr_res_vmptr(pg_ct);
		}
		/* get the number of page tables to access */
		endptr = virt_address - 1 + pg_ct * 0x1000; /* -1 protects against overflow */
		pd_ofs = (size_t)virt_address / ((cpu.has_pae ? 512 : 1024) * 4096);
		pd_end = (size_t)endptr / ((cpu.has_pae ? 512 : 1024) * 4096);
		if ((size_t)virt_address != 0xfffff000)
				mbprintf("%smap_pmem(%p, pg_ct=%d, endptr=%p, pd_ofs=%d)\n",
								flags & MMGR_MAP_ALLOW_REMAP ? "re" : "",
							 	virt_address, pg_ct, endptr, pd_ofs);

uint32_t b, e;
Pos1:
		for (i = pd_ofs; i <= pd_end; i++) {
				char is_present = mmgr_check_pd_present(i);
				if (is_present) {
						uint32_t /*b, e,*/ j;
						struct pte* pt; struct pae_pte* ptp;
Pos2:
						ptp = NULL;
						/* get offset into page table */
						if (i == pd_ofs)
								b = ((size_t)virt_address % (1024 * (cpu.has_pae ? 2048 : 4096))) / 4096;
						else
								b = 0;
						if (i == pd_end)
								e = ((size_t)endptr % (1024 * (cpu.has_pae ? 2048 : 4096))) / 4096;
						else
								e = (cpu.has_pae ? 511 : 1023);
						/* no identity mapping (lookup table used) */
						pt = (struct pte*)pd_pt_ptr[i];
						if (cpu.has_pae)
								ptp = (struct pae_pte*)pd_pt_ptr[i];
						if (!pt) {
								/* PT currently not mapped */
								cprintf(KFMT_ERROR, "PT %u currently not mapped\n", i);
								while (1);
						}
						/* j is bound from 0 to 1023 or 511(PAE) */
						for (j = b; j <= e; j++) {
								if (((ptp && ptp[j].present) || (!ptp && pt[j].present)) && !commit) {
										/* there's already sth. here */
										if (!(flags & MMGR_MAP_ALLOW_REMAP))
												return NULL;
								}
								if (!commit)
										continue;
								if (ptp) {
										ptp[j].g_bit = ((flags & MMGR_MAP_GLOBAL) != 0);
										ptp[j].mem_accessed = 0; /* on remap always purge */
										ptp[j].mem_write = 0;
										ptp[j].no_cache = ((flags & MMGR_MAP_NO_CACHING) != 0);
										ptp[j].writable = ((flags & MMGR_MAP_WRITE) != 0);
										ptp[j].wt_cache = ((flags & MMGR_MAP_WRITE_THROUGH) != 0);
										if (cpu.e_has_nx && !(flags & MMGR_MAP_EXECUTE))
												ptp[j].nx_enable = 1; /* use nx bit */
										/*TEST: ALL USER PAGES */
										ptp[j].user_page = 1;
										/*ptp[j].user_page = !(flags & MMGR_MAP_KERNEL);*/
										ptp[j].user = 0;
										ptp[j].mem_ptr = pr_bs / 0x1000;
										ptp[j].present = 1;
								} else {
										pt[j].g_bit = ((flags & MMGR_MAP_GLOBAL) != 0);
										pt[j].mem_accessed = 0; /* on remap always purge */
										pt[j].mem_write = 0;
										pt[j].no_cache = ((flags & MMGR_MAP_NO_CACHING) != 0);
										pt[j].writable = ((flags & MMGR_MAP_WRITE) != 0);
										pt[j].wt_cache = ((flags & MMGR_MAP_WRITE_THROUGH) != 0);
										/*TEST: ALL USER PAGES */
										pt[j].user_page = 1;
										/*pt[j].user_page = !(flags & MMGR_MAP_KERNEL);*/
										pt[j].user = 0;
										pt[j].mem_ptr = pr_bs / 0x1000;
										pt[j].present = 1;
								}
								pg_mp++;
								if (--pr_pc == 0) {
										prs++;
										if (--pr_ct) {
												pr_pc = prs->count;
												pr_bs = prs->base;
										}
										if (!pr_ct || !pr_bs || !pr_pc) {
												void* ptr = virt_address + 0x1000 * pg_ct;
												void* ptr2;
												/* done with the mapping */
												/* NOW flush the tlb and return */
												for (ptr2 = virt_address; ptr2 != ptr; ptr2 += 0x1000)
														flush_tlb_single((uint32_t)ptr2);
												return virt_address;
										}
								} else
										pr_bs += 4096;
						}
				} else if (!commit)
						continue; /* everything available so continue up to commit */
				else { /* allocate and fill new PT */
						uint64_t pt_pm; void* pt_ptr;
						mbprintf("Getting a new page table (i=%u)...\n", i);
						pt_ptr = pt_allocate(&pt_pm); /* maps to rv */
						if (!pt_ptr) {
								cprintf(KFMT_ERROR, "MMGR unable to allocate page for holding page table\n");
								while (1);
						}
						mbprintf("pgt at %p mapped to %p\n", (void*)(size_t)pt_pm, pt_ptr);
						if (cpu.has_pae) {
								/* PD existence is guranteed */
								*(uint64_t*)(pae_pds[i / 512] + (i % 512)) = 0;
								pae_pds[i / 512][i % 512].pt_ptr = (pt_pm) / 0x1000;
								pae_pds[i / 512][i % 512].present = 1;
								pae_pds[i / 512][i % 512].writable = 1;
								/* TEST: ALL USER PAGES */
								pae_pds[i / 512][i % 512].user_page = 1;
						} else {
								*(uint32_t*)(page_directory + i) = 0;
								page_directory[i].pt_ptr = (pt_pm) / 0x1000;
								page_directory[i].present = 1;
								/* MARK the entry most permissive in the directory */
								/* TODO: maybe group rw-accesses in mapping for unprescribed VM */
								/* also group user pages */
								page_directory[i].writable = 1;
								/* TEST: ALL USER PAGES (subtractive) */
								page_directory[i].user_page = 1;
						}
						pd_pt_ptr[i] = pt_ptr;
						goto Pos2;
				}
		}
		commit++;
		if (commit > 1) {
				cprintf(KFMT_WARN, "loop more than once?\n");
				printf("virtual address: %p\n", virt_address);
				printf("page table range: %u to %u\n", pd_ofs, pd_end);
				printf("page count: %u\n", pg_ct);
				printf("valid physical page-ranges: %u\n", pr_ct);
				printf("pages left in current range: %u\n", pr_pc);
				printf("dumping page-ranges:\n");
				for (i = 0; i < pr_ct; i++)
						printf("%016llx %u\n", prs[i].base, prs[i].count);
				printf("pages already allocated: %u\n", pg_mp);
				printf("pages remaining: %u\n", pg_ct - pg_mp);
				printf("b=%u e=%u\n", b, e);
		}
		goto Pos1;

		/* not reachable */
		return NULL;
}

/* only work on PT level */
void mmgr_protect_mem(void* virt_address, size_t num_pages, int flags)
{
		if ((size_t)virt_address % 4096)
				virt_address -= (size_t)virt_address % 4096;
		while (num_pages) {
				size_t pd_ofs; uint16_t b;
				if (cpu.has_pae) {
						pd_ofs = (size_t)virt_address / (512 * 4096);
						b = ((size_t)virt_address % (512 * 4096)) / 4096;
				} else {
						pd_ofs = (size_t)virt_address / (1024 * 4096);
						b = ((size_t)virt_address % (1024 * 4096)) / 4096;
				}
				/* check and ensure page directory presence */
				if (mmgr_check_pd_present(pd_ofs)) {
						struct pte* pt = NULL;
						pt = pd_pt_ptr[pd_ofs];
						if (!pt) {
								/* not mapped or not there? */
								cprintf(KFMT_ERROR, "PT %u currently not mapped\n", pd_ofs);
								while (1);
						} else {
								/* select entry [b] */
								if (cpu.has_pae) /* only access common entries */
										pt = (struct pte*)((struct pae_pte*)pd_pt_ptr[pd_ofs] + b);
								else
										pt += b;
						}
						mbprintf("protect: pt(p)=%p\n", pt);
						if (pt->present) {
								/* change the flags and flush the tlb */
								if (flags & MMGR_MAP_PURGE_ACC)
										pt->mem_accessed = 0;
								if (flags & MMGR_MAP_PURGE_DIRTY)
										pt->mem_write = 0;
								if (flags & MMGR_MAP_SET) {
										if (flags & MMGR_MAP_GLOBAL)
												pt->g_bit = 1;
										if (flags & MMGR_MAP_NO_CACHING)
												pt->no_cache = 1;
										if (flags & MMGR_MAP_WRITE)
												pt->writable = 1;
										if (flags & MMGR_MAP_WRITE_THROUGH)
												pt->wt_cache = 1;
										if (flags & MMGR_MAP_KERNEL)
												pt->user_page = 1; /* TEST: ALL USER PAGES */
										if (flags & MMGR_MAP_EXECUTE)
												if (cpu.has_pae && cpu.e_has_nx) {
														/* nx bit exists so use it */
														((struct pae_pte*)pt)->nx_enable = 0;
												}
								} else if (flags & MMGR_MAP_UNSET) {
										if (flags & MMGR_MAP_GLOBAL)
												pt->g_bit = 0;
										if (flags & MMGR_MAP_NO_CACHING)
												pt->no_cache = 0;
										if (flags & MMGR_MAP_WRITE)
												pt->writable = 0;
										if (flags & MMGR_MAP_WRITE_THROUGH)
												pt->wt_cache = 0;
										if (flags & MMGR_MAP_KERNEL)
												pt->user_page = 1;
										if (flags & MMGR_MAP_EXECUTE)
												if (cpu.has_pae && cpu.e_has_nx) {
														/* nx bit exists so use it */
														((struct pae_pte*)pt)->nx_enable = 1;
												}
								} else {
										pt->g_bit = ((flags & MMGR_MAP_GLOBAL) != 0);
										pt->no_cache = ((flags & MMGR_MAP_NO_CACHING) != 0);
										pt->writable = ((flags & MMGR_MAP_WRITE) != 0);
										pt->wt_cache = ((flags & MMGR_MAP_WRITE_THROUGH) != 0);
										/*pt->user_page = !(flags & MMGR_MAP_KERNEL);*/
										pt->user_page = 1; /* TEST: ALL USER PAGES */
								}
								flush_tlb_single((uint32_t)virt_address);
								// TODO: tlb_post_shoodown if global change
						}
				}
				num_pages--;
				virt_address += 4096;
		}
}

uint64_t mmgr_page_get_pmem(void* ptr, void** pp_pte)
{
		size_t pd_ofs; uint16_t b;
		if (cpu.has_pae) {
				pd_ofs = (size_t)ptr / (512 * 4096);
				b = ((size_t)ptr % (512 * 4096)) / 4096;
		} else {
				pd_ofs = (size_t)ptr / (1024 * 4096);
				b = ((size_t)ptr % (1024 * 4096)) / 4096;
		}

		if (mmgr_check_pd_present(pd_ofs)) {
				struct pte* pt; struct pae_pte* ptp;
				/* we use the lookup table */
				pt = pd_pt_ptr[pd_ofs];
				ptp = pd_pt_ptr[pd_ofs];
				if (pt[b].present) {
						if (pp_pte)
								*pp_pte = (cpu.has_pae ? (void*)(ptp + b) : (void*)(pt + b));
						return (uint64_t)(cpu.has_pae ? ptp[b].mem_ptr : pt[b].mem_ptr) * 0x1000;
				} else
						return -1;
		} else
				return -1;
		return -1; /* for the compiler */
}

void mmgr_unmap_pmem(void* ptr, size_t num_pages)
{
		size_t pd_ofs, pd_end, i; void* endptr;
		if (!ptr) /* don't unmap 0 */
				return;
		/* page align */
		if ((size_t)ptr % 4096)
				ptr -= (size_t)ptr % 4096;
		endptr = ptr - 1 + num_pages * 0x1000; /* -1 protects against overflow */
		pd_ofs = (size_t)ptr / ((cpu.has_pae ? 512 : 1024) * 4096);
		pd_end = (size_t)endptr / ((cpu.has_pae ? 512 : 1024) * 4096);

		for (i = pd_ofs; i <= pd_end; i++) {
				if (mmgr_check_pd_present(i)) {
						/* TODO: Add huge page support */
						uint32_t b, e, j;
						struct pte* pt; struct pae_pte* ptp = NULL;

						if (i == pd_ofs)
								b = ((size_t)ptr % (1024 * (cpu.has_pae ? 2048 : 4096))) / 4096;
						else
								b = 0;
						if (i == pd_end)
								e = ((size_t)endptr % (1024 * (cpu.has_pae ? 2048 : 4096))) / 4096;
						else
								e = (cpu.has_pae ? 511 : 1023);
						/* no identity mapping (use lookup table) */
						pt = pd_pt_ptr[i];
						if (cpu.has_pae)
								ptp = pd_pt_ptr[i];
						if (!pt) {
								/* we have to map the PT */
								cprintf(KFMT_ERROR, "PT %u currently not mapped\n", i);
								while (1);
						}
						for (j = b; j <= e; j++) {
								if ((ptp && !ptp[j].present) || (!ptp && !pt[j].present)) {
										cprintf(KFMT_WARN, "Warning: tried to unmap nonpresent virtual memory\n");
										return;
								}
								/* don't leak info */
								if (ptp)
										*((uint64_t*)ptp + j) = 0;
								else
										*((uint32_t*)pt + j) = 0;
						}
				} else {/* don't unmap sth. which is not there */
						cprintf(KFMT_WARN, "Warning: tried to unmap nonpresent virtual memory\n");
						return;
				}
		}

		/* flush TLB */
		{
				void* ptr2 = ptr;
				ptr += num_pages * 4096;
				for (; ptr2 != ptr; ptr2 += 0x1000)
						flush_tlb_single((uint32_t)ptr2);
				// TODO: tlb_post_shootdown(); if global
		}
}

/* PAGE flags:  USED  RECLAIMABLE  MEANING
 *              1     0            Page is allocated and owned OR no memory present
 *              1     1            Page will be scrubbed and is no longer owned
 *              0     0            Clean page for immediate use
 *              0     1            Should not occur so don't check for it
 * Scrubbing nonetheless performs a sanity check
 * */
#define FLOOR_DIV(a,b) ((a)/(b))
#define CEIL_DIV(a,b) ((a)/(b) + (((a)%(b)) != 0))
struct pmu* mmgr_initial_pmu(uint16_t page_ct)
{ /* reserved physical pages are marked as used */
		struct pmu* rv = pmu_allocator;
		size_t i;
		mbprintf("pmu_allocator=%p for pmu with pg_ct=%u\n", pmu_allocator, page_ct);
		if (page_ct > 4096)
				page_ct = 4096;
		for (i = 0; i < 128; i++) /* exact mapping only on level0 */
				rv->lvl0[i] = ((i + 1) * 32 > page_ct) ? (((i + 1) * 32 - page_ct >= 32) ? 0x00000000 :
					   ((0xffffffff >> (page_ct - i * 32)))) : 0xffffffff;
		for (i = 0; i < 64; i++)
				rv->lvl1[i] = ((i + 1) * 64 > page_ct) ? (((i + 1) * 32 - page_ct >= 32) ? 0x00000000 :
						((0xffffffff >> FLOOR_DIV(page_ct - i * 64, 2)))) : 0xffffffff;
		for (i = 0; i < 32; i++)
				rv->lvl2[i] = ((i + 1) * 128 > page_ct) ? (((i + 1) * 32 - page_ct >= 32) ? 0x00000000 :
						((0xffffffff >> FLOOR_DIV(page_ct - i * 128, 4)))) : 0xffffffff;
		for (i = 0; i < 16; i++)
				rv->lvl3[i] = ((i + 1) * 256 > page_ct) ? (((i + 1) * 32 - page_ct >= 32) ? 0x00000000 :
						((0xffffffff >> FLOOR_DIV(page_ct - i * 256, 8)))) : 0xffffffff;
		for (i = 0; i < 8; i++)
				rv->lvl4[i] = ((i + 1) * 512 > page_ct) ? (((i + 1) * 32 - page_ct >= 32) ? 0x00000000 :
						((0xffffffff >> FLOOR_DIV(page_ct - i * 512, 16)))) : 0xffffffff;
		for (i = 0; i < 4; i++)
				rv->lvl5[i] = ((i + 1) * 1024 > page_ct) ? (((i + 1) * 32 - page_ct >= 32) ? 0x00000000 :
						((0xffffffff >> FLOOR_DIV(page_ct - i * 1024, 32)))) : 0xffffffff;
		for (i = 0; i < 2; i++)
				rv->lvl6[i] = ((i + 1) * 2048 > page_ct) ? (((i + 1) * 32 - page_ct >= 32) ? 0x00000000 :
						((0xffffffff >> FLOOR_DIV(page_ct - i * 2048, 64)))) : 0xffffffff;
		rv->lvl7 = (0xffffffff >> FLOOR_DIV(page_ct, 128));
		rv->pmu_next = NULL;
		pmu_next();
		return rv;
}
struct pmu* mmgr_initial_res_rcp(uint16_t page_ct, uint16_t base_res)
{
		struct pmu* rv = pmu_allocator;
		size_t i;
		mbprintf("pmu_allocator=%p for rcp with pg_ct=%u\n", pmu_allocator, page_ct);
		if (page_ct > 4096)
				page_ct = 4096;
		for (i = 0; i < 128; i++) /* exact mapping only on level0 */
				rv->lvl0[i] = (((i + 1) * 32 > page_ct) ?
					   (0xffffffff >> (32 - (page_ct - i * 32))) : 0xffffffff)
						& ((i * 32) > base_res ? 0xffffffff : (0xffffffff << (base_res - i * 32)));
		for (i = 0; i < 32; i++)
				rv->lvl2[i] = (((i + 1) * 128 > page_ct) ?
						(0xffffffff >> (32 - CEIL_DIV(page_ct - i * 128, 4))) : 0xffffffff)
						& ((i * 128) > base_res ? 0xffffffff : (0xffffffff << (base_res - i * 128)));
		rv->lvl7 = (0xffffffff >> (32 - CEIL_DIV(page_ct, 128)))
				& (0xffffffff << FLOOR_DIV(base_res, 128));
		rv->pmu_next = NULL;
		pmu_next();
		return rv;
}
struct pmu* mmgr_initial_rcp(uint16_t page_ct)
{
		return mmgr_initial_res_rcp(page_ct, 0);
}

/* called while holding the lock on fm i */
size_t mmgr_scrub_pages(size_t i, size_t limit)
{
		size_t j, k, l, np = 0, npl = 0;
		/*printf("scrub_pages(%d, %d)\n", i, limit);
		printf("rc_ct=%d, rcp=%p\n", (size_t)free_mem_map[i].reclaimable_pages, free_mem_map[i].rcp);*/
		if (free_mem_map[i].reclaimable_pages) {
				uint64_t ofs = 0; size_t ct = 0;
				struct pmu* rc = free_mem_map[i].rcp;
				struct pmu* pu = free_mem_map[i].pmu;
				if (!rc) {
						uint64_t pct = ((free_mem_map[i].size - ofs) / 4096);
						mbprintf("pct=%d, s=%d, o=%d\n", (size_t)pct, (size_t)free_mem_map[i].size, (size_t)ofs);
					    if (pct >= 4096)
							pct = 4096;
						free_mem_map[i].rcp = rc = mmgr_initial_rcp((uint16_t)pct);
						mbprintf("rcp:=%p\n", free_mem_map[i].rcp);
				}
				if (!pu) { /* fully-used/dirty at begin */
						free_mem_map[i].pmu = pu = mmgr_initial_pmu(4096);
						mbprintf("assigning pmu at %p to FM %u PMU 1\n", pu, i);
				}
				/* scan the rcps */
				do {
						uint32_t ocp = rc->lvl7;
						if (ocp)
								mbprintf("FM %u:%u reclaimable: %032b\n", i, ct, ocp);
						npl = 0; ct++;
						for (j = 0; j < 32; j++) {
								uint32_t mask = (1 << j);
								/*printf("scan at %x\n", (size_t)(free_mem_map[i].base + ofs));*/
								if (ofs > free_mem_map[i].size)
										break;
								if (ocp & 1) { /* some bits in lvl2[j] set */
									uint32_t ocp2 = rc->lvl2[j];
									uint64_t ofs2 = free_mem_map[i].base + ofs;
									for (k = 0; k < 32; k++) {
											if (ofs2 > free_mem_map[i].base + free_mem_map[i].size)
													break;
											if (ocp2 & 1) { /* check up to 4 pages */
													uint16_t idx = 128 * j + k * 4;
													uint16_t base = idx / 32;
													uint16_t of = idx % 32;
													uint32_t flg = (1 << of);
													for (l = 0; l < 4; l++) {
															if (rc->lvl0[base] & flg) {
																	struct page_range pr = {0};
																	pr.base = ofs2 + l * 4096;
																	if (pr.base + 4096 > free_mem_map[i].base + free_mem_map[i].size)
																			break;
																	pr.count = 1;
																	/*printf("scrubbing %x (%d)\n", (size_t)pr.base, pr.count);*/
																	if (paging_enabled) {
																			mmgr_map_pmem((void*)0xfffff000, &pr, 1,
																						  MMGR_MAP_WRITE | MMGR_MAP_WRITE_THROUGH);
																			bzero((void*)0xfffff000, 4096);
																			mmgr_unmap_pmem((void*)0xfffff000, 1);
																	} else if (pr.base <= 0xfffff000) {
																			bzero((void*)(size_t)pr.base, 4096);
																	} else {
																			cprintf(KFMT_ERROR, "Cannot scrub physical pages beyond 4GiB without paging enabled\n");
																			while (1);
																	}
																	rc->lvl0[base] &= ~flg;
																	np++;
																	/* unset the use of reclaimable pages (only level0) */
																	pu->lvl0[base] &= ~flg;
																	/*printf("pu %p entry %u: %x\n", pu, base, pu->lvl0[base]);*/
															}
															flg <<= 1;
													}
											}
											ocp2 >>= 1;
											ofs2 += 4 * 4096;
									}
									/* all cleared */
									rc->lvl2[j] = 0;
								}
								ocp >>= 1;
								ofs += 128 * 4096;
								rc->lvl7 &= ~mask;
								if (limit && np >= limit) { /* low granularity for avoiding lvl0/2 update code */
										free_mem_map[i].reclaimable_pages -= (np - npl);
										free_mem_map[i].free_pages += (np - npl);
										/* update the buddies */
										pmu_update_buddies(pu);
										{
												extern struct kio_region kb_reg;
												rprintf(&kb_reg, "scrubbed %u pages\n", np);
										}
										/*printf("Aborting scrub due to limit %d>%d\n", (size_t)np, (size_t)limit);
										printf("now there are %u free pages in FM %u\n", (size_t)free_mem_map[i].free_pages, i);*/
										return np;
								}
						}
						/* update counts */
						free_mem_map[i].reclaimable_pages -= (np - npl);
						free_mem_map[i].free_pages += (np - npl);
						npl = np;
						/* update the buddies */
						pmu_update_buddies(pu);
						if (pu->pmu_next)
								pu = pu->pmu_next;
						else if (ofs < free_mem_map[i].size)
								pu = pu->pmu_next = mmgr_initial_pmu(4096);
						if (!rc->pmu_next && ofs < free_mem_map[i].size) {
								/* add a new list but don't scrub yet */
								uint64_t pct = ((free_mem_map[i].size - ofs) / 4096);
							    if (pct >= 4096)
									pct = 4096;
								rc->pmu_next = mmgr_initial_rcp((uint16_t)pct);
								rc = NULL;
						} else
								rc = rc->pmu_next;
				} while (rc && (!limit || (np <= limit))); /* clear up to 4096 pages : TODO adjusttable number from timing */
		}
		if (np) {
				extern struct kio_region kb_reg;
				rprintf(&kb_reg, "scrubbed %u pages\n", np);
		}
		return np;
}

/* scans reclaimable pages (in pmu structures) 
 * which are used in reverse, i.e. the top level indicates
 * presence of any reclaimable page and not of all contained 
 * as with physical memory usage entries (using only levels 7,2,0) */
int mmgr_page_scrub()
{
		/* only do limited scrubbing as it affects sleep granularity */
		size_t i, lm = 128;
		for (i = fm_begin; i < fm_ofs && lm; i++) {
				lm -= mmgr_scrub_pages(i, lm);
		}
		return (lm != 128);
}

void mmgr_init()
{
		struct mp* map = mem_map; size_t n;
		const char* typestr[] = {"B", "KiB", "MiB", "GiB", "TiB", "EiB" };

		printf("Memory map:\n");
		do {
				uint64_t ms = map->size;
				const char** ts = typestr;
				while (ms >= 1024) {
						if (ts - typestr == 5)
								break;
						ms /= 1024;
						ts++;
				}
				printf("%s at %#08x%08x with:\nsize %#08x%08x (%d %s)\n",
					  get_map_str(map->type), /* string ACPI, ... */
					  (uint32_t)((map->base & 0xffffffff00000000) >> 32),
					  (uint32_t)(map->base & 0xffffffff),
					  (uint32_t)((map->size & 0xffffffff00000000) >> 32),
					  (uint32_t)(map->size & 0xffffffff), (uint32_t)ms, *ts);
				if (map->type == 1)
						mmgr_add_free(map->base, map->size);
				else
						mmgr_add_reserved(map->base, map->size);
				map++;
		} while (map->base || map->size || map->type);

		/* now remove overlapping entries */
		map = mem_map;
		do {
				if (map->type != 1)
						mmgr_sub_block(map->base, map->size);
				map++;
		} while (map->base || map->size || map->type);

		/* sort and merge remaining blocks */
		mmgr_sort_and_merge();
		/* init free pages counts */
		for (n = 0; n < fm_ofs; n++) {
				if (!fm_begin && free_mem_map[n].base >= 0x100000) {
						fm_begin = n; /* only do dynamic alloc on himem */
				}
				/* no initial free pages (all dirty) */
				free_mem_map[n].reclaimable_pages = free_mem_map[n].size / 4096;
		}
		/* init the pmu directory */
		printf("Zeroing physical memory usage entries...\n");
		bzero(pmu_allocator, (void*)pmu_limit - (void*)pmu_allocator);
		/* mark the initial heap + ELF loadspace */
		if (free_mem_map[fm_begin].base != (size_t)0x100000) {
				cprintf(KFMT_ERROR, "Heap at himem %p shouldn't be there.\nHalting...\n", (void*)0x100000);
				while (1);
		}
		/*free_mem_map[fm_begin].pmu = pmu_allocator;*/
		if (free_mem_map[fm_begin].reclaimable_pages < 512) {
				cprintf(KFMT_ERROR, "lazy programming requires at least 2MiB of contiguous physical memory staring from 0x00100000\n");
				while (1);
		}
		free_mem_map[fm_begin].reclaimable_pages -= 512;
		/* all memory dirty or used */
		free_mem_map[fm_begin].pmu = mmgr_initial_pmu(4096);

		/*pmu_next();*/
		/* mark reclaimable entries in partially used memory */
		n = free_mem_map[fm_begin].size / 4096;
		if (n > 4096)
				n = 4096;
		free_mem_map[fm_begin].rcp = mmgr_initial_res_rcp(n, 512);

		/* reprint only free memory */
		cprintf(KFMT_INFO, "Usable memory:\n");
		cprintf(KFMT_INFO, "IDX  BASE ADDRESS     TOP ADDRESS      SIZE    PAGE COUNT\n");
		for (n = 0; n < fm_ofs; n++) {
				uint64_t ms = free_mem_map[n].size;
				const char** ts = typestr;
				while (ms >= 1024) {
						if (ts - typestr == 5)
								break;
						ms /= 1024;
						ts++;
				}
				cprintf(KFMT_INFO, "%4u %#08x%08x %#08x%08x %3d %-3s %u\n", n,
					  (uint32_t)((free_mem_map[n].base & 0xffffffff00000000) >> 32),
					  (uint32_t)(free_mem_map[n].base & 0xffffffff),
					  (uint32_t)(((free_mem_map[n].base + free_mem_map[n].size) & 0xffffffff00000000) >> 32),
					  (uint32_t)((free_mem_map[n].base + free_mem_map[n].size) & 0xffffffff),
					  (uint32_t)ms, *ts, (uint32_t)(free_mem_map[n].size / 4096));
		}

		/* Keep the limits */
		for (n = 0; n < fm_ofs; n++) {
				uint64_t limit = cpu.has_pae ? 0xfffffffff : 0xffffffff;
				if (free_mem_map[n].base > limit) {
						cprintf(KFMT_INFO, "No %s --> discarding entries %u+\n",
										cpu.has_pae ? "x86_64 used" : "PAE", n);
						fm_ofs = n;
				}
				else if (free_mem_map[n].base + free_mem_map[n].size > limit + 1) {
						cprintf(KFMT_INFO, "No %s --> capping entry %u to %dGiB:\n",
										cpu.has_pae ? "x86_64 used" : "PAE", n, cpu.has_pae ? 64 : 4);
						free_mem_map[n].size = limit + 1 - free_mem_map[n].base;
				}
		}

		/* check for the fixed allocator */
	//	extern void* endrest;
	//	if ((void*)&endrest >= FIXED_START) {
	//			cprintf(KFMT_ERROR, "Kernel image overlaps with fixed allocator\n");
	//			while (1);
	//	}

		/* initialize the paging */
		mmgr_init_paging();
		printf("init PD done\n");
		/* and fill the tss */
		mmgr_init_tss();
}

/* allocate and map pgs pages */
void* mmgr_alloc_vmem(size_t pg_ct, void* ptr, int flags)
{
		struct page_range pr[128]; void* nm;
		for (size_t i = 0; i < 128; i++)
				pr[i].count = 0;
		size_t ct_all = mmgr_pmem_allocate(pr, 128, pg_ct, 0);
		if (ct_all < pg_ct) {
				cprintf(KFMT_ERROR, "use a bigger page_range array in mmgr_alloc_vmem!\n");
				return 0;
		}
		nm = mmgr_map_pmem(ptr, pr, 128, flags);
		if (!nm) {
				/* can't map the heap */
				cprintf(KFMT_ERROR, "unable to map the kernel heap extension\n");
				cprintf(KFMT_ERROR, "although we have 4GiB of address space available\n");
				cprintf(KFMT_ERROR, "it would propably be possible to map it in smaller chunks\n");
				cprintf(KFMT_ERROR, "but I'm not in the mood to implement this\n");
				return 0;
		}
		return nm;
}

void mmgr_free_vmem(void* ptr, size_t pg_ct)
{
		/* QnD inefficient decommit 
		 * TLB will be updated like crazy */
		while (pg_ct) {
				struct page_range pr;
				pr.base = mmgr_page_get_pmem(ptr, NULL);
				pr.count = 1;
				/* always unmap before allowing reuse */
				mmgr_unmap_pmem(ptr, 1);
				mmgr_pmem_free(&pr, 1);
				ptr += 4096;
		}
}

void* mmgr_extend_vmem(void* ptr, size_t pc_old, size_t pc_new)
{
		size_t new_pmem = pc_new - pc_old, pm_res, p0c = 0, p1c = 0;
		void *rv, *p0 = ptr, *p1; int flg;
		struct page_range prs[128];
		if (!ptr || pc_new <= pc_old)
				return NULL;
		/* reserve virtual memory */
		rv = mmgr_res_vmptr(pc_new);
		if (!rv)
				return NULL;

		/* remap the existing pages */
		p1 = rv;
		while (pc_old) {
				struct page_range pr;
				struct pte* pt;
				pr.base = mmgr_page_get_pmem(p0, (void**)&pt);
				pr.count = 1; flg = 0;
				if (pt->g_bit)
						flg |= MMGR_MAP_GLOBAL;
				if (pt->no_cache)
						flg |= MMGR_MAP_NO_CACHING;
				if (pt->writable)
						flg |= MMGR_MAP_WRITE;
				if (!pt->user_page)
						flg |= MMGR_MAP_KERNEL;
				if(pt->wt_cache)
						flg |= MMGR_MAP_WRITE_THROUGH;
				if (!mmgr_map_pmem(p1, &pr, 1, flg)) {
						if (p0c)
								mmgr_unmap_pmem(rv, p0c);
						return NULL;
				}
				p0c++; pc_old--;
				p0 += 4096;
				p1 += 4096;
		}
		/* now get the physical memory and map it */
		while (new_pmem) {
				pm_res = mmgr_pmem_allocate(prs, 128, new_pmem, 0);
				if (!pm_res) {
						/* out of pmem */
						mmgr_free_vmem(rv + p0c * 4096, p1c);
						mmgr_unmap_pmem(rv, p0c);
						return NULL;
				}
				if (!mmgr_map_pmem(p1, prs, 128, flg)) {
						/* cannot happen on reserved mem */
						cprintf(KFMT_ERROR, "Error while mapping virtual memory which was already reserved.");
						while (1);
				} else {
						p1 += pm_res * 4096;
						p1c += pm_res;
				}
		}
		/* and unmap the old memory */
		mmgr_unmap_pmem(ptr, p0c);
		return rv;
}

void mmgr_protect_zero(int yes)
{
		struct pte* pt = pd_pt_ptr[0];
		struct pae_pte* ptp = pd_pt_ptr[0];
		if (!pt) {
				cprintf(KFMT_ERROR, "Page table of NULL not mapped!\n");
				while (1);
		}
		if (yes) {
				/* protect NULL pointer */
				pt[0].present = 0; /* we can use either interface */
		} else if (cpu.has_pae) {
				/* here we have to careful */
				ptp[0].present = 1;
				ptp[0].mem_ptr = 0;
				ptp[0].writable = 1;
		} else {
				pt[0].present = 1;
				pt[0].mem_ptr = 0;
				pt[0].writable = 1;
		}
		flush_tlb_single((uint32_t)NULL);
}

int mmgr_access_ptr(void* ptr)
{
		size_t pt_ofs;
		uint16_t sofs;
		if (cpu.has_pae) {
				pt_ofs = (size_t)ptr / (512 * 4096);
				sofs = ((size_t)ptr % (512 * 4096)) / 4096;
		} else {
				pt_ofs = (size_t)ptr / (1024 * 4096);
				sofs = ((size_t)ptr % (1024 * 4096)) / 4096;
		}
		struct pte* pt = pd_pt_ptr[pt_ofs];
		struct pae_pte* ptp = NULL;
		printf("accessing: %p n=%u\n", ptr, pt_ofs);
		if (!pt)
				return 1;
		printf("pte at %p sofs=%u\n", pt, sofs);
		pt = pt + sofs;
		if (cpu.has_pae)
				ptp = ptp + sofs;
		if ((ptp && !ptp->present) || (!ptp &&!pt->present)) {
				printf("np\n");
				if ((ptp && ptp->mem_ptr) || (!ptp && pt->mem_ptr)) {
						if (ptp) {
								ptp->writable = 1;
								ptp->present = 1;
						} else {
								pt->writable = 1;
								pt->present = 1;
						}
						flush_tlb_single((uint32_t)ptr);
						return 0;
				} else
						return 1;
		} else if ((ptp && !ptp->writable)|| (!ptp && !pt->writable)) {
				printf("nw\n");
				if (ptp)
						ptp->writable = 1;
				else
						pt->writable = 1;
				flush_tlb_single((uint32_t)ptr);
				return 0;
		}
		return 1;
}

