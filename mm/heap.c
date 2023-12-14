/* heap.c : Implements the heap functions used throughout the kernel. 
 * */

#include "../kernel.h"
#include "../kdata.h"


struct h_heap
{
		void* heap_base;
		void* heap_ptr;
		void* heap_limit;
		size_t heap_commit;
		h_oom_handler heap_oom_handler; /* sub-aggregates don't have one */
		h_decommit heap_decommit;
		int flags : 31; /* for now only aggregate vs. solo heap */
		int desc_in_heap : 1; /* for creation and deletion */
};

/* The fixed base (early use) kernel heap */
struct h_heap h_kernel = { NULL, NULL, NULL, 0,
	   	h_generic_oom_handler,
		NULL, /* we don't decommit the kernel heap */
		0, /* solo heap */
		0 /* desc stored here */
};

extern uint64_t pm_count; /* amount of physical memory */
void init_kernel_heap()
{
		/* use a 4M heap (or less if needed) */
		size_t ct = 1024; void* hp;
		if (pm_count / 4096 / 16 < ct) /* restrict to 1/16 of all memory */
				ct = pm_count / 4096 / 16;

		/* now allocate-on-access the heap */
		hp = mm_alloc_vmem(&mm_kernel, NULL, ct, /*MMGR_ALLOC_NP_AOA // no AOA for start
						|*/ MMGR_MAP_WRITE | MMGR_MAP_KERNEL/* | MMGR_MAP_GLOBAL*/);
		h_kernel.heap_base = h_kernel.heap_ptr = hp;
		h_kernel.heap_limit = hp + ct * 4096;
}

struct heap_entry
{
		void* next;
		size_t s;
};
int is_empty(struct heap_entry* he) { return ((char*)he->next - he->s - sizeof(struct heap_entry)) == (char*)he; }

void h_dump(void* hp)
{
		struct h_heap* h = (struct h_heap*)hp;
		if (h->flags == 1) { /* aggregate so dump twice */
				printf("dumping aggreate heap consisting of heaps at:\n%p and %p",
								h->heap_base, h->heap_ptr);
				h_dump(h->heap_base);
				h_dump(h->heap_ptr);
		} else {
				struct heap_entry* he = (struct heap_entry*)h->heap_base;
				printf("dumping heap at %p with limit %p and ptr=%p\n",
								h->heap_base, h->heap_limit, h->heap_ptr);
				do {
						printf("entry at %p with size %u\n", he, he->s);
				} while ((he = he->next));
		}
}

void* h_malloc(void* hpp, size_t s)
{
		struct h_heap* h = (struct h_heap*)hpp;
		if (h->flags == 1) { /* we're on an aggregate heap */
				/* try to malloc on the new one first */
				void* rv = NULL;
				rv = h_malloc(h->heap_limit, s);
				if (!rv) {
						/* swap the ptrs and try again */
						//h->heap_limit = (h->heap_limit == h->heap_ptr) ? h->heap_base : h->heap_ptr;
						rv = h_malloc(h->heap_base, s);
						if (!rv) { /* call the OOM handler (i.e. add another aggregation level) */
								// TODO: locking!
								if (!h->heap_oom_handler(hpp, s))
										return NULL;
								else /* guranteed success */
										rv = h_malloc(hpp, s);
						}
				}
				/* update the commit and return */
				// TODO: cmpxchg
				h->heap_commit = ((struct h_heap*)h->heap_base)->heap_commit
						+ ((struct h_heap*)h->heap_ptr)->heap_commit;
				return rv;
		}

		/* no we're on the memory */
		struct heap_entry* hp;
		size_t rem;
Pos1:
		hp = (struct heap_entry*)h->heap_base;
		rem = (char*)h->heap_limit - (char*)h->heap_ptr;
		if (rem > s + sizeof(struct heap_entry)) { /* easy, lock free */
			hp = (struct heap_entry*)h->heap_ptr;
			/* redo on parallel changes */
			if (rem != (size_t)((char*)h->heap_limit - (char*)hp))
					goto Pos1;
			if (!__sync_bool_compare_and_swap(&h->heap_ptr, hp, (char*)h->heap_ptr + s + sizeof(struct heap_entry)))
					goto Pos1;
			/* now we had the chance to allocate s bytes */
			hp->s = s;
			hp->next = h->heap_ptr;
			__sync_add_and_fetch(&h->heap_commit, s);
			return hp + 1;
		} else { /* heap walk */
				size_t fs_prev = 0; struct heap_entry* hp_p = 0;
				while ((void*)hp < h->heap_ptr) {
						size_t fs;
						/* get free space */
						fs = (char*)hp->next - (char*)hp - hp->s - sizeof(struct heap_entry);
						if (fs == 0) { /* full entry */
								fs_prev = 0; hp_p = hp;
								hp = hp->next;
						} else if (fs >= s + sizeof(struct heap_entry)) { /* reuse single (deleted?) space */
								if (is_empty(hp)) {
										hp->s = s;
										h->heap_commit += s;
										return hp + 1;
								} else {
										hp_p = hp;
										hp = (struct heap_entry*)((char*)(hp + 1) + hp->s);
										hp->s = s;
										hp->next = hp_p->next;
										hp_p->next = hp;
										h->heap_commit += s;
										return hp + 1;
								}
						} else if (fs == hp->s) { /* remove completly freed space */
								if (hp_p) { /* combine entries */
										hp_p->next = hp->next;
										fs_prev += fs + sizeof(struct heap_entry);
										if (fs_prev >= s + sizeof(struct heap_entry)) { /* found sth */
												hp = (struct heap_entry*)((char*)(hp_p + 1) + hp_p->s);
												hp->s = s;
												hp->next = hp_p->next;
												hp_p->next = hp;
												h->heap_commit += s;
												return hp + 1;
										} else /* advance */
												hp = (struct heap_entry*)hp->next;
								} else {
										fs_prev = fs;
										hp_p = hp;
								}
						} else { /* partially empty advance */
								fs_prev = fs;
								hp_p = hp;
								hp = (struct heap_entry*)hp->next;
						}
				}

				/* Out of memory? */
				if (h->heap_oom_handler)
						if (h->heap_oom_handler(hpp, s))
								return h_malloc(hpp, s);

				/*NOW we're done */
				printf("Out of heap memory\nIdling for debug\n");
				h_dump(hpp);
				while (1);
				errno = ENOMEM;
				return 0;
		}
}

