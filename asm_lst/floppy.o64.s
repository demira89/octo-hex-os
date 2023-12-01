
floppy.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <module_init>:
#include "kernel.h"
#include "module.h"


int MODENTRY module_init()
{
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
		printf("floppy.ko says hello\n");
   4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
   b:	b8 00 00 00 00       	mov    eax,0x0
  10:	e8 00 00 00 00       	call   15 <module_init+0x15>
		return 0;
  15:	b8 00 00 00 00       	mov    eax,0x0
}
  1a:	5d                   	pop    rbp
  1b:	c3                   	ret

000000000000001c <module_cleanup>:

void MODENTRY module_cleanup()
{
  1c:	55                   	push   rbp
  1d:	48 89 e5             	mov    rbp,rsp
		printf("goodbye floppy.ko\n");
  20:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  27:	b8 00 00 00 00       	mov    eax,0x0
  2c:	e8 00 00 00 00       	call   31 <module_cleanup+0x15>
}
  31:	90                   	nop
  32:	5d                   	pop    rbp
  33:	c3                   	ret
