/* min_mm.c : Impelements a simple early mmgr operating in 32-bit
 *            protected mode one physical memory only.
 * */

#include "../boot/fixmem.h"
#include "../kernel.h"
#include "../kdata.h"

extern uint64_t pm_zero;
extern struct mm mm_kernel;

#define BTS_NX 1
#define BTS_PGE 2
//#define BTS_PCID 4
/* Caching PAT: 3 bits select 8 entries
 * Most levels have 2 bits for the first 4 entries
 * Lowest level describing memory have additional PAT bit
 * Caching types are stored in 64-bit (8*8) PAT MTR 277h
 * Cache Types: UC, UC-(overridable), WC (writes are buffered
 * --> for fast write access to video memory!!), WT writes
 *  go to memory (FB or (defective) devices with bus master cap, reading mem)
 *  WB: general memory (All CPUs can work with it, many devices which
 *  "snoop" write access also), WP: writes go to system bus (lock prefix like)
 *  [WC buffer 64bytes >> SSE]
 *  Also: clear cr0 CD,NW flags: also check MTRRs
 * */

/* only for 32-bit paging */
struct pte32 {
		uint32_t p : 1; /* present */
		uint32_t w : 1; /* R/W */
		uint32_t u : 1; /* U/S */
		uint32_t wt : 1; /* WT */
		uint32_t cd : 1; /* CD */
		uint32_t a : 1; /* accessed */
		uint32_t d : 1; /* dirty */
		uint32_t s : 1; /* size bit or PAT on 4K level */
		uint32_t g : 1; /* global bit (on memory level) */
		uint32_t ign : 3; /* ignored bits */
		uint32_t addr : 20; /* LSB is PAT for 4M pages (/4096)*/
};

/* also for PAE */
struct pte64 {
		uint64_t p : 1; /* present */
		uint64_t w : 1; /* R/W */
		uint64_t u : 1; /* U/S */
		uint64_t wt : 1; /* WT */
		uint64_t cd : 1; /* CD */
		uint64_t a : 1; /* accessed */
		uint64_t d : 1; /* dirty */
		uint64_t s : 1; /* size bit or PAT on 4K level */
		uint64_t g : 1; /* global bit (on memory level) */
		uint64_t ign : 3; /* ignored bits */
		uint64_t addr : 40; /* LSB is PAT for 1G/2M pages (/4096)*/
		uint64_t ign2 : 11; /* 2M, 1G pages are aligned to 1G,2M */
		uint64_t xd : 1; /* NX/XD bit */
};

#ifdef __x86_64__
#define PTE_INVALID (void*)0xffffffffffffffff
#else
#define PTE_INVALID (void*)0xffffffff
#endif

/* try to enter critical section*/
#define ENTER_CS_PTE(ptr) __sync_bool_compare_and_swap(&ptr, NULL, PTE_INVALID)
#define SPIN_CS(ptr) while (*(void** volatile)(&ptr) == PTE_INVALID)

struct vmdesc {
		uint64_t vga_base;
		uint64_t vga_size;
		uint64_t vga_virt;
};

#ifndef __x86_64__
struct vm_pg_ptrs32 {
		void* cur;
		struct pte32* pd;
		struct pte32* pts[1024]; /* 4M PTs */
		struct vmdesc video_memory;
};

struct vm_pg_ptrs36 { /* hybrid structure as pte64s are saved here */
		struct pte64 pdps[4]; /* 32-bytes /w page alignment in lowmem */
		void* cur;
		struct pte64* pdp[4]; /* 4 PDs */
		struct pte64* pts[2048]; /* all 2M PTs */
		struct vmdesc video_memory;
};
#else
struct vm_pg_ptrs64 {
		void* cur;
		struct pte64* pml4;
		struct pte64* pml4e[512]; /* pdps */
		struct vm_pdpte_ptr* pdpte[512]; /* pds (struct pdpte_ptr) */
		struct vmdesc video_memory;
};

struct vm_pdpte_ptr {
		struct pte64* pds[512]; /* page directories */
		struct vm_pde_ptr* pdes[512]; /* pdes (struct pde_ptr) */
};

struct vm_pde_ptr {
		struct pte64* pts[512]; /* page tables */
};
#endif

/* The TLB handling */
uint64_t tlb_flush_ct = 0; /* stats */

static inline void flush_tlb_single(void* addr)
{
		__sync_fetch_and_add(&tlb_flush_ct, 1);
		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
}

static inline void flush_tlb_full()
{
#ifdef __x86_64__
		asm volatile("mov %%cr3, %%rax\nmov %%rax, %%cr3\n" : : : "%eax");
#else
		asm volatile("mov %%cr3, %%eax\nmov %%eax, %%cr3\n" : : : "%eax");
#endif
}

/* allocates a single page for paging structures */
void* mm_alloc_page(uint64_t* b)
{
		struct page_range pr; void** pp; void* rv;

#ifdef __x86_64__
		pp = &((struct vm_pg_ptrs64*)mm_kernel.ctx)->cur;
#else
		if (cpu.has_pae)
				pp = &((struct vm_pg_ptrs36*)mm_kernel.ctx)->cur;
		else
				pp = &((struct vm_pg_ptrs32*)mm_kernel.ctx)->cur;
#endif

		/* get the physical memory */
		if (!mm_alloc_pm(1, &pr, 1)) {
				die("Unable to allocate PM for paging strucures.\n");
				return NULL;
		}
		*b = pr.base;

		/* reserve and map the virtual memory */
		rv = __sync_fetch_and_sub(pp, 4096);
		if (rv < VM_TABLE_LIMIT) {
				die("Out of virtual memory for paging structures.\n");
				return NULL;
		}
		mm_map(&mm_kernel, rv, &pr, 1, MMGR_MAP_WRITE
						| MMGR_MAP_KERNEL /*| MMGR_MAP_GLOBAL*/);

		return rv;
}

