
mm/vmem.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
		rv = __sync_fetch_and_sub(pp, 4096);
		if (rv < VM_TABLE_LIMIT) {
				die("Out of virtual memory for paging structures.\n");
				return NULL;
		}
		mm_map(&mm_kernel, rv, &pr, 1, MMGR_MAP_WRITE
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
						| MMGR_MAP_KERNEL /*| MMGR_MAP_GLOBAL*/);

		return rv;
}

       6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
       c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
#ifdef __x86_64__
void* mm_map64(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
       f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
      12:	c9                   	leave
      13:	c3                   	ret

00000014 <flush_tlb_single>:
{
      14:	55                   	push   ebp
      15:	89 e5                	mov    ebp,esp
      17:	57                   	push   edi
      18:	56                   	push   esi
      19:	53                   	push   ebx
		__sync_fetch_and_add(&tlb_flush_ct, 1);
      1a:	a1 00 00 00 00       	mov    eax,ds:0x0
      1f:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
      25:	89 c1                	mov    ecx,eax
      27:	89 d3                	mov    ebx,edx
      29:	83 c1 01             	add    ecx,0x1
      2c:	83 d3 00             	adc    ebx,0x0
      2f:	89 ce                	mov    esi,ecx
      31:	89 df                	mov    edi,ebx
      33:	89 f3                	mov    ebx,esi
      35:	89 f9                	mov    ecx,edi
      37:	f0 0f c7 0d 00 00 00 00 	lock cmpxchg8b QWORD PTR ds:0x0
      3f:	0f 94 c1             	sete   cl
      42:	84 c9                	test   cl,cl
      44:	74 df                	je     25 <flush_tlb_single+0x11>
		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
      46:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      49:	0f 01 38             	invlpg BYTE PTR [eax]
}
      4c:	90                   	nop
      4d:	5b                   	pop    ebx
      4e:	5e                   	pop    esi
      4f:	5f                   	pop    edi
      50:	5d                   	pop    ebp
      51:	c3                   	ret

00000052 <flush_tlb_full>:
{
      52:	55                   	push   ebp
      53:	89 e5                	mov    ebp,esp
		asm volatile("mov %%cr3, %%eax\nmov %%eax, %%cr3\n" : : : "%eax");
      55:	0f 20 d8             	mov    eax,cr3
      58:	0f 22 d8             	mov    cr3,eax
}
      5b:	90                   	nop
      5c:	5d                   	pop    ebp
      5d:	c3                   	ret

0000005e <mm_alloc_page>:
{
      5e:	55                   	push   ebp
      5f:	89 e5                	mov    ebp,esp
      61:	83 ec 48             	sub    esp,0x48
		if (cpu.has_pae)
      64:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
      6b:	83 e0 40             	and    eax,0x40
      6e:	84 c0                	test   al,al
      70:	74 0d                	je     7f <mm_alloc_page+0x21>
				pp = &((struct vm_pg_ptrs36*)mm_kernel.ctx)->cur;
      72:	a1 08 00 00 00       	mov    eax,ds:0x8
      77:	83 c0 20             	add    eax,0x20
      7a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
      7d:	eb 08                	jmp    87 <mm_alloc_page+0x29>
				pp = &((struct vm_pg_ptrs32*)mm_kernel.ctx)->cur;
      7f:	a1 08 00 00 00       	mov    eax,ds:0x8
      84:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!mm_alloc_pm(1, &pr, 1)) {
      87:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
      8f:	8d 45 e4             	lea    eax,[ebp-0x1c]
      92:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
      96:	c7 04 24 01 00 00 00 	mov    DWORD PTR [esp],0x1
      9d:	e8 fc ff ff ff       	call   9e <mm_alloc_page+0x40>
      a2:	85 c0                	test   eax,eax
      a4:	75 29                	jne    cf <mm_alloc_page+0x71>
				die("Unable to allocate PM for paging strucures.\n");
      a6:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
      ae:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
      b5:	e8 fc ff ff ff       	call   b6 <mm_alloc_page+0x58>
      ba:	e8 fc ff ff ff       	call   bb <mm_alloc_page+0x5d>
      bf:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
      c6:	e8 fc ff ff ff       	call   c7 <mm_alloc_page+0x69>
      cb:	fa                   	cli
      cc:	f4                   	hlt
      cd:	eb fd                	jmp    cc <mm_alloc_page+0x6e>
		*b = pr.base;
      cf:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      d2:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
      d5:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
      d8:	89 01                	mov    DWORD PTR [ecx],eax
      da:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		rv = __sync_fetch_and_sub(pp, 4096);
      dd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      e0:	ba 00 10 00 00       	mov    edx,0x1000
      e5:	f7 da                	neg    edx
      e7:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
      eb:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
		if (rv < VM_TABLE_LIMIT) {
      ee:	81 7d f0 ff ff ff fd 	cmp    DWORD PTR [ebp-0x10],0xfdffffff
      f5:	77 29                	ja     120 <mm_alloc_page+0xc2>
				die("Out of virtual memory for paging structures.\n");
      f7:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
      ff:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     106:	e8 fc ff ff ff       	call   107 <mm_alloc_page+0xa9>
     10b:	e8 fc ff ff ff       	call   10c <mm_alloc_page+0xae>
     110:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     117:	e8 fc ff ff ff       	call   118 <mm_alloc_page+0xba>
     11c:	fa                   	cli
     11d:	f4                   	hlt
     11e:	eb fd                	jmp    11d <mm_alloc_page+0xbf>
		mm_map(&mm_kernel, rv, &pr, 1, MMGR_MAP_WRITE
     120:	c7 44 24 10 0c 00 00 00 	mov    DWORD PTR [esp+0x10],0xc
     128:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
     130:	8d 45 e4             	lea    eax,[ebp-0x1c]
     133:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     137:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     13a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     13e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     145:	e8 fc ff ff ff       	call   146 <mm_alloc_page+0xe8>
		return rv;
     14a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     14d:	c9                   	leave
     14e:	c3                   	ret

0000014f <mm_map36>:
		return vaddr;
}
#else
void* mm_map36(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
{
     14f:	55                   	push   ebp
     150:	89 e5                	mov    ebp,esp
     152:	56                   	push   esi
     153:	53                   	push   ebx
     154:	83 ec 40             	sub    esp,0x40
		struct vm_pg_ptrs36* vp = vm_mapping;
     157:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     15a:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		uint32_t pdpte, pde, pte;
		struct page_range pr_copy = *pr;
     15d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     160:	8b 10                	mov    edx,DWORD PTR [eax]
     162:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
     165:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     168:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
     16b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     16e:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		/* physical pointers */
		struct pte64* pd = 0;
     171:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
		struct pte64* pt = 0;
     178:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0

		/* and the PDPTE */
		pdpte = ((uint32_t)vaddr & 0xc0000000) >> 30; /* 1G per PDPTE */
     17f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     182:	c1 e8 1e             	shr    eax,0x1e
     185:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		pd = vp->pdp[pdpte];
     188:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     18b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     18e:	83 c2 08             	add    edx,0x8
     191:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     195:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

		/* and the PDE */
		pde = ((uint32_t)vaddr & 0x3fe00000) >> 21; /* 2M per PDE */
     198:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     19b:	c1 e8 15             	shr    eax,0x15
     19e:	25 ff 01 00 00       	and    eax,0x1ff
     1a3:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

		/* and finally the PTE */
		pte = ((uint32_t)vaddr & 0x1ff000) >> 12; /* 4K per PTE */
     1a6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1a9:	c1 e8 0c             	shr    eax,0xc
     1ac:	25 ff 01 00 00       	and    eax,0x1ff
     1b1:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* create a PT if not there */
new_pt:
		if (ENTER_CS_PTE(vp->pts[pdpte * 512 + pde])) {
     1b4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     1b7:	c1 e0 09             	shl    eax,0x9
     1ba:	89 c2                	mov    edx,eax
     1bc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     1bf:	01 d0                	add    eax,edx
     1c1:	83 c0 0c             	add    eax,0xc
     1c4:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     1cb:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     1ce:	01 d0                	add    eax,edx
     1d0:	8d 50 04             	lea    edx,[eax+0x4]
     1d3:	b8 00 00 00 00       	mov    eax,0x0
     1d8:	b9 ff ff ff ff       	mov    ecx,0xffffffff
     1dd:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     1e1:	0f 94 c0             	sete   al
     1e4:	84 c0                	test   al,al
     1e6:	0f 84 dd 00 00 00    	je     2c9 <mm_map36+0x17a>
				uint64_t b;
				/* allocate a page table */
				pt = mm_alloc_page(&b);
     1ec:	8d 45 c8             	lea    eax,[ebp-0x38]
     1ef:	89 04 24             	mov    DWORD PTR [esp],eax
     1f2:	e8 fc ff ff ff       	call   1f3 <mm_map36+0xa4>
     1f7:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax

				/* and set the reference in the PD */
				pd[pde].addr = b / 4096;
     1fa:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     1fd:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     200:	0f ac d0 0c          	shrd   eax,edx,0xc
     204:	c1 ea 0c             	shr    edx,0xc
     207:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     20a:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
     211:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     214:	01 d9                	add    ecx,ebx
     216:	81 e2 ff 00 00 00    	and    edx,0xff
     21c:	89 c3                	mov    ebx,eax
     21e:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
     224:	89 de                	mov    esi,ebx
     226:	c1 e6 0c             	shl    esi,0xc
     229:	8b 19                	mov    ebx,DWORD PTR [ecx]
     22b:	81 e3 ff 0f 00 00    	and    ebx,0xfff
     231:	09 f3                	or     ebx,esi
     233:	89 19                	mov    DWORD PTR [ecx],ebx
     235:	89 c3                	mov    ebx,eax
     237:	c1 eb 14             	shr    ebx,0x14
     23a:	89 de                	mov    esi,ebx
     23c:	66 81 e6 ff 0f       	and    si,0xfff
     241:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
     245:	66 81 e3 00 f0       	and    bx,0xf000
     24a:	09 f3                	or     ebx,esi
     24c:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
     250:	0f b6 c2             	movzx  eax,dl
     253:	c1 e0 0c             	shl    eax,0xc
     256:	89 c2                	mov    edx,eax
     258:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
     25b:	25 ff 0f f0 ff       	and    eax,0xfff00fff
     260:	09 d0                	or     eax,edx
     262:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pd[pde].u = 1;
     265:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     268:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     26f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     272:	01 d0                	add    eax,edx
     274:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     277:	83 ca 04             	or     edx,0x4
     27a:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
     27c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     27f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     286:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     289:	01 d0                	add    eax,edx
     28b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     28e:	83 ca 02             	or     edx,0x2
     291:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
     293:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     296:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     29d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     2a0:	01 d0                	add    eax,edx
     2a2:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     2a5:	83 ca 01             	or     edx,0x1
     2a8:	88 10                	mov    BYTE PTR [eax],dl

				/* release CS */
				vp->pts[pdpte * 512 + pde] = pt;
     2aa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2ad:	c1 e0 09             	shl    eax,0x9
     2b0:	89 c2                	mov    edx,eax
     2b2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2b5:	01 c2                	add    edx,eax
     2b7:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     2ba:	8d 4a 0c             	lea    ecx,[edx+0xc]
     2bd:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     2c0:	89 54 88 04          	mov    DWORD PTR [eax+ecx*4+0x4],edx
     2c4:	e9 15 03 00 00       	jmp    5de <mm_map36+0x48f>
		} else {
				SPIN_CS(vp->pts[pdpte * 512 + pde]);
     2c9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2cc:	c1 e0 09             	shl    eax,0x9
     2cf:	89 c2                	mov    edx,eax
     2d1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2d4:	01 d0                	add    eax,edx
     2d6:	83 c0 0c             	add    eax,0xc
     2d9:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     2e0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     2e3:	01 d0                	add    eax,edx
     2e5:	83 c0 04             	add    eax,0x4
     2e8:	8b 00                	mov    eax,DWORD PTR [eax]
     2ea:	83 f8 ff             	cmp    eax,0xffffffff
     2ed:	74 da                	je     2c9 <mm_map36+0x17a>
				pt = vp->pts[pdpte * 512 + pde];
     2ef:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2f2:	c1 e0 09             	shl    eax,0x9
     2f5:	89 c2                	mov    edx,eax
     2f7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2fa:	01 c2                	add    edx,eax
     2fc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     2ff:	83 c2 0c             	add    edx,0xc
     302:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     306:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		}

		/* now map the pages */
		while (prc) {
     309:	e9 d0 02 00 00       	jmp    5de <mm_map36+0x48f>
				pt[pte].addr = pr_copy.base / 4096;
     30e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     311:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     314:	0f ac d0 0c          	shrd   eax,edx,0xc
     318:	c1 ea 0c             	shr    edx,0xc
     31b:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     31e:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
     325:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     328:	01 d9                	add    ecx,ebx
     32a:	81 e2 ff 00 00 00    	and    edx,0xff
     330:	89 c3                	mov    ebx,eax
     332:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
     338:	89 de                	mov    esi,ebx
     33a:	c1 e6 0c             	shl    esi,0xc
     33d:	8b 19                	mov    ebx,DWORD PTR [ecx]
     33f:	81 e3 ff 0f 00 00    	and    ebx,0xfff
     345:	09 f3                	or     ebx,esi
     347:	89 19                	mov    DWORD PTR [ecx],ebx
     349:	89 c3                	mov    ebx,eax
     34b:	c1 eb 14             	shr    ebx,0x14
     34e:	89 de                	mov    esi,ebx
     350:	66 81 e6 ff 0f       	and    si,0xfff
     355:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
     359:	66 81 e3 00 f0       	and    bx,0xf000
     35e:	09 f3                	or     ebx,esi
     360:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
     364:	0f b6 c2             	movzx  eax,dl
     367:	c1 e0 0c             	shl    eax,0xc
     36a:	89 c2                	mov    edx,eax
     36c:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
     36f:	25 ff 0f f0 ff       	and    eax,0xfff00fff
     374:	09 d0                	or     eax,edx
     376:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pt[pte].u = 1; /* FIXME: for now (u ? 1 : 0) */
     379:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     37c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     383:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     386:	01 d0                	add    eax,edx
     388:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     38b:	83 ca 04             	or     edx,0x4
     38e:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].w = (w ? 1 : 0);
     390:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     393:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     39a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     39d:	01 d0                	add    eax,edx
     39f:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
     3a3:	0f 95 c2             	setne  dl
     3a6:	83 e2 01             	and    edx,0x1
     3a9:	8d 0c 12             	lea    ecx,[edx+edx*1]
     3ac:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     3af:	83 e2 fd             	and    edx,0xfffffffd
     3b2:	09 ca                	or     edx,ecx
     3b4:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
     3b6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     3b9:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     3c0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     3c3:	01 d0                	add    eax,edx
     3c5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     3c8:	83 ca 01             	or     edx,0x1
     3cb:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
     3cd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     3d0:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     3d7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     3da:	01 d0                	add    eax,edx
     3dc:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     3e0:	0f 95 c2             	setne  dl
     3e3:	89 d1                	mov    ecx,edx
     3e5:	c1 e1 07             	shl    ecx,0x7
     3e8:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     3eb:	83 e2 7f             	and    edx,0x7f
     3ee:	09 ca                	or     edx,ecx
     3f0:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].wt = (wt ? 1 : 0);
     3f2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     3f5:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     3fc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     3ff:	01 d0                	add    eax,edx
     401:	83 7d 24 00          	cmp    DWORD PTR [ebp+0x24],0x0
     405:	0f 95 c2             	setne  dl
     408:	83 e2 01             	and    edx,0x1
     40b:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
     412:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     415:	83 e2 f7             	and    edx,0xfffffff7
     418:	09 ca                	or     edx,ecx
     41a:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].cd = (cd ? 1 : 0);
     41c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     41f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     426:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     429:	01 d0                	add    eax,edx
     42b:	83 7d 28 00          	cmp    DWORD PTR [ebp+0x28],0x0
     42f:	0f 95 c2             	setne  dl
     432:	83 e2 01             	and    edx,0x1
     435:	89 d1                	mov    ecx,edx
     437:	c1 e1 04             	shl    ecx,0x4
     43a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     43d:	83 e2 ef             	and    edx,0xffffffef
     440:	09 ca                	or     edx,ecx
     442:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].g = (g ? 1 : 0);
     444:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     447:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     44e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     451:	01 d0                	add    eax,edx
     453:	83 7d 2c 00          	cmp    DWORD PTR [ebp+0x2c],0x0
     457:	0f 95 c2             	setne  dl
     45a:	89 d1                	mov    ecx,edx
     45c:	83 e1 01             	and    ecx,0x1
     45f:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     463:	83 e2 fe             	and    edx,0xfffffffe
     466:	09 ca                	or     edx,ecx
     468:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
				pt[pte].u = 1; /* FIXME: for now */
     46b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     46e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     475:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     478:	01 d0                	add    eax,edx
     47a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     47d:	83 ca 04             	or     edx,0x4
     480:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].ign = avl & 7;
     482:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     485:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     48c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     48f:	01 c2                	add    edx,eax
     491:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
     494:	83 e0 07             	and    eax,0x7
     497:	83 e0 07             	and    eax,0x7
     49a:	8d 0c 00             	lea    ecx,[eax+eax*1]
     49d:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
     4a1:	83 e0 f1             	and    eax,0xfffffff1
     4a4:	09 c8                	or     eax,ecx
     4a6:	88 42 01             	mov    BYTE PTR [edx+0x1],al
				pt[pte].ign2 = (avl >> 3);
     4a9:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
     4ac:	c1 f8 03             	sar    eax,0x3
     4af:	89 c1                	mov    ecx,eax
     4b1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     4b4:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     4bb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     4be:	01 c2                	add    edx,eax
     4c0:	89 c8                	mov    eax,ecx
     4c2:	66 25 ff 07          	and    ax,0x7ff
     4c6:	66 25 ff 07          	and    ax,0x7ff
     4ca:	c1 e0 04             	shl    eax,0x4
     4cd:	89 c1                	mov    ecx,eax
     4cf:	0f b7 42 06          	movzx  eax,WORD PTR [edx+0x6]
     4d3:	66 25 0f 80          	and    ax,0x800f
     4d7:	09 c8                	or     eax,ecx
     4d9:	66 89 42 06          	mov    WORD PTR [edx+0x6],ax
				if (cpu.e_has_nx)
     4dd:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
     4e4:	83 e0 10             	and    eax,0x10
     4e7:	84 c0                	test   al,al
     4e9:	74 27                	je     512 <mm_map36+0x3c3>
						pt[pte].xd = (x ? 0 : 1);
     4eb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     4ee:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     4f5:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     4f8:	01 d0                	add    eax,edx
     4fa:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     4fe:	0f 94 c2             	sete   dl
     501:	89 d1                	mov    ecx,edx
     503:	c1 e1 07             	shl    ecx,0x7
     506:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
     50a:	83 e2 7f             	and    edx,0x7f
     50d:	09 ca                	or     edx,ecx
     50f:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
				/* advance */
				if (pte++ == 511) {
     512:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     515:	8d 50 01             	lea    edx,[eax+0x1]
     518:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     51b:	3d ff 01 00 00       	cmp    eax,0x1ff
     520:	75 76                	jne    598 <mm_map36+0x449>
						if (pde++ == 511) {
     522:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     525:	8d 50 01             	lea    edx,[eax+0x1]
     528:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
     52b:	3d ff 01 00 00       	cmp    eax,0x1ff
     530:	75 5a                	jne    58c <mm_map36+0x43d>
								if (pdpte++ == 3) {
     532:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     535:	8d 50 01             	lea    edx,[eax+0x1]
     538:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     53b:	83 f8 03             	cmp    eax,0x3
     53e:	75 29                	jne    569 <mm_map36+0x41a>
										die("End of 4G address space\n");
     540:	c7 44 24 04 5e 00 00 00 	mov    DWORD PTR [esp+0x4],0x5e
     548:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     54f:	e8 fc ff ff ff       	call   550 <mm_map36+0x401>
     554:	e8 fc ff ff ff       	call   555 <mm_map36+0x406>
     559:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     560:	e8 fc ff ff ff       	call   561 <mm_map36+0x412>
     565:	fa                   	cli
     566:	f4                   	hlt
     567:	eb fd                	jmp    566 <mm_map36+0x417>
								}
								pd = vp->pdp[pdpte];
     569:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     56c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     56f:	83 c2 08             	add    edx,0x8
     572:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     576:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								pde = 0;
     579:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
								pte = 0;
     580:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
								goto new_pt;
     587:	e9 28 fc ff ff       	jmp    1b4 <mm_map36+0x65>
						}
						pte = 0;
     58c:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						goto new_pt;
     593:	e9 1c fc ff ff       	jmp    1b4 <mm_map36+0x65>
				}
				pr_copy.base += 4096;
     598:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     59b:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     59e:	05 00 10 00 00       	add    eax,0x1000
     5a3:	83 d2 00             	adc    edx,0x0
     5a6:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     5a9:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
				if (!--pr_copy.count) {
     5ac:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5af:	83 e8 01             	sub    eax,0x1
     5b2:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     5b5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5b8:	85 c0                	test   eax,eax
     5ba:	75 22                	jne    5de <mm_map36+0x48f>
						if (--prc)
     5bc:	83 6d 14 01          	sub    DWORD PTR [ebp+0x14],0x1
     5c0:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     5c4:	74 18                	je     5de <mm_map36+0x48f>
								pr_copy = *++pr; /* advance then dereference */
     5c6:	83 45 10 0c          	add    DWORD PTR [ebp+0x10],0xc
     5ca:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     5cd:	8b 10                	mov    edx,DWORD PTR [eax]
     5cf:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
     5d2:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     5d5:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
     5d8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     5db:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		while (prc) {
     5de:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     5e2:	0f 85 26 fd ff ff    	jne    30e <mm_map36+0x1bf>
				}
		}
		return vaddr;
     5e8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
}
     5eb:	83 c4 40             	add    esp,0x40
     5ee:	5b                   	pop    ebx
     5ef:	5e                   	pop    esi
     5f0:	5d                   	pop    ebp
     5f1:	c3                   	ret

000005f2 <mm_map32>:

