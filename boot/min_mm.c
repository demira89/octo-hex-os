/* min_mm.c : Impelements a simple early mmgr operating in 32-bit
 *            protected mode one physical memory only.
 * */

#include "fixmem.h"
#include "basedefs.h"
#include "../mm/virtmem.h"

static struct mp {
		uint64_t base;
		uint64_t size;
		uint32_t type;
		uint32_t res;
} * const mem_map = FM_MEMORY_MAP; /* transfer to MM+? */

static struct fme
{
		uint64_t base;
		uint64_t size;
		uint64_t free_pages;
		uint64_t reclaimable_pages;
		uint64_t ec;
		uint64_t pmu; /* physical ptr at this time */
		uint64_t rcp; /* likewise */
} * const fmm = FM_FREE_MEMORY_MAP;

static struct rme {
		uint64_t base;
		uint64_t size;
} * const rmm = FM_RESV_MEMORY_MAP;
static size_t fm_ofs = 0, fm_begin = 0, rm_count = 0;

struct pmue { /* physical memory usage entry (1020 bt) */
		uint32_t lvl0[128]; /* 4096 bits for covering 16MiB */
		uint32_t lvl1[64]; /* 2048 bits for 8K blocks */
		uint32_t lvl2[32]; /* 1024 bits for 16K blocks */
		uint32_t lvl3[16]; /* 512 bits for 32K blocks */
		uint32_t lvl4[8]; /* 256 bits for 64K blocks */
		uint32_t lvl5[4]; /* 128 bits for 128K blocks */
		uint32_t lvl6[2]; /* 64 bits for 256K blocks */
		uint32_t lvl7; /* 32 bits for 512K blocks */
};

struct pmu { /* covers 16384 pages (64M) */
		/* 64bt of info */
		uint16_t locks[4];
		uint16_t free_ct[4];
		struct pmue entries[4];
};

/***************   UTILITY FUNCTIONS   ****************************************/
void fmt_fun(char* p, uint64_t v) {
		for (int i = 0; i < 16; i++) {
				char c = (v >> 60);
				if (c > 9)
						c = 'a' + (c - 10);
				else
						c = '0' + c;
				*p++ = c;
				v <<= 4;
		}
}
void fmt_fun2(char* p, uint32_t v) {
		for (int i = 0; i < 8; i++) {
				char c = (v >> 28);
				if (c > 9)
						c = 'a' + (c - 10);
				else
						c = '0' + c;
				*p++ = c;
				v <<= 4;
		}
}

void put32(uint32_t num)
{
		char buf[] = "0x01234567";
		fmt_fun2(buf + 2, num);
		putstr(buf);
}
void nput32(uint32_t num, int min_cc)
{
		int len;
		char buf[] = "----------";
		char* c = &buf[9];
		while (c >= buf) {
				uint8_t rem = num % 10;
				num /= 10;
				*c = '0' + rem;
				c--;
				if (!num) {
						c++;
						break;
				}
		}
		len = 10 - (c - buf); /* c-buf=-1 */
		if (min_cc > 0) {
				while (min_cc-- > len)
						putstr(" ");
		}
		putstr(c);
		if (min_cc < 0) {
				while (len + min_cc++ < 0)
						putstr(" ");
		}
}
void put64(uint64_t num)
{
		char buf[] = "0x0123456789abcdef";
		fmt_fun(buf + 2, num);
		putstr(buf);
}

void bzero(void* ptr, size_t s)
{
		register uint8_t* p = (uint8_t*)ptr;
		if (s >= 8) {
				/* first align to dword boundary */
				while ((size_t)p % 4) {
						*p++ = 0;
						s--;
				}
				/* now clear uint32_t-sized blocks */
				while (s >= 4) {
						*(uint32_t*)p = 0;
						p += 4;
						s -= 4;
				}
		}
		/* set remaining memory */
		while (s--)
				*p++ = 0;
}

void mem_cpy(void* d, void* s, size_t c)
{
		char *p1 = d, *p2 = s;
		while (c--)
				*p1++ = *p2++;
}
/*************   MEMORY MAP GENERATION   **************************************/
void mm_add_free(uint64_t b, uint64_t s)
{
		if (!s)
				return;
		bzero(&fmm[fm_ofs], sizeof(*fmm));
		fmm[fm_ofs].base = b;
		fmm[fm_ofs++].size = s;
}

/* for providing valid MMIO ranges */
void mm_add_reserved(uint64_t b, uint64_t s)
{
		rmm[rm_count].base = b;
		rmm[rm_count++].size = s;
}

void mm_sub_block(uint64_t b, uint64_t s)
{
		size_t ofs;
		uint64_t end = b + s;
		if (!s)
				return;
		/* search for conflicting entries */
		for (ofs = 0; ofs < fm_ofs; ofs++) {
				uint64_t b2 = fmm[ofs].base;
				uint64_t end2 = b2 + fmm[ofs].size;

				/* any overlap? */
				if ((end > b2) && (b < end2)) {
						putstr("O");
						if (b <= b2) {
								/* overlap below */
								if (b + s >= end2) {
										/* complete overlap */
										if (ofs + 1 < fm_ofs) { /* swap out */
												fmm[ofs--] = fmm[--fm_ofs];
												fmm[fm_ofs].base = 0;
												fmm[fm_ofs].size = 0;
										} else
												break;
								} else {
										/* only reduce size */
										fmm[ofs].size = end2 - end;
										fmm[ofs].base = end;
								}
						} else if (end >= end2) {
								/* overlap on top end */
								fmm[ofs].size = b - b2;
						} else {
								/* overlap in center */
								fmm[fm_ofs].base = end; /* top end */
								fmm[fm_ofs++].size = end2 - end;
								fmm[ofs].size = b - b2; /* lower end */
						}
				}
		}
}

