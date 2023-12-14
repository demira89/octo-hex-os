/* basedefs.h : Basic definitions used in the boot code.
 * */

typedef unsigned long long int uint64_t;
typedef signed long long int int64_t;
typedef unsigned int uint32_t;
typedef signed int int32_t;
typedef unsigned long size_t;
typedef signed long ssize_t;
typedef unsigned short uint16_t;
typedef signed short int16_t;
typedef unsigned char uint8_t;
typedef signed char int8_t;
#define NULL (void*)0
#define rdiv(a,b) (((a)/(b))+(((a)%(b)!=0)?1:0))
#define min(a,b) (((a)>(b))?(b):(a))
#define max(a,b) (((a)<(b))?(b):(a))


void putstr(const char* str);
void nputstr(const char* str, int n);
void puts(const char* str);
void put_nl();
void unputc();
void putb(uint8_t bt);
void put16s(uint16_t num);
void put32(uint32_t num);
void nput32(uint32_t num, int min_cc);
void put64(uint64_t num);
void bzero(void* ptr, size_t s);
void mem_cpy(void* d, void* s, size_t c);
int strncmp(const char* p1, const char* p2, size_t num);
void enable_sse();


struct page_range {
		uint64_t base;
		uint32_t count;
};
void mm_initialize(int mode, int nx);
void mm_enable_paging(int mode, uint64_t ep);
void mm_perform_mapping(int mode, uint64_t ofs, struct page_range* pr, int prc,
			   uint64_t vaddr, uint64_t fs, uint64_t ms, struct page_range* pr2,
			   int pr2c, int x, int w);
uint32_t mm_alloc_pm(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct);
void* mm_register_video_memory(int mode, uint64_t vga_pmem, uint64_t vga_pmem_size);
uint64_t fl_load_images(int mode);
uint64_t map_elf_image(int mode, uint32_t pct, struct page_range* pr, int prc);


