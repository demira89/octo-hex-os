/* kdata.h: Provides the global kernel data structures.
 *          These are allocated once in the common section.
 *          Details can be found at the beginning of the linker map.
 * */

#ifdef __x86_64__ /* (C) osdev.org/IDT  */
struct __attribute__((packed)) idt_entry {
   uint16_t offset_1;        // offset bits 0..15
   uint16_t selector;        // a code segment selector in GDT or LDT
   uint8_t  ist;             // bits 0..2 holds Interrupt Stack Table offset, rest of bits zero.
   uint8_t  type;            // gate type, dpl, and p fields
   uint16_t offset_2;        // offset bits 16..31
   uint32_t offset_3;        // offset bits 32..63
   uint32_t zero;            // reserved
};
#else
struct __attribute__((packed)) idt_entry {
   uint16_t offset_1;        // offset bits 0..15
   uint16_t selector;        // a code segment selector in GDT or LDT
   uint8_t  zero;            // unused, set to 0
   uint8_t  type;            // gate type, dpl, and p fields
   uint16_t offset_2;        // offset bits 16..31
};
#endif

extern struct cpuinfo {
		uint32_t max_leaf; /* highest allowed cpuid eax */
		uint32_t max_eleaf; /* highest extended info leaf */
		int reserved : 30;
		char vendor_id[16];
		char brand_string[48];
		union {
				uint32_t feat_eax;
				struct {
						uint32_t stepping : 4;
						uint32_t model : 4;
						uint32_t family : 4;
						uint32_t processor_type : 2;
						uint32_t res0 : 2;
						uint32_t extended_model : 4;
						uint32_t extended_family : 8;
						uint32_t res0b : 4;
				};
		};
		uint32_t feat_ebx;
		union {
				uint32_t feat_ecx;
				struct {
						uint32_t has_sse3 : 1;
						uint32_t has_pclmul : 1;
						uint32_t has_dtes64 : 1;
						uint32_t has_monitor : 1;
						uint32_t has_ds_cpl : 1;
						uint32_t has_vmx : 1;
						uint32_t has_smx : 1;
						uint32_t has_est : 1;
						uint32_t has_tm2 : 1;
						uint32_t has_ssse3 : 1;
						uint32_t has_cid : 1;
						uint32_t res1 : 1;
						uint32_t has_fma : 1;
						uint32_t has_cx16 : 1;
						uint32_t has_etprd : 1;
						uint32_t has_pdcm : 1;
						uint32_t res2 : 2;
						uint32_t has_dca : 1;
						uint32_t has_sse4_1 : 1;
						uint32_t has_sse4_2 : 1;
						uint32_t has_x2APIC : 1;
						uint32_t has_movbe : 1;
						uint32_t has_popcnt : 1;
						uint32_t res3 : 1;
						uint32_t has_aes : 1;
						uint32_t has_xsave : 1;
						uint32_t has_oxsave : 1;
						uint32_t has_avx : 1;
						uint32_t res4 : 3;
				};
		};
		union {
				uint32_t feat_edx;
				struct {
						uint32_t has_fpu : 1;
						uint32_t has_vme : 1;
						uint32_t has_de : 1;
						uint32_t has_pse : 1;
						uint32_t has_tsc : 1;
						uint32_t has_msr : 1;
						uint32_t has_pae : 1;
						uint32_t has_mce : 1;
						uint32_t has_cx8 : 1;
						uint32_t has_apic : 1;
						uint32_t res5 : 1;
						uint32_t has_sep : 1;
						uint32_t has_mtrr : 1;
						uint32_t has_pge : 1;
						uint32_t has_mca : 1;
						uint32_t has_cmov : 1;
						uint32_t has_pat : 1;
						uint32_t has_pse36 : 1;
						uint32_t has_psn : 1;
						uint32_t has_clf : 1;
						uint32_t res6 : 1;
						uint32_t has_dtes : 1;
						uint32_t has_acpi : 1;
						uint32_t has_mmx : 1;
						uint32_t has_fxsr : 1;
						uint32_t has_sse : 1;
						uint32_t has_sse2 : 1;
						uint32_t has_ss : 1;
						uint32_t has_htt : 1;
						uint32_t has_tm1 : 1;
						uint32_t has_ia64 : 1;
						uint32_t has_pbe : 1;
				};
		};
		uint32_t efeat_eax;
		uint32_t efeat_ebx;
		uint32_t efeat_ecx;
		union {
				uint32_t efeat_edx;
				struct {
						uint32_t e_fpu : 1;
						uint32_t e_vme : 1;
						uint32_t e_de : 1;
						uint32_t e_pse : 1;
						uint32_t e_tsc : 1;
						uint32_t e_msr : 1;
						uint32_t e_pae : 1;
						uint32_t e_mce : 1;
						uint32_t e_cx8 : 1;
						uint32_t e_apic : 1;
						uint32_t e_res0 : 1;
						uint32_t e_syscall : 1;
						uint32_t e_mtrr : 1;
						uint32_t e_pge : 1;
						uint32_t e_mca : 1;
						uint32_t e_cmov : 1;
						uint32_t e_pat : 1;
						uint32_t e_pse36 : 1;
						uint32_t e_res2 : 1;
						uint32_t e_has_mp : 1;
						uint32_t e_has_nx : 1;
						uint32_t e_res3 : 1;
						uint32_t e_mmxext : 1;
						uint32_t e_mmx : 1;
						uint32_t e_fxsr : 1;
						uint32_t e_fxsr_opt : 1;
						uint32_t e_pdpe1gb : 1;
						uint32_t e_rdtscp : 1;
						uint32_t e_res4 : 1;
						uint32_t e_has_longmode : 1;
						uint32_t e_3dnowext : 1;
						uint32_t e_3dnow : 1;
				};
		};
		uint32_t invariant_tsc;
} cpu;