void* mm_map32(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
{
     5f2:	55                   	push   ebp
     5f3:	89 e5                	mov    ebp,esp
     5f5:	53                   	push   ebx
     5f6:	83 ec 44             	sub    esp,0x44
		struct vm_pg_ptrs32* vp = vm_mapping;
     5f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5fc:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		uint32_t pde, pte;
		struct page_range pr_copy = *pr;
     5ff:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     602:	8b 10                	mov    edx,DWORD PTR [eax]
     604:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
     607:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     60a:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     60d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     610:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax

		/* entry pointers */
		struct pte32* pd = vp->pd;
     613:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     616:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     619:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct pte32* pt = 0;
     61c:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0

		/* and the PDE */
		pde = ((uint32_t)vaddr & 0xffc00000) >> 22; /* 4M per PDE */
     623:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     626:	c1 e8 16             	shr    eax,0x16
     629:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* and finally the PTE */
		pte = ((uint32_t)vaddr & 0x3ff000) >> 12; /* 4K per PTE */
     62c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     62f:	c1 e8 0c             	shr    eax,0xc
     632:	25 ff 03 00 00       	and    eax,0x3ff
     637:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

new_pt:
		/* create a PT if not there */
		if (ENTER_CS_PTE(vp->pts[pde])) {
     63a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     63d:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     644:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     647:	01 d0                	add    eax,edx
     649:	8d 50 08             	lea    edx,[eax+0x8]
     64c:	b8 00 00 00 00       	mov    eax,0x0
     651:	b9 ff ff ff ff       	mov    ecx,0xffffffff
     656:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     65a:	0f 94 c0             	sete   al
     65d:	84 c0                	test   al,al
     65f:	0f 84 96 00 00 00    	je     6fb <mm_map32+0x109>
				uint64_t b;
				/* allocate a page table */
				pt = mm_alloc_page(&b);
     665:	8d 45 d0             	lea    eax,[ebp-0x30]
     668:	89 04 24             	mov    DWORD PTR [esp],eax
     66b:	e8 fc ff ff ff       	call   66c <mm_map32+0x7a>
     670:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

				/* and set the reference in the PD */
				pd[pde].addr = (uint32_t)(b / 4096);
     673:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     676:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     679:	0f ac d0 0c          	shrd   eax,edx,0xc
     67d:	c1 ea 0c             	shr    edx,0xc
     680:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     683:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
     68a:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     68d:	01 d9                	add    ecx,ebx
     68f:	25 ff ff 0f 00       	and    eax,0xfffff
     694:	c1 e0 0c             	shl    eax,0xc
     697:	89 c2                	mov    edx,eax
     699:	8b 01                	mov    eax,DWORD PTR [ecx]
     69b:	25 ff 0f 00 00       	and    eax,0xfff
     6a0:	09 d0                	or     eax,edx
     6a2:	89 01                	mov    DWORD PTR [ecx],eax
				pd[pde].u = 1;
     6a4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     6a7:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     6ae:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     6b1:	01 d0                	add    eax,edx
     6b3:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     6b6:	83 ca 04             	or     edx,0x4
     6b9:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
     6bb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     6be:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     6c5:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     6c8:	01 d0                	add    eax,edx
     6ca:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     6cd:	83 ca 02             	or     edx,0x2
     6d0:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
     6d2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     6d5:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     6dc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     6df:	01 d0                	add    eax,edx
     6e1:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     6e4:	83 ca 01             	or     edx,0x1
     6e7:	88 10                	mov    BYTE PTR [eax],dl
	
				/* release CS */
				vp->pts[pde] = pt;
     6e9:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     6ec:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     6ef:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     6f2:	89 4c 90 08          	mov    DWORD PTR [eax+edx*4+0x8],ecx
     6f6:	e9 23 02 00 00       	jmp    91e <mm_map32+0x32c>
		} else {
				/* wait until valid and fetch */
				SPIN_CS(vp->pts[pde]);
     6fb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     6fe:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     705:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     708:	01 d0                	add    eax,edx
     70a:	83 c0 08             	add    eax,0x8
     70d:	8b 00                	mov    eax,DWORD PTR [eax]
     70f:	83 f8 ff             	cmp    eax,0xffffffff
     712:	74 e7                	je     6fb <mm_map32+0x109>
				pt = vp->pts[pde];
     714:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     717:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     71a:	8b 44 90 08          	mov    eax,DWORD PTR [eax+edx*4+0x8]
     71e:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		}

		/* now map the pages */
		while (prc) {
     721:	e9 f8 01 00 00       	jmp    91e <mm_map32+0x32c>
				pt[pte].addr = pr_copy.base / 4096;
     726:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     729:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     72c:	0f ac d0 0c          	shrd   eax,edx,0xc
     730:	c1 ea 0c             	shr    edx,0xc
     733:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     736:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
     73d:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     740:	01 d9                	add    ecx,ebx
     742:	25 ff ff 0f 00       	and    eax,0xfffff
     747:	c1 e0 0c             	shl    eax,0xc
     74a:	89 c2                	mov    edx,eax
     74c:	8b 01                	mov    eax,DWORD PTR [ecx]
     74e:	25 ff 0f 00 00       	and    eax,0xfff
     753:	09 d0                	or     eax,edx
     755:	89 01                	mov    DWORD PTR [ecx],eax
				pt[pte].u = (u ? 1 : 0); /* FIXME: for now (u ? 1 : 0) */
     757:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     75a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     761:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     764:	01 d0                	add    eax,edx
     766:	83 7d 30 00          	cmp    DWORD PTR [ebp+0x30],0x0
     76a:	0f 95 c2             	setne  dl
     76d:	83 e2 01             	and    edx,0x1
     770:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
     777:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     77a:	83 e2 fb             	and    edx,0xfffffffb
     77d:	09 ca                	or     edx,ecx
     77f:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].w = (w ? 1 : 0);
     781:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     784:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     78b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     78e:	01 d0                	add    eax,edx
     790:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
     794:	0f 95 c2             	setne  dl
     797:	83 e2 01             	and    edx,0x1
     79a:	8d 0c 12             	lea    ecx,[edx+edx*1]
     79d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     7a0:	83 e2 fd             	and    edx,0xfffffffd
     7a3:	09 ca                	or     edx,ecx
     7a5:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
     7a7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7aa:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     7b1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     7b4:	01 d0                	add    eax,edx
     7b6:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     7b9:	83 ca 01             	or     edx,0x1
     7bc:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
     7be:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7c1:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     7c8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     7cb:	01 d0                	add    eax,edx
     7cd:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     7d1:	0f 95 c2             	setne  dl
     7d4:	89 d1                	mov    ecx,edx
     7d6:	c1 e1 07             	shl    ecx,0x7
     7d9:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     7dc:	83 e2 7f             	and    edx,0x7f
     7df:	09 ca                	or     edx,ecx
     7e1:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].wt = (wt ? 1 : 0);
     7e3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7e6:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     7ed:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     7f0:	01 d0                	add    eax,edx
     7f2:	83 7d 24 00          	cmp    DWORD PTR [ebp+0x24],0x0
     7f6:	0f 95 c2             	setne  dl
     7f9:	83 e2 01             	and    edx,0x1
     7fc:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
     803:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     806:	83 e2 f7             	and    edx,0xfffffff7
     809:	09 ca                	or     edx,ecx
     80b:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].cd = (cd ? 1 : 0);
     80d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     810:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     817:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     81a:	01 d0                	add    eax,edx
     81c:	83 7d 28 00          	cmp    DWORD PTR [ebp+0x28],0x0
     820:	0f 95 c2             	setne  dl
     823:	83 e2 01             	and    edx,0x1
     826:	89 d1                	mov    ecx,edx
     828:	c1 e1 04             	shl    ecx,0x4
     82b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     82e:	83 e2 ef             	and    edx,0xffffffef
     831:	09 ca                	or     edx,ecx
     833:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].g = (g ? 1 : 0);
     835:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     838:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     83f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     842:	01 d0                	add    eax,edx
     844:	83 7d 2c 00          	cmp    DWORD PTR [ebp+0x2c],0x0
     848:	0f 95 c2             	setne  dl
     84b:	89 d1                	mov    ecx,edx
     84d:	83 e1 01             	and    ecx,0x1
     850:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     854:	83 e2 fe             	and    edx,0xfffffffe
     857:	09 ca                	or     edx,ecx
     859:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
				pt[pte].ign = avl & 7;
     85c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     85f:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     866:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     869:	01 c2                	add    edx,eax
     86b:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
     86e:	83 e0 07             	and    eax,0x7
     871:	83 e0 07             	and    eax,0x7
     874:	8d 0c 00             	lea    ecx,[eax+eax*1]
     877:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
     87b:	83 e0 f1             	and    eax,0xfffffff1
     87e:	09 c8                	or     eax,ecx
     880:	88 42 01             	mov    BYTE PTR [edx+0x1],al
				/* advance */
				if (pte++ == 1023) {
     883:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     886:	8d 50 01             	lea    edx,[eax+0x1]
     889:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
     88c:	3d ff 03 00 00       	cmp    eax,0x3ff
     891:	75 45                	jne    8d8 <mm_map32+0x2e6>
						if (pde++ == 1023) {
     893:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     896:	8d 50 01             	lea    edx,[eax+0x1]
     899:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     89c:	3d ff 03 00 00       	cmp    eax,0x3ff
     8a1:	75 29                	jne    8cc <mm_map32+0x2da>
								die("end of 4G address space\n");
     8a3:	c7 44 24 04 77 00 00 00 	mov    DWORD PTR [esp+0x4],0x77
     8ab:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     8b2:	e8 fc ff ff ff       	call   8b3 <mm_map32+0x2c1>
     8b7:	e8 fc ff ff ff       	call   8b8 <mm_map32+0x2c6>
     8bc:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     8c3:	e8 fc ff ff ff       	call   8c4 <mm_map32+0x2d2>
     8c8:	fa                   	cli
     8c9:	f4                   	hlt
     8ca:	eb fd                	jmp    8c9 <mm_map32+0x2d7>
						}
						pte = 0;
     8cc:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
						goto new_pt;
     8d3:	e9 62 fd ff ff       	jmp    63a <mm_map32+0x48>
				}
				pr_copy.base += 4096;
     8d8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     8db:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     8de:	05 00 10 00 00       	add    eax,0x1000
     8e3:	83 d2 00             	adc    edx,0x0
     8e6:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     8e9:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
				if (!--pr_copy.count) {
     8ec:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     8ef:	83 e8 01             	sub    eax,0x1
     8f2:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     8f5:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     8f8:	85 c0                	test   eax,eax
     8fa:	75 22                	jne    91e <mm_map32+0x32c>
						if (--prc)
     8fc:	83 6d 14 01          	sub    DWORD PTR [ebp+0x14],0x1
     900:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     904:	74 18                	je     91e <mm_map32+0x32c>
								pr_copy = *++pr; /* advance then dereference */
     906:	83 45 10 0c          	add    DWORD PTR [ebp+0x10],0xc
     90a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     90d:	8b 10                	mov    edx,DWORD PTR [eax]
     90f:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
     912:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     915:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     918:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     91b:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		while (prc) {
     91e:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     922:	0f 85 fe fd ff ff    	jne    726 <mm_map32+0x134>
				}
		}
		return vaddr;
     928:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
}
     92b:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     92e:	c9                   	leave
     92f:	c3                   	ret

00000930 <mm_map>:
map_fun mf_map = NULL;
#endif

void* mm_map(struct mm* mm, void* virt_address,	const struct page_range* prs,
				size_t pr_ct, int flags)
{
     930:	55                   	push   ebp
     931:	89 e5                	mov    ebp,esp
     933:	83 ec 68             	sub    esp,0x68
		int x = !!(flags & MMGR_MAP_EXECUTE), w = !!(flags & MMGR_MAP_WRITE),
     936:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     939:	83 e0 02             	and    eax,0x2
     93c:	85 c0                	test   eax,eax
     93e:	0f 95 c0             	setne  al
     941:	0f b6 c0             	movzx  eax,al
     944:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
     947:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     94a:	83 e0 04             	and    eax,0x4
     94d:	85 c0                	test   eax,eax
     94f:	0f 95 c0             	setne  al
     952:	0f b6 c0             	movzx  eax,al
     955:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
			wc = !!(flags & MMGR_MAP_PAT), wt = !!(flags & MMGR_MAP_WRITE_THROUGH),
     958:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     95b:	25 80 00 00 00       	and    eax,0x80
     960:	85 c0                	test   eax,eax
     962:	0f 95 c0             	setne  al
     965:	0f b6 c0             	movzx  eax,al
     968:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     96b:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     96e:	83 e0 10             	and    eax,0x10
     971:	85 c0                	test   eax,eax
     973:	0f 95 c0             	setne  al
     976:	0f b6 c0             	movzx  eax,al
     979:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
			cd = !!(flags & MMGR_MAP_NO_CACHING), g = !!(flags & MMGR_MAP_GLOBAL),
     97c:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     97f:	83 e0 20             	and    eax,0x20
     982:	85 c0                	test   eax,eax
     984:	0f 95 c0             	setne  al
     987:	0f b6 c0             	movzx  eax,al
     98a:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     98d:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     990:	83 e0 40             	and    eax,0x40
     993:	85 c0                	test   eax,eax
     995:	0f 95 c0             	setne  al
     998:	0f b6 c0             	movzx  eax,al
     99b:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
			u = !(flags & MMGR_MAP_KERNEL);
     99e:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     9a1:	83 e0 08             	and    eax,0x8
     9a4:	85 c0                	test   eax,eax
     9a6:	0f 94 c0             	sete   al
     9a9:	0f b6 c0             	movzx  eax,al
     9ac:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		int avl = 0;
     9af:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0

		if (flags & MMGR_MAP_COW) {
     9b6:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     9b9:	25 00 02 00 00       	and    eax,0x200
     9be:	85 c0                	test   eax,eax
     9c0:	74 0e                	je     9d0 <mm_map+0xa0>
				avl = MMGR_AVL_COW;
     9c2:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [ebp-0x10],0x1
				w = 0; /* make COW workable */
     9c9:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		}

		/* get virtutal memory */
		if (!virt_address) {
     9d0:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     9d4:	75 51                	jne    a27 <mm_map+0xf7>
				size_t pg_ct = 0;
     9d6:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				for (size_t i = 0; i < pr_ct; i++)
     9dd:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     9e4:	eb 1d                	jmp    a03 <mm_map+0xd3>
						pg_ct += prs[i].count;
     9e6:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     9e9:	89 d0                	mov    eax,edx
     9eb:	01 c0                	add    eax,eax
     9ed:	01 d0                	add    eax,edx
     9ef:	c1 e0 02             	shl    eax,0x2
     9f2:	89 c2                	mov    edx,eax
     9f4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     9f7:	01 d0                	add    eax,edx
     9f9:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     9fc:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
				for (size_t i = 0; i < pr_ct; i++)
     9ff:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
     a03:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     a06:	3b 45 14             	cmp    eax,DWORD PTR [ebp+0x14]
     a09:	72 db                	jb     9e6 <mm_map+0xb6>
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);
     a0b:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     a0e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     a12:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     a15:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     a19:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a1c:	89 04 24             	mov    DWORD PTR [esp],eax
     a1f:	e8 fc ff ff ff       	call   a20 <mm_map+0xf0>
     a24:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
		}

#ifdef __x86_64__
		return mm_map64(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
#else
		return mf_map(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
     a27:	a1 00 00 00 00       	mov    eax,ds:0x0
     a2c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     a2f:	8b 52 08             	mov    edx,DWORD PTR [edx+0x8]
     a32:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     a35:	89 4c 24 2c          	mov    DWORD PTR [esp+0x2c],ecx
     a39:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
     a3c:	89 4c 24 28          	mov    DWORD PTR [esp+0x28],ecx
     a40:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     a43:	89 4c 24 24          	mov    DWORD PTR [esp+0x24],ecx
     a47:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
     a4a:	89 4c 24 20          	mov    DWORD PTR [esp+0x20],ecx
     a4e:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     a51:	89 4c 24 1c          	mov    DWORD PTR [esp+0x1c],ecx
     a55:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     a58:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
     a5c:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     a5f:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     a63:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     a66:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
     a6a:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
     a6d:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     a71:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
     a74:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     a78:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
     a7b:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
     a7f:	89 14 24             	mov    DWORD PTR [esp],edx
     a82:	ff d0                	call   eax
#endif
}
     a84:	c9                   	leave
     a85:	c3                   	ret

00000a86 <mm_page_walk36>:
		return (pt[pte].p ? 0 : -1);
}
#else
int mm_page_walk36(void* vm_mapping, void* virt_addr, struct pte64** parent,
				struct pte64** entry, int* level, uint32_t* offset, void*** cntr, void*** cntrm)
{
     a86:	55                   	push   ebp
     a87:	89 e5                	mov    ebp,esp
     a89:	83 ec 20             	sub    esp,0x20
		struct vm_pg_ptrs36* vp = vm_mapping;
     a8c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a8f:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		uint32_t pdpte, pde, pte;

		/* entry pointers */
		struct pte64* pd = 0;
     a92:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
		struct pte64* pt = 0;
     a99:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		*cntrm = NULL;
     aa0:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     aa3:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0

		/* the PDPTE */
		pdpte = ((uint32_t)virt_addr & 0xc0000000) >> 30; /* 1G per PDPTE */
     aa9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     aac:	c1 e8 1e             	shr    eax,0x1e
     aaf:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		pd = vp->pdp[pdpte];
     ab2:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     ab5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     ab8:	83 c2 08             	add    edx,0x8
     abb:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     abf:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax

		/* and the PDE */
		pde = ((uint32_t)virt_addr & 0x3fe00000) >> 21; /* 2M per PDE */
     ac2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ac5:	c1 e8 15             	shr    eax,0x15
     ac8:	25 ff 01 00 00       	and    eax,0x1ff
     acd:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* and finally the PTE */
		pte = ((uint32_t)virt_addr & 0x1ff000) >> 12; /* 4K per PTE */
     ad0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ad3:	c1 e8 0c             	shr    eax,0xc
     ad6:	25 ff 01 00 00       	and    eax,0x1ff
     adb:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

		/* PDPTE */
		if (!vp->pdps[pdpte].p) {
     ade:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     ae1:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     ae4:	0f b6 04 d0          	movzx  eax,BYTE PTR [eax+edx*8]
     ae8:	83 e0 01             	and    eax,0x1
     aeb:	84 c0                	test   al,al
     aed:	75 41                	jne    b30 <mm_page_walk36+0xaa>
				*parent = NULL;
     aef:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     af2:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				*entry = &vp->pdps[pdpte];
     af8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     afb:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     b02:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     b05:	01 c2                	add    edx,eax
     b07:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     b0a:	89 10                	mov    DWORD PTR [eax],edx
				*offset = pdpte;
     b0c:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     b0f:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     b12:	89 10                	mov    DWORD PTR [eax],edx
				*cntr = NULL; /* we have to reload CR3 */
     b14:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     b17:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				*level = 2;
     b1d:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     b20:	c7 00 02 00 00 00    	mov    DWORD PTR [eax],0x2
				return -1;
     b26:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b2b:	e9 2c 01 00 00       	jmp    c5c <mm_page_walk36+0x1d6>
		}

		/* PDE */
		if (!pd[pde].p || pd[pde].s) {
     b30:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     b33:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     b3a:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     b3d:	01 d0                	add    eax,edx
     b3f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     b42:	83 e0 01             	and    eax,0x1
     b45:	84 c0                	test   al,al
     b47:	74 19                	je     b62 <mm_page_walk36+0xdc>
     b49:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     b4c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     b53:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     b56:	01 d0                	add    eax,edx
     b58:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     b5b:	83 e0 80             	and    eax,0xffffff80
     b5e:	84 c0                	test   al,al
     b60:	74 79                	je     bdb <mm_page_walk36+0x155>
				*parent = &vp->pdps[pdpte];
     b62:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     b65:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     b6c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     b6f:	01 c2                	add    edx,eax
     b71:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     b74:	89 10                	mov    DWORD PTR [eax],edx
				*entry = &pd[pde];
     b76:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     b79:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     b80:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     b83:	01 c2                	add    edx,eax
     b85:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     b88:	89 10                	mov    DWORD PTR [eax],edx
				*offset = pde;
     b8a:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     b8d:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     b90:	89 10                	mov    DWORD PTR [eax],edx
				*level = 1;
     b92:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     b95:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
				*cntr = (void**)(vp->pts + pdpte * 512);
     b9b:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     b9e:	8d 50 34             	lea    edx,[eax+0x34]
     ba1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ba4:	c1 e0 0b             	shl    eax,0xb
     ba7:	01 c2                	add    edx,eax
     ba9:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     bac:	89 10                	mov    DWORD PTR [eax],edx
				/* 2M pages OK */
				return (pd[pde].s ? 0 : -1);
     bae:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     bb1:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     bb8:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     bbb:	01 d0                	add    eax,edx
     bbd:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     bc0:	83 e0 80             	and    eax,0xffffff80
     bc3:	84 c0                	test   al,al
     bc5:	74 0a                	je     bd1 <mm_page_walk36+0x14b>
     bc7:	b8 00 00 00 00       	mov    eax,0x0
     bcc:	e9 8b 00 00 00       	jmp    c5c <mm_page_walk36+0x1d6>
     bd1:	b8 ff ff ff ff       	mov    eax,0xffffffff
     bd6:	e9 81 00 00 00       	jmp    c5c <mm_page_walk36+0x1d6>
		}

		pt = vp->pts[512 * pdpte + pde];
     bdb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     bde:	c1 e0 09             	shl    eax,0x9
     be1:	89 c2                	mov    edx,eax
     be3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     be6:	01 c2                	add    edx,eax
     be8:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     beb:	83 c2 0c             	add    edx,0xc
     bee:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     bf2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* PTE */
		*parent = &pd[pde];
     bf5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     bf8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     bff:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     c02:	01 c2                	add    edx,eax
     c04:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c07:	89 10                	mov    DWORD PTR [eax],edx
		*entry = &pt[pte];
     c09:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     c0c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     c13:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c16:	01 c2                	add    edx,eax
     c18:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     c1b:	89 10                	mov    DWORD PTR [eax],edx
		*offset = pte;
     c1d:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     c20:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     c23:	89 10                	mov    DWORD PTR [eax],edx
		*cntr = NULL;
     c25:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     c28:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		*level = 0;
     c2e:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     c31:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		/* present or not? */
		return (pt[pte].p ? 0 : -1);
     c37:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     c3a:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     c41:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c44:	01 d0                	add    eax,edx
     c46:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     c49:	83 e0 01             	and    eax,0x1
     c4c:	84 c0                	test   al,al
     c4e:	74 07                	je     c57 <mm_page_walk36+0x1d1>
     c50:	b8 00 00 00 00       	mov    eax,0x0
     c55:	eb 05                	jmp    c5c <mm_page_walk36+0x1d6>
     c57:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     c5c:	c9                   	leave
     c5d:	c3                   	ret

00000c5e <mm_page_walk32>:

int mm_page_walk32(void* vm_mapping, void* virt_addr, struct pte32** parent,
				struct pte32** entry, int* level, uint32_t* offset, void*** cntr, void*** cntrm)
{
     c5e:	55                   	push   ebp
     c5f:	89 e5                	mov    ebp,esp
     c61:	83 ec 20             	sub    esp,0x20
		struct vm_pg_ptrs32* vp = vm_mapping;
     c64:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c67:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		uint32_t pde, pte;

		/* entry pointers */
		struct pte32* pd = vp->pd;
     c6a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     c6d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     c70:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		struct pte32* pt = 0;
     c73:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		*cntrm = NULL;
     c7a:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     c7d:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0

		/* and the PDE */
		pde = ((uint32_t)virt_addr & 0xffc00000) >> 22; /* 4M per PDE */
     c83:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c86:	c1 e8 16             	shr    eax,0x16
     c89:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

		/* and finally the PTE */
		pte = ((uint32_t)virt_addr & 0x3ff000) >> 12; /* 4K per PTE */
     c8c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c8f:	c1 e8 0c             	shr    eax,0xc
     c92:	25 ff 03 00 00       	and    eax,0x3ff
     c97:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* walk the hierachy */
		if (!pd) {
     c9a:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     c9e:	75 38                	jne    cd8 <mm_page_walk32+0x7a>
				*entry = *parent = 0;
     ca0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     ca3:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     ca9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     cac:	8b 10                	mov    edx,DWORD PTR [eax]
     cae:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     cb1:	89 10                	mov    DWORD PTR [eax],edx
				*offset = -1; /* CR3 invalid */
     cb3:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     cb6:	c7 00 ff ff ff ff    	mov    DWORD PTR [eax],0xffffffff
				*level = 2;
     cbc:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     cbf:	c7 00 02 00 00 00    	mov    DWORD PTR [eax],0x2
				*cntr = NULL; /* reload CR3 */
     cc5:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     cc8:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				return -1;
     cce:	b8 ff ff ff ff       	mov    eax,0xffffffff
     cd3:	e9 06 01 00 00       	jmp    dde <mm_page_walk32+0x180>
		}

		/* PDE */
		if (pd[pde].p || pd[pde].s) {
     cd8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     cdb:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     ce2:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     ce5:	01 d0                	add    eax,edx
     ce7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     cea:	83 e0 01             	and    eax,0x1
     ced:	84 c0                	test   al,al
     cef:	75 19                	jne    d0a <mm_page_walk32+0xac>
     cf1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     cf4:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     cfb:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     cfe:	01 d0                	add    eax,edx
     d00:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     d03:	83 e0 80             	and    eax,0xffffff80
     d06:	84 c0                	test   al,al
     d08:	74 60                	je     d6a <mm_page_walk32+0x10c>
				*parent = NULL;
     d0a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d0d:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				*entry = &pd[pde];
     d13:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d16:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     d1d:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     d20:	01 c2                	add    edx,eax
     d22:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     d25:	89 10                	mov    DWORD PTR [eax],edx
				*offset = pde;
     d27:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     d2a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d2d:	89 10                	mov    DWORD PTR [eax],edx
				*level = 1;
     d2f:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     d32:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
				*cntr = (void**)vp->pts;
     d38:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     d3b:	8d 50 08             	lea    edx,[eax+0x8]
     d3e:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     d41:	89 10                	mov    DWORD PTR [eax],edx
				/* 4M pages are OK */
				return (pd[pde].s ? 0 : -1);
     d43:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d46:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     d4d:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     d50:	01 d0                	add    eax,edx
     d52:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     d55:	83 e0 80             	and    eax,0xffffff80
     d58:	84 c0                	test   al,al
     d5a:	74 07                	je     d63 <mm_page_walk32+0x105>
     d5c:	b8 00 00 00 00       	mov    eax,0x0
     d61:	eb 7b                	jmp    dde <mm_page_walk32+0x180>
     d63:	b8 ff ff ff ff       	mov    eax,0xffffffff
     d68:	eb 74                	jmp    dde <mm_page_walk32+0x180>
		}

