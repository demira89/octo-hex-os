/* gdt.h : Defines the offsets for the GDT entries.
 * */

/* only system descriptors become 16-byte (LDT, TSS, Gates) */
#define SEG_NULL      0x0000
#define SEG_CODE      0x0008
#define SEG_DATA      0x0010
#ifdef __x86_64__
#define SEG_TSS_PL0   0x0018 /* 16bt TSS */
#define SEG_CODE_USER 0x0028
#define SEG_DATA_USER 0x0030
#define SEG_DATA_PROC 0x0038
#define SEG_TSS_INTR  0x0040
#define GDT_SIZE      0x0050
#else
#define SEG_CODE_16   0x0018
#define SEG_DATA_16   0x0020
#define SEG_TSS_PL0   0x0028 /* inter privilege */
#define SEG_CODE_USER 0x0030
#define SEG_DATA_USER 0x0038
#define SEG_DATA_PROC 0x0040 /* per-processor data */
#define SEG_TSS_INTR  0x0048 /* interrupt TSS */
#define GDT_SIZE      0x0050
#endif

extern void* gdt;