#ifdef __x86_64__
void* mm_map64(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
{
		uint64_t low48;
		struct vm_pg_ptrs64* vp = vm_mapping;
		uint32_t pml4e, pdpte, pde, pte;
		struct page_range pr_copy;

		/* physical pointers */
		struct pte64 *p = vp->pml4;
		struct pte64* pl = 0;
		struct pte64* pd = 0;
		struct pte64* pt = 0;

		/* mappings */
		struct vm_pdpte_ptr* m;
		struct vm_pde_ptr* n;

		/* calculate the PML4E */
		low48 = (uint64_t)vaddr & 0x0000ffffffffffff;
		pml4e = low48 >> 39; /* 512G per PML4E */

		/* and the PDPTE */
		pdpte = (low48 & 0x007fc0000000) >> 30; /* 1G per PDPTE */

		/* and the PDE */
		pde = (low48 & 0x3fe00000) >> 21; /* 2M per PDE */

		/* and finally the PTE */
		pte = (low48 & 0x1ff000) >> 12; /* 4K per PTE */

		/* create one if not there */
new_pdpt:
		if (ENTER_CS_PTE(vp->pml4e[pml4e])) {
				struct page_range pr2[2];
				/* allocate the PDPT */
				pl = mm_alloc_page(&pr2[0].base);

				/* and set the reference in the PML4 */
				p[pml4e].addr = pr2[0].base / 4096;
				p[pml4e].u = 1;
				p[pml4e].w = 1;
				p[pml4e].p = 1;

				/* now allocate the map (2 pages) */
				mm_alloc_pm(2, pr2, 2); /* not cont. as only virt access */
				m = __sync_fetch_and_sub(&vp->cur, 8096) - 4096;
				mm_map(&mm_kernel, m, pr2, pr2[0].count > 1 ? 1 : 2,
								MMGR_MAP_WRITE | MMGR_MAP_KERNEL /*| MMGR_MAP_GLOBAL*/);
				vp->pdpte[pml4e] = m;

				/* release the CS */
				vp->pml4e[pml4e] = pl;

		} else {
				/* wait for valid entry */
				SPIN_CS(vp->pml4e[pml4e]);
				pl = vp->pml4e[pml4e];
		}
		/* fetch the map */
		m = vp->pdpte[pml4e];

		/* now go on to the page directory */
new_pd:
		if (ENTER_CS_PTE(m->pds[pdpte])) {
				uint64_t b;
				/* allocate a page directory */
				pd = mm_alloc_page(&b);

				/* and set the reference in the PDPT */
				pl[pdpte].addr = b / 4096;
				pl[pdpte].u = 1;
				pl[pdpte].w = 1;
				pl[pdpte].p = 1;

				/* now allocate the map */
				n = mm_alloc_page(&b);
				m->pdes[pdpte] = n;

				/* release the CS */
				m->pds[pdpte] = pd;

		} else {
				SPIN_CS(m->pds[pdpte]);
				pd = m->pds[pdpte];
		}
		/* fetch the map */
		n = m->pdes[pdpte];

		/* now select the page table */
new_pt:
		if (ENTER_CS_PTE(n->pts[pde])) {
				uint64_t b;
				/* allocate a page table */
				pt = mm_alloc_page(&b);

				/* and set the reference in the PD */
				pd[pde].addr = b / 4096;
				pd[pde].u = 1;
				pd[pde].w = 1;
				pd[pde].p = 1;

				/* release the CS */
				n->pts[pde] = pt;

		} else {
				SPIN_CS(n->pts[pde]);
				pt = n->pts[pde];
		}

		/* now map the pages */
		pr_copy = *pr++;
		while (prc) {
				pt[pte].addr = pr_copy.base / 4096;
				pt[pte].u = 1; /* FIXME: for now (u ? 1 : 0) */
				pt[pte].w = (w ? 1 : 0);
				pt[pte].p = 1;
				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wt ? 1 : 0);
				pt[pte].cd = (cd ? 1 : 0);
				pt[pte].g = (g ? 1 : 0);
				pt[pte].u = 1; /* FIXME: for now */
				pt[pte].ign = avl & 7;
				pt[pte].ign2 = (avl >> 3);
				if (cpu.e_has_nx)
						pt[pte].xd = (x ? 0 : 1);
				/* advance */
				if (pte++ == 511) {
						if (pde++ == 511) {
								if (pdpte++ == 511) {
										if (pml4e++ == 511) {
												die("End of 16E address space\n");
										}
										pdpte = 0;
										pde = 0;
										pte = 0;
										goto new_pdpt;
								}
								pde = 0;
								pte = 0;
								goto new_pd;
						}
						pte = 0;
						goto new_pt;
				}
				pr_copy.base += 4096;
				if (!--pr_copy.count) {
						if (prc--)
								pr_copy = *pr++;
				}
		}
		return vaddr;
}
#else
void* mm_map36(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
{
		struct vm_pg_ptrs36* vp = vm_mapping;
		uint32_t pdpte, pde, pte;
		struct page_range pr_copy;

		/* physical pointers */
		struct pte64* pd = 0;
		struct pte64* pt = 0;

		/* and the PDPTE */
		pdpte = ((uint32_t)vaddr & 0xc0000000) >> 30; /* 1G per PDPTE */
		pd = vp->pdp[pdpte];

		/* and the PDE */
		pde = ((uint32_t)vaddr & 0x3fe00000) >> 21; /* 2M per PDE */

		/* and finally the PTE */
		pte = ((uint32_t)vaddr & 0x1ff000) >> 12; /* 4K per PTE */

		/* create a PT if not there */
new_pt:
		if (ENTER_CS_PTE(vp->pts[pdpte * 512 + pde])) {
				uint64_t b;
				/* allocate a page table */
				pt = mm_alloc_page(&b);

				/* and set the reference in the PD */
				pd[pde].addr = b / 4096;
				pd[pde].u = 1;
				pd[pde].w = 1;
				pd[pde].p = 1;

				/* release CS */
				vp->pts[pdpte * 512 + pde] = pt;
		} else {
				SPIN_CS(vp->pts[pdpte * 512 + pde]);
				pt = vp->pts[pdpte * 512 + pde];
		}

		/* now map the pages */
		pr_copy = *pr++;
		while (prc) {
				pt[pte].addr = pr_copy.base / 4096;
				pt[pte].u = 1; /* FIXME: for now (u ? 1 : 0) */
				pt[pte].w = (w ? 1 : 0);
				pt[pte].p = 1;
				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wt ? 1 : 0);
				pt[pte].cd = (cd ? 1 : 0);
				pt[pte].g = (g ? 1 : 0);
				pt[pte].u = 1; /* FIXME: for now */
				pt[pte].ign = avl & 7;
				pt[pte].ign2 = (avl >> 3);
				if (cpu.e_has_nx)
						pt[pte].xd = (x ? 0 : 1);
				/* advance */
				if (pte++ == 511) {
						if (pde++ == 511) {
								if (pdpte++ == 3) {
										die("End of 4G address space\n");
								}
								pd = vp->pdp[pdpte];
								pde = 0;
								pte = 0;
								goto new_pt;
						}
						pte = 0;
						goto new_pt;
				}
				pr_copy.base += 4096;
				if (!--pr_copy.count) {
						if (prc--)
								pr_copy = *pr++;
				}
		}
		return vaddr;
}