		pt = vp->pts[pde];
     d6a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     d6d:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d70:	8b 44 90 08          	mov    eax,DWORD PTR [eax+edx*4+0x8]
     d74:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* PTE */
		*parent = &pd[pde];
     d77:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d7a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     d81:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     d84:	01 c2                	add    edx,eax
     d86:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d89:	89 10                	mov    DWORD PTR [eax],edx
		*entry = &pt[pte];
     d8b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     d8e:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     d95:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d98:	01 c2                	add    edx,eax
     d9a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     d9d:	89 10                	mov    DWORD PTR [eax],edx
		*offset = pte;
     d9f:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     da2:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     da5:	89 10                	mov    DWORD PTR [eax],edx
		*level = 0;
     da7:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     daa:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		*cntr = NULL;
     db0:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     db3:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		/* present or not? */
		return (pt[pte].p ? 0 : -1);
     db9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     dbc:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     dc3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     dc6:	01 d0                	add    eax,edx
     dc8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     dcb:	83 e0 01             	and    eax,0x1
     dce:	84 c0                	test   al,al
     dd0:	74 07                	je     dd9 <mm_page_walk32+0x17b>
     dd2:	b8 00 00 00 00       	mov    eax,0x0
     dd7:	eb 05                	jmp    dde <mm_page_walk32+0x180>
     dd9:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     dde:	c9                   	leave
     ddf:	c3                   	ret

00000de0 <mm_protect>:
#endif

void mm_protect(struct mm* mm, void* virt_address, size_t num_pages, int flags)
{
     de0:	55                   	push   ebp
     de1:	89 e5                	mov    ebp,esp
     de3:	56                   	push   esi
     de4:	53                   	push   ebx
     de5:	83 ec 60             	sub    esp,0x60
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (num_pages--) {
     de8:	e9 66 07 00 00       	jmp    1553 <mm_protect+0x773>
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#else
				if (cpu.has_pae)
     ded:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
     df4:	83 e0 40             	and    eax,0x40
     df7:	84 c0                	test   al,al
     df9:	74 44                	je     e3f <mm_protect+0x5f>
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
     dfb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     dfe:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e01:	8d 55 d0             	lea    edx,[ebp-0x30]
     e04:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
     e08:	8d 55 d4             	lea    edx,[ebp-0x2c]
     e0b:	89 54 24 18          	mov    DWORD PTR [esp+0x18],edx
     e0f:	8d 55 e0             	lea    edx,[ebp-0x20]
     e12:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
     e16:	8d 55 e4             	lea    edx,[ebp-0x1c]
     e19:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
     e1d:	8d 55 d8             	lea    edx,[ebp-0x28]
     e20:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     e24:	8d 55 dc             	lea    edx,[ebp-0x24]
     e27:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     e2b:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     e2e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     e32:	89 04 24             	mov    DWORD PTR [esp],eax
     e35:	e8 fc ff ff ff       	call   e36 <mm_protect+0x56>
     e3a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     e3d:	eb 42                	jmp    e81 <mm_protect+0xa1>
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
     e3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e42:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e45:	8d 55 d0             	lea    edx,[ebp-0x30]
     e48:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
     e4c:	8d 55 d4             	lea    edx,[ebp-0x2c]
     e4f:	89 54 24 18          	mov    DWORD PTR [esp+0x18],edx
     e53:	8d 55 e0             	lea    edx,[ebp-0x20]
     e56:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
     e5a:	8d 55 e4             	lea    edx,[ebp-0x1c]
     e5d:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
     e61:	8d 55 d8             	lea    edx,[ebp-0x28]
     e64:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     e68:	8d 55 dc             	lea    edx,[ebp-0x24]
     e6b:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     e6f:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     e72:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     e76:	89 04 24             	mov    DWORD PTR [esp],eax
     e79:	e8 fc ff ff ff       	call   e7a <mm_protect+0x9a>
     e7e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
     e81:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     e85:	0f 85 db 06 00 00    	jne    1566 <mm_protect+0x786>
						return;

				e32 = NULL; e64 = NULL;
     e8b:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     e92:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (!cpu.has_pae)
     e99:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
     ea0:	83 e0 40             	and    eax,0x40
     ea3:	84 c0                	test   al,al
     ea5:	75 08                	jne    eaf <mm_protect+0xcf>
						e32 = e;
     ea7:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     eaa:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     ead:	eb 06                	jmp    eb5 <mm_protect+0xd5>
				else
						e64 = e;
     eaf:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     eb2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		
				/* set/unset or override */
				if (flags & MMGR_MAP_PURGE_ACC)
     eb5:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     eb8:	25 00 04 00 00       	and    eax,0x400
     ebd:	85 c0                	test   eax,eax
     ebf:	74 26                	je     ee7 <mm_protect+0x107>
						if (e64)
     ec1:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     ec5:	74 10                	je     ed7 <mm_protect+0xf7>
								e64->a = 0;
     ec7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     eca:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     ecd:	83 e2 df             	and    edx,0xffffffdf
     ed0:	88 10                	mov    BYTE PTR [eax],dl
     ed2:	e9 00 06 00 00       	jmp    14d7 <mm_protect+0x6f7>
						else
								e32->a = 0;
     ed7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     eda:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     edd:	83 e2 df             	and    edx,0xffffffdf
     ee0:	88 10                	mov    BYTE PTR [eax],dl
     ee2:	e9 f0 05 00 00       	jmp    14d7 <mm_protect+0x6f7>
				else if (flags & MMGR_MAP_PURGE_DIRTY)
     ee7:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     eea:	25 00 08 00 00       	and    eax,0x800
     eef:	85 c0                	test   eax,eax
     ef1:	74 26                	je     f19 <mm_protect+0x139>
						if (e64)
     ef3:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     ef7:	74 10                	je     f09 <mm_protect+0x129>
								e64->d = 0;
     ef9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     efc:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     eff:	83 e2 bf             	and    edx,0xffffffbf
     f02:	88 10                	mov    BYTE PTR [eax],dl
     f04:	e9 ce 05 00 00       	jmp    14d7 <mm_protect+0x6f7>
						else
								e32->d = 0;
     f09:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     f0c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     f0f:	83 e2 bf             	and    edx,0xffffffbf
     f12:	88 10                	mov    BYTE PTR [eax],dl
     f14:	e9 be 05 00 00       	jmp    14d7 <mm_protect+0x6f7>
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
     f19:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f1c:	25 00 10 00 00       	and    eax,0x1000
     f21:	85 c0                	test   eax,eax
     f23:	75 10                	jne    f35 <mm_protect+0x155>
     f25:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f28:	25 00 20 00 00       	and    eax,0x2000
     f2d:	85 c0                	test   eax,eax
     f2f:	0f 84 03 03 00 00    	je     1238 <mm_protect+0x458>
						char v = !!(flags & MMGR_MAP_SET); /* 1 or 0 */
     f35:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f38:	25 00 10 00 00       	and    eax,0x1000
     f3d:	85 c0                	test   eax,eax
     f3f:	0f 95 c0             	setne  al
     f42:	88 45 eb             	mov    BYTE PTR [ebp-0x15],al
						if (e64) {
     f45:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     f49:	0f 84 bb 01 00 00    	je     110a <mm_protect+0x32a>
								if (flags & MMGR_MAP_WRITE)
     f4f:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f52:	83 e0 04             	and    eax,0x4
     f55:	85 c0                	test   eax,eax
     f57:	74 1c                	je     f75 <mm_protect+0x195>
										e64->w = v;
     f59:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
     f5d:	83 e0 01             	and    eax,0x1
     f60:	89 c2                	mov    edx,eax
     f62:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     f65:	83 e2 01             	and    edx,0x1
     f68:	8d 0c 12             	lea    ecx,[edx+edx*1]
     f6b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     f6e:	83 e2 fd             	and    edx,0xfffffffd
     f71:	09 ca                	or     edx,ecx
     f73:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_WRITE_THROUGH)
     f75:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f78:	83 e0 10             	and    eax,0x10
     f7b:	85 c0                	test   eax,eax
     f7d:	74 20                	je     f9f <mm_protect+0x1bf>
										e64->wt = v;
     f7f:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
     f83:	83 e0 01             	and    eax,0x1
     f86:	89 c2                	mov    edx,eax
     f88:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     f8b:	83 e2 01             	and    edx,0x1
     f8e:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
     f95:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     f98:	83 e2 f7             	and    edx,0xfffffff7
     f9b:	09 ca                	or     edx,ecx
     f9d:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_NO_CACHING)
     f9f:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     fa2:	83 e0 20             	and    eax,0x20
     fa5:	85 c0                	test   eax,eax
     fa7:	74 1e                	je     fc7 <mm_protect+0x1e7>
										e64->cd = v;
     fa9:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
     fad:	83 e0 01             	and    eax,0x1
     fb0:	89 c2                	mov    edx,eax
     fb2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     fb5:	83 e2 01             	and    edx,0x1
     fb8:	89 d1                	mov    ecx,edx
     fba:	c1 e1 04             	shl    ecx,0x4
     fbd:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     fc0:	83 e2 ef             	and    edx,0xffffffef
     fc3:	09 ca                	or     edx,ecx
     fc5:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_PAT)
     fc7:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     fca:	25 80 00 00 00       	and    eax,0x80
     fcf:	85 c0                	test   eax,eax
     fd1:	0f 84 b4 00 00 00    	je     108b <mm_protect+0x2ab>
										if (lv > 0)
     fd7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     fda:	85 c0                	test   eax,eax
     fdc:	0f 8e 8e 00 00 00    	jle    1070 <mm_protect+0x290>
												e64->addr = (e64->addr & ~1) | v;
     fe2:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     fe5:	8b 19                	mov    ebx,DWORD PTR [ecx]
     fe7:	89 de                	mov    esi,ebx
     fe9:	c1 ee 0c             	shr    esi,0xc
     fec:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
     ff0:	81 e3 ff 0f 00 00    	and    ebx,0xfff
     ff6:	c1 e3 14             	shl    ebx,0x14
     ff9:	09 f3                	or     ebx,esi
     ffb:	89 d8                	mov    eax,ebx
     ffd:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    1000:	c1 e9 0c             	shr    ecx,0xc
    1003:	0f b6 d1             	movzx  edx,cl
    1006:	83 e0 fe             	and    eax,0xfffffffe
    1009:	81 e2 ff 00 00 00    	and    edx,0xff
    100f:	89 c1                	mov    ecx,eax
    1011:	89 d3                	mov    ebx,edx
    1013:	0f be 45 eb          	movsx  eax,BYTE PTR [ebp-0x15]
    1017:	99                   	cdq
    1018:	81 e2 ff 00 00 00    	and    edx,0xff
    101e:	09 c8                	or     eax,ecx
    1020:	09 da                	or     edx,ebx
    1022:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1025:	89 c3                	mov    ebx,eax
    1027:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    102d:	89 de                	mov    esi,ebx
    102f:	c1 e6 0c             	shl    esi,0xc
    1032:	8b 19                	mov    ebx,DWORD PTR [ecx]
    1034:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    103a:	09 f3                	or     ebx,esi
    103c:	89 19                	mov    DWORD PTR [ecx],ebx
    103e:	89 c3                	mov    ebx,eax
    1040:	c1 eb 14             	shr    ebx,0x14
    1043:	89 de                	mov    esi,ebx
    1045:	66 81 e6 ff 0f       	and    si,0xfff
    104a:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    104e:	66 81 e3 00 f0       	and    bx,0xf000
    1053:	09 f3                	or     ebx,esi
    1055:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    1059:	0f b6 c2             	movzx  eax,dl
    105c:	c1 e0 0c             	shl    eax,0xc
    105f:	89 c2                	mov    edx,eax
    1061:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    1064:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    1069:	09 d0                	or     eax,edx
    106b:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
    106e:	eb 1b                	jmp    108b <mm_protect+0x2ab>
										else
												e64->s = v;
    1070:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    1074:	83 e0 01             	and    eax,0x1
    1077:	89 c2                	mov    edx,eax
    1079:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    107c:	89 d1                	mov    ecx,edx
    107e:	c1 e1 07             	shl    ecx,0x7
    1081:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1084:	83 e2 7f             	and    edx,0x7f
    1087:	09 ca                	or     edx,ecx
    1089:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_GLOBAL)
    108b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    108e:	83 e0 40             	and    eax,0x40
    1091:	85 c0                	test   eax,eax
    1093:	74 1d                	je     10b2 <mm_protect+0x2d2>
										e64->g = v;
    1095:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    1099:	83 e0 01             	and    eax,0x1
    109c:	89 c2                	mov    edx,eax
    109e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    10a1:	89 d1                	mov    ecx,edx
    10a3:	83 e1 01             	and    ecx,0x1
    10a6:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    10aa:	83 e2 fe             	and    edx,0xfffffffe
    10ad:	09 ca                	or     edx,ecx
    10af:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								if (flags & MMGR_MAP_KERNEL)
    10b2:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    10b5:	83 e0 08             	and    eax,0x8
    10b8:	85 c0                	test   eax,eax
    10ba:	74 1e                	je     10da <mm_protect+0x2fa>
										e64->u = !v;
    10bc:	80 7d eb 00          	cmp    BYTE PTR [ebp-0x15],0x0
    10c0:	0f 94 c2             	sete   dl
    10c3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    10c6:	83 e2 01             	and    edx,0x1
    10c9:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    10d0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    10d3:	83 e2 fb             	and    edx,0xfffffffb
    10d6:	09 ca                	or     edx,ecx
    10d8:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_EXECUTE)
    10da:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    10dd:	83 e0 02             	and    eax,0x2
    10e0:	85 c0                	test   eax,eax
    10e2:	0f 84 ee 03 00 00    	je     14d6 <mm_protect+0x6f6>
										e64->xd = v;
    10e8:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    10ec:	83 e0 01             	and    eax,0x1
    10ef:	89 c2                	mov    edx,eax
    10f1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    10f4:	89 d1                	mov    ecx,edx
    10f6:	c1 e1 07             	shl    ecx,0x7
    10f9:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    10fd:	83 e2 7f             	and    edx,0x7f
    1100:	09 ca                	or     edx,ecx
    1102:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    1105:	e9 cc 03 00 00       	jmp    14d6 <mm_protect+0x6f6>
						} else {
								if (flags & MMGR_MAP_WRITE)
    110a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    110d:	83 e0 04             	and    eax,0x4
    1110:	85 c0                	test   eax,eax
    1112:	74 1c                	je     1130 <mm_protect+0x350>
										e32->w = v;
    1114:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    1118:	83 e0 01             	and    eax,0x1
    111b:	89 c2                	mov    edx,eax
    111d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1120:	83 e2 01             	and    edx,0x1
    1123:	8d 0c 12             	lea    ecx,[edx+edx*1]
    1126:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1129:	83 e2 fd             	and    edx,0xfffffffd
    112c:	09 ca                	or     edx,ecx
    112e:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_WRITE_THROUGH)
    1130:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1133:	83 e0 10             	and    eax,0x10
    1136:	85 c0                	test   eax,eax
    1138:	74 20                	je     115a <mm_protect+0x37a>
										e32->wt = v;
    113a:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    113e:	83 e0 01             	and    eax,0x1
    1141:	89 c2                	mov    edx,eax
    1143:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1146:	83 e2 01             	and    edx,0x1
    1149:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    1150:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1153:	83 e2 f7             	and    edx,0xfffffff7
    1156:	09 ca                	or     edx,ecx
    1158:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_NO_CACHING)
    115a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    115d:	83 e0 20             	and    eax,0x20
    1160:	85 c0                	test   eax,eax
    1162:	74 1e                	je     1182 <mm_protect+0x3a2>
										e32->cd = v;
    1164:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    1168:	83 e0 01             	and    eax,0x1
    116b:	89 c2                	mov    edx,eax
    116d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1170:	83 e2 01             	and    edx,0x1
    1173:	89 d1                	mov    ecx,edx
    1175:	c1 e1 04             	shl    ecx,0x4
    1178:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    117b:	83 e2 ef             	and    edx,0xffffffef
    117e:	09 ca                	or     edx,ecx
    1180:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_PAT)
    1182:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1185:	25 80 00 00 00       	and    eax,0x80
    118a:	85 c0                	test   eax,eax
    118c:	74 52                	je     11e0 <mm_protect+0x400>
										if (lv > 0)
    118e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1191:	85 c0                	test   eax,eax
    1193:	7e 30                	jle    11c5 <mm_protect+0x3e5>
												e32->addr = (e32->addr & ~1) | v;
    1195:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1198:	8b 00                	mov    eax,DWORD PTR [eax]
    119a:	c1 e8 0c             	shr    eax,0xc
    119d:	83 e0 fe             	and    eax,0xfffffffe
    11a0:	89 c2                	mov    edx,eax
    11a2:	0f be 45 eb          	movsx  eax,BYTE PTR [ebp-0x15]
    11a6:	09 d0                	or     eax,edx
    11a8:	25 ff ff 0f 00       	and    eax,0xfffff
    11ad:	89 c2                	mov    edx,eax
    11af:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11b2:	89 d1                	mov    ecx,edx
    11b4:	c1 e1 0c             	shl    ecx,0xc
    11b7:	8b 10                	mov    edx,DWORD PTR [eax]
    11b9:	81 e2 ff 0f 00 00    	and    edx,0xfff
    11bf:	09 ca                	or     edx,ecx
    11c1:	89 10                	mov    DWORD PTR [eax],edx
    11c3:	eb 1b                	jmp    11e0 <mm_protect+0x400>
										else
												e32->s = v;
    11c5:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    11c9:	83 e0 01             	and    eax,0x1
    11cc:	89 c2                	mov    edx,eax
    11ce:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11d1:	89 d1                	mov    ecx,edx
    11d3:	c1 e1 07             	shl    ecx,0x7
    11d6:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    11d9:	83 e2 7f             	and    edx,0x7f
    11dc:	09 ca                	or     edx,ecx
    11de:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_GLOBAL)
    11e0:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    11e3:	83 e0 40             	and    eax,0x40
    11e6:	85 c0                	test   eax,eax
    11e8:	74 1d                	je     1207 <mm_protect+0x427>
										e32->g = v;
    11ea:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    11ee:	83 e0 01             	and    eax,0x1
    11f1:	89 c2                	mov    edx,eax
    11f3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11f6:	89 d1                	mov    ecx,edx
    11f8:	83 e1 01             	and    ecx,0x1
    11fb:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    11ff:	83 e2 fe             	and    edx,0xfffffffe
    1202:	09 ca                	or     edx,ecx
    1204:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								if (flags & MMGR_MAP_KERNEL)
    1207:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    120a:	83 e0 08             	and    eax,0x8
    120d:	85 c0                	test   eax,eax
    120f:	0f 84 c1 02 00 00    	je     14d6 <mm_protect+0x6f6>
										e32->u = !v;
    1215:	80 7d eb 00          	cmp    BYTE PTR [ebp-0x15],0x0
    1219:	0f 94 c2             	sete   dl
    121c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    121f:	83 e2 01             	and    edx,0x1
    1222:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    1229:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    122c:	83 e2 fb             	and    edx,0xfffffffb
    122f:	09 ca                	or     edx,ecx
    1231:	88 10                	mov    BYTE PTR [eax],dl
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    1233:	e9 9e 02 00 00       	jmp    14d6 <mm_protect+0x6f6>
								//if (flags & MMGR_MAP_EXECUTE)
								//		e32->xd = v;
						}
				} else {
						if (e64) {
    1238:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    123c:	0f 84 8f 01 00 00    	je     13d1 <mm_protect+0x5f1>
								e64->w = !!(flags & MMGR_MAP_WRITE);
    1242:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1245:	83 e0 04             	and    eax,0x4
    1248:	85 c0                	test   eax,eax
    124a:	0f 95 c2             	setne  dl
    124d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1250:	83 e2 01             	and    edx,0x1
    1253:	8d 0c 12             	lea    ecx,[edx+edx*1]
    1256:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1259:	83 e2 fd             	and    edx,0xfffffffd
    125c:	09 ca                	or     edx,ecx
    125e:	88 10                	mov    BYTE PTR [eax],dl
								e64->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
    1260:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1263:	83 e0 10             	and    eax,0x10
    1266:	85 c0                	test   eax,eax
    1268:	0f 95 c2             	setne  dl
    126b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    126e:	83 e2 01             	and    edx,0x1
    1271:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    1278:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    127b:	83 e2 f7             	and    edx,0xfffffff7
    127e:	09 ca                	or     edx,ecx
    1280:	88 10                	mov    BYTE PTR [eax],dl
								e64->cd = !!(flags & MMGR_MAP_NO_CACHING);
    1282:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1285:	83 e0 20             	and    eax,0x20
    1288:	85 c0                	test   eax,eax
    128a:	0f 95 c2             	setne  dl
    128d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1290:	83 e2 01             	and    edx,0x1
    1293:	89 d1                	mov    ecx,edx
    1295:	c1 e1 04             	shl    ecx,0x4
    1298:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    129b:	83 e2 ef             	and    edx,0xffffffef
    129e:	09 ca                	or     edx,ecx
    12a0:	88 10                	mov    BYTE PTR [eax],dl
								if (lv > 0)
    12a2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12a5:	85 c0                	test   eax,eax
    12a7:	0f 8e a0 00 00 00    	jle    134d <mm_protect+0x56d>
										e64->addr = (e64->addr & ~1) | !!(flags & MMGR_MAP_PAT);
    12ad:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    12b0:	8b 19                	mov    ebx,DWORD PTR [ecx]
    12b2:	89 de                	mov    esi,ebx
    12b4:	c1 ee 0c             	shr    esi,0xc
    12b7:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    12bb:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    12c1:	c1 e3 14             	shl    ebx,0x14
    12c4:	09 f3                	or     ebx,esi
    12c6:	89 d8                	mov    eax,ebx
    12c8:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    12cb:	c1 e9 0c             	shr    ecx,0xc
    12ce:	0f b6 d1             	movzx  edx,cl
    12d1:	83 e0 fe             	and    eax,0xfffffffe
    12d4:	81 e2 ff 00 00 00    	and    edx,0xff
    12da:	89 c1                	mov    ecx,eax
    12dc:	89 d3                	mov    ebx,edx
    12de:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    12e1:	25 80 00 00 00       	and    eax,0x80
    12e6:	85 c0                	test   eax,eax
    12e8:	0f 95 45 c7          	setne  BYTE PTR [ebp-0x39]
    12ec:	0f b6 45 c7          	movzx  eax,BYTE PTR [ebp-0x39]
    12f0:	ba 00 00 00 00       	mov    edx,0x0
    12f5:	81 e2 ff 00 00 00    	and    edx,0xff
    12fb:	09 c8                	or     eax,ecx
    12fd:	09 da                	or     edx,ebx
    12ff:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1302:	89 c3                	mov    ebx,eax
    1304:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    130a:	89 de                	mov    esi,ebx
    130c:	c1 e6 0c             	shl    esi,0xc
    130f:	8b 19                	mov    ebx,DWORD PTR [ecx]
    1311:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    1317:	09 f3                	or     ebx,esi
    1319:	89 19                	mov    DWORD PTR [ecx],ebx
    131b:	89 c3                	mov    ebx,eax
    131d:	c1 eb 14             	shr    ebx,0x14
    1320:	89 de                	mov    esi,ebx
    1322:	66 81 e6 ff 0f       	and    si,0xfff
    1327:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    132b:	66 81 e3 00 f0       	and    bx,0xf000
    1330:	09 f3                	or     ebx,esi
    1332:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    1336:	0f b6 c2             	movzx  eax,dl
    1339:	c1 e0 0c             	shl    eax,0xc
    133c:	89 c2                	mov    edx,eax
    133e:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    1341:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    1346:	09 d0                	or     eax,edx
    1348:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
    134b:	eb 1f                	jmp    136c <mm_protect+0x58c>
								else
										e64->s = !!(flags & MMGR_MAP_PAT);
    134d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1350:	25 80 00 00 00       	and    eax,0x80
    1355:	85 c0                	test   eax,eax
    1357:	0f 95 c2             	setne  dl
    135a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    135d:	89 d1                	mov    ecx,edx
    135f:	c1 e1 07             	shl    ecx,0x7
    1362:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1365:	83 e2 7f             	and    edx,0x7f
    1368:	09 ca                	or     edx,ecx
    136a:	88 10                	mov    BYTE PTR [eax],dl
								e64->g = !!(flags & MMGR_MAP_GLOBAL);
    136c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    136f:	83 e0 40             	and    eax,0x40
    1372:	85 c0                	test   eax,eax
    1374:	0f 95 c2             	setne  dl
    1377:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    137a:	89 d1                	mov    ecx,edx
    137c:	83 e1 01             	and    ecx,0x1
    137f:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    1383:	83 e2 fe             	and    edx,0xfffffffe
    1386:	09 ca                	or     edx,ecx
    1388:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								e64->u = !(flags & MMGR_MAP_KERNEL);
    138b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    138e:	83 e0 08             	and    eax,0x8
    1391:	85 c0                	test   eax,eax
    1393:	0f 94 c2             	sete   dl
    1396:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1399:	83 e2 01             	and    edx,0x1
    139c:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    13a3:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    13a6:	83 e2 fb             	and    edx,0xfffffffb
    13a9:	09 ca                	or     edx,ecx
    13ab:	88 10                	mov    BYTE PTR [eax],dl
								e64->xd = !!(flags & MMGR_MAP_EXECUTE);
    13ad:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    13b0:	83 e0 02             	and    eax,0x2
    13b3:	85 c0                	test   eax,eax
    13b5:	0f 95 c2             	setne  dl
    13b8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    13bb:	89 d1                	mov    ecx,edx
    13bd:	c1 e1 07             	shl    ecx,0x7
    13c0:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    13c4:	83 e2 7f             	and    edx,0x7f
    13c7:	09 ca                	or     edx,ecx
    13c9:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
    13cc:	e9 06 01 00 00       	jmp    14d7 <mm_protect+0x6f7>
						} else {
								e32->w = !!(flags & MMGR_MAP_WRITE);
    13d1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    13d4:	83 e0 04             	and    eax,0x4
    13d7:	85 c0                	test   eax,eax
    13d9:	0f 95 c2             	setne  dl
    13dc:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    13df:	83 e2 01             	and    edx,0x1
    13e2:	8d 0c 12             	lea    ecx,[edx+edx*1]
    13e5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    13e8:	83 e2 fd             	and    edx,0xfffffffd
    13eb:	09 ca                	or     edx,ecx
    13ed:	88 10                	mov    BYTE PTR [eax],dl
								e32->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
    13ef:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    13f2:	83 e0 10             	and    eax,0x10
    13f5:	85 c0                	test   eax,eax
    13f7:	0f 95 c2             	setne  dl
    13fa:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    13fd:	83 e2 01             	and    edx,0x1
    1400:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    1407:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    140a:	83 e2 f7             	and    edx,0xfffffff7
    140d:	09 ca                	or     edx,ecx
    140f:	88 10                	mov    BYTE PTR [eax],dl
								e32->cd = !!(flags & MMGR_MAP_NO_CACHING);
    1411:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1414:	83 e0 20             	and    eax,0x20
    1417:	85 c0                	test   eax,eax
    1419:	0f 95 c2             	setne  dl
    141c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    141f:	83 e2 01             	and    edx,0x1
    1422:	89 d1                	mov    ecx,edx
    1424:	c1 e1 04             	shl    ecx,0x4
    1427:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    142a:	83 e2 ef             	and    edx,0xffffffef
    142d:	09 ca                	or     edx,ecx
    142f:	88 10                	mov    BYTE PTR [eax],dl
								if (lv > 0)
    1431:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1434:	85 c0                	test   eax,eax
    1436:	7e 3c                	jle    1474 <mm_protect+0x694>
										e32->addr = (e32->addr & ~1) | !!(flags & MMGR_MAP_PAT);
    1438:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    143b:	8b 00                	mov    eax,DWORD PTR [eax]
    143d:	c1 e8 0c             	shr    eax,0xc
    1440:	83 e0 fe             	and    eax,0xfffffffe
    1443:	89 c2                	mov    edx,eax
    1445:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1448:	25 80 00 00 00       	and    eax,0x80
    144d:	85 c0                	test   eax,eax
    144f:	0f 95 c0             	setne  al
    1452:	0f b6 c0             	movzx  eax,al
    1455:	09 d0                	or     eax,edx
    1457:	25 ff ff 0f 00       	and    eax,0xfffff
    145c:	89 c2                	mov    edx,eax
    145e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1461:	89 d1                	mov    ecx,edx
    1463:	c1 e1 0c             	shl    ecx,0xc
    1466:	8b 10                	mov    edx,DWORD PTR [eax]
    1468:	81 e2 ff 0f 00 00    	and    edx,0xfff
    146e:	09 ca                	or     edx,ecx
    1470:	89 10                	mov    DWORD PTR [eax],edx
    1472:	eb 1f                	jmp    1493 <mm_protect+0x6b3>
								else
										e32->s = !!(flags & MMGR_MAP_PAT);
    1474:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1477:	25 80 00 00 00       	and    eax,0x80
    147c:	85 c0                	test   eax,eax
    147e:	0f 95 c2             	setne  dl
    1481:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1484:	89 d1                	mov    ecx,edx
    1486:	c1 e1 07             	shl    ecx,0x7
    1489:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    148c:	83 e2 7f             	and    edx,0x7f
    148f:	09 ca                	or     edx,ecx
    1491:	88 10                	mov    BYTE PTR [eax],dl
								e32->g = !!(flags & MMGR_MAP_GLOBAL);
    1493:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1496:	83 e0 40             	and    eax,0x40
    1499:	85 c0                	test   eax,eax
    149b:	0f 95 c2             	setne  dl
    149e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    14a1:	89 d1                	mov    ecx,edx
    14a3:	83 e1 01             	and    ecx,0x1
    14a6:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    14aa:	83 e2 fe             	and    edx,0xfffffffe
    14ad:	09 ca                	or     edx,ecx
    14af:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								e32->u = !(flags & MMGR_MAP_KERNEL);
    14b2:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    14b5:	83 e0 08             	and    eax,0x8
    14b8:	85 c0                	test   eax,eax
    14ba:	0f 94 c2             	sete   dl
    14bd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    14c0:	83 e2 01             	and    edx,0x1
    14c3:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    14ca:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    14cd:	83 e2 fb             	and    edx,0xfffffffb
    14d0:	09 ca                	or     edx,ecx
    14d2:	88 10                	mov    BYTE PTR [eax],dl
    14d4:	eb 01                	jmp    14d7 <mm_protect+0x6f7>
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    14d6:	90                   	nop
								//e32->xd = !!(flags & MMGR_MAP_EXECUTE);
						}
				}

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
    14d7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    14da:	89 04 24             	mov    DWORD PTR [esp],eax
    14dd:	e8 32 eb ff ff       	call   14 <flush_tlb_single>
		
				/* advance */
				if (!lv) /* regular page */
    14e2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    14e5:	85 c0                	test   eax,eax
    14e7:	75 09                	jne    14f2 <mm_protect+0x712>
						virt_address += 4096;
    14e9:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
    14f0:	eb 61                	jmp    1553 <mm_protect+0x773>
				else if (lv == 1) /* large page 2M/4M */
    14f2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    14f5:	83 f8 01             	cmp    eax,0x1
    14f8:	75 1f                	jne    1519 <mm_protect+0x739>
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
    14fa:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1501:	83 e0 40             	and    eax,0x40
    1504:	84 c0                	test   al,al
    1506:	74 07                	je     150f <mm_protect+0x72f>
    1508:	b8 00 00 80 00       	mov    eax,0x800000
    150d:	eb 05                	jmp    1514 <mm_protect+0x734>
    150f:	b8 00 00 00 01       	mov    eax,0x1000000
    1514:	01 45 0c             	add    DWORD PTR [ebp+0xc],eax
    1517:	eb 3a                	jmp    1553 <mm_protect+0x773>
				else if (lv == 2) /* huge page 1G */
    1519:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    151c:	83 f8 02             	cmp    eax,0x2
    151f:	75 09                	jne    152a <mm_protect+0x74a>
						virt_address += 1024 * 1024 * 1024;
    1521:	81 45 0c 00 00 00 40 	add    DWORD PTR [ebp+0xc],0x40000000
    1528:	eb 29                	jmp    1553 <mm_protect+0x773>
				else
						die("ginormous page?\n");
    152a:	c7 44 24 04 90 00 00 00 	mov    DWORD PTR [esp+0x4],0x90
    1532:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1539:	e8 fc ff ff ff       	call   153a <mm_protect+0x75a>
    153e:	e8 fc ff ff ff       	call   153f <mm_protect+0x75f>
    1543:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    154a:	e8 fc ff ff ff       	call   154b <mm_protect+0x76b>
    154f:	fa                   	cli
    1550:	f4                   	hlt
    1551:	eb fd                	jmp    1550 <mm_protect+0x770>
		while (num_pages--) {
    1553:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1556:	8d 50 ff             	lea    edx,[eax-0x1]
    1559:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    155c:	85 c0                	test   eax,eax
    155e:	0f 85 89 f8 ff ff    	jne    ded <mm_protect+0xd>
    1564:	eb 01                	jmp    1567 <mm_protect+0x787>
						return;
    1566:	90                   	nop
		}
}
    1567:	83 c4 60             	add    esp,0x60
    156a:	5b                   	pop    ebx
    156b:	5e                   	pop    esi
    156c:	5d                   	pop    ebp
    156d:	c3                   	ret

