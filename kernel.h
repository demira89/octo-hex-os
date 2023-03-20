/* kernel.h: defines the essential function an inline assembly routines */

#include "gdt.h"
#include "mm/virtmem.h"

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;
typedef char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef long long int int64_t;
typedef unsigned long size_t;
typedef int64_t intmax_t;
typedef uint64_t uintmax_t;
typedef long int ptrdiff_t;
typedef long intptr_t;
typedef unsigned long uintptr_t;
#define NULL ((void*)0)
void task_diag();
#define die(...) do { cprintf(KFMT_ERROR, __VA_ARGS__); task_diag(); framebuffer_redraw(&fb_initial); asm("cli"); while (1) asm("hlt"); } while(0);

/*typedef void** va_list;
#define va_start(v, a) (v = (void**)((&a) + 1))
#define va_end(v) (v = NULL)
#define va_arg(v, t) (*((t*)(v)++))*/
typedef void* va_list;
#define va_start(v,a) (v = (void*)((void**)(&(a)) + 1))
#define va_end(v) (v = NULL)
#define __va_rounded_size(T) \
		(((sizeof (T) + sizeof(int) - 1) / sizeof(int)) * sizeof(int))
#define va_arg(v, t) \
		((void)(v = (va_list)((char*)(v) + __va_rounded_size(t))), \
		 *((t*)(void*)((char*)(v) - __va_rounded_size(t))))

#ifndef C11
#define CTASTR2(pre,post) pre ## post
#define CTASTR(pre,post) CTASTR2(pre,post)
#define STATIC_ASSERT(cond,msg) \
    typedef struct { int CTASTR(static_assertion_failed_,msg) : !!(cond); } \
    CTASTR(static_assertion_failed_,__COUNTER__)
#else
#define STATIC_ASSERT(cond,msg) _Static_assert(cond,msg)
#endif

STATIC_ASSERT((sizeof(uint64_t)==8), uint64_no_8_bytes);

#ifdef __GNUC__
#define inline __inline__
#define asm __asm__
#define volatile __volatile__
#endif

#define NO_GDB

#define max(a,b) (((a) > (b)) ? (a) : (b))
#define min(a,b) (((a) < (b)) ? (a) : (b))
#define countof(x) (sizeof(x)/sizeof((x)[0]))
#define COUNT_OF(x) (countof(x))
#define rdiv(a,b) (((a)/(b)) + (((a)%(b))?1:0))
//#define iceil(a,b) (((a)>(b))?(b):(a))
//#define ifloor(a,b) (((a)<(b))?(b):(a))
static inline int bsr(int x)
{
		int r;
		asm ("bsrl %1, %0\n"
			 "jnz 1f\n"
			 "movl $-1, %0\n"
			 "1: inc %0\n" : "=r" (r) : "rm" (x));
		return r;
}
static inline int bsf(int x)
{
		int r;
		asm ("bsfl %1, %0\n"
			 "jnz 1f\n"
			 "movl $-1, %0\n"
			 "1: inc %0\n" : "=r" (r) : "rm" (x));
		return r;
}
#define fls(x) bsr(x)
#define ffs(x) bsf(x)

#include "mm/mm.h"

/* string.h functtions used 
 * */
size_t strlen(const char* s);
int strcmp(const char* s1, const char* s2);
int strncmp(const char* p1, const char* p2, size_t num);
char* strcpy(char* dest, char* src);
char* strncpy(char* dest, const char* src, size_t n);
char* strchr(const char* str, int character);
char* strndup(const char* s, size_t n);
char* strdup(const char* s);
char* strtok_r(char* str, const char* delim, char** saveptr);
char* strtok(char* str, const char* delim);
char* strstr(const char* s1, const char* s2);
/* strings.h : posix */
void bzero(void* ptr, size_t s);
void* memmove(void* dest, const void* src, size_t len);
void* memset(void* ptr, int value, size_t num);
/* stdlib.h functions 
 * */
int atoi(const char* str);
long int strtol(const char* str, char** endptr, int base);
/* ctype.h functions
 * */
int isspace(int c);
int isprint(int c);

/* Programmable Interrupt Controller (PIC) definitions
 * including IO ports and command words
 * */
#define PIC1 0x20            /* IO base address for master PIC */
#define PIC2 0xA0            /* IO base address for slave PIC */
#define PIC1_COMMAND PIC1
#define PIC1_DATA (PIC1+1)
#define PIC2_COMMAND PIC2
#define PIC2_DATA (PIC2+1)

