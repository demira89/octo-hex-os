# vi:syntax=asmx86
# Used by top ld.in script
.code16
.intel_syntax noprefix
.section .p0text, "awx", @progbits
.org 0x0

bootsector:
 iOEM:          .ascii "DevOs   "    # OEM String
 iSectSize:     .word  0x200         # bytes per sector
 iClustSize:    .byte  1             # sectors per cluster
 iResSect:      .word  0             # #of reserved sectors
 iFatCnt:       .byte  2             # #of FAT copies
 iRootSize:     .word  224           # size of root directory (14 sec)
 iTotalSect:    .word  5824          # total # of sectors if over 32 MB
 iMedia:        .byte  0xF8          # media Descriptor
 iFatSize:      .word  22            # size of each FAT (2*2880 bytes)
 iTrackSect:    .word  63            # sectors per track
 iHeadCnt:      .word  16            # number of read-write heads
 iHiddenSect:   .int   0             # number of hidden sectors
 iSect32:       .int   0             # # sectors for over 32 MB
# FAT12/16 stuff
 iBootDrive:    .byte  0             # holds drive that the boot sector came from
 iReserved:     .byte  0             # reserved, empty
 iBootSign:     .byte  0x29          # extended boot sector signature XBPB
 iVolID:        .ascii "seri"        # disk serial
 acVolumeLabel: .ascii "MYVOLUME   " # volume label
 acFSType:      .ascii "FAT16   "    # file system type


.section .fat16dir
 .ascii "MYVOLUME"                   # file name
 .ascii "   "                        # file extension
 .byte  8                            # is volume label
 .byte  0                            # reserved
 .byte  0                            # creation time in ms
 .word  0                            # creation time
 .word  0                            # creation date
 .word  0                            # access date
 .word  0                            # reserved (FAT32 high numbers)
 .word  0                            # last modified time HMS 5/6/5
 .word  0                            # last modified date YMD 7/4/5 (Y0=1990)
 .word  0x0                          # start cluster offset (+2)
 .int   0                            # file size

 .ascii "MYFILE  "                   # file name
 .ascii "TXT"                        # file extension
 .byte  0                            # file attributes
 .byte  0                            # reserved
 .byte  0                            # creation time in ms
 .word  0                            # creation time
 .word  0                            # creation date
 .word  0                            # access time
 .word  0                            # reserved (FAT32 high numbers)
 .word  0                            # last modified time HMS 5/6/5
 .word  0                            # last modified date YMD 7/4/5 (Y0=1990)
 .word  0x2                          # start cluster offset (+2)
 .int   fend-fstart                  # file size

.section .fat16files
fstart:
.ascii "Diese Datei enthaelt text"
.fill 1212, 1, 'd'
fend:
.align 0x200

