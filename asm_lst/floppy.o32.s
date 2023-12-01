
floppy.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <module_init>:
#include "kernel.h"
#include "module.h"


int MODENTRY module_init()
{
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 08             	sub    esp,0x8
		printf("floppy.ko says hello\n");
   6:	83 ec 0c             	sub    esp,0xc
   9:	68 00 00 00 00       	push   0x0
   e:	e8 fc ff ff ff       	call   f <module_init+0xf>
  13:	83 c4 10             	add    esp,0x10
		return 0;
  16:	b8 00 00 00 00       	mov    eax,0x0
}
  1b:	c9                   	leave
  1c:	c3                   	ret

0000001d <module_cleanup>:

void MODENTRY module_cleanup()
{
  1d:	55                   	push   ebp
  1e:	89 e5                	mov    ebp,esp
  20:	83 ec 08             	sub    esp,0x8
		printf("goodbye floppy.ko\n");
  23:	83 ec 0c             	sub    esp,0xc
  26:	68 16 00 00 00       	push   0x16
  2b:	e8 fc ff ff ff       	call   2c <module_cleanup+0xf>
  30:	83 c4 10             	add    esp,0x10
}
  33:	90                   	nop
  34:	c9                   	leave
  35:	c3                   	ret