void mm_sort_and_merge()
{
		size_t n = fm_ofs, i; int new_n;
		/* bubble sort */
		do {
				new_n = 1;
				for (i = 0; i < n - 1; i++) {
						if (fmm[i].base > fmm[i + 1].base) {
								struct fme fm = fmm[i + 1];
								fmm[i + 1] = fmm[i];
								fmm[i] = fm;
								new_n = i + 1;
						}
				}
				n = new_n;
		} while (n > 1);
		/* do the same with the reserved entries */
		do {
				new_n = 1;
				for (i = 0; i < n; i++) {
						if (rmm[i].base > rmm[i + 1].base) {
								struct rme rm = rmm[i + 1];
								rmm[i + 1] = rmm[i];
								rmm[i] = rm;
								new_n = i + 1;
						}
				}
		} while (n > 1);

		/* merge adjacent elements */
		for (i = 0; i < fm_ofs - 1; i++)
				if (fmm[i].base + fmm[i].size >= fmm[i + 1].base) {
						fmm[i].size = (fmm[i + 1].base + fmm[i + 1].size) - fmm[i].base;
						if (i + 1 < fm_ofs) {
								size_t n;
								for (n = i + 1; n < fm_ofs - 1; n++)
										fmm[n] = fmm[n + 1];
						}
						fm_ofs--;
						fmm[fm_ofs].base = 0;
						fmm[fm_ofs].size = 0;
				}
}
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
										putstr("rb");
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
										putstr("rb");
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
						/* scrubbing */
						bzero((void*)(size_t)b, 4096);
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
				putstr("OOM");
				while (1);
		}

		/* null-terminate */
		if (pr_o < pr_ct) {
				pr[pr_o].base = 0;
				pr[pr_o].count = 0;
		} else if (pr_o > 1) { /* when list */
			put32(pr_o); putstr(" < "); put32(pr_ct); put_nl();
			puts("pr not null-terminated");
		}
		return rv;
}

uint32_t mm_alloc_pm_cont(uint32_t pg_ct, struct page_range* pr)
{
		return 0;
}
/******************************************************************************/


/* minimal init, i.e. just mark as invalid */
void mm_fm_init(struct fme* fm, uint32_t ec, uint16_t rec)
{
		uint64_t b = fm->base - 2 * ec * 4096;
		uint32_t ec2 = ec;

		/* init the pmu */
redo:
		do {
				struct pmu* p = (void*)(size_t)b;
				if (b > 0x100000000 - 4096) /* the rest will be done in the */
						return; /* 64-bit/PAE code loaded later */
				else
						b += 4096;

				/* clear the locks */
				bzero(p->locks, sizeof(p->locks));
				/* invalidate the counts and put rec in the last one */
				p->free_ct[0] = 0xffff;
				p->free_ct[1] = 0xffff;
				p->free_ct[2] = 0xffff;
				p->free_ct[3] = (ec == 1) ? rec : 0xffff;
		} while (ec--);
		/* also for rcp */
		if (ec2) {
				ec = ec2;
				ec2 = 0;
				goto redo;
		}

}

extern uint64_t cr3_val;
uint32_t bits_to_set = 0;
void* vm_mapping = FM_VIRTUAL_MAPPING;
void* pm_mapping;
uint64_t pm_zero;
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

struct vmdesc {
		uint64_t vga_base;
		uint64_t vga_size;
		uint64_t vga_virt;
};

struct vm_pg_ptrs32 {
		uint32_t cur;
		uint32_t pd;
		uint32_t pts[1024]; /* 4M PTs */
		struct vmdesc video_memory;
};

struct pm_pg32_ptrs { /* one PD with 1024 PTs */
		struct pte32* pd; /* The PD */
		struct pte32 *pt1, *pt2; /* Low and hight 4M PT */
		uint32_t ec_pt;
		struct {
				struct pte32* pt; /* vm is in vp->pts */
				uint32_t idx; /* max 4*512 */
		} extra_pts[64];
};

struct vm_pg_ptrs36 { /* hybrid structure as pte64s are saved here */
		struct pte64 pdps[4]; /* 32-bytes /w page alignment in lowmem */
		uint32_t cur;
		uint32_t pdp[4]; /* 4 PDs */
		uint32_t pts[2048]; /* all 2M PTs */
		struct vmdesc video_memory;
};

struct pm_pg36_ptrs { /* changing CR3 reloads all 4 PDPs */
		struct pte64* p; /* 4 PDPTEs */
		struct pte64* pds[4]; /* The 4 PDs */
		struct pte64 *pt1, *pt2; /* Top and bottom 2M PT */
		uint32_t ec_pt;
		struct {
				struct pte64* pt; /* vm is in vp->pts */
				uint32_t idx; /* max 4*512 */
		} extra_pts[64];
};

struct vm_pg_ptrs64 {
		uint64_t cur;
		uint64_t pml4;
		uint64_t pml4e[512]; /* pdps */
		uint64_t pdpte[512]; /* pds (struct pdpte_ptr) */
		struct vmdesc video_memory;
};

struct vm_pdpte_ptr {
		uint64_t pds[512]; /* page directories */
		uint64_t pdes[512]; /* pdes (struct pde_ptr) */
};

struct vm_pde_ptr {
		uint64_t pts[512]; /* page tables */
};

struct pm_pg64_ptrs {
		struct pte64 *p, *p1, *p2, *pl1, *pl2, *pt1, *pt2;
		struct vm_pdpte_ptr *m1, *m2;
		struct vm_pde_ptr *n1, *n2;
		uint16_t ec_pdpt, ec_pd, ec_pt; /* counts */
		struct {
				struct pte64* pdpt;
				struct vm_pdpte_ptr* map;
				uint32_t idx; /* in PML4 */
		} extra_pdpts[8];
		struct {
				struct pte64* pd;
				struct vm_pde_ptr* map;
				uint32_t idx; /* max 512*512 */
		} extra_pds[24];
		struct {
				struct pte64* pt; /* vm is in map n */
				uint32_t idx; /* max 512*512*512 */
		} extra_pts[64];
};

