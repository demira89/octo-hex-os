
mm/heap.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
void* kzalloc(size_t s)
{
		void* rv = kmalloc(s);
		if (!rv)
				return NULL;
		bzero(rv, s);
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 10             	sub    esp,0x10
		return rv;
   6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
}
   c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax

  12:	eb 17                	jmp    2b <memcpy+0x2b>
void kfree(void* ptr)
  14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
  17:	8d 42 01             	lea    eax,[edx+0x1]
  1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
  1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
  20:	8d 48 01             	lea    ecx,[eax+0x1]
  23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
  26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
  29:	88 10                	mov    BYTE PTR [eax],dl

  2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
  2e:	8d 50 ff             	lea    edx,[eax-0x1]
  31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
  34:	85 c0                	test   eax,eax
  36:	75 dc                	jne    14 <memcpy+0x14>
{
  38:	90                   	nop
  39:	90                   	nop
  3a:	c9                   	leave
  3b:	c3                   	ret

0000003c <init_kernel_heap>:
{
  3c:	55                   	push   ebp
  3d:	89 e5                	mov    ebp,esp
  3f:	53                   	push   ebx
  40:	83 ec 24             	sub    esp,0x24
		size_t ct = 1024; void* hp;
  43:	c7 45 f4 00 04 00 00 	mov    DWORD PTR [ebp-0xc],0x400
		if (pm_count / 4096 / 16 < ct) /* restrict to 1/16 of all memory */
  4a:	a1 00 00 00 00       	mov    eax,ds:0x0
  4f:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
  55:	0f ac d0 10          	shrd   eax,edx,0x10
  59:	c1 ea 10             	shr    edx,0x10
  5c:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
  5f:	bb 00 00 00 00       	mov    ebx,0x0
  64:	39 c8                	cmp    eax,ecx
  66:	89 d0                	mov    eax,edx
  68:	19 d8                	sbb    eax,ebx
  6a:	73 15                	jae    81 <init_kernel_heap+0x45>
				ct = pm_count / 4096 / 16;
  6c:	a1 00 00 00 00       	mov    eax,ds:0x0
  71:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
  77:	0f ac d0 10          	shrd   eax,edx,0x10
  7b:	c1 ea 10             	shr    edx,0x10
  7e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		hp = mm_alloc_vmem(&mm_kernel, NULL, ct, /*MMGR_ALLOC_NP_AOA // no AOA for start
  81:	c7 44 24 0c 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0xc
  89:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  8c:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
  90:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
  98:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
  9f:	e8 fc ff ff ff       	call   a0 <init_kernel_heap+0x64>
  a4:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		h_kernel.heap_base = h_kernel.heap_ptr = hp;
  a7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  aa:	a3 04 00 00 00       	mov    ds:0x4,eax
  af:	a1 04 00 00 00       	mov    eax,ds:0x4
  b4:	a3 00 00 00 00       	mov    ds:0x0,eax
		h_kernel.heap_limit = hp + ct * 4096;
  b9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  bc:	c1 e0 0c             	shl    eax,0xc
  bf:	89 c2                	mov    edx,eax
  c1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  c4:	01 d0                	add    eax,edx
  c6:	a3 08 00 00 00       	mov    ds:0x8,eax
}
  cb:	90                   	nop
  cc:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
  cf:	c9                   	leave
  d0:	c3                   	ret

000000d1 <is_empty>:
int is_empty(struct heap_entry* he) { return ((char*)he->next - he->s - sizeof(struct heap_entry)) == (char*)he; }
  d1:	55                   	push   ebp
  d2:	89 e5                	mov    ebp,esp
  d4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  d7:	8b 10                	mov    edx,DWORD PTR [eax]
  d9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  dc:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
  df:	b9 f8 ff ff ff       	mov    ecx,0xfffffff8
  e4:	29 c1                	sub    ecx,eax
  e6:	8d 04 0a             	lea    eax,[edx+ecx*1]
  e9:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
  ec:	0f 94 c0             	sete   al
  ef:	0f b6 c0             	movzx  eax,al
  f2:	5d                   	pop    ebp
  f3:	c3                   	ret

000000f4 <h_dump>:
{
  f4:	55                   	push   ebp
  f5:	89 e5                	mov    ebp,esp
  f7:	83 ec 28             	sub    esp,0x28
		struct h_heap* h = (struct h_heap*)hp;
  fa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  fd:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (h->flags == 1) { /* aggregate so dump twice */
 100:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 103:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 106:	25 ff ff ff 7f       	and    eax,0x7fffffff
 10b:	83 f8 01             	cmp    eax,0x1
 10e:	75 3c                	jne    14c <h_dump+0x58>
				printf("dumping aggreate heap consisting of heaps at:\n%p and %p",
 110:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 113:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 116:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 119:	8b 00                	mov    eax,DWORD PTR [eax]
 11b:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 11f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 123:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 12a:	e8 fc ff ff ff       	call   12b <h_dump+0x37>
				h_dump(h->heap_base);
 12f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 132:	8b 00                	mov    eax,DWORD PTR [eax]
 134:	89 04 24             	mov    DWORD PTR [esp],eax
 137:	e8 fc ff ff ff       	call   138 <h_dump+0x44>
				h_dump(h->heap_ptr);
 13c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 13f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 142:	89 04 24             	mov    DWORD PTR [esp],eax
 145:	e8 fc ff ff ff       	call   146 <h_dump+0x52>
}
 14a:	eb 5c                	jmp    1a8 <h_dump+0xb4>
				struct heap_entry* he = (struct heap_entry*)h->heap_base;
 14c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 14f:	8b 00                	mov    eax,DWORD PTR [eax]
 151:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				printf("dumping heap at %p with limit %p and ptr=%p\n",
 154:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 157:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
 15a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 15d:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 160:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 163:	8b 00                	mov    eax,DWORD PTR [eax]
 165:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
 169:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 16d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 171:	c7 04 24 38 00 00 00 	mov    DWORD PTR [esp],0x38
 178:	e8 fc ff ff ff       	call   179 <h_dump+0x85>
						printf("entry at %p with size %u\n", he, he->s);
 17d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 180:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 183:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 187:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 18a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 18e:	c7 04 24 65 00 00 00 	mov    DWORD PTR [esp],0x65
 195:	e8 fc ff ff ff       	call   196 <h_dump+0xa2>
				} while ((he = he->next));
 19a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 19d:	8b 00                	mov    eax,DWORD PTR [eax]
 19f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
 1a2:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 1a6:	75 d5                	jne    17d <h_dump+0x89>
}
 1a8:	90                   	nop
 1a9:	c9                   	leave
 1aa:	c3                   	ret

000001ab <h_malloc>:
{
 1ab:	55                   	push   ebp
 1ac:	89 e5                	mov    ebp,esp
 1ae:	83 ec 38             	sub    esp,0x38
		struct h_heap* h = (struct h_heap*)hpp;
 1b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 1b4:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (h->flags == 1) { /* we're on an aggregate heap */
 1b7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 1ba:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 1bd:	25 ff ff ff 7f       	and    eax,0x7fffffff
 1c2:	83 f8 01             	cmp    eax,0x1
 1c5:	74 06                	je     1cd <h_malloc+0x22>
Pos1:
 1c7:	90                   	nop
 1c8:	e9 9f 00 00 00       	jmp    26c <h_malloc+0xc1>
				void* rv = NULL;
 1cd:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
				rv = h_malloc(h->heap_limit, s);
 1d4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 1d7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 1da:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 1dd:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 1e1:	89 04 24             	mov    DWORD PTR [esp],eax
 1e4:	e8 fc ff ff ff       	call   1e5 <h_malloc+0x3a>
 1e9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (!rv) {
 1ec:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 1f0:	75 55                	jne    247 <h_malloc+0x9c>
						rv = h_malloc(h->heap_base, s);
 1f2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 1f5:	8b 00                	mov    eax,DWORD PTR [eax]
 1f7:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 1fa:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 1fe:	89 04 24             	mov    DWORD PTR [esp],eax
 201:	e8 fc ff ff ff       	call   202 <h_malloc+0x57>
 206:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						if (!rv) { /* call the OOM handler (i.e. add another aggregation level) */
 209:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 20d:	75 38                	jne    247 <h_malloc+0x9c>
								if (!h->heap_oom_handler(hpp, s))
 20f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 212:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 215:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 218:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 21c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 21f:	89 14 24             	mov    DWORD PTR [esp],edx
 222:	ff d0                	call   eax
 224:	85 c0                	test   eax,eax
 226:	75 0a                	jne    232 <h_malloc+0x87>
										return NULL;
 228:	b8 00 00 00 00       	mov    eax,0x0
 22d:	e9 aa 02 00 00       	jmp    4dc <h_malloc+0x331>
										rv = h_malloc(hpp, s);
 232:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 235:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 239:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 23c:	89 04 24             	mov    DWORD PTR [esp],eax
 23f:	e8 fc ff ff ff       	call   240 <h_malloc+0x95>
 244:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				h->heap_commit = ((struct h_heap*)h->heap_base)->heap_commit
 247:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 24a:	8b 00                	mov    eax,DWORD PTR [eax]
 24c:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
						+ ((struct h_heap*)h->heap_ptr)->heap_commit;
 24f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 252:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 255:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 258:	01 c2                	add    edx,eax
				h->heap_commit = ((struct h_heap*)h->heap_base)->heap_commit
 25a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 25d:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
				return rv;
 260:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 263:	e9 74 02 00 00       	jmp    4dc <h_malloc+0x331>
					goto Pos1;
 268:	90                   	nop
 269:	eb 01                	jmp    26c <h_malloc+0xc1>
					goto Pos1;
 26b:	90                   	nop
		hp = (struct heap_entry*)h->heap_base;
 26c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 26f:	8b 00                	mov    eax,DWORD PTR [eax]
 271:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rem = (char*)h->heap_limit - (char*)h->heap_ptr;
 274:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 277:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 27a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 27d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 280:	29 c2                	sub    edx,eax
 282:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
		if (rem > s + sizeof(struct heap_entry)) { /* easy, lock free */
 285:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 288:	83 c0 08             	add    eax,0x8
 28b:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
 28e:	73 6d                	jae    2fd <h_malloc+0x152>
			hp = (struct heap_entry*)h->heap_ptr;
 290:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 293:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 296:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
			if (rem != (size_t)((char*)h->heap_limit - (char*)hp))
 299:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 29c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 29f:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
 2a2:	89 c2                	mov    edx,eax
 2a4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 2a7:	39 c2                	cmp    edx,eax
 2a9:	75 bd                	jne    268 <h_malloc+0xbd>
			if (!__sync_bool_compare_and_swap(&h->heap_ptr, hp, (char*)h->heap_ptr + s + sizeof(struct heap_entry)))
 2ab:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 2ae:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 2b1:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 2b4:	83 c2 08             	add    edx,0x8
 2b7:	01 d0                	add    eax,edx
 2b9:	89 c1                	mov    ecx,eax
 2bb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 2be:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 2c1:	83 c2 04             	add    edx,0x4
 2c4:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
 2c8:	0f 94 c0             	sete   al
 2cb:	83 f0 01             	xor    eax,0x1
 2ce:	84 c0                	test   al,al
 2d0:	75 99                	jne    26b <h_malloc+0xc0>
			hp->s = s;
 2d2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 2d5:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 2d8:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
			hp->next = h->heap_ptr;
 2db:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 2de:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 2e1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 2e4:	89 10                	mov    DWORD PTR [eax],edx
			__sync_add_and_fetch(&h->heap_commit, s);
 2e6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 2e9:	8d 50 0c             	lea    edx,[eax+0xc]
 2ec:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 2ef:	f0 01 02             	lock add DWORD PTR [edx],eax
			return hp + 1;
 2f2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 2f5:	83 c0 08             	add    eax,0x8
 2f8:	e9 df 01 00 00       	jmp    4dc <h_malloc+0x331>
				size_t fs_prev = 0; struct heap_entry* hp_p = 0;
 2fd:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 304:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
				while ((void*)hp < h->heap_ptr) {
 30b:	e9 6c 01 00 00       	jmp    47c <h_malloc+0x2d1>
						fs = (char*)hp->next - (char*)hp - hp->s - sizeof(struct heap_entry);
 310:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 313:	8b 00                	mov    eax,DWORD PTR [eax]
 315:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
 318:	89 c2                	mov    edx,eax
 31a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 31d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 320:	29 c2                	sub    edx,eax
 322:	8d 42 f8             	lea    eax,[edx-0x8]
 325:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						if (fs == 0) { /* full entry */
 328:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
 32c:	75 1a                	jne    348 <h_malloc+0x19d>
								fs_prev = 0; hp_p = hp;
 32e:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 335:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 338:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								hp = hp->next;
 33b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 33e:	8b 00                	mov    eax,DWORD PTR [eax]
 340:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 343:	e9 34 01 00 00       	jmp    47c <h_malloc+0x2d1>
						} else if (fs >= s + sizeof(struct heap_entry)) { /* reuse single (deleted?) space */
 348:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 34b:	83 c0 08             	add    eax,0x8
 34e:	39 45 dc             	cmp    DWORD PTR [ebp-0x24],eax
 351:	72 7d                	jb     3d0 <h_malloc+0x225>
								if (is_empty(hp)) {
 353:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 356:	89 04 24             	mov    DWORD PTR [esp],eax
 359:	e8 fc ff ff ff       	call   35a <h_malloc+0x1af>
 35e:	85 c0                	test   eax,eax
 360:	74 25                	je     387 <h_malloc+0x1dc>
										hp->s = s;
 362:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 365:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 368:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										h->heap_commit += s;
 36b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 36e:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 371:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 374:	01 c2                	add    edx,eax
 376:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 379:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
										return hp + 1;
 37c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 37f:	83 c0 08             	add    eax,0x8
 382:	e9 55 01 00 00       	jmp    4dc <h_malloc+0x331>
										hp_p = hp;
 387:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 38a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										hp = (struct heap_entry*)((char*)(hp + 1) + hp->s);
 38d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 390:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 393:	83 c0 08             	add    eax,0x8
 396:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
										hp->s = s;
 399:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 39c:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 39f:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										hp->next = hp_p->next;
 3a2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 3a5:	8b 10                	mov    edx,DWORD PTR [eax]
 3a7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 3aa:	89 10                	mov    DWORD PTR [eax],edx
										hp_p->next = hp;
 3ac:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 3af:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 3b2:	89 10                	mov    DWORD PTR [eax],edx
										h->heap_commit += s;
 3b4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 3b7:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 3ba:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 3bd:	01 c2                	add    edx,eax
 3bf:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 3c2:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
										return hp + 1;
 3c5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 3c8:	83 c0 08             	add    eax,0x8
 3cb:	e9 0c 01 00 00       	jmp    4dc <h_malloc+0x331>
						} else if (fs == hp->s) { /* remove completly freed space */
 3d0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 3d3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 3d6:	39 45 dc             	cmp    DWORD PTR [ebp-0x24],eax
 3d9:	0f 85 89 00 00 00    	jne    468 <h_malloc+0x2bd>
								if (hp_p) { /* combine entries */
 3df:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
 3e3:	74 75                	je     45a <h_malloc+0x2af>
										hp_p->next = hp->next;
 3e5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 3e8:	8b 10                	mov    edx,DWORD PTR [eax]
 3ea:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 3ed:	89 10                	mov    DWORD PTR [eax],edx
										fs_prev += fs + sizeof(struct heap_entry);
 3ef:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 3f2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 3f5:	01 d0                	add    eax,edx
 3f7:	83 c0 08             	add    eax,0x8
 3fa:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
										if (fs_prev >= s + sizeof(struct heap_entry)) { /* found sth */
 3fd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 400:	83 c0 08             	add    eax,0x8
 403:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
 406:	72 48                	jb     450 <h_malloc+0x2a5>
												hp = (struct heap_entry*)((char*)(hp_p + 1) + hp_p->s);
 408:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 40b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 40e:	8d 50 08             	lea    edx,[eax+0x8]
 411:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 414:	01 d0                	add    eax,edx
 416:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
												hp->s = s;
 419:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 41c:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 41f:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
												hp->next = hp_p->next;
 422:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 425:	8b 10                	mov    edx,DWORD PTR [eax]
 427:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 42a:	89 10                	mov    DWORD PTR [eax],edx
												hp_p->next = hp;
 42c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 42f:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 432:	89 10                	mov    DWORD PTR [eax],edx
												h->heap_commit += s;
 434:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 437:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 43a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 43d:	01 c2                	add    edx,eax
 43f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 442:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
												return hp + 1;
 445:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 448:	83 c0 08             	add    eax,0x8
 44b:	e9 8c 00 00 00       	jmp    4dc <h_malloc+0x331>
												hp = (struct heap_entry*)hp->next;
 450:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 453:	8b 00                	mov    eax,DWORD PTR [eax]
 455:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 458:	eb 22                	jmp    47c <h_malloc+0x2d1>
										fs_prev = fs;
 45a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 45d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
										hp_p = hp;
 460:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 463:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 466:	eb 14                	jmp    47c <h_malloc+0x2d1>
								fs_prev = fs;
 468:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 46b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								hp_p = hp;
 46e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 471:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								hp = (struct heap_entry*)hp->next;
 474:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 477:	8b 00                	mov    eax,DWORD PTR [eax]
 479:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				while ((void*)hp < h->heap_ptr) {
 47c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 47f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 482:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
 485:	0f 82 85 fe ff ff    	jb     310 <h_malloc+0x165>
				if (h->heap_oom_handler)
 48b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 48e:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 491:	85 c0                	test   eax,eax
 493:	74 2d                	je     4c2 <h_malloc+0x317>
						if (h->heap_oom_handler(hpp, s))
 495:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 498:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 49b:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 49e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 4a2:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 4a5:	89 14 24             	mov    DWORD PTR [esp],edx
 4a8:	ff d0                	call   eax
 4aa:	85 c0                	test   eax,eax
 4ac:	74 14                	je     4c2 <h_malloc+0x317>
								return h_malloc(hpp, s);
 4ae:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 4b1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 4b5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 4b8:	89 04 24             	mov    DWORD PTR [esp],eax
 4bb:	e8 fc ff ff ff       	call   4bc <h_malloc+0x311>
 4c0:	eb 1a                	jmp    4dc <h_malloc+0x331>
				printf("Out of heap memory\nIdling for debug\n");
 4c2:	c7 04 24 80 00 00 00 	mov    DWORD PTR [esp],0x80
 4c9:	e8 fc ff ff ff       	call   4ca <h_malloc+0x31f>
				h_dump(hpp);
 4ce:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 4d1:	89 04 24             	mov    DWORD PTR [esp],eax
 4d4:	e8 fc ff ff ff       	call   4d5 <h_malloc+0x32a>
				while (1);
 4d9:	90                   	nop
 4da:	eb fd                	jmp    4d9 <h_malloc+0x32e>
}
 4dc:	c9                   	leave
 4dd:	c3                   	ret

000004de <h_free>:
{
 4de:	55                   	push   ebp
 4df:	89 e5                	mov    ebp,esp
 4e1:	83 ec 28             	sub    esp,0x28
		struct h_heap* h = (struct h_heap*)hp;
 4e4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 4e7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if(h->flags == 1) { /* free on aggregate heap (i.e. everywhere) */
 4ea:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 4ed:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 4f0:	25 ff ff ff 7f       	and    eax,0x7fffffff
 4f5:	83 f8 01             	cmp    eax,0x1
 4f8:	75 2b                	jne    525 <h_free+0x47>
				h_free(h->heap_base, ptr);
 4fa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 4fd:	8b 00                	mov    eax,DWORD PTR [eax]
 4ff:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 502:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 506:	89 04 24             	mov    DWORD PTR [esp],eax
 509:	e8 fc ff ff ff       	call   50a <h_free+0x2c>
				h_free(h->heap_ptr, ptr);
 50e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 511:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 514:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 517:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 51b:	89 04 24             	mov    DWORD PTR [esp],eax
 51e:	e8 fc ff ff ff       	call   51f <h_free+0x41>
				return;
 523:	eb 34                	jmp    559 <h_free+0x7b>
		if (ptr >= h->heap_base && ptr <= h->heap_limit) {
 525:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 528:	8b 00                	mov    eax,DWORD PTR [eax]
 52a:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
 52d:	72 2a                	jb     559 <h_free+0x7b>
 52f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 532:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 535:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
 538:	72 1f                	jb     559 <h_free+0x7b>
				__sync_sub_and_fetch(&h->heap_commit, ((struct heap_entry*)ptr - 1)->s);
 53a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 53d:	83 e8 08             	sub    eax,0x8
 540:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 543:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 546:	83 c2 0c             	add    edx,0xc
 549:	f0 29 02             	lock sub DWORD PTR [edx],eax
				((struct heap_entry*)ptr - 1)->s = 0;
 54c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 54f:	83 e8 08             	sub    eax,0x8
 552:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
}
 559:	c9                   	leave
 55a:	c3                   	ret

0000055b <h_realloc>:
{
 55b:	55                   	push   ebp
 55c:	89 e5                	mov    ebp,esp
 55e:	83 ec 38             	sub    esp,0x38
		if (ptr) {
 561:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
 565:	0f 84 a2 02 00 00    	je     80d <h_realloc+0x2b2>
				struct h_heap* h = (struct h_heap*)hp;
 56b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 56e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (h->flags == 1) { /* do an aggregate realloc (i.e. everywhere) */
 571:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 574:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 577:	25 ff ff ff 7f       	and    eax,0x7fffffff
 57c:	83 f8 01             	cmp    eax,0x1
 57f:	0f 85 94 00 00 00    	jne    619 <h_realloc+0xbe>
						void* rv = NULL;
 585:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
						rv = h_realloc(h->heap_base, ptr, s);
 58c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 58f:	8b 00                	mov    eax,DWORD PTR [eax]
 591:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 594:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 598:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 59b:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 59f:	89 04 24             	mov    DWORD PTR [esp],eax
 5a2:	e8 fc ff ff ff       	call   5a3 <h_realloc+0x48>
 5a7:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						if (!rv)
 5aa:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 5ae:	75 1c                	jne    5cc <h_realloc+0x71>
								h_realloc(h->heap_ptr, ptr, s);
 5b0:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 5b3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 5b6:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 5b9:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 5bd:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 5c0:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 5c4:	89 04 24             	mov    DWORD PTR [esp],eax
 5c7:	e8 fc ff ff ff       	call   5c8 <h_realloc+0x6d>
						if (!rv) { /* call the OOM handler (i.e. add another aggregation level) */
 5cc:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 5d0:	75 3f                	jne    611 <h_realloc+0xb6>
								if (!h->heap_oom_handler(hp, s))
 5d2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 5d5:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 5d8:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 5db:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 5df:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 5e2:	89 14 24             	mov    DWORD PTR [esp],edx
 5e5:	ff d0                	call   eax
 5e7:	85 c0                	test   eax,eax
 5e9:	75 0a                	jne    5f5 <h_realloc+0x9a>
										return NULL;
 5eb:	b8 00 00 00 00       	mov    eax,0x0
 5f0:	e9 2a 02 00 00       	jmp    81f <h_realloc+0x2c4>
										rv = h_realloc(hp, ptr, s);
 5f5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 5f8:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 5fc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 5ff:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 603:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 606:	89 04 24             	mov    DWORD PTR [esp],eax
 609:	e8 fc ff ff ff       	call   60a <h_realloc+0xaf>
 60e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						return rv;
 611:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 614:	e9 06 02 00 00       	jmp    81f <h_realloc+0x2c4>
				if (ptr < h->heap_base || ptr > h->heap_limit)
 619:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 61c:	8b 00                	mov    eax,DWORD PTR [eax]
 61e:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
 621:	72 0b                	jb     62e <h_realloc+0xd3>
 623:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 626:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 629:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
 62c:	73 0a                	jae    638 <h_realloc+0xdd>
						return NULL;
 62e:	b8 00 00 00 00       	mov    eax,0x0
 633:	e9 e7 01 00 00       	jmp    81f <h_realloc+0x2c4>
				struct heap_entry* hp = (struct heap_entry*)(ptr) - 1, *hp2;
 638:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 63b:	83 e8 08             	sub    eax,0x8
 63e:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				size_t fs = 0, oldS = hp->s;
 641:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 648:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 64b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 64e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				if (s <= hp->s) { /* shrink */
 651:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 654:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 657:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
 65a:	72 25                	jb     681 <h_realloc+0x126>
						h->heap_commit -= oldS - s;
 65c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 65f:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 662:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 665:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
 668:	01 c2                	add    edx,eax
 66a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 66d:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
						hp->s = s;
 670:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 673:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 676:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						return ptr;
 679:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 67c:	e9 9e 01 00 00       	jmp    81f <h_realloc+0x2c4>
				hp2 = hp->next;
 681:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 684:	8b 00                	mov    eax,DWORD PTR [eax]
 686:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				while ((char*)hp2 < (char*)h->heap_ptr) {
 689:	e9 ba 00 00 00       	jmp    748 <h_realloc+0x1ed>
						if (is_empty(hp2)) {
 68e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 691:	89 04 24             	mov    DWORD PTR [esp],eax
 694:	e8 fc ff ff ff       	call   695 <h_realloc+0x13a>
 699:	85 c0                	test   eax,eax
 69b:	74 5a                	je     6f7 <h_realloc+0x19c>
								fs += hp2->s + sizeof(struct heap_entry);
 69d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 6a0:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 6a3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 6a6:	01 d0                	add    eax,edx
 6a8:	83 c0 08             	add    eax,0x8
 6ab:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								hp->next = hp2->next;
 6ae:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 6b1:	8b 10                	mov    edx,DWORD PTR [eax]
 6b3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 6b6:	89 10                	mov    DWORD PTR [eax],edx
								if (hp->s + fs >= s) { /* found enough space*/
 6b8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 6bb:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 6be:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 6c1:	01 d0                	add    eax,edx
 6c3:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
 6c6:	72 25                	jb     6ed <h_realloc+0x192>
										h->heap_commit += s - oldS;
 6c8:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 6cb:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 6ce:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 6d1:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
 6d4:	01 c2                	add    edx,eax
 6d6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 6d9:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
										hp->s = s;
 6dc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 6df:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 6e2:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										return ptr;
 6e5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 6e8:	e9 32 01 00 00       	jmp    81f <h_realloc+0x2c4>
										hp2 = (struct heap_entry*)hp2->next;
 6ed:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 6f0:	8b 00                	mov    eax,DWORD PTR [eax]
 6f2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 6f5:	eb 51                	jmp    748 <h_realloc+0x1ed>
								void* rv = h_malloc(hp, s);
 6f7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 6fa:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 6fe:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 701:	89 04 24             	mov    DWORD PTR [esp],eax
 704:	e8 fc ff ff ff       	call   705 <h_realloc+0x1aa>
 709:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
								if(rv) {
 70c:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
 710:	74 2e                	je     740 <h_realloc+0x1e5>
										memcpy(rv, ptr, hp->s);
 712:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 715:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 718:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 71c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 71f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 723:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 726:	89 04 24             	mov    DWORD PTR [esp],eax
 729:	e8 d2 f8 ff ff       	call   0 <memcpy>
										h_free(hp, ptr);
 72e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 731:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 735:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 738:	89 04 24             	mov    DWORD PTR [esp],eax
 73b:	e8 fc ff ff ff       	call   73c <h_realloc+0x1e1>
								return rv;
 740:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 743:	e9 d7 00 00 00       	jmp    81f <h_realloc+0x2c4>
				while ((char*)hp2 < (char*)h->heap_ptr) {
 748:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 74b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 74e:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
 751:	0f 82 37 ff ff ff    	jb     68e <h_realloc+0x133>
				fs += (char*)h->heap_limit - (char*)h->heap_ptr;
 757:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 75a:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 75d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 760:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 763:	29 c2                	sub    edx,eax
 765:	89 d0                	mov    eax,edx
 767:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
				if (fs + hp->s >= s) {
 76a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 76d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 770:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 773:	01 d0                	add    eax,edx
 775:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
 778:	72 3b                	jb     7b5 <h_realloc+0x25a>
						h->heap_ptr = (char*)h->heap_ptr + s - hp->s;
 77a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 77d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 780:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 783:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 786:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
 789:	29 c1                	sub    ecx,eax
 78b:	01 ca                	add    edx,ecx
 78d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 790:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						h->heap_commit += s - oldS;
 793:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 796:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 799:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 79c:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
 79f:	01 c2                	add    edx,eax
 7a1:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 7a4:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
						hp->s = s;
 7a7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 7aa:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 7ad:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						return ptr;
 7b0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 7b3:	eb 6a                	jmp    81f <h_realloc+0x2c4>
				if (h->heap_oom_handler)
 7b5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 7b8:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 7bb:	85 c0                	test   eax,eax
 7bd:	74 34                	je     7f3 <h_realloc+0x298>
						if (h->heap_oom_handler(hp, s))
 7bf:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 7c2:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 7c5:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 7c8:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 7cc:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 7cf:	89 14 24             	mov    DWORD PTR [esp],edx
 7d2:	ff d0                	call   eax
 7d4:	85 c0                	test   eax,eax
 7d6:	74 1b                	je     7f3 <h_realloc+0x298>
								return h_realloc(hp, ptr, s);
 7d8:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 7db:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 7df:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 7e2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 7e6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 7e9:	89 04 24             	mov    DWORD PTR [esp],eax
 7ec:	e8 fc ff ff ff       	call   7ed <h_realloc+0x292>
 7f1:	eb 2c                	jmp    81f <h_realloc+0x2c4>
				printf("Out of heap memory\nIdling for debug\n");
 7f3:	c7 04 24 80 00 00 00 	mov    DWORD PTR [esp],0x80
 7fa:	e8 fc ff ff ff       	call   7fb <h_realloc+0x2a0>
				h_dump(hp);
 7ff:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 802:	89 04 24             	mov    DWORD PTR [esp],eax
 805:	e8 fc ff ff ff       	call   806 <h_realloc+0x2ab>
				while (1);
 80a:	90                   	nop
 80b:	eb fd                	jmp    80a <h_realloc+0x2af>
				return h_malloc(hp, s);
 80d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 810:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 814:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 817:	89 04 24             	mov    DWORD PTR [esp],eax
 81a:	e8 fc ff ff ff       	call   81b <h_realloc+0x2c0>
}
 81f:	c9                   	leave
 820:	c3                   	ret

00000821 <h_create_heap>:
{
 821:	55                   	push   ebp
 822:	89 e5                	mov    ebp,esp
 824:	83 ec 10             	sub    esp,0x10
		struct h_heap* h = (struct h_heap*)mem;
 827:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 82a:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (ct < sizeof(struct h_heap) + sizeof(struct heap_entry))
 82d:	83 7d 0c 23          	cmp    DWORD PTR [ebp+0xc],0x23
 831:	77 07                	ja     83a <h_create_heap+0x19>
				return NULL; /* don't allocate noviable heaps */
 833:	b8 00 00 00 00       	mov    eax,0x0
 838:	eb 5f                	jmp    899 <h_create_heap+0x78>
		h->desc_in_heap = 1; /* we're using part of mem */
 83a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 83d:	0f b6 50 1b          	movzx  edx,BYTE PTR [eax+0x1b]
 841:	83 ca 80             	or     edx,0xffffff80
 844:	88 50 1b             	mov    BYTE PTR [eax+0x1b],dl
		h->flags = 0; /* non-aggregate */
 847:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 84a:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 84d:	81 e2 00 00 00 80    	and    edx,0x80000000
 853:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		h->heap_base = mem + sizeof(struct h_heap);
 856:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 859:	8d 50 1c             	lea    edx,[eax+0x1c]
 85c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 85f:	89 10                	mov    DWORD PTR [eax],edx
		h->heap_limit = mem + ct;
 861:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 864:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 867:	01 c2                	add    edx,eax
 869:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 86c:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		h->heap_ptr = h->heap_base;
 86f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 872:	8b 10                	mov    edx,DWORD PTR [eax]
 874:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 877:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		h->heap_commit = 0;
 87a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 87d:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		h->heap_decommit = hdc;
 884:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 887:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
 88a:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		h->heap_oom_handler = hdlr;
 88d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 890:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 893:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		return mem;
 896:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
}
 899:	c9                   	leave
 89a:	c3                   	ret

0000089b <h_destroy>:
{
 89b:	55                   	push   ebp
 89c:	89 e5                	mov    ebp,esp
 89e:	83 ec 28             	sub    esp,0x28
		struct h_heap* h = (struct h_heap*)hp;
 8a1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 8a4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (h->flags == 1) { /* destroy both heaps */
 8a7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8aa:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 8ad:	25 ff ff ff 7f       	and    eax,0x7fffffff
 8b2:	83 f8 01             	cmp    eax,0x1
 8b5:	75 1d                	jne    8d4 <h_destroy+0x39>
				h_destroy(h->heap_base);
 8b7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8ba:	8b 00                	mov    eax,DWORD PTR [eax]
 8bc:	89 04 24             	mov    DWORD PTR [esp],eax
 8bf:	e8 fc ff ff ff       	call   8c0 <h_destroy+0x25>
				h_destroy(h->heap_ptr);
 8c4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8c7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 8ca:	89 04 24             	mov    DWORD PTR [esp],eax
 8cd:	e8 fc ff ff ff       	call   8ce <h_destroy+0x33>
				return;
 8d2:	eb 48                	jmp    91c <h_destroy+0x81>
		struct heap_entry* he = (struct heap_entry*)h->heap_base;
 8d4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8d7:	8b 00                	mov    eax,DWORD PTR [eax]
 8d9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		he->s = 0;
 8dc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 8df:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
		he->next = h->heap_limit;
 8e6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8e9:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 8ec:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 8ef:	89 10                	mov    DWORD PTR [eax],edx
		if (h->heap_decommit)
 8f1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8f4:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
 8f7:	85 c0                	test   eax,eax
 8f9:	74 21                	je     91c <h_destroy+0x81>
				h->heap_decommit(h->heap_base, h->heap_limit - h->heap_base);
 8fb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8fe:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
 901:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 904:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
 907:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 90a:	8b 12                	mov    edx,DWORD PTR [edx]
 90c:	29 d1                	sub    ecx,edx
 90e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 911:	8b 12                	mov    edx,DWORD PTR [edx]
 913:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
 917:	89 14 24             	mov    DWORD PTR [esp],edx
 91a:	ff d0                	call   eax
}
 91c:	c9                   	leave
 91d:	c3                   	ret

0000091e <kmalloc>:
{
 91e:	55                   	push   ebp
 91f:	89 e5                	mov    ebp,esp
 921:	83 ec 28             	sub    esp,0x28
		void* rv = h_malloc(&h_kernel, s + 2 * KGUARD_SIZE);
 924:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 927:	83 c0 10             	add    eax,0x10
 92a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 92e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 935:	e8 fc ff ff ff       	call   936 <kmalloc+0x18>
 93a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (!rv)
 93d:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
 941:	75 07                	jne    94a <kmalloc+0x2c>
				return NULL;
 943:	b8 00 00 00 00       	mov    eax,0x0
 948:	eb 48                	jmp    992 <kmalloc+0x74>
		p1 = rv;
 94a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 94d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		p2 = rv + s + 2 * KGUARD_SIZE;
 950:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 953:	8d 50 10             	lea    edx,[eax+0x10]
 956:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 959:	01 d0                	add    eax,edx
 95b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 95e:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 965:	eb 1f                	jmp    986 <kmalloc+0x68>
				*p1++ = *--p2 = 0xcb;
 967:	83 6d f0 01          	sub    DWORD PTR [ebp-0x10],0x1
 96b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 96e:	c6 00 cb             	mov    BYTE PTR [eax],0xcb
 971:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 974:	8d 50 01             	lea    edx,[eax+0x1]
 977:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
 97a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 97d:	0f b6 12             	movzx  edx,BYTE PTR [edx]
 980:	88 10                	mov    BYTE PTR [eax],dl
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 982:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
 986:	83 7d ec 07          	cmp    DWORD PTR [ebp-0x14],0x7
 98a:	76 db                	jbe    967 <kmalloc+0x49>
		return rv + KGUARD_SIZE;
 98c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 98f:	83 c0 08             	add    eax,0x8
}
 992:	c9                   	leave
 993:	c3                   	ret

00000994 <kzalloc>:
{
 994:	55                   	push   ebp
 995:	89 e5                	mov    ebp,esp
 997:	83 ec 28             	sub    esp,0x28
		void* rv = kmalloc(s);
 99a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 99d:	89 04 24             	mov    DWORD PTR [esp],eax
 9a0:	e8 fc ff ff ff       	call   9a1 <kzalloc+0xd>
 9a5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv)
 9a8:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 9ac:	75 07                	jne    9b5 <kzalloc+0x21>
				return NULL;
 9ae:	b8 00 00 00 00       	mov    eax,0x0
 9b3:	eb 15                	jmp    9ca <kzalloc+0x36>
		bzero(rv, s);
 9b5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 9b8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 9bc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 9bf:	89 04 24             	mov    DWORD PTR [esp],eax
 9c2:	e8 fc ff ff ff       	call   9c3 <kzalloc+0x2f>
		return rv;
 9c7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
 9ca:	c9                   	leave
 9cb:	c3                   	ret

000009cc <kfree>:
{
 9cc:	55                   	push   ebp
 9cd:	89 e5                	mov    ebp,esp
 9cf:	83 ec 18             	sub    esp,0x18
		h_free(&h_kernel, ptr - KGUARD_SIZE);
 9d2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 9d5:	83 e8 08             	sub    eax,0x8
 9d8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 9dc:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 9e3:	e8 fc ff ff ff       	call   9e4 <kfree+0x18>
}
 9e8:	90                   	nop
 9e9:	c9                   	leave
 9ea:	c3                   	ret

000009eb <krealloc>:

void* krealloc(void* ptr, size_t s)
{
 9eb:	55                   	push   ebp
 9ec:	89 e5                	mov    ebp,esp
 9ee:	83 ec 28             	sub    esp,0x28
		void* rv = h_realloc(&h_kernel, ptr - KGUARD_SIZE, s + 2 * KGUARD_SIZE);
 9f1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 9f4:	8d 50 10             	lea    edx,[eax+0x10]
 9f7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 9fa:	83 e8 08             	sub    eax,0x8
 9fd:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 a01:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 a05:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 a0c:	e8 fc ff ff ff       	call   a0d <krealloc+0x22>
 a11:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (!rv)
 a14:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 a18:	75 07                	jne    a21 <krealloc+0x36>
				return NULL;
 a1a:	b8 00 00 00 00       	mov    eax,0x0
 a1f:	eb 31                	jmp    a52 <krealloc+0x67>
		char* p2 = rv + s + 2 * KGUARD_SIZE;
 a21:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 a24:	8d 50 10             	lea    edx,[eax+0x10]
 a27:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a2a:	01 d0                	add    eax,edx
 a2c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 a2f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 a36:	eb 0e                	jmp    a46 <krealloc+0x5b>
				*--p2 = 0xcc;
 a38:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
 a3c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 a3f:	c6 00 cc             	mov    BYTE PTR [eax],0xcc
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 a42:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
 a46:	83 7d f0 07          	cmp    DWORD PTR [ebp-0x10],0x7
 a4a:	76 ec                	jbe    a38 <krealloc+0x4d>
		return rv + KGUARD_SIZE;
 a4c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a4f:	83 c0 08             	add    eax,0x8
}
 a52:	c9                   	leave
 a53:	c3                   	ret

00000a54 <kstats_impl>:

void kstats_impl(struct h_heap* h, size_t* s_total, size_t* s_commit, size_t* s_free, size_t* s_nheaps)
{
 a54:	55                   	push   ebp
 a55:	89 e5                	mov    ebp,esp
 a57:	83 ec 28             	sub    esp,0x28
		if (h->flags == 1) {
 a5a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 a5d:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 a60:	25 ff ff ff 7f       	and    eax,0x7fffffff
 a65:	83 f8 01             	cmp    eax,0x1
 a68:	75 55                	jne    abf <kstats_impl+0x6b>
				/* is aggregate */
				kstats_impl(h->heap_base, s_total, s_commit, s_free, s_nheaps);
 a6a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 a6d:	8b 00                	mov    eax,DWORD PTR [eax]
 a6f:	8b 55 18             	mov    edx,DWORD PTR [ebp+0x18]
 a72:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
 a76:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
 a79:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
 a7d:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 a80:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 a84:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 a87:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 a8b:	89 04 24             	mov    DWORD PTR [esp],eax
 a8e:	e8 fc ff ff ff       	call   a8f <kstats_impl+0x3b>
				kstats_impl(h->heap_ptr, s_total, s_commit, s_free, s_nheaps);
 a93:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 a96:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 a99:	8b 55 18             	mov    edx,DWORD PTR [ebp+0x18]
 a9c:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
 aa0:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
 aa3:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
 aa7:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 aaa:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 aae:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 ab1:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 ab5:	89 04 24             	mov    DWORD PTR [esp],eax
 ab8:	e8 fc ff ff ff       	call   ab9 <kstats_impl+0x65>
				return;
 abd:	eb 5b                	jmp    b1a <kstats_impl+0xc6>
		}

		/* we're on memory */
		*s_commit += h->heap_commit;
 abf:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 ac2:	8b 10                	mov    edx,DWORD PTR [eax]
 ac4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 ac7:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 aca:	01 c2                	add    edx,eax
 acc:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 acf:	89 10                	mov    DWORD PTR [eax],edx
		*s_total += h->heap_limit - h->heap_base;
 ad1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 ad4:	8b 10                	mov    edx,DWORD PTR [eax]
 ad6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 ad9:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
 adc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 adf:	8b 00                	mov    eax,DWORD PTR [eax]
 ae1:	29 c1                	sub    ecx,eax
 ae3:	89 c8                	mov    eax,ecx
 ae5:	01 c2                	add    edx,eax
 ae7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 aea:	89 10                	mov    DWORD PTR [eax],edx
		*s_free += (h->heap_limit - h->heap_base) - h->heap_commit;
 aec:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 aef:	8b 10                	mov    edx,DWORD PTR [eax]
 af1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 af4:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
 af7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 afa:	8b 00                	mov    eax,DWORD PTR [eax]
 afc:	29 c1                	sub    ecx,eax
 afe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b01:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 b04:	29 c1                	sub    ecx,eax
 b06:	01 ca                	add    edx,ecx
 b08:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 b0b:	89 10                	mov    DWORD PTR [eax],edx
		(*s_nheaps)++;
 b0d:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
 b10:	8b 00                	mov    eax,DWORD PTR [eax]
 b12:	8d 50 01             	lea    edx,[eax+0x1]
 b15:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
 b18:	89 10                	mov    DWORD PTR [eax],edx
}
 b1a:	c9                   	leave
 b1b:	c3                   	ret

00000b1c <kstats>:

void kstats(size_t* s_total, size_t* s_commit, size_t* s_free, size_t* s_nheaps)
{
 b1c:	55                   	push   ebp
 b1d:	89 e5                	mov    ebp,esp
 b1f:	83 ec 38             	sub    esp,0x38
		*s_total = *s_commit = *s_free = *s_nheaps = 0;
 b22:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 b25:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
 b2b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 b2e:	8b 10                	mov    edx,DWORD PTR [eax]
 b30:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 b33:	89 10                	mov    DWORD PTR [eax],edx
 b35:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 b38:	8b 10                	mov    edx,DWORD PTR [eax]
 b3a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 b3d:	89 10                	mov    DWORD PTR [eax],edx
 b3f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 b42:	8b 10                	mov    edx,DWORD PTR [eax]
 b44:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b47:	89 10                	mov    DWORD PTR [eax],edx
		struct h_heap* h = &h_kernel;
 b49:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		kstats_impl(h, s_total, s_commit, s_free, s_nheaps);
 b50:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 b53:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
 b57:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 b5a:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
 b5e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 b61:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 b65:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b68:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 b6c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 b6f:	89 04 24             	mov    DWORD PTR [esp],eax
 b72:	e8 fc ff ff ff       	call   b73 <kstats+0x57>
}
 b77:	90                   	nop
 b78:	c9                   	leave
 b79:	c3                   	ret

00000b7a <h_generic_oom_handler>:

int h_generic_oom_handler(void* hp, size_t s)
{
 b7a:	55                   	push   ebp
 b7b:	89 e5                	mov    ebp,esp
 b7d:	83 ec 28             	sub    esp,0x28
		struct h_heap* h = (struct h_heap*)hp, *h2; void* nm;
 b80:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b83:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		size_t page_ct;

		if (h->flags == 1) {
 b86:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 b89:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 b8c:	25 ff ff ff 7f       	and    eax,0x7fffffff
 b91:	83 f8 01             	cmp    eax,0x1
 b94:	75 0a                	jne    ba0 <h_generic_oom_handler+0x26>
				/* aggregate on aggregates */
				/* should be handled by the generic handler */
				/* TODO: maybe check kernel vs. user pages */
				return 0;
 b96:	b8 00 00 00 00       	mov    eax,0x0
 b9b:	e9 4c 01 00 00       	jmp    cec <h_generic_oom_handler+0x172>
		}

		while (s);
 ba0:	90                   	nop
 ba1:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
 ba5:	75 fa                	jne    ba1 <h_generic_oom_handler+0x27>

		/* map a new heap and move the initial desc into dynamic memory */
		page_ct = s / 4096;
 ba7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 baa:	c1 e8 0c             	shr    eax,0xc
 bad:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (page_ct % 256) /* MiB granularity */
 bb0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 bb3:	0f b6 c0             	movzx  eax,al
 bb6:	85 c0                	test   eax,eax
 bb8:	74 0d                	je     bc7 <h_generic_oom_handler+0x4d>
				page_ct += 256 - (page_ct % 256);
 bba:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 bbd:	b0 00                	mov    al,0x0
 bbf:	05 00 01 00 00       	add    eax,0x100
 bc4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		nm = mm_alloc_vmem(&mm_kernel, NULL, page_ct, MMGR_ALLOC_NP_AOA
 bc7:	c7 44 24 0c 0c 00 02 00 	mov    DWORD PTR [esp+0xc],0x2000c
 bcf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 bd2:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 bd6:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
 bde:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 be5:	e8 fc ff ff ff       	call   be6 <h_generic_oom_handler+0x6c>
 bea:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						| MMGR_MAP_WRITE | MMGR_MAP_KERNEL/* | MMGR_MAP_GLOBAL*/);

		/* we now have page_ct scrubbed pages at nm
		 * let's create a new heap there */
		h2 = (struct h_heap*)h_create_heap(nm, page_ct * 4096, h_generic_oom_handler, h_generic_decommit);
 bed:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 bf0:	c1 e0 0c             	shl    eax,0xc
 bf3:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
 bfb:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
 c03:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 c07:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 c0a:	89 04 24             	mov    DWORD PTR [esp],eax
 c0d:	e8 fc ff ff ff       	call   c0e <h_generic_oom_handler+0x94>
 c12:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		/* and move the desc of the initial heap there */
		nm = h_malloc(h2, sizeof(struct h_heap));
 c15:	c7 44 24 04 1c 00 00 00 	mov    DWORD PTR [esp+0x4],0x1c
 c1d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 c20:	89 04 24             	mov    DWORD PTR [esp],eax
 c23:	e8 fc ff ff ff       	call   c24 <h_generic_oom_handler+0xaa>
 c28:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (!nm) {
 c2b:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 c2f:	75 17                	jne    c48 <h_generic_oom_handler+0xce>
				/* this should never fail */
				cprintf(KFMT_ERROR, "catastrophe\n");
 c31:	c7 44 24 04 a5 00 00 00 	mov    DWORD PTR [esp+0x4],0xa5
 c39:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
 c40:	e8 fc ff ff ff       	call   c41 <h_generic_oom_handler+0xc7>
				while (1);
 c45:	90                   	nop
 c46:	eb fd                	jmp    c45 <h_generic_oom_handler+0xcb>
		}
		h->heap_oom_handler = NULL;
 c48:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c4b:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
		*(struct h_heap*)nm = *h; /* deregister this handler */
 c52:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 c55:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 c58:	8b 0a                	mov    ecx,DWORD PTR [edx]
 c5a:	89 08                	mov    DWORD PTR [eax],ecx
 c5c:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
 c5f:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
 c62:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
 c65:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
 c68:	8b 4a 0c             	mov    ecx,DWORD PTR [edx+0xc]
 c6b:	89 48 0c             	mov    DWORD PTR [eax+0xc],ecx
 c6e:	8b 4a 10             	mov    ecx,DWORD PTR [edx+0x10]
 c71:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
 c74:	8b 4a 14             	mov    ecx,DWORD PTR [edx+0x14]
 c77:	89 48 14             	mov    DWORD PTR [eax+0x14],ecx
 c7a:	8b 52 18             	mov    edx,DWORD PTR [edx+0x18]
 c7d:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		/* now change the desc for the aggregate heap */
		h->heap_base = nm;
 c80:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c83:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 c86:	89 10                	mov    DWORD PTR [eax],edx
		h->heap_ptr = h->heap_limit = h2;
 c88:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c8b:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
 c8e:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
 c91:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c94:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 c97:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c9a:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		h->heap_commit = h2->heap_commit + ((struct h_heap*)nm)->heap_commit;
 c9d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 ca0:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 ca3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 ca6:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 ca9:	01 c2                	add    edx,eax
 cab:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 cae:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		h->flags = 1;
 cb1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 cb4:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 cb7:	81 e2 00 00 00 80    	and    edx,0x80000000
 cbd:	83 ca 01             	or     edx,0x1
 cc0:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		h->desc_in_heap = 0;
 cc3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 cc6:	0f b6 50 1b          	movzx  edx,BYTE PTR [eax+0x1b]
 cca:	83 e2 7f             	and    edx,0x7f
 ccd:	88 50 1b             	mov    BYTE PTR [eax+0x1b],dl
		h->heap_decommit = NULL; /* don't decommit the aggregate */
 cd0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 cd3:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
		return 4096 * page_ct - ((struct h_heap*)nm)->heap_commit;
 cda:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 cdd:	c1 e0 0c             	shl    eax,0xc
 ce0:	89 c2                	mov    edx,eax
 ce2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 ce5:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 ce8:	29 c2                	sub    edx,eax
 cea:	89 d0                	mov    eax,edx
}
 cec:	c9                   	leave
 ced:	c3                   	ret

00000cee <h_generic_decommit>:

void h_generic_decommit(void* mem, size_t ct)
{
 cee:	55                   	push   ebp
 cef:	89 e5                	mov    ebp,esp
 cf1:	83 ec 18             	sub    esp,0x18
		mm_free_vmem(&mm_kernel, mem, ct / 4096);
 cf4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 cf7:	c1 e8 0c             	shr    eax,0xc
 cfa:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 cfe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 d01:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 d05:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 d0c:	e8 fc ff ff ff       	call   d0d <h_generic_decommit+0x1f>
}
 d11:	90                   	nop
 d12:	c9                   	leave
 d13:	c3                   	ret