#define ICW1_ICW4 0x01       /* ICW4 (not) needed */
#define ICW1_SINGLE 0x02     /* Single (cascade) mode */
#define ICW1_INTERVAL4 0x04  /* Call address interval 4 (8) */
#define ICW1_LEVEL 0x08      /* Level triggered (edge) mode */
#define ICW1_INIT 0x10       /* Initialization - required! */
 
#define ICW4_8086 0x01       /* 8086/88 (MCS-80/85) mode */
#define ICW4_AUTO 0x02       /* Auto (normal) EOI */
#define ICW4_BUF_SLAVE 0x08  /* Buffered mode/slave */
#define ICW4_BUF_MASTER 0x0C /* Buffered mode/master */
#define ICW4_SFNM 0x10       /* Special fully nested (not) */

struct mm_cpu_ctx {
		void* scrub_page;
		struct mm* cur_mm;
};
/* per-CPU definitions (only usable without preemption)
 */
// -> done x86: gs, fs gs is thread, fs is cpu
// x86_64 fs is thread, gs is cpu
struct processor_data {
		uint32_t proc_index;
		uint32_t apic_id;
		void* apic_addr;
		uint64_t apic_phys;
		struct perf_ctrs* ticks;
		struct mm_cpu_ctx mm_ctx;
};

static inline struct processor_data* per_cpu_ptr()
{
		struct processor_data* rv;
#ifdef __x86_64__
		asm volatile ("movq %%gs:0, %%rax" : "=a" (rv));
#else
		asm volatile ("movl %%fs:0, %%eax" : "=a" (rv));
#endif
		return rv;
}
struct processor_data* get_cpu_data(uint32_t smp_index);
#define smp_processor_id() per_cpu_ptr()->proc_index
#define get_cpu() ({ preempt_disable(); smp_processor_id(); })
#define put_cpu() preempt_enable()

/* APIC definitions
 * */
#define APIC_BASE (per_cpu_ptr()->apic_addr)
#define APIC_BASE_BP ((void*)0xefff0000)
#define APIC_BASE_MSR 0x1b
#define APIC_BASE_MSR_BSP 0x100
#define APIC_BASE_MSR_ENABLE 0x800
#define APIC_REG_APICID 0x20
#define APIC_REG_APICVER 0x30
#define APIC_REG_TASKPRIOR 0x80
#define APIC_REG_EOI 0x0B0
#define APIC_REG_LDR 0x0D0
#define APIC_REG_DFR 0x0E0
#define APIC_REG_SPURIOUS 0x0F0
#define APIC_REG_ESR 0x280
#define APIC_REG_ICRL 0x300
#define APIC_REG_ICRH 0x310
#define APIC_REG_LVT_TMR 0x320
#define APIC_REG_LVT_THERM 0x330
#define APIC_REG_LVT_PERF 0x340
#define APIC_REG_LVT_LINT0 0x350
#define APIC_REG_LVT_LINT1 0x360
#define APIC_REG_LVT_ERR 0x370
#define APIC_REG_TMRINITCNT 0x380
#define APIC_REG_TMRCURRCNT 0x390
#define APIC_REG_TMRDIV 0x3E0
#define APIC_REG_LAST 0x38F
#define apic_reg(num) (*(volatile uint32_t*)(APIC_BASE + num))
/* to be used before per_cpu becomes available */
#define apic_bp_reg(num) (*(volatile uint32_t*)(APIC_BASE_BP + num))

/* VGA graphics definitions including
 * IO ports and common functions
 * */
#define VGA_CH_INDEX 0x3d4
#define VGA_CH_DATA  0x3d5
void vga_update_cursor(short x, short y);

/* CMOS io ports and functions (after kbd)
 * */
#define CMOS_CH_INDEX 0x70
#define CMOS_CH_DATA 0x71
typedef int64_t time_t;
struct tm
{
		int tm_sec, tm_min, tm_hour, tm_mday, tm_mon, tm_year,
			tm_wday, tm_yday, tm_isdst;
};
struct timespec
{
		time_t tv_sec;
		long tv_nsec;
};
struct tm cmos_get_time();
void cmos_set_time(struct tm* time);
typedef int32_t clockid_t;
#define CLOCK_REALTIME 0
#define CLOCK_MONOTONIC 1
#define CLOCK_PROCESS_CPUTIME_ID 2
#define CLOCK_THREAD_CPUTIME_ID 3
int clock_getres(clockid_t clk_id, struct timespec* res);
int clock_gettime(clockid_t clk_id, struct timespec* tp);
int clock_settime(clockid_t clk_id, const struct timespec* tp);
#define PIT_FREQ (1193181.66666666)
#define CLOCKS_PER_SEC (PIT_FREQ/9861.0) /* about 121.0000sth */
#define CMOS_THRESHOLD (CLOCKS_PER_SEC*60*60) /* adjust every hour (prec is 1s/4h) */
char* asctime(const struct tm* timeptr);
char* asctime_r(const struct tm* timeptr, char* result);
time_t mktime(struct tm* timep);
time_t time(time_t* timep);
char* ctime(const time_t* timep);
char* ctime_r(const time_t* timep, char* result);
struct tm* gmtime_r(const time_t* timep, struct tm* result);
struct tm* gmtime(const time_t* timep);
struct tm* localtime_r(const time_t* timep, struct tm* result);
struct tm* localtime(const time_t* timep);
double difftime(time_t end, time_t beg);