void mm_pg64_init()
{
		struct page_range pr;
		struct vm_pg_ptrs64* vp = vm_mapping;
		struct pm_pg64_ptrs* pp = (void*)(vp + 1);
		struct pte64 *p, *p1, *p2, *pl1, *pl2, *pt1, *pt2;
		struct vm_pdpte_ptr *m1, *m2;
		struct vm_pde_ptr *n1, *n2;

		/* clear the mappings */
		bzero(vp, sizeof(*vp));
		vp->cur = 0xfffffffffffff000;
		bzero(pp, sizeof(*pp));

		/* first get PML4 table (scrubbed i.e. all np) */
		mm_alloc_pm(1, &pr, 1);
		cr3_val = pr.base;
		vp->pml4 = vp->cur; // f -> 10
		vp->cur -= 4096;
		p = (void*)(size_t)pr.base;

		/* and create two entries (base+high):
		 * --> first the lower */
		mm_alloc_pm(1, &pr, 1);
		p1 = (void*)(size_t)pr.base;
		vp->pml4e[0] = vp->cur; // e -> 11
		vp->cur -= 4096;
		/* and the upper end */
		mm_alloc_pm(1, &pr, 1);
		p2 = (void*)(size_t)pr.base;
		vp->pml4e[511] = vp->cur; // d -> 12
		vp->cur -= 4096;
		/* p1 and p2 are PDPTs (pointed by PML4E) */

		/* register them in the PML4 (512G per entry) */
		p[0].p = 1;
		p[0].w = 1; /* non-restrictive */
		p[0].u = 1; /* likewise */
		p[0].addr = (size_t)p1 / 4096;
		p[511].p = 1;
		p[511].w = 1;
		p[511].u = 1;
		p[511].addr = (size_t)p2 / 4096;

		/* create the VM mapping of the PDPTEs */
		uint32_t ct = mm_alloc_pm(2, &pr, 1); /* TODO check cont */

		if (ct != 2) {
la_meme:
				puts("unable to alloc two consecutive pages\n");
				while (1);
		}

		vp->pdpte[0] = vp->cur - 4096; // bc -> 13/14
		vp->cur -= 8192;
		m1 = (void*)(size_t)pr.base;
		ct = mm_alloc_pm(2, &pr, 1);

		if (ct != 2)
				goto la_meme;

		vp->pdpte[511] = vp->cur - 4096; // 9a 15/16
		vp->cur -= 8192;
		m2 = (void*)(size_t)pr.base;

		/* Now create two PDs (pointed by PDPTE) (1G per entry) */
		mm_alloc_pm(1, &pr, 1);
		pl1 = (void*)(size_t)pr.base;
		m1->pds[0] = vp->cur; // 8 -> 17
		vp->cur -= 4096;
		mm_alloc_pm(1, &pr, 1);
		pl2 = (void*)(size_t)pr.base;
		m2->pds[511] = vp->cur; // 7 -> 18
		vp->cur -= 4096;
		/* pl1 and pl2 are two PDs (2M per PDE) */

		/* register in the two PDPTs */
		p1[0].p = 1;
		p1[0].w = 1;
		p1[0].u = 1;
		p1[0].addr = (size_t)pl1 / 4096;
		p2[511].p = 1;
		p2[511].w = 1;
		p2[511].u = 1;
		p2[511].addr = (size_t)pl2 / 4096;

		/* create PT pointer containers */
		mm_alloc_pm(1, &pr, 1);
		n1 = (void*)(size_t)pr.base;
		m1->pdes[0] = vp->cur; // 6 -> 19
		vp->cur -= 4096;
		mm_alloc_pm(1, &pr, 1);
		n2 = (void*)(size_t)pr.base;
		m2->pdes[511] = vp->cur; // 5 -> 1a
		vp->cur -= 4096;

		/* now create PTs */
		/* one for the first 2MiB */
		mm_alloc_pm(1, &pr, 1);
		pt1 = (void*)(size_t)pr.base;
		n1->pts[0] = vp->cur; // 4 -> 1b
		vp->cur -= 4096;
		/* and one for the last two */
		mm_alloc_pm(1, &pr, 1);
		pt2 = (void*)(size_t)pr.base;
		n2->pts[511] = vp->cur; // 3 -> 1c
		vp->cur -= 4096;

		/* register them in the directories */
		pl1[0].p = 1;
		pl1[0].w = 1;
		pl1[0].u = 1;
		pl1[0].addr = (size_t)pt1 / 4096;
		pl2[511].p = 1;
		pl2[511].w = 1;
		pl2[511].u = 1;
		pl2[511].addr = (size_t)pt2	/ 4096;

		/* and set the entries */
		for (size_t i = 0; i < 256; i++) {
				/* identity CD */
				pt1[i].p = 1;
				pt1[i].w = 1;
				pt1[i].u = 1;
				//pt1[i].xd = 1;
				pt1[i].addr = i; /* identity */
		}

		/* now do the paging-structures mapping stored in vp,m,n */
		uint64_t bse = 0xffffffffffe00000; /* last PD */
		size_t idx;
		/* first the PML4 */
		idx = (vp->pml4 - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0; /* only supervisor access to pts */
		pt2[idx].addr = cr3_val / 4096;
		/* vp is identity mapped -> no need for doing sth. (TODO: protection) */		
		/* then the 2 PDPTs */
		idx = (vp->pml4e[0] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)p1 / 4096;
		idx = (vp->pml4e[511] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)p2 / 4096;
		/* now the two container structures (each 2 pages size, for PDPTEs(PDs & PDEs)) */
		idx = (vp->pdpte[0] - bse) / 4096;	
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)m1 / 4096;
		pt2[idx + 1].p = 1;
		pt2[idx + 1].w = 1;
		pt2[idx + 1].u = 0;
		pt2[idx + 1].addr = (uint64_t)m1 / 4096 + 1;
		idx = (vp->pdpte[511] - bse) / 4096;	
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)m2 / 4096;
		pt2[idx + 1].p = 1;
		pt2[idx + 1].w = 1;
		pt2[idx + 1].u = 0;
		pt2[idx + 1].addr = (uint64_t)m2 / 4096 + 1;
		/* followed by the two PDs */
		idx = (m1->pds[0] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)pl1 / 4096;
		idx = (m2->pds[511] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)pl2 / 4096;
		/* and the two PT pointer containers */
		idx = (m1->pdes[0] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)n1 / 4096;
		idx = (m2->pdes[511] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)n2 / 4096;
		/* and finally the PTs */
		idx = (n1->pts[0] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)pt1 / 4096;
		idx = (n2->pts[511] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)pt2 / 4096;

		/* and get the zero (read only) page */
		mm_alloc_pm(1, &pr, 1);
		pm_zero = pr.base;

		/* store the mapping temporarily */
		pm_mapping = (void*)pp;
		pp->p = p;
		pp->p1 = p1;
		pp->p2 = p2;
		pp->pl1 = pl1;
		pp->pl2 = pl2;
		pp->pt1 = pt1;
		pp->pt2 = pt2;
		pp->m1 = m1;
		pp->m2 = m2;
		pp->n1 = n1;
		pp->n2 = n2;
}

