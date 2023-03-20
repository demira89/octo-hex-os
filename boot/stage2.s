# vi:syntax=asmx86
.intel_syntax noprefix
.code16

# Initial GDT (temporary)
gdt:      .quad 0
flatcode: .byte 0xff, 0xff, 0, 0, 0, 0b10011010, 0b11001111, 0
flatdata: .byte 0xff, 0xff, 0, 0, 0, 0b10010010, 0b11001111, 0
b16tcode: .byte 0xff, 0xff, 0, 0, 0, 0x9a, 0x0f, 0 # 11->32bit 4KB (for PM16)
b16tdata: .byte 0xff, 0xff, 0, 0, 0, 0x92, 0x0f, 0 # 00->16bit 1bt (->BIOS)
gdt_end:  .quad 0xcccccccccccccccc
gdts:     .word 0
gdtp:     .long 0

# storage location of BIOS PM config
gdt_save: .word 0, 0, 0
idt_save: .word 0, 0, 0
null_idtr:.word 0
          .long 0

.global stage2_entry
stage2_entry:
	# we're using PM w/o an IDT (prevent INTRS)
	cli
 	# mask NMI (undone after IDT setup)
 	inb al, 0x70
 	or al, 0x80
 	outb 0x70, al

 	lea eax, gdt
 	mov DWORD PTR[gdtp], eax
 	lea eax, gdt_end-1
 	sub eax, OFFSET gdt
 	movw [gdts], ax
	# store the GDT of the BIOS (if there)
 	sgdt ds:[gdt_save] # why explicit ds?
 	sidt ds:[idt_save]
 	lgdt [gdts]
	lidt [null_idtr]

 	# enable PM
 	mov eax, cr0
 	or al,1
 	mov cr0, eax
 	ljmp 0x08,reload_segs
 .code32
 reload_segs:
 	mov ax, 0x10
 	mov ds, ax
 	mov es, ax
 	mov fs, ax
 	mov gs, ax
 	mov ss, ax
 	# stack grows upwards
 	mov esp, 0x00080000
 	mov ebp, esp
 	call base_entry

nope32:
	jmp nope32


# BIOS read sector API
sd_bt: .byte 0
.global rm_read_sector
rm_read_sector:
	movb [sd_bt], 0 # rm_read
	jmp rm_vga_2

.global rm_int15
rm_int15:
	movb [sd_bt], 4 # int15
	jmp rm_vga_2

.global rm_int16
rm_int16:
	movb [sd_bt], 3 # int16
	jmp rm_vga_2

.global rm_vga_int10
rm_vga_int10:
	movb [sd_bt], 2 # vga instead of read_sect
rm_vga_2:
	pushfd # 4+4(ret)
	pushad # 8*4
	mov eax, [esp+40]
	mov [DAP+12], eax # LBA high (%2)
	mov eax, [esp+44]
	mov [DAP+8], eax # LBA low (%1)
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

# 32-bit PM
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

# 16-bit protected mode
move_to_real:
	mov ss, ax # <--- segment setup important irregardless of real mode
	mov eax, cr0
	and al, ~1
	mov cr0, eax # now PM is off

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
	sgdt es:[0x208] # BIOS may uses PM internally so save PM gdt
	lgdt ds:[gdt_save]   # and load BIOS GDT
	lidt ds:[idt_save]
	ljmp 0:r2
.int 0xcccccccc

# pure real mode is now active
r2:
	# do something
	cmpb [sd_bt], 0
	je read_sector_lba
#	cmpb [sd_bt], 1
#	je shutdown
	cmpb [sd_bt], 2
	je vga_int10
	cmpb [sd_bt], 3
	je vga_int16
	cmpb [sd_bt], 4
	je vga_int15

.global rm_done
rm_done:
	lgdt es:[0x208]
	lidt ds:[null_idtr] # <- we don't have a IDT here
	
	mov eax, cr0
	or al, 1
	mov cr0, eax
	jmp 0x08:protected_again

# now read a single sector
lba_ok: .byte 0
read_sector_lba:
	sti
	cmpb [lba_ok], 0
	jne rsl_next
	# load the value of LBAOK
	movb al, [LBAOK]
	incb al
	movb [lba_ok], al
	movb [LBAOK], 0 # 0 in DAP
