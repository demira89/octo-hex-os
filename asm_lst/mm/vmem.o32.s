
mm/vmem.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
				return NULL;
		}
		*b = pr.base;

		/* reserve and map the virtual memory */
		rv = __sync_fetch_and_sub(pp, 4096);
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
		if (rv < VM_TABLE_LIMIT) {
				die("Out of virtual memory for paging structures.\n");
				return NULL;
		}
		mm_map(&mm_kernel, rv, &pr, 1, MMGR_MAP_WRITE
       6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
       c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						| MMGR_MAP_KERNEL /*| MMGR_MAP_GLOBAL*/);

       f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
		return rv;
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
      61:	83 ec 28             	sub    esp,0x28
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
      87:	83 ec 04             	sub    esp,0x4
      8a:	6a 01                	push   0x1
      8c:	8d 45 e4             	lea    eax,[ebp-0x1c]
      8f:	50                   	push   eax
      90:	6a 01                	push   0x1
      92:	e8 fc ff ff ff       	call   93 <mm_alloc_page+0x35>
      97:	83 c4 10             	add    esp,0x10
      9a:	85 c0                	test   eax,eax
      9c:	75 2b                	jne    c9 <mm_alloc_page+0x6b>
				die("Unable to allocate PM for paging strucures.\n");
      9e:	83 ec 08             	sub    esp,0x8
      a1:	68 00 00 00 00       	push   0x0
      a6:	6a 0c                	push   0xc
      a8:	e8 fc ff ff ff       	call   a9 <mm_alloc_page+0x4b>
      ad:	83 c4 10             	add    esp,0x10
      b0:	e8 fc ff ff ff       	call   b1 <mm_alloc_page+0x53>
      b5:	83 ec 0c             	sub    esp,0xc
      b8:	68 00 00 00 00       	push   0x0
      bd:	e8 fc ff ff ff       	call   be <mm_alloc_page+0x60>
      c2:	83 c4 10             	add    esp,0x10
      c5:	fa                   	cli
      c6:	f4                   	hlt
      c7:	eb fd                	jmp    c6 <mm_alloc_page+0x68>
		*b = pr.base;
      c9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      cc:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
      cf:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
      d2:	89 01                	mov    DWORD PTR [ecx],eax
      d4:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		rv = __sync_fetch_and_sub(pp, 4096);
      d7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
      da:	ba 00 10 00 00       	mov    edx,0x1000
      df:	f7 da                	neg    edx
      e1:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
      e5:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
		if (rv < VM_TABLE_LIMIT) {
      e8:	81 7d f0 ff ff ff fd 	cmp    DWORD PTR [ebp-0x10],0xfdffffff
      ef:	77 2b                	ja     11c <mm_alloc_page+0xbe>
				die("Out of virtual memory for paging structures.\n");
      f1:	83 ec 08             	sub    esp,0x8
      f4:	68 30 00 00 00       	push   0x30
      f9:	6a 0c                	push   0xc
      fb:	e8 fc ff ff ff       	call   fc <mm_alloc_page+0x9e>
     100:	83 c4 10             	add    esp,0x10
     103:	e8 fc ff ff ff       	call   104 <mm_alloc_page+0xa6>
     108:	83 ec 0c             	sub    esp,0xc
     10b:	68 00 00 00 00       	push   0x0
     110:	e8 fc ff ff ff       	call   111 <mm_alloc_page+0xb3>
     115:	83 c4 10             	add    esp,0x10
     118:	fa                   	cli
     119:	f4                   	hlt
     11a:	eb fd                	jmp    119 <mm_alloc_page+0xbb>
		mm_map(&mm_kernel, rv, &pr, 1, MMGR_MAP_WRITE
     11c:	83 ec 0c             	sub    esp,0xc
     11f:	6a 0c                	push   0xc
     121:	6a 01                	push   0x1
     123:	8d 45 e4             	lea    eax,[ebp-0x1c]
     126:	50                   	push   eax
     127:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     12a:	68 00 00 00 00       	push   0x0
     12f:	e8 fc ff ff ff       	call   130 <mm_alloc_page+0xd2>
     134:	83 c4 20             	add    esp,0x20
		return rv;
     137:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     13a:	c9                   	leave
     13b:	c3                   	ret

0000013c <mm_map36>:
		return vaddr;
}
#else
void* mm_map36(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
{
     13c:	55                   	push   ebp
     13d:	89 e5                	mov    ebp,esp
     13f:	56                   	push   esi
     140:	53                   	push   ebx
     141:	83 ec 30             	sub    esp,0x30
		struct vm_pg_ptrs36* vp = vm_mapping;
     144:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     147:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		uint32_t pdpte, pde, pte;
		struct page_range pr_copy;

		/* physical pointers */
		struct pte64* pd = 0;
     14a:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
		struct pte64* pt = 0;
     151:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0

		/* and the PDPTE */
		pdpte = ((uint32_t)vaddr & 0xc0000000) >> 30; /* 1G per PDPTE */
     158:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     15b:	c1 e8 1e             	shr    eax,0x1e
     15e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		pd = vp->pdp[pdpte];
     161:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     164:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     167:	83 c2 08             	add    edx,0x8
     16a:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     16e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

		/* and the PDE */
		pde = ((uint32_t)vaddr & 0x3fe00000) >> 21; /* 2M per PDE */
     171:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     174:	c1 e8 15             	shr    eax,0x15
     177:	25 ff 01 00 00       	and    eax,0x1ff
     17c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

		/* and finally the PTE */
		pte = ((uint32_t)vaddr & 0x1ff000) >> 12; /* 4K per PTE */
     17f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     182:	c1 e8 0c             	shr    eax,0xc
     185:	25 ff 01 00 00       	and    eax,0x1ff
     18a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* create a PT if not there */
new_pt:
		if (ENTER_CS_PTE(vp->pts[pdpte * 512 + pde])) {
     18d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     190:	c1 e0 09             	shl    eax,0x9
     193:	89 c2                	mov    edx,eax
     195:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     198:	01 d0                	add    eax,edx
     19a:	83 c0 0c             	add    eax,0xc
     19d:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     1a4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     1a7:	01 d0                	add    eax,edx
     1a9:	8d 50 04             	lea    edx,[eax+0x4]
     1ac:	b8 00 00 00 00       	mov    eax,0x0
     1b1:	b9 ff ff ff ff       	mov    ecx,0xffffffff
     1b6:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     1ba:	0f 94 c0             	sete   al
     1bd:	84 c0                	test   al,al
     1bf:	0f 84 de 00 00 00    	je     2a3 <mm_map36+0x167>
				uint64_t b;
				/* allocate a page table */
				pt = mm_alloc_page(&b);
     1c5:	83 ec 0c             	sub    esp,0xc
     1c8:	8d 45 c8             	lea    eax,[ebp-0x38]
     1cb:	50                   	push   eax
     1cc:	e8 fc ff ff ff       	call   1cd <mm_map36+0x91>
     1d1:	83 c4 10             	add    esp,0x10
     1d4:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax

				/* and set the reference in the PD */
				pd[pde].addr = b / 4096;
     1d7:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     1da:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     1dd:	0f ac d0 0c          	shrd   eax,edx,0xc
     1e1:	c1 ea 0c             	shr    edx,0xc
     1e4:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     1e7:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
     1ee:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     1f1:	01 d9                	add    ecx,ebx
     1f3:	81 e2 ff 00 00 00    	and    edx,0xff
     1f9:	89 c3                	mov    ebx,eax
     1fb:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
     201:	89 de                	mov    esi,ebx
     203:	c1 e6 0c             	shl    esi,0xc
     206:	8b 19                	mov    ebx,DWORD PTR [ecx]
     208:	81 e3 ff 0f 00 00    	and    ebx,0xfff
     20e:	09 f3                	or     ebx,esi
     210:	89 19                	mov    DWORD PTR [ecx],ebx
     212:	89 c3                	mov    ebx,eax
     214:	c1 eb 14             	shr    ebx,0x14
     217:	89 de                	mov    esi,ebx
     219:	66 81 e6 ff 0f       	and    si,0xfff
     21e:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
     222:	66 81 e3 00 f0       	and    bx,0xf000
     227:	09 f3                	or     ebx,esi
     229:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
     22d:	0f b6 c2             	movzx  eax,dl
     230:	c1 e0 0c             	shl    eax,0xc
     233:	89 c2                	mov    edx,eax
     235:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
     238:	25 ff 0f f0 ff       	and    eax,0xfff00fff
     23d:	09 d0                	or     eax,edx
     23f:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pd[pde].u = 1;
     242:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     245:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     24c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     24f:	01 d0                	add    eax,edx
     251:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     254:	83 ca 04             	or     edx,0x4
     257:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
     259:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     25c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     263:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     266:	01 d0                	add    eax,edx
     268:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     26b:	83 ca 02             	or     edx,0x2
     26e:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
     270:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     273:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     27a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     27d:	01 d0                	add    eax,edx
     27f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     282:	83 ca 01             	or     edx,0x1
     285:	88 10                	mov    BYTE PTR [eax],dl

				/* release CS */
				vp->pts[pdpte * 512 + pde] = pt;
     287:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     28a:	c1 e0 09             	shl    eax,0x9
     28d:	89 c2                	mov    edx,eax
     28f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     292:	01 c2                	add    edx,eax
     294:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     297:	8d 4a 0c             	lea    ecx,[edx+0xc]
     29a:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     29d:	89 54 88 04          	mov    DWORD PTR [eax+ecx*4+0x4],edx
     2a1:	eb 40                	jmp    2e3 <mm_map36+0x1a7>
		} else {
				SPIN_CS(vp->pts[pdpte * 512 + pde]);
     2a3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2a6:	c1 e0 09             	shl    eax,0x9
     2a9:	89 c2                	mov    edx,eax
     2ab:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2ae:	01 d0                	add    eax,edx
     2b0:	83 c0 0c             	add    eax,0xc
     2b3:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     2ba:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     2bd:	01 d0                	add    eax,edx
     2bf:	83 c0 04             	add    eax,0x4
     2c2:	8b 00                	mov    eax,DWORD PTR [eax]
     2c4:	83 f8 ff             	cmp    eax,0xffffffff
     2c7:	74 da                	je     2a3 <mm_map36+0x167>
				pt = vp->pts[pdpte * 512 + pde];
     2c9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     2cc:	c1 e0 09             	shl    eax,0x9
     2cf:	89 c2                	mov    edx,eax
     2d1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2d4:	01 c2                	add    edx,eax
     2d6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     2d9:	83 c2 0c             	add    edx,0xc
     2dc:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     2e0:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		}

		/* now map the pages */
		pr_copy = *pr++;
     2e3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     2e6:	8d 50 0c             	lea    edx,[eax+0xc]
     2e9:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
     2ec:	8b 10                	mov    edx,DWORD PTR [eax]
     2ee:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
     2f1:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     2f4:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
     2f7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     2fa:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		while (prc) {
     2fd:	e9 d7 02 00 00       	jmp    5d9 <mm_map36+0x49d>
				pt[pte].addr = pr_copy.base / 4096;
     302:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     305:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     308:	0f ac d0 0c          	shrd   eax,edx,0xc
     30c:	c1 ea 0c             	shr    edx,0xc
     30f:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     312:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
     319:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     31c:	01 d9                	add    ecx,ebx
     31e:	81 e2 ff 00 00 00    	and    edx,0xff
     324:	89 c3                	mov    ebx,eax
     326:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
     32c:	89 de                	mov    esi,ebx
     32e:	c1 e6 0c             	shl    esi,0xc
     331:	8b 19                	mov    ebx,DWORD PTR [ecx]
     333:	81 e3 ff 0f 00 00    	and    ebx,0xfff
     339:	09 f3                	or     ebx,esi
     33b:	89 19                	mov    DWORD PTR [ecx],ebx
     33d:	89 c3                	mov    ebx,eax
     33f:	c1 eb 14             	shr    ebx,0x14
     342:	89 de                	mov    esi,ebx
     344:	66 81 e6 ff 0f       	and    si,0xfff
     349:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
     34d:	66 81 e3 00 f0       	and    bx,0xf000
     352:	09 f3                	or     ebx,esi
     354:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
     358:	0f b6 c2             	movzx  eax,dl
     35b:	c1 e0 0c             	shl    eax,0xc
     35e:	89 c2                	mov    edx,eax
     360:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
     363:	25 ff 0f f0 ff       	and    eax,0xfff00fff
     368:	09 d0                	or     eax,edx
     36a:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
				pt[pte].u = 1; /* FIXME: for now (u ? 1 : 0) */
     36d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     370:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     377:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     37a:	01 d0                	add    eax,edx
     37c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     37f:	83 ca 04             	or     edx,0x4
     382:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].w = (w ? 1 : 0);
     384:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     387:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     38e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     391:	01 d0                	add    eax,edx
     393:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
     397:	0f 95 c2             	setne  dl
     39a:	83 e2 01             	and    edx,0x1
     39d:	8d 0c 12             	lea    ecx,[edx+edx*1]
     3a0:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     3a3:	83 e2 fd             	and    edx,0xfffffffd
     3a6:	09 ca                	or     edx,ecx
     3a8:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
     3aa:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     3ad:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     3b4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     3b7:	01 d0                	add    eax,edx
     3b9:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     3bc:	83 ca 01             	or     edx,0x1
     3bf:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
     3c1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     3c4:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     3cb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     3ce:	01 d0                	add    eax,edx
     3d0:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     3d4:	0f 95 c2             	setne  dl
     3d7:	89 d1                	mov    ecx,edx
     3d9:	c1 e1 07             	shl    ecx,0x7
     3dc:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     3df:	83 e2 7f             	and    edx,0x7f
     3e2:	09 ca                	or     edx,ecx
     3e4:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].wt = (wt ? 1 : 0);
     3e6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     3e9:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     3f0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     3f3:	01 d0                	add    eax,edx
     3f5:	83 7d 24 00          	cmp    DWORD PTR [ebp+0x24],0x0
     3f9:	0f 95 c2             	setne  dl
     3fc:	83 e2 01             	and    edx,0x1
     3ff:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
     406:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     409:	83 e2 f7             	and    edx,0xfffffff7
     40c:	09 ca                	or     edx,ecx
     40e:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].cd = (cd ? 1 : 0);
     410:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     413:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     41a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     41d:	01 d0                	add    eax,edx
     41f:	83 7d 28 00          	cmp    DWORD PTR [ebp+0x28],0x0
     423:	0f 95 c2             	setne  dl
     426:	83 e2 01             	and    edx,0x1
     429:	89 d1                	mov    ecx,edx
     42b:	c1 e1 04             	shl    ecx,0x4
     42e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     431:	83 e2 ef             	and    edx,0xffffffef
     434:	09 ca                	or     edx,ecx
     436:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].g = (g ? 1 : 0);
     438:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     43b:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     442:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     445:	01 d0                	add    eax,edx
     447:	83 7d 2c 00          	cmp    DWORD PTR [ebp+0x2c],0x0
     44b:	0f 95 c2             	setne  dl
     44e:	89 d1                	mov    ecx,edx
     450:	83 e1 01             	and    ecx,0x1
     453:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     457:	83 e2 fe             	and    edx,0xfffffffe
     45a:	09 ca                	or     edx,ecx
     45c:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
				pt[pte].u = 1; /* FIXME: for now */
     45f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     462:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     469:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     46c:	01 d0                	add    eax,edx
     46e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     471:	83 ca 04             	or     edx,0x4
     474:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].ign = avl & 7;
     476:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     479:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     480:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     483:	01 c2                	add    edx,eax
     485:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
     488:	83 e0 07             	and    eax,0x7
     48b:	83 e0 07             	and    eax,0x7
     48e:	8d 0c 00             	lea    ecx,[eax+eax*1]
     491:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
     495:	83 e0 f1             	and    eax,0xfffffff1
     498:	09 c8                	or     eax,ecx
     49a:	88 42 01             	mov    BYTE PTR [edx+0x1],al
				pt[pte].ign2 = (avl >> 3);
     49d:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
     4a0:	c1 f8 03             	sar    eax,0x3
     4a3:	89 c1                	mov    ecx,eax
     4a5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     4a8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     4af:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     4b2:	01 c2                	add    edx,eax
     4b4:	89 c8                	mov    eax,ecx
     4b6:	66 25 ff 07          	and    ax,0x7ff
     4ba:	66 25 ff 07          	and    ax,0x7ff
     4be:	c1 e0 04             	shl    eax,0x4
     4c1:	89 c1                	mov    ecx,eax
     4c3:	0f b7 42 06          	movzx  eax,WORD PTR [edx+0x6]
     4c7:	66 25 0f 80          	and    ax,0x800f
     4cb:	09 c8                	or     eax,ecx
     4cd:	66 89 42 06          	mov    WORD PTR [edx+0x6],ax
				if (cpu.e_has_nx)
     4d1:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
     4d8:	83 e0 10             	and    eax,0x10
     4db:	84 c0                	test   al,al
     4dd:	74 27                	je     506 <mm_map36+0x3ca>
						pt[pte].xd = (x ? 0 : 1);
     4df:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     4e2:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     4e9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     4ec:	01 d0                	add    eax,edx
     4ee:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     4f2:	0f 94 c2             	sete   dl
     4f5:	89 d1                	mov    ecx,edx
     4f7:	c1 e1 07             	shl    ecx,0x7
     4fa:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
     4fe:	83 e2 7f             	and    edx,0x7f
     501:	09 ca                	or     edx,ecx
     503:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
				/* advance */
				if (pte++ == 511) {
     506:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     509:	8d 50 01             	lea    edx,[eax+0x1]
     50c:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     50f:	3d ff 01 00 00       	cmp    eax,0x1ff
     514:	75 78                	jne    58e <mm_map36+0x452>
						if (pde++ == 511) {
     516:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     519:	8d 50 01             	lea    edx,[eax+0x1]
     51c:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
     51f:	3d ff 01 00 00       	cmp    eax,0x1ff
     524:	75 5c                	jne    582 <mm_map36+0x446>
								if (pdpte++ == 3) {
     526:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     529:	8d 50 01             	lea    edx,[eax+0x1]
     52c:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     52f:	83 f8 03             	cmp    eax,0x3
     532:	75 2b                	jne    55f <mm_map36+0x423>
										die("End of 4G address space\n");
     534:	83 ec 08             	sub    esp,0x8
     537:	68 5e 00 00 00       	push   0x5e
     53c:	6a 0c                	push   0xc
     53e:	e8 fc ff ff ff       	call   53f <mm_map36+0x403>
     543:	83 c4 10             	add    esp,0x10
     546:	e8 fc ff ff ff       	call   547 <mm_map36+0x40b>
     54b:	83 ec 0c             	sub    esp,0xc
     54e:	68 00 00 00 00       	push   0x0
     553:	e8 fc ff ff ff       	call   554 <mm_map36+0x418>
     558:	83 c4 10             	add    esp,0x10
     55b:	fa                   	cli
     55c:	f4                   	hlt
     55d:	eb fd                	jmp    55c <mm_map36+0x420>
								}
								pd = vp->pdp[pdpte];
     55f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     562:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     565:	83 c2 08             	add    edx,0x8
     568:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     56c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								pde = 0;
     56f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
								pte = 0;
     576:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
								goto new_pt;
     57d:	e9 0b fc ff ff       	jmp    18d <mm_map36+0x51>
						}
						pte = 0;
     582:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						goto new_pt;
     589:	e9 ff fb ff ff       	jmp    18d <mm_map36+0x51>
				}
				pr_copy.base += 4096;
     58e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     591:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     594:	05 00 10 00 00       	add    eax,0x1000
     599:	83 d2 00             	adc    edx,0x0
     59c:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     59f:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
				if (!--pr_copy.count) {
     5a2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5a5:	83 e8 01             	sub    eax,0x1
     5a8:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     5ab:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5ae:	85 c0                	test   eax,eax
     5b0:	75 27                	jne    5d9 <mm_map36+0x49d>
						if (prc--)
     5b2:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     5b5:	8d 50 ff             	lea    edx,[eax-0x1]
     5b8:	89 55 14             	mov    DWORD PTR [ebp+0x14],edx
     5bb:	85 c0                	test   eax,eax
     5bd:	74 1a                	je     5d9 <mm_map36+0x49d>
								pr_copy = *pr++;
     5bf:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     5c2:	8d 50 0c             	lea    edx,[eax+0xc]
     5c5:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
     5c8:	8b 10                	mov    edx,DWORD PTR [eax]
     5ca:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
     5cd:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     5d0:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
     5d3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     5d6:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		while (prc) {
     5d9:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     5dd:	0f 85 1f fd ff ff    	jne    302 <mm_map36+0x1c6>
				}
		}
		return vaddr;
     5e3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
}
     5e6:	8d 65 f8             	lea    esp,[ebp-0x8]
     5e9:	5b                   	pop    ebx
     5ea:	5e                   	pop    esi
     5eb:	5d                   	pop    ebp
     5ec:	c3                   	ret

000005ed <mm_map32>:

