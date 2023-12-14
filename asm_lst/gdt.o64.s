
gdt.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <gdt_init>:


.section .text, "ax", @progbits
.global gdt_init
gdt_init:
	lgdt [gdtr]
   0:	0f 01 14 25 00 00 00 00 	lgdt   ds:0x0
#ifdef __x86_64__
	push 0x08
   8:	6a 08                	push   0x8
	lea rax, reload_cs
   a:	48 8d 04 25 00 00 00 00 	lea    rax,ds:0x0
	push rax
  12:	50                   	push   rax
	retfq
  13:	48 cb                	retfq

0000000000000015 <reload_cs>:
#else
	jmp 0x08:reload_cs
#endif
reload_cs:
	mov ax, 0x10
  15:	66 b8 10 00          	mov    ax,0x10
	mov ds, ax
  19:	8e d8                	mov    ds,eax
	mov es, ax
  1b:	8e c0                	mov    es,eax
	mov fs, ax
  1d:	8e e0                	mov    fs,eax
	mov gs, ax
  1f:	8e e8                	mov    gs,eax
	mov ss, ax
  21:	8e d0                	mov    ss,eax
	ret
  23:	c3                   	ret
