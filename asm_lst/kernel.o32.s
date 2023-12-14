
kernel.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
}

/**************** COM routines to be moved into module *******************/
static int com_present = 0;
static uint16_t com_ports[4] = {0};
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
static uint16_t def_port = 0;

void enable_com(int num, uint16_t port)
{
		if (!com_present) {
       6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
       c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				com_present = 1;
				def_port = port;
       f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
				irq_unmask(3);
      12:	c9                   	leave
      13:	c3                   	ret

00000014 <io_wait>:

void putDebugChar(char c)
{
		while (!is_transit_empty(def_port));
		outb(def_port, c);
}
      14:	55                   	push   ebp
      15:	89 e5                	mov    ebp,esp

      17:	b8 00 00 00 00       	mov    eax,0x0
      1c:	e6 80                	out    0x80,al
int serial_received(uint16_t port)
      1e:	90                   	nop
      1f:	5d                   	pop    ebp
      20:	c3                   	ret

00000021 <outb>:
{
		return inb(port + 5) & 1;
}
      21:	55                   	push   ebp
      22:	89 e5                	mov    ebp,esp
      24:	83 ec 08             	sub    esp,0x8
      27:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      2a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      2d:	66 89 55 fc          	mov    WORD PTR [ebp-0x4],dx
      31:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al

      34:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
      38:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      3c:	ee                   	out    dx,al
char getDebugChar()
      3d:	90                   	nop
      3e:	c9                   	leave
      3f:	c3                   	ret

00000040 <inb>:
{
		while (!serial_received(def_port));
		return inb(def_port);
      40:	55                   	push   ebp
      41:	89 e5                	mov    ebp,esp
      43:	83 ec 14             	sub    esp,0x14
      46:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      49:	66 89 45 ec          	mov    WORD PTR [ebp-0x14],ax
}

      4d:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
      51:	89 c2                	mov    edx,eax
      53:	ec                   	in     al,dx
      54:	88 45 ff             	mov    BYTE PTR [ebp-0x1],al
/*************************************************************************/
      57:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
struct irqe {
      5b:	c9                   	leave
      5c:	c3                   	ret

0000005d <memcpy>:
		struct irqe* p = kmalloc(sizeof(*p));
		if (!p)
				return 0;
		p->fun = fun;
		/* unmask first */
		if (!irq_funs[irq - 1])
      5d:	55                   	push   ebp
      5e:	89 e5                	mov    ebp,esp
      60:	83 ec 10             	sub    esp,0x10
				irq_unmask(irq);
      63:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      66:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		do {
      69:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      6c:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
				p->next = irq_funs[irq - 1];
      6f:	eb 17                	jmp    88 <memcpy+0x2b>
		} while (!__sync_bool_compare_and_swap(&irq_funs[irq - 1], p->next, p));
      71:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      74:	8d 42 01             	lea    eax,[edx+0x1]
      77:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      7a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      7d:	8d 48 01             	lea    ecx,[eax+0x1]
      80:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      83:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      86:	88 10                	mov    BYTE PTR [eax],dl
				p->next = irq_funs[irq - 1];
      88:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      8b:	8d 50 ff             	lea    edx,[eax-0x1]
      8e:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      91:	85 c0                	test   eax,eax
      93:	75 dc                	jne    71 <memcpy+0x14>
		return 1;
      95:	90                   	nop
      96:	90                   	nop
      97:	c9                   	leave
      98:	c3                   	ret

00000099 <if_enabled>:
								? 1 : 0));
				pc_b = min(9, 10 - cpu_pcs[0].vals[4]);
				if (pc_a == 100)
						pc_b = 0;
				crprintf(KFMT_NORMAL, &km_regC, "%3u.%1u%%", pc_a, pc_b);
		}
      99:	55                   	push   ebp
      9a:	89 e5                	mov    ebp,esp
      9c:	83 ec 10             	sub    esp,0x10
}

      9f:	9c                   	pushf
      a0:	58                   	pop    eax
      a1:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				return;
		counter_print = jiffies;
		if (tsc_per_ms) {
				tp = " ns";
				rdt = fb_rdt * 1000000 / tsc_per_ms;
				if (rdt > 99999) {
      a4:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      a7:	83 e0 20             	and    eax,0x20
      aa:	85 c0                	test   eax,eax
      ac:	0f 95 c0             	setne  al
      af:	0f b6 c0             	movzx  eax,al
						rdt /= 1000;
      b2:	c9                   	leave
      b3:	c3                   	ret

000000b4 <__get_cpuid_max>:
   pointer is non-null, then first four bytes of the signature
   (as found in ebx register) are returned in location pointed by sig.  */

static __inline unsigned int
__get_cpuid_max (unsigned int __ext, unsigned int *__sig)
{
      b4:	55                   	push   ebp
      b5:	89 e5                	mov    ebp,esp
      b7:	53                   	push   ebx
      b8:	83 ec 10             	sub    esp,0x10
  unsigned int __eax, __ebx, __ecx, __edx;

#ifndef __x86_64__
  /* See if we can use cpuid.  On AMD64 we always can.  */
#if __GNUC__ >= 3
  __asm__ ("pushf{l|d}\n\t"
      bb:	9c                   	pushf
      bc:	9c                   	pushf
      bd:	5a                   	pop    edx
      be:	89 d0                	mov    eax,edx
      c0:	81 f2 00 00 20 00    	xor    edx,0x200000
      c6:	52                   	push   edx
      c7:	9d                   	popf
      c8:	9c                   	pushf
      c9:	5a                   	pop    edx
      ca:	9d                   	popf
      cb:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
      ce:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
	   "popfl\n\t"
	   : "=&r" (__eax), "=&r" (__ebx)
	   : "i" (0x00200000));
#endif

  if (__builtin_expect (!((__eax ^ __ebx) & 0x00200000), 0))
      d1:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
      d4:	33 45 f4             	xor    eax,DWORD PTR [ebp-0xc]
      d7:	25 00 00 20 00       	and    eax,0x200000
      dc:	85 c0                	test   eax,eax
      de:	0f 94 c0             	sete   al
      e1:	0f b6 c0             	movzx  eax,al
      e4:	85 c0                	test   eax,eax
      e6:	74 07                	je     ef <__get_cpuid_max+0x3b>
    return 0;
      e8:	b8 00 00 00 00       	mov    eax,0x0
      ed:	eb 30                	jmp    11f <__get_cpuid_max+0x6b>
#endif

  /* Host supports cpuid.  Return highest supported cpuid input value.  */
  __cpuid (__ext, __eax, __ebx, __ecx, __edx);
      ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      f2:	b9 00 00 00 00       	mov    ecx,0x0
      f7:	ba 00 00 00 00       	mov    edx,0x0
      fc:	89 cb                	mov    ebx,ecx
      fe:	89 d1                	mov    ecx,edx
     100:	0f a2                	cpuid
     102:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     105:	89 5d f4             	mov    DWORD PTR [ebp-0xc],ebx
     108:	89 4d f0             	mov    DWORD PTR [ebp-0x10],ecx
     10b:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx

  if (__sig)
     10e:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     112:	74 08                	je     11c <__get_cpuid_max+0x68>
    *__sig = __ebx;
     114:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     117:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     11a:	89 10                	mov    DWORD PTR [eax],edx

  return __eax;
     11c:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
}
     11f:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     122:	c9                   	leave
     123:	c3                   	ret

00000124 <exceptionHandler>:
{
     124:	55                   	push   ebp
     125:	89 e5                	mov    ebp,esp
     127:	83 ec 10             	sub    esp,0x10
		struct idt_entry* dt = &idt;
     12a:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
		if (i < 17) {
     131:	83 7d 08 10          	cmp    DWORD PTR [ebp+0x8],0x10
     135:	7f 34                	jg     16b <exceptionHandler+0x47>
				dt[i].offset_1 = (uint16_t)((size_t)ptr & 0x0000ffff);
     137:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
     13a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     13d:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     144:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     147:	01 d0                	add    eax,edx
     149:	89 ca                	mov    edx,ecx
     14b:	66 89 10             	mov    WORD PTR [eax],dx
				dt[i].offset_2 = (uint16_t)((size_t)ptr >> 16);
     14e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     151:	c1 e8 10             	shr    eax,0x10
     154:	89 c1                	mov    ecx,eax
     156:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     159:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     160:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     163:	01 d0                	add    eax,edx
     165:	89 ca                	mov    edx,ecx
     167:	66 89 50 06          	mov    WORD PTR [eax+0x6],dx
}
     16b:	90                   	nop
     16c:	c9                   	leave
     16d:	c3                   	ret

0000016e <print_exception>:
{
     16e:	55                   	push   ebp
     16f:	89 e5                	mov    ebp,esp
     171:	83 ec 18             	sub    esp,0x18
		while (eip);
     174:	90                   	nop
     175:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     179:	75 fa                	jne    175 <print_exception+0x7>
		switch (code) {
     17b:	83 7d 0c 1e          	cmp    DWORD PTR [ebp+0xc],0x1e
     17f:	0f 87 94 01 00 00    	ja     319 <print_exception+0x1ab>
     185:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     188:	c1 e0 02             	shl    eax,0x2
     18b:	05 30 01 00 00       	add    eax,0x130
     190:	8b 00                	mov    eax,DWORD PTR [eax]
     192:	ff e0                	jmp    eax
					printf("#DE at %p\n", eip);
     194:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     197:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     19b:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     1a2:	e8 fc ff ff ff       	call   1a3 <print_exception+0x35>
					break;
     1a7:	e9 88 01 00 00       	jmp    334 <print_exception+0x1c6>
					printf("#BP at %p\n", (void*)((char*)eip-1));
     1ac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1af:	83 e8 01             	sub    eax,0x1
     1b2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     1b6:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
     1bd:	e8 fc ff ff ff       	call   1be <print_exception+0x50>
					break;
     1c2:	e9 6d 01 00 00       	jmp    334 <print_exception+0x1c6>
					printf("#OF before %p\n", eip);
     1c7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1ca:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     1ce:	c7 04 24 16 00 00 00 	mov    DWORD PTR [esp],0x16
     1d5:	e8 fc ff ff ff       	call   1d6 <print_exception+0x68>
					break;
     1da:	e9 55 01 00 00       	jmp    334 <print_exception+0x1c6>
					printf("#BR at %p\n", eip);
     1df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1e2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     1e6:	c7 04 24 25 00 00 00 	mov    DWORD PTR [esp],0x25
     1ed:	e8 fc ff ff ff       	call   1ee <print_exception+0x80>
					while (1);
     1f2:	90                   	nop
     1f3:	eb fd                	jmp    1f2 <print_exception+0x84>
					printf("#UD at %p\n", eip);
     1f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1f8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     1fc:	c7 04 24 30 00 00 00 	mov    DWORD PTR [esp],0x30
     203:	e8 fc ff ff ff       	call   204 <print_exception+0x96>
					while (1);
     208:	90                   	nop
     209:	eb fd                	jmp    208 <print_exception+0x9a>
					printf("#NM at %p\nFPU is disabled or not present\n", eip);
     20b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     20e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     212:	c7 04 24 3c 00 00 00 	mov    DWORD PTR [esp],0x3c
     219:	e8 fc ff ff ff       	call   21a <print_exception+0xac>
					break;
     21e:	e9 11 01 00 00       	jmp    334 <print_exception+0x1c6>
					printf("#DF with error code %x\n", (uint32_t)(size_t)eip);
     223:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     226:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     22a:	c7 04 24 66 00 00 00 	mov    DWORD PTR [esp],0x66
     231:	e8 fc ff ff ff       	call   232 <print_exception+0xc4>
					die("that's it");
     236:	c7 44 24 04 7e 00 00 00 	mov    DWORD PTR [esp+0x4],0x7e
     23e:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     245:	e8 fc ff ff ff       	call   246 <print_exception+0xd8>
     24a:	e8 fc ff ff ff       	call   24b <print_exception+0xdd>
     24f:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     256:	e8 fc ff ff ff       	call   257 <print_exception+0xe9>
     25b:	fa                   	cli
     25c:	f4                   	hlt
     25d:	eb fd                	jmp    25c <print_exception+0xee>
					printf("Legacy coprocessor segment overrun at %p\n", eip);
     25f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     262:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     266:	c7 04 24 88 00 00 00 	mov    DWORD PTR [esp],0x88
     26d:	e8 fc ff ff ff       	call   26e <print_exception+0x100>
					break;
     272:	e9 bd 00 00 00       	jmp    334 <print_exception+0x1c6>
					printf("Reserved gate called from %p\n", eip);
     277:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     27a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     27e:	c7 04 24 b2 00 00 00 	mov    DWORD PTR [esp],0xb2
     285:	e8 fc ff ff ff       	call   286 <print_exception+0x118>
					break;
     28a:	e9 a5 00 00 00       	jmp    334 <print_exception+0x1c6>
					printf("#MF at %p\n", eip);
     28f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     292:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     296:	c7 04 24 d0 00 00 00 	mov    DWORD PTR [esp],0xd0
     29d:	e8 fc ff ff ff       	call   29e <print_exception+0x130>
					break;
     2a2:	e9 8d 00 00 00       	jmp    334 <print_exception+0x1c6>
					printf("#AC at %p\n", eip);
     2a7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2aa:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     2ae:	c7 04 24 db 00 00 00 	mov    DWORD PTR [esp],0xdb
     2b5:	e8 fc ff ff ff       	call   2b6 <print_exception+0x148>
					break;
     2ba:	eb 78                	jmp    334 <print_exception+0x1c6>
					cprintf(KFMT_ERROR, "#MC received while at %p\n", eip);
     2bc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2bf:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     2c3:	c7 44 24 04 e6 00 00 00 	mov    DWORD PTR [esp+0x4],0xe6
     2cb:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     2d2:	e8 fc ff ff ff       	call   2d3 <print_exception+0x165>
					while (1);
     2d7:	90                   	nop
     2d8:	eb fd                	jmp    2d7 <print_exception+0x169>
					printf("#XM at %p\n", eip);
     2da:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2dd:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     2e1:	c7 04 24 00 01 00 00 	mov    DWORD PTR [esp],0x100
     2e8:	e8 fc ff ff ff       	call   2e9 <print_exception+0x17b>
					break;
     2ed:	eb 45                	jmp    334 <print_exception+0x1c6>
					printf("#VE at %p\n", eip);
     2ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2f2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     2f6:	c7 04 24 0b 01 00 00 	mov    DWORD PTR [esp],0x10b
     2fd:	e8 fc ff ff ff       	call   2fe <print_exception+0x190>
					break;
     302:	eb 30                	jmp    334 <print_exception+0x1c6>
					printf("#SX at %p\n", eip);
     304:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     307:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     30b:	c7 04 24 16 01 00 00 	mov    DWORD PTR [esp],0x116
     312:	e8 fc ff ff ff       	call   313 <print_exception+0x1a5>
					break;
     317:	eb 1b                	jmp    334 <print_exception+0x1c6>
					printf("int %x at %p\n", code, eip);
     319:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     31c:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     320:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     323:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     327:	c7 04 24 21 01 00 00 	mov    DWORD PTR [esp],0x121
     32e:	e8 fc ff ff ff       	call   32f <print_exception+0x1c1>
					break;
     333:	90                   	nop
}
     334:	90                   	nop
     335:	c9                   	leave
     336:	c3                   	ret

00000337 <print_idt>:
{
     337:	55                   	push   ebp
     338:	89 e5                	mov    ebp,esp
     33a:	83 ec 38             	sub    esp,0x38
		printf("IDT at %p\n", idt);
     33d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     340:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     344:	c7 04 24 ac 01 00 00 	mov    DWORD PTR [esp],0x1ac
     34b:	e8 fc ff ff ff       	call   34c <print_idt+0x15>
		for (i = 0; i < num; i++) {
     350:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     357:	eb 57                	jmp    3b0 <print_idt+0x79>
								idt->type);
     359:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     35c:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
				printf("IDT entry %d: %x:%p type=%x\n", i, idt->selector,
     360:	0f b6 d0             	movzx  edx,al
								(void*)((((unsigned int)idt->offset_2) << 16) | idt->offset_1),
     363:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     366:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     36a:	0f b7 c0             	movzx  eax,ax
     36d:	c1 e0 10             	shl    eax,0x10
     370:	89 c1                	mov    ecx,eax
     372:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     375:	0f b7 00             	movzx  eax,WORD PTR [eax]
     378:	0f b7 c0             	movzx  eax,ax
     37b:	09 c8                	or     eax,ecx
				printf("IDT entry %d: %x:%p type=%x\n", i, idt->selector,
     37d:	89 c1                	mov    ecx,eax
     37f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     382:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     386:	0f b7 c0             	movzx  eax,ax
     389:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
     38d:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     391:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     395:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     398:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     39c:	c7 04 24 b7 01 00 00 	mov    DWORD PTR [esp],0x1b7
     3a3:	e8 fc ff ff ff       	call   3a4 <print_idt+0x6d>
				idt++;
     3a8:	83 45 08 08          	add    DWORD PTR [ebp+0x8],0x8
		for (i = 0; i < num; i++) {
     3ac:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     3b0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3b3:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
     3b6:	72 a1                	jb     359 <print_idt+0x22>
}
     3b8:	90                   	nop
     3b9:	90                   	nop
     3ba:	c9                   	leave
     3bb:	c3                   	ret

000003bc <debug_handler>:
{
     3bc:	55                   	push   ebp
     3bd:	89 e5                	mov    ebp,esp
     3bf:	83 ec 18             	sub    esp,0x18
		cprintf(KFMT_INFO, "#DB at %p with DR6=%x\n", eip, dr6);
     3c2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     3c5:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
     3c9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3cc:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     3d0:	c7 44 24 04 d4 01 00 00 	mov    DWORD PTR [esp+0x4],0x1d4
     3d8:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
     3df:	e8 fc ff ff ff       	call   3e0 <debug_handler+0x24>
		return 0;
     3e4:	b8 00 00 00 00       	mov    eax,0x0
}
     3e9:	c9                   	leave
     3ea:	c3                   	ret

000003eb <irq_mask>:
{
     3eb:	55                   	push   ebp
     3ec:	89 e5                	mov    ebp,esp
     3ee:	53                   	push   ebx
     3ef:	83 ec 1c             	sub    esp,0x1c
     3f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3f5:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		if (line < 8)
     3f8:	80 7d e8 07          	cmp    BYTE PTR [ebp-0x18],0x7
     3fc:	77 08                	ja     406 <irq_mask+0x1b>
				prt = PIC1_DATA;
     3fe:	66 c7 45 fa 21 00    	mov    WORD PTR [ebp-0x6],0x21
     404:	eb 10                	jmp    416 <irq_mask+0x2b>
		else if (line <= 15) {
     406:	80 7d e8 0f          	cmp    BYTE PTR [ebp-0x18],0xf
     40a:	77 42                	ja     44e <irq_mask+0x63>
				prt = PIC2_DATA;
     40c:	66 c7 45 fa a1 00    	mov    WORD PTR [ebp-0x6],0xa1
				line -= 8;
     412:	80 6d e8 08          	sub    BYTE PTR [ebp-0x18],0x8
		line = inb(prt) | (1 << line);
     416:	0f b7 45 fa          	movzx  eax,WORD PTR [ebp-0x6]
     41a:	89 04 24             	mov    DWORD PTR [esp],eax
     41d:	e8 1e fc ff ff       	call   40 <inb>
     422:	89 c3                	mov    ebx,eax
     424:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
     428:	ba 01 00 00 00       	mov    edx,0x1
     42d:	89 c1                	mov    ecx,eax
     42f:	d3 e2                	shl    edx,cl
     431:	89 d0                	mov    eax,edx
     433:	09 d8                	or     eax,ebx
     435:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		outb(prt, line);
     438:	0f b6 55 e8          	movzx  edx,BYTE PTR [ebp-0x18]
     43c:	0f b7 45 fa          	movzx  eax,WORD PTR [ebp-0x6]
     440:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     444:	89 04 24             	mov    DWORD PTR [esp],eax
     447:	e8 d5 fb ff ff       	call   21 <outb>
     44c:	eb 01                	jmp    44f <irq_mask+0x64>
				return;
     44e:	90                   	nop
}
     44f:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     452:	c9                   	leave
     453:	c3                   	ret

00000454 <irq_unmask>:
{
     454:	55                   	push   ebp
     455:	89 e5                	mov    ebp,esp
     457:	53                   	push   ebx
     458:	83 ec 1c             	sub    esp,0x1c
     45b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     45e:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		if (line < 8)
     461:	80 7d e8 07          	cmp    BYTE PTR [ebp-0x18],0x7
     465:	77 08                	ja     46f <irq_unmask+0x1b>
				prt = PIC1_DATA;
     467:	66 c7 45 fa 21 00    	mov    WORD PTR [ebp-0x6],0x21
     46d:	eb 10                	jmp    47f <irq_unmask+0x2b>
		else if (line <= 15) {
     46f:	80 7d e8 0f          	cmp    BYTE PTR [ebp-0x18],0xf
     473:	77 44                	ja     4b9 <irq_unmask+0x65>
				prt = PIC2_DATA;
     475:	66 c7 45 fa a1 00    	mov    WORD PTR [ebp-0x6],0xa1
				line -= 8;
     47b:	80 6d e8 08          	sub    BYTE PTR [ebp-0x18],0x8
		line = inb(prt) & ~(1 << line);
     47f:	0f b7 45 fa          	movzx  eax,WORD PTR [ebp-0x6]
     483:	89 04 24             	mov    DWORD PTR [esp],eax
     486:	e8 b5 fb ff ff       	call   40 <inb>
     48b:	89 c3                	mov    ebx,eax
     48d:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
     491:	ba 01 00 00 00       	mov    edx,0x1
     496:	89 c1                	mov    ecx,eax
     498:	d3 e2                	shl    edx,cl
     49a:	89 d0                	mov    eax,edx
     49c:	f7 d0                	not    eax
     49e:	21 d8                	and    eax,ebx
     4a0:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		outb(prt, line);
     4a3:	0f b6 55 e8          	movzx  edx,BYTE PTR [ebp-0x18]
     4a7:	0f b7 45 fa          	movzx  eax,WORD PTR [ebp-0x6]
     4ab:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     4af:	89 04 24             	mov    DWORD PTR [esp],eax
     4b2:	e8 6a fb ff ff       	call   21 <outb>
     4b7:	eb 01                	jmp    4ba <irq_unmask+0x66>
				return;
     4b9:	90                   	nop
}
     4ba:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     4bd:	c9                   	leave
     4be:	c3                   	ret

000004bf <pic_disable>:
{
     4bf:	55                   	push   ebp
     4c0:	89 e5                	mov    ebp,esp
     4c2:	83 ec 08             	sub    esp,0x8
		outb(PIC2_COMMAND, 0xff);
     4c5:	c7 44 24 04 ff 00 00 00 	mov    DWORD PTR [esp+0x4],0xff
     4cd:	c7 04 24 a0 00 00 00 	mov    DWORD PTR [esp],0xa0
     4d4:	e8 48 fb ff ff       	call   21 <outb>
		outb(PIC1_COMMAND, 0xff);
     4d9:	c7 44 24 04 ff 00 00 00 	mov    DWORD PTR [esp+0x4],0xff
     4e1:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
     4e8:	e8 34 fb ff ff       	call   21 <outb>
}
     4ed:	90                   	nop
     4ee:	c9                   	leave
     4ef:	c3                   	ret

000004f0 <pic_get_irr>:
{
     4f0:	55                   	push   ebp
     4f1:	89 e5                	mov    ebp,esp
     4f3:	53                   	push   ebx
     4f4:	83 ec 08             	sub    esp,0x8
		outb(PIC1_COMMAND, 0x0a); /* PIC_READ_IRR */
     4f7:	c7 44 24 04 0a 00 00 00 	mov    DWORD PTR [esp+0x4],0xa
     4ff:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
     506:	e8 16 fb ff ff       	call   21 <outb>
		outb(PIC2_COMMAND, 0x0a);
     50b:	c7 44 24 04 0a 00 00 00 	mov    DWORD PTR [esp+0x4],0xa
     513:	c7 04 24 a0 00 00 00 	mov    DWORD PTR [esp],0xa0
     51a:	e8 02 fb ff ff       	call   21 <outb>
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
     51f:	c7 04 24 a0 00 00 00 	mov    DWORD PTR [esp],0xa0
     526:	e8 15 fb ff ff       	call   40 <inb>
     52b:	0f b6 c0             	movzx  eax,al
     52e:	c1 e0 08             	shl    eax,0x8
     531:	89 c3                	mov    ebx,eax
     533:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
     53a:	e8 01 fb ff ff       	call   40 <inb>
     53f:	0f b6 c0             	movzx  eax,al
     542:	09 d8                	or     eax,ebx
}
     544:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     547:	c9                   	leave
     548:	c3                   	ret

00000549 <pic_get_isr>:
{
     549:	55                   	push   ebp
     54a:	89 e5                	mov    ebp,esp
     54c:	53                   	push   ebx
     54d:	83 ec 08             	sub    esp,0x8
		outb(PIC1_COMMAND, 0x0b); /* PIC_READ_ISR */
     550:	c7 44 24 04 0b 00 00 00 	mov    DWORD PTR [esp+0x4],0xb
     558:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
     55f:	e8 bd fa ff ff       	call   21 <outb>
		outb(PIC2_COMMAND, 0x0b);
     564:	c7 44 24 04 0b 00 00 00 	mov    DWORD PTR [esp+0x4],0xb
     56c:	c7 04 24 a0 00 00 00 	mov    DWORD PTR [esp],0xa0
     573:	e8 a9 fa ff ff       	call   21 <outb>
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
     578:	c7 04 24 a0 00 00 00 	mov    DWORD PTR [esp],0xa0
     57f:	e8 bc fa ff ff       	call   40 <inb>
     584:	0f b6 c0             	movzx  eax,al
     587:	c1 e0 08             	shl    eax,0x8
     58a:	89 c3                	mov    ebx,eax
     58c:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
     593:	e8 a8 fa ff ff       	call   40 <inb>
     598:	0f b6 c0             	movzx  eax,al
     59b:	09 d8                	or     eax,ebx
}
     59d:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     5a0:	c9                   	leave
     5a1:	c3                   	ret

000005a2 <enable_com>:
{
     5a2:	55                   	push   ebp
     5a3:	89 e5                	mov    ebp,esp
     5a5:	83 ec 0c             	sub    esp,0xc
     5a8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5ab:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		if (!com_present) {
     5af:	a1 c0 01 00 00       	mov    eax,ds:0x1c0
     5b4:	85 c0                	test   eax,eax
     5b6:	75 2c                	jne    5e4 <enable_com+0x42>
				com_present = 1;
     5b8:	c7 05 c0 01 00 00 01 00 00 00 	mov    DWORD PTR ds:0x1c0,0x1
				def_port = port;
     5c2:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     5c6:	66 a3 cc 01 00 00    	mov    ds:0x1cc,ax
				irq_unmask(3);
     5cc:	c7 04 24 03 00 00 00 	mov    DWORD PTR [esp],0x3
     5d3:	e8 fc ff ff ff       	call   5d4 <enable_com+0x32>
				irq_unmask(4);
     5d8:	c7 04 24 04 00 00 00 	mov    DWORD PTR [esp],0x4
     5df:	e8 fc ff ff ff       	call   5e0 <enable_com+0x3e>
		if (num < 4)
     5e4:	83 7d 08 03          	cmp    DWORD PTR [ebp+0x8],0x3
     5e8:	7f 0f                	jg     5f9 <enable_com+0x57>
				com_ports[num] = port;
     5ea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5ed:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
     5f1:	66 89 94 00 c4 01 00 00 	mov    WORD PTR [eax+eax*1+0x1c4],dx
		outb(port + 1, 0x00); /* disable interrupts */
     5f9:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     5fd:	83 c0 01             	add    eax,0x1
     600:	0f b7 c0             	movzx  eax,ax
     603:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     60b:	89 04 24             	mov    DWORD PTR [esp],eax
     60e:	e8 0e fa ff ff       	call   21 <outb>
		outb(port + 3, 0x80); /* DLAB enable */
     613:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     617:	83 c0 03             	add    eax,0x3
     61a:	0f b7 c0             	movzx  eax,ax
     61d:	c7 44 24 04 80 00 00 00 	mov    DWORD PTR [esp+0x4],0x80
     625:	89 04 24             	mov    DWORD PTR [esp],eax
     628:	e8 f4 f9 ff ff       	call   21 <outb>
		outb(port + 0, 0x0c); /* baud 9600 (div 12) */
     62d:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     631:	c7 44 24 04 0c 00 00 00 	mov    DWORD PTR [esp+0x4],0xc
     639:	89 04 24             	mov    DWORD PTR [esp],eax
     63c:	e8 e0 f9 ff ff       	call   21 <outb>
		outb(port + 1, 0x00);
     641:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     645:	83 c0 01             	add    eax,0x1
     648:	0f b7 c0             	movzx  eax,ax
     64b:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     653:	89 04 24             	mov    DWORD PTR [esp],eax
     656:	e8 c6 f9 ff ff       	call   21 <outb>
		outb(port + 3, 0x03); /* DLAB disable, 8+1 bits no parity */
     65b:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     65f:	83 c0 03             	add    eax,0x3
     662:	0f b7 c0             	movzx  eax,ax
     665:	c7 44 24 04 03 00 00 00 	mov    DWORD PTR [esp+0x4],0x3
     66d:	89 04 24             	mov    DWORD PTR [esp],eax
     670:	e8 ac f9 ff ff       	call   21 <outb>
		outb(port + 2, 0xe7); /* enable FIFO and trigger at 14 bytes and clear */
     675:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     679:	83 c0 02             	add    eax,0x2
     67c:	0f b7 c0             	movzx  eax,ax
     67f:	c7 44 24 04 e7 00 00 00 	mov    DWORD PTR [esp+0x4],0xe7
     687:	89 04 24             	mov    DWORD PTR [esp],eax
     68a:	e8 92 f9 ff ff       	call   21 <outb>
		outb(port + 4, 0x0b);
     68f:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     693:	83 c0 04             	add    eax,0x4
     696:	0f b7 c0             	movzx  eax,ax
     699:	c7 44 24 04 0b 00 00 00 	mov    DWORD PTR [esp+0x4],0xb
     6a1:	89 04 24             	mov    DWORD PTR [esp],eax
     6a4:	e8 78 f9 ff ff       	call   21 <outb>
		outb(port + 1, 0x07); /* enable buf empty & recv & line status interrupt */
     6a9:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     6ad:	83 c0 01             	add    eax,0x1
     6b0:	0f b7 c0             	movzx  eax,ax
     6b3:	c7 44 24 04 07 00 00 00 	mov    DWORD PTR [esp+0x4],0x7
     6bb:	89 04 24             	mov    DWORD PTR [esp],eax
     6be:	e8 5e f9 ff ff       	call   21 <outb>
}
     6c3:	90                   	nop
     6c4:	c9                   	leave
     6c5:	c3                   	ret

000006c6 <com_interrupt>:
{
     6c6:	55                   	push   ebp
     6c7:	89 e5                	mov    ebp,esp
     6c9:	83 ec 28             	sub    esp,0x28
		for (int i = 0; i < 4; i++) {
     6cc:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     6d3:	e9 b6 01 00 00       	jmp    88e <com_interrupt+0x1c8>
				port = com_ports[i];
     6d8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     6db:	0f b7 84 00 c4 01 00 00 	movzx  eax,WORD PTR [eax+eax*1+0x1c4]
     6e3:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
				if (!port)
     6e7:	66 83 7d f2 00       	cmp    WORD PTR [ebp-0xe],0x0
     6ec:	0f 84 94 01 00 00    	je     886 <com_interrupt+0x1c0>
				iir = inb(port + 2);
     6f2:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     6f6:	83 c0 02             	add    eax,0x2
     6f9:	0f b7 c0             	movzx  eax,ax
     6fc:	89 04 24             	mov    DWORD PTR [esp],eax
     6ff:	e8 3c f9 ff ff       	call   40 <inb>
     704:	88 45 f1             	mov    BYTE PTR [ebp-0xf],al
				if ((iir & 1)) /* 0 means yes 1 no */
     707:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     70b:	83 e0 01             	and    eax,0x1
     70e:	85 c0                	test   eax,eax
     710:	0f 85 73 01 00 00    	jne    889 <com_interrupt+0x1c3>
				if ((iir & 0x0e) == 0x00) /* modem status*/
     716:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     71a:	83 e0 0e             	and    eax,0xe
     71d:	85 c0                	test   eax,eax
     71f:	75 14                	jne    735 <com_interrupt+0x6f>
						inb(port + 6); /* just pop the interrupt */
     721:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     725:	83 c0 06             	add    eax,0x6
     728:	0f b7 c0             	movzx  eax,ax
     72b:	89 04 24             	mov    DWORD PTR [esp],eax
     72e:	e8 0d f9 ff ff       	call   40 <inb>
     733:	eb 51                	jmp    786 <com_interrupt+0xc0>
				else if ((iir & 0x0e) == 0x02) { /* transmitter empty */
     735:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     739:	83 e0 0e             	and    eax,0xe
     73c:	83 f8 02             	cmp    eax,0x2
     73f:	74 45                	je     786 <com_interrupt+0xc0>
				} else if ((iir & 0x0e) == 0x04) { /* data available */
     741:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     745:	83 e0 0e             	and    eax,0xe
     748:	83 f8 04             	cmp    eax,0x4
     74b:	74 39                	je     786 <com_interrupt+0xc0>
				} else if ((iir & 0x0e) == 0x06) { /* line status interrupt */
     74d:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     751:	83 e0 0e             	and    eax,0xe
     754:	83 f8 06             	cmp    eax,0x6
     757:	75 0e                	jne    767 <com_interrupt+0xa1>
						iprintf("line status:\n");
     759:	c7 04 24 eb 01 00 00 	mov    DWORD PTR [esp],0x1eb
     760:	e8 fc ff ff ff       	call   761 <com_interrupt+0x9b>
     765:	eb 1f                	jmp    786 <com_interrupt+0xc0>
				} else if ((iir & 0x0e) == 0x0c) { /* time out */
     767:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     76b:	83 e0 0e             	and    eax,0xe
     76e:	83 f8 0c             	cmp    eax,0xc
     771:	74 13                	je     786 <com_interrupt+0xc0>
						iprintf("unknown interrupt on COM%d\n", i);
     773:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     776:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     77a:	c7 04 24 f9 01 00 00 	mov    DWORD PTR [esp],0x1f9
     781:	e8 fc ff ff ff       	call   782 <com_interrupt+0xbc>
				lsr = inb(port + 5);
     786:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     78a:	83 c0 05             	add    eax,0x5
     78d:	0f b7 c0             	movzx  eax,ax
     790:	89 04 24             	mov    DWORD PTR [esp],eax
     793:	e8 a8 f8 ff ff       	call   40 <inb>
     798:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
				if (lsr & (1 << 7)) { /* clear fifo */
     79b:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     79f:	84 c0                	test   al,al
     7a1:	79 1c                	jns    7bf <com_interrupt+0xf9>
						outb(port + 2, 0xc7);
     7a3:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     7a7:	83 c0 02             	add    eax,0x2
     7aa:	0f b7 c0             	movzx  eax,ax
     7ad:	c7 44 24 04 c7 00 00 00 	mov    DWORD PTR [esp+0x4],0xc7
     7b5:	89 04 24             	mov    DWORD PTR [esp],eax
     7b8:	e8 64 f8 ff ff       	call   21 <outb>
     7bd:	eb 5e                	jmp    81d <com_interrupt+0x157>
				} else if (lsr & (1 << 3)) { /* framing error */
     7bf:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     7c3:	83 e0 08             	and    eax,0x8
     7c6:	85 c0                	test   eax,eax
     7c8:	74 15                	je     7df <com_interrupt+0x119>
						iprintf("COM%d framing error\n", i);
     7ca:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7cd:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     7d1:	c7 04 24 15 02 00 00 	mov    DWORD PTR [esp],0x215
     7d8:	e8 fc ff ff ff       	call   7d9 <com_interrupt+0x113>
     7dd:	eb 3e                	jmp    81d <com_interrupt+0x157>
				} else if (lsr & (1 << 2)) { /* parity error */
     7df:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     7e3:	83 e0 04             	and    eax,0x4
     7e6:	85 c0                	test   eax,eax
     7e8:	74 15                	je     7ff <com_interrupt+0x139>
						iprintf("COM%d parity error\n", i);
     7ea:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7ed:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     7f1:	c7 04 24 2a 02 00 00 	mov    DWORD PTR [esp],0x22a
     7f8:	e8 fc ff ff ff       	call   7f9 <com_interrupt+0x133>
     7fd:	eb 1e                	jmp    81d <com_interrupt+0x157>
				} else if (lsr & (1 << 1)) { /* overrun */
     7ff:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     803:	83 e0 02             	and    eax,0x2
     806:	85 c0                	test   eax,eax
     808:	74 13                	je     81d <com_interrupt+0x157>
						iprintf("COM%d overrun\n", i);
     80a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     80d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     811:	c7 04 24 3e 02 00 00 	mov    DWORD PTR [esp],0x23e
     818:	e8 fc ff ff ff       	call   819 <com_interrupt+0x153>
				if (lsr & 1) { /* data ready */
     81d:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     821:	83 e0 01             	and    eax,0x1
     824:	85 c0                	test   eax,eax
     826:	74 62                	je     88a <com_interrupt+0x1c4>
						iprintf("COM%d data: \"", i);
     828:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     82b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     82f:	c7 04 24 4d 02 00 00 	mov    DWORD PTR [esp],0x24d
     836:	e8 fc ff ff ff       	call   837 <com_interrupt+0x171>
								char c = inb(port);
     83b:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     83f:	89 04 24             	mov    DWORD PTR [esp],eax
     842:	e8 f9 f7 ff ff       	call   40 <inb>
     847:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
								if (c == 3) { /* TODO: reimplement stub */
     84a:	80 7d ef 03          	cmp    BYTE PTR [ebp-0x11],0x3
     84e:	74 0c                	je     85c <com_interrupt+0x196>
										putchar(c);
     850:	0f be 45 ef          	movsx  eax,BYTE PTR [ebp-0x11]
     854:	89 04 24             	mov    DWORD PTR [esp],eax
     857:	e8 fc ff ff ff       	call   858 <com_interrupt+0x192>
						} while (inb(port + 5) & 1);
     85c:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     860:	83 c0 05             	add    eax,0x5
     863:	0f b7 c0             	movzx  eax,ax
     866:	89 04 24             	mov    DWORD PTR [esp],eax
     869:	e8 d2 f7 ff ff       	call   40 <inb>
     86e:	0f b6 c0             	movzx  eax,al
     871:	83 e0 01             	and    eax,0x1
     874:	85 c0                	test   eax,eax
     876:	75 c3                	jne    83b <com_interrupt+0x175>
						iprintf("\"\n");
     878:	c7 04 24 5b 02 00 00 	mov    DWORD PTR [esp],0x25b
     87f:	e8 fc ff ff ff       	call   880 <com_interrupt+0x1ba>
     884:	eb 04                	jmp    88a <com_interrupt+0x1c4>
						continue;
     886:	90                   	nop
     887:	eb 01                	jmp    88a <com_interrupt+0x1c4>
						continue;
     889:	90                   	nop
		for (int i = 0; i < 4; i++) {
     88a:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     88e:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
     892:	0f 8e 40 fe ff ff    	jle    6d8 <com_interrupt+0x12>
}
     898:	90                   	nop
     899:	90                   	nop
     89a:	c9                   	leave
     89b:	c3                   	ret

0000089c <com_status>:
{
     89c:	55                   	push   ebp
     89d:	89 e5                	mov    ebp,esp
     89f:	83 ec 28             	sub    esp,0x28
		for (int i = 0; i < 4; i++)
     8a2:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     8a9:	eb 53                	jmp    8fe <com_status+0x62>
				if (com_ports[i]) {
     8ab:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8ae:	0f b7 84 00 c4 01 00 00 	movzx  eax,WORD PTR [eax+eax*1+0x1c4]
     8b6:	66 85 c0             	test   ax,ax
     8b9:	74 3f                	je     8fa <com_status+0x5e>
						uint16_t port = com_ports[i];
     8bb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8be:	0f b7 84 00 c4 01 00 00 	movzx  eax,WORD PTR [eax+eax*1+0x1c4]
     8c6:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
						lsr = inb(port + 5);
     8ca:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     8ce:	83 c0 05             	add    eax,0x5
     8d1:	0f b7 c0             	movzx  eax,ax
     8d4:	89 04 24             	mov    DWORD PTR [esp],eax
     8d7:	e8 64 f7 ff ff       	call   40 <inb>
     8dc:	88 45 f1             	mov    BYTE PTR [ebp-0xf],al
						printf("COM%d lsr: %08b\n", i, lsr);
     8df:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     8e3:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     8e7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8ea:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     8ee:	c7 04 24 5e 02 00 00 	mov    DWORD PTR [esp],0x25e
     8f5:	e8 fc ff ff ff       	call   8f6 <com_status+0x5a>
		for (int i = 0; i < 4; i++)
     8fa:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     8fe:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
     902:	7e a7                	jle    8ab <com_status+0xf>
}
     904:	90                   	nop
     905:	90                   	nop
     906:	c9                   	leave
     907:	c3                   	ret

00000908 <is_transit_empty>:
{
     908:	55                   	push   ebp
     909:	89 e5                	mov    ebp,esp
     90b:	83 ec 08             	sub    esp,0x8
     90e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     911:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		return inb(port + 5) & 0x20;
     915:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     919:	83 c0 05             	add    eax,0x5
     91c:	0f b7 c0             	movzx  eax,ax
     91f:	89 04 24             	mov    DWORD PTR [esp],eax
     922:	e8 19 f7 ff ff       	call   40 <inb>
     927:	0f b6 c0             	movzx  eax,al
     92a:	83 e0 20             	and    eax,0x20
}
     92d:	c9                   	leave
     92e:	c3                   	ret

0000092f <putDebugChar>:
{
     92f:	55                   	push   ebp
     930:	89 e5                	mov    ebp,esp
     932:	83 ec 0c             	sub    esp,0xc
     935:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     938:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		while (!is_transit_empty(def_port));
     93b:	90                   	nop
     93c:	0f b7 05 cc 01 00 00 	movzx  eax,WORD PTR ds:0x1cc
     943:	0f b7 c0             	movzx  eax,ax
     946:	89 04 24             	mov    DWORD PTR [esp],eax
     949:	e8 fc ff ff ff       	call   94a <putDebugChar+0x1b>
     94e:	85 c0                	test   eax,eax
     950:	74 ea                	je     93c <putDebugChar+0xd>
		outb(def_port, c);
     952:	0f b6 45 fc          	movzx  eax,BYTE PTR [ebp-0x4]
     956:	0f b6 d0             	movzx  edx,al
     959:	0f b7 05 cc 01 00 00 	movzx  eax,WORD PTR ds:0x1cc
     960:	0f b7 c0             	movzx  eax,ax
     963:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     967:	89 04 24             	mov    DWORD PTR [esp],eax
     96a:	e8 b2 f6 ff ff       	call   21 <outb>
}
     96f:	90                   	nop
     970:	c9                   	leave
     971:	c3                   	ret

00000972 <serial_received>:
{
     972:	55                   	push   ebp
     973:	89 e5                	mov    ebp,esp
     975:	83 ec 08             	sub    esp,0x8
     978:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     97b:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		return inb(port + 5) & 1;
     97f:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     983:	83 c0 05             	add    eax,0x5
     986:	0f b7 c0             	movzx  eax,ax
     989:	89 04 24             	mov    DWORD PTR [esp],eax
     98c:	e8 af f6 ff ff       	call   40 <inb>
     991:	0f b6 c0             	movzx  eax,al
     994:	83 e0 01             	and    eax,0x1
}
     997:	c9                   	leave
     998:	c3                   	ret

00000999 <getDebugChar>:
{
     999:	55                   	push   ebp
     99a:	89 e5                	mov    ebp,esp
     99c:	83 ec 04             	sub    esp,0x4
		while (!serial_received(def_port));
     99f:	90                   	nop
     9a0:	0f b7 05 cc 01 00 00 	movzx  eax,WORD PTR ds:0x1cc
     9a7:	0f b7 c0             	movzx  eax,ax
     9aa:	89 04 24             	mov    DWORD PTR [esp],eax
     9ad:	e8 fc ff ff ff       	call   9ae <getDebugChar+0x15>
     9b2:	85 c0                	test   eax,eax
     9b4:	74 ea                	je     9a0 <getDebugChar+0x7>
		return inb(def_port);
     9b6:	0f b7 05 cc 01 00 00 	movzx  eax,WORD PTR ds:0x1cc
     9bd:	0f b7 c0             	movzx  eax,ax
     9c0:	89 04 24             	mov    DWORD PTR [esp],eax
     9c3:	e8 78 f6 ff ff       	call   40 <inb>
}
     9c8:	c9                   	leave
     9c9:	c3                   	ret

000009ca <forward_irq>:
{
     9ca:	55                   	push   ebp
     9cb:	89 e5                	mov    ebp,esp
     9cd:	83 ec 28             	sub    esp,0x28
		if (!irq || irq > 15)
     9d0:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     9d4:	74 3e                	je     a14 <forward_irq+0x4a>
     9d6:	83 7d 08 0f          	cmp    DWORD PTR [ebp+0x8],0xf
     9da:	77 38                	ja     a14 <forward_irq+0x4a>
		pt = irq_funs[--irq]; /* 1 based */
     9dc:	83 6d 08 01          	sub    DWORD PTR [ebp+0x8],0x1
     9e0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9e3:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     9ea:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (pt) {
     9ed:	eb 1d                	jmp    a0c <forward_irq+0x42>
				if (pt->fun(irq + 1)) /* handled */
     9ef:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9f2:	8b 00                	mov    eax,DWORD PTR [eax]
     9f4:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     9f7:	83 c2 01             	add    edx,0x1
     9fa:	89 14 24             	mov    DWORD PTR [esp],edx
     9fd:	ff d0                	call   eax
     9ff:	85 c0                	test   eax,eax
     a01:	75 14                	jne    a17 <forward_irq+0x4d>
				pt = pt->next;
     a03:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a06:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a09:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (pt) {
     a0c:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     a10:	75 dd                	jne    9ef <forward_irq+0x25>
     a12:	eb 04                	jmp    a18 <forward_irq+0x4e>
				return;
     a14:	90                   	nop
     a15:	eb 01                	jmp    a18 <forward_irq+0x4e>
						break;
     a17:	90                   	nop
}
     a18:	c9                   	leave
     a19:	c3                   	ret

00000a1a <install_irq_handler>:
{
     a1a:	55                   	push   ebp
     a1b:	89 e5                	mov    ebp,esp
     a1d:	53                   	push   ebx
     a1e:	83 ec 24             	sub    esp,0x24
		if (!irq || irq > 15)
     a21:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     a25:	74 06                	je     a2d <install_irq_handler+0x13>
     a27:	83 7d 08 0f          	cmp    DWORD PTR [ebp+0x8],0xf
     a2b:	76 0a                	jbe    a37 <install_irq_handler+0x1d>
				return 0;
     a2d:	b8 00 00 00 00       	mov    eax,0x0
     a32:	e9 85 00 00 00       	jmp    abc <install_irq_handler+0xa2>
		struct irqe* p = kmalloc(sizeof(*p));
     a37:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
     a3e:	e8 fc ff ff ff       	call   a3f <install_irq_handler+0x25>
     a43:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!p)
     a46:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     a4a:	75 07                	jne    a53 <install_irq_handler+0x39>
				return 0;
     a4c:	b8 00 00 00 00       	mov    eax,0x0
     a51:	eb 69                	jmp    abc <install_irq_handler+0xa2>
		p->fun = fun;
     a53:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a56:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     a59:	89 10                	mov    DWORD PTR [eax],edx
		if (!irq_funs[irq - 1])
     a5b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a5e:	83 e8 01             	sub    eax,0x1
     a61:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     a68:	85 c0                	test   eax,eax
     a6a:	75 0e                	jne    a7a <install_irq_handler+0x60>
				irq_unmask(irq);
     a6c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a6f:	0f b6 c0             	movzx  eax,al
     a72:	89 04 24             	mov    DWORD PTR [esp],eax
     a75:	e8 fc ff ff ff       	call   a76 <install_irq_handler+0x5c>
				p->next = irq_funs[irq - 1];
     a7a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a7d:	83 e8 01             	sub    eax,0x1
     a80:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
     a87:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a8a:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		} while (!__sync_bool_compare_and_swap(&irq_funs[irq - 1], p->next, p));
     a8d:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     a90:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a93:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a96:	89 c3                	mov    ebx,eax
     a98:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a9b:	83 e8 01             	sub    eax,0x1
     a9e:	c1 e0 02             	shl    eax,0x2
     aa1:	8d 88 00 00 00 00    	lea    ecx,[eax+0x0]
     aa7:	89 d8                	mov    eax,ebx
     aa9:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     aad:	0f 94 c0             	sete   al
     ab0:	83 f0 01             	xor    eax,0x1
     ab3:	84 c0                	test   al,al
     ab5:	75 c3                	jne    a7a <install_irq_handler+0x60>
		return 1;
     ab7:	b8 01 00 00 00       	mov    eax,0x1
}
     abc:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     abf:	c9                   	leave
     ac0:	c3                   	ret

00000ac1 <remove_irq_handler>:
{
     ac1:	55                   	push   ebp
     ac2:	89 e5                	mov    ebp,esp
     ac4:	83 ec 28             	sub    esp,0x28
		struct irqe* pt, *prev = NULL;
     ac7:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		if (!irq || irq > 15)
     ace:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     ad2:	74 09                	je     add <remove_irq_handler+0x1c>
     ad4:	83 7d 08 0f          	cmp    DWORD PTR [ebp+0x8],0xf
     ad8:	77 03                	ja     add <remove_irq_handler+0x1c>
start:
     ada:	90                   	nop
     adb:	eb 0b                	jmp    ae8 <remove_irq_handler+0x27>
				return 0;
     add:	b8 00 00 00 00       	mov    eax,0x0
     ae2:	e9 98 00 00 00       	jmp    b7f <remove_irq_handler+0xbe>
										goto start;
     ae7:	90                   	nop
		pt = irq_funs[irq - 1];
     ae8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     aeb:	83 e8 01             	sub    eax,0x1
     aee:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     af5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (pt) {
     af8:	eb 7a                	jmp    b74 <remove_irq_handler+0xb3>
				if (pt->fun == fun) {
     afa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     afd:	8b 00                	mov    eax,DWORD PTR [eax]
     aff:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
     b02:	75 61                	jne    b65 <remove_irq_handler+0xa4>
						if (prev) {
     b04:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     b08:	74 21                	je     b2b <remove_irq_handler+0x6a>
														pt, pt->next))
     b0a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b0d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								if (!__sync_bool_compare_and_swap(&prev->next,
     b10:	89 c1                	mov    ecx,eax
     b12:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b15:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     b18:	83 c2 04             	add    edx,0x4
     b1b:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     b1f:	0f 94 c0             	sete   al
     b22:	83 f0 01             	xor    eax,0x1
     b25:	84 c0                	test   al,al
     b27:	74 2a                	je     b53 <remove_irq_handler+0x92>
										goto start;
     b29:	eb bd                	jmp    ae8 <remove_irq_handler+0x27>
														pt, pt->next))
     b2b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b2e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								if (!__sync_bool_compare_and_swap(&irq_funs[irq - 1],
     b31:	89 c1                	mov    ecx,eax
     b33:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b36:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     b39:	83 ea 01             	sub    edx,0x1
     b3c:	c1 e2 02             	shl    edx,0x2
     b3f:	81 c2 00 00 00 00    	add    edx,0x0
     b45:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     b49:	0f 94 c0             	sete   al
     b4c:	83 f0 01             	xor    eax,0x1
     b4f:	84 c0                	test   al,al
     b51:	75 94                	jne    ae7 <remove_irq_handler+0x26>
						kfree(pt);
     b53:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b56:	89 04 24             	mov    DWORD PTR [esp],eax
     b59:	e8 fc ff ff ff       	call   b5a <remove_irq_handler+0x99>
						return 1;
     b5e:	b8 01 00 00 00       	mov    eax,0x1
     b63:	eb 1a                	jmp    b7f <remove_irq_handler+0xbe>
				prev = pt;
     b65:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b68:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				pt = pt->next;
     b6b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b6e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     b71:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (pt) {
     b74:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     b78:	75 80                	jne    afa <remove_irq_handler+0x39>
		return 0;
     b7a:	b8 00 00 00 00       	mov    eax,0x0
}
     b7f:	c9                   	leave
     b80:	c3                   	ret

00000b81 <msi_handler>:
{
     b81:	55                   	push   ebp
     b82:	89 e5                	mov    ebp,esp
     b84:	83 ec 18             	sub    esp,0x18
		iprintf("MSI %u received on processor %u\n", msi, smp_processor_id());
     b87:	e8 74 f4 ff ff       	call   0 <per_cpu_ptr>
     b8c:	8b 00                	mov    eax,DWORD PTR [eax]
     b8e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     b92:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b95:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     b99:	c7 04 24 70 02 00 00 	mov    DWORD PTR [esp],0x270
     ba0:	e8 fc ff ff ff       	call   ba1 <msi_handler+0x20>
}
     ba5:	90                   	nop
     ba6:	c9                   	leave
     ba7:	c3                   	ret

00000ba8 <irq_handler>:
{
     ba8:	55                   	push   ebp
     ba9:	89 e5                	mov    ebp,esp
     bab:	83 ec 28             	sub    esp,0x28
		int spurious = 0; void (*hook)();
     bae:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		if (irq >= 8) { /* check if intr from I/O APIC */
     bb5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bb8:	83 f8 07             	cmp    eax,0x7
     bbb:	76 52                	jbe    c0f <irq_handler+0x67>
				isr = pic_get_isr();
     bbd:	e8 fc ff ff ff       	call   bbe <irq_handler+0x16>
     bc2:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
				if (!isr) { /* we have a PCI interrupt */
     bc6:	66 83 7d f2 00       	cmp    WORD PTR [ebp-0xe],0x0
     bcb:	75 42                	jne    c0f <irq_handler+0x67>
						iprintf("PCI IRQ %u\n", irq);
     bcd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bd0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     bd4:	c7 04 24 91 02 00 00 	mov    DWORD PTR [esp],0x291
     bdb:	e8 fc ff ff ff       	call   bdc <irq_handler+0x34>
						framebuffer_redraw(&fb_initial);
     be0:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     be7:	e8 fc ff ff ff       	call   be8 <irq_handler+0x40>
						forward_irq(irq);
     bec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bef:	89 04 24             	mov    DWORD PTR [esp],eax
     bf2:	e8 fc ff ff ff       	call   bf3 <irq_handler+0x4b>
						apic_reg(APIC_REG_EOI) = 0;
     bf7:	e8 04 f4 ff ff       	call   0 <per_cpu_ptr>
     bfc:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     bff:	05 b0 00 00 00       	add    eax,0xb0
     c04:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						return; /* don't signal the PIC */
     c0a:	e9 eb 00 00 00       	jmp    cfa <irq_handler+0x152>
		switch (irq) {
     c0f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c12:	83 f8 0f             	cmp    eax,0xf
     c15:	77 6c                	ja     c83 <irq_handler+0xdb>
     c17:	8b 04 85 a0 02 00 00 	mov    eax,DWORD PTR [eax*4+0x2a0]
     c1e:	ff e0                	jmp    eax
					if ((hook = irq0_hook))
     c20:	a1 00 00 00 00       	mov    eax,ds:0x0
     c25:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     c28:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     c2c:	74 05                	je     c33 <irq_handler+0x8b>
							hook();
     c2e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     c31:	ff d0                	call   eax
					ktimer_tick();
     c33:	e8 fc ff ff ff       	call   c34 <irq_handler+0x8c>
					break;
     c38:	eb 50                	jmp    c8a <irq_handler+0xe2>
					kbd_handler();
     c3a:	e8 fc ff ff ff       	call   c3b <irq_handler+0x93>
					break;
     c3f:	eb 49                	jmp    c8a <irq_handler+0xe2>
					com_interrupt(irq);
     c41:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c44:	89 04 24             	mov    DWORD PTR [esp],eax
     c47:	e8 fc ff ff ff       	call   c48 <irq_handler+0xa0>
					break;
     c4c:	eb 3c                	jmp    c8a <irq_handler+0xe2>
					if (!(pic_get_isr() & (1 << 7)))
     c4e:	e8 fc ff ff ff       	call   c4f <irq_handler+0xa7>
     c53:	0f b7 c0             	movzx  eax,ax
     c56:	25 80 00 00 00       	and    eax,0x80
     c5b:	85 c0                	test   eax,eax
     c5d:	75 27                	jne    c86 <irq_handler+0xde>
							spurious = 1;
     c5f:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
					break;
     c66:	eb 1e                	jmp    c86 <irq_handler+0xde>
					if (irq == 15 && !(pic_get_isr() & (1 << 15)))
     c68:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c6b:	83 f8 0f             	cmp    eax,0xf
     c6e:	75 19                	jne    c89 <irq_handler+0xe1>
     c70:	e8 fc ff ff ff       	call   c71 <irq_handler+0xc9>
     c75:	66 85 c0             	test   ax,ax
     c78:	78 0f                	js     c89 <irq_handler+0xe1>
							spurious = 1;
     c7a:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
					break;
     c81:	eb 06                	jmp    c89 <irq_handler+0xe1>
					break;
     c83:	90                   	nop
     c84:	eb 04                	jmp    c8a <irq_handler+0xe2>
					break;
     c86:	90                   	nop
     c87:	eb 01                	jmp    c8a <irq_handler+0xe2>
					break;
     c89:	90                   	nop
		if(!spurious && irq > 7) /* ack to slave if needed */
     c8a:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     c8e:	75 1c                	jne    cac <irq_handler+0x104>
     c90:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c93:	83 f8 07             	cmp    eax,0x7
     c96:	76 14                	jbe    cac <irq_handler+0x104>
				outb(PIC2, 0x20);
     c98:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
     ca0:	c7 04 24 a0 00 00 00 	mov    DWORD PTR [esp],0xa0
     ca7:	e8 75 f3 ff ff       	call   21 <outb>
		if (!spurious || irq > 7)
     cac:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     cb0:	74 08                	je     cba <irq_handler+0x112>
     cb2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cb5:	83 f8 07             	cmp    eax,0x7
     cb8:	76 14                	jbe    cce <irq_handler+0x126>
				outb(PIC1, 0x20); /* ack interrupt (even sp. from slave) */
     cba:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
     cc2:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
     cc9:	e8 53 f3 ff ff       	call   21 <outb>
		if (!spurious && irq)
     cce:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     cd2:	75 12                	jne    ce6 <irq_handler+0x13e>
     cd4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cd7:	85 c0                	test   eax,eax
     cd9:	74 0b                	je     ce6 <irq_handler+0x13e>
				forward_irq(irq);
     cdb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cde:	89 04 24             	mov    DWORD PTR [esp],eax
     ce1:	e8 fc ff ff ff       	call   ce2 <irq_handler+0x13a>
		if (!irq)
     ce6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ce9:	85 c0                	test   eax,eax
     ceb:	75 0d                	jne    cfa <irq_handler+0x152>
				task_schedule_isr(*(void**)(&irq + 1));
     ced:	8d 45 0c             	lea    eax,[ebp+0xc]
     cf0:	8b 00                	mov    eax,DWORD PTR [eax]
     cf2:	89 04 24             	mov    DWORD PTR [esp],eax
     cf5:	e8 fc ff ff ff       	call   cf6 <irq_handler+0x14e>
}
     cfa:	c9                   	leave
     cfb:	c3                   	ret

00000cfc <nmi_handler>:
{
     cfc:	55                   	push   ebp
     cfd:	89 e5                	mov    ebp,esp
     cff:	83 ec 38             	sub    esp,0x38
     d02:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     d05:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     d08:	88 55 e4             	mov    BYTE PTR [ebp-0x1c],dl
     d0b:	88 45 e0             	mov    BYTE PTR [ebp-0x20],al
		if (port_a & 0x10) {
     d0e:	0f b6 45 e0          	movzx  eax,BYTE PTR [ebp-0x20]
     d12:	83 e0 10             	and    eax,0x10
     d15:	85 c0                	test   eax,eax
     d17:	74 16                	je     d2f <nmi_handler+0x33>
				printf("NMI watchdog received\n");
     d19:	c7 04 24 e0 02 00 00 	mov    DWORD PTR [esp],0x2e0
     d20:	e8 fc ff ff ff       	call   d21 <nmi_handler+0x25>
				return 0;
     d25:	b8 00 00 00 00       	mov    eax,0x0
     d2a:	e9 9d 00 00 00       	jmp    dcc <nmi_handler+0xd0>
		if (port_b & 0x40)
     d2f:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
     d33:	83 e0 40             	and    eax,0x40
     d36:	85 c0                	test   eax,eax
     d38:	74 0e                	je     d48 <nmi_handler+0x4c>
				printf("Hardware bus channel error\n");
     d3a:	c7 04 24 f7 02 00 00 	mov    DWORD PTR [esp],0x2f7
     d41:	e8 fc ff ff ff       	call   d42 <nmi_handler+0x46>
     d46:	eb 32                	jmp    d7a <nmi_handler+0x7e>
		else if (port_b & 0x80)
     d48:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
     d4c:	84 c0                	test   al,al
     d4e:	79 0e                	jns    d5e <nmi_handler+0x62>
				printf("Memory read/write error\n");
     d50:	c7 04 24 13 03 00 00 	mov    DWORD PTR [esp],0x313
     d57:	e8 fc ff ff ff       	call   d58 <nmi_handler+0x5c>
     d5c:	eb 1c                	jmp    d7a <nmi_handler+0x7e>
				printf("Unknown NMI error A=%x, B=%x\n", port_a, port_b);
     d5e:	0f b6 55 e4          	movzx  edx,BYTE PTR [ebp-0x1c]
     d62:	0f b6 45 e0          	movzx  eax,BYTE PTR [ebp-0x20]
     d66:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     d6a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     d6e:	c7 04 24 2c 03 00 00 	mov    DWORD PTR [esp],0x32c
     d75:	e8 fc ff ff ff       	call   d76 <nmi_handler+0x7a>
		puts("restarting");
     d7a:	c7 04 24 4a 03 00 00 	mov    DWORD PTR [esp],0x34a
     d81:	e8 fc ff ff ff       	call   d82 <nmi_handler+0x86>
		for (i = 0; i < 3; i++) {
     d86:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     d8d:	eb 26                	jmp    db5 <nmi_handler+0xb9>
				for (j = 0; j < INT_MAX; j++);
     d8f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     d96:	eb 04                	jmp    d9c <nmi_handler+0xa0>
     d98:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     d9c:	81 7d f0 ff ff ff 7f 	cmp    DWORD PTR [ebp-0x10],0x7fffffff
     da3:	75 f3                	jne    d98 <nmi_handler+0x9c>
				putchar('.');
     da5:	c7 04 24 2e 00 00 00 	mov    DWORD PTR [esp],0x2e
     dac:	e8 fc ff ff ff       	call   dad <nmi_handler+0xb1>
		for (i = 0; i < 3; i++) {
     db1:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     db5:	83 7d f4 02          	cmp    DWORD PTR [ebp-0xc],0x2
     db9:	7e d4                	jle    d8f <nmi_handler+0x93>
		putchar('\n');
     dbb:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
     dc2:	e8 fc ff ff ff       	call   dc3 <nmi_handler+0xc7>
		return 1;
     dc7:	b8 01 00 00 00       	mov    eax,0x1
}
     dcc:	c9                   	leave
     dcd:	c3                   	ret

00000dce <segment_handler>:
{
     dce:	55                   	push   ebp
     dcf:	89 e5                	mov    ebp,esp
     dd1:	83 ec 38             	sub    esp,0x38
		const char* tp = "#UNKNOWN";
     dd4:	c7 45 f4 55 03 00 00 	mov    DWORD PTR [ebp-0xc],0x355
		switch(type) {
     ddb:	83 7d 14 04          	cmp    DWORD PTR [ebp+0x14],0x4
     ddf:	77 3b                	ja     e1c <segment_handler+0x4e>
     de1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     de4:	c1 e0 02             	shl    eax,0x2
     de7:	05 50 04 00 00       	add    eax,0x450
     dec:	8b 00                	mov    eax,DWORD PTR [eax]
     dee:	ff e0                	jmp    eax
				case 0: tp = "#TS"; break;
     df0:	c7 45 f4 5e 03 00 00 	mov    DWORD PTR [ebp-0xc],0x35e
     df7:	eb 23                	jmp    e1c <segment_handler+0x4e>
				case 1: tp = "#NP"; break;
     df9:	c7 45 f4 62 03 00 00 	mov    DWORD PTR [ebp-0xc],0x362
     e00:	eb 1a                	jmp    e1c <segment_handler+0x4e>
				case 2: tp = "#SS"; break;
     e02:	c7 45 f4 66 03 00 00 	mov    DWORD PTR [ebp-0xc],0x366
     e09:	eb 11                	jmp    e1c <segment_handler+0x4e>
				case 3: tp = "#GP"; break;
     e0b:	c7 45 f4 6a 03 00 00 	mov    DWORD PTR [ebp-0xc],0x36a
     e12:	eb 08                	jmp    e1c <segment_handler+0x4e>
				case 4: tp = "#PF"; break;
     e14:	c7 45 f4 6e 03 00 00 	mov    DWORD PTR [ebp-0xc],0x36e
     e1b:	90                   	nop
		while (type);
     e1c:	90                   	nop
     e1d:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     e21:	75 fa                	jne    e1d <segment_handler+0x4f>
		if (type == 4) {
     e23:	83 7d 14 04          	cmp    DWORD PTR [ebp+0x14],0x4
     e27:	75 29                	jne    e52 <segment_handler+0x84>
				if(mm_handle_pagefault(&mm_kernel, eip, seg_error, cr2) == 0)
     e29:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     e2c:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
     e30:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e33:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     e37:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e3a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     e3e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     e45:	e8 fc ff ff ff       	call   e46 <segment_handler+0x78>
     e4a:	85 c0                	test   eax,eax
     e4c:	0f 84 f3 00 00 00    	je     f45 <segment_handler+0x177>
		cprintf(KFMT_INFO, "Segment exception handler: %s at %p with error %x (cr2=%p)\n",
     e52:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     e55:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
     e59:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e5c:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
     e60:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e63:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
     e67:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e6a:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     e6e:	c7 44 24 04 74 03 00 00 	mov    DWORD PTR [esp+0x4],0x374
     e76:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
     e7d:	e8 fc ff ff ff       	call   e7e <segment_handler+0xb0>
		if (seg_error != 4) {
     e82:	83 7d 0c 04          	cmp    DWORD PTR [ebp+0xc],0x4
     e86:	0f 84 90 00 00 00    	je     f1c <segment_handler+0x14e>
					  (seg_error & 0xffff8) >> 3);
     e8c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e8f:	c1 e8 03             	shr    eax,0x3
				printf("The segment error originated %s and"
     e92:	25 ff ff 01 00       	and    eax,0x1ffff
     e97:	89 c2                	mov    edx,eax
						(seg_error & 2) ? "interrupt" : ((seg_error & 4) ? "local" : "global"),
     e99:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e9c:	83 e0 02             	and    eax,0x2
				printf("The segment error originated %s and"
     e9f:	85 c0                	test   eax,eax
     ea1:	75 18                	jne    ebb <segment_handler+0xed>
						(seg_error & 2) ? "interrupt" : ((seg_error & 4) ? "local" : "global"),
     ea3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ea6:	83 e0 04             	and    eax,0x4
     ea9:	85 c0                	test   eax,eax
     eab:	74 07                	je     eb4 <segment_handler+0xe6>
     ead:	b8 b0 03 00 00       	mov    eax,0x3b0
     eb2:	eb 0c                	jmp    ec0 <segment_handler+0xf2>
     eb4:	b8 b6 03 00 00       	mov    eax,0x3b6
     eb9:	eb 05                	jmp    ec0 <segment_handler+0xf2>
				printf("The segment error originated %s and"
     ebb:	b8 bd 03 00 00       	mov    eax,0x3bd
						(seg_error & 1) ? "external" : "internal",
     ec0:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
     ec3:	83 e1 01             	and    ecx,0x1
				printf("The segment error originated %s and"
     ec6:	85 c9                	test   ecx,ecx
     ec8:	74 07                	je     ed1 <segment_handler+0x103>
     eca:	b9 c7 03 00 00       	mov    ecx,0x3c7
     ecf:	eb 05                	jmp    ed6 <segment_handler+0x108>
     ed1:	b9 d0 03 00 00       	mov    ecx,0x3d0
     ed6:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     eda:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     ede:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
     ee2:	c7 04 24 dc 03 00 00 	mov    DWORD PTR [esp],0x3dc
     ee9:	e8 fc ff ff ff       	call   eea <segment_handler+0x11c>
				print_stacktrace();
     eee:	e8 fc ff ff ff       	call   eef <segment_handler+0x121>
				die("segment death\n");
     ef3:	c7 44 24 04 32 04 00 00 	mov    DWORD PTR [esp+0x4],0x432
     efb:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     f02:	e8 fc ff ff ff       	call   f03 <segment_handler+0x135>
     f07:	e8 fc ff ff ff       	call   f08 <segment_handler+0x13a>
     f0c:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     f13:	e8 fc ff ff ff       	call   f14 <segment_handler+0x146>
     f18:	fa                   	cli
     f19:	f4                   	hlt
     f1a:	eb fd                	jmp    f19 <segment_handler+0x14b>
				die("unfixable #PF\n");
     f1c:	c7 44 24 04 41 04 00 00 	mov    DWORD PTR [esp+0x4],0x441
     f24:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     f2b:	e8 fc ff ff ff       	call   f2c <segment_handler+0x15e>
     f30:	e8 fc ff ff ff       	call   f31 <segment_handler+0x163>
     f35:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     f3c:	e8 fc ff ff ff       	call   f3d <segment_handler+0x16f>
     f41:	fa                   	cli
     f42:	f4                   	hlt
     f43:	eb fd                	jmp    f42 <segment_handler+0x174>
						return; /* continue execution */
     f45:	90                   	nop
}
     f46:	c9                   	leave
     f47:	c3                   	ret

00000f48 <PIC_remap>:
{
     f48:	55                   	push   ebp
     f49:	89 e5                	mov    ebp,esp
     f4b:	53                   	push   ebx
     f4c:	83 ec 44             	sub    esp,0x44
     f4f:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     f52:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     f55:	88 55 e4             	mov    BYTE PTR [ebp-0x1c],dl
     f58:	88 45 e0             	mov    BYTE PTR [ebp-0x20],al
		a1 = inb(PIC1_DATA);                      /* save the masks */
     f5b:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
     f62:	e8 d9 f0 ff ff       	call   40 <inb>
     f67:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		a2 = inb(PIC2_DATA);
     f6a:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
     f71:	e8 ca f0 ff ff       	call   40 <inb>
     f76:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
		outb(PIC1_COMMAND, ICW1_INIT+ICW1_ICW4);  /* start the initialization */
     f79:	c7 44 24 04 11 00 00 00 	mov    DWORD PTR [esp+0x4],0x11
     f81:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
     f88:	e8 94 f0 ff ff       	call   21 <outb>
		io_wait();                                /* expects 3 control bytes */
     f8d:	e8 82 f0 ff ff       	call   14 <io_wait>
		outb(PIC2_COMMAND, ICW1_INIT+ICW1_ICW4);
     f92:	c7 44 24 04 11 00 00 00 	mov    DWORD PTR [esp+0x4],0x11
     f9a:	c7 04 24 a0 00 00 00 	mov    DWORD PTR [esp],0xa0
     fa1:	e8 7b f0 ff ff       	call   21 <outb>
		io_wait();
     fa6:	e8 69 f0 ff ff       	call   14 <io_wait>
		outb(PIC1_DATA, ofs1);                    /* master gate offset */
     fab:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
     faf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     fb3:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
     fba:	e8 62 f0 ff ff       	call   21 <outb>
		io_wait();
     fbf:	e8 50 f0 ff ff       	call   14 <io_wait>
		outb(PIC2_DATA, ofs2);                    /* slave gate offset */
     fc4:	0f b6 45 e0          	movzx  eax,BYTE PTR [ebp-0x20]
     fc8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     fcc:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
     fd3:	e8 49 f0 ff ff       	call   21 <outb>
		io_wait();
     fd8:	e8 37 f0 ff ff       	call   14 <io_wait>
		outb(PIC1_DATA, 4);                       /* tell master of the presence */
     fdd:	c7 44 24 04 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x4
     fe5:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
     fec:	e8 30 f0 ff ff       	call   21 <outb>
		io_wait();                                /* of slave at IRQ2 (1<<2) */
     ff1:	e8 1e f0 ff ff       	call   14 <io_wait>
		outb(PIC2_DATA, 2);                       /* tell slave it's second */
     ff6:	c7 44 24 04 02 00 00 00 	mov    DWORD PTR [esp+0x4],0x2
     ffe:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    1005:	e8 17 f0 ff ff       	call   21 <outb>
		io_wait();                                /* in cascade */
    100a:	e8 05 f0 ff ff       	call   14 <io_wait>
		outb(PIC1_DATA, ICW4_8086);               /* master in standard mode */
    100f:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
    1017:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    101e:	e8 fe ef ff ff       	call   21 <outb>
		io_wait();
    1023:	e8 ec ef ff ff       	call   14 <io_wait>
		outb(PIC2_DATA, ICW4_8086);               /* slave in standard mode */
    1028:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
    1030:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    1037:	e8 e5 ef ff ff       	call   21 <outb>
		io_wait();
    103c:	e8 d3 ef ff ff       	call   14 <io_wait>
		outb(PIC1_DATA, a1);                      /* restore saved masks */
    1041:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    1045:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1049:	c7 04 24 21 00 00 00 	mov    DWORD PTR [esp],0x21
    1050:	e8 cc ef ff ff       	call   21 <outb>
		outb(PIC2_DATA, a2);
    1055:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
    1059:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    105d:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    1064:	e8 b8 ef ff ff       	call   21 <outb>
		cprintf(KFMT_INFO, "PICs remapped to %x and %x with masks %x and %x\n",
    1069:	0f b6 5d f6          	movzx  ebx,BYTE PTR [ebp-0xa]
    106d:	0f b6 4d f7          	movzx  ecx,BYTE PTR [ebp-0x9]
    1071:	0f b6 55 e0          	movzx  edx,BYTE PTR [ebp-0x20]
    1075:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
    1079:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    107d:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    1081:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1085:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1089:	c7 44 24 04 64 04 00 00 	mov    DWORD PTR [esp+0x4],0x464
    1091:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    1098:	e8 fc ff ff ff       	call   1099 <PIC_remap+0x151>
}
    109d:	90                   	nop
    109e:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    10a1:	c9                   	leave
    10a2:	c3                   	ret

000010a3 <cmos_is_updating>:
{
    10a3:	55                   	push   ebp
    10a4:	89 e5                	mov    ebp,esp
    10a6:	83 ec 08             	sub    esp,0x8
		outb(CMOS_CH_INDEX, 0x0a);
    10a9:	c7 44 24 04 0a 00 00 00 	mov    DWORD PTR [esp+0x4],0xa
    10b1:	c7 04 24 70 00 00 00 	mov    DWORD PTR [esp],0x70
    10b8:	e8 64 ef ff ff       	call   21 <outb>
		return inb(CMOS_CH_DATA) & 0x80;
    10bd:	c7 04 24 71 00 00 00 	mov    DWORD PTR [esp],0x71
    10c4:	e8 77 ef ff ff       	call   40 <inb>
    10c9:	0f b6 c0             	movzx  eax,al
    10cc:	25 80 00 00 00       	and    eax,0x80
}
    10d1:	c9                   	leave
    10d2:	c3                   	ret

000010d3 <cmos_get_register>:
{
    10d3:	55                   	push   ebp
    10d4:	89 e5                	mov    ebp,esp
    10d6:	83 ec 0c             	sub    esp,0xc
    10d9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10dc:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		outb(CMOS_CH_INDEX, reg);
    10df:	0f b6 45 fc          	movzx  eax,BYTE PTR [ebp-0x4]
    10e3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    10e7:	c7 04 24 70 00 00 00 	mov    DWORD PTR [esp],0x70
    10ee:	e8 2e ef ff ff       	call   21 <outb>
		return inb(CMOS_CH_DATA);
    10f3:	c7 04 24 71 00 00 00 	mov    DWORD PTR [esp],0x71
    10fa:	e8 41 ef ff ff       	call   40 <inb>
}
    10ff:	c9                   	leave
    1100:	c3                   	ret

00001101 <cmos_get_time>:
{
    1101:	55                   	push   ebp
    1102:	89 e5                	mov    ebp,esp
    1104:	57                   	push   edi
    1105:	53                   	push   ebx
    1106:	83 ec 54             	sub    esp,0x54
		struct tm rv = {0}, rvb = {0};
    1109:	8d 55 cc             	lea    edx,[ebp-0x34]
    110c:	b8 00 00 00 00       	mov    eax,0x0
    1111:	b9 09 00 00 00       	mov    ecx,0x9
    1116:	89 d7                	mov    edi,edx
    1118:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    111a:	8d 55 a8             	lea    edx,[ebp-0x58]
    111d:	b8 00 00 00 00       	mov    eax,0x0
    1122:	b9 09 00 00 00       	mov    ecx,0x9
    1127:	89 d7                	mov    edi,edx
    1129:	f3 ab                	rep stos DWORD PTR es:[edi],eax
		struct tm* pt = &rv; uint8_t regB;
    112b:	8d 45 cc             	lea    eax,[ebp-0x34]
    112e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				while (cmos_is_updating()); /* busy spin (maybe called by ihander */
    1131:	90                   	nop
    1132:	e8 fc ff ff ff       	call   1133 <cmos_get_time+0x32>
    1137:	85 c0                	test   eax,eax
    1139:	75 f7                	jne    1132 <cmos_get_time+0x31>
				pt->tm_sec = cmos_get_register(0);
    113b:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1142:	e8 fc ff ff ff       	call   1143 <cmos_get_time+0x42>
    1147:	0f b6 d0             	movzx  edx,al
    114a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    114d:	89 10                	mov    DWORD PTR [eax],edx
				pt->tm_min = cmos_get_register(2);
    114f:	c7 04 24 02 00 00 00 	mov    DWORD PTR [esp],0x2
    1156:	e8 fc ff ff ff       	call   1157 <cmos_get_time+0x56>
    115b:	0f b6 d0             	movzx  edx,al
    115e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1161:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				pt->tm_hour = cmos_get_register(4);
    1164:	c7 04 24 04 00 00 00 	mov    DWORD PTR [esp],0x4
    116b:	e8 fc ff ff ff       	call   116c <cmos_get_time+0x6b>
    1170:	0f b6 d0             	movzx  edx,al
    1173:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1176:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
				pt->tm_wday = cmos_get_register(6);// - 1;
    1179:	c7 04 24 06 00 00 00 	mov    DWORD PTR [esp],0x6
    1180:	e8 fc ff ff ff       	call   1181 <cmos_get_time+0x80>
    1185:	0f b6 d0             	movzx  edx,al
    1188:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    118b:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				pt->tm_mday = cmos_get_register(7);
    118e:	c7 04 24 07 00 00 00 	mov    DWORD PTR [esp],0x7
    1195:	e8 fc ff ff ff       	call   1196 <cmos_get_time+0x95>
    119a:	0f b6 d0             	movzx  edx,al
    119d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11a0:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
				pt->tm_mon = cmos_get_register(8);
    11a3:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
    11aa:	e8 fc ff ff ff       	call   11ab <cmos_get_time+0xaa>
    11af:	0f b6 d0             	movzx  edx,al
    11b2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11b5:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
				pt->tm_year = cmos_get_register(9);
    11b8:	c7 04 24 09 00 00 00 	mov    DWORD PTR [esp],0x9
    11bf:	e8 fc ff ff ff       	call   11c0 <cmos_get_time+0xbf>
    11c4:	0f b6 d0             	movzx  edx,al
    11c7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11ca:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
				pt->tm_year |= (cmos_get_register(0x32) << 8); /* century or bogus data */
    11cd:	c7 04 24 32 00 00 00 	mov    DWORD PTR [esp],0x32
    11d4:	e8 fc ff ff ff       	call   11d5 <cmos_get_time+0xd4>
    11d9:	0f b6 c0             	movzx  eax,al
    11dc:	c1 e0 08             	shl    eax,0x8
    11df:	89 c2                	mov    edx,eax
    11e1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11e4:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    11e7:	09 c2                	or     edx,eax
    11e9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11ec:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
				if (pt == &rv)
    11ef:	8d 45 cc             	lea    eax,[ebp-0x34]
    11f2:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    11f5:	75 0b                	jne    1202 <cmos_get_time+0x101>
						pt = &rvb;
    11f7:	8d 45 a8             	lea    eax,[ebp-0x58]
    11fa:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    11fd:	e9 2f ff ff ff       	jmp    1131 <cmos_get_time+0x30>
				else if (rv.tm_sec != rvb.tm_sec ||
    1202:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1205:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    1208:	39 c2                	cmp    edx,eax
    120a:	75 3c                	jne    1248 <cmos_get_time+0x147>
								rv.tm_min != rvb.tm_min ||
    120c:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    120f:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
				else if (rv.tm_sec != rvb.tm_sec ||
    1212:	39 c2                	cmp    edx,eax
    1214:	75 32                	jne    1248 <cmos_get_time+0x147>
								rv.tm_hour != rvb.tm_hour ||
    1216:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1219:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
								rv.tm_min != rvb.tm_min ||
    121c:	39 c2                	cmp    edx,eax
    121e:	75 28                	jne    1248 <cmos_get_time+0x147>
								rv.tm_wday != rvb.tm_wday ||
    1220:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1223:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
								rv.tm_hour != rvb.tm_hour ||
    1226:	39 c2                	cmp    edx,eax
    1228:	75 1e                	jne    1248 <cmos_get_time+0x147>
								rv.tm_mday != rvb.tm_mday ||
    122a:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    122d:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
								rv.tm_wday != rvb.tm_wday ||
    1230:	39 c2                	cmp    edx,eax
    1232:	75 14                	jne    1248 <cmos_get_time+0x147>
								rv.tm_mon != rvb.tm_mon ||
    1234:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1237:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
								rv.tm_mday != rvb.tm_mday ||
    123a:	39 c2                	cmp    edx,eax
    123c:	75 0a                	jne    1248 <cmos_get_time+0x147>
								rv.tm_year != rvb.tm_year)
    123e:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    1241:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
								rv.tm_mon != rvb.tm_mon ||
    1244:	39 c2                	cmp    edx,eax
    1246:	74 0b                	je     1253 <cmos_get_time+0x152>
						pt = &rv;
    1248:	8d 45 cc             	lea    eax,[ebp-0x34]
    124b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				while (cmos_is_updating()); /* busy spin (maybe called by ihander */
    124e:	e9 de fe ff ff       	jmp    1131 <cmos_get_time+0x30>
		regB = cmos_get_register(0x0b);
    1253:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    125a:	e8 fc ff ff ff       	call   125b <cmos_get_time+0x15a>
    125f:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
		if (!(regB & 0x04)) {
    1262:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
    1266:	83 e0 04             	and    eax,0x4
    1269:	85 c0                	test   eax,eax
    126b:	0f 85 8a 01 00 00    	jne    13fb <cmos_get_time+0x2fa>
				pt->tm_sec = (pt->tm_sec & 0xf) + ((pt->tm_sec / 16) * 10);
    1271:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1274:	8b 00                	mov    eax,DWORD PTR [eax]
    1276:	83 e0 0f             	and    eax,0xf
    1279:	89 c1                	mov    ecx,eax
    127b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    127e:	8b 00                	mov    eax,DWORD PTR [eax]
    1280:	8d 50 0f             	lea    edx,[eax+0xf]
    1283:	85 c0                	test   eax,eax
    1285:	0f 48 c2             	cmovs  eax,edx
    1288:	c1 f8 04             	sar    eax,0x4
    128b:	89 c2                	mov    edx,eax
    128d:	89 d0                	mov    eax,edx
    128f:	c1 e0 02             	shl    eax,0x2
    1292:	01 d0                	add    eax,edx
    1294:	01 c0                	add    eax,eax
    1296:	8d 14 01             	lea    edx,[ecx+eax*1]
    1299:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    129c:	89 10                	mov    DWORD PTR [eax],edx
				pt->tm_min = (pt->tm_min & 0xf) + ((pt->tm_min / 16) * 10);
    129e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12a1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    12a4:	83 e0 0f             	and    eax,0xf
    12a7:	89 c1                	mov    ecx,eax
    12a9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12ac:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    12af:	8d 50 0f             	lea    edx,[eax+0xf]
    12b2:	85 c0                	test   eax,eax
    12b4:	0f 48 c2             	cmovs  eax,edx
    12b7:	c1 f8 04             	sar    eax,0x4
    12ba:	89 c2                	mov    edx,eax
    12bc:	89 d0                	mov    eax,edx
    12be:	c1 e0 02             	shl    eax,0x2
    12c1:	01 d0                	add    eax,edx
    12c3:	01 c0                	add    eax,eax
    12c5:	8d 14 01             	lea    edx,[ecx+eax*1]
    12c8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12cb:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				pt->tm_hour = (pt->tm_hour & 0x80) | ((pt->tm_hour & 0xf) + (((pt->tm_hour & 0x70) / 16) * 10));
    12ce:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12d1:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    12d4:	25 80 00 00 00       	and    eax,0x80
    12d9:	89 c1                	mov    ecx,eax
    12db:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12de:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    12e1:	83 e0 0f             	and    eax,0xf
    12e4:	89 c3                	mov    ebx,eax
    12e6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12e9:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    12ec:	83 e0 70             	and    eax,0x70
    12ef:	8d 50 0f             	lea    edx,[eax+0xf]
    12f2:	85 c0                	test   eax,eax
    12f4:	0f 48 c2             	cmovs  eax,edx
    12f7:	c1 f8 04             	sar    eax,0x4
    12fa:	89 c2                	mov    edx,eax
    12fc:	89 d0                	mov    eax,edx
    12fe:	c1 e0 02             	shl    eax,0x2
    1301:	01 d0                	add    eax,edx
    1303:	01 c0                	add    eax,eax
    1305:	01 d8                	add    eax,ebx
    1307:	09 c1                	or     ecx,eax
    1309:	89 ca                	mov    edx,ecx
    130b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    130e:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
				pt->tm_wday = (pt->tm_wday & 0xf) + ((pt->tm_wday / 16) * 10);
    1311:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1314:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1317:	83 e0 0f             	and    eax,0xf
    131a:	89 c1                	mov    ecx,eax
    131c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    131f:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1322:	8d 50 0f             	lea    edx,[eax+0xf]
    1325:	85 c0                	test   eax,eax
    1327:	0f 48 c2             	cmovs  eax,edx
    132a:	c1 f8 04             	sar    eax,0x4
    132d:	89 c2                	mov    edx,eax
    132f:	89 d0                	mov    eax,edx
    1331:	c1 e0 02             	shl    eax,0x2
    1334:	01 d0                	add    eax,edx
    1336:	01 c0                	add    eax,eax
    1338:	8d 14 01             	lea    edx,[ecx+eax*1]
    133b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    133e:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				pt->tm_mday = (pt->tm_mday & 0xf) + ((pt->tm_mday / 16) * 10);
    1341:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1344:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1347:	83 e0 0f             	and    eax,0xf
    134a:	89 c1                	mov    ecx,eax
    134c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    134f:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1352:	8d 50 0f             	lea    edx,[eax+0xf]
    1355:	85 c0                	test   eax,eax
    1357:	0f 48 c2             	cmovs  eax,edx
    135a:	c1 f8 04             	sar    eax,0x4
    135d:	89 c2                	mov    edx,eax
    135f:	89 d0                	mov    eax,edx
    1361:	c1 e0 02             	shl    eax,0x2
    1364:	01 d0                	add    eax,edx
    1366:	01 c0                	add    eax,eax
    1368:	8d 14 01             	lea    edx,[ecx+eax*1]
    136b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    136e:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
				pt->tm_mon = (pt->tm_mon & 0xf) + ((pt->tm_mon / 16) * 10);
    1371:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1374:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1377:	83 e0 0f             	and    eax,0xf
    137a:	89 c1                	mov    ecx,eax
    137c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    137f:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1382:	8d 50 0f             	lea    edx,[eax+0xf]
    1385:	85 c0                	test   eax,eax
    1387:	0f 48 c2             	cmovs  eax,edx
    138a:	c1 f8 04             	sar    eax,0x4
    138d:	89 c2                	mov    edx,eax
    138f:	89 d0                	mov    eax,edx
    1391:	c1 e0 02             	shl    eax,0x2
    1394:	01 d0                	add    eax,edx
    1396:	01 c0                	add    eax,eax
    1398:	8d 14 01             	lea    edx,[ecx+eax*1]
    139b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    139e:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
				pt->tm_year = ((pt->tm_year & 0xf) + ((pt->tm_year / 16) * 10))
    13a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13a4:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    13a7:	83 e0 0f             	and    eax,0xf
    13aa:	89 c1                	mov    ecx,eax
    13ac:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13af:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    13b2:	8d 50 0f             	lea    edx,[eax+0xf]
    13b5:	85 c0                	test   eax,eax
    13b7:	0f 48 c2             	cmovs  eax,edx
    13ba:	c1 f8 04             	sar    eax,0x4
    13bd:	89 c2                	mov    edx,eax
    13bf:	89 d0                	mov    eax,edx
    13c1:	c1 e0 02             	shl    eax,0x2
    13c4:	01 d0                	add    eax,edx
    13c6:	01 c0                	add    eax,eax
    13c8:	01 c1                	add    ecx,eax
						| ((((pt->tm_year & 0xf) >> 8) + ((((pt->tm_year & 0xf000) >> 8) / 16) * 10)) << 8);
    13ca:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13cd:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    13d0:	c1 f8 08             	sar    eax,0x8
    13d3:	25 f0 00 00 00       	and    eax,0xf0
    13d8:	8d 50 0f             	lea    edx,[eax+0xf]
    13db:	85 c0                	test   eax,eax
    13dd:	0f 48 c2             	cmovs  eax,edx
    13e0:	c1 f8 04             	sar    eax,0x4
    13e3:	89 c2                	mov    edx,eax
    13e5:	89 d0                	mov    eax,edx
    13e7:	c1 e0 02             	shl    eax,0x2
    13ea:	01 d0                	add    eax,edx
    13ec:	01 c0                	add    eax,eax
    13ee:	c1 e0 08             	shl    eax,0x8
    13f1:	09 c1                	or     ecx,eax
    13f3:	89 ca                	mov    edx,ecx
				pt->tm_year = ((pt->tm_year & 0xf) + ((pt->tm_year / 16) * 10))
    13f5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13f8:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		if (!(regB & 0x02) && (pt->tm_hour & 0x80))
    13fb:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
    13ff:	83 e0 02             	and    eax,0x2
    1402:	85 c0                	test   eax,eax
    1404:	75 41                	jne    1447 <cmos_get_time+0x346>
    1406:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1409:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    140c:	25 80 00 00 00       	and    eax,0x80
    1411:	85 c0                	test   eax,eax
    1413:	74 32                	je     1447 <cmos_get_time+0x346>
				pt->tm_hour = (((pt->tm_hour & 0x7f) + 12) % 24);
    1415:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1418:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    141b:	83 e0 7f             	and    eax,0x7f
    141e:	8d 48 0c             	lea    ecx,[eax+0xc]
    1421:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    1426:	89 c8                	mov    eax,ecx
    1428:	f7 ea                	imul   edx
    142a:	c1 fa 02             	sar    edx,0x2
    142d:	89 c8                	mov    eax,ecx
    142f:	c1 f8 1f             	sar    eax,0x1f
    1432:	29 c2                	sub    edx,eax
    1434:	89 d0                	mov    eax,edx
    1436:	01 c0                	add    eax,eax
    1438:	01 d0                	add    eax,edx
    143a:	c1 e0 03             	shl    eax,0x3
    143d:	29 c1                	sub    ecx,eax
    143f:	89 ca                	mov    edx,ecx
    1441:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1444:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		pt->tm_year = 100 * ((pt->tm_year & 0xff00) >> 8) + (pt->tm_year & 0xff);
    1447:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    144a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    144d:	c1 f8 08             	sar    eax,0x8
    1450:	0f b6 c0             	movzx  eax,al
    1453:	6b d0 64             	imul   edx,eax,0x64
    1456:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1459:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    145c:	0f b6 c0             	movzx  eax,al
    145f:	01 c2                	add    edx,eax
    1461:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1464:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pt->tm_year -= 1900;
    1467:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    146a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    146d:	8d 90 94 f8 ff ff    	lea    edx,[eax-0x76c]
    1473:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1476:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pt->tm_yday = pt->tm_mday - 1;
    1479:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    147c:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    147f:	8d 50 ff             	lea    edx,[eax-0x1]
    1482:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1485:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		pt->tm_mon -= 1;
    1488:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    148b:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    148e:	8d 50 ff             	lea    edx,[eax-0x1]
    1491:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1494:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		if (IS_LEAP_YEAR(pt->tm_year + 1900))
    1497:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    149a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    149d:	3d 95 f8 ff ff       	cmp    eax,0xfffff895
    14a2:	0f 8c 8a 00 00 00    	jl     1532 <cmos_get_time+0x431>
    14a8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    14ab:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    14ae:	05 6c 07 00 00       	add    eax,0x76c
    14b3:	83 e0 03             	and    eax,0x3
    14b6:	85 c0                	test   eax,eax
    14b8:	75 78                	jne    1532 <cmos_get_time+0x431>
    14ba:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    14bd:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    14c0:	8d 88 6c 07 00 00    	lea    ecx,[eax+0x76c]
    14c6:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    14cb:	89 c8                	mov    eax,ecx
    14cd:	f7 ea                	imul   edx
    14cf:	89 d0                	mov    eax,edx
    14d1:	c1 f8 05             	sar    eax,0x5
    14d4:	89 ca                	mov    edx,ecx
    14d6:	c1 fa 1f             	sar    edx,0x1f
    14d9:	29 d0                	sub    eax,edx
    14db:	6b d0 64             	imul   edx,eax,0x64
    14de:	89 c8                	mov    eax,ecx
    14e0:	29 d0                	sub    eax,edx
    14e2:	85 c0                	test   eax,eax
    14e4:	75 2f                	jne    1515 <cmos_get_time+0x414>
    14e6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    14e9:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    14ec:	8d 88 6c 07 00 00    	lea    ecx,[eax+0x76c]
    14f2:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    14f7:	89 c8                	mov    eax,ecx
    14f9:	f7 ea                	imul   edx
    14fb:	89 d0                	mov    eax,edx
    14fd:	c1 f8 07             	sar    eax,0x7
    1500:	89 ca                	mov    edx,ecx
    1502:	c1 fa 1f             	sar    edx,0x1f
    1505:	29 d0                	sub    eax,edx
    1507:	69 d0 90 01 00 00    	imul   edx,eax,0x190
    150d:	89 c8                	mov    eax,ecx
    150f:	29 d0                	sub    eax,edx
    1511:	85 c0                	test   eax,eax
    1513:	75 1d                	jne    1532 <cmos_get_time+0x431>
				pt->tm_yday += dayct_lp[pt->tm_mon];
    1515:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1518:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    151b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    151e:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1521:	8b 04 85 60 10 00 00 	mov    eax,DWORD PTR [eax*4+0x1060]
    1528:	01 c2                	add    edx,eax
    152a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    152d:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
    1530:	eb 1b                	jmp    154d <cmos_get_time+0x44c>
				pt->tm_yday += dayct_nl[pt->tm_mon];
    1532:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1535:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    1538:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    153b:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    153e:	8b 04 85 a0 10 00 00 	mov    eax,DWORD PTR [eax*4+0x10a0]
    1545:	01 c2                	add    edx,eax
    1547:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    154a:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		return *pt;
    154d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1550:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1553:	8b 0a                	mov    ecx,DWORD PTR [edx]
    1555:	89 08                	mov    DWORD PTR [eax],ecx
    1557:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
    155a:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
    155d:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
    1560:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    1563:	8b 4a 0c             	mov    ecx,DWORD PTR [edx+0xc]
    1566:	89 48 0c             	mov    DWORD PTR [eax+0xc],ecx
    1569:	8b 4a 10             	mov    ecx,DWORD PTR [edx+0x10]
    156c:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
    156f:	8b 4a 14             	mov    ecx,DWORD PTR [edx+0x14]
    1572:	89 48 14             	mov    DWORD PTR [eax+0x14],ecx
    1575:	8b 4a 18             	mov    ecx,DWORD PTR [edx+0x18]
    1578:	89 48 18             	mov    DWORD PTR [eax+0x18],ecx
    157b:	8b 4a 1c             	mov    ecx,DWORD PTR [edx+0x1c]
    157e:	89 48 1c             	mov    DWORD PTR [eax+0x1c],ecx
    1581:	8b 52 20             	mov    edx,DWORD PTR [edx+0x20]
    1584:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
}
    1587:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    158a:	83 c4 54             	add    esp,0x54
    158d:	5b                   	pop    ebx
    158e:	5f                   	pop    edi
    158f:	5d                   	pop    ebp
    1590:	c2 04 00             	ret    0x4

00001593 <kernel_fb_resize>:
{
    1593:	55                   	push   ebp
    1594:	89 e5                	mov    ebp,esp
		km_regS.x = fb_initial.width - 20;
    1596:	a1 04 00 00 00       	mov    eax,ds:0x4
    159b:	83 e8 14             	sub    eax,0x14
    159e:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		km_regC.x = fb_initial.width - 20;
    15a4:	a1 04 00 00 00       	mov    eax,ds:0x4
    15a9:	83 e8 14             	sub    eax,0x14
    15ac:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		km_regC.y = fb_initial.height - 2;
    15b2:	a1 08 00 00 00       	mov    eax,ds:0x8
    15b7:	83 e8 02             	sub    eax,0x2
    15ba:	66 a3 02 00 00 00    	mov    ds:0x2,ax
}
    15c0:	90                   	nop
    15c1:	5d                   	pop    ebp
    15c2:	c3                   	ret

000015c3 <second_tick>:
{
    15c3:	55                   	push   ebp
    15c4:	89 e5                	mov    ebp,esp
    15c6:	57                   	push   edi
    15c7:	56                   	push   esi
    15c8:	53                   	push   ebx
    15c9:	81 ec dc 00 00 00    	sub    esp,0xdc
		if(((jiffies - km_set) > CMOS_THRESHOLD)) {
    15cf:	a1 00 00 00 00       	mov    eax,ds:0x0
    15d4:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    15d7:	8b 00                	mov    eax,DWORD PTR [eax]
    15d9:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    15df:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    15e5:	29 c8                	sub    eax,ecx
    15e7:	19 da                	sbb    edx,ebx
    15e9:	bb 90 a5 06 00       	mov    ebx,0x6a590
    15ee:	b9 00 00 00 00       	mov    ecx,0x0
    15f3:	39 c3                	cmp    ebx,eax
    15f5:	19 d1                	sbb    ecx,edx
    15f7:	0f 83 89 00 00 00    	jae    1686 <second_tick+0xc3>
				km_time = cmos_get_time();
    15fd:	8d 85 58 ff ff ff    	lea    eax,[ebp-0xa8]
    1603:	89 04 24             	mov    DWORD PTR [esp],eax
    1606:	e8 fc ff ff ff       	call   1607 <second_tick+0x44>
    160b:	83 ec 04             	sub    esp,0x4
    160e:	8b 85 58 ff ff ff    	mov    eax,DWORD PTR [ebp-0xa8]
    1614:	a3 00 00 00 00       	mov    ds:0x0,eax
    1619:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [ebp-0xa4]
    161f:	a3 04 00 00 00       	mov    ds:0x4,eax
    1624:	8b 85 60 ff ff ff    	mov    eax,DWORD PTR [ebp-0xa0]
    162a:	a3 08 00 00 00       	mov    ds:0x8,eax
    162f:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [ebp-0x9c]
    1635:	a3 0c 00 00 00       	mov    ds:0xc,eax
    163a:	8b 85 68 ff ff ff    	mov    eax,DWORD PTR [ebp-0x98]
    1640:	a3 10 00 00 00       	mov    ds:0x10,eax
    1645:	8b 85 6c ff ff ff    	mov    eax,DWORD PTR [ebp-0x94]
    164b:	a3 14 00 00 00       	mov    ds:0x14,eax
    1650:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [ebp-0x90]
    1656:	a3 18 00 00 00       	mov    ds:0x18,eax
    165b:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [ebp-0x8c]
    1661:	a3 1c 00 00 00       	mov    ds:0x1c,eax
    1666:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [ebp-0x88]
    166c:	a3 20 00 00 00       	mov    ds:0x20,eax
				km_set = jiffies;
    1671:	a1 00 00 00 00       	mov    eax,ds:0x0
    1676:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1679:	8b 00                	mov    eax,DWORD PTR [eax]
    167b:	a3 00 00 00 00       	mov    ds:0x0,eax
    1680:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		task_do_stats();
    1686:	e8 fc ff ff ff       	call   1687 <second_tick+0xc4>
				uint64_t scs = jiffies / HZ;
    168b:	a1 00 00 00 00       	mov    eax,ds:0x0
    1690:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1693:	8b 00                	mov    eax,DWORD PTR [eax]
    1695:	c7 44 24 08 79 00 00 00 	mov    DWORD PTR [esp+0x8],0x79
    169d:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    16a5:	89 04 24             	mov    DWORD PTR [esp],eax
    16a8:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    16ac:	e8 fc ff ff ff       	call   16ad <second_tick+0xea>
    16b1:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    16b4:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
				uint32_t secs = 0, mins = 0, hrs = 0, days = 0;
    16b7:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    16be:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    16c5:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    16cc:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
				km_regS.cur_x = 4;
    16d3:	66 c7 05 0e 00 00 00 04 00 	mov    WORD PTR ds:0xe,0x4
				km_regS.cur_y = 2;
    16dc:	66 c7 05 10 00 00 00 02 00 	mov    WORD PTR ds:0x10,0x2
				days = (uint32_t)(scs / 86400); //.0
    16e5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    16e8:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    16eb:	c7 44 24 08 80 51 01 00 	mov    DWORD PTR [esp+0x8],0x15180
    16f3:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    16fb:	89 04 24             	mov    DWORD PTR [esp],eax
    16fe:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1702:	e8 fc ff ff ff       	call   1703 <second_tick+0x140>
    1707:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				scs -= 86400 * days;
    170a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    170d:	69 c0 80 51 01 00    	imul   eax,eax,0x15180
    1713:	ba 00 00 00 00       	mov    edx,0x0
    1718:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
    171b:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
				hrs = (uint32_t)(scs / 3600);
    171e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1721:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1724:	c7 44 24 08 10 0e 00 00 	mov    DWORD PTR [esp+0x8],0xe10
    172c:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    1734:	89 04 24             	mov    DWORD PTR [esp],eax
    1737:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    173b:	e8 fc ff ff ff       	call   173c <second_tick+0x179>
    1740:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				scs -= 3600 * hrs;
    1743:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1746:	69 c0 10 0e 00 00    	imul   eax,eax,0xe10
    174c:	ba 00 00 00 00       	mov    edx,0x0
    1751:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
    1754:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
				mins = (uint32_t)(scs / 60);
    1757:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    175a:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    175d:	c7 44 24 08 3c 00 00 00 	mov    DWORD PTR [esp+0x8],0x3c
    1765:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    176d:	89 04 24             	mov    DWORD PTR [esp],eax
    1770:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1774:	e8 fc ff ff ff       	call   1775 <second_tick+0x1b2>
    1779:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				scs -= 60 * mins;
    177c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    177f:	6b c0 3c             	imul   eax,eax,0x3c
    1782:	ba 00 00 00 00       	mov    edx,0x0
    1787:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
    178a:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
				secs = (uint32_t)(scs);
    178d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1790:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				if (secs != old_sc) {
    1793:	a1 e4 01 00 00       	mov    eax,ds:0x1e4
    1798:	39 45 d4             	cmp    DWORD PTR [ebp-0x2c],eax
    179b:	74 40                	je     17dd <second_tick+0x21a>
						crprintf(0x2f, &km_regS, "%ud %uh %um %us\n", days, hrs, mins, secs);
    179d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    17a0:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    17a4:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    17a7:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    17ab:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    17ae:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    17b2:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    17b5:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    17b9:	c7 44 24 08 95 04 00 00 	mov    DWORD PTR [esp+0x8],0x495
    17c1:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    17c9:	c7 04 24 2f 00 00 00 	mov    DWORD PTR [esp],0x2f
    17d0:	e8 fc ff ff ff       	call   17d1 <second_tick+0x20e>
						old_sc = secs;
    17d5:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    17d8:	a3 e4 01 00 00       	mov    ds:0x1e4,eax
				km_regS.cur_x = 0;
    17dd:	66 c7 05 0e 00 00 00 00 00 	mov    WORD PTR ds:0xe,0x0
				km_regS.cur_y = 3;
    17e6:	66 c7 05 10 00 00 00 03 00 	mov    WORD PTR ds:0x10,0x3
				if (km_time.tm_year) {
    17ef:	a1 14 00 00 00       	mov    eax,ds:0x14
    17f4:	85 c0                	test   eax,eax
    17f6:	0f 84 51 02 00 00    	je     1a4d <second_tick+0x48a>
						uint32_t adsec = ((uint64_t)(jiffies - km_set) / HZ);
    17fc:	a1 00 00 00 00       	mov    eax,ds:0x0
    1801:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1804:	8b 00                	mov    eax,DWORD PTR [eax]
    1806:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    180c:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    1812:	29 c8                	sub    eax,ecx
    1814:	19 da                	sbb    edx,ebx
    1816:	c7 44 24 08 79 00 00 00 	mov    DWORD PTR [esp+0x8],0x79
    181e:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    1826:	89 04 24             	mov    DWORD PTR [esp],eax
    1829:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    182d:	e8 fc ff ff ff       	call   182e <second_tick+0x26b>
    1832:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
						struct tm ta = km_time;
    1835:	a1 00 00 00 00       	mov    eax,ds:0x0
    183a:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
    183d:	a1 04 00 00 00       	mov    eax,ds:0x4
    1842:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    1845:	a1 08 00 00 00       	mov    eax,ds:0x8
    184a:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
    184d:	a1 0c 00 00 00       	mov    eax,ds:0xc
    1852:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    1855:	a1 10 00 00 00       	mov    eax,ds:0x10
    185a:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
    185d:	a1 14 00 00 00       	mov    eax,ds:0x14
    1862:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    1865:	a1 18 00 00 00       	mov    eax,ds:0x18
    186a:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
    186d:	a1 1c 00 00 00       	mov    eax,ds:0x1c
    1872:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    1875:	a1 20 00 00 00       	mov    eax,ds:0x20
    187a:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
						ta.tm_sec += adsec;
    187d:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    1880:	89 c2                	mov    edx,eax
    1882:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1885:	01 d0                	add    eax,edx
    1887:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
						if (ta.tm_sec > 59) {
    188a:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    188d:	83 f8 3b             	cmp    eax,0x3b
    1890:	7e 47                	jle    18d9 <second_tick+0x316>
								ta.tm_min += ta.tm_sec / 60;
    1892:	8b 5d 98             	mov    ebx,DWORD PTR [ebp-0x68]
    1895:	8b 4d 94             	mov    ecx,DWORD PTR [ebp-0x6c]
    1898:	ba 89 88 88 88       	mov    edx,0x88888889
    189d:	89 c8                	mov    eax,ecx
    189f:	f7 ea                	imul   edx
    18a1:	8d 04 0a             	lea    eax,[edx+ecx*1]
    18a4:	c1 f8 05             	sar    eax,0x5
    18a7:	89 c2                	mov    edx,eax
    18a9:	89 c8                	mov    eax,ecx
    18ab:	c1 f8 1f             	sar    eax,0x1f
    18ae:	29 c2                	sub    edx,eax
    18b0:	8d 04 13             	lea    eax,[ebx+edx*1]
    18b3:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
								ta.tm_sec %= 60;
    18b6:	8b 4d 94             	mov    ecx,DWORD PTR [ebp-0x6c]
    18b9:	ba 89 88 88 88       	mov    edx,0x88888889
    18be:	89 c8                	mov    eax,ecx
    18c0:	f7 ea                	imul   edx
    18c2:	8d 04 0a             	lea    eax,[edx+ecx*1]
    18c5:	c1 f8 05             	sar    eax,0x5
    18c8:	89 ca                	mov    edx,ecx
    18ca:	c1 fa 1f             	sar    edx,0x1f
    18cd:	29 d0                	sub    eax,edx
    18cf:	6b d0 3c             	imul   edx,eax,0x3c
    18d2:	89 c8                	mov    eax,ecx
    18d4:	29 d0                	sub    eax,edx
    18d6:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
						if (ta.tm_min > 59) {
    18d9:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    18dc:	83 f8 3b             	cmp    eax,0x3b
    18df:	7e 47                	jle    1928 <second_tick+0x365>
								ta.tm_hour += ta.tm_min / 60;
    18e1:	8b 5d 9c             	mov    ebx,DWORD PTR [ebp-0x64]
    18e4:	8b 4d 98             	mov    ecx,DWORD PTR [ebp-0x68]
    18e7:	ba 89 88 88 88       	mov    edx,0x88888889
    18ec:	89 c8                	mov    eax,ecx
    18ee:	f7 ea                	imul   edx
    18f0:	8d 04 0a             	lea    eax,[edx+ecx*1]
    18f3:	c1 f8 05             	sar    eax,0x5
    18f6:	89 c2                	mov    edx,eax
    18f8:	89 c8                	mov    eax,ecx
    18fa:	c1 f8 1f             	sar    eax,0x1f
    18fd:	29 c2                	sub    edx,eax
    18ff:	8d 04 13             	lea    eax,[ebx+edx*1]
    1902:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
								ta.tm_min %= 60;
    1905:	8b 4d 98             	mov    ecx,DWORD PTR [ebp-0x68]
    1908:	ba 89 88 88 88       	mov    edx,0x88888889
    190d:	89 c8                	mov    eax,ecx
    190f:	f7 ea                	imul   edx
    1911:	8d 04 0a             	lea    eax,[edx+ecx*1]
    1914:	c1 f8 05             	sar    eax,0x5
    1917:	89 ca                	mov    edx,ecx
    1919:	c1 fa 1f             	sar    edx,0x1f
    191c:	29 d0                	sub    eax,edx
    191e:	6b d0 3c             	imul   edx,eax,0x3c
    1921:	89 c8                	mov    eax,ecx
    1923:	29 d0                	sub    eax,edx
    1925:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
						if (ta.tm_hour > 23) {
    1928:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    192b:	83 f8 17             	cmp    eax,0x17
    192e:	0f 8e 83 00 00 00    	jle    19b7 <second_tick+0x3f4>
								ta.tm_mday += ta.tm_hour / 24;
    1934:	8b 5d a0             	mov    ebx,DWORD PTR [ebp-0x60]
    1937:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    193a:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    193f:	89 c8                	mov    eax,ecx
    1941:	f7 ea                	imul   edx
    1943:	c1 fa 02             	sar    edx,0x2
    1946:	89 c8                	mov    eax,ecx
    1948:	c1 f8 1f             	sar    eax,0x1f
    194b:	29 c2                	sub    edx,eax
    194d:	8d 04 13             	lea    eax,[ebx+edx*1]
    1950:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
								ta.tm_wday += ta.tm_hour / 24;
    1953:	8b 5d ac             	mov    ebx,DWORD PTR [ebp-0x54]
    1956:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    1959:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    195e:	89 c8                	mov    eax,ecx
    1960:	f7 ea                	imul   edx
    1962:	c1 fa 02             	sar    edx,0x2
    1965:	89 c8                	mov    eax,ecx
    1967:	c1 f8 1f             	sar    eax,0x1f
    196a:	29 c2                	sub    edx,eax
    196c:	8d 04 13             	lea    eax,[ebx+edx*1]
    196f:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
								ta.tm_yday += ta.tm_hour / 24;
    1972:	8b 5d b0             	mov    ebx,DWORD PTR [ebp-0x50]
    1975:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    1978:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    197d:	89 c8                	mov    eax,ecx
    197f:	f7 ea                	imul   edx
    1981:	c1 fa 02             	sar    edx,0x2
    1984:	89 c8                	mov    eax,ecx
    1986:	c1 f8 1f             	sar    eax,0x1f
    1989:	29 c2                	sub    edx,eax
    198b:	8d 04 13             	lea    eax,[ebx+edx*1]
    198e:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
								ta.tm_hour %= 24;
    1991:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    1994:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    1999:	89 c8                	mov    eax,ecx
    199b:	f7 ea                	imul   edx
    199d:	c1 fa 02             	sar    edx,0x2
    19a0:	89 c8                	mov    eax,ecx
    19a2:	c1 f8 1f             	sar    eax,0x1f
    19a5:	29 c2                	sub    edx,eax
    19a7:	89 d0                	mov    eax,edx
    19a9:	01 c0                	add    eax,eax
    19ab:	01 d0                	add    eax,edx
    19ad:	c1 e0 03             	shl    eax,0x3
    19b0:	29 c1                	sub    ecx,eax
    19b2:	89 ca                	mov    edx,ecx
    19b4:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
						if (ta.tm_wday > 6) {
    19b7:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    19ba:	83 f8 06             	cmp    eax,0x6
    19bd:	7e 27                	jle    19e6 <second_tick+0x423>
								ta.tm_wday %= 7;
    19bf:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    19c2:	ba 93 24 49 92       	mov    edx,0x92492493
    19c7:	89 c8                	mov    eax,ecx
    19c9:	f7 ea                	imul   edx
    19cb:	8d 04 0a             	lea    eax,[edx+ecx*1]
    19ce:	c1 f8 02             	sar    eax,0x2
    19d1:	89 ca                	mov    edx,ecx
    19d3:	c1 fa 1f             	sar    edx,0x1f
    19d6:	29 d0                	sub    eax,edx
    19d8:	89 c2                	mov    edx,eax
    19da:	c1 e2 03             	shl    edx,0x3
    19dd:	29 c2                	sub    edx,eax
    19df:	89 c8                	mov    eax,ecx
    19e1:	29 d0                	sub    eax,edx
    19e3:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
						if (adsec)
    19e6:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
    19ea:	74 61                	je     1a4d <second_tick+0x48a>
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    19ec:	8b 7d 94             	mov    edi,DWORD PTR [ebp-0x6c]
    19ef:	8b 75 98             	mov    esi,DWORD PTR [ebp-0x68]
    19f2:	8b 5d 9c             	mov    ebx,DWORD PTR [ebp-0x64]
    19f5:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    19f8:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
										ta.tm_mon + 1, ta.tm_mday,
    19fb:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    19fe:	83 c0 01             	add    eax,0x1
    1a01:	89 85 54 ff ff ff    	mov    DWORD PTR [ebp-0xac],eax
										1900 + ta.tm_year,
    1a07:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1a0a:	05 6c 07 00 00       	add    eax,0x76c
    1a0f:	89 7c 24 24          	mov    DWORD PTR [esp+0x24],edi
    1a13:	89 74 24 20          	mov    DWORD PTR [esp+0x20],esi
    1a17:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    1a1b:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    1a1f:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    1a23:	8b b5 54 ff ff ff    	mov    esi,DWORD PTR [ebp-0xac]
    1a29:	89 74 24 10          	mov    DWORD PTR [esp+0x10],esi
    1a2d:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1a31:	c7 44 24 08 a8 04 00 00 	mov    DWORD PTR [esp+0x8],0x4a8
    1a39:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1a41:	c7 04 24 2f 00 00 00 	mov    DWORD PTR [esp],0x2f
    1a48:	e8 fc ff ff ff       	call   1a49 <second_tick+0x486>
				const uint16_t gran = 10;
    1a4d:	66 c7 45 c2 0a 00    	mov    WORD PTR [ebp-0x3e],0xa
				l_k = 1 + (gran * cpu_pcs[0].vals[1]) / 100;
    1a53:	0f b7 55 c2          	movzx  edx,WORD PTR [ebp-0x3e]
    1a57:	a1 00 00 00 00       	mov    eax,ds:0x0
    1a5c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1a5f:	0f af c2             	imul   eax,edx
    1a62:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    1a67:	f7 e2                	mul    edx
    1a69:	89 d0                	mov    eax,edx
    1a6b:	c1 e8 05             	shr    eax,0x5
    1a6e:	83 c0 01             	add    eax,0x1
    1a71:	66 89 45 c0          	mov    WORD PTR [ebp-0x40],ax
				l_n = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3])) / 100;
    1a75:	0f b7 45 c2          	movzx  eax,WORD PTR [ebp-0x3e]
    1a79:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1a7f:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
    1a82:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1a88:	8b 52 0c             	mov    edx,DWORD PTR [edx+0xc]
    1a8b:	01 ca                	add    edx,ecx
    1a8d:	0f af c2             	imul   eax,edx
    1a90:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    1a95:	f7 e2                	mul    edx
    1a97:	89 d0                	mov    eax,edx
    1a99:	c1 e8 05             	shr    eax,0x5
    1a9c:	83 c0 01             	add    eax,0x1
    1a9f:	66 89 45 be          	mov    WORD PTR [ebp-0x42],ax
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1aa3:	0f b7 45 c2          	movzx  eax,WORD PTR [ebp-0x3e]
    1aa7:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1aad:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
    1ab0:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1ab6:	8b 52 0c             	mov    edx,DWORD PTR [edx+0xc]
    1ab9:	01 d1                	add    ecx,edx
										+ cpu_pcs[0].vals[2])) / 100;
    1abb:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1ac1:	8b 52 08             	mov    edx,DWORD PTR [edx+0x8]
    1ac4:	01 ca                	add    edx,ecx
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1ac6:	0f af c2             	imul   eax,edx
										+ cpu_pcs[0].vals[2])) / 100;
    1ac9:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    1ace:	f7 e2                	mul    edx
    1ad0:	89 d0                	mov    eax,edx
    1ad2:	c1 e8 05             	shr    eax,0x5
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1ad5:	83 c0 01             	add    eax,0x1
    1ad8:	66 89 45 bc          	mov    WORD PTR [ebp-0x44],ax
				putc_prc(&km_regC, KFMT_NORMAL, '[', 0, 0);
    1adc:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    1ae4:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    1aec:	c7 44 24 08 5b 00 00 00 	mov    DWORD PTR [esp+0x8],0x5b
    1af4:	c7 44 24 04 0f 00 00 00 	mov    DWORD PTR [esp+0x4],0xf
    1afc:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1b03:	e8 fc ff ff ff       	call   1b04 <second_tick+0x541>
				putc_prc(&km_regC, KFMT_NORMAL, ']', 11, 0);
    1b08:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    1b10:	c7 44 24 0c 0b 00 00 00 	mov    DWORD PTR [esp+0xc],0xb
    1b18:	c7 44 24 08 5d 00 00 00 	mov    DWORD PTR [esp+0x8],0x5d
    1b20:	c7 44 24 04 0f 00 00 00 	mov    DWORD PTR [esp+0x4],0xf
    1b28:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1b2f:	e8 fc ff ff ff       	call   1b30 <second_tick+0x56d>
				for (uint16_t i = 1; i < 1 + gran; i++) {
    1b34:	66 c7 45 e4 01 00    	mov    WORD PTR [ebp-0x1c],0x1
    1b3a:	e9 e2 00 00 00       	jmp    1c21 <second_tick+0x65e>
						if (i < l_k)
    1b3f:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b43:	66 3b 45 c0          	cmp    ax,WORD PTR [ebp-0x40]
    1b47:	73 31                	jae    1b7a <second_tick+0x5b7>
								putc_prc(&km_regC, KFMT_ERROR, '|', i, 0);
    1b49:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b4d:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    1b55:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1b59:	c7 44 24 08 7c 00 00 00 	mov    DWORD PTR [esp+0x8],0x7c
    1b61:	c7 44 24 04 0c 00 00 00 	mov    DWORD PTR [esp+0x4],0xc
    1b69:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1b70:	e8 fc ff ff ff       	call   1b71 <second_tick+0x5ae>
    1b75:	e9 9c 00 00 00       	jmp    1c16 <second_tick+0x653>
						else if (i < l_n)
    1b7a:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b7e:	66 3b 45 be          	cmp    ax,WORD PTR [ebp-0x42]
    1b82:	73 2e                	jae    1bb2 <second_tick+0x5ef>
								putc_prc(&km_regC, KFMT_WARN, '|', i, 0);
    1b84:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b88:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    1b90:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1b94:	c7 44 24 08 7c 00 00 00 	mov    DWORD PTR [esp+0x8],0x7c
    1b9c:	c7 44 24 04 0e 00 00 00 	mov    DWORD PTR [esp+0x4],0xe
    1ba4:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1bab:	e8 fc ff ff ff       	call   1bac <second_tick+0x5e9>
    1bb0:	eb 64                	jmp    1c16 <second_tick+0x653>
						else if (i < l_u)
    1bb2:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1bb6:	66 3b 45 bc          	cmp    ax,WORD PTR [ebp-0x44]
    1bba:	73 2e                	jae    1bea <second_tick+0x627>
								putc_prc(&km_regC, KFMT_INFO, '|', i, 0);
    1bbc:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1bc0:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    1bc8:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1bcc:	c7 44 24 08 7c 00 00 00 	mov    DWORD PTR [esp+0x8],0x7c
    1bd4:	c7 44 24 04 0b 00 00 00 	mov    DWORD PTR [esp+0x4],0xb
    1bdc:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1be3:	e8 fc ff ff ff       	call   1be4 <second_tick+0x621>
    1be8:	eb 2c                	jmp    1c16 <second_tick+0x653>
								putc_prc(&km_regC, KFMT_NORMAL, ' ', i, 0);
    1bea:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1bee:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    1bf6:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1bfa:	c7 44 24 08 20 00 00 00 	mov    DWORD PTR [esp+0x8],0x20
    1c02:	c7 44 24 04 0f 00 00 00 	mov    DWORD PTR [esp+0x4],0xf
    1c0a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1c11:	e8 fc ff ff ff       	call   1c12 <second_tick+0x64f>
				for (uint16_t i = 1; i < 1 + gran; i++) {
    1c16:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1c1a:	83 c0 01             	add    eax,0x1
    1c1d:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
    1c21:	0f b7 45 c2          	movzx  eax,WORD PTR [ebp-0x3e]
    1c25:	66 3b 45 e4          	cmp    ax,WORD PTR [ebp-0x1c]
    1c29:	0f 83 10 ff ff ff    	jae    1b3f <second_tick+0x57c>
				km_regC.cur_y = 0;
    1c2f:	66 c7 05 10 00 00 00 00 00 	mov    WORD PTR ds:0x10,0x0
				km_regC.cur_x = 2 + gran;
    1c38:	0f b7 45 c2          	movzx  eax,WORD PTR [ebp-0x3e]
    1c3c:	83 c0 02             	add    eax,0x2
    1c3f:	66 a3 0e 00 00 00    	mov    ds:0xe,ax
				pc_a = min(100, 100 - cpu_pcs[0].vals[0] - ((cpu_pcs[0].vals[4] > 0)
    1c45:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c4a:	8b 10                	mov    edx,DWORD PTR [eax]
    1c4c:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c51:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c54:	85 c0                	test   eax,eax
    1c56:	74 07                	je     1c5f <second_tick+0x69c>
    1c58:	b8 01 00 00 00       	mov    eax,0x1
    1c5d:	eb 05                	jmp    1c64 <second_tick+0x6a1>
    1c5f:	b8 00 00 00 00       	mov    eax,0x0
    1c64:	01 d0                	add    eax,edx
    1c66:	83 f8 64             	cmp    eax,0x64
    1c69:	77 2c                	ja     1c97 <second_tick+0x6d4>
    1c6b:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c70:	8b 00                	mov    eax,DWORD PTR [eax]
    1c72:	89 c2                	mov    edx,eax
    1c74:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c79:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c7c:	85 c0                	test   eax,eax
    1c7e:	74 07                	je     1c87 <second_tick+0x6c4>
    1c80:	b8 01 00 00 00       	mov    eax,0x1
    1c85:	eb 05                	jmp    1c8c <second_tick+0x6c9>
    1c87:	b8 00 00 00 00       	mov    eax,0x0
    1c8c:	01 c2                	add    edx,eax
    1c8e:	b8 64 00 00 00       	mov    eax,0x64
    1c93:	29 d0                	sub    eax,edx
    1c95:	eb 05                	jmp    1c9c <second_tick+0x6d9>
    1c97:	b8 64 00 00 00       	mov    eax,0x64
    1c9c:	66 89 45 ba          	mov    WORD PTR [ebp-0x46],ax
				pc_b = min(9, 10 - cpu_pcs[0].vals[4]);
    1ca0:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ca5:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
    1ca8:	b8 0a 00 00 00       	mov    eax,0xa
    1cad:	29 d0                	sub    eax,edx
    1caf:	ba 09 00 00 00       	mov    edx,0x9
    1cb4:	39 d0                	cmp    eax,edx
    1cb6:	0f 47 c2             	cmova  eax,edx
    1cb9:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
				if (pc_a == 100)
    1cbd:	66 83 7d ba 64       	cmp    WORD PTR [ebp-0x46],0x64
    1cc2:	75 06                	jne    1cca <second_tick+0x707>
						pc_b = 0;
    1cc4:	66 c7 45 e6 00 00    	mov    WORD PTR [ebp-0x1a],0x0
				crprintf(KFMT_NORMAL, &km_regC, "%3u.%1u%%", pc_a, pc_b);
    1cca:	0f b7 55 e6          	movzx  edx,WORD PTR [ebp-0x1a]
    1cce:	0f b7 45 ba          	movzx  eax,WORD PTR [ebp-0x46]
    1cd2:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    1cd6:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1cda:	c7 44 24 08 cf 04 00 00 	mov    DWORD PTR [esp+0x8],0x4cf
    1ce2:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1cea:	c7 04 24 0f 00 00 00 	mov    DWORD PTR [esp],0xf
    1cf1:	e8 fc ff ff ff       	call   1cf2 <second_tick+0x72f>
}
    1cf6:	90                   	nop
    1cf7:	8d 65 f4             	lea    esp,[ebp-0xc]
    1cfa:	5b                   	pop    ebx
    1cfb:	5e                   	pop    esi
    1cfc:	5f                   	pop    edi
    1cfd:	5d                   	pop    ebp
    1cfe:	c3                   	ret

00001cff <print_counter>:
{
    1cff:	55                   	push   ebp
    1d00:	89 e5                	mov    ebp,esp
    1d02:	57                   	push   edi
    1d03:	56                   	push   esi
    1d04:	53                   	push   ebx
    1d05:	83 ec 3c             	sub    esp,0x3c
		extern uint64_t fb_rdt; uint64_t rdt; const char* tp = "";
    1d08:	c7 45 dc d9 04 00 00 	mov    DWORD PTR [ebp-0x24],0x4d9
		if (counter_print == jiffies) /* limit the updates */
    1d0f:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d14:	8b 08                	mov    ecx,DWORD PTR [eax]
    1d16:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1d19:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d1e:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1d24:	89 cf                	mov    edi,ecx
    1d26:	89 c6                	mov    esi,eax
    1d28:	89 d9                	mov    ecx,ebx
    1d2a:	89 f8                	mov    eax,edi
    1d2c:	31 f0                	xor    eax,esi
    1d2e:	31 ca                	xor    edx,ecx
    1d30:	09 d0                	or     eax,edx
    1d32:	0f 84 07 03 00 00    	je     203f <print_counter+0x340>
		counter_print = jiffies;
    1d38:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d3d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1d40:	8b 00                	mov    eax,DWORD PTR [eax]
    1d42:	a3 00 00 00 00       	mov    ds:0x0,eax
    1d47:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		if (tsc_per_ms) {
    1d4d:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d52:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1d58:	89 c1                	mov    ecx,eax
    1d5a:	89 c8                	mov    eax,ecx
    1d5c:	09 d0                	or     eax,edx
    1d5e:	0f 84 d2 00 00 00    	je     1e36 <print_counter+0x137>
				tp = " ns";
    1d64:	c7 45 dc da 04 00 00 	mov    DWORD PTR [ebp-0x24],0x4da
				rdt = fb_rdt * 1000000 / tsc_per_ms;
    1d6b:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d70:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1d76:	69 da 40 42 0f 00    	imul   ebx,edx,0xf4240
    1d7c:	6b c8 00             	imul   ecx,eax,0x0
    1d7f:	01 d9                	add    ecx,ebx
    1d81:	bb 40 42 0f 00       	mov    ebx,0xf4240
    1d86:	f7 e3                	mul    ebx
    1d88:	01 d1                	add    ecx,edx
    1d8a:	89 ca                	mov    edx,ecx
    1d8c:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1d92:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    1d98:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    1d9c:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    1da0:	89 04 24             	mov    DWORD PTR [esp],eax
    1da3:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1da7:	e8 fc ff ff ff       	call   1da8 <print_counter+0xa9>
    1dac:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1daf:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				if (rdt > 99999) {
    1db2:	ba 9f 86 01 00       	mov    edx,0x1869f
    1db7:	b8 00 00 00 00       	mov    eax,0x0
    1dbc:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
    1dbf:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
    1dc2:	73 2f                	jae    1df3 <print_counter+0xf4>
						rdt /= 1000;
    1dc4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1dc7:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1dca:	c7 44 24 08 e8 03 00 00 	mov    DWORD PTR [esp+0x8],0x3e8
    1dd2:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    1dda:	89 04 24             	mov    DWORD PTR [esp],eax
    1ddd:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1de1:	e8 fc ff ff ff       	call   1de2 <print_counter+0xe3>
    1de6:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1de9:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						tp = " mu";
    1dec:	c7 45 dc de 04 00 00 	mov    DWORD PTR [ebp-0x24],0x4de
				}
				if (rdt > 99999) {
    1df3:	ba 9f 86 01 00       	mov    edx,0x1869f
    1df8:	b8 00 00 00 00       	mov    eax,0x0
    1dfd:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
    1e00:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
    1e03:	73 42                	jae    1e47 <print_counter+0x148>
						rdt /= 1000;
    1e05:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1e08:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1e0b:	c7 44 24 08 e8 03 00 00 	mov    DWORD PTR [esp+0x8],0x3e8
    1e13:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    1e1b:	89 04 24             	mov    DWORD PTR [esp],eax
    1e1e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1e22:	e8 fc ff ff ff       	call   1e23 <print_counter+0x124>
    1e27:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1e2a:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						tp = " ms";
    1e2d:	c7 45 dc e2 04 00 00 	mov    DWORD PTR [ebp-0x24],0x4e2
    1e34:	eb 11                	jmp    1e47 <print_counter+0x148>
				}
		} else
				rdt = fb_rdt;
    1e36:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e3b:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1e41:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1e44:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		km_regC.cur_x = 0; km_regC.cur_y = 1;
    1e47:	66 c7 05 0e 00 00 00 00 00 	mov    WORD PTR ds:0xe,0x0
    1e50:	66 c7 05 10 00 00 00 01 00 	mov    WORD PTR ds:0x10,0x1
		rprintf(&km_regC, "%7llu: %7llu%s", counter_print, rdt, tp);
    1e59:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e5e:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1e64:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    1e67:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    1e6b:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    1e6e:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
    1e71:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    1e75:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    1e79:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1e7d:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1e81:	c7 44 24 04 e6 04 00 00 	mov    DWORD PTR [esp+0x4],0x4e6
    1e89:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1e90:	e8 fc ff ff ff       	call   1e91 <print_counter+0x192>
		if ((jiffies - counter_sec) > HZ || !counter_sec) {
    1e95:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e9a:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1e9d:	8b 00                	mov    eax,DWORD PTR [eax]
    1e9f:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1ea5:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    1eab:	29 c8                	sub    eax,ecx
    1ead:	19 da                	sbb    edx,ebx
    1eaf:	bb 79 00 00 00       	mov    ebx,0x79
    1eb4:	b9 00 00 00 00       	mov    ecx,0x0
    1eb9:	39 c3                	cmp    ebx,eax
    1ebb:	19 d1                	sbb    ecx,edx
    1ebd:	72 13                	jb     1ed2 <print_counter+0x1d3>
    1ebf:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ec4:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1eca:	89 c1                	mov    ecx,eax
    1ecc:	89 c8                	mov    eax,ecx
    1ece:	09 d0                	or     eax,edx
    1ed0:	75 4b                	jne    1f1d <print_counter+0x21e>
				if (!counter_sec)
    1ed2:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ed7:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1edd:	89 c1                	mov    ecx,eax
    1edf:	89 c8                	mov    eax,ecx
    1ee1:	09 d0                	or     eax,edx
    1ee3:	75 17                	jne    1efc <print_counter+0x1fd>
						counter_sec = jiffies;
    1ee5:	a1 00 00 00 00       	mov    eax,ds:0x0
    1eea:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1eed:	8b 00                	mov    eax,DWORD PTR [eax]
    1eef:	a3 00 00 00 00       	mov    ds:0x0,eax
    1ef4:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
    1efa:	eb 1c                	jmp    1f18 <print_counter+0x219>
				else
						counter_sec += HZ;
    1efc:	a1 00 00 00 00       	mov    eax,ds:0x0
    1f01:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1f07:	83 c0 79             	add    eax,0x79
    1f0a:	83 d2 00             	adc    edx,0x0
    1f0d:	a3 00 00 00 00       	mov    ds:0x0,eax
    1f12:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
				second_tick();
    1f18:	e8 fc ff ff ff       	call   1f19 <print_counter+0x21a>
		}

		/* update memory stats faster than every second! really? */
		km_regS.cur_x = 0;
    1f1d:	66 c7 05 0e 00 00 00 00 00 	mov    WORD PTR ds:0xe,0x0
		km_regS.cur_y = 1;
    1f26:	66 c7 05 10 00 00 00 01 00 	mov    WORD PTR ds:0x10,0x1
		
		void kstats(size_t* s_total, size_t* s_commit,
					   	size_t* s_free, size_t* s_nheaps);
		kstats(h_stats, h_stats + 1, h_stats + 2, h_stats + 3);
    1f2f:	b9 0c 00 00 00       	mov    ecx,0xc
    1f34:	ba 08 00 00 00       	mov    edx,0x8
    1f39:	b8 04 00 00 00       	mov    eax,0x4
    1f3e:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1f42:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1f46:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1f4a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1f51:	e8 fc ff ff ff       	call   1f52 <print_counter+0x253>
		for (size_t i = 0; i < 4; i++)
    1f56:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    1f5d:	e9 d1 00 00 00       	jmp    2033 <print_counter+0x334>
				if (h_stats_old[i] != h_stats[i]) {
    1f62:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1f65:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    1f6c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1f6f:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1f76:	39 c2                	cmp    edx,eax
    1f78:	0f 84 b1 00 00 00    	je     202f <print_counter+0x330>
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
								h_stats[3], (h_stats[2]) / 1024);
    1f7e:	a1 08 00 00 00       	mov    eax,ds:0x8
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    1f83:	c1 e8 0a             	shr    eax,0xa
    1f86:	89 c6                	mov    esi,eax
    1f88:	8b 0d 0c 00 00 00    	mov    ecx,DWORD PTR ds:0xc
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
    1f8e:	a1 04 00 00 00       	mov    eax,ds:0x4
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    1f93:	3d 9f 86 01 00       	cmp    eax,0x1869f
    1f98:	77 1a                	ja     1fb4 <print_counter+0x2b5>
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
    1f9a:	a1 04 00 00 00       	mov    eax,ds:0x4
    1f9f:	3d 0f 27 00 00       	cmp    eax,0x270f
    1fa4:	76 07                	jbe    1fad <print_counter+0x2ae>
    1fa6:	ba d9 04 00 00       	mov    edx,0x4d9
    1fab:	eb 0c                	jmp    1fb9 <print_counter+0x2ba>
    1fad:	ba f5 04 00 00       	mov    edx,0x4f5
    1fb2:	eb 05                	jmp    1fb9 <print_counter+0x2ba>
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    1fb4:	ba f7 04 00 00       	mov    edx,0x4f7
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
    1fb9:	a1 04 00 00 00       	mov    eax,ds:0x4
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    1fbe:	3d 9f 86 01 00       	cmp    eax,0x1869f
    1fc3:	76 0a                	jbe    1fcf <print_counter+0x2d0>
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
    1fc5:	a1 04 00 00 00       	mov    eax,ds:0x4
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    1fca:	c1 e8 0a             	shr    eax,0xa
    1fcd:	eb 05                	jmp    1fd4 <print_counter+0x2d5>
    1fcf:	a1 04 00 00 00       	mov    eax,ds:0x4
    1fd4:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
    1fda:	c1 eb 0a             	shr    ebx,0xa
    1fdd:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    1fe1:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    1fe5:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    1fe9:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1fed:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    1ff1:	c7 44 24 08 f9 04 00 00 	mov    DWORD PTR [esp+0x8],0x4f9
    1ff9:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2001:	c7 04 24 2f 00 00 00 	mov    DWORD PTR [esp],0x2f
    2008:	e8 fc ff ff ff       	call   2009 <print_counter+0x30a>
						for (; i < 4; i++)
    200d:	eb 18                	jmp    2027 <print_counter+0x328>
								h_stats_old[i] = h_stats[i];
    200f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2012:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    2019:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    201c:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						for (; i < 4; i++)
    2023:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    2027:	83 7d d8 03          	cmp    DWORD PTR [ebp-0x28],0x3
    202b:	76 e2                	jbe    200f <print_counter+0x310>
						break;
    202d:	eb 11                	jmp    2040 <print_counter+0x341>
		for (size_t i = 0; i < 4; i++)
    202f:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    2033:	83 7d d8 03          	cmp    DWORD PTR [ebp-0x28],0x3
    2037:	0f 86 25 ff ff ff    	jbe    1f62 <print_counter+0x263>
    203d:	eb 01                	jmp    2040 <print_counter+0x341>
				return;
    203f:	90                   	nop
				}
}
    2040:	83 c4 3c             	add    esp,0x3c
    2043:	5b                   	pop    ebx
    2044:	5e                   	pop    esi
    2045:	5f                   	pop    edi
    2046:	5d                   	pop    ebp
    2047:	c3                   	ret

00002048 <ktimer_tick>:

/* this is the workhorse used for time-keeping */
void ktimer_tick()
{
    2048:	55                   	push   ebp
    2049:	89 e5                	mov    ebp,esp
    204b:	83 ec 18             	sub    esp,0x18
		extern uint64_t fb_udc;
		extern uint64_t fb_rdc;
		extern uint64_t fb_rdt;
		/* timekeeping */
		jiffies++;
    204e:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    2054:	8b 01                	mov    eax,DWORD PTR [ecx]
    2056:	8b 51 04             	mov    edx,DWORD PTR [ecx+0x4]
    2059:	83 c0 01             	add    eax,0x1
    205c:	83 d2 00             	adc    edx,0x0
    205f:	89 01                	mov    DWORD PTR [ecx],eax
    2061:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		if (irq0_hook) /* don't starve bogo_mips calculation */
    2064:	a1 00 00 00 00       	mov    eax,ds:0x0
    2069:	85 c0                	test   eax,eax
    206b:	75 38                	jne    20a5 <ktimer_tick+0x5d>
				return;

		static volatile int redr = 0;
		extern int preempt_needs_init;
		if (preempt_needs_init && !redr--) {
    206d:	a1 00 00 00 00       	mov    eax,ds:0x0
    2072:	85 c0                	test   eax,eax
    2074:	74 30                	je     20a6 <ktimer_tick+0x5e>
    2076:	a1 e8 01 00 00       	mov    eax,ds:0x1e8
    207b:	8d 50 ff             	lea    edx,[eax-0x1]
    207e:	89 15 e8 01 00 00    	mov    DWORD PTR ds:0x1e8,edx
    2084:	85 c0                	test   eax,eax
    2086:	75 1e                	jne    20a6 <ktimer_tick+0x5e>
				redr = 10;
    2088:	c7 05 e8 01 00 00 0a 00 00 00 	mov    DWORD PTR ds:0x1e8,0xa
				print_counter();
    2092:	e8 fc ff ff ff       	call   2093 <ktimer_tick+0x4b>
				framebuffer_redraw_updates(&fb_initial);
    2097:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    209e:	e8 fc ff ff ff       	call   209f <ktimer_tick+0x57>
    20a3:	eb 01                	jmp    20a6 <ktimer_tick+0x5e>
				return;
    20a5:	90                   	nop
		}
}
    20a6:	c9                   	leave
    20a7:	c3                   	ret

000020a8 <kredraw>:

void kredraw(void* data)
{
    20a8:	55                   	push   ebp
    20a9:	89 e5                	mov    ebp,esp
    20ab:	83 ec 18             	sub    esp,0x18
		while (1) {
				extern struct wait_queue_head wq_timer;
				print_counter();
    20ae:	e8 fc ff ff ff       	call   20af <kredraw+0x7>
				//asm("cli");
				preempt_disable();
    20b3:	e8 fc ff ff ff       	call   20b4 <kredraw+0xc>
    20b8:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    20bb:	83 c2 01             	add    edx,0x1
    20be:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				framebuffer_redraw_updates(&fb_initial);
    20c1:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    20c8:	e8 fc ff ff ff       	call   20c9 <kredraw+0x21>
				preempt_enable_no_resched();
    20cd:	e8 fc ff ff ff       	call   20ce <kredraw+0x26>
    20d2:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    20d5:	83 ea 01             	sub    edx,0x1
    20d8:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				//asm("sti");
				wait_timeout(&wq_timer, HZ / 60);
    20db:	c7 44 24 04 02 00 00 00 	mov    DWORD PTR [esp+0x4],0x2
    20e3:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    20ea:	e8 fc ff ff ff       	call   20eb <kredraw+0x43>
		while (1) {
    20ef:	90                   	nop
    20f0:	eb bc                	jmp    20ae <kredraw+0x6>

000020f2 <clock_gettime>:
		}
}

int clock_gettime(clockid_t clk_id, struct timespec* tp)
{
    20f2:	55                   	push   ebp
    20f3:	89 e5                	mov    ebp,esp
    20f5:	57                   	push   edi
    20f6:	56                   	push   esi
    20f7:	53                   	push   ebx
    20f8:	83 ec 5c             	sub    esp,0x5c
		if (!tp || clk_id != CLOCK_REALTIME) {
    20fb:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    20ff:	74 06                	je     2107 <clock_gettime+0x15>
    2101:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    2105:	74 14                	je     211b <clock_gettime+0x29>
				errno = EINVAL;
    2107:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    2111:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2116:	e9 db 01 00 00       	jmp    22f6 <clock_gettime+0x204>
		}
		/* query the cmos for REALTIME if needed */
		if (!km_set) {
    211b:	a1 00 00 00 00       	mov    eax,ds:0x0
    2120:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    2126:	89 c1                	mov    ecx,eax
    2128:	89 c8                	mov    eax,ecx
    212a:	09 d0                	or     eax,edx
    212c:	75 6b                	jne    2199 <clock_gettime+0xa7>
				km_time = cmos_get_time();
    212e:	8d 45 a8             	lea    eax,[ebp-0x58]
    2131:	89 04 24             	mov    DWORD PTR [esp],eax
    2134:	e8 fc ff ff ff       	call   2135 <clock_gettime+0x43>
    2139:	83 ec 04             	sub    esp,0x4
    213c:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    213f:	a3 00 00 00 00       	mov    ds:0x0,eax
    2144:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2147:	a3 04 00 00 00       	mov    ds:0x4,eax
    214c:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    214f:	a3 08 00 00 00       	mov    ds:0x8,eax
    2154:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    2157:	a3 0c 00 00 00       	mov    ds:0xc,eax
    215c:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    215f:	a3 10 00 00 00       	mov    ds:0x10,eax
    2164:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2167:	a3 14 00 00 00       	mov    ds:0x14,eax
    216c:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    216f:	a3 18 00 00 00       	mov    ds:0x18,eax
    2174:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2177:	a3 1c 00 00 00       	mov    ds:0x1c,eax
    217c:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    217f:	a3 20 00 00 00       	mov    ds:0x20,eax
				km_set = jiffies;
    2184:	a1 00 00 00 00       	mov    eax,ds:0x0
    2189:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    218c:	8b 00                	mov    eax,DWORD PTR [eax]
    218e:	a3 00 00 00 00       	mov    ds:0x0,eax
    2193:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		}
		tp->tv_nsec = 0;
    2199:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    219c:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
				ct |= (uint16_t)inb(PIT1_CH0) << 8;
				ct = (uint16_t)(PIT_FREQ / CLOCKS_PER_SEC) - ct;
				tp->tv_nsec += (long)((double)(uint32_t)ct * 1000000 / PIT_FREQ);
		}
		/* calculate the number of leap days since 1970 */
		time_t diff = jiffies - km_set;
    21a3:	a1 00 00 00 00       	mov    eax,ds:0x0
    21a8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    21ab:	8b 00                	mov    eax,DWORD PTR [eax]
    21ad:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    21b3:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    21b9:	29 c8                	sub    eax,ecx
    21bb:	19 da                	sbb    edx,ebx
    21bd:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    21c0:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		tp->tv_nsec = diff - (time_t)((time_t)(diff / CLOCKS_PER_SEC) * CLOCKS_PER_SEC);
    21c3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    21c6:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    21c9:	c7 44 24 08 87 ff ff ff 	mov    DWORD PTR [esp+0x8],0xffffff87
    21d1:	c7 44 24 0c ff ff ff ff 	mov    DWORD PTR [esp+0xc],0xffffffff
    21d9:	89 04 24             	mov    DWORD PTR [esp],eax
    21dc:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    21e0:	e8 fc ff ff ff       	call   21e1 <clock_gettime+0xef>
    21e5:	6b d0 79             	imul   edx,eax,0x79
    21e8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    21eb:	01 d0                	add    eax,edx
    21ed:	89 c2                	mov    edx,eax
    21ef:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21f2:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		tp->tv_nsec = (long)((tp->tv_nsec * 1000000) / CLOCKS_PER_SEC);
    21f5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21f8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    21fb:	69 c0 40 42 0f 00    	imul   eax,eax,0xf4240
    2201:	89 c1                	mov    ecx,eax
    2203:	ba bf 56 cf 0e       	mov    edx,0xecf56bf
    2208:	89 c8                	mov    eax,ecx
    220a:	f7 e2                	mul    edx
    220c:	89 c8                	mov    eax,ecx
    220e:	29 d0                	sub    eax,edx
    2210:	d1 e8                	shr    eax,1
    2212:	01 d0                	add    eax,edx
    2214:	c1 e8 06             	shr    eax,0x6
    2217:	89 c2                	mov    edx,eax
    2219:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    221c:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    221f:	a1 14 00 00 00       	mov    eax,ds:0x14
    2224:	05 6b 07 00 00       	add    eax,0x76b
    2229:	69 d8 6d 01 00 00    	imul   ebx,eax,0x16d
    222f:	a1 14 00 00 00       	mov    eax,ds:0x14
    2234:	05 6b 07 00 00       	add    eax,0x76b
    2239:	8d 50 03             	lea    edx,[eax+0x3]
    223c:	85 c0                	test   eax,eax
    223e:	0f 48 c2             	cmovs  eax,edx
    2241:	c1 f8 02             	sar    eax,0x2
    2244:	89 c6                	mov    esi,eax
    2246:	a1 14 00 00 00       	mov    eax,ds:0x14
    224b:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
    2251:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    2256:	89 c8                	mov    eax,ecx
    2258:	f7 ea                	imul   edx
    225a:	89 d0                	mov    eax,edx
    225c:	c1 f8 05             	sar    eax,0x5
    225f:	c1 f9 1f             	sar    ecx,0x1f
    2262:	89 ca                	mov    edx,ecx
    2264:	29 c2                	sub    edx,eax
    2266:	01 d6                	add    esi,edx
    2268:	a1 14 00 00 00       	mov    eax,ds:0x14
    226d:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
    2273:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    2278:	89 c8                	mov    eax,ecx
    227a:	f7 ea                	imul   edx
    227c:	c1 fa 07             	sar    edx,0x7
    227f:	89 c8                	mov    eax,ecx
    2281:	c1 f8 1f             	sar    eax,0x1f
    2284:	29 c2                	sub    edx,eax
    2286:	8d 04 16             	lea    eax,[esi+edx*1]
    2289:	01 d8                	add    eax,ebx
    228b:	8d 90 c6 06 f5 ff    	lea    edx,[eax-0xaf93a]
						+ km_time.tm_yday) + 3600 * km_time.tm_hour
    2291:	a1 1c 00 00 00       	mov    eax,ds:0x1c
    2296:	01 d0                	add    eax,edx
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    2298:	69 d0 80 51 01 00    	imul   edx,eax,0x15180
						+ km_time.tm_yday) + 3600 * km_time.tm_hour
    229e:	a1 08 00 00 00       	mov    eax,ds:0x8
    22a3:	69 c0 10 0e 00 00    	imul   eax,eax,0xe10
    22a9:	01 c2                	add    edx,eax
						+ 60 * km_time.tm_min + km_time.tm_sec
    22ab:	a1 04 00 00 00       	mov    eax,ds:0x4
    22b0:	6b c0 3c             	imul   eax,eax,0x3c
    22b3:	01 c2                	add    edx,eax
    22b5:	a1 00 00 00 00       	mov    eax,ds:0x0
    22ba:	01 d0                	add    eax,edx
    22bc:	89 c6                	mov    esi,eax
    22be:	89 c7                	mov    edi,eax
    22c0:	c1 ff 1f             	sar    edi,0x1f
						+ (time_t)(diff / CLOCKS_PER_SEC);
    22c3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    22c6:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    22c9:	c7 44 24 08 79 00 00 00 	mov    DWORD PTR [esp+0x8],0x79
    22d1:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    22d9:	89 04 24             	mov    DWORD PTR [esp],eax
    22dc:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    22e0:	e8 fc ff ff ff       	call   22e1 <clock_gettime+0x1ef>
    22e5:	01 f0                	add    eax,esi
    22e7:	11 fa                	adc    edx,edi
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    22e9:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    22ec:	89 01                	mov    DWORD PTR [ecx],eax
    22ee:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return 0;
    22f1:	b8 00 00 00 00       	mov    eax,0x0
}
    22f6:	8d 65 f4             	lea    esp,[ebp-0xc]
    22f9:	5b                   	pop    ebx
    22fa:	5e                   	pop    esi
    22fb:	5f                   	pop    edi
    22fc:	5d                   	pop    ebp
    22fd:	c3                   	ret

000022fe <hook_fun.0>:
void calibrate_bogo_mips(uint16_t pit_div)
{
		static uint32_t ct = 0, old_ct = 0, delta[8] = {0}, ni = 0;
		static uint64_t ts_delta[8], ts_ct = 0;
		uint32_t limit = 0x00f00000; /* very low for QEMU-software emu */
		void hook_fun() {
    22fe:	55                   	push   ebp
    22ff:	89 e5                	mov    ebp,esp
    2301:	83 ec 04             	sub    esp,0x4
    2304:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
				ni++;
    2307:	a1 ec 01 00 00       	mov    eax,ds:0x1ec
    230c:	83 c0 01             	add    eax,0x1
    230f:	a3 ec 01 00 00       	mov    ds:0x1ec,eax
				if (old_ct && ni <= 9) {
    2314:	a1 f0 01 00 00       	mov    eax,ds:0x1f0
    2319:	85 c0                	test   eax,eax
    231b:	74 4d                	je     236a <hook_fun.0+0x6c>
    231d:	a1 ec 01 00 00       	mov    eax,ds:0x1ec
    2322:	83 f8 09             	cmp    eax,0x9
    2325:	77 43                	ja     236a <hook_fun.0+0x6c>
						delta[ni - 2] = ct - old_ct;
    2327:	8b 0d f4 01 00 00    	mov    ecx,DWORD PTR ds:0x1f4
    232d:	a1 f0 01 00 00       	mov    eax,ds:0x1f0
    2332:	8b 15 ec 01 00 00    	mov    edx,DWORD PTR ds:0x1ec
    2338:	83 ea 02             	sub    edx,0x2
    233b:	29 c1                	sub    ecx,eax
    233d:	89 0c 95 00 02 00 00 	mov    DWORD PTR [edx*4+0x200],ecx
						if (cpu.has_tsc)
    2344:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    234b:	83 e0 10             	and    eax,0x10
    234e:	84 c0                	test   al,al
    2350:	74 18                	je     236a <hook_fun.0+0x6c>
								asm volatile ("rdtsc" : "=A" (ts_delta[ni - 2]));
    2352:	a1 ec 01 00 00       	mov    eax,ds:0x1ec
    2357:	8d 48 fe             	lea    ecx,[eax-0x2]
    235a:	0f 31                	rdtsc
    235c:	89 04 cd 20 02 00 00 	mov    DWORD PTR [ecx*8+0x220],eax
    2363:	89 14 cd 24 02 00 00 	mov    DWORD PTR [ecx*8+0x224],edx
				}
				old_ct = ct;
    236a:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    236f:	a3 f0 01 00 00       	mov    ds:0x1f0,eax
				if (ni >= 9)
    2374:	a1 ec 01 00 00       	mov    eax,ds:0x1ec
    2379:	83 f8 08             	cmp    eax,0x8
    237c:	76 0a                	jbe    2388 <hook_fun.0+0x8a>
						irq0_hook = NULL;
    237e:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
		}
    2388:	90                   	nop
    2389:	c9                   	leave
    238a:	c3                   	ret

0000238b <calibrate_bogo_mips>:
{
    238b:	55                   	push   ebp
    238c:	89 e5                	mov    ebp,esp
    238e:	57                   	push   edi
    238f:	56                   	push   esi
    2390:	53                   	push   ebx
    2391:	83 ec 5c             	sub    esp,0x5c
    2394:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2397:	66 89 45 c4          	mov    WORD PTR [ebp-0x3c],ax
void calibrate_bogo_mips(uint16_t pit_div)
    239b:	8d 45 08             	lea    eax,[ebp+0x8]
    239e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    23a1:	8d 45 d0             	lea    eax,[ebp-0x30]
    23a4:	8d 55 d0             	lea    edx,[ebp-0x30]
    23a7:	c6 00 b9             	mov    BYTE PTR [eax],0xb9
    23aa:	89 50 01             	mov    DWORD PTR [eax+0x1],edx
    23ad:	c6 40 05 e9          	mov    BYTE PTR [eax+0x5],0xe9
    23b1:	b9 fe 22 00 00       	mov    ecx,0x22fe
    23b6:	8d 50 0a             	lea    edx,[eax+0xa]
    23b9:	29 d1                	sub    ecx,edx
    23bb:	89 48 06             	mov    DWORD PTR [eax+0x6],ecx
		uint32_t limit = 0x00f00000; /* very low for QEMU-software emu */
    23be:	c7 45 e4 00 00 f0 00 	mov    DWORD PTR [ebp-0x1c],0xf00000

		printf("calibrating bogous MIPS value...\n");
    23c5:	c7 04 24 14 05 00 00 	mov    DWORD PTR [esp],0x514
    23cc:	e8 fc ff ff ff       	call   23cd <calibrate_bogo_mips+0x42>
		/* do the adaptive loop
		 * if limit needs to be > 32bit we're f'ed  */
		do {
				/* zero the variables */
				ct = old_ct = ni = 0;
    23d1:	c7 05 ec 01 00 00 00 00 00 00 	mov    DWORD PTR ds:0x1ec,0x0
    23db:	a1 ec 01 00 00       	mov    eax,ds:0x1ec
    23e0:	a3 f0 01 00 00       	mov    ds:0x1f0,eax
    23e5:	a1 f0 01 00 00       	mov    eax,ds:0x1f0
    23ea:	a3 f4 01 00 00       	mov    ds:0x1f4,eax
				/* (re-)install the irq0 hook */
				irq0_hook = hook_fun;
    23ef:	8d 45 d0             	lea    eax,[ebp-0x30]
    23f2:	a3 00 00 00 00       	mov    ds:0x0,eax
				for (ct = 0; ct < limit; ct++);
    23f7:	c7 05 f4 01 00 00 00 00 00 00 	mov    DWORD PTR ds:0x1f4,0x0
    2401:	eb 0d                	jmp    2410 <calibrate_bogo_mips+0x85>
    2403:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    2408:	83 c0 01             	add    eax,0x1
    240b:	a3 f4 01 00 00       	mov    ds:0x1f4,eax
    2410:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    2415:	3b 45 e4             	cmp    eax,DWORD PTR [ebp-0x1c]
    2418:	72 e9                	jb     2403 <calibrate_bogo_mips+0x78>
				if (ni < 9) { /* unusable -> redo */
    241a:	a1 ec 01 00 00       	mov    eax,ds:0x1ec
    241f:	83 f8 08             	cmp    eax,0x8
    2422:	77 2b                	ja     244f <calibrate_bogo_mips+0xc4>
						limit <<= 4;
    2424:	c1 65 e4 04          	shl    DWORD PTR [ebp-0x1c],0x4
						printf("increasing bogous MIPS calibration loop limit to %x\n", limit);
    2428:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    242b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    242f:	c7 04 24 38 05 00 00 	mov    DWORD PTR [esp],0x538
    2436:	e8 fc ff ff ff       	call   2437 <calibrate_bogo_mips+0xac>
						/* wait for hook self-removal */
						while (irq0_hook);
    243b:	90                   	nop
    243c:	a1 00 00 00 00       	mov    eax,ds:0x0
    2441:	85 c0                	test   eax,eax
    2443:	75 f7                	jne    243c <calibrate_bogo_mips+0xb1>
						ni = 0;
    2445:	c7 05 ec 01 00 00 00 00 00 00 	mov    DWORD PTR ds:0x1ec,0x0
				}
		} while (ni < 9);
    244f:	a1 ec 01 00 00       	mov    eax,ds:0x1ec
    2454:	83 f8 08             	cmp    eax,0x8
    2457:	0f 86 74 ff ff ff    	jbe    23d1 <calibrate_bogo_mips+0x46>

		/* now we have 8 positive delta values for
		 * calibrating bogo_mips each div ticks apart */
		old_ct = 0;
    245d:	c7 05 f0 01 00 00 00 00 00 00 	mov    DWORD PTR ds:0x1f0,0x0
		for (ct = 0; ct < 8; ct++) {
    2467:	c7 05 f4 01 00 00 00 00 00 00 	mov    DWORD PTR ds:0x1f4,0x0
    2471:	e9 ad 00 00 00       	jmp    2523 <calibrate_bogo_mips+0x198>
				printf("%u: %08x\n", ct, delta[ct]);
    2476:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    247b:	8b 14 85 00 02 00 00 	mov    edx,DWORD PTR [eax*4+0x200]
    2482:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    2487:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    248b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    248f:	c7 04 24 6d 05 00 00 	mov    DWORD PTR [esp],0x56d
    2496:	e8 fc ff ff ff       	call   2497 <calibrate_bogo_mips+0x10c>
				old_ct += delta[ct];
    249b:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    24a0:	8b 14 85 00 02 00 00 	mov    edx,DWORD PTR [eax*4+0x200]
    24a7:	a1 f0 01 00 00       	mov    eax,ds:0x1f0
    24ac:	01 d0                	add    eax,edx
    24ae:	a3 f0 01 00 00       	mov    ds:0x1f0,eax
				if (cpu.has_tsc && ct)
    24b3:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    24ba:	83 e0 10             	and    eax,0x10
    24bd:	84 c0                	test   al,al
    24bf:	74 55                	je     2516 <calibrate_bogo_mips+0x18b>
    24c1:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    24c6:	85 c0                	test   eax,eax
    24c8:	74 4c                	je     2516 <calibrate_bogo_mips+0x18b>
						ts_ct += ts_delta[ct] - ts_delta[ct - 1];
    24ca:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    24cf:	8b 14 c5 24 02 00 00 	mov    edx,DWORD PTR [eax*8+0x224]
    24d6:	8b 04 c5 20 02 00 00 	mov    eax,DWORD PTR [eax*8+0x220]
    24dd:	8b 0d f4 01 00 00    	mov    ecx,DWORD PTR ds:0x1f4
    24e3:	83 e9 01             	sub    ecx,0x1
    24e6:	8b 1c cd 24 02 00 00 	mov    ebx,DWORD PTR [ecx*8+0x224]
    24ed:	8b 0c cd 20 02 00 00 	mov    ecx,DWORD PTR [ecx*8+0x220]
    24f4:	29 c8                	sub    eax,ecx
    24f6:	19 da                	sbb    edx,ebx
    24f8:	89 c6                	mov    esi,eax
    24fa:	89 d7                	mov    edi,edx
    24fc:	a1 60 02 00 00       	mov    eax,ds:0x260
    2501:	8b 15 64 02 00 00    	mov    edx,DWORD PTR ds:0x264
    2507:	01 f0                	add    eax,esi
    2509:	11 fa                	adc    edx,edi
    250b:	a3 60 02 00 00       	mov    ds:0x260,eax
    2510:	89 15 64 02 00 00    	mov    DWORD PTR ds:0x264,edx
		for (ct = 0; ct < 8; ct++) {
    2516:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    251b:	83 c0 01             	add    eax,0x1
    251e:	a3 f4 01 00 00       	mov    ds:0x1f4,eax
    2523:	a1 f4 01 00 00       	mov    eax,ds:0x1f4
    2528:	83 f8 07             	cmp    eax,0x7
    252b:	0f 86 45 ff ff ff    	jbe    2476 <calibrate_bogo_mips+0xeb>
		}
		old_ct /= 8;
    2531:	a1 f0 01 00 00       	mov    eax,ds:0x1f0
    2536:	c1 e8 03             	shr    eax,0x3
    2539:	a3 f0 01 00 00       	mov    ds:0x1f0,eax
		if (cpu.has_tsc)
    253e:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2545:	83 e0 10             	and    eax,0x10
    2548:	84 c0                	test   al,al
    254a:	74 32                	je     257e <calibrate_bogo_mips+0x1f3>
				ts_ct /= 7;
    254c:	a1 60 02 00 00       	mov    eax,ds:0x260
    2551:	8b 15 64 02 00 00    	mov    edx,DWORD PTR ds:0x264
    2557:	c7 44 24 08 07 00 00 00 	mov    DWORD PTR [esp+0x8],0x7
    255f:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2567:	89 04 24             	mov    DWORD PTR [esp],eax
    256a:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    256e:	e8 fc ff ff ff       	call   256f <calibrate_bogo_mips+0x1e4>
    2573:	a3 60 02 00 00       	mov    ds:0x260,eax
    2578:	89 15 64 02 00 00    	mov    DWORD PTR ds:0x264,edx
		printf("Bougous MIPS calibrated to %08x steps per PIT tick with a "
    257e:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    2582:	a1 f0 01 00 00       	mov    eax,ds:0x1f0
    2587:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    258b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    258f:	c7 04 24 78 05 00 00 	mov    DWORD PTR [esp],0x578
    2596:	e8 fc ff ff ff       	call   2597 <calibrate_bogo_mips+0x20c>
				"PIT divider of %u\n", old_ct, pit_div);
		loops_per_jiffy = old_ct;
    259b:	a1 f0 01 00 00       	mov    eax,ds:0x1f0
    25a0:	a3 00 00 00 00       	mov    ds:0x0,eax
		printf("Therefore a delay of 1 ms corresponds to %u steps.\n",
				(loops_per_ms = (uint32_t)(HZ * (uint64_t)old_ct / 1000)));
    25a5:	a1 f0 01 00 00       	mov    eax,ds:0x1f0
    25aa:	89 c1                	mov    ecx,eax
    25ac:	bb 00 00 00 00       	mov    ebx,0x0
    25b1:	89 c8                	mov    eax,ecx
    25b3:	89 da                	mov    edx,ebx
    25b5:	0f a4 c2 04          	shld   edx,eax,0x4
    25b9:	c1 e0 04             	shl    eax,0x4
    25bc:	29 c8                	sub    eax,ecx
    25be:	19 da                	sbb    edx,ebx
    25c0:	0f a4 c2 03          	shld   edx,eax,0x3
    25c4:	c1 e0 03             	shl    eax,0x3
    25c7:	01 c8                	add    eax,ecx
    25c9:	11 da                	adc    edx,ebx
    25cb:	c7 44 24 08 e8 03 00 00 	mov    DWORD PTR [esp+0x8],0x3e8
    25d3:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    25db:	89 04 24             	mov    DWORD PTR [esp],eax
    25de:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    25e2:	e8 fc ff ff ff       	call   25e3 <calibrate_bogo_mips+0x258>
		printf("Therefore a delay of 1 ms corresponds to %u steps.\n",
    25e7:	a3 00 00 00 00       	mov    ds:0x0,eax
    25ec:	a1 00 00 00 00       	mov    eax,ds:0x0
    25f1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    25f5:	c7 04 24 c8 05 00 00 	mov    DWORD PTR [esp],0x5c8
    25fc:	e8 fc ff ff ff       	call   25fd <calibrate_bogo_mips+0x272>
		if (cpu.has_tsc) {
    2601:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2608:	83 e0 10             	and    eax,0x10
    260b:	84 c0                	test   al,al
    260d:	0f 84 80 00 00 00    	je     2693 <calibrate_bogo_mips+0x308>
				printf("As this CPU has a TSC a PIT tick corresponds to %llu "
						"TSC ticks --> %llu ticks per ms.\n", ts_ct,
					   (tsc_per_ms = HZ * ts_ct / 1000));
    2613:	8b 0d 60 02 00 00    	mov    ecx,DWORD PTR ds:0x260
    2619:	8b 1d 64 02 00 00    	mov    ebx,DWORD PTR ds:0x264
    261f:	89 c8                	mov    eax,ecx
    2621:	89 da                	mov    edx,ebx
    2623:	0f a4 c2 04          	shld   edx,eax,0x4
    2627:	c1 e0 04             	shl    eax,0x4
    262a:	29 c8                	sub    eax,ecx
    262c:	19 da                	sbb    edx,ebx
    262e:	0f a4 c2 03          	shld   edx,eax,0x3
    2632:	c1 e0 03             	shl    eax,0x3
    2635:	01 c8                	add    eax,ecx
    2637:	11 da                	adc    edx,ebx
    2639:	c7 44 24 08 e8 03 00 00 	mov    DWORD PTR [esp+0x8],0x3e8
    2641:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2649:	89 04 24             	mov    DWORD PTR [esp],eax
    264c:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2650:	e8 fc ff ff ff       	call   2651 <calibrate_bogo_mips+0x2c6>
				printf("As this CPU has a TSC a PIT tick corresponds to %llu "
    2655:	a3 00 00 00 00       	mov    ds:0x0,eax
    265a:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
    2660:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    2666:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    266c:	a1 60 02 00 00       	mov    eax,ds:0x260
    2671:	8b 15 64 02 00 00    	mov    edx,DWORD PTR ds:0x264
    2677:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    267b:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    267f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2683:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2687:	c7 04 24 fc 05 00 00 	mov    DWORD PTR [esp],0x5fc
    268e:	e8 fc ff ff ff       	call   268f <calibrate_bogo_mips+0x304>
		}
}
    2693:	90                   	nop
    2694:	83 c4 5c             	add    esp,0x5c
    2697:	5b                   	pop    ebx
    2698:	5e                   	pop    esi
    2699:	5f                   	pop    edi
    269a:	5d                   	pop    ebp
    269b:	c3                   	ret

0000269c <ndelay>:

void ndelay(unsigned long nsecs)
{
    269c:	55                   	push   ebp
    269d:	89 e5                	mov    ebp,esp
    269f:	57                   	push   edi
    26a0:	56                   	push   esi
    26a1:	53                   	push   ebx
    26a2:	83 ec 2c             	sub    esp,0x2c
		uint32_t ct = 0, limit = (uint32_t)((uint64_t)nsecs * loops_per_ms / 1000000);
    26a5:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    26ac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    26af:	ba 00 00 00 00       	mov    edx,0x0
    26b4:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    26ba:	bb 00 00 00 00       	mov    ebx,0x0
    26bf:	89 d7                	mov    edi,edx
    26c1:	0f af f9             	imul   edi,ecx
    26c4:	89 de                	mov    esi,ebx
    26c6:	0f af f0             	imul   esi,eax
    26c9:	01 fe                	add    esi,edi
    26cb:	f7 e1                	mul    ecx
    26cd:	8d 0c 16             	lea    ecx,[esi+edx*1]
    26d0:	89 ca                	mov    edx,ecx
    26d2:	c7 44 24 08 40 42 0f 00 	mov    DWORD PTR [esp+0x8],0xf4240
    26da:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    26e2:	89 04 24             	mov    DWORD PTR [esp],eax
    26e5:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    26e9:	e8 fc ff ff ff       	call   26ea <ndelay+0x4e>
    26ee:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		/* uses the same double mem-access
		 * as in the calibration routine */
		for (ct = 0; ct < limit; ct++);
    26f1:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    26f8:	eb 04                	jmp    26fe <ndelay+0x62>
    26fa:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    26fe:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2701:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    2704:	72 f4                	jb     26fa <ndelay+0x5e>
}
    2706:	90                   	nop
    2707:	90                   	nop
    2708:	83 c4 2c             	add    esp,0x2c
    270b:	5b                   	pop    ebx
    270c:	5e                   	pop    esi
    270d:	5f                   	pop    edi
    270e:	5d                   	pop    ebp
    270f:	c3                   	ret

00002710 <udelay>:

void udelay(unsigned long usecs)
{
    2710:	55                   	push   ebp
    2711:	89 e5                	mov    ebp,esp
    2713:	83 ec 18             	sub    esp,0x18
		while (usecs--)
    2716:	eb 0c                	jmp    2724 <udelay+0x14>
				ndelay(1000);
    2718:	c7 04 24 e8 03 00 00 	mov    DWORD PTR [esp],0x3e8
    271f:	e8 fc ff ff ff       	call   2720 <udelay+0x10>
		while (usecs--)
    2724:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2727:	8d 50 ff             	lea    edx,[eax-0x1]
    272a:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
    272d:	85 c0                	test   eax,eax
    272f:	75 e7                	jne    2718 <udelay+0x8>
}
    2731:	90                   	nop
    2732:	90                   	nop
    2733:	c9                   	leave
    2734:	c3                   	ret

00002735 <mdelay>:

void mdelay(unsigned long msecs)
{
    2735:	55                   	push   ebp
    2736:	89 e5                	mov    ebp,esp
    2738:	83 ec 18             	sub    esp,0x18
		if (!loops_per_ms)
    273b:	a1 00 00 00 00       	mov    eax,ds:0x0
    2740:	85 c0                	test   eax,eax
    2742:	74 1d                	je     2761 <mdelay+0x2c>
				return;
		while (msecs--)
    2744:	eb 0c                	jmp    2752 <mdelay+0x1d>
				udelay(1000);
    2746:	c7 04 24 e8 03 00 00 	mov    DWORD PTR [esp],0x3e8
    274d:	e8 fc ff ff ff       	call   274e <mdelay+0x19>
		while (msecs--)
    2752:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2755:	8d 50 ff             	lea    edx,[eax-0x1]
    2758:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
    275b:	85 c0                	test   eax,eax
    275d:	75 e7                	jne    2746 <mdelay+0x11>
    275f:	eb 01                	jmp    2762 <mdelay+0x2d>
				return;
    2761:	90                   	nop
}
    2762:	c9                   	leave
    2763:	c3                   	ret

00002764 <apic_expire>:
uint32_t apic_reload_value = 0x0fffffff;
uint8_t apic_div = 0x0b;
#define NCF_AP 48
static uint32_t n_ct = 0xffffffff, exp = 0; static uint32_t tmr_val = 0;
/* the expiration hook */
void apic_expire() {
    2764:	55                   	push   ebp
    2765:	89 e5                	mov    ebp,esp
		if (!exp) /* don't unsignal 2 (done) */
    2767:	a1 d0 01 00 00       	mov    eax,ds:0x1d0
    276c:	85 c0                	test   eax,eax
    276e:	75 0a                	jne    277a <apic_expire+0x16>
				exp = 1;
    2770:	c7 05 d0 01 00 00 01 00 00 00 	mov    DWORD PTR ds:0x1d0,0x1
}
    277a:	90                   	nop
    277b:	5d                   	pop    ebp
    277c:	c3                   	ret

0000277d <irq0_worker>:

/* the irq0 calibration worker */
void irq0_worker() {
    277d:	55                   	push   ebp
    277e:	89 e5                	mov    ebp,esp
    2780:	83 ec 28             	sub    esp,0x28
		if (n_ct == 0xffffffff) {
    2783:	a1 38 00 00 00       	mov    eax,ds:0x38
    2788:	83 f8 ff             	cmp    eax,0xffffffff
    278b:	75 2b                	jne    27b8 <irq0_worker+0x3b>
				/* enable the timer */
				apic_bp_reg(APIC_REG_TMRDIV) = apic_div;
    278d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    2794:	ba e0 03 ff ef       	mov    edx,0xefff03e0
    2799:	0f b6 c0             	movzx  eax,al
    279c:	89 02                	mov    DWORD PTR [edx],eax
				apic_bp_reg(APIC_REG_TMRINITCNT) = 0xffffffff;
    279e:	b8 80 03 ff ef       	mov    eax,0xefff0380
    27a3:	c7 00 ff ff ff ff    	mov    DWORD PTR [eax],0xffffffff
				n_ct = 0;
    27a9:	c7 05 38 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x38,0x0
				return;
    27b3:	e9 f2 00 00 00       	jmp    28aa <irq0_worker+0x12d>
		} else if (exp) {
    27b8:	a1 d0 01 00 00       	mov    eax,ds:0x1d0
    27bd:	85 c0                	test   eax,eax
    27bf:	0f 84 ac 00 00 00    	je     2871 <irq0_worker+0xf4>
				/* timer has expired and sample is too small */
				n_ct = 0xffffffff; exp = 0; tmr_val = 0;
    27c5:	c7 05 38 00 00 00 ff ff ff ff 	mov    DWORD PTR ds:0x38,0xffffffff
    27cf:	c7 05 d0 01 00 00 00 00 00 00 	mov    DWORD PTR ds:0x1d0,0x0
    27d9:	c7 05 d4 01 00 00 00 00 00 00 	mov    DWORD PTR ds:0x1d4,0x0
				if (apic_div == 0x0b)
    27e3:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    27ea:	3c 0b                	cmp    al,0xb
    27ec:	75 0c                	jne    27fa <irq0_worker+0x7d>
						apic_div = 1;
    27ee:	c6 05 00 00 00 00 01 	mov    BYTE PTR ds:0x0,0x1
    27f5:	e9 b0 00 00 00       	jmp    28aa <irq0_worker+0x12d>
				else {
						/* bits: 3210; 2=R=0, bin: 2-128, 1 */
						uint8_t val = (((apic_div & 0x08) >> 1) | (apic_div & 0x03));
    27fa:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    2801:	0f b6 c0             	movzx  eax,al
    2804:	d1 f8                	sar    eax,1
    2806:	83 e0 04             	and    eax,0x4
    2809:	89 c2                	mov    edx,eax
    280b:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    2812:	83 e0 03             	and    eax,0x3
    2815:	09 d0                	or     eax,edx
    2817:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
						val++;
    281a:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    281e:	83 c0 01             	add    eax,0x1
    2821:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
						apic_div = ((val & 0x04) << 1) | (val & 0x03);
    2824:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2828:	01 c0                	add    eax,eax
    282a:	83 e0 08             	and    eax,0x8
    282d:	89 c2                	mov    edx,eax
    282f:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2833:	83 e0 03             	and    eax,0x3
    2836:	09 d0                	or     eax,edx
    2838:	a2 00 00 00 00       	mov    ds:0x0,al
						if (apic_div == 0x0b)
    283d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    2844:	3c 0b                	cmp    al,0xb
    2846:	75 62                	jne    28aa <irq0_worker+0x12d>
								die("unable to divide high enough!\n");
    2848:	c7 44 24 04 54 06 00 00 	mov    DWORD PTR [esp+0x4],0x654
    2850:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2857:	e8 fc ff ff ff       	call   2858 <irq0_worker+0xdb>
    285c:	e8 fc ff ff ff       	call   285d <irq0_worker+0xe0>
    2861:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2868:	e8 fc ff ff ff       	call   2869 <irq0_worker+0xec>
    286d:	fa                   	cli
    286e:	f4                   	hlt
    286f:	eb fd                	jmp    286e <irq0_worker+0xf1>
				}
		} else if (n_ct < NCF_AP - 1)
    2871:	a1 38 00 00 00       	mov    eax,ds:0x38
    2876:	83 f8 2e             	cmp    eax,0x2e
    2879:	77 0f                	ja     288a <irq0_worker+0x10d>
				n_ct++;
    287b:	a1 38 00 00 00       	mov    eax,ds:0x38
    2880:	83 c0 01             	add    eax,0x1
    2883:	a3 38 00 00 00       	mov    ds:0x38,eax
    2888:	eb 20                	jmp    28aa <irq0_worker+0x12d>
		else {
				/* remove one of the hooks */
				tmr_val = apic_bp_reg(APIC_REG_TMRCURRCNT);
    288a:	b8 90 03 ff ef       	mov    eax,0xefff0390
    288f:	8b 00                	mov    eax,DWORD PTR [eax]
    2891:	a3 d4 01 00 00       	mov    ds:0x1d4,eax
				irq0_hook = NULL;
    2896:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
				exp = 2;
    28a0:	c7 05 d0 01 00 00 02 00 00 00 	mov    DWORD PTR ds:0x1d0,0x2
		}
}
    28aa:	c9                   	leave
    28ab:	c3                   	ret

000028ac <apic_timer_setup>:

/* function is already during preemption */
void apic_timer_setup()
{
    28ac:	55                   	push   ebp
    28ad:	89 e5                	mov    ebp,esp
    28af:	53                   	push   ebx
    28b0:	83 ec 24             	sub    esp,0x24
		/* strategy: set a irq0-hook which initializes the apic timer
		 * and reads the count(s) on the next iteration(s). If the
		 * APIC timer expires before completion the divider is increased. */

		/* enable the timer function of the BP */
		printf("calibrating BP APIC timer...\n");
    28b3:	c7 04 24 73 06 00 00 	mov    DWORD PTR [esp],0x673
    28ba:	e8 fc ff ff ff       	call   28bb <apic_timer_setup+0xf>
		/* (val << 16): R00M=one-shot, R01M per, R11M tsc, R=res, M=mask */
		apic_bp_reg(APIC_REG_LVT_TMR) = 0x00000000 | 0x3d; /* one-shot */
    28bf:	b8 20 03 ff ef       	mov    eax,0xefff0320
    28c4:	c7 00 3d 00 00 00    	mov    DWORD PTR [eax],0x3d

		/* now perform the work */
		preempt_disable();
    28ca:	e8 fc ff ff ff       	call   28cb <apic_timer_setup+0x1f>
    28cf:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    28d2:	83 c2 01             	add    edx,0x1
    28d5:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		apic_hook = apic_expire;
    28d8:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
		irq0_hook = irq0_worker;
    28e2:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0

		/* wait for completion */
		while (exp != 2);
    28ec:	90                   	nop
    28ed:	a1 d0 01 00 00       	mov    eax,ds:0x1d0
    28f2:	83 f8 02             	cmp    eax,0x2
    28f5:	75 f6                	jne    28ed <apic_timer_setup+0x41>

		/* disarm the bp timer for now */
		apic_bp_reg(APIC_REG_TMRINITCNT) = 0;
    28f7:	b8 80 03 ff ef       	mov    eax,0xefff0380
    28fc:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0

		/* remove the apic hook (possible rc? nope; intr preempts this)*/
		apic_hook = NULL;
    2902:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0

		/* reenable preemption */
		preempt_enable();
    290c:	e8 fc ff ff ff       	call   290d <apic_timer_setup+0x61>
    2911:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2914:	83 ea 01             	sub    edx,0x1
    2917:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
    291a:	e8 fc ff ff ff       	call   291b <apic_timer_setup+0x6f>
    291f:	8b 00                	mov    eax,DWORD PTR [eax]
    2921:	83 e0 01             	and    eax,0x1
    2924:	85 c0                	test   eax,eax
    2926:	74 05                	je     292d <apic_timer_setup+0x81>
    2928:	e8 fc ff ff ff       	call   2929 <apic_timer_setup+0x7d>

		/* calculate the tick values */
		tmr_val = (0xffffffff - tmr_val) / NCF_AP;
    292d:	a1 d4 01 00 00       	mov    eax,ds:0x1d4
    2932:	f7 d0                	not    eax
    2934:	ba ab aa aa aa       	mov    edx,0xaaaaaaab
    2939:	f7 e2                	mul    edx
    293b:	89 d0                	mov    eax,edx
    293d:	c1 e8 05             	shr    eax,0x5
    2940:	a3 d4 01 00 00       	mov    ds:0x1d4,eax
		printf("On average: %08x APIC timer ticks per PIT interrupt.\n", tmr_val);
    2945:	a1 d4 01 00 00       	mov    eax,ds:0x1d4
    294a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    294e:	c7 04 24 94 06 00 00 	mov    DWORD PTR [esp],0x694
    2955:	e8 fc ff ff ff       	call   2956 <apic_timer_setup+0xaa>
		apic_reload_value = tmr_val;
    295a:	a1 d4 01 00 00       	mov    eax,ds:0x1d4
    295f:	a3 00 00 00 00       	mov    ds:0x0,eax
		{
				uint64_t freq = ((uint64_t)HZ * tmr_val);
    2964:	a1 d4 01 00 00       	mov    eax,ds:0x1d4
    2969:	89 c1                	mov    ecx,eax
    296b:	bb 00 00 00 00       	mov    ebx,0x0
    2970:	89 c8                	mov    eax,ecx
    2972:	89 da                	mov    edx,ebx
    2974:	0f a4 c2 04          	shld   edx,eax,0x4
    2978:	c1 e0 04             	shl    eax,0x4
    297b:	29 c8                	sub    eax,ecx
    297d:	19 da                	sbb    edx,ebx
    297f:	0f a4 c2 03          	shld   edx,eax,0x3
    2983:	c1 e0 03             	shl    eax,0x3
    2986:	01 c8                	add    eax,ecx
    2988:	11 da                	adc    edx,ebx
    298a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    298d:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
				uint32_t mhz = (uint32_t)(freq / 1000000);
    2990:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2993:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2996:	c7 44 24 08 40 42 0f 00 	mov    DWORD PTR [esp+0x8],0xf4240
    299e:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    29a6:	89 04 24             	mov    DWORD PTR [esp],eax
    29a9:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    29ad:	e8 fc ff ff ff       	call   29ae <apic_timer_setup+0x102>
    29b2:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				uint32_t khz = (uint32_t)(freq % 1000000) / 1000;
    29b5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    29b8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    29bb:	c7 44 24 08 40 42 0f 00 	mov    DWORD PTR [esp+0x8],0xf4240
    29c3:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    29cb:	89 04 24             	mov    DWORD PTR [esp],eax
    29ce:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    29d2:	e8 fc ff ff ff       	call   29d3 <apic_timer_setup+0x127>
    29d7:	ba d3 4d 62 10       	mov    edx,0x10624dd3
    29dc:	f7 e2                	mul    edx
    29de:	89 d0                	mov    eax,edx
    29e0:	c1 e8 06             	shr    eax,0x6
    29e3:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				cprintf(KFMT_INFO, "This results in an APIC timer frequency of %u.%03u MHz\n",
    29e6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    29e9:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    29ed:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    29f0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    29f4:	c7 44 24 04 cc 06 00 00 	mov    DWORD PTR [esp+0x4],0x6cc
    29fc:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2a03:	e8 fc ff ff ff       	call   2a04 <apic_timer_setup+0x158>
						mhz, khz);
		}
}
    2a08:	90                   	nop
    2a09:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2a0c:	c9                   	leave
    2a0d:	c3                   	ret

00002a0e <timer_setup>:

void timer_setup()
{
    2a0e:	55                   	push   ebp
    2a0f:	89 e5                	mov    ebp,esp
    2a11:	56                   	push   esi
    2a12:	53                   	push   ebx
    2a13:	81 ec 90 00 00 00    	sub    esp,0x90
		uint8_t bt; const char* ams[4] = {"latch", "lo", "hi", "lo/hi"};
    2a19:	c7 45 d8 04 07 00 00 	mov    DWORD PTR [ebp-0x28],0x704
    2a20:	c7 45 dc 0a 07 00 00 	mov    DWORD PTR [ebp-0x24],0x70a
    2a27:	c7 45 e0 0d 07 00 00 	mov    DWORD PTR [ebp-0x20],0x70d
    2a2e:	c7 45 e4 10 07 00 00 	mov    DWORD PTR [ebp-0x1c],0x710
		uint16_t div; uint64_t tmv;
		const char* oms[8] = {
    2a35:	c7 45 b8 16 07 00 00 	mov    DWORD PTR [ebp-0x48],0x716
    2a3c:	c7 45 bc 23 07 00 00 	mov    DWORD PTR [ebp-0x44],0x723
    2a43:	c7 45 c0 34 07 00 00 	mov    DWORD PTR [ebp-0x40],0x734
    2a4a:	c7 45 c4 43 07 00 00 	mov    DWORD PTR [ebp-0x3c],0x743
    2a51:	c7 45 c8 59 07 00 00 	mov    DWORD PTR [ebp-0x38],0x759
    2a58:	c7 45 cc 69 07 00 00 	mov    DWORD PTR [ebp-0x34],0x769
    2a5f:	c7 45 d0 34 07 00 00 	mov    DWORD PTR [ebp-0x30],0x734
    2a66:	c7 45 d4 43 07 00 00 	mov    DWORD PTR [ebp-0x2c],0x743
				"int on count", "one-shot counter",
				"rate generator", "square wave generator",
				"software strobe", "hardware strobe",
				"rate generator", "square wave generator"
		};
		__asm__("cli");
    2a6d:	fa                   	cli
		km_time = cmos_get_time();
    2a6e:	8d 45 88             	lea    eax,[ebp-0x78]
    2a71:	89 04 24             	mov    DWORD PTR [esp],eax
    2a74:	e8 fc ff ff ff       	call   2a75 <timer_setup+0x67>
    2a79:	83 ec 04             	sub    esp,0x4
    2a7c:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    2a7f:	a3 00 00 00 00       	mov    ds:0x0,eax
    2a84:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
    2a87:	a3 04 00 00 00       	mov    ds:0x4,eax
    2a8c:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    2a8f:	a3 08 00 00 00       	mov    ds:0x8,eax
    2a94:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    2a97:	a3 0c 00 00 00       	mov    ds:0xc,eax
    2a9c:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    2a9f:	a3 10 00 00 00       	mov    ds:0x10,eax
    2aa4:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2aa7:	a3 14 00 00 00       	mov    ds:0x14,eax
    2aac:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    2aaf:	a3 18 00 00 00       	mov    ds:0x18,eax
    2ab4:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    2ab7:	a3 1c 00 00 00       	mov    ds:0x1c,eax
    2abc:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2abf:	a3 20 00 00 00       	mov    ds:0x20,eax
		km_set = jiffies; /* should be counter but alas */
    2ac4:	a1 00 00 00 00       	mov    eax,ds:0x0
    2ac9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2acc:	8b 00                	mov    eax,DWORD PTR [eax]
    2ace:	a3 00 00 00 00       	mov    ds:0x0,eax
    2ad3:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		/* get info on the status of the timer */
		outb(PIT1_CTR, 0b11010010); /* latch status of CH0 */
    2ad9:	c7 44 24 04 d2 00 00 00 	mov    DWORD PTR [esp+0x4],0xd2
    2ae1:	c7 04 24 43 00 00 00 	mov    DWORD PTR [esp],0x43
    2ae8:	e8 34 d5 ff ff       	call   21 <outb>
		bt = inb(PIT1_CH0);
    2aed:	c7 04 24 40 00 00 00 	mov    DWORD PTR [esp],0x40
    2af4:	e8 47 d5 ff ff       	call   40 <inb>
    2af9:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		printf("PIT1_CH0 status is %08b\n", bt);
    2afc:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2b00:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b04:	c7 04 24 79 07 00 00 	mov    DWORD PTR [esp],0x779
    2b0b:	e8 fc ff ff ff       	call   2b0c <timer_setup+0xfe>
		printf("with access mode: %s\n", ams[(bt >> 4) & 0x03]);
    2b10:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2b14:	c0 e8 04             	shr    al,0x4
    2b17:	0f b6 c0             	movzx  eax,al
    2b1a:	83 e0 03             	and    eax,0x3
    2b1d:	8b 44 85 d8          	mov    eax,DWORD PTR [ebp+eax*4-0x28]
    2b21:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b25:	c7 04 24 92 07 00 00 	mov    DWORD PTR [esp],0x792
    2b2c:	e8 fc ff ff ff       	call   2b2d <timer_setup+0x11f>
		printf("and operating mode: %s\n", oms[(bt >> 1) & 0x07]);
    2b31:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2b35:	d0 e8                	shr    al,1
    2b37:	0f b6 c0             	movzx  eax,al
    2b3a:	83 e0 07             	and    eax,0x7
    2b3d:	8b 44 85 b8          	mov    eax,DWORD PTR [ebp+eax*4-0x48]
    2b41:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b45:	c7 04 24 a8 07 00 00 	mov    DWORD PTR [esp],0x7a8
    2b4c:	e8 fc ff ff ff       	call   2b4d <timer_setup+0x13f>
		/* change the mode */
		printf("timer will be set to rate generator lo/hi mode\n");
    2b51:	c7 04 24 c0 07 00 00 	mov    DWORD PTR [esp],0x7c0
    2b58:	e8 fc ff ff ff       	call   2b59 <timer_setup+0x14b>
		outb(PIT1_CTR, 0b00110110); /* binary CH0 lohi rategen */
    2b5d:	c7 44 24 04 36 00 00 00 	mov    DWORD PTR [esp+0x4],0x36
    2b65:	c7 04 24 43 00 00 00 	mov    DWORD PTR [esp],0x43
    2b6c:	e8 b0 d4 ff ff       	call   21 <outb>
		/* and the divisor */
		printf("divisor for HZ=%d: %u\n", HZ, 1193182u / HZ);
    2b71:	c7 44 24 08 85 26 00 00 	mov    DWORD PTR [esp+0x8],0x2685
    2b79:	c7 44 24 04 79 00 00 00 	mov    DWORD PTR [esp+0x4],0x79
    2b81:	c7 04 24 f0 07 00 00 	mov    DWORD PTR [esp],0x7f0
    2b88:	e8 fc ff ff ff       	call   2b89 <timer_setup+0x17b>
		//div = 9861; //11931; //0xffff;
		div = 1193182u / HZ;
    2b8d:	66 c7 45 f4 85 26    	mov    WORD PTR [ebp-0xc],0x2685
		//printf("with a divisor of %u\n", div);
		//printf("resulting in a frequency of ~%u Hz\n", 1193182u / div);
		outb(PIT1_CH0, div & 0xff);
    2b93:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    2b97:	0f b6 c0             	movzx  eax,al
    2b9a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b9e:	c7 04 24 40 00 00 00 	mov    DWORD PTR [esp],0x40
    2ba5:	e8 77 d4 ff ff       	call   21 <outb>
		outb(PIT1_CH0, (div >> 8) & 0xff);
    2baa:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    2bae:	66 c1 e8 08          	shr    ax,0x8
    2bb2:	0f b6 c0             	movzx  eax,al
    2bb5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2bb9:	c7 04 24 40 00 00 00 	mov    DWORD PTR [esp],0x40
    2bc0:	e8 5c d4 ff ff       	call   21 <outb>
		__asm__("sti");
    2bc5:	fb                   	sti
		calibrate_bogo_mips(div);
    2bc6:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    2bca:	89 04 24             	mov    DWORD PTR [esp],eax
    2bcd:	e8 fc ff ff ff       	call   2bce <timer_setup+0x1c0>
		printf("done\n");
    2bd2:	c7 04 24 07 08 00 00 	mov    DWORD PTR [esp],0x807
    2bd9:	e8 fc ff ff ff       	call   2bda <timer_setup+0x1cc>
		/* testing the resolution */
		printf("delaying execution for 200 ms...\n");
    2bde:	c7 04 24 10 08 00 00 	mov    DWORD PTR [esp],0x810
    2be5:	e8 fc ff ff ff       	call   2be6 <timer_setup+0x1d8>
		tmv = jiffies;
    2bea:	a1 00 00 00 00       	mov    eax,ds:0x0
    2bef:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2bf2:	8b 00                	mov    eax,DWORD PTR [eax]
    2bf4:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    2bf7:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		mdelay(200);
    2bfa:	c7 04 24 c8 00 00 00 	mov    DWORD PTR [esp],0xc8
    2c01:	e8 fc ff ff ff       	call   2c02 <timer_setup+0x1f4>
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
				" to %u ms, resulting in a deviation of %+d ms\n",
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
				(int32_t)((jiffies - tmv) * 1000 / HZ) - 200);
    2c06:	a1 00 00 00 00       	mov    eax,ds:0x0
    2c0b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2c0e:	8b 00                	mov    eax,DWORD PTR [eax]
    2c10:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
    2c13:	1b 55 ec             	sbb    edx,DWORD PTR [ebp-0x14]
    2c16:	89 c1                	mov    ecx,eax
    2c18:	89 d3                	mov    ebx,edx
    2c1a:	89 c8                	mov    eax,ecx
    2c1c:	89 da                	mov    edx,ebx
    2c1e:	0f a4 c2 05          	shld   edx,eax,0x5
    2c22:	c1 e0 05             	shl    eax,0x5
    2c25:	29 c8                	sub    eax,ecx
    2c27:	19 da                	sbb    edx,ebx
    2c29:	0f a4 c2 02          	shld   edx,eax,0x2
    2c2d:	c1 e0 02             	shl    eax,0x2
    2c30:	01 c8                	add    eax,ecx
    2c32:	11 da                	adc    edx,ebx
    2c34:	0f a4 c2 03          	shld   edx,eax,0x3
    2c38:	c1 e0 03             	shl    eax,0x3
    2c3b:	c7 44 24 08 79 00 00 00 	mov    DWORD PTR [esp+0x8],0x79
    2c43:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2c4b:	89 04 24             	mov    DWORD PTR [esp],eax
    2c4e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2c52:	e8 fc ff ff ff       	call   2c53 <timer_setup+0x245>
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2c57:	8d b0 38 ff ff ff    	lea    esi,[eax-0xc8]
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
    2c5d:	a1 00 00 00 00       	mov    eax,ds:0x0
    2c62:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2c65:	8b 00                	mov    eax,DWORD PTR [eax]
    2c67:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
    2c6a:	1b 55 ec             	sbb    edx,DWORD PTR [ebp-0x14]
    2c6d:	89 c1                	mov    ecx,eax
    2c6f:	89 d3                	mov    ebx,edx
    2c71:	89 c8                	mov    eax,ecx
    2c73:	89 da                	mov    edx,ebx
    2c75:	0f a4 c2 05          	shld   edx,eax,0x5
    2c79:	c1 e0 05             	shl    eax,0x5
    2c7c:	29 c8                	sub    eax,ecx
    2c7e:	19 da                	sbb    edx,ebx
    2c80:	0f a4 c2 02          	shld   edx,eax,0x2
    2c84:	c1 e0 02             	shl    eax,0x2
    2c87:	01 c8                	add    eax,ecx
    2c89:	11 da                	adc    edx,ebx
    2c8b:	0f a4 c2 03          	shld   edx,eax,0x3
    2c8f:	c1 e0 03             	shl    eax,0x3
    2c92:	c7 44 24 08 79 00 00 00 	mov    DWORD PTR [esp+0x8],0x79
    2c9a:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2ca2:	89 04 24             	mov    DWORD PTR [esp],eax
    2ca5:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2ca9:	e8 fc ff ff ff       	call   2caa <timer_setup+0x29c>
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2cae:	89 c1                	mov    ecx,eax
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
    2cb0:	a1 00 00 00 00       	mov    eax,ds:0x0
    2cb5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2cb8:	8b 00                	mov    eax,DWORD PTR [eax]
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2cba:	89 c2                	mov    edx,eax
    2cbc:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2cbf:	29 c2                	sub    edx,eax
    2cc1:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    2cc5:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    2cc9:	c7 44 24 0c 79 00 00 00 	mov    DWORD PTR [esp+0xc],0x79
    2cd1:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2cd5:	c7 44 24 04 34 08 00 00 	mov    DWORD PTR [esp+0x4],0x834
    2cdd:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2ce4:	e8 fc ff ff ff       	call   2ce5 <timer_setup+0x2d7>
}
    2ce9:	90                   	nop
    2cea:	8d 65 f8             	lea    esp,[ebp-0x8]
    2ced:	5b                   	pop    ebx
    2cee:	5e                   	pop    esi
    2cef:	5d                   	pop    ebp
    2cf0:	c3                   	ret

00002cf1 <apic_tick>:

//uint32_t apic_tick_ct = 0;
void apic_tick()
{
    2cf1:	55                   	push   ebp
    2cf2:	89 e5                	mov    ebp,esp
		//apic_tick_ct++;
		//if (apic_tick_ct % (10 * nproc * HZ) == 0)
		//		printf("APIC %08x received timer interrupt (global ct=%u)\n",
		//				apic_reg(APIC_REG_APICID), apic_tick_ct);
		apic_reg(APIC_REG_TMRINITCNT) = apic_reload_value;
    2cf4:	e8 07 d3 ff ff       	call   0 <per_cpu_ptr>
    2cf9:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2cfc:	8d 90 80 03 00 00    	lea    edx,[eax+0x380]
    2d02:	a1 00 00 00 00       	mov    eax,ds:0x0
    2d07:	89 02                	mov    DWORD PTR [edx],eax
		per_cpu_ptr()->ticks->tick++;
    2d09:	e8 f2 d2 ff ff       	call   0 <per_cpu_ptr>
    2d0e:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
    2d11:	8b 01                	mov    eax,DWORD PTR [ecx]
    2d13:	8b 51 04             	mov    edx,DWORD PTR [ecx+0x4]
    2d16:	83 c0 01             	add    eax,0x1
    2d19:	83 d2 00             	adc    edx,0x0
    2d1c:	89 01                	mov    DWORD PTR [ecx],eax
    2d1e:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
}
    2d21:	90                   	nop
    2d22:	5d                   	pop    ebp
    2d23:	c3                   	ret

00002d24 <apic_ipi>:

void apic_ipi()
{
    2d24:	55                   	push   ebp
    2d25:	89 e5                	mov    ebp,esp
    2d27:	53                   	push   ebx
    2d28:	83 ec 14             	sub    esp,0x14
		printf("APIC %x (TPR=%x) received IPI\n", apic_reg(APIC_REG_APICID),
				apic_reg(APIC_REG_TASKPRIOR));
    2d2b:	e8 d0 d2 ff ff       	call   0 <per_cpu_ptr>
    2d30:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2d33:	83 e8 80             	sub    eax,0xffffff80
		printf("APIC %x (TPR=%x) received IPI\n", apic_reg(APIC_REG_APICID),
    2d36:	8b 18                	mov    ebx,DWORD PTR [eax]
    2d38:	e8 c3 d2 ff ff       	call   0 <per_cpu_ptr>
    2d3d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2d40:	83 c0 20             	add    eax,0x20
    2d43:	8b 00                	mov    eax,DWORD PTR [eax]
    2d45:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
    2d49:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2d4d:	c7 04 24 98 08 00 00 	mov    DWORD PTR [esp],0x898
    2d54:	e8 fc ff ff ff       	call   2d55 <apic_ipi+0x31>
		//printf("Current timer value %x\n", apic_reg(APIC_REG_TMRCURRCNT));
}
    2d59:	90                   	nop
    2d5a:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2d5d:	c9                   	leave
    2d5e:	c3                   	ret

00002d5f <ap_entry>:

/* kernel entry point of APs */
extern void ap_entry()
{
    2d5f:	55                   	push   ebp
    2d60:	89 e5                	mov    ebp,esp
    2d62:	83 ec 18             	sub    esp,0x18
		void enable_sse();
		enable_sse(); /* avoid hangups form sched. kredraw (using sse) */
    2d65:	e8 fc ff ff ff       	call   2d66 <ap_entry+0x7>
		/* local APIC init */
		extern void ap_apic_init(); /* PCP works afterwards */
		ap_apic_init();
    2d6a:	e8 fc ff ff ff       	call   2d6b <ap_entry+0xc>
		/* prevent death by empty queues */
		extern void kidle(void*);
		/* two per proc for the worst-case */
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2d6f:	c7 44 24 0c b7 08 00 00 	mov    DWORD PTR [esp+0xc],0x8b7
    2d77:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    2d7f:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2d87:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2d8e:	e8 fc ff ff ff       	call   2d8f <ap_entry+0x30>
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2d93:	c7 44 24 0c b7 08 00 00 	mov    DWORD PTR [esp+0xc],0x8b7
    2d9b:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    2da3:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2dab:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2db2:	e8 fc ff ff ff       	call   2db3 <ap_entry+0x54>
		/* signal we don't need the trampoline anymore */
		extern uint8_t ap_start;
		ap_start = 0; /* still unsafe as task_schedule builds a stack frame */
    2db7:	c6 05 00 00 00 00 00 	mov    BYTE PTR ds:0x0,0x0
		/* TODO: per-cpu tasks & runqueues */
		/* switch to stack of task (sti included in eflags of tasks) */
		extern void task_schedule(struct tsi*);
		task_schedule(NULL);
    2dbe:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2dc5:	e8 fc ff ff ff       	call   2dc6 <ap_entry+0x67>
		/* should never return */
		while (1); /* DBG: busy wait */
    2dca:	90                   	nop
    2dcb:	eb fd                	jmp    2dca <ap_entry+0x6b>

00002dcd <apic_handler>:
 * TSS stacks can also be transferred between processors -> all stacks bound to
 * tasks, i.e. no processor-specific stacks needed.
 */

extern void apic_handler(uint32_t intr)
{
    2dcd:	55                   	push   ebp
    2dce:	89 e5                	mov    ebp,esp
    2dd0:	53                   	push   ebx
    2dd1:	83 ec 24             	sub    esp,0x24
		static uint32_t num_spr = 0;
		switch (intr) {
    2dd4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2dd7:	83 f8 03             	cmp    eax,0x3
    2dda:	0f 84 ca 00 00 00    	je     2eaa <apic_handler+0xdd>
    2de0:	83 f8 03             	cmp    eax,0x3
    2de3:	0f 87 d0 00 00 00    	ja     2eb9 <apic_handler+0xec>
    2de9:	83 f8 02             	cmp    eax,0x2
    2dec:	0f 84 9e 00 00 00    	je     2e90 <apic_handler+0xc3>
    2df2:	83 f8 02             	cmp    eax,0x2
    2df5:	0f 87 be 00 00 00    	ja     2eb9 <apic_handler+0xec>
    2dfb:	85 c0                	test   eax,eax
    2dfd:	74 0a                	je     2e09 <apic_handler+0x3c>
    2dff:	83 f8 01             	cmp    eax,0x1
    2e02:	74 5d                	je     2e61 <apic_handler+0x94>
    2e04:	e9 b0 00 00 00       	jmp    2eb9 <apic_handler+0xec>
			case 0:
				printf("APIC %x received error %08x\n",
					apic_reg(APIC_REG_APICID), apic_reg(APIC_REG_ESR));
    2e09:	e8 f2 d1 ff ff       	call   0 <per_cpu_ptr>
    2e0e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2e11:	05 80 02 00 00       	add    eax,0x280
				printf("APIC %x received error %08x\n",
    2e16:	8b 18                	mov    ebx,DWORD PTR [eax]
					apic_reg(APIC_REG_APICID), apic_reg(APIC_REG_ESR));
    2e18:	e8 e3 d1 ff ff       	call   0 <per_cpu_ptr>
    2e1d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2e20:	83 c0 20             	add    eax,0x20
				printf("APIC %x received error %08x\n",
    2e23:	8b 00                	mov    eax,DWORD PTR [eax]
    2e25:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
    2e29:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e2d:	c7 04 24 bd 08 00 00 	mov    DWORD PTR [esp],0x8bd
    2e34:	e8 fc ff ff ff       	call   2e35 <apic_handler+0x68>
				/* rearm the error register */
				apic_reg(APIC_REG_ESR) = 0;
    2e39:	e8 c2 d1 ff ff       	call   0 <per_cpu_ptr>
    2e3e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2e41:	05 80 02 00 00       	add    eax,0x280
    2e46:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				apic_reg(APIC_REG_EOI) = 0;
    2e4c:	e8 af d1 ff ff       	call   0 <per_cpu_ptr>
    2e51:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2e54:	05 b0 00 00 00       	add    eax,0xb0
    2e59:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				break;
    2e5f:	eb 74                	jmp    2ed5 <apic_handler+0x108>
			case 1: {
				void (*hook)() = apic_hook;
    2e61:	a1 00 00 00 00       	mov    eax,ds:0x0
    2e66:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (hook)
    2e69:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2e6d:	74 07                	je     2e76 <apic_handler+0xa9>
						hook();
    2e6f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2e72:	ff d0                	call   eax
    2e74:	eb 05                	jmp    2e7b <apic_handler+0xae>
				else
						apic_tick();
    2e76:	e8 fc ff ff ff       	call   2e77 <apic_handler+0xaa>
				apic_reg(APIC_REG_EOI) = 0;
    2e7b:	e8 80 d1 ff ff       	call   0 <per_cpu_ptr>
    2e80:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2e83:	05 b0 00 00 00       	add    eax,0xb0
    2e88:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				break;
    2e8e:	eb 45                	jmp    2ed5 <apic_handler+0x108>
				}
			case 2:
				apic_ipi();
    2e90:	e8 fc ff ff ff       	call   2e91 <apic_handler+0xc4>
				apic_reg(APIC_REG_EOI) = 0;
    2e95:	e8 66 d1 ff ff       	call   0 <per_cpu_ptr>
    2e9a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2e9d:	05 b0 00 00 00       	add    eax,0xb0
    2ea2:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				break;
    2ea8:	eb 2b                	jmp    2ed5 <apic_handler+0x108>
			case 3: /* don't ack the spurious interrupt */
				num_spr++;
    2eaa:	a1 68 02 00 00       	mov    eax,ds:0x268
    2eaf:	83 c0 01             	add    eax,0x1
    2eb2:	a3 68 02 00 00       	mov    ds:0x268,eax
				break;
    2eb7:	eb 1c                	jmp    2ed5 <apic_handler+0x108>
			default:
				cprintf(KFMT_WARN, "unknown APIC intr %x received\n", intr);
    2eb9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2ebc:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2ec0:	c7 44 24 04 dc 08 00 00 	mov    DWORD PTR [esp+0x4],0x8dc
    2ec8:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    2ecf:	e8 fc ff ff ff       	call   2ed0 <apic_handler+0x103>
				break;
    2ed4:	90                   	nop
		}
		if (intr == 1) {
    2ed5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2ed8:	83 f8 01             	cmp    eax,0x1
    2edb:	75 0d                	jne    2eea <apic_handler+0x11d>
				void task_schedule_isr(void*);
				task_schedule_isr(*(void**)(&intr + 1));
    2edd:	8d 45 0c             	lea    eax,[ebp+0xc]
    2ee0:	8b 00                	mov    eax,DWORD PTR [eax]
    2ee2:	89 04 24             	mov    DWORD PTR [esp],eax
    2ee5:	e8 fc ff ff ff       	call   2ee6 <apic_handler+0x119>
		}
}
    2eea:	90                   	nop
    2eeb:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2eee:	c9                   	leave
    2eef:	c3                   	ret

00002ef0 <fun2>:

static int calc_state = 0, calc_thr = 0, calc_print = 0;

void fun2(uint32_t* f) {
    2ef0:	55                   	push   ebp
    2ef1:	89 e5                	mov    ebp,esp
    2ef3:	83 ec 18             	sub    esp,0x18
		while (1) {
				if (!calc_state)
    2ef6:	a1 d8 01 00 00       	mov    eax,ds:0x1d8
    2efb:	85 c0                	test   eax,eax
    2efd:	75 07                	jne    2f06 <fun2+0x16>
						task_yield();
    2eff:	e8 fc ff ff ff       	call   2f00 <fun2+0x10>
    2f04:	eb 28                	jmp    2f2e <fun2+0x3e>
				else {
						int v = calc_thr;
    2f06:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    2f0b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if ((v < 1) && __sync_bool_compare_and_swap(&calc_thr, v, v + 1))
    2f0e:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2f12:	7f 1a                	jg     2f2e <fun2+0x3e>
    2f14:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f17:	83 c0 01             	add    eax,0x1
    2f1a:	89 c2                	mov    edx,eax
    2f1c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f1f:	f0 0f b1 15 dc 01 00 00 	lock cmpxchg DWORD PTR ds:0x1dc,edx
    2f27:	0f 94 c0             	sete   al
    2f2a:	84 c0                	test   al,al
    2f2c:	75 1c                	jne    2f4a <fun2+0x5a>
								break;
				}
				for (size_t i = 0; i < 0xffffffff; i++);
    2f2e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2f35:	eb 04                	jmp    2f3b <fun2+0x4b>
    2f37:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    2f3b:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
    2f3f:	75 f6                	jne    2f37 <fun2+0x47>
				__sync_fetch_and_add(f, 1);
    2f41:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f44:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
				if (!calc_state)
    2f48:	eb ac                	jmp    2ef6 <fun2+0x6>
								break;
    2f4a:	90                   	nop
		}
}
    2f4b:	90                   	nop
    2f4c:	c9                   	leave
    2f4d:	c3                   	ret

00002f4e <calc_thread>:

void calc_thread(void* data)
{
    2f4e:	55                   	push   ebp
    2f4f:	89 e5                	mov    ebp,esp
    2f51:	53                   	push   ebx
    2f52:	83 ec 34             	sub    esp,0x34
		uint32_t val = 0; uint64_t to = 0; int upd;
    2f55:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    2f5c:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    2f63:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		calc_state = 1;
    2f6a:	c7 05 d8 01 00 00 01 00 00 00 	mov    DWORD PTR ds:0x1d8,0x1
		/* test er */
		/* here we do the integer calculations */
		while (1) {
				if (!calc_state)
    2f74:	a1 d8 01 00 00       	mov    eax,ds:0x1d8
    2f79:	85 c0                	test   eax,eax
    2f7b:	75 05                	jne    2f82 <calc_thread+0x34>
						task_yield();
    2f7d:	e8 fc ff ff ff       	call   2f7e <calc_thread+0x30>
				for (size_t i = 0; i < 0xffffffff; i++);
    2f82:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    2f89:	eb 04                	jmp    2f8f <calc_thread+0x41>
    2f8b:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    2f8f:	83 7d ec ff          	cmp    DWORD PTR [ebp-0x14],0xffffffff
    2f93:	75 f6                	jne    2f8b <calc_thread+0x3d>
				__sync_fetch_and_add(&val, 1);
    2f95:	f0 83 45 e4 01       	lock add DWORD PTR [ebp-0x1c],0x1
				upd = time_after(jiffies, to);
    2f9a:	a1 00 00 00 00       	mov    eax,ds:0x0
    2f9f:	8b 08                	mov    ecx,DWORD PTR [eax]
    2fa1:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    2fa4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2fa7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2faa:	29 c8                	sub    eax,ecx
    2fac:	19 da                	sbb    edx,ebx
    2fae:	89 d0                	mov    eax,edx
    2fb0:	31 d2                	xor    edx,edx
    2fb2:	c1 e8 1f             	shr    eax,0x1f
    2fb5:	0f b6 c0             	movzx  eax,al
    2fb8:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (calc_print == 1 || (calc_print == 2 && upd)){
    2fbb:	a1 e0 01 00 00       	mov    eax,ds:0x1e0
    2fc0:	83 f8 01             	cmp    eax,0x1
    2fc3:	74 10                	je     2fd5 <calc_thread+0x87>
    2fc5:	a1 e0 01 00 00       	mov    eax,ds:0x1e0
    2fca:	83 f8 02             	cmp    eax,0x2
    2fcd:	75 79                	jne    3048 <calc_thread+0xfa>
    2fcf:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    2fd3:	74 73                	je     3048 <calc_thread+0xfa>
						printf("calculation result: %u\n", val);
    2fd5:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2fd8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2fdc:	c7 04 24 fb 08 00 00 	mov    DWORD PTR [esp],0x8fb
    2fe3:	e8 fc ff ff ff       	call   2fe4 <calc_thread+0x96>
						if (calc_print == 2)
    2fe8:	a1 e0 01 00 00       	mov    eax,ds:0x1e0
    2fed:	83 f8 02             	cmp    eax,0x2
    2ff0:	75 1a                	jne    300c <calc_thread+0xbe>
								to = jiffies + 5 * HZ; /* print every 5 seconds */
    2ff2:	a1 00 00 00 00       	mov    eax,ds:0x0
    2ff7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2ffa:	8b 00                	mov    eax,DWORD PTR [eax]
    2ffc:	05 5d 02 00 00       	add    eax,0x25d
    3001:	83 d2 00             	adc    edx,0x0
    3004:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    3007:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    300a:	eb 3c                	jmp    3048 <calc_thread+0xfa>
						else
								calc_print = 0; /* print once */
    300c:	c7 05 e0 01 00 00 00 00 00 00 	mov    DWORD PTR ds:0x1e0,0x0
				}
				while (calc_thr >= 2) {
    3016:	eb 30                	jmp    3048 <calc_thread+0xfa>
						task_spawn(fun2, &val, PRIORITY_REGULAR);
    3018:	c7 44 24 0c 13 09 00 00 	mov    DWORD PTR [esp+0xc],0x913
    3020:	c7 44 24 08 02 00 00 00 	mov    DWORD PTR [esp+0x8],0x2
    3028:	8d 45 e4             	lea    eax,[ebp-0x1c]
    302b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    302f:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    3036:	e8 fc ff ff ff       	call   3037 <calc_thread+0xe9>
						calc_thr--;
    303b:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    3040:	83 e8 01             	sub    eax,0x1
    3043:	a3 dc 01 00 00       	mov    ds:0x1dc,eax
				while (calc_thr >= 2) {
    3048:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    304d:	83 f8 01             	cmp    eax,0x1
    3050:	7f c6                	jg     3018 <calc_thread+0xca>
				if (!calc_state)
    3052:	e9 1d ff ff ff       	jmp    2f74 <calc_thread+0x26>

00003057 <calc_fun>:
				}
		}
}

void calc_fun(const char* arg)
{
    3057:	55                   	push   ebp
    3058:	89 e5                	mov    ebp,esp
    305a:	83 ec 28             	sub    esp,0x28
		int sel = atoi(arg);
    305d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3060:	89 04 24             	mov    DWORD PTR [esp],eax
    3063:	e8 fc ff ff ff       	call   3064 <calc_fun+0xd>
    3068:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		switch (sel) {
    306b:	83 7d f4 09          	cmp    DWORD PTR [ebp-0xc],0x9
    306f:	77 0f                	ja     3080 <calc_fun+0x29>
    3071:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3074:	c1 e0 02             	shl    eax,0x2
    3077:	05 e0 0a 00 00       	add    eax,0xae0
    307c:	8b 00                	mov    eax,DWORD PTR [eax]
    307e:	ff e0                	jmp    eax
			case 0:
			default:
				printf("calc arg: starts/stops and shows the background\n"
    3080:	c7 04 24 18 09 00 00 	mov    DWORD PTR [esp],0x918
    3087:	e8 fc ff ff ff       	call   3088 <calc_fun+0x31>
					   "          5 - add a worker thread\n"
					   "          6 - add 5 worker threads\n"
					   "          7 - add 15 worker threads\n"
					   "          8 - remove a worker thread\n"
					   "          9 - remove 5 worker threads\n");
				break;
    308c:	e9 fd 00 00 00       	jmp    318e <calc_fun+0x137>
			case 1:
				calc_state = 0;
    3091:	c7 05 d8 01 00 00 00 00 00 00 	mov    DWORD PTR ds:0x1d8,0x0
				break;
    309b:	e9 ee 00 00 00       	jmp    318e <calc_fun+0x137>
			case 2:
				if (!calc_thr) {
    30a0:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    30a5:	85 c0                	test   eax,eax
    30a7:	75 33                	jne    30dc <calc_fun+0x85>
						task_spawn(calc_thread, NULL, PRIORITY_REGULAR);
    30a9:	c7 44 24 0c d3 0a 00 00 	mov    DWORD PTR [esp+0xc],0xad3
    30b1:	c7 44 24 08 02 00 00 00 	mov    DWORD PTR [esp+0x8],0x2
    30b9:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    30c1:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    30c8:	e8 fc ff ff ff       	call   30c9 <calc_fun+0x72>
						calc_thr = 1;
    30cd:	c7 05 dc 01 00 00 01 00 00 00 	mov    DWORD PTR ds:0x1dc,0x1
						//calc_state = 1;
				} else
						calc_state = 1;
				break;
    30d7:	e9 b2 00 00 00       	jmp    318e <calc_fun+0x137>
						calc_state = 1;
    30dc:	c7 05 d8 01 00 00 01 00 00 00 	mov    DWORD PTR ds:0x1d8,0x1
				break;
    30e6:	e9 a3 00 00 00       	jmp    318e <calc_fun+0x137>
			case 3:
				calc_print = 1;
    30eb:	c7 05 e0 01 00 00 01 00 00 00 	mov    DWORD PTR ds:0x1e0,0x1
				break;
    30f5:	e9 94 00 00 00       	jmp    318e <calc_fun+0x137>
			case 4:
				calc_print = 2;
    30fa:	c7 05 e0 01 00 00 02 00 00 00 	mov    DWORD PTR ds:0x1e0,0x2
				break;
    3104:	e9 85 00 00 00       	jmp    318e <calc_fun+0x137>
			case 5:
				if (calc_thr)
    3109:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    310e:	85 c0                	test   eax,eax
    3110:	74 6f                	je     3181 <calc_fun+0x12a>
						calc_thr++;
    3112:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    3117:	83 c0 01             	add    eax,0x1
    311a:	a3 dc 01 00 00       	mov    ds:0x1dc,eax
				break;
    311f:	eb 60                	jmp    3181 <calc_fun+0x12a>
			case 6:
				if (calc_thr)
    3121:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    3126:	85 c0                	test   eax,eax
    3128:	74 5a                	je     3184 <calc_fun+0x12d>
						calc_thr += 5;
    312a:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    312f:	83 c0 05             	add    eax,0x5
    3132:	a3 dc 01 00 00       	mov    ds:0x1dc,eax
				break;
    3137:	eb 4b                	jmp    3184 <calc_fun+0x12d>
			case 7:
				if (calc_thr)
    3139:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    313e:	85 c0                	test   eax,eax
    3140:	74 45                	je     3187 <calc_fun+0x130>
						calc_thr += 15;
    3142:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    3147:	83 c0 0f             	add    eax,0xf
    314a:	a3 dc 01 00 00       	mov    ds:0x1dc,eax
				break;
    314f:	eb 36                	jmp    3187 <calc_fun+0x130>
			case 8:
				if (calc_thr)
    3151:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    3156:	85 c0                	test   eax,eax
    3158:	74 30                	je     318a <calc_fun+0x133>
						calc_thr--;
    315a:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    315f:	83 e8 01             	sub    eax,0x1
    3162:	a3 dc 01 00 00       	mov    ds:0x1dc,eax
				break;
    3167:	eb 21                	jmp    318a <calc_fun+0x133>
			case 9:
				if (calc_thr)
    3169:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    316e:	85 c0                	test   eax,eax
    3170:	74 1b                	je     318d <calc_fun+0x136>
						calc_thr -= 5;
    3172:	a1 dc 01 00 00       	mov    eax,ds:0x1dc
    3177:	83 e8 05             	sub    eax,0x5
    317a:	a3 dc 01 00 00       	mov    ds:0x1dc,eax
				break;
    317f:	eb 0c                	jmp    318d <calc_fun+0x136>
				break;
    3181:	90                   	nop
    3182:	eb 0a                	jmp    318e <calc_fun+0x137>
				break;
    3184:	90                   	nop
    3185:	eb 07                	jmp    318e <calc_fun+0x137>
				break;
    3187:	90                   	nop
    3188:	eb 04                	jmp    318e <calc_fun+0x137>
				break;
    318a:	90                   	nop
    318b:	eb 01                	jmp    318e <calc_fun+0x137>
				break;
    318d:	90                   	nop
		}
}
    318e:	90                   	nop
    318f:	c9                   	leave
    3190:	c3                   	ret

00003191 <enable_sse>:
		} while ((unsigned int)((double)(counter - now) / CLOCKS_PER_SEC) < seconds);
		return 0;
}*/

void enable_sse()
{
    3191:	55                   	push   ebp
    3192:	89 e5                	mov    ebp,esp
    3194:	53                   	push   ebx
    3195:	83 ec 10             	sub    esp,0x10
		/* enable SSE if present */
		uint32_t eax, ebx, ecx, edx;
		__cpuid(1, eax, ebx, ecx, edx);
    3198:	b8 01 00 00 00       	mov    eax,0x1
    319d:	b9 00 00 00 00       	mov    ecx,0x0
    31a2:	ba 00 00 00 00       	mov    edx,0x0
    31a7:	89 cb                	mov    ebx,ecx
    31a9:	89 d1                	mov    ecx,edx
    31ab:	0f a2                	cpuid
    31ad:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    31b0:	89 5d f4             	mov    DWORD PTR [ebp-0xc],ebx
    31b3:	89 4d f0             	mov    DWORD PTR [ebp-0x10],ecx
    31b6:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		if (edx & (1<< 25)) {
    31b9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    31bc:	25 00 00 00 02       	and    eax,0x2000000
    31c1:	85 c0                	test   eax,eax
    31c3:	74 17                	je     31dc <enable_sse+0x4b>
					"mov %%cr4, %%rax\n"
					"or $0x0600, %%ax\n"
					"mov %%rax, %%cr4\n"
					: : : "rax");
#else
				asm("mov %%cr0, %%eax\n"
    31c5:	0f 20 c0             	mov    eax,cr0
    31c8:	83 c8 02             	or     eax,0x2
    31cb:	83 e0 fb             	and    eax,0xfffffffb
    31ce:	0f 22 c0             	mov    cr0,eax
					"or $2, %%eax\n"
					"and $0xfffffffb, %%eax\n"
					"mov %%eax, %%cr0\n"
					: : : "eax"); /* clear em(2); set mp(1) bit */
				asm("mov %%cr4, %%eax\n"
    31d1:	0f 20 e0             	mov    eax,cr4
    31d4:	0d 00 06 00 00       	or     eax,0x600
    31d9:	0f 22 e0             	mov    cr4,eax
					"or $0x00000600, %%eax\n"
					"mov %%eax, %%cr4\n"
					: : : "eax"); /* set oxfxsr osxmmexcpt */
#endif
		}
}
    31dc:	90                   	nop
    31dd:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    31e0:	c9                   	leave
    31e1:	c3                   	ret

000031e2 <do_cpuid>:

void do_cpuid()
{
    31e2:	55                   	push   ebp
    31e3:	89 e5                	mov    ebp,esp
    31e5:	53                   	push   ebx
    31e6:	83 ec 28             	sub    esp,0x28
		uint32_t eax, ebx, ecx, edx;
		cpu.max_leaf = __get_cpuid_max(0, NULL);
    31e9:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    31f1:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    31f8:	e8 b7 ce ff ff       	call   b4 <__get_cpuid_max>
    31fd:	a3 00 00 00 00       	mov    ds:0x0,eax
		cpu.max_eleaf = __get_cpuid_max(0x80000000, NULL);
    3202:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    320a:	c7 04 24 00 00 00 80 	mov    DWORD PTR [esp],0x80000000
    3211:	e8 9e ce ff ff       	call   b4 <__get_cpuid_max>
    3216:	a3 04 00 00 00       	mov    ds:0x4,eax
		__cpuid(0, eax, ebx, ecx, edx);
    321b:	b8 00 00 00 00       	mov    eax,0x0
    3220:	0f a2                	cpuid
    3222:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    3225:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    3228:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    322b:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		((int*)cpu.vendor_id)[0] = ebx;
    322e:	ba 0c 00 00 00       	mov    edx,0xc
    3233:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    3236:	89 02                	mov    DWORD PTR [edx],eax
		((int*)cpu.vendor_id)[1] = edx;
    3238:	ba 10 00 00 00       	mov    edx,0x10
    323d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3240:	89 02                	mov    DWORD PTR [edx],eax
		((int*)cpu.vendor_id)[2] = ecx;
    3242:	ba 14 00 00 00       	mov    edx,0x14
    3247:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    324a:	89 02                	mov    DWORD PTR [edx],eax
		((int*)cpu.vendor_id)[3] = 0;
    324c:	b8 18 00 00 00       	mov    eax,0x18
    3251:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		if (cpu.max_leaf > 0) {
    3257:	a1 00 00 00 00       	mov    eax,ds:0x0
    325c:	85 c0                	test   eax,eax
    325e:	74 41                	je     32a1 <do_cpuid+0xbf>
				__cpuid(1, eax, ebx, ecx, edx);
    3260:	b8 01 00 00 00       	mov    eax,0x1
    3265:	b9 00 00 00 00       	mov    ecx,0x0
    326a:	ba 00 00 00 00       	mov    edx,0x0
    326f:	89 cb                	mov    ebx,ecx
    3271:	89 d1                	mov    ecx,edx
    3273:	0f a2                	cpuid
    3275:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    3278:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    327b:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    327e:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				cpu.feat_eax = eax;
    3281:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3284:	a3 4c 00 00 00       	mov    ds:0x4c,eax
				cpu.feat_ecx = ecx;
    3289:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    328c:	a3 54 00 00 00       	mov    ds:0x54,eax
				cpu.feat_edx = edx;
    3291:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3294:	a3 58 00 00 00       	mov    ds:0x58,eax
				cpu.feat_ebx = ebx;
    3299:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    329c:	a3 50 00 00 00       	mov    ds:0x50,eax
		}
		if (cpu.max_eleaf > 0x80000000) {
    32a1:	a1 04 00 00 00       	mov    eax,ds:0x4
    32a6:	3d 00 00 00 80       	cmp    eax,0x80000000
    32ab:	76 33                	jbe    32e0 <do_cpuid+0xfe>
				__cpuid(0x80000001, eax, ebx, ecx, edx);
    32ad:	b8 01 00 00 80       	mov    eax,0x80000001
    32b2:	0f a2                	cpuid
    32b4:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    32b7:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    32ba:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    32bd:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				cpu.efeat_eax = eax;
    32c0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    32c3:	a3 5c 00 00 00       	mov    ds:0x5c,eax
				cpu.efeat_ebx = ebx;
    32c8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    32cb:	a3 60 00 00 00       	mov    ds:0x60,eax
				cpu.efeat_ecx = ecx;
    32d0:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    32d3:	a3 64 00 00 00       	mov    ds:0x64,eax
				cpu.efeat_edx = edx;
    32d8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    32db:	a3 68 00 00 00       	mov    ds:0x68,eax
		}
		cpu.brand_string[0] = '\0';
    32e0:	c6 05 1c 00 00 00 00 	mov    BYTE PTR ds:0x1c,0x0
		if (cpu.max_eleaf > 0x80000003) {
    32e7:	a1 04 00 00 00       	mov    eax,ds:0x4
    32ec:	3d 03 00 00 80       	cmp    eax,0x80000003
    32f1:	76 76                	jbe    3369 <do_cpuid+0x187>
				/* get the brand string */
				uint32_t* pt = (uint32_t*)cpu.brand_string;
    32f3:	c7 45 f8 1c 00 00 00 	mov    DWORD PTR [ebp-0x8],0x1c
				for (uint32_t i = 1; i < 4; i++) {
    32fa:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
    3301:	eb 60                	jmp    3363 <do_cpuid+0x181>
						__cpuid(0x80000001 + i, eax, ebx, ecx, edx);
    3303:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3306:	2d ff ff ff 7f       	sub    eax,0x7fffffff
    330b:	b9 00 00 00 00       	mov    ecx,0x0
    3310:	ba 00 00 00 00       	mov    edx,0x0
    3315:	89 cb                	mov    ebx,ecx
    3317:	89 d1                	mov    ecx,edx
    3319:	0f a2                	cpuid
    331b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    331e:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    3321:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    3324:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						*pt++ = eax;
    3327:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    332a:	8d 50 04             	lea    edx,[eax+0x4]
    332d:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
    3330:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    3333:	89 10                	mov    DWORD PTR [eax],edx
						*pt++ = ebx;
    3335:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    3338:	8d 50 04             	lea    edx,[eax+0x4]
    333b:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
    333e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    3341:	89 10                	mov    DWORD PTR [eax],edx
						*pt++ = ecx;
    3343:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    3346:	8d 50 04             	lea    edx,[eax+0x4]
    3349:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
    334c:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    334f:	89 10                	mov    DWORD PTR [eax],edx
						*pt++ = edx;
    3351:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    3354:	8d 50 04             	lea    edx,[eax+0x4]
    3357:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
    335a:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    335d:	89 10                	mov    DWORD PTR [eax],edx
				for (uint32_t i = 1; i < 4; i++) {
    335f:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    3363:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    3367:	76 9a                	jbe    3303 <do_cpuid+0x121>
				}
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
    3369:	a1 04 00 00 00       	mov    eax,ds:0x4
    336e:	3d 06 00 00 80       	cmp    eax,0x80000006
    3373:	76 36                	jbe    33ab <do_cpuid+0x1c9>
    3375:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    337c:	83 e0 10             	and    eax,0x10
    337f:	84 c0                	test   al,al
    3381:	74 28                	je     33ab <do_cpuid+0x1c9>
				/* get invariant tsc */
				__cpuid(0x80000007, eax, ebx, ecx, edx);
    3383:	b8 07 00 00 80       	mov    eax,0x80000007
    3388:	0f a2                	cpuid
    338a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    338d:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    3390:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    3393:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				cpu.invariant_tsc = !!(edx & (1 << 8));
    3396:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3399:	25 00 01 00 00       	and    eax,0x100
    339e:	85 c0                	test   eax,eax
    33a0:	0f 95 c0             	setne  al
    33a3:	0f b6 c0             	movzx  eax,al
    33a6:	a3 6c 00 00 00       	mov    ds:0x6c,eax
		}

		/* FIXME: using enable_sse due to framebuffer on x64 */
		enable_sse();
    33ab:	e8 fc ff ff ff       	call   33ac <do_cpuid+0x1ca>
}
    33b0:	90                   	nop
    33b1:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    33b4:	c9                   	leave
    33b5:	c3                   	ret

000033b6 <cpu_info>:
void cpu_info()
{
    33b6:	55                   	push   ebp
    33b7:	89 e5                	mov    ebp,esp
    33b9:	83 ec 18             	sub    esp,0x18
		printf("This cpu is \"%s\" and supports %u cpuid leaves and %u extended cpuid leaves\n",
						cpu.vendor_id, cpu.max_leaf, cpu.max_eleaf - 0x80000000);
    33bc:	a1 04 00 00 00       	mov    eax,ds:0x4
		printf("This cpu is \"%s\" and supports %u cpuid leaves and %u extended cpuid leaves\n",
    33c1:	8d 90 00 00 00 80    	lea    edx,[eax-0x80000000]
    33c7:	a1 00 00 00 00       	mov    eax,ds:0x0
    33cc:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    33d0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    33d4:	c7 44 24 04 0c 00 00 00 	mov    DWORD PTR [esp+0x4],0xc
    33dc:	c7 04 24 08 0b 00 00 	mov    DWORD PTR [esp],0xb08
    33e3:	e8 fc ff ff ff       	call   33e4 <cpu_info+0x2e>
		/* TODO: DBG! */
		//cpu.has_htt = 1;
		printf("Its main features are:\n");
    33e8:	c7 04 24 54 0b 00 00 	mov    DWORD PTR [esp],0xb54
    33ef:	e8 fc ff ff ff       	call   33f0 <cpu_info+0x3a>
		if (cpu.has_htt)
    33f4:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
    33fb:	83 e0 10             	and    eax,0x10
    33fe:	84 c0                	test   al,al
    3400:	74 0c                	je     340e <cpu_info+0x58>
				printf("\tHyper-threading\n");
    3402:	c7 04 24 6c 0b 00 00 	mov    DWORD PTR [esp],0xb6c
    3409:	e8 fc ff ff ff       	call   340a <cpu_info+0x54>
		if (cpu.has_pae)
    340e:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    3415:	83 e0 40             	and    eax,0x40
    3418:	84 c0                	test   al,al
    341a:	74 0c                	je     3428 <cpu_info+0x72>
				printf("\tPAE\n");
    341c:	c7 04 24 7e 0b 00 00 	mov    DWORD PTR [esp],0xb7e
    3423:	e8 fc ff ff ff       	call   3424 <cpu_info+0x6e>
		if (cpu.has_apic)
    3428:	0f b6 05 59 00 00 00 	movzx  eax,BYTE PTR ds:0x59
    342f:	83 e0 02             	and    eax,0x2
    3432:	84 c0                	test   al,al
    3434:	74 0c                	je     3442 <cpu_info+0x8c>
				printf("\tAPIC\n");
    3436:	c7 04 24 84 0b 00 00 	mov    DWORD PTR [esp],0xb84
    343d:	e8 fc ff ff ff       	call   343e <cpu_info+0x88>
		if (cpu.has_acpi)
    3442:	0f b6 05 5a 00 00 00 	movzx  eax,BYTE PTR ds:0x5a
    3449:	83 e0 40             	and    eax,0x40
    344c:	84 c0                	test   al,al
    344e:	74 0c                	je     345c <cpu_info+0xa6>
				printf("\tACPI\n");
    3450:	c7 04 24 8b 0b 00 00 	mov    DWORD PTR [esp],0xb8b
    3457:	e8 fc ff ff ff       	call   3458 <cpu_info+0xa2>
		printf("All features are:\n");
    345c:	c7 04 24 92 0b 00 00 	mov    DWORD PTR [esp],0xb92
    3463:	e8 fc ff ff ff       	call   3464 <cpu_info+0xae>
		printf("33222222222211111111110000000000\n");
    3468:	c7 04 24 a8 0b 00 00 	mov    DWORD PTR [esp],0xba8
    346f:	e8 fc ff ff ff       	call   3470 <cpu_info+0xba>
		printf("10987654321098765432109876543210\n");
    3474:	c7 04 24 cc 0b 00 00 	mov    DWORD PTR [esp],0xbcc
    347b:	e8 fc ff ff ff       	call   347c <cpu_info+0xc6>
		printf("%032b\n", cpu.feat_eax);
    3480:	a1 4c 00 00 00       	mov    eax,ds:0x4c
    3485:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3489:	c7 04 24 ee 0b 00 00 	mov    DWORD PTR [esp],0xbee
    3490:	e8 fc ff ff ff       	call   3491 <cpu_info+0xdb>
		printf("%032b\n", cpu.feat_ebx);
    3495:	a1 50 00 00 00       	mov    eax,ds:0x50
    349a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    349e:	c7 04 24 ee 0b 00 00 	mov    DWORD PTR [esp],0xbee
    34a5:	e8 fc ff ff ff       	call   34a6 <cpu_info+0xf0>
		printf("%032b\n", cpu.feat_ecx);
    34aa:	a1 54 00 00 00       	mov    eax,ds:0x54
    34af:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    34b3:	c7 04 24 ee 0b 00 00 	mov    DWORD PTR [esp],0xbee
    34ba:	e8 fc ff ff ff       	call   34bb <cpu_info+0x105>
		printf("%032b\n", cpu.feat_edx);
    34bf:	a1 58 00 00 00       	mov    eax,ds:0x58
    34c4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    34c8:	c7 04 24 ee 0b 00 00 	mov    DWORD PTR [esp],0xbee
    34cf:	e8 fc ff ff ff       	call   34d0 <cpu_info+0x11a>
		if (cpu.max_eleaf > 0x80000000) {
    34d4:	a1 04 00 00 00       	mov    eax,ds:0x4
    34d9:	3d 00 00 00 80       	cmp    eax,0x80000000
    34de:	0f 86 d4 00 00 00    	jbe    35b8 <cpu_info+0x202>
				printf("The main extended features are:\n");
    34e4:	c7 04 24 f8 0b 00 00 	mov    DWORD PTR [esp],0xbf8
    34eb:	e8 fc ff ff ff       	call   34ec <cpu_info+0x136>
				if (cpu.e_pat)
    34f0:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
    34f7:	83 e0 01             	and    eax,0x1
    34fa:	84 c0                	test   al,al
    34fc:	74 0c                	je     350a <cpu_info+0x154>
						printf("\tPAT\n");
    34fe:	c7 04 24 19 0c 00 00 	mov    DWORD PTR [esp],0xc19
    3505:	e8 fc ff ff ff       	call   3506 <cpu_info+0x150>
				if (cpu.e_has_mp)
    350a:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
    3511:	83 e0 08             	and    eax,0x8
    3514:	84 c0                	test   al,al
    3516:	74 0c                	je     3524 <cpu_info+0x16e>
						printf("\tMP capable\n");
    3518:	c7 04 24 1f 0c 00 00 	mov    DWORD PTR [esp],0xc1f
    351f:	e8 fc ff ff ff       	call   3520 <cpu_info+0x16a>
				if (cpu.e_has_nx)
    3524:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
    352b:	83 e0 10             	and    eax,0x10
    352e:	84 c0                	test   al,al
    3530:	74 0c                	je     353e <cpu_info+0x188>
						printf("\tNX bit\n");
    3532:	c7 04 24 2c 0c 00 00 	mov    DWORD PTR [esp],0xc2c
    3539:	e8 fc ff ff ff       	call   353a <cpu_info+0x184>
				if (cpu.e_has_longmode)
    353e:	0f b6 05 6b 00 00 00 	movzx  eax,BYTE PTR ds:0x6b
    3545:	83 e0 20             	and    eax,0x20
    3548:	84 c0                	test   al,al
    354a:	74 0c                	je     3558 <cpu_info+0x1a2>
						printf("\tx86_64\n");
    354c:	c7 04 24 35 0c 00 00 	mov    DWORD PTR [esp],0xc35
    3553:	e8 fc ff ff ff       	call   3554 <cpu_info+0x19e>
				printf("All extended features:\n");
    3558:	c7 04 24 3e 0c 00 00 	mov    DWORD PTR [esp],0xc3e
    355f:	e8 fc ff ff ff       	call   3560 <cpu_info+0x1aa>
				printf("%032b\n", cpu.efeat_eax);
    3564:	a1 5c 00 00 00       	mov    eax,ds:0x5c
    3569:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    356d:	c7 04 24 ee 0b 00 00 	mov    DWORD PTR [esp],0xbee
    3574:	e8 fc ff ff ff       	call   3575 <cpu_info+0x1bf>
				printf("%032b\n", cpu.efeat_ebx);
    3579:	a1 60 00 00 00       	mov    eax,ds:0x60
    357e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3582:	c7 04 24 ee 0b 00 00 	mov    DWORD PTR [esp],0xbee
    3589:	e8 fc ff ff ff       	call   358a <cpu_info+0x1d4>
				printf("%032b\n", cpu.efeat_ecx);
    358e:	a1 64 00 00 00       	mov    eax,ds:0x64
    3593:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3597:	c7 04 24 ee 0b 00 00 	mov    DWORD PTR [esp],0xbee
    359e:	e8 fc ff ff ff       	call   359f <cpu_info+0x1e9>
				printf("%032b\n", cpu.efeat_edx);
    35a3:	a1 68 00 00 00       	mov    eax,ds:0x68
    35a8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    35ac:	c7 04 24 ee 0b 00 00 	mov    DWORD PTR [esp],0xbee
    35b3:	e8 fc ff ff ff       	call   35b4 <cpu_info+0x1fe>
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
    35b8:	a1 04 00 00 00       	mov    eax,ds:0x4
    35bd:	3d 06 00 00 80       	cmp    eax,0x80000006
    35c2:	76 33                	jbe    35f7 <cpu_info+0x241>
    35c4:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    35cb:	83 e0 10             	and    eax,0x10
    35ce:	84 c0                	test   al,al
    35d0:	74 25                	je     35f7 <cpu_info+0x241>
				printf("The CPU's TSC is %s rate\n", cpu.invariant_tsc ? "constant" : "variable");
    35d2:	a1 6c 00 00 00       	mov    eax,ds:0x6c
    35d7:	85 c0                	test   eax,eax
    35d9:	74 07                	je     35e2 <cpu_info+0x22c>
    35db:	b8 56 0c 00 00       	mov    eax,0xc56
    35e0:	eb 05                	jmp    35e7 <cpu_info+0x231>
    35e2:	b8 5f 0c 00 00       	mov    eax,0xc5f
    35e7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    35eb:	c7 04 24 68 0c 00 00 	mov    DWORD PTR [esp],0xc68
    35f2:	e8 fc ff ff ff       	call   35f3 <cpu_info+0x23d>
		}
		printf("The brand string is \"%s\"\n", cpu.brand_string);
    35f7:	c7 44 24 04 1c 00 00 00 	mov    DWORD PTR [esp+0x4],0x1c
    35ff:	c7 04 24 82 0c 00 00 	mov    DWORD PTR [esp],0xc82
    3606:	e8 fc ff ff ff       	call   3607 <cpu_info+0x251>
}
    360b:	90                   	nop
    360c:	c9                   	leave
    360d:	c3                   	ret

0000360e <prepare_idt>:
//#	sub edx, 4
//	mov word ptr [edx+idt+2], bx
//	.endm
//#endif
void prepare_idt()
{
    360e:	55                   	push   ebp
    360f:	89 e5                	mov    ebp,esp
    3611:	83 ec 10             	sub    esp,0x10
	/* do the bit shuffling on IDT descriptors */
	struct idt_entry* pt = (struct idt_entry*)&idt;
    3614:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
	struct igate ig;
	size_t count = ((size_t)&idt_end - (size_t)&idt) / sizeof(struct idt_entry);
    361b:	b8 00 00 00 00       	mov    eax,0x0
    3620:	ba 00 00 00 00       	mov    edx,0x0
    3625:	29 d0                	sub    eax,edx
    3627:	c1 e8 03             	shr    eax,0x3
    362a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax

	while (count--) {
    362d:	eb 48                	jmp    3677 <prepare_idt+0x69>
		/* we got to swap the linear address (32/64bt) into the
		 * IDT descriptor format since there's no suitable relocation
		 * available to do it with the linker. */
		ig = *(struct igate*)pt;
    362f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    3632:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3635:	8b 00                	mov    eax,DWORD PTR [eax]
    3637:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    363a:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		pt->offset_1 = ig.fun & 0xffff;
    363d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3640:	89 c2                	mov    edx,eax
    3642:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    3645:	66 89 10             	mov    WORD PTR [eax],dx
		pt->offset_2 = (ig.fun >> 16) & 0xffff;
    3648:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    364b:	c1 e8 10             	shr    eax,0x10
    364e:	89 c2                	mov    edx,eax
    3650:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    3653:	66 89 50 06          	mov    WORD PTR [eax+0x6],dx
#ifdef __x86_64__
		pt->offset_3 = (ig.fun >> 32);
		pt->ist = 0; /* we don't have interrupt stacks so far */
#endif
		pt->selector = ig.sel;
    3657:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    365b:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    365e:	66 89 50 02          	mov    WORD PTR [eax+0x2],dx
		pt->type = ig.type;
    3662:	0f b6 55 f5          	movzx  edx,BYTE PTR [ebp-0xb]
    3666:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    3669:	88 50 05             	mov    BYTE PTR [eax+0x5],dl
		pt->zero = 0;
    366c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    366f:	c6 40 04 00          	mov    BYTE PTR [eax+0x4],0x0
		
		/* advance */
		pt++;
    3673:	83 45 fc 08          	add    DWORD PTR [ebp-0x4],0x8
	while (count--) {
    3677:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    367a:	8d 50 ff             	lea    edx,[eax-0x1]
    367d:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
    3680:	85 c0                	test   eax,eax
    3682:	75 ab                	jne    362f <prepare_idt+0x21>

	}
}
    3684:	90                   	nop
    3685:	90                   	nop
    3686:	c9                   	leave
    3687:	c3                   	ret

00003688 <_start>:

extern void _start()
{
    3688:	55                   	push   ebp
    3689:	89 e5                	mov    ebp,esp
    368b:	83 ec 18             	sub    esp,0x18
		extern int fb_no_malloc;
		/* set cpu to correct values */
		do_cpuid();
    368e:	e8 fc ff ff ff       	call   368f <_start+0x7>

		/* transfer the frambuffer mappings */
		void fb_video_setup();
		fb_no_malloc = 1;
    3693:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR ds:0x0,0x1
		fb_video_setup();
    369d:	e8 fc ff ff ff       	call   369e <_start+0x16>

		/* use the correct GDT */
		extern void gdt_init();
		gdt_init();
    36a2:	e8 fc ff ff ff       	call   36a3 <_start+0x1b>

		/* transfer mmgr data from known locations */
		extern void mmgr_reinit();
		mmgr_reinit();
    36a7:	e8 fc ff ff ff       	call   36a8 <_start+0x20>
		fb_no_malloc = 0;
    36ac:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0

		/* do the IDT setup & remap PIC */
		extern void idt_init();
		prepare_idt();
    36b6:	e8 fc ff ff ff       	call   36b7 <_start+0x2f>
		idt_init();
    36bb:	e8 fc ff ff ff       	call   36bc <_start+0x34>
		PIC_remap(0x20, 0x28);
    36c0:	c7 44 24 04 28 00 00 00 	mov    DWORD PTR [esp+0x4],0x28
    36c8:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
    36cf:	e8 fc ff ff ff       	call   36d0 <_start+0x48>
		while (!fb_no_malloc);
    36d4:	90                   	nop
    36d5:	a1 00 00 00 00       	mov    eax,ds:0x0
    36da:	85 c0                	test   eax,eax
    36dc:	74 f7                	je     36d5 <_start+0x4d>
		asm("sti");
    36de:	fb                   	sti

		/* protect null pointer */
		mm_unmap(&mm_kernel, NULL, 1);
    36df:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
    36e7:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    36ef:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    36f6:	e8 fc ff ff ff       	call   36f7 <_start+0x6f>

		/* print cpu info */
		cpu_info();
    36fb:	e8 fc ff ff ff       	call   36fc <_start+0x74>
		/* timekeeping setup */
		timer_setup();
    3700:	e8 fc ff ff ff       	call   3701 <_start+0x79>
		/* enable preemption (needed for MP init stacks) */
		/* enable preemption (calls kinit and never returns) */
		printf("starting preemption...\n");
    3705:	c7 04 24 9c 0c 00 00 	mov    DWORD PTR [esp],0xc9c
    370c:	e8 fc ff ff ff       	call   370d <_start+0x85>
		void preempt_init();
		preempt_init();
    3711:	e8 fc ff ff ff       	call   3712 <_start+0x8a>

		cprintf(KFMT_ERROR, "preempt_init returned\n");
    3716:	c7 44 24 04 b4 0c 00 00 	mov    DWORD PTR [esp+0x4],0xcb4
    371e:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    3725:	e8 fc ff ff ff       	call   3726 <_start+0x9e>
		while (1);
    372a:	90                   	nop
    372b:	eb fd                	jmp    372a <_start+0xa2>

0000372d <kinit>:
}

void kinit(void* data)
{
    372d:	55                   	push   ebp
    372e:	89 e5                	mov    ebp,esp
    3730:	83 ec 38             	sub    esp,0x38
		cprintf(KFMT_OK, "kernel is now preemptive\n");
    3733:	c7 44 24 04 cb 0c 00 00 	mov    DWORD PTR [esp+0x4],0xccb
    373b:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    3742:	e8 fc ff ff ff       	call   3743 <kinit+0x16>
		/* APIC and MP init */
		if (cpu.has_apic) {
    3747:	0f b6 05 59 00 00 00 	movzx  eax,BYTE PTR ds:0x59
    374e:	83 e0 02             	and    eax,0x2
    3751:	84 c0                	test   al,al
    3753:	74 05                	je     375a <kinit+0x2d>
				extern void apic_init(); /* PCP works afterwards */
				apic_init();
    3755:	e8 fc ff ff ff       	call   3756 <kinit+0x29>
		}
		extern void region_clear(struct kio_region* cr);
		region_clear(&km_regS);
    375a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    3761:	e8 fc ff ff ff       	call   3762 <kinit+0x35>
		km_regS.cur_x = km_regS.cur_y = 0;
    3766:	66 c7 05 10 00 00 00 00 00 	mov    WORD PTR ds:0x10,0x0
    376f:	0f b7 05 10 00 00 00 	movzx  eax,WORD PTR ds:0x10
    3776:	66 a3 0e 00 00 00    	mov    ds:0xe,ax
		region_puts(&km_regS, "total used  hp free\n\nup: ");
    377c:	c7 44 24 04 e5 0c 00 00 	mov    DWORD PTR [esp+0x4],0xce5
    3784:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    378b:	e8 fc ff ff ff       	call   378c <kinit+0x5f>
		/* Hardware detection and initialization */
		kbd_init();
    3790:	e8 fc ff ff ff       	call   3791 <kinit+0x64>
		{
				char bt;
				printf("VGA IO base port (from 0x0463): %x\n", *(uint16_t*)(0x463));
    3795:	b8 63 04 00 00       	mov    eax,0x463
    379a:	0f b7 00             	movzx  eax,WORD PTR [eax]
    379d:	0f b7 c0             	movzx  eax,ax
    37a0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    37a4:	c7 04 24 00 0d 00 00 	mov    DWORD PTR [esp],0xd00
    37ab:	e8 fc ff ff ff       	call   37ac <kinit+0x7f>
				bt = inb(0x3cc);
    37b0:	c7 04 24 cc 03 00 00 	mov    DWORD PTR [esp],0x3cc
    37b7:	e8 84 c8 ff ff       	call   40 <inb>
    37bc:	88 45 eb             	mov    BYTE PTR [ebp-0x15],al
				printf("VGA misc flags: %08b\n", bt);
    37bf:	0f be 45 eb          	movsx  eax,BYTE PTR [ebp-0x15]
    37c3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    37c7:	c7 04 24 24 0d 00 00 	mov    DWORD PTR [esp],0xd24
    37ce:	e8 fc ff ff ff       	call   37cf <kinit+0xa2>
/*				sleep(0);
				}*/
		}
		/* List the serial and printer ports */
		{
				uint16_t* ptr = (uint16_t*)0x400; int i;
    37d3:	c7 45 e4 00 04 00 00 	mov    DWORD PTR [ebp-0x1c],0x400
				for (i = 0; i < 7; i++)
    37da:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    37e1:	e9 b3 00 00 00       	jmp    3899 <kinit+0x16c>
						if (ptr[i])
    37e6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    37e9:	8d 14 00             	lea    edx,[eax+eax*1]
    37ec:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    37ef:	01 d0                	add    eax,edx
    37f1:	0f b7 00             	movzx  eax,WORD PTR [eax]
    37f4:	66 85 c0             	test   ax,ax
    37f7:	74 68                	je     3861 <kinit+0x134>
								if (i < 4) {
    37f9:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    37fd:	7f 3d                	jg     383c <kinit+0x10f>
										printf("COM%d IO port: %u\n", i + 1, *ptr);
    37ff:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3802:	0f b7 00             	movzx  eax,WORD PTR [eax]
    3805:	0f b7 c0             	movzx  eax,ax
    3808:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    380b:	83 c2 01             	add    edx,0x1
    380e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3812:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    3816:	c7 04 24 3a 0d 00 00 	mov    DWORD PTR [esp],0xd3a
    381d:	e8 fc ff ff ff       	call   381e <kinit+0xf1>
										enable_com(i, *ptr);
    3822:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3825:	0f b7 00             	movzx  eax,WORD PTR [eax]
    3828:	0f b7 c0             	movzx  eax,ax
    382b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    382f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3832:	89 04 24             	mov    DWORD PTR [esp],eax
    3835:	e8 fc ff ff ff       	call   3836 <kinit+0x109>
    383a:	eb 59                	jmp    3895 <kinit+0x168>
								} else
										printf("LPT%d IO port: %u\n", i - 3, *ptr);
    383c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    383f:	0f b7 00             	movzx  eax,WORD PTR [eax]
    3842:	0f b7 c0             	movzx  eax,ax
    3845:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    3848:	83 ea 03             	sub    edx,0x3
    384b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    384f:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    3853:	c7 04 24 4d 0d 00 00 	mov    DWORD PTR [esp],0xd4d
    385a:	e8 fc ff ff ff       	call   385b <kinit+0x12e>
    385f:	eb 34                	jmp    3895 <kinit+0x168>
						else
								if (i < 4)
    3861:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    3865:	7f 18                	jg     387f <kinit+0x152>
										printf("COM%d not present\n", i + 1);
    3867:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    386a:	83 c0 01             	add    eax,0x1
    386d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3871:	c7 04 24 60 0d 00 00 	mov    DWORD PTR [esp],0xd60
    3878:	e8 fc ff ff ff       	call   3879 <kinit+0x14c>
    387d:	eb 16                	jmp    3895 <kinit+0x168>
								else
										printf("LPT%d not present\n", i - 3);
    387f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3882:	83 e8 03             	sub    eax,0x3
    3885:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3889:	c7 04 24 73 0d 00 00 	mov    DWORD PTR [esp],0xd73
    3890:	e8 fc ff ff ff       	call   3891 <kinit+0x164>
				for (i = 0; i < 7; i++)
    3895:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    3899:	83 7d f4 06          	cmp    DWORD PTR [ebp-0xc],0x6
    389d:	0f 8e 43 ff ff ff    	jle    37e6 <kinit+0xb9>
		}
		/* Floppy devices */
		{
				uint8_t bt = cmos_get_register(0x10);
    38a3:	c7 04 24 10 00 00 00 	mov    DWORD PTR [esp],0x10
    38aa:	e8 fc ff ff ff       	call   38ab <kinit+0x17e>
    38af:	88 45 e3             	mov    BYTE PTR [ebp-0x1d],al
				uint8_t btM = (bt & 0xf0) >> 4;
    38b2:	0f b6 45 e3          	movzx  eax,BYTE PTR [ebp-0x1d]
    38b6:	c0 e8 04             	shr    al,0x4
    38b9:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
				bt &= 0x0f;
    38bc:	80 65 e3 0f          	and    BYTE PTR [ebp-0x1d],0xf
				do {
						const char* drv;
						switch (btM != 0xff ? btM : bt) {
    38c0:	80 7d f3 ff          	cmp    BYTE PTR [ebp-0xd],0xff
    38c4:	74 06                	je     38cc <kinit+0x19f>
    38c6:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
    38ca:	eb 04                	jmp    38d0 <kinit+0x1a3>
    38cc:	0f b6 45 e3          	movzx  eax,BYTE PTR [ebp-0x1d]
    38d0:	83 f8 05             	cmp    eax,0x5
    38d3:	77 3f                	ja     3914 <kinit+0x1e7>
    38d5:	8b 04 85 14 0e 00 00 	mov    eax,DWORD PTR [eax*4+0xe14]
    38dc:	ff e0                	jmp    eax
								case 0:
										drv = "no drive";
    38de:	c7 45 ec 86 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xd86
										break;
    38e5:	eb 35                	jmp    391c <kinit+0x1ef>
								case 1:
										drv = "360KiB 5.25\" drive";
    38e7:	c7 45 ec 8f 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xd8f
										break;
    38ee:	eb 2c                	jmp    391c <kinit+0x1ef>
								case 2:
										drv = "1.2MiB 5.25\" drive";
    38f0:	c7 45 ec a2 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xda2
										break;
    38f7:	eb 23                	jmp    391c <kinit+0x1ef>
								case 3:
										drv = "720KiB 3.5\" drive";
    38f9:	c7 45 ec b5 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xdb5
										break;
    3900:	eb 1a                	jmp    391c <kinit+0x1ef>
								case 4:
										drv = "1.44MiB 3.5\" drive";
    3902:	c7 45 ec c7 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xdc7
										break;
    3909:	eb 11                	jmp    391c <kinit+0x1ef>
								case 5:
										drv = "2.88MiB 3.5\" drive";
    390b:	c7 45 ec da 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xdda
										break;
    3912:	eb 08                	jmp    391c <kinit+0x1ef>
								default:
										drv = "unknown";
    3914:	c7 45 ec ed 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xded
										break;
    391b:	90                   	nop
						}
						printf("Floppy %s: %s\n", btM != 0xff ? "master" : "slave", drv);
    391c:	80 7d f3 ff          	cmp    BYTE PTR [ebp-0xd],0xff
    3920:	74 07                	je     3929 <kinit+0x1fc>
    3922:	ba f5 0d 00 00       	mov    edx,0xdf5
    3927:	eb 05                	jmp    392e <kinit+0x201>
    3929:	ba fc 0d 00 00       	mov    edx,0xdfc
    392e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    3931:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3935:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    3939:	c7 04 24 02 0e 00 00 	mov    DWORD PTR [esp],0xe02
    3940:	e8 fc ff ff ff       	call   3941 <kinit+0x214>
						if (btM == 0xff)
    3945:	80 7d f3 ff          	cmp    BYTE PTR [ebp-0xd],0xff
    3949:	74 09                	je     3954 <kinit+0x227>
								break;
						btM = 0xff;
    394b:	c6 45 f3 ff          	mov    BYTE PTR [ebp-0xd],0xff
				do {
    394f:	e9 6c ff ff ff       	jmp    38c0 <kinit+0x193>
								break;
    3954:	90                   	nop
		}

		/* PCI enumeration */
		void load_modules();
		void fun();
		fun();
    3955:	e8 fc ff ff ff       	call   3956 <kinit+0x229>
		load_modules();
    395a:	e8 fc ff ff ff       	call   395b <kinit+0x22e>

		/* now go to the loop */
		void kloop();
		kloop();
    395f:	e8 fc ff ff ff       	call   3960 <kinit+0x233>
}
    3964:	90                   	nop
    3965:	c9                   	leave
    3966:	c3                   	ret

00003967 <kscrub>:

/* performs scrubbing of pages at low priority */
void kscrub(void* data)
{
    3967:	55                   	push   ebp
    3968:	89 e5                	mov    ebp,esp
    396a:	83 ec 18             	sub    esp,0x18
		while (1) {/* need_resched is checked periodically inside */
				extern struct wait_queue_head wq_timer;
				if (!mm_page_scrub())
    396d:	e8 fc ff ff ff       	call   396e <kscrub+0x7>
    3972:	85 c0                	test   eax,eax
    3974:	75 f7                	jne    396d <kscrub+0x6>
						wait_timeout(&wq_timer, HZ);
    3976:	c7 44 24 04 79 00 00 00 	mov    DWORD PTR [esp+0x4],0x79
    397e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    3985:	e8 fc ff ff ff       	call   3986 <kscrub+0x1f>
		while (1) {/* need_resched is checked periodically inside */
    398a:	eb e1                	jmp    396d <kscrub+0x6>

0000398c <kloop>:
		}
}

void kloop()
{
    398c:	55                   	push   ebp
    398d:	89 e5                	mov    ebp,esp
    398f:	53                   	push   ebx
    3990:	81 ec 34 01 00 00    	sub    esp,0x134
		/* file_cli */
		int (*fptr)(const char*) = locate_module_function("file_cli");
    3996:	c7 04 24 2c 0e 00 00 	mov    DWORD PTR [esp],0xe2c
    399d:	e8 fc ff ff ff       	call   399e <kloop+0x12>
    39a2:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		void list_modules();
		void list_module_info(const char*);

		/* main loop */
		while (1) {
				char* str = 0; size_t n = 0;
    39a5:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x0
    39ac:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [ebp-0x40],0x0
				printf("enter text:\n");
    39b3:	c7 04 24 35 0e 00 00 	mov    DWORD PTR [esp],0xe35
    39ba:	e8 fc ff ff ff       	call   39bb <kloop+0x2f>
				getline(&str, &n);
    39bf:	8d 45 c0             	lea    eax,[ebp-0x40]
    39c2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    39c6:	8d 45 c4             	lea    eax,[ebp-0x3c]
    39c9:	89 04 24             	mov    DWORD PTR [esp],eax
    39cc:	e8 fc ff ff ff       	call   39cd <kloop+0x41>
				if (str) {
    39d1:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    39d4:	85 c0                	test   eax,eax
    39d6:	74 cd                	je     39a5 <kloop+0x19>
						char* s2 = str;
    39d8:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    39db:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						while (*s2++);
    39de:	90                   	nop
    39df:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    39e2:	8d 50 01             	lea    edx,[eax+0x1]
    39e5:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    39e8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    39eb:	84 c0                	test   al,al
    39ed:	75 f0                	jne    39df <kloop+0x53>
						if (s2 - 2 >= str)
    39ef:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    39f2:	8d 50 fe             	lea    edx,[eax-0x2]
    39f5:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    39f8:	39 c2                	cmp    edx,eax
    39fa:	72 09                	jb     3a05 <kloop+0x79>
								*(s2 - 2) = '\0';
    39fc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    39ff:	83 e8 02             	sub    eax,0x2
    3a02:	c6 00 00             	mov    BYTE PTR [eax],0x0
						if (strcmp(str, "pt") == 0) {
    3a05:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3a08:	c7 44 24 04 42 0e 00 00 	mov    DWORD PTR [esp+0x4],0xe42
    3a10:	89 04 24             	mov    DWORD PTR [esp],eax
    3a13:	e8 fc ff ff ff       	call   3a14 <kloop+0x88>
    3a18:	85 c0                	test   eax,eax
    3a1a:	75 0a                	jne    3a26 <kloop+0x9a>
								/* print tasks */
								void print_tasks();
								print_tasks();
    3a1c:	e8 fc ff ff ff       	call   3a1d <kloop+0x91>
    3a21:	e9 eb 07 00 00       	jmp    4211 <kloop+0x885>
						} else if (strncmp(str, "calc", 4) == 0) {
    3a26:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3a29:	c7 44 24 08 04 00 00 00 	mov    DWORD PTR [esp+0x8],0x4
    3a31:	c7 44 24 04 45 0e 00 00 	mov    DWORD PTR [esp+0x4],0xe45
    3a39:	89 04 24             	mov    DWORD PTR [esp],eax
    3a3c:	e8 fc ff ff ff       	call   3a3d <kloop+0xb1>
    3a41:	85 c0                	test   eax,eax
    3a43:	75 13                	jne    3a58 <kloop+0xcc>
								/* start/stop show the calculations */
								calc_fun(str + 5);
    3a45:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3a48:	83 c0 05             	add    eax,0x5
    3a4b:	89 04 24             	mov    DWORD PTR [esp],eax
    3a4e:	e8 fc ff ff ff       	call   3a4f <kloop+0xc3>
    3a53:	e9 b9 07 00 00       	jmp    4211 <kloop+0x885>
						} else if (strcmp(str, "rds") == 0) {
    3a58:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3a5b:	c7 44 24 04 4a 0e 00 00 	mov    DWORD PTR [esp+0x4],0xe4a
    3a63:	89 04 24             	mov    DWORD PTR [esp],eax
    3a66:	e8 fc ff ff ff       	call   3a67 <kloop+0xdb>
    3a6b:	85 c0                	test   eax,eax
    3a6d:	0f 85 25 01 00 00    	jne    3b98 <kloop+0x20c>
								//framebuffer_redraw(&fb_initial);
								printf("%d %d\n", video_mode.width, video_mode.height);
    3a73:	8b 15 08 00 00 00    	mov    edx,DWORD PTR ds:0x8
    3a79:	a1 04 00 00 00       	mov    eax,ds:0x4
    3a7e:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3a82:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3a86:	c7 04 24 4e 0e 00 00 	mov    DWORD PTR [esp],0xe4e
    3a8d:	e8 fc ff ff ff       	call   3a8e <kloop+0x102>
								printf("%d %d\n", fb_initial.cho_x, fb_initial.cho_y);
    3a92:	8b 15 28 00 00 00    	mov    edx,DWORD PTR ds:0x28
    3a98:	a1 24 00 00 00       	mov    eax,ds:0x24
    3a9d:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3aa1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3aa5:	c7 04 24 4e 0e 00 00 	mov    DWORD PTR [esp],0xe4e
    3aac:	e8 fc ff ff ff       	call   3aad <kloop+0x121>
								printf("%d %d\n", fb_initial.chw_x, fb_initial.chw_y);
    3ab1:	8b 15 30 00 00 00    	mov    edx,DWORD PTR ds:0x30
    3ab7:	a1 2c 00 00 00       	mov    eax,ds:0x2c
    3abc:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3ac0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3ac4:	c7 04 24 4e 0e 00 00 	mov    DWORD PTR [esp],0xe4e
    3acb:	e8 fc ff ff ff       	call   3acc <kloop+0x140>
								printf("%d %d\n", fb_initial.width, fb_initial.height);
    3ad0:	8b 15 08 00 00 00    	mov    edx,DWORD PTR ds:0x8
    3ad6:	a1 04 00 00 00       	mov    eax,ds:0x4
    3adb:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3adf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3ae3:	c7 04 24 4e 0e 00 00 	mov    DWORD PTR [esp],0xe4e
    3aea:	e8 fc ff ff ff       	call   3aeb <kloop+0x15f>
								printf("regions:\n");
    3aef:	c7 04 24 55 0e 00 00 	mov    DWORD PTR [esp],0xe55
    3af6:	e8 fc ff ff ff       	call   3af7 <kloop+0x16b>
								printf("km_regC: %d %d %d %d\n", km_regC.x, km_regC.y, km_regC.lx, km_regC.ly);
    3afb:	0f b7 05 06 00 00 00 	movzx  eax,WORD PTR ds:0x6
    3b02:	0f bf d8             	movsx  ebx,ax
    3b05:	0f b7 05 04 00 00 00 	movzx  eax,WORD PTR ds:0x4
    3b0c:	0f bf c8             	movsx  ecx,ax
    3b0f:	0f b7 05 02 00 00 00 	movzx  eax,WORD PTR ds:0x2
    3b16:	0f bf d0             	movsx  edx,ax
    3b19:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
    3b20:	98                   	cwde
    3b21:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    3b25:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    3b29:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3b2d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3b31:	c7 04 24 5f 0e 00 00 	mov    DWORD PTR [esp],0xe5f
    3b38:	e8 fc ff ff ff       	call   3b39 <kloop+0x1ad>
								printf("km_regS: %d %d %d %d\n", km_regS.x, km_regS.y, km_regS.lx, km_regS.ly);
    3b3d:	0f b7 05 06 00 00 00 	movzx  eax,WORD PTR ds:0x6
    3b44:	0f bf d8             	movsx  ebx,ax
    3b47:	0f b7 05 04 00 00 00 	movzx  eax,WORD PTR ds:0x4
    3b4e:	0f bf c8             	movsx  ecx,ax
    3b51:	0f b7 05 02 00 00 00 	movzx  eax,WORD PTR ds:0x2
    3b58:	0f bf d0             	movsx  edx,ax
    3b5b:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
    3b62:	98                   	cwde
    3b63:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    3b67:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    3b6b:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3b6f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3b73:	c7 04 24 75 0e 00 00 	mov    DWORD PTR [esp],0xe75
    3b7a:	e8 fc ff ff ff       	call   3b7b <kloop+0x1ef>
								framebuffer_update_region(&fb_initial, &km_regC);
    3b7f:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    3b87:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    3b8e:	e8 fc ff ff ff       	call   3b8f <kloop+0x203>
    3b93:	e9 79 06 00 00       	jmp    4211 <kloop+0x885>
						} else if (strcmp(str, "time") == 0) {
    3b98:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3b9b:	c7 44 24 04 8b 0e 00 00 	mov    DWORD PTR [esp+0x4],0xe8b
    3ba3:	89 04 24             	mov    DWORD PTR [esp],eax
    3ba6:	e8 fc ff ff ff       	call   3ba7 <kloop+0x21b>
    3bab:	85 c0                	test   eax,eax
    3bad:	0f 85 a6 01 00 00    	jne    3d59 <kloop+0x3cd>
								struct timespec tsp; struct tm* ts = &km_time;
    3bb3:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
								km_time = cmos_get_time();
    3bba:	8d 85 e8 fe ff ff    	lea    eax,[ebp-0x118]
    3bc0:	89 04 24             	mov    DWORD PTR [esp],eax
    3bc3:	e8 fc ff ff ff       	call   3bc4 <kloop+0x238>
    3bc8:	83 ec 04             	sub    esp,0x4
    3bcb:	8b 85 e8 fe ff ff    	mov    eax,DWORD PTR [ebp-0x118]
    3bd1:	a3 00 00 00 00       	mov    ds:0x0,eax
    3bd6:	8b 85 ec fe ff ff    	mov    eax,DWORD PTR [ebp-0x114]
    3bdc:	a3 04 00 00 00       	mov    ds:0x4,eax
    3be1:	8b 85 f0 fe ff ff    	mov    eax,DWORD PTR [ebp-0x110]
    3be7:	a3 08 00 00 00       	mov    ds:0x8,eax
    3bec:	8b 85 f4 fe ff ff    	mov    eax,DWORD PTR [ebp-0x10c]
    3bf2:	a3 0c 00 00 00       	mov    ds:0xc,eax
    3bf7:	8b 85 f8 fe ff ff    	mov    eax,DWORD PTR [ebp-0x108]
    3bfd:	a3 10 00 00 00       	mov    ds:0x10,eax
    3c02:	8b 85 fc fe ff ff    	mov    eax,DWORD PTR [ebp-0x104]
    3c08:	a3 14 00 00 00       	mov    ds:0x14,eax
    3c0d:	8b 85 00 ff ff ff    	mov    eax,DWORD PTR [ebp-0x100]
    3c13:	a3 18 00 00 00       	mov    ds:0x18,eax
    3c18:	8b 85 04 ff ff ff    	mov    eax,DWORD PTR [ebp-0xfc]
    3c1e:	a3 1c 00 00 00       	mov    ds:0x1c,eax
    3c23:	8b 85 08 ff ff ff    	mov    eax,DWORD PTR [ebp-0xf8]
    3c29:	a3 20 00 00 00       	mov    ds:0x20,eax
								km_set = jiffies;
    3c2e:	a1 00 00 00 00       	mov    eax,ds:0x0
    3c33:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3c36:	8b 00                	mov    eax,DWORD PTR [eax]
    3c38:	a3 00 00 00 00       	mov    ds:0x0,eax
    3c3d:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
								printf("upadting time from CMOS\n");
    3c43:	c7 04 24 90 0e 00 00 	mov    DWORD PTR [esp],0xe90
    3c4a:	e8 fc ff ff ff       	call   3c4b <kloop+0x2bf>
								clock_gettime(CLOCK_REALTIME, &tsp);
    3c4f:	8d 45 b4             	lea    eax,[ebp-0x4c]
    3c52:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3c56:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    3c5d:	e8 fc ff ff ff       	call   3c5e <kloop+0x2d2>
								printf("UNIX time: %llu.%lu\n", tsp.tv_sec, tsp.tv_nsec);
    3c62:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    3c65:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    3c68:	8b 55 b8             	mov    edx,DWORD PTR [ebp-0x48]
    3c6b:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    3c6f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3c73:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3c77:	c7 04 24 a9 0e 00 00 	mov    DWORD PTR [esp],0xea9
    3c7e:	e8 fc ff ff ff       	call   3c7f <kloop+0x2f3>
								printf("struct tm:\n");
    3c83:	c7 04 24 be 0e 00 00 	mov    DWORD PTR [esp],0xebe
    3c8a:	e8 fc ff ff ff       	call   3c8b <kloop+0x2ff>
								printf("tm_sec %d\n", ts->tm_sec);
    3c8f:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3c92:	8b 00                	mov    eax,DWORD PTR [eax]
    3c94:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3c98:	c7 04 24 ca 0e 00 00 	mov    DWORD PTR [esp],0xeca
    3c9f:	e8 fc ff ff ff       	call   3ca0 <kloop+0x314>
								printf("tm_min %d\n", ts->tm_min);
    3ca4:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3ca7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3caa:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3cae:	c7 04 24 d5 0e 00 00 	mov    DWORD PTR [esp],0xed5
    3cb5:	e8 fc ff ff ff       	call   3cb6 <kloop+0x32a>
								printf("tm_hour %d\n", ts->tm_hour);
    3cba:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3cbd:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3cc0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3cc4:	c7 04 24 e0 0e 00 00 	mov    DWORD PTR [esp],0xee0
    3ccb:	e8 fc ff ff ff       	call   3ccc <kloop+0x340>
								printf("tm_mday %d\n", ts->tm_mday);
    3cd0:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3cd3:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    3cd6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3cda:	c7 04 24 ec 0e 00 00 	mov    DWORD PTR [esp],0xeec
    3ce1:	e8 fc ff ff ff       	call   3ce2 <kloop+0x356>
								printf("tm_mon %d\n", ts->tm_mon);
    3ce6:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3ce9:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3cec:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3cf0:	c7 04 24 f8 0e 00 00 	mov    DWORD PTR [esp],0xef8
    3cf7:	e8 fc ff ff ff       	call   3cf8 <kloop+0x36c>
								printf("tm_year %d\n", ts->tm_year);
    3cfc:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3cff:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    3d02:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3d06:	c7 04 24 03 0f 00 00 	mov    DWORD PTR [esp],0xf03
    3d0d:	e8 fc ff ff ff       	call   3d0e <kloop+0x382>
								printf("tm_wday %d\n", ts->tm_wday);
    3d12:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3d15:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3d18:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3d1c:	c7 04 24 0f 0f 00 00 	mov    DWORD PTR [esp],0xf0f
    3d23:	e8 fc ff ff ff       	call   3d24 <kloop+0x398>
								printf("tm_yday %d\n", ts->tm_yday);
    3d28:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3d2b:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    3d2e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3d32:	c7 04 24 1b 0f 00 00 	mov    DWORD PTR [esp],0xf1b
    3d39:	e8 fc ff ff ff       	call   3d3a <kloop+0x3ae>
								printf("tm_isdst %d\n", ts->tm_isdst);
    3d3e:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3d41:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    3d44:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3d48:	c7 04 24 27 0f 00 00 	mov    DWORD PTR [esp],0xf27
    3d4f:	e8 fc ff ff ff       	call   3d50 <kloop+0x3c4>
    3d54:	e9 b8 04 00 00       	jmp    4211 <kloop+0x885>
						} else if(strcmp(str, "trhp") == 0) {
    3d59:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3d5c:	c7 44 24 04 34 0f 00 00 	mov    DWORD PTR [esp+0x4],0xf34
    3d64:	89 04 24             	mov    DWORD PTR [esp],eax
    3d67:	e8 fc ff ff ff       	call   3d68 <kloop+0x3dc>
    3d6c:	85 c0                	test   eax,eax
    3d6e:	75 78                	jne    3de8 <kloop+0x45c>
								unsigned int bval = 0xff;
    3d70:	c7 45 f0 ff 00 00 00 	mov    DWORD PTR [ebp-0x10],0xff
								printf("trashing kernel heap\n");
    3d77:	c7 04 24 39 0f 00 00 	mov    DWORD PTR [esp],0xf39
    3d7e:	e8 fc ff ff ff       	call   3d7f <kloop+0x3f3>
								/* glibc rand */
								while (1) {
										printf("allocating %u bytes ...\n", (bval & 0xffff));
    3d83:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3d86:	0f b7 c0             	movzx  eax,ax
    3d89:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3d8d:	c7 04 24 4f 0f 00 00 	mov    DWORD PTR [esp],0xf4f
    3d94:	e8 fc ff ff ff       	call   3d95 <kloop+0x409>
										printf("located at %p\n", kmalloc(bval & 0xffff));
    3d99:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3d9c:	0f b7 c0             	movzx  eax,ax
    3d9f:	89 04 24             	mov    DWORD PTR [esp],eax
    3da2:	e8 fc ff ff ff       	call   3da3 <kloop+0x417>
    3da7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3dab:	c7 04 24 68 0f 00 00 	mov    DWORD PTR [esp],0xf68
    3db2:	e8 fc ff ff ff       	call   3db3 <kloop+0x427>
										bval = (uint32_t)((1103515245*(uint64_t)bval+12345) % 0x80000000);
    3db7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3dba:	ba 00 00 00 00       	mov    edx,0x0
    3dbf:	69 da 6d 4e c6 41    	imul   ebx,edx,0x41c64e6d
    3dc5:	6b c8 00             	imul   ecx,eax,0x0
    3dc8:	01 d9                	add    ecx,ebx
    3dca:	bb 6d 4e c6 41       	mov    ebx,0x41c64e6d
    3dcf:	f7 e3                	mul    ebx
    3dd1:	01 d1                	add    ecx,edx
    3dd3:	89 ca                	mov    edx,ecx
    3dd5:	05 39 30 00 00       	add    eax,0x3039
    3dda:	83 d2 00             	adc    edx,0x0
    3ddd:	25 ff ff ff 7f       	and    eax,0x7fffffff
    3de2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
										printf("allocating %u bytes ...\n", (bval & 0xffff));
    3de5:	90                   	nop
    3de6:	eb 9b                	jmp    3d83 <kloop+0x3f7>
								}
						} else if (fptr && fptr(str)) {
    3de8:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    3dec:	74 13                	je     3e01 <kloop+0x475>
    3dee:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3df1:	89 04 24             	mov    DWORD PTR [esp],eax
    3df4:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3df7:	ff d0                	call   eax
    3df9:	85 c0                	test   eax,eax
    3dfb:	0f 85 10 04 00 00    	jne    4211 <kloop+0x885>
								/* do nothing -> fptr() does it */
						} else if (strcmp(str, "lsmod") == 0)
    3e01:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e04:	c7 44 24 04 77 0f 00 00 	mov    DWORD PTR [esp+0x4],0xf77
    3e0c:	89 04 24             	mov    DWORD PTR [esp],eax
    3e0f:	e8 fc ff ff ff       	call   3e10 <kloop+0x484>
    3e14:	85 c0                	test   eax,eax
    3e16:	75 0a                	jne    3e22 <kloop+0x496>
								list_modules();
    3e18:	e8 fc ff ff ff       	call   3e19 <kloop+0x48d>
    3e1d:	e9 ef 03 00 00       	jmp    4211 <kloop+0x885>
						else if (strncmp(str, "modinfo ", 7) == 0) {
    3e22:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e25:	c7 44 24 08 07 00 00 00 	mov    DWORD PTR [esp+0x8],0x7
    3e2d:	c7 44 24 04 7d 0f 00 00 	mov    DWORD PTR [esp+0x4],0xf7d
    3e35:	89 04 24             	mov    DWORD PTR [esp],eax
    3e38:	e8 fc ff ff ff       	call   3e39 <kloop+0x4ad>
    3e3d:	85 c0                	test   eax,eax
    3e3f:	75 19                	jne    3e5a <kloop+0x4ce>
								str += 8;
    3e41:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e44:	83 c0 08             	add    eax,0x8
    3e47:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
								list_module_info(str);
    3e4a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e4d:	89 04 24             	mov    DWORD PTR [esp],eax
    3e50:	e8 fc ff ff ff       	call   3e51 <kloop+0x4c5>
    3e55:	e9 b7 03 00 00       	jmp    4211 <kloop+0x885>
						} else if (strcmp(str, "com") == 0) {
    3e5a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e5d:	c7 44 24 04 86 0f 00 00 	mov    DWORD PTR [esp+0x4],0xf86
    3e65:	89 04 24             	mov    DWORD PTR [esp],eax
    3e68:	e8 fc ff ff ff       	call   3e69 <kloop+0x4dd>
    3e6d:	85 c0                	test   eax,eax
    3e6f:	75 0a                	jne    3e7b <kloop+0x4ef>
								com_status();
    3e71:	e8 fc ff ff ff       	call   3e72 <kloop+0x4e6>
    3e76:	e9 96 03 00 00       	jmp    4211 <kloop+0x885>
						} else if (strcmp(str, "brk") == 0) {
    3e7b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e7e:	c7 44 24 04 8a 0f 00 00 	mov    DWORD PTR [esp+0x4],0xf8a
    3e86:	89 04 24             	mov    DWORD PTR [esp],eax
    3e89:	e8 fc ff ff ff       	call   3e8a <kloop+0x4fe>
    3e8e:	85 c0                	test   eax,eax
    3e90:	0f 84 7b 03 00 00    	je     4211 <kloop+0x885>
								//breakpoint(); TODO reimpl.
						} else if (strncmp(str, "pma", 3) == 0) {
    3e96:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e99:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    3ea1:	c7 44 24 04 8e 0f 00 00 	mov    DWORD PTR [esp+0x4],0xf8e
    3ea9:	89 04 24             	mov    DWORD PTR [esp],eax
    3eac:	e8 fc ff ff ff       	call   3ead <kloop+0x521>
    3eb1:	85 c0                	test   eax,eax
    3eb3:	0f 85 0e 01 00 00    	jne    3fc7 <kloop+0x63b>
								int val;
								/* allocate pmem */
								val = atoi(str + 3);
    3eb9:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3ebc:	83 c0 03             	add    eax,0x3
    3ebf:	89 04 24             	mov    DWORD PTR [esp],eax
    3ec2:	e8 fc ff ff ff       	call   3ec3 <kloop+0x537>
    3ec7:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
								if (val) {
    3eca:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
    3ece:	0f 84 3d 03 00 00    	je     4211 <kloop+0x885>
										struct page_range pr[10]; size_t rv;
										printf("allocating %d physical pages...\n", val);
    3ed4:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    3ed7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3edb:	c7 04 24 94 0f 00 00 	mov    DWORD PTR [esp],0xf94
    3ee2:	e8 fc ff ff ff       	call   3ee3 <kloop+0x557>
										rv = mm_alloc_pm(val, pr, 10);
    3ee7:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    3eea:	c7 44 24 08 0a 00 00 00 	mov    DWORD PTR [esp+0x8],0xa
    3ef2:	8d 95 24 ff ff ff    	lea    edx,[ebp-0xdc]
    3ef8:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    3efc:	89 04 24             	mov    DWORD PTR [esp],eax
    3eff:	e8 fc ff ff ff       	call   3f00 <kloop+0x574>
    3f04:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
										printf("%zu pages allocated\n", rv);
    3f07:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    3f0a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3f0e:	c7 04 24 b5 0f 00 00 	mov    DWORD PTR [esp],0xfb5
    3f15:	e8 fc ff ff ff       	call   3f16 <kloop+0x58a>
										for (rv = 0; rv < 10; rv++)
    3f1a:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    3f21:	e9 92 00 00 00       	jmp    3fb8 <kloop+0x62c>
												if (!pr[rv].count)
    3f26:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    3f29:	89 d0                	mov    eax,edx
    3f2b:	01 c0                	add    eax,eax
    3f2d:	01 d0                	add    eax,edx
    3f2f:	c1 e0 02             	shl    eax,0x2
    3f32:	8d 40 f8             	lea    eax,[eax-0x8]
    3f35:	01 e8                	add    eax,ebp
    3f37:	2d cc 00 00 00       	sub    eax,0xcc
    3f3c:	8b 00                	mov    eax,DWORD PTR [eax]
    3f3e:	85 c0                	test   eax,eax
    3f40:	0f 84 ca 02 00 00    	je     4210 <kloop+0x884>
														break;
												else
														printf("%zu pages at %#08x%08x\n",
																	   pr[rv].count,
																	   (uint32_t)(pr[rv].base >> 32),
																	   (uint32_t)pr[rv].base);
    3f46:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    3f49:	89 d0                	mov    eax,edx
    3f4b:	01 c0                	add    eax,eax
    3f4d:	01 d0                	add    eax,edx
    3f4f:	c1 e0 02             	shl    eax,0x2
    3f52:	8d 40 f8             	lea    eax,[eax-0x8]
    3f55:	01 e8                	add    eax,ebp
    3f57:	2d d4 00 00 00       	sub    eax,0xd4
    3f5c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3f5f:	8b 00                	mov    eax,DWORD PTR [eax]
														printf("%zu pages at %#08x%08x\n",
    3f61:	89 c3                	mov    ebx,eax
																	   (uint32_t)(pr[rv].base >> 32),
    3f63:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    3f66:	89 d0                	mov    eax,edx
    3f68:	01 c0                	add    eax,eax
    3f6a:	01 d0                	add    eax,edx
    3f6c:	c1 e0 02             	shl    eax,0x2
    3f6f:	8d 40 f8             	lea    eax,[eax-0x8]
    3f72:	01 e8                	add    eax,ebp
    3f74:	2d d4 00 00 00       	sub    eax,0xd4
    3f79:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3f7c:	8b 00                	mov    eax,DWORD PTR [eax]
    3f7e:	89 d0                	mov    eax,edx
    3f80:	31 d2                	xor    edx,edx
														printf("%zu pages at %#08x%08x\n",
    3f82:	89 c1                	mov    ecx,eax
    3f84:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    3f87:	89 d0                	mov    eax,edx
    3f89:	01 c0                	add    eax,eax
    3f8b:	01 d0                	add    eax,edx
    3f8d:	c1 e0 02             	shl    eax,0x2
    3f90:	8d 40 f8             	lea    eax,[eax-0x8]
    3f93:	01 e8                	add    eax,ebp
    3f95:	2d cc 00 00 00       	sub    eax,0xcc
    3f9a:	8b 00                	mov    eax,DWORD PTR [eax]
    3f9c:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    3fa0:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    3fa4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3fa8:	c7 04 24 ca 0f 00 00 	mov    DWORD PTR [esp],0xfca
    3faf:	e8 fc ff ff ff       	call   3fb0 <kloop+0x624>
										for (rv = 0; rv < 10; rv++)
    3fb4:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    3fb8:	83 7d ec 09          	cmp    DWORD PTR [ebp-0x14],0x9
    3fbc:	0f 86 64 ff ff ff    	jbe    3f26 <kloop+0x59a>
    3fc2:	e9 4a 02 00 00       	jmp    4211 <kloop+0x885>
								}
						} else if (strncmp(str, "pmf", 3) == 0) {
    3fc7:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3fca:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    3fd2:	c7 44 24 04 e2 0f 00 00 	mov    DWORD PTR [esp+0x4],0xfe2
    3fda:	89 04 24             	mov    DWORD PTR [esp],eax
    3fdd:	e8 fc ff ff ff       	call   3fde <kloop+0x652>
    3fe2:	85 c0                	test   eax,eax
    3fe4:	0f 85 8b 00 00 00    	jne    4075 <kloop+0x6e9>
								long int val; char* ep;
								val = strtol(str + 3, &ep, 0);
    3fea:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3fed:	8d 50 03             	lea    edx,[eax+0x3]
    3ff0:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    3ff8:	8d 45 b0             	lea    eax,[ebp-0x50]
    3ffb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3fff:	89 14 24             	mov    DWORD PTR [esp],edx
    4002:	e8 fc ff ff ff       	call   4003 <kloop+0x677>
    4007:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								if (val) {
    400a:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    400e:	0f 84 fd 01 00 00    	je     4211 <kloop+0x885>
										int ct = atoi(ep);
    4014:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    4017:	89 04 24             	mov    DWORD PTR [esp],eax
    401a:	e8 fc ff ff ff       	call   401b <kloop+0x68f>
    401f:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
										if (ct) {
    4022:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    4026:	0f 84 e5 01 00 00    	je     4211 <kloop+0x885>
												struct page_range pr;
												pr.base = val;
    402c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    402f:	99                   	cdq
    4030:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
    4033:	89 55 a8             	mov    DWORD PTR [ebp-0x58],edx
												pr.count = ct;
    4036:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    4039:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
												printf("freeing %zu physical pages at 0x%016llx\n",
    403c:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    403f:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    4042:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    4045:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    4049:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    404d:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    4051:	c7 04 24 e8 0f 00 00 	mov    DWORD PTR [esp],0xfe8
    4058:	e8 fc ff ff ff       	call   4059 <kloop+0x6cd>
																pr.count, pr.base);
												mm_free_pm(&pr, 1);
    405d:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
    4065:	8d 45 a4             	lea    eax,[ebp-0x5c]
    4068:	89 04 24             	mov    DWORD PTR [esp],eax
    406b:	e8 fc ff ff ff       	call   406c <kloop+0x6e0>
    4070:	e9 9c 01 00 00       	jmp    4211 <kloop+0x885>
										}
								}
						} else if (strncmp(str, "pmu", 3) == 0) {
    4075:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4078:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    4080:	c7 44 24 04 11 10 00 00 	mov    DWORD PTR [esp+0x4],0x1011
    4088:	89 04 24             	mov    DWORD PTR [esp],eax
    408b:	e8 fc ff ff ff       	call   408c <kloop+0x700>
    4090:	85 c0                	test   eax,eax
    4092:	75 7e                	jne    4112 <kloop+0x786>
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
    4094:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4097:	8d 50 03             	lea    edx,[eax+0x3]
    409a:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    40a2:	8d 45 a0             	lea    eax,[ebp-0x60]
    40a5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    40a9:	89 14 24             	mov    DWORD PTR [esp],edx
    40ac:	e8 fc ff ff ff       	call   40ad <kloop+0x721>
    40b1:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
								if (val) {
    40b4:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    40b8:	74 37                	je     40f1 <kloop+0x765>
										int ct = atoi(ep);
    40ba:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    40bd:	89 04 24             	mov    DWORD PTR [esp],eax
    40c0:	e8 fc ff ff ff       	call   40c1 <kloop+0x735>
    40c5:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
										if (ct)
    40c8:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    40cc:	0f 84 3f 01 00 00    	je     4211 <kloop+0x885>
												mm_dump_pmu(val, ct, 0);
    40d2:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    40d5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    40d8:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    40e0:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    40e4:	89 04 24             	mov    DWORD PTR [esp],eax
    40e7:	e8 fc ff ff ff       	call   40e8 <kloop+0x75c>
    40ec:	e9 20 01 00 00       	jmp    4211 <kloop+0x885>
								} else
										mm_dump_pmu(0, 0, 2);
    40f1:	c7 44 24 08 02 00 00 00 	mov    DWORD PTR [esp+0x8],0x2
    40f9:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    4101:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    4108:	e8 fc ff ff ff       	call   4109 <kloop+0x77d>
    410d:	e9 ff 00 00 00       	jmp    4211 <kloop+0x885>
						} else if (strncmp(str, "rcp", 3) == 0) {
    4112:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4115:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    411d:	c7 44 24 04 15 10 00 00 	mov    DWORD PTR [esp+0x4],0x1015
    4125:	89 04 24             	mov    DWORD PTR [esp],eax
    4128:	e8 fc ff ff ff       	call   4129 <kloop+0x79d>
    412d:	85 c0                	test   eax,eax
    412f:	75 7b                	jne    41ac <kloop+0x820>
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
    4131:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4134:	8d 50 03             	lea    edx,[eax+0x3]
    4137:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    413f:	8d 45 9c             	lea    eax,[ebp-0x64]
    4142:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    4146:	89 14 24             	mov    DWORD PTR [esp],edx
    4149:	e8 fc ff ff ff       	call   414a <kloop+0x7be>
    414e:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								if (val) {
    4151:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    4155:	74 37                	je     418e <kloop+0x802>
										int ct = atoi(ep);
    4157:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    415a:	89 04 24             	mov    DWORD PTR [esp],eax
    415d:	e8 fc ff ff ff       	call   415e <kloop+0x7d2>
    4162:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
										if (ct)
    4165:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    4169:	0f 84 a2 00 00 00    	je     4211 <kloop+0x885>
												mm_dump_pmu(val, ct, 1);
    416f:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    4172:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4175:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
    417d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    4181:	89 04 24             	mov    DWORD PTR [esp],eax
    4184:	e8 fc ff ff ff       	call   4185 <kloop+0x7f9>
    4189:	e9 83 00 00 00       	jmp    4211 <kloop+0x885>
								} else
										mm_dump_pmu(0, 0, 2);
    418e:	c7 44 24 08 02 00 00 00 	mov    DWORD PTR [esp+0x8],0x2
    4196:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    419e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    41a5:	e8 fc ff ff ff       	call   41a6 <kloop+0x81a>
    41aa:	eb 65                	jmp    4211 <kloop+0x885>
						} else if (strcmp(str, "reboot") == 0)
    41ac:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    41af:	c7 44 24 04 19 10 00 00 	mov    DWORD PTR [esp+0x4],0x1019
    41b7:	89 04 24             	mov    DWORD PTR [esp],eax
    41ba:	e8 fc ff ff ff       	call   41bb <kloop+0x82f>
    41bf:	85 c0                	test   eax,eax
    41c1:	75 05                	jne    41c8 <kloop+0x83c>
								pc_reset();
    41c3:	e8 fc ff ff ff       	call   41c4 <kloop+0x838>
						else if (strcmp(str, "quit") == 0 || strcmp(str, "halt") == 0)
    41c8:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    41cb:	c7 44 24 04 20 10 00 00 	mov    DWORD PTR [esp+0x4],0x1020
    41d3:	89 04 24             	mov    DWORD PTR [esp],eax
    41d6:	e8 fc ff ff ff       	call   41d7 <kloop+0x84b>
    41db:	85 c0                	test   eax,eax
    41dd:	74 17                	je     41f6 <kloop+0x86a>
    41df:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    41e2:	c7 44 24 04 25 10 00 00 	mov    DWORD PTR [esp+0x4],0x1025
    41ea:	89 04 24             	mov    DWORD PTR [esp],eax
    41ed:	e8 fc ff ff ff       	call   41ee <kloop+0x862>
    41f2:	85 c0                	test   eax,eax
    41f4:	75 05                	jne    41fb <kloop+0x86f>
								pc_shutdown();
    41f6:	e8 fc ff ff ff       	call   41f7 <kloop+0x86b>
						else
								printf("Command \"%s\" read from keyboard is unrecognized\n", str);
    41fb:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    41fe:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    4202:	c7 04 24 2c 10 00 00 	mov    DWORD PTR [esp],0x102c
    4209:	e8 fc ff ff ff       	call   420a <kloop+0x87e>
    420e:	eb 01                	jmp    4211 <kloop+0x885>
														break;
    4210:	90                   	nop
						kfree(str);
    4211:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4214:	89 04 24             	mov    DWORD PTR [esp],eax
    4217:	e8 fc ff ff ff       	call   4218 <kloop+0x88c>
		while (1) {
    421c:	e9 84 f7 ff ff       	jmp    39a5 <kloop+0x19>

00004221 <ringbuffer_allocate>:
		char data[];
};

/* ringbuffer functions*/
void* ringbuffer_allocate(size_t init_cap)
{
    4221:	55                   	push   ebp
    4222:	89 e5                	mov    ebp,esp
    4224:	83 ec 28             	sub    esp,0x28
		void** rvR, *rv;
		rvR = (void**)kmalloc(sizeof(void*));
    4227:	c7 04 24 04 00 00 00 	mov    DWORD PTR [esp],0x4
    422e:	e8 fc ff ff ff       	call   422f <ringbuffer_allocate+0xe>
    4233:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rvR)
    4236:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    423a:	75 07                	jne    4243 <ringbuffer_allocate+0x22>
				return 0;
    423c:	b8 00 00 00 00       	mov    eax,0x0
    4241:	eb 64                	jmp    42a7 <ringbuffer_allocate+0x86>
		if ((rv = kmalloc(init_cap + sizeof(struct ringbuffer)))) {
    4243:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4246:	83 c0 10             	add    eax,0x10
    4249:	89 04 24             	mov    DWORD PTR [esp],eax
    424c:	e8 fc ff ff ff       	call   424d <ringbuffer_allocate+0x2c>
    4251:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    4254:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    4258:	74 3d                	je     4297 <ringbuffer_allocate+0x76>
				struct ringbuffer* rbf = (struct ringbuffer*)rv;
    425a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    425d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				rbf->cap = init_cap;
    4260:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4263:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    4266:	89 10                	mov    DWORD PTR [eax],edx
				rbf->ofs_start = 0;
    4268:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    426b:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
				rbf->ofs_end = 0;
    4272:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4275:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
				spin_lock_init(&rbf->lock);
    427c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    427f:	83 c0 0c             	add    eax,0xc
    4282:	89 04 24             	mov    DWORD PTR [esp],eax
    4285:	e8 fc ff ff ff       	call   4286 <ringbuffer_allocate+0x65>
				*rvR = rv;
    428a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    428d:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    4290:	89 10                	mov    DWORD PTR [eax],edx
				return (void*)rvR;
    4292:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4295:	eb 10                	jmp    42a7 <ringbuffer_allocate+0x86>
		} else
				kfree(rvR);
    4297:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    429a:	89 04 24             	mov    DWORD PTR [esp],eax
    429d:	e8 fc ff ff ff       	call   429e <ringbuffer_allocate+0x7d>
		return 0;
    42a2:	b8 00 00 00 00       	mov    eax,0x0
}
    42a7:	c9                   	leave
    42a8:	c3                   	ret

000042a9 <ringbuffer_enqueue>:

void ringbuffer_enqueue(void* rbi, const void* dat, size_t s)
{
    42a9:	55                   	push   ebp
    42aa:	89 e5                	mov    ebp,esp
    42ac:	53                   	push   ebx
    42ad:	83 ec 34             	sub    esp,0x34
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    42b0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    42b3:	8b 00                	mov    eax,DWORD PTR [eax]
    42b5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
	//	spin_lock(&rb->lock);
		const char* data = (const char*)dat;
    42b8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    42bb:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		size_t cap = rb->cap;
    42be:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    42c1:	8b 00                	mov    eax,DWORD PTR [eax]
    42c3:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (rb->ofs_end > rb->ofs_start)
    42c6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    42c9:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    42cc:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    42cf:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    42d2:	39 c2                	cmp    edx,eax
    42d4:	73 13                	jae    42e9 <ringbuffer_enqueue+0x40>
				cap -= rb->ofs_end - rb->ofs_start;
    42d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    42d9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    42dc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    42df:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    42e2:	29 c2                	sub    edx,eax
    42e4:	01 55 ec             	add    DWORD PTR [ebp-0x14],edx
    42e7:	eb 20                	jmp    4309 <ringbuffer_enqueue+0x60>
		else
				cap -= rb->cap - rb->ofs_start + rb->ofs_end + 1;
    42e9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    42ec:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    42ef:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    42f2:	8b 00                	mov    eax,DWORD PTR [eax]
    42f4:	29 c2                	sub    edx,eax
    42f6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    42f9:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    42fc:	29 c2                	sub    edx,eax
    42fe:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4301:	01 d0                	add    eax,edx
    4303:	83 e8 01             	sub    eax,0x1
    4306:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (cap < s) {
    4309:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    430c:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
    430f:	0f 83 df 00 00 00    	jae    43f4 <ringbuffer_enqueue+0x14b>
				void* nrb;
				/* allocate new buffer and shuffle data */
				size_t nc = rb->cap + max(rb->cap, 4 * s + 1);
    4315:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4318:	8b 08                	mov    ecx,DWORD PTR [eax]
    431a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    431d:	c1 e0 02             	shl    eax,0x2
    4320:	8d 50 01             	lea    edx,[eax+0x1]
    4323:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4326:	8b 00                	mov    eax,DWORD PTR [eax]
    4328:	39 c2                	cmp    edx,eax
    432a:	0f 43 c2             	cmovae eax,edx
    432d:	01 c8                	add    eax,ecx
    432f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if ((nrb = krealloc(rb, nc + sizeof(struct ringbuffer)))) {
    4332:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    4335:	83 c0 10             	add    eax,0x10
    4338:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    433c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    433f:	89 04 24             	mov    DWORD PTR [esp],eax
    4342:	e8 fc ff ff ff       	call   4343 <ringbuffer_enqueue+0x9a>
    4347:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    434a:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    434e:	0f 84 af 00 00 00    	je     4403 <ringbuffer_enqueue+0x15a>
						/* enough memory */
						rb = (struct ringbuffer*)nrb;
    4354:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    4357:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						*(void**)rbi = nrb;
    435a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    435d:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    4360:	89 10                	mov    DWORD PTR [eax],edx
						/* move old data (if wrapped) */
						if (rb->ofs_end < rb->ofs_start) {
    4362:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4365:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    4368:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    436b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    436e:	39 c2                	cmp    edx,eax
    4370:	73 3d                	jae    43af <ringbuffer_enqueue+0x106>
								memcpy(rb->data + rb->cap, rb->data, rb->ofs_end);
    4372:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4375:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4378:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    437b:	8d 4a 0e             	lea    ecx,[edx+0xe]
    437e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4381:	8d 5a 0e             	lea    ebx,[edx+0xe]
    4384:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4387:	8b 12                	mov    edx,DWORD PTR [edx]
    4389:	01 da                	add    edx,ebx
    438b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    438f:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    4393:	89 14 24             	mov    DWORD PTR [esp],edx
    4396:	e8 c2 bc ff ff       	call   5d <memcpy>
								rb->ofs_end += rb->ofs_start;
    439b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    439e:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    43a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    43a4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    43a7:	01 c2                	add    edx,eax
    43a9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    43ac:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
						}
						rb->cap = nc;
    43af:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    43b2:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    43b5:	89 10                	mov    DWORD PTR [eax],edx
				} else {
	//					spin_unlock(&rb->lock);
						return; /* OOM */
				}
		}
		while (s--) {
    43b7:	eb 3b                	jmp    43f4 <ringbuffer_enqueue+0x14b>
				if (rb->ofs_end == rb->cap)
    43b9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    43bc:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    43bf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    43c2:	8b 00                	mov    eax,DWORD PTR [eax]
    43c4:	39 c2                	cmp    edx,eax
    43c6:	75 0a                	jne    43d2 <ringbuffer_enqueue+0x129>
						rb->ofs_end = 0;
    43c8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    43cb:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
				rb->data[rb->ofs_end++] = *(data++);
    43d2:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    43d5:	8d 42 01             	lea    eax,[edx+0x1]
    43d8:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    43db:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    43de:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    43e1:	8d 58 01             	lea    ebx,[eax+0x1]
    43e4:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    43e7:	89 59 08             	mov    DWORD PTR [ecx+0x8],ebx
    43ea:	0f b6 0a             	movzx  ecx,BYTE PTR [edx]
    43ed:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    43f0:	88 4c 02 0e          	mov    BYTE PTR [edx+eax*1+0xe],cl
		while (s--) {
    43f4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    43f7:	8d 50 ff             	lea    edx,[eax-0x1]
    43fa:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    43fd:	85 c0                	test   eax,eax
    43ff:	75 b8                	jne    43b9 <ringbuffer_enqueue+0x110>
    4401:	eb 01                	jmp    4404 <ringbuffer_enqueue+0x15b>
						return; /* OOM */
    4403:	90                   	nop
		}
//		spin_unlock(&rb->lock);
}
    4404:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    4407:	c9                   	leave
    4408:	c3                   	ret

00004409 <ringbuffer_dequeue>:

void ringbuffer_dequeue(void* rbi, void* dat, size_t s)
{
    4409:	55                   	push   ebp
    440a:	89 e5                	mov    ebp,esp
    440c:	83 ec 10             	sub    esp,0x10
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    440f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4412:	8b 00                	mov    eax,DWORD PTR [eax]
    4414:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
//		spin_lock(&rb->lock);
		char* data = (char*)dat;
    4417:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    441a:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		while (s--) {
    441d:	eb 64                	jmp    4483 <ringbuffer_dequeue+0x7a>
				if (rb->ofs_end == rb->ofs_start) {
    441f:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4422:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    4425:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4428:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    442b:	39 c2                	cmp    edx,eax
    442d:	74 63                	je     4492 <ringbuffer_dequeue+0x89>
//						spin_unlock(&rb->lock);
						return;
				}
				*(data++) = rb->data[rb->ofs_start++];
    442f:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4432:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4435:	8d 4a 01             	lea    ecx,[edx+0x1]
    4438:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    443b:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
    443e:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    4441:	8d 48 01             	lea    ecx,[eax+0x1]
    4444:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
    4447:	8b 4d f8             	mov    ecx,DWORD PTR [ebp-0x8]
    444a:	0f b6 54 11 0e       	movzx  edx,BYTE PTR [ecx+edx*1+0xe]
    444f:	88 10                	mov    BYTE PTR [eax],dl
				if (rb->ofs_start == rb->cap) {
    4451:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4454:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4457:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    445a:	8b 00                	mov    eax,DWORD PTR [eax]
    445c:	39 c2                	cmp    edx,eax
    445e:	75 23                	jne    4483 <ringbuffer_dequeue+0x7a>
						rb->ofs_start = 0;
    4460:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4463:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
						if (rb->ofs_end == rb->cap)
    446a:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    446d:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    4470:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4473:	8b 00                	mov    eax,DWORD PTR [eax]
    4475:	39 c2                	cmp    edx,eax
    4477:	75 0a                	jne    4483 <ringbuffer_dequeue+0x7a>
								rb->ofs_end = 0;
    4479:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    447c:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
		while (s--) {
    4483:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    4486:	8d 50 ff             	lea    edx,[eax-0x1]
    4489:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    448c:	85 c0                	test   eax,eax
    448e:	75 8f                	jne    441f <ringbuffer_dequeue+0x16>
    4490:	eb 01                	jmp    4493 <ringbuffer_dequeue+0x8a>
						return;
    4492:	90                   	nop
				}
		}
//		spin_unlock(&rb->lock);
}
    4493:	c9                   	leave
    4494:	c3                   	ret

00004495 <ringbuffer_available>:

size_t ringbuffer_available(void* rbi)
{
    4495:	55                   	push   ebp
    4496:	89 e5                	mov    ebp,esp
    4498:	83 ec 10             	sub    esp,0x10
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    449b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    449e:	8b 00                	mov    eax,DWORD PTR [eax]
    44a0:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (rb->ofs_end < rb->ofs_start)
    44a3:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    44a6:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    44a9:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    44ac:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    44af:	39 c2                	cmp    edx,eax
    44b1:	73 17                	jae    44ca <ringbuffer_available+0x35>
				return rb->cap - rb->ofs_start + rb->ofs_end;
    44b3:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    44b6:	8b 10                	mov    edx,DWORD PTR [eax]
    44b8:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    44bb:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    44be:	29 c2                	sub    edx,eax
    44c0:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    44c3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    44c6:	01 d0                	add    eax,edx
    44c8:	eb 10                	jmp    44da <ringbuffer_available+0x45>
		else
				return rb->ofs_end - rb->ofs_start;
    44ca:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    44cd:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    44d0:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    44d3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    44d6:	89 c8                	mov    eax,ecx
    44d8:	29 d0                	sub    eax,edx
}
    44da:	c9                   	leave
    44db:	c3                   	ret

000044dc <ringbuffer_free>:

void ringbuffer_free(void* rbi)
{
    44dc:	55                   	push   ebp
    44dd:	89 e5                	mov    ebp,esp
    44df:	83 ec 28             	sub    esp,0x28
		struct ringbuffer* rbf = *(struct ringbuffer**)rbi;
    44e2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    44e5:	8b 00                	mov    eax,DWORD PTR [eax]
    44e7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		spin_lock(&rbf->lock);
    44ea:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    44ed:	83 c0 0c             	add    eax,0xc
    44f0:	89 04 24             	mov    DWORD PTR [esp],eax
    44f3:	e8 fc ff ff ff       	call   44f4 <ringbuffer_free+0x18>
		kfree(rbf);
    44f8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    44fb:	89 04 24             	mov    DWORD PTR [esp],eax
    44fe:	e8 fc ff ff ff       	call   44ff <ringbuffer_free+0x23>
		kfree(rbi);
    4503:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4506:	89 04 24             	mov    DWORD PTR [esp],eax
    4509:	e8 fc ff ff ff       	call   450a <ringbuffer_free+0x2e>
}
    450e:	90                   	nop
    450f:	c9                   	leave
    4510:	c3                   	ret

00004511 <spin_lock>:

/* locking functions */
/* linux ticket spin (better than xchg under high contention) */
#define ACCESS_ONCE(x) (*(volatile __typeof__(x)*)&(x))
void spin_lock(spinlock_t* lock)
{
    4511:	55                   	push   ebp
    4512:	89 e5                	mov    ebp,esp
    4514:	83 ec 10             	sub    esp,0x10
		register spinlock_t inc;
		inc.head_tail = 1 << (8 * sizeof(ticket_t));
    4517:	66 c7 45 fe 00 01    	mov    WORD PTR [ebp-0x2],0x100

		inc.head_tail = __sync_fetch_and_add(&lock->head_tail, inc.head_tail);
    451d:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    4521:	0f b7 d0             	movzx  edx,ax
    4524:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4527:	66 f0 0f c1 10       	lock xadd WORD PTR [eax],dx
    452c:	66 89 55 fe          	mov    WORD PTR [ebp-0x2],dx

		for (;;) {
				if (inc.tickets.head == inc.tickets.tail)
    4530:	0f b6 55 fe          	movzx  edx,BYTE PTR [ebp-0x2]
    4534:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
    4538:	38 c2                	cmp    dl,al
    453a:	74 0d                	je     4549 <spin_lock+0x38>
						break;
				_mm_pause();
    453c:	f3 90                	pause
				inc.tickets.head = ACCESS_ONCE(lock->tickets.head);
    453e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4541:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    4544:	88 45 fe             	mov    BYTE PTR [ebp-0x2],al
				if (inc.tickets.head == inc.tickets.tail)
    4547:	eb e7                	jmp    4530 <spin_lock+0x1f>
						break;
    4549:	90                   	nop
		}
}
    454a:	90                   	nop
    454b:	c9                   	leave
    454c:	c3                   	ret

0000454d <spin_lock_init>:

void spin_lock_init(spinlock_t* lock)
{
    454d:	55                   	push   ebp
    454e:	89 e5                	mov    ebp,esp
		*lock = (spinlock_t){0};
    4550:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4553:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
}
    4558:	90                   	nop
    4559:	5d                   	pop    ebp
    455a:	c3                   	ret

0000455b <spin_lock_irq>:

void spin_lock_irq(spinlock_t* lock)
{
    455b:	55                   	push   ebp
    455c:	89 e5                	mov    ebp,esp
    455e:	83 ec 04             	sub    esp,0x4
		asm("cli");
    4561:	fa                   	cli
		spin_lock(lock);
    4562:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4565:	89 04 24             	mov    DWORD PTR [esp],eax
    4568:	e8 fc ff ff ff       	call   4569 <spin_lock_irq+0xe>
}
    456d:	90                   	nop
    456e:	c9                   	leave
    456f:	c3                   	ret

00004570 <spin_lock_irqsave>:

void spin_lock_irqsave(spinlock_t* lock, unsigned long* flags)
{
    4570:	55                   	push   ebp
    4571:	89 e5                	mov    ebp,esp
    4573:	83 ec 18             	sub    esp,0x18
		*flags = !if_enabled();
    4576:	e8 1e bb ff ff       	call   99 <if_enabled>
    457b:	85 c0                	test   eax,eax
    457d:	0f 94 c0             	sete   al
    4580:	0f b6 d0             	movzx  edx,al
    4583:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    4586:	89 10                	mov    DWORD PTR [eax],edx
		asm("cli");
    4588:	fa                   	cli
		preempt_disable();
    4589:	e8 fc ff ff ff       	call   458a <spin_lock_irqsave+0x1a>
    458e:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    4591:	83 c2 01             	add    edx,0x1
    4594:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		spin_lock(lock);
    4597:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    459a:	89 04 24             	mov    DWORD PTR [esp],eax
    459d:	e8 fc ff ff ff       	call   459e <spin_lock_irqsave+0x2e>
}
    45a2:	90                   	nop
    45a3:	c9                   	leave
    45a4:	c3                   	ret

000045a5 <spin_trylock>:

int spin_trylock(spinlock_t* lock)
{
    45a5:	55                   	push   ebp
    45a6:	89 e5                	mov    ebp,esp
    45a8:	83 ec 10             	sub    esp,0x10
		spinlock_t old, new;

		old.head_tail = ACCESS_ONCE(lock->head_tail);
    45ab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    45ae:	0f b7 00             	movzx  eax,WORD PTR [eax]
    45b1:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
		if (old.tickets.head != old.tickets.tail)
    45b5:	0f b6 55 fe          	movzx  edx,BYTE PTR [ebp-0x2]
    45b9:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
    45bd:	38 c2                	cmp    dl,al
    45bf:	74 07                	je     45c8 <spin_trylock+0x23>
				return 0;
    45c1:	b8 00 00 00 00       	mov    eax,0x0
    45c6:	eb 28                	jmp    45f0 <spin_trylock+0x4b>

		new.head_tail = old.head_tail + (1 << (8 * sizeof(ticket_t)));
    45c8:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    45cc:	66 05 00 01          	add    ax,0x100
    45d0:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		return __sync_bool_compare_and_swap(&lock->head_tail, old.head_tail, new.head_tail);
    45d4:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
    45d8:	0f b7 c8             	movzx  ecx,ax
    45db:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    45df:	0f b7 c0             	movzx  eax,ax
    45e2:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    45e5:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [edx],cx
    45ea:	0f 94 c0             	sete   al
    45ed:	0f b6 c0             	movzx  eax,al
}
    45f0:	c9                   	leave
    45f1:	c3                   	ret

000045f2 <spin_trylock_irq>:

int spin_trylock_irq(spinlock_t* lock)
{
    45f2:	55                   	push   ebp
    45f3:	89 e5                	mov    ebp,esp
    45f5:	83 ec 14             	sub    esp,0x14
		int rv;
		asm("cli");
    45f8:	fa                   	cli
		rv = spin_trylock(lock);
    45f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    45fc:	89 04 24             	mov    DWORD PTR [esp],eax
    45ff:	e8 fc ff ff ff       	call   4600 <spin_trylock_irq+0xe>
    4604:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (rv)
    4607:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
    460b:	74 05                	je     4612 <spin_trylock_irq+0x20>
				return rv;
    460d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    4610:	eb 04                	jmp    4616 <spin_trylock_irq+0x24>
		asm("sti");
    4612:	fb                   	sti
		return rv;
    4613:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
    4616:	c9                   	leave
    4617:	c3                   	ret

00004618 <spin_trylock_irqsave>:

int spin_trylock_irqsave(spinlock_t* lock, int* flags)
{
    4618:	55                   	push   ebp
    4619:	89 e5                	mov    ebp,esp
    461b:	83 ec 28             	sub    esp,0x28
		int rv;
		*flags = if_enabled();
    461e:	e8 76 ba ff ff       	call   99 <if_enabled>
    4623:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    4626:	89 02                	mov    DWORD PTR [edx],eax
		asm("cli");
    4628:	fa                   	cli
		preempt_disable();
    4629:	e8 fc ff ff ff       	call   462a <spin_trylock_irqsave+0x12>
    462e:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    4631:	83 c2 01             	add    edx,0x1
    4634:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		rv = spin_trylock(lock);
    4637:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    463a:	89 04 24             	mov    DWORD PTR [esp],eax
    463d:	e8 fc ff ff ff       	call   463e <spin_trylock_irqsave+0x26>
    4642:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv) {
    4645:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    4649:	75 18                	jne    4663 <spin_trylock_irqsave+0x4b>
				if (*flags)
    464b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    464e:	8b 00                	mov    eax,DWORD PTR [eax]
    4650:	85 c0                	test   eax,eax
    4652:	74 01                	je     4655 <spin_trylock_irqsave+0x3d>
						asm("sti");
    4654:	fb                   	sti
				preempt_enable_no_resched();
    4655:	e8 fc ff ff ff       	call   4656 <spin_trylock_irqsave+0x3e>
    465a:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    465d:	83 ea 01             	sub    edx,0x1
    4660:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		}
		return rv;
    4663:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    4666:	c9                   	leave
    4667:	c3                   	ret

00004668 <spin_unlock>:

void spin_unlock(spinlock_t* lock)
{
    4668:	55                   	push   ebp
    4669:	89 e5                	mov    ebp,esp
		__sync_fetch_and_add(&lock->tickets.head, 1);
    466b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    466e:	f0 80 00 01          	lock add BYTE PTR [eax],0x1
}
    4672:	90                   	nop
    4673:	5d                   	pop    ebp
    4674:	c3                   	ret

00004675 <spin_unlock_irq>:

void spin_unlock_irq(spinlock_t* lock)
{
    4675:	55                   	push   ebp
    4676:	89 e5                	mov    ebp,esp
    4678:	83 ec 04             	sub    esp,0x4
		spin_unlock(lock);
    467b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    467e:	89 04 24             	mov    DWORD PTR [esp],eax
    4681:	e8 fc ff ff ff       	call   4682 <spin_unlock_irq+0xd>
		asm("sti");
    4686:	fb                   	sti
}
    4687:	90                   	nop
    4688:	c9                   	leave
    4689:	c3                   	ret

0000468a <spin_unlock_irqrestore>:

void spin_unlock_irqrestore(spinlock_t* lock, unsigned long flags)
{
    468a:	55                   	push   ebp
    468b:	89 e5                	mov    ebp,esp
    468d:	83 ec 18             	sub    esp,0x18
		spin_unlock(lock);
    4690:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4693:	89 04 24             	mov    DWORD PTR [esp],eax
    4696:	e8 fc ff ff ff       	call   4697 <spin_unlock_irqrestore+0xd>
		if (flags)
    469b:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    469f:	74 01                	je     46a2 <spin_unlock_irqrestore+0x18>
				asm("sti");
    46a1:	fb                   	sti
		preempt_enable_no_resched();
    46a2:	e8 fc ff ff ff       	call   46a3 <spin_unlock_irqrestore+0x19>
    46a7:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    46aa:	83 ea 01             	sub    edx,0x1
    46ad:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
}
    46b0:	90                   	nop
    46b1:	c9                   	leave
    46b2:	c3                   	ret

000046b3 <read_lock>:

void read_lock(rwlock_t* lock)
{
    46b3:	55                   	push   ebp
    46b4:	89 e5                	mov    ebp,esp
    46b6:	83 ec 04             	sub    esp,0x4
		if (!__sync_fetch_and_add(&lock->cnts.counter, 1)) {
    46b9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    46bc:	ba 01 00 00 00       	mov    edx,0x1
    46c1:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    46c5:	85 d2                	test   edx,edx
    46c7:	75 0e                	jne    46d7 <read_lock+0x24>
				/* first reader */
				spin_lock(&lock->lock);
    46c9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    46cc:	83 c0 04             	add    eax,0x4
    46cf:	89 04 24             	mov    DWORD PTR [esp],eax
    46d2:	e8 fc ff ff ff       	call   46d3 <read_lock+0x20>
		}
}
    46d7:	90                   	nop
    46d8:	c9                   	leave
    46d9:	c3                   	ret

000046da <read_unlock>:

void read_unlock(rwlock_t* lock)
{
    46da:	55                   	push   ebp
    46db:	89 e5                	mov    ebp,esp
    46dd:	83 ec 04             	sub    esp,0x4
		if (!__sync_sub_and_fetch(&lock->cnts.counter, 1)) {
    46e0:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    46e3:	b8 01 00 00 00       	mov    eax,0x1
    46e8:	f7 d8                	neg    eax
    46ea:	89 c1                	mov    ecx,eax
    46ec:	89 c8                	mov    eax,ecx
    46ee:	f0 0f c1 02          	lock xadd DWORD PTR [edx],eax
    46f2:	01 c8                	add    eax,ecx
    46f4:	85 c0                	test   eax,eax
    46f6:	75 0e                	jne    4706 <read_unlock+0x2c>
				/* last reader, allow writing again */
				spin_unlock(&lock->lock);
    46f8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    46fb:	83 c0 04             	add    eax,0x4
    46fe:	89 04 24             	mov    DWORD PTR [esp],eax
    4701:	e8 fc ff ff ff       	call   4702 <read_unlock+0x28>
		}
}
    4706:	90                   	nop
    4707:	c9                   	leave
    4708:	c3                   	ret

00004709 <write_lock>:

void write_lock(rwlock_t* lock)
{
    4709:	55                   	push   ebp
    470a:	89 e5                	mov    ebp,esp
    470c:	83 ec 04             	sub    esp,0x4
		spin_lock(&lock->lock);
    470f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4712:	83 c0 04             	add    eax,0x4
    4715:	89 04 24             	mov    DWORD PTR [esp],eax
    4718:	e8 fc ff ff ff       	call   4719 <write_lock+0x10>
}
    471d:	90                   	nop
    471e:	c9                   	leave
    471f:	c3                   	ret

00004720 <write_trylock>:

int write_trylock(rwlock_t* lock)
{
    4720:	55                   	push   ebp
    4721:	89 e5                	mov    ebp,esp
    4723:	83 ec 04             	sub    esp,0x4
		return spin_trylock(&lock->lock);
    4726:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4729:	83 c0 04             	add    eax,0x4
    472c:	89 04 24             	mov    DWORD PTR [esp],eax
    472f:	e8 fc ff ff ff       	call   4730 <write_trylock+0x10>
}
    4734:	c9                   	leave
    4735:	c3                   	ret

00004736 <write_unlock>:

void write_unlock(rwlock_t* lock)
{
    4736:	55                   	push   ebp
    4737:	89 e5                	mov    ebp,esp
    4739:	83 ec 04             	sub    esp,0x4
		spin_unlock(&lock->lock);
    473c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    473f:	83 c0 04             	add    eax,0x4
    4742:	89 04 24             	mov    DWORD PTR [esp],eax
    4745:	e8 fc ff ff ff       	call   4746 <write_unlock+0x10>
}
    474a:	90                   	nop
    474b:	c9                   	leave
    474c:	c3                   	ret
