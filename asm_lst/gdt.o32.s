
gdt.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <gdt_init>:


.section .text, "ax", @progbits
.global gdt_init
gdt_init:
	lgdt [gdtr]
   0:	0f 01 15 00 00 00 00 	lgdtd  ds:0x0
	ret
   7:	c3                   	ret