void* mm_map32(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
{
     5ed:	55                   	push   ebp
     5ee:	89 e5                	mov    ebp,esp
     5f0:	53                   	push   ebx
     5f1:	83 ec 34             	sub    esp,0x34
		struct vm_pg_ptrs32* vp = vm_mapping;
     5f4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5f7:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		uint32_t pde, pte;
		struct page_range pr_copy;

		/* entry pointers */
		struct pte32* pd = vp->pd;
     5fa:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     5fd:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     600:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct pte32* pt = 0;
     603:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0

		/* and the PDE */
		pde = ((uint32_t)vaddr & 0xffc00000) >> 22; /* 4M per PDE */
     60a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     60d:	c1 e8 16             	shr    eax,0x16
     610:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* and finally the PTE */
		pte = ((uint32_t)vaddr & 0x3ff000) >> 12; /* 4K per PTE */
     613:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     616:	c1 e8 0c             	shr    eax,0xc
     619:	25 ff 03 00 00       	and    eax,0x3ff
     61e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

new_pt:
		/* create a PT if not there */
		if (ENTER_CS_PTE(vp->pts[pde])) {
     621:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     624:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     62b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     62e:	01 d0                	add    eax,edx
     630:	8d 50 08             	lea    edx,[eax+0x8]
     633:	b8 00 00 00 00       	mov    eax,0x0
     638:	b9 ff ff ff ff       	mov    ecx,0xffffffff
     63d:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     641:	0f 94 c0             	sete   al
     644:	84 c0                	test   al,al
     646:	0f 84 97 00 00 00    	je     6e3 <mm_map32+0xf6>
				uint64_t b;
				/* allocate a page table */
				pt = mm_alloc_page(&b);
     64c:	83 ec 0c             	sub    esp,0xc
     64f:	8d 45 d0             	lea    eax,[ebp-0x30]
     652:	50                   	push   eax
     653:	e8 fc ff ff ff       	call   654 <mm_map32+0x67>
     658:	83 c4 10             	add    esp,0x10
     65b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

				/* and set the reference in the PD */
				pd[pde].addr = (uint32_t)(b / 4096);
     65e:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     661:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     664:	0f ac d0 0c          	shrd   eax,edx,0xc
     668:	c1 ea 0c             	shr    edx,0xc
     66b:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     66e:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
     675:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     678:	01 d9                	add    ecx,ebx
     67a:	25 ff ff 0f 00       	and    eax,0xfffff
     67f:	c1 e0 0c             	shl    eax,0xc
     682:	89 c2                	mov    edx,eax
     684:	8b 01                	mov    eax,DWORD PTR [ecx]
     686:	25 ff 0f 00 00       	and    eax,0xfff
     68b:	09 d0                	or     eax,edx
     68d:	89 01                	mov    DWORD PTR [ecx],eax
				pd[pde].u = 1;
     68f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     692:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     699:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     69c:	01 d0                	add    eax,edx
     69e:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     6a1:	83 ca 04             	or     edx,0x4
     6a4:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].w = 1;
     6a6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     6a9:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     6b0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     6b3:	01 d0                	add    eax,edx
     6b5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     6b8:	83 ca 02             	or     edx,0x2
     6bb:	88 10                	mov    BYTE PTR [eax],dl
				pd[pde].p = 1;
     6bd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     6c0:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     6c7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     6ca:	01 d0                	add    eax,edx
     6cc:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     6cf:	83 ca 01             	or     edx,0x1
     6d2:	88 10                	mov    BYTE PTR [eax],dl
	
				/* release CS */
				vp->pts[pde] = pt;
     6d4:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     6d7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     6da:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     6dd:	89 4c 90 08          	mov    DWORD PTR [eax+edx*4+0x8],ecx
     6e1:	eb 26                	jmp    709 <mm_map32+0x11c>
		} else {
				/* wait until valid and fetch */
				SPIN_CS(vp->pts[pde]);
     6e3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     6e6:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     6ed:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     6f0:	01 d0                	add    eax,edx
     6f2:	83 c0 08             	add    eax,0x8
     6f5:	8b 00                	mov    eax,DWORD PTR [eax]
     6f7:	83 f8 ff             	cmp    eax,0xffffffff
     6fa:	74 e7                	je     6e3 <mm_map32+0xf6>
				pt = vp->pts[pde];
     6fc:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     6ff:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     702:	8b 44 90 08          	mov    eax,DWORD PTR [eax+edx*4+0x8]
     706:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		}

		/* now map the pages */
		pr_copy = *pr++;
     709:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     70c:	8d 50 0c             	lea    edx,[eax+0xc]
     70f:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
     712:	8b 10                	mov    edx,DWORD PTR [eax]
     714:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
     717:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     71a:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     71d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     720:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		while (prc) {
     723:	e9 ec 01 00 00       	jmp    914 <mm_map32+0x327>
				pt[pte].addr = pr_copy.base / 4096;
     728:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     72b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     72e:	0f ac d0 0c          	shrd   eax,edx,0xc
     732:	c1 ea 0c             	shr    edx,0xc
     735:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     738:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
     73f:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     742:	01 d9                	add    ecx,ebx
     744:	25 ff ff 0f 00       	and    eax,0xfffff
     749:	c1 e0 0c             	shl    eax,0xc
     74c:	89 c2                	mov    edx,eax
     74e:	8b 01                	mov    eax,DWORD PTR [ecx]
     750:	25 ff 0f 00 00       	and    eax,0xfff
     755:	09 d0                	or     eax,edx
     757:	89 01                	mov    DWORD PTR [ecx],eax
				pt[pte].u = 1; /* FIXME: for now (u ? 1 : 0) */
     759:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     75c:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     763:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     766:	01 d0                	add    eax,edx
     768:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     76b:	83 ca 04             	or     edx,0x4
     76e:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].w = (w ? 1 : 0);
     770:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     773:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     77a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     77d:	01 d0                	add    eax,edx
     77f:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
     783:	0f 95 c2             	setne  dl
     786:	83 e2 01             	and    edx,0x1
     789:	8d 0c 12             	lea    ecx,[edx+edx*1]
     78c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     78f:	83 e2 fd             	and    edx,0xfffffffd
     792:	09 ca                	or     edx,ecx
     794:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].p = 1;
     796:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     799:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     7a0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     7a3:	01 d0                	add    eax,edx
     7a5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     7a8:	83 ca 01             	or     edx,0x1
     7ab:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
     7ad:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7b0:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     7b7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     7ba:	01 d0                	add    eax,edx
     7bc:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     7c0:	0f 95 c2             	setne  dl
     7c3:	89 d1                	mov    ecx,edx
     7c5:	c1 e1 07             	shl    ecx,0x7
     7c8:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     7cb:	83 e2 7f             	and    edx,0x7f
     7ce:	09 ca                	or     edx,ecx
     7d0:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].wt = (wt ? 1 : 0);
     7d2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7d5:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     7dc:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     7df:	01 d0                	add    eax,edx
     7e1:	83 7d 24 00          	cmp    DWORD PTR [ebp+0x24],0x0
     7e5:	0f 95 c2             	setne  dl
     7e8:	83 e2 01             	and    edx,0x1
     7eb:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
     7f2:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     7f5:	83 e2 f7             	and    edx,0xfffffff7
     7f8:	09 ca                	or     edx,ecx
     7fa:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].cd = (cd ? 1 : 0);
     7fc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7ff:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     806:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     809:	01 d0                	add    eax,edx
     80b:	83 7d 28 00          	cmp    DWORD PTR [ebp+0x28],0x0
     80f:	0f 95 c2             	setne  dl
     812:	83 e2 01             	and    edx,0x1
     815:	89 d1                	mov    ecx,edx
     817:	c1 e1 04             	shl    ecx,0x4
     81a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     81d:	83 e2 ef             	and    edx,0xffffffef
     820:	09 ca                	or     edx,ecx
     822:	88 10                	mov    BYTE PTR [eax],dl
				pt[pte].g = (g ? 1 : 0);
     824:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     827:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     82e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     831:	01 d0                	add    eax,edx
     833:	83 7d 2c 00          	cmp    DWORD PTR [ebp+0x2c],0x0
     837:	0f 95 c2             	setne  dl
     83a:	89 d1                	mov    ecx,edx
     83c:	83 e1 01             	and    ecx,0x1
     83f:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
     843:	83 e2 fe             	and    edx,0xfffffffe
     846:	09 ca                	or     edx,ecx
     848:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
				pt[pte].ign = avl & 7;
     84b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     84e:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     855:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     858:	01 c2                	add    edx,eax
     85a:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
     85d:	83 e0 07             	and    eax,0x7
     860:	83 e0 07             	and    eax,0x7
     863:	8d 0c 00             	lea    ecx,[eax+eax*1]
     866:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
     86a:	83 e0 f1             	and    eax,0xfffffff1
     86d:	09 c8                	or     eax,ecx
     86f:	88 42 01             	mov    BYTE PTR [edx+0x1],al
				/* advance */
				if (pte++ == 1023) {
     872:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     875:	8d 50 01             	lea    edx,[eax+0x1]
     878:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
     87b:	3d ff 03 00 00       	cmp    eax,0x3ff
     880:	75 47                	jne    8c9 <mm_map32+0x2dc>
						if (pde++ == 1023) {
     882:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     885:	8d 50 01             	lea    edx,[eax+0x1]
     888:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     88b:	3d ff 03 00 00       	cmp    eax,0x3ff
     890:	75 2b                	jne    8bd <mm_map32+0x2d0>
								die("end of 4G address space\n");
     892:	83 ec 08             	sub    esp,0x8
     895:	68 77 00 00 00       	push   0x77
     89a:	6a 0c                	push   0xc
     89c:	e8 fc ff ff ff       	call   89d <mm_map32+0x2b0>
     8a1:	83 c4 10             	add    esp,0x10
     8a4:	e8 fc ff ff ff       	call   8a5 <mm_map32+0x2b8>
     8a9:	83 ec 0c             	sub    esp,0xc
     8ac:	68 00 00 00 00       	push   0x0
     8b1:	e8 fc ff ff ff       	call   8b2 <mm_map32+0x2c5>
     8b6:	83 c4 10             	add    esp,0x10
     8b9:	fa                   	cli
     8ba:	f4                   	hlt
     8bb:	eb fd                	jmp    8ba <mm_map32+0x2cd>
						}
						pte = 0;
     8bd:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
						goto new_pt;
     8c4:	e9 58 fd ff ff       	jmp    621 <mm_map32+0x34>
				}
				pr_copy.base += 4096;
     8c9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     8cc:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     8cf:	05 00 10 00 00       	add    eax,0x1000
     8d4:	83 d2 00             	adc    edx,0x0
     8d7:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     8da:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
				if (!--pr_copy.count) {
     8dd:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     8e0:	83 e8 01             	sub    eax,0x1
     8e3:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     8e6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     8e9:	85 c0                	test   eax,eax
     8eb:	75 27                	jne    914 <mm_map32+0x327>
						if (prc--)
     8ed:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     8f0:	8d 50 ff             	lea    edx,[eax-0x1]
     8f3:	89 55 14             	mov    DWORD PTR [ebp+0x14],edx
     8f6:	85 c0                	test   eax,eax
     8f8:	74 1a                	je     914 <mm_map32+0x327>
								pr_copy = *pr++;
     8fa:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     8fd:	8d 50 0c             	lea    edx,[eax+0xc]
     900:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
     903:	8b 10                	mov    edx,DWORD PTR [eax]
     905:	89 55 d8             	mov    DWORD PTR [ebp-0x28],edx
     908:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     90b:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     90e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     911:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		while (prc) {
     914:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     918:	0f 85 0a fe ff ff    	jne    728 <mm_map32+0x13b>
				}
		}
		return vaddr;
     91e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
}
     921:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     924:	c9                   	leave
     925:	c3                   	ret

00000926 <mm_map>:
map_fun mf_map = NULL;
#endif

void* mm_map(struct mm* mm, void* virt_address,	const struct page_range* prs,
				size_t pr_ct, int flags)
{
     926:	55                   	push   ebp
     927:	89 e5                	mov    ebp,esp
     929:	83 ec 38             	sub    esp,0x38
		int x = flags & MMGR_MAP_EXECUTE, w = flags & MMGR_MAP_WRITE,
     92c:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     92f:	83 e0 02             	and    eax,0x2
     932:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
     935:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     938:	83 e0 04             	and    eax,0x4
     93b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
			wc = flags & MMGR_MAP_PAT, wt = flags & MMGR_MAP_WRITE_THROUGH,
     93e:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     941:	25 80 00 00 00       	and    eax,0x80
     946:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     949:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     94c:	83 e0 10             	and    eax,0x10
     94f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
			cd = flags & MMGR_MAP_NO_CACHING, g = flags & MMGR_MAP_GLOBAL,
     952:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     955:	83 e0 20             	and    eax,0x20
     958:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     95b:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     95e:	83 e0 40             	and    eax,0x40
     961:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
			u = !(flags & MMGR_MAP_KERNEL);
     964:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     967:	83 e0 08             	and    eax,0x8
     96a:	85 c0                	test   eax,eax
     96c:	0f 94 c0             	sete   al
     96f:	0f b6 c0             	movzx  eax,al
     972:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		int avl = 0;
     975:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0

		if (flags & MMGR_MAP_COW) {
     97c:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     97f:	25 00 02 00 00       	and    eax,0x200
     984:	85 c0                	test   eax,eax
     986:	74 0e                	je     996 <mm_map+0x70>
				avl = MMGR_AVL_COW;
     988:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [ebp-0x10],0x1
				w = 0; /* make COW workable */
     98f:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		}

		/* get virtutal memory */
		if (!virt_address) {
     996:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     99a:	75 4c                	jne    9e8 <mm_map+0xc2>
				size_t pg_ct = 0;
     99c:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				for (size_t i = 0; i < pr_ct; i++)
     9a3:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     9aa:	eb 1d                	jmp    9c9 <mm_map+0xa3>
						pg_ct += prs[i].count;
     9ac:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     9af:	89 d0                	mov    eax,edx
     9b1:	01 c0                	add    eax,eax
     9b3:	01 d0                	add    eax,edx
     9b5:	c1 e0 02             	shl    eax,0x2
     9b8:	89 c2                	mov    edx,eax
     9ba:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     9bd:	01 d0                	add    eax,edx
     9bf:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     9c2:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
				for (size_t i = 0; i < pr_ct; i++)
     9c5:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
     9c9:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     9cc:	3b 45 14             	cmp    eax,DWORD PTR [ebp+0x14]
     9cf:	72 db                	jb     9ac <mm_map+0x86>
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);
     9d1:	83 ec 04             	sub    esp,0x4
     9d4:	ff 75 18             	push   DWORD PTR [ebp+0x18]
     9d7:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     9da:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     9dd:	e8 fc ff ff ff       	call   9de <mm_map+0xb8>
     9e2:	83 c4 10             	add    esp,0x10
     9e5:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
		}

#ifdef __x86_64__
		return mm_map64(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
#else
		return mf_map(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
     9e8:	a1 00 00 00 00       	mov    eax,ds:0x0
     9ed:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     9f0:	8b 52 08             	mov    edx,DWORD PTR [edx+0x8]
     9f3:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     9f6:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
     9f9:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     9fc:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
     9ff:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
     a02:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     a05:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     a08:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     a0b:	ff 75 14             	push   DWORD PTR [ebp+0x14]
     a0e:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     a11:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     a14:	52                   	push   edx
     a15:	ff d0                	call   eax
     a17:	83 c4 30             	add    esp,0x30
#endif
}
     a1a:	c9                   	leave
     a1b:	c3                   	ret

00000a1c <mm_page_walk36>:
		return (pt[pte].p ? 0 : -1);
}
#else
int mm_page_walk36(void* vm_mapping, void* virt_addr, struct pte64** parent,
				struct pte64** entry, int* level, uint32_t* offset, void*** cntr, void*** cntrm)
{
     a1c:	55                   	push   ebp
     a1d:	89 e5                	mov    ebp,esp
     a1f:	83 ec 20             	sub    esp,0x20
		struct vm_pg_ptrs36* vp = vm_mapping;
     a22:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a25:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		uint32_t pdpte, pde, pte;

		/* entry pointers */
		struct pte64* pd = 0;
     a28:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
		struct pte64* pt = 0;
     a2f:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		*cntrm = NULL;
     a36:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     a39:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0

		/* the PDPTE */
		pdpte = ((uint32_t)virt_addr & 0xc0000000) >> 30; /* 1G per PDPTE */
     a3f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a42:	c1 e8 1e             	shr    eax,0x1e
     a45:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		pd = vp->pdp[pdpte];
     a48:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     a4b:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     a4e:	83 c2 08             	add    edx,0x8
     a51:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     a55:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax

		/* and the PDE */
		pde = ((uint32_t)virt_addr & 0x3fe00000) >> 21; /* 2M per PDE */
     a58:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a5b:	c1 e8 15             	shr    eax,0x15
     a5e:	25 ff 01 00 00       	and    eax,0x1ff
     a63:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* and finally the PTE */
		pte = ((uint32_t)virt_addr & 0x1ff000) >> 12; /* 4K per PTE */
     a66:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a69:	c1 e8 0c             	shr    eax,0xc
     a6c:	25 ff 01 00 00       	and    eax,0x1ff
     a71:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

		/* PDPTE */
		if (!vp->pdps[pdpte].p) {
     a74:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     a77:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     a7a:	0f b6 04 d0          	movzx  eax,BYTE PTR [eax+edx*8]
     a7e:	83 e0 01             	and    eax,0x1
     a81:	84 c0                	test   al,al
     a83:	75 41                	jne    ac6 <mm_page_walk36+0xaa>
				*parent = NULL;
     a85:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     a88:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				*entry = &vp->pdps[pdpte];
     a8e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a91:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     a98:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     a9b:	01 c2                	add    edx,eax
     a9d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     aa0:	89 10                	mov    DWORD PTR [eax],edx
				*offset = pdpte;
     aa2:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     aa5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     aa8:	89 10                	mov    DWORD PTR [eax],edx
				*cntr = NULL; /* we have to reload CR3 */
     aaa:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     aad:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				*level = 2;
     ab3:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     ab6:	c7 00 02 00 00 00    	mov    DWORD PTR [eax],0x2
				return -1;
     abc:	b8 ff ff ff ff       	mov    eax,0xffffffff
     ac1:	e9 2c 01 00 00       	jmp    bf2 <mm_page_walk36+0x1d6>
		}

		/* PDE */
		if (!pd[pde].p || pd[pde].s) {
     ac6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     ac9:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     ad0:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     ad3:	01 d0                	add    eax,edx
     ad5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     ad8:	83 e0 01             	and    eax,0x1
     adb:	84 c0                	test   al,al
     add:	74 19                	je     af8 <mm_page_walk36+0xdc>
     adf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     ae2:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     ae9:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     aec:	01 d0                	add    eax,edx
     aee:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     af1:	83 e0 80             	and    eax,0xffffff80
     af4:	84 c0                	test   al,al
     af6:	74 79                	je     b71 <mm_page_walk36+0x155>
				*parent = &vp->pdps[pdpte];
     af8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     afb:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     b02:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     b05:	01 c2                	add    edx,eax
     b07:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     b0a:	89 10                	mov    DWORD PTR [eax],edx
				*entry = &pd[pde];
     b0c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     b0f:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     b16:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     b19:	01 c2                	add    edx,eax
     b1b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     b1e:	89 10                	mov    DWORD PTR [eax],edx
				*offset = pde;
     b20:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     b23:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     b26:	89 10                	mov    DWORD PTR [eax],edx
				*level = 1;
     b28:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     b2b:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
				*cntr = (void**)(vp->pts + pdpte * 512);
     b31:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     b34:	8d 50 34             	lea    edx,[eax+0x34]
     b37:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     b3a:	c1 e0 0b             	shl    eax,0xb
     b3d:	01 c2                	add    edx,eax
     b3f:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     b42:	89 10                	mov    DWORD PTR [eax],edx
				/* 2M pages OK */
				return (pd[pde].s ? 0 : -1);
     b44:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     b47:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     b4e:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     b51:	01 d0                	add    eax,edx
     b53:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     b56:	83 e0 80             	and    eax,0xffffff80
     b59:	84 c0                	test   al,al
     b5b:	74 0a                	je     b67 <mm_page_walk36+0x14b>
     b5d:	b8 00 00 00 00       	mov    eax,0x0
     b62:	e9 8b 00 00 00       	jmp    bf2 <mm_page_walk36+0x1d6>
     b67:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b6c:	e9 81 00 00 00       	jmp    bf2 <mm_page_walk36+0x1d6>
		}

		pt = vp->pts[512 * pdpte + pde];
     b71:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     b74:	c1 e0 09             	shl    eax,0x9
     b77:	89 c2                	mov    edx,eax
     b79:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     b7c:	01 c2                	add    edx,eax
     b7e:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     b81:	83 c2 0c             	add    edx,0xc
     b84:	8b 44 90 04          	mov    eax,DWORD PTR [eax+edx*4+0x4]
     b88:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* PTE */
		*parent = &pd[pde];
     b8b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     b8e:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     b95:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     b98:	01 c2                	add    edx,eax
     b9a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     b9d:	89 10                	mov    DWORD PTR [eax],edx
		*entry = &pt[pte];
     b9f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     ba2:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     ba9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     bac:	01 c2                	add    edx,eax
     bae:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     bb1:	89 10                	mov    DWORD PTR [eax],edx
		*offset = pte;
     bb3:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     bb6:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     bb9:	89 10                	mov    DWORD PTR [eax],edx
		*cntr = NULL;
     bbb:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     bbe:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		*level = 0;
     bc4:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     bc7:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		/* present or not? */
		return (pt[pte].p ? 0 : -1);
     bcd:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     bd0:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     bd7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     bda:	01 d0                	add    eax,edx
     bdc:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     bdf:	83 e0 01             	and    eax,0x1
     be2:	84 c0                	test   al,al
     be4:	74 07                	je     bed <mm_page_walk36+0x1d1>
     be6:	b8 00 00 00 00       	mov    eax,0x0
     beb:	eb 05                	jmp    bf2 <mm_page_walk36+0x1d6>
     bed:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     bf2:	c9                   	leave
     bf3:	c3                   	ret

00000bf4 <mm_page_walk32>:

int mm_page_walk32(void* vm_mapping, void* virt_addr, struct pte32** parent,
				struct pte32** entry, int* level, uint32_t* offset, void*** cntr, void*** cntrm)
{
     bf4:	55                   	push   ebp
     bf5:	89 e5                	mov    ebp,esp
     bf7:	83 ec 20             	sub    esp,0x20
		struct vm_pg_ptrs32* vp = vm_mapping;
     bfa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bfd:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		uint32_t pde, pte;

		/* entry pointers */
		struct pte32* pd = vp->pd;
     c00:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     c03:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     c06:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		struct pte32* pt = 0;
     c09:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		*cntrm = NULL;
     c10:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     c13:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0

		/* and the PDE */
		pde = ((uint32_t)virt_addr & 0xffc00000) >> 22; /* 4M per PDE */
     c19:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c1c:	c1 e8 16             	shr    eax,0x16
     c1f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax

		/* and finally the PTE */
		pte = ((uint32_t)virt_addr & 0x3ff000) >> 12; /* 4K per PTE */
     c22:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c25:	c1 e8 0c             	shr    eax,0xc
     c28:	25 ff 03 00 00       	and    eax,0x3ff
     c2d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

		/* walk the hierachy */
		if (!pd) {
     c30:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     c34:	75 38                	jne    c6e <mm_page_walk32+0x7a>
				*entry = *parent = 0;
     c36:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c39:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     c3f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c42:	8b 10                	mov    edx,DWORD PTR [eax]
     c44:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     c47:	89 10                	mov    DWORD PTR [eax],edx
				*offset = -1; /* CR3 invalid */
     c49:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     c4c:	c7 00 ff ff ff ff    	mov    DWORD PTR [eax],0xffffffff
				*level = 2;
     c52:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     c55:	c7 00 02 00 00 00    	mov    DWORD PTR [eax],0x2
				*cntr = NULL; /* reload CR3 */
     c5b:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     c5e:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				return -1;
     c64:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c69:	e9 06 01 00 00       	jmp    d74 <mm_page_walk32+0x180>
		}

		/* PDE */
		if (pd[pde].p || pd[pde].s) {
     c6e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c71:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     c78:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     c7b:	01 d0                	add    eax,edx
     c7d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     c80:	83 e0 01             	and    eax,0x1
     c83:	84 c0                	test   al,al
     c85:	75 19                	jne    ca0 <mm_page_walk32+0xac>
     c87:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     c8a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     c91:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     c94:	01 d0                	add    eax,edx
     c96:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     c99:	83 e0 80             	and    eax,0xffffff80
     c9c:	84 c0                	test   al,al
     c9e:	74 60                	je     d00 <mm_page_walk32+0x10c>
				*parent = NULL;
     ca0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     ca3:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				*entry = &pd[pde];
     ca9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     cac:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     cb3:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     cb6:	01 c2                	add    edx,eax
     cb8:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     cbb:	89 10                	mov    DWORD PTR [eax],edx
				*offset = pde;
     cbd:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     cc0:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     cc3:	89 10                	mov    DWORD PTR [eax],edx
				*level = 1;
     cc5:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     cc8:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
				*cntr = (void**)vp->pts;
     cce:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     cd1:	8d 50 08             	lea    edx,[eax+0x8]
     cd4:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     cd7:	89 10                	mov    DWORD PTR [eax],edx
				/* 4M pages are OK */
				return (pd[pde].s ? 0 : -1);
     cd9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     cdc:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     ce3:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     ce6:	01 d0                	add    eax,edx
     ce8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     ceb:	83 e0 80             	and    eax,0xffffff80
     cee:	84 c0                	test   al,al
     cf0:	74 07                	je     cf9 <mm_page_walk32+0x105>
     cf2:	b8 00 00 00 00       	mov    eax,0x0
     cf7:	eb 7b                	jmp    d74 <mm_page_walk32+0x180>
     cf9:	b8 ff ff ff ff       	mov    eax,0xffffffff
     cfe:	eb 74                	jmp    d74 <mm_page_walk32+0x180>
		}