void* mm_map32(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
{
		struct vm_pg_ptrs32* vp = vm_mapping;
		uint32_t pde, pte;
		struct page_range pr_copy;

		/* entry pointers */
		struct pte32* pd = vp->pd;
		struct pte32* pt = 0;

		/* and the PDE */
		pde = ((uint32_t)vaddr & 0xffc00000) >> 22; /* 4M per PDE */

		/* and finally the PTE */
		pte = ((uint32_t)vaddr & 0x3ff000) >> 12; /* 4K per PTE */

new_pt:
		/* create a PT if not there */
		if (ENTER_CS_PTE(vp->pts[pde])) {
				uint64_t b;
				/* allocate a page table */
				pt = mm_alloc_page(&b);

				/* and set the reference in the PD */
				pd[pde].addr = (uint32_t)(b / 4096);
				pd[pde].u = 1;
				pd[pde].w = 1;
				pd[pde].p = 1;
	
				/* release CS */
				vp->pts[pde] = pt;
		} else {
				/* wait until valid and fetch */
				SPIN_CS(vp->pts[pde]);
				pt = vp->pts[pde];
		}

		/* now map the pages */
		pr_copy = *pr++;
		while (prc) {
				pt[pte].addr = pr_copy.base / 4096;
				pt[pte].u = 1; /* FIXME: for now (u ? 1 : 0) */
				pt[pte].w = (w ? 1 : 0);
				pt[pte].p = 1;
				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wt ? 1 : 0);
				pt[pte].cd = (cd ? 1 : 0);
				pt[pte].g = (g ? 1 : 0);
				pt[pte].ign = avl & 7;
				/* advance */
				if (pte++ == 1023) {
						if (pde++ == 1023) {
								die("end of 4G address space\n");
						}
						pte = 0;
						goto new_pt;
				}
				pr_copy.base += 4096;
				if (!--pr_copy.count) {
						if (prc--)
								pr_copy = *pr++;
				}
		}
		return vaddr;
}
#endif

#ifndef __x86_64__
typedef void* (*map_fun)(void*, void*, struct page_range*, size_t,
			   int, int, int, int, int, int, int, int);
map_fun mf_map = NULL;
#endif

void* mm_map(struct mm* mm, void* virt_address,	const struct page_range* prs,
				size_t pr_ct, int flags)
{
		int x = flags & MMGR_MAP_EXECUTE, w = flags & MMGR_MAP_WRITE,
			wc = flags & MMGR_MAP_PAT, wt = flags & MMGR_MAP_WRITE_THROUGH,
			cd = flags & MMGR_MAP_NO_CACHING, g = flags & MMGR_MAP_GLOBAL,
			u = !(flags & MMGR_MAP_KERNEL);
		int avl = 0;

		if (flags & MMGR_MAP_COW) {
				avl = MMGR_AVL_COW;
				w = 0; /* make COW workable */
		}

		/* get virtutal memory */
		if (!virt_address) {
				size_t pg_ct = 0;
				for (size_t i = 0; i < pr_ct; i++)
						pg_ct += prs[i].count;
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);
		}