rsl_next:
	# Test for LBA DAP support
	cmpb [lba_ok], 1
	je rsl_no_lba
rsl_lba:
	# we have LBA64 BIOS /w DAP
	push es
	xor ax, ax
	mov es, ax # for es:di
	# Set the sector count
	mov ax, 1
	movw [DAP+2], ax
	# and the address (6200:0000=0x62000)
	xor ax, ax
	movw [DAP+4], ax
	mov ax, 0x6200
	movw [DAP+6], ax
	# LBA low & high already stored

	# and now issue the call
	mov ah, 0x42
	lea si, DAP
	movb dl, [iBootDrive] # byte ptr
	int 0x13
	
	# check for errors
	pop es
	jc rsl_no_lba
	jmp rsl_done

rsl_no_lba:
	# we have to use CHS
	call rsl_lba28

rsl_done:
	cli
	jmp rm_done

 iSPT: .word 18
 iHCT: .word 1
 iRDV: .byte 0
rsl_lba28:
	push es
	# check for params
	cmpb [iRDV], 0
	jg read28

get_params:
	xor ax, ax
	mov es, ax
	mov ah, 0x08
	mov dl, [iBootDrive]
	xor di, di
	int 0x13
	jc read28 # on error: assume floppy configuration and try next time
	and cx, 0x003f # 6 lower bits
	movw [iSPT], cx
	movzx ax, dh
	inc ax
	movw [iHCT], ax
	movb [iRDV], 1
	jmp read28

read28:
	movw ax, [DAP+8] # LBA28->CHS
	movw dx, [DAP+10]# dx:ax number
	xor di, di
	call read_sect
	pop es
	jmp rsl_done

#### # BIOS real mode I/O available after loading rest
#### .section .bsrmio, "awx", @progbits
#### .align 16
#### gdt: .quad 0
#### flatcode: .byte 0xff, 0xff, 0, 0, 0, 0b10011010, 0b11001111, 0
#### flatdata: .byte 0xff, 0xff, 0, 0, 0, 0b10010010, 0b11001111, 0
#### b16tcode: .byte 0xff, 0xff, 0, 0, 0, 0x9a, 0x0f, 0 # 11->32bit 4KB
#### b16tdata: .byte 0xff, 0xff, 0, 0, 0, 0x92, 0x0f, 0 # 00->16bit 1bt
#### kernltss: .quad 0
#### usercode: .byte 0xff, 0xff, 0, 0, 0, 0b11111010, 0b11001111, 0
#### userdata: .byte 0xff, 0xff, 0, 0, 0, 0b11110010, 0b11001111, 0
#### # only 4 bytes size limit base will be set dynamically, read-only
#### pcp_gdte: .byte 0x04, 0x00, 0, 0, 0, 0b10010000, 0b01000000, 0 # kernel data (40h)
#### intrtss:  .quad 0 # 48h TSS for #SS
#### gdt_end:
#### .global kernltss
#### .global intrtss
#### 
#### nopfun:
#### 	jmp nf_rd
#### 	# check for LBA access
#### #	mov dl, [iBootDrive]
#### #	mov ah, 0x41
#### #	mov bx, 0x55aa
#### #	int 0x13
#### #	jc no_lba
#### #	cmp bx, 0xaa55
#### #	je lba_ok
#### #no_lba:
#### #	lea si, [lba_err]
#### #	call msg_fun
#### #	jmp nf_rd
#### #
#### #lba_ok:
#### #	lea si, [lba_noerr]
#### #	call msg_fun
#### nf_iLBA: .word 0
#### nf_iSec: .word 0
#### nf_iOfs: .word 0
#### 
#### nf_rd:
#### 	lea si, [nf_fat16]
#### 	call msg_fun
#### 
#### 	# NOW find the file pci.ko in the root directory
#### 	# rootOfs=(base+resSec)+n_fat*fatSec
#### 	# maxSec: 16xxx <= 16bit
#### 	movw cx, [iResSect]
#### 	movw ax, [iFatSize]
#### 	xor bh, bh
#### 	movb bl, [iFatCnt]
#### 	mul bx
#### 	add ax, cx
#### 	# result in dx:ax (guranteed 16 bits -> discard dx)
#### 	movw [nf_iLBA], ax
#### 	# calculate the sector count of root directory
#### 	movw ax, [iRootSize]
#### 	mov bx, 32
#### 	mul bx
#### 	# dx:ax has byte ct
#### 	mov bx, [iSectSize]
#### 	div bx
#### 	# quot in ax, rem in dx
#### 	test dx, dx
#### 	jz nf_p1
#### 	inc ax
#### nf_p1:
#### 	movw [nf_iSec], ax
#### 	
#### nf_p2:
#### 	movw ax, [nf_iLBA]
#### 	mov di, [nf_iOfs]
#### 	call read_sect
#### 	incw [nf_iLBA]
#### 	addw [nf_iOfs], 0x200
#### 	decw [nf_iSec]
#### 	movw ax, [nf_iSec]
#### 	test ax, ax
#### 	jnz nf_p2
#### 	lea si, [msg_drt]
#### 	call msg_fun
#### 
#### 	# now print all the filenames
#### 	# table is in memory therefore modifiable
#### 	movw cx, [iRootSize]
#### 	push ds
#### 	mov ax, 0x6200
#### 	mov ds, ax
#### 	xor si, si
#### 
#### prnt_lp:
#### 	mov di, si
#### 	add di, 0x0b
#### 	movb ds:[di], 0x00
#### 	push si
#### 	call msg_fun
#### 	pop si
#### 	# now do strcmp with fn_pci
#### 	
#### 	add si, 32
#### 	movb al, ds:[si]
#### 	test al, al
#### 	jnz prnt_lp
#### 	pop ds
#### 
#### 	jmp nope
#### 	nop
#### 	ret
####

