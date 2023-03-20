# vi:syntax=asmx86
.code16
.intel_syntax noprefix
.section .vga, "awx", @progbits
.org 0x0
.global vga_entry

#vga_entry:
#	push ds
#	push es
#	push fs
#	pushad
#	# now most registers are fair game
#
#	# put structures at 0x60000 up to 512 bytes
#	mov ax, 0x6000
#	mov es, ax
#	xor di, di
#	lea si, [vga_sig0]
#	mov cx, 4
#	rep movsb
#	# clear the other 508 bytes
#	mov cx, 508
#	xor al, al
#	rep stosb
#	# get the info structure
#	xor di, di
#	mov ax, 0x4f00
#	int 0x10
#	cmp al, 0x4f
#	jne not_supp
#	test ah, ah
#	jnz not_supp
#	# move the signature into the string
#	mov ax, es
#	mov fs, ax
#	xor ax, ax
#	mov es, ax
#	xor si, si
#	lea di, [vga_sig]
#	add di, 17
#	mov cx, 4
#	rep fs movsb
#	# and print the string
#	mov ax, 0xb800
#	mov es, ax
#	lea si, [vga_sig]
#	movw [msg_dst], 0
#	call msg_fun
#	# put the OEM name
#	lea si, [vga_oem]
#	call msg_fun
#	# from ds:si which is at fs:06
#	movw ax, fs:[8]
#	movw si, fs:[6]
#	push ds
#	mov ds, ax
#	call msg_fun
#	pop ds
#	# print the memory
#	lea si, [vga_mem]
#	mov di, si
#	add di, 30
#	movw bx, fs:[0x12] # mem/64K
#	mov cx, 10
#	std
#vga_div10:
#	xor dx, dx
#	mov ax, bx
#	div cx
#	add dx, '0'
#	mov bx, ax
#	mov al, dl
#	push es
#	xor dx, dx
#	mov es, dx
#	stosb
#	pop es
#	test bx, bx # end if 0
#	jnz vga_div10
#	cld	
#	call msg_fun
#	# check the version
#	movw ax, fs:[0x04]
#	lea si, [vga_102]
#	cmp ax, 0x102
#	je vga_prv
#	lea si, [vga_200]
#	cmp ax, 0x200
#	je vga_prv
#	lea si, [vga_300]
#	cmp ax, 0x300
#	je vga_prv
#	lea si, [vga_unk]
#vga_prv:
#	call msg_fun
#	jmp vga_ver20
#has_20: .byte 0
#is_vga: .byte 1
#has_8b: .byte 0
#has_af: .byte 0
#vga_ver20:
#	cmp ax, 0x200
#	jl vga_cap
#	movb [has_20], 1
#vga_cap:
#	# print the capabilities
#	movw ax, fs:[0x0a]
#	test ax, 1
#	jz vga_cap1
#	lea si, [vga_cap_dac]
#	movb [has_8b], 1
#	call msg_fun
#vga_cap1:
#	test ax, 2
#	jz vga_cap2
#	lea si, [vga_cap_nv]
#	movb [is_vga], 0
#	call msg_fun
#vga_cap2:
#	test ax, 8
#	jz vga_endcap
#	lea si, [vga_cap_af]
#	movb [has_af], 1
#	call msg_fun
#vga_endcap:
#	push es
#	push ds
#	# Now probe the modes
#	movw si, fs:[0x0e]
#vga_rep:
#	movw ax, fs:[0x10]
#	mov ds, ax
#	lodsw
#	cmp ax, 0xffff
#	je vga_done
#	mov cx, ax
#	mov ax, 0x6000
#	mov es, ax
#	mov di, 0x200
#	mov ax, 0x4f01
#	int 0x10
#	test ah, ah
#	jnz vga_int_err
#	mov ax, 0xb800
#	mov es, ax
#	# display the data
#	pop ds
#	xor ax, ax
#	mov ds, ax
#	push si
#	# prepare to append the string
#	movw bx, [msg_dst]
#	lea si, [vga_mod]
#	call msg_fun
#	# now print binary data
#	#shl shr rep nop
#	pop si
##	movw ax, fs:[0x200]
#	push ds
#	jmp vga_rep
#
#vga_int_err:
#	pop ds
#	pop es
#	lea si, [vga_intstr]
#	call msg_fun
#	
#vga_done:
#	pop ds
#	pop es
#
#	
#	# wait for display
#	mov ah, 0x86
#	mov cx, 50
#	int 0x15
#	
#
#vga_ret:
#	popad
#	pop fs
#	pop es
#	pop ds
#	ret

.global vga_es
.global vga_bp
.global vga_ax
.global vga_bx
.global vga_dx
.global vga_di
.global vga_cx
.global vga_rv
.global vga_rv2
.global vga_rv3
.global vga_rv4
vga_es: .word 0
vga_bp: .word 0
vga_ax: .word 0
vga_bx: .word 0
vga_dx: .word 0
vga_di: .word 0
vga_cx: .word 0
vga_rv: .word 0
vga_rv2: .word 0
vga_rv3: .word 0
vga_rv4: .word 0

.global vga_int15
vga_int15:
	sti
	movw cx, [vga_cx]
	movw dx, [vga_dx]
	mov ah, 0x86
	int 0x15
	cli
	jmp rm_done

.global vga_int16
vga_int16:
	sti
	push ax
	movw ax, [vga_ax]
	int 0x16
	movw [vga_rv], ax
	pop ax
	cli
	jmp rm_done

.global vga_int10
vga_int10:
	sti
	push es
	push bp
	movw ax, [vga_es]
	mov es, ax
	movw ax, [vga_ax]
	movw bx, [vga_bx]
	movw dx, [vga_dx]
	movw di, [vga_di]
	movw cx, [vga_cx]
	int 0x10
	movw [vga_rv], ax
	movw [vga_rv2], bx
	movw [vga_rv3], cx
	movw [vga_rv4], dx
	movw [vga_bp], bp
	mov ax, es
	movw [vga_es], ax
	pop bp
	pop es
	cli
	jmp rm_done

#vga_mod: .asciz "The mode bitmap is: "
#vga_intstr:  .asciz "Unable to query mode information"
#vga_cap_dac: .asciz "DAC /w 8-bit mode"
#vga_cap_nv:  .asciz "non-VGA controller"
#vga_cap_af:  .asciz "VBE/AF v1.0P"
#vga_unk: .asciz "VESA Version: other"
#vga_300: .asciz "VESA Version: 3.0"
#vga_200: .asciz "VESA Version: 2.0"
#vga_102: .asciz "VESA Version: 1.2"
#vga_mem: .asciz "Video memory (times 64K):      "
#vga_sig0: .ascii "VBE2"
#vga_oem: .asciz "The name of the OEM is:"
#vga_sig: .asciz "The signature is SIGN"
#vga_err: .asciz "The VESA BIOS extensions used for modesetting are not available."
#not_supp:
#	mov ax, 0xb800
#	mov es, ax
#	lea si, [vga_err]
#	call msg_fun
#	mov ah, 0x86
#	mov cx, 50
#	int 0x15
#	jmp vga_ret