#ifdef __x86_64__
struct __attribute__((packed)) tss {
		uint16_t res4;
		uint16_t iomap; /* base offset from TSS */
		uint64_t res3;
		uint64_t ist7;
		uint64_t ist6;
		uint64_t ist5;
		uint64_t ist4;
		uint64_t ist3;
		uint64_t ist2;
		uint64_t ist1;
		uint64_t res2;
		uint64_t rsp2;
		uint64_t rsp1;
		uint64_t rsp0;
		uint32_t res;
};
#else
struct tss {
		uint16_t link;
		uint16_t link_h;
		uint32_t esp0;
		uint16_t ss0;
		uint16_t ss0_h;
		uint32_t esp1;
		uint16_t ss1;
		uint16_t ss1_h;
		uint32_t esp2;
		uint16_t ss2;
		uint16_t ss2_h;
		uint32_t cr3;
		uint32_t eip;
		uint32_t eflags;
		uint32_t eax, ecx, edx, ebx, esp, ebp, esi, edi;
		uint16_t es, es_h, cs, cs_h, ss, ss_h, ds, ds_h, fs, fs_h, gs, gs_h;
		uint16_t ldt, ldt_h;
		uint16_t trap, iomap;
};
#endif

extern struct vmd {
		char is_textmode; char gm_bts; /* 4/8/15/16/24/32 */
		char btpp;
		int32_t width, height; uint32_t bpsl;
		uint32_t fnt, txt, ptr; /* low ptrs */
} video_mode;

extern void* vga_mem_ptr;
extern void* vga_pmem;
extern size_t vga_pmem_size;
extern const char* vga_font;

struct rct {
		struct kio_region r[32];
		struct rct* next;
		size_t r_ct;
};

struct exclude_rect {
		int x, y, lx, ly;
		struct exclude_rect* next;
};

extern struct framebuffer {
		void* text_mem;
		ssize_t width; /* in character cells */
		ssize_t height;
		const char* font;
		int is_visible; /* only access hardware if visible */
		ssize_t cur_x, cur_y; /* cursor location */
		ssize_t pix_x, pix_y; /* used as charofs in TM */
		ssize_t cho_x, cho_y;
		ssize_t chw_x, chw_y;
		struct rct* r_ud;
		struct exclude_rect* r_excl;
} fb_initial;

