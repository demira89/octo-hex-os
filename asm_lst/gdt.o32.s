
gdt.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <gdt_init>:


.section .text, "ax", @progbits
.global gdt_init
gdt_init:
	lgdt [gdtr]
   0:	0f 01 15 00 00 00 00 	lgdtd  ds:0x0
	push 0x08
	lea rax, reload_cs
	push rax
	retfq
#else
	jmp 0x08:reload_cs
   7:	ea 0e 00 00 00 08 00 	jmp    0x8:0xe

0000000e <reload_cs>:
#endif
reload_cs:
	mov ax, 0x10
   e:	66 b8 10 00          	mov    ax,0x10
	mov ds, ax
  12:	8e d8                	mov    ds,eax
	mov es, ax
  14:	8e c0                	mov    es,eax
	mov fs, ax
  16:	8e e0                	mov    fs,eax
	mov gs, ax
  18:	8e e8                	mov    gs,eax
	mov ss, ax
  1a:	8e d0                	mov    ss,eax
	ret
  1c:	c3                   	ret
