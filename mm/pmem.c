/* min_mm.c : Impelements a simple early mmgr operating in 32-bit
 *            protected mode one physical memory only.
 * */

#include "../boot/fixmem.h"
#include "../kernel.h"
#include "../kdata.h"
#include "pmem.h"

static struct mp {
		uint64_t base;
		uint64_t size;
		uint32_t type;
		uint32_t res;
} * const mem_map = FM_MEMORY_MAP; /* transfer to MM+? */

struct fme* const fmm = FM_FREE_MEMORY_MAP;

static struct rme {
		uint64_t base;
		uint64_t size;
} * const rmm = FM_RESV_MEMORY_MAP;
size_t fm_ofs = 0, fm_begin = 0, rm_count = 0;
uint64_t pm_zero = 0;

/*************   PHYSICAL MEMORY ALLOCATION   *********************************/
/* returns nonzero if locked */
int mm_init_pmu(struct pmu* p)
{
		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
				return -1;

		/* we're free to initialize (all full) */
		__builtin_memset(p->entries, 0xff, sizeof(p->entries));

		/* now release */
		bzero(p->locks, sizeof(p->locks));
		p->free_ct[3] = 0;
		p->free_ct[2] = 0;
		p->free_ct[1] = 0;
		p->free_ct[0] = 0;
		return 0;
}

/* returns nonzero if locked */
int mm_init_rcp(struct pmu* p)
{
		uint16_t rem, fc[4] = { 4096, 4096, 4096, 4096 };

		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
				return -1;

		/* check if last */
		rem = p->free_ct[3];

		if (rem != 0xffff) {
				for (size_t i = 0; i < 4; i++) {
						if (rem >= 4096) { /* still easy */
								/* set everything reclaimable */
								__builtin_memset(&p->entries[i], 0xff,
												sizeof(p->entries[i]));
								/* advance */
								rem -= 4096;
						} else {
								/* fill partially (0, 2, 7) */
								for (uint16_t j = 0, of = 0; j < 128; of += 32, j++) {
										uint32_t val = 0;
										if (rem > of) {
												if (rem - of >= 32) /* set full */
														val = 0xffffffff;
												else /* set partial */
														val = (1 << (rem - of)) - 1;
										}
										p->entries[i].lvl0[j] = val;
								}
								for (uint16_t j = 0, of = 0; j < 32; of += 128, j++) {
										uint32_t val = 0;
										if (rem > of) {
												if (rem - of >= 128)
														val = 0xffffffff;
												else /* set partial */
														val = (1 << rdiv(rem - of, 4)) - 1;
										}
										p->entries[i].lvl2[j] = val;
								}
								p->entries[i].lvl7 = (1 << rdiv(rem, 32)) - 1;

								/* advance */
								fc[i] = rem;
								rem = 0;
						}
				}
		} else /* very easy: everything is reclaimable */
				__builtin_memset(p->entries, 0xff, sizeof(p->entries));

		/* now release */
		bzero(p->locks, sizeof(p->locks));
		p->free_ct[3] = fc[3];
		p->free_ct[2] = fc[2];
		p->free_ct[1] = fc[1];
		p->free_ct[0] = fc[0];
		return 0;
}

/* lock: 2 bts in lvl7 
 * -> 4/6 8/5 16/4 32/3 64/2 128/1 256/1 */
/* assume caller know about locking and has made the right reservations
 * for us to operate freely on the range given by the limits. */
