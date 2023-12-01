/* pmem.h : Definitions for physical memory management.
 * */

extern struct fme
{
		uint64_t base;
		uint64_t size;
		uint64_t free_pages;
		uint64_t reclaimable_pages;
		uint64_t ec;
		uint64_t pmu; /* physical ptr at this time */
		uint64_t rcp; /* likewise */
} * const fmm;
extern size_t fm_begin, fm_ofs;

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