		pt = vp->pts[pde];
     d00:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     d03:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d06:	8b 44 90 08          	mov    eax,DWORD PTR [eax+edx*4+0x8]
     d0a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		/* PTE */
		*parent = &pd[pde];
     d0d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     d10:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     d17:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     d1a:	01 c2                	add    edx,eax
     d1c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d1f:	89 10                	mov    DWORD PTR [eax],edx
		*entry = &pt[pte];
     d21:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     d24:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     d2b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d2e:	01 c2                	add    edx,eax
     d30:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     d33:	89 10                	mov    DWORD PTR [eax],edx
		*offset = pte;
     d35:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     d38:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     d3b:	89 10                	mov    DWORD PTR [eax],edx
		*level = 0;
     d3d:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     d40:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		*cntr = NULL;
     d46:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     d49:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		/* present or not? */
		return (pt[pte].p ? 0 : -1);
     d4f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     d52:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     d59:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d5c:	01 d0                	add    eax,edx
     d5e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     d61:	83 e0 01             	and    eax,0x1
     d64:	84 c0                	test   al,al
     d66:	74 07                	je     d6f <mm_page_walk32+0x17b>
     d68:	b8 00 00 00 00       	mov    eax,0x0
     d6d:	eb 05                	jmp    d74 <mm_page_walk32+0x180>
     d6f:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     d74:	c9                   	leave
     d75:	c3                   	ret

00000d76 <mm_protect>:
#endif

void mm_protect(struct mm* mm, void* virt_address, size_t num_pages, int flags)
{
     d76:	55                   	push   ebp
     d77:	89 e5                	mov    ebp,esp
     d79:	56                   	push   esi
     d7a:	53                   	push   ebx
     d7b:	83 ec 40             	sub    esp,0x40
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (num_pages--) {
     d7e:	e9 3e 07 00 00       	jmp    14c1 <mm_protect+0x74b>
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#else
				if (cpu.has_pae)
     d83:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
     d8a:	83 e0 40             	and    eax,0x40
     d8d:	84 c0                	test   al,al
     d8f:	74 2f                	je     dc0 <mm_protect+0x4a>
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
     d91:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d94:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     d97:	8d 55 d0             	lea    edx,[ebp-0x30]
     d9a:	52                   	push   edx
     d9b:	8d 55 d4             	lea    edx,[ebp-0x2c]
     d9e:	52                   	push   edx
     d9f:	8d 55 e0             	lea    edx,[ebp-0x20]
     da2:	52                   	push   edx
     da3:	8d 55 e4             	lea    edx,[ebp-0x1c]
     da6:	52                   	push   edx
     da7:	8d 55 d8             	lea    edx,[ebp-0x28]
     daa:	52                   	push   edx
     dab:	8d 55 dc             	lea    edx,[ebp-0x24]
     dae:	52                   	push   edx
     daf:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     db2:	50                   	push   eax
     db3:	e8 fc ff ff ff       	call   db4 <mm_protect+0x3e>
     db8:	83 c4 20             	add    esp,0x20
     dbb:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     dbe:	eb 2d                	jmp    ded <mm_protect+0x77>
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
     dc0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     dc3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     dc6:	8d 55 d0             	lea    edx,[ebp-0x30]
     dc9:	52                   	push   edx
     dca:	8d 55 d4             	lea    edx,[ebp-0x2c]
     dcd:	52                   	push   edx
     dce:	8d 55 e0             	lea    edx,[ebp-0x20]
     dd1:	52                   	push   edx
     dd2:	8d 55 e4             	lea    edx,[ebp-0x1c]
     dd5:	52                   	push   edx
     dd6:	8d 55 d8             	lea    edx,[ebp-0x28]
     dd9:	52                   	push   edx
     dda:	8d 55 dc             	lea    edx,[ebp-0x24]
     ddd:	52                   	push   edx
     dde:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     de1:	50                   	push   eax
     de2:	e8 fc ff ff ff       	call   de3 <mm_protect+0x6d>
     de7:	83 c4 20             	add    esp,0x20
     dea:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
     ded:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     df1:	0f 85 dd 06 00 00    	jne    14d4 <mm_protect+0x75e>
						return;

				e32 = NULL; e64 = NULL;
     df7:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     dfe:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (!cpu.has_pae)
     e05:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
     e0c:	83 e0 40             	and    eax,0x40
     e0f:	84 c0                	test   al,al
     e11:	75 08                	jne    e1b <mm_protect+0xa5>
						e32 = e;
     e13:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e16:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     e19:	eb 06                	jmp    e21 <mm_protect+0xab>
				else
						e64 = e;
     e1b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e1e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		
				/* set/unset or override */
				if (flags & MMGR_MAP_PURGE_ACC)
     e21:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     e24:	25 00 04 00 00       	and    eax,0x400
     e29:	85 c0                	test   eax,eax
     e2b:	74 26                	je     e53 <mm_protect+0xdd>
						if (e64)
     e2d:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     e31:	74 10                	je     e43 <mm_protect+0xcd>
								e64->a = 0;
     e33:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     e36:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     e39:	83 e2 df             	and    edx,0xffffffdf
     e3c:	88 10                	mov    BYTE PTR [eax],dl
     e3e:	e9 00 06 00 00       	jmp    1443 <mm_protect+0x6cd>
						else
								e32->a = 0;
     e43:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     e46:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     e49:	83 e2 df             	and    edx,0xffffffdf
     e4c:	88 10                	mov    BYTE PTR [eax],dl
     e4e:	e9 f0 05 00 00       	jmp    1443 <mm_protect+0x6cd>
				else if (flags & MMGR_MAP_PURGE_DIRTY)
     e53:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     e56:	25 00 08 00 00       	and    eax,0x800
     e5b:	85 c0                	test   eax,eax
     e5d:	74 26                	je     e85 <mm_protect+0x10f>
						if (e64)
     e5f:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     e63:	74 10                	je     e75 <mm_protect+0xff>
								e64->d = 0;
     e65:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     e68:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     e6b:	83 e2 bf             	and    edx,0xffffffbf
     e6e:	88 10                	mov    BYTE PTR [eax],dl
     e70:	e9 ce 05 00 00       	jmp    1443 <mm_protect+0x6cd>
						else
								e32->d = 0;
     e75:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     e78:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     e7b:	83 e2 bf             	and    edx,0xffffffbf
     e7e:	88 10                	mov    BYTE PTR [eax],dl
     e80:	e9 be 05 00 00       	jmp    1443 <mm_protect+0x6cd>
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
     e85:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     e88:	25 00 10 00 00       	and    eax,0x1000
     e8d:	85 c0                	test   eax,eax
     e8f:	75 10                	jne    ea1 <mm_protect+0x12b>
     e91:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     e94:	25 00 20 00 00       	and    eax,0x2000
     e99:	85 c0                	test   eax,eax
     e9b:	0f 84 03 03 00 00    	je     11a4 <mm_protect+0x42e>
						char v = !!(flags & MMGR_MAP_SET); /* 1 or 0 */
     ea1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     ea4:	25 00 10 00 00       	and    eax,0x1000
     ea9:	85 c0                	test   eax,eax
     eab:	0f 95 c0             	setne  al
     eae:	88 45 eb             	mov    BYTE PTR [ebp-0x15],al
						if (e64) {
     eb1:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     eb5:	0f 84 bb 01 00 00    	je     1076 <mm_protect+0x300>
								if (flags & MMGR_MAP_WRITE)
     ebb:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     ebe:	83 e0 04             	and    eax,0x4
     ec1:	85 c0                	test   eax,eax
     ec3:	74 1c                	je     ee1 <mm_protect+0x16b>
										e64->w = v;
     ec5:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
     ec9:	83 e0 01             	and    eax,0x1
     ecc:	89 c2                	mov    edx,eax
     ece:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ed1:	83 e2 01             	and    edx,0x1
     ed4:	8d 0c 12             	lea    ecx,[edx+edx*1]
     ed7:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     eda:	83 e2 fd             	and    edx,0xfffffffd
     edd:	09 ca                	or     edx,ecx
     edf:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_WRITE_THROUGH)
     ee1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     ee4:	83 e0 10             	and    eax,0x10
     ee7:	85 c0                	test   eax,eax
     ee9:	74 20                	je     f0b <mm_protect+0x195>
										e64->wt = v;
     eeb:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
     eef:	83 e0 01             	and    eax,0x1
     ef2:	89 c2                	mov    edx,eax
     ef4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     ef7:	83 e2 01             	and    edx,0x1
     efa:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
     f01:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     f04:	83 e2 f7             	and    edx,0xfffffff7
     f07:	09 ca                	or     edx,ecx
     f09:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_NO_CACHING)
     f0b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f0e:	83 e0 20             	and    eax,0x20
     f11:	85 c0                	test   eax,eax
     f13:	74 1e                	je     f33 <mm_protect+0x1bd>
										e64->cd = v;
     f15:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
     f19:	83 e0 01             	and    eax,0x1
     f1c:	89 c2                	mov    edx,eax
     f1e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     f21:	83 e2 01             	and    edx,0x1
     f24:	89 d1                	mov    ecx,edx
     f26:	c1 e1 04             	shl    ecx,0x4
     f29:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     f2c:	83 e2 ef             	and    edx,0xffffffef
     f2f:	09 ca                	or     edx,ecx
     f31:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_PAT)
     f33:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f36:	25 80 00 00 00       	and    eax,0x80
     f3b:	85 c0                	test   eax,eax
     f3d:	0f 84 b4 00 00 00    	je     ff7 <mm_protect+0x281>
										if (lv > 0)
     f43:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     f46:	85 c0                	test   eax,eax
     f48:	0f 8e 8e 00 00 00    	jle    fdc <mm_protect+0x266>
												e64->addr = (e64->addr & ~1) | v;
     f4e:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     f51:	8b 19                	mov    ebx,DWORD PTR [ecx]
     f53:	89 de                	mov    esi,ebx
     f55:	c1 ee 0c             	shr    esi,0xc
     f58:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
     f5c:	81 e3 ff 0f 00 00    	and    ebx,0xfff
     f62:	c1 e3 14             	shl    ebx,0x14
     f65:	09 f3                	or     ebx,esi
     f67:	89 d8                	mov    eax,ebx
     f69:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
     f6c:	c1 e9 0c             	shr    ecx,0xc
     f6f:	0f b6 d1             	movzx  edx,cl
     f72:	83 e0 fe             	and    eax,0xfffffffe
     f75:	81 e2 ff 00 00 00    	and    edx,0xff
     f7b:	89 c1                	mov    ecx,eax
     f7d:	89 d3                	mov    ebx,edx
     f7f:	0f be 45 eb          	movsx  eax,BYTE PTR [ebp-0x15]
     f83:	99                   	cdq
     f84:	81 e2 ff 00 00 00    	and    edx,0xff
     f8a:	09 c8                	or     eax,ecx
     f8c:	09 da                	or     edx,ebx
     f8e:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     f91:	89 c3                	mov    ebx,eax
     f93:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
     f99:	89 de                	mov    esi,ebx
     f9b:	c1 e6 0c             	shl    esi,0xc
     f9e:	8b 19                	mov    ebx,DWORD PTR [ecx]
     fa0:	81 e3 ff 0f 00 00    	and    ebx,0xfff
     fa6:	09 f3                	or     ebx,esi
     fa8:	89 19                	mov    DWORD PTR [ecx],ebx
     faa:	89 c3                	mov    ebx,eax
     fac:	c1 eb 14             	shr    ebx,0x14
     faf:	89 de                	mov    esi,ebx
     fb1:	66 81 e6 ff 0f       	and    si,0xfff
     fb6:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
     fba:	66 81 e3 00 f0       	and    bx,0xf000
     fbf:	09 f3                	or     ebx,esi
     fc1:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
     fc5:	0f b6 c2             	movzx  eax,dl
     fc8:	c1 e0 0c             	shl    eax,0xc
     fcb:	89 c2                	mov    edx,eax
     fcd:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
     fd0:	25 ff 0f f0 ff       	and    eax,0xfff00fff
     fd5:	09 d0                	or     eax,edx
     fd7:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
     fda:	eb 1b                	jmp    ff7 <mm_protect+0x281>
										else
												e64->s = v;
     fdc:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
     fe0:	83 e0 01             	and    eax,0x1
     fe3:	89 c2                	mov    edx,eax
     fe5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     fe8:	89 d1                	mov    ecx,edx
     fea:	c1 e1 07             	shl    ecx,0x7
     fed:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     ff0:	83 e2 7f             	and    edx,0x7f
     ff3:	09 ca                	or     edx,ecx
     ff5:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_GLOBAL)
     ff7:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     ffa:	83 e0 40             	and    eax,0x40
     ffd:	85 c0                	test   eax,eax
     fff:	74 1d                	je     101e <mm_protect+0x2a8>
										e64->g = v;
    1001:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    1005:	83 e0 01             	and    eax,0x1
    1008:	89 c2                	mov    edx,eax
    100a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    100d:	89 d1                	mov    ecx,edx
    100f:	83 e1 01             	and    ecx,0x1
    1012:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    1016:	83 e2 fe             	and    edx,0xfffffffe
    1019:	09 ca                	or     edx,ecx
    101b:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								if (flags & MMGR_MAP_KERNEL)
    101e:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1021:	83 e0 08             	and    eax,0x8
    1024:	85 c0                	test   eax,eax
    1026:	74 1e                	je     1046 <mm_protect+0x2d0>
										e64->u = !v;
    1028:	80 7d eb 00          	cmp    BYTE PTR [ebp-0x15],0x0
    102c:	0f 94 c2             	sete   dl
    102f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1032:	83 e2 01             	and    edx,0x1
    1035:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    103c:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    103f:	83 e2 fb             	and    edx,0xfffffffb
    1042:	09 ca                	or     edx,ecx
    1044:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_EXECUTE)
    1046:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1049:	83 e0 02             	and    eax,0x2
    104c:	85 c0                	test   eax,eax
    104e:	0f 84 ee 03 00 00    	je     1442 <mm_protect+0x6cc>
										e64->xd = v;
    1054:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    1058:	83 e0 01             	and    eax,0x1
    105b:	89 c2                	mov    edx,eax
    105d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1060:	89 d1                	mov    ecx,edx
    1062:	c1 e1 07             	shl    ecx,0x7
    1065:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    1069:	83 e2 7f             	and    edx,0x7f
    106c:	09 ca                	or     edx,ecx
    106e:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    1071:	e9 cc 03 00 00       	jmp    1442 <mm_protect+0x6cc>
						} else {
								if (flags & MMGR_MAP_WRITE)
    1076:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1079:	83 e0 04             	and    eax,0x4
    107c:	85 c0                	test   eax,eax
    107e:	74 1c                	je     109c <mm_protect+0x326>
										e32->w = v;
    1080:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    1084:	83 e0 01             	and    eax,0x1
    1087:	89 c2                	mov    edx,eax
    1089:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    108c:	83 e2 01             	and    edx,0x1
    108f:	8d 0c 12             	lea    ecx,[edx+edx*1]
    1092:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1095:	83 e2 fd             	and    edx,0xfffffffd
    1098:	09 ca                	or     edx,ecx
    109a:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_WRITE_THROUGH)
    109c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    109f:	83 e0 10             	and    eax,0x10
    10a2:	85 c0                	test   eax,eax
    10a4:	74 20                	je     10c6 <mm_protect+0x350>
										e32->wt = v;
    10a6:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    10aa:	83 e0 01             	and    eax,0x1
    10ad:	89 c2                	mov    edx,eax
    10af:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10b2:	83 e2 01             	and    edx,0x1
    10b5:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    10bc:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    10bf:	83 e2 f7             	and    edx,0xfffffff7
    10c2:	09 ca                	or     edx,ecx
    10c4:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_NO_CACHING)
    10c6:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    10c9:	83 e0 20             	and    eax,0x20
    10cc:	85 c0                	test   eax,eax
    10ce:	74 1e                	je     10ee <mm_protect+0x378>
										e32->cd = v;
    10d0:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    10d4:	83 e0 01             	and    eax,0x1
    10d7:	89 c2                	mov    edx,eax
    10d9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10dc:	83 e2 01             	and    edx,0x1
    10df:	89 d1                	mov    ecx,edx
    10e1:	c1 e1 04             	shl    ecx,0x4
    10e4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    10e7:	83 e2 ef             	and    edx,0xffffffef
    10ea:	09 ca                	or     edx,ecx
    10ec:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_PAT)
    10ee:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    10f1:	25 80 00 00 00       	and    eax,0x80
    10f6:	85 c0                	test   eax,eax
    10f8:	74 52                	je     114c <mm_protect+0x3d6>
										if (lv > 0)
    10fa:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    10fd:	85 c0                	test   eax,eax
    10ff:	7e 30                	jle    1131 <mm_protect+0x3bb>
												e32->addr = (e32->addr & ~1) | v;
    1101:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1104:	8b 00                	mov    eax,DWORD PTR [eax]
    1106:	c1 e8 0c             	shr    eax,0xc
    1109:	83 e0 fe             	and    eax,0xfffffffe
    110c:	89 c2                	mov    edx,eax
    110e:	0f be 45 eb          	movsx  eax,BYTE PTR [ebp-0x15]
    1112:	09 d0                	or     eax,edx
    1114:	25 ff ff 0f 00       	and    eax,0xfffff
    1119:	89 c2                	mov    edx,eax
    111b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    111e:	89 d1                	mov    ecx,edx
    1120:	c1 e1 0c             	shl    ecx,0xc
    1123:	8b 10                	mov    edx,DWORD PTR [eax]
    1125:	81 e2 ff 0f 00 00    	and    edx,0xfff
    112b:	09 ca                	or     edx,ecx
    112d:	89 10                	mov    DWORD PTR [eax],edx
    112f:	eb 1b                	jmp    114c <mm_protect+0x3d6>
										else
												e32->s = v;
    1131:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    1135:	83 e0 01             	and    eax,0x1
    1138:	89 c2                	mov    edx,eax
    113a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    113d:	89 d1                	mov    ecx,edx
    113f:	c1 e1 07             	shl    ecx,0x7
    1142:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1145:	83 e2 7f             	and    edx,0x7f
    1148:	09 ca                	or     edx,ecx
    114a:	88 10                	mov    BYTE PTR [eax],dl
								if (flags & MMGR_MAP_GLOBAL)
    114c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    114f:	83 e0 40             	and    eax,0x40
    1152:	85 c0                	test   eax,eax
    1154:	74 1d                	je     1173 <mm_protect+0x3fd>
										e32->g = v;
    1156:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    115a:	83 e0 01             	and    eax,0x1
    115d:	89 c2                	mov    edx,eax
    115f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1162:	89 d1                	mov    ecx,edx
    1164:	83 e1 01             	and    ecx,0x1
    1167:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    116b:	83 e2 fe             	and    edx,0xfffffffe
    116e:	09 ca                	or     edx,ecx
    1170:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								if (flags & MMGR_MAP_KERNEL)
    1173:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1176:	83 e0 08             	and    eax,0x8
    1179:	85 c0                	test   eax,eax
    117b:	0f 84 c1 02 00 00    	je     1442 <mm_protect+0x6cc>
										e32->u = !v;
    1181:	80 7d eb 00          	cmp    BYTE PTR [ebp-0x15],0x0
    1185:	0f 94 c2             	sete   dl
    1188:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    118b:	83 e2 01             	and    edx,0x1
    118e:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    1195:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1198:	83 e2 fb             	and    edx,0xfffffffb
    119b:	09 ca                	or     edx,ecx
    119d:	88 10                	mov    BYTE PTR [eax],dl
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    119f:	e9 9e 02 00 00       	jmp    1442 <mm_protect+0x6cc>
								//if (flags & MMGR_MAP_EXECUTE)
								//		e32->xd = v;
						}
				} else {
						if (e64) {
    11a4:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    11a8:	0f 84 8f 01 00 00    	je     133d <mm_protect+0x5c7>
								e64->w = !!(flags & MMGR_MAP_WRITE);
    11ae:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    11b1:	83 e0 04             	and    eax,0x4
    11b4:	85 c0                	test   eax,eax
    11b6:	0f 95 c2             	setne  dl
    11b9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11bc:	83 e2 01             	and    edx,0x1
    11bf:	8d 0c 12             	lea    ecx,[edx+edx*1]
    11c2:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    11c5:	83 e2 fd             	and    edx,0xfffffffd
    11c8:	09 ca                	or     edx,ecx
    11ca:	88 10                	mov    BYTE PTR [eax],dl
								e64->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
    11cc:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    11cf:	83 e0 10             	and    eax,0x10
    11d2:	85 c0                	test   eax,eax
    11d4:	0f 95 c2             	setne  dl
    11d7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11da:	83 e2 01             	and    edx,0x1
    11dd:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    11e4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    11e7:	83 e2 f7             	and    edx,0xfffffff7
    11ea:	09 ca                	or     edx,ecx
    11ec:	88 10                	mov    BYTE PTR [eax],dl
								e64->cd = !!(flags & MMGR_MAP_NO_CACHING);
    11ee:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    11f1:	83 e0 20             	and    eax,0x20
    11f4:	85 c0                	test   eax,eax
    11f6:	0f 95 c2             	setne  dl
    11f9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11fc:	83 e2 01             	and    edx,0x1
    11ff:	89 d1                	mov    ecx,edx
    1201:	c1 e1 04             	shl    ecx,0x4
    1204:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1207:	83 e2 ef             	and    edx,0xffffffef
    120a:	09 ca                	or     edx,ecx
    120c:	88 10                	mov    BYTE PTR [eax],dl
								if (lv > 0)
    120e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1211:	85 c0                	test   eax,eax
    1213:	0f 8e a0 00 00 00    	jle    12b9 <mm_protect+0x543>
										e64->addr = (e64->addr & ~1) | !!(flags & MMGR_MAP_PAT);
    1219:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    121c:	8b 19                	mov    ebx,DWORD PTR [ecx]
    121e:	89 de                	mov    esi,ebx
    1220:	c1 ee 0c             	shr    esi,0xc
    1223:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    1227:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    122d:	c1 e3 14             	shl    ebx,0x14
    1230:	09 f3                	or     ebx,esi
    1232:	89 d8                	mov    eax,ebx
    1234:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    1237:	c1 e9 0c             	shr    ecx,0xc
    123a:	0f b6 d1             	movzx  edx,cl
    123d:	83 e0 fe             	and    eax,0xfffffffe
    1240:	81 e2 ff 00 00 00    	and    edx,0xff
    1246:	89 c1                	mov    ecx,eax
    1248:	89 d3                	mov    ebx,edx
    124a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    124d:	25 80 00 00 00       	and    eax,0x80
    1252:	85 c0                	test   eax,eax
    1254:	0f 95 45 c7          	setne  BYTE PTR [ebp-0x39]
    1258:	0f b6 45 c7          	movzx  eax,BYTE PTR [ebp-0x39]
    125c:	ba 00 00 00 00       	mov    edx,0x0
    1261:	81 e2 ff 00 00 00    	and    edx,0xff
    1267:	09 c8                	or     eax,ecx
    1269:	09 da                	or     edx,ebx
    126b:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    126e:	89 c3                	mov    ebx,eax
    1270:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    1276:	89 de                	mov    esi,ebx
    1278:	c1 e6 0c             	shl    esi,0xc
    127b:	8b 19                	mov    ebx,DWORD PTR [ecx]
    127d:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    1283:	09 f3                	or     ebx,esi
    1285:	89 19                	mov    DWORD PTR [ecx],ebx
    1287:	89 c3                	mov    ebx,eax
    1289:	c1 eb 14             	shr    ebx,0x14
    128c:	89 de                	mov    esi,ebx
    128e:	66 81 e6 ff 0f       	and    si,0xfff
    1293:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    1297:	66 81 e3 00 f0       	and    bx,0xf000
    129c:	09 f3                	or     ebx,esi
    129e:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    12a2:	0f b6 c2             	movzx  eax,dl
    12a5:	c1 e0 0c             	shl    eax,0xc
    12a8:	89 c2                	mov    edx,eax
    12aa:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    12ad:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    12b2:	09 d0                	or     eax,edx
    12b4:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
    12b7:	eb 1f                	jmp    12d8 <mm_protect+0x562>
								else
										e64->s = !!(flags & MMGR_MAP_PAT);
    12b9:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    12bc:	25 80 00 00 00       	and    eax,0x80
    12c1:	85 c0                	test   eax,eax
    12c3:	0f 95 c2             	setne  dl
    12c6:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    12c9:	89 d1                	mov    ecx,edx
    12cb:	c1 e1 07             	shl    ecx,0x7
    12ce:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    12d1:	83 e2 7f             	and    edx,0x7f
    12d4:	09 ca                	or     edx,ecx
    12d6:	88 10                	mov    BYTE PTR [eax],dl
								e64->g = !!(flags & MMGR_MAP_GLOBAL);
    12d8:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    12db:	83 e0 40             	and    eax,0x40
    12de:	85 c0                	test   eax,eax
    12e0:	0f 95 c2             	setne  dl
    12e3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    12e6:	89 d1                	mov    ecx,edx
    12e8:	83 e1 01             	and    ecx,0x1
    12eb:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    12ef:	83 e2 fe             	and    edx,0xfffffffe
    12f2:	09 ca                	or     edx,ecx
    12f4:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								e64->u = !(flags & MMGR_MAP_KERNEL);
    12f7:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    12fa:	83 e0 08             	and    eax,0x8
    12fd:	85 c0                	test   eax,eax
    12ff:	0f 94 c2             	sete   dl
    1302:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1305:	83 e2 01             	and    edx,0x1
    1308:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    130f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1312:	83 e2 fb             	and    edx,0xfffffffb
    1315:	09 ca                	or     edx,ecx
    1317:	88 10                	mov    BYTE PTR [eax],dl
								e64->xd = !!(flags & MMGR_MAP_EXECUTE);
    1319:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    131c:	83 e0 02             	and    eax,0x2
    131f:	85 c0                	test   eax,eax
    1321:	0f 95 c2             	setne  dl
    1324:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1327:	89 d1                	mov    ecx,edx
    1329:	c1 e1 07             	shl    ecx,0x7
    132c:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    1330:	83 e2 7f             	and    edx,0x7f
    1333:	09 ca                	or     edx,ecx
    1335:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
    1338:	e9 06 01 00 00       	jmp    1443 <mm_protect+0x6cd>
						} else {
								e32->w = !!(flags & MMGR_MAP_WRITE);
    133d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1340:	83 e0 04             	and    eax,0x4
    1343:	85 c0                	test   eax,eax
    1345:	0f 95 c2             	setne  dl
    1348:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    134b:	83 e2 01             	and    edx,0x1
    134e:	8d 0c 12             	lea    ecx,[edx+edx*1]
    1351:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1354:	83 e2 fd             	and    edx,0xfffffffd
    1357:	09 ca                	or     edx,ecx
    1359:	88 10                	mov    BYTE PTR [eax],dl
								e32->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
    135b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    135e:	83 e0 10             	and    eax,0x10
    1361:	85 c0                	test   eax,eax
    1363:	0f 95 c2             	setne  dl
    1366:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1369:	83 e2 01             	and    edx,0x1
    136c:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    1373:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1376:	83 e2 f7             	and    edx,0xfffffff7
    1379:	09 ca                	or     edx,ecx
    137b:	88 10                	mov    BYTE PTR [eax],dl
								e32->cd = !!(flags & MMGR_MAP_NO_CACHING);
    137d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1380:	83 e0 20             	and    eax,0x20
    1383:	85 c0                	test   eax,eax
    1385:	0f 95 c2             	setne  dl
    1388:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    138b:	83 e2 01             	and    edx,0x1
    138e:	89 d1                	mov    ecx,edx
    1390:	c1 e1 04             	shl    ecx,0x4
    1393:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1396:	83 e2 ef             	and    edx,0xffffffef
    1399:	09 ca                	or     edx,ecx
    139b:	88 10                	mov    BYTE PTR [eax],dl
								if (lv > 0)
    139d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    13a0:	85 c0                	test   eax,eax
    13a2:	7e 3c                	jle    13e0 <mm_protect+0x66a>
										e32->addr = (e32->addr & ~1) | !!(flags & MMGR_MAP_PAT);
    13a4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    13a7:	8b 00                	mov    eax,DWORD PTR [eax]
    13a9:	c1 e8 0c             	shr    eax,0xc
    13ac:	83 e0 fe             	and    eax,0xfffffffe
    13af:	89 c2                	mov    edx,eax
    13b1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    13b4:	25 80 00 00 00       	and    eax,0x80
    13b9:	85 c0                	test   eax,eax
    13bb:	0f 95 c0             	setne  al
    13be:	0f b6 c0             	movzx  eax,al
    13c1:	09 d0                	or     eax,edx
    13c3:	25 ff ff 0f 00       	and    eax,0xfffff
    13c8:	89 c2                	mov    edx,eax
    13ca:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    13cd:	89 d1                	mov    ecx,edx
    13cf:	c1 e1 0c             	shl    ecx,0xc
    13d2:	8b 10                	mov    edx,DWORD PTR [eax]
    13d4:	81 e2 ff 0f 00 00    	and    edx,0xfff
    13da:	09 ca                	or     edx,ecx
    13dc:	89 10                	mov    DWORD PTR [eax],edx
    13de:	eb 1f                	jmp    13ff <mm_protect+0x689>
								else
										e32->s = !!(flags & MMGR_MAP_PAT);
    13e0:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    13e3:	25 80 00 00 00       	and    eax,0x80
    13e8:	85 c0                	test   eax,eax
    13ea:	0f 95 c2             	setne  dl
    13ed:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    13f0:	89 d1                	mov    ecx,edx
    13f2:	c1 e1 07             	shl    ecx,0x7
    13f5:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    13f8:	83 e2 7f             	and    edx,0x7f
    13fb:	09 ca                	or     edx,ecx
    13fd:	88 10                	mov    BYTE PTR [eax],dl
								e32->g = !!(flags & MMGR_MAP_GLOBAL);
    13ff:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1402:	83 e0 40             	and    eax,0x40
    1405:	85 c0                	test   eax,eax
    1407:	0f 95 c2             	setne  dl
    140a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    140d:	89 d1                	mov    ecx,edx
    140f:	83 e1 01             	and    ecx,0x1
    1412:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    1416:	83 e2 fe             	and    edx,0xfffffffe
    1419:	09 ca                	or     edx,ecx
    141b:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								e32->u = !(flags & MMGR_MAP_KERNEL);
    141e:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1421:	83 e0 08             	and    eax,0x8
    1424:	85 c0                	test   eax,eax
    1426:	0f 94 c2             	sete   dl
    1429:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    142c:	83 e2 01             	and    edx,0x1
    142f:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    1436:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1439:	83 e2 fb             	and    edx,0xfffffffb
    143c:	09 ca                	or     edx,ecx
    143e:	88 10                	mov    BYTE PTR [eax],dl
    1440:	eb 01                	jmp    1443 <mm_protect+0x6cd>
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    1442:	90                   	nop
								//e32->xd = !!(flags & MMGR_MAP_EXECUTE);
						}
				}

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
    1443:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1446:	e8 c9 eb ff ff       	call   14 <flush_tlb_single>
    144b:	83 c4 04             	add    esp,0x4
		
				/* advance */
				if (!lv) /* regular page */
    144e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1451:	85 c0                	test   eax,eax
    1453:	75 09                	jne    145e <mm_protect+0x6e8>
						virt_address += 4096;
    1455:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
    145c:	eb 63                	jmp    14c1 <mm_protect+0x74b>
				else if (lv == 1) /* large page 2M/4M */
    145e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1461:	83 f8 01             	cmp    eax,0x1
    1464:	75 1f                	jne    1485 <mm_protect+0x70f>
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
    1466:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    146d:	83 e0 40             	and    eax,0x40
    1470:	84 c0                	test   al,al
    1472:	74 07                	je     147b <mm_protect+0x705>
    1474:	b8 00 00 80 00       	mov    eax,0x800000
    1479:	eb 05                	jmp    1480 <mm_protect+0x70a>
    147b:	b8 00 00 00 01       	mov    eax,0x1000000
    1480:	01 45 0c             	add    DWORD PTR [ebp+0xc],eax
    1483:	eb 3c                	jmp    14c1 <mm_protect+0x74b>
				else if (lv == 2) /* huge page 1G */
    1485:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1488:	83 f8 02             	cmp    eax,0x2
    148b:	75 09                	jne    1496 <mm_protect+0x720>
						virt_address += 1024 * 1024 * 1024;
    148d:	81 45 0c 00 00 00 40 	add    DWORD PTR [ebp+0xc],0x40000000
    1494:	eb 2b                	jmp    14c1 <mm_protect+0x74b>
				else
						die("ginormous page?\n");
    1496:	83 ec 08             	sub    esp,0x8
    1499:	68 90 00 00 00       	push   0x90
    149e:	6a 0c                	push   0xc
    14a0:	e8 fc ff ff ff       	call   14a1 <mm_protect+0x72b>
    14a5:	83 c4 10             	add    esp,0x10
    14a8:	e8 fc ff ff ff       	call   14a9 <mm_protect+0x733>
    14ad:	83 ec 0c             	sub    esp,0xc
    14b0:	68 00 00 00 00       	push   0x0
    14b5:	e8 fc ff ff ff       	call   14b6 <mm_protect+0x740>
    14ba:	83 c4 10             	add    esp,0x10
    14bd:	fa                   	cli
    14be:	f4                   	hlt
    14bf:	eb fd                	jmp    14be <mm_protect+0x748>
		while (num_pages--) {
    14c1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    14c4:	8d 50 ff             	lea    edx,[eax-0x1]
    14c7:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    14ca:	85 c0                	test   eax,eax
    14cc:	0f 85 b1 f8 ff ff    	jne    d83 <mm_protect+0xd>
    14d2:	eb 01                	jmp    14d5 <mm_protect+0x75f>
						return;
    14d4:	90                   	nop
		}
}
    14d5:	8d 65 f8             	lea    esp,[ebp-0x8]
    14d8:	5b                   	pop    ebx
    14d9:	5e                   	pop    esi
    14da:	5d                   	pop    ebp
    14db:	c3                   	ret

