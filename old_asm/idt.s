.code32
.intel_syntax noprefix
.section .idt, "aw", @progbits
.org 0x0
.global idt
.global idt_end
.global idt_init

.macro IGATE SEL FN TP
.int \FN
.byte 0
.byte \TP
.word \SEL
.endm

.macro IGI NUM
mov edx, \NUM
shl edx, 3
add edx, 2
mov ax, word ptr [edx+idt]
add edx, 4
mov bx, word ptr [edx+idt]
mov word ptr [edx+idt], ax
sub edx, 4
mov word ptr [edx+idt], bx
.endm

.align 16
# Interrupt descriptor table (in .idt section)
# First 32 entries intel-mandated exceptions
# then remapped IRQs from PIC (8+8, ofsM=0x20, ofsS=0x28)
# then software interrupts
# results in 0x180 bytes + software (fits in 0x200 .idt)
# types: e->interrupt f->trap
idt:
IGATE 0x08 gate_0 0x8e
IGATE 0x08 gate_1 0x8e
IGATE 0x08 gate_2 0x8e
IGATE 0x08 gate_3 0x8e
IGATE 0x08 gate_4 0x8e
IGATE 0x08 gate_5 0x8e
IGATE 0x08 gate_6 0x8e
IGATE 0x08 gate_7 0x8e
.global idt_desc_8
idt_desc_8:
IGATE 0x08 gate_8 0x8e
IGATE 0x08 gate_9 0x8e
# Faults with segments error code
IGATE 0x08 gate_10 0x8f
IGATE 0x08 gate_11 0x8f
IGATE 0x08 gate_12 0x8f
IGATE 0x08 gate_13 0x8f
IGATE 0x08 gate_14 0x8e
IGATE 0x08 gate_res 0x8e # Reserved
IGATE 0x08 gate_16 0x8e
IGATE 0x08 gate_17 0x8e
IGATE 0x08 gate_18 0x8e
IGATE 0x08 gate_19 0x8e
IGATE 0x08 gate_20 0x8e
# 21-29 reserved
IGATE 0x08 gate_res 0x8e # 21
IGATE 0x08 gate_res 0x8e # 22
IGATE 0x08 gate_res 0x8e # 23
IGATE 0x08 gate_res 0x8e # 24
IGATE 0x08 gate_res 0x8e # 25
IGATE 0x08 gate_res 0x8e # 26
IGATE 0x08 gate_res 0x8e # 27
IGATE 0x08 gate_res 0x8e # 28
IGATE 0x08 gate_res 0x8e # 29
IGATE 0x08 gate_30 0x8e # security exception
IGATE 0x08 gate_res 0x8e # 31 reserved
# IRQs 0-15 ISA stuff & IOAPIC/LegacyPCI
IGATE 0x08 irq_0 0x8e # timer
IGATE 0x08 irq_1 0x8e # keyboard interrupt
IGATE 0x08 irq_2 0x8e # 
IGATE 0x08 irq_3 0x8e # 
IGATE 0x08 irq_4 0x8e # 
IGATE 0x08 irq_5 0x8e # 
IGATE 0x08 irq_6 0x8e # 
IGATE 0x08 irq_7 0x8e # 
IGATE 0x08 irq_8 0x8e # A
IGATE 0x08 irq_9 0x8e # B
IGATE 0x08 irq_10 0x8e # C
IGATE 0x08 irq_11 0x8e # D
IGATE 0x08 irq_12 0x8e # E
IGATE 0x08 irq_13 0x8e # F
IGATE 0x08 irq_14 0x8e # G
IGATE 0x08 irq_15 0x8e # H
# MSI interrupts (48-55)
IGATE 0x08 msi_0 0x8e
IGATE 0x08 msi_1 0x8e
IGATE 0x08 msi_2 0x8e
IGATE 0x08 msi_3 0x8e
IGATE 0x08 msi_4 0x8e
IGATE 0x08 msi_5 0x8e
IGATE 0x08 msi_6 0x8e
IGATE 0x08 msi_7 0x8e
# Res 56-59 (system calls?)
IGATE 0x08 gate_res 0x8e
IGATE 0x08 gate_res 0x8e
IGATE 0x08 gate_res 0x8e
IGATE 0x08 gate_res 0x8e
# APIC interrupts (60-63)
IGATE 0x08 apic_err 0x8e # APIC error interrupt gate 3c
IGATE 0x08 apic_tmr 0x8e # APIC timer interrupt gate 3d
IGATE 0x08 apic_ipi 0x8e # APIC IPI test interrupt gate 3e
IGATE 0x08 apic_spr 0x8e # APIC spurious interrupt gate (vector 3f for P6)
idt_end:

