/* heap.c : Implements the heap functions used throughout the kernel. 
 * */

#include "../kernel.h"
#include "../kdata.h"
#include "pmem.h"

extern void* cur_percpu; /* fallback */

void mm_scrub_single_page(uint64_t pm)
{
		void* ptr, *map; struct page_range pr = { pm, 1 };

		/* get the scrubbing virt. address */
		if (cur_percpu > VM_MM_PER_CPU_BASE)
				ptr = per_cpu_ptr()->mm_ctx.scrub_page;
		else
				ptr = cur_percpu;

		/* map the pmem */
		map = mm_map(&mm_kernel, ptr, &pr, 1, MMGR_MAP_WRITE /* no TLB shootdown */
						| MMGR_MAP_WRITE_THROUGH | MMGR_MAP_LOCAL);

		if (!map)
				die("Unable to scrub!\n");

		/* clear it */
		bzero(map, 4096);

		/* unmap */
		mm_unmap(&mm_kernel, map, 1);
}

size_t mm_scrub_pages(size_t i, size_t limit)
{
		size_t j, k, l, np = 0, npl = 0;
		/*printf("scrub_pages(%d, %d)\n", i, limit);
		printf("rc_ct=%d, rcp=%p\n", (size_t)fmm[i].reclaimable_pages, fmm[i].rcp);*/
		if (fmm[i].reclaimable_pages) {
				uint64_t ofs = 0; size_t ct = 0;
				struct pmu* rc = (void*)fmm[i].rcp;
				struct pmu* pu = (void*)fmm[i].pmu;

				for (j = 0; j < 4; j++)
						if (rc->free_ct[j]) { /* reclaimable count */
								/* check and then lock */
								die("iii");
						}
		}

		/* reached the limit or no pages available */
done:
		if (np) {
				extern struct kio_region kb_reg;
				rprintf(&kb_reg, "scrubbed %u pages\n", np);
		}
		return np;
}

int mm_page_scrub()
{
		/* only do limited scrubbing as it affects sleep granularity */
		size_t i, lm = 128;
		for (i = fm_begin; i < fm_ofs && lm; i++) {
				lm -= mm_scrub_pages(i, lm);
		}
		return (lm != 128);
}