uint32_t mm_pmue_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bsir, uint64_t base)
{
		uint32_t* bitfield, rv = 0;

		/* set the reference */
		switch (lvl) {
				case 7:
						bitfield = &p->lvl7;
						break;
				case 6:
						bitfield = p->lvl6;
						break;
				case 5:
						bitfield = p->lvl5;
						break;
				case 4:
						bitfield = p->lvl4;
						break;
				case 3:
						bitfield = p->lvl3;
						break;
				case 2:
						bitfield = p->lvl2;
						break;
				case 1:
						bitfield = p->lvl1;
						break;
				case 0:
						bitfield = p->lvl0;
						break;
				default:
						while (1);
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
				/* test each bit */
				asm goto("bt %0, %1\n"
						 "jc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : carry);

				/* we've got a free entry at i */
				if (lvl > 0) {
						uint32_t rv2, prr = *n_pr, bs = 0;
						/* go deeper */
						rv2 = mm_pmue_get_range(p, i * 2, i * 2 + 1,
								lvl - 1, pg_ct, pr, pr_ct, n_pr, &bs, base);
						/* set counts */
						rv += rv2;
						pg_ct -= rv2;
						pr += *n_pr - prr;
						pr_ct -= *n_pr - prr;
						/* update by checking bits set in range */
						if (bs == 2) {
								asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
								(*bsir)++;
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct & !rv2))
								break;
				} else {
						uint64_t b = base + i * 4096, bp = 1;

						/* set the bit */
						asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");

						/* and create the mapping or extend it */
						if (*n_pr)
								bp = pr[-1].base + 4096 * pr[-1].count;
						if (b == bp)
								pr[-1].count++;
						else {
								if (!pr_ct) { /* rollback */
										asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
										break;
								}
								/* or advance */
								pr->base = b;
								pr->count = 1;
								pr_ct--;
								(*n_pr)++;
								pr++;
						}

						rv++;
						pg_ct--;
						(*bsir)++;
						/* check for done */
						if (!pg_ct)
								break;

				}
				continue;

carry:
				(*bsir)++;
		}

		return rv;
}

uint32_t mm_rcpe_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bfir, uint64_t base)
{
		uint32_t* bitfield, rv = 0;

		/* set the reference */
		switch (lvl) {
				case 7:
						bitfield = &p->lvl7;
						break;
				case 2:
						bitfield = p->lvl2;
						break;
				case 0:
						bitfield = p->lvl0;
						break;
				default:
						while (1);
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
				/* test each bit */
				asm goto("bt %0, %1\n"
						 "jnc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : nocarry);

				/* we've got a reclaimable entry at i */
				if (lvl > 0) {
						uint32_t rv2, prr = *n_pr, bf = 0, mul;
						mul = (lvl == 2) ? 4 : 32;
						/* go deeper */
						rv2 = mm_rcpe_get_range(p, i * mul, (i + 1) * mul - 1,
								(lvl == 2) ? 0 : 2, pg_ct, pr, pr_ct, n_pr, &bf, base);
						/* set counts */
						rv += rv2;
						pg_ct -= rv2;
						pr += *n_pr - prr;
						pr_ct -= *n_pr - prr;
						/* update by checking bits free in range */
						if (bf == mul) {
								asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
								(*bfir)++;
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct && !rv2))
								break;
				} else {
						uint64_t b = base + i * 4096, bp = 1;

						/* clear the bit */
						asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");

						/* and create the mapping or extend it */
						if (*n_pr)
								bp = pr[-1].base + 4096 * pr[-1].count;
						if (b == bp)
								pr[-1].count++;
						else {
								if (!pr_ct) { /* rollback */
										asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
										break;
								}
								/* or advance */
								pr->base = b;
								pr->count = 1;
								pr_ct--;
								(*n_pr)++;
								pr++;
						}

						rv++;
						pg_ct--;
						(*bfir)++;
						mm_scrub_single_page(b);
						/* check for done */
						if (!pg_ct)
								break;
				}
				continue;

nocarry:
				(*bfir)++;
		}

		return rv;
}