void mm_pg36_init()
{
		struct page_range pr;
		struct vm_pg_ptrs36* vp = vm_mapping;
		struct pm_pg36_ptrs* pp = (void*)(vp + 1);
		struct pte64 *p[4], *pt1, *pt2;

		/* clear the mappings */
		bzero(vp, sizeof(*vp));
		vp->cur = 0xfffff000;
		bzero(pp, sizeof(*pp));

		/* set CR3 to the base of vp */
		cr3_val = (uint64_t)vp;

		/* get the 4 page directories */
		for (size_t i = 0; i < 4; i++) {
				mm_alloc_pm(1, &pr, 1);
				/* VM mapping */
				vp->pdp[i] = vp->cur;
				vp->cur -= 4096;
				/* initialize the 32bt PDPT */
				vp->pdps[i].p = 1;
				vp->pdps[i].w = 1;
				vp->pdps[i].u = 1;
				vp->pdps[i].addr = pr.base / 4096;
				/* and get the physical pointers */
				p[i] = (void*)pr.base;
		}


		/* create the VM mapping of the PDPTEs */
		uint32_t ct = mm_alloc_pm(2, &pr, 1); /* TODO check cont */

		/* now allocate the two page tables */
		for (size_t i = 0; i < 2048; i += 2047) { /* 0, 2047 */
				struct pte64* pd = p[i / 512];
				mm_alloc_pm(1, &pr, 1);
				/* VM mapping */
				vp->pts[i] = vp->cur;
				vp->cur -= 4096;
				/* register in PD */
				pd[i % 512].p = 1;
				pd[i % 512].w = 1;
				pd[i % 512].u = 0;
				pd[i % 512].xd = 0; /* TODO: XD on PT1? */
				pd[i % 512].addr = pr.base / 4096;
				/* get the physical pointers */
				if (!i)
						pt1 = (void*)pr.base;
				else if (i == 2047)
						pt2 = (void*)pr.base;
		}

		/* and set the entries */
		for (size_t i = 0; i < 256; i++) {
				/* identity CD */
				pt1[i].p = 1;
				pt1[i].w = 1;
				pt1[i].u = 1;
				//pt1[i].xd = 1;
				pt1[i].addr = i; /* identity */
		}

		/* now do the paging-structures mapping stored in vp,m,n */
		uint32_t bse = 0xffe00000; /* base of last PT */
		size_t idx;
		/* first the four PDs */
		for (size_t i = 0; i < 4; i++) {
				idx = (vp->pdp[i] - bse) / 4096;
				pt2[idx].p = 1;
				pt2[idx].w = 1;
				pt2[idx].u = 0; /* only supervisor access to pts */
				pt2[idx].addr = (uint64_t)p[i] / 4096;
		}
		/* vp is identity mapped -> no need for doing sth.
		 * (TODO: protection) */

		/* then the 2 PTs */
		idx = (vp->pts[0] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)pt1 / 4096;
		idx = (vp->pts[2047] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint64_t)pt2 / 4096;

		/* and get the zero (read only) page */
		mm_alloc_pm(1, &pr, 1);
		pm_zero = pr.base;

		/* store the mapping temporarily */
		pm_mapping = (void*)pp;
		pp->p = vp->pdps;
		for (size_t i = 0; i < 4; i++)
				pp->pds[i] = p[i];
		pp->pt1 = pt1;
		pp->pt2 = pt2;
}