#ifdef __x86_64__
		return mm_map64(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
#else
		return mf_map(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
#endif
}

#ifdef __x86_64__
int mm_page_walk64(void* vm_mapping, void* virt_addr, struct pte64** parent,
				struct pte64** entry, int* level, uint32_t* offset, void*** cntr, void*** cntrm)
{
		uint64_t low48;
		struct vm_pg_ptrs64* vp = vm_mapping;
		uint32_t pml4e, pdpte, pde, pte;

		/* entry pointers */
		struct pte64 *p = vp->pml4;
		struct pte64* pl = 0;
		struct pte64* pd = 0;
		struct pte64* pt = 0;

		/* mappings */
		struct vm_pdpte_ptr* m;
		struct vm_pde_ptr* n;

		/* calculate the PML4E */
		low48 = (uint64_t)virt_addr & 0x0000ffffffffffff;
		pml4e = low48 >> 39; /* 512G per PML4E */

		/* and the PDPTE */
		pdpte = (low48 & 0x007fc0000000) >> 30; /* 1G per PDPTE */

		/* and the PDE */
		pde = (low48 & 0x3fe00000) >> 21; /* 2M per PDE */

		/* and finally the PTE */
		pte = (low48 & 0x1ff000) >> 12; /* 4K per PTE */

		/* Now walk down the hierachy */
		if (!p) {
				*parent = *entry = NULL;
				*offset = -1;
				*level = 4; /* missing lvl4 (very unlikely) */
				return -1;
		}

		/* PML4 (no size bit exists) */
		if (!p[pml4e].p) {
				*entry = &p[pml4e];
				*parent = p; /* to ensure parent[offset]=entry */
				*offset = pml4e;
				*level = 3;
				*cntr = (void**)vp->pml4e;
				*cntrm = (void**)vp->pdpte;
				return -1;
		}

		m = vp->pdpte[pml4e];
		pl = vp->pml4e[pml4e];

		/* PDPTE */
		if (!pl[pdpte].p || pl[pdpte].s) {
				*parent = &p[pml4e];
				*entry = &pl[pdpte];
				*level = 2;
				*offset = pdpte;
				*cntr = (void**)m->pds;
				*cntrm = (void**)m->pdes;
				/* 1G page is OK */
				return (pl[pdpte].s ? 0 : -1);
		}

		n = m->pdes[pdpte];
		pd = m->pds[pdpte];

		/* PDE */
		if (!pd[pde].p || pd[pde].s) {
				*parent = &pl[pdpte];
				*entry = &pd[pde];
				*level = 1;
				*offset = pde;
				*cntr = (void**)n->pts;
				*cntrm = NULL;
				/* 2M page is OK */
				return (pd[pde].s ? 0 : -1);
		}

		pt = n->pts[pde];

		/* PTE */
		*parent = &pd[pde];
		*entry = &pt[pte];
		*level = 0;
		*offset = pte;
		*cntr = NULL;
		*cntrm = NULL;
		/* present or not? */
		return (pt[pte].p ? 0 : -1);
}
#else
int mm_page_walk36(void* vm_mapping, void* virt_addr, struct pte64** parent,
				struct pte64** entry, int* level, uint32_t* offset, void*** cntr, void*** cntrm)
{
		struct vm_pg_ptrs36* vp = vm_mapping;
		uint32_t pdpte, pde, pte;

		/* entry pointers */
		struct pte64* pd = 0;
		struct pte64* pt = 0;
		*cntrm = NULL;

		/* the PDPTE */
		pdpte = ((uint32_t)virt_addr & 0xc0000000) >> 30; /* 1G per PDPTE */
		pd = vp->pdp[pdpte];

		/* and the PDE */
		pde = ((uint32_t)virt_addr & 0x3fe00000) >> 21; /* 2M per PDE */

		/* and finally the PTE */
		pte = ((uint32_t)virt_addr & 0x1ff000) >> 12; /* 4K per PTE */

		/* PDPTE */
		if (!vp->pdps[pdpte].p) {
				*parent = NULL;
				*entry = &vp->pdps[pdpte];
				*offset = pdpte;
				*cntr = NULL; /* we have to reload CR3 */
				*level = 2;
				return -1;
		}

		/* PDE */
		if (!pd[pde].p || pd[pde].s) {
				*parent = &vp->pdps[pdpte];
				*entry = &pd[pde];
				*offset = pde;
				*level = 1;
				*cntr = (void**)(vp->pts + pdpte * 512);
				/* 2M pages OK */
				return (pd[pde].s ? 0 : -1);
		}

		pt = vp->pts[512 * pdpte + pde];

		/* PTE */
		*parent = &pd[pde];
		*entry = &pt[pte];
		*offset = pte;
		*cntr = NULL;
		*level = 0;
		/* present or not? */
		return (pt[pte].p ? 0 : -1);
}

int mm_page_walk32(void* vm_mapping, void* virt_addr, struct pte32** parent,
				struct pte32** entry, int* level, uint32_t* offset, void*** cntr, void*** cntrm)
{
		struct vm_pg_ptrs32* vp = vm_mapping;
		uint32_t pde, pte;

		/* entry pointers */
		struct pte32* pd = vp->pd;
		struct pte32* pt = 0;
		*cntrm = NULL;

		/* and the PDE */
		pde = ((uint32_t)virt_addr & 0xffc00000) >> 22; /* 4M per PDE */

		/* and finally the PTE */
		pte = ((uint32_t)virt_addr & 0x3ff000) >> 12; /* 4K per PTE */

		/* walk the hierachy */
		if (!pd) {
				*entry = *parent = 0;
				*offset = -1; /* CR3 invalid */
				*level = 2;
				*cntr = NULL; /* reload CR3 */
				return -1;
		}

		/* PDE */
		if (pd[pde].p || pd[pde].s) {
				*parent = NULL;
				*entry = &pd[pde];
				*offset = pde;
				*level = 1;
				*cntr = (void**)vp->pts;
				/* 4M pages are OK */
				return (pd[pde].s ? 0 : -1);
		}

		pt = vp->pts[pde];

		/* PTE */
		*parent = &pd[pde];
		*entry = &pt[pte];
		*offset = pte;
		*level = 0;
		*cntr = NULL;
		/* present or not? */
		return (pt[pte].p ? 0 : -1);
}
#endif

void mm_protect(struct mm* mm, void* virt_address, size_t num_pages, int flags)
{
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (num_pages--) {
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#else
				if (cpu.has_pae)
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
						return;

				e32 = NULL; e64 = NULL;
				if (!cpu.has_pae)
						e32 = e;
				else
						e64 = e;
		
				/* set/unset or override */
				if (flags & MMGR_MAP_PURGE_ACC)
						if (e64)
								e64->a = 0;
						else
								e32->a = 0;
				else if (flags & MMGR_MAP_PURGE_DIRTY)
						if (e64)
								e64->d = 0;
						else
								e32->d = 0;
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
						char v = !!(flags & MMGR_MAP_SET); /* 1 or 0 */
						if (e64) {
								if (flags & MMGR_MAP_WRITE)
										e64->w = v;
								if (flags & MMGR_MAP_WRITE_THROUGH)
										e64->wt = v;
								if (flags & MMGR_MAP_NO_CACHING)
										e64->cd = v;
								if (flags & MMGR_MAP_PAT)
										if (lv > 0)
												e64->addr = (e64->addr & ~1) | v;
										else
												e64->s = v;
								if (flags & MMGR_MAP_GLOBAL)
										e64->g = v;
								if (flags & MMGR_MAP_KERNEL)
										e64->u = !v;
								if (flags & MMGR_MAP_EXECUTE)
										e64->xd = v;
						} else {
								if (flags & MMGR_MAP_WRITE)
										e32->w = v;
								if (flags & MMGR_MAP_WRITE_THROUGH)
										e32->wt = v;
								if (flags & MMGR_MAP_NO_CACHING)
										e32->cd = v;
								if (flags & MMGR_MAP_PAT)
										if (lv > 0)
												e32->addr = (e32->addr & ~1) | v;
										else
												e32->s = v;
								if (flags & MMGR_MAP_GLOBAL)
										e32->g = v;
								if (flags & MMGR_MAP_KERNEL)
										e32->u = !v;
								//if (flags & MMGR_MAP_EXECUTE)
								//		e32->xd = v;
						}
				} else {
						if (e64) {
								e64->w = !!(flags & MMGR_MAP_WRITE);
								e64->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
								e64->cd = !!(flags & MMGR_MAP_NO_CACHING);
								if (lv > 0)
										e64->addr = (e64->addr & ~1) | !!(flags & MMGR_MAP_PAT);
								else
										e64->s = !!(flags & MMGR_MAP_PAT);
								e64->g = !!(flags & MMGR_MAP_GLOBAL);
								e64->u = !(flags & MMGR_MAP_KERNEL);
								e64->xd = !!(flags & MMGR_MAP_EXECUTE);
						} else {
								e32->w = !!(flags & MMGR_MAP_WRITE);
								e32->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
								e32->cd = !!(flags & MMGR_MAP_NO_CACHING);
								if (lv > 0)
										e32->addr = (e32->addr & ~1) | !!(flags & MMGR_MAP_PAT);
								else
										e32->s = !!(flags & MMGR_MAP_PAT);
								e32->g = !!(flags & MMGR_MAP_GLOBAL);
								e32->u = !(flags & MMGR_MAP_KERNEL);
								//e32->xd = !!(flags & MMGR_MAP_EXECUTE);
						}
				}

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
		
				/* advance */
				if (!lv) /* regular page */
						virt_address += 4096;
				else if (lv == 1) /* large page 2M/4M */
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
				else if (lv == 2) /* huge page 1G */
						virt_address += 1024 * 1024 * 1024;
				else
						die("ginormous page?\n");
		}
}

