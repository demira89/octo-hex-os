# vi:syntax=asmx86
.code16
.intel_syntax noprefix
.section .bstext, "awx", @progbits
.org 0x0
.global rm_read_sector
#.globl _start1
	jmp short main
	nop

bootsector:
 iOEM:          .ascii "DevOs   "    # OEM String
 iSectSize:     .word  0x200         # bytes per sector
 iClustSize:    .byte  1             # sectors per cluster
 iResSect:      .word  512           # #of reserved sectors (large loader?)
 iFatCnt:       .byte  2             # #of FAT copies
 iRootSize:     .word  224           # size of root directory
 iTotalSect:    .word  5824          # total # of sectors if over 32 MB
 iMedia:        .byte  0xF0          # media Descriptor
 iFatSize:      .word  22            # size of each FAT (2*2880 bytes)
maxS: iTrackSect:    .word  18            # sectors per track
 iHeadCnt:      .word  2             # number of read-write heads
 iHiddenSect:   .int   0             # number of hidden sectors
 iSect32:       .int   0             # # sectors for over 32 MB
# FAT12/16 stuff
 iBootDrive:    .byte  0             # holds drive that the boot sector came from
 retrCt: iReserved:     .byte  0             # reserved, empty
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

.section .bstext, "awx", @progbits

LOAD_SEGMENT=0x7c00

main:
	# Set up the segment registers
	cli
	mov ax, cs          # CS = 0x0 -> 0x7c00
	mov ds, ax          # DS = CS = 0x0
	mov ss, ax          # SS = CS = 0x0
	mov sp, 0x7C00      # Stack grows down from offset 0x7C00 toward 0x0000.
	mov ax, 0xb800
	mov es, ax          # ES = 0xb800 = video memory
	sti
	movb [iBootDrive], dl

#	# set 80x25 text mode so we're in a known state, and to set 8x16 font
#	mov ax, 0x0004
#	int 0x10
#
#	# set 80x50 text mode and 8x8 font
#	mov ax, 0x1112
#	xor bl, bl
#	int 0x10
#	mov ax, 0x4f02 # VESA
#	mov bx, 0x108 # all textmode not supported by vbox 105
#	int 0x10
#	mov ax, 0x4f00
#	mov di, 0x7e00
#	int 0x10

	# enable a20
	mov ax, 0x2401
	int 0x15
	cmp ah, 0x86
	jz error_a20
	cmp ah, 0x00
	jnz error_a20

	# use es twice
	push es
	# get the memory map and store it at 0x00000500
	mov ax, 0x50
	mov es, ax
	xor di, di
	xor ebx, ebx
	mov edx, 0x534d4150
get_mem:
	mov eax, 0xe820
	mov ecx, 24
	int 0x15
	jc mem_err
	cmp eax, edx
	jne mem_err
	test ebx, ebx
	jz rd_dsk          # done if ebx=0
	add di, 24
	jmp get_mem

	# check for extensions
##	mov ah, 0x41
##	mov bx, 0x55aa
##	mov dl, [iBootDrive]
##	int 0x13
##	jc rd_dsk
##	test bx, 0xaa55
##	jne rd_dsk
##	and cx, 1 # check bitmap
##	test cx, cx
##	jz rd_dsk
#	# we can use LBA read
#	# first set up address packet
#tktk:
#	.byte 0x10, 0
#rs:	.word 1
#	.word 0x7e00, 0
#	.quad 0
#rex:
##	lea ax, restsize # calc by ld
##	movw [rs], ax
##	mov ah, 0x42
##	lea si, tktk
##	mov dl, [iBootDrive]
##	int 0x13
##	jnc rd_done
#	mov ah, 0x42
#	xor si, si
#	mov ax, 0x7a00
#	mov ds, ax
#	movw ds:[0], 0x1000
#	movw ds:[2], 1
#	movw ds:[4], 0x7e00
#	movw ds:[6], 0
##	movw ds:[8], 0
##	movw ds:[10], 0
##	movw ds:[12], 0
##	movw ds:[14], 0
#	mov dl, [iBootDrive]
#	int 0x13
#	xor ax, ax
#	mov ds, ax
#
#	pop es
#	movb es:0, 'A'
#	movb es:1, 0x0e
	# load the (pre-)kernel sections to 0x00007e00-0x00080000 << 1MB
rd_dsk:
#	mov ax, 0x7e0
#	mov es, ax
#	lea ax, restsize
	mov ax, OFFSET basesize