# in: dx:ax, di
read_sect:
	push es
	push bx
	push cx
	push dx
	push ax # b,c,d,a
	mov bx, 0x6200
	mov es, bx
	jmp rs_cnt
retrCt: .byte 0
rs_c: .word 0
rs_h: .word 0
rs_s: .word 0
	# convert 28-bit LBA to CHS iHeadCnt iTrackSect
	# C=LBA/(HC*SPT)
	# H=LBA/SPT % HC
	# S=(LBA % SPT) + 1
rs_cnt:
	movb [retrCt], 0
rs_rtr:
	movw ax, [iHCT]
	movw bx, [iSPT]
	mul bx # -> to dx:ax
	test dx, dx
	jnz err_siz
	mov bx, ax # bx is (HC*SPT)
	pop ax
	pop dx
	push dx
	push ax # dx:ax is LBA
	div bx # LBA/(HC*SPT)
	# ax is C -> done
	movw [rs_c], ax
	pop ax
	pop dx
	push dx
	push ax # ds:ax is LBA
	movw bx, [iSPT]
	div bx
	# ax is LBA/SPT, dx is LBA%SPT
	inc dx
	movw [rs_s], dx # S -> done
	xor dx, dx # 0:ax
	mov bx, [iHCT]
	div bx # H -> done
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
	jmp err_siz