void* mm_reserve_vmem(struct mm* mm, size_t pg_ct, int flags)
{
		void* rv = __sync_fetch_and_add(&mm->qnd_ptr, pg_ct * 4096);
		if (rv + pg_ct * 4096 > VM_QND_LIMIT)
				die("Out of QnD VM reservation ranges. Impelment a map!\n");
		return rv;
}

void mm_aoa_range(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
		int x = flags & MMGR_MAP_EXECUTE, w = flags & MMGR_MAP_WRITE,
			wc = flags & MMGR_MAP_PAT, wt = flags & MMGR_MAP_WRITE_THROUGH,
			cd = flags & MMGR_MAP_NO_CACHING, g = flags & MMGR_MAP_GLOBAL,
			u = !(flags & MMGR_MAP_KERNEL);
		int avl = MMGR_AVL_AOA, lvl; uint32_t ofs;
		void *p, *e, **cntr, **cntrm;

		while (pg_ct) {
redo:
				if (!mm_page_walk(mm, virt_address, &p, &e, &lvl,
										&ofs, &cntr, &cntrm)) {
						/* present entry! */
present:
						die("encountered present entry while AOA alloc\n");
				}
				/* create the appropiate paging structures */
				if (lvl > 0) {
						void* ptr; uint64_t b;
#ifdef __x86_64__ /* complicated nested pointer tables */
						if (ENTER_CS_PTE(cntr[ofs])) {
								struct pte64* p = e;
								/* get a new X table */
								ptr = mm_alloc_page(&b);
								/* register it */
								p[ofs].addr = b / 4096;
								p[ofs].u = 1;
								p[ofs].w = 1;
								p[ofs].p = 1;
								/* allocate container if needed */
								if (cntrm) {
										void* map;
										if (lvl == 3) {
												struct page_range pr2[2];
												struct vm_pg_ptrs64* vp = mm_kernel.ctx;
												mm_alloc_pm(2, pr2, 2);
												map = __sync_fetch_and_sub(&vp->cur, 8096) - 4096;
												mm_map(&mm_kernel, map, pr2, pr2[0].count > 1 ? 1 : 2,
														MMGR_MAP_WRITE | MMGR_MAP_KERNEL /*| MMGR_MAP_GLOBAL*/);
										} else
												map = mm_alloc_page(&b);
										cntrm[ofs] = map;
								}
								/* release CS */
								cntr[ofs] = ptr;
						} else
								SPIN_CS(cntr[ofs]);
#else /* just one big list of page table pointers */
						if (lvl == 1) {
								/* we need a new page table */
								if (ENTER_CS_PTE(cntr[ofs])) {
										ptr = mm_alloc_page(&b);
										/* register it */
										if (cpu.has_pae) {
												struct pte64* pd = e;
												pd[ofs].addr = b / 4096;
												pd[ofs].u = 1;
												pd[ofs].w = 1;
												pd[ofs].p = 1;
										} else {
												struct pte32* pd = e;
												pd[ofs].addr = (uint32_t)(b / 4096);
												pd[ofs].u = 1;
												pd[ofs].w = 1;
												pd[ofs].p = 1;
										}

										/* releae CS */
										cntr[ofs] = ptr;
								} else
										SPIN_CS(cntr[ofs]);
						} else { /* new page directory? */
								if (!cpu.has_pae) {
										die("PD missing\n");
								}
								/* alloc the PD */
								die("will not happen as 4PDs are pre-allocated.\n");
						}
#endif
						goto redo;
				}

				/* we now have a working page table */
				if (!cpu.has_pae) {
						struct pte32* pte = e;
						while (ofs < 1024) {
								/* check for present */
								if (pte->p)
										goto present;

								/* set the flags */
								pte->addr = pm_zero / 4096; /* cautonary */
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
								pte->w = (w ? 1 : 0);
								pte->p = 0; /* that's the point of allocate-on-access */
								pte->s = (wc ? 1 : 0); /* PAT bit */
								pte->wt = (wt ? 1 : 0);
								pte->cd = (cd ? 1 : 0);
								pte->g = (g ? 1 : 0);
								pte->ign = avl & 7;
								/* advance */
								pte++; ofs++; pg_ct--;
								virt_address += 4096;
								if (!pg_ct) /* exit if done */
										return;
						}
				} else {
						struct pte64* pte = e;
						while (ofs < 512) {
								/* check for present */
								if (pte->p)
										goto present;

								/* set the flags */
								pte->addr = pm_zero / 4096; /* cautonary */
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
								pte->w = (w ? 1 : 0);
								pte->p = 0; /* that's the point of allocate-on-access */
								pte->s = (wc ? 1 : 0); /* PAT bit */
								pte->wt = (wt ? 1 : 0);
								pte->cd = (cd ? 1 : 0);
								pte->g = (g ? 1 : 0);
								if (cpu.e_has_nx)
										pte->xd = (x ? 0 : 1);
								pte->ign = avl & 7;
								pte->ign2 = 0;
								/* advance */
								pte++; ofs++; pg_ct--;
								virt_address += 4096;
								if (!pg_ct) /* exit if done */
										return;
						}
				}
		}
}

