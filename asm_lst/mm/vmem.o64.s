
mm/vmem.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <per_cpu_ptr>:
				return NULL;
		}
		*b = pr.base;

		/* reserve and map the virtual memory */
		rv = __sync_fetch_and_sub(pp, 4096);
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 10          	sub    rsp,0x10
		if (rv < VM_TABLE_LIMIT) {
				die("Out of virtual memory for paging structures.\n");
				return NULL;
       8:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
      11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		}
		mm_map(&mm_kernel, rv, &pr, 1, MMGR_MAP_WRITE
						| MMGR_MAP_KERNEL /*| MMGR_MAP_GLOBAL*/);

      15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
		return rv;
      19:	c9                   	leave
      1a:	c3                   	ret

000000000000001b <flush_tlb_single>:
{
      1b:	55                   	push   rbp
      1c:	48 89 e5             	mov    rbp,rsp
      1f:	48 83 ec 08          	sub    rsp,0x8
      23:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		__sync_fetch_and_add(&tlb_flush_ct, 1);
      27:	f0 48 83 05 00 00 00 00 01 	lock add QWORD PTR [rip+0x0],0x1        # 30 <flush_tlb_single+0x15>
		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
      30:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      34:	0f 01 38             	invlpg BYTE PTR [rax]
}
      37:	90                   	nop
      38:	c9                   	leave
      39:	c3                   	ret

000000000000003a <flush_tlb_full>:
{
      3a:	55                   	push   rbp
      3b:	48 89 e5             	mov    rbp,rsp
		asm volatile("mov %%cr3, %%rax\nmov %%rax, %%cr3\n" : : : "%eax");
      3e:	0f 20 d8             	mov    rax,cr3
      41:	0f 22 d8             	mov    cr3,rax
}
      44:	90                   	nop
      45:	5d                   	pop    rbp
      46:	c3                   	ret

0000000000000047 <mm_alloc_page>:
{
      47:	55                   	push   rbp
      48:	48 89 e5             	mov    rbp,rsp
      4b:	48 83 ec 30          	sub    rsp,0x30
      4f:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		pp = &((struct vm_pg_ptrs64*)mm_kernel.ctx)->cur;
      53:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 5a <mm_alloc_page+0x13>
      5a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!mm_alloc_pm(1, &pr, 1)) {
      5e:	48 8d 45 e0          	lea    rax,[rbp-0x20]
      62:	ba 01 00 00 00       	mov    edx,0x1
      67:	48 89 c6             	mov    rsi,rax
      6a:	bf 01 00 00 00       	mov    edi,0x1
      6f:	e8 00 00 00 00       	call   74 <mm_alloc_page+0x2d>
      74:	85 c0                	test   eax,eax
      76:	75 30                	jne    a8 <mm_alloc_page+0x61>
				die("Unable to allocate PM for paging strucures.\n");
      78:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
      7f:	bf 0c 00 00 00       	mov    edi,0xc
      84:	b8 00 00 00 00       	mov    eax,0x0
      89:	e8 00 00 00 00       	call   8e <mm_alloc_page+0x47>
      8e:	b8 00 00 00 00       	mov    eax,0x0
      93:	e8 00 00 00 00       	call   98 <mm_alloc_page+0x51>
      98:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
      9f:	e8 00 00 00 00       	call   a4 <mm_alloc_page+0x5d>
      a4:	fa                   	cli
      a5:	f4                   	hlt
      a6:	eb fd                	jmp    a5 <mm_alloc_page+0x5e>
		*b = pr.base;
      a8:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
      ac:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      b0:	48 89 10             	mov    QWORD PTR [rax],rdx
		rv = __sync_fetch_and_sub(pp, 4096);
      b3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      b7:	ba 00 10 00 00       	mov    edx,0x1000
      bc:	48 f7 da             	neg    rdx
      bf:	f0 48 0f c1 10       	lock xadd QWORD PTR [rax],rdx
      c4:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
		if (rv < VM_TABLE_LIMIT) {
      c8:	48 81 7d f0 ff ff ff fd 	cmp    QWORD PTR [rbp-0x10],0xfffffffffdffffff
      d0:	77 30                	ja     102 <mm_alloc_page+0xbb>
				die("Out of virtual memory for paging structures.\n");
      d2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
      d9:	bf 0c 00 00 00       	mov    edi,0xc
      de:	b8 00 00 00 00       	mov    eax,0x0
      e3:	e8 00 00 00 00       	call   e8 <mm_alloc_page+0xa1>
      e8:	b8 00 00 00 00       	mov    eax,0x0
      ed:	e8 00 00 00 00       	call   f2 <mm_alloc_page+0xab>
      f2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
      f9:	e8 00 00 00 00       	call   fe <mm_alloc_page+0xb7>
      fe:	fa                   	cli
      ff:	f4                   	hlt
     100:	eb fd                	jmp    ff <mm_alloc_page+0xb8>
		mm_map(&mm_kernel, rv, &pr, 1, MMGR_MAP_WRITE
     102:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
     106:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     10a:	41 b8 0c 00 00 00    	mov    r8d,0xc
     110:	b9 01 00 00 00       	mov    ecx,0x1
     115:	48 89 c6             	mov    rsi,rax
     118:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     11f:	e8 00 00 00 00       	call   124 <mm_alloc_page+0xdd>
		return rv;
     124:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
}
     128:	c9                   	leave
     129:	c3                   	ret

000000000000012a <mm_map64>:

#ifdef __x86_64__
void* mm_map64(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
{
     12a:	55                   	push   rbp
     12b:	48 89 e5             	mov    rbp,rsp
     12e:	48 81 ec c0 00 00 00 	sub    rsp,0xc0
     135:	48 89 bd 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdi
     13c:	48 89 b5 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rsi
     143:	48 89 95 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdx
     14a:	48 89 8d 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rcx
     151:	44 89 85 4c ff ff ff 	mov    DWORD PTR [rbp-0xb4],r8d
     158:	44 89 8d 48 ff ff ff 	mov    DWORD PTR [rbp-0xb8],r9d
		uint64_t low48;
		struct vm_pg_ptrs64* vp = vm_mapping;
     15f:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     166:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		uint32_t pml4e, pdpte, pde, pte;
		struct page_range pr_copy;

		/* physical pointers */
		struct pte64 *p = vp->pml4;
     16a:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     16e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     172:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		struct pte64* pl = 0;
     176:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		struct pte64* pd = 0;
     17e:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		struct pte64* pt = 0;
     186:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
		/* mappings */
		struct vm_pdpte_ptr* m;
		struct vm_pde_ptr* n;

		/* calculate the PML4E */
		low48 = (uint64_t)vaddr & 0x0000ffffffffffff;
     18e:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
     195:	48 ba ff ff ff ff ff ff 00 00 	movabs rdx,0xffffffffffff
     19f:	48 21 d0             	and    rax,rdx
     1a2:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		pml4e = low48 >> 39; /* 512G per PML4E */
     1a6:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     1aa:	48 c1 e8 27          	shr    rax,0x27
     1ae:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax

		/* and the PDPTE */
		pdpte = (low48 & 0x007fc0000000) >> 30; /* 1G per PDPTE */
     1b1:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     1b5:	48 c1 e8 1e          	shr    rax,0x1e
     1b9:	25 ff 01 00 00       	and    eax,0x1ff
     1be:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax

		/* and the PDE */
		pde = (low48 & 0x3fe00000) >> 21; /* 2M per PDE */
     1c1:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     1c5:	48 c1 e8 15          	shr    rax,0x15
     1c9:	25 ff 01 00 00       	and    eax,0x1ff
     1ce:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax

		/* and finally the PTE */
		pte = (low48 & 0x1ff000) >> 12; /* 4K per PTE */
     1d1:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     1d5:	48 c1 e8 0c          	shr    rax,0xc
     1d9:	25 ff 01 00 00       	and    eax,0x1ff
     1de:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax

		/* create one if not there */
new_pdpt:
		if (ENTER_CS_PTE(vp->pml4e[pml4e])) {
     1e1:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     1e4:	48 83 c0 02          	add    rax,0x2
     1e8:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     1f0:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     1f4:	48 01 c2             	add    rdx,rax
     1f7:	b8 00 00 00 00       	mov    eax,0x0
     1fc:	48 c7 c1 ff ff ff ff 	mov    rcx,0xffffffffffffffff
     203:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     208:	0f 94 c0             	sete   al
     20b:	84 c0                	test   al,al
     20d:	0f 84 4e 01 00 00    	je     361 <mm_map64+0x237>
				struct page_range pr2[2];
				/* allocate the PDPT */
				pl = mm_alloc_page(&pr2[0].base);
     213:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
     21a:	48 89 c7             	mov    rdi,rax
     21d:	e8 00 00 00 00       	call   222 <mm_map64+0xf8>
     222:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax

				/* and set the reference in the PML4 */
				p[pml4e].addr = pr2[0].base / 4096;
     226:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     22d:	48 c1 e8 0c          	shr    rax,0xc
     231:	48 89 c1             	mov    rcx,rax
     234:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     237:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     23f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     243:	48 01 d0             	add    rax,rdx
     246:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     250:	48 21 d1             	and    rcx,rdx
     253:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     25d:	48 21 ca             	and    rdx,rcx
     260:	48 c1 e2 0c          	shl    rdx,0xc
     264:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     267:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
     271:	48 21 f1             	and    rcx,rsi
     274:	48 09 ca             	or     rdx,rcx
     277:	48 89 10             	mov    QWORD PTR [rax],rdx
				p[pml4e].u = 1;
     27a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     27d:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     285:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     289:	48 01 d0             	add    rax,rdx
     28c:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     28f:	83 ca 04             	or     edx,0x4
     292:	88 10                	mov    BYTE PTR [rax],dl
				p[pml4e].w = 1;
     294:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     297:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     29f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     2a3:	48 01 d0             	add    rax,rdx
     2a6:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     2a9:	83 ca 02             	or     edx,0x2
     2ac:	88 10                	mov    BYTE PTR [rax],dl
				p[pml4e].p = 1;
     2ae:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     2b1:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     2b9:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     2bd:	48 01 d0             	add    rax,rdx
     2c0:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     2c3:	83 ca 01             	or     edx,0x1
     2c6:	88 10                	mov    BYTE PTR [rax],dl

				/* now allocate the map (2 pages) */
				mm_alloc_pm(2, pr2, 2); /* not cont. as only virt access */
     2c8:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
     2cf:	ba 02 00 00 00       	mov    edx,0x2
     2d4:	48 89 c6             	mov    rsi,rax
     2d7:	bf 02 00 00 00       	mov    edi,0x2
     2dc:	e8 00 00 00 00       	call   2e1 <mm_map64+0x1b7>
				m = __sync_fetch_and_sub(&vp->cur, 8096) - 4096;
     2e1:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     2e5:	ba a0 1f 00 00       	mov    edx,0x1fa0
     2ea:	48 f7 da             	neg    rdx
     2ed:	f0 48 0f c1 10       	lock xadd QWORD PTR [rax],rdx
     2f2:	48 8d 82 00 f0 ff ff 	lea    rax,[rdx-0x1000]
     2f9:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				mm_map(&mm_kernel, m, pr2, pr2[0].count > 1 ? 1 : 2,
     2fd:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     304:	48 83 f8 01          	cmp    rax,0x1
     308:	76 07                	jbe    311 <mm_map64+0x1e7>
     30a:	b9 01 00 00 00       	mov    ecx,0x1
     30f:	eb 05                	jmp    316 <mm_map64+0x1ec>
     311:	b9 02 00 00 00       	mov    ecx,0x2
     316:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
     31d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     321:	41 b8 0c 00 00 00    	mov    r8d,0xc
     327:	48 89 c6             	mov    rsi,rax
     32a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     331:	e8 00 00 00 00       	call   336 <mm_map64+0x20c>
								MMGR_MAP_WRITE | MMGR_MAP_KERNEL /*| MMGR_MAP_GLOBAL*/);
				vp->pdpte[pml4e] = m;
     336:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     33a:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     33d:	48 8d 8a 02 02 00 00 	lea    rcx,[rdx+0x202]
     344:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
     348:	48 89 14 c8          	mov    QWORD PTR [rax+rcx*8],rdx

				/* release the CS */
				vp->pml4e[pml4e] = pl;
     34c:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     350:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     353:	48 8d 4a 02          	lea    rcx,[rdx+0x2]
     357:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     35b:	48 89 14 c8          	mov    QWORD PTR [rax+rcx*8],rdx
     35f:	eb 32                	jmp    393 <mm_map64+0x269>

		} else {
				/* wait for valid entry */
				SPIN_CS(vp->pml4e[pml4e]);
     361:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     364:	48 83 c0 02          	add    rax,0x2
     368:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     370:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     374:	48 01 d0             	add    rax,rdx
     377:	48 8b 00             	mov    rax,QWORD PTR [rax]
     37a:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
     37e:	74 e1                	je     361 <mm_map64+0x237>
				pl = vp->pml4e[pml4e];
     380:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     384:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     387:	48 83 c2 02          	add    rdx,0x2
     38b:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     38f:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		}
		/* fetch the map */
		m = vp->pdpte[pml4e];
     393:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     397:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     39a:	48 81 c2 02 02 00 00 	add    rdx,0x202
     3a1:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     3a5:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax

		/* now go on to the page directory */
new_pd:
		if (ENTER_CS_PTE(m->pds[pdpte])) {
     3a9:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     3ac:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     3b4:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     3b8:	48 01 c2             	add    rdx,rax
     3bb:	b8 00 00 00 00       	mov    eax,0x0
     3c0:	48 c7 c1 ff ff ff ff 	mov    rcx,0xffffffffffffffff
     3c7:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     3cc:	0f 94 c0             	sete   al
     3cf:	84 c0                	test   al,al
     3d1:	0f 84 e6 00 00 00    	je     4bd <mm_map64+0x393>
				uint64_t b;
				/* allocate a page directory */
				pd = mm_alloc_page(&b);
     3d7:	48 8d 45 98          	lea    rax,[rbp-0x68]
     3db:	48 89 c7             	mov    rdi,rax
     3de:	e8 00 00 00 00       	call   3e3 <mm_map64+0x2b9>
     3e3:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax

				/* and set the reference in the PDPT */
				pl[pdpte].addr = b / 4096;
     3e7:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     3eb:	48 c1 e8 0c          	shr    rax,0xc
     3ef:	48 89 c1             	mov    rcx,rax
     3f2:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     3f5:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     3fd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     401:	48 01 d0             	add    rax,rdx
     404:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     40e:	48 21 d1             	and    rcx,rdx
     411:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     41b:	48 21 ca             	and    rdx,rcx
     41e:	48 c1 e2 0c          	shl    rdx,0xc
     422:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     425:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
     42f:	48 21 f1             	and    rcx,rsi
     432:	48 09 ca             	or     rdx,rcx
     435:	48 89 10             	mov    QWORD PTR [rax],rdx
				pl[pdpte].u = 1;
     438:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     43b:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     443:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     447:	48 01 d0             	add    rax,rdx
     44a:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     44d:	83 ca 04             	or     edx,0x4
     450:	88 10                	mov    BYTE PTR [rax],dl
				pl[pdpte].w = 1;
     452:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     455:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     45d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     461:	48 01 d0             	add    rax,rdx
     464:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     467:	83 ca 02             	or     edx,0x2
     46a:	88 10                	mov    BYTE PTR [rax],dl
				pl[pdpte].p = 1;
     46c:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     46f:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     477:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     47b:	48 01 d0             	add    rax,rdx
     47e:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     481:	83 ca 01             	or     edx,0x1
     484:	88 10                	mov    BYTE PTR [rax],dl

				/* now allocate the map */
				n = mm_alloc_page(&b);
     486:	48 8d 45 98          	lea    rax,[rbp-0x68]
     48a:	48 89 c7             	mov    rdi,rax
     48d:	e8 00 00 00 00       	call   492 <mm_map64+0x368>
     492:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
				m->pdes[pdpte] = n;
     496:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     49a:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
     49d:	48 8d 8a 00 02 00 00 	lea    rcx,[rdx+0x200]
     4a4:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     4a8:	48 89 14 c8          	mov    QWORD PTR [rax+rcx*8],rdx

				/* release the CS */
				m->pds[pdpte] = pd;
     4ac:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     4b0:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
     4b3:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     4b7:	48 89 0c d0          	mov    QWORD PTR [rax+rdx*8],rcx
     4bb:	eb 2a                	jmp    4e7 <mm_map64+0x3bd>

		} else {
				SPIN_CS(m->pds[pdpte]);
     4bd:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     4c0:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     4c8:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     4cc:	48 01 d0             	add    rax,rdx
     4cf:	48 8b 00             	mov    rax,QWORD PTR [rax]
     4d2:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
     4d6:	74 e5                	je     4bd <mm_map64+0x393>
				pd = m->pds[pdpte];
     4d8:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     4dc:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
     4df:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     4e3:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		}
		/* fetch the map */
		n = m->pdes[pdpte];
     4e7:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     4eb:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
     4ee:	48 81 c2 00 02 00 00 	add    rdx,0x200
     4f5:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     4f9:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax

		/* now select the page table */
new_pt:
		if (ENTER_CS_PTE(n->pts[pde])) {
     4fd:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     500:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     508:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     50c:	48 01 c2             	add    rdx,rax
     50f:	b8 00 00 00 00       	mov    eax,0x0
     514:	48 c7 c1 ff ff ff ff 	mov    rcx,0xffffffffffffffff
     51b:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     520:	0f 94 c0             	sete   al
     523:	84 c0                	test   al,al
     525:	0f 84 c0 00 00 00    	je     5eb <mm_map64+0x4c1>
				uint64_t b;
				/* allocate a page table */
				pt = mm_alloc_page(&b);
     52b:	48 8d 45 90          	lea    rax,[rbp-0x70]
     52f:	48 89 c7             	mov    rdi,rax
     532:	e8 00 00 00 00       	call   537 <mm_map64+0x40d>
     537:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax

				/* and set the reference in the PD */
				pd[pde].addr = b / 4096;
     53b:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     53f:	48 c1 e8 0c          	shr    rax,0xc
     543:	48 89 c1             	mov    rcx,rax
     546:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     549:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     551:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     555:	48 01 d0             	add    rax,rdx
     558:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     562:	48 21 d1             	and    rcx,rdx
     565:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     56f:	48 21 ca             	and    rdx,rcx
     572:	48 c1 e2 0c          	shl    rdx,0xc
     576:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     579:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
     583:	48 21 f1             	and    rcx,rsi
     586:	48 09 ca             	or     rdx,rcx
     589:	48 89 10             	mov    QWORD PTR [rax],rdx
				pd[pde].u = 1;
     58c:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     58f:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     597:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     59b:	48 01 d0             	add    rax,rdx
     59e:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     5a1:	83 ca 04             	or     edx,0x4
     5a4:	88 10                	mov    BYTE PTR [rax],dl
				pd[pde].w = 1;
     5a6:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     5a9:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     5b1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5b5:	48 01 d0             	add    rax,rdx
     5b8:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     5bb:	83 ca 02             	or     edx,0x2
     5be:	88 10                	mov    BYTE PTR [rax],dl
				pd[pde].p = 1;
     5c0:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     5c3:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     5cb:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5cf:	48 01 d0             	add    rax,rdx
     5d2:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     5d5:	83 ca 01             	or     edx,0x1
     5d8:	88 10                	mov    BYTE PTR [rax],dl

				/* release the CS */
				n->pts[pde] = pt;
     5da:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     5de:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
     5e1:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
     5e5:	48 89 0c d0          	mov    QWORD PTR [rax+rdx*8],rcx
     5e9:	eb 2a                	jmp    615 <mm_map64+0x4eb>

		} else {
				SPIN_CS(n->pts[pde]);
     5eb:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     5ee:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     5f6:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     5fa:	48 01 d0             	add    rax,rdx
     5fd:	48 8b 00             	mov    rax,QWORD PTR [rax]
     600:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
     604:	74 e5                	je     5eb <mm_map64+0x4c1>
				pt = n->pts[pde];
     606:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     60a:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
     60d:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     611:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
		}

		/* now map the pages */
		pr_copy = *pr++;
     615:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     61c:	48 8d 50 10          	lea    rdx,[rax+0x10]
     620:	48 89 95 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdx
     627:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     62b:	48 8b 00             	mov    rax,QWORD PTR [rax]
     62e:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
     632:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
		while (prc) {
     636:	e9 19 03 00 00       	jmp    954 <mm_map64+0x82a>
				pt[pte].addr = pr_copy.base / 4096;
     63b:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     63f:	48 c1 e8 0c          	shr    rax,0xc
     643:	48 89 c1             	mov    rcx,rax
     646:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     649:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     651:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     655:	48 01 d0             	add    rax,rdx
     658:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     662:	48 21 d1             	and    rcx,rdx
     665:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     66f:	48 21 ca             	and    rdx,rcx
     672:	48 c1 e2 0c          	shl    rdx,0xc
     676:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     679:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
     683:	48 21 f1             	and    rcx,rsi
     686:	48 09 ca             	or     rdx,rcx
     689:	48 89 10             	mov    QWORD PTR [rax],rdx
				pt[pte].u = 1; /* FIXME: for now (u ? 1 : 0) */
     68c:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     68f:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     697:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     69b:	48 01 d0             	add    rax,rdx
     69e:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     6a1:	83 ca 04             	or     edx,0x4
     6a4:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].w = (w ? 1 : 0);
     6a6:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     6a9:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     6b1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     6b5:	48 01 d0             	add    rax,rdx
     6b8:	83 bd 48 ff ff ff 00 	cmp    DWORD PTR [rbp-0xb8],0x0
     6bf:	0f 95 c2             	setne  dl
     6c2:	83 e2 01             	and    edx,0x1
     6c5:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
     6c8:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     6cb:	83 e2 fd             	and    edx,0xfffffffd
     6ce:	09 ca                	or     edx,ecx
     6d0:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].p = 1;
     6d2:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     6d5:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     6dd:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     6e1:	48 01 d0             	add    rax,rdx
     6e4:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     6e7:	83 ca 01             	or     edx,0x1
     6ea:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
     6ec:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     6ef:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     6f7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     6fb:	48 01 d0             	add    rax,rdx
     6fe:	83 7d 10 00          	cmp    DWORD PTR [rbp+0x10],0x0
     702:	0f 95 c2             	setne  dl
     705:	89 d1                	mov    ecx,edx
     707:	c1 e1 07             	shl    ecx,0x7
     70a:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     70d:	83 e2 7f             	and    edx,0x7f
     710:	09 ca                	or     edx,ecx
     712:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].wt = (wt ? 1 : 0);
     714:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     717:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     71f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     723:	48 01 d0             	add    rax,rdx
     726:	83 7d 18 00          	cmp    DWORD PTR [rbp+0x18],0x0
     72a:	0f 95 c2             	setne  dl
     72d:	83 e2 01             	and    edx,0x1
     730:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
     737:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     73a:	83 e2 f7             	and    edx,0xfffffff7
     73d:	09 ca                	or     edx,ecx
     73f:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].cd = (cd ? 1 : 0);
     741:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     744:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     74c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     750:	48 01 d0             	add    rax,rdx
     753:	83 7d 20 00          	cmp    DWORD PTR [rbp+0x20],0x0
     757:	0f 95 c2             	setne  dl
     75a:	83 e2 01             	and    edx,0x1
     75d:	89 d1                	mov    ecx,edx
     75f:	c1 e1 04             	shl    ecx,0x4
     762:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     765:	83 e2 ef             	and    edx,0xffffffef
     768:	09 ca                	or     edx,ecx
     76a:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].g = (g ? 1 : 0);
     76c:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     76f:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     777:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     77b:	48 01 d0             	add    rax,rdx
     77e:	83 7d 28 00          	cmp    DWORD PTR [rbp+0x28],0x0
     782:	0f 95 c2             	setne  dl
     785:	89 d1                	mov    ecx,edx
     787:	83 e1 01             	and    ecx,0x1
     78a:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
     78e:	83 e2 fe             	and    edx,0xfffffffe
     791:	09 ca                	or     edx,ecx
     793:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
				pt[pte].u = 1; /* FIXME: for now */
     796:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     799:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     7a1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     7a5:	48 01 d0             	add    rax,rdx
     7a8:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     7ab:	83 ca 04             	or     edx,0x4
     7ae:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].ign = avl & 7;
     7b0:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     7b3:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     7bb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     7bf:	48 01 c2             	add    rdx,rax
     7c2:	8b 45 38             	mov    eax,DWORD PTR [rbp+0x38]
     7c5:	83 e0 07             	and    eax,0x7
     7c8:	83 e0 07             	and    eax,0x7
     7cb:	8d 0c 00             	lea    ecx,[rax+rax*1]
     7ce:	0f b6 42 01          	movzx  eax,BYTE PTR [rdx+0x1]
     7d2:	83 e0 f1             	and    eax,0xfffffff1
     7d5:	09 c8                	or     eax,ecx
     7d7:	88 42 01             	mov    BYTE PTR [rdx+0x1],al
				pt[pte].ign2 = (avl >> 3);
     7da:	8b 45 38             	mov    eax,DWORD PTR [rbp+0x38]
     7dd:	c1 f8 03             	sar    eax,0x3
     7e0:	89 c1                	mov    ecx,eax
     7e2:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     7e5:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     7ed:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     7f1:	48 01 c2             	add    rdx,rax
     7f4:	89 c8                	mov    eax,ecx
     7f6:	66 25 ff 07          	and    ax,0x7ff
     7fa:	66 25 ff 07          	and    ax,0x7ff
     7fe:	c1 e0 04             	shl    eax,0x4
     801:	89 c1                	mov    ecx,eax
     803:	0f b7 42 06          	movzx  eax,WORD PTR [rdx+0x6]
     807:	66 25 0f 80          	and    ax,0x800f
     80b:	09 c8                	or     eax,ecx
     80d:	66 89 42 06          	mov    WORD PTR [rdx+0x6],ax
				if (cpu.e_has_nx)
     811:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 818 <mm_map64+0x6ee>
     818:	83 e0 10             	and    eax,0x10
     81b:	84 c0                	test   al,al
     81d:	74 2d                	je     84c <mm_map64+0x722>
						pt[pte].xd = (x ? 0 : 1);
     81f:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     822:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     82a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     82e:	48 01 d0             	add    rax,rdx
     831:	83 bd 4c ff ff ff 00 	cmp    DWORD PTR [rbp-0xb4],0x0
     838:	0f 94 c2             	sete   dl
     83b:	89 d1                	mov    ecx,edx
     83d:	c1 e1 07             	shl    ecx,0x7
     840:	0f b6 50 07          	movzx  edx,BYTE PTR [rax+0x7]
     844:	83 e2 7f             	and    edx,0x7f
     847:	09 ca                	or     edx,ecx
     849:	88 50 07             	mov    BYTE PTR [rax+0x7],dl
				/* advance */
				if (pte++ == 511) {
     84c:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     84f:	8d 50 01             	lea    edx,[rax+0x1]
     852:	89 55 f0             	mov    DWORD PTR [rbp-0x10],edx
     855:	3d ff 01 00 00       	cmp    eax,0x1ff
     85a:	0f 85 99 00 00 00    	jne    8f9 <mm_map64+0x7cf>
						if (pde++ == 511) {
     860:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     863:	8d 50 01             	lea    edx,[rax+0x1]
     866:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
     869:	3d ff 01 00 00       	cmp    eax,0x1ff
     86e:	75 7d                	jne    8ed <mm_map64+0x7c3>
								if (pdpte++ == 511) {
     870:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     873:	8d 50 01             	lea    edx,[rax+0x1]
     876:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
     879:	3d ff 01 00 00       	cmp    eax,0x1ff
     87e:	75 5a                	jne    8da <mm_map64+0x7b0>
										if (pml4e++ == 511) {
     880:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     883:	8d 50 01             	lea    edx,[rax+0x1]
     886:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
     889:	3d ff 01 00 00       	cmp    eax,0x1ff
     88e:	75 30                	jne    8c0 <mm_map64+0x796>
												die("End of 16E address space\n");
     890:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     897:	bf 0c 00 00 00       	mov    edi,0xc
     89c:	b8 00 00 00 00       	mov    eax,0x0
     8a1:	e8 00 00 00 00       	call   8a6 <mm_map64+0x77c>
     8a6:	b8 00 00 00 00       	mov    eax,0x0
     8ab:	e8 00 00 00 00       	call   8b0 <mm_map64+0x786>
     8b0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     8b7:	e8 00 00 00 00       	call   8bc <mm_map64+0x792>
     8bc:	fa                   	cli
     8bd:	f4                   	hlt
     8be:	eb fd                	jmp    8bd <mm_map64+0x793>
										}
										pdpte = 0;
     8c0:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
										pde = 0;
     8c7:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
										pte = 0;
     8ce:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
										goto new_pdpt;
     8d5:	e9 07 f9 ff ff       	jmp    1e1 <mm_map64+0xb7>
								}
								pde = 0;
     8da:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
								pte = 0;
     8e1:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
								goto new_pd;
     8e8:	e9 bc fa ff ff       	jmp    3a9 <mm_map64+0x27f>
						}
						pte = 0;
     8ed:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
						goto new_pt;
     8f4:	e9 04 fc ff ff       	jmp    4fd <mm_map64+0x3d3>
				}
				pr_copy.base += 4096;
     8f9:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     8fd:	48 05 00 10 00 00    	add    rax,0x1000
     903:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
				if (!--pr_copy.count) {
     907:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     90b:	48 83 e8 01          	sub    rax,0x1
     90f:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
     913:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     917:	48 85 c0             	test   rax,rax
     91a:	75 38                	jne    954 <mm_map64+0x82a>
						if (prc--)
     91c:	48 8b 85 50 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb0]
     923:	48 8d 50 ff          	lea    rdx,[rax-0x1]
     927:	48 89 95 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rdx
     92e:	48 85 c0             	test   rax,rax
     931:	74 21                	je     954 <mm_map64+0x82a>
								pr_copy = *pr++;
     933:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     93a:	48 8d 50 10          	lea    rdx,[rax+0x10]
     93e:	48 89 95 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdx
     945:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     949:	48 8b 00             	mov    rax,QWORD PTR [rax]
     94c:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
     950:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
		while (prc) {
     954:	48 83 bd 50 ff ff ff 00 	cmp    QWORD PTR [rbp-0xb0],0x0
     95c:	0f 85 d9 fc ff ff    	jne    63b <mm_map64+0x511>
				}
		}
		return vaddr;
     962:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
}
     969:	c9                   	leave
     96a:	c3                   	ret