/* Programmable Interval Timer (PIT) definitions
 * including IO ports and command words
 * */
#define PIT1 0x40
#define PIT1_CH0 (PIT1)
#define PIT1_CH1 (PIT1+1)
#define PIT1_CH2 (PIT1+2)
#define PIT1_CTR (PIT1+3)
#define PIT2 0x48
#define PIT2_CH0 (PIT2)
#define PIT2_CH1 (PIT2+1)
#define PIT2_CH2 (PIT2+2)
#define PIT2_CTR (PIT2+3)
int sleep(unsigned int seconds);
int sched_yield();

/* Keyboard controller definitions
 * including IO ports and common flags */
#define KBD 0x60
#define KBD_CH0 (KBD)
#define KBD_CH1 (KBD+1)
#define KBD_CH2 (KBD+2)
#define KBD_CH3 (KBD+3)
#define KBD_CH4 (KBD+4)

static inline void io_wait()
{
		asm volatile ( "outb %%al, $0x80" : : "a"(0) );
}

static inline void outb(uint16_t port, uint8_t val)
{
		asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port) );
}

static inline uint8_t inb(uint16_t port)
{
		uint8_t ret;
		asm volatile ( "inb %1, %0" : "=a"(ret) : "Nd"(port) );
		return ret;
}

static inline void outw(uint16_t port, uint16_t val)
{
		asm volatile ( "outw %0, %1" : : "a"(val), "Nd"(port) );
}

static inline uint16_t inw(uint16_t port)
{
		uint16_t ret;
		asm volatile ( "inw %1, %0" : "=a"(ret) : "Nd"(port) );
		return ret;
}

static inline void outl(uint16_t port, uint32_t val)
{
		asm volatile ( "outl %0, %1" : : "a"(val), "Nd"(port) );
}

static inline uint32_t inl(uint16_t port)
{
		uint32_t ret;
		asm volatile ( "inl %1, %0" : "=a"(ret) : "Nd"(port) );
		return ret;
}

static inline void memcpy(void* dst, const void* src, size_t num)
{
		char* dst1 = (char*)dst;
		const char* src1 = (const char*)src;
		while (num--)
				*(dst1++) = *(src1++);
}

/* Global functions implemented in assembler
 * */
extern void pc_reset() __attribute__ ((noreturn));
extern void pc_shutdown() __attribute__ ((noreturn));

/* Global data structures and their function implemented in kernel.c
 * */
void* ringbuffer_allocate(size_t init_cap);
void ringbuffer_enqueue(void* rb, const void* data, size_t s);
void ringbuffer_dequeue(void* rb, void* data, size_t s);
size_t ringbuffer_available(void* rb);
void ringbuffer_free(void* rb);
/*************************************************/
/* MUTEXES & other interlocked 64-bytes alignment*/
/* for preventing bus blocking by 2xinterlocked  */
/* on the same (cache) line (eff. sgl. 64B-MUTEX)*/
/*************************************************/
/* Memory management functions in mmgr.c
 * */
