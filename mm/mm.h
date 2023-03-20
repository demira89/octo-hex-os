/* mm.h : Provides the interface to the mmgr.
 * */

extern struct mm {
		uint64_t cr3;
		void* ctx;
		void* qnd_ptr;
} mm_kernel;

struct page_range;

#define MMGR_ALLOC_COMPLETE   0x00000000 /* allocate right away */
#define MMGR_ALLOC_ZERO_COW   0x00010000 /* copy-on-write */
#define MMGR_ALLOC_NP_AOA     0x00020000 /* allocate-on-access */
#define MMGR_ALLOC_CONTIGUOUS 0x00030000
#define MMGR_ALLOC_32BIT      0x00040000

#define MMGR_AVL_COW 1
#define MMGR_AVL_AOA (1 << 2)

/* physical memory */
uint32_t mm_alloc_pm(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct);
uint32_t mm_alloc_pm_flg(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct, int flg);
void mm_free_pm(struct page_range* pr, uint32_t pr_ct);
void mm_scrub_single_page(uint64_t pm);
int mm_page_scrub();

/* virtual memory */
void* mm_map(struct mm* mm, void* virt_address,
				const struct page_range* prs,
				size_t pr_ct, int flags);
void mm_unmap(struct mm* mm, void* virt_address, size_t pg_ct);
void* mm_reserve_vmem(struct mm* mm, size_t pg_ct, int flags);
void* mm_alloc_vmem(struct mm* mm, void* virt_address, size_t pg_ct, int flags);
void* mm_extend_vmem(struct mm* mm, void* base, size_t pg_ct, size_t new_pg_ct, int flags);
void mm_free_vmem(struct mm* mm, void* virt_address, size_t pg_ct);
void mm_protect(struct mm* mm, void* virt_address, size_t num_pages, int flags);
/* use recursively until return value is zero */
int mm_page_walk(struct mm* mm, void* virt_address, void** parent, void** entry,
			    int* level, uint32_t* offset, void*** container, void*** member_cntnr);
uint64_t mm_page_get_pmem(struct mm* mm, void* virt_address);

int mm_handle_pagefault(struct mm* mm, void* eip, uint32_t seg_error, void* cr2);