000000000000096b <mm_map>:
map_fun mf_map = NULL;
#endif

void* mm_map(struct mm* mm, void* virt_address,	const struct page_range* prs,
				size_t pr_ct, int flags)
{
     96b:	55                   	push   rbp
     96c:	48 89 e5             	mov    rbp,rsp
     96f:	48 83 ec 60          	sub    rsp,0x60
     973:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     977:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
     97b:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
     97f:	48 89 4d b0          	mov    QWORD PTR [rbp-0x50],rcx
     983:	44 89 45 ac          	mov    DWORD PTR [rbp-0x54],r8d
		int x = flags & MMGR_MAP_EXECUTE, w = flags & MMGR_MAP_WRITE,
     987:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     98a:	83 e0 02             	and    eax,0x2
     98d:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
     990:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     993:	83 e0 04             	and    eax,0x4
     996:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
			wc = flags & MMGR_MAP_PAT, wt = flags & MMGR_MAP_WRITE_THROUGH,
     999:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     99c:	25 80 00 00 00       	and    eax,0x80
     9a1:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
     9a4:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9a7:	83 e0 10             	and    eax,0x10
     9aa:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
			cd = flags & MMGR_MAP_NO_CACHING, g = flags & MMGR_MAP_GLOBAL,
     9ad:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9b0:	83 e0 20             	and    eax,0x20
     9b3:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
     9b6:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9b9:	83 e0 40             	and    eax,0x40
     9bc:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
			u = !(flags & MMGR_MAP_KERNEL);
     9bf:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9c2:	83 e0 08             	and    eax,0x8
     9c5:	85 c0                	test   eax,eax
     9c7:	0f 94 c0             	sete   al
     9ca:	0f b6 c0             	movzx  eax,al
     9cd:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
		int avl = 0;
     9d0:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0

		if (flags & MMGR_MAP_COW) {
     9d7:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9da:	25 00 02 00 00       	and    eax,0x200
     9df:	85 c0                	test   eax,eax
     9e1:	74 0e                	je     9f1 <mm_map+0x86>
				avl = MMGR_AVL_COW;
     9e3:	c7 45 f8 01 00 00 00 	mov    DWORD PTR [rbp-0x8],0x1
				w = 0; /* make COW workable */
     9ea:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		}

		/* get virtutal memory */
		if (!virt_address) {
     9f1:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
     9f6:	75 55                	jne    a4d <mm_map+0xe2>
				size_t pg_ct = 0;
     9f8:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				for (size_t i = 0; i < pr_ct; i++)
     a00:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     a08:	eb 1f                	jmp    a29 <mm_map+0xbe>
						pg_ct += prs[i].count;
     a0a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a0e:	48 c1 e0 04          	shl    rax,0x4
     a12:	48 89 c2             	mov    rdx,rax
     a15:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a19:	48 01 d0             	add    rax,rdx
     a1c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     a20:	48 01 45 f0          	add    QWORD PTR [rbp-0x10],rax
				for (size_t i = 0; i < pr_ct; i++)
     a24:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     a29:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a2d:	48 3b 45 b0          	cmp    rax,QWORD PTR [rbp-0x50]
     a31:	72 d7                	jb     a0a <mm_map+0x9f>
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);
     a33:	8b 55 ac             	mov    edx,DWORD PTR [rbp-0x54]
     a36:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
     a3a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     a3e:	48 89 ce             	mov    rsi,rcx
     a41:	48 89 c7             	mov    rdi,rax
     a44:	e8 00 00 00 00       	call   a49 <mm_map+0xde>
     a49:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		}

