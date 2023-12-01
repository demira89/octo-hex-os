
tasks.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
		uint64_t es;
		uint64_t ds;
		uint64_t r15;
		uint64_t r14;
		uint64_t r13;
		uint64_t r12;
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
		uint64_t r11;
		uint64_t r10;
		uint64_t r9;
		uint64_t r8;
		uint64_t rdi;
       6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
       c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		uint64_t rsi;
		uint64_t rbp;
       f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
		uint64_t rsp;
      12:	c9                   	leave
      13:	c3                   	ret

00000014 <if_enabled>:
		asm("cli");
		if (diag++)
				return;
		framebuffer_redraw(&fb_initial);
		mdelay(1000);
		print_tasks();
      14:	55                   	push   ebp
      15:	89 e5                	mov    ebp,esp
      17:	83 ec 10             	sub    esp,0x10
		printf("PROC TASK TASK_NAME        EIP      ESP\n");
		for (size_t i = end - 1; i != end; i--) {
      1a:	9c                   	pushf
      1b:	58                   	pop    eax
      1c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						framebuffer_redraw(&fb_initial);
				if (!i)
						i = 128;
		}
}

      1f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      22:	83 e0 20             	and    eax,0x20
      25:	85 c0                	test   eax,eax
      27:	0f 95 c0             	setne  al
      2a:	0f b6 c0             	movzx  eax,al
void proc_add_time(uint64_t ns, uint32_t flags)
      2d:	c9                   	leave
      2e:	c3                   	ret

0000002f <alloc_stack>:
{
      2f:	55                   	push   ebp
      30:	89 e5                	mov    ebp,esp
      32:	83 ec 18             	sub    esp,0x18
		while (kernel_stacks.free_stacks) {
      35:	eb 58                	jmp    8f <alloc_stack+0x60>
				rv = kernel_stacks.free_stacks;
      37:	a1 18 00 00 00       	mov    eax,ds:0x18
      3c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (__sync_bool_compare_and_swap(&kernel_stacks.free_stacks, rv, *((void**)rv - 1))) {
      3f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      42:	83 e8 04             	sub    eax,0x4
      45:	8b 00                	mov    eax,DWORD PTR [eax]
      47:	89 c2                	mov    edx,eax
      49:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      4c:	f0 0f b1 15 18 00 00 00 	lock cmpxchg DWORD PTR ds:0x18,edx
      54:	0f 94 c0             	sete   al
      57:	84 c0                	test   al,al
      59:	74 34                	je     8f <alloc_stack+0x60>
										rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_res));
      5b:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
      61:	a1 10 00 00 00       	mov    eax,ds:0x10
      66:	01 d0                	add    eax,edx
      68:	c1 e0 0c             	shl    eax,0xc
      6b:	f7 d8                	neg    eax
      6d:	89 c2                	mov    edx,eax
						cprintf(KFMT_INFO, "stack from %p to %p reused\n", rv,
      6f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      72:	01 d0                	add    eax,edx
      74:	50                   	push   eax
      75:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
      78:	68 00 00 00 00       	push   0x0
      7d:	6a 0b                	push   0xb
      7f:	e8 fc ff ff ff       	call   80 <alloc_stack+0x51>
      84:	83 c4 10             	add    esp,0x10
						return rv;
      87:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      8a:	e9 ce 00 00 00       	jmp    15d <alloc_stack+0x12e>
		while (kernel_stacks.free_stacks) {
      8f:	a1 18 00 00 00       	mov    eax,ds:0x18
      94:	85 c0                	test   eax,eax
      96:	75 9f                	jne    37 <alloc_stack+0x8>
		rv = kernel_stacks.vm_ptr;
      98:	a1 04 00 00 00       	mov    eax,ds:0x4
      9d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rv += 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_guard + kernel_stacks.n_res);
      a0:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
      a6:	a1 14 00 00 00       	mov    eax,ds:0x14
      ab:	01 c2                	add    edx,eax
      ad:	a1 10 00 00 00       	mov    eax,ds:0x10
      b2:	01 d0                	add    eax,edx
      b4:	c1 e0 0c             	shl    eax,0xc
      b7:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		if (rv > kernel_stacks.vm_top)
      ba:	a1 08 00 00 00       	mov    eax,ds:0x8
      bf:	3b 45 f4             	cmp    eax,DWORD PTR [ebp-0xc]
      c2:	73 0a                	jae    ce <alloc_stack+0x9f>
				return NULL;
      c4:	b8 00 00 00 00       	mov    eax,0x0
      c9:	e9 8f 00 00 00       	jmp    15d <alloc_stack+0x12e>
						rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_guard),
      ce:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
      d4:	a1 14 00 00 00       	mov    eax,ds:0x14
      d9:	01 d0                	add    eax,edx
      db:	c1 e0 0c             	shl    eax,0xc
      de:	f7 d8                	neg    eax
      e0:	89 c2                	mov    edx,eax
      e2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      e5:	01 d0                	add    eax,edx
		rv = mm_alloc_vmem(&mm_kernel, kernel_stacks.n_alloc,
      e7:	89 c2                	mov    edx,eax
      e9:	a1 0c 00 00 00       	mov    eax,ds:0xc
      ee:	6a 0c                	push   0xc
      f0:	52                   	push   edx
      f1:	50                   	push   eax
      f2:	68 00 00 00 00       	push   0x0
      f7:	e8 fc ff ff ff       	call   f8 <alloc_stack+0xc9>
      fc:	83 c4 10             	add    esp,0x10
      ff:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (rv) {
     102:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     106:	74 50                	je     158 <alloc_stack+0x129>
				rv += kernel_stacks.n_alloc * 4096;
     108:	a1 0c 00 00 00       	mov    eax,ds:0xc
     10d:	c1 e0 0c             	shl    eax,0xc
     110:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
				kernel_stacks.vm_ptr = rv + 4096 * kernel_stacks.n_guard;
     113:	a1 14 00 00 00       	mov    eax,ds:0x14
     118:	c1 e0 0c             	shl    eax,0xc
     11b:	89 c2                	mov    edx,eax
     11d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     120:	01 d0                	add    eax,edx
     122:	a3 04 00 00 00       	mov    ds:0x4,eax
								rv, rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_res));
     127:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
     12d:	a1 10 00 00 00       	mov    eax,ds:0x10
     132:	01 d0                	add    eax,edx
     134:	c1 e0 0c             	shl    eax,0xc
     137:	f7 d8                	neg    eax
     139:	89 c2                	mov    edx,eax
				cprintf(KFMT_INFO, "alloc_stack(): from %p to %p\n",
     13b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     13e:	01 d0                	add    eax,edx
     140:	50                   	push   eax
     141:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     144:	68 1c 00 00 00       	push   0x1c
     149:	6a 0b                	push   0xb
     14b:	e8 fc ff ff ff       	call   14c <alloc_stack+0x11d>
     150:	83 c4 10             	add    esp,0x10
				return rv;
     153:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     156:	eb 05                	jmp    15d <alloc_stack+0x12e>
				return NULL;
     158:	b8 00 00 00 00       	mov    eax,0x0
}
     15d:	c9                   	leave
     15e:	c3                   	ret

0000015f <free_stack>:
{
     15f:	55                   	push   ebp
     160:	89 e5                	mov    ebp,esp
     162:	83 ec 10             	sub    esp,0x10
		void** pptr = (void**)(stack_base - sizeof(void*));
     165:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     168:	83 e8 04             	sub    eax,0x4
     16b:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				*pptr = kernel_stacks.free_stacks;
     16e:	8b 15 18 00 00 00    	mov    edx,DWORD PTR ds:0x18
     174:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     177:	89 10                	mov    DWORD PTR [eax],edx
		} while (!__sync_bool_compare_and_swap(&kernel_stacks.free_stacks, *pptr, stack_base));
     179:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     17c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     17f:	8b 00                	mov    eax,DWORD PTR [eax]
     181:	f0 0f b1 15 18 00 00 00 	lock cmpxchg DWORD PTR ds:0x18,edx
     189:	0f 94 c0             	sete   al
     18c:	83 f0 01             	xor    eax,0x1
     18f:	84 c0                	test   al,al
     191:	75 db                	jne    16e <free_stack+0xf>
}
     193:	90                   	nop
     194:	90                   	nop
     195:	c9                   	leave
     196:	c3                   	ret

00000197 <install_tss>:
{
     197:	55                   	push   ebp
     198:	89 e5                	mov    ebp,esp
     19a:	53                   	push   ebx
		*gdte = ((uint64_t)(tss_addr & 0x00ffffff) << 16) /* base */
     19b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     19e:	ba 00 00 00 00       	mov    edx,0x0
     1a3:	0f a4 c2 10          	shld   edx,eax,0x10
     1a7:	c1 e0 10             	shl    eax,0x10
     1aa:	66 b8 00 00          	mov    ax,0x0
     1ae:	81 e2 ff 00 00 00    	and    edx,0xff
     1b4:	89 c1                	mov    ecx,eax
     1b6:	89 d3                	mov    ebx,edx
				+ ((uint64_t)(tss_addr & 0xff000000) << 32)
     1b8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1bb:	ba 00 00 00 00       	mov    edx,0x0
     1c0:	89 c2                	mov    edx,eax
     1c2:	31 c0                	xor    eax,eax
     1c4:	b8 00 00 00 00       	mov    eax,0x0
     1c9:	81 e2 00 00 00 ff    	and    edx,0xff000000
     1cf:	09 c8                	or     eax,ecx
     1d1:	09 da                	or     edx,ebx
				+ (sizeof(struct tss) - 1);
     1d3:	83 c0 67             	add    eax,0x67
     1d6:	81 d2 00 89 40 00    	adc    edx,0x408900
		*gdte = ((uint64_t)(tss_addr & 0x00ffffff) << 16) /* base */
     1dc:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     1df:	89 01                	mov    DWORD PTR [ecx],eax
     1e1:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
}
     1e4:	90                   	nop
     1e5:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     1e8:	c9                   	leave
     1e9:	c3                   	ret

000001ea <mmgr_init_tss>:
{
     1ea:	55                   	push   ebp
     1eb:	89 e5                	mov    ebp,esp
     1ed:	83 ec 18             	sub    esp,0x18
		uint64_t* gdt = &kernltss;
     1f0:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		void* stk = alloc_stack();
     1f7:	e8 fc ff ff ff       	call   1f8 <mmgr_init_tss+0xe>
     1fc:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (stk)
     1ff:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     203:	74 15                	je     21a <mmgr_init_tss+0x30>
				printf("allocated interrupt stack for first TSS at %p\n", stk);
     205:	83 ec 08             	sub    esp,0x8
     208:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     20b:	68 3c 00 00 00       	push   0x3c
     210:	e8 fc ff ff ff       	call   211 <mmgr_init_tss+0x27>
     215:	83 c4 10             	add    esp,0x10
     218:	eb 02                	jmp    21c <mmgr_init_tss+0x32>
		else while (1);
     21a:	eb fe                	jmp    21a <mmgr_init_tss+0x30>
		main_tss.ss0 = SEG_DATA; /* kernel ds */
     21c:	66 c7 05 08 00 00 00 10 00 	mov    WORD PTR ds:0x8,0x10
		main_tss.esp0 = (uint32_t)stk;
     225:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     228:	a3 04 00 00 00       	mov    ds:0x4,eax
		main_tss.iomap = sizeof(struct tss);
     22d:	66 c7 05 66 00 00 00 68 00 	mov    WORD PTR ds:0x66,0x68
		install_tss(gdt, (intptr_t)&main_tss);
     236:	b8 00 00 00 00       	mov    eax,0x0
     23b:	83 ec 08             	sub    esp,0x8
     23e:	50                   	push   eax
     23f:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     242:	e8 fc ff ff ff       	call   243 <mmgr_init_tss+0x59>
     247:	83 c4 10             	add    esp,0x10
		asm volatile("ltr %%ax": : "a" (SEG_TSS_PL0));
     24a:	b8 28 00 00 00       	mov    eax,0x28
     24f:	0f 00 d8             	ltr    eax
		gdt = &intrtss;
     252:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		intr_tss.iomap = sizeof(struct tss);
     259:	66 c7 05 66 00 00 00 68 00 	mov    WORD PTR ds:0x66,0x68
		intr_tss.ss0 = SEG_DATA;
     262:	66 c7 05 08 00 00 00 10 00 	mov    WORD PTR ds:0x8,0x10
		intr_tss.esp0 = (uint32_t)stk;
     26b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     26e:	a3 04 00 00 00       	mov    ds:0x4,eax
		intr_tss.cs = SEG_CODE;
     273:	66 c7 05 4c 00 00 00 08 00 	mov    WORD PTR ds:0x4c,0x8
		intr_tss.ds = intr_tss.es = SEG_DATA;
     27c:	b8 10 00 00 00       	mov    eax,0x10
     281:	66 a3 48 00 00 00    	mov    ds:0x48,ax
     287:	66 a3 54 00 00 00    	mov    ds:0x54,ax
		intr_tss.ss = SEG_DATA;
     28d:	66 c7 05 50 00 00 00 10 00 	mov    WORD PTR ds:0x50,0x10
		intr_tss.gs = SEG_DATA;
     296:	66 c7 05 5c 00 00 00 10 00 	mov    WORD PTR ds:0x5c,0x10
		intr_tss.fs = SEG_DATA_PROC;
     29f:	66 c7 05 58 00 00 00 40 00 	mov    WORD PTR ds:0x58,0x40
		intr_tss.esp = (uint32_t)stk;// - 0x40; /* esp+14*x in handler <- PROLLY MISCONCEPTION */
     2a8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2ab:	a3 38 00 00 00       	mov    ds:0x38,eax
		asm ("mov %%cr3, %%eax\n movl %%eax, %0\n" : "=m" (intr_tss.cr3) : : "eax");
     2b0:	0f 20 d8             	mov    eax,cr3
     2b3:	a3 1c 00 00 00       	mov    ds:0x1c,eax
		intr_tss.eip = (uint32_t)&gate_8; /* already uses iret */
     2b8:	b8 00 00 00 00       	mov    eax,0x0
     2bd:	a3 20 00 00 00       	mov    ds:0x20,eax
		install_tss(gdt, (uintptr_t)&intr_tss);
     2c2:	b8 00 00 00 00       	mov    eax,0x0
     2c7:	83 ec 08             	sub    esp,0x8
     2ca:	50                   	push   eax
     2cb:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     2ce:	e8 fc ff ff ff       	call   2cf <mmgr_init_tss+0xe5>
     2d3:	83 c4 10             	add    esp,0x10
		idt_desc_8 = 0x0000850000480000;
     2d6:	c7 05 00 00 00 00 00 00 48 00 	mov    DWORD PTR ds:0x0,0x480000
     2e0:	c7 05 04 00 00 00 00 85 00 00 	mov    DWORD PTR ds:0x4,0x8500
}
     2ea:	90                   	nop
     2eb:	c9                   	leave
     2ec:	c3                   	ret