/* is used to really set entries in a pmu/rcp */
uint32_t mm_fmrc_get(struct pmu* p, uint32_t idx, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr, uint64_t base)
{
		size_t i; uint32_t msk = 0x00000003, rv = 0;
		struct pmue* e = &p->entries[idx];
		/* lock is 2 lvl7 bits wide (256 pages) so use it sparingly */

		/* first skip all full/empty lvl7 ranges (2 at a time) */
		uint32_t prc = 0;
		for (i = 0; i < 16; i++) {
				uint8_t bt = ((e->lvl7 & msk) >> 2 * i);
				if (free ? (bt != 3) : (bt)) { /* all set/unset */
						uint32_t rv2 = 0, pcc = prc, bsir = 0;
						/* some bits set: try to lock */
						asm goto("lock bts %0, %1\n"
							"jc %l2\n" : : "r" (idx * 16 + 2 * i),
							"m" (*p->locks) : "cc" : carry);

						/* we hold the lock (else jump to carry) */
						if (free)
								rv2 = mm_pmue_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
										pr, pr_ct, &prc, &bsir, base);
						else
								rv2 = mm_rcpe_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
										pr, pr_ct, &prc, &bsir, base);
						pr_ct -= prc - pcc;
						pr += prc - pcc;
						*n_pr += prc - pcc;
						rv += rv2;
						pg_ct -= rv2;

						/* release lock */
						asm("btr %0, %1\n" : : "r" (idx * 16 + 2 * i),
							"m" (*p->locks) : "cc");

						if (!pg_ct || (!pr_ct && !rv2))
								return rv;
				}
carry:
				/* advance */
				msk <<= 2;
		}

		return rv;
}

/* used for getting pages which are marked as free/reclaimable */
uint32_t mm_fmrc_alloc_pm(struct fme* fm, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr)
{
		uint32_t rv = 0; uint64_t base = fm->base;
		size_t i, j; uint64_t mem = (free ? fm->pmu : fm->rcp);

		for (i = 0; i < fm->ec; i++) {
				struct pmu* p = (void*)(size_t)mem;
				/* skip if above limit */
				if (mem + 4096 > 0x100000000)
						break;

				/* operate on pmu/rcp */
				if (p->free_ct[0] == 0xffff) {
						if (free) {
								if (mm_init_pmu(p))
										continue; /* if locked */
						} else {
								if (mm_init_rcp(p))
										continue; /* if locked */
						}
				}

				/* check for free/reclaimable counts */
				for (j = 0; j < 4; j++) {
						if (p->free_ct[j] > 0) {
								uint32_t rv2, np = 0;
								/* operate on lock */
								rv2 = mm_fmrc_get(p, j, pg_ct, free, pr,
												pr_ct, &np, base);

								*n_pr += np;
								pr_ct -= np;
								pr += np;
								rv += rv2;
								pg_ct -= rv2;
								/* update count */
								p->free_ct[j] -= rv2;
								/* exit if done or list exhausted (and no extension) */
								if (!pg_ct || (!pr_ct && !rv2))
										return rv;
						}

						/* advance base */
						base += 4096 * 4096;
				}
		}

		return rv;
}

uint32_t mm_alloc_pm(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct)
{
		size_t i; uint32_t rv = 0, r2 = 0, pr_o = 0;

retry:
		for (i = fm_begin; i < fm_ofs; i++) {
				/* skip if scrubbing is needed */
				if (!r2 && !fmm[i].free_pages)
						continue;

				/* collect free pages */
				if (fmm[i].free_pages) {
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 1, pr + pr_o,
										pr_ct - pr_o, &pr_o);
						rv += rv2;
						pg_ct -= rv2;
						__sync_sub_and_fetch(&fmm[i].free_pages, rv2);
						if (pg_ct && !r2) /* skip scrub for now */
								continue;
						else if (!pg_ct)
								goto done;
				}

				/* check for reclaimable */
				if (r2 && fmm[i].reclaimable_pages) {
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 0, pr + pr_o,
										pr_ct - pr_o, &pr_o);
						rv += rv2;
						pg_ct -= rv2;
						__sync_sub_and_fetch(&fmm[i].reclaimable_pages, rv2);
						if (!pg_ct)
								goto done;
				}
		}

		/* scrub enabled */
		if (pg_ct && !r2) {
				r2 = 1;
				goto retry;
		}