/* allocation on the default kernel heap */
void* kmalloc(size_t s);
void* kzalloc(size_t s);
void* krealloc(void* ptr, size_t s);
void kfree(void* ptr);
/* the implementation of a heap allocator */
/* usage: allocate more but never less (rather fail) */
typedef int(*h_oom_handler)(void* hp, size_t byte_ct); /* inout hp */
typedef void(*h_decommit)(void* mem, size_t ct); /* free pages if set */
void* h_create_heap(void* mem, size_t ct, h_oom_handler hdlr, h_decommit hdc);
void* h_malloc(void* hp, size_t s);
void* h_realloc(void* hp, void* ptr, size_t s);
void h_free(void* hp, void* ptr);
void h_destroy(void* hp);
void h_dump(void* hp);
/* aggregate and pmem */
int h_generic_oom_handler(void* hp, size_t ct);
void h_generic_decommit(void* mem, size_t ct);
/*void mmgr_init();*/
struct page_range {
		uint64_t base;
		size_t count;
};
/* returns the number of pages allocated */
/*size_t mmgr_pmem_allocate(struct page_range* dst, size_t pr_ct, size_t num_pages, int flags);
void mmgr_pmem_free(struct page_range* prs, size_t pr_ct);
void* mmgr_map_pmem(void* virt_address, const struct page_range* prs, size_t pr_ct, int flags);
void mmgr_protect_mem(void* virt_address, size_t num_pages, int flags);
void mmgr_unmap_pmem(void* ptr, size_t num_pages);
uint64_t mmgr_page_get_pmem(void* ptr, void** pp_pte);
void* mmgr_alloc_vmem(size_t pg_ct, void* ptr, int flags);*/ /* alloc & map */
/*void mmgr_free_vmem(void* ptr, size_t pg_ct);*/ /* free everything */
/*void* mmgr_extend_vmem(void* ptr, size_t pc_old, size_t pc_new);*/ /* also moves */
/*int mmgr_page_scrub();*/
#define MMGR_MAP_MMIO          0x01
#define MMGR_MAP_EXECUTE       0x02
#define MMGR_MAP_WRITE         0x04
#define MMGR_MAP_KERNEL        0x08
#define MMGR_MAP_WRITE_THROUGH 0x10
#define MMGR_MAP_NO_CACHING    0x20
#define MMGR_MAP_GLOBAL        0x40
#define MMGR_MAP_PAT           0x80
#define MMGR_MAP_LOCAL        0x100 /* no shootdown */
#define MMGR_MAP_COW           0x200
/* for the protect_mem function */
#define MMGR_MAP_PURGE_ACC     0x400
#define MMGR_MAP_PURGE_DIRTY   0x800
#define MMGR_MAP_SET           0x1000
#define MMGR_MAP_UNSET         0x2000

//#define MMGR_ALLOC_ANY         0x00
//#define MMGR_ALLOC_CONTIGUOUS  0x01
//#define MMGR_ALLOC_32_BIT      0x02
//#define MMGR_ALLOC_ISA         0x04

/* flags: 2 == any, 0 == 4GiB, 1 == 16MiB (ISA) */
uint64_t mmio_allocate_range(uint64_t size, int flags);
void mmio_free_range(uint64_t pm, uint64_t s);
int mmio_check_range(uint64_t b, uint64_t s);
void* mmio_get_vmem(size_t pg_ct);

/* Error values
 * */
#define EPERM 1
#define ENOENT 2
#define EBADF 9
#define EAGAIN 11
#define ENOMEM 12
#define EACCES 13
#define EFAULT 14
#define ENOTBLK 15
#define EEXIST 17
#define ENODEV 19
#define ENOTDIR 20
#define EINVAL 22
#define EFBIG 27
#define ERANGE 34
#define ENOSYS 38
#define ENOTSUP 95
int errno;

/* Text io functions implemented in kio.c
 * */
struct kio_region;
#define KIO_REGION_NO_DELAY            0x01
#define KIO_REGION_NO_SCROLL           0x02
#define KIO_REGION_DEFERED_SCROLL      0x04
#define KIO_REGION_INPUT_DISABLED      0x08
#define KIO_REGION_INPUT_MULTILINE     0x10
#define KIO_REGION_INPUT_NONBLOCKING   0x20
#define KIO_REGION_INPUT_WRAP          0x40
#define KIO_REGION_INPUT_NOCURSOR      0x80
#define EOF -1
#define KFMT_NORMAL 0x0f /* white */
#define KFMT_ERROR  0x0c /* light red */
#define KFMT_WARN   0x0e /* yellow */
#define KFMT_OK     0x0a /* light green */
#define KFMT_INFO   0x0b /* light cyan */
#define LFMT_DIR    0x09 /* bright blue */
#define LFMT_LNK    0x0b /* light cyan */
#define LFMT_PIPE   0x06 /* brown */
#define LFMT_SOCK   0x0d /* light mangenta */
#define LFMT_BDEV   0x0e /* light yellow */
#define LFMT_CDEV   0x0e /* light yellow */
#define LFMT_MISS   KFMT_NORMAL /* missing file */
#define LFMT_ORPH   KFMT_NORMAL /* orphaned symlink */
#define LFMT_EXEC   0x0a /* light green */
#define LFMT_DOOR   LFMT_SOCK
#define LFMT_SUID   0x4f /* white on red */
#define LFMT_SGID   0xe0 /* black on yellow */
#define LFMT_STCK   0x10 /* black on blue */
#define LFMT_OWRT   0x21 /* blue on green (other writable) */
#define LFMT_SWRT   0x20 /* black on green (ow /w sticky) */
#define LFMT_CA     0x40 /* black on red (has capability) */
#define LFMT_MH     KFMT_NORMAL /* multihardlink */
void memdump(void* ofs, size_t sz);
int vprintf(const char* fmt, va_list arg);
int vrprintf(struct kio_region* cr, const char* fmt, va_list arg);
int printf(const char* fmt, ...) __attribute__ ((format (printf, 1, 2)));
int iprintf(const char* fmt, ...) __attribute__ ((format (printf, 1, 2)));
int rprintf(struct kio_region* cr, const char* fmt, ...) __attribute__ ((format (printf, 2, 3)));
int noprintf(const char* fmt, ...) __attribute__ ((format (printf, 1, 2))); /* dummy */
int cprintf(char col, const char* fmt, ...) __attribute__((format (printf, 2, 3)));
int crprintf(char col, struct kio_region* cr, const char* fmt, ...) __attribute__((format (printf, 3, 4)));
int sprintf(char* str, const char* fmt, ...) __attribute__((format (printf, 2, 3)));
int vsprintf(char* str, const char* fmt, va_list arg);
int snprintf(char* str, size_t n, const char* fmt, ...) __attribute__((format (printf, 3, 4)));
int vsnprintf(char* str, size_t n, const char* fmt, va_list arg);

