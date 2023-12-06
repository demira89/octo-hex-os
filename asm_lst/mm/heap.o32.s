
mm/heap.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
		for (size_t i = 0; i < KGUARD_SIZE; i++)
				*p1++ = *--p2 = 0xcb;
		return rv + KGUARD_SIZE;
}

void* kzalloc(size_t s)
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 10             	sub    esp,0x10
{
   6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		void* rv = kmalloc(s);
   c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		if (!rv)
  12:	eb 17                	jmp    2b <memcpy+0x2b>
				return NULL;
  14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
  17:	8d 42 01             	lea    eax,[edx+0x1]
  1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
  1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
  20:	8d 48 01             	lea    ecx,[eax+0x1]
  23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
  26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
  29:	88 10                	mov    BYTE PTR [eax],dl
		if (!rv)
  2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
  2e:	8d 50 ff             	lea    edx,[eax-0x1]
  31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
  34:	85 c0                	test   eax,eax
  36:	75 dc                	jne    14 <memcpy+0x14>
		bzero(rv, s);
  38:	90                   	nop
  39:	90                   	nop
  3a:	c9                   	leave
  3b:	c3                   	ret

0000003c <init_kernel_heap>:
{
  3c:	55                   	push   ebp
  3d:	89 e5                	mov    ebp,esp
  3f:	53                   	push   ebx
  40:	83 ec 14             	sub    esp,0x14
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
		hp = mm_alloc_vmem(&mm_kernel, NULL, ct, MMGR_ALLOC_NP_AOA
  81:	68 0c 00 02 00       	push   0x2000c
  86:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
  89:	6a 00                	push   0x0
  8b:	68 00 00 00 00       	push   0x0
  90:	e8 fc ff ff ff       	call   91 <init_kernel_heap+0x55>
  95:	83 c4 10             	add    esp,0x10
  98:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		h_kernel.heap_base = h_kernel.heap_ptr = hp;
  9b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  9e:	a3 04 00 00 00       	mov    ds:0x4,eax
  a3:	a1 04 00 00 00       	mov    eax,ds:0x4
  a8:	a3 00 00 00 00       	mov    ds:0x0,eax
		h_kernel.heap_limit = hp + ct * 4096;
  ad:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  b0:	c1 e0 0c             	shl    eax,0xc
  b3:	89 c2                	mov    edx,eax
  b5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  b8:	01 d0                	add    eax,edx
  ba:	a3 08 00 00 00       	mov    ds:0x8,eax
}
  bf:	90                   	nop
  c0:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
  c3:	c9                   	leave
  c4:	c3                   	ret

000000c5 <is_empty>:
int is_empty(struct heap_entry* he) { return ((char*)he->next - he->s - sizeof(struct heap_entry)) == (char*)he; }
  c5:	55                   	push   ebp
  c6:	89 e5                	mov    ebp,esp
  c8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  cb:	8b 10                	mov    edx,DWORD PTR [eax]
  cd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  d0:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
  d3:	b9 f8 ff ff ff       	mov    ecx,0xfffffff8
  d8:	29 c1                	sub    ecx,eax
  da:	8d 04 0a             	lea    eax,[edx+ecx*1]
  dd:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
  e0:	0f 94 c0             	sete   al
  e3:	0f b6 c0             	movzx  eax,al
  e6:	5d                   	pop    ebp
  e7:	c3                   	ret

000000e8 <h_dump>:
{
  e8:	55                   	push   ebp
  e9:	89 e5                	mov    ebp,esp
  eb:	83 ec 18             	sub    esp,0x18
		struct h_heap* h = (struct h_heap*)hp;
  ee:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  f1:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (h->flags == 1) { /* aggregate so dump twice */
  f4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  f7:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
  fa:	25 ff ff ff 7f       	and    eax,0x7fffffff
  ff:	83 f8 01             	cmp    eax,0x1
 102:	75 42                	jne    146 <h_dump+0x5e>
				printf("dumping aggreate heap consisting of heaps at:\n%p and %p",
 104:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 107:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 10a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 10d:	8b 00                	mov    eax,DWORD PTR [eax]
 10f:	83 ec 04             	sub    esp,0x4
 112:	52                   	push   edx
 113:	50                   	push   eax
 114:	68 00 00 00 00       	push   0x0
 119:	e8 fc ff ff ff       	call   11a <h_dump+0x32>
 11e:	83 c4 10             	add    esp,0x10
				h_dump(h->heap_base);
 121:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 124:	8b 00                	mov    eax,DWORD PTR [eax]
 126:	83 ec 0c             	sub    esp,0xc
 129:	50                   	push   eax
 12a:	e8 fc ff ff ff       	call   12b <h_dump+0x43>
 12f:	83 c4 10             	add    esp,0x10
				h_dump(h->heap_ptr);
 132:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 135:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 138:	83 ec 0c             	sub    esp,0xc
 13b:	50                   	push   eax
 13c:	e8 fc ff ff ff       	call   13d <h_dump+0x55>
 141:	83 c4 10             	add    esp,0x10
}
 144:	eb 51                	jmp    197 <h_dump+0xaf>
				struct heap_entry* he = (struct heap_entry*)h->heap_base;
 146:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 149:	8b 00                	mov    eax,DWORD PTR [eax]
 14b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				printf("dumping heap at %p with limit %p and ptr=%p\n",
 14e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 151:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
 154:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 157:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 15a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 15d:	8b 00                	mov    eax,DWORD PTR [eax]
 15f:	51                   	push   ecx
 160:	52                   	push   edx
 161:	50                   	push   eax
 162:	68 38 00 00 00       	push   0x38
 167:	e8 fc ff ff ff       	call   168 <h_dump+0x80>
 16c:	83 c4 10             	add    esp,0x10
						printf("entry at %p with size %u\n", he, he->s);
 16f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 172:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 175:	83 ec 04             	sub    esp,0x4
 178:	50                   	push   eax
 179:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 17c:	68 65 00 00 00       	push   0x65
 181:	e8 fc ff ff ff       	call   182 <h_dump+0x9a>
 186:	83 c4 10             	add    esp,0x10
				} while ((he = he->next));
 189:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 18c:	8b 00                	mov    eax,DWORD PTR [eax]
 18e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
 191:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 195:	75 d8                	jne    16f <h_dump+0x87>
}
 197:	90                   	nop
 198:	c9                   	leave
 199:	c3                   	ret

0000019a <h_malloc>:
{
 19a:	55                   	push   ebp
 19b:	89 e5                	mov    ebp,esp
 19d:	83 ec 28             	sub    esp,0x28
		struct h_heap* h = (struct h_heap*)hpp;
 1a0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 1a3:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (h->flags == 1) { /* we're on an aggregate heap */
 1a6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 1a9:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 1ac:	25 ff ff ff 7f       	and    eax,0x7fffffff
 1b1:	83 f8 01             	cmp    eax,0x1
 1b4:	74 06                	je     1bc <h_malloc+0x22>
Pos1:
 1b6:	90                   	nop
 1b7:	e9 9d 00 00 00       	jmp    259 <h_malloc+0xbf>
				void* rv = NULL;
 1bc:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
				rv = h_malloc(h->heap_limit, s);
 1c3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 1c6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 1c9:	83 ec 08             	sub    esp,0x8
 1cc:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 1cf:	50                   	push   eax
 1d0:	e8 fc ff ff ff       	call   1d1 <h_malloc+0x37>
 1d5:	83 c4 10             	add    esp,0x10
 1d8:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (!rv) {
 1db:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 1df:	75 53                	jne    234 <h_malloc+0x9a>
						rv = h_malloc(h->heap_base, s);
 1e1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 1e4:	8b 00                	mov    eax,DWORD PTR [eax]
 1e6:	83 ec 08             	sub    esp,0x8
 1e9:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 1ec:	50                   	push   eax
 1ed:	e8 fc ff ff ff       	call   1ee <h_malloc+0x54>
 1f2:	83 c4 10             	add    esp,0x10
 1f5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						if (!rv) { /* call the OOM handler (i.e. add another aggregation level) */
 1f8:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 1fc:	75 36                	jne    234 <h_malloc+0x9a>
								if (!h->heap_oom_handler(hpp, s))
 1fe:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 201:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 204:	83 ec 08             	sub    esp,0x8
 207:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 20a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 20d:	ff d0                	call   eax
 20f:	83 c4 10             	add    esp,0x10
 212:	85 c0                	test   eax,eax
 214:	75 0a                	jne    220 <h_malloc+0x86>
										return NULL;
 216:	b8 00 00 00 00       	mov    eax,0x0
 21b:	e9 b5 02 00 00       	jmp    4d5 <h_malloc+0x33b>
										rv = h_malloc(hpp, s);
 220:	83 ec 08             	sub    esp,0x8
 223:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 226:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 229:	e8 fc ff ff ff       	call   22a <h_malloc+0x90>
 22e:	83 c4 10             	add    esp,0x10
 231:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				h->heap_commit = ((struct h_heap*)h->heap_base)->heap_commit
 234:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 237:	8b 00                	mov    eax,DWORD PTR [eax]
 239:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
						+ ((struct h_heap*)h->heap_ptr)->heap_commit;
 23c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 23f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 242:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 245:	01 c2                	add    edx,eax
				h->heap_commit = ((struct h_heap*)h->heap_base)->heap_commit
 247:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 24a:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
				return rv;
 24d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 250:	e9 80 02 00 00       	jmp    4d5 <h_malloc+0x33b>
					goto Pos1;
 255:	90                   	nop
 256:	eb 01                	jmp    259 <h_malloc+0xbf>
					goto Pos1;
 258:	90                   	nop
		hp = (struct heap_entry*)h->heap_base;
 259:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 25c:	8b 00                	mov    eax,DWORD PTR [eax]
 25e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rem = (char*)h->heap_limit - (char*)h->heap_ptr;
 261:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 264:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 267:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 26a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 26d:	29 c2                	sub    edx,eax
 26f:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
		if (rem > s + sizeof(struct heap_entry)) { /* easy, lock free */
 272:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 275:	83 c0 08             	add    eax,0x8
 278:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
 27b:	73 6d                	jae    2ea <h_malloc+0x150>
			hp = (struct heap_entry*)h->heap_ptr;
 27d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 280:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 283:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
			if (rem != (size_t)((char*)h->heap_limit - (char*)hp))
 286:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 289:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 28c:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
 28f:	89 c2                	mov    edx,eax
 291:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 294:	39 c2                	cmp    edx,eax
 296:	75 bd                	jne    255 <h_malloc+0xbb>
			if (!__sync_bool_compare_and_swap(&h->heap_ptr, hp, (char*)h->heap_ptr + s + sizeof(struct heap_entry)))
 298:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 29b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 29e:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 2a1:	83 c2 08             	add    edx,0x8
 2a4:	01 d0                	add    eax,edx
 2a6:	89 c1                	mov    ecx,eax
 2a8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 2ab:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 2ae:	83 c2 04             	add    edx,0x4
 2b1:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
 2b5:	0f 94 c0             	sete   al
 2b8:	83 f0 01             	xor    eax,0x1
 2bb:	84 c0                	test   al,al
 2bd:	75 99                	jne    258 <h_malloc+0xbe>
			hp->s = s;
 2bf:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 2c2:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 2c5:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
			hp->next = h->heap_ptr;
 2c8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 2cb:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 2ce:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 2d1:	89 10                	mov    DWORD PTR [eax],edx
			__sync_add_and_fetch(&h->heap_commit, s);
 2d3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 2d6:	8d 50 0c             	lea    edx,[eax+0xc]
 2d9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 2dc:	f0 01 02             	lock add DWORD PTR [edx],eax
			return hp + 1;
 2df:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 2e2:	83 c0 08             	add    eax,0x8
 2e5:	e9 eb 01 00 00       	jmp    4d5 <h_malloc+0x33b>
				size_t fs_prev = 0; struct heap_entry* hp_p = 0;
 2ea:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 2f1:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
				while ((void*)hp < h->heap_ptr) {
 2f8:	e9 73 01 00 00       	jmp    470 <h_malloc+0x2d6>
						fs = (char*)hp->next - (char*)hp - hp->s - sizeof(struct heap_entry);
 2fd:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 300:	8b 00                	mov    eax,DWORD PTR [eax]
 302:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
 305:	89 c2                	mov    edx,eax
 307:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 30a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 30d:	29 c2                	sub    edx,eax
 30f:	8d 42 f8             	lea    eax,[edx-0x8]
 312:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						if (fs == 0) { /* full entry */
 315:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
 319:	75 1a                	jne    335 <h_malloc+0x19b>
								fs_prev = 0; hp_p = hp;
 31b:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 322:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 325:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								hp = hp->next;
 328:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 32b:	8b 00                	mov    eax,DWORD PTR [eax]
 32d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 330:	e9 3b 01 00 00       	jmp    470 <h_malloc+0x2d6>
						} else if (fs >= s + sizeof(struct heap_entry)) { /* reuse single (deleted?) space */
 335:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 338:	83 c0 08             	add    eax,0x8
 33b:	39 45 dc             	cmp    DWORD PTR [ebp-0x24],eax
 33e:	0f 82 80 00 00 00    	jb     3c4 <h_malloc+0x22a>
								if (is_empty(hp)) {
 344:	83 ec 0c             	sub    esp,0xc
 347:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
 34a:	e8 fc ff ff ff       	call   34b <h_malloc+0x1b1>
 34f:	83 c4 10             	add    esp,0x10
 352:	85 c0                	test   eax,eax
 354:	74 25                	je     37b <h_malloc+0x1e1>
										hp->s = s;
 356:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 359:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 35c:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										h->heap_commit += s;
 35f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 362:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 365:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 368:	01 c2                	add    edx,eax
 36a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 36d:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
										return hp + 1;
 370:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 373:	83 c0 08             	add    eax,0x8
 376:	e9 5a 01 00 00       	jmp    4d5 <h_malloc+0x33b>
										hp_p = hp;
 37b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 37e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										hp = (struct heap_entry*)((char*)(hp + 1) + hp->s);
 381:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 384:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 387:	83 c0 08             	add    eax,0x8
 38a:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
										hp->s = s;
 38d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 390:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 393:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										hp->next = hp_p->next;
 396:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 399:	8b 10                	mov    edx,DWORD PTR [eax]
 39b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 39e:	89 10                	mov    DWORD PTR [eax],edx
										hp_p->next = hp;
 3a0:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 3a3:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 3a6:	89 10                	mov    DWORD PTR [eax],edx
										h->heap_commit += s;
 3a8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 3ab:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 3ae:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 3b1:	01 c2                	add    edx,eax
 3b3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 3b6:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
										return hp + 1;
 3b9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 3bc:	83 c0 08             	add    eax,0x8
 3bf:	e9 11 01 00 00       	jmp    4d5 <h_malloc+0x33b>
						} else if (fs == hp->s) { /* remove completly freed space */
 3c4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 3c7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 3ca:	39 45 dc             	cmp    DWORD PTR [ebp-0x24],eax
 3cd:	0f 85 89 00 00 00    	jne    45c <h_malloc+0x2c2>
								if (hp_p) { /* combine entries */
 3d3:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
 3d7:	74 75                	je     44e <h_malloc+0x2b4>
										hp_p->next = hp->next;
 3d9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 3dc:	8b 10                	mov    edx,DWORD PTR [eax]
 3de:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 3e1:	89 10                	mov    DWORD PTR [eax],edx
										fs_prev += fs + sizeof(struct heap_entry);
 3e3:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 3e6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 3e9:	01 d0                	add    eax,edx
 3eb:	83 c0 08             	add    eax,0x8
 3ee:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
										if (fs_prev >= s + sizeof(struct heap_entry)) { /* found sth */
 3f1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 3f4:	83 c0 08             	add    eax,0x8
 3f7:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
 3fa:	72 48                	jb     444 <h_malloc+0x2aa>
												hp = (struct heap_entry*)((char*)(hp_p + 1) + hp_p->s);
 3fc:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 3ff:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 402:	8d 50 08             	lea    edx,[eax+0x8]
 405:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 408:	01 d0                	add    eax,edx
 40a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
												hp->s = s;
 40d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 410:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 413:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
												hp->next = hp_p->next;
 416:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 419:	8b 10                	mov    edx,DWORD PTR [eax]
 41b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 41e:	89 10                	mov    DWORD PTR [eax],edx
												hp_p->next = hp;
 420:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 423:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 426:	89 10                	mov    DWORD PTR [eax],edx
												h->heap_commit += s;
 428:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 42b:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 42e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 431:	01 c2                	add    edx,eax
 433:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 436:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
												return hp + 1;
 439:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 43c:	83 c0 08             	add    eax,0x8
 43f:	e9 91 00 00 00       	jmp    4d5 <h_malloc+0x33b>
												hp = (struct heap_entry*)hp->next;
 444:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 447:	8b 00                	mov    eax,DWORD PTR [eax]
 449:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 44c:	eb 22                	jmp    470 <h_malloc+0x2d6>
										fs_prev = fs;
 44e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 451:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
										hp_p = hp;
 454:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 457:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 45a:	eb 14                	jmp    470 <h_malloc+0x2d6>
								fs_prev = fs;
 45c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 45f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								hp_p = hp;
 462:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 465:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								hp = (struct heap_entry*)hp->next;
 468:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 46b:	8b 00                	mov    eax,DWORD PTR [eax]
 46d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				while ((void*)hp < h->heap_ptr) {
 470:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 473:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 476:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
 479:	0f 82 7e fe ff ff    	jb     2fd <h_malloc+0x163>
				if (h->heap_oom_handler)
 47f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 482:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 485:	85 c0                	test   eax,eax
 487:	74 2b                	je     4b4 <h_malloc+0x31a>
						if (h->heap_oom_handler(hpp, s))
 489:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 48c:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 48f:	83 ec 08             	sub    esp,0x8
 492:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 495:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 498:	ff d0                	call   eax
 49a:	83 c4 10             	add    esp,0x10
 49d:	85 c0                	test   eax,eax
 49f:	74 13                	je     4b4 <h_malloc+0x31a>
								return h_malloc(hpp, s);
 4a1:	83 ec 08             	sub    esp,0x8
 4a4:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 4a7:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 4aa:	e8 fc ff ff ff       	call   4ab <h_malloc+0x311>
 4af:	83 c4 10             	add    esp,0x10
 4b2:	eb 21                	jmp    4d5 <h_malloc+0x33b>
				printf("Out of heap memory\nIdling for debug\n");
 4b4:	83 ec 0c             	sub    esp,0xc
 4b7:	68 80 00 00 00       	push   0x80
 4bc:	e8 fc ff ff ff       	call   4bd <h_malloc+0x323>
 4c1:	83 c4 10             	add    esp,0x10
				h_dump(hpp);
 4c4:	83 ec 0c             	sub    esp,0xc
 4c7:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 4ca:	e8 fc ff ff ff       	call   4cb <h_malloc+0x331>
 4cf:	83 c4 10             	add    esp,0x10
				while (1);
 4d2:	90                   	nop
 4d3:	eb fd                	jmp    4d2 <h_malloc+0x338>
}
 4d5:	c9                   	leave
 4d6:	c3                   	ret

000004d7 <h_free>:
{
 4d7:	55                   	push   ebp
 4d8:	89 e5                	mov    ebp,esp
 4da:	83 ec 18             	sub    esp,0x18
		struct h_heap* h = (struct h_heap*)hp;
 4dd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 4e0:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if(h->flags == 1) { /* free on aggregate heap (i.e. everywhere) */
 4e3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 4e6:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 4e9:	25 ff ff ff 7f       	and    eax,0x7fffffff
 4ee:	83 f8 01             	cmp    eax,0x1
 4f1:	75 2b                	jne    51e <h_free+0x47>
				h_free(h->heap_base, ptr);
 4f3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 4f6:	8b 00                	mov    eax,DWORD PTR [eax]
 4f8:	83 ec 08             	sub    esp,0x8
 4fb:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 4fe:	50                   	push   eax
 4ff:	e8 fc ff ff ff       	call   500 <h_free+0x29>
 504:	83 c4 10             	add    esp,0x10
				h_free(h->heap_ptr, ptr);
 507:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 50a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 50d:	83 ec 08             	sub    esp,0x8
 510:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 513:	50                   	push   eax
 514:	e8 fc ff ff ff       	call   515 <h_free+0x3e>
 519:	83 c4 10             	add    esp,0x10
				return;
 51c:	eb 34                	jmp    552 <h_free+0x7b>
		if (ptr >= h->heap_base && ptr <= h->heap_limit) {
 51e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 521:	8b 00                	mov    eax,DWORD PTR [eax]
 523:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
 526:	72 2a                	jb     552 <h_free+0x7b>
 528:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 52b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 52e:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
 531:	72 1f                	jb     552 <h_free+0x7b>
				__sync_sub_and_fetch(&h->heap_commit, ((struct heap_entry*)ptr - 1)->s);
 533:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 536:	83 e8 08             	sub    eax,0x8
 539:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 53c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 53f:	83 c2 0c             	add    edx,0xc
 542:	f0 29 02             	lock sub DWORD PTR [edx],eax
				((struct heap_entry*)ptr - 1)->s = 0;
 545:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 548:	83 e8 08             	sub    eax,0x8
 54b:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
}
 552:	c9                   	leave
 553:	c3                   	ret

00000554 <h_realloc>:
{
 554:	55                   	push   ebp
 555:	89 e5                	mov    ebp,esp
 557:	83 ec 28             	sub    esp,0x28
		if (ptr) {
 55a:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
 55e:	0f 84 92 02 00 00    	je     7f6 <h_realloc+0x2a2>
				struct h_heap* h = (struct h_heap*)hp;
 564:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 567:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (h->flags == 1) { /* do an aggregate realloc (i.e. everywhere) */
 56a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 56d:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 570:	25 ff ff ff 7f       	and    eax,0x7fffffff
 575:	83 f8 01             	cmp    eax,0x1
 578:	0f 85 86 00 00 00    	jne    604 <h_realloc+0xb0>
						void* rv = NULL;
 57e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
						rv = h_realloc(h->heap_base, ptr, s);
 585:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 588:	8b 00                	mov    eax,DWORD PTR [eax]
 58a:	83 ec 04             	sub    esp,0x4
 58d:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 590:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 593:	50                   	push   eax
 594:	e8 fc ff ff ff       	call   595 <h_realloc+0x41>
 599:	83 c4 10             	add    esp,0x10
 59c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						if (!rv)
 59f:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 5a3:	75 18                	jne    5bd <h_realloc+0x69>
								h_realloc(h->heap_ptr, ptr, s);
 5a5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 5a8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 5ab:	83 ec 04             	sub    esp,0x4
 5ae:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 5b1:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 5b4:	50                   	push   eax
 5b5:	e8 fc ff ff ff       	call   5b6 <h_realloc+0x62>
 5ba:	83 c4 10             	add    esp,0x10
						if (!rv) { /* call the OOM handler (i.e. add another aggregation level) */
 5bd:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 5c1:	75 39                	jne    5fc <h_realloc+0xa8>
								if (!h->heap_oom_handler(hp, s))
 5c3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 5c6:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 5c9:	83 ec 08             	sub    esp,0x8
 5cc:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 5cf:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 5d2:	ff d0                	call   eax
 5d4:	83 c4 10             	add    esp,0x10
 5d7:	85 c0                	test   eax,eax
 5d9:	75 0a                	jne    5e5 <h_realloc+0x91>
										return NULL;
 5db:	b8 00 00 00 00       	mov    eax,0x0
 5e0:	e9 22 02 00 00       	jmp    807 <h_realloc+0x2b3>
										rv = h_realloc(hp, ptr, s);
 5e5:	83 ec 04             	sub    esp,0x4
 5e8:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 5eb:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 5ee:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 5f1:	e8 fc ff ff ff       	call   5f2 <h_realloc+0x9e>
 5f6:	83 c4 10             	add    esp,0x10
 5f9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						return rv;
 5fc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 5ff:	e9 03 02 00 00       	jmp    807 <h_realloc+0x2b3>
				if (ptr < h->heap_base || ptr > h->heap_limit)
 604:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 607:	8b 00                	mov    eax,DWORD PTR [eax]
 609:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
 60c:	72 0b                	jb     619 <h_realloc+0xc5>
 60e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 611:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 614:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
 617:	73 0a                	jae    623 <h_realloc+0xcf>
						return NULL;
 619:	b8 00 00 00 00       	mov    eax,0x0
 61e:	e9 e4 01 00 00       	jmp    807 <h_realloc+0x2b3>
				struct heap_entry* hp = (struct heap_entry*)(ptr) - 1, *hp2;
 623:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 626:	83 e8 08             	sub    eax,0x8
 629:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				size_t fs = 0, oldS = hp->s;
 62c:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 633:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 636:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 639:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				if (s <= hp->s) { /* shrink */
 63c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 63f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 642:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
 645:	72 25                	jb     66c <h_realloc+0x118>
						h->heap_commit -= oldS - s;
 647:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 64a:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 64d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 650:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
 653:	01 c2                	add    edx,eax
 655:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 658:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
						hp->s = s;
 65b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 65e:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 661:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						return ptr;
 664:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 667:	e9 9b 01 00 00       	jmp    807 <h_realloc+0x2b3>
				hp2 = hp->next;
 66c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 66f:	8b 00                	mov    eax,DWORD PTR [eax]
 671:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				while ((char*)hp2 < (char*)h->heap_ptr) {
 674:	e9 b7 00 00 00       	jmp    730 <h_realloc+0x1dc>
						if (is_empty(hp2)) {
 679:	83 ec 0c             	sub    esp,0xc
 67c:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
 67f:	e8 fc ff ff ff       	call   680 <h_realloc+0x12c>
 684:	83 c4 10             	add    esp,0x10
 687:	85 c0                	test   eax,eax
 689:	74 5a                	je     6e5 <h_realloc+0x191>
								fs += hp2->s + sizeof(struct heap_entry);
 68b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 68e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 691:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 694:	01 d0                	add    eax,edx
 696:	83 c0 08             	add    eax,0x8
 699:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								hp->next = hp2->next;
 69c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 69f:	8b 10                	mov    edx,DWORD PTR [eax]
 6a1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 6a4:	89 10                	mov    DWORD PTR [eax],edx
								if (hp->s + fs >= s) { /* found enough space*/
 6a6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 6a9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 6ac:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 6af:	01 d0                	add    eax,edx
 6b1:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
 6b4:	72 25                	jb     6db <h_realloc+0x187>
										h->heap_commit += s - oldS;
 6b6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 6b9:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 6bc:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 6bf:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
 6c2:	01 c2                	add    edx,eax
 6c4:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 6c7:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
										hp->s = s;
 6ca:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 6cd:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 6d0:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										return ptr;
 6d3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 6d6:	e9 2c 01 00 00       	jmp    807 <h_realloc+0x2b3>
										hp2 = (struct heap_entry*)hp2->next;
 6db:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 6de:	8b 00                	mov    eax,DWORD PTR [eax]
 6e0:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 6e3:	eb 4b                	jmp    730 <h_realloc+0x1dc>
								void* rv = h_malloc(hp, s);
 6e5:	83 ec 08             	sub    esp,0x8
 6e8:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 6eb:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
 6ee:	e8 fc ff ff ff       	call   6ef <h_realloc+0x19b>
 6f3:	83 c4 10             	add    esp,0x10
 6f6:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
								if(rv) {
 6f9:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
 6fd:	74 29                	je     728 <h_realloc+0x1d4>
										memcpy(rv, ptr, hp->s);
 6ff:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 702:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 705:	83 ec 04             	sub    esp,0x4
 708:	50                   	push   eax
 709:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 70c:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
 70f:	e8 ec f8 ff ff       	call   0 <memcpy>
 714:	83 c4 10             	add    esp,0x10
										h_free(hp, ptr);
 717:	83 ec 08             	sub    esp,0x8
 71a:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 71d:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
 720:	e8 fc ff ff ff       	call   721 <h_realloc+0x1cd>
 725:	83 c4 10             	add    esp,0x10
								return rv;
 728:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 72b:	e9 d7 00 00 00       	jmp    807 <h_realloc+0x2b3>
				while ((char*)hp2 < (char*)h->heap_ptr) {
 730:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 733:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 736:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
 739:	0f 82 3a ff ff ff    	jb     679 <h_realloc+0x125>
				fs += (char*)h->heap_limit - (char*)h->heap_ptr;
 73f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 742:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 745:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 748:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 74b:	29 c2                	sub    edx,eax
 74d:	89 d0                	mov    eax,edx
 74f:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
				if (fs + hp->s >= s) {
 752:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 755:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 758:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 75b:	01 d0                	add    eax,edx
 75d:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
 760:	72 3b                	jb     79d <h_realloc+0x249>
						h->heap_ptr = (char*)h->heap_ptr + s - hp->s;
 762:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 765:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 768:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 76b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 76e:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
 771:	29 c1                	sub    ecx,eax
 773:	01 ca                	add    edx,ecx
 775:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 778:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						h->heap_commit += s - oldS;
 77b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 77e:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 781:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 784:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
 787:	01 c2                	add    edx,eax
 789:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 78c:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
						hp->s = s;
 78f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 792:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 795:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						return ptr;
 798:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 79b:	eb 6a                	jmp    807 <h_realloc+0x2b3>
				if (h->heap_oom_handler)
 79d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 7a0:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 7a3:	85 c0                	test   eax,eax
 7a5:	74 2e                	je     7d5 <h_realloc+0x281>
						if (h->heap_oom_handler(hp, s))
 7a7:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 7aa:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 7ad:	83 ec 08             	sub    esp,0x8
 7b0:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 7b3:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
 7b6:	ff d0                	call   eax
 7b8:	83 c4 10             	add    esp,0x10
 7bb:	85 c0                	test   eax,eax
 7bd:	74 16                	je     7d5 <h_realloc+0x281>
								return h_realloc(hp, ptr, s);
 7bf:	83 ec 04             	sub    esp,0x4
 7c2:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 7c5:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 7c8:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
 7cb:	e8 fc ff ff ff       	call   7cc <h_realloc+0x278>
 7d0:	83 c4 10             	add    esp,0x10
 7d3:	eb 32                	jmp    807 <h_realloc+0x2b3>
				printf("Out of heap memory\nIdling for debug\n");
 7d5:	83 ec 0c             	sub    esp,0xc
 7d8:	68 80 00 00 00       	push   0x80
 7dd:	e8 fc ff ff ff       	call   7de <h_realloc+0x28a>
 7e2:	83 c4 10             	add    esp,0x10
				h_dump(hp);
 7e5:	83 ec 0c             	sub    esp,0xc
 7e8:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
 7eb:	e8 fc ff ff ff       	call   7ec <h_realloc+0x298>
 7f0:	83 c4 10             	add    esp,0x10
				while (1);
 7f3:	90                   	nop
 7f4:	eb fd                	jmp    7f3 <h_realloc+0x29f>
				return h_malloc(hp, s);
 7f6:	83 ec 08             	sub    esp,0x8
 7f9:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 7fc:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 7ff:	e8 fc ff ff ff       	call   800 <h_realloc+0x2ac>
 804:	83 c4 10             	add    esp,0x10
}
 807:	c9                   	leave
 808:	c3                   	ret

00000809 <h_create_heap>:
{
 809:	55                   	push   ebp
 80a:	89 e5                	mov    ebp,esp
 80c:	83 ec 10             	sub    esp,0x10
		struct h_heap* h = (struct h_heap*)mem;
 80f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 812:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (ct < sizeof(struct h_heap) + sizeof(struct heap_entry))
 815:	83 7d 0c 23          	cmp    DWORD PTR [ebp+0xc],0x23
 819:	77 07                	ja     822 <h_create_heap+0x19>
				return NULL; /* don't allocate noviable heaps */
 81b:	b8 00 00 00 00       	mov    eax,0x0
 820:	eb 5f                	jmp    881 <h_create_heap+0x78>
		h->desc_in_heap = 1; /* we're using part of mem */
 822:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 825:	0f b6 50 1b          	movzx  edx,BYTE PTR [eax+0x1b]
 829:	83 ca 80             	or     edx,0xffffff80
 82c:	88 50 1b             	mov    BYTE PTR [eax+0x1b],dl
		h->flags = 0; /* non-aggregate */
 82f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 832:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 835:	81 e2 00 00 00 80    	and    edx,0x80000000
 83b:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		h->heap_base = mem + sizeof(struct h_heap);
 83e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 841:	8d 50 1c             	lea    edx,[eax+0x1c]
 844:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 847:	89 10                	mov    DWORD PTR [eax],edx
		h->heap_limit = mem + ct;
 849:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 84c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 84f:	01 c2                	add    edx,eax
 851:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 854:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		h->heap_ptr = h->heap_base;
 857:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 85a:	8b 10                	mov    edx,DWORD PTR [eax]
 85c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 85f:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		h->heap_commit = 0;
 862:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 865:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		h->heap_decommit = hdc;
 86c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 86f:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
 872:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		h->heap_oom_handler = hdlr;
 875:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 878:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 87b:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		return mem;
 87e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
}
 881:	c9                   	leave
 882:	c3                   	ret

00000883 <h_destroy>:
{
 883:	55                   	push   ebp
 884:	89 e5                	mov    ebp,esp
 886:	83 ec 18             	sub    esp,0x18
		struct h_heap* h = (struct h_heap*)hp;
 889:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 88c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (h->flags == 1) { /* destroy both heaps */
 88f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 892:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 895:	25 ff ff ff 7f       	and    eax,0x7fffffff
 89a:	83 f8 01             	cmp    eax,0x1
 89d:	75 25                	jne    8c4 <h_destroy+0x41>
				h_destroy(h->heap_base);
 89f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8a2:	8b 00                	mov    eax,DWORD PTR [eax]
 8a4:	83 ec 0c             	sub    esp,0xc
 8a7:	50                   	push   eax
 8a8:	e8 fc ff ff ff       	call   8a9 <h_destroy+0x26>
 8ad:	83 c4 10             	add    esp,0x10
				h_destroy(h->heap_ptr);
 8b0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8b3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 8b6:	83 ec 0c             	sub    esp,0xc
 8b9:	50                   	push   eax
 8ba:	e8 fc ff ff ff       	call   8bb <h_destroy+0x38>
 8bf:	83 c4 10             	add    esp,0x10
				return;
 8c2:	eb 49                	jmp    90d <h_destroy+0x8a>
		struct heap_entry* he = (struct heap_entry*)h->heap_base;
 8c4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8c7:	8b 00                	mov    eax,DWORD PTR [eax]
 8c9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		he->s = 0;
 8cc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 8cf:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
		he->next = h->heap_limit;
 8d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8d9:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 8dc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 8df:	89 10                	mov    DWORD PTR [eax],edx
		if (h->heap_decommit)
 8e1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8e4:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
 8e7:	85 c0                	test   eax,eax
 8e9:	74 22                	je     90d <h_destroy+0x8a>
				h->heap_decommit(h->heap_base, h->heap_limit - h->heap_base);
 8eb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8ee:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
 8f1:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 8f4:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
 8f7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 8fa:	8b 12                	mov    edx,DWORD PTR [edx]
 8fc:	29 d1                	sub    ecx,edx
 8fe:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 901:	8b 12                	mov    edx,DWORD PTR [edx]
 903:	83 ec 08             	sub    esp,0x8
 906:	51                   	push   ecx
 907:	52                   	push   edx
 908:	ff d0                	call   eax
 90a:	83 c4 10             	add    esp,0x10
}
 90d:	c9                   	leave
 90e:	c3                   	ret

0000090f <kmalloc>:
{
 90f:	55                   	push   ebp
 910:	89 e5                	mov    ebp,esp
 912:	83 ec 18             	sub    esp,0x18
		void* rv = h_malloc(&h_kernel, s + 2 * KGUARD_SIZE);
 915:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 918:	83 c0 10             	add    eax,0x10
 91b:	83 ec 08             	sub    esp,0x8
 91e:	50                   	push   eax
 91f:	68 00 00 00 00       	push   0x0
 924:	e8 fc ff ff ff       	call   925 <kmalloc+0x16>
 929:	83 c4 10             	add    esp,0x10
 92c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (!rv)
 92f:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
 933:	75 07                	jne    93c <kmalloc+0x2d>
				return NULL;
 935:	b8 00 00 00 00       	mov    eax,0x0
 93a:	eb 48                	jmp    984 <kmalloc+0x75>
		p1 = rv;
 93c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 93f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		p2 = rv + s + 2 * KGUARD_SIZE;
 942:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 945:	8d 50 10             	lea    edx,[eax+0x10]
 948:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 94b:	01 d0                	add    eax,edx
 94d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 950:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 957:	eb 1f                	jmp    978 <kmalloc+0x69>
				*p1++ = *--p2 = 0xcb;
 959:	83 6d f0 01          	sub    DWORD PTR [ebp-0x10],0x1
 95d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 960:	c6 00 cb             	mov    BYTE PTR [eax],0xcb
 963:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 966:	8d 50 01             	lea    edx,[eax+0x1]
 969:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
 96c:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 96f:	0f b6 12             	movzx  edx,BYTE PTR [edx]
 972:	88 10                	mov    BYTE PTR [eax],dl
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 974:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
 978:	83 7d ec 07          	cmp    DWORD PTR [ebp-0x14],0x7
 97c:	76 db                	jbe    959 <kmalloc+0x4a>
		return rv + KGUARD_SIZE;
 97e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 981:	83 c0 08             	add    eax,0x8
}
 984:	c9                   	leave
 985:	c3                   	ret

00000986 <kzalloc>:
{
 986:	55                   	push   ebp
 987:	89 e5                	mov    ebp,esp
 989:	83 ec 18             	sub    esp,0x18
		void* rv = kmalloc(s);
 98c:	83 ec 0c             	sub    esp,0xc
 98f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 992:	e8 fc ff ff ff       	call   993 <kzalloc+0xd>
 997:	83 c4 10             	add    esp,0x10
 99a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv)
 99d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 9a1:	75 07                	jne    9aa <kzalloc+0x24>
				return NULL;
 9a3:	b8 00 00 00 00       	mov    eax,0x0
 9a8:	eb 14                	jmp    9be <kzalloc+0x38>
		bzero(rv, s);
 9aa:	83 ec 08             	sub    esp,0x8
 9ad:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 9b0:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 9b3:	e8 fc ff ff ff       	call   9b4 <kzalloc+0x2e>
 9b8:	83 c4 10             	add    esp,0x10
		return rv;
 9bb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
 9be:	c9                   	leave
 9bf:	c3                   	ret

000009c0 <kfree>:

void kfree(void* ptr)
{
 9c0:	55                   	push   ebp
 9c1:	89 e5                	mov    ebp,esp
 9c3:	83 ec 08             	sub    esp,0x8
		h_free(&h_kernel, ptr - KGUARD_SIZE);
 9c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 9c9:	83 e8 08             	sub    eax,0x8
 9cc:	83 ec 08             	sub    esp,0x8
 9cf:	50                   	push   eax
 9d0:	68 00 00 00 00       	push   0x0
 9d5:	e8 fc ff ff ff       	call   9d6 <kfree+0x16>
 9da:	83 c4 10             	add    esp,0x10
}
 9dd:	90                   	nop
 9de:	c9                   	leave
 9df:	c3                   	ret

000009e0 <krealloc>:

void* krealloc(void* ptr, size_t s)
{
 9e0:	55                   	push   ebp
 9e1:	89 e5                	mov    ebp,esp
 9e3:	83 ec 18             	sub    esp,0x18
		void* rv = h_realloc(&h_kernel, ptr - KGUARD_SIZE, s + 2 * KGUARD_SIZE);
 9e6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 9e9:	8d 50 10             	lea    edx,[eax+0x10]
 9ec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 9ef:	83 e8 08             	sub    eax,0x8
 9f2:	83 ec 04             	sub    esp,0x4
 9f5:	52                   	push   edx
 9f6:	50                   	push   eax
 9f7:	68 00 00 00 00       	push   0x0
 9fc:	e8 fc ff ff ff       	call   9fd <krealloc+0x1d>
 a01:	83 c4 10             	add    esp,0x10
 a04:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (!rv)
 a07:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 a0b:	75 07                	jne    a14 <krealloc+0x34>
				return NULL;
 a0d:	b8 00 00 00 00       	mov    eax,0x0
 a12:	eb 31                	jmp    a45 <krealloc+0x65>
		char* p2 = rv + s + 2 * KGUARD_SIZE;
 a14:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 a17:	8d 50 10             	lea    edx,[eax+0x10]
 a1a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a1d:	01 d0                	add    eax,edx
 a1f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 a22:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 a29:	eb 0e                	jmp    a39 <krealloc+0x59>
				*--p2 = 0xcc;
 a2b:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
 a2f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 a32:	c6 00 cc             	mov    BYTE PTR [eax],0xcc
		for (size_t i = 0; i < KGUARD_SIZE; i++)
 a35:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
 a39:	83 7d f0 07          	cmp    DWORD PTR [ebp-0x10],0x7
 a3d:	76 ec                	jbe    a2b <krealloc+0x4b>
		return rv + KGUARD_SIZE;
 a3f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a42:	83 c0 08             	add    eax,0x8
}
 a45:	c9                   	leave
 a46:	c3                   	ret

00000a47 <kstats_impl>:

void kstats_impl(struct h_heap* h, size_t* s_total, size_t* s_commit, size_t* s_free, size_t* s_nheaps)
{
 a47:	55                   	push   ebp
 a48:	89 e5                	mov    ebp,esp
 a4a:	83 ec 08             	sub    esp,0x8
		if (h->flags == 1) {
 a4d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 a50:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 a53:	25 ff ff ff 7f       	and    eax,0x7fffffff
 a58:	83 f8 01             	cmp    eax,0x1
 a5b:	75 3d                	jne    a9a <kstats_impl+0x53>
				/* is aggregate */
				kstats_impl(h->heap_base, s_total, s_commit, s_free, s_nheaps);
 a5d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 a60:	8b 00                	mov    eax,DWORD PTR [eax]
 a62:	83 ec 0c             	sub    esp,0xc
 a65:	ff 75 18             	push   DWORD PTR [ebp+0x18]
 a68:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 a6b:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 a6e:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 a71:	50                   	push   eax
 a72:	e8 fc ff ff ff       	call   a73 <kstats_impl+0x2c>
 a77:	83 c4 20             	add    esp,0x20
				kstats_impl(h->heap_ptr, s_total, s_commit, s_free, s_nheaps);
 a7a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 a7d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 a80:	83 ec 0c             	sub    esp,0xc
 a83:	ff 75 18             	push   DWORD PTR [ebp+0x18]
 a86:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 a89:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 a8c:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 a8f:	50                   	push   eax
 a90:	e8 fc ff ff ff       	call   a91 <kstats_impl+0x4a>
 a95:	83 c4 20             	add    esp,0x20
				return;
 a98:	eb 5b                	jmp    af5 <kstats_impl+0xae>
		}

		/* we're on memory */
		*s_commit += h->heap_commit;
 a9a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 a9d:	8b 10                	mov    edx,DWORD PTR [eax]
 a9f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 aa2:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 aa5:	01 c2                	add    edx,eax
 aa7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 aaa:	89 10                	mov    DWORD PTR [eax],edx
		*s_total += h->heap_limit - h->heap_base;
 aac:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 aaf:	8b 10                	mov    edx,DWORD PTR [eax]
 ab1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 ab4:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
 ab7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 aba:	8b 00                	mov    eax,DWORD PTR [eax]
 abc:	29 c1                	sub    ecx,eax
 abe:	89 c8                	mov    eax,ecx
 ac0:	01 c2                	add    edx,eax
 ac2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 ac5:	89 10                	mov    DWORD PTR [eax],edx
		*s_free += (h->heap_limit - h->heap_base) - h->heap_commit;
 ac7:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 aca:	8b 10                	mov    edx,DWORD PTR [eax]
 acc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 acf:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
 ad2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 ad5:	8b 00                	mov    eax,DWORD PTR [eax]
 ad7:	29 c1                	sub    ecx,eax
 ad9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 adc:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 adf:	29 c1                	sub    ecx,eax
 ae1:	01 ca                	add    edx,ecx
 ae3:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 ae6:	89 10                	mov    DWORD PTR [eax],edx
		(*s_nheaps)++;
 ae8:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
 aeb:	8b 00                	mov    eax,DWORD PTR [eax]
 aed:	8d 50 01             	lea    edx,[eax+0x1]
 af0:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
 af3:	89 10                	mov    DWORD PTR [eax],edx
}
 af5:	c9                   	leave
 af6:	c3                   	ret

00000af7 <kstats>:

void kstats(size_t* s_total, size_t* s_commit, size_t* s_free, size_t* s_nheaps)
{
 af7:	55                   	push   ebp
 af8:	89 e5                	mov    ebp,esp
 afa:	83 ec 18             	sub    esp,0x18
		*s_total = *s_commit = *s_free = *s_nheaps = 0;
 afd:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 b00:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
 b06:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 b09:	8b 10                	mov    edx,DWORD PTR [eax]
 b0b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 b0e:	89 10                	mov    DWORD PTR [eax],edx
 b10:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 b13:	8b 10                	mov    edx,DWORD PTR [eax]
 b15:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 b18:	89 10                	mov    DWORD PTR [eax],edx
 b1a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 b1d:	8b 10                	mov    edx,DWORD PTR [eax]
 b1f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b22:	89 10                	mov    DWORD PTR [eax],edx
		struct h_heap* h = &h_kernel;
 b24:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		kstats_impl(h, s_total, s_commit, s_free, s_nheaps);
 b2b:	83 ec 0c             	sub    esp,0xc
 b2e:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 b31:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 b34:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 b37:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 b3a:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 b3d:	e8 fc ff ff ff       	call   b3e <kstats+0x47>
 b42:	83 c4 20             	add    esp,0x20
}
 b45:	90                   	nop
 b46:	c9                   	leave
 b47:	c3                   	ret

00000b48 <h_generic_oom_handler>:

int h_generic_oom_handler(void* hp, size_t s)
{
 b48:	55                   	push   ebp
 b49:	89 e5                	mov    ebp,esp
 b4b:	83 ec 18             	sub    esp,0x18
		struct h_heap* h = (struct h_heap*)hp, *h2; void* nm;
 b4e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b51:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		size_t page_ct;

		if (h->flags == 1) {
 b54:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 b57:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 b5a:	25 ff ff ff 7f       	and    eax,0x7fffffff
 b5f:	83 f8 01             	cmp    eax,0x1
 b62:	75 0a                	jne    b6e <h_generic_oom_handler+0x26>
				/* aggregate on aggregates */
				/* should be handled by the generic handler */
				/* TODO: maybe check kernel vs. user pages */
				return 0;
 b64:	b8 00 00 00 00       	mov    eax,0x0
 b69:	e9 2b 01 00 00       	jmp    c99 <h_generic_oom_handler+0x151>
		}

		/* map a new heap and move the initial desc into dynamic memory */
		page_ct = s / 4096;
 b6e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 b71:	c1 e8 0c             	shr    eax,0xc
 b74:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (page_ct % 256) /* MiB granularity */
 b77:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 b7a:	0f b6 c0             	movzx  eax,al
 b7d:	85 c0                	test   eax,eax
 b7f:	74 0d                	je     b8e <h_generic_oom_handler+0x46>
				page_ct += 256 - (page_ct % 256);
 b81:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 b84:	b0 00                	mov    al,0x0
 b86:	05 00 01 00 00       	add    eax,0x100
 b8b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		nm = mm_alloc_vmem(&mm_kernel, NULL, page_ct, MMGR_ALLOC_NP_AOA
 b8e:	68 0c 00 02 00       	push   0x2000c
 b93:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 b96:	6a 00                	push   0x0
 b98:	68 00 00 00 00       	push   0x0
 b9d:	e8 fc ff ff ff       	call   b9e <h_generic_oom_handler+0x56>
 ba2:	83 c4 10             	add    esp,0x10
 ba5:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						| MMGR_MAP_WRITE | MMGR_MAP_KERNEL/* | MMGR_MAP_GLOBAL*/);

		/* we now have page_ct scrubbed pages at nm
		 * let's create a new heap there */
		h2 = (struct h_heap*)h_create_heap(nm, page_ct * 4096, h_generic_oom_handler, h_generic_decommit);
 ba8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 bab:	c1 e0 0c             	shl    eax,0xc
 bae:	68 00 00 00 00       	push   0x0
 bb3:	68 00 00 00 00       	push   0x0
 bb8:	50                   	push   eax
 bb9:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
 bbc:	e8 fc ff ff ff       	call   bbd <h_generic_oom_handler+0x75>
 bc1:	83 c4 10             	add    esp,0x10
 bc4:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		/* and move the desc of the initial heap there */
		nm = h_malloc(h2, sizeof(struct h_heap));
 bc7:	83 ec 08             	sub    esp,0x8
 bca:	6a 1c                	push   0x1c
 bcc:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
 bcf:	e8 fc ff ff ff       	call   bd0 <h_generic_oom_handler+0x88>
 bd4:	83 c4 10             	add    esp,0x10
 bd7:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (!nm) {
 bda:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 bde:	75 15                	jne    bf5 <h_generic_oom_handler+0xad>
				/* this should never fail */
				cprintf(KFMT_ERROR, "catastrophe\n");
 be0:	83 ec 08             	sub    esp,0x8
 be3:	68 a5 00 00 00       	push   0xa5
 be8:	6a 0c                	push   0xc
 bea:	e8 fc ff ff ff       	call   beb <h_generic_oom_handler+0xa3>
 bef:	83 c4 10             	add    esp,0x10
				while (1);
 bf2:	90                   	nop
 bf3:	eb fd                	jmp    bf2 <h_generic_oom_handler+0xaa>
		}
		h->heap_oom_handler = NULL;
 bf5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 bf8:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
		*(struct h_heap*)nm = *h; /* deregister this handler */
 bff:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 c02:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 c05:	8b 0a                	mov    ecx,DWORD PTR [edx]
 c07:	89 08                	mov    DWORD PTR [eax],ecx
 c09:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
 c0c:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
 c0f:	8b 4a 08             	mov    ecx,DWORD PTR [edx+0x8]
 c12:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
 c15:	8b 4a 0c             	mov    ecx,DWORD PTR [edx+0xc]
 c18:	89 48 0c             	mov    DWORD PTR [eax+0xc],ecx
 c1b:	8b 4a 10             	mov    ecx,DWORD PTR [edx+0x10]
 c1e:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
 c21:	8b 4a 14             	mov    ecx,DWORD PTR [edx+0x14]
 c24:	89 48 14             	mov    DWORD PTR [eax+0x14],ecx
 c27:	8b 52 18             	mov    edx,DWORD PTR [edx+0x18]
 c2a:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		/* now change the desc for the aggregate heap */
		h->heap_base = nm;
 c2d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c30:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 c33:	89 10                	mov    DWORD PTR [eax],edx
		h->heap_ptr = h->heap_limit = h2;
 c35:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c38:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
 c3b:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
 c3e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c41:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 c44:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c47:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		h->heap_commit = h2->heap_commit + ((struct h_heap*)nm)->heap_commit;
 c4a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 c4d:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 c50:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 c53:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 c56:	01 c2                	add    edx,eax
 c58:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c5b:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		h->flags = 1;
 c5e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c61:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 c64:	81 e2 00 00 00 80    	and    edx,0x80000000
 c6a:	83 ca 01             	or     edx,0x1
 c6d:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		h->desc_in_heap = 0;
 c70:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c73:	0f b6 50 1b          	movzx  edx,BYTE PTR [eax+0x1b]
 c77:	83 e2 7f             	and    edx,0x7f
 c7a:	88 50 1b             	mov    BYTE PTR [eax+0x1b],dl
		h->heap_decommit = NULL; /* don't decommit the aggregate */
 c7d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 c80:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
		return 4096 * page_ct - ((struct h_heap*)nm)->heap_commit;
 c87:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 c8a:	c1 e0 0c             	shl    eax,0xc
 c8d:	89 c2                	mov    edx,eax
 c8f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 c92:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 c95:	29 c2                	sub    edx,eax
 c97:	89 d0                	mov    eax,edx
}
 c99:	c9                   	leave
 c9a:	c3                   	ret

00000c9b <h_generic_decommit>:

void h_generic_decommit(void* mem, size_t ct)
{
 c9b:	55                   	push   ebp
 c9c:	89 e5                	mov    ebp,esp
 c9e:	83 ec 08             	sub    esp,0x8
		mm_free_vmem(&mm_kernel, mem, ct / 4096);
 ca1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 ca4:	c1 e8 0c             	shr    eax,0xc
 ca7:	83 ec 04             	sub    esp,0x4
 caa:	50                   	push   eax
 cab:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 cae:	68 00 00 00 00       	push   0x0
 cb3:	e8 fc ff ff ff       	call   cb4 <h_generic_decommit+0x19>
 cb8:	83 c4 10             	add    esp,0x10
}
 cbb:	90                   	nop
 cbc:	c9                   	leave
 cbd:	c3                   	ret