void mm_unmap(struct mm* mm, void* virt_address, size_t pg_ct)
{
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (pg_ct--) {
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#else
				if (cpu.has_pae)
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
						goto advance;

				e32 = NULL; e64 = NULL;
				if (!cpu.has_pae)
						e32 = e;
				else
						e64 = e;
		
				/* make not present (TODO: clear as in free_vmem?) */
				if (!cpu.has_pae)
						e32->p = 0;
				else
						e64->p = 0;

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
		
				/* advance */
advance:
				if (!lv) /* regular page */
						virt_address += 4096;
				else if (lv == 1) /* large page 2M/4M */
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
				else if (lv == 2) /* huge page 1G */
						virt_address += 1024 * 1024 * 1024;
				else
						die("ginormous page?\n");
		}
}

void* mm_alloc_vmem(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
		if (!virt_address)
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);

		if (flags & MMGR_ALLOC_CONTIGUOUS) {
				struct page_range pr; size_t ct;
				/* FIXME: Implement cont. allocator for PMEM */
				ct = mm_alloc_pm(pg_ct, &pr, 1);
				if (ct < pg_ct) {
						die("Contiguous allocation failed\n");
				}
				return mm_map(mm, virt_address, &pr, 1, flags);
		} else if (flags & MMGR_ALLOC_ZERO_COW) {
				void* rv = virt_address;
				struct page_range pr = { pm_zero, 1 };
				while (pg_ct) {
						mm_map(mm, virt_address, &pr, 1, flags | MMGR_MAP_COW);
						virt_address += 4096;
				}
				return rv;
		} else if (flags & MMGR_ALLOC_NP_AOA) {
				void* rv = virt_address;
				mm_aoa_range(mm, virt_address, pg_ct, flags);
				return rv;
		} else {
				void* rv = virt_address;
				do {
						struct page_range pr[16]; size_t ct, ct2, prc = 0;
						ct = ct2 = mm_alloc_pm(pg_ct, pr, 16);
						pg_ct -= ct;
						while (ct) {
								ct -= pr[prc].count;
								prc++;
						}
						 mm_map(mm, virt_address, &pr, prc, flags);
						 virt_address += 4096 * ct2;
				} while (pg_ct);
				return rv;
		}
}