int region_putchar(struct kio_region* cr, char c);
int putchar(char c);
void region_puts(struct kio_region* cr, const char* str);
void puts(const char* str);
int region_getchar(struct kio_region* cr);
int getchar();
size_t region_getline(struct kio_region* cr, char** lineptr, size_t* n);
size_t getline(char** lineptr, size_t* n); /*, FILE* stream);*/


/* Keyboard functions implemented in kbd.c 
 * */
#include "kbd.h"

/* File I/O functions from fnctl.h/... implemented in file.c
 * */
typedef uint32_t mode_t; /* __U32_TYPE */
typedef int ssize_t; /* signed __SWORD_TYPE */
typedef int64_t off_t;
typedef uint64_t ino_t; /* SYSCALL_ULONG_TYPE */
typedef int64_t blksize_t; /* SYSCALL_SLONG_TYPE */
typedef int64_t blkcnt_t; /* SQUAD_TYPE 64 */
typedef uint64_t dev_t; /* UQUAD_TYPE */
#define INVALID_DEVICE (-1ul)
typedef uint32_t uid_t; /* U32_TYPE */
typedef uint32_t gid_t; /* U32_TYPE */
typedef uint64_t nlink_t; /* SYSCALL_ULONG_TYPE */
typedef struct __dirstream {
		int fd;
		volatile int lock;
		size_t allocation;
		size_t size;
		size_t offset;
		off_t filepos;
		char data[0];
} DIR;
struct dirent
{
		ino_t d_ino;
		off_t d_off;
		unsigned short int d_reclen;
		unsigned char d_type;
		char d_name[256];
};
struct stat
{
		dev_t st_dev; /* device of file */
		ino_t st_ino; /* file serial number */
		mode_t st_mode; /* file mode */
		nlink_t st_nlink; /* link count */
		uid_t st_uid; /* UID of file owner */
		gid_t st_gid; /* GID of file owner */
		dev_t st_rdev; /* device number if file itself is device */
		off_t st_size; /* size in bytes */
		blksize_t st_blksize; /* optimal I/O block size */
		blkcnt_t st_blocks; /* number of 512-byte blocks allocated */
	    struct timespec st_atim;        /* Time of last access.  */
	    struct timespec st_mtim;        /* Time of last modification.  */
	    struct timespec st_ctim;        /* Time of last status change.  */
# define st_atime st_atim.tv_sec    /* Backward compatibility.  */
# define st_mtime st_mtim.tv_sec
# define st_ctime st_ctim.tv_sec
};
/* MODES for mode_t
 * */
#define S_IFMT    0170000 /* These bits determine file type.  */
/* File types.  */
#define S_IFDIR   0040000 /* Directory.  */
#define S_IFCHR   0020000 /* Character device.  */
#define S_IFBLK   0060000 /* Block device.  */
#define S_IFREG   0100000 /* Regular file.  */
#define S_IFIFO   0010000 /* FIFO.  */
#define S_IFLNK   0120000 /* Symbolic link.  */
#define S_IFSOCK  0140000 /* Socket.  */
/* POSIX.1b objects.  Note that these macros always evaluate to zero.  But
 *    they do it by enforcing the correct use of the macros.  */