#	jmp rd_init
#	lea ax, endrest
#	lea bx, rest
#	sub ax, bx
#	xor dx, dx
#	mov bx, 0x0200
#	div bx
#	test dx, dx
#	jz rd_init
#	inc ax
	# al now contains the number of sectors (+1 if not full)
#maxH: moved to save space
rd_init:
	movw [numSec], ax
	# disk get param
	xor ax, ax
	mov es, ax
	mov ah, 0x08
	mov dl, [iBootDrive]
	xor di, di
	int 0x13
	jc rd_nxt #assume floppy
	mov bl, ah
	movb [maxS], cl
	andb [maxS], 0b00111111
	movb [maxH], dh
	xor ah, ah
	mov al, dh
	inc ax
	movw [iHeadCnt], ax
	movb al, [maxS]
	mov [iTrackSect], ax
#	pop es
#	add dh, '0'
#	and cl, 0b00111111
#	add cl, '0'
#	movb es:[0], dh
#	movb es:[1], 0xe
#	movb es:[2], cl
#	movb es:[3], 0xe
#	jmp ll
	jmp rd_nxt
maxH: .byte 1
numSec: .word 0x100   # 6bytes later used for gdtr
curSec: .byte 2
curHed: .byte 0
curCyl: .byte 0
curOfs: .word 0x7e0
#retrCt: .byte 0
rd_nxt:
	movb [retrCt], 0
rd_retry:
	movb ah, 0x02
	movb al, 1
	movb ch, [curCyl]
	movb cl, [curSec]
	movb dh, [curHed]
	movb dl, [iBootDrive]
	movw bx, [curOfs]
	mov es, bx
	xor bx, bx
	int 0x13
	jnc rd_noerr
	test ah, ah
	jz rd_noerr
	# retry operation
	pop es
	mov al, ah
	call prnt_bt
tieo:
	jmp tieo
	incb [retrCt]
	cmpb [retrCt], 6
	jle rd_retry
	movb [retrCt], 0
	# reset drive
	xor ah, ah
	int 0x13
	jmp rd_dsk
	# advance if necessary
rd_noerr:
	decw [numSec]
	cmpw [numSec], 0
	je rd_done
	addw [curOfs], 0x20
	incb [curSec]
	movb al, [maxS]
	cmpb [curSec], al
	jle rd_nxt
	# maxS-1 sectors read increase head index
	movb [curSec], 1
	incb [curHed]
	movb al, [maxH]
	cmpb [curHed], al
	jle rd_nxt
	# maxH heads used increase cylinder
	movb [curHed], 0
	incb [curCyl]
	jmp rd_nxt
rd_done:
	pop es
	mov ax, 0x7e0

#	push ds
#	xor dx, dx
#os1:
#	mov ds, ax
#	call memdump
#	mov ah, 0x86
#	mov cx, 2
#	int 0x15
#	inc dx
#	mov ax, dx
#	add di, 2
#	call prnt_bt
#	mov ax, ds
#	add ax, 0x20
#	cmp ax, 0x27c0 #OFFSET FLAT : endrestdv
#	jle os1
#	pop ds

	call testfun
#	movb es:0, 'A'
#	movb es:1, 0x0e
#ll:
#	jmp ll
	# do the extended BIOS I/O
##	call nopfun
#	push ax
#	mov ax, 0x7e0 <---- killed gdtr references and created untraceable bugs!
#	mov bx, ax
#	mov ds, ax
#	call memdump
	#jmp nope

	# init gdtr structure with offset+size
#	cli
#	lea eax, gdt
#	mov dword ptr[gdtr+2], eax
#	lea eax, gdt_end-1
#	sub eax, OFFSET gdt
#	mov word ptr[gdtr], ax
#	sgdt [numSec]
#	sidt ds:[0x7cfa]
#	lgdt [gdtr]
#	# enable PM
#	mov eax, cr0
#	or al,1
#	mov cr0, eax
#	ljmp 0x08,reload_segs
#.code32
#reload_segs:
#	cli
#	mov ax, 0x10
#	mov ds, ax
#	mov es, ax
#	mov fs, ax
#	mov gs, ax
#	mov ss, ax
#	# stack grows upwards
#	mov esp, 0x00080000
#	mov ebp, esp
#	# mask NMI (undone in idt)
#	inb al, 0x70
#	or al, 0x80
#	outb 0x70, al
#	call early_entry
#	call idt_init
#	sti
##	pushad
#	call kmain
##	popad
#nope32:
#	jmp nope32


.code16

	# now enter pm and call the kernel