void framebuffer_initialize(struct framebuffer* fb, const char* font, 
				void* textmem, ssize_t width, ssize_t height, ssize_t pxl_ofs_x,
				ssize_t pxl_ofs_y, ssize_t char_ofs_x, ssize_t char_ofs_y,
				ssize_t char_width_x, ssize_t char_width_y);
void framebuffer_redraw(struct framebuffer* fb);
void framebuffer_scroll_region(struct framebuffer* fb,
				struct kio_region* r, ssize_t nx, ssize_t ny);
void framebuffer_clear_region(struct framebuffer* fb, struct kio_region* r);
void framebuffer_update_region(struct framebuffer* fb, struct kio_region* r);
void framebuffer_set_cursor(struct framebuffer* fb, ssize_t x, ssize_t y);
void framebuffer_redraw_updates(struct framebuffer* fb);
void framebuffer_add_exclude_rect(struct framebuffer* fb, struct exclude_rect* r);
void framebuffer_remove_exclude_rect(struct framebuffer* fb, struct exclude_rect* r);

/* stat counters
 * */
#define COLLECT_STATS

#ifdef COLLECT_STATS
#define STAT_DECL_COUNTER(name, type) type name
#define STAT_INC_COUNTER(name, inc) __sync_fetch_and_add(&name, inc)
#define STAT_DEC_COUNTER(name, dec) __sync_fetch_and_sub(&name, dec)
#define STAT_COUNTER(name) name
#define STAT_ARG(arg) , arg
#else
#define STAT_DECL_COUNTER(name, type)
#define STAT_INC_COUNTER(name, inc)
#define STAT_DEC_COUNTER(name, dec)
#define STAT_COUNTER(name)
#define STAT_ARG(arg)
#endif

/* The number of major rotations of the staircase scheduler */
#ifdef COLLECT_STATS
extern STAT_DECL_COUNTER(sched_mr_count, uint32_t);
#endif

/* processor performance counter structure */
struct perf_ctrs {
		uint64_t tick;
		uint64_t ns_idle;
		uint64_t ns_kernel;
		uint64_t ns_user;
		uint64_t sec_ns_idle;
		uint64_t sec_ns_kernel;
		uint64_t sec_ns_user;
		uint32_t ns_idle_per_sec;
		uint32_t ns_kernel_per_sec;
		uint32_t ns_user_per_sec;
		uint32_t n_times;
		uint32_t n_times_per_sec;
		uint32_t sec_n_times;
};

/* task struct for scheduling */
struct tsi {
		uint32_t flags;
		struct task_state* ts;
		void* stack_base;
		void* stack_limit;
		const char* name;
		uint32_t task_id;
		uint32_t preempt_count;
		uint32_t sec_run_time; /* run time up to last second */
		uint32_t run_time_sec; /* run time in the last second */
		uint32_t run_time; /* total run time */
		uint32_t priority;
		int32_t quota;
		uint32_t cur_priority;
		uint64_t start_time; /* the (last) start time */
		uint64_t stop_time; /* the real stop time*/
		uint32_t task_proc;
		uint64_t ns_run;
		uint64_t ns_acc;
		uint64_t sec_ns_acc;
		uint32_t ns_per_sec;
		/* The number of priority bumps of this task in minor rotations */
		STAT_DECL_COUNTER(task_mr_bumps, uint32_t);
		/* The number of times this taks expired (i.e. MaR count) */
		STAT_DECL_COUNTER(task_mr_expires, uint32_t);
};
//struct task {
//		struct tss tss;
//		/* fxstore/fxrestore? */
//		void* stack_limit;
//		void* stack_base;
//};

#define WAIT_QUEUE_HEAD(name) (struct wait_queue_head){(struct wait_queue*)&name, (struct wait_queue*)&name, SPIN_LOCK_UNLOCKED, 0}
struct wait_queue_head {
		struct wait_queue* prev;
		struct wait_queue* next;
		spinlock_t lock;
		int signaled;
};
struct wait_queue {
		struct wait_queue* prev;
		struct wait_queue* next;
		struct tsi* task;
		uint64_t timeout;
};

