/* virtmem.h : Contains the fixed virtual addresses for various mappings.
 * */

#ifdef __x86_64__
#define VM_VIDEO_MEMORY         ((void*)(size_t)0xffffffffe0000000)
#define VM_KERNEL_BASE          ((void*)(size_t)0xffffffff80000000)
#define VM_QND_BASE             ((void*)(size_t)0xfffff00000000000)
#define VM_QND_LIMIT            ((void*)(size_t)0xffffffff80000000)
#define VM_KERNEL_STACK_BASE    ((void*)(size_t)0xfffffffffe000000)
#define VM_KERNEL_STACK_LIMIT   ((void*)(size_t)0xffffffffff000000)
#define VM_MM_PER_CPU_BASE      ((void*)(size_t)0xfffffffffb000000) /* 4096 cpus */
#define VM_MM_PER_CPU_LIMIT     ((void*)(size_t)0xfffffffffc000000) /* used for parallel scrub */
#define VM_PMU_BASE             ((void*)(size_t)0xfffffffffc000000) /* 4096 PMUs */
#define VM_PMU_LIMIT            ((void*)(size_t)0xfffffffffd000000) /* -> 256G */
#define VM_RCP_BASE             ((void*)(size_t)0xfffffffffd000000) /* 4096 RCPs */
#define VM_RCP_LIMIT            ((void*)(size_t)0xfffffffffe000000) /* -> 256G */
#define VM_TABLE_BASE           ((void*)(size_t)0xfffffffffffff000) /* 4096 tables */
#define VM_TABLE_LIMIT          ((void*)(size_t)0xfffffffffe000000) /* -> <8G /w 4K pgs */
#else
#define VM_KERNEL_BASE          ((void*)(size_t)0x80000000)
/* used until mm has rb_tree? */
#define VM_QND_BASE             ((void*)(size_t)0x90000000)
#define VM_QND_LIMIT            ((void*)(size_t)0xa0000000)
#define VM_VIDEO_MEMORY         ((void*)(size_t)0xe0000000)
#define VM_KERNEL_STACK_BASE    ((void*)(size_t)0xfe000000)
#define VM_KERNEL_STACK_LIMIT   ((void*)(size_t)0xff000000)
/* also consider PAE(up to 38) */
#define VM_MM_PER_CPU_BASE      ((void*)(size_t)0xfb000000) /* 4096 cpus */
#define VM_MM_PER_CPU_LIMIT     ((void*)(size_t)0xfc000000) /* used for parallel scrub */
#define VM_PMU_BASE             ((void*)(size_t)0xfc000000) /* 4096 PMUs */
#define VM_PMU_LIMIT            ((void*)(size_t)0xfd000000) /* -> 256G */
#define VM_RCP_BASE             ((void*)(size_t)0xfd000000) /* 4096 RCPs */
#define VM_RCP_LIMIT            ((void*)(size_t)0xfe000000) /* -> 256G */
#define VM_TABLE_BASE           ((void*)(size_t)0xfffff000) /* 4096 tables */
#define VM_TABLE_LIMIT          ((void*)(size_t)0xfe000000) /* -> <8G /w 4K pgs */
#endif
