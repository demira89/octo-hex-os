# vi:syntax=asmx86
.intel_syntax noprefix
.org 0x8000
.section .trampo, "awx", @progbits
#.align 0x1000
# The AP trampoline code for MP init at pseudovector 8 -> 0x8000
.code16
base:
ap_trampoline: # is CS:IP=800:0000 or 0:8000?
	cli
	cld # get to PM ASAP
	xor ax, ax
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov sp, 0x6000 # use the page below as stack
	movb cs:[ap_start-base], 1
	# A20 is per processor (package)
	mov ax, 0x2401
	int 0x15
	cmp ah, 0x86
	jz failed
	cmp ah, 0x00
	jnz failed

	# go to PM32 using our small GDT
	lgdt cs:[tmp_gdtr-base]	
	mov eax, cr0
	or al, 1
	mov cr0, eax
	ljmp 0x08,ap_pm-base

.code32
.global ap_pm
ap_pm: # Now we're in 32-bit PM enable PAE/LM if possible
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov gs, ax
	mov fs, ax
	mov ss, ax
	# set the stack
	mov eax, [ap_stack]
	mov esp, eax
	mov ebp, esp
	# switch modes if neccessary
	movb al, [ap_mode]
#ifdef __x86_64__
	test al, 2
	je ap_to_lm
	jmp nope32
#else
	test al, 1
	je ap_enable_pae
	mov eax, 0b10000000 # no PAE & PGE
	jmp ap_32
ap_enable_pae:
	mov eax, 0b10100000 # PAE & PGE
ap_32:
	#set CR4
	mov cr4, eax
	# load CR3
	mov eax, [ap_cr3]
	mov cr3, eax
	# enable paging
	mov eax, cr0
	or eax, 0x80010001 # PG & PM  + BIT16 (WP in ring0)
	mov cr0, eax
	# set IDT & GDT
	lgdt [ap_gdtr]
	lidt [idtr]
	# now enter the kernel
	call ap_entry
#endif
nope32:
	jmp nope32


#ifdef __x86_64__
ap_to_lm:
	mov eax, 0b10100000 # PAE & PGE
	mov cr4, eax
	mov eax, [ap_cr3] # Load cr3_val into cr3 (extend)
	mov cr3, eax

	mov ecx, 0xc0000080 # EFER MSR
	rdmsr

	or eax, 0x00000900 # Set LME+NX
	wrmsr

	mov eax, cr0
	or eax, 0x80010001 # PG & PM  + BIT16 (WP in ring0)
	mov cr0, eax

	# paging is already working -> use ptr
	lgdt [ap_gdtp]
	jmp 0x08:LongMode

.code64
LongMode:
	lidt [idtr]
	call ap_entry
nope64:
	jmp nope64
#endif

.code16
failed:
	movb [ap_fail-base], 1
	movb [ap_start-base], 0
	hlt

ap_start: .byte 0
ap_fail:  .byte 0
ap_mode:  .byte 0 # 1=PAE, 2=LM <- cpuid is ugly
ap_gdtr:  .word 0 # len?
ap_gdtp:  .quad 0 # virt addr
ap_stack: .quad 0 # no vaddr, but easier
#ap_idtr:  .quad 0 # global idtr is still OK
ap_cr3:   .quad 0 # export as uint64_t

.global ap_start, ap_fail, ap_gdtr, ap_stack, ap_idtr, ap_gdtp, ap_cr3, ap_mode

# Small temporary GDT
.align 16
temp_gdt: .quad 0
flatcode: .byte 0xff, 0xff, 0, 0, 0, 0b10011010, 0b11001111, 0
flatdata: .byte 0xff, 0xff, 0, 0, 0, 0b10010010, 0b11001111, 0
tmp_gdtr: .word 23
          .long temp_gdt

