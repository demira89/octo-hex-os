# vi:syntax=asmx86
.intel_syntax noprefix
.org 0x0
.code16

.global iBootDrive

.section .bstmstmp, "awx", @progbits
                .word  0
 iBootDrive:    .byte  0
 seconds:       .byte  0
 minutes:       .byte  0
 hours:         .byte  0

.section .bssign, "awx", @progbits
 signature:     .long 0xd3f05f01
 copyProt:      .word  0

.section .parttbl, "awx", @progbits
 p0_flag:       .byte  0x80          # bootable
 p0_chs:        .byte  0, 1, 0       # CHS (0=H, 1:76=S, 1:50=C, 2=S)
 p0_type:       .byte  4             # FAT: (1=12, 4=16<32M, 6=16>32M, 7=NTFS/exFAT, b=32)
 p0_end_chs:    .byte  0, 66, 2      # dummy CHS: 1023,63,254
 p0_lba:        .long  126     # more types: c=32+LBA, e=16XL+LBA, f=extended+LBA
 p0_size:       .long  8192    # 42=LDM, 82=SWAP, 83=Lin, 8e=LVM, EE=Prot.MBR+EFI, EF=EFI FS


.section .bspart1, "awx", @progbits

# This is the GPT MBR w/o a FS (stage 0)

LOAD_SEGMENT=0x7c00

entry:
	# Set up the segment registers
	cld
	mov ax, cs          # CS = 0x0 -> 0x7c00
	mov ds, ax          # DS = CS = 0x0
	mov ss, ax          # SS = CS = 0x0
	mov sp, LOAD_SEGMENT# Stack grows down from offset 0x7C00 toward 0x0000.
	mov ax, 0xb800
	mov es, ax          # ES = 0xb800 = video memory
	movb [iBootDrive], dl

	# set 80x25 text mode so we're in a known state, and to set 8x16 font
	mov ax, 0x0003
	int 0x10

	# enable a20
	mov ax, 0x2401
	int 0x15
	cmp ah, 0x86
	jz error_a20
#	test ah, ah
#	jnz error_a20

	# use es twice <- ES 0xb800 is now on stack
	push es
	# get the memory map and store it at 0x00020000
	mov ax, 0x2000
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

	# Now we want to read the sectors following the MBR
	# i.e. the "early" part

rd_dsk:
	xor ax, ax
	mov es, ax
	# check for LBA (EXT) extensions
	mov ah, 0x41
	mov bx, 0x55aa
	movb dl, [iBootDrive]
	int 0x13
	jc read_chs
	cmp bx, 0xaa55
	jne read_chs
	bt cx, 0 # check interface support bitmap
	jnc read_chs
	jmp read_lba

	# we can use LBA read (multisector)
	# here is the packet
.global LBAOK
.global DAP
.align 4
DAP:
 dapSize:  .byte 0x10
 LBAOK: dapZero:  .byte 0
 dapSecCt: .word 0 # to be initialized
 dapSegOf: .word 0 # Load to 0x07e0:0000
 dapSegBs: .word 0x7e0
 dapLBA64: .quad 1 # LBA1 <- extended BL for now

read_lba:
	# Set the count
	mov ax, OFFSET basesize
	movw [dapSecCt], ax
	# and now issue the call
	mov ah, 0x42
	lea si, dapSize
	mov dl, [iBootDrive]
	int 0x13
	jc read_chs
	movb [LBAOK], 1 # Signal LBA support
	jmp rd_done

# CHS data storage
 maxS:   .byte 18 # Fallback to (likely: numS<18)
 maxH:   .byte 1  # floppy defaults
 numSec: .word 0  # same as dapSecCt
 curSec: .byte 2  # LBA1 <- extended BL for now
 curHed: .byte 0
 curCyl: .byte 0
 curOfs: .word 0x7e0
 retrCt: .byte 0

read_chs:
	# load the (pre-)kernel sections to 0x00007e00-0x00080000 << 1MB
	mov ax, OFFSET basesize
rd_init:
	movw [numSec], ax
	# disk get param (clear es:di)
	xor ax, ax
	mov es, ax
	mov ah, 0x08
	mov dl, [iBootDrive]
	xor di, di
	int 0x13
	jc rd_nxt # on error: assume floppy configuration
	movb [maxS], cl
	andb [maxS], 0b00111111
	movb [maxH], dh
	jmp rd_nxt

# get around the disk signature
.section .bspart2, "awx", @progbits

	# The acutal reading
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
	call prnt_bt # print error code
tieo: # and show it for long
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
	call stage2_entry
nope:
	jmp nope

prnt_bt:
	push bx
	mov bx, ax
	mov ah, 0x0e
	shr al, 4
	call char_trans
	stosw
	mov al, bl
	call char_trans
	stosw
	mov al, ' '
	stosw
	pop bx
	ret
	
char_trans:
	and al, 0x0f
	cmp al, 0x09
	jbe ct_end
	add al, 'a'-'0'-10
ct_end:
	add al, '0'
	ret

mem_err:
	pop es
	lea si, [s_mem]
	xor di, di
	jmp ea_rep
error_a20:
	lea si, [string]
	xor di, di
ea_rep:
	lodsb
	test al, al
	jz nope
	stosb
	mov al, 0x1e
	stosb
	jmp ea_rep

.section .bsdata, "aw", @progbits
string: .asciz "A20"
s_mem:  .asciz "mm"

## .section .rest, "awx", @progbits
## 
## msv: .byte 0
##   memdump:
##   	# dump first 512 bytes at ds to video memory ES=0xb800
##   #	push si
##   #	push di
##   #	push ax
##   #	push bx
##   #	push cx
##   	xor si, si
##   	xor di, di
##   	xor bx, bx
##   	xor cx, cx
##   md_rd: # read data and form string
##   	movb al, ds:[si]
##   	addb cl, al
##   	call prnt_bt
##   	inc si
##   	inc bl
##   	cmp bl, 24
##   	jl md_nxt
##   	mov bl, 80-3*24-3
##   	movb al, cl
##   	call prnt_bt
##   md_spc:
## 	mov ax, 0x0e20
## 	stosw
##   	dec bl
##   	test bl, bl
##   	jnz md_spc
##   	add ch, cl
##   	xor cl, cl
##   md_nxt:
##   	cmp si, 0x200
##   	jl md_rd
##   	mov al, ch
##   	call prnt_bt
##   #	pop cx
##   #	pop bx
##   #	pop ax
##   #	pop di
##   #	pop si
##   	ret