#	call kmain
nope:
	jmp nope

spce:
	mov al, ' '
	stosb
	mov al, 0x0e
	stosb
	ret

prnt_bt:
	mov ah, al
	shr al, 4
	call char_trans
	stosb
	mov al, 0x0e
	stosb
	mov al, ah
	call char_trans
	stosb
	mov al, 0x0e
	stosb
	call spce
	ret
	
char_trans:
	and al, 0x0f
	cmp al, 0x09
	jbe ct_end
	add al, 'a'-'0'-10
ct_end:
	add al, '0'
	ret
#
msv: .byte 0
memdump:
	# dump first 512 bytes at ds to video memory ES=0xb800
#	push si
#	push di
#	push ax
#	push bx
#	push cx
	xor si, si
	xor di, di
	xor bx, bx
	xor cx, cx
md_rd: # read data and form string
	movb al, ds:[si]
	addb cl, al
	call prnt_bt
	inc si
	inc bl
	cmp bl, 24
	jl md_nxt
	mov bl, 80-3*24-3
	movb al, cl
	call prnt_bt
md_spc:
	call spce
	dec bl
	test bl, bl
	jnz md_spc
	add ch, cl
	xor cl, cl
md_nxt:
	cmp si, 0x200
	jl md_rd
	mov al, ch
	call prnt_bt
#	pop cx
#	pop bx
#	pop ax
#	pop di
#	pop si
	ret

mem_err:
#	pop es
#	lea si, [s_mem]
#	xor di, di
#	jmp ea_rep
error_a20:
#	lea si, [string]
#	xor di, di
ea_rep:
#	lodsb
#	test al, al
#	jz nope
#	stosb
#	mov al, 0x1e
#	stosb
#	jmp ea_rep

.section .bsdata, "aw", @progbits
string: .asciz "A20"
s_mem:  .asciz "mm"
gdtr:	.word 0
        .int  0
.global gdtr
gdtr2:  .word 0
ap_gdtp:.int 0
.global ap_gdtp
.global gdtr2

# BIOS real mode I/O available after loading rest
.section .bsrmio, "awx", @progbits
.align 16
gdt: .quad 0
flatcode: .byte 0xff, 0xff, 0, 0, 0, 0b10011010, 0b11001111, 0
flatdata: .byte 0xff, 0xff, 0, 0, 0, 0b10010010, 0b11001111, 0
b16tcode: .byte 0xff, 0xff, 0, 0, 0, 0x9a, 0x0f, 0 # 11->32bit 4KB
b16tdata: .byte 0xff, 0xff, 0, 0, 0, 0x92, 0x0f, 0 # 00->16bit 1bt
kernltss: .quad 0
usercode: .byte 0xff, 0xff, 0, 0, 0, 0b11111010, 0b11001111, 0
userdata: .byte 0xff, 0xff, 0, 0, 0, 0b11110010, 0b11001111, 0
# only 4 bytes size limit base will be set dynamically, read-only
pcp_gdte: .byte 0x04, 0x00, 0, 0, 0, 0b10010000, 0b01000000, 0 # kernel data (40h)
intrtss:  .quad 0 # 48h TSS for #SS
gdt_end:
.global kernltss
.global intrtss

nopfun:
	jmp nf_rd
	# check for LBA access
#	mov dl, [iBootDrive]
#	mov ah, 0x41
#	mov bx, 0x55aa
#	int 0x13
#	jc no_lba
#	cmp bx, 0xaa55
#	je lba_ok
#no_lba:
#	lea si, [lba_err]
#	call msg_fun
#	jmp nf_rd
#
#lba_ok:
#	lea si, [lba_noerr]
#	call msg_fun
nf_iLBA: .word 0
nf_iSec: .word 0
nf_iOfs: .word 0

nf_rd:
	lea si, [nf_fat16]
	call msg_fun

	# NOW find the file pci.ko in the root directory
	# rootOfs=(base+resSec)+n_fat*fatSec
	# maxSec: 16xxx <= 16bit
	movw cx, [iResSect]
	movw ax, [iFatSize]
	xor bh, bh
	movb bl, [iFatCnt]
	mul bx
	add ax, cx
	# result in dx:ax (guranteed 16 bits -> discard dx)
	movw [nf_iLBA], ax
	# calculate the sector count of root directory
	movw ax, [iRootSize]
	mov bx, 32
	mul bx
	# dx:ax has byte ct
	mov bx, [iSectSize]
	div bx
	# quot in ax, rem in dx
	test dx, dx
	jz nf_p1
	inc ax