void mm_pg32_init()
{
		struct page_range pr;
		struct vm_pg_ptrs32* vp = vm_mapping;
		struct pm_pg32_ptrs* pp = (void*)(vp + 1);
		struct pte32 *pd, *pt1, *pt2;

		/* clear the mappings */
		bzero(vp, sizeof(*vp));
		vp->cur = 0xfffff000;
		bzero(pp, sizeof(*pp));

		/* allocate the PD */
		mm_alloc_pm(1, &pr, 1);
		vp->pd = vp->cur;
		vp->cur -= 4096;

		/* set CR3 to its base */
		cr3_val = pr.base;
		pd = (void*)pr.base;

		/* now allocate the two page tables */
		for (size_t i = 0; i < 1024; i += 1023) { /* 0, 1023 */
				mm_alloc_pm(1, &pr, 1);
				/* VM mapping */
				vp->pts[i] = vp->cur;
				vp->cur -= 4096;
				/* register in PD */
				pd[i].p = 1;
				pd[i].w = 1;
				pd[i].u = 0;
				pd[i].addr = pr.base / 4096;
				/* get the physical pointers */
				if (!i)
						pt1 = (void*)pr.base;
				else if (i == 1023)
						pt2 = (void*)pr.base;
		}

		/* and set the entries */
		for (size_t i = 0; i < 256; i++) {
				/* identity CD */
				pt1[i].p = 1;
				pt1[i].w = 1;
				pt1[i].u = 1;
				//pt1[i].xd = 1; <- NOT in 32-bit paging
				pt1[i].addr = i; /* identity */
		}

		/* now do the paging-structures mapping stored in vp,m,n */
		uint32_t bse = 0xffc00000; /* base of last PT */
		size_t idx;
		/* first the PD */
		idx = (vp->pd - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0; /* only supervisor access to pts */
		pt2[idx].addr = (uint32_t)pd / 4096;
		/* vp is identity mapped -> no need for doing sth.
		 * (TODO: protection) */

		/* then the 2 PTs */
		idx = (vp->pts[0] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint32_t)pt1 / 4096;
		idx = (vp->pts[1023] - bse) / 4096;
		pt2[idx].p = 1;
		pt2[idx].w = 1;
		pt2[idx].u = 0;
		pt2[idx].addr = (uint32_t)pt2 / 4096;

		/* and get the zero (read only) page */
		mm_alloc_pm(1, &pr, 1);
		pm_zero = pr.base;

		/* store the mapping temporarily */
		pm_mapping = (void*)pp;
		pp->pd = pd;
		pp->pt1 = pt1;
		pp->pt2 = pt2;
}

void mm_prepare_paging(int mode)
{
		if (!mode)
				mm_pg32_init();
		else if (mode == 1)
				mm_pg36_init();
		else
				mm_pg64_init();
}

void mm_initialize(int mode)
{
		/* prepare the BIOS-provided memory map */
		struct mp* map = mem_map;
		do {
				if (map->type == 1)
						mm_add_free(map->base, map->size);
				else
						mm_add_reserved(map->base, map->size);
				map++;
		} while (map->base || map->size || map->type);

		/* now remove overlapping entries */
		map = mem_map;
		do {
				if (map->type != 1)
						mm_sub_block(map->base, map->size);
				map++;
		} while (map->base || map->size || map->type);

		/* sort and merge remaining blocks */
		mm_sort_and_merge();

		/* set fm_begin and page-align */
		for (size_t i = 0; i < fm_ofs; i++) {
				if (i && fmm[i - 1].base < 0x100000)
						fm_begin = i; /* works better this way, i.e. base=1 */
				if (fmm[i].base % 4096) {
						fmm[i].size -= fmm[i].base % 4096;
						fmm[i].base += fmm[i].base % 4096;
				}
		}

		/* and print the info for now */
		for (size_t i = 0; i < fm_ofs; i++) {
				put32(i);
				put64(fmm[i].base);
				putstr("-");
				put64(fmm[i].size);
				put_nl();
		}

		/* set the counts and create the rcp/pmu's,
		 *  -> this time we preallocate them all */
		for (size_t i = fm_begin; i < fm_ofs; i++) {
				uint32_t ec, rec;
				fmm[i].reclaimable_pages = fmm[i].size / 4096; /* skip half-pages */
				fmm[i].free_pages = 0;
				rec = fmm[i].reclaimable_pages % 16384;
				ec = (rec ? 1 : 0) + fmm[i].reclaimable_pages / 16384;
				/* the size will be reduced by 2*ec -> check rec */
				if (rec && (2 * ec > rec))
						ec--;
				fmm[i].reclaimable_pages -= 2 * ec;
				rec = fmm[i].reclaimable_pages % 16384;
				/* make the reservation */
				fmm[i].size -= 2 * ec * 4096;
				fmm[i].pmu = fmm[i].base;
				fmm[i].rcp = fmm[i].base + ec * 4096;
				fmm[i].base += 2 * ec * 4096;
				fmm[i].ec = ec;
				/* and fill if below 4G (use delayed init) */
				mm_fm_init(fmm + i, ec, rec);
		}

		/* create the page tables */
		mm_prepare_paging(mode);

//		putstr("done");
}

void mm_enable_paging(int mode, uint64_t ep)
{
		extern void ep32();
		extern void ep36();
		extern void ep64();
		extern uint64_t ep_ptr;

		/* store the values for transfer */
		uint32_t* ptr = FM_FREE_MEMORY_MAP;
		ptr[-1] = fm_ofs;
		ptr[-2] = fm_begin;
		ptr[-3] = rm_count;
		*(uint64_t*)(ptr - 5) = pm_zero;
		*(uint64_t*)(ptr - 7) = cr3_val;
		ptr[-8] = (uint32_t)mode;

		ep_ptr = ep;

		if (!mode)
				ep32();
		else if (mode == 1)
				ep36();
		else
				ep64();

		while (1);
}

void mm_map64(uint64_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
		uint64_t low48;
		struct vm_pg_ptrs64* vp = vm_mapping;
		struct pm_pg64_ptrs* pp = pm_mapping;
		uint32_t pml4e, pdpte, pde, pte;
		struct page_range pr_copy = *pr;

		/* physical pointers */
		struct pte64 *p = pp->p;
		struct pte64* pl = 0;
		struct pte64* pd = 0;
		struct pte64* pt = 0;

		/* mappings */
		struct vm_pdpte_ptr* m;
		struct vm_pde_ptr* n;

		/* calculate the PML4E */
		low48 = vaddr & 0x0000ffffffffffff;
		pml4e = low48 >> 39; /* 512G per PML4E */

		/* and the PDPTE */
		pdpte = (low48 & 0x007fc0000000) >> 30; /* 1G per PDPTE */

		/* and the PDE */
		pde = (low48 & 0x3fe00000) >> 21; /* 2M per PDE */

		/* and finally the PTE */
		pte = (low48 & 0x1ff000) >> 12; /* 4K per PTE */

		/* create one if not there */
new_pdpt:
		if (!vp->pml4e[pml4e]) {
				struct page_range pr2;
				/* allocate the PDPT */
				mm_alloc_pm(1, &pr2, 1);
				vp->pml4e[pml4e] = vp->cur;
				vp->cur -= 4096;
				pl = (void*)pr2.base;
				/* make it known in VM */
				mm_map64(vp->pml4e[pml4e], &pr2, 1, 1, 1, 1, 0);
				/* do the same for the map (2 pages) */
				if (mm_alloc_pm(2, &pr2, 1) != 2) {
						puts("cont alloc 2 failed.");
						while (1);
				}
				vp->pdpte[pml4e] = vp->cur - 4096;
				vp->cur -= 8192;
				m = (void*)pr2.base;
				/* store the physical pointers */
				pp->extra_pdpts[pp->ec_pdpt].idx = pml4e;
				pp->extra_pdpts[pp->ec_pdpt].pdpt = pl;
				pp->extra_pdpts[pp->ec_pdpt++].map = m;
				if (pp->ec_pdpt > 8)
					while (1); /* exhausted too */

				/* and set the reference in the PML4 */
				p[pml4e].addr = (uint64_t)pl / 4096;
				p[pml4e].u = 1;
				p[pml4e].w = 1;
				p[pml4e].p = 1;

				/* and make it known in later VM */
				mm_map64(vp->pdpte[pml4e], &pr2, 1, 1, 1, 1, 0);

		} else { /* find PP in pp */
				for (size_t i = 0; i < pp->ec_pdpt; i++)
						if (pp->extra_pdpts[i].idx == pml4e) {
								pl = pp->extra_pdpts[i].pdpt;
								m = pp->extra_pdpts[i].map;
								break;
						}
				if (!pl) {
						if (pml4e == 0) {
								pl = pp->p1;
								m = pp->m1;
						} else if (pml4e == 511) {
								pl = pp->p2;
								m = pp->m2;
						} else {
								puts("pre-paging exhausted.");
								while (1);
						}
				}
		}

		/* now go on to the page directory */
new_pd:
		if (!m->pds[pdpte]) {
				struct page_range pr2;
				/* allocate a page directory */
				mm_alloc_pm(1, &pr2, 1);
				m->pds[pdpte] = vp->cur;
				vp->cur -= 4096;
				pd = (void*)pr2.base;
				/* do the same for the map */
				mm_alloc_pm(1, &pr2, 1);
				m->pdes[pdpte] = vp->cur;
				vp->cur -= 4096;
				n = (void*)pr2.base;
				/* store the physical pointers (avoid 0*x) */
				pp->extra_pds[pp->ec_pd].idx = (pml4e << 9) | pdpte;
				pp->extra_pds[pp->ec_pd].pd = pd;
				pp->extra_pds[pp->ec_pd++].map = n;
				if (pp->ec_pd > 24)
					while (1); /* exhausted too */

				/* and set the reference in the PDPT */
				pl[pdpte].addr = (uint64_t)pd / 4096;
				pl[pdpte].u = 1;
				pl[pdpte].w = 1;
				pl[pdpte].p = 1;

				/* and make it known in later VM */
				mm_map64(m->pds[pdpte], &pr2, 1, 1, 1, 1, 0);
		} else {
				uint32_t id = (pml4e << 9) | pdpte;
				/* find PD in pp */
				for (size_t i = 0; i < pp->ec_pd; i++)
						if (pp->extra_pds[i].idx == id) {
								pd = pp->extra_pds[i].pd;
								n = pp->extra_pds[i].map;
								break;
						}
				if (!pd) { /* no index -> only default ones left */
						if (pml4e == 0 && pdpte == 0) {
								pd = pp->pl1;
								n = pp->n1;
						} else if (pml4e == 511 && pdpte == 511) {
								pd = pp->pl2;
								n = pp->n2;
						} else {
								puts("pre-paging exhausted.");
								while (1);
						}
				}
		}

		/* now select the page table */
new_pt:
		if (!n->pts[pde]) {
				struct page_range pr2;
				/* allocate a page table */
				mm_alloc_pm(1, &pr2, 1);
				n->pts[pde] = vp->cur;
				vp->cur -= 4096;
				pt = (void*)pr2.base;
				/* store the physical pointers */
				pp->extra_pts[pp->ec_pt].idx = (pml4e << 18)
					   	| (pdpte << 9) | pde;
				pp->extra_pts[pp->ec_pt++].pt = pt;
				if (pp->ec_pt > 64)
					while (1); /* exhausted too */

				/* and set the reference in the PD */
				pd[pde].addr = (uint64_t)pt / 4096;
				pd[pde].u = 1;
				pd[pde].w = 1;
				pd[pde].p = 1;

				/* and make it known in later VM */
				mm_map64(n->pts[pde], &pr2, 1, 1, 1, 1, 0);
		} else {
				uint32_t id = (pml4e << 18) | (pdpte << 9) | pde;
				/* find PT in pp */
				for (size_t i = 0; i < pp->ec_pt; i++)
						if (pp->extra_pts[i].idx == id) {
								pt = pp->extra_pts[i].pt;
								break;
						}
				if (!pt) { /* no index -> only default ones left */
						if (pml4e == 0 && pdpte == 0 && pde == 0) {
								pt = pp->pt1;
						} else if (pml4e == 511 && pdpte == 511 && pde == 511) {
								pt = pp->pt2;
						} else {
								puts("pre-paging exhausted.");
								while (1);
						}
				}
		}

		/* now map the pages */
		while (prc) {
				pt[pte].addr = pr_copy.base / 4096;
				pt[pte].u = (us ? 1 : 0);
				pt[pte].xd = (x ? 0 : 1);
				pt[pte].w = (w ? 1 : 0);
				pt[pte].p = 1;
				//pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wc ? 1 : 0);
				/* advance */
				if (pte++ == 511) {
						if (pde++ == 511) {
								if (pdpte++ == 511) {
										if (pml4e++ == 511) {
												puts("End of 16E address space");
												while (1);
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
						/* TODO: goto mess */
						puts("PT exhausted");
						put64(vaddr);
						put32(prc);
						put64(pr->base);
						put32(pr->count);
						while (1);
				}
				pr_copy.base += 4096;
				if (!--pr_copy.count) {
						if (--prc)
								pr_copy = *pr++;
				}
		}
}

void mm_map36(uint32_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
		struct vm_pg_ptrs36* vp = vm_mapping;
		struct pm_pg36_ptrs* pp = pm_mapping;
		uint32_t pdpte, pde, pte;
		struct page_range pr_copy = *pr;

		/* physical pointers */
		struct pte64* pd = 0;
		struct pte64* pt = 0;

		/* and the PDPTE */
		pdpte = (vaddr & 0xc0000000) >> 30; /* 1G per PDPTE */
		pd = pp->pds[pdpte];

		/* and the PDE */
		pde = (vaddr & 0x3fe00000) >> 21; /* 2M per PDE */

		/* and finally the PTE */
		pte = (vaddr & 0x1ff000) >> 12; /* 4K per PTE */

		/* create a PT if not there */
new_pt:
		if (!pd[pde].p) {
				struct page_range pr2;
				/* allocate a page table */
				mm_alloc_pm(1, &pr2, 1);
				vp->pts[pdpte * 512 + pde] = vp->cur;
				vp->cur -= 4096;
				pt = (void*)pr2.base;
				/* store the physical pointers */
				pp->extra_pts[pp->ec_pt].idx = (pdpte << 9) | pde;
				pp->extra_pts[pp->ec_pt++].pt = pt;
				if (pp->ec_pt > 64)
					while (1); /* exhausted too */

				/* and set the reference in the PD */
				pd[pde].addr = (uint64_t)pt / 4096;
				pd[pde].u = 1;
				pd[pde].w = 1;
				pd[pde].p = 1;

				/* and make it known in later VM */
				mm_map36(vp->pts[pdpte * 512 + pde], &pr2, 1, 1, 1, 1, 0);
		} else {
				uint32_t id = (pdpte << 9) | pde;
				/* find PT in pp */
				for (size_t i = 0; i < pp->ec_pt; i++)
						if (pp->extra_pts[i].idx == id) {
								pt = pp->extra_pts[i].pt;
								break;
						}
				if (!pt) { /* no index -> only default ones left */
						if (pdpte == 0 && pde == 0) {
								pt = pp->pt1;
						} else if (pdpte == 3 && pde == 511) {
								pt = pp->pt2;
						} else {
								puts("pre-paging exhausted.");
								while (1);
						}
				}
		}

		/* now map the pages */
		while (prc) {
				pt[pte].addr = pr_copy.base / 4096;
				pt[pte].u = (us ? 1 : 0);
	//			pt[pte].xd = (x ? 0 : 1); /* TODO: check if XD is supp */
				pt[pte].w = (w ? 1 : 0);
				pt[pte].p = 1;
				//pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wc ? 1 : 0);
				/* advance */
				if (pte++ == 511) {
						if (pde++ == 511) {
								if (pdpte++ == 3) {
										puts("End of 4G address space");
										while (1);
								}
								pd = pp->pds[pdpte];
								pde = 0;
								pte = 0;
								goto new_pt;
						}
						pte = 0;
						goto new_pt;
				}
				pr_copy.base += 4096;
				if (!--pr_copy.count) {
						if (--prc)
								pr_copy = *pr++;
				}
		}
}

void mm_map32(uint32_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
		struct vm_pg_ptrs32* vp = vm_mapping;
		struct pm_pg32_ptrs* pp = pm_mapping;
		uint32_t pde, pte;
		struct page_range pr_copy = *pr;

		/* physical pointers */
		struct pte32* pd = pp->pd;
		struct pte32* pt = 0;

		/* and the PDE */
		pde = (vaddr & 0xffc00000) >> 22; /* 4M per PDE */

		/* and finally the PTE */
		pte = (vaddr & 0x3ff000) >> 12; /* 4K per PTE */

new_pt:
		/* create a PT if not there */
		if (!pd[pde].p) {
				struct page_range pr2;
				/* allocate a page table */
				mm_alloc_pm(1, &pr2, 1);
				vp->pts[pde] = vp->cur;
				vp->cur -= 4096;
				pt = (void*)pr2.base;
				/* store the physical pointers */
				pp->extra_pts[pp->ec_pt].idx = pde;
				pp->extra_pts[pp->ec_pt++].pt = pt;
				if (pp->ec_pt > 64)
					while (1); /* exhausted too */

				/* and set the reference in the PD */
				pd[pde].addr = (uint32_t)pt / 4096;
				pd[pde].u = 1;
				pd[pde].w = 1;
				pd[pde].p = 1;

				/* and make it known in later VM */
				mm_map32(vp->pts[pde], &pr2, 1, 1, 1, 1, 0);
		} else {
				uint32_t id = pde;
				/* find PT in pp */
				for (size_t i = 0; i < pp->ec_pt; i++)
						if (pp->extra_pts[i].idx == id) {
								pt = pp->extra_pts[i].pt;
								break;
						}
				if (!pt) { /* no index -> only default ones left */
						if (pde == 0) {
								pt = pp->pt1;
						} else if (pde == 1023) {
								pt = pp->pt2;
						} else {
								puts("pre-paging exhausted.");
								nput32(pde, 0);
								nput32(pte, 0);
								put32(vaddr);
								while (1);
						}
				}
		}

		/* now map the pages */
		while (prc) {
				pt[pte].addr = pr_copy.base / 4096;
				pt[pte].u = (us ? 1 : 0);
				pt[pte].w = (w ? 1 : 0);
				pt[pte].p = 1;
//				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
				pt[pte].wt = (wc ? 1 : 0);
				/* advance */
				if (pte++ == 1023) {
						if (pde++ == 1023) {
								puts("end of 4G address space");
								while (1);
						}
						pte = 0;
						goto new_pt;
				}
				pr_copy.base += 4096;
				if (!--pr_copy.count) {
						if (--prc)
								pr_copy = *pr++;
				}
		}
}

void mm_perform_mapping(int mode, uint64_t ofs, struct page_range* pr, int prc,
			   uint64_t vaddr, uint64_t fs, uint64_t ms, struct page_range* pr2,
			   int pr2c, int x, int w)
{
		uint64_t cur = vaddr; int pro = 0;
		uint64_t po = ofs / 4096;
		size_t padding = ofs % 4096;
		size_t zeros;
		size_t pcf, pcm;
		size_t pcf_c;

		/* calculate the page counts */
		pcf_c = pcf = rdiv(padding + fs, 4096); /* count of pages from file */
		pcm = rdiv(padding + ms, 4096); /* count of pages in memory */
		/* and the number of zero bytes on the last file page */
		zeros = (padding + fs) % 4096;
		if (zeros)
				zeros = 4096 - zeros;

		/* fix the alignment */
		if (padding)
				cur -= padding;
		/* first build the page ranges for the mapping */
		while (po) {
				if (pr->count > po) {
						/* we found the start */
						pr2->base = pr->base + po * 4096;
						pr2->count = pr->count - po;
						break;
				} else {
						po -= pr->count;
						pr++;
						if (!--prc) { /* no there */
								puts("offset not found in ELF.");
								while (1);
						}
				}
		}

		/* now pr2 is already pointing in the right direction */
		while (pcf_c > pr2[pro].count) {
				pcf_c -= pr2[pro].count;
				/* discontinuity -> new pr needed */
				if (!prc || !pr2c) {
						puts("out of PRCs");
						while (1);
				}
				pro++; pr2c--; pr++; prc--;
				pr2[pro] = *pr;
		}
		if (pcf_c) { /* restrict last pr */
				pr2[pro].count = pcf_c;
		}
		/* and zero */
		if (zeros) {
				/* duplicate the critical last page */
				void* end = (void*)(pr2[pro].base + 4096 * --pr2[pro].count);
				pro++;
				if (mm_alloc_pm(1, pr2 + pro, --pr2c)) {
						void* dst = (void*)pr2[pro].base;
						mem_cpy(dst, end, 4096 - zeros);
						if (!pr2[pro - 1].count) { /* remove zero length */
								pr2[pro - 1] = pr2[pro];
								pr2c++; pro--;
						}
				} else {
						puts("unable to duplicate page");
						while (1);
				}
				//bzero(end - zeros, zeros);
		}

		/* advance */
		pro++;
		pr2c--;

		/* now add the zero pages */
		if (pcm > pcf) {
				size_t zc = pcm - pcf;
				if (w) {
						zc -= mm_alloc_pm(zc, pr2 + pro, pr2c);
						pro++; pr2c--;
				} else { /* use the single zero page (wastes many ranges) */
						while (zc && pr2c) {
								pr2[pro].base = pm_zero;
								pr2[pro++].count = 1;
								pr2c--; zc--;
								/* TODO: reprogram by using multiple calls */
								puts("zero-page used");
						}
				}
				if (zc) {
						puts("unable to zero-pad .bss-like section.");
				}
		}

		/* TODO: handle overlap of W and X if wanted */

		/* we now have built the mapping in pr2 with pro valid ranges */
		if (cur < 0x100000) { /* identity map -> .trampo */
				void* ptr = (void*)cur;
				for (int i = 0; i < pro; i++) {
						mem_cpy(ptr, (void*)pr2[i].base, pr2[i].count * 4096);
						ptr += pr2[i].count * 4096;
				}
				return; /* TODO: possible NX setup */
		}

		if (!mode)
				mm_map32((uint32_t)cur, pr2, pro, x, w, 0, 0);
		else if (mode == 1)
				mm_map36((uint32_t)cur, pr2, pro, x, w, 0, 0);
		else
				mm_map64(cur, pr2, pro, x, w, 0, 0);
}


void mm_mmap(int mode, uint64_t vaddr, struct page_range* pr, int prc, int x, int w, int wc, int us)
{
		if (!mode)
				mm_map32((uint32_t)vaddr, pr, prc, x, w, wc, us);
		else if (mode == 1)
				mm_map36((uint32_t)vaddr, pr, prc, x, w, wc, us);
		else
				mm_map64(vaddr, pr, prc, x, w, wc, us);
}

void* mm_register_video_memory(int mode, uint64_t vga_pmem, uint64_t vga_pmem_size)
{
		struct vmdesc vd, *pvd;
		struct page_range pr = { vga_pmem, rdiv(vga_pmem_size, 4096) };
		vd.vga_base = vga_pmem;
		vd.vga_size = vga_pmem_size;
		vd.vga_virt = VM_VIDEO_MEMORY;
		if (!mode)
			pvd = &((struct vm_pg_ptrs32*)vm_mapping)->video_memory;
		else if (mode == 1)
			pvd = &((struct vm_pg_ptrs36*)vm_mapping)->video_memory;
		else
			pvd = &((struct vm_pg_ptrs64*)vm_mapping)->video_memory;
		mm_mmap(mode, vd.vga_virt, &pr, 1, 0, 1, 1, 0);
		*pvd = vd;
		return pvd;
}

void mm_preallocate_maps(int mode)
{
			struct page_range pr;
			uint64_t mem_ranges[] = {
				VM_PMU_BASE, 1,
				VM_RCP_BASE, 1,
				VM_MM_PER_CPU_BASE, 1,
				VM_KERNEL_STACK_BASE, 1,
				VM_QND_BASE, 1
			}, *mr_pt;


			/* Pre-allocate the required ranges */
			for (mr_pt = &mem_ranges[0]; (mr_pt - mem_ranges) < 10; mr_pt += 2) {
					/* get some inital space for tables / stuff */
					putstr("allocating map for "); put64(mr_pt[0]);
					putstr(" of count "); put64(mr_pt[1]); put_nl();
					mm_alloc_pm(mr_pt[1], &pr, 1);
					if (pr.count < mr_pt[1]) {
							putstr("unable to allocate basic memory");
							while (1);
					}
					/* and then map it accordingly */
					mm_mmap(mode, mr_pt[0], &pr, 1, 0, 1, 0, 0);
			}

			puts("done");
}


