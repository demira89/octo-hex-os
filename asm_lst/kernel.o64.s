
kernel.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <per_cpu_ptr>:
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
}

/**************** COM routines to be moved into module *******************/
static int com_present = 0;
static uint16_t com_ports[4] = {0};
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 10          	sub    rsp,0x10
static uint16_t def_port = 0;

void enable_com(int num, uint16_t port)
       8:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
      11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
{
		if (!com_present) {
				com_present = 1;
				def_port = port;
      15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
				irq_unmask(3);
      19:	c9                   	leave
      1a:	c3                   	ret

000000000000001b <io_wait>:

void putDebugChar(char c)
{
		while (!is_transit_empty(def_port));
		outb(def_port, c);
}
      1b:	55                   	push   rbp
      1c:	48 89 e5             	mov    rbp,rsp

      1f:	b8 00 00 00 00       	mov    eax,0x0
      24:	e6 80                	out    0x80,al
int serial_received(uint16_t port)
      26:	90                   	nop
      27:	5d                   	pop    rbp
      28:	c3                   	ret

0000000000000029 <outb>:
{
		return inb(port + 5) & 1;
}
      29:	55                   	push   rbp
      2a:	48 89 e5             	mov    rbp,rsp
      2d:	48 83 ec 08          	sub    rsp,0x8
      31:	89 fa                	mov    edx,edi
      33:	89 f0                	mov    eax,esi
      35:	66 89 55 fc          	mov    WORD PTR [rbp-0x4],dx
      39:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al

      3c:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
      40:	0f b7 55 fc          	movzx  edx,WORD PTR [rbp-0x4]
      44:	ee                   	out    dx,al
char getDebugChar()
      45:	90                   	nop
      46:	c9                   	leave
      47:	c3                   	ret

0000000000000048 <inb>:
{
		while (!serial_received(def_port));
		return inb(def_port);
      48:	55                   	push   rbp
      49:	48 89 e5             	mov    rbp,rsp
      4c:	48 83 ec 18          	sub    rsp,0x18
      50:	89 f8                	mov    eax,edi
      52:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
}

      56:	0f b7 45 ec          	movzx  eax,WORD PTR [rbp-0x14]
      5a:	89 c2                	mov    edx,eax
      5c:	ec                   	in     al,dx
      5d:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
/*************************************************************************/
      60:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
struct irqe {
      64:	c9                   	leave
      65:	c3                   	ret

0000000000000066 <memcpy>:
		struct irqe* p = kmalloc(sizeof(*p));
		if (!p)
				return 0;
		p->fun = fun;
		/* unmask first */
		if (!irq_funs[irq - 1])
      66:	55                   	push   rbp
      67:	48 89 e5             	mov    rbp,rsp
      6a:	48 83 ec 28          	sub    rsp,0x28
      6e:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
      72:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      76:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
				irq_unmask(irq);
      7a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      7e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		do {
      82:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      86:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				p->next = irq_funs[irq - 1];
      8a:	eb 1d                	jmp    a9 <memcpy+0x43>
		} while (!__sync_bool_compare_and_swap(&irq_funs[irq - 1], p->next, p));
      8c:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      90:	48 8d 42 01          	lea    rax,[rdx+0x1]
      94:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      98:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      9c:	48 8d 48 01          	lea    rcx,[rax+0x1]
      a0:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      a4:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      a7:	88 10                	mov    BYTE PTR [rax],dl
				p->next = irq_funs[irq - 1];
      a9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      ad:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      b1:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      b5:	48 85 c0             	test   rax,rax
      b8:	75 d2                	jne    8c <memcpy+0x26>
		return 1;
      ba:	90                   	nop
      bb:	90                   	nop
      bc:	c9                   	leave
      bd:	c3                   	ret

00000000000000be <if_enabled>:
								? 1 : 0));
				pc_b = min(9, 10 - cpu_pcs[0].vals[4]);
				if (pc_a == 100)
						pc_b = 0;
				crprintf(KFMT_NORMAL, &km_regC, "%3u.%1u%%", pc_a, pc_b);
		}
      be:	55                   	push   rbp
      bf:	48 89 e5             	mov    rbp,rsp
      c2:	48 83 ec 10          	sub    rsp,0x10
}

      c6:	9c                   	pushf
      c7:	58                   	pop    rax
      c8:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				return;
		counter_print = jiffies;
		if (tsc_per_ms) {
				tp = " ns";
				rdt = fb_rdt * 1000000 / tsc_per_ms;
				if (rdt > 99999) {
      cc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      d0:	83 e0 20             	and    eax,0x20
      d3:	48 85 c0             	test   rax,rax
      d6:	0f 95 c0             	setne  al
      d9:	0f b6 c0             	movzx  eax,al
						rdt /= 1000;
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
		struct idt_entry* dt = &idt;
     129:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		if (i < 17) {
     131:	83 7d ec 10          	cmp    DWORD PTR [rbp-0x14],0x10
     135:	7f 61                	jg     198 <exceptionHandler+0x7e>
				dt[i].offset_1 = (uint16_t)((size_t)ptr & 0x0000ffff);
     137:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     13b:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     13e:	48 98                	cdqe
     140:	48 c1 e0 04          	shl    rax,0x4
     144:	48 89 c2             	mov    rdx,rax
     147:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     14b:	48 01 d0             	add    rax,rdx
     14e:	89 ca                	mov    edx,ecx
     150:	66 89 10             	mov    WORD PTR [rax],dx
				dt[i].offset_2 = (uint16_t)((size_t)ptr >> 16);
     153:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     157:	48 c1 e8 10          	shr    rax,0x10
     15b:	48 89 c1             	mov    rcx,rax
     15e:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     161:	48 98                	cdqe
     163:	48 c1 e0 04          	shl    rax,0x4
     167:	48 89 c2             	mov    rdx,rax
     16a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     16e:	48 01 d0             	add    rax,rdx
     171:	89 ca                	mov    edx,ecx
     173:	66 89 50 06          	mov    WORD PTR [rax+0x6],dx
				dt[i].offset_3 = (uint32_t)((size_t)ptr >> 32);
     177:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     17b:	48 c1 e8 20          	shr    rax,0x20
     17f:	48 89 c2             	mov    rdx,rax
     182:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     185:	48 98                	cdqe
     187:	48 c1 e0 04          	shl    rax,0x4
     18b:	48 89 c1             	mov    rcx,rax
     18e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     192:	48 01 c8             	add    rax,rcx
     195:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
}
     198:	90                   	nop
     199:	c9                   	leave
     19a:	c3                   	ret

000000000000019b <print_exception>:
{
     19b:	55                   	push   rbp
     19c:	48 89 e5             	mov    rbp,rsp
     19f:	48 83 ec 10          	sub    rsp,0x10
     1a3:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     1a7:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
		while (eip);
     1aa:	90                   	nop
     1ab:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     1b0:	75 f9                	jne    1ab <print_exception+0x10>
		switch (code) {
     1b2:	83 7d f4 1e          	cmp    DWORD PTR [rbp-0xc],0x1e
     1b6:	0f 87 e4 01 00 00    	ja     3a0 <print_exception+0x205>
     1bc:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     1bf:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     1c7:	ff e0                	jmp    rax
					printf("#DE at %p\n", eip);
     1c9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1cd:	48 89 c6             	mov    rsi,rax
     1d0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     1d7:	b8 00 00 00 00       	mov    eax,0x0
     1dc:	e8 00 00 00 00       	call   1e1 <print_exception+0x46>
					break;
     1e1:	e9 d5 01 00 00       	jmp    3bb <print_exception+0x220>
					printf("#BP at %p\n", (void*)((char*)eip-1));
     1e6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ea:	48 83 e8 01          	sub    rax,0x1
     1ee:	48 89 c6             	mov    rsi,rax
     1f1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     1f8:	b8 00 00 00 00       	mov    eax,0x0
     1fd:	e8 00 00 00 00       	call   202 <print_exception+0x67>
					break;
     202:	e9 b4 01 00 00       	jmp    3bb <print_exception+0x220>
					printf("#OF before %p\n", eip);
     207:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     20b:	48 89 c6             	mov    rsi,rax
     20e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     215:	b8 00 00 00 00       	mov    eax,0x0
     21a:	e8 00 00 00 00       	call   21f <print_exception+0x84>
					break;
     21f:	e9 97 01 00 00       	jmp    3bb <print_exception+0x220>
					printf("#BR at %p\n", eip);
     224:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     228:	48 89 c6             	mov    rsi,rax
     22b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     232:	b8 00 00 00 00       	mov    eax,0x0
     237:	e8 00 00 00 00       	call   23c <print_exception+0xa1>
					while (1);
     23c:	90                   	nop
     23d:	eb fd                	jmp    23c <print_exception+0xa1>
					printf("#UD at %p\n", eip);
     23f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     243:	48 89 c6             	mov    rsi,rax
     246:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     24d:	b8 00 00 00 00       	mov    eax,0x0
     252:	e8 00 00 00 00       	call   257 <print_exception+0xbc>
					while (1);
     257:	90                   	nop
     258:	eb fd                	jmp    257 <print_exception+0xbc>
					printf("#NM at %p\nFPU is disabled or not present\n", eip);
     25a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     25e:	48 89 c6             	mov    rsi,rax
     261:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     268:	b8 00 00 00 00       	mov    eax,0x0
     26d:	e8 00 00 00 00       	call   272 <print_exception+0xd7>
					break;
     272:	e9 44 01 00 00       	jmp    3bb <print_exception+0x220>
					printf("#DF with error code %x\n", (uint32_t)(size_t)eip);
     277:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     27b:	89 c6                	mov    esi,eax
     27d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     284:	b8 00 00 00 00       	mov    eax,0x0
     289:	e8 00 00 00 00       	call   28e <print_exception+0xf3>
					die("that's it");
     28e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     295:	bf 0c 00 00 00       	mov    edi,0xc
     29a:	b8 00 00 00 00       	mov    eax,0x0
     29f:	e8 00 00 00 00       	call   2a4 <print_exception+0x109>
     2a4:	b8 00 00 00 00       	mov    eax,0x0
     2a9:	e8 00 00 00 00       	call   2ae <print_exception+0x113>
     2ae:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2b5:	e8 00 00 00 00       	call   2ba <print_exception+0x11f>
     2ba:	fa                   	cli
     2bb:	f4                   	hlt
     2bc:	eb fd                	jmp    2bb <print_exception+0x120>
					printf("Legacy coprocessor segment overrun at %p\n", eip);
     2be:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2c2:	48 89 c6             	mov    rsi,rax
     2c5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2cc:	b8 00 00 00 00       	mov    eax,0x0
     2d1:	e8 00 00 00 00       	call   2d6 <print_exception+0x13b>
					break;
     2d6:	e9 e0 00 00 00       	jmp    3bb <print_exception+0x220>
					printf("Reserved gate called from %p\n", eip);
     2db:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2df:	48 89 c6             	mov    rsi,rax
     2e2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2e9:	b8 00 00 00 00       	mov    eax,0x0
     2ee:	e8 00 00 00 00       	call   2f3 <print_exception+0x158>
					break;
     2f3:	e9 c3 00 00 00       	jmp    3bb <print_exception+0x220>
					printf("#MF at %p\n", eip);
     2f8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2fc:	48 89 c6             	mov    rsi,rax
     2ff:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     306:	b8 00 00 00 00       	mov    eax,0x0
     30b:	e8 00 00 00 00       	call   310 <print_exception+0x175>
					break;
     310:	e9 a6 00 00 00       	jmp    3bb <print_exception+0x220>
					printf("#AC at %p\n", eip);
     315:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     319:	48 89 c6             	mov    rsi,rax
     31c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     323:	b8 00 00 00 00       	mov    eax,0x0
     328:	e8 00 00 00 00       	call   32d <print_exception+0x192>
					break;
     32d:	e9 89 00 00 00       	jmp    3bb <print_exception+0x220>
					cprintf(KFMT_ERROR, "#MC received while at %p\n", eip);
     332:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     336:	48 89 c2             	mov    rdx,rax
     339:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     340:	bf 0c 00 00 00       	mov    edi,0xc
     345:	b8 00 00 00 00       	mov    eax,0x0
     34a:	e8 00 00 00 00       	call   34f <print_exception+0x1b4>
					while (1);
     34f:	90                   	nop
     350:	eb fd                	jmp    34f <print_exception+0x1b4>
					printf("#XM at %p\n", eip);
     352:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     356:	48 89 c6             	mov    rsi,rax
     359:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     360:	b8 00 00 00 00       	mov    eax,0x0
     365:	e8 00 00 00 00       	call   36a <print_exception+0x1cf>
					break;
     36a:	eb 4f                	jmp    3bb <print_exception+0x220>
					printf("#VE at %p\n", eip);
     36c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     370:	48 89 c6             	mov    rsi,rax
     373:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     37a:	b8 00 00 00 00       	mov    eax,0x0
     37f:	e8 00 00 00 00       	call   384 <print_exception+0x1e9>
					break;
     384:	eb 35                	jmp    3bb <print_exception+0x220>
					printf("#SX at %p\n", eip);
     386:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     38a:	48 89 c6             	mov    rsi,rax
     38d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     394:	b8 00 00 00 00       	mov    eax,0x0
     399:	e8 00 00 00 00       	call   39e <print_exception+0x203>
					break;
     39e:	eb 1b                	jmp    3bb <print_exception+0x220>
					printf("int %x at %p\n", code, eip);
     3a0:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     3a4:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     3a7:	89 c6                	mov    esi,eax
     3a9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     3b0:	b8 00 00 00 00       	mov    eax,0x0
     3b5:	e8 00 00 00 00       	call   3ba <print_exception+0x21f>
					break;
     3ba:	90                   	nop
}
     3bb:	90                   	nop
     3bc:	c9                   	leave
     3bd:	c3                   	ret

00000000000003be <print_idt>:
{
     3be:	55                   	push   rbp
     3bf:	48 89 e5             	mov    rbp,rsp
     3c2:	48 83 ec 20          	sub    rsp,0x20
     3c6:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     3ca:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		printf("IDT at %p\n", idt);
     3cd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3d1:	48 89 c6             	mov    rsi,rax
     3d4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     3db:	b8 00 00 00 00       	mov    eax,0x0
     3e0:	e8 00 00 00 00       	call   3e5 <print_idt+0x27>
		for (i = 0; i < num; i++) {
     3e5:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     3ec:	eb 6e                	jmp    45c <print_idt+0x9e>
								idt->type);
     3ee:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3f2:	0f b6 40 05          	movzx  eax,BYTE PTR [rax+0x5]
				printf("IDT entry %d: %x:%p type=%x\n", i, idt->selector,
     3f6:	0f b6 c8             	movzx  ecx,al
								(void*)(((uint64_t)idt->offset_3 << 32) | (((uint32_t)idt->offset_2) << 16) | idt->offset_1),
     3f9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3fd:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
     400:	89 c0                	mov    eax,eax
     402:	48 c1 e0 20          	shl    rax,0x20
     406:	48 89 c2             	mov    rdx,rax
     409:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     40d:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
     411:	0f b7 c0             	movzx  eax,ax
     414:	c1 e0 10             	shl    eax,0x10
     417:	89 c0                	mov    eax,eax
     419:	48 09 c2             	or     rdx,rax
     41c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     420:	0f b7 00             	movzx  eax,WORD PTR [rax]
     423:	0f b7 c0             	movzx  eax,ax
     426:	48 09 d0             	or     rax,rdx
				printf("IDT entry %d: %x:%p type=%x\n", i, idt->selector,
     429:	48 89 c6             	mov    rsi,rax
     42c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     430:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     434:	0f b7 d0             	movzx  edx,ax
     437:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     43a:	41 89 c8             	mov    r8d,ecx
     43d:	48 89 f1             	mov    rcx,rsi
     440:	89 c6                	mov    esi,eax
     442:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     449:	b8 00 00 00 00       	mov    eax,0x0
     44e:	e8 00 00 00 00       	call   453 <print_idt+0x95>
				idt++;
     453:	48 83 45 e8 10       	add    QWORD PTR [rbp-0x18],0x10
		for (i = 0; i < num; i++) {
     458:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     45c:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     45f:	3b 45 e4             	cmp    eax,DWORD PTR [rbp-0x1c]
     462:	72 8a                	jb     3ee <print_idt+0x30>
}
     464:	90                   	nop
     465:	90                   	nop
     466:	c9                   	leave
     467:	c3                   	ret

0000000000000468 <debug_handler>:
{
     468:	55                   	push   rbp
     469:	48 89 e5             	mov    rbp,rsp
     46c:	48 83 ec 10          	sub    rsp,0x10
     470:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     474:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
		cprintf(KFMT_INFO, "#DB at %p with DR6=%x\n", eip, dr6);
     477:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
     47a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     47e:	89 d1                	mov    ecx,edx
     480:	48 89 c2             	mov    rdx,rax
     483:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     48a:	bf 0b 00 00 00       	mov    edi,0xb
     48f:	b8 00 00 00 00       	mov    eax,0x0
     494:	e8 00 00 00 00       	call   499 <debug_handler+0x31>
		return 0;
     499:	b8 00 00 00 00       	mov    eax,0x0
}
     49e:	c9                   	leave
     49f:	c3                   	ret

00000000000004a0 <irq_mask>:
{
     4a0:	55                   	push   rbp
     4a1:	48 89 e5             	mov    rbp,rsp
     4a4:	48 83 ec 18          	sub    rsp,0x18
     4a8:	89 f8                	mov    eax,edi
     4aa:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		if (line < 8)
     4ad:	80 7d ec 07          	cmp    BYTE PTR [rbp-0x14],0x7
     4b1:	77 08                	ja     4bb <irq_mask+0x1b>
				prt = PIC1_DATA;
     4b3:	66 c7 45 fe 21 00    	mov    WORD PTR [rbp-0x2],0x21
     4b9:	eb 10                	jmp    4cb <irq_mask+0x2b>
		else if (line <= 15) {
     4bb:	80 7d ec 0f          	cmp    BYTE PTR [rbp-0x14],0xf
     4bf:	77 3e                	ja     4ff <irq_mask+0x5f>
				prt = PIC2_DATA;
     4c1:	66 c7 45 fe a1 00    	mov    WORD PTR [rbp-0x2],0xa1
				line -= 8;
     4c7:	80 6d ec 08          	sub    BYTE PTR [rbp-0x14],0x8
		line = inb(prt) | (1 << line);
     4cb:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     4cf:	89 c7                	mov    edi,eax
     4d1:	e8 72 fb ff ff       	call   48 <inb>
     4d6:	89 c6                	mov    esi,eax
     4d8:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     4dc:	ba 01 00 00 00       	mov    edx,0x1
     4e1:	89 c1                	mov    ecx,eax
     4e3:	d3 e2                	shl    edx,cl
     4e5:	89 d0                	mov    eax,edx
     4e7:	09 f0                	or     eax,esi
     4e9:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		outb(prt, line);
     4ec:	0f b6 55 ec          	movzx  edx,BYTE PTR [rbp-0x14]
     4f0:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     4f4:	89 d6                	mov    esi,edx
     4f6:	89 c7                	mov    edi,eax
     4f8:	e8 2c fb ff ff       	call   29 <outb>
     4fd:	eb 01                	jmp    500 <irq_mask+0x60>
				return;
     4ff:	90                   	nop
}
     500:	c9                   	leave
     501:	c3                   	ret

0000000000000502 <irq_unmask>:
{
     502:	55                   	push   rbp
     503:	48 89 e5             	mov    rbp,rsp
     506:	48 83 ec 18          	sub    rsp,0x18
     50a:	89 f8                	mov    eax,edi
     50c:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		if (line < 8)
     50f:	80 7d ec 07          	cmp    BYTE PTR [rbp-0x14],0x7
     513:	77 08                	ja     51d <irq_unmask+0x1b>
				prt = PIC1_DATA;
     515:	66 c7 45 fe 21 00    	mov    WORD PTR [rbp-0x2],0x21
     51b:	eb 10                	jmp    52d <irq_unmask+0x2b>
		else if (line <= 15) {
     51d:	80 7d ec 0f          	cmp    BYTE PTR [rbp-0x14],0xf
     521:	77 40                	ja     563 <irq_unmask+0x61>
				prt = PIC2_DATA;
     523:	66 c7 45 fe a1 00    	mov    WORD PTR [rbp-0x2],0xa1
				line -= 8;
     529:	80 6d ec 08          	sub    BYTE PTR [rbp-0x14],0x8
		line = inb(prt) & ~(1 << line);
     52d:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     531:	89 c7                	mov    edi,eax
     533:	e8 10 fb ff ff       	call   48 <inb>
     538:	89 c6                	mov    esi,eax
     53a:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     53e:	ba 01 00 00 00       	mov    edx,0x1
     543:	89 c1                	mov    ecx,eax
     545:	d3 e2                	shl    edx,cl
     547:	89 d0                	mov    eax,edx
     549:	f7 d0                	not    eax
     54b:	21 f0                	and    eax,esi
     54d:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		outb(prt, line);
     550:	0f b6 55 ec          	movzx  edx,BYTE PTR [rbp-0x14]
     554:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     558:	89 d6                	mov    esi,edx
     55a:	89 c7                	mov    edi,eax
     55c:	e8 c8 fa ff ff       	call   29 <outb>
     561:	eb 01                	jmp    564 <irq_unmask+0x62>
				return;
     563:	90                   	nop
}
     564:	c9                   	leave
     565:	c3                   	ret

0000000000000566 <pic_disable>:
{
     566:	55                   	push   rbp
     567:	48 89 e5             	mov    rbp,rsp
		outb(PIC2_COMMAND, 0xff);
     56a:	be ff 00 00 00       	mov    esi,0xff
     56f:	bf a0 00 00 00       	mov    edi,0xa0
     574:	e8 b0 fa ff ff       	call   29 <outb>
		outb(PIC1_COMMAND, 0xff);
     579:	be ff 00 00 00       	mov    esi,0xff
     57e:	bf 20 00 00 00       	mov    edi,0x20
     583:	e8 a1 fa ff ff       	call   29 <outb>
}
     588:	90                   	nop
     589:	5d                   	pop    rbp
     58a:	c3                   	ret

000000000000058b <pic_get_irr>:
{
     58b:	55                   	push   rbp
     58c:	48 89 e5             	mov    rbp,rsp
     58f:	53                   	push   rbx
		outb(PIC1_COMMAND, 0x0a); /* PIC_READ_IRR */
     590:	be 0a 00 00 00       	mov    esi,0xa
     595:	bf 20 00 00 00       	mov    edi,0x20
     59a:	e8 8a fa ff ff       	call   29 <outb>
		outb(PIC2_COMMAND, 0x0a);
     59f:	be 0a 00 00 00       	mov    esi,0xa
     5a4:	bf a0 00 00 00       	mov    edi,0xa0
     5a9:	e8 7b fa ff ff       	call   29 <outb>
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
     5ae:	bf a0 00 00 00       	mov    edi,0xa0
     5b3:	e8 90 fa ff ff       	call   48 <inb>
     5b8:	0f b6 c0             	movzx  eax,al
     5bb:	c1 e0 08             	shl    eax,0x8
     5be:	89 c3                	mov    ebx,eax
     5c0:	bf 20 00 00 00       	mov    edi,0x20
     5c5:	e8 7e fa ff ff       	call   48 <inb>
     5ca:	0f b6 c0             	movzx  eax,al
     5cd:	09 d8                	or     eax,ebx
}
     5cf:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     5d3:	c9                   	leave
     5d4:	c3                   	ret

00000000000005d5 <pic_get_isr>:
{
     5d5:	55                   	push   rbp
     5d6:	48 89 e5             	mov    rbp,rsp
     5d9:	53                   	push   rbx
		outb(PIC1_COMMAND, 0x0b); /* PIC_READ_ISR */
     5da:	be 0b 00 00 00       	mov    esi,0xb
     5df:	bf 20 00 00 00       	mov    edi,0x20
     5e4:	e8 40 fa ff ff       	call   29 <outb>
		outb(PIC2_COMMAND, 0x0b);
     5e9:	be 0b 00 00 00       	mov    esi,0xb
     5ee:	bf a0 00 00 00       	mov    edi,0xa0
     5f3:	e8 31 fa ff ff       	call   29 <outb>
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
     5f8:	bf a0 00 00 00       	mov    edi,0xa0
     5fd:	e8 46 fa ff ff       	call   48 <inb>
     602:	0f b6 c0             	movzx  eax,al
     605:	c1 e0 08             	shl    eax,0x8
     608:	89 c3                	mov    ebx,eax
     60a:	bf 20 00 00 00       	mov    edi,0x20
     60f:	e8 34 fa ff ff       	call   48 <inb>
     614:	0f b6 c0             	movzx  eax,al
     617:	09 d8                	or     eax,ebx
}
     619:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     61d:	c9                   	leave
     61e:	c3                   	ret

000000000000061f <enable_com>:
{
     61f:	55                   	push   rbp
     620:	48 89 e5             	mov    rbp,rsp
     623:	48 83 ec 08          	sub    rsp,0x8
     627:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
     62a:	89 f0                	mov    eax,esi
     62c:	66 89 45 f8          	mov    WORD PTR [rbp-0x8],ax
		if (!com_present) {
     630:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 636 <enable_com+0x17>
     636:	85 c0                	test   eax,eax
     638:	75 29                	jne    663 <enable_com+0x44>
				com_present = 1;
     63a:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 644 <enable_com+0x25>
				def_port = port;
     644:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     648:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 64f <enable_com+0x30>
				irq_unmask(3);
     64f:	bf 03 00 00 00       	mov    edi,0x3
     654:	e8 00 00 00 00       	call   659 <enable_com+0x3a>
				irq_unmask(4);
     659:	bf 04 00 00 00       	mov    edi,0x4
     65e:	e8 00 00 00 00       	call   663 <enable_com+0x44>
		if (num < 4)
     663:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
     667:	7f 11                	jg     67a <enable_com+0x5b>
				com_ports[num] = port;
     669:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     66c:	48 98                	cdqe
     66e:	0f b7 55 f8          	movzx  edx,WORD PTR [rbp-0x8]
     672:	66 89 94 00 00 00 00 00 	mov    WORD PTR [rax+rax*1+0x0],dx
		outb(port + 1, 0x00); /* disable interrupts */
     67a:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     67e:	83 c0 01             	add    eax,0x1
     681:	0f b7 c0             	movzx  eax,ax
     684:	be 00 00 00 00       	mov    esi,0x0
     689:	89 c7                	mov    edi,eax
     68b:	e8 99 f9 ff ff       	call   29 <outb>
		outb(port + 3, 0x80); /* DLAB enable */
     690:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     694:	83 c0 03             	add    eax,0x3
     697:	0f b7 c0             	movzx  eax,ax
     69a:	be 80 00 00 00       	mov    esi,0x80
     69f:	89 c7                	mov    edi,eax
     6a1:	e8 83 f9 ff ff       	call   29 <outb>
		outb(port + 0, 0x0c); /* baud 9600 (div 12) */
     6a6:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     6aa:	be 0c 00 00 00       	mov    esi,0xc
     6af:	89 c7                	mov    edi,eax
     6b1:	e8 73 f9 ff ff       	call   29 <outb>
		outb(port + 1, 0x00);
     6b6:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     6ba:	83 c0 01             	add    eax,0x1
     6bd:	0f b7 c0             	movzx  eax,ax
     6c0:	be 00 00 00 00       	mov    esi,0x0
     6c5:	89 c7                	mov    edi,eax
     6c7:	e8 5d f9 ff ff       	call   29 <outb>
		outb(port + 3, 0x03); /* DLAB disable, 8+1 bits no parity */
     6cc:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     6d0:	83 c0 03             	add    eax,0x3
     6d3:	0f b7 c0             	movzx  eax,ax
     6d6:	be 03 00 00 00       	mov    esi,0x3
     6db:	89 c7                	mov    edi,eax
     6dd:	e8 47 f9 ff ff       	call   29 <outb>
		outb(port + 2, 0xe7); /* enable FIFO and trigger at 14 bytes and clear */
     6e2:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     6e6:	83 c0 02             	add    eax,0x2
     6e9:	0f b7 c0             	movzx  eax,ax
     6ec:	be e7 00 00 00       	mov    esi,0xe7
     6f1:	89 c7                	mov    edi,eax
     6f3:	e8 31 f9 ff ff       	call   29 <outb>
		outb(port + 4, 0x0b);
     6f8:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     6fc:	83 c0 04             	add    eax,0x4
     6ff:	0f b7 c0             	movzx  eax,ax
     702:	be 0b 00 00 00       	mov    esi,0xb
     707:	89 c7                	mov    edi,eax
     709:	e8 1b f9 ff ff       	call   29 <outb>
		outb(port + 1, 0x07); /* enable buf empty & recv & line status interrupt */
     70e:	0f b7 45 f8          	movzx  eax,WORD PTR [rbp-0x8]
     712:	83 c0 01             	add    eax,0x1
     715:	0f b7 c0             	movzx  eax,ax
     718:	be 07 00 00 00       	mov    esi,0x7
     71d:	89 c7                	mov    edi,eax
     71f:	e8 05 f9 ff ff       	call   29 <outb>
}
     724:	90                   	nop
     725:	c9                   	leave
     726:	c3                   	ret

0000000000000727 <com_interrupt>:
{
     727:	55                   	push   rbp
     728:	48 89 e5             	mov    rbp,rsp
     72b:	48 83 ec 20          	sub    rsp,0x20
     72f:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		for (int i = 0; i < 4; i++) {
     732:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     739:	e9 c7 01 00 00       	jmp    905 <com_interrupt+0x1de>
				port = com_ports[i];
     73e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     741:	48 98                	cdqe
     743:	0f b7 84 00 00 00 00 00 	movzx  eax,WORD PTR [rax+rax*1+0x0]
     74b:	66 89 45 fa          	mov    WORD PTR [rbp-0x6],ax
				if (!port)
     74f:	66 83 7d fa 00       	cmp    WORD PTR [rbp-0x6],0x0
     754:	0f 84 a3 01 00 00    	je     8fd <com_interrupt+0x1d6>
				iir = inb(port + 2);
     75a:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     75e:	83 c0 02             	add    eax,0x2
     761:	0f b7 c0             	movzx  eax,ax
     764:	89 c7                	mov    edi,eax
     766:	e8 dd f8 ff ff       	call   48 <inb>
     76b:	88 45 f9             	mov    BYTE PTR [rbp-0x7],al
				if ((iir & 1)) /* 0 means yes 1 no */
     76e:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     772:	83 e0 01             	and    eax,0x1
     775:	85 c0                	test   eax,eax
     777:	0f 85 83 01 00 00    	jne    900 <com_interrupt+0x1d9>
				if ((iir & 0x0e) == 0x00) /* modem status*/
     77d:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     781:	83 e0 0e             	and    eax,0xe
     784:	85 c0                	test   eax,eax
     786:	75 13                	jne    79b <com_interrupt+0x74>
						inb(port + 6); /* just pop the interrupt */
     788:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     78c:	83 c0 06             	add    eax,0x6
     78f:	0f b7 c0             	movzx  eax,ax
     792:	89 c7                	mov    edi,eax
     794:	e8 af f8 ff ff       	call   48 <inb>
     799:	eb 59                	jmp    7f4 <com_interrupt+0xcd>
				else if ((iir & 0x0e) == 0x02) { /* transmitter empty */
     79b:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     79f:	83 e0 0e             	and    eax,0xe
     7a2:	83 f8 02             	cmp    eax,0x2
     7a5:	74 4d                	je     7f4 <com_interrupt+0xcd>
				} else if ((iir & 0x0e) == 0x04) { /* data available */
     7a7:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     7ab:	83 e0 0e             	and    eax,0xe
     7ae:	83 f8 04             	cmp    eax,0x4
     7b1:	74 41                	je     7f4 <com_interrupt+0xcd>
				} else if ((iir & 0x0e) == 0x06) { /* line status interrupt */
     7b3:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     7b7:	83 e0 0e             	and    eax,0xe
     7ba:	83 f8 06             	cmp    eax,0x6
     7bd:	75 13                	jne    7d2 <com_interrupt+0xab>
						iprintf("line status:\n");
     7bf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     7c6:	b8 00 00 00 00       	mov    eax,0x0
     7cb:	e8 00 00 00 00       	call   7d0 <com_interrupt+0xa9>
     7d0:	eb 22                	jmp    7f4 <com_interrupt+0xcd>
				} else if ((iir & 0x0e) == 0x0c) { /* time out */
     7d2:	0f b6 45 f9          	movzx  eax,BYTE PTR [rbp-0x7]
     7d6:	83 e0 0e             	and    eax,0xe
     7d9:	83 f8 0c             	cmp    eax,0xc
     7dc:	74 16                	je     7f4 <com_interrupt+0xcd>
						iprintf("unknown interrupt on COM%d\n", i);
     7de:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     7e1:	89 c6                	mov    esi,eax
     7e3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     7ea:	b8 00 00 00 00       	mov    eax,0x0
     7ef:	e8 00 00 00 00       	call   7f4 <com_interrupt+0xcd>
				lsr = inb(port + 5);
     7f4:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     7f8:	83 c0 05             	add    eax,0x5
     7fb:	0f b7 c0             	movzx  eax,ax
     7fe:	89 c7                	mov    edi,eax
     800:	e8 43 f8 ff ff       	call   48 <inb>
     805:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
				if (lsr & (1 << 7)) { /* clear fifo */
     808:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     80c:	84 c0                	test   al,al
     80e:	79 18                	jns    828 <com_interrupt+0x101>
						outb(port + 2, 0xc7);
     810:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     814:	83 c0 02             	add    eax,0x2
     817:	0f b7 c0             	movzx  eax,ax
     81a:	be c7 00 00 00       	mov    esi,0xc7
     81f:	89 c7                	mov    edi,eax
     821:	e8 03 f8 ff ff       	call   29 <outb>
     826:	eb 67                	jmp    88f <com_interrupt+0x168>
				} else if (lsr & (1 << 3)) { /* framing error */
     828:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     82c:	83 e0 08             	and    eax,0x8
     82f:	85 c0                	test   eax,eax
     831:	74 18                	je     84b <com_interrupt+0x124>
						iprintf("COM%d framing error\n", i);
     833:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     836:	89 c6                	mov    esi,eax
     838:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     83f:	b8 00 00 00 00       	mov    eax,0x0
     844:	e8 00 00 00 00       	call   849 <com_interrupt+0x122>
     849:	eb 44                	jmp    88f <com_interrupt+0x168>
				} else if (lsr & (1 << 2)) { /* parity error */
     84b:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     84f:	83 e0 04             	and    eax,0x4
     852:	85 c0                	test   eax,eax
     854:	74 18                	je     86e <com_interrupt+0x147>
						iprintf("COM%d parity error\n", i);
     856:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     859:	89 c6                	mov    esi,eax
     85b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     862:	b8 00 00 00 00       	mov    eax,0x0
     867:	e8 00 00 00 00       	call   86c <com_interrupt+0x145>
     86c:	eb 21                	jmp    88f <com_interrupt+0x168>
				} else if (lsr & (1 << 1)) { /* overrun */
     86e:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     872:	83 e0 02             	and    eax,0x2
     875:	85 c0                	test   eax,eax
     877:	74 16                	je     88f <com_interrupt+0x168>
						iprintf("COM%d overrun\n", i);
     879:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     87c:	89 c6                	mov    esi,eax
     87e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     885:	b8 00 00 00 00       	mov    eax,0x0
     88a:	e8 00 00 00 00       	call   88f <com_interrupt+0x168>
				if (lsr & 1) { /* data ready */
     88f:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     893:	83 e0 01             	and    eax,0x1
     896:	85 c0                	test   eax,eax
     898:	74 67                	je     901 <com_interrupt+0x1da>
						iprintf("COM%d data: \"", i);
     89a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     89d:	89 c6                	mov    esi,eax
     89f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     8a6:	b8 00 00 00 00       	mov    eax,0x0
     8ab:	e8 00 00 00 00       	call   8b0 <com_interrupt+0x189>
								char c = inb(port);
     8b0:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     8b4:	89 c7                	mov    edi,eax
     8b6:	e8 8d f7 ff ff       	call   48 <inb>
     8bb:	88 45 f7             	mov    BYTE PTR [rbp-0x9],al
								if (c == 3) { /* TODO: reimplement stub */
     8be:	80 7d f7 03          	cmp    BYTE PTR [rbp-0x9],0x3
     8c2:	74 0b                	je     8cf <com_interrupt+0x1a8>
										putchar(c);
     8c4:	0f be 45 f7          	movsx  eax,BYTE PTR [rbp-0x9]
     8c8:	89 c7                	mov    edi,eax
     8ca:	e8 00 00 00 00       	call   8cf <com_interrupt+0x1a8>
						} while (inb(port + 5) & 1);
     8cf:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     8d3:	83 c0 05             	add    eax,0x5
     8d6:	0f b7 c0             	movzx  eax,ax
     8d9:	89 c7                	mov    edi,eax
     8db:	e8 68 f7 ff ff       	call   48 <inb>
     8e0:	0f b6 c0             	movzx  eax,al
     8e3:	83 e0 01             	and    eax,0x1
     8e6:	85 c0                	test   eax,eax
     8e8:	75 c6                	jne    8b0 <com_interrupt+0x189>
						iprintf("\"\n");
     8ea:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     8f1:	b8 00 00 00 00       	mov    eax,0x0
     8f6:	e8 00 00 00 00       	call   8fb <com_interrupt+0x1d4>
     8fb:	eb 04                	jmp    901 <com_interrupt+0x1da>
						continue;
     8fd:	90                   	nop
     8fe:	eb 01                	jmp    901 <com_interrupt+0x1da>
						continue;
     900:	90                   	nop
		for (int i = 0; i < 4; i++) {
     901:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     905:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
     909:	0f 8e 2f fe ff ff    	jle    73e <com_interrupt+0x17>
}
     90f:	90                   	nop
     910:	90                   	nop
     911:	c9                   	leave
     912:	c3                   	ret

0000000000000913 <com_status>:
{
     913:	55                   	push   rbp
     914:	48 89 e5             	mov    rbp,rsp
     917:	48 83 ec 10          	sub    rsp,0x10
		for (int i = 0; i < 4; i++)
     91b:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     922:	eb 55                	jmp    979 <com_status+0x66>
				if (com_ports[i]) {
     924:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     927:	48 98                	cdqe
     929:	0f b7 84 00 00 00 00 00 	movzx  eax,WORD PTR [rax+rax*1+0x0]
     931:	66 85 c0             	test   ax,ax
     934:	74 3f                	je     975 <com_status+0x62>
						uint16_t port = com_ports[i];
     936:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     939:	48 98                	cdqe
     93b:	0f b7 84 00 00 00 00 00 	movzx  eax,WORD PTR [rax+rax*1+0x0]
     943:	66 89 45 fa          	mov    WORD PTR [rbp-0x6],ax
						lsr = inb(port + 5);
     947:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     94b:	83 c0 05             	add    eax,0x5
     94e:	0f b7 c0             	movzx  eax,ax
     951:	89 c7                	mov    edi,eax
     953:	e8 f0 f6 ff ff       	call   48 <inb>
     958:	88 45 f9             	mov    BYTE PTR [rbp-0x7],al
						printf("COM%d lsr: %08b\n", i, lsr);
     95b:	0f b6 55 f9          	movzx  edx,BYTE PTR [rbp-0x7]
     95f:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     962:	89 c6                	mov    esi,eax
     964:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     96b:	b8 00 00 00 00       	mov    eax,0x0
     970:	e8 00 00 00 00       	call   975 <com_status+0x62>
		for (int i = 0; i < 4; i++)
     975:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     979:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
     97d:	7e a5                	jle    924 <com_status+0x11>
}
     97f:	90                   	nop
     980:	90                   	nop
     981:	c9                   	leave
     982:	c3                   	ret

0000000000000983 <is_transit_empty>:
{
     983:	55                   	push   rbp
     984:	48 89 e5             	mov    rbp,rsp
     987:	48 83 ec 08          	sub    rsp,0x8
     98b:	89 f8                	mov    eax,edi
     98d:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
		return inb(port + 5) & 0x20;
     991:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
     995:	83 c0 05             	add    eax,0x5
     998:	0f b7 c0             	movzx  eax,ax
     99b:	89 c7                	mov    edi,eax
     99d:	e8 a6 f6 ff ff       	call   48 <inb>
     9a2:	0f b6 c0             	movzx  eax,al
     9a5:	83 e0 20             	and    eax,0x20
}
     9a8:	c9                   	leave
     9a9:	c3                   	ret

00000000000009aa <putDebugChar>:
{
     9aa:	55                   	push   rbp
     9ab:	48 89 e5             	mov    rbp,rsp
     9ae:	48 83 ec 08          	sub    rsp,0x8
     9b2:	89 f8                	mov    eax,edi
     9b4:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
		while (!is_transit_empty(def_port));
     9b7:	90                   	nop
     9b8:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9bf <putDebugChar+0x15>
     9bf:	0f b7 c0             	movzx  eax,ax
     9c2:	89 c7                	mov    edi,eax
     9c4:	e8 00 00 00 00       	call   9c9 <putDebugChar+0x1f>
     9c9:	85 c0                	test   eax,eax
     9cb:	74 eb                	je     9b8 <putDebugChar+0xe>
		outb(def_port, c);
     9cd:	0f b6 45 fc          	movzx  eax,BYTE PTR [rbp-0x4]
     9d1:	0f b6 d0             	movzx  edx,al
     9d4:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9db <putDebugChar+0x31>
     9db:	0f b7 c0             	movzx  eax,ax
     9de:	89 d6                	mov    esi,edx
     9e0:	89 c7                	mov    edi,eax
     9e2:	e8 42 f6 ff ff       	call   29 <outb>
}
     9e7:	90                   	nop
     9e8:	c9                   	leave
     9e9:	c3                   	ret

00000000000009ea <serial_received>:
{
     9ea:	55                   	push   rbp
     9eb:	48 89 e5             	mov    rbp,rsp
     9ee:	48 83 ec 08          	sub    rsp,0x8
     9f2:	89 f8                	mov    eax,edi
     9f4:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
		return inb(port + 5) & 1;
     9f8:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
     9fc:	83 c0 05             	add    eax,0x5
     9ff:	0f b7 c0             	movzx  eax,ax
     a02:	89 c7                	mov    edi,eax
     a04:	e8 3f f6 ff ff       	call   48 <inb>
     a09:	0f b6 c0             	movzx  eax,al
     a0c:	83 e0 01             	and    eax,0x1
}
     a0f:	c9                   	leave
     a10:	c3                   	ret

0000000000000a11 <getDebugChar>:
{
     a11:	55                   	push   rbp
     a12:	48 89 e5             	mov    rbp,rsp
		while (!serial_received(def_port));
     a15:	90                   	nop
     a16:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # a1d <getDebugChar+0xc>
     a1d:	0f b7 c0             	movzx  eax,ax
     a20:	89 c7                	mov    edi,eax
     a22:	e8 00 00 00 00       	call   a27 <getDebugChar+0x16>
     a27:	85 c0                	test   eax,eax
     a29:	74 eb                	je     a16 <getDebugChar+0x5>
		return inb(def_port);
     a2b:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # a32 <getDebugChar+0x21>
     a32:	0f b7 c0             	movzx  eax,ax
     a35:	89 c7                	mov    edi,eax
     a37:	e8 0c f6 ff ff       	call   48 <inb>
}
     a3c:	5d                   	pop    rbp
     a3d:	c3                   	ret

0000000000000a3e <forward_irq>:
{
     a3e:	55                   	push   rbp
     a3f:	48 89 e5             	mov    rbp,rsp
     a42:	48 83 ec 20          	sub    rsp,0x20
     a46:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		if (!irq || irq > 15)
     a49:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     a4d:	74 45                	je     a94 <forward_irq+0x56>
     a4f:	83 7d ec 0f          	cmp    DWORD PTR [rbp-0x14],0xf
     a53:	77 3f                	ja     a94 <forward_irq+0x56>
		pt = irq_funs[--irq]; /* 1 based */
     a55:	83 6d ec 01          	sub    DWORD PTR [rbp-0x14],0x1
     a59:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     a5c:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     a64:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (pt) {
     a68:	eb 21                	jmp    a8b <forward_irq+0x4d>
				if (pt->fun(irq + 1)) /* handled */
     a6a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a6e:	48 8b 00             	mov    rax,QWORD PTR [rax]
     a71:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
     a74:	83 c2 01             	add    edx,0x1
     a77:	89 d7                	mov    edi,edx
     a79:	ff d0                	call   rax
     a7b:	85 c0                	test   eax,eax
     a7d:	75 18                	jne    a97 <forward_irq+0x59>
				pt = pt->next;
     a7f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a83:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     a87:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (pt) {
     a8b:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     a90:	75 d8                	jne    a6a <forward_irq+0x2c>
     a92:	eb 04                	jmp    a98 <forward_irq+0x5a>
				return;
     a94:	90                   	nop
     a95:	eb 01                	jmp    a98 <forward_irq+0x5a>
						break;
     a97:	90                   	nop
}
     a98:	c9                   	leave
     a99:	c3                   	ret

0000000000000a9a <install_irq_handler>:
{
     a9a:	55                   	push   rbp
     a9b:	48 89 e5             	mov    rbp,rsp
     a9e:	48 83 ec 20          	sub    rsp,0x20
     aa2:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
     aa5:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		if (!irq || irq > 15)
     aa9:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     aad:	74 06                	je     ab5 <install_irq_handler+0x1b>
     aaf:	83 7d ec 0f          	cmp    DWORD PTR [rbp-0x14],0xf
     ab3:	76 0a                	jbe    abf <install_irq_handler+0x25>
				return 0;
     ab5:	b8 00 00 00 00       	mov    eax,0x0
     aba:	e9 9a 00 00 00       	jmp    b59 <install_irq_handler+0xbf>
		struct irqe* p = kmalloc(sizeof(*p));
     abf:	bf 10 00 00 00       	mov    edi,0x10
     ac4:	e8 00 00 00 00       	call   ac9 <install_irq_handler+0x2f>
     ac9:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!p)
     acd:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     ad2:	75 07                	jne    adb <install_irq_handler+0x41>
				return 0;
     ad4:	b8 00 00 00 00       	mov    eax,0x0
     ad9:	eb 7e                	jmp    b59 <install_irq_handler+0xbf>
		p->fun = fun;
     adb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     adf:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     ae3:	48 89 10             	mov    QWORD PTR [rax],rdx
		if (!irq_funs[irq - 1])
     ae6:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     ae9:	83 e8 01             	sub    eax,0x1
     aec:	89 c0                	mov    eax,eax
     aee:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     af6:	48 85 c0             	test   rax,rax
     af9:	75 0d                	jne    b08 <install_irq_handler+0x6e>
				irq_unmask(irq);
     afb:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     afe:	0f b6 c0             	movzx  eax,al
     b01:	89 c7                	mov    edi,eax
     b03:	e8 00 00 00 00       	call   b08 <install_irq_handler+0x6e>
				p->next = irq_funs[irq - 1];
     b08:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     b0b:	83 e8 01             	sub    eax,0x1
     b0e:	89 c0                	mov    eax,eax
     b10:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
     b18:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b1c:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		} while (!__sync_bool_compare_and_swap(&irq_funs[irq - 1], p->next, p));
     b20:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     b24:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b28:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     b2c:	48 89 c6             	mov    rsi,rax
     b2f:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     b32:	83 e8 01             	sub    eax,0x1
     b35:	89 c0                	mov    eax,eax
     b37:	48 c1 e0 03          	shl    rax,0x3
     b3b:	48 8d 88 00 00 00 00 	lea    rcx,[rax+0x0]
     b42:	48 89 f0             	mov    rax,rsi
     b45:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     b4a:	0f 94 c0             	sete   al
     b4d:	83 f0 01             	xor    eax,0x1
     b50:	84 c0                	test   al,al
     b52:	75 b4                	jne    b08 <install_irq_handler+0x6e>
		return 1;
     b54:	b8 01 00 00 00       	mov    eax,0x1
}
     b59:	c9                   	leave
     b5a:	c3                   	ret

0000000000000b5b <remove_irq_handler>:
{
     b5b:	55                   	push   rbp
     b5c:	48 89 e5             	mov    rbp,rsp
     b5f:	48 83 ec 20          	sub    rsp,0x20
     b63:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
     b66:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		struct irqe* pt, *prev = NULL;
     b6a:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (!irq || irq > 15)
     b72:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     b76:	74 09                	je     b81 <remove_irq_handler+0x26>
     b78:	83 7d ec 0f          	cmp    DWORD PTR [rbp-0x14],0xf
     b7c:	77 03                	ja     b81 <remove_irq_handler+0x26>
start:
     b7e:	90                   	nop
     b7f:	eb 0b                	jmp    b8c <remove_irq_handler+0x31>
				return 0;
     b81:	b8 00 00 00 00       	mov    eax,0x0
     b86:	e9 c2 00 00 00       	jmp    c4d <remove_irq_handler+0xf2>
										goto start;
     b8b:	90                   	nop
		pt = irq_funs[irq - 1];
     b8c:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     b8f:	83 e8 01             	sub    eax,0x1
     b92:	89 c0                	mov    eax,eax
     b94:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     b9c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (pt) {
     ba0:	e9 98 00 00 00       	jmp    c3d <remove_irq_handler+0xe2>
				if (pt->fun == fun) {
     ba5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ba9:	48 8b 00             	mov    rax,QWORD PTR [rax]
     bac:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
     bb0:	75 77                	jne    c29 <remove_irq_handler+0xce>
						if (prev) {
     bb2:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     bb7:	74 28                	je     be1 <remove_irq_handler+0x86>
														pt, pt->next))
     bb9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bbd:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								if (!__sync_bool_compare_and_swap(&prev->next,
     bc1:	48 89 c1             	mov    rcx,rax
     bc4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bc8:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     bcc:	48 83 c2 08          	add    rdx,0x8
     bd0:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     bd5:	0f 94 c0             	sete   al
     bd8:	83 f0 01             	xor    eax,0x1
     bdb:	84 c0                	test   al,al
     bdd:	74 37                	je     c16 <remove_irq_handler+0xbb>
										goto start;
     bdf:	eb ab                	jmp    b8c <remove_irq_handler+0x31>
														pt, pt->next))
     be1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     be5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
								if (!__sync_bool_compare_and_swap(&irq_funs[irq - 1],
     be9:	48 89 c1             	mov    rcx,rax
     bec:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bf0:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
     bf3:	83 ea 01             	sub    edx,0x1
     bf6:	89 d2                	mov    edx,edx
     bf8:	48 c1 e2 03          	shl    rdx,0x3
     bfc:	48 81 c2 00 00 00 00 	add    rdx,0x0
     c03:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     c08:	0f 94 c0             	sete   al
     c0b:	83 f0 01             	xor    eax,0x1
     c0e:	84 c0                	test   al,al
     c10:	0f 85 75 ff ff ff    	jne    b8b <remove_irq_handler+0x30>
						kfree(pt);
     c16:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c1a:	48 89 c7             	mov    rdi,rax
     c1d:	e8 00 00 00 00       	call   c22 <remove_irq_handler+0xc7>
						return 1;
     c22:	b8 01 00 00 00       	mov    eax,0x1
     c27:	eb 24                	jmp    c4d <remove_irq_handler+0xf2>
				prev = pt;
     c29:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c2d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				pt = pt->next;
     c31:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c35:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     c39:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (pt) {
     c3d:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     c42:	0f 85 5d ff ff ff    	jne    ba5 <remove_irq_handler+0x4a>
		return 0;
     c48:	b8 00 00 00 00       	mov    eax,0x0
}
     c4d:	c9                   	leave
     c4e:	c3                   	ret

0000000000000c4f <msi_handler>:
{
     c4f:	55                   	push   rbp
     c50:	48 89 e5             	mov    rbp,rsp
     c53:	48 83 ec 10          	sub    rsp,0x10
     c57:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		iprintf("MSI %u received on processor %u\n", msi, smp_processor_id());
     c5a:	b8 00 00 00 00       	mov    eax,0x0
     c5f:	e8 9c f3 ff ff       	call   0 <per_cpu_ptr>
     c64:	8b 10                	mov    edx,DWORD PTR [rax]
     c66:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     c69:	89 c6                	mov    esi,eax
     c6b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c72:	b8 00 00 00 00       	mov    eax,0x0
     c77:	e8 00 00 00 00       	call   c7c <msi_handler+0x2d>
}
     c7c:	90                   	nop
     c7d:	c9                   	leave
     c7e:	c3                   	ret

0000000000000c7f <irq_handler>:
{
     c7f:	55                   	push   rbp
     c80:	48 89 e5             	mov    rbp,rsp
     c83:	48 83 ec 20          	sub    rsp,0x20
     c87:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		int spurious = 0; void (*hook)();
     c8a:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		if (irq >= 8) { /* check if intr from I/O APIC */
     c91:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     c94:	83 f8 07             	cmp    eax,0x7
     c97:	76 60                	jbe    cf9 <irq_handler+0x7a>
				isr = pic_get_isr();
     c99:	b8 00 00 00 00       	mov    eax,0x0
     c9e:	e8 00 00 00 00       	call   ca3 <irq_handler+0x24>
     ca3:	66 89 45 fa          	mov    WORD PTR [rbp-0x6],ax
				if (!isr) { /* we have a PCI interrupt */
     ca7:	66 83 7d fa 00       	cmp    WORD PTR [rbp-0x6],0x0
     cac:	75 4b                	jne    cf9 <irq_handler+0x7a>
						iprintf("PCI IRQ %u\n", irq);
     cae:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     cb1:	89 c6                	mov    esi,eax
     cb3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     cba:	b8 00 00 00 00       	mov    eax,0x0
     cbf:	e8 00 00 00 00       	call   cc4 <irq_handler+0x45>
						framebuffer_redraw(&fb_initial);
     cc4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     ccb:	e8 00 00 00 00       	call   cd0 <irq_handler+0x51>
						forward_irq(irq);
     cd0:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     cd3:	89 c7                	mov    edi,eax
     cd5:	e8 00 00 00 00       	call   cda <irq_handler+0x5b>
						apic_reg(APIC_REG_EOI) = 0;
     cda:	b8 00 00 00 00       	mov    eax,0x0
     cdf:	e8 1c f3 ff ff       	call   0 <per_cpu_ptr>
     ce4:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     ce8:	48 05 b0 00 00 00    	add    rax,0xb0
     cee:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
						return; /* don't signal the PIC */
     cf4:	e9 0a 01 00 00       	jmp    e03 <irq_handler+0x184>
		switch (irq) {
     cf9:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     cfc:	83 f8 0f             	cmp    eax,0xf
     cff:	0f 87 8c 00 00 00    	ja     d91 <irq_handler+0x112>
     d05:	89 c0                	mov    eax,eax
     d07:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     d0f:	ff e0                	jmp    rax
					if ((hook = irq0_hook))
     d11:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d18 <irq_handler+0x99>
     d18:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     d1c:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     d21:	74 0b                	je     d2e <irq_handler+0xaf>
							hook();
     d23:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     d27:	b8 00 00 00 00       	mov    eax,0x0
     d2c:	ff d2                	call   rdx
					ktimer_tick();
     d2e:	b8 00 00 00 00       	mov    eax,0x0
     d33:	e8 00 00 00 00       	call   d38 <irq_handler+0xb9>
					break;
     d38:	eb 5e                	jmp    d98 <irq_handler+0x119>
					kbd_handler();
     d3a:	b8 00 00 00 00       	mov    eax,0x0
     d3f:	e8 00 00 00 00       	call   d44 <irq_handler+0xc5>
					break;
     d44:	eb 52                	jmp    d98 <irq_handler+0x119>
					com_interrupt(irq);
     d46:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     d49:	89 c7                	mov    edi,eax
     d4b:	e8 00 00 00 00       	call   d50 <irq_handler+0xd1>
					break;
     d50:	eb 46                	jmp    d98 <irq_handler+0x119>
					if (!(pic_get_isr() & (1 << 7)))
     d52:	b8 00 00 00 00       	mov    eax,0x0
     d57:	e8 00 00 00 00       	call   d5c <irq_handler+0xdd>
     d5c:	0f b7 c0             	movzx  eax,ax
     d5f:	25 80 00 00 00       	and    eax,0x80
     d64:	85 c0                	test   eax,eax
     d66:	75 2c                	jne    d94 <irq_handler+0x115>
							spurious = 1;
     d68:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
					break;
     d6f:	eb 23                	jmp    d94 <irq_handler+0x115>
					if (irq == 15 && !(pic_get_isr() & (1 << 15)))
     d71:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     d74:	83 f8 0f             	cmp    eax,0xf
     d77:	75 1e                	jne    d97 <irq_handler+0x118>
     d79:	b8 00 00 00 00       	mov    eax,0x0
     d7e:	e8 00 00 00 00       	call   d83 <irq_handler+0x104>
     d83:	66 85 c0             	test   ax,ax
     d86:	78 0f                	js     d97 <irq_handler+0x118>
							spurious = 1;
     d88:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
					break;
     d8f:	eb 06                	jmp    d97 <irq_handler+0x118>
					break;
     d91:	90                   	nop
     d92:	eb 04                	jmp    d98 <irq_handler+0x119>
					break;
     d94:	90                   	nop
     d95:	eb 01                	jmp    d98 <irq_handler+0x119>
					break;
     d97:	90                   	nop
		if(!spurious && irq > 7) /* ack to slave if needed */
     d98:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     d9c:	75 17                	jne    db5 <irq_handler+0x136>
     d9e:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     da1:	83 f8 07             	cmp    eax,0x7
     da4:	76 0f                	jbe    db5 <irq_handler+0x136>
				outb(PIC2, 0x20);
     da6:	be 20 00 00 00       	mov    esi,0x20
     dab:	bf a0 00 00 00       	mov    edi,0xa0
     db0:	e8 74 f2 ff ff       	call   29 <outb>
		if (!spurious || irq > 7)
     db5:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     db9:	74 08                	je     dc3 <irq_handler+0x144>
     dbb:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     dbe:	83 f8 07             	cmp    eax,0x7
     dc1:	76 0f                	jbe    dd2 <irq_handler+0x153>
				outb(PIC1, 0x20); /* ack interrupt (even sp. from slave) */
     dc3:	be 20 00 00 00       	mov    esi,0x20
     dc8:	bf 20 00 00 00       	mov    edi,0x20
     dcd:	e8 57 f2 ff ff       	call   29 <outb>
		if (!spurious && irq)
     dd2:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     dd6:	75 11                	jne    de9 <irq_handler+0x16a>
     dd8:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     ddb:	85 c0                	test   eax,eax
     ddd:	74 0a                	je     de9 <irq_handler+0x16a>
				forward_irq(irq);
     ddf:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     de2:	89 c7                	mov    edi,eax
     de4:	e8 00 00 00 00       	call   de9 <irq_handler+0x16a>
		if (!irq)
     de9:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     dec:	85 c0                	test   eax,eax
     dee:	75 13                	jne    e03 <irq_handler+0x184>
				task_schedule_isr(*(void**)(&irq + 1));
     df0:	48 8d 45 ec          	lea    rax,[rbp-0x14]
     df4:	48 83 c0 04          	add    rax,0x4
     df8:	48 8b 00             	mov    rax,QWORD PTR [rax]
     dfb:	48 89 c7             	mov    rdi,rax
     dfe:	e8 00 00 00 00       	call   e03 <irq_handler+0x184>
}
     e03:	c9                   	leave
     e04:	c3                   	ret

0000000000000e05 <nmi_handler>:
{
     e05:	55                   	push   rbp
     e06:	48 89 e5             	mov    rbp,rsp
     e09:	48 83 ec 20          	sub    rsp,0x20
     e0d:	89 fa                	mov    edx,edi
     e0f:	89 f0                	mov    eax,esi
     e11:	88 55 ec             	mov    BYTE PTR [rbp-0x14],dl
     e14:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
		if (port_a & 0x10) {
     e17:	0f b6 45 e8          	movzx  eax,BYTE PTR [rbp-0x18]
     e1b:	83 e0 10             	and    eax,0x10
     e1e:	85 c0                	test   eax,eax
     e20:	74 1b                	je     e3d <nmi_handler+0x38>
				printf("NMI watchdog received\n");
     e22:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e29:	b8 00 00 00 00       	mov    eax,0x0
     e2e:	e8 00 00 00 00       	call   e33 <nmi_handler+0x2e>
				return 0;
     e33:	b8 00 00 00 00       	mov    eax,0x0
     e38:	e9 a2 00 00 00       	jmp    edf <nmi_handler+0xda>
		if (port_b & 0x40)
     e3d:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     e41:	83 e0 40             	and    eax,0x40
     e44:	85 c0                	test   eax,eax
     e46:	74 13                	je     e5b <nmi_handler+0x56>
				printf("Hardware bus channel error\n");
     e48:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e4f:	b8 00 00 00 00       	mov    eax,0x0
     e54:	e8 00 00 00 00       	call   e59 <nmi_handler+0x54>
     e59:	eb 36                	jmp    e91 <nmi_handler+0x8c>
		else if (port_b & 0x80)
     e5b:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     e5f:	84 c0                	test   al,al
     e61:	79 13                	jns    e76 <nmi_handler+0x71>
				printf("Memory read/write error\n");
     e63:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e6a:	b8 00 00 00 00       	mov    eax,0x0
     e6f:	e8 00 00 00 00       	call   e74 <nmi_handler+0x6f>
     e74:	eb 1b                	jmp    e91 <nmi_handler+0x8c>
				printf("Unknown NMI error A=%x, B=%x\n", port_a, port_b);
     e76:	0f b6 55 ec          	movzx  edx,BYTE PTR [rbp-0x14]
     e7a:	0f b6 45 e8          	movzx  eax,BYTE PTR [rbp-0x18]
     e7e:	89 c6                	mov    esi,eax
     e80:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e87:	b8 00 00 00 00       	mov    eax,0x0
     e8c:	e8 00 00 00 00       	call   e91 <nmi_handler+0x8c>
		puts("restarting");
     e91:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e98:	e8 00 00 00 00       	call   e9d <nmi_handler+0x98>
		for (i = 0; i < 3; i++) {
     e9d:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     ea4:	eb 24                	jmp    eca <nmi_handler+0xc5>
				for (j = 0; j < INT_MAX; j++);
     ea6:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
     ead:	eb 04                	jmp    eb3 <nmi_handler+0xae>
     eaf:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
     eb3:	81 7d f8 ff ff ff 7f 	cmp    DWORD PTR [rbp-0x8],0x7fffffff
     eba:	75 f3                	jne    eaf <nmi_handler+0xaa>
				putchar('.');
     ebc:	bf 2e 00 00 00       	mov    edi,0x2e
     ec1:	e8 00 00 00 00       	call   ec6 <nmi_handler+0xc1>
		for (i = 0; i < 3; i++) {
     ec6:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     eca:	83 7d fc 02          	cmp    DWORD PTR [rbp-0x4],0x2
     ece:	7e d6                	jle    ea6 <nmi_handler+0xa1>
		putchar('\n');
     ed0:	bf 0a 00 00 00       	mov    edi,0xa
     ed5:	e8 00 00 00 00       	call   eda <nmi_handler+0xd5>
		return 1;
     eda:	b8 01 00 00 00       	mov    eax,0x1
}
     edf:	c9                   	leave
     ee0:	c3                   	ret

0000000000000ee1 <segment_handler>:
{
     ee1:	55                   	push   rbp
     ee2:	48 89 e5             	mov    rbp,rsp
     ee5:	48 83 ec 30          	sub    rsp,0x30
     ee9:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     eed:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
     ef0:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
     ef4:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
		const char* tp = "#UNKNOWN";
     ef7:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		switch(type) {
     eff:	83 7d e0 04          	cmp    DWORD PTR [rbp-0x20],0x4
     f03:	77 3e                	ja     f43 <segment_handler+0x62>
     f05:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
     f08:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     f10:	ff e0                	jmp    rax
				case 0: tp = "#TS"; break;
     f12:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     f1a:	eb 27                	jmp    f43 <segment_handler+0x62>
				case 1: tp = "#NP"; break;
     f1c:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     f24:	eb 1d                	jmp    f43 <segment_handler+0x62>
				case 2: tp = "#SS"; break;
     f26:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     f2e:	eb 13                	jmp    f43 <segment_handler+0x62>
				case 3: tp = "#GP"; break;
     f30:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     f38:	eb 09                	jmp    f43 <segment_handler+0x62>
				case 4: tp = "#PF"; break;
     f3a:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     f42:	90                   	nop
		while (type);
     f43:	90                   	nop
     f44:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
     f48:	75 fa                	jne    f44 <segment_handler+0x63>
		if (type == 4) {
     f4a:	83 7d e0 04          	cmp    DWORD PTR [rbp-0x20],0x4
     f4e:	75 22                	jne    f72 <segment_handler+0x91>
				if(mm_handle_pagefault(&mm_kernel, eip, seg_error, cr2) == 0)
     f50:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
     f54:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
     f57:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     f5b:	48 89 c6             	mov    rsi,rax
     f5e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f65:	e8 00 00 00 00       	call   f6a <segment_handler+0x89>
     f6a:	85 c0                	test   eax,eax
     f6c:	0f 84 0f 01 00 00    	je     1081 <segment_handler+0x1a0>
		cprintf(KFMT_INFO, "Segment exception handler: %s at %p with error %x (cr2=%p)\n",
     f72:	48 8b 75 d8          	mov    rsi,QWORD PTR [rbp-0x28]
     f76:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
     f79:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     f7d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f81:	49 89 f1             	mov    r9,rsi
     f84:	41 89 c8             	mov    r8d,ecx
     f87:	48 89 d1             	mov    rcx,rdx
     f8a:	48 89 c2             	mov    rdx,rax
     f8d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f94:	bf 0b 00 00 00       	mov    edi,0xb
     f99:	b8 00 00 00 00       	mov    eax,0x0
     f9e:	e8 00 00 00 00       	call   fa3 <segment_handler+0xc2>
		if (seg_error != 4) {
     fa3:	83 7d e4 04          	cmp    DWORD PTR [rbp-0x1c],0x4
     fa7:	0f 84 a4 00 00 00    	je     1051 <segment_handler+0x170>
					  (seg_error & 0xffff8) >> 3);
     fad:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     fb0:	c1 e8 03             	shr    eax,0x3
				printf("The segment error originated %s and"
     fb3:	25 ff ff 01 00       	and    eax,0x1ffff
     fb8:	89 c2                	mov    edx,eax
						(seg_error & 2) ? "interrupt" : ((seg_error & 4) ? "local" : "global"),
     fba:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     fbd:	83 e0 02             	and    eax,0x2
				printf("The segment error originated %s and"
     fc0:	85 c0                	test   eax,eax
     fc2:	75 1c                	jne    fe0 <segment_handler+0xff>
						(seg_error & 2) ? "interrupt" : ((seg_error & 4) ? "local" : "global"),
     fc4:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     fc7:	83 e0 04             	and    eax,0x4
     fca:	85 c0                	test   eax,eax
     fcc:	74 09                	je     fd7 <segment_handler+0xf6>
     fce:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     fd5:	eb 10                	jmp    fe7 <segment_handler+0x106>
     fd7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     fde:	eb 07                	jmp    fe7 <segment_handler+0x106>
				printf("The segment error originated %s and"
     fe0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
						(seg_error & 1) ? "external" : "internal",
     fe7:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
     fea:	83 e1 01             	and    ecx,0x1
				printf("The segment error originated %s and"
     fed:	85 c9                	test   ecx,ecx
     fef:	74 09                	je     ffa <segment_handler+0x119>
     ff1:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     ff8:	eb 07                	jmp    1001 <segment_handler+0x120>
     ffa:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1001:	89 d1                	mov    ecx,edx
    1003:	48 89 c2             	mov    rdx,rax
    1006:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    100d:	b8 00 00 00 00       	mov    eax,0x0
    1012:	e8 00 00 00 00       	call   1017 <segment_handler+0x136>
				print_stacktrace();
    1017:	b8 00 00 00 00       	mov    eax,0x0
    101c:	e8 00 00 00 00       	call   1021 <segment_handler+0x140>
				die("segment death\n");
    1021:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1028:	bf 0c 00 00 00       	mov    edi,0xc
    102d:	b8 00 00 00 00       	mov    eax,0x0
    1032:	e8 00 00 00 00       	call   1037 <segment_handler+0x156>
    1037:	b8 00 00 00 00       	mov    eax,0x0
    103c:	e8 00 00 00 00       	call   1041 <segment_handler+0x160>
    1041:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1048:	e8 00 00 00 00       	call   104d <segment_handler+0x16c>
    104d:	fa                   	cli
    104e:	f4                   	hlt
    104f:	eb fd                	jmp    104e <segment_handler+0x16d>
				die("unfixable #PF\n");
    1051:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1058:	bf 0c 00 00 00       	mov    edi,0xc
    105d:	b8 00 00 00 00       	mov    eax,0x0
    1062:	e8 00 00 00 00       	call   1067 <segment_handler+0x186>
    1067:	b8 00 00 00 00       	mov    eax,0x0
    106c:	e8 00 00 00 00       	call   1071 <segment_handler+0x190>
    1071:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1078:	e8 00 00 00 00       	call   107d <segment_handler+0x19c>
    107d:	fa                   	cli
    107e:	f4                   	hlt
    107f:	eb fd                	jmp    107e <segment_handler+0x19d>
						return; /* continue execution */
    1081:	90                   	nop
}
    1082:	c9                   	leave
    1083:	c3                   	ret

0000000000001084 <PIC_remap>:
{
    1084:	55                   	push   rbp
    1085:	48 89 e5             	mov    rbp,rsp
    1088:	48 83 ec 20          	sub    rsp,0x20
    108c:	89 fa                	mov    edx,edi
    108e:	89 f0                	mov    eax,esi
    1090:	88 55 ec             	mov    BYTE PTR [rbp-0x14],dl
    1093:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
		a1 = inb(PIC1_DATA);                      /* save the masks */
    1096:	bf 21 00 00 00       	mov    edi,0x21
    109b:	e8 a8 ef ff ff       	call   48 <inb>
    10a0:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
		a2 = inb(PIC2_DATA);
    10a3:	bf a1 00 00 00       	mov    edi,0xa1
    10a8:	e8 9b ef ff ff       	call   48 <inb>
    10ad:	88 45 fe             	mov    BYTE PTR [rbp-0x2],al
		outb(PIC1_COMMAND, ICW1_INIT+ICW1_ICW4);  /* start the initialization */
    10b0:	be 11 00 00 00       	mov    esi,0x11
    10b5:	bf 20 00 00 00       	mov    edi,0x20
    10ba:	e8 6a ef ff ff       	call   29 <outb>
		io_wait();                                /* expects 3 control bytes */
    10bf:	b8 00 00 00 00       	mov    eax,0x0
    10c4:	e8 52 ef ff ff       	call   1b <io_wait>
		outb(PIC2_COMMAND, ICW1_INIT+ICW1_ICW4);
    10c9:	be 11 00 00 00       	mov    esi,0x11
    10ce:	bf a0 00 00 00       	mov    edi,0xa0
    10d3:	e8 51 ef ff ff       	call   29 <outb>
		io_wait();
    10d8:	b8 00 00 00 00       	mov    eax,0x0
    10dd:	e8 39 ef ff ff       	call   1b <io_wait>
		outb(PIC1_DATA, ofs1);                    /* master gate offset */
    10e2:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
    10e6:	89 c6                	mov    esi,eax
    10e8:	bf 21 00 00 00       	mov    edi,0x21
    10ed:	e8 37 ef ff ff       	call   29 <outb>
		io_wait();
    10f2:	b8 00 00 00 00       	mov    eax,0x0
    10f7:	e8 1f ef ff ff       	call   1b <io_wait>
		outb(PIC2_DATA, ofs2);                    /* slave gate offset */
    10fc:	0f b6 45 e8          	movzx  eax,BYTE PTR [rbp-0x18]
    1100:	89 c6                	mov    esi,eax
    1102:	bf a1 00 00 00       	mov    edi,0xa1
    1107:	e8 1d ef ff ff       	call   29 <outb>
		io_wait();
    110c:	b8 00 00 00 00       	mov    eax,0x0
    1111:	e8 05 ef ff ff       	call   1b <io_wait>
		outb(PIC1_DATA, 4);                       /* tell master of the presence */
    1116:	be 04 00 00 00       	mov    esi,0x4
    111b:	bf 21 00 00 00       	mov    edi,0x21
    1120:	e8 04 ef ff ff       	call   29 <outb>
		io_wait();                                /* of slave at IRQ2 (1<<2) */
    1125:	b8 00 00 00 00       	mov    eax,0x0
    112a:	e8 ec ee ff ff       	call   1b <io_wait>
		outb(PIC2_DATA, 2);                       /* tell slave it's second */
    112f:	be 02 00 00 00       	mov    esi,0x2
    1134:	bf a1 00 00 00       	mov    edi,0xa1
    1139:	e8 eb ee ff ff       	call   29 <outb>
		io_wait();                                /* in cascade */
    113e:	b8 00 00 00 00       	mov    eax,0x0
    1143:	e8 d3 ee ff ff       	call   1b <io_wait>
		outb(PIC1_DATA, ICW4_8086);               /* master in standard mode */
    1148:	be 01 00 00 00       	mov    esi,0x1
    114d:	bf 21 00 00 00       	mov    edi,0x21
    1152:	e8 d2 ee ff ff       	call   29 <outb>
		io_wait();
    1157:	b8 00 00 00 00       	mov    eax,0x0
    115c:	e8 ba ee ff ff       	call   1b <io_wait>
		outb(PIC2_DATA, ICW4_8086);               /* slave in standard mode */
    1161:	be 01 00 00 00       	mov    esi,0x1
    1166:	bf a1 00 00 00       	mov    edi,0xa1
    116b:	e8 b9 ee ff ff       	call   29 <outb>
		io_wait();
    1170:	b8 00 00 00 00       	mov    eax,0x0
    1175:	e8 a1 ee ff ff       	call   1b <io_wait>
		outb(PIC1_DATA, a1);                      /* restore saved masks */
    117a:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    117e:	89 c6                	mov    esi,eax
    1180:	bf 21 00 00 00       	mov    edi,0x21
    1185:	e8 9f ee ff ff       	call   29 <outb>
		outb(PIC2_DATA, a2);
    118a:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2]
    118e:	89 c6                	mov    esi,eax
    1190:	bf a1 00 00 00       	mov    edi,0xa1
    1195:	e8 8f ee ff ff       	call   29 <outb>
		cprintf(KFMT_INFO, "PICs remapped to %x and %x with masks %x and %x\n",
    119a:	0f b6 75 fe          	movzx  esi,BYTE PTR [rbp-0x2]
    119e:	0f b6 4d ff          	movzx  ecx,BYTE PTR [rbp-0x1]
    11a2:	0f b6 55 e8          	movzx  edx,BYTE PTR [rbp-0x18]
    11a6:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
    11aa:	41 89 f1             	mov    r9d,esi
    11ad:	41 89 c8             	mov    r8d,ecx
    11b0:	89 d1                	mov    ecx,edx
    11b2:	89 c2                	mov    edx,eax
    11b4:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    11bb:	bf 0b 00 00 00       	mov    edi,0xb
    11c0:	b8 00 00 00 00       	mov    eax,0x0
    11c5:	e8 00 00 00 00       	call   11ca <PIC_remap+0x146>
}
    11ca:	90                   	nop
    11cb:	c9                   	leave
    11cc:	c3                   	ret

00000000000011cd <cmos_is_updating>:
{
    11cd:	55                   	push   rbp
    11ce:	48 89 e5             	mov    rbp,rsp
		outb(CMOS_CH_INDEX, 0x0a);
    11d1:	be 0a 00 00 00       	mov    esi,0xa
    11d6:	bf 70 00 00 00       	mov    edi,0x70
    11db:	e8 49 ee ff ff       	call   29 <outb>
		return inb(CMOS_CH_DATA) & 0x80;
    11e0:	bf 71 00 00 00       	mov    edi,0x71
    11e5:	e8 5e ee ff ff       	call   48 <inb>
    11ea:	0f b6 c0             	movzx  eax,al
    11ed:	25 80 00 00 00       	and    eax,0x80
}
    11f2:	5d                   	pop    rbp
    11f3:	c3                   	ret

00000000000011f4 <cmos_get_register>:
{
    11f4:	55                   	push   rbp
    11f5:	48 89 e5             	mov    rbp,rsp
    11f8:	48 83 ec 08          	sub    rsp,0x8
    11fc:	89 f8                	mov    eax,edi
    11fe:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
		outb(CMOS_CH_INDEX, reg);
    1201:	0f b6 45 fc          	movzx  eax,BYTE PTR [rbp-0x4]
    1205:	89 c6                	mov    esi,eax
    1207:	bf 70 00 00 00       	mov    edi,0x70
    120c:	e8 18 ee ff ff       	call   29 <outb>
		return inb(CMOS_CH_DATA);
    1211:	bf 71 00 00 00       	mov    edi,0x71
    1216:	e8 2d ee ff ff       	call   48 <inb>
}
    121b:	c9                   	leave
    121c:	c3                   	ret

000000000000121d <cmos_get_time>:
{
    121d:	55                   	push   rbp
    121e:	48 89 e5             	mov    rbp,rsp
    1221:	48 83 ec 68          	sub    rsp,0x68
    1225:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
		struct tm rv = {0}, rvb = {0};
    1229:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    1231:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    1239:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    1241:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    1249:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
    1250:	48 c7 45 ac 00 00 00 00 	mov    QWORD PTR [rbp-0x54],0x0
    1258:	48 c7 45 b4 00 00 00 00 	mov    QWORD PTR [rbp-0x4c],0x0
    1260:	48 c7 45 bc 00 00 00 00 	mov    QWORD PTR [rbp-0x44],0x0
    1268:	48 c7 45 c4 00 00 00 00 	mov    QWORD PTR [rbp-0x3c],0x0
    1270:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0
		struct tm* pt = &rv; uint8_t regB;
    1277:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    127b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				while (cmos_is_updating()); /* busy spin (maybe called by ihander */
    127f:	90                   	nop
    1280:	b8 00 00 00 00       	mov    eax,0x0
    1285:	e8 00 00 00 00       	call   128a <cmos_get_time+0x6d>
    128a:	85 c0                	test   eax,eax
    128c:	75 f2                	jne    1280 <cmos_get_time+0x63>
				pt->tm_sec = cmos_get_register(0);
    128e:	bf 00 00 00 00       	mov    edi,0x0
    1293:	e8 00 00 00 00       	call   1298 <cmos_get_time+0x7b>
    1298:	0f b6 d0             	movzx  edx,al
    129b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    129f:	89 10                	mov    DWORD PTR [rax],edx
				pt->tm_min = cmos_get_register(2);
    12a1:	bf 02 00 00 00       	mov    edi,0x2
    12a6:	e8 00 00 00 00       	call   12ab <cmos_get_time+0x8e>
    12ab:	0f b6 d0             	movzx  edx,al
    12ae:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12b2:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
				pt->tm_hour = cmos_get_register(4);
    12b5:	bf 04 00 00 00       	mov    edi,0x4
    12ba:	e8 00 00 00 00       	call   12bf <cmos_get_time+0xa2>
    12bf:	0f b6 d0             	movzx  edx,al
    12c2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12c6:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
				pt->tm_wday = cmos_get_register(6);// - 1;
    12c9:	bf 06 00 00 00       	mov    edi,0x6
    12ce:	e8 00 00 00 00       	call   12d3 <cmos_get_time+0xb6>
    12d3:	0f b6 d0             	movzx  edx,al
    12d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12da:	89 50 18             	mov    DWORD PTR [rax+0x18],edx
				pt->tm_mday = cmos_get_register(7);
    12dd:	bf 07 00 00 00       	mov    edi,0x7
    12e2:	e8 00 00 00 00       	call   12e7 <cmos_get_time+0xca>
    12e7:	0f b6 d0             	movzx  edx,al
    12ea:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12ee:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
				pt->tm_mon = cmos_get_register(8);
    12f1:	bf 08 00 00 00       	mov    edi,0x8
    12f6:	e8 00 00 00 00       	call   12fb <cmos_get_time+0xde>
    12fb:	0f b6 d0             	movzx  edx,al
    12fe:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1302:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
				pt->tm_year = cmos_get_register(9);
    1305:	bf 09 00 00 00       	mov    edi,0x9
    130a:	e8 00 00 00 00       	call   130f <cmos_get_time+0xf2>
    130f:	0f b6 d0             	movzx  edx,al
    1312:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1316:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
				pt->tm_year |= (cmos_get_register(0x32) << 8); /* century or bogus data */
    1319:	bf 32 00 00 00       	mov    edi,0x32
    131e:	e8 00 00 00 00       	call   1323 <cmos_get_time+0x106>
    1323:	0f b6 c0             	movzx  eax,al
    1326:	c1 e0 08             	shl    eax,0x8
    1329:	89 c2                	mov    edx,eax
    132b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    132f:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    1332:	09 c2                	or     edx,eax
    1334:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1338:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
				if (pt == &rv)
    133b:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    133f:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    1343:	75 0d                	jne    1352 <cmos_get_time+0x135>
						pt = &rvb;
    1345:	48 8d 45 ac          	lea    rax,[rbp-0x54]
    1349:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    134d:	e9 2d ff ff ff       	jmp    127f <cmos_get_time+0x62>
				else if (rv.tm_sec != rvb.tm_sec ||
    1352:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    1355:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    1358:	39 c2                	cmp    edx,eax
    135a:	75 3c                	jne    1398 <cmos_get_time+0x17b>
								rv.tm_min != rvb.tm_min ||
    135c:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    135f:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
				else if (rv.tm_sec != rvb.tm_sec ||
    1362:	39 c2                	cmp    edx,eax
    1364:	75 32                	jne    1398 <cmos_get_time+0x17b>
								rv.tm_hour != rvb.tm_hour ||
    1366:	8b 55 d8             	mov    edx,DWORD PTR [rbp-0x28]
    1369:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
								rv.tm_min != rvb.tm_min ||
    136c:	39 c2                	cmp    edx,eax
    136e:	75 28                	jne    1398 <cmos_get_time+0x17b>
								rv.tm_wday != rvb.tm_wday ||
    1370:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    1373:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
								rv.tm_hour != rvb.tm_hour ||
    1376:	39 c2                	cmp    edx,eax
    1378:	75 1e                	jne    1398 <cmos_get_time+0x17b>
								rv.tm_mday != rvb.tm_mday ||
    137a:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    137d:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
								rv.tm_wday != rvb.tm_wday ||
    1380:	39 c2                	cmp    edx,eax
    1382:	75 14                	jne    1398 <cmos_get_time+0x17b>
								rv.tm_mon != rvb.tm_mon ||
    1384:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
    1387:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
								rv.tm_mday != rvb.tm_mday ||
    138a:	39 c2                	cmp    edx,eax
    138c:	75 0a                	jne    1398 <cmos_get_time+0x17b>
								rv.tm_year != rvb.tm_year)
    138e:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    1391:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
								rv.tm_mon != rvb.tm_mon ||
    1394:	39 c2                	cmp    edx,eax
    1396:	74 0d                	je     13a5 <cmos_get_time+0x188>
						pt = &rv;
    1398:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    139c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				while (cmos_is_updating()); /* busy spin (maybe called by ihander */
    13a0:	e9 da fe ff ff       	jmp    127f <cmos_get_time+0x62>
		regB = cmos_get_register(0x0b);
    13a5:	bf 0b 00 00 00       	mov    edi,0xb
    13aa:	e8 00 00 00 00       	call   13af <cmos_get_time+0x192>
    13af:	88 45 f7             	mov    BYTE PTR [rbp-0x9],al
		if (!(regB & 0x04)) {
    13b2:	0f b6 45 f7          	movzx  eax,BYTE PTR [rbp-0x9]
    13b6:	83 e0 04             	and    eax,0x4
    13b9:	85 c0                	test   eax,eax
    13bb:	0f 85 a1 01 00 00    	jne    1562 <cmos_get_time+0x345>
				pt->tm_sec = (pt->tm_sec & 0xf) + ((pt->tm_sec / 16) * 10);
    13c1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13c5:	8b 00                	mov    eax,DWORD PTR [rax]
    13c7:	83 e0 0f             	and    eax,0xf
    13ca:	89 c1                	mov    ecx,eax
    13cc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13d0:	8b 00                	mov    eax,DWORD PTR [rax]
    13d2:	8d 50 0f             	lea    edx,[rax+0xf]
    13d5:	85 c0                	test   eax,eax
    13d7:	0f 48 c2             	cmovs  eax,edx
    13da:	c1 f8 04             	sar    eax,0x4
    13dd:	89 c2                	mov    edx,eax
    13df:	89 d0                	mov    eax,edx
    13e1:	c1 e0 02             	shl    eax,0x2
    13e4:	01 d0                	add    eax,edx
    13e6:	01 c0                	add    eax,eax
    13e8:	8d 14 01             	lea    edx,[rcx+rax*1]
    13eb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13ef:	89 10                	mov    DWORD PTR [rax],edx
				pt->tm_min = (pt->tm_min & 0xf) + ((pt->tm_min / 16) * 10);
    13f1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13f5:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    13f8:	83 e0 0f             	and    eax,0xf
    13fb:	89 c1                	mov    ecx,eax
    13fd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1401:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1404:	8d 50 0f             	lea    edx,[rax+0xf]
    1407:	85 c0                	test   eax,eax
    1409:	0f 48 c2             	cmovs  eax,edx
    140c:	c1 f8 04             	sar    eax,0x4
    140f:	89 c2                	mov    edx,eax
    1411:	89 d0                	mov    eax,edx
    1413:	c1 e0 02             	shl    eax,0x2
    1416:	01 d0                	add    eax,edx
    1418:	01 c0                	add    eax,eax
    141a:	8d 14 01             	lea    edx,[rcx+rax*1]
    141d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1421:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
				pt->tm_hour = (pt->tm_hour & 0x80) | ((pt->tm_hour & 0xf) + (((pt->tm_hour & 0x70) / 16) * 10));
    1424:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1428:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    142b:	25 80 00 00 00       	and    eax,0x80
    1430:	89 c1                	mov    ecx,eax
    1432:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1436:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1439:	83 e0 0f             	and    eax,0xf
    143c:	89 c6                	mov    esi,eax
    143e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1442:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1445:	83 e0 70             	and    eax,0x70
    1448:	8d 50 0f             	lea    edx,[rax+0xf]
    144b:	85 c0                	test   eax,eax
    144d:	0f 48 c2             	cmovs  eax,edx
    1450:	c1 f8 04             	sar    eax,0x4
    1453:	89 c2                	mov    edx,eax
    1455:	89 d0                	mov    eax,edx
    1457:	c1 e0 02             	shl    eax,0x2
    145a:	01 d0                	add    eax,edx
    145c:	01 c0                	add    eax,eax
    145e:	01 f0                	add    eax,esi
    1460:	09 c1                	or     ecx,eax
    1462:	89 ca                	mov    edx,ecx
    1464:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1468:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
				pt->tm_wday = (pt->tm_wday & 0xf) + ((pt->tm_wday / 16) * 10);
    146b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    146f:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1472:	83 e0 0f             	and    eax,0xf
    1475:	89 c1                	mov    ecx,eax
    1477:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    147b:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    147e:	8d 50 0f             	lea    edx,[rax+0xf]
    1481:	85 c0                	test   eax,eax
    1483:	0f 48 c2             	cmovs  eax,edx
    1486:	c1 f8 04             	sar    eax,0x4
    1489:	89 c2                	mov    edx,eax
    148b:	89 d0                	mov    eax,edx
    148d:	c1 e0 02             	shl    eax,0x2
    1490:	01 d0                	add    eax,edx
    1492:	01 c0                	add    eax,eax
    1494:	8d 14 01             	lea    edx,[rcx+rax*1]
    1497:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    149b:	89 50 18             	mov    DWORD PTR [rax+0x18],edx
				pt->tm_mday = (pt->tm_mday & 0xf) + ((pt->tm_mday / 16) * 10);
    149e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14a2:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    14a5:	83 e0 0f             	and    eax,0xf
    14a8:	89 c1                	mov    ecx,eax
    14aa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14ae:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    14b1:	8d 50 0f             	lea    edx,[rax+0xf]
    14b4:	85 c0                	test   eax,eax
    14b6:	0f 48 c2             	cmovs  eax,edx
    14b9:	c1 f8 04             	sar    eax,0x4
    14bc:	89 c2                	mov    edx,eax
    14be:	89 d0                	mov    eax,edx
    14c0:	c1 e0 02             	shl    eax,0x2
    14c3:	01 d0                	add    eax,edx
    14c5:	01 c0                	add    eax,eax
    14c7:	8d 14 01             	lea    edx,[rcx+rax*1]
    14ca:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14ce:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
				pt->tm_mon = (pt->tm_mon & 0xf) + ((pt->tm_mon / 16) * 10);
    14d1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14d5:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    14d8:	83 e0 0f             	and    eax,0xf
    14db:	89 c1                	mov    ecx,eax
    14dd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14e1:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    14e4:	8d 50 0f             	lea    edx,[rax+0xf]
    14e7:	85 c0                	test   eax,eax
    14e9:	0f 48 c2             	cmovs  eax,edx
    14ec:	c1 f8 04             	sar    eax,0x4
    14ef:	89 c2                	mov    edx,eax
    14f1:	89 d0                	mov    eax,edx
    14f3:	c1 e0 02             	shl    eax,0x2
    14f6:	01 d0                	add    eax,edx
    14f8:	01 c0                	add    eax,eax
    14fa:	8d 14 01             	lea    edx,[rcx+rax*1]
    14fd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1501:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
				pt->tm_year = ((pt->tm_year & 0xf) + ((pt->tm_year / 16) * 10))
    1504:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1508:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    150b:	83 e0 0f             	and    eax,0xf
    150e:	89 c1                	mov    ecx,eax
    1510:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1514:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    1517:	8d 50 0f             	lea    edx,[rax+0xf]
    151a:	85 c0                	test   eax,eax
    151c:	0f 48 c2             	cmovs  eax,edx
    151f:	c1 f8 04             	sar    eax,0x4
    1522:	89 c2                	mov    edx,eax
    1524:	89 d0                	mov    eax,edx
    1526:	c1 e0 02             	shl    eax,0x2
    1529:	01 d0                	add    eax,edx
    152b:	01 c0                	add    eax,eax
    152d:	01 c1                	add    ecx,eax
						| ((((pt->tm_year & 0xf) >> 8) + ((((pt->tm_year & 0xf000) >> 8) / 16) * 10)) << 8);
    152f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1533:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    1536:	c1 f8 08             	sar    eax,0x8
    1539:	25 f0 00 00 00       	and    eax,0xf0
    153e:	8d 50 0f             	lea    edx,[rax+0xf]
    1541:	85 c0                	test   eax,eax
    1543:	0f 48 c2             	cmovs  eax,edx
    1546:	c1 f8 04             	sar    eax,0x4
    1549:	89 c2                	mov    edx,eax
    154b:	89 d0                	mov    eax,edx
    154d:	c1 e0 02             	shl    eax,0x2
    1550:	01 d0                	add    eax,edx
    1552:	01 c0                	add    eax,eax
    1554:	c1 e0 08             	shl    eax,0x8
    1557:	09 c1                	or     ecx,eax
    1559:	89 ca                	mov    edx,ecx
				pt->tm_year = ((pt->tm_year & 0xf) + ((pt->tm_year / 16) * 10))
    155b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    155f:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
		if (!(regB & 0x02) && (pt->tm_hour & 0x80))
    1562:	0f b6 45 f7          	movzx  eax,BYTE PTR [rbp-0x9]
    1566:	83 e0 02             	and    eax,0x2
    1569:	85 c0                	test   eax,eax
    156b:	75 4b                	jne    15b8 <cmos_get_time+0x39b>
    156d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1571:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1574:	25 80 00 00 00       	and    eax,0x80
    1579:	85 c0                	test   eax,eax
    157b:	74 3b                	je     15b8 <cmos_get_time+0x39b>
				pt->tm_hour = (((pt->tm_hour & 0x7f) + 12) % 24);
    157d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1581:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1584:	83 e0 7f             	and    eax,0x7f
    1587:	8d 48 0c             	lea    ecx,[rax+0xc]
    158a:	48 63 c1             	movsxd rax,ecx
    158d:	48 69 c0 ab aa aa 2a 	imul   rax,rax,0x2aaaaaab
    1594:	48 c1 e8 20          	shr    rax,0x20
    1598:	89 c2                	mov    edx,eax
    159a:	c1 fa 02             	sar    edx,0x2
    159d:	89 c8                	mov    eax,ecx
    159f:	c1 f8 1f             	sar    eax,0x1f
    15a2:	29 c2                	sub    edx,eax
    15a4:	89 d0                	mov    eax,edx
    15a6:	01 c0                	add    eax,eax
    15a8:	01 d0                	add    eax,edx
    15aa:	c1 e0 03             	shl    eax,0x3
    15ad:	29 c1                	sub    ecx,eax
    15af:	89 ca                	mov    edx,ecx
    15b1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15b5:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
		pt->tm_year = 100 * ((pt->tm_year & 0xff00) >> 8) + (pt->tm_year & 0xff);
    15b8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15bc:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    15bf:	c1 f8 08             	sar    eax,0x8
    15c2:	0f b6 c0             	movzx  eax,al
    15c5:	6b d0 64             	imul   edx,eax,0x64
    15c8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15cc:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    15cf:	0f b6 c0             	movzx  eax,al
    15d2:	01 c2                	add    edx,eax
    15d4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15d8:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
		pt->tm_year -= 1900;
    15db:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15df:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    15e2:	8d 90 94 f8 ff ff    	lea    edx,[rax-0x76c]
    15e8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15ec:	89 50 14             	mov    DWORD PTR [rax+0x14],edx
		pt->tm_yday = pt->tm_mday - 1;
    15ef:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15f3:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    15f6:	8d 50 ff             	lea    edx,[rax-0x1]
    15f9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15fd:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
		pt->tm_mon -= 1;
    1600:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1604:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1607:	8d 50 ff             	lea    edx,[rax-0x1]
    160a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    160e:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		if (IS_LEAP_YEAR(pt->tm_year + 1900))
    1611:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1615:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    1618:	3d 95 f8 ff ff       	cmp    eax,0xfffff895
    161d:	0f 8c 9c 00 00 00    	jl     16bf <cmos_get_time+0x4a2>
    1623:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1627:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    162a:	05 6c 07 00 00       	add    eax,0x76c
    162f:	83 e0 03             	and    eax,0x3
    1632:	85 c0                	test   eax,eax
    1634:	0f 85 85 00 00 00    	jne    16bf <cmos_get_time+0x4a2>
    163a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    163e:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    1641:	8d 90 6c 07 00 00    	lea    edx,[rax+0x76c]
    1647:	48 63 c2             	movsxd rax,edx
    164a:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    1651:	48 c1 e8 20          	shr    rax,0x20
    1655:	c1 f8 05             	sar    eax,0x5
    1658:	89 d1                	mov    ecx,edx
    165a:	c1 f9 1f             	sar    ecx,0x1f
    165d:	29 c8                	sub    eax,ecx
    165f:	6b c8 64             	imul   ecx,eax,0x64
    1662:	89 d0                	mov    eax,edx
    1664:	29 c8                	sub    eax,ecx
    1666:	85 c0                	test   eax,eax
    1668:	75 33                	jne    169d <cmos_get_time+0x480>
    166a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    166e:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    1671:	8d 90 6c 07 00 00    	lea    edx,[rax+0x76c]
    1677:	48 63 c2             	movsxd rax,edx
    167a:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    1681:	48 c1 e8 20          	shr    rax,0x20
    1685:	c1 f8 07             	sar    eax,0x7
    1688:	89 d1                	mov    ecx,edx
    168a:	c1 f9 1f             	sar    ecx,0x1f
    168d:	29 c8                	sub    eax,ecx
    168f:	69 c8 90 01 00 00    	imul   ecx,eax,0x190
    1695:	89 d0                	mov    eax,edx
    1697:	29 c8                	sub    eax,ecx
    1699:	85 c0                	test   eax,eax
    169b:	75 22                	jne    16bf <cmos_get_time+0x4a2>
				pt->tm_yday += dayct_lp[pt->tm_mon];
    169d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16a1:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    16a4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16a8:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    16ab:	48 98                	cdqe
    16ad:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
    16b4:	01 c2                	add    edx,eax
    16b6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16ba:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
    16bd:	eb 20                	jmp    16df <cmos_get_time+0x4c2>
				pt->tm_yday += dayct_nl[pt->tm_mon];
    16bf:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16c3:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    16c6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16ca:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    16cd:	48 98                	cdqe
    16cf:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
    16d6:	01 c2                	add    edx,eax
    16d8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16dc:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
		return *pt;
    16df:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    16e3:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    16e7:	48 8b 0a             	mov    rcx,QWORD PTR [rdx]
    16ea:	48 89 08             	mov    QWORD PTR [rax],rcx
    16ed:	48 8b 4a 08          	mov    rcx,QWORD PTR [rdx+0x8]
    16f1:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
    16f5:	48 8b 4a 10          	mov    rcx,QWORD PTR [rdx+0x10]
    16f9:	48 89 48 10          	mov    QWORD PTR [rax+0x10],rcx
    16fd:	48 8b 4a 18          	mov    rcx,QWORD PTR [rdx+0x18]
    1701:	48 89 48 18          	mov    QWORD PTR [rax+0x18],rcx
    1705:	8b 52 20             	mov    edx,DWORD PTR [rdx+0x20]
    1708:	89 50 20             	mov    DWORD PTR [rax+0x20],edx
}
    170b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    170f:	c9                   	leave
    1710:	c3                   	ret

0000000000001711 <kernel_fb_resize>:
{
    1711:	55                   	push   rbp
    1712:	48 89 e5             	mov    rbp,rsp
		km_regS.x = fb_initial.width - 20;
    1715:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 171b <kernel_fb_resize+0xa>
    171b:	83 e8 14             	sub    eax,0x14
    171e:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 1725 <kernel_fb_resize+0x14>
		km_regC.x = fb_initial.width - 20;
    1725:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 172b <kernel_fb_resize+0x1a>
    172b:	83 e8 14             	sub    eax,0x14
    172e:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 1735 <kernel_fb_resize+0x24>
		km_regC.y = fb_initial.height - 2;
    1735:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 173b <kernel_fb_resize+0x2a>
    173b:	83 e8 02             	sub    eax,0x2
    173e:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 1745 <kernel_fb_resize+0x34>
}
    1745:	90                   	nop
    1746:	5d                   	pop    rbp
    1747:	c3                   	ret

0000000000001748 <second_tick>:
{
    1748:	55                   	push   rbp
    1749:	48 89 e5             	mov    rbp,rsp
    174c:	48 81 ec b0 00 00 00 	sub    rsp,0xb0
		if(((jiffies - km_set) > CMOS_THRESHOLD)) {
    1753:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 175a <second_tick+0x12>
    175a:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    175d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1764 <second_tick+0x1c>
    1764:	48 29 c2             	sub    rdx,rax
    1767:	48 81 fa 90 a5 06 00 	cmp    rdx,0x6a590
    176e:	76 60                	jbe    17d0 <second_tick+0x88>
				km_time = cmos_get_time();
    1770:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    1777:	48 89 c7             	mov    rdi,rax
    177a:	b8 00 00 00 00       	mov    eax,0x0
    177f:	e8 00 00 00 00       	call   1784 <second_tick+0x3c>
    1784:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    178b:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1792 <second_tick+0x4a>
    1792:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    1799:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 17a0 <second_tick+0x58>
    17a0:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    17a4:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 17ab <second_tick+0x63>
    17ab:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    17af:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 17b6 <second_tick+0x6e>
    17b6:	8b 45 90             	mov    eax,DWORD PTR [rbp-0x70]
    17b9:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 17bf <second_tick+0x77>
				km_set = jiffies;
    17bf:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17c6 <second_tick+0x7e>
    17c6:	48 8b 00             	mov    rax,QWORD PTR [rax]
    17c9:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 17d0 <second_tick+0x88>
		task_do_stats();
    17d0:	b8 00 00 00 00       	mov    eax,0x0
    17d5:	e8 00 00 00 00       	call   17da <second_tick+0x92>
				uint64_t scs = jiffies / HZ;
    17da:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17e1 <second_tick+0x99>
    17e1:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    17e4:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    17ee:	48 89 c8             	mov    rax,rcx
    17f1:	48 f7 e2             	mul    rdx
    17f4:	48 89 c8             	mov    rax,rcx
    17f7:	48 29 d0             	sub    rax,rdx
    17fa:	48 d1 e8             	shr    rax,1
    17fd:	48 01 d0             	add    rax,rdx
    1800:	48 c1 e8 06          	shr    rax,0x6
    1804:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				uint32_t secs = 0, mins = 0, hrs = 0, days = 0;
    1808:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
    180f:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
    1816:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [rbp-0x1c],0x0
    181d:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [rbp-0x20],0x0
				km_regS.cur_x = 4;
    1824:	66 c7 05 00 00 00 00 04 00 	mov    WORD PTR [rip+0x0],0x4        # 182d <second_tick+0xe5>
				km_regS.cur_y = 2;
    182d:	66 c7 05 00 00 00 00 02 00 	mov    WORD PTR [rip+0x0],0x2        # 1836 <second_tick+0xee>
				days = (uint32_t)(scs / 86400); //.0
    1836:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    183a:	48 ba b7 4a 89 72 06 45 2e c2 	movabs rdx,0xc22e450672894ab7
    1844:	48 f7 e2             	mul    rdx
    1847:	48 89 d0             	mov    rax,rdx
    184a:	48 c1 e8 10          	shr    rax,0x10
    184e:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				scs -= 86400 * days;
    1851:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    1854:	69 c0 80 51 01 00    	imul   eax,eax,0x15180
    185a:	89 c0                	mov    eax,eax
    185c:	48 29 45 f0          	sub    QWORD PTR [rbp-0x10],rax
				hrs = (uint32_t)(scs / 3600);
    1860:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1864:	48 c1 e8 04          	shr    rax,0x4
    1868:	48 ba 81 6f 5e 4d 3c 2b 1a 09 	movabs rdx,0x91a2b3c4d5e6f81
    1872:	48 f7 e2             	mul    rdx
    1875:	48 89 d0             	mov    rax,rdx
    1878:	48 c1 e8 03          	shr    rax,0x3
    187c:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
				scs -= 3600 * hrs;
    187f:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1882:	69 c0 10 0e 00 00    	imul   eax,eax,0xe10
    1888:	89 c0                	mov    eax,eax
    188a:	48 29 45 f0          	sub    QWORD PTR [rbp-0x10],rax
				mins = (uint32_t)(scs / 60);
    188e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1892:	48 ba 89 88 88 88 88 88 88 88 	movabs rdx,0x8888888888888889
    189c:	48 f7 e2             	mul    rdx
    189f:	48 89 d0             	mov    rax,rdx
    18a2:	48 c1 e8 05          	shr    rax,0x5
    18a6:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
				scs -= 60 * mins;
    18a9:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    18ac:	6b c0 3c             	imul   eax,eax,0x3c
    18af:	89 c0                	mov    eax,eax
    18b1:	48 29 45 f0          	sub    QWORD PTR [rbp-0x10],rax
				secs = (uint32_t)(scs);
    18b5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    18b9:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
				if (secs != old_sc) {
    18bc:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 18c2 <second_tick+0x17a>
    18c2:	39 45 ec             	cmp    DWORD PTR [rbp-0x14],eax
    18c5:	74 3d                	je     1904 <second_tick+0x1bc>
						crprintf(0x2f, &km_regS, "%ud %uh %um %us\n", days, hrs, mins, secs);
    18c7:	8b 75 e8             	mov    esi,DWORD PTR [rbp-0x18]
    18ca:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
    18cd:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    18d0:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
    18d3:	89 14 24             	mov    DWORD PTR [rsp],edx
    18d6:	41 89 f1             	mov    r9d,esi
    18d9:	41 89 c8             	mov    r8d,ecx
    18dc:	89 c1                	mov    ecx,eax
    18de:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    18e5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    18ec:	bf 2f 00 00 00       	mov    edi,0x2f
    18f1:	b8 00 00 00 00       	mov    eax,0x0
    18f6:	e8 00 00 00 00       	call   18fb <second_tick+0x1b3>
						old_sc = secs;
    18fb:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    18fe:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 1904 <second_tick+0x1bc>
				km_regS.cur_x = 0;
    1904:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 190d <second_tick+0x1c5>
				km_regS.cur_y = 3;
    190d:	66 c7 05 00 00 00 00 03 00 	mov    WORD PTR [rip+0x0],0x3        # 1916 <second_tick+0x1ce>
				if (km_time.tm_year) {
    1916:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 191c <second_tick+0x1d4>
    191c:	85 c0                	test   eax,eax
    191e:	0f 84 4d 02 00 00    	je     1b71 <second_tick+0x429>
						uint32_t adsec = ((uint64_t)(jiffies - km_set) / HZ);
    1924:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 192b <second_tick+0x1e3>
    192b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    192e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1935 <second_tick+0x1ed>
    1935:	48 89 d1             	mov    rcx,rdx
    1938:	48 29 c1             	sub    rcx,rax
    193b:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    1945:	48 89 c8             	mov    rax,rcx
    1948:	48 f7 e2             	mul    rdx
    194b:	48 89 c8             	mov    rax,rcx
    194e:	48 29 d0             	sub    rax,rdx
    1951:	48 d1 e8             	shr    rax,1
    1954:	48 01 d0             	add    rax,rdx
    1957:	48 c1 e8 06          	shr    rax,0x6
    195b:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
						struct tm ta = km_time;
    195e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1965 <second_tick+0x21d>
    1965:	48 89 45 ac          	mov    QWORD PTR [rbp-0x54],rax
    1969:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1970 <second_tick+0x228>
    1970:	48 89 45 b4          	mov    QWORD PTR [rbp-0x4c],rax
    1974:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 197b <second_tick+0x233>
    197b:	48 89 45 bc          	mov    QWORD PTR [rbp-0x44],rax
    197f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1986 <second_tick+0x23e>
    1986:	48 89 45 c4          	mov    QWORD PTR [rbp-0x3c],rax
    198a:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1990 <second_tick+0x248>
    1990:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
						ta.tm_sec += adsec;
    1993:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    1996:	89 c2                	mov    edx,eax
    1998:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    199b:	01 d0                	add    eax,edx
    199d:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
						if (ta.tm_sec > 59) {
    19a0:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    19a3:	83 f8 3b             	cmp    eax,0x3b
    19a6:	7e 4b                	jle    19f3 <second_tick+0x2ab>
								ta.tm_min += ta.tm_sec / 60;
    19a8:	8b 55 b0             	mov    edx,DWORD PTR [rbp-0x50]
    19ab:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    19ae:	48 63 c8             	movsxd rcx,eax
    19b1:	48 69 c9 89 88 88 88 	imul   rcx,rcx,0xffffffff88888889
    19b8:	48 c1 e9 20          	shr    rcx,0x20
    19bc:	01 c1                	add    ecx,eax
    19be:	c1 f9 05             	sar    ecx,0x5
    19c1:	c1 f8 1f             	sar    eax,0x1f
    19c4:	29 c1                	sub    ecx,eax
    19c6:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    19c9:	89 45 b0             	mov    DWORD PTR [rbp-0x50],eax
								ta.tm_sec %= 60;
    19cc:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    19cf:	48 63 d0             	movsxd rdx,eax
    19d2:	48 69 d2 89 88 88 88 	imul   rdx,rdx,0xffffffff88888889
    19d9:	48 c1 ea 20          	shr    rdx,0x20
    19dd:	01 c2                	add    edx,eax
    19df:	c1 fa 05             	sar    edx,0x5
    19e2:	89 c1                	mov    ecx,eax
    19e4:	c1 f9 1f             	sar    ecx,0x1f
    19e7:	29 ca                	sub    edx,ecx
    19e9:	6b ca 3c             	imul   ecx,edx,0x3c
    19ec:	29 c8                	sub    eax,ecx
    19ee:	89 c2                	mov    edx,eax
    19f0:	89 55 ac             	mov    DWORD PTR [rbp-0x54],edx
						if (ta.tm_min > 59) {
    19f3:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
    19f6:	83 f8 3b             	cmp    eax,0x3b
    19f9:	7e 4b                	jle    1a46 <second_tick+0x2fe>
								ta.tm_hour += ta.tm_min / 60;
    19fb:	8b 55 b4             	mov    edx,DWORD PTR [rbp-0x4c]
    19fe:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
    1a01:	48 63 c8             	movsxd rcx,eax
    1a04:	48 69 c9 89 88 88 88 	imul   rcx,rcx,0xffffffff88888889
    1a0b:	48 c1 e9 20          	shr    rcx,0x20
    1a0f:	01 c1                	add    ecx,eax
    1a11:	c1 f9 05             	sar    ecx,0x5
    1a14:	c1 f8 1f             	sar    eax,0x1f
    1a17:	29 c1                	sub    ecx,eax
    1a19:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    1a1c:	89 45 b4             	mov    DWORD PTR [rbp-0x4c],eax
								ta.tm_min %= 60;
    1a1f:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
    1a22:	48 63 d0             	movsxd rdx,eax
    1a25:	48 69 d2 89 88 88 88 	imul   rdx,rdx,0xffffffff88888889
    1a2c:	48 c1 ea 20          	shr    rdx,0x20
    1a30:	01 c2                	add    edx,eax
    1a32:	c1 fa 05             	sar    edx,0x5
    1a35:	89 c1                	mov    ecx,eax
    1a37:	c1 f9 1f             	sar    ecx,0x1f
    1a3a:	29 ca                	sub    edx,ecx
    1a3c:	6b ca 3c             	imul   ecx,edx,0x3c
    1a3f:	29 c8                	sub    eax,ecx
    1a41:	89 c2                	mov    edx,eax
    1a43:	89 55 b0             	mov    DWORD PTR [rbp-0x50],edx
						if (ta.tm_hour > 23) {
    1a46:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1a49:	83 f8 17             	cmp    eax,0x17
    1a4c:	0f 8e 93 00 00 00    	jle    1ae5 <second_tick+0x39d>
								ta.tm_mday += ta.tm_hour / 24;
    1a52:	8b 55 b8             	mov    edx,DWORD PTR [rbp-0x48]
    1a55:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1a58:	48 63 c8             	movsxd rcx,eax
    1a5b:	48 69 c9 ab aa aa 2a 	imul   rcx,rcx,0x2aaaaaab
    1a62:	48 c1 e9 20          	shr    rcx,0x20
    1a66:	c1 f9 02             	sar    ecx,0x2
    1a69:	c1 f8 1f             	sar    eax,0x1f
    1a6c:	29 c1                	sub    ecx,eax
    1a6e:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    1a71:	89 45 b8             	mov    DWORD PTR [rbp-0x48],eax
								ta.tm_wday += ta.tm_hour / 24;
    1a74:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    1a77:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1a7a:	48 63 c8             	movsxd rcx,eax
    1a7d:	48 69 c9 ab aa aa 2a 	imul   rcx,rcx,0x2aaaaaab
    1a84:	48 c1 e9 20          	shr    rcx,0x20
    1a88:	c1 f9 02             	sar    ecx,0x2
    1a8b:	c1 f8 1f             	sar    eax,0x1f
    1a8e:	29 c1                	sub    ecx,eax
    1a90:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    1a93:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
								ta.tm_yday += ta.tm_hour / 24;
    1a96:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    1a99:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1a9c:	48 63 c8             	movsxd rcx,eax
    1a9f:	48 69 c9 ab aa aa 2a 	imul   rcx,rcx,0x2aaaaaab
    1aa6:	48 c1 e9 20          	shr    rcx,0x20
    1aaa:	c1 f9 02             	sar    ecx,0x2
    1aad:	c1 f8 1f             	sar    eax,0x1f
    1ab0:	29 c1                	sub    ecx,eax
    1ab2:	8d 04 0a             	lea    eax,[rdx+rcx*1]
    1ab5:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
								ta.tm_hour %= 24;
    1ab8:	8b 4d b4             	mov    ecx,DWORD PTR [rbp-0x4c]
    1abb:	48 63 c1             	movsxd rax,ecx
    1abe:	48 69 c0 ab aa aa 2a 	imul   rax,rax,0x2aaaaaab
    1ac5:	48 c1 e8 20          	shr    rax,0x20
    1ac9:	89 c2                	mov    edx,eax
    1acb:	c1 fa 02             	sar    edx,0x2
    1ace:	89 c8                	mov    eax,ecx
    1ad0:	c1 f8 1f             	sar    eax,0x1f
    1ad3:	29 c2                	sub    edx,eax
    1ad5:	89 d0                	mov    eax,edx
    1ad7:	01 c0                	add    eax,eax
    1ad9:	01 d0                	add    eax,edx
    1adb:	c1 e0 03             	shl    eax,0x3
    1ade:	29 c1                	sub    ecx,eax
    1ae0:	89 ca                	mov    edx,ecx
    1ae2:	89 55 b4             	mov    DWORD PTR [rbp-0x4c],edx
						if (ta.tm_wday > 6) {
    1ae5:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1ae8:	83 f8 06             	cmp    eax,0x6
    1aeb:	7e 2b                	jle    1b18 <second_tick+0x3d0>
								ta.tm_wday %= 7;
    1aed:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    1af0:	48 63 c2             	movsxd rax,edx
    1af3:	48 69 c0 93 24 49 92 	imul   rax,rax,0xffffffff92492493
    1afa:	48 c1 e8 20          	shr    rax,0x20
    1afe:	01 d0                	add    eax,edx
    1b00:	c1 f8 02             	sar    eax,0x2
    1b03:	89 d1                	mov    ecx,edx
    1b05:	c1 f9 1f             	sar    ecx,0x1f
    1b08:	29 c8                	sub    eax,ecx
    1b0a:	89 c1                	mov    ecx,eax
    1b0c:	c1 e1 03             	shl    ecx,0x3
    1b0f:	29 c1                	sub    ecx,eax
    1b11:	89 d0                	mov    eax,edx
    1b13:	29 c8                	sub    eax,ecx
    1b15:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
						if (adsec)
    1b18:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    1b1c:	74 53                	je     1b71 <second_tick+0x429>
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1b1e:	8b 7d ac             	mov    edi,DWORD PTR [rbp-0x54]
    1b21:	8b 75 b0             	mov    esi,DWORD PTR [rbp-0x50]
    1b24:	8b 4d b4             	mov    ecx,DWORD PTR [rbp-0x4c]
    1b27:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    1b2a:	44 8b 45 b8          	mov    r8d,DWORD PTR [rbp-0x48]
										ta.tm_mon + 1, ta.tm_mday,
    1b2e:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1b31:	44 8d 50 01          	lea    r10d,[rax+0x1]
										1900 + ta.tm_year,
    1b35:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
    1b38:	05 6c 07 00 00       	add    eax,0x76c
    1b3d:	89 7c 24 18          	mov    DWORD PTR [rsp+0x18],edi
    1b41:	89 74 24 10          	mov    DWORD PTR [rsp+0x10],esi
    1b45:	89 4c 24 08          	mov    DWORD PTR [rsp+0x8],ecx
    1b49:	89 14 24             	mov    DWORD PTR [rsp],edx
    1b4c:	45 89 c1             	mov    r9d,r8d
    1b4f:	45 89 d0             	mov    r8d,r10d
    1b52:	89 c1                	mov    ecx,eax
    1b54:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    1b5b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1b62:	bf 2f 00 00 00       	mov    edi,0x2f
    1b67:	b8 00 00 00 00       	mov    eax,0x0
    1b6c:	e8 00 00 00 00       	call   1b71 <second_tick+0x429>
				const uint16_t gran = 10;
    1b71:	66 c7 45 da 0a 00    	mov    WORD PTR [rbp-0x26],0xa
				l_k = 1 + (gran * cpu_pcs[0].vals[1]) / 100;
    1b77:	0f b7 55 da          	movzx  edx,WORD PTR [rbp-0x26]
    1b7b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1b82 <second_tick+0x43a>
    1b82:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1b85:	0f af c2             	imul   eax,edx
    1b88:	89 c0                	mov    eax,eax
    1b8a:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    1b91:	48 c1 e8 20          	shr    rax,0x20
    1b95:	c1 e8 05             	shr    eax,0x5
    1b98:	83 c0 01             	add    eax,0x1
    1b9b:	66 89 45 d8          	mov    WORD PTR [rbp-0x28],ax
				l_n = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3])) / 100;
    1b9f:	0f b7 45 da          	movzx  eax,WORD PTR [rbp-0x26]
    1ba3:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1baa <second_tick+0x462>
    1baa:	8b 4a 04             	mov    ecx,DWORD PTR [rdx+0x4]
    1bad:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1bb4 <second_tick+0x46c>
    1bb4:	8b 52 0c             	mov    edx,DWORD PTR [rdx+0xc]
    1bb7:	01 ca                	add    edx,ecx
    1bb9:	0f af c2             	imul   eax,edx
    1bbc:	89 c0                	mov    eax,eax
    1bbe:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    1bc5:	48 c1 e8 20          	shr    rax,0x20
    1bc9:	c1 e8 05             	shr    eax,0x5
    1bcc:	83 c0 01             	add    eax,0x1
    1bcf:	66 89 45 d6          	mov    WORD PTR [rbp-0x2a],ax
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1bd3:	0f b7 45 da          	movzx  eax,WORD PTR [rbp-0x26]
    1bd7:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1bde <second_tick+0x496>
    1bde:	8b 4a 04             	mov    ecx,DWORD PTR [rdx+0x4]
    1be1:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1be8 <second_tick+0x4a0>
    1be8:	8b 52 0c             	mov    edx,DWORD PTR [rdx+0xc]
    1beb:	01 d1                	add    ecx,edx
										+ cpu_pcs[0].vals[2])) / 100;
    1bed:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1bf4 <second_tick+0x4ac>
    1bf4:	8b 52 08             	mov    edx,DWORD PTR [rdx+0x8]
    1bf7:	01 ca                	add    edx,ecx
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1bf9:	0f af c2             	imul   eax,edx
										+ cpu_pcs[0].vals[2])) / 100;
    1bfc:	89 c0                	mov    eax,eax
    1bfe:	48 69 c0 1f 85 eb 51 	imul   rax,rax,0x51eb851f
    1c05:	48 c1 e8 20          	shr    rax,0x20
    1c09:	c1 e8 05             	shr    eax,0x5
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
    1c0c:	83 c0 01             	add    eax,0x1
    1c0f:	66 89 45 d4          	mov    WORD PTR [rbp-0x2c],ax
				putc_prc(&km_regC, KFMT_NORMAL, '[', 0, 0);
    1c13:	41 b8 00 00 00 00    	mov    r8d,0x0
    1c19:	b9 00 00 00 00       	mov    ecx,0x0
    1c1e:	ba 5b 00 00 00       	mov    edx,0x5b
    1c23:	be 0f 00 00 00       	mov    esi,0xf
    1c28:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c2f:	e8 00 00 00 00       	call   1c34 <second_tick+0x4ec>
				putc_prc(&km_regC, KFMT_NORMAL, ']', 11, 0);
    1c34:	41 b8 00 00 00 00    	mov    r8d,0x0
    1c3a:	b9 0b 00 00 00       	mov    ecx,0xb
    1c3f:	ba 5d 00 00 00       	mov    edx,0x5d
    1c44:	be 0f 00 00 00       	mov    esi,0xf
    1c49:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c50:	e8 00 00 00 00       	call   1c55 <second_tick+0x50d>
				for (uint16_t i = 1; i < 1 + gran; i++) {
    1c55:	66 c7 45 fc 01 00    	mov    WORD PTR [rbp-0x4],0x1
    1c5b:	e9 b7 00 00 00       	jmp    1d17 <second_tick+0x5cf>
						if (i < l_k)
    1c60:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1c64:	66 3b 45 d8          	cmp    ax,WORD PTR [rbp-0x28]
    1c68:	73 24                	jae    1c8e <second_tick+0x546>
								putc_prc(&km_regC, KFMT_ERROR, '|', i, 0);
    1c6a:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1c6e:	41 b8 00 00 00 00    	mov    r8d,0x0
    1c74:	89 c1                	mov    ecx,eax
    1c76:	ba 7c 00 00 00       	mov    edx,0x7c
    1c7b:	be 0c 00 00 00       	mov    esi,0xc
    1c80:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c87:	e8 00 00 00 00       	call   1c8c <second_tick+0x544>
    1c8c:	eb 7e                	jmp    1d0c <second_tick+0x5c4>
						else if (i < l_n)
    1c8e:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1c92:	66 3b 45 d6          	cmp    ax,WORD PTR [rbp-0x2a]
    1c96:	73 24                	jae    1cbc <second_tick+0x574>
								putc_prc(&km_regC, KFMT_WARN, '|', i, 0);
    1c98:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1c9c:	41 b8 00 00 00 00    	mov    r8d,0x0
    1ca2:	89 c1                	mov    ecx,eax
    1ca4:	ba 7c 00 00 00       	mov    edx,0x7c
    1ca9:	be 0e 00 00 00       	mov    esi,0xe
    1cae:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1cb5:	e8 00 00 00 00       	call   1cba <second_tick+0x572>
    1cba:	eb 50                	jmp    1d0c <second_tick+0x5c4>
						else if (i < l_u)
    1cbc:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1cc0:	66 3b 45 d4          	cmp    ax,WORD PTR [rbp-0x2c]
    1cc4:	73 24                	jae    1cea <second_tick+0x5a2>
								putc_prc(&km_regC, KFMT_INFO, '|', i, 0);
    1cc6:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1cca:	41 b8 00 00 00 00    	mov    r8d,0x0
    1cd0:	89 c1                	mov    ecx,eax
    1cd2:	ba 7c 00 00 00       	mov    edx,0x7c
    1cd7:	be 0b 00 00 00       	mov    esi,0xb
    1cdc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1ce3:	e8 00 00 00 00       	call   1ce8 <second_tick+0x5a0>
    1ce8:	eb 22                	jmp    1d0c <second_tick+0x5c4>
								putc_prc(&km_regC, KFMT_NORMAL, ' ', i, 0);
    1cea:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1cee:	41 b8 00 00 00 00    	mov    r8d,0x0
    1cf4:	89 c1                	mov    ecx,eax
    1cf6:	ba 20 00 00 00       	mov    edx,0x20
    1cfb:	be 0f 00 00 00       	mov    esi,0xf
    1d00:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d07:	e8 00 00 00 00       	call   1d0c <second_tick+0x5c4>
				for (uint16_t i = 1; i < 1 + gran; i++) {
    1d0c:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1d10:	83 c0 01             	add    eax,0x1
    1d13:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
    1d17:	0f b7 45 da          	movzx  eax,WORD PTR [rbp-0x26]
    1d1b:	66 3b 45 fc          	cmp    ax,WORD PTR [rbp-0x4]
    1d1f:	0f 83 3b ff ff ff    	jae    1c60 <second_tick+0x518>
				km_regC.cur_y = 0;
    1d25:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 1d2e <second_tick+0x5e6>
				km_regC.cur_x = 2 + gran;
    1d2e:	0f b7 45 da          	movzx  eax,WORD PTR [rbp-0x26]
    1d32:	83 c0 02             	add    eax,0x2
    1d35:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 1d3c <second_tick+0x5f4>
				pc_a = min(100, 100 - cpu_pcs[0].vals[0] - ((cpu_pcs[0].vals[4] > 0)
    1d3c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1d43 <second_tick+0x5fb>
    1d43:	8b 10                	mov    edx,DWORD PTR [rax]
    1d45:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1d4c <second_tick+0x604>
    1d4c:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1d4f:	85 c0                	test   eax,eax
    1d51:	74 07                	je     1d5a <second_tick+0x612>
    1d53:	b8 01 00 00 00       	mov    eax,0x1
    1d58:	eb 05                	jmp    1d5f <second_tick+0x617>
    1d5a:	b8 00 00 00 00       	mov    eax,0x0
    1d5f:	01 d0                	add    eax,edx
    1d61:	83 f8 64             	cmp    eax,0x64
    1d64:	77 30                	ja     1d96 <second_tick+0x64e>
    1d66:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1d6d <second_tick+0x625>
    1d6d:	8b 00                	mov    eax,DWORD PTR [rax]
    1d6f:	89 c2                	mov    edx,eax
    1d71:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1d78 <second_tick+0x630>
    1d78:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1d7b:	85 c0                	test   eax,eax
    1d7d:	74 07                	je     1d86 <second_tick+0x63e>
    1d7f:	b8 01 00 00 00       	mov    eax,0x1
    1d84:	eb 05                	jmp    1d8b <second_tick+0x643>
    1d86:	b8 00 00 00 00       	mov    eax,0x0
    1d8b:	01 c2                	add    edx,eax
    1d8d:	b8 64 00 00 00       	mov    eax,0x64
    1d92:	29 d0                	sub    eax,edx
    1d94:	eb 05                	jmp    1d9b <second_tick+0x653>
    1d96:	b8 64 00 00 00       	mov    eax,0x64
    1d9b:	66 89 45 d2          	mov    WORD PTR [rbp-0x2e],ax
				pc_b = min(9, 10 - cpu_pcs[0].vals[4]);
    1d9f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1da6 <second_tick+0x65e>
    1da6:	8b 50 10             	mov    edx,DWORD PTR [rax+0x10]
    1da9:	b8 0a 00 00 00       	mov    eax,0xa
    1dae:	29 d0                	sub    eax,edx
    1db0:	ba 09 00 00 00       	mov    edx,0x9
    1db5:	39 d0                	cmp    eax,edx
    1db7:	0f 47 c2             	cmova  eax,edx
    1dba:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
				if (pc_a == 100)
    1dbe:	66 83 7d d2 64       	cmp    WORD PTR [rbp-0x2e],0x64
    1dc3:	75 06                	jne    1dcb <second_tick+0x683>
						pc_b = 0;
    1dc5:	66 c7 45 fe 00 00    	mov    WORD PTR [rbp-0x2],0x0
				crprintf(KFMT_NORMAL, &km_regC, "%3u.%1u%%", pc_a, pc_b);
    1dcb:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    1dcf:	0f b7 45 d2          	movzx  eax,WORD PTR [rbp-0x2e]
    1dd3:	41 89 d0             	mov    r8d,edx
    1dd6:	89 c1                	mov    ecx,eax
    1dd8:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    1ddf:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1de6:	bf 0f 00 00 00       	mov    edi,0xf
    1deb:	b8 00 00 00 00       	mov    eax,0x0
    1df0:	e8 00 00 00 00       	call   1df5 <second_tick+0x6ad>
}
    1df5:	90                   	nop
    1df6:	c9                   	leave
    1df7:	c3                   	ret

0000000000001df8 <print_counter>:
{
    1df8:	55                   	push   rbp
    1df9:	48 89 e5             	mov    rbp,rsp
    1dfc:	48 83 ec 30          	sub    rsp,0x30
		extern uint64_t fb_rdt; uint64_t rdt; const char* tp = "";
    1e00:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (counter_print == jiffies) /* limit the updates */
    1e08:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e0f <print_counter+0x17>
    1e0f:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1e12:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e19 <print_counter+0x21>
    1e19:	48 39 c2             	cmp    rdx,rax
    1e1c:	0f 84 a5 02 00 00    	je     20c7 <print_counter+0x2cf>
		counter_print = jiffies;
    1e22:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e29 <print_counter+0x31>
    1e29:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1e2c:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1e33 <print_counter+0x3b>
		if (tsc_per_ms) {
    1e33:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e3a <print_counter+0x42>
    1e3a:	48 85 c0             	test   rax,rax
    1e3d:	0f 84 8f 00 00 00    	je     1ed2 <print_counter+0xda>
				tp = " ns";
    1e43:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				rdt = fb_rdt * 1000000 / tsc_per_ms;
    1e4b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e52 <print_counter+0x5a>
    1e52:	48 69 c0 40 42 0f 00 	imul   rax,rax,0xf4240
    1e59:	48 8b 35 00 00 00 00 	mov    rsi,QWORD PTR [rip+0x0]        # 1e60 <print_counter+0x68>
    1e60:	ba 00 00 00 00       	mov    edx,0x0
    1e65:	48 f7 f6             	div    rsi
    1e68:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (rdt > 99999) {
    1e6c:	48 81 7d f8 9f 86 01 00 	cmp    QWORD PTR [rbp-0x8],0x1869f
    1e74:	76 28                	jbe    1e9e <print_counter+0xa6>
						rdt /= 1000;
    1e76:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1e7a:	48 c1 e8 03          	shr    rax,0x3
    1e7e:	48 ba cf f7 53 e3 a5 9b c4 20 	movabs rdx,0x20c49ba5e353f7cf
    1e88:	48 f7 e2             	mul    rdx
    1e8b:	48 89 d0             	mov    rax,rdx
    1e8e:	48 c1 e8 04          	shr    rax,0x4
    1e92:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						tp = " mu";
    1e96:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				}
				if (rdt > 99999) {
    1e9e:	48 81 7d f8 9f 86 01 00 	cmp    QWORD PTR [rbp-0x8],0x1869f
    1ea6:	76 35                	jbe    1edd <print_counter+0xe5>
						rdt /= 1000;
    1ea8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1eac:	48 c1 e8 03          	shr    rax,0x3
    1eb0:	48 ba cf f7 53 e3 a5 9b c4 20 	movabs rdx,0x20c49ba5e353f7cf
    1eba:	48 f7 e2             	mul    rdx
    1ebd:	48 89 d0             	mov    rax,rdx
    1ec0:	48 c1 e8 04          	shr    rax,0x4
    1ec4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						tp = " ms";
    1ec8:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1ed0:	eb 0b                	jmp    1edd <print_counter+0xe5>
				}
		} else
				rdt = fb_rdt;
    1ed2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1ed9 <print_counter+0xe1>
    1ed9:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		km_regC.cur_x = 0; km_regC.cur_y = 1;
    1edd:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 1ee6 <print_counter+0xee>
    1ee6:	66 c7 05 00 00 00 00 01 00 	mov    WORD PTR [rip+0x0],0x1        # 1eef <print_counter+0xf7>
		rprintf(&km_regC, "%7llu: %7llu%s", counter_print, rdt, tp);
    1eef:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1ef6 <print_counter+0xfe>
    1ef6:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    1efa:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1efe:	49 89 c8             	mov    r8,rcx
    1f01:	48 89 d1             	mov    rcx,rdx
    1f04:	48 89 c2             	mov    rdx,rax
    1f07:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1f0e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1f15:	b8 00 00 00 00       	mov    eax,0x0
    1f1a:	e8 00 00 00 00       	call   1f1f <print_counter+0x127>
		if ((jiffies - counter_sec) > HZ || !counter_sec) {
    1f1f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f26 <print_counter+0x12e>
    1f26:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1f29:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f30 <print_counter+0x138>
    1f30:	48 29 c2             	sub    rdx,rax
    1f33:	48 83 fa 79          	cmp    rdx,0x79
    1f37:	77 0c                	ja     1f45 <print_counter+0x14d>
    1f39:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f40 <print_counter+0x148>
    1f40:	48 85 c0             	test   rax,rax
    1f43:	75 3b                	jne    1f80 <print_counter+0x188>
				if (!counter_sec)
    1f45:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f4c <print_counter+0x154>
    1f4c:	48 85 c0             	test   rax,rax
    1f4f:	75 13                	jne    1f64 <print_counter+0x16c>
						counter_sec = jiffies;
    1f51:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f58 <print_counter+0x160>
    1f58:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1f5b:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1f62 <print_counter+0x16a>
    1f62:	eb 12                	jmp    1f76 <print_counter+0x17e>
				else
						counter_sec += HZ;
    1f64:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f6b <print_counter+0x173>
    1f6b:	48 83 c0 79          	add    rax,0x79
    1f6f:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1f76 <print_counter+0x17e>
				second_tick();
    1f76:	b8 00 00 00 00       	mov    eax,0x0
    1f7b:	e8 00 00 00 00       	call   1f80 <print_counter+0x188>
		}

		/* update memory stats faster than every second! really? */
		km_regS.cur_x = 0;
    1f80:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 1f89 <print_counter+0x191>
		km_regS.cur_y = 1;
    1f89:	66 c7 05 00 00 00 00 01 00 	mov    WORD PTR [rip+0x0],0x1        # 1f92 <print_counter+0x19a>
		
		void kstats(size_t* s_total, size_t* s_commit,
					   	size_t* s_free, size_t* s_nheaps);
		kstats(h_stats, h_stats + 1, h_stats + 2, h_stats + 3);
    1f92:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    1f99:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    1fa0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1fa7:	48 89 c6             	mov    rsi,rax
    1faa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1fb1:	e8 00 00 00 00       	call   1fb6 <print_counter+0x1be>
		for (size_t i = 0; i < 4; i++)
    1fb6:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    1fbe:	e9 f7 00 00 00       	jmp    20ba <print_counter+0x2c2>
				if (h_stats_old[i] != h_stats[i]) {
    1fc3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fc7:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    1fcf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fd3:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    1fdb:	48 39 c2             	cmp    rdx,rax
    1fde:	0f 84 d1 00 00 00    	je     20b5 <print_counter+0x2bd>
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
								h_stats[3], (h_stats[2]) / 1024);
    1fe4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1feb <print_counter+0x1f3>
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    1feb:	48 c1 e8 0a          	shr    rax,0xa
    1fef:	48 89 c6             	mov    rsi,rax
    1ff2:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 1ff9 <print_counter+0x201>
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
    1ff9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2000 <print_counter+0x208>
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    2000:	48 3d 9f 86 01 00    	cmp    rax,0x1869f
    2006:	77 21                	ja     2029 <print_counter+0x231>
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
    2008:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 200f <print_counter+0x217>
    200f:	48 3d 0f 27 00 00    	cmp    rax,0x270f
    2015:	76 09                	jbe    2020 <print_counter+0x228>
    2017:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    201e:	eb 10                	jmp    2030 <print_counter+0x238>
    2020:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2027:	eb 07                	jmp    2030 <print_counter+0x238>
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    2029:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
    2030:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2037 <print_counter+0x23f>
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    2037:	48 3d 9f 86 01 00    	cmp    rax,0x1869f
    203d:	76 0d                	jbe    204c <print_counter+0x254>
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
    203f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2046 <print_counter+0x24e>
						crprintf(0x2f, &km_regS, "%4zuk %4zu%s %2zu %4zuk", (h_stats[0]) / 1024,
    2046:	48 c1 e8 0a          	shr    rax,0xa
    204a:	eb 07                	jmp    2053 <print_counter+0x25b>
    204c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2053 <print_counter+0x25b>
    2053:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 205a <print_counter+0x262>
    205a:	48 c1 ea 0a          	shr    rdx,0xa
    205e:	48 89 74 24 08       	mov    QWORD PTR [rsp+0x8],rsi
    2063:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
    2067:	49 89 f9             	mov    r9,rdi
    206a:	49 89 c0             	mov    r8,rax
    206d:	48 89 d1             	mov    rcx,rdx
    2070:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    2077:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    207e:	bf 2f 00 00 00       	mov    edi,0x2f
    2083:	b8 00 00 00 00       	mov    eax,0x0
    2088:	e8 00 00 00 00       	call   208d <print_counter+0x295>
						for (; i < 4; i++)
    208d:	eb 1d                	jmp    20ac <print_counter+0x2b4>
								h_stats_old[i] = h_stats[i];
    208f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2093:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    209b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    209f:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						for (; i < 4; i++)
    20a7:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    20ac:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
    20b1:	76 dc                	jbe    208f <print_counter+0x297>
						break;
    20b3:	eb 13                	jmp    20c8 <print_counter+0x2d0>
		for (size_t i = 0; i < 4; i++)
    20b5:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    20ba:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
    20bf:	0f 86 fe fe ff ff    	jbe    1fc3 <print_counter+0x1cb>
    20c5:	eb 01                	jmp    20c8 <print_counter+0x2d0>
				return;
    20c7:	90                   	nop
				}
}
    20c8:	c9                   	leave
    20c9:	c3                   	ret

00000000000020ca <ktimer_tick>:

/* this is the workhorse used for time-keeping */
void ktimer_tick()
{
    20ca:	55                   	push   rbp
    20cb:	48 89 e5             	mov    rbp,rsp
		extern uint64_t fb_udc;
		extern uint64_t fb_rdc;
		extern uint64_t fb_rdt;
		/* timekeeping */
		jiffies++;
    20ce:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 20d5 <ktimer_tick+0xb>
    20d5:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    20d8:	48 83 c2 01          	add    rdx,0x1
    20dc:	48 89 10             	mov    QWORD PTR [rax],rdx
		if (irq0_hook) /* don't starve bogo_mips calculation */
    20df:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 20e6 <ktimer_tick+0x1c>
    20e6:	48 85 c0             	test   rax,rax
    20e9:	75 3f                	jne    212a <ktimer_tick+0x60>
				return;

		static volatile int redr = 0;
		extern int preempt_needs_init;
		if (preempt_needs_init && !redr--) {
    20eb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 20f1 <ktimer_tick+0x27>
    20f1:	85 c0                	test   eax,eax
    20f3:	74 36                	je     212b <ktimer_tick+0x61>
    20f5:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 20fb <ktimer_tick+0x31>
    20fb:	8d 50 ff             	lea    edx,[rax-0x1]
    20fe:	89 15 00 00 00 00    	mov    DWORD PTR [rip+0x0],edx        # 2104 <ktimer_tick+0x3a>
    2104:	85 c0                	test   eax,eax
    2106:	75 23                	jne    212b <ktimer_tick+0x61>
				redr = 10;
    2108:	c7 05 00 00 00 00 0a 00 00 00 	mov    DWORD PTR [rip+0x0],0xa        # 2112 <ktimer_tick+0x48>
				print_counter();
    2112:	b8 00 00 00 00       	mov    eax,0x0
    2117:	e8 00 00 00 00       	call   211c <ktimer_tick+0x52>
				framebuffer_redraw_updates(&fb_initial);
    211c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2123:	e8 00 00 00 00       	call   2128 <ktimer_tick+0x5e>
    2128:	eb 01                	jmp    212b <ktimer_tick+0x61>
				return;
    212a:	90                   	nop
		}
}
    212b:	5d                   	pop    rbp
    212c:	c3                   	ret

000000000000212d <kredraw>:

void kredraw(void* data)
{
    212d:	55                   	push   rbp
    212e:	48 89 e5             	mov    rbp,rsp
    2131:	48 83 ec 10          	sub    rsp,0x10
    2135:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		while (1) {
				extern struct wait_queue_head wq_timer;
				print_counter();
    2139:	b8 00 00 00 00       	mov    eax,0x0
    213e:	e8 00 00 00 00       	call   2143 <kredraw+0x16>
				//asm("cli");
				preempt_disable();
    2143:	b8 00 00 00 00       	mov    eax,0x0
    2148:	e8 00 00 00 00       	call   214d <kredraw+0x20>
    214d:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    2150:	83 c2 01             	add    edx,0x1
    2153:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
				framebuffer_redraw_updates(&fb_initial);
    2156:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    215d:	e8 00 00 00 00       	call   2162 <kredraw+0x35>
				preempt_enable_no_resched();
    2162:	b8 00 00 00 00       	mov    eax,0x0
    2167:	e8 00 00 00 00       	call   216c <kredraw+0x3f>
    216c:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    216f:	83 ea 01             	sub    edx,0x1
    2172:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
				//asm("sti");
				wait_timeout(&wq_timer, HZ / 60);
    2175:	be 02 00 00 00       	mov    esi,0x2
    217a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2181:	e8 00 00 00 00       	call   2186 <kredraw+0x59>
		while (1) {
    2186:	90                   	nop
    2187:	eb b0                	jmp    2139 <kredraw+0xc>

0000000000002189 <clock_gettime>:
		}
}

int clock_gettime(clockid_t clk_id, struct timespec* tp)
{
    2189:	55                   	push   rbp
    218a:	48 89 e5             	mov    rbp,rsp
    218d:	48 83 ec 50          	sub    rsp,0x50
    2191:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
    2194:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		if (!tp || clk_id != CLOCK_REALTIME) {
    2198:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    219d:	74 06                	je     21a5 <clock_gettime+0x1c>
    219f:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    21a3:	74 14                	je     21b9 <clock_gettime+0x30>
				errno = EINVAL;
    21a5:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 21af <clock_gettime+0x26>
				return -1;
    21af:	b8 ff ff ff ff       	mov    eax,0xffffffff
    21b4:	e9 dc 01 00 00       	jmp    2395 <clock_gettime+0x20c>
		}
		/* query the cmos for REALTIME if needed */
		if (!km_set) {
    21b9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 21c0 <clock_gettime+0x37>
    21c0:	48 85 c0             	test   rax,rax
    21c3:	75 57                	jne    221c <clock_gettime+0x93>
				km_time = cmos_get_time();
    21c5:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    21c9:	48 89 c7             	mov    rdi,rax
    21cc:	b8 00 00 00 00       	mov    eax,0x0
    21d1:	e8 00 00 00 00       	call   21d6 <clock_gettime+0x4d>
    21d6:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21da:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 21e1 <clock_gettime+0x58>
    21e1:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    21e5:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 21ec <clock_gettime+0x63>
    21ec:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    21f0:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 21f7 <clock_gettime+0x6e>
    21f7:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    21fb:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2202 <clock_gettime+0x79>
    2202:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    2205:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 220b <clock_gettime+0x82>
				km_set = jiffies;
    220b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2212 <clock_gettime+0x89>
    2212:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2215:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 221c <clock_gettime+0x93>
		}
		tp->tv_nsec = 0;
    221c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2220:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
				ct |= (uint16_t)inb(PIT1_CH0) << 8;
				ct = (uint16_t)(PIT_FREQ / CLOCKS_PER_SEC) - ct;
				tp->tv_nsec += (long)((double)(uint32_t)ct * 1000000 / PIT_FREQ);
		}
		/* calculate the number of leap days since 1970 */
		time_t diff = jiffies - km_set;
    2228:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 222f <clock_gettime+0xa6>
    222f:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    2232:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2239 <clock_gettime+0xb0>
    2239:	48 29 c2             	sub    rdx,rax
    223c:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
		tp->tv_nsec = diff - (time_t)((time_t)(diff / CLOCKS_PER_SEC) * CLOCKS_PER_SEC);
    2240:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    2244:	48 ba 79 3f 72 9a af d5 b3 43 	movabs rdx,0x43b3d5af9a723f79
    224e:	48 89 c8             	mov    rax,rcx
    2251:	48 f7 ea             	imul   rdx
    2254:	48 89 d0             	mov    rax,rdx
    2257:	48 c1 f8 05          	sar    rax,0x5
    225b:	48 c1 f9 3f          	sar    rcx,0x3f
    225f:	48 89 ca             	mov    rdx,rcx
    2262:	48 29 c2             	sub    rdx,rax
    2265:	48 89 d0             	mov    rax,rdx
    2268:	48 c1 e0 04          	shl    rax,0x4
    226c:	48 29 d0             	sub    rax,rdx
    226f:	48 c1 e0 03          	shl    rax,0x3
    2273:	48 01 c2             	add    rdx,rax
    2276:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    227a:	48 01 c2             	add    rdx,rax
    227d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2281:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		tp->tv_nsec = (long)((tp->tv_nsec * 1000000) / CLOCKS_PER_SEC);
    2285:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2289:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    228d:	48 69 c8 40 42 0f 00 	imul   rcx,rax,0xf4240
    2294:	48 ba 79 3f 72 9a af d5 b3 43 	movabs rdx,0x43b3d5af9a723f79
    229e:	48 89 c8             	mov    rax,rcx
    22a1:	48 f7 ea             	imul   rdx
    22a4:	48 c1 fa 05          	sar    rdx,0x5
    22a8:	48 89 c8             	mov    rax,rcx
    22ab:	48 c1 f8 3f          	sar    rax,0x3f
    22af:	48 29 c2             	sub    rdx,rax
    22b2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    22b6:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    22ba:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 22c0 <clock_gettime+0x137>
    22c0:	05 6b 07 00 00       	add    eax,0x76b
    22c5:	69 d0 6d 01 00 00    	imul   edx,eax,0x16d
    22cb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 22d1 <clock_gettime+0x148>
    22d1:	05 6b 07 00 00       	add    eax,0x76b
    22d6:	8d 48 03             	lea    ecx,[rax+0x3]
    22d9:	85 c0                	test   eax,eax
    22db:	0f 48 c1             	cmovs  eax,ecx
    22de:	c1 f8 02             	sar    eax,0x2
    22e1:	89 c6                	mov    esi,eax
    22e3:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 22e9 <clock_gettime+0x160>
    22e9:	05 6b 07 00 00       	add    eax,0x76b
    22ee:	48 63 c8             	movsxd rcx,eax
    22f1:	48 69 c9 1f 85 eb 51 	imul   rcx,rcx,0x51eb851f
    22f8:	48 c1 e9 20          	shr    rcx,0x20
    22fc:	c1 f9 05             	sar    ecx,0x5
    22ff:	c1 f8 1f             	sar    eax,0x1f
    2302:	29 c8                	sub    eax,ecx
    2304:	01 c6                	add    esi,eax
    2306:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 230c <clock_gettime+0x183>
    230c:	05 6b 07 00 00       	add    eax,0x76b
    2311:	48 63 c8             	movsxd rcx,eax
    2314:	48 69 c9 1f 85 eb 51 	imul   rcx,rcx,0x51eb851f
    231b:	48 c1 e9 20          	shr    rcx,0x20
    231f:	c1 f9 07             	sar    ecx,0x7
    2322:	c1 f8 1f             	sar    eax,0x1f
    2325:	29 c1                	sub    ecx,eax
    2327:	8d 04 0e             	lea    eax,[rsi+rcx*1]
    232a:	01 d0                	add    eax,edx
    232c:	8d 90 c6 06 f5 ff    	lea    edx,[rax-0xaf93a]
						+ km_time.tm_yday) + 3600 * km_time.tm_hour
    2332:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2338 <clock_gettime+0x1af>
    2338:	01 d0                	add    eax,edx
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    233a:	69 d0 80 51 01 00    	imul   edx,eax,0x15180
						+ km_time.tm_yday) + 3600 * km_time.tm_hour
    2340:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2346 <clock_gettime+0x1bd>
    2346:	69 c0 10 0e 00 00    	imul   eax,eax,0xe10
    234c:	01 c2                	add    edx,eax
						+ 60 * km_time.tm_min + km_time.tm_sec
    234e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2354 <clock_gettime+0x1cb>
    2354:	6b c0 3c             	imul   eax,eax,0x3c
    2357:	01 c2                	add    edx,eax
    2359:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 235f <clock_gettime+0x1d6>
    235f:	01 d0                	add    eax,edx
    2361:	48 63 f0             	movsxd rsi,eax
						+ (time_t)(diff / CLOCKS_PER_SEC);
    2364:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    2368:	48 ba 79 3f 72 9a af d5 b3 43 	movabs rdx,0x43b3d5af9a723f79
    2372:	48 89 c8             	mov    rax,rcx
    2375:	48 f7 ea             	imul   rdx
    2378:	48 c1 fa 05          	sar    rdx,0x5
    237c:	48 89 c8             	mov    rax,rcx
    237f:	48 c1 f8 3f          	sar    rax,0x3f
    2383:	48 29 c2             	sub    rdx,rax
    2386:	48 01 f2             	add    rdx,rsi
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
    2389:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    238d:	48 89 10             	mov    QWORD PTR [rax],rdx
		return 0;
    2390:	b8 00 00 00 00       	mov    eax,0x0
}
    2395:	c9                   	leave
    2396:	c3                   	ret

0000000000002397 <hook_fun.0>:
void calibrate_bogo_mips(uint16_t pit_div)
{
		static uint32_t ct = 0, old_ct = 0, delta[8] = {0}, ni = 0;
		static uint64_t ts_delta[8], ts_ct = 0;
		uint32_t limit = 0x00f00000; /* very low for QEMU-software emu */
		void hook_fun() {
    2397:	55                   	push   rbp
    2398:	48 89 e5             	mov    rbp,rsp
    239b:	48 83 ec 08          	sub    rsp,0x8
    239f:	4c 89 55 f8          	mov    QWORD PTR [rbp-0x8],r10
				ni++;
    23a3:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23a9 <hook_fun.0+0x12>
    23a9:	83 c0 01             	add    eax,0x1
    23ac:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 23b2 <hook_fun.0+0x1b>
				if (old_ct && ni <= 9) {
    23b2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23b8 <hook_fun.0+0x21>
    23b8:	85 c0                	test   eax,eax
    23ba:	74 4e                	je     240a <hook_fun.0+0x73>
    23bc:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23c2 <hook_fun.0+0x2b>
    23c2:	83 f8 09             	cmp    eax,0x9
    23c5:	77 43                	ja     240a <hook_fun.0+0x73>
						delta[ni - 2] = ct - old_ct;
    23c7:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 23cd <hook_fun.0+0x36>
    23cd:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23d3 <hook_fun.0+0x3c>
    23d3:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 23d9 <hook_fun.0+0x42>
    23d9:	83 e9 02             	sub    ecx,0x2
    23dc:	29 c2                	sub    edx,eax
    23de:	89 c8                	mov    eax,ecx
    23e0:	89 14 85 00 00 00 00 	mov    DWORD PTR [rax*4+0x0],edx
						if (cpu.has_tsc)
    23e7:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 23ee <hook_fun.0+0x57>
    23ee:	83 e0 10             	and    eax,0x10
    23f1:	84 c0                	test   al,al
    23f3:	74 15                	je     240a <hook_fun.0+0x73>
								asm volatile ("rdtsc" : "=A" (ts_delta[ni - 2]));
    23f5:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23fb <hook_fun.0+0x64>
    23fb:	8d 50 fe             	lea    edx,[rax-0x2]
    23fe:	0f 31                	rdtsc
    2400:	89 d2                	mov    edx,edx
    2402:	48 89 04 d5 00 00 00 00 	mov    QWORD PTR [rdx*8+0x0],rax
				}
				old_ct = ct;
    240a:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2410 <hook_fun.0+0x79>
    2410:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2416 <hook_fun.0+0x7f>
				if (ni >= 9)
    2416:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 241c <hook_fun.0+0x85>
    241c:	83 f8 08             	cmp    eax,0x8
    241f:	76 0b                	jbe    242c <hook_fun.0+0x95>
						irq0_hook = NULL;
    2421:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 242c <hook_fun.0+0x95>
		}
    242c:	90                   	nop
    242d:	c9                   	leave
    242e:	c3                   	ret

000000000000242f <calibrate_bogo_mips>:
{
    242f:	55                   	push   rbp
    2430:	48 89 e5             	mov    rbp,rsp
    2433:	48 83 ec 40          	sub    rsp,0x40
    2437:	89 f8                	mov    eax,edi
    2439:	66 89 45 cc          	mov    WORD PTR [rbp-0x34],ax
void calibrate_bogo_mips(uint16_t pit_div)
    243d:	48 8d 45 10          	lea    rax,[rbp+0x10]
    2441:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    2445:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    2449:	48 8d 55 d0          	lea    rdx,[rbp-0x30]
    244d:	66 c7 00 49 bb       	mov    WORD PTR [rax],0xbb49
    2452:	48 c7 40 02 00 00 00 00 	mov    QWORD PTR [rax+0x2],0x0
    245a:	66 c7 40 0a 49 ba    	mov    WORD PTR [rax+0xa],0xba49
    2460:	48 89 50 0c          	mov    QWORD PTR [rax+0xc],rdx
    2464:	c7 40 14 49 ff e3 90 	mov    DWORD PTR [rax+0x14],0x90e3ff49
		uint32_t limit = 0x00f00000; /* very low for QEMU-software emu */
    246b:	c7 45 fc 00 00 f0 00 	mov    DWORD PTR [rbp-0x4],0xf00000

		printf("calibrating bogous MIPS value...\n");
    2472:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2479:	b8 00 00 00 00       	mov    eax,0x0
    247e:	e8 00 00 00 00       	call   2483 <calibrate_bogo_mips+0x54>
		/* do the adaptive loop
		 * if limit needs to be > 32bit we're f'ed  */
		do {
				/* zero the variables */
				ct = old_ct = ni = 0;
    2483:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 248d <calibrate_bogo_mips+0x5e>
    248d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2493 <calibrate_bogo_mips+0x64>
    2493:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2499 <calibrate_bogo_mips+0x6a>
    2499:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 249f <calibrate_bogo_mips+0x70>
    249f:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 24a5 <calibrate_bogo_mips+0x76>
				/* (re-)install the irq0 hook */
				irq0_hook = hook_fun;
    24a5:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    24a9:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 24b0 <calibrate_bogo_mips+0x81>
				for (ct = 0; ct < limit; ct++);
    24b0:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 24ba <calibrate_bogo_mips+0x8b>
    24ba:	eb 0f                	jmp    24cb <calibrate_bogo_mips+0x9c>
    24bc:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 24c2 <calibrate_bogo_mips+0x93>
    24c2:	83 c0 01             	add    eax,0x1
    24c5:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 24cb <calibrate_bogo_mips+0x9c>
    24cb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 24d1 <calibrate_bogo_mips+0xa2>
    24d1:	3b 45 fc             	cmp    eax,DWORD PTR [rbp-0x4]
    24d4:	72 e6                	jb     24bc <calibrate_bogo_mips+0x8d>
				if (ni < 9) { /* unusable -> redo */
    24d6:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 24dc <calibrate_bogo_mips+0xad>
    24dc:	83 f8 08             	cmp    eax,0x8
    24df:	77 31                	ja     2512 <calibrate_bogo_mips+0xe3>
						limit <<= 4;
    24e1:	c1 65 fc 04          	shl    DWORD PTR [rbp-0x4],0x4
						printf("increasing bogous MIPS calibration loop limit to %x\n", limit);
    24e5:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    24e8:	89 c6                	mov    esi,eax
    24ea:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    24f1:	b8 00 00 00 00       	mov    eax,0x0
    24f6:	e8 00 00 00 00       	call   24fb <calibrate_bogo_mips+0xcc>
						/* wait for hook self-removal */
						while (irq0_hook);
    24fb:	90                   	nop
    24fc:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2503 <calibrate_bogo_mips+0xd4>
    2503:	48 85 c0             	test   rax,rax
    2506:	75 f4                	jne    24fc <calibrate_bogo_mips+0xcd>
						ni = 0;
    2508:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 2512 <calibrate_bogo_mips+0xe3>
				}
		} while (ni < 9);
    2512:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2518 <calibrate_bogo_mips+0xe9>
    2518:	83 f8 08             	cmp    eax,0x8
    251b:	0f 86 62 ff ff ff    	jbe    2483 <calibrate_bogo_mips+0x54>

		/* now we have 8 positive delta values for
		 * calibrating bogo_mips each div ticks apart */
		old_ct = 0;
    2521:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 252b <calibrate_bogo_mips+0xfc>
		for (ct = 0; ct < 8; ct++) {
    252b:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 2535 <calibrate_bogo_mips+0x106>
    2535:	e9 a3 00 00 00       	jmp    25dd <calibrate_bogo_mips+0x1ae>
				printf("%u: %08x\n", ct, delta[ct]);
    253a:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2540 <calibrate_bogo_mips+0x111>
    2540:	89 c0                	mov    eax,eax
    2542:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [rax*4+0x0]
    2549:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 254f <calibrate_bogo_mips+0x120>
    254f:	89 c6                	mov    esi,eax
    2551:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2558:	b8 00 00 00 00       	mov    eax,0x0
    255d:	e8 00 00 00 00       	call   2562 <calibrate_bogo_mips+0x133>
				old_ct += delta[ct];
    2562:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2568 <calibrate_bogo_mips+0x139>
    2568:	89 c0                	mov    eax,eax
    256a:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [rax*4+0x0]
    2571:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2577 <calibrate_bogo_mips+0x148>
    2577:	01 d0                	add    eax,edx
    2579:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 257f <calibrate_bogo_mips+0x150>
				if (cpu.has_tsc && ct)
    257f:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2586 <calibrate_bogo_mips+0x157>
    2586:	83 e0 10             	and    eax,0x10
    2589:	84 c0                	test   al,al
    258b:	74 41                	je     25ce <calibrate_bogo_mips+0x19f>
    258d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2593 <calibrate_bogo_mips+0x164>
    2593:	85 c0                	test   eax,eax
    2595:	74 37                	je     25ce <calibrate_bogo_mips+0x19f>
						ts_ct += ts_delta[ct] - ts_delta[ct - 1];
    2597:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 259d <calibrate_bogo_mips+0x16e>
    259d:	89 c0                	mov    eax,eax
    259f:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    25a7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25ad <calibrate_bogo_mips+0x17e>
    25ad:	83 e8 01             	sub    eax,0x1
    25b0:	89 c0                	mov    eax,eax
    25b2:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    25ba:	48 29 c2             	sub    rdx,rax
    25bd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 25c4 <calibrate_bogo_mips+0x195>
    25c4:	48 01 d0             	add    rax,rdx
    25c7:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 25ce <calibrate_bogo_mips+0x19f>
		for (ct = 0; ct < 8; ct++) {
    25ce:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25d4 <calibrate_bogo_mips+0x1a5>
    25d4:	83 c0 01             	add    eax,0x1
    25d7:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 25dd <calibrate_bogo_mips+0x1ae>
    25dd:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25e3 <calibrate_bogo_mips+0x1b4>
    25e3:	83 f8 07             	cmp    eax,0x7
    25e6:	0f 86 4e ff ff ff    	jbe    253a <calibrate_bogo_mips+0x10b>
		}
		old_ct /= 8;
    25ec:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25f2 <calibrate_bogo_mips+0x1c3>
    25f2:	c1 e8 03             	shr    eax,0x3
    25f5:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 25fb <calibrate_bogo_mips+0x1cc>
		if (cpu.has_tsc)
    25fb:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2602 <calibrate_bogo_mips+0x1d3>
    2602:	83 e0 10             	and    eax,0x10
    2605:	84 c0                	test   al,al
    2607:	74 2e                	je     2637 <calibrate_bogo_mips+0x208>
				ts_ct /= 7;
    2609:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 2610 <calibrate_bogo_mips+0x1e1>
    2610:	48 ba 93 24 49 92 24 49 92 24 	movabs rdx,0x2492492492492493
    261a:	48 89 c8             	mov    rax,rcx
    261d:	48 f7 e2             	mul    rdx
    2620:	48 89 c8             	mov    rax,rcx
    2623:	48 29 d0             	sub    rax,rdx
    2626:	48 d1 e8             	shr    rax,1
    2629:	48 01 d0             	add    rax,rdx
    262c:	48 c1 e8 02          	shr    rax,0x2
    2630:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2637 <calibrate_bogo_mips+0x208>
		printf("Bougous MIPS calibrated to %08x steps per PIT tick with a "
    2637:	0f b7 55 cc          	movzx  edx,WORD PTR [rbp-0x34]
    263b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2641 <calibrate_bogo_mips+0x212>
    2641:	89 c6                	mov    esi,eax
    2643:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    264a:	b8 00 00 00 00       	mov    eax,0x0
    264f:	e8 00 00 00 00       	call   2654 <calibrate_bogo_mips+0x225>
				"PIT divider of %u\n", old_ct, pit_div);
		loops_per_jiffy = old_ct;
    2654:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 265a <calibrate_bogo_mips+0x22b>
    265a:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2660 <calibrate_bogo_mips+0x231>
		printf("Therefore a delay of 1 ms corresponds to %u steps.\n",
				(loops_per_ms = (uint32_t)(HZ * (uint64_t)old_ct / 1000)));
    2660:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2666 <calibrate_bogo_mips+0x237>
    2666:	89 c2                	mov    edx,eax
    2668:	48 89 d0             	mov    rax,rdx
    266b:	48 c1 e0 04          	shl    rax,0x4
    266f:	48 29 d0             	sub    rax,rdx
    2672:	48 c1 e0 03          	shl    rax,0x3
    2676:	48 01 d0             	add    rax,rdx
    2679:	48 c1 e8 03          	shr    rax,0x3
    267d:	48 ba cf f7 53 e3 a5 9b c4 20 	movabs rdx,0x20c49ba5e353f7cf
    2687:	48 f7 e2             	mul    rdx
    268a:	48 89 d0             	mov    rax,rdx
    268d:	48 c1 e8 04          	shr    rax,0x4
		printf("Therefore a delay of 1 ms corresponds to %u steps.\n",
    2691:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2697 <calibrate_bogo_mips+0x268>
    2697:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 269d <calibrate_bogo_mips+0x26e>
    269d:	89 c6                	mov    esi,eax
    269f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    26a6:	b8 00 00 00 00       	mov    eax,0x0
    26ab:	e8 00 00 00 00       	call   26b0 <calibrate_bogo_mips+0x281>
		if (cpu.has_tsc) {
    26b0:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 26b7 <calibrate_bogo_mips+0x288>
    26b7:	83 e0 10             	and    eax,0x10
    26ba:	84 c0                	test   al,al
    26bc:	74 59                	je     2717 <calibrate_bogo_mips+0x2e8>
				printf("As this CPU has a TSC a PIT tick corresponds to %llu "
						"TSC ticks --> %llu ticks per ms.\n", ts_ct,
					   (tsc_per_ms = HZ * ts_ct / 1000));
    26be:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 26c5 <calibrate_bogo_mips+0x296>
    26c5:	48 89 d0             	mov    rax,rdx
    26c8:	48 c1 e0 04          	shl    rax,0x4
    26cc:	48 29 d0             	sub    rax,rdx
    26cf:	48 c1 e0 03          	shl    rax,0x3
    26d3:	48 01 d0             	add    rax,rdx
    26d6:	48 c1 e8 03          	shr    rax,0x3
    26da:	48 ba cf f7 53 e3 a5 9b c4 20 	movabs rdx,0x20c49ba5e353f7cf
    26e4:	48 f7 e2             	mul    rdx
    26e7:	48 89 d0             	mov    rax,rdx
    26ea:	48 c1 e8 04          	shr    rax,0x4
				printf("As this CPU has a TSC a PIT tick corresponds to %llu "
    26ee:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 26f5 <calibrate_bogo_mips+0x2c6>
    26f5:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 26fc <calibrate_bogo_mips+0x2cd>
    26fc:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2703 <calibrate_bogo_mips+0x2d4>
    2703:	48 89 c6             	mov    rsi,rax
    2706:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    270d:	b8 00 00 00 00       	mov    eax,0x0
    2712:	e8 00 00 00 00       	call   2717 <calibrate_bogo_mips+0x2e8>
		}
}
    2717:	90                   	nop
    2718:	c9                   	leave
    2719:	c3                   	ret

000000000000271a <ndelay>:

void ndelay(unsigned long nsecs)
{
    271a:	55                   	push   rbp
    271b:	48 89 e5             	mov    rbp,rsp
    271e:	48 83 ec 18          	sub    rsp,0x18
    2722:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		uint32_t ct = 0, limit = (uint32_t)((uint64_t)nsecs * loops_per_ms / 1000000);
    2726:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    272d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2733 <ndelay+0x19>
    2733:	89 c0                	mov    eax,eax
    2735:	48 0f af 45 e8       	imul   rax,QWORD PTR [rbp-0x18]
    273a:	48 ba db 34 b6 d7 82 de 1b 43 	movabs rdx,0x431bde82d7b634db
    2744:	48 f7 e2             	mul    rdx
    2747:	48 89 d0             	mov    rax,rdx
    274a:	48 c1 e8 12          	shr    rax,0x12
    274e:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		/* uses the same double mem-access
		 * as in the calibration routine */
		for (ct = 0; ct < limit; ct++);
    2751:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    2758:	eb 04                	jmp    275e <ndelay+0x44>
    275a:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    275e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2761:	3b 45 f8             	cmp    eax,DWORD PTR [rbp-0x8]
    2764:	72 f4                	jb     275a <ndelay+0x40>
}
    2766:	90                   	nop
    2767:	90                   	nop
    2768:	c9                   	leave
    2769:	c3                   	ret

000000000000276a <udelay>:

void udelay(unsigned long usecs)
{
    276a:	55                   	push   rbp
    276b:	48 89 e5             	mov    rbp,rsp
    276e:	48 83 ec 08          	sub    rsp,0x8
    2772:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		while (usecs--)
    2776:	eb 0a                	jmp    2782 <udelay+0x18>
				ndelay(1000);
    2778:	bf e8 03 00 00       	mov    edi,0x3e8
    277d:	e8 00 00 00 00       	call   2782 <udelay+0x18>
		while (usecs--)
    2782:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2786:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    278a:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
    278e:	48 85 c0             	test   rax,rax
    2791:	75 e5                	jne    2778 <udelay+0xe>
}
    2793:	90                   	nop
    2794:	90                   	nop
    2795:	c9                   	leave
    2796:	c3                   	ret

0000000000002797 <mdelay>:

void mdelay(unsigned long msecs)
{
    2797:	55                   	push   rbp
    2798:	48 89 e5             	mov    rbp,rsp
    279b:	48 83 ec 08          	sub    rsp,0x8
    279f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		if (!loops_per_ms)
    27a3:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 27a9 <mdelay+0x12>
    27a9:	85 c0                	test   eax,eax
    27ab:	74 1f                	je     27cc <mdelay+0x35>
				return;
		while (msecs--)
    27ad:	eb 0a                	jmp    27b9 <mdelay+0x22>
				udelay(1000);
    27af:	bf e8 03 00 00       	mov    edi,0x3e8
    27b4:	e8 00 00 00 00       	call   27b9 <mdelay+0x22>
		while (msecs--)
    27b9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    27bd:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    27c1:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
    27c5:	48 85 c0             	test   rax,rax
    27c8:	75 e5                	jne    27af <mdelay+0x18>
    27ca:	eb 01                	jmp    27cd <mdelay+0x36>
				return;
    27cc:	90                   	nop
}
    27cd:	c9                   	leave
    27ce:	c3                   	ret

00000000000027cf <apic_expire>:
uint32_t apic_reload_value = 0x0fffffff;
uint8_t apic_div = 0x0b;
#define NCF_AP 48
static uint32_t n_ct = 0xffffffff, exp = 0; static uint32_t tmr_val = 0;
/* the expiration hook */
void apic_expire() {
    27cf:	55                   	push   rbp
    27d0:	48 89 e5             	mov    rbp,rsp
		if (!exp) /* don't unsignal 2 (done) */
    27d3:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 27d9 <apic_expire+0xa>
    27d9:	85 c0                	test   eax,eax
    27db:	75 0a                	jne    27e7 <apic_expire+0x18>
				exp = 1;
    27dd:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 27e7 <apic_expire+0x18>
}
    27e7:	90                   	nop
    27e8:	5d                   	pop    rbp
    27e9:	c3                   	ret

00000000000027ea <irq0_worker>:

/* the irq0 calibration worker */
void irq0_worker() {
    27ea:	55                   	push   rbp
    27eb:	48 89 e5             	mov    rbp,rsp
    27ee:	48 83 ec 10          	sub    rsp,0x10
		if (n_ct == 0xffffffff) {
    27f2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 27f8 <irq0_worker+0xe>
    27f8:	83 f8 ff             	cmp    eax,0xffffffff
    27fb:	75 2b                	jne    2828 <irq0_worker+0x3e>
				/* enable the timer */
				apic_bp_reg(APIC_REG_TMRDIV) = apic_div;
    27fd:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2804 <irq0_worker+0x1a>
    2804:	ba e0 03 ff ef       	mov    edx,0xefff03e0
    2809:	0f b6 c0             	movzx  eax,al
    280c:	89 02                	mov    DWORD PTR [rdx],eax
				apic_bp_reg(APIC_REG_TMRINITCNT) = 0xffffffff;
    280e:	b8 80 03 ff ef       	mov    eax,0xefff0380
    2813:	c7 00 ff ff ff ff    	mov    DWORD PTR [rax],0xffffffff
				n_ct = 0;
    2819:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 2823 <irq0_worker+0x39>
				return;
    2823:	e9 00 01 00 00       	jmp    2928 <irq0_worker+0x13e>
		} else if (exp) {
    2828:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 282e <irq0_worker+0x44>
    282e:	85 c0                	test   eax,eax
    2830:	0f 84 b4 00 00 00    	je     28ea <irq0_worker+0x100>
				/* timer has expired and sample is too small */
				n_ct = 0xffffffff; exp = 0; tmr_val = 0;
    2836:	c7 05 00 00 00 00 ff ff ff ff 	mov    DWORD PTR [rip+0x0],0xffffffff        # 2840 <irq0_worker+0x56>
    2840:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 284a <irq0_worker+0x60>
    284a:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 2854 <irq0_worker+0x6a>
				if (apic_div == 0x0b)
    2854:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 285b <irq0_worker+0x71>
    285b:	3c 0b                	cmp    al,0xb
    285d:	75 0c                	jne    286b <irq0_worker+0x81>
						apic_div = 1;
    285f:	c6 05 00 00 00 00 01 	mov    BYTE PTR [rip+0x0],0x1        # 2866 <irq0_worker+0x7c>
    2866:	e9 bd 00 00 00       	jmp    2928 <irq0_worker+0x13e>
				else {
						/* bits: 3210; 2=R=0, bin: 2-128, 1 */
						uint8_t val = (((apic_div & 0x08) >> 1) | (apic_div & 0x03));
    286b:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2872 <irq0_worker+0x88>
    2872:	0f b6 c0             	movzx  eax,al
    2875:	d1 f8                	sar    eax,1
    2877:	83 e0 04             	and    eax,0x4
    287a:	89 c2                	mov    edx,eax
    287c:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2883 <irq0_worker+0x99>
    2883:	83 e0 03             	and    eax,0x3
    2886:	09 d0                	or     eax,edx
    2888:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
						val++;
    288b:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    288f:	83 c0 01             	add    eax,0x1
    2892:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
						apic_div = ((val & 0x04) << 1) | (val & 0x03);
    2895:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    2899:	01 c0                	add    eax,eax
    289b:	83 e0 08             	and    eax,0x8
    289e:	89 c2                	mov    edx,eax
    28a0:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    28a4:	83 e0 03             	and    eax,0x3
    28a7:	09 d0                	or     eax,edx
    28a9:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 28af <irq0_worker+0xc5>
						if (apic_div == 0x0b)
    28af:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 28b6 <irq0_worker+0xcc>
    28b6:	3c 0b                	cmp    al,0xb
    28b8:	75 6e                	jne    2928 <irq0_worker+0x13e>
								die("unable to divide high enough!\n");
    28ba:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    28c1:	bf 0c 00 00 00       	mov    edi,0xc
    28c6:	b8 00 00 00 00       	mov    eax,0x0
    28cb:	e8 00 00 00 00       	call   28d0 <irq0_worker+0xe6>
    28d0:	b8 00 00 00 00       	mov    eax,0x0
    28d5:	e8 00 00 00 00       	call   28da <irq0_worker+0xf0>
    28da:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28e1:	e8 00 00 00 00       	call   28e6 <irq0_worker+0xfc>
    28e6:	fa                   	cli
    28e7:	f4                   	hlt
    28e8:	eb fd                	jmp    28e7 <irq0_worker+0xfd>
				}
		} else if (n_ct < NCF_AP - 1)
    28ea:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 28f0 <irq0_worker+0x106>
    28f0:	83 f8 2e             	cmp    eax,0x2e
    28f3:	77 11                	ja     2906 <irq0_worker+0x11c>
				n_ct++;
    28f5:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 28fb <irq0_worker+0x111>
    28fb:	83 c0 01             	add    eax,0x1
    28fe:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2904 <irq0_worker+0x11a>
    2904:	eb 22                	jmp    2928 <irq0_worker+0x13e>
		else {
				/* remove one of the hooks */
				tmr_val = apic_bp_reg(APIC_REG_TMRCURRCNT);
    2906:	b8 90 03 ff ef       	mov    eax,0xefff0390
    290b:	8b 00                	mov    eax,DWORD PTR [rax]
    290d:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2913 <irq0_worker+0x129>
				irq0_hook = NULL;
    2913:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 291e <irq0_worker+0x134>
				exp = 2;
    291e:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR [rip+0x0],0x2        # 2928 <irq0_worker+0x13e>
		}
}
    2928:	c9                   	leave
    2929:	c3                   	ret

000000000000292a <apic_timer_setup>:

/* function is already during preemption */
void apic_timer_setup()
{
    292a:	55                   	push   rbp
    292b:	48 89 e5             	mov    rbp,rsp
    292e:	48 83 ec 10          	sub    rsp,0x10
		/* strategy: set a irq0-hook which initializes the apic timer
		 * and reads the count(s) on the next iteration(s). If the
		 * APIC timer expires before completion the divider is increased. */

		/* enable the timer function of the BP */
		printf("calibrating BP APIC timer...\n");
    2932:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2939:	b8 00 00 00 00       	mov    eax,0x0
    293e:	e8 00 00 00 00       	call   2943 <apic_timer_setup+0x19>
		/* (val << 16): R00M=one-shot, R01M per, R11M tsc, R=res, M=mask */
		apic_bp_reg(APIC_REG_LVT_TMR) = 0x00000000 | 0x3d; /* one-shot */
    2943:	b8 20 03 ff ef       	mov    eax,0xefff0320
    2948:	c7 00 3d 00 00 00    	mov    DWORD PTR [rax],0x3d

		/* now perform the work */
		preempt_disable();
    294e:	b8 00 00 00 00       	mov    eax,0x0
    2953:	e8 00 00 00 00       	call   2958 <apic_timer_setup+0x2e>
    2958:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    295b:	83 c2 01             	add    edx,0x1
    295e:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		apic_hook = apic_expire;
    2961:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 296c <apic_timer_setup+0x42>
		irq0_hook = irq0_worker;
    296c:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 2977 <apic_timer_setup+0x4d>

		/* wait for completion */
		while (exp != 2);
    2977:	90                   	nop
    2978:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 297e <apic_timer_setup+0x54>
    297e:	83 f8 02             	cmp    eax,0x2
    2981:	75 f5                	jne    2978 <apic_timer_setup+0x4e>

		/* disarm the bp timer for now */
		apic_bp_reg(APIC_REG_TMRINITCNT) = 0;
    2983:	b8 80 03 ff ef       	mov    eax,0xefff0380
    2988:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0

		/* remove the apic hook (possible rc? nope; intr preempts this)*/
		apic_hook = NULL;
    298e:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 2999 <apic_timer_setup+0x6f>

		/* reenable preemption */
		preempt_enable();
    2999:	b8 00 00 00 00       	mov    eax,0x0
    299e:	e8 00 00 00 00       	call   29a3 <apic_timer_setup+0x79>
    29a3:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    29a6:	83 ea 01             	sub    edx,0x1
    29a9:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
    29ac:	b8 00 00 00 00       	mov    eax,0x0
    29b1:	e8 00 00 00 00       	call   29b6 <apic_timer_setup+0x8c>
    29b6:	8b 00                	mov    eax,DWORD PTR [rax]
    29b8:	83 e0 01             	and    eax,0x1
    29bb:	85 c0                	test   eax,eax
    29bd:	74 0a                	je     29c9 <apic_timer_setup+0x9f>
    29bf:	b8 00 00 00 00       	mov    eax,0x0
    29c4:	e8 00 00 00 00       	call   29c9 <apic_timer_setup+0x9f>

		/* calculate the tick values */
		tmr_val = (0xffffffff - tmr_val) / NCF_AP;
    29c9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 29cf <apic_timer_setup+0xa5>
    29cf:	f7 d0                	not    eax
    29d1:	89 c2                	mov    edx,eax
    29d3:	b8 ab aa aa aa       	mov    eax,0xaaaaaaab
    29d8:	48 0f af c2          	imul   rax,rdx
    29dc:	48 c1 e8 20          	shr    rax,0x20
    29e0:	c1 e8 05             	shr    eax,0x5
    29e3:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 29e9 <apic_timer_setup+0xbf>
		printf("On average: %08x APIC timer ticks per PIT interrupt.\n", tmr_val);
    29e9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 29ef <apic_timer_setup+0xc5>
    29ef:	89 c6                	mov    esi,eax
    29f1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29f8:	b8 00 00 00 00       	mov    eax,0x0
    29fd:	e8 00 00 00 00       	call   2a02 <apic_timer_setup+0xd8>
		apic_reload_value = tmr_val;
    2a02:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2a08 <apic_timer_setup+0xde>
    2a08:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2a0e <apic_timer_setup+0xe4>
		{
				uint64_t freq = ((uint64_t)HZ * tmr_val);
    2a0e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2a14 <apic_timer_setup+0xea>
    2a14:	89 c2                	mov    edx,eax
    2a16:	48 89 d0             	mov    rax,rdx
    2a19:	48 c1 e0 04          	shl    rax,0x4
    2a1d:	48 29 d0             	sub    rax,rdx
    2a20:	48 c1 e0 03          	shl    rax,0x3
    2a24:	48 01 d0             	add    rax,rdx
    2a27:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				uint32_t mhz = (uint32_t)(freq / 1000000);
    2a2b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2a2f:	48 ba db 34 b6 d7 82 de 1b 43 	movabs rdx,0x431bde82d7b634db
    2a39:	48 f7 e2             	mul    rdx
    2a3c:	48 89 d0             	mov    rax,rdx
    2a3f:	48 c1 e8 12          	shr    rax,0x12
    2a43:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
				uint32_t khz = (uint32_t)(freq % 1000000) / 1000;
    2a46:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    2a4a:	48 ba db 34 b6 d7 82 de 1b 43 	movabs rdx,0x431bde82d7b634db
    2a54:	48 89 c8             	mov    rax,rcx
    2a57:	48 f7 e2             	mul    rdx
    2a5a:	48 89 d0             	mov    rax,rdx
    2a5d:	48 c1 e8 12          	shr    rax,0x12
    2a61:	48 69 d0 40 42 0f 00 	imul   rdx,rax,0xf4240
    2a68:	48 89 c8             	mov    rax,rcx
    2a6b:	48 29 d0             	sub    rax,rdx
    2a6e:	89 c0                	mov    eax,eax
    2a70:	48 69 c0 d3 4d 62 10 	imul   rax,rax,0x10624dd3
    2a77:	48 c1 e8 20          	shr    rax,0x20
    2a7b:	c1 e8 06             	shr    eax,0x6
    2a7e:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				cprintf(KFMT_INFO, "This results in an APIC timer frequency of %u.%03u MHz\n",
    2a81:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
    2a84:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    2a87:	89 d1                	mov    ecx,edx
    2a89:	89 c2                	mov    edx,eax
    2a8b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2a92:	bf 0b 00 00 00       	mov    edi,0xb
    2a97:	b8 00 00 00 00       	mov    eax,0x0
    2a9c:	e8 00 00 00 00       	call   2aa1 <apic_timer_setup+0x177>
						mhz, khz);
		}
}
    2aa1:	90                   	nop
    2aa2:	c9                   	leave
    2aa3:	c3                   	ret

0000000000002aa4 <timer_setup>:

void timer_setup()
{
    2aa4:	55                   	push   rbp
    2aa5:	48 89 e5             	mov    rbp,rsp
    2aa8:	48 81 ec a0 00 00 00 	sub    rsp,0xa0
		uint8_t bt; const char* ams[4] = {"latch", "lo", "hi", "lo/hi"};
    2aaf:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    2ab7:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    2abf:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    2ac7:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		uint16_t div; uint64_t tmv;
		const char* oms[8] = {
    2acf:	48 c7 45 90 00 00 00 00 	mov    QWORD PTR [rbp-0x70],0x0
    2ad7:	48 c7 45 98 00 00 00 00 	mov    QWORD PTR [rbp-0x68],0x0
    2adf:	48 c7 45 a0 00 00 00 00 	mov    QWORD PTR [rbp-0x60],0x0
    2ae7:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
    2aef:	48 c7 45 b0 00 00 00 00 	mov    QWORD PTR [rbp-0x50],0x0
    2af7:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
    2aff:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
    2b07:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
				"int on count", "one-shot counter",
				"rate generator", "square wave generator",
				"software strobe", "hardware strobe",
				"rate generator", "square wave generator"
		};
		__asm__("cli");
    2b0f:	fa                   	cli
		km_time = cmos_get_time();
    2b10:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    2b17:	48 89 c7             	mov    rdi,rax
    2b1a:	b8 00 00 00 00       	mov    eax,0x0
    2b1f:	e8 00 00 00 00       	call   2b24 <timer_setup+0x80>
    2b24:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    2b2b:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b32 <timer_setup+0x8e>
    2b32:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    2b39:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b40 <timer_setup+0x9c>
    2b40:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    2b47:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b4e <timer_setup+0xaa>
    2b4e:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    2b55:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b5c <timer_setup+0xb8>
    2b5c:	8b 45 80             	mov    eax,DWORD PTR [rbp-0x80]
    2b5f:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2b65 <timer_setup+0xc1>
		km_set = jiffies; /* should be counter but alas */
    2b65:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b6c <timer_setup+0xc8>
    2b6c:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2b6f:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b76 <timer_setup+0xd2>
		/* get info on the status of the timer */
		outb(PIT1_CTR, 0b11010010); /* latch status of CH0 */
    2b76:	be d2 00 00 00       	mov    esi,0xd2
    2b7b:	bf 43 00 00 00       	mov    edi,0x43
    2b80:	e8 a4 d4 ff ff       	call   29 <outb>
		bt = inb(PIT1_CH0);
    2b85:	bf 40 00 00 00       	mov    edi,0x40
    2b8a:	e8 b9 d4 ff ff       	call   48 <inb>
    2b8f:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
		printf("PIT1_CH0 status is %08b\n", bt);
    2b92:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    2b96:	89 c6                	mov    esi,eax
    2b98:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2b9f:	b8 00 00 00 00       	mov    eax,0x0
    2ba4:	e8 00 00 00 00       	call   2ba9 <timer_setup+0x105>
		printf("with access mode: %s\n", ams[(bt >> 4) & 0x03]);
    2ba9:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    2bad:	c0 e8 04             	shr    al,0x4
    2bb0:	0f b6 c0             	movzx  eax,al
    2bb3:	83 e0 03             	and    eax,0x3
    2bb6:	48 98                	cdqe
    2bb8:	48 8b 44 c5 d0       	mov    rax,QWORD PTR [rbp+rax*8-0x30]
    2bbd:	48 89 c6             	mov    rsi,rax
    2bc0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2bc7:	b8 00 00 00 00       	mov    eax,0x0
    2bcc:	e8 00 00 00 00       	call   2bd1 <timer_setup+0x12d>
		printf("and operating mode: %s\n", oms[(bt >> 1) & 0x07]);
    2bd1:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    2bd5:	d0 e8                	shr    al,1
    2bd7:	0f b6 c0             	movzx  eax,al
    2bda:	83 e0 07             	and    eax,0x7
    2bdd:	48 98                	cdqe
    2bdf:	48 8b 44 c5 90       	mov    rax,QWORD PTR [rbp+rax*8-0x70]
    2be4:	48 89 c6             	mov    rsi,rax
    2be7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2bee:	b8 00 00 00 00       	mov    eax,0x0
    2bf3:	e8 00 00 00 00       	call   2bf8 <timer_setup+0x154>
		/* change the mode */
		printf("timer will be set to rate generator lo/hi mode\n");
    2bf8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2bff:	b8 00 00 00 00       	mov    eax,0x0
    2c04:	e8 00 00 00 00       	call   2c09 <timer_setup+0x165>
		outb(PIT1_CTR, 0b00110110); /* binary CH0 lohi rategen */
    2c09:	be 36 00 00 00       	mov    esi,0x36
    2c0e:	bf 43 00 00 00       	mov    edi,0x43
    2c13:	e8 11 d4 ff ff       	call   29 <outb>
		/* and the divisor */
		printf("divisor for HZ=%d: %u\n", HZ, 1193182u / HZ);
    2c18:	ba 85 26 00 00       	mov    edx,0x2685
    2c1d:	be 79 00 00 00       	mov    esi,0x79
    2c22:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c29:	b8 00 00 00 00       	mov    eax,0x0
    2c2e:	e8 00 00 00 00       	call   2c33 <timer_setup+0x18f>
		//div = 9861; //11931; //0xffff;
		div = 1193182u / HZ;
    2c33:	66 c7 45 fc 85 26    	mov    WORD PTR [rbp-0x4],0x2685
		//printf("with a divisor of %u\n", div);
		//printf("resulting in a frequency of ~%u Hz\n", 1193182u / div);
		outb(PIT1_CH0, div & 0xff);
    2c39:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    2c3d:	0f b6 c0             	movzx  eax,al
    2c40:	89 c6                	mov    esi,eax
    2c42:	bf 40 00 00 00       	mov    edi,0x40
    2c47:	e8 dd d3 ff ff       	call   29 <outb>
		outb(PIT1_CH0, (div >> 8) & 0xff);
    2c4c:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    2c50:	66 c1 e8 08          	shr    ax,0x8
    2c54:	0f b6 c0             	movzx  eax,al
    2c57:	89 c6                	mov    esi,eax
    2c59:	bf 40 00 00 00       	mov    edi,0x40
    2c5e:	e8 c6 d3 ff ff       	call   29 <outb>
		__asm__("sti");
    2c63:	fb                   	sti
		calibrate_bogo_mips(div);
    2c64:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    2c68:	89 c7                	mov    edi,eax
    2c6a:	e8 00 00 00 00       	call   2c6f <timer_setup+0x1cb>
		printf("done\n");
    2c6f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c76:	b8 00 00 00 00       	mov    eax,0x0
    2c7b:	e8 00 00 00 00       	call   2c80 <timer_setup+0x1dc>
		/* testing the resolution */
		printf("delaying execution for 200 ms...\n");
    2c80:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c87:	b8 00 00 00 00       	mov    eax,0x0
    2c8c:	e8 00 00 00 00       	call   2c91 <timer_setup+0x1ed>
		tmv = jiffies;
    2c91:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2c98 <timer_setup+0x1f4>
    2c98:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2c9b:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		mdelay(200);
    2c9f:	bf c8 00 00 00       	mov    edi,0xc8
    2ca4:	e8 00 00 00 00       	call   2ca9 <timer_setup+0x205>
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
				" to %u ms, resulting in a deviation of %+d ms\n",
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
				(int32_t)((jiffies - tmv) * 1000 / HZ) - 200);
    2ca9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2cb0 <timer_setup+0x20c>
    2cb0:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2cb3:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    2cb7:	48 69 c8 e8 03 00 00 	imul   rcx,rax,0x3e8
    2cbe:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    2cc8:	48 89 c8             	mov    rax,rcx
    2ccb:	48 f7 e2             	mul    rdx
    2cce:	48 89 c8             	mov    rax,rcx
    2cd1:	48 29 d0             	sub    rax,rdx
    2cd4:	48 d1 e8             	shr    rax,1
    2cd7:	48 01 d0             	add    rax,rdx
    2cda:	48 c1 e8 06          	shr    rax,0x6
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2cde:	8d b0 38 ff ff ff    	lea    esi,[rax-0xc8]
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
    2ce4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2ceb <timer_setup+0x247>
    2ceb:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2cee:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    2cf2:	48 69 c8 e8 03 00 00 	imul   rcx,rax,0x3e8
    2cf9:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    2d03:	48 89 c8             	mov    rax,rcx
    2d06:	48 f7 e2             	mul    rdx
    2d09:	48 89 c8             	mov    rax,rcx
    2d0c:	48 29 d0             	sub    rax,rdx
    2d0f:	48 d1 e8             	shr    rax,1
    2d12:	48 01 d0             	add    rax,rdx
    2d15:	48 c1 e8 06          	shr    rax,0x6
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2d19:	89 c7                	mov    edi,eax
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
    2d1b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2d22 <timer_setup+0x27e>
    2d22:	48 8b 00             	mov    rax,QWORD PTR [rax]
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
    2d25:	89 c1                	mov    ecx,eax
    2d27:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2d2b:	89 c2                	mov    edx,eax
    2d2d:	89 c8                	mov    eax,ecx
    2d2f:	29 d0                	sub    eax,edx
    2d31:	41 89 f1             	mov    r9d,esi
    2d34:	41 89 f8             	mov    r8d,edi
    2d37:	b9 79 00 00 00       	mov    ecx,0x79
    2d3c:	89 c2                	mov    edx,eax
    2d3e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2d45:	bf 0b 00 00 00       	mov    edi,0xb
    2d4a:	b8 00 00 00 00       	mov    eax,0x0
    2d4f:	e8 00 00 00 00       	call   2d54 <timer_setup+0x2b0>
}
    2d54:	90                   	nop
    2d55:	c9                   	leave
    2d56:	c3                   	ret

0000000000002d57 <apic_tick>:

//uint32_t apic_tick_ct = 0;
void apic_tick()
{
    2d57:	55                   	push   rbp
    2d58:	48 89 e5             	mov    rbp,rsp
		//apic_tick_ct++;
		//if (apic_tick_ct % (10 * nproc * HZ) == 0)
		//		printf("APIC %08x received timer interrupt (global ct=%u)\n",
		//				apic_reg(APIC_REG_APICID), apic_tick_ct);
		apic_reg(APIC_REG_TMRINITCNT) = apic_reload_value;
    2d5b:	b8 00 00 00 00       	mov    eax,0x0
    2d60:	e8 9b d2 ff ff       	call   0 <per_cpu_ptr>
    2d65:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2d69:	48 8d 90 80 03 00 00 	lea    rdx,[rax+0x380]
    2d70:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2d76 <apic_tick+0x1f>
    2d76:	89 02                	mov    DWORD PTR [rdx],eax
		per_cpu_ptr()->ticks->tick++;
    2d78:	b8 00 00 00 00       	mov    eax,0x0
    2d7d:	e8 7e d2 ff ff       	call   0 <per_cpu_ptr>
    2d82:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2d86:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    2d89:	48 83 c2 01          	add    rdx,0x1
    2d8d:	48 89 10             	mov    QWORD PTR [rax],rdx
}
    2d90:	90                   	nop
    2d91:	5d                   	pop    rbp
    2d92:	c3                   	ret

0000000000002d93 <apic_ipi>:

void apic_ipi()
{
    2d93:	55                   	push   rbp
    2d94:	48 89 e5             	mov    rbp,rsp
    2d97:	53                   	push   rbx
    2d98:	48 83 ec 08          	sub    rsp,0x8
		printf("APIC %x (TPR=%x) received IPI\n", apic_reg(APIC_REG_APICID),
				apic_reg(APIC_REG_TASKPRIOR));
    2d9c:	b8 00 00 00 00       	mov    eax,0x0
    2da1:	e8 5a d2 ff ff       	call   0 <per_cpu_ptr>
    2da6:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2daa:	48 83 e8 80          	sub    rax,0xffffffffffffff80
		printf("APIC %x (TPR=%x) received IPI\n", apic_reg(APIC_REG_APICID),
    2dae:	8b 18                	mov    ebx,DWORD PTR [rax]
    2db0:	b8 00 00 00 00       	mov    eax,0x0
    2db5:	e8 46 d2 ff ff       	call   0 <per_cpu_ptr>
    2dba:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2dbe:	48 83 c0 20          	add    rax,0x20
    2dc2:	8b 00                	mov    eax,DWORD PTR [rax]
    2dc4:	89 da                	mov    edx,ebx
    2dc6:	89 c6                	mov    esi,eax
    2dc8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2dcf:	b8 00 00 00 00       	mov    eax,0x0
    2dd4:	e8 00 00 00 00       	call   2dd9 <apic_ipi+0x46>
		//printf("Current timer value %x\n", apic_reg(APIC_REG_TMRCURRCNT));
}
    2dd9:	90                   	nop
    2dda:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    2dde:	c9                   	leave
    2ddf:	c3                   	ret

0000000000002de0 <ap_entry>:

/* kernel entry point of APs */
extern void ap_entry()
{
    2de0:	55                   	push   rbp
    2de1:	48 89 e5             	mov    rbp,rsp
		void enable_sse();
		enable_sse(); /* avoid hangups form sched. kredraw (using sse) */
    2de4:	b8 00 00 00 00       	mov    eax,0x0
    2de9:	e8 00 00 00 00       	call   2dee <ap_entry+0xe>
		/* local APIC init */
		extern void ap_apic_init(); /* PCP works afterwards */
		ap_apic_init();
    2dee:	b8 00 00 00 00       	mov    eax,0x0
    2df3:	e8 00 00 00 00       	call   2df8 <ap_entry+0x18>
		/* prevent death by empty queues */
		extern void kidle(void*);
		/* two per proc for the worst-case */
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2df8:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2dff:	ba 03 00 00 00       	mov    edx,0x3
    2e04:	be 00 00 00 00       	mov    esi,0x0
    2e09:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e10:	e8 00 00 00 00       	call   2e15 <ap_entry+0x35>
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2e15:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2e1c:	ba 03 00 00 00       	mov    edx,0x3
    2e21:	be 00 00 00 00       	mov    esi,0x0
    2e26:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e2d:	e8 00 00 00 00       	call   2e32 <ap_entry+0x52>
		/* signal we don't need the trampoline anymore */
		extern uint8_t ap_start;
		ap_start = 0; /* still unsafe as task_schedule builds a stack frame */
    2e32:	c6 05 00 00 00 00 00 	mov    BYTE PTR [rip+0x0],0x0        # 2e39 <ap_entry+0x59>
		/* TODO: per-cpu tasks & runqueues */
		/* switch to stack of task (sti included in eflags of tasks) */
		extern void task_schedule(struct tsi*);
		task_schedule(NULL);
    2e39:	bf 00 00 00 00       	mov    edi,0x0
    2e3e:	e8 00 00 00 00       	call   2e43 <ap_entry+0x63>
		/* should never return */
		while (1); /* DBG: busy wait */
    2e43:	90                   	nop
    2e44:	eb fd                	jmp    2e43 <ap_entry+0x63>

0000000000002e46 <apic_handler>:
 * TSS stacks can also be transferred between processors -> all stacks bound to
 * tasks, i.e. no processor-specific stacks needed.
 */

extern void apic_handler(uint32_t intr)
{
    2e46:	55                   	push   rbp
    2e47:	48 89 e5             	mov    rbp,rsp
    2e4a:	53                   	push   rbx
    2e4b:	48 83 ec 28          	sub    rsp,0x28
    2e4f:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi
		static uint32_t num_spr = 0;
		switch (intr) {
    2e52:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2e55:	83 f8 03             	cmp    eax,0x3
    2e58:	0f 84 0c 01 00 00    	je     2f6a <apic_handler+0x124>
    2e5e:	83 f8 03             	cmp    eax,0x3
    2e61:	0f 87 14 01 00 00    	ja     2f7b <apic_handler+0x135>
    2e67:	83 f8 02             	cmp    eax,0x2
    2e6a:	0f 84 d4 00 00 00    	je     2f44 <apic_handler+0xfe>
    2e70:	83 f8 02             	cmp    eax,0x2
    2e73:	0f 87 02 01 00 00    	ja     2f7b <apic_handler+0x135>
    2e79:	85 c0                	test   eax,eax
    2e7b:	74 0a                	je     2e87 <apic_handler+0x41>
    2e7d:	83 f8 01             	cmp    eax,0x1
    2e80:	74 7d                	je     2eff <apic_handler+0xb9>
    2e82:	e9 f4 00 00 00       	jmp    2f7b <apic_handler+0x135>
			case 0:
				printf("APIC %x received error %08x\n",
					apic_reg(APIC_REG_APICID), apic_reg(APIC_REG_ESR));
    2e87:	b8 00 00 00 00       	mov    eax,0x0
    2e8c:	e8 6f d1 ff ff       	call   0 <per_cpu_ptr>
    2e91:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2e95:	48 05 80 02 00 00    	add    rax,0x280
				printf("APIC %x received error %08x\n",
    2e9b:	8b 18                	mov    ebx,DWORD PTR [rax]
					apic_reg(APIC_REG_APICID), apic_reg(APIC_REG_ESR));
    2e9d:	b8 00 00 00 00       	mov    eax,0x0
    2ea2:	e8 59 d1 ff ff       	call   0 <per_cpu_ptr>
    2ea7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2eab:	48 83 c0 20          	add    rax,0x20
				printf("APIC %x received error %08x\n",
    2eaf:	8b 00                	mov    eax,DWORD PTR [rax]
    2eb1:	89 da                	mov    edx,ebx
    2eb3:	89 c6                	mov    esi,eax
    2eb5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ebc:	b8 00 00 00 00       	mov    eax,0x0
    2ec1:	e8 00 00 00 00       	call   2ec6 <apic_handler+0x80>
				/* rearm the error register */
				apic_reg(APIC_REG_ESR) = 0;
    2ec6:	b8 00 00 00 00       	mov    eax,0x0
    2ecb:	e8 30 d1 ff ff       	call   0 <per_cpu_ptr>
    2ed0:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2ed4:	48 05 80 02 00 00    	add    rax,0x280
    2eda:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				apic_reg(APIC_REG_EOI) = 0;
    2ee0:	b8 00 00 00 00       	mov    eax,0x0
    2ee5:	e8 16 d1 ff ff       	call   0 <per_cpu_ptr>
    2eea:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2eee:	48 05 b0 00 00 00    	add    rax,0xb0
    2ef4:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				break;
    2efa:	e9 98 00 00 00       	jmp    2f97 <apic_handler+0x151>
			case 1: {
				void (*hook)() = apic_hook;
    2eff:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2f06 <apic_handler+0xc0>
    2f06:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (hook)
    2f0a:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2f0f:	74 0d                	je     2f1e <apic_handler+0xd8>
						hook();
    2f11:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2f15:	b8 00 00 00 00       	mov    eax,0x0
    2f1a:	ff d2                	call   rdx
    2f1c:	eb 0a                	jmp    2f28 <apic_handler+0xe2>
				else
						apic_tick();
    2f1e:	b8 00 00 00 00       	mov    eax,0x0
    2f23:	e8 00 00 00 00       	call   2f28 <apic_handler+0xe2>
				apic_reg(APIC_REG_EOI) = 0;
    2f28:	b8 00 00 00 00       	mov    eax,0x0
    2f2d:	e8 ce d0 ff ff       	call   0 <per_cpu_ptr>
    2f32:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2f36:	48 05 b0 00 00 00    	add    rax,0xb0
    2f3c:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				break;
    2f42:	eb 53                	jmp    2f97 <apic_handler+0x151>
				}
			case 2:
				apic_ipi();
    2f44:	b8 00 00 00 00       	mov    eax,0x0
    2f49:	e8 00 00 00 00       	call   2f4e <apic_handler+0x108>
				apic_reg(APIC_REG_EOI) = 0;
    2f4e:	b8 00 00 00 00       	mov    eax,0x0
    2f53:	e8 a8 d0 ff ff       	call   0 <per_cpu_ptr>
    2f58:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2f5c:	48 05 b0 00 00 00    	add    rax,0xb0
    2f62:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
				break;
    2f68:	eb 2d                	jmp    2f97 <apic_handler+0x151>
			case 3: /* don't ack the spurious interrupt */
				num_spr++;
    2f6a:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2f70 <apic_handler+0x12a>
    2f70:	83 c0 01             	add    eax,0x1
    2f73:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2f79 <apic_handler+0x133>
				break;
    2f79:	eb 1c                	jmp    2f97 <apic_handler+0x151>
			default:
				cprintf(KFMT_WARN, "unknown APIC intr %x received\n", intr);
    2f7b:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2f7e:	89 c2                	mov    edx,eax
    2f80:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2f87:	bf 0e 00 00 00       	mov    edi,0xe
    2f8c:	b8 00 00 00 00       	mov    eax,0x0
    2f91:	e8 00 00 00 00       	call   2f96 <apic_handler+0x150>
				break;
    2f96:	90                   	nop
		}
		if (intr == 1) {
    2f97:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2f9a:	83 f8 01             	cmp    eax,0x1
    2f9d:	75 13                	jne    2fb2 <apic_handler+0x16c>
				void task_schedule_isr(void*);
				task_schedule_isr(*(void**)(&intr + 1));
    2f9f:	48 8d 45 dc          	lea    rax,[rbp-0x24]
    2fa3:	48 83 c0 04          	add    rax,0x4
    2fa7:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2faa:	48 89 c7             	mov    rdi,rax
    2fad:	e8 00 00 00 00       	call   2fb2 <apic_handler+0x16c>
		}
}
    2fb2:	90                   	nop
    2fb3:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    2fb7:	c9                   	leave
    2fb8:	c3                   	ret

0000000000002fb9 <fun2>:

static int calc_state = 0, calc_thr = 0, calc_print = 0;

void fun2(uint32_t* f) {
    2fb9:	55                   	push   rbp
    2fba:	48 89 e5             	mov    rbp,rsp
    2fbd:	48 83 ec 20          	sub    rsp,0x20
    2fc1:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		while (1) {
				if (!calc_state)
    2fc5:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2fcb <fun2+0x12>
    2fcb:	85 c0                	test   eax,eax
    2fcd:	75 0c                	jne    2fdb <fun2+0x22>
						task_yield();
    2fcf:	b8 00 00 00 00       	mov    eax,0x0
    2fd4:	e8 00 00 00 00       	call   2fd9 <fun2+0x20>
    2fd9:	eb 29                	jmp    3004 <fun2+0x4b>
				else {
						int v = calc_thr;
    2fdb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2fe1 <fun2+0x28>
    2fe1:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
						if ((v < 1) && __sync_bool_compare_and_swap(&calc_thr, v, v + 1))
    2fe4:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    2fe8:	7f 1a                	jg     3004 <fun2+0x4b>
    2fea:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    2fed:	83 c0 01             	add    eax,0x1
    2ff0:	89 c2                	mov    edx,eax
    2ff2:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    2ff5:	f0 0f b1 15 00 00 00 00 	lock cmpxchg DWORD PTR [rip+0x0],edx        # 2ffd <fun2+0x44>
    2ffd:	0f 94 c0             	sete   al
    3000:	84 c0                	test   al,al
    3002:	75 24                	jne    3028 <fun2+0x6f>
								break;
				}
				for (size_t i = 0; i < 0xffffffff; i++);
    3004:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    300c:	eb 05                	jmp    3013 <fun2+0x5a>
    300e:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    3013:	b8 fe ff ff ff       	mov    eax,0xfffffffe
    3018:	48 3b 45 f8          	cmp    rax,QWORD PTR [rbp-0x8]
    301c:	73 f0                	jae    300e <fun2+0x55>
				__sync_fetch_and_add(f, 1);
    301e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3022:	f0 83 00 01          	lock add DWORD PTR [rax],0x1
				if (!calc_state)
    3026:	eb 9d                	jmp    2fc5 <fun2+0xc>
								break;
    3028:	90                   	nop
		}
}
    3029:	90                   	nop
    302a:	c9                   	leave
    302b:	c3                   	ret

000000000000302c <calc_thread>:

void calc_thread(void* data)
{
    302c:	55                   	push   rbp
    302d:	48 89 e5             	mov    rbp,rsp
    3030:	48 83 ec 30          	sub    rsp,0x30
    3034:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		uint32_t val = 0; uint64_t to = 0; int upd;
    3038:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
    303f:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		calc_state = 1;
    3047:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 3051 <calc_thread+0x25>
		/* test er */
		/* here we do the integer calculations */
		while (1) {
				if (!calc_state)
    3051:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3057 <calc_thread+0x2b>
    3057:	85 c0                	test   eax,eax
    3059:	75 0a                	jne    3065 <calc_thread+0x39>
						task_yield();
    305b:	b8 00 00 00 00       	mov    eax,0x0
    3060:	e8 00 00 00 00       	call   3065 <calc_thread+0x39>
				for (size_t i = 0; i < 0xffffffff; i++);
    3065:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    306d:	eb 05                	jmp    3074 <calc_thread+0x48>
    306f:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    3074:	b8 fe ff ff ff       	mov    eax,0xfffffffe
    3079:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    307d:	73 f0                	jae    306f <calc_thread+0x43>
				__sync_fetch_and_add(&val, 1);
    307f:	f0 83 45 e8 01       	lock add DWORD PTR [rbp-0x18],0x1
				upd = time_after(jiffies, to);
    3084:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 308b <calc_thread+0x5f>
    308b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    308e:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    3092:	48 29 c2             	sub    rdx,rax
    3095:	48 89 d0             	mov    rax,rdx
    3098:	48 c1 e8 3f          	shr    rax,0x3f
    309c:	0f b6 c0             	movzx  eax,al
    309f:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
				if (calc_print == 1 || (calc_print == 2 && upd)){
    30a2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 30a8 <calc_thread+0x7c>
    30a8:	83 f8 01             	cmp    eax,0x1
    30ab:	74 11                	je     30be <calc_thread+0x92>
    30ad:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 30b3 <calc_thread+0x87>
    30b3:	83 f8 02             	cmp    eax,0x2
    30b6:	75 77                	jne    312f <calc_thread+0x103>
    30b8:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    30bc:	74 71                	je     312f <calc_thread+0x103>
						printf("calculation result: %u\n", val);
    30be:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    30c1:	89 c6                	mov    esi,eax
    30c3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    30ca:	b8 00 00 00 00       	mov    eax,0x0
    30cf:	e8 00 00 00 00       	call   30d4 <calc_thread+0xa8>
						if (calc_print == 2)
    30d4:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 30da <calc_thread+0xae>
    30da:	83 f8 02             	cmp    eax,0x2
    30dd:	75 16                	jne    30f5 <calc_thread+0xc9>
								to = jiffies + 5 * HZ; /* print every 5 seconds */
    30df:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 30e6 <calc_thread+0xba>
    30e6:	48 8b 00             	mov    rax,QWORD PTR [rax]
    30e9:	48 05 5d 02 00 00    	add    rax,0x25d
    30ef:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    30f3:	eb 3a                	jmp    312f <calc_thread+0x103>
						else
								calc_print = 0; /* print once */
    30f5:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 30ff <calc_thread+0xd3>
				}
				while (calc_thr >= 2) {
    30ff:	eb 2e                	jmp    312f <calc_thread+0x103>
						task_spawn(fun2, &val, PRIORITY_REGULAR);
    3101:	48 8d 45 e8          	lea    rax,[rbp-0x18]
    3105:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    310c:	ba 02 00 00 00       	mov    edx,0x2
    3111:	48 89 c6             	mov    rsi,rax
    3114:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    311b:	e8 00 00 00 00       	call   3120 <calc_thread+0xf4>
						calc_thr--;
    3120:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3126 <calc_thread+0xfa>
    3126:	83 e8 01             	sub    eax,0x1
    3129:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 312f <calc_thread+0x103>
				while (calc_thr >= 2) {
    312f:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3135 <calc_thread+0x109>
    3135:	83 f8 01             	cmp    eax,0x1
    3138:	7f c7                	jg     3101 <calc_thread+0xd5>
				if (!calc_state)
    313a:	e9 12 ff ff ff       	jmp    3051 <calc_thread+0x25>

000000000000313f <calc_fun>:
				}
		}
}

void calc_fun(const char* arg)
{
    313f:	55                   	push   rbp
    3140:	48 89 e5             	mov    rbp,rsp
    3143:	48 83 ec 20          	sub    rsp,0x20
    3147:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int sel = atoi(arg);
    314b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    314f:	48 89 c7             	mov    rdi,rax
    3152:	e8 00 00 00 00       	call   3157 <calc_fun+0x18>
    3157:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		switch (sel) {
    315a:	83 7d fc 09          	cmp    DWORD PTR [rbp-0x4],0x9
    315e:	77 0d                	ja     316d <calc_fun+0x2e>
    3160:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3163:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    316b:	ff e0                	jmp    rax
			case 0:
			default:
				printf("calc arg: starts/stops and shows the background\n"
    316d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3174:	b8 00 00 00 00       	mov    eax,0x0
    3179:	e8 00 00 00 00       	call   317e <calc_fun+0x3f>
					   "          5 - add a worker thread\n"
					   "          6 - add 5 worker threads\n"
					   "          7 - add 15 worker threads\n"
					   "          8 - remove a worker thread\n"
					   "          9 - remove 5 worker threads\n");
				break;
    317e:	e9 06 01 00 00       	jmp    3289 <calc_fun+0x14a>
			case 1:
				calc_state = 0;
    3183:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 318d <calc_fun+0x4e>
				break;
    318d:	e9 f7 00 00 00       	jmp    3289 <calc_fun+0x14a>
			case 2:
				if (!calc_thr) {
    3192:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3198 <calc_fun+0x59>
    3198:	85 c0                	test   eax,eax
    319a:	75 2c                	jne    31c8 <calc_fun+0x89>
						task_spawn(calc_thread, NULL, PRIORITY_REGULAR);
    319c:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    31a3:	ba 02 00 00 00       	mov    edx,0x2
    31a8:	be 00 00 00 00       	mov    esi,0x0
    31ad:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    31b4:	e8 00 00 00 00       	call   31b9 <calc_fun+0x7a>
						calc_thr = 1;
    31b9:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 31c3 <calc_fun+0x84>
						//calc_state = 1;
				} else
						calc_state = 1;
				break;
    31c3:	e9 c1 00 00 00       	jmp    3289 <calc_fun+0x14a>
						calc_state = 1;
    31c8:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 31d2 <calc_fun+0x93>
				break;
    31d2:	e9 b2 00 00 00       	jmp    3289 <calc_fun+0x14a>
			case 3:
				calc_print = 1;
    31d7:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 31e1 <calc_fun+0xa2>
				break;
    31e1:	e9 a3 00 00 00       	jmp    3289 <calc_fun+0x14a>
			case 4:
				calc_print = 2;
    31e6:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR [rip+0x0],0x2        # 31f0 <calc_fun+0xb1>
				break;
    31f0:	e9 94 00 00 00       	jmp    3289 <calc_fun+0x14a>
			case 5:
				if (calc_thr)
    31f5:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 31fb <calc_fun+0xbc>
    31fb:	85 c0                	test   eax,eax
    31fd:	74 7d                	je     327c <calc_fun+0x13d>
						calc_thr++;
    31ff:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3205 <calc_fun+0xc6>
    3205:	83 c0 01             	add    eax,0x1
    3208:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 320e <calc_fun+0xcf>
				break;
    320e:	eb 6c                	jmp    327c <calc_fun+0x13d>
			case 6:
				if (calc_thr)
    3210:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3216 <calc_fun+0xd7>
    3216:	85 c0                	test   eax,eax
    3218:	74 65                	je     327f <calc_fun+0x140>
						calc_thr += 5;
    321a:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3220 <calc_fun+0xe1>
    3220:	83 c0 05             	add    eax,0x5
    3223:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3229 <calc_fun+0xea>
				break;
    3229:	eb 54                	jmp    327f <calc_fun+0x140>
			case 7:
				if (calc_thr)
    322b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3231 <calc_fun+0xf2>
    3231:	85 c0                	test   eax,eax
    3233:	74 4d                	je     3282 <calc_fun+0x143>
						calc_thr += 15;
    3235:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 323b <calc_fun+0xfc>
    323b:	83 c0 0f             	add    eax,0xf
    323e:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3244 <calc_fun+0x105>
				break;
    3244:	eb 3c                	jmp    3282 <calc_fun+0x143>
			case 8:
				if (calc_thr)
    3246:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 324c <calc_fun+0x10d>
    324c:	85 c0                	test   eax,eax
    324e:	74 35                	je     3285 <calc_fun+0x146>
						calc_thr--;
    3250:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3256 <calc_fun+0x117>
    3256:	83 e8 01             	sub    eax,0x1
    3259:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 325f <calc_fun+0x120>
				break;
    325f:	eb 24                	jmp    3285 <calc_fun+0x146>
			case 9:
				if (calc_thr)
    3261:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3267 <calc_fun+0x128>
    3267:	85 c0                	test   eax,eax
    3269:	74 1d                	je     3288 <calc_fun+0x149>
						calc_thr -= 5;
    326b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3271 <calc_fun+0x132>
    3271:	83 e8 05             	sub    eax,0x5
    3274:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 327a <calc_fun+0x13b>
				break;
    327a:	eb 0c                	jmp    3288 <calc_fun+0x149>
				break;
    327c:	90                   	nop
    327d:	eb 0a                	jmp    3289 <calc_fun+0x14a>
				break;
    327f:	90                   	nop
    3280:	eb 07                	jmp    3289 <calc_fun+0x14a>
				break;
    3282:	90                   	nop
    3283:	eb 04                	jmp    3289 <calc_fun+0x14a>
				break;
    3285:	90                   	nop
    3286:	eb 01                	jmp    3289 <calc_fun+0x14a>
				break;
    3288:	90                   	nop
		}
}
    3289:	90                   	nop
    328a:	c9                   	leave
    328b:	c3                   	ret

000000000000328c <enable_sse>:
		} while ((unsigned int)((double)(counter - now) / CLOCKS_PER_SEC) < seconds);
		return 0;
}*/

void enable_sse()
{
    328c:	55                   	push   rbp
    328d:	48 89 e5             	mov    rbp,rsp
    3290:	53                   	push   rbx
    3291:	48 83 ec 10          	sub    rsp,0x10
		/* enable SSE if present */
		uint32_t eax, ebx, ecx, edx;
		__cpuid(1, eax, ebx, ecx, edx);
    3295:	b8 01 00 00 00       	mov    eax,0x1
    329a:	0f a2                	cpuid
    329c:	89 de                	mov    esi,ebx
    329e:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
    32a1:	89 75 f0             	mov    DWORD PTR [rbp-0x10],esi
    32a4:	89 4d ec             	mov    DWORD PTR [rbp-0x14],ecx
    32a7:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
		if (edx & (1<< 25)) {
    32aa:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    32ad:	25 00 00 00 02       	and    eax,0x2000000
    32b2:	85 c0                	test   eax,eax
    32b4:	74 16                	je     32cc <enable_sse+0x40>
#ifdef __x86_64__
				asm("mov %%cr0, %%rax\n"
    32b6:	0f 20 c0             	mov    rax,cr0
    32b9:	48 83 c8 02          	or     rax,0x2
    32bd:	24 fb                	and    al,0xfb
    32bf:	0f 22 c0             	mov    cr0,rax
    32c2:	0f 20 e0             	mov    rax,cr4
    32c5:	66 0d 00 06          	or     ax,0x600
    32c9:	0f 22 e0             	mov    cr4,rax
					"or $0x00000600, %%eax\n"
					"mov %%eax, %%cr4\n"
					: : : "eax"); /* set oxfxsr osxmmexcpt */
#endif
		}
}
    32cc:	90                   	nop
    32cd:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    32d1:	c9                   	leave
    32d2:	c3                   	ret

00000000000032d3 <do_cpuid>:

void do_cpuid()
{
    32d3:	55                   	push   rbp
    32d4:	48 89 e5             	mov    rbp,rsp
    32d7:	53                   	push   rbx
    32d8:	48 83 ec 20          	sub    rsp,0x20
		uint32_t eax, ebx, ecx, edx;
		cpu.max_leaf = __get_cpuid_max(0, NULL);
    32dc:	be 00 00 00 00       	mov    esi,0x0
    32e1:	bf 00 00 00 00       	mov    edi,0x0
    32e6:	e8 f3 cd ff ff       	call   de <__get_cpuid_max>
    32eb:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 32f1 <do_cpuid+0x1e>
		cpu.max_eleaf = __get_cpuid_max(0x80000000, NULL);
    32f1:	be 00 00 00 00       	mov    esi,0x0
    32f6:	bf 00 00 00 80       	mov    edi,0x80000000
    32fb:	e8 de cd ff ff       	call   de <__get_cpuid_max>
    3300:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3306 <do_cpuid+0x33>
		__cpuid(0, eax, ebx, ecx, edx);
    3306:	b8 00 00 00 00       	mov    eax,0x0
    330b:	0f a2                	cpuid
    330d:	89 de                	mov    esi,ebx
    330f:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    3312:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    3315:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    3318:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
		((int*)cpu.vendor_id)[0] = ebx;
    331b:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    3322:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    3325:	89 02                	mov    DWORD PTR [rdx],eax
		((int*)cpu.vendor_id)[1] = edx;
    3327:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    332e:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    3331:	89 02                	mov    DWORD PTR [rdx],eax
		((int*)cpu.vendor_id)[2] = ecx;
    3333:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    333a:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    333d:	89 02                	mov    DWORD PTR [rdx],eax
		((int*)cpu.vendor_id)[3] = 0;
    333f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3346:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		if (cpu.max_leaf > 0) {
    334c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3352 <do_cpuid+0x7f>
    3352:	85 c0                	test   eax,eax
    3354:	74 39                	je     338f <do_cpuid+0xbc>
				__cpuid(1, eax, ebx, ecx, edx);
    3356:	b8 01 00 00 00       	mov    eax,0x1
    335b:	0f a2                	cpuid
    335d:	89 de                	mov    esi,ebx
    335f:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    3362:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    3365:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    3368:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
				cpu.feat_eax = eax;
    336b:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    336e:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3374 <do_cpuid+0xa1>
				cpu.feat_ecx = ecx;
    3374:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    3377:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 337d <do_cpuid+0xaa>
				cpu.feat_edx = edx;
    337d:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    3380:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3386 <do_cpuid+0xb3>
				cpu.feat_ebx = ebx;
    3386:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    3389:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 338f <do_cpuid+0xbc>
		}
		if (cpu.max_eleaf > 0x80000000) {
    338f:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3395 <do_cpuid+0xc2>
    3395:	3d 00 00 00 80       	cmp    eax,0x80000000
    339a:	76 39                	jbe    33d5 <do_cpuid+0x102>
				__cpuid(0x80000001, eax, ebx, ecx, edx);
    339c:	b8 01 00 00 80       	mov    eax,0x80000001
    33a1:	0f a2                	cpuid
    33a3:	89 de                	mov    esi,ebx
    33a5:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    33a8:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    33ab:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    33ae:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
				cpu.efeat_eax = eax;
    33b1:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    33b4:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 33ba <do_cpuid+0xe7>
				cpu.efeat_ebx = ebx;
    33ba:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    33bd:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 33c3 <do_cpuid+0xf0>
				cpu.efeat_ecx = ecx;
    33c3:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    33c6:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 33cc <do_cpuid+0xf9>
				cpu.efeat_edx = edx;
    33cc:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    33cf:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 33d5 <do_cpuid+0x102>
		}
		cpu.brand_string[0] = '\0';
    33d5:	c6 05 00 00 00 00 00 	mov    BYTE PTR [rip+0x0],0x0        # 33dc <do_cpuid+0x109>
		if (cpu.max_eleaf > 0x80000003) {
    33dc:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 33e2 <do_cpuid+0x10f>
    33e2:	3d 03 00 00 80       	cmp    eax,0x80000003
    33e7:	76 77                	jbe    3460 <do_cpuid+0x18d>
				/* get the brand string */
				uint32_t* pt = (uint32_t*)cpu.brand_string;
    33e9:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				for (uint32_t i = 1; i < 4; i++) {
    33f1:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1
    33f8:	eb 60                	jmp    345a <do_cpuid+0x187>
						__cpuid(0x80000001 + i, eax, ebx, ecx, edx);
    33fa:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    33fd:	2d ff ff ff 7f       	sub    eax,0x7fffffff
    3402:	0f a2                	cpuid
    3404:	89 de                	mov    esi,ebx
    3406:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    3409:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    340c:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    340f:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
						*pt++ = eax;
    3412:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3416:	48 8d 50 04          	lea    rdx,[rax+0x4]
    341a:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
    341e:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    3421:	89 10                	mov    DWORD PTR [rax],edx
						*pt++ = ebx;
    3423:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3427:	48 8d 50 04          	lea    rdx,[rax+0x4]
    342b:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
    342f:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    3432:	89 10                	mov    DWORD PTR [rax],edx
						*pt++ = ecx;
    3434:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3438:	48 8d 50 04          	lea    rdx,[rax+0x4]
    343c:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
    3440:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
    3443:	89 10                	mov    DWORD PTR [rax],edx
						*pt++ = edx;
    3445:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3449:	48 8d 50 04          	lea    rdx,[rax+0x4]
    344d:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
    3451:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    3454:	89 10                	mov    DWORD PTR [rax],edx
				for (uint32_t i = 1; i < 4; i++) {
    3456:	83 45 ec 01          	add    DWORD PTR [rbp-0x14],0x1
    345a:	83 7d ec 03          	cmp    DWORD PTR [rbp-0x14],0x3
    345e:	76 9a                	jbe    33fa <do_cpuid+0x127>
				}
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
    3460:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3466 <do_cpuid+0x193>
    3466:	3d 06 00 00 80       	cmp    eax,0x80000006
    346b:	76 39                	jbe    34a6 <do_cpuid+0x1d3>
    346d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3474 <do_cpuid+0x1a1>
    3474:	83 e0 10             	and    eax,0x10
    3477:	84 c0                	test   al,al
    3479:	74 2b                	je     34a6 <do_cpuid+0x1d3>
				/* get invariant tsc */
				__cpuid(0x80000007, eax, ebx, ecx, edx);
    347b:	b8 07 00 00 80       	mov    eax,0x80000007
    3480:	0f a2                	cpuid
    3482:	89 de                	mov    esi,ebx
    3484:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
    3487:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    348a:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
    348d:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
				cpu.invariant_tsc = !!(edx & (1 << 8));
    3490:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    3493:	25 00 01 00 00       	and    eax,0x100
    3498:	85 c0                	test   eax,eax
    349a:	0f 95 c0             	setne  al
    349d:	0f b6 c0             	movzx  eax,al
    34a0:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 34a6 <do_cpuid+0x1d3>
		}

		/* FIXME: using enable_sse due to framebuffer on x64 */
		enable_sse();
    34a6:	b8 00 00 00 00       	mov    eax,0x0
    34ab:	e8 00 00 00 00       	call   34b0 <do_cpuid+0x1dd>
}
    34b0:	90                   	nop
    34b1:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    34b5:	c9                   	leave
    34b6:	c3                   	ret

00000000000034b7 <cpu_info>:
void cpu_info()
{
    34b7:	55                   	push   rbp
    34b8:	48 89 e5             	mov    rbp,rsp
		printf("This cpu is \"%s\" and supports %u cpuid leaves and %u extended cpuid leaves\n",
						cpu.vendor_id, cpu.max_leaf, cpu.max_eleaf - 0x80000000);
    34bb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 34c1 <cpu_info+0xa>
		printf("This cpu is \"%s\" and supports %u cpuid leaves and %u extended cpuid leaves\n",
    34c1:	8d 90 00 00 00 80    	lea    edx,[rax-0x80000000]
    34c7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 34cd <cpu_info+0x16>
    34cd:	89 d1                	mov    ecx,edx
    34cf:	89 c2                	mov    edx,eax
    34d1:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    34d8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    34df:	b8 00 00 00 00       	mov    eax,0x0
    34e4:	e8 00 00 00 00       	call   34e9 <cpu_info+0x32>
		/* TODO: DBG! */
		//cpu.has_htt = 1;
		printf("Its main features are:\n");
    34e9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    34f0:	b8 00 00 00 00       	mov    eax,0x0
    34f5:	e8 00 00 00 00       	call   34fa <cpu_info+0x43>
		if (cpu.has_htt)
    34fa:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3501 <cpu_info+0x4a>
    3501:	83 e0 10             	and    eax,0x10
    3504:	84 c0                	test   al,al
    3506:	74 11                	je     3519 <cpu_info+0x62>
				printf("\tHyper-threading\n");
    3508:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    350f:	b8 00 00 00 00       	mov    eax,0x0
    3514:	e8 00 00 00 00       	call   3519 <cpu_info+0x62>
		if (cpu.has_pae)
    3519:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3520 <cpu_info+0x69>
    3520:	83 e0 40             	and    eax,0x40
    3523:	84 c0                	test   al,al
    3525:	74 11                	je     3538 <cpu_info+0x81>
				printf("\tPAE\n");
    3527:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    352e:	b8 00 00 00 00       	mov    eax,0x0
    3533:	e8 00 00 00 00       	call   3538 <cpu_info+0x81>
		if (cpu.has_apic)
    3538:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 353f <cpu_info+0x88>
    353f:	83 e0 02             	and    eax,0x2
    3542:	84 c0                	test   al,al
    3544:	74 11                	je     3557 <cpu_info+0xa0>
				printf("\tAPIC\n");
    3546:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    354d:	b8 00 00 00 00       	mov    eax,0x0
    3552:	e8 00 00 00 00       	call   3557 <cpu_info+0xa0>
		if (cpu.has_acpi)
    3557:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 355e <cpu_info+0xa7>
    355e:	83 e0 40             	and    eax,0x40
    3561:	84 c0                	test   al,al
    3563:	74 11                	je     3576 <cpu_info+0xbf>
				printf("\tACPI\n");
    3565:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    356c:	b8 00 00 00 00       	mov    eax,0x0
    3571:	e8 00 00 00 00       	call   3576 <cpu_info+0xbf>
		printf("All features are:\n");
    3576:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    357d:	b8 00 00 00 00       	mov    eax,0x0
    3582:	e8 00 00 00 00       	call   3587 <cpu_info+0xd0>
		printf("33222222222211111111110000000000\n");
    3587:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    358e:	b8 00 00 00 00       	mov    eax,0x0
    3593:	e8 00 00 00 00       	call   3598 <cpu_info+0xe1>
		printf("10987654321098765432109876543210\n");
    3598:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    359f:	b8 00 00 00 00       	mov    eax,0x0
    35a4:	e8 00 00 00 00       	call   35a9 <cpu_info+0xf2>
		printf("%032b\n", cpu.feat_eax);
    35a9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 35af <cpu_info+0xf8>
    35af:	89 c6                	mov    esi,eax
    35b1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35b8:	b8 00 00 00 00       	mov    eax,0x0
    35bd:	e8 00 00 00 00       	call   35c2 <cpu_info+0x10b>
		printf("%032b\n", cpu.feat_ebx);
    35c2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 35c8 <cpu_info+0x111>
    35c8:	89 c6                	mov    esi,eax
    35ca:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35d1:	b8 00 00 00 00       	mov    eax,0x0
    35d6:	e8 00 00 00 00       	call   35db <cpu_info+0x124>
		printf("%032b\n", cpu.feat_ecx);
    35db:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 35e1 <cpu_info+0x12a>
    35e1:	89 c6                	mov    esi,eax
    35e3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35ea:	b8 00 00 00 00       	mov    eax,0x0
    35ef:	e8 00 00 00 00       	call   35f4 <cpu_info+0x13d>
		printf("%032b\n", cpu.feat_edx);
    35f4:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 35fa <cpu_info+0x143>
    35fa:	89 c6                	mov    esi,eax
    35fc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3603:	b8 00 00 00 00       	mov    eax,0x0
    3608:	e8 00 00 00 00       	call   360d <cpu_info+0x156>
		if (cpu.max_eleaf > 0x80000000) {
    360d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3613 <cpu_info+0x15c>
    3613:	3d 00 00 00 80       	cmp    eax,0x80000000
    3618:	0f 86 02 01 00 00    	jbe    3720 <cpu_info+0x269>
				printf("The main extended features are:\n");
    361e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3625:	b8 00 00 00 00       	mov    eax,0x0
    362a:	e8 00 00 00 00       	call   362f <cpu_info+0x178>
				if (cpu.e_pat)
    362f:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3636 <cpu_info+0x17f>
    3636:	83 e0 01             	and    eax,0x1
    3639:	84 c0                	test   al,al
    363b:	74 11                	je     364e <cpu_info+0x197>
						printf("\tPAT\n");
    363d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3644:	b8 00 00 00 00       	mov    eax,0x0
    3649:	e8 00 00 00 00       	call   364e <cpu_info+0x197>
				if (cpu.e_has_mp)
    364e:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3655 <cpu_info+0x19e>
    3655:	83 e0 08             	and    eax,0x8
    3658:	84 c0                	test   al,al
    365a:	74 11                	je     366d <cpu_info+0x1b6>
						printf("\tMP capable\n");
    365c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3663:	b8 00 00 00 00       	mov    eax,0x0
    3668:	e8 00 00 00 00       	call   366d <cpu_info+0x1b6>
				if (cpu.e_has_nx)
    366d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3674 <cpu_info+0x1bd>
    3674:	83 e0 10             	and    eax,0x10
    3677:	84 c0                	test   al,al
    3679:	74 11                	je     368c <cpu_info+0x1d5>
						printf("\tNX bit\n");
    367b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3682:	b8 00 00 00 00       	mov    eax,0x0
    3687:	e8 00 00 00 00       	call   368c <cpu_info+0x1d5>
				if (cpu.e_has_longmode)
    368c:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3693 <cpu_info+0x1dc>
    3693:	83 e0 20             	and    eax,0x20
    3696:	84 c0                	test   al,al
    3698:	74 11                	je     36ab <cpu_info+0x1f4>
						printf("\tx86_64\n");
    369a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36a1:	b8 00 00 00 00       	mov    eax,0x0
    36a6:	e8 00 00 00 00       	call   36ab <cpu_info+0x1f4>
				printf("All extended features:\n");
    36ab:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36b2:	b8 00 00 00 00       	mov    eax,0x0
    36b7:	e8 00 00 00 00       	call   36bc <cpu_info+0x205>
				printf("%032b\n", cpu.efeat_eax);
    36bc:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 36c2 <cpu_info+0x20b>
    36c2:	89 c6                	mov    esi,eax
    36c4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36cb:	b8 00 00 00 00       	mov    eax,0x0
    36d0:	e8 00 00 00 00       	call   36d5 <cpu_info+0x21e>
				printf("%032b\n", cpu.efeat_ebx);
    36d5:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 36db <cpu_info+0x224>
    36db:	89 c6                	mov    esi,eax
    36dd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36e4:	b8 00 00 00 00       	mov    eax,0x0
    36e9:	e8 00 00 00 00       	call   36ee <cpu_info+0x237>
				printf("%032b\n", cpu.efeat_ecx);
    36ee:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 36f4 <cpu_info+0x23d>
    36f4:	89 c6                	mov    esi,eax
    36f6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36fd:	b8 00 00 00 00       	mov    eax,0x0
    3702:	e8 00 00 00 00       	call   3707 <cpu_info+0x250>
				printf("%032b\n", cpu.efeat_edx);
    3707:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 370d <cpu_info+0x256>
    370d:	89 c6                	mov    esi,eax
    370f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3716:	b8 00 00 00 00       	mov    eax,0x0
    371b:	e8 00 00 00 00       	call   3720 <cpu_info+0x269>
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
    3720:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3726 <cpu_info+0x26f>
    3726:	3d 06 00 00 80       	cmp    eax,0x80000006
    372b:	76 3c                	jbe    3769 <cpu_info+0x2b2>
    372d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3734 <cpu_info+0x27d>
    3734:	83 e0 10             	and    eax,0x10
    3737:	84 c0                	test   al,al
    3739:	74 2e                	je     3769 <cpu_info+0x2b2>
				printf("The CPU's TSC is %s rate\n", cpu.invariant_tsc ? "constant" : "variable");
    373b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3741 <cpu_info+0x28a>
    3741:	85 c0                	test   eax,eax
    3743:	74 09                	je     374e <cpu_info+0x297>
    3745:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    374c:	eb 07                	jmp    3755 <cpu_info+0x29e>
    374e:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3755:	48 89 c6             	mov    rsi,rax
    3758:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    375f:	b8 00 00 00 00       	mov    eax,0x0
    3764:	e8 00 00 00 00       	call   3769 <cpu_info+0x2b2>
		}
		printf("The brand string is \"%s\"\n", cpu.brand_string);
    3769:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3770:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3777:	b8 00 00 00 00       	mov    eax,0x0
    377c:	e8 00 00 00 00       	call   3781 <cpu_info+0x2ca>
}
    3781:	90                   	nop
    3782:	5d                   	pop    rbp
    3783:	c3                   	ret

0000000000003784 <prepare_idt>:
//#	sub edx, 4
//	mov word ptr [edx+idt+2], bx
//	.endm
//#endif
void prepare_idt()
{
    3784:	55                   	push   rbp
    3785:	48 89 e5             	mov    rbp,rsp
    3788:	48 83 ec 20          	sub    rsp,0x20
	/* do the bit shuffling on IDT descriptors */
	struct idt_entry* pt = (struct idt_entry*)&idt;
    378c:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
	struct igate ig;
	size_t count = ((size_t)&idt_end - (size_t)&idt) / sizeof(struct idt_entry);
    3794:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    379b:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    37a2:	48 29 d0             	sub    rax,rdx
    37a5:	48 c1 e8 04          	shr    rax,0x4
    37a9:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax

	while (count--) {
    37ad:	eb 72                	jmp    3821 <prepare_idt+0x9d>
		/* we got to swap the linear address (32/64bt) into the
		 * IDT descriptor format since there's no suitable relocation
		 * available to do it with the linker. */
		ig = *(struct igate*)pt;
    37af:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    37b3:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    37b7:	48 8b 00             	mov    rax,QWORD PTR [rax]
    37ba:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    37be:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
		pt->offset_1 = ig.fun & 0xffff;
    37c2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    37c6:	89 c2                	mov    edx,eax
    37c8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    37cc:	66 89 10             	mov    WORD PTR [rax],dx
		pt->offset_2 = (ig.fun >> 16) & 0xffff;
    37cf:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    37d3:	48 c1 e8 10          	shr    rax,0x10
    37d7:	89 c2                	mov    edx,eax
    37d9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    37dd:	66 89 50 06          	mov    WORD PTR [rax+0x6],dx
#ifdef __x86_64__
		pt->offset_3 = (ig.fun >> 32);
    37e1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    37e5:	48 c1 e8 20          	shr    rax,0x20
    37e9:	89 c2                	mov    edx,eax
    37eb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    37ef:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
		pt->ist = 0; /* we don't have interrupt stacks so far */
    37f2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    37f6:	c6 40 04 00          	mov    BYTE PTR [rax+0x4],0x0
#endif
		pt->selector = ig.sel;
    37fa:	0f b7 55 ea          	movzx  edx,WORD PTR [rbp-0x16]
    37fe:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3802:	66 89 50 02          	mov    WORD PTR [rax+0x2],dx
		pt->type = ig.type;
    3806:	0f b6 55 e9          	movzx  edx,BYTE PTR [rbp-0x17]
    380a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    380e:	88 50 05             	mov    BYTE PTR [rax+0x5],dl
		pt->zero = 0;
    3811:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3815:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [rax+0xc],0x0
		
		/* advance */
		pt++;
    381c:	48 83 45 f8 10       	add    QWORD PTR [rbp-0x8],0x10
	while (count--) {
    3821:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3825:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    3829:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
    382d:	48 85 c0             	test   rax,rax
    3830:	0f 85 79 ff ff ff    	jne    37af <prepare_idt+0x2b>

	}
}
    3836:	90                   	nop
    3837:	90                   	nop
    3838:	c9                   	leave
    3839:	c3                   	ret

000000000000383a <_start>:

extern void _start()
{
    383a:	55                   	push   rbp
    383b:	48 89 e5             	mov    rbp,rsp
		extern int fb_no_malloc;
		/* set cpu to correct values */
		do_cpuid();
    383e:	b8 00 00 00 00       	mov    eax,0x0
    3843:	e8 00 00 00 00       	call   3848 <_start+0xe>

		/* transfer the frambuffer mappings */
		void fb_video_setup();
		fb_no_malloc = 1;
    3848:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 3852 <_start+0x18>
		fb_video_setup();
    3852:	b8 00 00 00 00       	mov    eax,0x0
    3857:	e8 00 00 00 00       	call   385c <_start+0x22>

		/* use the correct GDT */
		extern void gdt_init();
		gdt_init();
    385c:	b8 00 00 00 00       	mov    eax,0x0
    3861:	e8 00 00 00 00       	call   3866 <_start+0x2c>

		/* transfer mmgr data from known locations */
		extern void mmgr_reinit();
		mmgr_reinit();
    3866:	b8 00 00 00 00       	mov    eax,0x0
    386b:	e8 00 00 00 00       	call   3870 <_start+0x36>
		fb_no_malloc = 0;
    3870:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 387a <_start+0x40>

		/* do the IDT setup & remap PIC */
		extern void idt_init();
		prepare_idt();
    387a:	b8 00 00 00 00       	mov    eax,0x0
    387f:	e8 00 00 00 00       	call   3884 <_start+0x4a>
		idt_init();
    3884:	b8 00 00 00 00       	mov    eax,0x0
    3889:	e8 00 00 00 00       	call   388e <_start+0x54>
		PIC_remap(0x20, 0x28);
    388e:	be 28 00 00 00       	mov    esi,0x28
    3893:	bf 20 00 00 00       	mov    edi,0x20
    3898:	e8 00 00 00 00       	call   389d <_start+0x63>
		while (!fb_no_malloc);
    389d:	90                   	nop
    389e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 38a4 <_start+0x6a>
    38a4:	85 c0                	test   eax,eax
    38a6:	74 f6                	je     389e <_start+0x64>
		asm("sti");
    38a8:	fb                   	sti

		/* protect null pointer */
		mm_unmap(&mm_kernel, NULL, 1);
    38a9:	ba 01 00 00 00       	mov    edx,0x1
    38ae:	be 00 00 00 00       	mov    esi,0x0
    38b3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    38ba:	e8 00 00 00 00       	call   38bf <_start+0x85>

		/* print cpu info */
		cpu_info();
    38bf:	b8 00 00 00 00       	mov    eax,0x0
    38c4:	e8 00 00 00 00       	call   38c9 <_start+0x8f>
		/* timekeeping setup */
		timer_setup();
    38c9:	b8 00 00 00 00       	mov    eax,0x0
    38ce:	e8 00 00 00 00       	call   38d3 <_start+0x99>
		/* enable preemption (needed for MP init stacks) */
		/* enable preemption (calls kinit and never returns) */
		printf("starting preemption...\n");
    38d3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    38da:	b8 00 00 00 00       	mov    eax,0x0
    38df:	e8 00 00 00 00       	call   38e4 <_start+0xaa>
		void preempt_init();
		preempt_init();
    38e4:	b8 00 00 00 00       	mov    eax,0x0
    38e9:	e8 00 00 00 00       	call   38ee <_start+0xb4>

		cprintf(KFMT_ERROR, "preempt_init returned\n");
    38ee:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    38f5:	bf 0c 00 00 00       	mov    edi,0xc
    38fa:	b8 00 00 00 00       	mov    eax,0x0
    38ff:	e8 00 00 00 00       	call   3904 <_start+0xca>
		while (1);
    3904:	90                   	nop
    3905:	eb fd                	jmp    3904 <_start+0xca>

0000000000003907 <kinit>:
}

void kinit(void* data)
{
    3907:	55                   	push   rbp
    3908:	48 89 e5             	mov    rbp,rsp
    390b:	48 83 ec 40          	sub    rsp,0x40
    390f:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
		cprintf(KFMT_OK, "kernel is now preemptive\n");
    3913:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    391a:	bf 0a 00 00 00       	mov    edi,0xa
    391f:	b8 00 00 00 00       	mov    eax,0x0
    3924:	e8 00 00 00 00       	call   3929 <kinit+0x22>
		/* APIC and MP init */
		if (cpu.has_apic) {
    3929:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3930 <kinit+0x29>
    3930:	83 e0 02             	and    eax,0x2
    3933:	84 c0                	test   al,al
    3935:	74 0a                	je     3941 <kinit+0x3a>
				extern void apic_init(); /* PCP works afterwards */
				apic_init();
    3937:	b8 00 00 00 00       	mov    eax,0x0
    393c:	e8 00 00 00 00       	call   3941 <kinit+0x3a>
		}
		extern void region_clear(struct kio_region* cr);
		region_clear(&km_regS);
    3941:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3948:	e8 00 00 00 00       	call   394d <kinit+0x46>
		km_regS.cur_x = km_regS.cur_y = 0;
    394d:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 3956 <kinit+0x4f>
    3956:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 395d <kinit+0x56>
    395d:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 3964 <kinit+0x5d>
		region_puts(&km_regS, "total used  hp free\n\nup: ");
    3964:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    396b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3972:	e8 00 00 00 00       	call   3977 <kinit+0x70>
		/* Hardware detection and initialization */
		kbd_init();
    3977:	b8 00 00 00 00       	mov    eax,0x0
    397c:	e8 00 00 00 00       	call   3981 <kinit+0x7a>
		{
				char bt;
				printf("VGA IO base port (from 0x0463): %x\n", *(uint16_t*)(0x463));
    3981:	b8 63 04 00 00       	mov    eax,0x463
    3986:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3989:	0f b7 c0             	movzx  eax,ax
    398c:	89 c6                	mov    esi,eax
    398e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3995:	b8 00 00 00 00       	mov    eax,0x0
    399a:	e8 00 00 00 00       	call   399f <kinit+0x98>
				bt = inb(0x3cc);
    399f:	bf cc 03 00 00       	mov    edi,0x3cc
    39a4:	e8 9f c6 ff ff       	call   48 <inb>
    39a9:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al
				printf("VGA misc flags: %08b\n", bt);
    39ac:	0f be 45 ef          	movsx  eax,BYTE PTR [rbp-0x11]
    39b0:	89 c6                	mov    esi,eax
    39b2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    39b9:	b8 00 00 00 00       	mov    eax,0x0
    39be:	e8 00 00 00 00       	call   39c3 <kinit+0xbc>
/*				sleep(0);
				}*/
		}
		/* List the serial and printer ports */
		{
				uint16_t* ptr = (uint16_t*)0x400; int i;
    39c3:	48 c7 45 e0 00 04 00 00 	mov    QWORD PTR [rbp-0x20],0x400
				for (i = 0; i < 7; i++)
    39cb:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    39d2:	e9 c0 00 00 00       	jmp    3a97 <kinit+0x190>
						if (ptr[i])
    39d7:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    39da:	48 98                	cdqe
    39dc:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    39e0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    39e4:	48 01 d0             	add    rax,rdx
    39e7:	0f b7 00             	movzx  eax,WORD PTR [rax]
    39ea:	66 85 c0             	test   ax,ax
    39ed:	74 6a                	je     3a59 <kinit+0x152>
								if (i < 4) {
    39ef:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
    39f3:	7f 3d                	jg     3a32 <kinit+0x12b>
										printf("COM%d IO port: %u\n", i + 1, *ptr);
    39f5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    39f9:	0f b7 00             	movzx  eax,WORD PTR [rax]
    39fc:	0f b7 c0             	movzx  eax,ax
    39ff:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    3a02:	8d 4a 01             	lea    ecx,[rdx+0x1]
    3a05:	89 c2                	mov    edx,eax
    3a07:	89 ce                	mov    esi,ecx
    3a09:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3a10:	b8 00 00 00 00       	mov    eax,0x0
    3a15:	e8 00 00 00 00       	call   3a1a <kinit+0x113>
										enable_com(i, *ptr);
    3a1a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3a1e:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3a21:	0f b7 d0             	movzx  edx,ax
    3a24:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3a27:	89 d6                	mov    esi,edx
    3a29:	89 c7                	mov    edi,eax
    3a2b:	e8 00 00 00 00       	call   3a30 <kinit+0x129>
    3a30:	eb 61                	jmp    3a93 <kinit+0x18c>
								} else
										printf("LPT%d IO port: %u\n", i - 3, *ptr);
    3a32:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3a36:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3a39:	0f b7 c0             	movzx  eax,ax
    3a3c:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    3a3f:	8d 4a fd             	lea    ecx,[rdx-0x3]
    3a42:	89 c2                	mov    edx,eax
    3a44:	89 ce                	mov    esi,ecx
    3a46:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3a4d:	b8 00 00 00 00       	mov    eax,0x0
    3a52:	e8 00 00 00 00       	call   3a57 <kinit+0x150>
    3a57:	eb 3a                	jmp    3a93 <kinit+0x18c>
						else
								if (i < 4)
    3a59:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
    3a5d:	7f 1b                	jg     3a7a <kinit+0x173>
										printf("COM%d not present\n", i + 1);
    3a5f:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3a62:	83 c0 01             	add    eax,0x1
    3a65:	89 c6                	mov    esi,eax
    3a67:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3a6e:	b8 00 00 00 00       	mov    eax,0x0
    3a73:	e8 00 00 00 00       	call   3a78 <kinit+0x171>
    3a78:	eb 19                	jmp    3a93 <kinit+0x18c>
								else
										printf("LPT%d not present\n", i - 3);
    3a7a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3a7d:	83 e8 03             	sub    eax,0x3
    3a80:	89 c6                	mov    esi,eax
    3a82:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3a89:	b8 00 00 00 00       	mov    eax,0x0
    3a8e:	e8 00 00 00 00       	call   3a93 <kinit+0x18c>
				for (i = 0; i < 7; i++)
    3a93:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    3a97:	83 7d fc 06          	cmp    DWORD PTR [rbp-0x4],0x6
    3a9b:	0f 8e 36 ff ff ff    	jle    39d7 <kinit+0xd0>
		}
		/* Floppy devices */
		{
				uint8_t bt = cmos_get_register(0x10);
    3aa1:	bf 10 00 00 00       	mov    edi,0x10
    3aa6:	e8 00 00 00 00       	call   3aab <kinit+0x1a4>
    3aab:	88 45 df             	mov    BYTE PTR [rbp-0x21],al
				uint8_t btM = (bt & 0xf0) >> 4;
    3aae:	0f b6 45 df          	movzx  eax,BYTE PTR [rbp-0x21]
    3ab2:	c0 e8 04             	shr    al,0x4
    3ab5:	88 45 fb             	mov    BYTE PTR [rbp-0x5],al
				bt &= 0x0f;
    3ab8:	80 65 df 0f          	and    BYTE PTR [rbp-0x21],0xf
				do {
						const char* drv;
						switch (btM != 0xff ? btM : bt) {
    3abc:	80 7d fb ff          	cmp    BYTE PTR [rbp-0x5],0xff
    3ac0:	74 06                	je     3ac8 <kinit+0x1c1>
    3ac2:	0f b6 45 fb          	movzx  eax,BYTE PTR [rbp-0x5]
    3ac6:	eb 04                	jmp    3acc <kinit+0x1c5>
    3ac8:	0f b6 45 df          	movzx  eax,BYTE PTR [rbp-0x21]
    3acc:	83 f8 05             	cmp    eax,0x5
    3acf:	77 48                	ja     3b19 <kinit+0x212>
    3ad1:	89 c0                	mov    eax,eax
    3ad3:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    3adb:	ff e0                	jmp    rax
								case 0:
										drv = "no drive";
    3add:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3ae5:	eb 3b                	jmp    3b22 <kinit+0x21b>
								case 1:
										drv = "360KiB 5.25\" drive";
    3ae7:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3aef:	eb 31                	jmp    3b22 <kinit+0x21b>
								case 2:
										drv = "1.2MiB 5.25\" drive";
    3af1:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3af9:	eb 27                	jmp    3b22 <kinit+0x21b>
								case 3:
										drv = "720KiB 3.5\" drive";
    3afb:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3b03:	eb 1d                	jmp    3b22 <kinit+0x21b>
								case 4:
										drv = "1.44MiB 3.5\" drive";
    3b05:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3b0d:	eb 13                	jmp    3b22 <kinit+0x21b>
								case 5:
										drv = "2.88MiB 3.5\" drive";
    3b0f:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3b17:	eb 09                	jmp    3b22 <kinit+0x21b>
								default:
										drv = "unknown";
    3b19:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
										break;
    3b21:	90                   	nop
						}
						printf("Floppy %s: %s\n", btM != 0xff ? "master" : "slave", drv);
    3b22:	80 7d fb ff          	cmp    BYTE PTR [rbp-0x5],0xff
    3b26:	74 09                	je     3b31 <kinit+0x22a>
    3b28:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    3b2f:	eb 07                	jmp    3b38 <kinit+0x231>
    3b31:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    3b38:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3b3c:	48 89 c2             	mov    rdx,rax
    3b3f:	48 89 ce             	mov    rsi,rcx
    3b42:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3b49:	b8 00 00 00 00       	mov    eax,0x0
    3b4e:	e8 00 00 00 00       	call   3b53 <kinit+0x24c>
						if (btM == 0xff)
    3b53:	80 7d fb ff          	cmp    BYTE PTR [rbp-0x5],0xff
    3b57:	74 09                	je     3b62 <kinit+0x25b>
								break;
						btM = 0xff;
    3b59:	c6 45 fb ff          	mov    BYTE PTR [rbp-0x5],0xff
				do {
    3b5d:	e9 5a ff ff ff       	jmp    3abc <kinit+0x1b5>
								break;
    3b62:	90                   	nop
		}

		/* PCI enumeration */
		void load_modules();
		void fun();
		fun();
    3b63:	b8 00 00 00 00       	mov    eax,0x0
    3b68:	e8 00 00 00 00       	call   3b6d <kinit+0x266>
		load_modules();
    3b6d:	b8 00 00 00 00       	mov    eax,0x0
    3b72:	e8 00 00 00 00       	call   3b77 <kinit+0x270>

		/* now go to the loop */
		void kloop();
		kloop();
    3b77:	b8 00 00 00 00       	mov    eax,0x0
    3b7c:	e8 00 00 00 00       	call   3b81 <kinit+0x27a>
}
    3b81:	90                   	nop
    3b82:	c9                   	leave
    3b83:	c3                   	ret

0000000000003b84 <kscrub>:

/* performs scrubbing of pages at low priority */
void kscrub(void* data)
{
    3b84:	55                   	push   rbp
    3b85:	48 89 e5             	mov    rbp,rsp
    3b88:	48 83 ec 10          	sub    rsp,0x10
    3b8c:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		while (1) {/* need_resched is checked periodically inside */
				extern struct wait_queue_head wq_timer;
				if (!mm_page_scrub())
    3b90:	b8 00 00 00 00       	mov    eax,0x0
    3b95:	e8 00 00 00 00       	call   3b9a <kscrub+0x16>
    3b9a:	85 c0                	test   eax,eax
    3b9c:	75 f2                	jne    3b90 <kscrub+0xc>
						wait_timeout(&wq_timer, HZ);
    3b9e:	be 79 00 00 00       	mov    esi,0x79
    3ba3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3baa:	e8 00 00 00 00       	call   3baf <kscrub+0x2b>
		while (1) {/* need_resched is checked periodically inside */
    3baf:	eb df                	jmp    3b90 <kscrub+0xc>

0000000000003bb1 <kloop>:
		}
}

void kloop()
{
    3bb1:	55                   	push   rbp
    3bb2:	48 89 e5             	mov    rbp,rsp
    3bb5:	48 81 ec 70 01 00 00 	sub    rsp,0x170
		/* file_cli */
		int (*fptr)(const char*) = locate_module_function("file_cli");
    3bbc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3bc3:	e8 00 00 00 00       	call   3bc8 <kloop+0x17>
    3bc8:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		void list_modules();
		void list_module_info(const char*);

		/* main loop */
		while (1) {
				char* str = 0; size_t n = 0;
    3bcc:	48 c7 45 a0 00 00 00 00 	mov    QWORD PTR [rbp-0x60],0x0
    3bd4:	48 c7 45 98 00 00 00 00 	mov    QWORD PTR [rbp-0x68],0x0
				printf("enter text:\n");
    3bdc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3be3:	b8 00 00 00 00       	mov    eax,0x0
    3be8:	e8 00 00 00 00       	call   3bed <kloop+0x3c>
				getline(&str, &n);
    3bed:	48 8d 55 98          	lea    rdx,[rbp-0x68]
    3bf1:	48 8d 45 a0          	lea    rax,[rbp-0x60]
    3bf5:	48 89 d6             	mov    rsi,rdx
    3bf8:	48 89 c7             	mov    rdi,rax
    3bfb:	e8 00 00 00 00       	call   3c00 <kloop+0x4f>
				if (str) {
    3c00:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c04:	48 85 c0             	test   rax,rax
    3c07:	74 c3                	je     3bcc <kloop+0x1b>
						char* s2 = str;
    3c09:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c0d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						while (*s2++);
    3c11:	90                   	nop
    3c12:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3c16:	48 8d 50 01          	lea    rdx,[rax+0x1]
    3c1a:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
    3c1e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3c21:	84 c0                	test   al,al
    3c23:	75 ed                	jne    3c12 <kloop+0x61>
						if (s2 - 2 >= str)
    3c25:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3c29:	48 8d 50 fe          	lea    rdx,[rax-0x2]
    3c2d:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c31:	48 39 c2             	cmp    rdx,rax
    3c34:	72 0b                	jb     3c41 <kloop+0x90>
								*(s2 - 2) = '\0';
    3c36:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3c3a:	48 83 e8 02          	sub    rax,0x2
    3c3e:	c6 00 00             	mov    BYTE PTR [rax],0x0
						if (strcmp(str, "pt") == 0) {
    3c41:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c45:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3c4c:	48 89 c7             	mov    rdi,rax
    3c4f:	e8 00 00 00 00       	call   3c54 <kloop+0xa3>
    3c54:	85 c0                	test   eax,eax
    3c56:	75 0f                	jne    3c67 <kloop+0xb6>
								/* print tasks */
								void print_tasks();
								print_tasks();
    3c58:	b8 00 00 00 00       	mov    eax,0x0
    3c5d:	e8 00 00 00 00       	call   3c62 <kloop+0xb1>
    3c62:	e9 ec 07 00 00       	jmp    4453 <kloop+0x8a2>
						} else if (strncmp(str, "calc", 4) == 0) {
    3c67:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c6b:	ba 04 00 00 00       	mov    edx,0x4
    3c70:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3c77:	48 89 c7             	mov    rdi,rax
    3c7a:	e8 00 00 00 00       	call   3c7f <kloop+0xce>
    3c7f:	85 c0                	test   eax,eax
    3c81:	75 15                	jne    3c98 <kloop+0xe7>
								/* start/stop show the calculations */
								calc_fun(str + 5);
    3c83:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c87:	48 83 c0 05          	add    rax,0x5
    3c8b:	48 89 c7             	mov    rdi,rax
    3c8e:	e8 00 00 00 00       	call   3c93 <kloop+0xe2>
    3c93:	e9 bb 07 00 00       	jmp    4453 <kloop+0x8a2>
						} else if (strcmp(str, "rds") == 0) {
    3c98:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3c9c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3ca3:	48 89 c7             	mov    rdi,rax
    3ca6:	e8 00 00 00 00       	call   3cab <kloop+0xfa>
    3cab:	85 c0                	test   eax,eax
    3cad:	0f 85 1d 01 00 00    	jne    3dd0 <kloop+0x21f>
								//framebuffer_redraw(&fb_initial);
								printf("%d %d\n", video_mode.width, video_mode.height);
    3cb3:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3cb9 <kloop+0x108>
    3cb9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3cbf <kloop+0x10e>
    3cbf:	89 c6                	mov    esi,eax
    3cc1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3cc8:	b8 00 00 00 00       	mov    eax,0x0
    3ccd:	e8 00 00 00 00       	call   3cd2 <kloop+0x121>
								printf("%d %d\n", fb_initial.cho_x, fb_initial.cho_y);
    3cd2:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3cd8 <kloop+0x127>
    3cd8:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3cde <kloop+0x12d>
    3cde:	89 c6                	mov    esi,eax
    3ce0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3ce7:	b8 00 00 00 00       	mov    eax,0x0
    3cec:	e8 00 00 00 00       	call   3cf1 <kloop+0x140>
								printf("%d %d\n", fb_initial.chw_x, fb_initial.chw_y);
    3cf1:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3cf7 <kloop+0x146>
    3cf7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3cfd <kloop+0x14c>
    3cfd:	89 c6                	mov    esi,eax
    3cff:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3d06:	b8 00 00 00 00       	mov    eax,0x0
    3d0b:	e8 00 00 00 00       	call   3d10 <kloop+0x15f>
								printf("%d %d\n", fb_initial.width, fb_initial.height);
    3d10:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3d16 <kloop+0x165>
    3d16:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3d1c <kloop+0x16b>
    3d1c:	89 c6                	mov    esi,eax
    3d1e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3d25:	b8 00 00 00 00       	mov    eax,0x0
    3d2a:	e8 00 00 00 00       	call   3d2f <kloop+0x17e>
								printf("regions:\n");
    3d2f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3d36:	b8 00 00 00 00       	mov    eax,0x0
    3d3b:	e8 00 00 00 00       	call   3d40 <kloop+0x18f>
								printf("km_regC: %d %d %d %d\n", km_regC.x, km_regC.y, km_regC.lx, km_regC.ly);
    3d40:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d47 <kloop+0x196>
    3d47:	0f bf f0             	movsx  esi,ax
    3d4a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d51 <kloop+0x1a0>
    3d51:	0f bf c8             	movsx  ecx,ax
    3d54:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d5b <kloop+0x1aa>
    3d5b:	0f bf d0             	movsx  edx,ax
    3d5e:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d65 <kloop+0x1b4>
    3d65:	98                   	cwde
    3d66:	41 89 f0             	mov    r8d,esi
    3d69:	89 c6                	mov    esi,eax
    3d6b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3d72:	b8 00 00 00 00       	mov    eax,0x0
    3d77:	e8 00 00 00 00       	call   3d7c <kloop+0x1cb>
								printf("km_regS: %d %d %d %d\n", km_regS.x, km_regS.y, km_regS.lx, km_regS.ly);
    3d7c:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d83 <kloop+0x1d2>
    3d83:	0f bf f0             	movsx  esi,ax
    3d86:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d8d <kloop+0x1dc>
    3d8d:	0f bf c8             	movsx  ecx,ax
    3d90:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3d97 <kloop+0x1e6>
    3d97:	0f bf d0             	movsx  edx,ax
    3d9a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 3da1 <kloop+0x1f0>
    3da1:	98                   	cwde
    3da2:	41 89 f0             	mov    r8d,esi
    3da5:	89 c6                	mov    esi,eax
    3da7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3dae:	b8 00 00 00 00       	mov    eax,0x0
    3db3:	e8 00 00 00 00       	call   3db8 <kloop+0x207>
								framebuffer_update_region(&fb_initial, &km_regC);
    3db8:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3dbf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3dc6:	e8 00 00 00 00       	call   3dcb <kloop+0x21a>
    3dcb:	e9 83 06 00 00       	jmp    4453 <kloop+0x8a2>
						} else if (strcmp(str, "time") == 0) {
    3dd0:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3dd4:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3ddb:	48 89 c7             	mov    rdi,rax
    3dde:	e8 00 00 00 00       	call   3de3 <kloop+0x232>
    3de3:	85 c0                	test   eax,eax
    3de5:	0f 85 ae 01 00 00    	jne    3f99 <kloop+0x3e8>
								struct timespec tsp; struct tm* ts = &km_time;
    3deb:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
								km_time = cmos_get_time();
    3df3:	48 8d 85 90 fe ff ff 	lea    rax,[rbp-0x170]
    3dfa:	48 89 c7             	mov    rdi,rax
    3dfd:	b8 00 00 00 00       	mov    eax,0x0
    3e02:	e8 00 00 00 00       	call   3e07 <kloop+0x256>
    3e07:	48 8b 85 90 fe ff ff 	mov    rax,QWORD PTR [rbp-0x170]
    3e0e:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3e15 <kloop+0x264>
    3e15:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    3e1c:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3e23 <kloop+0x272>
    3e23:	48 8b 85 a0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x160]
    3e2a:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3e31 <kloop+0x280>
    3e31:	48 8b 85 a8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x158]
    3e38:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3e3f <kloop+0x28e>
    3e3f:	8b 85 b0 fe ff ff    	mov    eax,DWORD PTR [rbp-0x150]
    3e45:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 3e4b <kloop+0x29a>
								km_set = jiffies;
    3e4b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3e52 <kloop+0x2a1>
    3e52:	48 8b 00             	mov    rax,QWORD PTR [rax]
    3e55:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3e5c <kloop+0x2ab>
								printf("upadting time from CMOS\n");
    3e5c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3e63:	b8 00 00 00 00       	mov    eax,0x0
    3e68:	e8 00 00 00 00       	call   3e6d <kloop+0x2bc>
								clock_gettime(CLOCK_REALTIME, &tsp);
    3e6d:	48 8d 45 88          	lea    rax,[rbp-0x78]
    3e71:	48 89 c6             	mov    rsi,rax
    3e74:	bf 00 00 00 00       	mov    edi,0x0
    3e79:	e8 00 00 00 00       	call   3e7e <kloop+0x2cd>
								printf("UNIX time: %llu.%lu\n", tsp.tv_sec, tsp.tv_nsec);
    3e7e:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    3e82:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    3e86:	48 89 c6             	mov    rsi,rax
    3e89:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3e90:	b8 00 00 00 00       	mov    eax,0x0
    3e95:	e8 00 00 00 00       	call   3e9a <kloop+0x2e9>
								printf("struct tm:\n");
    3e9a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3ea1:	b8 00 00 00 00       	mov    eax,0x0
    3ea6:	e8 00 00 00 00       	call   3eab <kloop+0x2fa>
								printf("tm_sec %d\n", ts->tm_sec);
    3eab:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3eaf:	8b 00                	mov    eax,DWORD PTR [rax]
    3eb1:	89 c6                	mov    esi,eax
    3eb3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3eba:	b8 00 00 00 00       	mov    eax,0x0
    3ebf:	e8 00 00 00 00       	call   3ec4 <kloop+0x313>
								printf("tm_min %d\n", ts->tm_min);
    3ec4:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3ec8:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    3ecb:	89 c6                	mov    esi,eax
    3ecd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3ed4:	b8 00 00 00 00       	mov    eax,0x0
    3ed9:	e8 00 00 00 00       	call   3ede <kloop+0x32d>
								printf("tm_hour %d\n", ts->tm_hour);
    3ede:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3ee2:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    3ee5:	89 c6                	mov    esi,eax
    3ee7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3eee:	b8 00 00 00 00       	mov    eax,0x0
    3ef3:	e8 00 00 00 00       	call   3ef8 <kloop+0x347>
								printf("tm_mday %d\n", ts->tm_mday);
    3ef8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3efc:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    3eff:	89 c6                	mov    esi,eax
    3f01:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f08:	b8 00 00 00 00       	mov    eax,0x0
    3f0d:	e8 00 00 00 00       	call   3f12 <kloop+0x361>
								printf("tm_mon %d\n", ts->tm_mon);
    3f12:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3f16:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    3f19:	89 c6                	mov    esi,eax
    3f1b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f22:	b8 00 00 00 00       	mov    eax,0x0
    3f27:	e8 00 00 00 00       	call   3f2c <kloop+0x37b>
								printf("tm_year %d\n", ts->tm_year);
    3f2c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3f30:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    3f33:	89 c6                	mov    esi,eax
    3f35:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f3c:	b8 00 00 00 00       	mov    eax,0x0
    3f41:	e8 00 00 00 00       	call   3f46 <kloop+0x395>
								printf("tm_wday %d\n", ts->tm_wday);
    3f46:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3f4a:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    3f4d:	89 c6                	mov    esi,eax
    3f4f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f56:	b8 00 00 00 00       	mov    eax,0x0
    3f5b:	e8 00 00 00 00       	call   3f60 <kloop+0x3af>
								printf("tm_yday %d\n", ts->tm_yday);
    3f60:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3f64:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    3f67:	89 c6                	mov    esi,eax
    3f69:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f70:	b8 00 00 00 00       	mov    eax,0x0
    3f75:	e8 00 00 00 00       	call   3f7a <kloop+0x3c9>
								printf("tm_isdst %d\n", ts->tm_isdst);
    3f7a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3f7e:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3f81:	89 c6                	mov    esi,eax
    3f83:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3f8a:	b8 00 00 00 00       	mov    eax,0x0
    3f8f:	e8 00 00 00 00       	call   3f94 <kloop+0x3e3>
    3f94:	e9 ba 04 00 00       	jmp    4453 <kloop+0x8a2>
						} else if(strcmp(str, "trhp") == 0) {
    3f99:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3f9d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3fa4:	48 89 c7             	mov    rdi,rax
    3fa7:	e8 00 00 00 00       	call   3fac <kloop+0x3fb>
    3fac:	85 c0                	test   eax,eax
    3fae:	75 6e                	jne    401e <kloop+0x46d>
								unsigned int bval = 0xff;
    3fb0:	c7 45 f4 ff 00 00 00 	mov    DWORD PTR [rbp-0xc],0xff
								printf("trashing kernel heap\n");
    3fb7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3fbe:	b8 00 00 00 00       	mov    eax,0x0
    3fc3:	e8 00 00 00 00       	call   3fc8 <kloop+0x417>
								/* glibc rand */
								while (1) {
										printf("allocating %u bytes ...\n", (bval & 0xffff));
    3fc8:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    3fcb:	0f b7 c0             	movzx  eax,ax
    3fce:	89 c6                	mov    esi,eax
    3fd0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3fd7:	b8 00 00 00 00       	mov    eax,0x0
    3fdc:	e8 00 00 00 00       	call   3fe1 <kloop+0x430>
										printf("located at %p\n", kmalloc(bval & 0xffff));
    3fe1:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    3fe4:	0f b7 c0             	movzx  eax,ax
    3fe7:	48 89 c7             	mov    rdi,rax
    3fea:	e8 00 00 00 00       	call   3fef <kloop+0x43e>
    3fef:	48 89 c6             	mov    rsi,rax
    3ff2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3ff9:	b8 00 00 00 00       	mov    eax,0x0
    3ffe:	e8 00 00 00 00       	call   4003 <kloop+0x452>
										bval = (uint32_t)((1103515245*(uint64_t)bval+12345) % 0x80000000);
    4003:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    4006:	48 69 c0 6d 4e c6 41 	imul   rax,rax,0x41c64e6d
    400d:	48 05 39 30 00 00    	add    rax,0x3039
    4013:	25 ff ff ff 7f       	and    eax,0x7fffffff
    4018:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
										printf("allocating %u bytes ...\n", (bval & 0xffff));
    401b:	90                   	nop
    401c:	eb aa                	jmp    3fc8 <kloop+0x417>
								}
						} else if (fptr && fptr(str)) {
    401e:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    4023:	74 15                	je     403a <kloop+0x489>
    4025:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4029:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    402d:	48 89 c7             	mov    rdi,rax
    4030:	ff d2                	call   rdx
    4032:	85 c0                	test   eax,eax
    4034:	0f 85 19 04 00 00    	jne    4453 <kloop+0x8a2>
								/* do nothing -> fptr() does it */
						} else if (strcmp(str, "lsmod") == 0)
    403a:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    403e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4045:	48 89 c7             	mov    rdi,rax
    4048:	e8 00 00 00 00       	call   404d <kloop+0x49c>
    404d:	85 c0                	test   eax,eax
    404f:	75 0f                	jne    4060 <kloop+0x4af>
								list_modules();
    4051:	b8 00 00 00 00       	mov    eax,0x0
    4056:	e8 00 00 00 00       	call   405b <kloop+0x4aa>
    405b:	e9 f3 03 00 00       	jmp    4453 <kloop+0x8a2>
						else if (strncmp(str, "modinfo ", 7) == 0) {
    4060:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4064:	ba 07 00 00 00       	mov    edx,0x7
    4069:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4070:	48 89 c7             	mov    rdi,rax
    4073:	e8 00 00 00 00       	call   4078 <kloop+0x4c7>
    4078:	85 c0                	test   eax,eax
    407a:	75 1d                	jne    4099 <kloop+0x4e8>
								str += 8;
    407c:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4080:	48 83 c0 08          	add    rax,0x8
    4084:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
								list_module_info(str);
    4088:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    408c:	48 89 c7             	mov    rdi,rax
    408f:	e8 00 00 00 00       	call   4094 <kloop+0x4e3>
    4094:	e9 ba 03 00 00       	jmp    4453 <kloop+0x8a2>
						} else if (strcmp(str, "com") == 0) {
    4099:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    409d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    40a4:	48 89 c7             	mov    rdi,rax
    40a7:	e8 00 00 00 00       	call   40ac <kloop+0x4fb>
    40ac:	85 c0                	test   eax,eax
    40ae:	75 0f                	jne    40bf <kloop+0x50e>
								com_status();
    40b0:	b8 00 00 00 00       	mov    eax,0x0
    40b5:	e8 00 00 00 00       	call   40ba <kloop+0x509>
    40ba:	e9 94 03 00 00       	jmp    4453 <kloop+0x8a2>
						} else if (strcmp(str, "brk") == 0) {
    40bf:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    40c3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    40ca:	48 89 c7             	mov    rdi,rax
    40cd:	e8 00 00 00 00       	call   40d2 <kloop+0x521>
    40d2:	85 c0                	test   eax,eax
    40d4:	0f 84 79 03 00 00    	je     4453 <kloop+0x8a2>
								//breakpoint(); TODO reimpl.
						} else if (strncmp(str, "pma", 3) == 0) {
    40da:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    40de:	ba 03 00 00 00       	mov    edx,0x3
    40e3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    40ea:	48 89 c7             	mov    rdi,rax
    40ed:	e8 00 00 00 00       	call   40f2 <kloop+0x541>
    40f2:	85 c0                	test   eax,eax
    40f4:	0f 85 fe 00 00 00    	jne    41f8 <kloop+0x647>
								int val;
								/* allocate pmem */
								val = atoi(str + 3);
    40fa:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    40fe:	48 83 c0 03          	add    rax,0x3
    4102:	48 89 c7             	mov    rdi,rax
    4105:	e8 00 00 00 00       	call   410a <kloop+0x559>
    410a:	89 45 b0             	mov    DWORD PTR [rbp-0x50],eax
								if (val) {
    410d:	83 7d b0 00          	cmp    DWORD PTR [rbp-0x50],0x0
    4111:	0f 84 3c 03 00 00    	je     4453 <kloop+0x8a2>
										struct page_range pr[10]; size_t rv;
										printf("allocating %d physical pages...\n", val);
    4117:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
    411a:	89 c6                	mov    esi,eax
    411c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4123:	b8 00 00 00 00       	mov    eax,0x0
    4128:	e8 00 00 00 00       	call   412d <kloop+0x57c>
										rv = mm_alloc_pm(val, pr, 10);
    412d:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
    4130:	48 8d 8d c0 fe ff ff 	lea    rcx,[rbp-0x140]
    4137:	ba 0a 00 00 00       	mov    edx,0xa
    413c:	48 89 ce             	mov    rsi,rcx
    413f:	89 c7                	mov    edi,eax
    4141:	e8 00 00 00 00       	call   4146 <kloop+0x595>
    4146:	89 c0                	mov    eax,eax
    4148:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
										printf("%zu pages allocated\n", rv);
    414c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4150:	48 89 c6             	mov    rsi,rax
    4153:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    415a:	b8 00 00 00 00       	mov    eax,0x0
    415f:	e8 00 00 00 00       	call   4164 <kloop+0x5b3>
										for (rv = 0; rv < 10; rv++)
    4164:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    416c:	eb 7a                	jmp    41e8 <kloop+0x637>
												if (!pr[rv].count)
    416e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4172:	48 c1 e0 04          	shl    rax,0x4
    4176:	48 01 e8             	add    rax,rbp
    4179:	48 2d 38 01 00 00    	sub    rax,0x138
    417f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    4182:	48 85 c0             	test   rax,rax
    4185:	0f 84 c7 02 00 00    	je     4452 <kloop+0x8a1>
														break;
												else
														printf("%zu pages at %#08x%08x\n",
																	   pr[rv].count,
																	   (uint32_t)(pr[rv].base >> 32),
																	   (uint32_t)pr[rv].base);
    418b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    418f:	48 c1 e0 04          	shl    rax,0x4
    4193:	48 01 e8             	add    rax,rbp
    4196:	48 2d 40 01 00 00    	sub    rax,0x140
    419c:	48 8b 00             	mov    rax,QWORD PTR [rax]
														printf("%zu pages at %#08x%08x\n",
    419f:	89 c1                	mov    ecx,eax
																	   (uint32_t)(pr[rv].base >> 32),
    41a1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    41a5:	48 c1 e0 04          	shl    rax,0x4
    41a9:	48 01 e8             	add    rax,rbp
    41ac:	48 2d 40 01 00 00    	sub    rax,0x140
    41b2:	48 8b 00             	mov    rax,QWORD PTR [rax]
    41b5:	48 c1 e8 20          	shr    rax,0x20
														printf("%zu pages at %#08x%08x\n",
    41b9:	89 c2                	mov    edx,eax
    41bb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    41bf:	48 c1 e0 04          	shl    rax,0x4
    41c3:	48 01 e8             	add    rax,rbp
    41c6:	48 2d 38 01 00 00    	sub    rax,0x138
    41cc:	48 8b 00             	mov    rax,QWORD PTR [rax]
    41cf:	48 89 c6             	mov    rsi,rax
    41d2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    41d9:	b8 00 00 00 00       	mov    eax,0x0
    41de:	e8 00 00 00 00       	call   41e3 <kloop+0x632>
										for (rv = 0; rv < 10; rv++)
    41e3:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    41e8:	48 83 7d e8 09       	cmp    QWORD PTR [rbp-0x18],0x9
    41ed:	0f 86 7b ff ff ff    	jbe    416e <kloop+0x5bd>
    41f3:	e9 5b 02 00 00       	jmp    4453 <kloop+0x8a2>
								}
						} else if (strncmp(str, "pmf", 3) == 0) {
    41f8:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    41fc:	ba 03 00 00 00       	mov    edx,0x3
    4201:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4208:	48 89 c7             	mov    rdi,rax
    420b:	e8 00 00 00 00       	call   4210 <kloop+0x65f>
    4210:	85 c0                	test   eax,eax
    4212:	0f 85 96 00 00 00    	jne    42ae <kloop+0x6fd>
								long int val; char* ep;
								val = strtol(str + 3, &ep, 0);
    4218:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    421c:	48 8d 48 03          	lea    rcx,[rax+0x3]
    4220:	48 8d 45 80          	lea    rax,[rbp-0x80]
    4224:	ba 00 00 00 00       	mov    edx,0x0
    4229:	48 89 c6             	mov    rsi,rax
    422c:	48 89 cf             	mov    rdi,rcx
    422f:	e8 00 00 00 00       	call   4234 <kloop+0x683>
    4234:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
								if (val) {
    4238:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    423d:	0f 84 10 02 00 00    	je     4453 <kloop+0x8a2>
										int ct = atoi(ep);
    4243:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    4247:	48 89 c7             	mov    rdi,rax
    424a:	e8 00 00 00 00       	call   424f <kloop+0x69e>
    424f:	89 45 b4             	mov    DWORD PTR [rbp-0x4c],eax
										if (ct) {
    4252:	83 7d b4 00          	cmp    DWORD PTR [rbp-0x4c],0x0
    4256:	0f 84 f7 01 00 00    	je     4453 <kloop+0x8a2>
												struct page_range pr;
												pr.base = val;
    425c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    4260:	48 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rax
												pr.count = ct;
    4267:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    426a:	48 98                	cdqe
    426c:	48 89 85 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rax
												printf("freeing %zu physical pages at 0x%016llx\n",
    4273:	48 8b 95 70 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x90]
    427a:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    4281:	48 89 c6             	mov    rsi,rax
    4284:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    428b:	b8 00 00 00 00       	mov    eax,0x0
    4290:	e8 00 00 00 00       	call   4295 <kloop+0x6e4>
																pr.count, pr.base);
												mm_free_pm(&pr, 1);
    4295:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    429c:	be 01 00 00 00       	mov    esi,0x1
    42a1:	48 89 c7             	mov    rdi,rax
    42a4:	e8 00 00 00 00       	call   42a9 <kloop+0x6f8>
    42a9:	e9 a5 01 00 00       	jmp    4453 <kloop+0x8a2>
										}
								}
						} else if (strncmp(str, "pmu", 3) == 0) {
    42ae:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    42b2:	ba 03 00 00 00       	mov    edx,0x3
    42b7:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    42be:	48 89 c7             	mov    rdi,rax
    42c1:	e8 00 00 00 00       	call   42c6 <kloop+0x715>
    42c6:	85 c0                	test   eax,eax
    42c8:	75 7e                	jne    4348 <kloop+0x797>
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
    42ca:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    42ce:	48 8d 48 03          	lea    rcx,[rax+0x3]
    42d2:	48 8d 85 68 ff ff ff 	lea    rax,[rbp-0x98]
    42d9:	ba 00 00 00 00       	mov    edx,0x0
    42de:	48 89 c6             	mov    rsi,rax
    42e1:	48 89 cf             	mov    rdi,rcx
    42e4:	e8 00 00 00 00       	call   42e9 <kloop+0x738>
    42e9:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
								if (val) {
    42ed:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    42f2:	74 3b                	je     432f <kloop+0x77e>
										int ct = atoi(ep);
    42f4:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    42fb:	48 89 c7             	mov    rdi,rax
    42fe:	e8 00 00 00 00       	call   4303 <kloop+0x752>
    4303:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
										if (ct)
    4306:	83 7d c4 00          	cmp    DWORD PTR [rbp-0x3c],0x0
    430a:	0f 84 43 01 00 00    	je     4453 <kloop+0x8a2>
												mm_dump_pmu(val, ct, 0);
    4310:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    4313:	48 63 c8             	movsxd rcx,eax
    4316:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    431a:	ba 00 00 00 00       	mov    edx,0x0
    431f:	48 89 ce             	mov    rsi,rcx
    4322:	48 89 c7             	mov    rdi,rax
    4325:	e8 00 00 00 00       	call   432a <kloop+0x779>
    432a:	e9 24 01 00 00       	jmp    4453 <kloop+0x8a2>
								} else
										mm_dump_pmu(0, 0, 2);
    432f:	ba 02 00 00 00       	mov    edx,0x2
    4334:	be 00 00 00 00       	mov    esi,0x0
    4339:	bf 00 00 00 00       	mov    edi,0x0
    433e:	e8 00 00 00 00       	call   4343 <kloop+0x792>
    4343:	e9 0b 01 00 00       	jmp    4453 <kloop+0x8a2>
						} else if (strncmp(str, "rcp", 3) == 0) {
    4348:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    434c:	ba 03 00 00 00       	mov    edx,0x3
    4351:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4358:	48 89 c7             	mov    rdi,rax
    435b:	e8 00 00 00 00       	call   4360 <kloop+0x7af>
    4360:	85 c0                	test   eax,eax
    4362:	75 7b                	jne    43df <kloop+0x82e>
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
    4364:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4368:	48 8d 48 03          	lea    rcx,[rax+0x3]
    436c:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    4373:	ba 00 00 00 00       	mov    edx,0x0
    4378:	48 89 c6             	mov    rsi,rax
    437b:	48 89 cf             	mov    rdi,rcx
    437e:	e8 00 00 00 00       	call   4383 <kloop+0x7d2>
    4383:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
								if (val) {
    4387:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    438c:	74 3b                	je     43c9 <kloop+0x818>
										int ct = atoi(ep);
    438e:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    4395:	48 89 c7             	mov    rdi,rax
    4398:	e8 00 00 00 00       	call   439d <kloop+0x7ec>
    439d:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
										if (ct)
    43a0:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    43a4:	0f 84 a9 00 00 00    	je     4453 <kloop+0x8a2>
												mm_dump_pmu(val, ct, 1);
    43aa:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    43ad:	48 63 c8             	movsxd rcx,eax
    43b0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    43b4:	ba 01 00 00 00       	mov    edx,0x1
    43b9:	48 89 ce             	mov    rsi,rcx
    43bc:	48 89 c7             	mov    rdi,rax
    43bf:	e8 00 00 00 00       	call   43c4 <kloop+0x813>
    43c4:	e9 8a 00 00 00       	jmp    4453 <kloop+0x8a2>
								} else
										mm_dump_pmu(0, 0, 2);
    43c9:	ba 02 00 00 00       	mov    edx,0x2
    43ce:	be 00 00 00 00       	mov    esi,0x0
    43d3:	bf 00 00 00 00       	mov    edi,0x0
    43d8:	e8 00 00 00 00       	call   43dd <kloop+0x82c>
    43dd:	eb 74                	jmp    4453 <kloop+0x8a2>
						} else if (strcmp(str, "reboot") == 0)
    43df:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    43e3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    43ea:	48 89 c7             	mov    rdi,rax
    43ed:	e8 00 00 00 00       	call   43f2 <kloop+0x841>
    43f2:	85 c0                	test   eax,eax
    43f4:	75 0a                	jne    4400 <kloop+0x84f>
								pc_reset();
    43f6:	b8 00 00 00 00       	mov    eax,0x0
    43fb:	e8 00 00 00 00       	call   4400 <kloop+0x84f>
						else if (strcmp(str, "quit") == 0 || strcmp(str, "halt") == 0)
    4400:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4404:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    440b:	48 89 c7             	mov    rdi,rax
    440e:	e8 00 00 00 00       	call   4413 <kloop+0x862>
    4413:	85 c0                	test   eax,eax
    4415:	74 17                	je     442e <kloop+0x87d>
    4417:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    441b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    4422:	48 89 c7             	mov    rdi,rax
    4425:	e8 00 00 00 00       	call   442a <kloop+0x879>
    442a:	85 c0                	test   eax,eax
    442c:	75 0a                	jne    4438 <kloop+0x887>
								pc_shutdown();
    442e:	b8 00 00 00 00       	mov    eax,0x0
    4433:	e8 00 00 00 00       	call   4438 <kloop+0x887>
						else
								printf("Command \"%s\" read from keyboard is unrecognized\n", str);
    4438:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    443c:	48 89 c6             	mov    rsi,rax
    443f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    4446:	b8 00 00 00 00       	mov    eax,0x0
    444b:	e8 00 00 00 00       	call   4450 <kloop+0x89f>
    4450:	eb 01                	jmp    4453 <kloop+0x8a2>
														break;
    4452:	90                   	nop
						kfree(str);
    4453:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    4457:	48 89 c7             	mov    rdi,rax
    445a:	e8 00 00 00 00       	call   445f <kloop+0x8ae>
		while (1) {
    445f:	e9 68 f7 ff ff       	jmp    3bcc <kloop+0x1b>

0000000000004464 <ringbuffer_allocate>:
		char data[];
};

/* ringbuffer functions*/
void* ringbuffer_allocate(size_t init_cap)
{
    4464:	55                   	push   rbp
    4465:	48 89 e5             	mov    rbp,rsp
    4468:	48 83 ec 30          	sub    rsp,0x30
    446c:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		void** rvR, *rv;
		rvR = (void**)kmalloc(sizeof(void*));
    4470:	bf 08 00 00 00       	mov    edi,0x8
    4475:	e8 00 00 00 00       	call   447a <ringbuffer_allocate+0x16>
    447a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!rvR)
    447e:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    4483:	75 07                	jne    448c <ringbuffer_allocate+0x28>
				return 0;
    4485:	b8 00 00 00 00       	mov    eax,0x0
    448a:	eb 78                	jmp    4504 <ringbuffer_allocate+0xa0>
		if ((rv = kmalloc(init_cap + sizeof(struct ringbuffer)))) {
    448c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    4490:	48 83 c0 20          	add    rax,0x20
    4494:	48 89 c7             	mov    rdi,rax
    4497:	e8 00 00 00 00       	call   449c <ringbuffer_allocate+0x38>
    449c:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    44a0:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    44a5:	74 4c                	je     44f3 <ringbuffer_allocate+0x8f>
				struct ringbuffer* rbf = (struct ringbuffer*)rv;
    44a7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    44ab:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				rbf->cap = init_cap;
    44af:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    44b3:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    44b7:	48 89 10             	mov    QWORD PTR [rax],rdx
				rbf->ofs_start = 0;
    44ba:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    44be:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
				rbf->ofs_end = 0;
    44c6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    44ca:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
				spin_lock_init(&rbf->lock);
    44d2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    44d6:	48 83 c0 18          	add    rax,0x18
    44da:	48 89 c7             	mov    rdi,rax
    44dd:	e8 00 00 00 00       	call   44e2 <ringbuffer_allocate+0x7e>
				*rvR = rv;
    44e2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    44e6:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    44ea:	48 89 10             	mov    QWORD PTR [rax],rdx
				return (void*)rvR;
    44ed:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    44f1:	eb 11                	jmp    4504 <ringbuffer_allocate+0xa0>
		} else
				kfree(rvR);
    44f3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    44f7:	48 89 c7             	mov    rdi,rax
    44fa:	e8 00 00 00 00       	call   44ff <ringbuffer_allocate+0x9b>
		return 0;
    44ff:	b8 00 00 00 00       	mov    eax,0x0
}
    4504:	c9                   	leave
    4505:	c3                   	ret

0000000000004506 <ringbuffer_enqueue>:

void ringbuffer_enqueue(void* rbi, const void* dat, size_t s)
{
    4506:	55                   	push   rbp
    4507:	48 89 e5             	mov    rbp,rsp
    450a:	48 83 ec 50          	sub    rsp,0x50
    450e:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    4512:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
    4516:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    451a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    451e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    4521:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
	//	spin_lock(&rb->lock);
		const char* data = (const char*)dat;
    4525:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    4529:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		size_t cap = rb->cap;
    452d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4531:	48 8b 00             	mov    rax,QWORD PTR [rax]
    4534:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (rb->ofs_end > rb->ofs_start)
    4538:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    453c:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    4540:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    4544:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    4548:	48 39 c2             	cmp    rdx,rax
    454b:	73 19                	jae    4566 <ringbuffer_enqueue+0x60>
				cap -= rb->ofs_end - rb->ofs_start;
    454d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4551:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    4555:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4559:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    455d:	48 29 c2             	sub    rdx,rax
    4560:	48 01 55 e8          	add    QWORD PTR [rbp-0x18],rdx
    4564:	eb 2c                	jmp    4592 <ringbuffer_enqueue+0x8c>
		else
				cap -= rb->cap - rb->ofs_start + rb->ofs_end + 1;
    4566:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    456a:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    456d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4571:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    4575:	48 29 c2             	sub    rdx,rax
    4578:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    457c:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    4580:	48 01 d0             	add    rax,rdx
    4583:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    4587:	48 29 c2             	sub    rdx,rax
    458a:	48 8d 42 ff          	lea    rax,[rdx-0x1]
    458e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (cap < s) {
    4592:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4596:	48 3b 45 b8          	cmp    rax,QWORD PTR [rbp-0x48]
    459a:	0f 83 16 01 00 00    	jae    46b6 <ringbuffer_enqueue+0x1b0>
				void* nrb;
				/* allocate new buffer and shuffle data */
				size_t nc = rb->cap + max(rb->cap, 4 * s + 1);
    45a0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    45a4:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    45a7:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    45ab:	48 c1 e0 02          	shl    rax,0x2
    45af:	48 8d 50 01          	lea    rdx,[rax+0x1]
    45b3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    45b7:	48 8b 00             	mov    rax,QWORD PTR [rax]
    45ba:	48 39 c2             	cmp    rdx,rax
    45bd:	48 0f 43 c2          	cmovae rax,rdx
    45c1:	48 01 c8             	add    rax,rcx
    45c4:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if ((nrb = krealloc(rb, nc + sizeof(struct ringbuffer)))) {
    45c8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    45cc:	48 8d 50 20          	lea    rdx,[rax+0x20]
    45d0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    45d4:	48 89 d6             	mov    rsi,rdx
    45d7:	48 89 c7             	mov    rdi,rax
    45da:	e8 00 00 00 00       	call   45df <ringbuffer_enqueue+0xd9>
    45df:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    45e3:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    45e8:	0f 84 db 00 00 00    	je     46c9 <ringbuffer_enqueue+0x1c3>
						/* enough memory */
						rb = (struct ringbuffer*)nrb;
    45ee:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    45f2:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						*(void**)rbi = nrb;
    45f6:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    45fa:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    45fe:	48 89 10             	mov    QWORD PTR [rax],rdx
						/* move old data (if wrapped) */
						if (rb->ofs_end < rb->ofs_start) {
    4601:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4605:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    4609:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    460d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    4611:	48 39 c2             	cmp    rdx,rax
    4614:	73 48                	jae    465e <ringbuffer_enqueue+0x158>
								memcpy(rb->data + rb->cap, rb->data, rb->ofs_end);
    4616:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    461a:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    461e:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    4622:	48 8d 72 1a          	lea    rsi,[rdx+0x1a]
    4626:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    462a:	48 8d 4a 1a          	lea    rcx,[rdx+0x1a]
    462e:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    4632:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    4635:	48 01 d1             	add    rcx,rdx
    4638:	48 89 c2             	mov    rdx,rax
    463b:	48 89 cf             	mov    rdi,rcx
    463e:	e8 23 ba ff ff       	call   66 <memcpy>
								rb->ofs_end += rb->ofs_start;
    4643:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4647:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    464b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    464f:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    4653:	48 01 c2             	add    rdx,rax
    4656:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    465a:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
						}
						rb->cap = nc;
    465e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4662:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    4666:	48 89 10             	mov    QWORD PTR [rax],rdx
				} else {
	//					spin_unlock(&rb->lock);
						return; /* OOM */
				}
		}
		while (s--) {
    4669:	eb 4b                	jmp    46b6 <ringbuffer_enqueue+0x1b0>
				if (rb->ofs_end == rb->cap)
    466b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    466f:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    4673:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4677:	48 8b 00             	mov    rax,QWORD PTR [rax]
    467a:	48 39 c2             	cmp    rdx,rax
    467d:	75 0c                	jne    468b <ringbuffer_enqueue+0x185>
						rb->ofs_end = 0;
    467f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4683:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
				rb->data[rb->ofs_end++] = *(data++);
    468b:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    468f:	48 8d 42 01          	lea    rax,[rdx+0x1]
    4693:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    4697:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    469b:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    469f:	48 8d 70 01          	lea    rsi,[rax+0x1]
    46a3:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    46a7:	48 89 71 10          	mov    QWORD PTR [rcx+0x10],rsi
    46ab:	0f b6 0a             	movzx  ecx,BYTE PTR [rdx]
    46ae:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    46b2:	88 4c 02 1a          	mov    BYTE PTR [rdx+rax*1+0x1a],cl
		while (s--) {
    46b6:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    46ba:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    46be:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
    46c2:	48 85 c0             	test   rax,rax
    46c5:	75 a4                	jne    466b <ringbuffer_enqueue+0x165>
    46c7:	eb 01                	jmp    46ca <ringbuffer_enqueue+0x1c4>
						return; /* OOM */
    46c9:	90                   	nop
		}
//		spin_unlock(&rb->lock);
}
    46ca:	c9                   	leave
    46cb:	c3                   	ret

00000000000046cc <ringbuffer_dequeue>:

void ringbuffer_dequeue(void* rbi, void* dat, size_t s)
{
    46cc:	55                   	push   rbp
    46cd:	48 89 e5             	mov    rbp,rsp
    46d0:	48 83 ec 28          	sub    rsp,0x28
    46d4:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    46d8:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    46dc:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    46e0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    46e4:	48 8b 00             	mov    rax,QWORD PTR [rax]
    46e7:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
//		spin_lock(&rb->lock);
		char* data = (char*)dat;
    46eb:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    46ef:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (s--) {
    46f3:	e9 84 00 00 00       	jmp    477c <ringbuffer_dequeue+0xb0>
				if (rb->ofs_end == rb->ofs_start) {
    46f8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    46fc:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    4700:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4704:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    4708:	48 39 c2             	cmp    rdx,rax
    470b:	0f 84 82 00 00 00    	je     4793 <ringbuffer_dequeue+0xc7>
//						spin_unlock(&rb->lock);
						return;
				}
				*(data++) = rb->data[rb->ofs_start++];
    4711:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4715:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    4719:	48 8d 4a 01          	lea    rcx,[rdx+0x1]
    471d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4721:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
    4725:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4729:	48 8d 48 01          	lea    rcx,[rax+0x1]
    472d:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
    4731:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    4735:	0f b6 54 11 1a       	movzx  edx,BYTE PTR [rcx+rdx*1+0x1a]
    473a:	88 10                	mov    BYTE PTR [rax],dl
				if (rb->ofs_start == rb->cap) {
    473c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4740:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    4744:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4748:	48 8b 00             	mov    rax,QWORD PTR [rax]
    474b:	48 39 c2             	cmp    rdx,rax
    474e:	75 2c                	jne    477c <ringbuffer_dequeue+0xb0>
						rb->ofs_start = 0;
    4750:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4754:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
						if (rb->ofs_end == rb->cap)
    475c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4760:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    4764:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4768:	48 8b 00             	mov    rax,QWORD PTR [rax]
    476b:	48 39 c2             	cmp    rdx,rax
    476e:	75 0c                	jne    477c <ringbuffer_dequeue+0xb0>
								rb->ofs_end = 0;
    4770:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    4774:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
		while (s--) {
    477c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    4780:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    4784:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    4788:	48 85 c0             	test   rax,rax
    478b:	0f 85 67 ff ff ff    	jne    46f8 <ringbuffer_dequeue+0x2c>
    4791:	eb 01                	jmp    4794 <ringbuffer_dequeue+0xc8>
						return;
    4793:	90                   	nop
				}
		}
//		spin_unlock(&rb->lock);
}
    4794:	c9                   	leave
    4795:	c3                   	ret

0000000000004796 <ringbuffer_available>:

size_t ringbuffer_available(void* rbi)
{
    4796:	55                   	push   rbp
    4797:	48 89 e5             	mov    rbp,rsp
    479a:	48 83 ec 18          	sub    rsp,0x18
    479e:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
    47a2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    47a6:	48 8b 00             	mov    rax,QWORD PTR [rax]
    47a9:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (rb->ofs_end < rb->ofs_start)
    47ad:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47b1:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    47b5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47b9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    47bd:	48 39 c2             	cmp    rdx,rax
    47c0:	73 1f                	jae    47e1 <ringbuffer_available+0x4b>
				return rb->cap - rb->ofs_start + rb->ofs_end;
    47c2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47c6:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    47c9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47cd:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    47d1:	48 29 c2             	sub    rdx,rax
    47d4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47d8:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    47dc:	48 01 d0             	add    rax,rdx
    47df:	eb 16                	jmp    47f7 <ringbuffer_available+0x61>
		else
				return rb->ofs_end - rb->ofs_start;
    47e1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47e5:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    47e9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    47ed:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    47f1:	48 89 c8             	mov    rax,rcx
    47f4:	48 29 d0             	sub    rax,rdx
}
    47f7:	c9                   	leave
    47f8:	c3                   	ret

00000000000047f9 <ringbuffer_free>:

void ringbuffer_free(void* rbi)
{
    47f9:	55                   	push   rbp
    47fa:	48 89 e5             	mov    rbp,rsp
    47fd:	48 83 ec 20          	sub    rsp,0x20
    4801:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct ringbuffer* rbf = *(struct ringbuffer**)rbi;
    4805:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4809:	48 8b 00             	mov    rax,QWORD PTR [rax]
    480c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		spin_lock(&rbf->lock);
    4810:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4814:	48 83 c0 18          	add    rax,0x18
    4818:	48 89 c7             	mov    rdi,rax
    481b:	e8 00 00 00 00       	call   4820 <ringbuffer_free+0x27>
		kfree(rbf);
    4820:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4824:	48 89 c7             	mov    rdi,rax
    4827:	e8 00 00 00 00       	call   482c <ringbuffer_free+0x33>
		kfree(rbi);
    482c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4830:	48 89 c7             	mov    rdi,rax
    4833:	e8 00 00 00 00       	call   4838 <ringbuffer_free+0x3f>
}
    4838:	90                   	nop
    4839:	c9                   	leave
    483a:	c3                   	ret

000000000000483b <spin_lock>:

/* locking functions */
/* linux ticket spin (better than xchg under high contention) */
#define ACCESS_ONCE(x) (*(volatile __typeof__(x)*)&(x))
void spin_lock(spinlock_t* lock)
{
    483b:	55                   	push   rbp
    483c:	48 89 e5             	mov    rbp,rsp
    483f:	48 83 ec 18          	sub    rsp,0x18
    4843:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		register spinlock_t inc;
		inc.head_tail = 1 << (8 * sizeof(ticket_t));
    4847:	66 c7 45 fe 00 01    	mov    WORD PTR [rbp-0x2],0x100

		inc.head_tail = __sync_fetch_and_add(&lock->head_tail, inc.head_tail);
    484d:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    4851:	0f b7 d0             	movzx  edx,ax
    4854:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4858:	66 f0 0f c1 10       	lock xadd WORD PTR [rax],dx
    485d:	66 89 55 fe          	mov    WORD PTR [rbp-0x2],dx

		for (;;) {
				if (inc.tickets.head == inc.tickets.tail)
    4861:	0f b6 55 fe          	movzx  edx,BYTE PTR [rbp-0x2]
    4865:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    4869:	38 c2                	cmp    dl,al
    486b:	74 0e                	je     487b <spin_lock+0x40>
						break;
				_mm_pause();
    486d:	f3 90                	pause
				inc.tickets.head = ACCESS_ONCE(lock->tickets.head);
    486f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4873:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    4876:	88 45 fe             	mov    BYTE PTR [rbp-0x2],al
				if (inc.tickets.head == inc.tickets.tail)
    4879:	eb e6                	jmp    4861 <spin_lock+0x26>
						break;
    487b:	90                   	nop
		}
}
    487c:	90                   	nop
    487d:	c9                   	leave
    487e:	c3                   	ret

000000000000487f <spin_lock_init>:

void spin_lock_init(spinlock_t* lock)
{
    487f:	55                   	push   rbp
    4880:	48 89 e5             	mov    rbp,rsp
    4883:	48 83 ec 08          	sub    rsp,0x8
    4887:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		*lock = (spinlock_t){0};
    488b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    488f:	66 c7 00 00 00       	mov    WORD PTR [rax],0x0
}
    4894:	90                   	nop
    4895:	c9                   	leave
    4896:	c3                   	ret

0000000000004897 <spin_lock_irq>:

void spin_lock_irq(spinlock_t* lock)
{
    4897:	55                   	push   rbp
    4898:	48 89 e5             	mov    rbp,rsp
    489b:	48 83 ec 08          	sub    rsp,0x8
    489f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		asm("cli");
    48a3:	fa                   	cli
		spin_lock(lock);
    48a4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    48a8:	48 89 c7             	mov    rdi,rax
    48ab:	e8 00 00 00 00       	call   48b0 <spin_lock_irq+0x19>
}
    48b0:	90                   	nop
    48b1:	c9                   	leave
    48b2:	c3                   	ret

00000000000048b3 <spin_lock_irqsave>:

void spin_lock_irqsave(spinlock_t* lock, unsigned long* flags)
{
    48b3:	55                   	push   rbp
    48b4:	48 89 e5             	mov    rbp,rsp
    48b7:	48 83 ec 10          	sub    rsp,0x10
    48bb:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    48bf:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		*flags = !if_enabled();
    48c3:	b8 00 00 00 00       	mov    eax,0x0
    48c8:	e8 f1 b7 ff ff       	call   be <if_enabled>
    48cd:	48 85 c0             	test   rax,rax
    48d0:	0f 94 c0             	sete   al
    48d3:	0f b6 d0             	movzx  edx,al
    48d6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    48da:	48 89 10             	mov    QWORD PTR [rax],rdx
		asm("cli");
    48dd:	fa                   	cli
		preempt_disable();
    48de:	b8 00 00 00 00       	mov    eax,0x0
    48e3:	e8 00 00 00 00       	call   48e8 <spin_lock_irqsave+0x35>
    48e8:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    48eb:	83 c2 01             	add    edx,0x1
    48ee:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		spin_lock(lock);
    48f1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    48f5:	48 89 c7             	mov    rdi,rax
    48f8:	e8 00 00 00 00       	call   48fd <spin_lock_irqsave+0x4a>
}
    48fd:	90                   	nop
    48fe:	c9                   	leave
    48ff:	c3                   	ret

0000000000004900 <spin_trylock>:

int spin_trylock(spinlock_t* lock)
{
    4900:	55                   	push   rbp
    4901:	48 89 e5             	mov    rbp,rsp
    4904:	48 83 ec 18          	sub    rsp,0x18
    4908:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		spinlock_t old, new;

		old.head_tail = ACCESS_ONCE(lock->head_tail);
    490c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4910:	0f b7 00             	movzx  eax,WORD PTR [rax]
    4913:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
		if (old.tickets.head != old.tickets.tail)
    4917:	0f b6 55 fe          	movzx  edx,BYTE PTR [rbp-0x2]
    491b:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    491f:	38 c2                	cmp    dl,al
    4921:	74 07                	je     492a <spin_trylock+0x2a>
				return 0;
    4923:	b8 00 00 00 00       	mov    eax,0x0
    4928:	eb 29                	jmp    4953 <spin_trylock+0x53>

		new.head_tail = old.head_tail + (1 << (8 * sizeof(ticket_t)));
    492a:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    492e:	66 05 00 01          	add    ax,0x100
    4932:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
		return __sync_bool_compare_and_swap(&lock->head_tail, old.head_tail, new.head_tail);
    4936:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    493a:	0f b7 c8             	movzx  ecx,ax
    493d:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    4941:	0f b7 c0             	movzx  eax,ax
    4944:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    4948:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [rdx],cx
    494d:	0f 94 c0             	sete   al
    4950:	0f b6 c0             	movzx  eax,al
}
    4953:	c9                   	leave
    4954:	c3                   	ret

0000000000004955 <spin_trylock_irq>:

int spin_trylock_irq(spinlock_t* lock)
{
    4955:	55                   	push   rbp
    4956:	48 89 e5             	mov    rbp,rsp
    4959:	48 83 ec 18          	sub    rsp,0x18
    495d:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv;
		asm("cli");
    4961:	fa                   	cli
		rv = spin_trylock(lock);
    4962:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    4966:	48 89 c7             	mov    rdi,rax
    4969:	e8 00 00 00 00       	call   496e <spin_trylock_irq+0x19>
    496e:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (rv)
    4971:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    4975:	74 05                	je     497c <spin_trylock_irq+0x27>
				return rv;
    4977:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    497a:	eb 04                	jmp    4980 <spin_trylock_irq+0x2b>
		asm("sti");
    497c:	fb                   	sti
		return rv;
    497d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    4980:	c9                   	leave
    4981:	c3                   	ret

0000000000004982 <spin_trylock_irqsave>:

int spin_trylock_irqsave(spinlock_t* lock, int* flags)
{
    4982:	55                   	push   rbp
    4983:	48 89 e5             	mov    rbp,rsp
    4986:	48 83 ec 20          	sub    rsp,0x20
    498a:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    498e:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		int rv;
		*flags = if_enabled();
    4992:	b8 00 00 00 00       	mov    eax,0x0
    4997:	e8 22 b7 ff ff       	call   be <if_enabled>
    499c:	89 c2                	mov    edx,eax
    499e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    49a2:	89 10                	mov    DWORD PTR [rax],edx
		asm("cli");
    49a4:	fa                   	cli
		preempt_disable();
    49a5:	b8 00 00 00 00       	mov    eax,0x0
    49aa:	e8 00 00 00 00       	call   49af <spin_trylock_irqsave+0x2d>
    49af:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    49b2:	83 c2 01             	add    edx,0x1
    49b5:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		rv = spin_trylock(lock);
    49b8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    49bc:	48 89 c7             	mov    rdi,rax
    49bf:	e8 00 00 00 00       	call   49c4 <spin_trylock_irqsave+0x42>
    49c4:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (!rv) {
    49c7:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    49cb:	75 1e                	jne    49eb <spin_trylock_irqsave+0x69>
				if (*flags)
    49cd:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    49d1:	8b 00                	mov    eax,DWORD PTR [rax]
    49d3:	85 c0                	test   eax,eax
    49d5:	74 01                	je     49d8 <spin_trylock_irqsave+0x56>
						asm("sti");
    49d7:	fb                   	sti
				preempt_enable_no_resched();
    49d8:	b8 00 00 00 00       	mov    eax,0x0
    49dd:	e8 00 00 00 00       	call   49e2 <spin_trylock_irqsave+0x60>
    49e2:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    49e5:	83 ea 01             	sub    edx,0x1
    49e8:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		}
		return rv;
    49eb:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    49ee:	c9                   	leave
    49ef:	c3                   	ret

00000000000049f0 <spin_unlock>:

void spin_unlock(spinlock_t* lock)
{
    49f0:	55                   	push   rbp
    49f1:	48 89 e5             	mov    rbp,rsp
    49f4:	48 83 ec 08          	sub    rsp,0x8
    49f8:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		__sync_fetch_and_add(&lock->tickets.head, 1);
    49fc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4a00:	f0 80 00 01          	lock add BYTE PTR [rax],0x1
}
    4a04:	90                   	nop
    4a05:	c9                   	leave
    4a06:	c3                   	ret

0000000000004a07 <spin_unlock_irq>:

void spin_unlock_irq(spinlock_t* lock)
{
    4a07:	55                   	push   rbp
    4a08:	48 89 e5             	mov    rbp,rsp
    4a0b:	48 83 ec 08          	sub    rsp,0x8
    4a0f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		spin_unlock(lock);
    4a13:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4a17:	48 89 c7             	mov    rdi,rax
    4a1a:	e8 00 00 00 00       	call   4a1f <spin_unlock_irq+0x18>
		asm("sti");
    4a1f:	fb                   	sti
}
    4a20:	90                   	nop
    4a21:	c9                   	leave
    4a22:	c3                   	ret

0000000000004a23 <spin_unlock_irqrestore>:

void spin_unlock_irqrestore(spinlock_t* lock, unsigned long flags)
{
    4a23:	55                   	push   rbp
    4a24:	48 89 e5             	mov    rbp,rsp
    4a27:	48 83 ec 10          	sub    rsp,0x10
    4a2b:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    4a2f:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		spin_unlock(lock);
    4a33:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4a37:	48 89 c7             	mov    rdi,rax
    4a3a:	e8 00 00 00 00       	call   4a3f <spin_unlock_irqrestore+0x1c>
		if (flags)
    4a3f:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    4a44:	74 01                	je     4a47 <spin_unlock_irqrestore+0x24>
				asm("sti");
    4a46:	fb                   	sti
		preempt_enable_no_resched();
    4a47:	b8 00 00 00 00       	mov    eax,0x0
    4a4c:	e8 00 00 00 00       	call   4a51 <spin_unlock_irqrestore+0x2e>
    4a51:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    4a54:	83 ea 01             	sub    edx,0x1
    4a57:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
}
    4a5a:	90                   	nop
    4a5b:	c9                   	leave
    4a5c:	c3                   	ret

0000000000004a5d <read_lock>:

void read_lock(rwlock_t* lock)
{
    4a5d:	55                   	push   rbp
    4a5e:	48 89 e5             	mov    rbp,rsp
    4a61:	48 83 ec 08          	sub    rsp,0x8
    4a65:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		if (!__sync_fetch_and_add(&lock->cnts.counter, 1)) {
    4a69:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4a6d:	ba 01 00 00 00       	mov    edx,0x1
    4a72:	f0 0f c1 10          	lock xadd DWORD PTR [rax],edx
    4a76:	85 d2                	test   edx,edx
    4a78:	75 10                	jne    4a8a <read_lock+0x2d>
				/* first reader */
				spin_lock(&lock->lock);
    4a7a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4a7e:	48 83 c0 04          	add    rax,0x4
    4a82:	48 89 c7             	mov    rdi,rax
    4a85:	e8 00 00 00 00       	call   4a8a <read_lock+0x2d>
		}
}
    4a8a:	90                   	nop
    4a8b:	c9                   	leave
    4a8c:	c3                   	ret

0000000000004a8d <read_unlock>:

void read_unlock(rwlock_t* lock)
{
    4a8d:	55                   	push   rbp
    4a8e:	48 89 e5             	mov    rbp,rsp
    4a91:	48 83 ec 08          	sub    rsp,0x8
    4a95:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		if (!__sync_sub_and_fetch(&lock->cnts.counter, 1)) {
    4a99:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    4a9d:	b8 01 00 00 00       	mov    eax,0x1
    4aa2:	f7 d8                	neg    eax
    4aa4:	89 c1                	mov    ecx,eax
    4aa6:	89 c8                	mov    eax,ecx
    4aa8:	f0 0f c1 02          	lock xadd DWORD PTR [rdx],eax
    4aac:	01 c8                	add    eax,ecx
    4aae:	85 c0                	test   eax,eax
    4ab0:	75 10                	jne    4ac2 <read_unlock+0x35>
				/* last reader, allow writing again */
				spin_unlock(&lock->lock);
    4ab2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4ab6:	48 83 c0 04          	add    rax,0x4
    4aba:	48 89 c7             	mov    rdi,rax
    4abd:	e8 00 00 00 00       	call   4ac2 <read_unlock+0x35>
		}
}
    4ac2:	90                   	nop
    4ac3:	c9                   	leave
    4ac4:	c3                   	ret

0000000000004ac5 <write_lock>:

void write_lock(rwlock_t* lock)
{
    4ac5:	55                   	push   rbp
    4ac6:	48 89 e5             	mov    rbp,rsp
    4ac9:	48 83 ec 08          	sub    rsp,0x8
    4acd:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		spin_lock(&lock->lock);
    4ad1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4ad5:	48 83 c0 04          	add    rax,0x4
    4ad9:	48 89 c7             	mov    rdi,rax
    4adc:	e8 00 00 00 00       	call   4ae1 <write_lock+0x1c>
}
    4ae1:	90                   	nop
    4ae2:	c9                   	leave
    4ae3:	c3                   	ret

0000000000004ae4 <write_trylock>:

int write_trylock(rwlock_t* lock)
{
    4ae4:	55                   	push   rbp
    4ae5:	48 89 e5             	mov    rbp,rsp
    4ae8:	48 83 ec 08          	sub    rsp,0x8
    4aec:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		return spin_trylock(&lock->lock);
    4af0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4af4:	48 83 c0 04          	add    rax,0x4
    4af8:	48 89 c7             	mov    rdi,rax
    4afb:	e8 00 00 00 00       	call   4b00 <write_trylock+0x1c>
}
    4b00:	c9                   	leave
    4b01:	c3                   	ret

0000000000004b02 <write_unlock>:

void write_unlock(rwlock_t* lock)
{
    4b02:	55                   	push   rbp
    4b03:	48 89 e5             	mov    rbp,rsp
    4b06:	48 83 ec 08          	sub    rsp,0x8
    4b0a:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		spin_unlock(&lock->lock);
    4b0e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    4b12:	48 83 c0 04          	add    rax,0x4
    4b16:	48 89 c7             	mov    rdi,rax
    4b19:	e8 00 00 00 00       	call   4b1e <write_unlock+0x1c>
}
    4b1e:	90                   	nop
    4b1f:	c9                   	leave
    4b20:	c3                   	ret
