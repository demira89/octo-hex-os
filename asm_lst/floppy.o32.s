
floppy.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <module_init>:
#include "kernel.h"
#include "module.h"


int MODENTRY module_init()
{
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 18             	sub    esp,0x18
		printf("floppy.ko says hello\n");
   6:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
   d:	e8 fc ff ff ff       	call   e <module_init+0xe>
		return 0;
  12:	b8 00 00 00 00       	mov    eax,0x0
}
  17:	c9                   	leave
  18:	c3                   	ret

00000019 <module_cleanup>:

void MODENTRY module_cleanup()
{
  19:	55                   	push   ebp
  1a:	89 e5                	mov    ebp,esp
  1c:	83 ec 18             	sub    esp,0x18
		printf("goodbye floppy.ko\n");
  1f:	c7 04 24 16 00 00 00 	mov    DWORD PTR [esp],0x16
  26:	e8 fc ff ff ff       	call   27 <module_cleanup+0xe>
}
  2b:	90                   	nop
  2c:	c9                   	leave
  2d:	c3                   	ret