void h_free(void* hp, void* ptr)
{
		struct h_heap* h = (struct h_heap*)hp;
		if(h->flags == 1) { /* free on aggregate heap (i.e. everywhere) */
				h_free(h->heap_base, ptr);
				h_free(h->heap_ptr, ptr);
				return;
		}

		/* free if in heap memory */
		if (ptr >= h->heap_base && ptr <= h->heap_limit) {
				__sync_sub_and_fetch(&h->heap_commit, ((struct heap_entry*)ptr - 1)->s);
				((struct heap_entry*)ptr - 1)->s = 0;
		}
}

void* h_realloc(void* hp, void* ptr, size_t s)
{
		if (ptr) {
				struct h_heap* h = (struct h_heap*)hp;
				if (h->flags == 1) { /* do an aggregate realloc (i.e. everywhere) */
						void* rv = NULL;
						rv = h_realloc(h->heap_base, ptr, s);
						if (!rv)
								h_realloc(h->heap_ptr, ptr, s);
						if (!rv) { /* call the OOM handler (i.e. add another aggregation level) */
								if (!h->heap_oom_handler(hp, s))
										return NULL;
								else /* guranteed success */
										rv = h_realloc(hp, ptr, s);
						}
						return rv;
				}

				/* only on our memory! */
				if (ptr < h->heap_base || ptr > h->heap_limit)
						return NULL;

				struct heap_entry* hp = (struct heap_entry*)(ptr) - 1, *hp2;
				size_t fs = 0, oldS = hp->s;
				if (s <= hp->s) { /* shrink */
						h->heap_commit -= oldS - s;
						hp->s = s;
						return ptr;
				}
				/* find adjacent space */
				hp2 = hp->next;
				while ((char*)hp2 < (char*)h->heap_ptr) {
						if (is_empty(hp2)) {
								/* add free space */
								fs += hp2->s + sizeof(struct heap_entry);
								hp->next = hp2->next;
								if (hp->s + fs >= s) { /* found enough space*/
										h->heap_commit += s - oldS;
										hp->s = s;
										return ptr;
								} else
										hp2 = (struct heap_entry*)hp2->next;
						} else { /* blocked use kmalloc */
								void* rv = h_malloc(hp, s);
								if(rv) {
										memcpy(rv, ptr, hp->s);
										h_free(hp, ptr);
								}
								return rv;
						}
				}
				/* get space until heap_limit */
				fs += (char*)h->heap_limit - (char*)h->heap_ptr;
				if (fs + hp->s >= s) {
						h->heap_ptr = (char*)h->heap_ptr + s - hp->s;
						h->heap_commit += s - oldS;
						hp->s = s;
						return ptr;
				}

				/* Out of memory? */
				if (h->heap_oom_handler)
						if (h->heap_oom_handler(hp, s))
								return h_realloc(hp, ptr, s);
				/* YES */
				printf("Out of heap memory\nIdling for debug\n");
				h_dump(hp);
				while (1);
				errno = ENOMEM;
				return 0;
		} else
				return h_malloc(hp, s);
}

void* h_create_heap(void* mem, size_t ct, h_oom_handler hdlr, h_decommit hdc)
{
		struct h_heap* h = (struct h_heap*)mem;
		if (ct < sizeof(struct h_heap) + sizeof(struct heap_entry))
				return NULL; /* don't allocate noviable heaps */
		h->desc_in_heap = 1; /* we're using part of mem */
		h->flags = 0; /* non-aggregate */
		h->heap_base = mem + sizeof(struct h_heap);
		h->heap_limit = mem + ct;
		h->heap_ptr = h->heap_base;
		h->heap_commit = 0;
		h->heap_decommit = hdc;
		h->heap_oom_handler = hdlr;
		return mem;
}

