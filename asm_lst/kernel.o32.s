
kernel.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
		outb(PIC1_COMMAND, 0xff);
}

uint16_t pic_get_irr() /* currently requested interrupts */
{
		outb(PIC1_COMMAND, 0x0a); /* PIC_READ_IRR */
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
		outb(PIC2_COMMAND, 0x0a);
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
}

uint16_t pic_get_isr() /* currently serviced interrput */
       6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
       c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
{
		outb(PIC1_COMMAND, 0x0b); /* PIC_READ_ISR */
       f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
		outb(PIC2_COMMAND, 0x0b);
      12:	c9                   	leave
      13:	c3                   	ret

00000014 <io_wait>:
{
		for (int i = 0; i < 4; i++)
				if (com_ports[i]) {
						uint16_t port = com_ports[i];
						uint8_t lsr;
						lsr = inb(port + 5);
      14:	55                   	push   ebp
      15:	89 e5                	mov    ebp,esp
						printf("COM%d lsr: %08b\n", i, lsr);
      17:	b8 00 00 00 00       	mov    eax,0x0
      1c:	e6 80                	out    0x80,al
				}
      1e:	90                   	nop
      1f:	5d                   	pop    ebp
      20:	c3                   	ret

00000021 <outb>:
}

int is_transit_empty(uint16_t port)
      21:	55                   	push   ebp
      22:	89 e5                	mov    ebp,esp
      24:	83 ec 08             	sub    esp,0x8
      27:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      2a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      2d:	66 89 55 fc          	mov    WORD PTR [ebp-0x4],dx
      31:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
{
      34:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
      38:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      3c:	ee                   	out    dx,al
		return inb(port + 5) & 0x20;
      3d:	90                   	nop
      3e:	c9                   	leave
      3f:	c3                   	ret

00000040 <inb>:
}

void putDebugChar(char c)
      40:	55                   	push   ebp
      41:	89 e5                	mov    ebp,esp
      43:	83 ec 14             	sub    esp,0x14
      46:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      49:	66 89 45 ec          	mov    WORD PTR [ebp-0x14],ax
{
		while (!is_transit_empty(def_port));
      4d:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
      51:	89 c2                	mov    edx,eax
      53:	ec                   	in     al,dx
      54:	88 45 ff             	mov    BYTE PTR [ebp-0x1],al
		outb(def_port, c);
      57:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
}
      5b:	c9                   	leave
      5c:	c3                   	ret

0000005d <memcpy>:
		if (!irq || irq > 15)
				return;
		pt = irq_funs[--irq]; /* 1 based */
		while (pt) {
				if (pt->fun(irq + 1)) /* handled */
						break;
      5d:	55                   	push   ebp
      5e:	89 e5                	mov    ebp,esp
      60:	83 ec 10             	sub    esp,0x10
				pt = pt->next;
      63:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      66:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		}
      69:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      6c:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
}
      6f:	eb 17                	jmp    88 <memcpy+0x2b>

      71:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      74:	8d 42 01             	lea    eax,[edx+0x1]
      77:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      7a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      7d:	8d 48 01             	lea    ecx,[eax+0x1]
      80:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      83:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      86:	88 10                	mov    BYTE PTR [eax],dl
}
      88:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      8b:	8d 50 ff             	lea    edx,[eax-0x1]
      8e:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      91:	85 c0                	test   eax,eax
      93:	75 dc                	jne    71 <memcpy+0x14>
int install_irq_handler(unsigned int irq, irq_handler_function fun)
      95:	90                   	nop
      96:	90                   	nop
      97:	c9                   	leave
      98:	c3                   	ret

00000099 <if_enabled>:
						else if (i < l_n)
								putc_prc(&km_regC, KFMT_WARN, '|', i, 0);
						else if (i < l_u)
								putc_prc(&km_regC, KFMT_INFO, '|', i, 0);
						else
								putc_prc(&km_regC, KFMT_NORMAL, ' ', i, 0);
      99:	55                   	push   ebp
      9a:	89 e5                	mov    ebp,esp
      9c:	83 ec 10             	sub    esp,0x10
				}
				/* also written */
      9f:	9c                   	pushf
      a0:	58                   	pop    eax
      a1:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				pc_b = min(9, 10 - cpu_pcs[0].vals[4]);
				if (pc_a == 100)
						pc_b = 0;
				crprintf(KFMT_NORMAL, &km_regC, "%3u.%1u%%", pc_a, pc_b);
		}
}
      a4:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      a7:	83 e0 20             	and    eax,0x20
      aa:	85 c0                	test   eax,eax
      ac:	0f 95 c0             	setne  al
      af:	0f b6 c0             	movzx  eax,al

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
		struct IDTDescr* dt = &idt;
     12a:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
		if (i < 17) {
     131:	83 7d 08 10          	cmp    DWORD PTR [ebp+0x8],0x10
     135:	7f 34                	jg     16b <exceptionHandler+0x47>
				dt[i].offset_1 = (uint16_t)((uint32_t)ptr & 0x0000ffff);
     137:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
     13a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     13d:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     144:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     147:	01 d0                	add    eax,edx
     149:	89 ca                	mov    edx,ecx
     14b:	66 89 10             	mov    WORD PTR [eax],dx
				dt[i].offset_2 = (uint16_t)((uint32_t)ptr >> 16);
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
     171:	83 ec 08             	sub    esp,0x8
		while (eip);
     174:	90                   	nop
     175:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     179:	75 fa                	jne    175 <print_exception+0x7>
		switch (code) {
     17b:	83 7d 0c 1e          	cmp    DWORD PTR [ebp+0xc],0x1e
     17f:	0f 87 92 01 00 00    	ja     317 <print_exception+0x1a9>
     185:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     188:	c1 e0 02             	shl    eax,0x2
     18b:	05 30 01 00 00       	add    eax,0x130
     190:	8b 00                	mov    eax,DWORD PTR [eax]
     192:	ff e0                	jmp    eax
					printf("#DE at %p\n", eip);
     194:	83 ec 08             	sub    esp,0x8
     197:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     19a:	68 00 00 00 00       	push   0x0
     19f:	e8 fc ff ff ff       	call   1a0 <print_exception+0x32>
     1a4:	83 c4 10             	add    esp,0x10
					break;
     1a7:	e9 82 01 00 00       	jmp    32e <print_exception+0x1c0>
					printf("#BP at %p\n", (void*)((char*)eip-1));
     1ac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1af:	83 e8 01             	sub    eax,0x1
     1b2:	83 ec 08             	sub    esp,0x8
     1b5:	50                   	push   eax
     1b6:	68 0b 00 00 00       	push   0xb
     1bb:	e8 fc ff ff ff       	call   1bc <print_exception+0x4e>
     1c0:	83 c4 10             	add    esp,0x10
					break;
     1c3:	e9 66 01 00 00       	jmp    32e <print_exception+0x1c0>
					printf("#OF before %p\n", eip);
     1c8:	83 ec 08             	sub    esp,0x8
     1cb:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     1ce:	68 16 00 00 00       	push   0x16
     1d3:	e8 fc ff ff ff       	call   1d4 <print_exception+0x66>
     1d8:	83 c4 10             	add    esp,0x10
					break;
     1db:	e9 4e 01 00 00       	jmp    32e <print_exception+0x1c0>
					printf("#BR at %p\n", eip);
     1e0:	83 ec 08             	sub    esp,0x8
     1e3:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     1e6:	68 25 00 00 00       	push   0x25
     1eb:	e8 fc ff ff ff       	call   1ec <print_exception+0x7e>
     1f0:	83 c4 10             	add    esp,0x10
					while (1);
     1f3:	90                   	nop
     1f4:	eb fd                	jmp    1f3 <print_exception+0x85>
					printf("#UD at %p\n", eip);
     1f6:	83 ec 08             	sub    esp,0x8
     1f9:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     1fc:	68 30 00 00 00       	push   0x30
     201:	e8 fc ff ff ff       	call   202 <print_exception+0x94>
     206:	83 c4 10             	add    esp,0x10
					while (1);
     209:	90                   	nop
     20a:	eb fd                	jmp    209 <print_exception+0x9b>
					printf("#NM at %p\nFPU is disabled or not present\n", eip);
     20c:	83 ec 08             	sub    esp,0x8
     20f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     212:	68 3c 00 00 00       	push   0x3c
     217:	e8 fc ff ff ff       	call   218 <print_exception+0xaa>
     21c:	83 c4 10             	add    esp,0x10
					break;
     21f:	e9 0a 01 00 00       	jmp    32e <print_exception+0x1c0>
					printf("#DF with error code %x\n", (unsigned int)eip);
     224:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     227:	83 ec 08             	sub    esp,0x8
     22a:	50                   	push   eax
     22b:	68 66 00 00 00       	push   0x66
     230:	e8 fc ff ff ff       	call   231 <print_exception+0xc3>
     235:	83 c4 10             	add    esp,0x10
					die("that's it");
     238:	83 ec 08             	sub    esp,0x8
     23b:	68 7e 00 00 00       	push   0x7e
     240:	6a 0c                	push   0xc
     242:	e8 fc ff ff ff       	call   243 <print_exception+0xd5>
     247:	83 c4 10             	add    esp,0x10
     24a:	e8 fc ff ff ff       	call   24b <print_exception+0xdd>
     24f:	83 ec 0c             	sub    esp,0xc
     252:	68 00 00 00 00       	push   0x0
     257:	e8 fc ff ff ff       	call   258 <print_exception+0xea>
     25c:	83 c4 10             	add    esp,0x10
     25f:	fa                   	cli
     260:	f4                   	hlt
     261:	eb fd                	jmp    260 <print_exception+0xf2>
					printf("Legacy coprocessor segment overrun at %p\n", eip);
     263:	83 ec 08             	sub    esp,0x8
     266:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     269:	68 88 00 00 00       	push   0x88
     26e:	e8 fc ff ff ff       	call   26f <print_exception+0x101>
     273:	83 c4 10             	add    esp,0x10
					break;
     276:	e9 b3 00 00 00       	jmp    32e <print_exception+0x1c0>
					printf("Reserved gate called from %p\n", eip);
     27b:	83 ec 08             	sub    esp,0x8
     27e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     281:	68 b2 00 00 00       	push   0xb2
     286:	e8 fc ff ff ff       	call   287 <print_exception+0x119>
     28b:	83 c4 10             	add    esp,0x10
					break;
     28e:	e9 9b 00 00 00       	jmp    32e <print_exception+0x1c0>
					printf("#MF at %p\n", eip);
     293:	83 ec 08             	sub    esp,0x8
     296:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     299:	68 d0 00 00 00       	push   0xd0
     29e:	e8 fc ff ff ff       	call   29f <print_exception+0x131>
     2a3:	83 c4 10             	add    esp,0x10
					break;
     2a6:	e9 83 00 00 00       	jmp    32e <print_exception+0x1c0>
					printf("#AC at %p\n", eip);
     2ab:	83 ec 08             	sub    esp,0x8
     2ae:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     2b1:	68 db 00 00 00       	push   0xdb
     2b6:	e8 fc ff ff ff       	call   2b7 <print_exception+0x149>
     2bb:	83 c4 10             	add    esp,0x10
					break;
     2be:	eb 6e                	jmp    32e <print_exception+0x1c0>
					cprintf(KFMT_ERROR, "#MC received while at %p\n", eip);
     2c0:	83 ec 04             	sub    esp,0x4
     2c3:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     2c6:	68 e6 00 00 00       	push   0xe6
     2cb:	6a 0c                	push   0xc
     2cd:	e8 fc ff ff ff       	call   2ce <print_exception+0x160>
     2d2:	83 c4 10             	add    esp,0x10
					while (1);
     2d5:	90                   	nop
     2d6:	eb fd                	jmp    2d5 <print_exception+0x167>
					printf("#XM at %p\n", eip);
     2d8:	83 ec 08             	sub    esp,0x8
     2db:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     2de:	68 00 01 00 00       	push   0x100
     2e3:	e8 fc ff ff ff       	call   2e4 <print_exception+0x176>
     2e8:	83 c4 10             	add    esp,0x10
					break;
     2eb:	eb 41                	jmp    32e <print_exception+0x1c0>
					printf("#VE at %p\n", eip);
     2ed:	83 ec 08             	sub    esp,0x8
     2f0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     2f3:	68 0b 01 00 00       	push   0x10b
     2f8:	e8 fc ff ff ff       	call   2f9 <print_exception+0x18b>
     2fd:	83 c4 10             	add    esp,0x10
					break;
     300:	eb 2c                	jmp    32e <print_exception+0x1c0>
					printf("#SX at %p\n", eip);
     302:	83 ec 08             	sub    esp,0x8
     305:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     308:	68 16 01 00 00       	push   0x116
     30d:	e8 fc ff ff ff       	call   30e <print_exception+0x1a0>
     312:	83 c4 10             	add    esp,0x10
					break;
     315:	eb 17                	jmp    32e <print_exception+0x1c0>
					printf("int %x at %p\n", code, eip);
     317:	83 ec 04             	sub    esp,0x4
     31a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     31d:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     320:	68 21 01 00 00       	push   0x121
     325:	e8 fc ff ff ff       	call   326 <print_exception+0x1b8>
     32a:	83 c4 10             	add    esp,0x10
					break;
     32d:	90                   	nop
}
     32e:	90                   	nop
     32f:	c9                   	leave
     330:	c3                   	ret

00000331 <print_idt>:
{
     331:	55                   	push   ebp
     332:	89 e5                	mov    ebp,esp
     334:	83 ec 18             	sub    esp,0x18
		printf("IDT at %p\n", idt);
     337:	83 ec 08             	sub    esp,0x8
     33a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     33d:	68 ac 01 00 00       	push   0x1ac
     342:	e8 fc ff ff ff       	call   343 <print_idt+0x12>
     347:	83 c4 10             	add    esp,0x10
		for (i = 0; i < num; i++) {
     34a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     351:	eb 4e                	jmp    3a1 <print_idt+0x70>
								idt->type_attr);
     353:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     356:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
				printf("IDT entry %d: %x:%p type=%x\n", i, idt->selector,
     35a:	0f b6 d0             	movzx  edx,al
								(void*)((((unsigned int)idt->offset_2) << 16) + idt->offset_1),
     35d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     360:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     364:	0f b7 c0             	movzx  eax,ax
     367:	c1 e0 10             	shl    eax,0x10
     36a:	89 c1                	mov    ecx,eax
     36c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     36f:	0f b7 00             	movzx  eax,WORD PTR [eax]
     372:	0f b7 c0             	movzx  eax,ax
     375:	01 c8                	add    eax,ecx
				printf("IDT entry %d: %x:%p type=%x\n", i, idt->selector,
     377:	89 c1                	mov    ecx,eax
     379:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     37c:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     380:	0f b7 c0             	movzx  eax,ax
     383:	83 ec 0c             	sub    esp,0xc
     386:	52                   	push   edx
     387:	51                   	push   ecx
     388:	50                   	push   eax
     389:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     38c:	68 b7 01 00 00       	push   0x1b7
     391:	e8 fc ff ff ff       	call   392 <print_idt+0x61>
     396:	83 c4 20             	add    esp,0x20
				idt++;
     399:	83 45 08 08          	add    DWORD PTR [ebp+0x8],0x8
		for (i = 0; i < num; i++) {
     39d:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     3a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3a4:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
     3a7:	72 aa                	jb     353 <print_idt+0x22>
}
     3a9:	90                   	nop
     3aa:	90                   	nop
     3ab:	c9                   	leave
     3ac:	c3                   	ret

000003ad <debug_handler>:
{
     3ad:	55                   	push   ebp
     3ae:	89 e5                	mov    ebp,esp
     3b0:	83 ec 08             	sub    esp,0x8
		cprintf(KFMT_INFO, "#DB at %p with DR6=%x\n", eip, dr6);
     3b3:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     3b6:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     3b9:	68 d4 01 00 00       	push   0x1d4
     3be:	6a 0b                	push   0xb
     3c0:	e8 fc ff ff ff       	call   3c1 <debug_handler+0x14>
     3c5:	83 c4 10             	add    esp,0x10
		return 0;
     3c8:	b8 00 00 00 00       	mov    eax,0x0
}
     3cd:	c9                   	leave
     3ce:	c3                   	ret

000003cf <irq_mask>:
{
     3cf:	55                   	push   ebp
     3d0:	89 e5                	mov    ebp,esp
     3d2:	53                   	push   ebx
     3d3:	83 ec 14             	sub    esp,0x14
     3d6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3d9:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		if (line < 8)
     3dc:	80 7d e8 07          	cmp    BYTE PTR [ebp-0x18],0x7
     3e0:	77 08                	ja     3ea <irq_mask+0x1b>
				prt = PIC1_DATA;
     3e2:	66 c7 45 fa 21 00    	mov    WORD PTR [ebp-0x6],0x21
     3e8:	eb 10                	jmp    3fa <irq_mask+0x2b>
		else if (line <= 15) {
     3ea:	80 7d e8 0f          	cmp    BYTE PTR [ebp-0x18],0xf
     3ee:	77 41                	ja     431 <irq_mask+0x62>
				prt = PIC2_DATA;
     3f0:	66 c7 45 fa a1 00    	mov    WORD PTR [ebp-0x6],0xa1
				line -= 8;
     3f6:	80 6d e8 08          	sub    BYTE PTR [ebp-0x18],0x8
		line = inb(prt) | (1 << line);
     3fa:	0f b7 45 fa          	movzx  eax,WORD PTR [ebp-0x6]
     3fe:	50                   	push   eax
     3ff:	e8 3c fc ff ff       	call   40 <inb>
     404:	83 c4 04             	add    esp,0x4
     407:	89 c3                	mov    ebx,eax
     409:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
     40d:	ba 01 00 00 00       	mov    edx,0x1
     412:	89 c1                	mov    ecx,eax
     414:	d3 e2                	shl    edx,cl
     416:	89 d0                	mov    eax,edx
     418:	09 d8                	or     eax,ebx
     41a:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		outb(prt, line);
     41d:	0f b6 55 e8          	movzx  edx,BYTE PTR [ebp-0x18]
     421:	0f b7 45 fa          	movzx  eax,WORD PTR [ebp-0x6]
     425:	52                   	push   edx
     426:	50                   	push   eax
     427:	e8 f5 fb ff ff       	call   21 <outb>
     42c:	83 c4 08             	add    esp,0x8
     42f:	eb 01                	jmp    432 <irq_mask+0x63>
				return;
     431:	90                   	nop
}
     432:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     435:	c9                   	leave
     436:	c3                   	ret

00000437 <irq_unmask>:
{
     437:	55                   	push   ebp
     438:	89 e5                	mov    ebp,esp
     43a:	53                   	push   ebx
     43b:	83 ec 14             	sub    esp,0x14
     43e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     441:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		if (line < 8)
     444:	80 7d e8 07          	cmp    BYTE PTR [ebp-0x18],0x7
     448:	77 08                	ja     452 <irq_unmask+0x1b>
				prt = PIC1_DATA;
     44a:	66 c7 45 fa 21 00    	mov    WORD PTR [ebp-0x6],0x21
     450:	eb 10                	jmp    462 <irq_unmask+0x2b>
		else if (line <= 15) {
     452:	80 7d e8 0f          	cmp    BYTE PTR [ebp-0x18],0xf
     456:	77 43                	ja     49b <irq_unmask+0x64>
				prt = PIC2_DATA;
     458:	66 c7 45 fa a1 00    	mov    WORD PTR [ebp-0x6],0xa1
				line -= 8;
     45e:	80 6d e8 08          	sub    BYTE PTR [ebp-0x18],0x8
		line = inb(prt) & ~(1 << line);
     462:	0f b7 45 fa          	movzx  eax,WORD PTR [ebp-0x6]
     466:	50                   	push   eax
     467:	e8 d4 fb ff ff       	call   40 <inb>
     46c:	83 c4 04             	add    esp,0x4
     46f:	89 c3                	mov    ebx,eax
     471:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
     475:	ba 01 00 00 00       	mov    edx,0x1
     47a:	89 c1                	mov    ecx,eax
     47c:	d3 e2                	shl    edx,cl
     47e:	89 d0                	mov    eax,edx
     480:	f7 d0                	not    eax
     482:	21 d8                	and    eax,ebx
     484:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		outb(prt, line);
     487:	0f b6 55 e8          	movzx  edx,BYTE PTR [ebp-0x18]
     48b:	0f b7 45 fa          	movzx  eax,WORD PTR [ebp-0x6]
     48f:	52                   	push   edx
     490:	50                   	push   eax
     491:	e8 8b fb ff ff       	call   21 <outb>
     496:	83 c4 08             	add    esp,0x8
     499:	eb 01                	jmp    49c <irq_unmask+0x65>
				return;
     49b:	90                   	nop
}
     49c:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     49f:	c9                   	leave
     4a0:	c3                   	ret

000004a1 <pic_disable>:
{
     4a1:	55                   	push   ebp
     4a2:	89 e5                	mov    ebp,esp
		outb(PIC2_COMMAND, 0xff);
     4a4:	68 ff 00 00 00       	push   0xff
     4a9:	68 a0 00 00 00       	push   0xa0
     4ae:	e8 6e fb ff ff       	call   21 <outb>
     4b3:	83 c4 08             	add    esp,0x8
		outb(PIC1_COMMAND, 0xff);
     4b6:	68 ff 00 00 00       	push   0xff
     4bb:	6a 20                	push   0x20
     4bd:	e8 5f fb ff ff       	call   21 <outb>
     4c2:	83 c4 08             	add    esp,0x8
}
     4c5:	90                   	nop
     4c6:	c9                   	leave
     4c7:	c3                   	ret

000004c8 <pic_get_irr>:
{
     4c8:	55                   	push   ebp
     4c9:	89 e5                	mov    ebp,esp
     4cb:	53                   	push   ebx
		outb(PIC1_COMMAND, 0x0a); /* PIC_READ_IRR */
     4cc:	6a 0a                	push   0xa
     4ce:	6a 20                	push   0x20
     4d0:	e8 4c fb ff ff       	call   21 <outb>
     4d5:	83 c4 08             	add    esp,0x8
		outb(PIC2_COMMAND, 0x0a);
     4d8:	6a 0a                	push   0xa
     4da:	68 a0 00 00 00       	push   0xa0
     4df:	e8 3d fb ff ff       	call   21 <outb>
     4e4:	83 c4 08             	add    esp,0x8
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
     4e7:	68 a0 00 00 00       	push   0xa0
     4ec:	e8 4f fb ff ff       	call   40 <inb>
     4f1:	83 c4 04             	add    esp,0x4
     4f4:	0f b6 c0             	movzx  eax,al
     4f7:	c1 e0 08             	shl    eax,0x8
     4fa:	89 c3                	mov    ebx,eax
     4fc:	6a 20                	push   0x20
     4fe:	e8 3d fb ff ff       	call   40 <inb>
     503:	83 c4 04             	add    esp,0x4
     506:	0f b6 c0             	movzx  eax,al
     509:	09 d8                	or     eax,ebx
}
     50b:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     50e:	c9                   	leave
     50f:	c3                   	ret

00000510 <pic_get_isr>:
{
     510:	55                   	push   ebp
     511:	89 e5                	mov    ebp,esp
     513:	53                   	push   ebx
		outb(PIC1_COMMAND, 0x0b); /* PIC_READ_ISR */
     514:	6a 0b                	push   0xb
     516:	6a 20                	push   0x20
     518:	e8 04 fb ff ff       	call   21 <outb>
     51d:	83 c4 08             	add    esp,0x8
		outb(PIC2_COMMAND, 0x0b);
     520:	6a 0b                	push   0xb
     522:	68 a0 00 00 00       	push   0xa0
     527:	e8 f5 fa ff ff       	call   21 <outb>
     52c:	83 c4 08             	add    esp,0x8
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
     52f:	68 a0 00 00 00       	push   0xa0
     534:	e8 07 fb ff ff       	call   40 <inb>
     539:	83 c4 04             	add    esp,0x4
     53c:	0f b6 c0             	movzx  eax,al
     53f:	c1 e0 08             	shl    eax,0x8
     542:	89 c3                	mov    ebx,eax
     544:	6a 20                	push   0x20
     546:	e8 f5 fa ff ff       	call   40 <inb>
     54b:	83 c4 04             	add    esp,0x4
     54e:	0f b6 c0             	movzx  eax,al
     551:	09 d8                	or     eax,ebx
}
     553:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     556:	c9                   	leave
     557:	c3                   	ret

00000558 <enable_com>:
{
     558:	55                   	push   ebp
     559:	89 e5                	mov    ebp,esp
     55b:	83 ec 04             	sub    esp,0x4
     55e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     561:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		if (!com_present) {
     565:	a1 10 02 00 00       	mov    eax,ds:0x210
     56a:	85 c0                	test   eax,eax
     56c:	75 28                	jne    596 <enable_com+0x3e>
				com_present = 1;
     56e:	c7 05 10 02 00 00 01 00 00 00 	mov    DWORD PTR ds:0x210,0x1
				def_port = port;
     578:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     57c:	66 a3 1c 02 00 00    	mov    ds:0x21c,ax
				irq_unmask(3);
     582:	6a 03                	push   0x3
     584:	e8 fc ff ff ff       	call   585 <enable_com+0x2d>
     589:	83 c4 04             	add    esp,0x4
				irq_unmask(4);
     58c:	6a 04                	push   0x4
     58e:	e8 fc ff ff ff       	call   58f <enable_com+0x37>
     593:	83 c4 04             	add    esp,0x4
		if (num < 4)
     596:	83 7d 08 03          	cmp    DWORD PTR [ebp+0x8],0x3
     59a:	7f 0f                	jg     5ab <enable_com+0x53>
				com_ports[num] = port;
     59c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     59f:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
     5a3:	66 89 94 00 14 02 00 00 	mov    WORD PTR [eax+eax*1+0x214],dx
		outb(port + 1, 0x00); /* disable interrupts */
     5ab:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     5af:	83 c0 01             	add    eax,0x1
     5b2:	0f b7 c0             	movzx  eax,ax
     5b5:	6a 00                	push   0x0
     5b7:	50                   	push   eax
     5b8:	e8 64 fa ff ff       	call   21 <outb>
     5bd:	83 c4 08             	add    esp,0x8
		outb(port + 3, 0x80); /* DLAB enable */
     5c0:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     5c4:	83 c0 03             	add    eax,0x3
     5c7:	0f b7 c0             	movzx  eax,ax
     5ca:	68 80 00 00 00       	push   0x80
     5cf:	50                   	push   eax
     5d0:	e8 4c fa ff ff       	call   21 <outb>
     5d5:	83 c4 08             	add    esp,0x8
		outb(port + 0, 0x0c); /* baud 9600 (div 12) */
     5d8:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     5dc:	6a 0c                	push   0xc
     5de:	50                   	push   eax
     5df:	e8 3d fa ff ff       	call   21 <outb>
     5e4:	83 c4 08             	add    esp,0x8
		outb(port + 1, 0x00);
     5e7:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     5eb:	83 c0 01             	add    eax,0x1
     5ee:	0f b7 c0             	movzx  eax,ax
     5f1:	6a 00                	push   0x0
     5f3:	50                   	push   eax
     5f4:	e8 28 fa ff ff       	call   21 <outb>
     5f9:	83 c4 08             	add    esp,0x8
		outb(port + 3, 0x03); /* DLAB disable, 8+1 bits no parity */
     5fc:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     600:	83 c0 03             	add    eax,0x3
     603:	0f b7 c0             	movzx  eax,ax
     606:	6a 03                	push   0x3
     608:	50                   	push   eax
     609:	e8 13 fa ff ff       	call   21 <outb>
     60e:	83 c4 08             	add    esp,0x8
		outb(port + 2, 0xe7); /* enable FIFO and trigger at 14 bytes and clear */
     611:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     615:	83 c0 02             	add    eax,0x2
     618:	0f b7 c0             	movzx  eax,ax
     61b:	68 e7 00 00 00       	push   0xe7
     620:	50                   	push   eax
     621:	e8 fb f9 ff ff       	call   21 <outb>
     626:	83 c4 08             	add    esp,0x8
		outb(port + 4, 0x0b);
     629:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     62d:	83 c0 04             	add    eax,0x4
     630:	0f b7 c0             	movzx  eax,ax
     633:	6a 0b                	push   0xb
     635:	50                   	push   eax
     636:	e8 e6 f9 ff ff       	call   21 <outb>
     63b:	83 c4 08             	add    esp,0x8
		outb(port + 1, 0x07); /* enable buf empty & recv & line status interrupt */
     63e:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     642:	83 c0 01             	add    eax,0x1
     645:	0f b7 c0             	movzx  eax,ax
     648:	6a 07                	push   0x7
     64a:	50                   	push   eax
     64b:	e8 d1 f9 ff ff       	call   21 <outb>
     650:	83 c4 08             	add    esp,0x8
}
     653:	90                   	nop
     654:	c9                   	leave
     655:	c3                   	ret

00000656 <com_interrupt>:
{
     656:	55                   	push   ebp
     657:	89 e5                	mov    ebp,esp
     659:	83 ec 18             	sub    esp,0x18
		for (int i = 0; i < 4; i++) {
     65c:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     663:	e9 d1 01 00 00       	jmp    839 <com_interrupt+0x1e3>
				port = com_ports[i];
     668:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     66b:	0f b7 84 00 14 02 00 00 	movzx  eax,WORD PTR [eax+eax*1+0x214]
     673:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
				if (!port)
     677:	66 83 7d f2 00       	cmp    WORD PTR [ebp-0xe],0x0
     67c:	0f 84 af 01 00 00    	je     831 <com_interrupt+0x1db>
				iir = inb(port + 2);
     682:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     686:	83 c0 02             	add    eax,0x2
     689:	0f b7 c0             	movzx  eax,ax
     68c:	50                   	push   eax
     68d:	e8 ae f9 ff ff       	call   40 <inb>
     692:	83 c4 04             	add    esp,0x4
     695:	88 45 f1             	mov    BYTE PTR [ebp-0xf],al
				if ((iir & 1)) /* 0 means yes 1 no */
     698:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     69c:	83 e0 01             	and    eax,0x1
     69f:	85 c0                	test   eax,eax
     6a1:	0f 85 8d 01 00 00    	jne    834 <com_interrupt+0x1de>
				if ((iir & 0x0e) == 0x00) /* modem status*/
     6a7:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     6ab:	83 e0 0e             	and    eax,0xe
     6ae:	85 c0                	test   eax,eax
     6b0:	75 15                	jne    6c7 <com_interrupt+0x71>
						inb(port + 6); /* just pop the interrupt */
     6b2:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     6b6:	83 c0 06             	add    eax,0x6
     6b9:	0f b7 c0             	movzx  eax,ax
     6bc:	50                   	push   eax
     6bd:	e8 7e f9 ff ff       	call   40 <inb>
     6c2:	83 c4 04             	add    esp,0x4
     6c5:	eb 55                	jmp    71c <com_interrupt+0xc6>
				else if ((iir & 0x0e) == 0x02) { /* transmitter empty */
     6c7:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     6cb:	83 e0 0e             	and    eax,0xe
     6ce:	83 f8 02             	cmp    eax,0x2
     6d1:	74 49                	je     71c <com_interrupt+0xc6>
				} else if ((iir & 0x0e) == 0x04) { /* data available */
     6d3:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     6d7:	83 e0 0e             	and    eax,0xe
     6da:	83 f8 04             	cmp    eax,0x4
     6dd:	74 3d                	je     71c <com_interrupt+0xc6>
				} else if ((iir & 0x0e) == 0x06) { /* line status interrupt */
     6df:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     6e3:	83 e0 0e             	and    eax,0xe
     6e6:	83 f8 06             	cmp    eax,0x6
     6e9:	75 12                	jne    6fd <com_interrupt+0xa7>
						iprintf("line status:\n");
     6eb:	83 ec 0c             	sub    esp,0xc
     6ee:	68 eb 01 00 00       	push   0x1eb
     6f3:	e8 fc ff ff ff       	call   6f4 <com_interrupt+0x9e>
     6f8:	83 c4 10             	add    esp,0x10
     6fb:	eb 1f                	jmp    71c <com_interrupt+0xc6>
				} else if ((iir & 0x0e) == 0x0c) { /* time out */
     6fd:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     701:	83 e0 0e             	and    eax,0xe
     704:	83 f8 0c             	cmp    eax,0xc
     707:	74 13                	je     71c <com_interrupt+0xc6>
						iprintf("unknown interrupt on COM%d\n", i);
     709:	83 ec 08             	sub    esp,0x8
     70c:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     70f:	68 f9 01 00 00       	push   0x1f9
     714:	e8 fc ff ff ff       	call   715 <com_interrupt+0xbf>
     719:	83 c4 10             	add    esp,0x10
				lsr = inb(port + 5);
     71c:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     720:	83 c0 05             	add    eax,0x5
     723:	0f b7 c0             	movzx  eax,ax
     726:	83 ec 0c             	sub    esp,0xc
     729:	50                   	push   eax
     72a:	e8 11 f9 ff ff       	call   40 <inb>
     72f:	83 c4 10             	add    esp,0x10
     732:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
				if (lsr & (1 << 7)) { /* clear fifo */
     735:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     739:	84 c0                	test   al,al
     73b:	79 1d                	jns    75a <com_interrupt+0x104>
						outb(port + 2, 0xc7);
     73d:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     741:	83 c0 02             	add    eax,0x2
     744:	0f b7 c0             	movzx  eax,ax
     747:	83 ec 08             	sub    esp,0x8
     74a:	68 c7 00 00 00       	push   0xc7
     74f:	50                   	push   eax
     750:	e8 cc f8 ff ff       	call   21 <outb>
     755:	83 c4 10             	add    esp,0x10
     758:	eb 5e                	jmp    7b8 <com_interrupt+0x162>
				} else if (lsr & (1 << 3)) { /* framing error */
     75a:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     75e:	83 e0 08             	and    eax,0x8
     761:	85 c0                	test   eax,eax
     763:	74 15                	je     77a <com_interrupt+0x124>
						iprintf("COM%d framing error\n", i);
     765:	83 ec 08             	sub    esp,0x8
     768:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     76b:	68 15 02 00 00       	push   0x215
     770:	e8 fc ff ff ff       	call   771 <com_interrupt+0x11b>
     775:	83 c4 10             	add    esp,0x10
     778:	eb 3e                	jmp    7b8 <com_interrupt+0x162>
				} else if (lsr & (1 << 2)) { /* parity error */
     77a:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     77e:	83 e0 04             	and    eax,0x4
     781:	85 c0                	test   eax,eax
     783:	74 15                	je     79a <com_interrupt+0x144>
						iprintf("COM%d parity error\n", i);
     785:	83 ec 08             	sub    esp,0x8
     788:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     78b:	68 2a 02 00 00       	push   0x22a
     790:	e8 fc ff ff ff       	call   791 <com_interrupt+0x13b>
     795:	83 c4 10             	add    esp,0x10
     798:	eb 1e                	jmp    7b8 <com_interrupt+0x162>
				} else if (lsr & (1 << 1)) { /* overrun */
     79a:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     79e:	83 e0 02             	and    eax,0x2
     7a1:	85 c0                	test   eax,eax
     7a3:	74 13                	je     7b8 <com_interrupt+0x162>
						iprintf("COM%d overrun\n", i);
     7a5:	83 ec 08             	sub    esp,0x8
     7a8:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     7ab:	68 3e 02 00 00       	push   0x23e
     7b0:	e8 fc ff ff ff       	call   7b1 <com_interrupt+0x15b>
     7b5:	83 c4 10             	add    esp,0x10
				if (lsr & 1) { /* data ready */
     7b8:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     7bc:	83 e0 01             	and    eax,0x1
     7bf:	85 c0                	test   eax,eax
     7c1:	74 72                	je     835 <com_interrupt+0x1df>
						iprintf("COM%d data: \"", i);
     7c3:	83 ec 08             	sub    esp,0x8
     7c6:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     7c9:	68 4d 02 00 00       	push   0x24d
     7ce:	e8 fc ff ff ff       	call   7cf <com_interrupt+0x179>
     7d3:	83 c4 10             	add    esp,0x10
								char c = inb(port);
     7d6:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     7da:	83 ec 0c             	sub    esp,0xc
     7dd:	50                   	push   eax
     7de:	e8 5d f8 ff ff       	call   40 <inb>
     7e3:	83 c4 10             	add    esp,0x10
     7e6:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
								if (c == 3) { /* TODO: reimplement stub */
     7e9:	80 7d ef 03          	cmp    BYTE PTR [ebp-0x11],0x3
     7ed:	74 10                	je     7ff <com_interrupt+0x1a9>
										putchar(c);
     7ef:	0f be 45 ef          	movsx  eax,BYTE PTR [ebp-0x11]
     7f3:	83 ec 0c             	sub    esp,0xc
     7f6:	50                   	push   eax
     7f7:	e8 fc ff ff ff       	call   7f8 <com_interrupt+0x1a2>
     7fc:	83 c4 10             	add    esp,0x10
						} while (inb(port + 5) & 1);
     7ff:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     803:	83 c0 05             	add    eax,0x5
     806:	0f b7 c0             	movzx  eax,ax
     809:	83 ec 0c             	sub    esp,0xc
     80c:	50                   	push   eax
     80d:	e8 2e f8 ff ff       	call   40 <inb>
     812:	83 c4 10             	add    esp,0x10
     815:	0f b6 c0             	movzx  eax,al
     818:	83 e0 01             	and    eax,0x1
     81b:	85 c0                	test   eax,eax
     81d:	75 b7                	jne    7d6 <com_interrupt+0x180>
						iprintf("\"\n");
     81f:	83 ec 0c             	sub    esp,0xc
     822:	68 5b 02 00 00       	push   0x25b
     827:	e8 fc ff ff ff       	call   828 <com_interrupt+0x1d2>
     82c:	83 c4 10             	add    esp,0x10
     82f:	eb 04                	jmp    835 <com_interrupt+0x1df>
						continue;
     831:	90                   	nop
     832:	eb 01                	jmp    835 <com_interrupt+0x1df>
						continue;
     834:	90                   	nop
		for (int i = 0; i < 4; i++) {
     835:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     839:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
     83d:	0f 8e 25 fe ff ff    	jle    668 <com_interrupt+0x12>
}
     843:	90                   	nop
     844:	90                   	nop
     845:	c9                   	leave
     846:	c3                   	ret

00000847 <com_status>:
{
     847:	55                   	push   ebp
     848:	89 e5                	mov    ebp,esp
     84a:	83 ec 18             	sub    esp,0x18
		for (int i = 0; i < 4; i++)
     84d:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     854:	eb 51                	jmp    8a7 <com_status+0x60>
				if (com_ports[i]) {
     856:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     859:	0f b7 84 00 14 02 00 00 	movzx  eax,WORD PTR [eax+eax*1+0x214]
     861:	66 85 c0             	test   ax,ax
     864:	74 3d                	je     8a3 <com_status+0x5c>
						uint16_t port = com_ports[i];
     866:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     869:	0f b7 84 00 14 02 00 00 	movzx  eax,WORD PTR [eax+eax*1+0x214]
     871:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
						lsr = inb(port + 5);
     875:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
     879:	83 c0 05             	add    eax,0x5
     87c:	0f b7 c0             	movzx  eax,ax
     87f:	50                   	push   eax
     880:	e8 bb f7 ff ff       	call   40 <inb>
     885:	83 c4 04             	add    esp,0x4
     888:	88 45 f1             	mov    BYTE PTR [ebp-0xf],al
						printf("COM%d lsr: %08b\n", i, lsr);
     88b:	0f b6 45 f1          	movzx  eax,BYTE PTR [ebp-0xf]
     88f:	83 ec 04             	sub    esp,0x4
     892:	50                   	push   eax
     893:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     896:	68 5e 02 00 00       	push   0x25e
     89b:	e8 fc ff ff ff       	call   89c <com_status+0x55>
     8a0:	83 c4 10             	add    esp,0x10
		for (int i = 0; i < 4; i++)
     8a3:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     8a7:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
     8ab:	7e a9                	jle    856 <com_status+0xf>
}
     8ad:	90                   	nop
     8ae:	90                   	nop
     8af:	c9                   	leave
     8b0:	c3                   	ret

000008b1 <is_transit_empty>:
{
     8b1:	55                   	push   ebp
     8b2:	89 e5                	mov    ebp,esp
     8b4:	83 ec 04             	sub    esp,0x4
     8b7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8ba:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		return inb(port + 5) & 0x20;
     8be:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     8c2:	83 c0 05             	add    eax,0x5
     8c5:	0f b7 c0             	movzx  eax,ax
     8c8:	50                   	push   eax
     8c9:	e8 72 f7 ff ff       	call   40 <inb>
     8ce:	83 c4 04             	add    esp,0x4
     8d1:	0f b6 c0             	movzx  eax,al
     8d4:	83 e0 20             	and    eax,0x20
}
     8d7:	c9                   	leave
     8d8:	c3                   	ret

000008d9 <putDebugChar>:
{
     8d9:	55                   	push   ebp
     8da:	89 e5                	mov    ebp,esp
     8dc:	83 ec 04             	sub    esp,0x4
     8df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8e2:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		while (!is_transit_empty(def_port));
     8e5:	90                   	nop
     8e6:	0f b7 05 1c 02 00 00 	movzx  eax,WORD PTR ds:0x21c
     8ed:	0f b7 c0             	movzx  eax,ax
     8f0:	50                   	push   eax
     8f1:	e8 fc ff ff ff       	call   8f2 <putDebugChar+0x19>
     8f6:	83 c4 04             	add    esp,0x4
     8f9:	85 c0                	test   eax,eax
     8fb:	74 e9                	je     8e6 <putDebugChar+0xd>
		outb(def_port, c);
     8fd:	0f b6 45 fc          	movzx  eax,BYTE PTR [ebp-0x4]
     901:	0f b6 d0             	movzx  edx,al
     904:	0f b7 05 1c 02 00 00 	movzx  eax,WORD PTR ds:0x21c
     90b:	0f b7 c0             	movzx  eax,ax
     90e:	52                   	push   edx
     90f:	50                   	push   eax
     910:	e8 0c f7 ff ff       	call   21 <outb>
     915:	83 c4 08             	add    esp,0x8
}
     918:	90                   	nop
     919:	c9                   	leave
     91a:	c3                   	ret

0000091b <serial_received>:
{
     91b:	55                   	push   ebp
     91c:	89 e5                	mov    ebp,esp
     91e:	83 ec 04             	sub    esp,0x4
     921:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     924:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		return inb(port + 5) & 1;
     928:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
     92c:	83 c0 05             	add    eax,0x5
     92f:	0f b7 c0             	movzx  eax,ax
     932:	50                   	push   eax
     933:	e8 08 f7 ff ff       	call   40 <inb>
     938:	83 c4 04             	add    esp,0x4
     93b:	0f b6 c0             	movzx  eax,al
     93e:	83 e0 01             	and    eax,0x1
}
     941:	c9                   	leave
     942:	c3                   	ret

00000943 <getDebugChar>:
{
     943:	55                   	push   ebp
     944:	89 e5                	mov    ebp,esp
		while (!serial_received(def_port));
     946:	90                   	nop
     947:	0f b7 05 1c 02 00 00 	movzx  eax,WORD PTR ds:0x21c
     94e:	0f b7 c0             	movzx  eax,ax
     951:	50                   	push   eax
     952:	e8 fc ff ff ff       	call   953 <getDebugChar+0x10>
     957:	83 c4 04             	add    esp,0x4
     95a:	85 c0                	test   eax,eax
     95c:	74 e9                	je     947 <getDebugChar+0x4>
		return inb(def_port);
     95e:	0f b7 05 1c 02 00 00 	movzx  eax,WORD PTR ds:0x21c
     965:	0f b7 c0             	movzx  eax,ax
     968:	50                   	push   eax
     969:	e8 d2 f6 ff ff       	call   40 <inb>
     96e:	83 c4 04             	add    esp,0x4
}
     971:	c9                   	leave
     972:	c3                   	ret

00000973 <forward_irq>:
{
     973:	55                   	push   ebp
     974:	89 e5                	mov    ebp,esp
     976:	83 ec 18             	sub    esp,0x18
		if (!irq || irq > 15)
     979:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     97d:	74 42                	je     9c1 <forward_irq+0x4e>
     97f:	83 7d 08 0f          	cmp    DWORD PTR [ebp+0x8],0xf
     983:	77 3c                	ja     9c1 <forward_irq+0x4e>
		pt = irq_funs[--irq]; /* 1 based */
     985:	83 6d 08 01          	sub    DWORD PTR [ebp+0x8],0x1
     989:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     98c:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     993:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (pt) {
     996:	eb 21                	jmp    9b9 <forward_irq+0x46>
				if (pt->fun(irq + 1)) /* handled */
     998:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     99b:	8b 00                	mov    eax,DWORD PTR [eax]
     99d:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     9a0:	83 c2 01             	add    edx,0x1
     9a3:	83 ec 0c             	sub    esp,0xc
     9a6:	52                   	push   edx
     9a7:	ff d0                	call   eax
     9a9:	83 c4 10             	add    esp,0x10
     9ac:	85 c0                	test   eax,eax
     9ae:	75 14                	jne    9c4 <forward_irq+0x51>
				pt = pt->next;
     9b0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9b3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     9b6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (pt) {
     9b9:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     9bd:	75 d9                	jne    998 <forward_irq+0x25>
     9bf:	eb 04                	jmp    9c5 <forward_irq+0x52>
				return;
     9c1:	90                   	nop
     9c2:	eb 01                	jmp    9c5 <forward_irq+0x52>
						break;
     9c4:	90                   	nop
}
     9c5:	c9                   	leave
     9c6:	c3                   	ret

000009c7 <install_irq_handler>:
{
     9c7:	55                   	push   ebp
     9c8:	89 e5                	mov    ebp,esp
     9ca:	53                   	push   ebx
     9cb:	83 ec 14             	sub    esp,0x14
		if (!irq || irq > 15)
     9ce:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     9d2:	74 06                	je     9da <install_irq_handler+0x13>
     9d4:	83 7d 08 0f          	cmp    DWORD PTR [ebp+0x8],0xf
     9d8:	76 0a                	jbe    9e4 <install_irq_handler+0x1d>
				return 0;
     9da:	b8 00 00 00 00       	mov    eax,0x0
     9df:	e9 8a 00 00 00       	jmp    a6e <install_irq_handler+0xa7>
		struct irqe* p = kmalloc(sizeof(*p));
     9e4:	83 ec 0c             	sub    esp,0xc
     9e7:	6a 08                	push   0x8
     9e9:	e8 fc ff ff ff       	call   9ea <install_irq_handler+0x23>
     9ee:	83 c4 10             	add    esp,0x10
     9f1:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!p)
     9f4:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     9f8:	75 07                	jne    a01 <install_irq_handler+0x3a>
				return 0;
     9fa:	b8 00 00 00 00       	mov    eax,0x0
     9ff:	eb 6d                	jmp    a6e <install_irq_handler+0xa7>
		p->fun = fun;
     a01:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a04:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     a07:	89 10                	mov    DWORD PTR [eax],edx
		if (!irq_funs[irq - 1])
     a09:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a0c:	83 e8 01             	sub    eax,0x1
     a0f:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     a16:	85 c0                	test   eax,eax
     a18:	75 12                	jne    a2c <install_irq_handler+0x65>
				irq_unmask(irq);
     a1a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a1d:	0f b6 c0             	movzx  eax,al
     a20:	83 ec 0c             	sub    esp,0xc
     a23:	50                   	push   eax
     a24:	e8 fc ff ff ff       	call   a25 <install_irq_handler+0x5e>
     a29:	83 c4 10             	add    esp,0x10
				p->next = irq_funs[irq - 1];
     a2c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a2f:	83 e8 01             	sub    eax,0x1
     a32:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
     a39:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a3c:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		} while (!__sync_bool_compare_and_swap(&irq_funs[irq - 1], p->next, p));
     a3f:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     a42:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a45:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a48:	89 c3                	mov    ebx,eax
     a4a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a4d:	83 e8 01             	sub    eax,0x1
     a50:	c1 e0 02             	shl    eax,0x2
     a53:	8d 88 00 00 00 00    	lea    ecx,[eax+0x0]
     a59:	89 d8                	mov    eax,ebx
     a5b:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     a5f:	0f 94 c0             	sete   al
     a62:	83 f0 01             	xor    eax,0x1
     a65:	84 c0                	test   al,al
     a67:	75 c3                	jne    a2c <install_irq_handler+0x65>
		return 1;
     a69:	b8 01 00 00 00       	mov    eax,0x1
}
     a6e:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     a71:	c9                   	leave
     a72:	c3                   	ret

00000a73 <remove_irq_handler>:
{
     a73:	55                   	push   ebp
     a74:	89 e5                	mov    ebp,esp
     a76:	83 ec 18             	sub    esp,0x18
		struct irqe* pt, *prev = NULL;
     a79:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		if (!irq || irq > 15)
     a80:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     a84:	74 09                	je     a8f <remove_irq_handler+0x1c>
     a86:	83 7d 08 0f          	cmp    DWORD PTR [ebp+0x8],0xf
     a8a:	77 03                	ja     a8f <remove_irq_handler+0x1c>
start:
     a8c:	90                   	nop
     a8d:	eb 0b                	jmp    a9a <remove_irq_handler+0x27>
				return 0;
     a8f:	b8 00 00 00 00       	mov    eax,0x0
     a94:	e9 9f 00 00 00       	jmp    b38 <remove_irq_handler+0xc5>
										goto start;
     a99:	90                   	nop
		pt = irq_funs[irq - 1];
     a9a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a9d:	83 e8 01             	sub    eax,0x1
     aa0:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     aa7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (pt) {
     aaa:	eb 7d                	jmp    b29 <remove_irq_handler+0xb6>
				if (pt->fun == fun) {
     aac:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     aaf:	8b 00                	mov    eax,DWORD PTR [eax]
     ab1:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
     ab4:	75 64                	jne    b1a <remove_irq_handler+0xa7>
						if (prev) {
     ab6:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     aba:	74 21                	je     add <remove_irq_handler+0x6a>
														pt, pt->next))
     abc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     abf:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								if (!__sync_bool_compare_and_swap(&prev->next,
     ac2:	89 c1                	mov    ecx,eax
     ac4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ac7:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     aca:	83 c2 04             	add    edx,0x4
     acd:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     ad1:	0f 94 c0             	sete   al
     ad4:	83 f0 01             	xor    eax,0x1
     ad7:	84 c0                	test   al,al
     ad9:	74 2a                	je     b05 <remove_irq_handler+0x92>
										goto start;
     adb:	eb bd                	jmp    a9a <remove_irq_handler+0x27>
														pt, pt->next))
     add:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ae0:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								if (!__sync_bool_compare_and_swap(&irq_funs[irq - 1],
     ae3:	89 c1                	mov    ecx,eax
     ae5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ae8:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     aeb:	83 ea 01             	sub    edx,0x1
     aee:	c1 e2 02             	shl    edx,0x2
     af1:	81 c2 00 00 00 00    	add    edx,0x0
     af7:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     afb:	0f 94 c0             	sete   al
     afe:	83 f0 01             	xor    eax,0x1
     b01:	84 c0                	test   al,al
     b03:	75 94                	jne    a99 <remove_irq_handler+0x26>
						kfree(pt);
     b05:	83 ec 0c             	sub    esp,0xc
     b08:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     b0b:	e8 fc ff ff ff       	call   b0c <remove_irq_handler+0x99>
     b10:	83 c4 10             	add    esp,0x10
						return 1;
     b13:	b8 01 00 00 00       	mov    eax,0x1
     b18:	eb 1e                	jmp    b38 <remove_irq_handler+0xc5>
				prev = pt;
     b1a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b1d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				pt = pt->next;
     b20:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b23:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     b26:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (pt) {
     b29:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     b2d:	0f 85 79 ff ff ff    	jne    aac <remove_irq_handler+0x39>
		return 0;
     b33:	b8 00 00 00 00       	mov    eax,0x0
}
     b38:	c9                   	leave
     b39:	c3                   	ret

00000b3a <msi_handler>:
{
     b3a:	55                   	push   ebp
     b3b:	89 e5                	mov    ebp,esp
     b3d:	83 ec 08             	sub    esp,0x8
		iprintf("MSI %u received on processor %u\n", msi, smp_processor_id());
     b40:	e8 bb f4 ff ff       	call   0 <per_cpu_ptr>
     b45:	8b 00                	mov    eax,DWORD PTR [eax]
     b47:	83 ec 04             	sub    esp,0x4
     b4a:	50                   	push   eax
     b4b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     b4e:	68 70 02 00 00       	push   0x270
     b53:	e8 fc ff ff ff       	call   b54 <msi_handler+0x1a>
     b58:	83 c4 10             	add    esp,0x10
}
     b5b:	90                   	nop
     b5c:	c9                   	leave
     b5d:	c3                   	ret

00000b5e <irq_handler>:
{
     b5e:	55                   	push   ebp
     b5f:	89 e5                	mov    ebp,esp
     b61:	83 ec 18             	sub    esp,0x18
		int spurious = 0; void (*hook)();
     b64:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		if (irq >= 8) { /* check if intr from I/O APIC */
     b6b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b6e:	83 f8 07             	cmp    eax,0x7
     b71:	76 5b                	jbe    bce <irq_handler+0x70>
				isr = pic_get_isr();
     b73:	e8 fc ff ff ff       	call   b74 <irq_handler+0x16>
     b78:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
				if (!isr) { /* we have a PCI interrupt */
     b7c:	66 83 7d f2 00       	cmp    WORD PTR [ebp-0xe],0x0
     b81:	75 4b                	jne    bce <irq_handler+0x70>
						iprintf("PCI IRQ %u\n", irq);
     b83:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b86:	83 ec 08             	sub    esp,0x8
     b89:	50                   	push   eax
     b8a:	68 91 02 00 00       	push   0x291
     b8f:	e8 fc ff ff ff       	call   b90 <irq_handler+0x32>
     b94:	83 c4 10             	add    esp,0x10
						framebuffer_redraw(&fb_initial);
     b97:	83 ec 0c             	sub    esp,0xc
     b9a:	68 00 00 00 00       	push   0x0
     b9f:	e8 fc ff ff ff       	call   ba0 <irq_handler+0x42>
     ba4:	83 c4 10             	add    esp,0x10
						forward_irq(irq);
     ba7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     baa:	83 ec 0c             	sub    esp,0xc
     bad:	50                   	push   eax
     bae:	e8 fc ff ff ff       	call   baf <irq_handler+0x51>
     bb3:	83 c4 10             	add    esp,0x10
						apic_reg(APIC_REG_EOI) = 0;
     bb6:	e8 45 f4 ff ff       	call   0 <per_cpu_ptr>
     bbb:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     bbe:	05 b0 00 00 00       	add    eax,0xb0
     bc3:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						return; /* don't signal the PIC */
     bc9:	e9 f0 00 00 00       	jmp    cbe <irq_handler+0x160>
		switch (irq) {
     bce:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bd1:	83 f8 0f             	cmp    eax,0xf
     bd4:	77 70                	ja     c46 <irq_handler+0xe8>
     bd6:	8b 04 85 a0 02 00 00 	mov    eax,DWORD PTR [eax*4+0x2a0]
     bdd:	ff e0                	jmp    eax
					if ((hook = irq0_hook))
     bdf:	a1 00 00 00 00       	mov    eax,ds:0x0
     be4:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     be7:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     beb:	74 05                	je     bf2 <irq_handler+0x94>
							hook();
     bed:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     bf0:	ff d0                	call   eax
					ktimer_tick();
     bf2:	e8 fc ff ff ff       	call   bf3 <irq_handler+0x95>
					break;
     bf7:	eb 54                	jmp    c4d <irq_handler+0xef>
					kbd_handler();
     bf9:	e8 fc ff ff ff       	call   bfa <irq_handler+0x9c>
					break;
     bfe:	eb 4d                	jmp    c4d <irq_handler+0xef>
					com_interrupt(irq);
     c00:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c03:	83 ec 0c             	sub    esp,0xc
     c06:	50                   	push   eax
     c07:	e8 fc ff ff ff       	call   c08 <irq_handler+0xaa>
     c0c:	83 c4 10             	add    esp,0x10
					break;
     c0f:	eb 3c                	jmp    c4d <irq_handler+0xef>
					if (!(pic_get_isr() & (1 << 7)))
     c11:	e8 fc ff ff ff       	call   c12 <irq_handler+0xb4>
     c16:	0f b7 c0             	movzx  eax,ax
     c19:	25 80 00 00 00       	and    eax,0x80
     c1e:	85 c0                	test   eax,eax
     c20:	75 27                	jne    c49 <irq_handler+0xeb>
							spurious = 1;
     c22:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
					break;
     c29:	eb 1e                	jmp    c49 <irq_handler+0xeb>
					if (irq == 15 && !(pic_get_isr() & (1 << 15)))
     c2b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c2e:	83 f8 0f             	cmp    eax,0xf
     c31:	75 19                	jne    c4c <irq_handler+0xee>
     c33:	e8 fc ff ff ff       	call   c34 <irq_handler+0xd6>
     c38:	66 85 c0             	test   ax,ax
     c3b:	78 0f                	js     c4c <irq_handler+0xee>
							spurious = 1;
     c3d:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
					break;
     c44:	eb 06                	jmp    c4c <irq_handler+0xee>
					break;
     c46:	90                   	nop
     c47:	eb 04                	jmp    c4d <irq_handler+0xef>
					break;
     c49:	90                   	nop
     c4a:	eb 01                	jmp    c4d <irq_handler+0xef>
					break;
     c4c:	90                   	nop
		if(!spurious && irq > 7) /* ack to slave if needed */
     c4d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     c51:	75 1a                	jne    c6d <irq_handler+0x10f>
     c53:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c56:	83 f8 07             	cmp    eax,0x7
     c59:	76 12                	jbe    c6d <irq_handler+0x10f>
				outb(PIC2, 0x20);
     c5b:	83 ec 08             	sub    esp,0x8
     c5e:	6a 20                	push   0x20
     c60:	68 a0 00 00 00       	push   0xa0
     c65:	e8 b7 f3 ff ff       	call   21 <outb>
     c6a:	83 c4 10             	add    esp,0x10
		if (!spurious || irq > 7)
     c6d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     c71:	74 08                	je     c7b <irq_handler+0x11d>
     c73:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c76:	83 f8 07             	cmp    eax,0x7
     c79:	76 0f                	jbe    c8a <irq_handler+0x12c>
				outb(PIC1, 0x20); /* ack interrupt (even sp. from slave) */
     c7b:	83 ec 08             	sub    esp,0x8
     c7e:	6a 20                	push   0x20
     c80:	6a 20                	push   0x20
     c82:	e8 9a f3 ff ff       	call   21 <outb>
     c87:	83 c4 10             	add    esp,0x10
		if (!spurious && irq)
     c8a:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     c8e:	75 16                	jne    ca6 <irq_handler+0x148>
     c90:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c93:	85 c0                	test   eax,eax
     c95:	74 0f                	je     ca6 <irq_handler+0x148>
				forward_irq(irq);
     c97:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c9a:	83 ec 0c             	sub    esp,0xc
     c9d:	50                   	push   eax
     c9e:	e8 fc ff ff ff       	call   c9f <irq_handler+0x141>
     ca3:	83 c4 10             	add    esp,0x10
		if (!irq)
     ca6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ca9:	85 c0                	test   eax,eax
     cab:	75 11                	jne    cbe <irq_handler+0x160>
				task_schedule_isr(*(void**)(&irq + 1));
     cad:	8d 45 0c             	lea    eax,[ebp+0xc]
     cb0:	8b 00                	mov    eax,DWORD PTR [eax]
     cb2:	83 ec 0c             	sub    esp,0xc
     cb5:	50                   	push   eax
     cb6:	e8 fc ff ff ff       	call   cb7 <irq_handler+0x159>
     cbb:	83 c4 10             	add    esp,0x10
}
     cbe:	c9                   	leave
     cbf:	c3                   	ret

00000cc0 <nmi_handler>:
{
     cc0:	55                   	push   ebp
     cc1:	89 e5                	mov    ebp,esp
     cc3:	83 ec 28             	sub    esp,0x28
     cc6:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     cc9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ccc:	88 55 e4             	mov    BYTE PTR [ebp-0x1c],dl
     ccf:	88 45 e0             	mov    BYTE PTR [ebp-0x20],al
		if (port_a & 0x10) {
     cd2:	0f b6 45 e0          	movzx  eax,BYTE PTR [ebp-0x20]
     cd6:	83 e0 10             	and    eax,0x10
     cd9:	85 c0                	test   eax,eax
     cdb:	74 1a                	je     cf7 <nmi_handler+0x37>
				printf("NMI watchdog received\n");
     cdd:	83 ec 0c             	sub    esp,0xc
     ce0:	68 e0 02 00 00       	push   0x2e0
     ce5:	e8 fc ff ff ff       	call   ce6 <nmi_handler+0x26>
     cea:	83 c4 10             	add    esp,0x10
				return 0;
     ced:	b8 00 00 00 00       	mov    eax,0x0
     cf2:	e9 a9 00 00 00       	jmp    da0 <nmi_handler+0xe0>
		if (port_b & 0x40)
     cf7:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
     cfb:	83 e0 40             	and    eax,0x40
     cfe:	85 c0                	test   eax,eax
     d00:	74 12                	je     d14 <nmi_handler+0x54>
				printf("Hardware bus channel error\n");
     d02:	83 ec 0c             	sub    esp,0xc
     d05:	68 f7 02 00 00       	push   0x2f7
     d0a:	e8 fc ff ff ff       	call   d0b <nmi_handler+0x4b>
     d0f:	83 c4 10             	add    esp,0x10
     d12:	eb 34                	jmp    d48 <nmi_handler+0x88>
		else if (port_b & 0x80)
     d14:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
     d18:	84 c0                	test   al,al
     d1a:	79 12                	jns    d2e <nmi_handler+0x6e>
				printf("Memory read/write error\n");
     d1c:	83 ec 0c             	sub    esp,0xc
     d1f:	68 13 03 00 00       	push   0x313
     d24:	e8 fc ff ff ff       	call   d25 <nmi_handler+0x65>
     d29:	83 c4 10             	add    esp,0x10
     d2c:	eb 1a                	jmp    d48 <nmi_handler+0x88>
				printf("Unknown NMI error A=%x, B=%x\n", port_a, port_b);
     d2e:	0f b6 55 e4          	movzx  edx,BYTE PTR [ebp-0x1c]
     d32:	0f b6 45 e0          	movzx  eax,BYTE PTR [ebp-0x20]
     d36:	83 ec 04             	sub    esp,0x4
     d39:	52                   	push   edx
     d3a:	50                   	push   eax
     d3b:	68 2c 03 00 00       	push   0x32c
     d40:	e8 fc ff ff ff       	call   d41 <nmi_handler+0x81>
     d45:	83 c4 10             	add    esp,0x10
		puts("restarting");
     d48:	83 ec 0c             	sub    esp,0xc
     d4b:	68 4a 03 00 00       	push   0x34a
     d50:	e8 fc ff ff ff       	call   d51 <nmi_handler+0x91>
     d55:	83 c4 10             	add    esp,0x10
		for (i = 0; i < 3; i++) {
     d58:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     d5f:	eb 27                	jmp    d88 <nmi_handler+0xc8>
				for (j = 0; j < INT_MAX; j++);
     d61:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     d68:	eb 04                	jmp    d6e <nmi_handler+0xae>
     d6a:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     d6e:	81 7d f0 ff ff ff 7f 	cmp    DWORD PTR [ebp-0x10],0x7fffffff
     d75:	75 f3                	jne    d6a <nmi_handler+0xaa>
				putchar('.');
     d77:	83 ec 0c             	sub    esp,0xc
     d7a:	6a 2e                	push   0x2e
     d7c:	e8 fc ff ff ff       	call   d7d <nmi_handler+0xbd>
     d81:	83 c4 10             	add    esp,0x10
		for (i = 0; i < 3; i++) {
     d84:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     d88:	83 7d f4 02          	cmp    DWORD PTR [ebp-0xc],0x2
     d8c:	7e d3                	jle    d61 <nmi_handler+0xa1>
		putchar('\n');
     d8e:	83 ec 0c             	sub    esp,0xc
     d91:	6a 0a                	push   0xa
     d93:	e8 fc ff ff ff       	call   d94 <nmi_handler+0xd4>
     d98:	83 c4 10             	add    esp,0x10
		return 1;
     d9b:	b8 01 00 00 00       	mov    eax,0x1
}
     da0:	c9                   	leave
     da1:	c3                   	ret

00000da2 <segment_handler>:
{
     da2:	55                   	push   ebp
     da3:	89 e5                	mov    ebp,esp
     da5:	83 ec 18             	sub    esp,0x18
		const char* tp = "#UNKNOWN";
     da8:	c7 45 f4 55 03 00 00 	mov    DWORD PTR [ebp-0xc],0x355
		switch(type) {
     daf:	83 7d 14 04          	cmp    DWORD PTR [ebp+0x14],0x4
     db3:	77 3b                	ja     df0 <segment_handler+0x4e>
     db5:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     db8:	c1 e0 02             	shl    eax,0x2
     dbb:	05 50 04 00 00       	add    eax,0x450
     dc0:	8b 00                	mov    eax,DWORD PTR [eax]
     dc2:	ff e0                	jmp    eax
				case 0: tp = "#TS"; break;
     dc4:	c7 45 f4 5e 03 00 00 	mov    DWORD PTR [ebp-0xc],0x35e
     dcb:	eb 23                	jmp    df0 <segment_handler+0x4e>
				case 1: tp = "#NP"; break;
     dcd:	c7 45 f4 62 03 00 00 	mov    DWORD PTR [ebp-0xc],0x362
     dd4:	eb 1a                	jmp    df0 <segment_handler+0x4e>
				case 2: tp = "#SS"; break;
     dd6:	c7 45 f4 66 03 00 00 	mov    DWORD PTR [ebp-0xc],0x366
     ddd:	eb 11                	jmp    df0 <segment_handler+0x4e>
				case 3: tp = "#GP"; break;
     ddf:	c7 45 f4 6a 03 00 00 	mov    DWORD PTR [ebp-0xc],0x36a
     de6:	eb 08                	jmp    df0 <segment_handler+0x4e>
				case 4: tp = "#PF"; break;
     de8:	c7 45 f4 6e 03 00 00 	mov    DWORD PTR [ebp-0xc],0x36e
     def:	90                   	nop
		if (type == 4) {
     df0:	83 7d 14 04          	cmp    DWORD PTR [ebp+0x14],0x4
     df4:	75 1e                	jne    e14 <segment_handler+0x72>
				if(mm_handle_pagefault(&mm_kernel, eip, seg_error, cr2) == 0)
     df6:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     df9:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     dfc:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     dff:	68 00 00 00 00       	push   0x0
     e04:	e8 fc ff ff ff       	call   e05 <segment_handler+0x63>
     e09:	83 c4 10             	add    esp,0x10
     e0c:	85 c0                	test   eax,eax
     e0e:	0f 84 dd 00 00 00    	je     ef1 <segment_handler+0x14f>
		cprintf(KFMT_INFO, "Segment exception handler: %s at %p with error %x (cr2=%p)\n",
     e14:	83 ec 08             	sub    esp,0x8
     e17:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     e1a:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     e1d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     e20:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     e23:	68 74 03 00 00       	push   0x374
     e28:	6a 0b                	push   0xb
     e2a:	e8 fc ff ff ff       	call   e2b <segment_handler+0x89>
     e2f:	83 c4 20             	add    esp,0x20
		if (seg_error != 4) {
     e32:	83 7d 0c 04          	cmp    DWORD PTR [ebp+0xc],0x4
     e36:	0f 84 8a 00 00 00    	je     ec6 <segment_handler+0x124>
					  (seg_error & 0xffff8) >> 3);
     e3c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e3f:	c1 e8 03             	shr    eax,0x3
				printf("The segment error originated %s and"
     e42:	25 ff ff 01 00       	and    eax,0x1ffff
     e47:	89 c2                	mov    edx,eax
						(seg_error & 2) ? "interrupt" : ((seg_error & 4) ? "local" : "global"),
     e49:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e4c:	83 e0 02             	and    eax,0x2
				printf("The segment error originated %s and"
     e4f:	85 c0                	test   eax,eax
     e51:	75 18                	jne    e6b <segment_handler+0xc9>
						(seg_error & 2) ? "interrupt" : ((seg_error & 4) ? "local" : "global"),
     e53:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e56:	83 e0 04             	and    eax,0x4
     e59:	85 c0                	test   eax,eax
     e5b:	74 07                	je     e64 <segment_handler+0xc2>
     e5d:	b8 b0 03 00 00       	mov    eax,0x3b0
     e62:	eb 0c                	jmp    e70 <segment_handler+0xce>
     e64:	b8 b6 03 00 00       	mov    eax,0x3b6
     e69:	eb 05                	jmp    e70 <segment_handler+0xce>
				printf("The segment error originated %s and"
     e6b:	b8 bd 03 00 00       	mov    eax,0x3bd
						(seg_error & 1) ? "external" : "internal",
     e70:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
     e73:	83 e1 01             	and    ecx,0x1
				printf("The segment error originated %s and"
     e76:	85 c9                	test   ecx,ecx
     e78:	74 07                	je     e81 <segment_handler+0xdf>
     e7a:	b9 c7 03 00 00       	mov    ecx,0x3c7
     e7f:	eb 05                	jmp    e86 <segment_handler+0xe4>
     e81:	b9 d0 03 00 00       	mov    ecx,0x3d0
     e86:	52                   	push   edx
     e87:	50                   	push   eax
     e88:	51                   	push   ecx
     e89:	68 dc 03 00 00       	push   0x3dc
     e8e:	e8 fc ff ff ff       	call   e8f <segment_handler+0xed>
     e93:	83 c4 10             	add    esp,0x10
				print_stacktrace();
     e96:	e8 fc ff ff ff       	call   e97 <segment_handler+0xf5>
				die("segment death\n");
     e9b:	83 ec 08             	sub    esp,0x8
     e9e:	68 32 04 00 00       	push   0x432
     ea3:	6a 0c                	push   0xc
     ea5:	e8 fc ff ff ff       	call   ea6 <segment_handler+0x104>
     eaa:	83 c4 10             	add    esp,0x10
     ead:	e8 fc ff ff ff       	call   eae <segment_handler+0x10c>
     eb2:	83 ec 0c             	sub    esp,0xc
     eb5:	68 00 00 00 00       	push   0x0
     eba:	e8 fc ff ff ff       	call   ebb <segment_handler+0x119>
     ebf:	83 c4 10             	add    esp,0x10
     ec2:	fa                   	cli
     ec3:	f4                   	hlt
     ec4:	eb fd                	jmp    ec3 <segment_handler+0x121>
				die("unfixable #PF\n");
     ec6:	83 ec 08             	sub    esp,0x8
     ec9:	68 41 04 00 00       	push   0x441
     ece:	6a 0c                	push   0xc
     ed0:	e8 fc ff ff ff       	call   ed1 <segment_handler+0x12f>
     ed5:	83 c4 10             	add    esp,0x10
     ed8:	e8 fc ff ff ff       	call   ed9 <segment_handler+0x137>
     edd:	83 ec 0c             	sub    esp,0xc
     ee0:	68 00 00 00 00       	push   0x0
     ee5:	e8 fc ff ff ff       	call   ee6 <segment_handler+0x144>
     eea:	83 c4 10             	add    esp,0x10
     eed:	fa                   	cli
     eee:	f4                   	hlt
     eef:	eb fd                	jmp    eee <segment_handler+0x14c>
						return; /* continue execution */
     ef1:	90                   	nop
}
     ef2:	c9                   	leave
     ef3:	c3                   	ret

00000ef4 <PIC_remap>:
{
     ef4:	55                   	push   ebp
     ef5:	89 e5                	mov    ebp,esp
     ef7:	53                   	push   ebx
     ef8:	83 ec 24             	sub    esp,0x24
     efb:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     efe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     f01:	88 55 e4             	mov    BYTE PTR [ebp-0x1c],dl
     f04:	88 45 e0             	mov    BYTE PTR [ebp-0x20],al
		a1 = inb(PIC1_DATA);                      /* save the masks */
     f07:	6a 21                	push   0x21
     f09:	e8 32 f1 ff ff       	call   40 <inb>
     f0e:	83 c4 04             	add    esp,0x4
     f11:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		a2 = inb(PIC2_DATA);
     f14:	68 a1 00 00 00       	push   0xa1
     f19:	e8 22 f1 ff ff       	call   40 <inb>
     f1e:	83 c4 04             	add    esp,0x4
     f21:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
		outb(PIC1_COMMAND, ICW1_INIT+ICW1_ICW4);  /* start the initialization */
     f24:	6a 11                	push   0x11
     f26:	6a 20                	push   0x20
     f28:	e8 f4 f0 ff ff       	call   21 <outb>
     f2d:	83 c4 08             	add    esp,0x8
		io_wait();                                /* expects 3 control bytes */
     f30:	e8 df f0 ff ff       	call   14 <io_wait>
		outb(PIC2_COMMAND, ICW1_INIT+ICW1_ICW4);
     f35:	6a 11                	push   0x11
     f37:	68 a0 00 00 00       	push   0xa0
     f3c:	e8 e0 f0 ff ff       	call   21 <outb>
     f41:	83 c4 08             	add    esp,0x8
		io_wait();
     f44:	e8 cb f0 ff ff       	call   14 <io_wait>
		outb(PIC1_DATA, ofs1);                    /* master gate offset */
     f49:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
     f4d:	50                   	push   eax
     f4e:	6a 21                	push   0x21
     f50:	e8 cc f0 ff ff       	call   21 <outb>
     f55:	83 c4 08             	add    esp,0x8
		io_wait();
     f58:	e8 b7 f0 ff ff       	call   14 <io_wait>
		outb(PIC2_DATA, ofs2);                    /* slave gate offset */
     f5d:	0f b6 45 e0          	movzx  eax,BYTE PTR [ebp-0x20]
     f61:	50                   	push   eax
     f62:	68 a1 00 00 00       	push   0xa1
     f67:	e8 b5 f0 ff ff       	call   21 <outb>
     f6c:	83 c4 08             	add    esp,0x8
		io_wait();
     f6f:	e8 a0 f0 ff ff       	call   14 <io_wait>
		outb(PIC1_DATA, 4);                       /* tell master of the presence */
     f74:	6a 04                	push   0x4
     f76:	6a 21                	push   0x21
     f78:	e8 a4 f0 ff ff       	call   21 <outb>
     f7d:	83 c4 08             	add    esp,0x8
		io_wait();                                /* of slave at IRQ2 (1<<2) */
     f80:	e8 8f f0 ff ff       	call   14 <io_wait>
		outb(PIC2_DATA, 2);                       /* tell slave it's second */
     f85:	6a 02                	push   0x2
     f87:	68 a1 00 00 00       	push   0xa1
     f8c:	e8 90 f0 ff ff       	call   21 <outb>
     f91:	83 c4 08             	add    esp,0x8
		io_wait();                                /* in cascade */
     f94:	e8 7b f0 ff ff       	call   14 <io_wait>
		outb(PIC1_DATA, ICW4_8086);               /* master in standard mode */
     f99:	6a 01                	push   0x1
     f9b:	6a 21                	push   0x21
     f9d:	e8 7f f0 ff ff       	call   21 <outb>
     fa2:	83 c4 08             	add    esp,0x8
		io_wait();
     fa5:	e8 6a f0 ff ff       	call   14 <io_wait>
		outb(PIC2_DATA, ICW4_8086);               /* slave in standard mode */
     faa:	6a 01                	push   0x1
     fac:	68 a1 00 00 00       	push   0xa1
     fb1:	e8 6b f0 ff ff       	call   21 <outb>
     fb6:	83 c4 08             	add    esp,0x8
		io_wait();
     fb9:	e8 56 f0 ff ff       	call   14 <io_wait>
		outb(PIC1_DATA, a1);                      /* restore saved masks */
     fbe:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
     fc2:	50                   	push   eax
     fc3:	6a 21                	push   0x21
     fc5:	e8 57 f0 ff ff       	call   21 <outb>
     fca:	83 c4 08             	add    esp,0x8
		outb(PIC2_DATA, a2);
     fcd:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
     fd1:	50                   	push   eax
     fd2:	68 a1 00 00 00       	push   0xa1
     fd7:	e8 45 f0 ff ff       	call   21 <outb>
     fdc:	83 c4 08             	add    esp,0x8
		cprintf(KFMT_INFO, "PICs remapped to %x and %x with masks %x and %x\n",
     fdf:	0f b6 5d f6          	movzx  ebx,BYTE PTR [ebp-0xa]
     fe3:	0f b6 4d f7          	movzx  ecx,BYTE PTR [ebp-0x9]
     fe7:	0f b6 55 e0          	movzx  edx,BYTE PTR [ebp-0x20]
     feb:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
     fef:	83 ec 08             	sub    esp,0x8
     ff2:	53                   	push   ebx
     ff3:	51                   	push   ecx
     ff4:	52                   	push   edx
     ff5:	50                   	push   eax
     ff6:	68 64 04 00 00       	push   0x464
     ffb:	6a 0b                	push   0xb
     ffd:	e8 fc ff ff ff       	call   ffe <PIC_remap+0x10a>
    1002:	83 c4 20             	add    esp,0x20
}
    1005:	90                   	nop
    1006:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1009:	c9                   	leave
    100a:	c3                   	ret

0000100b <cmos_is_updating>:
{
    100b:	55                   	push   ebp
    100c:	89 e5                	mov    ebp,esp
		outb(CMOS_CH_INDEX, 0x0a);
    100e:	6a 0a                	push   0xa
    1010:	6a 70                	push   0x70
    1012:	e8 0a f0 ff ff       	call   21 <outb>
    1017:	83 c4 08             	add    esp,0x8
		return inb(CMOS_CH_DATA) & 0x80;
    101a:	6a 71                	push   0x71
    101c:	e8 1f f0 ff ff       	call   40 <inb>
    1021:	83 c4 04             	add    esp,0x4
    1024:	0f b6 c0             	movzx  eax,al
    1027:	25 80 00 00 00       	and    eax,0x80
}
    102c:	c9                   	leave
    102d:	c3                   	ret

0000102e <cmos_get_register>:
{
    102e:	55                   	push   ebp
    102f:	89 e5                	mov    ebp,esp
    1031:	83 ec 04             	sub    esp,0x4
    1034:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1037:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		outb(CMOS_CH_INDEX, reg);
    103a:	0f b6 45 fc          	movzx  eax,BYTE PTR [ebp-0x4]
    103e:	50                   	push   eax
    103f:	6a 70                	push   0x70
    1041:	e8 db ef ff ff       	call   21 <outb>
    1046:	83 c4 08             	add    esp,0x8
		return inb(CMOS_CH_DATA);
    1049:	6a 71                	push   0x71
    104b:	e8 f0 ef ff ff       	call   40 <inb>
    1050:	83 c4 04             	add    esp,0x4
}
    1053:	c9                   	leave
    1054:	c3                   	ret

00001055 <cmos_get_time>:
{
    1055:	55                   	push   ebp
    1056:	89 e5                	mov    ebp,esp
    1058:	57                   	push   edi
    1059:	53                   	push   ebx
    105a:	83 ec 50             	sub    esp,0x50
		struct tm rv = {0}, rvb = {0};
    105d:	8d 55 cc             	lea    edx,[ebp-0x34]
    1060:	b8 00 00 00 00       	mov    eax,0x0
    1065:	b9 09 00 00 00       	mov    ecx,0x9
    106a:	89 d7                	mov    edi,edx
    106c:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    106e:	8d 55 a8             	lea    edx,[ebp-0x58]
    1071:	b8 00 00 00 00       	mov    eax,0x0
    1076:	b9 09 00 00 00       	mov    ecx,0x9
    107b:	89 d7                	mov    edi,edx
    107d:	f3 ab                	rep stos DWORD PTR es:[edi],eax
		struct tm* pt = &rv; uint8_t regB;
    107f:	8d 45 cc             	lea    eax,[ebp-0x34]
    1082:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				while (cmos_is_updating()); /* busy spin (maybe called by ihander */
    1085:	90                   	nop
    1086:	e8 fc ff ff ff       	call   1087 <cmos_get_time+0x32>
    108b:	85 c0                	test   eax,eax
    108d:	75 f7                	jne    1086 <cmos_get_time+0x31>
				pt->tm_sec = cmos_get_register(0);
    108f:	6a 00                	push   0x0
    1091:	e8 fc ff ff ff       	call   1092 <cmos_get_time+0x3d>
    1096:	83 c4 04             	add    esp,0x4
    1099:	0f b6 d0             	movzx  edx,al
    109c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    109f:	89 10                	mov    DWORD PTR [eax],edx
				pt->tm_min = cmos_get_register(2);
    10a1:	6a 02                	push   0x2
    10a3:	e8 fc ff ff ff       	call   10a4 <cmos_get_time+0x4f>
    10a8:	83 c4 04             	add    esp,0x4
    10ab:	0f b6 d0             	movzx  edx,al
    10ae:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10b1:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				pt->tm_hour = cmos_get_register(4);
    10b4:	6a 04                	push   0x4
    10b6:	e8 fc ff ff ff       	call   10b7 <cmos_get_time+0x62>
    10bb:	83 c4 04             	add    esp,0x4
    10be:	0f b6 d0             	movzx  edx,al
    10c1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10c4:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
				pt->tm_wday = cmos_get_register(6);// - 1;
    10c7:	6a 06                	push   0x6
    10c9:	e8 fc ff ff ff       	call   10ca <cmos_get_time+0x75>
    10ce:	83 c4 04             	add    esp,0x4
    10d1:	0f b6 d0             	movzx  edx,al
    10d4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10d7:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				pt->tm_mday = cmos_get_register(7);
    10da:	6a 07                	push   0x7
    10dc:	e8 fc ff ff ff       	call   10dd <cmos_get_time+0x88>
    10e1:	83 c4 04             	add    esp,0x4
    10e4:	0f b6 d0             	movzx  edx,al
    10e7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10ea:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
				pt->tm_mon = cmos_get_register(8);
    10ed:	6a 08                	push   0x8
    10ef:	e8 fc ff ff ff       	call   10f0 <cmos_get_time+0x9b>
    10f4:	83 c4 04             	add    esp,0x4
    10f7:	0f b6 d0             	movzx  edx,al
    10fa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10fd:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
				pt->tm_year = cmos_get_register(9);
    1100:	6a 09                	push   0x9
    1102:	e8 fc ff ff ff       	call   1103 <cmos_get_time+0xae>
    1107:	83 c4 04             	add    esp,0x4
    110a:	0f b6 d0             	movzx  edx,al
    110d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1110:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
				pt->tm_year |= (cmos_get_register(0x32) << 8); /* century or bogus data */
    1113:	6a 32                	push   0x32
    1115:	e8 fc ff ff ff       	call   1116 <cmos_get_time+0xc1>
    111a:	83 c4 04             	add    esp,0x4
    111d:	0f b6 c0             	movzx  eax,al
    1120:	c1 e0 08             	shl    eax,0x8
    1123:	89 c2                	mov    edx,eax
    1125:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1128:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    112b:	09 c2                	or     edx,eax
    112d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1130:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
				if (pt == &rv)
    1133:	8d 45 cc             	lea    eax,[ebp-0x34]
    1136:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    1139:	75 0b                	jne    1146 <cmos_get_time+0xf1>
						pt = &rvb;
    113b:	8d 45 a8             	lea    eax,[ebp-0x58]
    113e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1141:	e9 3f ff ff ff       	jmp    1085 <cmos_get_time+0x30>
				else if (rv.tm_sec != rvb.tm_sec ||
    1146:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1149:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    114c:	39 c2                	cmp    edx,eax
    114e:	75 3c                	jne    118c <cmos_get_time+0x137>
								rv.tm_min != rvb.tm_min ||
    1150:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    1153:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
				else if (rv.tm_sec != rvb.tm_sec ||
    1156:	39 c2                	cmp    edx,eax
    1158:	75 32                	jne    118c <cmos_get_time+0x137>
								rv.tm_hour != rvb.tm_hour ||
    115a:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    115d:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
								rv.tm_min != rvb.tm_min ||
    1160:	39 c2                	cmp    edx,eax
    1162:	75 28                	jne    118c <cmos_get_time+0x137>
								rv.tm_wday != rvb.tm_wday ||
    1164:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1167:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
								rv.tm_hour != rvb.tm_hour ||
    116a:	39 c2                	cmp    edx,eax
    116c:	75 1e                	jne    118c <cmos_get_time+0x137>
								rv.tm_mday != rvb.tm_mday ||
    116e:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    1171:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
								rv.tm_wday != rvb.tm_wday ||
    1174:	39 c2                	cmp    edx,eax
    1176:	75 14                	jne    118c <cmos_get_time+0x137>
								rv.tm_mon != rvb.tm_mon ||
    1178:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    117b:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
								rv.tm_mday != rvb.tm_mday ||
    117e:	39 c2                	cmp    edx,eax
    1180:	75 0a                	jne    118c <cmos_get_time+0x137>
								rv.tm_year != rvb.tm_year)
    1182:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    1185:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
								rv.tm_mon != rvb.tm_mon ||
    1188:	39 c2                	cmp    edx,eax
    118a:	74 0b                	je     1197 <cmos_get_time+0x142>
						pt = &rv;
    118c:	8d 45 cc             	lea    eax,[ebp-0x34]
    118f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				while (cmos_is_updating()); /* busy spin (maybe called by ihander */
    1192:	e9 ee fe ff ff       	jmp    1085 <cmos_get_time+0x30>
		regB = cmos_get_register(0x0b);
    1197:	6a 0b                	push   0xb
    1199:	e8 fc ff ff ff       	call   119a <cmos_get_time+0x145>
    119e:	83 c4 04             	add    esp,0x4
    11a1:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
		if (!(regB & 0x04)) {
    11a4:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
    11a8:	83 e0 04             	and    eax,0x4
    11ab:	85 c0                	test   eax,eax
    11ad:	0f 85 8a 01 00 00    	jne    133d <cmos_get_time+0x2e8>
				pt->tm_sec = (pt->tm_sec & 0xf) + ((pt->tm_sec / 16) * 10);
    11b3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11b6:	8b 00                	mov    eax,DWORD PTR [eax]
    11b8:	83 e0 0f             	and    eax,0xf
    11bb:	89 c1                	mov    ecx,eax
    11bd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11c0:	8b 00                	mov    eax,DWORD PTR [eax]
    11c2:	8d 50 0f             	lea    edx,[eax+0xf]
    11c5:	85 c0                	test   eax,eax
    11c7:	0f 48 c2             	cmovs  eax,edx
    11ca:	c1 f8 04             	sar    eax,0x4
    11cd:	89 c2                	mov    edx,eax
    11cf:	89 d0                	mov    eax,edx
    11d1:	c1 e0 02             	shl    eax,0x2
    11d4:	01 d0                	add    eax,edx
    11d6:	01 c0                	add    eax,eax
    11d8:	8d 14 01             	lea    edx,[ecx+eax*1]
    11db:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11de:	89 10                	mov    DWORD PTR [eax],edx
				pt->tm_min = (pt->tm_min & 0xf) + ((pt->tm_min / 16) * 10);
    11e0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11e3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    11e6:	83 e0 0f             	and    eax,0xf
    11e9:	89 c1                	mov    ecx,eax
    11eb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11ee:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    11f1:	8d 50 0f             	lea    edx,[eax+0xf]
    11f4:	85 c0                	test   eax,eax
    11f6:	0f 48 c2             	cmovs  eax,edx
    11f9:	c1 f8 04             	sar    eax,0x4
    11fc:	89 c2                	mov    edx,eax
    11fe:	89 d0                	mov    eax,edx
    1200:	c1 e0 02             	shl    eax,0x2
    1203:	01 d0                	add    eax,edx
    1205:	01 c0                	add    eax,eax
    1207:	8d 14 01             	lea    edx,[ecx+eax*1]
    120a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    120d:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				pt->tm_hour = (pt->tm_hour & 0x80) | ((pt->tm_hour & 0xf) + (((pt->tm_hour & 0x70) / 16) * 10));
    1210:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1213:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1216:	25 80 00 00 00       	and    eax,0x80
    121b:	89 c1                	mov    ecx,eax
    121d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1220:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1223:	83 e0 0f             	and    eax,0xf
    1226:	89 c3                	mov    ebx,eax
    1228:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    122b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    122e:	83 e0 70             	and    eax,0x70
    1231:	8d 50 0f             	lea    edx,[eax+0xf]
    1234:	85 c0                	test   eax,eax
    1236:	0f 48 c2             	cmovs  eax,edx
    1239:	c1 f8 04             	sar    eax,0x4
    123c:	89 c2                	mov    edx,eax
    123e:	89 d0                	mov    eax,edx
    1240:	c1 e0 02             	shl    eax,0x2
    1243:	01 d0                	add    eax,edx
    1245:	01 c0                	add    eax,eax
    1247:	01 d8                	add    eax,ebx
    1249:	09 c1                	or     ecx,eax
    124b:	89 ca                	mov    edx,ecx
    124d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1250:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
				pt->tm_wday = (pt->tm_wday & 0xf) + ((pt->tm_wday / 16) * 10);
    1253:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1256:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1259:	83 e0 0f             	and    eax,0xf
    125c:	89 c1                	mov    ecx,eax
    125e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1261:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1264:	8d 50 0f             	lea    edx,[eax+0xf]
    1267:	85 c0                	test   eax,eax
    1269:	0f 48 c2             	cmovs  eax,edx
    126c:	c1 f8 04             	sar    eax,0x4
    126f:	89 c2                	mov    edx,eax
    1271:	89 d0                	mov    eax,edx
    1273:	c1 e0 02             	shl    eax,0x2
    1276:	01 d0                	add    eax,edx
    1278:	01 c0                	add    eax,eax
    127a:	8d 14 01             	lea    edx,[ecx+eax*1]
    127d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1280:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				pt->tm_mday = (pt->tm_mday & 0xf) + ((pt->tm_mday / 16) * 10);
    1283:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1286:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1289:	83 e0 0f             	and    eax,0xf
    128c:	89 c1                	mov    ecx,eax
    128e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1291:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1294:	8d 50 0f             	lea    edx,[eax+0xf]
    1297:	85 c0                	test   eax,eax
    1299:	0f 48 c2             	cmovs  eax,edx
    129c:	c1 f8 04             	sar    eax,0x4
    129f:	89 c2                	mov    edx,eax
    12a1:	89 d0                	mov    eax,edx
    12a3:	c1 e0 02             	shl    eax,0x2
    12a6:	01 d0                	add    eax,edx
    12a8:	01 c0                	add    eax,eax
    12aa:	8d 14 01             	lea    edx,[ecx+eax*1]
    12ad:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12b0:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
				pt->tm_mon = (pt->tm_mon & 0xf) + ((pt->tm_mon / 16) * 10);
    12b3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12b6:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    12b9:	83 e0 0f             	and    eax,0xf
    12bc:	89 c1                	mov    ecx,eax
    12be:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12c1:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    12c4:	8d 50 0f             	lea    edx,[eax+0xf]
    12c7:	85 c0                	test   eax,eax
    12c9:	0f 48 c2             	cmovs  eax,edx
    12cc:	c1 f8 04             	sar    eax,0x4
    12cf:	89 c2                	mov    edx,eax
    12d1:	89 d0                	mov    eax,edx
    12d3:	c1 e0 02             	shl    eax,0x2
    12d6:	01 d0                	add    eax,edx
    12d8:	01 c0                	add    eax,eax
    12da:	8d 14 01             	lea    edx,[ecx+eax*1]
    12dd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12e0:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
				pt->tm_year = ((pt->tm_year & 0xf) + ((pt->tm_year / 16) * 10))
    12e3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12e6:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    12e9:	83 e0 0f             	and    eax,0xf
    12ec:	89 c1                	mov    ecx,eax
    12ee:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12f1:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    12f4:	8d 50 0f             	lea    edx,[eax+0xf]
    12f7:	85 c0                	test   eax,eax
    12f9:	0f 48 c2             	cmovs  eax,edx
    12fc:	c1 f8 04             	sar    eax,0x4
    12ff:	89 c2                	mov    edx,eax
    1301:	89 d0                	mov    eax,edx
    1303:	c1 e0 02             	shl    eax,0x2
    1306:	01 d0                	add    eax,edx
    1308:	01 c0                	add    eax,eax
    130a:	01 c1                	add    ecx,eax
						| ((((pt->tm_year & 0xf) >> 8) + ((((pt->tm_year & 0xf000) >> 8) / 16) * 10)) << 8);
    130c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    130f:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1312:	c1 f8 08             	sar    eax,0x8
    1315:	25 f0 00 00 00       	and    eax,0xf0
    131a:	8d 50 0f             	lea    edx,[eax+0xf]
    131d:	85 c0                	test   eax,eax
    131f:	0f 48 c2             	cmovs  eax,edx
    1322:	c1 f8 04             	sar    eax,0x4
    1325:	89 c2                	mov    edx,eax
    1327:	89 d0                	mov    eax,edx
    1329:	c1 e0 02             	shl    eax,0x2
    132c:	01 d0                	add    eax,edx
    132e:	01 c0                	add    eax,eax
    1330:	c1 e0 08             	shl    eax,0x8
    1333:	09 c1                	or     ecx,eax
    1335:	89 ca                	mov    edx,ecx
				pt->tm_year = ((pt->tm_year & 0xf) + ((pt->tm_year / 16) * 10))
    1337:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    133a:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		if (!(regB & 0x02) && (pt->tm_hour & 0x80))
    133d:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
    1341:	83 e0 02             	and    eax,0x2
    1344:	85 c0                	test   eax,eax
    1346:	75 41                	jne    1389 <cmos_get_time+0x334>
    1348:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    134b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    134e:	25 80 00 00 00       	and    eax,0x80
    1353:	85 c0                	test   eax,eax
    1355:	74 32                	je     1389 <cmos_get_time+0x334>
				pt->tm_hour = (((pt->tm_hour & 0x7f) + 12) % 24);
    1357:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    135a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    135d:	83 e0 7f             	and    eax,0x7f
    1360:	8d 48 0c             	lea    ecx,[eax+0xc]
    1363:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    1368:	89 c8                	mov    eax,ecx
    136a:	f7 ea                	imul   edx
    136c:	c1 fa 02             	sar    edx,0x2
    136f:	89 c8                	mov    eax,ecx
    1371:	c1 f8 1f             	sar    eax,0x1f
    1374:	29 c2                	sub    edx,eax
    1376:	89 d0                	mov    eax,edx
    1378:	01 c0                	add    eax,eax
    137a:	01 d0                	add    eax,edx
    137c:	c1 e0 03             	shl    eax,0x3
    137f:	29 c1                	sub    ecx,eax
    1381:	89 ca                	mov    edx,ecx
    1383:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1386:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		pt->tm_year = 100 * ((pt->tm_year & 0xff00) >> 8) + (pt->tm_year & 0xff);
    1389:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    138c:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    138f:	c1 f8 08             	sar    eax,0x8
    1392:	0f b6 c0             	movzx  eax,al
    1395:	6b d0 64             	imul   edx,eax,0x64
    1398:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    139b:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    139e:	0f b6 c0             	movzx  eax,al
    13a1:	01 c2                	add    edx,eax
    13a3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13a6:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pt->tm_year -= 1900;
    13a9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13ac:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    13af:	8d 90 94 f8 ff ff    	lea    edx,[eax-0x76c]
    13b5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13b8:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		pt->tm_yday = pt->tm_mday - 1;
    13bb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13be:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    13c1:	8d 50 ff             	lea    edx,[eax-0x1]
    13c4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13c7:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		pt->tm_mon -= 1;
    13ca:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13cd:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    13d0:	8d 50 ff             	lea    edx,[eax-0x1]
    13d3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13d6:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		if (IS_LEAP_YEAR(pt->tm_year + 1900))
    13d9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13dc:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    13df:	3d 95 f8 ff ff       	cmp    eax,0xfffff895
    13e4:	0f 8c 8a 00 00 00    	jl     1474 <cmos_get_time+0x41f>
    13ea:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13ed:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    13f0:	05 6c 07 00 00       	add    eax,0x76c
    13f5:	83 e0 03             	and    eax,0x3
    13f8:	85 c0                	test   eax,eax
    13fa:	75 78                	jne    1474 <cmos_get_time+0x41f>
    13fc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13ff:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1402:	8d 88 6c 07 00 00    	lea    ecx,[eax+0x76c]
    1408:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    140d:	89 c8                	mov    eax,ecx
    140f:	f7 ea                	imul   edx
    1411:	89 d0                	mov    eax,edx
    1413:	c1 f8 05             	sar    eax,0x5
    1416:	89 ca                	mov    edx,ecx
    1418:	c1 fa 1f             	sar    edx,0x1f
    141b:	29 d0                	sub    eax,edx
    141d:	6b d0 64             	imul   edx,eax,0x64
    1420:	89 c8                	mov    eax,ecx
    1422:	29 d0                	sub    eax,edx
    1424:	85 c0                	test   eax,eax
    1426:	75 2f                	jne    1457 <cmos_get_time+0x402>
    1428:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    142b:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    142e:	8d 88 6c 07 00 00    	lea    ecx,[eax+0x76c]
    1434:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    1439:	89 c8                	mov    eax,ecx
    143b:	f7 ea                	imul   edx
    143d:	89 d0                	mov    eax,edx
    143f:	c1 f8 07             	sar    eax,0x7
    1442:	89 ca                	mov    edx,ecx
    1444:	c1 fa 1f             	sar    edx,0x1f
    1447:	29 d0                	sub    eax,edx
    1449:	69 d0 90 01 00 00    	imul   edx,eax,0x190
    144f:	89 c8                	mov    eax,ecx
    1451:	29 d0                	sub    eax,edx
    1453:	85 c0                	test   eax,eax
    1455:	75 1d                	jne    1474 <cmos_get_time+0x41f>
				pt->tm_yday += dayct_lp[pt->tm_mon];
    1457:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    145a:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    145d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1460:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1463:	8b 04 85 60 10 00 00 	mov    eax,DWORD PTR [eax*4+0x1060]
    146a:	01 c2                	add    edx,eax
    146c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    146f:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
    1472:	eb 1b                	jmp    148f <cmos_get_time+0x43a>
				pt->tm_yday += dayct_nl[pt->tm_mon];
    1474:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1477:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    147a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    147d:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1480:	8b 04 85 a0 10 00 00 	mov    eax,DWORD PTR [eax*4+0x10a0]
    1487:	01 c2                	add    edx,eax
    1489:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    148c:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		return *pt;
    148f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1492:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1495:	8b 0a                	mov    ecx,DWORD PTR [edx]
    1497:	89 08                	mov    DWORD PTR [eax],ecx
    1499:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
    149c:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
    149f:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
    14a2:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    14a5:	8b 4a 0c             	mov    ecx,DWORD PTR [edx+0xc]
    14a8:	89 48 0c             	mov    DWORD PTR [eax+0xc],ecx
    14ab:	8b 4a 10             	mov    ecx,DWORD PTR [edx+0x10]
    14ae:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
    14b1:	8b 4a 14             	mov    ecx,DWORD PTR [edx+0x14]
    14b4:	89 48 14             	mov    DWORD PTR [eax+0x14],ecx
    14b7:	8b 4a 18             	mov    ecx,DWORD PTR [edx+0x18]
    14ba:	89 48 18             	mov    DWORD PTR [eax+0x18],ecx
    14bd:	8b 4a 1c             	mov    ecx,DWORD PTR [edx+0x1c]
    14c0:	89 48 1c             	mov    DWORD PTR [eax+0x1c],ecx
    14c3:	8b 52 20             	mov    edx,DWORD PTR [edx+0x20]
    14c6:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
}
    14c9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14cc:	8d 65 f8             	lea    esp,[ebp-0x8]
    14cf:	5b                   	pop    ebx
    14d0:	5f                   	pop    edi
    14d1:	5d                   	pop    ebp
    14d2:	c2 04 00             	ret    0x4

000014d5 <kernel_fb_resize>:
{
    14d5:	55                   	push   ebp
    14d6:	89 e5                	mov    ebp,esp
		km_regS.x = fb_initial.width - 20;
    14d8:	a1 04 00 00 00       	mov    eax,ds:0x4
    14dd:	83 e8 14             	sub    eax,0x14
    14e0:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		km_regC.x = fb_initial.width - 20;
    14e6:	a1 04 00 00 00       	mov    eax,ds:0x4
    14eb:	83 e8 14             	sub    eax,0x14
    14ee:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		km_regC.y = fb_initial.height - 2;
    14f4:	a1 08 00 00 00       	mov    eax,ds:0x8
    14f9:	83 e8 02             	sub    eax,0x2
    14fc:	66 a3 02 00 00 00    	mov    ds:0x2,ax
}
    1502:	90                   	nop
    1503:	5d                   	pop    ebp
    1504:	c3                   	ret

00001505 <second_tick>:
{
    1505:	55                   	push   ebp
    1506:	89 e5                	mov    ebp,esp
    1508:	57                   	push   edi
    1509:	56                   	push   esi
    150a:	53                   	push   ebx
    150b:	81 ec ac 00 00 00    	sub    esp,0xac
		if(((jiffies - km_set) > CMOS_THRESHOLD)) {
    1511:	a1 00 00 00 00       	mov    eax,ds:0x0
    1516:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1519:	8b 00                	mov    eax,DWORD PTR [eax]
    151b:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1521:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    1527:	29 c8                	sub    eax,ecx
    1529:	19 da                	sbb    edx,ebx
    152b:	89 85 48 ff ff ff    	mov    DWORD PTR [ebp-0xb8],eax
    1531:	89 95 4c ff ff ff    	mov    DWORD PTR [ebp-0xb4],edx
    1537:	df ad 48 ff ff ff    	fild   QWORD PTR [ebp-0xb8]
    153d:	85 d2                	test   edx,edx
    153f:	79 08                	jns    1549 <second_tick+0x44>
    1541:	db 2d d0 10 00 00    	fld    TBYTE PTR ds:0x10d0
    1547:	de c1                	faddp  st(1),st
    1549:	dd 9d 48 ff ff ff    	fstp   QWORD PTR [ebp-0xb8]
    154f:	dd 05 e0 10 00 00    	fld    QWORD PTR ds:0x10e0
    1555:	dd 85 48 ff ff ff    	fld    QWORD PTR [ebp-0xb8]
    155b:	df f1                	fcomip st,st(1)
    155d:	dd d8                	fstp   st(0)
    155f:	0f 86 84 00 00 00    	jbe    15e9 <second_tick+0xe4>
				km_time = cmos_get_time();
    1565:	8d 85 58 ff ff ff    	lea    eax,[ebp-0xa8]
    156b:	50                   	push   eax
    156c:	e8 fc ff ff ff       	call   156d <second_tick+0x68>
    1571:	8b 85 58 ff ff ff    	mov    eax,DWORD PTR [ebp-0xa8]
    1577:	a3 00 00 00 00       	mov    ds:0x0,eax
    157c:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [ebp-0xa4]
    1582:	a3 04 00 00 00       	mov    ds:0x4,eax
    1587:	8b 85 60 ff ff ff    	mov    eax,DWORD PTR [ebp-0xa0]
    158d:	a3 08 00 00 00       	mov    ds:0x8,eax
    1592:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [ebp-0x9c]
    1598:	a3 0c 00 00 00       	mov    ds:0xc,eax
    159d:	8b 85 68 ff ff ff    	mov    eax,DWORD PTR [ebp-0x98]
    15a3:	a3 10 00 00 00       	mov    ds:0x10,eax
    15a8:	8b 85 6c ff ff ff    	mov    eax,DWORD PTR [ebp-0x94]
    15ae:	a3 14 00 00 00       	mov    ds:0x14,eax
    15b3:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [ebp-0x90]
    15b9:	a3 18 00 00 00       	mov    ds:0x18,eax
    15be:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [ebp-0x8c]
    15c4:	a3 1c 00 00 00       	mov    ds:0x1c,eax
    15c9:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [ebp-0x88]
    15cf:	a3 20 00 00 00       	mov    ds:0x20,eax
				km_set = jiffies;
    15d4:	a1 00 00 00 00       	mov    eax,ds:0x0
    15d9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    15dc:	8b 00                	mov    eax,DWORD PTR [eax]
    15de:	a3 00 00 00 00       	mov    ds:0x0,eax
    15e3:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		task_do_stats();
    15e9:	e8 fc ff ff ff       	call   15ea <second_tick+0xe5>
				double scs = (double)jiffies / HZ;
    15ee:	a1 00 00 00 00       	mov    eax,ds:0x0
    15f3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    15f6:	8b 00                	mov    eax,DWORD PTR [eax]
    15f8:	89 85 48 ff ff ff    	mov    DWORD PTR [ebp-0xb8],eax
    15fe:	89 95 4c ff ff ff    	mov    DWORD PTR [ebp-0xb4],edx
    1604:	df ad 48 ff ff ff    	fild   QWORD PTR [ebp-0xb8]
    160a:	85 d2                	test   edx,edx
    160c:	79 08                	jns    1616 <second_tick+0x111>
    160e:	db 2d d0 10 00 00    	fld    TBYTE PTR ds:0x10d0
    1614:	de c1                	faddp  st(1),st
    1616:	dd 9d 48 ff ff ff    	fstp   QWORD PTR [ebp-0xb8]
    161c:	dd 85 48 ff ff ff    	fld    QWORD PTR [ebp-0xb8]
    1622:	dd 05 e8 10 00 00    	fld    QWORD PTR ds:0x10e8
    1628:	de f9                	fdivp  st(1),st
    162a:	dd 5d d8             	fstp   QWORD PTR [ebp-0x28]
				uint32_t secs = 0, mins = 0, hrs = 0, days = 0;
    162d:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    1634:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    163b:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    1642:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
				km_regS.cur_x = 4;
    1649:	66 c7 05 0e 00 00 00 04 00 	mov    WORD PTR ds:0xe,0x4
				km_regS.cur_y = 2;
    1652:	66 c7 05 10 00 00 00 02 00 	mov    WORD PTR ds:0x10,0x2
				days = (uint32_t)(scs / 86400.0f);
    165b:	dd 45 d8             	fld    QWORD PTR [ebp-0x28]
    165e:	dd 05 f0 10 00 00    	fld    QWORD PTR ds:0x10f0
    1664:	de f9                	fdivp  st(1),st
    1666:	d9 bd 56 ff ff ff    	fnstcw WORD PTR [ebp-0xaa]
    166c:	0f b7 85 56 ff ff ff 	movzx  eax,WORD PTR [ebp-0xaa]
    1673:	80 cc 0c             	or     ah,0xc
    1676:	66 89 85 54 ff ff ff 	mov    WORD PTR [ebp-0xac],ax
    167d:	d9 ad 54 ff ff ff    	fldcw  WORD PTR [ebp-0xac]
    1683:	df bd 48 ff ff ff    	fistp  QWORD PTR [ebp-0xb8]
    1689:	d9 ad 56 ff ff ff    	fldcw  WORD PTR [ebp-0xaa]
    168f:	8b 85 48 ff ff ff    	mov    eax,DWORD PTR [ebp-0xb8]
    1695:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				scs -= 86400.0f * days;
    1698:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    169b:	ba 00 00 00 00       	mov    edx,0x0
    16a0:	89 85 48 ff ff ff    	mov    DWORD PTR [ebp-0xb8],eax
    16a6:	89 95 4c ff ff ff    	mov    DWORD PTR [ebp-0xb4],edx
    16ac:	df ad 48 ff ff ff    	fild   QWORD PTR [ebp-0xb8]
    16b2:	d9 05 f8 10 00 00    	fld    DWORD PTR ds:0x10f8
    16b8:	de c9                	fmulp  st(1),st
    16ba:	dd 45 d8             	fld    QWORD PTR [ebp-0x28]
    16bd:	de e1                	fsubrp st(1),st
    16bf:	dd 5d d8             	fstp   QWORD PTR [ebp-0x28]
				hrs = (uint32_t)(scs / 3600.0f);
    16c2:	dd 45 d8             	fld    QWORD PTR [ebp-0x28]
    16c5:	dd 05 00 11 00 00    	fld    QWORD PTR ds:0x1100
    16cb:	de f9                	fdivp  st(1),st
    16cd:	d9 ad 54 ff ff ff    	fldcw  WORD PTR [ebp-0xac]
    16d3:	df bd 48 ff ff ff    	fistp  QWORD PTR [ebp-0xb8]
    16d9:	d9 ad 56 ff ff ff    	fldcw  WORD PTR [ebp-0xaa]
    16df:	8b 85 48 ff ff ff    	mov    eax,DWORD PTR [ebp-0xb8]
    16e5:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				scs -= 3600.0f * hrs;
    16e8:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    16eb:	ba 00 00 00 00       	mov    edx,0x0
    16f0:	89 85 48 ff ff ff    	mov    DWORD PTR [ebp-0xb8],eax
    16f6:	89 95 4c ff ff ff    	mov    DWORD PTR [ebp-0xb4],edx
    16fc:	df ad 48 ff ff ff    	fild   QWORD PTR [ebp-0xb8]
    1702:	d9 05 08 11 00 00    	fld    DWORD PTR ds:0x1108
    1708:	de c9                	fmulp  st(1),st
    170a:	dd 45 d8             	fld    QWORD PTR [ebp-0x28]
    170d:	de e1                	fsubrp st(1),st
    170f:	dd 5d d8             	fstp   QWORD PTR [ebp-0x28]
				mins = (uint32_t)(scs / 60.0f);
    1712:	dd 45 d8             	fld    QWORD PTR [ebp-0x28]
    1715:	dd 05 10 11 00 00    	fld    QWORD PTR ds:0x1110
    171b:	de f9                	fdivp  st(1),st
    171d:	d9 ad 54 ff ff ff    	fldcw  WORD PTR [ebp-0xac]
    1723:	df bd 48 ff ff ff    	fistp  QWORD PTR [ebp-0xb8]
    1729:	d9 ad 56 ff ff ff    	fldcw  WORD PTR [ebp-0xaa]
    172f:	8b 85 48 ff ff ff    	mov    eax,DWORD PTR [ebp-0xb8]
    1735:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				scs -= 60.0f * mins;
    1738:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    173b:	ba 00 00 00 00       	mov    edx,0x0
    1740:	89 85 48 ff ff ff    	mov    DWORD PTR [ebp-0xb8],eax
    1746:	89 95 4c ff ff ff    	mov    DWORD PTR [ebp-0xb4],edx
    174c:	df ad 48 ff ff ff    	fild   QWORD PTR [ebp-0xb8]
    1752:	d9 05 18 11 00 00    	fld    DWORD PTR ds:0x1118
    1758:	de c9                	fmulp  st(1),st
    175a:	dd 45 d8             	fld    QWORD PTR [ebp-0x28]
    175d:	de e1                	fsubrp st(1),st
    175f:	dd 5d d8             	fstp   QWORD PTR [ebp-0x28]
				secs = (uint32_t)(scs);
    1762:	dd 45 d8             	fld    QWORD PTR [ebp-0x28]
    1765:	d9 ad 54 ff ff ff    	fldcw  WORD PTR [ebp-0xac]
    176b:	df bd 48 ff ff ff    	fistp  QWORD PTR [ebp-0xb8]
    1771:	d9 ad 56 ff ff ff    	fldcw  WORD PTR [ebp-0xaa]
    1777:	8b 85 48 ff ff ff    	mov    eax,DWORD PTR [ebp-0xb8]
    177d:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				if (secs != old_sc) {
    1780:	a1 34 02 00 00       	mov    eax,ds:0x234
    1785:	39 45 d4             	cmp    DWORD PTR [ebp-0x2c],eax
    1788:	74 2b                	je     17b5 <second_tick+0x2b0>
						crprintf(0x2f, &km_regS, "%ud %uh %um %us\n", days, hrs, mins, secs);
    178a:	83 ec 04             	sub    esp,0x4
    178d:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1790:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    1793:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1796:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    1799:	68 95 04 00 00       	push   0x495
    179e:	68 00 00 00 00       	push   0x0
    17a3:	6a 2f                	push   0x2f
    17a5:	e8 fc ff ff ff       	call   17a6 <second_tick+0x2a1>
    17aa:	83 c4 20             	add    esp,0x20
						old_sc = secs;
    17ad:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    17b0:	a3 34 02 00 00       	mov    ds:0x234,eax
				km_regS.cur_x = 0;
    17b5:	66 c7 05 0e 00 00 00 00 00 	mov    WORD PTR ds:0xe,0x0
				km_regS.cur_y = 3;
    17be:	66 c7 05 10 00 00 00 03 00 	mov    WORD PTR ds:0x10,0x3
				if (km_time.tm_year) {
    17c7:	a1 14 00 00 00       	mov    eax,ds:0x14
    17cc:	85 c0                	test   eax,eax
    17ce:	0f 84 7b 02 00 00    	je     1a4f <second_tick+0x54a>
						uint32_t adsec = ((double)(jiffies - km_set) / HZ);
    17d4:	a1 00 00 00 00       	mov    eax,ds:0x0
    17d9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    17dc:	8b 00                	mov    eax,DWORD PTR [eax]
    17de:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    17e4:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    17ea:	29 c8                	sub    eax,ecx
    17ec:	19 da                	sbb    edx,ebx
    17ee:	89 85 48 ff ff ff    	mov    DWORD PTR [ebp-0xb8],eax
    17f4:	89 95 4c ff ff ff    	mov    DWORD PTR [ebp-0xb4],edx
    17fa:	df ad 48 ff ff ff    	fild   QWORD PTR [ebp-0xb8]
    1800:	85 d2                	test   edx,edx
    1802:	79 08                	jns    180c <second_tick+0x307>
    1804:	db 2d d0 10 00 00    	fld    TBYTE PTR ds:0x10d0
    180a:	de c1                	faddp  st(1),st
    180c:	dd 9d 48 ff ff ff    	fstp   QWORD PTR [ebp-0xb8]
    1812:	dd 85 48 ff ff ff    	fld    QWORD PTR [ebp-0xb8]
    1818:	dd 05 e8 10 00 00    	fld    QWORD PTR ds:0x10e8
    181e:	de f9                	fdivp  st(1),st
    1820:	d9 bd 56 ff ff ff    	fnstcw WORD PTR [ebp-0xaa]
    1826:	0f b7 85 56 ff ff ff 	movzx  eax,WORD PTR [ebp-0xaa]
    182d:	80 cc 0c             	or     ah,0xc
    1830:	66 89 85 54 ff ff ff 	mov    WORD PTR [ebp-0xac],ax
    1837:	d9 ad 54 ff ff ff    	fldcw  WORD PTR [ebp-0xac]
    183d:	df bd 48 ff ff ff    	fistp  QWORD PTR [ebp-0xb8]
    1843:	d9 ad 56 ff ff ff    	fldcw  WORD PTR [ebp-0xaa]
    1849:	8b 85 48 ff ff ff    	mov    eax,DWORD PTR [ebp-0xb8]
    184f:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
						struct tm ta = km_time;
    1852:	a1 00 00 00 00       	mov    eax,ds:0x0
    1857:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
    185a:	a1 04 00 00 00       	mov    eax,ds:0x4
    185f:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
    1862:	a1 08 00 00 00       	mov    eax,ds:0x8
    1867:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
    186a:	a1 0c 00 00 00       	mov    eax,ds:0xc
    186f:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    1872:	a1 10 00 00 00       	mov    eax,ds:0x10
    1877:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
    187a:	a1 14 00 00 00       	mov    eax,ds:0x14
    187f:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    1882:	a1 18 00 00 00       	mov    eax,ds:0x18
    1887:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
    188a:	a1 1c 00 00 00       	mov    eax,ds:0x1c
    188f:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    1892:	a1 20 00 00 00       	mov    eax,ds:0x20
    1897:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
						ta.tm_sec += adsec;
    189a:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    189d:	89 c2                	mov    edx,eax
    189f:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    18a2:	01 d0                	add    eax,edx
    18a4:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
						if (ta.tm_sec > 59) {
    18a7:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    18aa:	83 f8 3b             	cmp    eax,0x3b
    18ad:	7e 47                	jle    18f6 <second_tick+0x3f1>
								ta.tm_min += ta.tm_sec / 60;
    18af:	8b 5d 98             	mov    ebx,DWORD PTR [ebp-0x68]
    18b2:	8b 4d 94             	mov    ecx,DWORD PTR [ebp-0x6c]
    18b5:	ba 89 88 88 88       	mov    edx,0x88888889
    18ba:	89 c8                	mov    eax,ecx
    18bc:	f7 ea                	imul   edx
    18be:	8d 04 0a             	lea    eax,[edx+ecx*1]
    18c1:	c1 f8 05             	sar    eax,0x5
    18c4:	89 c2                	mov    edx,eax
    18c6:	89 c8                	mov    eax,ecx
    18c8:	c1 f8 1f             	sar    eax,0x1f
    18cb:	29 c2                	sub    edx,eax
    18cd:	8d 04 13             	lea    eax,[ebx+edx*1]
    18d0:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
								ta.tm_sec %= 60;
    18d3:	8b 4d 94             	mov    ecx,DWORD PTR [ebp-0x6c]
    18d6:	ba 89 88 88 88       	mov    edx,0x88888889
    18db:	89 c8                	mov    eax,ecx
    18dd:	f7 ea                	imul   edx
    18df:	8d 04 0a             	lea    eax,[edx+ecx*1]
    18e2:	c1 f8 05             	sar    eax,0x5
    18e5:	89 ca                	mov    edx,ecx
    18e7:	c1 fa 1f             	sar    edx,0x1f
    18ea:	29 d0                	sub    eax,edx
    18ec:	6b d0 3c             	imul   edx,eax,0x3c
    18ef:	89 c8                	mov    eax,ecx
    18f1:	29 d0                	sub    eax,edx
    18f3:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
						if (ta.tm_min > 59) {
    18f6:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    18f9:	83 f8 3b             	cmp    eax,0x3b
    18fc:	7e 47                	jle    1945 <second_tick+0x440>
								ta.tm_hour += ta.tm_min / 60;
    18fe:	8b 5d 9c             	mov    ebx,DWORD PTR [ebp-0x64]
    1901:	8b 4d 98             	mov    ecx,DWORD PTR [ebp-0x68]
    1904:	ba 89 88 88 88       	mov    edx,0x88888889
    1909:	89 c8                	mov    eax,ecx
    190b:	f7 ea                	imul   edx
    190d:	8d 04 0a             	lea    eax,[edx+ecx*1]
    1910:	c1 f8 05             	sar    eax,0x5
    1913:	89 c2                	mov    edx,eax
    1915:	89 c8                	mov    eax,ecx
    1917:	c1 f8 1f             	sar    eax,0x1f
    191a:	29 c2                	sub    edx,eax
    191c:	8d 04 13             	lea    eax,[ebx+edx*1]
    191f:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
								ta.tm_min %= 60;
    1922:	8b 4d 98             	mov    ecx,DWORD PTR [ebp-0x68]
    1925:	ba 89 88 88 88       	mov    edx,0x88888889
    192a:	89 c8                	mov    eax,ecx
    192c:	f7 ea                	imul   edx
    192e:	8d 04 0a             	lea    eax,[edx+ecx*1]
    1931:	c1 f8 05             	sar    eax,0x5
    1934:	89 ca                	mov    edx,ecx
    1936:	c1 fa 1f             	sar    edx,0x1f
    1939:	29 d0                	sub    eax,edx
    193b:	6b d0 3c             	imul   edx,eax,0x3c
    193e:	89 c8                	mov    eax,ecx
    1940:	29 d0                	sub    eax,edx
    1942:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
						if (ta.tm_hour > 23) {
    1945:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    1948:	83 f8 17             	cmp    eax,0x17
    194b:	0f 8e 83 00 00 00    	jle    19d4 <second_tick+0x4cf>
								ta.tm_mday += ta.tm_hour / 24;
    1951:	8b 5d a0             	mov    ebx,DWORD PTR [ebp-0x60]
    1954:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    1957:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    195c:	89 c8                	mov    eax,ecx
    195e:	f7 ea                	imul   edx
    1960:	c1 fa 02             	sar    edx,0x2
    1963:	89 c8                	mov    eax,ecx
    1965:	c1 f8 1f             	sar    eax,0x1f
    1968:	29 c2                	sub    edx,eax
    196a:	8d 04 13             	lea    eax,[ebx+edx*1]
    196d:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
								ta.tm_wday += ta.tm_hour / 24;
    1970:	8b 5d ac             	mov    ebx,DWORD PTR [ebp-0x54]
    1973:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    1976:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    197b:	89 c8                	mov    eax,ecx
    197d:	f7 ea                	imul   edx
    197f:	c1 fa 02             	sar    edx,0x2
    1982:	89 c8                	mov    eax,ecx
    1984:	c1 f8 1f             	sar    eax,0x1f
    1987:	29 c2                	sub    edx,eax
    1989:	8d 04 13             	lea    eax,[ebx+edx*1]
    198c:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
								ta.tm_yday += ta.tm_hour / 24;
    198f:	8b 5d b0             	mov    ebx,DWORD PTR [ebp-0x50]
    1992:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    1995:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    199a:	89 c8                	mov    eax,ecx
    199c:	f7 ea                	imul   edx
    199e:	c1 fa 02             	sar    edx,0x2
    19a1:	89 c8                	mov    eax,ecx
    19a3:	c1 f8 1f             	sar    eax,0x1f
    19a6:	29 c2                	sub    edx,eax
    19a8:	8d 04 13             	lea    eax,[ebx+edx*1]
    19ab:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
								ta.tm_hour %= 24;
    19ae:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    19b1:	ba ab aa aa 2a       	mov    edx,0x2aaaaaab
    19b6:	89 c8                	mov    eax,ecx
    19b8:	f7 ea                	imul   edx
    19ba:	c1 fa 02             	sar    edx,0x2
    19bd:	89 c8                	mov    eax,ecx
    19bf:	c1 f8 1f             	sar    eax,0x1f
    19c2:	29 c2                	sub    edx,eax
    19c4:	89 d0                	mov    eax,edx
    19c6:	01 c0                	add    eax,eax
    19c8:	01 d0                	add    eax,edx
    19ca:	c1 e0 03             	shl    eax,0x3
    19cd:	29 c1                	sub    ecx,eax
    19cf:	89 ca                	mov    edx,ecx
    19d1:	89 55 9c             	mov    DWORD PTR [ebp-0x64],edx
						if (ta.tm_wday > 6) {
    19d4:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    19d7:	83 f8 06             	cmp    eax,0x6
    19da:	7e 27                	jle    1a03 <second_tick+0x4fe>
								ta.tm_wday %= 7;
    19dc:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    19df:	ba 93 24 49 92       	mov    edx,0x92492493
    19e4:	89 c8                	mov    eax,ecx
    19e6:	f7 ea                	imul   edx
    19e8:	8d 04 0a             	lea    eax,[edx+ecx*1]
    19eb:	c1 f8 02             	sar    eax,0x2
    19ee:	89 ca                	mov    edx,ecx
    19f0:	c1 fa 1f             	sar    edx,0x1f
    19f3:	29 d0                	sub    eax,edx
    19f5:	89 c2                	mov    edx,eax
    19f7:	c1 e2 03             	shl    edx,0x3
    19fa:	29 c2                	sub    edx,eax
    19fc:	89 c8                	mov    eax,ecx
    19fe:	29 d0                	sub    eax,edx
    1a00:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
						if (adsec)
    1a03:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
    1a07:	74 46                	je     1a4f <second_tick+0x54a>
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1a09:	8b 7d 94             	mov    edi,DWORD PTR [ebp-0x6c]
    1a0c:	8b 75 98             	mov    esi,DWORD PTR [ebp-0x68]
    1a0f:	8b 5d 9c             	mov    ebx,DWORD PTR [ebp-0x64]
    1a12:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    1a15:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
										ta.tm_mon + 1, ta.tm_mday,
    1a18:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1a1b:	83 c0 01             	add    eax,0x1
    1a1e:	89 85 48 ff ff ff    	mov    DWORD PTR [ebp-0xb8],eax
										1900 + ta.tm_year,
    1a24:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1a27:	05 6c 07 00 00       	add    eax,0x76c
    1a2c:	83 ec 08             	sub    esp,0x8
    1a2f:	57                   	push   edi
    1a30:	56                   	push   esi
    1a31:	53                   	push   ebx
    1a32:	51                   	push   ecx
    1a33:	52                   	push   edx
    1a34:	ff b5 48 ff ff ff    	push   DWORD PTR [ebp-0xb8]
    1a3a:	50                   	push   eax
    1a3b:	68 a8 04 00 00       	push   0x4a8
    1a40:	68 00 00 00 00       	push   0x0
    1a45:	6a 2f                	push   0x2f
    1a47:	e8 fc ff ff ff       	call   1a48 <second_tick+0x543>
    1a4c:	83 c4 30             	add    esp,0x30
				const uint16_t gran = 10;
    1a4f:	66 c7 45 c2 0a 00    	mov    WORD PTR [ebp-0x3e],0xa
				l_k = 1 + (gran * cpu_pcs[0].vals[1]) / 100;
    1a55:	0f b7 55 c2          	movzx  edx,WORD PTR [ebp-0x3e]
    1a59:	a1 00 00 00 00       	mov    eax,ds:0x0
    1a5e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1a61:	0f af c2             	imul   eax,edx
    1a64:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    1a69:	f7 e2                	mul    edx
    1a6b:	89 d0                	mov    eax,edx
    1a6d:	c1 e8 05             	shr    eax,0x5
    1a70:	83 c0 01             	add    eax,0x1
    1a73:	66 89 45 c0          	mov    WORD PTR [ebp-0x40],ax
				l_n = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3])) / 100;
    1a77:	0f b7 45 c2          	movzx  eax,WORD PTR [ebp-0x3e]
    1a7b:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1a81:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
    1a84:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1a8a:	8b 52 0c             	mov    edx,DWORD PTR [edx+0xc]
    1a8d:	01 ca                	add    edx,ecx
    1a8f:	0f af c2             	imul   eax,edx
    1a92:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    1a97:	f7 e2                	mul    edx
    1a99:	89 d0                	mov    eax,edx
    1a9b:	c1 e8 05             	shr    eax,0x5
    1a9e:	83 c0 01             	add    eax,0x1
    1aa1:	66 89 45 be          	mov    WORD PTR [ebp-0x42],ax
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1aa5:	0f b7 45 c2          	movzx  eax,WORD PTR [ebp-0x3e]
    1aa9:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1aaf:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
    1ab2:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1ab8:	8b 52 0c             	mov    edx,DWORD PTR [edx+0xc]
    1abb:	01 d1                	add    ecx,edx
										+ cpu_pcs[0].vals[2])) / 100;
    1abd:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1ac3:	8b 52 08             	mov    edx,DWORD PTR [edx+0x8]
    1ac6:	01 ca                	add    edx,ecx
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1ac8:	0f af c2             	imul   eax,edx
										+ cpu_pcs[0].vals[2])) / 100;
    1acb:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    1ad0:	f7 e2                	mul    edx
    1ad2:	89 d0                	mov    eax,edx
    1ad4:	c1 e8 05             	shr    eax,0x5
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1ad7:	83 c0 01             	add    eax,0x1
    1ada:	66 89 45 bc          	mov    WORD PTR [ebp-0x44],ax
				putc_prc(&km_regC, KFMT_NORMAL, '[', 0, 0);
    1ade:	83 ec 0c             	sub    esp,0xc
    1ae1:	6a 00                	push   0x0
    1ae3:	6a 00                	push   0x0
    1ae5:	6a 5b                	push   0x5b
    1ae7:	6a 0f                	push   0xf
    1ae9:	68 00 00 00 00       	push   0x0
    1aee:	e8 fc ff ff ff       	call   1aef <second_tick+0x5ea>
    1af3:	83 c4 20             	add    esp,0x20
				putc_prc(&km_regC, KFMT_NORMAL, ']', 11, 0);
    1af6:	83 ec 0c             	sub    esp,0xc
    1af9:	6a 00                	push   0x0
    1afb:	6a 0b                	push   0xb
    1afd:	6a 5d                	push   0x5d
    1aff:	6a 0f                	push   0xf
    1b01:	68 00 00 00 00       	push   0x0
    1b06:	e8 fc ff ff ff       	call   1b07 <second_tick+0x602>
    1b0b:	83 c4 20             	add    esp,0x20
				for (uint16_t i = 1; i < 1 + gran; i++) {
    1b0e:	66 c7 45 e4 01 00    	mov    WORD PTR [ebp-0x1c],0x1
    1b14:	e9 9b 00 00 00       	jmp    1bb4 <second_tick+0x6af>
						if (i < l_k)
    1b19:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b1d:	66 3b 45 c0          	cmp    ax,WORD PTR [ebp-0x40]
    1b21:	73 1d                	jae    1b40 <second_tick+0x63b>
								putc_prc(&km_regC, KFMT_ERROR, '|', i, 0);
    1b23:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b27:	83 ec 0c             	sub    esp,0xc
    1b2a:	6a 00                	push   0x0
    1b2c:	50                   	push   eax
    1b2d:	6a 7c                	push   0x7c
    1b2f:	6a 0c                	push   0xc
    1b31:	68 00 00 00 00       	push   0x0
    1b36:	e8 fc ff ff ff       	call   1b37 <second_tick+0x632>
    1b3b:	83 c4 20             	add    esp,0x20
    1b3e:	eb 69                	jmp    1ba9 <second_tick+0x6a4>
						else if (i < l_n)
    1b40:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b44:	66 3b 45 be          	cmp    ax,WORD PTR [ebp-0x42]
    1b48:	73 1d                	jae    1b67 <second_tick+0x662>
								putc_prc(&km_regC, KFMT_WARN, '|', i, 0);
    1b4a:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b4e:	83 ec 0c             	sub    esp,0xc
    1b51:	6a 00                	push   0x0
    1b53:	50                   	push   eax
    1b54:	6a 7c                	push   0x7c
    1b56:	6a 0e                	push   0xe
    1b58:	68 00 00 00 00       	push   0x0
    1b5d:	e8 fc ff ff ff       	call   1b5e <second_tick+0x659>
    1b62:	83 c4 20             	add    esp,0x20
    1b65:	eb 42                	jmp    1ba9 <second_tick+0x6a4>
						else if (i < l_u)
    1b67:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b6b:	66 3b 45 bc          	cmp    ax,WORD PTR [ebp-0x44]
    1b6f:	73 1d                	jae    1b8e <second_tick+0x689>
								putc_prc(&km_regC, KFMT_INFO, '|', i, 0);
    1b71:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b75:	83 ec 0c             	sub    esp,0xc
    1b78:	6a 00                	push   0x0
    1b7a:	50                   	push   eax
    1b7b:	6a 7c                	push   0x7c
    1b7d:	6a 0b                	push   0xb
    1b7f:	68 00 00 00 00       	push   0x0
    1b84:	e8 fc ff ff ff       	call   1b85 <second_tick+0x680>
    1b89:	83 c4 20             	add    esp,0x20
    1b8c:	eb 1b                	jmp    1ba9 <second_tick+0x6a4>
								putc_prc(&km_regC, KFMT_NORMAL, ' ', i, 0);
    1b8e:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1b92:	83 ec 0c             	sub    esp,0xc
    1b95:	6a 00                	push   0x0
    1b97:	50                   	push   eax
    1b98:	6a 20                	push   0x20
    1b9a:	6a 0f                	push   0xf
    1b9c:	68 00 00 00 00       	push   0x0
    1ba1:	e8 fc ff ff ff       	call   1ba2 <second_tick+0x69d>
    1ba6:	83 c4 20             	add    esp,0x20
				for (uint16_t i = 1; i < 1 + gran; i++) {
    1ba9:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1bad:	83 c0 01             	add    eax,0x1
    1bb0:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
    1bb4:	0f b7 45 c2          	movzx  eax,WORD PTR [ebp-0x3e]
    1bb8:	66 3b 45 e4          	cmp    ax,WORD PTR [ebp-0x1c]
    1bbc:	0f 83 57 ff ff ff    	jae    1b19 <second_tick+0x614>
				km_regC.cur_y = 0;
    1bc2:	66 c7 05 10 00 00 00 00 00 	mov    WORD PTR ds:0x10,0x0
				km_regC.cur_x = 2 + gran;
    1bcb:	0f b7 45 c2          	movzx  eax,WORD PTR [ebp-0x3e]
    1bcf:	83 c0 02             	add    eax,0x2
    1bd2:	66 a3 0e 00 00 00    	mov    ds:0xe,ax
				pc_a = min(100, 100 - cpu_pcs[0].vals[0] - ((cpu_pcs[0].vals[4] > 0)
    1bd8:	a1 00 00 00 00       	mov    eax,ds:0x0
    1bdd:	8b 10                	mov    edx,DWORD PTR [eax]
    1bdf:	a1 00 00 00 00       	mov    eax,ds:0x0
    1be4:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1be7:	85 c0                	test   eax,eax
    1be9:	74 07                	je     1bf2 <second_tick+0x6ed>
    1beb:	b8 01 00 00 00       	mov    eax,0x1
    1bf0:	eb 05                	jmp    1bf7 <second_tick+0x6f2>
    1bf2:	b8 00 00 00 00       	mov    eax,0x0
    1bf7:	01 d0                	add    eax,edx
    1bf9:	83 f8 64             	cmp    eax,0x64
    1bfc:	77 2c                	ja     1c2a <second_tick+0x725>
    1bfe:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c03:	8b 00                	mov    eax,DWORD PTR [eax]
    1c05:	89 c2                	mov    edx,eax
    1c07:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c0c:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c0f:	85 c0                	test   eax,eax
    1c11:	74 07                	je     1c1a <second_tick+0x715>
    1c13:	b8 01 00 00 00       	mov    eax,0x1
    1c18:	eb 05                	jmp    1c1f <second_tick+0x71a>
    1c1a:	b8 00 00 00 00       	mov    eax,0x0
    1c1f:	01 c2                	add    edx,eax
    1c21:	b8 64 00 00 00       	mov    eax,0x64
    1c26:	29 d0                	sub    eax,edx
    1c28:	eb 05                	jmp    1c2f <second_tick+0x72a>
    1c2a:	b8 64 00 00 00       	mov    eax,0x64
    1c2f:	66 89 45 ba          	mov    WORD PTR [ebp-0x46],ax
				pc_b = min(9, 10 - cpu_pcs[0].vals[4]);
    1c33:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c38:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
    1c3b:	b8 0a 00 00 00       	mov    eax,0xa
    1c40:	29 d0                	sub    eax,edx
    1c42:	ba 09 00 00 00       	mov    edx,0x9
    1c47:	39 d0                	cmp    eax,edx
    1c49:	0f 47 c2             	cmova  eax,edx
    1c4c:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
				if (pc_a == 100)
    1c50:	66 83 7d ba 64       	cmp    WORD PTR [ebp-0x46],0x64
    1c55:	75 06                	jne    1c5d <second_tick+0x758>
						pc_b = 0;
    1c57:	66 c7 45 e6 00 00    	mov    WORD PTR [ebp-0x1a],0x0
				crprintf(KFMT_NORMAL, &km_regC, "%3u.%1u%%", pc_a, pc_b);
    1c5d:	0f b7 55 e6          	movzx  edx,WORD PTR [ebp-0x1a]
    1c61:	0f b7 45 ba          	movzx  eax,WORD PTR [ebp-0x46]
    1c65:	83 ec 0c             	sub    esp,0xc
    1c68:	52                   	push   edx
    1c69:	50                   	push   eax
    1c6a:	68 cf 04 00 00       	push   0x4cf
    1c6f:	68 00 00 00 00       	push   0x0
    1c74:	6a 0f                	push   0xf
    1c76:	e8 fc ff ff ff       	call   1c77 <second_tick+0x772>
    1c7b:	83 c4 20             	add    esp,0x20
}
    1c7e:	90                   	nop
    1c7f:	8d 65 f4             	lea    esp,[ebp-0xc]
    1c82:	5b                   	pop    ebx
    1c83:	5e                   	pop    esi
    1c84:	5f                   	pop    edi
    1c85:	5d                   	pop    ebp
    1c86:	c3                   	ret

00001c87 <print_counter>:
void print_counter()
{
    1c87:	55                   	push   ebp
    1c88:	89 e5                	mov    ebp,esp
    1c8a:	57                   	push   edi
    1c8b:	56                   	push   esi
    1c8c:	53                   	push   ebx
    1c8d:	83 ec 1c             	sub    esp,0x1c
		extern uint64_t fb_rdt; uint64_t rdt; const char* tp = "";
    1c90:	c7 45 dc d9 04 00 00 	mov    DWORD PTR [ebp-0x24],0x4d9
		if (counter_print == jiffies) /* limit the updates */
    1c97:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c9c:	8b 08                	mov    ecx,DWORD PTR [eax]
    1c9e:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1ca1:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ca6:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1cac:	89 cf                	mov    edi,ecx
    1cae:	89 c6                	mov    esi,eax
    1cb0:	89 d9                	mov    ecx,ebx
    1cb2:	89 f8                	mov    eax,edi
    1cb4:	31 f0                	xor    eax,esi
    1cb6:	31 ca                	xor    edx,ecx
    1cb8:	09 d0                	or     eax,edx
    1cba:	0f 84 b9 02 00 00    	je     1f79 <print_counter+0x2f2>
				return;
		counter_print = jiffies;
    1cc0:	a1 00 00 00 00       	mov    eax,ds:0x0
    1cc5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1cc8:	8b 00                	mov    eax,DWORD PTR [eax]
    1cca:	a3 00 00 00 00       	mov    ds:0x0,eax
    1ccf:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		if (tsc_per_ms) {
    1cd5:	a1 00 00 00 00       	mov    eax,ds:0x0
    1cda:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1ce0:	89 c1                	mov    ecx,eax
    1ce2:	89 c8                	mov    eax,ecx
    1ce4:	09 d0                	or     eax,edx
    1ce6:	0f 84 b4 00 00 00    	je     1da0 <print_counter+0x119>
				tp = " ns";
    1cec:	c7 45 dc da 04 00 00 	mov    DWORD PTR [ebp-0x24],0x4da
				rdt = fb_rdt * 1000000 / tsc_per_ms;
    1cf3:	a1 00 00 00 00       	mov    eax,ds:0x0
    1cf8:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1cfe:	69 da 40 42 0f 00    	imul   ebx,edx,0xf4240
    1d04:	6b c8 00             	imul   ecx,eax,0x0
    1d07:	01 d9                	add    ecx,ebx
    1d09:	bb 40 42 0f 00       	mov    ebx,0xf4240
    1d0e:	f7 e3                	mul    ebx
    1d10:	01 d1                	add    ecx,edx
    1d12:	89 ca                	mov    edx,ecx
    1d14:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1d1a:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    1d20:	53                   	push   ebx
    1d21:	51                   	push   ecx
    1d22:	52                   	push   edx
    1d23:	50                   	push   eax
    1d24:	e8 fc ff ff ff       	call   1d25 <print_counter+0x9e>
    1d29:	83 c4 10             	add    esp,0x10
    1d2c:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1d2f:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				if (rdt > 99999) {
    1d32:	ba 9f 86 01 00       	mov    edx,0x1869f
    1d37:	b8 00 00 00 00       	mov    eax,0x0
    1d3c:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
    1d3f:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
    1d42:	73 24                	jae    1d68 <print_counter+0xe1>
						rdt /= 1000;
    1d44:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1d47:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1d4a:	6a 00                	push   0x0
    1d4c:	68 e8 03 00 00       	push   0x3e8
    1d51:	52                   	push   edx
    1d52:	50                   	push   eax
    1d53:	e8 fc ff ff ff       	call   1d54 <print_counter+0xcd>
    1d58:	83 c4 10             	add    esp,0x10
    1d5b:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1d5e:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						tp = " mu";
    1d61:	c7 45 dc de 04 00 00 	mov    DWORD PTR [ebp-0x24],0x4de
				}
				if (rdt > 99999) {
    1d68:	ba 9f 86 01 00       	mov    edx,0x1869f
    1d6d:	b8 00 00 00 00       	mov    eax,0x0
    1d72:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
    1d75:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
    1d78:	73 37                	jae    1db1 <print_counter+0x12a>
						rdt /= 1000;
    1d7a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1d7d:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1d80:	6a 00                	push   0x0
    1d82:	68 e8 03 00 00       	push   0x3e8
    1d87:	52                   	push   edx
    1d88:	50                   	push   eax
    1d89:	e8 fc ff ff ff       	call   1d8a <print_counter+0x103>
    1d8e:	83 c4 10             	add    esp,0x10
    1d91:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1d94:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						tp = " ms";
    1d97:	c7 45 dc e2 04 00 00 	mov    DWORD PTR [ebp-0x24],0x4e2
    1d9e:	eb 11                	jmp    1db1 <print_counter+0x12a>
				}
		} else
				rdt = fb_rdt;
    1da0:	a1 00 00 00 00       	mov    eax,ds:0x0
    1da5:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1dab:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1dae:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		km_regC.cur_x = 0; km_regC.cur_y = 1;
    1db1:	66 c7 05 0e 00 00 00 00 00 	mov    WORD PTR ds:0xe,0x0
    1dba:	66 c7 05 10 00 00 00 01 00 	mov    WORD PTR ds:0x10,0x1
		rprintf(&km_regC, "%7llu: %7llu%s", counter_print, rdt, tp);
    1dc3:	a1 00 00 00 00       	mov    eax,ds:0x0
    1dc8:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1dce:	83 ec 04             	sub    esp,0x4
    1dd1:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1dd4:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1dd7:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    1dda:	52                   	push   edx
    1ddb:	50                   	push   eax
    1ddc:	68 e6 04 00 00       	push   0x4e6
    1de1:	68 00 00 00 00       	push   0x0
    1de6:	e8 fc ff ff ff       	call   1de7 <print_counter+0x160>
    1deb:	83 c4 20             	add    esp,0x20
		if ((jiffies - counter_sec) > HZ || !counter_sec) {
    1dee:	a1 00 00 00 00       	mov    eax,ds:0x0
    1df3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1df6:	8b 00                	mov    eax,DWORD PTR [eax]
    1df8:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1dfe:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    1e04:	29 c8                	sub    eax,ecx
    1e06:	19 da                	sbb    edx,ebx
    1e08:	bb 79 00 00 00       	mov    ebx,0x79
    1e0d:	b9 00 00 00 00       	mov    ecx,0x0
    1e12:	39 c3                	cmp    ebx,eax
    1e14:	19 d1                	sbb    ecx,edx
    1e16:	72 13                	jb     1e2b <print_counter+0x1a4>
    1e18:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e1d:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1e23:	89 c1                	mov    ecx,eax
    1e25:	89 c8                	mov    eax,ecx
    1e27:	09 d0                	or     eax,edx
    1e29:	75 4b                	jne    1e76 <print_counter+0x1ef>
				if (!counter_sec)
    1e2b:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e30:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1e36:	89 c1                	mov    ecx,eax
    1e38:	89 c8                	mov    eax,ecx
    1e3a:	09 d0                	or     eax,edx
    1e3c:	75 17                	jne    1e55 <print_counter+0x1ce>
						counter_sec = jiffies;
    1e3e:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e43:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1e46:	8b 00                	mov    eax,DWORD PTR [eax]
    1e48:	a3 00 00 00 00       	mov    ds:0x0,eax
    1e4d:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
    1e53:	eb 1c                	jmp    1e71 <print_counter+0x1ea>
				else
						counter_sec += HZ;
    1e55:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e5a:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1e60:	83 c0 79             	add    eax,0x79
    1e63:	83 d2 00             	adc    edx,0x0
    1e66:	a3 00 00 00 00       	mov    ds:0x0,eax
    1e6b:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
				second_tick();
    1e71:	e8 fc ff ff ff       	call   1e72 <print_counter+0x1eb>
		}

		/* update memory stats faster than every second! really? */
		km_regS.cur_x = 0;
    1e76:	66 c7 05 0e 00 00 00 00 00 	mov    WORD PTR ds:0xe,0x0
		km_regS.cur_y = 1;
    1e7f:	66 c7 05 10 00 00 00 01 00 	mov    WORD PTR ds:0x10,0x1
		
		void kstats(size_t* s_total, size_t* s_commit,
					   	size_t* s_free, size_t* s_nheaps);
		kstats(h_stats, h_stats + 1, h_stats + 2, h_stats + 3);
    1e88:	b9 0c 00 00 00       	mov    ecx,0xc
    1e8d:	ba 08 00 00 00       	mov    edx,0x8
    1e92:	b8 04 00 00 00       	mov    eax,0x4
    1e97:	51                   	push   ecx
    1e98:	52                   	push   edx
    1e99:	50                   	push   eax
    1e9a:	68 00 00 00 00       	push   0x0
    1e9f:	e8 fc ff ff ff       	call   1ea0 <print_counter+0x219>
    1ea4:	83 c4 10             	add    esp,0x10
		for (size_t i = 0; i < 4; i++)
    1ea7:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    1eae:	e9 ba 00 00 00       	jmp    1f6d <print_counter+0x2e6>
				if (h_stats_old[i] != h_stats[i]) {
    1eb3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1eb6:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    1ebd:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1ec0:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1ec7:	39 c2                	cmp    edx,eax
    1ec9:	0f 84 9a 00 00 00    	je     1f69 <print_counter+0x2e2>
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
								h_stats[3], (h_stats[2]) / 1024);
    1ecf:	a1 08 00 00 00       	mov    eax,ds:0x8
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    1ed4:	c1 e8 0a             	shr    eax,0xa
    1ed7:	89 c6                	mov    esi,eax
    1ed9:	8b 0d 0c 00 00 00    	mov    ecx,DWORD PTR ds:0xc
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
    1edf:	a1 04 00 00 00       	mov    eax,ds:0x4
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    1ee4:	3d 9f 86 01 00       	cmp    eax,0x1869f
    1ee9:	77 1a                	ja     1f05 <print_counter+0x27e>
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
    1eeb:	a1 04 00 00 00       	mov    eax,ds:0x4
    1ef0:	3d 0f 27 00 00       	cmp    eax,0x270f
    1ef5:	76 07                	jbe    1efe <print_counter+0x277>
    1ef7:	ba d9 04 00 00       	mov    edx,0x4d9
    1efc:	eb 0c                	jmp    1f0a <print_counter+0x283>
    1efe:	ba f5 04 00 00       	mov    edx,0x4f5
    1f03:	eb 05                	jmp    1f0a <print_counter+0x283>
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    1f05:	ba f7 04 00 00       	mov    edx,0x4f7
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
    1f0a:	a1 04 00 00 00       	mov    eax,ds:0x4
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    1f0f:	3d 9f 86 01 00       	cmp    eax,0x1869f
    1f14:	76 0a                	jbe    1f20 <print_counter+0x299>
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
    1f16:	a1 04 00 00 00       	mov    eax,ds:0x4
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    1f1b:	c1 e8 0a             	shr    eax,0xa
    1f1e:	eb 05                	jmp    1f25 <print_counter+0x29e>
    1f20:	a1 04 00 00 00       	mov    eax,ds:0x4
    1f25:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
    1f2b:	c1 eb 0a             	shr    ebx,0xa
    1f2e:	56                   	push   esi
    1f2f:	51                   	push   ecx
    1f30:	52                   	push   edx
    1f31:	50                   	push   eax
    1f32:	53                   	push   ebx
    1f33:	68 f9 04 00 00       	push   0x4f9
    1f38:	68 00 00 00 00       	push   0x0
    1f3d:	6a 2f                	push   0x2f
    1f3f:	e8 fc ff ff ff       	call   1f40 <print_counter+0x2b9>
    1f44:	83 c4 20             	add    esp,0x20
						for (; i < 4; i++)
    1f47:	eb 18                	jmp    1f61 <print_counter+0x2da>
								h_stats_old[i] = h_stats[i];
    1f49:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1f4c:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    1f53:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1f56:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						for (; i < 4; i++)
    1f5d:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    1f61:	83 7d d8 03          	cmp    DWORD PTR [ebp-0x28],0x3
    1f65:	76 e2                	jbe    1f49 <print_counter+0x2c2>
						break;
    1f67:	eb 11                	jmp    1f7a <print_counter+0x2f3>
		for (size_t i = 0; i < 4; i++)
    1f69:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    1f6d:	83 7d d8 03          	cmp    DWORD PTR [ebp-0x28],0x3
    1f71:	0f 86 3c ff ff ff    	jbe    1eb3 <print_counter+0x22c>
    1f77:	eb 01                	jmp    1f7a <print_counter+0x2f3>
				return;
    1f79:	90                   	nop
				}
}
    1f7a:	8d 65 f4             	lea    esp,[ebp-0xc]
    1f7d:	5b                   	pop    ebx
    1f7e:	5e                   	pop    esi
    1f7f:	5f                   	pop    edi
    1f80:	5d                   	pop    ebp
    1f81:	c3                   	ret

00001f82 <ktimer_tick>:

/* this is the workhorse used for time-keeping */
void ktimer_tick()
{
    1f82:	55                   	push   ebp
    1f83:	89 e5                	mov    ebp,esp
    1f85:	83 ec 08             	sub    esp,0x8
		extern uint64_t fb_udc;
		extern uint64_t fb_rdc;
		extern uint64_t fb_rdt;
		/* timekeeping */
		jiffies++;
    1f88:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1f8e:	8b 01                	mov    eax,DWORD PTR [ecx]
    1f90:	8b 51 04             	mov    edx,DWORD PTR [ecx+0x4]
    1f93:	83 c0 01             	add    eax,0x1
    1f96:	83 d2 00             	adc    edx,0x0
    1f99:	89 01                	mov    DWORD PTR [ecx],eax
    1f9b:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		if (irq0_hook) /* don't starve bogo_mips calculation */
    1f9e:	a1 00 00 00 00       	mov    eax,ds:0x0
    1fa3:	85 c0                	test   eax,eax
    1fa5:	75 3c                	jne    1fe3 <ktimer_tick+0x61>
				return;

		static volatile int redr = 0;
		extern int preempt_needs_init;
		if (preempt_needs_init && !redr--) {
    1fa7:	a1 00 00 00 00       	mov    eax,ds:0x0
    1fac:	85 c0                	test   eax,eax
    1fae:	74 34                	je     1fe4 <ktimer_tick+0x62>
    1fb0:	a1 38 02 00 00       	mov    eax,ds:0x238
    1fb5:	8d 50 ff             	lea    edx,[eax-0x1]
    1fb8:	89 15 38 02 00 00    	mov    DWORD PTR ds:0x238,edx
    1fbe:	85 c0                	test   eax,eax
    1fc0:	75 22                	jne    1fe4 <ktimer_tick+0x62>
				redr = 10;
    1fc2:	c7 05 38 02 00 00 0a 00 00 00 	mov    DWORD PTR ds:0x238,0xa
				print_counter();
    1fcc:	e8 fc ff ff ff       	call   1fcd <ktimer_tick+0x4b>
				framebuffer_redraw_updates(&fb_initial);
    1fd1:	83 ec 0c             	sub    esp,0xc
    1fd4:	68 00 00 00 00       	push   0x0
    1fd9:	e8 fc ff ff ff       	call   1fda <ktimer_tick+0x58>
    1fde:	83 c4 10             	add    esp,0x10
    1fe1:	eb 01                	jmp    1fe4 <ktimer_tick+0x62>
				return;
    1fe3:	90                   	nop
		}
}
    1fe4:	c9                   	leave
    1fe5:	c3                   	ret

00001fe6 <kredraw>:

void kredraw(void* data)
{
    1fe6:	55                   	push   ebp
    1fe7:	89 e5                	mov    ebp,esp
    1fe9:	83 ec 08             	sub    esp,0x8
		while (1) {
				extern struct wait_queue_head wq_timer;
				print_counter();
    1fec:	e8 fc ff ff ff       	call   1fed <kredraw+0x7>
				//asm("cli");
				preempt_disable();
    1ff1:	e8 fc ff ff ff       	call   1ff2 <kredraw+0xc>
    1ff6:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    1ff9:	83 c2 01             	add    edx,0x1
    1ffc:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				framebuffer_redraw_updates(&fb_initial);
    1fff:	83 ec 0c             	sub    esp,0xc
    2002:	68 00 00 00 00       	push   0x0
    2007:	e8 fc ff ff ff       	call   2008 <kredraw+0x22>
    200c:	83 c4 10             	add    esp,0x10
				preempt_enable_no_resched();
    200f:	e8 fc ff ff ff       	call   2010 <kredraw+0x2a>
    2014:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2017:	83 ea 01             	sub    edx,0x1
    201a:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				//asm("sti");
				wait_timeout(&wq_timer, HZ / 60);
    201d:	83 ec 08             	sub    esp,0x8
    2020:	6a 02                	push   0x2
    2022:	68 00 00 00 00       	push   0x0
    2027:	e8 fc ff ff ff       	call   2028 <kredraw+0x42>
    202c:	83 c4 10             	add    esp,0x10
		while (1) {
    202f:	90                   	nop
    2030:	eb ba                	jmp    1fec <kredraw+0x6>

00002032 <clock_gettime>:
		}
}

int clock_gettime(clockid_t clk_id, struct timespec* tp)
{
    2032:	55                   	push   ebp
    2033:	89 e5                	mov    ebp,esp
    2035:	56                   	push   esi
    2036:	53                   	push   ebx
    2037:	83 ec 50             	sub    esp,0x50
		if (!tp || clk_id != CLOCK_REALTIME) {
    203a:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    203e:	74 06                	je     2046 <clock_gettime+0x14>
    2040:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    2044:	74 14                	je     205a <clock_gettime+0x28>
				errno = EINVAL;
    2046:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    2050:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2055:	e9 dc 01 00 00       	jmp    2236 <clock_gettime+0x204>
		}
		/* query the cmos for REALTIME if needed */
		if (!km_set) {
    205a:	a1 00 00 00 00       	mov    eax,ds:0x0
    205f:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    2065:	89 c1                	mov    ecx,eax
    2067:	89 c8                	mov    eax,ecx
    2069:	09 d0                	or     eax,edx
    206b:	75 66                	jne    20d3 <clock_gettime+0xa1>
				km_time = cmos_get_time();
    206d:	8d 45 b8             	lea    eax,[ebp-0x48]
    2070:	50                   	push   eax
    2071:	e8 fc ff ff ff       	call   2072 <clock_gettime+0x40>
    2076:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    2079:	a3 00 00 00 00       	mov    ds:0x0,eax
    207e:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2081:	a3 04 00 00 00       	mov    ds:0x4,eax
    2086:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    2089:	a3 08 00 00 00       	mov    ds:0x8,eax
    208e:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2091:	a3 0c 00 00 00       	mov    ds:0xc,eax
    2096:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2099:	a3 10 00 00 00       	mov    ds:0x10,eax
    209e:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    20a1:	a3 14 00 00 00       	mov    ds:0x14,eax
    20a6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    20a9:	a3 18 00 00 00       	mov    ds:0x18,eax
    20ae:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    20b1:	a3 1c 00 00 00       	mov    ds:0x1c,eax
    20b6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    20b9:	a3 20 00 00 00       	mov    ds:0x20,eax
				km_set = jiffies;
    20be:	a1 00 00 00 00       	mov    eax,ds:0x0
    20c3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    20c6:	8b 00                	mov    eax,DWORD PTR [eax]
    20c8:	a3 00 00 00 00       	mov    ds:0x0,eax
    20cd:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		}
		tp->tv_nsec = 0;
    20d3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    20d6:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
				ct |= (uint16_t)inb(PIT1_CH0) << 8;
				ct = (uint16_t)(PIT_FREQ / CLOCKS_PER_SEC) - ct;
				tp->tv_nsec += (long)((double)(uint32_t)ct * 1000000 / PIT_FREQ);
		}
		/* calculate the number of leap days since 1970 */
		time_t diff = jiffies - km_set;
    20dd:	a1 00 00 00 00       	mov    eax,ds:0x0
    20e2:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    20e5:	8b 00                	mov    eax,DWORD PTR [eax]
    20e7:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    20ed:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    20f3:	29 c8                	sub    eax,ecx
    20f5:	19 da                	sbb    edx,ebx
    20f7:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    20fa:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		tp->tv_nsec = diff - (time_t)((time_t)(diff / CLOCKS_PER_SEC) * CLOCKS_PER_SEC);
    20fd:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2100:	df 6d f0             	fild   QWORD PTR [ebp-0x10]
    2103:	dd 05 20 11 00 00    	fld    QWORD PTR ds:0x1120
    2109:	de f9                	fdivp  st(1),st
    210b:	d9 7d b6             	fnstcw WORD PTR [ebp-0x4a]
    210e:	0f b7 45 b6          	movzx  eax,WORD PTR [ebp-0x4a]
    2112:	80 cc 0c             	or     ah,0xc
    2115:	66 89 45 b4          	mov    WORD PTR [ebp-0x4c],ax
    2119:	d9 6d b4             	fldcw  WORD PTR [ebp-0x4c]
    211c:	df 7d a8             	fistp  QWORD PTR [ebp-0x58]
    211f:	d9 6d b6             	fldcw  WORD PTR [ebp-0x4a]
    2122:	df 6d a8             	fild   QWORD PTR [ebp-0x58]
    2125:	dd 05 20 11 00 00    	fld    QWORD PTR ds:0x1120
    212b:	de c9                	fmulp  st(1),st
    212d:	d9 6d b4             	fldcw  WORD PTR [ebp-0x4c]
    2130:	df 7d a8             	fistp  QWORD PTR [ebp-0x58]
    2133:	d9 6d b6             	fldcw  WORD PTR [ebp-0x4a]
    2136:	8b 4d a8             	mov    ecx,DWORD PTR [ebp-0x58]
    2139:	89 d0                	mov    eax,edx
    213b:	29 c8                	sub    eax,ecx
    213d:	89 c2                	mov    edx,eax
    213f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2142:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		tp->tv_nsec = (long)((tp->tv_nsec * 1000000) / CLOCKS_PER_SEC);
    2145:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2148:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    214b:	69 c0 40 42 0f 00    	imul   eax,eax,0xf4240
    2151:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
    2154:	db 45 a8             	fild   DWORD PTR [ebp-0x58]
    2157:	dd 05 20 11 00 00    	fld    QWORD PTR ds:0x1120
    215d:	de f9                	fdivp  st(1),st
    215f:	d9 6d b4             	fldcw  WORD PTR [ebp-0x4c]
    2162:	db 5d a8             	fistp  DWORD PTR [ebp-0x58]
    2165:	d9 6d b6             	fldcw  WORD PTR [ebp-0x4a]
    2168:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    216b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    216e:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    2171:	a1 14 00 00 00       	mov    eax,ds:0x14
    2176:	05 6b 07 00 00       	add    eax,0x76b
    217b:	69 d8 6d 01 00 00    	imul   ebx,eax,0x16d
    2181:	a1 14 00 00 00       	mov    eax,ds:0x14
    2186:	05 6b 07 00 00       	add    eax,0x76b
    218b:	8d 50 03             	lea    edx,[eax+0x3]
    218e:	85 c0                	test   eax,eax
    2190:	0f 48 c2             	cmovs  eax,edx
    2193:	c1 f8 02             	sar    eax,0x2
    2196:	89 c6                	mov    esi,eax
    2198:	a1 14 00 00 00       	mov    eax,ds:0x14
    219d:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
    21a3:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    21a8:	89 c8                	mov    eax,ecx
    21aa:	f7 ea                	imul   edx
    21ac:	89 d0                	mov    eax,edx
    21ae:	c1 f8 05             	sar    eax,0x5
    21b1:	c1 f9 1f             	sar    ecx,0x1f
    21b4:	89 ca                	mov    edx,ecx
    21b6:	29 c2                	sub    edx,eax
    21b8:	01 d6                	add    esi,edx
    21ba:	a1 14 00 00 00       	mov    eax,ds:0x14
    21bf:	8d 88 6b 07 00 00    	lea    ecx,[eax+0x76b]
    21c5:	ba 1f 85 eb 51       	mov    edx,0x51eb851f
    21ca:	89 c8                	mov    eax,ecx
    21cc:	f7 ea                	imul   edx
    21ce:	c1 fa 07             	sar    edx,0x7
    21d1:	89 c8                	mov    eax,ecx
    21d3:	c1 f8 1f             	sar    eax,0x1f
    21d6:	29 c2                	sub    edx,eax
    21d8:	8d 04 16             	lea    eax,[esi+edx*1]
    21db:	01 d8                	add    eax,ebx
    21dd:	8d 90 c6 06 f5 ff    	lea    edx,[eax-0xaf93a]
						+ km_time.tm_yday) + 3600 * km_time.tm_hour
    21e3:	a1 1c 00 00 00       	mov    eax,ds:0x1c
    21e8:	01 d0                	add    eax,edx
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    21ea:	69 d0 80 51 01 00    	imul   edx,eax,0x15180
						+ km_time.tm_yday) + 3600 * km_time.tm_hour
    21f0:	a1 08 00 00 00       	mov    eax,ds:0x8
    21f5:	69 c0 10 0e 00 00    	imul   eax,eax,0xe10
    21fb:	01 c2                	add    edx,eax
						+ 60 * km_time.tm_min + km_time.tm_sec
    21fd:	a1 04 00 00 00       	mov    eax,ds:0x4
    2202:	6b c0 3c             	imul   eax,eax,0x3c
    2205:	01 c2                	add    edx,eax
    2207:	a1 00 00 00 00       	mov    eax,ds:0x0
    220c:	01 d0                	add    eax,edx
    220e:	99                   	cdq
						+ (time_t)(diff / CLOCKS_PER_SEC);
    220f:	df 6d f0             	fild   QWORD PTR [ebp-0x10]
    2212:	dd 05 20 11 00 00    	fld    QWORD PTR ds:0x1120
    2218:	de f9                	fdivp  st(1),st
    221a:	d9 6d b4             	fldcw  WORD PTR [ebp-0x4c]
    221d:	df 7d a8             	fistp  QWORD PTR [ebp-0x58]
    2220:	d9 6d b6             	fldcw  WORD PTR [ebp-0x4a]
    2223:	03 45 a8             	add    eax,DWORD PTR [ebp-0x58]
    2226:	13 55 ac             	adc    edx,DWORD PTR [ebp-0x54]
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    2229:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    222c:	89 01                	mov    DWORD PTR [ecx],eax
    222e:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return 0;
    2231:	b8 00 00 00 00       	mov    eax,0x0
}
    2236:	8d 65 f8             	lea    esp,[ebp-0x8]
    2239:	5b                   	pop    ebx
    223a:	5e                   	pop    esi
    223b:	5d                   	pop    ebp
    223c:	c3                   	ret

0000223d <hook_fun.0>:
void calibrate_bogo_mips(uint16_t pit_div)
{
		static uint32_t ct = 0, old_ct = 0, delta[8] = {0}, ni = 0;
		static uint64_t ts_delta[8], ts_ct = 0;
		uint32_t limit = 0x00f00000; /* very low for QEMU-software emu */
		void hook_fun() {
    223d:	55                   	push   ebp
    223e:	89 e5                	mov    ebp,esp
    2240:	83 ec 04             	sub    esp,0x4
    2243:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
				ni++;
    2246:	a1 3c 02 00 00       	mov    eax,ds:0x23c
    224b:	83 c0 01             	add    eax,0x1
    224e:	a3 3c 02 00 00       	mov    ds:0x23c,eax
				if (old_ct && ni <= 9) {
    2253:	a1 40 02 00 00       	mov    eax,ds:0x240
    2258:	85 c0                	test   eax,eax
    225a:	74 4d                	je     22a9 <hook_fun.0+0x6c>
    225c:	a1 3c 02 00 00       	mov    eax,ds:0x23c
    2261:	83 f8 09             	cmp    eax,0x9
    2264:	77 43                	ja     22a9 <hook_fun.0+0x6c>
						delta[ni - 2] = ct - old_ct;
    2266:	8b 0d 44 02 00 00    	mov    ecx,DWORD PTR ds:0x244
    226c:	a1 40 02 00 00       	mov    eax,ds:0x240
    2271:	8b 15 3c 02 00 00    	mov    edx,DWORD PTR ds:0x23c
    2277:	83 ea 02             	sub    edx,0x2
    227a:	29 c1                	sub    ecx,eax
    227c:	89 0c 95 60 02 00 00 	mov    DWORD PTR [edx*4+0x260],ecx
						if (cpu.has_tsc)
    2283:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    228a:	83 e0 10             	and    eax,0x10
    228d:	84 c0                	test   al,al
    228f:	74 18                	je     22a9 <hook_fun.0+0x6c>
								asm volatile ("rdtsc" : "=A" (ts_delta[ni - 2]));
    2291:	a1 3c 02 00 00       	mov    eax,ds:0x23c
    2296:	8d 48 fe             	lea    ecx,[eax-0x2]
    2299:	0f 31                	rdtsc
    229b:	89 04 cd 80 02 00 00 	mov    DWORD PTR [ecx*8+0x280],eax
    22a2:	89 14 cd 84 02 00 00 	mov    DWORD PTR [ecx*8+0x284],edx
				}
				old_ct = ct;
    22a9:	a1 44 02 00 00       	mov    eax,ds:0x244
    22ae:	a3 40 02 00 00       	mov    ds:0x240,eax
				if (ni >= 9)
    22b3:	a1 3c 02 00 00       	mov    eax,ds:0x23c
    22b8:	83 f8 08             	cmp    eax,0x8
    22bb:	76 0a                	jbe    22c7 <hook_fun.0+0x8a>
						irq0_hook = NULL;
    22bd:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
		}
    22c7:	90                   	nop
    22c8:	c9                   	leave
    22c9:	c3                   	ret

000022ca <calibrate_bogo_mips>:
{
    22ca:	55                   	push   ebp
    22cb:	89 e5                	mov    ebp,esp
    22cd:	57                   	push   edi
    22ce:	56                   	push   esi
    22cf:	53                   	push   ebx
    22d0:	83 ec 3c             	sub    esp,0x3c
    22d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    22d6:	66 89 45 c4          	mov    WORD PTR [ebp-0x3c],ax
void calibrate_bogo_mips(uint16_t pit_div)
    22da:	8d 45 08             	lea    eax,[ebp+0x8]
    22dd:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    22e0:	8d 45 d0             	lea    eax,[ebp-0x30]
    22e3:	8d 55 d0             	lea    edx,[ebp-0x30]
    22e6:	c6 00 b9             	mov    BYTE PTR [eax],0xb9
    22e9:	89 50 01             	mov    DWORD PTR [eax+0x1],edx
    22ec:	c6 40 05 e9          	mov    BYTE PTR [eax+0x5],0xe9
    22f0:	b9 3d 22 00 00       	mov    ecx,0x223d
    22f5:	8d 50 0a             	lea    edx,[eax+0xa]
    22f8:	29 d1                	sub    ecx,edx
    22fa:	89 48 06             	mov    DWORD PTR [eax+0x6],ecx
		uint32_t limit = 0x00f00000; /* very low for QEMU-software emu */
    22fd:	c7 45 e4 00 00 f0 00 	mov    DWORD PTR [ebp-0x1c],0xf00000

		printf("calibrating bogous MIPS value...\n");
    2304:	83 ec 0c             	sub    esp,0xc
    2307:	68 10 05 00 00       	push   0x510
    230c:	e8 fc ff ff ff       	call   230d <calibrate_bogo_mips+0x43>
    2311:	83 c4 10             	add    esp,0x10
		/* do the adaptive loop
		 * if limit needs to be > 32bit we're f'ed  */
		do {
				/* zero the variables */
				ct = old_ct = ni = 0;
    2314:	c7 05 3c 02 00 00 00 00 00 00 	mov    DWORD PTR ds:0x23c,0x0
    231e:	a1 3c 02 00 00       	mov    eax,ds:0x23c
    2323:	a3 40 02 00 00       	mov    ds:0x240,eax
    2328:	a1 40 02 00 00       	mov    eax,ds:0x240
    232d:	a3 44 02 00 00       	mov    ds:0x244,eax
				/* (re-)install the irq0 hook */
				irq0_hook = hook_fun;
    2332:	8d 45 d0             	lea    eax,[ebp-0x30]
    2335:	a3 00 00 00 00       	mov    ds:0x0,eax
				for (ct = 0; ct < limit; ct++);
    233a:	c7 05 44 02 00 00 00 00 00 00 	mov    DWORD PTR ds:0x244,0x0
    2344:	eb 0d                	jmp    2353 <calibrate_bogo_mips+0x89>
    2346:	a1 44 02 00 00       	mov    eax,ds:0x244
    234b:	83 c0 01             	add    eax,0x1
    234e:	a3 44 02 00 00       	mov    ds:0x244,eax
    2353:	a1 44 02 00 00       	mov    eax,ds:0x244
    2358:	3b 45 e4             	cmp    eax,DWORD PTR [ebp-0x1c]
    235b:	72 e9                	jb     2346 <calibrate_bogo_mips+0x7c>
				if (ni < 9) { /* unusable -> redo */
    235d:	a1 3c 02 00 00       	mov    eax,ds:0x23c
    2362:	83 f8 08             	cmp    eax,0x8
    2365:	77 2b                	ja     2392 <calibrate_bogo_mips+0xc8>
						limit <<= 4;
    2367:	c1 65 e4 04          	shl    DWORD PTR [ebp-0x1c],0x4
						printf("increasing bogous MIPS calibration loop limit to %x\n", limit);
    236b:	83 ec 08             	sub    esp,0x8
    236e:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    2371:	68 34 05 00 00       	push   0x534
    2376:	e8 fc ff ff ff       	call   2377 <calibrate_bogo_mips+0xad>
    237b:	83 c4 10             	add    esp,0x10
						/* wait for hook self-removal */
						while (irq0_hook);
    237e:	90                   	nop
    237f:	a1 00 00 00 00       	mov    eax,ds:0x0
    2384:	85 c0                	test   eax,eax
    2386:	75 f7                	jne    237f <calibrate_bogo_mips+0xb5>
						ni = 0;
    2388:	c7 05 3c 02 00 00 00 00 00 00 	mov    DWORD PTR ds:0x23c,0x0
				}
		} while (ni < 9);
    2392:	a1 3c 02 00 00       	mov    eax,ds:0x23c
    2397:	83 f8 08             	cmp    eax,0x8
    239a:	0f 86 74 ff ff ff    	jbe    2314 <calibrate_bogo_mips+0x4a>

		/* now we have 8 positive delta values for
		 * calibrating bogo_mips each div ticks apart */
		old_ct = 0;
    23a0:	c7 05 40 02 00 00 00 00 00 00 	mov    DWORD PTR ds:0x240,0x0
		for (ct = 0; ct < 8; ct++) {
    23aa:	c7 05 44 02 00 00 00 00 00 00 	mov    DWORD PTR ds:0x244,0x0
    23b4:	e9 ab 00 00 00       	jmp    2464 <calibrate_bogo_mips+0x19a>
				printf("%u: %08x\n", ct, delta[ct]);
    23b9:	a1 44 02 00 00       	mov    eax,ds:0x244
    23be:	8b 14 85 60 02 00 00 	mov    edx,DWORD PTR [eax*4+0x260]
    23c5:	a1 44 02 00 00       	mov    eax,ds:0x244
    23ca:	83 ec 04             	sub    esp,0x4
    23cd:	52                   	push   edx
    23ce:	50                   	push   eax
    23cf:	68 69 05 00 00       	push   0x569
    23d4:	e8 fc ff ff ff       	call   23d5 <calibrate_bogo_mips+0x10b>
    23d9:	83 c4 10             	add    esp,0x10
				old_ct += delta[ct];
    23dc:	a1 44 02 00 00       	mov    eax,ds:0x244
    23e1:	8b 14 85 60 02 00 00 	mov    edx,DWORD PTR [eax*4+0x260]
    23e8:	a1 40 02 00 00       	mov    eax,ds:0x240
    23ed:	01 d0                	add    eax,edx
    23ef:	a3 40 02 00 00       	mov    ds:0x240,eax
				if (cpu.has_tsc && ct)
    23f4:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    23fb:	83 e0 10             	and    eax,0x10
    23fe:	84 c0                	test   al,al
    2400:	74 55                	je     2457 <calibrate_bogo_mips+0x18d>
    2402:	a1 44 02 00 00       	mov    eax,ds:0x244
    2407:	85 c0                	test   eax,eax
    2409:	74 4c                	je     2457 <calibrate_bogo_mips+0x18d>
						ts_ct += ts_delta[ct] - ts_delta[ct - 1];
    240b:	a1 44 02 00 00       	mov    eax,ds:0x244
    2410:	8b 14 c5 84 02 00 00 	mov    edx,DWORD PTR [eax*8+0x284]
    2417:	8b 04 c5 80 02 00 00 	mov    eax,DWORD PTR [eax*8+0x280]
    241e:	8b 0d 44 02 00 00    	mov    ecx,DWORD PTR ds:0x244
    2424:	83 e9 01             	sub    ecx,0x1
    2427:	8b 1c cd 84 02 00 00 	mov    ebx,DWORD PTR [ecx*8+0x284]
    242e:	8b 0c cd 80 02 00 00 	mov    ecx,DWORD PTR [ecx*8+0x280]
    2435:	29 c8                	sub    eax,ecx
    2437:	19 da                	sbb    edx,ebx
    2439:	89 c6                	mov    esi,eax
    243b:	89 d7                	mov    edi,edx
    243d:	a1 c0 02 00 00       	mov    eax,ds:0x2c0
    2442:	8b 15 c4 02 00 00    	mov    edx,DWORD PTR ds:0x2c4
    2448:	01 f0                	add    eax,esi
    244a:	11 fa                	adc    edx,edi
    244c:	a3 c0 02 00 00       	mov    ds:0x2c0,eax
    2451:	89 15 c4 02 00 00    	mov    DWORD PTR ds:0x2c4,edx
		for (ct = 0; ct < 8; ct++) {
    2457:	a1 44 02 00 00       	mov    eax,ds:0x244
    245c:	83 c0 01             	add    eax,0x1
    245f:	a3 44 02 00 00       	mov    ds:0x244,eax
    2464:	a1 44 02 00 00       	mov    eax,ds:0x244
    2469:	83 f8 07             	cmp    eax,0x7
    246c:	0f 86 47 ff ff ff    	jbe    23b9 <calibrate_bogo_mips+0xef>
		}
		old_ct /= 8;
    2472:	a1 40 02 00 00       	mov    eax,ds:0x240
    2477:	c1 e8 03             	shr    eax,0x3
    247a:	a3 40 02 00 00       	mov    ds:0x240,eax
		if (cpu.has_tsc)
    247f:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2486:	83 e0 10             	and    eax,0x10
    2489:	84 c0                	test   al,al
    248b:	74 24                	je     24b1 <calibrate_bogo_mips+0x1e7>
				ts_ct /= 7;
    248d:	a1 c0 02 00 00       	mov    eax,ds:0x2c0
    2492:	8b 15 c4 02 00 00    	mov    edx,DWORD PTR ds:0x2c4
    2498:	6a 00                	push   0x0
    249a:	6a 07                	push   0x7
    249c:	52                   	push   edx
    249d:	50                   	push   eax
    249e:	e8 fc ff ff ff       	call   249f <calibrate_bogo_mips+0x1d5>
    24a3:	83 c4 10             	add    esp,0x10
    24a6:	a3 c0 02 00 00       	mov    ds:0x2c0,eax
    24ab:	89 15 c4 02 00 00    	mov    DWORD PTR ds:0x2c4,edx
		printf("Bougous MIPS calibrated to %08x steps per PIT tick with a "
    24b1:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    24b5:	a1 40 02 00 00       	mov    eax,ds:0x240
    24ba:	83 ec 04             	sub    esp,0x4
    24bd:	52                   	push   edx
    24be:	50                   	push   eax
    24bf:	68 74 05 00 00       	push   0x574
    24c4:	e8 fc ff ff ff       	call   24c5 <calibrate_bogo_mips+0x1fb>
    24c9:	83 c4 10             	add    esp,0x10
				"PIT divider of %u\n", old_ct, pit_div);
		loops_per_jiffy = old_ct;
    24cc:	a1 40 02 00 00       	mov    eax,ds:0x240
    24d1:	a3 00 00 00 00       	mov    ds:0x0,eax
		printf("Therefore a delay of 1 ms corresponds to %u steps.\n",
				(loops_per_ms = (uint32_t)(HZ * (uint64_t)old_ct / 1000)));
    24d6:	a1 40 02 00 00       	mov    eax,ds:0x240
    24db:	89 c1                	mov    ecx,eax
    24dd:	bb 00 00 00 00       	mov    ebx,0x0
    24e2:	89 c8                	mov    eax,ecx
    24e4:	89 da                	mov    edx,ebx
    24e6:	0f a4 c2 04          	shld   edx,eax,0x4
    24ea:	c1 e0 04             	shl    eax,0x4
    24ed:	29 c8                	sub    eax,ecx
    24ef:	19 da                	sbb    edx,ebx
    24f1:	0f a4 c2 03          	shld   edx,eax,0x3
    24f5:	c1 e0 03             	shl    eax,0x3
    24f8:	01 c8                	add    eax,ecx
    24fa:	11 da                	adc    edx,ebx
    24fc:	6a 00                	push   0x0
    24fe:	68 e8 03 00 00       	push   0x3e8
    2503:	52                   	push   edx
    2504:	50                   	push   eax
    2505:	e8 fc ff ff ff       	call   2506 <calibrate_bogo_mips+0x23c>
    250a:	83 c4 10             	add    esp,0x10
		printf("Therefore a delay of 1 ms corresponds to %u steps.\n",
    250d:	a3 00 00 00 00       	mov    ds:0x0,eax
    2512:	a1 00 00 00 00       	mov    eax,ds:0x0
    2517:	83 ec 08             	sub    esp,0x8
    251a:	50                   	push   eax
    251b:	68 c4 05 00 00       	push   0x5c4
    2520:	e8 fc ff ff ff       	call   2521 <calibrate_bogo_mips+0x257>
    2525:	83 c4 10             	add    esp,0x10
		if (cpu.has_tsc) {
    2528:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    252f:	83 e0 10             	and    eax,0x10
    2532:	84 c0                	test   al,al
    2534:	74 6d                	je     25a3 <calibrate_bogo_mips+0x2d9>
				printf("As this CPU has a TSC a PIT tick corresponds to %llu "
						"TSC ticks --> %llu ticks per ms.\n", ts_ct,
					   (tsc_per_ms = HZ * ts_ct / 1000));
    2536:	8b 0d c0 02 00 00    	mov    ecx,DWORD PTR ds:0x2c0
    253c:	8b 1d c4 02 00 00    	mov    ebx,DWORD PTR ds:0x2c4
    2542:	89 c8                	mov    eax,ecx
    2544:	89 da                	mov    edx,ebx
    2546:	0f a4 c2 04          	shld   edx,eax,0x4
    254a:	c1 e0 04             	shl    eax,0x4
    254d:	29 c8                	sub    eax,ecx
    254f:	19 da                	sbb    edx,ebx
    2551:	0f a4 c2 03          	shld   edx,eax,0x3
    2555:	c1 e0 03             	shl    eax,0x3
    2558:	01 c8                	add    eax,ecx
    255a:	11 da                	adc    edx,ebx
    255c:	6a 00                	push   0x0
    255e:	68 e8 03 00 00       	push   0x3e8
    2563:	52                   	push   edx
    2564:	50                   	push   eax
    2565:	e8 fc ff ff ff       	call   2566 <calibrate_bogo_mips+0x29c>
    256a:	83 c4 10             	add    esp,0x10
				printf("As this CPU has a TSC a PIT tick corresponds to %llu "
    256d:	a3 00 00 00 00       	mov    ds:0x0,eax
    2572:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
    2578:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    257e:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    2584:	a1 c0 02 00 00       	mov    eax,ds:0x2c0
    2589:	8b 15 c4 02 00 00    	mov    edx,DWORD PTR ds:0x2c4
    258f:	83 ec 0c             	sub    esp,0xc
    2592:	53                   	push   ebx
    2593:	51                   	push   ecx
    2594:	52                   	push   edx
    2595:	50                   	push   eax
    2596:	68 f8 05 00 00       	push   0x5f8
    259b:	e8 fc ff ff ff       	call   259c <calibrate_bogo_mips+0x2d2>
    25a0:	83 c4 20             	add    esp,0x20
		}
}
    25a3:	90                   	nop
    25a4:	8d 65 f4             	lea    esp,[ebp-0xc]
    25a7:	5b                   	pop    ebx
    25a8:	5e                   	pop    esi
    25a9:	5f                   	pop    edi
    25aa:	5d                   	pop    ebp
    25ab:	c3                   	ret

000025ac <ndelay>:

void ndelay(unsigned long nsecs)
{
    25ac:	55                   	push   ebp
    25ad:	89 e5                	mov    ebp,esp
    25af:	57                   	push   edi
    25b0:	56                   	push   esi
    25b1:	53                   	push   ebx
    25b2:	83 ec 1c             	sub    esp,0x1c
		uint32_t ct = 0, limit = (uint32_t)((uint64_t)nsecs * loops_per_ms / 1000000);
    25b5:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    25bc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25bf:	ba 00 00 00 00       	mov    edx,0x0
    25c4:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    25ca:	bb 00 00 00 00       	mov    ebx,0x0
    25cf:	89 d7                	mov    edi,edx
    25d1:	0f af f9             	imul   edi,ecx
    25d4:	89 de                	mov    esi,ebx
    25d6:	0f af f0             	imul   esi,eax
    25d9:	01 fe                	add    esi,edi
    25db:	f7 e1                	mul    ecx
    25dd:	8d 0c 16             	lea    ecx,[esi+edx*1]
    25e0:	89 ca                	mov    edx,ecx
    25e2:	6a 00                	push   0x0
    25e4:	68 40 42 0f 00       	push   0xf4240
    25e9:	52                   	push   edx
    25ea:	50                   	push   eax
    25eb:	e8 fc ff ff ff       	call   25ec <ndelay+0x40>
    25f0:	83 c4 10             	add    esp,0x10
    25f3:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		/* uses the same double mem-access
		 * as in the calibration routine */
		for (ct = 0; ct < limit; ct++);
    25f6:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    25fd:	eb 04                	jmp    2603 <ndelay+0x57>
    25ff:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    2603:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2606:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    2609:	72 f4                	jb     25ff <ndelay+0x53>
}
    260b:	90                   	nop
    260c:	90                   	nop
    260d:	8d 65 f4             	lea    esp,[ebp-0xc]
    2610:	5b                   	pop    ebx
    2611:	5e                   	pop    esi
    2612:	5f                   	pop    edi
    2613:	5d                   	pop    ebp
    2614:	c3                   	ret

00002615 <udelay>:

void udelay(unsigned long usecs)
{
    2615:	55                   	push   ebp
    2616:	89 e5                	mov    ebp,esp
    2618:	83 ec 08             	sub    esp,0x8
		while (usecs--)
    261b:	eb 10                	jmp    262d <udelay+0x18>
				ndelay(1000);
    261d:	83 ec 0c             	sub    esp,0xc
    2620:	68 e8 03 00 00       	push   0x3e8
    2625:	e8 fc ff ff ff       	call   2626 <udelay+0x11>
    262a:	83 c4 10             	add    esp,0x10
		while (usecs--)
    262d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2630:	8d 50 ff             	lea    edx,[eax-0x1]
    2633:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
    2636:	85 c0                	test   eax,eax
    2638:	75 e3                	jne    261d <udelay+0x8>
}
    263a:	90                   	nop
    263b:	90                   	nop
    263c:	c9                   	leave
    263d:	c3                   	ret

0000263e <mdelay>:

void mdelay(unsigned long msecs)
{
    263e:	55                   	push   ebp
    263f:	89 e5                	mov    ebp,esp
    2641:	83 ec 08             	sub    esp,0x8
		if (!loops_per_ms)
    2644:	a1 00 00 00 00       	mov    eax,ds:0x0
    2649:	85 c0                	test   eax,eax
    264b:	74 21                	je     266e <mdelay+0x30>
				return;
		while (msecs--)
    264d:	eb 10                	jmp    265f <mdelay+0x21>
				udelay(1000);
    264f:	83 ec 0c             	sub    esp,0xc
    2652:	68 e8 03 00 00       	push   0x3e8
    2657:	e8 fc ff ff ff       	call   2658 <mdelay+0x1a>
    265c:	83 c4 10             	add    esp,0x10
		while (msecs--)
    265f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2662:	8d 50 ff             	lea    edx,[eax-0x1]
    2665:	89 55 08             	mov    DWORD PTR [ebp+0x8],edx
    2668:	85 c0                	test   eax,eax
    266a:	75 e3                	jne    264f <mdelay+0x11>
    266c:	eb 01                	jmp    266f <mdelay+0x31>
				return;
    266e:	90                   	nop
}
    266f:	c9                   	leave
    2670:	c3                   	ret

00002671 <apic_expire>:
uint32_t apic_reload_value = 0x0fffffff;
uint8_t apic_div = 0x0b;
#define NCF_AP 48
static uint32_t n_ct = 0xffffffff, exp = 0; static uint32_t tmr_val = 0;
/* the expiration hook */
void apic_expire() {
    2671:	55                   	push   ebp
    2672:	89 e5                	mov    ebp,esp
		if (!exp) /* don't unsignal 2 (done) */
    2674:	a1 20 02 00 00       	mov    eax,ds:0x220
    2679:	85 c0                	test   eax,eax
    267b:	75 0a                	jne    2687 <apic_expire+0x16>
				exp = 1;
    267d:	c7 05 20 02 00 00 01 00 00 00 	mov    DWORD PTR ds:0x220,0x1
}
    2687:	90                   	nop
    2688:	5d                   	pop    ebp
    2689:	c3                   	ret

0000268a <irq0_worker>:

/* the irq0 calibration worker */
void irq0_worker() {
    268a:	55                   	push   ebp
    268b:	89 e5                	mov    ebp,esp
    268d:	83 ec 18             	sub    esp,0x18
		if (n_ct == 0xffffffff) {
    2690:	a1 38 00 00 00       	mov    eax,ds:0x38
    2695:	83 f8 ff             	cmp    eax,0xffffffff
    2698:	75 2b                	jne    26c5 <irq0_worker+0x3b>
				/* enable the timer */
				apic_bp_reg(APIC_REG_TMRDIV) = apic_div;
    269a:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    26a1:	ba e0 03 ff ef       	mov    edx,0xefff03e0
    26a6:	0f b6 c0             	movzx  eax,al
    26a9:	89 02                	mov    DWORD PTR [edx],eax
				apic_bp_reg(APIC_REG_TMRINITCNT) = 0xffffffff;
    26ab:	b8 80 03 ff ef       	mov    eax,0xefff0380
    26b0:	c7 00 ff ff ff ff    	mov    DWORD PTR [eax],0xffffffff
				n_ct = 0;
    26b6:	c7 05 38 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x38,0x0
				return;
    26c0:	e9 f4 00 00 00       	jmp    27b9 <irq0_worker+0x12f>
		} else if (exp) {
    26c5:	a1 20 02 00 00       	mov    eax,ds:0x220
    26ca:	85 c0                	test   eax,eax
    26cc:	0f 84 ae 00 00 00    	je     2780 <irq0_worker+0xf6>
				/* timer has expired and sample is too small */
				n_ct = 0xffffffff; exp = 0; tmr_val = 0;
    26d2:	c7 05 38 00 00 00 ff ff ff ff 	mov    DWORD PTR ds:0x38,0xffffffff
    26dc:	c7 05 20 02 00 00 00 00 00 00 	mov    DWORD PTR ds:0x220,0x0
    26e6:	c7 05 24 02 00 00 00 00 00 00 	mov    DWORD PTR ds:0x224,0x0
				if (apic_div == 0x0b)
    26f0:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    26f7:	3c 0b                	cmp    al,0xb
    26f9:	75 0c                	jne    2707 <irq0_worker+0x7d>
						apic_div = 1;
    26fb:	c6 05 00 00 00 00 01 	mov    BYTE PTR ds:0x0,0x1
    2702:	e9 b2 00 00 00       	jmp    27b9 <irq0_worker+0x12f>
				else {
						/* bits: 3210; 2=R=0, bin: 2-128, 1 */
						uint8_t val = (((apic_div & 0x08) >> 1) | (apic_div & 0x03));
    2707:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    270e:	0f b6 c0             	movzx  eax,al
    2711:	d1 f8                	sar    eax,1
    2713:	83 e0 04             	and    eax,0x4
    2716:	89 c2                	mov    edx,eax
    2718:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    271f:	83 e0 03             	and    eax,0x3
    2722:	09 d0                	or     eax,edx
    2724:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
						val++;
    2727:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    272b:	83 c0 01             	add    eax,0x1
    272e:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
						apic_div = ((val & 0x04) << 1) | (val & 0x03);
    2731:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2735:	01 c0                	add    eax,eax
    2737:	83 e0 08             	and    eax,0x8
    273a:	89 c2                	mov    edx,eax
    273c:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2740:	83 e0 03             	and    eax,0x3
    2743:	09 d0                	or     eax,edx
    2745:	a2 00 00 00 00       	mov    ds:0x0,al
						if (apic_div == 0x0b)
    274a:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    2751:	3c 0b                	cmp    al,0xb
    2753:	75 64                	jne    27b9 <irq0_worker+0x12f>
								die("unable to divide high enough!\n");
    2755:	83 ec 08             	sub    esp,0x8
    2758:	68 50 06 00 00       	push   0x650
    275d:	6a 0c                	push   0xc
    275f:	e8 fc ff ff ff       	call   2760 <irq0_worker+0xd6>
    2764:	83 c4 10             	add    esp,0x10
    2767:	e8 fc ff ff ff       	call   2768 <irq0_worker+0xde>
    276c:	83 ec 0c             	sub    esp,0xc
    276f:	68 00 00 00 00       	push   0x0
    2774:	e8 fc ff ff ff       	call   2775 <irq0_worker+0xeb>
    2779:	83 c4 10             	add    esp,0x10
    277c:	fa                   	cli
    277d:	f4                   	hlt
    277e:	eb fd                	jmp    277d <irq0_worker+0xf3>
				}
		} else if (n_ct < NCF_AP - 1)
    2780:	a1 38 00 00 00       	mov    eax,ds:0x38
    2785:	83 f8 2e             	cmp    eax,0x2e
    2788:	77 0f                	ja     2799 <irq0_worker+0x10f>
				n_ct++;
    278a:	a1 38 00 00 00       	mov    eax,ds:0x38
    278f:	83 c0 01             	add    eax,0x1
    2792:	a3 38 00 00 00       	mov    ds:0x38,eax
    2797:	eb 20                	jmp    27b9 <irq0_worker+0x12f>
		else {
				/* remove one of the hooks */
				tmr_val = apic_bp_reg(APIC_REG_TMRCURRCNT);
    2799:	b8 90 03 ff ef       	mov    eax,0xefff0390
    279e:	8b 00                	mov    eax,DWORD PTR [eax]
    27a0:	a3 24 02 00 00       	mov    ds:0x224,eax
				irq0_hook = NULL;
    27a5:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
				exp = 2;
    27af:	c7 05 20 02 00 00 02 00 00 00 	mov    DWORD PTR ds:0x220,0x2
		}
}
    27b9:	c9                   	leave
    27ba:	c3                   	ret

000027bb <apic_timer_setup>:

/* function is already during preemption */
void apic_timer_setup()
{
    27bb:	55                   	push   ebp
    27bc:	89 e5                	mov    ebp,esp
    27be:	53                   	push   ebx
    27bf:	83 ec 14             	sub    esp,0x14
		/* strategy: set a irq0-hook which initializes the apic timer
		 * and reads the count(s) on the next iteration(s). If the
		 * APIC timer expires before completion the divider is increased. */

		/* enable the timer function of the BP */
		printf("calibrating BP APIC timer...\n");
    27c2:	83 ec 0c             	sub    esp,0xc
    27c5:	68 6f 06 00 00       	push   0x66f
    27ca:	e8 fc ff ff ff       	call   27cb <apic_timer_setup+0x10>
    27cf:	83 c4 10             	add    esp,0x10
		/* (val << 16): R00M=one-shot, R01M per, R11M tsc, R=res, M=mask */
		apic_bp_reg(APIC_REG_LVT_TMR) = 0x00000000 | 0x3d; /* one-shot */
    27d2:	b8 20 03 ff ef       	mov    eax,0xefff0320
    27d7:	c7 00 3d 00 00 00    	mov    DWORD PTR [eax],0x3d

		/* now perform the work */
		preempt_disable();
    27dd:	e8 fc ff ff ff       	call   27de <apic_timer_setup+0x23>
    27e2:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    27e5:	83 c2 01             	add    edx,0x1
    27e8:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		apic_hook = apic_expire;
    27eb:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
		irq0_hook = irq0_worker;
    27f5:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0

		/* wait for completion */
		while (exp != 2);
    27ff:	90                   	nop
    2800:	a1 20 02 00 00       	mov    eax,ds:0x220
    2805:	83 f8 02             	cmp    eax,0x2
    2808:	75 f6                	jne    2800 <apic_timer_setup+0x45>

		/* disarm the bp timer for now */
		apic_bp_reg(APIC_REG_TMRINITCNT) = 0;
    280a:	b8 80 03 ff ef       	mov    eax,0xefff0380
    280f:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0

		/* remove the apic hook (possible rc? nope; intr preempts this)*/
		apic_hook = NULL;
    2815:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0

		/* reenable preemption */
		preempt_enable();
    281f:	e8 fc ff ff ff       	call   2820 <apic_timer_setup+0x65>
    2824:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2827:	83 ea 01             	sub    edx,0x1
    282a:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
    282d:	e8 fc ff ff ff       	call   282e <apic_timer_setup+0x73>
    2832:	8b 00                	mov    eax,DWORD PTR [eax]
    2834:	83 e0 01             	and    eax,0x1
    2837:	85 c0                	test   eax,eax
    2839:	74 05                	je     2840 <apic_timer_setup+0x85>
    283b:	e8 fc ff ff ff       	call   283c <apic_timer_setup+0x81>

		/* calculate the tick values */
		tmr_val = (0xffffffff - tmr_val) / NCF_AP;
    2840:	a1 24 02 00 00       	mov    eax,ds:0x224
    2845:	f7 d0                	not    eax
    2847:	ba ab aa aa aa       	mov    edx,0xaaaaaaab
    284c:	f7 e2                	mul    edx
    284e:	89 d0                	mov    eax,edx
    2850:	c1 e8 05             	shr    eax,0x5
    2853:	a3 24 02 00 00       	mov    ds:0x224,eax
		printf("On average: %08x APIC timer ticks per PIT interrupt.\n", tmr_val);
    2858:	a1 24 02 00 00       	mov    eax,ds:0x224
    285d:	83 ec 08             	sub    esp,0x8
    2860:	50                   	push   eax
    2861:	68 90 06 00 00       	push   0x690
    2866:	e8 fc ff ff ff       	call   2867 <apic_timer_setup+0xac>
    286b:	83 c4 10             	add    esp,0x10
		apic_reload_value = tmr_val;
    286e:	a1 24 02 00 00       	mov    eax,ds:0x224
    2873:	a3 00 00 00 00       	mov    ds:0x0,eax
		{
				uint64_t freq = ((uint64_t)HZ * tmr_val);
    2878:	a1 24 02 00 00       	mov    eax,ds:0x224
    287d:	89 c1                	mov    ecx,eax
    287f:	bb 00 00 00 00       	mov    ebx,0x0
    2884:	89 c8                	mov    eax,ecx
    2886:	89 da                	mov    edx,ebx
    2888:	0f a4 c2 04          	shld   edx,eax,0x4
    288c:	c1 e0 04             	shl    eax,0x4
    288f:	29 c8                	sub    eax,ecx
    2891:	19 da                	sbb    edx,ebx
    2893:	0f a4 c2 03          	shld   edx,eax,0x3
    2897:	c1 e0 03             	shl    eax,0x3
    289a:	01 c8                	add    eax,ecx
    289c:	11 da                	adc    edx,ebx
    289e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    28a1:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
				uint32_t mhz = (uint32_t)(freq / 1000000);
    28a4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    28a7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    28aa:	6a 00                	push   0x0
    28ac:	68 40 42 0f 00       	push   0xf4240
    28b1:	52                   	push   edx
    28b2:	50                   	push   eax
    28b3:	e8 fc ff ff ff       	call   28b4 <apic_timer_setup+0xf9>
    28b8:	83 c4 10             	add    esp,0x10
    28bb:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				uint32_t khz = (uint32_t)(freq % 1000000) / 1000;
    28be:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    28c1:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    28c4:	6a 00                	push   0x0
    28c6:	68 40 42 0f 00       	push   0xf4240
    28cb:	52                   	push   edx
    28cc:	50                   	push   eax
    28cd:	e8 fc ff ff ff       	call   28ce <apic_timer_setup+0x113>
    28d2:	83 c4 10             	add    esp,0x10
    28d5:	ba d3 4d 62 10       	mov    edx,0x10624dd3
    28da:	f7 e2                	mul    edx
    28dc:	89 d0                	mov    eax,edx
    28de:	c1 e8 06             	shr    eax,0x6
    28e1:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				cprintf(KFMT_INFO, "This results in an APIC timer frequency of %u.%03u MHz\n",
    28e4:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    28e7:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    28ea:	68 c8 06 00 00       	push   0x6c8
    28ef:	6a 0b                	push   0xb
    28f1:	e8 fc ff ff ff       	call   28f2 <apic_timer_setup+0x137>
    28f6:	83 c4 10             	add    esp,0x10
						mhz, khz);
		}
}
    28f9:	90                   	nop
    28fa:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    28fd:	c9                   	leave
    28fe:	c3                   	ret

000028ff <timer_setup>:

void timer_setup()
{
    28ff:	55                   	push   ebp
    2900:	89 e5                	mov    ebp,esp
    2902:	56                   	push   esi
    2903:	53                   	push   ebx
    2904:	83 ec 70             	sub    esp,0x70
		uint8_t bt; const char* ams[4] = {"latch", "lo", "hi", "lo/hi"};
    2907:	c7 45 d8 00 07 00 00 	mov    DWORD PTR [ebp-0x28],0x700
    290e:	c7 45 dc 06 07 00 00 	mov    DWORD PTR [ebp-0x24],0x706
    2915:	c7 45 e0 09 07 00 00 	mov    DWORD PTR [ebp-0x20],0x709
    291c:	c7 45 e4 0c 07 00 00 	mov    DWORD PTR [ebp-0x1c],0x70c
		uint16_t div; uint64_t tmv;
		const char* oms[8] = {
    2923:	c7 45 b8 12 07 00 00 	mov    DWORD PTR [ebp-0x48],0x712
    292a:	c7 45 bc 1f 07 00 00 	mov    DWORD PTR [ebp-0x44],0x71f
    2931:	c7 45 c0 30 07 00 00 	mov    DWORD PTR [ebp-0x40],0x730
    2938:	c7 45 c4 3f 07 00 00 	mov    DWORD PTR [ebp-0x3c],0x73f
    293f:	c7 45 c8 55 07 00 00 	mov    DWORD PTR [ebp-0x38],0x755
    2946:	c7 45 cc 65 07 00 00 	mov    DWORD PTR [ebp-0x34],0x765
    294d:	c7 45 d0 30 07 00 00 	mov    DWORD PTR [ebp-0x30],0x730
    2954:	c7 45 d4 3f 07 00 00 	mov    DWORD PTR [ebp-0x2c],0x73f
				"int on count", "one-shot counter",
				"rate generator", "square wave generator",
				"software strobe", "hardware strobe",
				"rate generator", "square wave generator"
		};
		__asm__("cli");
    295b:	fa                   	cli
		km_time = cmos_get_time();
    295c:	8d 45 88             	lea    eax,[ebp-0x78]
    295f:	50                   	push   eax
    2960:	e8 fc ff ff ff       	call   2961 <timer_setup+0x62>
    2965:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    2968:	a3 00 00 00 00       	mov    ds:0x0,eax
    296d:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
    2970:	a3 04 00 00 00       	mov    ds:0x4,eax
    2975:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    2978:	a3 08 00 00 00       	mov    ds:0x8,eax
    297d:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    2980:	a3 0c 00 00 00       	mov    ds:0xc,eax
    2985:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    2988:	a3 10 00 00 00       	mov    ds:0x10,eax
    298d:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2990:	a3 14 00 00 00       	mov    ds:0x14,eax
    2995:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    2998:	a3 18 00 00 00       	mov    ds:0x18,eax
    299d:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    29a0:	a3 1c 00 00 00       	mov    ds:0x1c,eax
    29a5:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    29a8:	a3 20 00 00 00       	mov    ds:0x20,eax
		km_set = jiffies; /* should be counter but alas */
    29ad:	a1 00 00 00 00       	mov    eax,ds:0x0
    29b2:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    29b5:	8b 00                	mov    eax,DWORD PTR [eax]
    29b7:	a3 00 00 00 00       	mov    ds:0x0,eax
    29bc:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		/* get info on the status of the timer */
		outb(PIT1_CTR, 0b11010010); /* latch status of CH0 */
    29c2:	68 d2 00 00 00       	push   0xd2
    29c7:	6a 43                	push   0x43
    29c9:	e8 53 d6 ff ff       	call   21 <outb>
    29ce:	83 c4 08             	add    esp,0x8
		bt = inb(PIT1_CH0);
    29d1:	6a 40                	push   0x40
    29d3:	e8 68 d6 ff ff       	call   40 <inb>
    29d8:	83 c4 04             	add    esp,0x4
    29db:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		printf("PIT1_CH0 status is %08b\n", bt);
    29de:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    29e2:	83 ec 08             	sub    esp,0x8
    29e5:	50                   	push   eax
    29e6:	68 75 07 00 00       	push   0x775
    29eb:	e8 fc ff ff ff       	call   29ec <timer_setup+0xed>
    29f0:	83 c4 10             	add    esp,0x10
		printf("with access mode: %s\n", ams[(bt >> 4) & 0x03]);
    29f3:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    29f7:	c0 e8 04             	shr    al,0x4
    29fa:	0f b6 c0             	movzx  eax,al
    29fd:	83 e0 03             	and    eax,0x3
    2a00:	8b 44 85 d8          	mov    eax,DWORD PTR [ebp+eax*4-0x28]
    2a04:	83 ec 08             	sub    esp,0x8
    2a07:	50                   	push   eax
    2a08:	68 8e 07 00 00       	push   0x78e
    2a0d:	e8 fc ff ff ff       	call   2a0e <timer_setup+0x10f>
    2a12:	83 c4 10             	add    esp,0x10
		printf("and operating mode: %s\n", oms[(bt >> 1) & 0x07]);
    2a15:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2a19:	d0 e8                	shr    al,1
    2a1b:	0f b6 c0             	movzx  eax,al
    2a1e:	83 e0 07             	and    eax,0x7
    2a21:	8b 44 85 b8          	mov    eax,DWORD PTR [ebp+eax*4-0x48]
    2a25:	83 ec 08             	sub    esp,0x8
    2a28:	50                   	push   eax
    2a29:	68 a4 07 00 00       	push   0x7a4
    2a2e:	e8 fc ff ff ff       	call   2a2f <timer_setup+0x130>
    2a33:	83 c4 10             	add    esp,0x10
		/* change the mode */
		printf("timer will be set to rate generator lo/hi mode\n");
    2a36:	83 ec 0c             	sub    esp,0xc
    2a39:	68 bc 07 00 00       	push   0x7bc
    2a3e:	e8 fc ff ff ff       	call   2a3f <timer_setup+0x140>
    2a43:	83 c4 10             	add    esp,0x10
		outb(PIT1_CTR, 0b00110110); /* binary CH0 lohi rategen */
    2a46:	83 ec 08             	sub    esp,0x8
    2a49:	6a 36                	push   0x36
    2a4b:	6a 43                	push   0x43
    2a4d:	e8 cf d5 ff ff       	call   21 <outb>
    2a52:	83 c4 10             	add    esp,0x10
		/* and the divisor */
		printf("divisor for HZ=%d: %u\n", HZ, 1193182u / HZ);
    2a55:	83 ec 04             	sub    esp,0x4
    2a58:	68 85 26 00 00       	push   0x2685
    2a5d:	6a 79                	push   0x79
    2a5f:	68 ec 07 00 00       	push   0x7ec
    2a64:	e8 fc ff ff ff       	call   2a65 <timer_setup+0x166>
    2a69:	83 c4 10             	add    esp,0x10
		//div = 9861; //11931; //0xffff;
		div = 1193182u / HZ;
    2a6c:	66 c7 45 f4 85 26    	mov    WORD PTR [ebp-0xc],0x2685
		//printf("with a divisor of %u\n", div);
		//printf("resulting in a frequency of ~%u Hz\n", 1193182u / div);
		outb(PIT1_CH0, div & 0xff);
    2a72:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    2a76:	0f b6 c0             	movzx  eax,al
    2a79:	83 ec 08             	sub    esp,0x8
    2a7c:	50                   	push   eax
    2a7d:	6a 40                	push   0x40
    2a7f:	e8 9d d5 ff ff       	call   21 <outb>
    2a84:	83 c4 10             	add    esp,0x10
		outb(PIT1_CH0, (div >> 8) & 0xff);
    2a87:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    2a8b:	66 c1 e8 08          	shr    ax,0x8
    2a8f:	0f b6 c0             	movzx  eax,al
    2a92:	83 ec 08             	sub    esp,0x8
    2a95:	50                   	push   eax
    2a96:	6a 40                	push   0x40
    2a98:	e8 84 d5 ff ff       	call   21 <outb>
    2a9d:	83 c4 10             	add    esp,0x10
		__asm__("sti");
    2aa0:	fb                   	sti
		calibrate_bogo_mips(div);
    2aa1:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    2aa5:	83 ec 0c             	sub    esp,0xc
    2aa8:	50                   	push   eax
    2aa9:	e8 fc ff ff ff       	call   2aaa <timer_setup+0x1ab>
    2aae:	83 c4 10             	add    esp,0x10
		printf("done\n");
    2ab1:	83 ec 0c             	sub    esp,0xc
    2ab4:	68 03 08 00 00       	push   0x803
    2ab9:	e8 fc ff ff ff       	call   2aba <timer_setup+0x1bb>
    2abe:	83 c4 10             	add    esp,0x10
		/* testing the resolution */
		printf("delaying execution for 200 ms...\n");
    2ac1:	83 ec 0c             	sub    esp,0xc
    2ac4:	68 0c 08 00 00       	push   0x80c
    2ac9:	e8 fc ff ff ff       	call   2aca <timer_setup+0x1cb>
    2ace:	83 c4 10             	add    esp,0x10
		tmv = jiffies;
    2ad1:	a1 00 00 00 00       	mov    eax,ds:0x0
    2ad6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2ad9:	8b 00                	mov    eax,DWORD PTR [eax]
    2adb:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    2ade:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		mdelay(200);
    2ae1:	83 ec 0c             	sub    esp,0xc
    2ae4:	68 c8 00 00 00       	push   0xc8
    2ae9:	e8 fc ff ff ff       	call   2aea <timer_setup+0x1eb>
    2aee:	83 c4 10             	add    esp,0x10
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
				" to %u ms, resulting in a deviation of %+d ms\n",
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
				(int32_t)((jiffies - tmv) * 1000 / HZ) - 200);
    2af1:	a1 00 00 00 00       	mov    eax,ds:0x0
    2af6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2af9:	8b 00                	mov    eax,DWORD PTR [eax]
    2afb:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
    2afe:	1b 55 ec             	sbb    edx,DWORD PTR [ebp-0x14]
    2b01:	89 c1                	mov    ecx,eax
    2b03:	89 d3                	mov    ebx,edx
    2b05:	89 c8                	mov    eax,ecx
    2b07:	89 da                	mov    edx,ebx
    2b09:	0f a4 c2 05          	shld   edx,eax,0x5
    2b0d:	c1 e0 05             	shl    eax,0x5
    2b10:	29 c8                	sub    eax,ecx
    2b12:	19 da                	sbb    edx,ebx
    2b14:	0f a4 c2 02          	shld   edx,eax,0x2
    2b18:	c1 e0 02             	shl    eax,0x2
    2b1b:	01 c8                	add    eax,ecx
    2b1d:	11 da                	adc    edx,ebx
    2b1f:	0f a4 c2 03          	shld   edx,eax,0x3
    2b23:	c1 e0 03             	shl    eax,0x3
    2b26:	6a 00                	push   0x0
    2b28:	6a 79                	push   0x79
    2b2a:	52                   	push   edx
    2b2b:	50                   	push   eax
    2b2c:	e8 fc ff ff ff       	call   2b2d <timer_setup+0x22e>
    2b31:	83 c4 10             	add    esp,0x10
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2b34:	8d b0 38 ff ff ff    	lea    esi,[eax-0xc8]
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
    2b3a:	a1 00 00 00 00       	mov    eax,ds:0x0
    2b3f:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2b42:	8b 00                	mov    eax,DWORD PTR [eax]
    2b44:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
    2b47:	1b 55 ec             	sbb    edx,DWORD PTR [ebp-0x14]
    2b4a:	89 c1                	mov    ecx,eax
    2b4c:	89 d3                	mov    ebx,edx
    2b4e:	89 c8                	mov    eax,ecx
    2b50:	89 da                	mov    edx,ebx
    2b52:	0f a4 c2 05          	shld   edx,eax,0x5
    2b56:	c1 e0 05             	shl    eax,0x5
    2b59:	29 c8                	sub    eax,ecx
    2b5b:	19 da                	sbb    edx,ebx
    2b5d:	0f a4 c2 02          	shld   edx,eax,0x2
    2b61:	c1 e0 02             	shl    eax,0x2
    2b64:	01 c8                	add    eax,ecx
    2b66:	11 da                	adc    edx,ebx
    2b68:	0f a4 c2 03          	shld   edx,eax,0x3
    2b6c:	c1 e0 03             	shl    eax,0x3
    2b6f:	6a 00                	push   0x0
    2b71:	6a 79                	push   0x79
    2b73:	52                   	push   edx
    2b74:	50                   	push   eax
    2b75:	e8 fc ff ff ff       	call   2b76 <timer_setup+0x277>
    2b7a:	83 c4 10             	add    esp,0x10
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2b7d:	89 c1                	mov    ecx,eax
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
    2b7f:	a1 00 00 00 00       	mov    eax,ds:0x0
    2b84:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2b87:	8b 00                	mov    eax,DWORD PTR [eax]
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2b89:	89 c2                	mov    edx,eax
    2b8b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2b8e:	29 c2                	sub    edx,eax
    2b90:	83 ec 08             	sub    esp,0x8
    2b93:	56                   	push   esi
    2b94:	51                   	push   ecx
    2b95:	6a 79                	push   0x79
    2b97:	52                   	push   edx
    2b98:	68 30 08 00 00       	push   0x830
    2b9d:	6a 0b                	push   0xb
    2b9f:	e8 fc ff ff ff       	call   2ba0 <timer_setup+0x2a1>
    2ba4:	83 c4 20             	add    esp,0x20
}
    2ba7:	90                   	nop
    2ba8:	8d 65 f8             	lea    esp,[ebp-0x8]
    2bab:	5b                   	pop    ebx
    2bac:	5e                   	pop    esi
    2bad:	5d                   	pop    ebp
    2bae:	c3                   	ret

00002baf <apic_tick>:

//uint32_t apic_tick_ct = 0;
void apic_tick()
{
    2baf:	55                   	push   ebp
    2bb0:	89 e5                	mov    ebp,esp
		//apic_tick_ct++;
		//if (apic_tick_ct % (10 * nproc * HZ) == 0)
		//		printf("APIC %08x received timer interrupt (global ct=%u)\n",
		//				apic_reg(APIC_REG_APICID), apic_tick_ct);
		apic_reg(APIC_REG_TMRINITCNT) = apic_reload_value;
    2bb2:	e8 49 d4 ff ff       	call   0 <per_cpu_ptr>
    2bb7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2bba:	8d 90 80 03 00 00    	lea    edx,[eax+0x380]
    2bc0:	a1 00 00 00 00       	mov    eax,ds:0x0
    2bc5:	89 02                	mov    DWORD PTR [edx],eax
		per_cpu_ptr()->ticks->tick++;
    2bc7:	e8 34 d4 ff ff       	call   0 <per_cpu_ptr>
    2bcc:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
    2bcf:	8b 01                	mov    eax,DWORD PTR [ecx]
    2bd1:	8b 51 04             	mov    edx,DWORD PTR [ecx+0x4]
    2bd4:	83 c0 01             	add    eax,0x1
    2bd7:	83 d2 00             	adc    edx,0x0
    2bda:	89 01                	mov    DWORD PTR [ecx],eax
    2bdc:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
}
    2bdf:	90                   	nop
    2be0:	5d                   	pop    ebp
    2be1:	c3                   	ret

00002be2 <apic_ipi>:

void apic_ipi()
{
    2be2:	55                   	push   ebp
    2be3:	89 e5                	mov    ebp,esp
    2be5:	53                   	push   ebx
    2be6:	83 ec 04             	sub    esp,0x4
		printf("APIC %x (TPR=%x) received IPI\n", apic_reg(APIC_REG_APICID),
				apic_reg(APIC_REG_TASKPRIOR));
    2be9:	e8 12 d4 ff ff       	call   0 <per_cpu_ptr>
    2bee:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2bf1:	83 e8 80             	sub    eax,0xffffff80
		printf("APIC %x (TPR=%x) received IPI\n", apic_reg(APIC_REG_APICID),
    2bf4:	8b 18                	mov    ebx,DWORD PTR [eax]
    2bf6:	e8 05 d4 ff ff       	call   0 <per_cpu_ptr>
    2bfb:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2bfe:	83 c0 20             	add    eax,0x20
    2c01:	8b 00                	mov    eax,DWORD PTR [eax]
    2c03:	83 ec 04             	sub    esp,0x4
    2c06:	53                   	push   ebx
    2c07:	50                   	push   eax
    2c08:	68 94 08 00 00       	push   0x894
    2c0d:	e8 fc ff ff ff       	call   2c0e <apic_ipi+0x2c>
    2c12:	83 c4 10             	add    esp,0x10
		//printf("Current timer value %x\n", apic_reg(APIC_REG_TMRCURRCNT));
}
    2c15:	90                   	nop
    2c16:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2c19:	c9                   	leave
    2c1a:	c3                   	ret

00002c1b <ap_entry>:

/* kernel entry point of APs */
extern void ap_entry()
{
    2c1b:	55                   	push   ebp
    2c1c:	89 e5                	mov    ebp,esp
    2c1e:	83 ec 08             	sub    esp,0x8
		void enable_sse();
		enable_sse(); /* avoid hangups form sched. kredraw (using sse) */
    2c21:	e8 fc ff ff ff       	call   2c22 <ap_entry+0x7>
		/* local APIC init */
		extern void ap_apic_init(); /* PCP works afterwards */
		ap_apic_init();
    2c26:	e8 fc ff ff ff       	call   2c27 <ap_entry+0xc>
		/* prevent death by empty queues */
		extern void kidle(void*);
		/* two per proc for the worst-case */
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2c2b:	68 b3 08 00 00       	push   0x8b3
    2c30:	6a 03                	push   0x3
    2c32:	6a 00                	push   0x0
    2c34:	68 00 00 00 00       	push   0x0
    2c39:	e8 fc ff ff ff       	call   2c3a <ap_entry+0x1f>
    2c3e:	83 c4 10             	add    esp,0x10
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2c41:	68 b3 08 00 00       	push   0x8b3
    2c46:	6a 03                	push   0x3
    2c48:	6a 00                	push   0x0
    2c4a:	68 00 00 00 00       	push   0x0
    2c4f:	e8 fc ff ff ff       	call   2c50 <ap_entry+0x35>
    2c54:	83 c4 10             	add    esp,0x10
		/* signal we don't need the trampoline anymore */
		extern uint8_t ap_start;
		ap_start = 0; /* still unsafe as task_schedule builds a stack frame */
    2c57:	c6 05 00 00 00 00 00 	mov    BYTE PTR ds:0x0,0x0
		/* TODO: per-cpu tasks & runqueues */
		/* switch to stack of task (sti included in eflags of tasks) */
		extern void task_schedule(struct tsi*);
		task_schedule(NULL);
    2c5e:	83 ec 0c             	sub    esp,0xc
    2c61:	6a 00                	push   0x0
    2c63:	e8 fc ff ff ff       	call   2c64 <ap_entry+0x49>
    2c68:	83 c4 10             	add    esp,0x10
		/* should never return */
		while (1); /* DBG: busy wait */
    2c6b:	90                   	nop
    2c6c:	eb fd                	jmp    2c6b <ap_entry+0x50>

00002c6e <apic_handler>:
 * TSS stacks can also be transferred between processors -> all stacks bound to
 * tasks, i.e. no processor-specific stacks needed.
 */

extern void apic_handler(uint32_t intr)
{
    2c6e:	55                   	push   ebp
    2c6f:	89 e5                	mov    ebp,esp
    2c71:	53                   	push   ebx
    2c72:	83 ec 14             	sub    esp,0x14
		static uint32_t num_spr = 0;
		switch (intr) {
    2c75:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c78:	83 f8 03             	cmp    eax,0x3
    2c7b:	0f 84 c8 00 00 00    	je     2d49 <apic_handler+0xdb>
    2c81:	83 f8 03             	cmp    eax,0x3
    2c84:	0f 87 ce 00 00 00    	ja     2d58 <apic_handler+0xea>
    2c8a:	83 f8 02             	cmp    eax,0x2
    2c8d:	0f 84 9c 00 00 00    	je     2d2f <apic_handler+0xc1>
    2c93:	83 f8 02             	cmp    eax,0x2
    2c96:	0f 87 bc 00 00 00    	ja     2d58 <apic_handler+0xea>
    2c9c:	85 c0                	test   eax,eax
    2c9e:	74 0a                	je     2caa <apic_handler+0x3c>
    2ca0:	83 f8 01             	cmp    eax,0x1
    2ca3:	74 5b                	je     2d00 <apic_handler+0x92>
    2ca5:	e9 ae 00 00 00       	jmp    2d58 <apic_handler+0xea>
			case 0:
				printf("APIC %x received error %08x\n",
					apic_reg(APIC_REG_APICID), apic_reg(APIC_REG_ESR));
    2caa:	e8 51 d3 ff ff       	call   0 <per_cpu_ptr>
    2caf:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2cb2:	05 80 02 00 00       	add    eax,0x280
				printf("APIC %x received error %08x\n",
    2cb7:	8b 18                	mov    ebx,DWORD PTR [eax]
					apic_reg(APIC_REG_APICID), apic_reg(APIC_REG_ESR));
    2cb9:	e8 42 d3 ff ff       	call   0 <per_cpu_ptr>
    2cbe:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2cc1:	83 c0 20             	add    eax,0x20
				printf("APIC %x received error %08x\n",
    2cc4:	8b 00                	mov    eax,DWORD PTR [eax]
    2cc6:	83 ec 04             	sub    esp,0x4
    2cc9:	53                   	push   ebx
    2cca:	50                   	push   eax
    2ccb:	68 b9 08 00 00       	push   0x8b9
    2cd0:	e8 fc ff ff ff       	call   2cd1 <apic_handler+0x63>
    2cd5:	83 c4 10             	add    esp,0x10
				/* rearm the error register */
				apic_reg(APIC_REG_ESR) = 0;
    2cd8:	e8 23 d3 ff ff       	call   0 <per_cpu_ptr>
    2cdd:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2ce0:	05 80 02 00 00       	add    eax,0x280
    2ce5:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				apic_reg(APIC_REG_EOI) = 0;
    2ceb:	e8 10 d3 ff ff       	call   0 <per_cpu_ptr>
    2cf0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2cf3:	05 b0 00 00 00       	add    eax,0xb0
    2cf8:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				break;
    2cfe:	eb 6f                	jmp    2d6f <apic_handler+0x101>
			case 1: {
				void (*hook)() = apic_hook;
    2d00:	a1 00 00 00 00       	mov    eax,ds:0x0
    2d05:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (hook)
    2d08:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2d0c:	74 07                	je     2d15 <apic_handler+0xa7>
						hook();
    2d0e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2d11:	ff d0                	call   eax
    2d13:	eb 05                	jmp    2d1a <apic_handler+0xac>
				else
						apic_tick();
    2d15:	e8 fc ff ff ff       	call   2d16 <apic_handler+0xa8>
				apic_reg(APIC_REG_EOI) = 0;
    2d1a:	e8 e1 d2 ff ff       	call   0 <per_cpu_ptr>
    2d1f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2d22:	05 b0 00 00 00       	add    eax,0xb0
    2d27:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				break;
    2d2d:	eb 40                	jmp    2d6f <apic_handler+0x101>
				}
			case 2:
				apic_ipi();
    2d2f:	e8 fc ff ff ff       	call   2d30 <apic_handler+0xc2>
				apic_reg(APIC_REG_EOI) = 0;
    2d34:	e8 c7 d2 ff ff       	call   0 <per_cpu_ptr>
    2d39:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2d3c:	05 b0 00 00 00       	add    eax,0xb0
    2d41:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				break;
    2d47:	eb 26                	jmp    2d6f <apic_handler+0x101>
			case 3: /* don't ack the spurious interrupt */
				num_spr++;
    2d49:	a1 c8 02 00 00       	mov    eax,ds:0x2c8
    2d4e:	83 c0 01             	add    eax,0x1
    2d51:	a3 c8 02 00 00       	mov    ds:0x2c8,eax
				break;
    2d56:	eb 17                	jmp    2d6f <apic_handler+0x101>
			default:
				cprintf(KFMT_WARN, "unknown APIC intr %x received\n", intr);
    2d58:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2d5b:	83 ec 04             	sub    esp,0x4
    2d5e:	50                   	push   eax
    2d5f:	68 d8 08 00 00       	push   0x8d8
    2d64:	6a 0e                	push   0xe
    2d66:	e8 fc ff ff ff       	call   2d67 <apic_handler+0xf9>
    2d6b:	83 c4 10             	add    esp,0x10
				break;
    2d6e:	90                   	nop
		}
		if (intr == 1) {
    2d6f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2d72:	83 f8 01             	cmp    eax,0x1
    2d75:	75 11                	jne    2d88 <apic_handler+0x11a>
				void task_schedule_isr(void*);
				task_schedule_isr(*(void**)(&intr + 1));
    2d77:	8d 45 0c             	lea    eax,[ebp+0xc]
    2d7a:	8b 00                	mov    eax,DWORD PTR [eax]
    2d7c:	83 ec 0c             	sub    esp,0xc
    2d7f:	50                   	push   eax
    2d80:	e8 fc ff ff ff       	call   2d81 <apic_handler+0x113>
    2d85:	83 c4 10             	add    esp,0x10
		}
}
    2d88:	90                   	nop
    2d89:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2d8c:	c9                   	leave
    2d8d:	c3                   	ret

00002d8e <fun2>:

static int calc_state = 0, calc_thr = 0, calc_print = 0;

void fun2(uint32_t* f) {
    2d8e:	55                   	push   ebp
    2d8f:	89 e5                	mov    ebp,esp
    2d91:	83 ec 18             	sub    esp,0x18
		while (1) {
				if (!calc_state)
    2d94:	a1 28 02 00 00       	mov    eax,ds:0x228
    2d99:	85 c0                	test   eax,eax
    2d9b:	75 07                	jne    2da4 <fun2+0x16>
						task_yield();
    2d9d:	e8 fc ff ff ff       	call   2d9e <fun2+0x10>
    2da2:	eb 28                	jmp    2dcc <fun2+0x3e>
				else {
						int v = calc_thr;
    2da4:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2da9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if ((v < 1) && __sync_bool_compare_and_swap(&calc_thr, v, v + 1))
    2dac:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2db0:	7f 1a                	jg     2dcc <fun2+0x3e>
    2db2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2db5:	83 c0 01             	add    eax,0x1
    2db8:	89 c2                	mov    edx,eax
    2dba:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2dbd:	f0 0f b1 15 2c 02 00 00 	lock cmpxchg DWORD PTR ds:0x22c,edx
    2dc5:	0f 94 c0             	sete   al
    2dc8:	84 c0                	test   al,al
    2dca:	75 1c                	jne    2de8 <fun2+0x5a>
								break;
				}
				for (size_t i = 0; i < 0xffffffff; i++);
    2dcc:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2dd3:	eb 04                	jmp    2dd9 <fun2+0x4b>
    2dd5:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    2dd9:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
    2ddd:	75 f6                	jne    2dd5 <fun2+0x47>
				__sync_fetch_and_add(f, 1);
    2ddf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2de2:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
				if (!calc_state)
    2de6:	eb ac                	jmp    2d94 <fun2+0x6>
								break;
    2de8:	90                   	nop
		}
}
    2de9:	90                   	nop
    2dea:	c9                   	leave
    2deb:	c3                   	ret

00002dec <calc_thread>:

void calc_thread(void* data)
{
    2dec:	55                   	push   ebp
    2ded:	89 e5                	mov    ebp,esp
    2def:	53                   	push   ebx
    2df0:	83 ec 24             	sub    esp,0x24
		uint32_t val = 0; uint64_t to = 0; int upd;
    2df3:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    2dfa:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    2e01:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		calc_state = 1;
    2e08:	c7 05 28 02 00 00 01 00 00 00 	mov    DWORD PTR ds:0x228,0x1
		/* test er */
		/* here we do the integer calculations */
		while (1) {
				if (!calc_state)
    2e12:	a1 28 02 00 00       	mov    eax,ds:0x228
    2e17:	85 c0                	test   eax,eax
    2e19:	75 05                	jne    2e20 <calc_thread+0x34>
						task_yield();
    2e1b:	e8 fc ff ff ff       	call   2e1c <calc_thread+0x30>
				for (size_t i = 0; i < 0xffffffff; i++);
    2e20:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    2e27:	eb 04                	jmp    2e2d <calc_thread+0x41>
    2e29:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    2e2d:	83 7d ec ff          	cmp    DWORD PTR [ebp-0x14],0xffffffff
    2e31:	75 f6                	jne    2e29 <calc_thread+0x3d>
				__sync_fetch_and_add(&val, 1);
    2e33:	f0 83 45 e4 01       	lock add DWORD PTR [ebp-0x1c],0x1
				upd = time_after(jiffies, to);
    2e38:	a1 00 00 00 00       	mov    eax,ds:0x0
    2e3d:	8b 08                	mov    ecx,DWORD PTR [eax]
    2e3f:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    2e42:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2e45:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2e48:	29 c8                	sub    eax,ecx
    2e4a:	19 da                	sbb    edx,ebx
    2e4c:	89 d0                	mov    eax,edx
    2e4e:	31 d2                	xor    edx,edx
    2e50:	c1 e8 1f             	shr    eax,0x1f
    2e53:	0f b6 c0             	movzx  eax,al
    2e56:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (calc_print == 1 || (calc_print == 2 && upd)){
    2e59:	a1 30 02 00 00       	mov    eax,ds:0x230
    2e5e:	83 f8 01             	cmp    eax,0x1
    2e61:	74 10                	je     2e73 <calc_thread+0x87>
    2e63:	a1 30 02 00 00       	mov    eax,ds:0x230
    2e68:	83 f8 02             	cmp    eax,0x2
    2e6b:	75 6f                	jne    2edc <calc_thread+0xf0>
    2e6d:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    2e71:	74 69                	je     2edc <calc_thread+0xf0>
						printf("calculation result: %u\n", val);
    2e73:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2e76:	83 ec 08             	sub    esp,0x8
    2e79:	50                   	push   eax
    2e7a:	68 f7 08 00 00       	push   0x8f7
    2e7f:	e8 fc ff ff ff       	call   2e80 <calc_thread+0x94>
    2e84:	83 c4 10             	add    esp,0x10
						if (calc_print == 2)
    2e87:	a1 30 02 00 00       	mov    eax,ds:0x230
    2e8c:	83 f8 02             	cmp    eax,0x2
    2e8f:	75 1a                	jne    2eab <calc_thread+0xbf>
								to = jiffies + 5 * HZ; /* print every 5 seconds */
    2e91:	a1 00 00 00 00       	mov    eax,ds:0x0
    2e96:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2e99:	8b 00                	mov    eax,DWORD PTR [eax]
    2e9b:	05 5d 02 00 00       	add    eax,0x25d
    2ea0:	83 d2 00             	adc    edx,0x0
    2ea3:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    2ea6:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2ea9:	eb 31                	jmp    2edc <calc_thread+0xf0>
						else
								calc_print = 0; /* print once */
    2eab:	c7 05 30 02 00 00 00 00 00 00 	mov    DWORD PTR ds:0x230,0x0
				}
				while (calc_thr >= 2) {
    2eb5:	eb 25                	jmp    2edc <calc_thread+0xf0>
						task_spawn(fun2, &val, PRIORITY_REGULAR);
    2eb7:	68 0f 09 00 00       	push   0x90f
    2ebc:	6a 02                	push   0x2
    2ebe:	8d 45 e4             	lea    eax,[ebp-0x1c]
    2ec1:	50                   	push   eax
    2ec2:	68 00 00 00 00       	push   0x0
    2ec7:	e8 fc ff ff ff       	call   2ec8 <calc_thread+0xdc>
    2ecc:	83 c4 10             	add    esp,0x10
						calc_thr--;
    2ecf:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2ed4:	83 e8 01             	sub    eax,0x1
    2ed7:	a3 2c 02 00 00       	mov    ds:0x22c,eax
				while (calc_thr >= 2) {
    2edc:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2ee1:	83 f8 01             	cmp    eax,0x1
    2ee4:	7f d1                	jg     2eb7 <calc_thread+0xcb>
				if (!calc_state)
    2ee6:	e9 27 ff ff ff       	jmp    2e12 <calc_thread+0x26>

00002eeb <calc_fun>:
				}
		}
}

void calc_fun(const char* arg)
{
    2eeb:	55                   	push   ebp
    2eec:	89 e5                	mov    ebp,esp
    2eee:	83 ec 18             	sub    esp,0x18
		int sel = atoi(arg);
    2ef1:	83 ec 0c             	sub    esp,0xc
    2ef4:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2ef7:	e8 fc ff ff ff       	call   2ef8 <calc_fun+0xd>
    2efc:	83 c4 10             	add    esp,0x10
    2eff:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		switch (sel) {
    2f02:	83 7d f4 09          	cmp    DWORD PTR [ebp-0xc],0x9
    2f06:	77 0f                	ja     2f17 <calc_fun+0x2c>
    2f08:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2f0b:	c1 e0 02             	shl    eax,0x2
    2f0e:	05 dc 0a 00 00       	add    eax,0xadc
    2f13:	8b 00                	mov    eax,DWORD PTR [eax]
    2f15:	ff e0                	jmp    eax
			case 0:
			default:
				printf("calc arg: starts/stops and shows the background\n"
    2f17:	83 ec 0c             	sub    esp,0xc
    2f1a:	68 14 09 00 00       	push   0x914
    2f1f:	e8 fc ff ff ff       	call   2f20 <calc_fun+0x35>
    2f24:	83 c4 10             	add    esp,0x10
					   "          5 - add a worker thread\n"
					   "          6 - add 5 worker threads\n"
					   "          7 - add 15 worker threads\n"
					   "          8 - remove a worker thread\n"
					   "          9 - remove 5 worker threads\n");
				break;
    2f27:	e9 ef 00 00 00       	jmp    301b <calc_fun+0x130>
			case 1:
				calc_state = 0;
    2f2c:	c7 05 28 02 00 00 00 00 00 00 	mov    DWORD PTR ds:0x228,0x0
				break;
    2f36:	e9 e0 00 00 00       	jmp    301b <calc_fun+0x130>
			case 2:
				if (!calc_thr) {
    2f3b:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2f40:	85 c0                	test   eax,eax
    2f42:	75 25                	jne    2f69 <calc_fun+0x7e>
						task_spawn(calc_thread, NULL, PRIORITY_REGULAR);
    2f44:	68 cf 0a 00 00       	push   0xacf
    2f49:	6a 02                	push   0x2
    2f4b:	6a 00                	push   0x0
    2f4d:	68 00 00 00 00       	push   0x0
    2f52:	e8 fc ff ff ff       	call   2f53 <calc_fun+0x68>
    2f57:	83 c4 10             	add    esp,0x10
						calc_thr = 1;
    2f5a:	c7 05 2c 02 00 00 01 00 00 00 	mov    DWORD PTR ds:0x22c,0x1
						//calc_state = 1;
				} else
						calc_state = 1;
				break;
    2f64:	e9 b2 00 00 00       	jmp    301b <calc_fun+0x130>
						calc_state = 1;
    2f69:	c7 05 28 02 00 00 01 00 00 00 	mov    DWORD PTR ds:0x228,0x1
				break;
    2f73:	e9 a3 00 00 00       	jmp    301b <calc_fun+0x130>
			case 3:
				calc_print = 1;
    2f78:	c7 05 30 02 00 00 01 00 00 00 	mov    DWORD PTR ds:0x230,0x1
				break;
    2f82:	e9 94 00 00 00       	jmp    301b <calc_fun+0x130>
			case 4:
				calc_print = 2;
    2f87:	c7 05 30 02 00 00 02 00 00 00 	mov    DWORD PTR ds:0x230,0x2
				break;
    2f91:	e9 85 00 00 00       	jmp    301b <calc_fun+0x130>
			case 5:
				if (calc_thr)
    2f96:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2f9b:	85 c0                	test   eax,eax
    2f9d:	74 6f                	je     300e <calc_fun+0x123>
						calc_thr++;
    2f9f:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2fa4:	83 c0 01             	add    eax,0x1
    2fa7:	a3 2c 02 00 00       	mov    ds:0x22c,eax
				break;
    2fac:	eb 60                	jmp    300e <calc_fun+0x123>
			case 6:
				if (calc_thr)
    2fae:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2fb3:	85 c0                	test   eax,eax
    2fb5:	74 5a                	je     3011 <calc_fun+0x126>
						calc_thr += 5;
    2fb7:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2fbc:	83 c0 05             	add    eax,0x5
    2fbf:	a3 2c 02 00 00       	mov    ds:0x22c,eax
				break;
    2fc4:	eb 4b                	jmp    3011 <calc_fun+0x126>
			case 7:
				if (calc_thr)
    2fc6:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2fcb:	85 c0                	test   eax,eax
    2fcd:	74 45                	je     3014 <calc_fun+0x129>
						calc_thr += 15;
    2fcf:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2fd4:	83 c0 0f             	add    eax,0xf
    2fd7:	a3 2c 02 00 00       	mov    ds:0x22c,eax
				break;
    2fdc:	eb 36                	jmp    3014 <calc_fun+0x129>
			case 8:
				if (calc_thr)
    2fde:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2fe3:	85 c0                	test   eax,eax
    2fe5:	74 30                	je     3017 <calc_fun+0x12c>
						calc_thr--;
    2fe7:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2fec:	83 e8 01             	sub    eax,0x1
    2fef:	a3 2c 02 00 00       	mov    ds:0x22c,eax
				break;
    2ff4:	eb 21                	jmp    3017 <calc_fun+0x12c>
			case 9:
				if (calc_thr)
    2ff6:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    2ffb:	85 c0                	test   eax,eax
    2ffd:	74 1b                	je     301a <calc_fun+0x12f>
						calc_thr -= 5;
    2fff:	a1 2c 02 00 00       	mov    eax,ds:0x22c
    3004:	83 e8 05             	sub    eax,0x5
    3007:	a3 2c 02 00 00       	mov    ds:0x22c,eax
				break;
    300c:	eb 0c                	jmp    301a <calc_fun+0x12f>
				break;
    300e:	90                   	nop
    300f:	eb 0a                	jmp    301b <calc_fun+0x130>
				break;
    3011:	90                   	nop
    3012:	eb 07                	jmp    301b <calc_fun+0x130>
				break;
    3014:	90                   	nop
    3015:	eb 04                	jmp    301b <calc_fun+0x130>
				break;
    3017:	90                   	nop
    3018:	eb 01                	jmp    301b <calc_fun+0x130>
				break;
    301a:	90                   	nop
		}
}
    301b:	90                   	nop
    301c:	c9                   	leave
    301d:	c3                   	ret

0000301e <enable_sse>:
		} while ((unsigned int)((double)(counter - now) / CLOCKS_PER_SEC) < seconds);
		return 0;
}*/

void enable_sse()
{
    301e:	55                   	push   ebp
    301f:	89 e5                	mov    ebp,esp
    3021:	53                   	push   ebx
    3022:	83 ec 10             	sub    esp,0x10
		/* enable SSE if present */
		uint32_t eax, ebx, ecx, edx;
		__cpuid(1, eax, ebx, ecx, edx);
    3025:	b8 01 00 00 00       	mov    eax,0x1
    302a:	b9 00 00 00 00       	mov    ecx,0x0
    302f:	ba 00 00 00 00       	mov    edx,0x0
    3034:	89 cb                	mov    ebx,ecx
    3036:	89 d1                	mov    ecx,edx
    3038:	0f a2                	cpuid
    303a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    303d:	89 5d f4             	mov    DWORD PTR [ebp-0xc],ebx
    3040:	89 4d f0             	mov    DWORD PTR [ebp-0x10],ecx
    3043:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		if (edx & (1<< 25)) {
    3046:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    3049:	25 00 00 00 02       	and    eax,0x2000000
    304e:	85 c0                	test   eax,eax
    3050:	74 17                	je     3069 <enable_sse+0x4b>
					"mov %%cr4, %%rax\n"
					"or $0x0600, %%ax\n"
					"mov %%rax, %%cr4\n"
					: : : "rax");
#else
				asm("mov %%cr0, %%eax\n"
    3052:	0f 20 c0             	mov    eax,cr0
    3055:	83 c8 02             	or     eax,0x2
    3058:	83 e0 fb             	and    eax,0xfffffffb
    305b:	0f 22 c0             	mov    cr0,eax
					"or $2, %%eax\n"
					"and $0xfffffffb, %%eax\n"
					"mov %%eax, %%cr0\n"
					: : : "eax"); /* clear em(2); set mp(1) bit */
				asm("mov %%cr4, %%eax\n"
    305e:	0f 20 e0             	mov    eax,cr4
    3061:	0d 00 06 00 00       	or     eax,0x600
    3066:	0f 22 e0             	mov    cr4,eax
					"or $0x00000600, %%eax\n"
					"mov %%eax, %%cr4\n"
					: : : "eax"); /* set oxfxsr osxmmexcpt */
#endif
		}
}
    3069:	90                   	nop
    306a:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    306d:	c9                   	leave
    306e:	c3                   	ret

0000306f <do_cpuid>:

void do_cpuid()
{
    306f:	55                   	push   ebp
    3070:	89 e5                	mov    ebp,esp
    3072:	53                   	push   ebx
    3073:	83 ec 20             	sub    esp,0x20
		uint32_t eax, ebx, ecx, edx;
		cpu.max_leaf = __get_cpuid_max(0, NULL);
    3076:	6a 00                	push   0x0
    3078:	6a 00                	push   0x0
    307a:	e8 35 d0 ff ff       	call   b4 <__get_cpuid_max>
    307f:	83 c4 08             	add    esp,0x8
    3082:	a3 00 00 00 00       	mov    ds:0x0,eax
		cpu.max_eleaf = __get_cpuid_max(0x80000000, NULL);
    3087:	6a 00                	push   0x0
    3089:	68 00 00 00 80       	push   0x80000000
    308e:	e8 21 d0 ff ff       	call   b4 <__get_cpuid_max>
    3093:	83 c4 08             	add    esp,0x8
    3096:	a3 04 00 00 00       	mov    ds:0x4,eax
		__cpuid(0, eax, ebx, ecx, edx);
    309b:	b8 00 00 00 00       	mov    eax,0x0
    30a0:	0f a2                	cpuid
    30a2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    30a5:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    30a8:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    30ab:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		((int*)cpu.vendor_id)[0] = ebx;
    30ae:	ba 0c 00 00 00       	mov    edx,0xc
    30b3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    30b6:	89 02                	mov    DWORD PTR [edx],eax
		((int*)cpu.vendor_id)[1] = edx;
    30b8:	ba 10 00 00 00       	mov    edx,0x10
    30bd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    30c0:	89 02                	mov    DWORD PTR [edx],eax
		((int*)cpu.vendor_id)[2] = ecx;
    30c2:	ba 14 00 00 00       	mov    edx,0x14
    30c7:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    30ca:	89 02                	mov    DWORD PTR [edx],eax
		((int*)cpu.vendor_id)[3] = 0;
    30cc:	b8 18 00 00 00       	mov    eax,0x18
    30d1:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		if (cpu.max_leaf > 0) {
    30d7:	a1 00 00 00 00       	mov    eax,ds:0x0
    30dc:	85 c0                	test   eax,eax
    30de:	74 41                	je     3121 <do_cpuid+0xb2>
				__cpuid(1, eax, ebx, ecx, edx);
    30e0:	b8 01 00 00 00       	mov    eax,0x1
    30e5:	b9 00 00 00 00       	mov    ecx,0x0
    30ea:	ba 00 00 00 00       	mov    edx,0x0
    30ef:	89 cb                	mov    ebx,ecx
    30f1:	89 d1                	mov    ecx,edx
    30f3:	0f a2                	cpuid
    30f5:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    30f8:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    30fb:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    30fe:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				cpu.feat_eax = eax;
    3101:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3104:	a3 4c 00 00 00       	mov    ds:0x4c,eax
				cpu.feat_ecx = ecx;
    3109:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    310c:	a3 54 00 00 00       	mov    ds:0x54,eax
				cpu.feat_edx = edx;
    3111:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3114:	a3 58 00 00 00       	mov    ds:0x58,eax
				cpu.feat_ebx = ebx;
    3119:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    311c:	a3 50 00 00 00       	mov    ds:0x50,eax
		}
		if (cpu.max_eleaf > 0x80000000) {
    3121:	a1 04 00 00 00       	mov    eax,ds:0x4
    3126:	3d 00 00 00 80       	cmp    eax,0x80000000
    312b:	76 33                	jbe    3160 <do_cpuid+0xf1>
				__cpuid(0x80000001, eax, ebx, ecx, edx);
    312d:	b8 01 00 00 80       	mov    eax,0x80000001
    3132:	0f a2                	cpuid
    3134:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    3137:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    313a:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    313d:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				cpu.efeat_eax = eax;
    3140:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3143:	a3 5c 00 00 00       	mov    ds:0x5c,eax
				cpu.efeat_ebx = ebx;
    3148:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    314b:	a3 60 00 00 00       	mov    ds:0x60,eax
				cpu.efeat_ecx = ecx;
    3150:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3153:	a3 64 00 00 00       	mov    ds:0x64,eax
				cpu.efeat_edx = edx;
    3158:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    315b:	a3 68 00 00 00       	mov    ds:0x68,eax
		}
		cpu.brand_string[0] = '\0';
    3160:	c6 05 1c 00 00 00 00 	mov    BYTE PTR ds:0x1c,0x0
		if (cpu.max_eleaf > 0x80000003) {
    3167:	a1 04 00 00 00       	mov    eax,ds:0x4
    316c:	3d 03 00 00 80       	cmp    eax,0x80000003
    3171:	76 76                	jbe    31e9 <do_cpuid+0x17a>
				/* get the brand string */
				uint32_t* pt = (uint32_t*)cpu.brand_string;
    3173:	c7 45 f8 1c 00 00 00 	mov    DWORD PTR [ebp-0x8],0x1c
				for (uint32_t i = 1; i < 4; i++) {
    317a:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
    3181:	eb 60                	jmp    31e3 <do_cpuid+0x174>
						__cpuid(0x80000001 + i, eax, ebx, ecx, edx);
    3183:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3186:	2d ff ff ff 7f       	sub    eax,0x7fffffff
    318b:	b9 00 00 00 00       	mov    ecx,0x0
    3190:	ba 00 00 00 00       	mov    edx,0x0
    3195:	89 cb                	mov    ebx,ecx
    3197:	89 d1                	mov    ecx,edx
    3199:	0f a2                	cpuid
    319b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    319e:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    31a1:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    31a4:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						*pt++ = eax;
    31a7:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    31aa:	8d 50 04             	lea    edx,[eax+0x4]
    31ad:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
    31b0:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    31b3:	89 10                	mov    DWORD PTR [eax],edx
						*pt++ = ebx;
    31b5:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    31b8:	8d 50 04             	lea    edx,[eax+0x4]
    31bb:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
    31be:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    31c1:	89 10                	mov    DWORD PTR [eax],edx
						*pt++ = ecx;
    31c3:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    31c6:	8d 50 04             	lea    edx,[eax+0x4]
    31c9:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
    31cc:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    31cf:	89 10                	mov    DWORD PTR [eax],edx
						*pt++ = edx;
    31d1:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    31d4:	8d 50 04             	lea    edx,[eax+0x4]
    31d7:	89 55 f8             	mov    DWORD PTR [ebp-0x8],edx
    31da:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    31dd:	89 10                	mov    DWORD PTR [eax],edx
				for (uint32_t i = 1; i < 4; i++) {
    31df:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    31e3:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    31e7:	76 9a                	jbe    3183 <do_cpuid+0x114>
				}
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
    31e9:	a1 04 00 00 00       	mov    eax,ds:0x4
    31ee:	3d 06 00 00 80       	cmp    eax,0x80000006
    31f3:	76 36                	jbe    322b <do_cpuid+0x1bc>
    31f5:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    31fc:	83 e0 10             	and    eax,0x10
    31ff:	84 c0                	test   al,al
    3201:	74 28                	je     322b <do_cpuid+0x1bc>
				/* get invariant tsc */
				__cpuid(0x80000007, eax, ebx, ecx, edx);
    3203:	b8 07 00 00 80       	mov    eax,0x80000007
    3208:	0f a2                	cpuid
    320a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    320d:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
    3210:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
    3213:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				cpu.invariant_tsc = !!(edx & (1 << 8));
    3216:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3219:	25 00 01 00 00       	and    eax,0x100
    321e:	85 c0                	test   eax,eax
    3220:	0f 95 c0             	setne  al
    3223:	0f b6 c0             	movzx  eax,al
    3226:	a3 6c 00 00 00       	mov    ds:0x6c,eax
		}

		/* FIXME: using enable_sse due to framebuffer on x64 */
		enable_sse();
    322b:	e8 fc ff ff ff       	call   322c <do_cpuid+0x1bd>
}
    3230:	90                   	nop
    3231:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    3234:	c9                   	leave
    3235:	c3                   	ret

00003236 <cpu_info>:
void cpu_info()
{
    3236:	55                   	push   ebp
    3237:	89 e5                	mov    ebp,esp
    3239:	83 ec 08             	sub    esp,0x8
		printf("This cpu is \"%s\" and supports %u cpuid leaves and %u extended cpuid leaves\n",
						cpu.vendor_id, cpu.max_leaf, cpu.max_eleaf - 0x80000000);
    323c:	a1 04 00 00 00       	mov    eax,ds:0x4
		printf("This cpu is \"%s\" and supports %u cpuid leaves and %u extended cpuid leaves\n",
    3241:	8d 90 00 00 00 80    	lea    edx,[eax-0x80000000]
    3247:	a1 00 00 00 00       	mov    eax,ds:0x0
    324c:	52                   	push   edx
    324d:	50                   	push   eax
    324e:	68 0c 00 00 00       	push   0xc
    3253:	68 04 0b 00 00       	push   0xb04
    3258:	e8 fc ff ff ff       	call   3259 <cpu_info+0x23>
    325d:	83 c4 10             	add    esp,0x10
		/* TODO: DBG! */
		//cpu.has_htt = 1;
		printf("Its main features are:\n");
    3260:	83 ec 0c             	sub    esp,0xc
    3263:	68 50 0b 00 00       	push   0xb50
    3268:	e8 fc ff ff ff       	call   3269 <cpu_info+0x33>
    326d:	83 c4 10             	add    esp,0x10
		if (cpu.has_htt)
    3270:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
    3277:	83 e0 10             	and    eax,0x10
    327a:	84 c0                	test   al,al
    327c:	74 10                	je     328e <cpu_info+0x58>
				printf("\tHyper-threading\n");
    327e:	83 ec 0c             	sub    esp,0xc
    3281:	68 68 0b 00 00       	push   0xb68
    3286:	e8 fc ff ff ff       	call   3287 <cpu_info+0x51>
    328b:	83 c4 10             	add    esp,0x10
		if (cpu.has_pae)
    328e:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    3295:	83 e0 40             	and    eax,0x40
    3298:	84 c0                	test   al,al
    329a:	74 10                	je     32ac <cpu_info+0x76>
				printf("\tPAE\n");
    329c:	83 ec 0c             	sub    esp,0xc
    329f:	68 7a 0b 00 00       	push   0xb7a
    32a4:	e8 fc ff ff ff       	call   32a5 <cpu_info+0x6f>
    32a9:	83 c4 10             	add    esp,0x10
		if (cpu.has_apic)
    32ac:	0f b6 05 59 00 00 00 	movzx  eax,BYTE PTR ds:0x59
    32b3:	83 e0 02             	and    eax,0x2
    32b6:	84 c0                	test   al,al
    32b8:	74 10                	je     32ca <cpu_info+0x94>
				printf("\tAPIC\n");
    32ba:	83 ec 0c             	sub    esp,0xc
    32bd:	68 80 0b 00 00       	push   0xb80
    32c2:	e8 fc ff ff ff       	call   32c3 <cpu_info+0x8d>
    32c7:	83 c4 10             	add    esp,0x10
		if (cpu.has_acpi)
    32ca:	0f b6 05 5a 00 00 00 	movzx  eax,BYTE PTR ds:0x5a
    32d1:	83 e0 40             	and    eax,0x40
    32d4:	84 c0                	test   al,al
    32d6:	74 10                	je     32e8 <cpu_info+0xb2>
				printf("\tACPI\n");
    32d8:	83 ec 0c             	sub    esp,0xc
    32db:	68 87 0b 00 00       	push   0xb87
    32e0:	e8 fc ff ff ff       	call   32e1 <cpu_info+0xab>
    32e5:	83 c4 10             	add    esp,0x10
		printf("All features are:\n");
    32e8:	83 ec 0c             	sub    esp,0xc
    32eb:	68 8e 0b 00 00       	push   0xb8e
    32f0:	e8 fc ff ff ff       	call   32f1 <cpu_info+0xbb>
    32f5:	83 c4 10             	add    esp,0x10
		printf("33222222222211111111110000000000\n");
    32f8:	83 ec 0c             	sub    esp,0xc
    32fb:	68 a4 0b 00 00       	push   0xba4
    3300:	e8 fc ff ff ff       	call   3301 <cpu_info+0xcb>
    3305:	83 c4 10             	add    esp,0x10
		printf("10987654321098765432109876543210\n");
    3308:	83 ec 0c             	sub    esp,0xc
    330b:	68 c8 0b 00 00       	push   0xbc8
    3310:	e8 fc ff ff ff       	call   3311 <cpu_info+0xdb>
    3315:	83 c4 10             	add    esp,0x10
		printf("%032b\n", cpu.feat_eax);
    3318:	a1 4c 00 00 00       	mov    eax,ds:0x4c
    331d:	83 ec 08             	sub    esp,0x8
    3320:	50                   	push   eax
    3321:	68 ea 0b 00 00       	push   0xbea
    3326:	e8 fc ff ff ff       	call   3327 <cpu_info+0xf1>
    332b:	83 c4 10             	add    esp,0x10
		printf("%032b\n", cpu.feat_ebx);
    332e:	a1 50 00 00 00       	mov    eax,ds:0x50
    3333:	83 ec 08             	sub    esp,0x8
    3336:	50                   	push   eax
    3337:	68 ea 0b 00 00       	push   0xbea
    333c:	e8 fc ff ff ff       	call   333d <cpu_info+0x107>
    3341:	83 c4 10             	add    esp,0x10
		printf("%032b\n", cpu.feat_ecx);
    3344:	a1 54 00 00 00       	mov    eax,ds:0x54
    3349:	83 ec 08             	sub    esp,0x8
    334c:	50                   	push   eax
    334d:	68 ea 0b 00 00       	push   0xbea
    3352:	e8 fc ff ff ff       	call   3353 <cpu_info+0x11d>
    3357:	83 c4 10             	add    esp,0x10
		printf("%032b\n", cpu.feat_edx);
    335a:	a1 58 00 00 00       	mov    eax,ds:0x58
    335f:	83 ec 08             	sub    esp,0x8
    3362:	50                   	push   eax
    3363:	68 ea 0b 00 00       	push   0xbea
    3368:	e8 fc ff ff ff       	call   3369 <cpu_info+0x133>
    336d:	83 c4 10             	add    esp,0x10
		if (cpu.max_eleaf > 0x80000000) {
    3370:	a1 04 00 00 00       	mov    eax,ds:0x4
    3375:	3d 00 00 00 80       	cmp    eax,0x80000000
    337a:	0f 86 f0 00 00 00    	jbe    3470 <cpu_info+0x23a>
				printf("The main extended features are:\n");
    3380:	83 ec 0c             	sub    esp,0xc
    3383:	68 f4 0b 00 00       	push   0xbf4
    3388:	e8 fc ff ff ff       	call   3389 <cpu_info+0x153>
    338d:	83 c4 10             	add    esp,0x10
				if (cpu.e_pat)
    3390:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
    3397:	83 e0 01             	and    eax,0x1
    339a:	84 c0                	test   al,al
    339c:	74 10                	je     33ae <cpu_info+0x178>
						printf("\tPAT\n");
    339e:	83 ec 0c             	sub    esp,0xc
    33a1:	68 15 0c 00 00       	push   0xc15
    33a6:	e8 fc ff ff ff       	call   33a7 <cpu_info+0x171>
    33ab:	83 c4 10             	add    esp,0x10
				if (cpu.e_has_mp)
    33ae:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
    33b5:	83 e0 08             	and    eax,0x8
    33b8:	84 c0                	test   al,al
    33ba:	74 10                	je     33cc <cpu_info+0x196>
						printf("\tMP capable\n");
    33bc:	83 ec 0c             	sub    esp,0xc
    33bf:	68 1b 0c 00 00       	push   0xc1b
    33c4:	e8 fc ff ff ff       	call   33c5 <cpu_info+0x18f>
    33c9:	83 c4 10             	add    esp,0x10
				if (cpu.e_has_nx)
    33cc:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
    33d3:	83 e0 10             	and    eax,0x10
    33d6:	84 c0                	test   al,al
    33d8:	74 10                	je     33ea <cpu_info+0x1b4>
						printf("\tNX bit\n");
    33da:	83 ec 0c             	sub    esp,0xc
    33dd:	68 28 0c 00 00       	push   0xc28
    33e2:	e8 fc ff ff ff       	call   33e3 <cpu_info+0x1ad>
    33e7:	83 c4 10             	add    esp,0x10
				if (cpu.e_has_longmode)
    33ea:	0f b6 05 6b 00 00 00 	movzx  eax,BYTE PTR ds:0x6b
    33f1:	83 e0 20             	and    eax,0x20
    33f4:	84 c0                	test   al,al
    33f6:	74 10                	je     3408 <cpu_info+0x1d2>
						printf("\tx86_64\n");
    33f8:	83 ec 0c             	sub    esp,0xc
    33fb:	68 31 0c 00 00       	push   0xc31
    3400:	e8 fc ff ff ff       	call   3401 <cpu_info+0x1cb>
    3405:	83 c4 10             	add    esp,0x10
				printf("All extended features:\n");
    3408:	83 ec 0c             	sub    esp,0xc
    340b:	68 3a 0c 00 00       	push   0xc3a
    3410:	e8 fc ff ff ff       	call   3411 <cpu_info+0x1db>
    3415:	83 c4 10             	add    esp,0x10
				printf("%032b\n", cpu.efeat_eax);
    3418:	a1 5c 00 00 00       	mov    eax,ds:0x5c
    341d:	83 ec 08             	sub    esp,0x8
    3420:	50                   	push   eax
    3421:	68 ea 0b 00 00       	push   0xbea
    3426:	e8 fc ff ff ff       	call   3427 <cpu_info+0x1f1>
    342b:	83 c4 10             	add    esp,0x10
				printf("%032b\n", cpu.efeat_ebx);
    342e:	a1 60 00 00 00       	mov    eax,ds:0x60
    3433:	83 ec 08             	sub    esp,0x8
    3436:	50                   	push   eax
    3437:	68 ea 0b 00 00       	push   0xbea
    343c:	e8 fc ff ff ff       	call   343d <cpu_info+0x207>
    3441:	83 c4 10             	add    esp,0x10
				printf("%032b\n", cpu.efeat_ecx);
    3444:	a1 64 00 00 00       	mov    eax,ds:0x64
    3449:	83 ec 08             	sub    esp,0x8
    344c:	50                   	push   eax
    344d:	68 ea 0b 00 00       	push   0xbea
    3452:	e8 fc ff ff ff       	call   3453 <cpu_info+0x21d>
    3457:	83 c4 10             	add    esp,0x10
				printf("%032b\n", cpu.efeat_edx);
    345a:	a1 68 00 00 00       	mov    eax,ds:0x68
    345f:	83 ec 08             	sub    esp,0x8
    3462:	50                   	push   eax
    3463:	68 ea 0b 00 00       	push   0xbea
    3468:	e8 fc ff ff ff       	call   3469 <cpu_info+0x233>
    346d:	83 c4 10             	add    esp,0x10
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
    3470:	a1 04 00 00 00       	mov    eax,ds:0x4
    3475:	3d 06 00 00 80       	cmp    eax,0x80000006
    347a:	76 34                	jbe    34b0 <cpu_info+0x27a>
    347c:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    3483:	83 e0 10             	and    eax,0x10
    3486:	84 c0                	test   al,al
    3488:	74 26                	je     34b0 <cpu_info+0x27a>
				printf("The CPU's TSC is %s rate\n", cpu.invariant_tsc ? "constant" : "variable");
    348a:	a1 6c 00 00 00       	mov    eax,ds:0x6c
    348f:	85 c0                	test   eax,eax
    3491:	74 07                	je     349a <cpu_info+0x264>
    3493:	b8 52 0c 00 00       	mov    eax,0xc52
    3498:	eb 05                	jmp    349f <cpu_info+0x269>
    349a:	b8 5b 0c 00 00       	mov    eax,0xc5b
    349f:	83 ec 08             	sub    esp,0x8
    34a2:	50                   	push   eax
    34a3:	68 64 0c 00 00       	push   0xc64
    34a8:	e8 fc ff ff ff       	call   34a9 <cpu_info+0x273>
    34ad:	83 c4 10             	add    esp,0x10
		}
		printf("The brand string is \"%s\"\n", cpu.brand_string);
    34b0:	83 ec 08             	sub    esp,0x8
    34b3:	68 1c 00 00 00       	push   0x1c
    34b8:	68 7e 0c 00 00       	push   0xc7e
    34bd:	e8 fc ff ff ff       	call   34be <cpu_info+0x288>
    34c2:	83 c4 10             	add    esp,0x10
}
    34c5:	90                   	nop
    34c6:	c9                   	leave
    34c7:	c3                   	ret

000034c8 <_start>:

extern void _start()
{
    34c8:	55                   	push   ebp
    34c9:	89 e5                	mov    ebp,esp
    34cb:	83 ec 08             	sub    esp,0x8
		extern int fb_no_malloc;
		/* set cpu to correct values */
		do_cpuid();
    34ce:	e8 fc ff ff ff       	call   34cf <_start+0x7>

		/* transfer the frambuffer mappings */
		void fb_video_setup();
		fb_no_malloc = 1;
    34d3:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR ds:0x0,0x1
		fb_video_setup();
    34dd:	e8 fc ff ff ff       	call   34de <_start+0x16>

		/* transfer mmgr data from known locations */
		extern void mmgr_reinit();
		mmgr_reinit();
    34e2:	e8 fc ff ff ff       	call   34e3 <_start+0x1b>
		fb_no_malloc = 0;
    34e7:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0

		/* use the correct GDT */
		extern void gdt_init();
		gdt_init();
    34f1:	e8 fc ff ff ff       	call   34f2 <_start+0x2a>

		/* do the IDT setup & remap PIC */
		extern void mm_idt_init();
		mm_idt_init();
    34f6:	e8 fc ff ff ff       	call   34f7 <_start+0x2f>
		PIC_remap(0x20, 0x28);
    34fb:	83 ec 08             	sub    esp,0x8
    34fe:	6a 28                	push   0x28
    3500:	6a 20                	push   0x20
    3502:	e8 fc ff ff ff       	call   3503 <_start+0x3b>
    3507:	83 c4 10             	add    esp,0x10
		asm("sti");
    350a:	fb                   	sti

		/* protect null pointer */
		mm_unmap(&mm_kernel, NULL, 1);
    350b:	83 ec 04             	sub    esp,0x4
    350e:	6a 01                	push   0x1
    3510:	6a 00                	push   0x0
    3512:	68 00 00 00 00       	push   0x0
    3517:	e8 fc ff ff ff       	call   3518 <_start+0x50>
    351c:	83 c4 10             	add    esp,0x10

		/* print cpu info */
		cpu_info();
    351f:	e8 fc ff ff ff       	call   3520 <_start+0x58>
		/* timekeeping setup */
		timer_setup();
    3524:	e8 fc ff ff ff       	call   3525 <_start+0x5d>
		/* enable preemption (needed for MP init stacks) */
		/* enable preemption (calls kinit and never returns) */
		printf("starting preemption...\n");
    3529:	83 ec 0c             	sub    esp,0xc
    352c:	68 98 0c 00 00       	push   0xc98
    3531:	e8 fc ff ff ff       	call   3532 <_start+0x6a>
    3536:	83 c4 10             	add    esp,0x10
		void preempt_init();
		preempt_init();
    3539:	e8 fc ff ff ff       	call   353a <_start+0x72>

		cprintf(KFMT_ERROR, "preempt_init returned\n");
    353e:	83 ec 08             	sub    esp,0x8
    3541:	68 b0 0c 00 00       	push   0xcb0
    3546:	6a 0c                	push   0xc
    3548:	e8 fc ff ff ff       	call   3549 <_start+0x81>
    354d:	83 c4 10             	add    esp,0x10
		while (1);
    3550:	90                   	nop
    3551:	eb fd                	jmp    3550 <_start+0x88>

00003553 <kinit>:
}

void kinit(void* data)
{
    3553:	55                   	push   ebp
    3554:	89 e5                	mov    ebp,esp
    3556:	83 ec 28             	sub    esp,0x28
		cprintf(KFMT_OK, "kernel is now preemptive\n");
    3559:	83 ec 08             	sub    esp,0x8
    355c:	68 c7 0c 00 00       	push   0xcc7
    3561:	6a 0a                	push   0xa
    3563:	e8 fc ff ff ff       	call   3564 <kinit+0x11>
    3568:	83 c4 10             	add    esp,0x10
		/* APIC and MP init */
		if (cpu.has_apic) {
    356b:	0f b6 05 59 00 00 00 	movzx  eax,BYTE PTR ds:0x59
    3572:	83 e0 02             	and    eax,0x2
    3575:	84 c0                	test   al,al
    3577:	74 05                	je     357e <kinit+0x2b>
				extern void apic_init(); /* PCP works afterwards */
				apic_init();
    3579:	e8 fc ff ff ff       	call   357a <kinit+0x27>
		}
		region_clear(&km_regS);
    357e:	83 ec 0c             	sub    esp,0xc
    3581:	68 00 00 00 00       	push   0x0
    3586:	e8 fc ff ff ff       	call   3587 <kinit+0x34>
    358b:	83 c4 10             	add    esp,0x10
		km_regS.cur_x = km_regS.cur_y = 0;
    358e:	66 c7 05 10 00 00 00 00 00 	mov    WORD PTR ds:0x10,0x0
    3597:	0f b7 05 10 00 00 00 	movzx  eax,WORD PTR ds:0x10
    359e:	66 a3 0e 00 00 00    	mov    ds:0xe,ax
		region_puts(&km_regS, "total used  hp free\n\nup: ");
    35a4:	83 ec 08             	sub    esp,0x8
    35a7:	68 e1 0c 00 00       	push   0xce1
    35ac:	68 00 00 00 00       	push   0x0
    35b1:	e8 fc ff ff ff       	call   35b2 <kinit+0x5f>
    35b6:	83 c4 10             	add    esp,0x10
		/* Hardware detection and initialization */
		kbd_init();
    35b9:	e8 fc ff ff ff       	call   35ba <kinit+0x67>
		{
				char bt;
				printf("VGA IO base port (from 0x0463): %x\n", *(uint16_t*)(0x463));
    35be:	b8 63 04 00 00       	mov    eax,0x463
    35c3:	0f b7 00             	movzx  eax,WORD PTR [eax]
    35c6:	0f b7 c0             	movzx  eax,ax
    35c9:	83 ec 08             	sub    esp,0x8
    35cc:	50                   	push   eax
    35cd:	68 fc 0c 00 00       	push   0xcfc
    35d2:	e8 fc ff ff ff       	call   35d3 <kinit+0x80>
    35d7:	83 c4 10             	add    esp,0x10
				bt = inb(0x3cc);
    35da:	83 ec 0c             	sub    esp,0xc
    35dd:	68 cc 03 00 00       	push   0x3cc
    35e2:	e8 59 ca ff ff       	call   40 <inb>
    35e7:	83 c4 10             	add    esp,0x10
    35ea:	88 45 eb             	mov    BYTE PTR [ebp-0x15],al
				printf("VGA misc flags: %08b\n", bt);
    35ed:	0f be 45 eb          	movsx  eax,BYTE PTR [ebp-0x15]
    35f1:	83 ec 08             	sub    esp,0x8
    35f4:	50                   	push   eax
    35f5:	68 20 0d 00 00       	push   0xd20
    35fa:	e8 fc ff ff ff       	call   35fb <kinit+0xa8>
    35ff:	83 c4 10             	add    esp,0x10
/*				sleep(0);
				}*/
		}
		/* List the serial and printer ports */
		{
				uint16_t* ptr = (uint16_t*)0x400; int i;
    3602:	c7 45 e4 00 04 00 00 	mov    DWORD PTR [ebp-0x1c],0x400
				for (i = 0; i < 7; i++)
    3609:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    3610:	e9 b1 00 00 00       	jmp    36c6 <kinit+0x173>
						if (ptr[i])
    3615:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3618:	8d 14 00             	lea    edx,[eax+eax*1]
    361b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    361e:	01 d0                	add    eax,edx
    3620:	0f b7 00             	movzx  eax,WORD PTR [eax]
    3623:	66 85 c0             	test   ax,ax
    3626:	74 64                	je     368c <kinit+0x139>
								if (i < 4) {
    3628:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    362c:	7f 3b                	jg     3669 <kinit+0x116>
										printf("COM%d IO port: %u\n", i + 1, *ptr);
    362e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3631:	0f b7 00             	movzx  eax,WORD PTR [eax]
    3634:	0f b7 c0             	movzx  eax,ax
    3637:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    363a:	83 c2 01             	add    edx,0x1
    363d:	83 ec 04             	sub    esp,0x4
    3640:	50                   	push   eax
    3641:	52                   	push   edx
    3642:	68 36 0d 00 00       	push   0xd36
    3647:	e8 fc ff ff ff       	call   3648 <kinit+0xf5>
    364c:	83 c4 10             	add    esp,0x10
										enable_com(i, *ptr);
    364f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3652:	0f b7 00             	movzx  eax,WORD PTR [eax]
    3655:	0f b7 c0             	movzx  eax,ax
    3658:	83 ec 08             	sub    esp,0x8
    365b:	50                   	push   eax
    365c:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    365f:	e8 fc ff ff ff       	call   3660 <kinit+0x10d>
    3664:	83 c4 10             	add    esp,0x10
    3667:	eb 59                	jmp    36c2 <kinit+0x16f>
								} else
										printf("LPT%d IO port: %u\n", i - 3, *ptr);
    3669:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    366c:	0f b7 00             	movzx  eax,WORD PTR [eax]
    366f:	0f b7 c0             	movzx  eax,ax
    3672:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    3675:	83 ea 03             	sub    edx,0x3
    3678:	83 ec 04             	sub    esp,0x4
    367b:	50                   	push   eax
    367c:	52                   	push   edx
    367d:	68 49 0d 00 00       	push   0xd49
    3682:	e8 fc ff ff ff       	call   3683 <kinit+0x130>
    3687:	83 c4 10             	add    esp,0x10
    368a:	eb 36                	jmp    36c2 <kinit+0x16f>
						else
								if (i < 4)
    368c:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    3690:	7f 19                	jg     36ab <kinit+0x158>
										printf("COM%d not present\n", i + 1);
    3692:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3695:	83 c0 01             	add    eax,0x1
    3698:	83 ec 08             	sub    esp,0x8
    369b:	50                   	push   eax
    369c:	68 5c 0d 00 00       	push   0xd5c
    36a1:	e8 fc ff ff ff       	call   36a2 <kinit+0x14f>
    36a6:	83 c4 10             	add    esp,0x10
    36a9:	eb 17                	jmp    36c2 <kinit+0x16f>
								else
										printf("LPT%d not present\n", i - 3);
    36ab:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    36ae:	83 e8 03             	sub    eax,0x3
    36b1:	83 ec 08             	sub    esp,0x8
    36b4:	50                   	push   eax
    36b5:	68 6f 0d 00 00       	push   0xd6f
    36ba:	e8 fc ff ff ff       	call   36bb <kinit+0x168>
    36bf:	83 c4 10             	add    esp,0x10
				for (i = 0; i < 7; i++)
    36c2:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    36c6:	83 7d f4 06          	cmp    DWORD PTR [ebp-0xc],0x6
    36ca:	0f 8e 45 ff ff ff    	jle    3615 <kinit+0xc2>
		}
		/* Floppy devices */
		{
				uint8_t bt = cmos_get_register(0x10);
    36d0:	83 ec 0c             	sub    esp,0xc
    36d3:	6a 10                	push   0x10
    36d5:	e8 fc ff ff ff       	call   36d6 <kinit+0x183>
    36da:	83 c4 10             	add    esp,0x10
    36dd:	88 45 e3             	mov    BYTE PTR [ebp-0x1d],al
				uint8_t btM = (bt & 0xf0) >> 4;
    36e0:	0f b6 45 e3          	movzx  eax,BYTE PTR [ebp-0x1d]
    36e4:	c0 e8 04             	shr    al,0x4
    36e7:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
				bt &= 0x0f;
    36ea:	80 65 e3 0f          	and    BYTE PTR [ebp-0x1d],0xf
				do {
						const char* drv;
						switch (btM != 0xff ? btM : bt) {
    36ee:	80 7d f3 ff          	cmp    BYTE PTR [ebp-0xd],0xff
    36f2:	74 06                	je     36fa <kinit+0x1a7>
    36f4:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
    36f8:	eb 04                	jmp    36fe <kinit+0x1ab>
    36fa:	0f b6 45 e3          	movzx  eax,BYTE PTR [ebp-0x1d]
    36fe:	83 f8 05             	cmp    eax,0x5
    3701:	77 3f                	ja     3742 <kinit+0x1ef>
    3703:	8b 04 85 10 0e 00 00 	mov    eax,DWORD PTR [eax*4+0xe10]
    370a:	ff e0                	jmp    eax
								case 0:
										drv = "no drive";
    370c:	c7 45 ec 82 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xd82
										break;
    3713:	eb 35                	jmp    374a <kinit+0x1f7>
								case 1:
										drv = "360KiB 5.25\" drive";
    3715:	c7 45 ec 8b 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xd8b
										break;
    371c:	eb 2c                	jmp    374a <kinit+0x1f7>
								case 2:
										drv = "1.2MiB 5.25\" drive";
    371e:	c7 45 ec 9e 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xd9e
										break;
    3725:	eb 23                	jmp    374a <kinit+0x1f7>
								case 3:
										drv = "720KiB 3.5\" drive";
    3727:	c7 45 ec b1 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xdb1
										break;
    372e:	eb 1a                	jmp    374a <kinit+0x1f7>
								case 4:
										drv = "1.44MiB 3.5\" drive";
    3730:	c7 45 ec c3 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xdc3
										break;
    3737:	eb 11                	jmp    374a <kinit+0x1f7>
								case 5:
										drv = "2.88MiB 3.5\" drive";
    3739:	c7 45 ec d6 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xdd6
										break;
    3740:	eb 08                	jmp    374a <kinit+0x1f7>
								default:
										drv = "unknown";
    3742:	c7 45 ec e9 0d 00 00 	mov    DWORD PTR [ebp-0x14],0xde9
										break;
    3749:	90                   	nop
						}
						printf("Floppy %s: %s\n", btM != 0xff ? "master" : "slave", drv);
    374a:	80 7d f3 ff          	cmp    BYTE PTR [ebp-0xd],0xff
    374e:	74 07                	je     3757 <kinit+0x204>
    3750:	b8 f1 0d 00 00       	mov    eax,0xdf1
    3755:	eb 05                	jmp    375c <kinit+0x209>
    3757:	b8 f8 0d 00 00       	mov    eax,0xdf8
    375c:	83 ec 04             	sub    esp,0x4
    375f:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    3762:	50                   	push   eax
    3763:	68 fe 0d 00 00       	push   0xdfe
    3768:	e8 fc ff ff ff       	call   3769 <kinit+0x216>
    376d:	83 c4 10             	add    esp,0x10
						if (btM == 0xff)
    3770:	80 7d f3 ff          	cmp    BYTE PTR [ebp-0xd],0xff
    3774:	74 09                	je     377f <kinit+0x22c>
								break;
						btM = 0xff;
    3776:	c6 45 f3 ff          	mov    BYTE PTR [ebp-0xd],0xff
				do {
    377a:	e9 6f ff ff ff       	jmp    36ee <kinit+0x19b>
								break;
    377f:	90                   	nop
		}

		/* PCI enumeration */
		void load_modules();
		void fun();
		fun();
    3780:	e8 fc ff ff ff       	call   3781 <kinit+0x22e>
		load_modules();
    3785:	e8 fc ff ff ff       	call   3786 <kinit+0x233>

		/* now go to the loop */
		void kloop();
		kloop();
    378a:	e8 fc ff ff ff       	call   378b <kinit+0x238>
}
    378f:	90                   	nop
    3790:	c9                   	leave
    3791:	c3                   	ret

00003792 <kscrub>:

/* performs scrubbing of pages at low priority */
void kscrub(void* data)
{
    3792:	55                   	push   ebp
    3793:	89 e5                	mov    ebp,esp
    3795:	83 ec 08             	sub    esp,0x8
		while (1) {/* need_resched is checked periodically inside */
				extern struct wait_queue_head wq_timer;
				if (!mm_page_scrub())
    3798:	e8 fc ff ff ff       	call   3799 <kscrub+0x7>
    379d:	85 c0                	test   eax,eax
    379f:	75 f7                	jne    3798 <kscrub+0x6>
						wait_timeout(&wq_timer, HZ);
    37a1:	83 ec 08             	sub    esp,0x8
    37a4:	6a 79                	push   0x79
    37a6:	68 00 00 00 00       	push   0x0
    37ab:	e8 fc ff ff ff       	call   37ac <kscrub+0x1a>
    37b0:	83 c4 10             	add    esp,0x10
		while (1) {/* need_resched is checked periodically inside */
    37b3:	eb e3                	jmp    3798 <kscrub+0x6>

000037b5 <kloop>:
		}
}

void kloop()
{
    37b5:	55                   	push   ebp
    37b6:	89 e5                	mov    ebp,esp
    37b8:	53                   	push   ebx
    37b9:	81 ec 14 01 00 00    	sub    esp,0x114
		/* file_cli */
		int (*fptr)(const char*) = locate_module_function("file_cli");
    37bf:	83 ec 0c             	sub    esp,0xc
    37c2:	68 28 0e 00 00       	push   0xe28
    37c7:	e8 fc ff ff ff       	call   37c8 <kloop+0x13>
    37cc:	83 c4 10             	add    esp,0x10
    37cf:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		void list_modules();
		void list_module_info(const char*);

		/* main loop */
		while (1) {
				char* str = 0; size_t n = 0;
    37d2:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x0
    37d9:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [ebp-0x40],0x0
				printf("enter text:\n");
    37e0:	83 ec 0c             	sub    esp,0xc
    37e3:	68 31 0e 00 00       	push   0xe31
    37e8:	e8 fc ff ff ff       	call   37e9 <kloop+0x34>
    37ed:	83 c4 10             	add    esp,0x10
				getline(&str, &n);
    37f0:	83 ec 08             	sub    esp,0x8
    37f3:	8d 45 c0             	lea    eax,[ebp-0x40]
    37f6:	50                   	push   eax
    37f7:	8d 45 c4             	lea    eax,[ebp-0x3c]
    37fa:	50                   	push   eax
    37fb:	e8 fc ff ff ff       	call   37fc <kloop+0x47>
    3800:	83 c4 10             	add    esp,0x10
				if (str) {
    3803:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3806:	85 c0                	test   eax,eax
    3808:	74 c8                	je     37d2 <kloop+0x1d>
						char* s2 = str;
    380a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    380d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						while (*s2++);
    3810:	90                   	nop
    3811:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3814:	8d 50 01             	lea    edx,[eax+0x1]
    3817:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    381a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    381d:	84 c0                	test   al,al
    381f:	75 f0                	jne    3811 <kloop+0x5c>
						if (s2 - 2 >= str)
    3821:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3824:	8d 50 fe             	lea    edx,[eax-0x2]
    3827:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    382a:	39 c2                	cmp    edx,eax
    382c:	72 09                	jb     3837 <kloop+0x82>
								*(s2 - 2) = '\0';
    382e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3831:	83 e8 02             	sub    eax,0x2
    3834:	c6 00 00             	mov    BYTE PTR [eax],0x0
						if (strcmp(str, "pt") == 0) {
    3837:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    383a:	83 ec 08             	sub    esp,0x8
    383d:	68 3e 0e 00 00       	push   0xe3e
    3842:	50                   	push   eax
    3843:	e8 fc ff ff ff       	call   3844 <kloop+0x8f>
    3848:	83 c4 10             	add    esp,0x10
    384b:	85 c0                	test   eax,eax
    384d:	75 0a                	jne    3859 <kloop+0xa4>
								/* print tasks */
								void print_tasks();
								print_tasks();
    384f:	e8 fc ff ff ff       	call   3850 <kloop+0x9b>
    3854:	e9 ad 07 00 00       	jmp    4006 <kloop+0x851>
						} else if (strncmp(str, "calc", 4) == 0) {
    3859:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    385c:	83 ec 04             	sub    esp,0x4
    385f:	6a 04                	push   0x4
    3861:	68 41 0e 00 00       	push   0xe41
    3866:	50                   	push   eax
    3867:	e8 fc ff ff ff       	call   3868 <kloop+0xb3>
    386c:	83 c4 10             	add    esp,0x10
    386f:	85 c0                	test   eax,eax
    3871:	75 17                	jne    388a <kloop+0xd5>
								/* start/stop show the calculations */
								calc_fun(str + 5);
    3873:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3876:	83 c0 05             	add    eax,0x5
    3879:	83 ec 0c             	sub    esp,0xc
    387c:	50                   	push   eax
    387d:	e8 fc ff ff ff       	call   387e <kloop+0xc9>
    3882:	83 c4 10             	add    esp,0x10
    3885:	e9 7c 07 00 00       	jmp    4006 <kloop+0x851>
						} else if (strcmp(str, "rds") == 0) {
    388a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    388d:	83 ec 08             	sub    esp,0x8
    3890:	68 46 0e 00 00       	push   0xe46
    3895:	50                   	push   eax
    3896:	e8 fc ff ff ff       	call   3897 <kloop+0xe2>
    389b:	83 c4 10             	add    esp,0x10
    389e:	85 c0                	test   eax,eax
    38a0:	0f 85 12 01 00 00    	jne    39b8 <kloop+0x203>
								//framebuffer_redraw(&fb_initial);
								printf("%d %d\n", video_mode.width, video_mode.height);
    38a6:	8b 15 08 00 00 00    	mov    edx,DWORD PTR ds:0x8
    38ac:	a1 04 00 00 00       	mov    eax,ds:0x4
    38b1:	83 ec 04             	sub    esp,0x4
    38b4:	52                   	push   edx
    38b5:	50                   	push   eax
    38b6:	68 4a 0e 00 00       	push   0xe4a
    38bb:	e8 fc ff ff ff       	call   38bc <kloop+0x107>
    38c0:	83 c4 10             	add    esp,0x10
								printf("%d %d\n", fb_initial.cho_x, fb_initial.cho_y);
    38c3:	8b 15 28 00 00 00    	mov    edx,DWORD PTR ds:0x28
    38c9:	a1 24 00 00 00       	mov    eax,ds:0x24
    38ce:	83 ec 04             	sub    esp,0x4
    38d1:	52                   	push   edx
    38d2:	50                   	push   eax
    38d3:	68 4a 0e 00 00       	push   0xe4a
    38d8:	e8 fc ff ff ff       	call   38d9 <kloop+0x124>
    38dd:	83 c4 10             	add    esp,0x10
								printf("%d %d\n", fb_initial.chw_x, fb_initial.chw_y);
    38e0:	8b 15 30 00 00 00    	mov    edx,DWORD PTR ds:0x30
    38e6:	a1 2c 00 00 00       	mov    eax,ds:0x2c
    38eb:	83 ec 04             	sub    esp,0x4
    38ee:	52                   	push   edx
    38ef:	50                   	push   eax
    38f0:	68 4a 0e 00 00       	push   0xe4a
    38f5:	e8 fc ff ff ff       	call   38f6 <kloop+0x141>
    38fa:	83 c4 10             	add    esp,0x10
								printf("%d %d\n", fb_initial.width, fb_initial.height);
    38fd:	8b 15 08 00 00 00    	mov    edx,DWORD PTR ds:0x8
    3903:	a1 04 00 00 00       	mov    eax,ds:0x4
    3908:	83 ec 04             	sub    esp,0x4
    390b:	52                   	push   edx
    390c:	50                   	push   eax
    390d:	68 4a 0e 00 00       	push   0xe4a
    3912:	e8 fc ff ff ff       	call   3913 <kloop+0x15e>
    3917:	83 c4 10             	add    esp,0x10
								printf("regions:\n");
    391a:	83 ec 0c             	sub    esp,0xc
    391d:	68 51 0e 00 00       	push   0xe51
    3922:	e8 fc ff ff ff       	call   3923 <kloop+0x16e>
    3927:	83 c4 10             	add    esp,0x10
								printf("km_regC: %d %d %d %d\n", km_regC.x, km_regC.y, km_regC.lx, km_regC.ly);
    392a:	0f b7 05 06 00 00 00 	movzx  eax,WORD PTR ds:0x6
    3931:	0f bf d8             	movsx  ebx,ax
    3934:	0f b7 05 04 00 00 00 	movzx  eax,WORD PTR ds:0x4
    393b:	0f bf c8             	movsx  ecx,ax
    393e:	0f b7 05 02 00 00 00 	movzx  eax,WORD PTR ds:0x2
    3945:	0f bf d0             	movsx  edx,ax
    3948:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
    394f:	98                   	cwde
    3950:	83 ec 0c             	sub    esp,0xc
    3953:	53                   	push   ebx
    3954:	51                   	push   ecx
    3955:	52                   	push   edx
    3956:	50                   	push   eax
    3957:	68 5b 0e 00 00       	push   0xe5b
    395c:	e8 fc ff ff ff       	call   395d <kloop+0x1a8>
    3961:	83 c4 20             	add    esp,0x20
								printf("km_regS: %d %d %d %d\n", km_regS.x, km_regS.y, km_regS.lx, km_regS.ly);
    3964:	0f b7 05 06 00 00 00 	movzx  eax,WORD PTR ds:0x6
    396b:	0f bf d8             	movsx  ebx,ax
    396e:	0f b7 05 04 00 00 00 	movzx  eax,WORD PTR ds:0x4
    3975:	0f bf c8             	movsx  ecx,ax
    3978:	0f b7 05 02 00 00 00 	movzx  eax,WORD PTR ds:0x2
    397f:	0f bf d0             	movsx  edx,ax
    3982:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
    3989:	98                   	cwde
    398a:	83 ec 0c             	sub    esp,0xc
    398d:	53                   	push   ebx
    398e:	51                   	push   ecx
    398f:	52                   	push   edx
    3990:	50                   	push   eax
    3991:	68 71 0e 00 00       	push   0xe71
    3996:	e8 fc ff ff ff       	call   3997 <kloop+0x1e2>
    399b:	83 c4 20             	add    esp,0x20
								framebuffer_update_region(&fb_initial, &km_regC);
    399e:	83 ec 08             	sub    esp,0x8
    39a1:	68 00 00 00 00       	push   0x0
    39a6:	68 00 00 00 00       	push   0x0
    39ab:	e8 fc ff ff ff       	call   39ac <kloop+0x1f7>
    39b0:	83 c4 10             	add    esp,0x10
    39b3:	e9 4e 06 00 00       	jmp    4006 <kloop+0x851>
						} else if (strcmp(str, "time") == 0) {
    39b8:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    39bb:	83 ec 08             	sub    esp,0x8
    39be:	68 87 0e 00 00       	push   0xe87
    39c3:	50                   	push   eax
    39c4:	e8 fc ff ff ff       	call   39c5 <kloop+0x210>
    39c9:	83 c4 10             	add    esp,0x10
    39cc:	85 c0                	test   eax,eax
    39ce:	0f 85 ae 01 00 00    	jne    3b82 <kloop+0x3cd>
								struct timespec tsp; struct tm* ts = &km_time;
    39d4:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
								km_time = cmos_get_time();
    39db:	8d 85 e8 fe ff ff    	lea    eax,[ebp-0x118]
    39e1:	83 ec 0c             	sub    esp,0xc
    39e4:	50                   	push   eax
    39e5:	e8 fc ff ff ff       	call   39e6 <kloop+0x231>
    39ea:	83 c4 0c             	add    esp,0xc
    39ed:	8b 85 e8 fe ff ff    	mov    eax,DWORD PTR [ebp-0x118]
    39f3:	a3 00 00 00 00       	mov    ds:0x0,eax
    39f8:	8b 85 ec fe ff ff    	mov    eax,DWORD PTR [ebp-0x114]
    39fe:	a3 04 00 00 00       	mov    ds:0x4,eax
    3a03:	8b 85 f0 fe ff ff    	mov    eax,DWORD PTR [ebp-0x110]
    3a09:	a3 08 00 00 00       	mov    ds:0x8,eax
    3a0e:	8b 85 f4 fe ff ff    	mov    eax,DWORD PTR [ebp-0x10c]
    3a14:	a3 0c 00 00 00       	mov    ds:0xc,eax
    3a19:	8b 85 f8 fe ff ff    	mov    eax,DWORD PTR [ebp-0x108]
    3a1f:	a3 10 00 00 00       	mov    ds:0x10,eax
    3a24:	8b 85 fc fe ff ff    	mov    eax,DWORD PTR [ebp-0x104]
    3a2a:	a3 14 00 00 00       	mov    ds:0x14,eax
    3a2f:	8b 85 00 ff ff ff    	mov    eax,DWORD PTR [ebp-0x100]
    3a35:	a3 18 00 00 00       	mov    ds:0x18,eax
    3a3a:	8b 85 04 ff ff ff    	mov    eax,DWORD PTR [ebp-0xfc]
    3a40:	a3 1c 00 00 00       	mov    ds:0x1c,eax
    3a45:	8b 85 08 ff ff ff    	mov    eax,DWORD PTR [ebp-0xf8]
    3a4b:	a3 20 00 00 00       	mov    ds:0x20,eax
								km_set = jiffies;
    3a50:	a1 00 00 00 00       	mov    eax,ds:0x0
    3a55:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3a58:	8b 00                	mov    eax,DWORD PTR [eax]
    3a5a:	a3 00 00 00 00       	mov    ds:0x0,eax
    3a5f:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
								printf("upadting time from CMOS\n");
    3a65:	83 ec 0c             	sub    esp,0xc
    3a68:	68 8c 0e 00 00       	push   0xe8c
    3a6d:	e8 fc ff ff ff       	call   3a6e <kloop+0x2b9>
    3a72:	83 c4 10             	add    esp,0x10
								clock_gettime(CLOCK_REALTIME, &tsp);
    3a75:	83 ec 08             	sub    esp,0x8
    3a78:	8d 45 b4             	lea    eax,[ebp-0x4c]
    3a7b:	50                   	push   eax
    3a7c:	6a 00                	push   0x0
    3a7e:	e8 fc ff ff ff       	call   3a7f <kloop+0x2ca>
    3a83:	83 c4 10             	add    esp,0x10
								printf("UNIX time: %llu.%lu\n", tsp.tv_sec, tsp.tv_nsec);
    3a86:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    3a89:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    3a8c:	8b 55 b8             	mov    edx,DWORD PTR [ebp-0x48]
    3a8f:	51                   	push   ecx
    3a90:	52                   	push   edx
    3a91:	50                   	push   eax
    3a92:	68 a5 0e 00 00       	push   0xea5
    3a97:	e8 fc ff ff ff       	call   3a98 <kloop+0x2e3>
    3a9c:	83 c4 10             	add    esp,0x10
								printf("struct tm:\n");
    3a9f:	83 ec 0c             	sub    esp,0xc
    3aa2:	68 ba 0e 00 00       	push   0xeba
    3aa7:	e8 fc ff ff ff       	call   3aa8 <kloop+0x2f3>
    3aac:	83 c4 10             	add    esp,0x10
								printf("tm_sec %d\n", ts->tm_sec);
    3aaf:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3ab2:	8b 00                	mov    eax,DWORD PTR [eax]
    3ab4:	83 ec 08             	sub    esp,0x8
    3ab7:	50                   	push   eax
    3ab8:	68 c6 0e 00 00       	push   0xec6
    3abd:	e8 fc ff ff ff       	call   3abe <kloop+0x309>
    3ac2:	83 c4 10             	add    esp,0x10
								printf("tm_min %d\n", ts->tm_min);
    3ac5:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3ac8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3acb:	83 ec 08             	sub    esp,0x8
    3ace:	50                   	push   eax
    3acf:	68 d1 0e 00 00       	push   0xed1
    3ad4:	e8 fc ff ff ff       	call   3ad5 <kloop+0x320>
    3ad9:	83 c4 10             	add    esp,0x10
								printf("tm_hour %d\n", ts->tm_hour);
    3adc:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3adf:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3ae2:	83 ec 08             	sub    esp,0x8
    3ae5:	50                   	push   eax
    3ae6:	68 dc 0e 00 00       	push   0xedc
    3aeb:	e8 fc ff ff ff       	call   3aec <kloop+0x337>
    3af0:	83 c4 10             	add    esp,0x10
								printf("tm_mday %d\n", ts->tm_mday);
    3af3:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3af6:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    3af9:	83 ec 08             	sub    esp,0x8
    3afc:	50                   	push   eax
    3afd:	68 e8 0e 00 00       	push   0xee8
    3b02:	e8 fc ff ff ff       	call   3b03 <kloop+0x34e>
    3b07:	83 c4 10             	add    esp,0x10
								printf("tm_mon %d\n", ts->tm_mon);
    3b0a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3b0d:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    3b10:	83 ec 08             	sub    esp,0x8
    3b13:	50                   	push   eax
    3b14:	68 f4 0e 00 00       	push   0xef4
    3b19:	e8 fc ff ff ff       	call   3b1a <kloop+0x365>
    3b1e:	83 c4 10             	add    esp,0x10
								printf("tm_year %d\n", ts->tm_year);
    3b21:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3b24:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    3b27:	83 ec 08             	sub    esp,0x8
    3b2a:	50                   	push   eax
    3b2b:	68 ff 0e 00 00       	push   0xeff
    3b30:	e8 fc ff ff ff       	call   3b31 <kloop+0x37c>
    3b35:	83 c4 10             	add    esp,0x10
								printf("tm_wday %d\n", ts->tm_wday);
    3b38:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3b3b:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3b3e:	83 ec 08             	sub    esp,0x8
    3b41:	50                   	push   eax
    3b42:	68 0b 0f 00 00       	push   0xf0b
    3b47:	e8 fc ff ff ff       	call   3b48 <kloop+0x393>
    3b4c:	83 c4 10             	add    esp,0x10
								printf("tm_yday %d\n", ts->tm_yday);
    3b4f:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3b52:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    3b55:	83 ec 08             	sub    esp,0x8
    3b58:	50                   	push   eax
    3b59:	68 17 0f 00 00       	push   0xf17
    3b5e:	e8 fc ff ff ff       	call   3b5f <kloop+0x3aa>
    3b63:	83 c4 10             	add    esp,0x10
								printf("tm_isdst %d\n", ts->tm_isdst);
    3b66:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    3b69:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    3b6c:	83 ec 08             	sub    esp,0x8
    3b6f:	50                   	push   eax
    3b70:	68 23 0f 00 00       	push   0xf23
    3b75:	e8 fc ff ff ff       	call   3b76 <kloop+0x3c1>
    3b7a:	83 c4 10             	add    esp,0x10
    3b7d:	e9 84 04 00 00       	jmp    4006 <kloop+0x851>
						} else if(strcmp(str, "trhp") == 0) {
    3b82:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3b85:	83 ec 08             	sub    esp,0x8
    3b88:	68 30 0f 00 00       	push   0xf30
    3b8d:	50                   	push   eax
    3b8e:	e8 fc ff ff ff       	call   3b8f <kloop+0x3da>
    3b93:	83 c4 10             	add    esp,0x10
    3b96:	85 c0                	test   eax,eax
    3b98:	0f 85 82 00 00 00    	jne    3c20 <kloop+0x46b>
								unsigned int bval = 0xff;
    3b9e:	c7 45 f0 ff 00 00 00 	mov    DWORD PTR [ebp-0x10],0xff
								printf("trashing kernel heap\n");
    3ba5:	83 ec 0c             	sub    esp,0xc
    3ba8:	68 35 0f 00 00       	push   0xf35
    3bad:	e8 fc ff ff ff       	call   3bae <kloop+0x3f9>
    3bb2:	83 c4 10             	add    esp,0x10
								/* glibc rand */
								while (1) {
										printf("allocating %u bytes ...\n", (bval & 0xffff));
    3bb5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3bb8:	0f b7 c0             	movzx  eax,ax
    3bbb:	83 ec 08             	sub    esp,0x8
    3bbe:	50                   	push   eax
    3bbf:	68 4b 0f 00 00       	push   0xf4b
    3bc4:	e8 fc ff ff ff       	call   3bc5 <kloop+0x410>
    3bc9:	83 c4 10             	add    esp,0x10
										printf("located at %p\n", kmalloc(bval & 0xffff));
    3bcc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3bcf:	0f b7 c0             	movzx  eax,ax
    3bd2:	83 ec 0c             	sub    esp,0xc
    3bd5:	50                   	push   eax
    3bd6:	e8 fc ff ff ff       	call   3bd7 <kloop+0x422>
    3bdb:	83 c4 10             	add    esp,0x10
    3bde:	83 ec 08             	sub    esp,0x8
    3be1:	50                   	push   eax
    3be2:	68 64 0f 00 00       	push   0xf64
    3be7:	e8 fc ff ff ff       	call   3be8 <kloop+0x433>
    3bec:	83 c4 10             	add    esp,0x10
										bval = (uint32_t)((1103515245*(uint64_t)bval+12345) % 0x80000000);
    3bef:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3bf2:	ba 00 00 00 00       	mov    edx,0x0
    3bf7:	69 da 6d 4e c6 41    	imul   ebx,edx,0x41c64e6d
    3bfd:	6b c8 00             	imul   ecx,eax,0x0
    3c00:	01 d9                	add    ecx,ebx
    3c02:	bb 6d 4e c6 41       	mov    ebx,0x41c64e6d
    3c07:	f7 e3                	mul    ebx
    3c09:	01 d1                	add    ecx,edx
    3c0b:	89 ca                	mov    edx,ecx
    3c0d:	05 39 30 00 00       	add    eax,0x3039
    3c12:	83 d2 00             	adc    edx,0x0
    3c15:	25 ff ff ff 7f       	and    eax,0x7fffffff
    3c1a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
										printf("allocating %u bytes ...\n", (bval & 0xffff));
    3c1d:	90                   	nop
    3c1e:	eb 95                	jmp    3bb5 <kloop+0x400>
								}
						} else if (fptr && fptr(str)) {
    3c20:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    3c24:	74 17                	je     3c3d <kloop+0x488>
    3c26:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3c29:	83 ec 0c             	sub    esp,0xc
    3c2c:	50                   	push   eax
    3c2d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    3c30:	ff d0                	call   eax
    3c32:	83 c4 10             	add    esp,0x10
    3c35:	85 c0                	test   eax,eax
    3c37:	0f 85 c9 03 00 00    	jne    4006 <kloop+0x851>
								/* do nothing -> fptr() does it */
						} else if (strcmp(str, "lsmod") == 0)
    3c3d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3c40:	83 ec 08             	sub    esp,0x8
    3c43:	68 73 0f 00 00       	push   0xf73
    3c48:	50                   	push   eax
    3c49:	e8 fc ff ff ff       	call   3c4a <kloop+0x495>
    3c4e:	83 c4 10             	add    esp,0x10
    3c51:	85 c0                	test   eax,eax
    3c53:	75 0a                	jne    3c5f <kloop+0x4aa>
								list_modules();
    3c55:	e8 fc ff ff ff       	call   3c56 <kloop+0x4a1>
    3c5a:	e9 a7 03 00 00       	jmp    4006 <kloop+0x851>
						else if (strncmp(str, "modinfo ", 7) == 0) {
    3c5f:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3c62:	83 ec 04             	sub    esp,0x4
    3c65:	6a 07                	push   0x7
    3c67:	68 79 0f 00 00       	push   0xf79
    3c6c:	50                   	push   eax
    3c6d:	e8 fc ff ff ff       	call   3c6e <kloop+0x4b9>
    3c72:	83 c4 10             	add    esp,0x10
    3c75:	85 c0                	test   eax,eax
    3c77:	75 1d                	jne    3c96 <kloop+0x4e1>
								str += 8;
    3c79:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3c7c:	83 c0 08             	add    eax,0x8
    3c7f:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
								list_module_info(str);
    3c82:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3c85:	83 ec 0c             	sub    esp,0xc
    3c88:	50                   	push   eax
    3c89:	e8 fc ff ff ff       	call   3c8a <kloop+0x4d5>
    3c8e:	83 c4 10             	add    esp,0x10
    3c91:	e9 70 03 00 00       	jmp    4006 <kloop+0x851>
						} else if (strcmp(str, "com") == 0) {
    3c96:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3c99:	83 ec 08             	sub    esp,0x8
    3c9c:	68 82 0f 00 00       	push   0xf82
    3ca1:	50                   	push   eax
    3ca2:	e8 fc ff ff ff       	call   3ca3 <kloop+0x4ee>
    3ca7:	83 c4 10             	add    esp,0x10
    3caa:	85 c0                	test   eax,eax
    3cac:	75 0a                	jne    3cb8 <kloop+0x503>
								com_status();
    3cae:	e8 fc ff ff ff       	call   3caf <kloop+0x4fa>
    3cb3:	e9 4e 03 00 00       	jmp    4006 <kloop+0x851>
						} else if (strcmp(str, "brk") == 0) {
    3cb8:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3cbb:	83 ec 08             	sub    esp,0x8
    3cbe:	68 86 0f 00 00       	push   0xf86
    3cc3:	50                   	push   eax
    3cc4:	e8 fc ff ff ff       	call   3cc5 <kloop+0x510>
    3cc9:	83 c4 10             	add    esp,0x10
    3ccc:	85 c0                	test   eax,eax
    3cce:	0f 84 32 03 00 00    	je     4006 <kloop+0x851>
								//breakpoint(); TODO reimpl.
						} else if (strncmp(str, "pma", 3) == 0) {
    3cd4:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3cd7:	83 ec 04             	sub    esp,0x4
    3cda:	6a 03                	push   0x3
    3cdc:	68 8a 0f 00 00       	push   0xf8a
    3ce1:	50                   	push   eax
    3ce2:	e8 fc ff ff ff       	call   3ce3 <kloop+0x52e>
    3ce7:	83 c4 10             	add    esp,0x10
    3cea:	85 c0                	test   eax,eax
    3cec:	0f 85 05 01 00 00    	jne    3df7 <kloop+0x642>
								int val;
								/* allocate pmem */
								val = atoi(str + 3);
    3cf2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3cf5:	83 c0 03             	add    eax,0x3
    3cf8:	83 ec 0c             	sub    esp,0xc
    3cfb:	50                   	push   eax
    3cfc:	e8 fc ff ff ff       	call   3cfd <kloop+0x548>
    3d01:	83 c4 10             	add    esp,0x10
    3d04:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
								if (val) {
    3d07:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
    3d0b:	0f 84 f5 02 00 00    	je     4006 <kloop+0x851>
										struct page_range pr[10]; size_t rv;
										printf("allocating %d physical pages...\n", val);
    3d11:	83 ec 08             	sub    esp,0x8
    3d14:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    3d17:	68 90 0f 00 00       	push   0xf90
    3d1c:	e8 fc ff ff ff       	call   3d1d <kloop+0x568>
    3d21:	83 c4 10             	add    esp,0x10
										rv = mm_alloc_pm(pr, 10, val);
    3d24:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    3d27:	8d 85 24 ff ff ff    	lea    eax,[ebp-0xdc]
    3d2d:	83 ec 04             	sub    esp,0x4
    3d30:	52                   	push   edx
    3d31:	6a 0a                	push   0xa
    3d33:	50                   	push   eax
    3d34:	e8 fc ff ff ff       	call   3d35 <kloop+0x580>
    3d39:	83 c4 10             	add    esp,0x10
    3d3c:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
										printf("%u pages allocated\n", rv);
    3d3f:	83 ec 08             	sub    esp,0x8
    3d42:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    3d45:	68 b1 0f 00 00       	push   0xfb1
    3d4a:	e8 fc ff ff ff       	call   3d4b <kloop+0x596>
    3d4f:	83 c4 10             	add    esp,0x10
										for (rv = 0; rv < 10; rv++)
    3d52:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    3d59:	e9 8a 00 00 00       	jmp    3de8 <kloop+0x633>
												if (!pr[rv].count)
    3d5e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    3d61:	89 d0                	mov    eax,edx
    3d63:	01 c0                	add    eax,eax
    3d65:	01 d0                	add    eax,edx
    3d67:	c1 e0 02             	shl    eax,0x2
    3d6a:	8d 40 f8             	lea    eax,[eax-0x8]
    3d6d:	01 e8                	add    eax,ebp
    3d6f:	2d cc 00 00 00       	sub    eax,0xcc
    3d74:	8b 00                	mov    eax,DWORD PTR [eax]
    3d76:	85 c0                	test   eax,eax
    3d78:	0f 84 87 02 00 00    	je     4005 <kloop+0x850>
														break;
												else
														printf("%u pages at %#08x%08x\n",
																	   pr[rv].count,
																	   (uint32_t)(pr[rv].base >> 32),
																	   (uint32_t)pr[rv].base);
    3d7e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    3d81:	89 d0                	mov    eax,edx
    3d83:	01 c0                	add    eax,eax
    3d85:	01 d0                	add    eax,edx
    3d87:	c1 e0 02             	shl    eax,0x2
    3d8a:	8d 40 f8             	lea    eax,[eax-0x8]
    3d8d:	01 e8                	add    eax,ebp
    3d8f:	2d d4 00 00 00       	sub    eax,0xd4
    3d94:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3d97:	8b 00                	mov    eax,DWORD PTR [eax]
														printf("%u pages at %#08x%08x\n",
    3d99:	89 c3                	mov    ebx,eax
																	   (uint32_t)(pr[rv].base >> 32),
    3d9b:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    3d9e:	89 d0                	mov    eax,edx
    3da0:	01 c0                	add    eax,eax
    3da2:	01 d0                	add    eax,edx
    3da4:	c1 e0 02             	shl    eax,0x2
    3da7:	8d 40 f8             	lea    eax,[eax-0x8]
    3daa:	01 e8                	add    eax,ebp
    3dac:	2d d4 00 00 00       	sub    eax,0xd4
    3db1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3db4:	8b 00                	mov    eax,DWORD PTR [eax]
    3db6:	89 d0                	mov    eax,edx
    3db8:	31 d2                	xor    edx,edx
														printf("%u pages at %#08x%08x\n",
    3dba:	89 c1                	mov    ecx,eax
    3dbc:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    3dbf:	89 d0                	mov    eax,edx
    3dc1:	01 c0                	add    eax,eax
    3dc3:	01 d0                	add    eax,edx
    3dc5:	c1 e0 02             	shl    eax,0x2
    3dc8:	8d 40 f8             	lea    eax,[eax-0x8]
    3dcb:	01 e8                	add    eax,ebp
    3dcd:	2d cc 00 00 00       	sub    eax,0xcc
    3dd2:	8b 00                	mov    eax,DWORD PTR [eax]
    3dd4:	53                   	push   ebx
    3dd5:	51                   	push   ecx
    3dd6:	50                   	push   eax
    3dd7:	68 c5 0f 00 00       	push   0xfc5
    3ddc:	e8 fc ff ff ff       	call   3ddd <kloop+0x628>
    3de1:	83 c4 10             	add    esp,0x10
										for (rv = 0; rv < 10; rv++)
    3de4:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    3de8:	83 7d ec 09          	cmp    DWORD PTR [ebp-0x14],0x9
    3dec:	0f 86 6c ff ff ff    	jbe    3d5e <kloop+0x5a9>
    3df2:	e9 0f 02 00 00       	jmp    4006 <kloop+0x851>
								}
						} else if (strncmp(str, "pmf", 3) == 0) {
    3df7:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3dfa:	83 ec 04             	sub    esp,0x4
    3dfd:	6a 03                	push   0x3
    3dff:	68 dc 0f 00 00       	push   0xfdc
    3e04:	50                   	push   eax
    3e05:	e8 fc ff ff ff       	call   3e06 <kloop+0x651>
    3e0a:	83 c4 10             	add    esp,0x10
    3e0d:	85 c0                	test   eax,eax
    3e0f:	0f 85 80 00 00 00    	jne    3e95 <kloop+0x6e0>
								long int val; char* ep;
								val = strtol(str + 3, &ep, 0);
    3e15:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e18:	8d 50 03             	lea    edx,[eax+0x3]
    3e1b:	83 ec 04             	sub    esp,0x4
    3e1e:	6a 00                	push   0x0
    3e20:	8d 45 b0             	lea    eax,[ebp-0x50]
    3e23:	50                   	push   eax
    3e24:	52                   	push   edx
    3e25:	e8 fc ff ff ff       	call   3e26 <kloop+0x671>
    3e2a:	83 c4 10             	add    esp,0x10
    3e2d:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								if (val) {
    3e30:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    3e34:	0f 84 cc 01 00 00    	je     4006 <kloop+0x851>
										int ct = atoi(ep);
    3e3a:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    3e3d:	83 ec 0c             	sub    esp,0xc
    3e40:	50                   	push   eax
    3e41:	e8 fc ff ff ff       	call   3e42 <kloop+0x68d>
    3e46:	83 c4 10             	add    esp,0x10
    3e49:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
										if (ct) {
    3e4c:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    3e50:	0f 84 b0 01 00 00    	je     4006 <kloop+0x851>
												struct page_range pr;
												pr.base = val;
    3e56:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    3e59:	99                   	cdq
    3e5a:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
    3e5d:	89 55 a8             	mov    DWORD PTR [ebp-0x58],edx
												pr.count = ct;
    3e60:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    3e63:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
												printf("freeing %d physical pages at 0x%016llx\n",
    3e66:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    3e69:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    3e6c:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    3e6f:	52                   	push   edx
    3e70:	50                   	push   eax
    3e71:	51                   	push   ecx
    3e72:	68 e0 0f 00 00       	push   0xfe0
    3e77:	e8 fc ff ff ff       	call   3e78 <kloop+0x6c3>
    3e7c:	83 c4 10             	add    esp,0x10
																pr.count, pr.base);
												mm_free_pm(&pr, 1);
    3e7f:	83 ec 08             	sub    esp,0x8
    3e82:	6a 01                	push   0x1
    3e84:	8d 45 a4             	lea    eax,[ebp-0x5c]
    3e87:	50                   	push   eax
    3e88:	e8 fc ff ff ff       	call   3e89 <kloop+0x6d4>
    3e8d:	83 c4 10             	add    esp,0x10
    3e90:	e9 71 01 00 00       	jmp    4006 <kloop+0x851>
										}
								}
						} else if (strncmp(str, "pmu", 3) == 0) {
    3e95:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3e98:	83 ec 04             	sub    esp,0x4
    3e9b:	6a 03                	push   0x3
    3e9d:	68 08 10 00 00       	push   0x1008
    3ea2:	50                   	push   eax
    3ea3:	e8 fc ff ff ff       	call   3ea4 <kloop+0x6ef>
    3ea8:	83 c4 10             	add    esp,0x10
    3eab:	85 c0                	test   eax,eax
    3ead:	75 6d                	jne    3f1c <kloop+0x767>
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
    3eaf:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3eb2:	8d 50 03             	lea    edx,[eax+0x3]
    3eb5:	83 ec 04             	sub    esp,0x4
    3eb8:	6a 00                	push   0x0
    3eba:	8d 45 a0             	lea    eax,[ebp-0x60]
    3ebd:	50                   	push   eax
    3ebe:	52                   	push   edx
    3ebf:	e8 fc ff ff ff       	call   3ec0 <kloop+0x70b>
    3ec4:	83 c4 10             	add    esp,0x10
    3ec7:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
								if (val) {
    3eca:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    3ece:	74 36                	je     3f06 <kloop+0x751>
										int ct = atoi(ep);
    3ed0:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    3ed3:	83 ec 0c             	sub    esp,0xc
    3ed6:	50                   	push   eax
    3ed7:	e8 fc ff ff ff       	call   3ed8 <kloop+0x723>
    3edc:	83 c4 10             	add    esp,0x10
    3edf:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
										if (ct)
    3ee2:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    3ee6:	0f 84 1a 01 00 00    	je     4006 <kloop+0x851>
												mm_dump_pmu(val, ct, 0);
    3eec:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    3eef:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    3ef2:	83 ec 04             	sub    esp,0x4
    3ef5:	6a 00                	push   0x0
    3ef7:	52                   	push   edx
    3ef8:	50                   	push   eax
    3ef9:	e8 fc ff ff ff       	call   3efa <kloop+0x745>
    3efe:	83 c4 10             	add    esp,0x10
    3f01:	e9 00 01 00 00       	jmp    4006 <kloop+0x851>
								} else
										mm_dump_pmu(0, 0, 2);
    3f06:	83 ec 04             	sub    esp,0x4
    3f09:	6a 02                	push   0x2
    3f0b:	6a 00                	push   0x0
    3f0d:	6a 00                	push   0x0
    3f0f:	e8 fc ff ff ff       	call   3f10 <kloop+0x75b>
    3f14:	83 c4 10             	add    esp,0x10
    3f17:	e9 ea 00 00 00       	jmp    4006 <kloop+0x851>
						} else if (strncmp(str, "rcp", 3) == 0) {
    3f1c:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3f1f:	83 ec 04             	sub    esp,0x4
    3f22:	6a 03                	push   0x3
    3f24:	68 0c 10 00 00       	push   0x100c
    3f29:	50                   	push   eax
    3f2a:	e8 fc ff ff ff       	call   3f2b <kloop+0x776>
    3f2f:	83 c4 10             	add    esp,0x10
    3f32:	85 c0                	test   eax,eax
    3f34:	75 67                	jne    3f9d <kloop+0x7e8>
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
    3f36:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3f39:	8d 50 03             	lea    edx,[eax+0x3]
    3f3c:	83 ec 04             	sub    esp,0x4
    3f3f:	6a 00                	push   0x0
    3f41:	8d 45 9c             	lea    eax,[ebp-0x64]
    3f44:	50                   	push   eax
    3f45:	52                   	push   edx
    3f46:	e8 fc ff ff ff       	call   3f47 <kloop+0x792>
    3f4b:	83 c4 10             	add    esp,0x10
    3f4e:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								if (val) {
    3f51:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    3f55:	74 33                	je     3f8a <kloop+0x7d5>
										int ct = atoi(ep);
    3f57:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    3f5a:	83 ec 0c             	sub    esp,0xc
    3f5d:	50                   	push   eax
    3f5e:	e8 fc ff ff ff       	call   3f5f <kloop+0x7aa>
    3f63:	83 c4 10             	add    esp,0x10
    3f66:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
										if (ct)
    3f69:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    3f6d:	0f 84 93 00 00 00    	je     4006 <kloop+0x851>
												mm_dump_pmu(val, ct, 1);
    3f73:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    3f76:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3f79:	83 ec 04             	sub    esp,0x4
    3f7c:	6a 01                	push   0x1
    3f7e:	52                   	push   edx
    3f7f:	50                   	push   eax
    3f80:	e8 fc ff ff ff       	call   3f81 <kloop+0x7cc>
    3f85:	83 c4 10             	add    esp,0x10
    3f88:	eb 7c                	jmp    4006 <kloop+0x851>
								} else
										mm_dump_pmu(0, 0, 2);
    3f8a:	83 ec 04             	sub    esp,0x4
    3f8d:	6a 02                	push   0x2
    3f8f:	6a 00                	push   0x0
    3f91:	6a 00                	push   0x0
    3f93:	e8 fc ff ff ff       	call   3f94 <kloop+0x7df>
    3f98:	83 c4 10             	add    esp,0x10
    3f9b:	eb 69                	jmp    4006 <kloop+0x851>
						} else if (strcmp(str, "reboot") == 0)
    3f9d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3fa0:	83 ec 08             	sub    esp,0x8
    3fa3:	68 10 10 00 00       	push   0x1010
    3fa8:	50                   	push   eax
    3fa9:	e8 fc ff ff ff       	call   3faa <kloop+0x7f5>
    3fae:	83 c4 10             	add    esp,0x10
    3fb1:	85 c0                	test   eax,eax
    3fb3:	75 05                	jne    3fba <kloop+0x805>
								pc_reset();
    3fb5:	e8 fc ff ff ff       	call   3fb6 <kloop+0x801>
						else if (strcmp(str, "quit") == 0 || strcmp(str, "halt") == 0)
    3fba:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3fbd:	83 ec 08             	sub    esp,0x8
    3fc0:	68 17 10 00 00       	push   0x1017
    3fc5:	50                   	push   eax
    3fc6:	e8 fc ff ff ff       	call   3fc7 <kloop+0x812>
    3fcb:	83 c4 10             	add    esp,0x10
    3fce:	85 c0                	test   eax,eax
    3fd0:	74 18                	je     3fea <kloop+0x835>
    3fd2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3fd5:	83 ec 08             	sub    esp,0x8
    3fd8:	68 1c 10 00 00       	push   0x101c
    3fdd:	50                   	push   eax
    3fde:	e8 fc ff ff ff       	call   3fdf <kloop+0x82a>
    3fe3:	83 c4 10             	add    esp,0x10
    3fe6:	85 c0                	test   eax,eax
    3fe8:	75 05                	jne    3fef <kloop+0x83a>
								pc_shutdown();
    3fea:	e8 fc ff ff ff       	call   3feb <kloop+0x836>
						else
								printf("Command \"%s\" read from keyboard is unrecognized\n", str);
    3fef:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    3ff2:	83 ec 08             	sub    esp,0x8
    3ff5:	50                   	push   eax
    3ff6:	68 24 10 00 00       	push   0x1024
    3ffb:	e8 fc ff ff ff       	call   3ffc <kloop+0x847>
    4000:	83 c4 10             	add    esp,0x10
    4003:	eb 01                	jmp    4006 <kloop+0x851>
														break;
    4005:	90                   	nop
						kfree(str);
    4006:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    4009:	83 ec 0c             	sub    esp,0xc
    400c:	50                   	push   eax
    400d:	e8 fc ff ff ff       	call   400e <kloop+0x859>
    4012:	83 c4 10             	add    esp,0x10
		while (1) {
    4015:	e9 b8 f7 ff ff       	jmp    37d2 <kloop+0x1d>

0000401a <ringbuffer_allocate>:
		char data[];
};

/* ringbuffer functions*/
void* ringbuffer_allocate(size_t init_cap)
{
    401a:	55                   	push   ebp
    401b:	89 e5                	mov    ebp,esp
    401d:	83 ec 18             	sub    esp,0x18
		void** rvR, *rv;
		rvR = (void**)kmalloc(sizeof(void*));
    4020:	83 ec 0c             	sub    esp,0xc
    4023:	6a 04                	push   0x4
    4025:	e8 fc ff ff ff       	call   4026 <ringbuffer_allocate+0xc>
    402a:	83 c4 10             	add    esp,0x10
    402d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rvR)
    4030:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    4034:	75 07                	jne    403d <ringbuffer_allocate+0x23>
				return 0;
    4036:	b8 00 00 00 00       	mov    eax,0x0
    403b:	eb 6f                	jmp    40ac <ringbuffer_allocate+0x92>
		if ((rv = kmalloc(init_cap + sizeof(struct ringbuffer)))) {
    403d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4040:	83 c0 10             	add    eax,0x10
    4043:	83 ec 0c             	sub    esp,0xc
    4046:	50                   	push   eax
    4047:	e8 fc ff ff ff       	call   4048 <ringbuffer_allocate+0x2e>
    404c:	83 c4 10             	add    esp,0x10
    404f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    4052:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    4056:	74 41                	je     4099 <ringbuffer_allocate+0x7f>
				struct ringbuffer* rbf = (struct ringbuffer*)rv;
    4058:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    405b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				rbf->cap = init_cap;
    405e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4061:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    4064:	89 10                	mov    DWORD PTR [eax],edx
				rbf->ofs_start = 0;
    4066:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4069:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
				rbf->ofs_end = 0;
    4070:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4073:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
				spin_lock_init(&rbf->lock);
    407a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    407d:	83 c0 0c             	add    eax,0xc
    4080:	83 ec 0c             	sub    esp,0xc
    4083:	50                   	push   eax
    4084:	e8 fc ff ff ff       	call   4085 <ringbuffer_allocate+0x6b>
    4089:	83 c4 10             	add    esp,0x10
				*rvR = rv;
    408c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    408f:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    4092:	89 10                	mov    DWORD PTR [eax],edx
				return (void*)rvR;
    4094:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4097:	eb 13                	jmp    40ac <ringbuffer_allocate+0x92>
		} else
				kfree(rvR);
    4099:	83 ec 0c             	sub    esp,0xc
    409c:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    409f:	e8 fc ff ff ff       	call   40a0 <ringbuffer_allocate+0x86>
    40a4:	83 c4 10             	add    esp,0x10
		return 0;
    40a7:	b8 00 00 00 00       	mov    eax,0x0
}
    40ac:	c9                   	leave
    40ad:	c3                   	ret

000040ae <ringbuffer_enqueue>:

void ringbuffer_enqueue(void* rbi, const void* dat, size_t s)
{
    40ae:	55                   	push   ebp
    40af:	89 e5                	mov    ebp,esp
    40b1:	53                   	push   ebx
    40b2:	83 ec 24             	sub    esp,0x24
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    40b5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    40b8:	8b 00                	mov    eax,DWORD PTR [eax]
    40ba:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
	//	spin_lock(&rb->lock);
		const char* data = (const char*)dat;
    40bd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    40c0:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		size_t cap = rb->cap;
    40c3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    40c6:	8b 00                	mov    eax,DWORD PTR [eax]
    40c8:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (rb->ofs_end > rb->ofs_start)
    40cb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    40ce:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    40d1:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    40d4:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    40d7:	39 c2                	cmp    edx,eax
    40d9:	73 13                	jae    40ee <ringbuffer_enqueue+0x40>
				cap -= rb->ofs_end - rb->ofs_start;
    40db:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    40de:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    40e1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    40e4:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    40e7:	29 c2                	sub    edx,eax
    40e9:	01 55 ec             	add    DWORD PTR [ebp-0x14],edx
    40ec:	eb 20                	jmp    410e <ringbuffer_enqueue+0x60>
		else
				cap -= rb->cap - rb->ofs_start + rb->ofs_end + 1;
    40ee:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    40f1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    40f4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    40f7:	8b 00                	mov    eax,DWORD PTR [eax]
    40f9:	29 c2                	sub    edx,eax
    40fb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    40fe:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    4101:	29 c2                	sub    edx,eax
    4103:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4106:	01 d0                	add    eax,edx
    4108:	83 e8 01             	sub    eax,0x1
    410b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (cap < s) {
    410e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    4111:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
    4114:	0f 83 dd 00 00 00    	jae    41f7 <ringbuffer_enqueue+0x149>
				void* nrb;
				/* allocate new buffer and shuffle data */
				size_t nc = rb->cap + max(rb->cap, 4 * s + 1);
    411a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    411d:	8b 08                	mov    ecx,DWORD PTR [eax]
    411f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    4122:	c1 e0 02             	shl    eax,0x2
    4125:	8d 50 01             	lea    edx,[eax+0x1]
    4128:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    412b:	8b 00                	mov    eax,DWORD PTR [eax]
    412d:	39 c2                	cmp    edx,eax
    412f:	0f 43 c2             	cmovae eax,edx
    4132:	01 c8                	add    eax,ecx
    4134:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if ((nrb = krealloc(rb, nc + sizeof(struct ringbuffer)))) {
    4137:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    413a:	83 c0 10             	add    eax,0x10
    413d:	83 ec 08             	sub    esp,0x8
    4140:	50                   	push   eax
    4141:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    4144:	e8 fc ff ff ff       	call   4145 <ringbuffer_enqueue+0x97>
    4149:	83 c4 10             	add    esp,0x10
    414c:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    414f:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    4153:	0f 84 ad 00 00 00    	je     4206 <ringbuffer_enqueue+0x158>
						/* enough memory */
						rb = (struct ringbuffer*)nrb;
    4159:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    415c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						*(void**)rbi = nrb;
    415f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4162:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    4165:	89 10                	mov    DWORD PTR [eax],edx
						/* move old data (if wrapped) */
						if (rb->ofs_end < rb->ofs_start) {
    4167:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    416a:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    416d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    4170:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    4173:	39 c2                	cmp    edx,eax
    4175:	73 3b                	jae    41b2 <ringbuffer_enqueue+0x104>
								memcpy(rb->data + rb->cap, rb->data, rb->ofs_end);
    4177:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    417a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    417d:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4180:	8d 4a 0e             	lea    ecx,[edx+0xe]
    4183:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    4186:	8d 5a 0e             	lea    ebx,[edx+0xe]
    4189:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    418c:	8b 12                	mov    edx,DWORD PTR [edx]
    418e:	01 da                	add    edx,ebx
    4190:	83 ec 04             	sub    esp,0x4
    4193:	50                   	push   eax
    4194:	51                   	push   ecx
    4195:	52                   	push   edx
    4196:	e8 c2 be ff ff       	call   5d <memcpy>
    419b:	83 c4 10             	add    esp,0x10
								rb->ofs_end += rb->ofs_start;
    419e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    41a1:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    41a4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    41a7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    41aa:	01 c2                	add    edx,eax
    41ac:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    41af:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
						}
						rb->cap = nc;
    41b2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    41b5:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    41b8:	89 10                	mov    DWORD PTR [eax],edx
				} else {
	//					spin_unlock(&rb->lock);
						return; /* OOM */
				}
		}
		while (s--) {
    41ba:	eb 3b                	jmp    41f7 <ringbuffer_enqueue+0x149>
				if (rb->ofs_end == rb->cap)
    41bc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    41bf:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    41c2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    41c5:	8b 00                	mov    eax,DWORD PTR [eax]
    41c7:	39 c2                	cmp    edx,eax
    41c9:	75 0a                	jne    41d5 <ringbuffer_enqueue+0x127>
						rb->ofs_end = 0;
    41cb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    41ce:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
				rb->data[rb->ofs_end++] = *(data++);
    41d5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    41d8:	8d 42 01             	lea    eax,[edx+0x1]
    41db:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    41de:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    41e1:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    41e4:	8d 58 01             	lea    ebx,[eax+0x1]
    41e7:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    41ea:	89 59 08             	mov    DWORD PTR [ecx+0x8],ebx
    41ed:	0f b6 0a             	movzx  ecx,BYTE PTR [edx]
    41f0:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    41f3:	88 4c 02 0e          	mov    BYTE PTR [edx+eax*1+0xe],cl
		while (s--) {
    41f7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    41fa:	8d 50 ff             	lea    edx,[eax-0x1]
    41fd:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    4200:	85 c0                	test   eax,eax
    4202:	75 b8                	jne    41bc <ringbuffer_enqueue+0x10e>
    4204:	eb 01                	jmp    4207 <ringbuffer_enqueue+0x159>
						return; /* OOM */
    4206:	90                   	nop
		}
//		spin_unlock(&rb->lock);
}
    4207:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    420a:	c9                   	leave
    420b:	c3                   	ret

0000420c <ringbuffer_dequeue>:

void ringbuffer_dequeue(void* rbi, void* dat, size_t s)
{
    420c:	55                   	push   ebp
    420d:	89 e5                	mov    ebp,esp
    420f:	83 ec 10             	sub    esp,0x10
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    4212:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4215:	8b 00                	mov    eax,DWORD PTR [eax]
    4217:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
//		spin_lock(&rb->lock);
		char* data = (char*)dat;
    421a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    421d:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		while (s--) {
    4220:	eb 64                	jmp    4286 <ringbuffer_dequeue+0x7a>
				if (rb->ofs_end == rb->ofs_start) {
    4222:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4225:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    4228:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    422b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    422e:	39 c2                	cmp    edx,eax
    4230:	74 63                	je     4295 <ringbuffer_dequeue+0x89>
//						spin_unlock(&rb->lock);
						return;
				}
				*(data++) = rb->data[rb->ofs_start++];
    4232:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4235:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    4238:	8d 4a 01             	lea    ecx,[edx+0x1]
    423b:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    423e:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
    4241:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    4244:	8d 48 01             	lea    ecx,[eax+0x1]
    4247:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
    424a:	8b 4d f8             	mov    ecx,DWORD PTR [ebp-0x8]
    424d:	0f b6 54 11 0e       	movzx  edx,BYTE PTR [ecx+edx*1+0xe]
    4252:	88 10                	mov    BYTE PTR [eax],dl
				if (rb->ofs_start == rb->cap) {
    4254:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4257:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    425a:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    425d:	8b 00                	mov    eax,DWORD PTR [eax]
    425f:	39 c2                	cmp    edx,eax
    4261:	75 23                	jne    4286 <ringbuffer_dequeue+0x7a>
						rb->ofs_start = 0;
    4263:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4266:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
						if (rb->ofs_end == rb->cap)
    426d:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4270:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    4273:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    4276:	8b 00                	mov    eax,DWORD PTR [eax]
    4278:	39 c2                	cmp    edx,eax
    427a:	75 0a                	jne    4286 <ringbuffer_dequeue+0x7a>
								rb->ofs_end = 0;
    427c:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    427f:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
		while (s--) {
    4286:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    4289:	8d 50 ff             	lea    edx,[eax-0x1]
    428c:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    428f:	85 c0                	test   eax,eax
    4291:	75 8f                	jne    4222 <ringbuffer_dequeue+0x16>
    4293:	eb 01                	jmp    4296 <ringbuffer_dequeue+0x8a>
						return;
    4295:	90                   	nop
				}
		}
//		spin_unlock(&rb->lock);
}
    4296:	c9                   	leave
    4297:	c3                   	ret

00004298 <ringbuffer_available>:

size_t ringbuffer_available(void* rbi)
{
    4298:	55                   	push   ebp
    4299:	89 e5                	mov    ebp,esp
    429b:	83 ec 10             	sub    esp,0x10
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    429e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    42a1:	8b 00                	mov    eax,DWORD PTR [eax]
    42a3:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (rb->ofs_end < rb->ofs_start)
    42a6:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    42a9:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    42ac:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    42af:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    42b2:	39 c2                	cmp    edx,eax
    42b4:	73 17                	jae    42cd <ringbuffer_available+0x35>
				return rb->cap - rb->ofs_start + rb->ofs_end;
    42b6:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    42b9:	8b 10                	mov    edx,DWORD PTR [eax]
    42bb:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    42be:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    42c1:	29 c2                	sub    edx,eax
    42c3:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    42c6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    42c9:	01 d0                	add    eax,edx
    42cb:	eb 10                	jmp    42dd <ringbuffer_available+0x45>
		else
				return rb->ofs_end - rb->ofs_start;
    42cd:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    42d0:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    42d3:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    42d6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    42d9:	89 c8                	mov    eax,ecx
    42db:	29 d0                	sub    eax,edx
}
    42dd:	c9                   	leave
    42de:	c3                   	ret

000042df <ringbuffer_free>:

void ringbuffer_free(void* rbi)
{
    42df:	55                   	push   ebp
    42e0:	89 e5                	mov    ebp,esp
    42e2:	83 ec 18             	sub    esp,0x18
		struct ringbuffer* rbf = *(struct ringbuffer**)rbi;
    42e5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    42e8:	8b 00                	mov    eax,DWORD PTR [eax]
    42ea:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		spin_lock(&rbf->lock);
    42ed:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    42f0:	83 c0 0c             	add    eax,0xc
    42f3:	83 ec 0c             	sub    esp,0xc
    42f6:	50                   	push   eax
    42f7:	e8 fc ff ff ff       	call   42f8 <ringbuffer_free+0x19>
    42fc:	83 c4 10             	add    esp,0x10
		kfree(rbf);
    42ff:	83 ec 0c             	sub    esp,0xc
    4302:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    4305:	e8 fc ff ff ff       	call   4306 <ringbuffer_free+0x27>
    430a:	83 c4 10             	add    esp,0x10
		kfree(rbi);
    430d:	83 ec 0c             	sub    esp,0xc
    4310:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    4313:	e8 fc ff ff ff       	call   4314 <ringbuffer_free+0x35>
    4318:	83 c4 10             	add    esp,0x10
}
    431b:	90                   	nop
    431c:	c9                   	leave
    431d:	c3                   	ret

0000431e <spin_lock>:

/* locking functions */
/* linux ticket spin (better than xchg under high contention) */
#define ACCESS_ONCE(x) (*(volatile __typeof__(x)*)&(x))
void spin_lock(spinlock_t* lock)
{
    431e:	55                   	push   ebp
    431f:	89 e5                	mov    ebp,esp
    4321:	83 ec 10             	sub    esp,0x10
		register spinlock_t inc;
		inc.head_tail = 1 << (8 * sizeof(ticket_t));
    4324:	66 c7 45 fe 00 01    	mov    WORD PTR [ebp-0x2],0x100

		inc.head_tail = __sync_fetch_and_add(&lock->head_tail, inc.head_tail);
    432a:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    432e:	0f b7 d0             	movzx  edx,ax
    4331:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4334:	66 f0 0f c1 10       	lock xadd WORD PTR [eax],dx
    4339:	66 89 55 fe          	mov    WORD PTR [ebp-0x2],dx

		for (;;) {
				if (inc.tickets.head == inc.tickets.tail)
    433d:	0f b6 55 fe          	movzx  edx,BYTE PTR [ebp-0x2]
    4341:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
    4345:	38 c2                	cmp    dl,al
    4347:	74 0d                	je     4356 <spin_lock+0x38>
						break;
				_mm_pause();
    4349:	f3 90                	pause
				inc.tickets.head = ACCESS_ONCE(lock->tickets.head);
    434b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    434e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    4351:	88 45 fe             	mov    BYTE PTR [ebp-0x2],al
				if (inc.tickets.head == inc.tickets.tail)
    4354:	eb e7                	jmp    433d <spin_lock+0x1f>
						break;
    4356:	90                   	nop
		}
}
    4357:	90                   	nop
    4358:	c9                   	leave
    4359:	c3                   	ret

0000435a <spin_lock_init>:

void spin_lock_init(spinlock_t* lock)
{
    435a:	55                   	push   ebp
    435b:	89 e5                	mov    ebp,esp
		*lock = (spinlock_t){0};
    435d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4360:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
}
    4365:	90                   	nop
    4366:	5d                   	pop    ebp
    4367:	c3                   	ret

00004368 <spin_lock_irq>:

void spin_lock_irq(spinlock_t* lock)
{
    4368:	55                   	push   ebp
    4369:	89 e5                	mov    ebp,esp
		asm("cli");
    436b:	fa                   	cli
		spin_lock(lock);
    436c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    436f:	e8 fc ff ff ff       	call   4370 <spin_lock_irq+0x8>
    4374:	83 c4 04             	add    esp,0x4
}
    4377:	90                   	nop
    4378:	c9                   	leave
    4379:	c3                   	ret

0000437a <spin_lock_irqsave>:

void spin_lock_irqsave(spinlock_t* lock, unsigned long* flags)
{
    437a:	55                   	push   ebp
    437b:	89 e5                	mov    ebp,esp
    437d:	83 ec 08             	sub    esp,0x8
		*flags = !if_enabled();
    4380:	e8 14 bd ff ff       	call   99 <if_enabled>
    4385:	85 c0                	test   eax,eax
    4387:	0f 94 c0             	sete   al
    438a:	0f b6 d0             	movzx  edx,al
    438d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    4390:	89 10                	mov    DWORD PTR [eax],edx
		asm("cli");
    4392:	fa                   	cli
		preempt_disable();
    4393:	e8 fc ff ff ff       	call   4394 <spin_lock_irqsave+0x1a>
    4398:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    439b:	83 c2 01             	add    edx,0x1
    439e:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		spin_lock(lock);
    43a1:	83 ec 0c             	sub    esp,0xc
    43a4:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    43a7:	e8 fc ff ff ff       	call   43a8 <spin_lock_irqsave+0x2e>
    43ac:	83 c4 10             	add    esp,0x10
}
    43af:	90                   	nop
    43b0:	c9                   	leave
    43b1:	c3                   	ret

000043b2 <spin_trylock>:

int spin_trylock(spinlock_t* lock)
{
    43b2:	55                   	push   ebp
    43b3:	89 e5                	mov    ebp,esp
    43b5:	83 ec 10             	sub    esp,0x10
		spinlock_t old, new;

		old.head_tail = ACCESS_ONCE(lock->head_tail);
    43b8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    43bb:	0f b7 00             	movzx  eax,WORD PTR [eax]
    43be:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
		if (old.tickets.head != old.tickets.tail)
    43c2:	0f b6 55 fe          	movzx  edx,BYTE PTR [ebp-0x2]
    43c6:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
    43ca:	38 c2                	cmp    dl,al
    43cc:	74 07                	je     43d5 <spin_trylock+0x23>
				return 0;
    43ce:	b8 00 00 00 00       	mov    eax,0x0
    43d3:	eb 28                	jmp    43fd <spin_trylock+0x4b>

		new.head_tail = old.head_tail + (1 << (8 * sizeof(ticket_t)));
    43d5:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    43d9:	66 05 00 01          	add    ax,0x100
    43dd:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		return __sync_bool_compare_and_swap(&lock->head_tail, old.head_tail, new.head_tail);
    43e1:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
    43e5:	0f b7 c8             	movzx  ecx,ax
    43e8:	0f b7 45 fe          	movzx  eax,WORD PTR [ebp-0x2]
    43ec:	0f b7 c0             	movzx  eax,ax
    43ef:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    43f2:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [edx],cx
    43f7:	0f 94 c0             	sete   al
    43fa:	0f b6 c0             	movzx  eax,al
}
    43fd:	c9                   	leave
    43fe:	c3                   	ret

000043ff <spin_trylock_irq>:

int spin_trylock_irq(spinlock_t* lock)
{
    43ff:	55                   	push   ebp
    4400:	89 e5                	mov    ebp,esp
    4402:	83 ec 10             	sub    esp,0x10
		int rv;
		asm("cli");
    4405:	fa                   	cli
		rv = spin_trylock(lock);
    4406:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    4409:	e8 fc ff ff ff       	call   440a <spin_trylock_irq+0xb>
    440e:	83 c4 04             	add    esp,0x4
    4411:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (rv)
    4414:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
    4418:	74 05                	je     441f <spin_trylock_irq+0x20>
				return rv;
    441a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    441d:	eb 04                	jmp    4423 <spin_trylock_irq+0x24>
		asm("sti");
    441f:	fb                   	sti
		return rv;
    4420:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
    4423:	c9                   	leave
    4424:	c3                   	ret

00004425 <spin_trylock_irqsave>:

int spin_trylock_irqsave(spinlock_t* lock, int* flags)
{
    4425:	55                   	push   ebp
    4426:	89 e5                	mov    ebp,esp
    4428:	83 ec 18             	sub    esp,0x18
		int rv;
		*flags = if_enabled();
    442b:	e8 69 bc ff ff       	call   99 <if_enabled>
    4430:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    4433:	89 02                	mov    DWORD PTR [edx],eax
		asm("cli");
    4435:	fa                   	cli
		preempt_disable();
    4436:	e8 fc ff ff ff       	call   4437 <spin_trylock_irqsave+0x12>
    443b:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    443e:	83 c2 01             	add    edx,0x1
    4441:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		rv = spin_trylock(lock);
    4444:	83 ec 0c             	sub    esp,0xc
    4447:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    444a:	e8 fc ff ff ff       	call   444b <spin_trylock_irqsave+0x26>
    444f:	83 c4 10             	add    esp,0x10
    4452:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv) {
    4455:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    4459:	75 18                	jne    4473 <spin_trylock_irqsave+0x4e>
				if (*flags)
    445b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    445e:	8b 00                	mov    eax,DWORD PTR [eax]
    4460:	85 c0                	test   eax,eax
    4462:	74 01                	je     4465 <spin_trylock_irqsave+0x40>
						asm("sti");
    4464:	fb                   	sti
				preempt_enable_no_resched();
    4465:	e8 fc ff ff ff       	call   4466 <spin_trylock_irqsave+0x41>
    446a:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    446d:	83 ea 01             	sub    edx,0x1
    4470:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		}
		return rv;
    4473:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    4476:	c9                   	leave
    4477:	c3                   	ret

00004478 <spin_unlock>:

void spin_unlock(spinlock_t* lock)
{
    4478:	55                   	push   ebp
    4479:	89 e5                	mov    ebp,esp
		__sync_fetch_and_add(&lock->tickets.head, 1);
    447b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    447e:	f0 80 00 01          	lock add BYTE PTR [eax],0x1
}
    4482:	90                   	nop
    4483:	5d                   	pop    ebp
    4484:	c3                   	ret

00004485 <spin_unlock_irq>:

void spin_unlock_irq(spinlock_t* lock)
{
    4485:	55                   	push   ebp
    4486:	89 e5                	mov    ebp,esp
		spin_unlock(lock);
    4488:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    448b:	e8 fc ff ff ff       	call   448c <spin_unlock_irq+0x7>
    4490:	83 c4 04             	add    esp,0x4
		asm("sti");
    4493:	fb                   	sti
}
    4494:	90                   	nop
    4495:	c9                   	leave
    4496:	c3                   	ret

00004497 <spin_unlock_irqrestore>:

void spin_unlock_irqrestore(spinlock_t* lock, unsigned long flags)
{
    4497:	55                   	push   ebp
    4498:	89 e5                	mov    ebp,esp
    449a:	83 ec 08             	sub    esp,0x8
		spin_unlock(lock);
    449d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    44a0:	e8 fc ff ff ff       	call   44a1 <spin_unlock_irqrestore+0xa>
    44a5:	83 c4 04             	add    esp,0x4
		if (flags)
    44a8:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    44ac:	74 01                	je     44af <spin_unlock_irqrestore+0x18>
				asm("sti");
    44ae:	fb                   	sti
		preempt_enable_no_resched();
    44af:	e8 fc ff ff ff       	call   44b0 <spin_unlock_irqrestore+0x19>
    44b4:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    44b7:	83 ea 01             	sub    edx,0x1
    44ba:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
}
    44bd:	90                   	nop
    44be:	c9                   	leave
    44bf:	c3                   	ret

000044c0 <read_lock>:

void read_lock(rwlock_t* lock)
{
    44c0:	55                   	push   ebp
    44c1:	89 e5                	mov    ebp,esp
		if (!__sync_fetch_and_add(&lock->cnts.counter, 1)) {
    44c3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    44c6:	ba 01 00 00 00       	mov    edx,0x1
    44cb:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    44cf:	85 d2                	test   edx,edx
    44d1:	75 0f                	jne    44e2 <read_lock+0x22>
				/* first reader */
				spin_lock(&lock->lock);
    44d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    44d6:	83 c0 04             	add    eax,0x4
    44d9:	50                   	push   eax
    44da:	e8 fc ff ff ff       	call   44db <read_lock+0x1b>
    44df:	83 c4 04             	add    esp,0x4
		}
}
    44e2:	90                   	nop
    44e3:	c9                   	leave
    44e4:	c3                   	ret

000044e5 <read_unlock>:

void read_unlock(rwlock_t* lock)
{
    44e5:	55                   	push   ebp
    44e6:	89 e5                	mov    ebp,esp
		if (!__sync_sub_and_fetch(&lock->cnts.counter, 1)) {
    44e8:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    44eb:	b8 01 00 00 00       	mov    eax,0x1
    44f0:	f7 d8                	neg    eax
    44f2:	89 c1                	mov    ecx,eax
    44f4:	89 c8                	mov    eax,ecx
    44f6:	f0 0f c1 02          	lock xadd DWORD PTR [edx],eax
    44fa:	01 c8                	add    eax,ecx
    44fc:	85 c0                	test   eax,eax
    44fe:	75 0f                	jne    450f <read_unlock+0x2a>
				/* last reader, allow writing again */
				spin_unlock(&lock->lock);
    4500:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4503:	83 c0 04             	add    eax,0x4
    4506:	50                   	push   eax
    4507:	e8 fc ff ff ff       	call   4508 <read_unlock+0x23>
    450c:	83 c4 04             	add    esp,0x4
		}
}
    450f:	90                   	nop
    4510:	c9                   	leave
    4511:	c3                   	ret

00004512 <write_lock>:

void write_lock(rwlock_t* lock)
{
    4512:	55                   	push   ebp
    4513:	89 e5                	mov    ebp,esp
		spin_lock(&lock->lock);
    4515:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4518:	83 c0 04             	add    eax,0x4
    451b:	50                   	push   eax
    451c:	e8 fc ff ff ff       	call   451d <write_lock+0xb>
    4521:	83 c4 04             	add    esp,0x4
}
    4524:	90                   	nop
    4525:	c9                   	leave
    4526:	c3                   	ret

00004527 <write_trylock>:

int write_trylock(rwlock_t* lock)
{
    4527:	55                   	push   ebp
    4528:	89 e5                	mov    ebp,esp
		return spin_trylock(&lock->lock);
    452a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    452d:	83 c0 04             	add    eax,0x4
    4530:	50                   	push   eax
    4531:	e8 fc ff ff ff       	call   4532 <write_trylock+0xb>
    4536:	83 c4 04             	add    esp,0x4
}
    4539:	c9                   	leave
    453a:	c3                   	ret

0000453b <write_unlock>:

void write_unlock(rwlock_t* lock)
{
    453b:	55                   	push   ebp
    453c:	89 e5                	mov    ebp,esp
		spin_unlock(&lock->lock);
    453e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    4541:	83 c0 04             	add    eax,0x4
    4544:	50                   	push   eax
    4545:	e8 fc ff ff ff       	call   4546 <write_unlock+0xb>
    454a:	83 c4 04             	add    esp,0x4
}
    454d:	90                   	nop
    454e:	c9                   	leave
    454f:	c3                   	ret