#### 
#### err_siz:
#### 	add sp, 8
#### 	pop es
#### 	lea si, [msg_siz]
#### 	call msg_fun
#### 	jmp nope
#### 
#### .global msg_fun
#### msg_fun: # ds:si -> es:(msg_dst)
#### 	movw di, cs:[msg_dst]
#### msg_nxt:
#### 	lodsb
#### 	test al, al
#### 	jz msg_done
#### 	stosb
#### 	mov al, 0x0f
#### 	stosb
#### 	jmp msg_nxt
#### 
#### msg_done:
#### 	# prepare offset for next line
#### 	mov ax, di
#### 	mov cl, 160
#### 	div cl
#### 	test ah, ah
#### 	jz msg_upd
#### 	mov cx, 160
#### 	shr ax, 8
#### 	sub cx, ax
#### 	add di, cx
#### msg_upd:
#### 	movw cs:[msg_dst], di
#### 	# wait 2 seconds
#### 	mov ah, 0x86
#### 	mov cx, 0x1e
#### 	mov dx, 0x8480
#### 	int 0x15
#### 	# and return to caller
#### 	ret
#### 
#### #lba_err: .asciz "No LBA BIOS extenstions present. Only limited early disk access."
#### #lba_noerr: .asciz "BIOS LBA extension present."
#### .global msg_dst
#### msg_dst: .word 0
#### nf_fat16: .asciz "parsing FAT16 formatted disk..."
#### msg_siz: .asciz "HC*SPT larger than 16 bits"
#### msg_drt: .asciz "done reading FAT16 root directory"
#### fn_pci: .asciz "pci     ko "
#### 
#### .code32
#### .global to_usermode
#### to_usermode:
#### 	cli
#### ot:
#### jmp ot
#### 	mov ax, (7*8|3) # RPL=3
#### 	mov ds, ax
#### 	mov es, ax
#### 	mov fs, ax
#### 	mov gs, ax
#### 	push (7*8|3) # RPL=3
#### 	mov eax, esp
#### 	push eax # continue on kernel stack (hack)
#### 	pushf
#### 	or dword ptr[esp], 0x00000200
#### 	push (6*8|3) # RPL=3
#### 	push OFFSET usermode_entry
#### 	iretd
#### 
#### rm_read_sector:
#### 	movb [sd_bt], 0 # rm_read
#### 	jmp rm_vga_2
#### 
#### .global rm_int16
#### rm_int16:
#### 	movb [sd_bt], 3 # int16
#### 	jmp rm_vga_2
#### 
#### .global rm_vga_int10
#### rm_vga_int10:
#### 	movb [sd_bt], 2 # vga instead of read_sect
#### rm_vga_2:
#### 	pushfd
#### 	pushad
#### 	mov eax, [ebp-8]
#### 	mov [0x62200], eax
#### 	mov [0x62204], esp
#### 	mov ax, 0x20
#### 	mov ds, ax
#### 	mov fs, ax
#### 	mov gs, ax
#### 	mov es, ax
#### 	call 0x18:move_to_real
#### 	popad
#### 	popfd
#### 	ret
#### 
#### sd_bt: .byte 0 # shutdown byte
#### .global pc_shutdown
#### pc_shutdown:
#### 	cli
#### 	# we have to disable paging to not trigger #GP on leaving PM
#### 	mov eax, cr0
#### 	and eax, 0b01111111111111111111111111111111
#### 	mov cr0, eax
#### 	# we don't care about registers anymore
#### 	movb [sd_bt], 1 # shutdown instead of read_sect
#### 	mov ax, 0x20
#### 	mov ds, ax
#### 	mov fs, ax
#### 	mov gs, ax
#### 	mov es, ax
#### 	call 0x18:move_to_real
#### 
#### # 16-bit protected mode
#### move_to_real:
#### 	mov ss, ax # <--- segment setup important irregardless of real mode
#### 	mov eax, cr0
#### 	and al, ~1
#### 	mov cr0, eax
#### 
#### .code16
#### 	ljmp 0:real
#### 	.int 0xcccccccc
#### real:
#### 	mov ax, 0
#### 	mov ds, ax
#### 	mov fs, ax
#### 	mov gs, ax
#### 	mov ss, ax
#### 	mov ax, 0x6200
#### 	mov es, ax
#### 	xor eax, eax
#### 	xor ebx, ebx
#### 	xor ecx, ecx
#### 	xor edx, edx
#### 	xor esi, esi
#### 	xor ebp, ebp
#### 	mov sp, 0x7c00
#### 	mov bp, 0x7c00
#### 	sgdt es:[0x208] # BIOS may uses PM internally so restore old gdt
#### 	lgdt [numSec]
#### 	lidt ds:[old_idtr]
#### #	lidt ds:[0x7cfa] # in case the idt setup from RM got messed up
#### 	ljmp 0:r2
#### 	.int 0xcccccccc
#### r2:
#### 	cmpb [sd_bt], 1
#### 	je rm_shutdown
#### 	cmpb [sd_bt], 2
#### 	jne lend
#### 	sti
#### 	call vga_int10
#### 	cli
#### 	jmp rend
#### lend:
#### 	cmpb [sd_bt], 3
#### 	jne rdsec
#### 	sti
#### 	call vga_int16
#### 	cli
#### 	jmp rend
#### rdsec:
#### 	sti
#### 	xor di, di
#### 	mov ax, es:[0x200] # 202 LE/BE
#### 	call read_sect
#### 	cli
#### rend:
#### 	lgdt es:[0x208]
#### 	lidt ds:[idtr]
#### 	
#### 	mov eax, cr0
#### 	or al, 1
#### 	mov cr0, eax
#### 	jmp 0x08:protected_again
#### 
#### # APM
#### rm_shutdown:
#### 	xor ax, ax
#### 	mov es, ax
#### 	sti
#### 	mov ah, 0x53
#### 	xor al, al
#### 	xor bx, bx
#### 	int 0x15 # show version
#### 	jc apm_err
#### 
#### 	mov ah, 0x53
#### 	mov al, 0x04
#### 	xor bx, bx
#### 	int 0x15 # disconnect
#### 	jnc apm_noerr
#### 	cmp ah, 0x03
#### 	jne apm_err # only error if ah=3
#### 
#### apm_noerr:
#### 	mov ah, 0x53
#### 	mov al, 0x01
#### 	xor bx, bx
#### 	int 0x15 # connect to RM interface
#### 	jc apm_err
#### 
#### 	mov ah, 0x53
#### 	mov al, 0x08
#### 	mov bx, 0x0001
#### 	mov cx, 0x0001
#### 	int 0x15 # enable PMgmt on all devices
#### 	jc apm_err2
#### 
#### 	mov ah, 0x53
#### 	mov al, 0x07
#### 	mov bx, 0x0001
#### 	mov cx, 0x0003
#### 	int 0x15 # set tate to PowerOff on all devices
#### 	jc apm_err
#### 
#### apm_err2:
#### 	mov ax, 0xb800
#### 	mov es, ax
#### 	mov si, OFFSET apm_str2
#### 	xor di, di
#### apm_err:
#### 	mov ax, 0xb800
#### 	mov es, ax
#### 	mov si, OFFSET apm_str
#### 	xor di, di
#### apm_lop:
#### 	lodsb
#### 	test al, al
#### 	jz nope
#### 	stosb
#### 	mov al, 0x0f
#### 	stosb
#### 	jmp apm_lop
#### 
#### apm_str: .asciz "Failed to use APM interface for shutdown"
#### apm_str2: .asciz "Failed to use APM interface for power management"
#### 
#### .code32
#### protected_again:
#### 	mov ax, 0x10
#### 	mov ds, ax
#### 	mov es, ax
#### 	mov fs, ax
#### 	mov gs, ax
#### 	mov ss, ax
#### 	mov eax, [0x62204]
#### 	sub eax, 8 # call far -> retf
#### 	mov esp, eax
#### 	retf
#### 
#### # switch back to real mode
#### # and go to protected mode
#### 
#### .code16
#### cv: .byte 'A'
#### infofun:
#### 	xor di, di
#### 	mov cx, 160
#### 	movb al, fs:[cv]
#### 	movb ah, 0x0f
#### rmv:
#### 	movw es:[di], ax
#### 	add di, 2
#### 	dec cx
#### 	test cx, cx
#### 	jnz rmv
#### 	incb fs:[cv]
#### 	mov ah, 0x86
#### 	mov cx, 42
#### 	int 0x15
#### 	ret
#### 
#### diagfun:
#### 	push es
#### 	# disk get param
#### 	xor ax, ax
#### 	mov es, ax
#### 	mov ah, 0x08
#### 	mov dl, [iBootDrive]
#### 	xor di, di
#### 	int 0x13
#### 	jc rd_nxt #assume floppy
#### 	movb [maxS], cl
#### 	andb [maxS], 0b00111111
#### 	movb [maxH], dh
#### 	xor ah, ah
#### 	mov al, dh
#### 	inc ax
#### 	movw [iHeadCnt], ax
#### 	movb al, [maxS]
#### 	mov [iTrackSect], ax
#### 	pop es
#### 	# print the values
#### 	xor di, di
#### 	movb al, [maxS]
#### 	call prnt_bt
#### 	movb al, [maxH]
#### 	call prnt_bt
#### 	lea bx, restsize
#### 	mov al, bh
#### 	call prnt_bt
#### 	mov al, bl
#### 	call prnt_bt
#### 	push ds
#### 	mov ah, 0x86
#### 	mov cx, 22
#### 	int 0x15
#### 	mov ax, 0x6200
#### 	mov ds, ax
#### 	xor ax, ax
#### nx:
#### 	xor di, di
#### 	push ax
#### 	push ds
#### 	xor bx, bx
#### 	mov ds, bx
#### 	call read_sect
#### 	pop ds
#### 	xor di, di
#### #	call memdump #
#### #	mov ah, 0x86 #
#### #	mov cx, 2 #
#### #	int 0x15 #
#### 	pop ax
#### #	mov bx, ax #
#### #	mov di, 80*2*23 #
#### #	shr ax, 8 #
#### #	call prnt_bt #
#### #	mov ax, bx #
#### #	call prnt_bt #
#### #	push ds #
#### #	xor ax, ax #
#### #	mov ds, ax #
#### #	mov ax, [rs_c] #
#### #	call prnt_bt #
#### #	mov ax, [rs_h] #
#### #	call prnt_bt #
#### #	mov ax, [rs_s] #
#### #	call prnt_bt #
#### #	pop ds #
#### #	mov ax, bx #
#### 	inc ax
#### 	mov bx, OFFSET basesize
#### #	inc bx <- test!
#### 	cmp ax, bx
#### 	jle ti
#### #	cmp ax, 8
#### #	jl ti
#### 	call move_dat
#### ti:
#### #	cmp ax, 0x100
#### 	cmp ax, OFFSET restsize
#### 	jle nx
#### 	pop ds
#### 	ret
#### 
#### ofn: .word 0x8c0 # (endbase / 0x10)  !!!! was 0x8a0
#### move_dat:
#### 	push ax
#### 	push ds
#### 	push es
#### 	xor si, si
#### 	xor di, di
#### 	mov ds, si
#### 	mov ax, [ofn]
#### 	mov es, ax
#### 	add ax, 0x20
#### 	mov [ofn], ax
#### 	mov ax, 0x6200
#### 	mov ds, ax
#### 	mov cx, 0x200
#### 	cld
#### 	rep ds movsb
#### 	pop es
#### #	mov di, 80*2*23+20*2 #
#### #	mov ax, ds:[0] #
#### #	xor si, si #
#### #	mov ds, si #
#### #	call prnt_bt #
#### 	pop ds
#### 	pop ax
#### 	ret
#### 
#### old_idtr: .byte 0, 0, 0, 0, 0, 0
#### testfun:
#### #	call infofun
#### 
#### 	call diagfun
#### 	#call vga_entry
#### 
#### 	# init gdtr structure with offset+size
#### 	cli
#### 	lea eax, gdt
#### 	mov dword ptr[gdtr+2], eax
#### 	mov dword ptr[gdtr2+2], eax
#### 	lea eax, gdt_end-1
#### 	sub eax, OFFSET gdt
#### 	mov word ptr[gdtr], ax
#### 	mov word ptr[gdtr2], ax
#### 	sgdt [numSec]
#### 	sidt ds:[old_idtr]
#### 	lgdt [gdtr]
#### #	call infofun
#### 	# enable PM
#### 	mov eax, cr0
#### 	or al,1
#### 	mov cr0, eax
#### 	ljmp 0x08,reload_segs
#### .code32
#### reload_segs:
#### 	cli
#### 	mov ax, 0x10
#### 	mov ds, ax
#### 	mov es, ax
#### 	mov fs, ax
#### 	mov gs, ax
#### 	mov ss, ax
#### 	# stack grows upwards
#### 	mov esp, 0x00080000
#### 	mov ebp, esp
#### #	call infofun32
#### #	call infofun32
#### 	# mask NMI (undone in idt)
#### 	inb al, 0x70
#### 	or al, 0x80
#### 	outb 0x70, al
#### 	call early_entry
#### #	call infofun32
#### 	call idt_init
#### #	call infofun32
#### 	sti
#### #	pushad
#### .global root_caller
#### root_caller:
#### 	call kmain
#### #	popad
#### nope32:
#### 	jmp nope32
#### 
#### infofun32:
#### 	mov ebx, 0xb8000
#### 	mov ecx, 480
#### 	xor edi, edi
#### 	movb al, [cv]
#### 	movb ah, 0x0f
#### rmv32:
#### 	movw [ebx+edi], ax
#### 	add edi, 2
#### 	dec ecx
#### 	test ecx, ecx
#### 	jnz rmv32
#### 	incb [cv]
#### 	mov ebx, 1
#### looe:
#### 	mov ecx, 0xffffffff
#### loo:
#### 	dec ecx
#### 	test ecx, ecx
#### 	jnz loo
#### 	dec ebx
#### 	test ebx, ebx
#### 	jnz looe
#### 	ret
#### 