void h_destroy(void* hp)
{
		struct h_heap* h = (struct h_heap*)hp;
		if (h->flags == 1) { /* destroy both heaps */
				h_destroy(h->heap_base);
				h_destroy(h->heap_ptr);
				return;
		}

		/* we're on bare memory */
		struct heap_entry* he = (struct heap_entry*)h->heap_base;
		he->s = 0;
		he->next = h->heap_limit;
		if (h->heap_decommit)
				h->heap_decommit(h->heap_base, h->heap_limit - h->heap_base);
}

/* kernel heap: extra conservative */
#define KGUARD_SIZE 8
//spinlock_t km_lock = SPIN_LOCK_UNLOCKED;
void* kmalloc(size_t s)
{
		void* rv = h_malloc(&h_kernel, s + 2 * KGUARD_SIZE);
		char *p1, *p2;
		if (!rv)
				return NULL;
		p1 = rv;
		p2 = rv + s + 2 * KGUARD_SIZE;
		for (size_t i = 0; i < KGUARD_SIZE; i++)
				*p1++ = *--p2 = 0xcb;
		return rv + KGUARD_SIZE;
}

void* kzalloc(size_t s)
{
		void* rv = kmalloc(s);
		if (!rv)
				return NULL;
		bzero(rv, s);
		return rv;
}

void kfree(void* ptr)
{
		h_free(&h_kernel, ptr - KGUARD_SIZE);
}

void* krealloc(void* ptr, size_t s)
{
		void* rv = h_realloc(&h_kernel, ptr - KGUARD_SIZE, s + 2 * KGUARD_SIZE);
		if (!rv)
				return NULL;
		char* p2 = rv + s + 2 * KGUARD_SIZE;
		for (size_t i = 0; i < KGUARD_SIZE; i++)
				*--p2 = 0xcc;
		return rv + KGUARD_SIZE;
}

void kstats_impl(struct h_heap* h, size_t* s_total, size_t* s_commit, size_t* s_free, size_t* s_nheaps)
{
		if (h->flags == 1) {
				/* is aggregate */
				kstats_impl(h->heap_base, s_total, s_commit, s_free, s_nheaps);
				kstats_impl(h->heap_ptr, s_total, s_commit, s_free, s_nheaps);
				return;
		}

		/* we're on memory */
		*s_commit += h->heap_commit;
		*s_total += h->heap_limit - h->heap_base;
		*s_free += (h->heap_limit - h->heap_base) - h->heap_commit;
		(*s_nheaps)++;
}

void kstats(size_t* s_total, size_t* s_commit, size_t* s_free, size_t* s_nheaps)
{
		*s_total = *s_commit = *s_free = *s_nheaps = 0;
		struct h_heap* h = &h_kernel;
		kstats_impl(h, s_total, s_commit, s_free, s_nheaps);
}

int h_generic_oom_handler(void* hp, size_t s)
{
		struct h_heap* h = (struct h_heap*)hp, *h2; void* nm;
		size_t page_ct;

		if (h->flags == 1) {
				/* aggregate on aggregates */
				/* should be handled by the generic handler */
				/* TODO: maybe check kernel vs. user pages */
				return 0;
		}

		while (s);

		/* map a new heap and move the initial desc into dynamic memory */
		page_ct = s / 4096;
		if (page_ct % 256) /* MiB granularity */
				page_ct += 256 - (page_ct % 256);
		nm = mm_alloc_vmem(&mm_kernel, NULL, page_ct, MMGR_ALLOC_NP_AOA
						| MMGR_MAP_WRITE | MMGR_MAP_KERNEL/* | MMGR_MAP_GLOBAL*/);

		/* we now have page_ct scrubbed pages at nm
		 * let's create a new heap there */
		h2 = (struct h_heap*)h_create_heap(nm, page_ct * 4096, h_generic_oom_handler, h_generic_decommit);
		/* and move the desc of the initial heap there */
		nm = h_malloc(h2, sizeof(struct h_heap));
		if (!nm) {
				/* this should never fail */
				cprintf(KFMT_ERROR, "catastrophe\n");
				while (1);
		}
		h->heap_oom_handler = NULL;
		*(struct h_heap*)nm = *h; /* deregister this handler */
		/* now change the desc for the aggregate heap */
		h->heap_base = nm;
		h->heap_ptr = h->heap_limit = h2;
		h->heap_commit = h2->heap_commit + ((struct h_heap*)nm)->heap_commit;
		h->flags = 1;
		h->desc_in_heap = 0;
		h->heap_decommit = NULL; /* don't decommit the aggregate */
		return 4096 * page_ct - ((struct h_heap*)nm)->heap_commit;
}

void h_generic_decommit(void* mem, size_t ct)
{
		mm_free_vmem(&mm_kernel, mem, ct / 4096);
}