#ifdef __x86_64__
		return mm_map64(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
     a4d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     a51:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     a55:	44 8b 4d fc          	mov    r9d,DWORD PTR [rbp-0x4]
     a59:	44 8b 45 e4          	mov    r8d,DWORD PTR [rbp-0x1c]
     a5d:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
     a61:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
     a65:	48 8b 75 c0          	mov    rsi,QWORD PTR [rbp-0x40]
     a69:	8b 7d f8             	mov    edi,DWORD PTR [rbp-0x8]
     a6c:	57                   	push   rdi
     a6d:	8b 7d d0             	mov    edi,DWORD PTR [rbp-0x30]
     a70:	57                   	push   rdi
     a71:	8b 7d d4             	mov    edi,DWORD PTR [rbp-0x2c]
     a74:	57                   	push   rdi
     a75:	8b 7d d8             	mov    edi,DWORD PTR [rbp-0x28]
     a78:	57                   	push   rdi
     a79:	8b 7d dc             	mov    edi,DWORD PTR [rbp-0x24]
     a7c:	57                   	push   rdi
     a7d:	8b 7d e0             	mov    edi,DWORD PTR [rbp-0x20]
     a80:	57                   	push   rdi
     a81:	48 89 c7             	mov    rdi,rax
     a84:	e8 00 00 00 00       	call   a89 <mm_map+0x11e>
     a89:	48 83 c4 30          	add    rsp,0x30
#else
		return mf_map(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
#endif
}
     a8d:	c9                   	leave
     a8e:	c3                   	ret

0000000000000a8f <mm_page_walk64>:

#ifdef __x86_64__
int mm_page_walk64(void* vm_mapping, void* virt_addr, struct pte64** parent,
				struct pte64** entry, int* level, uint32_t* offset, void*** cntr, void*** cntrm)
{
     a8f:	55                   	push   rbp
     a90:	48 89 e5             	mov    rbp,rsp
     a93:	48 83 c4 80          	add    rsp,0xffffffffffffff80
     a97:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
     a9b:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
     a9f:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
     aa3:	48 89 4d 90          	mov    QWORD PTR [rbp-0x70],rcx
     aa7:	4c 89 45 88          	mov    QWORD PTR [rbp-0x78],r8
     aab:	4c 89 4d 80          	mov    QWORD PTR [rbp-0x80],r9
		uint64_t low48;
		struct vm_pg_ptrs64* vp = vm_mapping;
     aaf:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     ab3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		uint32_t pml4e, pdpte, pde, pte;

		/* entry pointers */
		struct pte64 *p = vp->pml4;
     ab7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     abb:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     abf:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		struct pte64* pl = 0;
     ac3:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		struct pte64* pd = 0;
     acb:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		struct pte64* pt = 0;
     ad3:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
		/* mappings */
		struct vm_pdpte_ptr* m;
		struct vm_pde_ptr* n;

		/* calculate the PML4E */
		low48 = (uint64_t)virt_addr & 0x0000ffffffffffff;
     adb:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     adf:	48 ba ff ff ff ff ff ff 00 00 	movabs rdx,0xffffffffffff
     ae9:	48 21 d0             	and    rax,rdx
     aec:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		pml4e = low48 >> 39; /* 512G per PML4E */
     af0:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     af4:	48 c1 e8 27          	shr    rax,0x27
     af8:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax

		/* and the PDPTE */
		pdpte = (low48 & 0x007fc0000000) >> 30; /* 1G per PDPTE */
     afb:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     aff:	48 c1 e8 1e          	shr    rax,0x1e
     b03:	25 ff 01 00 00       	and    eax,0x1ff
     b08:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax

		/* and the PDE */
		pde = (low48 & 0x3fe00000) >> 21; /* 2M per PDE */
     b0b:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b0f:	48 c1 e8 15          	shr    rax,0x15
     b13:	25 ff 01 00 00       	and    eax,0x1ff
     b18:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax

		/* and finally the PTE */
		pte = (low48 & 0x1ff000) >> 12; /* 4K per PTE */
     b1b:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b1f:	48 c1 e8 0c          	shr    rax,0xc
     b23:	25 ff 01 00 00       	and    eax,0x1ff
     b28:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax

		/* Now walk down the hierachy */
		if (!p) {
     b2b:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     b30:	75 37                	jne    b69 <mm_page_walk64+0xda>
				*parent = *entry = NULL;
     b32:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     b36:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
     b3d:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     b41:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     b44:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     b48:	48 89 10             	mov    QWORD PTR [rax],rdx
				*offset = -1;
     b4b:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     b4f:	c7 00 ff ff ff ff    	mov    DWORD PTR [rax],0xffffffff
				*level = 4; /* missing lvl4 (very unlikely) */
     b55:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     b59:	c7 00 04 00 00 00    	mov    DWORD PTR [rax],0x4
				return -1;
     b5f:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b64:	e9 f3 02 00 00       	jmp    e5c <mm_page_walk64+0x3cd>
		}

		/* PML4 (no size bit exists) */
		if (!p[pml4e].p) {
     b69:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     b6c:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     b74:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     b78:	48 01 d0             	add    rax,rdx
     b7b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     b7e:	83 e0 01             	and    eax,0x1
     b81:	84 c0                	test   al,al
     b83:	75 62                	jne    be7 <mm_page_walk64+0x158>
				*entry = &p[pml4e];
     b85:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     b88:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     b90:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     b94:	48 01 c2             	add    rdx,rax
     b97:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     b9b:	48 89 10             	mov    QWORD PTR [rax],rdx
				*parent = p; /* to ensure parent[offset]=entry */
     b9e:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     ba2:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     ba6:	48 89 10             	mov    QWORD PTR [rax],rdx
				*offset = pml4e;
     ba9:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     bad:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
     bb0:	89 10                	mov    DWORD PTR [rax],edx
				*level = 3;
     bb2:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     bb6:	c7 00 03 00 00 00    	mov    DWORD PTR [rax],0x3
				*cntr = (void**)vp->pml4e;
     bbc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bc0:	48 8d 50 10          	lea    rdx,[rax+0x10]
     bc4:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     bc8:	48 89 10             	mov    QWORD PTR [rax],rdx
				*cntrm = (void**)vp->pdpte;
     bcb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bcf:	48 8d 90 10 10 00 00 	lea    rdx,[rax+0x1010]
     bd6:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     bda:	48 89 10             	mov    QWORD PTR [rax],rdx
				return -1;
     bdd:	b8 ff ff ff ff       	mov    eax,0xffffffff
     be2:	e9 75 02 00 00       	jmp    e5c <mm_page_walk64+0x3cd>
		}

		m = vp->pdpte[pml4e];
     be7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     beb:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
     bee:	48 81 c2 02 02 00 00 	add    rdx,0x202
     bf5:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     bf9:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
		pl = vp->pml4e[pml4e];
     bfd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c01:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
     c04:	48 83 c2 02          	add    rdx,0x2
     c08:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     c0c:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax

		/* PDPTE */
		if (!pl[pdpte].p || pl[pdpte].s) {
     c10:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c13:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     c1b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c1f:	48 01 d0             	add    rax,rdx
     c22:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c25:	83 e0 01             	and    eax,0x1
     c28:	84 c0                	test   al,al
     c2a:	74 20                	je     c4c <mm_page_walk64+0x1bd>
     c2c:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c2f:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     c37:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c3b:	48 01 d0             	add    rax,rdx
     c3e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c41:	83 e0 80             	and    eax,0xffffff80
     c44:	84 c0                	test   al,al
     c46:	0f 84 92 00 00 00    	je     cde <mm_page_walk64+0x24f>
				*parent = &p[pml4e];
     c4c:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     c4f:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     c57:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c5b:	48 01 c2             	add    rdx,rax
     c5e:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     c62:	48 89 10             	mov    QWORD PTR [rax],rdx
				*entry = &pl[pdpte];
     c65:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c68:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     c70:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c74:	48 01 c2             	add    rdx,rax
     c77:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     c7b:	48 89 10             	mov    QWORD PTR [rax],rdx
				*level = 2;
     c7e:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     c82:	c7 00 02 00 00 00    	mov    DWORD PTR [rax],0x2
				*offset = pdpte;
     c88:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     c8c:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
     c8f:	89 10                	mov    DWORD PTR [rax],edx
				*cntr = (void**)m->pds;
     c91:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
     c95:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     c99:	48 89 10             	mov    QWORD PTR [rax],rdx
				*cntrm = (void**)m->pdes;
     c9c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     ca0:	48 8d 90 00 10 00 00 	lea    rdx,[rax+0x1000]
     ca7:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     cab:	48 89 10             	mov    QWORD PTR [rax],rdx
				/* 1G page is OK */
				return (pl[pdpte].s ? 0 : -1);
     cae:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     cb1:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     cb9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     cbd:	48 01 d0             	add    rax,rdx
     cc0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     cc3:	83 e0 80             	and    eax,0xffffff80
     cc6:	84 c0                	test   al,al
     cc8:	74 0a                	je     cd4 <mm_page_walk64+0x245>
     cca:	b8 00 00 00 00       	mov    eax,0x0
     ccf:	e9 88 01 00 00       	jmp    e5c <mm_page_walk64+0x3cd>
     cd4:	b8 ff ff ff ff       	mov    eax,0xffffffff
     cd9:	e9 7e 01 00 00       	jmp    e5c <mm_page_walk64+0x3cd>
		}

		n = m->pdes[pdpte];
     cde:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     ce2:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
     ce5:	48 81 c2 00 02 00 00 	add    rdx,0x200
     cec:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     cf0:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		pd = m->pds[pdpte];
     cf4:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     cf8:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
     cfb:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     cff:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax

		/* PDE */
		if (!pd[pde].p || pd[pde].s) {
     d03:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d06:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     d0e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d12:	48 01 d0             	add    rax,rdx
     d15:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     d18:	83 e0 01             	and    eax,0x1
     d1b:	84 c0                	test   al,al
     d1d:	74 20                	je     d3f <mm_page_walk64+0x2b0>
     d1f:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d22:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     d2a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d2e:	48 01 d0             	add    rax,rdx
     d31:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     d34:	83 e0 80             	and    eax,0xffffff80
     d37:	84 c0                	test   al,al
     d39:	0f 84 8b 00 00 00    	je     dca <mm_page_walk64+0x33b>
				*parent = &pl[pdpte];
     d3f:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     d42:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     d4a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d4e:	48 01 c2             	add    rdx,rax
     d51:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     d55:	48 89 10             	mov    QWORD PTR [rax],rdx
				*entry = &pd[pde];
     d58:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d5b:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     d63:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d67:	48 01 c2             	add    rdx,rax
     d6a:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     d6e:	48 89 10             	mov    QWORD PTR [rax],rdx
				*level = 1;
     d71:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     d75:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
				*offset = pde;
     d7b:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     d7f:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
     d82:	89 10                	mov    DWORD PTR [rax],edx
				*cntr = (void**)n->pts;
     d84:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     d88:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     d8c:	48 89 10             	mov    QWORD PTR [rax],rdx
				*cntrm = NULL;
     d8f:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     d93:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				/* 2M page is OK */
				return (pd[pde].s ? 0 : -1);
     d9a:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d9d:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     da5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     da9:	48 01 d0             	add    rax,rdx
     dac:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     daf:	83 e0 80             	and    eax,0xffffff80
     db2:	84 c0                	test   al,al
     db4:	74 0a                	je     dc0 <mm_page_walk64+0x331>
     db6:	b8 00 00 00 00       	mov    eax,0x0
     dbb:	e9 9c 00 00 00       	jmp    e5c <mm_page_walk64+0x3cd>
     dc0:	b8 ff ff ff ff       	mov    eax,0xffffffff
     dc5:	e9 92 00 00 00       	jmp    e5c <mm_page_walk64+0x3cd>
		}

		pt = n->pts[pde];
     dca:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     dce:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
     dd1:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     dd5:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax

		/* PTE */
		*parent = &pd[pde];
     dd9:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     ddc:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     de4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     de8:	48 01 c2             	add    rdx,rax
     deb:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     def:	48 89 10             	mov    QWORD PTR [rax],rdx
		*entry = &pt[pte];
     df2:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
     df5:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     dfd:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     e01:	48 01 c2             	add    rdx,rax
     e04:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     e08:	48 89 10             	mov    QWORD PTR [rax],rdx
		*level = 0;
     e0b:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     e0f:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		*offset = pte;
     e15:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     e19:	8b 55 c0             	mov    edx,DWORD PTR [rbp-0x40]
     e1c:	89 10                	mov    DWORD PTR [rax],edx
		*cntr = NULL;
     e1e:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     e22:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
		*cntrm = NULL;
     e29:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     e2d:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
		/* present or not? */
		return (pt[pte].p ? 0 : -1);
     e34:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
     e37:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     e3f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     e43:	48 01 d0             	add    rax,rdx
     e46:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     e49:	83 e0 01             	and    eax,0x1
     e4c:	84 c0                	test   al,al
     e4e:	74 07                	je     e57 <mm_page_walk64+0x3c8>
     e50:	b8 00 00 00 00       	mov    eax,0x0
     e55:	eb 05                	jmp    e5c <mm_page_walk64+0x3cd>
     e57:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     e5c:	c9                   	leave
     e5d:	c3                   	ret

0000000000000e5e <mm_protect>:
		return (pt[pte].p ? 0 : -1);
}
#endif

void mm_protect(struct mm* mm, void* virt_address, size_t num_pages, int flags)
{
     e5e:	55                   	push   rbp
     e5f:	48 89 e5             	mov    rbp,rsp
     e62:	48 83 ec 60          	sub    rsp,0x60
     e66:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
     e6a:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
     e6e:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
     e72:	89 4d a4             	mov    DWORD PTR [rbp-0x5c],ecx
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (num_pages--) {
     e75:	e9 e7 06 00 00       	jmp    1561 <mm_protect+0x703>
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
     e7a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     e7e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e82:	4c 8d 4d e0          	lea    r9,[rbp-0x20]
     e86:	4c 8d 45 e4          	lea    r8,[rbp-0x1c]
     e8a:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
     e8e:	48 8d 55 d8          	lea    rdx,[rbp-0x28]
     e92:	48 8b 75 b0          	mov    rsi,QWORD PTR [rbp-0x50]
     e96:	48 8d 7d c0          	lea    rdi,[rbp-0x40]
     e9a:	57                   	push   rdi
     e9b:	48 8d 7d c8          	lea    rdi,[rbp-0x38]
     e9f:	57                   	push   rdi
     ea0:	48 89 c7             	mov    rdi,rax
     ea3:	e8 00 00 00 00       	call   ea8 <mm_protect+0x4a>
     ea8:	48 83 c4 10          	add    rsp,0x10
     eac:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
     eaf:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     eb3:	0f 85 bf 06 00 00    	jne    1578 <mm_protect+0x71a>
						return;

				e32 = NULL; e64 = NULL;
     eb9:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     ec1:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (!cpu.has_pae)
     ec9:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # ed0 <mm_protect+0x72>
     ed0:	83 e0 40             	and    eax,0x40
     ed3:	84 c0                	test   al,al
     ed5:	75 0a                	jne    ee1 <mm_protect+0x83>
						e32 = e;
     ed7:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     edb:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     edf:	eb 08                	jmp    ee9 <mm_protect+0x8b>
				else
						e64 = e;
     ee1:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     ee5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		
				/* set/unset or override */
				if (flags & MMGR_MAP_PURGE_ACC)
     ee9:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     eec:	25 00 04 00 00       	and    eax,0x400
     ef1:	85 c0                	test   eax,eax
     ef3:	74 29                	je     f1e <mm_protect+0xc0>
						if (e64)
     ef5:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     efa:	74 11                	je     f0d <mm_protect+0xaf>
								e64->a = 0;
     efc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f00:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     f03:	83 e2 df             	and    edx,0xffffffdf
     f06:	88 10                	mov    BYTE PTR [rax],dl
     f08:	e9 cd 05 00 00       	jmp    14da <mm_protect+0x67c>
						else
								e32->a = 0;
     f0d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f11:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     f14:	83 e2 df             	and    edx,0xffffffdf
     f17:	88 10                	mov    BYTE PTR [rax],dl
     f19:	e9 bc 05 00 00       	jmp    14da <mm_protect+0x67c>
				else if (flags & MMGR_MAP_PURGE_DIRTY)
     f1e:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f21:	25 00 08 00 00       	and    eax,0x800
     f26:	85 c0                	test   eax,eax
     f28:	74 29                	je     f53 <mm_protect+0xf5>
						if (e64)
     f2a:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     f2f:	74 11                	je     f42 <mm_protect+0xe4>
								e64->d = 0;
     f31:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f35:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     f38:	83 e2 bf             	and    edx,0xffffffbf
     f3b:	88 10                	mov    BYTE PTR [rax],dl
     f3d:	e9 98 05 00 00       	jmp    14da <mm_protect+0x67c>
						else
								e32->d = 0;
     f42:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f46:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     f49:	83 e2 bf             	and    edx,0xffffffbf
     f4c:	88 10                	mov    BYTE PTR [rax],dl
     f4e:	e9 87 05 00 00       	jmp    14da <mm_protect+0x67c>
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
     f53:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f56:	25 00 10 00 00       	and    eax,0x1000
     f5b:	85 c0                	test   eax,eax
     f5d:	75 10                	jne    f6f <mm_protect+0x111>
     f5f:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f62:	25 00 20 00 00       	and    eax,0x2000
     f67:	85 c0                	test   eax,eax
     f69:	0f 84 eb 02 00 00    	je     125a <mm_protect+0x3fc>
						char v = !!(flags & MMGR_MAP_SET); /* 1 or 0 */
     f6f:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f72:	25 00 10 00 00       	and    eax,0x1000
     f77:	85 c0                	test   eax,eax
     f79:	0f 95 c0             	setne  al
     f7c:	88 45 eb             	mov    BYTE PTR [rbp-0x15],al
						if (e64) {
     f7f:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     f84:	0f 84 9a 01 00 00    	je     1124 <mm_protect+0x2c6>
								if (flags & MMGR_MAP_WRITE)
     f8a:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f8d:	83 e0 04             	and    eax,0x4
     f90:	85 c0                	test   eax,eax
     f92:	74 1d                	je     fb1 <mm_protect+0x153>
										e64->w = v;
     f94:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
     f98:	83 e0 01             	and    eax,0x1
     f9b:	89 c2                	mov    edx,eax
     f9d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fa1:	83 e2 01             	and    edx,0x1
     fa4:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
     fa7:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     faa:	83 e2 fd             	and    edx,0xfffffffd
     fad:	09 ca                	or     edx,ecx
     faf:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_WRITE_THROUGH)
     fb1:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     fb4:	83 e0 10             	and    eax,0x10
     fb7:	85 c0                	test   eax,eax
     fb9:	74 21                	je     fdc <mm_protect+0x17e>
										e64->wt = v;
     fbb:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
     fbf:	83 e0 01             	and    eax,0x1
     fc2:	89 c2                	mov    edx,eax
     fc4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fc8:	83 e2 01             	and    edx,0x1
     fcb:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
     fd2:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     fd5:	83 e2 f7             	and    edx,0xfffffff7
     fd8:	09 ca                	or     edx,ecx
     fda:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_NO_CACHING)
     fdc:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     fdf:	83 e0 20             	and    eax,0x20
     fe2:	85 c0                	test   eax,eax
     fe4:	74 1f                	je     1005 <mm_protect+0x1a7>
										e64->cd = v;
     fe6:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
     fea:	83 e0 01             	and    eax,0x1
     fed:	89 c2                	mov    edx,eax
     fef:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ff3:	83 e2 01             	and    edx,0x1
     ff6:	89 d1                	mov    ecx,edx
     ff8:	c1 e1 04             	shl    ecx,0x4
     ffb:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     ffe:	83 e2 ef             	and    edx,0xffffffef
    1001:	09 ca                	or     edx,ecx
    1003:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_PAT)
    1005:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1008:	25 80 00 00 00       	and    eax,0x80
    100d:	85 c0                	test   eax,eax
    100f:	0f 84 8d 00 00 00    	je     10a2 <mm_protect+0x244>
										if (lv > 0)
    1015:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1018:	85 c0                	test   eax,eax
    101a:	7e 6a                	jle    1086 <mm_protect+0x228>
												e64->addr = (e64->addr & ~1) | v;
    101c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1020:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1023:	48 c1 e8 0c          	shr    rax,0xc
    1027:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    1031:	48 21 d0             	and    rax,rdx
    1034:	48 ba fe ff ff ff ff 00 00 00 	movabs rdx,0xfffffffffe
    103e:	48 21 c2             	and    rdx,rax
    1041:	48 0f be 45 eb       	movsx  rax,BYTE PTR [rbp-0x15]
    1046:	48 b9 ff ff ff ff ff 00 00 00 	movabs rcx,0xffffffffff
    1050:	48 21 c8             	and    rax,rcx
    1053:	48 89 d1             	mov    rcx,rdx
    1056:	48 09 c1             	or     rcx,rax
    1059:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    105d:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    1067:	48 21 ca             	and    rdx,rcx
    106a:	48 c1 e2 0c          	shl    rdx,0xc
    106e:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1071:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    107b:	48 21 f1             	and    rcx,rsi
    107e:	48 09 ca             	or     rdx,rcx
    1081:	48 89 10             	mov    QWORD PTR [rax],rdx
    1084:	eb 1c                	jmp    10a2 <mm_protect+0x244>
										else
												e64->s = v;
    1086:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    108a:	83 e0 01             	and    eax,0x1
    108d:	89 c2                	mov    edx,eax
    108f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1093:	89 d1                	mov    ecx,edx
    1095:	c1 e1 07             	shl    ecx,0x7
    1098:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    109b:	83 e2 7f             	and    edx,0x7f
    109e:	09 ca                	or     edx,ecx
    10a0:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_GLOBAL)
    10a2:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    10a5:	83 e0 40             	and    eax,0x40
    10a8:	85 c0                	test   eax,eax
    10aa:	74 1e                	je     10ca <mm_protect+0x26c>
										e64->g = v;
    10ac:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    10b0:	83 e0 01             	and    eax,0x1
    10b3:	89 c2                	mov    edx,eax
    10b5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10b9:	89 d1                	mov    ecx,edx
    10bb:	83 e1 01             	and    ecx,0x1
    10be:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    10c2:	83 e2 fe             	and    edx,0xfffffffe
    10c5:	09 ca                	or     edx,ecx
    10c7:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								if (flags & MMGR_MAP_KERNEL)
    10ca:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    10cd:	83 e0 08             	and    eax,0x8
    10d0:	85 c0                	test   eax,eax
    10d2:	74 1f                	je     10f3 <mm_protect+0x295>
										e64->u = !v;
    10d4:	80 7d eb 00          	cmp    BYTE PTR [rbp-0x15],0x0
    10d8:	0f 94 c2             	sete   dl
    10db:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10df:	83 e2 01             	and    edx,0x1
    10e2:	8d 0c 95 00 00 00 00 	lea    ecx,[rdx*4+0x0]
    10e9:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    10ec:	83 e2 fb             	and    edx,0xfffffffb
    10ef:	09 ca                	or     edx,ecx
    10f1:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_EXECUTE)
    10f3:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    10f6:	83 e0 02             	and    eax,0x2
    10f9:	85 c0                	test   eax,eax
    10fb:	0f 84 d8 03 00 00    	je     14d9 <mm_protect+0x67b>
										e64->xd = v;
    1101:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    1105:	83 e0 01             	and    eax,0x1
    1108:	89 c2                	mov    edx,eax
    110a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    110e:	89 d1                	mov    ecx,edx
    1110:	c1 e1 07             	shl    ecx,0x7
    1113:	0f b6 50 07          	movzx  edx,BYTE PTR [rax+0x7]
    1117:	83 e2 7f             	and    edx,0x7f
    111a:	09 ca                	or     edx,ecx
    111c:	88 50 07             	mov    BYTE PTR [rax+0x7],dl
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    111f:	e9 b5 03 00 00       	jmp    14d9 <mm_protect+0x67b>
						} else {
								if (flags & MMGR_MAP_WRITE)
    1124:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1127:	83 e0 04             	and    eax,0x4
    112a:	85 c0                	test   eax,eax
    112c:	74 1d                	je     114b <mm_protect+0x2ed>
										e32->w = v;
    112e:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    1132:	83 e0 01             	and    eax,0x1
    1135:	89 c2                	mov    edx,eax
    1137:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    113b:	83 e2 01             	and    edx,0x1
    113e:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    1141:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1144:	83 e2 fd             	and    edx,0xfffffffd
    1147:	09 ca                	or     edx,ecx
    1149:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_WRITE_THROUGH)
    114b:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    114e:	83 e0 10             	and    eax,0x10
    1151:	85 c0                	test   eax,eax
    1153:	74 21                	je     1176 <mm_protect+0x318>
										e32->wt = v;
    1155:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    1159:	83 e0 01             	and    eax,0x1
    115c:	89 c2                	mov    edx,eax
    115e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1162:	83 e2 01             	and    edx,0x1
    1165:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    116c:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    116f:	83 e2 f7             	and    edx,0xfffffff7
    1172:	09 ca                	or     edx,ecx
    1174:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_NO_CACHING)
    1176:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1179:	83 e0 20             	and    eax,0x20
    117c:	85 c0                	test   eax,eax
    117e:	74 1f                	je     119f <mm_protect+0x341>
										e32->cd = v;
    1180:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    1184:	83 e0 01             	and    eax,0x1
    1187:	89 c2                	mov    edx,eax
    1189:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    118d:	83 e2 01             	and    edx,0x1
    1190:	89 d1                	mov    ecx,edx
    1192:	c1 e1 04             	shl    ecx,0x4
    1195:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1198:	83 e2 ef             	and    edx,0xffffffef
    119b:	09 ca                	or     edx,ecx
    119d:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_PAT)
    119f:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    11a2:	25 80 00 00 00       	and    eax,0x80
    11a7:	85 c0                	test   eax,eax
    11a9:	74 55                	je     1200 <mm_protect+0x3a2>
										if (lv > 0)
    11ab:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    11ae:	85 c0                	test   eax,eax
    11b0:	7e 32                	jle    11e4 <mm_protect+0x386>
												e32->addr = (e32->addr & ~1) | v;
    11b2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    11b6:	8b 00                	mov    eax,DWORD PTR [rax]
    11b8:	c1 e8 0c             	shr    eax,0xc
    11bb:	83 e0 fe             	and    eax,0xfffffffe
    11be:	89 c2                	mov    edx,eax
    11c0:	0f be 45 eb          	movsx  eax,BYTE PTR [rbp-0x15]
    11c4:	09 d0                	or     eax,edx
    11c6:	25 ff ff 0f 00       	and    eax,0xfffff
    11cb:	89 c2                	mov    edx,eax
    11cd:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    11d1:	89 d1                	mov    ecx,edx
    11d3:	c1 e1 0c             	shl    ecx,0xc
    11d6:	8b 10                	mov    edx,DWORD PTR [rax]
    11d8:	81 e2 ff 0f 00 00    	and    edx,0xfff
    11de:	09 ca                	or     edx,ecx
    11e0:	89 10                	mov    DWORD PTR [rax],edx
    11e2:	eb 1c                	jmp    1200 <mm_protect+0x3a2>
										else
												e32->s = v;
    11e4:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    11e8:	83 e0 01             	and    eax,0x1
    11eb:	89 c2                	mov    edx,eax
    11ed:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    11f1:	89 d1                	mov    ecx,edx
    11f3:	c1 e1 07             	shl    ecx,0x7
    11f6:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    11f9:	83 e2 7f             	and    edx,0x7f
    11fc:	09 ca                	or     edx,ecx
    11fe:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_GLOBAL)
    1200:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1203:	83 e0 40             	and    eax,0x40
    1206:	85 c0                	test   eax,eax
    1208:	74 1e                	je     1228 <mm_protect+0x3ca>
										e32->g = v;
    120a:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    120e:	83 e0 01             	and    eax,0x1
    1211:	89 c2                	mov    edx,eax
    1213:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1217:	89 d1                	mov    ecx,edx
    1219:	83 e1 01             	and    ecx,0x1
    121c:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    1220:	83 e2 fe             	and    edx,0xfffffffe
    1223:	09 ca                	or     edx,ecx
    1225:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								if (flags & MMGR_MAP_KERNEL)
    1228:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    122b:	83 e0 08             	and    eax,0x8
    122e:	85 c0                	test   eax,eax
    1230:	0f 84 a3 02 00 00    	je     14d9 <mm_protect+0x67b>
										e32->u = !v;
    1236:	80 7d eb 00          	cmp    BYTE PTR [rbp-0x15],0x0
    123a:	0f 94 c2             	sete   dl
    123d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1241:	83 e2 01             	and    edx,0x1
    1244:	8d 0c 95 00 00 00 00 	lea    ecx,[rdx*4+0x0]
    124b:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    124e:	83 e2 fb             	and    edx,0xfffffffb
    1251:	09 ca                	or     edx,ecx
    1253:	88 10                	mov    BYTE PTR [rax],dl
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    1255:	e9 7f 02 00 00       	jmp    14d9 <mm_protect+0x67b>
								//if (flags & MMGR_MAP_EXECUTE)
								//		e32->xd = v;
						}
				} else {
						if (e64) {
    125a:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    125f:	0f 84 67 01 00 00    	je     13cc <mm_protect+0x56e>
								e64->w = !!(flags & MMGR_MAP_WRITE);
    1265:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1268:	83 e0 04             	and    eax,0x4
    126b:	85 c0                	test   eax,eax
    126d:	0f 95 c2             	setne  dl
    1270:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1274:	83 e2 01             	and    edx,0x1
    1277:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    127a:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    127d:	83 e2 fd             	and    edx,0xfffffffd
    1280:	09 ca                	or     edx,ecx
    1282:	88 10                	mov    BYTE PTR [rax],dl
								e64->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
    1284:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1287:	83 e0 10             	and    eax,0x10
    128a:	85 c0                	test   eax,eax
    128c:	0f 95 c2             	setne  dl
    128f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1293:	83 e2 01             	and    edx,0x1
    1296:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    129d:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    12a0:	83 e2 f7             	and    edx,0xfffffff7
    12a3:	09 ca                	or     edx,ecx
    12a5:	88 10                	mov    BYTE PTR [rax],dl
								e64->cd = !!(flags & MMGR_MAP_NO_CACHING);
    12a7:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    12aa:	83 e0 20             	and    eax,0x20
    12ad:	85 c0                	test   eax,eax
    12af:	0f 95 c2             	setne  dl
    12b2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12b6:	83 e2 01             	and    edx,0x1
    12b9:	89 d1                	mov    ecx,edx
    12bb:	c1 e1 04             	shl    ecx,0x4
    12be:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    12c1:	83 e2 ef             	and    edx,0xffffffef
    12c4:	09 ca                	or     edx,ecx
    12c6:	88 10                	mov    BYTE PTR [rax],dl
								if (lv > 0)
    12c8:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    12cb:	85 c0                	test   eax,eax
    12cd:	7e 75                	jle    1344 <mm_protect+0x4e6>
										e64->addr = (e64->addr & ~1) | !!(flags & MMGR_MAP_PAT);
    12cf:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12d3:	48 8b 00             	mov    rax,QWORD PTR [rax]
    12d6:	48 c1 e8 0c          	shr    rax,0xc
    12da:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    12e4:	48 21 d0             	and    rax,rdx
    12e7:	48 ba fe ff ff ff ff 00 00 00 	movabs rdx,0xfffffffffe
    12f1:	48 21 c2             	and    rdx,rax
    12f4:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    12f7:	25 80 00 00 00       	and    eax,0x80
    12fc:	85 c0                	test   eax,eax
    12fe:	0f 95 c0             	setne  al
    1301:	0f b6 c0             	movzx  eax,al
    1304:	48 b9 ff ff ff ff ff 00 00 00 	movabs rcx,0xffffffffff
    130e:	48 21 c8             	and    rax,rcx
    1311:	48 89 d1             	mov    rcx,rdx
    1314:	48 09 c1             	or     rcx,rax
    1317:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    131b:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    1325:	48 21 ca             	and    rdx,rcx
    1328:	48 c1 e2 0c          	shl    rdx,0xc
    132c:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    132f:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    1339:	48 21 f1             	and    rcx,rsi
    133c:	48 09 ca             	or     rdx,rcx
    133f:	48 89 10             	mov    QWORD PTR [rax],rdx
    1342:	eb 20                	jmp    1364 <mm_protect+0x506>
								else
										e64->s = !!(flags & MMGR_MAP_PAT);
    1344:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1347:	25 80 00 00 00       	and    eax,0x80
    134c:	85 c0                	test   eax,eax
    134e:	0f 95 c2             	setne  dl
    1351:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1355:	89 d1                	mov    ecx,edx
    1357:	c1 e1 07             	shl    ecx,0x7
    135a:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    135d:	83 e2 7f             	and    edx,0x7f
    1360:	09 ca                	or     edx,ecx
    1362:	88 10                	mov    BYTE PTR [rax],dl
								e64->g = !!(flags & MMGR_MAP_GLOBAL);
    1364:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1367:	83 e0 40             	and    eax,0x40
    136a:	85 c0                	test   eax,eax
    136c:	0f 95 c2             	setne  dl
    136f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1373:	89 d1                	mov    ecx,edx
    1375:	83 e1 01             	and    ecx,0x1
    1378:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    137c:	83 e2 fe             	and    edx,0xfffffffe
    137f:	09 ca                	or     edx,ecx
    1381:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								e64->u = !(flags & MMGR_MAP_KERNEL);
    1384:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1387:	83 e0 08             	and    eax,0x8
    138a:	85 c0                	test   eax,eax
    138c:	0f 94 c2             	sete   dl
    138f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1393:	83 e2 01             	and    edx,0x1
    1396:	8d 0c 95 00 00 00 00 	lea    ecx,[rdx*4+0x0]
    139d:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    13a0:	83 e2 fb             	and    edx,0xfffffffb
    13a3:	09 ca                	or     edx,ecx
    13a5:	88 10                	mov    BYTE PTR [rax],dl
								e64->xd = !!(flags & MMGR_MAP_EXECUTE);
    13a7:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    13aa:	83 e0 02             	and    eax,0x2
    13ad:	85 c0                	test   eax,eax
    13af:	0f 95 c2             	setne  dl
    13b2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13b6:	89 d1                	mov    ecx,edx
    13b8:	c1 e1 07             	shl    ecx,0x7
    13bb:	0f b6 50 07          	movzx  edx,BYTE PTR [rax+0x7]
    13bf:	83 e2 7f             	and    edx,0x7f
    13c2:	09 ca                	or     edx,ecx
    13c4:	88 50 07             	mov    BYTE PTR [rax+0x7],dl
    13c7:	e9 0e 01 00 00       	jmp    14da <mm_protect+0x67c>
						} else {
								e32->w = !!(flags & MMGR_MAP_WRITE);
    13cc:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    13cf:	83 e0 04             	and    eax,0x4
    13d2:	85 c0                	test   eax,eax
    13d4:	0f 95 c2             	setne  dl
    13d7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13db:	83 e2 01             	and    edx,0x1
    13de:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    13e1:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    13e4:	83 e2 fd             	and    edx,0xfffffffd
    13e7:	09 ca                	or     edx,ecx
    13e9:	88 10                	mov    BYTE PTR [rax],dl
								e32->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
    13eb:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    13ee:	83 e0 10             	and    eax,0x10
    13f1:	85 c0                	test   eax,eax
    13f3:	0f 95 c2             	setne  dl
    13f6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13fa:	83 e2 01             	and    edx,0x1
    13fd:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    1404:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1407:	83 e2 f7             	and    edx,0xfffffff7
    140a:	09 ca                	or     edx,ecx
    140c:	88 10                	mov    BYTE PTR [rax],dl
								e32->cd = !!(flags & MMGR_MAP_NO_CACHING);
    140e:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1411:	83 e0 20             	and    eax,0x20
    1414:	85 c0                	test   eax,eax
    1416:	0f 95 c2             	setne  dl
    1419:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    141d:	83 e2 01             	and    edx,0x1
    1420:	89 d1                	mov    ecx,edx
    1422:	c1 e1 04             	shl    ecx,0x4
    1425:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1428:	83 e2 ef             	and    edx,0xffffffef
    142b:	09 ca                	or     edx,ecx
    142d:	88 10                	mov    BYTE PTR [rax],dl
								if (lv > 0)
    142f:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1432:	85 c0                	test   eax,eax
    1434:	7e 3e                	jle    1474 <mm_protect+0x616>
										e32->addr = (e32->addr & ~1) | !!(flags & MMGR_MAP_PAT);
    1436:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    143a:	8b 00                	mov    eax,DWORD PTR [rax]
    143c:	c1 e8 0c             	shr    eax,0xc
    143f:	83 e0 fe             	and    eax,0xfffffffe
    1442:	89 c2                	mov    edx,eax
    1444:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1447:	25 80 00 00 00       	and    eax,0x80
    144c:	85 c0                	test   eax,eax
    144e:	0f 95 c0             	setne  al
    1451:	0f b6 c0             	movzx  eax,al
    1454:	09 d0                	or     eax,edx
    1456:	25 ff ff 0f 00       	and    eax,0xfffff
    145b:	89 c2                	mov    edx,eax
    145d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1461:	89 d1                	mov    ecx,edx
    1463:	c1 e1 0c             	shl    ecx,0xc
    1466:	8b 10                	mov    edx,DWORD PTR [rax]
    1468:	81 e2 ff 0f 00 00    	and    edx,0xfff
    146e:	09 ca                	or     edx,ecx
    1470:	89 10                	mov    DWORD PTR [rax],edx
    1472:	eb 20                	jmp    1494 <mm_protect+0x636>
								else
										e32->s = !!(flags & MMGR_MAP_PAT);
    1474:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1477:	25 80 00 00 00       	and    eax,0x80
    147c:	85 c0                	test   eax,eax
    147e:	0f 95 c2             	setne  dl
    1481:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1485:	89 d1                	mov    ecx,edx
    1487:	c1 e1 07             	shl    ecx,0x7
    148a:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    148d:	83 e2 7f             	and    edx,0x7f
    1490:	09 ca                	or     edx,ecx
    1492:	88 10                	mov    BYTE PTR [rax],dl
								e32->g = !!(flags & MMGR_MAP_GLOBAL);
    1494:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1497:	83 e0 40             	and    eax,0x40
    149a:	85 c0                	test   eax,eax
    149c:	0f 95 c2             	setne  dl
    149f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    14a3:	89 d1                	mov    ecx,edx
    14a5:	83 e1 01             	and    ecx,0x1
    14a8:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    14ac:	83 e2 fe             	and    edx,0xfffffffe
    14af:	09 ca                	or     edx,ecx
    14b1:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								e32->u = !(flags & MMGR_MAP_KERNEL);
    14b4:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    14b7:	83 e0 08             	and    eax,0x8
    14ba:	85 c0                	test   eax,eax
    14bc:	0f 94 c2             	sete   dl
    14bf:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    14c3:	83 e2 01             	and    edx,0x1
    14c6:	8d 0c 95 00 00 00 00 	lea    ecx,[rdx*4+0x0]
    14cd:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    14d0:	83 e2 fb             	and    edx,0xfffffffb
    14d3:	09 ca                	or     edx,ecx
    14d5:	88 10                	mov    BYTE PTR [rax],dl
    14d7:	eb 01                	jmp    14da <mm_protect+0x67c>
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    14d9:	90                   	nop
								//e32->xd = !!(flags & MMGR_MAP_EXECUTE);
						}
				}

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
    14da:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    14de:	48 89 c7             	mov    rdi,rax
    14e1:	e8 35 eb ff ff       	call   1b <flush_tlb_single>
		
				/* advance */
				if (!lv) /* regular page */
    14e6:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    14e9:	85 c0                	test   eax,eax
    14eb:	75 0a                	jne    14f7 <mm_protect+0x699>
						virt_address += 4096;
    14ed:	48 81 45 b0 00 10 00 00 	add    QWORD PTR [rbp-0x50],0x1000
    14f5:	eb 6a                	jmp    1561 <mm_protect+0x703>
				else if (lv == 1) /* large page 2M/4M */
    14f7:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    14fa:	83 f8 01             	cmp    eax,0x1
    14fd:	75 20                	jne    151f <mm_protect+0x6c1>
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
    14ff:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1506 <mm_protect+0x6a8>
    1506:	83 e0 40             	and    eax,0x40
    1509:	84 c0                	test   al,al
    150b:	74 07                	je     1514 <mm_protect+0x6b6>
    150d:	b8 00 00 80 00       	mov    eax,0x800000
    1512:	eb 05                	jmp    1519 <mm_protect+0x6bb>
    1514:	b8 00 00 00 01       	mov    eax,0x1000000
    1519:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
    151d:	eb 42                	jmp    1561 <mm_protect+0x703>
				else if (lv == 2) /* huge page 1G */
    151f:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1522:	83 f8 02             	cmp    eax,0x2
    1525:	75 0a                	jne    1531 <mm_protect+0x6d3>
						virt_address += 1024 * 1024 * 1024;
    1527:	48 81 45 b0 00 00 00 40 	add    QWORD PTR [rbp-0x50],0x40000000
    152f:	eb 30                	jmp    1561 <mm_protect+0x703>
				else
						die("ginormous page?\n");
    1531:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1538:	bf 0c 00 00 00       	mov    edi,0xc
    153d:	b8 00 00 00 00       	mov    eax,0x0
    1542:	e8 00 00 00 00       	call   1547 <mm_protect+0x6e9>
    1547:	b8 00 00 00 00       	mov    eax,0x0
    154c:	e8 00 00 00 00       	call   1551 <mm_protect+0x6f3>
    1551:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1558:	e8 00 00 00 00       	call   155d <mm_protect+0x6ff>
    155d:	fa                   	cli
    155e:	f4                   	hlt
    155f:	eb fd                	jmp    155e <mm_protect+0x700>
		while (num_pages--) {
    1561:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1565:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    1569:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
    156d:	48 85 c0             	test   rax,rax
    1570:	0f 85 04 f9 ff ff    	jne    e7a <mm_protect+0x1c>
    1576:	eb 01                	jmp    1579 <mm_protect+0x71b>
						return;
    1578:	90                   	nop
		}
}
    1579:	c9                   	leave
    157a:	c3                   	ret

