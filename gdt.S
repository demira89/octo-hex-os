.intel_syntax noprefix
.section .data, "aw", @progbits

.align 16
gdt: .quad 0
#ifdef __x86_64__
#flatcode: .quad 0x00209a0000000000 # 64-bit code
#flatdata: .quad 0x0000920000000000 # 64-bit data
flatcode: .byte 0xff, 0xff, 0, 0, 0, 0b10011011, 0b10101111, 0 #9A->9B (acc), flags 0b1010=a
flatdata: .byte 0xff, 0xff, 0, 0, 0, 0b10010011, 0b11001111, 0 #92->93 (acc), flags 0b1100=c
#else
flatcode: .byte 0xff, 0xff, 0, 0, 0, 0b10011011, 0b11001111, 0 #9A->9B (acc), flags 0b1100=c
flatdata: .byte 0xff, 0xff, 0, 0, 0, 0b10010011, 0b11001111, 0 #92->93 (acc), flags 0b1100=c
#endif
#ifdef __x86_64__ /* no 16-bit */
kernltss: .quad 0, 0 /* 16 byte TSS */
#else
b16tcode: .byte 0xff, 0xff, 0, 0, 0, 0x9a, 0x0f, 0 # 11->32bit 4KB
b16tdata: .byte 0xff, 0xff, 0, 0, 0, 0x92, 0x0f, 0 # 00->16bit 1bt
kernltss: .quad 0
#endif
#ifdef __x86_64__
usercode: .byte 0xff, 0xff, 0, 0, 0, 0b11111010, 0b10101111, 0
userdata: .byte 0xff, 0xff, 0, 0, 0, 0b11110010, 0b11001111, 0
#else
usercode: .byte 0xff, 0xff, 0, 0, 0, 0b11111010, 0b11001111, 0
userdata: .byte 0xff, 0xff, 0, 0, 0, 0b11110010, 0b11001111, 0
#endif
#ifdef __x86_64__
pcp_gdte: .byte 0x08, 0x00, 0, 0, 0, 0b10010000, 0b01000000, 0 # kernel data 38h
intrtss:  .quad 0, 0
#else
# only 4 bytes size limit base will be set dynamically, read-only
pcp_gdte: .byte 0x04, 0x00, 0, 0, 0, 0b10010000, 0b01000000, 0 # kernel data (40h)
intrtss:  .quad 0 # 48h TSS for #SS
#endif
gdt_end:
.global kernltss
.global intrtss
.global gdt

gdtr:	.word gdt_end - gdt - 1
#ifdef __x86_64__
        .quad gdt /* for x86-64 compat */
#else
		.long gdt
#endif
.global gdtr


.section .text, "ax", @progbits
.global gdt_init
gdt_init:
	lgdt [gdtr]
#ifdef __x86_64__
	push 0x08
	lea rax, reload_cs
	push rax
	retfq
#else
	jmp 0x08:reload_cs
#endif
reload_cs:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	ret