nf_p1:
	movw [nf_iSec], ax
	
nf_p2:
	movw ax, [nf_iLBA]
	mov di, [nf_iOfs]
	call read_sect
	incw [nf_iLBA]
	addw [nf_iOfs], 0x200
	decw [nf_iSec]
	movw ax, [nf_iSec]
	test ax, ax
	jnz nf_p2
	lea si, [msg_drt]
	call msg_fun

	# now print all the filenames
	# table is in memory therefore modifiable
	movw cx, [iRootSize]
	push ds
	mov ax, 0x6200
	mov ds, ax
	xor si, si

prnt_lp:
	mov di, si
	add di, 0x0b
	movb ds:[di], 0x00
	push si
	call msg_fun
	pop si
	# now do strcmp with fn_pci
	
	add si, 32
	movb al, ds:[si]
	test al, al
	jnz prnt_lp
	pop ds

	jmp nope
	nop
	ret

# in: ax, di
read_sect:
	push es
	push bx
	push cx
	push dx
	push ax # b,c,d,a
	mov bx, 0x6200
	mov es, bx
	jmp rs_cnt
rs_c: .word 0
rs_h: .word 0
rs_s: .word 0
	# convert 16-bit LBA to CHS iHeadCnt iTrackSect
	# C=LBA/(HC*SPT)
	# H=LBA/SPT % HC
	# S=(LBA % SPT) + 1
rs_cnt:
	movb [retrCt], 0
rs_rtr:
	movw ax, [iHeadCnt]
	mov bx, [iTrackSect]
	mul bx
	test dx, dx
	jnz err_siz
	mov bx, ax
	pop ax
	push ax
	div bx
	# ax is C
	movw [rs_c], ax
	pop ax
	push ax
	xor dx, dx
	movw bx, [iTrackSect]
	div bx
	# ax is LBA/SPT, dx is LBA%SPT
	inc dx
	movw [rs_s], dx
	xor dx, dx
	mov bx, [iHeadCnt]
	div bx
	# dx is (LBA/SPT)%HC
	movw [rs_h], dx
	# CHS conversion done
	# read single sector
	mov ah, 0x02
	mov al, 1
	movw cx, [rs_c] # CX=7654321098 543210 cyl:sec
	mov bx, cx
	and bx, 0b0000001100000000
	shl cx, 8
	shr bx, 2
	or cx, bx
	movw dx, [rs_s]
	and dx, 0b0000000000111111
	add cx, dx
	movw dx, [rs_h]
	shl dx, 8
	mov dl, [iBootDrive]
	mov bx, di
	int 0x13
	jnc rs_noerr
	test ah, ah
	jz rs_noerr
	# retry operation
	incb [retrCt]
	cmpb [retrCt], 3
	jle rs_rtr
	# reset drive
	xor ah, ah
	int 0x13
	jmp rs_cnt

rs_noerr:
	pop ax # a,d,c,b
	pop dx
	pop cx
	pop bx
	pop es
	ret

err_siz:
	add sp, 8
	pop es
	lea si, [msg_siz]
	call msg_fun
	jmp nope

.global msg_fun
msg_fun: # ds:si -> es:(msg_dst)
	movw di, cs:[msg_dst]
msg_nxt:
	lodsb
	test al, al
	jz msg_done
	stosb
	mov al, 0x0f
	stosb
	jmp msg_nxt

msg_done:
	# prepare offset for next line
	mov ax, di
	mov cl, 160
	div cl
	test ah, ah
	jz msg_upd
	mov cx, 160
	shr ax, 8
	sub cx, ax
	add di, cx
msg_upd:
	movw cs:[msg_dst], di
	# wait 2 seconds
	mov ah, 0x86
	mov cx, 0x1e
	mov dx, 0x8480
	int 0x15
	# and return to caller
	ret

#lba_err: .asciz "No LBA BIOS extenstions present. Only limited early disk access."
#lba_noerr: .asciz "BIOS LBA extension present."
.global msg_dst
msg_dst: .word 0
nf_fat16: .asciz "parsing FAT16 formatted disk..."
msg_siz: .asciz "HC*SPT larger than 16 bits"
msg_drt: .asciz "done reading FAT16 root directory"
fn_pci: .asciz "pci     ko "

.code32
.global to_usermode
to_usermode:
	cli
