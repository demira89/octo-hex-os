
tasks.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
		uint64_t r12;
		uint64_t r11;
		uint64_t r10;
		uint64_t r9;
		uint64_t r8;
		uint64_t rdi;
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
		uint64_t rsi;
		uint64_t rbp;
		uint64_t rsp;
		uint64_t rbx;
		uint64_t rdx;
       6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
       c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		uint64_t rcx;
		uint64_t rax;
       f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
		uint64_t rip;
      12:	c9                   	leave
      13:	c3                   	ret

00000014 <if_enabled>:
		if (diag++)
				return;
		framebuffer_redraw(&fb_initial);
		mdelay(1000);
		print_tasks();
		printf("PROC TASK TASK_NAME        EIP      ESP\n");
      14:	55                   	push   ebp
      15:	89 e5                	mov    ebp,esp
      17:	83 ec 10             	sub    esp,0x10
		for (size_t i = end - 1; i != end; i--) {
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
      1a:	9c                   	pushf
      1b:	58                   	pop    eax
      1c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				if (!i)
						i = 128;
		}
}

void proc_add_time(uint64_t ns, uint32_t flags)
      1f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      22:	83 e0 20             	and    eax,0x20
      25:	85 c0                	test   eax,eax
      27:	0f 95 c0             	setne  al
      2a:	0f b6 c0             	movzx  eax,al
{
      2d:	c9                   	leave
      2e:	c3                   	ret

0000002f <alloc_stack>:
{
      2f:	55                   	push   ebp
      30:	89 e5                	mov    ebp,esp
      32:	83 ec 28             	sub    esp,0x28
		while (kernel_stacks.free_stacks) {
      35:	eb 64                	jmp    9b <alloc_stack+0x6c>
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
      59:	74 40                	je     9b <alloc_stack+0x6c>
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
      74:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
      78:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      7b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
      7f:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
      87:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
      8e:	e8 fc ff ff ff       	call   8f <alloc_stack+0x60>
						return rv;
      93:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      96:	e9 e5 00 00 00       	jmp    180 <alloc_stack+0x151>
		while (kernel_stacks.free_stacks) {
      9b:	a1 18 00 00 00       	mov    eax,ds:0x18
      a0:	85 c0                	test   eax,eax
      a2:	75 93                	jne    37 <alloc_stack+0x8>
		rv = kernel_stacks.vm_ptr;
      a4:	a1 04 00 00 00       	mov    eax,ds:0x4
      a9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rv += 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_guard + kernel_stacks.n_res);
      ac:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
      b2:	a1 14 00 00 00       	mov    eax,ds:0x14
      b7:	01 c2                	add    edx,eax
      b9:	a1 10 00 00 00       	mov    eax,ds:0x10
      be:	01 d0                	add    eax,edx
      c0:	c1 e0 0c             	shl    eax,0xc
      c3:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		if (rv > kernel_stacks.vm_top)
      c6:	a1 08 00 00 00       	mov    eax,ds:0x8
      cb:	3b 45 f4             	cmp    eax,DWORD PTR [ebp-0xc]
      ce:	73 0a                	jae    da <alloc_stack+0xab>
				return NULL;
      d0:	b8 00 00 00 00       	mov    eax,0x0
      d5:	e9 a6 00 00 00       	jmp    180 <alloc_stack+0x151>
						rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_guard),
      da:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
      e0:	a1 14 00 00 00       	mov    eax,ds:0x14
      e5:	01 d0                	add    eax,edx
      e7:	c1 e0 0c             	shl    eax,0xc
      ea:	f7 d8                	neg    eax
      ec:	89 c2                	mov    edx,eax
      ee:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      f1:	01 d0                	add    eax,edx
		rv = mm_alloc_vmem(&mm_kernel, kernel_stacks.n_alloc,
      f3:	89 c2                	mov    edx,eax
      f5:	a1 0c 00 00 00       	mov    eax,ds:0xc
      fa:	c7 44 24 0c 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0xc
     102:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     106:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     10a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     111:	e8 fc ff ff ff       	call   112 <alloc_stack+0xe3>
     116:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (rv) {
     119:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     11d:	74 5c                	je     17b <alloc_stack+0x14c>
				rv += kernel_stacks.n_alloc * 4096;
     11f:	a1 0c 00 00 00       	mov    eax,ds:0xc
     124:	c1 e0 0c             	shl    eax,0xc
     127:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
				kernel_stacks.vm_ptr = rv + 4096 * kernel_stacks.n_guard;
     12a:	a1 14 00 00 00       	mov    eax,ds:0x14
     12f:	c1 e0 0c             	shl    eax,0xc
     132:	89 c2                	mov    edx,eax
     134:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     137:	01 d0                	add    eax,edx
     139:	a3 04 00 00 00       	mov    ds:0x4,eax
								rv, rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_res));
     13e:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
     144:	a1 10 00 00 00       	mov    eax,ds:0x10
     149:	01 d0                	add    eax,edx
     14b:	c1 e0 0c             	shl    eax,0xc
     14e:	f7 d8                	neg    eax
     150:	89 c2                	mov    edx,eax
				cprintf(KFMT_INFO, "alloc_stack(): from %p to %p\n",
     152:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     155:	01 d0                	add    eax,edx
     157:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
     15b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     15e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     162:	c7 44 24 04 1c 00 00 00 	mov    DWORD PTR [esp+0x4],0x1c
     16a:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
     171:	e8 fc ff ff ff       	call   172 <alloc_stack+0x143>
				return rv;
     176:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     179:	eb 05                	jmp    180 <alloc_stack+0x151>
				return NULL;
     17b:	b8 00 00 00 00       	mov    eax,0x0
}
     180:	c9                   	leave
     181:	c3                   	ret

00000182 <free_stack>:
{
     182:	55                   	push   ebp
     183:	89 e5                	mov    ebp,esp
     185:	83 ec 10             	sub    esp,0x10
		void** pptr = (void**)(stack_base - sizeof(void*));
     188:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     18b:	83 e8 04             	sub    eax,0x4
     18e:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				*pptr = kernel_stacks.free_stacks;
     191:	8b 15 18 00 00 00    	mov    edx,DWORD PTR ds:0x18
     197:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     19a:	89 10                	mov    DWORD PTR [eax],edx
		} while (!__sync_bool_compare_and_swap(&kernel_stacks.free_stacks, *pptr, stack_base));
     19c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     19f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     1a2:	8b 00                	mov    eax,DWORD PTR [eax]
     1a4:	f0 0f b1 15 18 00 00 00 	lock cmpxchg DWORD PTR ds:0x18,edx
     1ac:	0f 94 c0             	sete   al
     1af:	83 f0 01             	xor    eax,0x1
     1b2:	84 c0                	test   al,al
     1b4:	75 db                	jne    191 <free_stack+0xf>
}
     1b6:	90                   	nop
     1b7:	90                   	nop
     1b8:	c9                   	leave
     1b9:	c3                   	ret

000001ba <install_tss>:
{
     1ba:	55                   	push   ebp
     1bb:	89 e5                	mov    ebp,esp
     1bd:	53                   	push   ebx
		*gdte = ((uint64_t)(tss_addr & 0x00ffffff) << 16) /* base */
     1be:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1c1:	ba 00 00 00 00       	mov    edx,0x0
     1c6:	0f a4 c2 10          	shld   edx,eax,0x10
     1ca:	c1 e0 10             	shl    eax,0x10
     1cd:	66 b8 00 00          	mov    ax,0x0
     1d1:	81 e2 ff 00 00 00    	and    edx,0xff
     1d7:	89 c1                	mov    ecx,eax
     1d9:	89 d3                	mov    ebx,edx
				+ ((uint64_t)(tss_addr & 0xff000000) << 32)
     1db:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1de:	ba 00 00 00 00       	mov    edx,0x0
     1e3:	89 c2                	mov    edx,eax
     1e5:	31 c0                	xor    eax,eax
     1e7:	b8 00 00 00 00       	mov    eax,0x0
     1ec:	81 e2 00 00 00 ff    	and    edx,0xff000000
     1f2:	09 c8                	or     eax,ecx
     1f4:	09 da                	or     edx,ebx
				+ (sizeof(struct tss) - 1);
     1f6:	83 c0 67             	add    eax,0x67
     1f9:	81 d2 00 89 40 00    	adc    edx,0x408900
		*gdte = ((uint64_t)(tss_addr & 0x00ffffff) << 16) /* base */
     1ff:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     202:	89 01                	mov    DWORD PTR [ecx],eax
     204:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
}
     207:	90                   	nop
     208:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     20b:	c9                   	leave
     20c:	c3                   	ret

0000020d <mmgr_init_tss>:
{
     20d:	55                   	push   ebp
     20e:	89 e5                	mov    ebp,esp
     210:	83 ec 28             	sub    esp,0x28
		uint64_t* gdt = &kernltss;
     213:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		void* stk = alloc_stack();
     21a:	e8 fc ff ff ff       	call   21b <mmgr_init_tss+0xe>
     21f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (stk)
     222:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     226:	74 15                	je     23d <mmgr_init_tss+0x30>
				printf("allocated interrupt stack for first TSS at %p\n", stk);
     228:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     22b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     22f:	c7 04 24 3c 00 00 00 	mov    DWORD PTR [esp],0x3c
     236:	e8 fc ff ff ff       	call   237 <mmgr_init_tss+0x2a>
     23b:	eb 02                	jmp    23f <mmgr_init_tss+0x32>
		else while (1);
     23d:	eb fe                	jmp    23d <mmgr_init_tss+0x30>
		main_tss.ss0 = SEG_DATA; /* kernel ds */
     23f:	66 c7 05 08 00 00 00 10 00 	mov    WORD PTR ds:0x8,0x10
		main_tss.esp0 = (uint32_t)stk;
     248:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     24b:	a3 04 00 00 00       	mov    ds:0x4,eax
		main_tss.iomap = sizeof(struct tss);
     250:	66 c7 05 66 00 00 00 68 00 	mov    WORD PTR ds:0x66,0x68
		install_tss(gdt, (intptr_t)&main_tss);
     259:	b8 00 00 00 00       	mov    eax,0x0
     25e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     262:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     265:	89 04 24             	mov    DWORD PTR [esp],eax
     268:	e8 fc ff ff ff       	call   269 <mmgr_init_tss+0x5c>
		asm volatile("ltr %%ax": : "a" (SEG_TSS_PL0));
     26d:	b8 28 00 00 00       	mov    eax,0x28
     272:	0f 00 d8             	ltr    eax
		gdt = &intrtss;
     275:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		intr_tss.iomap = sizeof(struct tss);
     27c:	66 c7 05 66 00 00 00 68 00 	mov    WORD PTR ds:0x66,0x68
		intr_tss.ss0 = SEG_DATA;
     285:	66 c7 05 08 00 00 00 10 00 	mov    WORD PTR ds:0x8,0x10
		intr_tss.esp0 = (uint32_t)stk;
     28e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     291:	a3 04 00 00 00       	mov    ds:0x4,eax
		intr_tss.cs = SEG_CODE;
     296:	66 c7 05 4c 00 00 00 08 00 	mov    WORD PTR ds:0x4c,0x8
		intr_tss.ds = intr_tss.es = SEG_DATA;
     29f:	b8 10 00 00 00       	mov    eax,0x10
     2a4:	66 a3 48 00 00 00    	mov    ds:0x48,ax
     2aa:	66 a3 54 00 00 00    	mov    ds:0x54,ax
		intr_tss.ss = SEG_DATA;
     2b0:	66 c7 05 50 00 00 00 10 00 	mov    WORD PTR ds:0x50,0x10
		intr_tss.gs = SEG_DATA;
     2b9:	66 c7 05 5c 00 00 00 10 00 	mov    WORD PTR ds:0x5c,0x10
		intr_tss.fs = SEG_DATA_PROC;
     2c2:	66 c7 05 58 00 00 00 40 00 	mov    WORD PTR ds:0x58,0x40
		intr_tss.esp = (uint32_t)stk;// - 0x40; /* esp+14*x in handler <- PROLLY MISCONCEPTION */
     2cb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2ce:	a3 38 00 00 00       	mov    ds:0x38,eax
		asm ("mov %%cr3, %%eax\n movl %%eax, %0\n" : "=m" (intr_tss.cr3) : : "eax");
     2d3:	0f 20 d8             	mov    eax,cr3
     2d6:	a3 1c 00 00 00       	mov    ds:0x1c,eax
		intr_tss.eip = (uint32_t)&gate_8; /* already uses iret */
     2db:	b8 00 00 00 00       	mov    eax,0x0
     2e0:	a3 20 00 00 00       	mov    ds:0x20,eax
		install_tss(gdt, (uintptr_t)&intr_tss);
     2e5:	b8 00 00 00 00       	mov    eax,0x0
     2ea:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     2ee:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2f1:	89 04 24             	mov    DWORD PTR [esp],eax
     2f4:	e8 fc ff ff ff       	call   2f5 <mmgr_init_tss+0xe8>
		idt_desc_8 = 0x0000850000480000;
     2f9:	c7 05 00 00 00 00 00 00 48 00 	mov    DWORD PTR ds:0x0,0x480000
     303:	c7 05 04 00 00 00 00 85 00 00 	mov    DWORD PTR ds:0x4,0x8500
}
     30d:	90                   	nop
     30e:	c9                   	leave
     30f:	c3                   	ret

00000310 <pq_enqueue>:
{
     310:	55                   	push   ebp
     311:	89 e5                	mov    ebp,esp
     313:	53                   	push   ebx
     314:	83 ec 24             	sub    esp,0x24
		struct pqe* e = pq->queues[t->cur_priority];
     317:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     31a:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
     31d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     320:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
     323:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!e) {
     326:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     32a:	75 54                	jne    380 <pq_enqueue+0x70>
				e = pq->queues[t->cur_priority] = kzalloc(sizeof(struct pqe));
     32c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     32f:	8b 58 30             	mov    ebx,DWORD PTR [eax+0x30]
     332:	c7 04 24 8c 00 00 00 	mov    DWORD PTR [esp],0x8c
     339:	e8 fc ff ff ff       	call   33a <pq_enqueue+0x2a>
     33e:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     341:	89 04 9a             	mov    DWORD PTR [edx+ebx*4],eax
     344:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     347:	8b 04 98             	mov    eax,DWORD PTR [eax+ebx*4]
     34a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				e->next = NULL;
     34d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     350:	c7 80 88 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x88],0x0
				e->cur = e->end = &e->tks[0];
     35a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     35d:	8d 50 08             	lea    edx,[eax+0x8]
     360:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     363:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     366:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     369:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     36c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     36f:	89 10                	mov    DWORD PTR [eax],edx
				pq->queues[t->cur_priority] = e;
     371:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     374:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
     377:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     37a:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     37d:	89 0c 90             	mov    DWORD PTR [eax+edx*4],ecx
				if (e->end + 1 != e->cur) {
     380:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     383:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     386:	8d 50 04             	lea    edx,[eax+0x4]
     389:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     38c:	8b 00                	mov    eax,DWORD PTR [eax]
     38e:	39 c2                	cmp    edx,eax
     390:	74 60                	je     3f2 <pq_enqueue+0xe2>
						if (!(e->cur == e->tks && (e->end + 1 == e->tks + COUNT_OF(e->tks)))) {
     392:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     395:	8b 10                	mov    edx,DWORD PTR [eax]
     397:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     39a:	83 c0 08             	add    eax,0x8
     39d:	39 c2                	cmp    edx,eax
     39f:	75 16                	jne    3b7 <pq_enqueue+0xa7>
     3a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3a4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     3a7:	8d 50 04             	lea    edx,[eax+0x4]
     3aa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3ad:	83 c0 08             	add    eax,0x8
     3b0:	83 e8 80             	sub    eax,0xffffff80
     3b3:	39 c2                	cmp    edx,eax
     3b5:	74 3b                	je     3f2 <pq_enqueue+0xe2>
								*e->end = t;
     3b7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3ba:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     3bd:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     3c0:	89 10                	mov    DWORD PTR [eax],edx
								if (++e->end == e->tks + COUNT_OF(e->tks))
     3c2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3c5:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     3c8:	8d 50 04             	lea    edx,[eax+0x4]
     3cb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3ce:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     3d1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3d4:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     3d7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3da:	83 c0 08             	add    eax,0x8
     3dd:	83 e8 80             	sub    eax,0xffffff80
     3e0:	39 c2                	cmp    edx,eax
     3e2:	75 7a                	jne    45e <pq_enqueue+0x14e>
										e->end = &e->tks[0];
     3e4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3e7:	8d 50 08             	lea    edx,[eax+0x8]
     3ea:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3ed:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								return;
     3f0:	eb 6c                	jmp    45e <pq_enqueue+0x14e>
				if (!e->next) {
     3f2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3f5:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     3fb:	85 c0                	test   eax,eax
     3fd:	75 4e                	jne    44d <pq_enqueue+0x13d>
						e->next = kzalloc(sizeof(struct pqe));
     3ff:	c7 04 24 8c 00 00 00 	mov    DWORD PTR [esp],0x8c
     406:	e8 fc ff ff ff       	call   407 <pq_enqueue+0xf7>
     40b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     40e:	89 82 88 00 00 00    	mov    DWORD PTR [edx+0x88],eax
						e->next->next = NULL;
     414:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     417:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     41d:	c7 80 88 00 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x88],0x0
						e->next->cur = e->next->end = &e->next->tks[0];
     427:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     42a:	8b 90 88 00 00 00    	mov    edx,DWORD PTR [eax+0x88]
     430:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     433:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     439:	83 c2 08             	add    edx,0x8
     43c:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     43f:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     442:	8b 92 88 00 00 00    	mov    edx,DWORD PTR [edx+0x88]
     448:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     44b:	89 02                	mov    DWORD PTR [edx],eax
				e = e->next;
     44d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     450:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     456:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (e->end + 1 != e->cur) {
     459:	e9 22 ff ff ff       	jmp    380 <pq_enqueue+0x70>
								return;
     45e:	90                   	nop
}
     45f:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     462:	c9                   	leave
     463:	c3                   	ret

00000464 <pq_dequeue>:
{
     464:	55                   	push   ebp
     465:	89 e5                	mov    ebp,esp
     467:	83 ec 10             	sub    esp,0x10
		for (uint32_t p = PRIORITY_MAX; p <= PRIORITY_MIN; p++) {
     46a:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
     471:	eb 67                	jmp    4da <pq_dequeue+0x76>
				struct pqe* e = pq->queues[p];
     473:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     476:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     479:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
     47c:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
				while (e) {
     47f:	eb 4f                	jmp    4d0 <pq_dequeue+0x6c>
						if (e->cur != e->end) {
     481:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     484:	8b 10                	mov    edx,DWORD PTR [eax]
     486:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     489:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     48c:	39 c2                	cmp    edx,eax
     48e:	74 34                	je     4c4 <pq_dequeue+0x60>
								rv = *e->cur++;
     490:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     493:	8b 00                	mov    eax,DWORD PTR [eax]
     495:	8d 48 04             	lea    ecx,[eax+0x4]
     498:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
     49b:	89 0a                	mov    DWORD PTR [edx],ecx
     49d:	8b 00                	mov    eax,DWORD PTR [eax]
     49f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								if (e->cur == (e->tks + COUNT_OF(e->tks)))
     4a2:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     4a5:	8b 10                	mov    edx,DWORD PTR [eax]
     4a7:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     4aa:	83 c0 08             	add    eax,0x8
     4ad:	83 e8 80             	sub    eax,0xffffff80
     4b0:	39 c2                	cmp    edx,eax
     4b2:	75 0b                	jne    4bf <pq_dequeue+0x5b>
										e->cur = e->tks;
     4b4:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     4b7:	8d 50 08             	lea    edx,[eax+0x8]
     4ba:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     4bd:	89 10                	mov    DWORD PTR [eax],edx
								return rv;
     4bf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     4c2:	eb 21                	jmp    4e5 <pq_dequeue+0x81>
						e = e->next;
     4c4:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     4c7:	8b 80 88 00 00 00    	mov    eax,DWORD PTR [eax+0x88]
     4cd:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
				while (e) {
     4d0:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     4d4:	75 ab                	jne    481 <pq_dequeue+0x1d>
		for (uint32_t p = PRIORITY_MAX; p <= PRIORITY_MIN; p++) {
     4d6:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
     4da:	83 7d fc 03          	cmp    DWORD PTR [ebp-0x4],0x3
     4de:	76 93                	jbe    473 <pq_dequeue+0xf>
		return NULL; /* major rotation */
     4e0:	b8 00 00 00 00       	mov    eax,0x0
}
     4e5:	c9                   	leave
     4e6:	c3                   	ret

000004e7 <get_stack>:
{
     4e7:	55                   	push   ebp
     4e8:	89 e5                	mov    ebp,esp
     4ea:	83 ec 10             	sub    esp,0x10
		if ((ptr < kernel_stacks.vm_base) || (ptr > kernel_stacks.vm_ptr)) {
     4ed:	a1 00 00 00 00       	mov    eax,ds:0x0
     4f2:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
     4f5:	72 0a                	jb     501 <get_stack+0x1a>
     4f7:	a1 04 00 00 00       	mov    eax,ds:0x4
     4fc:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
     4ff:	73 07                	jae    508 <get_stack+0x21>
				return -1;
     501:	b8 ff ff ff ff       	mov    eax,0xffffffff
     506:	eb 73                	jmp    57b <get_stack+0x94>
		ptr = (void*)((size_t)ptr - (size_t)kernel_stacks.vm_base);
     508:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     50b:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     511:	29 d0                	sub    eax,edx
     513:	89 45 08             	mov    DWORD PTR [ebp+0x8],eax
		rv = (size_t)ptr / 4096;
     516:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     519:	c1 e8 0c             	shr    eax,0xc
     51c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		np = kernel_stacks.n_alloc + kernel_stacks.n_guard + kernel_stacks.n_res;
     51f:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
     525:	a1 14 00 00 00       	mov    eax,ds:0x14
     52a:	01 c2                	add    edx,eax
     52c:	a1 10 00 00 00       	mov    eax,ds:0x10
     531:	01 d0                	add    eax,edx
     533:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		rv /= np;
     536:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     539:	ba 00 00 00 00       	mov    edx,0x0
     53e:	f7 75 f8             	div    DWORD PTR [ebp-0x8]
     541:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		sl->limit = kernel_stacks.vm_base + rv * np * 4096;
     544:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     54a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     54d:	0f af 45 f8          	imul   eax,DWORD PTR [ebp-0x8]
     551:	c1 e0 0c             	shl    eax,0xc
     554:	01 c2                	add    edx,eax
     556:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     559:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		sl->base = sl->limit + 4096 * (np - kernel_stacks.n_guard);
     55c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     55f:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     562:	a1 14 00 00 00       	mov    eax,ds:0x14
     567:	8b 4d f8             	mov    ecx,DWORD PTR [ebp-0x8]
     56a:	29 c1                	sub    ecx,eax
     56c:	89 c8                	mov    eax,ecx
     56e:	c1 e0 0c             	shl    eax,0xc
     571:	01 c2                	add    edx,eax
     573:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     576:	89 10                	mov    DWORD PTR [eax],edx
		return rv;
     578:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
     57b:	c9                   	leave
     57c:	c3                   	ret

0000057d <task_gettime>:
{
     57d:	55                   	push   ebp
     57e:	89 e5                	mov    ebp,esp
     580:	57                   	push   edi
     581:	56                   	push   esi
     582:	53                   	push   ebx
     583:	83 ec 14             	sub    esp,0x14
		if (cpu.invariant_tsc) {
     586:	a1 6c 00 00 00       	mov    eax,ds:0x6c
     58b:	85 c0                	test   eax,eax
     58d:	74 0d                	je     59c <task_gettime+0x1f>
				asm volatile ("rdtsc" : "=A" (rv));
     58f:	0f 31                	rdtsc
     591:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     594:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     597:	e9 98 00 00 00       	jmp    634 <task_gettime+0xb7>
		} else if (cpu.has_apic) {
     59c:	0f b6 05 59 00 00 00 	movzx  eax,BYTE PTR ds:0x59
     5a3:	83 e0 02             	and    eax,0x2
     5a6:	84 c0                	test   al,al
     5a8:	74 7a                	je     624 <task_gettime+0xa7>
				if (!apic_initialized)
     5aa:	a1 00 00 00 00       	mov    eax,ds:0x0
     5af:	85 c0                	test   eax,eax
     5b1:	75 0c                	jne    5bf <task_gettime+0x42>
						return 0;
     5b3:	b8 00 00 00 00       	mov    eax,0x0
     5b8:	ba 00 00 00 00       	mov    edx,0x0
     5bd:	eb 7b                	jmp    63a <task_gettime+0xbd>
				if (nproc > 1)
     5bf:	a1 00 00 00 00       	mov    eax,ds:0x0
     5c4:	83 f8 01             	cmp    eax,0x1
     5c7:	76 35                	jbe    5fe <task_gettime+0x81>
						rv = (per_cpu_ptr()->ticks->tick << 32) | apic_reg(APIC_REG_TMRCURRCNT);
     5c9:	e8 32 fa ff ff       	call   0 <per_cpu_ptr>
     5ce:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     5d1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     5d4:	8b 00                	mov    eax,DWORD PTR [eax]
     5d6:	89 c2                	mov    edx,eax
     5d8:	31 c0                	xor    eax,eax
     5da:	89 c6                	mov    esi,eax
     5dc:	89 d7                	mov    edi,edx
     5de:	e8 1d fa ff ff       	call   0 <per_cpu_ptr>
     5e3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     5e6:	05 90 03 00 00       	add    eax,0x390
     5eb:	8b 00                	mov    eax,DWORD PTR [eax]
     5ed:	ba 00 00 00 00       	mov    edx,0x0
     5f2:	09 f0                	or     eax,esi
     5f4:	09 fa                	or     edx,edi
     5f6:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     5f9:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     5fc:	eb 36                	jmp    634 <task_gettime+0xb7>
						rv = (jiffies << 32) | apic_bp_reg(APIC_REG_TMRCURRCNT);
     5fe:	a1 00 00 00 00       	mov    eax,ds:0x0
     603:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     606:	8b 00                	mov    eax,DWORD PTR [eax]
     608:	89 c2                	mov    edx,eax
     60a:	31 c0                	xor    eax,eax
     60c:	b9 90 03 ff ef       	mov    ecx,0xefff0390
     611:	8b 09                	mov    ecx,DWORD PTR [ecx]
     613:	bb 00 00 00 00       	mov    ebx,0x0
     618:	09 c8                	or     eax,ecx
     61a:	09 da                	or     edx,ebx
     61c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     61f:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     622:	eb 10                	jmp    634 <task_gettime+0xb7>
			rv = jiffies;
     624:	a1 00 00 00 00       	mov    eax,ds:0x0
     629:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     62c:	8b 00                	mov    eax,DWORD PTR [eax]
     62e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     631:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		return rv;
     634:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     637:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
}
     63a:	83 c4 14             	add    esp,0x14
     63d:	5b                   	pop    ebx
     63e:	5e                   	pop    esi
     63f:	5f                   	pop    edi
     640:	5d                   	pop    ebp
     641:	c3                   	ret

00000642 <get_task_esp>:
{
     642:	55                   	push   ebp
     643:	89 e5                	mov    ebp,esp
     645:	83 ec 28             	sub    esp,0x28
		stk = get_stack(esp, &sl);
     648:	8d 45 e8             	lea    eax,[ebp-0x18]
     64b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     64f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     652:	89 04 24             	mov    DWORD PTR [esp],eax
     655:	e8 fc ff ff ff       	call   656 <get_task_esp+0x14>
     65a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (stk == -1) {
     65d:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
     661:	75 5f                	jne    6c2 <get_task_esp+0x80>
				if (preempt_needs_init)
     663:	a1 00 00 00 00       	mov    eax,ds:0x0
     668:	85 c0                	test   eax,eax
     66a:	74 07                	je     673 <get_task_esp+0x31>
						return &dummy;
     66c:	b8 60 00 00 00       	mov    eax,0x60
     671:	eb 5c                	jmp    6cf <get_task_esp+0x8d>
				printf("kernel_stacks: %p to %p\n", kernel_stacks.vm_base, kernel_stacks.vm_ptr);
     673:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
     679:	a1 00 00 00 00       	mov    eax,ds:0x0
     67e:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     682:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     686:	c7 04 24 6b 00 00 00 	mov    DWORD PTR [esp],0x6b
     68d:	e8 fc ff ff ff       	call   68e <get_task_esp+0x4c>
				die("unkown stack at %p\n", esp);
     692:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     695:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     699:	c7 44 24 04 84 00 00 00 	mov    DWORD PTR [esp+0x4],0x84
     6a1:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     6a8:	e8 fc ff ff ff       	call   6a9 <get_task_esp+0x67>
     6ad:	e8 fc ff ff ff       	call   6ae <get_task_esp+0x6c>
     6b2:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     6b9:	e8 fc ff ff ff       	call   6ba <get_task_esp+0x78>
     6be:	fa                   	cli
     6bf:	f4                   	hlt
     6c0:	eb fd                	jmp    6bf <get_task_esp+0x7d>
		rv = sl.base;
     6c2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     6c5:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rv--;
     6c8:	83 6d f0 6c          	sub    DWORD PTR [ebp-0x10],0x6c
		return rv;
     6cc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     6cf:	c9                   	leave
     6d0:	c3                   	ret

000006d1 <get_task>:
{
     6d1:	55                   	push   ebp
     6d2:	89 e5                	mov    ebp,esp
     6d4:	83 ec 28             	sub    esp,0x28
		return get_task_esp(&dm);
     6d7:	8d 45 f4             	lea    eax,[ebp-0xc]
     6da:	89 04 24             	mov    DWORD PTR [esp],eax
     6dd:	e8 fc ff ff ff       	call   6de <get_task+0xd>
}
     6e2:	c9                   	leave
     6e3:	c3                   	ret

000006e4 <task_save_state>:
{
     6e4:	55                   	push   ebp
     6e5:	89 e5                	mov    ebp,esp
     6e7:	83 ec 28             	sub    esp,0x28
		if (esp->cs & 3) { /* RPL>0, i.e. call from usermode */
     6ea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6ed:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
     6f0:	83 e0 03             	and    eax,0x3
     6f3:	85 c0                	test   eax,eax
     6f5:	74 57                	je     74e <task_save_state+0x6a>
				st = get_stack(esp, &sl);
     6f7:	8d 45 e8             	lea    eax,[ebp-0x18]
     6fa:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     6fe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     701:	89 04 24             	mov    DWORD PTR [esp],eax
     704:	e8 fc ff ff ff       	call   705 <task_save_state+0x21>
     709:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								(void*)esp->esp_rpl
     70c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     70f:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
				printf("irq0 from usermode with stack at %p\n",
     712:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     716:	c7 04 24 98 00 00 00 	mov    DWORD PTR [esp],0x98
     71d:	e8 fc ff ff ff       	call   71e <task_save_state+0x3a>
				printf("current esp: %p\n", esp);
     722:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     725:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     729:	c7 04 24 bd 00 00 00 	mov    DWORD PTR [esp],0xbd
     730:	e8 fc ff ff ff       	call   731 <task_save_state+0x4d>
				printf("cs: %x\n", esp->cs);
     735:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     738:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
     73b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     73f:	c7 04 24 ce 00 00 00 	mov    DWORD PTR [esp],0xce
     746:	e8 fc ff ff ff       	call   747 <task_save_state+0x63>
				while (1);
     74b:	90                   	nop
     74c:	eb fd                	jmp    74b <task_save_state+0x67>
		} else if ((size_t)esp <= 0x80000 && (size_t)esp > 0x60000) {
     74e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     751:	3d 00 00 08 00       	cmp    eax,0x80000
     756:	77 0a                	ja     762 <task_save_state+0x7e>
     758:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     75b:	3d 00 00 06 00       	cmp    eax,0x60000
     760:	77 4a                	ja     7ac <task_save_state+0xc8>
				st = get_stack(esp, &sl);
     762:	8d 45 e8             	lea    eax,[ebp-0x18]
     765:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     769:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     76c:	89 04 24             	mov    DWORD PTR [esp],eax
     76f:	e8 fc ff ff ff       	call   770 <task_save_state+0x8c>
     774:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (st == -1) {
     777:	83 7d f4 ff          	cmp    DWORD PTR [ebp-0xc],0xffffffff
     77b:	75 0e                	jne    78b <task_save_state+0xa7>
						printf("unrecognized ring0 task!\n");
     77d:	c7 04 24 d6 00 00 00 	mov    DWORD PTR [esp],0xd6
     784:	e8 fc ff ff ff       	call   785 <task_save_state+0xa1>
     789:	eb 21                	jmp    7ac <task_save_state+0xc8>
				t = sl.base;
     78b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     78e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				t--;
     791:	83 6d f0 6c          	sub    DWORD PTR [ebp-0x10],0x6c
				t->ts = esp;
     795:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     798:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     79b:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				t->stop_time = task_gettime();
     79e:	e8 fc ff ff ff       	call   79f <task_save_state+0xbb>
     7a3:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     7a6:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
     7a9:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
}
     7ac:	c9                   	leave
     7ad:	c3                   	ret

000007ae <print_task>:
{
     7ae:	55                   	push   ebp
     7af:	89 e5                	mov    ebp,esp
     7b1:	57                   	push   edi
     7b2:	56                   	push   esi
     7b3:	53                   	push   ebx
     7b4:	81 ec 9c 00 00 00    	sub    esp,0x9c
		char proc_str[5] = "N/A";
     7ba:	c7 45 e3 4e 2f 41 00 	mov    DWORD PTR [ebp-0x1d],0x412f4e
     7c1:	c6 45 e7 00          	mov    BYTE PTR [ebp-0x19],0x0
		if (ts->task_proc != 0xffffffff)
     7c5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7c8:	8b 40 44             	mov    eax,DWORD PTR [eax+0x44]
     7cb:	83 f8 ff             	cmp    eax,0xffffffff
     7ce:	74 25                	je     7f5 <print_task+0x47>
				snprintf(proc_str, 5, "%4u", ts->task_proc);
     7d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7d3:	8b 40 44             	mov    eax,DWORD PTR [eax+0x44]
     7d6:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
     7da:	c7 44 24 08 f0 00 00 00 	mov    DWORD PTR [esp+0x8],0xf0
     7e2:	c7 44 24 04 05 00 00 00 	mov    DWORD PTR [esp+0x4],0x5
     7ea:	8d 45 e3             	lea    eax,[ebp-0x1d]
     7ed:	89 04 24             	mov    DWORD PTR [esp],eax
     7f0:	e8 fc ff ff ff       	call   7f1 <print_task+0x43>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     7f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7f8:	8b 40 68             	mov    eax,DWORD PTR [eax+0x68]
     7fb:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     7fe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     801:	8b 40 64             	mov    eax,DWORD PTR [eax+0x64]
     804:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
     807:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     80a:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     80d:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
     810:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     813:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
     816:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
     819:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     81c:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     81f:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
     822:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     825:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     828:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
				(uint32_t)(ts->ns_acc / 1000000000), ts->ns_per_sec / 1000000,
     82b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     82e:	8b 40 60             	mov    eax,DWORD PTR [eax+0x60]
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     831:	ba 83 de 1b 43       	mov    edx,0x431bde83
     836:	f7 e2                	mul    edx
     838:	c1 ea 12             	shr    edx,0x12
     83b:	89 55 b8             	mov    DWORD PTR [ebp-0x48],edx
				(uint32_t)(ts->ns_acc / 1000000000), ts->ns_per_sec / 1000000,
     83e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     841:	8b 50 54             	mov    edx,DWORD PTR [eax+0x54]
     844:	8b 40 50             	mov    eax,DWORD PTR [eax+0x50]
     847:	c7 44 24 08 00 ca 9a 3b 	mov    DWORD PTR [esp+0x8],0x3b9aca00
     84f:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
     857:	89 04 24             	mov    DWORD PTR [esp],eax
     85a:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     85e:	e8 fc ff ff ff       	call   85f <print_task+0xb1>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     863:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
     866:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     869:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
     86c:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
     86f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     872:	8b 78 28             	mov    edi,DWORD PTR [eax+0x28]
     875:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     878:	8b 70 08             	mov    esi,DWORD PTR [eax+0x8]
				(ts->flags & TIF_YIELDED) ? 'Y' : ' ', proc_str,
     87b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     87e:	8b 00                	mov    eax,DWORD PTR [eax]
     880:	83 e0 02             	and    eax,0x2
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     883:	85 c0                	test   eax,eax
     885:	74 09                	je     890 <print_task+0xe2>
     887:	c7 45 d4 59 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x59
     88e:	eb 07                	jmp    897 <print_task+0xe9>
     890:	c7 45 d4 20 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x20
				(ts->flags & TIF_KERNEL_STACK) ? ((ts->flags & TIF_IDLE) ? 'I' : 'K') : 'U',
     897:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     89a:	8b 00                	mov    eax,DWORD PTR [eax]
     89c:	83 e0 08             	and    eax,0x8
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     89f:	85 c0                	test   eax,eax
     8a1:	74 1a                	je     8bd <print_task+0x10f>
				(ts->flags & TIF_KERNEL_STACK) ? ((ts->flags & TIF_IDLE) ? 'I' : 'K') : 'U',
     8a3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8a6:	8b 00                	mov    eax,DWORD PTR [eax]
     8a8:	83 e0 40             	and    eax,0x40
     8ab:	85 c0                	test   eax,eax
     8ad:	74 07                	je     8b6 <print_task+0x108>
     8af:	bb 49 00 00 00       	mov    ebx,0x49
     8b4:	eb 0c                	jmp    8c2 <print_task+0x114>
     8b6:	bb 4b 00 00 00       	mov    ebx,0x4b
     8bb:	eb 05                	jmp    8c2 <print_task+0x114>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     8bd:	bb 55 00 00 00       	mov    ebx,0x55
				(ts->flags & TIF_RUNNING) ? 'R' : (ts->flags & TIF_EXPIRED) ? 'X' : (ts->flags & TIF_SLEEPING) ? 'S': ' ',
     8c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8c5:	8b 00                	mov    eax,DWORD PTR [eax]
     8c7:	83 e0 10             	and    eax,0x10
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     8ca:	85 c0                	test   eax,eax
     8cc:	75 2f                	jne    8fd <print_task+0x14f>
				(ts->flags & TIF_RUNNING) ? 'R' : (ts->flags & TIF_EXPIRED) ? 'X' : (ts->flags & TIF_SLEEPING) ? 'S': ' ',
     8ce:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8d1:	8b 00                	mov    eax,DWORD PTR [eax]
     8d3:	83 e0 20             	and    eax,0x20
     8d6:	85 c0                	test   eax,eax
     8d8:	75 1c                	jne    8f6 <print_task+0x148>
     8da:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8dd:	8b 00                	mov    eax,DWORD PTR [eax]
     8df:	25 80 00 00 00       	and    eax,0x80
     8e4:	85 c0                	test   eax,eax
     8e6:	74 07                	je     8ef <print_task+0x141>
     8e8:	b9 53 00 00 00       	mov    ecx,0x53
     8ed:	eb 13                	jmp    902 <print_task+0x154>
     8ef:	b9 20 00 00 00       	mov    ecx,0x20
     8f4:	eb 0c                	jmp    902 <print_task+0x154>
     8f6:	b9 58 00 00 00       	mov    ecx,0x58
     8fb:	eb 05                	jmp    902 <print_task+0x154>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     8fd:	b9 52 00 00 00       	mov    ecx,0x52
     902:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     905:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     908:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     90b:	89 44 24 40          	mov    DWORD PTR [esp+0x40],eax
     90f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     912:	89 44 24 3c          	mov    DWORD PTR [esp+0x3c],eax
     916:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     919:	89 44 24 38          	mov    DWORD PTR [esp+0x38],eax
     91d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     920:	89 44 24 34          	mov    DWORD PTR [esp+0x34],eax
     924:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     927:	89 44 24 30          	mov    DWORD PTR [esp+0x30],eax
     92b:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     92e:	89 44 24 2c          	mov    DWORD PTR [esp+0x2c],eax
     932:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     935:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
     939:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
     93c:	89 44 24 24          	mov    DWORD PTR [esp+0x24],eax
     940:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
     943:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
     947:	89 7c 24 1c          	mov    DWORD PTR [esp+0x1c],edi
     94b:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
     94f:	8d 45 e3             	lea    eax,[ebp-0x1d]
     952:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
     956:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     959:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
     95d:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
     961:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     965:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     969:	c7 04 24 f4 00 00 00 	mov    DWORD PTR [esp],0xf4
     970:	e8 fc ff ff ff       	call   971 <print_task+0x1c3>
}
     975:	90                   	nop
     976:	81 c4 9c 00 00 00    	add    esp,0x9c
     97c:	5b                   	pop    ebx
     97d:	5e                   	pop    esi
     97e:	5f                   	pop    edi
     97f:	5d                   	pop    ebp
     980:	c3                   	ret

00000981 <cpu_stat_counter>:
{
     981:	55                   	push   ebp
     982:	89 e5                	mov    ebp,esp
     984:	83 ec 28             	sub    esp,0x28
		if (nproc > 1) {
     987:	a1 00 00 00 00       	mov    eax,ds:0x0
     98c:	83 f8 01             	cmp    eax,0x1
     98f:	76 23                	jbe    9b4 <cpu_stat_counter+0x33>
				struct processor_data* pd = get_cpu_data(id);
     991:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     994:	89 04 24             	mov    DWORD PTR [esp],eax
     997:	e8 fc ff ff ff       	call   998 <cpu_stat_counter+0x17>
     99c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (!pd)
     99f:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     9a3:	75 07                	jne    9ac <cpu_stat_counter+0x2b>
						return NULL;
     9a5:	b8 00 00 00 00       	mov    eax,0x0
     9aa:	eb 0d                	jmp    9b9 <cpu_stat_counter+0x38>
				return pd->ticks;
     9ac:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9af:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     9b2:	eb 05                	jmp    9b9 <cpu_stat_counter+0x38>
				return bp_tick;
     9b4:	a1 00 00 00 00       	mov    eax,ds:0x0
}
     9b9:	c9                   	leave
     9ba:	c3                   	ret

000009bb <cpu_calc_percentages>:
{
     9bb:	55                   	push   ebp
     9bc:	89 e5                	mov    ebp,esp
     9be:	56                   	push   esi
     9bf:	53                   	push   ebx
     9c0:	83 ec 20             	sub    esp,0x20
		struct perf_ctrs* pc = cpu_stat_counter(i);
     9c3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9c6:	89 04 24             	mov    DWORD PTR [esp],eax
     9c9:	e8 fc ff ff ff       	call   9ca <cpu_calc_percentages+0xf>
     9ce:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!pc) {
     9d1:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     9d5:	75 40                	jne    a17 <cpu_calc_percentages+0x5c>
				bzero(&cpu_pcs[i + 1], sizeof(cpu_pcs[i + 1]));
     9d7:	a1 00 00 00 00       	mov    eax,ds:0x0
     9dc:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     9df:	83 c2 01             	add    edx,0x1
     9e2:	c1 e2 05             	shl    edx,0x5
     9e5:	01 d0                	add    eax,edx
     9e7:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
     9ef:	89 04 24             	mov    DWORD PTR [esp],eax
     9f2:	e8 fc ff ff ff       	call   9f3 <cpu_calc_percentages+0x38>
				cpu_pcs[i + 1].vals[0] = 0xffffffff;
     9f7:	a1 00 00 00 00       	mov    eax,ds:0x0
     9fc:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     9ff:	83 c2 01             	add    edx,0x1
     a02:	c1 e2 05             	shl    edx,0x5
     a05:	01 d0                	add    eax,edx
     a07:	c7 00 ff ff ff ff    	mov    DWORD PTR [eax],0xffffffff
				return -1;
     a0d:	b8 ff ff ff ff       	mov    eax,0xffffffff
     a12:	e9 8c 01 00 00       	jmp    ba3 <cpu_calc_percentages+0x1e8>
		cpu_pcs[0].vals[0] += pc->ns_idle_per_sec;
     a17:	a1 00 00 00 00       	mov    eax,ds:0x0
     a1c:	8b 08                	mov    ecx,DWORD PTR [eax]
     a1e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a21:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
     a24:	a1 00 00 00 00       	mov    eax,ds:0x0
     a29:	01 ca                	add    edx,ecx
     a2b:	89 10                	mov    DWORD PTR [eax],edx
		cpu_pcs[0].vals[1] += pc->ns_kernel_per_sec;
     a2d:	a1 00 00 00 00       	mov    eax,ds:0x0
     a32:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
     a35:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a38:	8b 50 3c             	mov    edx,DWORD PTR [eax+0x3c]
     a3b:	a1 00 00 00 00       	mov    eax,ds:0x0
     a40:	01 ca                	add    edx,ecx
     a42:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		cpu_pcs[0].vals[2] += pc->ns_user_per_sec;
     a45:	a1 00 00 00 00       	mov    eax,ds:0x0
     a4a:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
     a4d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a50:	8b 50 40             	mov    edx,DWORD PTR [eax+0x40]
     a53:	a1 00 00 00 00       	mov    eax,ds:0x0
     a58:	01 ca                	add    edx,ecx
     a5a:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		cpu_pcs[0].vals[3] += 1000000000 - pc->ns_idle_per_sec
     a5d:	a1 00 00 00 00       	mov    eax,ds:0x0
     a62:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
     a65:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a68:	8b 48 38             	mov    ecx,DWORD PTR [eax+0x38]
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     a6b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a6e:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
     a71:	01 c1                	add    ecx,eax
     a73:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a76:	8b 40 40             	mov    eax,DWORD PTR [eax+0x40]
     a79:	01 c8                	add    eax,ecx
		cpu_pcs[0].vals[3] += 1000000000 - pc->ns_idle_per_sec
     a7b:	29 c2                	sub    edx,eax
     a7d:	a1 00 00 00 00       	mov    eax,ds:0x0
     a82:	81 c2 00 ca 9a 3b    	add    edx,0x3b9aca00
     a88:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		cpu_pcs[i + 1].vals[0] = pc->ns_idle_per_sec;
     a8b:	a1 00 00 00 00       	mov    eax,ds:0x0
     a90:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     a93:	83 c2 01             	add    edx,0x1
     a96:	c1 e2 05             	shl    edx,0x5
     a99:	01 c2                	add    edx,eax
     a9b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a9e:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
     aa1:	89 02                	mov    DWORD PTR [edx],eax
		cpu_pcs[i + 1].vals[1] = pc->ns_kernel_per_sec;
     aa3:	a1 00 00 00 00       	mov    eax,ds:0x0
     aa8:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     aab:	83 c2 01             	add    edx,0x1
     aae:	c1 e2 05             	shl    edx,0x5
     ab1:	01 c2                	add    edx,eax
     ab3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ab6:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
     ab9:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
		cpu_pcs[i + 1].vals[2] = pc->ns_user_per_sec;
     abc:	a1 00 00 00 00       	mov    eax,ds:0x0
     ac1:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     ac4:	83 c2 01             	add    edx,0x1
     ac7:	c1 e2 05             	shl    edx,0x5
     aca:	01 c2                	add    edx,eax
     acc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     acf:	8b 40 40             	mov    eax,DWORD PTR [eax+0x40]
     ad2:	89 42 08             	mov    DWORD PTR [edx+0x8],eax
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     ad5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ad8:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     adb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ade:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
     ae1:	01 c2                	add    edx,eax
     ae3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ae6:	8b 40 40             	mov    eax,DWORD PTR [eax+0x40]
     ae9:	8d 0c 02             	lea    ecx,[edx+eax*1]
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     aec:	a1 00 00 00 00       	mov    eax,ds:0x0
     af1:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     af4:	83 c2 01             	add    edx,0x1
     af7:	c1 e2 05             	shl    edx,0x5
     afa:	01 d0                	add    eax,edx
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     afc:	ba 00 ca 9a 3b       	mov    edx,0x3b9aca00
     b01:	29 ca                	sub    edx,ecx
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     b03:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		for (size_t j = 0; j < 4; j++) {
     b06:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     b0d:	e9 82 00 00 00       	jmp    b94 <cpu_calc_percentages+0x1d9>
				const uint32_t ntot = 10000000;
     b12:	c7 45 ec 80 96 98 00 	mov    DWORD PTR [ebp-0x14],0x989680
				uint32_t val = cpu_pcs[i + 1].vals[j];
     b19:	a1 00 00 00 00       	mov    eax,ds:0x0
     b1e:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     b21:	83 c2 01             	add    edx,0x1
     b24:	c1 e2 05             	shl    edx,0x5
     b27:	01 c2                	add    edx,eax
     b29:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b2c:	8b 04 82             	mov    eax,DWORD PTR [edx+eax*4]
     b2f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				cpu_pcs[i + 1].vals[j] = val / ntot;
     b32:	a1 00 00 00 00       	mov    eax,ds:0x0
     b37:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     b3a:	83 c2 01             	add    edx,0x1
     b3d:	c1 e2 05             	shl    edx,0x5
     b40:	8d 0c 10             	lea    ecx,[eax+edx*1]
     b43:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     b46:	ba 00 00 00 00       	mov    edx,0x0
     b4b:	f7 75 ec             	div    DWORD PTR [ebp-0x14]
     b4e:	89 c2                	mov    edx,eax
     b50:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b53:	89 14 81             	mov    DWORD PTR [ecx+eax*4],edx
				cpu_pcs[i + 1].vals[4 + j] = 10 * (val % ntot) / ntot;
     b56:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     b59:	ba 00 00 00 00       	mov    edx,0x0
     b5e:	f7 75 ec             	div    DWORD PTR [ebp-0x14]
     b61:	89 d0                	mov    eax,edx
     b63:	c1 e0 02             	shl    eax,0x2
     b66:	01 d0                	add    eax,edx
     b68:	01 c0                	add    eax,eax
     b6a:	89 c6                	mov    esi,eax
     b6c:	a1 00 00 00 00       	mov    eax,ds:0x0
     b71:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     b74:	83 c2 01             	add    edx,0x1
     b77:	c1 e2 05             	shl    edx,0x5
     b7a:	8d 0c 10             	lea    ecx,[eax+edx*1]
     b7d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b80:	8d 58 04             	lea    ebx,[eax+0x4]
     b83:	89 f0                	mov    eax,esi
     b85:	ba 00 00 00 00       	mov    edx,0x0
     b8a:	f7 75 ec             	div    DWORD PTR [ebp-0x14]
     b8d:	89 04 99             	mov    DWORD PTR [ecx+ebx*4],eax
		for (size_t j = 0; j < 4; j++) {
     b90:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     b94:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
     b98:	0f 86 74 ff ff ff    	jbe    b12 <cpu_calc_percentages+0x157>
		return 0;
     b9e:	b8 00 00 00 00       	mov    eax,0x0
}
     ba3:	83 c4 20             	add    esp,0x20
     ba6:	5b                   	pop    ebx
     ba7:	5e                   	pop    esi
     ba8:	5d                   	pop    ebp
     ba9:	c3                   	ret

00000baa <cpu_do_stats>:
{
     baa:	55                   	push   ebp
     bab:	89 e5                	mov    ebp,esp
     bad:	53                   	push   ebx
     bae:	83 ec 34             	sub    esp,0x34
		if (!cpu_pcs || (nproc != nproc_alloc)) {
     bb1:	a1 00 00 00 00       	mov    eax,ds:0x0
     bb6:	85 c0                	test   eax,eax
     bb8:	74 0f                	je     bc9 <cpu_do_stats+0x1f>
     bba:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     bc0:	a1 00 00 00 00       	mov    eax,ds:0x0
     bc5:	39 c2                	cmp    edx,eax
     bc7:	74 38                	je     c01 <cpu_do_stats+0x57>
				if (cpu_pcs)
     bc9:	a1 00 00 00 00       	mov    eax,ds:0x0
     bce:	85 c0                	test   eax,eax
     bd0:	74 0d                	je     bdf <cpu_do_stats+0x35>
						kfree(cpu_pcs);
     bd2:	a1 00 00 00 00       	mov    eax,ds:0x0
     bd7:	89 04 24             	mov    DWORD PTR [esp],eax
     bda:	e8 fc ff ff ff       	call   bdb <cpu_do_stats+0x31>
				cpu_pcs = kmalloc((nproc + 1) * sizeof(*cpu_pcs));
     bdf:	a1 00 00 00 00       	mov    eax,ds:0x0
     be4:	83 c0 01             	add    eax,0x1
     be7:	c1 e0 05             	shl    eax,0x5
     bea:	89 04 24             	mov    DWORD PTR [esp],eax
     bed:	e8 fc ff ff ff       	call   bee <cpu_do_stats+0x44>
     bf2:	a3 00 00 00 00       	mov    ds:0x0,eax
				nproc_alloc = nproc;
     bf7:	a1 00 00 00 00       	mov    eax,ds:0x0
     bfc:	a3 00 00 00 00       	mov    ds:0x0,eax
		bzero(&cpu_pcs[0], sizeof(cpu_pcs[0]));
     c01:	a1 00 00 00 00       	mov    eax,ds:0x0
     c06:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
     c0e:	89 04 24             	mov    DWORD PTR [esp],eax
     c11:	e8 fc ff ff ff       	call   c12 <cpu_do_stats+0x68>
		size_t nval = 0; uint32_t ntot;
     c16:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		for (size_t i = 0; i < nproc; i++) {
     c1d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     c24:	eb 1b                	jmp    c41 <cpu_do_stats+0x97>
				if (-1 == cpu_calc_percentages(i))
     c26:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c29:	89 04 24             	mov    DWORD PTR [esp],eax
     c2c:	e8 fc ff ff ff       	call   c2d <cpu_do_stats+0x83>
     c31:	83 f8 ff             	cmp    eax,0xffffffff
     c34:	74 06                	je     c3c <cpu_do_stats+0x92>
				nval++;
     c36:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     c3a:	eb 01                	jmp    c3d <cpu_do_stats+0x93>
						continue;
     c3c:	90                   	nop
		for (size_t i = 0; i < nproc; i++) {
     c3d:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     c41:	a1 00 00 00 00       	mov    eax,ds:0x0
     c46:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     c49:	72 db                	jb     c26 <cpu_do_stats+0x7c>
		nproc_rep = nval;
     c4b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c4e:	a3 00 00 00 00       	mov    ds:0x0,eax
		ntot = 10000000 * nval; /* div 100 */
     c53:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c56:	69 c0 80 96 98 00    	imul   eax,eax,0x989680
     c5c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (!ntot)
     c5f:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     c63:	74 6b                	je     cd0 <cpu_do_stats+0x126>
		for (size_t i = 0; i < 4; i++) {
     c65:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     c6c:	eb 5a                	jmp    cc8 <cpu_do_stats+0x11e>
				uint32_t val = cpu_pcs[0].vals[i];
     c6e:	a1 00 00 00 00       	mov    eax,ds:0x0
     c73:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     c76:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
     c79:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				cpu_pcs[0].vals[i] = val / ntot;
     c7c:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     c82:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     c85:	ba 00 00 00 00       	mov    edx,0x0
     c8a:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
     c8d:	89 c2                	mov    edx,eax
     c8f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     c92:	89 14 81             	mov    DWORD PTR [ecx+eax*4],edx
				cpu_pcs[0].vals[4 + i] = 10 * (val % ntot) / ntot;
     c95:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     c98:	ba 00 00 00 00       	mov    edx,0x0
     c9d:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
     ca0:	89 d0                	mov    eax,edx
     ca2:	c1 e0 02             	shl    eax,0x2
     ca5:	01 d0                	add    eax,edx
     ca7:	01 c0                	add    eax,eax
     ca9:	89 c2                	mov    edx,eax
     cab:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     cb1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     cb4:	8d 58 04             	lea    ebx,[eax+0x4]
     cb7:	89 d0                	mov    eax,edx
     cb9:	ba 00 00 00 00       	mov    edx,0x0
     cbe:	f7 75 e8             	div    DWORD PTR [ebp-0x18]
     cc1:	89 04 99             	mov    DWORD PTR [ecx+ebx*4],eax
		for (size_t i = 0; i < 4; i++) {
     cc4:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     cc8:	83 7d ec 03          	cmp    DWORD PTR [ebp-0x14],0x3
     ccc:	76 a0                	jbe    c6e <cpu_do_stats+0xc4>
     cce:	eb 01                	jmp    cd1 <cpu_do_stats+0x127>
			return; /* div0 otherwise */
     cd0:	90                   	nop
}
     cd1:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     cd4:	c9                   	leave
     cd5:	c3                   	ret

00000cd6 <print_cpus>:
{
     cd6:	55                   	push   ebp
     cd7:	89 e5                	mov    ebp,esp
     cd9:	57                   	push   edi
     cda:	56                   	push   esi
     cdb:	53                   	push   ebx
     cdc:	83 ec 6c             	sub    esp,0x6c
		printf("listing cpus: %u total, %u provided data\n", nproc, nproc_rep);
     cdf:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     ce5:	a1 00 00 00 00       	mov    eax,ds:0x0
     cea:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     cee:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     cf2:	c7 04 24 34 01 00 00 	mov    DWORD PTR [esp],0x134
     cf9:	e8 fc ff ff ff       	call   cfa <print_cpus+0x24>
				cpu_pcs[0].vals[0], cpu_pcs[0].vals[4]); /* i pi */
     cfe:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     d03:	8b 48 10             	mov    ecx,DWORD PTR [eax+0x10]
				cpu_pcs[0].vals[0], cpu_pcs[0].vals[4]); /* i pi */
     d06:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     d0b:	8b 00                	mov    eax,DWORD PTR [eax]
     d0d:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				cpu_pcs[0].vals[3], cpu_pcs[0].vals[7], /* ni pni */
     d10:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     d15:	8b 58 1c             	mov    ebx,DWORD PTR [eax+0x1c]
     d18:	89 5d d0             	mov    DWORD PTR [ebp-0x30],ebx
				cpu_pcs[0].vals[3], cpu_pcs[0].vals[7], /* ni pni */
     d1b:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     d20:	8b 78 0c             	mov    edi,DWORD PTR [eax+0xc]
				cpu_pcs[0].vals[1], cpu_pcs[0].vals[5], /* k pk */
     d23:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     d28:	8b 70 14             	mov    esi,DWORD PTR [eax+0x14]
				cpu_pcs[0].vals[1], cpu_pcs[0].vals[5], /* k pk */
     d2b:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     d30:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
				cpu_pcs[0].vals[2], cpu_pcs[0].vals[6], /* u pu */
     d33:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     d38:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
				cpu_pcs[0].vals[2], cpu_pcs[0].vals[6], /* u pu */
     d3b:	a1 00 00 00 00       	mov    eax,ds:0x0
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     d40:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     d43:	89 4c 24 20          	mov    DWORD PTR [esp+0x20],ecx
     d47:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     d4a:	89 4c 24 1c          	mov    DWORD PTR [esp+0x1c],ecx
     d4e:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
     d51:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
     d55:	89 7c 24 14          	mov    DWORD PTR [esp+0x14],edi
     d59:	89 74 24 10          	mov    DWORD PTR [esp+0x10],esi
     d5d:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
     d61:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     d65:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     d69:	c7 04 24 60 01 00 00 	mov    DWORD PTR [esp],0x160
     d70:	e8 fc ff ff ff       	call   d71 <print_cpus+0x9b>
		for (size_t i = 0; i < nproc; i++) {
     d75:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
     d7c:	e9 3e 01 00 00       	jmp    ebf <print_cpus+0x1e9>
				if (cpu_pcs[i + 1].vals[0] == 0xffffffff) {
     d81:	a1 00 00 00 00       	mov    eax,ds:0x0
     d86:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     d89:	83 c2 01             	add    edx,0x1
     d8c:	c1 e2 05             	shl    edx,0x5
     d8f:	01 d0                	add    eax,edx
     d91:	8b 00                	mov    eax,DWORD PTR [eax]
     d93:	83 f8 ff             	cmp    eax,0xffffffff
     d96:	75 11                	jne    da9 <print_cpus+0xd3>
						printf("%%Cpu%-3u: N/A\n");
     d98:	c7 04 24 9a 01 00 00 	mov    DWORD PTR [esp],0x19a
     d9f:	e8 fc ff ff ff       	call   da0 <print_cpus+0xca>
						continue;
     da4:	e9 12 01 00 00       	jmp    ebb <print_cpus+0x1e5>
				struct perf_ctrs* pc = get_cpu_data(i)->ticks;
     da9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     dac:	89 04 24             	mov    DWORD PTR [esp],eax
     daf:	e8 fc ff ff ff       	call   db0 <print_cpus+0xda>
     db4:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     db7:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     dba:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     dbd:	8b 40 44             	mov    eax,DWORD PTR [eax+0x44]
     dc0:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     dc3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     dc6:	8b 70 48             	mov    esi,DWORD PTR [eax+0x48]
     dc9:	89 75 d0             	mov    DWORD PTR [ebp-0x30],esi
						cpu_pcs[i + 1].vals[0], cpu_pcs[i + 1].vals[4], /* i pi */
     dcc:	a1 00 00 00 00       	mov    eax,ds:0x0
     dd1:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     dd4:	83 c2 01             	add    edx,0x1
     dd7:	c1 e2 05             	shl    edx,0x5
     dda:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     ddc:	8b 78 10             	mov    edi,DWORD PTR [eax+0x10]
     ddf:	89 7d cc             	mov    DWORD PTR [ebp-0x34],edi
						cpu_pcs[i + 1].vals[0], cpu_pcs[i + 1].vals[4], /* i pi */
     de2:	a1 00 00 00 00       	mov    eax,ds:0x0
     de7:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     dea:	83 c2 01             	add    edx,0x1
     ded:	c1 e2 05             	shl    edx,0x5
     df0:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     df2:	8b 18                	mov    ebx,DWORD PTR [eax]
     df4:	89 5d c8             	mov    DWORD PTR [ebp-0x38],ebx
						cpu_pcs[i + 1].vals[3], cpu_pcs[i + 1].vals[7], /* ni pni */
     df7:	a1 00 00 00 00       	mov    eax,ds:0x0
     dfc:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     dff:	83 c2 01             	add    edx,0x1
     e02:	c1 e2 05             	shl    edx,0x5
     e05:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     e07:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
     e0a:	89 4d c4             	mov    DWORD PTR [ebp-0x3c],ecx
						cpu_pcs[i + 1].vals[3], cpu_pcs[i + 1].vals[7], /* ni pni */
     e0d:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     e13:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e16:	83 c0 01             	add    eax,0x1
     e19:	c1 e0 05             	shl    eax,0x5
     e1c:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     e1e:	8b 78 0c             	mov    edi,DWORD PTR [eax+0xc]
						cpu_pcs[i + 1].vals[1], cpu_pcs[i + 1].vals[5], /* k pk */
     e21:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     e27:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e2a:	83 c0 01             	add    eax,0x1
     e2d:	c1 e0 05             	shl    eax,0x5
     e30:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     e32:	8b 70 14             	mov    esi,DWORD PTR [eax+0x14]
						cpu_pcs[i + 1].vals[1], cpu_pcs[i + 1].vals[5], /* k pk */
     e35:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     e3b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e3e:	83 c0 01             	add    eax,0x1
     e41:	c1 e0 05             	shl    eax,0x5
     e44:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     e46:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
						cpu_pcs[i + 1].vals[2], cpu_pcs[i + 1].vals[6], /* u pu */
     e49:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     e4f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e52:	83 c0 01             	add    eax,0x1
     e55:	c1 e0 05             	shl    eax,0x5
     e58:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     e5a:	8b 48 18             	mov    ecx,DWORD PTR [eax+0x18]
						cpu_pcs[i + 1].vals[2], cpu_pcs[i + 1].vals[6], /* u pu */
     e5d:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     e63:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e66:	83 c0 01             	add    eax,0x1
     e69:	c1 e0 05             	shl    eax,0x5
     e6c:	01 d0                	add    eax,edx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     e6e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e71:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     e74:	89 54 24 2c          	mov    DWORD PTR [esp+0x2c],edx
     e78:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     e7b:	89 54 24 28          	mov    DWORD PTR [esp+0x28],edx
     e7f:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     e82:	89 54 24 24          	mov    DWORD PTR [esp+0x24],edx
     e86:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
     e89:	89 54 24 20          	mov    DWORD PTR [esp+0x20],edx
     e8d:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     e90:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
     e94:	89 7c 24 18          	mov    DWORD PTR [esp+0x18],edi
     e98:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
     e9c:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
     ea0:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     ea4:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     ea8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     eab:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     eaf:	c7 04 24 ac 01 00 00 	mov    DWORD PTR [esp],0x1ac
     eb6:	e8 fc ff ff ff       	call   eb7 <print_cpus+0x1e1>
		for (size_t i = 0; i < nproc; i++) {
     ebb:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
     ebf:	a1 00 00 00 00       	mov    eax,ds:0x0
     ec4:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
     ec7:	0f 82 b4 fe ff ff    	jb     d81 <print_cpus+0xab>
}
     ecd:	90                   	nop
     ece:	90                   	nop
     ecf:	83 c4 6c             	add    esp,0x6c
     ed2:	5b                   	pop    ebx
     ed3:	5e                   	pop    esi
     ed4:	5f                   	pop    edi
     ed5:	5d                   	pop    ebp
     ed6:	c3                   	ret

00000ed7 <print_tasks>:
{
     ed7:	55                   	push   ebp
     ed8:	89 e5                	mov    ebp,esp
     eda:	53                   	push   ebx
     edb:	83 ec 34             	sub    esp,0x34
		const char* md = "";
     ede:	c7 45 f4 fd 01 00 00 	mov    DWORD PTR [ebp-0xc],0x1fd
		if (cpu.invariant_tsc)
     ee5:	a1 6c 00 00 00       	mov    eax,ds:0x6c
     eea:	85 c0                	test   eax,eax
     eec:	74 09                	je     ef7 <print_tasks+0x20>
				md = "inv_tsc";
     eee:	c7 45 f4 fe 01 00 00 	mov    DWORD PTR [ebp-0xc],0x1fe
     ef5:	eb 1e                	jmp    f15 <print_tasks+0x3e>
		else if (cpu.has_apic)
     ef7:	0f b6 05 59 00 00 00 	movzx  eax,BYTE PTR ds:0x59
     efe:	83 e0 02             	and    eax,0x2
     f01:	84 c0                	test   al,al
     f03:	74 09                	je     f0e <print_tasks+0x37>
				md = "apic timer";
     f05:	c7 45 f4 06 02 00 00 	mov    DWORD PTR [ebp-0xc],0x206
     f0c:	eb 07                	jmp    f15 <print_tasks+0x3e>
				md = "PIT ticks";
     f0e:	c7 45 f4 11 02 00 00 	mov    DWORD PTR [ebp-0xc],0x211
		printf("Tasks:%4u total,%4u running,%4u pending,%4u sleeping\n",
     f15:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
     f1b:	8b 0d 08 00 00 00    	mov    ecx,DWORD PTR ds:0x8
     f21:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     f27:	a1 00 00 00 00       	mov    eax,ds:0x0
     f2c:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
     f30:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     f34:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     f38:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     f3c:	c7 04 24 1c 02 00 00 	mov    DWORD PTR [esp],0x21c
     f43:	e8 fc ff ff ff       	call   f44 <print_tasks+0x6d>
		printf("Task time:%6u secs total, %4u ms last sec, mode: %s\n",
     f48:	8b 15 10 00 00 00    	mov    edx,DWORD PTR ds:0x10
     f4e:	a1 0c 00 00 00       	mov    eax,ds:0xc
     f53:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     f56:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     f5a:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     f5e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     f62:	c7 04 24 54 02 00 00 	mov    DWORD PTR [esp],0x254
     f69:	e8 fc ff ff ff       	call   f6a <print_tasks+0x93>
		print_cpus();
     f6e:	e8 fc ff ff ff       	call   f6f <print_tasks+0x98>
		printf("listing tasks: %u total" STAT_COUNTER("  major rotations: %u")  "\n", n_tks STAT_ARG(sched_mr_count));
     f73:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
     f79:	a1 00 00 00 00       	mov    eax,ds:0x0
     f7e:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     f82:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     f86:	c7 04 24 8c 02 00 00 	mov    DWORD PTR [esp],0x28c
     f8d:	e8 fc ff ff ff       	call   f8e <print_tasks+0xb7>
		printf("ID FLG PROC STACK    PRIORITY  RUNTIME[ms] RUNTIME      QTA NAME        " STAT_COUNTER("SCHED  ") "\n"
     f92:	c7 04 24 bc 02 00 00 	mov    DWORD PTR [esp],0x2bc
     f99:	e8 fc ff ff ff       	call   f9a <print_tasks+0xc3>
		for (size_t i = 0; i < n_tks; i++)
     f9e:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     fa5:	eb 16                	jmp    fbd <print_tasks+0xe6>
				print_task(tks[i]);
     fa7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     faa:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     fb1:	89 04 24             	mov    DWORD PTR [esp],eax
     fb4:	e8 fc ff ff ff       	call   fb5 <print_tasks+0xde>
		for (size_t i = 0; i < n_tks; i++)
     fb9:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     fbd:	a1 00 00 00 00       	mov    eax,ds:0x0
     fc2:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     fc5:	72 e0                	jb     fa7 <print_tasks+0xd0>
}
     fc7:	90                   	nop
     fc8:	90                   	nop
     fc9:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     fcc:	c9                   	leave
     fcd:	c3                   	ret

00000fce <task_do_stats>:
{
     fce:	55                   	push   ebp
     fcf:	89 e5                	mov    ebp,esp
     fd1:	53                   	push   ebx
     fd2:	83 ec 24             	sub    esp,0x24
		bzero(&task_stats, sizeof(task_stats));
     fd5:	c7 44 24 04 14 00 00 00 	mov    DWORD PTR [esp+0x4],0x14
     fdd:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     fe4:	e8 fc ff ff ff       	call   fe5 <task_do_stats+0x17>
		for (size_t i = 0; i < n_tks; i++) {
     fe9:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     ff0:	e9 04 01 00 00       	jmp    10f9 <task_do_stats+0x12b>
				struct tsi* t = tks[i];
     ff5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ff8:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     fff:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (!t)
    1002:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    1006:	0f 84 e8 00 00 00    	je     10f4 <task_do_stats+0x126>
				t->run_time_sec = t->run_time - t->sec_run_time;
    100c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    100f:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1012:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1015:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1018:	29 c2                	sub    edx,eax
    101a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    101d:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
				t->sec_run_time = t->run_time;
    1020:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1023:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1026:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1029:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
				t->ns_per_sec = t->ns_acc - t->sec_ns_acc;
    102c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    102f:	8b 50 54             	mov    edx,DWORD PTR [eax+0x54]
    1032:	8b 40 50             	mov    eax,DWORD PTR [eax+0x50]
    1035:	89 c1                	mov    ecx,eax
    1037:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    103a:	8b 50 5c             	mov    edx,DWORD PTR [eax+0x5c]
    103d:	8b 40 58             	mov    eax,DWORD PTR [eax+0x58]
    1040:	29 c1                	sub    ecx,eax
    1042:	89 ca                	mov    edx,ecx
    1044:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1047:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
				t->sec_ns_acc = t->ns_acc;
    104a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    104d:	8b 50 54             	mov    edx,DWORD PTR [eax+0x54]
    1050:	8b 40 50             	mov    eax,DWORD PTR [eax+0x50]
    1053:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
    1056:	89 41 58             	mov    DWORD PTR [ecx+0x58],eax
    1059:	89 51 5c             	mov    DWORD PTR [ecx+0x5c],edx
				if (t->flags & TIF_RUNNING)
    105c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    105f:	8b 00                	mov    eax,DWORD PTR [eax]
    1061:	83 e0 10             	and    eax,0x10
    1064:	85 c0                	test   eax,eax
    1066:	74 0f                	je     1077 <task_do_stats+0xa9>
						task_stats.n_running++;
    1068:	a1 00 00 00 00       	mov    eax,ds:0x0
    106d:	83 c0 01             	add    eax,0x1
    1070:	a3 00 00 00 00       	mov    ds:0x0,eax
    1075:	eb 2a                	jmp    10a1 <task_do_stats+0xd3>
				else if (t->flags & TIF_SLEEPING)
    1077:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    107a:	8b 00                	mov    eax,DWORD PTR [eax]
    107c:	25 80 00 00 00       	and    eax,0x80
    1081:	85 c0                	test   eax,eax
    1083:	74 0f                	je     1094 <task_do_stats+0xc6>
						task_stats.n_sleeping++;
    1085:	a1 04 00 00 00       	mov    eax,ds:0x4
    108a:	83 c0 01             	add    eax,0x1
    108d:	a3 04 00 00 00       	mov    ds:0x4,eax
    1092:	eb 0d                	jmp    10a1 <task_do_stats+0xd3>
						task_stats.n_pending++;
    1094:	a1 08 00 00 00       	mov    eax,ds:0x8
    1099:	83 c0 01             	add    eax,0x1
    109c:	a3 08 00 00 00       	mov    ds:0x8,eax
				task_stats.tot_runtime += (uint32_t)(t->ns_acc / 1000000000llu);
    10a1:	8b 1d 0c 00 00 00    	mov    ebx,DWORD PTR ds:0xc
    10a7:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    10aa:	8b 50 54             	mov    edx,DWORD PTR [eax+0x54]
    10ad:	8b 40 50             	mov    eax,DWORD PTR [eax+0x50]
    10b0:	c7 44 24 08 00 ca 9a 3b 	mov    DWORD PTR [esp+0x8],0x3b9aca00
    10b8:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    10c0:	89 04 24             	mov    DWORD PTR [esp],eax
    10c3:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    10c7:	e8 fc ff ff ff       	call   10c8 <task_do_stats+0xfa>
    10cc:	01 d8                	add    eax,ebx
    10ce:	a3 0c 00 00 00       	mov    ds:0xc,eax
				task_stats.sec_runtime += t->ns_per_sec / 1000000;
    10d3:	8b 0d 10 00 00 00    	mov    ecx,DWORD PTR ds:0x10
    10d9:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    10dc:	8b 40 60             	mov    eax,DWORD PTR [eax+0x60]
    10df:	ba 83 de 1b 43       	mov    edx,0x431bde83
    10e4:	f7 e2                	mul    edx
    10e6:	89 d0                	mov    eax,edx
    10e8:	c1 e8 12             	shr    eax,0x12
    10eb:	01 c8                	add    eax,ecx
    10ed:	a3 10 00 00 00       	mov    ds:0x10,eax
    10f2:	eb 01                	jmp    10f5 <task_do_stats+0x127>
						continue;
    10f4:	90                   	nop
		for (size_t i = 0; i < n_tks; i++) {
    10f5:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    10f9:	a1 00 00 00 00       	mov    eax,ds:0x0
    10fe:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    1101:	0f 82 ee fe ff ff    	jb     ff5 <task_do_stats+0x27>
		for (size_t i = 0; i < nproc; i++) {
    1107:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    110e:	e9 cf 00 00 00       	jmp    11e2 <task_do_stats+0x214>
				struct perf_ctrs* pc = cpu_stat_counter(i);
    1113:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1116:	89 04 24             	mov    DWORD PTR [esp],eax
    1119:	e8 fc ff ff ff       	call   111a <task_do_stats+0x14c>
    111e:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!pc)
    1121:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1125:	0f 84 b2 00 00 00    	je     11dd <task_do_stats+0x20f>
				pc->ns_idle_per_sec = pc->ns_idle - pc->sec_ns_idle;
    112b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    112e:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1131:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1134:	89 c1                	mov    ecx,eax
    1136:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1139:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    113c:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    113f:	29 c1                	sub    ecx,eax
    1141:	89 ca                	mov    edx,ecx
    1143:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1146:	89 50 38             	mov    DWORD PTR [eax+0x38],edx
				pc->sec_ns_idle = pc->ns_idle;
    1149:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    114c:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    114f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1152:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1155:	89 41 20             	mov    DWORD PTR [ecx+0x20],eax
    1158:	89 51 24             	mov    DWORD PTR [ecx+0x24],edx
				pc->ns_user_per_sec = pc->ns_user - pc->sec_ns_user;
    115b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    115e:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    1161:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1164:	89 c1                	mov    ecx,eax
    1166:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1169:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    116c:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    116f:	89 ca                	mov    edx,ecx
    1171:	29 c2                	sub    edx,eax
    1173:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1176:	89 50 40             	mov    DWORD PTR [eax+0x40],edx
				pc->sec_ns_user = pc->ns_user;
    1179:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    117c:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    117f:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1182:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1185:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
    1188:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
				pc->ns_kernel_per_sec = pc->ns_kernel - pc->sec_ns_kernel;
    118b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    118e:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    1191:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1194:	89 c1                	mov    ecx,eax
    1196:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1199:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    119c:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    119f:	29 c1                	sub    ecx,eax
    11a1:	89 ca                	mov    edx,ecx
    11a3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11a6:	89 50 3c             	mov    DWORD PTR [eax+0x3c],edx
				pc->sec_ns_kernel = pc->ns_kernel;
    11a9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11ac:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    11af:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    11b2:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    11b5:	89 41 28             	mov    DWORD PTR [ecx+0x28],eax
    11b8:	89 51 2c             	mov    DWORD PTR [ecx+0x2c],edx
				pc->n_times_per_sec = pc->n_times - pc->sec_n_times;
    11bb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11be:	8b 50 44             	mov    edx,DWORD PTR [eax+0x44]
    11c1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11c4:	8b 40 4c             	mov    eax,DWORD PTR [eax+0x4c]
    11c7:	29 c2                	sub    edx,eax
    11c9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11cc:	89 50 48             	mov    DWORD PTR [eax+0x48],edx
				pc->sec_n_times = pc->n_times;
    11cf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11d2:	8b 50 44             	mov    edx,DWORD PTR [eax+0x44]
    11d5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11d8:	89 50 4c             	mov    DWORD PTR [eax+0x4c],edx
    11db:	eb 01                	jmp    11de <task_do_stats+0x210>
						continue;
    11dd:	90                   	nop
		for (size_t i = 0; i < nproc; i++) {
    11de:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    11e2:	a1 00 00 00 00       	mov    eax,ds:0x0
    11e7:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    11ea:	0f 82 23 ff ff ff    	jb     1113 <task_do_stats+0x145>
		cpu_do_stats();
    11f0:	e8 fc ff ff ff       	call   11f1 <task_do_stats+0x223>
}
    11f5:	90                   	nop
    11f6:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    11f9:	c9                   	leave
    11fa:	c3                   	ret

000011fb <task_initfunc>:
{
    11fb:	55                   	push   ebp
    11fc:	89 e5                	mov    ebp,esp
    11fe:	83 ec 28             	sub    esp,0x28
		asm volatile("mov %%eax, %0" : "=rm" (fun) );
    1201:	89 c0                	mov    eax,eax
    1203:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		asm volatile("mov %%ecx, %0" : "=rm" (arg) );
    1206:	89 c8                	mov    eax,ecx
    1208:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		asm ("sti");
    120b:	fb                   	sti
		fun(arg);
    120c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    120f:	89 04 24             	mov    DWORD PTR [esp],eax
    1212:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1215:	ff d0                	call   eax
		get_task()->flags |= TIF_DEALLOCATE;
    1217:	e8 fc ff ff ff       	call   1218 <task_initfunc+0x1d>
    121c:	8b 10                	mov    edx,DWORD PTR [eax]
    121e:	83 ca 04             	or     edx,0x4
    1221:	89 10                	mov    DWORD PTR [eax],edx
		task_yield();
    1223:	e8 fc ff ff ff       	call   1224 <task_initfunc+0x29>
				cprintf(KFMT_WARN, "Deallocated task is rescheduled. This should never happen!\n");
    1228:	c7 44 24 04 60 03 00 00 	mov    DWORD PTR [esp+0x4],0x360
    1230:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    1237:	e8 fc ff ff ff       	call   1238 <task_initfunc+0x3d>
				task_yield();
    123c:	e8 fc ff ff ff       	call   123d <task_initfunc+0x42>
				cprintf(KFMT_WARN, "Deallocated task is rescheduled. This should never happen!\n");
    1241:	90                   	nop
    1242:	eb e4                	jmp    1228 <task_initfunc+0x2d>

00001244 <task_spawn_named>:
{
    1244:	55                   	push   ebp
    1245:	89 e5                	mov    ebp,esp
    1247:	57                   	push   edi
    1248:	56                   	push   esi
    1249:	53                   	push   ebx
    124a:	81 ec ac 00 00 00    	sub    esp,0xac
		if (n_tks < 128) {
    1250:	a1 00 00 00 00       	mov    eax,ds:0x0
    1255:	83 f8 7f             	cmp    eax,0x7f
    1258:	0f 87 ed 01 00 00    	ja     144b <task_spawn_named+0x207>
				struct tsi ts = {0}; int flg;
    125e:	8d 95 60 ff ff ff    	lea    edx,[ebp-0xa0]
    1264:	b8 00 00 00 00       	mov    eax,0x0
    1269:	b9 1b 00 00 00       	mov    ecx,0x1b
    126e:	89 d7                	mov    edi,edx
    1270:	f3 ab                	rep stos DWORD PTR es:[edi],eax
				void* stk = alloc_stack();
    1272:	e8 fc ff ff ff       	call   1273 <task_spawn_named+0x2f>
    1277:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (!stk) {
    127a:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    127e:	75 29                	jne    12a9 <task_spawn_named+0x65>
						die("Failed to alloc stack!\n");
    1280:	c7 44 24 04 9c 03 00 00 	mov    DWORD PTR [esp+0x4],0x39c
    1288:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    128f:	e8 fc ff ff ff       	call   1290 <task_spawn_named+0x4c>
    1294:	e8 fc ff ff ff       	call   1295 <task_spawn_named+0x51>
    1299:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    12a0:	e8 fc ff ff ff       	call   12a1 <task_spawn_named+0x5d>
    12a5:	fa                   	cli
    12a6:	f4                   	hlt
    12a7:	eb fd                	jmp    12a6 <task_spawn_named+0x62>
				if ((flg = if_enabled()))
    12a9:	e8 66 ed ff ff       	call   14 <if_enabled>
    12ae:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    12b1:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    12b5:	74 0e                	je     12c5 <task_spawn_named+0x81>
						preempt_disable();
    12b7:	e8 fc ff ff ff       	call   12b8 <task_spawn_named+0x74>
    12bc:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    12bf:	83 c2 01             	add    edx,0x1
    12c2:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				spin_lock(&pq_lock);
    12c5:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    12cc:	e8 fc ff ff ff       	call   12cd <task_spawn_named+0x89>
				struct tsi* pts = stk;
    12d1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12d4:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				pts--;
    12d7:	83 6d dc 6c          	sub    DWORD PTR [ebp-0x24],0x6c
				struct task_state* ti = (void*)pts;
    12db:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    12de:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ti--; /* store info at stack bottom */
    12e1:	83 6d d8 44          	sub    DWORD PTR [ebp-0x28],0x44
				id = get_stack(stk, &sl);
    12e5:	8d 45 cc             	lea    eax,[ebp-0x34]
    12e8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    12ec:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12ef:	89 04 24             	mov    DWORD PTR [esp],eax
    12f2:	e8 fc ff ff ff       	call   12f3 <task_spawn_named+0xaf>
    12f7:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				ts.flags = TIF_KERNEL_STACK;
    12fa:	c7 85 60 ff ff ff 08 00 00 00 	mov    DWORD PTR [ebp-0xa0],0x8
				ts.task_id = id;
    1304:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1307:	89 85 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],eax
				ts.stack_base = sl.base;
    130d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1310:	89 85 68 ff ff ff    	mov    DWORD PTR [ebp-0x98],eax
				ts.stack_limit = sl.limit;
    1316:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1319:	89 85 6c ff ff ff    	mov    DWORD PTR [ebp-0x94],eax
				ts.priority = ts.cur_priority = priority;
    131f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1322:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
    1325:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    1328:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
				ts.name = name;
    132b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    132e:	89 85 70 ff ff ff    	mov    DWORD PTR [ebp-0x90],eax
				ts.quota = 10; ts.run_time = 0;
    1334:	c7 45 8c 0a 00 00 00 	mov    DWORD PTR [ebp-0x74],0xa
    133b:	c7 45 84 00 00 00 00 	mov    DWORD PTR [ebp-0x7c],0x0
				ts.ts = ti;
    1342:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1345:	89 85 64 ff ff ff    	mov    DWORD PTR [ebp-0x9c],eax
				ts.task_proc = 0xffffffff;
    134b:	c7 45 a4 ff ff ff ff 	mov    DWORD PTR [ebp-0x5c],0xffffffff
				bzero(ti, sizeof(*ti));
    1352:	c7 44 24 04 44 00 00 00 	mov    DWORD PTR [esp+0x4],0x44
    135a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    135d:	89 04 24             	mov    DWORD PTR [esp],eax
    1360:	e8 fc ff ff ff       	call   1361 <task_spawn_named+0x11d>
				ti->cs = SEG_CODE;
    1365:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1368:	c7 40 34 08 00 00 00 	mov    DWORD PTR [eax+0x34],0x8
				ti->ds = ti->es = SEG_DATA;
    136f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1372:	c7 40 08 10 00 00 00 	mov    DWORD PTR [eax+0x8],0x10
    1379:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    137c:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    137f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1382:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
				ti->gs = SEG_DATA;
    1385:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1388:	c7 00 10 00 00 00    	mov    DWORD PTR [eax],0x10
				ti->fs = SEG_DATA_PROC; // x86, x86_64 other way
    138e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1391:	c7 40 04 40 00 00 00 	mov    DWORD PTR [eax+0x4],0x40
				ti->esp = (uint32_t)ti;
    1398:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    139b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    139e:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
				ti->ebp = ti->esp;
    13a1:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13a4:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    13a7:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13aa:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				ti->eflags = (1 << 9)/* | (1 << 8)*/; /* IF TF (interrupt enable, single-step) */
    13ad:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13b0:	c7 40 38 00 02 00 00 	mov    DWORD PTR [eax+0x38],0x200
				ti->eax = (uint32_t)fn;
    13b7:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    13ba:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13bd:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
				ti->ecx = (uint32_t)dat;
    13c0:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    13c3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13c6:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
				ti->eip = (uint32_t)task_initfunc;
    13c9:	ba 00 00 00 00       	mov    edx,0x0
    13ce:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13d1:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
				*pts = ts;
    13d4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    13d7:	89 c3                	mov    ebx,eax
    13d9:	8d 85 60 ff ff ff    	lea    eax,[ebp-0xa0]
    13df:	ba 1b 00 00 00       	mov    edx,0x1b
    13e4:	89 df                	mov    edi,ebx
    13e6:	89 c6                	mov    esi,eax
    13e8:	89 d1                	mov    ecx,edx
    13ea:	f3 a5                	rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]
				tks[n_tks++] = pts;
    13ec:	a1 00 00 00 00       	mov    eax,ds:0x0
    13f1:	8d 50 01             	lea    edx,[eax+0x1]
    13f4:	89 15 00 00 00 00    	mov    DWORD PTR ds:0x0,edx
    13fa:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    13fd:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
				pq_enqueue(run_queue, pts);
    1404:	a1 00 00 00 00       	mov    eax,ds:0x0
    1409:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    140c:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1410:	89 04 24             	mov    DWORD PTR [esp],eax
    1413:	e8 fc ff ff ff       	call   1414 <task_spawn_named+0x1d0>
				spin_unlock(&pq_lock);
    1418:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    141f:	e8 fc ff ff ff       	call   1420 <task_spawn_named+0x1dc>
				if (flg)
    1424:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1428:	74 21                	je     144b <task_spawn_named+0x207>
						preempt_enable();
    142a:	e8 fc ff ff ff       	call   142b <task_spawn_named+0x1e7>
    142f:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    1432:	83 ea 01             	sub    edx,0x1
    1435:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
    1438:	e8 fc ff ff ff       	call   1439 <task_spawn_named+0x1f5>
    143d:	8b 00                	mov    eax,DWORD PTR [eax]
    143f:	83 e0 01             	and    eax,0x1
    1442:	85 c0                	test   eax,eax
    1444:	74 05                	je     144b <task_spawn_named+0x207>
    1446:	e8 fc ff ff ff       	call   1447 <task_spawn_named+0x203>
}
    144b:	81 c4 ac 00 00 00    	add    esp,0xac
    1451:	5b                   	pop    ebx
    1452:	5e                   	pop    esi
    1453:	5f                   	pop    edi
    1454:	5d                   	pop    ebp
    1455:	c3                   	ret

00001456 <task_deallocate>:
{
    1456:	55                   	push   ebp
    1457:	89 e5                	mov    ebp,esp
    1459:	83 ec 14             	sub    esp,0x14
		for (size_t i = 0; i < n_tks; i++)
    145c:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
    1463:	eb 46                	jmp    14ab <task_deallocate+0x55>
				if (tks[i] == t) {
    1465:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1468:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    146f:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1472:	75 33                	jne    14a7 <task_deallocate+0x51>
						tks[i] = NULL;
    1474:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1477:	c7 04 85 00 00 00 00 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],0x0
						tks[i] = tks[--n_tks];
    1482:	a1 00 00 00 00       	mov    eax,ds:0x0
    1487:	83 e8 01             	sub    eax,0x1
    148a:	a3 00 00 00 00       	mov    ds:0x0,eax
    148f:	a1 00 00 00 00       	mov    eax,ds:0x0
    1494:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    149b:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    149e:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						break;
    14a5:	eb 0e                	jmp    14b5 <task_deallocate+0x5f>
		for (size_t i = 0; i < n_tks; i++)
    14a7:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
    14ab:	a1 00 00 00 00       	mov    eax,ds:0x0
    14b0:	39 45 fc             	cmp    DWORD PTR [ebp-0x4],eax
    14b3:	72 b0                	jb     1465 <task_deallocate+0xf>
		free_stack(t->stack_base);
    14b5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14b8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    14bb:	89 04 24             	mov    DWORD PTR [esp],eax
    14be:	e8 fc ff ff ff       	call   14bf <task_deallocate+0x69>
}
    14c3:	90                   	nop
    14c4:	c9                   	leave
    14c5:	c3                   	ret

000014c6 <task_diag>:
{
    14c6:	55                   	push   ebp
    14c7:	89 e5                	mov    ebp,esp
    14c9:	57                   	push   edi
    14ca:	56                   	push   esi
    14cb:	53                   	push   ebx
    14cc:	83 ec 4c             	sub    esp,0x4c
		size_t end = pr_idx;
    14cf:	a1 00 00 00 00       	mov    eax,ds:0x0
    14d4:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		asm("cli");
    14d7:	fa                   	cli
		if (diag++)
    14d8:	a1 04 04 00 00       	mov    eax,ds:0x404
    14dd:	8d 50 01             	lea    edx,[eax+0x1]
    14e0:	89 15 04 04 00 00    	mov    DWORD PTR ds:0x404,edx
    14e6:	85 c0                	test   eax,eax
    14e8:	0f 85 22 01 00 00    	jne    1610 <task_diag+0x14a>
		framebuffer_redraw(&fb_initial);
    14ee:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    14f5:	e8 fc ff ff ff       	call   14f6 <task_diag+0x30>
		mdelay(1000);
    14fa:	c7 04 24 e8 03 00 00 	mov    DWORD PTR [esp],0x3e8
    1501:	e8 fc ff ff ff       	call   1502 <task_diag+0x3c>
		print_tasks();
    1506:	e8 fc ff ff ff       	call   1507 <task_diag+0x41>
		printf("PROC TASK TASK_NAME        EIP      ESP\n");
    150b:	c7 04 24 b4 03 00 00 	mov    DWORD PTR [esp],0x3b4
    1512:	e8 fc ff ff ff       	call   1513 <task_diag+0x4d>
		for (size_t i = end - 1; i != end; i--) {
    1517:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    151a:	83 e8 01             	sub    eax,0x1
    151d:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1520:	e9 dd 00 00 00       	jmp    1602 <task_diag+0x13c>
						pr_lst[i].eip, pr_lst[i].esp);
    1525:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    152b:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    152e:	89 d0                	mov    eax,edx
    1530:	c1 e0 02             	shl    eax,0x2
    1533:	01 d0                	add    eax,edx
    1535:	c1 e0 02             	shl    eax,0x2
    1538:	01 c8                	add    eax,ecx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    153a:	8b 78 10             	mov    edi,DWORD PTR [eax+0x10]
						pr_lst[i].eip, pr_lst[i].esp);
    153d:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1543:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1546:	89 d0                	mov    eax,edx
    1548:	c1 e0 02             	shl    eax,0x2
    154b:	01 d0                	add    eax,edx
    154d:	c1 e0 02             	shl    eax,0x2
    1550:	01 c8                	add    eax,ecx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    1552:	8b 70 0c             	mov    esi,DWORD PTR [eax+0xc]
						pr_lst[i].task_id, pr_lst[i].task_name,
    1555:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    155b:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    155e:	89 d0                	mov    eax,edx
    1560:	c1 e0 02             	shl    eax,0x2
    1563:	01 d0                	add    eax,edx
    1565:	c1 e0 02             	shl    eax,0x2
    1568:	01 c8                	add    eax,ecx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    156a:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
						pr_lst[i].task_id, pr_lst[i].task_name,
    156d:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1573:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1576:	89 d0                	mov    eax,edx
    1578:	c1 e0 02             	shl    eax,0x2
    157b:	01 d0                	add    eax,edx
    157d:	c1 e0 02             	shl    eax,0x2
    1580:	01 c8                	add    eax,ecx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    1582:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    1585:	a1 00 00 00 00       	mov    eax,ds:0x0
    158a:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    158d:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1590:	89 d0                	mov    eax,edx
    1592:	c1 e0 02             	shl    eax,0x2
    1595:	01 d0                	add    eax,edx
    1597:	c1 e0 02             	shl    eax,0x2
    159a:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    159d:	01 d0                	add    eax,edx
    159f:	8b 00                	mov    eax,DWORD PTR [eax]
    15a1:	c1 e8 18             	shr    eax,0x18
    15a4:	89 7c 24 14          	mov    DWORD PTR [esp+0x14],edi
    15a8:	89 74 24 10          	mov    DWORD PTR [esp+0x10],esi
    15ac:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    15b0:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    15b4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    15b8:	c7 04 24 dd 03 00 00 	mov    DWORD PTR [esp],0x3dd
    15bf:	e8 fc ff ff ff       	call   15c0 <task_diag+0xfa>
				if (i % 20)
    15c4:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    15c7:	ba cd cc cc cc       	mov    edx,0xcccccccd
    15cc:	89 c8                	mov    eax,ecx
    15ce:	f7 e2                	mul    edx
    15d0:	c1 ea 04             	shr    edx,0x4
    15d3:	89 d0                	mov    eax,edx
    15d5:	c1 e0 02             	shl    eax,0x2
    15d8:	01 d0                	add    eax,edx
    15da:	c1 e0 02             	shl    eax,0x2
    15dd:	29 c1                	sub    ecx,eax
    15df:	89 ca                	mov    edx,ecx
    15e1:	85 d2                	test   edx,edx
    15e3:	74 0c                	je     15f1 <task_diag+0x12b>
						framebuffer_redraw(&fb_initial);
    15e5:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    15ec:	e8 fc ff ff ff       	call   15ed <task_diag+0x127>
				if (!i)
    15f1:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    15f5:	75 07                	jne    15fe <task_diag+0x138>
						i = 128;
    15f7:	c7 45 e4 80 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x80
		for (size_t i = end - 1; i != end; i--) {
    15fe:	83 6d e4 01          	sub    DWORD PTR [ebp-0x1c],0x1
    1602:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1605:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    1608:	0f 85 17 ff ff ff    	jne    1525 <task_diag+0x5f>
    160e:	eb 01                	jmp    1611 <task_diag+0x14b>
				return;
    1610:	90                   	nop
}
    1611:	83 c4 4c             	add    esp,0x4c
    1614:	5b                   	pop    ebx
    1615:	5e                   	pop    esi
    1616:	5f                   	pop    edi
    1617:	5d                   	pop    ebp
    1618:	c3                   	ret

00001619 <proc_add_time>:
{
    1619:	55                   	push   ebp
    161a:	89 e5                	mov    ebp,esp
    161c:	53                   	push   ebx
    161d:	83 ec 1c             	sub    esp,0x1c
    1620:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1623:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1626:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1629:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct perf_ctrs* pc = (nproc > 1) ? per_cpu_ptr()->ticks : bp_tick;
    162c:	a1 00 00 00 00       	mov    eax,ds:0x0
    1631:	83 f8 01             	cmp    eax,0x1
    1634:	76 0a                	jbe    1640 <proc_add_time+0x27>
    1636:	e8 c5 e9 ff ff       	call   0 <per_cpu_ptr>
    163b:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    163e:	eb 05                	jmp    1645 <proc_add_time+0x2c>
    1640:	a1 00 00 00 00       	mov    eax,ds:0x0
    1645:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		/* we're inside the pq lock -> no sync */
		if (flags & TIF_IDLE)
    1648:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    164b:	83 e0 40             	and    eax,0x40
    164e:	85 c0                	test   eax,eax
    1650:	74 1e                	je     1670 <proc_add_time+0x57>
				pc->ns_idle += ns;
    1652:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1655:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    1658:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    165b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    165e:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1661:	01 c8                	add    eax,ecx
    1663:	11 da                	adc    edx,ebx
    1665:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    1668:	89 41 08             	mov    DWORD PTR [ecx+0x8],eax
    166b:	89 51 0c             	mov    DWORD PTR [ecx+0xc],edx
    166e:	eb 44                	jmp    16b4 <proc_add_time+0x9b>
		else if (flags & TIF_KERNEL_STACK)
    1670:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1673:	83 e0 08             	and    eax,0x8
    1676:	85 c0                	test   eax,eax
    1678:	74 1e                	je     1698 <proc_add_time+0x7f>
				pc->ns_kernel += ns;
    167a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    167d:	8b 48 10             	mov    ecx,DWORD PTR [eax+0x10]
    1680:	8b 58 14             	mov    ebx,DWORD PTR [eax+0x14]
    1683:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1686:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1689:	01 c8                	add    eax,ecx
    168b:	11 da                	adc    edx,ebx
    168d:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    1690:	89 41 10             	mov    DWORD PTR [ecx+0x10],eax
    1693:	89 51 14             	mov    DWORD PTR [ecx+0x14],edx
    1696:	eb 1c                	jmp    16b4 <proc_add_time+0x9b>
		else
				pc->ns_user += ns;
    1698:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    169b:	8b 48 18             	mov    ecx,DWORD PTR [eax+0x18]
    169e:	8b 58 1c             	mov    ebx,DWORD PTR [eax+0x1c]
    16a1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    16a4:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    16a7:	01 c8                	add    eax,ecx
    16a9:	11 da                	adc    edx,ebx
    16ab:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    16ae:	89 41 18             	mov    DWORD PTR [ecx+0x18],eax
    16b1:	89 51 1c             	mov    DWORD PTR [ecx+0x1c],edx
		pc->n_times++;
    16b4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    16b7:	8b 40 44             	mov    eax,DWORD PTR [eax+0x44]
    16ba:	8d 50 01             	lea    edx,[eax+0x1]
    16bd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    16c0:	89 50 44             	mov    DWORD PTR [eax+0x44],edx
}
    16c3:	90                   	nop
    16c4:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    16c7:	c9                   	leave
    16c8:	c3                   	ret

000016c9 <get_runtime>:

/* returns runtime in ns */
uint64_t get_runtime(struct tsi* t)
{
    16c9:	55                   	push   ebp
    16ca:	89 e5                	mov    ebp,esp
    16cc:	53                   	push   ebx
    16cd:	83 ec 44             	sub    esp,0x44
		uint64_t rv;
		union {	uint64_t val; struct { uint32_t lo, hi; }; } b, e, d;
		b.val = t->start_time;
    16d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16d3:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
    16d6:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    16d9:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    16dc:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		e.val = t->stop_time;
    16df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16e2:	8b 50 40             	mov    edx,DWORD PTR [eax+0x40]
    16e5:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
    16e8:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    16eb:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		d.val = e.val - b.val;
    16ee:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    16f1:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    16f4:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    16f7:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
    16fa:	29 c8                	sub    eax,ecx
    16fc:	19 da                	sbb    edx,ebx
    16fe:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    1701:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (cpu.invariant_tsc) {
    1704:	a1 6c 00 00 00       	mov    eax,ds:0x6c
    1709:	85 c0                	test   eax,eax
    170b:	74 47                	je     1754 <get_runtime+0x8b>
				rv = 1000000 * d.val / tsc_per_ms;
    170d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1710:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1713:	69 da 40 42 0f 00    	imul   ebx,edx,0xf4240
    1719:	6b c8 00             	imul   ecx,eax,0x0
    171c:	01 d9                	add    ecx,ebx
    171e:	bb 40 42 0f 00       	mov    ebx,0xf4240
    1723:	f7 e3                	mul    ebx
    1725:	01 d1                	add    ecx,edx
    1727:	89 ca                	mov    edx,ecx
    1729:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    172f:	8b 1d 04 00 00 00    	mov    ebx,DWORD PTR ds:0x4
    1735:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    1739:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    173d:	89 04 24             	mov    DWORD PTR [esp],eax
    1740:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1744:	e8 fc ff ff ff       	call   1745 <get_runtime+0x7c>
    1749:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    174c:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    174f:	e9 13 01 00 00       	jmp    1867 <get_runtime+0x19e>
		} else if (cpu.has_acpi) {
    1754:	0f b6 05 5a 00 00 00 	movzx  eax,BYTE PTR ds:0x5a
    175b:	83 e0 40             	and    eax,0x40
    175e:	84 c0                	test   al,al
    1760:	0f 84 c3 00 00 00    	je     1829 <get_runtime+0x160>
				int64_t bias = 0;
    1766:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    176d:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				/* complicated double values */
				d.hi = e.hi - b.hi; /* jiffie/HZ difference */
    1774:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1777:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    177a:	29 c2                	sub    edx,eax
    177c:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				/* countdown timer values */
				bias = e.lo - b.lo;
    177f:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    1782:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1785:	29 c2                	sub    edx,eax
    1787:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
    178a:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				bias = bias * 1000000000ll / (HZ * apic_reload_value);
    1791:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1794:	69 d0 00 ca 9a 3b    	imul   edx,eax,0x3b9aca00
    179a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    179d:	6b c0 00             	imul   eax,eax,0x0
    17a0:	8d 0c 02             	lea    ecx,[edx+eax*1]
    17a3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    17a6:	ba 00 ca 9a 3b       	mov    edx,0x3b9aca00
    17ab:	f7 e2                	mul    edx
    17ad:	01 d1                	add    ecx,edx
    17af:	89 ca                	mov    edx,ecx
    17b1:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    17b7:	6b c9 79             	imul   ecx,ecx,0x79
    17ba:	bb 00 00 00 00       	mov    ebx,0x0
    17bf:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    17c3:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    17c7:	89 04 24             	mov    DWORD PTR [esp],eax
    17ca:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    17ce:	e8 fc ff ff ff       	call   17cf <get_runtime+0x106>
    17d3:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    17d6:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
				rv = (uint64_t)(1000000000ull * d.hi / HZ + bias);
    17d9:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    17dc:	ba 00 00 00 00       	mov    edx,0x0
    17e1:	69 da 00 ca 9a 3b    	imul   ebx,edx,0x3b9aca00
    17e7:	6b c8 00             	imul   ecx,eax,0x0
    17ea:	01 d9                	add    ecx,ebx
    17ec:	bb 00 ca 9a 3b       	mov    ebx,0x3b9aca00
    17f1:	f7 e3                	mul    ebx
    17f3:	01 d1                	add    ecx,edx
    17f5:	89 ca                	mov    edx,ecx
    17f7:	c7 44 24 08 79 00 00 00 	mov    DWORD PTR [esp+0x8],0x79
    17ff:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    1807:	89 04 24             	mov    DWORD PTR [esp],eax
    180a:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    180e:	e8 fc ff ff ff       	call   180f <get_runtime+0x146>
    1813:	89 c1                	mov    ecx,eax
    1815:	89 d3                	mov    ebx,edx
    1817:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    181a:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    181d:	01 c8                	add    eax,ecx
    181f:	11 da                	adc    edx,ebx
    1821:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1824:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    1827:	eb 3e                	jmp    1867 <get_runtime+0x19e>
		} else { /* jiffies */
				rv = 1000000000ull * d.val / HZ;
    1829:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    182c:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    182f:	69 da 00 ca 9a 3b    	imul   ebx,edx,0x3b9aca00
    1835:	6b c8 00             	imul   ecx,eax,0x0
    1838:	01 d9                	add    ecx,ebx
    183a:	bb 00 ca 9a 3b       	mov    ebx,0x3b9aca00
    183f:	f7 e3                	mul    ebx
    1841:	01 d1                	add    ecx,edx
    1843:	89 ca                	mov    edx,ecx
    1845:	c7 44 24 08 79 00 00 00 	mov    DWORD PTR [esp+0x8],0x79
    184d:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    1855:	89 04 24             	mov    DWORD PTR [esp],eax
    1858:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    185c:	e8 fc ff ff ff       	call   185d <get_runtime+0x194>
    1861:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1864:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		}
		return rv;
    1867:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    186a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
}
    186d:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1870:	c9                   	leave
    1871:	c3                   	ret

00001872 <sleep>:
struct wait_queue_head wq_idle = WAIT_QUEUE_HEAD(wq_idle);
struct wait_queue_head wq_timer = WAIT_QUEUE_HEAD(wq_timer);

int sleep(unsigned int seconds)
{
    1872:	55                   	push   ebp
    1873:	89 e5                	mov    ebp,esp
    1875:	83 ec 18             	sub    esp,0x18
		wait_timeout(&wq_timer, HZ * seconds);
    1878:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    187b:	6b c0 79             	imul   eax,eax,0x79
    187e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1882:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1889:	e8 fc ff ff ff       	call   188a <sleep+0x18>
		return 0;
    188e:	b8 00 00 00 00       	mov    eax,0x0
}
    1893:	c9                   	leave
    1894:	c3                   	ret

00001895 <wq_add>:

static inline void wq_add(struct wait_queue_head* wq_head, struct wait_queue* wq_tail)
{
    1895:	55                   	push   ebp
    1896:	89 e5                	mov    ebp,esp
    1898:	83 ec 18             	sub    esp,0x18
		spin_lock(&wq_head->lock);
    189b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    189e:	83 c0 08             	add    eax,0x8
    18a1:	89 04 24             	mov    DWORD PTR [esp],eax
    18a4:	e8 fc ff ff ff       	call   18a5 <wq_add+0x10>
		wq_head->prev->next = wq_tail;
    18a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18ac:	8b 00                	mov    eax,DWORD PTR [eax]
    18ae:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    18b1:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		wq_tail->prev = wq_head->prev;
    18b4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18b7:	8b 10                	mov    edx,DWORD PTR [eax]
    18b9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18bc:	89 10                	mov    DWORD PTR [eax],edx
		wq_head->prev = wq_tail;
    18be:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18c1:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    18c4:	89 10                	mov    DWORD PTR [eax],edx
		wq_tail->next = wq_head;
    18c6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18c9:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    18cc:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		spin_unlock(&wq_head->lock);
    18cf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18d2:	83 c0 08             	add    eax,0x8
    18d5:	89 04 24             	mov    DWORD PTR [esp],eax
    18d8:	e8 fc ff ff ff       	call   18d9 <wq_add+0x44>
}
    18dd:	90                   	nop
    18de:	c9                   	leave
    18df:	c3                   	ret

000018e0 <wq_purge>:

static inline void wq_purge(struct wait_queue_head* wq, struct wait_queue* wq_e)
{
    18e0:	55                   	push   ebp
    18e1:	89 e5                	mov    ebp,esp
    18e3:	83 ec 28             	sub    esp,0x28
		int flg;
		spin_lock_irqsave(&wq->lock, &flg);
    18e6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18e9:	8d 50 08             	lea    edx,[eax+0x8]
    18ec:	8d 45 f0             	lea    eax,[ebp-0x10]
    18ef:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    18f3:	89 14 24             	mov    DWORD PTR [esp],edx
    18f6:	e8 fc ff ff ff       	call   18f7 <wq_purge+0x17>
		if (wq->next != (struct wait_queue*)wq) {
    18fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18fe:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1901:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1904:	74 3f                	je     1945 <wq_purge+0x65>
				struct wait_queue* wq_n = wq->next;
    1906:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1909:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    190c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				do {
						if (wq_n == wq_e) {
    190f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1912:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    1915:	75 1d                	jne    1934 <wq_purge+0x54>
								wq_n->prev->next = wq_n->next;
    1917:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    191a:	8b 00                	mov    eax,DWORD PTR [eax]
    191c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    191f:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    1922:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								wq_n->next->prev = wq_n->prev;
    1925:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1928:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    192b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    192e:	8b 12                	mov    edx,DWORD PTR [edx]
    1930:	89 10                	mov    DWORD PTR [eax],edx
								break;
    1932:	eb 11                	jmp    1945 <wq_purge+0x65>
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
    1934:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1937:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    193a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    193d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1940:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    1943:	75 ca                	jne    190f <wq_purge+0x2f>
		}
		spin_unlock_irqrestore(&wq->lock, flg);
    1945:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1948:	89 c2                	mov    edx,eax
    194a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    194d:	83 c0 08             	add    eax,0x8
    1950:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1954:	89 04 24             	mov    DWORD PTR [esp],eax
    1957:	e8 fc ff ff ff       	call   1958 <wq_purge+0x78>
}
    195c:	90                   	nop
    195d:	c9                   	leave
    195e:	c3                   	ret

0000195f <wait_on_event>:

void wait_on_event(struct wait_queue_head* wq)
{
    195f:	55                   	push   ebp
    1960:	89 e5                	mov    ebp,esp
    1962:	83 ec 38             	sub    esp,0x38
		struct wait_queue my_q;
		if (__sync_bool_compare_and_swap(&wq->signaled, 1, 0))
    1965:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1968:	8d 50 0c             	lea    edx,[eax+0xc]
    196b:	b8 01 00 00 00       	mov    eax,0x1
    1970:	b9 00 00 00 00       	mov    ecx,0x0
    1975:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    1979:	0f 94 c0             	sete   al
    197c:	84 c0                	test   al,al
    197e:	0f 85 81 00 00 00    	jne    1a05 <wait_on_event+0xa6>
				return; /* handle signalling */
		if (preempt_needs_init)
    1984:	a1 00 00 00 00       	mov    eax,ds:0x0
    1989:	85 c0                	test   eax,eax
    198b:	75 7b                	jne    1a08 <wait_on_event+0xa9>
				return;
		else if (preempt_count())
    198d:	e8 fc ff ff ff       	call   198e <wait_on_event+0x2f>
    1992:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1995:	85 c0                	test   eax,eax
    1997:	75 72                	jne    1a0b <wait_on_event+0xac>
				return;
		my_q.task = get_task();
    1999:	e8 fc ff ff ff       	call   199a <wait_on_event+0x3b>
    199e:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		my_q.timeout = 0;
    19a1:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    19a8:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		wq_add(wq, &my_q);
    19af:	8d 45 e4             	lea    eax,[ebp-0x1c]
    19b2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    19b6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19b9:	89 04 24             	mov    DWORD PTR [esp],eax
    19bc:	e8 d4 fe ff ff       	call   1895 <wq_add>
		if (!__sync_bool_compare_and_swap(&wq->signaled, 1, 0)) { /* again */
    19c1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19c4:	8d 50 0c             	lea    edx,[eax+0xc]
    19c7:	b8 01 00 00 00       	mov    eax,0x1
    19cc:	b9 00 00 00 00       	mov    ecx,0x0
    19d1:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    19d5:	0f 94 c0             	sete   al
    19d8:	83 f0 01             	xor    eax,0x1
    19db:	84 c0                	test   al,al
    19dd:	74 12                	je     19f1 <wait_on_event+0x92>
				my_q.task->flags |= TIF_SLEEPING;
    19df:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    19e2:	8b 10                	mov    edx,DWORD PTR [eax]
    19e4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    19e7:	80 ca 80             	or     dl,0x80
    19ea:	89 10                	mov    DWORD PTR [eax],edx
				task_yield();
    19ec:	e8 fc ff ff ff       	call   19ed <wait_on_event+0x8e>
		}
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
    19f1:	8d 45 e4             	lea    eax,[ebp-0x1c]
    19f4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    19f8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19fb:	89 04 24             	mov    DWORD PTR [esp],eax
    19fe:	e8 dd fe ff ff       	call   18e0 <wq_purge>
    1a03:	eb 07                	jmp    1a0c <wait_on_event+0xad>
				return; /* handle signalling */
    1a05:	90                   	nop
    1a06:	eb 04                	jmp    1a0c <wait_on_event+0xad>
				return;
    1a08:	90                   	nop
    1a09:	eb 01                	jmp    1a0c <wait_on_event+0xad>
				return;
    1a0b:	90                   	nop
}
    1a0c:	c9                   	leave
    1a0d:	c3                   	ret

00001a0e <wait_timeout>:

void wait_timeout(struct wait_queue_head* wq, uint32_t delta)
{
    1a0e:	55                   	push   ebp
    1a0f:	89 e5                	mov    ebp,esp
    1a11:	53                   	push   ebx
    1a12:	83 ec 34             	sub    esp,0x34
		struct wait_queue my_q;
		my_q.task = get_task();
    1a15:	e8 fc ff ff ff       	call   1a16 <wait_timeout+0x8>
    1a1a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		my_q.timeout = jiffies + delta;
    1a1d:	a1 00 00 00 00       	mov    eax,ds:0x0
    1a22:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1a25:	8b 00                	mov    eax,DWORD PTR [eax]
    1a27:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    1a2a:	bb 00 00 00 00       	mov    ebx,0x0
    1a2f:	01 c8                	add    eax,ecx
    1a31:	11 da                	adc    edx,ebx
    1a33:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1a36:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		wq_add(wq, &my_q);
    1a39:	8d 45 e4             	lea    eax,[ebp-0x1c]
    1a3c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a40:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a43:	89 04 24             	mov    DWORD PTR [esp],eax
    1a46:	e8 4a fe ff ff       	call   1895 <wq_add>
		my_q.task->flags |= TIF_SLEEPING;
    1a4b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a4e:	8b 10                	mov    edx,DWORD PTR [eax]
    1a50:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a53:	80 ca 80             	or     dl,0x80
    1a56:	89 10                	mov    DWORD PTR [eax],edx
		task_yield();
    1a58:	e8 fc ff ff ff       	call   1a59 <wait_timeout+0x4b>
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
    1a5d:	8d 45 e4             	lea    eax,[ebp-0x1c]
    1a60:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a64:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a67:	89 04 24             	mov    DWORD PTR [esp],eax
    1a6a:	e8 71 fe ff ff       	call   18e0 <wq_purge>
}
    1a6f:	90                   	nop
    1a70:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1a73:	c9                   	leave
    1a74:	c3                   	ret

00001a75 <wake_task>:

int wake_task(struct tsi* t)
{
    1a75:	55                   	push   ebp
    1a76:	89 e5                	mov    ebp,esp
    1a78:	83 ec 28             	sub    esp,0x28
		int rv = 0;
    1a7b:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		if (!t)
    1a82:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1a86:	75 16                	jne    1a9e <wake_task+0x29>
				cprintf(KFMT_WARN, "Empty queue entry in wait queue\n");
    1a88:	c7 44 24 04 f4 03 00 00 	mov    DWORD PTR [esp+0x4],0x3f4
    1a90:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    1a97:	e8 fc ff ff ff       	call   1a98 <wake_task+0x23>
    1a9c:	eb 3c                	jmp    1ada <wake_task+0x65>
		else { /* TODO: maybe check if really sleeping */
				t->flags &= ~TIF_SLEEPING;
    1a9e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1aa1:	8b 00                	mov    eax,DWORD PTR [eax]
    1aa3:	24 7f                	and    al,0x7f
    1aa5:	89 c2                	mov    edx,eax
    1aa7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1aaa:	89 10                	mov    DWORD PTR [eax],edx
				pq_enqueue((t->flags & TIF_EXPIRED) ?
    1aac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1aaf:	8b 00                	mov    eax,DWORD PTR [eax]
    1ab1:	83 e0 20             	and    eax,0x20
    1ab4:	85 c0                	test   eax,eax
    1ab6:	74 07                	je     1abf <wake_task+0x4a>
    1ab8:	a1 00 00 00 00       	mov    eax,ds:0x0
    1abd:	eb 05                	jmp    1ac4 <wake_task+0x4f>
    1abf:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ac4:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1ac7:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1acb:	89 04 24             	mov    DWORD PTR [esp],eax
    1ace:	e8 fc ff ff ff       	call   1acf <wake_task+0x5a>
						expired_queue : run_queue, t);
				rv = 1;
    1ad3:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
		}
		return rv;
    1ada:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1add:	c9                   	leave
    1ade:	c3                   	ret

00001adf <wake_up>:

/* called by the scheduler holding pq_lock */
int wake_up(struct wait_queue_head* wq)
{
    1adf:	55                   	push   ebp
    1ae0:	89 e5                	mov    ebp,esp
    1ae2:	83 ec 28             	sub    esp,0x28
		int rv = 0;
    1ae5:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		spin_lock(&wq->lock);
    1aec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1aef:	83 c0 08             	add    eax,0x8
    1af2:	89 04 24             	mov    DWORD PTR [esp],eax
    1af5:	e8 fc ff ff ff       	call   1af6 <wake_up+0x17>
		if (wq->next != (struct wait_queue*)wq) {
    1afa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1afd:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b00:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1b03:	74 35                	je     1b3a <wake_up+0x5b>
				struct wait_queue* wq_n = wq->next;
    1b05:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b08:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b0b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
    1b0e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b11:	8b 00                	mov    eax,DWORD PTR [eax]
    1b13:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1b16:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    1b19:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				wq_n->next->prev = wq_n->prev;
    1b1c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b1f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b22:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1b25:	8b 12                	mov    edx,DWORD PTR [edx]
    1b27:	89 10                	mov    DWORD PTR [eax],edx
				rv = wake_task(wq_n->task);
    1b29:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b2c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1b2f:	89 04 24             	mov    DWORD PTR [esp],eax
    1b32:	e8 fc ff ff ff       	call   1b33 <wake_up+0x54>
    1b37:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		}
		spin_unlock(&wq->lock);
    1b3a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b3d:	83 c0 08             	add    eax,0x8
    1b40:	89 04 24             	mov    DWORD PTR [esp],eax
    1b43:	e8 fc ff ff ff       	call   1b44 <wake_up+0x65>
		return rv;
    1b48:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1b4b:	c9                   	leave
    1b4c:	c3                   	ret

00001b4d <wake_up_all>:

int wake_up_all(struct wait_queue* wq)
{
    1b4d:	55                   	push   ebp
    1b4e:	89 e5                	mov    ebp,esp
    1b50:	83 ec 28             	sub    esp,0x28
		int rv = 0;
    1b53:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		while (wake_up(wq))
    1b5a:	eb 04                	jmp    1b60 <wake_up_all+0x13>
				rv++;
    1b5c:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		while (wake_up(wq))
    1b60:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b63:	89 04 24             	mov    DWORD PTR [esp],eax
    1b66:	e8 fc ff ff ff       	call   1b67 <wake_up_all+0x1a>
    1b6b:	85 c0                	test   eax,eax
    1b6d:	75 ed                	jne    1b5c <wake_up_all+0xf>
		return rv;
    1b6f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1b72:	c9                   	leave
    1b73:	c3                   	ret

00001b74 <wake_up_external_event>:

int wake_up_external_event(struct wait_queue_head* wq)
{
    1b74:	55                   	push   ebp
    1b75:	89 e5                	mov    ebp,esp
    1b77:	83 ec 28             	sub    esp,0x28
		int rv = 0;
    1b7a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		spin_lock(&wq->lock);
    1b81:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b84:	83 c0 08             	add    eax,0x8
    1b87:	89 04 24             	mov    DWORD PTR [esp],eax
    1b8a:	e8 fc ff ff ff       	call   1b8b <wake_up_external_event+0x17>
		if (wq->next != (struct wait_queue*)wq) {
    1b8f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b92:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b95:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1b98:	74 5d                	je     1bf7 <wake_up_external_event+0x83>
				struct wait_queue* wq_n = wq->next;
    1b9a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b9d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ba0:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
    1ba3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ba6:	8b 00                	mov    eax,DWORD PTR [eax]
    1ba8:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1bab:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    1bae:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				wq_n->next->prev = wq_n->prev;
    1bb1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1bb4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1bb7:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1bba:	8b 12                	mov    edx,DWORD PTR [edx]
    1bbc:	89 10                	mov    DWORD PTR [eax],edx
				wq_n->timeout = jiffies;
    1bbe:	a1 00 00 00 00       	mov    eax,ds:0x0
    1bc3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1bc6:	8b 00                	mov    eax,DWORD PTR [eax]
    1bc8:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1bcb:	89 41 0c             	mov    DWORD PTR [ecx+0xc],eax
    1bce:	89 51 10             	mov    DWORD PTR [ecx+0x10],edx
				/* abuse the timer queue */
				wq_add(&wq_timer, wq_n);
    1bd1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1bd4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1bd8:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1bdf:	e8 b1 fc ff ff       	call   1895 <wq_add>
				rv = 1;
    1be4:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
				wq->signaled = 0;
    1beb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bee:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
    1bf5:	eb 0a                	jmp    1c01 <wake_up_external_event+0x8d>
		} else { /* empty -> prevent waiting forever */
				wq->signaled = 1;
    1bf7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bfa:	c7 40 0c 01 00 00 00 	mov    DWORD PTR [eax+0xc],0x1
		}
		spin_unlock(&wq->lock);
    1c01:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c04:	83 c0 08             	add    eax,0x8
    1c07:	89 04 24             	mov    DWORD PTR [esp],eax
    1c0a:	e8 fc ff ff ff       	call   1c0b <wake_up_external_event+0x97>
		return rv;
    1c0f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1c12:	c9                   	leave
    1c13:	c3                   	ret

00001c14 <wake_up_all_external_event>:

int wake_up_all_external_event(struct wait_queue_head* wq)
{
    1c14:	55                   	push   ebp
    1c15:	89 e5                	mov    ebp,esp
    1c17:	83 ec 28             	sub    esp,0x28
		int rv = 0;
    1c1a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		while (wake_up_external_event(wq))
    1c21:	eb 04                	jmp    1c27 <wake_up_all_external_event+0x13>
				rv++;
    1c23:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		while (wake_up_external_event(wq))
    1c27:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c2a:	89 04 24             	mov    DWORD PTR [esp],eax
    1c2d:	e8 fc ff ff ff       	call   1c2e <wake_up_all_external_event+0x1a>
    1c32:	85 c0                	test   eax,eax
    1c34:	75 ed                	jne    1c23 <wake_up_all_external_event+0xf>
		if (rv) /* a bit iffy */
    1c36:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1c3a:	74 0a                	je     1c46 <wake_up_all_external_event+0x32>
				wq->signaled = 0;
    1c3c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c3f:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		return rv;
    1c46:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1c49:	c9                   	leave
    1c4a:	c3                   	ret

00001c4b <wake_up_timer>:

int wake_up_timer(struct wait_queue_head* wq)
{
    1c4b:	55                   	push   ebp
    1c4c:	89 e5                	mov    ebp,esp
    1c4e:	53                   	push   ebx
    1c4f:	83 ec 24             	sub    esp,0x24
		int rv = 0;
    1c52:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		spin_lock(&wq->lock);
    1c59:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c5c:	83 c0 08             	add    eax,0x8
    1c5f:	89 04 24             	mov    DWORD PTR [esp],eax
    1c62:	e8 fc ff ff ff       	call   1c63 <wake_up_timer+0x18>
		if (wq->next != (struct wait_queue*)wq) {
    1c67:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c6a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c6d:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1c70:	74 69                	je     1cdb <wake_up_timer+0x90>
				struct wait_queue* wq_n = wq->next;
    1c72:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c75:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c78:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				do {
						if (wq_n->timeout <= jiffies) {
    1c7b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1c7e:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
    1c81:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1c84:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1c8a:	8b 59 04             	mov    ebx,DWORD PTR [ecx+0x4]
    1c8d:	8b 09                	mov    ecx,DWORD PTR [ecx]
    1c8f:	39 c1                	cmp    ecx,eax
    1c91:	19 d3                	sbb    ebx,edx
    1c93:	72 32                	jb     1cc7 <wake_up_timer+0x7c>
								wq_n->prev->next = wq_n->next;
    1c95:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1c98:	8b 00                	mov    eax,DWORD PTR [eax]
    1c9a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1c9d:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    1ca0:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								wq_n->next->prev = wq_n->prev;
    1ca3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ca6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ca9:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1cac:	8b 12                	mov    edx,DWORD PTR [edx]
    1cae:	89 10                	mov    DWORD PTR [eax],edx
								rv = wake_task(wq_n->task);
    1cb0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1cb3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1cb6:	89 04 24             	mov    DWORD PTR [esp],eax
    1cb9:	e8 fc ff ff ff       	call   1cba <wake_up_timer+0x6f>
    1cbe:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								if (rv)
    1cc1:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1cc5:	75 13                	jne    1cda <wake_up_timer+0x8f>
										break;
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
    1cc7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1cca:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ccd:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1cd0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1cd3:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    1cd6:	75 a3                	jne    1c7b <wake_up_timer+0x30>
    1cd8:	eb 01                	jmp    1cdb <wake_up_timer+0x90>
										break;
    1cda:	90                   	nop
		}
		spin_unlock(&wq->lock);
    1cdb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cde:	83 c0 08             	add    eax,0x8
    1ce1:	89 04 24             	mov    DWORD PTR [esp],eax
    1ce4:	e8 fc ff ff ff       	call   1ce5 <wake_up_timer+0x9a>
		return rv;
    1ce9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1cec:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1cef:	c9                   	leave
    1cf0:	c3                   	ret

00001cf1 <wake_up_timer_all>:

int wake_up_timer_all(struct wait_queue_head* wq)
{
    1cf1:	55                   	push   ebp
    1cf2:	89 e5                	mov    ebp,esp
    1cf4:	83 ec 28             	sub    esp,0x28
		int rv = 0;
    1cf7:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		while (wake_up_timer(wq))
    1cfe:	eb 04                	jmp    1d04 <wake_up_timer_all+0x13>
				rv++;
    1d00:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		while (wake_up_timer(wq))
    1d04:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d07:	89 04 24             	mov    DWORD PTR [esp],eax
    1d0a:	e8 fc ff ff ff       	call   1d0b <wake_up_timer_all+0x1a>
    1d0f:	85 c0                	test   eax,eax
    1d11:	75 ed                	jne    1d00 <wake_up_timer_all+0xf>
		return rv;
    1d13:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1d16:	c9                   	leave
    1d17:	c3                   	ret

00001d18 <kidle>:

void kidle(void* data)
{
    1d18:	55                   	push   ebp
    1d19:	89 e5                	mov    ebp,esp
    1d1b:	83 ec 18             	sub    esp,0x18
		get_task()->flags |= TIF_IDLE;
    1d1e:	e8 fc ff ff ff       	call   1d1f <kidle+0x7>
    1d23:	8b 10                	mov    edx,DWORD PTR [eax]
    1d25:	83 ca 40             	or     edx,0x40
    1d28:	89 10                	mov    DWORD PTR [eax],edx
		while (1) {
				wait_on_event(&wq_idle);
    1d2a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1d31:	e8 fc ff ff ff       	call   1d32 <kidle+0x1a>
				asm("hlt");
    1d36:	f4                   	hlt
				wait_on_event(&wq_idle);
    1d37:	90                   	nop
    1d38:	eb f0                	jmp    1d2a <kidle+0x12>

00001d3a <task_schedule>:
size_t ri_ofs = 0;

/* called from everyone else (using cli before). The stack is the
 * stack of the current task. */
void task_schedule(struct tsi* prev_task)
{
    1d3a:	55                   	push   ebp
    1d3b:	89 e5                	mov    ebp,esp
    1d3d:	53                   	push   ebx
    1d3e:	83 ec 54             	sub    esp,0x54
		if (preempt_needs_init) /* returns to the task_state on the stack */
    1d41:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d46:	85 c0                	test   eax,eax
    1d48:	0f 85 68 06 00 00    	jne    23b6 <task_schedule+0x67c>
				return;    /* of the irq0 handler, i.e. where execution stopped. */

		struct tsi* t;
		/* calculate the runtime of prev_task and go back if no preemption */
		if (prev_task) {
    1d4e:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1d52:	0f 84 ad 00 00 00    	je     1e05 <task_schedule+0xcb>
				/* happens on same proc */
				uint64_t rt = get_runtime(prev_task);
    1d58:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d5b:	89 04 24             	mov    DWORD PTR [esp],eax
    1d5e:	e8 fc ff ff ff       	call   1d5f <task_schedule+0x25>
    1d63:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1d66:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				prev_task->ns_run = rt; // <- could be used for nice values
    1d69:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1d6c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1d6f:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1d72:	89 41 48             	mov    DWORD PTR [ecx+0x48],eax
    1d75:	89 51 4c             	mov    DWORD PTR [ecx+0x4c],edx
				prev_task->ns_acc += rt;
    1d78:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d7b:	8b 48 50             	mov    ecx,DWORD PTR [eax+0x50]
    1d7e:	8b 58 54             	mov    ebx,DWORD PTR [eax+0x54]
    1d81:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1d84:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1d87:	01 c8                	add    eax,ecx
    1d89:	11 da                	adc    edx,ebx
    1d8b:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1d8e:	89 41 50             	mov    DWORD PTR [ecx+0x50],eax
    1d91:	89 51 54             	mov    DWORD PTR [ecx+0x54],edx
				proc_add_time(rt, prev_task->flags);
    1d94:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d97:	8b 00                	mov    eax,DWORD PTR [eax]
    1d99:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1d9d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1da0:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1da3:	89 04 24             	mov    DWORD PTR [esp],eax
    1da6:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1daa:	e8 fc ff ff ff       	call   1dab <task_schedule+0x71>
				/* go back but signify TIF_NEED_RESCHED */
				if (prev_task->preempt_count) {
    1daf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1db2:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1db5:	85 c0                	test   eax,eax
    1db7:	74 31                	je     1dea <task_schedule+0xb0>
						prev_task->flags |= TIF_NEED_RESCHED;
    1db9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1dbc:	8b 00                	mov    eax,DWORD PTR [eax]
    1dbe:	83 c8 01             	or     eax,0x1
    1dc1:	89 c2                	mov    edx,eax
    1dc3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1dc6:	89 10                	mov    DWORD PTR [eax],edx
						prev_task->start_time = task_gettime();
    1dc8:	e8 fc ff ff ff       	call   1dc9 <task_schedule+0x8f>
    1dcd:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1dd0:	89 41 34             	mov    DWORD PTR [ecx+0x34],eax
    1dd3:	89 51 38             	mov    DWORD PTR [ecx+0x38],edx
						prev_task->quota--; /* go into negative values */
    1dd6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1dd9:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1ddc:	8d 50 ff             	lea    edx,[eax-0x1]
    1ddf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1de2:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
						return;
    1de5:	e9 cd 05 00 00       	jmp    23b7 <task_schedule+0x67d>
				} else if (prev_task->flags & TIF_NEED_RESCHED) /* clear the flag */
    1dea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ded:	8b 00                	mov    eax,DWORD PTR [eax]
    1def:	83 e0 01             	and    eax,0x1
    1df2:	85 c0                	test   eax,eax
    1df4:	74 0f                	je     1e05 <task_schedule+0xcb>
						prev_task->flags &= ~TIF_NEED_RESCHED;
    1df6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1df9:	8b 00                	mov    eax,DWORD PTR [eax]
    1dfb:	83 e0 fe             	and    eax,0xfffffffe
    1dfe:	89 c2                	mov    edx,eax
    1e00:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e03:	89 10                	mov    DWORD PTR [eax],edx
		}

		/* enter the queue lock (entails free reign over ts values) */
		spin_lock(&pq_lock);
    1e05:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1e0c:	e8 fc ff ff ff       	call   1e0d <task_schedule+0xd3>
		/* wake up once */
		wake_up_timer_all(&wq_timer);
    1e11:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1e18:	e8 fc ff ff ff       	call   1e19 <task_schedule+0xdf>
		/* check for reinsertion */
		for (size_t i = 0; i < ri_ofs; i++) {
    1e1d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1e24:	eb 71                	jmp    1e97 <task_schedule+0x15d>
				struct tsi* ti = ri_queue[i];
    1e26:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1e29:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1e30:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				if (ti->flags & TIF_RUNNING)
    1e33:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1e36:	8b 00                	mov    eax,DWORD PTR [eax]
    1e38:	83 e0 10             	and    eax,0x10
    1e3b:	85 c0                	test   eax,eax
    1e3d:	75 53                	jne    1e92 <task_schedule+0x158>
						continue;
				/* task is eligible */
				pq_enqueue((ti->flags & TIF_EXPIRED) ?
    1e3f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1e42:	8b 00                	mov    eax,DWORD PTR [eax]
    1e44:	83 e0 20             	and    eax,0x20
    1e47:	85 c0                	test   eax,eax
    1e49:	74 07                	je     1e52 <task_schedule+0x118>
    1e4b:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e50:	eb 05                	jmp    1e57 <task_schedule+0x11d>
    1e52:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e57:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    1e5a:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1e5e:	89 04 24             	mov    DWORD PTR [esp],eax
    1e61:	e8 fc ff ff ff       	call   1e62 <task_schedule+0x128>
						expired_queue : run_queue, ti);
				/* shorten queue and redo current iteration */
				ri_queue[i--] = ri_queue[--ri_ofs];
    1e66:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e6b:	83 e8 01             	sub    eax,0x1
    1e6e:	a3 00 00 00 00       	mov    ds:0x0,eax
    1e73:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1e79:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1e7c:	8d 48 ff             	lea    ecx,[eax-0x1]
    1e7f:	89 4d f0             	mov    DWORD PTR [ebp-0x10],ecx
    1e82:	8b 14 95 00 00 00 00 	mov    edx,DWORD PTR [edx*4+0x0]
    1e89:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
    1e90:	eb 01                	jmp    1e93 <task_schedule+0x159>
						continue;
    1e92:	90                   	nop
		for (size_t i = 0; i < ri_ofs; i++) {
    1e93:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1e97:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e9c:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    1e9f:	72 85                	jb     1e26 <task_schedule+0xec>
		}

Pos1:
    1ea1:	90                   	nop
    1ea2:	eb 04                	jmp    1ea8 <task_schedule+0x16e>
		}

		/* check for sleeping tasks and if so, forget the task
		 * (wake_up is responsible for reenqueueing) */
		if (t->flags & TIF_SLEEPING)
				goto Pos1;
    1ea4:	90                   	nop
    1ea5:	eb 01                	jmp    1ea8 <task_schedule+0x16e>
				if (t != prev_task) { /* except if we're the one holding it */
						ri_queue[ri_ofs++] = t;
						t->quota++;
						if (ri_ofs == RI_LIMIT)
								die("Use a larger reinsertion queue!\n");
						goto Pos1; /* don't schedule the same task on many procs */
    1ea7:	90                   	nop
		t = pq_dequeue(run_queue);
    1ea8:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ead:	89 04 24             	mov    DWORD PTR [esp],eax
    1eb0:	e8 fc ff ff ff       	call   1eb1 <task_schedule+0x177>
    1eb5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!t) { /* major rotation */
    1eb8:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1ebc:	75 64                	jne    1f22 <task_schedule+0x1e8>
				struct priority_queue* q = run_queue;
    1ebe:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ec3:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				run_queue = expired_queue;
    1ec6:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ecb:	a3 00 00 00 00       	mov    ds:0x0,eax
				expired_queue = q;
    1ed0:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1ed3:	a3 00 00 00 00       	mov    ds:0x0,eax
				for (size_t i = 0; i < n_tks; i++) /* unexpire them */
    1ed8:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    1edf:	eb 1f                	jmp    1f00 <task_schedule+0x1c6>
						tks[i]->flags &= ~TIF_EXPIRED;
    1ee1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ee4:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1eeb:	8b 10                	mov    edx,DWORD PTR [eax]
    1eed:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ef0:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1ef7:	83 e2 df             	and    edx,0xffffffdf
    1efa:	89 10                	mov    DWORD PTR [eax],edx
				for (size_t i = 0; i < n_tks; i++) /* unexpire them */
    1efc:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    1f00:	a1 00 00 00 00       	mov    eax,ds:0x0
    1f05:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
    1f08:	72 d7                	jb     1ee1 <task_schedule+0x1a7>
				STAT_INC_COUNTER(sched_mr_count, 1);
    1f0a:	f0 83 05 00 00 00 00 01 	lock add DWORD PTR ds:0x0,0x1
				t = pq_dequeue(run_queue);
    1f12:	a1 00 00 00 00       	mov    eax,ds:0x0
    1f17:	89 04 24             	mov    DWORD PTR [esp],eax
    1f1a:	e8 fc ff ff ff       	call   1f1b <task_schedule+0x1e1>
    1f1f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!t) { /* nothing to do? --> wake idle process */
    1f22:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1f26:	75 37                	jne    1f5f <task_schedule+0x225>
				if (!prev_task || (prev_task->flags & TIF_SLEEPING)
    1f28:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1f2c:	74 1a                	je     1f48 <task_schedule+0x20e>
    1f2e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f31:	8b 00                	mov    eax,DWORD PTR [eax]
    1f33:	25 80 00 00 00       	and    eax,0x80
    1f38:	85 c0                	test   eax,eax
    1f3a:	75 0c                	jne    1f48 <task_schedule+0x20e>
							   || (prev_task->flags & TIF_YIELDED)) {
    1f3c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f3f:	8b 00                	mov    eax,DWORD PTR [eax]
    1f41:	83 e0 02             	and    eax,0x2
    1f44:	85 c0                	test   eax,eax
    1f46:	74 11                	je     1f59 <task_schedule+0x21f>
						wake_up(&wq_idle);
    1f48:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1f4f:	e8 fc ff ff ff       	call   1f50 <task_schedule+0x216>
						goto Pos1;
    1f54:	e9 4f ff ff ff       	jmp    1ea8 <task_schedule+0x16e>
						t = prev_task;
    1f59:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f5c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (t->flags & TIF_DEALLOCATE && !(t->flags & TIF_RUNNING)) {
    1f5f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f62:	8b 00                	mov    eax,DWORD PTR [eax]
    1f64:	83 e0 04             	and    eax,0x4
    1f67:	85 c0                	test   eax,eax
    1f69:	74 1c                	je     1f87 <task_schedule+0x24d>
    1f6b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f6e:	8b 00                	mov    eax,DWORD PTR [eax]
    1f70:	83 e0 10             	and    eax,0x10
    1f73:	85 c0                	test   eax,eax
    1f75:	75 10                	jne    1f87 <task_schedule+0x24d>
				task_deallocate(t);
    1f77:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f7a:	89 04 24             	mov    DWORD PTR [esp],eax
    1f7d:	e8 fc ff ff ff       	call   1f7e <task_schedule+0x244>
				goto Pos1;
    1f82:	e9 21 ff ff ff       	jmp    1ea8 <task_schedule+0x16e>
		if (t->flags & TIF_SLEEPING)
    1f87:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f8a:	8b 00                	mov    eax,DWORD PTR [eax]
    1f8c:	25 80 00 00 00       	and    eax,0x80
    1f91:	85 c0                	test   eax,eax
    1f93:	0f 85 0b ff ff ff    	jne    1ea4 <task_schedule+0x16a>
		if (--t->quota <= 0) {
    1f99:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f9c:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1f9f:	8d 50 ff             	lea    edx,[eax-0x1]
    1fa2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fa5:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
    1fa8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fab:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1fae:	85 c0                	test   eax,eax
    1fb0:	7f 69                	jg     201b <task_schedule+0x2e1>
				t->quota += 10;
    1fb2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fb5:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1fb8:	8d 50 0a             	lea    edx,[eax+0xa]
    1fbb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fbe:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
				t->flags &= ~TIF_YIELDED;
    1fc1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fc4:	8b 00                	mov    eax,DWORD PTR [eax]
    1fc6:	83 e0 fd             	and    eax,0xfffffffd
    1fc9:	89 c2                	mov    edx,eax
    1fcb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fce:	89 10                	mov    DWORD PTR [eax],edx
				if (t->cur_priority != PRIORITY_MIN) {
    1fd0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fd3:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1fd6:	83 f8 03             	cmp    eax,0x3
    1fd9:	74 1b                	je     1ff6 <task_schedule+0x2bc>
						t->cur_priority++;
    1fdb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fde:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1fe1:	8d 50 01             	lea    edx,[eax+0x1]
    1fe4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fe7:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
						STAT_INC_COUNTER(t->task_mr_bumps, 1);
    1fea:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1fed:	83 c0 64             	add    eax,0x64
    1ff0:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
    1ff4:	eb 25                	jmp    201b <task_schedule+0x2e1>
						t->flags |= TIF_EXPIRED;
    1ff6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1ff9:	8b 00                	mov    eax,DWORD PTR [eax]
    1ffb:	83 c8 20             	or     eax,0x20
    1ffe:	89 c2                	mov    edx,eax
    2000:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2003:	89 10                	mov    DWORD PTR [eax],edx
						t->cur_priority = t->priority;
    2005:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2008:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
    200b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    200e:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
						STAT_INC_COUNTER(t->task_mr_expires, 1);
    2011:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2014:	83 c0 68             	add    eax,0x68
    2017:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
		if (__sync_fetch_and_or(&t->flags, TIF_RUNNING) & TIF_RUNNING) {
    201b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    201e:	8b 02                	mov    eax,DWORD PTR [edx]
    2020:	89 c3                	mov    ebx,eax
    2022:	89 c1                	mov    ecx,eax
    2024:	83 c9 10             	or     ecx,0x10
    2027:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    202b:	0f 94 c1             	sete   cl
    202e:	84 c9                	test   cl,cl
    2030:	74 ee                	je     2020 <task_schedule+0x2e6>
    2032:	89 d8                	mov    eax,ebx
    2034:	83 e0 10             	and    eax,0x10
    2037:	85 c0                	test   eax,eax
    2039:	74 66                	je     20a1 <task_schedule+0x367>
				if (t != prev_task) { /* except if we're the one holding it */
    203b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    203e:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    2041:	74 5e                	je     20a1 <task_schedule+0x367>
						ri_queue[ri_ofs++] = t;
    2043:	a1 00 00 00 00       	mov    eax,ds:0x0
    2048:	8d 50 01             	lea    edx,[eax+0x1]
    204b:	89 15 00 00 00 00    	mov    DWORD PTR ds:0x0,edx
    2051:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2054:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						t->quota++;
    205b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    205e:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2061:	8d 50 01             	lea    edx,[eax+0x1]
    2064:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2067:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
						if (ri_ofs == RI_LIMIT)
    206a:	a1 00 00 00 00       	mov    eax,ds:0x0
    206f:	83 f8 20             	cmp    eax,0x20
    2072:	0f 85 2f fe ff ff    	jne    1ea7 <task_schedule+0x16d>
								die("Use a larger reinsertion queue!\n");
    2078:	c7 44 24 04 18 04 00 00 	mov    DWORD PTR [esp+0x4],0x418
    2080:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2087:	e8 fc ff ff ff       	call   2088 <task_schedule+0x34e>
    208c:	e8 fc ff ff ff       	call   208d <task_schedule+0x353>
    2091:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2098:	e8 fc ff ff ff       	call   2099 <task_schedule+0x35f>
    209d:	fa                   	cli
    209e:	f4                   	hlt
    209f:	eb fd                	jmp    209e <task_schedule+0x364>
				}
		}
		barrier();
		t->run_time++; /* accounting */
    20a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20a4:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    20a7:	8d 50 01             	lea    edx,[eax+0x1]
    20aa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20ad:	89 50 24             	mov    DWORD PTR [eax+0x24],edx

		/* now jump into task */
		t->start_time = task_gettime();
    20b0:	e8 fc ff ff ff       	call   20b1 <task_schedule+0x377>
    20b5:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    20b8:	89 41 34             	mov    DWORD PTR [ecx+0x34],eax
    20bb:	89 51 38             	mov    DWORD PTR [ecx+0x38],edx
		/* DEBUG check! */
		{
				struct stack_limits sl;
				if (get_stack(stack_ptr(t), &sl) == -1) {
    20be:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20c1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    20c4:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    20c7:	89 c2                	mov    edx,eax
    20c9:	8d 45 d0             	lea    eax,[ebp-0x30]
    20cc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    20d0:	89 14 24             	mov    DWORD PTR [esp],edx
    20d3:	e8 fc ff ff ff       	call   20d4 <task_schedule+0x39a>
    20d8:	83 f8 ff             	cmp    eax,0xffffffff
    20db:	75 5a                	jne    2137 <task_schedule+0x3fd>
						die("invalid task struct at %p (esp=%p)\nt%sprev_task\n",
    20dd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20e0:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    20e3:	75 07                	jne    20ec <task_schedule+0x3b2>
    20e5:	ba 39 04 00 00       	mov    edx,0x439
    20ea:	eb 05                	jmp    20f1 <task_schedule+0x3b7>
    20ec:	ba 3c 04 00 00       	mov    edx,0x43c
    20f1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20f4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    20f7:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    20fa:	89 c1                	mov    ecx,eax
    20fc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20ff:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2102:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    2106:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    210a:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    210e:	c7 44 24 04 40 04 00 00 	mov    DWORD PTR [esp+0x4],0x440
    2116:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    211d:	e8 fc ff ff ff       	call   211e <task_schedule+0x3e4>
    2122:	e8 fc ff ff ff       	call   2123 <task_schedule+0x3e9>
    2127:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    212e:	e8 fc ff ff ff       	call   212f <task_schedule+0x3f5>
    2133:	fa                   	cli
    2134:	f4                   	hlt
    2135:	eb fd                	jmp    2134 <task_schedule+0x3fa>
								t->ts, stack_ptr(t), (t == prev_task) ? "==" : "!=");
				} else if (stack_ptr(t) < 0x7c00) {
    2137:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    213a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    213d:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2140:	3d ff 7b 00 00       	cmp    eax,0x7bff
    2145:	77 33                	ja     217a <task_schedule+0x440>
						die("eip below 0x7c00 for task struct at %p\n", t->ts);
    2147:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    214a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    214d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2151:	c7 44 24 04 74 04 00 00 	mov    DWORD PTR [esp+0x4],0x474
    2159:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2160:	e8 fc ff ff ff       	call   2161 <task_schedule+0x427>
    2165:	e8 fc ff ff ff       	call   2166 <task_schedule+0x42c>
    216a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2171:	e8 fc ff ff ff       	call   2172 <task_schedule+0x438>
    2176:	fa                   	cli
    2177:	f4                   	hlt
    2178:	eb fd                	jmp    2177 <task_schedule+0x43d>
				} else if (t->stack_base < stack_ptr(t) || t->stack_limit > stack_ptr(t)) {
    217a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    217d:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    2180:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2183:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2186:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2189:	39 c2                	cmp    edx,eax
    218b:	72 13                	jb     21a0 <task_schedule+0x466>
    218d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2190:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2193:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2196:	8b 52 04             	mov    edx,DWORD PTR [edx+0x4]
    2199:	8b 52 1c             	mov    edx,DWORD PTR [edx+0x1c]
    219c:	39 c2                	cmp    edx,eax
    219e:	73 29                	jae    21c9 <task_schedule+0x48f>
						die("jumping into wrong stack!\n");
    21a0:	c7 44 24 04 9c 04 00 00 	mov    DWORD PTR [esp+0x4],0x49c
    21a8:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    21af:	e8 fc ff ff ff       	call   21b0 <task_schedule+0x476>
    21b4:	e8 fc ff ff ff       	call   21b5 <task_schedule+0x47b>
    21b9:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    21c0:	e8 fc ff ff ff       	call   21c1 <task_schedule+0x487>
    21c5:	fa                   	cli
    21c6:	f4                   	hlt
    21c7:	eb fd                	jmp    21c6 <task_schedule+0x48c>
				} else if (!t->ts)
    21c9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    21cc:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    21cf:	85 c0                	test   eax,eax
    21d1:	75 29                	jne    21fc <task_schedule+0x4c2>
						die("jumping into null!\n");
    21d3:	c7 44 24 04 b7 04 00 00 	mov    DWORD PTR [esp+0x4],0x4b7
    21db:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    21e2:	e8 fc ff ff ff       	call   21e3 <task_schedule+0x4a9>
    21e7:	e8 fc ff ff ff       	call   21e8 <task_schedule+0x4ae>
    21ec:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    21f3:	e8 fc ff ff ff       	call   21f4 <task_schedule+0x4ba>
    21f8:	fa                   	cli
    21f9:	f4                   	hlt
    21fa:	eb fd                	jmp    21f9 <task_schedule+0x4bf>
				//check_tasks();
				if (pr_lst) { /* ringbuffer */
    21fc:	a1 00 00 00 00       	mov    eax,ds:0x0
    2201:	85 c0                	test   eax,eax
    2203:	0f 84 05 01 00 00    	je     230e <task_schedule+0x5d4>
						size_t idx;
get_idx:
    2209:	90                   	nop
						idx = __sync_fetch_and_add(&pr_idx, 1);
    220a:	b8 01 00 00 00       	mov    eax,0x1
    220f:	f0 0f c1 05 00 00 00 00 	lock xadd DWORD PTR ds:0x0,eax
    2217:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						if (idx > 127) {
    221a:	83 7d e8 7f          	cmp    DWORD PTR [ebp-0x18],0x7f
    221e:	76 21                	jbe    2241 <task_schedule+0x507>
								if (__sync_bool_compare_and_swap(&pr_idx, idx + 1, 0))
    2220:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2223:	83 c0 01             	add    eax,0x1
    2226:	ba 00 00 00 00       	mov    edx,0x0
    222b:	f0 0f b1 15 00 00 00 00 	lock cmpxchg DWORD PTR ds:0x0,edx
    2233:	0f 94 c0             	sete   al
    2236:	84 c0                	test   al,al
    2238:	74 d0                	je     220a <task_schedule+0x4d0>
										idx = 0;
    223a:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
								else
										goto get_idx;
						}
						if (nproc > 1)
    2241:	a1 00 00 00 00       	mov    eax,ds:0x0
    2246:	83 f8 01             	cmp    eax,0x1
    2249:	76 24                	jbe    226f <task_schedule+0x535>
								pr_lst[idx].proc = per_cpu_ptr()->apic_id;
    224b:	e8 b0 dd ff ff       	call   0 <per_cpu_ptr>
    2250:	89 c1                	mov    ecx,eax
    2252:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
    2258:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    225b:	89 d0                	mov    eax,edx
    225d:	c1 e0 02             	shl    eax,0x2
    2260:	01 d0                	add    eax,edx
    2262:	c1 e0 02             	shl    eax,0x2
    2265:	8d 14 03             	lea    edx,[ebx+eax*1]
    2268:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    226b:	89 02                	mov    DWORD PTR [edx],eax
    226d:	eb 1b                	jmp    228a <task_schedule+0x550>
						else
								pr_lst[idx].proc = 0;
    226f:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    2275:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2278:	89 d0                	mov    eax,edx
    227a:	c1 e0 02             	shl    eax,0x2
    227d:	01 d0                	add    eax,edx
    227f:	c1 e0 02             	shl    eax,0x2
    2282:	01 c8                	add    eax,ecx
    2284:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						pr_lst[idx].task_name = t->name;
    228a:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    2290:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2293:	89 d0                	mov    eax,edx
    2295:	c1 e0 02             	shl    eax,0x2
    2298:	01 d0                	add    eax,edx
    229a:	c1 e0 02             	shl    eax,0x2
    229d:	8d 14 01             	lea    edx,[ecx+eax*1]
    22a0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    22a3:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    22a6:	89 42 08             	mov    DWORD PTR [edx+0x8],eax
						pr_lst[idx].task_id = t->task_id;
    22a9:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    22af:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    22b2:	89 d0                	mov    eax,edx
    22b4:	c1 e0 02             	shl    eax,0x2
    22b7:	01 d0                	add    eax,edx
    22b9:	c1 e0 02             	shl    eax,0x2
    22bc:	8d 14 01             	lea    edx,[ecx+eax*1]
    22bf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    22c2:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    22c5:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
						pr_lst[idx].eip = instr_ptr(t);
    22c8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    22cb:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22ce:	8b 48 30             	mov    ecx,DWORD PTR [eax+0x30]
    22d1:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
    22d7:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    22da:	89 d0                	mov    eax,edx
    22dc:	c1 e0 02             	shl    eax,0x2
    22df:	01 d0                	add    eax,edx
    22e1:	c1 e0 02             	shl    eax,0x2
    22e4:	01 d8                	add    eax,ebx
    22e6:	89 ca                	mov    edx,ecx
    22e8:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
						pr_lst[idx].esp = stack_ptr(t);
    22eb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    22ee:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22f1:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
    22f4:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
    22fa:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    22fd:	89 d0                	mov    eax,edx
    22ff:	c1 e0 02             	shl    eax,0x2
    2302:	01 d0                	add    eax,edx
    2304:	c1 e0 02             	shl    eax,0x2
    2307:	01 d8                	add    eax,ebx
    2309:	89 ca                	mov    edx,ecx
    230b:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
				}
		}
		/* document the processor */
		if (nproc > 1)
    230e:	a1 00 00 00 00       	mov    eax,ds:0x0
    2313:	83 f8 01             	cmp    eax,0x1
    2316:	76 0d                	jbe    2325 <task_schedule+0x5eb>
				t->task_proc = smp_processor_id();
    2318:	e8 e3 dc ff ff       	call   0 <per_cpu_ptr>
    231d:	8b 10                	mov    edx,DWORD PTR [eax]
    231f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2322:	89 50 44             	mov    DWORD PTR [eax+0x44],edx
		/* reinsert the previous task (if we don't do so next time) */
		if (prev_task && (t != prev_task)) {
    2325:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    2329:	74 53                	je     237e <task_schedule+0x644>
    232b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    232e:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    2331:	74 4b                	je     237e <task_schedule+0x644>
				ri_queue[ri_ofs++] = prev_task;
    2333:	a1 00 00 00 00       	mov    eax,ds:0x0
    2338:	8d 50 01             	lea    edx,[eax+0x1]
    233b:	89 15 00 00 00 00    	mov    DWORD PTR ds:0x0,edx
    2341:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    2344:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
				if (ri_ofs == RI_LIMIT)
    234b:	a1 00 00 00 00       	mov    eax,ds:0x0
    2350:	83 f8 20             	cmp    eax,0x20
    2353:	75 29                	jne    237e <task_schedule+0x644>
						die("Use a larger reinsertion queue!\n");
    2355:	c7 44 24 04 18 04 00 00 	mov    DWORD PTR [esp+0x4],0x418
    235d:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2364:	e8 fc ff ff ff       	call   2365 <task_schedule+0x62b>
    2369:	e8 fc ff ff ff       	call   236a <task_schedule+0x630>
    236e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2375:	e8 fc ff ff ff       	call   2376 <task_schedule+0x63c>
    237a:	fa                   	cli
    237b:	f4                   	hlt
    237c:	eb fd                	jmp    237b <task_schedule+0x641>
		}
		spin_unlock(&pq_lock);
    237e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2385:	e8 fc ff ff ff       	call   2386 <task_schedule+0x64c>

		/* release stack */
		{ /* only rely on registers */
				register void* ctx = t->ts;
    238a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    238d:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
				if (prev_task && (t != prev_task))
    2390:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    2394:	74 17                	je     23ad <task_schedule+0x673>
    2396:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2399:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    239c:	74 0f                	je     23ad <task_schedule+0x673>
						prev_task->flags &= ~TIF_RUNNING;
    239e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    23a1:	8b 00                	mov    eax,DWORD PTR [eax]
    23a3:	83 e0 ef             	and    eax,0xffffffef
    23a6:	89 c2                	mov    edx,eax
    23a8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    23ab:	89 10                	mov    DWORD PTR [eax],edx
				longjmp(ctx);
    23ad:	89 dc                	mov    esp,ebx
    23af:	e9 fc ff ff ff       	jmp    23b0 <task_schedule+0x676>
    23b4:	eb 01                	jmp    23b7 <task_schedule+0x67d>
				return;    /* of the irq0 handler, i.e. where execution stopped. */
    23b6:	90                   	nop
		}
}
    23b7:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    23ba:	c9                   	leave
    23bb:	c3                   	ret

000023bc <task_schedule_isr>:

/* called from irq0/apic handler returning with iret via longjmp.
 * These handlers are gates, i.e. not-reentrant, ensuring that
 * they have always finished execution before the task switch. */
void task_schedule_isr(void* esp)
{
    23bc:	55                   	push   ebp
    23bd:	89 e5                	mov    ebp,esp
    23bf:	83 ec 28             	sub    esp,0x28
		struct tsi* t = get_task_esp(esp);
    23c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    23c5:	89 04 24             	mov    DWORD PTR [esp],eax
    23c8:	e8 fc ff ff ff       	call   23c9 <task_schedule_isr+0xd>
    23cd:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		task_schedule(t);
    23d0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    23d3:	89 04 24             	mov    DWORD PTR [esp],eax
    23d6:	e8 fc ff ff ff       	call   23d7 <task_schedule_isr+0x1b>
}
    23db:	90                   	nop
    23dc:	c9                   	leave
    23dd:	c3                   	ret

000023de <task_yield>:

void task_yield()
{
    23de:	55                   	push   ebp
    23df:	89 e5                	mov    ebp,esp
    23e1:	83 ec 28             	sub    esp,0x28
		struct tsi* t;
		if (preempt_needs_init)
    23e4:	a1 00 00 00 00       	mov    eax,ds:0x0
    23e9:	85 c0                	test   eax,eax
    23eb:	0f 85 9d 00 00 00    	jne    248e <task_yield+0xb0>
				return; /* shouldn't be called before preemption */
		t = get_task();
    23f1:	e8 fc ff ff ff       	call   23f2 <task_yield+0x14>
    23f6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (t->preempt_count) { /* don't yield nonpreemptable task */
    23f9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    23fc:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    23ff:	85 c0                	test   eax,eax
    2401:	0f 85 8a 00 00 00    	jne    2491 <task_yield+0xb3>
exit:
				return;
		}
		if (if_enabled())
    2407:	e8 08 dc ff ff       	call   14 <if_enabled>
    240c:	85 c0                	test   eax,eax
    240e:	74 29                	je     2439 <task_yield+0x5b>
				die("yielding in interrupt!\n");
    2410:	c7 44 24 04 cb 04 00 00 	mov    DWORD PTR [esp+0x4],0x4cb
    2418:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    241f:	e8 fc ff ff ff       	call   2420 <task_yield+0x42>
    2424:	e8 fc ff ff ff       	call   2425 <task_yield+0x47>
    2429:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2430:	e8 fc ff ff ff       	call   2431 <task_yield+0x53>
    2435:	fa                   	cli
    2436:	f4                   	hlt
    2437:	eb fd                	jmp    2436 <task_yield+0x58>
		void* ptr = &&exit;
    2439:	c7 45 f0 8c 24 00 00 	mov    DWORD PTR [ebp-0x10],0x248c
		asm volatile (
    2440:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2443:	fa                   	cli
    2444:	9c                   	pushf
    2445:	81 0c 24 00 02 00 00 	or     DWORD PTR [esp],0x200
    244c:	0e                   	push   cs
    244d:	50                   	push   eax
    244e:	60                   	pusha
    244f:	1e                   	push   ds
    2450:	06                   	push   es
    2451:	0f a0                	push   fs
    2453:	0f a8                	push   gs
    2455:	89 e0                	mov    eax,esp
    2457:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		: "=mr" (ptr) : "0" (ptr)
#ifdef __x86_64__
							 : "rax" /* we clobber rax */
#endif
							 );
		t->ts = ptr;
    245a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    245d:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2460:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		t->flags |= TIF_YIELDED;
    2463:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2466:	8b 00                	mov    eax,DWORD PTR [eax]
    2468:	83 c8 02             	or     eax,0x2
    246b:	89 c2                	mov    edx,eax
    246d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2470:	89 10                	mov    DWORD PTR [eax],edx
		/* NOPE! */
		//t->flags &= ~TIF_RUNNING;
		t->stop_time = task_gettime();
    2472:	e8 fc ff ff ff       	call   2473 <task_yield+0x95>
    2477:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    247a:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    247d:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
		task_schedule(t);
    2480:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2483:	89 04 24             	mov    DWORD PTR [esp],eax
    2486:	e8 fc ff ff ff       	call   2487 <task_yield+0xa9>
		goto exit;
    248b:	90                   	nop
				return;
    248c:	eb 03                	jmp    2491 <task_yield+0xb3>
				return; /* shouldn't be called before preemption */
    248e:	90                   	nop
    248f:	eb 01                	jmp    2492 <task_yield+0xb4>
				return;
    2491:	90                   	nop
}
    2492:	c9                   	leave
    2493:	c3                   	ret

00002494 <preempt_init>:

/* this function makes the kernel preemptable and is freeing the
 * previous main kernel stack at 0x60000-0x80000 */
void preempt_init()
{
    2494:	55                   	push   ebp
    2495:	89 e5                	mov    ebp,esp
    2497:	83 ec 18             	sub    esp,0x18
		asm ("cli");
    249a:	fa                   	cli
		pr_lst = kmalloc(128 * sizeof(*pr_lst));
    249b:	c7 04 24 00 0a 00 00 	mov    DWORD PTR [esp],0xa00
    24a2:	e8 fc ff ff ff       	call   24a3 <preempt_init+0xf>
    24a7:	a3 00 00 00 00       	mov    ds:0x0,eax
		extern void kinit(void*);
		extern void kredraw(void*);
		extern void kscrub(void*);
		task_spawn(kinit, NULL, PRIORITY_MAX);
    24ac:	c7 44 24 0c e3 04 00 00 	mov    DWORD PTR [esp+0xc],0x4e3
    24b4:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    24bc:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    24c4:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    24cb:	e8 fc ff ff ff       	call   24cc <preempt_init+0x38>
		task_spawn(kredraw, NULL, PRIORITY_MAX);
    24d0:	c7 44 24 0c e9 04 00 00 	mov    DWORD PTR [esp+0xc],0x4e9
    24d8:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    24e0:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    24e8:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    24ef:	e8 fc ff ff ff       	call   24f0 <preempt_init+0x5c>
		task_spawn(kscrub, NULL, PRIORITY_MIN);
    24f4:	c7 44 24 0c f1 04 00 00 	mov    DWORD PTR [esp+0xc],0x4f1
    24fc:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    2504:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    250c:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2513:	e8 fc ff ff ff       	call   2514 <preempt_init+0x80>
		/* at least n+1 idle task are needed */
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2518:	c7 44 24 0c f8 04 00 00 	mov    DWORD PTR [esp+0xc],0x4f8
    2520:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    2528:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2530:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2537:	e8 fc ff ff ff       	call   2538 <preempt_init+0xa4>
		task_spawn(kidle, NULL, PRIORITY_MIN);
    253c:	c7 44 24 0c f8 04 00 00 	mov    DWORD PTR [esp+0xc],0x4f8
    2544:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    254c:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2554:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    255b:	e8 fc ff ff ff       	call   255c <preempt_init+0xc8>
		preempt_needs_init = 0;
    2560:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
		task_schedule(NULL);
    256a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2571:	e8 fc ff ff ff       	call   2572 <preempt_init+0xde>
}
    2576:	90                   	nop
    2577:	c9                   	leave
    2578:	c3                   	ret