void* mm_extend_vmem(struct mm* mm, void* ptr, size_t pg_ct, size_t new_pg_ct, int flg)
{
		size_t new_pmem = new_pg_ct - pg_ct, pm_res, p0c = 0, p1c = 0;
		void *rv, *p0 = ptr, *p1;
		struct page_range prs[128];
		if (!ptr || new_pg_ct <= pg_ct)
				return NULL;
		/* reserve virtual memory */
		rv = mm_reserve_vmem(mm, new_pg_ct, flg);
		if (!rv)
				return NULL;

		/* remap the existing pages */
		p1 = rv;
		while (pg_ct) {
				struct page_range pr;
				pr.base = mm_page_get_pmem(mm, p0);
				pr.count = 1; flg = 0;
				if (!mm_map(mm, p1, &pr, 1, flg)) {
						if (p0c) /* undo the new mapping */
								mm_unmap(mm, rv - p0c * 4096, p0c);
						return NULL;
				}
				p0c++; pg_ct--;
				p0 += 4096;
				p1 += 4096;
		}
		/* now get the physical memory and map it */
		while (new_pmem) {
				pm_res = mm_alloc_pm(new_pmem, prs, 128);
				if (!pm_res) {
						/* out of pmem */
						mm_free_vmem(mm, rv + p0c * 4096, p1c);
						mm_unmap(mm, rv, p0c);
						return NULL;
				}
				if (!mm_map(mm, p1, prs, 128, flg)) {
						/* cannot happen on reserved mem */
						cprintf(KFMT_ERROR, "Error while mapping virtual memory which was already reserved.");
						while (1);
				} else {
						p1 += pm_res * 4096;
						p1c += pm_res;
				}
		}
		/* and unmap the old memory */
		mm_unmap(mm, ptr, p0c);
		return rv;
}

void mm_free_vmem(struct mm* mm, void* virt_address, size_t pg_ct)
{
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};

		/* check every page */
		while (pg_ct--) {
				/* first get the references to the structures */
				rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);

				if (rv == 0) { /* present page */
						uint64_t b;
						/* get the physical memory */
						if (!cpu.has_pae)
								b = ((struct pte32*)e)->addr * 0x1000;
						else
								b = ((struct pte64*)e)->addr * 0x1000;
						/* concat if possible */
						if (pr.count) {
								if (pr.base + 4096 * pr.count == b)
										pr.count++;
								else {
										/* deallocate */
										mm_free_pm(&pr, 1);
										pr.count = 0;
								}
						} else {
								pr.base = b;
								pr.count = 1;
						}
				} else if (e) { /* AOW etc. */
						bzero(e, cpu.has_pae ? 8 : 4);
				} else {
						/* invalid address */
						die("Invalid virtual address specified in free_vmem.\n");
				}

				/* advance */
				virt_address += 4096;
		}

		/* remove remaining pmem */
		if (pr.count)
				mm_free_pm(&pr, 1);
}