done:
		if (!rv) { /* OOM */
				die("OOM");
		}

		/* null-terminate */
		if (pr_o < pr_ct) {
				pr[pr_o].base = 0;
				pr[pr_o].count = 0;
		}
		return rv;
}

/* rcp: higher-levels<=>Exists; pmu: higher-levels: completely used */
uint32_t mm_alloc_pm_flg(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct, int flg)
{
		die("not implemented\n");
		return 0;
}

void pmue_set_range(struct pmue* e, uint16_t start, uint16_t end, int unset, int is_rcp)
{
		/* we also have to consider the values at the fringes,
		 * as start & end don't have to be perfectly aligned. */
		void psr(uint32_t* lv, uint32_t* pr, uint16_t div, uint16_t div2) {
				uint16_t i, j;
				if (pr) { /* align start & end to boundaries and set fringe values */
						die("fringes!\n"); /* TODO: fix it */
				}
				for (i = start / div; i <= end / div; i++) {
						int lwr = (i * div >= start); /* starts at bit0 */
						int hgr = (end - i * div >= div); /* goes until bit 31 */
						if (lwr && hgr) {
								lv[i] = unset ? 0 : 0xffffffff;
								continue;
						} else if (lwr) {
								uint8_t bit = (end - i * div) * 32 / div + 1;
								uint32_t mask = (1 << bit) - 1;
								lv[i] &= ~mask;
								if (!unset)
										lv[i] |= mask;
						} else if (hgr) {
								uint8_t bit = (start - i * div) * 32 / div;
								uint32_t mask = ~((1 << bit) - 1);
								lv[i] &= ~mask;
								if (!unset)
										lv[i] |= mask;
						} else {
								/* in-between */
								uint8_t b1 = (end - i * div) * 32 / div + 1;
								uint8_t b2 = (start - i * div) * 32 / div;
								uint32_t m1 = (1 << b1) - 1;
								uint32_t m2 = ~((1 << b2) - 1);
								uint32_t mask = m1 & m2;
								lv[i] &= ~mask;
								if (!unset)
										lv[i] |= mask;
						}
				}
		}
		psr(e->lvl0, NULL, 32, 0);
		if (!is_rcp)
				psr(e->lvl1, e->lvl0, 64, 32);
		psr(e->lvl2, is_rcp ? e->lvl0 : e->lvl1, 128, is_rcp ? 32 : 64);
		if (!is_rcp) {
				psr(e->lvl3, e->lvl2, 256, 128);
				psr(e->lvl4, e->lvl3, 512, 256);
				psr(e->lvl5, e->lvl4, 1024, 512);
				psr(e->lvl6, e->lvl5, 2048, 1024);
		}
		psr(&e->lvl7, is_rcp ? e->lvl2 : e->lvl6, 4096, is_rcp ? 128 : 2048);
}