.section .idtext, "awx", @progbits
.int 0xcccccccc, 0xcccccccc
.align 16
idtr: .word 0
      .int 0
.global idtr
.int 0xcccccccc, 0xcccccccc

.global gate_0
# DIV0 <- cld instruction in all handlers
gate_0:
#	movb [0xb8000], 'a'
	pushad # 8*4 bytes
	push 0x00000000
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret

.global gate_1
# DBG
gate_1:
#	movb [0xb8000], 'b'
	pushad
	mov eax, dr6
	push eax
	push [esp+9*4] # (old or target) eip
	call debug_handler
	add esp, 8
	mov dr6, eax
	popad
	iret

.global pc_reset
pc_reset:
	cli
	jmp g2_reset

.global gate_2
# NMI
gate_2:
#	movb [0xb8000], 'c'
	pushad
	xor eax, eax
	inb al, 0x92
	push eax
	inb al, 0x61
	push eax
	call nmi_handler
	add esp, 8
	test eax, eax
	jz g2_end
g2_reset:
	# reset with PS/2
	mov al, 0x8d
	outb 0x70, al
	inb al, 0x71
	# cli is already done
	mov al, 0x01
	outb 0x92, al
g2_idle: # loop if the reset doesn't work
	jmp g2_idle
g2_end:
	popad
	iret

.global gate_3
# BP
gate_3:
#	movb [0xb8000], 'd'
	pushad # 8*4 bytes
	push 0x00000003
	push [esp+9*4] # next eip
	call print_exception
	add esp, 8
	popad
	iret

.global gate_4
# OF
gate_4:
#	movb [0xb8000], 'e'
	pushad # 8*4 bytes
	push 0x00000004
	push [esp+9*4] # next eip
	call print_exception
	add esp, 8
	popad
	iret

.global gate_5
# BR
gate_5:
#	movb [0xb8000], 'f'
	pushad # 8*4 bytes
	push 0x00000005
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret

.global gate_6
# UD
gate_6:
#	movb [0xb8000], 'g'
	pushad # 8*4 bytes
	push 0x00000006
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret

.global gate_7
# NM
gate_7:
#	movb [0xb8000], 'h'
	pushad # 8*4 bytes
	push 0x00000007
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret

.global gate_8
# DF -- ignore stack errorcode (zero as per intel manual)
gate_8:
#	movb [0xb8000], 'i'
	pushad # 8*4 bytes
	push 0x00000008
	push [esp+9*4] # error code
	call print_exception
	add esp, 8
	popad
	add esp, 4
	iret

.global gate_9
# Legacy
gate_9:
#	movb [0xb8000], 'j'
	pushad # 8*4 bytes
	push 0x00000009
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret

.global gate_10
# Gates 10-14 with segment error codes on stack
gate_10:
#	movb [0xb8000], 'k'
	push 0
	jmp gate_se
.global gate_11
gate_11:
#	movb [0xb8000], 'l'
	push 1
	jmp gate_se
.global gate_12
gate_12:
#	movb [0xb8000], 'm'
	push 2
	jmp gate_se
.global gate_13
gate_13:
#	movb [0xb8000], 'n'
	push 3
	jmp gate_se
.global gate_14
gate_14:
#	movb [0xb8000], 'o'
	push 4
	jmp gate_se