000002ed <pq_enqueue>:
{
     2ed:	55                   	push   ebp
     2ee:	89 e5                	mov    ebp,esp
     2f0:	53                   	push   ebx
     2f1:	83 ec 14             	sub    esp,0x14
		struct pqe* e = pq->queues[t->cur_priority];
     2f4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     2f7:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
     2fa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2fd:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
     300:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!e) {
     303:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     307:	75 58                	jne    361 <pq_enqueue+0x74>
				e = pq->queues[t->cur_priority] = kzalloc(sizeof(struct pqe));
     309:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     30c:	8b 58 30             	mov    ebx,DWORD PTR [eax+0x30]
     30f:	83 ec 0c             	sub    esp,0xc
     312:	68 8c 00 00 00       	push   0x8c
     317:	e8 fc ff ff ff       	call   318 <pq_enqueue+0x2b>
     31c:	83 c4 10             	add    esp,0x10
     31f:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     322:	89 04 9a             	mov    DWORD PTR [edx+ebx*4],eax
     325:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     328:	8b 04 98             	mov    eax,DWORD PTR [eax+ebx*4]
     32b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				e->next = NULL;
     32e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     331:	c7 80 88 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x88],0x0
				e->cur = e->end = &e->tks[0];
     33b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     33e:	8d 50 08             	lea    edx,[eax+0x8]
     341:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     344:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     347:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     34a:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     34d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     350:	89 10                	mov    DWORD PTR [eax],edx
				pq->queues[t->cur_priority] = e;
     352:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     355:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
     358:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     35b:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     35e:	89 0c 90             	mov    DWORD PTR [eax+edx*4],ecx
				if (e->end + 1 != e->cur) {
     361:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     364:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     367:	8d 50 04             	lea    edx,[eax+0x4]
     36a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     36d:	8b 00                	mov    eax,DWORD PTR [eax]
     36f:	39 c2                	cmp    edx,eax
     371:	74 60                	je     3d3 <pq_enqueue+0xe6>
						if (!(e->cur == e->tks && (e->end + 1 == e->tks + COUNT_OF(e->tks)))) {
     373:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     376:	8b 10                	mov    edx,DWORD PTR [eax]
     378:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     37b:	83 c0 08             	add    eax,0x8
     37e:	39 c2                	cmp    edx,eax
     380:	75 16                	jne    398 <pq_enqueue+0xab>
     382:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     385:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     388:	8d 50 04             	lea    edx,[eax+0x4]
     38b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     38e:	83 c0 08             	add    eax,0x8
     391:	83 e8 80             	sub    eax,0xffffff80
     394:	39 c2                	cmp    edx,eax
     396:	74 3b                	je     3d3 <pq_enqueue+0xe6>
								*e->end = t;
     398:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     39b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     39e:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     3a1:	89 10                	mov    DWORD PTR [eax],edx
								if (++e->end == e->tks + COUNT_OF(e->tks))
     3a3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3a6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     3a9:	8d 50 04             	lea    edx,[eax+0x4]
     3ac:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3af:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     3b2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3b5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     3b8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3bb:	83 c0 08             	add    eax,0x8
     3be:	83 e8 80             	sub    eax,0xffffff80
     3c1:	39 c2                	cmp    edx,eax
     3c3:	75 7e                	jne    443 <pq_enqueue+0x156>
										e->end = &e->tks[0];
     3c5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3c8:	8d 50 08             	lea    edx,[eax+0x8]
     3cb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3ce:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								return;
     3d1:	eb 70                	jmp    443 <pq_enqueue+0x156>
				if (!e->next) {
     3d3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3d6:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     3dc:	85 c0                	test   eax,eax
     3de:	75 52                	jne    432 <pq_enqueue+0x145>
						e->next = kzalloc(sizeof(struct pqe));
     3e0:	83 ec 0c             	sub    esp,0xc
     3e3:	68 8c 00 00 00       	push   0x8c
     3e8:	e8 fc ff ff ff       	call   3e9 <pq_enqueue+0xfc>
     3ed:	83 c4 10             	add    esp,0x10
     3f0:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     3f3:	89 82 88 00 00 00    	mov    DWORD PTR [edx+0x88],eax
						e->next->next = NULL;
     3f9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3fc:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     402:	c7 80 88 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x88],0x0
						e->next->cur = e->next->end = &e->next->tks[0];
     40c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     40f:	8b 90 88 00 00 00    	mov    edx,DWORD PTR [eax+0x88]
     415:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     418:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     41e:	83 c2 08             	add    edx,0x8
     421:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     424:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     427:	8b 92 88 00 00 00    	mov    edx,DWORD PTR [edx+0x88]
     42d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     430:	89 02                	mov    DWORD PTR [edx],eax
				e = e->next;
     432:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     435:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     43b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (e->end + 1 != e->cur) {
     43e:	e9 1e ff ff ff       	jmp    361 <pq_enqueue+0x74>
								return;
     443:	90                   	nop
}
     444:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     447:	c9                   	leave
     448:	c3                   	ret

00000449 <pq_dequeue>:
{
     449:	55                   	push   ebp
     44a:	89 e5                	mov    ebp,esp
     44c:	83 ec 10             	sub    esp,0x10
		for (uint32_t p = PRIORITY_MAX; p <= PRIORITY_MIN; p++) {
     44f:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     456:	eb 67                	jmp    4bf <pq_dequeue+0x76>
				struct pqe* e = pq->queues[p];
     458:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     45b:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     45e:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
     461:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
				while (e) {
     464:	eb 4f                	jmp    4b5 <pq_dequeue+0x6c>
						if (e->cur != e->end) {
     466:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     469:	8b 10                	mov    edx,DWORD PTR [eax]
     46b:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     46e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     471:	39 c2                	cmp    edx,eax
     473:	74 34                	je     4a9 <pq_dequeue+0x60>
								rv = *e->cur++;
     475:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     478:	8b 00                	mov    eax,DWORD PTR [eax]
     47a:	8d 48 04             	lea    ecx,[eax+0x4]
     47d:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
     480:	89 0a                	mov    DWORD PTR [edx],ecx
     482:	8b 00                	mov    eax,DWORD PTR [eax]
     484:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								if (e->cur == (e->tks + COUNT_OF(e->tks)))
     487:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     48a:	8b 10                	mov    edx,DWORD PTR [eax]
     48c:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     48f:	83 c0 08             	add    eax,0x8
     492:	83 e8 80             	sub    eax,0xffffff80
     495:	39 c2                	cmp    edx,eax
     497:	75 0b                	jne    4a4 <pq_dequeue+0x5b>
										e->cur = e->tks;
     499:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     49c:	8d 50 08             	lea    edx,[eax+0x8]
     49f:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     4a2:	89 10                	mov    DWORD PTR [eax],edx
								return rv;
     4a4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4a7:	eb 21                	jmp    4ca <pq_dequeue+0x81>
						e = e->next;
     4a9:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     4ac:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     4b2:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
				while (e) {
     4b5:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     4b9:	75 ab                	jne    466 <pq_dequeue+0x1d>
		for (uint32_t p = PRIORITY_MAX; p <= PRIORITY_MIN; p++) {
     4bb:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
     4bf:	83 7d fc 03          	cmp    DWORD PTR [ebp-0x4],0x3
     4c3:	76 93                	jbe    458 <pq_dequeue+0xf>
		return NULL; /* major rotation */
     4c5:	b8 00 00 00 00       	mov    eax,0x0
}
     4ca:	c9                   	leave
     4cb:	c3                   	ret

000004cc <get_stack>:
{
     4cc:	55                   	push   ebp
     4cd:	89 e5                	mov    ebp,esp
     4cf:	83 ec 10             	sub    esp,0x10
		if ((ptr < kernel_stacks.vm_base) || (ptr > kernel_stacks.vm_ptr)) {
     4d2:	a1 00 00 00 00       	mov    eax,ds:0x0
     4d7:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
     4da:	72 0a                	jb     4e6 <get_stack+0x1a>
     4dc:	a1 04 00 00 00       	mov    eax,ds:0x4
     4e1:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
     4e4:	73 07                	jae    4ed <get_stack+0x21>
				return -1;
     4e6:	b8 ff ff ff ff       	mov    eax,0xffffffff
     4eb:	eb 73                	jmp    560 <get_stack+0x94>
		ptr = (void*)((size_t)ptr - (size_t)kernel_stacks.vm_base);
     4ed:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4f0:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     4f6:	29 d0                	sub    eax,edx
     4f8:	89 45 08             	mov    DWORD PTR [ebp+0x8],eax
		rv = (size_t)ptr / 4096;
     4fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4fe:	c1 e8 0c             	shr    eax,0xc
     501:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		np = kernel_stacks.n_alloc + kernel_stacks.n_guard + kernel_stacks.n_res;
     504:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
     50a:	a1 14 00 00 00       	mov    eax,ds:0x14
     50f:	01 c2                	add    edx,eax
     511:	a1 10 00 00 00       	mov    eax,ds:0x10
     516:	01 d0                	add    eax,edx
     518:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		rv /= np;
     51b:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     51e:	ba 00 00 00 00       	mov    edx,0x0
     523:	f7 75 f8             	div    DWORD PTR [ebp-0x8]
     526:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		sl->limit = kernel_stacks.vm_base + rv * np * 4096;
     529:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     52f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     532:	0f af 45 f8          	imul   eax,DWORD PTR [ebp-0x8]
     536:	c1 e0 0c             	shl    eax,0xc
     539:	01 c2                	add    edx,eax
     53b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     53e:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		sl->base = sl->limit + 4096 * (np - kernel_stacks.n_guard);
     541:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     544:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     547:	a1 14 00 00 00       	mov    eax,ds:0x14
     54c:	8b 4d f8             	mov    ecx,DWORD PTR [ebp-0x8]
     54f:	29 c1                	sub    ecx,eax
     551:	89 c8                	mov    eax,ecx
     553:	c1 e0 0c             	shl    eax,0xc
     556:	01 c2                	add    edx,eax
     558:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     55b:	89 10                	mov    DWORD PTR [eax],edx
		return rv;
     55d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
     560:	c9                   	leave
     561:	c3                   	ret

00000562 <task_gettime>:
{
     562:	55                   	push   ebp
     563:	89 e5                	mov    ebp,esp
     565:	57                   	push   edi
     566:	56                   	push   esi
     567:	53                   	push   ebx
     568:	83 ec 14             	sub    esp,0x14
		if (cpu.invariant_tsc) {
     56b:	a1 6c 00 00 00       	mov    eax,ds:0x6c
     570:	85 c0                	test   eax,eax
     572:	74 0d                	je     581 <task_gettime+0x1f>
				asm volatile ("rdtsc" : "=A" (rv));
     574:	0f 31                	rdtsc
     576:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     579:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     57c:	e9 98 00 00 00       	jmp    619 <task_gettime+0xb7>
		} else if (cpu.has_apic) {
     581:	0f b6 05 59 00 00 00 	movzx  eax,BYTE PTR ds:0x59
     588:	83 e0 02             	and    eax,0x2
     58b:	84 c0                	test   al,al
     58d:	74 7a                	je     609 <task_gettime+0xa7>
				if (!apic_initialized)
     58f:	a1 00 00 00 00       	mov    eax,ds:0x0
     594:	85 c0                	test   eax,eax
     596:	75 0c                	jne    5a4 <task_gettime+0x42>
						return 0;
     598:	b8 00 00 00 00       	mov    eax,0x0
     59d:	ba 00 00 00 00       	mov    edx,0x0
     5a2:	eb 7b                	jmp    61f <task_gettime+0xbd>
				if (nproc > 1)
     5a4:	a1 00 00 00 00       	mov    eax,ds:0x0
     5a9:	83 f8 01             	cmp    eax,0x1
     5ac:	76 35                	jbe    5e3 <task_gettime+0x81>
						rv = (per_cpu_ptr()->ticks->tick << 32) | apic_reg(APIC_REG_TMRCURRCNT);
     5ae:	e8 4d fa ff ff       	call   0 <per_cpu_ptr>
     5b3:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     5b6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     5b9:	8b 00                	mov    eax,DWORD PTR [eax]
     5bb:	89 c2                	mov    edx,eax
     5bd:	31 c0                	xor    eax,eax
     5bf:	89 c6                	mov    esi,eax
     5c1:	89 d7                	mov    edi,edx
     5c3:	e8 38 fa ff ff       	call   0 <per_cpu_ptr>
     5c8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     5cb:	05 90 03 00 00       	add    eax,0x390
     5d0:	8b 00                	mov    eax,DWORD PTR [eax]
     5d2:	ba 00 00 00 00       	mov    edx,0x0
     5d7:	09 f0                	or     eax,esi
     5d9:	09 fa                	or     edx,edi
     5db:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     5de:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     5e1:	eb 36                	jmp    619 <task_gettime+0xb7>
						rv = (jiffies << 32) | apic_bp_reg(APIC_REG_TMRCURRCNT);
     5e3:	a1 00 00 00 00       	mov    eax,ds:0x0
     5e8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     5eb:	8b 00                	mov    eax,DWORD PTR [eax]
     5ed:	89 c2                	mov    edx,eax
     5ef:	31 c0                	xor    eax,eax
     5f1:	b9 90 03 ff ef       	mov    ecx,0xefff0390
     5f6:	8b 09                	mov    ecx,DWORD PTR [ecx]
     5f8:	bb 00 00 00 00       	mov    ebx,0x0
     5fd:	09 c8                	or     eax,ecx
     5ff:	09 da                	or     edx,ebx
     601:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     604:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     607:	eb 10                	jmp    619 <task_gettime+0xb7>
			rv = jiffies;
     609:	a1 00 00 00 00       	mov    eax,ds:0x0
     60e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     611:	8b 00                	mov    eax,DWORD PTR [eax]
     613:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     616:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		return rv;
     619:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     61c:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
}
     61f:	83 c4 14             	add    esp,0x14
     622:	5b                   	pop    ebx
     623:	5e                   	pop    esi
     624:	5f                   	pop    edi
     625:	5d                   	pop    ebp
     626:	c3                   	ret

00000627 <get_task_esp>:
{
     627:	55                   	push   ebp
     628:	89 e5                	mov    ebp,esp
     62a:	83 ec 18             	sub    esp,0x18
		stk = get_stack(esp, &sl);
     62d:	8d 45 e8             	lea    eax,[ebp-0x18]
     630:	50                   	push   eax
     631:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     634:	e8 fc ff ff ff       	call   635 <get_task_esp+0xe>
     639:	83 c4 08             	add    esp,0x8
     63c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (stk == -1) {
     63f:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
     643:	75 5b                	jne    6a0 <get_task_esp+0x79>
				if (preempt_needs_init)
     645:	a1 00 00 00 00       	mov    eax,ds:0x0
     64a:	85 c0                	test   eax,eax
     64c:	74 07                	je     655 <get_task_esp+0x2e>
						return &dummy;
     64e:	b8 60 00 00 00       	mov    eax,0x60
     653:	eb 58                	jmp    6ad <get_task_esp+0x86>
				printf("kernel_stacks: %p to %p\n", kernel_stacks.vm_base, kernel_stacks.vm_ptr);
     655:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
     65b:	a1 00 00 00 00       	mov    eax,ds:0x0
     660:	83 ec 04             	sub    esp,0x4
     663:	52                   	push   edx
     664:	50                   	push   eax
     665:	68 6b 00 00 00       	push   0x6b
     66a:	e8 fc ff ff ff       	call   66b <get_task_esp+0x44>
     66f:	83 c4 10             	add    esp,0x10
				die("unkown stack at %p\n", esp);
     672:	83 ec 04             	sub    esp,0x4
     675:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     678:	68 84 00 00 00       	push   0x84
     67d:	6a 0c                	push   0xc
     67f:	e8 fc ff ff ff       	call   680 <get_task_esp+0x59>
     684:	83 c4 10             	add    esp,0x10
     687:	e8 fc ff ff ff       	call   688 <get_task_esp+0x61>
     68c:	83 ec 0c             	sub    esp,0xc
     68f:	68 00 00 00 00       	push   0x0
     694:	e8 fc ff ff ff       	call   695 <get_task_esp+0x6e>
     699:	83 c4 10             	add    esp,0x10
     69c:	fa                   	cli
     69d:	f4                   	hlt
     69e:	eb fd                	jmp    69d <get_task_esp+0x76>
		rv = sl.base;
     6a0:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     6a3:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rv--;
     6a6:	83 6d f0 6c          	sub    DWORD PTR [ebp-0x10],0x6c
		return rv;
     6aa:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     6ad:	c9                   	leave
     6ae:	c3                   	ret

000006af <get_task>:
{
     6af:	55                   	push   ebp
     6b0:	89 e5                	mov    ebp,esp
     6b2:	83 ec 18             	sub    esp,0x18
		return get_task_esp(&dm);
     6b5:	83 ec 0c             	sub    esp,0xc
     6b8:	8d 45 f4             	lea    eax,[ebp-0xc]
     6bb:	50                   	push   eax
     6bc:	e8 fc ff ff ff       	call   6bd <get_task+0xe>
     6c1:	83 c4 10             	add    esp,0x10
}
     6c4:	c9                   	leave
     6c5:	c3                   	ret

000006c6 <task_save_state>:
{
     6c6:	55                   	push   ebp
     6c7:	89 e5                	mov    ebp,esp
     6c9:	83 ec 18             	sub    esp,0x18
		if (esp->cs & 3) { /* RPL>0, i.e. call from usermode */
     6cc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6cf:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
     6d2:	83 e0 03             	and    eax,0x3
     6d5:	85 c0                	test   eax,eax
     6d7:	74 56                	je     72f <task_save_state+0x69>
				st = get_stack(esp, &sl);
     6d9:	8d 45 e8             	lea    eax,[ebp-0x18]
     6dc:	50                   	push   eax
     6dd:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     6e0:	e8 fc ff ff ff       	call   6e1 <task_save_state+0x1b>
     6e5:	83 c4 08             	add    esp,0x8
     6e8:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								(void*)esp->esp_rpl
     6eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6ee:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
				printf("irq0 from usermode with stack at %p\n",
     6f1:	83 ec 08             	sub    esp,0x8
     6f4:	50                   	push   eax
     6f5:	68 98 00 00 00       	push   0x98
     6fa:	e8 fc ff ff ff       	call   6fb <task_save_state+0x35>
     6ff:	83 c4 10             	add    esp,0x10
				printf("current esp: %p\n", esp);
     702:	83 ec 08             	sub    esp,0x8
     705:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     708:	68 bd 00 00 00       	push   0xbd
     70d:	e8 fc ff ff ff       	call   70e <task_save_state+0x48>
     712:	83 c4 10             	add    esp,0x10
				printf("cs: %x\n", esp->cs);
     715:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     718:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
     71b:	83 ec 08             	sub    esp,0x8
     71e:	50                   	push   eax
     71f:	68 ce 00 00 00       	push   0xce
     724:	e8 fc ff ff ff       	call   725 <task_save_state+0x5f>
     729:	83 c4 10             	add    esp,0x10
				while (1);
     72c:	90                   	nop
     72d:	eb fd                	jmp    72c <task_save_state+0x66>
		} else if ((size_t)esp <= 0x80000 && (size_t)esp > 0x60000) {
     72f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     732:	3d 00 00 08 00       	cmp    eax,0x80000
     737:	77 0a                	ja     743 <task_save_state+0x7d>
     739:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     73c:	3d 00 00 06 00       	cmp    eax,0x60000
     741:	77 4e                	ja     791 <task_save_state+0xcb>
				st = get_stack(esp, &sl);
     743:	83 ec 08             	sub    esp,0x8
     746:	8d 45 e8             	lea    eax,[ebp-0x18]
     749:	50                   	push   eax
     74a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     74d:	e8 fc ff ff ff       	call   74e <task_save_state+0x88>
     752:	83 c4 10             	add    esp,0x10
     755:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (st == -1) {
     758:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
     75c:	75 12                	jne    770 <task_save_state+0xaa>
						printf("unrecognized ring0 task!\n");
     75e:	83 ec 0c             	sub    esp,0xc
     761:	68 d6 00 00 00       	push   0xd6
     766:	e8 fc ff ff ff       	call   767 <task_save_state+0xa1>
     76b:	83 c4 10             	add    esp,0x10
     76e:	eb 21                	jmp    791 <task_save_state+0xcb>
				t = sl.base;
     770:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     773:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				t--;
     776:	83 6d f0 6c          	sub    DWORD PTR [ebp-0x10],0x6c
				t->ts = esp;
     77a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     77d:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     780:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				t->stop_time = task_gettime();
     783:	e8 fc ff ff ff       	call   784 <task_save_state+0xbe>
     788:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     78b:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
     78e:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
}
     791:	c9                   	leave
     792:	c3                   	ret

00000793 <print_task>:
{
     793:	55                   	push   ebp
     794:	89 e5                	mov    ebp,esp
     796:	57                   	push   edi
     797:	56                   	push   esi
     798:	53                   	push   ebx
     799:	83 ec 4c             	sub    esp,0x4c
		char proc_str[5] = "N/A";
     79c:	c7 45 e3 4e 2f 41 00 	mov    DWORD PTR [ebp-0x1d],0x412f4e
     7a3:	c6 45 e7 00          	mov    BYTE PTR [ebp-0x19],0x0
		if (ts->task_proc != 0xffffffff)
     7a7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7aa:	8b 40 44             	mov    eax,DWORD PTR [eax+0x44]
     7ad:	83 f8 ff             	cmp    eax,0xffffffff
     7b0:	74 1a                	je     7cc <print_task+0x39>
				snprintf(proc_str, 5, "%4u", ts->task_proc);
     7b2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7b5:	8b 40 44             	mov    eax,DWORD PTR [eax+0x44]
     7b8:	50                   	push   eax
     7b9:	68 f0 00 00 00       	push   0xf0
     7be:	6a 05                	push   0x5
     7c0:	8d 45 e3             	lea    eax,[ebp-0x1d]
     7c3:	50                   	push   eax
     7c4:	e8 fc ff ff ff       	call   7c5 <print_task+0x32>
     7c9:	83 c4 10             	add    esp,0x10
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     7cc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7cf:	8b 40 68             	mov    eax,DWORD PTR [eax+0x68]
     7d2:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     7d5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7d8:	8b 40 64             	mov    eax,DWORD PTR [eax+0x64]
     7db:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
     7de:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7e1:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     7e4:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
     7e7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7ea:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     7ed:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
     7f0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7f3:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     7f6:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
     7f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7fc:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     7ff:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
				(uint32_t)(ts->ns_acc / 1000000000), ts->ns_per_sec / 1000000,
     802:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     805:	8b 40 60             	mov    eax,DWORD PTR [eax+0x60]
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     808:	ba 83 de 1b 43       	mov    edx,0x431bde83
     80d:	f7 e2                	mul    edx
     80f:	c1 ea 12             	shr    edx,0x12
     812:	89 55 b8             	mov    DWORD PTR [ebp-0x48],edx
				(uint32_t)(ts->ns_acc / 1000000000), ts->ns_per_sec / 1000000,
     815:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     818:	8b 50 54             	mov    edx,DWORD PTR [eax+0x54]
     81b:	8b 40 50             	mov    eax,DWORD PTR [eax+0x50]
     81e:	6a 00                	push   0x0
     820:	68 00 ca 9a 3b       	push   0x3b9aca00
     825:	52                   	push   edx
     826:	50                   	push   eax
     827:	e8 fc ff ff ff       	call   828 <print_task+0x95>
     82c:	83 c4 10             	add    esp,0x10
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     82f:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
     832:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     835:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
     838:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
     83b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     83e:	8b 78 28             	mov    edi,DWORD PTR [eax+0x28]
     841:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     844:	8b 70 08             	mov    esi,DWORD PTR [eax+0x8]
				(ts->flags & TIF_YIELDED) ? 'Y' : ' ', proc_str,
     847:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     84a:	8b 00                	mov    eax,DWORD PTR [eax]
     84c:	83 e0 02             	and    eax,0x2
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     84f:	85 c0                	test   eax,eax
     851:	74 09                	je     85c <print_task+0xc9>
     853:	c7 45 d4 59 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x59
     85a:	eb 07                	jmp    863 <print_task+0xd0>
     85c:	c7 45 d4 20 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x20
				(ts->flags & TIF_KERNEL_STACK) ? ((ts->flags & TIF_IDLE) ? 'I' : 'K') : 'U',
     863:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     866:	8b 00                	mov    eax,DWORD PTR [eax]
     868:	83 e0 08             	and    eax,0x8
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     86b:	85 c0                	test   eax,eax
     86d:	74 1a                	je     889 <print_task+0xf6>
				(ts->flags & TIF_KERNEL_STACK) ? ((ts->flags & TIF_IDLE) ? 'I' : 'K') : 'U',
     86f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     872:	8b 00                	mov    eax,DWORD PTR [eax]
     874:	83 e0 40             	and    eax,0x40
     877:	85 c0                	test   eax,eax
     879:	74 07                	je     882 <print_task+0xef>
     87b:	bb 49 00 00 00       	mov    ebx,0x49
     880:	eb 0c                	jmp    88e <print_task+0xfb>
     882:	bb 4b 00 00 00       	mov    ebx,0x4b
     887:	eb 05                	jmp    88e <print_task+0xfb>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     889:	bb 55 00 00 00       	mov    ebx,0x55
				(ts->flags & TIF_RUNNING) ? 'R' : (ts->flags & TIF_EXPIRED) ? 'X' : (ts->flags & TIF_SLEEPING) ? 'S': ' ',
     88e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     891:	8b 00                	mov    eax,DWORD PTR [eax]
     893:	83 e0 10             	and    eax,0x10
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     896:	85 c0                	test   eax,eax
     898:	75 2f                	jne    8c9 <print_task+0x136>
				(ts->flags & TIF_RUNNING) ? 'R' : (ts->flags & TIF_EXPIRED) ? 'X' : (ts->flags & TIF_SLEEPING) ? 'S': ' ',
     89a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     89d:	8b 00                	mov    eax,DWORD PTR [eax]
     89f:	83 e0 20             	and    eax,0x20
     8a2:	85 c0                	test   eax,eax
     8a4:	75 1c                	jne    8c2 <print_task+0x12f>
     8a6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8a9:	8b 00                	mov    eax,DWORD PTR [eax]
     8ab:	25 80 00 00 00       	and    eax,0x80
     8b0:	85 c0                	test   eax,eax
     8b2:	74 07                	je     8bb <print_task+0x128>
     8b4:	b9 53 00 00 00       	mov    ecx,0x53
     8b9:	eb 13                	jmp    8ce <print_task+0x13b>
     8bb:	b9 20 00 00 00       	mov    ecx,0x20
     8c0:	eb 0c                	jmp    8ce <print_task+0x13b>
     8c2:	b9 58 00 00 00       	mov    ecx,0x58
     8c7:	eb 05                	jmp    8ce <print_task+0x13b>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     8c9:	b9 52 00 00 00       	mov    ecx,0x52
     8ce:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8d1:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     8d4:	83 ec 0c             	sub    esp,0xc
     8d7:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
     8da:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
     8dd:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
     8e0:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
     8e3:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     8e6:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
     8e9:	ff 75 b8             	push   DWORD PTR [ebp-0x48]
     8ec:	ff 75 b4             	push   DWORD PTR [ebp-0x4c]
     8ef:	ff 75 b0             	push   DWORD PTR [ebp-0x50]
     8f2:	57                   	push   edi
     8f3:	56                   	push   esi
     8f4:	8d 45 e3             	lea    eax,[ebp-0x1d]
     8f7:	50                   	push   eax
     8f8:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     8fb:	53                   	push   ebx
     8fc:	51                   	push   ecx
     8fd:	52                   	push   edx
     8fe:	68 f4 00 00 00       	push   0xf4
     903:	e8 fc ff ff ff       	call   904 <print_task+0x171>
     908:	83 c4 50             	add    esp,0x50
}
     90b:	90                   	nop
     90c:	8d 65 f4             	lea    esp,[ebp-0xc]
     90f:	5b                   	pop    ebx
     910:	5e                   	pop    esi
     911:	5f                   	pop    edi
     912:	5d                   	pop    ebp
     913:	c3                   	ret

00000914 <cpu_stat_counter>:
{
     914:	55                   	push   ebp
     915:	89 e5                	mov    ebp,esp
     917:	83 ec 18             	sub    esp,0x18
		if (nproc > 1) {
     91a:	a1 00 00 00 00       	mov    eax,ds:0x0
     91f:	83 f8 01             	cmp    eax,0x1
     922:	76 26                	jbe    94a <cpu_stat_counter+0x36>
				struct processor_data* pd = get_cpu_data(id);
     924:	83 ec 0c             	sub    esp,0xc
     927:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     92a:	e8 fc ff ff ff       	call   92b <cpu_stat_counter+0x17>
     92f:	83 c4 10             	add    esp,0x10
     932:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (!pd)
     935:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     939:	75 07                	jne    942 <cpu_stat_counter+0x2e>
						return NULL;
     93b:	b8 00 00 00 00       	mov    eax,0x0
     940:	eb 0d                	jmp    94f <cpu_stat_counter+0x3b>
				return pd->ticks;
     942:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     945:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     948:	eb 05                	jmp    94f <cpu_stat_counter+0x3b>
				return bp_tick;
     94a:	a1 00 00 00 00       	mov    eax,ds:0x0
}
     94f:	c9                   	leave
     950:	c3                   	ret

00000951 <cpu_calc_percentages>:
{
     951:	55                   	push   ebp
     952:	89 e5                	mov    ebp,esp
     954:	56                   	push   esi
     955:	53                   	push   ebx
     956:	83 ec 10             	sub    esp,0x10
		struct perf_ctrs* pc = cpu_stat_counter(i);
     959:	83 ec 0c             	sub    esp,0xc
     95c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     95f:	e8 fc ff ff ff       	call   960 <cpu_calc_percentages+0xf>
     964:	83 c4 10             	add    esp,0x10
     967:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!pc) {
     96a:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     96e:	75 3e                	jne    9ae <cpu_calc_percentages+0x5d>
				bzero(&cpu_pcs[i + 1], sizeof(cpu_pcs[i + 1]));
     970:	a1 00 00 00 00       	mov    eax,ds:0x0
     975:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     978:	83 c2 01             	add    edx,0x1
     97b:	c1 e2 05             	shl    edx,0x5
     97e:	01 d0                	add    eax,edx
     980:	83 ec 08             	sub    esp,0x8
     983:	6a 20                	push   0x20
     985:	50                   	push   eax
     986:	e8 fc ff ff ff       	call   987 <cpu_calc_percentages+0x36>
     98b:	83 c4 10             	add    esp,0x10
				cpu_pcs[i + 1].vals[0] = 0xffffffff;
     98e:	a1 00 00 00 00       	mov    eax,ds:0x0
     993:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     996:	83 c2 01             	add    edx,0x1
     999:	c1 e2 05             	shl    edx,0x5
     99c:	01 d0                	add    eax,edx
     99e:	c7 00 ff ff ff ff    	mov    DWORD PTR [eax],0xffffffff
				return -1;
     9a4:	b8 ff ff ff ff       	mov    eax,0xffffffff
     9a9:	e9 8c 01 00 00       	jmp    b3a <cpu_calc_percentages+0x1e9>
		cpu_pcs[0].vals[0] += pc->ns_idle_per_sec;
     9ae:	a1 00 00 00 00       	mov    eax,ds:0x0
     9b3:	8b 08                	mov    ecx,DWORD PTR [eax]
     9b5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     9b8:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
     9bb:	a1 00 00 00 00       	mov    eax,ds:0x0
     9c0:	01 ca                	add    edx,ecx
     9c2:	89 10                	mov    DWORD PTR [eax],edx
		cpu_pcs[0].vals[1] += pc->ns_kernel_per_sec;
     9c4:	a1 00 00 00 00       	mov    eax,ds:0x0
     9c9:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
     9cc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     9cf:	8b 50 3c             	mov    edx,DWORD PTR [eax+0x3c]
     9d2:	a1 00 00 00 00       	mov    eax,ds:0x0
     9d7:	01 ca                	add    edx,ecx
     9d9:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		cpu_pcs[0].vals[2] += pc->ns_user_per_sec;
     9dc:	a1 00 00 00 00       	mov    eax,ds:0x0
     9e1:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
     9e4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     9e7:	8b 50 40             	mov    edx,DWORD PTR [eax+0x40]
     9ea:	a1 00 00 00 00       	mov    eax,ds:0x0
     9ef:	01 ca                	add    edx,ecx
     9f1:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		cpu_pcs[0].vals[3] += 1000000000 - pc->ns_idle_per_sec
     9f4:	a1 00 00 00 00       	mov    eax,ds:0x0
     9f9:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     9fc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     9ff:	8b 48 38             	mov    ecx,DWORD PTR [eax+0x38]
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     a02:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a05:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
     a08:	01 c1                	add    ecx,eax
     a0a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a0d:	8b 40 40             	mov    eax,DWORD PTR [eax+0x40]
     a10:	01 c8                	add    eax,ecx
		cpu_pcs[0].vals[3] += 1000000000 - pc->ns_idle_per_sec
     a12:	29 c2                	sub    edx,eax
     a14:	a1 00 00 00 00       	mov    eax,ds:0x0
     a19:	81 c2 00 ca 9a 3b    	add    edx,0x3b9aca00
     a1f:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		cpu_pcs[i + 1].vals[0] = pc->ns_idle_per_sec;
     a22:	a1 00 00 00 00       	mov    eax,ds:0x0
     a27:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     a2a:	83 c2 01             	add    edx,0x1
     a2d:	c1 e2 05             	shl    edx,0x5
     a30:	01 c2                	add    edx,eax
     a32:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a35:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
     a38:	89 02                	mov    DWORD PTR [edx],eax
		cpu_pcs[i + 1].vals[1] = pc->ns_kernel_per_sec;
     a3a:	a1 00 00 00 00       	mov    eax,ds:0x0
     a3f:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     a42:	83 c2 01             	add    edx,0x1
     a45:	c1 e2 05             	shl    edx,0x5
     a48:	01 c2                	add    edx,eax
     a4a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a4d:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
     a50:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
		cpu_pcs[i + 1].vals[2] = pc->ns_user_per_sec;
     a53:	a1 00 00 00 00       	mov    eax,ds:0x0
     a58:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     a5b:	83 c2 01             	add    edx,0x1
     a5e:	c1 e2 05             	shl    edx,0x5
     a61:	01 c2                	add    edx,eax
     a63:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a66:	8b 40 40             	mov    eax,DWORD PTR [eax+0x40]
     a69:	89 42 08             	mov    DWORD PTR [edx+0x8],eax
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     a6c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a6f:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     a72:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a75:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
     a78:	01 c2                	add    edx,eax
     a7a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a7d:	8b 40 40             	mov    eax,DWORD PTR [eax+0x40]
     a80:	8d 0c 02             	lea    ecx,[edx+eax*1]
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     a83:	a1 00 00 00 00       	mov    eax,ds:0x0
     a88:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     a8b:	83 c2 01             	add    edx,0x1
     a8e:	c1 e2 05             	shl    edx,0x5
     a91:	01 d0                	add    eax,edx
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     a93:	ba 00 ca 9a 3b       	mov    edx,0x3b9aca00
     a98:	29 ca                	sub    edx,ecx
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     a9a:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		for (size_t j = 0; j < 4; j++) {
     a9d:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     aa4:	e9 82 00 00 00       	jmp    b2b <cpu_calc_percentages+0x1da>
				const uint32_t ntot = 10000000;
     aa9:	c7 45 ec 80 96 98 00 	mov    DWORD PTR [ebp-0x14],0x989680
				uint32_t val = cpu_pcs[i + 1].vals[j];
     ab0:	a1 00 00 00 00       	mov    eax,ds:0x0
     ab5:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     ab8:	83 c2 01             	add    edx,0x1
     abb:	c1 e2 05             	shl    edx,0x5
     abe:	01 c2                	add    edx,eax
     ac0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ac3:	8b 04 82             	mov    eax,DWORD PTR [edx+eax*4]
     ac6:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				cpu_pcs[i + 1].vals[j] = val / ntot;
     ac9:	a1 00 00 00 00       	mov    eax,ds:0x0
     ace:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     ad1:	83 c2 01             	add    edx,0x1
     ad4:	c1 e2 05             	shl    edx,0x5
     ad7:	8d 0c 10             	lea    ecx,[eax+edx*1]
     ada:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     add:	ba 00 00 00 00       	mov    edx,0x0
     ae2:	f7 75 ec             	div    DWORD PTR [ebp-0x14]
     ae5:	89 c2                	mov    edx,eax
     ae7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     aea:	89 14 81             	mov    DWORD PTR [ecx+eax*4],edx
				cpu_pcs[i + 1].vals[4 + j] = 10 * (val % ntot) / ntot;
     aed:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     af0:	ba 00 00 00 00       	mov    edx,0x0
     af5:	f7 75 ec             	div    DWORD PTR [ebp-0x14]
     af8:	89 d0                	mov    eax,edx
     afa:	c1 e0 02             	shl    eax,0x2
     afd:	01 d0                	add    eax,edx
     aff:	01 c0                	add    eax,eax
     b01:	89 c6                	mov    esi,eax
     b03:	a1 00 00 00 00       	mov    eax,ds:0x0
     b08:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     b0b:	83 c2 01             	add    edx,0x1
     b0e:	c1 e2 05             	shl    edx,0x5
     b11:	8d 0c 10             	lea    ecx,[eax+edx*1]
     b14:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b17:	8d 58 04             	lea    ebx,[eax+0x4]
     b1a:	89 f0                	mov    eax,esi
     b1c:	ba 00 00 00 00       	mov    edx,0x0
     b21:	f7 75 ec             	div    DWORD PTR [ebp-0x14]
     b24:	89 04 99             	mov    DWORD PTR [ecx+ebx*4],eax
		for (size_t j = 0; j < 4; j++) {
     b27:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     b2b:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
     b2f:	0f 86 74 ff ff ff    	jbe    aa9 <cpu_calc_percentages+0x158>
		return 0;
     b35:	b8 00 00 00 00       	mov    eax,0x0
}
     b3a:	8d 65 f8             	lea    esp,[ebp-0x8]
     b3d:	5b                   	pop    ebx
     b3e:	5e                   	pop    esi
     b3f:	5d                   	pop    ebp
     b40:	c3                   	ret

00000b41 <cpu_do_stats>:
{
     b41:	55                   	push   ebp
     b42:	89 e5                	mov    ebp,esp
     b44:	53                   	push   ebx
     b45:	83 ec 24             	sub    esp,0x24
		if (!cpu_pcs || (nproc != nproc_alloc)) {
     b48:	a1 00 00 00 00       	mov    eax,ds:0x0
     b4d:	85 c0                	test   eax,eax
     b4f:	74 0f                	je     b60 <cpu_do_stats+0x1f>
     b51:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     b57:	a1 00 00 00 00       	mov    eax,ds:0x0
     b5c:	39 c2                	cmp    edx,eax
     b5e:	74 36                	je     b96 <cpu_do_stats+0x55>
				if (cpu_pcs)
     b60:	a1 00 00 00 00       	mov    eax,ds:0x0
     b65:	85 c0                	test   eax,eax
     b67:	74 11                	je     b7a <cpu_do_stats+0x39>
						kfree(cpu_pcs);
     b69:	a1 00 00 00 00       	mov    eax,ds:0x0
     b6e:	83 ec 0c             	sub    esp,0xc
     b71:	50                   	push   eax
     b72:	e8 fc ff ff ff       	call   b73 <cpu_do_stats+0x32>
     b77:	83 c4 10             	add    esp,0x10
				cpu_pcs = kmalloc((nproc + 1) * sizeof(*cpu_pcs));
     b7a:	a1 00 00 00 00       	mov    eax,ds:0x0
     b7f:	83 c0 01             	add    eax,0x1
     b82:	c1 e0 05             	shl    eax,0x5
     b85:	83 ec 0c             	sub    esp,0xc
     b88:	50                   	push   eax
     b89:	e8 fc ff ff ff       	call   b8a <cpu_do_stats+0x49>
     b8e:	83 c4 10             	add    esp,0x10
     b91:	a3 00 00 00 00       	mov    ds:0x0,eax
		bzero(&cpu_pcs[0], sizeof(cpu_pcs[0]));
     b96:	a1 00 00 00 00       	mov    eax,ds:0x0
     b9b:	83 ec 08             	sub    esp,0x8
     b9e:	6a 20                	push   0x20
     ba0:	50                   	push   eax
     ba1:	e8 fc ff ff ff       	call   ba2 <cpu_do_stats+0x61>
     ba6:	83 c4 10             	add    esp,0x10
		size_t nval = 0; uint32_t ntot;
     ba9:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		for (size_t i = 0; i < nproc; i++) {
     bb0:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     bb7:	eb 1e                	jmp    bd7 <cpu_do_stats+0x96>
				if (-1 == cpu_calc_percentages(i))
     bb9:	83 ec 0c             	sub    esp,0xc
     bbc:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     bbf:	e8 fc ff ff ff       	call   bc0 <cpu_do_stats+0x7f>
     bc4:	83 c4 10             	add    esp,0x10
     bc7:	83 f8 ff             	cmp    eax,0xffffffff
     bca:	74 06                	je     bd2 <cpu_do_stats+0x91>
				nval++;
     bcc:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     bd0:	eb 01                	jmp    bd3 <cpu_do_stats+0x92>
						continue;
     bd2:	90                   	nop
		for (size_t i = 0; i < nproc; i++) {
     bd3:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     bd7:	a1 00 00 00 00       	mov    eax,ds:0x0
     bdc:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     bdf:	72 d8                	jb     bb9 <cpu_do_stats+0x78>
		nproc_rep = nval;
     be1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     be4:	a3 00 00 00 00       	mov    ds:0x0,eax
		ntot = 10000000 * nval; /* div 100 */
     be9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     bec:	69 c0 80 96 98 00    	imul   eax,eax,0x989680
     bf2:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		for (size_t i = 0; i < 4; i++) {
     bf5:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     bfc:	eb 5a                	jmp    c58 <cpu_do_stats+0x117>
				uint32_t val = cpu_pcs[0].vals[i];
     bfe:	a1 00 00 00 00       	mov    eax,ds:0x0
     c03:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     c06:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
     c09:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				cpu_pcs[0].vals[i] = val / ntot;
     c0c:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     c12:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     c15:	ba 00 00 00 00       	mov    edx,0x0
     c1a:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
     c1d:	89 c2                	mov    edx,eax
     c1f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     c22:	89 14 81             	mov    DWORD PTR [ecx+eax*4],edx
				cpu_pcs[0].vals[4 + i] = 10 * (val % ntot) / ntot;
     c25:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     c28:	ba 00 00 00 00       	mov    edx,0x0
     c2d:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
     c30:	89 d0                	mov    eax,edx
     c32:	c1 e0 02             	shl    eax,0x2
     c35:	01 d0                	add    eax,edx
     c37:	01 c0                	add    eax,eax
     c39:	89 c2                	mov    edx,eax
     c3b:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     c41:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     c44:	8d 58 04             	lea    ebx,[eax+0x4]
     c47:	89 d0                	mov    eax,edx
     c49:	ba 00 00 00 00       	mov    edx,0x0
     c4e:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
     c51:	89 04 99             	mov    DWORD PTR [ecx+ebx*4],eax
		for (size_t i = 0; i < 4; i++) {
     c54:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     c58:	83 7d ec 03          	cmp    DWORD PTR [ebp-0x14],0x3
     c5c:	76 a0                	jbe    bfe <cpu_do_stats+0xbd>
}
     c5e:	90                   	nop
     c5f:	90                   	nop
     c60:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     c63:	c9                   	leave
     c64:	c3                   	ret

00000c65 <print_cpus>:
{
     c65:	55                   	push   ebp
     c66:	89 e5                	mov    ebp,esp
     c68:	57                   	push   edi
     c69:	56                   	push   esi
     c6a:	53                   	push   ebx
     c6b:	83 ec 3c             	sub    esp,0x3c
		printf("listing cpus: %u total, %u provided data\n", nproc, nproc_rep);
     c6e:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     c74:	a1 00 00 00 00       	mov    eax,ds:0x0
     c79:	83 ec 04             	sub    esp,0x4
     c7c:	52                   	push   edx
     c7d:	50                   	push   eax
     c7e:	68 34 01 00 00       	push   0x134
     c83:	e8 fc ff ff ff       	call   c84 <print_cpus+0x1f>
     c88:	83 c4 10             	add    esp,0x10
				cpu_pcs[0].vals[0], cpu_pcs[0].vals[4]); /* i pi */
     c8b:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     c90:	8b 48 10             	mov    ecx,DWORD PTR [eax+0x10]
				cpu_pcs[0].vals[0], cpu_pcs[0].vals[4]); /* i pi */
     c93:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     c98:	8b 00                	mov    eax,DWORD PTR [eax]
     c9a:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				cpu_pcs[0].vals[3], cpu_pcs[0].vals[7], /* ni pni */
     c9d:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ca2:	8b 58 1c             	mov    ebx,DWORD PTR [eax+0x1c]
     ca5:	89 5d d0             	mov    DWORD PTR [ebp-0x30],ebx
				cpu_pcs[0].vals[3], cpu_pcs[0].vals[7], /* ni pni */
     ca8:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     cad:	8b 78 0c             	mov    edi,DWORD PTR [eax+0xc]
				cpu_pcs[0].vals[1], cpu_pcs[0].vals[5], /* k pk */
     cb0:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     cb5:	8b 70 14             	mov    esi,DWORD PTR [eax+0x14]
				cpu_pcs[0].vals[1], cpu_pcs[0].vals[5], /* k pk */
     cb8:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     cbd:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
				cpu_pcs[0].vals[2], cpu_pcs[0].vals[6], /* u pu */
     cc0:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     cc5:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
				cpu_pcs[0].vals[2], cpu_pcs[0].vals[6], /* u pu */
     cc8:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ccd:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     cd0:	83 ec 0c             	sub    esp,0xc
     cd3:	51                   	push   ecx
     cd4:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     cd7:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
     cda:	57                   	push   edi
     cdb:	56                   	push   esi
     cdc:	53                   	push   ebx
     cdd:	52                   	push   edx
     cde:	50                   	push   eax
     cdf:	68 60 01 00 00       	push   0x160
     ce4:	e8 fc ff ff ff       	call   ce5 <print_cpus+0x80>
     ce9:	83 c4 30             	add    esp,0x30
		for (size_t i = 0; i < nproc; i++) {
     cec:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
     cf3:	e9 1f 01 00 00       	jmp    e17 <print_cpus+0x1b2>
				if (cpu_pcs[i + 1].vals[0] == 0xffffffff) {
     cf8:	a1 00 00 00 00       	mov    eax,ds:0x0
     cfd:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     d00:	83 c2 01             	add    edx,0x1
     d03:	c1 e2 05             	shl    edx,0x5
     d06:	01 d0                	add    eax,edx
     d08:	8b 00                	mov    eax,DWORD PTR [eax]
     d0a:	83 f8 ff             	cmp    eax,0xffffffff
     d0d:	75 15                	jne    d24 <print_cpus+0xbf>
						printf("%%Cpu%-3u: N/A\n");
     d0f:	83 ec 0c             	sub    esp,0xc
     d12:	68 9a 01 00 00       	push   0x19a
     d17:	e8 fc ff ff ff       	call   d18 <print_cpus+0xb3>
     d1c:	83 c4 10             	add    esp,0x10
						continue;
     d1f:	e9 ef 00 00 00       	jmp    e13 <print_cpus+0x1ae>
				struct perf_ctrs* pc = get_cpu_data(i)->ticks;
     d24:	83 ec 0c             	sub    esp,0xc
     d27:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     d2a:	e8 fc ff ff ff       	call   d2b <print_cpus+0xc6>
     d2f:	83 c4 10             	add    esp,0x10
     d32:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     d35:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     d38:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     d3b:	8b 40 44             	mov    eax,DWORD PTR [eax+0x44]
     d3e:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     d41:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     d44:	8b 48 48             	mov    ecx,DWORD PTR [eax+0x48]
     d47:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
						cpu_pcs[i + 1].vals[0], cpu_pcs[i + 1].vals[4], /* i pi */
     d4a:	a1 00 00 00 00       	mov    eax,ds:0x0
     d4f:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     d52:	83 c2 01             	add    edx,0x1
     d55:	c1 e2 05             	shl    edx,0x5
     d58:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     d5a:	8b 70 10             	mov    esi,DWORD PTR [eax+0x10]
     d5d:	89 75 cc             	mov    DWORD PTR [ebp-0x34],esi
						cpu_pcs[i + 1].vals[0], cpu_pcs[i + 1].vals[4], /* i pi */
     d60:	a1 00 00 00 00       	mov    eax,ds:0x0
     d65:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     d68:	83 c2 01             	add    edx,0x1
     d6b:	c1 e2 05             	shl    edx,0x5
     d6e:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     d70:	8b 38                	mov    edi,DWORD PTR [eax]
     d72:	89 7d c8             	mov    DWORD PTR [ebp-0x38],edi
						cpu_pcs[i + 1].vals[3], cpu_pcs[i + 1].vals[7], /* ni pni */
     d75:	a1 00 00 00 00       	mov    eax,ds:0x0
     d7a:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     d7d:	83 c2 01             	add    edx,0x1
     d80:	c1 e2 05             	shl    edx,0x5
     d83:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     d85:	8b 58 1c             	mov    ebx,DWORD PTR [eax+0x1c]
     d88:	89 5d c4             	mov    DWORD PTR [ebp-0x3c],ebx
						cpu_pcs[i + 1].vals[3], cpu_pcs[i + 1].vals[7], /* ni pni */
     d8b:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     d91:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d94:	83 c0 01             	add    eax,0x1
     d97:	c1 e0 05             	shl    eax,0x5
     d9a:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     d9c:	8b 78 0c             	mov    edi,DWORD PTR [eax+0xc]
						cpu_pcs[i + 1].vals[1], cpu_pcs[i + 1].vals[5], /* k pk */
     d9f:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     da5:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     da8:	83 c0 01             	add    eax,0x1
     dab:	c1 e0 05             	shl    eax,0x5
     dae:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     db0:	8b 70 14             	mov    esi,DWORD PTR [eax+0x14]
						cpu_pcs[i + 1].vals[1], cpu_pcs[i + 1].vals[5], /* k pk */
     db3:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     db9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     dbc:	83 c0 01             	add    eax,0x1
     dbf:	c1 e0 05             	shl    eax,0x5
     dc2:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     dc4:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
						cpu_pcs[i + 1].vals[2], cpu_pcs[i + 1].vals[6], /* u pu */
     dc7:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     dcd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     dd0:	83 c0 01             	add    eax,0x1
     dd3:	c1 e0 05             	shl    eax,0x5
     dd6:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     dd8:	8b 48 18             	mov    ecx,DWORD PTR [eax+0x18]
						cpu_pcs[i + 1].vals[2], cpu_pcs[i + 1].vals[6], /* u pu */
     ddb:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     de1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     de4:	83 c0 01             	add    eax,0x1
     de7:	c1 e0 05             	shl    eax,0x5
     dea:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     dec:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     def:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     df2:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
     df5:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
     df8:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
     dfb:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
     dfe:	57                   	push   edi
     dff:	56                   	push   esi
     e00:	53                   	push   ebx
     e01:	51                   	push   ecx
     e02:	50                   	push   eax
     e03:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     e06:	68 ac 01 00 00       	push   0x1ac
     e0b:	e8 fc ff ff ff       	call   e0c <print_cpus+0x1a7>
     e10:	83 c4 30             	add    esp,0x30
		for (size_t i = 0; i < nproc; i++) {
     e13:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
     e17:	a1 00 00 00 00       	mov    eax,ds:0x0
     e1c:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
     e1f:	0f 82 d3 fe ff ff    	jb     cf8 <print_cpus+0x93>
}
     e25:	90                   	nop
     e26:	90                   	nop
     e27:	8d 65 f4             	lea    esp,[ebp-0xc]
     e2a:	5b                   	pop    ebx
     e2b:	5e                   	pop    esi
     e2c:	5f                   	pop    edi
     e2d:	5d                   	pop    ebp
     e2e:	c3                   	ret

00000e2f <print_tasks>:
{
     e2f:	55                   	push   ebp
     e30:	89 e5                	mov    ebp,esp
     e32:	53                   	push   ebx
     e33:	83 ec 14             	sub    esp,0x14
		const char* md = "";
     e36:	c7 45 f4 fd 01 00 00 	mov    DWORD PTR [ebp-0xc],0x1fd
		if (cpu.invariant_tsc)
     e3d:	a1 6c 00 00 00       	mov    eax,ds:0x6c
     e42:	85 c0                	test   eax,eax
     e44:	74 09                	je     e4f <print_tasks+0x20>
				md = "inv_tsc";
     e46:	c7 45 f4 fe 01 00 00 	mov    DWORD PTR [ebp-0xc],0x1fe
     e4d:	eb 1e                	jmp    e6d <print_tasks+0x3e>
		else if (cpu.has_apic)
     e4f:	0f b6 05 59 00 00 00 	movzx  eax,BYTE PTR ds:0x59
     e56:	83 e0 02             	and    eax,0x2
     e59:	84 c0                	test   al,al
     e5b:	74 09                	je     e66 <print_tasks+0x37>
				md = "apic timer";
     e5d:	c7 45 f4 06 02 00 00 	mov    DWORD PTR [ebp-0xc],0x206
     e64:	eb 07                	jmp    e6d <print_tasks+0x3e>
				md = "PIT ticks";
     e66:	c7 45 f4 11 02 00 00 	mov    DWORD PTR [ebp-0xc],0x211
		printf("Tasks:%4u total,%4u running,%4u pending,%4u sleeping\n",
     e6d:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
     e73:	8b 0d 08 00 00 00    	mov    ecx,DWORD PTR ds:0x8
     e79:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     e7f:	a1 00 00 00 00       	mov    eax,ds:0x0
     e84:	83 ec 0c             	sub    esp,0xc
     e87:	53                   	push   ebx
     e88:	51                   	push   ecx
     e89:	52                   	push   edx
     e8a:	50                   	push   eax
     e8b:	68 1c 02 00 00       	push   0x21c
     e90:	e8 fc ff ff ff       	call   e91 <print_tasks+0x62>
     e95:	83 c4 20             	add    esp,0x20
		printf("Task time:%6u secs total, %4u ms last sec, mode: %s\n",
     e98:	8b 15 10 00 00 00    	mov    edx,DWORD PTR ds:0x10
     e9e:	a1 0c 00 00 00       	mov    eax,ds:0xc
     ea3:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     ea6:	52                   	push   edx
     ea7:	50                   	push   eax
     ea8:	68 54 02 00 00       	push   0x254
     ead:	e8 fc ff ff ff       	call   eae <print_tasks+0x7f>
     eb2:	83 c4 10             	add    esp,0x10
		print_cpus();
     eb5:	e8 fc ff ff ff       	call   eb6 <print_tasks+0x87>
		printf("listing tasks: %u total" STAT_COUNTER("  major rotations: %u")  "\n", n_tks STAT_ARG(sched_mr_count));
     eba:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     ec0:	a1 00 00 00 00       	mov    eax,ds:0x0
     ec5:	83 ec 04             	sub    esp,0x4
     ec8:	52                   	push   edx
     ec9:	50                   	push   eax
     eca:	68 8c 02 00 00       	push   0x28c
     ecf:	e8 fc ff ff ff       	call   ed0 <print_tasks+0xa1>
     ed4:	83 c4 10             	add    esp,0x10
		printf("ID FLG PROC STACK    PRIORITY  RUNTIME[ms] RUNTIME      QTA NAME        " STAT_COUNTER("SCHED  ") "\n"
     ed7:	83 ec 0c             	sub    esp,0xc
     eda:	68 bc 02 00 00       	push   0x2bc
     edf:	e8 fc ff ff ff       	call   ee0 <print_tasks+0xb1>
     ee4:	83 c4 10             	add    esp,0x10
		for (size_t i = 0; i < n_tks; i++)
     ee7:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     eee:	eb 1a                	jmp    f0a <print_tasks+0xdb>
				print_task(tks[i]);
     ef0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ef3:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     efa:	83 ec 0c             	sub    esp,0xc
     efd:	50                   	push   eax
     efe:	e8 fc ff ff ff       	call   eff <print_tasks+0xd0>
     f03:	83 c4 10             	add    esp,0x10
		for (size_t i = 0; i < n_tks; i++)
     f06:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     f0a:	a1 00 00 00 00       	mov    eax,ds:0x0
     f0f:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     f12:	72 dc                	jb     ef0 <print_tasks+0xc1>
}
     f14:	90                   	nop
     f15:	90                   	nop
     f16:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     f19:	c9                   	leave
     f1a:	c3                   	ret

00000f1b <task_do_stats>:
{
     f1b:	55                   	push   ebp
     f1c:	89 e5                	mov    ebp,esp
     f1e:	53                   	push   ebx
     f1f:	83 ec 14             	sub    esp,0x14
		bzero(&task_stats, sizeof(task_stats));
     f22:	83 ec 08             	sub    esp,0x8
     f25:	6a 14                	push   0x14
     f27:	68 00 00 00 00       	push   0x0
     f2c:	e8 fc ff ff ff       	call   f2d <task_do_stats+0x12>
     f31:	83 c4 10             	add    esp,0x10
		for (size_t i = 0; i < n_tks; i++) {
     f34:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     f3b:	e9 f9 00 00 00       	jmp    1039 <task_do_stats+0x11e>
				struct tsi* t = tks[i];
     f40:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f43:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     f4a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (!t)
     f4d:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     f51:	0f 84 dd 00 00 00    	je     1034 <task_do_stats+0x119>
				t->run_time_sec = t->run_time - t->sec_run_time;
     f57:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f5a:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
     f5d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f60:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
     f63:	29 c2                	sub    edx,eax
     f65:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f68:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
				t->sec_run_time = t->run_time;
     f6b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f6e:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
     f71:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f74:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
				t->ns_per_sec = t->ns_acc - t->sec_ns_acc;
     f77:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f7a:	8b 50 54             	mov    edx,DWORD PTR [eax+0x54]
     f7d:	8b 40 50             	mov    eax,DWORD PTR [eax+0x50]
     f80:	89 c1                	mov    ecx,eax
     f82:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f85:	8b 50 5c             	mov    edx,DWORD PTR [eax+0x5c]
     f88:	8b 40 58             	mov    eax,DWORD PTR [eax+0x58]
     f8b:	29 c1                	sub    ecx,eax
     f8d:	89 ca                	mov    edx,ecx
     f8f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f92:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
				t->sec_ns_acc = t->ns_acc;
     f95:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f98:	8b 50 54             	mov    edx,DWORD PTR [eax+0x54]
     f9b:	8b 40 50             	mov    eax,DWORD PTR [eax+0x50]
     f9e:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     fa1:	89 41 58             	mov    DWORD PTR [ecx+0x58],eax
     fa4:	89 51 5c             	mov    DWORD PTR [ecx+0x5c],edx
				if (t->flags & TIF_RUNNING)
     fa7:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     faa:	8b 00                	mov    eax,DWORD PTR [eax]
     fac:	83 e0 10             	and    eax,0x10
     faf:	85 c0                	test   eax,eax
     fb1:	74 0f                	je     fc2 <task_do_stats+0xa7>
						task_stats.n_running++;
     fb3:	a1 00 00 00 00       	mov    eax,ds:0x0
     fb8:	83 c0 01             	add    eax,0x1
     fbb:	a3 00 00 00 00       	mov    ds:0x0,eax
     fc0:	eb 2a                	jmp    fec <task_do_stats+0xd1>
				else if (t->flags & TIF_SLEEPING)
     fc2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     fc5:	8b 00                	mov    eax,DWORD PTR [eax]
     fc7:	25 80 00 00 00       	and    eax,0x80
     fcc:	85 c0                	test   eax,eax
     fce:	74 0f                	je     fdf <task_do_stats+0xc4>
						task_stats.n_sleeping++;
     fd0:	a1 04 00 00 00       	mov    eax,ds:0x4
     fd5:	83 c0 01             	add    eax,0x1
     fd8:	a3 04 00 00 00       	mov    ds:0x4,eax
     fdd:	eb 0d                	jmp    fec <task_do_stats+0xd1>
						task_stats.n_pending++;
     fdf:	a1 08 00 00 00       	mov    eax,ds:0x8
     fe4:	83 c0 01             	add    eax,0x1
     fe7:	a3 08 00 00 00       	mov    ds:0x8,eax
				task_stats.tot_runtime += (uint32_t)(t->ns_acc / 1000000000llu);
     fec:	8b 1d 0c 00 00 00    	mov    ebx,DWORD PTR ds:0xc
     ff2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     ff5:	8b 50 54             	mov    edx,DWORD PTR [eax+0x54]
     ff8:	8b 40 50             	mov    eax,DWORD PTR [eax+0x50]
     ffb:	6a 00                	push   0x0
     ffd:	68 00 ca 9a 3b       	push   0x3b9aca00
    1002:	52                   	push   edx
    1003:	50                   	push   eax
    1004:	e8 fc ff ff ff       	call   1005 <task_do_stats+0xea>
    1009:	83 c4 10             	add    esp,0x10
    100c:	01 d8                	add    eax,ebx
    100e:	a3 0c 00 00 00       	mov    ds:0xc,eax
				task_stats.sec_runtime += t->ns_per_sec / 1000000;
    1013:	8b 0d 10 00 00 00    	mov    ecx,DWORD PTR ds:0x10
    1019:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    101c:	8b 40 60             	mov    eax,DWORD PTR [eax+0x60]
    101f:	ba 83 de 1b 43       	mov    edx,0x431bde83
    1024:	f7 e2                	mul    edx
    1026:	89 d0                	mov    eax,edx
    1028:	c1 e8 12             	shr    eax,0x12
    102b:	01 c8                	add    eax,ecx
    102d:	a3 10 00 00 00       	mov    ds:0x10,eax
    1032:	eb 01                	jmp    1035 <task_do_stats+0x11a>
						continue;
    1034:	90                   	nop
		for (size_t i = 0; i < n_tks; i++) {
    1035:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1039:	a1 00 00 00 00       	mov    eax,ds:0x0
    103e:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    1041:	0f 82 f9 fe ff ff    	jb     f40 <task_do_stats+0x25>
		for (size_t i = 0; i < nproc; i++) {
    1047:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    104e:	e9 d2 00 00 00       	jmp    1125 <task_do_stats+0x20a>
				struct perf_ctrs* pc = cpu_stat_counter(i);
    1053:	83 ec 0c             	sub    esp,0xc
    1056:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1059:	e8 fc ff ff ff       	call   105a <task_do_stats+0x13f>
    105e:	83 c4 10             	add    esp,0x10
    1061:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!pc)
    1064:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1068:	0f 84 b2 00 00 00    	je     1120 <task_do_stats+0x205>
				pc->ns_idle_per_sec = pc->ns_idle - pc->sec_ns_idle;
    106e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1071:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1074:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1077:	89 c1                	mov    ecx,eax
    1079:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    107c:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    107f:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1082:	29 c1                	sub    ecx,eax
    1084:	89 ca                	mov    edx,ecx
    1086:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1089:	89 50 38             	mov    DWORD PTR [eax+0x38],edx
				pc->sec_ns_idle = pc->ns_idle;
    108c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    108f:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1092:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1095:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1098:	89 41 20             	mov    DWORD PTR [ecx+0x20],eax
    109b:	89 51 24             	mov    DWORD PTR [ecx+0x24],edx
				pc->ns_user_per_sec = pc->ns_user - pc->sec_ns_user;
    109e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10a1:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    10a4:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    10a7:	89 c1                	mov    ecx,eax
    10a9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10ac:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    10af:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    10b2:	89 ca                	mov    edx,ecx
    10b4:	29 c2                	sub    edx,eax
    10b6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10b9:	89 50 40             	mov    DWORD PTR [eax+0x40],edx
				pc->sec_ns_user = pc->ns_user;
    10bc:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10bf:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    10c2:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    10c5:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    10c8:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
    10cb:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
				pc->ns_kernel_per_sec = pc->ns_kernel - pc->sec_ns_kernel;
    10ce:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10d1:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    10d4:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    10d7:	89 c1                	mov    ecx,eax
    10d9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10dc:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    10df:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    10e2:	29 c1                	sub    ecx,eax
    10e4:	89 ca                	mov    edx,ecx
    10e6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10e9:	89 50 3c             	mov    DWORD PTR [eax+0x3c],edx
				pc->sec_ns_kernel = pc->ns_kernel;
    10ec:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10ef:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    10f2:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    10f5:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    10f8:	89 41 28             	mov    DWORD PTR [ecx+0x28],eax
    10fb:	89 51 2c             	mov    DWORD PTR [ecx+0x2c],edx
				pc->n_times_per_sec = pc->n_times - pc->sec_n_times;
    10fe:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1101:	8b 50 44             	mov    edx,DWORD PTR [eax+0x44]
    1104:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1107:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
    110a:	29 c2                	sub    edx,eax
    110c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    110f:	89 50 48             	mov    DWORD PTR [eax+0x48],edx
				pc->sec_n_times = pc->n_times;
    1112:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1115:	8b 50 44             	mov    edx,DWORD PTR [eax+0x44]
    1118:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    111b:	89 50 4c             	mov    DWORD PTR [eax+0x4c],edx
    111e:	eb 01                	jmp    1121 <task_do_stats+0x206>
						continue;
    1120:	90                   	nop
		for (size_t i = 0; i < nproc; i++) {
    1121:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1125:	a1 00 00 00 00       	mov    eax,ds:0x0
    112a:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    112d:	0f 82 20 ff ff ff    	jb     1053 <task_do_stats+0x138>
		cpu_do_stats();
    1133:	e8 fc ff ff ff       	call   1134 <task_do_stats+0x219>
}
    1138:	90                   	nop
    1139:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    113c:	c9                   	leave
    113d:	c3                   	ret

0000113e <task_initfunc>:
{
    113e:	55                   	push   ebp
    113f:	89 e5                	mov    ebp,esp
    1141:	83 ec 18             	sub    esp,0x18
		asm volatile("mov %%eax, %0" : "=rm" (fun) );
    1144:	89 c0                	mov    eax,eax
    1146:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		asm volatile("mov %%ecx, %0" : "=rm" (arg) );
    1149:	89 c8                	mov    eax,ecx
    114b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		asm ("sti");
    114e:	fb                   	sti
		fun(arg);
    114f:	83 ec 0c             	sub    esp,0xc
    1152:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1155:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1158:	ff d0                	call   eax
    115a:	83 c4 10             	add    esp,0x10
		get_task()->flags |= TIF_DEALLOCATE;
    115d:	e8 fc ff ff ff       	call   115e <task_initfunc+0x20>
    1162:	8b 10                	mov    edx,DWORD PTR [eax]
    1164:	83 ca 04             	or     edx,0x4
    1167:	89 10                	mov    DWORD PTR [eax],edx
		task_yield();
    1169:	e8 fc ff ff ff       	call   116a <task_initfunc+0x2c>
				cprintf(KFMT_WARN, "Deallocated task is rescheduled. This should never happen!\n");
    116e:	83 ec 08             	sub    esp,0x8
    1171:	68 60 03 00 00       	push   0x360
    1176:	6a 0e                	push   0xe
    1178:	e8 fc ff ff ff       	call   1179 <task_initfunc+0x3b>
    117d:	83 c4 10             	add    esp,0x10
				task_yield();
    1180:	e8 fc ff ff ff       	call   1181 <task_initfunc+0x43>
				cprintf(KFMT_WARN, "Deallocated task is rescheduled. This should never happen!\n");
    1185:	90                   	nop
    1186:	eb e6                	jmp    116e <task_initfunc+0x30>

00001188 <task_spawn_named>:
{
    1188:	55                   	push   ebp
    1189:	89 e5                	mov    ebp,esp
    118b:	57                   	push   edi
    118c:	56                   	push   esi
    118d:	53                   	push   ebx
    118e:	81 ec 9c 00 00 00    	sub    esp,0x9c
		if (n_tks < 128) {
    1194:	a1 00 00 00 00       	mov    eax,ds:0x0
    1199:	83 f8 7f             	cmp    eax,0x7f
    119c:	0f 87 f4 01 00 00    	ja     1396 <task_spawn_named+0x20e>
				struct tsi ts = {0}; int flg;
    11a2:	8d 95 60 ff ff ff    	lea    edx,[ebp-0xa0]
    11a8:	b8 00 00 00 00       	mov    eax,0x0
    11ad:	b9 1b 00 00 00       	mov    ecx,0x1b
    11b2:	89 d7                	mov    edi,edx
    11b4:	f3 ab                	rep stos DWORD PTR es:[edi],eax
				void* stk = alloc_stack();
    11b6:	e8 fc ff ff ff       	call   11b7 <task_spawn_named+0x2f>
    11bb:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (!stk) {
    11be:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    11c2:	75 2b                	jne    11ef <task_spawn_named+0x67>
						die("Failed to alloc stack!\n");
    11c4:	83 ec 08             	sub    esp,0x8
    11c7:	68 9c 03 00 00       	push   0x39c
    11cc:	6a 0c                	push   0xc
    11ce:	e8 fc ff ff ff       	call   11cf <task_spawn_named+0x47>
    11d3:	83 c4 10             	add    esp,0x10
    11d6:	e8 fc ff ff ff       	call   11d7 <task_spawn_named+0x4f>
    11db:	83 ec 0c             	sub    esp,0xc
    11de:	68 00 00 00 00       	push   0x0
    11e3:	e8 fc ff ff ff       	call   11e4 <task_spawn_named+0x5c>
    11e8:	83 c4 10             	add    esp,0x10
    11eb:	fa                   	cli
    11ec:	f4                   	hlt
    11ed:	eb fd                	jmp    11ec <task_spawn_named+0x64>
				if ((flg = if_enabled()))
    11ef:	e8 20 ee ff ff       	call   14 <if_enabled>
    11f4:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    11f7:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    11fb:	74 0e                	je     120b <task_spawn_named+0x83>
						preempt_disable();
    11fd:	e8 fc ff ff ff       	call   11fe <task_spawn_named+0x76>
    1202:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    1205:	83 c2 01             	add    edx,0x1
    1208:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				spin_lock(&pq_lock);
    120b:	83 ec 0c             	sub    esp,0xc
    120e:	68 00 00 00 00       	push   0x0
    1213:	e8 fc ff ff ff       	call   1214 <task_spawn_named+0x8c>
    1218:	83 c4 10             	add    esp,0x10
				struct tsi* pts = stk;
    121b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    121e:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				pts--;
    1221:	83 6d dc 6c          	sub    DWORD PTR [ebp-0x24],0x6c
				struct task_state* ti = (void*)pts;
    1225:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1228:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ti--; /* store info at stack bottom */
    122b:	83 6d d8 44          	sub    DWORD PTR [ebp-0x28],0x44
				id = get_stack(stk, &sl);
    122f:	83 ec 08             	sub    esp,0x8
    1232:	8d 45 cc             	lea    eax,[ebp-0x34]
    1235:	50                   	push   eax
    1236:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1239:	e8 fc ff ff ff       	call   123a <task_spawn_named+0xb2>
    123e:	83 c4 10             	add    esp,0x10
    1241:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				ts.flags = TIF_KERNEL_STACK;
    1244:	c7 85 60 ff ff ff 08 00 00 00 	mov    DWORD PTR [ebp-0xa0],0x8
				ts.task_id = id;
    124e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1251:	89 85 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],eax
				ts.stack_base = sl.base;
    1257:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    125a:	89 85 68 ff ff ff    	mov    DWORD PTR [ebp-0x98],eax
				ts.stack_limit = sl.limit;
    1260:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1263:	89 85 6c ff ff ff    	mov    DWORD PTR [ebp-0x94],eax
				ts.priority = ts.cur_priority = priority;
    1269:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    126c:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
    126f:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    1272:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
				ts.name = name;
    1275:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1278:	89 85 70 ff ff ff    	mov    DWORD PTR [ebp-0x90],eax
				ts.quota = 10; ts.run_time = 0;
    127e:	c7 45 8c 0a 00 00 00 	mov    DWORD PTR [ebp-0x74],0xa
    1285:	c7 45 84 00 00 00 00 	mov    DWORD PTR [ebp-0x7c],0x0
				ts.ts = ti;
    128c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    128f:	89 85 64 ff ff ff    	mov    DWORD PTR [ebp-0x9c],eax
				ts.task_proc = 0xffffffff;
    1295:	c7 45 a4 ff ff ff ff 	mov    DWORD PTR [ebp-0x5c],0xffffffff
				bzero(ti, sizeof(*ti));
    129c:	83 ec 08             	sub    esp,0x8
    129f:	6a 44                	push   0x44
    12a1:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    12a4:	e8 fc ff ff ff       	call   12a5 <task_spawn_named+0x11d>
    12a9:	83 c4 10             	add    esp,0x10
				ti->cs = SEG_CODE;
    12ac:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12af:	c7 40 34 08 00 00 00 	mov    DWORD PTR [eax+0x34],0x8
				ti->ds = ti->es = SEG_DATA;
    12b6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12b9:	c7 40 08 10 00 00 00 	mov    DWORD PTR [eax+0x8],0x10
    12c0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12c3:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    12c6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12c9:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
				ti->gs = SEG_DATA;
    12cc:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12cf:	c7 00 10 00 00 00    	mov    DWORD PTR [eax],0x10
				ti->fs = SEG_DATA_PROC; // x86, x86_64 other way
    12d5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12d8:	c7 40 04 40 00 00 00 	mov    DWORD PTR [eax+0x4],0x40
				ti->esp = (uint32_t)ti;
    12df:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    12e2:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12e5:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
				ti->ebp = ti->esp;
    12e8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12eb:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    12ee:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12f1:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				ti->eflags = (1 << 9)/* | (1 << 8)*/; /* IF TF (interrupt enable, single-step) */
    12f4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12f7:	c7 40 38 00 02 00 00 	mov    DWORD PTR [eax+0x38],0x200
				ti->eax = (uint32_t)fn;
    12fe:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1301:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1304:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
				ti->ecx = (uint32_t)dat;
    1307:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    130a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    130d:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
				ti->eip = (uint32_t)task_initfunc;
    1310:	ba 00 00 00 00       	mov    edx,0x0
    1315:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1318:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
				*pts = ts;
    131b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    131e:	89 c3                	mov    ebx,eax
    1320:	8d 85 60 ff ff ff    	lea    eax,[ebp-0xa0]
    1326:	ba 1b 00 00 00       	mov    edx,0x1b
    132b:	89 df                	mov    edi,ebx
    132d:	89 c6                	mov    esi,eax
    132f:	89 d1                	mov    ecx,edx
    1331:	f3 a5                	rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]
				tks[n_tks++] = pts;
    1333:	a1 00 00 00 00       	mov    eax,ds:0x0
    1338:	8d 50 01             	lea    edx,[eax+0x1]
    133b:	89 15 00 00 00 00    	mov    DWORD PTR ds:0x0,edx
    1341:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1344:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
				pq_enqueue(run_queue, pts);
    134b:	a1 00 00 00 00       	mov    eax,ds:0x0
    1350:	83 ec 08             	sub    esp,0x8
    1353:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1356:	50                   	push   eax
    1357:	e8 fc ff ff ff       	call   1358 <task_spawn_named+0x1d0>
    135c:	83 c4 10             	add    esp,0x10
				spin_unlock(&pq_lock);
    135f:	83 ec 0c             	sub    esp,0xc
    1362:	68 00 00 00 00       	push   0x0
    1367:	e8 fc ff ff ff       	call   1368 <task_spawn_named+0x1e0>
    136c:	83 c4 10             	add    esp,0x10
				if (flg)
    136f:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1373:	74 21                	je     1396 <task_spawn_named+0x20e>
						preempt_enable();
    1375:	e8 fc ff ff ff       	call   1376 <task_spawn_named+0x1ee>
    137a:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    137d:	83 ea 01             	sub    edx,0x1
    1380:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
    1383:	e8 fc ff ff ff       	call   1384 <task_spawn_named+0x1fc>
    1388:	8b 00                	mov    eax,DWORD PTR [eax]
    138a:	83 e0 01             	and    eax,0x1
    138d:	85 c0                	test   eax,eax
    138f:	74 05                	je     1396 <task_spawn_named+0x20e>
    1391:	e8 fc ff ff ff       	call   1392 <task_spawn_named+0x20a>
}
    1396:	8d 65 f4             	lea    esp,[ebp-0xc]
    1399:	5b                   	pop    ebx
    139a:	5e                   	pop    esi
    139b:	5f                   	pop    edi
    139c:	5d                   	pop    ebp
    139d:	c3                   	ret

0000139e <task_deallocate>:
{
    139e:	55                   	push   ebp
    139f:	89 e5                	mov    ebp,esp
    13a1:	83 ec 10             	sub    esp,0x10
		for (size_t i = 0; i < n_tks; i++)
    13a4:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
    13ab:	eb 46                	jmp    13f3 <task_deallocate+0x55>
				if (tks[i] == t) {
    13ad:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    13b0:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    13b7:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    13ba:	75 33                	jne    13ef <task_deallocate+0x51>
						tks[i] = NULL;
    13bc:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    13bf:	c7 04 85 00 00 00 00 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],0x0
						tks[i] = tks[--n_tks];
    13ca:	a1 00 00 00 00       	mov    eax,ds:0x0
    13cf:	83 e8 01             	sub    eax,0x1
    13d2:	a3 00 00 00 00       	mov    ds:0x0,eax
    13d7:	a1 00 00 00 00       	mov    eax,ds:0x0
    13dc:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    13e3:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    13e6:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						break;
    13ed:	eb 0e                	jmp    13fd <task_deallocate+0x5f>
		for (size_t i = 0; i < n_tks; i++)
    13ef:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
    13f3:	a1 00 00 00 00       	mov    eax,ds:0x0
    13f8:	39 45 fc             	cmp    DWORD PTR [ebp-0x4],eax
    13fb:	72 b0                	jb     13ad <task_deallocate+0xf>
		free_stack(t->stack_base);
    13fd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1400:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1403:	50                   	push   eax
    1404:	e8 fc ff ff ff       	call   1405 <task_deallocate+0x67>
    1409:	83 c4 04             	add    esp,0x4
}
    140c:	90                   	nop
    140d:	c9                   	leave
    140e:	c3                   	ret

0000140f <task_diag>:
{
    140f:	55                   	push   ebp
    1410:	89 e5                	mov    ebp,esp
    1412:	57                   	push   edi
    1413:	56                   	push   esi
    1414:	53                   	push   ebx
    1415:	83 ec 2c             	sub    esp,0x2c
		size_t end = pr_idx;
    1418:	a1 00 00 00 00       	mov    eax,ds:0x0
    141d:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		asm("cli");
    1420:	fa                   	cli
		if (diag++)
    1421:	a1 04 05 00 00       	mov    eax,ds:0x504
    1426:	8d 50 01             	lea    edx,[eax+0x1]
    1429:	89 15 04 05 00 00    	mov    DWORD PTR ds:0x504,edx
    142f:	85 c0                	test   eax,eax
    1431:	0f 85 27 01 00 00    	jne    155e <task_diag+0x14f>
		framebuffer_redraw(&fb_initial);
    1437:	83 ec 0c             	sub    esp,0xc
    143a:	68 00 00 00 00       	push   0x0
    143f:	e8 fc ff ff ff       	call   1440 <task_diag+0x31>
    1444:	83 c4 10             	add    esp,0x10
		mdelay(1000);
    1447:	83 ec 0c             	sub    esp,0xc
    144a:	68 e8 03 00 00       	push   0x3e8
    144f:	e8 fc ff ff ff       	call   1450 <task_diag+0x41>
    1454:	83 c4 10             	add    esp,0x10
		print_tasks();
    1457:	e8 fc ff ff ff       	call   1458 <task_diag+0x49>
		printf("PROC TASK TASK_NAME        EIP      ESP\n");
    145c:	83 ec 0c             	sub    esp,0xc
    145f:	68 b4 03 00 00       	push   0x3b4
    1464:	e8 fc ff ff ff       	call   1465 <task_diag+0x56>
    1469:	83 c4 10             	add    esp,0x10
		for (size_t i = end - 1; i != end; i--) {
    146c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    146f:	83 e8 01             	sub    eax,0x1
    1472:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1475:	e9 d6 00 00 00       	jmp    1550 <task_diag+0x141>
						pr_lst[i].eip, pr_lst[i].esp);
    147a:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1480:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1483:	89 d0                	mov    eax,edx
    1485:	c1 e0 02             	shl    eax,0x2
    1488:	01 d0                	add    eax,edx
    148a:	c1 e0 02             	shl    eax,0x2
    148d:	01 c8                	add    eax,ecx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    148f:	8b 78 10             	mov    edi,DWORD PTR [eax+0x10]
						pr_lst[i].eip, pr_lst[i].esp);
    1492:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1498:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    149b:	89 d0                	mov    eax,edx
    149d:	c1 e0 02             	shl    eax,0x2
    14a0:	01 d0                	add    eax,edx
    14a2:	c1 e0 02             	shl    eax,0x2
    14a5:	01 c8                	add    eax,ecx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    14a7:	8b 70 0c             	mov    esi,DWORD PTR [eax+0xc]
						pr_lst[i].task_id, pr_lst[i].task_name,
    14aa:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    14b0:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    14b3:	89 d0                	mov    eax,edx
    14b5:	c1 e0 02             	shl    eax,0x2
    14b8:	01 d0                	add    eax,edx
    14ba:	c1 e0 02             	shl    eax,0x2
    14bd:	01 c8                	add    eax,ecx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    14bf:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
						pr_lst[i].task_id, pr_lst[i].task_name,
    14c2:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    14c8:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    14cb:	89 d0                	mov    eax,edx
    14cd:	c1 e0 02             	shl    eax,0x2
    14d0:	01 d0                	add    eax,edx
    14d2:	c1 e0 02             	shl    eax,0x2
    14d5:	01 c8                	add    eax,ecx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    14d7:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    14da:	a1 00 00 00 00       	mov    eax,ds:0x0
    14df:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    14e2:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    14e5:	89 d0                	mov    eax,edx
    14e7:	c1 e0 02             	shl    eax,0x2
    14ea:	01 d0                	add    eax,edx
    14ec:	c1 e0 02             	shl    eax,0x2
    14ef:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    14f2:	01 d0                	add    eax,edx
    14f4:	8b 00                	mov    eax,DWORD PTR [eax]
    14f6:	c1 e8 18             	shr    eax,0x18
    14f9:	83 ec 08             	sub    esp,0x8
    14fc:	57                   	push   edi
    14fd:	56                   	push   esi
    14fe:	53                   	push   ebx
    14ff:	51                   	push   ecx
    1500:	50                   	push   eax
    1501:	68 dd 03 00 00       	push   0x3dd
    1506:	e8 fc ff ff ff       	call   1507 <task_diag+0xf8>
    150b:	83 c4 20             	add    esp,0x20
				if (i % 20)
    150e:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    1511:	ba cd cc cc cc       	mov    edx,0xcccccccd
    1516:	89 c8                	mov    eax,ecx
    1518:	f7 e2                	mul    edx
    151a:	c1 ea 04             	shr    edx,0x4
    151d:	89 d0                	mov    eax,edx
    151f:	c1 e0 02             	shl    eax,0x2
    1522:	01 d0                	add    eax,edx
    1524:	c1 e0 02             	shl    eax,0x2
    1527:	29 c1                	sub    ecx,eax
    1529:	89 ca                	mov    edx,ecx
    152b:	85 d2                	test   edx,edx
    152d:	74 10                	je     153f <task_diag+0x130>
						framebuffer_redraw(&fb_initial);
    152f:	83 ec 0c             	sub    esp,0xc
    1532:	68 00 00 00 00       	push   0x0
    1537:	e8 fc ff ff ff       	call   1538 <task_diag+0x129>
    153c:	83 c4 10             	add    esp,0x10
				if (!i)
    153f:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1543:	75 07                	jne    154c <task_diag+0x13d>
						i = 128;
    1545:	c7 45 e4 80 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x80
		for (size_t i = end - 1; i != end; i--) {
    154c:	83 6d e4 01          	sub    DWORD PTR [ebp-0x1c],0x1
    1550:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1553:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    1556:	0f 85 1e ff ff ff    	jne    147a <task_diag+0x6b>
    155c:	eb 01                	jmp    155f <task_diag+0x150>
				return;
    155e:	90                   	nop
}
    155f:	8d 65 f4             	lea    esp,[ebp-0xc]
    1562:	5b                   	pop    ebx
    1563:	5e                   	pop    esi
    1564:	5f                   	pop    edi
    1565:	5d                   	pop    ebp
    1566:	c3                   	ret

00001567 <proc_add_time>:
{
    1567:	55                   	push   ebp
    1568:	89 e5                	mov    ebp,esp
    156a:	53                   	push   ebx
    156b:	83 ec 1c             	sub    esp,0x1c
    156e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1571:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1574:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1577:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct perf_ctrs* pc = (nproc > 1) ? per_cpu_ptr()->ticks : bp_tick;
    157a:	a1 00 00 00 00       	mov    eax,ds:0x0
    157f:	83 f8 01             	cmp    eax,0x1
    1582:	76 0a                	jbe    158e <proc_add_time+0x27>
    1584:	e8 77 ea ff ff       	call   0 <per_cpu_ptr>
    1589:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    158c:	eb 05                	jmp    1593 <proc_add_time+0x2c>
    158e:	a1 00 00 00 00       	mov    eax,ds:0x0
    1593:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		/* we're inside the pq lock -> no sync */
		if (flags & TIF_IDLE)
    1596:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1599:	83 e0 40             	and    eax,0x40
    159c:	85 c0                	test   eax,eax
    159e:	74 1e                	je     15be <proc_add_time+0x57>
				pc->ns_idle += ns;
    15a0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    15a3:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    15a6:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    15a9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    15ac:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    15af:	01 c8                	add    eax,ecx
    15b1:	11 da                	adc    edx,ebx
    15b3:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    15b6:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
    15b9:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
    15bc:	eb 44                	jmp    1602 <proc_add_time+0x9b>
		else if (flags & TIF_KERNEL_STACK)
    15be:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    15c1:	83 e0 08             	and    eax,0x8
    15c4:	85 c0                	test   eax,eax
    15c6:	74 1e                	je     15e6 <proc_add_time+0x7f>
				pc->ns_kernel += ns;
    15c8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    15cb:	8b 48 10             	mov    ecx,DWORD PTR [eax+0x10]
    15ce:	8b 58 14             	mov    ebx,DWORD PTR [eax+0x14]
    15d1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    15d4:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    15d7:	01 c8                	add    eax,ecx
    15d9:	11 da                	adc    edx,ebx
    15db:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    15de:	89 41 10             	mov    DWORD PTR [ecx+0x10],eax
    15e1:	89 51 14             	mov    DWORD PTR [ecx+0x14],edx
    15e4:	eb 1c                	jmp    1602 <proc_add_time+0x9b>
		else
				pc->ns_user += ns;
    15e6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    15e9:	8b 48 18             	mov    ecx,DWORD PTR [eax+0x18]
    15ec:	8b 58 1c             	mov    ebx,DWORD PTR [eax+0x1c]
    15ef:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    15f2:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    15f5:	01 c8                	add    eax,ecx
    15f7:	11 da                	adc    edx,ebx
    15f9:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    15fc:	89 41 18             	mov    DWORD PTR [ecx+0x18],eax
    15ff:	89 51 1c             	mov    DWORD PTR [ecx+0x1c],edx
		pc->n_times++;
    1602:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1605:	8b 40 44             	mov    eax,DWORD PTR [eax+0x44]
    1608:	8d 50 01             	lea    edx,[eax+0x1]
    160b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    160e:	89 50 44             	mov    DWORD PTR [eax+0x44],edx
}
    1611:	90                   	nop
    1612:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1615:	c9                   	leave
    1616:	c3                   	ret

00001617 <get_runtime>:

/* returns runtime in ns */
uint64_t get_runtime(struct tsi* t)
{
    1617:	55                   	push   ebp
    1618:	89 e5                	mov    ebp,esp
    161a:	53                   	push   ebx
    161b:	83 ec 34             	sub    esp,0x34
		uint64_t rv;
		union {	uint64_t val; struct { uint32_t lo, hi; }; } b, e, d;
		b.val = t->start_time;
    161e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1621:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
    1624:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    1627:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    162a:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		e.val = t->stop_time;
    162d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1630:	8b 50 40             	mov    edx,DWORD PTR [eax+0x40]
    1633:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
    1636:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1639:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		d.val = e.val - b.val;
    163c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    163f:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1642:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    1645:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
    1648:	29 c8                	sub    eax,ecx
    164a:	19 da                	sbb    edx,ebx
    164c:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    164f:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (cpu.invariant_tsc) {
    1652:	a1 6c 00 00 00       	mov    eax,ds:0x6c
    1657:	85 c0                	test   eax,eax
    1659:	74 3f                	je     169a <get_runtime+0x83>
				rv = 1000000 * d.val / tsc_per_ms;
    165b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    165e:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1661:	69 da 40 42 0f 00    	imul   ebx,edx,0xf4240
    1667:	6b c8 00             	imul   ecx,eax,0x0
    166a:	01 d9                	add    ecx,ebx
    166c:	bb 40 42 0f 00       	mov    ebx,0xf4240
    1671:	f7 e3                	mul    ebx
    1673:	01 d1                	add    ecx,edx
    1675:	89 ca                	mov    edx,ecx
    1677:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    167d:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    1683:	53                   	push   ebx
    1684:	51                   	push   ecx
    1685:	52                   	push   edx
    1686:	50                   	push   eax
    1687:	e8 fc ff ff ff       	call   1688 <get_runtime+0x71>
    168c:	83 c4 10             	add    esp,0x10
    168f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1692:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    1695:	e9 ef 00 00 00       	jmp    1789 <get_runtime+0x172>
		} else if (cpu.has_acpi) {
    169a:	0f b6 05 5a 00 00 00 	movzx  eax,BYTE PTR ds:0x5a
    16a1:	83 e0 40             	and    eax,0x40
    16a4:	84 c0                	test   al,al
    16a6:	0f 84 ad 00 00 00    	je     1759 <get_runtime+0x142>
				int64_t bias = 0;
    16ac:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    16b3:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				/* complicated double values */
				d.hi = e.hi - b.hi; /* jiffie/HZ difference */
    16ba:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    16bd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    16c0:	29 c2                	sub    edx,eax
    16c2:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				/* countdown timer values */
				bias = e.lo - b.lo;
    16c5:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    16c8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    16cb:	29 c2                	sub    edx,eax
    16cd:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
    16d0:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				bias = bias * 1000000000ll / (HZ * apic_reload_value);
    16d7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    16da:	69 d0 00 ca 9a 3b    	imul   edx,eax,0x3b9aca00
    16e0:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    16e3:	6b c0 00             	imul   eax,eax,0x0
    16e6:	8d 0c 02             	lea    ecx,[edx+eax*1]
    16e9:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    16ec:	ba 00 ca 9a 3b       	mov    edx,0x3b9aca00
    16f1:	f7 e2                	mul    edx
    16f3:	01 d1                	add    ecx,edx
    16f5:	89 ca                	mov    edx,ecx
    16f7:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    16fd:	6b c9 79             	imul   ecx,ecx,0x79
    1700:	bb 00 00 00 00       	mov    ebx,0x0
    1705:	53                   	push   ebx
    1706:	51                   	push   ecx
    1707:	52                   	push   edx
    1708:	50                   	push   eax
    1709:	e8 fc ff ff ff       	call   170a <get_runtime+0xf3>
    170e:	83 c4 10             	add    esp,0x10
    1711:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1714:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
				rv = (uint64_t)(1000000000ull * d.hi / HZ + bias);
    1717:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    171a:	ba 00 00 00 00       	mov    edx,0x0
    171f:	69 da 00 ca 9a 3b    	imul   ebx,edx,0x3b9aca00
    1725:	6b c8 00             	imul   ecx,eax,0x0
    1728:	01 d9                	add    ecx,ebx
    172a:	bb 00 ca 9a 3b       	mov    ebx,0x3b9aca00
    172f:	f7 e3                	mul    ebx
    1731:	01 d1                	add    ecx,edx
    1733:	89 ca                	mov    edx,ecx
    1735:	6a 00                	push   0x0
    1737:	6a 79                	push   0x79
    1739:	52                   	push   edx
    173a:	50                   	push   eax
    173b:	e8 fc ff ff ff       	call   173c <get_runtime+0x125>
    1740:	83 c4 10             	add    esp,0x10
    1743:	89 c1                	mov    ecx,eax
    1745:	89 d3                	mov    ebx,edx
    1747:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    174a:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    174d:	01 c8                	add    eax,ecx
    174f:	11 da                	adc    edx,ebx
    1751:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1754:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    1757:	eb 30                	jmp    1789 <get_runtime+0x172>
		} else { /* jiffies */
				rv = 1000000000ull * d.val / HZ;
    1759:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    175c:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    175f:	69 da 00 ca 9a 3b    	imul   ebx,edx,0x3b9aca00
    1765:	6b c8 00             	imul   ecx,eax,0x0
    1768:	01 d9                	add    ecx,ebx
    176a:	bb 00 ca 9a 3b       	mov    ebx,0x3b9aca00
    176f:	f7 e3                	mul    ebx
    1771:	01 d1                	add    ecx,edx
    1773:	89 ca                	mov    edx,ecx
    1775:	6a 00                	push   0x0
    1777:	6a 79                	push   0x79
    1779:	52                   	push   edx
    177a:	50                   	push   eax
    177b:	e8 fc ff ff ff       	call   177c <get_runtime+0x165>
    1780:	83 c4 10             	add    esp,0x10
    1783:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1786:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		}
		return rv;
    1789:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    178c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
}
    178f:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1792:	c9                   	leave
    1793:	c3                   	ret

00001794 <sleep>:
struct wait_queue_head wq_idle = WAIT_QUEUE_HEAD(wq_idle);
struct wait_queue_head wq_timer = WAIT_QUEUE_HEAD(wq_timer);

int sleep(unsigned int seconds)
{
    1794:	55                   	push   ebp
    1795:	89 e5                	mov    ebp,esp
    1797:	83 ec 08             	sub    esp,0x8
		wait_timeout(&wq_timer, HZ * seconds);
    179a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    179d:	6b c0 79             	imul   eax,eax,0x79
    17a0:	83 ec 08             	sub    esp,0x8
    17a3:	50                   	push   eax
    17a4:	68 00 00 00 00       	push   0x0
    17a9:	e8 fc ff ff ff       	call   17aa <sleep+0x16>
    17ae:	83 c4 10             	add    esp,0x10
		return 0;
    17b1:	b8 00 00 00 00       	mov    eax,0x0
}
    17b6:	c9                   	leave
    17b7:	c3                   	ret

000017b8 <wq_add>:

static inline void wq_add(struct wait_queue_head* wq_head, struct wait_queue* wq_tail)
{
    17b8:	55                   	push   ebp
    17b9:	89 e5                	mov    ebp,esp
    17bb:	83 ec 08             	sub    esp,0x8
		spin_lock(&wq_head->lock);
    17be:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17c1:	83 c0 08             	add    eax,0x8
    17c4:	83 ec 0c             	sub    esp,0xc
    17c7:	50                   	push   eax
    17c8:	e8 fc ff ff ff       	call   17c9 <wq_add+0x11>
    17cd:	83 c4 10             	add    esp,0x10
		wq_head->prev->next = wq_tail;
    17d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17d3:	8b 00                	mov    eax,DWORD PTR [eax]
    17d5:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    17d8:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		wq_tail->prev = wq_head->prev;
    17db:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17de:	8b 10                	mov    edx,DWORD PTR [eax]
    17e0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17e3:	89 10                	mov    DWORD PTR [eax],edx
		wq_head->prev = wq_tail;
    17e5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17e8:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    17eb:	89 10                	mov    DWORD PTR [eax],edx
		wq_tail->next = wq_head;
    17ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17f0:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    17f3:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		spin_unlock(&wq_head->lock);
    17f6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17f9:	83 c0 08             	add    eax,0x8
    17fc:	83 ec 0c             	sub    esp,0xc
    17ff:	50                   	push   eax
    1800:	e8 fc ff ff ff       	call   1801 <wq_add+0x49>
    1805:	83 c4 10             	add    esp,0x10
}
    1808:	90                   	nop
    1809:	c9                   	leave
    180a:	c3                   	ret

0000180b <wq_purge>:

static inline void wq_purge(struct wait_queue_head* wq, struct wait_queue* wq_e)
{
    180b:	55                   	push   ebp
    180c:	89 e5                	mov    ebp,esp
    180e:	83 ec 18             	sub    esp,0x18
		int flg;
		spin_lock_irqsave(&wq->lock, &flg);
    1811:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1814:	8d 50 08             	lea    edx,[eax+0x8]
    1817:	83 ec 08             	sub    esp,0x8
    181a:	8d 45 f0             	lea    eax,[ebp-0x10]
    181d:	50                   	push   eax
    181e:	52                   	push   edx
    181f:	e8 fc ff ff ff       	call   1820 <wq_purge+0x15>
    1824:	83 c4 10             	add    esp,0x10
		if (wq->next != (struct wait_queue*)wq) {
    1827:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    182a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    182d:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1830:	74 3f                	je     1871 <wq_purge+0x66>
				struct wait_queue* wq_n = wq->next;
    1832:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1835:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1838:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				do {
						if (wq_n == wq_e) {
    183b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    183e:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    1841:	75 1d                	jne    1860 <wq_purge+0x55>
								wq_n->prev->next = wq_n->next;
    1843:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1846:	8b 00                	mov    eax,DWORD PTR [eax]
    1848:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    184b:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    184e:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								wq_n->next->prev = wq_n->prev;
    1851:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1854:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1857:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    185a:	8b 12                	mov    edx,DWORD PTR [edx]
    185c:	89 10                	mov    DWORD PTR [eax],edx
								break;
    185e:	eb 11                	jmp    1871 <wq_purge+0x66>
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
    1860:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1863:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1866:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1869:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    186c:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    186f:	75 ca                	jne    183b <wq_purge+0x30>
		}
		spin_unlock_irqrestore(&wq->lock, flg);
    1871:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1874:	89 c2                	mov    edx,eax
    1876:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1879:	83 c0 08             	add    eax,0x8
    187c:	83 ec 08             	sub    esp,0x8
    187f:	52                   	push   edx
    1880:	50                   	push   eax
    1881:	e8 fc ff ff ff       	call   1882 <wq_purge+0x77>
    1886:	83 c4 10             	add    esp,0x10
}
    1889:	90                   	nop
    188a:	c9                   	leave
    188b:	c3                   	ret

0000188c <wait_on_event>:

void wait_on_event(struct wait_queue_head* wq)
{
    188c:	55                   	push   ebp
    188d:	89 e5                	mov    ebp,esp
    188f:	83 ec 28             	sub    esp,0x28
		struct wait_queue my_q;
		if (__sync_bool_compare_and_swap(&wq->signaled, 1, 0))
    1892:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1895:	8d 50 0c             	lea    edx,[eax+0xc]
    1898:	b8 01 00 00 00       	mov    eax,0x1
    189d:	b9 00 00 00 00       	mov    ecx,0x0
    18a2:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    18a6:	0f 94 c0             	sete   al
    18a9:	84 c0                	test   al,al
    18ab:	0f 85 81 00 00 00    	jne    1932 <wait_on_event+0xa6>
				return; /* handle signalling */
		if (preempt_needs_init)
    18b1:	a1 00 00 00 00       	mov    eax,ds:0x0
    18b6:	85 c0                	test   eax,eax
    18b8:	75 7b                	jne    1935 <wait_on_event+0xa9>
				return;
		else if (preempt_count())
    18ba:	e8 fc ff ff ff       	call   18bb <wait_on_event+0x2f>
    18bf:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    18c2:	85 c0                	test   eax,eax
    18c4:	75 72                	jne    1938 <wait_on_event+0xac>
				return;
		my_q.task = get_task();
    18c6:	e8 fc ff ff ff       	call   18c7 <wait_on_event+0x3b>
    18cb:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		my_q.timeout = 0;
    18ce:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    18d5:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		wq_add(wq, &my_q);
    18dc:	83 ec 08             	sub    esp,0x8
    18df:	8d 45 e4             	lea    eax,[ebp-0x1c]
    18e2:	50                   	push   eax
    18e3:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    18e6:	e8 cd fe ff ff       	call   17b8 <wq_add>
    18eb:	83 c4 10             	add    esp,0x10
		if (!__sync_bool_compare_and_swap(&wq->signaled, 1, 0)) { /* again */
    18ee:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18f1:	8d 50 0c             	lea    edx,[eax+0xc]
    18f4:	b8 01 00 00 00       	mov    eax,0x1
    18f9:	b9 00 00 00 00       	mov    ecx,0x0
    18fe:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    1902:	0f 94 c0             	sete   al
    1905:	83 f0 01             	xor    eax,0x1
    1908:	84 c0                	test   al,al
    190a:	74 12                	je     191e <wait_on_event+0x92>
				my_q.task->flags |= TIF_SLEEPING;
    190c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    190f:	8b 10                	mov    edx,DWORD PTR [eax]
    1911:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1914:	80 ca 80             	or     dl,0x80
    1917:	89 10                	mov    DWORD PTR [eax],edx
				task_yield();
    1919:	e8 fc ff ff ff       	call   191a <wait_on_event+0x8e>
		}
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
    191e:	83 ec 08             	sub    esp,0x8
    1921:	8d 45 e4             	lea    eax,[ebp-0x1c]
    1924:	50                   	push   eax
    1925:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1928:	e8 de fe ff ff       	call   180b <wq_purge>
    192d:	83 c4 10             	add    esp,0x10
    1930:	eb 07                	jmp    1939 <wait_on_event+0xad>
				return; /* handle signalling */
    1932:	90                   	nop
    1933:	eb 04                	jmp    1939 <wait_on_event+0xad>
				return;
    1935:	90                   	nop
    1936:	eb 01                	jmp    1939 <wait_on_event+0xad>
				return;
    1938:	90                   	nop
}
    1939:	c9                   	leave
    193a:	c3                   	ret

0000193b <wait_timeout>:

void wait_timeout(struct wait_queue_head* wq, uint32_t delta)
{
    193b:	55                   	push   ebp
    193c:	89 e5                	mov    ebp,esp
    193e:	53                   	push   ebx
    193f:	83 ec 24             	sub    esp,0x24
		struct wait_queue my_q;
		my_q.task = get_task();
    1942:	e8 fc ff ff ff       	call   1943 <wait_timeout+0x8>
    1947:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		my_q.timeout = jiffies + delta;
    194a:	a1 00 00 00 00       	mov    eax,ds:0x0
    194f:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1952:	8b 00                	mov    eax,DWORD PTR [eax]
    1954:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    1957:	bb 00 00 00 00       	mov    ebx,0x0
    195c:	01 c8                	add    eax,ecx
    195e:	11 da                	adc    edx,ebx
    1960:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1963:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		wq_add(wq, &my_q);
    1966:	83 ec 08             	sub    esp,0x8
    1969:	8d 45 e4             	lea    eax,[ebp-0x1c]
    196c:	50                   	push   eax
    196d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1970:	e8 43 fe ff ff       	call   17b8 <wq_add>
    1975:	83 c4 10             	add    esp,0x10
		my_q.task->flags |= TIF_SLEEPING;
    1978:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    197b:	8b 10                	mov    edx,DWORD PTR [eax]
    197d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1980:	80 ca 80             	or     dl,0x80
    1983:	89 10                	mov    DWORD PTR [eax],edx
		task_yield();
    1985:	e8 fc ff ff ff       	call   1986 <wait_timeout+0x4b>
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
    198a:	83 ec 08             	sub    esp,0x8
    198d:	8d 45 e4             	lea    eax,[ebp-0x1c]
    1990:	50                   	push   eax
    1991:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1994:	e8 72 fe ff ff       	call   180b <wq_purge>
    1999:	83 c4 10             	add    esp,0x10
}
    199c:	90                   	nop
    199d:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    19a0:	c9                   	leave
    19a1:	c3                   	ret

000019a2 <wake_task>:

int wake_task(struct tsi* t)
{
    19a2:	55                   	push   ebp
    19a3:	89 e5                	mov    ebp,esp
    19a5:	83 ec 18             	sub    esp,0x18
		int rv = 0;
    19a8:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		if (!t)
    19af:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    19b3:	75 14                	jne    19c9 <wake_task+0x27>
				cprintf(KFMT_WARN, "Empty queue entry in wait queue\n");
    19b5:	83 ec 08             	sub    esp,0x8
    19b8:	68 f4 03 00 00       	push   0x3f4
    19bd:	6a 0e                	push   0xe
    19bf:	e8 fc ff ff ff       	call   19c0 <wake_task+0x1e>
    19c4:	83 c4 10             	add    esp,0x10
    19c7:	eb 3c                	jmp    1a05 <wake_task+0x63>
		else { /* TODO: maybe check if really sleeping */
				t->flags &= ~TIF_SLEEPING;
    19c9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19cc:	8b 00                	mov    eax,DWORD PTR [eax]
    19ce:	24 7f                	and    al,0x7f
    19d0:	89 c2                	mov    edx,eax
    19d2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19d5:	89 10                	mov    DWORD PTR [eax],edx
				pq_enqueue((t->flags & TIF_EXPIRED) ?
    19d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19da:	8b 00                	mov    eax,DWORD PTR [eax]
    19dc:	83 e0 20             	and    eax,0x20
    19df:	85 c0                	test   eax,eax
    19e1:	74 07                	je     19ea <wake_task+0x48>
    19e3:	a1 00 00 00 00       	mov    eax,ds:0x0
    19e8:	eb 05                	jmp    19ef <wake_task+0x4d>
    19ea:	a1 00 00 00 00       	mov    eax,ds:0x0
    19ef:	83 ec 08             	sub    esp,0x8
    19f2:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    19f5:	50                   	push   eax
    19f6:	e8 fc ff ff ff       	call   19f7 <wake_task+0x55>
    19fb:	83 c4 10             	add    esp,0x10
						expired_queue : run_queue, t);
				rv = 1;
    19fe:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
		}
		return rv;
    1a05:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1a08:	c9                   	leave
    1a09:	c3                   	ret

00001a0a <wake_up>:

/* called by the scheduler holding pq_lock */
int wake_up(struct wait_queue_head* wq)
{
    1a0a:	55                   	push   ebp
    1a0b:	89 e5                	mov    ebp,esp
    1a0d:	83 ec 18             	sub    esp,0x18
		int rv = 0;
    1a10:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		spin_lock(&wq->lock);
    1a17:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a1a:	83 c0 08             	add    eax,0x8
    1a1d:	83 ec 0c             	sub    esp,0xc
    1a20:	50                   	push   eax
    1a21:	e8 fc ff ff ff       	call   1a22 <wake_up+0x18>
    1a26:	83 c4 10             	add    esp,0x10
		if (wq->next != (struct wait_queue*)wq) {
    1a29:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a2c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1a2f:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1a32:	74 39                	je     1a6d <wake_up+0x63>
				struct wait_queue* wq_n = wq->next;
    1a34:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a37:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1a3a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
    1a3d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a40:	8b 00                	mov    eax,DWORD PTR [eax]
    1a42:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1a45:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    1a48:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				wq_n->next->prev = wq_n->prev;
    1a4b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a4e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1a51:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1a54:	8b 12                	mov    edx,DWORD PTR [edx]
    1a56:	89 10                	mov    DWORD PTR [eax],edx
				rv = wake_task(wq_n->task);
    1a58:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a5b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1a5e:	83 ec 0c             	sub    esp,0xc
    1a61:	50                   	push   eax
    1a62:	e8 fc ff ff ff       	call   1a63 <wake_up+0x59>
    1a67:	83 c4 10             	add    esp,0x10
    1a6a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		}
		spin_unlock(&wq->lock);
    1a6d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a70:	83 c0 08             	add    eax,0x8
    1a73:	83 ec 0c             	sub    esp,0xc
    1a76:	50                   	push   eax
    1a77:	e8 fc ff ff ff       	call   1a78 <wake_up+0x6e>
    1a7c:	83 c4 10             	add    esp,0x10
		return rv;
    1a7f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1a82:	c9                   	leave
    1a83:	c3                   	ret

00001a84 <wake_up_all>:

int wake_up_all(struct wait_queue* wq)
{
    1a84:	55                   	push   ebp
    1a85:	89 e5                	mov    ebp,esp
    1a87:	83 ec 18             	sub    esp,0x18
		int rv = 0;
    1a8a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		while (wake_up(wq))
    1a91:	eb 04                	jmp    1a97 <wake_up_all+0x13>
				rv++;
    1a93:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		while (wake_up(wq))
    1a97:	83 ec 0c             	sub    esp,0xc
    1a9a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1a9d:	e8 fc ff ff ff       	call   1a9e <wake_up_all+0x1a>
    1aa2:	83 c4 10             	add    esp,0x10
    1aa5:	85 c0                	test   eax,eax
    1aa7:	75 ea                	jne    1a93 <wake_up_all+0xf>
		return rv;
    1aa9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1aac:	c9                   	leave
    1aad:	c3                   	ret

00001aae <wake_up_external_event>:

int wake_up_external_event(struct wait_queue_head* wq)
{
    1aae:	55                   	push   ebp
    1aaf:	89 e5                	mov    ebp,esp
    1ab1:	83 ec 18             	sub    esp,0x18
		int rv = 0;
    1ab4:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		spin_lock(&wq->lock);
    1abb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1abe:	83 c0 08             	add    eax,0x8
    1ac1:	83 ec 0c             	sub    esp,0xc
    1ac4:	50                   	push   eax
    1ac5:	e8 fc ff ff ff       	call   1ac6 <wake_up_external_event+0x18>
    1aca:	83 c4 10             	add    esp,0x10
		if (wq->next != (struct wait_queue*)wq) {
    1acd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ad0:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ad3:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1ad6:	74 5d                	je     1b35 <wake_up_external_event+0x87>
				struct wait_queue* wq_n = wq->next;
    1ad8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1adb:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ade:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
    1ae1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ae4:	8b 00                	mov    eax,DWORD PTR [eax]
    1ae6:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1ae9:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    1aec:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				wq_n->next->prev = wq_n->prev;
    1aef:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1af2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1af5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1af8:	8b 12                	mov    edx,DWORD PTR [edx]
    1afa:	89 10                	mov    DWORD PTR [eax],edx
				wq_n->timeout = jiffies;
    1afc:	a1 00 00 00 00       	mov    eax,ds:0x0
    1b01:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1b04:	8b 00                	mov    eax,DWORD PTR [eax]
    1b06:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1b09:	89 41 0c             	mov    DWORD PTR [ecx+0xc],eax
    1b0c:	89 51 10             	mov    DWORD PTR [ecx+0x10],edx
				/* abuse the timer queue */
				wq_add(&wq_timer, wq_n);
    1b0f:	83 ec 08             	sub    esp,0x8
    1b12:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1b15:	68 00 00 00 00       	push   0x0
    1b1a:	e8 99 fc ff ff       	call   17b8 <wq_add>
    1b1f:	83 c4 10             	add    esp,0x10
				rv = 1;
    1b22:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
				wq->signaled = 0;
    1b29:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b2c:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
    1b33:	eb 0a                	jmp    1b3f <wake_up_external_event+0x91>
		} else { /* empty -> prevent waiting forever */
				wq->signaled = 1;
    1b35:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b38:	c7 40 0c 01 00 00 00 	mov    DWORD PTR [eax+0xc],0x1
		}
		spin_unlock(&wq->lock);
    1b3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b42:	83 c0 08             	add    eax,0x8
    1b45:	83 ec 0c             	sub    esp,0xc
    1b48:	50                   	push   eax
    1b49:	e8 fc ff ff ff       	call   1b4a <wake_up_external_event+0x9c>
    1b4e:	83 c4 10             	add    esp,0x10
		return rv;
    1b51:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1b54:	c9                   	leave
    1b55:	c3                   	ret

00001b56 <wake_up_all_external_event>:

int wake_up_all_external_event(struct wait_queue_head* wq)
{
    1b56:	55                   	push   ebp
    1b57:	89 e5                	mov    ebp,esp
    1b59:	83 ec 18             	sub    esp,0x18
		int rv = 0;
    1b5c:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		while (wake_up_external_event(wq))
    1b63:	eb 04                	jmp    1b69 <wake_up_all_external_event+0x13>
				rv++;
    1b65:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		while (wake_up_external_event(wq))
    1b69:	83 ec 0c             	sub    esp,0xc
    1b6c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1b6f:	e8 fc ff ff ff       	call   1b70 <wake_up_all_external_event+0x1a>
    1b74:	83 c4 10             	add    esp,0x10
    1b77:	85 c0                	test   eax,eax
    1b79:	75 ea                	jne    1b65 <wake_up_all_external_event+0xf>
		if (rv) /* a bit iffy */
    1b7b:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1b7f:	74 0a                	je     1b8b <wake_up_all_external_event+0x35>
				wq->signaled = 0;
    1b81:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b84:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		return rv;
    1b8b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1b8e:	c9                   	leave
    1b8f:	c3                   	ret

00001b90 <wake_up_timer>:

int wake_up_timer(struct wait_queue_head* wq)
{
    1b90:	55                   	push   ebp
    1b91:	89 e5                	mov    ebp,esp
    1b93:	53                   	push   ebx
    1b94:	83 ec 14             	sub    esp,0x14
		int rv = 0;
    1b97:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		spin_lock(&wq->lock);
    1b9e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ba1:	83 c0 08             	add    eax,0x8
    1ba4:	83 ec 0c             	sub    esp,0xc
    1ba7:	50                   	push   eax
    1ba8:	e8 fc ff ff ff       	call   1ba9 <wake_up_timer+0x19>
    1bad:	83 c4 10             	add    esp,0x10
		if (wq->next != (struct wait_queue*)wq) {
    1bb0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bb3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1bb6:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1bb9:	74 6d                	je     1c28 <wake_up_timer+0x98>
				struct wait_queue* wq_n = wq->next;
    1bbb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bbe:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1bc1:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				do {
						if (wq_n->timeout <= jiffies) {
    1bc4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1bc7:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
    1bca:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1bcd:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1bd3:	8b 59 04             	mov    ebx,DWORD PTR [ecx+0x4]
    1bd6:	8b 09                	mov    ecx,DWORD PTR [ecx]
    1bd8:	39 c1                	cmp    ecx,eax
    1bda:	19 d3                	sbb    ebx,edx
    1bdc:	72 36                	jb     1c14 <wake_up_timer+0x84>
								wq_n->prev->next = wq_n->next;
    1bde:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1be1:	8b 00                	mov    eax,DWORD PTR [eax]
    1be3:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1be6:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    1be9:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								wq_n->next->prev = wq_n->prev;
    1bec:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1bef:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1bf2:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1bf5:	8b 12                	mov    edx,DWORD PTR [edx]
    1bf7:	89 10                	mov    DWORD PTR [eax],edx
								rv = wake_task(wq_n->task);
    1bf9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1bfc:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1bff:	83 ec 0c             	sub    esp,0xc
    1c02:	50                   	push   eax
    1c03:	e8 fc ff ff ff       	call   1c04 <wake_up_timer+0x74>
    1c08:	83 c4 10             	add    esp,0x10
    1c0b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								if (rv)
    1c0e:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1c12:	75 13                	jne    1c27 <wake_up_timer+0x97>
										break;
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
    1c14:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1c17:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c1a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1c1d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1c20:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    1c23:	75 9f                	jne    1bc4 <wake_up_timer+0x34>
    1c25:	eb 01                	jmp    1c28 <wake_up_timer+0x98>
										break;
    1c27:	90                   	nop
		}
		spin_unlock(&wq->lock);
    1c28:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c2b:	83 c0 08             	add    eax,0x8
    1c2e:	83 ec 0c             	sub    esp,0xc
    1c31:	50                   	push   eax
    1c32:	e8 fc ff ff ff       	call   1c33 <wake_up_timer+0xa3>
    1c37:	83 c4 10             	add    esp,0x10
		return rv;
    1c3a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1c3d:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1c40:	c9                   	leave
    1c41:	c3                   	ret

00001c42 <wake_up_timer_all>:

int wake_up_timer_all(struct wait_queue_head* wq)
{
    1c42:	55                   	push   ebp
    1c43:	89 e5                	mov    ebp,esp
    1c45:	83 ec 18             	sub    esp,0x18
		int rv = 0;
    1c48:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		while (wake_up_timer(wq))
    1c4f:	eb 04                	jmp    1c55 <wake_up_timer_all+0x13>
				rv++;
    1c51:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		while (wake_up_timer(wq))
    1c55:	83 ec 0c             	sub    esp,0xc
    1c58:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1c5b:	e8 fc ff ff ff       	call   1c5c <wake_up_timer_all+0x1a>
    1c60:	83 c4 10             	add    esp,0x10
    1c63:	85 c0                	test   eax,eax
    1c65:	75 ea                	jne    1c51 <wake_up_timer_all+0xf>
		return rv;
    1c67:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1c6a:	c9                   	leave
    1c6b:	c3                   	ret

00001c6c <kidle>:

void kidle(void* data)
{
    1c6c:	55                   	push   ebp
    1c6d:	89 e5                	mov    ebp,esp
    1c6f:	83 ec 08             	sub    esp,0x8
		get_task()->flags |= TIF_IDLE;
    1c72:	e8 fc ff ff ff       	call   1c73 <kidle+0x7>
    1c77:	8b 10                	mov    edx,DWORD PTR [eax]
    1c79:	83 ca 40             	or     edx,0x40
    1c7c:	89 10                	mov    DWORD PTR [eax],edx
		while (1) {
				wait_on_event(&wq_idle);
    1c7e:	83 ec 0c             	sub    esp,0xc
    1c81:	68 00 00 00 00       	push   0x0
    1c86:	e8 fc ff ff ff       	call   1c87 <kidle+0x1b>
    1c8b:	83 c4 10             	add    esp,0x10
				asm("hlt");
    1c8e:	f4                   	hlt
				wait_on_event(&wq_idle);
    1c8f:	90                   	nop
    1c90:	eb ec                	jmp    1c7e <kidle+0x12>

00001c92 <task_schedule>:
size_t ri_ofs = 0;

/* called from everyone else (using cli before). The stack is the
 * stack of the current task. */
void task_schedule(struct tsi* prev_task)
{
    1c92:	55                   	push   ebp
    1c93:	89 e5                	mov    ebp,esp
    1c95:	53                   	push   ebx
    1c96:	83 ec 34             	sub    esp,0x34
		if (preempt_needs_init) /* returns to the task_state on the stack */
    1c99:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c9e:	85 c0                	test   eax,eax
    1ca0:	0f 85 83 06 00 00    	jne    2329 <task_schedule+0x697>
				return;    /* of the irq0 handler, i.e. where execution stopped. */

		struct tsi* t;
		/* calculate the runtime of prev_task and go back if no preemption */
		if (prev_task) {
    1ca6:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1caa:	0f 84 ac 00 00 00    	je     1d5c <task_schedule+0xca>
				/* happens on same proc */
				uint64_t rt = get_runtime(prev_task);
    1cb0:	83 ec 0c             	sub    esp,0xc
    1cb3:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1cb6:	e8 fc ff ff ff       	call   1cb7 <task_schedule+0x25>
    1cbb:	83 c4 10             	add    esp,0x10
    1cbe:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1cc1:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				prev_task->ns_run = rt; // <- could be used for nice values
    1cc4:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1cc7:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1cca:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1ccd:	89 41 48             	mov    DWORD PTR [ecx+0x48],eax
    1cd0:	89 51 4c             	mov    DWORD PTR [ecx+0x4c],edx
				prev_task->ns_acc += rt;
    1cd3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cd6:	8b 48 50             	mov    ecx,DWORD PTR [eax+0x50]
    1cd9:	8b 58 54             	mov    ebx,DWORD PTR [eax+0x54]
    1cdc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1cdf:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1ce2:	01 c8                	add    eax,ecx
    1ce4:	11 da                	adc    edx,ebx
    1ce6:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1ce9:	89 41 50             	mov    DWORD PTR [ecx+0x50],eax
    1cec:	89 51 54             	mov    DWORD PTR [ecx+0x54],edx
				proc_add_time(rt, prev_task->flags);
    1cef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cf2:	8b 00                	mov    eax,DWORD PTR [eax]
    1cf4:	83 ec 04             	sub    esp,0x4
    1cf7:	50                   	push   eax
    1cf8:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1cfb:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    1cfe:	e8 fc ff ff ff       	call   1cff <task_schedule+0x6d>
    1d03:	83 c4 10             	add    esp,0x10
				/* go back but signify TIF_NEED_RESCHED */
				if (prev_task->preempt_count) {
    1d06:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d09:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1d0c:	85 c0                	test   eax,eax
    1d0e:	74 31                	je     1d41 <task_schedule+0xaf>
						prev_task->flags |= TIF_NEED_RESCHED;
    1d10:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d13:	8b 00                	mov    eax,DWORD PTR [eax]
    1d15:	83 c8 01             	or     eax,0x1
    1d18:	89 c2                	mov    edx,eax
    1d1a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d1d:	89 10                	mov    DWORD PTR [eax],edx
						prev_task->start_time = task_gettime();
    1d1f:	e8 fc ff ff ff       	call   1d20 <task_schedule+0x8e>
    1d24:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1d27:	89 41 34             	mov    DWORD PTR [ecx+0x34],eax
    1d2a:	89 51 38             	mov    DWORD PTR [ecx+0x38],edx
						prev_task->quota--; /* go into negative values */
    1d2d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d30:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1d33:	8d 50 ff             	lea    edx,[eax-0x1]
    1d36:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d39:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
						return;
    1d3c:	e9 e9 05 00 00       	jmp    232a <task_schedule+0x698>
				} else if (prev_task->flags & TIF_NEED_RESCHED) /* clear the flag */
    1d41:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d44:	8b 00                	mov    eax,DWORD PTR [eax]
    1d46:	83 e0 01             	and    eax,0x1
    1d49:	85 c0                	test   eax,eax
    1d4b:	74 0f                	je     1d5c <task_schedule+0xca>
						prev_task->flags &= ~TIF_NEED_RESCHED;
    1d4d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d50:	8b 00                	mov    eax,DWORD PTR [eax]
    1d52:	83 e0 fe             	and    eax,0xfffffffe
    1d55:	89 c2                	mov    edx,eax
    1d57:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d5a:	89 10                	mov    DWORD PTR [eax],edx
		}

		/* enter the queue lock (entails free reign over ts values) */
		spin_lock(&pq_lock);
    1d5c:	83 ec 0c             	sub    esp,0xc
    1d5f:	68 00 00 00 00       	push   0x0
    1d64:	e8 fc ff ff ff       	call   1d65 <task_schedule+0xd3>
    1d69:	83 c4 10             	add    esp,0x10
		/* wake up once */
		wake_up_timer_all(&wq_timer);
    1d6c:	83 ec 0c             	sub    esp,0xc
    1d6f:	68 00 00 00 00       	push   0x0
    1d74:	e8 fc ff ff ff       	call   1d75 <task_schedule+0xe3>
    1d79:	83 c4 10             	add    esp,0x10
		/* check for reinsertion */
		for (size_t i = 0; i < ri_ofs; i++) {
    1d7c:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1d83:	eb 71                	jmp    1df6 <task_schedule+0x164>
				struct tsi* ti = ri_queue[i];
    1d85:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1d88:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1d8f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				if (ti->flags & TIF_RUNNING)
    1d92:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1d95:	8b 00                	mov    eax,DWORD PTR [eax]
    1d97:	83 e0 10             	and    eax,0x10
    1d9a:	85 c0                	test   eax,eax
    1d9c:	75 53                	jne    1df1 <task_schedule+0x15f>
						continue;
				/* task is eligible */
				pq_enqueue((ti->flags & TIF_EXPIRED) ?
    1d9e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1da1:	8b 00                	mov    eax,DWORD PTR [eax]
    1da3:	83 e0 20             	and    eax,0x20
    1da6:	85 c0                	test   eax,eax
    1da8:	74 07                	je     1db1 <task_schedule+0x11f>
    1daa:	a1 00 00 00 00       	mov    eax,ds:0x0
    1daf:	eb 05                	jmp    1db6 <task_schedule+0x124>
    1db1:	a1 00 00 00 00       	mov    eax,ds:0x0
    1db6:	83 ec 08             	sub    esp,0x8
    1db9:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1dbc:	50                   	push   eax
    1dbd:	e8 fc ff ff ff       	call   1dbe <task_schedule+0x12c>
    1dc2:	83 c4 10             	add    esp,0x10
						expired_queue : run_queue, ti);
				/* shorten queue and redo current iteration */
				ri_queue[i--] = ri_queue[--ri_ofs];
    1dc5:	a1 00 00 00 00       	mov    eax,ds:0x0
    1dca:	83 e8 01             	sub    eax,0x1
    1dcd:	a3 00 00 00 00       	mov    ds:0x0,eax
    1dd2:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1dd8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ddb:	8d 48 ff             	lea    ecx,[eax-0x1]
    1dde:	89 4d f0             	mov    DWORD PTR [ebp-0x10],ecx
    1de1:	8b 14 95 00 00 00 00 	mov    edx,DWORD PTR [edx*4+0x0]
    1de8:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
    1def:	eb 01                	jmp    1df2 <task_schedule+0x160>
						continue;
    1df1:	90                   	nop
		for (size_t i = 0; i < ri_ofs; i++) {
    1df2:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1df6:	a1 00 00 00 00       	mov    eax,ds:0x0
    1dfb:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    1dfe:	72 85                	jb     1d85 <task_schedule+0xf3>
		}

Pos1:
    1e00:	90                   	nop
    1e01:	eb 04                	jmp    1e07 <task_schedule+0x175>
		}

		/* check for sleeping tasks and if so, forget the task
		 * (wake_up is responsible for reenqueueing) */
		if (t->flags & TIF_SLEEPING)
				goto Pos1;
    1e03:	90                   	nop
    1e04:	eb 01                	jmp    1e07 <task_schedule+0x175>
				if (t != prev_task) { /* except if we're the one holding it */
						ri_queue[ri_ofs++] = t;
						t->quota++;
						if (ri_ofs == RI_LIMIT)
								die("Use a larger reinsertion queue!\n");
						goto Pos1; /* don't schedule the same task on many procs */
    1e06:	90                   	nop
		t = pq_dequeue(run_queue);
    1e07:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e0c:	83 ec 0c             	sub    esp,0xc
    1e0f:	50                   	push   eax
    1e10:	e8 fc ff ff ff       	call   1e11 <task_schedule+0x17f>
    1e15:	83 c4 10             	add    esp,0x10
    1e18:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!t) { /* major rotation */
    1e1b:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1e1f:	75 68                	jne    1e89 <task_schedule+0x1f7>
				struct priority_queue* q = run_queue;
    1e21:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e26:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				run_queue = expired_queue;
    1e29:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e2e:	a3 00 00 00 00       	mov    ds:0x0,eax
				expired_queue = q;
    1e33:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1e36:	a3 00 00 00 00       	mov    ds:0x0,eax
				for (size_t i = 0; i < n_tks; i++) /* unexpire them */
    1e3b:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    1e42:	eb 1f                	jmp    1e63 <task_schedule+0x1d1>
						tks[i]->flags &= ~TIF_EXPIRED;
    1e44:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e47:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1e4e:	8b 10                	mov    edx,DWORD PTR [eax]
    1e50:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e53:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1e5a:	83 e2 df             	and    edx,0xffffffdf
    1e5d:	89 10                	mov    DWORD PTR [eax],edx
				for (size_t i = 0; i < n_tks; i++) /* unexpire them */
    1e5f:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    1e63:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e68:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
    1e6b:	72 d7                	jb     1e44 <task_schedule+0x1b2>
				STAT_INC_COUNTER(sched_mr_count, 1);
    1e6d:	f0 83 05 00 00 00 00 01 	lock add DWORD PTR ds:0x0,0x1
				t = pq_dequeue(run_queue);
    1e75:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e7a:	83 ec 0c             	sub    esp,0xc
    1e7d:	50                   	push   eax
    1e7e:	e8 fc ff ff ff       	call   1e7f <task_schedule+0x1ed>
    1e83:	83 c4 10             	add    esp,0x10
    1e86:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!t) { /* nothing to do? --> wake idle process */
    1e89:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1e8d:	75 3b                	jne    1eca <task_schedule+0x238>
				if (!prev_task || (prev_task->flags & TIF_SLEEPING)
    1e8f:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1e93:	74 1a                	je     1eaf <task_schedule+0x21d>
    1e95:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e98:	8b 00                	mov    eax,DWORD PTR [eax]
    1e9a:	25 80 00 00 00       	and    eax,0x80
    1e9f:	85 c0                	test   eax,eax
    1ea1:	75 0c                	jne    1eaf <task_schedule+0x21d>
							   || (prev_task->flags & TIF_YIELDED)) {
    1ea3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ea6:	8b 00                	mov    eax,DWORD PTR [eax]
    1ea8:	83 e0 02             	and    eax,0x2
    1eab:	85 c0                	test   eax,eax
    1ead:	74 15                	je     1ec4 <task_schedule+0x232>
						wake_up(&wq_idle);
    1eaf:	83 ec 0c             	sub    esp,0xc
    1eb2:	68 00 00 00 00       	push   0x0
    1eb7:	e8 fc ff ff ff       	call   1eb8 <task_schedule+0x226>
    1ebc:	83 c4 10             	add    esp,0x10
						goto Pos1;
    1ebf:	e9 43 ff ff ff       	jmp    1e07 <task_schedule+0x175>
						t = prev_task;
    1ec4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ec7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (t->flags & TIF_DEALLOCATE && !(t->flags & TIF_RUNNING)) {
    1eca:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1ecd:	8b 00                	mov    eax,DWORD PTR [eax]
    1ecf:	83 e0 04             	and    eax,0x4
    1ed2:	85 c0                	test   eax,eax
    1ed4:	74 1f                	je     1ef5 <task_schedule+0x263>
    1ed6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1ed9:	8b 00                	mov    eax,DWORD PTR [eax]
    1edb:	83 e0 10             	and    eax,0x10
    1ede:	85 c0                	test   eax,eax
    1ee0:	75 13                	jne    1ef5 <task_schedule+0x263>
				task_deallocate(t);
    1ee2:	83 ec 0c             	sub    esp,0xc
    1ee5:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1ee8:	e8 fc ff ff ff       	call   1ee9 <task_schedule+0x257>
    1eed:	83 c4 10             	add    esp,0x10
				goto Pos1;
    1ef0:	e9 12 ff ff ff       	jmp    1e07 <task_schedule+0x175>
		if (t->flags & TIF_SLEEPING)
    1ef5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1ef8:	8b 00                	mov    eax,DWORD PTR [eax]
    1efa:	25 80 00 00 00       	and    eax,0x80
    1eff:	85 c0                	test   eax,eax
    1f01:	0f 85 fc fe ff ff    	jne    1e03 <task_schedule+0x171>
		if (--t->quota <= 0) {
    1f07:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f0a:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1f0d:	8d 50 ff             	lea    edx,[eax-0x1]
    1f10:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f13:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
    1f16:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f19:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1f1c:	85 c0                	test   eax,eax
    1f1e:	7f 69                	jg     1f89 <task_schedule+0x2f7>
				t->quota += 10;
    1f20:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f23:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1f26:	8d 50 0a             	lea    edx,[eax+0xa]
    1f29:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f2c:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
				t->flags &= ~TIF_YIELDED;
    1f2f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f32:	8b 00                	mov    eax,DWORD PTR [eax]
    1f34:	83 e0 fd             	and    eax,0xfffffffd
    1f37:	89 c2                	mov    edx,eax
    1f39:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f3c:	89 10                	mov    DWORD PTR [eax],edx
				if (t->cur_priority != PRIORITY_MIN) {
    1f3e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f41:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1f44:	83 f8 03             	cmp    eax,0x3
    1f47:	74 1b                	je     1f64 <task_schedule+0x2d2>
						t->cur_priority++;
    1f49:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f4c:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1f4f:	8d 50 01             	lea    edx,[eax+0x1]
    1f52:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f55:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
						STAT_INC_COUNTER(t->task_mr_bumps, 1);
    1f58:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f5b:	83 c0 64             	add    eax,0x64
    1f5e:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
    1f62:	eb 25                	jmp    1f89 <task_schedule+0x2f7>
						t->flags |= TIF_EXPIRED;
    1f64:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f67:	8b 00                	mov    eax,DWORD PTR [eax]
    1f69:	83 c8 20             	or     eax,0x20
    1f6c:	89 c2                	mov    edx,eax
    1f6e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f71:	89 10                	mov    DWORD PTR [eax],edx
						t->cur_priority = t->priority;
    1f73:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f76:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
    1f79:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f7c:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
						STAT_INC_COUNTER(t->task_mr_expires, 1);
    1f7f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f82:	83 c0 68             	add    eax,0x68
    1f85:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
		if (__sync_fetch_and_or(&t->flags, TIF_RUNNING) & TIF_RUNNING) {
    1f89:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1f8c:	8b 02                	mov    eax,DWORD PTR [edx]
    1f8e:	89 c3                	mov    ebx,eax
    1f90:	89 c1                	mov    ecx,eax
    1f92:	83 c9 10             	or     ecx,0x10
    1f95:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    1f99:	0f 94 c1             	sete   cl
    1f9c:	84 c9                	test   cl,cl
    1f9e:	74 ee                	je     1f8e <task_schedule+0x2fc>
    1fa0:	89 d8                	mov    eax,ebx
    1fa2:	83 e0 10             	and    eax,0x10
    1fa5:	85 c0                	test   eax,eax
    1fa7:	74 68                	je     2011 <task_schedule+0x37f>
				if (t != prev_task) { /* except if we're the one holding it */
    1fa9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fac:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    1faf:	74 60                	je     2011 <task_schedule+0x37f>
						ri_queue[ri_ofs++] = t;
    1fb1:	a1 00 00 00 00       	mov    eax,ds:0x0
    1fb6:	8d 50 01             	lea    edx,[eax+0x1]
    1fb9:	89 15 00 00 00 00    	mov    DWORD PTR ds:0x0,edx
    1fbf:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1fc2:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						t->quota++;
    1fc9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fcc:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1fcf:	8d 50 01             	lea    edx,[eax+0x1]
    1fd2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fd5:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
						if (ri_ofs == RI_LIMIT)
    1fd8:	a1 00 00 00 00       	mov    eax,ds:0x0
    1fdd:	83 f8 20             	cmp    eax,0x20
    1fe0:	0f 85 20 fe ff ff    	jne    1e06 <task_schedule+0x174>
								die("Use a larger reinsertion queue!\n");
    1fe6:	83 ec 08             	sub    esp,0x8
    1fe9:	68 18 04 00 00       	push   0x418
    1fee:	6a 0c                	push   0xc
    1ff0:	e8 fc ff ff ff       	call   1ff1 <task_schedule+0x35f>
    1ff5:	83 c4 10             	add    esp,0x10
    1ff8:	e8 fc ff ff ff       	call   1ff9 <task_schedule+0x367>
    1ffd:	83 ec 0c             	sub    esp,0xc
    2000:	68 00 00 00 00       	push   0x0
    2005:	e8 fc ff ff ff       	call   2006 <task_schedule+0x374>
    200a:	83 c4 10             	add    esp,0x10
    200d:	fa                   	cli
    200e:	f4                   	hlt
    200f:	eb fd                	jmp    200e <task_schedule+0x37c>
				}
		}
		barrier();
		t->run_time++; /* accounting */
    2011:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2014:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    2017:	8d 50 01             	lea    edx,[eax+0x1]
    201a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    201d:	89 50 24             	mov    DWORD PTR [eax+0x24],edx

		/* now jump into task */
		t->start_time = task_gettime();
    2020:	e8 fc ff ff ff       	call   2021 <task_schedule+0x38f>
    2025:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2028:	89 41 34             	mov    DWORD PTR [ecx+0x34],eax
    202b:	89 51 38             	mov    DWORD PTR [ecx+0x38],edx
		/* DEBUG check! */
		{
				struct stack_limits sl;
				if (get_stack(stack_ptr(t), &sl) == -1) {
    202e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2031:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2034:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2037:	89 c2                	mov    edx,eax
    2039:	83 ec 08             	sub    esp,0x8
    203c:	8d 45 d0             	lea    eax,[ebp-0x30]
    203f:	50                   	push   eax
    2040:	52                   	push   edx
    2041:	e8 fc ff ff ff       	call   2042 <task_schedule+0x3b0>
    2046:	83 c4 10             	add    esp,0x10
    2049:	83 f8 ff             	cmp    eax,0xffffffff
    204c:	75 53                	jne    20a1 <task_schedule+0x40f>
						die("invalid task struct at %p (esp=%p)\nt%sprev_task\n",
    204e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2051:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    2054:	75 07                	jne    205d <task_schedule+0x3cb>
    2056:	ba 39 04 00 00       	mov    edx,0x439
    205b:	eb 05                	jmp    2062 <task_schedule+0x3d0>
    205d:	ba 3c 04 00 00       	mov    edx,0x43c
    2062:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2065:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2068:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    206b:	89 c1                	mov    ecx,eax
    206d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2070:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2073:	83 ec 0c             	sub    esp,0xc
    2076:	52                   	push   edx
    2077:	51                   	push   ecx
    2078:	50                   	push   eax
    2079:	68 40 04 00 00       	push   0x440
    207e:	6a 0c                	push   0xc
    2080:	e8 fc ff ff ff       	call   2081 <task_schedule+0x3ef>
    2085:	83 c4 20             	add    esp,0x20
    2088:	e8 fc ff ff ff       	call   2089 <task_schedule+0x3f7>
    208d:	83 ec 0c             	sub    esp,0xc
    2090:	68 00 00 00 00       	push   0x0
    2095:	e8 fc ff ff ff       	call   2096 <task_schedule+0x404>
    209a:	83 c4 10             	add    esp,0x10
    209d:	fa                   	cli
    209e:	f4                   	hlt
    209f:	eb fd                	jmp    209e <task_schedule+0x40c>
								t->ts, stack_ptr(t), (t == prev_task) ? "==" : "!=");
				} else if (stack_ptr(t) < 0x7c00) {
    20a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20a4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    20a7:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    20aa:	3d ff 7b 00 00       	cmp    eax,0x7bff
    20af:	77 32                	ja     20e3 <task_schedule+0x451>
						die("eip below 0x7c00 for task struct at %p\n", t->ts);
    20b1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20b4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    20b7:	83 ec 04             	sub    esp,0x4
    20ba:	50                   	push   eax
    20bb:	68 74 04 00 00       	push   0x474
    20c0:	6a 0c                	push   0xc
    20c2:	e8 fc ff ff ff       	call   20c3 <task_schedule+0x431>
    20c7:	83 c4 10             	add    esp,0x10
    20ca:	e8 fc ff ff ff       	call   20cb <task_schedule+0x439>
    20cf:	83 ec 0c             	sub    esp,0xc
    20d2:	68 00 00 00 00       	push   0x0
    20d7:	e8 fc ff ff ff       	call   20d8 <task_schedule+0x446>
    20dc:	83 c4 10             	add    esp,0x10
    20df:	fa                   	cli
    20e0:	f4                   	hlt
    20e1:	eb fd                	jmp    20e0 <task_schedule+0x44e>
				} else if (t->stack_base < stack_ptr(t) || t->stack_limit > stack_ptr(t)) {
    20e3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20e6:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    20e9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20ec:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    20ef:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    20f2:	39 c2                	cmp    edx,eax
    20f4:	72 13                	jb     2109 <task_schedule+0x477>
    20f6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20f9:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    20fc:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    20ff:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    2102:	8b 52 1c             	mov    edx,DWORD PTR [edx+0x1c]
    2105:	39 c2                	cmp    edx,eax
    2107:	73 2b                	jae    2134 <task_schedule+0x4a2>
						die("jumping into wrong stack!\n");
    2109:	83 ec 08             	sub    esp,0x8
    210c:	68 9c 04 00 00       	push   0x49c
    2111:	6a 0c                	push   0xc
    2113:	e8 fc ff ff ff       	call   2114 <task_schedule+0x482>
    2118:	83 c4 10             	add    esp,0x10
    211b:	e8 fc ff ff ff       	call   211c <task_schedule+0x48a>
    2120:	83 ec 0c             	sub    esp,0xc
    2123:	68 00 00 00 00       	push   0x0
    2128:	e8 fc ff ff ff       	call   2129 <task_schedule+0x497>
    212d:	83 c4 10             	add    esp,0x10
    2130:	fa                   	cli
    2131:	f4                   	hlt
    2132:	eb fd                	jmp    2131 <task_schedule+0x49f>
				} else if (!t->ts)
    2134:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2137:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    213a:	85 c0                	test   eax,eax
    213c:	75 2b                	jne    2169 <task_schedule+0x4d7>
						die("jumping into null!\n");
    213e:	83 ec 08             	sub    esp,0x8
    2141:	68 b7 04 00 00       	push   0x4b7
    2146:	6a 0c                	push   0xc
    2148:	e8 fc ff ff ff       	call   2149 <task_schedule+0x4b7>
    214d:	83 c4 10             	add    esp,0x10
    2150:	e8 fc ff ff ff       	call   2151 <task_schedule+0x4bf>
    2155:	83 ec 0c             	sub    esp,0xc
    2158:	68 00 00 00 00       	push   0x0
    215d:	e8 fc ff ff ff       	call   215e <task_schedule+0x4cc>
    2162:	83 c4 10             	add    esp,0x10
    2165:	fa                   	cli
    2166:	f4                   	hlt
    2167:	eb fd                	jmp    2166 <task_schedule+0x4d4>
				//check_tasks();
				if (pr_lst) { /* ringbuffer */
    2169:	a1 00 00 00 00       	mov    eax,ds:0x0
    216e:	85 c0                	test   eax,eax
    2170:	0f 84 05 01 00 00    	je     227b <task_schedule+0x5e9>
						size_t idx;
get_idx:
    2176:	90                   	nop
						idx = __sync_fetch_and_add(&pr_idx, 1);
    2177:	b8 01 00 00 00       	mov    eax,0x1
    217c:	f0 0f c1 05 00 00 00 00 	lock xadd DWORD PTR ds:0x0,eax
    2184:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						if (idx > 127) {
    2187:	83 7d e8 7f          	cmp    DWORD PTR [ebp-0x18],0x7f
    218b:	76 21                	jbe    21ae <task_schedule+0x51c>
								if (__sync_bool_compare_and_swap(&pr_idx, idx + 1, 0))
    218d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2190:	83 c0 01             	add    eax,0x1
    2193:	ba 00 00 00 00       	mov    edx,0x0
    2198:	f0 0f b1 15 00 00 00 00 	lock cmpxchg DWORD PTR ds:0x0,edx
    21a0:	0f 94 c0             	sete   al
    21a3:	84 c0                	test   al,al
    21a5:	74 d0                	je     2177 <task_schedule+0x4e5>
										idx = 0;
    21a7:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
								else
										goto get_idx;
						}
						if (nproc > 1)
    21ae:	a1 00 00 00 00       	mov    eax,ds:0x0
    21b3:	83 f8 01             	cmp    eax,0x1
    21b6:	76 24                	jbe    21dc <task_schedule+0x54a>
								pr_lst[idx].proc = per_cpu_ptr()->apic_id;
    21b8:	e8 43 de ff ff       	call   0 <per_cpu_ptr>
    21bd:	89 c1                	mov    ecx,eax
    21bf:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
    21c5:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    21c8:	89 d0                	mov    eax,edx
    21ca:	c1 e0 02             	shl    eax,0x2
    21cd:	01 d0                	add    eax,edx
    21cf:	c1 e0 02             	shl    eax,0x2
    21d2:	8d 14 03             	lea    edx,[ebx+eax*1]
    21d5:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    21d8:	89 02                	mov    DWORD PTR [edx],eax
    21da:	eb 1b                	jmp    21f7 <task_schedule+0x565>
						else
								pr_lst[idx].proc = 0;
    21dc:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    21e2:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    21e5:	89 d0                	mov    eax,edx
    21e7:	c1 e0 02             	shl    eax,0x2
    21ea:	01 d0                	add    eax,edx
    21ec:	c1 e0 02             	shl    eax,0x2
    21ef:	01 c8                	add    eax,ecx
    21f1:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						pr_lst[idx].task_name = t->name;
    21f7:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    21fd:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2200:	89 d0                	mov    eax,edx
    2202:	c1 e0 02             	shl    eax,0x2
    2205:	01 d0                	add    eax,edx
    2207:	c1 e0 02             	shl    eax,0x2
    220a:	8d 14 01             	lea    edx,[ecx+eax*1]
    220d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2210:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    2213:	89 42 08             	mov    DWORD PTR [edx+0x8],eax
						pr_lst[idx].task_id = t->task_id;
    2216:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    221c:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    221f:	89 d0                	mov    eax,edx
    2221:	c1 e0 02             	shl    eax,0x2
    2224:	01 d0                	add    eax,edx
    2226:	c1 e0 02             	shl    eax,0x2
    2229:	8d 14 01             	lea    edx,[ecx+eax*1]
    222c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    222f:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2232:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
						pr_lst[idx].eip = instr_ptr(t);
    2235:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2238:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    223b:	8b 48 30             	mov    ecx,DWORD PTR [eax+0x30]
    223e:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
    2244:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2247:	89 d0                	mov    eax,edx
    2249:	c1 e0 02             	shl    eax,0x2
    224c:	01 d0                	add    eax,edx
    224e:	c1 e0 02             	shl    eax,0x2
    2251:	01 d8                	add    eax,ebx
    2253:	89 ca                	mov    edx,ecx
    2255:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
						pr_lst[idx].esp = stack_ptr(t);
    2258:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    225b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    225e:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
    2261:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
    2267:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    226a:	89 d0                	mov    eax,edx
    226c:	c1 e0 02             	shl    eax,0x2
    226f:	01 d0                	add    eax,edx
    2271:	c1 e0 02             	shl    eax,0x2
    2274:	01 d8                	add    eax,ebx
    2276:	89 ca                	mov    edx,ecx
    2278:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
				}
		}
		/* document the processor */
		if (nproc > 1)
    227b:	a1 00 00 00 00       	mov    eax,ds:0x0
    2280:	83 f8 01             	cmp    eax,0x1
    2283:	76 0d                	jbe    2292 <task_schedule+0x600>
				t->task_proc = smp_processor_id();
    2285:	e8 76 dd ff ff       	call   0 <per_cpu_ptr>
    228a:	8b 10                	mov    edx,DWORD PTR [eax]
    228c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    228f:	89 50 44             	mov    DWORD PTR [eax+0x44],edx
		/* reinsert the previous task (if we don't do so next time) */
		if (prev_task && (t != prev_task)) {
    2292:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    2296:	74 55                	je     22ed <task_schedule+0x65b>
    2298:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    229b:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    229e:	74 4d                	je     22ed <task_schedule+0x65b>
				ri_queue[ri_ofs++] = prev_task;
    22a0:	a1 00 00 00 00       	mov    eax,ds:0x0
    22a5:	8d 50 01             	lea    edx,[eax+0x1]
    22a8:	89 15 00 00 00 00    	mov    DWORD PTR ds:0x0,edx
    22ae:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    22b1:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
				if (ri_ofs == RI_LIMIT)
    22b8:	a1 00 00 00 00       	mov    eax,ds:0x0
    22bd:	83 f8 20             	cmp    eax,0x20
    22c0:	75 2b                	jne    22ed <task_schedule+0x65b>
						die("Use a larger reinsertion queue!\n");
    22c2:	83 ec 08             	sub    esp,0x8
    22c5:	68 18 04 00 00       	push   0x418
    22ca:	6a 0c                	push   0xc
    22cc:	e8 fc ff ff ff       	call   22cd <task_schedule+0x63b>
    22d1:	83 c4 10             	add    esp,0x10
    22d4:	e8 fc ff ff ff       	call   22d5 <task_schedule+0x643>
    22d9:	83 ec 0c             	sub    esp,0xc
    22dc:	68 00 00 00 00       	push   0x0
    22e1:	e8 fc ff ff ff       	call   22e2 <task_schedule+0x650>
    22e6:	83 c4 10             	add    esp,0x10
    22e9:	fa                   	cli
    22ea:	f4                   	hlt
    22eb:	eb fd                	jmp    22ea <task_schedule+0x658>
		}
		spin_unlock(&pq_lock);
    22ed:	83 ec 0c             	sub    esp,0xc
    22f0:	68 00 00 00 00       	push   0x0
    22f5:	e8 fc ff ff ff       	call   22f6 <task_schedule+0x664>
    22fa:	83 c4 10             	add    esp,0x10

		/* release stack */
		{ /* only rely on registers */
				register void* ctx = t->ts;
    22fd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2300:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
				if (prev_task && (t != prev_task))
    2303:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    2307:	74 17                	je     2320 <task_schedule+0x68e>
    2309:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    230c:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    230f:	74 0f                	je     2320 <task_schedule+0x68e>
						prev_task->flags &= ~TIF_RUNNING;
    2311:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2314:	8b 00                	mov    eax,DWORD PTR [eax]
    2316:	83 e0 ef             	and    eax,0xffffffef
    2319:	89 c2                	mov    edx,eax
    231b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    231e:	89 10                	mov    DWORD PTR [eax],edx
				longjmp(ctx);
    2320:	89 dc                	mov    esp,ebx
    2322:	e9 fc ff ff ff       	jmp    2323 <task_schedule+0x691>
    2327:	eb 01                	jmp    232a <task_schedule+0x698>
				return;    /* of the irq0 handler, i.e. where execution stopped. */
    2329:	90                   	nop
		}
}
    232a:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    232d:	c9                   	leave
    232e:	c3                   	ret

0000232f <task_schedule_isr>:

/* called from irq0/apic handler returning with iret via longjmp.
 * These handlers are gates, i.e. not-reentrant, ensuring that
 * they have always finished execution before the task switch. */
void task_schedule_isr(void* esp)
{
    232f:	55                   	push   ebp
    2330:	89 e5                	mov    ebp,esp
    2332:	83 ec 18             	sub    esp,0x18
		struct tsi* t = get_task_esp(esp);
    2335:	83 ec 0c             	sub    esp,0xc
    2338:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    233b:	e8 fc ff ff ff       	call   233c <task_schedule_isr+0xd>
    2340:	83 c4 10             	add    esp,0x10
    2343:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		task_schedule(t);
    2346:	83 ec 0c             	sub    esp,0xc
    2349:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    234c:	e8 fc ff ff ff       	call   234d <task_schedule_isr+0x1e>
    2351:	83 c4 10             	add    esp,0x10
}
    2354:	90                   	nop
    2355:	c9                   	leave
    2356:	c3                   	ret

00002357 <task_yield>:

void task_yield()
{
    2357:	55                   	push   ebp
    2358:	89 e5                	mov    ebp,esp
    235a:	83 ec 18             	sub    esp,0x18
		struct tsi* t;
		if (preempt_needs_init)
    235d:	a1 00 00 00 00       	mov    eax,ds:0x0
    2362:	85 c0                	test   eax,eax
    2364:	0f 85 a2 00 00 00    	jne    240c <task_yield+0xb5>
				return; /* shouldn't be called before preemption */
		t = get_task();
    236a:	e8 fc ff ff ff       	call   236b <task_yield+0x14>
    236f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (t->preempt_count) { /* don't yield nonpreemptable task */
    2372:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2375:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2378:	85 c0                	test   eax,eax
    237a:	0f 85 8f 00 00 00    	jne    240f <task_yield+0xb8>
exit:
				return;
		}
		if (if_enabled())
    2380:	e8 8f dc ff ff       	call   14 <if_enabled>
    2385:	85 c0                	test   eax,eax
    2387:	74 2b                	je     23b4 <task_yield+0x5d>
				die("yielding in interrupt!\n");
    2389:	83 ec 08             	sub    esp,0x8
    238c:	68 cb 04 00 00       	push   0x4cb
    2391:	6a 0c                	push   0xc
    2393:	e8 fc ff ff ff       	call   2394 <task_yield+0x3d>
    2398:	83 c4 10             	add    esp,0x10
    239b:	e8 fc ff ff ff       	call   239c <task_yield+0x45>
    23a0:	83 ec 0c             	sub    esp,0xc
    23a3:	68 00 00 00 00       	push   0x0
    23a8:	e8 fc ff ff ff       	call   23a9 <task_yield+0x52>
    23ad:	83 c4 10             	add    esp,0x10
    23b0:	fa                   	cli
    23b1:	f4                   	hlt
    23b2:	eb fd                	jmp    23b1 <task_yield+0x5a>
		void* ptr = &&exit;
    23b4:	c7 45 f0 0a 24 00 00 	mov    DWORD PTR [ebp-0x10],0x240a
		asm volatile (
    23bb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    23be:	fa                   	cli
    23bf:	9c                   	pushf
    23c0:	81 0c 24 00 02 00 00 	or     DWORD PTR [esp],0x200
    23c7:	0e                   	push   cs
    23c8:	50                   	push   eax
    23c9:	60                   	pusha
    23ca:	1e                   	push   ds
    23cb:	06                   	push   es
    23cc:	0f a0                	push   fs
    23ce:	0f a8                	push   gs
    23d0:	89 e0                	mov    eax,esp
    23d2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		: "=mr" (ptr) : "0" (ptr)
#ifdef __x86_64__
							 : "rax" /* we clobber rax */
#endif
							 );
		t->ts = ptr;
    23d5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    23d8:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    23db:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		t->flags |= TIF_YIELDED;
    23de:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    23e1:	8b 00                	mov    eax,DWORD PTR [eax]
    23e3:	83 c8 02             	or     eax,0x2
    23e6:	89 c2                	mov    edx,eax
    23e8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    23eb:	89 10                	mov    DWORD PTR [eax],edx
		/* NOPE! */
		//t->flags &= ~TIF_RUNNING;
		t->stop_time = task_gettime();
    23ed:	e8 fc ff ff ff       	call   23ee <task_yield+0x97>
    23f2:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    23f5:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    23f8:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
		task_schedule(t);
    23fb:	83 ec 0c             	sub    esp,0xc
    23fe:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2401:	e8 fc ff ff ff       	call   2402 <task_yield+0xab>
    2406:	83 c4 10             	add    esp,0x10
		goto exit;
    2409:	90                   	nop
				return;
    240a:	eb 03                	jmp    240f <task_yield+0xb8>
				return; /* shouldn't be called before preemption */
    240c:	90                   	nop
    240d:	eb 01                	jmp    2410 <task_yield+0xb9>
				return;
    240f:	90                   	nop
}
    2410:	c9                   	leave
    2411:	c3                   	ret

00002412 <preempt_init>:

/* this function makes the kernel preemptable and is freeing the
 * previous main kernel stack at 0x60000-0x80000 */
void preempt_init()
{
    2412:	55                   	push   ebp
    2413:	89 e5                	mov    ebp,esp
    2415:	83 ec 08             	sub    esp,0x8
		asm ("cli");
    2418:	fa                   	cli
		pr_lst = kmalloc(128 * sizeof(*pr_lst));
    2419:	83 ec 0c             	sub    esp,0xc
    241c:	68 00 0a 00 00       	push   0xa00
    2421:	e8 fc ff ff ff       	call   2422 <preempt_init+0x10>
    2426:	83 c4 10             	add    esp,0x10
    2429:	a3 00 00 00 00       	mov    ds:0x0,eax
		extern void kinit(void*);
		extern void kredraw(void*);
		extern void kscrub(void*);
		task_spawn(kinit, NULL, PRIORITY_MAX);
    242e:	68 e3 04 00 00       	push   0x4e3
    2433:	6a 00                	push   0x0
    2435:	6a 00                	push   0x0
    2437:	68 00 00 00 00       	push   0x0
    243c:	e8 fc ff ff ff       	call   243d <preempt_init+0x2b>
    2441:	83 c4 10             	add    esp,0x10
		task_spawn(kredraw, NULL, PRIORITY_MAX);
    2444:	68 e9 04 00 00       	push   0x4e9
    2449:	6a 00                	push   0x0
    244b:	6a 00                	push   0x0
    244d:	68 00 00 00 00       	push   0x0
    2452:	e8 fc ff ff ff       	call   2453 <preempt_init+0x41>
    2457:	83 c4 10             	add    esp,0x10
		task_spawn(kscrub, NULL, PRIORITY_MIN);
    245a:	68 f1 04 00 00       	push   0x4f1
    245f:	6a 03                	push   0x3
    2461:	6a 00                	push   0x0
    2463:	68 00 00 00 00       	push   0x0
    2468:	e8 fc ff ff ff       	call   2469 <preempt_init+0x57>
    246d:	83 c4 10             	add    esp,0x10
		/* at least n+1 idle task are needed */
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2470:	68 f8 04 00 00       	push   0x4f8
    2475:	6a 03                	push   0x3
    2477:	6a 00                	push   0x0
    2479:	68 00 00 00 00       	push   0x0
    247e:	e8 fc ff ff ff       	call   247f <preempt_init+0x6d>
    2483:	83 c4 10             	add    esp,0x10
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2486:	68 f8 04 00 00       	push   0x4f8
    248b:	6a 03                	push   0x3
    248d:	6a 00                	push   0x0
    248f:	68 00 00 00 00       	push   0x0
    2494:	e8 fc ff ff ff       	call   2495 <preempt_init+0x83>
    2499:	83 c4 10             	add    esp,0x10
		preempt_needs_init = 0;
    249c:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
		task_schedule(NULL);
    24a6:	83 ec 0c             	sub    esp,0xc
    24a9:	6a 00                	push   0x0
    24ab:	e8 fc ff ff ff       	call   24ac <preempt_init+0x9a>
    24b0:	83 c4 10             	add    esp,0x10
}
    24b3:	90                   	nop
    24b4:	c9                   	leave
    24b5:	c3                   	ret
