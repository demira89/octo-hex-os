
kernel.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <per_cpu_ptr>:
		outb(PIC1_COMMAND, 0xff);
}

uint16_t pic_get_irr() /* currently requested interrupts */
{
		outb(PIC1_COMMAND, 0x0a); /* PIC_READ_IRR */
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 10          	sub    rsp,0x10
		outb(PIC2_COMMAND, 0x0a);
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
}
       8:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
      11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax

uint16_t pic_get_isr() /* currently serviced interrput */
{
		outb(PIC1_COMMAND, 0x0b); /* PIC_READ_ISR */
      15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
		outb(PIC2_COMMAND, 0x0b);
      19:	c9                   	leave
      1a:	c3                   	ret

000000000000001b <io_wait>:
{
		for (int i = 0; i < 4; i++)
				if (com_ports[i]) {
						uint16_t port = com_ports[i];
						uint8_t lsr;
						lsr = inb(port + 5);
      1b:	55                   	push   rbp
      1c:	48 89 e5             	mov    rbp,rsp
						printf("COM%d lsr: %08b\n", i, lsr);
      1f:	b8 00 00 00 00       	mov    eax,0x0
      24:	e6 80                	out    0x80,al
				}
      26:	90                   	nop
      27:	5d                   	pop    rbp
      28:	c3                   	ret

0000000000000029 <outb>:
}

int is_transit_empty(uint16_t port)
      29:	55                   	push   rbp
      2a:	48 89 e5             	mov    rbp,rsp
      2d:	48 83 ec 08          	sub    rsp,0x8
      31:	89 fa                	mov    edx,edi
      33:	89 f0                	mov    eax,esi
      35:	66 89 55 fc          	mov    WORD PTR [rbp-0x4],dx
      39:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
{
      3c:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
      40:	0f b7 55 fc          	movzx  edx,WORD PTR [rbp-0x4]
      44:	ee                   	out    dx,al
		return inb(port + 5) & 0x20;
      45:	90                   	nop
      46:	c9                   	leave
      47:	c3                   	ret

0000000000000048 <inb>:
}

void putDebugChar(char c)
      48:	55                   	push   rbp
      49:	48 89 e5             	mov    rbp,rsp
      4c:	48 83 ec 18          	sub    rsp,0x18
      50:	89 f8                	mov    eax,edi
      52:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
{
		while (!is_transit_empty(def_port));
      56:	0f b7 45 ec          	movzx  eax,WORD PTR [rbp-0x14]
      5a:	89 c2                	mov    edx,eax
      5c:	ec                   	in     al,dx
      5d:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
		outb(def_port, c);
      60:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
}
      64:	c9                   	leave
      65:	c3                   	ret

0000000000000066 <memcpy>:
		if (!irq || irq > 15)
				return;
		pt = irq_funs[--irq]; /* 1 based */
		while (pt) {
				if (pt->fun(irq + 1)) /* handled */
						break;
      66:	55                   	push   rbp
      67:	48 89 e5             	mov    rbp,rsp
      6a:	48 83 ec 28          	sub    rsp,0x28
      6e:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
      72:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      76:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
				pt = pt->next;
      7a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      7e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		}
      82:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      86:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
}
      8a:	eb 1d                	jmp    a9 <memcpy+0x43>

      8c:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      90:	48 8d 42 01          	lea    rax,[rdx+0x1]
      94:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      98:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      9c:	48 8d 48 01          	lea    rcx,[rax+0x1]
      a0:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      a4:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      a7:	88 10                	mov    BYTE PTR [rax],dl
}
      a9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      ad:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      b1:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      b5:	48 85 c0             	test   rax,rax
      b8:	75 d2                	jne    8c <memcpy+0x26>
int install_irq_handler(unsigned int irq, irq_handler_function fun)
      ba:	90                   	nop
      bb:	90                   	nop
      bc:	c9                   	leave
      bd:	c3                   	ret

00000000000000be <if_enabled>:
						else if (i < l_n)
								putc_prc(&km_regC, KFMT_WARN, '|', i, 0);
						else if (i < l_u)
								putc_prc(&km_regC, KFMT_INFO, '|', i, 0);
						else
								putc_prc(&km_regC, KFMT_NORMAL, ' ', i, 0);
      be:	55                   	push   rbp
      bf:	48 89 e5             	mov    rbp,rsp
      c2:	48 83 ec 10          	sub    rsp,0x10
				}
				/* also written */
      c6:	9c                   	pushf
      c7:	58                   	pop    rax
      c8:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				pc_b = min(9, 10 - cpu_pcs[0].vals[4]);
				if (pc_a == 100)
						pc_b = 0;
				crprintf(KFMT_NORMAL, &km_regC, "%3u.%1u%%", pc_a, pc_b);
		}
}
      cc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      d0:	83 e0 20             	and    eax,0x20
      d3:	48 85 c0             	test   rax,rax
      d6:	0f 95 c0             	setne  al
      d9:	0f b6 c0             	movzx  eax,al

      dc:	c9                   	leave
      dd:	c3                   	ret

00000000000000de <__get_cpuid_max>:
   pointer is non-null, then first four bytes of the signature
   (as found in ebx register) are returned in location pointed by sig.  */