ot:
jmp ot
	mov ax, (7*8|3) # RPL=3
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	push (7*8|3) # RPL=3
	mov eax, esp
	push eax # continue on kernel stack (hack)
	pushf
	or dword ptr[esp], 0x00000200
	push (6*8|3) # RPL=3
	push OFFSET usermode_entry
	iretd

rm_read_sector:
	movb [sd_bt], 0 # rm_read
	jmp rm_vga_2

.global rm_int16
rm_int16:
	movb [sd_bt], 3 # int16
	jmp rm_vga_2

.global rm_vga_int10
rm_vga_int10:
	movb [sd_bt], 2 # vga instead of read_sect
rm_vga_2:
	pushfd
	pushad
	mov eax, [ebp-8]
	mov [0x62200], eax
	mov [0x62204], esp
	mov ax, 0x20
	mov ds, ax
	mov fs, ax
	mov gs, ax
	mov es, ax
	call 0x18:move_to_real
	popad
	popfd
	ret

sd_bt: .byte 0 # shutdown byte
.global pc_shutdown
pc_shutdown:
	cli
	# we have to disable paging to not trigger #GP on leaving PM
	mov eax, cr0
	and eax, 0b01111111111111111111111111111111
	mov cr0, eax
	# we don't care about registers anymore
	movb [sd_bt], 1 # shutdown instead of read_sect
	mov ax, 0x20
	mov ds, ax
	mov fs, ax
	mov gs, ax
	mov es, ax
	call 0x18:move_to_real

# 16-bit protected mode
move_to_real:
	mov ss, ax # <--- segment setup important irregardless of real mode
	mov eax, cr0
	and al, ~1
	mov cr0, eax

.code16
	ljmp 0:real
	.int 0xcccccccc
real:
	mov ax, 0
	mov ds, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov ax, 0x6200
	mov es, ax
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi
	xor ebp, ebp
	mov sp, 0x7c00
	mov bp, 0x7c00
	sgdt es:[0x208] # BIOS may uses PM internally so restore old gdt
	lgdt [numSec]
	lidt ds:[old_idtr]
#	lidt ds:[0x7cfa] # in case the idt setup from RM got messed up
	ljmp 0:r2
	.int 0xcccccccc
r2:
	cmpb [sd_bt], 1
	je rm_shutdown
	cmpb [sd_bt], 2
	jne lend
	sti
	call vga_int10
	cli
	jmp rend
lend:
	cmpb [sd_bt], 3
	jne rdsec
	sti
	call vga_int16
	cli
	jmp rend
rdsec:
	sti
	xor di, di
	mov ax, es:[0x200] # 202 LE/BE
	call read_sect
	cli
rend:
	lgdt es:[0x208]
	lidt ds:[idtr]
	
	mov eax, cr0
	or al, 1
	mov cr0, eax
	jmp 0x08:protected_again

# APM
rm_shutdown:
	xor ax, ax
	mov es, ax
	sti
	mov ah, 0x53
	xor al, al
	xor bx, bx
	int 0x15 # show version
	jc apm_err

	mov ah, 0x53
	mov al, 0x04
	xor bx, bx
	int 0x15 # disconnect
	jnc apm_noerr
	cmp ah, 0x03
	jne apm_err # only error if ah=3

apm_noerr:
	mov ah, 0x53
	mov al, 0x01
	xor bx, bx
	int 0x15 # connect to RM interface
	jc apm_err

	mov ah, 0x53
	mov al, 0x08
	mov bx, 0x0001
	mov cx, 0x0001
	int 0x15 # enable PMgmt on all devices
	jc apm_err2

	mov ah, 0x53
	mov al, 0x07
	mov bx, 0x0001
	mov cx, 0x0003
	int 0x15 # set tate to PowerOff on all devices
	jc apm_err

apm_err2:
	mov ax, 0xb800
	mov es, ax
	mov si, OFFSET apm_str2
	xor di, di
apm_err:
	mov ax, 0xb800
	mov es, ax
	mov si, OFFSET apm_str
	xor di, di
apm_lop:
	lodsb
	test al, al
	jz nope
	stosb
	mov al, 0x0f
	stosb
	jmp apm_lop

apm_str: .asciz "Failed to use APM interface for shutdown"
apm_str2: .asciz "Failed to use APM interface for power management"

.code32
protected_again:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov eax, [0x62204]
	sub eax, 8 # call far -> retf
	mov esp, eax
	retf

# switch back to real mode
# and go to protected mode

.code16
cv: .byte 'A'
infofun:
	xor di, di
	mov cx, 160
	movb al, fs:[cv]
	movb ah, 0x0f
