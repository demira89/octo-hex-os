
gdt.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <gdt_init>:


.section .text, "ax", @progbits
.global gdt_init
gdt_init:
	lgdt [gdtr]
   0:	0f 01 14 25 00 00 00 00 	lgdt   ds:0x0
	ret
   8:	c3                   	ret