#define S_TYPEISMQ(buf)  ((buf)->st_mode - (buf)->st_mode)
#define S_TYPEISSEM(buf) ((buf)->st_mode - (buf)->st_mode)
#define S_TYPEISSHM(buf) ((buf)->st_mode - (buf)->st_mode)
#define S_ISREG(m) ((m & S_IFMT) == S_IFREG)
#define S_ISDIR(m) ((m & S_IFMT) == S_IFDIR)
#define S_ISCHR(m) ((m & S_IFMT) == S_IFCHR)
#define S_ISBLK(m) ((m & S_IFMT) == S_IFBLK)
#define S_ISLNK(m) ((m & S_IFMT) == S_IFLNK)
#define S_ISSOCK(m) ((m & S_IFMT) == S_IFSOCK)
#define S_ISFIFO(m) ((m & S_IFMT) == S_IFIFO)
/* Protection bits.  */
#define S_ISUID   04000   /* Set user ID on execution.  */
#define S_ISGID   02000   /* Set group ID on execution.  */
#define S_ISVTX   01000   /* Save swapped text after use (sticky).  */
#define S_IREAD   S_IRUSR /* Read by owner.  */
#define S_IWRITE  S_IWUSR /* Write by owner.  */
#define S_IEXEC   S_IXUSR /* Execute by owner.  */
#define S_IRUSR   0400
#define S_IWUSR   0200
#define S_IXUSR   0100
#define S_IRWXU   0700
#define S_IRGRP   040
#define S_IWGRP   020
#define S_IXGRP   010
#define S_IRWXG   070
#define S_IROTH   04
#define S_IWOTH   02
#define S_IXOTH   01
#define S_IRWXO   07
#define S_IXUGO   0111
/* SEEK positions */
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2
/* FLAGS for fcntl and open
 * */
#define O_ACCMODE      0003
#define O_RDONLY         00
#define O_WRONLY         01
#define O_RDWR           02
#define O_CREAT        0100 /* Not fcntl.  */
#define O_EXCL         0200 /* Not fcntl.  */
#define O_NOCTTY       0400 /* Not fcntl.  */
#define O_TRUNC       01000 /* Not fcntl.  */
#define O_APPEND      02000
#define O_NONBLOCK    04000
#define O_NDELAY O_NONBLOCK
#define O_SYNC     04010000 /* DSYNC but with all metadata  */
#define O_FSYNC      O_SYNC
#define O_ASYNC      020000
#define O_RSYNC   040000000 /* <- not from linux */
#define O_LARGEFILE 0100000
#define O_DIRECTORY 0200000
#define O_NOFOLLOW  0400000
#define O_CLOEXEC  02000000
#define O_DIRECT     040000 /* direct access to user buffers (here always) */
#define O_NOATIME  01000000
#define O_PATH    010000000 /* don't really open, used for dir,stat */
#define O_DSYNC      010000 /* write sync + crucial metadata done after call */
#define O_TMPFILE 020200000
struct timeval;

int open(const char* path, int flags, ... /*mode_t mod*/);
int mknod(const char* path, mode_t mod, dev_t dev);
int mknodat(int dirfd, const char* path, mode_t mode, dev_t dev);
int mkdir(const char* path, mode_t mod);
int mkdirat(int dirfd, const char* path, mode_t mod);
int creat(const char* path, mode_t mod);
ssize_t read(int fd, void* buf, size_t noct);
ssize_t write(int fd, const void* buf, size_t noct);
int close(int fd);
off_t lseek(int fd, off_t offset, int ref);
int link(const char* oldpath, const char* newpath);
int symlink(const char* oldpath, const char* newpath);
int unlink(const char* path);
int stat(const char* path, struct stat* buf);
int lstat(const char* path, struct stat* buf);
int fstat(int df, struct stat* buf); 
int access(const char* path, int mod);
mode_t umask(mode_t mask);
int chmod(const char* path, mode_t mod);
int chown(const char* path, uid_t owner, gid_t grp);
int utimes(const char* path,
           const struct timeval* times);
int lutimes(const char* path,
            const struct timeval* times);
int futimes(int fd, const struct timeval* times);
DIR* opendir(const char* pathname);
DIR* fdopendir(int fd);
struct dirent* readdir(DIR* dp);
void rewinddir(DIR* dp);
void seekdir(DIR* dp, long int pos);
long int telldir(DIR* dp);
int dirfd(DIR* dp);
int closedir(DIR* dp);

void* locate_module_function(char* name);

/* linux-like spinlock types
 * */