000000000000157b <mm_reserve_vmem>:

void* mm_reserve_vmem(struct mm* mm, size_t pg_ct, int flags)
{
    157b:	55                   	push   rbp
    157c:	48 89 e5             	mov    rbp,rsp
    157f:	48 83 ec 30          	sub    rsp,0x30
    1583:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1587:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    158b:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
		void* rv = __sync_fetch_and_add(&mm->qnd_ptr, pg_ct * 4096);
    158e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1592:	48 c1 e0 0c          	shl    rax,0xc
    1596:	48 89 c2             	mov    rdx,rax
    1599:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    159d:	48 83 c0 10          	add    rax,0x10
    15a1:	f0 48 0f c1 10       	lock xadd QWORD PTR [rax],rdx
    15a6:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
		printf("mm reserved at %x\n", rv);
    15aa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15ae:	48 89 c6             	mov    rsi,rax
    15b1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    15b8:	b8 00 00 00 00       	mov    eax,0x0
    15bd:	e8 00 00 00 00       	call   15c2 <mm_reserve_vmem+0x47>
		if (rv + pg_ct * 4096 > VM_QND_LIMIT)
    15c2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    15c6:	48 c1 e0 0c          	shl    rax,0xc
    15ca:	48 89 c2             	mov    rdx,rax
    15cd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15d1:	48 01 d0             	add    rax,rdx
    15d4:	48 3d 00 00 00 80    	cmp    rax,0xffffffff80000000
    15da:	76 30                	jbe    160c <mm_reserve_vmem+0x91>
				die("Out of QnD VM reservation ranges. Impelment a map!\n");
    15dc:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    15e3:	bf 0c 00 00 00       	mov    edi,0xc
    15e8:	b8 00 00 00 00       	mov    eax,0x0
    15ed:	e8 00 00 00 00       	call   15f2 <mm_reserve_vmem+0x77>
    15f2:	b8 00 00 00 00       	mov    eax,0x0
    15f7:	e8 00 00 00 00       	call   15fc <mm_reserve_vmem+0x81>
    15fc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1603:	e8 00 00 00 00       	call   1608 <mm_reserve_vmem+0x8d>
    1608:	fa                   	cli
    1609:	f4                   	hlt
    160a:	eb fd                	jmp    1609 <mm_reserve_vmem+0x8e>
		return rv;
    160c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
    1610:	c9                   	leave
    1611:	c3                   	ret

0000000000001612 <mm_aoa_range>:

void mm_aoa_range(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
    1612:	55                   	push   rbp
    1613:	48 89 e5             	mov    rbp,rsp
    1616:	48 81 ec c0 00 00 00 	sub    rsp,0xc0
    161d:	48 89 bd 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdi
    1624:	48 89 b5 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rsi
    162b:	48 89 95 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rdx
    1632:	89 8d 44 ff ff ff    	mov    DWORD PTR [rbp-0xbc],ecx
		int x = flags & MMGR_MAP_EXECUTE, w = flags & MMGR_MAP_WRITE,
    1638:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    163e:	83 e0 02             	and    eax,0x2
    1641:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
    1644:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    164a:	83 e0 04             	and    eax,0x4
    164d:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
			wc = flags & MMGR_MAP_PAT, wt = flags & MMGR_MAP_WRITE_THROUGH,
    1650:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    1656:	25 80 00 00 00       	and    eax,0x80
    165b:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
    165e:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    1664:	83 e0 10             	and    eax,0x10
    1667:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
			cd = flags & MMGR_MAP_NO_CACHING, g = flags & MMGR_MAP_GLOBAL,
    166a:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    1670:	83 e0 20             	and    eax,0x20
    1673:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
    1676:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    167c:	83 e0 40             	and    eax,0x40
    167f:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
			u = !(flags & MMGR_MAP_KERNEL);
    1682:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    1688:	83 e0 08             	and    eax,0x8
    168b:	85 c0                	test   eax,eax
    168d:	0f 94 c0             	sete   al
    1690:	0f b6 c0             	movzx  eax,al
    1693:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
		int avl = MMGR_AVL_AOA, lvl; uint32_t ofs;
    1696:	c7 45 c8 04 00 00 00 	mov    DWORD PTR [rbp-0x38],0x4
		void *p, *e, **cntr, **cntrm; /* page walk: cntr (last one), cntrm (missing)*/

		while (pg_ct) {
    169d:	e9 0e 05 00 00       	jmp    1bb0 <mm_aoa_range+0x59e>
redo:
				if (!mm_page_walk(mm, virt_address, &p, &e, &lvl,
    16a2:	4c 8d 4d a8          	lea    r9,[rbp-0x58]
    16a6:	4c 8d 45 ac          	lea    r8,[rbp-0x54]
    16aa:	48 8d 4d 98          	lea    rcx,[rbp-0x68]
    16ae:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
    16b2:	48 8b b5 50 ff ff ff 	mov    rsi,QWORD PTR [rbp-0xb0]
    16b9:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    16c0:	48 8d 7d 88          	lea    rdi,[rbp-0x78]
    16c4:	57                   	push   rdi
    16c5:	48 8d 7d 90          	lea    rdi,[rbp-0x70]
    16c9:	57                   	push   rdi
    16ca:	48 89 c7             	mov    rdi,rax
    16cd:	e8 00 00 00 00       	call   16d2 <mm_aoa_range+0xc0>
    16d2:	48 83 c4 10          	add    rsp,0x10
    16d6:	85 c0                	test   eax,eax
    16d8:	75 37                	jne    1711 <mm_aoa_range+0xff>
										&ofs, &cntr, &cntrm)) {
						/* present entry! */
present:
    16da:	90                   	nop
    16db:	eb 04                	jmp    16e1 <mm_aoa_range+0xcf>
				if (!cpu.has_pae) {
						struct pte32* pte = e;
						while (ofs < 1024) {
								/* check for present */
								if (pte->p)
										goto present;
    16dd:	90                   	nop
    16de:	eb 01                	jmp    16e1 <mm_aoa_range+0xcf>
				} else {
						struct pte64* pte = e;
						while (ofs < 512) {
								/* check for present */
								if (pte->p)
										goto present;
    16e0:	90                   	nop
						die("encountered present entry while AOA alloc\n");
    16e1:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    16e8:	bf 0c 00 00 00       	mov    edi,0xc
    16ed:	b8 00 00 00 00       	mov    eax,0x0
    16f2:	e8 00 00 00 00       	call   16f7 <mm_aoa_range+0xe5>
    16f7:	b8 00 00 00 00       	mov    eax,0x0
    16fc:	e8 00 00 00 00       	call   1701 <mm_aoa_range+0xef>
    1701:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1708:	e8 00 00 00 00       	call   170d <mm_aoa_range+0xfb>
    170d:	fa                   	cli
    170e:	f4                   	hlt
    170f:	eb fd                	jmp    170e <mm_aoa_range+0xfc>
				if (lvl > 0) {
    1711:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    1714:	85 c0                	test   eax,eax
    1716:	0f 8e 9f 01 00 00    	jle    18bb <mm_aoa_range+0x2a9>
						if (ENTER_CS_PTE(cntr[ofs])) {
    171c:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1720:	8b 55 a8             	mov    edx,DWORD PTR [rbp-0x58]
    1723:	89 d2                	mov    edx,edx
    1725:	48 c1 e2 03          	shl    rdx,0x3
    1729:	48 01 c2             	add    rdx,rax
    172c:	b8 00 00 00 00       	mov    eax,0x0
    1731:	48 c7 c1 ff ff ff ff 	mov    rcx,0xffffffffffffffff
    1738:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
    173d:	0f 94 c0             	sete   al
    1740:	84 c0                	test   al,al
    1742:	0f 84 55 01 00 00    	je     189d <mm_aoa_range+0x28b>
								struct pte64* p = e;
    1748:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    174c:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
								ptr = mm_alloc_page(&b);
    1750:	48 8d 45 80          	lea    rax,[rbp-0x80]
    1754:	48 89 c7             	mov    rdi,rax
    1757:	e8 00 00 00 00       	call   175c <mm_aoa_range+0x14a>
    175c:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
								p->addr = b / 4096;
    1760:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1764:	48 c1 e8 0c          	shr    rax,0xc
    1768:	48 89 c2             	mov    rdx,rax
    176b:	48 b8 ff ff ff ff ff 00 00 00 	movabs rax,0xffffffffff
    1775:	48 89 d1             	mov    rcx,rdx
    1778:	48 21 c1             	and    rcx,rax
    177b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    177f:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    1789:	48 21 ca             	and    rdx,rcx
    178c:	48 c1 e2 0c          	shl    rdx,0xc
    1790:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1793:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    179d:	48 21 f1             	and    rcx,rsi
    17a0:	48 09 ca             	or     rdx,rcx
    17a3:	48 89 10             	mov    QWORD PTR [rax],rdx
								p->u = 1;
    17a6:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    17aa:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    17ad:	83 ca 04             	or     edx,0x4
    17b0:	88 10                	mov    BYTE PTR [rax],dl
								p->w = 1;
    17b2:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    17b6:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    17b9:	83 ca 02             	or     edx,0x2
    17bc:	88 10                	mov    BYTE PTR [rax],dl
								p->p = 1;
    17be:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    17c2:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    17c5:	83 ca 01             	or     edx,0x1
    17c8:	88 10                	mov    BYTE PTR [rax],dl
								if (cntrm) {
    17ca:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    17ce:	48 85 c0             	test   rax,rax
    17d1:	0f 84 aa 00 00 00    	je     1881 <mm_aoa_range+0x26f>
										if (lvl == 3) {
    17d7:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    17da:	83 f8 03             	cmp    eax,0x3
    17dd:	75 7b                	jne    185a <mm_aoa_range+0x248>
												struct vm_pg_ptrs64* vp = mm_kernel.ctx;
    17df:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17e6 <mm_aoa_range+0x1d4>
    17e6:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
												mm_alloc_pm(2, pr2, 2);
    17ea:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    17f1:	ba 02 00 00 00       	mov    edx,0x2
    17f6:	48 89 c6             	mov    rsi,rax
    17f9:	bf 02 00 00 00       	mov    edi,0x2
    17fe:	e8 00 00 00 00       	call   1803 <mm_aoa_range+0x1f1>
												map = __sync_fetch_and_sub(&vp->cur, 8096) - 4096;
    1803:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1807:	ba a0 1f 00 00       	mov    edx,0x1fa0
    180c:	48 f7 da             	neg    rdx
    180f:	f0 48 0f c1 10       	lock xadd QWORD PTR [rax],rdx
    1814:	48 8d 82 00 f0 ff ff 	lea    rax,[rdx-0x1000]
    181b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
												mm_map(&mm_kernel, map, pr2, pr2[0].count > 1 ? 1 : 2,
    181f:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1826:	48 83 f8 01          	cmp    rax,0x1
    182a:	76 07                	jbe    1833 <mm_aoa_range+0x221>
    182c:	b9 01 00 00 00       	mov    ecx,0x1
    1831:	eb 05                	jmp    1838 <mm_aoa_range+0x226>
    1833:	b9 02 00 00 00       	mov    ecx,0x2
    1838:	48 8d 95 60 ff ff ff 	lea    rdx,[rbp-0xa0]
    183f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1843:	41 b8 0c 00 00 00    	mov    r8d,0xc
    1849:	48 89 c6             	mov    rsi,rax
    184c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1853:	e8 00 00 00 00       	call   1858 <mm_aoa_range+0x246>
    1858:	eb 10                	jmp    186a <mm_aoa_range+0x258>
												map = mm_alloc_page(&b);
    185a:	48 8d 45 80          	lea    rax,[rbp-0x80]
    185e:	48 89 c7             	mov    rdi,rax
    1861:	e8 00 00 00 00       	call   1866 <mm_aoa_range+0x254>
    1866:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
										cntrm[ofs] = map;
    186a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    186e:	8b 55 a8             	mov    edx,DWORD PTR [rbp-0x58]
    1871:	89 d2                	mov    edx,edx
    1873:	48 c1 e2 03          	shl    rdx,0x3
    1877:	48 01 c2             	add    rdx,rax
    187a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    187e:	48 89 02             	mov    QWORD PTR [rdx],rax
								cntr[ofs] = ptr;
    1881:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1885:	8b 55 a8             	mov    edx,DWORD PTR [rbp-0x58]
    1888:	89 d2                	mov    edx,edx
    188a:	48 c1 e2 03          	shl    rdx,0x3
    188e:	48 01 c2             	add    rdx,rax
    1891:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1895:	48 89 02             	mov    QWORD PTR [rdx],rax
    1898:	e9 05 fe ff ff       	jmp    16a2 <mm_aoa_range+0x90>
								SPIN_CS(cntr[ofs]);
    189d:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    18a1:	8b 55 a8             	mov    edx,DWORD PTR [rbp-0x58]
    18a4:	89 d2                	mov    edx,edx
    18a6:	48 c1 e2 03          	shl    rdx,0x3
    18aa:	48 01 d0             	add    rax,rdx
    18ad:	48 8b 00             	mov    rax,QWORD PTR [rax]
    18b0:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
    18b4:	74 e7                	je     189d <mm_aoa_range+0x28b>
    18b6:	e9 e7 fd ff ff       	jmp    16a2 <mm_aoa_range+0x90>
				if (!cpu.has_pae) {
    18bb:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 18c2 <mm_aoa_range+0x2b0>
    18c2:	83 e0 40             	and    eax,0x40
    18c5:	84 c0                	test   al,al
    18c7:	0f 85 46 01 00 00    	jne    1a13 <mm_aoa_range+0x401>
						struct pte32* pte = e;
    18cd:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    18d1:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						while (ofs < 1024) {
    18d5:	e9 26 01 00 00       	jmp    1a00 <mm_aoa_range+0x3ee>
								if (pte->p)
    18da:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    18de:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    18e1:	83 e0 01             	and    eax,0x1
    18e4:	84 c0                	test   al,al
    18e6:	0f 85 f1 fd ff ff    	jne    16dd <mm_aoa_range+0xcb>
								pte->addr = pm_zero / 4096; /* cautonary */
    18ec:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18f3 <mm_aoa_range+0x2e1>
    18f3:	48 c1 e8 0c          	shr    rax,0xc
    18f7:	25 ff ff 0f 00       	and    eax,0xfffff
    18fc:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1900:	c1 e0 0c             	shl    eax,0xc
    1903:	89 c1                	mov    ecx,eax
    1905:	8b 02                	mov    eax,DWORD PTR [rdx]
    1907:	25 ff 0f 00 00       	and    eax,0xfff
    190c:	09 c8                	or     eax,ecx
    190e:	89 02                	mov    DWORD PTR [rdx],eax
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
    1910:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1914:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1917:	83 ca 04             	or     edx,0x4
    191a:	88 10                	mov    BYTE PTR [rax],dl
								pte->w = (w ? 1 : 0);
    191c:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    1920:	0f 95 c2             	setne  dl
    1923:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1927:	83 e2 01             	and    edx,0x1
    192a:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    192d:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1930:	83 e2 fd             	and    edx,0xfffffffd
    1933:	09 ca                	or     edx,ecx
    1935:	88 10                	mov    BYTE PTR [rax],dl
								pte->p = 0; /* that's the point of allocate-on-access */
    1937:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    193b:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    193e:	83 e2 fe             	and    edx,0xfffffffe
    1941:	88 10                	mov    BYTE PTR [rax],dl
								pte->s = (wc ? 1 : 0); /* PAT bit */
    1943:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    1947:	0f 95 c2             	setne  dl
    194a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    194e:	89 d1                	mov    ecx,edx
    1950:	c1 e1 07             	shl    ecx,0x7
    1953:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1956:	83 e2 7f             	and    edx,0x7f
    1959:	09 ca                	or     edx,ecx
    195b:	88 10                	mov    BYTE PTR [rax],dl
								pte->wt = (wt ? 1 : 0);
    195d:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    1961:	0f 95 c2             	setne  dl
    1964:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1968:	83 e2 01             	and    edx,0x1
    196b:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    1972:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1975:	83 e2 f7             	and    edx,0xfffffff7
    1978:	09 ca                	or     edx,ecx
    197a:	88 10                	mov    BYTE PTR [rax],dl
								pte->cd = (cd ? 1 : 0);
    197c:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    1980:	0f 95 c2             	setne  dl
    1983:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1987:	83 e2 01             	and    edx,0x1
    198a:	89 d1                	mov    ecx,edx
    198c:	c1 e1 04             	shl    ecx,0x4
    198f:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1992:	83 e2 ef             	and    edx,0xffffffef
    1995:	09 ca                	or     edx,ecx
    1997:	88 10                	mov    BYTE PTR [rax],dl
								pte->g = (g ? 1 : 0);
    1999:	83 7d d0 00          	cmp    DWORD PTR [rbp-0x30],0x0
    199d:	0f 95 c2             	setne  dl
    19a0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    19a4:	89 d1                	mov    ecx,edx
    19a6:	83 e1 01             	and    ecx,0x1
    19a9:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    19ad:	83 e2 fe             	and    edx,0xfffffffe
    19b0:	09 ca                	or     edx,ecx
    19b2:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								pte->ign = avl & 7;
    19b5:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    19b8:	83 e0 07             	and    eax,0x7
    19bb:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    19bf:	83 e0 07             	and    eax,0x7
    19c2:	8d 0c 00             	lea    ecx,[rax+rax*1]
    19c5:	0f b6 42 01          	movzx  eax,BYTE PTR [rdx+0x1]
    19c9:	83 e0 f1             	and    eax,0xfffffff1
    19cc:	09 c8                	or     eax,ecx
    19ce:	88 42 01             	mov    BYTE PTR [rdx+0x1],al
								pte++; ofs++; pg_ct--;
    19d1:	48 83 45 f0 04       	add    QWORD PTR [rbp-0x10],0x4
    19d6:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    19d9:	83 c0 01             	add    eax,0x1
    19dc:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
    19df:	48 83 ad 48 ff ff ff 01 	sub    QWORD PTR [rbp-0xb8],0x1
								virt_address += 4096;
    19e7:	48 81 85 50 ff ff ff 00 10 00 00 	add    QWORD PTR [rbp-0xb0],0x1000
								if (!pg_ct) /* exit if done */
    19f2:	48 83 bd 48 ff ff ff 00 	cmp    QWORD PTR [rbp-0xb8],0x0
    19fa:	0f 84 c0 01 00 00    	je     1bc0 <mm_aoa_range+0x5ae>
						while (ofs < 1024) {
    1a00:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1a03:	3d ff 03 00 00       	cmp    eax,0x3ff
    1a08:	0f 86 cc fe ff ff    	jbe    18da <mm_aoa_range+0x2c8>
    1a0e:	e9 9d 01 00 00       	jmp    1bb0 <mm_aoa_range+0x59e>
						struct pte64* pte = e;
    1a13:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1a17:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						while (ofs < 512) {
    1a1b:	e9 82 01 00 00       	jmp    1ba2 <mm_aoa_range+0x590>
								if (pte->p)
    1a20:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a24:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a27:	83 e0 01             	and    eax,0x1
    1a2a:	84 c0                	test   al,al
    1a2c:	0f 85 ae fc ff ff    	jne    16e0 <mm_aoa_range+0xce>

								/* set the flags */
								pte->addr = pm_zero / 4096; /* cautonary */
    1a32:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1a39 <mm_aoa_range+0x427>
    1a39:	48 c1 e8 0c          	shr    rax,0xc
    1a3d:	48 89 c2             	mov    rdx,rax
    1a40:	48 b8 ff ff ff ff ff 00 00 00 	movabs rax,0xffffffffff
    1a4a:	48 89 d1             	mov    rcx,rdx
    1a4d:	48 21 c1             	and    rcx,rax
    1a50:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a54:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    1a5e:	48 21 ca             	and    rdx,rcx
    1a61:	48 c1 e2 0c          	shl    rdx,0xc
    1a65:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1a68:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    1a72:	48 21 f1             	and    rcx,rsi
    1a75:	48 09 ca             	or     rdx,rcx
    1a78:	48 89 10             	mov    QWORD PTR [rax],rdx
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
    1a7b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a7f:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1a82:	83 ca 04             	or     edx,0x4
    1a85:	88 10                	mov    BYTE PTR [rax],dl
								pte->w = (w ? 1 : 0);
    1a87:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    1a8b:	0f 95 c2             	setne  dl
    1a8e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a92:	83 e2 01             	and    edx,0x1
    1a95:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    1a98:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1a9b:	83 e2 fd             	and    edx,0xfffffffd
    1a9e:	09 ca                	or     edx,ecx
    1aa0:	88 10                	mov    BYTE PTR [rax],dl
								pte->p = 0; /* that's the point of allocate-on-access */
    1aa2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1aa6:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1aa9:	83 e2 fe             	and    edx,0xfffffffe
    1aac:	88 10                	mov    BYTE PTR [rax],dl
								pte->s = (wc ? 1 : 0); /* PAT bit */
    1aae:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    1ab2:	0f 95 c2             	setne  dl
    1ab5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ab9:	89 d1                	mov    ecx,edx
    1abb:	c1 e1 07             	shl    ecx,0x7
    1abe:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1ac1:	83 e2 7f             	and    edx,0x7f
    1ac4:	09 ca                	or     edx,ecx
    1ac6:	88 10                	mov    BYTE PTR [rax],dl
								pte->wt = (wt ? 1 : 0);
    1ac8:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    1acc:	0f 95 c2             	setne  dl
    1acf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ad3:	83 e2 01             	and    edx,0x1
    1ad6:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    1add:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1ae0:	83 e2 f7             	and    edx,0xfffffff7
    1ae3:	09 ca                	or     edx,ecx
    1ae5:	88 10                	mov    BYTE PTR [rax],dl
								pte->cd = (cd ? 1 : 0);
    1ae7:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    1aeb:	0f 95 c2             	setne  dl
    1aee:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1af2:	83 e2 01             	and    edx,0x1
    1af5:	89 d1                	mov    ecx,edx
    1af7:	c1 e1 04             	shl    ecx,0x4
    1afa:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1afd:	83 e2 ef             	and    edx,0xffffffef
    1b00:	09 ca                	or     edx,ecx
    1b02:	88 10                	mov    BYTE PTR [rax],dl
								pte->g = (g ? 1 : 0);
    1b04:	83 7d d0 00          	cmp    DWORD PTR [rbp-0x30],0x0
    1b08:	0f 95 c2             	setne  dl
    1b0b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b0f:	89 d1                	mov    ecx,edx
    1b11:	83 e1 01             	and    ecx,0x1
    1b14:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    1b18:	83 e2 fe             	and    edx,0xfffffffe
    1b1b:	09 ca                	or     edx,ecx
    1b1d:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								if (cpu.e_has_nx)
    1b20:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1b27 <mm_aoa_range+0x515>
    1b27:	83 e0 10             	and    eax,0x10
    1b2a:	84 c0                	test   al,al
    1b2c:	74 1c                	je     1b4a <mm_aoa_range+0x538>
										pte->xd = (x ? 0 : 1);
    1b2e:	83 7d e4 00          	cmp    DWORD PTR [rbp-0x1c],0x0
    1b32:	0f 94 c2             	sete   dl
    1b35:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b39:	89 d1                	mov    ecx,edx
    1b3b:	c1 e1 07             	shl    ecx,0x7
    1b3e:	0f b6 50 07          	movzx  edx,BYTE PTR [rax+0x7]
    1b42:	83 e2 7f             	and    edx,0x7f
    1b45:	09 ca                	or     edx,ecx
    1b47:	88 50 07             	mov    BYTE PTR [rax+0x7],dl
								pte->ign = avl & 7;
    1b4a:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    1b4d:	83 e0 07             	and    eax,0x7
    1b50:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1b54:	83 e0 07             	and    eax,0x7
    1b57:	8d 0c 00             	lea    ecx,[rax+rax*1]
    1b5a:	0f b6 42 01          	movzx  eax,BYTE PTR [rdx+0x1]
    1b5e:	83 e0 f1             	and    eax,0xfffffff1
    1b61:	09 c8                	or     eax,ecx
    1b63:	88 42 01             	mov    BYTE PTR [rdx+0x1],al
								pte->ign2 = 0;
    1b66:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b6a:	0f b7 50 06          	movzx  edx,WORD PTR [rax+0x6]
    1b6e:	66 81 e2 0f 80       	and    dx,0x800f
    1b73:	66 89 50 06          	mov    WORD PTR [rax+0x6],dx
								/* advance */
								pte++; ofs++; pg_ct--;
    1b77:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
    1b7c:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1b7f:	83 c0 01             	add    eax,0x1
    1b82:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
    1b85:	48 83 ad 48 ff ff ff 01 	sub    QWORD PTR [rbp-0xb8],0x1
								virt_address += 4096;
    1b8d:	48 81 85 50 ff ff ff 00 10 00 00 	add    QWORD PTR [rbp-0xb0],0x1000
								if (!pg_ct) /* exit if done */
    1b98:	48 83 bd 48 ff ff ff 00 	cmp    QWORD PTR [rbp-0xb8],0x0
    1ba0:	74 21                	je     1bc3 <mm_aoa_range+0x5b1>
						while (ofs < 512) {
    1ba2:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1ba5:	3d ff 01 00 00       	cmp    eax,0x1ff
    1baa:	0f 86 70 fe ff ff    	jbe    1a20 <mm_aoa_range+0x40e>
		while (pg_ct) {
    1bb0:	48 83 bd 48 ff ff ff 00 	cmp    QWORD PTR [rbp-0xb8],0x0
    1bb8:	74 0a                	je     1bc4 <mm_aoa_range+0x5b2>
redo:
    1bba:	90                   	nop
    1bbb:	e9 e2 fa ff ff       	jmp    16a2 <mm_aoa_range+0x90>
										return;
    1bc0:	90                   	nop
    1bc1:	eb 01                	jmp    1bc4 <mm_aoa_range+0x5b2>
										return;
    1bc3:	90                   	nop
						}
				}
		}
}
    1bc4:	c9                   	leave
    1bc5:	c3                   	ret

0000000000001bc6 <mm_unmap>:

void mm_unmap(struct mm* mm, void* virt_address, size_t pg_ct)
{
    1bc6:	55                   	push   rbp
    1bc7:	48 89 e5             	mov    rbp,rsp
    1bca:	48 83 ec 60          	sub    rsp,0x60
    1bce:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    1bd2:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
    1bd6:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (pg_ct--) {
    1bda:	e9 1d 01 00 00       	jmp    1cfc <mm_unmap+0x136>
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
    1bdf:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1be3:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1be7:	4c 8d 4d e4          	lea    r9,[rbp-0x1c]
    1beb:	4c 8d 45 e8          	lea    r8,[rbp-0x18]
    1bef:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
    1bf3:	48 8d 55 d8          	lea    rdx,[rbp-0x28]
    1bf7:	48 8b 75 b0          	mov    rsi,QWORD PTR [rbp-0x50]
    1bfb:	48 8d 7d c0          	lea    rdi,[rbp-0x40]
    1bff:	57                   	push   rdi
    1c00:	48 8d 7d c8          	lea    rdi,[rbp-0x38]
    1c04:	57                   	push   rdi
    1c05:	48 89 c7             	mov    rdi,rax
    1c08:	e8 00 00 00 00       	call   1c0d <mm_unmap+0x47>
    1c0d:	48 83 c4 10          	add    rsp,0x10
    1c11:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
    1c14:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    1c18:	75 66                	jne    1c80 <mm_unmap+0xba>
						goto advance;

				e32 = NULL; e64 = NULL;
    1c1a:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1c22:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (!cpu.has_pae)
    1c2a:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1c31 <mm_unmap+0x6b>
    1c31:	83 e0 40             	and    eax,0x40
    1c34:	84 c0                	test   al,al
    1c36:	75 0a                	jne    1c42 <mm_unmap+0x7c>
						e32 = e;
    1c38:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1c3c:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    1c40:	eb 08                	jmp    1c4a <mm_unmap+0x84>
				else
						e64 = e;
    1c42:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1c46:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		
				/* make not present (TODO: clear as in free_vmem?) */
				if (!cpu.has_pae)
    1c4a:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1c51 <mm_unmap+0x8b>
    1c51:	83 e0 40             	and    eax,0x40
    1c54:	84 c0                	test   al,al
    1c56:	75 0e                	jne    1c66 <mm_unmap+0xa0>
						e32->p = 0;
    1c58:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1c5c:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1c5f:	83 e2 fe             	and    edx,0xfffffffe
    1c62:	88 10                	mov    BYTE PTR [rax],dl
    1c64:	eb 0c                	jmp    1c72 <mm_unmap+0xac>
				else
						e64->p = 0;
    1c66:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1c6a:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1c6d:	83 e2 fe             	and    edx,0xfffffffe
    1c70:	88 10                	mov    BYTE PTR [rax],dl

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
    1c72:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c76:	48 89 c7             	mov    rdi,rax
    1c79:	e8 9d e3 ff ff       	call   1b <flush_tlb_single>
    1c7e:	eb 01                	jmp    1c81 <mm_unmap+0xbb>
						goto advance;
    1c80:	90                   	nop
		
				/* advance */
advance:
				if (!lv) /* regular page */
    1c81:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1c84:	85 c0                	test   eax,eax
    1c86:	75 0a                	jne    1c92 <mm_unmap+0xcc>
						virt_address += 4096;
    1c88:	48 81 45 b0 00 10 00 00 	add    QWORD PTR [rbp-0x50],0x1000
    1c90:	eb 6a                	jmp    1cfc <mm_unmap+0x136>
				else if (lv == 1) /* large page 2M/4M */
    1c92:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1c95:	83 f8 01             	cmp    eax,0x1
    1c98:	75 20                	jne    1cba <mm_unmap+0xf4>
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
    1c9a:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1ca1 <mm_unmap+0xdb>
    1ca1:	83 e0 40             	and    eax,0x40
    1ca4:	84 c0                	test   al,al
    1ca6:	74 07                	je     1caf <mm_unmap+0xe9>
    1ca8:	b8 00 00 80 00       	mov    eax,0x800000
    1cad:	eb 05                	jmp    1cb4 <mm_unmap+0xee>
    1caf:	b8 00 00 00 01       	mov    eax,0x1000000
    1cb4:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
    1cb8:	eb 42                	jmp    1cfc <mm_unmap+0x136>
				else if (lv == 2) /* huge page 1G */
    1cba:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1cbd:	83 f8 02             	cmp    eax,0x2
    1cc0:	75 0a                	jne    1ccc <mm_unmap+0x106>
						virt_address += 1024 * 1024 * 1024;
    1cc2:	48 81 45 b0 00 00 00 40 	add    QWORD PTR [rbp-0x50],0x40000000
    1cca:	eb 30                	jmp    1cfc <mm_unmap+0x136>
				else
						die("ginormous page?\n");
    1ccc:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1cd3:	bf 0c 00 00 00       	mov    edi,0xc
    1cd8:	b8 00 00 00 00       	mov    eax,0x0
    1cdd:	e8 00 00 00 00       	call   1ce2 <mm_unmap+0x11c>
    1ce2:	b8 00 00 00 00       	mov    eax,0x0
    1ce7:	e8 00 00 00 00       	call   1cec <mm_unmap+0x126>
    1cec:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1cf3:	e8 00 00 00 00       	call   1cf8 <mm_unmap+0x132>
    1cf8:	fa                   	cli
    1cf9:	f4                   	hlt
    1cfa:	eb fd                	jmp    1cf9 <mm_unmap+0x133>
		while (pg_ct--) {
    1cfc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1d00:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    1d04:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
    1d08:	48 85 c0             	test   rax,rax
    1d0b:	0f 85 ce fe ff ff    	jne    1bdf <mm_unmap+0x19>
		}
}
    1d11:	90                   	nop
    1d12:	90                   	nop
    1d13:	c9                   	leave
    1d14:	c3                   	ret

0000000000001d15 <mm_alloc_vmem>:

void* mm_alloc_vmem(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
    1d15:	55                   	push   rbp
    1d16:	48 89 e5             	mov    rbp,rsp
    1d19:	48 81 ec 80 01 00 00 	sub    rsp,0x180
    1d20:	48 89 bd 98 fe ff ff 	mov    QWORD PTR [rbp-0x168],rdi
    1d27:	48 89 b5 90 fe ff ff 	mov    QWORD PTR [rbp-0x170],rsi
    1d2e:	48 89 95 88 fe ff ff 	mov    QWORD PTR [rbp-0x178],rdx
    1d35:	89 8d 84 fe ff ff    	mov    DWORD PTR [rbp-0x17c],ecx
		if (!virt_address)
    1d3b:	48 83 bd 90 fe ff ff 00 	cmp    QWORD PTR [rbp-0x170],0x0
    1d43:	75 26                	jne    1d6b <mm_alloc_vmem+0x56>
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);
    1d45:	8b 95 84 fe ff ff    	mov    edx,DWORD PTR [rbp-0x17c]
    1d4b:	48 8b 8d 88 fe ff ff 	mov    rcx,QWORD PTR [rbp-0x178]
    1d52:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1d59:	48 89 ce             	mov    rsi,rcx
    1d5c:	48 89 c7             	mov    rdi,rax
    1d5f:	e8 00 00 00 00       	call   1d64 <mm_alloc_vmem+0x4f>
    1d64:	48 89 85 90 fe ff ff 	mov    QWORD PTR [rbp-0x170],rax

		if ((flags & MMGR_ALLOC_CONTIGUOUS) == MMGR_ALLOC_CONTIGUOUS) {
    1d6b:	8b 85 84 fe ff ff    	mov    eax,DWORD PTR [rbp-0x17c]
    1d71:	25 00 00 03 00       	and    eax,0x30000
    1d76:	3d 00 00 03 00       	cmp    eax,0x30000
    1d7b:	0f 85 8c 00 00 00    	jne    1e0d <mm_alloc_vmem+0xf8>
				struct page_range pr; size_t ct;
				/* FIXME: Implement cont. allocator for PMEM */
				ct = mm_alloc_pm(pg_ct, &pr, 1);
    1d81:	48 8b 85 88 fe ff ff 	mov    rax,QWORD PTR [rbp-0x178]
    1d88:	89 c1                	mov    ecx,eax
    1d8a:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    1d8e:	ba 01 00 00 00       	mov    edx,0x1
    1d93:	48 89 c6             	mov    rsi,rax
    1d96:	89 cf                	mov    edi,ecx
    1d98:	e8 00 00 00 00       	call   1d9d <mm_alloc_vmem+0x88>
    1d9d:	89 c0                	mov    eax,eax
    1d9f:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				if (ct < pg_ct) {
    1da3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1da7:	48 3b 85 88 fe ff ff 	cmp    rax,QWORD PTR [rbp-0x178]
    1dae:	73 30                	jae    1de0 <mm_alloc_vmem+0xcb>
						die("Contiguous allocation failed\n");
    1db0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1db7:	bf 0c 00 00 00       	mov    edi,0xc
    1dbc:	b8 00 00 00 00       	mov    eax,0x0
    1dc1:	e8 00 00 00 00       	call   1dc6 <mm_alloc_vmem+0xb1>
    1dc6:	b8 00 00 00 00       	mov    eax,0x0
    1dcb:	e8 00 00 00 00       	call   1dd0 <mm_alloc_vmem+0xbb>
    1dd0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1dd7:	e8 00 00 00 00       	call   1ddc <mm_alloc_vmem+0xc7>
    1ddc:	fa                   	cli
    1ddd:	f4                   	hlt
    1dde:	eb fd                	jmp    1ddd <mm_alloc_vmem+0xc8>
				}
				return mm_map(mm, virt_address, &pr, 1, flags);
    1de0:	8b 8d 84 fe ff ff    	mov    ecx,DWORD PTR [rbp-0x17c]
    1de6:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
    1dea:	48 8b b5 90 fe ff ff 	mov    rsi,QWORD PTR [rbp-0x170]
    1df1:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1df8:	41 89 c8             	mov    r8d,ecx
    1dfb:	b9 01 00 00 00       	mov    ecx,0x1
    1e00:	48 89 c7             	mov    rdi,rax
    1e03:	e8 00 00 00 00       	call   1e08 <mm_alloc_vmem+0xf3>
    1e08:	e9 7c 01 00 00       	jmp    1f89 <mm_alloc_vmem+0x274>
		} else if ((flags & MMGR_ALLOC_ZERO_COW) == MMGR_ALLOC_ZERO_COW) {
    1e0d:	8b 85 84 fe ff ff    	mov    eax,DWORD PTR [rbp-0x17c]
    1e13:	25 00 00 01 00       	and    eax,0x10000
    1e18:	85 c0                	test   eax,eax
    1e1a:	74 6b                	je     1e87 <mm_alloc_vmem+0x172>
				void* rv = virt_address;
    1e1c:	48 8b 85 90 fe ff ff 	mov    rax,QWORD PTR [rbp-0x170]
    1e23:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				struct page_range pr = { pm_zero, 1 };
    1e27:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e2e <mm_alloc_vmem+0x119>
    1e2e:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
    1e32:	48 c7 45 a8 01 00 00 00 	mov    QWORD PTR [rbp-0x58],0x1
				while (pg_ct) {
    1e3a:	eb 38                	jmp    1e74 <mm_alloc_vmem+0x15f>
						mm_map(mm, virt_address, &pr, 1, flags | MMGR_MAP_COW);
    1e3c:	8b 85 84 fe ff ff    	mov    eax,DWORD PTR [rbp-0x17c]
    1e42:	80 cc 02             	or     ah,0x2
    1e45:	89 c1                	mov    ecx,eax
    1e47:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
    1e4b:	48 8b b5 90 fe ff ff 	mov    rsi,QWORD PTR [rbp-0x170]
    1e52:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1e59:	41 89 c8             	mov    r8d,ecx
    1e5c:	b9 01 00 00 00       	mov    ecx,0x1
    1e61:	48 89 c7             	mov    rdi,rax
    1e64:	e8 00 00 00 00       	call   1e69 <mm_alloc_vmem+0x154>
						virt_address += 4096;
    1e69:	48 81 85 90 fe ff ff 00 10 00 00 	add    QWORD PTR [rbp-0x170],0x1000
				while (pg_ct) {
    1e74:	48 83 bd 88 fe ff ff 00 	cmp    QWORD PTR [rbp-0x178],0x0
    1e7c:	75 be                	jne    1e3c <mm_alloc_vmem+0x127>
				}
				return rv;
    1e7e:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1e82:	e9 02 01 00 00       	jmp    1f89 <mm_alloc_vmem+0x274>
		} else if ((flags & MMGR_ALLOC_NP_AOA) == MMGR_ALLOC_NP_AOA) {
    1e87:	8b 85 84 fe ff ff    	mov    eax,DWORD PTR [rbp-0x17c]
    1e8d:	25 00 00 02 00       	and    eax,0x20000
    1e92:	85 c0                	test   eax,eax
    1e94:	74 37                	je     1ecd <mm_alloc_vmem+0x1b8>
				void* rv = virt_address;
    1e96:	48 8b 85 90 fe ff ff 	mov    rax,QWORD PTR [rbp-0x170]
    1e9d:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				mm_aoa_range(mm, virt_address, pg_ct, flags);
    1ea1:	8b 8d 84 fe ff ff    	mov    ecx,DWORD PTR [rbp-0x17c]
    1ea7:	48 8b 95 88 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x178]
    1eae:	48 8b b5 90 fe ff ff 	mov    rsi,QWORD PTR [rbp-0x170]
    1eb5:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1ebc:	48 89 c7             	mov    rdi,rax
    1ebf:	e8 00 00 00 00       	call   1ec4 <mm_alloc_vmem+0x1af>
				return rv;
    1ec4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ec8:	e9 bc 00 00 00       	jmp    1f89 <mm_alloc_vmem+0x274>
		} else {
				void* rv = virt_address;
    1ecd:	48 8b 85 90 fe ff ff 	mov    rax,QWORD PTR [rbp-0x170]
    1ed4:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				do {
						struct page_range pr[16]; size_t ct, ct2, prc = 0;
    1ed8:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
						ct = ct2 = mm_alloc_pm(pg_ct, pr, 16);
    1ee0:	48 8b 85 88 fe ff ff 	mov    rax,QWORD PTR [rbp-0x178]
    1ee7:	89 c1                	mov    ecx,eax
    1ee9:	48 8d 85 a0 fe ff ff 	lea    rax,[rbp-0x160]
    1ef0:	ba 10 00 00 00       	mov    edx,0x10
    1ef5:	48 89 c6             	mov    rsi,rax
    1ef8:	89 cf                	mov    edi,ecx
    1efa:	e8 00 00 00 00       	call   1eff <mm_alloc_vmem+0x1ea>
    1eff:	89 c0                	mov    eax,eax
    1f01:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1f05:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1f09:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						pg_ct -= ct;
    1f0d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1f11:	48 29 85 88 fe ff ff 	sub    QWORD PTR [rbp-0x178],rax
						while (ct) {
    1f18:	eb 1d                	jmp    1f37 <mm_alloc_vmem+0x222>
								ct -= pr[prc].count;
    1f1a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f1e:	48 c1 e0 04          	shl    rax,0x4
    1f22:	48 01 e8             	add    rax,rbp
    1f25:	48 2d 58 01 00 00    	sub    rax,0x158
    1f2b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1f2e:	48 29 45 f8          	sub    QWORD PTR [rbp-0x8],rax
								prc++;
    1f32:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
						while (ct) {
    1f37:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1f3c:	75 dc                	jne    1f1a <mm_alloc_vmem+0x205>
						}
						 mm_map(mm, virt_address, &pr, prc, flags);
    1f3e:	8b bd 84 fe ff ff    	mov    edi,DWORD PTR [rbp-0x17c]
    1f44:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    1f48:	48 8d 95 a0 fe ff ff 	lea    rdx,[rbp-0x160]
    1f4f:	48 8b b5 90 fe ff ff 	mov    rsi,QWORD PTR [rbp-0x170]
    1f56:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1f5d:	41 89 f8             	mov    r8d,edi
    1f60:	48 89 c7             	mov    rdi,rax
    1f63:	e8 00 00 00 00       	call   1f68 <mm_alloc_vmem+0x253>
						 virt_address += 4096 * ct2;
    1f68:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1f6c:	48 c1 e0 0c          	shl    rax,0xc
    1f70:	48 01 85 90 fe ff ff 	add    QWORD PTR [rbp-0x170],rax
				} while (pg_ct);
    1f77:	48 83 bd 88 fe ff ff 00 	cmp    QWORD PTR [rbp-0x178],0x0
    1f7f:	0f 85 53 ff ff ff    	jne    1ed8 <mm_alloc_vmem+0x1c3>
				return rv;
    1f85:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
		}
}
    1f89:	c9                   	leave
    1f8a:	c3                   	ret

0000000000001f8b <mm_extend_vmem>:

void* mm_extend_vmem(struct mm* mm, void* ptr, size_t pg_ct, size_t new_pg_ct, int flg)
{
    1f8b:	55                   	push   rbp
    1f8c:	48 89 e5             	mov    rbp,rsp
    1f8f:	48 81 ec 80 08 00 00 	sub    rsp,0x880
    1f96:	48 89 bd a8 f7 ff ff 	mov    QWORD PTR [rbp-0x858],rdi
    1f9d:	48 89 b5 a0 f7 ff ff 	mov    QWORD PTR [rbp-0x860],rsi
    1fa4:	48 89 95 98 f7 ff ff 	mov    QWORD PTR [rbp-0x868],rdx
    1fab:	48 89 8d 90 f7 ff ff 	mov    QWORD PTR [rbp-0x870],rcx
    1fb2:	44 89 85 8c f7 ff ff 	mov    DWORD PTR [rbp-0x874],r8d
		size_t new_pmem = new_pg_ct - pg_ct, pm_res, p0c = 0, p1c = 0;
    1fb9:	48 8b 85 90 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x870]
    1fc0:	48 2b 85 98 f7 ff ff 	sub    rax,QWORD PTR [rbp-0x868]
    1fc7:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    1fcb:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    1fd3:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		void *rv, *p0 = ptr, *p1;
    1fdb:	48 8b 85 a0 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x860]
    1fe2:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		struct page_range prs[128];
		if (!ptr || new_pg_ct <= pg_ct)
    1fe6:	48 83 bd a0 f7 ff ff 00 	cmp    QWORD PTR [rbp-0x860],0x0
    1fee:	74 10                	je     2000 <mm_extend_vmem+0x75>
    1ff0:	48 8b 85 90 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x870]
    1ff7:	48 39 85 98 f7 ff ff 	cmp    QWORD PTR [rbp-0x868],rax
    1ffe:	72 0a                	jb     200a <mm_extend_vmem+0x7f>
				return NULL;
    2000:	b8 00 00 00 00       	mov    eax,0x0
    2005:	e9 09 02 00 00       	jmp    2213 <mm_extend_vmem+0x288>
		/* reserve virtual memory */
		rv = mm_reserve_vmem(mm, new_pg_ct, flg);
    200a:	8b 95 8c f7 ff ff    	mov    edx,DWORD PTR [rbp-0x874]
    2010:	48 8b 8d 90 f7 ff ff 	mov    rcx,QWORD PTR [rbp-0x870]
    2017:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    201e:	48 89 ce             	mov    rsi,rcx
    2021:	48 89 c7             	mov    rdi,rax
    2024:	e8 00 00 00 00       	call   2029 <mm_extend_vmem+0x9e>
    2029:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		if (!rv)
    202d:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
    2032:	75 0a                	jne    203e <mm_extend_vmem+0xb3>
				return NULL;
    2034:	b8 00 00 00 00       	mov    eax,0x0
    2039:	e9 d5 01 00 00       	jmp    2213 <mm_extend_vmem+0x288>

		/* remap the existing pages */
		p1 = rv;
    203e:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2042:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		while (pg_ct) {
    2046:	e9 b9 00 00 00       	jmp    2104 <mm_extend_vmem+0x179>
				struct page_range pr;
				pr.base = mm_page_get_pmem(mm, p0);
    204b:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    204f:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    2056:	48 89 d6             	mov    rsi,rdx
    2059:	48 89 c7             	mov    rdi,rax
    205c:	e8 00 00 00 00       	call   2061 <mm_extend_vmem+0xd6>
    2061:	48 89 85 b0 f7 ff ff 	mov    QWORD PTR [rbp-0x850],rax
				pr.count = 1; flg = 0;
    2068:	48 c7 85 b8 f7 ff ff 01 00 00 00 	mov    QWORD PTR [rbp-0x848],0x1
    2073:	c7 85 8c f7 ff ff 00 00 00 00 	mov    DWORD PTR [rbp-0x874],0x0
				if (!mm_map(mm, p1, &pr, 1, flg)) {
    207d:	8b 8d 8c f7 ff ff    	mov    ecx,DWORD PTR [rbp-0x874]
    2083:	48 8d 95 b0 f7 ff ff 	lea    rdx,[rbp-0x850]
    208a:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    208e:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    2095:	41 89 c8             	mov    r8d,ecx
    2098:	b9 01 00 00 00       	mov    ecx,0x1
    209d:	48 89 c7             	mov    rdi,rax
    20a0:	e8 00 00 00 00       	call   20a5 <mm_extend_vmem+0x11a>
    20a5:	48 85 c0             	test   rax,rax
    20a8:	75 3d                	jne    20e7 <mm_extend_vmem+0x15c>
						if (p0c) /* undo the new mapping */
    20aa:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    20af:	74 2c                	je     20dd <mm_extend_vmem+0x152>
								mm_unmap(mm, rv - p0c * 4096, p0c);
    20b1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20b5:	48 c1 e0 0c          	shl    rax,0xc
    20b9:	48 f7 d8             	neg    rax
    20bc:	48 89 c2             	mov    rdx,rax
    20bf:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    20c3:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    20c7:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    20cb:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    20d2:	48 89 ce             	mov    rsi,rcx
    20d5:	48 89 c7             	mov    rdi,rax
    20d8:	e8 00 00 00 00       	call   20dd <mm_extend_vmem+0x152>
						return NULL;
    20dd:	b8 00 00 00 00       	mov    eax,0x0
    20e2:	e9 2c 01 00 00       	jmp    2213 <mm_extend_vmem+0x288>
				}
				p0c++; pg_ct--;
    20e7:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    20ec:	48 83 ad 98 f7 ff ff 01 	sub    QWORD PTR [rbp-0x868],0x1
				p0 += 4096;
    20f4:	48 81 45 e8 00 10 00 00 	add    QWORD PTR [rbp-0x18],0x1000
				p1 += 4096;
    20fc:	48 81 45 e0 00 10 00 00 	add    QWORD PTR [rbp-0x20],0x1000
		while (pg_ct) {
    2104:	48 83 bd 98 f7 ff ff 00 	cmp    QWORD PTR [rbp-0x868],0x0
    210c:	0f 85 39 ff ff ff    	jne    204b <mm_extend_vmem+0xc0>
		}
		/* now get the physical memory and map it */
		while (new_pmem) {
    2112:	e9 d0 00 00 00       	jmp    21e7 <mm_extend_vmem+0x25c>
				pm_res = mm_alloc_pm(new_pmem, prs, 128);
    2117:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    211b:	89 c1                	mov    ecx,eax
    211d:	48 8d 85 c0 f7 ff ff 	lea    rax,[rbp-0x840]
    2124:	ba 80 00 00 00       	mov    edx,0x80
    2129:	48 89 c6             	mov    rsi,rax
    212c:	89 cf                	mov    edi,ecx
    212e:	e8 00 00 00 00       	call   2133 <mm_extend_vmem+0x1a8>
    2133:	89 c0                	mov    eax,eax
    2135:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				if (!pm_res) {
    2139:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    213e:	75 4d                	jne    218d <mm_extend_vmem+0x202>
						/* out of pmem */
						mm_free_vmem(mm, rv + p0c * 4096, p1c);
    2140:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2144:	48 c1 e0 0c          	shl    rax,0xc
    2148:	48 89 c2             	mov    rdx,rax
    214b:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    214f:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    2153:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    2157:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    215e:	48 89 ce             	mov    rsi,rcx
    2161:	48 89 c7             	mov    rdi,rax
    2164:	e8 00 00 00 00       	call   2169 <mm_extend_vmem+0x1de>
						mm_unmap(mm, rv, p0c);
    2169:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    216d:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    2171:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    2178:	48 89 ce             	mov    rsi,rcx
    217b:	48 89 c7             	mov    rdi,rax
    217e:	e8 00 00 00 00       	call   2183 <mm_extend_vmem+0x1f8>
						return NULL;
    2183:	b8 00 00 00 00       	mov    eax,0x0
    2188:	e9 86 00 00 00       	jmp    2213 <mm_extend_vmem+0x288>
				}
				if (!mm_map(mm, p1, prs, 128, flg)) {
    218d:	8b 8d 8c f7 ff ff    	mov    ecx,DWORD PTR [rbp-0x874]
    2193:	48 8d 95 c0 f7 ff ff 	lea    rdx,[rbp-0x840]
    219a:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    219e:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    21a5:	41 89 c8             	mov    r8d,ecx
    21a8:	b9 80 00 00 00       	mov    ecx,0x80
    21ad:	48 89 c7             	mov    rdi,rax
    21b0:	e8 00 00 00 00       	call   21b5 <mm_extend_vmem+0x22a>
    21b5:	48 85 c0             	test   rax,rax
    21b8:	75 19                	jne    21d3 <mm_extend_vmem+0x248>
						/* cannot happen on reserved mem */
						cprintf(KFMT_ERROR, "Error while mapping virtual memory which was already reserved.");
    21ba:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    21c1:	bf 0c 00 00 00       	mov    edi,0xc
    21c6:	b8 00 00 00 00       	mov    eax,0x0
    21cb:	e8 00 00 00 00       	call   21d0 <mm_extend_vmem+0x245>
						while (1);
    21d0:	90                   	nop
    21d1:	eb fd                	jmp    21d0 <mm_extend_vmem+0x245>
				} else {
						p1 += pm_res * 4096;
    21d3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    21d7:	48 c1 e0 0c          	shl    rax,0xc
    21db:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
						p1c += pm_res;
    21df:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    21e3:	48 01 45 f0          	add    QWORD PTR [rbp-0x10],rax
		while (new_pmem) {
    21e7:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    21ec:	0f 85 25 ff ff ff    	jne    2117 <mm_extend_vmem+0x18c>
				}
		}
		/* and unmap the old memory */
		mm_unmap(mm, ptr, p0c);
    21f2:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    21f6:	48 8b 8d a0 f7 ff ff 	mov    rcx,QWORD PTR [rbp-0x860]
    21fd:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    2204:	48 89 ce             	mov    rsi,rcx
    2207:	48 89 c7             	mov    rdi,rax
    220a:	e8 00 00 00 00       	call   220f <mm_extend_vmem+0x284>
		return rv;
    220f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
}
    2213:	c9                   	leave
    2214:	c3                   	ret

0000000000002215 <mm_free_vmem>:

void mm_free_vmem(struct mm* mm, void* virt_address, size_t pg_ct)
{
    2215:	55                   	push   rbp
    2216:	48 89 e5             	mov    rbp,rsp
    2219:	48 83 ec 70          	sub    rsp,0x70
    221d:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    2221:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
    2225:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};
    2229:	48 c7 45 b0 00 00 00 00 	mov    QWORD PTR [rbp-0x50],0x0
    2231:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0

		/* check every page */
		while (pg_ct--) {
    2239:	e9 52 01 00 00       	jmp    2390 <mm_free_vmem+0x17b>
				/* first get the references to the structures */
				rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);
    223e:	4c 8d 4d ec          	lea    r9,[rbp-0x14]
    2242:	4c 8d 45 f0          	lea    r8,[rbp-0x10]
    2246:	48 8d 4d d8          	lea    rcx,[rbp-0x28]
    224a:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    224e:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
    2252:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2256:	48 8d 7d c8          	lea    rdi,[rbp-0x38]
    225a:	57                   	push   rdi
    225b:	48 8d 7d d0          	lea    rdi,[rbp-0x30]
    225f:	57                   	push   rdi
    2260:	48 89 c7             	mov    rdi,rax
    2263:	e8 00 00 00 00       	call   2268 <mm_free_vmem+0x53>
    2268:	48 83 c4 10          	add    rsp,0x10
    226c:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax

				if (rv == 0) { /* present page */
    226f:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    2273:	0f 85 ab 00 00 00    	jne    2324 <mm_free_vmem+0x10f>
						uint64_t b;
						/* get the physical memory */
						if (!cpu.has_pae)
    2279:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2280 <mm_free_vmem+0x6b>
    2280:	83 e0 40             	and    eax,0x40
    2283:	84 c0                	test   al,al
    2285:	75 14                	jne    229b <mm_free_vmem+0x86>
								b = ((struct pte32*)e)->addr * 0x1000;
    2287:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    228b:	8b 00                	mov    eax,DWORD PTR [rax]
    228d:	c1 e8 0c             	shr    eax,0xc
    2290:	c1 e0 0c             	shl    eax,0xc
    2293:	48 98                	cdqe
    2295:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    2299:	eb 2d                	jmp    22c8 <mm_free_vmem+0xb3>
						else
								b = ((struct pte64*)e)->addr * 0x1000;
    229b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    229f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    22a2:	48 c1 e8 0c          	shr    rax,0xc
    22a6:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    22b0:	48 21 d0             	and    rax,rdx
    22b3:	48 c1 e0 0c          	shl    rax,0xc
    22b7:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    22c1:	48 21 d0             	and    rax,rdx
    22c4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						/* concat if possible */
						if (pr.count) {
    22c8:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    22cc:	48 85 c0             	test   rax,rax
    22cf:	74 41                	je     2312 <mm_free_vmem+0xfd>
								if (pr.base + 4096 * pr.count == b)
    22d1:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    22d5:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    22d9:	48 c1 e2 0c          	shl    rdx,0xc
    22dd:	48 01 d0             	add    rax,rdx
    22e0:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    22e4:	75 11                	jne    22f7 <mm_free_vmem+0xe2>
										pr.count++;
    22e6:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    22ea:	48 83 c0 01          	add    rax,0x1
    22ee:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    22f2:	e9 91 00 00 00       	jmp    2388 <mm_free_vmem+0x173>
								else {
										/* deallocate */
										mm_free_pm(&pr, 1);
    22f7:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    22fb:	be 01 00 00 00       	mov    esi,0x1
    2300:	48 89 c7             	mov    rdi,rax
    2303:	e8 00 00 00 00       	call   2308 <mm_free_vmem+0xf3>
										pr.count = 0;
    2308:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
    2310:	eb 76                	jmp    2388 <mm_free_vmem+0x173>
								}
						} else {
								pr.base = b;
    2312:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2316:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
								pr.count = 1;
    231a:	48 c7 45 b8 01 00 00 00 	mov    QWORD PTR [rbp-0x48],0x1
    2322:	eb 64                	jmp    2388 <mm_free_vmem+0x173>
						}
				} else if (e) { /* AOW etc. */
    2324:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2328:	48 85 c0             	test   rax,rax
    232b:	74 2b                	je     2358 <mm_free_vmem+0x143>
						bzero(e, cpu.has_pae ? 8 : 4);
    232d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2334 <mm_free_vmem+0x11f>
    2334:	83 e0 40             	and    eax,0x40
    2337:	84 c0                	test   al,al
    2339:	74 07                	je     2342 <mm_free_vmem+0x12d>
    233b:	ba 08 00 00 00       	mov    edx,0x8
    2340:	eb 05                	jmp    2347 <mm_free_vmem+0x132>
    2342:	ba 04 00 00 00       	mov    edx,0x4
    2347:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    234b:	48 89 d6             	mov    rsi,rdx
    234e:	48 89 c7             	mov    rdi,rax
    2351:	e8 00 00 00 00       	call   2356 <mm_free_vmem+0x141>
    2356:	eb 30                	jmp    2388 <mm_free_vmem+0x173>
				} else {
						/* invalid address */
						die("Invalid virtual address specified in free_vmem.\n");
    2358:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    235f:	bf 0c 00 00 00       	mov    edi,0xc
    2364:	b8 00 00 00 00       	mov    eax,0x0
    2369:	e8 00 00 00 00       	call   236e <mm_free_vmem+0x159>
    236e:	b8 00 00 00 00       	mov    eax,0x0
    2373:	e8 00 00 00 00       	call   2378 <mm_free_vmem+0x163>
    2378:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    237f:	e8 00 00 00 00       	call   2384 <mm_free_vmem+0x16f>
    2384:	fa                   	cli
    2385:	f4                   	hlt
    2386:	eb fd                	jmp    2385 <mm_free_vmem+0x170>
				}

				/* advance */
				virt_address += 4096;
    2388:	48 81 45 a0 00 10 00 00 	add    QWORD PTR [rbp-0x60],0x1000
		while (pg_ct--) {
    2390:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2394:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    2398:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
    239c:	48 85 c0             	test   rax,rax
    239f:	0f 85 99 fe ff ff    	jne    223e <mm_free_vmem+0x29>
		}

		/* remove remaining pmem */
		if (pr.count)
    23a5:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    23a9:	48 85 c0             	test   rax,rax
    23ac:	74 11                	je     23bf <mm_free_vmem+0x1aa>
				mm_free_pm(&pr, 1);
    23ae:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    23b2:	be 01 00 00 00       	mov    esi,0x1
    23b7:	48 89 c7             	mov    rdi,rax
    23ba:	e8 00 00 00 00       	call   23bf <mm_free_vmem+0x1aa>
}
    23bf:	90                   	nop
    23c0:	c9                   	leave
    23c1:	c3                   	ret

00000000000023c2 <mm_page_walk>:

int mm_page_walk(struct mm* mm, void* vmem, void** p, void** e, int* lv,
				uint32_t* of, void*** cntr, void*** cntrm)
{
    23c2:	55                   	push   rbp
    23c3:	48 89 e5             	mov    rbp,rsp
    23c6:	48 83 ec 30          	sub    rsp,0x30
    23ca:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    23ce:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
    23d2:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
    23d6:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
    23da:	4c 89 45 d8          	mov    QWORD PTR [rbp-0x28],r8
    23de:	4c 89 4d d0          	mov    QWORD PTR [rbp-0x30],r9
#ifdef __x86_64__
		return mm_page_walk64(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
    23e2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    23e6:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    23ea:	4c 8b 45 d0          	mov    r8,QWORD PTR [rbp-0x30]
    23ee:	48 8b 7d d8          	mov    rdi,QWORD PTR [rbp-0x28]
    23f2:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
    23f6:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    23fa:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
    23fe:	ff 75 18             	push   QWORD PTR [rbp+0x18]
    2401:	ff 75 10             	push   QWORD PTR [rbp+0x10]
    2404:	4d 89 c1             	mov    r9,r8
    2407:	49 89 f8             	mov    r8,rdi
    240a:	48 89 c7             	mov    rdi,rax
    240d:	e8 00 00 00 00       	call   2412 <mm_page_walk+0x50>
    2412:	48 83 c4 10          	add    rsp,0x10
		if (cpu.has_pae)
				return mm_page_walk36(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
		else
				return mm_page_walk32(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
#endif
}
    2416:	c9                   	leave
    2417:	c3                   	ret

0000000000002418 <mm_page_get_pmem>:

uint64_t mm_page_get_pmem(struct mm* mm, void* virt_address)
{
    2418:	55                   	push   rbp
    2419:	48 89 e5             	mov    rbp,rsp
    241c:	48 83 ec 50          	sub    rsp,0x50
    2420:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    2424:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};
    2428:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
    2430:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0

		/* first get the references to the structures */
		rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);
    2438:	4c 8d 4d f4          	lea    r9,[rbp-0xc]
    243c:	4c 8d 45 f8          	lea    r8,[rbp-0x8]
    2440:	48 8d 4d e0          	lea    rcx,[rbp-0x20]
    2444:	48 8d 55 e8          	lea    rdx,[rbp-0x18]
    2448:	48 8b 75 b0          	mov    rsi,QWORD PTR [rbp-0x50]
    244c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2450:	48 8d 7d d0          	lea    rdi,[rbp-0x30]
    2454:	57                   	push   rdi
    2455:	48 8d 7d d8          	lea    rdi,[rbp-0x28]
    2459:	57                   	push   rdi
    245a:	48 89 c7             	mov    rdi,rax
    245d:	e8 00 00 00 00       	call   2462 <mm_page_get_pmem+0x4a>
    2462:	48 83 c4 10          	add    rsp,0x10
    2466:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax

		if (!rv)
    2469:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    246d:	75 0c                	jne    247b <mm_page_get_pmem+0x63>
				return (uint64_t)-1;
    246f:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
    2476:	e9 91 00 00 00       	jmp    250c <mm_page_get_pmem+0xf4>
		else if (!lv) {
    247b:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    247e:	85 c0                	test   eax,eax
    2480:	75 49                	jne    24cb <mm_page_get_pmem+0xb3>
				if (cpu.has_pae)
    2482:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2489 <mm_page_get_pmem+0x71>
    2489:	83 e0 40             	and    eax,0x40
    248c:	84 c0                	test   al,al
    248e:	74 2b                	je     24bb <mm_page_get_pmem+0xa3>
						return ((struct pte64*)e)->addr * 0x1000;
    2490:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2494:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2497:	48 c1 e8 0c          	shr    rax,0xc
    249b:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    24a5:	48 21 d0             	and    rax,rdx
    24a8:	48 c1 e0 0c          	shl    rax,0xc
    24ac:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    24b6:	48 21 d0             	and    rax,rdx
    24b9:	eb 51                	jmp    250c <mm_page_get_pmem+0xf4>
				else
						return ((struct pte32*)e)->addr * 0x1000;
    24bb:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    24bf:	8b 00                	mov    eax,DWORD PTR [rax]
    24c1:	c1 e8 0c             	shr    eax,0xc
    24c4:	c1 e0 0c             	shl    eax,0xc
    24c7:	48 98                	cdqe
    24c9:	eb 41                	jmp    250c <mm_page_get_pmem+0xf4>
		} else { /* ignore PAT bit */
				if (cpu.has_pae)
    24cb:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 24d2 <mm_page_get_pmem+0xba>
    24d2:	83 e0 40             	and    eax,0x40
    24d5:	84 c0                	test   al,al
    24d7:	74 22                	je     24fb <mm_page_get_pmem+0xe3>
						return (((struct pte64*)e)->addr & ~1ull) * 0x1000;
    24d9:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    24dd:	48 8b 00             	mov    rax,QWORD PTR [rax]
    24e0:	48 c1 e8 0c          	shr    rax,0xc
    24e4:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    24ee:	48 21 d0             	and    rax,rdx
    24f1:	48 83 e0 fe          	and    rax,0xfffffffffffffffe
    24f5:	48 c1 e0 0c          	shl    rax,0xc
    24f9:	eb 11                	jmp    250c <mm_page_get_pmem+0xf4>
				else
						return (((struct pte32*)e)->addr & ~1) * 0x1000;
    24fb:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    24ff:	8b 00                	mov    eax,DWORD PTR [rax]
    2501:	c1 e8 0c             	shr    eax,0xc
    2504:	83 e0 fe             	and    eax,0xfffffffe
    2507:	c1 e0 0c             	shl    eax,0xc
    250a:	48 98                	cdqe
		}
}
    250c:	c9                   	leave
    250d:	c3                   	ret

000000000000250e <mm_handle_pagefault>:

int mm_handle_pagefault(struct mm* mm, void* eip, uint32_t seg_error, void* cr2)
{
    250e:	55                   	push   rbp
    250f:	48 89 e5             	mov    rbp,rsp
    2512:	48 81 ec d0 00 00 00 	sub    rsp,0xd0
    2519:	48 89 bd 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rdi
    2520:	48 89 b5 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rsi
    2527:	89 95 3c ff ff ff    	mov    DWORD PTR [rbp-0xc4],edx
    252d:	48 89 8d 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rcx
		extern struct kio_region kb_reg; /* for I/O diag */
		int lv, rv; uint32_t of; struct pte64 *p, *e; struct pte32 *ps, *es;
		void **cntr, **cntrm;

		/* first get the references to the structures */
		rv = mm_page_walk(mm, cr2, &p, &e, &lv, &of, &cntr, &cntrm);
    2534:	4c 8d 4d 98          	lea    r9,[rbp-0x68]
    2538:	4c 8d 45 9c          	lea    r8,[rbp-0x64]
    253c:	48 8d 4d 88          	lea    rcx,[rbp-0x78]
    2540:	48 8d 55 90          	lea    rdx,[rbp-0x70]
    2544:	48 8b b5 30 ff ff ff 	mov    rsi,QWORD PTR [rbp-0xd0]
    254b:	48 8b 85 48 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb8]
    2552:	48 8d bd 78 ff ff ff 	lea    rdi,[rbp-0x88]
    2559:	57                   	push   rdi
    255a:	48 8d 7d 80          	lea    rdi,[rbp-0x80]
    255e:	57                   	push   rdi
    255f:	48 89 c7             	mov    rdi,rax
    2562:	e8 00 00 00 00       	call   2567 <mm_handle_pagefault+0x59>
    2567:	48 83 c4 10          	add    rsp,0x10
    256b:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
		ps = (void*)p; es = (void*)e;
    256e:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2572:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    2576:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    257a:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax

		/* then check the error code */
		/* bits: 0=present, 1=write, 2=user, 3=res, 4=nx */

		if (seg_error & 1) { /* some sort of access violation */
    257e:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    2584:	83 e0 01             	and    eax,0x1
    2587:	85 c0                	test   eax,eax
    2589:	0f 84 44 04 00 00    	je     29d3 <mm_handle_pagefault+0x4c5>
				if (seg_error & 8) { /* reserved bits */
    258f:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    2595:	83 e0 08             	and    eax,0x8
    2598:	85 c0                	test   eax,eax
    259a:	0f 84 c3 00 00 00    	je     2663 <mm_handle_pagefault+0x155>
						uint32_t hi, lo;
						cprintf(KFMT_ERROR, "Page lookup through %p contained entries"
    25a0:	48 8b 85 30 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd0]
    25a7:	48 89 c2             	mov    rdx,rax
    25aa:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    25b1:	bf 0c 00 00 00       	mov    edi,0xc
    25b6:	b8 00 00 00 00       	mov    eax,0x0
    25bb:	e8 00 00 00 00       	call   25c0 <mm_handle_pagefault+0xb2>
								" which have reserved bits set. This indicates"
								" either page table corruption or sloppy programming.\n", cr2);
						printf("seg_error: %08x\n", seg_error);
    25c0:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    25c6:	89 c6                	mov    esi,eax
    25c8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25cf:	b8 00 00 00 00       	mov    eax,0x0
    25d4:	e8 00 00 00 00       	call   25d9 <mm_handle_pagefault+0xcb>
						printf("level=%d, entry=%u\n", lv, of);
    25d9:	8b 55 98             	mov    edx,DWORD PTR [rbp-0x68]
    25dc:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    25df:	89 c6                	mov    esi,eax
    25e1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25e8:	b8 00 00 00 00       	mov    eax,0x0
    25ed:	e8 00 00 00 00       	call   25f2 <mm_handle_pagefault+0xe4>
						if (cpu.has_pae)
    25f2:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 25f9 <mm_handle_pagefault+0xeb>
    25f9:	83 e0 40             	and    eax,0x40
    25fc:	84 c0                	test   al,al
    25fe:	74 1d                	je     261d <mm_handle_pagefault+0x10f>
								printf("entry: %016llx\n", *(uint64_t*)e);
    2600:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2604:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2607:	48 89 c6             	mov    rsi,rax
    260a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2611:	b8 00 00 00 00       	mov    eax,0x0
    2616:	e8 00 00 00 00       	call   261b <mm_handle_pagefault+0x10d>
    261b:	eb 19                	jmp    2636 <mm_handle_pagefault+0x128>
						else
								printf("entry: %08x\n", *(uint32_t*)es);
    261d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2621:	8b 00                	mov    eax,DWORD PTR [rax]
    2623:	89 c6                	mov    esi,eax
    2625:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    262c:	b8 00 00 00 00       	mov    eax,0x0
    2631:	e8 00 00 00 00       	call   2636 <mm_handle_pagefault+0x128>
						/* Show MSR */
						asm ("rdmsr" : "=a" (lo), "=d" (hi) : "c" (0xc0000080));
    2636:	b8 80 00 00 c0       	mov    eax,0xc0000080
    263b:	89 c1                	mov    ecx,eax
    263d:	0f 32                	rdmsr
    263f:	89 45 a4             	mov    DWORD PTR [rbp-0x5c],eax
    2642:	89 55 a0             	mov    DWORD PTR [rbp-0x60],edx
						printf("MSR: %08x%08x\n", hi, lo);
    2645:	8b 55 a4             	mov    edx,DWORD PTR [rbp-0x5c]
    2648:	8b 45 a0             	mov    eax,DWORD PTR [rbp-0x60]
    264b:	89 c6                	mov    esi,eax
    264d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2654:	b8 00 00 00 00       	mov    eax,0x0
    2659:	e8 00 00 00 00       	call   265e <mm_handle_pagefault+0x150>
    265e:	e9 da 05 00 00       	jmp    2c3d <mm_handle_pagefault+0x72f>
				} else { /* regular access error */
						uint64_t pm; int w, u, x, tlb = 0;
    2663:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
						const char* errstr; uint32_t avl;

						/* get the info */
						if (!cpu.has_pae) {
    266a:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2671 <mm_handle_pagefault+0x163>
    2671:	83 e0 40             	and    eax,0x40
    2674:	84 c0                	test   al,al
    2676:	75 56                	jne    26ce <mm_handle_pagefault+0x1c0>
								pm = es->addr * 0x1000;
    2678:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    267c:	8b 00                	mov    eax,DWORD PTR [rax]
    267e:	c1 e8 0c             	shr    eax,0xc
    2681:	c1 e0 0c             	shl    eax,0xc
    2684:	48 98                	cdqe
    2686:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
								x = 1;
    268a:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1
								w = es->w;
    2691:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2695:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2698:	d0 e8                	shr    al,1
    269a:	83 e0 01             	and    eax,0x1
    269d:	0f b6 c0             	movzx  eax,al
    26a0:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								u = es->u;
    26a3:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    26a7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    26aa:	c0 e8 02             	shr    al,0x2
    26ad:	83 e0 01             	and    eax,0x1
    26b0:	0f b6 c0             	movzx  eax,al
    26b3:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
								avl = es->ign;
    26b6:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    26ba:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    26be:	d0 e8                	shr    al,1
    26c0:	83 e0 07             	and    eax,0x7
    26c3:	0f b6 c0             	movzx  eax,al
    26c6:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
    26c9:	e9 93 00 00 00       	jmp    2761 <mm_handle_pagefault+0x253>
						} else {
								pm = e->addr * 0x1000;
    26ce:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    26d2:	48 8b 00             	mov    rax,QWORD PTR [rax]
    26d5:	48 c1 e8 0c          	shr    rax,0xc
    26d9:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    26e3:	48 21 d0             	and    rax,rdx
    26e6:	48 c1 e0 0c          	shl    rax,0xc
    26ea:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    26f4:	48 21 d0             	and    rax,rdx
    26f7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
								x = !e->xd;
    26fb:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    26ff:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
    2703:	83 e0 80             	and    eax,0xffffff80
    2706:	84 c0                	test   al,al
    2708:	0f 94 c0             	sete   al
    270b:	0f b6 c0             	movzx  eax,al
    270e:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
								w = e->w;
    2711:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2715:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2718:	d0 e8                	shr    al,1
    271a:	83 e0 01             	and    eax,0x1
    271d:	0f b6 c0             	movzx  eax,al
    2720:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								u = e->u;
    2723:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2727:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    272a:	c0 e8 02             	shr    al,0x2
    272d:	83 e0 01             	and    eax,0x1
    2730:	0f b6 c0             	movzx  eax,al
    2733:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
								avl = e->ign | (e->ign2 << 3);
    2736:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    273a:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    273e:	d0 e8                	shr    al,1
    2740:	83 e0 07             	and    eax,0x7
    2743:	0f b6 d0             	movzx  edx,al
    2746:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    274a:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    274e:	66 c1 e8 04          	shr    ax,0x4
    2752:	66 25 ff 07          	and    ax,0x7ff
    2756:	0f b7 c0             	movzx  eax,ax
    2759:	c1 e0 03             	shl    eax,0x3
    275c:	09 d0                	or     eax,edx
    275e:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
						}
						/* create the errstr */
						if (seg_error & 16) {
    2761:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    2767:	83 e0 10             	and    eax,0x10
    276a:	85 c0                	test   eax,eax
    276c:	74 1f                	je     278d <mm_handle_pagefault+0x27f>
								if (x) { /* check for NX in directoy */
    276e:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    2772:	74 0c                	je     2780 <mm_handle_pagefault+0x272>
										tlb = 1;
    2774:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [rbp-0x18],0x1
    277b:	e9 31 01 00 00       	jmp    28b1 <mm_handle_pagefault+0x3a3>
								} else
										errstr = "no execute";
    2780:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    2788:	e9 24 01 00 00       	jmp    28b1 <mm_handle_pagefault+0x3a3>
						} else if (seg_error & 4) {
    278d:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    2793:	83 e0 04             	and    eax,0x4
    2796:	85 c0                	test   eax,eax
    2798:	74 1f                	je     27b9 <mm_handle_pagefault+0x2ab>
								if (u)
    279a:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    279e:	74 0c                	je     27ac <mm_handle_pagefault+0x29e>
										tlb = 1;
    27a0:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [rbp-0x18],0x1
    27a7:	e9 05 01 00 00       	jmp    28b1 <mm_handle_pagefault+0x3a3>
								else
										errstr = "kernel";
    27ac:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    27b4:	e9 f8 00 00 00       	jmp    28b1 <mm_handle_pagefault+0x3a3>
						} else if (seg_error & 2) {
    27b9:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    27bf:	83 e0 02             	and    eax,0x2
    27c2:	85 c0                	test   eax,eax
    27c4:	0f 84 e7 00 00 00    	je     28b1 <mm_handle_pagefault+0x3a3>
								if (w) /* we assume consistent directories */
    27ca:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    27ce:	74 0c                	je     27dc <mm_handle_pagefault+0x2ce>
										tlb = 1;
    27d0:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [rbp-0x18],0x1
    27d7:	e9 d5 00 00 00       	jmp    28b1 <mm_handle_pagefault+0x3a3>
								else if (avl & 1) { /* COW */
    27dc:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    27df:	83 e0 01             	and    eax,0x1
    27e2:	85 c0                	test   eax,eax
    27e4:	0f 84 bf 00 00 00    	je     28a9 <mm_handle_pagefault+0x39b>
										size_t pg_ct = 1; struct page_range pr;
    27ea:	48 c7 45 a8 01 00 00 00 	mov    QWORD PTR [rbp-0x58],0x1
										if (lv > 0) {
    27f2:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    27f5:	85 c0                	test   eax,eax
    27f7:	7e 30                	jle    2829 <mm_handle_pagefault+0x31b>
												die("COW on large pages not implemented yet\n");
    27f9:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2800:	bf 0c 00 00 00       	mov    edi,0xc
    2805:	b8 00 00 00 00       	mov    eax,0x0
    280a:	e8 00 00 00 00       	call   280f <mm_handle_pagefault+0x301>
    280f:	b8 00 00 00 00       	mov    eax,0x0
    2814:	e8 00 00 00 00       	call   2819 <mm_handle_pagefault+0x30b>
    2819:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2820:	e8 00 00 00 00       	call   2825 <mm_handle_pagefault+0x317>
    2825:	fa                   	cli
    2826:	f4                   	hlt
    2827:	eb fd                	jmp    2826 <mm_handle_pagefault+0x318>
										}
										if (mm_alloc_pm(pg_ct, &pr, 1)) {
    2829:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    282d:	89 c1                	mov    ecx,eax
    282f:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    2836:	ba 01 00 00 00       	mov    edx,0x1
    283b:	48 89 c6             	mov    rsi,rax
    283e:	89 cf                	mov    edi,ecx
    2840:	e8 00 00 00 00       	call   2845 <mm_handle_pagefault+0x337>
    2845:	85 c0                	test   eax,eax
    2847:	74 30                	je     2879 <mm_handle_pagefault+0x36b>
												/* FIXME: Shootdown needed? No stale data would cause
												 * another COW and this can be detected in the PF handler. */
												die("COW not implemented\n");
    2849:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2850:	bf 0c 00 00 00       	mov    edi,0xc
    2855:	b8 00 00 00 00       	mov    eax,0x0
    285a:	e8 00 00 00 00       	call   285f <mm_handle_pagefault+0x351>
    285f:	b8 00 00 00 00       	mov    eax,0x0
    2864:	e8 00 00 00 00       	call   2869 <mm_handle_pagefault+0x35b>
    2869:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2870:	e8 00 00 00 00       	call   2875 <mm_handle_pagefault+0x367>
    2875:	fa                   	cli
    2876:	f4                   	hlt
    2877:	eb fd                	jmp    2876 <mm_handle_pagefault+0x368>
										} else {
												die("unable to allocate memory for COW\n");
    2879:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2880:	bf 0c 00 00 00       	mov    edi,0xc
    2885:	b8 00 00 00 00       	mov    eax,0x0
    288a:	e8 00 00 00 00       	call   288f <mm_handle_pagefault+0x381>
    288f:	b8 00 00 00 00       	mov    eax,0x0
    2894:	e8 00 00 00 00       	call   2899 <mm_handle_pagefault+0x38b>
    2899:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28a0:	e8 00 00 00 00       	call   28a5 <mm_handle_pagefault+0x397>
    28a5:	fa                   	cli
    28a6:	f4                   	hlt
    28a7:	eb fd                	jmp    28a6 <mm_handle_pagefault+0x398>
										}
								} else
										errstr = "read only";
    28a9:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
						}

						if (tlb) {
    28b1:	83 7d e8 00          	cmp    DWORD PTR [rbp-0x18],0x0
    28b5:	74 5f                	je     2916 <mm_handle_pagefault+0x408>
								uint8_t id = 0;
    28b7:	c6 45 db 00          	mov    BYTE PTR [rbp-0x25],0x0
								if (nproc > 1)
    28bb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 28c1 <mm_handle_pagefault+0x3b3>
    28c1:	83 f8 01             	cmp    eax,0x1
    28c4:	76 0f                	jbe    28d5 <mm_handle_pagefault+0x3c7>
										id = smp_processor_id();
    28c6:	b8 00 00 00 00       	mov    eax,0x0
    28cb:	e8 30 d7 ff ff       	call   0 <per_cpu_ptr>
    28d0:	8b 00                	mov    eax,DWORD PTR [rax]
    28d2:	88 45 db             	mov    BYTE PTR [rbp-0x25],al
								rprintf(&kb_reg, "[%u] TLB fl: %p\n", id, cr2);
    28d5:	0f b6 45 db          	movzx  eax,BYTE PTR [rbp-0x25]
    28d9:	48 8b 95 30 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xd0]
    28e0:	48 89 d1             	mov    rcx,rdx
    28e3:	89 c2                	mov    edx,eax
    28e5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    28ec:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28f3:	b8 00 00 00 00       	mov    eax,0x0
    28f8:	e8 00 00 00 00       	call   28fd <mm_handle_pagefault+0x3ef>
								flush_tlb_single(cr2);
    28fd:	48 8b 85 30 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd0]
    2904:	48 89 c7             	mov    rdi,rax
    2907:	e8 0f d7 ff ff       	call   1b <flush_tlb_single>
								return 0;
    290c:	b8 00 00 00 00       	mov    eax,0x0
    2911:	e9 2c 03 00 00       	jmp    2c42 <mm_handle_pagefault+0x734>
						}

						/* print the error */
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
								" but is not allowed to do so as page is marked as %s\n",
								eip, (seg_error & 2) ? "write to" : ((seg_error & 16) ?
    2916:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    291c:	83 e0 02             	and    eax,0x2
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
    291f:	85 c0                	test   eax,eax
    2921:	75 1f                	jne    2942 <mm_handle_pagefault+0x434>
								eip, (seg_error & 2) ? "write to" : ((seg_error & 16) ?
    2923:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    2929:	83 e0 10             	and    eax,0x10
								"fetch instructions from": "read from"),
    292c:	85 c0                	test   eax,eax
    292e:	74 09                	je     2939 <mm_handle_pagefault+0x42b>
    2930:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2937:	eb 10                	jmp    2949 <mm_handle_pagefault+0x43b>
    2939:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2940:	eb 07                	jmp    2949 <mm_handle_pagefault+0x43b>
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
    2942:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2949:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    294d:	48 8b 8d 30 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xd0]
    2954:	48 8b 95 40 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xc0]
    295b:	49 89 f1             	mov    r9,rsi
    295e:	49 89 c8             	mov    r8,rcx
    2961:	48 89 c1             	mov    rcx,rax
    2964:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    296b:	bf 0c 00 00 00       	mov    edi,0xc
    2970:	b8 00 00 00 00       	mov    eax,0x0
    2975:	e8 00 00 00 00       	call   297a <mm_handle_pagefault+0x46c>
								cr2, errstr);
						printf("The page is %s and present\n", lv ? (lv > 1 ? "huge" : "large") : "regular");
    297a:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    297d:	85 c0                	test   eax,eax
    297f:	74 1a                	je     299b <mm_handle_pagefault+0x48d>
    2981:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    2984:	83 f8 01             	cmp    eax,0x1
    2987:	7e 09                	jle    2992 <mm_handle_pagefault+0x484>
    2989:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2990:	eb 10                	jmp    29a2 <mm_handle_pagefault+0x494>
    2992:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2999:	eb 07                	jmp    29a2 <mm_handle_pagefault+0x494>
    299b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    29a2:	48 89 c6             	mov    rsi,rax
    29a5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29ac:	b8 00 00 00 00       	mov    eax,0x0
    29b1:	e8 00 00 00 00       	call   29b6 <mm_handle_pagefault+0x4a8>
						printf("it points to physical memory at %#.16llx\n", pm);
    29b6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    29ba:	48 89 c6             	mov    rsi,rax
    29bd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29c4:	b8 00 00 00 00       	mov    eax,0x0
    29c9:	e8 00 00 00 00       	call   29ce <mm_handle_pagefault+0x4c0>
    29ce:	e9 6a 02 00 00       	jmp    2c3d <mm_handle_pagefault+0x72f>
				}
		} else { /* encountered nonpresent page */
				uint64_t flags = 0;
    29d3:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
				/* get flag bits */
				if (!cpu.has_pae) { /* pte32 */
    29db:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 29e2 <mm_handle_pagefault+0x4d4>
    29e2:	83 e0 40             	and    eax,0x40
    29e5:	84 c0                	test   al,al
    29e7:	75 45                	jne    2a2e <mm_handle_pagefault+0x520>
						if (es) /* there's sth. */
    29e9:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    29ee:	74 0e                	je     29fe <mm_handle_pagefault+0x4f0>
								flags |= *(uint32_t*)es;
    29f0:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    29f4:	8b 00                	mov    eax,DWORD PTR [rax]
    29f6:	89 c0                	mov    eax,eax
    29f8:	48 09 45 d0          	or     QWORD PTR [rbp-0x30],rax
    29fc:	eb 76                	jmp    2a74 <mm_handle_pagefault+0x566>
						else
								die("level 2 missing\n");
    29fe:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2a05:	bf 0c 00 00 00       	mov    edi,0xc
    2a0a:	b8 00 00 00 00       	mov    eax,0x0
    2a0f:	e8 00 00 00 00       	call   2a14 <mm_handle_pagefault+0x506>
    2a14:	b8 00 00 00 00       	mov    eax,0x0
    2a19:	e8 00 00 00 00       	call   2a1e <mm_handle_pagefault+0x510>
    2a1e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a25:	e8 00 00 00 00       	call   2a2a <mm_handle_pagefault+0x51c>
    2a2a:	fa                   	cli
    2a2b:	f4                   	hlt
    2a2c:	eb fd                	jmp    2a2b <mm_handle_pagefault+0x51d>
				} else {
						if (e)
    2a2e:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2a32:	48 85 c0             	test   rax,rax
    2a35:	74 0d                	je     2a44 <mm_handle_pagefault+0x536>
								flags |= *(uint64_t*)e;
    2a37:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2a3b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2a3e:	48 09 45 d0          	or     QWORD PTR [rbp-0x30],rax
    2a42:	eb 30                	jmp    2a74 <mm_handle_pagefault+0x566>
						else
								die("level 2 or 4 missing\n");
    2a44:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2a4b:	bf 0c 00 00 00       	mov    edi,0xc
    2a50:	b8 00 00 00 00       	mov    eax,0x0
    2a55:	e8 00 00 00 00       	call   2a5a <mm_handle_pagefault+0x54c>
    2a5a:	b8 00 00 00 00       	mov    eax,0x0
    2a5f:	e8 00 00 00 00       	call   2a64 <mm_handle_pagefault+0x556>
    2a64:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a6b:	e8 00 00 00 00       	call   2a70 <mm_handle_pagefault+0x562>
    2a70:	fa                   	cli
    2a71:	f4                   	hlt
    2a72:	eb fd                	jmp    2a71 <mm_handle_pagefault+0x563>
				}

				/* check for known codes */
				flags >>= 1;
    2a74:	48 d1 6d d0          	shr    QWORD PTR [rbp-0x30],1
				/* CAUTION: Swap IDs have to keep AVL field free */
				if (flags & (1 << 11)) { /* allocate on access */
    2a78:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2a7c:	25 00 08 00 00       	and    eax,0x800
    2a81:	48 85 c0             	test   rax,rax
    2a84:	0f 84 60 01 00 00    	je     2bea <mm_handle_pagefault+0x6dc>
						size_t pg_ct = 1; struct page_range pr;
    2a8a:	48 c7 45 b0 01 00 00 00 	mov    QWORD PTR [rbp-0x50],0x1
						if (lv > 0) {
    2a92:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    2a95:	85 c0                	test   eax,eax
    2a97:	7e 30                	jle    2ac9 <mm_handle_pagefault+0x5bb>
								/* TODO: cont alloc & large pages */
								die("no AOA large pages implemented yet!\n");
    2a99:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2aa0:	bf 0c 00 00 00       	mov    edi,0xc
    2aa5:	b8 00 00 00 00       	mov    eax,0x0
    2aaa:	e8 00 00 00 00       	call   2aaf <mm_handle_pagefault+0x5a1>
    2aaf:	b8 00 00 00 00       	mov    eax,0x0
    2ab4:	e8 00 00 00 00       	call   2ab9 <mm_handle_pagefault+0x5ab>
    2ab9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ac0:	e8 00 00 00 00       	call   2ac5 <mm_handle_pagefault+0x5b7>
    2ac5:	fa                   	cli
    2ac6:	f4                   	hlt
    2ac7:	eb fd                	jmp    2ac6 <mm_handle_pagefault+0x5b8>
						}
						/* alloc & print info */
						if (mm_alloc_pm(pg_ct, &pr, 1)) {
    2ac9:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2acd:	89 c1                	mov    ecx,eax
    2acf:	48 8d 85 50 ff ff ff 	lea    rax,[rbp-0xb0]
    2ad6:	ba 01 00 00 00       	mov    edx,0x1
    2adb:	48 89 c6             	mov    rsi,rax
    2ade:	89 cf                	mov    edi,ecx
    2ae0:	e8 00 00 00 00       	call   2ae5 <mm_handle_pagefault+0x5d7>
    2ae5:	85 c0                	test   eax,eax
    2ae7:	0f 84 cd 00 00 00    	je     2bba <mm_handle_pagefault+0x6ac>
								/* level0 -> no new pointers */
								if (!cpu.has_pae) {
    2aed:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2af4 <mm_handle_pagefault+0x5e6>
    2af4:	83 e0 40             	and    eax,0x40
    2af7:	84 c0                	test   al,al
    2af9:	75 32                	jne    2b2d <mm_handle_pagefault+0x61f>
										es->addr = (uint32_t)(pr.base / 4096);
    2afb:	48 8b 85 50 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb0]
    2b02:	48 c1 e8 0c          	shr    rax,0xc
    2b06:	25 ff ff 0f 00       	and    eax,0xfffff
    2b0b:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    2b0f:	c1 e0 0c             	shl    eax,0xc
    2b12:	89 c1                	mov    ecx,eax
    2b14:	8b 02                	mov    eax,DWORD PTR [rdx]
    2b16:	25 ff 0f 00 00       	and    eax,0xfff
    2b1b:	09 c8                	or     eax,ecx
    2b1d:	89 02                	mov    DWORD PTR [rdx],eax
										es->p = 1;
    2b1f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2b23:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    2b26:	83 ca 01             	or     edx,0x1
    2b29:	88 10                	mov    BYTE PTR [rax],dl
    2b2b:	eb 52                	jmp    2b7f <mm_handle_pagefault+0x671>
								} else {
										e->addr = pr.base / 4096;
    2b2d:	48 8b 85 50 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb0]
    2b34:	48 c1 e8 0c          	shr    rax,0xc
    2b38:	48 89 c1             	mov    rcx,rax
    2b3b:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b3f:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    2b49:	48 21 d1             	and    rcx,rdx
    2b4c:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    2b56:	48 21 ca             	and    rdx,rcx
    2b59:	48 c1 e2 0c          	shl    rdx,0xc
    2b5d:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    2b60:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    2b6a:	48 21 f1             	and    rcx,rsi
    2b6d:	48 09 ca             	or     rdx,rcx
    2b70:	48 89 10             	mov    QWORD PTR [rax],rdx
										e->p = 1;
    2b73:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b77:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    2b7a:	83 ca 01             	or     edx,0x1
    2b7d:	88 10                	mov    BYTE PTR [rax],dl
								}
								flush_tlb_single(cr2);
    2b7f:	48 8b 85 30 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd0]
    2b86:	48 89 c7             	mov    rdi,rax
    2b89:	e8 8d d4 ff ff       	call   1b <flush_tlb_single>
								rprintf(&kb_reg, "MM AOW: %p\n", cr2);
    2b8e:	48 8b 85 30 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd0]
    2b95:	48 89 c2             	mov    rdx,rax
    2b98:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2b9f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ba6:	b8 00 00 00 00       	mov    eax,0x0
    2bab:	e8 00 00 00 00       	call   2bb0 <mm_handle_pagefault+0x6a2>
								return 0;
    2bb0:	b8 00 00 00 00       	mov    eax,0x0
    2bb5:	e9 88 00 00 00       	jmp    2c42 <mm_handle_pagefault+0x734>
						} else {
								die("Out of memory for AOA\n");
    2bba:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2bc1:	bf 0c 00 00 00       	mov    edi,0xc
    2bc6:	b8 00 00 00 00       	mov    eax,0x0
    2bcb:	e8 00 00 00 00       	call   2bd0 <mm_handle_pagefault+0x6c2>
    2bd0:	b8 00 00 00 00       	mov    eax,0x0
    2bd5:	e8 00 00 00 00       	call   2bda <mm_handle_pagefault+0x6cc>
    2bda:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2be1:	e8 00 00 00 00       	call   2be6 <mm_handle_pagefault+0x6d8>
    2be6:	fa                   	cli
    2be7:	f4                   	hlt
    2be8:	eb fd                	jmp    2be7 <mm_handle_pagefault+0x6d9>
						}
				} else {
						/* swapped with ID */
						cprintf(KFMT_INFO, "Swapping in single page with id %llu\n", flags);
    2bea:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2bee:	48 89 c2             	mov    rdx,rax
    2bf1:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2bf8:	bf 0b 00 00 00       	mov    edi,0xb
    2bfd:	b8 00 00 00 00       	mov    eax,0x0
    2c02:	e8 00 00 00 00       	call   2c07 <mm_handle_pagefault+0x6f9>
						cprintf(KFMT_ERROR, "which is not implemented\n");
    2c07:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2c0e:	bf 0c 00 00 00       	mov    edi,0xc
    2c13:	b8 00 00 00 00       	mov    eax,0x0
    2c18:	e8 00 00 00 00       	call   2c1d <mm_handle_pagefault+0x70f>
						printf("level=%d, entry=%u, ptr=%p\n", lv, of, cr2);
    2c1d:	8b 55 98             	mov    edx,DWORD PTR [rbp-0x68]
    2c20:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    2c23:	48 8b 8d 30 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xd0]
    2c2a:	89 c6                	mov    esi,eax
    2c2c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c33:	b8 00 00 00 00       	mov    eax,0x0
    2c38:	e8 00 00 00 00       	call   2c3d <mm_handle_pagefault+0x72f>
		// --------------
		// Codes with access violation on present pages: 3 avl bits
		// 0 = regular, i.e. invalid
		// 1 = copy on write
		*/
		return 1;
    2c3d:	b8 01 00 00 00       	mov    eax,0x1
}
    2c42:	c9                   	leave
    2c43:	c3                   	ret

0000000000002c44 <print_stacktrace>:

const char* elf_get_closest_symbol(void* ptr, size_t* offset);
void print_stacktrace()
{
    2c44:	55                   	push   rbp
    2c45:	48 89 e5             	mov    rbp,rsp
    2c48:	53                   	push   rbx
    2c49:	48 83 ec 68          	sub    rsp,0x68
				struct sf* prev;
				void* ret_addr;
				void* args[4];
		} __attribute__((packed)) *fp;
		static int stc = 0;
		stc++;
    2c4d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2c53 <print_stacktrace+0xf>
    2c53:	83 c0 01             	add    eax,0x1
    2c56:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2c5c <print_stacktrace+0x18>
		if (stc == 1) {
    2c5c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2c62 <print_stacktrace+0x1e>
    2c62:	83 f8 01             	cmp    eax,0x1
    2c65:	0f 85 0e 01 00 00    	jne    2d79 <print_stacktrace+0x135>
print_st:
    2c6b:	90                   	nop
				/* get ebp into C code */
#ifdef __x86_64__
				__asm__("mov %%rbp, %[fp]" : /* output */ [fp] "=r" (fp));
    2c6c:	48 89 e8             	mov    rax,rbp
    2c6f:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
#else
				__asm__("movl %%ebp, %[fp]" : /* output */ [fp] "=r" (fp));
#endif
				/* do the backtrace from ebp to ebp */
				printf("performing stacktrace:\n");
    2c73:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c7a:	b8 00 00 00 00       	mov    eax,0x0
    2c7f:	e8 00 00 00 00       	call   2c84 <print_stacktrace+0x40>
#ifdef __x86_64__
				printf("RBP              ARG-1             ARG-2             ARG-3             ARG-4            FROM\n");
    2c84:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c8b:	b8 00 00 00 00       	mov    eax,0x0
    2c90:	e8 00 00 00 00       	call   2c95 <print_stacktrace+0x51>
#else
				printf("EBP      ARG-1     ARG-2     ARG-3     ARG-4    FROM\n");
#endif
				do {
						size_t of; const char* sym;
						printf("%p %p %p %p %p %p\n", fp, fp->args[0], fp->args[1],
    2c95:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2c99:	48 8b 70 08          	mov    rsi,QWORD PTR [rax+0x8]
    2c9d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ca1:	4c 8b 40 28          	mov    r8,QWORD PTR [rax+0x28]
    2ca5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ca9:	48 8b 78 20          	mov    rdi,QWORD PTR [rax+0x20]
    2cad:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2cb1:	48 8b 48 18          	mov    rcx,QWORD PTR [rax+0x18]
    2cb5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2cb9:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    2cbd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2cc1:	48 83 ec 08          	sub    rsp,0x8
    2cc5:	56                   	push   rsi
    2cc6:	4d 89 c1             	mov    r9,r8
    2cc9:	49 89 f8             	mov    r8,rdi
    2ccc:	48 89 c6             	mov    rsi,rax
    2ccf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2cd6:	b8 00 00 00 00       	mov    eax,0x0
    2cdb:	e8 00 00 00 00       	call   2ce0 <print_stacktrace+0x9c>
    2ce0:	48 83 c4 10          	add    rsp,0x10
										fp->args[2], fp->args[3], fp->ret_addr);
						sym = (const char*)elf_get_closest_symbol(fp->ret_addr, &of);
    2ce4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ce8:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2cec:	48 8d 55 b8          	lea    rdx,[rbp-0x48]
    2cf0:	48 89 d6             	mov    rsi,rdx
    2cf3:	48 89 c7             	mov    rdi,rax
    2cf6:	e8 00 00 00 00       	call   2cfb <print_stacktrace+0xb7>
    2cfb:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
						cprintf(KFMT_INFO, "called from %p (%s%+#lx)\n", fp->ret_addr, sym, of);
    2cff:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    2d03:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2d07:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2d0b:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    2d0f:	49 89 c8             	mov    r8,rcx
    2d12:	48 89 d1             	mov    rcx,rdx
    2d15:	48 89 c2             	mov    rdx,rax
    2d18:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2d1f:	bf 0b 00 00 00       	mov    edi,0xb
    2d24:	b8 00 00 00 00       	mov    eax,0x0
    2d29:	e8 00 00 00 00       	call   2d2e <print_stacktrace+0xea>
						extern void _start();
						if (fp->ret_addr - 5 == (void*)&_start)
    2d2e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2d32:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2d36:	48 83 e8 05          	sub    rax,0x5
    2d3a:	48 3d 00 00 00 00    	cmp    rax,0x0
    2d40:	74 25                	je     2d67 <print_stacktrace+0x123>
								break; /* only until call to kmain */
						else if (!fp->ret_addr)
    2d42:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2d46:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2d4a:	48 85 c0             	test   rax,rax
    2d4d:	74 1b                	je     2d6a <print_stacktrace+0x126>
								break;
						fp = fp->prev;
    2d4f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2d53:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2d56:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				} while (fp);
    2d5a:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2d5f:	0f 85 30 ff ff ff    	jne    2c95 <print_stacktrace+0x51>
    2d65:	eb 04                	jmp    2d6b <print_stacktrace+0x127>
								break; /* only until call to kmain */
    2d67:	90                   	nop
    2d68:	eb 01                	jmp    2d6b <print_stacktrace+0x127>
								break;
    2d6a:	90                   	nop
				framebuffer_redraw(&fb_initial);
    2d6b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2d72:	e8 00 00 00 00       	call   2d77 <print_stacktrace+0x133>
    2d77:	eb 30                	jmp    2da9 <print_stacktrace+0x165>
		} else
				die("stacktrace loop!\n");
    2d79:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2d80:	bf 0c 00 00 00       	mov    edi,0xc
    2d85:	b8 00 00 00 00       	mov    eax,0x0
    2d8a:	e8 00 00 00 00       	call   2d8f <print_stacktrace+0x14b>
    2d8f:	b8 00 00 00 00       	mov    eax,0x0
    2d94:	e8 00 00 00 00       	call   2d99 <print_stacktrace+0x155>
    2d99:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2da0:	e8 00 00 00 00       	call   2da5 <print_stacktrace+0x161>
    2da5:	fa                   	cli
    2da6:	f4                   	hlt
    2da7:	eb fd                	jmp    2da6 <print_stacktrace+0x162>
		/* now offer basic diag */
print_help:
		printf("Debug diagnostics mode with following commands:\n"
    2da9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2db0:	b8 00 00 00 00       	mov    eax,0x0
    2db5:	e8 00 00 00 00       	call   2dba <print_stacktrace+0x176>
				"\tm                   Display symbol map\n"
				"\tk                   Reprint the stack trace\n"
				"\th(elp)              Display this help message\n"
				"\th(a)lt              Turns off the computer\n"
				"\tl Address           Find symbol below/at Address\n");
		framebuffer_redraw(&fb_initial);
    2dba:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2dc1:	e8 00 00 00 00       	call   2dc6 <print_stacktrace+0x182>
		while (1) {
				char* str = 0; size_t n = 0;
    2dc6:	48 c7 45 b0 00 00 00 00 	mov    QWORD PTR [rbp-0x50],0x0
    2dce:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
				printf("enter command:\n");
    2dd6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ddd:	b8 00 00 00 00       	mov    eax,0x0
    2de2:	e8 00 00 00 00       	call   2de7 <print_stacktrace+0x1a3>
				framebuffer_redraw(&fb_initial);
    2de7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2dee:	e8 00 00 00 00       	call   2df3 <print_stacktrace+0x1af>
				getline(&str, &n);
    2df3:	48 8d 55 a8          	lea    rdx,[rbp-0x58]
    2df7:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    2dfb:	48 89 d6             	mov    rsi,rdx
    2dfe:	48 89 c7             	mov    rdi,rax
    2e01:	e8 00 00 00 00       	call   2e06 <print_stacktrace+0x1c2>
				if (str) {
    2e06:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e0a:	48 85 c0             	test   rax,rax
    2e0d:	74 b7                	je     2dc6 <print_stacktrace+0x182>
						if (strlen(str))
    2e0f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e13:	48 89 c7             	mov    rdi,rax
    2e16:	e8 00 00 00 00       	call   2e1b <print_stacktrace+0x1d7>
    2e1b:	48 85 c0             	test   rax,rax
    2e1e:	74 1a                	je     2e3a <print_stacktrace+0x1f6>
								str[strlen(str) - 1] = '\0';
    2e20:	48 8b 5d b0          	mov    rbx,QWORD PTR [rbp-0x50]
    2e24:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e28:	48 89 c7             	mov    rdi,rax
    2e2b:	e8 00 00 00 00       	call   2e30 <print_stacktrace+0x1ec>
    2e30:	48 83 e8 01          	sub    rax,0x1
    2e34:	48 01 d8             	add    rax,rbx
    2e37:	c6 00 00             	mov    BYTE PTR [rax],0x0
						if (strcmp(str, "r") == 0)
    2e3a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e3e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2e45:	48 89 c7             	mov    rdi,rax
    2e48:	e8 00 00 00 00       	call   2e4d <print_stacktrace+0x209>
    2e4d:	85 c0                	test   eax,eax
    2e4f:	75 16                	jne    2e67 <print_stacktrace+0x223>
								printf("registers: \n");
    2e51:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e58:	b8 00 00 00 00       	mov    eax,0x0
    2e5d:	e8 00 00 00 00       	call   2e62 <print_stacktrace+0x21e>
    2e62:	e9 f4 01 00 00       	jmp    305b <print_stacktrace+0x417>
						else if (strcmp(str, "k") == 0)
    2e67:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e6b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2e72:	48 89 c7             	mov    rdi,rax
    2e75:	e8 00 00 00 00       	call   2e7a <print_stacktrace+0x236>
    2e7a:	85 c0                	test   eax,eax
    2e7c:	75 05                	jne    2e83 <print_stacktrace+0x23f>
    2e7e:	e9 e9 fd ff ff       	jmp    2c6c <print_stacktrace+0x28>
								goto print_st;
						else if (strcmp(str, "m") == 0)
    2e83:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e87:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2e8e:	48 89 c7             	mov    rdi,rax
    2e91:	e8 00 00 00 00       	call   2e96 <print_stacktrace+0x252>
    2e96:	85 c0                	test   eax,eax
    2e98:	75 16                	jne    2eb0 <print_stacktrace+0x26c>
								printf("Symbol map: \n");
    2e9a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ea1:	b8 00 00 00 00       	mov    eax,0x0
    2ea6:	e8 00 00 00 00       	call   2eab <print_stacktrace+0x267>
    2eab:	e9 ab 01 00 00       	jmp    305b <print_stacktrace+0x417>
						else if (strncmp(str, "l ", 2) == 0) {
    2eb0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2eb4:	ba 02 00 00 00       	mov    edx,0x2
    2eb9:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2ec0:	48 89 c7             	mov    rdi,rax
    2ec3:	e8 00 00 00 00       	call   2ec8 <print_stacktrace+0x284>
    2ec8:	85 c0                	test   eax,eax
    2eca:	75 56                	jne    2f22 <print_stacktrace+0x2de>
								long int addr = strtol(str + 2, NULL, 0);
    2ecc:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2ed0:	48 83 c0 02          	add    rax,0x2
    2ed4:	ba 00 00 00 00       	mov    edx,0x0
    2ed9:	be 00 00 00 00       	mov    esi,0x0
    2ede:	48 89 c7             	mov    rdi,rax
    2ee1:	e8 00 00 00 00       	call   2ee6 <print_stacktrace+0x2a2>
    2ee6:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
								const char* sym; size_t of;
								sym = (const char*)elf_get_closest_symbol((void*)addr, &of);
    2eea:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2eee:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
    2ef2:	48 89 d6             	mov    rsi,rdx
    2ef5:	48 89 c7             	mov    rdi,rax
    2ef8:	e8 00 00 00 00       	call   2efd <print_stacktrace+0x2b9>
    2efd:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
								printf("Address is located at %s%+#lx\n", sym, of);
    2f01:	48 8b 55 a0          	mov    rdx,QWORD PTR [rbp-0x60]
    2f05:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2f09:	48 89 c6             	mov    rsi,rax
    2f0c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2f13:	b8 00 00 00 00       	mov    eax,0x0
    2f18:	e8 00 00 00 00       	call   2f1d <print_stacktrace+0x2d9>
    2f1d:	e9 39 01 00 00       	jmp    305b <print_stacktrace+0x417>
						} else if (strncmp(str, "db ", 3) == 0) {
    2f22:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2f26:	ba 03 00 00 00       	mov    edx,0x3
    2f2b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2f32:	48 89 c7             	mov    rdi,rax
    2f35:	e8 00 00 00 00       	call   2f3a <print_stacktrace+0x2f6>
    2f3a:	85 c0                	test   eax,eax
    2f3c:	75 69                	jne    2fa7 <print_stacktrace+0x363>
								char* end;
								long int addr = strtol(str + 3, &end, 0), cap = 512;
    2f3e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2f42:	48 8d 48 03          	lea    rcx,[rax+0x3]
    2f46:	48 8d 45 98          	lea    rax,[rbp-0x68]
    2f4a:	ba 00 00 00 00       	mov    edx,0x0
    2f4f:	48 89 c6             	mov    rsi,rax
    2f52:	48 89 cf             	mov    rdi,rcx
    2f55:	e8 00 00 00 00       	call   2f5a <print_stacktrace+0x316>
    2f5a:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    2f5e:	48 c7 45 e0 00 02 00 00 	mov    QWORD PTR [rbp-0x20],0x200
								if (*end == ' ')
    2f66:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2f6a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2f6d:	3c 20                	cmp    al,0x20
    2f6f:	75 1e                	jne    2f8f <print_stacktrace+0x34b>
										cap = strtol(end + 1, NULL, 0);
    2f71:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2f75:	48 83 c0 01          	add    rax,0x1
    2f79:	ba 00 00 00 00       	mov    edx,0x0
    2f7e:	be 00 00 00 00       	mov    esi,0x0
    2f83:	48 89 c7             	mov    rdi,rax
    2f86:	e8 00 00 00 00       	call   2f8b <print_stacktrace+0x347>
    2f8b:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								memdump((void*)addr, cap);
    2f8f:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    2f93:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2f97:	48 89 d6             	mov    rsi,rdx
    2f9a:	48 89 c7             	mov    rdi,rax
    2f9d:	e8 00 00 00 00       	call   2fa2 <print_stacktrace+0x35e>
    2fa2:	e9 b4 00 00 00       	jmp    305b <print_stacktrace+0x417>
						} else if (strcmp(str, "dpt") == 0) {
    2fa7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2fab:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2fb2:	48 89 c7             	mov    rdi,rax
    2fb5:	e8 00 00 00 00       	call   2fba <print_stacktrace+0x376>
    2fba:	85 c0                	test   eax,eax
    2fbc:	75 16                	jne    2fd4 <print_stacktrace+0x390>
								printf("dumping page table\n");
    2fbe:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2fc5:	b8 00 00 00 00       	mov    eax,0x0
    2fca:	e8 00 00 00 00       	call   2fcf <print_stacktrace+0x38b>
    2fcf:	e9 87 00 00 00       	jmp    305b <print_stacktrace+0x417>
						} else if (strcmp(str, "help") == 0 || strcmp(str, "h") == 0)
    2fd4:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2fd8:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2fdf:	48 89 c7             	mov    rdi,rax
    2fe2:	e8 00 00 00 00       	call   2fe7 <print_stacktrace+0x3a3>
    2fe7:	85 c0                	test   eax,eax
    2fe9:	0f 84 ba fd ff ff    	je     2da9 <print_stacktrace+0x165>
    2fef:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2ff3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2ffa:	48 89 c7             	mov    rdi,rax
    2ffd:	e8 00 00 00 00       	call   3002 <print_stacktrace+0x3be>
    3002:	85 c0                	test   eax,eax
    3004:	75 05                	jne    300b <print_stacktrace+0x3c7>
    3006:	e9 9e fd ff ff       	jmp    2da9 <print_stacktrace+0x165>
								goto print_help;
						else if (strcmp(str, "halt") == 0 || strcmp(str, "hlt") == 0)
    300b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    300f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3016:	48 89 c7             	mov    rdi,rax
    3019:	e8 00 00 00 00       	call   301e <print_stacktrace+0x3da>
    301e:	85 c0                	test   eax,eax
    3020:	74 17                	je     3039 <print_stacktrace+0x3f5>
    3022:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3026:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    302d:	48 89 c7             	mov    rdi,rax
    3030:	e8 00 00 00 00       	call   3035 <print_stacktrace+0x3f1>
    3035:	85 c0                	test   eax,eax
    3037:	75 0a                	jne    3043 <print_stacktrace+0x3ff>
								pc_shutdown();
    3039:	b8 00 00 00 00       	mov    eax,0x0
    303e:	e8 00 00 00 00       	call   3043 <print_stacktrace+0x3ff>
						else
								printf("unknown command \"%s\"\n", str);
    3043:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3047:	48 89 c6             	mov    rsi,rax
    304a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3051:	b8 00 00 00 00       	mov    eax,0x0
    3056:	e8 00 00 00 00       	call   305b <print_stacktrace+0x417>
						kfree(str);
    305b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    305f:	48 89 c7             	mov    rdi,rax
    3062:	e8 00 00 00 00       	call   3067 <print_stacktrace+0x423>
		while (1) {
    3067:	e9 5a fd ff ff       	jmp    2dc6 <print_stacktrace+0x182>

000000000000306c <mm_idt_init>:
		}
		stc--;
}

void mm_idt_init()
{
    306c:	55                   	push   rbp
    306d:	48 89 e5             	mov    rbp,rsp
		extern void idt_init();
		mm_protect(&mm_kernel, idt, 1, MMGR_MAP_SET | MMGR_MAP_WRITE);
    3070:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3077 <mm_idt_init+0xb>
    3077:	b9 04 10 00 00       	mov    ecx,0x1004
    307c:	ba 01 00 00 00       	mov    edx,0x1
    3081:	48 89 c6             	mov    rsi,rax
    3084:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    308b:	e8 00 00 00 00       	call   3090 <mm_idt_init+0x24>
		flush_tlb_single(idt);
    3090:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3097 <mm_idt_init+0x2b>
    3097:	48 89 c7             	mov    rdi,rax
    309a:	e8 7c cf ff ff       	call   1b <flush_tlb_single>
		idt_init();
    309f:	b8 00 00 00 00       	mov    eax,0x0
    30a4:	e8 00 00 00 00       	call   30a9 <mm_idt_init+0x3d>
		mm_protect(&mm_kernel, idt, 1, MMGR_MAP_UNSET | MMGR_MAP_WRITE);
    30a9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 30b0 <mm_idt_init+0x44>
    30b0:	b9 04 20 00 00       	mov    ecx,0x2004
    30b5:	ba 01 00 00 00       	mov    edx,0x1
    30ba:	48 89 c6             	mov    rsi,rax
    30bd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    30c4:	e8 00 00 00 00       	call   30c9 <mm_idt_init+0x5d>
		flush_tlb_single(idt);
    30c9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 30d0 <mm_idt_init+0x64>
    30d0:	48 89 c7             	mov    rdi,rax
    30d3:	e8 43 cf ff ff       	call   1b <flush_tlb_single>
}
    30d8:	90                   	nop
    30d9:	5d                   	pop    rbp
    30da:	c3                   	ret
