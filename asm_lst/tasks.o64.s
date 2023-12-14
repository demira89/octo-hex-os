
tasks.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <per_cpu_ptr>:
		uint64_t r12;
		uint64_t r11;
		uint64_t r10;
		uint64_t r9;
		uint64_t r8;
		uint64_t rdi;
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 10          	sub    rsp,0x10
		uint64_t rsi;
		uint64_t rbp;
		uint64_t rsp;
       8:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
      11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		uint64_t rbx;
		uint64_t rdx;
		uint64_t rcx;
		uint64_t rax;
      15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
		uint64_t rip;
      19:	c9                   	leave
      1a:	c3                   	ret

000000000000001b <if_enabled>:
		if (diag++)
				return;
		framebuffer_redraw(&fb_initial);
		mdelay(1000);
		print_tasks();
		printf("PROC TASK TASK_NAME        EIP      ESP\n");
      1b:	55                   	push   rbp
      1c:	48 89 e5             	mov    rbp,rsp
      1f:	48 83 ec 10          	sub    rsp,0x10
		for (size_t i = end - 1; i != end; i--) {
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
      23:	9c                   	pushf
      24:	58                   	pop    rax
      25:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (!i)
						i = 128;
		}
}

void proc_add_time(uint64_t ns, uint32_t flags)
      29:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      2d:	83 e0 20             	and    eax,0x20
      30:	48 85 c0             	test   rax,rax
      33:	0f 95 c0             	setne  al
      36:	0f b6 c0             	movzx  eax,al
{
      39:	c9                   	leave
      3a:	c3                   	ret

000000000000003b <alloc_stack>:
{
      3b:	55                   	push   rbp
      3c:	48 89 e5             	mov    rbp,rsp
      3f:	48 83 ec 10          	sub    rsp,0x10
		while (kernel_stacks.free_stacks) {
      43:	eb 78                	jmp    bd <alloc_stack+0x82>
				rv = kernel_stacks.free_stacks;
      45:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 4c <alloc_stack+0x11>
      4c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (__sync_bool_compare_and_swap(&kernel_stacks.free_stacks, rv, *((void**)rv - 1))) {
      50:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      54:	48 83 e8 08          	sub    rax,0x8
      58:	48 8b 00             	mov    rax,QWORD PTR [rax]
      5b:	48 89 c2             	mov    rdx,rax
      5e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      62:	f0 48 0f b1 15 00 00 00 00 	lock cmpxchg QWORD PTR [rip+0x0],rdx        # 6b <alloc_stack+0x30>
      6b:	0f 94 c0             	sete   al
      6e:	84 c0                	test   al,al
      70:	74 4b                	je     bd <alloc_stack+0x82>
										rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_res));
      72:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 79 <alloc_stack+0x3e>
      79:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 80 <alloc_stack+0x45>
      80:	48 01 d0             	add    rax,rdx
      83:	48 c1 e0 0c          	shl    rax,0xc
      87:	48 f7 d8             	neg    rax
      8a:	48 89 c2             	mov    rdx,rax
						cprintf(KFMT_INFO, "stack from %p to %p reused\n", rv,
      8d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      91:	48 01 c2             	add    rdx,rax
      94:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      98:	48 89 d1             	mov    rcx,rdx
      9b:	48 89 c2             	mov    rdx,rax
      9e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
      a5:	bf 0b 00 00 00       	mov    edi,0xb
      aa:	b8 00 00 00 00       	mov    eax,0x0
      af:	e8 00 00 00 00       	call   b4 <alloc_stack+0x79>
						return rv;
      b4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      b8:	e9 18 01 00 00       	jmp    1d5 <alloc_stack+0x19a>
		while (kernel_stacks.free_stacks) {
      bd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c4 <alloc_stack+0x89>
      c4:	48 85 c0             	test   rax,rax
      c7:	0f 85 78 ff ff ff    	jne    45 <alloc_stack+0xa>
		rv = kernel_stacks.vm_ptr;
      cd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d4 <alloc_stack+0x99>
      d4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		rv += 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_guard + kernel_stacks.n_res);
      d8:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # df <alloc_stack+0xa4>
      df:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # e6 <alloc_stack+0xab>
      e6:	48 01 c2             	add    rdx,rax
      e9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f0 <alloc_stack+0xb5>
      f0:	48 01 d0             	add    rax,rdx
      f3:	48 c1 e0 0c          	shl    rax,0xc
      f7:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		if (rv > kernel_stacks.vm_top)
      fb:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 102 <alloc_stack+0xc7>
     102:	48 3b 45 f8          	cmp    rax,QWORD PTR [rbp-0x8]
     106:	73 0a                	jae    112 <alloc_stack+0xd7>
				return NULL;
     108:	b8 00 00 00 00       	mov    eax,0x0
     10d:	e9 c3 00 00 00       	jmp    1d5 <alloc_stack+0x19a>
						rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_guard),
     112:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 119 <alloc_stack+0xde>
     119:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 120 <alloc_stack+0xe5>
     120:	48 01 d0             	add    rax,rdx
     123:	48 c1 e0 0c          	shl    rax,0xc
     127:	48 f7 d8             	neg    rax
     12a:	48 89 c2             	mov    rdx,rax
     12d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     131:	48 01 d0             	add    rax,rdx
		rv = mm_alloc_vmem(&mm_kernel, kernel_stacks.n_alloc,
     134:	48 89 c2             	mov    rdx,rax
     137:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 13e <alloc_stack+0x103>
     13e:	b9 0c 00 00 00       	mov    ecx,0xc
     143:	48 89 c6             	mov    rsi,rax
     146:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     14d:	e8 00 00 00 00       	call   152 <alloc_stack+0x117>
     152:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (rv) {
     156:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     15b:	74 73                	je     1d0 <alloc_stack+0x195>
				rv += kernel_stacks.n_alloc * 4096;
     15d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 164 <alloc_stack+0x129>
     164:	48 c1 e0 0c          	shl    rax,0xc
     168:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
				kernel_stacks.vm_ptr = rv + 4096 * kernel_stacks.n_guard;
     16c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 173 <alloc_stack+0x138>
     173:	48 c1 e0 0c          	shl    rax,0xc
     177:	48 89 c2             	mov    rdx,rax
     17a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     17e:	48 01 d0             	add    rax,rdx
     181:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 188 <alloc_stack+0x14d>
								rv, rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_res));
     188:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 18f <alloc_stack+0x154>
     18f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 196 <alloc_stack+0x15b>
     196:	48 01 d0             	add    rax,rdx
     199:	48 c1 e0 0c          	shl    rax,0xc
     19d:	48 f7 d8             	neg    rax
     1a0:	48 89 c2             	mov    rdx,rax
				cprintf(KFMT_INFO, "alloc_stack(): from %p to %p\n",
     1a3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1a7:	48 01 c2             	add    rdx,rax
     1aa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ae:	48 89 d1             	mov    rcx,rdx
     1b1:	48 89 c2             	mov    rdx,rax
     1b4:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     1bb:	bf 0b 00 00 00       	mov    edi,0xb
     1c0:	b8 00 00 00 00       	mov    eax,0x0
     1c5:	e8 00 00 00 00       	call   1ca <alloc_stack+0x18f>
				return rv;
     1ca:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ce:	eb 05                	jmp    1d5 <alloc_stack+0x19a>
				return NULL;
     1d0:	b8 00 00 00 00       	mov    eax,0x0
}
     1d5:	c9                   	leave
     1d6:	c3                   	ret

00000000000001d7 <free_stack>:
{
     1d7:	55                   	push   rbp
     1d8:	48 89 e5             	mov    rbp,rsp
     1db:	48 83 ec 18          	sub    rsp,0x18
     1df:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		void** pptr = (void**)(stack_base - sizeof(void*));
     1e3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     1e7:	48 83 e8 08          	sub    rax,0x8
     1eb:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				*pptr = kernel_stacks.free_stacks;
     1ef:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1f6 <free_stack+0x1f>
     1f6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1fa:	48 89 10             	mov    QWORD PTR [rax],rdx
		} while (!__sync_bool_compare_and_swap(&kernel_stacks.free_stacks, *pptr, stack_base));
     1fd:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     201:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     205:	48 8b 00             	mov    rax,QWORD PTR [rax]
     208:	f0 48 0f b1 15 00 00 00 00 	lock cmpxchg QWORD PTR [rip+0x0],rdx        # 211 <free_stack+0x3a>
     211:	0f 94 c0             	sete   al
     214:	83 f0 01             	xor    eax,0x1
     217:	84 c0                	test   al,al
     219:	75 d4                	jne    1ef <free_stack+0x18>
}
     21b:	90                   	nop
     21c:	90                   	nop
     21d:	c9                   	leave
     21e:	c3                   	ret

000000000000021f <install_tss>:
{
     21f:	55                   	push   rbp
     220:	48 89 e5             	mov    rbp,rsp
     223:	48 83 ec 10          	sub    rsp,0x10
     227:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     22b:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		*(gdte + 1) = (uint64_t)tss_addr >> 32;
     22f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     233:	48 83 c0 08          	add    rax,0x8
     237:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     23b:	48 c1 ea 20          	shr    rdx,0x20
     23f:	48 89 10             	mov    QWORD PTR [rax],rdx
		*gdte = ((uint64_t)(tss_addr & 0x00ffffff) << 16) /* base */
     242:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     246:	48 c1 e0 10          	shl    rax,0x10
     24a:	48 89 c2             	mov    rdx,rax
     24d:	48 b8 00 00 ff ff ff 00 00 00 	movabs rax,0xffffff0000
     257:	48 21 c2             	and    rdx,rax
				+ ((uint64_t)(tss_addr & 0xff000000) << 32)
     25a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     25e:	48 c1 e0 20          	shl    rax,0x20
     262:	48 89 c1             	mov    rcx,rax
     265:	48 b8 00 00 00 00 00 00 00 ff 	movabs rax,0xff00000000000000
     26f:	48 21 c8             	and    rax,rcx
     272:	48 09 c2             	or     rdx,rax
				+ (sizeof(struct tss) - 1);
     275:	48 b8 67 00 00 00 00 89 40 00 	movabs rax,0x40890000000067
     27f:	48 01 c2             	add    rdx,rax
		*gdte = ((uint64_t)(tss_addr & 0x00ffffff) << 16) /* base */
     282:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     286:	48 89 10             	mov    QWORD PTR [rax],rdx
}
     289:	90                   	nop
     28a:	c9                   	leave
     28b:	c3                   	ret

000000000000028c <mmgr_init_tss>:
{
     28c:	55                   	push   rbp
     28d:	48 89 e5             	mov    rbp,rsp
     290:	48 83 ec 10          	sub    rsp,0x10
		uint64_t* gdt = &kernltss;
     294:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		void* stk = alloc_stack();
     29c:	b8 00 00 00 00       	mov    eax,0x0
     2a1:	e8 00 00 00 00       	call   2a6 <mmgr_init_tss+0x1a>
     2a6:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (stk)
     2aa:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     2af:	74 1a                	je     2cb <mmgr_init_tss+0x3f>
				printf("allocated interrupt stack for first TSS at %p\n", stk);
     2b1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     2b5:	48 89 c6             	mov    rsi,rax
     2b8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2bf:	b8 00 00 00 00       	mov    eax,0x0
     2c4:	e8 00 00 00 00       	call   2c9 <mmgr_init_tss+0x3d>
     2c9:	eb 02                	jmp    2cd <mmgr_init_tss+0x41>
		else while (1);
     2cb:	eb fe                	jmp    2cb <mmgr_init_tss+0x3f>
		main_tss.rsp0 = (uint64_t)stk;
     2cd:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     2d1:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2d8 <mmgr_init_tss+0x4c>
		main_tss.iomap = sizeof(struct tss);
     2d8:	66 c7 05 00 00 00 00 68 00 	mov    WORD PTR [rip+0x0],0x68        # 2e1 <mmgr_init_tss+0x55>
		install_tss(gdt, (intptr_t)&main_tss);
     2e1:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     2e8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2ec:	48 89 d6             	mov    rsi,rdx
     2ef:	48 89 c7             	mov    rdi,rax
     2f2:	e8 00 00 00 00       	call   2f7 <mmgr_init_tss+0x6b>
		asm volatile("ltr %%ax": : "a" (SEG_TSS_PL0));
     2f7:	b8 18 00 00 00       	mov    eax,0x18
     2fc:	0f 00 d8             	ltr    eax
		gdt = &intrtss;
     2ff:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		intr_tss.iomap = sizeof(struct tss);
     307:	66 c7 05 00 00 00 00 68 00 	mov    WORD PTR [rip+0x0],0x68        # 310 <mmgr_init_tss+0x84>
		intr_tss.ist1 = (uint64_t)stk;
     310:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     314:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 31b <mmgr_init_tss+0x8f>
		intr_tss.rsp0 = (uint64_t)stk;
     31b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     31f:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 326 <mmgr_init_tss+0x9a>
		install_tss(gdt, (uintptr_t)&intr_tss);
     326:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     32d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     331:	48 89 d6             	mov    rsi,rdx
     334:	48 89 c7             	mov    rdi,rax
     337:	e8 00 00 00 00       	call   33c <mmgr_init_tss+0xb0>
}
     33c:	90                   	nop
     33d:	c9                   	leave
     33e:	c3                   	ret

000000000000033f <pq_enqueue>:
{
     33f:	55                   	push   rbp
     340:	48 89 e5             	mov    rbp,rsp
     343:	53                   	push   rbx
     344:	48 83 ec 28          	sub    rsp,0x28
     348:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     34c:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		struct pqe* e = pq->queues[t->cur_priority];
     350:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     354:	8b 50 44             	mov    edx,DWORD PTR [rax+0x44]
     357:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     35b:	89 d2                	mov    edx,edx
     35d:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     361:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!e) {
     365:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     36a:	75 6c                	jne    3d8 <pq_enqueue+0x99>
				e = pq->queues[t->cur_priority] = kzalloc(sizeof(struct pqe));
     36c:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     370:	8b 58 44             	mov    ebx,DWORD PTR [rax+0x44]
     373:	bf 18 01 00 00       	mov    edi,0x118
     378:	e8 00 00 00 00       	call   37d <pq_enqueue+0x3e>
     37d:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     381:	89 d9                	mov    ecx,ebx
     383:	48 89 04 ca          	mov    QWORD PTR [rdx+rcx*8],rax
     387:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     38b:	89 da                	mov    edx,ebx
     38d:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     391:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				e->next = NULL;
     395:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     399:	48 c7 80 10 01 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x110],0x0
				e->cur = e->end = &e->tks[0];
     3a4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3a8:	48 8d 50 10          	lea    rdx,[rax+0x10]
     3ac:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3b0:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     3b4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3b8:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     3bc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3c0:	48 89 10             	mov    QWORD PTR [rax],rdx
				pq->queues[t->cur_priority] = e;
     3c3:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     3c7:	8b 50 44             	mov    edx,DWORD PTR [rax+0x44]
     3ca:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     3ce:	89 d1                	mov    ecx,edx
     3d0:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     3d4:	48 89 14 c8          	mov    QWORD PTR [rax+rcx*8],rdx
				if (e->end + 1 != e->cur) {
     3d8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3dc:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     3e0:	48 8d 50 08          	lea    rdx,[rax+0x8]
     3e4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3e8:	48 8b 00             	mov    rax,QWORD PTR [rax]
     3eb:	48 39 c2             	cmp    rdx,rax
     3ee:	0f 84 87 00 00 00    	je     47b <pq_enqueue+0x13c>
						if (!(e->cur == e->tks && (e->end + 1 == e->tks + COUNT_OF(e->tks)))) {
     3f4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3f8:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     3fb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     3ff:	48 83 c0 10          	add    rax,0x10
     403:	48 39 c2             	cmp    rdx,rax
     406:	75 1f                	jne    427 <pq_enqueue+0xe8>
     408:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     40c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     410:	48 8d 50 08          	lea    rdx,[rax+0x8]
     414:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     418:	48 83 c0 10          	add    rax,0x10
     41c:	48 05 00 01 00 00    	add    rax,0x100
     422:	48 39 c2             	cmp    rdx,rax
     425:	74 54                	je     47b <pq_enqueue+0x13c>
								*e->end = t;
     427:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     42b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     42f:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
     433:	48 89 10             	mov    QWORD PTR [rax],rdx
								if (++e->end == e->tks + COUNT_OF(e->tks))
     436:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     43a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     43e:	48 8d 50 08          	lea    rdx,[rax+0x8]
     442:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     446:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     44a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     44e:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     452:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     456:	48 83 c0 10          	add    rax,0x10
     45a:	48 05 00 01 00 00    	add    rax,0x100
     460:	48 39 c2             	cmp    rdx,rax
     463:	0f 85 91 00 00 00    	jne    4fa <pq_enqueue+0x1bb>
										e->end = &e->tks[0];
     469:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     46d:	48 8d 50 10          	lea    rdx,[rax+0x10]
     471:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     475:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
								return;
     479:	eb 7f                	jmp    4fa <pq_enqueue+0x1bb>
				if (!e->next) {
     47b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     47f:	48 8b 80 10 01 00 00 	mov    rax,QWORD PTR [rax+0x110]
     486:	48 85 c0             	test   rax,rax
     489:	75 5b                	jne    4e6 <pq_enqueue+0x1a7>
						e->next = kzalloc(sizeof(struct pqe));
     48b:	bf 18 01 00 00       	mov    edi,0x118
     490:	e8 00 00 00 00       	call   495 <pq_enqueue+0x156>
     495:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     499:	48 89 82 10 01 00 00 	mov    QWORD PTR [rdx+0x110],rax
						e->next->next = NULL;
     4a0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     4a4:	48 8b 80 10 01 00 00 	mov    rax,QWORD PTR [rax+0x110]
     4ab:	48 c7 80 10 01 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x110],0x0
						e->next->cur = e->next->end = &e->next->tks[0];
     4b6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     4ba:	48 8b 90 10 01 00 00 	mov    rdx,QWORD PTR [rax+0x110]
     4c1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     4c5:	48 8b 80 10 01 00 00 	mov    rax,QWORD PTR [rax+0x110]
     4cc:	48 83 c2 10          	add    rdx,0x10
     4d0:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     4d4:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     4d8:	48 8b 92 10 01 00 00 	mov    rdx,QWORD PTR [rdx+0x110]
     4df:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     4e3:	48 89 02             	mov    QWORD PTR [rdx],rax
				e = e->next;
     4e6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     4ea:	48 8b 80 10 01 00 00 	mov    rax,QWORD PTR [rax+0x110]
     4f1:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (e->end + 1 != e->cur) {
     4f5:	e9 de fe ff ff       	jmp    3d8 <pq_enqueue+0x99>
								return;
     4fa:	90                   	nop
}
     4fb:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     4ff:	c9                   	leave
     500:	c3                   	ret

0000000000000501 <pq_dequeue>:
{
     501:	55                   	push   rbp
     502:	48 89 e5             	mov    rbp,rsp
     505:	48 83 ec 28          	sub    rsp,0x28
     509:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		for (uint32_t p = PRIORITY_MAX; p <= PRIORITY_MIN; p++) {
     50d:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     514:	e9 87 00 00 00       	jmp    5a0 <pq_dequeue+0x9f>
				struct pqe* e = pq->queues[p];
     519:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     51d:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     520:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     524:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				while (e) {
     528:	eb 6b                	jmp    595 <pq_dequeue+0x94>
						if (e->cur != e->end) {
     52a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     52e:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     531:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     535:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     539:	48 39 c2             	cmp    rdx,rax
     53c:	74 48                	je     586 <pq_dequeue+0x85>
								rv = *e->cur++;
     53e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     542:	48 8b 00             	mov    rax,QWORD PTR [rax]
     545:	48 8d 48 08          	lea    rcx,[rax+0x8]
     549:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     54d:	48 89 0a             	mov    QWORD PTR [rdx],rcx
     550:	48 8b 00             	mov    rax,QWORD PTR [rax]
     553:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
								if (e->cur == (e->tks + COUNT_OF(e->tks)))
     557:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     55b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     55e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     562:	48 83 c0 10          	add    rax,0x10
     566:	48 05 00 01 00 00    	add    rax,0x100
     56c:	48 39 c2             	cmp    rdx,rax
     56f:	75 0f                	jne    580 <pq_dequeue+0x7f>
										e->cur = e->tks;
     571:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     575:	48 8d 50 10          	lea    rdx,[rax+0x10]
     579:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     57d:	48 89 10             	mov    QWORD PTR [rax],rdx
								return rv;
     580:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     584:	eb 29                	jmp    5af <pq_dequeue+0xae>
						e = e->next;
     586:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     58a:	48 8b 80 10 01 00 00 	mov    rax,QWORD PTR [rax+0x110]
     591:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				while (e) {
     595:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     59a:	75 8e                	jne    52a <pq_dequeue+0x29>
		for (uint32_t p = PRIORITY_MAX; p <= PRIORITY_MIN; p++) {
     59c:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     5a0:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
     5a4:	0f 86 6f ff ff ff    	jbe    519 <pq_dequeue+0x18>
		return NULL; /* major rotation */
     5aa:	b8 00 00 00 00       	mov    eax,0x0
}
     5af:	c9                   	leave
     5b0:	c3                   	ret

00000000000005b1 <get_stack>:
{
     5b1:	55                   	push   rbp
     5b2:	48 89 e5             	mov    rbp,rsp
     5b5:	48 83 ec 20          	sub    rsp,0x20
     5b9:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     5bd:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		if ((ptr < kernel_stacks.vm_base) || (ptr > kernel_stacks.vm_ptr)) {
     5c1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 5c8 <get_stack+0x17>
     5c8:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
     5cc:	72 0d                	jb     5db <get_stack+0x2a>
     5ce:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 5d5 <get_stack+0x24>
     5d5:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
     5d9:	73 0a                	jae    5e5 <get_stack+0x34>
				return -1;
     5db:	b8 ff ff ff ff       	mov    eax,0xffffffff
     5e0:	e9 97 00 00 00       	jmp    67c <get_stack+0xcb>
		ptr = (void*)((size_t)ptr - (size_t)kernel_stacks.vm_base);
     5e5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     5e9:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 5f0 <get_stack+0x3f>
     5f0:	48 29 d0             	sub    rax,rdx
     5f3:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		rv = (size_t)ptr / 4096;
     5f7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     5fb:	48 c1 e8 0c          	shr    rax,0xc
     5ff:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		np = kernel_stacks.n_alloc + kernel_stacks.n_guard + kernel_stacks.n_res;
     602:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 609 <get_stack+0x58>
     609:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 610 <get_stack+0x5f>
     610:	48 01 c2             	add    rdx,rax
     613:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 61a <get_stack+0x69>
     61a:	48 01 d0             	add    rax,rdx
     61d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		rv /= np;
     621:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     624:	48 98                	cdqe
     626:	ba 00 00 00 00       	mov    edx,0x0
     62b:	48 f7 75 f0          	div    QWORD PTR [rbp-0x10]
     62f:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		sl->limit = kernel_stacks.vm_base + rv * np * 4096;
     632:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 639 <get_stack+0x88>
     639:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     63c:	48 98                	cdqe
     63e:	48 0f af 45 f0       	imul   rax,QWORD PTR [rbp-0x10]
     643:	48 c1 e0 0c          	shl    rax,0xc
     647:	48 01 c2             	add    rdx,rax
     64a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     64e:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		sl->base = sl->limit + 4096 * (np - kernel_stacks.n_guard);
     652:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     656:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     65a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 661 <get_stack+0xb0>
     661:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
     665:	48 29 c1             	sub    rcx,rax
     668:	48 89 c8             	mov    rax,rcx
     66b:	48 c1 e0 0c          	shl    rax,0xc
     66f:	48 01 c2             	add    rdx,rax
     672:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     676:	48 89 10             	mov    QWORD PTR [rax],rdx
		return rv;
     679:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
     67c:	c9                   	leave
     67d:	c3                   	ret

000000000000067e <task_gettime>:
{
     67e:	55                   	push   rbp
     67f:	48 89 e5             	mov    rbp,rsp
     682:	53                   	push   rbx
     683:	48 83 ec 10          	sub    rsp,0x10
		if (cpu.invariant_tsc) {
     687:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 68d <task_gettime+0xf>
     68d:	85 c0                	test   eax,eax
     68f:	74 0b                	je     69c <task_gettime+0x1e>
				asm volatile ("rdtsc" : "=A" (rv));
     691:	0f 31                	rdtsc
     693:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     697:	e9 94 00 00 00       	jmp    730 <task_gettime+0xb2>
		} else if (cpu.has_apic) {
     69c:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 6a3 <task_gettime+0x25>
     6a3:	83 e0 02             	and    eax,0x2
     6a6:	84 c0                	test   al,al
     6a8:	74 78                	je     722 <task_gettime+0xa4>
				if (!apic_initialized)
     6aa:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 6b0 <task_gettime+0x32>
     6b0:	85 c0                	test   eax,eax
     6b2:	75 07                	jne    6bb <task_gettime+0x3d>
						return 0;
     6b4:	b8 00 00 00 00       	mov    eax,0x0
     6b9:	eb 79                	jmp    734 <task_gettime+0xb6>
				if (nproc > 1)
     6bb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 6c1 <task_gettime+0x43>
     6c1:	83 f8 01             	cmp    eax,0x1
     6c4:	76 39                	jbe    6ff <task_gettime+0x81>
						rv = (per_cpu_ptr()->ticks->tick << 32) | apic_reg(APIC_REG_TMRCURRCNT);
     6c6:	b8 00 00 00 00       	mov    eax,0x0
     6cb:	e8 30 f9 ff ff       	call   0 <per_cpu_ptr>
     6d0:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     6d4:	48 8b 00             	mov    rax,QWORD PTR [rax]
     6d7:	48 c1 e0 20          	shl    rax,0x20
     6db:	48 89 c3             	mov    rbx,rax
     6de:	b8 00 00 00 00       	mov    eax,0x0
     6e3:	e8 18 f9 ff ff       	call   0 <per_cpu_ptr>
     6e8:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     6ec:	48 05 90 03 00 00    	add    rax,0x390
     6f2:	8b 00                	mov    eax,DWORD PTR [rax]
     6f4:	89 c0                	mov    eax,eax
     6f6:	48 09 d8             	or     rax,rbx
     6f9:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     6fd:	eb 31                	jmp    730 <task_gettime+0xb2>
						rv = (jiffies << 32) | apic_bp_reg(APIC_REG_TMRCURRCNT);
     6ff:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 706 <task_gettime+0x88>
     706:	48 8b 00             	mov    rax,QWORD PTR [rax]
     709:	48 c1 e0 20          	shl    rax,0x20
     70d:	48 89 c2             	mov    rdx,rax
     710:	b8 90 03 ff ef       	mov    eax,0xefff0390
     715:	8b 00                	mov    eax,DWORD PTR [rax]
     717:	89 c0                	mov    eax,eax
     719:	48 09 d0             	or     rax,rdx
     71c:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     720:	eb 0e                	jmp    730 <task_gettime+0xb2>
			rv = jiffies;
     722:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 729 <task_gettime+0xab>
     729:	48 8b 00             	mov    rax,QWORD PTR [rax]
     72c:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		return rv;
     730:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
}
     734:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     738:	c9                   	leave
     739:	c3                   	ret

000000000000073a <get_task_esp>:
{
     73a:	55                   	push   rbp
     73b:	48 89 e5             	mov    rbp,rsp
     73e:	48 83 ec 30          	sub    rsp,0x30
     742:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		stk = get_stack(esp, &sl);
     746:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
     74a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     74e:	48 89 d6             	mov    rsi,rdx
     751:	48 89 c7             	mov    rdi,rax
     754:	e8 00 00 00 00       	call   759 <get_task_esp+0x1f>
     759:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (stk == -1) {
     75c:	83 7d fc ff          	cmp    DWORD PTR [rbp-0x4],0xffffffff
     760:	75 6c                	jne    7ce <get_task_esp+0x94>
				if (preempt_needs_init)
     762:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 768 <get_task_esp+0x2e>
     768:	85 c0                	test   eax,eax
     76a:	74 09                	je     775 <get_task_esp+0x3b>
						return &dummy;
     76c:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     773:	eb 6d                	jmp    7e2 <get_task_esp+0xa8>
				printf("kernel_stacks: %p to %p\n", kernel_stacks.vm_base, kernel_stacks.vm_ptr);
     775:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 77c <get_task_esp+0x42>
     77c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 783 <get_task_esp+0x49>
     783:	48 89 c6             	mov    rsi,rax
     786:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     78d:	b8 00 00 00 00       	mov    eax,0x0
     792:	e8 00 00 00 00       	call   797 <get_task_esp+0x5d>
				die("unkown stack at %p\n", esp);
     797:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     79b:	48 89 c2             	mov    rdx,rax
     79e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     7a5:	bf 0c 00 00 00       	mov    edi,0xc
     7aa:	b8 00 00 00 00       	mov    eax,0x0
     7af:	e8 00 00 00 00       	call   7b4 <get_task_esp+0x7a>
     7b4:	b8 00 00 00 00       	mov    eax,0x0
     7b9:	e8 00 00 00 00       	call   7be <get_task_esp+0x84>
     7be:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     7c5:	e8 00 00 00 00       	call   7ca <get_task_esp+0x90>
     7ca:	fa                   	cli
     7cb:	f4                   	hlt
     7cc:	eb fd                	jmp    7cb <get_task_esp+0x91>
		rv = sl.base;
     7ce:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     7d2:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		rv--;
     7d6:	48 81 6d f0 88 00 00 00 	sub    QWORD PTR [rbp-0x10],0x88
		return rv;
     7de:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
}
     7e2:	c9                   	leave
     7e3:	c3                   	ret

00000000000007e4 <get_task>:
{
     7e4:	55                   	push   rbp
     7e5:	48 89 e5             	mov    rbp,rsp
     7e8:	48 83 ec 10          	sub    rsp,0x10
		return get_task_esp(&dm);
     7ec:	48 8d 45 fc          	lea    rax,[rbp-0x4]
     7f0:	48 89 c7             	mov    rdi,rax
     7f3:	e8 00 00 00 00       	call   7f8 <get_task+0x14>
}
     7f8:	c9                   	leave
     7f9:	c3                   	ret

00000000000007fa <task_save_state>:
{
     7fa:	55                   	push   rbp
     7fb:	48 89 e5             	mov    rbp,rsp
     7fe:	48 83 ec 30          	sub    rsp,0x30
     802:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		if (esp->cs & 3) { /* RPL>0, i.e. call from usermode */
     806:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     80a:	48 8b 80 a8 00 00 00 	mov    rax,QWORD PTR [rax+0xa8]
     811:	83 e0 03             	and    eax,0x3
     814:	48 85 c0             	test   rax,rax
     817:	74 6f                	je     888 <task_save_state+0x8e>
				st = get_stack(esp, &sl);
     819:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
     81d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     821:	48 89 d6             	mov    rsi,rdx
     824:	48 89 c7             	mov    rdi,rax
     827:	e8 00 00 00 00       	call   82c <task_save_state+0x32>
     82c:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
								(void*)esp->rsp_rpl
     82f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     833:	48 8b 80 b8 00 00 00 	mov    rax,QWORD PTR [rax+0xb8]
				printf("irq0 from usermode with stack at %p\n",
     83a:	48 89 c6             	mov    rsi,rax
     83d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     844:	b8 00 00 00 00       	mov    eax,0x0
     849:	e8 00 00 00 00       	call   84e <task_save_state+0x54>
				printf("current esp: %p\n", esp);
     84e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     852:	48 89 c6             	mov    rsi,rax
     855:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     85c:	b8 00 00 00 00       	mov    eax,0x0
     861:	e8 00 00 00 00       	call   866 <task_save_state+0x6c>
				printf("cs: %x\n", esp->cs);
     866:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     86a:	48 8b 80 a8 00 00 00 	mov    rax,QWORD PTR [rax+0xa8]
     871:	48 89 c6             	mov    rsi,rax
     874:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     87b:	b8 00 00 00 00       	mov    eax,0x0
     880:	e8 00 00 00 00       	call   885 <task_save_state+0x8b>
				while (1);
     885:	90                   	nop
     886:	eb fd                	jmp    885 <task_save_state+0x8b>
		} else if ((size_t)esp <= 0x80000 && (size_t)esp > 0x60000) {
     888:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     88c:	48 3d 00 00 08 00    	cmp    rax,0x80000
     892:	77 0c                	ja     8a0 <task_save_state+0xa6>
     894:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     898:	48 3d 00 00 06 00    	cmp    rax,0x60000
     89e:	77 5d                	ja     8fd <task_save_state+0x103>
				st = get_stack(esp, &sl);
     8a0:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
     8a4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     8a8:	48 89 d6             	mov    rsi,rdx
     8ab:	48 89 c7             	mov    rdi,rax
     8ae:	e8 00 00 00 00       	call   8b3 <task_save_state+0xb9>
     8b3:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				if (st == -1) {
     8b6:	83 7d fc ff          	cmp    DWORD PTR [rbp-0x4],0xffffffff
     8ba:	75 13                	jne    8cf <task_save_state+0xd5>
						printf("unrecognized ring0 task!\n");
     8bc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     8c3:	b8 00 00 00 00       	mov    eax,0x0
     8c8:	e8 00 00 00 00       	call   8cd <task_save_state+0xd3>
     8cd:	eb 2e                	jmp    8fd <task_save_state+0x103>
				t = sl.base;
     8cf:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     8d3:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				t--;
     8d7:	48 81 6d f0 88 00 00 00 	sub    QWORD PTR [rbp-0x10],0x88
				t->ts = esp;
     8df:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     8e3:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     8e7:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				t->stop_time = task_gettime();
     8eb:	b8 00 00 00 00       	mov    eax,0x0
     8f0:	e8 00 00 00 00       	call   8f5 <task_save_state+0xfb>
     8f5:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     8f9:	48 89 42 50          	mov    QWORD PTR [rdx+0x50],rax
}
     8fd:	c9                   	leave
     8fe:	c3                   	ret

00000000000008ff <print_task>:
{
     8ff:	55                   	push   rbp
     900:	48 89 e5             	mov    rbp,rsp
     903:	41 57                	push   r15
     905:	41 56                	push   r14
     907:	41 55                	push   r13
     909:	41 54                	push   r12
     90b:	53                   	push   rbx
     90c:	48 81 ec 88 00 00 00 	sub    rsp,0x88
     913:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
		char proc_str[5] = "N/A";
     917:	c7 45 cb 4e 2f 41 00 	mov    DWORD PTR [rbp-0x35],0x412f4e
     91e:	c6 45 cf 00          	mov    BYTE PTR [rbp-0x31],0x0
		if (ts->task_proc != 0xffffffff)
     922:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     926:	8b 40 58             	mov    eax,DWORD PTR [rax+0x58]
     929:	83 f8 ff             	cmp    eax,0xffffffff
     92c:	74 26                	je     954 <print_task+0x55>
				snprintf(proc_str, 5, "%4u", ts->task_proc);
     92e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     932:	8b 50 58             	mov    edx,DWORD PTR [rax+0x58]
     935:	48 8d 45 cb          	lea    rax,[rbp-0x35]
     939:	89 d1                	mov    ecx,edx
     93b:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     942:	be 05 00 00 00       	mov    esi,0x5
     947:	48 89 c7             	mov    rdi,rax
     94a:	b8 00 00 00 00       	mov    eax,0x0
     94f:	e8 00 00 00 00       	call   954 <print_task+0x55>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     954:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     958:	8b 88 80 00 00 00    	mov    ecx,DWORD PTR [rax+0x80]
     95e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     962:	44 8b 70 7c          	mov    r14d,DWORD PTR [rax+0x7c]
     966:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     96a:	4c 8b 68 20          	mov    r13,QWORD PTR [rax+0x20]
     96e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     972:	44 8b 60 40          	mov    r12d,DWORD PTR [rax+0x40]
     976:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     97a:	8b 58 34             	mov    ebx,DWORD PTR [rax+0x34]
     97d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     981:	44 8b 58 38          	mov    r11d,DWORD PTR [rax+0x38]
				(uint32_t)(ts->ns_acc / 1000000000), ts->ns_per_sec / 1000000,
     985:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     989:	8b 40 78             	mov    eax,DWORD PTR [rax+0x78]
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     98c:	89 c0                	mov    eax,eax
     98e:	48 69 c0 83 de 1b 43 	imul   rax,rax,0x431bde83
     995:	48 c1 e8 20          	shr    rax,0x20
     999:	41 89 c7             	mov    r15d,eax
     99c:	41 c1 ef 12          	shr    r15d,0x12
				(uint32_t)(ts->ns_acc / 1000000000), ts->ns_per_sec / 1000000,
     9a0:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9a4:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
     9a8:	48 c1 e8 09          	shr    rax,0x9
     9ac:	48 ba 53 5a 9b a0 2f b8 44 00 	movabs rdx,0x44b82fa09b5a53
     9b6:	48 f7 e2             	mul    rdx
     9b9:	48 89 d0             	mov    rax,rdx
     9bc:	48 c1 e8 0b          	shr    rax,0xb
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     9c0:	89 45 b0             	mov    DWORD PTR [rbp-0x50],eax
     9c3:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9c7:	44 8b 50 44          	mov    r10d,DWORD PTR [rax+0x44]
     9cb:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9cf:	44 8b 48 3c          	mov    r9d,DWORD PTR [rax+0x3c]
     9d3:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9d7:	4c 8b 40 10          	mov    r8,QWORD PTR [rax+0x10]
				(ts->flags & TIF_YIELDED) ? 'Y' : ' ', proc_str,
     9db:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9df:	8b 00                	mov    eax,DWORD PTR [rax]
     9e1:	83 e0 02             	and    eax,0x2
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     9e4:	85 c0                	test   eax,eax
     9e6:	74 09                	je     9f1 <print_task+0xf2>
     9e8:	c7 45 b4 59 00 00 00 	mov    DWORD PTR [rbp-0x4c],0x59
     9ef:	eb 07                	jmp    9f8 <print_task+0xf9>
     9f1:	c7 45 b4 20 00 00 00 	mov    DWORD PTR [rbp-0x4c],0x20
				(ts->flags & TIF_KERNEL_STACK) ? ((ts->flags & TIF_IDLE) ? 'I' : 'K') : 'U',
     9f8:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9fc:	8b 00                	mov    eax,DWORD PTR [rax]
     9fe:	83 e0 08             	and    eax,0x8
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     a01:	85 c0                	test   eax,eax
     a03:	74 1b                	je     a20 <print_task+0x121>
				(ts->flags & TIF_KERNEL_STACK) ? ((ts->flags & TIF_IDLE) ? 'I' : 'K') : 'U',
     a05:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a09:	8b 00                	mov    eax,DWORD PTR [rax]
     a0b:	83 e0 40             	and    eax,0x40
     a0e:	85 c0                	test   eax,eax
     a10:	74 07                	je     a19 <print_task+0x11a>
     a12:	bf 49 00 00 00       	mov    edi,0x49
     a17:	eb 0c                	jmp    a25 <print_task+0x126>
     a19:	bf 4b 00 00 00       	mov    edi,0x4b
     a1e:	eb 05                	jmp    a25 <print_task+0x126>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     a20:	bf 55 00 00 00       	mov    edi,0x55
				(ts->flags & TIF_RUNNING) ? 'R' : (ts->flags & TIF_EXPIRED) ? 'X' : (ts->flags & TIF_SLEEPING) ? 'S': ' ',
     a25:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a29:	8b 00                	mov    eax,DWORD PTR [rax]
     a2b:	83 e0 10             	and    eax,0x10
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     a2e:	85 c0                	test   eax,eax
     a30:	75 31                	jne    a63 <print_task+0x164>
				(ts->flags & TIF_RUNNING) ? 'R' : (ts->flags & TIF_EXPIRED) ? 'X' : (ts->flags & TIF_SLEEPING) ? 'S': ' ',
     a32:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a36:	8b 00                	mov    eax,DWORD PTR [rax]
     a38:	83 e0 20             	and    eax,0x20
     a3b:	85 c0                	test   eax,eax
     a3d:	75 1d                	jne    a5c <print_task+0x15d>
     a3f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a43:	8b 00                	mov    eax,DWORD PTR [rax]
     a45:	25 80 00 00 00       	and    eax,0x80
     a4a:	85 c0                	test   eax,eax
     a4c:	74 07                	je     a55 <print_task+0x156>
     a4e:	ba 53 00 00 00       	mov    edx,0x53
     a53:	eb 13                	jmp    a68 <print_task+0x169>
     a55:	ba 20 00 00 00       	mov    edx,0x20
     a5a:	eb 0c                	jmp    a68 <print_task+0x169>
     a5c:	ba 58 00 00 00       	mov    edx,0x58
     a61:	eb 05                	jmp    a68 <print_task+0x169>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     a63:	ba 52 00 00 00       	mov    edx,0x52
     a68:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a6c:	8b 70 28             	mov    esi,DWORD PTR [rax+0x28]
     a6f:	48 8d 45 cb          	lea    rax,[rbp-0x35]
     a73:	89 4c 24 50          	mov    DWORD PTR [rsp+0x50],ecx
     a77:	44 89 74 24 48       	mov    DWORD PTR [rsp+0x48],r14d
     a7c:	4c 89 6c 24 40       	mov    QWORD PTR [rsp+0x40],r13
     a81:	44 89 64 24 38       	mov    DWORD PTR [rsp+0x38],r12d
     a86:	89 5c 24 30          	mov    DWORD PTR [rsp+0x30],ebx
     a8a:	44 89 5c 24 28       	mov    DWORD PTR [rsp+0x28],r11d
     a8f:	44 89 7c 24 20       	mov    DWORD PTR [rsp+0x20],r15d
     a94:	8b 5d b0             	mov    ebx,DWORD PTR [rbp-0x50]
     a97:	89 5c 24 18          	mov    DWORD PTR [rsp+0x18],ebx
     a9b:	44 89 54 24 10       	mov    DWORD PTR [rsp+0x10],r10d
     aa0:	44 89 4c 24 08       	mov    DWORD PTR [rsp+0x8],r9d
     aa5:	4c 89 04 24          	mov    QWORD PTR [rsp],r8
     aa9:	49 89 c1             	mov    r9,rax
     aac:	44 8b 45 b4          	mov    r8d,DWORD PTR [rbp-0x4c]
     ab0:	89 f9                	mov    ecx,edi
     ab2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     ab9:	b8 00 00 00 00       	mov    eax,0x0
     abe:	e8 00 00 00 00       	call   ac3 <print_task+0x1c4>
}
     ac3:	90                   	nop
     ac4:	48 81 c4 88 00 00 00 	add    rsp,0x88
     acb:	5b                   	pop    rbx
     acc:	41 5c                	pop    r12
     ace:	41 5d                	pop    r13
     ad0:	41 5e                	pop    r14
     ad2:	41 5f                	pop    r15
     ad4:	5d                   	pop    rbp
     ad5:	c3                   	ret

0000000000000ad6 <cpu_stat_counter>:
{
     ad6:	55                   	push   rbp
     ad7:	48 89 e5             	mov    rbp,rsp
     ada:	48 83 ec 20          	sub    rsp,0x20
     ade:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		if (nproc > 1) {
     ae1:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # ae7 <cpu_stat_counter+0x11>
     ae7:	83 f8 01             	cmp    eax,0x1
     aea:	76 26                	jbe    b12 <cpu_stat_counter+0x3c>
				struct processor_data* pd = get_cpu_data(id);
     aec:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     aef:	89 c7                	mov    edi,eax
     af1:	e8 00 00 00 00       	call   af6 <cpu_stat_counter+0x20>
     af6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (!pd)
     afa:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     aff:	75 07                	jne    b08 <cpu_stat_counter+0x32>
						return NULL;
     b01:	b8 00 00 00 00       	mov    eax,0x0
     b06:	eb 11                	jmp    b19 <cpu_stat_counter+0x43>
				return pd->ticks;
     b08:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     b0c:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     b10:	eb 07                	jmp    b19 <cpu_stat_counter+0x43>
				return bp_tick;
     b12:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b19 <cpu_stat_counter+0x43>
}
     b19:	c9                   	leave
     b1a:	c3                   	ret

0000000000000b1b <cpu_calc_percentages>:
{
     b1b:	55                   	push   rbp
     b1c:	48 89 e5             	mov    rbp,rsp
     b1f:	48 83 ec 30          	sub    rsp,0x30
     b23:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct perf_ctrs* pc = cpu_stat_counter(i);
     b27:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b2b:	89 c7                	mov    edi,eax
     b2d:	e8 00 00 00 00       	call   b32 <cpu_calc_percentages+0x17>
     b32:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!pc) {
     b36:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     b3b:	75 49                	jne    b86 <cpu_calc_percentages+0x6b>
				bzero(&cpu_pcs[i + 1], sizeof(cpu_pcs[i + 1]));
     b3d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b44 <cpu_calc_percentages+0x29>
     b44:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     b48:	48 83 c2 01          	add    rdx,0x1
     b4c:	48 c1 e2 05          	shl    rdx,0x5
     b50:	48 01 d0             	add    rax,rdx
     b53:	be 20 00 00 00       	mov    esi,0x20
     b58:	48 89 c7             	mov    rdi,rax
     b5b:	e8 00 00 00 00       	call   b60 <cpu_calc_percentages+0x45>
				cpu_pcs[i + 1].vals[0] = 0xffffffff;
     b60:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b67 <cpu_calc_percentages+0x4c>
     b67:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     b6b:	48 83 c2 01          	add    rdx,0x1
     b6f:	48 c1 e2 05          	shl    rdx,0x5
     b73:	48 01 d0             	add    rax,rdx
     b76:	c7 00 ff ff ff ff    	mov    DWORD PTR [rax],0xffffffff
				return -1;
     b7c:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b81:	e9 d9 01 00 00       	jmp    d5f <cpu_calc_percentages+0x244>
		cpu_pcs[0].vals[0] += pc->ns_idle_per_sec;
     b86:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b8d <cpu_calc_percentages+0x72>
     b8d:	8b 08                	mov    ecx,DWORD PTR [rax]
     b8f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     b93:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
     b96:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b9d <cpu_calc_percentages+0x82>
     b9d:	01 ca                	add    edx,ecx
     b9f:	89 10                	mov    DWORD PTR [rax],edx
		cpu_pcs[0].vals[1] += pc->ns_kernel_per_sec;
     ba1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ba8 <cpu_calc_percentages+0x8d>
     ba8:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
     bab:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     baf:	8b 50 3c             	mov    edx,DWORD PTR [rax+0x3c]
     bb2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # bb9 <cpu_calc_percentages+0x9e>
     bb9:	01 ca                	add    edx,ecx
     bbb:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
		cpu_pcs[0].vals[2] += pc->ns_user_per_sec;
     bbe:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # bc5 <cpu_calc_percentages+0xaa>
     bc5:	8b 48 08             	mov    ecx,DWORD PTR [rax+0x8]
     bc8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bcc:	8b 50 40             	mov    edx,DWORD PTR [rax+0x40]
     bcf:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # bd6 <cpu_calc_percentages+0xbb>
     bd6:	01 ca                	add    edx,ecx
     bd8:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
		cpu_pcs[0].vals[3] += 1000000000 - pc->ns_idle_per_sec
     bdb:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # be2 <cpu_calc_percentages+0xc7>
     be2:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
     be5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     be9:	8b 48 38             	mov    ecx,DWORD PTR [rax+0x38]
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     bec:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bf0:	8b 40 3c             	mov    eax,DWORD PTR [rax+0x3c]
     bf3:	01 c1                	add    ecx,eax
     bf5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bf9:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
     bfc:	01 c8                	add    eax,ecx
		cpu_pcs[0].vals[3] += 1000000000 - pc->ns_idle_per_sec
     bfe:	29 c2                	sub    edx,eax
     c00:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c07 <cpu_calc_percentages+0xec>
     c07:	81 c2 00 ca 9a 3b    	add    edx,0x3b9aca00
     c0d:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
		cpu_pcs[i + 1].vals[0] = pc->ns_idle_per_sec;
     c10:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c17 <cpu_calc_percentages+0xfc>
     c17:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     c1b:	48 83 c2 01          	add    rdx,0x1
     c1f:	48 c1 e2 05          	shl    rdx,0x5
     c23:	48 01 c2             	add    rdx,rax
     c26:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c2a:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
     c2d:	89 02                	mov    DWORD PTR [rdx],eax
		cpu_pcs[i + 1].vals[1] = pc->ns_kernel_per_sec;
     c2f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c36 <cpu_calc_percentages+0x11b>
     c36:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     c3a:	48 83 c2 01          	add    rdx,0x1
     c3e:	48 c1 e2 05          	shl    rdx,0x5
     c42:	48 01 c2             	add    rdx,rax
     c45:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c49:	8b 40 3c             	mov    eax,DWORD PTR [rax+0x3c]
     c4c:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
		cpu_pcs[i + 1].vals[2] = pc->ns_user_per_sec;
     c4f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c56 <cpu_calc_percentages+0x13b>
     c56:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     c5a:	48 83 c2 01          	add    rdx,0x1
     c5e:	48 c1 e2 05          	shl    rdx,0x5
     c62:	48 01 c2             	add    rdx,rax
     c65:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c69:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
     c6c:	89 42 08             	mov    DWORD PTR [rdx+0x8],eax
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     c6f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c73:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     c76:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c7a:	8b 40 3c             	mov    eax,DWORD PTR [rax+0x3c]
     c7d:	01 c2                	add    edx,eax
     c7f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c83:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
     c86:	8d 0c 02             	lea    ecx,[rdx+rax*1]
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     c89:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c90 <cpu_calc_percentages+0x175>
     c90:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     c94:	48 83 c2 01          	add    rdx,0x1
     c98:	48 c1 e2 05          	shl    rdx,0x5
     c9c:	48 01 d0             	add    rax,rdx
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     c9f:	ba 00 ca 9a 3b       	mov    edx,0x3b9aca00
     ca4:	29 ca                	sub    edx,ecx
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     ca6:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
		for (size_t j = 0; j < 4; j++) {
     ca9:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     cb1:	e9 99 00 00 00       	jmp    d4f <cpu_calc_percentages+0x234>
				const uint32_t ntot = 10000000;
     cb6:	c7 45 ec 80 96 98 00 	mov    DWORD PTR [rbp-0x14],0x989680
				uint32_t val = cpu_pcs[i + 1].vals[j];
     cbd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # cc4 <cpu_calc_percentages+0x1a9>
     cc4:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     cc8:	48 83 c2 01          	add    rdx,0x1
     ccc:	48 c1 e2 05          	shl    rdx,0x5
     cd0:	48 01 c2             	add    rdx,rax
     cd3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     cd7:	8b 04 82             	mov    eax,DWORD PTR [rdx+rax*4]
     cda:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
				cpu_pcs[i + 1].vals[j] = val / ntot;
     cdd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ce4 <cpu_calc_percentages+0x1c9>
     ce4:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     ce8:	48 83 c2 01          	add    rdx,0x1
     cec:	48 c1 e2 05          	shl    rdx,0x5
     cf0:	48 8d 0c 10          	lea    rcx,[rax+rdx*1]
     cf4:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     cf7:	ba 00 00 00 00       	mov    edx,0x0
     cfc:	f7 75 ec             	div    DWORD PTR [rbp-0x14]
     cff:	89 c2                	mov    edx,eax
     d01:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     d05:	89 14 81             	mov    DWORD PTR [rcx+rax*4],edx
				cpu_pcs[i + 1].vals[4 + j] = 10 * (val % ntot) / ntot;
     d08:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     d0b:	ba 00 00 00 00       	mov    edx,0x0
     d10:	f7 75 ec             	div    DWORD PTR [rbp-0x14]
     d13:	89 d0                	mov    eax,edx
     d15:	c1 e0 02             	shl    eax,0x2
     d18:	01 d0                	add    eax,edx
     d1a:	01 c0                	add    eax,eax
     d1c:	89 c7                	mov    edi,eax
     d1e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d25 <cpu_calc_percentages+0x20a>
     d25:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     d29:	48 83 c2 01          	add    rdx,0x1
     d2d:	48 c1 e2 05          	shl    rdx,0x5
     d31:	48 8d 0c 10          	lea    rcx,[rax+rdx*1]
     d35:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     d39:	48 8d 70 04          	lea    rsi,[rax+0x4]
     d3d:	89 f8                	mov    eax,edi
     d3f:	ba 00 00 00 00       	mov    edx,0x0
     d44:	f7 75 ec             	div    DWORD PTR [rbp-0x14]
     d47:	89 04 b1             	mov    DWORD PTR [rcx+rsi*4],eax
		for (size_t j = 0; j < 4; j++) {
     d4a:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     d4f:	48 83 7d f8 03       	cmp    QWORD PTR [rbp-0x8],0x3
     d54:	0f 86 5c ff ff ff    	jbe    cb6 <cpu_calc_percentages+0x19b>
		return 0;
     d5a:	b8 00 00 00 00       	mov    eax,0x0
}
     d5f:	c9                   	leave
     d60:	c3                   	ret

0000000000000d61 <cpu_do_stats>:
{
     d61:	55                   	push   rbp
     d62:	48 89 e5             	mov    rbp,rsp
     d65:	48 83 ec 20          	sub    rsp,0x20
		if (!cpu_pcs || (nproc != nproc_alloc)) {
     d69:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d70 <cpu_do_stats+0xf>
     d70:	48 85 c0             	test   rax,rax
     d73:	74 10                	je     d85 <cpu_do_stats+0x24>
     d75:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # d7b <cpu_do_stats+0x1a>
     d7b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # d81 <cpu_do_stats+0x20>
     d81:	39 c2                	cmp    edx,eax
     d83:	74 45                	je     dca <cpu_do_stats+0x69>
				if (cpu_pcs)
     d85:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d8c <cpu_do_stats+0x2b>
     d8c:	48 85 c0             	test   rax,rax
     d8f:	74 0f                	je     da0 <cpu_do_stats+0x3f>
						kfree(cpu_pcs);
     d91:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d98 <cpu_do_stats+0x37>
     d98:	48 89 c7             	mov    rdi,rax
     d9b:	e8 00 00 00 00       	call   da0 <cpu_do_stats+0x3f>
				cpu_pcs = kmalloc((nproc + 1) * sizeof(*cpu_pcs));
     da0:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # da6 <cpu_do_stats+0x45>
     da6:	83 c0 01             	add    eax,0x1
     da9:	89 c0                	mov    eax,eax
     dab:	48 c1 e0 05          	shl    rax,0x5
     daf:	48 89 c7             	mov    rdi,rax
     db2:	e8 00 00 00 00       	call   db7 <cpu_do_stats+0x56>
     db7:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # dbe <cpu_do_stats+0x5d>
				nproc_alloc = nproc;
     dbe:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # dc4 <cpu_do_stats+0x63>
     dc4:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # dca <cpu_do_stats+0x69>
		bzero(&cpu_pcs[0], sizeof(cpu_pcs[0]));
     dca:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # dd1 <cpu_do_stats+0x70>
     dd1:	be 20 00 00 00       	mov    esi,0x20
     dd6:	48 89 c7             	mov    rdi,rax
     dd9:	e8 00 00 00 00       	call   dde <cpu_do_stats+0x7d>
		size_t nval = 0; uint32_t ntot;
     dde:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		for (size_t i = 0; i < nproc; i++) {
     de6:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     dee:	eb 1e                	jmp    e0e <cpu_do_stats+0xad>
				if (-1 == cpu_calc_percentages(i))
     df0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     df4:	48 89 c7             	mov    rdi,rax
     df7:	e8 00 00 00 00       	call   dfc <cpu_do_stats+0x9b>
     dfc:	83 f8 ff             	cmp    eax,0xffffffff
     dff:	74 07                	je     e08 <cpu_do_stats+0xa7>
				nval++;
     e01:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     e06:	eb 01                	jmp    e09 <cpu_do_stats+0xa8>
						continue;
     e08:	90                   	nop
		for (size_t i = 0; i < nproc; i++) {
     e09:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
     e0e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # e14 <cpu_do_stats+0xb3>
     e14:	89 c0                	mov    eax,eax
     e16:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
     e1a:	72 d4                	jb     df0 <cpu_do_stats+0x8f>
		nproc_rep = nval;
     e1c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     e20:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # e26 <cpu_do_stats+0xc5>
		ntot = 10000000 * nval; /* div 100 */
     e26:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     e2a:	69 c0 80 96 98 00    	imul   eax,eax,0x989680
     e30:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
		if (!ntot)
     e33:	83 7d e4 00          	cmp    DWORD PTR [rbp-0x1c],0x0
     e37:	74 76                	je     eaf <cpu_do_stats+0x14e>
		for (size_t i = 0; i < 4; i++) {
     e39:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     e41:	eb 63                	jmp    ea6 <cpu_do_stats+0x145>
				uint32_t val = cpu_pcs[0].vals[i];
     e43:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # e4a <cpu_do_stats+0xe9>
     e4a:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     e4e:	8b 04 90             	mov    eax,DWORD PTR [rax+rdx*4]
     e51:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				cpu_pcs[0].vals[i] = val / ntot;
     e54:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # e5b <cpu_do_stats+0xfa>
     e5b:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
     e5e:	ba 00 00 00 00       	mov    edx,0x0
     e63:	f7 75 e4             	div    DWORD PTR [rbp-0x1c]
     e66:	89 c2                	mov    edx,eax
     e68:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e6c:	89 14 81             	mov    DWORD PTR [rcx+rax*4],edx
				cpu_pcs[0].vals[4 + i] = 10 * (val % ntot) / ntot;
     e6f:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
     e72:	ba 00 00 00 00       	mov    edx,0x0
     e77:	f7 75 e4             	div    DWORD PTR [rbp-0x1c]
     e7a:	89 d0                	mov    eax,edx
     e7c:	c1 e0 02             	shl    eax,0x2
     e7f:	01 d0                	add    eax,edx
     e81:	01 c0                	add    eax,eax
     e83:	89 c2                	mov    edx,eax
     e85:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # e8c <cpu_do_stats+0x12b>
     e8c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e90:	48 8d 70 04          	lea    rsi,[rax+0x4]
     e94:	89 d0                	mov    eax,edx
     e96:	ba 00 00 00 00       	mov    edx,0x0
     e9b:	f7 75 e4             	div    DWORD PTR [rbp-0x1c]
     e9e:	89 04 b1             	mov    DWORD PTR [rcx+rsi*4],eax
		for (size_t i = 0; i < 4; i++) {
     ea1:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     ea6:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
     eab:	76 96                	jbe    e43 <cpu_do_stats+0xe2>
     ead:	eb 01                	jmp    eb0 <cpu_do_stats+0x14f>
			return; /* div0 otherwise */
     eaf:	90                   	nop
}
     eb0:	c9                   	leave
     eb1:	c3                   	ret

0000000000000eb2 <print_cpus>:
{
     eb2:	55                   	push   rbp
     eb3:	48 89 e5             	mov    rbp,rsp
     eb6:	41 54                	push   r12
     eb8:	53                   	push   rbx
     eb9:	48 83 ec 40          	sub    rsp,0x40
		printf("listing cpus: %u total, %u provided data\n", nproc, nproc_rep);
     ebd:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # ec3 <print_cpus+0x11>
     ec3:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # ec9 <print_cpus+0x17>
     ec9:	89 c6                	mov    esi,eax
     ecb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     ed2:	b8 00 00 00 00       	mov    eax,0x0
     ed7:	e8 00 00 00 00       	call   edc <print_cpus+0x2a>
				cpu_pcs[0].vals[0], cpu_pcs[0].vals[4]); /* i pi */
     edc:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ee3 <print_cpus+0x31>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ee3:	44 8b 40 10          	mov    r8d,DWORD PTR [rax+0x10]
				cpu_pcs[0].vals[0], cpu_pcs[0].vals[4]); /* i pi */
     ee7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # eee <print_cpus+0x3c>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     eee:	8b 38                	mov    edi,DWORD PTR [rax]
				cpu_pcs[0].vals[3], cpu_pcs[0].vals[7], /* ni pni */
     ef0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ef7 <print_cpus+0x45>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ef7:	8b 70 1c             	mov    esi,DWORD PTR [rax+0x1c]
				cpu_pcs[0].vals[3], cpu_pcs[0].vals[7], /* ni pni */
     efa:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f01 <print_cpus+0x4f>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     f01:	44 8b 48 0c          	mov    r9d,DWORD PTR [rax+0xc]
				cpu_pcs[0].vals[1], cpu_pcs[0].vals[5], /* k pk */
     f05:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f0c <print_cpus+0x5a>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     f0c:	44 8b 50 14          	mov    r10d,DWORD PTR [rax+0x14]
				cpu_pcs[0].vals[1], cpu_pcs[0].vals[5], /* k pk */
     f10:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f17 <print_cpus+0x65>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     f17:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
				cpu_pcs[0].vals[2], cpu_pcs[0].vals[6], /* u pu */
     f1a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f21 <print_cpus+0x6f>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     f21:	8b 50 18             	mov    edx,DWORD PTR [rax+0x18]
				cpu_pcs[0].vals[2], cpu_pcs[0].vals[6], /* u pu */
     f24:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f2b <print_cpus+0x79>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     f2b:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
     f2e:	44 89 44 24 10       	mov    DWORD PTR [rsp+0x10],r8d
     f33:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
     f37:	89 34 24             	mov    DWORD PTR [rsp],esi
     f3a:	45 89 d0             	mov    r8d,r10d
     f3d:	89 c6                	mov    esi,eax
     f3f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f46:	b8 00 00 00 00       	mov    eax,0x0
     f4b:	e8 00 00 00 00       	call   f50 <print_cpus+0x9e>
		for (size_t i = 0; i < nproc; i++) {
     f50:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     f58:	e9 5e 01 00 00       	jmp    10bb <print_cpus+0x209>
				if (cpu_pcs[i + 1].vals[0] == 0xffffffff) {
     f5d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f64 <print_cpus+0xb2>
     f64:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     f68:	48 83 c2 01          	add    rdx,0x1
     f6c:	48 c1 e2 05          	shl    rdx,0x5
     f70:	48 01 d0             	add    rax,rdx
     f73:	8b 00                	mov    eax,DWORD PTR [rax]
     f75:	83 f8 ff             	cmp    eax,0xffffffff
     f78:	75 16                	jne    f90 <print_cpus+0xde>
						printf("%%Cpu%-3u: N/A\n");
     f7a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f81:	b8 00 00 00 00       	mov    eax,0x0
     f86:	e8 00 00 00 00       	call   f8b <print_cpus+0xd9>
						continue;
     f8b:	e9 26 01 00 00       	jmp    10b6 <print_cpus+0x204>
				struct perf_ctrs* pc = get_cpu_data(i)->ticks;
     f90:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     f94:	89 c7                	mov    edi,eax
     f96:	e8 00 00 00 00       	call   f9b <print_cpus+0xe9>
     f9b:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     f9f:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     fa3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     fa7:	44 8b 58 44          	mov    r11d,DWORD PTR [rax+0x44]
     fab:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     faf:	44 8b 50 48          	mov    r10d,DWORD PTR [rax+0x48]
						cpu_pcs[i + 1].vals[0], cpu_pcs[i + 1].vals[4], /* i pi */
     fb3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fba <print_cpus+0x108>
     fba:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     fbe:	48 83 c2 01          	add    rdx,0x1
     fc2:	48 c1 e2 05          	shl    rdx,0x5
     fc6:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     fc9:	44 8b 48 10          	mov    r9d,DWORD PTR [rax+0x10]
						cpu_pcs[i + 1].vals[0], cpu_pcs[i + 1].vals[4], /* i pi */
     fcd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fd4 <print_cpus+0x122>
     fd4:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     fd8:	48 83 c2 01          	add    rdx,0x1
     fdc:	48 c1 e2 05          	shl    rdx,0x5
     fe0:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     fe3:	44 8b 00             	mov    r8d,DWORD PTR [rax]
						cpu_pcs[i + 1].vals[3], cpu_pcs[i + 1].vals[7], /* ni pni */
     fe6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fed <print_cpus+0x13b>
     fed:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     ff1:	48 83 c2 01          	add    rdx,0x1
     ff5:	48 c1 e2 05          	shl    rdx,0x5
     ff9:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     ffc:	8b 78 1c             	mov    edi,DWORD PTR [rax+0x1c]
						cpu_pcs[i + 1].vals[3], cpu_pcs[i + 1].vals[7], /* ni pni */
     fff:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1006 <print_cpus+0x154>
    1006:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    100a:	48 83 c2 01          	add    rdx,0x1
    100e:	48 c1 e2 05          	shl    rdx,0x5
    1012:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
    1015:	8b 70 0c             	mov    esi,DWORD PTR [rax+0xc]
						cpu_pcs[i + 1].vals[1], cpu_pcs[i + 1].vals[5], /* k pk */
    1018:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 101f <print_cpus+0x16d>
    101f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1023:	48 83 c2 01          	add    rdx,0x1
    1027:	48 c1 e2 05          	shl    rdx,0x5
    102b:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
    102e:	44 8b 60 14          	mov    r12d,DWORD PTR [rax+0x14]
						cpu_pcs[i + 1].vals[1], cpu_pcs[i + 1].vals[5], /* k pk */
    1032:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1039 <print_cpus+0x187>
    1039:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    103d:	48 83 c2 01          	add    rdx,0x1
    1041:	48 c1 e2 05          	shl    rdx,0x5
    1045:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
    1048:	8b 58 04             	mov    ebx,DWORD PTR [rax+0x4]
						cpu_pcs[i + 1].vals[2], cpu_pcs[i + 1].vals[6], /* u pu */
    104b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1052 <print_cpus+0x1a0>
    1052:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1056:	48 83 c2 01          	add    rdx,0x1
    105a:	48 c1 e2 05          	shl    rdx,0x5
    105e:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
    1061:	8b 48 18             	mov    ecx,DWORD PTR [rax+0x18]
						cpu_pcs[i + 1].vals[2], cpu_pcs[i + 1].vals[6], /* u pu */
    1064:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 106b <print_cpus+0x1b9>
    106b:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    106f:	48 83 c2 01          	add    rdx,0x1
    1073:	48 c1 e2 05          	shl    rdx,0x5
    1077:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
    107a:	8b 50 08             	mov    edx,DWORD PTR [rax+0x8]
    107d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1081:	44 89 5c 24 28       	mov    DWORD PTR [rsp+0x28],r11d
    1086:	44 89 54 24 20       	mov    DWORD PTR [rsp+0x20],r10d
    108b:	44 89 4c 24 18       	mov    DWORD PTR [rsp+0x18],r9d
    1090:	44 89 44 24 10       	mov    DWORD PTR [rsp+0x10],r8d
    1095:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    1099:	89 34 24             	mov    DWORD PTR [rsp],esi
    109c:	45 89 e1             	mov    r9d,r12d
    109f:	41 89 d8             	mov    r8d,ebx
    10a2:	48 89 c6             	mov    rsi,rax
    10a5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    10ac:	b8 00 00 00 00       	mov    eax,0x0
    10b1:	e8 00 00 00 00       	call   10b6 <print_cpus+0x204>
		for (size_t i = 0; i < nproc; i++) {
    10b6:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    10bb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 10c1 <print_cpus+0x20f>
    10c1:	89 c0                	mov    eax,eax
    10c3:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    10c7:	0f 82 90 fe ff ff    	jb     f5d <print_cpus+0xab>
}
    10cd:	90                   	nop
    10ce:	90                   	nop
    10cf:	48 83 c4 40          	add    rsp,0x40
    10d3:	5b                   	pop    rbx
    10d4:	41 5c                	pop    r12
    10d6:	5d                   	pop    rbp
    10d7:	c3                   	ret

00000000000010d8 <print_tasks>:
{
    10d8:	55                   	push   rbp
    10d9:	48 89 e5             	mov    rbp,rsp
    10dc:	48 83 ec 10          	sub    rsp,0x10
		const char* md = "";
    10e0:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		if (cpu.invariant_tsc)
    10e8:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 10ee <print_tasks+0x16>
    10ee:	85 c0                	test   eax,eax
    10f0:	74 0a                	je     10fc <print_tasks+0x24>
				md = "inv_tsc";
    10f2:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    10fa:	eb 20                	jmp    111c <print_tasks+0x44>
		else if (cpu.has_apic)
    10fc:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1103 <print_tasks+0x2b>
    1103:	83 e0 02             	and    eax,0x2
    1106:	84 c0                	test   al,al
    1108:	74 0a                	je     1114 <print_tasks+0x3c>
				md = "apic timer";
    110a:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    1112:	eb 08                	jmp    111c <print_tasks+0x44>
				md = "PIT ticks";
    1114:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		printf("Tasks:%4u total,%4u running,%4u pending,%4u sleeping\n",
    111c:	8b 35 00 00 00 00    	mov    esi,DWORD PTR [rip+0x0]        # 1122 <print_tasks+0x4a>
    1122:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 1128 <print_tasks+0x50>
    1128:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 112e <print_tasks+0x56>
    112e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1135 <print_tasks+0x5d>
    1135:	41 89 f0             	mov    r8d,esi
    1138:	48 89 c6             	mov    rsi,rax
    113b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1142:	b8 00 00 00 00       	mov    eax,0x0
    1147:	e8 00 00 00 00       	call   114c <print_tasks+0x74>
		printf("Task time:%6u secs total, %4u ms last sec, mode: %s\n",
    114c:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 1152 <print_tasks+0x7a>
    1152:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1158 <print_tasks+0x80>
    1158:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    115c:	89 c6                	mov    esi,eax
    115e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1165:	b8 00 00 00 00       	mov    eax,0x0
    116a:	e8 00 00 00 00       	call   116f <print_tasks+0x97>
		print_cpus();
    116f:	b8 00 00 00 00       	mov    eax,0x0
    1174:	e8 00 00 00 00       	call   1179 <print_tasks+0xa1>
		printf("listing tasks: %u total" STAT_COUNTER("  major rotations: %u")  "\n", n_tks STAT_ARG(sched_mr_count));
    1179:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 117f <print_tasks+0xa7>
    117f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1186 <print_tasks+0xae>
    1186:	48 89 c6             	mov    rsi,rax
    1189:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1190:	b8 00 00 00 00       	mov    eax,0x0
    1195:	e8 00 00 00 00       	call   119a <print_tasks+0xc2>
		printf("ID FLG PROC STACK    PRIORITY  RUNTIME[ms] RUNTIME      QTA NAME        " STAT_COUNTER("SCHED  ") "\n"
    119a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    11a1:	b8 00 00 00 00       	mov    eax,0x0
    11a6:	e8 00 00 00 00       	call   11ab <print_tasks+0xd3>
		for (size_t i = 0; i < n_tks; i++)
    11ab:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    11b3:	eb 19                	jmp    11ce <print_tasks+0xf6>
				print_task(tks[i]);
    11b5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    11b9:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    11c1:	48 89 c7             	mov    rdi,rax
    11c4:	e8 00 00 00 00       	call   11c9 <print_tasks+0xf1>
		for (size_t i = 0; i < n_tks; i++)
    11c9:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    11ce:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 11d5 <print_tasks+0xfd>
    11d5:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    11d9:	72 da                	jb     11b5 <print_tasks+0xdd>
}
    11db:	90                   	nop
    11dc:	90                   	nop
    11dd:	c9                   	leave
    11de:	c3                   	ret

00000000000011df <task_do_stats>:
{
    11df:	55                   	push   rbp
    11e0:	48 89 e5             	mov    rbp,rsp
    11e3:	48 83 ec 20          	sub    rsp,0x20
		bzero(&task_stats, sizeof(task_stats));
    11e7:	be 14 00 00 00       	mov    esi,0x14
    11ec:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    11f3:	e8 00 00 00 00       	call   11f8 <task_do_stats+0x19>
		for (size_t i = 0; i < n_tks; i++) {
    11f8:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    1200:	e9 13 01 00 00       	jmp    1318 <task_do_stats+0x139>
				struct tsi* t = tks[i];
    1205:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1209:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    1211:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if (!t)
    1215:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    121a:	0f 84 f2 00 00 00    	je     1312 <task_do_stats+0x133>
				t->run_time_sec = t->run_time - t->sec_run_time;
    1220:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1224:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
    1227:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    122b:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    122e:	29 c2                	sub    edx,eax
    1230:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1234:	89 50 34             	mov    DWORD PTR [rax+0x34],edx
				t->sec_run_time = t->run_time;
    1237:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    123b:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
    123e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1242:	89 50 30             	mov    DWORD PTR [rax+0x30],edx
				t->ns_per_sec = t->ns_acc - t->sec_ns_acc;
    1245:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1249:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
    124d:	89 c2                	mov    edx,eax
    124f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1253:	48 8b 40 70          	mov    rax,QWORD PTR [rax+0x70]
    1257:	29 c2                	sub    edx,eax
    1259:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    125d:	89 50 78             	mov    DWORD PTR [rax+0x78],edx
				t->sec_ns_acc = t->ns_acc;
    1260:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1264:	48 8b 50 68          	mov    rdx,QWORD PTR [rax+0x68]
    1268:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    126c:	48 89 50 70          	mov    QWORD PTR [rax+0x70],rdx
				if (t->flags & TIF_RUNNING)
    1270:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1274:	8b 00                	mov    eax,DWORD PTR [rax]
    1276:	83 e0 10             	and    eax,0x10
    1279:	85 c0                	test   eax,eax
    127b:	74 11                	je     128e <task_do_stats+0xaf>
						task_stats.n_running++;
    127d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1283 <task_do_stats+0xa4>
    1283:	83 c0 01             	add    eax,0x1
    1286:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 128c <task_do_stats+0xad>
    128c:	eb 2f                	jmp    12bd <task_do_stats+0xde>
				else if (t->flags & TIF_SLEEPING)
    128e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1292:	8b 00                	mov    eax,DWORD PTR [rax]
    1294:	25 80 00 00 00       	and    eax,0x80
    1299:	85 c0                	test   eax,eax
    129b:	74 11                	je     12ae <task_do_stats+0xcf>
						task_stats.n_sleeping++;
    129d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 12a3 <task_do_stats+0xc4>
    12a3:	83 c0 01             	add    eax,0x1
    12a6:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 12ac <task_do_stats+0xcd>
    12ac:	eb 0f                	jmp    12bd <task_do_stats+0xde>
						task_stats.n_pending++;
    12ae:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 12b4 <task_do_stats+0xd5>
    12b4:	83 c0 01             	add    eax,0x1
    12b7:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 12bd <task_do_stats+0xde>
				task_stats.tot_runtime += (uint32_t)(t->ns_acc / 1000000000llu);
    12bd:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 12c3 <task_do_stats+0xe4>
    12c3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    12c7:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
    12cb:	48 c1 e8 09          	shr    rax,0x9
    12cf:	48 ba 53 5a 9b a0 2f b8 44 00 	movabs rdx,0x44b82fa09b5a53
    12d9:	48 f7 e2             	mul    rdx
    12dc:	48 89 d0             	mov    rax,rdx
    12df:	48 c1 e8 0b          	shr    rax,0xb
    12e3:	01 c8                	add    eax,ecx
    12e5:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 12eb <task_do_stats+0x10c>
				task_stats.sec_runtime += t->ns_per_sec / 1000000;
    12eb:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 12f1 <task_do_stats+0x112>
    12f1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    12f5:	8b 40 78             	mov    eax,DWORD PTR [rax+0x78]
    12f8:	89 c0                	mov    eax,eax
    12fa:	48 69 c0 83 de 1b 43 	imul   rax,rax,0x431bde83
    1301:	48 c1 e8 20          	shr    rax,0x20
    1305:	c1 e8 12             	shr    eax,0x12
    1308:	01 d0                	add    eax,edx
    130a:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 1310 <task_do_stats+0x131>
    1310:	eb 01                	jmp    1313 <task_do_stats+0x134>
						continue;
    1312:	90                   	nop
		for (size_t i = 0; i < n_tks; i++) {
    1313:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    1318:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 131f <task_do_stats+0x140>
    131f:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    1323:	0f 82 dc fe ff ff    	jb     1205 <task_do_stats+0x26>
		for (size_t i = 0; i < nproc; i++) {
    1329:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1331:	e9 c8 00 00 00       	jmp    13fe <task_do_stats+0x21f>
				struct perf_ctrs* pc = cpu_stat_counter(i);
    1336:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    133a:	89 c7                	mov    edi,eax
    133c:	e8 00 00 00 00       	call   1341 <task_do_stats+0x162>
    1341:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!pc)
    1345:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    134a:	0f 84 a8 00 00 00    	je     13f8 <task_do_stats+0x219>
				pc->ns_idle_per_sec = pc->ns_idle - pc->sec_ns_idle;
    1350:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1354:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1358:	89 c2                	mov    edx,eax
    135a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    135e:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1362:	29 c2                	sub    edx,eax
    1364:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1368:	89 50 38             	mov    DWORD PTR [rax+0x38],edx
				pc->sec_ns_idle = pc->ns_idle;
    136b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    136f:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    1373:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1377:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
				pc->ns_user_per_sec = pc->ns_user - pc->sec_ns_user;
    137b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    137f:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1383:	89 c2                	mov    edx,eax
    1385:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1389:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    138d:	29 c2                	sub    edx,eax
    138f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1393:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
				pc->sec_ns_user = pc->ns_user;
    1396:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    139a:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
    139e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13a2:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
				pc->ns_kernel_per_sec = pc->ns_kernel - pc->sec_ns_kernel;
    13a6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13aa:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    13ae:	89 c2                	mov    edx,eax
    13b0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13b4:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    13b8:	29 c2                	sub    edx,eax
    13ba:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13be:	89 50 3c             	mov    DWORD PTR [rax+0x3c],edx
				pc->sec_ns_kernel = pc->ns_kernel;
    13c1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13c5:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    13c9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13cd:	48 89 50 28          	mov    QWORD PTR [rax+0x28],rdx
				pc->n_times_per_sec = pc->n_times - pc->sec_n_times;
    13d1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13d5:	8b 50 44             	mov    edx,DWORD PTR [rax+0x44]
    13d8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13dc:	8b 40 4c             	mov    eax,DWORD PTR [rax+0x4c]
    13df:	29 c2                	sub    edx,eax
    13e1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13e5:	89 50 48             	mov    DWORD PTR [rax+0x48],edx
				pc->sec_n_times = pc->n_times;
    13e8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13ec:	8b 50 44             	mov    edx,DWORD PTR [rax+0x44]
    13ef:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13f3:	89 50 4c             	mov    DWORD PTR [rax+0x4c],edx
    13f6:	eb 01                	jmp    13f9 <task_do_stats+0x21a>
						continue;
    13f8:	90                   	nop
		for (size_t i = 0; i < nproc; i++) {
    13f9:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    13fe:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1404 <task_do_stats+0x225>
    1404:	89 c0                	mov    eax,eax
    1406:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    140a:	0f 82 26 ff ff ff    	jb     1336 <task_do_stats+0x157>
		cpu_do_stats();
    1410:	b8 00 00 00 00       	mov    eax,0x0
    1415:	e8 00 00 00 00       	call   141a <task_do_stats+0x23b>
}
    141a:	90                   	nop
    141b:	c9                   	leave
    141c:	c3                   	ret

000000000000141d <task_initfunc>:
{
    141d:	55                   	push   rbp
    141e:	48 89 e5             	mov    rbp,rsp
    1421:	48 83 ec 10          	sub    rsp,0x10
		asm volatile("mov %%rax, %0" : "=rm" (fun) );
    1425:	48 89 c0             	mov    rax,rax
    1428:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		asm volatile("mov %%rcx, %0" : "=rm" (arg) );
    142c:	48 89 c8             	mov    rax,rcx
    142f:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		asm ("sti");
    1433:	fb                   	sti
		fun(arg);
    1434:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1438:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    143c:	48 89 c7             	mov    rdi,rax
    143f:	ff d2                	call   rdx
		get_task()->flags |= TIF_DEALLOCATE;
    1441:	b8 00 00 00 00       	mov    eax,0x0
    1446:	e8 00 00 00 00       	call   144b <task_initfunc+0x2e>
    144b:	8b 10                	mov    edx,DWORD PTR [rax]
    144d:	83 ca 04             	or     edx,0x4
    1450:	89 10                	mov    DWORD PTR [rax],edx
		task_yield();
    1452:	b8 00 00 00 00       	mov    eax,0x0
    1457:	e8 00 00 00 00       	call   145c <task_initfunc+0x3f>
				cprintf(KFMT_WARN, "Deallocated task is rescheduled. This should never happen!\n");
    145c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1463:	bf 0e 00 00 00       	mov    edi,0xe
    1468:	b8 00 00 00 00       	mov    eax,0x0
    146d:	e8 00 00 00 00       	call   1472 <task_initfunc+0x55>
				task_yield();
    1472:	b8 00 00 00 00       	mov    eax,0x0
    1477:	e8 00 00 00 00       	call   147c <task_initfunc+0x5f>
				cprintf(KFMT_WARN, "Deallocated task is rescheduled. This should never happen!\n");
    147c:	90                   	nop
    147d:	eb dd                	jmp    145c <task_initfunc+0x3f>

000000000000147f <task_spawn_named>:
{
    147f:	55                   	push   rbp
    1480:	48 89 e5             	mov    rbp,rsp
    1483:	48 81 ec e0 00 00 00 	sub    rsp,0xe0
    148a:	48 89 bd 38 ff ff ff 	mov    QWORD PTR [rbp-0xc8],rdi
    1491:	48 89 b5 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rsi
    1498:	89 95 2c ff ff ff    	mov    DWORD PTR [rbp-0xd4],edx
    149e:	48 89 8d 20 ff ff ff 	mov    QWORD PTR [rbp-0xe0],rcx
		if (n_tks < 128) {
    14a5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 14ac <task_spawn_named+0x2d>
    14ac:	48 83 f8 7f          	cmp    rax,0x7f
    14b0:	0f 87 76 02 00 00    	ja     172c <task_spawn_named+0x2ad>
				struct tsi ts = {0}; int flg;
    14b6:	48 8d 95 40 ff ff ff 	lea    rdx,[rbp-0xc0]
    14bd:	b8 00 00 00 00       	mov    eax,0x0
    14c2:	b9 11 00 00 00       	mov    ecx,0x11
    14c7:	48 89 d7             	mov    rdi,rdx
    14ca:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
				void* stk = alloc_stack();
    14cd:	b8 00 00 00 00       	mov    eax,0x0
    14d2:	e8 00 00 00 00       	call   14d7 <task_spawn_named+0x58>
    14d7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (!stk) {
    14db:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    14e0:	75 30                	jne    1512 <task_spawn_named+0x93>
						die("Failed to alloc stack!\n");
    14e2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    14e9:	bf 0c 00 00 00       	mov    edi,0xc
    14ee:	b8 00 00 00 00       	mov    eax,0x0
    14f3:	e8 00 00 00 00       	call   14f8 <task_spawn_named+0x79>
    14f8:	b8 00 00 00 00       	mov    eax,0x0
    14fd:	e8 00 00 00 00       	call   1502 <task_spawn_named+0x83>
    1502:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1509:	e8 00 00 00 00       	call   150e <task_spawn_named+0x8f>
    150e:	fa                   	cli
    150f:	f4                   	hlt
    1510:	eb fd                	jmp    150f <task_spawn_named+0x90>
				if ((flg = if_enabled()))
    1512:	b8 00 00 00 00       	mov    eax,0x0
    1517:	e8 ff ea ff ff       	call   1b <if_enabled>
    151c:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
    151f:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    1523:	74 13                	je     1538 <task_spawn_named+0xb9>
						preempt_disable();
    1525:	b8 00 00 00 00       	mov    eax,0x0
    152a:	e8 00 00 00 00       	call   152f <task_spawn_named+0xb0>
    152f:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    1532:	83 c2 01             	add    edx,0x1
    1535:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
				spin_lock(&pq_lock);
    1538:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    153f:	e8 00 00 00 00       	call   1544 <task_spawn_named+0xc5>
				struct tsi* pts = stk;
    1544:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1548:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				pts--;
    154c:	48 81 6d e8 88 00 00 00 	sub    QWORD PTR [rbp-0x18],0x88
				struct task_state* ti = (void*)pts;
    1554:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1558:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				ti--; /* store info at stack bottom */
    155c:	48 81 6d e0 c8 00 00 00 	sub    QWORD PTR [rbp-0x20],0xc8
				id = get_stack(stk, &sl);
    1564:	48 8d 55 c8          	lea    rdx,[rbp-0x38]
    1568:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    156c:	48 89 d6             	mov    rsi,rdx
    156f:	48 89 c7             	mov    rdi,rax
    1572:	e8 00 00 00 00       	call   1577 <task_spawn_named+0xf8>
    1577:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				ts.flags = TIF_KERNEL_STACK;
    157a:	c7 85 40 ff ff ff 08 00 00 00 	mov    DWORD PTR [rbp-0xc0],0x8
				ts.task_id = id;
    1584:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1587:	89 85 68 ff ff ff    	mov    DWORD PTR [rbp-0x98],eax
				ts.stack_base = sl.base;
    158d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1591:	48 89 85 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rax
				ts.stack_limit = sl.limit;
    1598:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    159c:	48 89 85 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rax
				ts.priority = ts.cur_priority = priority;
    15a3:	8b 85 2c ff ff ff    	mov    eax,DWORD PTR [rbp-0xd4]
    15a9:	89 45 84             	mov    DWORD PTR [rbp-0x7c],eax
    15ac:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    15af:	89 85 7c ff ff ff    	mov    DWORD PTR [rbp-0x84],eax
				ts.name = name;
    15b5:	48 8b 85 20 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe0]
    15bc:	48 89 85 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rax
				ts.quota = 10; ts.run_time = 0;
    15c3:	c7 45 80 0a 00 00 00 	mov    DWORD PTR [rbp-0x80],0xa
    15ca:	c7 85 78 ff ff ff 00 00 00 00 	mov    DWORD PTR [rbp-0x88],0x0
				ts.ts = ti;
    15d4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    15d8:	48 89 85 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rax
				ts.task_proc = 0xffffffff;
    15df:	c7 45 98 ff ff ff ff 	mov    DWORD PTR [rbp-0x68],0xffffffff
				bzero(ti, sizeof(*ti));
    15e6:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    15ea:	be c8 00 00 00       	mov    esi,0xc8
    15ef:	48 89 c7             	mov    rdi,rax
    15f2:	e8 00 00 00 00       	call   15f7 <task_spawn_named+0x178>
				ti->cs = SEG_CODE;
    15f7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    15fb:	48 c7 80 a8 00 00 00 08 00 00 00 	mov    QWORD PTR [rax+0xa8],0x8
				ti->ds = ti->es = SEG_DATA;
    1606:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    160a:	48 c7 40 10 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x10
    1612:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1616:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    161a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    161e:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
				ti->gs = SEG_DATA_PROC;
    1622:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1626:	48 c7 00 38 00 00 00 	mov    QWORD PTR [rax],0x38
				ti->fs = SEG_DATA;
    162d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1631:	48 c7 40 08 10 00 00 00 	mov    QWORD PTR [rax+0x8],0x10
				ti->rsp = (uint64_t)ti;
    1639:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    163d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1641:	48 89 50 78          	mov    QWORD PTR [rax+0x78],rdx
				ti->rbp = ti->rsp;
    1645:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1649:	48 8b 50 78          	mov    rdx,QWORD PTR [rax+0x78]
    164d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1651:	48 89 50 70          	mov    QWORD PTR [rax+0x70],rdx
				ti->rflags = (1 << 9)/* | (1 << 8)*/; /* IF TF (interrupt enable, single-step) */
    1655:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1659:	48 c7 80 b0 00 00 00 00 02 00 00 	mov    QWORD PTR [rax+0xb0],0x200
				ti->rax = (uint64_t)fn;
    1664:	48 8b 95 38 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xc8]
    166b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    166f:	48 89 90 98 00 00 00 	mov    QWORD PTR [rax+0x98],rdx
				ti->rcx = (uint64_t)dat;
    1676:	48 8b 95 30 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xd0]
    167d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1681:	48 89 90 90 00 00 00 	mov    QWORD PTR [rax+0x90],rdx
				ti->rip = (uint64_t)task_initfunc;
    1688:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    168f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1693:	48 89 90 a0 00 00 00 	mov    QWORD PTR [rax+0xa0],rdx
				*pts = ts;
    169a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    169e:	48 89 c7             	mov    rdi,rax
    16a1:	48 8d 85 40 ff ff ff 	lea    rax,[rbp-0xc0]
    16a8:	ba 11 00 00 00       	mov    edx,0x11
    16ad:	48 89 c6             	mov    rsi,rax
    16b0:	48 89 d1             	mov    rcx,rdx
    16b3:	f3 48 a5             	rep movs QWORD PTR es:[rdi],QWORD PTR ds:[rsi]
				tks[n_tks++] = pts;
    16b6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 16bd <task_spawn_named+0x23e>
    16bd:	48 8d 50 01          	lea    rdx,[rax+0x1]
    16c1:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 16c8 <task_spawn_named+0x249>
    16c8:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    16cc:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
				pq_enqueue(run_queue, pts);
    16d4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 16db <task_spawn_named+0x25c>
    16db:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    16df:	48 89 d6             	mov    rsi,rdx
    16e2:	48 89 c7             	mov    rdi,rax
    16e5:	e8 00 00 00 00       	call   16ea <task_spawn_named+0x26b>
				spin_unlock(&pq_lock);
    16ea:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    16f1:	e8 00 00 00 00       	call   16f6 <task_spawn_named+0x277>
				if (flg)
    16f6:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    16fa:	74 30                	je     172c <task_spawn_named+0x2ad>
						preempt_enable();
    16fc:	b8 00 00 00 00       	mov    eax,0x0
    1701:	e8 00 00 00 00       	call   1706 <task_spawn_named+0x287>
    1706:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    1709:	83 ea 01             	sub    edx,0x1
    170c:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
    170f:	b8 00 00 00 00       	mov    eax,0x0
    1714:	e8 00 00 00 00       	call   1719 <task_spawn_named+0x29a>
    1719:	8b 00                	mov    eax,DWORD PTR [rax]
    171b:	83 e0 01             	and    eax,0x1
    171e:	85 c0                	test   eax,eax
    1720:	74 0a                	je     172c <task_spawn_named+0x2ad>
    1722:	b8 00 00 00 00       	mov    eax,0x0
    1727:	e8 00 00 00 00       	call   172c <task_spawn_named+0x2ad>
}
    172c:	c9                   	leave
    172d:	c3                   	ret

000000000000172e <task_deallocate>:
{
    172e:	55                   	push   rbp
    172f:	48 89 e5             	mov    rbp,rsp
    1732:	48 83 ec 18          	sub    rsp,0x18
    1736:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		for (size_t i = 0; i < n_tks; i++)
    173a:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    1742:	eb 56                	jmp    179a <task_deallocate+0x6c>
				if (tks[i] == t) {
    1744:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1748:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    1750:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1754:	75 3f                	jne    1795 <task_deallocate+0x67>
						tks[i] = NULL;
    1756:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    175a:	48 c7 04 c5 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],0x0
						tks[i] = tks[--n_tks];
    1766:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 176d <task_deallocate+0x3f>
    176d:	48 83 e8 01          	sub    rax,0x1
    1771:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1778 <task_deallocate+0x4a>
    1778:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 177f <task_deallocate+0x51>
    177f:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    1787:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    178b:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						break;
    1793:	eb 12                	jmp    17a7 <task_deallocate+0x79>
		for (size_t i = 0; i < n_tks; i++)
    1795:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    179a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17a1 <task_deallocate+0x73>
    17a1:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    17a5:	72 9d                	jb     1744 <task_deallocate+0x16>
		free_stack(t->stack_base);
    17a7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    17ab:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    17af:	48 89 c7             	mov    rdi,rax
    17b2:	e8 00 00 00 00       	call   17b7 <task_deallocate+0x89>
}
    17b7:	90                   	nop
    17b8:	c9                   	leave
    17b9:	c3                   	ret

00000000000017ba <task_diag>:
{
    17ba:	55                   	push   rbp
    17bb:	48 89 e5             	mov    rbp,rsp
    17be:	48 83 ec 10          	sub    rsp,0x10
		size_t end = pr_idx;
    17c2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17c9 <task_diag+0xf>
    17c9:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		asm("cli");
    17cd:	fa                   	cli
		if (diag++)
    17ce:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 17d4 <task_diag+0x1a>
    17d4:	8d 50 01             	lea    edx,[rax+0x1]
    17d7:	89 15 00 00 00 00    	mov    DWORD PTR [rip+0x0],edx        # 17dd <task_diag+0x23>
    17dd:	85 c0                	test   eax,eax
    17df:	0f 85 2f 01 00 00    	jne    1914 <task_diag+0x15a>
		framebuffer_redraw(&fb_initial);
    17e5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    17ec:	e8 00 00 00 00       	call   17f1 <task_diag+0x37>
		mdelay(1000);
    17f1:	bf e8 03 00 00       	mov    edi,0x3e8
    17f6:	e8 00 00 00 00       	call   17fb <task_diag+0x41>
		print_tasks();
    17fb:	b8 00 00 00 00       	mov    eax,0x0
    1800:	e8 00 00 00 00       	call   1805 <task_diag+0x4b>
		printf("PROC TASK TASK_NAME        EIP      ESP\n");
    1805:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    180c:	b8 00 00 00 00       	mov    eax,0x0
    1811:	e8 00 00 00 00       	call   1816 <task_diag+0x5c>
		for (size_t i = end - 1; i != end; i--) {
    1816:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    181a:	48 83 e8 01          	sub    rax,0x1
    181e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1822:	e9 dd 00 00 00       	jmp    1904 <task_diag+0x14a>
						pr_lst[i].eip, pr_lst[i].esp);
    1827:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 182e <task_diag+0x74>
    182e:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1832:	48 c1 e2 05          	shl    rdx,0x5
    1836:	48 01 d0             	add    rax,rdx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    1839:	4c 8b 40 18          	mov    r8,QWORD PTR [rax+0x18]
						pr_lst[i].eip, pr_lst[i].esp);
    183d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1844 <task_diag+0x8a>
    1844:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1848:	48 c1 e2 05          	shl    rdx,0x5
    184c:	48 01 d0             	add    rax,rdx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    184f:	48 8b 78 10          	mov    rdi,QWORD PTR [rax+0x10]
						pr_lst[i].task_id, pr_lst[i].task_name,
    1853:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 185a <task_diag+0xa0>
    185a:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    185e:	48 c1 e2 05          	shl    rdx,0x5
    1862:	48 01 d0             	add    rax,rdx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    1865:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
						pr_lst[i].task_id, pr_lst[i].task_name,
    1869:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1870 <task_diag+0xb6>
    1870:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1874:	48 c1 e1 05          	shl    rcx,0x5
    1878:	48 01 c8             	add    rax,rcx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    187b:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    187e:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 1885 <task_diag+0xcb>
    1885:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
    1889:	48 c1 e6 05          	shl    rsi,0x5
    188d:	48 01 f1             	add    rcx,rsi
    1890:	8b 09                	mov    ecx,DWORD PTR [rcx]
    1892:	89 ce                	mov    esi,ecx
    1894:	c1 ee 18             	shr    esi,0x18
    1897:	4d 89 c1             	mov    r9,r8
    189a:	49 89 f8             	mov    r8,rdi
    189d:	48 89 d1             	mov    rcx,rdx
    18a0:	89 c2                	mov    edx,eax
    18a2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    18a9:	b8 00 00 00 00       	mov    eax,0x0
    18ae:	e8 00 00 00 00       	call   18b3 <task_diag+0xf9>
				if (i % 20)
    18b3:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    18b7:	48 ba cd cc cc cc cc cc cc cc 	movabs rdx,0xcccccccccccccccd
    18c1:	48 89 c8             	mov    rax,rcx
    18c4:	48 f7 e2             	mul    rdx
    18c7:	48 c1 ea 04          	shr    rdx,0x4
    18cb:	48 89 d0             	mov    rax,rdx
    18ce:	48 c1 e0 02          	shl    rax,0x2
    18d2:	48 01 d0             	add    rax,rdx
    18d5:	48 c1 e0 02          	shl    rax,0x2
    18d9:	48 29 c1             	sub    rcx,rax
    18dc:	48 89 ca             	mov    rdx,rcx
    18df:	48 85 d2             	test   rdx,rdx
    18e2:	74 0c                	je     18f0 <task_diag+0x136>
						framebuffer_redraw(&fb_initial);
    18e4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    18eb:	e8 00 00 00 00       	call   18f0 <task_diag+0x136>
				if (!i)
    18f0:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    18f5:	75 08                	jne    18ff <task_diag+0x145>
						i = 128;
    18f7:	48 c7 45 f8 80 00 00 00 	mov    QWORD PTR [rbp-0x8],0x80
		for (size_t i = end - 1; i != end; i--) {
    18ff:	48 83 6d f8 01       	sub    QWORD PTR [rbp-0x8],0x1
    1904:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1908:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    190c:	0f 85 15 ff ff ff    	jne    1827 <task_diag+0x6d>
    1912:	eb 01                	jmp    1915 <task_diag+0x15b>
				return;
    1914:	90                   	nop
}
    1915:	c9                   	leave
    1916:	c3                   	ret

0000000000001917 <proc_add_time>:
{
    1917:	55                   	push   rbp
    1918:	48 89 e5             	mov    rbp,rsp
    191b:	48 83 ec 20          	sub    rsp,0x20
    191f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1923:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct perf_ctrs* pc = (nproc > 1) ? per_cpu_ptr()->ticks : bp_tick;
    1926:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 192c <proc_add_time+0x15>
    192c:	83 f8 01             	cmp    eax,0x1
    192f:	76 10                	jbe    1941 <proc_add_time+0x2a>
    1931:	b8 00 00 00 00       	mov    eax,0x0
    1936:	e8 c5 e6 ff ff       	call   0 <per_cpu_ptr>
    193b:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    193f:	eb 07                	jmp    1948 <proc_add_time+0x31>
    1941:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1948 <proc_add_time+0x31>
    1948:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		/* we're inside the pq lock -> no sync */
		if (flags & TIF_IDLE)
    194c:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    194f:	83 e0 40             	and    eax,0x40
    1952:	85 c0                	test   eax,eax
    1954:	74 19                	je     196f <proc_add_time+0x58>
				pc->ns_idle += ns;
    1956:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    195a:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    195e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1962:	48 01 c2             	add    rdx,rax
    1965:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1969:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    196d:	eb 3a                	jmp    19a9 <proc_add_time+0x92>
		else if (flags & TIF_KERNEL_STACK)
    196f:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1972:	83 e0 08             	and    eax,0x8
    1975:	85 c0                	test   eax,eax
    1977:	74 19                	je     1992 <proc_add_time+0x7b>
				pc->ns_kernel += ns;
    1979:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    197d:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1981:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1985:	48 01 c2             	add    rdx,rax
    1988:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    198c:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
    1990:	eb 17                	jmp    19a9 <proc_add_time+0x92>
		else
				pc->ns_user += ns;
    1992:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1996:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
    199a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    199e:	48 01 c2             	add    rdx,rax
    19a1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19a5:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
		pc->n_times++;
    19a9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19ad:	8b 40 44             	mov    eax,DWORD PTR [rax+0x44]
    19b0:	8d 50 01             	lea    edx,[rax+0x1]
    19b3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19b7:	89 50 44             	mov    DWORD PTR [rax+0x44],edx
}
    19ba:	90                   	nop
    19bb:	c9                   	leave
    19bc:	c3                   	ret

00000000000019bd <get_runtime>:

/* returns runtime in ns */
uint64_t get_runtime(struct tsi* t)
{
    19bd:	55                   	push   rbp
    19be:	48 89 e5             	mov    rbp,rsp
    19c1:	48 83 ec 38          	sub    rsp,0x38
    19c5:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
		uint64_t rv;
		union {	uint64_t val; struct { uint32_t lo, hi; }; } b, e, d;
		b.val = t->start_time;
    19c9:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    19cd:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    19d1:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		e.val = t->stop_time;
    19d5:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    19d9:	48 8b 40 50          	mov    rax,QWORD PTR [rax+0x50]
    19dd:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		d.val = e.val - b.val;
    19e1:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    19e5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    19e9:	48 29 c2             	sub    rdx,rax
    19ec:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		if (cpu.invariant_tsc) {
    19f0:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 19f6 <get_runtime+0x39>
    19f6:	85 c0                	test   eax,eax
    19f8:	74 23                	je     1a1d <get_runtime+0x60>
				rv = 1000000 * d.val / tsc_per_ms;
    19fa:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19fe:	48 69 c0 40 42 0f 00 	imul   rax,rax,0xf4240
    1a05:	48 8b 35 00 00 00 00 	mov    rsi,QWORD PTR [rip+0x0]        # 1a0c <get_runtime+0x4f>
    1a0c:	ba 00 00 00 00       	mov    edx,0x0
    1a11:	48 f7 f6             	div    rsi
    1a14:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1a18:	e9 b9 00 00 00       	jmp    1ad6 <get_runtime+0x119>
		} else if (cpu.has_acpi) {
    1a1d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1a24 <get_runtime+0x67>
    1a24:	83 e0 40             	and    eax,0x40
    1a27:	84 c0                	test   al,al
    1a29:	74 7c                	je     1aa7 <get_runtime+0xea>
				int64_t bias = 0;
    1a2b:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				/* complicated double values */
				d.hi = e.hi - b.hi; /* jiffie/HZ difference */
    1a33:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    1a36:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1a39:	29 c2                	sub    edx,eax
    1a3b:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
				/* countdown timer values */
				bias = e.lo - b.lo;
    1a3e:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
    1a41:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1a44:	29 c2                	sub    edx,eax
    1a46:	89 d0                	mov    eax,edx
    1a48:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				bias = bias * 1000000000ll / (HZ * apic_reload_value);
    1a4c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1a50:	48 69 c0 00 ca 9a 3b 	imul   rax,rax,0x3b9aca00
    1a57:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 1a5d <get_runtime+0xa0>
    1a5d:	6b d2 79             	imul   edx,edx,0x79
    1a60:	89 d7                	mov    edi,edx
    1a62:	48 99                	cqo
    1a64:	48 f7 ff             	idiv   rdi
    1a67:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				rv = (uint64_t)(1000000000ull * d.hi / HZ + bias);
    1a6b:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1a6e:	89 c0                	mov    eax,eax
    1a70:	48 69 c8 00 ca 9a 3b 	imul   rcx,rax,0x3b9aca00
    1a77:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    1a81:	48 89 c8             	mov    rax,rcx
    1a84:	48 f7 e2             	mul    rdx
    1a87:	48 89 c8             	mov    rax,rcx
    1a8a:	48 29 d0             	sub    rax,rdx
    1a8d:	48 d1 e8             	shr    rax,1
    1a90:	48 01 d0             	add    rax,rdx
    1a93:	48 c1 e8 06          	shr    rax,0x6
    1a97:	48 89 c2             	mov    rdx,rax
    1a9a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1a9e:	48 01 d0             	add    rax,rdx
    1aa1:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1aa5:	eb 2f                	jmp    1ad6 <get_runtime+0x119>
		} else { /* jiffies */
				rv = 1000000000ull * d.val / HZ;
    1aa7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1aab:	48 69 c8 00 ca 9a 3b 	imul   rcx,rax,0x3b9aca00
    1ab2:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    1abc:	48 89 c8             	mov    rax,rcx
    1abf:	48 f7 e2             	mul    rdx
    1ac2:	48 89 c8             	mov    rax,rcx
    1ac5:	48 29 d0             	sub    rax,rdx
    1ac8:	48 d1 e8             	shr    rax,1
    1acb:	48 01 d0             	add    rax,rdx
    1ace:	48 c1 e8 06          	shr    rax,0x6
    1ad2:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		}
		return rv;
    1ad6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
    1ada:	c9                   	leave
    1adb:	c3                   	ret

0000000000001adc <sleep>:
struct wait_queue_head wq_idle = WAIT_QUEUE_HEAD(wq_idle);
struct wait_queue_head wq_timer = WAIT_QUEUE_HEAD(wq_timer);

int sleep(unsigned int seconds)
{
    1adc:	55                   	push   rbp
    1add:	48 89 e5             	mov    rbp,rsp
    1ae0:	48 83 ec 10          	sub    rsp,0x10
    1ae4:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		wait_timeout(&wq_timer, HZ * seconds);
    1ae7:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1aea:	6b c0 79             	imul   eax,eax,0x79
    1aed:	89 c6                	mov    esi,eax
    1aef:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1af6:	e8 00 00 00 00       	call   1afb <sleep+0x1f>
		return 0;
    1afb:	b8 00 00 00 00       	mov    eax,0x0
}
    1b00:	c9                   	leave
    1b01:	c3                   	ret

0000000000001b02 <wq_add>:

static inline void wq_add(struct wait_queue_head* wq_head, struct wait_queue* wq_tail)
{
    1b02:	55                   	push   rbp
    1b03:	48 89 e5             	mov    rbp,rsp
    1b06:	48 83 ec 10          	sub    rsp,0x10
    1b0a:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    1b0e:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		spin_lock(&wq_head->lock);
    1b12:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1b16:	48 83 c0 10          	add    rax,0x10
    1b1a:	48 89 c7             	mov    rdi,rax
    1b1d:	e8 00 00 00 00       	call   1b22 <wq_add+0x20>
		wq_head->prev->next = wq_tail;
    1b22:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1b26:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1b29:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1b2d:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		wq_tail->prev = wq_head->prev;
    1b31:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1b35:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1b38:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b3c:	48 89 10             	mov    QWORD PTR [rax],rdx
		wq_head->prev = wq_tail;
    1b3f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1b43:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1b47:	48 89 10             	mov    QWORD PTR [rax],rdx
		wq_tail->next = wq_head;
    1b4a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b4e:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1b52:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		spin_unlock(&wq_head->lock);
    1b56:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1b5a:	48 83 c0 10          	add    rax,0x10
    1b5e:	48 89 c7             	mov    rdi,rax
    1b61:	e8 00 00 00 00       	call   1b66 <wq_add+0x64>
}
    1b66:	90                   	nop
    1b67:	c9                   	leave
    1b68:	c3                   	ret

0000000000001b69 <wq_purge>:

static inline void wq_purge(struct wait_queue_head* wq, struct wait_queue* wq_e)
{
    1b69:	55                   	push   rbp
    1b6a:	48 89 e5             	mov    rbp,rsp
    1b6d:	48 83 ec 20          	sub    rsp,0x20
    1b71:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1b75:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		int flg;
		spin_lock_irqsave(&wq->lock, &flg);
    1b79:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b7d:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1b81:	48 8d 45 f4          	lea    rax,[rbp-0xc]
    1b85:	48 89 c6             	mov    rsi,rax
    1b88:	48 89 d7             	mov    rdi,rdx
    1b8b:	e8 00 00 00 00       	call   1b90 <wq_purge+0x27>
		if (wq->next != (struct wait_queue*)wq) {
    1b90:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b94:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1b98:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1b9c:	74 53                	je     1bf1 <wq_purge+0x88>
				struct wait_queue* wq_n = wq->next;
    1b9e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ba2:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1ba6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				do {
						if (wq_n == wq_e) {
    1baa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1bae:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
    1bb2:	75 27                	jne    1bdb <wq_purge+0x72>
								wq_n->prev->next = wq_n->next;
    1bb4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1bb8:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1bbb:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1bbf:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    1bc3:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
								wq_n->next->prev = wq_n->prev;
    1bc7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1bcb:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1bcf:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1bd3:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    1bd6:	48 89 10             	mov    QWORD PTR [rax],rdx
								break;
    1bd9:	eb 16                	jmp    1bf1 <wq_purge+0x88>
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
    1bdb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1bdf:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1be3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1be7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1beb:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
    1bef:	75 b9                	jne    1baa <wq_purge+0x41>
		}
		spin_unlock_irqrestore(&wq->lock, flg);
    1bf1:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1bf4:	48 98                	cdqe
    1bf6:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1bfa:	48 83 c2 10          	add    rdx,0x10
    1bfe:	48 89 c6             	mov    rsi,rax
    1c01:	48 89 d7             	mov    rdi,rdx
    1c04:	e8 00 00 00 00       	call   1c09 <wq_purge+0xa0>
}
    1c09:	90                   	nop
    1c0a:	c9                   	leave
    1c0b:	c3                   	ret

0000000000001c0c <wait_on_event>:

void wait_on_event(struct wait_queue_head* wq)
{
    1c0c:	55                   	push   rbp
    1c0d:	48 89 e5             	mov    rbp,rsp
    1c10:	48 83 ec 30          	sub    rsp,0x30
    1c14:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct wait_queue my_q;
		if (__sync_bool_compare_and_swap(&wq->signaled, 1, 0))
    1c18:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c1c:	48 8d 50 14          	lea    rdx,[rax+0x14]
    1c20:	b8 01 00 00 00       	mov    eax,0x1
    1c25:	b9 00 00 00 00       	mov    ecx,0x0
    1c2a:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    1c2e:	0f 94 c0             	sete   al
    1c31:	84 c0                	test   al,al
    1c33:	0f 85 96 00 00 00    	jne    1ccf <wait_on_event+0xc3>
				return; /* handle signalling */
		if (preempt_needs_init)
    1c39:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1c3f <wait_on_event+0x33>
    1c3f:	85 c0                	test   eax,eax
    1c41:	0f 85 8b 00 00 00    	jne    1cd2 <wait_on_event+0xc6>
				return;
		else if (preempt_count())
    1c47:	b8 00 00 00 00       	mov    eax,0x0
    1c4c:	e8 00 00 00 00       	call   1c51 <wait_on_event+0x45>
    1c51:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    1c54:	85 c0                	test   eax,eax
    1c56:	75 7d                	jne    1cd5 <wait_on_event+0xc9>
				return;
		my_q.task = get_task();
    1c58:	b8 00 00 00 00       	mov    eax,0x0
    1c5d:	e8 00 00 00 00       	call   1c62 <wait_on_event+0x56>
    1c62:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		my_q.timeout = 0;
    1c66:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		wq_add(wq, &my_q);
    1c6e:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    1c72:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c76:	48 89 d6             	mov    rsi,rdx
    1c79:	48 89 c7             	mov    rdi,rax
    1c7c:	e8 81 fe ff ff       	call   1b02 <wq_add>
		if (!__sync_bool_compare_and_swap(&wq->signaled, 1, 0)) { /* again */
    1c81:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c85:	48 8d 50 14          	lea    rdx,[rax+0x14]
    1c89:	b8 01 00 00 00       	mov    eax,0x1
    1c8e:	b9 00 00 00 00       	mov    ecx,0x0
    1c93:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    1c97:	0f 94 c0             	sete   al
    1c9a:	83 f0 01             	xor    eax,0x1
    1c9d:	84 c0                	test   al,al
    1c9f:	74 19                	je     1cba <wait_on_event+0xae>
				my_q.task->flags |= TIF_SLEEPING;
    1ca1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1ca5:	8b 10                	mov    edx,DWORD PTR [rax]
    1ca7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1cab:	80 ca 80             	or     dl,0x80
    1cae:	89 10                	mov    DWORD PTR [rax],edx
				task_yield();
    1cb0:	b8 00 00 00 00       	mov    eax,0x0
    1cb5:	e8 00 00 00 00       	call   1cba <wait_on_event+0xae>
		}
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
    1cba:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    1cbe:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1cc2:	48 89 d6             	mov    rsi,rdx
    1cc5:	48 89 c7             	mov    rdi,rax
    1cc8:	e8 9c fe ff ff       	call   1b69 <wq_purge>
    1ccd:	eb 07                	jmp    1cd6 <wait_on_event+0xca>
				return; /* handle signalling */
    1ccf:	90                   	nop
    1cd0:	eb 04                	jmp    1cd6 <wait_on_event+0xca>
				return;
    1cd2:	90                   	nop
    1cd3:	eb 01                	jmp    1cd6 <wait_on_event+0xca>
				return;
    1cd5:	90                   	nop
}
    1cd6:	c9                   	leave
    1cd7:	c3                   	ret

0000000000001cd8 <wait_timeout>:

void wait_timeout(struct wait_queue_head* wq, uint32_t delta)
{
    1cd8:	55                   	push   rbp
    1cd9:	48 89 e5             	mov    rbp,rsp
    1cdc:	48 83 ec 30          	sub    rsp,0x30
    1ce0:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1ce4:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
		struct wait_queue my_q;
		my_q.task = get_task();
    1ce7:	b8 00 00 00 00       	mov    eax,0x0
    1cec:	e8 00 00 00 00       	call   1cf1 <wait_timeout+0x19>
    1cf1:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		my_q.timeout = jiffies + delta;
    1cf5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1cfc <wait_timeout+0x24>
    1cfc:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1cff:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    1d02:	48 01 d0             	add    rax,rdx
    1d05:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		wq_add(wq, &my_q);
    1d09:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    1d0d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d11:	48 89 d6             	mov    rsi,rdx
    1d14:	48 89 c7             	mov    rdi,rax
    1d17:	e8 e6 fd ff ff       	call   1b02 <wq_add>
		my_q.task->flags |= TIF_SLEEPING;
    1d1c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1d20:	8b 10                	mov    edx,DWORD PTR [rax]
    1d22:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1d26:	80 ca 80             	or     dl,0x80
    1d29:	89 10                	mov    DWORD PTR [rax],edx
		task_yield();
    1d2b:	b8 00 00 00 00       	mov    eax,0x0
    1d30:	e8 00 00 00 00       	call   1d35 <wait_timeout+0x5d>
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
    1d35:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    1d39:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d3d:	48 89 d6             	mov    rsi,rdx
    1d40:	48 89 c7             	mov    rdi,rax
    1d43:	e8 21 fe ff ff       	call   1b69 <wq_purge>
}
    1d48:	90                   	nop
    1d49:	c9                   	leave
    1d4a:	c3                   	ret

0000000000001d4b <wake_task>:

int wake_task(struct tsi* t)
{
    1d4b:	55                   	push   rbp
    1d4c:	48 89 e5             	mov    rbp,rsp
    1d4f:	48 83 ec 20          	sub    rsp,0x20
    1d53:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1d57:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		if (!t)
    1d5e:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    1d63:	75 18                	jne    1d7d <wake_task+0x32>
				cprintf(KFMT_WARN, "Empty queue entry in wait queue\n");
    1d65:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1d6c:	bf 0e 00 00 00       	mov    edi,0xe
    1d71:	b8 00 00 00 00       	mov    eax,0x0
    1d76:	e8 00 00 00 00       	call   1d7b <wake_task+0x30>
    1d7b:	eb 43                	jmp    1dc0 <wake_task+0x75>
		else { /* TODO: maybe check if really sleeping */
				t->flags &= ~TIF_SLEEPING;
    1d7d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d81:	8b 00                	mov    eax,DWORD PTR [rax]
    1d83:	24 7f                	and    al,0x7f
    1d85:	89 c2                	mov    edx,eax
    1d87:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d8b:	89 10                	mov    DWORD PTR [rax],edx
				pq_enqueue((t->flags & TIF_EXPIRED) ?
    1d8d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d91:	8b 00                	mov    eax,DWORD PTR [rax]
    1d93:	83 e0 20             	and    eax,0x20
    1d96:	85 c0                	test   eax,eax
    1d98:	74 09                	je     1da3 <wake_task+0x58>
    1d9a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1da1 <wake_task+0x56>
    1da1:	eb 07                	jmp    1daa <wake_task+0x5f>
    1da3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1daa <wake_task+0x5f>
    1daa:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1dae:	48 89 d6             	mov    rsi,rdx
    1db1:	48 89 c7             	mov    rdi,rax
    1db4:	e8 00 00 00 00       	call   1db9 <wake_task+0x6e>
						expired_queue : run_queue, t);
				rv = 1;
    1db9:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
		}
		return rv;
    1dc0:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1dc3:	c9                   	leave
    1dc4:	c3                   	ret

0000000000001dc5 <wake_up>:

/* called by the scheduler holding pq_lock */
int wake_up(struct wait_queue_head* wq)
{
    1dc5:	55                   	push   rbp
    1dc6:	48 89 e5             	mov    rbp,rsp
    1dc9:	48 83 ec 20          	sub    rsp,0x20
    1dcd:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1dd1:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		spin_lock(&wq->lock);
    1dd8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ddc:	48 83 c0 10          	add    rax,0x10
    1de0:	48 89 c7             	mov    rdi,rax
    1de3:	e8 00 00 00 00       	call   1de8 <wake_up+0x23>
		if (wq->next != (struct wait_queue*)wq) {
    1de8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1dec:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1df0:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1df4:	74 44                	je     1e3a <wake_up+0x75>
				struct wait_queue* wq_n = wq->next;
    1df6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1dfa:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1dfe:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
    1e02:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1e06:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1e09:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1e0d:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    1e11:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				wq_n->next->prev = wq_n->prev;
    1e15:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1e19:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1e1d:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1e21:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    1e24:	48 89 10             	mov    QWORD PTR [rax],rdx
				rv = wake_task(wq_n->task);
    1e27:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1e2b:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1e2f:	48 89 c7             	mov    rdi,rax
    1e32:	e8 00 00 00 00       	call   1e37 <wake_up+0x72>
    1e37:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		}
		spin_unlock(&wq->lock);
    1e3a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e3e:	48 83 c0 10          	add    rax,0x10
    1e42:	48 89 c7             	mov    rdi,rax
    1e45:	e8 00 00 00 00       	call   1e4a <wake_up+0x85>
		return rv;
    1e4a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1e4d:	c9                   	leave
    1e4e:	c3                   	ret

0000000000001e4f <wake_up_all>:

int wake_up_all(struct wait_queue* wq)
{
    1e4f:	55                   	push   rbp
    1e50:	48 89 e5             	mov    rbp,rsp
    1e53:	48 83 ec 20          	sub    rsp,0x20
    1e57:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1e5b:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		while (wake_up(wq))
    1e62:	eb 04                	jmp    1e68 <wake_up_all+0x19>
				rv++;
    1e64:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
		while (wake_up(wq))
    1e68:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e6c:	48 89 c7             	mov    rdi,rax
    1e6f:	e8 00 00 00 00       	call   1e74 <wake_up_all+0x25>
    1e74:	85 c0                	test   eax,eax
    1e76:	75 ec                	jne    1e64 <wake_up_all+0x15>
		return rv;
    1e78:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1e7b:	c9                   	leave
    1e7c:	c3                   	ret

0000000000001e7d <wake_up_external_event>:

int wake_up_external_event(struct wait_queue_head* wq)
{
    1e7d:	55                   	push   rbp
    1e7e:	48 89 e5             	mov    rbp,rsp
    1e81:	48 83 ec 20          	sub    rsp,0x20
    1e85:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1e89:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		spin_lock(&wq->lock);
    1e90:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e94:	48 83 c0 10          	add    rax,0x10
    1e98:	48 89 c7             	mov    rdi,rax
    1e9b:	e8 00 00 00 00       	call   1ea0 <wake_up_external_event+0x23>
		if (wq->next != (struct wait_queue*)wq) {
    1ea0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ea4:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1ea8:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1eac:	74 6a                	je     1f18 <wake_up_external_event+0x9b>
				struct wait_queue* wq_n = wq->next;
    1eae:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1eb2:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1eb6:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
    1eba:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1ebe:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1ec1:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1ec5:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    1ec9:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				wq_n->next->prev = wq_n->prev;
    1ecd:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1ed1:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1ed5:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1ed9:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    1edc:	48 89 10             	mov    QWORD PTR [rax],rdx
				wq_n->timeout = jiffies;
    1edf:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1ee6 <wake_up_external_event+0x69>
    1ee6:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1ee9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1eed:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
				/* abuse the timer queue */
				wq_add(&wq_timer, wq_n);
    1ef1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1ef5:	48 89 c6             	mov    rsi,rax
    1ef8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1eff:	e8 fe fb ff ff       	call   1b02 <wq_add>
				rv = 1;
    1f04:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
				wq->signaled = 0;
    1f0b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f0f:	c7 40 14 00 00 00 00 	mov    DWORD PTR [rax+0x14],0x0
    1f16:	eb 0b                	jmp    1f23 <wake_up_external_event+0xa6>
		} else { /* empty -> prevent waiting forever */
				wq->signaled = 1;
    1f18:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f1c:	c7 40 14 01 00 00 00 	mov    DWORD PTR [rax+0x14],0x1
		}
		spin_unlock(&wq->lock);
    1f23:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f27:	48 83 c0 10          	add    rax,0x10
    1f2b:	48 89 c7             	mov    rdi,rax
    1f2e:	e8 00 00 00 00       	call   1f33 <wake_up_external_event+0xb6>
		return rv;
    1f33:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1f36:	c9                   	leave
    1f37:	c3                   	ret

0000000000001f38 <wake_up_all_external_event>:

int wake_up_all_external_event(struct wait_queue_head* wq)
{
    1f38:	55                   	push   rbp
    1f39:	48 89 e5             	mov    rbp,rsp
    1f3c:	48 83 ec 20          	sub    rsp,0x20
    1f40:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1f44:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		while (wake_up_external_event(wq))
    1f4b:	eb 04                	jmp    1f51 <wake_up_all_external_event+0x19>
				rv++;
    1f4d:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
		while (wake_up_external_event(wq))
    1f51:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f55:	48 89 c7             	mov    rdi,rax
    1f58:	e8 00 00 00 00       	call   1f5d <wake_up_all_external_event+0x25>
    1f5d:	85 c0                	test   eax,eax
    1f5f:	75 ec                	jne    1f4d <wake_up_all_external_event+0x15>
		if (rv) /* a bit iffy */
    1f61:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1f65:	74 0b                	je     1f72 <wake_up_all_external_event+0x3a>
				wq->signaled = 0;
    1f67:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f6b:	c7 40 14 00 00 00 00 	mov    DWORD PTR [rax+0x14],0x0
		return rv;
    1f72:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1f75:	c9                   	leave
    1f76:	c3                   	ret

0000000000001f77 <wake_up_timer>:

int wake_up_timer(struct wait_queue_head* wq)
{
    1f77:	55                   	push   rbp
    1f78:	48 89 e5             	mov    rbp,rsp
    1f7b:	48 83 ec 20          	sub    rsp,0x20
    1f7f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1f83:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		spin_lock(&wq->lock);
    1f8a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f8e:	48 83 c0 10          	add    rax,0x10
    1f92:	48 89 c7             	mov    rdi,rax
    1f95:	e8 00 00 00 00       	call   1f9a <wake_up_timer+0x23>
		if (wq->next != (struct wait_queue*)wq) {
    1f9a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f9e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1fa2:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1fa6:	74 7a                	je     2022 <wake_up_timer+0xab>
				struct wait_queue* wq_n = wq->next;
    1fa8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fac:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1fb0:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				do {
						if (wq_n->timeout <= jiffies) {
    1fb4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1fb8:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1fbc:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1fc3 <wake_up_timer+0x4c>
    1fc3:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    1fc6:	48 39 c2             	cmp    rdx,rax
    1fc9:	72 3e                	jb     2009 <wake_up_timer+0x92>
								wq_n->prev->next = wq_n->next;
    1fcb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1fcf:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1fd2:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1fd6:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    1fda:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
								wq_n->next->prev = wq_n->prev;
    1fde:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1fe2:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1fe6:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1fea:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    1fed:	48 89 10             	mov    QWORD PTR [rax],rdx
								rv = wake_task(wq_n->task);
    1ff0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1ff4:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1ff8:	48 89 c7             	mov    rdi,rax
    1ffb:	e8 00 00 00 00       	call   2000 <wake_up_timer+0x89>
    2000:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
								if (rv)
    2003:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    2007:	75 18                	jne    2021 <wake_up_timer+0xaa>
										break;
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
    2009:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    200d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2011:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    2015:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2019:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
    201d:	75 95                	jne    1fb4 <wake_up_timer+0x3d>
    201f:	eb 01                	jmp    2022 <wake_up_timer+0xab>
										break;
    2021:	90                   	nop
		}
		spin_unlock(&wq->lock);
    2022:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2026:	48 83 c0 10          	add    rax,0x10
    202a:	48 89 c7             	mov    rdi,rax
    202d:	e8 00 00 00 00       	call   2032 <wake_up_timer+0xbb>
		return rv;
    2032:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    2035:	c9                   	leave
    2036:	c3                   	ret

0000000000002037 <wake_up_timer_all>:

int wake_up_timer_all(struct wait_queue_head* wq)
{
    2037:	55                   	push   rbp
    2038:	48 89 e5             	mov    rbp,rsp
    203b:	48 83 ec 20          	sub    rsp,0x20
    203f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    2043:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		while (wake_up_timer(wq))
    204a:	eb 04                	jmp    2050 <wake_up_timer_all+0x19>
				rv++;
    204c:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
		while (wake_up_timer(wq))
    2050:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2054:	48 89 c7             	mov    rdi,rax
    2057:	e8 00 00 00 00       	call   205c <wake_up_timer_all+0x25>
    205c:	85 c0                	test   eax,eax
    205e:	75 ec                	jne    204c <wake_up_timer_all+0x15>
		return rv;
    2060:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    2063:	c9                   	leave
    2064:	c3                   	ret

0000000000002065 <kidle>:

void kidle(void* data)
{
    2065:	55                   	push   rbp
    2066:	48 89 e5             	mov    rbp,rsp
    2069:	48 83 ec 10          	sub    rsp,0x10
    206d:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		get_task()->flags |= TIF_IDLE;
    2071:	b8 00 00 00 00       	mov    eax,0x0
    2076:	e8 00 00 00 00       	call   207b <kidle+0x16>
    207b:	8b 10                	mov    edx,DWORD PTR [rax]
    207d:	83 ca 40             	or     edx,0x40
    2080:	89 10                	mov    DWORD PTR [rax],edx
		while (1) {
				wait_on_event(&wq_idle);
    2082:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2089:	e8 00 00 00 00       	call   208e <kidle+0x29>
				asm("hlt");
    208e:	f4                   	hlt
				wait_on_event(&wq_idle);
    208f:	90                   	nop
    2090:	eb f0                	jmp    2082 <kidle+0x1d>

0000000000002092 <task_schedule>:
size_t ri_ofs = 0;

/* called from everyone else (using cli before). The stack is the
 * stack of the current task. */
void task_schedule(struct tsi* prev_task)
{
    2092:	55                   	push   rbp
    2093:	48 89 e5             	mov    rbp,rsp
    2096:	53                   	push   rbx
    2097:	48 83 ec 68          	sub    rsp,0x68
    209b:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
		if (preempt_needs_init) /* returns to the task_state on the stack */
    209f:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 20a5 <task_schedule+0x13>
    20a5:	85 c0                	test   eax,eax
    20a7:	0f 85 39 07 00 00    	jne    27e6 <task_schedule+0x754>
				return;    /* of the irq0 handler, i.e. where execution stopped. */

		struct tsi* t;
		/* calculate the runtime of prev_task and go back if no preemption */
		if (prev_task) {
    20ad:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    20b2:	0f 84 a9 00 00 00    	je     2161 <task_schedule+0xcf>
				/* happens on same proc */
				uint64_t rt = get_runtime(prev_task);
    20b8:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    20bc:	48 89 c7             	mov    rdi,rax
    20bf:	e8 00 00 00 00       	call   20c4 <task_schedule+0x32>
    20c4:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				prev_task->ns_run = rt; // <- could be used for nice values
    20c8:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    20cc:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    20d0:	48 89 50 60          	mov    QWORD PTR [rax+0x60],rdx
				prev_task->ns_acc += rt;
    20d4:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    20d8:	48 8b 50 68          	mov    rdx,QWORD PTR [rax+0x68]
    20dc:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    20e0:	48 01 c2             	add    rdx,rax
    20e3:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    20e7:	48 89 50 68          	mov    QWORD PTR [rax+0x68],rdx
				proc_add_time(rt, prev_task->flags);
    20eb:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    20ef:	8b 10                	mov    edx,DWORD PTR [rax]
    20f1:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    20f5:	89 d6                	mov    esi,edx
    20f7:	48 89 c7             	mov    rdi,rax
    20fa:	e8 00 00 00 00       	call   20ff <task_schedule+0x6d>
				/* go back but signify TIF_NEED_RESCHED */
				if (prev_task->preempt_count) {
    20ff:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2103:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    2106:	85 c0                	test   eax,eax
    2108:	74 39                	je     2143 <task_schedule+0xb1>
						prev_task->flags |= TIF_NEED_RESCHED;
    210a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    210e:	8b 00                	mov    eax,DWORD PTR [rax]
    2110:	83 c8 01             	or     eax,0x1
    2113:	89 c2                	mov    edx,eax
    2115:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2119:	89 10                	mov    DWORD PTR [rax],edx
						prev_task->start_time = task_gettime();
    211b:	b8 00 00 00 00       	mov    eax,0x0
    2120:	e8 00 00 00 00       	call   2125 <task_schedule+0x93>
    2125:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    2129:	48 89 42 48          	mov    QWORD PTR [rdx+0x48],rax
						prev_task->quota--; /* go into negative values */
    212d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2131:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    2134:	8d 50 ff             	lea    edx,[rax-0x1]
    2137:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    213b:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
						return;
    213e:	e9 a4 06 00 00       	jmp    27e7 <task_schedule+0x755>
				} else if (prev_task->flags & TIF_NEED_RESCHED) /* clear the flag */
    2143:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2147:	8b 00                	mov    eax,DWORD PTR [rax]
    2149:	83 e0 01             	and    eax,0x1
    214c:	85 c0                	test   eax,eax
    214e:	74 11                	je     2161 <task_schedule+0xcf>
						prev_task->flags &= ~TIF_NEED_RESCHED;
    2150:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2154:	8b 00                	mov    eax,DWORD PTR [rax]
    2156:	83 e0 fe             	and    eax,0xfffffffe
    2159:	89 c2                	mov    edx,eax
    215b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    215f:	89 10                	mov    DWORD PTR [rax],edx
		}

		/* enter the queue lock (entails free reign over ts values) */
		spin_lock(&pq_lock);
    2161:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2168:	e8 00 00 00 00       	call   216d <task_schedule+0xdb>
		/* wake up once */
		wake_up_timer_all(&wq_timer);
    216d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2174:	e8 00 00 00 00       	call   2179 <task_schedule+0xe7>
		/* check for reinsertion */
		for (size_t i = 0; i < ri_ofs; i++) {
    2179:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    2181:	e9 86 00 00 00       	jmp    220c <task_schedule+0x17a>
				struct tsi* ti = ri_queue[i];
    2186:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    218a:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2192:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				if (ti->flags & TIF_RUNNING)
    2196:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    219a:	8b 00                	mov    eax,DWORD PTR [rax]
    219c:	83 e0 10             	and    eax,0x10
    219f:	85 c0                	test   eax,eax
    21a1:	75 63                	jne    2206 <task_schedule+0x174>
						continue;
				/* task is eligible */
				pq_enqueue((ti->flags & TIF_EXPIRED) ?
    21a3:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    21a7:	8b 00                	mov    eax,DWORD PTR [rax]
    21a9:	83 e0 20             	and    eax,0x20
    21ac:	85 c0                	test   eax,eax
    21ae:	74 09                	je     21b9 <task_schedule+0x127>
    21b0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 21b7 <task_schedule+0x125>
    21b7:	eb 07                	jmp    21c0 <task_schedule+0x12e>
    21b9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 21c0 <task_schedule+0x12e>
    21c0:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    21c4:	48 89 d6             	mov    rsi,rdx
    21c7:	48 89 c7             	mov    rdi,rax
    21ca:	e8 00 00 00 00       	call   21cf <task_schedule+0x13d>
						expired_queue : run_queue, ti);
				/* shorten queue and redo current iteration */
				ri_queue[i--] = ri_queue[--ri_ofs];
    21cf:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 21d6 <task_schedule+0x144>
    21d6:	48 83 e8 01          	sub    rax,0x1
    21da:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 21e1 <task_schedule+0x14f>
    21e1:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 21e8 <task_schedule+0x156>
    21e8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    21ec:	48 8d 48 ff          	lea    rcx,[rax-0x1]
    21f0:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
    21f4:	48 8b 14 d5 00 00 00 00 	mov    rdx,QWORD PTR [rdx*8+0x0]
    21fc:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
    2204:	eb 01                	jmp    2207 <task_schedule+0x175>
						continue;
    2206:	90                   	nop
		for (size_t i = 0; i < ri_ofs; i++) {
    2207:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
    220c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2213 <task_schedule+0x181>
    2213:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
    2217:	0f 82 69 ff ff ff    	jb     2186 <task_schedule+0xf4>
		}

Pos1:
    221d:	90                   	nop
    221e:	eb 04                	jmp    2224 <task_schedule+0x192>
		}

		/* check for sleeping tasks and if so, forget the task
		 * (wake_up is responsible for reenqueueing) */
		if (t->flags & TIF_SLEEPING)
				goto Pos1;
    2220:	90                   	nop
    2221:	eb 01                	jmp    2224 <task_schedule+0x192>
				if (t != prev_task) { /* except if we're the one holding it */
						ri_queue[ri_ofs++] = t;
						t->quota++;
						if (ri_ofs == RI_LIMIT)
								die("Use a larger reinsertion queue!\n");
						goto Pos1; /* don't schedule the same task on many procs */
    2223:	90                   	nop
		t = pq_dequeue(run_queue);
    2224:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 222b <task_schedule+0x199>
    222b:	48 89 c7             	mov    rdi,rax
    222e:	e8 00 00 00 00       	call   2233 <task_schedule+0x1a1>
    2233:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!t) { /* major rotation */
    2237:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    223c:	75 7a                	jne    22b8 <task_schedule+0x226>
				struct priority_queue* q = run_queue;
    223e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2245 <task_schedule+0x1b3>
    2245:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				run_queue = expired_queue;
    2249:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2250 <task_schedule+0x1be>
    2250:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2257 <task_schedule+0x1c5>
				expired_queue = q;
    2257:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    225b:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2262 <task_schedule+0x1d0>
				for (size_t i = 0; i < n_tks; i++) /* unexpire them */
    2262:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    226a:	eb 24                	jmp    2290 <task_schedule+0x1fe>
						tks[i]->flags &= ~TIF_EXPIRED;
    226c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2270:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2278:	8b 10                	mov    edx,DWORD PTR [rax]
    227a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    227e:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2286:	83 e2 df             	and    edx,0xffffffdf
    2289:	89 10                	mov    DWORD PTR [rax],edx
				for (size_t i = 0; i < n_tks; i++) /* unexpire them */
    228b:	48 83 45 d8 01       	add    QWORD PTR [rbp-0x28],0x1
    2290:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2297 <task_schedule+0x205>
    2297:	48 39 45 d8          	cmp    QWORD PTR [rbp-0x28],rax
    229b:	72 cf                	jb     226c <task_schedule+0x1da>
				STAT_INC_COUNTER(sched_mr_count, 1);
    229d:	f0 83 05 00 00 00 00 01 	lock add DWORD PTR [rip+0x0],0x1        # 22a5 <task_schedule+0x213>
				t = pq_dequeue(run_queue);
    22a5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 22ac <task_schedule+0x21a>
    22ac:	48 89 c7             	mov    rdi,rax
    22af:	e8 00 00 00 00       	call   22b4 <task_schedule+0x222>
    22b4:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!t) { /* nothing to do? --> wake idle process */
    22b8:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    22bd:	75 3c                	jne    22fb <task_schedule+0x269>
				if (!prev_task || (prev_task->flags & TIF_SLEEPING)
    22bf:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    22c4:	74 1c                	je     22e2 <task_schedule+0x250>
    22c6:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    22ca:	8b 00                	mov    eax,DWORD PTR [rax]
    22cc:	25 80 00 00 00       	and    eax,0x80
    22d1:	85 c0                	test   eax,eax
    22d3:	75 0d                	jne    22e2 <task_schedule+0x250>
							   || (prev_task->flags & TIF_YIELDED)) {
    22d5:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    22d9:	8b 00                	mov    eax,DWORD PTR [rax]
    22db:	83 e0 02             	and    eax,0x2
    22de:	85 c0                	test   eax,eax
    22e0:	74 11                	je     22f3 <task_schedule+0x261>
						wake_up(&wq_idle);
    22e2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    22e9:	e8 00 00 00 00       	call   22ee <task_schedule+0x25c>
						goto Pos1;
    22ee:	e9 31 ff ff ff       	jmp    2224 <task_schedule+0x192>
						t = prev_task;
    22f3:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    22f7:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (t->flags & TIF_DEALLOCATE && !(t->flags & TIF_RUNNING)) {
    22fb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    22ff:	8b 00                	mov    eax,DWORD PTR [rax]
    2301:	83 e0 04             	and    eax,0x4
    2304:	85 c0                	test   eax,eax
    2306:	74 1e                	je     2326 <task_schedule+0x294>
    2308:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    230c:	8b 00                	mov    eax,DWORD PTR [rax]
    230e:	83 e0 10             	and    eax,0x10
    2311:	85 c0                	test   eax,eax
    2313:	75 11                	jne    2326 <task_schedule+0x294>
				task_deallocate(t);
    2315:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2319:	48 89 c7             	mov    rdi,rax
    231c:	e8 00 00 00 00       	call   2321 <task_schedule+0x28f>
				goto Pos1;
    2321:	e9 fe fe ff ff       	jmp    2224 <task_schedule+0x192>
		if (t->flags & TIF_SLEEPING)
    2326:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    232a:	8b 00                	mov    eax,DWORD PTR [rax]
    232c:	25 80 00 00 00       	and    eax,0x80
    2331:	85 c0                	test   eax,eax
    2333:	0f 85 e7 fe ff ff    	jne    2220 <task_schedule+0x18e>
		if (--t->quota <= 0) {
    2339:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    233d:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    2340:	8d 50 ff             	lea    edx,[rax-0x1]
    2343:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2347:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
    234a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    234e:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    2351:	85 c0                	test   eax,eax
    2353:	7f 78                	jg     23cd <task_schedule+0x33b>
				t->quota += 10;
    2355:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2359:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    235c:	8d 50 0a             	lea    edx,[rax+0xa]
    235f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2363:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
				t->flags &= ~TIF_YIELDED;
    2366:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    236a:	8b 00                	mov    eax,DWORD PTR [rax]
    236c:	83 e0 fd             	and    eax,0xfffffffd
    236f:	89 c2                	mov    edx,eax
    2371:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2375:	89 10                	mov    DWORD PTR [rax],edx
				if (t->cur_priority != PRIORITY_MIN) {
    2377:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    237b:	8b 40 44             	mov    eax,DWORD PTR [rax+0x44]
    237e:	83 f8 03             	cmp    eax,0x3
    2381:	74 1f                	je     23a2 <task_schedule+0x310>
						t->cur_priority++;
    2383:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2387:	8b 40 44             	mov    eax,DWORD PTR [rax+0x44]
    238a:	8d 50 01             	lea    edx,[rax+0x1]
    238d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2391:	89 50 44             	mov    DWORD PTR [rax+0x44],edx
						STAT_INC_COUNTER(t->task_mr_bumps, 1);
    2394:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2398:	48 83 c0 7c          	add    rax,0x7c
    239c:	f0 83 00 01          	lock add DWORD PTR [rax],0x1
    23a0:	eb 2b                	jmp    23cd <task_schedule+0x33b>
						t->flags |= TIF_EXPIRED;
    23a2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23a6:	8b 00                	mov    eax,DWORD PTR [rax]
    23a8:	83 c8 20             	or     eax,0x20
    23ab:	89 c2                	mov    edx,eax
    23ad:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23b1:	89 10                	mov    DWORD PTR [rax],edx
						t->cur_priority = t->priority;
    23b3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23b7:	8b 50 3c             	mov    edx,DWORD PTR [rax+0x3c]
    23ba:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23be:	89 50 44             	mov    DWORD PTR [rax+0x44],edx
						STAT_INC_COUNTER(t->task_mr_expires, 1);
    23c1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23c5:	48 83 e8 80          	sub    rax,0xffffffffffffff80
    23c9:	f0 83 00 01          	lock add DWORD PTR [rax],0x1
		if (__sync_fetch_and_or(&t->flags, TIF_RUNNING) & TIF_RUNNING) {
    23cd:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    23d1:	8b 02                	mov    eax,DWORD PTR [rdx]
    23d3:	89 c6                	mov    esi,eax
    23d5:	89 c1                	mov    ecx,eax
    23d7:	83 c9 10             	or     ecx,0x10
    23da:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    23de:	0f 94 c1             	sete   cl
    23e1:	84 c9                	test   cl,cl
    23e3:	74 ee                	je     23d3 <task_schedule+0x341>
    23e5:	89 f0                	mov    eax,esi
    23e7:	83 e0 10             	and    eax,0x10
    23ea:	85 c0                	test   eax,eax
    23ec:	74 7a                	je     2468 <task_schedule+0x3d6>
				if (t != prev_task) { /* except if we're the one holding it */
    23ee:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23f2:	48 3b 45 98          	cmp    rax,QWORD PTR [rbp-0x68]
    23f6:	74 70                	je     2468 <task_schedule+0x3d6>
						ri_queue[ri_ofs++] = t;
    23f8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 23ff <task_schedule+0x36d>
    23ff:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2403:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 240a <task_schedule+0x378>
    240a:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    240e:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						t->quota++;
    2416:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    241a:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    241d:	8d 50 01             	lea    edx,[rax+0x1]
    2420:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2424:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
						if (ri_ofs == RI_LIMIT)
    2427:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 242e <task_schedule+0x39c>
    242e:	48 83 f8 20          	cmp    rax,0x20
    2432:	0f 85 eb fd ff ff    	jne    2223 <task_schedule+0x191>
								die("Use a larger reinsertion queue!\n");
    2438:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    243f:	bf 0c 00 00 00       	mov    edi,0xc
    2444:	b8 00 00 00 00       	mov    eax,0x0
    2449:	e8 00 00 00 00       	call   244e <task_schedule+0x3bc>
    244e:	b8 00 00 00 00       	mov    eax,0x0
    2453:	e8 00 00 00 00       	call   2458 <task_schedule+0x3c6>
    2458:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    245f:	e8 00 00 00 00       	call   2464 <task_schedule+0x3d2>
    2464:	fa                   	cli
    2465:	f4                   	hlt
    2466:	eb fd                	jmp    2465 <task_schedule+0x3d3>
				}
		}
		barrier();
		t->run_time++; /* accounting */
    2468:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    246c:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    246f:	8d 50 01             	lea    edx,[rax+0x1]
    2472:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2476:	89 50 38             	mov    DWORD PTR [rax+0x38],edx

		/* now jump into task */
		t->start_time = task_gettime();
    2479:	b8 00 00 00 00       	mov    eax,0x0
    247e:	e8 00 00 00 00       	call   2483 <task_schedule+0x3f1>
    2483:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2487:	48 89 42 48          	mov    QWORD PTR [rdx+0x48],rax
		/* DEBUG check! */
		{
				struct stack_limits sl;
				if (get_stack(stack_ptr(t), &sl) == -1) {
    248b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    248f:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2493:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    2497:	48 89 c2             	mov    rdx,rax
    249a:	48 8d 45 a8          	lea    rax,[rbp-0x58]
    249e:	48 89 c6             	mov    rsi,rax
    24a1:	48 89 d7             	mov    rdi,rdx
    24a4:	e8 00 00 00 00       	call   24a9 <task_schedule+0x417>
    24a9:	83 f8 ff             	cmp    eax,0xffffffff
    24ac:	75 6a                	jne    2518 <task_schedule+0x486>
						die("invalid task struct at %p (esp=%p)\nt%sprev_task\n",
    24ae:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    24b2:	48 3b 45 98          	cmp    rax,QWORD PTR [rbp-0x68]
    24b6:	75 09                	jne    24c1 <task_schedule+0x42f>
    24b8:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    24bf:	eb 07                	jmp    24c8 <task_schedule+0x436>
    24c1:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    24c8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    24cc:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    24d0:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    24d4:	48 89 c2             	mov    rdx,rax
    24d7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    24db:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    24df:	49 89 c8             	mov    r8,rcx
    24e2:	48 89 d1             	mov    rcx,rdx
    24e5:	48 89 c2             	mov    rdx,rax
    24e8:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    24ef:	bf 0c 00 00 00       	mov    edi,0xc
    24f4:	b8 00 00 00 00       	mov    eax,0x0
    24f9:	e8 00 00 00 00       	call   24fe <task_schedule+0x46c>
    24fe:	b8 00 00 00 00       	mov    eax,0x0
    2503:	e8 00 00 00 00       	call   2508 <task_schedule+0x476>
    2508:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    250f:	e8 00 00 00 00       	call   2514 <task_schedule+0x482>
    2514:	fa                   	cli
    2515:	f4                   	hlt
    2516:	eb fd                	jmp    2515 <task_schedule+0x483>
								t->ts, stack_ptr(t), (t == prev_task) ? "==" : "!=");
				} else if (stack_ptr(t) < 0x7c00) {
    2518:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    251c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2520:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    2524:	48 3d ff 7b 00 00    	cmp    rax,0x7bff
    252a:	77 3b                	ja     2567 <task_schedule+0x4d5>
						die("eip below 0x7c00 for task struct at %p\n", t->ts);
    252c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2530:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2534:	48 89 c2             	mov    rdx,rax
    2537:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    253e:	bf 0c 00 00 00       	mov    edi,0xc
    2543:	b8 00 00 00 00       	mov    eax,0x0
    2548:	e8 00 00 00 00       	call   254d <task_schedule+0x4bb>
    254d:	b8 00 00 00 00       	mov    eax,0x0
    2552:	e8 00 00 00 00       	call   2557 <task_schedule+0x4c5>
    2557:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    255e:	e8 00 00 00 00       	call   2563 <task_schedule+0x4d1>
    2563:	fa                   	cli
    2564:	f4                   	hlt
    2565:	eb fd                	jmp    2564 <task_schedule+0x4d2>
				} else if (t->stack_base < stack_ptr(t) || t->stack_limit > stack_ptr(t)) {
    2567:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    256b:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    256f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2573:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2577:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    257b:	48 39 c2             	cmp    rdx,rax
    257e:	72 19                	jb     2599 <task_schedule+0x507>
    2580:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2584:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2588:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    258c:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    2590:	48 8b 52 78          	mov    rdx,QWORD PTR [rdx+0x78]
    2594:	48 39 c2             	cmp    rdx,rax
    2597:	73 30                	jae    25c9 <task_schedule+0x537>
						die("jumping into wrong stack!\n");
    2599:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    25a0:	bf 0c 00 00 00       	mov    edi,0xc
    25a5:	b8 00 00 00 00       	mov    eax,0x0
    25aa:	e8 00 00 00 00       	call   25af <task_schedule+0x51d>
    25af:	b8 00 00 00 00       	mov    eax,0x0
    25b4:	e8 00 00 00 00       	call   25b9 <task_schedule+0x527>
    25b9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25c0:	e8 00 00 00 00       	call   25c5 <task_schedule+0x533>
    25c5:	fa                   	cli
    25c6:	f4                   	hlt
    25c7:	eb fd                	jmp    25c6 <task_schedule+0x534>
				} else if (!t->ts)
    25c9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    25cd:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    25d1:	48 85 c0             	test   rax,rax
    25d4:	75 30                	jne    2606 <task_schedule+0x574>
						die("jumping into null!\n");
    25d6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    25dd:	bf 0c 00 00 00       	mov    edi,0xc
    25e2:	b8 00 00 00 00       	mov    eax,0x0
    25e7:	e8 00 00 00 00       	call   25ec <task_schedule+0x55a>
    25ec:	b8 00 00 00 00       	mov    eax,0x0
    25f1:	e8 00 00 00 00       	call   25f6 <task_schedule+0x564>
    25f6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25fd:	e8 00 00 00 00       	call   2602 <task_schedule+0x570>
    2602:	fa                   	cli
    2603:	f4                   	hlt
    2604:	eb fd                	jmp    2603 <task_schedule+0x571>
				//check_tasks();
				if (pr_lst) { /* ringbuffer */
    2606:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 260d <task_schedule+0x57b>
    260d:	48 85 c0             	test   rax,rax
    2610:	0f 84 06 01 00 00    	je     271c <task_schedule+0x68a>
						size_t idx;
get_idx:
    2616:	90                   	nop
						idx = __sync_fetch_and_add(&pr_idx, 1);
    2617:	b8 01 00 00 00       	mov    eax,0x1
    261c:	f0 48 0f c1 05 00 00 00 00 	lock xadd QWORD PTR [rip+0x0],rax        # 2625 <task_schedule+0x593>
    2625:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						if (idx > 127) {
    2629:	48 83 7d d0 7f       	cmp    QWORD PTR [rbp-0x30],0x7f
    262e:	76 25                	jbe    2655 <task_schedule+0x5c3>
								if (__sync_bool_compare_and_swap(&pr_idx, idx + 1, 0))
    2630:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2634:	48 83 c0 01          	add    rax,0x1
    2638:	ba 00 00 00 00       	mov    edx,0x0
    263d:	f0 48 0f b1 15 00 00 00 00 	lock cmpxchg QWORD PTR [rip+0x0],rdx        # 2646 <task_schedule+0x5b4>
    2646:	0f 94 c0             	sete   al
    2649:	84 c0                	test   al,al
    264b:	74 ca                	je     2617 <task_schedule+0x585>
										idx = 0;
    264d:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
								else
										goto get_idx;
						}
						if (nproc > 1)
    2655:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 265b <task_schedule+0x5c9>
    265b:	83 f8 01             	cmp    eax,0x1
    265e:	76 23                	jbe    2683 <task_schedule+0x5f1>
								pr_lst[idx].proc = per_cpu_ptr()->apic_id;
    2660:	b8 00 00 00 00       	mov    eax,0x0
    2665:	e8 96 d9 ff ff       	call   0 <per_cpu_ptr>
    266a:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 2671 <task_schedule+0x5df>
    2671:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    2675:	48 c1 e1 05          	shl    rcx,0x5
    2679:	48 01 ca             	add    rdx,rcx
    267c:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    267f:	89 02                	mov    DWORD PTR [rdx],eax
    2681:	eb 18                	jmp    269b <task_schedule+0x609>
						else
								pr_lst[idx].proc = 0;
    2683:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 268a <task_schedule+0x5f8>
    268a:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    268e:	48 c1 e2 05          	shl    rdx,0x5
    2692:	48 01 d0             	add    rax,rdx
    2695:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
						pr_lst[idx].task_name = t->name;
    269b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 26a2 <task_schedule+0x610>
    26a2:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    26a6:	48 c1 e2 05          	shl    rdx,0x5
    26aa:	48 01 c2             	add    rdx,rax
    26ad:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    26b1:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    26b5:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
						pr_lst[idx].task_id = t->task_id;
    26b9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 26c0 <task_schedule+0x62e>
    26c0:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    26c4:	48 c1 e2 05          	shl    rdx,0x5
    26c8:	48 01 c2             	add    rdx,rax
    26cb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    26cf:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    26d2:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
						pr_lst[idx].eip = instr_ptr(t);
    26d5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    26d9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    26dd:	48 8b 90 a0 00 00 00 	mov    rdx,QWORD PTR [rax+0xa0]
    26e4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 26eb <task_schedule+0x659>
    26eb:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    26ef:	48 c1 e1 05          	shl    rcx,0x5
    26f3:	48 01 c8             	add    rax,rcx
    26f6:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
						pr_lst[idx].esp = stack_ptr(t);
    26fa:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    26fe:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2702:	48 8b 50 78          	mov    rdx,QWORD PTR [rax+0x78]
    2706:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 270d <task_schedule+0x67b>
    270d:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    2711:	48 c1 e1 05          	shl    rcx,0x5
    2715:	48 01 c8             	add    rax,rcx
    2718:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
				}
		}
		/* document the processor */
		if (nproc > 1)
    271c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2722 <task_schedule+0x690>
    2722:	83 f8 01             	cmp    eax,0x1
    2725:	76 13                	jbe    273a <task_schedule+0x6a8>
				t->task_proc = smp_processor_id();
    2727:	b8 00 00 00 00       	mov    eax,0x0
    272c:	e8 cf d8 ff ff       	call   0 <per_cpu_ptr>
    2731:	8b 10                	mov    edx,DWORD PTR [rax]
    2733:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2737:	89 50 58             	mov    DWORD PTR [rax+0x58],edx
		/* reinsert the previous task (if we don't do so next time) */
		if (prev_task && (t != prev_task)) {
    273a:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    273f:	74 65                	je     27a6 <task_schedule+0x714>
    2741:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2745:	48 3b 45 98          	cmp    rax,QWORD PTR [rbp-0x68]
    2749:	74 5b                	je     27a6 <task_schedule+0x714>
				ri_queue[ri_ofs++] = prev_task;
    274b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2752 <task_schedule+0x6c0>
    2752:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2756:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 275d <task_schedule+0x6cb>
    275d:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    2761:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
				if (ri_ofs == RI_LIMIT)
    2769:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2770 <task_schedule+0x6de>
    2770:	48 83 f8 20          	cmp    rax,0x20
    2774:	75 30                	jne    27a6 <task_schedule+0x714>
						die("Use a larger reinsertion queue!\n");
    2776:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    277d:	bf 0c 00 00 00       	mov    edi,0xc
    2782:	b8 00 00 00 00       	mov    eax,0x0
    2787:	e8 00 00 00 00       	call   278c <task_schedule+0x6fa>
    278c:	b8 00 00 00 00       	mov    eax,0x0
    2791:	e8 00 00 00 00       	call   2796 <task_schedule+0x704>
    2796:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    279d:	e8 00 00 00 00       	call   27a2 <task_schedule+0x710>
    27a2:	fa                   	cli
    27a3:	f4                   	hlt
    27a4:	eb fd                	jmp    27a3 <task_schedule+0x711>
		}
		spin_unlock(&pq_lock);
    27a6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    27ad:	e8 00 00 00 00       	call   27b2 <task_schedule+0x720>

		/* release stack */
		{ /* only rely on registers */
				register void* ctx = t->ts;
    27b2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    27b6:	48 8b 58 08          	mov    rbx,QWORD PTR [rax+0x8]
				if (prev_task && (t != prev_task))
    27ba:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    27bf:	74 1b                	je     27dc <task_schedule+0x74a>
    27c1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    27c5:	48 3b 45 98          	cmp    rax,QWORD PTR [rbp-0x68]
    27c9:	74 11                	je     27dc <task_schedule+0x74a>
						prev_task->flags &= ~TIF_RUNNING;
    27cb:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    27cf:	8b 00                	mov    eax,DWORD PTR [rax]
    27d1:	83 e0 ef             	and    eax,0xffffffef
    27d4:	89 c2                	mov    edx,eax
    27d6:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    27da:	89 10                	mov    DWORD PTR [rax],edx
				longjmp(ctx);
    27dc:	48 89 dc             	mov    rsp,rbx
    27df:	e9 00 00 00 00       	jmp    27e4 <task_schedule+0x752>
    27e4:	eb 01                	jmp    27e7 <task_schedule+0x755>
				return;    /* of the irq0 handler, i.e. where execution stopped. */
    27e6:	90                   	nop
		}
}
    27e7:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    27eb:	c9                   	leave
    27ec:	c3                   	ret

00000000000027ed <task_schedule_isr>:

/* called from irq0/apic handler returning with iret via longjmp.
 * These handlers are gates, i.e. not-reentrant, ensuring that
 * they have always finished execution before the task switch. */
void task_schedule_isr(void* esp)
{
    27ed:	55                   	push   rbp
    27ee:	48 89 e5             	mov    rbp,rsp
    27f1:	48 83 ec 20          	sub    rsp,0x20
    27f5:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct tsi* t = get_task_esp(esp);
    27f9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    27fd:	48 89 c7             	mov    rdi,rax
    2800:	e8 00 00 00 00       	call   2805 <task_schedule_isr+0x18>
    2805:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		task_schedule(t);
    2809:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    280d:	48 89 c7             	mov    rdi,rax
    2810:	e8 00 00 00 00       	call   2815 <task_schedule_isr+0x28>
}
    2815:	90                   	nop
    2816:	c9                   	leave
    2817:	c3                   	ret

0000000000002818 <task_yield>:

void task_yield()
{
    2818:	55                   	push   rbp
    2819:	48 89 e5             	mov    rbp,rsp
    281c:	48 83 ec 10          	sub    rsp,0x10
		struct tsi* t;
		if (preempt_needs_init)
    2820:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2826 <task_yield+0xe>
    2826:	85 c0                	test   eax,eax
    2828:	0f 85 f8 00 00 00    	jne    2926 <task_yield+0x10e>
				return; /* shouldn't be called before preemption */
		t = get_task();
    282e:	b8 00 00 00 00       	mov    eax,0x0
    2833:	e8 00 00 00 00       	call   2838 <task_yield+0x20>
    2838:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (t->preempt_count) { /* don't yield nonpreemptable task */
    283c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2840:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    2843:	85 c0                	test   eax,eax
    2845:	0f 85 de 00 00 00    	jne    2929 <task_yield+0x111>
exit:
				return;
		}
		if (if_enabled())
    284b:	b8 00 00 00 00       	mov    eax,0x0
    2850:	e8 c6 d7 ff ff       	call   1b <if_enabled>
    2855:	48 85 c0             	test   rax,rax
    2858:	74 30                	je     288a <task_yield+0x72>
				die("yielding in interrupt!\n");
    285a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2861:	bf 0c 00 00 00       	mov    edi,0xc
    2866:	b8 00 00 00 00       	mov    eax,0x0
    286b:	e8 00 00 00 00       	call   2870 <task_yield+0x58>
    2870:	b8 00 00 00 00       	mov    eax,0x0
    2875:	e8 00 00 00 00       	call   287a <task_yield+0x62>
    287a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2881:	e8 00 00 00 00       	call   2886 <task_yield+0x6e>
    2886:	fa                   	cli
    2887:	f4                   	hlt
    2888:	eb fd                	jmp    2887 <task_yield+0x6f>
		void* ptr = &&exit;
    288a:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		asm volatile (
    2892:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    2896:	fa                   	cli
    2897:	48 89 84 24 30 ff ff ff 	mov    QWORD PTR [rsp-0xd0],rax
    289f:	48 31 c0             	xor    rax,rax
    28a2:	66 8c d0             	mov    ax,ss
    28a5:	50                   	push   rax
    28a6:	54                   	push   rsp
    28a7:	9c                   	pushf
    28a8:	81 0c 24 00 02 00 00 	or     DWORD PTR [rsp],0x200
    28af:	66 8c c8             	mov    ax,cs
    28b2:	50                   	push   rax
    28b3:	52                   	push   rdx
    28b4:	48 8b 84 24 58 ff ff ff 	mov    rax,QWORD PTR [rsp-0xa8]
    28bc:	50                   	push   rax
    28bd:	51                   	push   rcx
    28be:	52                   	push   rdx
    28bf:	53                   	push   rbx
    28c0:	54                   	push   rsp
    28c1:	55                   	push   rbp
    28c2:	56                   	push   rsi
    28c3:	57                   	push   rdi
    28c4:	41 50                	push   r8
    28c6:	41 51                	push   r9
    28c8:	41 52                	push   r10
    28ca:	41 53                	push   r11
    28cc:	41 54                	push   r12
    28ce:	41 55                	push   r13
    28d0:	41 56                	push   r14
    28d2:	41 57                	push   r15
    28d4:	66 8c d8             	mov    ax,ds
    28d7:	50                   	push   rax
    28d8:	66 8c c0             	mov    ax,es
    28db:	50                   	push   rax
    28dc:	66 8c e0             	mov    ax,fs
    28df:	50                   	push   rax
    28e0:	66 8c e8             	mov    ax,gs
    28e3:	50                   	push   rax
    28e4:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
		: "=mr" (ptr) : "0" (ptr)
#ifdef __x86_64__
							 : "rax" /* we clobber rax */
#endif
							 );
		t->ts = ptr;
    28e8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    28ec:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    28f0:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		t->flags |= TIF_YIELDED;
    28f4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    28f8:	8b 00                	mov    eax,DWORD PTR [rax]
    28fa:	83 c8 02             	or     eax,0x2
    28fd:	89 c2                	mov    edx,eax
    28ff:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2903:	89 10                	mov    DWORD PTR [rax],edx
		/* NOPE! */
		//t->flags &= ~TIF_RUNNING;
		t->stop_time = task_gettime();
    2905:	b8 00 00 00 00       	mov    eax,0x0
    290a:	e8 00 00 00 00       	call   290f <task_yield+0xf7>
    290f:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2913:	48 89 42 50          	mov    QWORD PTR [rdx+0x50],rax
		task_schedule(t);
    2917:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    291b:	48 89 c7             	mov    rdi,rax
    291e:	e8 00 00 00 00       	call   2923 <task_yield+0x10b>
		goto exit;
    2923:	90                   	nop
				return;
    2924:	eb 03                	jmp    2929 <task_yield+0x111>
				return; /* shouldn't be called before preemption */
    2926:	90                   	nop
    2927:	eb 01                	jmp    292a <task_yield+0x112>
				return;
    2929:	90                   	nop
}
    292a:	c9                   	leave
    292b:	c3                   	ret

000000000000292c <preempt_init>:

/* this function makes the kernel preemptable and is freeing the
 * previous main kernel stack at 0x60000-0x80000 */
void preempt_init()
{
    292c:	55                   	push   rbp
    292d:	48 89 e5             	mov    rbp,rsp
		asm ("cli");
    2930:	fa                   	cli
		pr_lst = kmalloc(128 * sizeof(*pr_lst));
    2931:	bf 00 10 00 00       	mov    edi,0x1000
    2936:	e8 00 00 00 00       	call   293b <preempt_init+0xf>
    293b:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2942 <preempt_init+0x16>
		extern void kinit(void*);
		extern void kredraw(void*);
		extern void kscrub(void*);
		task_spawn(kinit, NULL, PRIORITY_MAX);
    2942:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2949:	ba 00 00 00 00       	mov    edx,0x0
    294e:	be 00 00 00 00       	mov    esi,0x0
    2953:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    295a:	e8 00 00 00 00       	call   295f <preempt_init+0x33>
		task_spawn(kredraw, NULL, PRIORITY_MAX);
    295f:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2966:	ba 00 00 00 00       	mov    edx,0x0
    296b:	be 00 00 00 00       	mov    esi,0x0
    2970:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2977:	e8 00 00 00 00       	call   297c <preempt_init+0x50>
		task_spawn(kscrub, NULL, PRIORITY_MIN);
    297c:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2983:	ba 03 00 00 00       	mov    edx,0x3
    2988:	be 00 00 00 00       	mov    esi,0x0
    298d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2994:	e8 00 00 00 00       	call   2999 <preempt_init+0x6d>
		/* at least n+1 idle task are needed */
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2999:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    29a0:	ba 03 00 00 00       	mov    edx,0x3
    29a5:	be 00 00 00 00       	mov    esi,0x0
    29aa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29b1:	e8 00 00 00 00       	call   29b6 <preempt_init+0x8a>
		task_spawn(kidle, NULL, PRIORITY_MIN);
    29b6:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    29bd:	ba 03 00 00 00       	mov    edx,0x3
    29c2:	be 00 00 00 00       	mov    esi,0x0
    29c7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29ce:	e8 00 00 00 00       	call   29d3 <preempt_init+0xa7>
		preempt_needs_init = 0;
    29d3:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 29dd <preempt_init+0xb1>
		task_schedule(NULL);
    29dd:	bf 00 00 00 00       	mov    edi,0x0
    29e2:	e8 00 00 00 00       	call   29e7 <preempt_init+0xbb>
}
    29e7:	90                   	nop
    29e8:	5d                   	pop    rbp
    29e9:	c3                   	ret