0000156e <mm_reserve_vmem>:

void* mm_reserve_vmem(struct mm* mm, size_t pg_ct, int flags)
{
    156e:	55                   	push   ebp
    156f:	89 e5                	mov    ebp,esp
    1571:	83 ec 28             	sub    esp,0x28
		void* rv = __sync_fetch_and_add(&mm->qnd_ptr, pg_ct * 4096);
    1574:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1577:	c1 e0 0c             	shl    eax,0xc
    157a:	89 c2                	mov    edx,eax
    157c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    157f:	83 c0 0c             	add    eax,0xc
    1582:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    1586:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		printf("mm reserved at %x\n", rv);
    1589:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    158c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1590:	c7 04 24 a1 00 00 00 	mov    DWORD PTR [esp],0xa1
    1597:	e8 fc ff ff ff       	call   1598 <mm_reserve_vmem+0x2a>
		if (rv + pg_ct * 4096 > VM_QND_LIMIT)
    159c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    159f:	c1 e0 0c             	shl    eax,0xc
    15a2:	89 c2                	mov    edx,eax
    15a4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    15a7:	01 d0                	add    eax,edx
    15a9:	3d 00 00 00 a0       	cmp    eax,0xa0000000
    15ae:	76 29                	jbe    15d9 <mm_reserve_vmem+0x6b>
				die("Out of QnD VM reservation ranges. Impelment a map!\n");
    15b0:	c7 44 24 04 b4 00 00 00 	mov    DWORD PTR [esp+0x4],0xb4
    15b8:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    15bf:	e8 fc ff ff ff       	call   15c0 <mm_reserve_vmem+0x52>
    15c4:	e8 fc ff ff ff       	call   15c5 <mm_reserve_vmem+0x57>
    15c9:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    15d0:	e8 fc ff ff ff       	call   15d1 <mm_reserve_vmem+0x63>
    15d5:	fa                   	cli
    15d6:	f4                   	hlt
    15d7:	eb fd                	jmp    15d6 <mm_reserve_vmem+0x68>
		return rv;
    15d9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    15dc:	c9                   	leave
    15dd:	c3                   	ret

000015de <mm_aoa_range>:

void mm_aoa_range(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
    15de:	55                   	push   ebp
    15df:	89 e5                	mov    ebp,esp
    15e1:	56                   	push   esi
    15e2:	53                   	push   ebx
    15e3:	83 c4 80             	add    esp,0xffffff80
		int x = flags & MMGR_MAP_EXECUTE, w = flags & MMGR_MAP_WRITE,
    15e6:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    15e9:	83 e0 02             	and    eax,0x2
    15ec:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    15ef:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    15f2:	83 e0 04             	and    eax,0x4
    15f5:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
			wc = flags & MMGR_MAP_PAT, wt = flags & MMGR_MAP_WRITE_THROUGH,
    15f8:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    15fb:	25 80 00 00 00       	and    eax,0x80
    1600:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1603:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1606:	83 e0 10             	and    eax,0x10
    1609:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
			cd = flags & MMGR_MAP_NO_CACHING, g = flags & MMGR_MAP_GLOBAL,
    160c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    160f:	83 e0 20             	and    eax,0x20
    1612:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1615:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1618:	83 e0 40             	and    eax,0x40
    161b:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
			u = !(flags & MMGR_MAP_KERNEL);
    161e:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1621:	83 e0 08             	and    eax,0x8
    1624:	85 c0                	test   eax,eax
    1626:	0f 94 c0             	sete   al
    1629:	0f b6 c0             	movzx  eax,al
    162c:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		int avl = MMGR_AVL_AOA, lvl; uint32_t ofs;
    162f:	c7 45 d0 04 00 00 00 	mov    DWORD PTR [ebp-0x30],0x4
		void *p, *e, **cntr, **cntrm; /* page walk: cntr (last one), cntrm (missing)*/

		while (pg_ct) {
    1636:	e9 6f 05 00 00       	jmp    1baa <mm_aoa_range+0x5cc>
redo:
				if (!mm_page_walk(mm, virt_address, &p, &e, &lvl,
    163b:	8d 45 ac             	lea    eax,[ebp-0x54]
    163e:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    1642:	8d 45 b0             	lea    eax,[ebp-0x50]
    1645:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    1649:	8d 45 bc             	lea    eax,[ebp-0x44]
    164c:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    1650:	8d 45 c0             	lea    eax,[ebp-0x40]
    1653:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1657:	8d 45 b4             	lea    eax,[ebp-0x4c]
    165a:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    165e:	8d 45 b8             	lea    eax,[ebp-0x48]
    1661:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1665:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1668:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    166c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    166f:	89 04 24             	mov    DWORD PTR [esp],eax
    1672:	e8 fc ff ff ff       	call   1673 <mm_aoa_range+0x95>
    1677:	85 c0                	test   eax,eax
    1679:	75 30                	jne    16ab <mm_aoa_range+0xcd>
										&ofs, &cntr, &cntrm)) {
						/* present entry! */
present:
    167b:	90                   	nop
    167c:	eb 04                	jmp    1682 <mm_aoa_range+0xa4>
				if (!cpu.has_pae) {
						struct pte32* pte = e;
						while (ofs < 1024) {
								/* check for present */
								if (pte->p)
										goto present;
    167e:	90                   	nop
    167f:	eb 01                	jmp    1682 <mm_aoa_range+0xa4>
				} else {
						struct pte64* pte = e;
						while (ofs < 512) {
								/* check for present */
								if (pte->p)
										goto present;
    1681:	90                   	nop
						die("encountered present entry while AOA alloc\n");
    1682:	c7 44 24 04 e8 00 00 00 	mov    DWORD PTR [esp+0x4],0xe8
    168a:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1691:	e8 fc ff ff ff       	call   1692 <mm_aoa_range+0xb4>
    1696:	e8 fc ff ff ff       	call   1697 <mm_aoa_range+0xb9>
    169b:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    16a2:	e8 fc ff ff ff       	call   16a3 <mm_aoa_range+0xc5>
    16a7:	fa                   	cli
    16a8:	f4                   	hlt
    16a9:	eb fd                	jmp    16a8 <mm_aoa_range+0xca>
				if (lvl > 0) {
    16ab:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    16ae:	85 c0                	test   eax,eax
    16b0:	0f 8e 10 02 00 00    	jle    18c6 <mm_aoa_range+0x2e8>
						if (lvl == 1) {
    16b6:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    16b9:	83 f8 01             	cmp    eax,0x1
    16bc:	0f 85 a4 01 00 00    	jne    1866 <mm_aoa_range+0x288>
								if (ENTER_CS_PTE(cntr[ofs])) {
    16c2:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    16c5:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    16c8:	c1 e2 02             	shl    edx,0x2
    16cb:	01 c2                	add    edx,eax
    16cd:	b8 00 00 00 00       	mov    eax,0x0
    16d2:	b9 ff ff ff ff       	mov    ecx,0xffffffff
    16d7:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    16db:	0f 94 c0             	sete   al
    16de:	84 c0                	test   al,al
    16e0:	0f 84 69 01 00 00    	je     184f <mm_aoa_range+0x271>
										ptr = mm_alloc_page(&b);
    16e6:	8d 45 a0             	lea    eax,[ebp-0x60]
    16e9:	89 04 24             	mov    DWORD PTR [esp],eax
    16ec:	e8 fc ff ff ff       	call   16ed <mm_aoa_range+0x10f>
    16f1:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
										if (cpu.has_pae) {
    16f4:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    16fb:	83 e0 40             	and    eax,0x40
    16fe:	84 c0                	test   al,al
    1700:	0f 84 b8 00 00 00    	je     17be <mm_aoa_range+0x1e0>
												struct pte64* pd = e;
    1706:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1709:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
												pd[ofs].addr = b / 4096;
    170c:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    170f:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1712:	0f ac d0 0c          	shrd   eax,edx,0xc
    1716:	c1 ea 0c             	shr    edx,0xc
    1719:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    171c:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    1723:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    1726:	01 d9                	add    ecx,ebx
    1728:	81 e2 ff 00 00 00    	and    edx,0xff
    172e:	89 c3                	mov    ebx,eax
    1730:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    1736:	89 de                	mov    esi,ebx
    1738:	c1 e6 0c             	shl    esi,0xc
    173b:	8b 19                	mov    ebx,DWORD PTR [ecx]
    173d:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    1743:	09 f3                	or     ebx,esi
    1745:	89 19                	mov    DWORD PTR [ecx],ebx
    1747:	89 c3                	mov    ebx,eax
    1749:	c1 eb 14             	shr    ebx,0x14
    174c:	89 de                	mov    esi,ebx
    174e:	66 81 e6 ff 0f       	and    si,0xfff
    1753:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    1757:	66 81 e3 00 f0       	and    bx,0xf000
    175c:	09 f3                	or     ebx,esi
    175e:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    1762:	0f b6 c2             	movzx  eax,dl
    1765:	c1 e0 0c             	shl    eax,0xc
    1768:	89 c2                	mov    edx,eax
    176a:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    176d:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    1772:	09 d0                	or     eax,edx
    1774:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
												pd[ofs].u = 1;
    1777:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    177a:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1781:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1784:	01 d0                	add    eax,edx
    1786:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1789:	83 ca 04             	or     edx,0x4
    178c:	88 10                	mov    BYTE PTR [eax],dl
												pd[ofs].w = 1;
    178e:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1791:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1798:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    179b:	01 d0                	add    eax,edx
    179d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    17a0:	83 ca 02             	or     edx,0x2
    17a3:	88 10                	mov    BYTE PTR [eax],dl
												pd[ofs].p = 1;
    17a5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    17a8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    17af:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    17b2:	01 d0                	add    eax,edx
    17b4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    17b7:	83 ca 01             	or     edx,0x1
    17ba:	88 10                	mov    BYTE PTR [eax],dl
    17bc:	eb 7c                	jmp    183a <mm_aoa_range+0x25c>
												struct pte32* pd = e;
    17be:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    17c1:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
												pd[ofs].addr = (uint32_t)(b / 4096);
    17c4:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    17c7:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    17ca:	0f ac d0 0c          	shrd   eax,edx,0xc
    17ce:	c1 ea 0c             	shr    edx,0xc
    17d1:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    17d4:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
    17db:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    17de:	01 d9                	add    ecx,ebx
    17e0:	25 ff ff 0f 00       	and    eax,0xfffff
    17e5:	c1 e0 0c             	shl    eax,0xc
    17e8:	89 c2                	mov    edx,eax
    17ea:	8b 01                	mov    eax,DWORD PTR [ecx]
    17ec:	25 ff 0f 00 00       	and    eax,0xfff
    17f1:	09 d0                	or     eax,edx
    17f3:	89 01                	mov    DWORD PTR [ecx],eax
												pd[ofs].u = 1;
    17f5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    17f8:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    17ff:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1802:	01 d0                	add    eax,edx
    1804:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1807:	83 ca 04             	or     edx,0x4
    180a:	88 10                	mov    BYTE PTR [eax],dl
												pd[ofs].w = 1;
    180c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    180f:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    1816:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1819:	01 d0                	add    eax,edx
    181b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    181e:	83 ca 02             	or     edx,0x2
    1821:	88 10                	mov    BYTE PTR [eax],dl
												pd[ofs].p = 1;
    1823:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1826:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    182d:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1830:	01 d0                	add    eax,edx
    1832:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1835:	83 ca 01             	or     edx,0x1
    1838:	88 10                	mov    BYTE PTR [eax],dl
										cntr[ofs] = ptr;
    183a:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    183d:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1840:	c1 e2 02             	shl    edx,0x2
    1843:	01 c2                	add    edx,eax
    1845:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1848:	89 02                	mov    DWORD PTR [edx],eax
    184a:	e9 ec fd ff ff       	jmp    163b <mm_aoa_range+0x5d>
										SPIN_CS(cntr[ofs]);
    184f:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    1852:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1855:	c1 e2 02             	shl    edx,0x2
    1858:	01 d0                	add    eax,edx
    185a:	8b 00                	mov    eax,DWORD PTR [eax]
    185c:	83 f8 ff             	cmp    eax,0xffffffff
    185f:	74 ee                	je     184f <mm_aoa_range+0x271>
    1861:	e9 d5 fd ff ff       	jmp    163b <mm_aoa_range+0x5d>
								if (!cpu.has_pae) {
    1866:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    186d:	83 e0 40             	and    eax,0x40
    1870:	84 c0                	test   al,al
    1872:	75 29                	jne    189d <mm_aoa_range+0x2bf>
										die("PD missing\n");
    1874:	c7 44 24 04 13 01 00 00 	mov    DWORD PTR [esp+0x4],0x113
    187c:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1883:	e8 fc ff ff ff       	call   1884 <mm_aoa_range+0x2a6>
    1888:	e8 fc ff ff ff       	call   1889 <mm_aoa_range+0x2ab>
    188d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1894:	e8 fc ff ff ff       	call   1895 <mm_aoa_range+0x2b7>
    1899:	fa                   	cli
    189a:	f4                   	hlt
    189b:	eb fd                	jmp    189a <mm_aoa_range+0x2bc>
								die("will not happen as 4PDs are pre-allocated.\n");
    189d:	c7 44 24 04 20 01 00 00 	mov    DWORD PTR [esp+0x4],0x120
    18a5:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    18ac:	e8 fc ff ff ff       	call   18ad <mm_aoa_range+0x2cf>
    18b1:	e8 fc ff ff ff       	call   18b2 <mm_aoa_range+0x2d4>
    18b6:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    18bd:	e8 fc ff ff ff       	call   18be <mm_aoa_range+0x2e0>
    18c2:	fa                   	cli
    18c3:	f4                   	hlt
    18c4:	eb fd                	jmp    18c3 <mm_aoa_range+0x2e5>
				if (!cpu.has_pae) {
    18c6:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    18cd:	83 e0 40             	and    eax,0x40
    18d0:	84 c0                	test   al,al
    18d2:	0f 85 34 01 00 00    	jne    1a0c <mm_aoa_range+0x42e>
						struct pte32* pte = e;
    18d8:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    18db:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						while (ofs < 1024) {
    18de:	e9 16 01 00 00       	jmp    19f9 <mm_aoa_range+0x41b>
								if (pte->p)
    18e3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    18e6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    18e9:	83 e0 01             	and    eax,0x1
    18ec:	84 c0                	test   al,al
    18ee:	0f 85 8a fd ff ff    	jne    167e <mm_aoa_range+0xa0>
								pte->addr = pm_zero / 4096; /* cautonary */
    18f4:	a1 00 00 00 00       	mov    eax,ds:0x0
    18f9:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    18ff:	0f ac d0 0c          	shrd   eax,edx,0xc
    1903:	c1 ea 0c             	shr    edx,0xc
    1906:	25 ff ff 0f 00       	and    eax,0xfffff
    190b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    190e:	c1 e0 0c             	shl    eax,0xc
    1911:	89 c1                	mov    ecx,eax
    1913:	8b 02                	mov    eax,DWORD PTR [edx]
    1915:	25 ff 0f 00 00       	and    eax,0xfff
    191a:	09 c8                	or     eax,ecx
    191c:	89 02                	mov    DWORD PTR [edx],eax
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
    191e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1921:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1924:	83 ca 04             	or     edx,0x4
    1927:	88 10                	mov    BYTE PTR [eax],dl
								pte->w = (w ? 1 : 0);
    1929:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    192d:	0f 95 c2             	setne  dl
    1930:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1933:	83 e2 01             	and    edx,0x1
    1936:	8d 0c 12             	lea    ecx,[edx+edx*1]
    1939:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    193c:	83 e2 fd             	and    edx,0xfffffffd
    193f:	09 ca                	or     edx,ecx
    1941:	88 10                	mov    BYTE PTR [eax],dl
								pte->p = 0; /* that's the point of allocate-on-access */
    1943:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1946:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1949:	83 e2 fe             	and    edx,0xfffffffe
    194c:	88 10                	mov    BYTE PTR [eax],dl
								pte->s = (wc ? 1 : 0); /* PAT bit */
    194e:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1952:	0f 95 c2             	setne  dl
    1955:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1958:	89 d1                	mov    ecx,edx
    195a:	c1 e1 07             	shl    ecx,0x7
    195d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1960:	83 e2 7f             	and    edx,0x7f
    1963:	09 ca                	or     edx,ecx
    1965:	88 10                	mov    BYTE PTR [eax],dl
								pte->wt = (wt ? 1 : 0);
    1967:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    196b:	0f 95 c2             	setne  dl
    196e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1971:	83 e2 01             	and    edx,0x1
    1974:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    197b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    197e:	83 e2 f7             	and    edx,0xfffffff7
    1981:	09 ca                	or     edx,ecx
    1983:	88 10                	mov    BYTE PTR [eax],dl
								pte->cd = (cd ? 1 : 0);
    1985:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    1989:	0f 95 c2             	setne  dl
    198c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    198f:	83 e2 01             	and    edx,0x1
    1992:	89 d1                	mov    ecx,edx
    1994:	c1 e1 04             	shl    ecx,0x4
    1997:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    199a:	83 e2 ef             	and    edx,0xffffffef
    199d:	09 ca                	or     edx,ecx
    199f:	88 10                	mov    BYTE PTR [eax],dl
								pte->g = (g ? 1 : 0);
    19a1:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    19a5:	0f 95 c2             	setne  dl
    19a8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    19ab:	89 d1                	mov    ecx,edx
    19ad:	83 e1 01             	and    ecx,0x1
    19b0:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    19b4:	83 e2 fe             	and    edx,0xfffffffe
    19b7:	09 ca                	or     edx,ecx
    19b9:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								pte->ign = avl & 7;
    19bc:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    19bf:	83 e0 07             	and    eax,0x7
    19c2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    19c5:	83 e0 07             	and    eax,0x7
    19c8:	8d 0c 00             	lea    ecx,[eax+eax*1]
    19cb:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
    19cf:	83 e0 f1             	and    eax,0xfffffff1
    19d2:	09 c8                	or     eax,ecx
    19d4:	88 42 01             	mov    BYTE PTR [edx+0x1],al
								pte++; ofs++; pg_ct--;
    19d7:	83 45 f4 04          	add    DWORD PTR [ebp-0xc],0x4
    19db:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    19de:	83 c0 01             	add    eax,0x1
    19e1:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    19e4:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
								virt_address += 4096;
    19e8:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
								if (!pg_ct) /* exit if done */
    19ef:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    19f3:	0f 84 bd 01 00 00    	je     1bb6 <mm_aoa_range+0x5d8>
						while (ofs < 1024) {
    19f9:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    19fc:	3d ff 03 00 00       	cmp    eax,0x3ff
    1a01:	0f 86 dc fe ff ff    	jbe    18e3 <mm_aoa_range+0x305>
    1a07:	e9 9e 01 00 00       	jmp    1baa <mm_aoa_range+0x5cc>
						struct pte64* pte = e;
    1a0c:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1a0f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						while (ofs < 512) {
    1a12:	e9 85 01 00 00       	jmp    1b9c <mm_aoa_range+0x5be>
								if (pte->p)
    1a17:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a1a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1a1d:	83 e0 01             	and    eax,0x1
    1a20:	84 c0                	test   al,al
    1a22:	0f 85 59 fc ff ff    	jne    1681 <mm_aoa_range+0xa3>

								/* set the flags */
								pte->addr = pm_zero / 4096; /* cautonary */
    1a28:	a1 00 00 00 00       	mov    eax,ds:0x0
    1a2d:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1a33:	0f ac d0 0c          	shrd   eax,edx,0xc
    1a37:	c1 ea 0c             	shr    edx,0xc
    1a3a:	81 e2 ff 00 00 00    	and    edx,0xff
    1a40:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1a43:	89 c3                	mov    ebx,eax
    1a45:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    1a4b:	89 de                	mov    esi,ebx
    1a4d:	c1 e6 0c             	shl    esi,0xc
    1a50:	8b 19                	mov    ebx,DWORD PTR [ecx]
    1a52:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    1a58:	09 f3                	or     ebx,esi
    1a5a:	89 19                	mov    DWORD PTR [ecx],ebx
    1a5c:	89 c3                	mov    ebx,eax
    1a5e:	c1 eb 14             	shr    ebx,0x14
    1a61:	89 de                	mov    esi,ebx
    1a63:	66 81 e6 ff 0f       	and    si,0xfff
    1a68:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    1a6c:	66 81 e3 00 f0       	and    bx,0xf000
    1a71:	09 f3                	or     ebx,esi
    1a73:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    1a77:	0f b6 c2             	movzx  eax,dl
    1a7a:	c1 e0 0c             	shl    eax,0xc
    1a7d:	89 c2                	mov    edx,eax
    1a7f:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    1a82:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    1a87:	09 d0                	or     eax,edx
    1a89:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
    1a8c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a8f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1a92:	83 ca 04             	or     edx,0x4
    1a95:	88 10                	mov    BYTE PTR [eax],dl
								pte->w = (w ? 1 : 0);
    1a97:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    1a9b:	0f 95 c2             	setne  dl
    1a9e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1aa1:	83 e2 01             	and    edx,0x1
    1aa4:	8d 0c 12             	lea    ecx,[edx+edx*1]
    1aa7:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1aaa:	83 e2 fd             	and    edx,0xfffffffd
    1aad:	09 ca                	or     edx,ecx
    1aaf:	88 10                	mov    BYTE PTR [eax],dl
								pte->p = 0; /* that's the point of allocate-on-access */
    1ab1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ab4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1ab7:	83 e2 fe             	and    edx,0xfffffffe
    1aba:	88 10                	mov    BYTE PTR [eax],dl
								pte->s = (wc ? 1 : 0); /* PAT bit */
    1abc:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1ac0:	0f 95 c2             	setne  dl
    1ac3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ac6:	89 d1                	mov    ecx,edx
    1ac8:	c1 e1 07             	shl    ecx,0x7
    1acb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1ace:	83 e2 7f             	and    edx,0x7f
    1ad1:	09 ca                	or     edx,ecx
    1ad3:	88 10                	mov    BYTE PTR [eax],dl
								pte->wt = (wt ? 1 : 0);
    1ad5:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1ad9:	0f 95 c2             	setne  dl
    1adc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1adf:	83 e2 01             	and    edx,0x1
    1ae2:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    1ae9:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1aec:	83 e2 f7             	and    edx,0xfffffff7
    1aef:	09 ca                	or     edx,ecx
    1af1:	88 10                	mov    BYTE PTR [eax],dl
								pte->cd = (cd ? 1 : 0);
    1af3:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    1af7:	0f 95 c2             	setne  dl
    1afa:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1afd:	83 e2 01             	and    edx,0x1
    1b00:	89 d1                	mov    ecx,edx
    1b02:	c1 e1 04             	shl    ecx,0x4
    1b05:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1b08:	83 e2 ef             	and    edx,0xffffffef
    1b0b:	09 ca                	or     edx,ecx
    1b0d:	88 10                	mov    BYTE PTR [eax],dl
								pte->g = (g ? 1 : 0);
    1b0f:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    1b13:	0f 95 c2             	setne  dl
    1b16:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b19:	89 d1                	mov    ecx,edx
    1b1b:	83 e1 01             	and    ecx,0x1
    1b1e:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    1b22:	83 e2 fe             	and    edx,0xfffffffe
    1b25:	09 ca                	or     edx,ecx
    1b27:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								if (cpu.e_has_nx)
    1b2a:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
    1b31:	83 e0 10             	and    eax,0x10
    1b34:	84 c0                	test   al,al
    1b36:	74 1b                	je     1b53 <mm_aoa_range+0x575>
										pte->xd = (x ? 0 : 1);
    1b38:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1b3c:	0f 94 c2             	sete   dl
    1b3f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b42:	89 d1                	mov    ecx,edx
    1b44:	c1 e1 07             	shl    ecx,0x7
    1b47:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    1b4b:	83 e2 7f             	and    edx,0x7f
    1b4e:	09 ca                	or     edx,ecx
    1b50:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
								pte->ign = avl & 7;
    1b53:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1b56:	83 e0 07             	and    eax,0x7
    1b59:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1b5c:	83 e0 07             	and    eax,0x7
    1b5f:	8d 0c 00             	lea    ecx,[eax+eax*1]
    1b62:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
    1b66:	83 e0 f1             	and    eax,0xfffffff1
    1b69:	09 c8                	or     eax,ecx
    1b6b:	88 42 01             	mov    BYTE PTR [edx+0x1],al
								pte->ign2 = 0;
    1b6e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b71:	0f b7 50 06          	movzx  edx,WORD PTR [eax+0x6]
    1b75:	66 81 e2 0f 80       	and    dx,0x800f
    1b7a:	66 89 50 06          	mov    WORD PTR [eax+0x6],dx
								/* advance */
								pte++; ofs++; pg_ct--;
    1b7e:	83 45 f0 08          	add    DWORD PTR [ebp-0x10],0x8
    1b82:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1b85:	83 c0 01             	add    eax,0x1
    1b88:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    1b8b:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
								virt_address += 4096;
    1b8f:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
								if (!pg_ct) /* exit if done */
    1b96:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1b9a:	74 1d                	je     1bb9 <mm_aoa_range+0x5db>
						while (ofs < 512) {
    1b9c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1b9f:	3d ff 01 00 00       	cmp    eax,0x1ff
    1ba4:	0f 86 6d fe ff ff    	jbe    1a17 <mm_aoa_range+0x439>
		while (pg_ct) {
    1baa:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1bae:	74 0a                	je     1bba <mm_aoa_range+0x5dc>
redo:
    1bb0:	90                   	nop
    1bb1:	e9 85 fa ff ff       	jmp    163b <mm_aoa_range+0x5d>
										return;
    1bb6:	90                   	nop
    1bb7:	eb 01                	jmp    1bba <mm_aoa_range+0x5dc>
										return;
    1bb9:	90                   	nop
						}
				}
		}
}
    1bba:	83 ec 80             	sub    esp,0xffffff80
    1bbd:	5b                   	pop    ebx
    1bbe:	5e                   	pop    esi
    1bbf:	5d                   	pop    ebp
    1bc0:	c3                   	ret

00001bc1 <mm_unmap>:

void mm_unmap(struct mm* mm, void* virt_address, size_t pg_ct)
{
    1bc1:	55                   	push   ebp
    1bc2:	89 e5                	mov    ebp,esp
    1bc4:	83 ec 58             	sub    esp,0x58
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (pg_ct--) {
    1bc7:	e9 69 01 00 00       	jmp    1d35 <mm_unmap+0x174>
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#else
				if (cpu.has_pae)
    1bcc:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1bd3:	83 e0 40             	and    eax,0x40
    1bd6:	84 c0                	test   al,al
    1bd8:	74 44                	je     1c1e <mm_unmap+0x5d>
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
    1bda:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bdd:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1be0:	8d 55 d4             	lea    edx,[ebp-0x2c]
    1be3:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
    1be7:	8d 55 d8             	lea    edx,[ebp-0x28]
    1bea:	89 54 24 18          	mov    DWORD PTR [esp+0x18],edx
    1bee:	8d 55 e4             	lea    edx,[ebp-0x1c]
    1bf1:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    1bf5:	8d 55 e8             	lea    edx,[ebp-0x18]
    1bf8:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    1bfc:	8d 55 dc             	lea    edx,[ebp-0x24]
    1bff:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1c03:	8d 55 e0             	lea    edx,[ebp-0x20]
    1c06:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1c0a:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1c0d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1c11:	89 04 24             	mov    DWORD PTR [esp],eax
    1c14:	e8 fc ff ff ff       	call   1c15 <mm_unmap+0x54>
    1c19:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1c1c:	eb 42                	jmp    1c60 <mm_unmap+0x9f>
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
    1c1e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c21:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1c24:	8d 55 d4             	lea    edx,[ebp-0x2c]
    1c27:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
    1c2b:	8d 55 d8             	lea    edx,[ebp-0x28]
    1c2e:	89 54 24 18          	mov    DWORD PTR [esp+0x18],edx
    1c32:	8d 55 e4             	lea    edx,[ebp-0x1c]
    1c35:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    1c39:	8d 55 e8             	lea    edx,[ebp-0x18]
    1c3c:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    1c40:	8d 55 dc             	lea    edx,[ebp-0x24]
    1c43:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1c47:	8d 55 e0             	lea    edx,[ebp-0x20]
    1c4a:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1c4e:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1c51:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1c55:	89 04 24             	mov    DWORD PTR [esp],eax
    1c58:	e8 fc ff ff ff       	call   1c59 <mm_unmap+0x98>
    1c5d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
    1c60:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1c64:	75 5d                	jne    1cc3 <mm_unmap+0x102>
						goto advance;

				e32 = NULL; e64 = NULL;
    1c66:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    1c6d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (!cpu.has_pae)
    1c74:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1c7b:	83 e0 40             	and    eax,0x40
    1c7e:	84 c0                	test   al,al
    1c80:	75 08                	jne    1c8a <mm_unmap+0xc9>
						e32 = e;
    1c82:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c85:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1c88:	eb 06                	jmp    1c90 <mm_unmap+0xcf>
				else
						e64 = e;
    1c8a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c8d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		
				/* make not present (TODO: clear as in free_vmem?) */
				if (!cpu.has_pae)
    1c90:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1c97:	83 e0 40             	and    eax,0x40
    1c9a:	84 c0                	test   al,al
    1c9c:	75 0d                	jne    1cab <mm_unmap+0xea>
						e32->p = 0;
    1c9e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ca1:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1ca4:	83 e2 fe             	and    edx,0xfffffffe
    1ca7:	88 10                	mov    BYTE PTR [eax],dl
    1ca9:	eb 0b                	jmp    1cb6 <mm_unmap+0xf5>
				else
						e64->p = 0;
    1cab:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1cae:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1cb1:	83 e2 fe             	and    edx,0xfffffffe
    1cb4:	88 10                	mov    BYTE PTR [eax],dl

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
    1cb6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1cb9:	89 04 24             	mov    DWORD PTR [esp],eax
    1cbc:	e8 53 e3 ff ff       	call   14 <flush_tlb_single>
    1cc1:	eb 01                	jmp    1cc4 <mm_unmap+0x103>
						goto advance;
    1cc3:	90                   	nop
		
				/* advance */
advance:
				if (!lv) /* regular page */
    1cc4:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1cc7:	85 c0                	test   eax,eax
    1cc9:	75 09                	jne    1cd4 <mm_unmap+0x113>
						virt_address += 4096;
    1ccb:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
    1cd2:	eb 61                	jmp    1d35 <mm_unmap+0x174>
				else if (lv == 1) /* large page 2M/4M */
    1cd4:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1cd7:	83 f8 01             	cmp    eax,0x1
    1cda:	75 1f                	jne    1cfb <mm_unmap+0x13a>
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
    1cdc:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1ce3:	83 e0 40             	and    eax,0x40
    1ce6:	84 c0                	test   al,al
    1ce8:	74 07                	je     1cf1 <mm_unmap+0x130>
    1cea:	b8 00 00 80 00       	mov    eax,0x800000
    1cef:	eb 05                	jmp    1cf6 <mm_unmap+0x135>
    1cf1:	b8 00 00 00 01       	mov    eax,0x1000000
    1cf6:	01 45 0c             	add    DWORD PTR [ebp+0xc],eax
    1cf9:	eb 3a                	jmp    1d35 <mm_unmap+0x174>
				else if (lv == 2) /* huge page 1G */
    1cfb:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1cfe:	83 f8 02             	cmp    eax,0x2
    1d01:	75 09                	jne    1d0c <mm_unmap+0x14b>
						virt_address += 1024 * 1024 * 1024;
    1d03:	81 45 0c 00 00 00 40 	add    DWORD PTR [ebp+0xc],0x40000000
    1d0a:	eb 29                	jmp    1d35 <mm_unmap+0x174>
				else
						die("ginormous page?\n");
    1d0c:	c7 44 24 04 90 00 00 00 	mov    DWORD PTR [esp+0x4],0x90
    1d14:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1d1b:	e8 fc ff ff ff       	call   1d1c <mm_unmap+0x15b>
    1d20:	e8 fc ff ff ff       	call   1d21 <mm_unmap+0x160>
    1d25:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1d2c:	e8 fc ff ff ff       	call   1d2d <mm_unmap+0x16c>
    1d31:	fa                   	cli
    1d32:	f4                   	hlt
    1d33:	eb fd                	jmp    1d32 <mm_unmap+0x171>
		while (pg_ct--) {
    1d35:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d38:	8d 50 ff             	lea    edx,[eax-0x1]
    1d3b:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1d3e:	85 c0                	test   eax,eax
    1d40:	0f 85 86 fe ff ff    	jne    1bcc <mm_unmap+0xb>
		}
}
    1d46:	90                   	nop
    1d47:	90                   	nop
    1d48:	c9                   	leave
    1d49:	c3                   	ret

00001d4a <mm_alloc_vmem>:

void* mm_alloc_vmem(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
    1d4a:	55                   	push   ebp
    1d4b:	89 e5                	mov    ebp,esp
    1d4d:	81 ec 28 01 00 00    	sub    esp,0x128
		if (!virt_address)
    1d53:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1d57:	75 1c                	jne    1d75 <mm_alloc_vmem+0x2b>
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);
    1d59:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1d5c:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1d60:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d63:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1d67:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d6a:	89 04 24             	mov    DWORD PTR [esp],eax
    1d6d:	e8 fc ff ff ff       	call   1d6e <mm_alloc_vmem+0x24>
    1d72:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax

		if ((flags & MMGR_ALLOC_CONTIGUOUS) == MMGR_ALLOC_CONTIGUOUS) {
    1d75:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1d78:	25 00 00 03 00       	and    eax,0x30000
    1d7d:	3d 00 00 03 00       	cmp    eax,0x30000
    1d82:	75 7b                	jne    1dff <mm_alloc_vmem+0xb5>
				struct page_range pr; size_t ct;
				/* FIXME: Implement cont. allocator for PMEM */
				ct = mm_alloc_pm(pg_ct, &pr, 1);
    1d84:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
    1d8c:	8d 45 d0             	lea    eax,[ebp-0x30]
    1d8f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1d93:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d96:	89 04 24             	mov    DWORD PTR [esp],eax
    1d99:	e8 fc ff ff ff       	call   1d9a <mm_alloc_vmem+0x50>
    1d9e:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				if (ct < pg_ct) {
    1da1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1da4:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
    1da7:	73 29                	jae    1dd2 <mm_alloc_vmem+0x88>
						die("Contiguous allocation failed\n");
    1da9:	c7 44 24 04 4c 01 00 00 	mov    DWORD PTR [esp+0x4],0x14c
    1db1:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1db8:	e8 fc ff ff ff       	call   1db9 <mm_alloc_vmem+0x6f>
    1dbd:	e8 fc ff ff ff       	call   1dbe <mm_alloc_vmem+0x74>
    1dc2:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1dc9:	e8 fc ff ff ff       	call   1dca <mm_alloc_vmem+0x80>
    1dce:	fa                   	cli
    1dcf:	f4                   	hlt
    1dd0:	eb fd                	jmp    1dcf <mm_alloc_vmem+0x85>
				}
				return mm_map(mm, virt_address, &pr, 1, flags);
    1dd2:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1dd5:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1dd9:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    1de1:	8d 45 d0             	lea    eax,[ebp-0x30]
    1de4:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1de8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1deb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1def:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1df2:	89 04 24             	mov    DWORD PTR [esp],eax
    1df5:	e8 fc ff ff ff       	call   1df6 <mm_alloc_vmem+0xac>
    1dfa:	e9 46 01 00 00       	jmp    1f45 <mm_alloc_vmem+0x1fb>
		} else if ((flags & MMGR_ALLOC_ZERO_COW) == MMGR_ALLOC_ZERO_COW) {
    1dff:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1e02:	25 00 00 01 00       	and    eax,0x10000
    1e07:	85 c0                	test   eax,eax
    1e09:	74 60                	je     1e6b <mm_alloc_vmem+0x121>
				void* rv = virt_address;
    1e0b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e0e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				struct page_range pr = { pm_zero, 1 };
    1e11:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e16:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1e1c:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    1e1f:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
    1e22:	c7 45 cc 01 00 00 00 	mov    DWORD PTR [ebp-0x34],0x1
				while (pg_ct) {
    1e29:	eb 32                	jmp    1e5d <mm_alloc_vmem+0x113>
						mm_map(mm, virt_address, &pr, 1, flags | MMGR_MAP_COW);
    1e2b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1e2e:	80 cc 02             	or     ah,0x2
    1e31:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1e35:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    1e3d:	8d 45 c4             	lea    eax,[ebp-0x3c]
    1e40:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1e44:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e47:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e4b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e4e:	89 04 24             	mov    DWORD PTR [esp],eax
    1e51:	e8 fc ff ff ff       	call   1e52 <mm_alloc_vmem+0x108>
						virt_address += 4096;
    1e56:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
				while (pg_ct) {
    1e5d:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1e61:	75 c8                	jne    1e2b <mm_alloc_vmem+0xe1>
				}
				return rv;
    1e63:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1e66:	e9 da 00 00 00       	jmp    1f45 <mm_alloc_vmem+0x1fb>
		} else if ((flags & MMGR_ALLOC_NP_AOA) == MMGR_ALLOC_NP_AOA) {
    1e6b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1e6e:	25 00 00 02 00       	and    eax,0x20000
    1e73:	85 c0                	test   eax,eax
    1e75:	74 2e                	je     1ea5 <mm_alloc_vmem+0x15b>
				void* rv = virt_address;
    1e77:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e7a:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				mm_aoa_range(mm, virt_address, pg_ct, flags);
    1e7d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1e80:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1e84:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1e87:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1e8b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e8e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e92:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e95:	89 04 24             	mov    DWORD PTR [esp],eax
    1e98:	e8 fc ff ff ff       	call   1e99 <mm_alloc_vmem+0x14f>
				return rv;
    1e9d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1ea0:	e9 a0 00 00 00       	jmp    1f45 <mm_alloc_vmem+0x1fb>
		} else {
				void* rv = virt_address;
    1ea5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ea8:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				do {
						struct page_range pr[16]; size_t ct, ct2, prc = 0;
    1eab:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
						ct = ct2 = mm_alloc_pm(pg_ct, pr, 16);
    1eb2:	c7 44 24 08 10 00 00 00 	mov    DWORD PTR [esp+0x8],0x10
    1eba:	8d 85 04 ff ff ff    	lea    eax,[ebp-0xfc]
    1ec0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1ec4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ec7:	89 04 24             	mov    DWORD PTR [esp],eax
    1eca:	e8 fc ff ff ff       	call   1ecb <mm_alloc_vmem+0x181>
    1ecf:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1ed2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1ed5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						pg_ct -= ct;
    1ed8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1edb:	29 45 10             	sub    DWORD PTR [ebp+0x10],eax
						while (ct) {
    1ede:	eb 1f                	jmp    1eff <mm_alloc_vmem+0x1b5>
								ct -= pr[prc].count;
    1ee0:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1ee3:	89 d0                	mov    eax,edx
    1ee5:	01 c0                	add    eax,eax
    1ee7:	01 d0                	add    eax,edx
    1ee9:	c1 e0 02             	shl    eax,0x2
    1eec:	8d 40 f8             	lea    eax,[eax-0x8]
    1eef:	01 e8                	add    eax,ebp
    1ef1:	2d ec 00 00 00       	sub    eax,0xec
    1ef6:	8b 00                	mov    eax,DWORD PTR [eax]
    1ef8:	29 45 f4             	sub    DWORD PTR [ebp-0xc],eax
								prc++;
    1efb:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
						while (ct) {
    1eff:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1f03:	75 db                	jne    1ee0 <mm_alloc_vmem+0x196>
						}
						 mm_map(mm, virt_address, &pr, prc, flags);
    1f05:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1f08:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1f0c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1f0f:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1f13:	8d 85 04 ff ff ff    	lea    eax,[ebp-0xfc]
    1f19:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1f1d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f20:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1f24:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f27:	89 04 24             	mov    DWORD PTR [esp],eax
    1f2a:	e8 fc ff ff ff       	call   1f2b <mm_alloc_vmem+0x1e1>
						 virt_address += 4096 * ct2;
    1f2f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1f32:	c1 e0 0c             	shl    eax,0xc
    1f35:	01 45 0c             	add    DWORD PTR [ebp+0xc],eax
				} while (pg_ct);
    1f38:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1f3c:	0f 85 69 ff ff ff    	jne    1eab <mm_alloc_vmem+0x161>
				return rv;
    1f42:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
		}
}
    1f45:	c9                   	leave
    1f46:	c3                   	ret

00001f47 <mm_extend_vmem>:

void* mm_extend_vmem(struct mm* mm, void* ptr, size_t pg_ct, size_t new_pg_ct, int flg)
{
    1f47:	55                   	push   ebp
    1f48:	89 e5                	mov    ebp,esp
    1f4a:	81 ec 58 06 00 00    	sub    esp,0x658
		size_t new_pmem = new_pg_ct - pg_ct, pm_res, p0c = 0, p1c = 0;
    1f50:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1f53:	2b 45 10             	sub    eax,DWORD PTR [ebp+0x10]
    1f56:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1f59:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1f60:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		void *rv, *p0 = ptr, *p1;
    1f67:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f6a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		struct page_range prs[128];
		if (!ptr || new_pg_ct <= pg_ct)
    1f6d:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1f71:	74 08                	je     1f7b <mm_extend_vmem+0x34>
    1f73:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1f76:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
    1f79:	72 0a                	jb     1f85 <mm_extend_vmem+0x3e>
				return NULL;
    1f7b:	b8 00 00 00 00       	mov    eax,0x0
    1f80:	e9 d3 01 00 00       	jmp    2158 <mm_extend_vmem+0x211>
		/* reserve virtual memory */
		rv = mm_reserve_vmem(mm, new_pg_ct, flg);
    1f85:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    1f88:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1f8c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1f8f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1f93:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f96:	89 04 24             	mov    DWORD PTR [esp],eax
    1f99:	e8 fc ff ff ff       	call   1f9a <mm_extend_vmem+0x53>
    1f9e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		if (!rv)
    1fa1:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1fa5:	75 0a                	jne    1fb1 <mm_extend_vmem+0x6a>
				return NULL;
    1fa7:	b8 00 00 00 00       	mov    eax,0x0
    1fac:	e9 a7 01 00 00       	jmp    2158 <mm_extend_vmem+0x211>

		/* remap the existing pages */
		p1 = rv;
    1fb1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1fb4:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		while (pg_ct) {
    1fb7:	e9 a9 00 00 00       	jmp    2065 <mm_extend_vmem+0x11e>
				struct page_range pr;
				pr.base = mm_page_get_pmem(mm, p0);
    1fbc:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1fbf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1fc3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1fc6:	89 04 24             	mov    DWORD PTR [esp],eax
    1fc9:	e8 fc ff ff ff       	call   1fca <mm_extend_vmem+0x83>
    1fce:	89 85 d0 f9 ff ff    	mov    DWORD PTR [ebp-0x630],eax
    1fd4:	89 95 d4 f9 ff ff    	mov    DWORD PTR [ebp-0x62c],edx
				pr.count = 1; flg = 0;
    1fda:	c7 85 d8 f9 ff ff 01 00 00 00 	mov    DWORD PTR [ebp-0x628],0x1
    1fe4:	c7 45 18 00 00 00 00 	mov    DWORD PTR [ebp+0x18],0x0
				if (!mm_map(mm, p1, &pr, 1, flg)) {
    1feb:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    1fee:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1ff2:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    1ffa:	8d 85 d0 f9 ff ff    	lea    eax,[ebp-0x630]
    2000:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2004:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2007:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    200b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    200e:	89 04 24             	mov    DWORD PTR [esp],eax
    2011:	e8 fc ff ff ff       	call   2012 <mm_extend_vmem+0xcb>
    2016:	85 c0                	test   eax,eax
    2018:	75 35                	jne    204f <mm_extend_vmem+0x108>
						if (p0c) /* undo the new mapping */
    201a:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    201e:	74 25                	je     2045 <mm_extend_vmem+0xfe>
								mm_unmap(mm, rv - p0c * 4096, p0c);
    2020:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2023:	c1 e0 0c             	shl    eax,0xc
    2026:	f7 d8                	neg    eax
    2028:	89 c2                	mov    edx,eax
    202a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    202d:	01 c2                	add    edx,eax
    202f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2032:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2036:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    203a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    203d:	89 04 24             	mov    DWORD PTR [esp],eax
    2040:	e8 fc ff ff ff       	call   2041 <mm_extend_vmem+0xfa>
						return NULL;
    2045:	b8 00 00 00 00       	mov    eax,0x0
    204a:	e9 09 01 00 00       	jmp    2158 <mm_extend_vmem+0x211>
				}
				p0c++; pg_ct--;
    204f:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    2053:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
				p0 += 4096;
    2057:	81 45 ec 00 10 00 00 	add    DWORD PTR [ebp-0x14],0x1000
				p1 += 4096;
    205e:	81 45 e8 00 10 00 00 	add    DWORD PTR [ebp-0x18],0x1000
		while (pg_ct) {
    2065:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    2069:	0f 85 4d ff ff ff    	jne    1fbc <mm_extend_vmem+0x75>
		}
		/* now get the physical memory and map it */
		while (new_pmem) {
    206f:	e9 be 00 00 00       	jmp    2132 <mm_extend_vmem+0x1eb>
				pm_res = mm_alloc_pm(new_pmem, prs, 128);
    2074:	c7 44 24 08 80 00 00 00 	mov    DWORD PTR [esp+0x8],0x80
    207c:	8d 85 dc f9 ff ff    	lea    eax,[ebp-0x624]
    2082:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2086:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2089:	89 04 24             	mov    DWORD PTR [esp],eax
    208c:	e8 fc ff ff ff       	call   208d <mm_extend_vmem+0x146>
    2091:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				if (!pm_res) {
    2094:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    2098:	75 43                	jne    20dd <mm_extend_vmem+0x196>
						/* out of pmem */
						mm_free_vmem(mm, rv + p0c * 4096, p1c);
    209a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    209d:	c1 e0 0c             	shl    eax,0xc
    20a0:	89 c2                	mov    edx,eax
    20a2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    20a5:	01 c2                	add    edx,eax
    20a7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    20aa:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    20ae:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    20b2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20b5:	89 04 24             	mov    DWORD PTR [esp],eax
    20b8:	e8 fc ff ff ff       	call   20b9 <mm_extend_vmem+0x172>
						mm_unmap(mm, rv, p0c);
    20bd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    20c0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    20c4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    20c7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    20cb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20ce:	89 04 24             	mov    DWORD PTR [esp],eax
    20d1:	e8 fc ff ff ff       	call   20d2 <mm_extend_vmem+0x18b>
						return NULL;
    20d6:	b8 00 00 00 00       	mov    eax,0x0
    20db:	eb 7b                	jmp    2158 <mm_extend_vmem+0x211>
				}
				if (!mm_map(mm, p1, prs, 128, flg)) {
    20dd:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    20e0:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    20e4:	c7 44 24 0c 80 00 00 00 	mov    DWORD PTR [esp+0xc],0x80
    20ec:	8d 85 dc f9 ff ff    	lea    eax,[ebp-0x624]
    20f2:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    20f6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    20f9:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    20fd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2100:	89 04 24             	mov    DWORD PTR [esp],eax
    2103:	e8 fc ff ff ff       	call   2104 <mm_extend_vmem+0x1bd>
    2108:	85 c0                	test   eax,eax
    210a:	75 17                	jne    2123 <mm_extend_vmem+0x1dc>
						/* cannot happen on reserved mem */
						cprintf(KFMT_ERROR, "Error while mapping virtual memory which was already reserved.");
    210c:	c7 44 24 04 6c 01 00 00 	mov    DWORD PTR [esp+0x4],0x16c
    2114:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    211b:	e8 fc ff ff ff       	call   211c <mm_extend_vmem+0x1d5>
						while (1);
    2120:	90                   	nop
    2121:	eb fd                	jmp    2120 <mm_extend_vmem+0x1d9>
				} else {
						p1 += pm_res * 4096;
    2123:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2126:	c1 e0 0c             	shl    eax,0xc
    2129:	01 45 e8             	add    DWORD PTR [ebp-0x18],eax
						p1c += pm_res;
    212c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    212f:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
		while (new_pmem) {
    2132:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    2136:	0f 85 38 ff ff ff    	jne    2074 <mm_extend_vmem+0x12d>
				}
		}
		/* and unmap the old memory */
		mm_unmap(mm, ptr, p0c);
    213c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    213f:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2143:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2146:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    214a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    214d:	89 04 24             	mov    DWORD PTR [esp],eax
    2150:	e8 fc ff ff ff       	call   2151 <mm_extend_vmem+0x20a>
		return rv;
    2155:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
}
    2158:	c9                   	leave
    2159:	c3                   	ret

0000215a <mm_free_vmem>:

void mm_free_vmem(struct mm* mm, void* virt_address, size_t pg_ct)
{
    215a:	55                   	push   ebp
    215b:	89 e5                	mov    ebp,esp
    215d:	56                   	push   esi
    215e:	53                   	push   ebx
    215f:	83 ec 50             	sub    esp,0x50
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};
    2162:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
    2169:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    2170:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0

		/* check every page */
		while (pg_ct--) {
    2177:	e9 6d 01 00 00       	jmp    22e9 <mm_free_vmem+0x18f>
				/* first get the references to the structures */
				rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);
    217c:	8d 45 d4             	lea    eax,[ebp-0x2c]
    217f:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    2183:	8d 45 d8             	lea    eax,[ebp-0x28]
    2186:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    218a:	8d 45 e4             	lea    eax,[ebp-0x1c]
    218d:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    2191:	8d 45 e8             	lea    eax,[ebp-0x18]
    2194:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    2198:	8d 45 dc             	lea    eax,[ebp-0x24]
    219b:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    219f:	8d 45 e0             	lea    eax,[ebp-0x20]
    21a2:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    21a6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21a9:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    21ad:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21b0:	89 04 24             	mov    DWORD PTR [esp],eax
    21b3:	e8 fc ff ff ff       	call   21b4 <mm_free_vmem+0x5a>
    21b8:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

				if (rv == 0) { /* present page */
    21bb:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    21bf:	0f 85 c2 00 00 00    	jne    2287 <mm_free_vmem+0x12d>
						uint64_t b;
						/* get the physical memory */
						if (!cpu.has_pae)
    21c5:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    21cc:	83 e0 40             	and    eax,0x40
    21cf:	84 c0                	test   al,al
    21d1:	75 14                	jne    21e7 <mm_free_vmem+0x8d>
								b = ((struct pte32*)e)->addr * 0x1000;
    21d3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    21d6:	8b 00                	mov    eax,DWORD PTR [eax]
    21d8:	c1 e8 0c             	shr    eax,0xc
    21db:	c1 e0 0c             	shl    eax,0xc
    21de:	99                   	cdq
    21df:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    21e2:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    21e5:	eb 37                	jmp    221e <mm_free_vmem+0xc4>
						else
								b = ((struct pte64*)e)->addr * 0x1000;
    21e7:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    21ea:	8b 19                	mov    ebx,DWORD PTR [ecx]
    21ec:	89 de                	mov    esi,ebx
    21ee:	c1 ee 0c             	shr    esi,0xc
    21f1:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    21f5:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    21fb:	c1 e3 14             	shl    ebx,0x14
    21fe:	09 f3                	or     ebx,esi
    2200:	89 d8                	mov    eax,ebx
    2202:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    2205:	c1 e9 0c             	shr    ecx,0xc
    2208:	0f b6 d1             	movzx  edx,cl
    220b:	0f a4 c2 0c          	shld   edx,eax,0xc
    220f:	c1 e0 0c             	shl    eax,0xc
    2212:	81 e2 ff 00 00 00    	and    edx,0xff
    2218:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    221b:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
						/* concat if possible */
						if (pr.count) {
    221e:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2221:	85 c0                	test   eax,eax
    2223:	74 4d                	je     2272 <mm_free_vmem+0x118>
								if (pr.base + 4096 * pr.count == b)
    2225:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2228:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    222b:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    222e:	c1 e1 0c             	shl    ecx,0xc
    2231:	bb 00 00 00 00       	mov    ebx,0x0
    2236:	01 c8                	add    eax,ecx
    2238:	11 da                	adc    edx,ebx
    223a:	89 c1                	mov    ecx,eax
    223c:	89 c8                	mov    eax,ecx
    223e:	33 45 f0             	xor    eax,DWORD PTR [ebp-0x10]
    2241:	33 55 f4             	xor    edx,DWORD PTR [ebp-0xc]
    2244:	09 d0                	or     eax,edx
    2246:	75 0e                	jne    2256 <mm_free_vmem+0xfc>
										pr.count++;
    2248:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    224b:	83 c0 01             	add    eax,0x1
    224e:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    2251:	e9 8c 00 00 00       	jmp    22e2 <mm_free_vmem+0x188>
								else {
										/* deallocate */
										mm_free_pm(&pr, 1);
    2256:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
    225e:	8d 45 c8             	lea    eax,[ebp-0x38]
    2261:	89 04 24             	mov    DWORD PTR [esp],eax
    2264:	e8 fc ff ff ff       	call   2265 <mm_free_vmem+0x10b>
										pr.count = 0;
    2269:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    2270:	eb 70                	jmp    22e2 <mm_free_vmem+0x188>
								}
						} else {
								pr.base = b;
    2272:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2275:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2278:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    227b:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
								pr.count = 1;
    227e:	c7 45 d0 01 00 00 00 	mov    DWORD PTR [ebp-0x30],0x1
    2285:	eb 5b                	jmp    22e2 <mm_free_vmem+0x188>
						}
				} else if (e) { /* AOW etc. */
    2287:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    228a:	85 c0                	test   eax,eax
    228c:	74 2b                	je     22b9 <mm_free_vmem+0x15f>
						bzero(e, cpu.has_pae ? 8 : 4);
    228e:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2295:	83 e0 40             	and    eax,0x40
    2298:	84 c0                	test   al,al
    229a:	74 07                	je     22a3 <mm_free_vmem+0x149>
    229c:	ba 08 00 00 00       	mov    edx,0x8
    22a1:	eb 05                	jmp    22a8 <mm_free_vmem+0x14e>
    22a3:	ba 04 00 00 00       	mov    edx,0x4
    22a8:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    22ab:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    22af:	89 04 24             	mov    DWORD PTR [esp],eax
    22b2:	e8 fc ff ff ff       	call   22b3 <mm_free_vmem+0x159>
    22b7:	eb 29                	jmp    22e2 <mm_free_vmem+0x188>
				} else {
						/* invalid address */
						die("Invalid virtual address specified in free_vmem.\n");
    22b9:	c7 44 24 04 ac 01 00 00 	mov    DWORD PTR [esp+0x4],0x1ac
    22c1:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    22c8:	e8 fc ff ff ff       	call   22c9 <mm_free_vmem+0x16f>
    22cd:	e8 fc ff ff ff       	call   22ce <mm_free_vmem+0x174>
    22d2:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    22d9:	e8 fc ff ff ff       	call   22da <mm_free_vmem+0x180>
    22de:	fa                   	cli
    22df:	f4                   	hlt
    22e0:	eb fd                	jmp    22df <mm_free_vmem+0x185>
				}

				/* advance */
				virt_address += 4096;
    22e2:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
		while (pg_ct--) {
    22e9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    22ec:	8d 50 ff             	lea    edx,[eax-0x1]
    22ef:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    22f2:	85 c0                	test   eax,eax
    22f4:	0f 85 82 fe ff ff    	jne    217c <mm_free_vmem+0x22>
		}

		/* remove remaining pmem */
		if (pr.count)
    22fa:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    22fd:	85 c0                	test   eax,eax
    22ff:	74 13                	je     2314 <mm_free_vmem+0x1ba>
				mm_free_pm(&pr, 1);
    2301:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
    2309:	8d 45 c8             	lea    eax,[ebp-0x38]
    230c:	89 04 24             	mov    DWORD PTR [esp],eax
    230f:	e8 fc ff ff ff       	call   2310 <mm_free_vmem+0x1b6>
}
    2314:	90                   	nop
    2315:	83 c4 50             	add    esp,0x50
    2318:	5b                   	pop    ebx
    2319:	5e                   	pop    esi
    231a:	5d                   	pop    ebp
    231b:	c3                   	ret

0000231c <mm_page_walk>:

int mm_page_walk(struct mm* mm, void* vmem, void** p, void** e, int* lv,
				uint32_t* of, void*** cntr, void*** cntrm)
{
    231c:	55                   	push   ebp
    231d:	89 e5                	mov    ebp,esp
    231f:	83 ec 20             	sub    esp,0x20
#ifdef __x86_64__
		return mm_page_walk64(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
#else
		if (cpu.has_pae)
    2322:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2329:	83 e0 40             	and    eax,0x40
    232c:	84 c0                	test   al,al
    232e:	74 41                	je     2371 <mm_page_walk+0x55>
				return mm_page_walk36(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
    2330:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2333:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2336:	8b 55 24             	mov    edx,DWORD PTR [ebp+0x24]
    2339:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
    233d:	8b 55 20             	mov    edx,DWORD PTR [ebp+0x20]
    2340:	89 54 24 18          	mov    DWORD PTR [esp+0x18],edx
    2344:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    2347:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    234b:	8b 55 18             	mov    edx,DWORD PTR [ebp+0x18]
    234e:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    2352:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
    2355:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2359:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    235c:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2360:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2363:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2367:	89 04 24             	mov    DWORD PTR [esp],eax
    236a:	e8 fc ff ff ff       	call   236b <mm_page_walk+0x4f>
    236f:	eb 3f                	jmp    23b0 <mm_page_walk+0x94>
		else
				return mm_page_walk32(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
    2371:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2374:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2377:	8b 55 24             	mov    edx,DWORD PTR [ebp+0x24]
    237a:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
    237e:	8b 55 20             	mov    edx,DWORD PTR [ebp+0x20]
    2381:	89 54 24 18          	mov    DWORD PTR [esp+0x18],edx
    2385:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    2388:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    238c:	8b 55 18             	mov    edx,DWORD PTR [ebp+0x18]
    238f:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    2393:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
    2396:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    239a:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    239d:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    23a1:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    23a4:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    23a8:	89 04 24             	mov    DWORD PTR [esp],eax
    23ab:	e8 fc ff ff ff       	call   23ac <mm_page_walk+0x90>
#endif
}
    23b0:	c9                   	leave
    23b1:	c3                   	ret

000023b2 <mm_page_get_pmem>:

uint64_t mm_page_get_pmem(struct mm* mm, void* virt_address)
{
    23b2:	55                   	push   ebp
    23b3:	89 e5                	mov    ebp,esp
    23b5:	56                   	push   esi
    23b6:	53                   	push   ebx
    23b7:	83 ec 50             	sub    esp,0x50
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};
    23ba:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    23c1:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    23c8:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0

		/* first get the references to the structures */
		rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);
    23cf:	8d 45 dc             	lea    eax,[ebp-0x24]
    23d2:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    23d6:	8d 45 e0             	lea    eax,[ebp-0x20]
    23d9:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    23dd:	8d 45 ec             	lea    eax,[ebp-0x14]
    23e0:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    23e4:	8d 45 f0             	lea    eax,[ebp-0x10]
    23e7:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    23eb:	8d 45 e4             	lea    eax,[ebp-0x1c]
    23ee:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    23f2:	8d 45 e8             	lea    eax,[ebp-0x18]
    23f5:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    23f9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    23fc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2400:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2403:	89 04 24             	mov    DWORD PTR [esp],eax
    2406:	e8 fc ff ff ff       	call   2407 <mm_page_get_pmem+0x55>
    240b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		if (!rv)
    240e:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2412:	75 0f                	jne    2423 <mm_page_get_pmem+0x71>
				return (uint64_t)-1;
    2414:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2419:	ba ff ff ff ff       	mov    edx,0xffffffff
    241e:	e9 a3 00 00 00       	jmp    24c6 <mm_page_get_pmem+0x114>
		else if (!lv) {
    2423:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2426:	85 c0                	test   eax,eax
    2428:	75 4f                	jne    2479 <mm_page_get_pmem+0xc7>
				if (cpu.has_pae)
    242a:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2431:	83 e0 40             	and    eax,0x40
    2434:	84 c0                	test   al,al
    2436:	74 33                	je     246b <mm_page_get_pmem+0xb9>
						return ((struct pte64*)e)->addr * 0x1000;
    2438:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    243b:	8b 19                	mov    ebx,DWORD PTR [ecx]
    243d:	89 de                	mov    esi,ebx
    243f:	c1 ee 0c             	shr    esi,0xc
    2442:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2446:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    244c:	c1 e3 14             	shl    ebx,0x14
    244f:	09 f3                	or     ebx,esi
    2451:	89 d8                	mov    eax,ebx
    2453:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    2456:	c1 e9 0c             	shr    ecx,0xc
    2459:	0f b6 d1             	movzx  edx,cl
    245c:	0f a4 c2 0c          	shld   edx,eax,0xc
    2460:	c1 e0 0c             	shl    eax,0xc
    2463:	81 e2 ff 00 00 00    	and    edx,0xff
    2469:	eb 5b                	jmp    24c6 <mm_page_get_pmem+0x114>
				else
						return ((struct pte32*)e)->addr * 0x1000;
    246b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    246e:	8b 00                	mov    eax,DWORD PTR [eax]
    2470:	c1 e8 0c             	shr    eax,0xc
    2473:	c1 e0 0c             	shl    eax,0xc
    2476:	99                   	cdq
    2477:	eb 4d                	jmp    24c6 <mm_page_get_pmem+0x114>
		} else { /* ignore PAT bit */
				if (cpu.has_pae)
    2479:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2480:	83 e0 40             	and    eax,0x40
    2483:	84 c0                	test   al,al
    2485:	74 30                	je     24b7 <mm_page_get_pmem+0x105>
						return (((struct pte64*)e)->addr & ~1ull) * 0x1000;
    2487:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    248a:	8b 19                	mov    ebx,DWORD PTR [ecx]
    248c:	89 de                	mov    esi,ebx
    248e:	c1 ee 0c             	shr    esi,0xc
    2491:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2495:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    249b:	c1 e3 14             	shl    ebx,0x14
    249e:	09 f3                	or     ebx,esi
    24a0:	89 d8                	mov    eax,ebx
    24a2:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    24a5:	c1 e9 0c             	shr    ecx,0xc
    24a8:	0f b6 d1             	movzx  edx,cl
    24ab:	83 e0 fe             	and    eax,0xfffffffe
    24ae:	0f a4 c2 0c          	shld   edx,eax,0xc
    24b2:	c1 e0 0c             	shl    eax,0xc
    24b5:	eb 0f                	jmp    24c6 <mm_page_get_pmem+0x114>
				else
						return (((struct pte32*)e)->addr & ~1) * 0x1000;
    24b7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    24ba:	8b 00                	mov    eax,DWORD PTR [eax]
    24bc:	c1 e8 0c             	shr    eax,0xc
    24bf:	83 e0 fe             	and    eax,0xfffffffe
    24c2:	c1 e0 0c             	shl    eax,0xc
    24c5:	99                   	cdq
		}
}
    24c6:	83 c4 50             	add    esp,0x50
    24c9:	5b                   	pop    ebx
    24ca:	5e                   	pop    esi
    24cb:	5d                   	pop    ebp
    24cc:	c3                   	ret

000024cd <mm_handle_pagefault>:

int mm_handle_pagefault(struct mm* mm, void* eip, uint32_t seg_error, void* cr2)
{
    24cd:	55                   	push   ebp
    24ce:	89 e5                	mov    ebp,esp
    24d0:	56                   	push   esi
    24d1:	53                   	push   ebx
    24d2:	81 ec a0 00 00 00    	sub    esp,0xa0
		extern struct kio_region kb_reg; /* for I/O diag */
		int lv, rv; uint32_t of; struct pte64 *p, *e; struct pte32 *ps, *es;
		void **cntr, **cntrm;

		/* first get the references to the structures */
		rv = mm_page_walk(mm, cr2, &p, &e, &lv, &of, &cntr, &cntrm);
    24d8:	8d 45 94             	lea    eax,[ebp-0x6c]
    24db:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    24df:	8d 45 98             	lea    eax,[ebp-0x68]
    24e2:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    24e6:	8d 45 a4             	lea    eax,[ebp-0x5c]
    24e9:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    24ed:	8d 45 a8             	lea    eax,[ebp-0x58]
    24f0:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    24f4:	8d 45 9c             	lea    eax,[ebp-0x64]
    24f7:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    24fb:	8d 45 a0             	lea    eax,[ebp-0x60]
    24fe:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2502:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    2505:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2509:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    250c:	89 04 24             	mov    DWORD PTR [esp],eax
    250f:	e8 fc ff ff ff       	call   2510 <mm_handle_pagefault+0x43>
    2514:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		ps = (void*)p; es = (void*)e;
    2517:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    251a:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    251d:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2520:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax

		/* then check the error code */
		/* bits: 0=present, 1=write, 2=user, 3=res, 4=nx */

		if (seg_error & 1) { /* some sort of access violation */
    2523:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2526:	83 e0 01             	and    eax,0x1
    2529:	85 c0                	test   eax,eax
    252b:	0f 84 ec 03 00 00    	je     291d <mm_handle_pagefault+0x450>
				if (seg_error & 8) { /* reserved bits */
    2531:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2534:	83 e0 08             	and    eax,0x8
    2537:	85 c0                	test   eax,eax
    2539:	0f 84 b7 00 00 00    	je     25f6 <mm_handle_pagefault+0x129>
						uint32_t hi, lo;
						cprintf(KFMT_ERROR, "Page lookup through %p contained entries"
    253f:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    2542:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2546:	c7 44 24 04 e0 01 00 00 	mov    DWORD PTR [esp+0x4],0x1e0
    254e:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2555:	e8 fc ff ff ff       	call   2556 <mm_handle_pagefault+0x89>
								" which have reserved bits set. This indicates"
								" either page table corruption or sloppy programming.\n", cr2);
						printf("seg_error: %08x\n", seg_error);
    255a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    255d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2561:	c7 04 24 6b 02 00 00 	mov    DWORD PTR [esp],0x26b
    2568:	e8 fc ff ff ff       	call   2569 <mm_handle_pagefault+0x9c>
						printf("level=%d, entry=%u\n", lv, of);
    256d:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    2570:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2573:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2577:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    257b:	c7 04 24 7c 02 00 00 	mov    DWORD PTR [esp],0x27c
    2582:	e8 fc ff ff ff       	call   2583 <mm_handle_pagefault+0xb6>
						if (cpu.has_pae)
    2587:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    258e:	83 e0 40             	and    eax,0x40
    2591:	84 c0                	test   al,al
    2593:	74 1e                	je     25b3 <mm_handle_pagefault+0xe6>
								printf("entry: %016llx\n", *(uint64_t*)e);
    2595:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2598:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    259b:	8b 00                	mov    eax,DWORD PTR [eax]
    259d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    25a1:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    25a5:	c7 04 24 90 02 00 00 	mov    DWORD PTR [esp],0x290
    25ac:	e8 fc ff ff ff       	call   25ad <mm_handle_pagefault+0xe0>
    25b1:	eb 15                	jmp    25c8 <mm_handle_pagefault+0xfb>
						else
								printf("entry: %08x\n", *(uint32_t*)es);
    25b3:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    25b6:	8b 00                	mov    eax,DWORD PTR [eax]
    25b8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    25bc:	c7 04 24 a0 02 00 00 	mov    DWORD PTR [esp],0x2a0
    25c3:	e8 fc ff ff ff       	call   25c4 <mm_handle_pagefault+0xf7>
						/* Show MSR */
						asm ("rdmsr" : "=a" (lo), "=d" (hi) : "c" (0xc0000080));
    25c8:	b8 80 00 00 c0       	mov    eax,0xc0000080
    25cd:	89 c1                	mov    ecx,eax
    25cf:	0f 32                	rdmsr
    25d1:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    25d4:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
						printf("MSR: %08x%08x\n", hi, lo);
    25d7:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    25da:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    25de:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    25e1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    25e5:	c7 04 24 ad 02 00 00 	mov    DWORD PTR [esp],0x2ad
    25ec:	e8 fc ff ff ff       	call   25ed <mm_handle_pagefault+0x120>
    25f1:	e9 ae 05 00 00       	jmp    2ba4 <mm_handle_pagefault+0x6d7>
				} else { /* regular access error */
						uint64_t pm; int w, u, x, tlb = 0;
    25f6:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
						const char* errstr; uint32_t avl;

						/* get the info */
						if (!cpu.has_pae) {
    25fd:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2604:	83 e0 40             	and    eax,0x40
    2607:	84 c0                	test   al,al
    2609:	75 53                	jne    265e <mm_handle_pagefault+0x191>
								pm = es->addr * 0x1000;
    260b:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    260e:	8b 00                	mov    eax,DWORD PTR [eax]
    2610:	c1 e8 0c             	shr    eax,0xc
    2613:	c1 e0 0c             	shl    eax,0xc
    2616:	99                   	cdq
    2617:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    261a:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
								x = 1;
    261d:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
								w = es->w;
    2624:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2627:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    262a:	d0 e8                	shr    al,1
    262c:	83 e0 01             	and    eax,0x1
    262f:	0f b6 c0             	movzx  eax,al
    2632:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								u = es->u;
    2635:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2638:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    263b:	c0 e8 02             	shr    al,0x2
    263e:	83 e0 01             	and    eax,0x1
    2641:	0f b6 c0             	movzx  eax,al
    2644:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								avl = es->ign;
    2647:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    264a:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    264e:	d0 e8                	shr    al,1
    2650:	83 e0 07             	and    eax,0x7
    2653:	0f b6 c0             	movzx  eax,al
    2656:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    2659:	e9 98 00 00 00       	jmp    26f6 <mm_handle_pagefault+0x229>
						} else {
								pm = e->addr * 0x1000;
    265e:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    2661:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2663:	89 de                	mov    esi,ebx
    2665:	c1 ee 0c             	shr    esi,0xc
    2668:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    266c:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2672:	c1 e3 14             	shl    ebx,0x14
    2675:	09 f3                	or     ebx,esi
    2677:	89 d8                	mov    eax,ebx
    2679:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    267c:	c1 e9 0c             	shr    ecx,0xc
    267f:	0f b6 d1             	movzx  edx,cl
    2682:	0f a4 c2 0c          	shld   edx,eax,0xc
    2686:	c1 e0 0c             	shl    eax,0xc
    2689:	81 e2 ff 00 00 00    	and    edx,0xff
    268f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    2692:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
								x = !e->xd;
    2695:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2698:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    269c:	83 e0 80             	and    eax,0xffffff80
    269f:	84 c0                	test   al,al
    26a1:	0f 94 c0             	sete   al
    26a4:	0f b6 c0             	movzx  eax,al
    26a7:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								w = e->w;
    26aa:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    26ad:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    26b0:	d0 e8                	shr    al,1
    26b2:	83 e0 01             	and    eax,0x1
    26b5:	0f b6 c0             	movzx  eax,al
    26b8:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								u = e->u;
    26bb:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    26be:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    26c1:	c0 e8 02             	shr    al,0x2
    26c4:	83 e0 01             	and    eax,0x1
    26c7:	0f b6 c0             	movzx  eax,al
    26ca:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								avl = e->ign | (e->ign2 << 3);
    26cd:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    26d0:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    26d4:	d0 e8                	shr    al,1
    26d6:	83 e0 07             	and    eax,0x7
    26d9:	0f b6 d0             	movzx  edx,al
    26dc:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    26df:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    26e3:	66 c1 e8 04          	shr    ax,0x4
    26e7:	66 25 ff 07          	and    ax,0x7ff
    26eb:	0f b7 c0             	movzx  eax,ax
    26ee:	c1 e0 03             	shl    eax,0x3
    26f1:	09 d0                	or     eax,edx
    26f3:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
						}
						/* create the errstr */
						if (seg_error & 16) {
    26f6:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    26f9:	83 e0 10             	and    eax,0x10
    26fc:	85 c0                	test   eax,eax
    26fe:	74 1e                	je     271e <mm_handle_pagefault+0x251>
								if (x) { /* check for NX in directoy */
    2700:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    2704:	74 0c                	je     2712 <mm_handle_pagefault+0x245>
										tlb = 1;
    2706:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
    270d:	e9 10 01 00 00       	jmp    2822 <mm_handle_pagefault+0x355>
								} else
										errstr = "no execute";
    2712:	c7 45 dc bc 02 00 00 	mov    DWORD PTR [ebp-0x24],0x2bc
    2719:	e9 04 01 00 00       	jmp    2822 <mm_handle_pagefault+0x355>
						} else if (seg_error & 4) {
    271e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2721:	83 e0 04             	and    eax,0x4
    2724:	85 c0                	test   eax,eax
    2726:	74 1e                	je     2746 <mm_handle_pagefault+0x279>
								if (u)
    2728:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    272c:	74 0c                	je     273a <mm_handle_pagefault+0x26d>
										tlb = 1;
    272e:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
    2735:	e9 e8 00 00 00       	jmp    2822 <mm_handle_pagefault+0x355>
								else
										errstr = "kernel";
    273a:	c7 45 dc c7 02 00 00 	mov    DWORD PTR [ebp-0x24],0x2c7
    2741:	e9 dc 00 00 00       	jmp    2822 <mm_handle_pagefault+0x355>
						} else if (seg_error & 2) {
    2746:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2749:	83 e0 02             	and    eax,0x2
    274c:	85 c0                	test   eax,eax
    274e:	0f 84 ce 00 00 00    	je     2822 <mm_handle_pagefault+0x355>
								if (w) /* we assume consistent directories */
    2754:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2758:	74 0c                	je     2766 <mm_handle_pagefault+0x299>
										tlb = 1;
    275a:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
    2761:	e9 bc 00 00 00       	jmp    2822 <mm_handle_pagefault+0x355>
								else if (avl & 1) { /* COW */
    2766:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2769:	83 e0 01             	and    eax,0x1
    276c:	85 c0                	test   eax,eax
    276e:	0f 84 a7 00 00 00    	je     281b <mm_handle_pagefault+0x34e>
										size_t pg_ct = 1; struct page_range pr;
    2774:	c7 45 b4 01 00 00 00 	mov    DWORD PTR [ebp-0x4c],0x1
										if (lv > 0) {
    277b:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    277e:	85 c0                	test   eax,eax
    2780:	7e 29                	jle    27ab <mm_handle_pagefault+0x2de>
												die("COW on large pages not implemented yet\n");
    2782:	c7 44 24 04 d0 02 00 00 	mov    DWORD PTR [esp+0x4],0x2d0
    278a:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2791:	e8 fc ff ff ff       	call   2792 <mm_handle_pagefault+0x2c5>
    2796:	e8 fc ff ff ff       	call   2797 <mm_handle_pagefault+0x2ca>
    279b:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    27a2:	e8 fc ff ff ff       	call   27a3 <mm_handle_pagefault+0x2d6>
    27a7:	fa                   	cli
    27a8:	f4                   	hlt
    27a9:	eb fd                	jmp    27a8 <mm_handle_pagefault+0x2db>
										}
										if (mm_alloc_pm(pg_ct, &pr, 1)) {
    27ab:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
    27b3:	8d 45 88             	lea    eax,[ebp-0x78]
    27b6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    27ba:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    27bd:	89 04 24             	mov    DWORD PTR [esp],eax
    27c0:	e8 fc ff ff ff       	call   27c1 <mm_handle_pagefault+0x2f4>
    27c5:	85 c0                	test   eax,eax
    27c7:	74 29                	je     27f2 <mm_handle_pagefault+0x325>
												/* FIXME: Shootdown needed? No stale data would cause
												 * another COW and this can be detected in the PF handler. */
												die("COW not implemented\n");
    27c9:	c7 44 24 04 f8 02 00 00 	mov    DWORD PTR [esp+0x4],0x2f8
    27d1:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    27d8:	e8 fc ff ff ff       	call   27d9 <mm_handle_pagefault+0x30c>
    27dd:	e8 fc ff ff ff       	call   27de <mm_handle_pagefault+0x311>
    27e2:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    27e9:	e8 fc ff ff ff       	call   27ea <mm_handle_pagefault+0x31d>
    27ee:	fa                   	cli
    27ef:	f4                   	hlt
    27f0:	eb fd                	jmp    27ef <mm_handle_pagefault+0x322>
										} else {
												die("unable to allocate memory for COW\n");
    27f2:	c7 44 24 04 10 03 00 00 	mov    DWORD PTR [esp+0x4],0x310
    27fa:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2801:	e8 fc ff ff ff       	call   2802 <mm_handle_pagefault+0x335>
    2806:	e8 fc ff ff ff       	call   2807 <mm_handle_pagefault+0x33a>
    280b:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2812:	e8 fc ff ff ff       	call   2813 <mm_handle_pagefault+0x346>
    2817:	fa                   	cli
    2818:	f4                   	hlt
    2819:	eb fd                	jmp    2818 <mm_handle_pagefault+0x34b>
										}
								} else
										errstr = "read only";
    281b:	c7 45 dc 33 03 00 00 	mov    DWORD PTR [ebp-0x24],0x333
						}

						if (tlb) {
    2822:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    2826:	74 50                	je     2878 <mm_handle_pagefault+0x3ab>
								uint8_t id = 0;
    2828:	c6 45 d7 00          	mov    BYTE PTR [ebp-0x29],0x0
								if (nproc > 1)
    282c:	a1 00 00 00 00       	mov    eax,ds:0x0
    2831:	83 f8 01             	cmp    eax,0x1
    2834:	76 0a                	jbe    2840 <mm_handle_pagefault+0x373>
										id = smp_processor_id();
    2836:	e8 c5 d7 ff ff       	call   0 <per_cpu_ptr>
    283b:	8b 00                	mov    eax,DWORD PTR [eax]
    283d:	88 45 d7             	mov    BYTE PTR [ebp-0x29],al
								rprintf(&kb_reg, "[%u] TLB fl: %p\n", id, cr2);
    2840:	0f b6 45 d7          	movzx  eax,BYTE PTR [ebp-0x29]
    2844:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
    2847:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    284b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    284f:	c7 44 24 04 3d 03 00 00 	mov    DWORD PTR [esp+0x4],0x33d
    2857:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    285e:	e8 fc ff ff ff       	call   285f <mm_handle_pagefault+0x392>
								flush_tlb_single(cr2);
    2863:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    2866:	89 04 24             	mov    DWORD PTR [esp],eax
    2869:	e8 a6 d7 ff ff       	call   14 <flush_tlb_single>
								return 0;
    286e:	b8 00 00 00 00       	mov    eax,0x0
    2873:	e9 31 03 00 00       	jmp    2ba9 <mm_handle_pagefault+0x6dc>
						}

						/* print the error */
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
								" but is not allowed to do so as page is marked as %s\n",
								eip, (seg_error & 2) ? "write to" : ((seg_error & 16) ?
    2878:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    287b:	83 e0 02             	and    eax,0x2
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
    287e:	85 c0                	test   eax,eax
    2880:	75 18                	jne    289a <mm_handle_pagefault+0x3cd>
								eip, (seg_error & 2) ? "write to" : ((seg_error & 16) ?
    2882:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2885:	83 e0 10             	and    eax,0x10
								"fetch instructions from": "read from"),
    2888:	85 c0                	test   eax,eax
    288a:	74 07                	je     2893 <mm_handle_pagefault+0x3c6>
    288c:	b8 4e 03 00 00       	mov    eax,0x34e
    2891:	eb 0c                	jmp    289f <mm_handle_pagefault+0x3d2>
    2893:	b8 66 03 00 00       	mov    eax,0x366
    2898:	eb 05                	jmp    289f <mm_handle_pagefault+0x3d2>
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
    289a:	b8 70 03 00 00       	mov    eax,0x370
    289f:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    28a2:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    28a6:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
    28a9:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    28ad:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    28b1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    28b4:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    28b8:	c7 44 24 04 7c 03 00 00 	mov    DWORD PTR [esp+0x4],0x37c
    28c0:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    28c7:	e8 fc ff ff ff       	call   28c8 <mm_handle_pagefault+0x3fb>
								cr2, errstr);
						printf("The page is %s and present\n", lv ? (lv > 1 ? "huge" : "large") : "regular");
    28cc:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    28cf:	85 c0                	test   eax,eax
    28d1:	74 16                	je     28e9 <mm_handle_pagefault+0x41c>
    28d3:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    28d6:	83 f8 01             	cmp    eax,0x1
    28d9:	7e 07                	jle    28e2 <mm_handle_pagefault+0x415>
    28db:	b8 db 03 00 00       	mov    eax,0x3db
    28e0:	eb 0c                	jmp    28ee <mm_handle_pagefault+0x421>
    28e2:	b8 e0 03 00 00       	mov    eax,0x3e0
    28e7:	eb 05                	jmp    28ee <mm_handle_pagefault+0x421>
    28e9:	b8 e6 03 00 00       	mov    eax,0x3e6
    28ee:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    28f2:	c7 04 24 ee 03 00 00 	mov    DWORD PTR [esp],0x3ee
    28f9:	e8 fc ff ff ff       	call   28fa <mm_handle_pagefault+0x42d>
						printf("it points to physical memory at %#.16llx\n", pm);
    28fe:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2901:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2904:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2908:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    290c:	c7 04 24 0c 04 00 00 	mov    DWORD PTR [esp],0x40c
    2913:	e8 fc ff ff ff       	call   2914 <mm_handle_pagefault+0x447>
    2918:	e9 87 02 00 00       	jmp    2ba4 <mm_handle_pagefault+0x6d7>
				}
		} else { /* encountered nonpresent page */
				uint64_t flags = 0;
    291d:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
    2924:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
				/* get flag bits */
				if (!cpu.has_pae) { /* pte32 */
    292b:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2932:	83 e0 40             	and    eax,0x40
    2935:	84 c0                	test   al,al
    2937:	75 41                	jne    297a <mm_handle_pagefault+0x4ad>
						if (es) /* there's sth. */
    2939:	83 7d bc 00          	cmp    DWORD PTR [ebp-0x44],0x0
    293d:	74 12                	je     2951 <mm_handle_pagefault+0x484>
								flags |= *(uint32_t*)es;
    293f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2942:	8b 00                	mov    eax,DWORD PTR [eax]
    2944:	ba 00 00 00 00       	mov    edx,0x0
    2949:	09 45 c8             	or     DWORD PTR [ebp-0x38],eax
    294c:	09 55 cc             	or     DWORD PTR [ebp-0x34],edx
    294f:	eb 69                	jmp    29ba <mm_handle_pagefault+0x4ed>
						else
								die("level 2 missing\n");
    2951:	c7 44 24 04 36 04 00 00 	mov    DWORD PTR [esp+0x4],0x436
    2959:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2960:	e8 fc ff ff ff       	call   2961 <mm_handle_pagefault+0x494>
    2965:	e8 fc ff ff ff       	call   2966 <mm_handle_pagefault+0x499>
    296a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2971:	e8 fc ff ff ff       	call   2972 <mm_handle_pagefault+0x4a5>
    2976:	fa                   	cli
    2977:	f4                   	hlt
    2978:	eb fd                	jmp    2977 <mm_handle_pagefault+0x4aa>
				} else {
						if (e)
    297a:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    297d:	85 c0                	test   eax,eax
    297f:	74 10                	je     2991 <mm_handle_pagefault+0x4c4>
								flags |= *(uint64_t*)e;
    2981:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2984:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2987:	8b 00                	mov    eax,DWORD PTR [eax]
    2989:	09 45 c8             	or     DWORD PTR [ebp-0x38],eax
    298c:	09 55 cc             	or     DWORD PTR [ebp-0x34],edx
    298f:	eb 29                	jmp    29ba <mm_handle_pagefault+0x4ed>
						else
								die("level 2 or 4 missing\n");
    2991:	c7 44 24 04 47 04 00 00 	mov    DWORD PTR [esp+0x4],0x447
    2999:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    29a0:	e8 fc ff ff ff       	call   29a1 <mm_handle_pagefault+0x4d4>
    29a5:	e8 fc ff ff ff       	call   29a6 <mm_handle_pagefault+0x4d9>
    29aa:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    29b1:	e8 fc ff ff ff       	call   29b2 <mm_handle_pagefault+0x4e5>
    29b6:	fa                   	cli
    29b7:	f4                   	hlt
    29b8:	eb fd                	jmp    29b7 <mm_handle_pagefault+0x4ea>
				}

				/* check for known codes */
				flags >>= 1;
    29ba:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    29bd:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    29c0:	0f ac d0 01          	shrd   eax,edx,0x1
    29c4:	d1 ea                	shr    edx,1
    29c6:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    29c9:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
				/* CAUTION: Swap IDs have to keep AVL field free */
				if (flags & (1 << 11)) { /* allocate on access */
    29cc:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    29cf:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    29d2:	25 00 08 00 00       	and    eax,0x800
    29d7:	ba 00 00 00 00       	mov    edx,0x0
    29dc:	89 c1                	mov    ecx,eax
    29de:	89 c8                	mov    eax,ecx
    29e0:	09 d0                	or     eax,edx
    29e2:	0f 84 65 01 00 00    	je     2b4d <mm_handle_pagefault+0x680>
						size_t pg_ct = 1; struct page_range pr;
    29e8:	c7 45 b8 01 00 00 00 	mov    DWORD PTR [ebp-0x48],0x1
						if (lv > 0) {
    29ef:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    29f2:	85 c0                	test   eax,eax
    29f4:	7e 29                	jle    2a1f <mm_handle_pagefault+0x552>
								/* TODO: cont alloc & large pages */
								die("no AOA large pages implemented yet!\n");
    29f6:	c7 44 24 04 60 04 00 00 	mov    DWORD PTR [esp+0x4],0x460
    29fe:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2a05:	e8 fc ff ff ff       	call   2a06 <mm_handle_pagefault+0x539>
    2a0a:	e8 fc ff ff ff       	call   2a0b <mm_handle_pagefault+0x53e>
    2a0f:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2a16:	e8 fc ff ff ff       	call   2a17 <mm_handle_pagefault+0x54a>
    2a1b:	fa                   	cli
    2a1c:	f4                   	hlt
    2a1d:	eb fd                	jmp    2a1c <mm_handle_pagefault+0x54f>
						}
						/* alloc & print info */
						if (mm_alloc_pm(pg_ct, &pr, 1)) {
    2a1f:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
    2a27:	8d 85 7c ff ff ff    	lea    eax,[ebp-0x84]
    2a2d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2a31:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    2a34:	89 04 24             	mov    DWORD PTR [esp],eax
    2a37:	e8 fc ff ff ff       	call   2a38 <mm_handle_pagefault+0x56b>
    2a3c:	85 c0                	test   eax,eax
    2a3e:	0f 84 e0 00 00 00    	je     2b24 <mm_handle_pagefault+0x657>
								/* level0 -> no new pointers */
								if (!cpu.has_pae) {
    2a44:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2a4b:	83 e0 40             	and    eax,0x40
    2a4e:	84 c0                	test   al,al
    2a50:	75 35                	jne    2a87 <mm_handle_pagefault+0x5ba>
										es->addr = (uint32_t)(pr.base / 4096);
    2a52:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [ebp-0x84]
    2a58:	8b 55 80             	mov    edx,DWORD PTR [ebp-0x80]
    2a5b:	0f ac d0 0c          	shrd   eax,edx,0xc
    2a5f:	c1 ea 0c             	shr    edx,0xc
    2a62:	25 ff ff 0f 00       	and    eax,0xfffff
    2a67:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    2a6a:	c1 e0 0c             	shl    eax,0xc
    2a6d:	89 c1                	mov    ecx,eax
    2a6f:	8b 02                	mov    eax,DWORD PTR [edx]
    2a71:	25 ff 0f 00 00       	and    eax,0xfff
    2a76:	09 c8                	or     eax,ecx
    2a78:	89 02                	mov    DWORD PTR [edx],eax
										es->p = 1;
    2a7a:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2a7d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2a80:	83 ca 01             	or     edx,0x1
    2a83:	88 10                	mov    BYTE PTR [eax],dl
    2a85:	eb 6d                	jmp    2af4 <mm_handle_pagefault+0x627>
								} else {
										e->addr = pr.base / 4096;
    2a87:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [ebp-0x84]
    2a8d:	8b 55 80             	mov    edx,DWORD PTR [ebp-0x80]
    2a90:	0f ac d0 0c          	shrd   eax,edx,0xc
    2a94:	c1 ea 0c             	shr    edx,0xc
    2a97:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    2a9a:	81 e2 ff 00 00 00    	and    edx,0xff
    2aa0:	89 c3                	mov    ebx,eax
    2aa2:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    2aa8:	89 de                	mov    esi,ebx
    2aaa:	c1 e6 0c             	shl    esi,0xc
    2aad:	8b 19                	mov    ebx,DWORD PTR [ecx]
    2aaf:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    2ab5:	09 f3                	or     ebx,esi
    2ab7:	89 19                	mov    DWORD PTR [ecx],ebx
    2ab9:	89 c3                	mov    ebx,eax
    2abb:	c1 eb 14             	shr    ebx,0x14
    2abe:	89 de                	mov    esi,ebx
    2ac0:	66 81 e6 ff 0f       	and    si,0xfff
    2ac5:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    2ac9:	66 81 e3 00 f0       	and    bx,0xf000
    2ace:	09 f3                	or     ebx,esi
    2ad0:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    2ad4:	0f b6 c2             	movzx  eax,dl
    2ad7:	c1 e0 0c             	shl    eax,0xc
    2ada:	89 c2                	mov    edx,eax
    2adc:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    2adf:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2ae4:	09 d0                	or     eax,edx
    2ae6:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
										e->p = 1;
    2ae9:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2aec:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    2aef:	83 ca 01             	or     edx,0x1
    2af2:	88 10                	mov    BYTE PTR [eax],dl
								}
								flush_tlb_single(cr2);
    2af4:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    2af7:	89 04 24             	mov    DWORD PTR [esp],eax
    2afa:	e8 15 d5 ff ff       	call   14 <flush_tlb_single>
								rprintf(&kb_reg, "MM AOW: %p\n", cr2);
    2aff:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    2b02:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2b06:	c7 44 24 04 85 04 00 00 	mov    DWORD PTR [esp+0x4],0x485
    2b0e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2b15:	e8 fc ff ff ff       	call   2b16 <mm_handle_pagefault+0x649>
								return 0;
    2b1a:	b8 00 00 00 00       	mov    eax,0x0
    2b1f:	e9 85 00 00 00       	jmp    2ba9 <mm_handle_pagefault+0x6dc>
						} else {
								die("Out of memory for AOA\n");
    2b24:	c7 44 24 04 91 04 00 00 	mov    DWORD PTR [esp+0x4],0x491
    2b2c:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2b33:	e8 fc ff ff ff       	call   2b34 <mm_handle_pagefault+0x667>
    2b38:	e8 fc ff ff ff       	call   2b39 <mm_handle_pagefault+0x66c>
    2b3d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2b44:	e8 fc ff ff ff       	call   2b45 <mm_handle_pagefault+0x678>
    2b49:	fa                   	cli
    2b4a:	f4                   	hlt
    2b4b:	eb fd                	jmp    2b4a <mm_handle_pagefault+0x67d>
						}
				} else {
						/* swapped with ID */
						cprintf(KFMT_INFO, "Swapping in single page with id %llu\n", flags);
    2b4d:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2b50:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    2b53:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2b57:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2b5b:	c7 44 24 04 a8 04 00 00 	mov    DWORD PTR [esp+0x4],0x4a8
    2b63:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2b6a:	e8 fc ff ff ff       	call   2b6b <mm_handle_pagefault+0x69e>
						cprintf(KFMT_ERROR, "which is not implemented\n");
    2b6f:	c7 44 24 04 ce 04 00 00 	mov    DWORD PTR [esp+0x4],0x4ce
    2b77:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2b7e:	e8 fc ff ff ff       	call   2b7f <mm_handle_pagefault+0x6b2>
						printf("level=%d, entry=%u, ptr=%p\n", lv, of, cr2);
    2b83:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    2b86:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2b89:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
    2b8c:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    2b90:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2b94:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b98:	c7 04 24 e8 04 00 00 	mov    DWORD PTR [esp],0x4e8
    2b9f:	e8 fc ff ff ff       	call   2ba0 <mm_handle_pagefault+0x6d3>
		// --------------
		// Codes with access violation on present pages: 3 avl bits
		// 0 = regular, i.e. invalid
		// 1 = copy on write
		*/
		return 1;
    2ba4:	b8 01 00 00 00       	mov    eax,0x1
}
    2ba9:	81 c4 a0 00 00 00    	add    esp,0xa0
    2baf:	5b                   	pop    ebx
    2bb0:	5e                   	pop    esi
    2bb1:	5d                   	pop    ebp
    2bb2:	c3                   	ret

00002bb3 <print_stacktrace>:

const char* elf_get_closest_symbol(void* ptr, size_t* offset);
void print_stacktrace()
{
    2bb3:	55                   	push   ebp
    2bb4:	89 e5                	mov    ebp,esp
    2bb6:	56                   	push   esi
    2bb7:	53                   	push   ebx
    2bb8:	83 ec 50             	sub    esp,0x50
				struct sf* prev;
				void* ret_addr;
				void* args[4];
		} __attribute__((packed)) *fp;
		static int stc = 0;
		stc++;
    2bbb:	a1 0c 00 00 00       	mov    eax,ds:0xc
    2bc0:	83 c0 01             	add    eax,0x1
    2bc3:	a3 0c 00 00 00       	mov    ds:0xc,eax
		if (stc == 1) {
    2bc8:	a1 0c 00 00 00       	mov    eax,ds:0xc
    2bcd:	83 f8 01             	cmp    eax,0x1
    2bd0:	0f 85 e7 00 00 00    	jne    2cbd <print_stacktrace+0x10a>
print_st:
    2bd6:	90                   	nop
				/* get ebp into C code */
#ifdef __x86_64__
				__asm__("mov %%rbp, %[fp]" : /* output */ [fp] "=r" (fp));
#else
				__asm__("movl %%ebp, %[fp]" : /* output */ [fp] "=r" (fp));
    2bd7:	89 e8                	mov    eax,ebp
    2bd9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
#endif
				/* do the backtrace from ebp to ebp */
				printf("performing stacktrace:\n");
    2bdc:	c7 04 24 04 05 00 00 	mov    DWORD PTR [esp],0x504
    2be3:	e8 fc ff ff ff       	call   2be4 <print_stacktrace+0x31>
#ifdef __x86_64__
				printf("RBP              ARG-1             ARG-2             ARG-3             ARG-4            FROM\n");
#else
				printf("EBP      ARG-1     ARG-2     ARG-3     ARG-4    FROM\n");
    2be8:	c7 04 24 1c 05 00 00 	mov    DWORD PTR [esp],0x51c
    2bef:	e8 fc ff ff ff       	call   2bf0 <print_stacktrace+0x3d>
#endif
				do {
						size_t of; const char* sym;
						printf("%p %p %p %p %p %p\n", fp, fp->args[0], fp->args[1],
    2bf4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2bf7:	8b 70 04             	mov    esi,DWORD PTR [eax+0x4]
    2bfa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2bfd:	8b 58 14             	mov    ebx,DWORD PTR [eax+0x14]
    2c00:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2c03:	8b 48 10             	mov    ecx,DWORD PTR [eax+0x10]
    2c06:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2c09:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2c0c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2c0f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2c12:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
    2c16:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    2c1a:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    2c1e:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2c22:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2c26:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2c29:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2c2d:	c7 04 24 52 05 00 00 	mov    DWORD PTR [esp],0x552
    2c34:	e8 fc ff ff ff       	call   2c35 <print_stacktrace+0x82>
										fp->args[2], fp->args[3], fp->ret_addr);
						sym = (const char*)elf_get_closest_symbol(fp->ret_addr, &of);
    2c39:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2c3c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2c3f:	8d 55 dc             	lea    edx,[ebp-0x24]
    2c42:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2c46:	89 04 24             	mov    DWORD PTR [esp],eax
    2c49:	e8 fc ff ff ff       	call   2c4a <print_stacktrace+0x97>
    2c4e:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						cprintf(KFMT_INFO, "called from %p (%s%+#lx)\n", fp->ret_addr, sym, of);
    2c51:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2c54:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2c57:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2c5a:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    2c5e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    2c61:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2c65:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2c69:	c7 44 24 04 65 05 00 00 	mov    DWORD PTR [esp+0x4],0x565
    2c71:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2c78:	e8 fc ff ff ff       	call   2c79 <print_stacktrace+0xc6>
						extern void _start();
						if (fp->ret_addr - 5 == (void*)&_start)
    2c7d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2c80:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2c83:	83 e8 05             	sub    eax,0x5
    2c86:	3d 00 00 00 00       	cmp    eax,0x0
    2c8b:	74 1e                	je     2cab <print_stacktrace+0xf8>
								break; /* only until call to kmain */
						else if (!fp->ret_addr)
    2c8d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2c90:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2c93:	85 c0                	test   eax,eax
    2c95:	74 17                	je     2cae <print_stacktrace+0xfb>
								break;
						fp = fp->prev;
    2c97:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2c9a:	8b 00                	mov    eax,DWORD PTR [eax]
    2c9c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				} while (fp);
    2c9f:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2ca3:	0f 85 4b ff ff ff    	jne    2bf4 <print_stacktrace+0x41>
    2ca9:	eb 04                	jmp    2caf <print_stacktrace+0xfc>
								break; /* only until call to kmain */
    2cab:	90                   	nop
    2cac:	eb 01                	jmp    2caf <print_stacktrace+0xfc>
								break;
    2cae:	90                   	nop
				framebuffer_redraw(&fb_initial);
    2caf:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2cb6:	e8 fc ff ff ff       	call   2cb7 <print_stacktrace+0x104>
    2cbb:	eb 29                	jmp    2ce6 <print_stacktrace+0x133>
		} else
				die("stacktrace loop!\n");
    2cbd:	c7 44 24 04 7f 05 00 00 	mov    DWORD PTR [esp+0x4],0x57f
    2cc5:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2ccc:	e8 fc ff ff ff       	call   2ccd <print_stacktrace+0x11a>
    2cd1:	e8 fc ff ff ff       	call   2cd2 <print_stacktrace+0x11f>
    2cd6:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2cdd:	e8 fc ff ff ff       	call   2cde <print_stacktrace+0x12b>
    2ce2:	fa                   	cli
    2ce3:	f4                   	hlt
    2ce4:	eb fd                	jmp    2ce3 <print_stacktrace+0x130>
		/* now offer basic diag */
print_help:
		printf("Debug diagnostics mode with following commands:\n"
    2ce6:	c7 04 24 94 05 00 00 	mov    DWORD PTR [esp],0x594
    2ced:	e8 fc ff ff ff       	call   2cee <print_stacktrace+0x13b>
				"\tm                   Display symbol map\n"
				"\tk                   Reprint the stack trace\n"
				"\th(elp)              Display this help message\n"
				"\th(a)lt              Turns off the computer\n"
				"\tl Address           Find symbol below/at Address\n");
		framebuffer_redraw(&fb_initial);
    2cf2:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2cf9:	e8 fc ff ff ff       	call   2cfa <print_stacktrace+0x147>
		while (1) {
				char* str = 0; size_t n = 0;
    2cfe:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    2d05:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
				printf("enter command:\n");
    2d0c:	c7 04 24 ff 06 00 00 	mov    DWORD PTR [esp],0x6ff
    2d13:	e8 fc ff ff ff       	call   2d14 <print_stacktrace+0x161>
				framebuffer_redraw(&fb_initial);
    2d18:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2d1f:	e8 fc ff ff ff       	call   2d20 <print_stacktrace+0x16d>
				getline(&str, &n);
    2d24:	8d 45 d4             	lea    eax,[ebp-0x2c]
    2d27:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2d2b:	8d 45 d8             	lea    eax,[ebp-0x28]
    2d2e:	89 04 24             	mov    DWORD PTR [esp],eax
    2d31:	e8 fc ff ff ff       	call   2d32 <print_stacktrace+0x17f>
				if (str) {
    2d36:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d39:	85 c0                	test   eax,eax
    2d3b:	74 c1                	je     2cfe <print_stacktrace+0x14b>
						if (strlen(str))
    2d3d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d40:	89 04 24             	mov    DWORD PTR [esp],eax
    2d43:	e8 fc ff ff ff       	call   2d44 <print_stacktrace+0x191>
    2d48:	85 c0                	test   eax,eax
    2d4a:	74 16                	je     2d62 <print_stacktrace+0x1af>
								str[strlen(str) - 1] = '\0';
    2d4c:	8b 5d d8             	mov    ebx,DWORD PTR [ebp-0x28]
    2d4f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d52:	89 04 24             	mov    DWORD PTR [esp],eax
    2d55:	e8 fc ff ff ff       	call   2d56 <print_stacktrace+0x1a3>
    2d5a:	83 e8 01             	sub    eax,0x1
    2d5d:	01 d8                	add    eax,ebx
    2d5f:	c6 00 00             	mov    BYTE PTR [eax],0x0
						if (strcmp(str, "r") == 0)
    2d62:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d65:	c7 44 24 04 0f 07 00 00 	mov    DWORD PTR [esp+0x4],0x70f
    2d6d:	89 04 24             	mov    DWORD PTR [esp],eax
    2d70:	e8 fc ff ff ff       	call   2d71 <print_stacktrace+0x1be>
    2d75:	85 c0                	test   eax,eax
    2d77:	75 11                	jne    2d8a <print_stacktrace+0x1d7>
								printf("registers: \n");
    2d79:	c7 04 24 11 07 00 00 	mov    DWORD PTR [esp],0x711
    2d80:	e8 fc ff ff ff       	call   2d81 <print_stacktrace+0x1ce>
    2d85:	e9 e2 01 00 00       	jmp    2f6c <print_stacktrace+0x3b9>
						else if (strcmp(str, "k") == 0)
    2d8a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d8d:	c7 44 24 04 1e 07 00 00 	mov    DWORD PTR [esp+0x4],0x71e
    2d95:	89 04 24             	mov    DWORD PTR [esp],eax
    2d98:	e8 fc ff ff ff       	call   2d99 <print_stacktrace+0x1e6>
    2d9d:	85 c0                	test   eax,eax
    2d9f:	75 05                	jne    2da6 <print_stacktrace+0x1f3>
    2da1:	e9 31 fe ff ff       	jmp    2bd7 <print_stacktrace+0x24>
								goto print_st;
						else if (strcmp(str, "m") == 0)
    2da6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2da9:	c7 44 24 04 20 07 00 00 	mov    DWORD PTR [esp+0x4],0x720
    2db1:	89 04 24             	mov    DWORD PTR [esp],eax
    2db4:	e8 fc ff ff ff       	call   2db5 <print_stacktrace+0x202>
    2db9:	85 c0                	test   eax,eax
    2dbb:	75 11                	jne    2dce <print_stacktrace+0x21b>
								printf("Symbol map: \n");
    2dbd:	c7 04 24 22 07 00 00 	mov    DWORD PTR [esp],0x722
    2dc4:	e8 fc ff ff ff       	call   2dc5 <print_stacktrace+0x212>
    2dc9:	e9 9e 01 00 00       	jmp    2f6c <print_stacktrace+0x3b9>
						else if (strncmp(str, "l ", 2) == 0) {
    2dce:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2dd1:	c7 44 24 08 02 00 00 00 	mov    DWORD PTR [esp+0x8],0x2
    2dd9:	c7 44 24 04 30 07 00 00 	mov    DWORD PTR [esp+0x4],0x730
    2de1:	89 04 24             	mov    DWORD PTR [esp],eax
    2de4:	e8 fc ff ff ff       	call   2de5 <print_stacktrace+0x232>
    2de9:	85 c0                	test   eax,eax
    2deb:	75 55                	jne    2e42 <print_stacktrace+0x28f>
								long int addr = strtol(str + 2, NULL, 0);
    2ded:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2df0:	83 c0 02             	add    eax,0x2
    2df3:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    2dfb:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2e03:	89 04 24             	mov    DWORD PTR [esp],eax
    2e06:	e8 fc ff ff ff       	call   2e07 <print_stacktrace+0x254>
    2e0b:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								const char* sym; size_t of;
								sym = (const char*)elf_get_closest_symbol((void*)addr, &of);
    2e0e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2e11:	8d 55 d0             	lea    edx,[ebp-0x30]
    2e14:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2e18:	89 04 24             	mov    DWORD PTR [esp],eax
    2e1b:	e8 fc ff ff ff       	call   2e1c <print_stacktrace+0x269>
    2e20:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								printf("Address is located at %s%+#lx\n", sym, of);
    2e23:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2e26:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2e2a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2e2d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e31:	c7 04 24 34 07 00 00 	mov    DWORD PTR [esp],0x734
    2e38:	e8 fc ff ff ff       	call   2e39 <print_stacktrace+0x286>
    2e3d:	e9 2a 01 00 00       	jmp    2f6c <print_stacktrace+0x3b9>
						} else if (strncmp(str, "db ", 3) == 0) {
    2e42:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2e45:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    2e4d:	c7 44 24 04 53 07 00 00 	mov    DWORD PTR [esp+0x4],0x753
    2e55:	89 04 24             	mov    DWORD PTR [esp],eax
    2e58:	e8 fc ff ff ff       	call   2e59 <print_stacktrace+0x2a6>
    2e5d:	85 c0                	test   eax,eax
    2e5f:	75 69                	jne    2eca <print_stacktrace+0x317>
								char* end;
								long int addr = strtol(str + 3, &end, 0), cap = 512;
    2e61:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2e64:	8d 50 03             	lea    edx,[eax+0x3]
    2e67:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    2e6f:	8d 45 cc             	lea    eax,[ebp-0x34]
    2e72:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e76:	89 14 24             	mov    DWORD PTR [esp],edx
    2e79:	e8 fc ff ff ff       	call   2e7a <print_stacktrace+0x2c7>
    2e7e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    2e81:	c7 45 f0 00 02 00 00 	mov    DWORD PTR [ebp-0x10],0x200
								if (*end == ' ')
    2e88:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2e8b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2e8e:	3c 20                	cmp    al,0x20
    2e90:	75 21                	jne    2eb3 <print_stacktrace+0x300>
										cap = strtol(end + 1, NULL, 0);
    2e92:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2e95:	83 c0 01             	add    eax,0x1
    2e98:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    2ea0:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2ea8:	89 04 24             	mov    DWORD PTR [esp],eax
    2eab:	e8 fc ff ff ff       	call   2eac <print_stacktrace+0x2f9>
    2eb0:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								memdump((void*)addr, cap);
    2eb3:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2eb6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2eb9:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2ebd:	89 04 24             	mov    DWORD PTR [esp],eax
    2ec0:	e8 fc ff ff ff       	call   2ec1 <print_stacktrace+0x30e>
    2ec5:	e9 a2 00 00 00       	jmp    2f6c <print_stacktrace+0x3b9>
						} else if (strcmp(str, "dpt") == 0) {
    2eca:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2ecd:	c7 44 24 04 57 07 00 00 	mov    DWORD PTR [esp+0x4],0x757
    2ed5:	89 04 24             	mov    DWORD PTR [esp],eax
    2ed8:	e8 fc ff ff ff       	call   2ed9 <print_stacktrace+0x326>
    2edd:	85 c0                	test   eax,eax
    2edf:	75 0e                	jne    2eef <print_stacktrace+0x33c>
								printf("dumping page table\n");
    2ee1:	c7 04 24 5b 07 00 00 	mov    DWORD PTR [esp],0x75b
    2ee8:	e8 fc ff ff ff       	call   2ee9 <print_stacktrace+0x336>
    2eed:	eb 7d                	jmp    2f6c <print_stacktrace+0x3b9>
						} else if (strcmp(str, "help") == 0 || strcmp(str, "h") == 0)
    2eef:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2ef2:	c7 44 24 04 6f 07 00 00 	mov    DWORD PTR [esp+0x4],0x76f
    2efa:	89 04 24             	mov    DWORD PTR [esp],eax
    2efd:	e8 fc ff ff ff       	call   2efe <print_stacktrace+0x34b>
    2f02:	85 c0                	test   eax,eax
    2f04:	0f 84 dc fd ff ff    	je     2ce6 <print_stacktrace+0x133>
    2f0a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2f0d:	c7 44 24 04 74 07 00 00 	mov    DWORD PTR [esp+0x4],0x774
    2f15:	89 04 24             	mov    DWORD PTR [esp],eax
    2f18:	e8 fc ff ff ff       	call   2f19 <print_stacktrace+0x366>
    2f1d:	85 c0                	test   eax,eax
    2f1f:	75 05                	jne    2f26 <print_stacktrace+0x373>
    2f21:	e9 c0 fd ff ff       	jmp    2ce6 <print_stacktrace+0x133>
								goto print_help;
						else if (strcmp(str, "halt") == 0 || strcmp(str, "hlt") == 0)
    2f26:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2f29:	c7 44 24 04 76 07 00 00 	mov    DWORD PTR [esp+0x4],0x776
    2f31:	89 04 24             	mov    DWORD PTR [esp],eax
    2f34:	e8 fc ff ff ff       	call   2f35 <print_stacktrace+0x382>
    2f39:	85 c0                	test   eax,eax
    2f3b:	74 17                	je     2f54 <print_stacktrace+0x3a1>
    2f3d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2f40:	c7 44 24 04 7b 07 00 00 	mov    DWORD PTR [esp+0x4],0x77b
    2f48:	89 04 24             	mov    DWORD PTR [esp],eax
    2f4b:	e8 fc ff ff ff       	call   2f4c <print_stacktrace+0x399>
    2f50:	85 c0                	test   eax,eax
    2f52:	75 05                	jne    2f59 <print_stacktrace+0x3a6>
								pc_shutdown();
    2f54:	e8 fc ff ff ff       	call   2f55 <print_stacktrace+0x3a2>
						else
								printf("unknown command \"%s\"\n", str);
    2f59:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2f5c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f60:	c7 04 24 7f 07 00 00 	mov    DWORD PTR [esp],0x77f
    2f67:	e8 fc ff ff ff       	call   2f68 <print_stacktrace+0x3b5>
						kfree(str);
    2f6c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2f6f:	89 04 24             	mov    DWORD PTR [esp],eax
    2f72:	e8 fc ff ff ff       	call   2f73 <print_stacktrace+0x3c0>
		while (1) {
    2f77:	e9 82 fd ff ff       	jmp    2cfe <print_stacktrace+0x14b>
