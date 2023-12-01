# vi:syntax=asmx86
.intel_syntax noprefix
.code32
.global ep32
.global ep36
.global ep64
.global ep_ptr
.global cr3_val

ep_ptr:  .quad 0
cr3_val: .quad 0

ep32:
	mov eax, 0b10000000 # no PAE & PGE
	jmp ep32c
ep36:
	mov eax, 0b10100000 # PAE & PGE

ep32c:
	mov cr4, eax
	mov eax, [cr3_val] # Load cr3_val into cr3
	mov cr3, eax
	mov eax, cr0
	or eax, 0x80010001 # PG & PM  + BIT16 (WP in ring0)
	mov cr0, eax

	mov eax, [ep_ptr]
	
	# realign esp
	mov esp, 0x00080000
	sub esp, 0x8 # _start
	mov ebp, esp

	jmp eax

# as in osdev
ep64:
	mov eax, 0b10100000 # PAE & PGE
	mov cr4, eax
	mov eax, [cr3_val] # Load cr3_val into cr3
	mov cr3, eax

	mov ecx, 0xc0000080 # EFER MSR
	rdmsr

	or eax, 0x00000900 # Set LME+NX
	wrmsr

	mov eax, cr0
	or eax, 0x80010001 # PG & PM  + BIT16 (WP in ring0)
	mov cr0, eax

	lgdt [gdtp]

	# push the address as mixed relocations are iffy
	push [ep_ptr+4]
	push [ep_ptr]
	jmp 0x08:LongMode

.align 8
gdt:
 g0: .quad 0
 gc: .quad 0x00209a0000000000 # 64-bit code
 gd: .quad 0x0000920000000000 # 64-bit data
gdte:

.align 4
gdtp:
 ps: .word gdte - gdt - 1
 pt: .long gdt, 0

.code64
LongMode:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	# blank screen
	mov edi, 0xb8000
	mov rcx, 500
	mov rax, 0x1f201f201f201f20
	rep stosq

	pop rax

	# realign stack
	mov rsp, 0x00080000
	sub rsp, 0x8
	mov rbp, rsp

	jmp rax

nope64:
	jmp nope64