gate_se:
	pushad # 8*4 bytes
	mov eax, [esp+8*4] # type
	push eax
	mov eax, cr2
	push eax
	mov eax, [esp+11*4] # segerr
	push eax
	mov eax, [esp+13*4] # eip
	push eax
	call segment_handler
	add esp, 16
	popad
	add esp, 8 # segerr&code <- correct
	iret
	
.global gate_16
# MF
gate_16:
#	movb [0xb8000], 'p'
	pushad # 8*4 bytes
	push 0x00000010
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret
	
.global gate_17
# AC -- ignore error on stack (zero as per intel manual)
gate_17:
#	movb [0xb8000], 'q'
	pushad # 8*4 bytes
	push 0x00000011
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	add esp, 4
	iret
	
.global gate_18
# MC
gate_18:
#	movb [0xb8000], 'r'
	pushad # 8*4 bytes
	push 0x00000012
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret
	
.global gate_19
# XM/XF
gate_19:
#	movb [0xb8000], 's'
	pushad # 8*4 bytes
	push 0x00000013
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret
	
.global gate_20
# VE
gate_20:
#	movb [0xb8000], 't'
	pushad # 8*4 bytes
	push 0x00000014
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret
	
.global gate_30
# SX -- ignore stack value (exp unknown)
gate_30:
#	movb [0xb8000], 'u'
	pushad # 8*4 bytes
	push 0x0000001e
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	add esp, 4
	iret

.global gate_res
# Reserved gate
gate_res:
#	movb [0xb8000], 'v'
	pushad # 8*4 bytes
	push 0x0000000f
	push [esp+9*4] # old eip
	call print_exception
	add esp, 8
	popad
	iret

.global irq0_longjmp
.global irq_0
irq_0:
#	movb [0xb8000], 'w'
	pushad # 8*4+4*4
	push ds
	push es
	push fs
	push gs
	push esp
	call task_save_state
	push 0
	call irq_handler
	add esp, 8 # old type+esp <- only in case no longjmp
irq0_longjmp:
	pop gs
	pop fs
	pop es
	pop ds
	popad
	iret

.global irq_1
irq_1:
#	movb [0xb8000], 'x'
	push 1
	jmp irq_ahandler

.global irq_2
irq_2:
#	movb [0xb8000], 'y'
	push 2
	jmp irq_ahandler

.global irq_3
irq_3:
#	movb [0xb8000], 'z'
	push 3
	jmp irq_ahandler

.global irq_4
irq_4:
#	movb [0xb8000], '0'
	push 4
	jmp irq_ahandler

.global irq_5
irq_5:
#	movb [0xb8000], '1'
	push 5
	jmp irq_ahandler

.global irq_6
irq_6:
#	movb [0xb8000], '2'
	push 6
	jmp irq_ahandler

.global irq_7
irq_7:
#	movb [0xb8000], '3'
	push 7
	jmp irq_ahandler

.global irq_8
irq_8:
#	movb [0xb8000], '4'
	push 8
	jmp irq_ahandler

.global irq_9
irq_9:
#	movb [0xb8000], '5'
	push 9
	jmp irq_ahandler

.global irq_10
irq_10:
#	movb [0xb8000], '6'
	push 10
	jmp irq_ahandler

.global irq_11
irq_11:
#	movb [0xb8000], '7'
	push 11
	jmp irq_ahandler

.global irq_12
irq_12:
#	movb [0xb8000], '8'
	push 12
	jmp irq_ahandler

.global irq_13
irq_13:
#	movb [0xb8000], '9'
	push 13
	jmp irq_ahandler

.global irq_14
irq_14:
#	movb [0xb8000], '!'
	push 14
	jmp irq_ahandler

.global irq_15
irq_15:
#	movb [0xb8000], '?'
	push 15
	jmp irq_ahandler


# handler for all IRQs
irq_ahandler:
	pushad # 8*4 bytes
	mov eax, [esp+8*4] # type
	push eax
	call irq_handler
	add esp, 4 # type
	popad
	add esp, 4 # old type
	iret

