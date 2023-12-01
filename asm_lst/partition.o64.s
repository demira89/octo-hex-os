
partition.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <do_nothing>:
#include "kernel.h"
#include "file.h"
#include "module.h"

void do_nothing()
{
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
		while (1);
   4:	90                   	nop
   5:	eb fd                	jmp    4 <do_nothing+0x4>