/* rcp: 7,2,0 set if any below; pmu all, set if all below are used */
void pmu_set_range(struct pmu* pm, uint16_t start, uint16_t end, int unset, int is_rcp)
{
		struct pmue* e; uint16_t fc = 0;
		/* we have to lock for keeping higher levels consistent 
		 * else we could do without as we own the ranges exclusively. */

redo:
		/* lock is 64 bit wide 4x16 (2 lvl7 bits per bit) */
		for (uint16_t i = start / 256; i <= end / 256; i++) {
				uint16_t o = i * 256, p1, p2;
				e = pm->entries + i / 16;
				/* first check if we can skip */
				if (is_rcp) {
						if (unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
								continue; /* unsafe as lock was not
						 * checked (could be set concurrently). But 
						 * this is not relevant as it'd be user error. */
				} else {
						if (!unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
								continue; /* already all set */
				}

				/* then try to acquire the lock */
				asm goto("lock bts %0, %1\n"
					"jc %l2\n" : : "r" (2 * i),
					"m" (*pm->locks) : "cc" : carry);
				/* calculate the range */
				p1 = max(o, start);
				p2 = min(o + 256, end);
				p1 -= (i / 4) * 4096;
				p2 -= (i / 4) * 4096;
				/* we now hold the lock so modify the acutal entry */
				pmue_set_range(e, p1, p2, unset, is_rcp);

				/* release it */
				asm("btr %0, %1\n" : : "r" (2 * i),
					"m" (*pm->locks) : "cc");
				continue;

carry: 			/* lock failed */
				fc++; /* set failure count and continue (retry later) */
		}

		if (fc) { /* busy loop as these locks are held for ns */
				fc = 0;
				goto redo;
		}
}

void mm_free_pm(struct page_range* pr, uint32_t pr_ct)
{
		for (uint32_t i = 0; i < pr_ct; i++) {
				struct fme* fm; struct pmu* rc;
				uint64_t ofs, fp, lp;
				for (fm = fmm + fm_begin; fm < fmm + fm_ofs; fm++)
						if (pr->base >= fm->base && pr->base < fm->base + fm->size)
								break; /* just assume integrity */
				ofs = pr->base - fm->base;
				rc = (struct pmu*)fm->rcp;
				/* set first and last page */
				fp = ofs / 4096;
				lp = fp + pr->count - 1;

				for (uint32_t idx = fp / 4096 / 4; idx <= lp / 4096 / 4; idx++) {
						uint16_t s, e; uint64_t o = idx * 4096 * 4;
						/* get the limits */
						s = (fp > o ? fp - o : 0);
						e = max(lp - o, 4096 * 4 - 1);
						/* set the rcp */
						pmu_set_range(&rc[idx], s, e, 0, 1);
				}
		}
}
/*************   INITIALIZATION AFTER BOOT CONTROL TRANSFER  ******************/
void *cur_pmu = VM_PMU_BASE, *cur_rcp = VM_RCP_BASE;
void* cur_percpu = VM_MM_PER_CPU_BASE;
struct mm mm_kernel; uint64_t pm_count = 0;

struct mm_cpu_ctx mm_create_ctx()
{
		struct mm_cpu_ctx rv = {0};
		rv.cur_mm = &mm_kernel;
		rv.scrub_page = __sync_fetch_and_add(&cur_percpu, 4096);
		if (cur_percpu >= VM_MM_PER_CPU_LIMIT) {
				die("Out of MM percpu context slots.\n");
		}
		return rv;
}
/* full mapping & init of high elements */
void mm_fm_init(struct fme* fm)
{
		uint64_t b = fm->base - 2 * fm->ec * 4096, b1;
		uint32_t ec2 = fm->ec; b1 = b + fm->ec * 4096;
		struct pmu *p, *r; struct page_range pr; uint16_t rec;
		uint32_t lst = 0;

		/* get the limit */
		rec = (fm->size / 4096) % 16384;
		if (rec)
				lst = (fm->size / 4096) / 16384;

		/* before preemption -> no sync needed */
		fm->pmu = (uint64_t)cur_pmu;
		fm->rcp = (uint64_t)cur_rcp;
		p = cur_pmu; r = cur_rcp;
		pm_count += fm->size;
	
		/* add sizes */
		cur_pmu += ec2 * 4096;
		cur_rcp += ec2 * 4096;
		if (cur_pmu >= VM_PMU_LIMIT || cur_rcp >= VM_RCP_LIMIT) {
				/* we should cap and inform the user */
				ec2 = (cur_pmu - VM_PMU_LIMIT) / 4096; /* only on PMUs as LIMITS are identical*/
				cprintf(KFMT_WARN, "%u PMUs discarded -> %uM of memory lost\n",
								ec2, ec2 * 64);
				fm->ec -= ec2;
				ec2 = fm->ec;
		}

		/* skip completely if neccessary */
		if (!ec2)
				return;

		/* map & init the pmus */
		pr.base = b;
		pr.count = ec2;
		mm_map(&mm_kernel, p, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
		pr.base = b1;
		pr.count = ec2;
		mm_map(&mm_kernel, r, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);

		/* now init the leftovers */
		for (uint32_t i = 0; i < ec2; i++) {
				struct pmu* pt = NULL; int rd = 0;
				/* check for exception */
				if (b > 0x100000000 - 4096)
						pt = &p[i];

redo:
				/* initialize */
				if (pt) {
						/* clear the locks */
						bzero(pt->locks, sizeof(pt->locks));
						/* invalidate the counts and put rec in the last one */
						pt->free_ct[0] = 0xffff;
						pt->free_ct[1] = 0xffff;
						pt->free_ct[2] = 0xffff;
						if (rec)
								pt->free_ct[3] = (i == lst) ? rec : 0xffff;
						else
								pt->free_ct[3] = 0xffff;
				}

				/* check for second run */
				if (!rd && (b1 > 0x100000000 - 4096)) {
						pt = &r[i];
						rd = 1;
						goto redo;
				}

				/* advance */
				b += 4096;
				b1 += 4096;
		}
}

void mmgr_reinit()
{
		uint32_t* ptr = FM_FREE_MEMORY_MAP;
		fm_ofs = ptr[-1];
		fm_begin = ptr[-2];
		rm_count = ptr[-3];
		pm_zero = *(uint64_t*)(ptr - 5);
		mm_kernel.cr3 = *(uint64_t*)(ptr - 7);
		mm_kernel.ctx = FM_VIRTUAL_MAPPING;
		mm_kernel.qnd_ptr = VM_QND_BASE;
#ifndef __x86_64__ /* PAE? */
		extern void* mf_map;
		extern void* mm_map36;
		extern void* mm_map32;
		if (ptr[-8] == 1) /* PAE */
				mf_map = &mm_map36;
		else
				mf_map = &mm_map32;
#endif

		/* map the pmus & initialize high pmus */
		for (size_t i = fm_begin; i < fm_ofs; i++) {
				mm_fm_init(fmm + i);
		}

		/* enable NX if needed */
		//if (cpu.e_has_nx)
		//		enable_nx();

		/* allocate the heap */
		void init_kernel_heap();
		init_kernel_heap();
}

void pmue_dump(struct pmue* pu, int level)
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
		printf("pmue/rcpe (at %p) lvl%d entries:\n", pu, level);
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
void pmu_dump(struct pmu* pu, int level)
{
		printf("dumping pmu/rcp (at %p)\n", pu);
		for (int i = 0; i < 4; i++)
				pmue_dump(&pu->entries[i], level);
}
void mm_dump_pmu(size_t fm, size_t n, int is_rcp)
{
		struct pmu* pu;
		if (is_rcp == 2) {
				/* user talk */
				printf("Free mem map contains %lu entries\n", fm_ofs);
				printf("Enumerating maps:\n");
				for (n = 0; n < fm_ofs; n++) {
						size_t cr = 0, cu = 0;
						struct pmu* pu;
						printf("Map %lu: %016llx-%016llx\n", n,
								fmm[n].base, fmm[n].base + fmm[n].size);
						pu = (void*)fmm[n].pmu;
						printf("\tEntry count: %u\n", fmm[n].ec);
				}
				return;
		}
		if (fm > fm_ofs) {
				printf("FM out of range\n");
				return;
		}
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
						(uint32_t)fmm[fm].free_pages,
						(uint32_t)fmm[fm].reclaimable_pages);
		if (is_rcp)
				pu = (void*)fmm[fm].rcp;
		else
				pu = (void*)fmm[fm].pmu;
		if (n > fmm[fm].ec)
				printf("PMU index out of range\n");
		pu += n;
		pmu_dump(pu, 0);
		if (is_rcp)
				pmu_dump(pu, 2);
}