# MSI pre-handlers
.global msi_0
msi_0:
	push 0
	jmp msi_ahandler
.global msi_1
msi_1:
	push 1
	jmp msi_ahandler
.global msi_2
msi_2:
	push 2
	jmp msi_ahandler
.global msi_3
msi_3:
	push 3
	jmp msi_ahandler
.global msi_4
msi_4:
	push 4
	jmp msi_ahandler
.global msi_5
msi_5:
	push 5
	jmp msi_ahandler
.global msi_6
msi_6:
	push 6
	jmp msi_ahandler
.global msi_7
msi_7:
	push 7
	jmp msi_ahandler

# MSI handler
msi_ahandler:
	pushad # 8*4
	mov eax, [esp+8*4] # ype
	push eax
	call msi_handler
	add esp, 4 # type
	popad
	add esp, 4 # old type
	iret

# APIC gates
apic_err:
	push 0
	jmp apic_cmm
#apic_tmr:
#	push 1
#	jmp apic_cmm
apic_ipi:
	push 2
	jmp apic_cmm
apic_spr:
	push 3
apic_cmm:
	pushad
	mov eax, [esp+8*4] # type
	push eax
	call apic_handler
	add esp, 4 # type
	popad
	add esp, 4 # old type
	iret
apic_tmr:
	pushad # 8*4+4*4
	push ds
	push es
	push fs
	push gs
	push esp
	call task_save_state
	push 1
	call apic_handler
	add esp, 8 # old type+esp <- only in case no longjmp
	jmp irq0_longjmp

.global apic_tmr
	

.global idt_init
idt_init:
	push ebp
	mov ebp, esp
	# disable NMI
	inb al, 0x70
	or al, 0x80
	outb 0x70, al

	# now set up the idt
	lea eax, idt
	mov dword ptr[idtr+2], eax
	lea eax, idt_end-1
	sub eax, OFFSET idt
	mov word ptr[idtr], ax
	lidt [idtr]

	mov ecx, ( ( idt_end-idt ) / 8 ) # <- only suse patch
#	mov ecx, 48
idt_i1:
	dec ecx
	IGI ecx
	test ecx, ecx
	jnz idt_i1

	# remap PICs
	pushad
	push 0x28
	push 0x20
	call PIC_remap
	add esp, 8
	popad

	# reenable NMI
	inb al, 0x70
	and al, 0x7f
	outb 0x70, al

###################################
#	# print it
#	pushad
#	mov eax, ((idt_end-idt)/8)
#	push eax
#	mov eax, OFFSET idt
#	push eax
#	call print_idt
#	add esp, 8
#	popad
##################################

	leave
	ret

.section .trampo, "awx", @progbits
#.align 0x1000
# The AP trampoline code for MP init at pseudovector 8 -> 0x8000
.code16
ap_trampoline:
	cli
	cld # get to PM ASAP
	xor ax, ax
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov sp, 0x8200
	movb [ap_start], 1
	# A20 is per processor (package)
	mov ax, 0x2401
	int 0x15
	cmp ah, 0x86
	jz failed
	cmp ah, 0x00
	jnz failed
	# NOW get to PM
	lgdt [gdtr2]
	mov eax, cr0
	or al, 1
	mov cr0, eax
	ljmp 0x08,ap_pm
.code32
.global ap_pm
ap_pm:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov gs, ax
#	mov fs, ax
	mov ss, ax
	mov ax, 0x40
	mov fs, ax
	# get the stack
	mov eax, [ap_stack]
#	mov eax, 0x8200 <- too small printf overwrites IDT
	mov esp, eax
	mov ebp, esp
	# set IDT
	lidt [idtr]
	# now enter the kernel
	call ap_entry
.code16
failed:
	movb [ap_fail], 1
	movb [ap_start], 0
	hlt

ap_start: .byte 0
ap_fail: .byte 0
ap_stack: .int 0
.global ap_start
.global ap_fail
.global ap_stack

