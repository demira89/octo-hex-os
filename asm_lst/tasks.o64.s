
tasks.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <per_cpu_ptr>:
		uint64_t es;
		uint64_t ds;
		uint64_t r15;
		uint64_t r14;
		uint64_t r13;
		uint64_t r12;
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 10          	sub    rsp,0x10
		uint64_t r11;
		uint64_t r10;
		uint64_t r9;
       8:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
      11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		uint64_t r8;
		uint64_t rdi;
		uint64_t rsi;
		uint64_t rbp;
      15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
		uint64_t rsp;
      19:	c9                   	leave
      1a:	c3                   	ret

000000000000001b <if_enabled>:
		asm("cli");
		if (diag++)
				return;
		framebuffer_redraw(&fb_initial);
		mdelay(1000);
		print_tasks();
      1b:	55                   	push   rbp
      1c:	48 89 e5             	mov    rbp,rsp
      1f:	48 83 ec 10          	sub    rsp,0x10
		printf("PROC TASK TASK_NAME        EIP      ESP\n");
		for (size_t i = end - 1; i != end; i--) {
      23:	9c                   	pushf
      24:	58                   	pop    rax
      25:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						framebuffer_redraw(&fb_initial);
				if (!i)
						i = 128;
		}
}

      29:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      2d:	83 e0 20             	and    eax,0x20
      30:	48 85 c0             	test   rax,rax
      33:	0f 95 c0             	setne  al
      36:	0f b6 c0             	movzx  eax,al
void proc_add_time(uint64_t ns, uint32_t flags)
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
     90c:	48 83 ec 28          	sub    rsp,0x28
     910:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
		char proc_str[5] = "N/A";
     914:	c7 45 cb 4e 2f 41 00 	mov    DWORD PTR [rbp-0x35],0x412f4e
     91b:	c6 45 cf 00          	mov    BYTE PTR [rbp-0x31],0x0
		if (ts->task_proc != 0xffffffff)
     91f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     923:	8b 40 58             	mov    eax,DWORD PTR [rax+0x58]
     926:	83 f8 ff             	cmp    eax,0xffffffff
     929:	74 26                	je     951 <print_task+0x52>
				snprintf(proc_str, 5, "%4u", ts->task_proc);
     92b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     92f:	8b 50 58             	mov    edx,DWORD PTR [rax+0x58]
     932:	48 8d 45 cb          	lea    rax,[rbp-0x35]
     936:	89 d1                	mov    ecx,edx
     938:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     93f:	be 05 00 00 00       	mov    esi,0x5
     944:	48 89 c7             	mov    rdi,rax
     947:	b8 00 00 00 00       	mov    eax,0x0
     94c:	e8 00 00 00 00       	call   951 <print_task+0x52>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     951:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     955:	8b b8 80 00 00 00    	mov    edi,DWORD PTR [rax+0x80]
     95b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     95f:	44 8b 70 7c          	mov    r14d,DWORD PTR [rax+0x7c]
     963:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     967:	4c 8b 68 20          	mov    r13,QWORD PTR [rax+0x20]
     96b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     96f:	44 8b 60 40          	mov    r12d,DWORD PTR [rax+0x40]
     973:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     977:	8b 58 34             	mov    ebx,DWORD PTR [rax+0x34]
     97a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     97e:	44 8b 58 38          	mov    r11d,DWORD PTR [rax+0x38]
				(uint32_t)(ts->ns_acc / 1000000000), ts->ns_per_sec / 1000000,
     982:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     986:	8b 40 78             	mov    eax,DWORD PTR [rax+0x78]
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     989:	89 c0                	mov    eax,eax
     98b:	48 69 c0 83 de 1b 43 	imul   rax,rax,0x431bde83
     992:	48 c1 e8 20          	shr    rax,0x20
     996:	41 89 c7             	mov    r15d,eax
     999:	41 c1 ef 12          	shr    r15d,0x12
				(uint32_t)(ts->ns_acc / 1000000000), ts->ns_per_sec / 1000000,
     99d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9a1:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
     9a5:	48 c1 e8 09          	shr    rax,0x9
     9a9:	48 ba 53 5a 9b a0 2f b8 44 00 	movabs rdx,0x44b82fa09b5a53
     9b3:	48 f7 e2             	mul    rdx
     9b6:	48 89 d0             	mov    rax,rdx
     9b9:	48 c1 e8 0b          	shr    rax,0xb
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     9bd:	89 45 b0             	mov    DWORD PTR [rbp-0x50],eax
     9c0:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9c4:	44 8b 50 44          	mov    r10d,DWORD PTR [rax+0x44]
     9c8:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9cc:	44 8b 48 3c          	mov    r9d,DWORD PTR [rax+0x3c]
     9d0:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9d4:	4c 8b 40 10          	mov    r8,QWORD PTR [rax+0x10]
				(ts->flags & TIF_YIELDED) ? 'Y' : ' ', proc_str,
     9d8:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9dc:	8b 00                	mov    eax,DWORD PTR [rax]
     9de:	83 e0 02             	and    eax,0x2
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     9e1:	85 c0                	test   eax,eax
     9e3:	74 09                	je     9ee <print_task+0xef>
     9e5:	c7 45 b4 59 00 00 00 	mov    DWORD PTR [rbp-0x4c],0x59
     9ec:	eb 07                	jmp    9f5 <print_task+0xf6>
     9ee:	c7 45 b4 20 00 00 00 	mov    DWORD PTR [rbp-0x4c],0x20
				(ts->flags & TIF_KERNEL_STACK) ? ((ts->flags & TIF_IDLE) ? 'I' : 'K') : 'U',
     9f5:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     9f9:	8b 00                	mov    eax,DWORD PTR [rax]
     9fb:	83 e0 08             	and    eax,0x8
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     9fe:	85 c0                	test   eax,eax
     a00:	74 1b                	je     a1d <print_task+0x11e>
				(ts->flags & TIF_KERNEL_STACK) ? ((ts->flags & TIF_IDLE) ? 'I' : 'K') : 'U',
     a02:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a06:	8b 00                	mov    eax,DWORD PTR [rax]
     a08:	83 e0 40             	and    eax,0x40
     a0b:	85 c0                	test   eax,eax
     a0d:	74 07                	je     a16 <print_task+0x117>
     a0f:	b9 49 00 00 00       	mov    ecx,0x49
     a14:	eb 0c                	jmp    a22 <print_task+0x123>
     a16:	b9 4b 00 00 00       	mov    ecx,0x4b
     a1b:	eb 05                	jmp    a22 <print_task+0x123>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     a1d:	b9 55 00 00 00       	mov    ecx,0x55
				(ts->flags & TIF_RUNNING) ? 'R' : (ts->flags & TIF_EXPIRED) ? 'X' : (ts->flags & TIF_SLEEPING) ? 'S': ' ',
     a22:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a26:	8b 00                	mov    eax,DWORD PTR [rax]
     a28:	83 e0 10             	and    eax,0x10
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     a2b:	85 c0                	test   eax,eax
     a2d:	75 31                	jne    a60 <print_task+0x161>
				(ts->flags & TIF_RUNNING) ? 'R' : (ts->flags & TIF_EXPIRED) ? 'X' : (ts->flags & TIF_SLEEPING) ? 'S': ' ',
     a2f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a33:	8b 00                	mov    eax,DWORD PTR [rax]
     a35:	83 e0 20             	and    eax,0x20
     a38:	85 c0                	test   eax,eax
     a3a:	75 1d                	jne    a59 <print_task+0x15a>
     a3c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a40:	8b 00                	mov    eax,DWORD PTR [rax]
     a42:	25 80 00 00 00       	and    eax,0x80
     a47:	85 c0                	test   eax,eax
     a49:	74 07                	je     a52 <print_task+0x153>
     a4b:	ba 53 00 00 00       	mov    edx,0x53
     a50:	eb 13                	jmp    a65 <print_task+0x166>
     a52:	ba 20 00 00 00       	mov    edx,0x20
     a57:	eb 0c                	jmp    a65 <print_task+0x166>
     a59:	ba 58 00 00 00       	mov    edx,0x58
     a5e:	eb 05                	jmp    a65 <print_task+0x166>
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
     a60:	ba 52 00 00 00       	mov    edx,0x52
     a65:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a69:	8b 70 28             	mov    esi,DWORD PTR [rax+0x28]
     a6c:	48 8d 45 cb          	lea    rax,[rbp-0x35]
     a70:	48 83 ec 08          	sub    rsp,0x8
     a74:	57                   	push   rdi
     a75:	41 56                	push   r14
     a77:	41 55                	push   r13
     a79:	41 54                	push   r12
     a7b:	53                   	push   rbx
     a7c:	41 53                	push   r11
     a7e:	41 57                	push   r15
     a80:	8b 5d b0             	mov    ebx,DWORD PTR [rbp-0x50]
     a83:	53                   	push   rbx
     a84:	41 52                	push   r10
     a86:	41 51                	push   r9
     a88:	41 50                	push   r8
     a8a:	49 89 c1             	mov    r9,rax
     a8d:	44 8b 45 b4          	mov    r8d,DWORD PTR [rbp-0x4c]
     a91:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a98:	b8 00 00 00 00       	mov    eax,0x0
     a9d:	e8 00 00 00 00       	call   aa2 <print_task+0x1a3>
     aa2:	48 83 c4 60          	add    rsp,0x60
}
     aa6:	90                   	nop
     aa7:	48 8d 65 d8          	lea    rsp,[rbp-0x28]
     aab:	5b                   	pop    rbx
     aac:	41 5c                	pop    r12
     aae:	41 5d                	pop    r13
     ab0:	41 5e                	pop    r14
     ab2:	41 5f                	pop    r15
     ab4:	5d                   	pop    rbp
     ab5:	c3                   	ret