typedef uint8_t ticket_t;
typedef uint16_t ticketpair_t;
typedef struct __attribute__ ((aligned(2))) {
		union {
				ticketpair_t head_tail;
				struct {
						ticket_t head, tail;
				} tickets;
		};
} spinlock_t;
typedef struct { int counter; } atomic_t;
typedef struct {
		atomic_t cnts;
		spinlock_t lock;
} rwlock_t; /* implementation prefers readers */
#define SPIN_LOCK_UNLOCKED { { 0 } }
#define RW_LOCK_UNLOCKED { { 0 }, SPIN_LOCK_UNLOCKED }
void spin_lock_init(spinlock_t* lock);
void spin_lock(spinlock_t* lock);
void spin_unlock(spinlock_t* lock);
void spin_lock_irqsave(spinlock_t* lock, unsigned long* flags);
void spin_lock_irq(spinlock_t* lock);
void spin_lock_bh(spinlock_t* lock);
void spin_unlock_irqrestore(spinlock_t* lock, unsigned long flags);
/* linux macro w/o ptr */
void spin_unlock_irq(spinlock_t* lock);
void spin_unlock_bh(spinlock_t* lock);
int spin_trylock(spinlock_t* lock);
int spin_trylock_bh(spinlock_t* lock);
void read_lock(rwlock_t *lock);
void read_lock_irqsave(rwlock_t *lock, unsigned long* flags);
void read_lock_irq(rwlock_t *lock);
void read_lock_bh(rwlock_t *lock);
void read_unlock(rwlock_t *lock);
void read_unlock_irqrestore(rwlock_t *lock, unsigned long flags);
void read_unlock_irq(rwlock_t *lock);
void read_unlock_bh(rwlock_t *lock);
/* no upgrading possible (&addr) */
void write_lock(rwlock_t *lock);
void write_lock_irqsave(rwlock_t *lock, unsigned long* flags);
void write_lock_irq(rwlock_t *lock);
void write_lock_bh(rwlock_t *lock);
int write_trylock(rwlock_t *lock);
void write_unlock(rwlock_t *lock);
void write_unlock_irqrestore(rwlock_t *lock, unsigned long flags);
void write_unlock_irq(rwlock_t *lock);
void write_unlock_bh(rwlock_t *lock);
#ifndef _mm_pause
#define _mm_pause() __asm__ volatile("pause" ::: "memory");
#endif
static inline long if_enabled()
{
		long rv;
		asm (
#ifdef __x86_64__
				"pushfq\n"
				"pop %%rax\n"
#else
				"pushfl\n"
				"pop %%eax\n"
#endif
				: "=a" (rv)
		);
		return ((rv & 0x20) != 0);
}

#define cpu_relax() _mm_pause()
#define PRIORITY_MAX 0
#define PRIORITY_ELEVATED 1
#define PRIORITY_REGULAR 2
#define PRIORITY_MIN 3
struct tsi* get_task();
void task_yield();
void task_spawn_named(void (*fn)(void*), void* dat, uint32_t priority, const char* name);
#define task_spawn(fun, dat, prio) task_spawn_named(fun, dat, prio, #fun)
struct perf_ctrs* bp_tick;
/* provide jiffies-like interface for delays */
extern uint64_t tsc_per_ms;
extern uint32_t loops_per_jiffy, loop_per_ms, apic_reload_value;
extern uint32_t nproc;
#define HZ 121
//#define HZ 300
#define jiffies (bp_tick->tick)
#define time_after(a,b) ((int64_t)((b) - (a)) < 0)
#define time_before(a,b) time_after(b,a)
void ndelay(unsigned long nsecs);
void udelay(unsigned long usecs);
void mdelay(unsigned long msecs);

/* wait queues */
struct wait_queue_head;
void wait_on_event(struct wait_queue_head* wq);
void wait_timeout(struct wait_queue_head* wq, uint32_t delta);
int wake_up_external_event(struct wait_queue_head* wq); /* signal event w/o pq lock */
int wake_up_all_external_event(struct wait_queue_head* wq);

#define TIF_NEED_RESCHED 0x01
#define TIF_YIELDED      0x02
#define TIF_DEALLOCATE   0x04
#define TIF_KERNEL_STACK 0x08
#define TIF_RUNNING      0x10
#define TIF_EXPIRED      0x20
#define TIF_IDLE         0x40
#define TIF_SLEEPING     0x80
/* preempt/barrier macros */
#define preempt_count() (get_task()->preempt_count)
#define add_preempt_count(val) do { preempt_count() += (val); } while(0);
#define sub_preempt_count(val) do { preempt_count() -= (val); } while(0);
#define inc_preempt_count() add_preempt_count(1)
#define dec_preempt_count() sub_preempt_count(1)
#define barrier() __asm__ __volatile__("": : :"memory")
#define preempt_disable() do { inc_preempt_count(); barrier(); } while(0)
#define preempt_enable_no_resched() do { barrier(); dec_preempt_count(); } while(0)
#define test_thread_flag(flag) (((get_task()->flags) & (flag))!=0)
#define preempt_schedule() do {task_yield(); } while(0);
#define preempt_check_resched() do { if (test_thread_flag(TIF_NEED_RESCHED)) preempt_schedule(); } while(0)
#define preempt_enable() do { preempt_enable_no_resched(); barrier(); preempt_check_resched(); } while(0)

