/* virtmem.h : Contains the fixed virtual addresses for various mappings.
 * */

#ifdef __x86_64__
#define VM_VIDEO_MEMORY         ((void*)0xffffffffe0000000)
#define VM_KERNEL_BASE          ((void*)0xffffffff80000000)
#define VM_QND_BASE             ((void*)0xffff000000000000)
#define VM_QND_LIMIT            ((void*)0xffffffff80000000)
#define VM_KERNEL_STACK_BASE    ((void*)0xfffffffffe000000)
#define VM_KERNEL_STACK_LIMIT   ((void*)0xffffffffff000000)
#define VM_MM_PER_CPU_BASE      ((void*)0xfffffffffb000000) /* 4096 cpus */
#define VM_MM_PER_CPU_LIMIT     ((void*)0xfffffffffc000000) /* used for parallel scrub */
#define VM_PMU_BASE             ((void*)0xfffffffffc000000) /* 4096 PMUs */
#define VM_PMU_LIMIT            ((void*)0xfffffffffd000000) /* -> 256G */
#define VM_RCP_BASE             ((void*)0xfffffffffd000000) /* 4096 RCPs */
#define VM_RCP_LIMIT            ((void*)0xfffffffffe000000) /* -> 256G */
#define VM_TABLE_BASE           ((void*)0xfffffffffffff000) /* 4096 tables */
#define VM_TABLE_LIMIT          ((void*)0xfffffffffe000000) /* -> <8G /w 4K pgs */
#else
#define VM_KERNEL_BASE          ((void*)0x80000000)
/* used until mm has rb_tree? */
#define VM_QND_BASE             ((void*)0x90000000)
#define VM_QND_LIMIT            ((void*)0xa0000000)
#define VM_VIDEO_MEMORY         ((void*)0xe0000000)
#define VM_KERNEL_STACK_BASE    ((void*)0xfe000000)
#define VM_KERNEL_STACK_LIMIT   ((void*)0xff000000)
/* also consider PAE(up to 38) */
#define VM_MM_PER_CPU_BASE      ((void*)0xfb000000) /* 4096 cpus */
#define VM_MM_PER_CPU_LIMIT     ((void*)0xfc000000) /* used for parallel scrub */
#define VM_PMU_BASE             ((void*)0xfc000000) /* 4096 PMUs */
#define VM_PMU_LIMIT            ((void*)0xfd000000) /* -> 256G */
#define VM_RCP_BASE             ((void*)0xfd000000) /* 4096 RCPs */
#define VM_RCP_LIMIT            ((void*)0xfe000000) /* -> 256G */
#define VM_TABLE_BASE           ((void*)0xfffff000) /* 4096 tables */
#define VM_TABLE_LIMIT          ((void*)0xfe000000) /* -> <8G /w 4K pgs */
#endif