0000000000000ab6 <cpu_stat_counter>:
{
     ab6:	55                   	push   rbp
     ab7:	48 89 e5             	mov    rbp,rsp
     aba:	48 83 ec 20          	sub    rsp,0x20
     abe:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		if (nproc > 1) {
     ac1:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # ac7 <cpu_stat_counter+0x11>
     ac7:	83 f8 01             	cmp    eax,0x1
     aca:	76 26                	jbe    af2 <cpu_stat_counter+0x3c>
				struct processor_data* pd = get_cpu_data(id);
     acc:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     acf:	89 c7                	mov    edi,eax
     ad1:	e8 00 00 00 00       	call   ad6 <cpu_stat_counter+0x20>
     ad6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (!pd)
     ada:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     adf:	75 07                	jne    ae8 <cpu_stat_counter+0x32>
						return NULL;
     ae1:	b8 00 00 00 00       	mov    eax,0x0
     ae6:	eb 11                	jmp    af9 <cpu_stat_counter+0x43>
				return pd->ticks;
     ae8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     aec:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     af0:	eb 07                	jmp    af9 <cpu_stat_counter+0x43>
				return bp_tick;
     af2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # af9 <cpu_stat_counter+0x43>
}
     af9:	c9                   	leave
     afa:	c3                   	ret

0000000000000afb <cpu_calc_percentages>:
{
     afb:	55                   	push   rbp
     afc:	48 89 e5             	mov    rbp,rsp
     aff:	48 83 ec 30          	sub    rsp,0x30
     b03:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct perf_ctrs* pc = cpu_stat_counter(i);
     b07:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b0b:	89 c7                	mov    edi,eax
     b0d:	e8 00 00 00 00       	call   b12 <cpu_calc_percentages+0x17>
     b12:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!pc) {
     b16:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     b1b:	75 49                	jne    b66 <cpu_calc_percentages+0x6b>
				bzero(&cpu_pcs[i + 1], sizeof(cpu_pcs[i + 1]));
     b1d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b24 <cpu_calc_percentages+0x29>
     b24:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     b28:	48 83 c2 01          	add    rdx,0x1
     b2c:	48 c1 e2 05          	shl    rdx,0x5
     b30:	48 01 d0             	add    rax,rdx
     b33:	be 20 00 00 00       	mov    esi,0x20
     b38:	48 89 c7             	mov    rdi,rax
     b3b:	e8 00 00 00 00       	call   b40 <cpu_calc_percentages+0x45>
				cpu_pcs[i + 1].vals[0] = 0xffffffff;
     b40:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b47 <cpu_calc_percentages+0x4c>
     b47:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     b4b:	48 83 c2 01          	add    rdx,0x1
     b4f:	48 c1 e2 05          	shl    rdx,0x5
     b53:	48 01 d0             	add    rax,rdx
     b56:	c7 00 ff ff ff ff    	mov    DWORD PTR [rax],0xffffffff
				return -1;
     b5c:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b61:	e9 d9 01 00 00       	jmp    d3f <cpu_calc_percentages+0x244>
		cpu_pcs[0].vals[0] += pc->ns_idle_per_sec;
     b66:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b6d <cpu_calc_percentages+0x72>
     b6d:	8b 08                	mov    ecx,DWORD PTR [rax]
     b6f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     b73:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
     b76:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b7d <cpu_calc_percentages+0x82>
     b7d:	01 ca                	add    edx,ecx
     b7f:	89 10                	mov    DWORD PTR [rax],edx
		cpu_pcs[0].vals[1] += pc->ns_kernel_per_sec;
     b81:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b88 <cpu_calc_percentages+0x8d>
     b88:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
     b8b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     b8f:	8b 50 3c             	mov    edx,DWORD PTR [rax+0x3c]
     b92:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b99 <cpu_calc_percentages+0x9e>
     b99:	01 ca                	add    edx,ecx
     b9b:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
		cpu_pcs[0].vals[2] += pc->ns_user_per_sec;
     b9e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ba5 <cpu_calc_percentages+0xaa>
     ba5:	8b 48 08             	mov    ecx,DWORD PTR [rax+0x8]
     ba8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bac:	8b 50 40             	mov    edx,DWORD PTR [rax+0x40]
     baf:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # bb6 <cpu_calc_percentages+0xbb>
     bb6:	01 ca                	add    edx,ecx
     bb8:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
		cpu_pcs[0].vals[3] += 1000000000 - pc->ns_idle_per_sec
     bbb:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # bc2 <cpu_calc_percentages+0xc7>
     bc2:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
     bc5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bc9:	8b 48 38             	mov    ecx,DWORD PTR [rax+0x38]
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     bcc:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bd0:	8b 40 3c             	mov    eax,DWORD PTR [rax+0x3c]
     bd3:	01 c1                	add    ecx,eax
     bd5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bd9:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
     bdc:	01 c8                	add    eax,ecx
		cpu_pcs[0].vals[3] += 1000000000 - pc->ns_idle_per_sec
     bde:	29 c2                	sub    edx,eax
     be0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # be7 <cpu_calc_percentages+0xec>
     be7:	81 c2 00 ca 9a 3b    	add    edx,0x3b9aca00
     bed:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
		cpu_pcs[i + 1].vals[0] = pc->ns_idle_per_sec;
     bf0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # bf7 <cpu_calc_percentages+0xfc>
     bf7:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     bfb:	48 83 c2 01          	add    rdx,0x1
     bff:	48 c1 e2 05          	shl    rdx,0x5
     c03:	48 01 c2             	add    rdx,rax
     c06:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c0a:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
     c0d:	89 02                	mov    DWORD PTR [rdx],eax
		cpu_pcs[i + 1].vals[1] = pc->ns_kernel_per_sec;
     c0f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c16 <cpu_calc_percentages+0x11b>
     c16:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     c1a:	48 83 c2 01          	add    rdx,0x1
     c1e:	48 c1 e2 05          	shl    rdx,0x5
     c22:	48 01 c2             	add    rdx,rax
     c25:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c29:	8b 40 3c             	mov    eax,DWORD PTR [rax+0x3c]
     c2c:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
		cpu_pcs[i + 1].vals[2] = pc->ns_user_per_sec;
     c2f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c36 <cpu_calc_percentages+0x13b>
     c36:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     c3a:	48 83 c2 01          	add    rdx,0x1
     c3e:	48 c1 e2 05          	shl    rdx,0x5
     c42:	48 01 c2             	add    rdx,rax
     c45:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c49:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
     c4c:	89 42 08             	mov    DWORD PTR [rdx+0x8],eax
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     c4f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c53:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     c56:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c5a:	8b 40 3c             	mov    eax,DWORD PTR [rax+0x3c]
     c5d:	01 c2                	add    edx,eax
     c5f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c63:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
     c66:	8d 0c 02             	lea    ecx,[rdx+rax*1]
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     c69:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c70 <cpu_calc_percentages+0x175>
     c70:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     c74:	48 83 c2 01          	add    rdx,0x1
     c78:	48 c1 e2 05          	shl    rdx,0x5
     c7c:	48 01 d0             	add    rax,rdx
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
     c7f:	ba 00 ca 9a 3b       	mov    edx,0x3b9aca00
     c84:	29 ca                	sub    edx,ecx
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
     c86:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
		for (size_t j = 0; j < 4; j++) {
     c89:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     c91:	e9 99 00 00 00       	jmp    d2f <cpu_calc_percentages+0x234>
				const uint32_t ntot = 10000000;
     c96:	c7 45 ec 80 96 98 00 	mov    DWORD PTR [rbp-0x14],0x989680
				uint32_t val = cpu_pcs[i + 1].vals[j];
     c9d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ca4 <cpu_calc_percentages+0x1a9>
     ca4:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     ca8:	48 83 c2 01          	add    rdx,0x1
     cac:	48 c1 e2 05          	shl    rdx,0x5
     cb0:	48 01 c2             	add    rdx,rax
     cb3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     cb7:	8b 04 82             	mov    eax,DWORD PTR [rdx+rax*4]
     cba:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
				cpu_pcs[i + 1].vals[j] = val / ntot;
     cbd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # cc4 <cpu_calc_percentages+0x1c9>
     cc4:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     cc8:	48 83 c2 01          	add    rdx,0x1
     ccc:	48 c1 e2 05          	shl    rdx,0x5
     cd0:	48 8d 0c 10          	lea    rcx,[rax+rdx*1]
     cd4:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     cd7:	ba 00 00 00 00       	mov    edx,0x0
     cdc:	f7 75 ec             	div    DWORD PTR [rbp-0x14]
     cdf:	89 c2                	mov    edx,eax
     ce1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ce5:	89 14 81             	mov    DWORD PTR [rcx+rax*4],edx
				cpu_pcs[i + 1].vals[4 + j] = 10 * (val % ntot) / ntot;
     ce8:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     ceb:	ba 00 00 00 00       	mov    edx,0x0
     cf0:	f7 75 ec             	div    DWORD PTR [rbp-0x14]
     cf3:	89 d0                	mov    eax,edx
     cf5:	c1 e0 02             	shl    eax,0x2
     cf8:	01 d0                	add    eax,edx
     cfa:	01 c0                	add    eax,eax
     cfc:	89 c7                	mov    edi,eax
     cfe:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d05 <cpu_calc_percentages+0x20a>
     d05:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     d09:	48 83 c2 01          	add    rdx,0x1
     d0d:	48 c1 e2 05          	shl    rdx,0x5
     d11:	48 8d 0c 10          	lea    rcx,[rax+rdx*1]
     d15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     d19:	48 8d 70 04          	lea    rsi,[rax+0x4]
     d1d:	89 f8                	mov    eax,edi
     d1f:	ba 00 00 00 00       	mov    edx,0x0
     d24:	f7 75 ec             	div    DWORD PTR [rbp-0x14]
     d27:	89 04 b1             	mov    DWORD PTR [rcx+rsi*4],eax
		for (size_t j = 0; j < 4; j++) {
     d2a:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     d2f:	48 83 7d f8 03       	cmp    QWORD PTR [rbp-0x8],0x3
     d34:	0f 86 5c ff ff ff    	jbe    c96 <cpu_calc_percentages+0x19b>
		return 0;
     d3a:	b8 00 00 00 00       	mov    eax,0x0
}
     d3f:	c9                   	leave
     d40:	c3                   	ret

0000000000000d41 <cpu_do_stats>:
{
     d41:	55                   	push   rbp
     d42:	48 89 e5             	mov    rbp,rsp
     d45:	48 83 ec 20          	sub    rsp,0x20
		if (!cpu_pcs || (nproc != nproc_alloc)) {
     d49:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d50 <cpu_do_stats+0xf>
     d50:	48 85 c0             	test   rax,rax
     d53:	74 10                	je     d65 <cpu_do_stats+0x24>
     d55:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # d5b <cpu_do_stats+0x1a>
     d5b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # d61 <cpu_do_stats+0x20>
     d61:	39 c2                	cmp    edx,eax
     d63:	74 39                	je     d9e <cpu_do_stats+0x5d>
				if (cpu_pcs)
     d65:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d6c <cpu_do_stats+0x2b>
     d6c:	48 85 c0             	test   rax,rax
     d6f:	74 0f                	je     d80 <cpu_do_stats+0x3f>
						kfree(cpu_pcs);
     d71:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d78 <cpu_do_stats+0x37>
     d78:	48 89 c7             	mov    rdi,rax
     d7b:	e8 00 00 00 00       	call   d80 <cpu_do_stats+0x3f>
				cpu_pcs = kmalloc((nproc + 1) * sizeof(*cpu_pcs));
     d80:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # d86 <cpu_do_stats+0x45>
     d86:	83 c0 01             	add    eax,0x1
     d89:	89 c0                	mov    eax,eax
     d8b:	48 c1 e0 05          	shl    rax,0x5
     d8f:	48 89 c7             	mov    rdi,rax
     d92:	e8 00 00 00 00       	call   d97 <cpu_do_stats+0x56>
     d97:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # d9e <cpu_do_stats+0x5d>
		bzero(&cpu_pcs[0], sizeof(cpu_pcs[0]));
     d9e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # da5 <cpu_do_stats+0x64>
     da5:	be 20 00 00 00       	mov    esi,0x20
     daa:	48 89 c7             	mov    rdi,rax
     dad:	e8 00 00 00 00       	call   db2 <cpu_do_stats+0x71>
		size_t nval = 0; uint32_t ntot;
     db2:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		for (size_t i = 0; i < nproc; i++) {
     dba:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     dc2:	eb 1e                	jmp    de2 <cpu_do_stats+0xa1>
				if (-1 == cpu_calc_percentages(i))
     dc4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     dc8:	48 89 c7             	mov    rdi,rax
     dcb:	e8 00 00 00 00       	call   dd0 <cpu_do_stats+0x8f>
     dd0:	83 f8 ff             	cmp    eax,0xffffffff
     dd3:	74 07                	je     ddc <cpu_do_stats+0x9b>
				nval++;
     dd5:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     dda:	eb 01                	jmp    ddd <cpu_do_stats+0x9c>
						continue;
     ddc:	90                   	nop
		for (size_t i = 0; i < nproc; i++) {
     ddd:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
     de2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # de8 <cpu_do_stats+0xa7>
     de8:	89 c0                	mov    eax,eax
     dea:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
     dee:	72 d4                	jb     dc4 <cpu_do_stats+0x83>
		nproc_rep = nval;
     df0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     df4:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # dfa <cpu_do_stats+0xb9>
		ntot = 10000000 * nval; /* div 100 */
     dfa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     dfe:	69 c0 80 96 98 00    	imul   eax,eax,0x989680
     e04:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
		for (size_t i = 0; i < 4; i++) {
     e07:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     e0f:	eb 63                	jmp    e74 <cpu_do_stats+0x133>
				uint32_t val = cpu_pcs[0].vals[i];
     e11:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # e18 <cpu_do_stats+0xd7>
     e18:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     e1c:	8b 04 90             	mov    eax,DWORD PTR [rax+rdx*4]
     e1f:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				cpu_pcs[0].vals[i] = val / ntot;
     e22:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # e29 <cpu_do_stats+0xe8>
     e29:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
     e2c:	ba 00 00 00 00       	mov    edx,0x0
     e31:	f7 75 e4             	div    DWORD PTR [rbp-0x1c]
     e34:	89 c2                	mov    edx,eax
     e36:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e3a:	89 14 81             	mov    DWORD PTR [rcx+rax*4],edx
				cpu_pcs[0].vals[4 + i] = 10 * (val % ntot) / ntot;
     e3d:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
     e40:	ba 00 00 00 00       	mov    edx,0x0
     e45:	f7 75 e4             	div    DWORD PTR [rbp-0x1c]
     e48:	89 d0                	mov    eax,edx
     e4a:	c1 e0 02             	shl    eax,0x2
     e4d:	01 d0                	add    eax,edx
     e4f:	01 c0                	add    eax,eax
     e51:	89 c2                	mov    edx,eax
     e53:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # e5a <cpu_do_stats+0x119>
     e5a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e5e:	48 8d 70 04          	lea    rsi,[rax+0x4]
     e62:	89 d0                	mov    eax,edx
     e64:	ba 00 00 00 00       	mov    edx,0x0
     e69:	f7 75 e4             	div    DWORD PTR [rbp-0x1c]
     e6c:	89 04 b1             	mov    DWORD PTR [rcx+rsi*4],eax
		for (size_t i = 0; i < 4; i++) {
     e6f:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     e74:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
     e79:	76 96                	jbe    e11 <cpu_do_stats+0xd0>
}
     e7b:	90                   	nop
     e7c:	90                   	nop
     e7d:	c9                   	leave
     e7e:	c3                   	ret

0000000000000e7f <print_cpus>:
{
     e7f:	55                   	push   rbp
     e80:	48 89 e5             	mov    rbp,rsp
     e83:	41 54                	push   r12
     e85:	53                   	push   rbx
     e86:	48 83 ec 10          	sub    rsp,0x10
		printf("listing cpus: %u total, %u provided data\n", nproc, nproc_rep);
     e8a:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # e90 <print_cpus+0x11>
     e90:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # e96 <print_cpus+0x17>
     e96:	89 c6                	mov    esi,eax
     e98:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     e9f:	b8 00 00 00 00       	mov    eax,0x0
     ea4:	e8 00 00 00 00       	call   ea9 <print_cpus+0x2a>
				cpu_pcs[0].vals[0], cpu_pcs[0].vals[4]); /* i pi */
     ea9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # eb0 <print_cpus+0x31>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     eb0:	44 8b 40 10          	mov    r8d,DWORD PTR [rax+0x10]
				cpu_pcs[0].vals[0], cpu_pcs[0].vals[4]); /* i pi */
     eb4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ebb <print_cpus+0x3c>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ebb:	8b 38                	mov    edi,DWORD PTR [rax]
				cpu_pcs[0].vals[3], cpu_pcs[0].vals[7], /* ni pni */
     ebd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ec4 <print_cpus+0x45>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ec4:	8b 70 1c             	mov    esi,DWORD PTR [rax+0x1c]
				cpu_pcs[0].vals[3], cpu_pcs[0].vals[7], /* ni pni */
     ec7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ece <print_cpus+0x4f>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ece:	44 8b 48 0c          	mov    r9d,DWORD PTR [rax+0xc]
				cpu_pcs[0].vals[1], cpu_pcs[0].vals[5], /* k pk */
     ed2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ed9 <print_cpus+0x5a>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ed9:	44 8b 50 14          	mov    r10d,DWORD PTR [rax+0x14]
				cpu_pcs[0].vals[1], cpu_pcs[0].vals[5], /* k pk */
     edd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ee4 <print_cpus+0x65>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ee4:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
				cpu_pcs[0].vals[2], cpu_pcs[0].vals[6], /* u pu */
     ee7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # eee <print_cpus+0x6f>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     eee:	8b 50 18             	mov    edx,DWORD PTR [rax+0x18]
				cpu_pcs[0].vals[2], cpu_pcs[0].vals[6], /* u pu */
     ef1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ef8 <print_cpus+0x79>
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
     ef8:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
     efb:	48 83 ec 08          	sub    rsp,0x8
     eff:	41 50                	push   r8
     f01:	57                   	push   rdi
     f02:	56                   	push   rsi
     f03:	45 89 d0             	mov    r8d,r10d
     f06:	89 c6                	mov    esi,eax
     f08:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f0f:	b8 00 00 00 00       	mov    eax,0x0
     f14:	e8 00 00 00 00       	call   f19 <print_cpus+0x9a>
     f19:	48 83 c4 20          	add    rsp,0x20
		for (size_t i = 0; i < nproc; i++) {
     f1d:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     f25:	e9 51 01 00 00       	jmp    107b <print_cpus+0x1fc>
				if (cpu_pcs[i + 1].vals[0] == 0xffffffff) {
     f2a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f31 <print_cpus+0xb2>
     f31:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     f35:	48 83 c2 01          	add    rdx,0x1
     f39:	48 c1 e2 05          	shl    rdx,0x5
     f3d:	48 01 d0             	add    rax,rdx
     f40:	8b 00                	mov    eax,DWORD PTR [rax]
     f42:	83 f8 ff             	cmp    eax,0xffffffff
     f45:	75 16                	jne    f5d <print_cpus+0xde>
						printf("%%Cpu%-3u: N/A\n");
     f47:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f4e:	b8 00 00 00 00       	mov    eax,0x0
     f53:	e8 00 00 00 00       	call   f58 <print_cpus+0xd9>
						continue;
     f58:	e9 19 01 00 00       	jmp    1076 <print_cpus+0x1f7>
				struct perf_ctrs* pc = get_cpu_data(i)->ticks;
     f5d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     f61:	89 c7                	mov    edi,eax
     f63:	e8 00 00 00 00       	call   f68 <print_cpus+0xe9>
     f68:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     f6c:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     f70:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     f74:	44 8b 58 44          	mov    r11d,DWORD PTR [rax+0x44]
     f78:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     f7c:	44 8b 50 48          	mov    r10d,DWORD PTR [rax+0x48]
						cpu_pcs[i + 1].vals[0], cpu_pcs[i + 1].vals[4], /* i pi */
     f80:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # f87 <print_cpus+0x108>
     f87:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     f8b:	48 83 c2 01          	add    rdx,0x1
     f8f:	48 c1 e2 05          	shl    rdx,0x5
     f93:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     f96:	44 8b 48 10          	mov    r9d,DWORD PTR [rax+0x10]
						cpu_pcs[i + 1].vals[0], cpu_pcs[i + 1].vals[4], /* i pi */
     f9a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fa1 <print_cpus+0x122>
     fa1:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     fa5:	48 83 c2 01          	add    rdx,0x1
     fa9:	48 c1 e2 05          	shl    rdx,0x5
     fad:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     fb0:	44 8b 00             	mov    r8d,DWORD PTR [rax]
						cpu_pcs[i + 1].vals[3], cpu_pcs[i + 1].vals[7], /* ni pni */
     fb3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fba <print_cpus+0x13b>
     fba:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     fbe:	48 83 c2 01          	add    rdx,0x1
     fc2:	48 c1 e2 05          	shl    rdx,0x5
     fc6:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     fc9:	8b 78 1c             	mov    edi,DWORD PTR [rax+0x1c]
						cpu_pcs[i + 1].vals[3], cpu_pcs[i + 1].vals[7], /* ni pni */
     fcc:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fd3 <print_cpus+0x154>
     fd3:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     fd7:	48 83 c2 01          	add    rdx,0x1
     fdb:	48 c1 e2 05          	shl    rdx,0x5
     fdf:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     fe2:	8b 70 0c             	mov    esi,DWORD PTR [rax+0xc]
						cpu_pcs[i + 1].vals[1], cpu_pcs[i + 1].vals[5], /* k pk */
     fe5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fec <print_cpus+0x16d>
     fec:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     ff0:	48 83 c2 01          	add    rdx,0x1
     ff4:	48 c1 e2 05          	shl    rdx,0x5
     ff8:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
     ffb:	44 8b 60 14          	mov    r12d,DWORD PTR [rax+0x14]
						cpu_pcs[i + 1].vals[1], cpu_pcs[i + 1].vals[5], /* k pk */
     fff:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1006 <print_cpus+0x187>
    1006:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    100a:	48 83 c2 01          	add    rdx,0x1
    100e:	48 c1 e2 05          	shl    rdx,0x5
    1012:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
    1015:	8b 58 04             	mov    ebx,DWORD PTR [rax+0x4]
						cpu_pcs[i + 1].vals[2], cpu_pcs[i + 1].vals[6], /* u pu */
    1018:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 101f <print_cpus+0x1a0>
    101f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1023:	48 83 c2 01          	add    rdx,0x1
    1027:	48 c1 e2 05          	shl    rdx,0x5
    102b:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
    102e:	8b 48 18             	mov    ecx,DWORD PTR [rax+0x18]
						cpu_pcs[i + 1].vals[2], cpu_pcs[i + 1].vals[6], /* u pu */
    1031:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1038 <print_cpus+0x1b9>
    1038:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    103c:	48 83 c2 01          	add    rdx,0x1
    1040:	48 c1 e2 05          	shl    rdx,0x5
    1044:	48 01 d0             	add    rax,rdx
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
    1047:	8b 50 08             	mov    edx,DWORD PTR [rax+0x8]
    104a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    104e:	41 53                	push   r11
    1050:	41 52                	push   r10
    1052:	41 51                	push   r9
    1054:	41 50                	push   r8
    1056:	57                   	push   rdi
    1057:	56                   	push   rsi
    1058:	45 89 e1             	mov    r9d,r12d
    105b:	41 89 d8             	mov    r8d,ebx
    105e:	48 89 c6             	mov    rsi,rax
    1061:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1068:	b8 00 00 00 00       	mov    eax,0x0
    106d:	e8 00 00 00 00       	call   1072 <print_cpus+0x1f3>
    1072:	48 83 c4 30          	add    rsp,0x30
		for (size_t i = 0; i < nproc; i++) {
    1076:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    107b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1081 <print_cpus+0x202>
    1081:	89 c0                	mov    eax,eax
    1083:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1087:	0f 82 9d fe ff ff    	jb     f2a <print_cpus+0xab>
}
    108d:	90                   	nop
    108e:	90                   	nop
    108f:	48 8d 65 f0          	lea    rsp,[rbp-0x10]
    1093:	5b                   	pop    rbx
    1094:	41 5c                	pop    r12
    1096:	5d                   	pop    rbp
    1097:	c3                   	ret

0000000000001098 <print_tasks>:
{
    1098:	55                   	push   rbp
    1099:	48 89 e5             	mov    rbp,rsp
    109c:	48 83 ec 10          	sub    rsp,0x10
		const char* md = "";
    10a0:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		if (cpu.invariant_tsc)
    10a8:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 10ae <print_tasks+0x16>
    10ae:	85 c0                	test   eax,eax
    10b0:	74 0a                	je     10bc <print_tasks+0x24>
				md = "inv_tsc";
    10b2:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    10ba:	eb 20                	jmp    10dc <print_tasks+0x44>
		else if (cpu.has_apic)
    10bc:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 10c3 <print_tasks+0x2b>
    10c3:	83 e0 02             	and    eax,0x2
    10c6:	84 c0                	test   al,al
    10c8:	74 0a                	je     10d4 <print_tasks+0x3c>
				md = "apic timer";
    10ca:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    10d2:	eb 08                	jmp    10dc <print_tasks+0x44>
				md = "PIT ticks";
    10d4:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		printf("Tasks:%4u total,%4u running,%4u pending,%4u sleeping\n",
    10dc:	8b 35 00 00 00 00    	mov    esi,DWORD PTR [rip+0x0]        # 10e2 <print_tasks+0x4a>
    10e2:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 10e8 <print_tasks+0x50>
    10e8:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 10ee <print_tasks+0x56>
    10ee:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 10f5 <print_tasks+0x5d>
    10f5:	41 89 f0             	mov    r8d,esi
    10f8:	48 89 c6             	mov    rsi,rax
    10fb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1102:	b8 00 00 00 00       	mov    eax,0x0
    1107:	e8 00 00 00 00       	call   110c <print_tasks+0x74>
		printf("Task time:%6u secs total, %4u ms last sec, mode: %s\n",
    110c:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 1112 <print_tasks+0x7a>
    1112:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1118 <print_tasks+0x80>
    1118:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    111c:	89 c6                	mov    esi,eax
    111e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1125:	b8 00 00 00 00       	mov    eax,0x0
    112a:	e8 00 00 00 00       	call   112f <print_tasks+0x97>
		print_cpus();
    112f:	b8 00 00 00 00       	mov    eax,0x0
    1134:	e8 00 00 00 00       	call   1139 <print_tasks+0xa1>
		printf("listing tasks: %u total" STAT_COUNTER("  major rotations: %u")  "\n", n_tks STAT_ARG(sched_mr_count));
    1139:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 113f <print_tasks+0xa7>
    113f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1146 <print_tasks+0xae>
    1146:	48 89 c6             	mov    rsi,rax
    1149:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1150:	b8 00 00 00 00       	mov    eax,0x0
    1155:	e8 00 00 00 00       	call   115a <print_tasks+0xc2>
		printf("ID FLG PROC STACK    PRIORITY  RUNTIME[ms] RUNTIME      QTA NAME        " STAT_COUNTER("SCHED  ") "\n"
    115a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1161:	b8 00 00 00 00       	mov    eax,0x0
    1166:	e8 00 00 00 00       	call   116b <print_tasks+0xd3>
		for (size_t i = 0; i < n_tks; i++)
    116b:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1173:	eb 19                	jmp    118e <print_tasks+0xf6>
				print_task(tks[i]);
    1175:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1179:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    1181:	48 89 c7             	mov    rdi,rax
    1184:	e8 00 00 00 00       	call   1189 <print_tasks+0xf1>
		for (size_t i = 0; i < n_tks; i++)
    1189:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    118e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1195 <print_tasks+0xfd>
    1195:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    1199:	72 da                	jb     1175 <print_tasks+0xdd>
}
    119b:	90                   	nop
    119c:	90                   	nop
    119d:	c9                   	leave
    119e:	c3                   	ret

000000000000119f <task_do_stats>:
{
    119f:	55                   	push   rbp
    11a0:	48 89 e5             	mov    rbp,rsp
    11a3:	48 83 ec 20          	sub    rsp,0x20
		bzero(&task_stats, sizeof(task_stats));
    11a7:	be 14 00 00 00       	mov    esi,0x14
    11ac:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    11b3:	e8 00 00 00 00       	call   11b8 <task_do_stats+0x19>
		for (size_t i = 0; i < n_tks; i++) {
    11b8:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    11c0:	e9 13 01 00 00       	jmp    12d8 <task_do_stats+0x139>
				struct tsi* t = tks[i];
    11c5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11c9:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    11d1:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if (!t)
    11d5:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    11da:	0f 84 f2 00 00 00    	je     12d2 <task_do_stats+0x133>
				t->run_time_sec = t->run_time - t->sec_run_time;
    11e0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    11e4:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
    11e7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    11eb:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    11ee:	29 c2                	sub    edx,eax
    11f0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    11f4:	89 50 34             	mov    DWORD PTR [rax+0x34],edx
				t->sec_run_time = t->run_time;
    11f7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    11fb:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
    11fe:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1202:	89 50 30             	mov    DWORD PTR [rax+0x30],edx
				t->ns_per_sec = t->ns_acc - t->sec_ns_acc;
    1205:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1209:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
    120d:	89 c2                	mov    edx,eax
    120f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1213:	48 8b 40 70          	mov    rax,QWORD PTR [rax+0x70]
    1217:	29 c2                	sub    edx,eax
    1219:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    121d:	89 50 78             	mov    DWORD PTR [rax+0x78],edx
				t->sec_ns_acc = t->ns_acc;
    1220:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1224:	48 8b 50 68          	mov    rdx,QWORD PTR [rax+0x68]
    1228:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    122c:	48 89 50 70          	mov    QWORD PTR [rax+0x70],rdx
				if (t->flags & TIF_RUNNING)
    1230:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1234:	8b 00                	mov    eax,DWORD PTR [rax]
    1236:	83 e0 10             	and    eax,0x10
    1239:	85 c0                	test   eax,eax
    123b:	74 11                	je     124e <task_do_stats+0xaf>
						task_stats.n_running++;
    123d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1243 <task_do_stats+0xa4>
    1243:	83 c0 01             	add    eax,0x1
    1246:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 124c <task_do_stats+0xad>
    124c:	eb 2f                	jmp    127d <task_do_stats+0xde>
				else if (t->flags & TIF_SLEEPING)
    124e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1252:	8b 00                	mov    eax,DWORD PTR [rax]
    1254:	25 80 00 00 00       	and    eax,0x80
    1259:	85 c0                	test   eax,eax
    125b:	74 11                	je     126e <task_do_stats+0xcf>
						task_stats.n_sleeping++;
    125d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1263 <task_do_stats+0xc4>
    1263:	83 c0 01             	add    eax,0x1
    1266:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 126c <task_do_stats+0xcd>
    126c:	eb 0f                	jmp    127d <task_do_stats+0xde>
						task_stats.n_pending++;
    126e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1274 <task_do_stats+0xd5>
    1274:	83 c0 01             	add    eax,0x1
    1277:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 127d <task_do_stats+0xde>
				task_stats.tot_runtime += (uint32_t)(t->ns_acc / 1000000000llu);
    127d:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 1283 <task_do_stats+0xe4>
    1283:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1287:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
    128b:	48 c1 e8 09          	shr    rax,0x9
    128f:	48 ba 53 5a 9b a0 2f b8 44 00 	movabs rdx,0x44b82fa09b5a53
    1299:	48 f7 e2             	mul    rdx
    129c:	48 89 d0             	mov    rax,rdx
    129f:	48 c1 e8 0b          	shr    rax,0xb
    12a3:	01 c8                	add    eax,ecx
    12a5:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 12ab <task_do_stats+0x10c>
				task_stats.sec_runtime += t->ns_per_sec / 1000000;
    12ab:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 12b1 <task_do_stats+0x112>
    12b1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    12b5:	8b 40 78             	mov    eax,DWORD PTR [rax+0x78]
    12b8:	89 c0                	mov    eax,eax
    12ba:	48 69 c0 83 de 1b 43 	imul   rax,rax,0x431bde83
    12c1:	48 c1 e8 20          	shr    rax,0x20
    12c5:	c1 e8 12             	shr    eax,0x12
    12c8:	01 d0                	add    eax,edx
    12ca:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 12d0 <task_do_stats+0x131>
    12d0:	eb 01                	jmp    12d3 <task_do_stats+0x134>
						continue;
    12d2:	90                   	nop
		for (size_t i = 0; i < n_tks; i++) {
    12d3:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    12d8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 12df <task_do_stats+0x140>
    12df:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    12e3:	0f 82 dc fe ff ff    	jb     11c5 <task_do_stats+0x26>
		for (size_t i = 0; i < nproc; i++) {
    12e9:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    12f1:	e9 c8 00 00 00       	jmp    13be <task_do_stats+0x21f>
				struct perf_ctrs* pc = cpu_stat_counter(i);
    12f6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    12fa:	89 c7                	mov    edi,eax
    12fc:	e8 00 00 00 00       	call   1301 <task_do_stats+0x162>
    1301:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!pc)
    1305:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    130a:	0f 84 a8 00 00 00    	je     13b8 <task_do_stats+0x219>
				pc->ns_idle_per_sec = pc->ns_idle - pc->sec_ns_idle;
    1310:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1314:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1318:	89 c2                	mov    edx,eax
    131a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    131e:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1322:	29 c2                	sub    edx,eax
    1324:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1328:	89 50 38             	mov    DWORD PTR [rax+0x38],edx
				pc->sec_ns_idle = pc->ns_idle;
    132b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    132f:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    1333:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1337:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
				pc->ns_user_per_sec = pc->ns_user - pc->sec_ns_user;
    133b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    133f:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1343:	89 c2                	mov    edx,eax
    1345:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1349:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    134d:	29 c2                	sub    edx,eax
    134f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1353:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
				pc->sec_ns_user = pc->ns_user;
    1356:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    135a:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
    135e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1362:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
				pc->ns_kernel_per_sec = pc->ns_kernel - pc->sec_ns_kernel;
    1366:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    136a:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    136e:	89 c2                	mov    edx,eax
    1370:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1374:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    1378:	29 c2                	sub    edx,eax
    137a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    137e:	89 50 3c             	mov    DWORD PTR [rax+0x3c],edx
				pc->sec_ns_kernel = pc->ns_kernel;
    1381:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1385:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1389:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    138d:	48 89 50 28          	mov    QWORD PTR [rax+0x28],rdx
				pc->n_times_per_sec = pc->n_times - pc->sec_n_times;
    1391:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1395:	8b 50 44             	mov    edx,DWORD PTR [rax+0x44]
    1398:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    139c:	8b 40 4c             	mov    eax,DWORD PTR [rax+0x4c]
    139f:	29 c2                	sub    edx,eax
    13a1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13a5:	89 50 48             	mov    DWORD PTR [rax+0x48],edx
				pc->sec_n_times = pc->n_times;
    13a8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13ac:	8b 50 44             	mov    edx,DWORD PTR [rax+0x44]
    13af:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13b3:	89 50 4c             	mov    DWORD PTR [rax+0x4c],edx
    13b6:	eb 01                	jmp    13b9 <task_do_stats+0x21a>
						continue;
    13b8:	90                   	nop
		for (size_t i = 0; i < nproc; i++) {
    13b9:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    13be:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 13c4 <task_do_stats+0x225>
    13c4:	89 c0                	mov    eax,eax
    13c6:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    13ca:	0f 82 26 ff ff ff    	jb     12f6 <task_do_stats+0x157>
		cpu_do_stats();
    13d0:	b8 00 00 00 00       	mov    eax,0x0
    13d5:	e8 00 00 00 00       	call   13da <task_do_stats+0x23b>
}
    13da:	90                   	nop
    13db:	c9                   	leave
    13dc:	c3                   	ret

00000000000013dd <task_initfunc>:
{
    13dd:	55                   	push   rbp
    13de:	48 89 e5             	mov    rbp,rsp
    13e1:	48 83 ec 10          	sub    rsp,0x10
		asm volatile("mov %%rax, %0" : "=rm" (fun) );
    13e5:	48 89 c0             	mov    rax,rax
    13e8:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		asm volatile("mov %%rcx, %0" : "=rm" (arg) );
    13ec:	48 89 c8             	mov    rax,rcx
    13ef:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		asm ("sti");
    13f3:	fb                   	sti
		fun(arg);
    13f4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13f8:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    13fc:	48 89 c7             	mov    rdi,rax
    13ff:	ff d2                	call   rdx
		get_task()->flags |= TIF_DEALLOCATE;
    1401:	b8 00 00 00 00       	mov    eax,0x0
    1406:	e8 00 00 00 00       	call   140b <task_initfunc+0x2e>
    140b:	8b 10                	mov    edx,DWORD PTR [rax]
    140d:	83 ca 04             	or     edx,0x4
    1410:	89 10                	mov    DWORD PTR [rax],edx
		task_yield();
    1412:	b8 00 00 00 00       	mov    eax,0x0
    1417:	e8 00 00 00 00       	call   141c <task_initfunc+0x3f>
				cprintf(KFMT_WARN, "Deallocated task is rescheduled. This should never happen!\n");
    141c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1423:	bf 0e 00 00 00       	mov    edi,0xe
    1428:	b8 00 00 00 00       	mov    eax,0x0
    142d:	e8 00 00 00 00       	call   1432 <task_initfunc+0x55>
				task_yield();
    1432:	b8 00 00 00 00       	mov    eax,0x0
    1437:	e8 00 00 00 00       	call   143c <task_initfunc+0x5f>
				cprintf(KFMT_WARN, "Deallocated task is rescheduled. This should never happen!\n");
    143c:	90                   	nop
    143d:	eb dd                	jmp    141c <task_initfunc+0x3f>

000000000000143f <task_spawn_named>:
{
    143f:	55                   	push   rbp
    1440:	48 89 e5             	mov    rbp,rsp
    1443:	53                   	push   rbx
    1444:	48 81 ec f8 00 00 00 	sub    rsp,0xf8
    144b:	48 89 bd 18 ff ff ff 	mov    QWORD PTR [rbp-0xe8],rdi
    1452:	48 89 b5 10 ff ff ff 	mov    QWORD PTR [rbp-0xf0],rsi
    1459:	89 95 0c ff ff ff    	mov    DWORD PTR [rbp-0xf4],edx
    145f:	48 89 8d 00 ff ff ff 	mov    QWORD PTR [rbp-0x100],rcx
		if (n_tks < 128) {
    1466:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 146d <task_spawn_named+0x2e>
    146d:	48 83 f8 7f          	cmp    rax,0x7f
    1471:	0f 87 18 03 00 00    	ja     178f <task_spawn_named+0x350>
				struct tsi ts = {0}; int flg;
    1477:	48 8d 95 20 ff ff ff 	lea    rdx,[rbp-0xe0]
    147e:	b8 00 00 00 00       	mov    eax,0x0
    1483:	b9 11 00 00 00       	mov    ecx,0x11
    1488:	48 89 d7             	mov    rdi,rdx
    148b:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
				void* stk = alloc_stack();
    148e:	b8 00 00 00 00       	mov    eax,0x0
    1493:	e8 00 00 00 00       	call   1498 <task_spawn_named+0x59>
    1498:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!stk) {
    149c:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    14a1:	75 30                	jne    14d3 <task_spawn_named+0x94>
						die("Failed to alloc stack!\n");
    14a3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    14aa:	bf 0c 00 00 00       	mov    edi,0xc
    14af:	b8 00 00 00 00       	mov    eax,0x0
    14b4:	e8 00 00 00 00       	call   14b9 <task_spawn_named+0x7a>
    14b9:	b8 00 00 00 00       	mov    eax,0x0
    14be:	e8 00 00 00 00       	call   14c3 <task_spawn_named+0x84>
    14c3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    14ca:	e8 00 00 00 00       	call   14cf <task_spawn_named+0x90>
    14cf:	fa                   	cli
    14d0:	f4                   	hlt
    14d1:	eb fd                	jmp    14d0 <task_spawn_named+0x91>
				if ((flg = if_enabled()))
    14d3:	b8 00 00 00 00       	mov    eax,0x0
    14d8:	e8 3e eb ff ff       	call   1b <if_enabled>
    14dd:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
    14e0:	83 7d e4 00          	cmp    DWORD PTR [rbp-0x1c],0x0
    14e4:	74 13                	je     14f9 <task_spawn_named+0xba>
						preempt_disable();
    14e6:	b8 00 00 00 00       	mov    eax,0x0
    14eb:	e8 00 00 00 00       	call   14f0 <task_spawn_named+0xb1>
    14f0:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    14f3:	83 c2 01             	add    edx,0x1
    14f6:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
				spin_lock(&pq_lock);
    14f9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1500:	e8 00 00 00 00       	call   1505 <task_spawn_named+0xc6>
				struct tsi* pts = stk;
    1505:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1509:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				pts--;
    150d:	48 81 6d d8 88 00 00 00 	sub    QWORD PTR [rbp-0x28],0x88
				struct task_state* ti = (void*)pts;
    1515:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1519:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				ti--; /* store info at stack bottom */
    151d:	48 81 6d d0 c8 00 00 00 	sub    QWORD PTR [rbp-0x30],0xc8
				id = get_stack(stk, &sl);
    1525:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
    1529:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    152d:	48 89 d6             	mov    rsi,rdx
    1530:	48 89 c7             	mov    rdi,rax
    1533:	e8 00 00 00 00       	call   1538 <task_spawn_named+0xf9>
    1538:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
				ts.flags = TIF_KERNEL_STACK;
    153b:	c7 85 20 ff ff ff 08 00 00 00 	mov    DWORD PTR [rbp-0xe0],0x8
				ts.task_id = id;
    1545:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    1548:	89 85 48 ff ff ff    	mov    DWORD PTR [rbp-0xb8],eax
				ts.stack_base = sl.base;
    154e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1552:	48 89 85 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rax
				ts.stack_limit = sl.limit;
    1559:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    155d:	48 89 85 38 ff ff ff 	mov    QWORD PTR [rbp-0xc8],rax
				ts.priority = ts.cur_priority = priority;
    1564:	8b 85 0c ff ff ff    	mov    eax,DWORD PTR [rbp-0xf4]
    156a:	89 85 64 ff ff ff    	mov    DWORD PTR [rbp-0x9c],eax
    1570:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
    1576:	89 85 5c ff ff ff    	mov    DWORD PTR [rbp-0xa4],eax
				ts.name = name;
    157c:	48 8b 85 00 ff ff ff 	mov    rax,QWORD PTR [rbp-0x100]
    1583:	48 89 85 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rax
				ts.quota = 10; ts.run_time = 0;
    158a:	c7 85 60 ff ff ff 0a 00 00 00 	mov    DWORD PTR [rbp-0xa0],0xa
    1594:	c7 85 58 ff ff ff 00 00 00 00 	mov    DWORD PTR [rbp-0xa8],0x0
				ts.ts = ti;
    159e:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15a2:	48 89 85 28 ff ff ff 	mov    QWORD PTR [rbp-0xd8],rax
				ts.task_proc = 0xffffffff;
    15a9:	c7 85 78 ff ff ff ff ff ff ff 	mov    DWORD PTR [rbp-0x88],0xffffffff
				bzero(ti, sizeof(*ti));
    15b3:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15b7:	be c8 00 00 00       	mov    esi,0xc8
    15bc:	48 89 c7             	mov    rdi,rax
    15bf:	e8 00 00 00 00       	call   15c4 <task_spawn_named+0x185>
				ti->cs = SEG_CODE;
    15c4:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15c8:	48 c7 80 a8 00 00 00 08 00 00 00 	mov    QWORD PTR [rax+0xa8],0x8
				ti->ds = ti->es = SEG_DATA;
    15d3:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15d7:	48 c7 40 10 10 00 00 00 	mov    QWORD PTR [rax+0x10],0x10
    15df:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15e3:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    15e7:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15eb:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
				ti->gs = SEG_DATA_PROC;
    15ef:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15f3:	48 c7 00 38 00 00 00 	mov    QWORD PTR [rax],0x38
				ti->fs = SEG_DATA;
    15fa:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    15fe:	48 c7 40 08 10 00 00 00 	mov    QWORD PTR [rax+0x8],0x10
				ti->rsp = (uint64_t)ti;
    1606:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    160a:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    160e:	48 89 50 78          	mov    QWORD PTR [rax+0x78],rdx
				ti->rbp = ti->rsp;
    1612:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1616:	48 8b 50 78          	mov    rdx,QWORD PTR [rax+0x78]
    161a:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    161e:	48 89 50 70          	mov    QWORD PTR [rax+0x70],rdx
				ti->rflags = (1 << 9)/* | (1 << 8)*/; /* IF TF (interrupt enable, single-step) */
    1622:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1626:	48 c7 80 b0 00 00 00 00 02 00 00 	mov    QWORD PTR [rax+0xb0],0x200
				ti->rax = (uint64_t)fn;
    1631:	48 8b 95 18 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xe8]
    1638:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    163c:	48 89 90 98 00 00 00 	mov    QWORD PTR [rax+0x98],rdx
				ti->rcx = (uint64_t)dat;
    1643:	48 8b 95 10 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xf0]
    164a:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    164e:	48 89 90 90 00 00 00 	mov    QWORD PTR [rax+0x90],rdx
				ti->rip = (uint64_t)task_initfunc;
    1655:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    165c:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1660:	48 89 90 a0 00 00 00 	mov    QWORD PTR [rax+0xa0],rdx
				*pts = ts;
    1667:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    166b:	48 8b 8d 20 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xe0]
    1672:	48 8b 9d 28 ff ff ff 	mov    rbx,QWORD PTR [rbp-0xd8]
    1679:	48 89 08             	mov    QWORD PTR [rax],rcx
    167c:	48 89 58 08          	mov    QWORD PTR [rax+0x8],rbx
    1680:	48 8b 8d 30 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xd0]
    1687:	48 8b 9d 38 ff ff ff 	mov    rbx,QWORD PTR [rbp-0xc8]
    168e:	48 89 48 10          	mov    QWORD PTR [rax+0x10],rcx
    1692:	48 89 58 18          	mov    QWORD PTR [rax+0x18],rbx
    1696:	48 8b 8d 40 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xc0]
    169d:	48 8b 9d 48 ff ff ff 	mov    rbx,QWORD PTR [rbp-0xb8]
    16a4:	48 89 48 20          	mov    QWORD PTR [rax+0x20],rcx
    16a8:	48 89 58 28          	mov    QWORD PTR [rax+0x28],rbx
    16ac:	48 8b 8d 50 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xb0]
    16b3:	48 8b 9d 58 ff ff ff 	mov    rbx,QWORD PTR [rbp-0xa8]
    16ba:	48 89 48 30          	mov    QWORD PTR [rax+0x30],rcx
    16be:	48 89 58 38          	mov    QWORD PTR [rax+0x38],rbx
    16c2:	48 8b 8d 60 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xa0]
    16c9:	48 8b 9d 68 ff ff ff 	mov    rbx,QWORD PTR [rbp-0x98]
    16d0:	48 89 48 40          	mov    QWORD PTR [rax+0x40],rcx
    16d4:	48 89 58 48          	mov    QWORD PTR [rax+0x48],rbx
    16d8:	48 8b 8d 70 ff ff ff 	mov    rcx,QWORD PTR [rbp-0x90]
    16df:	48 8b 9d 78 ff ff ff 	mov    rbx,QWORD PTR [rbp-0x88]
    16e6:	48 89 48 50          	mov    QWORD PTR [rax+0x50],rcx
    16ea:	48 89 58 58          	mov    QWORD PTR [rax+0x58],rbx
    16ee:	48 8b 4d 80          	mov    rcx,QWORD PTR [rbp-0x80]
    16f2:	48 8b 5d 88          	mov    rbx,QWORD PTR [rbp-0x78]
    16f6:	48 89 48 60          	mov    QWORD PTR [rax+0x60],rcx
    16fa:	48 89 58 68          	mov    QWORD PTR [rax+0x68],rbx
    16fe:	48 8b 4d 90          	mov    rcx,QWORD PTR [rbp-0x70]
    1702:	48 8b 5d 98          	mov    rbx,QWORD PTR [rbp-0x68]
    1706:	48 89 48 70          	mov    QWORD PTR [rax+0x70],rcx
    170a:	48 89 58 78          	mov    QWORD PTR [rax+0x78],rbx
    170e:	48 8b 55 a0          	mov    rdx,QWORD PTR [rbp-0x60]
    1712:	48 89 90 80 00 00 00 	mov    QWORD PTR [rax+0x80],rdx
				tks[n_tks++] = pts;
    1719:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1720 <task_spawn_named+0x2e1>
    1720:	48 8d 50 01          	lea    rdx,[rax+0x1]
    1724:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 172b <task_spawn_named+0x2ec>
    172b:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    172f:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
				pq_enqueue(run_queue, pts);
    1737:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 173e <task_spawn_named+0x2ff>
    173e:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1742:	48 89 d6             	mov    rsi,rdx
    1745:	48 89 c7             	mov    rdi,rax
    1748:	e8 00 00 00 00       	call   174d <task_spawn_named+0x30e>
				spin_unlock(&pq_lock);
    174d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1754:	e8 00 00 00 00       	call   1759 <task_spawn_named+0x31a>
				if (flg)
    1759:	83 7d e4 00          	cmp    DWORD PTR [rbp-0x1c],0x0
    175d:	74 30                	je     178f <task_spawn_named+0x350>
						preempt_enable();
    175f:	b8 00 00 00 00       	mov    eax,0x0
    1764:	e8 00 00 00 00       	call   1769 <task_spawn_named+0x32a>
    1769:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    176c:	83 ea 01             	sub    edx,0x1
    176f:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
    1772:	b8 00 00 00 00       	mov    eax,0x0
    1777:	e8 00 00 00 00       	call   177c <task_spawn_named+0x33d>
    177c:	8b 00                	mov    eax,DWORD PTR [rax]
    177e:	83 e0 01             	and    eax,0x1
    1781:	85 c0                	test   eax,eax
    1783:	74 0a                	je     178f <task_spawn_named+0x350>
    1785:	b8 00 00 00 00       	mov    eax,0x0
    178a:	e8 00 00 00 00       	call   178f <task_spawn_named+0x350>
}
    178f:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    1793:	c9                   	leave
    1794:	c3                   	ret

0000000000001795 <task_deallocate>:
{
    1795:	55                   	push   rbp
    1796:	48 89 e5             	mov    rbp,rsp
    1799:	48 83 ec 18          	sub    rsp,0x18
    179d:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		for (size_t i = 0; i < n_tks; i++)
    17a1:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    17a9:	eb 56                	jmp    1801 <task_deallocate+0x6c>
				if (tks[i] == t) {
    17ab:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    17af:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    17b7:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    17bb:	75 3f                	jne    17fc <task_deallocate+0x67>
						tks[i] = NULL;
    17bd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    17c1:	48 c7 04 c5 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],0x0
						tks[i] = tks[--n_tks];
    17cd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17d4 <task_deallocate+0x3f>
    17d4:	48 83 e8 01          	sub    rax,0x1
    17d8:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 17df <task_deallocate+0x4a>
    17df:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17e6 <task_deallocate+0x51>
    17e6:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    17ee:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    17f2:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						break;
    17fa:	eb 12                	jmp    180e <task_deallocate+0x79>
		for (size_t i = 0; i < n_tks; i++)
    17fc:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    1801:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1808 <task_deallocate+0x73>
    1808:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    180c:	72 9d                	jb     17ab <task_deallocate+0x16>
		free_stack(t->stack_base);
    180e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1812:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1816:	48 89 c7             	mov    rdi,rax
    1819:	e8 00 00 00 00       	call   181e <task_deallocate+0x89>
}
    181e:	90                   	nop
    181f:	c9                   	leave
    1820:	c3                   	ret

0000000000001821 <task_diag>:
{
    1821:	55                   	push   rbp
    1822:	48 89 e5             	mov    rbp,rsp
    1825:	48 83 ec 10          	sub    rsp,0x10
		size_t end = pr_idx;
    1829:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1830 <task_diag+0xf>
    1830:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		asm("cli");
    1834:	fa                   	cli
		if (diag++)
    1835:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 183b <task_diag+0x1a>
    183b:	8d 50 01             	lea    edx,[rax+0x1]
    183e:	89 15 00 00 00 00    	mov    DWORD PTR [rip+0x0],edx        # 1844 <task_diag+0x23>
    1844:	85 c0                	test   eax,eax
    1846:	0f 85 2f 01 00 00    	jne    197b <task_diag+0x15a>
		framebuffer_redraw(&fb_initial);
    184c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1853:	e8 00 00 00 00       	call   1858 <task_diag+0x37>
		mdelay(1000);
    1858:	bf e8 03 00 00       	mov    edi,0x3e8
    185d:	e8 00 00 00 00       	call   1862 <task_diag+0x41>
		print_tasks();
    1862:	b8 00 00 00 00       	mov    eax,0x0
    1867:	e8 00 00 00 00       	call   186c <task_diag+0x4b>
		printf("PROC TASK TASK_NAME        EIP      ESP\n");
    186c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1873:	b8 00 00 00 00       	mov    eax,0x0
    1878:	e8 00 00 00 00       	call   187d <task_diag+0x5c>
		for (size_t i = end - 1; i != end; i--) {
    187d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1881:	48 83 e8 01          	sub    rax,0x1
    1885:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1889:	e9 dd 00 00 00       	jmp    196b <task_diag+0x14a>
						pr_lst[i].eip, pr_lst[i].esp);
    188e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1895 <task_diag+0x74>
    1895:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1899:	48 c1 e2 05          	shl    rdx,0x5
    189d:	48 01 d0             	add    rax,rdx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    18a0:	4c 8b 40 18          	mov    r8,QWORD PTR [rax+0x18]
						pr_lst[i].eip, pr_lst[i].esp);
    18a4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18ab <task_diag+0x8a>
    18ab:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    18af:	48 c1 e2 05          	shl    rdx,0x5
    18b3:	48 01 d0             	add    rax,rdx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    18b6:	48 8b 78 10          	mov    rdi,QWORD PTR [rax+0x10]
						pr_lst[i].task_id, pr_lst[i].task_name,
    18ba:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18c1 <task_diag+0xa0>
    18c1:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    18c5:	48 c1 e2 05          	shl    rdx,0x5
    18c9:	48 01 d0             	add    rax,rdx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    18cc:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
						pr_lst[i].task_id, pr_lst[i].task_name,
    18d0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18d7 <task_diag+0xb6>
    18d7:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    18db:	48 c1 e1 05          	shl    rcx,0x5
    18df:	48 01 c8             	add    rax,rcx
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
    18e2:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    18e5:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 18ec <task_diag+0xcb>
    18ec:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
    18f0:	48 c1 e6 05          	shl    rsi,0x5
    18f4:	48 01 f1             	add    rcx,rsi
    18f7:	8b 09                	mov    ecx,DWORD PTR [rcx]
    18f9:	89 ce                	mov    esi,ecx
    18fb:	c1 ee 18             	shr    esi,0x18
    18fe:	4d 89 c1             	mov    r9,r8
    1901:	49 89 f8             	mov    r8,rdi
    1904:	48 89 d1             	mov    rcx,rdx
    1907:	89 c2                	mov    edx,eax
    1909:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1910:	b8 00 00 00 00       	mov    eax,0x0
    1915:	e8 00 00 00 00       	call   191a <task_diag+0xf9>
				if (i % 20)
    191a:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    191e:	48 ba cd cc cc cc cc cc cc cc 	movabs rdx,0xcccccccccccccccd
    1928:	48 89 c8             	mov    rax,rcx
    192b:	48 f7 e2             	mul    rdx
    192e:	48 c1 ea 04          	shr    rdx,0x4
    1932:	48 89 d0             	mov    rax,rdx
    1935:	48 c1 e0 02          	shl    rax,0x2
    1939:	48 01 d0             	add    rax,rdx
    193c:	48 c1 e0 02          	shl    rax,0x2
    1940:	48 29 c1             	sub    rcx,rax
    1943:	48 89 ca             	mov    rdx,rcx
    1946:	48 85 d2             	test   rdx,rdx
    1949:	74 0c                	je     1957 <task_diag+0x136>
						framebuffer_redraw(&fb_initial);
    194b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1952:	e8 00 00 00 00       	call   1957 <task_diag+0x136>
				if (!i)
    1957:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    195c:	75 08                	jne    1966 <task_diag+0x145>
						i = 128;
    195e:	48 c7 45 f8 80 00 00 00 	mov    QWORD PTR [rbp-0x8],0x80
		for (size_t i = end - 1; i != end; i--) {
    1966:	48 83 6d f8 01       	sub    QWORD PTR [rbp-0x8],0x1
    196b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    196f:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    1973:	0f 85 15 ff ff ff    	jne    188e <task_diag+0x6d>
    1979:	eb 01                	jmp    197c <task_diag+0x15b>
				return;
    197b:	90                   	nop
}
    197c:	c9                   	leave
    197d:	c3                   	ret

000000000000197e <proc_add_time>:
{
    197e:	55                   	push   rbp
    197f:	48 89 e5             	mov    rbp,rsp
    1982:	48 83 ec 20          	sub    rsp,0x20
    1986:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    198a:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct perf_ctrs* pc = (nproc > 1) ? per_cpu_ptr()->ticks : bp_tick;
    198d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1993 <proc_add_time+0x15>
    1993:	83 f8 01             	cmp    eax,0x1
    1996:	76 10                	jbe    19a8 <proc_add_time+0x2a>
    1998:	b8 00 00 00 00       	mov    eax,0x0
    199d:	e8 5e e6 ff ff       	call   0 <per_cpu_ptr>
    19a2:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    19a6:	eb 07                	jmp    19af <proc_add_time+0x31>
    19a8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 19af <proc_add_time+0x31>
    19af:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		/* we're inside the pq lock -> no sync */
		if (flags & TIF_IDLE)
    19b3:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    19b6:	83 e0 40             	and    eax,0x40
    19b9:	85 c0                	test   eax,eax
    19bb:	74 19                	je     19d6 <proc_add_time+0x58>
				pc->ns_idle += ns;
    19bd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19c1:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    19c5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    19c9:	48 01 c2             	add    rdx,rax
    19cc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19d0:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    19d4:	eb 3a                	jmp    1a10 <proc_add_time+0x92>
		else if (flags & TIF_KERNEL_STACK)
    19d6:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    19d9:	83 e0 08             	and    eax,0x8
    19dc:	85 c0                	test   eax,eax
    19de:	74 19                	je     19f9 <proc_add_time+0x7b>
				pc->ns_kernel += ns;
    19e0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19e4:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    19e8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    19ec:	48 01 c2             	add    rdx,rax
    19ef:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19f3:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
    19f7:	eb 17                	jmp    1a10 <proc_add_time+0x92>
		else
				pc->ns_user += ns;
    19f9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19fd:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
    1a01:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a05:	48 01 c2             	add    rdx,rax
    1a08:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a0c:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
		pc->n_times++;
    1a10:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a14:	8b 40 44             	mov    eax,DWORD PTR [rax+0x44]
    1a17:	8d 50 01             	lea    edx,[rax+0x1]
    1a1a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a1e:	89 50 44             	mov    DWORD PTR [rax+0x44],edx
}
    1a21:	90                   	nop
    1a22:	c9                   	leave
    1a23:	c3                   	ret

0000000000001a24 <get_runtime>:

/* returns runtime in ns */
uint64_t get_runtime(struct tsi* t)
{
    1a24:	55                   	push   rbp
    1a25:	48 89 e5             	mov    rbp,rsp
    1a28:	48 83 ec 38          	sub    rsp,0x38
    1a2c:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
		uint64_t rv;
		union {	uint64_t val; struct { uint32_t lo, hi; }; } b, e, d;
		b.val = t->start_time;
    1a30:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1a34:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    1a38:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		e.val = t->stop_time;
    1a3c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1a40:	48 8b 40 50          	mov    rax,QWORD PTR [rax+0x50]
    1a44:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		d.val = e.val - b.val;
    1a48:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    1a4c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a50:	48 29 c2             	sub    rdx,rax
    1a53:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		if (cpu.invariant_tsc) {
    1a57:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1a5d <get_runtime+0x39>
    1a5d:	85 c0                	test   eax,eax
    1a5f:	74 23                	je     1a84 <get_runtime+0x60>
				rv = 1000000 * d.val / tsc_per_ms;
    1a61:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a65:	48 69 c0 40 42 0f 00 	imul   rax,rax,0xf4240
    1a6c:	48 8b 35 00 00 00 00 	mov    rsi,QWORD PTR [rip+0x0]        # 1a73 <get_runtime+0x4f>
    1a73:	ba 00 00 00 00       	mov    edx,0x0
    1a78:	48 f7 f6             	div    rsi
    1a7b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1a7f:	e9 b9 00 00 00       	jmp    1b3d <get_runtime+0x119>
		} else if (cpu.has_acpi) {
    1a84:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1a8b <get_runtime+0x67>
    1a8b:	83 e0 40             	and    eax,0x40
    1a8e:	84 c0                	test   al,al
    1a90:	74 7c                	je     1b0e <get_runtime+0xea>
				int64_t bias = 0;
    1a92:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				/* complicated double values */
				d.hi = e.hi - b.hi; /* jiffie/HZ difference */
    1a9a:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    1a9d:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1aa0:	29 c2                	sub    edx,eax
    1aa2:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
				/* countdown timer values */
				bias = e.lo - b.lo;
    1aa5:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
    1aa8:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1aab:	29 c2                	sub    edx,eax
    1aad:	89 d0                	mov    eax,edx
    1aaf:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				bias = bias * 1000000000ll / (HZ * apic_reload_value);
    1ab3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1ab7:	48 69 c0 00 ca 9a 3b 	imul   rax,rax,0x3b9aca00
    1abe:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 1ac4 <get_runtime+0xa0>
    1ac4:	6b d2 79             	imul   edx,edx,0x79
    1ac7:	89 d7                	mov    edi,edx
    1ac9:	48 99                	cqo
    1acb:	48 f7 ff             	idiv   rdi
    1ace:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				rv = (uint64_t)(1000000000ull * d.hi / HZ + bias);
    1ad2:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1ad5:	89 c0                	mov    eax,eax
    1ad7:	48 69 c8 00 ca 9a 3b 	imul   rcx,rax,0x3b9aca00
    1ade:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    1ae8:	48 89 c8             	mov    rax,rcx
    1aeb:	48 f7 e2             	mul    rdx
    1aee:	48 89 c8             	mov    rax,rcx
    1af1:	48 29 d0             	sub    rax,rdx
    1af4:	48 d1 e8             	shr    rax,1
    1af7:	48 01 d0             	add    rax,rdx
    1afa:	48 c1 e8 06          	shr    rax,0x6
    1afe:	48 89 c2             	mov    rdx,rax
    1b01:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b05:	48 01 d0             	add    rax,rdx
    1b08:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1b0c:	eb 2f                	jmp    1b3d <get_runtime+0x119>
		} else { /* jiffies */
				rv = 1000000000ull * d.val / HZ;
    1b0e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1b12:	48 69 c8 00 ca 9a 3b 	imul   rcx,rax,0x3b9aca00
    1b19:	48 ba e3 fd c8 69 be 56 cf 0e 	movabs rdx,0xecf56be69c8fde3
    1b23:	48 89 c8             	mov    rax,rcx
    1b26:	48 f7 e2             	mul    rdx
    1b29:	48 89 c8             	mov    rax,rcx
    1b2c:	48 29 d0             	sub    rax,rdx
    1b2f:	48 d1 e8             	shr    rax,1
    1b32:	48 01 d0             	add    rax,rdx
    1b35:	48 c1 e8 06          	shr    rax,0x6
    1b39:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		}
		return rv;
    1b3d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
    1b41:	c9                   	leave
    1b42:	c3                   	ret

0000000000001b43 <sleep>:
struct wait_queue_head wq_idle = WAIT_QUEUE_HEAD(wq_idle);
struct wait_queue_head wq_timer = WAIT_QUEUE_HEAD(wq_timer);

int sleep(unsigned int seconds)
{
    1b43:	55                   	push   rbp
    1b44:	48 89 e5             	mov    rbp,rsp
    1b47:	48 83 ec 10          	sub    rsp,0x10
    1b4b:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		wait_timeout(&wq_timer, HZ * seconds);
    1b4e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1b51:	6b c0 79             	imul   eax,eax,0x79
    1b54:	89 c6                	mov    esi,eax
    1b56:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1b5d:	e8 00 00 00 00       	call   1b62 <sleep+0x1f>
		return 0;
    1b62:	b8 00 00 00 00       	mov    eax,0x0
}
    1b67:	c9                   	leave
    1b68:	c3                   	ret

0000000000001b69 <wq_add>:

static inline void wq_add(struct wait_queue_head* wq_head, struct wait_queue* wq_tail)
{
    1b69:	55                   	push   rbp
    1b6a:	48 89 e5             	mov    rbp,rsp
    1b6d:	48 83 ec 10          	sub    rsp,0x10
    1b71:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    1b75:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		spin_lock(&wq_head->lock);
    1b79:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1b7d:	48 83 c0 10          	add    rax,0x10
    1b81:	48 89 c7             	mov    rdi,rax
    1b84:	e8 00 00 00 00       	call   1b89 <wq_add+0x20>
		wq_head->prev->next = wq_tail;
    1b89:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1b8d:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1b90:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1b94:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		wq_tail->prev = wq_head->prev;
    1b98:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1b9c:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1b9f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1ba3:	48 89 10             	mov    QWORD PTR [rax],rdx
		wq_head->prev = wq_tail;
    1ba6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1baa:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1bae:	48 89 10             	mov    QWORD PTR [rax],rdx
		wq_tail->next = wq_head;
    1bb1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1bb5:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1bb9:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		spin_unlock(&wq_head->lock);
    1bbd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1bc1:	48 83 c0 10          	add    rax,0x10
    1bc5:	48 89 c7             	mov    rdi,rax
    1bc8:	e8 00 00 00 00       	call   1bcd <wq_add+0x64>
}
    1bcd:	90                   	nop
    1bce:	c9                   	leave
    1bcf:	c3                   	ret

0000000000001bd0 <wq_purge>:

static inline void wq_purge(struct wait_queue_head* wq, struct wait_queue* wq_e)
{
    1bd0:	55                   	push   rbp
    1bd1:	48 89 e5             	mov    rbp,rsp
    1bd4:	48 83 ec 20          	sub    rsp,0x20
    1bd8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1bdc:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		int flg;
		spin_lock_irqsave(&wq->lock, &flg);
    1be0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1be4:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1be8:	48 8d 45 f4          	lea    rax,[rbp-0xc]
    1bec:	48 89 c6             	mov    rsi,rax
    1bef:	48 89 d7             	mov    rdi,rdx
    1bf2:	e8 00 00 00 00       	call   1bf7 <wq_purge+0x27>
		if (wq->next != (struct wait_queue*)wq) {
    1bf7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1bfb:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1bff:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1c03:	74 53                	je     1c58 <wq_purge+0x88>
				struct wait_queue* wq_n = wq->next;
    1c05:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1c09:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1c0d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				do {
						if (wq_n == wq_e) {
    1c11:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1c15:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
    1c19:	75 27                	jne    1c42 <wq_purge+0x72>
								wq_n->prev->next = wq_n->next;
    1c1b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1c1f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1c22:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1c26:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    1c2a:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
								wq_n->next->prev = wq_n->prev;
    1c2e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1c32:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1c36:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1c3a:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    1c3d:	48 89 10             	mov    QWORD PTR [rax],rdx
								break;
    1c40:	eb 16                	jmp    1c58 <wq_purge+0x88>
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
    1c42:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1c46:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1c4a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1c4e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1c52:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
    1c56:	75 b9                	jne    1c11 <wq_purge+0x41>
		}
		spin_unlock_irqrestore(&wq->lock, flg);
    1c58:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1c5b:	48 98                	cdqe
    1c5d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1c61:	48 83 c2 10          	add    rdx,0x10
    1c65:	48 89 c6             	mov    rsi,rax
    1c68:	48 89 d7             	mov    rdi,rdx
    1c6b:	e8 00 00 00 00       	call   1c70 <wq_purge+0xa0>
}
    1c70:	90                   	nop
    1c71:	c9                   	leave
    1c72:	c3                   	ret

0000000000001c73 <wait_on_event>:

void wait_on_event(struct wait_queue_head* wq)
{
    1c73:	55                   	push   rbp
    1c74:	48 89 e5             	mov    rbp,rsp
    1c77:	48 83 ec 30          	sub    rsp,0x30
    1c7b:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct wait_queue my_q;
		if (__sync_bool_compare_and_swap(&wq->signaled, 1, 0))
    1c7f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c83:	48 8d 50 14          	lea    rdx,[rax+0x14]
    1c87:	b8 01 00 00 00       	mov    eax,0x1
    1c8c:	b9 00 00 00 00       	mov    ecx,0x0
    1c91:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    1c95:	0f 94 c0             	sete   al
    1c98:	84 c0                	test   al,al
    1c9a:	0f 85 96 00 00 00    	jne    1d36 <wait_on_event+0xc3>
				return; /* handle signalling */
		if (preempt_needs_init)
    1ca0:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1ca6 <wait_on_event+0x33>
    1ca6:	85 c0                	test   eax,eax
    1ca8:	0f 85 8b 00 00 00    	jne    1d39 <wait_on_event+0xc6>
				return;
		else if (preempt_count())
    1cae:	b8 00 00 00 00       	mov    eax,0x0
    1cb3:	e8 00 00 00 00       	call   1cb8 <wait_on_event+0x45>
    1cb8:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    1cbb:	85 c0                	test   eax,eax
    1cbd:	75 7d                	jne    1d3c <wait_on_event+0xc9>
				return;
		my_q.task = get_task();
    1cbf:	b8 00 00 00 00       	mov    eax,0x0
    1cc4:	e8 00 00 00 00       	call   1cc9 <wait_on_event+0x56>
    1cc9:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		my_q.timeout = 0;
    1ccd:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		wq_add(wq, &my_q);
    1cd5:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    1cd9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1cdd:	48 89 d6             	mov    rsi,rdx
    1ce0:	48 89 c7             	mov    rdi,rax
    1ce3:	e8 81 fe ff ff       	call   1b69 <wq_add>
		if (!__sync_bool_compare_and_swap(&wq->signaled, 1, 0)) { /* again */
    1ce8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1cec:	48 8d 50 14          	lea    rdx,[rax+0x14]
    1cf0:	b8 01 00 00 00       	mov    eax,0x1
    1cf5:	b9 00 00 00 00       	mov    ecx,0x0
    1cfa:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    1cfe:	0f 94 c0             	sete   al
    1d01:	83 f0 01             	xor    eax,0x1
    1d04:	84 c0                	test   al,al
    1d06:	74 19                	je     1d21 <wait_on_event+0xae>
				my_q.task->flags |= TIF_SLEEPING;
    1d08:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1d0c:	8b 10                	mov    edx,DWORD PTR [rax]
    1d0e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1d12:	80 ca 80             	or     dl,0x80
    1d15:	89 10                	mov    DWORD PTR [rax],edx
				task_yield();
    1d17:	b8 00 00 00 00       	mov    eax,0x0
    1d1c:	e8 00 00 00 00       	call   1d21 <wait_on_event+0xae>
		}
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
    1d21:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    1d25:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d29:	48 89 d6             	mov    rsi,rdx
    1d2c:	48 89 c7             	mov    rdi,rax
    1d2f:	e8 9c fe ff ff       	call   1bd0 <wq_purge>
    1d34:	eb 07                	jmp    1d3d <wait_on_event+0xca>
				return; /* handle signalling */
    1d36:	90                   	nop
    1d37:	eb 04                	jmp    1d3d <wait_on_event+0xca>
				return;
    1d39:	90                   	nop
    1d3a:	eb 01                	jmp    1d3d <wait_on_event+0xca>
				return;
    1d3c:	90                   	nop
}
    1d3d:	c9                   	leave
    1d3e:	c3                   	ret

0000000000001d3f <wait_timeout>:

void wait_timeout(struct wait_queue_head* wq, uint32_t delta)
{
    1d3f:	55                   	push   rbp
    1d40:	48 89 e5             	mov    rbp,rsp
    1d43:	48 83 ec 30          	sub    rsp,0x30
    1d47:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1d4b:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
		struct wait_queue my_q;
		my_q.task = get_task();
    1d4e:	b8 00 00 00 00       	mov    eax,0x0
    1d53:	e8 00 00 00 00       	call   1d58 <wait_timeout+0x19>
    1d58:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		my_q.timeout = jiffies + delta;
    1d5c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1d63 <wait_timeout+0x24>
    1d63:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1d66:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    1d69:	48 01 d0             	add    rax,rdx
    1d6c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		wq_add(wq, &my_q);
    1d70:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    1d74:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d78:	48 89 d6             	mov    rsi,rdx
    1d7b:	48 89 c7             	mov    rdi,rax
    1d7e:	e8 e6 fd ff ff       	call   1b69 <wq_add>
		my_q.task->flags |= TIF_SLEEPING;
    1d83:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1d87:	8b 10                	mov    edx,DWORD PTR [rax]
    1d89:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1d8d:	80 ca 80             	or     dl,0x80
    1d90:	89 10                	mov    DWORD PTR [rax],edx
		task_yield();
    1d92:	b8 00 00 00 00       	mov    eax,0x0
    1d97:	e8 00 00 00 00       	call   1d9c <wait_timeout+0x5d>
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
    1d9c:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    1da0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1da4:	48 89 d6             	mov    rsi,rdx
    1da7:	48 89 c7             	mov    rdi,rax
    1daa:	e8 21 fe ff ff       	call   1bd0 <wq_purge>
}
    1daf:	90                   	nop
    1db0:	c9                   	leave
    1db1:	c3                   	ret

0000000000001db2 <wake_task>:

int wake_task(struct tsi* t)
{
    1db2:	55                   	push   rbp
    1db3:	48 89 e5             	mov    rbp,rsp
    1db6:	48 83 ec 20          	sub    rsp,0x20
    1dba:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1dbe:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		if (!t)
    1dc5:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    1dca:	75 18                	jne    1de4 <wake_task+0x32>
				cprintf(KFMT_WARN, "Empty queue entry in wait queue\n");
    1dcc:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1dd3:	bf 0e 00 00 00       	mov    edi,0xe
    1dd8:	b8 00 00 00 00       	mov    eax,0x0
    1ddd:	e8 00 00 00 00       	call   1de2 <wake_task+0x30>
    1de2:	eb 43                	jmp    1e27 <wake_task+0x75>
		else { /* TODO: maybe check if really sleeping */
				t->flags &= ~TIF_SLEEPING;
    1de4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1de8:	8b 00                	mov    eax,DWORD PTR [rax]
    1dea:	24 7f                	and    al,0x7f
    1dec:	89 c2                	mov    edx,eax
    1dee:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1df2:	89 10                	mov    DWORD PTR [rax],edx
				pq_enqueue((t->flags & TIF_EXPIRED) ?
    1df4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1df8:	8b 00                	mov    eax,DWORD PTR [rax]
    1dfa:	83 e0 20             	and    eax,0x20
    1dfd:	85 c0                	test   eax,eax
    1dff:	74 09                	je     1e0a <wake_task+0x58>
    1e01:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e08 <wake_task+0x56>
    1e08:	eb 07                	jmp    1e11 <wake_task+0x5f>
    1e0a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e11 <wake_task+0x5f>
    1e11:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1e15:	48 89 d6             	mov    rsi,rdx
    1e18:	48 89 c7             	mov    rdi,rax
    1e1b:	e8 00 00 00 00       	call   1e20 <wake_task+0x6e>
						expired_queue : run_queue, t);
				rv = 1;
    1e20:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
		}
		return rv;
    1e27:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1e2a:	c9                   	leave
    1e2b:	c3                   	ret

0000000000001e2c <wake_up>:

/* called by the scheduler holding pq_lock */
int wake_up(struct wait_queue_head* wq)
{
    1e2c:	55                   	push   rbp
    1e2d:	48 89 e5             	mov    rbp,rsp
    1e30:	48 83 ec 20          	sub    rsp,0x20
    1e34:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1e38:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		spin_lock(&wq->lock);
    1e3f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e43:	48 83 c0 10          	add    rax,0x10
    1e47:	48 89 c7             	mov    rdi,rax
    1e4a:	e8 00 00 00 00       	call   1e4f <wake_up+0x23>
		if (wq->next != (struct wait_queue*)wq) {
    1e4f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e53:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1e57:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1e5b:	74 44                	je     1ea1 <wake_up+0x75>
				struct wait_queue* wq_n = wq->next;
    1e5d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e61:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1e65:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
    1e69:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1e6d:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1e70:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1e74:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    1e78:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				wq_n->next->prev = wq_n->prev;
    1e7c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1e80:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1e84:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1e88:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    1e8b:	48 89 10             	mov    QWORD PTR [rax],rdx
				rv = wake_task(wq_n->task);
    1e8e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1e92:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1e96:	48 89 c7             	mov    rdi,rax
    1e99:	e8 00 00 00 00       	call   1e9e <wake_up+0x72>
    1e9e:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		}
		spin_unlock(&wq->lock);
    1ea1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ea5:	48 83 c0 10          	add    rax,0x10
    1ea9:	48 89 c7             	mov    rdi,rax
    1eac:	e8 00 00 00 00       	call   1eb1 <wake_up+0x85>
		return rv;
    1eb1:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1eb4:	c9                   	leave
    1eb5:	c3                   	ret

0000000000001eb6 <wake_up_all>:

int wake_up_all(struct wait_queue* wq)
{
    1eb6:	55                   	push   rbp
    1eb7:	48 89 e5             	mov    rbp,rsp
    1eba:	48 83 ec 20          	sub    rsp,0x20
    1ebe:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1ec2:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		while (wake_up(wq))
    1ec9:	eb 04                	jmp    1ecf <wake_up_all+0x19>
				rv++;
    1ecb:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
		while (wake_up(wq))
    1ecf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ed3:	48 89 c7             	mov    rdi,rax
    1ed6:	e8 00 00 00 00       	call   1edb <wake_up_all+0x25>
    1edb:	85 c0                	test   eax,eax
    1edd:	75 ec                	jne    1ecb <wake_up_all+0x15>
		return rv;
    1edf:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1ee2:	c9                   	leave
    1ee3:	c3                   	ret

0000000000001ee4 <wake_up_external_event>:

int wake_up_external_event(struct wait_queue_head* wq)
{
    1ee4:	55                   	push   rbp
    1ee5:	48 89 e5             	mov    rbp,rsp
    1ee8:	48 83 ec 20          	sub    rsp,0x20
    1eec:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1ef0:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		spin_lock(&wq->lock);
    1ef7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1efb:	48 83 c0 10          	add    rax,0x10
    1eff:	48 89 c7             	mov    rdi,rax
    1f02:	e8 00 00 00 00       	call   1f07 <wake_up_external_event+0x23>
		if (wq->next != (struct wait_queue*)wq) {
    1f07:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f0b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1f0f:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1f13:	74 6a                	je     1f7f <wake_up_external_event+0x9b>
				struct wait_queue* wq_n = wq->next;
    1f15:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f19:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1f1d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
    1f21:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f25:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1f28:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1f2c:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    1f30:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				wq_n->next->prev = wq_n->prev;
    1f34:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f38:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1f3c:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1f40:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    1f43:	48 89 10             	mov    QWORD PTR [rax],rdx
				wq_n->timeout = jiffies;
    1f46:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f4d <wake_up_external_event+0x69>
    1f4d:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1f50:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f54:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
				/* abuse the timer queue */
				wq_add(&wq_timer, wq_n);
    1f58:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f5c:	48 89 c6             	mov    rsi,rax
    1f5f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1f66:	e8 fe fb ff ff       	call   1b69 <wq_add>
				rv = 1;
    1f6b:	c7 45 fc 01 00 00 00 	mov    DWORD PTR [rbp-0x4],0x1
				wq->signaled = 0;
    1f72:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f76:	c7 40 14 00 00 00 00 	mov    DWORD PTR [rax+0x14],0x0
    1f7d:	eb 0b                	jmp    1f8a <wake_up_external_event+0xa6>
		} else { /* empty -> prevent waiting forever */
				wq->signaled = 1;
    1f7f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f83:	c7 40 14 01 00 00 00 	mov    DWORD PTR [rax+0x14],0x1
		}
		spin_unlock(&wq->lock);
    1f8a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f8e:	48 83 c0 10          	add    rax,0x10
    1f92:	48 89 c7             	mov    rdi,rax
    1f95:	e8 00 00 00 00       	call   1f9a <wake_up_external_event+0xb6>
		return rv;
    1f9a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1f9d:	c9                   	leave
    1f9e:	c3                   	ret

0000000000001f9f <wake_up_all_external_event>:

int wake_up_all_external_event(struct wait_queue_head* wq)
{
    1f9f:	55                   	push   rbp
    1fa0:	48 89 e5             	mov    rbp,rsp
    1fa3:	48 83 ec 20          	sub    rsp,0x20
    1fa7:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1fab:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		while (wake_up_external_event(wq))
    1fb2:	eb 04                	jmp    1fb8 <wake_up_all_external_event+0x19>
				rv++;
    1fb4:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
		while (wake_up_external_event(wq))
    1fb8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fbc:	48 89 c7             	mov    rdi,rax
    1fbf:	e8 00 00 00 00       	call   1fc4 <wake_up_all_external_event+0x25>
    1fc4:	85 c0                	test   eax,eax
    1fc6:	75 ec                	jne    1fb4 <wake_up_all_external_event+0x15>
		if (rv) /* a bit iffy */
    1fc8:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1fcc:	74 0b                	je     1fd9 <wake_up_all_external_event+0x3a>
				wq->signaled = 0;
    1fce:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fd2:	c7 40 14 00 00 00 00 	mov    DWORD PTR [rax+0x14],0x0
		return rv;
    1fd9:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1fdc:	c9                   	leave
    1fdd:	c3                   	ret

0000000000001fde <wake_up_timer>:

int wake_up_timer(struct wait_queue_head* wq)
{
    1fde:	55                   	push   rbp
    1fdf:	48 89 e5             	mov    rbp,rsp
    1fe2:	48 83 ec 20          	sub    rsp,0x20
    1fe6:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    1fea:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		spin_lock(&wq->lock);
    1ff1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ff5:	48 83 c0 10          	add    rax,0x10
    1ff9:	48 89 c7             	mov    rdi,rax
    1ffc:	e8 00 00 00 00       	call   2001 <wake_up_timer+0x23>
		if (wq->next != (struct wait_queue*)wq) {
    2001:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2005:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2009:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    200d:	74 7a                	je     2089 <wake_up_timer+0xab>
				struct wait_queue* wq_n = wq->next;
    200f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2013:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2017:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				do {
						if (wq_n->timeout <= jiffies) {
    201b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    201f:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2023:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 202a <wake_up_timer+0x4c>
    202a:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    202d:	48 39 c2             	cmp    rdx,rax
    2030:	72 3e                	jb     2070 <wake_up_timer+0x92>
								wq_n->prev->next = wq_n->next;
    2032:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2036:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2039:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    203d:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    2041:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
								wq_n->next->prev = wq_n->prev;
    2045:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2049:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    204d:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    2051:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    2054:	48 89 10             	mov    QWORD PTR [rax],rdx
								rv = wake_task(wq_n->task);
    2057:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    205b:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    205f:	48 89 c7             	mov    rdi,rax
    2062:	e8 00 00 00 00       	call   2067 <wake_up_timer+0x89>
    2067:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
								if (rv)
    206a:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    206e:	75 18                	jne    2088 <wake_up_timer+0xaa>
										break;
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
    2070:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2074:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2078:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    207c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2080:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
    2084:	75 95                	jne    201b <wake_up_timer+0x3d>
    2086:	eb 01                	jmp    2089 <wake_up_timer+0xab>
										break;
    2088:	90                   	nop
		}
		spin_unlock(&wq->lock);
    2089:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    208d:	48 83 c0 10          	add    rax,0x10
    2091:	48 89 c7             	mov    rdi,rax
    2094:	e8 00 00 00 00       	call   2099 <wake_up_timer+0xbb>
		return rv;
    2099:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    209c:	c9                   	leave
    209d:	c3                   	ret

000000000000209e <wake_up_timer_all>:

int wake_up_timer_all(struct wait_queue_head* wq)
{
    209e:	55                   	push   rbp
    209f:	48 89 e5             	mov    rbp,rsp
    20a2:	48 83 ec 20          	sub    rsp,0x20
    20a6:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		int rv = 0;
    20aa:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		while (wake_up_timer(wq))
    20b1:	eb 04                	jmp    20b7 <wake_up_timer_all+0x19>
				rv++;
    20b3:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
		while (wake_up_timer(wq))
    20b7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    20bb:	48 89 c7             	mov    rdi,rax
    20be:	e8 00 00 00 00       	call   20c3 <wake_up_timer_all+0x25>
    20c3:	85 c0                	test   eax,eax
    20c5:	75 ec                	jne    20b3 <wake_up_timer_all+0x15>
		return rv;
    20c7:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    20ca:	c9                   	leave
    20cb:	c3                   	ret

00000000000020cc <kidle>:

void kidle(void* data)
{
    20cc:	55                   	push   rbp
    20cd:	48 89 e5             	mov    rbp,rsp
    20d0:	48 83 ec 10          	sub    rsp,0x10
    20d4:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		get_task()->flags |= TIF_IDLE;
    20d8:	b8 00 00 00 00       	mov    eax,0x0
    20dd:	e8 00 00 00 00       	call   20e2 <kidle+0x16>
    20e2:	8b 10                	mov    edx,DWORD PTR [rax]
    20e4:	83 ca 40             	or     edx,0x40
    20e7:	89 10                	mov    DWORD PTR [rax],edx
		while (1) {
				wait_on_event(&wq_idle);
    20e9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    20f0:	e8 00 00 00 00       	call   20f5 <kidle+0x29>
				asm("hlt");
    20f5:	f4                   	hlt
				wait_on_event(&wq_idle);
    20f6:	90                   	nop
    20f7:	eb f0                	jmp    20e9 <kidle+0x1d>

00000000000020f9 <task_schedule>:
size_t ri_ofs = 0;

/* called from everyone else (using cli before). The stack is the
 * stack of the current task. */
void task_schedule(struct tsi* prev_task)
{
    20f9:	55                   	push   rbp
    20fa:	48 89 e5             	mov    rbp,rsp
    20fd:	53                   	push   rbx
    20fe:	48 83 ec 68          	sub    rsp,0x68
    2102:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
		if (preempt_needs_init) /* returns to the task_state on the stack */
    2106:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 210c <task_schedule+0x13>
    210c:	85 c0                	test   eax,eax
    210e:	0f 85 3f 07 00 00    	jne    2853 <task_schedule+0x75a>
				return;    /* of the irq0 handler, i.e. where execution stopped. */

		struct tsi* t;
		/* calculate the runtime of prev_task and go back if no preemption */
		if (prev_task) {
    2114:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    2119:	0f 84 a9 00 00 00    	je     21c8 <task_schedule+0xcf>
				/* happens on same proc */
				uint64_t rt = get_runtime(prev_task);
    211f:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2123:	48 89 c7             	mov    rdi,rax
    2126:	e8 00 00 00 00       	call   212b <task_schedule+0x32>
    212b:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				prev_task->ns_run = rt; // <- could be used for nice values
    212f:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2133:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    2137:	48 89 50 60          	mov    QWORD PTR [rax+0x60],rdx
				prev_task->ns_acc += rt;
    213b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    213f:	48 8b 50 68          	mov    rdx,QWORD PTR [rax+0x68]
    2143:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2147:	48 01 c2             	add    rdx,rax
    214a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    214e:	48 89 50 68          	mov    QWORD PTR [rax+0x68],rdx
				proc_add_time(rt, prev_task->flags);
    2152:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2156:	8b 10                	mov    edx,DWORD PTR [rax]
    2158:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    215c:	89 d6                	mov    esi,edx
    215e:	48 89 c7             	mov    rdi,rax
    2161:	e8 00 00 00 00       	call   2166 <task_schedule+0x6d>
				/* go back but signify TIF_NEED_RESCHED */
				if (prev_task->preempt_count) {
    2166:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    216a:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    216d:	85 c0                	test   eax,eax
    216f:	74 39                	je     21aa <task_schedule+0xb1>
						prev_task->flags |= TIF_NEED_RESCHED;
    2171:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2175:	8b 00                	mov    eax,DWORD PTR [rax]
    2177:	83 c8 01             	or     eax,0x1
    217a:	89 c2                	mov    edx,eax
    217c:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2180:	89 10                	mov    DWORD PTR [rax],edx
						prev_task->start_time = task_gettime();
    2182:	b8 00 00 00 00       	mov    eax,0x0
    2187:	e8 00 00 00 00       	call   218c <task_schedule+0x93>
    218c:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    2190:	48 89 42 48          	mov    QWORD PTR [rdx+0x48],rax
						prev_task->quota--; /* go into negative values */
    2194:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2198:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    219b:	8d 50 ff             	lea    edx,[rax-0x1]
    219e:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    21a2:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
						return;
    21a5:	e9 aa 06 00 00       	jmp    2854 <task_schedule+0x75b>
				} else if (prev_task->flags & TIF_NEED_RESCHED) /* clear the flag */
    21aa:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    21ae:	8b 00                	mov    eax,DWORD PTR [rax]
    21b0:	83 e0 01             	and    eax,0x1
    21b3:	85 c0                	test   eax,eax
    21b5:	74 11                	je     21c8 <task_schedule+0xcf>
						prev_task->flags &= ~TIF_NEED_RESCHED;
    21b7:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    21bb:	8b 00                	mov    eax,DWORD PTR [rax]
    21bd:	83 e0 fe             	and    eax,0xfffffffe
    21c0:	89 c2                	mov    edx,eax
    21c2:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    21c6:	89 10                	mov    DWORD PTR [rax],edx
		}

		/* enter the queue lock (entails free reign over ts values) */
		spin_lock(&pq_lock);
    21c8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    21cf:	e8 00 00 00 00       	call   21d4 <task_schedule+0xdb>
		/* wake up once */
		wake_up_timer_all(&wq_timer);
    21d4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    21db:	e8 00 00 00 00       	call   21e0 <task_schedule+0xe7>
		/* check for reinsertion */
		for (size_t i = 0; i < ri_ofs; i++) {
    21e0:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    21e8:	e9 86 00 00 00       	jmp    2273 <task_schedule+0x17a>
				struct tsi* ti = ri_queue[i];
    21ed:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    21f1:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    21f9:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				if (ti->flags & TIF_RUNNING)
    21fd:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2201:	8b 00                	mov    eax,DWORD PTR [rax]
    2203:	83 e0 10             	and    eax,0x10
    2206:	85 c0                	test   eax,eax
    2208:	75 63                	jne    226d <task_schedule+0x174>
						continue;
				/* task is eligible */
				pq_enqueue((ti->flags & TIF_EXPIRED) ?
    220a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    220e:	8b 00                	mov    eax,DWORD PTR [rax]
    2210:	83 e0 20             	and    eax,0x20
    2213:	85 c0                	test   eax,eax
    2215:	74 09                	je     2220 <task_schedule+0x127>
    2217:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 221e <task_schedule+0x125>
    221e:	eb 07                	jmp    2227 <task_schedule+0x12e>
    2220:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2227 <task_schedule+0x12e>
    2227:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    222b:	48 89 d6             	mov    rsi,rdx
    222e:	48 89 c7             	mov    rdi,rax
    2231:	e8 00 00 00 00       	call   2236 <task_schedule+0x13d>
						expired_queue : run_queue, ti);
				/* shorten queue and redo current iteration */
				ri_queue[i--] = ri_queue[--ri_ofs];
    2236:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 223d <task_schedule+0x144>
    223d:	48 83 e8 01          	sub    rax,0x1
    2241:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2248 <task_schedule+0x14f>
    2248:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 224f <task_schedule+0x156>
    224f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2253:	48 8d 48 ff          	lea    rcx,[rax-0x1]
    2257:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
    225b:	48 8b 14 d5 00 00 00 00 	mov    rdx,QWORD PTR [rdx*8+0x0]
    2263:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
    226b:	eb 01                	jmp    226e <task_schedule+0x175>
						continue;
    226d:	90                   	nop
		for (size_t i = 0; i < ri_ofs; i++) {
    226e:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
    2273:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 227a <task_schedule+0x181>
    227a:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
    227e:	0f 82 69 ff ff ff    	jb     21ed <task_schedule+0xf4>
		}

Pos1:
    2284:	90                   	nop
    2285:	eb 04                	jmp    228b <task_schedule+0x192>
		}

		/* check for sleeping tasks and if so, forget the task
		 * (wake_up is responsible for reenqueueing) */
		if (t->flags & TIF_SLEEPING)
				goto Pos1;
    2287:	90                   	nop
    2288:	eb 01                	jmp    228b <task_schedule+0x192>
				if (t != prev_task) { /* except if we're the one holding it */
						ri_queue[ri_ofs++] = t;
						t->quota++;
						if (ri_ofs == RI_LIMIT)
								die("Use a larger reinsertion queue!\n");
						goto Pos1; /* don't schedule the same task on many procs */
    228a:	90                   	nop
		t = pq_dequeue(run_queue);
    228b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2292 <task_schedule+0x199>
    2292:	48 89 c7             	mov    rdi,rax
    2295:	e8 00 00 00 00       	call   229a <task_schedule+0x1a1>
    229a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!t) { /* major rotation */
    229e:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    22a3:	75 7a                	jne    231f <task_schedule+0x226>
				struct priority_queue* q = run_queue;
    22a5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 22ac <task_schedule+0x1b3>
    22ac:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				run_queue = expired_queue;
    22b0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 22b7 <task_schedule+0x1be>
    22b7:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 22be <task_schedule+0x1c5>
				expired_queue = q;
    22be:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    22c2:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 22c9 <task_schedule+0x1d0>
				for (size_t i = 0; i < n_tks; i++) /* unexpire them */
    22c9:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    22d1:	eb 24                	jmp    22f7 <task_schedule+0x1fe>
						tks[i]->flags &= ~TIF_EXPIRED;
    22d3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    22d7:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    22df:	8b 10                	mov    edx,DWORD PTR [rax]
    22e1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    22e5:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    22ed:	83 e2 df             	and    edx,0xffffffdf
    22f0:	89 10                	mov    DWORD PTR [rax],edx
				for (size_t i = 0; i < n_tks; i++) /* unexpire them */
    22f2:	48 83 45 d8 01       	add    QWORD PTR [rbp-0x28],0x1
    22f7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 22fe <task_schedule+0x205>
    22fe:	48 39 45 d8          	cmp    QWORD PTR [rbp-0x28],rax
    2302:	72 cf                	jb     22d3 <task_schedule+0x1da>
				STAT_INC_COUNTER(sched_mr_count, 1);
    2304:	f0 83 05 00 00 00 00 01 	lock add DWORD PTR [rip+0x0],0x1        # 230c <task_schedule+0x213>
				t = pq_dequeue(run_queue);
    230c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2313 <task_schedule+0x21a>
    2313:	48 89 c7             	mov    rdi,rax
    2316:	e8 00 00 00 00       	call   231b <task_schedule+0x222>
    231b:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!t) { /* nothing to do? --> wake idle process */
    231f:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2324:	75 3c                	jne    2362 <task_schedule+0x269>
				if (!prev_task || (prev_task->flags & TIF_SLEEPING)
    2326:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    232b:	74 1c                	je     2349 <task_schedule+0x250>
    232d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2331:	8b 00                	mov    eax,DWORD PTR [rax]
    2333:	25 80 00 00 00       	and    eax,0x80
    2338:	85 c0                	test   eax,eax
    233a:	75 0d                	jne    2349 <task_schedule+0x250>
							   || (prev_task->flags & TIF_YIELDED)) {
    233c:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2340:	8b 00                	mov    eax,DWORD PTR [rax]
    2342:	83 e0 02             	and    eax,0x2
    2345:	85 c0                	test   eax,eax
    2347:	74 11                	je     235a <task_schedule+0x261>
						wake_up(&wq_idle);
    2349:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2350:	e8 00 00 00 00       	call   2355 <task_schedule+0x25c>
						goto Pos1;
    2355:	e9 31 ff ff ff       	jmp    228b <task_schedule+0x192>
						t = prev_task;
    235a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    235e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (t->flags & TIF_DEALLOCATE && !(t->flags & TIF_RUNNING)) {
    2362:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2366:	8b 00                	mov    eax,DWORD PTR [rax]
    2368:	83 e0 04             	and    eax,0x4
    236b:	85 c0                	test   eax,eax
    236d:	74 1e                	je     238d <task_schedule+0x294>
    236f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2373:	8b 00                	mov    eax,DWORD PTR [rax]
    2375:	83 e0 10             	and    eax,0x10
    2378:	85 c0                	test   eax,eax
    237a:	75 11                	jne    238d <task_schedule+0x294>
				task_deallocate(t);
    237c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2380:	48 89 c7             	mov    rdi,rax
    2383:	e8 00 00 00 00       	call   2388 <task_schedule+0x28f>
				goto Pos1;
    2388:	e9 fe fe ff ff       	jmp    228b <task_schedule+0x192>
		if (t->flags & TIF_SLEEPING)
    238d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2391:	8b 00                	mov    eax,DWORD PTR [rax]
    2393:	25 80 00 00 00       	and    eax,0x80
    2398:	85 c0                	test   eax,eax
    239a:	0f 85 e7 fe ff ff    	jne    2287 <task_schedule+0x18e>
		if (--t->quota <= 0) {
    23a0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23a4:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    23a7:	8d 50 ff             	lea    edx,[rax-0x1]
    23aa:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23ae:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
    23b1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23b5:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    23b8:	85 c0                	test   eax,eax
    23ba:	7f 78                	jg     2434 <task_schedule+0x33b>
				t->quota += 10;
    23bc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23c0:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    23c3:	8d 50 0a             	lea    edx,[rax+0xa]
    23c6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23ca:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
				t->flags &= ~TIF_YIELDED;
    23cd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23d1:	8b 00                	mov    eax,DWORD PTR [rax]
    23d3:	83 e0 fd             	and    eax,0xfffffffd
    23d6:	89 c2                	mov    edx,eax
    23d8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23dc:	89 10                	mov    DWORD PTR [rax],edx
				if (t->cur_priority != PRIORITY_MIN) {
    23de:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23e2:	8b 40 44             	mov    eax,DWORD PTR [rax+0x44]
    23e5:	83 f8 03             	cmp    eax,0x3
    23e8:	74 1f                	je     2409 <task_schedule+0x310>
						t->cur_priority++;
    23ea:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23ee:	8b 40 44             	mov    eax,DWORD PTR [rax+0x44]
    23f1:	8d 50 01             	lea    edx,[rax+0x1]
    23f4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23f8:	89 50 44             	mov    DWORD PTR [rax+0x44],edx
						STAT_INC_COUNTER(t->task_mr_bumps, 1);
    23fb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    23ff:	48 83 c0 7c          	add    rax,0x7c
    2403:	f0 83 00 01          	lock add DWORD PTR [rax],0x1
    2407:	eb 2b                	jmp    2434 <task_schedule+0x33b>
						t->flags |= TIF_EXPIRED;
    2409:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    240d:	8b 00                	mov    eax,DWORD PTR [rax]
    240f:	83 c8 20             	or     eax,0x20
    2412:	89 c2                	mov    edx,eax
    2414:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2418:	89 10                	mov    DWORD PTR [rax],edx
						t->cur_priority = t->priority;
    241a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    241e:	8b 50 3c             	mov    edx,DWORD PTR [rax+0x3c]
    2421:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2425:	89 50 44             	mov    DWORD PTR [rax+0x44],edx
						STAT_INC_COUNTER(t->task_mr_expires, 1);
    2428:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    242c:	48 83 e8 80          	sub    rax,0xffffffffffffff80
    2430:	f0 83 00 01          	lock add DWORD PTR [rax],0x1
		if (__sync_fetch_and_or(&t->flags, TIF_RUNNING) & TIF_RUNNING) {
    2434:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2438:	8b 02                	mov    eax,DWORD PTR [rdx]
    243a:	89 c6                	mov    esi,eax
    243c:	89 c1                	mov    ecx,eax
    243e:	83 c9 10             	or     ecx,0x10
    2441:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [rdx],ecx
    2445:	0f 94 c1             	sete   cl
    2448:	84 c9                	test   cl,cl
    244a:	74 ee                	je     243a <task_schedule+0x341>
    244c:	89 f0                	mov    eax,esi
    244e:	83 e0 10             	and    eax,0x10
    2451:	85 c0                	test   eax,eax
    2453:	74 7a                	je     24cf <task_schedule+0x3d6>
				if (t != prev_task) { /* except if we're the one holding it */
    2455:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2459:	48 3b 45 98          	cmp    rax,QWORD PTR [rbp-0x68]
    245d:	74 70                	je     24cf <task_schedule+0x3d6>
						ri_queue[ri_ofs++] = t;
    245f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2466 <task_schedule+0x36d>
    2466:	48 8d 50 01          	lea    rdx,[rax+0x1]
    246a:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 2471 <task_schedule+0x378>
    2471:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2475:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						t->quota++;
    247d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2481:	8b 40 40             	mov    eax,DWORD PTR [rax+0x40]
    2484:	8d 50 01             	lea    edx,[rax+0x1]
    2487:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    248b:	89 50 40             	mov    DWORD PTR [rax+0x40],edx
						if (ri_ofs == RI_LIMIT)
    248e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2495 <task_schedule+0x39c>
    2495:	48 83 f8 20          	cmp    rax,0x20
    2499:	0f 85 eb fd ff ff    	jne    228a <task_schedule+0x191>
								die("Use a larger reinsertion queue!\n");
    249f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    24a6:	bf 0c 00 00 00       	mov    edi,0xc
    24ab:	b8 00 00 00 00       	mov    eax,0x0
    24b0:	e8 00 00 00 00       	call   24b5 <task_schedule+0x3bc>
    24b5:	b8 00 00 00 00       	mov    eax,0x0
    24ba:	e8 00 00 00 00       	call   24bf <task_schedule+0x3c6>
    24bf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    24c6:	e8 00 00 00 00       	call   24cb <task_schedule+0x3d2>
    24cb:	fa                   	cli
    24cc:	f4                   	hlt
    24cd:	eb fd                	jmp    24cc <task_schedule+0x3d3>
				}
		}
		barrier();
		t->run_time++; /* accounting */
    24cf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    24d3:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    24d6:	8d 50 01             	lea    edx,[rax+0x1]
    24d9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    24dd:	89 50 38             	mov    DWORD PTR [rax+0x38],edx

		/* now jump into task */
		t->start_time = task_gettime();
    24e0:	b8 00 00 00 00       	mov    eax,0x0
    24e5:	e8 00 00 00 00       	call   24ea <task_schedule+0x3f1>
    24ea:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    24ee:	48 89 42 48          	mov    QWORD PTR [rdx+0x48],rax
		/* DEBUG check! */
		{
				struct stack_limits sl;
				if (get_stack(stack_ptr(t), &sl) == -1) {
    24f2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    24f6:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    24fa:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    24fe:	48 89 c2             	mov    rdx,rax
    2501:	48 8d 45 a0          	lea    rax,[rbp-0x60]
    2505:	48 89 c6             	mov    rsi,rax
    2508:	48 89 d7             	mov    rdi,rdx
    250b:	e8 00 00 00 00       	call   2510 <task_schedule+0x417>
    2510:	83 f8 ff             	cmp    eax,0xffffffff
    2513:	75 6a                	jne    257f <task_schedule+0x486>
						die("invalid task struct at %p (esp=%p)\nt%sprev_task\n",
    2515:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2519:	48 3b 45 98          	cmp    rax,QWORD PTR [rbp-0x68]
    251d:	75 09                	jne    2528 <task_schedule+0x42f>
    251f:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2526:	eb 07                	jmp    252f <task_schedule+0x436>
    2528:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    252f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2533:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2537:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    253b:	48 89 c2             	mov    rdx,rax
    253e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2542:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2546:	49 89 c8             	mov    r8,rcx
    2549:	48 89 d1             	mov    rcx,rdx
    254c:	48 89 c2             	mov    rdx,rax
    254f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2556:	bf 0c 00 00 00       	mov    edi,0xc
    255b:	b8 00 00 00 00       	mov    eax,0x0
    2560:	e8 00 00 00 00       	call   2565 <task_schedule+0x46c>
    2565:	b8 00 00 00 00       	mov    eax,0x0
    256a:	e8 00 00 00 00       	call   256f <task_schedule+0x476>
    256f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2576:	e8 00 00 00 00       	call   257b <task_schedule+0x482>
    257b:	fa                   	cli
    257c:	f4                   	hlt
    257d:	eb fd                	jmp    257c <task_schedule+0x483>
								t->ts, stack_ptr(t), (t == prev_task) ? "==" : "!=");
				} else if (stack_ptr(t) < 0x7c00) {
    257f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2583:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2587:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    258b:	48 3d ff 7b 00 00    	cmp    rax,0x7bff
    2591:	77 3b                	ja     25ce <task_schedule+0x4d5>
						die("eip below 0x7c00 for task struct at %p\n", t->ts);
    2593:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2597:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    259b:	48 89 c2             	mov    rdx,rax
    259e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    25a5:	bf 0c 00 00 00       	mov    edi,0xc
    25aa:	b8 00 00 00 00       	mov    eax,0x0
    25af:	e8 00 00 00 00       	call   25b4 <task_schedule+0x4bb>
    25b4:	b8 00 00 00 00       	mov    eax,0x0
    25b9:	e8 00 00 00 00       	call   25be <task_schedule+0x4c5>
    25be:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25c5:	e8 00 00 00 00       	call   25ca <task_schedule+0x4d1>
    25ca:	fa                   	cli
    25cb:	f4                   	hlt
    25cc:	eb fd                	jmp    25cb <task_schedule+0x4d2>
				} else if (t->stack_base < stack_ptr(t) || t->stack_limit > stack_ptr(t)) {
    25ce:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    25d2:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    25d6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    25da:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    25de:	48 8b 40 78          	mov    rax,QWORD PTR [rax+0x78]
    25e2:	48 39 c2             	cmp    rdx,rax
    25e5:	72 19                	jb     2600 <task_schedule+0x507>
    25e7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    25eb:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    25ef:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    25f3:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
    25f7:	48 8b 52 78          	mov    rdx,QWORD PTR [rdx+0x78]
    25fb:	48 39 c2             	cmp    rdx,rax
    25fe:	73 30                	jae    2630 <task_schedule+0x537>
						die("jumping into wrong stack!\n");
    2600:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2607:	bf 0c 00 00 00       	mov    edi,0xc
    260c:	b8 00 00 00 00       	mov    eax,0x0
    2611:	e8 00 00 00 00       	call   2616 <task_schedule+0x51d>
    2616:	b8 00 00 00 00       	mov    eax,0x0
    261b:	e8 00 00 00 00       	call   2620 <task_schedule+0x527>
    2620:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2627:	e8 00 00 00 00       	call   262c <task_schedule+0x533>
    262c:	fa                   	cli
    262d:	f4                   	hlt
    262e:	eb fd                	jmp    262d <task_schedule+0x534>
				} else if (!t->ts)
    2630:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2634:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2638:	48 85 c0             	test   rax,rax
    263b:	75 30                	jne    266d <task_schedule+0x574>
						die("jumping into null!\n");
    263d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2644:	bf 0c 00 00 00       	mov    edi,0xc
    2649:	b8 00 00 00 00       	mov    eax,0x0
    264e:	e8 00 00 00 00       	call   2653 <task_schedule+0x55a>
    2653:	b8 00 00 00 00       	mov    eax,0x0
    2658:	e8 00 00 00 00       	call   265d <task_schedule+0x564>
    265d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2664:	e8 00 00 00 00       	call   2669 <task_schedule+0x570>
    2669:	fa                   	cli
    266a:	f4                   	hlt
    266b:	eb fd                	jmp    266a <task_schedule+0x571>
				//check_tasks();
				if (pr_lst) { /* ringbuffer */
    266d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2674 <task_schedule+0x57b>
    2674:	48 85 c0             	test   rax,rax
    2677:	0f 84 0c 01 00 00    	je     2789 <task_schedule+0x690>
						size_t idx;
get_idx:
    267d:	90                   	nop
						idx = __sync_fetch_and_add(&pr_idx, 1);
    267e:	b8 01 00 00 00       	mov    eax,0x1
    2683:	f0 48 0f c1 05 00 00 00 00 	lock xadd QWORD PTR [rip+0x0],rax        # 268c <task_schedule+0x593>
    268c:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						if (idx > 127) {
    2690:	48 83 7d d0 7f       	cmp    QWORD PTR [rbp-0x30],0x7f
    2695:	76 25                	jbe    26bc <task_schedule+0x5c3>
								if (__sync_bool_compare_and_swap(&pr_idx, idx + 1, 0))
    2697:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    269b:	48 83 c0 01          	add    rax,0x1
    269f:	ba 00 00 00 00       	mov    edx,0x0
    26a4:	f0 48 0f b1 15 00 00 00 00 	lock cmpxchg QWORD PTR [rip+0x0],rdx        # 26ad <task_schedule+0x5b4>
    26ad:	0f 94 c0             	sete   al
    26b0:	84 c0                	test   al,al
    26b2:	74 ca                	je     267e <task_schedule+0x585>
										idx = 0;
    26b4:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
								else
										goto get_idx;
						}
						if (nproc > 1)
    26bc:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 26c2 <task_schedule+0x5c9>
    26c2:	83 f8 01             	cmp    eax,0x1
    26c5:	76 23                	jbe    26ea <task_schedule+0x5f1>
								pr_lst[idx].proc = per_cpu_ptr()->apic_id;
    26c7:	b8 00 00 00 00       	mov    eax,0x0
    26cc:	e8 2f d9 ff ff       	call   0 <per_cpu_ptr>
    26d1:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 26d8 <task_schedule+0x5df>
    26d8:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    26dc:	48 c1 e1 05          	shl    rcx,0x5
    26e0:	48 01 ca             	add    rdx,rcx
    26e3:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    26e6:	89 02                	mov    DWORD PTR [rdx],eax
    26e8:	eb 18                	jmp    2702 <task_schedule+0x609>
						else
								pr_lst[idx].proc = 0;
    26ea:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 26f1 <task_schedule+0x5f8>
    26f1:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    26f5:	48 c1 e2 05          	shl    rdx,0x5
    26f9:	48 01 d0             	add    rax,rdx
    26fc:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
						pr_lst[idx].task_name = t->name;
    2702:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2709 <task_schedule+0x610>
    2709:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    270d:	48 c1 e2 05          	shl    rdx,0x5
    2711:	48 01 c2             	add    rdx,rax
    2714:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2718:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    271c:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
						pr_lst[idx].task_id = t->task_id;
    2720:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2727 <task_schedule+0x62e>
    2727:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    272b:	48 c1 e2 05          	shl    rdx,0x5
    272f:	48 01 c2             	add    rdx,rax
    2732:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2736:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2739:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
						pr_lst[idx].eip = instr_ptr(t);
    273c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2740:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2744:	48 8b 88 a0 00 00 00 	mov    rcx,QWORD PTR [rax+0xa0]
    274b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2752 <task_schedule+0x659>
    2752:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2756:	48 c1 e2 05          	shl    rdx,0x5
    275a:	48 01 d0             	add    rax,rdx
    275d:	48 89 ca             	mov    rdx,rcx
    2760:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
						pr_lst[idx].esp = stack_ptr(t);
    2764:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2768:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    276c:	48 8b 48 78          	mov    rcx,QWORD PTR [rax+0x78]
    2770:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2777 <task_schedule+0x67e>
    2777:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    277b:	48 c1 e2 05          	shl    rdx,0x5
    277f:	48 01 d0             	add    rax,rdx
    2782:	48 89 ca             	mov    rdx,rcx
    2785:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
				}
		}
		/* document the processor */
		if (nproc > 1)
    2789:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 278f <task_schedule+0x696>
    278f:	83 f8 01             	cmp    eax,0x1
    2792:	76 13                	jbe    27a7 <task_schedule+0x6ae>
				t->task_proc = smp_processor_id();
    2794:	b8 00 00 00 00       	mov    eax,0x0
    2799:	e8 62 d8 ff ff       	call   0 <per_cpu_ptr>
    279e:	8b 10                	mov    edx,DWORD PTR [rax]
    27a0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    27a4:	89 50 58             	mov    DWORD PTR [rax+0x58],edx
		/* reinsert the previous task (if we don't do so next time) */
		if (prev_task && (t != prev_task)) {
    27a7:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    27ac:	74 65                	je     2813 <task_schedule+0x71a>
    27ae:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    27b2:	48 3b 45 98          	cmp    rax,QWORD PTR [rbp-0x68]
    27b6:	74 5b                	je     2813 <task_schedule+0x71a>
				ri_queue[ri_ofs++] = prev_task;
    27b8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 27bf <task_schedule+0x6c6>
    27bf:	48 8d 50 01          	lea    rdx,[rax+0x1]
    27c3:	48 89 15 00 00 00 00 	mov    QWORD PTR [rip+0x0],rdx        # 27ca <task_schedule+0x6d1>
    27ca:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    27ce:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
				if (ri_ofs == RI_LIMIT)
    27d6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 27dd <task_schedule+0x6e4>
    27dd:	48 83 f8 20          	cmp    rax,0x20
    27e1:	75 30                	jne    2813 <task_schedule+0x71a>
						die("Use a larger reinsertion queue!\n");
    27e3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    27ea:	bf 0c 00 00 00       	mov    edi,0xc
    27ef:	b8 00 00 00 00       	mov    eax,0x0
    27f4:	e8 00 00 00 00       	call   27f9 <task_schedule+0x700>
    27f9:	b8 00 00 00 00       	mov    eax,0x0
    27fe:	e8 00 00 00 00       	call   2803 <task_schedule+0x70a>
    2803:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    280a:	e8 00 00 00 00       	call   280f <task_schedule+0x716>
    280f:	fa                   	cli
    2810:	f4                   	hlt
    2811:	eb fd                	jmp    2810 <task_schedule+0x717>
		}
		spin_unlock(&pq_lock);
    2813:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    281a:	e8 00 00 00 00       	call   281f <task_schedule+0x726>

		/* release stack */
		{ /* only rely on registers */
				register void* ctx = t->ts;
    281f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2823:	48 8b 58 08          	mov    rbx,QWORD PTR [rax+0x8]
				if (prev_task && (t != prev_task))
    2827:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    282c:	74 1b                	je     2849 <task_schedule+0x750>
    282e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2832:	48 3b 45 98          	cmp    rax,QWORD PTR [rbp-0x68]
    2836:	74 11                	je     2849 <task_schedule+0x750>
						prev_task->flags &= ~TIF_RUNNING;
    2838:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    283c:	8b 00                	mov    eax,DWORD PTR [rax]
    283e:	83 e0 ef             	and    eax,0xffffffef
    2841:	89 c2                	mov    edx,eax
    2843:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2847:	89 10                	mov    DWORD PTR [rax],edx
				longjmp(ctx);
    2849:	48 89 dc             	mov    rsp,rbx
    284c:	e9 00 00 00 00       	jmp    2851 <task_schedule+0x758>
    2851:	eb 01                	jmp    2854 <task_schedule+0x75b>
				return;    /* of the irq0 handler, i.e. where execution stopped. */
    2853:	90                   	nop
		}
}
    2854:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    2858:	c9                   	leave
    2859:	c3                   	ret

000000000000285a <task_schedule_isr>:

/* called from irq0/apic handler returning with iret via longjmp.
 * These handlers are gates, i.e. not-reentrant, ensuring that
 * they have always finished execution before the task switch. */
void task_schedule_isr(void* esp)
{
    285a:	55                   	push   rbp
    285b:	48 89 e5             	mov    rbp,rsp
    285e:	48 83 ec 20          	sub    rsp,0x20
    2862:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct tsi* t = get_task_esp(esp);
    2866:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    286a:	48 89 c7             	mov    rdi,rax
    286d:	e8 00 00 00 00       	call   2872 <task_schedule_isr+0x18>
    2872:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		task_schedule(t);
    2876:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    287a:	48 89 c7             	mov    rdi,rax
    287d:	e8 00 00 00 00       	call   2882 <task_schedule_isr+0x28>
}
    2882:	90                   	nop
    2883:	c9                   	leave
    2884:	c3                   	ret

0000000000002885 <task_yield>:

void task_yield()
{
    2885:	55                   	push   rbp
    2886:	48 89 e5             	mov    rbp,rsp
    2889:	48 83 ec 10          	sub    rsp,0x10
		struct tsi* t;
		if (preempt_needs_init)
    288d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2893 <task_yield+0xe>
    2893:	85 c0                	test   eax,eax
    2895:	0f 85 f8 00 00 00    	jne    2993 <task_yield+0x10e>
				return; /* shouldn't be called before preemption */
		t = get_task();
    289b:	b8 00 00 00 00       	mov    eax,0x0
    28a0:	e8 00 00 00 00       	call   28a5 <task_yield+0x20>
    28a5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (t->preempt_count) { /* don't yield nonpreemptable task */
    28a9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    28ad:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    28b0:	85 c0                	test   eax,eax
    28b2:	0f 85 de 00 00 00    	jne    2996 <task_yield+0x111>
exit:
				return;
		}
		if (if_enabled())
    28b8:	b8 00 00 00 00       	mov    eax,0x0
    28bd:	e8 59 d7 ff ff       	call   1b <if_enabled>
    28c2:	48 85 c0             	test   rax,rax
    28c5:	74 30                	je     28f7 <task_yield+0x72>
				die("yielding in interrupt!\n");
    28c7:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    28ce:	bf 0c 00 00 00       	mov    edi,0xc
    28d3:	b8 00 00 00 00       	mov    eax,0x0
    28d8:	e8 00 00 00 00       	call   28dd <task_yield+0x58>
    28dd:	b8 00 00 00 00       	mov    eax,0x0
    28e2:	e8 00 00 00 00       	call   28e7 <task_yield+0x62>
    28e7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28ee:	e8 00 00 00 00       	call   28f3 <task_yield+0x6e>
    28f3:	fa                   	cli
    28f4:	f4                   	hlt
    28f5:	eb fd                	jmp    28f4 <task_yield+0x6f>
		void* ptr = &&exit;
    28f7:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		asm volatile (
    28ff:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    2903:	fa                   	cli
    2904:	48 89 84 24 30 ff ff ff 	mov    QWORD PTR [rsp-0xd0],rax
    290c:	48 31 c0             	xor    rax,rax
    290f:	66 8c d0             	mov    ax,ss
    2912:	50                   	push   rax
    2913:	54                   	push   rsp
    2914:	9c                   	pushf
    2915:	81 0c 24 00 02 00 00 	or     DWORD PTR [rsp],0x200
    291c:	66 8c c8             	mov    ax,cs
    291f:	50                   	push   rax
    2920:	52                   	push   rdx
    2921:	48 8b 84 24 58 ff ff ff 	mov    rax,QWORD PTR [rsp-0xa8]
    2929:	50                   	push   rax
    292a:	51                   	push   rcx
    292b:	52                   	push   rdx
    292c:	53                   	push   rbx
    292d:	54                   	push   rsp
    292e:	55                   	push   rbp
    292f:	56                   	push   rsi
    2930:	57                   	push   rdi
    2931:	41 50                	push   r8
    2933:	41 51                	push   r9
    2935:	41 52                	push   r10
    2937:	41 53                	push   r11
    2939:	41 54                	push   r12
    293b:	41 55                	push   r13
    293d:	41 56                	push   r14
    293f:	41 57                	push   r15
    2941:	66 8c d8             	mov    ax,ds
    2944:	50                   	push   rax
    2945:	66 8c c0             	mov    ax,es
    2948:	50                   	push   rax
    2949:	66 8c e0             	mov    ax,fs
    294c:	50                   	push   rax
    294d:	66 8c e8             	mov    ax,gs
    2950:	50                   	push   rax
    2951:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
		: "=mr" (ptr) : "0" (ptr)
#ifdef __x86_64__
							 : "rax" /* we clobber rax */
#endif
							 );
		t->ts = ptr;
    2955:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2959:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    295d:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		t->flags |= TIF_YIELDED;
    2961:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2965:	8b 00                	mov    eax,DWORD PTR [rax]
    2967:	83 c8 02             	or     eax,0x2
    296a:	89 c2                	mov    edx,eax
    296c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2970:	89 10                	mov    DWORD PTR [rax],edx
		/* NOPE! */
		//t->flags &= ~TIF_RUNNING;
		t->stop_time = task_gettime();
    2972:	b8 00 00 00 00       	mov    eax,0x0
    2977:	e8 00 00 00 00       	call   297c <task_yield+0xf7>
    297c:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2980:	48 89 42 50          	mov    QWORD PTR [rdx+0x50],rax
		task_schedule(t);
    2984:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2988:	48 89 c7             	mov    rdi,rax
    298b:	e8 00 00 00 00       	call   2990 <task_yield+0x10b>
		goto exit;
    2990:	90                   	nop
				return;
    2991:	eb 03                	jmp    2996 <task_yield+0x111>
				return; /* shouldn't be called before preemption */
    2993:	90                   	nop
    2994:	eb 01                	jmp    2997 <task_yield+0x112>
				return;
    2996:	90                   	nop
}
    2997:	c9                   	leave
    2998:	c3                   	ret

0000000000002999 <preempt_init>:

/* this function makes the kernel preemptable and is freeing the
 * previous main kernel stack at 0x60000-0x80000 */
void preempt_init()
{
    2999:	55                   	push   rbp
    299a:	48 89 e5             	mov    rbp,rsp
		asm ("cli");
    299d:	fa                   	cli
		pr_lst = kmalloc(128 * sizeof(*pr_lst));
    299e:	bf 00 10 00 00       	mov    edi,0x1000
    29a3:	e8 00 00 00 00       	call   29a8 <preempt_init+0xf>
    29a8:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 29af <preempt_init+0x16>
		extern void kinit(void*);
		extern void kredraw(void*);
		extern void kscrub(void*);
		task_spawn(kinit, NULL, PRIORITY_MAX);
    29af:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    29b6:	ba 00 00 00 00       	mov    edx,0x0
    29bb:	be 00 00 00 00       	mov    esi,0x0
    29c0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29c7:	e8 00 00 00 00       	call   29cc <preempt_init+0x33>
		task_spawn(kredraw, NULL, PRIORITY_MAX);
    29cc:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    29d3:	ba 00 00 00 00       	mov    edx,0x0
    29d8:	be 00 00 00 00       	mov    esi,0x0
    29dd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29e4:	e8 00 00 00 00       	call   29e9 <preempt_init+0x50>
		task_spawn(kscrub, NULL, PRIORITY_MIN);
    29e9:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    29f0:	ba 03 00 00 00       	mov    edx,0x3
    29f5:	be 00 00 00 00       	mov    esi,0x0
    29fa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a01:	e8 00 00 00 00       	call   2a06 <preempt_init+0x6d>
		/* at least n+1 idle task are needed */
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2a06:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2a0d:	ba 03 00 00 00       	mov    edx,0x3
    2a12:	be 00 00 00 00       	mov    esi,0x0
    2a17:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a1e:	e8 00 00 00 00       	call   2a23 <preempt_init+0x8a>
		task_spawn(kidle, NULL, PRIORITY_MIN);
    2a23:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
    2a2a:	ba 03 00 00 00       	mov    edx,0x3
    2a2f:	be 00 00 00 00       	mov    esi,0x0
    2a34:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a3b:	e8 00 00 00 00       	call   2a40 <preempt_init+0xa7>
		preempt_needs_init = 0;
    2a40:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 2a4a <preempt_init+0xb1>
		task_schedule(NULL);
    2a4a:	bf 00 00 00 00       	mov    edi,0x0
    2a4f:	e8 00 00 00 00       	call   2a54 <preempt_init+0xbb>
}
    2a54:	90                   	nop
    2a55:	5d                   	pop    rbp
    2a56:	c3                   	ret