int mm_page_walk(struct mm* mm, void* vmem, void** p, void** e, int* lv,
				uint32_t* of, void*** cntr, void*** cntrm)
{
#ifdef __x86_64__
		return mm_page_walk64(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
#else
		if (cpu.has_pae)
				return mm_page_walk36(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
		else
				return mm_page_walk32(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
#endif
}

uint64_t mm_page_get_pmem(struct mm* mm, void* virt_address)
{
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};

		/* first get the references to the structures */
		rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);

		if (!rv)
				return (uint64_t)-1;
		else if (!lv) {
				if (cpu.has_pae)
						return ((struct pte64*)e)->addr * 0x1000;
				else
						return ((struct pte32*)e)->addr * 0x1000;
		} else { /* ignore PAT bit */
				if (cpu.has_pae)
						return (((struct pte64*)e)->addr & ~1ull) * 0x1000;
				else
						return (((struct pte32*)e)->addr & ~1) * 0x1000;
		}
}

int mm_handle_pagefault(struct mm* mm, void* eip, uint32_t seg_error, void* cr2)
{
		extern struct kio_region kb_reg; /* for I/O diag */
		int lv, rv; uint32_t of; struct pte64 *p, *e; struct pte32 *ps, *es;
		void **cntr, **cntrm;

		/* first get the references to the structures */
		rv = mm_page_walk(mm, cr2, &p, &e, &lv, &of, &cntr, &cntrm);
		ps = (void*)p; es = (void*)e;

		/* then check the error code */
		/* bits: 0=present, 1=write, 2=user, 3=res, 4=nx */

		if (seg_error & 1) { /* some sort of access violation */
				if (seg_error & 8) { /* reserved bits */
						uint32_t hi, lo;
						cprintf(KFMT_ERROR, "Page lookup through %p contained entries"
								" which have reserved bits set. This indicates"
								" either page table corruption or sloppy programming.\n", cr2);
						printf("seg_error: %08x\n", seg_error);
						printf("level=%d, entry=%u\n", lv, of);
						if (cpu.has_pae)
								printf("entry: %016llx\n", *(uint64_t*)e);
						else
								printf("entry: %08x\n", *(uint32_t*)es);
						/* Show MSR */
						asm ("rdmsr" : "=a" (lo), "=d" (hi) : "c" (0xc0000080));
						printf("MSR: %08x%08x\n", hi, lo);
				} else { /* regular access error */
						uint64_t pm; int w, u, x, tlb = 0;
						const char* errstr; uint32_t avl;

						/* get the info */
						if (!cpu.has_pae) {
								pm = es->addr * 0x1000;
								x = 1;
								w = es->w;
								u = es->u;
								avl = es->ign;
						} else {
								pm = e->addr * 0x1000;
								x = !e->xd;
								w = e->w;
								u = e->u;
								avl = e->ign | (e->ign2 << 3);
						}
						/* create the errstr */
						if (seg_error & 16) {
								if (x) { /* check for NX in directoy */
										tlb = 1;
								} else
										errstr = "no execute";
						} else if (seg_error & 4) {
								if (u)
										tlb = 1;
								else
										errstr = "kernel";
						} else if (seg_error & 2) {
								if (w) /* we assume consistent directories */
										tlb = 1;
								else if (avl & 1) { /* COW */
										size_t pg_ct = 1; struct page_range pr;
										if (lv > 0) {
												die("COW on large pages not implemented yet\n");
										}
										if (mm_alloc_pm(pg_ct, &pr, 1)) {
												/* FIXME: Shootdown needed? No stale data would cause
												 * another COW and this can be detected in the PF handler. */
												die("COW not implemented\n");
										} else {
												die("unable to allocate memory for COW\n");
										}
								} else
										errstr = "read only";
						}

						if (tlb) {
								uint8_t id = 0;
								if (nproc > 1)
										id = smp_processor_id();
								rprintf(&kb_reg, "[%u] TLB fl: %p\n", id, cr2);
								flush_tlb_single(cr2);
								return 0;
						}

						/* print the error */
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
								" but is not allowed to do so as page is marked as %s\n",
								eip, (seg_error & 2) ? "write to" : ((seg_error & 16) ?
								"fetch instructions from": "read from"),
								cr2, errstr);
						printf("The page is %s and present\n", lv ? (lv > 1 ? "huge" : "large") : "regular");
						printf("it points to physical memory at %#.16llx\n", pm);
				}
		} else { /* encountered nonpresent page */
				uint64_t flags = 0;
				/* get flag bits */
				if (!cpu.has_pae) { /* pte32 */
						if (es) /* there's sth. */
								flags |= *(uint32_t*)es;
						else
								die("level 2 missing\n");
				} else {
						if (e)
								flags |= *(uint64_t*)e;
						else
								die("level 2 or 4 missing\n");
				}

				/* check for known codes */
				flags >>= 1;
				/* CAUTION: Swap IDs have to keep AVL field free */
				if (flags & (1 << 11)) { /* allocate on access */
						size_t pg_ct = 1; struct page_range pr;
						if (lv > 0) {
								/* TODO: cont alloc & large pages */
								die("no AOA large pages implemented yet!\n");
						}
						/* alloc & print info */
						if (mm_alloc_pm(pg_ct, &pr, 1)) {
								/* level0 -> no new pointers */
								if (!cpu.has_pae) {
										es->addr = (uint32_t)(pr.base / 4096);
										es->p = 1;
								} else {
										e->addr = pr.base / 4096;
										e->p = 1;
								}
								flush_tlb_single(cr2);
								rprintf(&kb_reg, "MM AOW: %p\n", cr2);
								return 0;
						} else {
								die("Out of memory for AOA\n");
						}
				} else {
						/* swapped with ID */
						cprintf(KFMT_INFO, "Swapping in single page with id %llu\n", flags);
						cprintf(KFMT_ERROR, "which is not implemented\n");
						printf("level=%d, entry=%u, ptr=%p\n", lv, of, cr2);
				}
		}


		/* we have to page walk 32/36/64
		// Not present codes:
		// 1 = allocate on access
		//
		// --------------
		// Codes with access violation on present pages: 3 avl bits
		// 0 = regular, i.e. invalid
		// 1 = copy on write
		*/
		return 1;
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
#ifdef __x86_64__
				__asm__("mov %%rbp, %[fp]" : /* output */ [fp] "=r" (fp));
#else
				__asm__("movl %%ebp, %[fp]" : /* output */ [fp] "=r" (fp));
#endif
				/* do the backtrace from ebp to ebp */
				printf("performing stacktrace:\n");
#ifdef __x86_64__
				printf("RBP              ARG-1             ARG-2             ARG-3             ARG-4            FROM\n");
#else
				printf("EBP      ARG-1     ARG-2     ARG-3     ARG-4    FROM\n");
#endif
				do {
						size_t of; const char* sym;
						printf("%p %p %p %p %p %p\n", fp, fp->args[0], fp->args[1],
										fp->args[2], fp->args[3], fp->ret_addr);
						sym = (const char*)elf_get_closest_symbol(fp->ret_addr, &of);
						cprintf(KFMT_INFO, "called from %p (%s%+#lx)\n", fp->ret_addr, sym, of);
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
								printf("Address is located at %s%+#lx\n", sym, of);
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

