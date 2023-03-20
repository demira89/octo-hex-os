/* fixmem.h : Defines fixed memory locations used without prior
 *            allocation by a memory manager.
 * */

/* memory manager locations */
#define FM_AP_STACK        (void*)0x05000
#define FM_AP_TRAMPOLINE   (void*)0x06000
#define FM_MEMORY_MAP      (void*)0x20000
#define FM_RESV_MEMORY_MAP (void*)0x22000
#define FM_FREE_MEMORY_MAP (void*)0x24000
#define FM_VIRTUAL_MAPPING (void*)0x28000
/* other stuff */
#define FM_FAT16_BPB       (void*)0x30000
#define FM_FAT16_FILES     (void*)0x40000
#define FM_VGA_MODELIST    (void*)0x48000
#define FM_VIDEO_MODE      (void*)0x4f000
#define FM_VGA_TEST        (void*)0x50000
#define FM_SECTOR_DATA     (void*)0x62000
#define FM_FAT16_CLSTRS    (void*)0x62400
#define FM_VIDEO_MEMORY    (void*)0xb8000