struct kio_region
{
		short x, y, lx, ly, cx, cy;
		char fmt, flags;
		short cur_x, cur_y;
		spinlock_t lock;
};

/* custom IRQ handlers */
typedef int (*irq_handler_function)(unsigned int irq);
int install_irq_handler(unsigned int irq, irq_handler_function fun);
int remove_irq_handler(unsigned int irq, irq_handler_function fun);

/* the generic (linux inspired!) BUT locked list_head */
struct list_head {
		struct list_head* prev;
		struct list_head* next;
		spinlock_t lock;
};

#define LIST_HEAD_INIT(name) (struct list_head){ &(name), &(name), SPIN_LOCK_UNLOCKED }

static inline void __list_add(struct list_head *new,
		struct list_head *prev, struct list_head *next)
{
		next->prev = new;
		new->next = next;
		new->prev = prev;
		prev->next = new;
}

static inline void __list_del(struct list_head* entry)
{
		entry->prev->next = entry->next;
		entry->next->prev = entry->prev;
		entry->next = NULL;
		entry->prev = NULL;
}

static inline void list_add(struct list_head *new, struct list_head *head)
{
		spin_lock(&head->lock);
		__list_add(new, head, head->next);
		spin_unlock(&head->lock);
}

static inline void list_add_tail(struct list_head *new, struct list_head *head)
{
		spin_lock(&head->lock);
		__list_add(new, head->prev, head);
		spin_unlock(&head->lock);
}

static inline void list_del(struct list_head *entry, struct list_head* head)
{
		spin_lock(&head->lock);
		__list_del(entry);
		spin_unlock(&head->lock);
}

static inline int list_empty(const struct list_head *head)
{
	return head->next == head;
}

#define lock_list(lst) spin_lock(&(lst).lock)
#define unlock_list(lst) spin_unlock(&(lst).lock)
#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
#define container_of(ptr, type, member) ({ \
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
     (type *)( (char *)__mptr - offsetof(type,member) );})
#define list_entry(ptr, type, member) \
	container_of(ptr, type, member)
#define list_first_entry(ptr, type, member) \
	list_entry((ptr)->next, type, member)
#define list_last_entry(ptr, type, member) \
	list_entry((ptr)->prev, type, member)
#define list_first_entry_or_null(ptr, type, member) \
	(!list_empty(ptr) ? list_first_entry(ptr, type, member) : NULL)
#define list_next_entry(pos, member) \
	list_entry((pos)->member.next, typeof(*(pos)), member)
#define list_prev_entry(pos, member) \
	list_entry((pos)->member.prev, typeof(*(pos)), member)
#define list_for_each(pos, head) \
	for (pos = (head)->next; pos != (head); pos = pos->next)
#define list_for_each_entry(pos, head, member)				\
	for (pos = list_first_entry(head, typeof(*pos), member);	\
	     &pos->member != (head);					\
	     pos = list_next_entry(pos, member))
#define list_cut_first_entry(ptr, type, member) \
		({ type* __ptr; if (!list_empty(ptr)) { lock_list(*ptr); \
		 __ptr = list_first_entry_or_null(ptr, type, member); \
		 if (__ptr) __list_del(&__ptr->member); \
		 unlock_list(*ptr); } else __ptr = NULL; __ptr; })
/* arguments: ptr    - list_head
 *            type   - plain entry type for rv 
 *            member - name of list_head member of rv
 *            var    - variable name for iterator (used in cond)
 *            cond   - expression for condition evaluation */
#define list_cut_first_entry_where(ptr, type, member, var, cond) \
		({ type* var, *__ptr_rv = NULL; if (!list_empty(ptr)) \
		 { lock_list(*ptr); list_for_each_entry(var, ptr, member) { \
		 if (cond) { __ptr_rv = var; __list_del(&(var)->member); break; } } \
		 unlock_list(*ptr); } __ptr_rv; })
/* removes an entry of the list and enables the for_each to continue.
 * !Modifies ptr!: use copy of ptr for further access before continue. */
#define list_del_and_prepare_continue(ptr, head, member) \
		({ typeof(ptr) __mptr = ptr; ptr = list_prev_entry(ptr, member); \
		 list_del(&__mptr->member, head); })

/* add up all bytes */
static inline uint8_t checksum_memory(void* mem, size_t len)
{
		uint8_t rv = 0;
		while (len--)
				rv += *(uint8_t*)mem++;
		return rv;
}