rmv:
	movw es:[di], ax
	add di, 2
	dec cx
	test cx, cx
	jnz rmv
	incb fs:[cv]
	mov ah, 0x86
	mov cx, 42
	int 0x15
	ret

diagfun:
	push es
	# disk get param
	xor ax, ax
	mov es, ax
	mov ah, 0x08
	mov dl, [iBootDrive]
	xor di, di
	int 0x13
	jc rd_nxt #assume floppy
	movb [maxS], cl
	andb [maxS], 0b00111111
	movb [maxH], dh
	xor ah, ah
	mov al, dh
	inc ax
	movw [iHeadCnt], ax
	movb al, [maxS]
	mov [iTrackSect], ax
	pop es
	# print the values
	xor di, di
	movb al, [maxS]
	call prnt_bt
	movb al, [maxH]
	call prnt_bt
	lea bx, restsize
	mov al, bh
	call prnt_bt
	mov al, bl
	call prnt_bt
	push ds
	mov ah, 0x86
	mov cx, 22
	int 0x15
	mov ax, 0x6200
	mov ds, ax
	xor ax, ax
nx:
	xor di, di
	push ax
	push ds
	xor bx, bx
	mov ds, bx
	call read_sect
	pop ds
	xor di, di
#	call memdump #
#	mov ah, 0x86 #
#	mov cx, 2 #
#	int 0x15 #
	pop ax
#	mov bx, ax #
#	mov di, 80*2*23 #
#	shr ax, 8 #
#	call prnt_bt #
#	mov ax, bx #
#	call prnt_bt #
#	push ds #
#	xor ax, ax #
#	mov ds, ax #
#	mov ax, [rs_c] #
#	call prnt_bt #
#	mov ax, [rs_h] #
#	call prnt_bt #
#	mov ax, [rs_s] #
#	call prnt_bt #
#	pop ds #
#	mov ax, bx #
	inc ax
	mov bx, OFFSET basesize
#	inc bx <- test!
	cmp ax, bx
	jle ti
#	cmp ax, 8
#	jl ti
	call move_dat
ti:
#	cmp ax, 0x100
	cmp ax, OFFSET restsize
	jle nx
	pop ds
	ret

ofn: .word 0x8c0 # (endbase / 0x10)  !!!! was 0x8a0
move_dat:
	push ax
	push ds
	push es
	xor si, si
	xor di, di
	mov ds, si
	mov ax, [ofn]
	mov es, ax
	add ax, 0x20
	mov [ofn], ax
	mov ax, 0x6200
	mov ds, ax
	mov cx, 0x200
	cld
	rep ds movsb
	pop es
#	mov di, 80*2*23+20*2 #
#	mov ax, ds:[0] #
#	xor si, si #
#	mov ds, si #
#	call prnt_bt #
	pop ds
	pop ax
	ret

old_idtr: .byte 0, 0, 0, 0, 0, 0
testfun:
#	call infofun

	call diagfun
	#call vga_entry

	# init gdtr structure with offset+size
	cli
	lea eax, gdt
	mov dword ptr[gdtr+2], eax
	mov dword ptr[gdtr2+2], eax
	lea eax, gdt_end-1
	sub eax, OFFSET gdt
	mov word ptr[gdtr], ax
	mov word ptr[gdtr2], ax
	sgdt [numSec]
	sidt ds:[old_idtr]
	lgdt [gdtr]
#	call infofun
	# enable PM
	mov eax, cr0
	or al,1
	mov cr0, eax
	ljmp 0x08,reload_segs
.code32
reload_segs:
	cli
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	# stack grows upwards
	mov esp, 0x00080000
	mov ebp, esp
#	call infofun32
#	call infofun32
	# mask NMI (undone in idt)
	inb al, 0x70
	or al, 0x80
	outb 0x70, al
	call early_entry
#	call infofun32
	call idt_init
#	call infofun32
	sti
#	pushad
.global root_caller
root_caller:
	call kmain
#	popad
nope32:
	jmp nope32

infofun32:
	mov ebx, 0xb8000
	mov ecx, 480
	xor edi, edi
	movb al, [cv]
	movb ah, 0x0f
rmv32:
	movw [ebx+edi], ax
	add edi, 2
	dec ecx
	test ecx, ecx
	jnz rmv32
	incb [cv]
	mov ebx, 1
looe:
	mov ecx, 0xffffffff
loo:
	dec ecx
	test ecx, ecx
	jnz loo
	dec ebx
	test ebx, ebx
	jnz looe
	ret