000014dc <mm_reserve_vmem>:

void* mm_reserve_vmem(struct mm* mm, size_t pg_ct, int flags)
{
    14dc:	55                   	push   ebp
    14dd:	89 e5                	mov    ebp,esp
    14df:	83 ec 18             	sub    esp,0x18
		void* rv = __sync_fetch_and_add(&mm->qnd_ptr, pg_ct * 4096);
    14e2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    14e5:	c1 e0 0c             	shl    eax,0xc
    14e8:	89 c2                	mov    edx,eax
    14ea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14ed:	83 c0 0c             	add    eax,0xc
    14f0:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    14f4:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		printf("mm reserved at %x\n", rv);
    14f7:	83 ec 08             	sub    esp,0x8
    14fa:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    14fd:	68 a1 00 00 00       	push   0xa1
    1502:	e8 fc ff ff ff       	call   1503 <mm_reserve_vmem+0x27>
    1507:	83 c4 10             	add    esp,0x10
		if (rv + pg_ct * 4096 > VM_QND_LIMIT)
    150a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    150d:	c1 e0 0c             	shl    eax,0xc
    1510:	89 c2                	mov    edx,eax
    1512:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1515:	01 d0                	add    eax,edx
    1517:	3d 00 00 00 a0       	cmp    eax,0xa0000000
    151c:	76 2b                	jbe    1549 <mm_reserve_vmem+0x6d>
				die("Out of QnD VM reservation ranges. Impelment a map!\n");
    151e:	83 ec 08             	sub    esp,0x8
    1521:	68 b4 00 00 00       	push   0xb4
    1526:	6a 0c                	push   0xc
    1528:	e8 fc ff ff ff       	call   1529 <mm_reserve_vmem+0x4d>
    152d:	83 c4 10             	add    esp,0x10
    1530:	e8 fc ff ff ff       	call   1531 <mm_reserve_vmem+0x55>
    1535:	83 ec 0c             	sub    esp,0xc
    1538:	68 00 00 00 00       	push   0x0
    153d:	e8 fc ff ff ff       	call   153e <mm_reserve_vmem+0x62>
    1542:	83 c4 10             	add    esp,0x10
    1545:	fa                   	cli
    1546:	f4                   	hlt
    1547:	eb fd                	jmp    1546 <mm_reserve_vmem+0x6a>
		return rv;
    1549:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    154c:	c9                   	leave
    154d:	c3                   	ret

0000154e <mm_aoa_range>:

void mm_aoa_range(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
    154e:	55                   	push   ebp
    154f:	89 e5                	mov    ebp,esp
    1551:	56                   	push   esi
    1552:	53                   	push   ebx
    1553:	83 ec 60             	sub    esp,0x60
		int x = flags & MMGR_MAP_EXECUTE, w = flags & MMGR_MAP_WRITE,
    1556:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1559:	83 e0 02             	and    eax,0x2
    155c:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    155f:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1562:	83 e0 04             	and    eax,0x4
    1565:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
			wc = flags & MMGR_MAP_PAT, wt = flags & MMGR_MAP_WRITE_THROUGH,
    1568:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    156b:	25 80 00 00 00       	and    eax,0x80
    1570:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1573:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1576:	83 e0 10             	and    eax,0x10
    1579:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
			cd = flags & MMGR_MAP_NO_CACHING, g = flags & MMGR_MAP_GLOBAL,
    157c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    157f:	83 e0 20             	and    eax,0x20
    1582:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1585:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1588:	83 e0 40             	and    eax,0x40
    158b:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
			u = !(flags & MMGR_MAP_KERNEL);
    158e:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1591:	83 e0 08             	and    eax,0x8
    1594:	85 c0                	test   eax,eax
    1596:	0f 94 c0             	sete   al
    1599:	0f b6 c0             	movzx  eax,al
    159c:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		int avl = MMGR_AVL_AOA, lvl; uint32_t ofs;
    159f:	c7 45 d0 04 00 00 00 	mov    DWORD PTR [ebp-0x30],0x4
		void *p, *e, **cntr, **cntrm; /* page walk: cntr (last one), cntrm (missing)*/

		while (pg_ct) {
    15a6:	e9 63 05 00 00       	jmp    1b0e <mm_aoa_range+0x5c0>
redo:
				if (!mm_page_walk(mm, virt_address, &p, &e, &lvl,
    15ab:	8d 45 ac             	lea    eax,[ebp-0x54]
    15ae:	50                   	push   eax
    15af:	8d 45 b0             	lea    eax,[ebp-0x50]
    15b2:	50                   	push   eax
    15b3:	8d 45 bc             	lea    eax,[ebp-0x44]
    15b6:	50                   	push   eax
    15b7:	8d 45 c0             	lea    eax,[ebp-0x40]
    15ba:	50                   	push   eax
    15bb:	8d 45 b4             	lea    eax,[ebp-0x4c]
    15be:	50                   	push   eax
    15bf:	8d 45 b8             	lea    eax,[ebp-0x48]
    15c2:	50                   	push   eax
    15c3:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    15c6:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    15c9:	e8 fc ff ff ff       	call   15ca <mm_aoa_range+0x7c>
    15ce:	83 c4 20             	add    esp,0x20
    15d1:	85 c0                	test   eax,eax
    15d3:	75 32                	jne    1607 <mm_aoa_range+0xb9>
										&ofs, &cntr, &cntrm)) {
						/* present entry! */
present:
    15d5:	90                   	nop
    15d6:	eb 04                	jmp    15dc <mm_aoa_range+0x8e>
				if (!cpu.has_pae) {
						struct pte32* pte = e;
						while (ofs < 1024) {
								/* check for present */
								if (pte->p)
										goto present;
    15d8:	90                   	nop
    15d9:	eb 01                	jmp    15dc <mm_aoa_range+0x8e>
				} else {
						struct pte64* pte = e;
						while (ofs < 512) {
								/* check for present */
								if (pte->p)
										goto present;
    15db:	90                   	nop
						die("encountered present entry while AOA alloc\n");
    15dc:	83 ec 08             	sub    esp,0x8
    15df:	68 e8 00 00 00       	push   0xe8
    15e4:	6a 0c                	push   0xc
    15e6:	e8 fc ff ff ff       	call   15e7 <mm_aoa_range+0x99>
    15eb:	83 c4 10             	add    esp,0x10
    15ee:	e8 fc ff ff ff       	call   15ef <mm_aoa_range+0xa1>
    15f3:	83 ec 0c             	sub    esp,0xc
    15f6:	68 00 00 00 00       	push   0x0
    15fb:	e8 fc ff ff ff       	call   15fc <mm_aoa_range+0xae>
    1600:	83 c4 10             	add    esp,0x10
    1603:	fa                   	cli
    1604:	f4                   	hlt
    1605:	eb fd                	jmp    1604 <mm_aoa_range+0xb6>
				if (lvl > 0) {
    1607:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    160a:	85 c0                	test   eax,eax
    160c:	0f 8e 18 02 00 00    	jle    182a <mm_aoa_range+0x2dc>
						if (lvl == 1) {
    1612:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1615:	83 f8 01             	cmp    eax,0x1
    1618:	0f 85 a8 01 00 00    	jne    17c6 <mm_aoa_range+0x278>
								if (ENTER_CS_PTE(cntr[ofs])) {
    161e:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    1621:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1624:	c1 e2 02             	shl    edx,0x2
    1627:	01 c2                	add    edx,eax
    1629:	b8 00 00 00 00       	mov    eax,0x0
    162e:	b9 ff ff ff ff       	mov    ecx,0xffffffff
    1633:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    1637:	0f 94 c0             	sete   al
    163a:	84 c0                	test   al,al
    163c:	0f 84 6d 01 00 00    	je     17af <mm_aoa_range+0x261>
										ptr = mm_alloc_page(&b);
    1642:	83 ec 0c             	sub    esp,0xc
    1645:	8d 45 a0             	lea    eax,[ebp-0x60]
    1648:	50                   	push   eax
    1649:	e8 fc ff ff ff       	call   164a <mm_aoa_range+0xfc>
    164e:	83 c4 10             	add    esp,0x10
    1651:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
										if (cpu.has_pae) {
    1654:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    165b:	83 e0 40             	and    eax,0x40
    165e:	84 c0                	test   al,al
    1660:	0f 84 b8 00 00 00    	je     171e <mm_aoa_range+0x1d0>
												struct pte64* pd = e;
    1666:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1669:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
												pd[ofs].addr = b / 4096;
    166c:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    166f:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    1672:	0f ac d0 0c          	shrd   eax,edx,0xc
    1676:	c1 ea 0c             	shr    edx,0xc
    1679:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    167c:	8d 1c cd 00 00 00 00 	lea    ebx,[ecx*8+0x0]
    1683:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    1686:	01 d9                	add    ecx,ebx
    1688:	81 e2 ff 00 00 00    	and    edx,0xff
    168e:	89 c3                	mov    ebx,eax
    1690:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    1696:	89 de                	mov    esi,ebx
    1698:	c1 e6 0c             	shl    esi,0xc
    169b:	8b 19                	mov    ebx,DWORD PTR [ecx]
    169d:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    16a3:	09 f3                	or     ebx,esi
    16a5:	89 19                	mov    DWORD PTR [ecx],ebx
    16a7:	89 c3                	mov    ebx,eax
    16a9:	c1 eb 14             	shr    ebx,0x14
    16ac:	89 de                	mov    esi,ebx
    16ae:	66 81 e6 ff 0f       	and    si,0xfff
    16b3:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    16b7:	66 81 e3 00 f0       	and    bx,0xf000
    16bc:	09 f3                	or     ebx,esi
    16be:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    16c2:	0f b6 c2             	movzx  eax,dl
    16c5:	c1 e0 0c             	shl    eax,0xc
    16c8:	89 c2                	mov    edx,eax
    16ca:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    16cd:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    16d2:	09 d0                	or     eax,edx
    16d4:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
												pd[ofs].u = 1;
    16d7:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    16da:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    16e1:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16e4:	01 d0                	add    eax,edx
    16e6:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    16e9:	83 ca 04             	or     edx,0x4
    16ec:	88 10                	mov    BYTE PTR [eax],dl
												pd[ofs].w = 1;
    16ee:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    16f1:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    16f8:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    16fb:	01 d0                	add    eax,edx
    16fd:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1700:	83 ca 02             	or     edx,0x2
    1703:	88 10                	mov    BYTE PTR [eax],dl
												pd[ofs].p = 1;
    1705:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1708:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    170f:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1712:	01 d0                	add    eax,edx
    1714:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1717:	83 ca 01             	or     edx,0x1
    171a:	88 10                	mov    BYTE PTR [eax],dl
    171c:	eb 7c                	jmp    179a <mm_aoa_range+0x24c>
												struct pte32* pd = e;
    171e:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1721:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
												pd[ofs].addr = (uint32_t)(b / 4096);
    1724:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    1727:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    172a:	0f ac d0 0c          	shrd   eax,edx,0xc
    172e:	c1 ea 0c             	shr    edx,0xc
    1731:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    1734:	8d 1c 8d 00 00 00 00 	lea    ebx,[ecx*4+0x0]
    173b:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    173e:	01 d9                	add    ecx,ebx
    1740:	25 ff ff 0f 00       	and    eax,0xfffff
    1745:	c1 e0 0c             	shl    eax,0xc
    1748:	89 c2                	mov    edx,eax
    174a:	8b 01                	mov    eax,DWORD PTR [ecx]
    174c:	25 ff 0f 00 00       	and    eax,0xfff
    1751:	09 d0                	or     eax,edx
    1753:	89 01                	mov    DWORD PTR [ecx],eax
												pd[ofs].u = 1;
    1755:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1758:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    175f:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1762:	01 d0                	add    eax,edx
    1764:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1767:	83 ca 04             	or     edx,0x4
    176a:	88 10                	mov    BYTE PTR [eax],dl
												pd[ofs].w = 1;
    176c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    176f:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    1776:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1779:	01 d0                	add    eax,edx
    177b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    177e:	83 ca 02             	or     edx,0x2
    1781:	88 10                	mov    BYTE PTR [eax],dl
												pd[ofs].p = 1;
    1783:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1786:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    178d:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1790:	01 d0                	add    eax,edx
    1792:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1795:	83 ca 01             	or     edx,0x1
    1798:	88 10                	mov    BYTE PTR [eax],dl
										cntr[ofs] = ptr;
    179a:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    179d:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    17a0:	c1 e2 02             	shl    edx,0x2
    17a3:	01 c2                	add    edx,eax
    17a5:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    17a8:	89 02                	mov    DWORD PTR [edx],eax
    17aa:	e9 fc fd ff ff       	jmp    15ab <mm_aoa_range+0x5d>
										SPIN_CS(cntr[ofs]);
    17af:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    17b2:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    17b5:	c1 e2 02             	shl    edx,0x2
    17b8:	01 d0                	add    eax,edx
    17ba:	8b 00                	mov    eax,DWORD PTR [eax]
    17bc:	83 f8 ff             	cmp    eax,0xffffffff
    17bf:	74 ee                	je     17af <mm_aoa_range+0x261>
    17c1:	e9 e5 fd ff ff       	jmp    15ab <mm_aoa_range+0x5d>
								if (!cpu.has_pae) {
    17c6:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    17cd:	83 e0 40             	and    eax,0x40
    17d0:	84 c0                	test   al,al
    17d2:	75 2b                	jne    17ff <mm_aoa_range+0x2b1>
										die("PD missing\n");
    17d4:	83 ec 08             	sub    esp,0x8
    17d7:	68 13 01 00 00       	push   0x113
    17dc:	6a 0c                	push   0xc
    17de:	e8 fc ff ff ff       	call   17df <mm_aoa_range+0x291>
    17e3:	83 c4 10             	add    esp,0x10
    17e6:	e8 fc ff ff ff       	call   17e7 <mm_aoa_range+0x299>
    17eb:	83 ec 0c             	sub    esp,0xc
    17ee:	68 00 00 00 00       	push   0x0
    17f3:	e8 fc ff ff ff       	call   17f4 <mm_aoa_range+0x2a6>
    17f8:	83 c4 10             	add    esp,0x10
    17fb:	fa                   	cli
    17fc:	f4                   	hlt
    17fd:	eb fd                	jmp    17fc <mm_aoa_range+0x2ae>
								die("will not happen as 4PDs are pre-allocated.\n");
    17ff:	83 ec 08             	sub    esp,0x8
    1802:	68 20 01 00 00       	push   0x120
    1807:	6a 0c                	push   0xc
    1809:	e8 fc ff ff ff       	call   180a <mm_aoa_range+0x2bc>
    180e:	83 c4 10             	add    esp,0x10
    1811:	e8 fc ff ff ff       	call   1812 <mm_aoa_range+0x2c4>
    1816:	83 ec 0c             	sub    esp,0xc
    1819:	68 00 00 00 00       	push   0x0
    181e:	e8 fc ff ff ff       	call   181f <mm_aoa_range+0x2d1>
    1823:	83 c4 10             	add    esp,0x10
    1826:	fa                   	cli
    1827:	f4                   	hlt
    1828:	eb fd                	jmp    1827 <mm_aoa_range+0x2d9>
				if (!cpu.has_pae) {
    182a:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1831:	83 e0 40             	and    eax,0x40
    1834:	84 c0                	test   al,al
    1836:	0f 85 34 01 00 00    	jne    1970 <mm_aoa_range+0x422>
						struct pte32* pte = e;
    183c:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    183f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						while (ofs < 1024) {
    1842:	e9 16 01 00 00       	jmp    195d <mm_aoa_range+0x40f>
								if (pte->p)
    1847:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    184a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    184d:	83 e0 01             	and    eax,0x1
    1850:	84 c0                	test   al,al
    1852:	0f 85 80 fd ff ff    	jne    15d8 <mm_aoa_range+0x8a>
								pte->addr = pm_zero / 4096; /* cautonary */
    1858:	a1 00 00 00 00       	mov    eax,ds:0x0
    185d:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1863:	0f ac d0 0c          	shrd   eax,edx,0xc
    1867:	c1 ea 0c             	shr    edx,0xc
    186a:	25 ff ff 0f 00       	and    eax,0xfffff
    186f:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1872:	c1 e0 0c             	shl    eax,0xc
    1875:	89 c1                	mov    ecx,eax
    1877:	8b 02                	mov    eax,DWORD PTR [edx]
    1879:	25 ff 0f 00 00       	and    eax,0xfff
    187e:	09 c8                	or     eax,ecx
    1880:	89 02                	mov    DWORD PTR [edx],eax
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
    1882:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1885:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1888:	83 ca 04             	or     edx,0x4
    188b:	88 10                	mov    BYTE PTR [eax],dl
								pte->w = (w ? 1 : 0);
    188d:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    1891:	0f 95 c2             	setne  dl
    1894:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1897:	83 e2 01             	and    edx,0x1
    189a:	8d 0c 12             	lea    ecx,[edx+edx*1]
    189d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    18a0:	83 e2 fd             	and    edx,0xfffffffd
    18a3:	09 ca                	or     edx,ecx
    18a5:	88 10                	mov    BYTE PTR [eax],dl
								pte->p = 0; /* that's the point of allocate-on-access */
    18a7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    18aa:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    18ad:	83 e2 fe             	and    edx,0xfffffffe
    18b0:	88 10                	mov    BYTE PTR [eax],dl
								pte->s = (wc ? 1 : 0); /* PAT bit */
    18b2:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    18b6:	0f 95 c2             	setne  dl
    18b9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    18bc:	89 d1                	mov    ecx,edx
    18be:	c1 e1 07             	shl    ecx,0x7
    18c1:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    18c4:	83 e2 7f             	and    edx,0x7f
    18c7:	09 ca                	or     edx,ecx
    18c9:	88 10                	mov    BYTE PTR [eax],dl
								pte->wt = (wt ? 1 : 0);
    18cb:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    18cf:	0f 95 c2             	setne  dl
    18d2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    18d5:	83 e2 01             	and    edx,0x1
    18d8:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    18df:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    18e2:	83 e2 f7             	and    edx,0xfffffff7
    18e5:	09 ca                	or     edx,ecx
    18e7:	88 10                	mov    BYTE PTR [eax],dl
								pte->cd = (cd ? 1 : 0);
    18e9:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    18ed:	0f 95 c2             	setne  dl
    18f0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    18f3:	83 e2 01             	and    edx,0x1
    18f6:	89 d1                	mov    ecx,edx
    18f8:	c1 e1 04             	shl    ecx,0x4
    18fb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    18fe:	83 e2 ef             	and    edx,0xffffffef
    1901:	09 ca                	or     edx,ecx
    1903:	88 10                	mov    BYTE PTR [eax],dl
								pte->g = (g ? 1 : 0);
    1905:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    1909:	0f 95 c2             	setne  dl
    190c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    190f:	89 d1                	mov    ecx,edx
    1911:	83 e1 01             	and    ecx,0x1
    1914:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    1918:	83 e2 fe             	and    edx,0xfffffffe
    191b:	09 ca                	or     edx,ecx
    191d:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								pte->ign = avl & 7;
    1920:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1923:	83 e0 07             	and    eax,0x7
    1926:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1929:	83 e0 07             	and    eax,0x7
    192c:	8d 0c 00             	lea    ecx,[eax+eax*1]
    192f:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
    1933:	83 e0 f1             	and    eax,0xfffffff1
    1936:	09 c8                	or     eax,ecx
    1938:	88 42 01             	mov    BYTE PTR [edx+0x1],al
								pte++; ofs++; pg_ct--;
    193b:	83 45 f4 04          	add    DWORD PTR [ebp-0xc],0x4
    193f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1942:	83 c0 01             	add    eax,0x1
    1945:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    1948:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
								virt_address += 4096;
    194c:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
								if (!pg_ct) /* exit if done */
    1953:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1957:	0f 84 bd 01 00 00    	je     1b1a <mm_aoa_range+0x5cc>
						while (ofs < 1024) {
    195d:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1960:	3d ff 03 00 00       	cmp    eax,0x3ff
    1965:	0f 86 dc fe ff ff    	jbe    1847 <mm_aoa_range+0x2f9>
    196b:	e9 9e 01 00 00       	jmp    1b0e <mm_aoa_range+0x5c0>
						struct pte64* pte = e;
    1970:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1973:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						while (ofs < 512) {
    1976:	e9 85 01 00 00       	jmp    1b00 <mm_aoa_range+0x5b2>
								if (pte->p)
    197b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    197e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1981:	83 e0 01             	and    eax,0x1
    1984:	84 c0                	test   al,al
    1986:	0f 85 4f fc ff ff    	jne    15db <mm_aoa_range+0x8d>

								/* set the flags */
								pte->addr = pm_zero / 4096; /* cautonary */
    198c:	a1 00 00 00 00       	mov    eax,ds:0x0
    1991:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1997:	0f ac d0 0c          	shrd   eax,edx,0xc
    199b:	c1 ea 0c             	shr    edx,0xc
    199e:	81 e2 ff 00 00 00    	and    edx,0xff
    19a4:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    19a7:	89 c3                	mov    ebx,eax
    19a9:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    19af:	89 de                	mov    esi,ebx
    19b1:	c1 e6 0c             	shl    esi,0xc
    19b4:	8b 19                	mov    ebx,DWORD PTR [ecx]
    19b6:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    19bc:	09 f3                	or     ebx,esi
    19be:	89 19                	mov    DWORD PTR [ecx],ebx
    19c0:	89 c3                	mov    ebx,eax
    19c2:	c1 eb 14             	shr    ebx,0x14
    19c5:	89 de                	mov    esi,ebx
    19c7:	66 81 e6 ff 0f       	and    si,0xfff
    19cc:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    19d0:	66 81 e3 00 f0       	and    bx,0xf000
    19d5:	09 f3                	or     ebx,esi
    19d7:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    19db:	0f b6 c2             	movzx  eax,dl
    19de:	c1 e0 0c             	shl    eax,0xc
    19e1:	89 c2                	mov    edx,eax
    19e3:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    19e6:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    19eb:	09 d0                	or     eax,edx
    19ed:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
    19f0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19f3:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    19f6:	83 ca 04             	or     edx,0x4
    19f9:	88 10                	mov    BYTE PTR [eax],dl
								pte->w = (w ? 1 : 0);
    19fb:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    19ff:	0f 95 c2             	setne  dl
    1a02:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a05:	83 e2 01             	and    edx,0x1
    1a08:	8d 0c 12             	lea    ecx,[edx+edx*1]
    1a0b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1a0e:	83 e2 fd             	and    edx,0xfffffffd
    1a11:	09 ca                	or     edx,ecx
    1a13:	88 10                	mov    BYTE PTR [eax],dl
								pte->p = 0; /* that's the point of allocate-on-access */
    1a15:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a18:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1a1b:	83 e2 fe             	and    edx,0xfffffffe
    1a1e:	88 10                	mov    BYTE PTR [eax],dl
								pte->s = (wc ? 1 : 0); /* PAT bit */
    1a20:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1a24:	0f 95 c2             	setne  dl
    1a27:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a2a:	89 d1                	mov    ecx,edx
    1a2c:	c1 e1 07             	shl    ecx,0x7
    1a2f:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1a32:	83 e2 7f             	and    edx,0x7f
    1a35:	09 ca                	or     edx,ecx
    1a37:	88 10                	mov    BYTE PTR [eax],dl
								pte->wt = (wt ? 1 : 0);
    1a39:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1a3d:	0f 95 c2             	setne  dl
    1a40:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a43:	83 e2 01             	and    edx,0x1
    1a46:	8d 0c d5 00 00 00 00 	lea    ecx,[edx*8+0x0]
    1a4d:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1a50:	83 e2 f7             	and    edx,0xfffffff7
    1a53:	09 ca                	or     edx,ecx
    1a55:	88 10                	mov    BYTE PTR [eax],dl
								pte->cd = (cd ? 1 : 0);
    1a57:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    1a5b:	0f 95 c2             	setne  dl
    1a5e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a61:	83 e2 01             	and    edx,0x1
    1a64:	89 d1                	mov    ecx,edx
    1a66:	c1 e1 04             	shl    ecx,0x4
    1a69:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1a6c:	83 e2 ef             	and    edx,0xffffffef
    1a6f:	09 ca                	or     edx,ecx
    1a71:	88 10                	mov    BYTE PTR [eax],dl
								pte->g = (g ? 1 : 0);
    1a73:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    1a77:	0f 95 c2             	setne  dl
    1a7a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a7d:	89 d1                	mov    ecx,edx
    1a7f:	83 e1 01             	and    ecx,0x1
    1a82:	0f b6 50 01          	movzx  edx,BYTE PTR [eax+0x1]
    1a86:	83 e2 fe             	and    edx,0xfffffffe
    1a89:	09 ca                	or     edx,ecx
    1a8b:	88 50 01             	mov    BYTE PTR [eax+0x1],dl
								if (cpu.e_has_nx)
    1a8e:	0f b6 05 6a 00 00 00 	movzx  eax,BYTE PTR ds:0x6a
    1a95:	83 e0 10             	and    eax,0x10
    1a98:	84 c0                	test   al,al
    1a9a:	74 1b                	je     1ab7 <mm_aoa_range+0x569>
										pte->xd = (x ? 0 : 1);
    1a9c:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1aa0:	0f 94 c2             	sete   dl
    1aa3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1aa6:	89 d1                	mov    ecx,edx
    1aa8:	c1 e1 07             	shl    ecx,0x7
    1aab:	0f b6 50 07          	movzx  edx,BYTE PTR [eax+0x7]
    1aaf:	83 e2 7f             	and    edx,0x7f
    1ab2:	09 ca                	or     edx,ecx
    1ab4:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
								pte->ign = avl & 7;
    1ab7:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1aba:	83 e0 07             	and    eax,0x7
    1abd:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1ac0:	83 e0 07             	and    eax,0x7
    1ac3:	8d 0c 00             	lea    ecx,[eax+eax*1]
    1ac6:	0f b6 42 01          	movzx  eax,BYTE PTR [edx+0x1]
    1aca:	83 e0 f1             	and    eax,0xfffffff1
    1acd:	09 c8                	or     eax,ecx
    1acf:	88 42 01             	mov    BYTE PTR [edx+0x1],al
								pte->ign2 = 0;
    1ad2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ad5:	0f b7 50 06          	movzx  edx,WORD PTR [eax+0x6]
    1ad9:	66 81 e2 0f 80       	and    dx,0x800f
    1ade:	66 89 50 06          	mov    WORD PTR [eax+0x6],dx
								/* advance */
								pte++; ofs++; pg_ct--;
    1ae2:	83 45 f0 08          	add    DWORD PTR [ebp-0x10],0x8
    1ae6:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1ae9:	83 c0 01             	add    eax,0x1
    1aec:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    1aef:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
								virt_address += 4096;
    1af3:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
								if (!pg_ct) /* exit if done */
    1afa:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1afe:	74 1d                	je     1b1d <mm_aoa_range+0x5cf>
						while (ofs < 512) {
    1b00:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1b03:	3d ff 01 00 00       	cmp    eax,0x1ff
    1b08:	0f 86 6d fe ff ff    	jbe    197b <mm_aoa_range+0x42d>
		while (pg_ct) {
    1b0e:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1b12:	74 0a                	je     1b1e <mm_aoa_range+0x5d0>
redo:
    1b14:	90                   	nop
    1b15:	e9 91 fa ff ff       	jmp    15ab <mm_aoa_range+0x5d>
										return;
    1b1a:	90                   	nop
    1b1b:	eb 01                	jmp    1b1e <mm_aoa_range+0x5d0>
										return;
    1b1d:	90                   	nop
						}
				}
		}
}
    1b1e:	8d 65 f8             	lea    esp,[ebp-0x8]
    1b21:	5b                   	pop    ebx
    1b22:	5e                   	pop    esi
    1b23:	5d                   	pop    ebp
    1b24:	c3                   	ret

00001b25 <mm_unmap>:

void mm_unmap(struct mm* mm, void* virt_address, size_t pg_ct)
{
    1b25:	55                   	push   ebp
    1b26:	89 e5                	mov    ebp,esp
    1b28:	83 ec 38             	sub    esp,0x38
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (pg_ct--) {
    1b2b:	e9 41 01 00 00       	jmp    1c71 <mm_unmap+0x14c>
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#else
				if (cpu.has_pae)
    1b30:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1b37:	83 e0 40             	and    eax,0x40
    1b3a:	84 c0                	test   al,al
    1b3c:	74 2f                	je     1b6d <mm_unmap+0x48>
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
    1b3e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b41:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1b44:	8d 55 d4             	lea    edx,[ebp-0x2c]
    1b47:	52                   	push   edx
    1b48:	8d 55 d8             	lea    edx,[ebp-0x28]
    1b4b:	52                   	push   edx
    1b4c:	8d 55 e4             	lea    edx,[ebp-0x1c]
    1b4f:	52                   	push   edx
    1b50:	8d 55 e8             	lea    edx,[ebp-0x18]
    1b53:	52                   	push   edx
    1b54:	8d 55 dc             	lea    edx,[ebp-0x24]
    1b57:	52                   	push   edx
    1b58:	8d 55 e0             	lea    edx,[ebp-0x20]
    1b5b:	52                   	push   edx
    1b5c:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1b5f:	50                   	push   eax
    1b60:	e8 fc ff ff ff       	call   1b61 <mm_unmap+0x3c>
    1b65:	83 c4 20             	add    esp,0x20
    1b68:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1b6b:	eb 2d                	jmp    1b9a <mm_unmap+0x75>
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
    1b6d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b70:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1b73:	8d 55 d4             	lea    edx,[ebp-0x2c]
    1b76:	52                   	push   edx
    1b77:	8d 55 d8             	lea    edx,[ebp-0x28]
    1b7a:	52                   	push   edx
    1b7b:	8d 55 e4             	lea    edx,[ebp-0x1c]
    1b7e:	52                   	push   edx
    1b7f:	8d 55 e8             	lea    edx,[ebp-0x18]
    1b82:	52                   	push   edx
    1b83:	8d 55 dc             	lea    edx,[ebp-0x24]
    1b86:	52                   	push   edx
    1b87:	8d 55 e0             	lea    edx,[ebp-0x20]
    1b8a:	52                   	push   edx
    1b8b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1b8e:	50                   	push   eax
    1b8f:	e8 fc ff ff ff       	call   1b90 <mm_unmap+0x6b>
    1b94:	83 c4 20             	add    esp,0x20
    1b97:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
    1b9a:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1b9e:	75 5d                	jne    1bfd <mm_unmap+0xd8>
						goto advance;

				e32 = NULL; e64 = NULL;
    1ba0:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    1ba7:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (!cpu.has_pae)
    1bae:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1bb5:	83 e0 40             	and    eax,0x40
    1bb8:	84 c0                	test   al,al
    1bba:	75 08                	jne    1bc4 <mm_unmap+0x9f>
						e32 = e;
    1bbc:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1bbf:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    1bc2:	eb 06                	jmp    1bca <mm_unmap+0xa5>
				else
						e64 = e;
    1bc4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1bc7:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		
				/* make not present (TODO: clear as in free_vmem?) */
				if (!cpu.has_pae)
    1bca:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1bd1:	83 e0 40             	and    eax,0x40
    1bd4:	84 c0                	test   al,al
    1bd6:	75 0d                	jne    1be5 <mm_unmap+0xc0>
						e32->p = 0;
    1bd8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1bdb:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1bde:	83 e2 fe             	and    edx,0xfffffffe
    1be1:	88 10                	mov    BYTE PTR [eax],dl
    1be3:	eb 0b                	jmp    1bf0 <mm_unmap+0xcb>
				else
						e64->p = 0;
    1be5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1be8:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    1beb:	83 e2 fe             	and    edx,0xfffffffe
    1bee:	88 10                	mov    BYTE PTR [eax],dl

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
    1bf0:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1bf3:	e8 1c e4 ff ff       	call   14 <flush_tlb_single>
    1bf8:	83 c4 04             	add    esp,0x4
    1bfb:	eb 01                	jmp    1bfe <mm_unmap+0xd9>
						goto advance;
    1bfd:	90                   	nop
		
				/* advance */
advance:
				if (!lv) /* regular page */
    1bfe:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1c01:	85 c0                	test   eax,eax
    1c03:	75 09                	jne    1c0e <mm_unmap+0xe9>
						virt_address += 4096;
    1c05:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
    1c0c:	eb 63                	jmp    1c71 <mm_unmap+0x14c>
				else if (lv == 1) /* large page 2M/4M */
    1c0e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1c11:	83 f8 01             	cmp    eax,0x1
    1c14:	75 1f                	jne    1c35 <mm_unmap+0x110>
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
    1c16:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    1c1d:	83 e0 40             	and    eax,0x40
    1c20:	84 c0                	test   al,al
    1c22:	74 07                	je     1c2b <mm_unmap+0x106>
    1c24:	b8 00 00 80 00       	mov    eax,0x800000
    1c29:	eb 05                	jmp    1c30 <mm_unmap+0x10b>
    1c2b:	b8 00 00 00 01       	mov    eax,0x1000000
    1c30:	01 45 0c             	add    DWORD PTR [ebp+0xc],eax
    1c33:	eb 3c                	jmp    1c71 <mm_unmap+0x14c>
				else if (lv == 2) /* huge page 1G */
    1c35:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1c38:	83 f8 02             	cmp    eax,0x2
    1c3b:	75 09                	jne    1c46 <mm_unmap+0x121>
						virt_address += 1024 * 1024 * 1024;
    1c3d:	81 45 0c 00 00 00 40 	add    DWORD PTR [ebp+0xc],0x40000000
    1c44:	eb 2b                	jmp    1c71 <mm_unmap+0x14c>
				else
						die("ginormous page?\n");
    1c46:	83 ec 08             	sub    esp,0x8
    1c49:	68 90 00 00 00       	push   0x90
    1c4e:	6a 0c                	push   0xc
    1c50:	e8 fc ff ff ff       	call   1c51 <mm_unmap+0x12c>
    1c55:	83 c4 10             	add    esp,0x10
    1c58:	e8 fc ff ff ff       	call   1c59 <mm_unmap+0x134>
    1c5d:	83 ec 0c             	sub    esp,0xc
    1c60:	68 00 00 00 00       	push   0x0
    1c65:	e8 fc ff ff ff       	call   1c66 <mm_unmap+0x141>
    1c6a:	83 c4 10             	add    esp,0x10
    1c6d:	fa                   	cli
    1c6e:	f4                   	hlt
    1c6f:	eb fd                	jmp    1c6e <mm_unmap+0x149>
		while (pg_ct--) {
    1c71:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c74:	8d 50 ff             	lea    edx,[eax-0x1]
    1c77:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1c7a:	85 c0                	test   eax,eax
    1c7c:	0f 85 ae fe ff ff    	jne    1b30 <mm_unmap+0xb>
		}
}
    1c82:	90                   	nop
    1c83:	90                   	nop
    1c84:	c9                   	leave
    1c85:	c3                   	ret

00001c86 <mm_alloc_vmem>:

void* mm_alloc_vmem(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
    1c86:	55                   	push   ebp
    1c87:	89 e5                	mov    ebp,esp
    1c89:	81 ec 08 01 00 00    	sub    esp,0x108
		if (!virt_address)
    1c8f:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1c93:	75 17                	jne    1cac <mm_alloc_vmem+0x26>
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);
    1c95:	83 ec 04             	sub    esp,0x4
    1c98:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    1c9b:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1c9e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1ca1:	e8 fc ff ff ff       	call   1ca2 <mm_alloc_vmem+0x1c>
    1ca6:	83 c4 10             	add    esp,0x10
    1ca9:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax

		if ((flags & MMGR_ALLOC_CONTIGUOUS) == MMGR_ALLOC_CONTIGUOUS) {
    1cac:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1caf:	25 00 00 03 00       	and    eax,0x30000
    1cb4:	3d 00 00 03 00       	cmp    eax,0x30000
    1cb9:	75 69                	jne    1d24 <mm_alloc_vmem+0x9e>
				struct page_range pr; size_t ct;
				/* FIXME: Implement cont. allocator for PMEM */
				ct = mm_alloc_pm(pg_ct, &pr, 1);
    1cbb:	83 ec 04             	sub    esp,0x4
    1cbe:	6a 01                	push   0x1
    1cc0:	8d 45 d0             	lea    eax,[ebp-0x30]
    1cc3:	50                   	push   eax
    1cc4:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1cc7:	e8 fc ff ff ff       	call   1cc8 <mm_alloc_vmem+0x42>
    1ccc:	83 c4 10             	add    esp,0x10
    1ccf:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				if (ct < pg_ct) {
    1cd2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1cd5:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
    1cd8:	73 2b                	jae    1d05 <mm_alloc_vmem+0x7f>
						die("Contiguous allocation failed\n");
    1cda:	83 ec 08             	sub    esp,0x8
    1cdd:	68 4c 01 00 00       	push   0x14c
    1ce2:	6a 0c                	push   0xc
    1ce4:	e8 fc ff ff ff       	call   1ce5 <mm_alloc_vmem+0x5f>
    1ce9:	83 c4 10             	add    esp,0x10
    1cec:	e8 fc ff ff ff       	call   1ced <mm_alloc_vmem+0x67>
    1cf1:	83 ec 0c             	sub    esp,0xc
    1cf4:	68 00 00 00 00       	push   0x0
    1cf9:	e8 fc ff ff ff       	call   1cfa <mm_alloc_vmem+0x74>
    1cfe:	83 c4 10             	add    esp,0x10
    1d01:	fa                   	cli
    1d02:	f4                   	hlt
    1d03:	eb fd                	jmp    1d02 <mm_alloc_vmem+0x7c>
				}
				return mm_map(mm, virt_address, &pr, 1, flags);
    1d05:	83 ec 0c             	sub    esp,0xc
    1d08:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    1d0b:	6a 01                	push   0x1
    1d0d:	8d 45 d0             	lea    eax,[ebp-0x30]
    1d10:	50                   	push   eax
    1d11:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1d14:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1d17:	e8 fc ff ff ff       	call   1d18 <mm_alloc_vmem+0x92>
    1d1c:	83 c4 20             	add    esp,0x20
    1d1f:	e9 1b 01 00 00       	jmp    1e3f <mm_alloc_vmem+0x1b9>
		} else if ((flags & MMGR_ALLOC_ZERO_COW) == MMGR_ALLOC_ZERO_COW) {
    1d24:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1d27:	25 00 00 01 00       	and    eax,0x10000
    1d2c:	85 c0                	test   eax,eax
    1d2e:	74 53                	je     1d83 <mm_alloc_vmem+0xfd>
				void* rv = virt_address;
    1d30:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d33:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				struct page_range pr = { pm_zero, 1 };
    1d36:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d3b:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1d41:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    1d44:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
    1d47:	c7 45 cc 01 00 00 00 	mov    DWORD PTR [ebp-0x34],0x1
				while (pg_ct) {
    1d4e:	eb 25                	jmp    1d75 <mm_alloc_vmem+0xef>
						mm_map(mm, virt_address, &pr, 1, flags | MMGR_MAP_COW);
    1d50:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1d53:	80 cc 02             	or     ah,0x2
    1d56:	83 ec 0c             	sub    esp,0xc
    1d59:	50                   	push   eax
    1d5a:	6a 01                	push   0x1
    1d5c:	8d 45 c4             	lea    eax,[ebp-0x3c]
    1d5f:	50                   	push   eax
    1d60:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1d63:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1d66:	e8 fc ff ff ff       	call   1d67 <mm_alloc_vmem+0xe1>
    1d6b:	83 c4 20             	add    esp,0x20
						virt_address += 4096;
    1d6e:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
				while (pg_ct) {
    1d75:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1d79:	75 d5                	jne    1d50 <mm_alloc_vmem+0xca>
				}
				return rv;
    1d7b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1d7e:	e9 bc 00 00 00       	jmp    1e3f <mm_alloc_vmem+0x1b9>
		} else if ((flags & MMGR_ALLOC_NP_AOA) == MMGR_ALLOC_NP_AOA) {
    1d83:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1d86:	25 00 00 02 00       	and    eax,0x20000
    1d8b:	85 c0                	test   eax,eax
    1d8d:	74 22                	je     1db1 <mm_alloc_vmem+0x12b>
				void* rv = virt_address;
    1d8f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d92:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				mm_aoa_range(mm, virt_address, pg_ct, flags);
    1d95:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    1d98:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1d9b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1d9e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1da1:	e8 fc ff ff ff       	call   1da2 <mm_alloc_vmem+0x11c>
    1da6:	83 c4 10             	add    esp,0x10
				return rv;
    1da9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1dac:	e9 8e 00 00 00       	jmp    1e3f <mm_alloc_vmem+0x1b9>
		} else {
				void* rv = virt_address;
    1db1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1db4:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				do {
						struct page_range pr[16]; size_t ct, ct2, prc = 0;
    1db7:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
						ct = ct2 = mm_alloc_pm(pg_ct, pr, 16);
    1dbe:	83 ec 04             	sub    esp,0x4
    1dc1:	6a 10                	push   0x10
    1dc3:	8d 85 04 ff ff ff    	lea    eax,[ebp-0xfc]
    1dc9:	50                   	push   eax
    1dca:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1dcd:	e8 fc ff ff ff       	call   1dce <mm_alloc_vmem+0x148>
    1dd2:	83 c4 10             	add    esp,0x10
    1dd5:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1dd8:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1ddb:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						pg_ct -= ct;
    1dde:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1de1:	29 45 10             	sub    DWORD PTR [ebp+0x10],eax
						while (ct) {
    1de4:	eb 1f                	jmp    1e05 <mm_alloc_vmem+0x17f>
								ct -= pr[prc].count;
    1de6:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1de9:	89 d0                	mov    eax,edx
    1deb:	01 c0                	add    eax,eax
    1ded:	01 d0                	add    eax,edx
    1def:	c1 e0 02             	shl    eax,0x2
    1df2:	8d 40 f8             	lea    eax,[eax-0x8]
    1df5:	01 e8                	add    eax,ebp
    1df7:	2d ec 00 00 00       	sub    eax,0xec
    1dfc:	8b 00                	mov    eax,DWORD PTR [eax]
    1dfe:	29 45 f4             	sub    DWORD PTR [ebp-0xc],eax
								prc++;
    1e01:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
						while (ct) {
    1e05:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1e09:	75 db                	jne    1de6 <mm_alloc_vmem+0x160>
						}
						 mm_map(mm, virt_address, &pr, prc, flags);
    1e0b:	83 ec 0c             	sub    esp,0xc
    1e0e:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    1e11:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1e14:	8d 85 04 ff ff ff    	lea    eax,[ebp-0xfc]
    1e1a:	50                   	push   eax
    1e1b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1e1e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1e21:	e8 fc ff ff ff       	call   1e22 <mm_alloc_vmem+0x19c>
    1e26:	83 c4 20             	add    esp,0x20
						 virt_address += 4096 * ct2;
    1e29:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1e2c:	c1 e0 0c             	shl    eax,0xc
    1e2f:	01 45 0c             	add    DWORD PTR [ebp+0xc],eax
				} while (pg_ct);
    1e32:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1e36:	0f 85 7b ff ff ff    	jne    1db7 <mm_alloc_vmem+0x131>
				return rv;
    1e3c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
		}
}
    1e3f:	c9                   	leave
    1e40:	c3                   	ret

00001e41 <mm_extend_vmem>:

void* mm_extend_vmem(struct mm* mm, void* ptr, size_t pg_ct, size_t new_pg_ct, int flg)
{
    1e41:	55                   	push   ebp
    1e42:	89 e5                	mov    ebp,esp
    1e44:	81 ec 38 06 00 00    	sub    esp,0x638
		size_t new_pmem = new_pg_ct - pg_ct, pm_res, p0c = 0, p1c = 0;
    1e4a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1e4d:	2b 45 10             	sub    eax,DWORD PTR [ebp+0x10]
    1e50:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1e53:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1e5a:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		void *rv, *p0 = ptr, *p1;
    1e61:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e64:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		struct page_range prs[128];
		if (!ptr || new_pg_ct <= pg_ct)
    1e67:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1e6b:	74 08                	je     1e75 <mm_extend_vmem+0x34>
    1e6d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1e70:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
    1e73:	72 0a                	jb     1e7f <mm_extend_vmem+0x3e>
				return NULL;
    1e75:	b8 00 00 00 00       	mov    eax,0x0
    1e7a:	e9 9d 01 00 00       	jmp    201c <mm_extend_vmem+0x1db>
		/* reserve virtual memory */
		rv = mm_reserve_vmem(mm, new_pg_ct, flg);
    1e7f:	83 ec 04             	sub    esp,0x4
    1e82:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    1e85:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    1e88:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1e8b:	e8 fc ff ff ff       	call   1e8c <mm_extend_vmem+0x4b>
    1e90:	83 c4 10             	add    esp,0x10
    1e93:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		if (!rv)
    1e96:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1e9a:	75 0a                	jne    1ea6 <mm_extend_vmem+0x65>
				return NULL;
    1e9c:	b8 00 00 00 00       	mov    eax,0x0
    1ea1:	e9 76 01 00 00       	jmp    201c <mm_extend_vmem+0x1db>

		/* remap the existing pages */
		p1 = rv;
    1ea6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1ea9:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		while (pg_ct) {
    1eac:	e9 96 00 00 00       	jmp    1f47 <mm_extend_vmem+0x106>
				struct page_range pr;
				pr.base = mm_page_get_pmem(mm, p0);
    1eb1:	83 ec 08             	sub    esp,0x8
    1eb4:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    1eb7:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1eba:	e8 fc ff ff ff       	call   1ebb <mm_extend_vmem+0x7a>
    1ebf:	83 c4 10             	add    esp,0x10
    1ec2:	89 85 d0 f9 ff ff    	mov    DWORD PTR [ebp-0x630],eax
    1ec8:	89 95 d4 f9 ff ff    	mov    DWORD PTR [ebp-0x62c],edx
				pr.count = 1; flg = 0;
    1ece:	c7 85 d8 f9 ff ff 01 00 00 00 	mov    DWORD PTR [ebp-0x628],0x1
    1ed8:	c7 45 18 00 00 00 00 	mov    DWORD PTR [ebp+0x18],0x0
				if (!mm_map(mm, p1, &pr, 1, flg)) {
    1edf:	83 ec 0c             	sub    esp,0xc
    1ee2:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    1ee5:	6a 01                	push   0x1
    1ee7:	8d 85 d0 f9 ff ff    	lea    eax,[ebp-0x630]
    1eed:	50                   	push   eax
    1eee:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1ef1:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1ef4:	e8 fc ff ff ff       	call   1ef5 <mm_extend_vmem+0xb4>
    1ef9:	83 c4 20             	add    esp,0x20
    1efc:	85 c0                	test   eax,eax
    1efe:	75 31                	jne    1f31 <mm_extend_vmem+0xf0>
						if (p0c) /* undo the new mapping */
    1f00:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1f04:	74 21                	je     1f27 <mm_extend_vmem+0xe6>
								mm_unmap(mm, rv - p0c * 4096, p0c);
    1f06:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f09:	c1 e0 0c             	shl    eax,0xc
    1f0c:	f7 d8                	neg    eax
    1f0e:	89 c2                	mov    edx,eax
    1f10:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1f13:	01 d0                	add    eax,edx
    1f15:	83 ec 04             	sub    esp,0x4
    1f18:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1f1b:	50                   	push   eax
    1f1c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1f1f:	e8 fc ff ff ff       	call   1f20 <mm_extend_vmem+0xdf>
    1f24:	83 c4 10             	add    esp,0x10
						return NULL;
    1f27:	b8 00 00 00 00       	mov    eax,0x0
    1f2c:	e9 eb 00 00 00       	jmp    201c <mm_extend_vmem+0x1db>
				}
				p0c++; pg_ct--;
    1f31:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1f35:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
				p0 += 4096;
    1f39:	81 45 ec 00 10 00 00 	add    DWORD PTR [ebp-0x14],0x1000
				p1 += 4096;
    1f40:	81 45 e8 00 10 00 00 	add    DWORD PTR [ebp-0x18],0x1000
		while (pg_ct) {
    1f47:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1f4b:	0f 85 60 ff ff ff    	jne    1eb1 <mm_extend_vmem+0x70>
		}
		/* now get the physical memory and map it */
		while (new_pmem) {
    1f51:	e9 a5 00 00 00       	jmp    1ffb <mm_extend_vmem+0x1ba>
				pm_res = mm_alloc_pm(new_pmem, prs, 128);
    1f56:	83 ec 04             	sub    esp,0x4
    1f59:	68 80 00 00 00       	push   0x80
    1f5e:	8d 85 dc f9 ff ff    	lea    eax,[ebp-0x624]
    1f64:	50                   	push   eax
    1f65:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1f68:	e8 fc ff ff ff       	call   1f69 <mm_extend_vmem+0x128>
    1f6d:	83 c4 10             	add    esp,0x10
    1f70:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				if (!pm_res) {
    1f73:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    1f77:	75 3a                	jne    1fb3 <mm_extend_vmem+0x172>
						/* out of pmem */
						mm_free_vmem(mm, rv + p0c * 4096, p1c);
    1f79:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1f7c:	c1 e0 0c             	shl    eax,0xc
    1f7f:	89 c2                	mov    edx,eax
    1f81:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1f84:	01 d0                	add    eax,edx
    1f86:	83 ec 04             	sub    esp,0x4
    1f89:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1f8c:	50                   	push   eax
    1f8d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1f90:	e8 fc ff ff ff       	call   1f91 <mm_extend_vmem+0x150>
    1f95:	83 c4 10             	add    esp,0x10
						mm_unmap(mm, rv, p0c);
    1f98:	83 ec 04             	sub    esp,0x4
    1f9b:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1f9e:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    1fa1:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1fa4:	e8 fc ff ff ff       	call   1fa5 <mm_extend_vmem+0x164>
    1fa9:	83 c4 10             	add    esp,0x10
						return NULL;
    1fac:	b8 00 00 00 00       	mov    eax,0x0
    1fb1:	eb 69                	jmp    201c <mm_extend_vmem+0x1db>
				}
				if (!mm_map(mm, p1, prs, 128, flg)) {
    1fb3:	83 ec 0c             	sub    esp,0xc
    1fb6:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    1fb9:	68 80 00 00 00       	push   0x80
    1fbe:	8d 85 dc f9 ff ff    	lea    eax,[ebp-0x624]
    1fc4:	50                   	push   eax
    1fc5:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1fc8:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1fcb:	e8 fc ff ff ff       	call   1fcc <mm_extend_vmem+0x18b>
    1fd0:	83 c4 20             	add    esp,0x20
    1fd3:	85 c0                	test   eax,eax
    1fd5:	75 15                	jne    1fec <mm_extend_vmem+0x1ab>
						/* cannot happen on reserved mem */
						cprintf(KFMT_ERROR, "Error while mapping virtual memory which was already reserved.");
    1fd7:	83 ec 08             	sub    esp,0x8
    1fda:	68 6c 01 00 00       	push   0x16c
    1fdf:	6a 0c                	push   0xc
    1fe1:	e8 fc ff ff ff       	call   1fe2 <mm_extend_vmem+0x1a1>
    1fe6:	83 c4 10             	add    esp,0x10
						while (1);
    1fe9:	90                   	nop
    1fea:	eb fd                	jmp    1fe9 <mm_extend_vmem+0x1a8>
				} else {
						p1 += pm_res * 4096;
    1fec:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1fef:	c1 e0 0c             	shl    eax,0xc
    1ff2:	01 45 e8             	add    DWORD PTR [ebp-0x18],eax
						p1c += pm_res;
    1ff5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1ff8:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
		while (new_pmem) {
    1ffb:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1fff:	0f 85 51 ff ff ff    	jne    1f56 <mm_extend_vmem+0x115>
				}
		}
		/* and unmap the old memory */
		mm_unmap(mm, ptr, p0c);
    2005:	83 ec 04             	sub    esp,0x4
    2008:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    200b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    200e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2011:	e8 fc ff ff ff       	call   2012 <mm_extend_vmem+0x1d1>
    2016:	83 c4 10             	add    esp,0x10
		return rv;
    2019:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
}
    201c:	c9                   	leave
    201d:	c3                   	ret

0000201e <mm_free_vmem>:

void mm_free_vmem(struct mm* mm, void* virt_address, size_t pg_ct)
{
    201e:	55                   	push   ebp
    201f:	89 e5                	mov    ebp,esp
    2021:	56                   	push   esi
    2022:	53                   	push   ebx
    2023:	83 ec 30             	sub    esp,0x30
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};
    2026:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
    202d:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
    2034:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0

		/* check every page */
		while (pg_ct--) {
    203b:	e9 58 01 00 00       	jmp    2198 <mm_free_vmem+0x17a>
				/* first get the references to the structures */
				rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);
    2040:	8d 45 d4             	lea    eax,[ebp-0x2c]
    2043:	50                   	push   eax
    2044:	8d 45 d8             	lea    eax,[ebp-0x28]
    2047:	50                   	push   eax
    2048:	8d 45 e4             	lea    eax,[ebp-0x1c]
    204b:	50                   	push   eax
    204c:	8d 45 e8             	lea    eax,[ebp-0x18]
    204f:	50                   	push   eax
    2050:	8d 45 dc             	lea    eax,[ebp-0x24]
    2053:	50                   	push   eax
    2054:	8d 45 e0             	lea    eax,[ebp-0x20]
    2057:	50                   	push   eax
    2058:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    205b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    205e:	e8 fc ff ff ff       	call   205f <mm_free_vmem+0x41>
    2063:	83 c4 20             	add    esp,0x20
    2066:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax

				if (rv == 0) { /* present page */
    2069:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    206d:	0f 85 c0 00 00 00    	jne    2133 <mm_free_vmem+0x115>
						uint64_t b;
						/* get the physical memory */
						if (!cpu.has_pae)
    2073:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    207a:	83 e0 40             	and    eax,0x40
    207d:	84 c0                	test   al,al
    207f:	75 14                	jne    2095 <mm_free_vmem+0x77>
								b = ((struct pte32*)e)->addr * 0x1000;
    2081:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2084:	8b 00                	mov    eax,DWORD PTR [eax]
    2086:	c1 e8 0c             	shr    eax,0xc
    2089:	c1 e0 0c             	shl    eax,0xc
    208c:	99                   	cdq
    208d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    2090:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2093:	eb 37                	jmp    20cc <mm_free_vmem+0xae>
						else
								b = ((struct pte64*)e)->addr * 0x1000;
    2095:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    2098:	8b 19                	mov    ebx,DWORD PTR [ecx]
    209a:	89 de                	mov    esi,ebx
    209c:	c1 ee 0c             	shr    esi,0xc
    209f:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    20a3:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    20a9:	c1 e3 14             	shl    ebx,0x14
    20ac:	09 f3                	or     ebx,esi
    20ae:	89 d8                	mov    eax,ebx
    20b0:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    20b3:	c1 e9 0c             	shr    ecx,0xc
    20b6:	0f b6 d1             	movzx  edx,cl
    20b9:	0f a4 c2 0c          	shld   edx,eax,0xc
    20bd:	c1 e0 0c             	shl    eax,0xc
    20c0:	81 e2 ff 00 00 00    	and    edx,0xff
    20c6:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    20c9:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
						/* concat if possible */
						if (pr.count) {
    20cc:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    20cf:	85 c0                	test   eax,eax
    20d1:	74 4b                	je     211e <mm_free_vmem+0x100>
								if (pr.base + 4096 * pr.count == b)
    20d3:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    20d6:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    20d9:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    20dc:	c1 e1 0c             	shl    ecx,0xc
    20df:	bb 00 00 00 00       	mov    ebx,0x0
    20e4:	01 c8                	add    eax,ecx
    20e6:	11 da                	adc    edx,ebx
    20e8:	89 c1                	mov    ecx,eax
    20ea:	89 c8                	mov    eax,ecx
    20ec:	33 45 f0             	xor    eax,DWORD PTR [ebp-0x10]
    20ef:	33 55 f4             	xor    edx,DWORD PTR [ebp-0xc]
    20f2:	09 d0                	or     eax,edx
    20f4:	75 0e                	jne    2104 <mm_free_vmem+0xe6>
										pr.count++;
    20f6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    20f9:	83 c0 01             	add    eax,0x1
    20fc:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    20ff:	e9 8d 00 00 00       	jmp    2191 <mm_free_vmem+0x173>
								else {
										/* deallocate */
										mm_free_pm(&pr, 1);
    2104:	83 ec 08             	sub    esp,0x8
    2107:	6a 01                	push   0x1
    2109:	8d 45 c8             	lea    eax,[ebp-0x38]
    210c:	50                   	push   eax
    210d:	e8 fc ff ff ff       	call   210e <mm_free_vmem+0xf0>
    2112:	83 c4 10             	add    esp,0x10
										pr.count = 0;
    2115:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    211c:	eb 73                	jmp    2191 <mm_free_vmem+0x173>
								}
						} else {
								pr.base = b;
    211e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2121:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2124:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    2127:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
								pr.count = 1;
    212a:	c7 45 d0 01 00 00 00 	mov    DWORD PTR [ebp-0x30],0x1
    2131:	eb 5e                	jmp    2191 <mm_free_vmem+0x173>
						}
				} else if (e) { /* AOW etc. */
    2133:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2136:	85 c0                	test   eax,eax
    2138:	74 2c                	je     2166 <mm_free_vmem+0x148>
						bzero(e, cpu.has_pae ? 8 : 4);
    213a:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2141:	83 e0 40             	and    eax,0x40
    2144:	84 c0                	test   al,al
    2146:	74 07                	je     214f <mm_free_vmem+0x131>
    2148:	ba 08 00 00 00       	mov    edx,0x8
    214d:	eb 05                	jmp    2154 <mm_free_vmem+0x136>
    214f:	ba 04 00 00 00       	mov    edx,0x4
    2154:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2157:	83 ec 08             	sub    esp,0x8
    215a:	52                   	push   edx
    215b:	50                   	push   eax
    215c:	e8 fc ff ff ff       	call   215d <mm_free_vmem+0x13f>
    2161:	83 c4 10             	add    esp,0x10
    2164:	eb 2b                	jmp    2191 <mm_free_vmem+0x173>
				} else {
						/* invalid address */
						die("Invalid virtual address specified in free_vmem.\n");
    2166:	83 ec 08             	sub    esp,0x8
    2169:	68 ac 01 00 00       	push   0x1ac
    216e:	6a 0c                	push   0xc
    2170:	e8 fc ff ff ff       	call   2171 <mm_free_vmem+0x153>
    2175:	83 c4 10             	add    esp,0x10
    2178:	e8 fc ff ff ff       	call   2179 <mm_free_vmem+0x15b>
    217d:	83 ec 0c             	sub    esp,0xc
    2180:	68 00 00 00 00       	push   0x0
    2185:	e8 fc ff ff ff       	call   2186 <mm_free_vmem+0x168>
    218a:	83 c4 10             	add    esp,0x10
    218d:	fa                   	cli
    218e:	f4                   	hlt
    218f:	eb fd                	jmp    218e <mm_free_vmem+0x170>
				}

				/* advance */
				virt_address += 4096;
    2191:	81 45 0c 00 10 00 00 	add    DWORD PTR [ebp+0xc],0x1000
		while (pg_ct--) {
    2198:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    219b:	8d 50 ff             	lea    edx,[eax-0x1]
    219e:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    21a1:	85 c0                	test   eax,eax
    21a3:	0f 85 97 fe ff ff    	jne    2040 <mm_free_vmem+0x22>
		}

		/* remove remaining pmem */
		if (pr.count)
    21a9:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    21ac:	85 c0                	test   eax,eax
    21ae:	74 11                	je     21c1 <mm_free_vmem+0x1a3>
				mm_free_pm(&pr, 1);
    21b0:	83 ec 08             	sub    esp,0x8
    21b3:	6a 01                	push   0x1
    21b5:	8d 45 c8             	lea    eax,[ebp-0x38]
    21b8:	50                   	push   eax
    21b9:	e8 fc ff ff ff       	call   21ba <mm_free_vmem+0x19c>
    21be:	83 c4 10             	add    esp,0x10
}
    21c1:	90                   	nop
    21c2:	8d 65 f8             	lea    esp,[ebp-0x8]
    21c5:	5b                   	pop    ebx
    21c6:	5e                   	pop    esi
    21c7:	5d                   	pop    ebp
    21c8:	c3                   	ret

000021c9 <mm_page_walk>:

int mm_page_walk(struct mm* mm, void* vmem, void** p, void** e, int* lv,
				uint32_t* of, void*** cntr, void*** cntrm)
{
    21c9:	55                   	push   ebp
    21ca:	89 e5                	mov    ebp,esp
#ifdef __x86_64__
		return mm_page_walk64(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
#else
		if (cpu.has_pae)
    21cc:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    21d3:	83 e0 40             	and    eax,0x40
    21d6:	84 c0                	test   al,al
    21d8:	74 26                	je     2200 <mm_page_walk+0x37>
				return mm_page_walk36(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
    21da:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21dd:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    21e0:	ff 75 24             	push   DWORD PTR [ebp+0x24]
    21e3:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    21e6:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    21e9:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    21ec:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    21ef:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    21f2:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    21f5:	50                   	push   eax
    21f6:	e8 fc ff ff ff       	call   21f7 <mm_page_walk+0x2e>
    21fb:	83 c4 20             	add    esp,0x20
    21fe:	eb 24                	jmp    2224 <mm_page_walk+0x5b>
		else
				return mm_page_walk32(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
    2200:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2203:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2206:	ff 75 24             	push   DWORD PTR [ebp+0x24]
    2209:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    220c:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    220f:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    2212:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    2215:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    2218:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    221b:	50                   	push   eax
    221c:	e8 fc ff ff ff       	call   221d <mm_page_walk+0x54>
    2221:	83 c4 20             	add    esp,0x20
#endif
}
    2224:	c9                   	leave
    2225:	c3                   	ret

00002226 <mm_page_get_pmem>:

uint64_t mm_page_get_pmem(struct mm* mm, void* virt_address)
{
    2226:	55                   	push   ebp
    2227:	89 e5                	mov    ebp,esp
    2229:	56                   	push   esi
    222a:	53                   	push   ebx
    222b:	83 ec 30             	sub    esp,0x30
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};
    222e:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    2235:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
    223c:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0

		/* first get the references to the structures */
		rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);
    2243:	8d 45 dc             	lea    eax,[ebp-0x24]
    2246:	50                   	push   eax
    2247:	8d 45 e0             	lea    eax,[ebp-0x20]
    224a:	50                   	push   eax
    224b:	8d 45 ec             	lea    eax,[ebp-0x14]
    224e:	50                   	push   eax
    224f:	8d 45 f0             	lea    eax,[ebp-0x10]
    2252:	50                   	push   eax
    2253:	8d 45 e4             	lea    eax,[ebp-0x1c]
    2256:	50                   	push   eax
    2257:	8d 45 e8             	lea    eax,[ebp-0x18]
    225a:	50                   	push   eax
    225b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    225e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2261:	e8 fc ff ff ff       	call   2262 <mm_page_get_pmem+0x3c>
    2266:	83 c4 20             	add    esp,0x20
    2269:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax

		if (!rv)
    226c:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2270:	75 0f                	jne    2281 <mm_page_get_pmem+0x5b>
				return (uint64_t)-1;
    2272:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2277:	ba ff ff ff ff       	mov    edx,0xffffffff
    227c:	e9 a3 00 00 00       	jmp    2324 <mm_page_get_pmem+0xfe>
		else if (!lv) {
    2281:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2284:	85 c0                	test   eax,eax
    2286:	75 4f                	jne    22d7 <mm_page_get_pmem+0xb1>
				if (cpu.has_pae)
    2288:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    228f:	83 e0 40             	and    eax,0x40
    2292:	84 c0                	test   al,al
    2294:	74 33                	je     22c9 <mm_page_get_pmem+0xa3>
						return ((struct pte64*)e)->addr * 0x1000;
    2296:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    2299:	8b 19                	mov    ebx,DWORD PTR [ecx]
    229b:	89 de                	mov    esi,ebx
    229d:	c1 ee 0c             	shr    esi,0xc
    22a0:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    22a4:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    22aa:	c1 e3 14             	shl    ebx,0x14
    22ad:	09 f3                	or     ebx,esi
    22af:	89 d8                	mov    eax,ebx
    22b1:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    22b4:	c1 e9 0c             	shr    ecx,0xc
    22b7:	0f b6 d1             	movzx  edx,cl
    22ba:	0f a4 c2 0c          	shld   edx,eax,0xc
    22be:	c1 e0 0c             	shl    eax,0xc
    22c1:	81 e2 ff 00 00 00    	and    edx,0xff
    22c7:	eb 5b                	jmp    2324 <mm_page_get_pmem+0xfe>
				else
						return ((struct pte32*)e)->addr * 0x1000;
    22c9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    22cc:	8b 00                	mov    eax,DWORD PTR [eax]
    22ce:	c1 e8 0c             	shr    eax,0xc
    22d1:	c1 e0 0c             	shl    eax,0xc
    22d4:	99                   	cdq
    22d5:	eb 4d                	jmp    2324 <mm_page_get_pmem+0xfe>
		} else { /* ignore PAT bit */
				if (cpu.has_pae)
    22d7:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    22de:	83 e0 40             	and    eax,0x40
    22e1:	84 c0                	test   al,al
    22e3:	74 30                	je     2315 <mm_page_get_pmem+0xef>
						return (((struct pte64*)e)->addr & ~1ull) * 0x1000;
    22e5:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    22e8:	8b 19                	mov    ebx,DWORD PTR [ecx]
    22ea:	89 de                	mov    esi,ebx
    22ec:	c1 ee 0c             	shr    esi,0xc
    22ef:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    22f3:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    22f9:	c1 e3 14             	shl    ebx,0x14
    22fc:	09 f3                	or     ebx,esi
    22fe:	89 d8                	mov    eax,ebx
    2300:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    2303:	c1 e9 0c             	shr    ecx,0xc
    2306:	0f b6 d1             	movzx  edx,cl
    2309:	83 e0 fe             	and    eax,0xfffffffe
    230c:	0f a4 c2 0c          	shld   edx,eax,0xc
    2310:	c1 e0 0c             	shl    eax,0xc
    2313:	eb 0f                	jmp    2324 <mm_page_get_pmem+0xfe>
				else
						return (((struct pte32*)e)->addr & ~1) * 0x1000;
    2315:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2318:	8b 00                	mov    eax,DWORD PTR [eax]
    231a:	c1 e8 0c             	shr    eax,0xc
    231d:	83 e0 fe             	and    eax,0xfffffffe
    2320:	c1 e0 0c             	shl    eax,0xc
    2323:	99                   	cdq
		}
}
    2324:	8d 65 f8             	lea    esp,[ebp-0x8]
    2327:	5b                   	pop    ebx
    2328:	5e                   	pop    esi
    2329:	5d                   	pop    ebp
    232a:	c3                   	ret

0000232b <mm_handle_pagefault>:

int mm_handle_pagefault(struct mm* mm, void* eip, uint32_t seg_error, void* cr2)
{
    232b:	55                   	push   ebp
    232c:	89 e5                	mov    ebp,esp
    232e:	56                   	push   esi
    232f:	53                   	push   ebx
    2330:	83 c4 80             	add    esp,0xffffff80
		extern struct kio_region kb_reg; /* for I/O diag */
		int lv, rv; uint32_t of; struct pte64 *p, *e; struct pte32 *ps, *es;
		void **cntr, **cntrm;

		/* first get the references to the structures */
		rv = mm_page_walk(mm, cr2, &p, &e, &lv, &of, &cntr, &cntrm);
    2333:	8d 45 94             	lea    eax,[ebp-0x6c]
    2336:	50                   	push   eax
    2337:	8d 45 98             	lea    eax,[ebp-0x68]
    233a:	50                   	push   eax
    233b:	8d 45 a4             	lea    eax,[ebp-0x5c]
    233e:	50                   	push   eax
    233f:	8d 45 a8             	lea    eax,[ebp-0x58]
    2342:	50                   	push   eax
    2343:	8d 45 9c             	lea    eax,[ebp-0x64]
    2346:	50                   	push   eax
    2347:	8d 45 a0             	lea    eax,[ebp-0x60]
    234a:	50                   	push   eax
    234b:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    234e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2351:	e8 fc ff ff ff       	call   2352 <mm_handle_pagefault+0x27>
    2356:	83 c4 20             	add    esp,0x20
    2359:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		ps = (void*)p; es = (void*)e;
    235c:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    235f:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    2362:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2365:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax

		/* then check the error code */
		/* bits: 0=present, 1=write, 2=user, 3=res, 4=nx */

		if (seg_error & 1) { /* some sort of access violation */
    2368:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    236b:	83 e0 01             	and    eax,0x1
    236e:	85 c0                	test   eax,eax
    2370:	0f 84 c5 03 00 00    	je     273b <mm_handle_pagefault+0x410>
				if (seg_error & 8) { /* reserved bits */
    2376:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2379:	83 e0 08             	and    eax,0x8
    237c:	85 c0                	test   eax,eax
    237e:	0f 84 aa 00 00 00    	je     242e <mm_handle_pagefault+0x103>
						uint32_t hi, lo;
						cprintf(KFMT_ERROR, "Page lookup through %p contained entries"
    2384:	83 ec 04             	sub    esp,0x4
    2387:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    238a:	68 e0 01 00 00       	push   0x1e0
    238f:	6a 0c                	push   0xc
    2391:	e8 fc ff ff ff       	call   2392 <mm_handle_pagefault+0x67>
    2396:	83 c4 10             	add    esp,0x10
								" which have reserved bits set. This indicates"
								" either page table corruption or sloppy programming.\n", cr2);
						printf("seg_error: %08x\n", seg_error);
    2399:	83 ec 08             	sub    esp,0x8
    239c:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    239f:	68 6b 02 00 00       	push   0x26b
    23a4:	e8 fc ff ff ff       	call   23a5 <mm_handle_pagefault+0x7a>
    23a9:	83 c4 10             	add    esp,0x10
						printf("level=%d, entry=%u\n", lv, of);
    23ac:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    23af:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    23b2:	83 ec 04             	sub    esp,0x4
    23b5:	52                   	push   edx
    23b6:	50                   	push   eax
    23b7:	68 7c 02 00 00       	push   0x27c
    23bc:	e8 fc ff ff ff       	call   23bd <mm_handle_pagefault+0x92>
    23c1:	83 c4 10             	add    esp,0x10
						if (cpu.has_pae)
    23c4:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    23cb:	83 e0 40             	and    eax,0x40
    23ce:	84 c0                	test   al,al
    23d0:	74 1c                	je     23ee <mm_handle_pagefault+0xc3>
								printf("entry: %016llx\n", *(uint64_t*)e);
    23d2:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    23d5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    23d8:	8b 00                	mov    eax,DWORD PTR [eax]
    23da:	83 ec 04             	sub    esp,0x4
    23dd:	52                   	push   edx
    23de:	50                   	push   eax
    23df:	68 90 02 00 00       	push   0x290
    23e4:	e8 fc ff ff ff       	call   23e5 <mm_handle_pagefault+0xba>
    23e9:	83 c4 10             	add    esp,0x10
    23ec:	eb 16                	jmp    2404 <mm_handle_pagefault+0xd9>
						else
								printf("entry: %08x\n", *(uint32_t*)es);
    23ee:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    23f1:	8b 00                	mov    eax,DWORD PTR [eax]
    23f3:	83 ec 08             	sub    esp,0x8
    23f6:	50                   	push   eax
    23f7:	68 a0 02 00 00       	push   0x2a0
    23fc:	e8 fc ff ff ff       	call   23fd <mm_handle_pagefault+0xd2>
    2401:	83 c4 10             	add    esp,0x10
						/* Show MSR */
						asm ("rdmsr" : "=a" (lo), "=d" (hi) : "c" (0xc0000080));
    2404:	b8 80 00 00 c0       	mov    eax,0xc0000080
    2409:	89 c1                	mov    ecx,eax
    240b:	0f 32                	rdmsr
    240d:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    2410:	89 55 ac             	mov    DWORD PTR [ebp-0x54],edx
						printf("MSR: %08x%08x\n", hi, lo);
    2413:	83 ec 04             	sub    esp,0x4
    2416:	ff 75 b0             	push   DWORD PTR [ebp-0x50]
    2419:	ff 75 ac             	push   DWORD PTR [ebp-0x54]
    241c:	68 ad 02 00 00       	push   0x2ad
    2421:	e8 fc ff ff ff       	call   2422 <mm_handle_pagefault+0xf7>
    2426:	83 c4 10             	add    esp,0x10
    2429:	e9 7b 05 00 00       	jmp    29a9 <mm_handle_pagefault+0x67e>
				} else { /* regular access error */
						uint64_t pm; int w, u, x, tlb = 0;
    242e:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
						const char* errstr; uint32_t avl;

						/* get the info */
						if (!cpu.has_pae) {
    2435:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    243c:	83 e0 40             	and    eax,0x40
    243f:	84 c0                	test   al,al
    2441:	75 53                	jne    2496 <mm_handle_pagefault+0x16b>
								pm = es->addr * 0x1000;
    2443:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2446:	8b 00                	mov    eax,DWORD PTR [eax]
    2448:	c1 e8 0c             	shr    eax,0xc
    244b:	c1 e0 0c             	shl    eax,0xc
    244e:	99                   	cdq
    244f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    2452:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
								x = 1;
    2455:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
								w = es->w;
    245c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    245f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2462:	d0 e8                	shr    al,1
    2464:	83 e0 01             	and    eax,0x1
    2467:	0f b6 c0             	movzx  eax,al
    246a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								u = es->u;
    246d:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2470:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2473:	c0 e8 02             	shr    al,0x2
    2476:	83 e0 01             	and    eax,0x1
    2479:	0f b6 c0             	movzx  eax,al
    247c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								avl = es->ign;
    247f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2482:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    2486:	d0 e8                	shr    al,1
    2488:	83 e0 07             	and    eax,0x7
    248b:	0f b6 c0             	movzx  eax,al
    248e:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    2491:	e9 98 00 00 00       	jmp    252e <mm_handle_pagefault+0x203>
						} else {
								pm = e->addr * 0x1000;
    2496:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    2499:	8b 19                	mov    ebx,DWORD PTR [ecx]
    249b:	89 de                	mov    esi,ebx
    249d:	c1 ee 0c             	shr    esi,0xc
    24a0:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    24a4:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    24aa:	c1 e3 14             	shl    ebx,0x14
    24ad:	09 f3                	or     ebx,esi
    24af:	89 d8                	mov    eax,ebx
    24b1:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    24b4:	c1 e9 0c             	shr    ecx,0xc
    24b7:	0f b6 d1             	movzx  edx,cl
    24ba:	0f a4 c2 0c          	shld   edx,eax,0xc
    24be:	c1 e0 0c             	shl    eax,0xc
    24c1:	81 e2 ff 00 00 00    	and    edx,0xff
    24c7:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    24ca:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
								x = !e->xd;
    24cd:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    24d0:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    24d4:	83 e0 80             	and    eax,0xffffff80
    24d7:	84 c0                	test   al,al
    24d9:	0f 94 c0             	sete   al
    24dc:	0f b6 c0             	movzx  eax,al
    24df:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								w = e->w;
    24e2:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    24e5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    24e8:	d0 e8                	shr    al,1
    24ea:	83 e0 01             	and    eax,0x1
    24ed:	0f b6 c0             	movzx  eax,al
    24f0:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								u = e->u;
    24f3:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    24f6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    24f9:	c0 e8 02             	shr    al,0x2
    24fc:	83 e0 01             	and    eax,0x1
    24ff:	0f b6 c0             	movzx  eax,al
    2502:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
								avl = e->ign | (e->ign2 << 3);
    2505:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2508:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
    250c:	d0 e8                	shr    al,1
    250e:	83 e0 07             	and    eax,0x7
    2511:	0f b6 d0             	movzx  edx,al
    2514:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2517:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    251b:	66 c1 e8 04          	shr    ax,0x4
    251f:	66 25 ff 07          	and    ax,0x7ff
    2523:	0f b7 c0             	movzx  eax,ax
    2526:	c1 e0 03             	shl    eax,0x3
    2529:	09 d0                	or     eax,edx
    252b:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
						}
						/* create the errstr */
						if (seg_error & 16) {
    252e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2531:	83 e0 10             	and    eax,0x10
    2534:	85 c0                	test   eax,eax
    2536:	74 1e                	je     2556 <mm_handle_pagefault+0x22b>
								if (x) { /* check for NX in directoy */
    2538:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    253c:	74 0c                	je     254a <mm_handle_pagefault+0x21f>
										tlb = 1;
    253e:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
    2545:	e9 10 01 00 00       	jmp    265a <mm_handle_pagefault+0x32f>
								} else
										errstr = "no execute";
    254a:	c7 45 dc bc 02 00 00 	mov    DWORD PTR [ebp-0x24],0x2bc
    2551:	e9 04 01 00 00       	jmp    265a <mm_handle_pagefault+0x32f>
						} else if (seg_error & 4) {
    2556:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2559:	83 e0 04             	and    eax,0x4
    255c:	85 c0                	test   eax,eax
    255e:	74 1e                	je     257e <mm_handle_pagefault+0x253>
								if (u)
    2560:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    2564:	74 0c                	je     2572 <mm_handle_pagefault+0x247>
										tlb = 1;
    2566:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
    256d:	e9 e8 00 00 00       	jmp    265a <mm_handle_pagefault+0x32f>
								else
										errstr = "kernel";
    2572:	c7 45 dc c7 02 00 00 	mov    DWORD PTR [ebp-0x24],0x2c7
    2579:	e9 dc 00 00 00       	jmp    265a <mm_handle_pagefault+0x32f>
						} else if (seg_error & 2) {
    257e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2581:	83 e0 02             	and    eax,0x2
    2584:	85 c0                	test   eax,eax
    2586:	0f 84 ce 00 00 00    	je     265a <mm_handle_pagefault+0x32f>
								if (w) /* we assume consistent directories */
    258c:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2590:	74 0c                	je     259e <mm_handle_pagefault+0x273>
										tlb = 1;
    2592:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
    2599:	e9 bc 00 00 00       	jmp    265a <mm_handle_pagefault+0x32f>
								else if (avl & 1) { /* COW */
    259e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    25a1:	83 e0 01             	and    eax,0x1
    25a4:	85 c0                	test   eax,eax
    25a6:	0f 84 a7 00 00 00    	je     2653 <mm_handle_pagefault+0x328>
										size_t pg_ct = 1; struct page_range pr;
    25ac:	c7 45 b4 01 00 00 00 	mov    DWORD PTR [ebp-0x4c],0x1
										if (lv > 0) {
    25b3:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    25b6:	85 c0                	test   eax,eax
    25b8:	7e 2b                	jle    25e5 <mm_handle_pagefault+0x2ba>
												die("COW on large pages not implemented yet\n");
    25ba:	83 ec 08             	sub    esp,0x8
    25bd:	68 d0 02 00 00       	push   0x2d0
    25c2:	6a 0c                	push   0xc
    25c4:	e8 fc ff ff ff       	call   25c5 <mm_handle_pagefault+0x29a>
    25c9:	83 c4 10             	add    esp,0x10
    25cc:	e8 fc ff ff ff       	call   25cd <mm_handle_pagefault+0x2a2>
    25d1:	83 ec 0c             	sub    esp,0xc
    25d4:	68 00 00 00 00       	push   0x0
    25d9:	e8 fc ff ff ff       	call   25da <mm_handle_pagefault+0x2af>
    25de:	83 c4 10             	add    esp,0x10
    25e1:	fa                   	cli
    25e2:	f4                   	hlt
    25e3:	eb fd                	jmp    25e2 <mm_handle_pagefault+0x2b7>
										}
										if (mm_alloc_pm(pg_ct, &pr, 1)) {
    25e5:	83 ec 04             	sub    esp,0x4
    25e8:	6a 01                	push   0x1
    25ea:	8d 45 88             	lea    eax,[ebp-0x78]
    25ed:	50                   	push   eax
    25ee:	ff 75 b4             	push   DWORD PTR [ebp-0x4c]
    25f1:	e8 fc ff ff ff       	call   25f2 <mm_handle_pagefault+0x2c7>
    25f6:	83 c4 10             	add    esp,0x10
    25f9:	85 c0                	test   eax,eax
    25fb:	74 2b                	je     2628 <mm_handle_pagefault+0x2fd>
												/* FIXME: Shootdown needed? No stale data would cause
												 * another COW and this can be detected in the PF handler. */
												die("COW not implemented\n");
    25fd:	83 ec 08             	sub    esp,0x8
    2600:	68 f8 02 00 00       	push   0x2f8
    2605:	6a 0c                	push   0xc
    2607:	e8 fc ff ff ff       	call   2608 <mm_handle_pagefault+0x2dd>
    260c:	83 c4 10             	add    esp,0x10
    260f:	e8 fc ff ff ff       	call   2610 <mm_handle_pagefault+0x2e5>
    2614:	83 ec 0c             	sub    esp,0xc
    2617:	68 00 00 00 00       	push   0x0
    261c:	e8 fc ff ff ff       	call   261d <mm_handle_pagefault+0x2f2>
    2621:	83 c4 10             	add    esp,0x10
    2624:	fa                   	cli
    2625:	f4                   	hlt
    2626:	eb fd                	jmp    2625 <mm_handle_pagefault+0x2fa>
										} else {
												die("unable to allocate memory for COW\n");
    2628:	83 ec 08             	sub    esp,0x8
    262b:	68 10 03 00 00       	push   0x310
    2630:	6a 0c                	push   0xc
    2632:	e8 fc ff ff ff       	call   2633 <mm_handle_pagefault+0x308>
    2637:	83 c4 10             	add    esp,0x10
    263a:	e8 fc ff ff ff       	call   263b <mm_handle_pagefault+0x310>
    263f:	83 ec 0c             	sub    esp,0xc
    2642:	68 00 00 00 00       	push   0x0
    2647:	e8 fc ff ff ff       	call   2648 <mm_handle_pagefault+0x31d>
    264c:	83 c4 10             	add    esp,0x10
    264f:	fa                   	cli
    2650:	f4                   	hlt
    2651:	eb fd                	jmp    2650 <mm_handle_pagefault+0x325>
										}
								} else
										errstr = "read only";
    2653:	c7 45 dc 33 03 00 00 	mov    DWORD PTR [ebp-0x24],0x333
						}

						if (tlb) {
    265a:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    265e:	74 4a                	je     26aa <mm_handle_pagefault+0x37f>
								uint8_t id = 0;
    2660:	c6 45 d7 00          	mov    BYTE PTR [ebp-0x29],0x0
								if (nproc > 1)
    2664:	a1 00 00 00 00       	mov    eax,ds:0x0
    2669:	83 f8 01             	cmp    eax,0x1
    266c:	76 0a                	jbe    2678 <mm_handle_pagefault+0x34d>
										id = smp_processor_id();
    266e:	e8 8d d9 ff ff       	call   0 <per_cpu_ptr>
    2673:	8b 00                	mov    eax,DWORD PTR [eax]
    2675:	88 45 d7             	mov    BYTE PTR [ebp-0x29],al
								rprintf(&kb_reg, "[%u] TLB fl: %p\n", id, cr2);
    2678:	0f b6 45 d7          	movzx  eax,BYTE PTR [ebp-0x29]
    267c:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    267f:	50                   	push   eax
    2680:	68 3d 03 00 00       	push   0x33d
    2685:	68 00 00 00 00       	push   0x0
    268a:	e8 fc ff ff ff       	call   268b <mm_handle_pagefault+0x360>
    268f:	83 c4 10             	add    esp,0x10
								flush_tlb_single(cr2);
    2692:	83 ec 0c             	sub    esp,0xc
    2695:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    2698:	e8 77 d9 ff ff       	call   14 <flush_tlb_single>
    269d:	83 c4 10             	add    esp,0x10
								return 0;
    26a0:	b8 00 00 00 00       	mov    eax,0x0
    26a5:	e9 04 03 00 00       	jmp    29ae <mm_handle_pagefault+0x683>
						}

						/* print the error */
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
								" but is not allowed to do so as page is marked as %s\n",
								eip, (seg_error & 2) ? "write to" : ((seg_error & 16) ?
    26aa:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    26ad:	83 e0 02             	and    eax,0x2
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
    26b0:	85 c0                	test   eax,eax
    26b2:	75 18                	jne    26cc <mm_handle_pagefault+0x3a1>
								eip, (seg_error & 2) ? "write to" : ((seg_error & 16) ?
    26b4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    26b7:	83 e0 10             	and    eax,0x10
								"fetch instructions from": "read from"),
    26ba:	85 c0                	test   eax,eax
    26bc:	74 07                	je     26c5 <mm_handle_pagefault+0x39a>
    26be:	b8 4e 03 00 00       	mov    eax,0x34e
    26c3:	eb 0c                	jmp    26d1 <mm_handle_pagefault+0x3a6>
    26c5:	b8 66 03 00 00       	mov    eax,0x366
    26ca:	eb 05                	jmp    26d1 <mm_handle_pagefault+0x3a6>
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
    26cc:	b8 70 03 00 00       	mov    eax,0x370
    26d1:	83 ec 08             	sub    esp,0x8
    26d4:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    26d7:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    26da:	50                   	push   eax
    26db:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    26de:	68 7c 03 00 00       	push   0x37c
    26e3:	6a 0c                	push   0xc
    26e5:	e8 fc ff ff ff       	call   26e6 <mm_handle_pagefault+0x3bb>
    26ea:	83 c4 20             	add    esp,0x20
								cr2, errstr);
						printf("The page is %s and present\n", lv ? (lv > 1 ? "huge" : "large") : "regular");
    26ed:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    26f0:	85 c0                	test   eax,eax
    26f2:	74 16                	je     270a <mm_handle_pagefault+0x3df>
    26f4:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    26f7:	83 f8 01             	cmp    eax,0x1
    26fa:	7e 07                	jle    2703 <mm_handle_pagefault+0x3d8>
    26fc:	b8 db 03 00 00       	mov    eax,0x3db
    2701:	eb 0c                	jmp    270f <mm_handle_pagefault+0x3e4>
    2703:	b8 e0 03 00 00       	mov    eax,0x3e0
    2708:	eb 05                	jmp    270f <mm_handle_pagefault+0x3e4>
    270a:	b8 e6 03 00 00       	mov    eax,0x3e6
    270f:	83 ec 08             	sub    esp,0x8
    2712:	50                   	push   eax
    2713:	68 ee 03 00 00       	push   0x3ee
    2718:	e8 fc ff ff ff       	call   2719 <mm_handle_pagefault+0x3ee>
    271d:	83 c4 10             	add    esp,0x10
						printf("it points to physical memory at %#.16llx\n", pm);
    2720:	83 ec 04             	sub    esp,0x4
    2723:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2726:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    2729:	68 0c 04 00 00       	push   0x40c
    272e:	e8 fc ff ff ff       	call   272f <mm_handle_pagefault+0x404>
    2733:	83 c4 10             	add    esp,0x10
    2736:	e9 6e 02 00 00       	jmp    29a9 <mm_handle_pagefault+0x67e>
				}
		} else { /* encountered nonpresent page */
				uint64_t flags = 0;
    273b:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
    2742:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
				/* get flag bits */
				if (!cpu.has_pae) { /* pte32 */
    2749:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2750:	83 e0 40             	and    eax,0x40
    2753:	84 c0                	test   al,al
    2755:	75 43                	jne    279a <mm_handle_pagefault+0x46f>
						if (es) /* there's sth. */
    2757:	83 7d bc 00          	cmp    DWORD PTR [ebp-0x44],0x0
    275b:	74 12                	je     276f <mm_handle_pagefault+0x444>
								flags |= *(uint32_t*)es;
    275d:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2760:	8b 00                	mov    eax,DWORD PTR [eax]
    2762:	ba 00 00 00 00       	mov    edx,0x0
    2767:	09 45 c8             	or     DWORD PTR [ebp-0x38],eax
    276a:	09 55 cc             	or     DWORD PTR [ebp-0x34],edx
    276d:	eb 6d                	jmp    27dc <mm_handle_pagefault+0x4b1>
						else
								die("level 2 missing\n");
    276f:	83 ec 08             	sub    esp,0x8
    2772:	68 36 04 00 00       	push   0x436
    2777:	6a 0c                	push   0xc
    2779:	e8 fc ff ff ff       	call   277a <mm_handle_pagefault+0x44f>
    277e:	83 c4 10             	add    esp,0x10
    2781:	e8 fc ff ff ff       	call   2782 <mm_handle_pagefault+0x457>
    2786:	83 ec 0c             	sub    esp,0xc
    2789:	68 00 00 00 00       	push   0x0
    278e:	e8 fc ff ff ff       	call   278f <mm_handle_pagefault+0x464>
    2793:	83 c4 10             	add    esp,0x10
    2796:	fa                   	cli
    2797:	f4                   	hlt
    2798:	eb fd                	jmp    2797 <mm_handle_pagefault+0x46c>
				} else {
						if (e)
    279a:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    279d:	85 c0                	test   eax,eax
    279f:	74 10                	je     27b1 <mm_handle_pagefault+0x486>
								flags |= *(uint64_t*)e;
    27a1:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    27a4:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    27a7:	8b 00                	mov    eax,DWORD PTR [eax]
    27a9:	09 45 c8             	or     DWORD PTR [ebp-0x38],eax
    27ac:	09 55 cc             	or     DWORD PTR [ebp-0x34],edx
    27af:	eb 2b                	jmp    27dc <mm_handle_pagefault+0x4b1>
						else
								die("level 2 or 4 missing\n");
    27b1:	83 ec 08             	sub    esp,0x8
    27b4:	68 47 04 00 00       	push   0x447
    27b9:	6a 0c                	push   0xc
    27bb:	e8 fc ff ff ff       	call   27bc <mm_handle_pagefault+0x491>
    27c0:	83 c4 10             	add    esp,0x10
    27c3:	e8 fc ff ff ff       	call   27c4 <mm_handle_pagefault+0x499>
    27c8:	83 ec 0c             	sub    esp,0xc
    27cb:	68 00 00 00 00       	push   0x0
    27d0:	e8 fc ff ff ff       	call   27d1 <mm_handle_pagefault+0x4a6>
    27d5:	83 c4 10             	add    esp,0x10
    27d8:	fa                   	cli
    27d9:	f4                   	hlt
    27da:	eb fd                	jmp    27d9 <mm_handle_pagefault+0x4ae>
				}

				/* check for known codes */
				flags >>= 1;
    27dc:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    27df:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    27e2:	0f ac d0 01          	shrd   eax,edx,0x1
    27e6:	d1 ea                	shr    edx,1
    27e8:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
    27eb:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
				/* CAUTION: Swap IDs have to keep AVL field free */
				if (flags & (1 << 11)) { /* allocate on access */
    27ee:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    27f1:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    27f4:	25 00 08 00 00       	and    eax,0x800
    27f9:	ba 00 00 00 00       	mov    edx,0x0
    27fe:	89 c1                	mov    ecx,eax
    2800:	89 c8                	mov    eax,ecx
    2802:	09 d0                	or     eax,edx
    2804:	0f 84 60 01 00 00    	je     296a <mm_handle_pagefault+0x63f>
						size_t pg_ct = 1; struct page_range pr;
    280a:	c7 45 b8 01 00 00 00 	mov    DWORD PTR [ebp-0x48],0x1
						if (lv > 0) {
    2811:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2814:	85 c0                	test   eax,eax
    2816:	7e 2b                	jle    2843 <mm_handle_pagefault+0x518>
								/* TODO: cont alloc & large pages */
								die("no AOA large pages implemented yet!\n");
    2818:	83 ec 08             	sub    esp,0x8
    281b:	68 60 04 00 00       	push   0x460
    2820:	6a 0c                	push   0xc
    2822:	e8 fc ff ff ff       	call   2823 <mm_handle_pagefault+0x4f8>
    2827:	83 c4 10             	add    esp,0x10
    282a:	e8 fc ff ff ff       	call   282b <mm_handle_pagefault+0x500>
    282f:	83 ec 0c             	sub    esp,0xc
    2832:	68 00 00 00 00       	push   0x0
    2837:	e8 fc ff ff ff       	call   2838 <mm_handle_pagefault+0x50d>
    283c:	83 c4 10             	add    esp,0x10
    283f:	fa                   	cli
    2840:	f4                   	hlt
    2841:	eb fd                	jmp    2840 <mm_handle_pagefault+0x515>
						}
						/* alloc & print info */
						if (mm_alloc_pm(pg_ct, &pr, 1)) {
    2843:	83 ec 04             	sub    esp,0x4
    2846:	6a 01                	push   0x1
    2848:	8d 85 7c ff ff ff    	lea    eax,[ebp-0x84]
    284e:	50                   	push   eax
    284f:	ff 75 b8             	push   DWORD PTR [ebp-0x48]
    2852:	e8 fc ff ff ff       	call   2853 <mm_handle_pagefault+0x528>
    2857:	83 c4 10             	add    esp,0x10
    285a:	85 c0                	test   eax,eax
    285c:	0f 84 dd 00 00 00    	je     293f <mm_handle_pagefault+0x614>
								/* level0 -> no new pointers */
								if (!cpu.has_pae) {
    2862:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2869:	83 e0 40             	and    eax,0x40
    286c:	84 c0                	test   al,al
    286e:	75 35                	jne    28a5 <mm_handle_pagefault+0x57a>
										es->addr = (uint32_t)(pr.base / 4096);
    2870:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [ebp-0x84]
    2876:	8b 55 80             	mov    edx,DWORD PTR [ebp-0x80]
    2879:	0f ac d0 0c          	shrd   eax,edx,0xc
    287d:	c1 ea 0c             	shr    edx,0xc
    2880:	25 ff ff 0f 00       	and    eax,0xfffff
    2885:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    2888:	c1 e0 0c             	shl    eax,0xc
    288b:	89 c1                	mov    ecx,eax
    288d:	8b 02                	mov    eax,DWORD PTR [edx]
    288f:	25 ff 0f 00 00       	and    eax,0xfff
    2894:	09 c8                	or     eax,ecx
    2896:	89 02                	mov    DWORD PTR [edx],eax
										es->p = 1;
    2898:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    289b:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    289e:	83 ca 01             	or     edx,0x1
    28a1:	88 10                	mov    BYTE PTR [eax],dl
    28a3:	eb 6d                	jmp    2912 <mm_handle_pagefault+0x5e7>
								} else {
										e->addr = pr.base / 4096;
    28a5:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [ebp-0x84]
    28ab:	8b 55 80             	mov    edx,DWORD PTR [ebp-0x80]
    28ae:	0f ac d0 0c          	shrd   eax,edx,0xc
    28b2:	c1 ea 0c             	shr    edx,0xc
    28b5:	8b 4d 9c             	mov    ecx,DWORD PTR [ebp-0x64]
    28b8:	81 e2 ff 00 00 00    	and    edx,0xff
    28be:	89 c3                	mov    ebx,eax
    28c0:	81 e3 ff ff 0f 00    	and    ebx,0xfffff
    28c6:	89 de                	mov    esi,ebx
    28c8:	c1 e6 0c             	shl    esi,0xc
    28cb:	8b 19                	mov    ebx,DWORD PTR [ecx]
    28cd:	81 e3 ff 0f 00 00    	and    ebx,0xfff
    28d3:	09 f3                	or     ebx,esi
    28d5:	89 19                	mov    DWORD PTR [ecx],ebx
    28d7:	89 c3                	mov    ebx,eax
    28d9:	c1 eb 14             	shr    ebx,0x14
    28dc:	89 de                	mov    esi,ebx
    28de:	66 81 e6 ff 0f       	and    si,0xfff
    28e3:	0f b7 59 04          	movzx  ebx,WORD PTR [ecx+0x4]
    28e7:	66 81 e3 00 f0       	and    bx,0xf000
    28ec:	09 f3                	or     ebx,esi
    28ee:	66 89 59 04          	mov    WORD PTR [ecx+0x4],bx
    28f2:	0f b6 c2             	movzx  eax,dl
    28f5:	c1 e0 0c             	shl    eax,0xc
    28f8:	89 c2                	mov    edx,eax
    28fa:	8b 41 04             	mov    eax,DWORD PTR [ecx+0x4]
    28fd:	25 ff 0f f0 ff       	and    eax,0xfff00fff
    2902:	09 d0                	or     eax,edx
    2904:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
										e->p = 1;
    2907:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    290a:	0f b6 10             	movzx  edx,BYTE PTR [eax]
    290d:	83 ca 01             	or     edx,0x1
    2910:	88 10                	mov    BYTE PTR [eax],dl
								}
								flush_tlb_single(cr2);
    2912:	83 ec 0c             	sub    esp,0xc
    2915:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    2918:	e8 f7 d6 ff ff       	call   14 <flush_tlb_single>
    291d:	83 c4 10             	add    esp,0x10
								rprintf(&kb_reg, "MM AOW: %p\n", cr2);
    2920:	83 ec 04             	sub    esp,0x4
    2923:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    2926:	68 85 04 00 00       	push   0x485
    292b:	68 00 00 00 00       	push   0x0
    2930:	e8 fc ff ff ff       	call   2931 <mm_handle_pagefault+0x606>
    2935:	83 c4 10             	add    esp,0x10
								return 0;
    2938:	b8 00 00 00 00       	mov    eax,0x0
    293d:	eb 6f                	jmp    29ae <mm_handle_pagefault+0x683>
						} else {
								die("Out of memory for AOA\n");
    293f:	83 ec 08             	sub    esp,0x8
    2942:	68 91 04 00 00       	push   0x491
    2947:	6a 0c                	push   0xc
    2949:	e8 fc ff ff ff       	call   294a <mm_handle_pagefault+0x61f>
    294e:	83 c4 10             	add    esp,0x10
    2951:	e8 fc ff ff ff       	call   2952 <mm_handle_pagefault+0x627>
    2956:	83 ec 0c             	sub    esp,0xc
    2959:	68 00 00 00 00       	push   0x0
    295e:	e8 fc ff ff ff       	call   295f <mm_handle_pagefault+0x634>
    2963:	83 c4 10             	add    esp,0x10
    2966:	fa                   	cli
    2967:	f4                   	hlt
    2968:	eb fd                	jmp    2967 <mm_handle_pagefault+0x63c>
						}
				} else {
						/* swapped with ID */
						cprintf(KFMT_INFO, "Swapping in single page with id %llu\n", flags);
    296a:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    296d:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    2970:	68 a8 04 00 00       	push   0x4a8
    2975:	6a 0b                	push   0xb
    2977:	e8 fc ff ff ff       	call   2978 <mm_handle_pagefault+0x64d>
    297c:	83 c4 10             	add    esp,0x10
						cprintf(KFMT_ERROR, "which is not implemented\n");
    297f:	83 ec 08             	sub    esp,0x8
    2982:	68 ce 04 00 00       	push   0x4ce
    2987:	6a 0c                	push   0xc
    2989:	e8 fc ff ff ff       	call   298a <mm_handle_pagefault+0x65f>
    298e:	83 c4 10             	add    esp,0x10
						printf("level=%d, entry=%u, ptr=%p\n", lv, of, cr2);
    2991:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    2994:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2997:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    299a:	52                   	push   edx
    299b:	50                   	push   eax
    299c:	68 e8 04 00 00       	push   0x4e8
    29a1:	e8 fc ff ff ff       	call   29a2 <mm_handle_pagefault+0x677>
    29a6:	83 c4 10             	add    esp,0x10
		// --------------
		// Codes with access violation on present pages: 3 avl bits
		// 0 = regular, i.e. invalid
		// 1 = copy on write
		*/
		return 1;
    29a9:	b8 01 00 00 00       	mov    eax,0x1
}
    29ae:	8d 65 f8             	lea    esp,[ebp-0x8]
    29b1:	5b                   	pop    ebx
    29b2:	5e                   	pop    esi
    29b3:	5d                   	pop    ebp
    29b4:	c3                   	ret

000029b5 <print_stacktrace>:

const char* elf_get_closest_symbol(void* ptr, size_t* offset);
void print_stacktrace()
{
    29b5:	55                   	push   ebp
    29b6:	89 e5                	mov    ebp,esp
    29b8:	56                   	push   esi
    29b9:	53                   	push   ebx
    29ba:	83 ec 30             	sub    esp,0x30
				struct sf* prev;
				void* ret_addr;
				void* args[4];
		} __attribute__((packed)) *fp;
		static int stc = 0;
		stc++;
    29bd:	a1 0c 01 00 00       	mov    eax,ds:0x10c
    29c2:	83 c0 01             	add    eax,0x1
    29c5:	a3 0c 01 00 00       	mov    ds:0x10c,eax
		if (stc == 1) {
    29ca:	a1 0c 01 00 00       	mov    eax,ds:0x10c
    29cf:	83 f8 01             	cmp    eax,0x1
    29d2:	0f 85 d9 00 00 00    	jne    2ab1 <print_stacktrace+0xfc>
print_st:
    29d8:	90                   	nop
				/* get ebp into C code */
#ifdef __x86_64__
				__asm__("mov %%rbp, %[fp]" : /* output */ [fp] "=r" (fp));
#else
				__asm__("movl %%ebp, %[fp]" : /* output */ [fp] "=r" (fp));
    29d9:	89 e8                	mov    eax,ebp
    29db:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
#endif
				/* do the backtrace from ebp to ebp */
				printf("performing stacktrace:\n");
    29de:	83 ec 0c             	sub    esp,0xc
    29e1:	68 04 05 00 00       	push   0x504
    29e6:	e8 fc ff ff ff       	call   29e7 <print_stacktrace+0x32>
    29eb:	83 c4 10             	add    esp,0x10
#ifdef __x86_64__
				printf("RBP              ARG-1             ARG-2             ARG-3             ARG-4            FROM\n");
#else
				printf("EBP      ARG-1     ARG-2     ARG-3     ARG-4    FROM\n");
    29ee:	83 ec 0c             	sub    esp,0xc
    29f1:	68 1c 05 00 00       	push   0x51c
    29f6:	e8 fc ff ff ff       	call   29f7 <print_stacktrace+0x42>
    29fb:	83 c4 10             	add    esp,0x10
#endif
				do {
						size_t of; const char* sym;
						printf("%p %p %p %p %p %p\n", fp, fp->args[0], fp->args[1],
    29fe:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a01:	8b 70 04             	mov    esi,DWORD PTR [eax+0x4]
    2a04:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a07:	8b 58 14             	mov    ebx,DWORD PTR [eax+0x14]
    2a0a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a0d:	8b 48 10             	mov    ecx,DWORD PTR [eax+0x10]
    2a10:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a13:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2a16:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a19:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2a1c:	83 ec 04             	sub    esp,0x4
    2a1f:	56                   	push   esi
    2a20:	53                   	push   ebx
    2a21:	51                   	push   ecx
    2a22:	52                   	push   edx
    2a23:	50                   	push   eax
    2a24:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2a27:	68 52 05 00 00       	push   0x552
    2a2c:	e8 fc ff ff ff       	call   2a2d <print_stacktrace+0x78>
    2a31:	83 c4 20             	add    esp,0x20
										fp->args[2], fp->args[3], fp->ret_addr);
						sym = (const char*)elf_get_closest_symbol(fp->ret_addr, &of);
    2a34:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a37:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2a3a:	83 ec 08             	sub    esp,0x8
    2a3d:	8d 55 dc             	lea    edx,[ebp-0x24]
    2a40:	52                   	push   edx
    2a41:	50                   	push   eax
    2a42:	e8 fc ff ff ff       	call   2a43 <print_stacktrace+0x8e>
    2a47:	83 c4 10             	add    esp,0x10
    2a4a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						cprintf(KFMT_INFO, "called from %p (%s%+#lx)\n", fp->ret_addr, sym, of);
    2a4d:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2a50:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a53:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2a56:	83 ec 0c             	sub    esp,0xc
    2a59:	52                   	push   edx
    2a5a:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    2a5d:	50                   	push   eax
    2a5e:	68 65 05 00 00       	push   0x565
    2a63:	6a 0b                	push   0xb
    2a65:	e8 fc ff ff ff       	call   2a66 <print_stacktrace+0xb1>
    2a6a:	83 c4 20             	add    esp,0x20
						extern void _start();
						if (fp->ret_addr - 5 == (void*)&_start)
    2a6d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a70:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2a73:	83 e8 05             	sub    eax,0x5
    2a76:	3d 00 00 00 00       	cmp    eax,0x0
    2a7b:	74 1e                	je     2a9b <print_stacktrace+0xe6>
								break; /* only until call to kmain */
						else if (!fp->ret_addr)
    2a7d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a80:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2a83:	85 c0                	test   eax,eax
    2a85:	74 17                	je     2a9e <print_stacktrace+0xe9>
								break;
						fp = fp->prev;
    2a87:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a8a:	8b 00                	mov    eax,DWORD PTR [eax]
    2a8c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				} while (fp);
    2a8f:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2a93:	0f 85 65 ff ff ff    	jne    29fe <print_stacktrace+0x49>
    2a99:	eb 04                	jmp    2a9f <print_stacktrace+0xea>
								break; /* only until call to kmain */
    2a9b:	90                   	nop
    2a9c:	eb 01                	jmp    2a9f <print_stacktrace+0xea>
								break;
    2a9e:	90                   	nop
				framebuffer_redraw(&fb_initial);
    2a9f:	83 ec 0c             	sub    esp,0xc
    2aa2:	68 00 00 00 00       	push   0x0
    2aa7:	e8 fc ff ff ff       	call   2aa8 <print_stacktrace+0xf3>
    2aac:	83 c4 10             	add    esp,0x10
    2aaf:	eb 2b                	jmp    2adc <print_stacktrace+0x127>
		} else
				die("stacktrace loop!\n");
    2ab1:	83 ec 08             	sub    esp,0x8
    2ab4:	68 7f 05 00 00       	push   0x57f
    2ab9:	6a 0c                	push   0xc
    2abb:	e8 fc ff ff ff       	call   2abc <print_stacktrace+0x107>
    2ac0:	83 c4 10             	add    esp,0x10
    2ac3:	e8 fc ff ff ff       	call   2ac4 <print_stacktrace+0x10f>
    2ac8:	83 ec 0c             	sub    esp,0xc
    2acb:	68 00 00 00 00       	push   0x0
    2ad0:	e8 fc ff ff ff       	call   2ad1 <print_stacktrace+0x11c>
    2ad5:	83 c4 10             	add    esp,0x10
    2ad8:	fa                   	cli
    2ad9:	f4                   	hlt
    2ada:	eb fd                	jmp    2ad9 <print_stacktrace+0x124>
		/* now offer basic diag */
print_help:
		printf("Debug diagnostics mode with following commands:\n"
    2adc:	83 ec 0c             	sub    esp,0xc
    2adf:	68 94 05 00 00       	push   0x594
    2ae4:	e8 fc ff ff ff       	call   2ae5 <print_stacktrace+0x130>
    2ae9:	83 c4 10             	add    esp,0x10
				"\tm                   Display symbol map\n"
				"\tk                   Reprint the stack trace\n"
				"\th(elp)              Display this help message\n"
				"\th(a)lt              Turns off the computer\n"
				"\tl Address           Find symbol below/at Address\n");
		framebuffer_redraw(&fb_initial);
    2aec:	83 ec 0c             	sub    esp,0xc
    2aef:	68 00 00 00 00       	push   0x0
    2af4:	e8 fc ff ff ff       	call   2af5 <print_stacktrace+0x140>
    2af9:	83 c4 10             	add    esp,0x10
		while (1) {
				char* str = 0; size_t n = 0;
    2afc:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    2b03:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
				printf("enter command:\n");
    2b0a:	83 ec 0c             	sub    esp,0xc
    2b0d:	68 ff 06 00 00       	push   0x6ff
    2b12:	e8 fc ff ff ff       	call   2b13 <print_stacktrace+0x15e>
    2b17:	83 c4 10             	add    esp,0x10
				framebuffer_redraw(&fb_initial);
    2b1a:	83 ec 0c             	sub    esp,0xc
    2b1d:	68 00 00 00 00       	push   0x0
    2b22:	e8 fc ff ff ff       	call   2b23 <print_stacktrace+0x16e>
    2b27:	83 c4 10             	add    esp,0x10
				getline(&str, &n);
    2b2a:	83 ec 08             	sub    esp,0x8
    2b2d:	8d 45 d4             	lea    eax,[ebp-0x2c]
    2b30:	50                   	push   eax
    2b31:	8d 45 d8             	lea    eax,[ebp-0x28]
    2b34:	50                   	push   eax
    2b35:	e8 fc ff ff ff       	call   2b36 <print_stacktrace+0x181>
    2b3a:	83 c4 10             	add    esp,0x10
				if (str) {
    2b3d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2b40:	85 c0                	test   eax,eax
    2b42:	74 b8                	je     2afc <print_stacktrace+0x147>
						if (strlen(str))
    2b44:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2b47:	83 ec 0c             	sub    esp,0xc
    2b4a:	50                   	push   eax
    2b4b:	e8 fc ff ff ff       	call   2b4c <print_stacktrace+0x197>
    2b50:	83 c4 10             	add    esp,0x10
    2b53:	85 c0                	test   eax,eax
    2b55:	74 1a                	je     2b71 <print_stacktrace+0x1bc>
								str[strlen(str) - 1] = '\0';
    2b57:	8b 5d d8             	mov    ebx,DWORD PTR [ebp-0x28]
    2b5a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2b5d:	83 ec 0c             	sub    esp,0xc
    2b60:	50                   	push   eax
    2b61:	e8 fc ff ff ff       	call   2b62 <print_stacktrace+0x1ad>
    2b66:	83 c4 10             	add    esp,0x10
    2b69:	83 e8 01             	sub    eax,0x1
    2b6c:	01 d8                	add    eax,ebx
    2b6e:	c6 00 00             	mov    BYTE PTR [eax],0x0
						if (strcmp(str, "r") == 0)
    2b71:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2b74:	83 ec 08             	sub    esp,0x8
    2b77:	68 0f 07 00 00       	push   0x70f
    2b7c:	50                   	push   eax
    2b7d:	e8 fc ff ff ff       	call   2b7e <print_stacktrace+0x1c9>
    2b82:	83 c4 10             	add    esp,0x10
    2b85:	85 c0                	test   eax,eax
    2b87:	75 15                	jne    2b9e <print_stacktrace+0x1e9>
								printf("registers: \n");
    2b89:	83 ec 0c             	sub    esp,0xc
    2b8c:	68 11 07 00 00       	push   0x711
    2b91:	e8 fc ff ff ff       	call   2b92 <print_stacktrace+0x1dd>
    2b96:	83 c4 10             	add    esp,0x10
    2b99:	e9 d5 01 00 00       	jmp    2d73 <print_stacktrace+0x3be>
						else if (strcmp(str, "k") == 0)
    2b9e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2ba1:	83 ec 08             	sub    esp,0x8
    2ba4:	68 1e 07 00 00       	push   0x71e
    2ba9:	50                   	push   eax
    2baa:	e8 fc ff ff ff       	call   2bab <print_stacktrace+0x1f6>
    2baf:	83 c4 10             	add    esp,0x10
    2bb2:	85 c0                	test   eax,eax
    2bb4:	75 05                	jne    2bbb <print_stacktrace+0x206>
    2bb6:	e9 1e fe ff ff       	jmp    29d9 <print_stacktrace+0x24>
								goto print_st;
						else if (strcmp(str, "m") == 0)
    2bbb:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2bbe:	83 ec 08             	sub    esp,0x8
    2bc1:	68 20 07 00 00       	push   0x720
    2bc6:	50                   	push   eax
    2bc7:	e8 fc ff ff ff       	call   2bc8 <print_stacktrace+0x213>
    2bcc:	83 c4 10             	add    esp,0x10
    2bcf:	85 c0                	test   eax,eax
    2bd1:	75 15                	jne    2be8 <print_stacktrace+0x233>
								printf("Symbol map: \n");
    2bd3:	83 ec 0c             	sub    esp,0xc
    2bd6:	68 22 07 00 00       	push   0x722
    2bdb:	e8 fc ff ff ff       	call   2bdc <print_stacktrace+0x227>
    2be0:	83 c4 10             	add    esp,0x10
    2be3:	e9 8b 01 00 00       	jmp    2d73 <print_stacktrace+0x3be>
						else if (strncmp(str, "l ", 2) == 0) {
    2be8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2beb:	83 ec 04             	sub    esp,0x4
    2bee:	6a 02                	push   0x2
    2bf0:	68 30 07 00 00       	push   0x730
    2bf5:	50                   	push   eax
    2bf6:	e8 fc ff ff ff       	call   2bf7 <print_stacktrace+0x242>
    2bfb:	83 c4 10             	add    esp,0x10
    2bfe:	85 c0                	test   eax,eax
    2c00:	75 4b                	jne    2c4d <print_stacktrace+0x298>
								long int addr = strtol(str + 2, NULL, 0);
    2c02:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2c05:	83 c0 02             	add    eax,0x2
    2c08:	83 ec 04             	sub    esp,0x4
    2c0b:	6a 00                	push   0x0
    2c0d:	6a 00                	push   0x0
    2c0f:	50                   	push   eax
    2c10:	e8 fc ff ff ff       	call   2c11 <print_stacktrace+0x25c>
    2c15:	83 c4 10             	add    esp,0x10
    2c18:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								const char* sym; size_t of;
								sym = (const char*)elf_get_closest_symbol((void*)addr, &of);
    2c1b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2c1e:	83 ec 08             	sub    esp,0x8
    2c21:	8d 55 d0             	lea    edx,[ebp-0x30]
    2c24:	52                   	push   edx
    2c25:	50                   	push   eax
    2c26:	e8 fc ff ff ff       	call   2c27 <print_stacktrace+0x272>
    2c2b:	83 c4 10             	add    esp,0x10
    2c2e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								printf("Address is located at %s%+#lx\n", sym, of);
    2c31:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2c34:	83 ec 04             	sub    esp,0x4
    2c37:	50                   	push   eax
    2c38:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    2c3b:	68 34 07 00 00       	push   0x734
    2c40:	e8 fc ff ff ff       	call   2c41 <print_stacktrace+0x28c>
    2c45:	83 c4 10             	add    esp,0x10
    2c48:	e9 26 01 00 00       	jmp    2d73 <print_stacktrace+0x3be>
						} else if (strncmp(str, "db ", 3) == 0) {
    2c4d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2c50:	83 ec 04             	sub    esp,0x4
    2c53:	6a 03                	push   0x3
    2c55:	68 53 07 00 00       	push   0x753
    2c5a:	50                   	push   eax
    2c5b:	e8 fc ff ff ff       	call   2c5c <print_stacktrace+0x2a7>
    2c60:	83 c4 10             	add    esp,0x10
    2c63:	85 c0                	test   eax,eax
    2c65:	75 5d                	jne    2cc4 <print_stacktrace+0x30f>
								char* end;
								long int addr = strtol(str + 3, &end, 0), cap = 512;
    2c67:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2c6a:	8d 50 03             	lea    edx,[eax+0x3]
    2c6d:	83 ec 04             	sub    esp,0x4
    2c70:	6a 00                	push   0x0
    2c72:	8d 45 cc             	lea    eax,[ebp-0x34]
    2c75:	50                   	push   eax
    2c76:	52                   	push   edx
    2c77:	e8 fc ff ff ff       	call   2c78 <print_stacktrace+0x2c3>
    2c7c:	83 c4 10             	add    esp,0x10
    2c7f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    2c82:	c7 45 f0 00 02 00 00 	mov    DWORD PTR [ebp-0x10],0x200
								if (*end == ' ')
    2c89:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2c8c:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2c8f:	3c 20                	cmp    al,0x20
    2c91:	75 19                	jne    2cac <print_stacktrace+0x2f7>
										cap = strtol(end + 1, NULL, 0);
    2c93:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2c96:	83 c0 01             	add    eax,0x1
    2c99:	83 ec 04             	sub    esp,0x4
    2c9c:	6a 00                	push   0x0
    2c9e:	6a 00                	push   0x0
    2ca0:	50                   	push   eax
    2ca1:	e8 fc ff ff ff       	call   2ca2 <print_stacktrace+0x2ed>
    2ca6:	83 c4 10             	add    esp,0x10
    2ca9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								memdump((void*)addr, cap);
    2cac:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2caf:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2cb2:	83 ec 08             	sub    esp,0x8
    2cb5:	52                   	push   edx
    2cb6:	50                   	push   eax
    2cb7:	e8 fc ff ff ff       	call   2cb8 <print_stacktrace+0x303>
    2cbc:	83 c4 10             	add    esp,0x10
    2cbf:	e9 af 00 00 00       	jmp    2d73 <print_stacktrace+0x3be>
						} else if (strcmp(str, "dpt") == 0) {
    2cc4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2cc7:	83 ec 08             	sub    esp,0x8
    2cca:	68 57 07 00 00       	push   0x757
    2ccf:	50                   	push   eax
    2cd0:	e8 fc ff ff ff       	call   2cd1 <print_stacktrace+0x31c>
    2cd5:	83 c4 10             	add    esp,0x10
    2cd8:	85 c0                	test   eax,eax
    2cda:	75 15                	jne    2cf1 <print_stacktrace+0x33c>
								printf("dumping page table\n");
    2cdc:	83 ec 0c             	sub    esp,0xc
    2cdf:	68 5b 07 00 00       	push   0x75b
    2ce4:	e8 fc ff ff ff       	call   2ce5 <print_stacktrace+0x330>
    2ce9:	83 c4 10             	add    esp,0x10
    2cec:	e9 82 00 00 00       	jmp    2d73 <print_stacktrace+0x3be>
						} else if (strcmp(str, "help") == 0 || strcmp(str, "h") == 0)
    2cf1:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2cf4:	83 ec 08             	sub    esp,0x8
    2cf7:	68 6f 07 00 00       	push   0x76f
    2cfc:	50                   	push   eax
    2cfd:	e8 fc ff ff ff       	call   2cfe <print_stacktrace+0x349>
    2d02:	83 c4 10             	add    esp,0x10
    2d05:	85 c0                	test   eax,eax
    2d07:	0f 84 cf fd ff ff    	je     2adc <print_stacktrace+0x127>
    2d0d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d10:	83 ec 08             	sub    esp,0x8
    2d13:	68 74 07 00 00       	push   0x774
    2d18:	50                   	push   eax
    2d19:	e8 fc ff ff ff       	call   2d1a <print_stacktrace+0x365>
    2d1e:	83 c4 10             	add    esp,0x10
    2d21:	85 c0                	test   eax,eax
    2d23:	75 05                	jne    2d2a <print_stacktrace+0x375>
    2d25:	e9 b2 fd ff ff       	jmp    2adc <print_stacktrace+0x127>
								goto print_help;
						else if (strcmp(str, "halt") == 0 || strcmp(str, "hlt") == 0)
    2d2a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d2d:	83 ec 08             	sub    esp,0x8
    2d30:	68 76 07 00 00       	push   0x776
    2d35:	50                   	push   eax
    2d36:	e8 fc ff ff ff       	call   2d37 <print_stacktrace+0x382>
    2d3b:	83 c4 10             	add    esp,0x10
    2d3e:	85 c0                	test   eax,eax
    2d40:	74 18                	je     2d5a <print_stacktrace+0x3a5>
    2d42:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d45:	83 ec 08             	sub    esp,0x8
    2d48:	68 7b 07 00 00       	push   0x77b
    2d4d:	50                   	push   eax
    2d4e:	e8 fc ff ff ff       	call   2d4f <print_stacktrace+0x39a>
    2d53:	83 c4 10             	add    esp,0x10
    2d56:	85 c0                	test   eax,eax
    2d58:	75 05                	jne    2d5f <print_stacktrace+0x3aa>
								pc_shutdown();
    2d5a:	e8 fc ff ff ff       	call   2d5b <print_stacktrace+0x3a6>
						else
								printf("unknown command \"%s\"\n", str);
    2d5f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d62:	83 ec 08             	sub    esp,0x8
    2d65:	50                   	push   eax
    2d66:	68 7f 07 00 00       	push   0x77f
    2d6b:	e8 fc ff ff ff       	call   2d6c <print_stacktrace+0x3b7>
    2d70:	83 c4 10             	add    esp,0x10
						kfree(str);
    2d73:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2d76:	83 ec 0c             	sub    esp,0xc
    2d79:	50                   	push   eax
    2d7a:	e8 fc ff ff ff       	call   2d7b <print_stacktrace+0x3c6>
    2d7f:	83 c4 10             	add    esp,0x10
		while (1) {
    2d82:	e9 75 fd ff ff       	jmp    2afc <print_stacktrace+0x147>

00002d87 <mm_idt_init>:
		}
		stc--;
}

void mm_idt_init()
{
    2d87:	55                   	push   ebp
    2d88:	89 e5                	mov    ebp,esp
    2d8a:	83 ec 08             	sub    esp,0x8
		extern void idt_init();
		mm_protect(&mm_kernel, idt, 1, MMGR_MAP_SET | MMGR_MAP_WRITE);
    2d8d:	a1 00 00 00 00       	mov    eax,ds:0x0
    2d92:	68 04 10 00 00       	push   0x1004
    2d97:	6a 01                	push   0x1
    2d99:	50                   	push   eax
    2d9a:	68 00 00 00 00       	push   0x0
    2d9f:	e8 fc ff ff ff       	call   2da0 <mm_idt_init+0x19>
    2da4:	83 c4 10             	add    esp,0x10
		flush_tlb_single(idt);
    2da7:	a1 00 00 00 00       	mov    eax,ds:0x0
    2dac:	83 ec 0c             	sub    esp,0xc
    2daf:	50                   	push   eax
    2db0:	e8 5f d2 ff ff       	call   14 <flush_tlb_single>
    2db5:	83 c4 10             	add    esp,0x10
		idt_init();
    2db8:	e8 fc ff ff ff       	call   2db9 <mm_idt_init+0x32>
		mm_protect(&mm_kernel, idt, 1, MMGR_MAP_UNSET | MMGR_MAP_WRITE);
    2dbd:	a1 00 00 00 00       	mov    eax,ds:0x0
    2dc2:	68 04 20 00 00       	push   0x2004
    2dc7:	6a 01                	push   0x1
    2dc9:	50                   	push   eax
    2dca:	68 00 00 00 00       	push   0x0
    2dcf:	e8 fc ff ff ff       	call   2dd0 <mm_idt_init+0x49>
    2dd4:	83 c4 10             	add    esp,0x10
		flush_tlb_single(idt);
    2dd7:	a1 00 00 00 00       	mov    eax,ds:0x0
    2ddc:	83 ec 0c             	sub    esp,0xc
    2ddf:	50                   	push   eax
    2de0:	e8 2f d2 ff ff       	call   14 <flush_tlb_single>
    2de5:	83 c4 10             	add    esp,0x10
}
    2de8:	90                   	nop
    2de9:	c9                   	leave
    2dea:	c3                   	ret
