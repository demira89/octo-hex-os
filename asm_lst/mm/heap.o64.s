
mm/heap.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <memcpy>:
void* kzalloc(size_t s)
{
		void* rv = kmalloc(s);
		if (!rv)
				return NULL;
		bzero(rv, s);
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
   4:	48 83 ec 28          	sub    rsp,0x28
   8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
   c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
  10:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		return rv;
  14:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
  18:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
}
  1c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
  20:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax

  24:	eb 1d                	jmp    43 <memcpy+0x43>
void kfree(void* ptr)
  26:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
  2a:	48 8d 42 01          	lea    rax,[rdx+0x1]
  2e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
  32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  36:	48 8d 48 01          	lea    rcx,[rax+0x1]
  3a:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
  3e:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
  41:	88 10                	mov    BYTE PTR [rax],dl

  43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
  47:	48 8d 50 ff          	lea    rdx,[rax-0x1]
  4b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
  4f:	48 85 c0             	test   rax,rax
  52:	75 d2                	jne    26 <memcpy+0x26>
{
  54:	90                   	nop
  55:	90                   	nop
  56:	c9                   	leave
  57:	c3                   	ret

0000000000000058 <init_kernel_heap>:
{
  58:	55                   	push   rbp
  59:	48 89 e5             	mov    rbp,rsp
  5c:	48 83 ec 10          	sub    rsp,0x10
		size_t ct = 1024; void* hp;
  60:	48 c7 45 f8 00 04 00 00 	mov    QWORD PTR [rbp-0x8],0x400
		if (pm_count / 4096 / 16 < ct) /* restrict to 1/16 of all memory */
  68:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 6f <init_kernel_heap+0x17>
  6f:	48 c1 e8 10          	shr    rax,0x10
  73:	48 3b 45 f8          	cmp    rax,QWORD PTR [rbp-0x8]
  77:	73 0f                	jae    88 <init_kernel_heap+0x30>
				ct = pm_count / 4096 / 16;
  79:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 80 <init_kernel_heap+0x28>
  80:	48 c1 e8 10          	shr    rax,0x10
  84:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		hp = mm_alloc_vmem(&mm_kernel, NULL, ct, /*MMGR_ALLOC_NP_AOA // no AOA for start
  88:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  8c:	b9 0c 00 00 00       	mov    ecx,0xc
  91:	48 89 c2             	mov    rdx,rax
  94:	be 00 00 00 00       	mov    esi,0x0
  99:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  a0:	e8 00 00 00 00       	call   a5 <init_kernel_heap+0x4d>
  a5:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		h_kernel.heap_base = h_kernel.heap_ptr = hp;
  a9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  ad:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # b4 <init_kernel_heap+0x5c>
  b4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # bb <init_kernel_heap+0x63>
  bb:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # c2 <init_kernel_heap+0x6a>
		h_kernel.heap_limit = hp + ct * 4096;
  c2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  c6:	48 c1 e0 0c          	shl    rax,0xc
  ca:	48 89 c2             	mov    rdx,rax
  cd:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  d1:	48 01 d0             	add    rax,rdx
  d4:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # db <init_kernel_heap+0x83>
}
  db:	90                   	nop
  dc:	c9                   	leave
  dd:	c3                   	ret

00000000000000de <is_empty>:
int is_empty(struct heap_entry* he) { return ((char*)he->next - he->s - sizeof(struct heap_entry)) == (char*)he; }
  de:	55                   	push   rbp
  df:	48 89 e5             	mov    rbp,rsp
  e2:	48 83 ec 08          	sub    rsp,0x8
  e6:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
  ea:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  ee:	48 8b 10             	mov    rdx,QWORD PTR [rax]
  f1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  f5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
  f9:	48 c7 c1 f0 ff ff ff 	mov    rcx,0xfffffffffffffff0
 100:	48 29 c1             	sub    rcx,rax
 103:	48 8d 04 0a          	lea    rax,[rdx+rcx*1]
 107:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
 10b:	0f 94 c0             	sete   al
 10e:	0f b6 c0             	movzx  eax,al
 111:	c9                   	leave
 112:	c3                   	ret

0000000000000113 <h_dump>:
{
 113:	55                   	push   rbp
 114:	48 89 e5             	mov    rbp,rsp
 117:	48 83 ec 20          	sub    rsp,0x20
 11b:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct h_heap* h = (struct h_heap*)hp;
 11f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 123:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (h->flags == 1) { /* aggregate so dump twice */
 127:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 12b:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
 12e:	25 ff ff ff 7f       	and    eax,0x7fffffff
 133:	83 f8 01             	cmp    eax,0x1
 136:	75 44                	jne    17c <h_dump+0x69>
				printf("dumping aggreate heap consisting of heaps at:\n%p and %p",
 138:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 13c:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
 140:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 144:	48 8b 00             	mov    rax,QWORD PTR [rax]
 147:	48 89 c6             	mov    rsi,rax
 14a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 151:	b8 00 00 00 00       	mov    eax,0x0
 156:	e8 00 00 00 00       	call   15b <h_dump+0x48>
				h_dump(h->heap_base);
 15b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 15f:	48 8b 00             	mov    rax,QWORD PTR [rax]
 162:	48 89 c7             	mov    rdi,rax
 165:	e8 00 00 00 00       	call   16a <h_dump+0x57>
				h_dump(h->heap_ptr);
 16a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 16e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 172:	48 89 c7             	mov    rdi,rax
 175:	e8 00 00 00 00       	call   17a <h_dump+0x67>
}
 17a:	eb 68                	jmp    1e4 <h_dump+0xd1>
				struct heap_entry* he = (struct heap_entry*)h->heap_base;
 17c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 180:	48 8b 00             	mov    rax,QWORD PTR [rax]
 183:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				printf("dumping heap at %p with limit %p and ptr=%p\n",
 187:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 18b:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 18f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 193:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
 197:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 19b:	48 8b 00             	mov    rax,QWORD PTR [rax]
 19e:	48 89 c6             	mov    rsi,rax
 1a1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 1a8:	b8 00 00 00 00       	mov    eax,0x0
 1ad:	e8 00 00 00 00       	call   1b2 <h_dump+0x9f>
						printf("entry at %p with size %u\n", he, he->s);
 1b2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 1b6:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
 1ba:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 1be:	48 89 c6             	mov    rsi,rax
 1c1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 1c8:	b8 00 00 00 00       	mov    eax,0x0
 1cd:	e8 00 00 00 00       	call   1d2 <h_dump+0xbf>
				} while ((he = he->next));
 1d2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 1d6:	48 8b 00             	mov    rax,QWORD PTR [rax]
 1d9:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
 1dd:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
 1e2:	75 ce                	jne    1b2 <h_dump+0x9f>
}
 1e4:	90                   	nop
 1e5:	c9                   	leave
 1e6:	c3                   	ret

00000000000001e7 <h_malloc>:
{
 1e7:	55                   	push   rbp
 1e8:	48 89 e5             	mov    rbp,rsp
 1eb:	48 83 ec 50          	sub    rsp,0x50
 1ef:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
 1f3:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
		struct h_heap* h = (struct h_heap*)hpp;
 1f7:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 1fb:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
		if (h->flags == 1) { /* we're on an aggregate heap */
 1ff:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 203:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
 206:	25 ff ff ff 7f       	and    eax,0x7fffffff
 20b:	83 f8 01             	cmp    eax,0x1
 20e:	74 06                	je     216 <h_malloc+0x2f>
Pos1:
 210:	90                   	nop
 211:	e9 b7 00 00 00       	jmp    2cd <h_malloc+0xe6>
				void* rv = NULL;
 216:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				rv = h_malloc(h->heap_limit, s);
 21e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 222:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
 226:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 22a:	48 89 d6             	mov    rsi,rdx
 22d:	48 89 c7             	mov    rdi,rax
 230:	e8 00 00 00 00       	call   235 <h_malloc+0x4e>
 235:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (!rv) {
 239:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
 23e:	75 5e                	jne    29e <h_malloc+0xb7>
						rv = h_malloc(h->heap_base, s);
 240:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 244:	48 8b 00             	mov    rax,QWORD PTR [rax]
 247:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 24b:	48 89 d6             	mov    rsi,rdx
 24e:	48 89 c7             	mov    rdi,rax
 251:	e8 00 00 00 00       	call   256 <h_malloc+0x6f>
 256:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						if (!rv) { /* call the OOM handler (i.e. add another aggregation level) */
 25a:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
 25f:	75 3d                	jne    29e <h_malloc+0xb7>
								if (!h->heap_oom_handler(hpp, s))
 261:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 265:	48 8b 48 20          	mov    rcx,QWORD PTR [rax+0x20]
 269:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 26d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 271:	48 89 d6             	mov    rsi,rdx
 274:	48 89 c7             	mov    rdi,rax
 277:	ff d1                	call   rcx
 279:	85 c0                	test   eax,eax
 27b:	75 0a                	jne    287 <h_malloc+0xa0>
										return NULL;
 27d:	b8 00 00 00 00       	mov    eax,0x0
 282:	e9 71 03 00 00       	jmp    5f8 <h_malloc+0x411>
										rv = h_malloc(hpp, s);
 287:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 28b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 28f:	48 89 d6             	mov    rsi,rdx
 292:	48 89 c7             	mov    rdi,rax
 295:	e8 00 00 00 00       	call   29a <h_malloc+0xb3>
 29a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				h->heap_commit = ((struct h_heap*)h->heap_base)->heap_commit
 29e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2a2:	48 8b 00             	mov    rax,QWORD PTR [rax]
 2a5:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
						+ ((struct h_heap*)h->heap_ptr)->heap_commit;
 2a9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2ad:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 2b1:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 2b5:	48 01 c2             	add    rdx,rax
				h->heap_commit = ((struct h_heap*)h->heap_base)->heap_commit
 2b8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2bc:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
				return rv;
 2c0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 2c4:	e9 2f 03 00 00       	jmp    5f8 <h_malloc+0x411>
					goto Pos1;
 2c9:	90                   	nop
 2ca:	eb 01                	jmp    2cd <h_malloc+0xe6>
					goto Pos1;
 2cc:	90                   	nop
		hp = (struct heap_entry*)h->heap_base;
 2cd:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2d1:	48 8b 00             	mov    rax,QWORD PTR [rax]
 2d4:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		rem = (char*)h->heap_limit - (char*)h->heap_ptr;
 2d8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2dc:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
 2e0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2e4:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 2e8:	48 29 c2             	sub    rdx,rax
 2eb:	48 89 55 d0          	mov    QWORD PTR [rbp-0x30],rdx
		if (rem > s + sizeof(struct heap_entry)) { /* easy, lock free */
 2ef:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 2f3:	48 83 c0 10          	add    rax,0x10
 2f7:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
 2fb:	0f 83 91 00 00 00    	jae    392 <h_malloc+0x1ab>
			hp = (struct heap_entry*)h->heap_ptr;
 301:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 305:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 309:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
			if (rem != (size_t)((char*)h->heap_limit - (char*)hp))
 30d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 311:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
 315:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
 319:	48 89 c2             	mov    rdx,rax
 31c:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
 320:	48 39 c2             	cmp    rdx,rax
 323:	75 a4                	jne    2c9 <h_malloc+0xe2>
			if (!__sync_bool_compare_and_swap(&h->heap_ptr, hp, (char*)h->heap_ptr + s + sizeof(struct heap_entry)))
 325:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 329:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 32d:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 331:	48 83 c2 10          	add    rdx,0x10
 335:	48 01 d0             	add    rax,rdx
 338:	48 89 c1             	mov    rcx,rax
 33b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 33f:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
 343:	48 83 c2 08          	add    rdx,0x8
 347:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
 34c:	0f 94 c0             	sete   al
 34f:	83 f0 01             	xor    eax,0x1
 352:	84 c0                	test   al,al
 354:	0f 85 72 ff ff ff    	jne    2cc <h_malloc+0xe5>
			hp->s = s;
 35a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 35e:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 362:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
			hp->next = h->heap_ptr;
 366:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 36a:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
 36e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 372:	48 89 10             	mov    QWORD PTR [rax],rdx
			__sync_add_and_fetch(&h->heap_commit, s);
 375:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 379:	48 8d 50 18          	lea    rdx,[rax+0x18]
 37d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 381:	f0 48 01 02          	lock add QWORD PTR [rdx],rax
			return hp + 1;
 385:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 389:	48 83 c0 10          	add    rax,0x10
 38d:	e9 66 02 00 00       	jmp    5f8 <h_malloc+0x411>
				size_t fs_prev = 0; struct heap_entry* hp_p = 0;
 392:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
 39a:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
				while ((void*)hp < h->heap_ptr) {
 3a2:	e9 e1 01 00 00       	jmp    588 <h_malloc+0x3a1>
						fs = (char*)hp->next - (char*)hp - hp->s - sizeof(struct heap_entry);
 3a7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 3ab:	48 8b 00             	mov    rax,QWORD PTR [rax]
 3ae:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
 3b2:	48 89 c2             	mov    rdx,rax
 3b5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 3b9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 3bd:	48 29 c2             	sub    rdx,rax
 3c0:	48 8d 42 f0          	lea    rax,[rdx-0x10]
 3c4:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
						if (fs == 0) { /* full entry */
 3c8:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
 3cd:	75 20                	jne    3ef <h_malloc+0x208>
								fs_prev = 0; hp_p = hp;
 3cf:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
 3d7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 3db:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								hp = hp->next;
 3df:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 3e3:	48 8b 00             	mov    rax,QWORD PTR [rax]
 3e6:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
 3ea:	e9 99 01 00 00       	jmp    588 <h_malloc+0x3a1>
						} else if (fs >= s + sizeof(struct heap_entry)) { /* reuse single (deleted?) space */
 3ef:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 3f3:	48 83 c0 10          	add    rax,0x10
 3f7:	48 39 45 c8          	cmp    QWORD PTR [rbp-0x38],rax
 3fb:	0f 82 a1 00 00 00    	jb     4a2 <h_malloc+0x2bb>
								if (is_empty(hp)) {
 401:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 405:	48 89 c7             	mov    rdi,rax
 408:	e8 00 00 00 00       	call   40d <h_malloc+0x226>
 40d:	85 c0                	test   eax,eax
 40f:	74 30                	je     441 <h_malloc+0x25a>
										hp->s = s;
 411:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 415:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 419:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
										h->heap_commit += s;
 41d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 421:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
 425:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 429:	48 01 c2             	add    rdx,rax
 42c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 430:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
										return hp + 1;
 434:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 438:	48 83 c0 10          	add    rax,0x10
 43c:	e9 b7 01 00 00       	jmp    5f8 <h_malloc+0x411>
										hp_p = hp;
 441:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 445:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
										hp = (struct heap_entry*)((char*)(hp + 1) + hp->s);
 449:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 44d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 451:	48 83 c0 10          	add    rax,0x10
 455:	48 01 45 f0          	add    QWORD PTR [rbp-0x10],rax
										hp->s = s;
 459:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 45d:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 461:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
										hp->next = hp_p->next;
 465:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 469:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 46c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 470:	48 89 10             	mov    QWORD PTR [rax],rdx
										hp_p->next = hp;
 473:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 477:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
 47b:	48 89 10             	mov    QWORD PTR [rax],rdx
										h->heap_commit += s;
 47e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 482:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
 486:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 48a:	48 01 c2             	add    rdx,rax
 48d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 491:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
										return hp + 1;
 495:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 499:	48 83 c0 10          	add    rax,0x10
 49d:	e9 56 01 00 00       	jmp    5f8 <h_malloc+0x411>
						} else if (fs == hp->s) { /* remove completly freed space */
 4a2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 4a6:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 4aa:	48 39 45 c8          	cmp    QWORD PTR [rbp-0x38],rax
 4ae:	0f 85 b9 00 00 00    	jne    56d <h_malloc+0x386>
								if (hp_p) { /* combine entries */
 4b4:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
 4b9:	0f 84 9c 00 00 00    	je     55b <h_malloc+0x374>
										hp_p->next = hp->next;
 4bf:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 4c3:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 4c6:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 4ca:	48 89 10             	mov    QWORD PTR [rax],rdx
										fs_prev += fs + sizeof(struct heap_entry);
 4cd:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
 4d1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 4d5:	48 01 d0             	add    rax,rdx
 4d8:	48 83 c0 10          	add    rax,0x10
 4dc:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
										if (fs_prev >= s + sizeof(struct heap_entry)) { /* found sth */
 4e0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 4e4:	48 83 c0 10          	add    rax,0x10
 4e8:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
 4ec:	72 60                	jb     54e <h_malloc+0x367>
												hp = (struct heap_entry*)((char*)(hp_p + 1) + hp_p->s);
 4ee:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 4f2:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 4f6:	48 8d 50 10          	lea    rdx,[rax+0x10]
 4fa:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 4fe:	48 01 d0             	add    rax,rdx
 501:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
												hp->s = s;
 505:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 509:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 50d:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
												hp->next = hp_p->next;
 511:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 515:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 518:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 51c:	48 89 10             	mov    QWORD PTR [rax],rdx
												hp_p->next = hp;
 51f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 523:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
 527:	48 89 10             	mov    QWORD PTR [rax],rdx
												h->heap_commit += s;
 52a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 52e:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
 532:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 536:	48 01 c2             	add    rdx,rax
 539:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 53d:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
												return hp + 1;
 541:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 545:	48 83 c0 10          	add    rax,0x10
 549:	e9 aa 00 00 00       	jmp    5f8 <h_malloc+0x411>
												hp = (struct heap_entry*)hp->next;
 54e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 552:	48 8b 00             	mov    rax,QWORD PTR [rax]
 555:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
 559:	eb 2d                	jmp    588 <h_malloc+0x3a1>
										fs_prev = fs;
 55b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
 55f:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
										hp_p = hp;
 563:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 567:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
 56b:	eb 1b                	jmp    588 <h_malloc+0x3a1>
								fs_prev = fs;
 56d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
 571:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
								hp_p = hp;
 575:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 579:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								hp = (struct heap_entry*)hp->next;
 57d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 581:	48 8b 00             	mov    rax,QWORD PTR [rax]
 584:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				while ((void*)hp < h->heap_ptr) {
 588:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 58c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 590:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
 594:	0f 82 0d fe ff ff    	jb     3a7 <h_malloc+0x1c0>
				if (h->heap_oom_handler)
 59a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 59e:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
 5a2:	48 85 c0             	test   rax,rax
 5a5:	74 31                	je     5d8 <h_malloc+0x3f1>
						if (h->heap_oom_handler(hpp, s))
 5a7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 5ab:	48 8b 48 20          	mov    rcx,QWORD PTR [rax+0x20]
 5af:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 5b3:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 5b7:	48 89 d6             	mov    rsi,rdx
 5ba:	48 89 c7             	mov    rdi,rax
 5bd:	ff d1                	call   rcx
 5bf:	85 c0                	test   eax,eax
 5c1:	74 15                	je     5d8 <h_malloc+0x3f1>
								return h_malloc(hpp, s);
 5c3:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 5c7:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 5cb:	48 89 d6             	mov    rsi,rdx
 5ce:	48 89 c7             	mov    rdi,rax
 5d1:	e8 00 00 00 00       	call   5d6 <h_malloc+0x3ef>
 5d6:	eb 20                	jmp    5f8 <h_malloc+0x411>
				printf("Out of heap memory\nIdling for debug\n");
 5d8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 5df:	b8 00 00 00 00       	mov    eax,0x0
 5e4:	e8 00 00 00 00       	call   5e9 <h_malloc+0x402>
				h_dump(hpp);
 5e9:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 5ed:	48 89 c7             	mov    rdi,rax
 5f0:	e8 00 00 00 00       	call   5f5 <h_malloc+0x40e>
				while (1);
 5f5:	90                   	nop
 5f6:	eb fd                	jmp    5f5 <h_malloc+0x40e>
}
 5f8:	c9                   	leave
 5f9:	c3                   	ret

00000000000005fa <h_free>:
{
 5fa:	55                   	push   rbp
 5fb:	48 89 e5             	mov    rbp,rsp
 5fe:	48 83 ec 20          	sub    rsp,0x20
 602:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
 606:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		struct h_heap* h = (struct h_heap*)hp;
 60a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 60e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if(h->flags == 1) { /* free on aggregate heap (i.e. everywhere) */
 612:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 616:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
 619:	25 ff ff ff 7f       	and    eax,0x7fffffff
 61e:	83 f8 01             	cmp    eax,0x1
 621:	75 2f                	jne    652 <h_free+0x58>
				h_free(h->heap_base, ptr);
 623:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 627:	48 8b 00             	mov    rax,QWORD PTR [rax]
 62a:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
 62e:	48 89 d6             	mov    rsi,rdx
 631:	48 89 c7             	mov    rdi,rax
 634:	e8 00 00 00 00       	call   639 <h_free+0x3f>
				h_free(h->heap_ptr, ptr);
 639:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 63d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 641:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
 645:	48 89 d6             	mov    rsi,rdx
 648:	48 89 c7             	mov    rdi,rax
 64b:	e8 00 00 00 00       	call   650 <h_free+0x56>
				return;
 650:	eb 43                	jmp    695 <h_free+0x9b>
		if (ptr >= h->heap_base && ptr <= h->heap_limit) {
 652:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 656:	48 8b 00             	mov    rax,QWORD PTR [rax]
 659:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
 65d:	72 36                	jb     695 <h_free+0x9b>
 65f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 663:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
 667:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
 66b:	72 28                	jb     695 <h_free+0x9b>
				__sync_sub_and_fetch(&h->heap_commit, ((struct heap_entry*)ptr - 1)->s);
 66d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 671:	48 83 e8 10          	sub    rax,0x10
 675:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 679:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
 67d:	48 83 c2 18          	add    rdx,0x18
 681:	f0 48 29 02          	lock sub QWORD PTR [rdx],rax
				((struct heap_entry*)ptr - 1)->s = 0;
 685:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 689:	48 83 e8 10          	sub    rax,0x10
 68d:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
}
 695:	c9                   	leave
 696:	c3                   	ret

0000000000000697 <h_realloc>:
{
 697:	55                   	push   rbp
 698:	48 89 e5             	mov    rbp,rsp
 69b:	48 83 ec 60          	sub    rsp,0x60
 69f:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
 6a3:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
 6a7:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
		if (ptr) {
 6ab:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
 6b0:	0f 84 17 03 00 00    	je     9cd <h_realloc+0x336>
				struct h_heap* h = (struct h_heap*)hp;
 6b6:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 6ba:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if (h->flags == 1) { /* do an aggregate realloc (i.e. everywhere) */
 6be:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 6c2:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
 6c5:	25 ff ff ff 7f       	and    eax,0x7fffffff
 6ca:	83 f8 01             	cmp    eax,0x1
 6cd:	0f 85 99 00 00 00    	jne    76c <h_realloc+0xd5>
						void* rv = NULL;
 6d3:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
						rv = h_realloc(h->heap_base, ptr, s);
 6db:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 6df:	48 8b 00             	mov    rax,QWORD PTR [rax]
 6e2:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 6e6:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
 6ea:	48 89 ce             	mov    rsi,rcx
 6ed:	48 89 c7             	mov    rdi,rax
 6f0:	e8 00 00 00 00       	call   6f5 <h_realloc+0x5e>
 6f5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						if (!rv)
 6f9:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
 6fe:	75 1b                	jne    71b <h_realloc+0x84>
								h_realloc(h->heap_ptr, ptr, s);
 700:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 704:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 708:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 70c:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
 710:	48 89 ce             	mov    rsi,rcx
 713:	48 89 c7             	mov    rdi,rax
 716:	e8 00 00 00 00       	call   71b <h_realloc+0x84>
						if (!rv) { /* call the OOM handler (i.e. add another aggregation level) */
 71b:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
 720:	75 41                	jne    763 <h_realloc+0xcc>
								if (!h->heap_oom_handler(hp, s))
 722:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 726:	48 8b 48 20          	mov    rcx,QWORD PTR [rax+0x20]
 72a:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 72e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 732:	48 89 d6             	mov    rsi,rdx
 735:	48 89 c7             	mov    rdi,rax
 738:	ff d1                	call   rcx
 73a:	85 c0                	test   eax,eax
 73c:	75 0a                	jne    748 <h_realloc+0xb1>
										return NULL;
 73e:	b8 00 00 00 00       	mov    eax,0x0
 743:	e9 98 02 00 00       	jmp    9e0 <h_realloc+0x349>
										rv = h_realloc(hp, ptr, s);
 748:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 74c:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
 750:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 754:	48 89 ce             	mov    rsi,rcx
 757:	48 89 c7             	mov    rdi,rax
 75a:	e8 00 00 00 00       	call   75f <h_realloc+0xc8>
 75f:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						return rv;
 763:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 767:	e9 74 02 00 00       	jmp    9e0 <h_realloc+0x349>
				if (ptr < h->heap_base || ptr > h->heap_limit)
 76c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 770:	48 8b 00             	mov    rax,QWORD PTR [rax]
 773:	48 39 45 b0          	cmp    QWORD PTR [rbp-0x50],rax
 777:	72 0e                	jb     787 <h_realloc+0xf0>
 779:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 77d:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
 781:	48 3b 45 b0          	cmp    rax,QWORD PTR [rbp-0x50]
 785:	73 0a                	jae    791 <h_realloc+0xfa>
						return NULL;
 787:	b8 00 00 00 00       	mov    eax,0x0
 78c:	e9 4f 02 00 00       	jmp    9e0 <h_realloc+0x349>
				struct heap_entry* hp = (struct heap_entry*)(ptr) - 1, *hp2;
 791:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 795:	48 83 e8 10          	sub    rax,0x10
 799:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				size_t fs = 0, oldS = hp->s;
 79d:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
 7a5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 7a9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 7ad:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				if (s <= hp->s) { /* shrink */
 7b1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 7b5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 7b9:	48 3b 45 a8          	cmp    rax,QWORD PTR [rbp-0x58]
 7bd:	72 30                	jb     7ef <h_realloc+0x158>
						h->heap_commit -= oldS - s;
 7bf:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 7c3:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
 7c7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
 7cb:	48 2b 45 d0          	sub    rax,QWORD PTR [rbp-0x30]
 7cf:	48 01 c2             	add    rdx,rax
 7d2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 7d6:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
						hp->s = s;
 7da:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 7de:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 7e2:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
						return ptr;
 7e6:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 7ea:	e9 f1 01 00 00       	jmp    9e0 <h_realloc+0x349>
				hp2 = hp->next;
 7ef:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 7f3:	48 8b 00             	mov    rax,QWORD PTR [rax]
 7f6:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				while ((char*)hp2 < (char*)h->heap_ptr) {
 7fa:	e9 dc 00 00 00       	jmp    8db <h_realloc+0x244>
						if (is_empty(hp2)) {
 7ff:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 803:	48 89 c7             	mov    rdi,rax
 806:	e8 00 00 00 00       	call   80b <h_realloc+0x174>
 80b:	85 c0                	test   eax,eax
 80d:	74 77                	je     886 <h_realloc+0x1ef>
								fs += hp2->s + sizeof(struct heap_entry);
 80f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 813:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
 817:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 81b:	48 01 d0             	add    rax,rdx
 81e:	48 83 c0 10          	add    rax,0x10
 822:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
								hp->next = hp2->next;
 826:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 82a:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 82d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 831:	48 89 10             	mov    QWORD PTR [rax],rdx
								if (hp->s + fs >= s) { /* found enough space*/
 834:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 838:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
 83c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 840:	48 01 d0             	add    rax,rdx
 843:	48 3b 45 a8          	cmp    rax,QWORD PTR [rbp-0x58]
 847:	72 30                	jb     879 <h_realloc+0x1e2>
										h->heap_commit += s - oldS;
 849:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 84d:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
 851:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
 855:	48 2b 45 d0          	sub    rax,QWORD PTR [rbp-0x30]
 859:	48 01 c2             	add    rdx,rax
 85c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 860:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
										hp->s = s;
 864:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 868:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 86c:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
										return ptr;
 870:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 874:	e9 67 01 00 00       	jmp    9e0 <h_realloc+0x349>
										hp2 = (struct heap_entry*)hp2->next;
 879:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 87d:	48 8b 00             	mov    rax,QWORD PTR [rax]
 880:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
 884:	eb 55                	jmp    8db <h_realloc+0x244>
								void* rv = h_malloc(hp, s);
 886:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 88a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 88e:	48 89 d6             	mov    rsi,rdx
 891:	48 89 c7             	mov    rdi,rax
 894:	e8 00 00 00 00       	call   899 <h_realloc+0x202>
 899:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
								if(rv) {
 89d:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
 8a2:	74 2e                	je     8d2 <h_realloc+0x23b>
										memcpy(rv, ptr, hp->s);
 8a4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 8a8:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
 8ac:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
 8b0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
 8b4:	48 89 ce             	mov    rsi,rcx
 8b7:	48 89 c7             	mov    rdi,rax
 8ba:	e8 41 f7 ff ff       	call   0 <memcpy>
										h_free(hp, ptr);
 8bf:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
 8c3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 8c7:	48 89 d6             	mov    rsi,rdx
 8ca:	48 89 c7             	mov    rdi,rax
 8cd:	e8 00 00 00 00       	call   8d2 <h_realloc+0x23b>
								return rv;
 8d2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
 8d6:	e9 05 01 00 00       	jmp    9e0 <h_realloc+0x349>
				while ((char*)hp2 < (char*)h->heap_ptr) {
 8db:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 8df:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 8e3:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
 8e7:	0f 82 12 ff ff ff    	jb     7ff <h_realloc+0x168>
				fs += (char*)h->heap_limit - (char*)h->heap_ptr;
 8ed:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 8f1:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
 8f5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 8f9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 8fd:	48 29 c2             	sub    rdx,rax
 900:	48 89 d0             	mov    rax,rdx
 903:	48 01 45 e8          	add    QWORD PTR [rbp-0x18],rax
				if (fs + hp->s >= s) {
 907:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 90b:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
 90f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 913:	48 01 d0             	add    rax,rdx
 916:	48 3b 45 a8          	cmp    rax,QWORD PTR [rbp-0x58]
 91a:	72 4f                	jb     96b <h_realloc+0x2d4>
						h->heap_ptr = (char*)h->heap_ptr + s - hp->s;
 91c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 920:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
 924:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 928:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 92c:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
 930:	48 29 c1             	sub    rcx,rax
 933:	48 01 ca             	add    rdx,rcx
 936:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 93a:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
						h->heap_commit += s - oldS;
 93e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 942:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
 946:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
 94a:	48 2b 45 d0          	sub    rax,QWORD PTR [rbp-0x30]
 94e:	48 01 c2             	add    rdx,rax
 951:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 955:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
						hp->s = s;
 959:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 95d:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 961:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
						return ptr;
 965:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
 969:	eb 75                	jmp    9e0 <h_realloc+0x349>
				if (h->heap_oom_handler)
 96b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 96f:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
 973:	48 85 c0             	test   rax,rax
 976:	74 35                	je     9ad <h_realloc+0x316>
						if (h->heap_oom_handler(hp, s))
 978:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 97c:	48 8b 48 20          	mov    rcx,QWORD PTR [rax+0x20]
 980:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 984:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 988:	48 89 d6             	mov    rsi,rdx
 98b:	48 89 c7             	mov    rdi,rax
 98e:	ff d1                	call   rcx
 990:	85 c0                	test   eax,eax
 992:	74 19                	je     9ad <h_realloc+0x316>
								return h_realloc(hp, ptr, s);
 994:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 998:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
 99c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 9a0:	48 89 ce             	mov    rsi,rcx
 9a3:	48 89 c7             	mov    rdi,rax
 9a6:	e8 00 00 00 00       	call   9ab <h_realloc+0x314>
 9ab:	eb 33                	jmp    9e0 <h_realloc+0x349>
				printf("Out of heap memory\nIdling for debug\n");
 9ad:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 9b4:	b8 00 00 00 00       	mov    eax,0x0
 9b9:	e8 00 00 00 00       	call   9be <h_realloc+0x327>
				h_dump(hp);
 9be:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 9c2:	48 89 c7             	mov    rdi,rax
 9c5:	e8 00 00 00 00       	call   9ca <h_realloc+0x333>
				while (1);
 9ca:	90                   	nop
 9cb:	eb fd                	jmp    9ca <h_realloc+0x333>
				return h_malloc(hp, s);
 9cd:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
 9d1:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 9d5:	48 89 d6             	mov    rsi,rdx
 9d8:	48 89 c7             	mov    rdi,rax
 9db:	e8 00 00 00 00       	call   9e0 <h_realloc+0x349>
}
 9e0:	c9                   	leave
 9e1:	c3                   	ret

00000000000009e2 <h_create_heap>:
{
 9e2:	55                   	push   rbp
 9e3:	48 89 e5             	mov    rbp,rsp
 9e6:	48 83 ec 30          	sub    rsp,0x30
 9ea:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
 9ee:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
 9f2:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
 9f6:	48 89 4d d0          	mov    QWORD PTR [rbp-0x30],rcx
		struct h_heap* h = (struct h_heap*)mem;
 9fa:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 9fe:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (ct < sizeof(struct h_heap) + sizeof(struct heap_entry))
 a02:	48 83 7d e0 47       	cmp    QWORD PTR [rbp-0x20],0x47
 a07:	77 07                	ja     a10 <h_create_heap+0x2e>
				return NULL; /* don't allocate noviable heaps */
 a09:	b8 00 00 00 00       	mov    eax,0x0
 a0e:	eb 77                	jmp    a87 <h_create_heap+0xa5>
		h->desc_in_heap = 1; /* we're using part of mem */
 a10:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 a14:	0f b6 50 33          	movzx  edx,BYTE PTR [rax+0x33]
 a18:	83 ca 80             	or     edx,0xffffff80
 a1b:	88 50 33             	mov    BYTE PTR [rax+0x33],dl
		h->flags = 0; /* non-aggregate */
 a1e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 a22:	8b 50 30             	mov    edx,DWORD PTR [rax+0x30]
 a25:	81 e2 00 00 00 80    	and    edx,0x80000000
 a2b:	89 50 30             	mov    DWORD PTR [rax+0x30],edx
		h->heap_base = mem + sizeof(struct h_heap);
 a2e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 a32:	48 8d 50 38          	lea    rdx,[rax+0x38]
 a36:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 a3a:	48 89 10             	mov    QWORD PTR [rax],rdx
		h->heap_limit = mem + ct;
 a3d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
 a41:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 a45:	48 01 c2             	add    rdx,rax
 a48:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 a4c:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
		h->heap_ptr = h->heap_base;
 a50:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 a54:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 a57:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 a5b:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		h->heap_commit = 0;
 a5f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 a63:	48 c7 40 18 00 00 00 00 	mov    QWORD PTR [rax+0x18],0x0
		h->heap_decommit = hdc;
 a6b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 a6f:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
 a73:	48 89 50 28          	mov    QWORD PTR [rax+0x28],rdx
		h->heap_oom_handler = hdlr;
 a77:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 a7b:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
 a7f:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
		return mem;
 a83:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
}
 a87:	c9                   	leave
 a88:	c3                   	ret

0000000000000a89 <h_destroy>:
{
 a89:	55                   	push   rbp
 a8a:	48 89 e5             	mov    rbp,rsp
 a8d:	48 83 ec 20          	sub    rsp,0x20
 a91:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct h_heap* h = (struct h_heap*)hp;
 a95:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 a99:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (h->flags == 1) { /* destroy both heaps */
 a9d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 aa1:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
 aa4:	25 ff ff ff 7f       	and    eax,0x7fffffff
 aa9:	83 f8 01             	cmp    eax,0x1
 aac:	75 21                	jne    acf <h_destroy+0x46>
				h_destroy(h->heap_base);
 aae:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 ab2:	48 8b 00             	mov    rax,QWORD PTR [rax]
 ab5:	48 89 c7             	mov    rdi,rax
 ab8:	e8 00 00 00 00       	call   abd <h_destroy+0x34>
				h_destroy(h->heap_ptr);
 abd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 ac1:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 ac5:	48 89 c7             	mov    rdi,rax
 ac8:	e8 00 00 00 00       	call   acd <h_destroy+0x44>
				return;
 acd:	eb 5c                	jmp    b2b <h_destroy+0xa2>
		struct heap_entry* he = (struct heap_entry*)h->heap_base;
 acf:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 ad3:	48 8b 00             	mov    rax,QWORD PTR [rax]
 ad6:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		he->s = 0;
 ada:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 ade:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		he->next = h->heap_limit;
 ae6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 aea:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
 aee:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 af2:	48 89 10             	mov    QWORD PTR [rax],rdx
		if (h->heap_decommit)
 af5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 af9:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
 afd:	48 85 c0             	test   rax,rax
 b00:	74 29                	je     b2b <h_destroy+0xa2>
				h->heap_decommit(h->heap_base, h->heap_limit - h->heap_base);
 b02:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 b06:	48 8b 50 28          	mov    rdx,QWORD PTR [rax+0x28]
 b0a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 b0e:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
 b12:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 b16:	48 8b 00             	mov    rax,QWORD PTR [rax]
 b19:	48 29 c1             	sub    rcx,rax
 b1c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 b20:	48 8b 00             	mov    rax,QWORD PTR [rax]
 b23:	48 89 ce             	mov    rsi,rcx
 b26:	48 89 c7             	mov    rdi,rax
 b29:	ff d2                	call   rdx
}
 b2b:	c9                   	leave
 b2c:	c3                   	ret

0000000000000b2d <kmalloc>:
{
 b2d:	55                   	push   rbp
 b2e:	48 89 e5             	mov    rbp,rsp
 b31:	48 83 ec 30          	sub    rsp,0x30
 b35:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		void* rv = h_malloc(&h_kernel, s + 2 * KGUARD_SIZE);
 b39:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 b3d:	48 83 c0 10          	add    rax,0x10
 b41:	48 89 c6             	mov    rsi,rax
 b44:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 b4b:	e8 00 00 00 00       	call   b50 <kmalloc+0x23>
 b50:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		if (!rv)
 b54:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
 b59:	75 07                	jne    b62 <kmalloc+0x35>
				return NULL;
 b5b:	b8 00 00 00 00       	mov    eax,0x0
 b60:	eb 5a                	jmp    bbc <kmalloc+0x8f>
		p1 = rv;
 b62:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 b66:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		p2 = rv + s + 2 * KGUARD_SIZE;
 b6a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 b6e:	48 8d 50 10          	lea    rdx,[rax+0x10]
 b72:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 b76:	48 01 d0             	add    rax,rdx
 b79:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 b7d:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
 b85:	eb 26                	jmp    bad <kmalloc+0x80>
				*p1++ = *--p2 = 0xcb;
 b87:	48 83 6d f0 01       	sub    QWORD PTR [rbp-0x10],0x1
 b8c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 b90:	c6 00 cb             	mov    BYTE PTR [rax],0xcb
 b93:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 b97:	48 8d 50 01          	lea    rdx,[rax+0x1]
 b9b:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
 b9f:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
 ba3:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
 ba6:	88 10                	mov    BYTE PTR [rax],dl
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 ba8:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
 bad:	48 83 7d e8 07       	cmp    QWORD PTR [rbp-0x18],0x7
 bb2:	76 d3                	jbe    b87 <kmalloc+0x5a>
		return rv + KGUARD_SIZE;
 bb4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 bb8:	48 83 c0 08          	add    rax,0x8
}
 bbc:	c9                   	leave
 bbd:	c3                   	ret

0000000000000bbe <kzalloc>:
{
 bbe:	55                   	push   rbp
 bbf:	48 89 e5             	mov    rbp,rsp
 bc2:	48 83 ec 20          	sub    rsp,0x20
 bc6:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		void* rv = kmalloc(s);
 bca:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 bce:	48 89 c7             	mov    rdi,rax
 bd1:	e8 00 00 00 00       	call   bd6 <kzalloc+0x18>
 bd6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!rv)
 bda:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
 bdf:	75 07                	jne    be8 <kzalloc+0x2a>
				return NULL;
 be1:	b8 00 00 00 00       	mov    eax,0x0
 be6:	eb 17                	jmp    bff <kzalloc+0x41>
		bzero(rv, s);
 be8:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
 bec:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 bf0:	48 89 d6             	mov    rsi,rdx
 bf3:	48 89 c7             	mov    rdi,rax
 bf6:	e8 00 00 00 00       	call   bfb <kzalloc+0x3d>
		return rv;
 bfb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
 bff:	c9                   	leave
 c00:	c3                   	ret

0000000000000c01 <kfree>:
{
 c01:	55                   	push   rbp
 c02:	48 89 e5             	mov    rbp,rsp
 c05:	48 83 ec 10          	sub    rsp,0x10
 c09:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		h_free(&h_kernel, ptr - KGUARD_SIZE);
 c0d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 c11:	48 83 e8 08          	sub    rax,0x8
 c15:	48 89 c6             	mov    rsi,rax
 c18:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 c1f:	e8 00 00 00 00       	call   c24 <kfree+0x23>
}
 c24:	90                   	nop
 c25:	c9                   	leave
 c26:	c3                   	ret

0000000000000c27 <krealloc>:

void* krealloc(void* ptr, size_t s)
{
 c27:	55                   	push   rbp
 c28:	48 89 e5             	mov    rbp,rsp
 c2b:	48 83 ec 30          	sub    rsp,0x30
 c2f:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
 c33:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		void* rv = h_realloc(&h_kernel, ptr - KGUARD_SIZE, s + 2 * KGUARD_SIZE);
 c37:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
 c3b:	48 8d 50 10          	lea    rdx,[rax+0x10]
 c3f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 c43:	48 83 e8 08          	sub    rax,0x8
 c47:	48 89 c6             	mov    rsi,rax
 c4a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 c51:	e8 00 00 00 00       	call   c56 <krealloc+0x2f>
 c56:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!rv)
 c5a:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
 c5f:	75 07                	jne    c68 <krealloc+0x41>
				return NULL;
 c61:	b8 00 00 00 00       	mov    eax,0x0
 c66:	eb 3d                	jmp    ca5 <krealloc+0x7e>
		char* p2 = rv + s + 2 * KGUARD_SIZE;
 c68:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
 c6c:	48 8d 50 10          	lea    rdx,[rax+0x10]
 c70:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 c74:	48 01 d0             	add    rax,rdx
 c77:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 c7b:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
 c83:	eb 11                	jmp    c96 <krealloc+0x6f>
				*--p2 = 0xcc;
 c85:	48 83 6d f8 01       	sub    QWORD PTR [rbp-0x8],0x1
 c8a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 c8e:	c6 00 cc             	mov    BYTE PTR [rax],0xcc
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 c91:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
 c96:	48 83 7d f0 07       	cmp    QWORD PTR [rbp-0x10],0x7
 c9b:	76 e8                	jbe    c85 <krealloc+0x5e>
		return rv + KGUARD_SIZE;
 c9d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 ca1:	48 83 c0 08          	add    rax,0x8
}
 ca5:	c9                   	leave
 ca6:	c3                   	ret

0000000000000ca7 <kstats_impl>:

void kstats_impl(struct h_heap* h, size_t* s_total, size_t* s_commit, size_t* s_free, size_t* s_nheaps)
{
 ca7:	55                   	push   rbp
 ca8:	48 89 e5             	mov    rbp,rsp
 cab:	48 83 ec 30          	sub    rsp,0x30
 caf:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
 cb3:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
 cb7:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
 cbb:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
 cbf:	4c 89 45 d8          	mov    QWORD PTR [rbp-0x28],r8
		if (h->flags == 1) {
 cc3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 cc7:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
 cca:	25 ff ff ff 7f       	and    eax,0x7fffffff
 ccf:	83 f8 01             	cmp    eax,0x1
 cd2:	75 47                	jne    d1b <kstats_impl+0x74>
				/* is aggregate */
				kstats_impl(h->heap_base, s_total, s_commit, s_free, s_nheaps);
 cd4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 cd8:	48 8b 00             	mov    rax,QWORD PTR [rax]
 cdb:	48 8b 7d d8          	mov    rdi,QWORD PTR [rbp-0x28]
 cdf:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
 ce3:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
 ce7:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
 ceb:	49 89 f8             	mov    r8,rdi
 cee:	48 89 c7             	mov    rdi,rax
 cf1:	e8 00 00 00 00       	call   cf6 <kstats_impl+0x4f>
				kstats_impl(h->heap_ptr, s_total, s_commit, s_free, s_nheaps);
 cf6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 cfa:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 cfe:	48 8b 7d d8          	mov    rdi,QWORD PTR [rbp-0x28]
 d02:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
 d06:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
 d0a:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
 d0e:	49 89 f8             	mov    r8,rdi
 d11:	48 89 c7             	mov    rdi,rax
 d14:	e8 00 00 00 00       	call   d19 <kstats_impl+0x72>
				return;
 d19:	eb 7f                	jmp    d9a <kstats_impl+0xf3>
		}

		/* we're on memory */
		*s_commit += h->heap_commit;
 d1b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 d1f:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 d22:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 d26:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 d2a:	48 01 c2             	add    rdx,rax
 d2d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 d31:	48 89 10             	mov    QWORD PTR [rax],rdx
		*s_total += h->heap_limit - h->heap_base;
 d34:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 d38:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 d3b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 d3f:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
 d43:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 d47:	48 8b 00             	mov    rax,QWORD PTR [rax]
 d4a:	48 29 c1             	sub    rcx,rax
 d4d:	48 89 c8             	mov    rax,rcx
 d50:	48 01 c2             	add    rdx,rax
 d53:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 d57:	48 89 10             	mov    QWORD PTR [rax],rdx
		*s_free += (h->heap_limit - h->heap_base) - h->heap_commit;
 d5a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 d5e:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 d61:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 d65:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
 d69:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 d6d:	48 8b 00             	mov    rax,QWORD PTR [rax]
 d70:	48 29 c1             	sub    rcx,rax
 d73:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 d77:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 d7b:	48 29 c1             	sub    rcx,rax
 d7e:	48 01 ca             	add    rdx,rcx
 d81:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 d85:	48 89 10             	mov    QWORD PTR [rax],rdx
		(*s_nheaps)++;
 d88:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 d8c:	48 8b 00             	mov    rax,QWORD PTR [rax]
 d8f:	48 8d 50 01          	lea    rdx,[rax+0x1]
 d93:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 d97:	48 89 10             	mov    QWORD PTR [rax],rdx
}
 d9a:	c9                   	leave
 d9b:	c3                   	ret

0000000000000d9c <kstats>:

void kstats(size_t* s_total, size_t* s_commit, size_t* s_free, size_t* s_nheaps)
{
 d9c:	55                   	push   rbp
 d9d:	48 89 e5             	mov    rbp,rsp
 da0:	48 83 ec 30          	sub    rsp,0x30
 da4:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
 da8:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
 dac:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
 db0:	48 89 4d d0          	mov    QWORD PTR [rbp-0x30],rcx
		*s_total = *s_commit = *s_free = *s_nheaps = 0;
 db4:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
 db8:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
 dbf:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
 dc3:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 dc6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 dca:	48 89 10             	mov    QWORD PTR [rax],rdx
 dcd:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 dd1:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 dd4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 dd8:	48 89 10             	mov    QWORD PTR [rax],rdx
 ddb:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 ddf:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 de2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 de6:	48 89 10             	mov    QWORD PTR [rax],rdx
		struct h_heap* h = &h_kernel;
 de9:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		kstats_impl(h, s_total, s_commit, s_free, s_nheaps);
 df1:	48 8b 7d d0          	mov    rdi,QWORD PTR [rbp-0x30]
 df5:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
 df9:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
 dfd:	48 8b 75 e8          	mov    rsi,QWORD PTR [rbp-0x18]
 e01:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 e05:	49 89 f8             	mov    r8,rdi
 e08:	48 89 c7             	mov    rdi,rax
 e0b:	e8 00 00 00 00       	call   e10 <kstats+0x74>
}
 e10:	90                   	nop
 e11:	c9                   	leave
 e12:	c3                   	ret

0000000000000e13 <h_generic_oom_handler>:

int h_generic_oom_handler(void* hp, size_t s)
{
 e13:	55                   	push   rbp
 e14:	48 89 e5             	mov    rbp,rsp
 e17:	48 83 ec 30          	sub    rsp,0x30
 e1b:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
 e1f:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		struct h_heap* h = (struct h_heap*)hp, *h2; void* nm;
 e23:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 e27:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		size_t page_ct;

		if (h->flags == 1) {
 e2b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 e2f:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
 e32:	25 ff ff ff 7f       	and    eax,0x7fffffff
 e37:	83 f8 01             	cmp    eax,0x1
 e3a:	75 0a                	jne    e46 <h_generic_oom_handler+0x33>
				/* aggregate on aggregates */
				/* should be handled by the generic handler */
				/* TODO: maybe check kernel vs. user pages */
				return 0;
 e3c:	b8 00 00 00 00       	mov    eax,0x0
 e41:	e9 7f 01 00 00       	jmp    fc5 <h_generic_oom_handler+0x1b2>
		}

		while (s);
 e46:	90                   	nop
 e47:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
 e4c:	75 f9                	jne    e47 <h_generic_oom_handler+0x34>

		/* map a new heap and move the initial desc into dynamic memory */
		page_ct = s / 4096;
 e4e:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
 e52:	48 c1 e8 0c          	shr    rax,0xc
 e56:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (page_ct % 256) /* MiB granularity */
 e5a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 e5e:	0f b6 c0             	movzx  eax,al
 e61:	48 85 c0             	test   rax,rax
 e64:	74 10                	je     e76 <h_generic_oom_handler+0x63>
				page_ct += 256 - (page_ct % 256);
 e66:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 e6a:	b0 00                	mov    al,0x0
 e6c:	48 05 00 01 00 00    	add    rax,0x100
 e72:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		nm = mm_alloc_vmem(&mm_kernel, NULL, page_ct, MMGR_ALLOC_NP_AOA
 e76:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 e7a:	b9 0c 00 02 00       	mov    ecx,0x2000c
 e7f:	48 89 c2             	mov    rdx,rax
 e82:	be 00 00 00 00       	mov    esi,0x0
 e87:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 e8e:	e8 00 00 00 00       	call   e93 <h_generic_oom_handler+0x80>
 e93:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						| MMGR_MAP_WRITE | MMGR_MAP_KERNEL/* | MMGR_MAP_GLOBAL*/);

		/* we now have page_ct scrubbed pages at nm
		 * let's create a new heap there */
		h2 = (struct h_heap*)h_create_heap(nm, page_ct * 4096, h_generic_oom_handler, h_generic_decommit);
 e97:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 e9b:	48 c1 e0 0c          	shl    rax,0xc
 e9f:	48 89 c6             	mov    rsi,rax
 ea2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 ea6:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
 ead:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
 eb4:	48 89 c7             	mov    rdi,rax
 eb7:	e8 00 00 00 00       	call   ebc <h_generic_oom_handler+0xa9>
 ebc:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		/* and move the desc of the initial heap there */
		nm = h_malloc(h2, sizeof(struct h_heap));
 ec0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 ec4:	be 38 00 00 00       	mov    esi,0x38
 ec9:	48 89 c7             	mov    rdi,rax
 ecc:	e8 00 00 00 00       	call   ed1 <h_generic_oom_handler+0xbe>
 ed1:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!nm) {
 ed5:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
 eda:	75 19                	jne    ef5 <h_generic_oom_handler+0xe2>
				/* this should never fail */
				cprintf(KFMT_ERROR, "catastrophe\n");
 edc:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 ee3:	bf 0c 00 00 00       	mov    edi,0xc
 ee8:	b8 00 00 00 00       	mov    eax,0x0
 eed:	e8 00 00 00 00       	call   ef2 <h_generic_oom_handler+0xdf>
				while (1);
 ef2:	90                   	nop
 ef3:	eb fd                	jmp    ef2 <h_generic_oom_handler+0xdf>
		}
		h->heap_oom_handler = NULL;
 ef5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 ef9:	48 c7 40 20 00 00 00 00 	mov    QWORD PTR [rax+0x20],0x0
		*(struct h_heap*)nm = *h; /* deregister this handler */
 f01:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 f05:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
 f09:	48 8b 0a             	mov    rcx,QWORD PTR [rdx]
 f0c:	48 89 08             	mov    QWORD PTR [rax],rcx
 f0f:	48 8b 4a 08          	mov    rcx,QWORD PTR [rdx+0x8]
 f13:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
 f17:	48 8b 4a 10          	mov    rcx,QWORD PTR [rdx+0x10]
 f1b:	48 89 48 10          	mov    QWORD PTR [rax+0x10],rcx
 f1f:	48 8b 4a 18          	mov    rcx,QWORD PTR [rdx+0x18]
 f23:	48 89 48 18          	mov    QWORD PTR [rax+0x18],rcx
 f27:	48 8b 4a 20          	mov    rcx,QWORD PTR [rdx+0x20]
 f2b:	48 89 48 20          	mov    QWORD PTR [rax+0x20],rcx
 f2f:	48 8b 4a 28          	mov    rcx,QWORD PTR [rdx+0x28]
 f33:	48 89 48 28          	mov    QWORD PTR [rax+0x28],rcx
 f37:	48 8b 52 30          	mov    rdx,QWORD PTR [rdx+0x30]
 f3b:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		/* now change the desc for the aggregate heap */
		h->heap_base = nm;
 f3f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 f43:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
 f47:	48 89 10             	mov    QWORD PTR [rax],rdx
		h->heap_ptr = h->heap_limit = h2;
 f4a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 f4e:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
 f52:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
 f56:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 f5a:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
 f5e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 f62:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		h->heap_commit = h2->heap_commit + ((struct h_heap*)nm)->heap_commit;
 f66:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 f6a:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
 f6e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 f72:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 f76:	48 01 c2             	add    rdx,rax
 f79:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 f7d:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
		h->flags = 1;
 f81:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 f85:	8b 50 30             	mov    edx,DWORD PTR [rax+0x30]
 f88:	81 e2 00 00 00 80    	and    edx,0x80000000
 f8e:	83 ca 01             	or     edx,0x1
 f91:	89 50 30             	mov    DWORD PTR [rax+0x30],edx
		h->desc_in_heap = 0;
 f94:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 f98:	0f b6 50 33          	movzx  edx,BYTE PTR [rax+0x33]
 f9c:	83 e2 7f             	and    edx,0x7f
 f9f:	88 50 33             	mov    BYTE PTR [rax+0x33],dl
		h->heap_decommit = NULL; /* don't decommit the aggregate */
 fa2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 fa6:	48 c7 40 28 00 00 00 00 	mov    QWORD PTR [rax+0x28],0x0
		return 4096 * page_ct - ((struct h_heap*)nm)->heap_commit;
 fae:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 fb2:	c1 e0 0c             	shl    eax,0xc
 fb5:	89 c2                	mov    edx,eax
 fb7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 fbb:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 fbf:	89 c1                	mov    ecx,eax
 fc1:	89 d0                	mov    eax,edx
 fc3:	29 c8                	sub    eax,ecx
}
 fc5:	c9                   	leave
 fc6:	c3                   	ret

0000000000000fc7 <h_generic_decommit>:

void h_generic_decommit(void* mem, size_t ct)
{
 fc7:	55                   	push   rbp
 fc8:	48 89 e5             	mov    rbp,rsp
 fcb:	48 83 ec 10          	sub    rsp,0x10
 fcf:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
 fd3:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		mm_free_vmem(&mm_kernel, mem, ct / 4096);
 fd7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 fdb:	48 c1 e8 0c          	shr    rax,0xc
 fdf:	48 89 c2             	mov    rdx,rax
 fe2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 fe6:	48 89 c6             	mov    rsi,rax
 fe9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 ff0:	e8 00 00 00 00       	call   ff5 <h_generic_decommit+0x2e>
}
 ff5:	90                   	nop
 ff6:	c9                   	leave
 ff7:	c3                   	ret