static __inline unsigned int
__get_cpuid_max (unsigned int __ext, unsigned int *__sig)
{
      de:	55                   	push   rbp
      df:	48 89 e5             	mov    rbp,rsp
      e2:	53                   	push   rbx
      e3:	48 83 ec 20          	sub    rsp,0x20
      e7:	89 7d e4             	mov    DWORD PTR [rbp-0x1c],edi
      ea:	48 89 75 d8          	mov    QWORD PTR [rbp-0x28],rsi
  if (__builtin_expect (!((__eax ^ __ebx) & 0x00200000), 0))
    return 0;
#endif

  /* Host supports cpuid.  Return highest supported cpuid input value.  */
  __cpuid (__ext, __eax, __ebx, __ecx, __edx);
      ee:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
      f1:	0f a2                	cpuid
      f3:	89 de                	mov    esi,ebx
      f5:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
      f8:	89 75 f0             	mov    DWORD PTR [rbp-0x10],esi
      fb:	89 4d ec             	mov    DWORD PTR [rbp-0x14],ecx
      fe:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx

  if (__sig)
     101:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     106:	74 09                	je     111 <__get_cpuid_max+0x33>
    *__sig = __ebx;
     108:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     10c:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
     10f:	89 10                	mov    DWORD PTR [rax],edx

  return __eax;
     111:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     114:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     118:	c9                   	leave
     119:	c3                   	ret

000000000000011a <exceptionHandler>:
{
     11a:	55                   	push   rbp
     11b:	48 89 e5             	mov    rbp,rsp
     11e:	48 83 ec 20          	sub    rsp,0x20
     122:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
     125:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		struct IDTDescr* dt = &idt;
     129:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		if (i < 17) {
     131:	83 7d ec 10          	cmp    DWORD PTR [rbp-0x14],0x10
     135:	7f 40                	jg     177 <exceptionHandler+0x5d>
				dt[i].offset_1 = (uint16_t)((uint32_t)ptr & 0x0000ffff);
     137:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     13b:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     13e:	48 98                	cdqe
     140:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     148:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     14c:	48 01 d0             	add    rax,rdx
     14f:	89 ca                	mov    edx,ecx
     151:	66 89 10             	mov    WORD PTR [rax],dx
				dt[i].offset_2 = (uint16_t)((uint32_t)ptr >> 16);
     154:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     158:	c1 e8 10             	shr    eax,0x10
     15b:	89 c1                	mov    ecx,eax
     15d:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     160:	48 98                	cdqe
     162:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     16a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     16e:	48 01 d0             	add    rax,rdx
     171:	89 ca                	mov    edx,ecx
     173:	66 89 50 06          	mov    WORD PTR [rax+0x6],dx
}
     177:	90                   	nop
     178:	c9                   	leave
     179:	c3                   	ret

000000000000017a <print_exception>:
{
     17a:	55                   	push   rbp
     17b:	48 89 e5             	mov    rbp,rsp
     17e:	48 83 ec 10          	sub    rsp,0x10
     182:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     186:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
		while (eip);
     189:	90                   	nop
     18a:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     18f:	75 f9                	jne    18a <print_exception+0x10>
		switch (code) {
     191:	83 7d f4 1e          	cmp    DWORD PTR [rbp-0xc],0x1e
     195:	0f 87 e4 01 00 00    	ja     37f <print_exception+0x205>
     19b:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     19e:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     1a6:	ff e0                	jmp    rax
					printf("#DE at %p\n", eip);
     1a8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ac:	48 89 c6             	mov    rsi,rax
     1af:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     1b6:	b8 00 00 00 00       	mov    eax,0x0
     1bb:	e8 00 00 00 00       	call   1c0 <print_exception+0x46>
					break;
     1c0:	e9 d5 01 00 00       	jmp    39a <print_exception+0x220>
					printf("#BP at %p\n", (void*)((char*)eip-1));
     1c5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1c9:	48 83 e8 01          	sub    rax,0x1
     1cd:	48 89 c6             	mov    rsi,rax
     1d0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     1d7:	b8 00 00 00 00       	mov    eax,0x0
     1dc:	e8 00 00 00 00       	call   1e1 <print_exception+0x67>
					break;
     1e1:	e9 b4 01 00 00       	jmp    39a <print_exception+0x220>
					printf("#OF before %p\n", eip);
     1e6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ea:	48 89 c6             	mov    rsi,rax
     1ed:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     1f4:	b8 00 00 00 00       	mov    eax,0x0
     1f9:	e8 00 00 00 00       	call   1fe <print_exception+0x84>
					break;
     1fe:	e9 97 01 00 00       	jmp    39a <print_exception+0x220>
					printf("#BR at %p\n", eip);
     203:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     207:	48 89 c6             	mov    rsi,rax
     20a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     211:	b8 00 00 00 00       	mov    eax,0x0
     216:	e8 00 00 00 00       	call   21b <print_exception+0xa1>
					while (1);
     21b:	90                   	nop
     21c:	eb fd                	jmp    21b <print_exception+0xa1>
					printf("#UD at %p\n", eip);
     21e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     222:	48 89 c6             	mov    rsi,rax
     225:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     22c:	b8 00 00 00 00       	mov    eax,0x0
     231:	e8 00 00 00 00       	call   236 <print_exception+0xbc>
					while (1);
     236:	90                   	nop
     237:	eb fd                	jmp    236 <print_exception+0xbc>
					printf("#NM at %p\nFPU is disabled or not present\n", eip);
     239:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     23d:	48 89 c6             	mov    rsi,rax
     240:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     247:	b8 00 00 00 00       	mov    eax,0x0
     24c:	e8 00 00 00 00       	call   251 <print_exception+0xd7>
					break;
     251:	e9 44 01 00 00       	jmp    39a <print_exception+0x220>
					printf("#DF with error code %x\n", (unsigned int)eip);
     256:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     25a:	89 c6                	mov    esi,eax
     25c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     263:	b8 00 00 00 00       	mov    eax,0x0
     268:	e8 00 00 00 00       	call   26d <print_exception+0xf3>
					die("that's it");
     26d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     274:	bf 0c 00 00 00       	mov    edi,0xc
     279:	b8 00 00 00 00       	mov    eax,0x0
     27e:	e8 00 00 00 00       	call   283 <print_exception+0x109>
     283:	b8 00 00 00 00       	mov    eax,0x0
     288:	e8 00 00 00 00       	call   28d <print_exception+0x113>
     28d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     294:	e8 00 00 00 00       	call   299 <print_exception+0x11f>
     299:	fa                   	cli
     29a:	f4                   	hlt
     29b:	eb fd                	jmp    29a <print_exception+0x120>
					printf("Legacy coprocessor segment overrun at %p\n", eip);
     29d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2a1:	48 89 c6             	mov    rsi,rax
     2a4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2ab:	b8 00 00 00 00       	mov    eax,0x0
     2b0:	e8 00 00 00 00       	call   2b5 <print_exception+0x13b>
					break;
     2b5:	e9 e0 00 00 00       	jmp    39a <print_exception+0x220>
					printf("Reserved gate called from %p\n", eip);
     2ba:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2be:	48 89 c6             	mov    rsi,rax
     2c1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2c8:	b8 00 00 00 00       	mov    eax,0x0
     2cd:	e8 00 00 00 00       	call   2d2 <print_exception+0x158>
					break;
     2d2:	e9 c3 00 00 00       	jmp    39a <print_exception+0x220>
					printf("#MF at %p\n", eip);
     2d7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2db:	48 89 c6             	mov    rsi,rax
     2de:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2e5:	b8 00 00 00 00       	mov    eax,0x0
     2ea:	e8 00 00 00 00       	call   2ef <print_exception+0x175>
					break;
     2ef:	e9 a6 00 00 00       	jmp    39a <print_exception+0x220>
					printf("#AC at %p\n", eip);
     2f4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2f8:	48 89 c6             	mov    rsi,rax
     2fb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     302:	b8 00 00 00 00       	mov    eax,0x0
     307:	e8 00 00 00 00       	call   30c <print_exception+0x192>
					break;
     30c:	e9 89 00 00 00       	jmp    39a <print_exception+0x220>
					cprintf(KFMT_ERROR, "#MC received while at %p\n", eip);
     311:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     315:	48 89 c2             	mov    rdx,rax
     318:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     31f:	bf 0c 00 00 00       	mov    edi,0xc
     324:	b8 00 00 00 00       	mov    eax,0x0
     329:	e8 00 00 00 00       	call   32e <print_exception+0x1b4>
					while (1);
     32e:	90                   	nop
     32f:	eb fd                	jmp    32e <print_exception+0x1b4>
					printf("#XM at %p\n", eip);
     331:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     335:	48 89 c6             	mov    rsi,rax
     338:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     33f:	b8 00 00 00 00       	mov    eax,0x0
     344:	e8 00 00 00 00       	call   349 <print_exception+0x1cf>
					break;
     349:	eb 4f                	jmp    39a <print_exception+0x220>
					printf("#VE at %p\n", eip);
     34b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     34f:	48 89 c6             	mov    rsi,rax
     352:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     359:	b8 00 00 00 00       	mov    eax,0x0
     35e:	e8 00 00 00 00       	call   363 <print_exception+0x1e9>
					break;
     363:	eb 35                	jmp    39a <print_exception+0x220>
					printf("#SX at %p\n", eip);
     365:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     369:	48 89 c6             	mov    rsi,rax
     36c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     373:	b8 00 00 00 00       	mov    eax,0x0
     378:	e8 00 00 00 00       	call   37d <print_exception+0x203>
					break;
     37d:	eb 1b                	jmp    39a <print_exception+0x220>
					printf("int %x at %p\n", code, eip);
     37f:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     383:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     386:	89 c6                	mov    esi,eax
     388:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     38f:	b8 00 00 00 00       	mov    eax,0x0
     394:	e8 00 00 00 00       	call   399 <print_exception+0x21f>
					break;
     399:	90                   	nop
}
     39a:	90                   	nop
     39b:	c9                   	leave
     39c:	c3                   	ret

000000000000039d <print_idt>:
{
     39d:	55                   	push   rbp
     39e:	48 89 e5             	mov    rbp,rsp
     3a1:	48 83 ec 20          	sub    rsp,0x20
     3a5:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     3a9:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		printf("IDT at %p\n", idt);
     3ac:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3b0:	48 89 c6             	mov    rsi,rax
     3b3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     3ba:	b8 00 00 00 00       	mov    eax,0x0
     3bf:	e8 00 00 00 00       	call   3c4 <print_idt+0x27>
		for (i = 0; i < num; i++) {
     3c4:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     3cb:	eb 5c                	jmp    429 <print_idt+0x8c>
								idt->type_attr);
     3cd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3d1:	0f b6 40 05          	movzx  eax,BYTE PTR [rax+0x5]
				printf("IDT entry %d: %x:%p type=%x\n", i, idt->selector,
     3d5:	0f b6 c8             	movzx  ecx,al
								(void*)((((unsigned int)idt->offset_2) << 16) + idt->offset_1),
     3d8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3dc:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
     3e0:	0f b7 c0             	movzx  eax,ax
     3e3:	c1 e0 10             	shl    eax,0x10
     3e6:	89 c2                	mov    edx,eax
     3e8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3ec:	0f b7 00             	movzx  eax,WORD PTR [rax]
     3ef:	0f b7 c0             	movzx  eax,ax
     3f2:	01 d0                	add    eax,edx
     3f4:	89 c0                	mov    eax,eax
				printf("IDT entry %d: %x:%p type=%x\n", i, idt->selector,
     3f6:	48 89 c6             	mov    rsi,rax
     3f9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3fd:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     401:	0f b7 d0             	movzx  edx,ax
     404:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     407:	41 89 c8             	mov    r8d,ecx
     40a:	48 89 f1             	mov    rcx,rsi
     40d:	89 c6                	mov    esi,eax
     40f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     416:	b8 00 00 00 00       	mov    eax,0x0
     41b:	e8 00 00 00 00       	call   420 <print_idt+0x83>
				idt++;
     420:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
		for (i = 0; i < num; i++) {
     425:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     429:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     42c:	3b 45 e4             	cmp    eax,DWORD PTR [rbp-0x1c]
     42f:	72 9c                	jb     3cd <print_idt+0x30>
}
     431:	90                   	nop
     432:	90                   	nop
     433:	c9                   	leave
     434:	c3                   	ret

0000000000000435 <debug_handler>:
{
     435:	55                   	push   rbp
     436:	48 89 e5             	mov    rbp,rsp
     439:	48 83 ec 10          	sub    rsp,0x10
     43d:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     441:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
		cprintf(KFMT_INFO, "#DB at %p with DR6=%x\n", eip, dr6);
     444:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
     447:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     44b:	89 d1                	mov    ecx,edx
     44d:	48 89 c2             	mov    rdx,rax
     450:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     457:	bf 0b 00 00 00       	mov    edi,0xb
     45c:	b8 00 00 00 00       	mov    eax,0x0
     461:	e8 00 00 00 00       	call   466 <debug_handler+0x31>
		return 0;
     466:	b8 00 00 00 00       	mov    eax,0x0
}
     46b:	c9                   	leave
     46c:	c3                   	ret

000000000000046d <irq_mask>:
{
     46d:	55                   	push   rbp
     46e:	48 89 e5             	mov    rbp,rsp
     471:	48 83 ec 18          	sub    rsp,0x18
     475:	89 f8                	mov    eax,edi
     477:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		if (line < 8)
     47a:	80 7d ec 07          	cmp    BYTE PTR [rbp-0x14],0x7
     47e:	77 08                	ja     488 <irq_mask+0x1b>
				prt = PIC1_DATA;
     480:	66 c7 45 fe 21 00    	mov    WORD PTR [rbp-0x2],0x21
     486:	eb 10                	jmp    498 <irq_mask+0x2b>
		else if (line <= 15) {
     488:	80 7d ec 0f          	cmp    BYTE PTR [rbp-0x14],0xf
     48c:	77 3e                	ja     4cc <irq_mask+0x5f>
				prt = PIC2_DATA;
     48e:	66 c7 45 fe a1 00    	mov    WORD PTR [rbp-0x2],0xa1
				line -= 8;
     494:	80 6d ec 08          	sub    BYTE PTR [rbp-0x14],0x8
		line = inb(prt) | (1 << line);
     498:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     49c:	89 c7                	mov    edi,eax
     49e:	e8 a5 fb ff ff       	call   48 <inb>
     4a3:	89 c6                	mov    esi,eax
     4a5:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     4a9:	ba 01 00 00 00       	mov    edx,0x1
     4ae:	89 c1                	mov    ecx,eax
     4b0:	d3 e2                	shl    edx,cl
     4b2:	89 d0                	mov    eax,edx
     4b4:	09 f0                	or     eax,esi
     4b6:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		outb(prt, line);
     4b9:	0f b6 55 ec          	movzx  edx,BYTE PTR [rbp-0x14]
     4bd:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     4c1:	89 d6                	mov    esi,edx
     4c3:	89 c7                	mov    edi,eax
     4c5:	e8 5f fb ff ff       	call   29 <outb>
     4ca:	eb 01                	jmp    4cd <irq_mask+0x60>
				return;
     4cc:	90                   	nop
}
     4cd:	c9                   	leave
     4ce:	c3                   	ret

00000000000004cf <irq_unmask>:
{
     4cf:	55                   	push   rbp
     4d0:	48 89 e5             	mov    rbp,rsp
     4d3:	48 83 ec 18          	sub    rsp,0x18
     4d7:	89 f8                	mov    eax,edi
     4d9:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		if (line < 8)
     4dc:	80 7d ec 07          	cmp    BYTE PTR [rbp-0x14],0x7
     4e0:	77 08                	ja     4ea <irq_unmask+0x1b>
				prt = PIC1_DATA;
     4e2:	66 c7 45 fe 21 00    	mov    WORD PTR [rbp-0x2],0x21
     4e8:	eb 10                	jmp    4fa <irq_unmask+0x2b>
		else if (line <= 15) {
     4ea:	80 7d ec 0f          	cmp    BYTE PTR [rbp-0x14],0xf
     4ee:	77 40                	ja     530 <irq_unmask+0x61>
				prt = PIC2_DATA;
     4f0:	66 c7 45 fe a1 00    	mov    WORD PTR [rbp-0x2],0xa1
				line -= 8;
     4f6:	80 6d ec 08          	sub    BYTE PTR [rbp-0x14],0x8
		line = inb(prt) & ~(1 << line);
     4fa:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     4fe:	89 c7                	mov    edi,eax
     500:	e8 43 fb ff ff       	call   48 <inb>
     505:	89 c6                	mov    esi,eax
     507:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     50b:	ba 01 00 00 00       	mov    edx,0x1
     510:	89 c1                	mov    ecx,eax
     512:	d3 e2                	shl    edx,cl
     514:	89 d0                	mov    eax,edx
     516:	f7 d0                	not    eax
     518:	21 f0                	and    eax,esi
     51a:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		outb(prt, line);
     51d:	0f b6 55 ec          	movzx  edx,BYTE PTR [rbp-0x14]
     521:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     525:	89 d6                	mov    esi,edx
     527:	89 c7                	mov    edi,eax
     529:	e8 fb fa ff ff       	call   29 <outb>
     52e:	eb 01                	jmp    531 <irq_unmask+0x62>
				return;
     530:	90                   	nop
}
     531:	c9                   	leave
     532:	c3                   	ret

0000000000000533 <pic_disable>:
{
     533:	55                   	push   rbp
     534:	48 89 e5             	mov    rbp,rsp
		outb(PIC2_COMMAND, 0xff);
     537:	be ff 00 00 00       	mov    esi,0xff
     53c:	bf a0 00 00 00       	mov    edi,0xa0
     541:	e8 e3 fa ff ff       	call   29 <outb>
		outb(PIC1_COMMAND, 0xff);
     546:	be ff 00 00 00       	mov    esi,0xff
     54b:	bf 20 00 00 00       	mov    edi,0x20
     550:	e8 d4 fa ff ff       	call   29 <outb>
}
     555:	90                   	nop
     556:	5d                   	pop    rbp
     557:	c3                   	ret

0000000000000558 <pic_get_irr>:
{
     558:	55                   	push   rbp
     559:	48 89 e5             	mov    rbp,rsp
     55c:	53                   	push   rbx
		outb(PIC1_COMMAND, 0x0a); /* PIC_READ_IRR */
     55d:	be 0a 00 00 00       	mov    esi,0xa
     562:	bf 20 00 00 00       	mov    edi,0x20
     567:	e8 bd fa ff ff       	call   29 <outb>
		outb(PIC2_COMMAND, 0x0a);
     56c:	be 0a 00 00 00       	mov    esi,0xa
     571:	bf a0 00 00 00       	mov    edi,0xa0
     576:	e8 ae fa ff ff       	call   29 <outb>
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
     57b:	bf a0 00 00 00       	mov    edi,0xa0
     580:	e8 c3 fa ff ff       	call   48 <inb>
     585:	0f b6 c0             	movzx  eax,al
     588:	c1 e0 08             	shl    eax,0x8
     58b:	89 c3                	mov    ebx,eax
     58d:	bf 20 00 00 00       	mov    edi,0x20
     592:	e8 b1 fa ff ff       	call   48 <inb>
     597:	0f b6 c0             	movzx  eax,al
     59a:	09 d8                	or     eax,ebx
}
     59c:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     5a0:	c9                   	leave
     5a1:	c3                   	ret

00000000000005a2 <pic_get_isr>:
{
     5a2:	55                   	push   rbp
     5a3:	48 89 e5             	mov    rbp,rsp
     5a6:	53                   	push   rbx
		outb(PIC1_COMMAND, 0x0b); /* PIC_READ_ISR */
     5a7:	be 0b 00 00 00       	mov    esi,0xb
     5ac:	bf 20 00 00 00       	mov    edi,0x20
     5b1:	e8 73 fa ff ff       	call   29 <outb>
		outb(PIC2_COMMAND, 0x0b);
     5b6:	be 0b 00 00 00       	mov    esi,0xb
     5bb:	bf a0 00 00 00       	mov    edi,0xa0
     5c0:	e8 64 fa ff ff       	call   29 <outb>
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
     5c5:	bf a0 00 00 00       	mov    edi,0xa0
     5ca:	e8 79 fa ff ff       	call   48 <inb>
     5cf:	0f b6 c0             	movzx  eax,al
     5d2:	c1 e0 08             	shl    eax,0x8
     5d5:	89 c3                	mov    ebx,eax
     5d7:	bf 20 00 00 00       	mov    edi,0x20
     5dc:	e8 67 fa ff ff       	call   48 <inb>
     5e1:	0f b6 c0             	movzx  eax,al
     5e4:	09 d8                	or     eax,ebx
}
     5e6:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     5ea:	c9                   	leave
     5eb:	c3                   	ret

00000000000005ec <enable_com>:
{
     5ec:	55                   	push   rbp
     5ed:	48 89 e5             	mov    rbp,rsp
     5f0:	48 83 ec 08          	sub    rsp,0x8
     5f4:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
     5f7:	89 f0                	mov    eax,esi
     5f9:	66 89 45 f8          	mov    WORD PTR [rbp-0x8],ax
		if (!com_present) {
     5fd:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 603 <enable_com+0x17>
     603:	85 c0                	test   eax,eax
     605:	75 29                	jne    630 <enable_com+0x44>
				com_present = 1;
     607:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 611 <enable_com+0x25>
				def_port = port;
     611:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     615:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 61c <enable_com+0x30>
				irq_unmask(3);
     61c:	bf 03 00 00 00       	mov    edi,0x3
     621:	e8 00 00 00 00       	call   626 <enable_com+0x3a>
				irq_unmask(4);
     626:	bf 04 00 00 00       	mov    edi,0x4
     62b:	e8 00 00 00 00       	call   630 <enable_com+0x44>
		if (num < 4)
     630:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
     634:	7f 11                	jg     647 <enable_com+0x5b>
				com_ports[num] = port;
     636:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     639:	48 98                	cdqe
     63b:	0f b7 55 f8          	movzx  edx,WORD PTR [rbp-0x8]
     63f:	66 89 94 00 00 00 00 00 	mov    WORD PTR [rax+rax*1+0x0],dx
		outb(port + 1, 0x00); /* disable interrupts */
     647:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     64b:	83 c0 01             	add    eax,0x1
     64e:	0f b7 c0             	movzx  eax,ax
     651:	be 00 00 00 00       	mov    esi,0x0
     656:	89 c7                	mov    edi,eax
     658:	e8 cc f9 ff ff       	call   29 <outb>
		outb(port + 3, 0x80); /* DLAB enable */
     65d:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     661:	83 c0 03             	add    eax,0x3
     664:	0f b7 c0             	movzx  eax,ax
     667:	be 80 00 00 00       	mov    esi,0x80
     66c:	89 c7                	mov    edi,eax
     66e:	e8 b6 f9 ff ff       	call   29 <outb>
		outb(port + 0, 0x0c); /* baud 9600 (div 12) */
     673:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     677:	be 0c 00 00 00       	mov    esi,0xc
     67c:	89 c7                	mov    edi,eax
     67e:	e8 a6 f9 ff ff       	call   29 <outb>
		outb(port + 1, 0x00);
     683:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     687:	83 c0 01             	add    eax,0x1
     68a:	0f b7 c0             	movzx  eax,ax
     68d:	be 00 00 00 00       	mov    esi,0x0
     692:	89 c7                	mov    edi,eax
     694:	e8 90 f9 ff ff       	call   29 <outb>
		outb(port + 3, 0x03); /* DLAB disable, 8+1 bits no parity */
     699:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     69d:	83 c0 03             	add    eax,0x3
     6a0:	0f b7 c0             	movzx  eax,ax
     6a3:	be 03 00 00 00       	mov    esi,0x3
     6a8:	89 c7                	mov    edi,eax
     6aa:	e8 7a f9 ff ff       	call   29 <outb>
		outb(port + 2, 0xe7); /* enable FIFO and trigger at 14 bytes and clear */
     6af:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     6b3:	83 c0 02             	add    eax,0x2
     6b6:	0f b7 c0             	movzx  eax,ax
     6b9:	be e7 00 00 00       	mov    esi,0xe7
     6be:	89 c7                	mov    edi,eax
     6c0:	e8 64 f9 ff ff       	call   29 <outb>
		outb(port + 4, 0x0b);
     6c5:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     6c9:	83 c0 04             	add    eax,0x4
     6cc:	0f b7 c0             	movzx  eax,ax
     6cf:	be 0b 00 00 00       	mov    esi,0xb
     6d4:	89 c7                	mov    edi,eax
     6d6:	e8 4e f9 ff ff       	call   29 <outb>
		outb(port + 1, 0x07); /* enable buf empty & recv & line status interrupt */
     6db:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     6df:	83 c0 01             	add    eax,0x1
     6e2:	0f b7 c0             	movzx  eax,ax
     6e5:	be 07 00 00 00       	mov    esi,0x7
     6ea:	89 c7                	mov    edi,eax
     6ec:	e8 38 f9 ff ff       	call   29 <outb>
}
     6f1:	90                   	nop
     6f2:	c9                   	leave
     6f3:	c3                   	ret

00000000000006f4 <com_interrupt>:
{
     6f4:	55                   	push   rbp
     6f5:	48 89 e5             	mov    rbp,rsp
     6f8:	48 83 ec 20          	sub    rsp,0x20
     6fc:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		for (int i = 0; i < 4; i++) {
     6ff:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     706:	e9 c7 01 00 00       	jmp    8d2 <com_interrupt+0x1de>
				port = com_ports[i];
     70b:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     70e:	48 98                	cdqe
     710:	0f b7 84 00 00 00 00 00 	movzx  eax,WORD PTR [rax+rax*1+0x0]
     718:	66 89 45 fa          	mov    WORD PTR [rbp-0x6],ax
				if (!port)
     71c:	66 83 7d fa 00       	cmp    WORD PTR [rbp-0x6],0x0
     721:	0f 84 a3 01 00 00    	je     8ca <com_interrupt+0x1d6>
				iir = inb(port + 2);
     727:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     72b:	83 c0 02             	add    eax,0x2
     72e:	0f b7 c0             	movzx  eax,ax
     731:	89 c7                	mov    edi,eax
     733:	e8 10 f9 ff ff       	call   48 <inb>
     738:	88 45 f9             	mov    BYTE PTR [rbp-0x7],al
				if ((iir & 1)) /* 0 means yes 1 no */
     73b:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     73f:	83 e0 01             	and    eax,0x1
     742:	85 c0                	test   eax,eax
     744:	0f 85 83 01 00 00    	jne    8cd <com_interrupt+0x1d9>
				if ((iir & 0x0e) == 0x00) /* modem status*/
     74a:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     74e:	83 e0 0e             	and    eax,0xe
     751:	85 c0                	test   eax,eax
     753:	75 13                	jne    768 <com_interrupt+0x74>
						inb(port + 6); /* just pop the interrupt */
     755:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     759:	83 c0 06             	add    eax,0x6
     75c:	0f b7 c0             	movzx  eax,ax
     75f:	89 c7                	mov    edi,eax
     761:	e8 e2 f8 ff ff       	call   48 <inb>
     766:	eb 59                	jmp    7c1 <com_interrupt+0xcd>
				else if ((iir & 0x0e) == 0x02) { /* transmitter empty */
     768:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     76c:	83 e0 0e             	and    eax,0xe
     76f:	83 f8 02             	cmp    eax,0x2
     772:	74 4d                	je     7c1 <com_interrupt+0xcd>
				} else if ((iir & 0x0e) == 0x04) { /* data available */
     774:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     778:	83 e0 0e             	and    eax,0xe
     77b:	83 f8 04             	cmp    eax,0x4
     77e:	74 41                	je     7c1 <com_interrupt+0xcd>
				} else if ((iir & 0x0e) == 0x06) { /* line status interrupt */
     780:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     784:	83 e0 0e             	and    eax,0xe
     787:	83 f8 06             	cmp    eax,0x6
     78a:	75 13                	jne    79f <com_interrupt+0xab>
						iprintf("line status:\n");
     78c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     793:	b8 00 00 00 00       	mov    eax,0x0
     798:	e8 00 00 00 00       	call   79d <com_interrupt+0xa9>
     79d:	eb 22                	jmp    7c1 <com_interrupt+0xcd>
				} else if ((iir & 0x0e) == 0x0c) { /* time out */
     79f:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     7a3:	83 e0 0e             	and    eax,0xe
     7a6:	83 f8 0c             	cmp    eax,0xc
     7a9:	74 16                	je     7c1 <com_interrupt+0xcd>
						iprintf("unknown interrupt on COM%d\n", i);
     7ab:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     7ae:	89 c6                	mov    esi,eax
     7b0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     7b7:	b8 00 00 00 00       	mov    eax,0x0
     7bc:	e8 00 00 00 00       	call   7c1 <com_interrupt+0xcd>
				lsr = inb(port + 5);
     7c1:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     7c5:	83 c0 05             	add    eax,0x5
     7c8:	0f b7 c0             	movzx  eax,ax
     7cb:	89 c7                	mov    edi,eax
     7cd:	e8 76 f8 ff ff       	call   48 <inb>
     7d2:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
				if (lsr & (1 << 7)) { /* clear fifo */
     7d5:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     7d9:	84 c0                	test   al,al
     7db:	79 18                	jns    7f5 <com_interrupt+0x101>
						outb(port + 2, 0xc7);
     7dd:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     7e1:	83 c0 02             	add    eax,0x2
     7e4:	0f b7 c0             	movzx  eax,ax
     7e7:	be c7 00 00 00       	mov    esi,0xc7
     7ec:	89 c7                	mov    edi,eax
     7ee:	e8 36 f8 ff ff       	call   29 <outb>
     7f3:	eb 67                	jmp    85c <com_interrupt+0x168>
				} else if (lsr & (1 << 3)) { /* framing error */
     7f5:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     7f9:	83 e0 08             	and    eax,0x8
     7fc:	85 c0                	test   eax,eax
     7fe:	74 18                	je     818 <com_interrupt+0x124>
						iprintf("COM%d framing error\n", i);
     800:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     803:	89 c6                	mov    esi,eax
     805:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     80c:	b8 00 00 00 00       	mov    eax,0x0
     811:	e8 00 00 00 00       	call   816 <com_interrupt+0x122>
     816:	eb 44                	jmp    85c <com_interrupt+0x168>
				} else if (lsr & (1 << 2)) { /* parity error */
     818:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     81c:	83 e0 04             	and    eax,0x4
     81f:	85 c0                	test   eax,eax
     821:	74 18                	je     83b <com_interrupt+0x147>
						iprintf("COM%d parity error\n", i);
     823:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     826:	89 c6                	mov    esi,eax
     828:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     82f:	b8 00 00 00 00       	mov    eax,0x0
     834:	e8 00 00 00 00       	call   839 <com_interrupt+0x145>
     839:	eb 21                	jmp    85c <com_interrupt+0x168>
				} else if (lsr & (1 << 1)) { /* overrun */
     83b:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     83f:	83 e0 02             	and    eax,0x2
     842:	85 c0                	test   eax,eax
     844:	74 16                	je     85c <com_interrupt+0x168>
						iprintf("COM%d overrun\n", i);
     846:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     849:	89 c6                	mov    esi,eax
     84b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     852:	b8 00 00 00 00       	mov    eax,0x0
     857:	e8 00 00 00 00       	call   85c <com_interrupt+0x168>
				if (lsr & 1) { /* data ready */
     85c:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     860:	83 e0 01             	and    eax,0x1
     863:	85 c0                	test   eax,eax
     865:	74 67                	je     8ce <com_interrupt+0x1da>
						iprintf("COM%d data: \"", i);
     867:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     86a:	89 c6                	mov    esi,eax
     86c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     873:	b8 00 00 00 00       	mov    eax,0x0
     878:	e8 00 00 00 00       	call   87d <com_interrupt+0x189>
								char c = inb(port);
     87d:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     881:	89 c7                	mov    edi,eax
     883:	e8 c0 f7 ff ff       	call   48 <inb>
     888:	88 45 f7             	mov    BYTE PTR [rbp-0x9],al
								if (c == 3) { /* TODO: reimplement stub */
     88b:	80 7d f7 03          	cmp    BYTE PTR [rbp-0x9],0x3
     88f:	74 0b                	je     89c <com_interrupt+0x1a8>
										putchar(c);
     891:	0f be 45 f7          	movsx  eax,BYTE PTR [rbp-0x9]
     895:	89 c7                	mov    edi,eax
     897:	e8 00 00 00 00       	call   89c <com_interrupt+0x1a8>
						} while (inb(port + 5) & 1);
     89c:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     8a0:	83 c0 05             	add    eax,0x5
     8a3:	0f b7 c0             	movzx  eax,ax
     8a6:	89 c7                	mov    edi,eax
     8a8:	e8 9b f7 ff ff       	call   48 <inb>
     8ad:	0f b6 c0             	movzx  eax,al
     8b0:	83 e0 01             	and    eax,0x1
     8b3:	85 c0                	test   eax,eax
     8b5:	75 c6                	jne    87d <com_interrupt+0x189>
						iprintf("\"\n");
     8b7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     8be:	b8 00 00 00 00       	mov    eax,0x0
     8c3:	e8 00 00 00 00       	call   8c8 <com_interrupt+0x1d4>
     8c8:	eb 04                	jmp    8ce <com_interrupt+0x1da>
						continue;
     8ca:	90                   	nop
     8cb:	eb 01                	jmp    8ce <com_interrupt+0x1da>
						continue;
     8cd:	90                   	nop
		for (int i = 0; i < 4; i++) {
     8ce:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     8d2:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
     8d6:	0f 8e 2f fe ff ff    	jle    70b <com_interrupt+0x17>
}
     8dc:	90                   	nop
     8dd:	90                   	nop
     8de:	c9                   	leave
     8df:	c3                   	ret

00000000000008e0 <com_status>:
{
     8e0:	55                   	push   rbp
     8e1:	48 89 e5             	mov    rbp,rsp
     8e4:	48 83 ec 10          	sub    rsp,0x10
		for (int i = 0; i < 4; i++)
     8e8:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     8ef:	eb 55                	jmp    946 <com_status+0x66>
				if (com_ports[i]) {
     8f1:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     8f4:	48 98                	cdqe
     8f6:	0f b7 84 00 00 00 00 00 	movzx  eax,WORD PTR [rax+rax*1+0x0]
     8fe:	66 85 c0             	test   ax,ax
     901:	74 3f                	je     942 <com_status+0x62>
						uint16_t port = com_ports[i];
     903:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     906:	48 98                	cdqe
     908:	0f b7 84 00 00 00 00 00 	movzx  eax,WORD PTR [rax+rax*1+0x0]
     910:	66 89 45 fa          	mov    WORD PTR [rbp-0x6],ax
						lsr = inb(port + 5);
     914:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     918:	83 c0 05             	add    eax,0x5
     91b:	0f b7 c0             	movzx  eax,ax
     91e:	89 c7                	mov    edi,eax
     920:	e8 23 f7 ff ff       	call   48 <inb>
     925:	88 45 f9             	mov    BYTE PTR [rbp-0x7],al
						printf("COM%d lsr: %08b\n", i, lsr);
     928:	0f b6 55 f9          	movzx  edx,BYTE PTR [rbp-0x7]
     92c:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     92f:	89 c6                	mov    esi,eax
     931:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     938:	b8 00 00 00 00       	mov    eax,0x0
     93d:	e8 00 00 00 00       	call   942 <com_status+0x62>
		for (int i = 0; i < 4; i++)
     942:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     946:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
     94a:	7e a5                	jle    8f1 <com_status+0x11>
}
     94c:	90                   	nop
     94d:	90                   	nop
     94e:	c9                   	leave
     94f:	c3                   	ret

0000000000000950 <is_transit_empty>:
{
     950:	55                   	push   rbp
     951:	48 89 e5             	mov    rbp,rsp
     954:	48 83 ec 08          	sub    rsp,0x8
     958:	89 f8                	mov    eax,edi
     95a:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
		return inb(port + 5) & 0x20;
     95e:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
     962:	83 c0 05             	add    eax,0x5
     965:	0f b7 c0             	movzx  eax,ax
     968:	89 c7                	mov    edi,eax
     96a:	e8 d9 f6 ff ff       	call   48 <inb>
     96f:	0f b6 c0             	movzx  eax,al
     972:	83 e0 20             	and    eax,0x20
}
     975:	c9                   	leave
     976:	c3                   	ret

0000000000000977 <putDebugChar>:
{
     977:	55                   	push   rbp
     978:	48 89 e5             	mov    rbp,rsp
     97b:	48 83 ec 08          	sub    rsp,0x8
     97f:	89 f8                	mov    eax,edi
     981:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
		while (!is_transit_empty(def_port));
     984:	90                   	nop
     985:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 98c <putDebugChar+0x15>
     98c:	0f b7 c0             	movzx  eax,ax
     98f:	89 c7                	mov    edi,eax
     991:	e8 00 00 00 00       	call   996 <putDebugChar+0x1f>
     996:	85 c0                	test   eax,eax
     998:	74 eb                	je     985 <putDebugChar+0xe>
		outb(def_port, c);
     99a:	0f b6 45 fc          	movzx  eax,BYTE PTR [rbp-0x4]
     99e:	0f b6 d0             	movzx  edx,al
     9a1:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9a8 <putDebugChar+0x31>
     9a8:	0f b7 c0             	movzx  eax,ax
     9ab:	89 d6                	mov    esi,edx
     9ad:	89 c7                	mov    edi,eax
     9af:	e8 75 f6 ff ff       	call   29 <outb>
}
     9b4:	90                   	nop
     9b5:	c9                   	leave
     9b6:	c3                   	ret

00000000000009b7 <serial_received>:
{
     9b7:	55                   	push   rbp
     9b8:	48 89 e5             	mov    rbp,rsp
     9bb:	48 83 ec 08          	sub    rsp,0x8
     9bf:	89 f8                	mov    eax,edi
     9c1:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
		return inb(port + 5) & 1;
     9c5:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
     9c9:	83 c0 05             	add    eax,0x5
     9cc:	0f b7 c0             	movzx  eax,ax
     9cf:	89 c7                	mov    edi,eax
     9d1:	e8 72 f6 ff ff       	call   48 <inb>
     9d6:	0f b6 c0             	movzx  eax,al
     9d9:	83 e0 01             	and    eax,0x1
}
     9dc:	c9                   	leave
     9dd:	c3                   	ret

00000000000009de <getDebugChar>:
{
     9de:	55                   	push   rbp
     9df:	48 89 e5             	mov    rbp,rsp
		while (!serial_received(def_port));
     9e2:	90                   	nop
     9e3:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9ea <getDebugChar+0xc>
     9ea:	0f b7 c0             	movzx  eax,ax
     9ed:	89 c7                	mov    edi,eax
     9ef:	e8 00 00 00 00       	call   9f4 <getDebugChar+0x16>
     9f4:	85 c0                	test   eax,eax
     9f6:	74 eb                	je     9e3 <getDebugChar+0x5>
		return inb(def_port);
     9f8:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9ff <getDebugChar+0x21>
     9ff:	0f b7 c0             	movzx  eax,ax
     a02:	89 c7                	mov    edi,eax
     a04:	e8 3f f6 ff ff       	call   48 <inb>
}
     a09:	5d                   	pop    rbp
     a0a:	c3                   	ret

0000000000000a0b <forward_irq>:
{
     a0b:	55                   	push   rbp
     a0c:	48 89 e5             	mov    rbp,rsp
     a0f:	48 83 ec 20          	sub    rsp,0x20
     a13:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		if (!irq || irq > 15)
     a16:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     a1a:	74 45                	je     a61 <forward_irq+0x56>
     a1c:	83 7d ec 0f          	cmp    DWORD PTR [rbp-0x14],0xf
     a20:	77 3f                	ja     a61 <forward_irq+0x56>
		pt = irq_funs[--irq]; /* 1 based */
     a22:	83 6d ec 01          	sub    DWORD PTR [rbp-0x14],0x1
     a26:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     a29:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     a31:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (pt) {
     a35:	eb 21                	jmp    a58 <forward_irq+0x4d>
				if (pt->fun(irq + 1)) /* handled */
     a37:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a3b:	48 8b 00             	mov    rax,QWORD PTR [rax]
     a3e:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
     a41:	83 c2 01             	add    edx,0x1
     a44:	89 d7                	mov    edi,edx
     a46:	ff d0                	call   rax
     a48:	85 c0                	test   eax,eax
     a4a:	75 18                	jne    a64 <forward_irq+0x59>
				pt = pt->next;
     a4c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a50:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     a54:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (pt) {
     a58:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     a5d:	75 d8                	jne    a37 <forward_irq+0x2c>
     a5f:	eb 04                	jmp    a65 <forward_irq+0x5a>
				return;
     a61:	90                   	nop
     a62:	eb 01                	jmp    a65 <forward_irq+0x5a>
						break;
     a64:	90                   	nop
}
     a65:	c9                   	leave
     a66:	c3                   	ret

0000000000000a67 <install_irq_handler>:
{
     a67:	55                   	push   rbp
     a68:	48 89 e5             	mov    rbp,rsp
     a6b:	48 83 ec 20          	sub    rsp,0x20
     a6f:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
     a72:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		if (!irq || irq > 15)
     a76:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     a7a:	74 06                	je     a82 <install_irq_handler+0x1b>
     a7c:	83 7d ec 0f          	cmp    DWORD PTR [rbp-0x14],0xf
     a80:	76 0a                	jbe    a8c <install_irq_handler+0x25>
				return 0;
     a82:	b8 00 00 00 00       	mov    eax,0x0
     a87:	e9 9a 00 00 00       	jmp    b26 <install_irq_handler+0xbf>
		struct irqe* p = kmalloc(sizeof(*p));
     a8c:	bf 10 00 00 00       	mov    edi,0x10
     a91:	e8 00 00 00 00       	call   a96 <install_irq_handler+0x2f>
     a96:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!p)
     a9a:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     a9f:	75 07                	jne    aa8 <install_irq_handler+0x41>
				return 0;
     aa1:	b8 00 00 00 00       	mov    eax,0x0
     aa6:	eb 7e                	jmp    b26 <install_irq_handler+0xbf>
		p->fun = fun;
     aa8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     aac:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     ab0:	48 89 10             	mov    QWORD PTR [rax],rdx
		if (!irq_funs[irq - 1])
     ab3:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     ab6:	83 e8 01             	sub    eax,0x1
     ab9:	89 c0                	mov    eax,eax
     abb:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     ac3:	48 85 c0             	test   rax,rax
     ac6:	75 0d                	jne    ad5 <install_irq_handler+0x6e>
				irq_unmask(irq);
     ac8:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     acb:	0f b6 c0             	movzx  eax,al
     ace:	89 c7                	mov    edi,eax
     ad0:	e8 00 00 00 00       	call   ad5 <install_irq_handler+0x6e>
				p->next = irq_funs[irq - 1];
     ad5:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     ad8:	83 e8 01             	sub    eax,0x1
     adb:	89 c0                	mov    eax,eax
     add:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
     ae5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ae9:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		} while (!__sync_bool_compare_and_swap(&irq_funs[irq - 1], p->next, p));
     aed:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     af1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     af5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     af9:	48 89 c6             	mov    rsi,rax
     afc:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     aff:	83 e8 01             	sub    eax,0x1
     b02:	89 c0                	mov    eax,eax
     b04:	48 c1 e0 03          	shl    rax,0x3
     b08:	48 8d 88 00 00 00 00 	lea    rcx,[rax+0x0]
     b0f:	48 89 f0             	mov    rax,rsi
     b12:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     b17:	0f 94 c0             	sete   al
     b1a:	83 f0 01             	xor    eax,0x1
     b1d:	84 c0                	test   al,al
     b1f:	75 b4                	jne    ad5 <install_irq_handler+0x6e>
		return 1;
     b21:	b8 01 00 00 00       	mov    eax,0x1
}
     b26:	c9                   	leave
     b27:	c3                   	ret

0000000000000b28 <remove_irq_handler>:
{
     b28:	55                   	push   rbp
     b29:	48 89 e5             	mov    rbp,rsp
     b2c:	48 83 ec 20          	sub    rsp,0x20
     b30:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
     b33:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		struct irqe* pt, *prev = NULL;
     b37:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (!irq || irq > 15)
     b3f:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     b43:	74 09                	je     b4e <remove_irq_handler+0x26>
     b45:	83 7d ec 0f          	cmp    DWORD PTR [rbp-0x14],0xf
     b49:	77 03                	ja     b4e <remove_irq_handler+0x26>
start:
     b4b:	90                   	nop
     b4c:	eb 0b                	jmp    b59 <remove_irq_handler+0x31>
				return 0;
     b4e:	b8 00 00 00 00       	mov    eax,0x0
     b53:	e9 c2 00 00 00       	jmp    c1a <remove_irq_handler+0xf2>
										goto start;
     b58:	90                   	nop
		pt = irq_funs[irq - 1];
     b59:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     b5c:	83 e8 01             	sub    eax,0x1
     b5f:	89 c0                	mov    eax,eax
     b61:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     b69:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (pt) {
     b6d:	e9 98 00 00 00       	jmp    c0a <remove_irq_handler+0xe2>
				if (pt->fun == fun) {
     b72:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b76:	48 8b 00             	mov    rax,QWORD PTR [rax]
     b79:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
     b7d:	75 77                	jne    bf6 <remove_irq_handler+0xce>
						if (prev) {
     b7f:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     b84:	74 28                	je     bae <remove_irq_handler+0x86>
														pt, pt->next))
     b86:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b8a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								if (!__sync_bool_compare_and_swap(&prev->next,
     b8e:	48 89 c1             	mov    rcx,rax
     b91:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b95:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     b99:	48 83 c2 08          	add    rdx,0x8
     b9d:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     ba2:	0f 94 c0             	sete   al
     ba5:	83 f0 01             	xor    eax,0x1
     ba8:	84 c0                	test   al,al
     baa:	74 37                	je     be3 <remove_irq_handler+0xbb>
										goto start;
     bac:	eb ab                	jmp    b59 <remove_irq_handler+0x31>
														pt, pt->next))
     bae:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bb2:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								if (!__sync_bool_compare_and_swap(&irq_funs[irq - 1],
     bb6:	48 89 c1             	mov    rcx,rax
     bb9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bbd:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
     bc0:	83 ea 01             	sub    edx,0x1
     bc3:	89 d2                	mov    edx,edx
     bc5:	48 c1 e2 03          	shl    rdx,0x3
     bc9:	48 81 c2 00 00 00 00 	add    rdx,0x0
     bd0:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     bd5:	0f 94 c0             	sete   al
     bd8:	83 f0 01             	xor    eax,0x1
     bdb:	84 c0                	test   al,al
     bdd:	0f 85 75 ff ff ff    	jne    b58 <remove_irq_handler+0x30>
						kfree(pt);
     be3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     be7:	48 89 c7             	mov    rdi,rax
     bea:	e8 00 00 00 00       	call   bef <remove_irq_handler+0xc7>
						return 1;
     bef:	b8 01 00 00 00       	mov    eax,0x1
     bf4:	eb 24                	jmp    c1a <remove_irq_handler+0xf2>
				prev = pt;
     bf6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bfa:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				pt = pt->next;
     bfe:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c02:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     c06:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (pt) {
     c0a:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     c0f:	0f 85 5d ff ff ff    	jne    b72 <remove_irq_handler+0x4a>
		return 0;
     c15:	b8 00 00 00 00       	mov    eax,0x0
}
     c1a:	c9                   	leave
     c1b:	c3                   	ret

0000000000000c1c <msi_handler>:
{
     c1c:	55                   	push   rbp
     c1d:	48 89 e5             	mov    rbp,rsp
     c20:	48 83 ec 10          	sub    rsp,0x10
     c24:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		iprintf("MSI %u received on processor %u\n", msi, smp_processor_id());
     c27:	b8 00 00 00 00       	mov    eax,0x0
     c2c:	e8 cf f3 ff ff       	call   0 <per_cpu_ptr>
     c31:	8b 10                	mov    edx,DWORD PTR [rax]
     c33:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     c36:	89 c6                	mov    esi,eax
     c38:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c3f:	b8 00 00 00 00       	mov    eax,0x0
     c44:	e8 00 00 00 00       	call   c49 <msi_handler+0x2d>
}
     c49:	90                   	nop
     c4a:	c9                   	leave
     c4b:	c3                   	ret

0000000000000c4c <irq_handler>:
{
     c4c:	55                   	push   rbp
     c4d:	48 89 e5             	mov    rbp,rsp
     c50:	48 83 ec 20          	sub    rsp,0x20
     c54:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		int spurious = 0; void (*hook)();
     c57:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		if (irq >= 8) { /* check if intr from I/O APIC */
     c5e:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     c61:	83 f8 07             	cmp    eax,0x7
     c64:	76 60                	jbe    cc6 <irq_handler+0x7a>
				isr = pic_get_isr();
     c66:	b8 00 00 00 00       	mov    eax,0x0
     c6b:	e8 00 00 00 00       	call   c70 <irq_handler+0x24>
     c70:	66 89 45 fa          	mov    WORD PTR [rbp-0x6],ax
				if (!isr) { /* we have a PCI interrupt */
     c74:	66 83 7d fa 00       	cmp    WORD PTR [rbp-0x6],0x0
     c79:	75 4b                	jne    cc6 <irq_handler+0x7a>
						iprintf("PCI IRQ %u\n", irq);
     c7b:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     c7e:	89 c6                	mov    esi,eax
     c80:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c87:	b8 00 00 00 00       	mov    eax,0x0
     c8c:	e8 00 00 00 00       	call   c91 <irq_handler+0x45>
						framebuffer_redraw(&fb_initial);
     c91:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c98:	e8 00 00 00 00       	call   c9d <irq_handler+0x51>
						forward_irq(irq);
     c9d:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     ca0:	89 c7                	mov    edi,eax
     ca2:	e8 00 00 00 00       	call   ca7 <irq_handler+0x5b>
						apic_reg(APIC_REG_EOI) = 0;
     ca7:	b8 00 00 00 00       	mov    eax,0x0
     cac:	e8 4f f3 ff ff       	call   0 <per_cpu_ptr>
     cb1:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     cb5:	48 05 b0 00 00 00    	add    rax,0xb0
     cbb:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
						return; /* don't signal the PIC */
     cc1:	e9 0a 01 00 00       	jmp    dd0 <irq_handler+0x184>
		switch (irq) {
     cc6:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     cc9:	83 f8 0f             	cmp    eax,0xf
     ccc:	0f 87 8c 00 00 00    	ja     d5e <irq_handler+0x112>
     cd2:	89 c0                	mov    eax,eax
     cd4:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     cdc:	ff e0                	jmp    rax
					if ((hook = irq0_hook))
     cde:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ce5 <irq_handler+0x99>
     ce5:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     ce9:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     cee:	74 0b                	je     cfb <irq_handler+0xaf>
							hook();
     cf0:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     cf4:	b8 00 00 00 00       	mov    eax,0x0
     cf9:	ff d2                	call   rdx
					ktimer_tick();
     cfb:	b8 00 00 00 00       	mov    eax,0x0
     d00:	e8 00 00 00 00       	call   d05 <irq_handler+0xb9>
					break;
     d05:	eb 5e                	jmp    d65 <irq_handler+0x119>
					kbd_handler();
     d07:	b8 00 00 00 00       	mov    eax,0x0
     d0c:	e8 00 00 00 00       	call   d11 <irq_handler+0xc5>
					break;
     d11:	eb 52                	jmp    d65 <irq_handler+0x119>
					com_interrupt(irq);
     d13:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     d16:	89 c7                	mov    edi,eax
     d18:	e8 00 00 00 00       	call   d1d <irq_handler+0xd1>
					break;
     d1d:	eb 46                	jmp    d65 <irq_handler+0x119>
					if (!(pic_get_isr() & (1 << 7)))
     d1f:	b8 00 00 00 00       	mov    eax,0x0
     d24:	e8 00 00 00 00       	call   d29 <irq_handler+0xdd>
     d29:	0f b7 c0             	movzx  eax,ax
     d2c:	25 80 00 00 00       	and    eax,0x80
     d31:	85 c0                	test   eax,eax
     d33:	75 2c                	jne    d61 <irq_handler+0x115>
							spurious = 1;
     d35:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
					break;
     d3c:	eb 23                	jmp    d61 <irq_handler+0x115>
					if (irq == 15 && !(pic_get_isr() & (1 << 15)))
     d3e:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     d41:	83 f8 0f             	cmp    eax,0xf
     d44:	75 1e                	jne    d64 <irq_handler+0x118>
     d46:	b8 00 00 00 00       	mov    eax,0x0
     d4b:	e8 00 00 00 00       	call   d50 <irq_handler+0x104>
     d50:	66 85 c0             	test   ax,ax
     d53:	78 0f                	js     d64 <irq_handler+0x118>
							spurious = 1;
     d55:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
					break;
     d5c:	eb 06                	jmp    d64 <irq_handler+0x118>
					break;
     d5e:	90                   	nop
     d5f:	eb 04                	jmp    d65 <irq_handler+0x119>
					break;
     d61:	90                   	nop
     d62:	eb 01                	jmp    d65 <irq_handler+0x119>
					break;
     d64:	90                   	nop
		if(!spurious && irq > 7) /* ack to slave if needed */
     d65:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     d69:	75 17                	jne    d82 <irq_handler+0x136>
     d6b:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     d6e:	83 f8 07             	cmp    eax,0x7
     d71:	76 0f                	jbe    d82 <irq_handler+0x136>
				outb(PIC2, 0x20);
     d73:	be 20 00 00 00       	mov    esi,0x20
     d78:	bf a0 00 00 00       	mov    edi,0xa0
     d7d:	e8 a7 f2 ff ff       	call   29 <outb>
		if (!spurious || irq > 7)
     d82:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     d86:	74 08                	je     d90 <irq_handler+0x144>
     d88:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     d8b:	83 f8 07             	cmp    eax,0x7
     d8e:	76 0f                	jbe    d9f <irq_handler+0x153>
				outb(PIC1, 0x20); /* ack interrupt (even sp. from slave) */
     d90:	be 20 00 00 00       	mov    esi,0x20
     d95:	bf 20 00 00 00       	mov    edi,0x20
     d9a:	e8 8a f2 ff ff       	call   29 <outb>
		if (!spurious && irq)
     d9f:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     da3:	75 11                	jne    db6 <irq_handler+0x16a>
     da5:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     da8:	85 c0                	test   eax,eax
     daa:	74 0a                	je     db6 <irq_handler+0x16a>
				forward_irq(irq);
     dac:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     daf:	89 c7                	mov    edi,eax
     db1:	e8 00 00 00 00       	call   db6 <irq_handler+0x16a>
		if (!irq)
     db6:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     db9:	85 c0                	test   eax,eax
     dbb:	75 13                	jne    dd0 <irq_handler+0x184>
				task_schedule_isr(*(void**)(&irq + 1));
     dbd:	48 8d 45 ec          	lea    rax,[rbp-0x14]
     dc1:	48 83 c0 04          	add    rax,0x4
     dc5:	48 8b 00             	mov    rax,QWORD PTR [rax]
     dc8:	48 89 c7             	mov    rdi,rax
     dcb:	e8 00 00 00 00       	call   dd0 <irq_handler+0x184>
}
     dd0:	c9                   	leave
     dd1:	c3                   	ret

0000000000000dd2 <nmi_handler>:
{
     dd2:	55                   	push   rbp
     dd3:	48 89 e5             	mov    rbp,rsp
     dd6:	48 83 ec 20          	sub    rsp,0x20
     dda:	89 fa                	mov    edx,edi
     ddc:	89 f0                	mov    eax,esi
     dde:	88 55 ec             	mov    BYTE PTR [rbp-0x14],dl
     de1:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
		if (port_a & 0x10) {
     de4:	0f b6 45 e8          	movzx  eax,BYTE PTR [rbp-0x18]
     de8:	83 e0 10             	and    eax,0x10
     deb:	85 c0                	test   eax,eax
     ded:	74 1b                	je     e0a <nmi_handler+0x38>
				printf("NMI watchdog received\n");
     def:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     df6:	b8 00 00 00 00       	mov    eax,0x0
     dfb:	e8 00 00 00 00       	call   e00 <nmi_handler+0x2e>
				return 0;
     e00:	b8 00 00 00 00       	mov    eax,0x0
     e05:	e9 a2 00 00 00       	jmp    eac <nmi_handler+0xda>
		if (port_b & 0x40)
     e0a:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     e0e:	83 e0 40             	and    eax,0x40
     e11:	85 c0                	test   eax,eax
     e13:	74 13                	je     e28 <nmi_handler+0x56>
				printf("Hardware bus channel error\n");
     e15:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e1c:	b8 00 00 00 00       	mov    eax,0x0
     e21:	e8 00 00 00 00       	call   e26 <nmi_handler+0x54>
     e26:	eb 36                	jmp    e5e <nmi_handler+0x8c>
		else if (port_b & 0x80)
     e28:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     e2c:	84 c0                	test   al,al
     e2e:	79 13                	jns    e43 <nmi_handler+0x71>
				printf("Memory read/write error\n");
     e30:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e37:	b8 00 00 00 00       	mov    eax,0x0
     e3c:	e8 00 00 00 00       	call   e41 <nmi_handler+0x6f>
     e41:	eb 1b                	jmp    e5e <nmi_handler+0x8c>
				printf("Unknown NMI error A=%x, B=%x\n", port_a, port_b);
     e43:	0f b6 55 ec          	movzx  edx,BYTE PTR [rbp-0x14]
     e47:	0f b6 45 e8          	movzx  eax,BYTE PTR [rbp-0x18]
     e4b:	89 c6                	mov    esi,eax
     e4d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e54:	b8 00 00 00 00       	mov    eax,0x0
     e59:	e8 00 00 00 00       	call   e5e <nmi_handler+0x8c>
		puts("restarting");
     e5e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e65:	e8 00 00 00 00       	call   e6a <nmi_handler+0x98>
		for (i = 0; i < 3; i++) {
     e6a:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     e71:	eb 24                	jmp    e97 <nmi_handler+0xc5>
				for (j = 0; j < INT_MAX; j++);
     e73:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
     e7a:	eb 04                	jmp    e80 <nmi_handler+0xae>
     e7c:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
     e80:	81 7d f8 ff ff ff 7f 	cmp    DWORD PTR [rbp-0x8],0x7fffffff
     e87:	75 f3                	jne    e7c <nmi_handler+0xaa>
				putchar('.');
     e89:	bf 2e 00 00 00       	mov    edi,0x2e
     e8e:	e8 00 00 00 00       	call   e93 <nmi_handler+0xc1>
		for (i = 0; i < 3; i++) {
     e93:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     e97:	83 7d fc 02          	cmp    DWORD PTR [rbp-0x4],0x2
     e9b:	7e d6                	jle    e73 <nmi_handler+0xa1>
		putchar('\n');
     e9d:	bf 0a 00 00 00       	mov    edi,0xa
     ea2:	e8 00 00 00 00       	call   ea7 <nmi_handler+0xd5>
		return 1;
     ea7:	b8 01 00 00 00       	mov    eax,0x1
}
     eac:	c9                   	leave
     ead:	c3                   	ret

0000000000000eae <segment_handler>:
{
     eae:	55                   	push   rbp
     eaf:	48 89 e5             	mov    rbp,rsp
     eb2:	48 83 ec 30          	sub    rsp,0x30
     eb6:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     eba:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
     ebd:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
     ec1:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
		const char* tp = "#UNKNOWN";
     ec4:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		switch(type) {
     ecc:	83 7d e0 04          	cmp    DWORD PTR [rbp-0x20],0x4
     ed0:	77 3e                	ja     f10 <segment_handler+0x62>
     ed2:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
     ed5:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     edd:	ff e0                	jmp    rax
				case 0: tp = "#TS"; break;
     edf:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     ee7:	eb 27                	jmp    f10 <segment_handler+0x62>
				case 1: tp = "#NP"; break;
     ee9:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     ef1:	eb 1d                	jmp    f10 <segment_handler+0x62>
				case 2: tp = "#SS"; break;
     ef3:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     efb:	eb 13                	jmp    f10 <segment_handler+0x62>
				case 3: tp = "#GP"; break;
     efd:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     f05:	eb 09                	jmp    f10 <segment_handler+0x62>
				case 4: tp = "#PF"; break;
     f07:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     f0f:	90                   	nop
		if (type == 4) {
     f10:	83 7d e0 04          	cmp    DWORD PTR [rbp-0x20],0x4
     f14:	75 22                	jne    f38 <segment_handler+0x8a>
				if(mm_handle_pagefault(&mm_kernel, eip, seg_error, cr2) == 0)
     f16:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
     f1a:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
     f1d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     f21:	48 89 c6             	mov    rsi,rax
     f24:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f2b:	e8 00 00 00 00       	call   f30 <segment_handler+0x82>
     f30:	85 c0                	test   eax,eax
     f32:	0f 84 0f 01 00 00    	je     1047 <segment_handler+0x199>
		cprintf(KFMT_INFO, "Segment exception handler: %s at %p with error %x (cr2=%p)\n",
     f38:	48 8b 75 d8          	mov    rsi,QWORD PTR [rbp-0x28]
     f3c:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
     f3f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     f43:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f47:	49 89 f1             	mov    r9,rsi
     f4a:	41 89 c8             	mov    r8d,ecx
     f4d:	48 89 d1             	mov    rcx,rdx
     f50:	48 89 c2             	mov    rdx,rax
     f53:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f5a:	bf 0b 00 00 00       	mov    edi,0xb
     f5f:	b8 00 00 00 00       	mov    eax,0x0
     f64:	e8 00 00 00 00       	call   f69 <segment_handler+0xbb>
		if (seg_error != 4) {
     f69:	83 7d e4 04          	cmp    DWORD PTR [rbp-0x1c],0x4
     f6d:	0f 84 a4 00 00 00    	je     1017 <segment_handler+0x169>
					  (seg_error & 0xffff8) >> 3);
     f73:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     f76:	c1 e8 03             	shr    eax,0x3
				printf("The segment error originated %s and"
     f79:	25 ff ff 01 00       	and    eax,0x1ffff
     f7e:	89 c2                	mov    edx,eax
						(seg_error & 2) ? "interrupt" : ((seg_error & 4) ? "local" : "global"),
     f80:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     f83:	83 e0 02             	and    eax,0x2
				printf("The segment error originated %s and"
     f86:	85 c0                	test   eax,eax
     f88:	75 1c                	jne    fa6 <segment_handler+0xf8>
						(seg_error & 2) ? "interrupt" : ((seg_error & 4) ? "local" : "global"),
     f8a:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     f8d:	83 e0 04             	and    eax,0x4
     f90:	85 c0                	test   eax,eax
     f92:	74 09                	je     f9d <segment_handler+0xef>
     f94:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     f9b:	eb 10                	jmp    fad <segment_handler+0xff>
     f9d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     fa4:	eb 07                	jmp    fad <segment_handler+0xff>
				printf("The segment error originated %s and"
     fa6:	48 c7 c0 00 00 00 00 	mov    rax,0x0
						(seg_error & 1) ? "external" : "internal",
     fad:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
     fb0:	83 e1 01             	and    ecx,0x1
				printf("The segment error originated %s and"
     fb3:	85 c9                	test   ecx,ecx
     fb5:	74 09                	je     fc0 <segment_handler+0x112>
     fb7:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     fbe:	eb 07                	jmp    fc7 <segment_handler+0x119>
     fc0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     fc7:	89 d1                	mov    ecx,edx
     fc9:	48 89 c2             	mov    rdx,rax
     fcc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     fd3:	b8 00 00 00 00       	mov    eax,0x0
     fd8:	e8 00 00 00 00       	call   fdd <segment_handler+0x12f>
				print_stacktrace();
     fdd:	b8 00 00 00 00       	mov    eax,0x0
     fe2:	e8 00 00 00 00       	call   fe7 <segment_handler+0x139>
				die("segment death\n");
     fe7:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     fee:	bf 0c 00 00 00       	mov    edi,0xc
     ff3:	b8 00 00 00 00       	mov    eax,0x0
     ff8:	e8 00 00 00 00       	call   ffd <segment_handler+0x14f>
     ffd:	b8 00 00 00 00       	mov    eax,0x0
    1002:	e8 00 00 00 00       	call   1007 <segment_handler+0x159>
    1007:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    100e:	e8 00 00 00 00       	call   1013 <segment_handler+0x165>
    1013:	fa                   	cli
    1014:	f4                   	hlt
    1015:	eb fd                	jmp    1014 <segment_handler+0x166>
				die("unfixable #PF\n");
    1017:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    101e:	bf 0c 00 00 00       	mov    edi,0xc
    1023:	b8 00 00 00 00       	mov    eax,0x0
    1028:	e8 00 00 00 00       	call   102d <segment_handler+0x17f>
    102d:	b8 00 00 00 00       	mov    eax,0x0
    1032:	e8 00 00 00 00       	call   1037 <segment_handler+0x189>
    1037:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    103e:	e8 00 00 00 00       	call   1043 <segment_handler+0x195>
    1043:	fa                   	cli
    1044:	f4                   	hlt
    1045:	eb fd                	jmp    1044 <segment_handler+0x196>
						return; /* continue execution */
    1047:	90                   	nop
}
    1048:	c9                   	leave
    1049:	c3                   	ret

000000000000104a <PIC_remap>:
{
    104a:	55                   	push   rbp
    104b:	48 89 e5             	mov    rbp,rsp
    104e:	48 83 ec 20          	sub    rsp,0x20
    1052:	89 fa                	mov    edx,edi
    1054:	89 f0                	mov    eax,esi
    1056:	88 55 ec             	mov    BYTE PTR [rbp-0x14],dl
    1059:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
		a1 = inb(PIC1_DATA);                      /* save the masks */
    105c:	bf 21 00 00 00       	mov    edi,0x21
    1061:	e8 e2 ef ff ff       	call   48 <inb>
    1066:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
		a2 = inb(PIC2_DATA);
    1069:	bf a1 00 00 00       	mov    edi,0xa1
    106e:	e8 d5 ef ff ff       	call   48 <inb>
    1073:	88 45 fe             	mov    BYTE PTR [rbp-0x2],al
		outb(PIC1_COMMAND, ICW1_INIT+ICW1_ICW4);  /* start the initialization */
    1076:	be 11 00 00 00       	mov    esi,0x11
    107b:	bf 20 00 00 00       	mov    edi,0x20
    1080:	e8 a4 ef ff ff       	call   29 <outb>
		io_wait();                                /* expects 3 control bytes */
    1085:	b8 00 00 00 00       	mov    eax,0x0
    108a:	e8 8c ef ff ff       	call   1b <io_wait>
		outb(PIC2_COMMAND, ICW1_INIT+ICW1_ICW4);
    108f:	be 11 00 00 00       	mov    esi,0x11
    1094:	bf a0 00 00 00       	mov    edi,0xa0
    1099:	e8 8b ef ff ff       	call   29 <outb>
		io_wait();
    109e:	b8 00 00 00 00       	mov    eax,0x0
    10a3:	e8 73 ef ff ff       	call   1b <io_wait>
		outb(PIC1_DATA, ofs1);                    /* master gate offset */
    10a8:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
    10ac:	89 c6                	mov    esi,eax
    10ae:	bf 21 00 00 00       	mov    edi,0x21
    10b3:	e8 71 ef ff ff       	call   29 <outb>
		io_wait();
    10b8:	b8 00 00 00 00       	mov    eax,0x0
    10bd:	e8 59 ef ff ff       	call   1b <io_wait>
		outb(PIC2_DATA, ofs2);                    /* slave gate offset */
    10c2:	0f b6 45 e8          	movzx  eax,BYTE PTR [rbp-0x18]
    10c6:	89 c6                	mov    esi,eax
    10c8:	bf a1 00 00 00       	mov    edi,0xa1
    10cd:	e8 57 ef ff ff       	call   29 <outb>
		io_wait();
    10d2:	b8 00 00 00 00       	mov    eax,0x0
    10d7:	e8 3f ef ff ff       	call   1b <io_wait>
		outb(PIC1_DATA, 4);                       /* tell master of the presence */
    10dc:	be 04 00 00 00       	mov    esi,0x4
    10e1:	bf 21 00 00 00       	mov    edi,0x21
    10e6:	e8 3e ef ff ff       	call   29 <outb>
		io_wait();                                /* of slave at IRQ2 (1<<2) */
    10eb:	b8 00 00 00 00       	mov    eax,0x0
    10f0:	e8 26 ef ff ff       	call   1b <io_wait>
		outb(PIC2_DATA, 2);                       /* tell slave it's second */
    10f5:	be 02 00 00 00       	mov    esi,0x2
    10fa:	bf a1 00 00 00       	mov    edi,0xa1
    10ff:	e8 25 ef ff ff       	call   29 <outb>
		io_wait();                                /* in cascade */
    1104:	b8 00 00 00 00       	mov    eax,0x0
    1109:	e8 0d ef ff ff       	call   1b <io_wait>
		outb(PIC1_DATA, ICW4_8086);               /* master in standard mode */
    110e:	be 01 00 00 00       	mov    esi,0x1
    1113:	bf 21 00 00 00       	mov    edi,0x21
    1118:	e8 0c ef ff ff       	call   29 <outb>
		io_wait();
    111d:	b8 00 00 00 00       	mov    eax,0x0
    1122:	e8 f4 ee ff ff       	call   1b <io_wait>
		outb(PIC2_DATA, ICW4_8086);               /* slave in standard mode */
    1127:	be 01 00 00 00       	mov    esi,0x1
    112c:	bf a1 00 00 00       	mov    edi,0xa1
    1131:	e8 f3 ee ff ff       	call   29 <outb>
		io_wait();
    1136:	b8 00 00 00 00       	mov    eax,0x0
    113b:	e8 db ee ff ff       	call   1b <io_wait>
		outb(PIC1_DATA, a1);                      /* restore saved masks */
    1140:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    1144:	89 c6                	mov    esi,eax
    1146:	bf 21 00 00 00       	mov    edi,0x21
    114b:	e8 d9 ee ff ff       	call   29 <outb>
		outb(PIC2_DATA, a2);
    1150:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2]
    1154:	89 c6                	mov    esi,eax
    1156:	bf a1 00 00 00       	mov    edi,0xa1
    115b:	e8 c9 ee ff ff       	call   29 <outb>
		cprintf(KFMT_INFO, "PICs remapped to %x and %x with masks %x and %x\n",
    1160:	0f b6 75 fe          	movzx  esi,BYTE PTR [rbp-0x2]
    1164:	0f b6 4d ff          	movzx  ecx,BYTE PTR [rbp-0x1]
    1168:	0f b6 55 e8          	movzx  edx,BYTE PTR [rbp-0x18]
    116c:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
    1170:	41 89 f1             	mov    r9d,esi
    1173:	41 89 c8             	mov    r8d,ecx
    1176:	89 d1                	mov    ecx,edx
    1178:	89 c2                	mov    edx,eax
    117a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1181:	bf 0b 00 00 00       	mov    edi,0xb
    1186:	b8 00 00 00 00       	mov    eax,0x0
    118b:	e8 00 00 00 00       	call   1190 <PIC_remap+0x146>
}
    1190:	90                   	nop
    1191:	c9                   	leave
    1192:	c3                   	ret

0000000000001193 <cmos_is_updating>:
{
    1193:	55                   	push   rbp
    1194:	48 89 e5             	mov    rbp,rsp
		outb(CMOS_CH_INDEX, 0x0a);
    1197:	be 0a 00 00 00       	mov    esi,0xa
    119c:	bf 70 00 00 00       	mov    edi,0x70
    11a1:	e8 83 ee ff ff       	call   29 <outb>
		return inb(CMOS_CH_DATA) & 0x80;
    11a6:	bf 71 00 00 00       	mov    edi,0x71
    11ab:	e8 98 ee ff ff       	call   48 <inb>
    11b0:	0f b6 c0             	movzx  eax,al
    11b3:	25 80 00 00 00       	and    eax,0x80
}
    11b8:	5d                   	pop    rbp
    11b9:	c3                   	ret

00000000000011ba <cmos_get_register>:
{
    11ba:	55                   	push   rbp
    11bb:	48 89 e5             	mov    rbp,rsp
    11be:	48 83 ec 08          	sub    rsp,0x8
    11c2:	89 f8                	mov    eax,edi
    11c4:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
		outb(CMOS_CH_INDEX, reg);
    11c7:	0f b6 45 fc          	movzx  eax,BYTE PTR [rbp-0x4]
    11cb:	89 c6                	mov    esi,eax
    11cd:	bf 70 00 00 00       	mov    edi,0x70
    11d2:	e8 52 ee ff ff       	call   29 <outb>
		return inb(CMOS_CH_DATA);
    11d7:	bf 71 00 00 00       	mov    edi,0x71
    11dc:	e8 67 ee ff ff       	call   48 <inb>
}
    11e1:	c9                   	leave
    11e2:	c3                   	ret

00000000000011e3 <cmos_get_time>:
{
    11e3:	55                   	push   rbp
    11e4:	48 89 e5             	mov    rbp,rsp
    11e7:	53                   	push   rbx
    11e8:	48 83 ec 78          	sub    rsp,0x78
    11ec:	48 89 7d 88          	mov    QWORD PTR [rbp-0x78],rdi
		struct tm rv = {0}, rvb = {0};
    11f0:	66 0f ef c0          	pxor   xmm0,xmm0
    11f4:	0f 29 45 c0          	movaps XMMWORD PTR [rbp-0x40],xmm0
    11f8:	0f 29 45 d0          	movaps XMMWORD PTR [rbp-0x30],xmm0
    11fc:	66 0f 7e 45 e0       	movd   DWORD PTR [rbp-0x20],xmm0
    1201:	66 0f ef c0          	pxor   xmm0,xmm0
    1205:	0f 29 45 90          	movaps XMMWORD PTR [rbp-0x70],xmm0
    1209:	0f 29 45 a0          	movaps XMMWORD PTR [rbp-0x60],xmm0
    120d:	66 0f 7e 45 b0       	movd   DWORD PTR [rbp-0x50],xmm0
		struct tm* pt = &rv; uint8_t regB;
    1212:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    1216:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				while (cmos_is_updating()); /* busy spin (maybe called by ihander */
    121a:	90                   	nop
    121b:	b8 00 00 00 00       	mov    eax,0x0
    1220:	e8 00 00 00 00       	call   1225 <cmos_get_time+0x42>
    1225:	85 c0                	test   eax,eax
    1227:	75 f2                	jne    121b <cmos_get_time+0x38>
				pt->tm_sec = cmos_get_register(0);
    1229:	bf 00 00 00 00       	mov    edi,0x0
    122e:	e8 00 00 00 00       	call   1233 <cmos_get_time+0x50>
    1233:	0f b6 d0             	movzx  edx,al
    1236:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    123a:	89 10                	mov    DWORD PTR [rax],edx
				pt->tm_min = cmos_get_register(2);
    123c:	bf 02 00 00 00       	mov    edi,0x2
    1241:	e8 00 00 00 00       	call   1246 <cmos_get_time+0x63>
    1246:	0f b6 d0             	movzx  edx,al
    1249:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    124d:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
				pt->tm_hour = cmos_get_register(4);
    1250:	bf 04 00 00 00       	mov    edi,0x4
    1255:	e8 00 00 00 00       	call   125a <cmos_get_time+0x77>
    125a:	0f b6 d0             	movzx  edx,al
    125d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1261:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
				pt->tm_wday = cmos_get_register(6);// - 1;
    1264:	bf 06 00 00 00       	mov    edi,0x6
    1269:	e8 00 00 00 00       	call   126e <cmos_get_time+0x8b>
    126e:	0f b6 d0             	movzx  edx,al
    1271:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1275:	89 50 18             	mov    DWORD PTR [rax+0x18],edx
				pt->tm_mday = cmos_get_register(7);
    1278:	bf 07 00 00 00       	mov    edi,0x7
    127d:	e8 00 00 00 00       	call   1282 <cmos_get_time+0x9f>
    1282:	0f b6 d0             	movzx  edx,al
    1285:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1289:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
				pt->tm_mon = cmos_get_register(8);
    128c:	bf 08 00 00 00       	mov    edi,0x8
    1291:	e8 00 00 00 00       	call   1296 <cmos_get_time+0xb3>
    1296:	0f b6 d0             	movzx  edx,al
    1299:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    129d:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
				pt->tm_year = cmos_get_register(9);
    12a0:	bf 09 00 00 00       	mov    edi,0x9
    12a5:	e8 00 00 00 00       	call   12aa <cmos_get_time+0xc7>
    12aa:	0f b6 d0             	movzx  edx,al
    12ad:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    12b1:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
				pt->tm_year |= (cmos_get_register(0x32) << 8); /* century or bogus data */
    12b4:	bf 32 00 00 00       	mov    edi,0x32
    12b9:	e8 00 00 00 00       	call   12be <cmos_get_time+0xdb>
    12be:	0f b6 c0             	movzx  eax,al
    12c1:	c1 e0 08             	shl    eax,0x8
    12c4:	89 c2                	mov    edx,eax
    12c6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    12ca:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    12cd:	09 c2                	or     edx,eax
    12cf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    12d3:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
				if (pt == &rv)
    12d6:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    12da:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    12de:	75 0d                	jne    12ed <cmos_get_time+0x10a>
						pt = &rvb;
    12e0:	48 8d 45 90          	lea    rax,[rbp-0x70]
    12e4:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    12e8:	e9 2d ff ff ff       	jmp    121a <cmos_get_time+0x37>
				else if (rv.tm_sec != rvb.tm_sec ||
    12ed:	8b 55 c0             	mov    edx,DWORD PTR [rbp-0x40]
    12f0:	8b 45 90             	mov    eax,DWORD PTR [rbp-0x70]
    12f3:	39 c2                	cmp    edx,eax
    12f5:	75 3c                	jne    1333 <cmos_get_time+0x150>
								rv.tm_min != rvb.tm_min ||
    12f7:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    12fa:	8b 45 94             	mov    eax,DWORD PTR [rbp-0x6c]
				else if (rv.tm_sec != rvb.tm_sec ||
    12fd:	39 c2                	cmp    edx,eax
    12ff:	75 32                	jne    1333 <cmos_get_time+0x150>
								rv.tm_hour != rvb.tm_hour ||
    1301:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    1304:	8b 45 98             	mov    eax,DWORD PTR [rbp-0x68]
								rv.tm_min != rvb.tm_min ||
    1307:	39 c2                	cmp    edx,eax
    1309:	75 28                	jne    1333 <cmos_get_time+0x150>
								rv.tm_wday != rvb.tm_wday ||
    130b:	8b 55 d8             	mov    edx,DWORD PTR [rbp-0x28]
    130e:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
								rv.tm_hour != rvb.tm_hour ||
    1311:	39 c2                	cmp    edx,eax
    1313:	75 1e                	jne    1333 <cmos_get_time+0x150>
								rv.tm_mday != rvb.tm_mday ||
    1315:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
    1318:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
								rv.tm_wday != rvb.tm_wday ||
    131b:	39 c2                	cmp    edx,eax
    131d:	75 14                	jne    1333 <cmos_get_time+0x150>
								rv.tm_mon != rvb.tm_mon ||
    131f:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    1322:	8b 45 a0             	mov    eax,DWORD PTR [rbp-0x60]
								rv.tm_mday != rvb.tm_mday ||
    1325:	39 c2                	cmp    edx,eax
    1327:	75 0a                	jne    1333 <cmos_get_time+0x150>
								rv.tm_year != rvb.tm_year)
    1329:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    132c:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
								rv.tm_mon != rvb.tm_mon ||
    132f:	39 c2                	cmp    edx,eax
    1331:	74 0d                	je     1340 <cmos_get_time+0x15d>
						pt = &rv;
    1333:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    1337:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				while (cmos_is_updating()); /* busy spin (maybe called by ihander */
    133b:	e9 da fe ff ff       	jmp    121a <cmos_get_time+0x37>
		regB = cmos_get_register(0x0b);
    1340:	bf 0b 00 00 00       	mov    edi,0xb
    1345:	e8 00 00 00 00       	call   134a <cmos_get_time+0x167>
    134a:	88 45 e7             	mov    BYTE PTR [rbp-0x19],al
		if (!(regB & 0x04)) {
    134d:	0f b6 45 e7          	movzx  eax,BYTE PTR [rbp-0x19]
    1351:	83 e0 04             	and    eax,0x4
    1354:	85 c0                	test   eax,eax
    1356:	0f 85 a1 01 00 00    	jne    14fd <cmos_get_time+0x31a>
				pt->tm_sec = (pt->tm_sec & 0xf) + ((pt->tm_sec / 16) * 10);
    135c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1360:	8b 00                	mov    eax,DWORD PTR [rax]
    1362:	83 e0 0f             	and    eax,0xf
    1365:	89 c1                	mov    ecx,eax
    1367:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    136b:	8b 00                	mov    eax,DWORD PTR [rax]
    136d:	8d 50 0f             	lea    edx,[rax+0xf]
    1370:	85 c0                	test   eax,eax
    1372:	0f 48 c2             	cmovs  eax,edx
    1375:	c1 f8 04             	sar    eax,0x4
    1378:	89 c2                	mov    edx,eax
    137a:	89 d0                	mov    eax,edx
    137c:	c1 e0 02             	shl    eax,0x2
    137f:	01 d0                	add    eax,edx
    1381:	01 c0                	add    eax,eax
    1383:	8d 14 01             	lea    edx,[rcx+rax*1]
    1386:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    138a:	89 10                	mov    DWORD PTR [rax],edx
				pt->tm_min = (pt->tm_min & 0xf) + ((pt->tm_min / 16) * 10);
    138c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1390:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1393:	83 e0 0f             	and    eax,0xf
    1396:	89 c1                	mov    ecx,eax
    1398:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    139c:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    139f:	8d 50 0f             	lea    edx,[rax+0xf]
    13a2:	85 c0                	test   eax,eax
    13a4:	0f 48 c2             	cmovs  eax,edx
    13a7:	c1 f8 04             	sar    eax,0x4
    13aa:	89 c2                	mov    edx,eax
    13ac:	89 d0                	mov    eax,edx
    13ae:	c1 e0 02             	shl    eax,0x2
    13b1:	01 d0                	add    eax,edx
    13b3:	01 c0                	add    eax,eax
    13b5:	8d 14 01             	lea    edx,[rcx+rax*1]
    13b8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13bc:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
				pt->tm_hour = (pt->tm_hour & 0x80) | ((pt->tm_hour & 0xf) + (((pt->tm_hour & 0x70) / 16) * 10));
    13bf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13c3:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    13c6:	25 80 00 00 00       	and    eax,0x80
    13cb:	89 c1                	mov    ecx,eax
    13cd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13d1:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    13d4:	83 e0 0f             	and    eax,0xf
    13d7:	89 c6                	mov    esi,eax
    13d9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13dd:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    13e0:	83 e0 70             	and    eax,0x70
    13e3:	8d 50 0f             	lea    edx,[rax+0xf]
    13e6:	85 c0                	test   eax,eax
    13e8:	0f 48 c2             	cmovs  eax,edx
    13eb:	c1 f8 04             	sar    eax,0x4
    13ee:	89 c2                	mov    edx,eax
    13f0:	89 d0                	mov    eax,edx
    13f2:	c1 e0 02             	shl    eax,0x2
    13f5:	01 d0                	add    eax,edx
    13f7:	01 c0                	add    eax,eax
    13f9:	01 f0                	add    eax,esi
    13fb:	09 c1                	or     ecx,eax
    13fd:	89 ca                	mov    edx,ecx
    13ff:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1403:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
				pt->tm_wday = (pt->tm_wday & 0xf) + ((pt->tm_wday / 16) * 10);
    1406:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    140a:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    140d:	83 e0 0f             	and    eax,0xf
    1410:	89 c1                	mov    ecx,eax
    1412:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1416:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1419:	8d 50 0f             	lea    edx,[rax+0xf]
    141c:	85 c0                	test   eax,eax
    141e:	0f 48 c2             	cmovs  eax,edx
    1421:	c1 f8 04             	sar    eax,0x4
    1424:	89 c2                	mov    edx,eax
    1426:	89 d0                	mov    eax,edx
    1428:	c1 e0 02             	shl    eax,0x2
    142b:	01 d0                	add    eax,edx
    142d:	01 c0                	add    eax,eax
    142f:	8d 14 01             	lea    edx,[rcx+rax*1]
    1432:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1436:	89 50 18             	mov    DWORD PTR [rax+0x18],edx
				pt->tm_mday = (pt->tm_mday & 0xf) + ((pt->tm_mday / 16) * 10);
    1439:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    143d:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    1440:	83 e0 0f             	and    eax,0xf
    1443:	89 c1                	mov    ecx,eax
    1445:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1449:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    144c:	8d 50 0f             	lea    edx,[rax+0xf]
    144f:	85 c0                	test   eax,eax
    1451:	0f 48 c2             	cmovs  eax,edx
    1454:	c1 f8 04             	sar    eax,0x4
    1457:	89 c2                	mov    edx,eax
    1459:	89 d0                	mov    eax,edx
    145b:	c1 e0 02             	shl    eax,0x2
    145e:	01 d0                	add    eax,edx
    1460:	01 c0                	add    eax,eax
    1462:	8d 14 01             	lea    edx,[rcx+rax*1]
    1465:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1469:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
				pt->tm_mon = (pt->tm_mon & 0xf) + ((pt->tm_mon / 16) * 10);
    146c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1470:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1473:	83 e0 0f             	and    eax,0xf
    1476:	89 c1                	mov    ecx,eax
    1478:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    147c:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    147f:	8d 50 0f             	lea    edx,[rax+0xf]
    1482:	85 c0                	test   eax,eax
    1484:	0f 48 c2             	cmovs  eax,edx
    1487:	c1 f8 04             	sar    eax,0x4
    148a:	89 c2                	mov    edx,eax
    148c:	89 d0                	mov    eax,edx
    148e:	c1 e0 02             	shl    eax,0x2
    1491:	01 d0                	add    eax,edx
    1493:	01 c0                	add    eax,eax
    1495:	8d 14 01             	lea    edx,[rcx+rax*1]
    1498:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    149c:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
				pt->tm_year = ((pt->tm_year & 0xf) + ((pt->tm_year / 16) * 10))
    149f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    14a3:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    14a6:	83 e0 0f             	and    eax,0xf
    14a9:	89 c1                	mov    ecx,eax
    14ab:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    14af:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    14b2:	8d 50 0f             	lea    edx,[rax+0xf]
    14b5:	85 c0                	test   eax,eax
    14b7:	0f 48 c2             	cmovs  eax,edx
    14ba:	c1 f8 04             	sar    eax,0x4
    14bd:	89 c2                	mov    edx,eax
    14bf:	89 d0                	mov    eax,edx
    14c1:	c1 e0 02             	shl    eax,0x2
    14c4:	01 d0                	add    eax,edx
    14c6:	01 c0                	add    eax,eax
    14c8:	01 c1                	add    ecx,eax
						| ((((pt->tm_year & 0xf) >> 8) + ((((pt->tm_year & 0xf000) >> 8) / 16) * 10)) << 8);
    14ca:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    14ce:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    14d1:	c1 f8 08             	sar    eax,0x8
    14d4:	25 f0 00 00 00       	and    eax,0xf0
    14d9:	8d 50 0f             	lea    edx,[rax+0xf]
    14dc:	85 c0                	test   eax,eax
    14de:	0f 48 c2             	cmovs  eax,edx
    14e1:	c1 f8 04             	sar    eax,0x4
    14e4:	89 c2                	mov    edx,eax
    14e6:	89 d0                	mov    eax,edx
    14e8:	c1 e0 02             	shl    eax,0x2
    14eb:	01 d0                	add    eax,edx
    14ed:	01 c0                	add    eax,eax
    14ef:	c1 e0 08             	shl    eax,0x8
    14f2:	09 c1                	or     ecx,eax
    14f4:	89 ca                	mov    edx,ecx
				pt->tm_year = ((pt->tm_year & 0xf) + ((pt->tm_year / 16) * 10))
    14f6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    14fa:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
		if (!(regB & 0x02) && (pt->tm_hour & 0x80))
    14fd:	0f b6 45 e7          	movzx  eax,BYTE PTR [rbp-0x19]
    1501:	83 e0 02             	and    eax,0x2
    1504:	85 c0                	test   eax,eax
    1506:	75 4b                	jne    1553 <cmos_get_time+0x370>
    1508:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    150c:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    150f:	25 80 00 00 00       	and    eax,0x80
    1514:	85 c0                	test   eax,eax
    1516:	74 3b                	je     1553 <cmos_get_time+0x370>
				pt->tm_hour = (((pt->tm_hour & 0x7f) + 12) % 24);
    1518:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    151c:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    151f:	83 e0 7f             	and    eax,0x7f
    1522:	8d 48 0c             	lea    ecx,[rax+0xc]
    1525:	48 63 c1             	movsxd rax,ecx
    1528:	48 69 c0 ab aa aa 2a 	imul   rax,rax,0x2aaaaaab
    152f:	48 c1 e8 20          	shr    rax,0x20
    1533:	89 c2                	mov    edx,eax
    1535:	c1 fa 02             	sar    edx,0x2
    1538:	89 c8                	mov    eax,ecx
    153a:	c1 f8 1f             	sar    eax,0x1f
    153d:	29 c2                	sub    edx,eax
    153f:	89 d0                	mov    eax,edx
    1541:	01 c0                	add    eax,eax
    1543:	01 d0                	add    eax,edx
    1545:	c1 e0 03             	shl    eax,0x3
    1548:	29 c1                	sub    ecx,eax
    154a:	89 ca                	mov    edx,ecx
    154c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1550:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
		pt->tm_year = 100 * ((pt->tm_year & 0xff00) >> 8) + (pt->tm_year & 0xff);
    1553:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1557:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    155a:	c1 f8 08             	sar    eax,0x8
    155d:	0f b6 c0             	movzx  eax,al
    1560:	6b d0 64             	imul   edx,eax,0x64
    1563:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1567:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    156a:	0f b6 c0             	movzx  eax,al
    156d:	01 c2                	add    edx,eax
    156f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1573:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
		pt->tm_year -= 1900;
    1576:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    157a:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    157d:	8d 90 94 f8 ff ff    	lea    edx,[rax-0x76c]
    1583:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1587:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
		pt->tm_yday = pt->tm_mday - 1;
    158a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    158e:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    1591:	8d 50 ff             	lea    edx,[rax-0x1]
    1594:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1598:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
		pt->tm_mon -= 1;
    159b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    159f:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    15a2:	8d 50 ff             	lea    edx,[rax-0x1]
    15a5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    15a9:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		if (IS_LEAP_YEAR(pt->tm_year + 1900))
    15ac:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    15b0:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    15b3:	3d 95 f8 ff ff       	cmp    eax,0xfffff895
    15b8:	0f 8c 9c 00 00 00    	jl     165a <cmos_get_time+0x477>
    15be:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    15c2:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    15c5:	05 6c 07 00 00       	add    eax,0x76c
    15ca:	83 e0 03             	and    eax,0x3
    15cd:	85 c0                	test   eax,eax
    15cf:	0f 85 85 00 00 00    	jne    165a <cmos_get_time+0x477>
    15d5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    15d9:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    15dc:	8d 90 6c 07 00 00    	lea    edx,[rax+0x76c]
    15e2:	48 63 c2             	movsxd rax,edx
    15e5:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    15ec:	48 c1 e8 20          	shr    rax,0x20
    15f0:	c1 f8 05             	sar    eax,0x5
    15f3:	89 d1                	mov    ecx,edx
    15f5:	c1 f9 1f             	sar    ecx,0x1f
    15f8:	29 c8                	sub    eax,ecx
    15fa:	6b c8 64             	imul   ecx,eax,0x64
    15fd:	89 d0                	mov    eax,edx
    15ff:	29 c8                	sub    eax,ecx
    1601:	85 c0                	test   eax,eax
    1603:	75 33                	jne    1638 <cmos_get_time+0x455>
    1605:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1609:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    160c:	8d 90 6c 07 00 00    	lea    edx,[rax+0x76c]
    1612:	48 63 c2             	movsxd rax,edx
    1615:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    161c:	48 c1 e8 20          	shr    rax,0x20
    1620:	c1 f8 07             	sar    eax,0x7
    1623:	89 d1                	mov    ecx,edx
    1625:	c1 f9 1f             	sar    ecx,0x1f
    1628:	29 c8                	sub    eax,ecx
    162a:	69 c8 90 01 00 00    	imul   ecx,eax,0x190
    1630:	89 d0                	mov    eax,edx
    1632:	29 c8                	sub    eax,ecx
    1634:	85 c0                	test   eax,eax
    1636:	75 22                	jne    165a <cmos_get_time+0x477>
				pt->tm_yday += dayct_lp[pt->tm_mon];
    1638:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    163c:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    163f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1643:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1646:	48 98                	cdqe
    1648:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
    164f:	01 c2                	add    edx,eax
    1651:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1655:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
    1658:	eb 20                	jmp    167a <cmos_get_time+0x497>
				pt->tm_yday += dayct_nl[pt->tm_mon];
    165a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    165e:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    1661:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1665:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1668:	48 98                	cdqe
    166a:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
    1671:	01 c2                	add    edx,eax
    1673:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1677:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
		return *pt;
    167a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    167e:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1682:	48 8b 0a             	mov    rcx,QWORD PTR [rdx]
    1685:	48 8b 5a 08          	mov    rbx,QWORD PTR [rdx+0x8]
    1689:	48 89 08             	mov    QWORD PTR [rax],rcx
    168c:	48 89 58 08          	mov    QWORD PTR [rax+0x8],rbx
    1690:	48 8b 4a 10          	mov    rcx,QWORD PTR [rdx+0x10]
    1694:	48 8b 5a 18          	mov    rbx,QWORD PTR [rdx+0x18]
    1698:	48 89 48 10          	mov    QWORD PTR [rax+0x10],rcx
    169c:	48 89 58 18          	mov    QWORD PTR [rax+0x18],rbx
    16a0:	8b 52 20             	mov    edx,DWORD PTR [rdx+0x20]
    16a3:	89 50 20             	mov    DWORD PTR [rax+0x20],edx
}
    16a6:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    16aa:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    16ae:	c9                   	leave
    16af:	c3                   	ret

00000000000016b0 <kernel_fb_resize>:
{
    16b0:	55                   	push   rbp
    16b1:	48 89 e5             	mov    rbp,rsp
		km_regS.x = fb_initial.width - 20;
    16b4:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 16ba <kernel_fb_resize+0xa>
    16ba:	83 e8 14             	sub    eax,0x14
    16bd:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 16c4 <kernel_fb_resize+0x14>
		km_regC.x = fb_initial.width - 20;
    16c4:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 16ca <kernel_fb_resize+0x1a>
    16ca:	83 e8 14             	sub    eax,0x14
    16cd:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 16d4 <kernel_fb_resize+0x24>
		km_regC.y = fb_initial.height - 2;
    16d4:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 16da <kernel_fb_resize+0x2a>
    16da:	83 e8 02             	sub    eax,0x2
    16dd:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 16e4 <kernel_fb_resize+0x34>
}
    16e4:	90                   	nop
    16e5:	5d                   	pop    rbp
    16e6:	c3                   	ret

00000000000016e7 <second_tick>:
{
    16e7:	55                   	push   rbp
    16e8:	48 89 e5             	mov    rbp,rsp
    16eb:	48 81 ec 90 00 00 00 	sub    rsp,0x90
		if(((jiffies - km_set) > CMOS_THRESHOLD)) {
    16f2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 16f9 <second_tick+0x12>
    16f9:	48 8b 00             	mov    rax,QWORD PTR [rax]
    16fc:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1703 <second_tick+0x1c>
    1703:	48 29 d0             	sub    rax,rdx
    1706:	48 85 c0             	test   rax,rax
    1709:	78 0b                	js     1716 <second_tick+0x2f>
    170b:	66 0f ef c0          	pxor   xmm0,xmm0
    170f:	f2 48 0f 2a c0       	cvtsi2sd xmm0,rax
    1714:	eb 19                	jmp    172f <second_tick+0x48>
    1716:	48 89 c2             	mov    rdx,rax
    1719:	48 d1 ea             	shr    rdx,1
    171c:	83 e0 01             	and    eax,0x1
    171f:	48 09 c2             	or     rdx,rax
    1722:	66 0f ef c0          	pxor   xmm0,xmm0
    1726:	f2 48 0f 2a c2       	cvtsi2sd xmm0,rdx
    172b:	f2 0f 58 c0          	addsd  xmm0,xmm0
    172f:	66 0f 2f 05 00 00 00 00 	comisd xmm0,QWORD PTR [rip+0x0]        # 1737 <second_tick+0x50>
    1737:	76 60                	jbe    1799 <second_tick+0xb2>
				km_time = cmos_get_time();
    1739:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    1740:	48 89 c7             	mov    rdi,rax
    1743:	b8 00 00 00 00       	mov    eax,0x0
    1748:	e8 00 00 00 00       	call   174d <second_tick+0x66>
    174d:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1754:	48 8b 95 78 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x88]
    175b:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1762 <second_tick+0x7b>
    1762:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 1769 <second_tick+0x82>
    1769:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    176d:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    1771:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1778 <second_tick+0x91>
    1778:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 177f <second_tick+0x98>
    177f:	8b 45 90             	mov    eax,DWORD PTR [rbp-0x70]
    1782:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 1788 <second_tick+0xa1>
				km_set = jiffies;
    1788:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 178f <second_tick+0xa8>
    178f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1792:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1799 <second_tick+0xb2>
		task_do_stats();
    1799:	b8 00 00 00 00       	mov    eax,0x0
    179e:	e8 00 00 00 00       	call   17a3 <second_tick+0xbc>
				double scs = (double)jiffies / HZ;
    17a3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17aa <second_tick+0xc3>
    17aa:	48 8b 00             	mov    rax,QWORD PTR [rax]
    17ad:	48 85 c0             	test   rax,rax
    17b0:	78 0b                	js     17bd <second_tick+0xd6>
    17b2:	66 0f ef c0          	pxor   xmm0,xmm0
    17b6:	f2 48 0f 2a c0       	cvtsi2sd xmm0,rax
    17bb:	eb 19                	jmp    17d6 <second_tick+0xef>
    17bd:	48 89 c2             	mov    rdx,rax
    17c0:	48 d1 ea             	shr    rdx,1
    17c3:	83 e0 01             	and    eax,0x1
    17c6:	48 09 c2             	or     rdx,rax
    17c9:	66 0f ef c0          	pxor   xmm0,xmm0
    17cd:	f2 48 0f 2a c2       	cvtsi2sd xmm0,rdx
    17d2:	f2 0f 58 c0          	addsd  xmm0,xmm0
    17d6:	f2 0f 10 0d 00 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # 17de <second_tick+0xf7>
    17de:	f2 0f 5e c1          	divsd  xmm0,xmm1
    17e2:	f2 0f 11 45 f0       	movsd  QWORD PTR [rbp-0x10],xmm0
				uint32_t secs = 0, mins = 0, hrs = 0, days = 0;
    17e7:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
    17ee:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
    17f5:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [rbp-0x1c],0x0
    17fc:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [rbp-0x20],0x0
				km_regS.cur_x = 4;
    1803:	66 c7 05 00 00 00 00 04 00 	mov    WORD PTR [rip+0x0],0x4        # 180c <second_tick+0x125>
				km_regS.cur_y = 2;
    180c:	66 c7 05 00 00 00 00 02 00 	mov    WORD PTR [rip+0x0],0x2        # 1815 <second_tick+0x12e>
				days = (uint32_t)(scs / 86400.0f);
    1815:	f2 0f 10 45 f0       	movsd  xmm0,QWORD PTR [rbp-0x10]
    181a:	f2 0f 10 0d 00 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # 1822 <second_tick+0x13b>
    1822:	f2 0f 5e c1          	divsd  xmm0,xmm1
    1826:	f2 48 0f 2c c0       	cvttsd2si rax,xmm0
    182b:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				scs -= 86400.0f * days;
    182e:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    1831:	48 85 c0             	test   rax,rax
    1834:	78 0b                	js     1841 <second_tick+0x15a>
    1836:	66 0f ef c0          	pxor   xmm0,xmm0
    183a:	f3 48 0f 2a c0       	cvtsi2ss xmm0,rax
    183f:	eb 19                	jmp    185a <second_tick+0x173>
    1841:	48 89 c2             	mov    rdx,rax
    1844:	48 d1 ea             	shr    rdx,1
    1847:	83 e0 01             	and    eax,0x1
    184a:	48 09 c2             	or     rdx,rax
    184d:	66 0f ef c0          	pxor   xmm0,xmm0
    1851:	f3 48 0f 2a c2       	cvtsi2ss xmm0,rdx
    1856:	f3 0f 58 c0          	addss  xmm0,xmm0
    185a:	f3 0f 10 0d 00 00 00 00 	movss  xmm1,DWORD PTR [rip+0x0]        # 1862 <second_tick+0x17b>
    1862:	f3 0f 59 c1          	mulss  xmm0,xmm1
    1866:	66 0f ef c9          	pxor   xmm1,xmm1
    186a:	f3 0f 5a c8          	cvtss2sd xmm1,xmm0
    186e:	f2 0f 10 45 f0       	movsd  xmm0,QWORD PTR [rbp-0x10]
    1873:	f2 0f 5c c1          	subsd  xmm0,xmm1
    1877:	f2 0f 11 45 f0       	movsd  QWORD PTR [rbp-0x10],xmm0
				hrs = (uint32_t)(scs / 3600.0f);
    187c:	f2 0f 10 45 f0       	movsd  xmm0,QWORD PTR [rbp-0x10]
    1881:	f2 0f 10 0d 00 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # 1889 <second_tick+0x1a2>
    1889:	f2 0f 5e c1          	divsd  xmm0,xmm1
    188d:	f2 48 0f 2c c0       	cvttsd2si rax,xmm0
    1892:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
				scs -= 3600.0f * hrs;
    1895:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1898:	48 85 c0             	test   rax,rax
    189b:	78 0b                	js     18a8 <second_tick+0x1c1>
    189d:	66 0f ef c0          	pxor   xmm0,xmm0
    18a1:	f3 48 0f 2a c0       	cvtsi2ss xmm0,rax
    18a6:	eb 19                	jmp    18c1 <second_tick+0x1da>
    18a8:	48 89 c2             	mov    rdx,rax
    18ab:	48 d1 ea             	shr    rdx,1
    18ae:	83 e0 01             	and    eax,0x1
    18b1:	48 09 c2             	or     rdx,rax
    18b4:	66 0f ef c0          	pxor   xmm0,xmm0
    18b8:	f3 48 0f 2a c2       	cvtsi2ss xmm0,rdx
    18bd:	f3 0f 58 c0          	addss  xmm0,xmm0
    18c1:	f3 0f 10 0d 00 00 00 00 	movss  xmm1,DWORD PTR [rip+0x0]        # 18c9 <second_tick+0x1e2>
    18c9:	f3 0f 59 c1          	mulss  xmm0,xmm1
    18cd:	66 0f ef c9          	pxor   xmm1,xmm1
    18d1:	f3 0f 5a c8          	cvtss2sd xmm1,xmm0
    18d5:	f2 0f 10 45 f0       	movsd  xmm0,QWORD PTR [rbp-0x10]
    18da:	f2 0f 5c c1          	subsd  xmm0,xmm1
    18de:	f2 0f 11 45 f0       	movsd  QWORD PTR [rbp-0x10],xmm0
				mins = (uint32_t)(scs / 60.0f);
    18e3:	f2 0f 10 45 f0       	movsd  xmm0,QWORD PTR [rbp-0x10]
    18e8:	f2 0f 10 0d 00 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # 18f0 <second_tick+0x209>
    18f0:	f2 0f 5e c1          	divsd  xmm0,xmm1
    18f4:	f2 48 0f 2c c0       	cvttsd2si rax,xmm0
    18f9:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
				scs -= 60.0f * mins;
    18fc:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    18ff:	48 85 c0             	test   rax,rax
    1902:	78 0b                	js     190f <second_tick+0x228>
    1904:	66 0f ef c0          	pxor   xmm0,xmm0
    1908:	f3 48 0f 2a c0       	cvtsi2ss xmm0,rax
    190d:	eb 19                	jmp    1928 <second_tick+0x241>
    190f:	48 89 c2             	mov    rdx,rax
    1912:	48 d1 ea             	shr    rdx,1
    1915:	83 e0 01             	and    eax,0x1
    1918:	48 09 c2             	or     rdx,rax
    191b:	66 0f ef c0          	pxor   xmm0,xmm0
    191f:	f3 48 0f 2a c2       	cvtsi2ss xmm0,rdx
    1924:	f3 0f 58 c0          	addss  xmm0,xmm0
    1928:	f3 0f 10 0d 00 00 00 00 	movss  xmm1,DWORD PTR [rip+0x0]        # 1930 <second_tick+0x249>
    1930:	f3 0f 59 c1          	mulss  xmm0,xmm1
    1934:	66 0f ef c9          	pxor   xmm1,xmm1
    1938:	f3 0f 5a c8          	cvtss2sd xmm1,xmm0
    193c:	f2 0f 10 45 f0       	movsd  xmm0,QWORD PTR [rbp-0x10]
    1941:	f2 0f 5c c1          	subsd  xmm0,xmm1
    1945:	f2 0f 11 45 f0       	movsd  QWORD PTR [rbp-0x10],xmm0
				secs = (uint32_t)(scs);
    194a:	f2 0f 10 45 f0       	movsd  xmm0,QWORD PTR [rbp-0x10]
    194f:	f2 48 0f 2c c0       	cvttsd2si rax,xmm0
    1954:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
				if (secs != old_sc) {
    1957:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 195d <second_tick+0x276>
    195d:	39 45 ec             	cmp    DWORD PTR [rbp-0x14],eax
    1960:	74 43                	je     19a5 <second_tick+0x2be>
						crprintf(0x2f, &km_regS, "%ud %uh %um %us\n", days, hrs, mins, secs);
    1962:	8b 75 e8             	mov    esi,DWORD PTR [rbp-0x18]
    1965:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
    1968:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    196b:	48 83 ec 08          	sub    rsp,0x8
    196f:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
    1972:	52                   	push   rdx
    1973:	41 89 f1             	mov    r9d,esi
    1976:	41 89 c8             	mov    r8d,ecx
    1979:	89 c1                	mov    ecx,eax
    197b:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    1982:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1989:	bf 2f 00 00 00       	mov    edi,0x2f
    198e:	b8 00 00 00 00       	mov    eax,0x0
    1993:	e8 00 00 00 00       	call   1998 <second_tick+0x2b1>
    1998:	48 83 c4 10          	add    rsp,0x10
						old_sc = secs;
    199c:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    199f:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 19a5 <second_tick+0x2be>
				km_regS.cur_x = 0;
    19a5:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 19ae <second_tick+0x2c7>
				km_regS.cur_y = 3;
    19ae:	66 c7 05 00 00 00 00 03 00 	mov    WORD PTR [rip+0x0],0x3        # 19b7 <second_tick+0x2d0>
				if (km_time.tm_year) {
    19b7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 19bd <second_tick+0x2d6>
    19bd:	85 c0                	test   eax,eax
    19bf:	0f 84 5d 02 00 00    	je     1c22 <second_tick+0x53b>
						uint32_t adsec = ((double)(jiffies - km_set) / HZ);
    19c5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 19cc <second_tick+0x2e5>
    19cc:	48 8b 00             	mov    rax,QWORD PTR [rax]
    19cf:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 19d6 <second_tick+0x2ef>
    19d6:	48 29 d0             	sub    rax,rdx
    19d9:	48 85 c0             	test   rax,rax
    19dc:	78 0b                	js     19e9 <second_tick+0x302>
    19de:	66 0f ef c0          	pxor   xmm0,xmm0
    19e2:	f2 48 0f 2a c0       	cvtsi2sd xmm0,rax
    19e7:	eb 19                	jmp    1a02 <second_tick+0x31b>
    19e9:	48 89 c2             	mov    rdx,rax
    19ec:	48 d1 ea             	shr    rdx,1
    19ef:	83 e0 01             	and    eax,0x1
    19f2:	48 09 c2             	or     rdx,rax
    19f5:	66 0f ef c0          	pxor   xmm0,xmm0
    19f9:	f2 48 0f 2a c2       	cvtsi2sd xmm0,rdx
    19fe:	f2 0f 58 c0          	addsd  xmm0,xmm0
    1a02:	f2 0f 10 0d 00 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # 1a0a <second_tick+0x323>
    1a0a:	f2 0f 5e c1          	divsd  xmm0,xmm1
    1a0e:	f2 48 0f 2c c0       	cvttsd2si rax,xmm0
    1a13:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
						struct tm ta = km_time;
    1a16:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1a1d <second_tick+0x336>
    1a1d:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1a24 <second_tick+0x33d>
    1a24:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
    1a28:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
    1a2c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1a33 <second_tick+0x34c>
    1a33:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1a3a <second_tick+0x353>
    1a3a:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
    1a3e:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
    1a42:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1a48 <second_tick+0x361>
    1a48:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
						ta.tm_sec += adsec;
    1a4b:	8b 45 a0             	mov    eax,DWORD PTR [rbp-0x60]
    1a4e:	89 c2                	mov    edx,eax
    1a50:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1a53:	01 d0                	add    eax,edx
    1a55:	89 45 a0             	mov    DWORD PTR [rbp-0x60],eax
						if (ta.tm_sec > 59) {
    1a58:	8b 45 a0             	mov    eax,DWORD PTR [rbp-0x60]
    1a5b:	83 f8 3b             	cmp    eax,0x3b
    1a5e:	7e 4b                	jle    1aab <second_tick+0x3c4>
								ta.tm_min += ta.tm_sec / 60;
    1a60:	8b 55 a4             	mov    edx,DWORD PTR [rbp-0x5c]
    1a63:	8b 45 a0             	mov    eax,DWORD PTR [rbp-0x60]
    1a66:	48 63 c8             	movsxd rcx,eax
    1a69:	48 69 c9 89 88 88 88 	imul   rcx,rcx,0xffffffff88888889
    1a70:	48 c1 e9 20          	shr    rcx,0x20
    1a74:	01 c1                	add    ecx,eax
    1a76:	c1 f9 05             	sar    ecx,0x5
    1a79:	c1 f8 1f             	sar    eax,0x1f
    1a7c:	29 c1                	sub    ecx,eax
    1a7e:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    1a81:	89 45 a4             	mov    DWORD PTR [rbp-0x5c],eax
								ta.tm_sec %= 60;
    1a84:	8b 45 a0             	mov    eax,DWORD PTR [rbp-0x60]
    1a87:	48 63 d0             	movsxd rdx,eax
    1a8a:	48 69 d2 89 88 88 88 	imul   rdx,rdx,0xffffffff88888889
    1a91:	48 c1 ea 20          	shr    rdx,0x20
    1a95:	01 c2                	add    edx,eax
    1a97:	c1 fa 05             	sar    edx,0x5
    1a9a:	89 c1                	mov    ecx,eax
    1a9c:	c1 f9 1f             	sar    ecx,0x1f
    1a9f:	29 ca                	sub    edx,ecx
    1aa1:	6b ca 3c             	imul   ecx,edx,0x3c
    1aa4:	29 c8                	sub    eax,ecx
    1aa6:	89 c2                	mov    edx,eax
    1aa8:	89 55 a0             	mov    DWORD PTR [rbp-0x60],edx
						if (ta.tm_min > 59) {
    1aab:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1aae:	83 f8 3b             	cmp    eax,0x3b
    1ab1:	7e 4b                	jle    1afe <second_tick+0x417>
								ta.tm_hour += ta.tm_min / 60;
    1ab3:	8b 55 a8             	mov    edx,DWORD PTR [rbp-0x58]
    1ab6:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1ab9:	48 63 c8             	movsxd rcx,eax
    1abc:	48 69 c9 89 88 88 88 	imul   rcx,rcx,0xffffffff88888889
    1ac3:	48 c1 e9 20          	shr    rcx,0x20
    1ac7:	01 c1                	add    ecx,eax
    1ac9:	c1 f9 05             	sar    ecx,0x5
    1acc:	c1 f8 1f             	sar    eax,0x1f
    1acf:	29 c1                	sub    ecx,eax
    1ad1:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    1ad4:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
								ta.tm_min %= 60;
    1ad7:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1ada:	48 63 d0             	movsxd rdx,eax
    1add:	48 69 d2 89 88 88 88 	imul   rdx,rdx,0xffffffff88888889
    1ae4:	48 c1 ea 20          	shr    rdx,0x20
    1ae8:	01 c2                	add    edx,eax
    1aea:	c1 fa 05             	sar    edx,0x5
    1aed:	89 c1                	mov    ecx,eax
    1aef:	c1 f9 1f             	sar    ecx,0x1f
    1af2:	29 ca                	sub    edx,ecx
    1af4:	6b ca 3c             	imul   ecx,edx,0x3c
    1af7:	29 c8                	sub    eax,ecx
    1af9:	89 c2                	mov    edx,eax
    1afb:	89 55 a4             	mov    DWORD PTR [rbp-0x5c],edx
						if (ta.tm_hour > 23) {
    1afe:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1b01:	83 f8 17             	cmp    eax,0x17
    1b04:	0f 8e 93 00 00 00    	jle    1b9d <second_tick+0x4b6>
								ta.tm_mday += ta.tm_hour / 24;
    1b0a:	8b 55 ac             	mov    edx,DWORD PTR [rbp-0x54]
    1b0d:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1b10:	48 63 c8             	movsxd rcx,eax
    1b13:	48 69 c9 ab aa aa 2a 	imul   rcx,rcx,0x2aaaaaab
    1b1a:	48 c1 e9 20          	shr    rcx,0x20
    1b1e:	c1 f9 02             	sar    ecx,0x2
    1b21:	c1 f8 1f             	sar    eax,0x1f
    1b24:	29 c1                	sub    ecx,eax
    1b26:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    1b29:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
								ta.tm_wday += ta.tm_hour / 24;
    1b2c:	8b 55 b8             	mov    edx,DWORD PTR [rbp-0x48]
    1b2f:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1b32:	48 63 c8             	movsxd rcx,eax
    1b35:	48 69 c9 ab aa aa 2a 	imul   rcx,rcx,0x2aaaaaab
    1b3c:	48 c1 e9 20          	shr    rcx,0x20
    1b40:	c1 f9 02             	sar    ecx,0x2
    1b43:	c1 f8 1f             	sar    eax,0x1f
    1b46:	29 c1                	sub    ecx,eax
    1b48:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    1b4b:	89 45 b8             	mov    DWORD PTR [rbp-0x48],eax
								ta.tm_yday += ta.tm_hour / 24;
    1b4e:	8b 55 bc             	mov    edx,DWORD PTR [rbp-0x44]
    1b51:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1b54:	48 63 c8             	movsxd rcx,eax
    1b57:	48 69 c9 ab aa aa 2a 	imul   rcx,rcx,0x2aaaaaab
    1b5e:	48 c1 e9 20          	shr    rcx,0x20
    1b62:	c1 f9 02             	sar    ecx,0x2
    1b65:	c1 f8 1f             	sar    eax,0x1f
    1b68:	29 c1                	sub    ecx,eax
    1b6a:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    1b6d:	89 45 bc             	mov    DWORD PTR [rbp-0x44],eax
								ta.tm_hour %= 24;
    1b70:	8b 4d a8             	mov    ecx,DWORD PTR [rbp-0x58]
    1b73:	48 63 c1             	movsxd rax,ecx
    1b76:	48 69 c0 ab aa aa 2a 	imul   rax,rax,0x2aaaaaab
    1b7d:	48 c1 e8 20          	shr    rax,0x20
    1b81:	89 c2                	mov    edx,eax
    1b83:	c1 fa 02             	sar    edx,0x2
    1b86:	89 c8                	mov    eax,ecx
    1b88:	c1 f8 1f             	sar    eax,0x1f
    1b8b:	29 c2                	sub    edx,eax
    1b8d:	89 d0                	mov    eax,edx
    1b8f:	01 c0                	add    eax,eax
    1b91:	01 d0                	add    eax,edx
    1b93:	c1 e0 03             	shl    eax,0x3
    1b96:	29 c1                	sub    ecx,eax
    1b98:	89 ca                	mov    edx,ecx
    1b9a:	89 55 a8             	mov    DWORD PTR [rbp-0x58],edx
						if (ta.tm_wday > 6) {
    1b9d:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    1ba0:	83 f8 06             	cmp    eax,0x6
    1ba3:	7e 2b                	jle    1bd0 <second_tick+0x4e9>
								ta.tm_wday %= 7;
    1ba5:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    1ba8:	48 63 d0             	movsxd rdx,eax
    1bab:	48 69 d2 93 24 49 92 	imul   rdx,rdx,0xffffffff92492493
    1bb2:	48 c1 ea 20          	shr    rdx,0x20
    1bb6:	01 c2                	add    edx,eax
    1bb8:	c1 fa 02             	sar    edx,0x2
    1bbb:	89 c1                	mov    ecx,eax
    1bbd:	c1 f9 1f             	sar    ecx,0x1f
    1bc0:	29 ca                	sub    edx,ecx
    1bc2:	89 d1                	mov    ecx,edx
    1bc4:	c1 e1 03             	shl    ecx,0x3
    1bc7:	29 d1                	sub    ecx,edx
    1bc9:	29 c8                	sub    eax,ecx
    1bcb:	89 c2                	mov    edx,eax
    1bcd:	89 55 b8             	mov    DWORD PTR [rbp-0x48],edx
						if (adsec)
    1bd0:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    1bd4:	74 4c                	je     1c22 <second_tick+0x53b>
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1bd6:	8b 7d a0             	mov    edi,DWORD PTR [rbp-0x60]
    1bd9:	8b 75 a4             	mov    esi,DWORD PTR [rbp-0x5c]
    1bdc:	8b 4d a8             	mov    ecx,DWORD PTR [rbp-0x58]
    1bdf:	8b 55 b8             	mov    edx,DWORD PTR [rbp-0x48]
    1be2:	44 8b 45 ac          	mov    r8d,DWORD PTR [rbp-0x54]
										ta.tm_mon + 1, ta.tm_mday,
    1be6:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1be9:	44 8d 50 01          	lea    r10d,[rax+0x1]
										1900 + ta.tm_year,
    1bed:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1bf0:	05 6c 07 00 00       	add    eax,0x76c
    1bf5:	57                   	push   rdi
    1bf6:	56                   	push   rsi
    1bf7:	51                   	push   rcx
    1bf8:	52                   	push   rdx
    1bf9:	45 89 c1             	mov    r9d,r8d
    1bfc:	45 89 d0             	mov    r8d,r10d
    1bff:	89 c1                	mov    ecx,eax
    1c01:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    1c08:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1c0f:	bf 2f 00 00 00       	mov    edi,0x2f
    1c14:	b8 00 00 00 00       	mov    eax,0x0
    1c19:	e8 00 00 00 00       	call   1c1e <second_tick+0x537>
    1c1e:	48 83 c4 20          	add    rsp,0x20
				const uint16_t gran = 10;
    1c22:	66 c7 45 da 0a 00    	mov    WORD PTR [rbp-0x26],0xa
				l_k = 1 + (gran * cpu_pcs[0].vals[1]) / 100;
    1c28:	0f b7 55 da          	movzx  edx,WORD PTR [rbp-0x26]
    1c2c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1c33 <second_tick+0x54c>
    1c33:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1c36:	0f af c2             	imul   eax,edx
    1c39:	89 c0                	mov    eax,eax
    1c3b:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    1c42:	48 c1 e8 20          	shr    rax,0x20
    1c46:	c1 e8 05             	shr    eax,0x5
    1c49:	83 c0 01             	add    eax,0x1
    1c4c:	66 89 45 d8          	mov    WORD PTR [rbp-0x28],ax
				l_n = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3])) / 100;
    1c50:	0f b7 45 da          	movzx  eax,WORD PTR [rbp-0x26]
    1c54:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1c5b <second_tick+0x574>
    1c5b:	8b 4a 04             	mov    ecx,DWORD PTR [rdx+0x4]
    1c5e:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1c65 <second_tick+0x57e>
    1c65:	8b 52 0c             	mov    edx,DWORD PTR [rdx+0xc]
    1c68:	01 ca                	add    edx,ecx
    1c6a:	0f af c2             	imul   eax,edx
    1c6d:	89 c0                	mov    eax,eax
    1c6f:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    1c76:	48 c1 e8 20          	shr    rax,0x20
    1c7a:	c1 e8 05             	shr    eax,0x5
    1c7d:	83 c0 01             	add    eax,0x1
    1c80:	66 89 45 d6          	mov    WORD PTR [rbp-0x2a],ax
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1c84:	0f b7 45 da          	movzx  eax,WORD PTR [rbp-0x26]
    1c88:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1c8f <second_tick+0x5a8>
    1c8f:	8b 4a 04             	mov    ecx,DWORD PTR [rdx+0x4]
    1c92:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1c99 <second_tick+0x5b2>
    1c99:	8b 52 0c             	mov    edx,DWORD PTR [rdx+0xc]
    1c9c:	01 d1                	add    ecx,edx
										+ cpu_pcs[0].vals[2])) / 100;
    1c9e:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1ca5 <second_tick+0x5be>
    1ca5:	8b 52 08             	mov    edx,DWORD PTR [rdx+0x8]
    1ca8:	01 ca                	add    edx,ecx
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1caa:	0f af c2             	imul   eax,edx
										+ cpu_pcs[0].vals[2])) / 100;
    1cad:	89 c0                	mov    eax,eax
    1caf:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    1cb6:	48 c1 e8 20          	shr    rax,0x20
    1cba:	c1 e8 05             	shr    eax,0x5
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1cbd:	83 c0 01             	add    eax,0x1
    1cc0:	66 89 45 d4          	mov    WORD PTR [rbp-0x2c],ax
				putc_prc(&km_regC, KFMT_NORMAL, '[', 0, 0);
    1cc4:	41 b8 00 00 00 00    	mov    r8d,0x0
    1cca:	b9 00 00 00 00       	mov    ecx,0x0
    1ccf:	ba 5b 00 00 00       	mov    edx,0x5b
    1cd4:	be 0f 00 00 00       	mov    esi,0xf
    1cd9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1ce0:	e8 00 00 00 00       	call   1ce5 <second_tick+0x5fe>
				putc_prc(&km_regC, KFMT_NORMAL, ']', 11, 0);
    1ce5:	41 b8 00 00 00 00    	mov    r8d,0x0
    1ceb:	b9 0b 00 00 00       	mov    ecx,0xb
    1cf0:	ba 5d 00 00 00       	mov    edx,0x5d
    1cf5:	be 0f 00 00 00       	mov    esi,0xf
    1cfa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d01:	e8 00 00 00 00       	call   1d06 <second_tick+0x61f>
				for (uint16_t i = 1; i < 1 + gran; i++) {
    1d06:	66 c7 45 fc 01 00    	mov    WORD PTR [rbp-0x4],0x1
    1d0c:	e9 b7 00 00 00       	jmp    1dc8 <second_tick+0x6e1>
						if (i < l_k)
    1d11:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1d15:	66 3b 45 d8          	cmp    ax,WORD PTR [rbp-0x28]
    1d19:	73 24                	jae    1d3f <second_tick+0x658>
								putc_prc(&km_regC, KFMT_ERROR, '|', i, 0);
    1d1b:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1d1f:	41 b8 00 00 00 00    	mov    r8d,0x0
    1d25:	89 c1                	mov    ecx,eax
    1d27:	ba 7c 00 00 00       	mov    edx,0x7c
    1d2c:	be 0c 00 00 00       	mov    esi,0xc
    1d31:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d38:	e8 00 00 00 00       	call   1d3d <second_tick+0x656>
    1d3d:	eb 7e                	jmp    1dbd <second_tick+0x6d6>
						else if (i < l_n)
    1d3f:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1d43:	66 3b 45 d6          	cmp    ax,WORD PTR [rbp-0x2a]
    1d47:	73 24                	jae    1d6d <second_tick+0x686>
								putc_prc(&km_regC, KFMT_WARN, '|', i, 0);
    1d49:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1d4d:	41 b8 00 00 00 00    	mov    r8d,0x0
    1d53:	89 c1                	mov    ecx,eax
    1d55:	ba 7c 00 00 00       	mov    edx,0x7c
    1d5a:	be 0e 00 00 00       	mov    esi,0xe
    1d5f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d66:	e8 00 00 00 00       	call   1d6b <second_tick+0x684>
    1d6b:	eb 50                	jmp    1dbd <second_tick+0x6d6>
						else if (i < l_u)
    1d6d:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1d71:	66 3b 45 d4          	cmp    ax,WORD PTR [rbp-0x2c]
    1d75:	73 24                	jae    1d9b <second_tick+0x6b4>
								putc_prc(&km_regC, KFMT_INFO, '|', i, 0);
    1d77:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1d7b:	41 b8 00 00 00 00    	mov    r8d,0x0
    1d81:	89 c1                	mov    ecx,eax
    1d83:	ba 7c 00 00 00       	mov    edx,0x7c
    1d88:	be 0b 00 00 00       	mov    esi,0xb
    1d8d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d94:	e8 00 00 00 00       	call   1d99 <second_tick+0x6b2>
    1d99:	eb 22                	jmp    1dbd <second_tick+0x6d6>
								putc_prc(&km_regC, KFMT_NORMAL, ' ', i, 0);
    1d9b:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1d9f:	41 b8 00 00 00 00    	mov    r8d,0x0
    1da5:	89 c1                	mov    ecx,eax
    1da7:	ba 20 00 00 00       	mov    edx,0x20
    1dac:	be 0f 00 00 00       	mov    esi,0xf
    1db1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1db8:	e8 00 00 00 00       	call   1dbd <second_tick+0x6d6>
				for (uint16_t i = 1; i < 1 + gran; i++) {
    1dbd:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1dc1:	83 c0 01             	add    eax,0x1
    1dc4:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
    1dc8:	0f b7 45 da          	movzx  eax,WORD PTR [rbp-0x26]
    1dcc:	66 3b 45 fc          	cmp    ax,WORD PTR [rbp-0x4]
    1dd0:	0f 83 3b ff ff ff    	jae    1d11 <second_tick+0x62a>
				km_regC.cur_y = 0;
    1dd6:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 1ddf <second_tick+0x6f8>
				km_regC.cur_x = 2 + gran;
    1ddf:	0f b7 45 da          	movzx  eax,WORD PTR [rbp-0x26]
    1de3:	83 c0 02             	add    eax,0x2
    1de6:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 1ded <second_tick+0x706>
				pc_a = min(100, 100 - cpu_pcs[0].vals[0] - ((cpu_pcs[0].vals[4] > 0)
    1ded:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1df4 <second_tick+0x70d>
    1df4:	8b 10                	mov    edx,DWORD PTR [rax]
    1df6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1dfd <second_tick+0x716>
    1dfd:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e00:	85 c0                	test   eax,eax
    1e02:	74 07                	je     1e0b <second_tick+0x724>
    1e04:	b8 01 00 00 00       	mov    eax,0x1
    1e09:	eb 05                	jmp    1e10 <second_tick+0x729>
    1e0b:	b8 00 00 00 00       	mov    eax,0x0
    1e10:	01 d0                	add    eax,edx
    1e12:	83 f8 64             	cmp    eax,0x64
    1e15:	77 30                	ja     1e47 <second_tick+0x760>
    1e17:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e1e <second_tick+0x737>
    1e1e:	8b 00                	mov    eax,DWORD PTR [rax]
    1e20:	89 c2                	mov    edx,eax
    1e22:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e29 <second_tick+0x742>
    1e29:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e2c:	85 c0                	test   eax,eax
    1e2e:	74 07                	je     1e37 <second_tick+0x750>
    1e30:	b8 01 00 00 00       	mov    eax,0x1
    1e35:	eb 05                	jmp    1e3c <second_tick+0x755>
    1e37:	b8 00 00 00 00       	mov    eax,0x0
    1e3c:	01 c2                	add    edx,eax
    1e3e:	b8 64 00 00 00       	mov    eax,0x64
    1e43:	29 d0                	sub    eax,edx
    1e45:	eb 05                	jmp    1e4c <second_tick+0x765>
    1e47:	b8 64 00 00 00       	mov    eax,0x64
    1e4c:	66 89 45 d2          	mov    WORD PTR [rbp-0x2e],ax
				pc_b = min(9, 10 - cpu_pcs[0].vals[4]);
    1e50:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e57 <second_tick+0x770>
    1e57:	8b 50 10             	mov    edx,DWORD PTR [rax+0x10]
    1e5a:	b8 0a 00 00 00       	mov    eax,0xa
    1e5f:	29 d0                	sub    eax,edx
    1e61:	ba 09 00 00 00       	mov    edx,0x9
    1e66:	39 d0                	cmp    eax,edx
    1e68:	0f 47 c2             	cmova  eax,edx
    1e6b:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
				if (pc_a == 100)
    1e6f:	66 83 7d d2 64       	cmp    WORD PTR [rbp-0x2e],0x64
    1e74:	75 06                	jne    1e7c <second_tick+0x795>
						pc_b = 0;
    1e76:	66 c7 45 fe 00 00    	mov    WORD PTR [rbp-0x2],0x0
				crprintf(KFMT_NORMAL, &km_regC, "%3u.%1u%%", pc_a, pc_b);
    1e7c:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    1e80:	0f b7 45 d2          	movzx  eax,WORD PTR [rbp-0x2e]
    1e84:	41 89 d0             	mov    r8d,edx
    1e87:	89 c1                	mov    ecx,eax
    1e89:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    1e90:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1e97:	bf 0f 00 00 00       	mov    edi,0xf
    1e9c:	b8 00 00 00 00       	mov    eax,0x0
    1ea1:	e8 00 00 00 00       	call   1ea6 <second_tick+0x7bf>
}
    1ea6:	90                   	nop
    1ea7:	c9                   	leave
    1ea8:	c3                   	ret

0000000000001ea9 <print_counter>:
void print_counter()
{
    1ea9:	55                   	push   rbp
    1eaa:	48 89 e5             	mov    rbp,rsp
    1ead:	48 83 ec 20          	sub    rsp,0x20
		extern uint64_t fb_rdt; uint64_t rdt; const char* tp = "";
    1eb1:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (counter_print == jiffies) /* limit the updates */
    1eb9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1ec0 <print_counter+0x17>
    1ec0:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1ec3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1eca <print_counter+0x21>
    1eca:	48 39 c2             	cmp    rdx,rax
    1ecd:	0f 84 a2 02 00 00    	je     2175 <print_counter+0x2cc>
				return;
		counter_print = jiffies;
    1ed3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1eda <print_counter+0x31>
    1eda:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1edd:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1ee4 <print_counter+0x3b>
		if (tsc_per_ms) {
    1ee4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1eeb <print_counter+0x42>
    1eeb:	48 85 c0             	test   rax,rax
    1eee:	0f 84 8f 00 00 00    	je     1f83 <print_counter+0xda>
				tp = " ns";
    1ef4:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				rdt = fb_rdt * 1000000 / tsc_per_ms;
    1efc:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f03 <print_counter+0x5a>
    1f03:	48 69 c0 40 42 0f 00 	imul   rax,rax,0xf4240
    1f0a:	48 8b 35 00 00 00 00 	mov    rsi,QWORD PTR [rip+0x0]        # 1f11 <print_counter+0x68>
    1f11:	ba 00 00 00 00       	mov    edx,0x0
    1f16:	48 f7 f6             	div    rsi
    1f19:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (rdt > 99999) {
    1f1d:	48 81 7d f8 9f 86 01 00 	cmp    QWORD PTR [rbp-0x8],0x1869f
    1f25:	76 28                	jbe    1f4f <print_counter+0xa6>
						rdt /= 1000;
    1f27:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1f2b:	48 c1 e8 03          	shr    rax,0x3
    1f2f:	48 ba cf f7 53 e3 a5 9b c4 20 	movabs rdx,0x20c49ba5e353f7cf
    1f39:	48 f7 e2             	mul    rdx
    1f3c:	48 89 d0             	mov    rax,rdx
    1f3f:	48 c1 e8 04          	shr    rax,0x4
    1f43:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						tp = " mu";
    1f47:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				}
				if (rdt > 99999) {
    1f4f:	48 81 7d f8 9f 86 01 00 	cmp    QWORD PTR [rbp-0x8],0x1869f
    1f57:	76 35                	jbe    1f8e <print_counter+0xe5>
						rdt /= 1000;
    1f59:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1f5d:	48 c1 e8 03          	shr    rax,0x3
    1f61:	48 ba cf f7 53 e3 a5 9b c4 20 	movabs rdx,0x20c49ba5e353f7cf
    1f6b:	48 f7 e2             	mul    rdx
    1f6e:	48 89 d0             	mov    rax,rdx
    1f71:	48 c1 e8 04          	shr    rax,0x4
    1f75:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						tp = " ms";
    1f79:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1f81:	eb 0b                	jmp    1f8e <print_counter+0xe5>
				}
		} else
				rdt = fb_rdt;
    1f83:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f8a <print_counter+0xe1>
    1f8a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		km_regC.cur_x = 0; km_regC.cur_y = 1;
    1f8e:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 1f97 <print_counter+0xee>
    1f97:	66 c7 05 00 00 00 00 01 00 	mov    WORD PTR [rip+0x0],0x1        # 1fa0 <print_counter+0xf7>
		rprintf(&km_regC, "%7llu: %7llu%s", counter_print, rdt, tp);
    1fa0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1fa7 <print_counter+0xfe>
    1fa7:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    1fab:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1faf:	49 89 c8             	mov    r8,rcx
    1fb2:	48 89 d1             	mov    rcx,rdx
    1fb5:	48 89 c2             	mov    rdx,rax
    1fb8:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1fbf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1fc6:	b8 00 00 00 00       	mov    eax,0x0
    1fcb:	e8 00 00 00 00       	call   1fd0 <print_counter+0x127>
		if ((jiffies - counter_sec) > HZ || !counter_sec) {
    1fd0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1fd7 <print_counter+0x12e>
    1fd7:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1fda:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1fe1 <print_counter+0x138>
    1fe1:	48 29 c2             	sub    rdx,rax
    1fe4:	48 83 fa 79          	cmp    rdx,0x79
    1fe8:	77 0c                	ja     1ff6 <print_counter+0x14d>
    1fea:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1ff1 <print_counter+0x148>
    1ff1:	48 85 c0             	test   rax,rax
    1ff4:	75 3b                	jne    2031 <print_counter+0x188>
				if (!counter_sec)
    1ff6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1ffd <print_counter+0x154>
    1ffd:	48 85 c0             	test   rax,rax
    2000:	75 13                	jne    2015 <print_counter+0x16c>
						counter_sec = jiffies;
    2002:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2009 <print_counter+0x160>
    2009:	48 8b 00             	mov    rax,QWORD PTR [rax]
    200c:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2013 <print_counter+0x16a>
    2013:	eb 12                	jmp    2027 <print_counter+0x17e>
				else
						counter_sec += HZ;
    2015:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 201c <print_counter+0x173>
    201c:	48 83 c0 79          	add    rax,0x79
    2020:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2027 <print_counter+0x17e>
				second_tick();
    2027:	b8 00 00 00 00       	mov    eax,0x0
    202c:	e8 00 00 00 00       	call   2031 <print_counter+0x188>
		}

		/* update memory stats faster than every second! really? */
		km_regS.cur_x = 0;
    2031:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 203a <print_counter+0x191>
		km_regS.cur_y = 1;
    203a:	66 c7 05 00 00 00 00 01 00 	mov    WORD PTR [rip+0x0],0x1        # 2043 <print_counter+0x19a>
		
		void kstats(size_t* s_total, size_t* s_commit,
					   	size_t* s_free, size_t* s_nheaps);
		kstats(h_stats, h_stats + 1, h_stats + 2, h_stats + 3);
    2043:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    204a:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    2051:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2058:	48 89 c6             	mov    rsi,rax
    205b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2062:	e8 00 00 00 00       	call   2067 <print_counter+0x1be>
		for (size_t i = 0; i < 4; i++)
    2067:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    206f:	e9 f4 00 00 00       	jmp    2168 <print_counter+0x2bf>
				if (h_stats_old[i] != h_stats[i]) {
    2074:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2078:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    2080:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2084:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    208c:	48 39 c2             	cmp    rdx,rax
    208f:	0f 84 ce 00 00 00    	je     2163 <print_counter+0x2ba>
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
								h_stats[3], (h_stats[2]) / 1024);
    2095:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 209c <print_counter+0x1f3>
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    209c:	48 c1 e8 0a          	shr    rax,0xa
    20a0:	48 89 c6             	mov    rsi,rax
    20a3:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 20aa <print_counter+0x201>
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
    20aa:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 20b1 <print_counter+0x208>
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    20b1:	48 3d 9f 86 01 00    	cmp    rax,0x1869f
    20b7:	77 21                	ja     20da <print_counter+0x231>
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
    20b9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 20c0 <print_counter+0x217>
    20c0:	48 3d 0f 27 00 00    	cmp    rax,0x270f
    20c6:	76 09                	jbe    20d1 <print_counter+0x228>
    20c8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    20cf:	eb 10                	jmp    20e1 <print_counter+0x238>
    20d1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    20d8:	eb 07                	jmp    20e1 <print_counter+0x238>
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    20da:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
    20e1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 20e8 <print_counter+0x23f>
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    20e8:	48 3d 9f 86 01 00    	cmp    rax,0x1869f
    20ee:	76 0d                	jbe    20fd <print_counter+0x254>
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
    20f0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 20f7 <print_counter+0x24e>
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
    20f7:	48 c1 e8 0a          	shr    rax,0xa
    20fb:	eb 07                	jmp    2104 <print_counter+0x25b>
    20fd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2104 <print_counter+0x25b>
    2104:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 210b <print_counter+0x262>
    210b:	48 c1 ea 0a          	shr    rdx,0xa
    210f:	56                   	push   rsi
    2110:	51                   	push   rcx
    2111:	49 89 f9             	mov    r9,rdi
    2114:	49 89 c0             	mov    r8,rax
    2117:	48 89 d1             	mov    rcx,rdx
    211a:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    2121:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2128:	bf 2f 00 00 00       	mov    edi,0x2f
    212d:	b8 00 00 00 00       	mov    eax,0x0
    2132:	e8 00 00 00 00       	call   2137 <print_counter+0x28e>
    2137:	48 83 c4 10          	add    rsp,0x10
						for (; i < 4; i++)
    213b:	eb 1d                	jmp    215a <print_counter+0x2b1>
								h_stats_old[i] = h_stats[i];
    213d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2141:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    2149:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    214d:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						for (; i < 4; i++)
    2155:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    215a:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
    215f:	76 dc                	jbe    213d <print_counter+0x294>
						break;
    2161:	eb 13                	jmp    2176 <print_counter+0x2cd>
		for (size_t i = 0; i < 4; i++)
    2163:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2168:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
    216d:	0f 86 01 ff ff ff    	jbe    2074 <print_counter+0x1cb>
    2173:	eb 01                	jmp    2176 <print_counter+0x2cd>
				return;
    2175:	90                   	nop
				}
}
    2176:	c9                   	leave
    2177:	c3                   	ret

0000000000002178 <ktimer_tick>:

/* this is the workhorse used for time-keeping */
void ktimer_tick()
{
    2178:	55                   	push   rbp
    2179:	48 89 e5             	mov    rbp,rsp
		extern uint64_t fb_udc;
		extern uint64_t fb_rdc;
		extern uint64_t fb_rdt;
		/* timekeeping */
		jiffies++;
    217c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2183 <ktimer_tick+0xb>
    2183:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    2186:	48 83 c2 01          	add    rdx,0x1
    218a:	48 89 10             	mov    QWORD PTR [rax],rdx
		if (irq0_hook) /* don't starve bogo_mips calculation */
    218d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2194 <ktimer_tick+0x1c>
    2194:	48 85 c0             	test   rax,rax
    2197:	75 3f                	jne    21d8 <ktimer_tick+0x60>
				return;

		static volatile int redr = 0;
		extern int preempt_needs_init;
		if (preempt_needs_init && !redr--) {
    2199:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 219f <ktimer_tick+0x27>
    219f:	85 c0                	test   eax,eax
    21a1:	74 36                	je     21d9 <ktimer_tick+0x61>
    21a3:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 21a9 <ktimer_tick+0x31>
    21a9:	8d 50 ff             	lea    edx,[rax-0x1]
    21ac:	89 15 00 00 00 00    	mov    DWORD PTR [rip+0x0],edx        # 21b2 <ktimer_tick+0x3a>
    21b2:	85 c0                	test   eax,eax
    21b4:	75 23                	jne    21d9 <ktimer_tick+0x61>
				redr = 10;
    21b6:	c7 05 00 00 00 00 0a 00 00 00 	mov    DWORD PTR [rip+0x0],0xa        # 21c0 <ktimer_tick+0x48>
				print_counter();
    21c0:	b8 00 00 00 00       	mov    eax,0x0
    21c5:	e8 00 00 00 00       	call   21ca <ktimer_tick+0x52>
				framebuffer_redraw_updates(&fb_initial);
    21ca:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    21d1:	e8 00 00 00 00       	call   21d6 <ktimer_tick+0x5e>
    21d6:	eb 01                	jmp    21d9 <ktimer_tick+0x61>
				return;
    21d8:	90                   	nop
		}
}
    21d9:	5d                   	pop    rbp
    21da:	c3                   	ret

00000000000021db <kredraw>:

void kredraw(void* data)
{
    21db:	55                   	push   rbp
    21dc:	48 89 e5             	mov    rbp,rsp
    21df:	48 83 ec 10          	sub    rsp,0x10
    21e3:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		while (1) {
				extern struct wait_queue_head wq_timer;
				print_counter();
    21e7:	b8 00 00 00 00       	mov    eax,0x0
    21ec:	e8 00 00 00 00       	call   21f1 <kredraw+0x16>
				//asm("cli");
				preempt_disable();
    21f1:	b8 00 00 00 00       	mov    eax,0x0
    21f6:	e8 00 00 00 00       	call   21fb <kredraw+0x20>
    21fb:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    21fe:	83 c2 01             	add    edx,0x1
    2201:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
				framebuffer_redraw_updates(&fb_initial);
    2204:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    220b:	e8 00 00 00 00       	call   2210 <kredraw+0x35>
				preempt_enable_no_resched();
    2210:	b8 00 00 00 00       	mov    eax,0x0
    2215:	e8 00 00 00 00       	call   221a <kredraw+0x3f>
    221a:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    221d:	83 ea 01             	sub    edx,0x1
    2220:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
				//asm("sti");
				wait_timeout(&wq_timer, HZ / 60);
    2223:	be 02 00 00 00       	mov    esi,0x2
    2228:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    222f:	e8 00 00 00 00       	call   2234 <kredraw+0x59>
		while (1) {
    2234:	90                   	nop
    2235:	eb b0                	jmp    21e7 <kredraw+0xc>

0000000000002237 <clock_gettime>:
		}
}

int clock_gettime(clockid_t clk_id, struct timespec* tp)
{
    2237:	55                   	push   rbp
    2238:	48 89 e5             	mov    rbp,rsp
    223b:	48 83 ec 50          	sub    rsp,0x50
    223f:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
    2242:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		if (!tp || clk_id != CLOCK_REALTIME) {
    2246:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    224b:	74 06                	je     2253 <clock_gettime+0x1c>
    224d:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    2251:	74 14                	je     2267 <clock_gettime+0x30>
				errno = EINVAL;
    2253:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 225d <clock_gettime+0x26>
				return -1;
    225d:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2262:	e9 d0 01 00 00       	jmp    2437 <clock_gettime+0x200>
		}
		/* query the cmos for REALTIME if needed */
		if (!km_set) {
    2267:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 226e <clock_gettime+0x37>
    226e:	48 85 c0             	test   rax,rax
    2271:	75 57                	jne    22ca <clock_gettime+0x93>
				km_time = cmos_get_time();
    2273:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    2277:	48 89 c7             	mov    rdi,rax
    227a:	b8 00 00 00 00       	mov    eax,0x0
    227f:	e8 00 00 00 00       	call   2284 <clock_gettime+0x4d>
    2284:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2288:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    228c:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2293 <clock_gettime+0x5c>
    2293:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 229a <clock_gettime+0x63>
    229a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    229e:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    22a2:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 22a9 <clock_gettime+0x72>
    22a9:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 22b0 <clock_gettime+0x79>
    22b0:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    22b3:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 22b9 <clock_gettime+0x82>
				km_set = jiffies;
    22b9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 22c0 <clock_gettime+0x89>
    22c0:	48 8b 00             	mov    rax,QWORD PTR [rax]
    22c3:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 22ca <clock_gettime+0x93>
		}
		tp->tv_nsec = 0;
    22ca:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    22ce:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
				ct |= (uint16_t)inb(PIT1_CH0) << 8;
				ct = (uint16_t)(PIT_FREQ / CLOCKS_PER_SEC) - ct;
				tp->tv_nsec += (long)((double)(uint32_t)ct * 1000000 / PIT_FREQ);
		}
		/* calculate the number of leap days since 1970 */
		time_t diff = jiffies - km_set;
    22d6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 22dd <clock_gettime+0xa6>
    22dd:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    22e0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 22e7 <clock_gettime+0xb0>
    22e7:	48 29 c2             	sub    rdx,rax
    22ea:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
		tp->tv_nsec = diff - (time_t)((time_t)(diff / CLOCKS_PER_SEC) * CLOCKS_PER_SEC);
    22ee:	66 0f ef c0          	pxor   xmm0,xmm0
    22f2:	f2 48 0f 2a 45 f8    	cvtsi2sd xmm0,QWORD PTR [rbp-0x8]
    22f8:	f2 0f 10 0d 00 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # 2300 <clock_gettime+0xc9>
    2300:	f2 0f 5e c1          	divsd  xmm0,xmm1
    2304:	f2 48 0f 2c c0       	cvttsd2si rax,xmm0
    2309:	66 0f ef c9          	pxor   xmm1,xmm1
    230d:	f2 48 0f 2a c8       	cvtsi2sd xmm1,rax
    2312:	f2 0f 10 05 00 00 00 00 	movsd  xmm0,QWORD PTR [rip+0x0]        # 231a <clock_gettime+0xe3>
    231a:	f2 0f 59 c1          	mulsd  xmm0,xmm1
    231e:	f2 48 0f 2c c0       	cvttsd2si rax,xmm0
    2323:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2327:	48 29 c2             	sub    rdx,rax
    232a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    232e:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		tp->tv_nsec = (long)((tp->tv_nsec * 1000000) / CLOCKS_PER_SEC);
    2332:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2336:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    233a:	48 69 c0 40 42 0f 00 	imul   rax,rax,0xf4240
    2341:	66 0f ef c0          	pxor   xmm0,xmm0
    2345:	f2 48 0f 2a c0       	cvtsi2sd xmm0,rax
    234a:	f2 0f 10 0d 00 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # 2352 <clock_gettime+0x11b>
    2352:	f2 0f 5e c1          	divsd  xmm0,xmm1
    2356:	f2 48 0f 2c d0       	cvttsd2si rdx,xmm0
    235b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    235f:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    2363:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2369 <clock_gettime+0x132>
    2369:	05 6b 07 00 00       	add    eax,0x76b
    236e:	69 d0 6d 01 00 00    	imul   edx,eax,0x16d
    2374:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 237a <clock_gettime+0x143>
    237a:	05 6b 07 00 00       	add    eax,0x76b
    237f:	8d 48 03             	lea    ecx,[rax+0x3]
    2382:	85 c0                	test   eax,eax
    2384:	0f 48 c1             	cmovs  eax,ecx
    2387:	c1 f8 02             	sar    eax,0x2
    238a:	89 c6                	mov    esi,eax
    238c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2392 <clock_gettime+0x15b>
    2392:	05 6b 07 00 00       	add    eax,0x76b
    2397:	48 63 c8             	movsxd rcx,eax
    239a:	48 69 c9 1f 85 eb 51 	imul   rcx,rcx,0x51eb851f
    23a1:	48 c1 e9 20          	shr    rcx,0x20
    23a5:	c1 f9 05             	sar    ecx,0x5
    23a8:	c1 f8 1f             	sar    eax,0x1f
    23ab:	29 c8                	sub    eax,ecx
    23ad:	01 c6                	add    esi,eax
    23af:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23b5 <clock_gettime+0x17e>
    23b5:	05 6b 07 00 00       	add    eax,0x76b
    23ba:	48 63 c8             	movsxd rcx,eax
    23bd:	48 69 c9 1f 85 eb 51 	imul   rcx,rcx,0x51eb851f
    23c4:	48 c1 e9 20          	shr    rcx,0x20
    23c8:	c1 f9 07             	sar    ecx,0x7
    23cb:	c1 f8 1f             	sar    eax,0x1f
    23ce:	29 c1                	sub    ecx,eax
    23d0:	8d 04 0e             	lea    eax,[rsi+rcx*1]
    23d3:	01 d0                	add    eax,edx
    23d5:	8d 90 c6 06 f5 ff    	lea    edx,[rax-0xaf93a]
						+ km_time.tm_yday) + 3600 * km_time.tm_hour
    23db:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23e1 <clock_gettime+0x1aa>
    23e1:	01 d0                	add    eax,edx
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    23e3:	69 d0 80 51 01 00    	imul   edx,eax,0x15180
						+ km_time.tm_yday) + 3600 * km_time.tm_hour
    23e9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23ef <clock_gettime+0x1b8>
    23ef:	69 c0 10 0e 00 00    	imul   eax,eax,0xe10
    23f5:	01 c2                	add    edx,eax
						+ 60 * km_time.tm_min + km_time.tm_sec
    23f7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23fd <clock_gettime+0x1c6>
    23fd:	6b c0 3c             	imul   eax,eax,0x3c
    2400:	01 c2                	add    edx,eax
    2402:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2408 <clock_gettime+0x1d1>
    2408:	01 d0                	add    eax,edx
    240a:	48 63 d0             	movsxd rdx,eax
						+ (time_t)(diff / CLOCKS_PER_SEC);
    240d:	66 0f ef c0          	pxor   xmm0,xmm0
    2411:	f2 48 0f 2a 45 f8    	cvtsi2sd xmm0,QWORD PTR [rbp-0x8]
    2417:	f2 0f 10 0d 00 00 00 00 	movsd  xmm1,QWORD PTR [rip+0x0]        # 241f <clock_gettime+0x1e8>
    241f:	f2 0f 5e c1          	divsd  xmm0,xmm1
    2423:	f2 48 0f 2c c0       	cvttsd2si rax,xmm0
    2428:	48 01 c2             	add    rdx,rax
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    242b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    242f:	48 89 10             	mov    QWORD PTR [rax],rdx
		return 0;
    2432:	b8 00 00 00 00       	mov    eax,0x0
}
    2437:	c9                   	leave
    2438:	c3                   	ret

0000000000002439 <hook_fun.0>:
void calibrate_bogo_mips(uint16_t pit_div)
{
		static uint32_t ct = 0, old_ct = 0, delta[8] = {0}, ni = 0;
		static uint64_t ts_delta[8], ts_ct = 0;
		uint32_t limit = 0x00f00000; /* very low for QEMU-software emu */
		void hook_fun() {
    2439:	55                   	push   rbp
    243a:	48 89 e5             	mov    rbp,rsp
    243d:	48 83 ec 08          	sub    rsp,0x8
    2441:	4c 89 55 f8          	mov    QWORD PTR [rbp-0x8],r10
				ni++;
    2445:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 244b <hook_fun.0+0x12>
    244b:	83 c0 01             	add    eax,0x1
    244e:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2454 <hook_fun.0+0x1b>
				if (old_ct && ni <= 9) {
    2454:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 245a <hook_fun.0+0x21>
    245a:	85 c0                	test   eax,eax
    245c:	74 4e                	je     24ac <hook_fun.0+0x73>
    245e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2464 <hook_fun.0+0x2b>
    2464:	83 f8 09             	cmp    eax,0x9
    2467:	77 43                	ja     24ac <hook_fun.0+0x73>
						delta[ni - 2] = ct - old_ct;
    2469:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 246f <hook_fun.0+0x36>
    246f:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2475 <hook_fun.0+0x3c>
    2475:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 247b <hook_fun.0+0x42>
    247b:	83 e9 02             	sub    ecx,0x2
    247e:	29 c2                	sub    edx,eax
    2480:	89 c8                	mov    eax,ecx
    2482:	89 14 85 00 00 00 00 	mov    DWORD PTR [rax*4+0x0],edx
						if (cpu.has_tsc)
    2489:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2490 <hook_fun.0+0x57>
    2490:	83 e0 10             	and    eax,0x10
    2493:	84 c0                	test   al,al
    2495:	74 15                	je     24ac <hook_fun.0+0x73>
								asm volatile ("rdtsc" : "=A" (ts_delta[ni - 2]));
    2497:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 249d <hook_fun.0+0x64>
    249d:	8d 50 fe             	lea    edx,[rax-0x2]
    24a0:	0f 31                	rdtsc
    24a2:	89 d2                	mov    edx,edx
    24a4:	48 89 04 d5 00 00 00 00 	mov    QWORD PTR [rdx*8+0x0],rax
				}
				old_ct = ct;
    24ac:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 24b2 <hook_fun.0+0x79>
    24b2:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 24b8 <hook_fun.0+0x7f>
				if (ni >= 9)
    24b8:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 24be <hook_fun.0+0x85>
    24be:	83 f8 08             	cmp    eax,0x8
    24c1:	76 0b                	jbe    24ce <hook_fun.0+0x95>
						irq0_hook = NULL;
    24c3:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 24ce <hook_fun.0+0x95>
		}
    24ce:	90                   	nop
    24cf:	c9                   	leave
    24d0:	c3                   	ret

00000000000024d1 <calibrate_bogo_mips>:
{
    24d1:	55                   	push   rbp
    24d2:	48 89 e5             	mov    rbp,rsp
    24d5:	48 83 ec 40          	sub    rsp,0x40
    24d9:	89 f8                	mov    eax,edi
    24db:	66 89 45 cc          	mov    WORD PTR [rbp-0x34],ax
void calibrate_bogo_mips(uint16_t pit_div)
    24df:	48 8d 45 10          	lea    rax,[rbp+0x10]
    24e3:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    24e7:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    24eb:	48 8d 55 d0          	lea    rdx,[rbp-0x30]
    24ef:	66 c7 00 49 bb       	mov    WORD PTR [rax],0xbb49
    24f4:	48 c7 40 02 00 00 00 00 	mov    QWORD PTR [rax+0x2],0x0
    24fc:	66 c7 40 0a 49 ba    	mov    WORD PTR [rax+0xa],0xba49
    2502:	48 89 50 0c          	mov    QWORD PTR [rax+0xc],rdx
    2506:	c7 40 14 49 ff e3 90 	mov    DWORD PTR [rax+0x14],0x90e3ff49
		uint32_t limit = 0x00f00000; /* very low for QEMU-software emu */
    250d:	c7 45 fc 00 00 f0 00 	mov    DWORD PTR [rbp-0x4],0xf00000

		printf("calibrating bogous MIPS value...\n");
    2514:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    251b:	b8 00 00 00 00       	mov    eax,0x0
    2520:	e8 00 00 00 00       	call   2525 <calibrate_bogo_mips+0x54>
		/* do the adaptive loop
		 * if limit needs to be > 32bit we're f'ed  */
		do {
				/* zero the variables */
				ct = old_ct = ni = 0;
    2525:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 252f <calibrate_bogo_mips+0x5e>
    252f:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2535 <calibrate_bogo_mips+0x64>
    2535:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 253b <calibrate_bogo_mips+0x6a>
    253b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2541 <calibrate_bogo_mips+0x70>
    2541:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2547 <calibrate_bogo_mips+0x76>
				/* (re-)install the irq0 hook */
				irq0_hook = hook_fun;
    2547:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    254b:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2552 <calibrate_bogo_mips+0x81>
				for (ct = 0; ct < limit; ct++);
    2552:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 255c <calibrate_bogo_mips+0x8b>
    255c:	eb 0f                	jmp    256d <calibrate_bogo_mips+0x9c>
    255e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2564 <calibrate_bogo_mips+0x93>
    2564:	83 c0 01             	add    eax,0x1
    2567:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 256d <calibrate_bogo_mips+0x9c>
    256d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2573 <calibrate_bogo_mips+0xa2>
    2573:	3b 45 fc             	cmp    eax,DWORD PTR [rbp-0x4]
    2576:	72 e6                	jb     255e <calibrate_bogo_mips+0x8d>
				if (ni < 9) { /* unusable -> redo */
    2578:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 257e <calibrate_bogo_mips+0xad>
    257e:	83 f8 08             	cmp    eax,0x8
    2581:	77 31                	ja     25b4 <calibrate_bogo_mips+0xe3>
						limit <<= 4;
    2583:	c1 65 fc 04          	shl    DWORD PTR [rbp-0x4],0x4
						printf("increasing bogous MIPS calibration loop limit to %x\n", limit);
    2587:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    258a:	89 c6                	mov    esi,eax
    258c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2593:	b8 00 00 00 00       	mov    eax,0x0
    2598:	e8 00 00 00 00       	call   259d <calibrate_bogo_mips+0xcc>
						/* wait for hook self-removal */
						while (irq0_hook);
    259d:	90                   	nop
    259e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 25a5 <calibrate_bogo_mips+0xd4>
    25a5:	48 85 c0             	test   rax,rax
    25a8:	75 f4                	jne    259e <calibrate_bogo_mips+0xcd>
						ni = 0;
    25aa:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 25b4 <calibrate_bogo_mips+0xe3>
				}
		} while (ni < 9);
    25b4:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25ba <calibrate_bogo_mips+0xe9>
    25ba:	83 f8 08             	cmp    eax,0x8
    25bd:	0f 86 62 ff ff ff    	jbe    2525 <calibrate_bogo_mips+0x54>

		/* now we have 8 positive delta values for
		 * calibrating bogo_mips each div ticks apart */
		old_ct = 0;
    25c3:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 25cd <calibrate_bogo_mips+0xfc>
		for (ct = 0; ct < 8; ct++) {
    25cd:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 25d7 <calibrate_bogo_mips+0x106>
    25d7:	e9 a3 00 00 00       	jmp    267f <calibrate_bogo_mips+0x1ae>
				printf("%u: %08x\n", ct, delta[ct]);
    25dc:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25e2 <calibrate_bogo_mips+0x111>
    25e2:	89 c0                	mov    eax,eax
    25e4:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [rax*4+0x0]
    25eb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25f1 <calibrate_bogo_mips+0x120>
    25f1:	89 c6                	mov    esi,eax
    25f3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25fa:	b8 00 00 00 00       	mov    eax,0x0
    25ff:	e8 00 00 00 00       	call   2604 <calibrate_bogo_mips+0x133>
				old_ct += delta[ct];
    2604:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 260a <calibrate_bogo_mips+0x139>
    260a:	89 c0                	mov    eax,eax
    260c:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [rax*4+0x0]
    2613:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2619 <calibrate_bogo_mips+0x148>
    2619:	01 d0                	add    eax,edx
    261b:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2621 <calibrate_bogo_mips+0x150>
				if (cpu.has_tsc && ct)
    2621:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2628 <calibrate_bogo_mips+0x157>
    2628:	83 e0 10             	and    eax,0x10
    262b:	84 c0                	test   al,al
    262d:	74 41                	je     2670 <calibrate_bogo_mips+0x19f>
    262f:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2635 <calibrate_bogo_mips+0x164>
    2635:	85 c0                	test   eax,eax
    2637:	74 37                	je     2670 <calibrate_bogo_mips+0x19f>
						ts_ct += ts_delta[ct] - ts_delta[ct - 1];
    2639:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 263f <calibrate_bogo_mips+0x16e>
    263f:	89 c0                	mov    eax,eax
    2641:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    2649:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 264f <calibrate_bogo_mips+0x17e>
    264f:	83 e8 01             	sub    eax,0x1
    2652:	89 c0                	mov    eax,eax
    2654:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    265c:	48 29 c2             	sub    rdx,rax
    265f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2666 <calibrate_bogo_mips+0x195>
    2666:	48 01 d0             	add    rax,rdx
    2669:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2670 <calibrate_bogo_mips+0x19f>
		for (ct = 0; ct < 8; ct++) {
    2670:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2676 <calibrate_bogo_mips+0x1a5>
    2676:	83 c0 01             	add    eax,0x1
    2679:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 267f <calibrate_bogo_mips+0x1ae>
    267f:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2685 <calibrate_bogo_mips+0x1b4>
    2685:	83 f8 07             	cmp    eax,0x7
    2688:	0f 86 4e ff ff ff    	jbe    25dc <calibrate_bogo_mips+0x10b>
		}
		old_ct /= 8;
    268e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2694 <calibrate_bogo_mips+0x1c3>
    2694:	c1 e8 03             	shr    eax,0x3
    2697:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 269d <calibrate_bogo_mips+0x1cc>
		if (cpu.has_tsc)
    269d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 26a4 <calibrate_bogo_mips+0x1d3>
    26a4:	83 e0 10             	and    eax,0x10
    26a7:	84 c0                	test   al,al
    26a9:	74 2e                	je     26d9 <calibrate_bogo_mips+0x208>
				ts_ct /= 7;
    26ab:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 26b2 <calibrate_bogo_mips+0x1e1>
    26b2:	48 ba 93 24 49 92 24 49 92 24 	movabs rdx,0x2492492492492493
    26bc:	48 89 c8             	mov    rax,rcx
    26bf:	48 f7 e2             	mul    rdx
    26c2:	48 89 c8             	mov    rax,rcx
    26c5:	48 29 d0             	sub    rax,rdx
    26c8:	48 d1 e8             	shr    rax,1
    26cb:	48 01 d0             	add    rax,rdx
    26ce:	48 c1 e8 02          	shr    rax,0x2
    26d2:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 26d9 <calibrate_bogo_mips+0x208>
		printf("Bougous MIPS calibrated to %08x steps per PIT tick with a "
    26d9:	0f b7 55 cc          	movzx  edx,WORD PTR [rbp-0x34]
    26dd:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 26e3 <calibrate_bogo_mips+0x212>
    26e3:	89 c6                	mov    esi,eax
    26e5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    26ec:	b8 00 00 00 00       	mov    eax,0x0
    26f1:	e8 00 00 00 00       	call   26f6 <calibrate_bogo_mips+0x225>
				"PIT divider of %u\n", old_ct, pit_div);
		loops_per_jiffy = old_ct;
    26f6:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 26fc <calibrate_bogo_mips+0x22b>
    26fc:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2702 <calibrate_bogo_mips+0x231>
		printf("Therefore a delay of 1 ms corresponds to %u steps.\n",
				(loops_per_ms = (uint32_t)(HZ * (uint64_t)old_ct / 1000)));
    2702:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2708 <calibrate_bogo_mips+0x237>
    2708:	89 c2                	mov    edx,eax
    270a:	48 89 d0             	mov    rax,rdx
    270d:	48 c1 e0 04          	shl    rax,0x4
    2711:	48 29 d0             	sub    rax,rdx
    2714:	48 c1 e0 03          	shl    rax,0x3
    2718:	48 01 d0             	add    rax,rdx
    271b:	48 c1 e8 03          	shr    rax,0x3
    271f:	48 ba cf f7 53 e3 a5 9b c4 20 	movabs rdx,0x20c49ba5e353f7cf
    2729:	48 f7 e2             	mul    rdx
    272c:	48 89 d0             	mov    rax,rdx
    272f:	48 c1 e8 04          	shr    rax,0x4
		printf("Therefore a delay of 1 ms corresponds to %u steps.\n",
    2733:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2739 <calibrate_bogo_mips+0x268>
    2739:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 273f <calibrate_bogo_mips+0x26e>
    273f:	89 c6                	mov    esi,eax
    2741:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2748:	b8 00 00 00 00       	mov    eax,0x0
    274d:	e8 00 00 00 00       	call   2752 <calibrate_bogo_mips+0x281>
		if (cpu.has_tsc) {
    2752:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2759 <calibrate_bogo_mips+0x288>
    2759:	83 e0 10             	and    eax,0x10
    275c:	84 c0                	test   al,al
    275e:	74 59                	je     27b9 <calibrate_bogo_mips+0x2e8>
				printf("As this CPU has a TSC a PIT tick corresponds to %llu "
						"TSC ticks --> %llu ticks per ms.\n", ts_ct,
					   (tsc_per_ms = HZ * ts_ct / 1000));
    2760:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 2767 <calibrate_bogo_mips+0x296>
    2767:	48 89 d0             	mov    rax,rdx
    276a:	48 c1 e0 04          	shl    rax,0x4
    276e:	48 29 d0             	sub    rax,rdx
    2771:	48 c1 e0 03          	shl    rax,0x3
    2775:	48 01 d0             	add    rax,rdx
    2778:	48 c1 e8 03          	shr    rax,0x3
    277c:	48 ba cf f7 53 e3 a5 9b c4 20 	movabs rdx,0x20c49ba5e353f7cf
    2786:	48 f7 e2             	mul    rdx
    2789:	48 89 d0             	mov    rax,rdx
    278c:	48 c1 e8 04          	shr    rax,0x4
				printf("As this CPU has a TSC a PIT tick corresponds to %llu "
    2790:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2797 <calibrate_bogo_mips+0x2c6>
    2797:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 279e <calibrate_bogo_mips+0x2cd>
    279e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 27a5 <calibrate_bogo_mips+0x2d4>
    27a5:	48 89 c6             	mov    rsi,rax
    27a8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    27af:	b8 00 00 00 00       	mov    eax,0x0
    27b4:	e8 00 00 00 00       	call   27b9 <calibrate_bogo_mips+0x2e8>
		}
}
    27b9:	90                   	nop
    27ba:	c9                   	leave
    27bb:	c3                   	ret

00000000000027bc <ndelay>:

void ndelay(unsigned long nsecs)
{
    27bc:	55                   	push   rbp
    27bd:	48 89 e5             	mov    rbp,rsp
    27c0:	48 83 ec 18          	sub    rsp,0x18
    27c4:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		uint32_t ct = 0, limit = (uint32_t)((uint64_t)nsecs * loops_per_ms / 1000000);
    27c8:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    27cf:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 27d5 <ndelay+0x19>
    27d5:	89 c0                	mov    eax,eax
    27d7:	48 0f af 45 e8       	imul   rax,QWORD PTR [rbp-0x18]
    27dc:	48 ba db 34 b6 d7 82 de 1b 43 	movabs rdx,0x431bde82d7b634db
    27e6:	48 f7 e2             	mul    rdx
    27e9:	48 89 d0             	mov    rax,rdx
    27ec:	48 c1 e8 12          	shr    rax,0x12
    27f0:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		/* uses the same double mem-access
		 * as in the calibration routine */
		for (ct = 0; ct < limit; ct++);
    27f3:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    27fa:	eb 04                	jmp    2800 <ndelay+0x44>
    27fc:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    2800:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2803:	3b 45 f8             	cmp    eax,DWORD PTR [rbp-0x8]
    2806:	72 f4                	jb     27fc <ndelay+0x40>
}
    2808:	90                   	nop
    2809:	90                   	nop
    280a:	c9                   	leave
    280b:	c3                   	ret

000000000000280c <udelay>:

void udelay(unsigned long usecs)
{
    280c:	55                   	push   rbp
    280d:	48 89 e5             	mov    rbp,rsp
    2810:	48 83 ec 08          	sub    rsp,0x8
    2814:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		while (usecs--)
    2818:	eb 0a                	jmp    2824 <udelay+0x18>
				ndelay(1000);
    281a:	bf e8 03 00 00       	mov    edi,0x3e8
    281f:	e8 00 00 00 00       	call   2824 <udelay+0x18>
		while (usecs--)
    2824:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2828:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    282c:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
    2830:	48 85 c0             	test   rax,rax
    2833:	75 e5                	jne    281a <udelay+0xe>
}
    2835:	90                   	nop
    2836:	90                   	nop
    2837:	c9                   	leave
    2838:	c3                   	ret

0000000000002839 <mdelay>:

void mdelay(unsigned long msecs)
{
    2839:	55                   	push   rbp
    283a:	48 89 e5             	mov    rbp,rsp
    283d:	48 83 ec 08          	sub    rsp,0x8
    2841:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		if (!loops_per_ms)
    2845:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 284b <mdelay+0x12>
    284b:	85 c0                	test   eax,eax
    284d:	74 1f                	je     286e <mdelay+0x35>
				return;
		while (msecs--)
    284f:	eb 0a                	jmp    285b <mdelay+0x22>
				udelay(1000);
    2851:	bf e8 03 00 00       	mov    edi,0x3e8
    2856:	e8 00 00 00 00       	call   285b <mdelay+0x22>
		while (msecs--)
    285b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    285f:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    2863:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
    2867:	48 85 c0             	test   rax,rax
    286a:	75 e5                	jne    2851 <mdelay+0x18>
    286c:	eb 01                	jmp    286f <mdelay+0x36>
				return;
    286e:	90                   	nop
}
    286f:	c9                   	leave
    2870:	c3                   	ret

0000000000002871 <apic_expire>:
uint32_t apic_reload_value = 0x0fffffff;
uint8_t apic_div = 0x0b;
#define NCF_AP 48
static uint32_t n_ct = 0xffffffff, exp = 0; static uint32_t tmr_val = 0;
/* the expiration hook */
void apic_expire() {
    2871:	55                   	push   rbp
    2872:	48 89 e5             	mov    rbp,rsp
		if (!exp) /* don't unsignal 2 (done) */
    2875:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 287b <apic_expire+0xa>
    287b:	85 c0                	test   eax,eax
    287d:	75 0a                	jne    2889 <apic_expire+0x18>
				exp = 1;
    287f:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 2889 <apic_expire+0x18>
}
    2889:	90                   	nop
    288a:	5d                   	pop    rbp
    288b:	c3                   	ret

000000000000288c <irq0_worker>:

/* the irq0 calibration worker */
void irq0_worker() {
    288c:	55                   	push   rbp
    288d:	48 89 e5             	mov    rbp,rsp
    2890:	48 83 ec 10          	sub    rsp,0x10
		if (n_ct == 0xffffffff) {
    2894:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 289a <irq0_worker+0xe>
    289a:	83 f8 ff             	cmp    eax,0xffffffff
    289d:	75 2b                	jne    28ca <irq0_worker+0x3e>
				/* enable the timer */
				apic_bp_reg(APIC_REG_TMRDIV) = apic_div;
    289f:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 28a6 <irq0_worker+0x1a>
    28a6:	ba e0 03 ff ef       	mov    edx,0xefff03e0
    28ab:	0f b6 c0             	movzx  eax,al
    28ae:	89 02                	mov    DWORD PTR [rdx],eax
				apic_bp_reg(APIC_REG_TMRINITCNT) = 0xffffffff;
    28b0:	b8 80 03 ff ef       	mov    eax,0xefff0380
    28b5:	c7 00 ff ff ff ff    	mov    DWORD PTR [rax],0xffffffff
				n_ct = 0;
    28bb:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 28c5 <irq0_worker+0x39>
				return;
    28c5:	e9 00 01 00 00       	jmp    29ca <irq0_worker+0x13e>
		} else if (exp) {
    28ca:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 28d0 <irq0_worker+0x44>
    28d0:	85 c0                	test   eax,eax
    28d2:	0f 84 b4 00 00 00    	je     298c <irq0_worker+0x100>
				/* timer has expired and sample is too small */
				n_ct = 0xffffffff; exp = 0; tmr_val = 0;
    28d8:	c7 05 00 00 00 00 ff ff ff ff 	mov    DWORD PTR [rip+0x0],0xffffffff        # 28e2 <irq0_worker+0x56>
    28e2:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 28ec <irq0_worker+0x60>
    28ec:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 28f6 <irq0_worker+0x6a>
				if (apic_div == 0x0b)
    28f6:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 28fd <irq0_worker+0x71>
    28fd:	3c 0b                	cmp    al,0xb
    28ff:	75 0c                	jne    290d <irq0_worker+0x81>
						apic_div = 1;
    2901:	c6 05 00 00 00 00 01 	mov    BYTE PTR [rip+0x0],0x1        # 2908 <irq0_worker+0x7c>
    2908:	e9 bd 00 00 00       	jmp    29ca <irq0_worker+0x13e>
				else {
						/* bits: 3210; 2=R=0, bin: 2-128, 1 */
						uint8_t val = (((apic_div & 0x08) >> 1) | (apic_div & 0x03));
    290d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2914 <irq0_worker+0x88>
    2914:	0f b6 c0             	movzx  eax,al
    2917:	d1 f8                	sar    eax,1
    2919:	83 e0 04             	and    eax,0x4
    291c:	89 c2                	mov    edx,eax
    291e:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2925 <irq0_worker+0x99>
    2925:	83 e0 03             	and    eax,0x3
    2928:	09 d0                	or     eax,edx
    292a:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
						val++;
    292d:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    2931:	83 c0 01             	add    eax,0x1
    2934:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
						apic_div = ((val & 0x04) << 1) | (val & 0x03);
    2937:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    293b:	01 c0                	add    eax,eax
    293d:	83 e0 08             	and    eax,0x8
    2940:	89 c2                	mov    edx,eax
    2942:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    2946:	83 e0 03             	and    eax,0x3
    2949:	09 d0                	or     eax,edx
    294b:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 2951 <irq0_worker+0xc5>
						if (apic_div == 0x0b)
    2951:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2958 <irq0_worker+0xcc>
    2958:	3c 0b                	cmp    al,0xb
    295a:	75 6e                	jne    29ca <irq0_worker+0x13e>
								die("unable to divide high enough!\n");
    295c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2963:	bf 0c 00 00 00       	mov    edi,0xc
    2968:	b8 00 00 00 00       	mov    eax,0x0
    296d:	e8 00 00 00 00       	call   2972 <irq0_worker+0xe6>
    2972:	b8 00 00 00 00       	mov    eax,0x0
    2977:	e8 00 00 00 00       	call   297c <irq0_worker+0xf0>
    297c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2983:	e8 00 00 00 00       	call   2988 <irq0_worker+0xfc>
    2988:	fa                   	cli
    2989:	f4                   	hlt
    298a:	eb fd                	jmp    2989 <irq0_worker+0xfd>
				}
		} else if (n_ct < NCF_AP - 1)
    298c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2992 <irq0_worker+0x106>
    2992:	83 f8 2e             	cmp    eax,0x2e
    2995:	77 11                	ja     29a8 <irq0_worker+0x11c>
				n_ct++;
    2997:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 299d <irq0_worker+0x111>
    299d:	83 c0 01             	add    eax,0x1
    29a0:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 29a6 <irq0_worker+0x11a>
    29a6:	eb 22                	jmp    29ca <irq0_worker+0x13e>
		else {
				/* remove one of the hooks */
				tmr_val = apic_bp_reg(APIC_REG_TMRCURRCNT);
    29a8:	b8 90 03 ff ef       	mov    eax,0xefff0390
    29ad:	8b 00                	mov    eax,DWORD PTR [rax]
    29af:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 29b5 <irq0_worker+0x129>
				irq0_hook = NULL;
    29b5:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 29c0 <irq0_worker+0x134>
				exp = 2;
    29c0:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR [rip+0x0],0x2        # 29ca <irq0_worker+0x13e>
		}
}
    29ca:	c9                   	leave
    29cb:	c3                   	ret

00000000000029cc <apic_timer_setup>:

/* function is already during preemption */
void apic_timer_setup()
{
    29cc:	55                   	push   rbp
    29cd:	48 89 e5             	mov    rbp,rsp
    29d0:	48 83 ec 10          	sub    rsp,0x10
		/* strategy: set a irq0-hook which initializes the apic timer
		 * and reads the count(s) on the next iteration(s). If the
		 * APIC timer expires before completion the divider is increased. */

		/* enable the timer function of the BP */
		printf("calibrating BP APIC timer...\n");
    29d4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29db:	b8 00 00 00 00       	mov    eax,0x0
    29e0:	e8 00 00 00 00       	call   29e5 <apic_timer_setup+0x19>
		/* (val << 16): R00M=one-shot, R01M per, R11M tsc, R=res, M=mask */
		apic_bp_reg(APIC_REG_LVT_TMR) = 0x00000000 | 0x3d; /* one-shot */
    29e5:	b8 20 03 ff ef       	mov    eax,0xefff0320
    29ea:	c7 00 3d 00 00 00    	mov    DWORD PTR [rax],0x3d

		/* now perform the work */
		preempt_disable();
    29f0:	b8 00 00 00 00       	mov    eax,0x0
    29f5:	e8 00 00 00 00       	call   29fa <apic_timer_setup+0x2e>
    29fa:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    29fd:	83 c2 01             	add    edx,0x1
    2a00:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		apic_hook = apic_expire;
    2a03:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 2a0e <apic_timer_setup+0x42>
		irq0_hook = irq0_worker;
    2a0e:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 2a19 <apic_timer_setup+0x4d>

		/* wait for completion */
		while (exp != 2);
    2a19:	90                   	nop
    2a1a:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2a20 <apic_timer_setup+0x54>
    2a20:	83 f8 02             	cmp    eax,0x2
    2a23:	75 f5                	jne    2a1a <apic_timer_setup+0x4e>

		/* disarm the bp timer for now */
		apic_bp_reg(APIC_REG_TMRINITCNT) = 0;
    2a25:	b8 80 03 ff ef       	mov    eax,0xefff0380
    2a2a:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0

		/* remove the apic hook (possible rc? nope; intr preempts this)*/
		apic_hook = NULL;
    2a30:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 2a3b <apic_timer_setup+0x6f>

		/* reenable preemption */
		preempt_enable();
    2a3b:	b8 00 00 00 00       	mov    eax,0x0
    2a40:	e8 00 00 00 00       	call   2a45 <apic_timer_setup+0x79>
    2a45:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    2a48:	83 ea 01             	sub    edx,0x1
    2a4b:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
    2a4e:	b8 00 00 00 00       	mov    eax,0x0
    2a53:	e8 00 00 00 00       	call   2a58 <apic_timer_setup+0x8c>
    2a58:	8b 00                	mov    eax,DWORD PTR [rax]
    2a5a:	83 e0 01             	and    eax,0x1
    2a5d:	85 c0                	test   eax,eax
    2a5f:	74 0a                	je     2a6b <apic_timer_setup+0x9f>
    2a61:	b8 00 00 00 00       	mov    eax,0x0
    2a66:	e8 00 00 00 00       	call   2a6b <apic_timer_setup+0x9f>

		/* calculate the tick values */
		tmr_val = (0xffffffff - tmr_val) / NCF_AP;
    2a6b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2a71 <apic_timer_setup+0xa5>
    2a71:	f7 d0                	not    eax
    2a73:	89 c2                	mov    edx,eax
    2a75:	b8 ab aa aa aa       	mov    eax,0xaaaaaaab
    2a7a:	48 0f af c2          	imul   rax,rdx
    2a7e:	48 c1 e8 20          	shr    rax,0x20
    2a82:	c1 e8 05             	shr    eax,0x5
    2a85:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2a8b <apic_timer_setup+0xbf>
		printf("On average: %08x APIC timer ticks per PIT interrupt.\n", tmr_val);
    2a8b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2a91 <apic_timer_setup+0xc5>
    2a91:	89 c6                	mov    esi,eax
    2a93:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a9a:	b8 00 00 00 00       	mov    eax,0x0
    2a9f:	e8 00 00 00 00       	call   2aa4 <apic_timer_setup+0xd8>
		apic_reload_value = tmr_val;
    2aa4:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2aaa <apic_timer_setup+0xde>
    2aaa:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2ab0 <apic_timer_setup+0xe4>
		{
				uint64_t freq = ((uint64_t)HZ * tmr_val);
    2ab0:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2ab6 <apic_timer_setup+0xea>
    2ab6:	89 c2                	mov    edx,eax
    2ab8:	48 89 d0             	mov    rax,rdx
    2abb:	48 c1 e0 04          	shl    rax,0x4
    2abf:	48 29 d0             	sub    rax,rdx
    2ac2:	48 c1 e0 03          	shl    rax,0x3
    2ac6:	48 01 d0             	add    rax,rdx
    2ac9:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				uint32_t mhz = (uint32_t)(freq / 1000000);
    2acd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2ad1:	48 ba db 34 b6 d7 82 de 1b 43 	movabs rdx,0x431bde82d7b634db
    2adb:	48 f7 e2             	mul    rdx
    2ade:	48 89 d0             	mov    rax,rdx
    2ae1:	48 c1 e8 12          	shr    rax,0x12
    2ae5:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
				uint32_t khz = (uint32_t)(freq % 1000000) / 1000;
    2ae8:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    2aec:	48 ba db 34 b6 d7 82 de 1b 43 	movabs rdx,0x431bde82d7b634db
    2af6:	48 89 c8             	mov    rax,rcx
    2af9:	48 f7 e2             	mul    rdx
    2afc:	48 89 d0             	mov    rax,rdx
    2aff:	48 c1 e8 12          	shr    rax,0x12
    2b03:	48 69 d0 40 42 0f 00 	imul   rdx,rax,0xf4240
    2b0a:	48 89 c8             	mov    rax,rcx
    2b0d:	48 29 d0             	sub    rax,rdx
    2b10:	89 c0                	mov    eax,eax
    2b12:	48 69 c0 d3 4d 62 10 	imul   rax,rax,0x10624dd3
    2b19:	48 c1 e8 20          	shr    rax,0x20
    2b1d:	c1 e8 06             	shr    eax,0x6
    2b20:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				cprintf(KFMT_INFO, "This results in an APIC timer frequency of %u.%03u MHz\n",
    2b23:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    2b26:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    2b29:	89 d1                	mov    ecx,edx
    2b2b:	89 c2                	mov    edx,eax
    2b2d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2b34:	bf 0b 00 00 00       	mov    edi,0xb
    2b39:	b8 00 00 00 00       	mov    eax,0x0
    2b3e:	e8 00 00 00 00       	call   2b43 <apic_timer_setup+0x177>
						mhz, khz);
		}
}
    2b43:	90                   	nop
    2b44:	c9                   	leave
    2b45:	c3                   	ret

0000000000002b46 <timer_setup>:

void timer_setup()
{
    2b46:	55                   	push   rbp
    2b47:	48 89 e5             	mov    rbp,rsp
    2b4a:	48 81 ec a0 00 00 00 	sub    rsp,0xa0
		uint8_t bt; const char* ams[4] = {"latch", "lo", "hi", "lo/hi"};
    2b51:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    2b59:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    2b61:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    2b69:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		uint16_t div; uint64_t tmv;
		const char* oms[8] = {
    2b71:	48 c7 45 90 00 00 00 00 	mov    QWORD PTR [rbp-0x70],0x0
    2b79:	48 c7 45 98 00 00 00 00 	mov    QWORD PTR [rbp-0x68],0x0
    2b81:	48 c7 45 a0 00 00 00 00 	mov    QWORD PTR [rbp-0x60],0x0
    2b89:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
    2b91:	48 c7 45 b0 00 00 00 00 	mov    QWORD PTR [rbp-0x50],0x0
    2b99:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
    2ba1:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
    2ba9:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
				"int on count", "one-shot counter",
				"rate generator", "square wave generator",
				"software strobe", "hardware strobe",
				"rate generator", "square wave generator"
		};
		__asm__("cli");
    2bb1:	fa                   	cli
		km_time = cmos_get_time();
    2bb2:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    2bb9:	48 89 c7             	mov    rdi,rax
    2bbc:	b8 00 00 00 00       	mov    eax,0x0
    2bc1:	e8 00 00 00 00       	call   2bc6 <timer_setup+0x80>
    2bc6:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    2bcd:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
    2bd4:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2bdb <timer_setup+0x95>
    2bdb:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 2be2 <timer_setup+0x9c>
    2be2:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    2be9:	48 8b 95 78 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x88]
    2bf0:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2bf7 <timer_setup+0xb1>
    2bf7:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 2bfe <timer_setup+0xb8>
    2bfe:	8b 45 80             	mov    eax,DWORD PTR [rbp-0x80]
    2c01:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2c07 <timer_setup+0xc1>
		km_set = jiffies; /* should be counter but alas */
    2c07:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2c0e <timer_setup+0xc8>
    2c0e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2c11:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2c18 <timer_setup+0xd2>
		/* get info on the status of the timer */
		outb(PIT1_CTR, 0b11010010); /* latch status of CH0 */
    2c18:	be d2 00 00 00       	mov    esi,0xd2
    2c1d:	bf 43 00 00 00       	mov    edi,0x43
    2c22:	e8 02 d4 ff ff       	call   29 <outb>
		bt = inb(PIT1_CH0);
    2c27:	bf 40 00 00 00       	mov    edi,0x40
    2c2c:	e8 17 d4 ff ff       	call   48 <inb>
    2c31:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
		printf("PIT1_CH0 status is %08b\n", bt);
    2c34:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    2c38:	89 c6                	mov    esi,eax
    2c3a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c41:	b8 00 00 00 00       	mov    eax,0x0
    2c46:	e8 00 00 00 00       	call   2c4b <timer_setup+0x105>
		printf("with access mode: %s\n", ams[(bt >> 4) & 0x03]);
    2c4b:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    2c4f:	c0 e8 04             	shr    al,0x4
    2c52:	0f b6 c0             	movzx  eax,al
    2c55:	83 e0 03             	and    eax,0x3
    2c58:	48 98                	cdqe
    2c5a:	48 8b 44 c5 d0       	mov    rax,QWORD PTR [rbp+rax*8-0x30]
    2c5f:	48 89 c6             	mov    rsi,rax
    2c62:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c69:	b8 00 00 00 00       	mov    eax,0x0
    2c6e:	e8 00 00 00 00       	call   2c73 <timer_setup+0x12d>
		printf("and operating mode: %s\n", oms[(bt >> 1) & 0x07]);
    2c73:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    2c77:	d0 e8                	shr    al,1
    2c79:	0f b6 c0             	movzx  eax,al
    2c7c:	83 e0 07             	and    eax,0x7
    2c7f:	48 98                	cdqe
    2c81:	48 8b 44 c5 90       	mov    rax,QWORD PTR [rbp+rax*8-0x70]
    2c86:	48 89 c6             	mov    rsi,rax
    2c89:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c90:	b8 00 00 00 00       	mov    eax,0x0
    2c95:	e8 00 00 00 00       	call   2c9a <timer_setup+0x154>
		/* change the mode */
		printf("timer will be set to rate generator lo/hi mode\n");
    2c9a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ca1:	b8 00 00 00 00       	mov    eax,0x0
    2ca6:	e8 00 00 00 00       	call   2cab <timer_setup+0x165>
		outb(PIT1_CTR, 0b00110110); /* binary CH0 lohi rategen */
    2cab:	be 36 00 00 00       	mov    esi,0x36
    2cb0:	bf 43 00 00 00       	mov    edi,0x43
    2cb5:	e8 6f d3 ff ff       	call   29 <outb>
		/* and the divisor */
		printf("divisor for HZ=%d: %u\n", HZ, 1193182u / HZ);
    2cba:	ba 85 26 00 00       	mov    edx,0x2685
    2cbf:	be 79 00 00 00       	mov    esi,0x79
    2cc4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ccb:	b8 00 00 00 00       	mov    eax,0x0
    2cd0:	e8 00 00 00 00       	call   2cd5 <timer_setup+0x18f>
		//div = 9861; //11931; //0xffff;
		div = 1193182u / HZ;
    2cd5:	66 c7 45 fc 85 26    	mov    WORD PTR [rbp-0x4],0x2685
		//printf("with a divisor of %u\n", div);
		//printf("resulting in a frequency of ~%u Hz\n", 1193182u / div);
		outb(PIT1_CH0, div & 0xff);
    2cdb:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    2cdf:	0f b6 c0             	movzx  eax,al
    2ce2:	89 c6                	mov    esi,eax
    2ce4:	bf 40 00 00 00       	mov    edi,0x40
    2ce9:	e8 3b d3 ff ff       	call   29 <outb>
		outb(PIT1_CH0, (div >> 8) & 0xff);
    2cee:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    2cf2:	66 c1 e8 08          	shr    ax,0x8
    2cf6:	0f b6 c0             	movzx  eax,al
    2cf9:	89 c6                	mov    esi,eax
    2cfb:	bf 40 00 00 00       	mov    edi,0x40
    2d00:	e8 24 d3 ff ff       	call   29 <outb>
		__asm__("sti");
    2d05:	fb                   	sti
		calibrate_bogo_mips(div);
    2d06:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    2d0a:	89 c7                	mov    edi,eax
    2d0c:	e8 00 00 00 00       	call   2d11 <timer_setup+0x1cb>
		printf("done\n");
    2d11:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2d18:	b8 00 00 00 00       	mov    eax,0x0
    2d1d:	e8 00 00 00 00       	call   2d22 <timer_setup+0x1dc>
		/* testing the resolution */
		printf("delaying execution for 200 ms...\n");
    2d22:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2d29:	b8 00 00 00 00       	mov    eax,0x0
    2d2e:	e8 00 00 00 00       	call   2d33 <timer_setup+0x1ed>
		tmv = jiffies;
    2d33:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2d3a <timer_setup+0x1f4>
    2d3a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2d3d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		mdelay(200);
    2d41:	bf c8 00 00 00       	mov    edi,0xc8
    2d46:	e8 00 00 00 00       	call   2d4b <timer_setup+0x205>
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
				" to %u ms, resulting in a deviation of %+d ms\n",
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
				(int32_t)((jiffies - tmv) * 1000 / HZ) - 200);
    2d4b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2d52 <timer_setup+0x20c>
    2d52:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2d55:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    2d59:	48 69 c8 e8 03 00 00 	imul   rcx,rax,0x3e8
    2d60:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    2d6a:	48 89 c8             	mov    rax,rcx
    2d6d:	48 f7 e2             	mul    rdx
    2d70:	48 89 c8             	mov    rax,rcx
    2d73:	48 29 d0             	sub    rax,rdx
    2d76:	48 d1 e8             	shr    rax,1
    2d79:	48 01 d0             	add    rax,rdx
    2d7c:	48 c1 e8 06          	shr    rax,0x6
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2d80:	8d b0 38 ff ff ff    	lea    esi,[rax-0xc8]
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
    2d86:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2d8d <timer_setup+0x247>
    2d8d:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2d90:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    2d94:	48 69 c8 e8 03 00 00 	imul   rcx,rax,0x3e8
    2d9b:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    2da5:	48 89 c8             	mov    rax,rcx
    2da8:	48 f7 e2             	mul    rdx
    2dab:	48 89 c8             	mov    rax,rcx
    2dae:	48 29 d0             	sub    rax,rdx
    2db1:	48 d1 e8             	shr    rax,1
    2db4:	48 01 d0             	add    rax,rdx
    2db7:	48 c1 e8 06          	shr    rax,0x6
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2dbb:	89 c7                	mov    edi,eax
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
    2dbd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2dc4 <timer_setup+0x27e>
    2dc4:	48 8b 00             	mov    rax,QWORD PTR [rax]
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2dc7:	89 c1                	mov    ecx,eax
    2dc9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2dcd:	89 c2                	mov    edx,eax
    2dcf:	89 c8                	mov    eax,ecx
    2dd1:	29 d0                	sub    eax,edx
    2dd3:	41 89 f1             	mov    r9d,esi
    2dd6:	41 89 f8             	mov    r8d,edi
    2dd9:	b9 79 00 00 00       	mov    ecx,0x79
    2dde:	89 c2                	mov    edx,eax
    2de0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2de7:	bf 0b 00 00 00       	mov    edi,0xb
    2dec:	b8 00 00 00 00       	mov    eax,0x0
    2df1:	e8 00 00 00 00       	call   2df6 <timer_setup+0x2b0>
}
    2df6:	90                   	nop
    2df7:	c9                   	leave
    2df8:	c3                   	ret

0000000000002df9 <apic_tick>:

//uint32_t apic_tick_ct = 0;
void apic_tick()
{
    2df9:	55                   	push   rbp
    2dfa:	48 89 e5             	mov    rbp,rsp
		//apic_tick_ct++;
		//if (apic_tick_ct % (10 * nproc * HZ) == 0)
		//		printf("APIC %08x received timer interrupt (global ct=%u)\n",
		//				apic_reg(APIC_REG_APICID), apic_tick_ct);
		apic_reg(APIC_REG_TMRINITCNT) = apic_reload_value;
    2dfd:	b8 00 00 00 00       	mov    eax,0x0
    2e02:	e8 f9 d1 ff ff       	call   0 <per_cpu_ptr>
    2e07:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2e0b:	48 8d 90 80 03 00 00 	lea    rdx,[rax+0x380]
    2e12:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2e18 <apic_tick+0x1f>
    2e18:	89 02                	mov    DWORD PTR [rdx],eax
		per_cpu_ptr()->ticks->tick++;
    2e1a:	b8 00 00 00 00       	mov    eax,0x0
    2e1f:	e8 dc d1 ff ff       	call   0 <per_cpu_ptr>
    2e24:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2e28:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    2e2b:	48 83 c2 01          	add    rdx,0x1
    2e2f:	48 89 10             	mov    QWORD PTR [rax],rdx
}
    2e32:	90                   	nop
    2e33:	5d                   	pop    rbp
    2e34:	c3                   	ret

0000000000002e35 <apic_ipi>:

void apic_ipi()
{
    2e35:	55                   	push   rbp
    2e36:	48 89 e5             	mov    rbp,rsp
    2e39:	53                   	push   rbx
    2e3a:	48 83 ec 08          	sub    rsp,0x8
		printf("APIC %x (TPR=%x) received IPI\n", apic_reg(APIC_REG_APICID),
				apic_reg(APIC_REG_TASKPRIOR));
    2e3e:	b8 00 00 00 00       	mov    eax,0x0
    2e43:	e8 b8 d1 ff ff       	call   0 <per_cpu_ptr>
    2e48:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2e4c:	48 83 e8 80          	sub    rax,0xffffffffffffff80
		printf("APIC %x (TPR=%x) received IPI\n", apic_reg(APIC_REG_APICID),
    2e50:	8b 18                	mov    ebx,DWORD PTR [rax]
    2e52:	b8 00 00 00 00       	mov    eax,0x0
    2e57:	e8 a4 d1 ff ff       	call   0 <per_cpu_ptr>
    2e5c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2e60:	48 83 c0 20          	add    rax,0x20
    2e64:	8b 00                	mov    eax,DWORD PTR [rax]
    2e66:	89 da                	mov    edx,ebx
    2e68:	89 c6                	mov    esi,eax
    2e6a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e71:	b8 00 00 00 00       	mov    eax,0x0
    2e76:	e8 00 00 00 00       	call   2e7b <apic_ipi+0x46>
		//printf("Current timer value %x\n", apic_reg(APIC_REG_TMRCURRCNT));
}
    2e7b:	90                   	nop
    2e7c:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    2e80:	c9                   	leave
    2e81:	c3                   	ret

0000000000002e82 <ap_entry>:

/* kernel entry point of APs */
extern void ap_entry()
{
    2e82:	55                   	push   rbp
    2e83:	48 89 e5             	mov    rbp,rsp
		void enable_sse();
		enable_sse(); /* avoid hangups form sched. kredraw (using sse) */
    2e86:	b8 00 00 00 00       	mov    eax,0x0
    2e8b:	e8 00 00 00 00       	call   2e90 <ap_entry+0xe>
		/* local APIC init */
		extern void ap_apic_init(); /* PCP works afterwards */
		ap_apic_init();
    2e90:	b8 00 00 00 00       	mov    eax,0x0
    2e95:	e8 00 00 00 00       	call   2e9a <ap_entry+0x18>
		/* prevent death by empty queues */
		extern void kidle(void*);
		/* two per proc for the worst-case */
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2e9a:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2ea1:	ba 03 00 00 00       	mov    edx,0x3
    2ea6:	be 00 00 00 00       	mov    esi,0x0
    2eab:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2eb2:	e8 00 00 00 00       	call   2eb7 <ap_entry+0x35>
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2eb7:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2ebe:	ba 03 00 00 00       	mov    edx,0x3
    2ec3:	be 00 00 00 00       	mov    esi,0x0
    2ec8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ecf:	e8 00 00 00 00       	call   2ed4 <ap_entry+0x52>
		/* signal we don't need the trampoline anymore */
		extern uint8_t ap_start;
		ap_start = 0; /* still unsafe as task_schedule builds a stack frame */
    2ed4:	c6 05 00 00 00 00 00 	mov    BYTE PTR [rip+0x0],0x0        # 2edb <ap_entry+0x59>
		/* TODO: per-cpu tasks & runqueues */
		/* switch to stack of task (sti included in eflags of tasks) */
		extern void task_schedule(struct tsi*);
		task_schedule(NULL);
    2edb:	bf 00 00 00 00       	mov    edi,0x0
    2ee0:	e8 00 00 00 00       	call   2ee5 <ap_entry+0x63>
		/* should never return */
		while (1); /* DBG: busy wait */
    2ee5:	90                   	nop
    2ee6:	eb fd                	jmp    2ee5 <ap_entry+0x63>

0000000000002ee8 <apic_handler>:
 * TSS stacks can also be transferred between processors -> all stacks bound to
 * tasks, i.e. no processor-specific stacks needed.
 */

extern void apic_handler(uint32_t intr)
{
    2ee8:	55                   	push   rbp
    2ee9:	48 89 e5             	mov    rbp,rsp
    2eec:	53                   	push   rbx
    2eed:	48 83 ec 28          	sub    rsp,0x28
    2ef1:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi
		static uint32_t num_spr = 0;
		switch (intr) {
    2ef4:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2ef7:	83 f8 03             	cmp    eax,0x3
    2efa:	0f 84 0c 01 00 00    	je     300c <apic_handler+0x124>
    2f00:	83 f8 03             	cmp    eax,0x3
    2f03:	0f 87 14 01 00 00    	ja     301d <apic_handler+0x135>
    2f09:	83 f8 02             	cmp    eax,0x2
    2f0c:	0f 84 d4 00 00 00    	je     2fe6 <apic_handler+0xfe>
    2f12:	83 f8 02             	cmp    eax,0x2
    2f15:	0f 87 02 01 00 00    	ja     301d <apic_handler+0x135>
    2f1b:	85 c0                	test   eax,eax
    2f1d:	74 0a                	je     2f29 <apic_handler+0x41>
    2f1f:	83 f8 01             	cmp    eax,0x1
    2f22:	74 7d                	je     2fa1 <apic_handler+0xb9>
    2f24:	e9 f4 00 00 00       	jmp    301d <apic_handler+0x135>
			case 0:
				printf("APIC %x received error %08x\n",
					apic_reg(APIC_REG_APICID), apic_reg(APIC_REG_ESR));
    2f29:	b8 00 00 00 00       	mov    eax,0x0
    2f2e:	e8 cd d0 ff ff       	call   0 <per_cpu_ptr>
    2f33:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2f37:	48 05 80 02 00 00    	add    rax,0x280
				printf("APIC %x received error %08x\n",
    2f3d:	8b 18                	mov    ebx,DWORD PTR [rax]
					apic_reg(APIC_REG_APICID), apic_reg(APIC_REG_ESR));
    2f3f:	b8 00 00 00 00       	mov    eax,0x0
    2f44:	e8 b7 d0 ff ff       	call   0 <per_cpu_ptr>
    2f49:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2f4d:	48 83 c0 20          	add    rax,0x20
				printf("APIC %x received error %08x\n",
    2f51:	8b 00                	mov    eax,DWORD PTR [rax]
    2f53:	89 da                	mov    edx,ebx
    2f55:	89 c6                	mov    esi,eax
    2f57:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2f5e:	b8 00 00 00 00       	mov    eax,0x0
    2f63:	e8 00 00 00 00       	call   2f68 <apic_handler+0x80>
				/* rearm the error register */
				apic_reg(APIC_REG_ESR) = 0;
    2f68:	b8 00 00 00 00       	mov    eax,0x0
    2f6d:	e8 8e d0 ff ff       	call   0 <per_cpu_ptr>
    2f72:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2f76:	48 05 80 02 00 00    	add    rax,0x280
    2f7c:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				apic_reg(APIC_REG_EOI) = 0;
    2f82:	b8 00 00 00 00       	mov    eax,0x0
    2f87:	e8 74 d0 ff ff       	call   0 <per_cpu_ptr>
    2f8c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2f90:	48 05 b0 00 00 00    	add    rax,0xb0
    2f96:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				break;
    2f9c:	e9 98 00 00 00       	jmp    3039 <apic_handler+0x151>
			case 1: {
				void (*hook)() = apic_hook;
    2fa1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2fa8 <apic_handler+0xc0>
    2fa8:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (hook)
    2fac:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2fb1:	74 0d                	je     2fc0 <apic_handler+0xd8>
						hook();
    2fb3:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2fb7:	b8 00 00 00 00       	mov    eax,0x0
    2fbc:	ff d2                	call   rdx
    2fbe:	eb 0a                	jmp    2fca <apic_handler+0xe2>
				else
						apic_tick();
    2fc0:	b8 00 00 00 00       	mov    eax,0x0
    2fc5:	e8 00 00 00 00       	call   2fca <apic_handler+0xe2>
				apic_reg(APIC_REG_EOI) = 0;
    2fca:	b8 00 00 00 00       	mov    eax,0x0
    2fcf:	e8 2c d0 ff ff       	call   0 <per_cpu_ptr>
    2fd4:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2fd8:	48 05 b0 00 00 00    	add    rax,0xb0
    2fde:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				break;
    2fe4:	eb 53                	jmp    3039 <apic_handler+0x151>
				}
			case 2:
				apic_ipi();
    2fe6:	b8 00 00 00 00       	mov    eax,0x0
    2feb:	e8 00 00 00 00       	call   2ff0 <apic_handler+0x108>
				apic_reg(APIC_REG_EOI) = 0;
    2ff0:	b8 00 00 00 00       	mov    eax,0x0
    2ff5:	e8 06 d0 ff ff       	call   0 <per_cpu_ptr>
    2ffa:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2ffe:	48 05 b0 00 00 00    	add    rax,0xb0
    3004:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				break;
    300a:	eb 2d                	jmp    3039 <apic_handler+0x151>
			case 3: /* don't ack the spurious interrupt */
				num_spr++;
    300c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3012 <apic_handler+0x12a>
    3012:	83 c0 01             	add    eax,0x1
    3015:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 301b <apic_handler+0x133>
				break;
    301b:	eb 1c                	jmp    3039 <apic_handler+0x151>
			default:
				cprintf(KFMT_WARN, "unknown APIC intr %x received\n", intr);
    301d:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    3020:	89 c2                	mov    edx,eax
    3022:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3029:	bf 0e 00 00 00       	mov    edi,0xe
    302e:	b8 00 00 00 00       	mov    eax,0x0
    3033:	e8 00 00 00 00       	call   3038 <apic_handler+0x150>
				break;
    3038:	90                   	nop
		}
		if (intr == 1) {
    3039:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    303c:	83 f8 01             	cmp    eax,0x1
    303f:	75 13                	jne    3054 <apic_handler+0x16c>
				void task_schedule_isr(void*);
				task_schedule_isr(*(void**)(&intr + 1));
    3041:	48 8d 45 dc          	lea    rax,[rbp-0x24]
    3045:	48 83 c0 04          	add    rax,0x4
    3049:	48 8b 00             	mov    rax,QWORD PTR [rax]
    304c:	48 89 c7             	mov    rdi,rax
    304f:	e8 00 00 00 00       	call   3054 <apic_handler+0x16c>
		}
}
    3054:	90                   	nop
    3055:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    3059:	c9                   	leave
    305a:	c3                   	ret

000000000000305b <fun2>:

static int calc_state = 0, calc_thr = 0, calc_print = 0;

void fun2(uint32_t* f) {
    305b:	55                   	push   rbp
    305c:	48 89 e5             	mov    rbp,rsp
    305f:	48 83 ec 20          	sub    rsp,0x20
    3063:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		while (1) {
				if (!calc_state)
    3067:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 306d <fun2+0x12>
    306d:	85 c0                	test   eax,eax
    306f:	75 0c                	jne    307d <fun2+0x22>
						task_yield();
    3071:	b8 00 00 00 00       	mov    eax,0x0
    3076:	e8 00 00 00 00       	call   307b <fun2+0x20>
    307b:	eb 29                	jmp    30a6 <fun2+0x4b>
				else {
						int v = calc_thr;
    307d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3083 <fun2+0x28>
    3083:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
						if ((v < 1) && __sync_bool_compare_and_swap(&calc_thr, v, v + 1))
    3086:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    308a:	7f 1a                	jg     30a6 <fun2+0x4b>
    308c:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    308f:	83 c0 01             	add    eax,0x1
    3092:	89 c2                	mov    edx,eax
    3094:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    3097:	f0 0f b1 15 00 00 00 00 	lock cmpxchg DWORD PTR [rip+0x0],edx        # 309f <fun2+0x44>
    309f:	0f 94 c0             	sete   al
    30a2:	84 c0                	test   al,al
    30a4:	75 24                	jne    30ca <fun2+0x6f>
								break;
				}
				for (size_t i = 0; i < 0xffffffff; i++);
    30a6:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    30ae:	eb 05                	jmp    30b5 <fun2+0x5a>
    30b0:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    30b5:	b8 fe ff ff ff       	mov    eax,0xfffffffe
    30ba:	48 3b 45 f8          	cmp    rax,QWORD PTR [rbp-0x8]
    30be:	73 f0                	jae    30b0 <fun2+0x55>
				__sync_fetch_and_add(f, 1);
    30c0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    30c4:	f0 83 00 01          	lock add DWORD PTR [rax],0x1
				if (!calc_state)
    30c8:	eb 9d                	jmp    3067 <fun2+0xc>
								break;
    30ca:	90                   	nop
		}
}
    30cb:	90                   	nop
    30cc:	c9                   	leave
    30cd:	c3                   	ret

00000000000030ce <calc_thread>:

void calc_thread(void* data)
{
    30ce:	55                   	push   rbp
    30cf:	48 89 e5             	mov    rbp,rsp
    30d2:	48 83 ec 30          	sub    rsp,0x30
    30d6:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		uint32_t val = 0; uint64_t to = 0; int upd;
    30da:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
    30e1:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		calc_state = 1;
    30e9:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 30f3 <calc_thread+0x25>
		/* test er */
		/* here we do the integer calculations */
		while (1) {
				if (!calc_state)
    30f3:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 30f9 <calc_thread+0x2b>
    30f9:	85 c0                	test   eax,eax
    30fb:	75 0a                	jne    3107 <calc_thread+0x39>
						task_yield();
    30fd:	b8 00 00 00 00       	mov    eax,0x0
    3102:	e8 00 00 00 00       	call   3107 <calc_thread+0x39>
				for (size_t i = 0; i < 0xffffffff; i++);
    3107:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    310f:	eb 05                	jmp    3116 <calc_thread+0x48>
    3111:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    3116:	b8 fe ff ff ff       	mov    eax,0xfffffffe
    311b:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    311f:	73 f0                	jae    3111 <calc_thread+0x43>
				__sync_fetch_and_add(&val, 1);
    3121:	f0 83 45 e8 01       	lock add DWORD PTR [rbp-0x18],0x1
				upd = time_after(jiffies, to);
    3126:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 312d <calc_thread+0x5f>
    312d:	48 8b 00             	mov    rax,QWORD PTR [rax]
    3130:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    3134:	48 29 c2             	sub    rdx,rax
    3137:	48 89 d0             	mov    rax,rdx
    313a:	48 c1 e8 3f          	shr    rax,0x3f
    313e:	0f b6 c0             	movzx  eax,al
    3141:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
				if (calc_print == 1 || (calc_print == 2 && upd)){
    3144:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 314a <calc_thread+0x7c>
    314a:	83 f8 01             	cmp    eax,0x1
    314d:	74 11                	je     3160 <calc_thread+0x92>
    314f:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3155 <calc_thread+0x87>
    3155:	83 f8 02             	cmp    eax,0x2
    3158:	75 77                	jne    31d1 <calc_thread+0x103>
    315a:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    315e:	74 71                	je     31d1 <calc_thread+0x103>
						printf("calculation result: %u\n", val);
    3160:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    3163:	89 c6                	mov    esi,eax
    3165:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    316c:	b8 00 00 00 00       	mov    eax,0x0
    3171:	e8 00 00 00 00       	call   3176 <calc_thread+0xa8>
						if (calc_print == 2)
    3176:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 317c <calc_thread+0xae>
    317c:	83 f8 02             	cmp    eax,0x2
    317f:	75 16                	jne    3197 <calc_thread+0xc9>
								to = jiffies + 5 * HZ; /* print every 5 seconds */
    3181:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3188 <calc_thread+0xba>
    3188:	48 8b 00             	mov    rax,QWORD PTR [rax]
    318b:	48 05 5d 02 00 00    	add    rax,0x25d
    3191:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    3195:	eb 3a                	jmp    31d1 <calc_thread+0x103>
						else
								calc_print = 0; /* print once */
    3197:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 31a1 <calc_thread+0xd3>
				}
				while (calc_thr >= 2) {
    31a1:	eb 2e                	jmp    31d1 <calc_thread+0x103>
						task_spawn(fun2, &val, PRIORITY_REGULAR);
    31a3:	48 8d 45 e8          	lea    rax,[rbp-0x18]
    31a7:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    31ae:	ba 02 00 00 00       	mov    edx,0x2
    31b3:	48 89 c6             	mov    rsi,rax
    31b6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    31bd:	e8 00 00 00 00       	call   31c2 <calc_thread+0xf4>
						calc_thr--;
    31c2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 31c8 <calc_thread+0xfa>
    31c8:	83 e8 01             	sub    eax,0x1
    31cb:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 31d1 <calc_thread+0x103>
				while (calc_thr >= 2) {
    31d1:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 31d7 <calc_thread+0x109>
    31d7:	83 f8 01             	cmp    eax,0x1
    31da:	7f c7                	jg     31a3 <calc_thread+0xd5>
				if (!calc_state)
    31dc:	e9 12 ff ff ff       	jmp    30f3 <calc_thread+0x25>

00000000000031e1 <calc_fun>:
				}
		}
}

void calc_fun(const char* arg)
{
    31e1:	55                   	push   rbp
    31e2:	48 89 e5             	mov    rbp,rsp
    31e5:	48 83 ec 20          	sub    rsp,0x20
    31e9:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int sel = atoi(arg);
    31ed:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    31f1:	48 89 c7             	mov    rdi,rax
    31f4:	e8 00 00 00 00       	call   31f9 <calc_fun+0x18>
    31f9:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		switch (sel) {
    31fc:	83 7d fc 09          	cmp    DWORD PTR [rbp-0x4],0x9
    3200:	77 0d                	ja     320f <calc_fun+0x2e>
    3202:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3205:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    320d:	ff e0                	jmp    rax
			case 0:
			default:
				printf("calc arg: starts/stops and shows the background\n"
    320f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3216:	b8 00 00 00 00       	mov    eax,0x0
    321b:	e8 00 00 00 00       	call   3220 <calc_fun+0x3f>
					   "          5 - add a worker thread\n"
					   "          6 - add 5 worker threads\n"
					   "          7 - add 15 worker threads\n"
					   "          8 - remove a worker thread\n"
					   "          9 - remove 5 worker threads\n");
				break;
    3220:	e9 06 01 00 00       	jmp    332b <calc_fun+0x14a>
			case 1:
				calc_state = 0;
    3225:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 322f <calc_fun+0x4e>
				break;
    322f:	e9 f7 00 00 00       	jmp    332b <calc_fun+0x14a>
			case 2:
				if (!calc_thr) {
    3234:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 323a <calc_fun+0x59>
    323a:	85 c0                	test   eax,eax
    323c:	75 2c                	jne    326a <calc_fun+0x89>
						task_spawn(calc_thread, NULL, PRIORITY_REGULAR);
    323e:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    3245:	ba 02 00 00 00       	mov    edx,0x2
    324a:	be 00 00 00 00       	mov    esi,0x0
    324f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3256:	e8 00 00 00 00       	call   325b <calc_fun+0x7a>
						calc_thr = 1;
    325b:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 3265 <calc_fun+0x84>
						//calc_state = 1;
				} else
						calc_state = 1;
				break;
    3265:	e9 c1 00 00 00       	jmp    332b <calc_fun+0x14a>
						calc_state = 1;
    326a:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 3274 <calc_fun+0x93>
				break;
    3274:	e9 b2 00 00 00       	jmp    332b <calc_fun+0x14a>
			case 3:
				calc_print = 1;
    3279:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 3283 <calc_fun+0xa2>
				break;
    3283:	e9 a3 00 00 00       	jmp    332b <calc_fun+0x14a>
			case 4:
				calc_print = 2;
    3288:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR [rip+0x0],0x2        # 3292 <calc_fun+0xb1>
				break;
    3292:	e9 94 00 00 00       	jmp    332b <calc_fun+0x14a>
			case 5:
				if (calc_thr)
    3297:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 329d <calc_fun+0xbc>
    329d:	85 c0                	test   eax,eax
    329f:	74 7d                	je     331e <calc_fun+0x13d>
						calc_thr++;
    32a1:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 32a7 <calc_fun+0xc6>
    32a7:	83 c0 01             	add    eax,0x1
    32aa:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 32b0 <calc_fun+0xcf>
				break;
    32b0:	eb 6c                	jmp    331e <calc_fun+0x13d>
			case 6:
				if (calc_thr)
    32b2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 32b8 <calc_fun+0xd7>
    32b8:	85 c0                	test   eax,eax
    32ba:	74 65                	je     3321 <calc_fun+0x140>
						calc_thr += 5;
    32bc:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 32c2 <calc_fun+0xe1>
    32c2:	83 c0 05             	add    eax,0x5
    32c5:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 32cb <calc_fun+0xea>
				break;
    32cb:	eb 54                	jmp    3321 <calc_fun+0x140>
			case 7:
				if (calc_thr)
    32cd:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 32d3 <calc_fun+0xf2>
    32d3:	85 c0                	test   eax,eax
    32d5:	74 4d                	je     3324 <calc_fun+0x143>
						calc_thr += 15;
    32d7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 32dd <calc_fun+0xfc>
    32dd:	83 c0 0f             	add    eax,0xf
    32e0:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 32e6 <calc_fun+0x105>
				break;
    32e6:	eb 3c                	jmp    3324 <calc_fun+0x143>
			case 8:
				if (calc_thr)
    32e8:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 32ee <calc_fun+0x10d>
    32ee:	85 c0                	test   eax,eax
    32f0:	74 35                	je     3327 <calc_fun+0x146>
						calc_thr--;
    32f2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 32f8 <calc_fun+0x117>
    32f8:	83 e8 01             	sub    eax,0x1
    32fb:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3301 <calc_fun+0x120>
				break;
    3301:	eb 24                	jmp    3327 <calc_fun+0x146>
			case 9:
				if (calc_thr)
    3303:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3309 <calc_fun+0x128>
    3309:	85 c0                	test   eax,eax
    330b:	74 1d                	je     332a <calc_fun+0x149>
						calc_thr -= 5;
    330d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3313 <calc_fun+0x132>
    3313:	83 e8 05             	sub    eax,0x5
    3316:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 331c <calc_fun+0x13b>
				break;
    331c:	eb 0c                	jmp    332a <calc_fun+0x149>
				break;
    331e:	90                   	nop
    331f:	eb 0a                	jmp    332b <calc_fun+0x14a>
				break;
    3321:	90                   	nop
    3322:	eb 07                	jmp    332b <calc_fun+0x14a>
				break;
    3324:	90                   	nop
    3325:	eb 04                	jmp    332b <calc_fun+0x14a>
				break;
    3327:	90                   	nop
    3328:	eb 01                	jmp    332b <calc_fun+0x14a>
				break;
    332a:	90                   	nop
		}
}
    332b:	90                   	nop
    332c:	c9                   	leave
    332d:	c3                   	ret

000000000000332e <enable_sse>:
		} while ((unsigned int)((double)(counter - now) / CLOCKS_PER_SEC) < seconds);
		return 0;
}*/

void enable_sse()
{
    332e:	55                   	push   rbp
    332f:	48 89 e5             	mov    rbp,rsp
    3332:	53                   	push   rbx
    3333:	48 83 ec 10          	sub    rsp,0x10
		/* enable SSE if present */
		uint32_t eax, ebx, ecx, edx;
		__cpuid(1, eax, ebx, ecx, edx);
    3337:	b8 01 00 00 00       	mov    eax,0x1
    333c:	0f a2                	cpuid
    333e:	89 de                	mov    esi,ebx
    3340:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
    3343:	89 75 f0             	mov    DWORD PTR [rbp-0x10],esi
    3346:	89 4d ec             	mov    DWORD PTR [rbp-0x14],ecx
    3349:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
		if (edx & (1<< 25)) {
    334c:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    334f:	25 00 00 00 02       	and    eax,0x2000000
    3354:	85 c0                	test   eax,eax
    3356:	74 16                	je     336e <enable_sse+0x40>
#ifdef __x86_64__
				asm("mov %%cr0, %%rax\n"
    3358:	0f 20 c0             	mov    rax,cr0
    335b:	48 83 c8 02          	or     rax,0x2
    335f:	24 fb                	and    al,0xfb
    3361:	0f 22 c0             	mov    cr0,rax
    3364:	0f 20 e0             	mov    rax,cr4
    3367:	66 0d 00 06          	or     ax,0x600
    336b:	0f 22 e0             	mov    cr4,rax
					"or $0x00000600, %%eax\n"
					"mov %%eax, %%cr4\n"
					: : : "eax"); /* set oxfxsr osxmmexcpt */
#endif
		}
}
    336e:	90                   	nop
    336f:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    3373:	c9                   	leave
    3374:	c3                   	ret

0000000000003375 <do_cpuid>:

void do_cpuid()
{
    3375:	55                   	push   rbp
    3376:	48 89 e5             	mov    rbp,rsp
    3379:	53                   	push   rbx
    337a:	48 83 ec 20          	sub    rsp,0x20
		uint32_t eax, ebx, ecx, edx;
		cpu.max_leaf = __get_cpuid_max(0, NULL);
    337e:	be 00 00 00 00       	mov    esi,0x0
    3383:	bf 00 00 00 00       	mov    edi,0x0
    3388:	e8 51 cd ff ff       	call   de <__get_cpuid_max>
    338d:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3393 <do_cpuid+0x1e>
		cpu.max_eleaf = __get_cpuid_max(0x80000000, NULL);
    3393:	be 00 00 00 00       	mov    esi,0x0
    3398:	bf 00 00 00 80       	mov    edi,0x80000000
    339d:	e8 3c cd ff ff       	call   de <__get_cpuid_max>
    33a2:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 33a8 <do_cpuid+0x33>
		__cpuid(0, eax, ebx, ecx, edx);
    33a8:	b8 00 00 00 00       	mov    eax,0x0
    33ad:	0f a2                	cpuid
    33af:	89 de                	mov    esi,ebx
    33b1:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    33b4:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    33b7:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    33ba:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
		((int*)cpu.vendor_id)[0] = ebx;
    33bd:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    33c4:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    33c7:	89 02                	mov    DWORD PTR [rdx],eax
		((int*)cpu.vendor_id)[1] = edx;
    33c9:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    33d0:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    33d3:	89 02                	mov    DWORD PTR [rdx],eax
		((int*)cpu.vendor_id)[2] = ecx;
    33d5:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    33dc:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    33df:	89 02                	mov    DWORD PTR [rdx],eax
		((int*)cpu.vendor_id)[3] = 0;
    33e1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    33e8:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		if (cpu.max_leaf > 0) {
    33ee:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 33f4 <do_cpuid+0x7f>
    33f4:	85 c0                	test   eax,eax
    33f6:	74 39                	je     3431 <do_cpuid+0xbc>
				__cpuid(1, eax, ebx, ecx, edx);
    33f8:	b8 01 00 00 00       	mov    eax,0x1
    33fd:	0f a2                	cpuid
    33ff:	89 de                	mov    esi,ebx
    3401:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    3404:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    3407:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    340a:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
				cpu.feat_eax = eax;
    340d:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    3410:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3416 <do_cpuid+0xa1>
				cpu.feat_ecx = ecx;
    3416:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    3419:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 341f <do_cpuid+0xaa>
				cpu.feat_edx = edx;
    341f:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    3422:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3428 <do_cpuid+0xb3>
				cpu.feat_ebx = ebx;
    3428:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    342b:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3431 <do_cpuid+0xbc>
		}
		if (cpu.max_eleaf > 0x80000000) {
    3431:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3437 <do_cpuid+0xc2>
    3437:	3d 00 00 00 80       	cmp    eax,0x80000000
    343c:	76 39                	jbe    3477 <do_cpuid+0x102>
				__cpuid(0x80000001, eax, ebx, ecx, edx);
    343e:	b8 01 00 00 80       	mov    eax,0x80000001
    3443:	0f a2                	cpuid
    3445:	89 de                	mov    esi,ebx
    3447:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    344a:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    344d:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    3450:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
				cpu.efeat_eax = eax;
    3453:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    3456:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 345c <do_cpuid+0xe7>
				cpu.efeat_ebx = ebx;
    345c:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    345f:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3465 <do_cpuid+0xf0>
				cpu.efeat_ecx = ecx;
    3465:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    3468:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 346e <do_cpuid+0xf9>
				cpu.efeat_edx = edx;
    346e:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    3471:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3477 <do_cpuid+0x102>
		}
		cpu.brand_string[0] = '\0';
    3477:	c6 05 00 00 00 00 00 	mov    BYTE PTR [rip+0x0],0x0        # 347e <do_cpuid+0x109>
		if (cpu.max_eleaf > 0x80000003) {
    347e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3484 <do_cpuid+0x10f>
    3484:	3d 03 00 00 80       	cmp    eax,0x80000003
    3489:	76 77                	jbe    3502 <do_cpuid+0x18d>
				/* get the brand string */
				uint32_t* pt = (uint32_t*)cpu.brand_string;
    348b:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				for (uint32_t i = 1; i < 4; i++) {
    3493:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1
    349a:	eb 60                	jmp    34fc <do_cpuid+0x187>
						__cpuid(0x80000001 + i, eax, ebx, ecx, edx);
    349c:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    349f:	2d ff ff ff 7f       	sub    eax,0x7fffffff
    34a4:	0f a2                	cpuid
    34a6:	89 de                	mov    esi,ebx
    34a8:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    34ab:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    34ae:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    34b1:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
						*pt++ = eax;
    34b4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34b8:	48 8d 50 04          	lea    rdx,[rax+0x4]
    34bc:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
    34c0:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    34c3:	89 10                	mov    DWORD PTR [rax],edx
						*pt++ = ebx;
    34c5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34c9:	48 8d 50 04          	lea    rdx,[rax+0x4]
    34cd:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
    34d1:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    34d4:	89 10                	mov    DWORD PTR [rax],edx
						*pt++ = ecx;
    34d6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34da:	48 8d 50 04          	lea    rdx,[rax+0x4]
    34de:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
    34e2:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
    34e5:	89 10                	mov    DWORD PTR [rax],edx
						*pt++ = edx;
    34e7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34eb:	48 8d 50 04          	lea    rdx,[rax+0x4]
    34ef:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
    34f3:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    34f6:	89 10                	mov    DWORD PTR [rax],edx
				for (uint32_t i = 1; i < 4; i++) {
    34f8:	83 45 ec 01          	add    DWORD PTR [rbp-0x14],0x1
    34fc:	83 7d ec 03          	cmp    DWORD PTR [rbp-0x14],0x3
    3500:	76 9a                	jbe    349c <do_cpuid+0x127>
				}
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
    3502:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3508 <do_cpuid+0x193>
    3508:	3d 06 00 00 80       	cmp    eax,0x80000006
    350d:	76 39                	jbe    3548 <do_cpuid+0x1d3>
    350f:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3516 <do_cpuid+0x1a1>
    3516:	83 e0 10             	and    eax,0x10
    3519:	84 c0                	test   al,al
    351b:	74 2b                	je     3548 <do_cpuid+0x1d3>
				/* get invariant tsc */
				__cpuid(0x80000007, eax, ebx, ecx, edx);
    351d:	b8 07 00 00 80       	mov    eax,0x80000007
    3522:	0f a2                	cpuid
    3524:	89 de                	mov    esi,ebx
    3526:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    3529:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    352c:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    352f:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
				cpu.invariant_tsc = !!(edx & (1 << 8));
    3532:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    3535:	25 00 01 00 00       	and    eax,0x100
    353a:	85 c0                	test   eax,eax
    353c:	0f 95 c0             	setne  al
    353f:	0f b6 c0             	movzx  eax,al
    3542:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3548 <do_cpuid+0x1d3>
		}

		/* FIXME: using enable_sse due to framebuffer on x64 */
		enable_sse();
    3548:	b8 00 00 00 00       	mov    eax,0x0
    354d:	e8 00 00 00 00       	call   3552 <do_cpuid+0x1dd>
}
    3552:	90                   	nop
    3553:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    3557:	c9                   	leave
    3558:	c3                   	ret

0000000000003559 <cpu_info>:
void cpu_info()
{
    3559:	55                   	push   rbp
    355a:	48 89 e5             	mov    rbp,rsp
		printf("This cpu is \"%s\" and supports %u cpuid leaves and %u extended cpuid leaves\n",
						cpu.vendor_id, cpu.max_leaf, cpu.max_eleaf - 0x80000000);
    355d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3563 <cpu_info+0xa>
		printf("This cpu is \"%s\" and supports %u cpuid leaves and %u extended cpuid leaves\n",
    3563:	8d 90 00 00 00 80    	lea    edx,[rax-0x80000000]
    3569:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 356f <cpu_info+0x16>
    356f:	89 d1                	mov    ecx,edx
    3571:	89 c2                	mov    edx,eax
    3573:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    357a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3581:	b8 00 00 00 00       	mov    eax,0x0
    3586:	e8 00 00 00 00       	call   358b <cpu_info+0x32>
		/* TODO: DBG! */
		//cpu.has_htt = 1;
		printf("Its main features are:\n");
    358b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3592:	b8 00 00 00 00       	mov    eax,0x0
    3597:	e8 00 00 00 00       	call   359c <cpu_info+0x43>
		if (cpu.has_htt)
    359c:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 35a3 <cpu_info+0x4a>
    35a3:	83 e0 10             	and    eax,0x10
    35a6:	84 c0                	test   al,al
    35a8:	74 11                	je     35bb <cpu_info+0x62>
				printf("\tHyper-threading\n");
    35aa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35b1:	b8 00 00 00 00       	mov    eax,0x0
    35b6:	e8 00 00 00 00       	call   35bb <cpu_info+0x62>
		if (cpu.has_pae)
    35bb:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 35c2 <cpu_info+0x69>
    35c2:	83 e0 40             	and    eax,0x40
    35c5:	84 c0                	test   al,al
    35c7:	74 11                	je     35da <cpu_info+0x81>
				printf("\tPAE\n");
    35c9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35d0:	b8 00 00 00 00       	mov    eax,0x0
    35d5:	e8 00 00 00 00       	call   35da <cpu_info+0x81>
		if (cpu.has_apic)
    35da:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 35e1 <cpu_info+0x88>
    35e1:	83 e0 02             	and    eax,0x2
    35e4:	84 c0                	test   al,al
    35e6:	74 11                	je     35f9 <cpu_info+0xa0>
				printf("\tAPIC\n");
    35e8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35ef:	b8 00 00 00 00       	mov    eax,0x0
    35f4:	e8 00 00 00 00       	call   35f9 <cpu_info+0xa0>
		if (cpu.has_acpi)
    35f9:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3600 <cpu_info+0xa7>
    3600:	83 e0 40             	and    eax,0x40
    3603:	84 c0                	test   al,al
    3605:	74 11                	je     3618 <cpu_info+0xbf>
				printf("\tACPI\n");
    3607:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    360e:	b8 00 00 00 00       	mov    eax,0x0
    3613:	e8 00 00 00 00       	call   3618 <cpu_info+0xbf>
		printf("All features are:\n");
    3618:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    361f:	b8 00 00 00 00       	mov    eax,0x0
    3624:	e8 00 00 00 00       	call   3629 <cpu_info+0xd0>
		printf("33222222222211111111110000000000\n");
    3629:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3630:	b8 00 00 00 00       	mov    eax,0x0
    3635:	e8 00 00 00 00       	call   363a <cpu_info+0xe1>
		printf("10987654321098765432109876543210\n");
    363a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3641:	b8 00 00 00 00       	mov    eax,0x0
    3646:	e8 00 00 00 00       	call   364b <cpu_info+0xf2>
		printf("%032b\n", cpu.feat_eax);
    364b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3651 <cpu_info+0xf8>
    3651:	89 c6                	mov    esi,eax
    3653:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    365a:	b8 00 00 00 00       	mov    eax,0x0
    365f:	e8 00 00 00 00       	call   3664 <cpu_info+0x10b>
		printf("%032b\n", cpu.feat_ebx);
    3664:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 366a <cpu_info+0x111>
    366a:	89 c6                	mov    esi,eax
    366c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3673:	b8 00 00 00 00       	mov    eax,0x0
    3678:	e8 00 00 00 00       	call   367d <cpu_info+0x124>
		printf("%032b\n", cpu.feat_ecx);
    367d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3683 <cpu_info+0x12a>
    3683:	89 c6                	mov    esi,eax
    3685:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    368c:	b8 00 00 00 00       	mov    eax,0x0
    3691:	e8 00 00 00 00       	call   3696 <cpu_info+0x13d>
		printf("%032b\n", cpu.feat_edx);
    3696:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 369c <cpu_info+0x143>
    369c:	89 c6                	mov    esi,eax
    369e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36a5:	b8 00 00 00 00       	mov    eax,0x0
    36aa:	e8 00 00 00 00       	call   36af <cpu_info+0x156>
		if (cpu.max_eleaf > 0x80000000) {
    36af:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 36b5 <cpu_info+0x15c>
    36b5:	3d 00 00 00 80       	cmp    eax,0x80000000
    36ba:	0f 86 02 01 00 00    	jbe    37c2 <cpu_info+0x269>
				printf("The main extended features are:\n");
    36c0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36c7:	b8 00 00 00 00       	mov    eax,0x0
    36cc:	e8 00 00 00 00       	call   36d1 <cpu_info+0x178>
				if (cpu.e_pat)
    36d1:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 36d8 <cpu_info+0x17f>
    36d8:	83 e0 01             	and    eax,0x1
    36db:	84 c0                	test   al,al
    36dd:	74 11                	je     36f0 <cpu_info+0x197>
						printf("\tPAT\n");
    36df:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36e6:	b8 00 00 00 00       	mov    eax,0x0
    36eb:	e8 00 00 00 00       	call   36f0 <cpu_info+0x197>
				if (cpu.e_has_mp)
    36f0:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 36f7 <cpu_info+0x19e>
    36f7:	83 e0 08             	and    eax,0x8
    36fa:	84 c0                	test   al,al
    36fc:	74 11                	je     370f <cpu_info+0x1b6>
						printf("\tMP capable\n");
    36fe:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3705:	b8 00 00 00 00       	mov    eax,0x0
    370a:	e8 00 00 00 00       	call   370f <cpu_info+0x1b6>
				if (cpu.e_has_nx)
    370f:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3716 <cpu_info+0x1bd>
    3716:	83 e0 10             	and    eax,0x10
    3719:	84 c0                	test   al,al
    371b:	74 11                	je     372e <cpu_info+0x1d5>
						printf("\tNX bit\n");
    371d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3724:	b8 00 00 00 00       	mov    eax,0x0
    3729:	e8 00 00 00 00       	call   372e <cpu_info+0x1d5>
				if (cpu.e_has_longmode)
    372e:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3735 <cpu_info+0x1dc>
    3735:	83 e0 20             	and    eax,0x20
    3738:	84 c0                	test   al,al
    373a:	74 11                	je     374d <cpu_info+0x1f4>
						printf("\tx86_64\n");
    373c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3743:	b8 00 00 00 00       	mov    eax,0x0
    3748:	e8 00 00 00 00       	call   374d <cpu_info+0x1f4>
				printf("All extended features:\n");
    374d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3754:	b8 00 00 00 00       	mov    eax,0x0
    3759:	e8 00 00 00 00       	call   375e <cpu_info+0x205>
				printf("%032b\n", cpu.efeat_eax);
    375e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3764 <cpu_info+0x20b>
    3764:	89 c6                	mov    esi,eax
    3766:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    376d:	b8 00 00 00 00       	mov    eax,0x0
    3772:	e8 00 00 00 00       	call   3777 <cpu_info+0x21e>
				printf("%032b\n", cpu.efeat_ebx);
    3777:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 377d <cpu_info+0x224>
    377d:	89 c6                	mov    esi,eax
    377f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3786:	b8 00 00 00 00       	mov    eax,0x0
    378b:	e8 00 00 00 00       	call   3790 <cpu_info+0x237>
				printf("%032b\n", cpu.efeat_ecx);
    3790:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3796 <cpu_info+0x23d>
    3796:	89 c6                	mov    esi,eax
    3798:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    379f:	b8 00 00 00 00       	mov    eax,0x0
    37a4:	e8 00 00 00 00       	call   37a9 <cpu_info+0x250>
				printf("%032b\n", cpu.efeat_edx);
    37a9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 37af <cpu_info+0x256>
    37af:	89 c6                	mov    esi,eax
    37b1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    37b8:	b8 00 00 00 00       	mov    eax,0x0
    37bd:	e8 00 00 00 00       	call   37c2 <cpu_info+0x269>
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
    37c2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 37c8 <cpu_info+0x26f>
    37c8:	3d 06 00 00 80       	cmp    eax,0x80000006
    37cd:	76 3c                	jbe    380b <cpu_info+0x2b2>
    37cf:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 37d6 <cpu_info+0x27d>
    37d6:	83 e0 10             	and    eax,0x10
    37d9:	84 c0                	test   al,al
    37db:	74 2e                	je     380b <cpu_info+0x2b2>
				printf("The CPU's TSC is %s rate\n", cpu.invariant_tsc ? "constant" : "variable");
    37dd:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 37e3 <cpu_info+0x28a>
    37e3:	85 c0                	test   eax,eax
    37e5:	74 09                	je     37f0 <cpu_info+0x297>
    37e7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    37ee:	eb 07                	jmp    37f7 <cpu_info+0x29e>
    37f0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    37f7:	48 89 c6             	mov    rsi,rax
    37fa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3801:	b8 00 00 00 00       	mov    eax,0x0
    3806:	e8 00 00 00 00       	call   380b <cpu_info+0x2b2>
		}
		printf("The brand string is \"%s\"\n", cpu.brand_string);
    380b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3812:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3819:	b8 00 00 00 00       	mov    eax,0x0
    381e:	e8 00 00 00 00       	call   3823 <cpu_info+0x2ca>
}
    3823:	90                   	nop
    3824:	5d                   	pop    rbp
    3825:	c3                   	ret

0000000000003826 <_start>:

extern void _start()
{
    3826:	55                   	push   rbp
    3827:	48 89 e5             	mov    rbp,rsp
		extern int fb_no_malloc;
		/* set cpu to correct values */
		do_cpuid();
    382a:	b8 00 00 00 00       	mov    eax,0x0
    382f:	e8 00 00 00 00       	call   3834 <_start+0xe>

		/* transfer the frambuffer mappings */
		void fb_video_setup();
		fb_no_malloc = 1;
    3834:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 383e <_start+0x18>
		fb_video_setup();
    383e:	b8 00 00 00 00       	mov    eax,0x0
    3843:	e8 00 00 00 00       	call   3848 <_start+0x22>

		/* transfer mmgr data from known locations */
		extern void mmgr_reinit();
		mmgr_reinit();
    3848:	b8 00 00 00 00       	mov    eax,0x0
    384d:	e8 00 00 00 00       	call   3852 <_start+0x2c>
		fb_no_malloc = 0;
    3852:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 385c <_start+0x36>

		/* use the correct GDT */
		extern void gdt_init();
		gdt_init();
    385c:	b8 00 00 00 00       	mov    eax,0x0
    3861:	e8 00 00 00 00       	call   3866 <_start+0x40>

		/* do the IDT setup & remap PIC */
		extern void mm_idt_init();
		mm_idt_init();
    3866:	b8 00 00 00 00       	mov    eax,0x0
    386b:	e8 00 00 00 00       	call   3870 <_start+0x4a>
		PIC_remap(0x20, 0x28);
    3870:	be 28 00 00 00       	mov    esi,0x28
    3875:	bf 20 00 00 00       	mov    edi,0x20
    387a:	e8 00 00 00 00       	call   387f <_start+0x59>
		asm("sti");
    387f:	fb                   	sti

		/* protect null pointer */
		mm_unmap(&mm_kernel, NULL, 1);
    3880:	ba 01 00 00 00       	mov    edx,0x1
    3885:	be 00 00 00 00       	mov    esi,0x0
    388a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3891:	e8 00 00 00 00       	call   3896 <_start+0x70>

		/* print cpu info */
		cpu_info();
    3896:	b8 00 00 00 00       	mov    eax,0x0
    389b:	e8 00 00 00 00       	call   38a0 <_start+0x7a>
		/* timekeeping setup */
		timer_setup();
    38a0:	b8 00 00 00 00       	mov    eax,0x0
    38a5:	e8 00 00 00 00       	call   38aa <_start+0x84>
		/* enable preemption (needed for MP init stacks) */
		/* enable preemption (calls kinit and never returns) */
		printf("starting preemption...\n");
    38aa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    38b1:	b8 00 00 00 00       	mov    eax,0x0
    38b6:	e8 00 00 00 00       	call   38bb <_start+0x95>
		void preempt_init();
		preempt_init();
    38bb:	b8 00 00 00 00       	mov    eax,0x0
    38c0:	e8 00 00 00 00       	call   38c5 <_start+0x9f>

		cprintf(KFMT_ERROR, "preempt_init returned\n");
    38c5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    38cc:	bf 0c 00 00 00       	mov    edi,0xc
    38d1:	b8 00 00 00 00       	mov    eax,0x0
    38d6:	e8 00 00 00 00       	call   38db <_start+0xb5>
		while (1);
    38db:	90                   	nop
    38dc:	eb fd                	jmp    38db <_start+0xb5>

00000000000038de <kinit>:
}

void kinit(void* data)
{
    38de:	55                   	push   rbp
    38df:	48 89 e5             	mov    rbp,rsp
    38e2:	48 83 ec 40          	sub    rsp,0x40
    38e6:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
		cprintf(KFMT_OK, "kernel is now preemptive\n");
    38ea:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    38f1:	bf 0a 00 00 00       	mov    edi,0xa
    38f6:	b8 00 00 00 00       	mov    eax,0x0
    38fb:	e8 00 00 00 00       	call   3900 <kinit+0x22>
		/* APIC and MP init */
		if (cpu.has_apic) {
    3900:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3907 <kinit+0x29>
    3907:	83 e0 02             	and    eax,0x2
    390a:	84 c0                	test   al,al
    390c:	74 0a                	je     3918 <kinit+0x3a>
				extern void apic_init(); /* PCP works afterwards */
				apic_init();
    390e:	b8 00 00 00 00       	mov    eax,0x0
    3913:	e8 00 00 00 00       	call   3918 <kinit+0x3a>
		}
		region_clear(&km_regS);
    3918:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    391f:	b8 00 00 00 00       	mov    eax,0x0
    3924:	e8 00 00 00 00       	call   3929 <kinit+0x4b>
		km_regS.cur_x = km_regS.cur_y = 0;
    3929:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 3932 <kinit+0x54>
    3932:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3939 <kinit+0x5b>
    3939:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 3940 <kinit+0x62>
		region_puts(&km_regS, "total used  hp free\n\nup: ");
    3940:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3947:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    394e:	e8 00 00 00 00       	call   3953 <kinit+0x75>
		/* Hardware detection and initialization */
		kbd_init();
    3953:	b8 00 00 00 00       	mov    eax,0x0
    3958:	e8 00 00 00 00       	call   395d <kinit+0x7f>
		{
				char bt;
				printf("VGA IO base port (from 0x0463): %x\n", *(uint16_t*)(0x463));
    395d:	b8 63 04 00 00       	mov    eax,0x463
    3962:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3965:	0f b7 c0             	movzx  eax,ax
    3968:	89 c6                	mov    esi,eax
    396a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3971:	b8 00 00 00 00       	mov    eax,0x0
    3976:	e8 00 00 00 00       	call   397b <kinit+0x9d>
				bt = inb(0x3cc);
    397b:	bf cc 03 00 00       	mov    edi,0x3cc
    3980:	e8 c3 c6 ff ff       	call   48 <inb>
    3985:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al
				printf("VGA misc flags: %08b\n", bt);
    3988:	0f be 45 ef          	movsx  eax,BYTE PTR [rbp-0x11]
    398c:	89 c6                	mov    esi,eax
    398e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3995:	b8 00 00 00 00       	mov    eax,0x0
    399a:	e8 00 00 00 00       	call   399f <kinit+0xc1>
/*				sleep(0);
				}*/
		}
		/* List the serial and printer ports */
		{
				uint16_t* ptr = (uint16_t*)0x400; int i;
    399f:	48 c7 45 e0 00 04 00 00 	mov    QWORD PTR [rbp-0x20],0x400
				for (i = 0; i < 7; i++)
    39a7:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    39ae:	e9 c0 00 00 00       	jmp    3a73 <kinit+0x195>
						if (ptr[i])
    39b3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    39b6:	48 98                	cdqe
    39b8:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    39bc:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    39c0:	48 01 d0             	add    rax,rdx
    39c3:	0f b7 00             	movzx  eax,WORD PTR [rax]
    39c6:	66 85 c0             	test   ax,ax
    39c9:	74 6a                	je     3a35 <kinit+0x157>
								if (i < 4) {
    39cb:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
    39cf:	7f 3d                	jg     3a0e <kinit+0x130>
										printf("COM%d IO port: %u\n", i + 1, *ptr);
    39d1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    39d5:	0f b7 00             	movzx  eax,WORD PTR [rax]
    39d8:	0f b7 c0             	movzx  eax,ax
    39db:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    39de:	8d 4a 01             	lea    ecx,[rdx+0x1]
    39e1:	89 c2                	mov    edx,eax
    39e3:	89 ce                	mov    esi,ecx
    39e5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    39ec:	b8 00 00 00 00       	mov    eax,0x0
    39f1:	e8 00 00 00 00       	call   39f6 <kinit+0x118>
										enable_com(i, *ptr);
    39f6:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    39fa:	0f b7 00             	movzx  eax,WORD PTR [rax]
    39fd:	0f b7 d0             	movzx  edx,ax
    3a00:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3a03:	89 d6                	mov    esi,edx
    3a05:	89 c7                	mov    edi,eax
    3a07:	e8 00 00 00 00       	call   3a0c <kinit+0x12e>
    3a0c:	eb 61                	jmp    3a6f <kinit+0x191>
								} else
										printf("LPT%d IO port: %u\n", i - 3, *ptr);
    3a0e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3a12:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3a15:	0f b7 c0             	movzx  eax,ax
    3a18:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    3a1b:	8d 4a fd             	lea    ecx,[rdx-0x3]
    3a1e:	89 c2                	mov    edx,eax
    3a20:	89 ce                	mov    esi,ecx
    3a22:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3a29:	b8 00 00 00 00       	mov    eax,0x0
    3a2e:	e8 00 00 00 00       	call   3a33 <kinit+0x155>
    3a33:	eb 3a                	jmp    3a6f <kinit+0x191>
						else
								if (i < 4)
    3a35:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
    3a39:	7f 1b                	jg     3a56 <kinit+0x178>
										printf("COM%d not present\n", i + 1);
    3a3b:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3a3e:	83 c0 01             	add    eax,0x1
    3a41:	89 c6                	mov    esi,eax
    3a43:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3a4a:	b8 00 00 00 00       	mov    eax,0x0
    3a4f:	e8 00 00 00 00       	call   3a54 <kinit+0x176>
    3a54:	eb 19                	jmp    3a6f <kinit+0x191>
								else
										printf("LPT%d not present\n", i - 3);
    3a56:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3a59:	83 e8 03             	sub    eax,0x3
    3a5c:	89 c6                	mov    esi,eax
    3a5e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3a65:	b8 00 00 00 00       	mov    eax,0x0
    3a6a:	e8 00 00 00 00       	call   3a6f <kinit+0x191>
				for (i = 0; i < 7; i++)
    3a6f:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    3a73:	83 7d fc 06          	cmp    DWORD PTR [rbp-0x4],0x6
    3a77:	0f 8e 36 ff ff ff    	jle    39b3 <kinit+0xd5>
		}
		/* Floppy devices */
		{
				uint8_t bt = cmos_get_register(0x10);
    3a7d:	bf 10 00 00 00       	mov    edi,0x10
    3a82:	e8 00 00 00 00       	call   3a87 <kinit+0x1a9>
    3a87:	88 45 df             	mov    BYTE PTR [rbp-0x21],al
				uint8_t btM = (bt & 0xf0) >> 4;
    3a8a:	0f b6 45 df          	movzx  eax,BYTE PTR [rbp-0x21]
    3a8e:	c0 e8 04             	shr    al,0x4
    3a91:	88 45 fb             	mov    BYTE PTR [rbp-0x5],al
				bt &= 0x0f;
    3a94:	80 65 df 0f          	and    BYTE PTR [rbp-0x21],0xf
				do {
						const char* drv;
						switch (btM != 0xff ? btM : bt) {
    3a98:	80 7d fb ff          	cmp    BYTE PTR [rbp-0x5],0xff
    3a9c:	74 06                	je     3aa4 <kinit+0x1c6>
    3a9e:	0f b6 45 fb          	movzx  eax,BYTE PTR [rbp-0x5]
    3aa2:	eb 04                	jmp    3aa8 <kinit+0x1ca>
    3aa4:	0f b6 45 df          	movzx  eax,BYTE PTR [rbp-0x21]
    3aa8:	83 f8 05             	cmp    eax,0x5
    3aab:	77 48                	ja     3af5 <kinit+0x217>
    3aad:	89 c0                	mov    eax,eax
    3aaf:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    3ab7:	ff e0                	jmp    rax
								case 0:
										drv = "no drive";
    3ab9:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3ac1:	eb 3b                	jmp    3afe <kinit+0x220>
								case 1:
										drv = "360KiB 5.25\" drive";
    3ac3:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3acb:	eb 31                	jmp    3afe <kinit+0x220>
								case 2:
										drv = "1.2MiB 5.25\" drive";
    3acd:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3ad5:	eb 27                	jmp    3afe <kinit+0x220>
								case 3:
										drv = "720KiB 3.5\" drive";
    3ad7:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3adf:	eb 1d                	jmp    3afe <kinit+0x220>
								case 4:
										drv = "1.44MiB 3.5\" drive";
    3ae1:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3ae9:	eb 13                	jmp    3afe <kinit+0x220>
								case 5:
										drv = "2.88MiB 3.5\" drive";
    3aeb:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3af3:	eb 09                	jmp    3afe <kinit+0x220>
								default:
										drv = "unknown";
    3af5:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3afd:	90                   	nop
						}
						printf("Floppy %s: %s\n", btM != 0xff ? "master" : "slave", drv);
    3afe:	80 7d fb ff          	cmp    BYTE PTR [rbp-0x5],0xff
    3b02:	74 09                	je     3b0d <kinit+0x22f>
    3b04:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    3b0b:	eb 07                	jmp    3b14 <kinit+0x236>
    3b0d:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    3b14:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3b18:	48 89 c2             	mov    rdx,rax
    3b1b:	48 89 ce             	mov    rsi,rcx
    3b1e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3b25:	b8 00 00 00 00       	mov    eax,0x0
    3b2a:	e8 00 00 00 00       	call   3b2f <kinit+0x251>
						if (btM == 0xff)
    3b2f:	80 7d fb ff          	cmp    BYTE PTR [rbp-0x5],0xff
    3b33:	74 09                	je     3b3e <kinit+0x260>
								break;
						btM = 0xff;
    3b35:	c6 45 fb ff          	mov    BYTE PTR [rbp-0x5],0xff
				do {
    3b39:	e9 5a ff ff ff       	jmp    3a98 <kinit+0x1ba>
								break;
    3b3e:	90                   	nop
		}

		/* PCI enumeration */
		void load_modules();
		void fun();
		fun();
    3b3f:	b8 00 00 00 00       	mov    eax,0x0
    3b44:	e8 00 00 00 00       	call   3b49 <kinit+0x26b>
		load_modules();
    3b49:	b8 00 00 00 00       	mov    eax,0x0
    3b4e:	e8 00 00 00 00       	call   3b53 <kinit+0x275>

		/* now go to the loop */
		void kloop();
		kloop();
    3b53:	b8 00 00 00 00       	mov    eax,0x0
    3b58:	e8 00 00 00 00       	call   3b5d <kinit+0x27f>
}
    3b5d:	90                   	nop
    3b5e:	c9                   	leave
    3b5f:	c3                   	ret

0000000000003b60 <kscrub>:

/* performs scrubbing of pages at low priority */
void kscrub(void* data)
{
    3b60:	55                   	push   rbp
    3b61:	48 89 e5             	mov    rbp,rsp
    3b64:	48 83 ec 10          	sub    rsp,0x10
    3b68:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		while (1) {/* need_resched is checked periodically inside */
				extern struct wait_queue_head wq_timer;
				if (!mm_page_scrub())
    3b6c:	b8 00 00 00 00       	mov    eax,0x0
    3b71:	e8 00 00 00 00       	call   3b76 <kscrub+0x16>
    3b76:	85 c0                	test   eax,eax
    3b78:	75 f2                	jne    3b6c <kscrub+0xc>
						wait_timeout(&wq_timer, HZ);
    3b7a:	be 79 00 00 00       	mov    esi,0x79
    3b7f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3b86:	e8 00 00 00 00       	call   3b8b <kscrub+0x2b>
		while (1) {/* need_resched is checked periodically inside */
    3b8b:	eb df                	jmp    3b6c <kscrub+0xc>

0000000000003b8d <kloop>:
		}
}

void kloop()
{
    3b8d:	55                   	push   rbp
    3b8e:	48 89 e5             	mov    rbp,rsp
    3b91:	48 81 ec 80 01 00 00 	sub    rsp,0x180
		/* file_cli */
		int (*fptr)(const char*) = locate_module_function("file_cli");
    3b98:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3b9f:	e8 00 00 00 00       	call   3ba4 <kloop+0x17>
    3ba4:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		void list_modules();
		void list_module_info(const char*);

		/* main loop */
		while (1) {
				char* str = 0; size_t n = 0;
    3ba8:	48 c7 45 a0 00 00 00 00 	mov    QWORD PTR [rbp-0x60],0x0
    3bb0:	48 c7 45 98 00 00 00 00 	mov    QWORD PTR [rbp-0x68],0x0
				printf("enter text:\n");
    3bb8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3bbf:	b8 00 00 00 00       	mov    eax,0x0
    3bc4:	e8 00 00 00 00       	call   3bc9 <kloop+0x3c>
				getline(&str, &n);
    3bc9:	48 8d 55 98          	lea    rdx,[rbp-0x68]
    3bcd:	48 8d 45 a0          	lea    rax,[rbp-0x60]
    3bd1:	48 89 d6             	mov    rsi,rdx
    3bd4:	48 89 c7             	mov    rdi,rax
    3bd7:	e8 00 00 00 00       	call   3bdc <kloop+0x4f>
				if (str) {
    3bdc:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3be0:	48 85 c0             	test   rax,rax
    3be3:	74 c3                	je     3ba8 <kloop+0x1b>
						char* s2 = str;
    3be5:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3be9:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						while (*s2++);
    3bed:	90                   	nop
    3bee:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3bf2:	48 8d 50 01          	lea    rdx,[rax+0x1]
    3bf6:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
    3bfa:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3bfd:	84 c0                	test   al,al
    3bff:	75 ed                	jne    3bee <kloop+0x61>
						if (s2 - 2 >= str)
    3c01:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3c05:	48 8d 50 fe          	lea    rdx,[rax-0x2]
    3c09:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c0d:	48 39 c2             	cmp    rdx,rax
    3c10:	72 0b                	jb     3c1d <kloop+0x90>
								*(s2 - 2) = '\0';
    3c12:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3c16:	48 83 e8 02          	sub    rax,0x2
    3c1a:	c6 00 00             	mov    BYTE PTR [rax],0x0
						if (strcmp(str, "pt") == 0) {
    3c1d:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c21:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3c28:	48 89 c7             	mov    rdi,rax
    3c2b:	e8 00 00 00 00       	call   3c30 <kloop+0xa3>
    3c30:	85 c0                	test   eax,eax
    3c32:	75 0f                	jne    3c43 <kloop+0xb6>
								/* print tasks */
								void print_tasks();
								print_tasks();
    3c34:	b8 00 00 00 00       	mov    eax,0x0
    3c39:	e8 00 00 00 00       	call   3c3e <kloop+0xb1>
    3c3e:	e9 f3 07 00 00       	jmp    4436 <kloop+0x8a9>
						} else if (strncmp(str, "calc", 4) == 0) {
    3c43:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c47:	ba 04 00 00 00       	mov    edx,0x4
    3c4c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3c53:	48 89 c7             	mov    rdi,rax
    3c56:	e8 00 00 00 00       	call   3c5b <kloop+0xce>
    3c5b:	85 c0                	test   eax,eax
    3c5d:	75 15                	jne    3c74 <kloop+0xe7>
								/* start/stop show the calculations */
								calc_fun(str + 5);
    3c5f:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c63:	48 83 c0 05          	add    rax,0x5
    3c67:	48 89 c7             	mov    rdi,rax
    3c6a:	e8 00 00 00 00       	call   3c6f <kloop+0xe2>
    3c6f:	e9 c2 07 00 00       	jmp    4436 <kloop+0x8a9>
						} else if (strcmp(str, "rds") == 0) {
    3c74:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c78:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3c7f:	48 89 c7             	mov    rdi,rax
    3c82:	e8 00 00 00 00       	call   3c87 <kloop+0xfa>
    3c87:	85 c0                	test   eax,eax
    3c89:	0f 85 1d 01 00 00    	jne    3dac <kloop+0x21f>
								//framebuffer_redraw(&fb_initial);
								printf("%d %d\n", video_mode.width, video_mode.height);
    3c8f:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3c95 <kloop+0x108>
    3c95:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3c9b <kloop+0x10e>
    3c9b:	89 c6                	mov    esi,eax
    3c9d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3ca4:	b8 00 00 00 00       	mov    eax,0x0
    3ca9:	e8 00 00 00 00       	call   3cae <kloop+0x121>
								printf("%d %d\n", fb_initial.cho_x, fb_initial.cho_y);
    3cae:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3cb4 <kloop+0x127>
    3cb4:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3cba <kloop+0x12d>
    3cba:	89 c6                	mov    esi,eax
    3cbc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3cc3:	b8 00 00 00 00       	mov    eax,0x0
    3cc8:	e8 00 00 00 00       	call   3ccd <kloop+0x140>
								printf("%d %d\n", fb_initial.chw_x, fb_initial.chw_y);
    3ccd:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3cd3 <kloop+0x146>
    3cd3:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3cd9 <kloop+0x14c>
    3cd9:	89 c6                	mov    esi,eax
    3cdb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3ce2:	b8 00 00 00 00       	mov    eax,0x0
    3ce7:	e8 00 00 00 00       	call   3cec <kloop+0x15f>
								printf("%d %d\n", fb_initial.width, fb_initial.height);
    3cec:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3cf2 <kloop+0x165>
    3cf2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3cf8 <kloop+0x16b>
    3cf8:	89 c6                	mov    esi,eax
    3cfa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3d01:	b8 00 00 00 00       	mov    eax,0x0
    3d06:	e8 00 00 00 00       	call   3d0b <kloop+0x17e>
								printf("regions:\n");
    3d0b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3d12:	b8 00 00 00 00       	mov    eax,0x0
    3d17:	e8 00 00 00 00       	call   3d1c <kloop+0x18f>
								printf("km_regC: %d %d %d %d\n", km_regC.x, km_regC.y, km_regC.lx, km_regC.ly);
    3d1c:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d23 <kloop+0x196>
    3d23:	0f bf f0             	movsx  esi,ax
    3d26:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d2d <kloop+0x1a0>
    3d2d:	0f bf c8             	movsx  ecx,ax
    3d30:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d37 <kloop+0x1aa>
    3d37:	0f bf d0             	movsx  edx,ax
    3d3a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d41 <kloop+0x1b4>
    3d41:	98                   	cwde
    3d42:	41 89 f0             	mov    r8d,esi
    3d45:	89 c6                	mov    esi,eax
    3d47:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3d4e:	b8 00 00 00 00       	mov    eax,0x0
    3d53:	e8 00 00 00 00       	call   3d58 <kloop+0x1cb>
								printf("km_regS: %d %d %d %d\n", km_regS.x, km_regS.y, km_regS.lx, km_regS.ly);
    3d58:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d5f <kloop+0x1d2>
    3d5f:	0f bf f0             	movsx  esi,ax
    3d62:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d69 <kloop+0x1dc>
    3d69:	0f bf c8             	movsx  ecx,ax
    3d6c:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d73 <kloop+0x1e6>
    3d73:	0f bf d0             	movsx  edx,ax
    3d76:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d7d <kloop+0x1f0>
    3d7d:	98                   	cwde
    3d7e:	41 89 f0             	mov    r8d,esi
    3d81:	89 c6                	mov    esi,eax
    3d83:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3d8a:	b8 00 00 00 00       	mov    eax,0x0
    3d8f:	e8 00 00 00 00       	call   3d94 <kloop+0x207>
								framebuffer_update_region(&fb_initial, &km_regC);
    3d94:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3d9b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3da2:	e8 00 00 00 00       	call   3da7 <kloop+0x21a>
    3da7:	e9 8a 06 00 00       	jmp    4436 <kloop+0x8a9>
						} else if (strcmp(str, "time") == 0) {
    3dac:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3db0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3db7:	48 89 c7             	mov    rdi,rax
    3dba:	e8 00 00 00 00       	call   3dbf <kloop+0x232>
    3dbf:	85 c0                	test   eax,eax
    3dc1:	0f 85 ae 01 00 00    	jne    3f75 <kloop+0x3e8>
								struct timespec tsp; struct tm* ts = &km_time;
    3dc7:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
								km_time = cmos_get_time();
    3dcf:	48 8d 85 80 fe ff ff 	lea    rax,[rbp-0x180]
    3dd6:	48 89 c7             	mov    rdi,rax
    3dd9:	b8 00 00 00 00       	mov    eax,0x0
    3dde:	e8 00 00 00 00       	call   3de3 <kloop+0x256>
    3de3:	48 8b 85 80 fe ff ff 	mov    rax,QWORD PTR [rbp-0x180]
    3dea:	48 8b 95 88 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x178]
    3df1:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3df8 <kloop+0x26b>
    3df8:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 3dff <kloop+0x272>
    3dff:	48 8b 85 90 fe ff ff 	mov    rax,QWORD PTR [rbp-0x170]
    3e06:	48 8b 95 98 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x168]
    3e0d:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3e14 <kloop+0x287>
    3e14:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 3e1b <kloop+0x28e>
    3e1b:	8b 85 a0 fe ff ff    	mov    eax,DWORD PTR [rbp-0x160]
    3e21:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3e27 <kloop+0x29a>
								km_set = jiffies;
    3e27:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3e2e <kloop+0x2a1>
    3e2e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    3e31:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3e38 <kloop+0x2ab>
								printf("upadting time from CMOS\n");
    3e38:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3e3f:	b8 00 00 00 00       	mov    eax,0x0
    3e44:	e8 00 00 00 00       	call   3e49 <kloop+0x2bc>
								clock_gettime(CLOCK_REALTIME, &tsp);
    3e49:	48 8d 45 80          	lea    rax,[rbp-0x80]
    3e4d:	48 89 c6             	mov    rsi,rax
    3e50:	bf 00 00 00 00       	mov    edi,0x0
    3e55:	e8 00 00 00 00       	call   3e5a <kloop+0x2cd>
								printf("UNIX time: %llu.%lu\n", tsp.tv_sec, tsp.tv_nsec);
    3e5a:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    3e5e:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    3e62:	48 89 c6             	mov    rsi,rax
    3e65:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3e6c:	b8 00 00 00 00       	mov    eax,0x0
    3e71:	e8 00 00 00 00       	call   3e76 <kloop+0x2e9>
								printf("struct tm:\n");
    3e76:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3e7d:	b8 00 00 00 00       	mov    eax,0x0
    3e82:	e8 00 00 00 00       	call   3e87 <kloop+0x2fa>
								printf("tm_sec %d\n", ts->tm_sec);
    3e87:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3e8b:	8b 00                	mov    eax,DWORD PTR [rax]
    3e8d:	89 c6                	mov    esi,eax
    3e8f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3e96:	b8 00 00 00 00       	mov    eax,0x0
    3e9b:	e8 00 00 00 00       	call   3ea0 <kloop+0x313>
								printf("tm_min %d\n", ts->tm_min);
    3ea0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3ea4:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    3ea7:	89 c6                	mov    esi,eax
    3ea9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3eb0:	b8 00 00 00 00       	mov    eax,0x0
    3eb5:	e8 00 00 00 00       	call   3eba <kloop+0x32d>
								printf("tm_hour %d\n", ts->tm_hour);
    3eba:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3ebe:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    3ec1:	89 c6                	mov    esi,eax
    3ec3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3eca:	b8 00 00 00 00       	mov    eax,0x0
    3ecf:	e8 00 00 00 00       	call   3ed4 <kloop+0x347>
								printf("tm_mday %d\n", ts->tm_mday);
    3ed4:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3ed8:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    3edb:	89 c6                	mov    esi,eax
    3edd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3ee4:	b8 00 00 00 00       	mov    eax,0x0
    3ee9:	e8 00 00 00 00       	call   3eee <kloop+0x361>
								printf("tm_mon %d\n", ts->tm_mon);
    3eee:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3ef2:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    3ef5:	89 c6                	mov    esi,eax
    3ef7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3efe:	b8 00 00 00 00       	mov    eax,0x0
    3f03:	e8 00 00 00 00       	call   3f08 <kloop+0x37b>
								printf("tm_year %d\n", ts->tm_year);
    3f08:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3f0c:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    3f0f:	89 c6                	mov    esi,eax
    3f11:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f18:	b8 00 00 00 00       	mov    eax,0x0
    3f1d:	e8 00 00 00 00       	call   3f22 <kloop+0x395>
								printf("tm_wday %d\n", ts->tm_wday);
    3f22:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3f26:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    3f29:	89 c6                	mov    esi,eax
    3f2b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f32:	b8 00 00 00 00       	mov    eax,0x0
    3f37:	e8 00 00 00 00       	call   3f3c <kloop+0x3af>
								printf("tm_yday %d\n", ts->tm_yday);
    3f3c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3f40:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    3f43:	89 c6                	mov    esi,eax
    3f45:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f4c:	b8 00 00 00 00       	mov    eax,0x0
    3f51:	e8 00 00 00 00       	call   3f56 <kloop+0x3c9>
								printf("tm_isdst %d\n", ts->tm_isdst);
    3f56:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3f5a:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3f5d:	89 c6                	mov    esi,eax
    3f5f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f66:	b8 00 00 00 00       	mov    eax,0x0
    3f6b:	e8 00 00 00 00       	call   3f70 <kloop+0x3e3>
    3f70:	e9 c1 04 00 00       	jmp    4436 <kloop+0x8a9>
						} else if(strcmp(str, "trhp") == 0) {
    3f75:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3f79:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3f80:	48 89 c7             	mov    rdi,rax
    3f83:	e8 00 00 00 00       	call   3f88 <kloop+0x3fb>
    3f88:	85 c0                	test   eax,eax
    3f8a:	75 6e                	jne    3ffa <kloop+0x46d>
								unsigned int bval = 0xff;
    3f8c:	c7 45 f4 ff 00 00 00 	mov    DWORD PTR [rbp-0xc],0xff
								printf("trashing kernel heap\n");
    3f93:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f9a:	b8 00 00 00 00       	mov    eax,0x0
    3f9f:	e8 00 00 00 00       	call   3fa4 <kloop+0x417>
								/* glibc rand */
								while (1) {
										printf("allocating %u bytes ...\n", (bval & 0xffff));
    3fa4:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    3fa7:	0f b7 c0             	movzx  eax,ax
    3faa:	89 c6                	mov    esi,eax
    3fac:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3fb3:	b8 00 00 00 00       	mov    eax,0x0
    3fb8:	e8 00 00 00 00       	call   3fbd <kloop+0x430>
										printf("located at %p\n", kmalloc(bval & 0xffff));
    3fbd:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    3fc0:	0f b7 c0             	movzx  eax,ax
    3fc3:	48 89 c7             	mov    rdi,rax
    3fc6:	e8 00 00 00 00       	call   3fcb <kloop+0x43e>
    3fcb:	48 89 c6             	mov    rsi,rax
    3fce:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3fd5:	b8 00 00 00 00       	mov    eax,0x0
    3fda:	e8 00 00 00 00       	call   3fdf <kloop+0x452>
										bval = (uint32_t)((1103515245*(uint64_t)bval+12345) % 0x80000000);
    3fdf:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    3fe2:	48 69 c0 6d 4e c6 41 	imul   rax,rax,0x41c64e6d
    3fe9:	48 05 39 30 00 00    	add    rax,0x3039
    3fef:	25 ff ff ff 7f       	and    eax,0x7fffffff
    3ff4:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
										printf("allocating %u bytes ...\n", (bval & 0xffff));
    3ff7:	90                   	nop
    3ff8:	eb aa                	jmp    3fa4 <kloop+0x417>
								}
						} else if (fptr && fptr(str)) {
    3ffa:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    3fff:	74 15                	je     4016 <kloop+0x489>
    4001:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4005:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    4009:	48 89 c7             	mov    rdi,rax
    400c:	ff d2                	call   rdx
    400e:	85 c0                	test   eax,eax
    4010:	0f 85 20 04 00 00    	jne    4436 <kloop+0x8a9>
								/* do nothing -> fptr() does it */
						} else if (strcmp(str, "lsmod") == 0)
    4016:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    401a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4021:	48 89 c7             	mov    rdi,rax
    4024:	e8 00 00 00 00       	call   4029 <kloop+0x49c>
    4029:	85 c0                	test   eax,eax
    402b:	75 0f                	jne    403c <kloop+0x4af>
								list_modules();
    402d:	b8 00 00 00 00       	mov    eax,0x0
    4032:	e8 00 00 00 00       	call   4037 <kloop+0x4aa>
    4037:	e9 fa 03 00 00       	jmp    4436 <kloop+0x8a9>
						else if (strncmp(str, "modinfo ", 7) == 0) {
    403c:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4040:	ba 07 00 00 00       	mov    edx,0x7
    4045:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    404c:	48 89 c7             	mov    rdi,rax
    404f:	e8 00 00 00 00       	call   4054 <kloop+0x4c7>
    4054:	85 c0                	test   eax,eax
    4056:	75 1d                	jne    4075 <kloop+0x4e8>
								str += 8;
    4058:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    405c:	48 83 c0 08          	add    rax,0x8
    4060:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
								list_module_info(str);
    4064:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4068:	48 89 c7             	mov    rdi,rax
    406b:	e8 00 00 00 00       	call   4070 <kloop+0x4e3>
    4070:	e9 c1 03 00 00       	jmp    4436 <kloop+0x8a9>
						} else if (strcmp(str, "com") == 0) {
    4075:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4079:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4080:	48 89 c7             	mov    rdi,rax
    4083:	e8 00 00 00 00       	call   4088 <kloop+0x4fb>
    4088:	85 c0                	test   eax,eax
    408a:	75 0f                	jne    409b <kloop+0x50e>
								com_status();
    408c:	b8 00 00 00 00       	mov    eax,0x0
    4091:	e8 00 00 00 00       	call   4096 <kloop+0x509>
    4096:	e9 9b 03 00 00       	jmp    4436 <kloop+0x8a9>
						} else if (strcmp(str, "brk") == 0) {
    409b:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    409f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    40a6:	48 89 c7             	mov    rdi,rax
    40a9:	e8 00 00 00 00       	call   40ae <kloop+0x521>
    40ae:	85 c0                	test   eax,eax
    40b0:	0f 84 80 03 00 00    	je     4436 <kloop+0x8a9>
								//breakpoint(); TODO reimpl.
						} else if (strncmp(str, "pma", 3) == 0) {
    40b6:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    40ba:	ba 03 00 00 00       	mov    edx,0x3
    40bf:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    40c6:	48 89 c7             	mov    rdi,rax
    40c9:	e8 00 00 00 00       	call   40ce <kloop+0x541>
    40ce:	85 c0                	test   eax,eax
    40d0:	0f 85 ff 00 00 00    	jne    41d5 <kloop+0x648>
								int val;
								/* allocate pmem */
								val = atoi(str + 3);
    40d6:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    40da:	48 83 c0 03          	add    rax,0x3
    40de:	48 89 c7             	mov    rdi,rax
    40e1:	e8 00 00 00 00       	call   40e6 <kloop+0x559>
    40e6:	89 45 b0             	mov    DWORD PTR [rbp-0x50],eax
								if (val) {
    40e9:	83 7d b0 00          	cmp    DWORD PTR [rbp-0x50],0x0
    40ed:	0f 84 43 03 00 00    	je     4436 <kloop+0x8a9>
										struct page_range pr[10]; size_t rv;
										printf("allocating %d physical pages...\n", val);
    40f3:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
    40f6:	89 c6                	mov    esi,eax
    40f8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    40ff:	b8 00 00 00 00       	mov    eax,0x0
    4104:	e8 00 00 00 00       	call   4109 <kloop+0x57c>
										rv = mm_alloc_pm(pr, 10, val);
    4109:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
    410c:	48 8d 95 b0 fe ff ff 	lea    rdx,[rbp-0x150]
    4113:	89 d1                	mov    ecx,edx
    4115:	89 c2                	mov    edx,eax
    4117:	be 0a 00 00 00       	mov    esi,0xa
    411c:	89 cf                	mov    edi,ecx
    411e:	e8 00 00 00 00       	call   4123 <kloop+0x596>
    4123:	89 c0                	mov    eax,eax
    4125:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
										printf("%u pages allocated\n", rv);
    4129:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    412d:	48 89 c6             	mov    rsi,rax
    4130:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4137:	b8 00 00 00 00       	mov    eax,0x0
    413c:	e8 00 00 00 00       	call   4141 <kloop+0x5b4>
										for (rv = 0; rv < 10; rv++)
    4141:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    4149:	eb 7a                	jmp    41c5 <kloop+0x638>
												if (!pr[rv].count)
    414b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    414f:	48 c1 e0 04          	shl    rax,0x4
    4153:	48 01 e8             	add    rax,rbp
    4156:	48 2d 48 01 00 00    	sub    rax,0x148
    415c:	48 8b 00             	mov    rax,QWORD PTR [rax]
    415f:	48 85 c0             	test   rax,rax
    4162:	0f 84 cd 02 00 00    	je     4435 <kloop+0x8a8>
														break;
												else
														printf("%u pages at %#08x%08x\n",
																	   pr[rv].count,
																	   (uint32_t)(pr[rv].base >> 32),
																	   (uint32_t)pr[rv].base);
    4168:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    416c:	48 c1 e0 04          	shl    rax,0x4
    4170:	48 01 e8             	add    rax,rbp
    4173:	48 2d 50 01 00 00    	sub    rax,0x150
    4179:	48 8b 00             	mov    rax,QWORD PTR [rax]
														printf("%u pages at %#08x%08x\n",
    417c:	89 c1                	mov    ecx,eax
																	   (uint32_t)(pr[rv].base >> 32),
    417e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4182:	48 c1 e0 04          	shl    rax,0x4
    4186:	48 01 e8             	add    rax,rbp
    4189:	48 2d 50 01 00 00    	sub    rax,0x150
    418f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    4192:	48 c1 e8 20          	shr    rax,0x20
														printf("%u pages at %#08x%08x\n",
    4196:	89 c2                	mov    edx,eax
    4198:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    419c:	48 c1 e0 04          	shl    rax,0x4
    41a0:	48 01 e8             	add    rax,rbp
    41a3:	48 2d 48 01 00 00    	sub    rax,0x148
    41a9:	48 8b 00             	mov    rax,QWORD PTR [rax]
    41ac:	48 89 c6             	mov    rsi,rax
    41af:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    41b6:	b8 00 00 00 00       	mov    eax,0x0
    41bb:	e8 00 00 00 00       	call   41c0 <kloop+0x633>
										for (rv = 0; rv < 10; rv++)
    41c0:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    41c5:	48 83 7d e8 09       	cmp    QWORD PTR [rbp-0x18],0x9
    41ca:	0f 86 7b ff ff ff    	jbe    414b <kloop+0x5be>
    41d0:	e9 61 02 00 00       	jmp    4436 <kloop+0x8a9>
								}
						} else if (strncmp(str, "pmf", 3) == 0) {
    41d5:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    41d9:	ba 03 00 00 00       	mov    edx,0x3
    41de:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    41e5:	48 89 c7             	mov    rdi,rax
    41e8:	e8 00 00 00 00       	call   41ed <kloop+0x660>
    41ed:	85 c0                	test   eax,eax
    41ef:	0f 85 9c 00 00 00    	jne    4291 <kloop+0x704>
								long int val; char* ep;
								val = strtol(str + 3, &ep, 0);
    41f5:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    41f9:	48 8d 48 03          	lea    rcx,[rax+0x3]
    41fd:	48 8d 85 78 ff ff ff 	lea    rax,[rbp-0x88]
    4204:	ba 00 00 00 00       	mov    edx,0x0
    4209:	48 89 c6             	mov    rsi,rax
    420c:	48 89 cf             	mov    rdi,rcx
    420f:	e8 00 00 00 00       	call   4214 <kloop+0x687>
    4214:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
								if (val) {
    4218:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    421d:	0f 84 13 02 00 00    	je     4436 <kloop+0x8a9>
										int ct = atoi(ep);
    4223:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    422a:	48 89 c7             	mov    rdi,rax
    422d:	e8 00 00 00 00       	call   4232 <kloop+0x6a5>
    4232:	89 45 b4             	mov    DWORD PTR [rbp-0x4c],eax
										if (ct) {
    4235:	83 7d b4 00          	cmp    DWORD PTR [rbp-0x4c],0x0
    4239:	0f 84 f7 01 00 00    	je     4436 <kloop+0x8a9>
												struct page_range pr;
												pr.base = val;
    423f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    4243:	48 89 85 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rax
												pr.count = ct;
    424a:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    424d:	48 98                	cdqe
    424f:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
												printf("freeing %d physical pages at 0x%016llx\n",
    4256:	48 8b 95 60 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xa0]
    425d:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    4264:	48 89 c6             	mov    rsi,rax
    4267:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    426e:	b8 00 00 00 00       	mov    eax,0x0
    4273:	e8 00 00 00 00       	call   4278 <kloop+0x6eb>
																pr.count, pr.base);
												mm_free_pm(&pr, 1);
    4278:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    427f:	be 01 00 00 00       	mov    esi,0x1
    4284:	48 89 c7             	mov    rdi,rax
    4287:	e8 00 00 00 00       	call   428c <kloop+0x6ff>
    428c:	e9 a5 01 00 00       	jmp    4436 <kloop+0x8a9>
										}
								}
						} else if (strncmp(str, "pmu", 3) == 0) {
    4291:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4295:	ba 03 00 00 00       	mov    edx,0x3
    429a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    42a1:	48 89 c7             	mov    rdi,rax
    42a4:	e8 00 00 00 00       	call   42a9 <kloop+0x71c>
    42a9:	85 c0                	test   eax,eax
    42ab:	75 7e                	jne    432b <kloop+0x79e>
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
    42ad:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    42b1:	48 8d 48 03          	lea    rcx,[rax+0x3]
    42b5:	48 8d 85 58 ff ff ff 	lea    rax,[rbp-0xa8]
    42bc:	ba 00 00 00 00       	mov    edx,0x0
    42c1:	48 89 c6             	mov    rsi,rax
    42c4:	48 89 cf             	mov    rdi,rcx
    42c7:	e8 00 00 00 00       	call   42cc <kloop+0x73f>
    42cc:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
								if (val) {
    42d0:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    42d5:	74 3b                	je     4312 <kloop+0x785>
										int ct = atoi(ep);
    42d7:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    42de:	48 89 c7             	mov    rdi,rax
    42e1:	e8 00 00 00 00       	call   42e6 <kloop+0x759>
    42e6:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
										if (ct)
    42e9:	83 7d c4 00          	cmp    DWORD PTR [rbp-0x3c],0x0
    42ed:	0f 84 43 01 00 00    	je     4436 <kloop+0x8a9>
												mm_dump_pmu(val, ct, 0);
    42f3:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    42f6:	48 63 c8             	movsxd rcx,eax
    42f9:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    42fd:	ba 00 00 00 00       	mov    edx,0x0
    4302:	48 89 ce             	mov    rsi,rcx
    4305:	48 89 c7             	mov    rdi,rax
    4308:	e8 00 00 00 00       	call   430d <kloop+0x780>
    430d:	e9 24 01 00 00       	jmp    4436 <kloop+0x8a9>
								} else
										mm_dump_pmu(0, 0, 2);
    4312:	ba 02 00 00 00       	mov    edx,0x2
    4317:	be 00 00 00 00       	mov    esi,0x0
    431c:	bf 00 00 00 00       	mov    edi,0x0
    4321:	e8 00 00 00 00       	call   4326 <kloop+0x799>
    4326:	e9 0b 01 00 00       	jmp    4436 <kloop+0x8a9>
						} else if (strncmp(str, "rcp", 3) == 0) {
    432b:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    432f:	ba 03 00 00 00       	mov    edx,0x3
    4334:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    433b:	48 89 c7             	mov    rdi,rax
    433e:	e8 00 00 00 00       	call   4343 <kloop+0x7b6>
    4343:	85 c0                	test   eax,eax
    4345:	75 7b                	jne    43c2 <kloop+0x835>
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
    4347:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    434b:	48 8d 48 03          	lea    rcx,[rax+0x3]
    434f:	48 8d 85 50 ff ff ff 	lea    rax,[rbp-0xb0]
    4356:	ba 00 00 00 00       	mov    edx,0x0
    435b:	48 89 c6             	mov    rsi,rax
    435e:	48 89 cf             	mov    rdi,rcx
    4361:	e8 00 00 00 00       	call   4366 <kloop+0x7d9>
    4366:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
								if (val) {
    436a:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    436f:	74 3b                	je     43ac <kloop+0x81f>
										int ct = atoi(ep);
    4371:	48 8b 85 50 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb0]
    4378:	48 89 c7             	mov    rdi,rax
    437b:	e8 00 00 00 00       	call   4380 <kloop+0x7f3>
    4380:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
										if (ct)
    4383:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    4387:	0f 84 a9 00 00 00    	je     4436 <kloop+0x8a9>
												mm_dump_pmu(val, ct, 1);
    438d:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    4390:	48 63 c8             	movsxd rcx,eax
    4393:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    4397:	ba 01 00 00 00       	mov    edx,0x1
    439c:	48 89 ce             	mov    rsi,rcx
    439f:	48 89 c7             	mov    rdi,rax
    43a2:	e8 00 00 00 00       	call   43a7 <kloop+0x81a>
    43a7:	e9 8a 00 00 00       	jmp    4436 <kloop+0x8a9>
								} else
										mm_dump_pmu(0, 0, 2);
    43ac:	ba 02 00 00 00       	mov    edx,0x2
    43b1:	be 00 00 00 00       	mov    esi,0x0
    43b6:	bf 00 00 00 00       	mov    edi,0x0
    43bb:	e8 00 00 00 00       	call   43c0 <kloop+0x833>
    43c0:	eb 74                	jmp    4436 <kloop+0x8a9>
						} else if (strcmp(str, "reboot") == 0)
    43c2:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    43c6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    43cd:	48 89 c7             	mov    rdi,rax
    43d0:	e8 00 00 00 00       	call   43d5 <kloop+0x848>
    43d5:	85 c0                	test   eax,eax
    43d7:	75 0a                	jne    43e3 <kloop+0x856>
								pc_reset();
    43d9:	b8 00 00 00 00       	mov    eax,0x0
    43de:	e8 00 00 00 00       	call   43e3 <kloop+0x856>
						else if (strcmp(str, "quit") == 0 || strcmp(str, "halt") == 0)
    43e3:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    43e7:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    43ee:	48 89 c7             	mov    rdi,rax
    43f1:	e8 00 00 00 00       	call   43f6 <kloop+0x869>
    43f6:	85 c0                	test   eax,eax
    43f8:	74 17                	je     4411 <kloop+0x884>
    43fa:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    43fe:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4405:	48 89 c7             	mov    rdi,rax
    4408:	e8 00 00 00 00       	call   440d <kloop+0x880>
    440d:	85 c0                	test   eax,eax
    440f:	75 0a                	jne    441b <kloop+0x88e>
								pc_shutdown();
    4411:	b8 00 00 00 00       	mov    eax,0x0
    4416:	e8 00 00 00 00       	call   441b <kloop+0x88e>
						else
								printf("Command \"%s\" read from keyboard is unrecognized\n", str);
    441b:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    441f:	48 89 c6             	mov    rsi,rax
    4422:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4429:	b8 00 00 00 00       	mov    eax,0x0
    442e:	e8 00 00 00 00       	call   4433 <kloop+0x8a6>
    4433:	eb 01                	jmp    4436 <kloop+0x8a9>
														break;
    4435:	90                   	nop
						kfree(str);
    4436:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    443a:	48 89 c7             	mov    rdi,rax
    443d:	e8 00 00 00 00       	call   4442 <kloop+0x8b5>
		while (1) {
    4442:	e9 61 f7 ff ff       	jmp    3ba8 <kloop+0x1b>

0000000000004447 <ringbuffer_allocate>:
		char data[];
};

/* ringbuffer functions*/
void* ringbuffer_allocate(size_t init_cap)
{
    4447:	55                   	push   rbp
    4448:	48 89 e5             	mov    rbp,rsp
    444b:	48 83 ec 30          	sub    rsp,0x30
    444f:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		void** rvR, *rv;
		rvR = (void**)kmalloc(sizeof(void*));
    4453:	bf 08 00 00 00       	mov    edi,0x8
    4458:	e8 00 00 00 00       	call   445d <ringbuffer_allocate+0x16>
    445d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!rvR)
    4461:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    4466:	75 07                	jne    446f <ringbuffer_allocate+0x28>
				return 0;
    4468:	b8 00 00 00 00       	mov    eax,0x0
    446d:	eb 78                	jmp    44e7 <ringbuffer_allocate+0xa0>
		if ((rv = kmalloc(init_cap + sizeof(struct ringbuffer)))) {
    446f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    4473:	48 83 c0 20          	add    rax,0x20
    4477:	48 89 c7             	mov    rdi,rax
    447a:	e8 00 00 00 00       	call   447f <ringbuffer_allocate+0x38>
    447f:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    4483:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    4488:	74 4c                	je     44d6 <ringbuffer_allocate+0x8f>
				struct ringbuffer* rbf = (struct ringbuffer*)rv;
    448a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    448e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				rbf->cap = init_cap;
    4492:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4496:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    449a:	48 89 10             	mov    QWORD PTR [rax],rdx
				rbf->ofs_start = 0;
    449d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    44a1:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
				rbf->ofs_end = 0;
    44a9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    44ad:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
				spin_lock_init(&rbf->lock);
    44b5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    44b9:	48 83 c0 18          	add    rax,0x18
    44bd:	48 89 c7             	mov    rdi,rax
    44c0:	e8 00 00 00 00       	call   44c5 <ringbuffer_allocate+0x7e>
				*rvR = rv;
    44c5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    44c9:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    44cd:	48 89 10             	mov    QWORD PTR [rax],rdx
				return (void*)rvR;
    44d0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    44d4:	eb 11                	jmp    44e7 <ringbuffer_allocate+0xa0>
		} else
				kfree(rvR);
    44d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    44da:	48 89 c7             	mov    rdi,rax
    44dd:	e8 00 00 00 00       	call   44e2 <ringbuffer_allocate+0x9b>
		return 0;
    44e2:	b8 00 00 00 00       	mov    eax,0x0
}
    44e7:	c9                   	leave
    44e8:	c3                   	ret

00000000000044e9 <ringbuffer_enqueue>:

void ringbuffer_enqueue(void* rbi, const void* dat, size_t s)
{
    44e9:	55                   	push   rbp
    44ea:	48 89 e5             	mov    rbp,rsp
    44ed:	48 83 ec 50          	sub    rsp,0x50
    44f1:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    44f5:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
    44f9:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    44fd:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    4501:	48 8b 00             	mov    rax,QWORD PTR [rax]
    4504:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
	//	spin_lock(&rb->lock);
		const char* data = (const char*)dat;
    4508:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    450c:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		size_t cap = rb->cap;
    4510:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4514:	48 8b 00             	mov    rax,QWORD PTR [rax]
    4517:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (rb->ofs_end > rb->ofs_start)
    451b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    451f:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    4523:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    4527:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    452b:	48 39 c2             	cmp    rdx,rax
    452e:	73 19                	jae    4549 <ringbuffer_enqueue+0x60>
				cap -= rb->ofs_end - rb->ofs_start;
    4530:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4534:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    4538:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    453c:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    4540:	48 29 c2             	sub    rdx,rax
    4543:	48 01 55 e8          	add    QWORD PTR [rbp-0x18],rdx
    4547:	eb 2c                	jmp    4575 <ringbuffer_enqueue+0x8c>
		else
				cap -= rb->cap - rb->ofs_start + rb->ofs_end + 1;
    4549:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    454d:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    4550:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4554:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    4558:	48 29 c2             	sub    rdx,rax
    455b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    455f:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    4563:	48 01 d0             	add    rax,rdx
    4566:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    456a:	48 29 c2             	sub    rdx,rax
    456d:	48 8d 42 ff          	lea    rax,[rdx-0x1]
    4571:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (cap < s) {
    4575:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4579:	48 3b 45 b8          	cmp    rax,QWORD PTR [rbp-0x48]
    457d:	0f 83 16 01 00 00    	jae    4699 <ringbuffer_enqueue+0x1b0>
				void* nrb;
				/* allocate new buffer and shuffle data */
				size_t nc = rb->cap + max(rb->cap, 4 * s + 1);
    4583:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4587:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    458a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    458e:	48 c1 e0 02          	shl    rax,0x2
    4592:	48 8d 50 01          	lea    rdx,[rax+0x1]
    4596:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    459a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    459d:	48 39 c2             	cmp    rdx,rax
    45a0:	48 0f 43 c2          	cmovae rax,rdx
    45a4:	48 01 c8             	add    rax,rcx
    45a7:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if ((nrb = krealloc(rb, nc + sizeof(struct ringbuffer)))) {
    45ab:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    45af:	48 8d 50 20          	lea    rdx,[rax+0x20]
    45b3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    45b7:	48 89 d6             	mov    rsi,rdx
    45ba:	48 89 c7             	mov    rdi,rax
    45bd:	e8 00 00 00 00       	call   45c2 <ringbuffer_enqueue+0xd9>
    45c2:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    45c6:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    45cb:	0f 84 db 00 00 00    	je     46ac <ringbuffer_enqueue+0x1c3>
						/* enough memory */
						rb = (struct ringbuffer*)nrb;
    45d1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    45d5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						*(void**)rbi = nrb;
    45d9:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    45dd:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    45e1:	48 89 10             	mov    QWORD PTR [rax],rdx
						/* move old data (if wrapped) */
						if (rb->ofs_end < rb->ofs_start) {
    45e4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    45e8:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    45ec:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    45f0:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    45f4:	48 39 c2             	cmp    rdx,rax
    45f7:	73 48                	jae    4641 <ringbuffer_enqueue+0x158>
								memcpy(rb->data + rb->cap, rb->data, rb->ofs_end);
    45f9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    45fd:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    4601:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    4605:	48 8d 72 1a          	lea    rsi,[rdx+0x1a]
    4609:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    460d:	48 8d 4a 1a          	lea    rcx,[rdx+0x1a]
    4611:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    4615:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    4618:	48 01 d1             	add    rcx,rdx
    461b:	48 89 c2             	mov    rdx,rax
    461e:	48 89 cf             	mov    rdi,rcx
    4621:	e8 40 ba ff ff       	call   66 <memcpy>
								rb->ofs_end += rb->ofs_start;
    4626:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    462a:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    462e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4632:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    4636:	48 01 c2             	add    rdx,rax
    4639:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    463d:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
						}
						rb->cap = nc;
    4641:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4645:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    4649:	48 89 10             	mov    QWORD PTR [rax],rdx
				} else {
	//					spin_unlock(&rb->lock);
						return; /* OOM */
				}
		}
		while (s--) {
    464c:	eb 4b                	jmp    4699 <ringbuffer_enqueue+0x1b0>
				if (rb->ofs_end == rb->cap)
    464e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4652:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    4656:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    465a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    465d:	48 39 c2             	cmp    rdx,rax
    4660:	75 0c                	jne    466e <ringbuffer_enqueue+0x185>
						rb->ofs_end = 0;
    4662:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4666:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
				rb->data[rb->ofs_end++] = *(data++);
    466e:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    4672:	48 8d 42 01          	lea    rax,[rdx+0x1]
    4676:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    467a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    467e:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    4682:	48 8d 70 01          	lea    rsi,[rax+0x1]
    4686:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    468a:	48 89 71 10          	mov    QWORD PTR [rcx+0x10],rsi
    468e:	0f b6 0a             	movzx  ecx,BYTE PTR [rdx]
    4691:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    4695:	88 4c 02 1a          	mov    BYTE PTR [rdx+rax*1+0x1a],cl
		while (s--) {
    4699:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    469d:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    46a1:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
    46a5:	48 85 c0             	test   rax,rax
    46a8:	75 a4                	jne    464e <ringbuffer_enqueue+0x165>
    46aa:	eb 01                	jmp    46ad <ringbuffer_enqueue+0x1c4>
						return; /* OOM */
    46ac:	90                   	nop
		}
//		spin_unlock(&rb->lock);
}
    46ad:	c9                   	leave
    46ae:	c3                   	ret

00000000000046af <ringbuffer_dequeue>:

void ringbuffer_dequeue(void* rbi, void* dat, size_t s)
{
    46af:	55                   	push   rbp
    46b0:	48 89 e5             	mov    rbp,rsp
    46b3:	48 83 ec 28          	sub    rsp,0x28
    46b7:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    46bb:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    46bf:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    46c3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    46c7:	48 8b 00             	mov    rax,QWORD PTR [rax]
    46ca:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
//		spin_lock(&rb->lock);
		char* data = (char*)dat;
    46ce:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    46d2:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (s--) {
    46d6:	e9 84 00 00 00       	jmp    475f <ringbuffer_dequeue+0xb0>
				if (rb->ofs_end == rb->ofs_start) {
    46db:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    46df:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    46e3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    46e7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    46eb:	48 39 c2             	cmp    rdx,rax
    46ee:	0f 84 82 00 00 00    	je     4776 <ringbuffer_dequeue+0xc7>
//						spin_unlock(&rb->lock);
						return;
				}
				*(data++) = rb->data[rb->ofs_start++];
    46f4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    46f8:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    46fc:	48 8d 4a 01          	lea    rcx,[rdx+0x1]
    4700:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4704:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
    4708:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    470c:	48 8d 48 01          	lea    rcx,[rax+0x1]
    4710:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
    4714:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    4718:	0f b6 54 11 1a       	movzx  edx,BYTE PTR [rcx+rdx*1+0x1a]
    471d:	88 10                	mov    BYTE PTR [rax],dl
				if (rb->ofs_start == rb->cap) {
    471f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4723:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    4727:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    472b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    472e:	48 39 c2             	cmp    rdx,rax
    4731:	75 2c                	jne    475f <ringbuffer_dequeue+0xb0>
						rb->ofs_start = 0;
    4733:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4737:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
						if (rb->ofs_end == rb->cap)
    473f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4743:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    4747:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    474b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    474e:	48 39 c2             	cmp    rdx,rax
    4751:	75 0c                	jne    475f <ringbuffer_dequeue+0xb0>
								rb->ofs_end = 0;
    4753:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4757:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
		while (s--) {
    475f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    4763:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    4767:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    476b:	48 85 c0             	test   rax,rax
    476e:	0f 85 67 ff ff ff    	jne    46db <ringbuffer_dequeue+0x2c>
    4774:	eb 01                	jmp    4777 <ringbuffer_dequeue+0xc8>
						return;
    4776:	90                   	nop
				}
		}
//		spin_unlock(&rb->lock);
}
    4777:	c9                   	leave
    4778:	c3                   	ret

0000000000004779 <ringbuffer_available>:

size_t ringbuffer_available(void* rbi)
{
    4779:	55                   	push   rbp
    477a:	48 89 e5             	mov    rbp,rsp
    477d:	48 83 ec 18          	sub    rsp,0x18
    4781:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    4785:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4789:	48 8b 00             	mov    rax,QWORD PTR [rax]
    478c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (rb->ofs_end < rb->ofs_start)
    4790:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4794:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    4798:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    479c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    47a0:	48 39 c2             	cmp    rdx,rax
    47a3:	73 1f                	jae    47c4 <ringbuffer_available+0x4b>
				return rb->cap - rb->ofs_start + rb->ofs_end;
    47a5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47a9:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    47ac:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47b0:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    47b4:	48 29 c2             	sub    rdx,rax
    47b7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47bb:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    47bf:	48 01 d0             	add    rax,rdx
    47c2:	eb 16                	jmp    47da <ringbuffer_available+0x61>
		else
				return rb->ofs_end - rb->ofs_start;
    47c4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47c8:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    47cc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47d0:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    47d4:	48 89 c8             	mov    rax,rcx
    47d7:	48 29 d0             	sub    rax,rdx
}
    47da:	c9                   	leave
    47db:	c3                   	ret

00000000000047dc <ringbuffer_free>:

void ringbuffer_free(void* rbi)
{
    47dc:	55                   	push   rbp
    47dd:	48 89 e5             	mov    rbp,rsp
    47e0:	48 83 ec 20          	sub    rsp,0x20
    47e4:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct ringbuffer* rbf = *(struct ringbuffer**)rbi;
    47e8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    47ec:	48 8b 00             	mov    rax,QWORD PTR [rax]
    47ef:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		spin_lock(&rbf->lock);
    47f3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47f7:	48 83 c0 18          	add    rax,0x18
    47fb:	48 89 c7             	mov    rdi,rax
    47fe:	e8 00 00 00 00       	call   4803 <ringbuffer_free+0x27>
		kfree(rbf);
    4803:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4807:	48 89 c7             	mov    rdi,rax
    480a:	e8 00 00 00 00       	call   480f <ringbuffer_free+0x33>
		kfree(rbi);
    480f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4813:	48 89 c7             	mov    rdi,rax
    4816:	e8 00 00 00 00       	call   481b <ringbuffer_free+0x3f>
}
    481b:	90                   	nop
    481c:	c9                   	leave
    481d:	c3                   	ret

000000000000481e <spin_lock>:

/* locking functions */
/* linux ticket spin (better than xchg under high contention) */
#define ACCESS_ONCE(x) (*(volatile __typeof__(x)*)&(x))
void spin_lock(spinlock_t* lock)
{
    481e:	55                   	push   rbp
    481f:	48 89 e5             	mov    rbp,rsp
    4822:	48 83 ec 18          	sub    rsp,0x18
    4826:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		register spinlock_t inc;
		inc.head_tail = 1 << (8 * sizeof(ticket_t));
    482a:	66 c7 45 fe 00 01    	mov    WORD PTR [rbp-0x2],0x100

		inc.head_tail = __sync_fetch_and_add(&lock->head_tail, inc.head_tail);
    4830:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    4834:	0f b7 d0             	movzx  edx,ax
    4837:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    483b:	66 f0 0f c1 10       	lock xadd WORD PTR [rax],dx
    4840:	66 89 55 fe          	mov    WORD PTR [rbp-0x2],dx

		for (;;) {
				if (inc.tickets.head == inc.tickets.tail)
    4844:	0f b6 55 fe          	movzx  edx,BYTE PTR [rbp-0x2]
    4848:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    484c:	38 c2                	cmp    dl,al
    484e:	74 0e                	je     485e <spin_lock+0x40>
						break;
				_mm_pause();
    4850:	f3 90                	pause
				inc.tickets.head = ACCESS_ONCE(lock->tickets.head);
    4852:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4856:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    4859:	88 45 fe             	mov    BYTE PTR [rbp-0x2],al
				if (inc.tickets.head == inc.tickets.tail)
    485c:	eb e6                	jmp    4844 <spin_lock+0x26>
						break;
    485e:	90                   	nop
		}
}
    485f:	90                   	nop
    4860:	c9                   	leave
    4861:	c3                   	ret

0000000000004862 <spin_lock_init>:

void spin_lock_init(spinlock_t* lock)
{
    4862:	55                   	push   rbp
    4863:	48 89 e5             	mov    rbp,rsp
    4866:	48 83 ec 08          	sub    rsp,0x8
    486a:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		*lock = (spinlock_t){0};
    486e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4872:	66 c7 00 00 00       	mov    WORD PTR [rax],0x0
}
    4877:	90                   	nop
    4878:	c9                   	leave
    4879:	c3                   	ret

000000000000487a <spin_lock_irq>:

void spin_lock_irq(spinlock_t* lock)
{
    487a:	55                   	push   rbp
    487b:	48 89 e5             	mov    rbp,rsp
    487e:	48 83 ec 08          	sub    rsp,0x8
    4882:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		asm("cli");
    4886:	fa                   	cli
		spin_lock(lock);
    4887:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    488b:	48 89 c7             	mov    rdi,rax
    488e:	e8 00 00 00 00       	call   4893 <spin_lock_irq+0x19>
}
    4893:	90                   	nop
    4894:	c9                   	leave
    4895:	c3                   	ret

0000000000004896 <spin_lock_irqsave>:

void spin_lock_irqsave(spinlock_t* lock, unsigned long* flags)
{
    4896:	55                   	push   rbp
    4897:	48 89 e5             	mov    rbp,rsp
    489a:	48 83 ec 10          	sub    rsp,0x10
    489e:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    48a2:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		*flags = !if_enabled();
    48a6:	b8 00 00 00 00       	mov    eax,0x0
    48ab:	e8 0e b8 ff ff       	call   be <if_enabled>
    48b0:	48 85 c0             	test   rax,rax
    48b3:	0f 94 c0             	sete   al
    48b6:	0f b6 d0             	movzx  edx,al
    48b9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    48bd:	48 89 10             	mov    QWORD PTR [rax],rdx
		asm("cli");
    48c0:	fa                   	cli
		preempt_disable();
    48c1:	b8 00 00 00 00       	mov    eax,0x0
    48c6:	e8 00 00 00 00       	call   48cb <spin_lock_irqsave+0x35>
    48cb:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    48ce:	83 c2 01             	add    edx,0x1
    48d1:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		spin_lock(lock);
    48d4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    48d8:	48 89 c7             	mov    rdi,rax
    48db:	e8 00 00 00 00       	call   48e0 <spin_lock_irqsave+0x4a>
}
    48e0:	90                   	nop
    48e1:	c9                   	leave
    48e2:	c3                   	ret

00000000000048e3 <spin_trylock>:

int spin_trylock(spinlock_t* lock)
{
    48e3:	55                   	push   rbp
    48e4:	48 89 e5             	mov    rbp,rsp
    48e7:	48 83 ec 18          	sub    rsp,0x18
    48eb:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		spinlock_t old, new;

		old.head_tail = ACCESS_ONCE(lock->head_tail);
    48ef:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    48f3:	0f b7 00             	movzx  eax,WORD PTR [rax]
    48f6:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
		if (old.tickets.head != old.tickets.tail)
    48fa:	0f b6 55 fe          	movzx  edx,BYTE PTR [rbp-0x2]
    48fe:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    4902:	38 c2                	cmp    dl,al
    4904:	74 07                	je     490d <spin_trylock+0x2a>
				return 0;
    4906:	b8 00 00 00 00       	mov    eax,0x0
    490b:	eb 29                	jmp    4936 <spin_trylock+0x53>

		new.head_tail = old.head_tail + (1 << (8 * sizeof(ticket_t)));
    490d:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    4911:	66 05 00 01          	add    ax,0x100
    4915:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
		return __sync_bool_compare_and_swap(&lock->head_tail, old.head_tail, new.head_tail);
    4919:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    491d:	0f b7 c8             	movzx  ecx,ax
    4920:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    4924:	0f b7 c0             	movzx  eax,ax
    4927:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    492b:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [rdx],cx
    4930:	0f 94 c0             	sete   al
    4933:	0f b6 c0             	movzx  eax,al
}
    4936:	c9                   	leave
    4937:	c3                   	ret

0000000000004938 <spin_trylock_irq>:

int spin_trylock_irq(spinlock_t* lock)
{
    4938:	55                   	push   rbp
    4939:	48 89 e5             	mov    rbp,rsp
    493c:	48 83 ec 18          	sub    rsp,0x18
    4940:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv;
		asm("cli");
    4944:	fa                   	cli
		rv = spin_trylock(lock);
    4945:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4949:	48 89 c7             	mov    rdi,rax
    494c:	e8 00 00 00 00       	call   4951 <spin_trylock_irq+0x19>
    4951:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (rv)
    4954:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    4958:	74 05                	je     495f <spin_trylock_irq+0x27>
				return rv;
    495a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    495d:	eb 04                	jmp    4963 <spin_trylock_irq+0x2b>
		asm("sti");
    495f:	fb                   	sti
		return rv;
    4960:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    4963:	c9                   	leave
    4964:	c3                   	ret

0000000000004965 <spin_trylock_irqsave>:

int spin_trylock_irqsave(spinlock_t* lock, int* flags)
{
    4965:	55                   	push   rbp
    4966:	48 89 e5             	mov    rbp,rsp
    4969:	48 83 ec 20          	sub    rsp,0x20
    496d:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    4971:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		int rv;
		*flags = if_enabled();
    4975:	b8 00 00 00 00       	mov    eax,0x0
    497a:	e8 3f b7 ff ff       	call   be <if_enabled>
    497f:	89 c2                	mov    edx,eax
    4981:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    4985:	89 10                	mov    DWORD PTR [rax],edx
		asm("cli");
    4987:	fa                   	cli
		preempt_disable();
    4988:	b8 00 00 00 00       	mov    eax,0x0
    498d:	e8 00 00 00 00       	call   4992 <spin_trylock_irqsave+0x2d>
    4992:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    4995:	83 c2 01             	add    edx,0x1
    4998:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		rv = spin_trylock(lock);
    499b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    499f:	48 89 c7             	mov    rdi,rax
    49a2:	e8 00 00 00 00       	call   49a7 <spin_trylock_irqsave+0x42>
    49a7:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (!rv) {
    49aa:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    49ae:	75 1e                	jne    49ce <spin_trylock_irqsave+0x69>
				if (*flags)
    49b0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    49b4:	8b 00                	mov    eax,DWORD PTR [rax]
    49b6:	85 c0                	test   eax,eax
    49b8:	74 01                	je     49bb <spin_trylock_irqsave+0x56>
						asm("sti");
    49ba:	fb                   	sti
				preempt_enable_no_resched();
    49bb:	b8 00 00 00 00       	mov    eax,0x0
    49c0:	e8 00 00 00 00       	call   49c5 <spin_trylock_irqsave+0x60>
    49c5:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    49c8:	83 ea 01             	sub    edx,0x1
    49cb:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		}
		return rv;
    49ce:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    49d1:	c9                   	leave
    49d2:	c3                   	ret

00000000000049d3 <spin_unlock>:

void spin_unlock(spinlock_t* lock)
{
    49d3:	55                   	push   rbp
    49d4:	48 89 e5             	mov    rbp,rsp
    49d7:	48 83 ec 08          	sub    rsp,0x8
    49db:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		__sync_fetch_and_add(&lock->tickets.head, 1);
    49df:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    49e3:	f0 80 00 01          	lock add BYTE PTR [rax],0x1
}
    49e7:	90                   	nop
    49e8:	c9                   	leave
    49e9:	c3                   	ret

00000000000049ea <spin_unlock_irq>:

void spin_unlock_irq(spinlock_t* lock)
{
    49ea:	55                   	push   rbp
    49eb:	48 89 e5             	mov    rbp,rsp
    49ee:	48 83 ec 08          	sub    rsp,0x8
    49f2:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		spin_unlock(lock);
    49f6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    49fa:	48 89 c7             	mov    rdi,rax
    49fd:	e8 00 00 00 00       	call   4a02 <spin_unlock_irq+0x18>
		asm("sti");
    4a02:	fb                   	sti
}
    4a03:	90                   	nop
    4a04:	c9                   	leave
    4a05:	c3                   	ret

0000000000004a06 <spin_unlock_irqrestore>:

void spin_unlock_irqrestore(spinlock_t* lock, unsigned long flags)
{
    4a06:	55                   	push   rbp
    4a07:	48 89 e5             	mov    rbp,rsp
    4a0a:	48 83 ec 10          	sub    rsp,0x10
    4a0e:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    4a12:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		spin_unlock(lock);
    4a16:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4a1a:	48 89 c7             	mov    rdi,rax
    4a1d:	e8 00 00 00 00       	call   4a22 <spin_unlock_irqrestore+0x1c>
		if (flags)
    4a22:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    4a27:	74 01                	je     4a2a <spin_unlock_irqrestore+0x24>
				asm("sti");
    4a29:	fb                   	sti
		preempt_enable_no_resched();
    4a2a:	b8 00 00 00 00       	mov    eax,0x0
    4a2f:	e8 00 00 00 00       	call   4a34 <spin_unlock_irqrestore+0x2e>
    4a34:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    4a37:	83 ea 01             	sub    edx,0x1
    4a3a:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
}
    4a3d:	90                   	nop
    4a3e:	c9                   	leave
    4a3f:	c3                   	ret

0000000000004a40 <read_lock>:

void read_lock(rwlock_t* lock)
{
    4a40:	55                   	push   rbp
    4a41:	48 89 e5             	mov    rbp,rsp
    4a44:	48 83 ec 08          	sub    rsp,0x8
    4a48:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		if (!__sync_fetch_and_add(&lock->cnts.counter, 1)) {
    4a4c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4a50:	ba 01 00 00 00       	mov    edx,0x1
    4a55:	f0 0f c1 10          	lock xadd DWORD PTR [rax],edx
    4a59:	85 d2                	test   edx,edx
    4a5b:	75 10                	jne    4a6d <read_lock+0x2d>
				/* first reader */
				spin_lock(&lock->lock);
    4a5d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4a61:	48 83 c0 04          	add    rax,0x4
    4a65:	48 89 c7             	mov    rdi,rax
    4a68:	e8 00 00 00 00       	call   4a6d <read_lock+0x2d>
		}
}
    4a6d:	90                   	nop
    4a6e:	c9                   	leave
    4a6f:	c3                   	ret

0000000000004a70 <read_unlock>:

void read_unlock(rwlock_t* lock)
{
    4a70:	55                   	push   rbp
    4a71:	48 89 e5             	mov    rbp,rsp
    4a74:	48 83 ec 08          	sub    rsp,0x8
    4a78:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		if (!__sync_sub_and_fetch(&lock->cnts.counter, 1)) {
    4a7c:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    4a80:	b8 01 00 00 00       	mov    eax,0x1
    4a85:	f7 d8                	neg    eax
    4a87:	89 c1                	mov    ecx,eax
    4a89:	89 c8                	mov    eax,ecx
    4a8b:	f0 0f c1 02          	lock xadd DWORD PTR [rdx],eax
    4a8f:	01 c8                	add    eax,ecx
    4a91:	85 c0                	test   eax,eax
    4a93:	75 10                	jne    4aa5 <read_unlock+0x35>
				/* last reader, allow writing again */
				spin_unlock(&lock->lock);
    4a95:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4a99:	48 83 c0 04          	add    rax,0x4
    4a9d:	48 89 c7             	mov    rdi,rax
    4aa0:	e8 00 00 00 00       	call   4aa5 <read_unlock+0x35>
		}
}
    4aa5:	90                   	nop
    4aa6:	c9                   	leave
    4aa7:	c3                   	ret

0000000000004aa8 <write_lock>:

void write_lock(rwlock_t* lock)
{
    4aa8:	55                   	push   rbp
    4aa9:	48 89 e5             	mov    rbp,rsp
    4aac:	48 83 ec 08          	sub    rsp,0x8
    4ab0:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		spin_lock(&lock->lock);
    4ab4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4ab8:	48 83 c0 04          	add    rax,0x4
    4abc:	48 89 c7             	mov    rdi,rax
    4abf:	e8 00 00 00 00       	call   4ac4 <write_lock+0x1c>
}
    4ac4:	90                   	nop
    4ac5:	c9                   	leave
    4ac6:	c3                   	ret

0000000000004ac7 <write_trylock>:

int write_trylock(rwlock_t* lock)
{
    4ac7:	55                   	push   rbp
    4ac8:	48 89 e5             	mov    rbp,rsp
    4acb:	48 83 ec 08          	sub    rsp,0x8
    4acf:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		return spin_trylock(&lock->lock);
    4ad3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4ad7:	48 83 c0 04          	add    rax,0x4
    4adb:	48 89 c7             	mov    rdi,rax
    4ade:	e8 00 00 00 00       	call   4ae3 <write_trylock+0x1c>
}
    4ae3:	c9                   	leave
    4ae4:	c3                   	ret

0000000000004ae5 <write_unlock>:

void write_unlock(rwlock_t* lock)
{
    4ae5:	55                   	push   rbp
    4ae6:	48 89 e5             	mov    rbp,rsp
    4ae9:	48 83 ec 08          	sub    rsp,0x8
    4aed:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		spin_unlock(&lock->lock);
    4af1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4af5:	48 83 c0 04          	add    rax,0x4
    4af9:	48 89 c7             	mov    rdi,rax
    4afc:	e8 00 00 00 00       	call   4b01 <write_unlock+0x1c>
}
    4b01:	90                   	nop
    4b02:	c9                   	leave
    4b03:	c3                   	ret
