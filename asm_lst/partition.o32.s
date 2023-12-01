
partition.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <do_nothing>:
#include "kernel.h"
#include "file.h"
#include "module.h"

void do_nothing()
{
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
		while (1);
   3:	90                   	nop
   4:	eb fd                	jmp    3 <do_nothing+0x3>
