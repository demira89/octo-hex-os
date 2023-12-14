
mm/vmem.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <per_cpu_ptr>:
		rv = __sync_fetch_and_sub(pp, 4096);
		if (rv < VM_TABLE_LIMIT) {
				die("Out of virtual memory for paging structures.\n");
				return NULL;
		}
		mm_map(&mm_kernel, rv, &pr, 1, MMGR_MAP_WRITE
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 10          	sub    rsp,0x10
						| MMGR_MAP_KERNEL /*| MMGR_MAP_GLOBAL*/);

		return rv;
       8:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
      11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
}

#ifdef __x86_64__
void* mm_map64(void* vm_mapping, void* vaddr, struct page_range* pr, size_t prc,
      15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
			   	int x, int w, int wc, int wt, int cd, int g, int u, int avl)
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
		struct page_range pr_copy = *pr;
     16a:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     171:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     175:	48 8b 00             	mov    rax,QWORD PTR [rax]
     178:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
     17c:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx

		/* physical pointers */
		struct pte64 *p = vp->pml4;
     180:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     184:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     188:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		struct pte64* pl = 0;
     18c:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		struct pte64* pd = 0;
     194:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		struct pte64* pt = 0;
     19c:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
		/* mappings */
		struct vm_pdpte_ptr* m;
		struct vm_pde_ptr* n;

		/* calculate the PML4E */
		low48 = (uint64_t)vaddr & 0x0000ffffffffffff;
     1a4:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
     1ab:	48 ba ff ff ff ff ff ff 00 00 	movabs rdx,0xffffffffffff
     1b5:	48 21 d0             	and    rax,rdx
     1b8:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		pml4e = low48 >> 39; /* 512G per PML4E */
     1bc:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     1c0:	48 c1 e8 27          	shr    rax,0x27
     1c4:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax

		/* and the PDPTE */
		pdpte = (low48 & 0x007fc0000000) >> 30; /* 1G per PDPTE */
     1c7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     1cb:	48 c1 e8 1e          	shr    rax,0x1e
     1cf:	25 ff 01 00 00       	and    eax,0x1ff
     1d4:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax

		/* and the PDE */
		pde = (low48 & 0x3fe00000) >> 21; /* 2M per PDE */
     1d7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     1db:	48 c1 e8 15          	shr    rax,0x15
     1df:	25 ff 01 00 00       	and    eax,0x1ff
     1e4:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax

		/* and finally the PTE */
		pte = (low48 & 0x1ff000) >> 12; /* 4K per PTE */
     1e7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     1eb:	48 c1 e8 0c          	shr    rax,0xc
     1ef:	25 ff 01 00 00       	and    eax,0x1ff
     1f4:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax

		/* create one if not there */
new_pdpt:
		if (ENTER_CS_PTE(vp->pml4e[pml4e])) {
     1f7:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     1fa:	48 83 c0 02          	add    rax,0x2
     1fe:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     206:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     20a:	48 01 c2             	add    rdx,rax
     20d:	b8 00 00 00 00       	mov    eax,0x0
     212:	48 c7 c1 ff ff ff ff 	mov    rcx,0xffffffffffffffff
     219:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     21e:	0f 94 c0             	sete   al
     221:	84 c0                	test   al,al
     223:	0f 84 4e 01 00 00    	je     377 <mm_map64+0x24d>
				struct page_range pr2[2];
				/* allocate the PDPT */
				pl = mm_alloc_page(&pr2[0].base); /* alloc returns mapped memory */
     229:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
     230:	48 89 c7             	mov    rdi,rax
     233:	e8 00 00 00 00       	call   238 <mm_map64+0x10e>
     238:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax

				/* and set the reference in the PML4 */
				p[pml4e].addr = pr2[0].base / 4096;
     23c:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     243:	48 c1 e8 0c          	shr    rax,0xc
     247:	48 89 c1             	mov    rcx,rax
     24a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     24d:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     255:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     259:	48 01 d0             	add    rax,rdx
     25c:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     266:	48 21 d1             	and    rcx,rdx
     269:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     273:	48 21 ca             	and    rdx,rcx
     276:	48 c1 e2 0c          	shl    rdx,0xc
     27a:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     27d:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
     287:	48 21 f1             	and    rcx,rsi
     28a:	48 09 ca             	or     rdx,rcx
     28d:	48 89 10             	mov    QWORD PTR [rax],rdx
				p[pml4e].u = 1;
     290:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     293:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     29b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     29f:	48 01 d0             	add    rax,rdx
     2a2:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     2a5:	83 ca 04             	or     edx,0x4
     2a8:	88 10                	mov    BYTE PTR [rax],dl
				p[pml4e].w = 1;
     2aa:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     2ad:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     2b5:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     2b9:	48 01 d0             	add    rax,rdx
     2bc:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     2bf:	83 ca 02             	or     edx,0x2
     2c2:	88 10                	mov    BYTE PTR [rax],dl
				p[pml4e].p = 1;
     2c4:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     2c7:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     2cf:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     2d3:	48 01 d0             	add    rax,rdx
     2d6:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     2d9:	83 ca 01             	or     edx,0x1
     2dc:	88 10                	mov    BYTE PTR [rax],dl

				/* now allocate the map (2 pages) */
				mm_alloc_pm(2, pr2, 2); /* not cont. as only virt access */
     2de:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
     2e5:	ba 02 00 00 00       	mov    edx,0x2
     2ea:	48 89 c6             	mov    rsi,rax
     2ed:	bf 02 00 00 00       	mov    edi,0x2
     2f2:	e8 00 00 00 00       	call   2f7 <mm_map64+0x1cd>
				m = __sync_fetch_and_sub(&vp->cur, 8192) - 8192;
     2f7:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     2fb:	ba 00 20 00 00       	mov    edx,0x2000
     300:	48 f7 da             	neg    rdx
     303:	f0 48 0f c1 10       	lock xadd QWORD PTR [rax],rdx
     308:	48 8d 82 00 e0 ff ff 	lea    rax,[rdx-0x2000]
     30f:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				mm_map(&mm_kernel, m, pr2, pr2[0].count > 1 ? 1 : 2,
     313:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     31a:	48 83 f8 01          	cmp    rax,0x1
     31e:	76 07                	jbe    327 <mm_map64+0x1fd>
     320:	b9 01 00 00 00       	mov    ecx,0x1
     325:	eb 05                	jmp    32c <mm_map64+0x202>
     327:	b9 02 00 00 00       	mov    ecx,0x2
     32c:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
     333:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     337:	41 b8 0c 00 00 00    	mov    r8d,0xc
     33d:	48 89 c6             	mov    rsi,rax
     340:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     347:	e8 00 00 00 00       	call   34c <mm_map64+0x222>
								MMGR_MAP_WRITE | MMGR_MAP_KERNEL /*| MMGR_MAP_GLOBAL*/);
				vp->pdpte[pml4e] = m;
     34c:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     350:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     353:	48 8d 8a 02 02 00 00 	lea    rcx,[rdx+0x202]
     35a:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
     35e:	48 89 14 c8          	mov    QWORD PTR [rax+rcx*8],rdx

				/* release the CS */
				vp->pml4e[pml4e] = pl;
     362:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     366:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     369:	48 8d 4a 02          	lea    rcx,[rdx+0x2]
     36d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     371:	48 89 14 c8          	mov    QWORD PTR [rax+rcx*8],rdx
     375:	eb 32                	jmp    3a9 <mm_map64+0x27f>

		} else {
				/* wait for valid entry */
				SPIN_CS(vp->pml4e[pml4e]);
     377:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     37a:	48 83 c0 02          	add    rax,0x2
     37e:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     386:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     38a:	48 01 d0             	add    rax,rdx
     38d:	48 8b 00             	mov    rax,QWORD PTR [rax]
     390:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
     394:	74 e1                	je     377 <mm_map64+0x24d>
				pl = vp->pml4e[pml4e];
     396:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     39a:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     39d:	48 83 c2 02          	add    rdx,0x2
     3a1:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     3a5:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		}
		/* fetch the map */
		m = vp->pdpte[pml4e];
     3a9:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     3ad:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     3b0:	48 81 c2 02 02 00 00 	add    rdx,0x202
     3b7:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     3bb:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax

		/* now go on to the page directory */
new_pd:
		if (ENTER_CS_PTE(m->pds[pdpte])) {
     3bf:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     3c2:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     3ca:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     3ce:	48 01 c2             	add    rdx,rax
     3d1:	b8 00 00 00 00       	mov    eax,0x0
     3d6:	48 c7 c1 ff ff ff ff 	mov    rcx,0xffffffffffffffff
     3dd:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     3e2:	0f 94 c0             	sete   al
     3e5:	84 c0                	test   al,al
     3e7:	0f 84 e6 00 00 00    	je     4d3 <mm_map64+0x3a9>
				uint64_t b;
				/* allocate a page directory */
				pd = mm_alloc_page(&b);
     3ed:	48 8d 45 98          	lea    rax,[rbp-0x68]
     3f1:	48 89 c7             	mov    rdi,rax
     3f4:	e8 00 00 00 00       	call   3f9 <mm_map64+0x2cf>
     3f9:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax

				/* and set the reference in the PDPT */
				pl[pdpte].addr = b / 4096;
     3fd:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     401:	48 c1 e8 0c          	shr    rax,0xc
     405:	48 89 c1             	mov    rcx,rax
     408:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     40b:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     413:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     417:	48 01 d0             	add    rax,rdx
     41a:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     424:	48 21 d1             	and    rcx,rdx
     427:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     431:	48 21 ca             	and    rdx,rcx
     434:	48 c1 e2 0c          	shl    rdx,0xc
     438:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     43b:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
     445:	48 21 f1             	and    rcx,rsi
     448:	48 09 ca             	or     rdx,rcx
     44b:	48 89 10             	mov    QWORD PTR [rax],rdx
				pl[pdpte].u = 1;
     44e:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     451:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     459:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     45d:	48 01 d0             	add    rax,rdx
     460:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     463:	83 ca 04             	or     edx,0x4
     466:	88 10                	mov    BYTE PTR [rax],dl
				pl[pdpte].w = 1;
     468:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     46b:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     473:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     477:	48 01 d0             	add    rax,rdx
     47a:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     47d:	83 ca 02             	or     edx,0x2
     480:	88 10                	mov    BYTE PTR [rax],dl
				pl[pdpte].p = 1;
     482:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     485:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     48d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     491:	48 01 d0             	add    rax,rdx
     494:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     497:	83 ca 01             	or     edx,0x1
     49a:	88 10                	mov    BYTE PTR [rax],dl

				/* now allocate the map */
				n = mm_alloc_page(&b);
     49c:	48 8d 45 98          	lea    rax,[rbp-0x68]
     4a0:	48 89 c7             	mov    rdi,rax
     4a3:	e8 00 00 00 00       	call   4a8 <mm_map64+0x37e>
     4a8:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
				m->pdes[pdpte] = n;
     4ac:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     4b0:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
     4b3:	48 8d 8a 00 02 00 00 	lea    rcx,[rdx+0x200]
     4ba:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     4be:	48 89 14 c8          	mov    QWORD PTR [rax+rcx*8],rdx

				/* release the CS */
				m->pds[pdpte] = pd;
     4c2:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     4c6:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
     4c9:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     4cd:	48 89 0c d0          	mov    QWORD PTR [rax+rdx*8],rcx
     4d1:	eb 2a                	jmp    4fd <mm_map64+0x3d3>

		} else {
				SPIN_CS(m->pds[pdpte]);
     4d3:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     4d6:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     4de:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     4e2:	48 01 d0             	add    rax,rdx
     4e5:	48 8b 00             	mov    rax,QWORD PTR [rax]
     4e8:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
     4ec:	74 e5                	je     4d3 <mm_map64+0x3a9>
				pd = m->pds[pdpte];
     4ee:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     4f2:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
     4f5:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     4f9:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		}
		/* fetch the map */
		n = m->pdes[pdpte];
     4fd:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     501:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
     504:	48 81 c2 00 02 00 00 	add    rdx,0x200
     50b:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     50f:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax

		/* now select the page table */
new_pt:
		if (ENTER_CS_PTE(n->pts[pde])) {
     513:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     516:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     51e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     522:	48 01 c2             	add    rdx,rax
     525:	b8 00 00 00 00       	mov    eax,0x0
     52a:	48 c7 c1 ff ff ff ff 	mov    rcx,0xffffffffffffffff
     531:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     536:	0f 94 c0             	sete   al
     539:	84 c0                	test   al,al
     53b:	0f 84 c3 00 00 00    	je     604 <mm_map64+0x4da>
				uint64_t b;
				/* allocate a page table */
				pt = mm_alloc_page(&b);
     541:	48 8d 45 90          	lea    rax,[rbp-0x70]
     545:	48 89 c7             	mov    rdi,rax
     548:	e8 00 00 00 00       	call   54d <mm_map64+0x423>
     54d:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax

				/* and set the reference in the PD */
				pd[pde].addr = b / 4096;
     551:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     555:	48 c1 e8 0c          	shr    rax,0xc
     559:	48 89 c1             	mov    rcx,rax
     55c:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     55f:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     567:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     56b:	48 01 d0             	add    rax,rdx
     56e:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     578:	48 21 d1             	and    rcx,rdx
     57b:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     585:	48 21 ca             	and    rdx,rcx
     588:	48 c1 e2 0c          	shl    rdx,0xc
     58c:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     58f:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
     599:	48 21 f1             	and    rcx,rsi
     59c:	48 09 ca             	or     rdx,rcx
     59f:	48 89 10             	mov    QWORD PTR [rax],rdx
				pd[pde].u = 1;
     5a2:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     5a5:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     5ad:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5b1:	48 01 d0             	add    rax,rdx
     5b4:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     5b7:	83 ca 04             	or     edx,0x4
     5ba:	88 10                	mov    BYTE PTR [rax],dl
				pd[pde].w = 1;
     5bc:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     5bf:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     5c7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5cb:	48 01 d0             	add    rax,rdx
     5ce:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     5d1:	83 ca 02             	or     edx,0x2
     5d4:	88 10                	mov    BYTE PTR [rax],dl
				pd[pde].p = 1;
     5d6:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     5d9:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     5e1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5e5:	48 01 d0             	add    rax,rdx
     5e8:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     5eb:	83 ca 01             	or     edx,0x1
     5ee:	88 10                	mov    BYTE PTR [rax],dl

				/* release the CS */
				n->pts[pde] = pt;
     5f0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     5f4:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
     5f7:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
     5fb:	48 89 0c d0          	mov    QWORD PTR [rax+rdx*8],rcx
     5ff:	e9 39 03 00 00       	jmp    93d <mm_map64+0x813>

		} else {
				SPIN_CS(n->pts[pde]);
     604:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     607:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     60f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     613:	48 01 d0             	add    rax,rdx
     616:	48 8b 00             	mov    rax,QWORD PTR [rax]
     619:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
     61d:	74 e5                	je     604 <mm_map64+0x4da>
				pt = n->pts[pde];
     61f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     623:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
     626:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     62a:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
		}

		/* now map the pages */
		while (prc) {
     62e:	e9 0a 03 00 00       	jmp    93d <mm_map64+0x813>
				pt[pte].addr = pr_copy.base / 4096;
     633:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     637:	48 c1 e8 0c          	shr    rax,0xc
     63b:	48 89 c1             	mov    rcx,rax
     63e:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     641:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     649:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     64d:	48 01 d0             	add    rax,rdx
     650:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     65a:	48 21 d1             	and    rcx,rdx
     65d:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
     667:	48 21 ca             	and    rdx,rcx
     66a:	48 c1 e2 0c          	shl    rdx,0xc
     66e:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     671:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
     67b:	48 21 f1             	and    rcx,rsi
     67e:	48 09 ca             	or     rdx,rcx
     681:	48 89 10             	mov    QWORD PTR [rax],rdx
				pt[pte].u = (u ? 1 : 0); /* FIXME: for now (u ? 1 : 0) */
     684:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     687:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     68f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     693:	48 01 d0             	add    rax,rdx
     696:	83 7d 30 00          	cmp    DWORD PTR [rbp+0x30],0x0
     69a:	0f 95 c2             	setne  dl
     69d:	83 e2 01             	and    edx,0x1
     6a0:	8d 0c 95 00 00 00 00 	lea    ecx,[rdx*4+0x0]
     6a7:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     6aa:	83 e2 fb             	and    edx,0xfffffffb
     6ad:	09 ca                	or     edx,ecx
     6af:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].w = (w ? 1 : 0);
     6b1:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     6b4:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     6bc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     6c0:	48 01 d0             	add    rax,rdx
     6c3:	83 bd 48 ff ff ff 00 	cmp    DWORD PTR [rbp-0xb8],0x0
     6ca:	0f 95 c2             	setne  dl
     6cd:	83 e2 01             	and    edx,0x1
     6d0:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
     6d3:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     6d6:	83 e2 fd             	and    edx,0xfffffffd
     6d9:	09 ca                	or     edx,ecx
     6db:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].p = 1;
     6dd:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     6e0:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     6e8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     6ec:	48 01 d0             	add    rax,rdx
     6ef:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     6f2:	83 ca 01             	or     edx,0x1
     6f5:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].s = (wc ? 1 : 0); /* PAT bit */
     6f7:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     6fa:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     702:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     706:	48 01 d0             	add    rax,rdx
     709:	83 7d 10 00          	cmp    DWORD PTR [rbp+0x10],0x0
     70d:	0f 95 c2             	setne  dl
     710:	89 d1                	mov    ecx,edx
     712:	c1 e1 07             	shl    ecx,0x7
     715:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     718:	83 e2 7f             	and    edx,0x7f
     71b:	09 ca                	or     edx,ecx
     71d:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].wt = (wt ? 1 : 0);
     71f:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     722:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     72a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     72e:	48 01 d0             	add    rax,rdx
     731:	83 7d 18 00          	cmp    DWORD PTR [rbp+0x18],0x0
     735:	0f 95 c2             	setne  dl
     738:	83 e2 01             	and    edx,0x1
     73b:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
     742:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     745:	83 e2 f7             	and    edx,0xfffffff7
     748:	09 ca                	or     edx,ecx
     74a:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].cd = (cd ? 1 : 0);
     74c:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     74f:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     757:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     75b:	48 01 d0             	add    rax,rdx
     75e:	83 7d 20 00          	cmp    DWORD PTR [rbp+0x20],0x0
     762:	0f 95 c2             	setne  dl
     765:	83 e2 01             	and    edx,0x1
     768:	89 d1                	mov    ecx,edx
     76a:	c1 e1 04             	shl    ecx,0x4
     76d:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     770:	83 e2 ef             	and    edx,0xffffffef
     773:	09 ca                	or     edx,ecx
     775:	88 10                	mov    BYTE PTR [rax],dl
				pt[pte].g = (g ? 1 : 0);
     777:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     77a:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     782:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     786:	48 01 d0             	add    rax,rdx
     789:	83 7d 28 00          	cmp    DWORD PTR [rbp+0x28],0x0
     78d:	0f 95 c2             	setne  dl
     790:	89 d1                	mov    ecx,edx
     792:	83 e1 01             	and    ecx,0x1
     795:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
     799:	83 e2 fe             	and    edx,0xfffffffe
     79c:	09 ca                	or     edx,ecx
     79e:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
				pt[pte].ign = avl & 7;
     7a1:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     7a4:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     7ac:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     7b0:	48 01 c2             	add    rdx,rax
     7b3:	8b 45 38             	mov    eax,DWORD PTR [rbp+0x38]
     7b6:	83 e0 07             	and    eax,0x7
     7b9:	83 e0 07             	and    eax,0x7
     7bc:	8d 0c 00             	lea    ecx,[rax+rax*1]
     7bf:	0f b6 42 01          	movzx  eax,BYTE PTR [rdx+0x1]
     7c3:	83 e0 f1             	and    eax,0xfffffff1
     7c6:	09 c8                	or     eax,ecx
     7c8:	88 42 01             	mov    BYTE PTR [rdx+0x1],al
				pt[pte].ign2 = (avl >> 3);
     7cb:	8b 45 38             	mov    eax,DWORD PTR [rbp+0x38]
     7ce:	c1 f8 03             	sar    eax,0x3
     7d1:	89 c1                	mov    ecx,eax
     7d3:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     7d6:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     7de:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     7e2:	48 01 c2             	add    rdx,rax
     7e5:	89 c8                	mov    eax,ecx
     7e7:	66 25 ff 07          	and    ax,0x7ff
     7eb:	66 25 ff 07          	and    ax,0x7ff
     7ef:	c1 e0 04             	shl    eax,0x4
     7f2:	89 c1                	mov    ecx,eax
     7f4:	0f b7 42 06          	movzx  eax,WORD PTR [rdx+0x6]
     7f8:	66 25 0f 80          	and    ax,0x800f
     7fc:	09 c8                	or     eax,ecx
     7fe:	66 89 42 06          	mov    WORD PTR [rdx+0x6],ax
				if (cpu.e_has_nx)
     802:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 809 <mm_map64+0x6df>
     809:	83 e0 10             	and    eax,0x10
     80c:	84 c0                	test   al,al
     80e:	74 2d                	je     83d <mm_map64+0x713>
						pt[pte].xd = (x ? 0 : 1);
     810:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     813:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     81b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     81f:	48 01 d0             	add    rax,rdx
     822:	83 bd 4c ff ff ff 00 	cmp    DWORD PTR [rbp-0xb4],0x0
     829:	0f 94 c2             	sete   dl
     82c:	89 d1                	mov    ecx,edx
     82e:	c1 e1 07             	shl    ecx,0x7
     831:	0f b6 50 07          	movzx  edx,BYTE PTR [rax+0x7]
     835:	83 e2 7f             	and    edx,0x7f
     838:	09 ca                	or     edx,ecx
     83a:	88 50 07             	mov    BYTE PTR [rax+0x7],dl
				/* advance */
				if (pte++ == 511) {
     83d:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     840:	8d 50 01             	lea    edx,[rax+0x1]
     843:	89 55 f0             	mov    DWORD PTR [rbp-0x10],edx
     846:	3d ff 01 00 00       	cmp    eax,0x1ff
     84b:	0f 85 99 00 00 00    	jne    8ea <mm_map64+0x7c0>
						if (pde++ == 511) {
     851:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     854:	8d 50 01             	lea    edx,[rax+0x1]
     857:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
     85a:	3d ff 01 00 00       	cmp    eax,0x1ff
     85f:	75 7d                	jne    8de <mm_map64+0x7b4>
								if (pdpte++ == 511) {
     861:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     864:	8d 50 01             	lea    edx,[rax+0x1]
     867:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
     86a:	3d ff 01 00 00       	cmp    eax,0x1ff
     86f:	75 5a                	jne    8cb <mm_map64+0x7a1>
										if (pml4e++ == 511) {
     871:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     874:	8d 50 01             	lea    edx,[rax+0x1]
     877:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
     87a:	3d ff 01 00 00       	cmp    eax,0x1ff
     87f:	75 30                	jne    8b1 <mm_map64+0x787>
												die("End of 16E address space\n");
     881:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     888:	bf 0c 00 00 00       	mov    edi,0xc
     88d:	b8 00 00 00 00       	mov    eax,0x0
     892:	e8 00 00 00 00       	call   897 <mm_map64+0x76d>
     897:	b8 00 00 00 00       	mov    eax,0x0
     89c:	e8 00 00 00 00       	call   8a1 <mm_map64+0x777>
     8a1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     8a8:	e8 00 00 00 00       	call   8ad <mm_map64+0x783>
     8ad:	fa                   	cli
     8ae:	f4                   	hlt
     8af:	eb fd                	jmp    8ae <mm_map64+0x784>
										}
										pdpte = 0;
     8b1:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
										pde = 0;
     8b8:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
										pte = 0;
     8bf:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
										goto new_pdpt;
     8c6:	e9 2c f9 ff ff       	jmp    1f7 <mm_map64+0xcd>
								}
								pde = 0;
     8cb:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
								pte = 0;
     8d2:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
								goto new_pd;
     8d9:	e9 e1 fa ff ff       	jmp    3bf <mm_map64+0x295>
						}
						pte = 0;
     8de:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
						goto new_pt;
     8e5:	e9 29 fc ff ff       	jmp    513 <mm_map64+0x3e9>
				}
				pr_copy.base += 4096;
     8ea:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     8ee:	48 05 00 10 00 00    	add    rax,0x1000
     8f4:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
				if (!--pr_copy.count) {
     8f8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     8fc:	48 83 e8 01          	sub    rax,0x1
     900:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
     904:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     908:	48 85 c0             	test   rax,rax
     90b:	75 30                	jne    93d <mm_map64+0x813>
						if (--prc)
     90d:	48 83 ad 50 ff ff ff 01 	sub    QWORD PTR [rbp-0xb0],0x1
     915:	48 83 bd 50 ff ff ff 00 	cmp    QWORD PTR [rbp-0xb0],0x0
     91d:	74 1e                	je     93d <mm_map64+0x813>
								pr_copy = *++pr; /* advance then dereference */
     91f:	48 83 85 58 ff ff ff 10 	add    QWORD PTR [rbp-0xa8],0x10
     927:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
     92e:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     932:	48 8b 00             	mov    rax,QWORD PTR [rax]
     935:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
     939:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
		while (prc) {
     93d:	48 83 bd 50 ff ff ff 00 	cmp    QWORD PTR [rbp-0xb0],0x0
     945:	0f 85 e8 fc ff ff    	jne    633 <mm_map64+0x509>
				}
		}
		return vaddr;
     94b:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
}
     952:	c9                   	leave
     953:	c3                   	ret

0000000000000954 <mm_map>:
map_fun mf_map = NULL;
#endif

void* mm_map(struct mm* mm, void* virt_address,	const struct page_range* prs,
				size_t pr_ct, int flags)
{
     954:	55                   	push   rbp
     955:	48 89 e5             	mov    rbp,rsp
     958:	48 81 ec 90 00 00 00 	sub    rsp,0x90
     95f:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     963:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
     967:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
     96b:	48 89 4d b0          	mov    QWORD PTR [rbp-0x50],rcx
     96f:	44 89 45 ac          	mov    DWORD PTR [rbp-0x54],r8d
		int x = !!(flags & MMGR_MAP_EXECUTE), w = !!(flags & MMGR_MAP_WRITE),
     973:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     976:	83 e0 02             	and    eax,0x2
     979:	85 c0                	test   eax,eax
     97b:	0f 95 c0             	setne  al
     97e:	0f b6 c0             	movzx  eax,al
     981:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
     984:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     987:	83 e0 04             	and    eax,0x4
     98a:	85 c0                	test   eax,eax
     98c:	0f 95 c0             	setne  al
     98f:	0f b6 c0             	movzx  eax,al
     992:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
			wc = !!(flags & MMGR_MAP_PAT), wt = !!(flags & MMGR_MAP_WRITE_THROUGH),
     995:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     998:	25 80 00 00 00       	and    eax,0x80
     99d:	85 c0                	test   eax,eax
     99f:	0f 95 c0             	setne  al
     9a2:	0f b6 c0             	movzx  eax,al
     9a5:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
     9a8:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9ab:	83 e0 10             	and    eax,0x10
     9ae:	85 c0                	test   eax,eax
     9b0:	0f 95 c0             	setne  al
     9b3:	0f b6 c0             	movzx  eax,al
     9b6:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
			cd = !!(flags & MMGR_MAP_NO_CACHING), g = !!(flags & MMGR_MAP_GLOBAL),
     9b9:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9bc:	83 e0 20             	and    eax,0x20
     9bf:	85 c0                	test   eax,eax
     9c1:	0f 95 c0             	setne  al
     9c4:	0f b6 c0             	movzx  eax,al
     9c7:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
     9ca:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9cd:	83 e0 40             	and    eax,0x40
     9d0:	85 c0                	test   eax,eax
     9d2:	0f 95 c0             	setne  al
     9d5:	0f b6 c0             	movzx  eax,al
     9d8:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
			u = !(flags & MMGR_MAP_KERNEL);
     9db:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9de:	83 e0 08             	and    eax,0x8
     9e1:	85 c0                	test   eax,eax
     9e3:	0f 94 c0             	sete   al
     9e6:	0f b6 c0             	movzx  eax,al
     9e9:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
		int avl = 0;
     9ec:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0

		if (flags & MMGR_MAP_COW) {
     9f3:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
     9f6:	25 00 02 00 00       	and    eax,0x200
     9fb:	85 c0                	test   eax,eax
     9fd:	74 0e                	je     a0d <mm_map+0xb9>
				avl = MMGR_AVL_COW;
     9ff:	c7 45 f8 01 00 00 00 	mov    DWORD PTR [rbp-0x8],0x1
				w = 0; /* make COW workable */
     a06:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		}

		/* get virtutal memory */
		if (!virt_address) {
     a0d:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
     a12:	75 55                	jne    a69 <mm_map+0x115>
				size_t pg_ct = 0;
     a14:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				for (size_t i = 0; i < pr_ct; i++)
     a1c:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     a24:	eb 1f                	jmp    a45 <mm_map+0xf1>
						pg_ct += prs[i].count;
     a26:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a2a:	48 c1 e0 04          	shl    rax,0x4
     a2e:	48 89 c2             	mov    rdx,rax
     a31:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     a35:	48 01 d0             	add    rax,rdx
     a38:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     a3c:	48 01 45 f0          	add    QWORD PTR [rbp-0x10],rax
				for (size_t i = 0; i < pr_ct; i++)
     a40:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     a45:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a49:	48 3b 45 b0          	cmp    rax,QWORD PTR [rbp-0x50]
     a4d:	72 d7                	jb     a26 <mm_map+0xd2>
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);
     a4f:	8b 55 ac             	mov    edx,DWORD PTR [rbp-0x54]
     a52:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
     a56:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     a5a:	48 89 ce             	mov    rsi,rcx
     a5d:	48 89 c7             	mov    rdi,rax
     a60:	e8 00 00 00 00       	call   a65 <mm_map+0x111>
     a65:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		}

#ifdef __x86_64__
		return mm_map64(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
     a69:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     a6d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     a71:	44 8b 4d fc          	mov    r9d,DWORD PTR [rbp-0x4]
     a75:	44 8b 45 e4          	mov    r8d,DWORD PTR [rbp-0x1c]
     a79:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
     a7d:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
     a81:	48 8b 75 c0          	mov    rsi,QWORD PTR [rbp-0x40]
     a85:	8b 7d f8             	mov    edi,DWORD PTR [rbp-0x8]
     a88:	89 7c 24 28          	mov    DWORD PTR [rsp+0x28],edi
     a8c:	8b 7d d0             	mov    edi,DWORD PTR [rbp-0x30]
     a8f:	89 7c 24 20          	mov    DWORD PTR [rsp+0x20],edi
     a93:	8b 7d d4             	mov    edi,DWORD PTR [rbp-0x2c]
     a96:	89 7c 24 18          	mov    DWORD PTR [rsp+0x18],edi
     a9a:	8b 7d d8             	mov    edi,DWORD PTR [rbp-0x28]
     a9d:	89 7c 24 10          	mov    DWORD PTR [rsp+0x10],edi
     aa1:	8b 7d dc             	mov    edi,DWORD PTR [rbp-0x24]
     aa4:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
     aa8:	8b 7d e0             	mov    edi,DWORD PTR [rbp-0x20]
     aab:	89 3c 24             	mov    DWORD PTR [rsp],edi
     aae:	48 89 c7             	mov    rdi,rax
     ab1:	e8 00 00 00 00       	call   ab6 <mm_map+0x162>
#else
		return mf_map(mm->ctx, virt_address, prs, pr_ct, x, w, wc, wt, cd, g, u, avl);
#endif
}
     ab6:	c9                   	leave
     ab7:	c3                   	ret

0000000000000ab8 <mm_page_walk64>:

#ifdef __x86_64__
int mm_page_walk64(void* vm_mapping, void* virt_addr, struct pte64** parent,
				struct pte64** entry, int* level, uint32_t* offset, void*** cntr, void*** cntrm)
{
     ab8:	55                   	push   rbp
     ab9:	48 89 e5             	mov    rbp,rsp
     abc:	48 83 c4 80          	add    rsp,0xffffffffffffff80
     ac0:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
     ac4:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
     ac8:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
     acc:	48 89 4d 90          	mov    QWORD PTR [rbp-0x70],rcx
     ad0:	4c 89 45 88          	mov    QWORD PTR [rbp-0x78],r8
     ad4:	4c 89 4d 80          	mov    QWORD PTR [rbp-0x80],r9
		uint64_t low48;
		struct vm_pg_ptrs64* vp = vm_mapping;
     ad8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     adc:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		uint32_t pml4e, pdpte, pde, pte;

		/* entry pointers */
		struct pte64 *p = vp->pml4;
     ae0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ae4:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     ae8:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		struct pte64* pl = 0;
     aec:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		struct pte64* pd = 0;
     af4:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		struct pte64* pt = 0;
     afc:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
		/* mappings */
		struct vm_pdpte_ptr* m;
		struct vm_pde_ptr* n;

		/* calculate the PML4E */
		low48 = (uint64_t)virt_addr & 0x0000ffffffffffff;
     b04:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b08:	48 ba ff ff ff ff ff ff 00 00 	movabs rdx,0xffffffffffff
     b12:	48 21 d0             	and    rax,rdx
     b15:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		pml4e = low48 >> 39; /* 512G per PML4E */
     b19:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b1d:	48 c1 e8 27          	shr    rax,0x27
     b21:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax

		/* and the PDPTE */
		pdpte = (low48 & 0x007fc0000000) >> 30; /* 1G per PDPTE */
     b24:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b28:	48 c1 e8 1e          	shr    rax,0x1e
     b2c:	25 ff 01 00 00       	and    eax,0x1ff
     b31:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax

		/* and the PDE */
		pde = (low48 & 0x3fe00000) >> 21; /* 2M per PDE */
     b34:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b38:	48 c1 e8 15          	shr    rax,0x15
     b3c:	25 ff 01 00 00       	and    eax,0x1ff
     b41:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax

		/* and finally the PTE */
		pte = (low48 & 0x1ff000) >> 12; /* 4K per PTE */
     b44:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b48:	48 c1 e8 0c          	shr    rax,0xc
     b4c:	25 ff 01 00 00       	and    eax,0x1ff
     b51:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax

		/* Now walk down the hierachy */
		if (!p) {
     b54:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     b59:	75 37                	jne    b92 <mm_page_walk64+0xda>
				*parent = *entry = NULL;
     b5b:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     b5f:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
     b66:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     b6a:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     b6d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     b71:	48 89 10             	mov    QWORD PTR [rax],rdx
				*offset = -1;
     b74:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     b78:	c7 00 ff ff ff ff    	mov    DWORD PTR [rax],0xffffffff
				*level = 4; /* missing lvl4 (very unlikely) */
     b7e:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     b82:	c7 00 04 00 00 00    	mov    DWORD PTR [rax],0x4
				return -1;
     b88:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b8d:	e9 f3 02 00 00       	jmp    e85 <mm_page_walk64+0x3cd>
		}

		/* PML4 (no size bit exists) */
		if (!p[pml4e].p) {
     b92:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     b95:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     b9d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     ba1:	48 01 d0             	add    rax,rdx
     ba4:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     ba7:	83 e0 01             	and    eax,0x1
     baa:	84 c0                	test   al,al
     bac:	75 62                	jne    c10 <mm_page_walk64+0x158>
				*entry = &p[pml4e];
     bae:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     bb1:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     bb9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     bbd:	48 01 c2             	add    rdx,rax
     bc0:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     bc4:	48 89 10             	mov    QWORD PTR [rax],rdx
				*parent = p; /* to ensure parent[offset]=entry */
     bc7:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     bcb:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     bcf:	48 89 10             	mov    QWORD PTR [rax],rdx
				*offset = pml4e;
     bd2:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     bd6:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
     bd9:	89 10                	mov    DWORD PTR [rax],edx
				*level = 3;
     bdb:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     bdf:	c7 00 03 00 00 00    	mov    DWORD PTR [rax],0x3
				*cntr = (void**)vp->pml4e;
     be5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     be9:	48 8d 50 10          	lea    rdx,[rax+0x10]
     bed:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     bf1:	48 89 10             	mov    QWORD PTR [rax],rdx
				*cntrm = (void**)vp->pdpte;
     bf4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bf8:	48 8d 90 10 10 00 00 	lea    rdx,[rax+0x1010]
     bff:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     c03:	48 89 10             	mov    QWORD PTR [rax],rdx
				return -1;
     c06:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c0b:	e9 75 02 00 00       	jmp    e85 <mm_page_walk64+0x3cd>
		}

		m = vp->pdpte[pml4e];
     c10:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c14:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
     c17:	48 81 c2 02 02 00 00 	add    rdx,0x202
     c1e:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     c22:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
		pl = vp->pml4e[pml4e];
     c26:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c2a:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
     c2d:	48 83 c2 02          	add    rdx,0x2
     c31:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     c35:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax

		/* PDPTE */
		if (!pl[pdpte].p || pl[pdpte].s) {
     c39:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c3c:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     c44:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c48:	48 01 d0             	add    rax,rdx
     c4b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c4e:	83 e0 01             	and    eax,0x1
     c51:	84 c0                	test   al,al
     c53:	74 20                	je     c75 <mm_page_walk64+0x1bd>
     c55:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c58:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     c60:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c64:	48 01 d0             	add    rax,rdx
     c67:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c6a:	83 e0 80             	and    eax,0xffffff80
     c6d:	84 c0                	test   al,al
     c6f:	0f 84 92 00 00 00    	je     d07 <mm_page_walk64+0x24f>
				*parent = &p[pml4e];
     c75:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     c78:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     c80:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c84:	48 01 c2             	add    rdx,rax
     c87:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     c8b:	48 89 10             	mov    QWORD PTR [rax],rdx
				*entry = &pl[pdpte];
     c8e:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c91:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     c99:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c9d:	48 01 c2             	add    rdx,rax
     ca0:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     ca4:	48 89 10             	mov    QWORD PTR [rax],rdx
				*level = 2;
     ca7:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     cab:	c7 00 02 00 00 00    	mov    DWORD PTR [rax],0x2
				*offset = pdpte;
     cb1:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     cb5:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
     cb8:	89 10                	mov    DWORD PTR [rax],edx
				*cntr = (void**)m->pds;
     cba:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
     cbe:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     cc2:	48 89 10             	mov    QWORD PTR [rax],rdx
				*cntrm = (void**)m->pdes;
     cc5:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     cc9:	48 8d 90 00 10 00 00 	lea    rdx,[rax+0x1000]
     cd0:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     cd4:	48 89 10             	mov    QWORD PTR [rax],rdx
				/* 1G page is OK */
				return (pl[pdpte].s ? 0 : -1);
     cd7:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     cda:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     ce2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     ce6:	48 01 d0             	add    rax,rdx
     ce9:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     cec:	83 e0 80             	and    eax,0xffffff80
     cef:	84 c0                	test   al,al
     cf1:	74 0a                	je     cfd <mm_page_walk64+0x245>
     cf3:	b8 00 00 00 00       	mov    eax,0x0
     cf8:	e9 88 01 00 00       	jmp    e85 <mm_page_walk64+0x3cd>
     cfd:	b8 ff ff ff ff       	mov    eax,0xffffffff
     d02:	e9 7e 01 00 00       	jmp    e85 <mm_page_walk64+0x3cd>
		}

		n = m->pdes[pdpte];
     d07:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     d0b:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
     d0e:	48 81 c2 00 02 00 00 	add    rdx,0x200
     d15:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     d19:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		pd = m->pds[pdpte];
     d1d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     d21:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
     d24:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     d28:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax

		/* PDE */
		if (!pd[pde].p || pd[pde].s) {
     d2c:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d2f:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     d37:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d3b:	48 01 d0             	add    rax,rdx
     d3e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     d41:	83 e0 01             	and    eax,0x1
     d44:	84 c0                	test   al,al
     d46:	74 20                	je     d68 <mm_page_walk64+0x2b0>
     d48:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d4b:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     d53:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d57:	48 01 d0             	add    rax,rdx
     d5a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     d5d:	83 e0 80             	and    eax,0xffffff80
     d60:	84 c0                	test   al,al
     d62:	0f 84 8b 00 00 00    	je     df3 <mm_page_walk64+0x33b>
				*parent = &pl[pdpte];
     d68:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     d6b:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     d73:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d77:	48 01 c2             	add    rdx,rax
     d7a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     d7e:	48 89 10             	mov    QWORD PTR [rax],rdx
				*entry = &pd[pde];
     d81:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d84:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     d8c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     d90:	48 01 c2             	add    rdx,rax
     d93:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     d97:	48 89 10             	mov    QWORD PTR [rax],rdx
				*level = 1;
     d9a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     d9e:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
				*offset = pde;
     da4:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     da8:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
     dab:	89 10                	mov    DWORD PTR [rax],edx
				*cntr = (void**)n->pts;
     dad:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     db1:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     db5:	48 89 10             	mov    QWORD PTR [rax],rdx
				*cntrm = NULL;
     db8:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     dbc:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				/* 2M page is OK */
				return (pd[pde].s ? 0 : -1);
     dc3:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     dc6:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     dce:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     dd2:	48 01 d0             	add    rax,rdx
     dd5:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     dd8:	83 e0 80             	and    eax,0xffffff80
     ddb:	84 c0                	test   al,al
     ddd:	74 0a                	je     de9 <mm_page_walk64+0x331>
     ddf:	b8 00 00 00 00       	mov    eax,0x0
     de4:	e9 9c 00 00 00       	jmp    e85 <mm_page_walk64+0x3cd>
     de9:	b8 ff ff ff ff       	mov    eax,0xffffffff
     dee:	e9 92 00 00 00       	jmp    e85 <mm_page_walk64+0x3cd>
		}

		pt = n->pts[pde];
     df3:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     df7:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
     dfa:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
     dfe:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax

		/* PTE */
		*parent = &pd[pde];
     e02:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     e05:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     e0d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     e11:	48 01 c2             	add    rdx,rax
     e14:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     e18:	48 89 10             	mov    QWORD PTR [rax],rdx
		*entry = &pt[pte];
     e1b:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
     e1e:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     e26:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     e2a:	48 01 c2             	add    rdx,rax
     e2d:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
     e31:	48 89 10             	mov    QWORD PTR [rax],rdx
		*level = 0;
     e34:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     e38:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		*offset = pte;
     e3e:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
     e42:	8b 55 c0             	mov    edx,DWORD PTR [rbp-0x40]
     e45:	89 10                	mov    DWORD PTR [rax],edx
		*cntr = NULL;
     e47:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     e4b:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
		*cntrm = NULL;
     e52:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     e56:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
		/* present or not? */
		return (pt[pte].p ? 0 : -1);
     e5d:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
     e60:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     e68:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     e6c:	48 01 d0             	add    rax,rdx
     e6f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     e72:	83 e0 01             	and    eax,0x1
     e75:	84 c0                	test   al,al
     e77:	74 07                	je     e80 <mm_page_walk64+0x3c8>
     e79:	b8 00 00 00 00       	mov    eax,0x0
     e7e:	eb 05                	jmp    e85 <mm_page_walk64+0x3cd>
     e80:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     e85:	c9                   	leave
     e86:	c3                   	ret

0000000000000e87 <mm_protect>:
		return (pt[pte].p ? 0 : -1);
}
#endif

void mm_protect(struct mm* mm, void* virt_address, size_t num_pages, int flags)
{
     e87:	55                   	push   rbp
     e88:	48 89 e5             	mov    rbp,rsp
     e8b:	48 83 ec 70          	sub    rsp,0x70
     e8f:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
     e93:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
     e97:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
     e9b:	89 4d a4             	mov    DWORD PTR [rbp-0x5c],ecx
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (num_pages--) {
     e9e:	e9 ea 06 00 00       	jmp    158d <mm_protect+0x706>
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
     ea3:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     ea7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     eab:	4c 8d 4d e0          	lea    r9,[rbp-0x20]
     eaf:	4c 8d 45 e4          	lea    r8,[rbp-0x1c]
     eb3:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
     eb7:	48 8d 55 d8          	lea    rdx,[rbp-0x28]
     ebb:	48 8b 75 b0          	mov    rsi,QWORD PTR [rbp-0x50]
     ebf:	48 8d 7d c0          	lea    rdi,[rbp-0x40]
     ec3:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
     ec8:	48 8d 7d c8          	lea    rdi,[rbp-0x38]
     ecc:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
     ed0:	48 89 c7             	mov    rdi,rax
     ed3:	e8 00 00 00 00       	call   ed8 <mm_protect+0x51>
     ed8:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
     edb:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     edf:	0f 85 bf 06 00 00    	jne    15a4 <mm_protect+0x71d>
						return;

				e32 = NULL; e64 = NULL;
     ee5:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     eed:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (!cpu.has_pae)
     ef5:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # efc <mm_protect+0x75>
     efc:	83 e0 40             	and    eax,0x40
     eff:	84 c0                	test   al,al
     f01:	75 0a                	jne    f0d <mm_protect+0x86>
						e32 = e;
     f03:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     f07:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     f0b:	eb 08                	jmp    f15 <mm_protect+0x8e>
				else
						e64 = e;
     f0d:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     f11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		
				/* set/unset or override */
				if (flags & MMGR_MAP_PURGE_ACC)
     f15:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f18:	25 00 04 00 00       	and    eax,0x400
     f1d:	85 c0                	test   eax,eax
     f1f:	74 29                	je     f4a <mm_protect+0xc3>
						if (e64)
     f21:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     f26:	74 11                	je     f39 <mm_protect+0xb2>
								e64->a = 0;
     f28:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f2c:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     f2f:	83 e2 df             	and    edx,0xffffffdf
     f32:	88 10                	mov    BYTE PTR [rax],dl
     f34:	e9 cd 05 00 00       	jmp    1506 <mm_protect+0x67f>
						else
								e32->a = 0;
     f39:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f3d:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     f40:	83 e2 df             	and    edx,0xffffffdf
     f43:	88 10                	mov    BYTE PTR [rax],dl
     f45:	e9 bc 05 00 00       	jmp    1506 <mm_protect+0x67f>
				else if (flags & MMGR_MAP_PURGE_DIRTY)
     f4a:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f4d:	25 00 08 00 00       	and    eax,0x800
     f52:	85 c0                	test   eax,eax
     f54:	74 29                	je     f7f <mm_protect+0xf8>
						if (e64)
     f56:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     f5b:	74 11                	je     f6e <mm_protect+0xe7>
								e64->d = 0;
     f5d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f61:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     f64:	83 e2 bf             	and    edx,0xffffffbf
     f67:	88 10                	mov    BYTE PTR [rax],dl
     f69:	e9 98 05 00 00       	jmp    1506 <mm_protect+0x67f>
						else
								e32->d = 0;
     f6e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f72:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     f75:	83 e2 bf             	and    edx,0xffffffbf
     f78:	88 10                	mov    BYTE PTR [rax],dl
     f7a:	e9 87 05 00 00       	jmp    1506 <mm_protect+0x67f>
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
     f7f:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f82:	25 00 10 00 00       	and    eax,0x1000
     f87:	85 c0                	test   eax,eax
     f89:	75 10                	jne    f9b <mm_protect+0x114>
     f8b:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f8e:	25 00 20 00 00       	and    eax,0x2000
     f93:	85 c0                	test   eax,eax
     f95:	0f 84 eb 02 00 00    	je     1286 <mm_protect+0x3ff>
						char v = !!(flags & MMGR_MAP_SET); /* 1 or 0 */
     f9b:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     f9e:	25 00 10 00 00       	and    eax,0x1000
     fa3:	85 c0                	test   eax,eax
     fa5:	0f 95 c0             	setne  al
     fa8:	88 45 eb             	mov    BYTE PTR [rbp-0x15],al
						if (e64) {
     fab:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     fb0:	0f 84 9a 01 00 00    	je     1150 <mm_protect+0x2c9>
								if (flags & MMGR_MAP_WRITE)
     fb6:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     fb9:	83 e0 04             	and    eax,0x4
     fbc:	85 c0                	test   eax,eax
     fbe:	74 1d                	je     fdd <mm_protect+0x156>
										e64->w = v;
     fc0:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
     fc4:	83 e0 01             	and    eax,0x1
     fc7:	89 c2                	mov    edx,eax
     fc9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fcd:	83 e2 01             	and    edx,0x1
     fd0:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
     fd3:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     fd6:	83 e2 fd             	and    edx,0xfffffffd
     fd9:	09 ca                	or     edx,ecx
     fdb:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_WRITE_THROUGH)
     fdd:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
     fe0:	83 e0 10             	and    eax,0x10
     fe3:	85 c0                	test   eax,eax
     fe5:	74 21                	je     1008 <mm_protect+0x181>
										e64->wt = v;
     fe7:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
     feb:	83 e0 01             	and    eax,0x1
     fee:	89 c2                	mov    edx,eax
     ff0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ff4:	83 e2 01             	and    edx,0x1
     ff7:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
     ffe:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1001:	83 e2 f7             	and    edx,0xfffffff7
    1004:	09 ca                	or     edx,ecx
    1006:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_NO_CACHING)
    1008:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    100b:	83 e0 20             	and    eax,0x20
    100e:	85 c0                	test   eax,eax
    1010:	74 1f                	je     1031 <mm_protect+0x1aa>
										e64->cd = v;
    1012:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    1016:	83 e0 01             	and    eax,0x1
    1019:	89 c2                	mov    edx,eax
    101b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    101f:	83 e2 01             	and    edx,0x1
    1022:	89 d1                	mov    ecx,edx
    1024:	c1 e1 04             	shl    ecx,0x4
    1027:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    102a:	83 e2 ef             	and    edx,0xffffffef
    102d:	09 ca                	or     edx,ecx
    102f:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_PAT)
    1031:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1034:	25 80 00 00 00       	and    eax,0x80
    1039:	85 c0                	test   eax,eax
    103b:	0f 84 8d 00 00 00    	je     10ce <mm_protect+0x247>
										if (lv > 0)
    1041:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1044:	85 c0                	test   eax,eax
    1046:	7e 6a                	jle    10b2 <mm_protect+0x22b>
												e64->addr = (e64->addr & ~1) | v;
    1048:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    104c:	48 8b 00             	mov    rax,QWORD PTR [rax]
    104f:	48 c1 e8 0c          	shr    rax,0xc
    1053:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    105d:	48 21 d0             	and    rax,rdx
    1060:	48 ba fe ff ff ff ff 00 00 00 	movabs rdx,0xfffffffffe
    106a:	48 21 c2             	and    rdx,rax
    106d:	48 0f be 45 eb       	movsx  rax,BYTE PTR [rbp-0x15]
    1072:	48 b9 ff ff ff ff ff 00 00 00 	movabs rcx,0xffffffffff
    107c:	48 21 c8             	and    rax,rcx
    107f:	48 89 d1             	mov    rcx,rdx
    1082:	48 09 c1             	or     rcx,rax
    1085:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1089:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    1093:	48 21 ca             	and    rdx,rcx
    1096:	48 c1 e2 0c          	shl    rdx,0xc
    109a:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    109d:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    10a7:	48 21 f1             	and    rcx,rsi
    10aa:	48 09 ca             	or     rdx,rcx
    10ad:	48 89 10             	mov    QWORD PTR [rax],rdx
    10b0:	eb 1c                	jmp    10ce <mm_protect+0x247>
										else
												e64->s = v;
    10b2:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    10b6:	83 e0 01             	and    eax,0x1
    10b9:	89 c2                	mov    edx,eax
    10bb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10bf:	89 d1                	mov    ecx,edx
    10c1:	c1 e1 07             	shl    ecx,0x7
    10c4:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    10c7:	83 e2 7f             	and    edx,0x7f
    10ca:	09 ca                	or     edx,ecx
    10cc:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_GLOBAL)
    10ce:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    10d1:	83 e0 40             	and    eax,0x40
    10d4:	85 c0                	test   eax,eax
    10d6:	74 1e                	je     10f6 <mm_protect+0x26f>
										e64->g = v;
    10d8:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    10dc:	83 e0 01             	and    eax,0x1
    10df:	89 c2                	mov    edx,eax
    10e1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10e5:	89 d1                	mov    ecx,edx
    10e7:	83 e1 01             	and    ecx,0x1
    10ea:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    10ee:	83 e2 fe             	and    edx,0xfffffffe
    10f1:	09 ca                	or     edx,ecx
    10f3:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								if (flags & MMGR_MAP_KERNEL)
    10f6:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    10f9:	83 e0 08             	and    eax,0x8
    10fc:	85 c0                	test   eax,eax
    10fe:	74 1f                	je     111f <mm_protect+0x298>
										e64->u = !v;
    1100:	80 7d eb 00          	cmp    BYTE PTR [rbp-0x15],0x0
    1104:	0f 94 c2             	sete   dl
    1107:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    110b:	83 e2 01             	and    edx,0x1
    110e:	8d 0c 95 00 00 00 00 	lea    ecx,[rdx*4+0x0]
    1115:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1118:	83 e2 fb             	and    edx,0xfffffffb
    111b:	09 ca                	or     edx,ecx
    111d:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_EXECUTE)
    111f:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1122:	83 e0 02             	and    eax,0x2
    1125:	85 c0                	test   eax,eax
    1127:	0f 84 d8 03 00 00    	je     1505 <mm_protect+0x67e>
										e64->xd = v;
    112d:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    1131:	83 e0 01             	and    eax,0x1
    1134:	89 c2                	mov    edx,eax
    1136:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    113a:	89 d1                	mov    ecx,edx
    113c:	c1 e1 07             	shl    ecx,0x7
    113f:	0f b6 50 07          	movzx  edx,BYTE PTR [rax+0x7]
    1143:	83 e2 7f             	and    edx,0x7f
    1146:	09 ca                	or     edx,ecx
    1148:	88 50 07             	mov    BYTE PTR [rax+0x7],dl
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    114b:	e9 b5 03 00 00       	jmp    1505 <mm_protect+0x67e>
						} else {
								if (flags & MMGR_MAP_WRITE)
    1150:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1153:	83 e0 04             	and    eax,0x4
    1156:	85 c0                	test   eax,eax
    1158:	74 1d                	je     1177 <mm_protect+0x2f0>
										e32->w = v;
    115a:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    115e:	83 e0 01             	and    eax,0x1
    1161:	89 c2                	mov    edx,eax
    1163:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1167:	83 e2 01             	and    edx,0x1
    116a:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    116d:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1170:	83 e2 fd             	and    edx,0xfffffffd
    1173:	09 ca                	or     edx,ecx
    1175:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_WRITE_THROUGH)
    1177:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    117a:	83 e0 10             	and    eax,0x10
    117d:	85 c0                	test   eax,eax
    117f:	74 21                	je     11a2 <mm_protect+0x31b>
										e32->wt = v;
    1181:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    1185:	83 e0 01             	and    eax,0x1
    1188:	89 c2                	mov    edx,eax
    118a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    118e:	83 e2 01             	and    edx,0x1
    1191:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    1198:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    119b:	83 e2 f7             	and    edx,0xfffffff7
    119e:	09 ca                	or     edx,ecx
    11a0:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_NO_CACHING)
    11a2:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    11a5:	83 e0 20             	and    eax,0x20
    11a8:	85 c0                	test   eax,eax
    11aa:	74 1f                	je     11cb <mm_protect+0x344>
										e32->cd = v;
    11ac:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    11b0:	83 e0 01             	and    eax,0x1
    11b3:	89 c2                	mov    edx,eax
    11b5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    11b9:	83 e2 01             	and    edx,0x1
    11bc:	89 d1                	mov    ecx,edx
    11be:	c1 e1 04             	shl    ecx,0x4
    11c1:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    11c4:	83 e2 ef             	and    edx,0xffffffef
    11c7:	09 ca                	or     edx,ecx
    11c9:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_PAT)
    11cb:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    11ce:	25 80 00 00 00       	and    eax,0x80
    11d3:	85 c0                	test   eax,eax
    11d5:	74 55                	je     122c <mm_protect+0x3a5>
										if (lv > 0)
    11d7:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    11da:	85 c0                	test   eax,eax
    11dc:	7e 32                	jle    1210 <mm_protect+0x389>
												e32->addr = (e32->addr & ~1) | v;
    11de:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    11e2:	8b 00                	mov    eax,DWORD PTR [rax]
    11e4:	c1 e8 0c             	shr    eax,0xc
    11e7:	83 e0 fe             	and    eax,0xfffffffe
    11ea:	89 c2                	mov    edx,eax
    11ec:	0f be 45 eb          	movsx  eax,BYTE PTR [rbp-0x15]
    11f0:	09 d0                	or     eax,edx
    11f2:	25 ff ff 0f 00       	and    eax,0xfffff
    11f7:	89 c2                	mov    edx,eax
    11f9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    11fd:	89 d1                	mov    ecx,edx
    11ff:	c1 e1 0c             	shl    ecx,0xc
    1202:	8b 10                	mov    edx,DWORD PTR [rax]
    1204:	81 e2 ff 0f 00 00    	and    edx,0xfff
    120a:	09 ca                	or     edx,ecx
    120c:	89 10                	mov    DWORD PTR [rax],edx
    120e:	eb 1c                	jmp    122c <mm_protect+0x3a5>
										else
												e32->s = v;
    1210:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    1214:	83 e0 01             	and    eax,0x1
    1217:	89 c2                	mov    edx,eax
    1219:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    121d:	89 d1                	mov    ecx,edx
    121f:	c1 e1 07             	shl    ecx,0x7
    1222:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1225:	83 e2 7f             	and    edx,0x7f
    1228:	09 ca                	or     edx,ecx
    122a:	88 10                	mov    BYTE PTR [rax],dl
								if (flags & MMGR_MAP_GLOBAL)
    122c:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    122f:	83 e0 40             	and    eax,0x40
    1232:	85 c0                	test   eax,eax
    1234:	74 1e                	je     1254 <mm_protect+0x3cd>
										e32->g = v;
    1236:	0f b6 45 eb          	movzx  eax,BYTE PTR [rbp-0x15]
    123a:	83 e0 01             	and    eax,0x1
    123d:	89 c2                	mov    edx,eax
    123f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1243:	89 d1                	mov    ecx,edx
    1245:	83 e1 01             	and    ecx,0x1
    1248:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    124c:	83 e2 fe             	and    edx,0xfffffffe
    124f:	09 ca                	or     edx,ecx
    1251:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								if (flags & MMGR_MAP_KERNEL)
    1254:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1257:	83 e0 08             	and    eax,0x8
    125a:	85 c0                	test   eax,eax
    125c:	0f 84 a3 02 00 00    	je     1505 <mm_protect+0x67e>
										e32->u = !v;
    1262:	80 7d eb 00          	cmp    BYTE PTR [rbp-0x15],0x0
    1266:	0f 94 c2             	sete   dl
    1269:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    126d:	83 e2 01             	and    edx,0x1
    1270:	8d 0c 95 00 00 00 00 	lea    ecx,[rdx*4+0x0]
    1277:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    127a:	83 e2 fb             	and    edx,0xfffffffb
    127d:	09 ca                	or     edx,ecx
    127f:	88 10                	mov    BYTE PTR [rax],dl
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    1281:	e9 7f 02 00 00       	jmp    1505 <mm_protect+0x67e>
								//if (flags & MMGR_MAP_EXECUTE)
								//		e32->xd = v;
						}
				} else {
						if (e64) {
    1286:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    128b:	0f 84 67 01 00 00    	je     13f8 <mm_protect+0x571>
								e64->w = !!(flags & MMGR_MAP_WRITE);
    1291:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1294:	83 e0 04             	and    eax,0x4
    1297:	85 c0                	test   eax,eax
    1299:	0f 95 c2             	setne  dl
    129c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12a0:	83 e2 01             	and    edx,0x1
    12a3:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    12a6:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    12a9:	83 e2 fd             	and    edx,0xfffffffd
    12ac:	09 ca                	or     edx,ecx
    12ae:	88 10                	mov    BYTE PTR [rax],dl
								e64->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
    12b0:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    12b3:	83 e0 10             	and    eax,0x10
    12b6:	85 c0                	test   eax,eax
    12b8:	0f 95 c2             	setne  dl
    12bb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12bf:	83 e2 01             	and    edx,0x1
    12c2:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    12c9:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    12cc:	83 e2 f7             	and    edx,0xfffffff7
    12cf:	09 ca                	or     edx,ecx
    12d1:	88 10                	mov    BYTE PTR [rax],dl
								e64->cd = !!(flags & MMGR_MAP_NO_CACHING);
    12d3:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    12d6:	83 e0 20             	and    eax,0x20
    12d9:	85 c0                	test   eax,eax
    12db:	0f 95 c2             	setne  dl
    12de:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12e2:	83 e2 01             	and    edx,0x1
    12e5:	89 d1                	mov    ecx,edx
    12e7:	c1 e1 04             	shl    ecx,0x4
    12ea:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    12ed:	83 e2 ef             	and    edx,0xffffffef
    12f0:	09 ca                	or     edx,ecx
    12f2:	88 10                	mov    BYTE PTR [rax],dl
								if (lv > 0)
    12f4:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    12f7:	85 c0                	test   eax,eax
    12f9:	7e 75                	jle    1370 <mm_protect+0x4e9>
										e64->addr = (e64->addr & ~1) | !!(flags & MMGR_MAP_PAT);
    12fb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12ff:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1302:	48 c1 e8 0c          	shr    rax,0xc
    1306:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    1310:	48 21 d0             	and    rax,rdx
    1313:	48 ba fe ff ff ff ff 00 00 00 	movabs rdx,0xfffffffffe
    131d:	48 21 c2             	and    rdx,rax
    1320:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1323:	25 80 00 00 00       	and    eax,0x80
    1328:	85 c0                	test   eax,eax
    132a:	0f 95 c0             	setne  al
    132d:	0f b6 c0             	movzx  eax,al
    1330:	48 b9 ff ff ff ff ff 00 00 00 	movabs rcx,0xffffffffff
    133a:	48 21 c8             	and    rax,rcx
    133d:	48 89 d1             	mov    rcx,rdx
    1340:	48 09 c1             	or     rcx,rax
    1343:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1347:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    1351:	48 21 ca             	and    rdx,rcx
    1354:	48 c1 e2 0c          	shl    rdx,0xc
    1358:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    135b:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    1365:	48 21 f1             	and    rcx,rsi
    1368:	48 09 ca             	or     rdx,rcx
    136b:	48 89 10             	mov    QWORD PTR [rax],rdx
    136e:	eb 20                	jmp    1390 <mm_protect+0x509>
								else
										e64->s = !!(flags & MMGR_MAP_PAT);
    1370:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1373:	25 80 00 00 00       	and    eax,0x80
    1378:	85 c0                	test   eax,eax
    137a:	0f 95 c2             	setne  dl
    137d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1381:	89 d1                	mov    ecx,edx
    1383:	c1 e1 07             	shl    ecx,0x7
    1386:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1389:	83 e2 7f             	and    edx,0x7f
    138c:	09 ca                	or     edx,ecx
    138e:	88 10                	mov    BYTE PTR [rax],dl
								e64->g = !!(flags & MMGR_MAP_GLOBAL);
    1390:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1393:	83 e0 40             	and    eax,0x40
    1396:	85 c0                	test   eax,eax
    1398:	0f 95 c2             	setne  dl
    139b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    139f:	89 d1                	mov    ecx,edx
    13a1:	83 e1 01             	and    ecx,0x1
    13a4:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    13a8:	83 e2 fe             	and    edx,0xfffffffe
    13ab:	09 ca                	or     edx,ecx
    13ad:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								e64->u = !(flags & MMGR_MAP_KERNEL);
    13b0:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    13b3:	83 e0 08             	and    eax,0x8
    13b6:	85 c0                	test   eax,eax
    13b8:	0f 94 c2             	sete   dl
    13bb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13bf:	83 e2 01             	and    edx,0x1
    13c2:	8d 0c 95 00 00 00 00 	lea    ecx,[rdx*4+0x0]
    13c9:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    13cc:	83 e2 fb             	and    edx,0xfffffffb
    13cf:	09 ca                	or     edx,ecx
    13d1:	88 10                	mov    BYTE PTR [rax],dl
								e64->xd = !!(flags & MMGR_MAP_EXECUTE);
    13d3:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    13d6:	83 e0 02             	and    eax,0x2
    13d9:	85 c0                	test   eax,eax
    13db:	0f 95 c2             	setne  dl
    13de:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13e2:	89 d1                	mov    ecx,edx
    13e4:	c1 e1 07             	shl    ecx,0x7
    13e7:	0f b6 50 07          	movzx  edx,BYTE PTR [rax+0x7]
    13eb:	83 e2 7f             	and    edx,0x7f
    13ee:	09 ca                	or     edx,ecx
    13f0:	88 50 07             	mov    BYTE PTR [rax+0x7],dl
    13f3:	e9 0e 01 00 00       	jmp    1506 <mm_protect+0x67f>
						} else {
								e32->w = !!(flags & MMGR_MAP_WRITE);
    13f8:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    13fb:	83 e0 04             	and    eax,0x4
    13fe:	85 c0                	test   eax,eax
    1400:	0f 95 c2             	setne  dl
    1403:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1407:	83 e2 01             	and    edx,0x1
    140a:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    140d:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1410:	83 e2 fd             	and    edx,0xfffffffd
    1413:	09 ca                	or     edx,ecx
    1415:	88 10                	mov    BYTE PTR [rax],dl
								e32->wt = !!(flags & MMGR_MAP_WRITE_THROUGH);
    1417:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    141a:	83 e0 10             	and    eax,0x10
    141d:	85 c0                	test   eax,eax
    141f:	0f 95 c2             	setne  dl
    1422:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1426:	83 e2 01             	and    edx,0x1
    1429:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    1430:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1433:	83 e2 f7             	and    edx,0xfffffff7
    1436:	09 ca                	or     edx,ecx
    1438:	88 10                	mov    BYTE PTR [rax],dl
								e32->cd = !!(flags & MMGR_MAP_NO_CACHING);
    143a:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    143d:	83 e0 20             	and    eax,0x20
    1440:	85 c0                	test   eax,eax
    1442:	0f 95 c2             	setne  dl
    1445:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1449:	83 e2 01             	and    edx,0x1
    144c:	89 d1                	mov    ecx,edx
    144e:	c1 e1 04             	shl    ecx,0x4
    1451:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1454:	83 e2 ef             	and    edx,0xffffffef
    1457:	09 ca                	or     edx,ecx
    1459:	88 10                	mov    BYTE PTR [rax],dl
								if (lv > 0)
    145b:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    145e:	85 c0                	test   eax,eax
    1460:	7e 3e                	jle    14a0 <mm_protect+0x619>
										e32->addr = (e32->addr & ~1) | !!(flags & MMGR_MAP_PAT);
    1462:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1466:	8b 00                	mov    eax,DWORD PTR [rax]
    1468:	c1 e8 0c             	shr    eax,0xc
    146b:	83 e0 fe             	and    eax,0xfffffffe
    146e:	89 c2                	mov    edx,eax
    1470:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    1473:	25 80 00 00 00       	and    eax,0x80
    1478:	85 c0                	test   eax,eax
    147a:	0f 95 c0             	setne  al
    147d:	0f b6 c0             	movzx  eax,al
    1480:	09 d0                	or     eax,edx
    1482:	25 ff ff 0f 00       	and    eax,0xfffff
    1487:	89 c2                	mov    edx,eax
    1489:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    148d:	89 d1                	mov    ecx,edx
    148f:	c1 e1 0c             	shl    ecx,0xc
    1492:	8b 10                	mov    edx,DWORD PTR [rax]
    1494:	81 e2 ff 0f 00 00    	and    edx,0xfff
    149a:	09 ca                	or     edx,ecx
    149c:	89 10                	mov    DWORD PTR [rax],edx
    149e:	eb 20                	jmp    14c0 <mm_protect+0x639>
								else
										e32->s = !!(flags & MMGR_MAP_PAT);
    14a0:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    14a3:	25 80 00 00 00       	and    eax,0x80
    14a8:	85 c0                	test   eax,eax
    14aa:	0f 95 c2             	setne  dl
    14ad:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    14b1:	89 d1                	mov    ecx,edx
    14b3:	c1 e1 07             	shl    ecx,0x7
    14b6:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    14b9:	83 e2 7f             	and    edx,0x7f
    14bc:	09 ca                	or     edx,ecx
    14be:	88 10                	mov    BYTE PTR [rax],dl
								e32->g = !!(flags & MMGR_MAP_GLOBAL);
    14c0:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    14c3:	83 e0 40             	and    eax,0x40
    14c6:	85 c0                	test   eax,eax
    14c8:	0f 95 c2             	setne  dl
    14cb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    14cf:	89 d1                	mov    ecx,edx
    14d1:	83 e1 01             	and    ecx,0x1
    14d4:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    14d8:	83 e2 fe             	and    edx,0xfffffffe
    14db:	09 ca                	or     edx,ecx
    14dd:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								e32->u = !(flags & MMGR_MAP_KERNEL);
    14e0:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    14e3:	83 e0 08             	and    eax,0x8
    14e6:	85 c0                	test   eax,eax
    14e8:	0f 94 c2             	sete   dl
    14eb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    14ef:	83 e2 01             	and    edx,0x1
    14f2:	8d 0c 95 00 00 00 00 	lea    ecx,[rdx*4+0x0]
    14f9:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    14fc:	83 e2 fb             	and    edx,0xfffffffb
    14ff:	09 ca                	or     edx,ecx
    1501:	88 10                	mov    BYTE PTR [rax],dl
    1503:	eb 01                	jmp    1506 <mm_protect+0x67f>
				else if ((flags & MMGR_MAP_SET) || (flags & MMGR_MAP_UNSET)) {
    1505:	90                   	nop
								//e32->xd = !!(flags & MMGR_MAP_EXECUTE);
						}
				}

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
    1506:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    150a:	48 89 c7             	mov    rdi,rax
    150d:	e8 09 eb ff ff       	call   1b <flush_tlb_single>
		
				/* advance */
				if (!lv) /* regular page */
    1512:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1515:	85 c0                	test   eax,eax
    1517:	75 0a                	jne    1523 <mm_protect+0x69c>
						virt_address += 4096;
    1519:	48 81 45 b0 00 10 00 00 	add    QWORD PTR [rbp-0x50],0x1000
    1521:	eb 6a                	jmp    158d <mm_protect+0x706>
				else if (lv == 1) /* large page 2M/4M */
    1523:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1526:	83 f8 01             	cmp    eax,0x1
    1529:	75 20                	jne    154b <mm_protect+0x6c4>
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
    152b:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1532 <mm_protect+0x6ab>
    1532:	83 e0 40             	and    eax,0x40
    1535:	84 c0                	test   al,al
    1537:	74 07                	je     1540 <mm_protect+0x6b9>
    1539:	b8 00 00 80 00       	mov    eax,0x800000
    153e:	eb 05                	jmp    1545 <mm_protect+0x6be>
    1540:	b8 00 00 00 01       	mov    eax,0x1000000
    1545:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
    1549:	eb 42                	jmp    158d <mm_protect+0x706>
				else if (lv == 2) /* huge page 1G */
    154b:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    154e:	83 f8 02             	cmp    eax,0x2
    1551:	75 0a                	jne    155d <mm_protect+0x6d6>
						virt_address += 1024 * 1024 * 1024;
    1553:	48 81 45 b0 00 00 00 40 	add    QWORD PTR [rbp-0x50],0x40000000
    155b:	eb 30                	jmp    158d <mm_protect+0x706>
				else
						die("ginormous page?\n");
    155d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1564:	bf 0c 00 00 00       	mov    edi,0xc
    1569:	b8 00 00 00 00       	mov    eax,0x0
    156e:	e8 00 00 00 00       	call   1573 <mm_protect+0x6ec>
    1573:	b8 00 00 00 00       	mov    eax,0x0
    1578:	e8 00 00 00 00       	call   157d <mm_protect+0x6f6>
    157d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1584:	e8 00 00 00 00       	call   1589 <mm_protect+0x702>
    1589:	fa                   	cli
    158a:	f4                   	hlt
    158b:	eb fd                	jmp    158a <mm_protect+0x703>
		while (num_pages--) {
    158d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1591:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    1595:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
    1599:	48 85 c0             	test   rax,rax
    159c:	0f 85 01 f9 ff ff    	jne    ea3 <mm_protect+0x1c>
    15a2:	eb 01                	jmp    15a5 <mm_protect+0x71e>
						return;
    15a4:	90                   	nop
		}
}
    15a5:	c9                   	leave
    15a6:	c3                   	ret

00000000000015a7 <mm_reserve_vmem>:

void* mm_reserve_vmem(struct mm* mm, size_t pg_ct, int flags)
{
    15a7:	55                   	push   rbp
    15a8:	48 89 e5             	mov    rbp,rsp
    15ab:	48 83 ec 30          	sub    rsp,0x30
    15af:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    15b3:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    15b7:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
		void* rv = __sync_fetch_and_add(&mm->qnd_ptr, pg_ct * 4096);
    15ba:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    15be:	48 c1 e0 0c          	shl    rax,0xc
    15c2:	48 89 c2             	mov    rdx,rax
    15c5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    15c9:	48 83 c0 10          	add    rax,0x10
    15cd:	f0 48 0f c1 10       	lock xadd QWORD PTR [rax],rdx
    15d2:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
		printf("mm reserved at %x\n", rv);
    15d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15da:	48 89 c6             	mov    rsi,rax
    15dd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    15e4:	b8 00 00 00 00       	mov    eax,0x0
    15e9:	e8 00 00 00 00       	call   15ee <mm_reserve_vmem+0x47>
		if (rv + pg_ct * 4096 > VM_QND_LIMIT)
    15ee:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    15f2:	48 c1 e0 0c          	shl    rax,0xc
    15f6:	48 89 c2             	mov    rdx,rax
    15f9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15fd:	48 01 d0             	add    rax,rdx
    1600:	48 3d 00 00 00 80    	cmp    rax,0xffffffff80000000
    1606:	76 30                	jbe    1638 <mm_reserve_vmem+0x91>
				die("Out of QnD VM reservation ranges. Impelment a map!\n");
    1608:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    160f:	bf 0c 00 00 00       	mov    edi,0xc
    1614:	b8 00 00 00 00       	mov    eax,0x0
    1619:	e8 00 00 00 00       	call   161e <mm_reserve_vmem+0x77>
    161e:	b8 00 00 00 00       	mov    eax,0x0
    1623:	e8 00 00 00 00       	call   1628 <mm_reserve_vmem+0x81>
    1628:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    162f:	e8 00 00 00 00       	call   1634 <mm_reserve_vmem+0x8d>
    1634:	fa                   	cli
    1635:	f4                   	hlt
    1636:	eb fd                	jmp    1635 <mm_reserve_vmem+0x8e>
		return rv;
    1638:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
    163c:	c9                   	leave
    163d:	c3                   	ret

000000000000163e <mm_aoa_range>:

void mm_aoa_range(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
    163e:	55                   	push   rbp
    163f:	48 89 e5             	mov    rbp,rsp
    1642:	48 81 ec d0 00 00 00 	sub    rsp,0xd0
    1649:	48 89 bd 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdi
    1650:	48 89 b5 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rsi
    1657:	48 89 95 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rdx
    165e:	89 8d 44 ff ff ff    	mov    DWORD PTR [rbp-0xbc],ecx
		int x = flags & MMGR_MAP_EXECUTE, w = flags & MMGR_MAP_WRITE,
    1664:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    166a:	83 e0 02             	and    eax,0x2
    166d:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
    1670:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    1676:	83 e0 04             	and    eax,0x4
    1679:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
			wc = flags & MMGR_MAP_PAT, wt = flags & MMGR_MAP_WRITE_THROUGH,
    167c:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    1682:	25 80 00 00 00       	and    eax,0x80
    1687:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
    168a:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    1690:	83 e0 10             	and    eax,0x10
    1693:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
			cd = flags & MMGR_MAP_NO_CACHING, g = flags & MMGR_MAP_GLOBAL,
    1696:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    169c:	83 e0 20             	and    eax,0x20
    169f:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
    16a2:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    16a8:	83 e0 40             	and    eax,0x40
    16ab:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
			u = !(flags & MMGR_MAP_KERNEL);
    16ae:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    16b4:	83 e0 08             	and    eax,0x8
    16b7:	85 c0                	test   eax,eax
    16b9:	0f 94 c0             	sete   al
    16bc:	0f b6 c0             	movzx  eax,al
    16bf:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
		int avl = MMGR_AVL_AOA, lvl; uint32_t ofs;
    16c2:	c7 45 c8 04 00 00 00 	mov    DWORD PTR [rbp-0x38],0x4
		void *p, *e, **cntr, **cntrm; /* page walk: cntr (last one), cntrm (missing)*/

		while (pg_ct) {
    16c9:	e9 11 05 00 00       	jmp    1bdf <mm_aoa_range+0x5a1>
redo:
				if (!mm_page_walk(mm, virt_address, &p, &e, &lvl,
    16ce:	4c 8d 4d a8          	lea    r9,[rbp-0x58]
    16d2:	4c 8d 45 ac          	lea    r8,[rbp-0x54]
    16d6:	48 8d 4d 98          	lea    rcx,[rbp-0x68]
    16da:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
    16de:	48 8b b5 50 ff ff ff 	mov    rsi,QWORD PTR [rbp-0xb0]
    16e5:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    16ec:	48 8d 7d 88          	lea    rdi,[rbp-0x78]
    16f0:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
    16f5:	48 8d 7d 90          	lea    rdi,[rbp-0x70]
    16f9:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    16fd:	48 89 c7             	mov    rdi,rax
    1700:	e8 00 00 00 00       	call   1705 <mm_aoa_range+0xc7>
    1705:	85 c0                	test   eax,eax
    1707:	75 37                	jne    1740 <mm_aoa_range+0x102>
										&ofs, &cntr, &cntrm)) {
						/* present entry! */
present:
    1709:	90                   	nop
    170a:	eb 04                	jmp    1710 <mm_aoa_range+0xd2>
				if (!cpu.has_pae) {
						struct pte32* pte = e;
						while (ofs < 1024) {
								/* check for present */
								if (pte->p)
										goto present;
    170c:	90                   	nop
    170d:	eb 01                	jmp    1710 <mm_aoa_range+0xd2>
				} else {
						struct pte64* pte = e;
						while (ofs < 512) {
								/* check for present */
								if (pte->p)
										goto present;
    170f:	90                   	nop
						die("encountered present entry while AOA alloc\n");
    1710:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1717:	bf 0c 00 00 00       	mov    edi,0xc
    171c:	b8 00 00 00 00       	mov    eax,0x0
    1721:	e8 00 00 00 00       	call   1726 <mm_aoa_range+0xe8>
    1726:	b8 00 00 00 00       	mov    eax,0x0
    172b:	e8 00 00 00 00       	call   1730 <mm_aoa_range+0xf2>
    1730:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1737:	e8 00 00 00 00       	call   173c <mm_aoa_range+0xfe>
    173c:	fa                   	cli
    173d:	f4                   	hlt
    173e:	eb fd                	jmp    173d <mm_aoa_range+0xff>
				if (lvl > 0) {
    1740:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    1743:	85 c0                	test   eax,eax
    1745:	0f 8e 9f 01 00 00    	jle    18ea <mm_aoa_range+0x2ac>
						if (ENTER_CS_PTE(cntr[ofs])) {
    174b:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    174f:	8b 55 a8             	mov    edx,DWORD PTR [rbp-0x58]
    1752:	89 d2                	mov    edx,edx
    1754:	48 c1 e2 03          	shl    rdx,0x3
    1758:	48 01 c2             	add    rdx,rax
    175b:	b8 00 00 00 00       	mov    eax,0x0
    1760:	48 c7 c1 ff ff ff ff 	mov    rcx,0xffffffffffffffff
    1767:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
    176c:	0f 94 c0             	sete   al
    176f:	84 c0                	test   al,al
    1771:	0f 84 55 01 00 00    	je     18cc <mm_aoa_range+0x28e>
								struct pte64* p = e;
    1777:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    177b:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
								ptr = mm_alloc_page(&b);
    177f:	48 8d 45 80          	lea    rax,[rbp-0x80]
    1783:	48 89 c7             	mov    rdi,rax
    1786:	e8 00 00 00 00       	call   178b <mm_aoa_range+0x14d>
    178b:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
								p->addr = b / 4096;
    178f:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1793:	48 c1 e8 0c          	shr    rax,0xc
    1797:	48 89 c2             	mov    rdx,rax
    179a:	48 b8 ff ff ff ff ff 00 00 00 	movabs rax,0xffffffffff
    17a4:	48 89 d1             	mov    rcx,rdx
    17a7:	48 21 c1             	and    rcx,rax
    17aa:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    17ae:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    17b8:	48 21 ca             	and    rdx,rcx
    17bb:	48 c1 e2 0c          	shl    rdx,0xc
    17bf:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    17c2:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    17cc:	48 21 f1             	and    rcx,rsi
    17cf:	48 09 ca             	or     rdx,rcx
    17d2:	48 89 10             	mov    QWORD PTR [rax],rdx
								p->u = 1;
    17d5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    17d9:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    17dc:	83 ca 04             	or     edx,0x4
    17df:	88 10                	mov    BYTE PTR [rax],dl
								p->w = 1;
    17e1:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    17e5:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    17e8:	83 ca 02             	or     edx,0x2
    17eb:	88 10                	mov    BYTE PTR [rax],dl
								p->p = 1;
    17ed:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    17f1:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    17f4:	83 ca 01             	or     edx,0x1
    17f7:	88 10                	mov    BYTE PTR [rax],dl
								if (cntrm) {
    17f9:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    17fd:	48 85 c0             	test   rax,rax
    1800:	0f 84 aa 00 00 00    	je     18b0 <mm_aoa_range+0x272>
										if (lvl == 3) {
    1806:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    1809:	83 f8 03             	cmp    eax,0x3
    180c:	75 7b                	jne    1889 <mm_aoa_range+0x24b>
												struct vm_pg_ptrs64* vp = mm_kernel.ctx;
    180e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1815 <mm_aoa_range+0x1d7>
    1815:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
												mm_alloc_pm(2, pr2, 2);
    1819:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    1820:	ba 02 00 00 00       	mov    edx,0x2
    1825:	48 89 c6             	mov    rsi,rax
    1828:	bf 02 00 00 00       	mov    edi,0x2
    182d:	e8 00 00 00 00       	call   1832 <mm_aoa_range+0x1f4>
												map = __sync_fetch_and_sub(&vp->cur, 8192) - 8192;
    1832:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1836:	ba 00 20 00 00       	mov    edx,0x2000
    183b:	48 f7 da             	neg    rdx
    183e:	f0 48 0f c1 10       	lock xadd QWORD PTR [rax],rdx
    1843:	48 8d 82 00 e0 ff ff 	lea    rax,[rdx-0x2000]
    184a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
												mm_map(&mm_kernel, map, pr2, pr2[0].count > 1 ? 1 : 2,
    184e:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1855:	48 83 f8 01          	cmp    rax,0x1
    1859:	76 07                	jbe    1862 <mm_aoa_range+0x224>
    185b:	b9 01 00 00 00       	mov    ecx,0x1
    1860:	eb 05                	jmp    1867 <mm_aoa_range+0x229>
    1862:	b9 02 00 00 00       	mov    ecx,0x2
    1867:	48 8d 95 60 ff ff ff 	lea    rdx,[rbp-0xa0]
    186e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1872:	41 b8 0c 00 00 00    	mov    r8d,0xc
    1878:	48 89 c6             	mov    rsi,rax
    187b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1882:	e8 00 00 00 00       	call   1887 <mm_aoa_range+0x249>
    1887:	eb 10                	jmp    1899 <mm_aoa_range+0x25b>
												map = mm_alloc_page(&b);
    1889:	48 8d 45 80          	lea    rax,[rbp-0x80]
    188d:	48 89 c7             	mov    rdi,rax
    1890:	e8 00 00 00 00       	call   1895 <mm_aoa_range+0x257>
    1895:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
										cntrm[ofs] = map;
    1899:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    189d:	8b 55 a8             	mov    edx,DWORD PTR [rbp-0x58]
    18a0:	89 d2                	mov    edx,edx
    18a2:	48 c1 e2 03          	shl    rdx,0x3
    18a6:	48 01 c2             	add    rdx,rax
    18a9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    18ad:	48 89 02             	mov    QWORD PTR [rdx],rax
								cntr[ofs] = ptr;
    18b0:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    18b4:	8b 55 a8             	mov    edx,DWORD PTR [rbp-0x58]
    18b7:	89 d2                	mov    edx,edx
    18b9:	48 c1 e2 03          	shl    rdx,0x3
    18bd:	48 01 c2             	add    rdx,rax
    18c0:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    18c4:	48 89 02             	mov    QWORD PTR [rdx],rax
    18c7:	e9 02 fe ff ff       	jmp    16ce <mm_aoa_range+0x90>
								SPIN_CS(cntr[ofs]);
    18cc:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    18d0:	8b 55 a8             	mov    edx,DWORD PTR [rbp-0x58]
    18d3:	89 d2                	mov    edx,edx
    18d5:	48 c1 e2 03          	shl    rdx,0x3
    18d9:	48 01 d0             	add    rax,rdx
    18dc:	48 8b 00             	mov    rax,QWORD PTR [rax]
    18df:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
    18e3:	74 e7                	je     18cc <mm_aoa_range+0x28e>
    18e5:	e9 e4 fd ff ff       	jmp    16ce <mm_aoa_range+0x90>
				if (!cpu.has_pae) {
    18ea:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 18f1 <mm_aoa_range+0x2b3>
    18f1:	83 e0 40             	and    eax,0x40
    18f4:	84 c0                	test   al,al
    18f6:	0f 85 46 01 00 00    	jne    1a42 <mm_aoa_range+0x404>
						struct pte32* pte = e;
    18fc:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1900:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						while (ofs < 1024) {
    1904:	e9 26 01 00 00       	jmp    1a2f <mm_aoa_range+0x3f1>
								if (pte->p)
    1909:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    190d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1910:	83 e0 01             	and    eax,0x1
    1913:	84 c0                	test   al,al
    1915:	0f 85 f1 fd ff ff    	jne    170c <mm_aoa_range+0xce>
								pte->addr = pm_zero / 4096; /* cautonary */
    191b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1922 <mm_aoa_range+0x2e4>
    1922:	48 c1 e8 0c          	shr    rax,0xc
    1926:	25 ff ff 0f 00       	and    eax,0xfffff
    192b:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    192f:	c1 e0 0c             	shl    eax,0xc
    1932:	89 c1                	mov    ecx,eax
    1934:	8b 02                	mov    eax,DWORD PTR [rdx]
    1936:	25 ff 0f 00 00       	and    eax,0xfff
    193b:	09 c8                	or     eax,ecx
    193d:	89 02                	mov    DWORD PTR [rdx],eax
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
    193f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1943:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1946:	83 ca 04             	or     edx,0x4
    1949:	88 10                	mov    BYTE PTR [rax],dl
								pte->w = (w ? 1 : 0);
    194b:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    194f:	0f 95 c2             	setne  dl
    1952:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1956:	83 e2 01             	and    edx,0x1
    1959:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    195c:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    195f:	83 e2 fd             	and    edx,0xfffffffd
    1962:	09 ca                	or     edx,ecx
    1964:	88 10                	mov    BYTE PTR [rax],dl
								pte->p = 0; /* that's the point of allocate-on-access */
    1966:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    196a:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    196d:	83 e2 fe             	and    edx,0xfffffffe
    1970:	88 10                	mov    BYTE PTR [rax],dl
								pte->s = (wc ? 1 : 0); /* PAT bit */
    1972:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    1976:	0f 95 c2             	setne  dl
    1979:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    197d:	89 d1                	mov    ecx,edx
    197f:	c1 e1 07             	shl    ecx,0x7
    1982:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1985:	83 e2 7f             	and    edx,0x7f
    1988:	09 ca                	or     edx,ecx
    198a:	88 10                	mov    BYTE PTR [rax],dl
								pte->wt = (wt ? 1 : 0);
    198c:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    1990:	0f 95 c2             	setne  dl
    1993:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1997:	83 e2 01             	and    edx,0x1
    199a:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    19a1:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    19a4:	83 e2 f7             	and    edx,0xfffffff7
    19a7:	09 ca                	or     edx,ecx
    19a9:	88 10                	mov    BYTE PTR [rax],dl
								pte->cd = (cd ? 1 : 0);
    19ab:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    19af:	0f 95 c2             	setne  dl
    19b2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    19b6:	83 e2 01             	and    edx,0x1
    19b9:	89 d1                	mov    ecx,edx
    19bb:	c1 e1 04             	shl    ecx,0x4
    19be:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    19c1:	83 e2 ef             	and    edx,0xffffffef
    19c4:	09 ca                	or     edx,ecx
    19c6:	88 10                	mov    BYTE PTR [rax],dl
								pte->g = (g ? 1 : 0);
    19c8:	83 7d d0 00          	cmp    DWORD PTR [rbp-0x30],0x0
    19cc:	0f 95 c2             	setne  dl
    19cf:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    19d3:	89 d1                	mov    ecx,edx
    19d5:	83 e1 01             	and    ecx,0x1
    19d8:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    19dc:	83 e2 fe             	and    edx,0xfffffffe
    19df:	09 ca                	or     edx,ecx
    19e1:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								pte->ign = avl & 7;
    19e4:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    19e7:	83 e0 07             	and    eax,0x7
    19ea:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    19ee:	83 e0 07             	and    eax,0x7
    19f1:	8d 0c 00             	lea    ecx,[rax+rax*1]
    19f4:	0f b6 42 01          	movzx  eax,BYTE PTR [rdx+0x1]
    19f8:	83 e0 f1             	and    eax,0xfffffff1
    19fb:	09 c8                	or     eax,ecx
    19fd:	88 42 01             	mov    BYTE PTR [rdx+0x1],al
								pte++; ofs++; pg_ct--;
    1a00:	48 83 45 f0 04       	add    QWORD PTR [rbp-0x10],0x4
    1a05:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1a08:	83 c0 01             	add    eax,0x1
    1a0b:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
    1a0e:	48 83 ad 48 ff ff ff 01 	sub    QWORD PTR [rbp-0xb8],0x1
								virt_address += 4096;
    1a16:	48 81 85 50 ff ff ff 00 10 00 00 	add    QWORD PTR [rbp-0xb0],0x1000
								if (!pg_ct) /* exit if done */
    1a21:	48 83 bd 48 ff ff ff 00 	cmp    QWORD PTR [rbp-0xb8],0x0
    1a29:	0f 84 c0 01 00 00    	je     1bef <mm_aoa_range+0x5b1>
						while (ofs < 1024) {
    1a2f:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1a32:	3d ff 03 00 00       	cmp    eax,0x3ff
    1a37:	0f 86 cc fe ff ff    	jbe    1909 <mm_aoa_range+0x2cb>
    1a3d:	e9 9d 01 00 00       	jmp    1bdf <mm_aoa_range+0x5a1>
						struct pte64* pte = e;
    1a42:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1a46:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						while (ofs < 512) {
    1a4a:	e9 82 01 00 00       	jmp    1bd1 <mm_aoa_range+0x593>
								if (pte->p)
    1a4f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a53:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a56:	83 e0 01             	and    eax,0x1
    1a59:	84 c0                	test   al,al
    1a5b:	0f 85 ae fc ff ff    	jne    170f <mm_aoa_range+0xd1>

								/* set the flags */
								pte->addr = pm_zero / 4096; /* cautonary */
    1a61:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1a68 <mm_aoa_range+0x42a>
    1a68:	48 c1 e8 0c          	shr    rax,0xc
    1a6c:	48 89 c2             	mov    rdx,rax
    1a6f:	48 b8 ff ff ff ff ff 00 00 00 	movabs rax,0xffffffffff
    1a79:	48 89 d1             	mov    rcx,rdx
    1a7c:	48 21 c1             	and    rcx,rax
    1a7f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a83:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    1a8d:	48 21 ca             	and    rdx,rcx
    1a90:	48 c1 e2 0c          	shl    rdx,0xc
    1a94:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1a97:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    1aa1:	48 21 f1             	and    rcx,rsi
    1aa4:	48 09 ca             	or     rdx,rcx
    1aa7:	48 89 10             	mov    QWORD PTR [rax],rdx
								pte->u = 1; /* FIXME: for now (u ? 1 : 0) */
    1aaa:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1aae:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1ab1:	83 ca 04             	or     edx,0x4
    1ab4:	88 10                	mov    BYTE PTR [rax],dl
								pte->w = (w ? 1 : 0);
    1ab6:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    1aba:	0f 95 c2             	setne  dl
    1abd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ac1:	83 e2 01             	and    edx,0x1
    1ac4:	8d 0c 12             	lea    ecx,[rdx+rdx*1]
    1ac7:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1aca:	83 e2 fd             	and    edx,0xfffffffd
    1acd:	09 ca                	or     edx,ecx
    1acf:	88 10                	mov    BYTE PTR [rax],dl
								pte->p = 0; /* that's the point of allocate-on-access */
    1ad1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ad5:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1ad8:	83 e2 fe             	and    edx,0xfffffffe
    1adb:	88 10                	mov    BYTE PTR [rax],dl
								pte->s = (wc ? 1 : 0); /* PAT bit */
    1add:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    1ae1:	0f 95 c2             	setne  dl
    1ae4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ae8:	89 d1                	mov    ecx,edx
    1aea:	c1 e1 07             	shl    ecx,0x7
    1aed:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1af0:	83 e2 7f             	and    edx,0x7f
    1af3:	09 ca                	or     edx,ecx
    1af5:	88 10                	mov    BYTE PTR [rax],dl
								pte->wt = (wt ? 1 : 0);
    1af7:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    1afb:	0f 95 c2             	setne  dl
    1afe:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b02:	83 e2 01             	and    edx,0x1
    1b05:	8d 0c d5 00 00 00 00 	lea    ecx,[rdx*8+0x0]
    1b0c:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1b0f:	83 e2 f7             	and    edx,0xfffffff7
    1b12:	09 ca                	or     edx,ecx
    1b14:	88 10                	mov    BYTE PTR [rax],dl
								pte->cd = (cd ? 1 : 0);
    1b16:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    1b1a:	0f 95 c2             	setne  dl
    1b1d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b21:	83 e2 01             	and    edx,0x1
    1b24:	89 d1                	mov    ecx,edx
    1b26:	c1 e1 04             	shl    ecx,0x4
    1b29:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1b2c:	83 e2 ef             	and    edx,0xffffffef
    1b2f:	09 ca                	or     edx,ecx
    1b31:	88 10                	mov    BYTE PTR [rax],dl
								pte->g = (g ? 1 : 0);
    1b33:	83 7d d0 00          	cmp    DWORD PTR [rbp-0x30],0x0
    1b37:	0f 95 c2             	setne  dl
    1b3a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b3e:	89 d1                	mov    ecx,edx
    1b40:	83 e1 01             	and    ecx,0x1
    1b43:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
    1b47:	83 e2 fe             	and    edx,0xfffffffe
    1b4a:	09 ca                	or     edx,ecx
    1b4c:	88 50 01             	mov    BYTE PTR [rax+0x1],dl
								if (cpu.e_has_nx)
    1b4f:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1b56 <mm_aoa_range+0x518>
    1b56:	83 e0 10             	and    eax,0x10
    1b59:	84 c0                	test   al,al
    1b5b:	74 1c                	je     1b79 <mm_aoa_range+0x53b>
										pte->xd = (x ? 0 : 1);
    1b5d:	83 7d e4 00          	cmp    DWORD PTR [rbp-0x1c],0x0
    1b61:	0f 94 c2             	sete   dl
    1b64:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b68:	89 d1                	mov    ecx,edx
    1b6a:	c1 e1 07             	shl    ecx,0x7
    1b6d:	0f b6 50 07          	movzx  edx,BYTE PTR [rax+0x7]
    1b71:	83 e2 7f             	and    edx,0x7f
    1b74:	09 ca                	or     edx,ecx
    1b76:	88 50 07             	mov    BYTE PTR [rax+0x7],dl
								pte->ign = avl & 7;
    1b79:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    1b7c:	83 e0 07             	and    eax,0x7
    1b7f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1b83:	83 e0 07             	and    eax,0x7
    1b86:	8d 0c 00             	lea    ecx,[rax+rax*1]
    1b89:	0f b6 42 01          	movzx  eax,BYTE PTR [rdx+0x1]
    1b8d:	83 e0 f1             	and    eax,0xfffffff1
    1b90:	09 c8                	or     eax,ecx
    1b92:	88 42 01             	mov    BYTE PTR [rdx+0x1],al
								pte->ign2 = 0;
    1b95:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1b99:	0f b7 50 06          	movzx  edx,WORD PTR [rax+0x6]
    1b9d:	66 81 e2 0f 80       	and    dx,0x800f
    1ba2:	66 89 50 06          	mov    WORD PTR [rax+0x6],dx
								/* advance */
								pte++; ofs++; pg_ct--;
    1ba6:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
    1bab:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1bae:	83 c0 01             	add    eax,0x1
    1bb1:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
    1bb4:	48 83 ad 48 ff ff ff 01 	sub    QWORD PTR [rbp-0xb8],0x1
								virt_address += 4096;
    1bbc:	48 81 85 50 ff ff ff 00 10 00 00 	add    QWORD PTR [rbp-0xb0],0x1000
								if (!pg_ct) /* exit if done */
    1bc7:	48 83 bd 48 ff ff ff 00 	cmp    QWORD PTR [rbp-0xb8],0x0
    1bcf:	74 21                	je     1bf2 <mm_aoa_range+0x5b4>
						while (ofs < 512) {
    1bd1:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    1bd4:	3d ff 01 00 00       	cmp    eax,0x1ff
    1bd9:	0f 86 70 fe ff ff    	jbe    1a4f <mm_aoa_range+0x411>
		while (pg_ct) {
    1bdf:	48 83 bd 48 ff ff ff 00 	cmp    QWORD PTR [rbp-0xb8],0x0
    1be7:	74 0a                	je     1bf3 <mm_aoa_range+0x5b5>
redo:
    1be9:	90                   	nop
    1bea:	e9 df fa ff ff       	jmp    16ce <mm_aoa_range+0x90>
										return;
    1bef:	90                   	nop
    1bf0:	eb 01                	jmp    1bf3 <mm_aoa_range+0x5b5>
										return;
    1bf2:	90                   	nop
						}
				}
		}
}
    1bf3:	c9                   	leave
    1bf4:	c3                   	ret

0000000000001bf5 <mm_unmap>:

void mm_unmap(struct mm* mm, void* virt_address, size_t pg_ct)
{
    1bf5:	55                   	push   rbp
    1bf6:	48 89 e5             	mov    rbp,rsp
    1bf9:	48 83 ec 70          	sub    rsp,0x70
    1bfd:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    1c01:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
    1c05:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
		int rv, lv, of; void *p, *e, **cnt, **cntm;
		struct pte64* e64; struct pte32* e32;

		while (pg_ct--) {
    1c09:	e9 20 01 00 00       	jmp    1d2e <mm_unmap+0x139>
#ifdef __x86_64__
				rv = mm_page_walk64(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
    1c0e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1c12:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1c16:	4c 8d 4d e4          	lea    r9,[rbp-0x1c]
    1c1a:	4c 8d 45 e8          	lea    r8,[rbp-0x18]
    1c1e:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
    1c22:	48 8d 55 d8          	lea    rdx,[rbp-0x28]
    1c26:	48 8b 75 b0          	mov    rsi,QWORD PTR [rbp-0x50]
    1c2a:	48 8d 7d c0          	lea    rdi,[rbp-0x40]
    1c2e:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
    1c33:	48 8d 7d c8          	lea    rdi,[rbp-0x38]
    1c37:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    1c3b:	48 89 c7             	mov    rdi,rax
    1c3e:	e8 00 00 00 00       	call   1c43 <mm_unmap+0x4e>
    1c43:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
						rv = mm_page_walk36(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
				else
						rv = mm_page_walk32(mm->ctx, virt_address, &p, &e, &lv, &of, &cnt, &cntm);
#endif
		
				if (rv != 0) /* not mapped (TODO: check AOA and the like) */
    1c46:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    1c4a:	75 66                	jne    1cb2 <mm_unmap+0xbd>
						goto advance;

				e32 = NULL; e64 = NULL;
    1c4c:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1c54:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (!cpu.has_pae)
    1c5c:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1c63 <mm_unmap+0x6e>
    1c63:	83 e0 40             	and    eax,0x40
    1c66:	84 c0                	test   al,al
    1c68:	75 0a                	jne    1c74 <mm_unmap+0x7f>
						e32 = e;
    1c6a:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1c6e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    1c72:	eb 08                	jmp    1c7c <mm_unmap+0x87>
				else
						e64 = e;
    1c74:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1c78:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		
				/* make not present (TODO: clear as in free_vmem?) */
				if (!cpu.has_pae)
    1c7c:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1c83 <mm_unmap+0x8e>
    1c83:	83 e0 40             	and    eax,0x40
    1c86:	84 c0                	test   al,al
    1c88:	75 0e                	jne    1c98 <mm_unmap+0xa3>
						e32->p = 0;
    1c8a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1c8e:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1c91:	83 e2 fe             	and    edx,0xfffffffe
    1c94:	88 10                	mov    BYTE PTR [rax],dl
    1c96:	eb 0c                	jmp    1ca4 <mm_unmap+0xaf>
				else
						e64->p = 0;
    1c98:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1c9c:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1c9f:	83 e2 fe             	and    edx,0xfffffffe
    1ca2:	88 10                	mov    BYTE PTR [rax],dl

				/* flush TLB (TODO: and post shootdown) */
				flush_tlb_single(virt_address);
    1ca4:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1ca8:	48 89 c7             	mov    rdi,rax
    1cab:	e8 6b e3 ff ff       	call   1b <flush_tlb_single>
    1cb0:	eb 01                	jmp    1cb3 <mm_unmap+0xbe>
						goto advance;
    1cb2:	90                   	nop
		
				/* advance */
advance:
				if (!lv) /* regular page */
    1cb3:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1cb6:	85 c0                	test   eax,eax
    1cb8:	75 0a                	jne    1cc4 <mm_unmap+0xcf>
						virt_address += 4096;
    1cba:	48 81 45 b0 00 10 00 00 	add    QWORD PTR [rbp-0x50],0x1000
    1cc2:	eb 6a                	jmp    1d2e <mm_unmap+0x139>
				else if (lv == 1) /* large page 2M/4M */
    1cc4:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1cc7:	83 f8 01             	cmp    eax,0x1
    1cca:	75 20                	jne    1cec <mm_unmap+0xf7>
						virt_address += 4096 * 2048 * (cpu.has_pae ? 1 : 2);
    1ccc:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1cd3 <mm_unmap+0xde>
    1cd3:	83 e0 40             	and    eax,0x40
    1cd6:	84 c0                	test   al,al
    1cd8:	74 07                	je     1ce1 <mm_unmap+0xec>
    1cda:	b8 00 00 80 00       	mov    eax,0x800000
    1cdf:	eb 05                	jmp    1ce6 <mm_unmap+0xf1>
    1ce1:	b8 00 00 00 01       	mov    eax,0x1000000
    1ce6:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
    1cea:	eb 42                	jmp    1d2e <mm_unmap+0x139>
				else if (lv == 2) /* huge page 1G */
    1cec:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1cef:	83 f8 02             	cmp    eax,0x2
    1cf2:	75 0a                	jne    1cfe <mm_unmap+0x109>
						virt_address += 1024 * 1024 * 1024;
    1cf4:	48 81 45 b0 00 00 00 40 	add    QWORD PTR [rbp-0x50],0x40000000
    1cfc:	eb 30                	jmp    1d2e <mm_unmap+0x139>
				else
						die("ginormous page?\n");
    1cfe:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1d05:	bf 0c 00 00 00       	mov    edi,0xc
    1d0a:	b8 00 00 00 00       	mov    eax,0x0
    1d0f:	e8 00 00 00 00       	call   1d14 <mm_unmap+0x11f>
    1d14:	b8 00 00 00 00       	mov    eax,0x0
    1d19:	e8 00 00 00 00       	call   1d1e <mm_unmap+0x129>
    1d1e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d25:	e8 00 00 00 00       	call   1d2a <mm_unmap+0x135>
    1d2a:	fa                   	cli
    1d2b:	f4                   	hlt
    1d2c:	eb fd                	jmp    1d2b <mm_unmap+0x136>
		while (pg_ct--) {
    1d2e:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1d32:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    1d36:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
    1d3a:	48 85 c0             	test   rax,rax
    1d3d:	0f 85 cb fe ff ff    	jne    1c0e <mm_unmap+0x19>
		}
}
    1d43:	90                   	nop
    1d44:	90                   	nop
    1d45:	c9                   	leave
    1d46:	c3                   	ret

0000000000001d47 <mm_alloc_vmem>:

void* mm_alloc_vmem(struct mm* mm, void* virt_address, size_t pg_ct, int flags)
{
    1d47:	55                   	push   rbp
    1d48:	48 89 e5             	mov    rbp,rsp
    1d4b:	48 81 ec 80 01 00 00 	sub    rsp,0x180
    1d52:	48 89 bd 98 fe ff ff 	mov    QWORD PTR [rbp-0x168],rdi
    1d59:	48 89 b5 90 fe ff ff 	mov    QWORD PTR [rbp-0x170],rsi
    1d60:	48 89 95 88 fe ff ff 	mov    QWORD PTR [rbp-0x178],rdx
    1d67:	89 8d 84 fe ff ff    	mov    DWORD PTR [rbp-0x17c],ecx
		if (!virt_address)
    1d6d:	48 83 bd 90 fe ff ff 00 	cmp    QWORD PTR [rbp-0x170],0x0
    1d75:	75 26                	jne    1d9d <mm_alloc_vmem+0x56>
				virt_address = mm_reserve_vmem(mm, pg_ct, flags);
    1d77:	8b 95 84 fe ff ff    	mov    edx,DWORD PTR [rbp-0x17c]
    1d7d:	48 8b 8d 88 fe ff ff 	mov    rcx,QWORD PTR [rbp-0x178]
    1d84:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1d8b:	48 89 ce             	mov    rsi,rcx
    1d8e:	48 89 c7             	mov    rdi,rax
    1d91:	e8 00 00 00 00       	call   1d96 <mm_alloc_vmem+0x4f>
    1d96:	48 89 85 90 fe ff ff 	mov    QWORD PTR [rbp-0x170],rax

		if ((flags & MMGR_ALLOC_CONTIGUOUS) == MMGR_ALLOC_CONTIGUOUS) {
    1d9d:	8b 85 84 fe ff ff    	mov    eax,DWORD PTR [rbp-0x17c]
    1da3:	25 00 00 03 00       	and    eax,0x30000
    1da8:	3d 00 00 03 00       	cmp    eax,0x30000
    1dad:	0f 85 8c 00 00 00    	jne    1e3f <mm_alloc_vmem+0xf8>
				struct page_range pr; size_t ct;
				/* FIXME: Implement cont. allocator for PMEM */
				ct = mm_alloc_pm(pg_ct, &pr, 1);
    1db3:	48 8b 85 88 fe ff ff 	mov    rax,QWORD PTR [rbp-0x178]
    1dba:	89 c1                	mov    ecx,eax
    1dbc:	48 8d 45 b8          	lea    rax,[rbp-0x48]
    1dc0:	ba 01 00 00 00       	mov    edx,0x1
    1dc5:	48 89 c6             	mov    rsi,rax
    1dc8:	89 cf                	mov    edi,ecx
    1dca:	e8 00 00 00 00       	call   1dcf <mm_alloc_vmem+0x88>
    1dcf:	89 c0                	mov    eax,eax
    1dd1:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				if (ct < pg_ct) {
    1dd5:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1dd9:	48 3b 85 88 fe ff ff 	cmp    rax,QWORD PTR [rbp-0x178]
    1de0:	73 30                	jae    1e12 <mm_alloc_vmem+0xcb>
						die("Contiguous allocation failed\n");
    1de2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1de9:	bf 0c 00 00 00       	mov    edi,0xc
    1dee:	b8 00 00 00 00       	mov    eax,0x0
    1df3:	e8 00 00 00 00       	call   1df8 <mm_alloc_vmem+0xb1>
    1df8:	b8 00 00 00 00       	mov    eax,0x0
    1dfd:	e8 00 00 00 00       	call   1e02 <mm_alloc_vmem+0xbb>
    1e02:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e09:	e8 00 00 00 00       	call   1e0e <mm_alloc_vmem+0xc7>
    1e0e:	fa                   	cli
    1e0f:	f4                   	hlt
    1e10:	eb fd                	jmp    1e0f <mm_alloc_vmem+0xc8>
				}
				return mm_map(mm, virt_address, &pr, 1, flags);
    1e12:	8b 8d 84 fe ff ff    	mov    ecx,DWORD PTR [rbp-0x17c]
    1e18:	48 8d 55 b8          	lea    rdx,[rbp-0x48]
    1e1c:	48 8b b5 90 fe ff ff 	mov    rsi,QWORD PTR [rbp-0x170]
    1e23:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1e2a:	41 89 c8             	mov    r8d,ecx
    1e2d:	b9 01 00 00 00       	mov    ecx,0x1
    1e32:	48 89 c7             	mov    rdi,rax
    1e35:	e8 00 00 00 00       	call   1e3a <mm_alloc_vmem+0xf3>
    1e3a:	e9 7c 01 00 00       	jmp    1fbb <mm_alloc_vmem+0x274>
		} else if ((flags & MMGR_ALLOC_ZERO_COW) == MMGR_ALLOC_ZERO_COW) {
    1e3f:	8b 85 84 fe ff ff    	mov    eax,DWORD PTR [rbp-0x17c]
    1e45:	25 00 00 01 00       	and    eax,0x10000
    1e4a:	85 c0                	test   eax,eax
    1e4c:	74 6b                	je     1eb9 <mm_alloc_vmem+0x172>
				void* rv = virt_address;
    1e4e:	48 8b 85 90 fe ff ff 	mov    rax,QWORD PTR [rbp-0x170]
    1e55:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				struct page_range pr = { pm_zero, 1 };
    1e59:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1e60 <mm_alloc_vmem+0x119>
    1e60:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
    1e64:	48 c7 45 b0 01 00 00 00 	mov    QWORD PTR [rbp-0x50],0x1
				while (pg_ct) {
    1e6c:	eb 38                	jmp    1ea6 <mm_alloc_vmem+0x15f>
						mm_map(mm, virt_address, &pr, 1, flags | MMGR_MAP_COW);
    1e6e:	8b 85 84 fe ff ff    	mov    eax,DWORD PTR [rbp-0x17c]
    1e74:	80 cc 02             	or     ah,0x2
    1e77:	89 c1                	mov    ecx,eax
    1e79:	48 8d 55 a8          	lea    rdx,[rbp-0x58]
    1e7d:	48 8b b5 90 fe ff ff 	mov    rsi,QWORD PTR [rbp-0x170]
    1e84:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1e8b:	41 89 c8             	mov    r8d,ecx
    1e8e:	b9 01 00 00 00       	mov    ecx,0x1
    1e93:	48 89 c7             	mov    rdi,rax
    1e96:	e8 00 00 00 00       	call   1e9b <mm_alloc_vmem+0x154>
						virt_address += 4096;
    1e9b:	48 81 85 90 fe ff ff 00 10 00 00 	add    QWORD PTR [rbp-0x170],0x1000
				while (pg_ct) {
    1ea6:	48 83 bd 88 fe ff ff 00 	cmp    QWORD PTR [rbp-0x178],0x0
    1eae:	75 be                	jne    1e6e <mm_alloc_vmem+0x127>
				}
				return rv;
    1eb0:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1eb4:	e9 02 01 00 00       	jmp    1fbb <mm_alloc_vmem+0x274>
		} else if ((flags & MMGR_ALLOC_NP_AOA) == MMGR_ALLOC_NP_AOA) {
    1eb9:	8b 85 84 fe ff ff    	mov    eax,DWORD PTR [rbp-0x17c]
    1ebf:	25 00 00 02 00       	and    eax,0x20000
    1ec4:	85 c0                	test   eax,eax
    1ec6:	74 37                	je     1eff <mm_alloc_vmem+0x1b8>
				void* rv = virt_address;
    1ec8:	48 8b 85 90 fe ff ff 	mov    rax,QWORD PTR [rbp-0x170]
    1ecf:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				mm_aoa_range(mm, virt_address, pg_ct, flags);
    1ed3:	8b 8d 84 fe ff ff    	mov    ecx,DWORD PTR [rbp-0x17c]
    1ed9:	48 8b 95 88 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x178]
    1ee0:	48 8b b5 90 fe ff ff 	mov    rsi,QWORD PTR [rbp-0x170]
    1ee7:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1eee:	48 89 c7             	mov    rdi,rax
    1ef1:	e8 00 00 00 00       	call   1ef6 <mm_alloc_vmem+0x1af>
				return rv;
    1ef6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1efa:	e9 bc 00 00 00       	jmp    1fbb <mm_alloc_vmem+0x274>
		} else {
				void* rv = virt_address;
    1eff:	48 8b 85 90 fe ff ff 	mov    rax,QWORD PTR [rbp-0x170]
    1f06:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				do {
						struct page_range pr[16]; size_t ct, ct2, prc = 0;
    1f0a:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
						ct = ct2 = mm_alloc_pm(pg_ct, pr, 16);
    1f12:	48 8b 85 88 fe ff ff 	mov    rax,QWORD PTR [rbp-0x178]
    1f19:	89 c1                	mov    ecx,eax
    1f1b:	48 8d 85 a0 fe ff ff 	lea    rax,[rbp-0x160]
    1f22:	ba 10 00 00 00       	mov    edx,0x10
    1f27:	48 89 c6             	mov    rsi,rax
    1f2a:	89 cf                	mov    edi,ecx
    1f2c:	e8 00 00 00 00       	call   1f31 <mm_alloc_vmem+0x1ea>
    1f31:	89 c0                	mov    eax,eax
    1f33:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1f37:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1f3b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						pg_ct -= ct;
    1f3f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1f43:	48 29 85 88 fe ff ff 	sub    QWORD PTR [rbp-0x178],rax
						while (ct) {
    1f4a:	eb 1d                	jmp    1f69 <mm_alloc_vmem+0x222>
								ct -= pr[prc].count;
    1f4c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f50:	48 c1 e0 04          	shl    rax,0x4
    1f54:	48 01 e8             	add    rax,rbp
    1f57:	48 2d 58 01 00 00    	sub    rax,0x158
    1f5d:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1f60:	48 29 45 f8          	sub    QWORD PTR [rbp-0x8],rax
								prc++;
    1f64:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
						while (ct) {
    1f69:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1f6e:	75 dc                	jne    1f4c <mm_alloc_vmem+0x205>
						}
						 mm_map(mm, virt_address, &pr, prc, flags);
    1f70:	8b bd 84 fe ff ff    	mov    edi,DWORD PTR [rbp-0x17c]
    1f76:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    1f7a:	48 8d 95 a0 fe ff ff 	lea    rdx,[rbp-0x160]
    1f81:	48 8b b5 90 fe ff ff 	mov    rsi,QWORD PTR [rbp-0x170]
    1f88:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    1f8f:	41 89 f8             	mov    r8d,edi
    1f92:	48 89 c7             	mov    rdi,rax
    1f95:	e8 00 00 00 00       	call   1f9a <mm_alloc_vmem+0x253>
						 virt_address += 4096 * ct2;
    1f9a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1f9e:	48 c1 e0 0c          	shl    rax,0xc
    1fa2:	48 01 85 90 fe ff ff 	add    QWORD PTR [rbp-0x170],rax
				} while (pg_ct);
    1fa9:	48 83 bd 88 fe ff ff 00 	cmp    QWORD PTR [rbp-0x178],0x0
    1fb1:	0f 85 53 ff ff ff    	jne    1f0a <mm_alloc_vmem+0x1c3>
				return rv;
    1fb7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
		}
}
    1fbb:	c9                   	leave
    1fbc:	c3                   	ret

0000000000001fbd <mm_extend_vmem>:

void* mm_extend_vmem(struct mm* mm, void* ptr, size_t pg_ct, size_t new_pg_ct, int flg)
{
    1fbd:	55                   	push   rbp
    1fbe:	48 89 e5             	mov    rbp,rsp
    1fc1:	48 81 ec 80 08 00 00 	sub    rsp,0x880
    1fc8:	48 89 bd a8 f7 ff ff 	mov    QWORD PTR [rbp-0x858],rdi
    1fcf:	48 89 b5 a0 f7 ff ff 	mov    QWORD PTR [rbp-0x860],rsi
    1fd6:	48 89 95 98 f7 ff ff 	mov    QWORD PTR [rbp-0x868],rdx
    1fdd:	48 89 8d 90 f7 ff ff 	mov    QWORD PTR [rbp-0x870],rcx
    1fe4:	44 89 85 8c f7 ff ff 	mov    DWORD PTR [rbp-0x874],r8d
		size_t new_pmem = new_pg_ct - pg_ct, pm_res, p0c = 0, p1c = 0;
    1feb:	48 8b 85 90 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x870]
    1ff2:	48 2b 85 98 f7 ff ff 	sub    rax,QWORD PTR [rbp-0x868]
    1ff9:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    1ffd:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    2005:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		void *rv, *p0 = ptr, *p1;
    200d:	48 8b 85 a0 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x860]
    2014:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		struct page_range prs[128];
		if (!ptr || new_pg_ct <= pg_ct)
    2018:	48 83 bd a0 f7 ff ff 00 	cmp    QWORD PTR [rbp-0x860],0x0
    2020:	74 10                	je     2032 <mm_extend_vmem+0x75>
    2022:	48 8b 85 90 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x870]
    2029:	48 39 85 98 f7 ff ff 	cmp    QWORD PTR [rbp-0x868],rax
    2030:	72 0a                	jb     203c <mm_extend_vmem+0x7f>
				return NULL;
    2032:	b8 00 00 00 00       	mov    eax,0x0
    2037:	e9 09 02 00 00       	jmp    2245 <mm_extend_vmem+0x288>
		/* reserve virtual memory */
		rv = mm_reserve_vmem(mm, new_pg_ct, flg);
    203c:	8b 95 8c f7 ff ff    	mov    edx,DWORD PTR [rbp-0x874]
    2042:	48 8b 8d 90 f7 ff ff 	mov    rcx,QWORD PTR [rbp-0x870]
    2049:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    2050:	48 89 ce             	mov    rsi,rcx
    2053:	48 89 c7             	mov    rdi,rax
    2056:	e8 00 00 00 00       	call   205b <mm_extend_vmem+0x9e>
    205b:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		if (!rv)
    205f:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
    2064:	75 0a                	jne    2070 <mm_extend_vmem+0xb3>
				return NULL;
    2066:	b8 00 00 00 00       	mov    eax,0x0
    206b:	e9 d5 01 00 00       	jmp    2245 <mm_extend_vmem+0x288>

		/* remap the existing pages */
		p1 = rv;
    2070:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2074:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		while (pg_ct) {
    2078:	e9 b9 00 00 00       	jmp    2136 <mm_extend_vmem+0x179>
				struct page_range pr;
				pr.base = mm_page_get_pmem(mm, p0);
    207d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2081:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    2088:	48 89 d6             	mov    rsi,rdx
    208b:	48 89 c7             	mov    rdi,rax
    208e:	e8 00 00 00 00       	call   2093 <mm_extend_vmem+0xd6>
    2093:	48 89 85 b0 f7 ff ff 	mov    QWORD PTR [rbp-0x850],rax
				pr.count = 1; flg = 0;
    209a:	48 c7 85 b8 f7 ff ff 01 00 00 00 	mov    QWORD PTR [rbp-0x848],0x1
    20a5:	c7 85 8c f7 ff ff 00 00 00 00 	mov    DWORD PTR [rbp-0x874],0x0
				if (!mm_map(mm, p1, &pr, 1, flg)) {
    20af:	8b 8d 8c f7 ff ff    	mov    ecx,DWORD PTR [rbp-0x874]
    20b5:	48 8d 95 b0 f7 ff ff 	lea    rdx,[rbp-0x850]
    20bc:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    20c0:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    20c7:	41 89 c8             	mov    r8d,ecx
    20ca:	b9 01 00 00 00       	mov    ecx,0x1
    20cf:	48 89 c7             	mov    rdi,rax
    20d2:	e8 00 00 00 00       	call   20d7 <mm_extend_vmem+0x11a>
    20d7:	48 85 c0             	test   rax,rax
    20da:	75 3d                	jne    2119 <mm_extend_vmem+0x15c>
						if (p0c) /* undo the new mapping */
    20dc:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    20e1:	74 2c                	je     210f <mm_extend_vmem+0x152>
								mm_unmap(mm, rv - p0c * 4096, p0c);
    20e3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20e7:	48 c1 e0 0c          	shl    rax,0xc
    20eb:	48 f7 d8             	neg    rax
    20ee:	48 89 c2             	mov    rdx,rax
    20f1:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    20f5:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    20f9:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    20fd:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    2104:	48 89 ce             	mov    rsi,rcx
    2107:	48 89 c7             	mov    rdi,rax
    210a:	e8 00 00 00 00       	call   210f <mm_extend_vmem+0x152>
						return NULL;
    210f:	b8 00 00 00 00       	mov    eax,0x0
    2114:	e9 2c 01 00 00       	jmp    2245 <mm_extend_vmem+0x288>
				}
				p0c++; pg_ct--;
    2119:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    211e:	48 83 ad 98 f7 ff ff 01 	sub    QWORD PTR [rbp-0x868],0x1
				p0 += 4096;
    2126:	48 81 45 e8 00 10 00 00 	add    QWORD PTR [rbp-0x18],0x1000
				p1 += 4096;
    212e:	48 81 45 e0 00 10 00 00 	add    QWORD PTR [rbp-0x20],0x1000
		while (pg_ct) {
    2136:	48 83 bd 98 f7 ff ff 00 	cmp    QWORD PTR [rbp-0x868],0x0
    213e:	0f 85 39 ff ff ff    	jne    207d <mm_extend_vmem+0xc0>
		}
		/* now get the physical memory and map it */
		while (new_pmem) {
    2144:	e9 d0 00 00 00       	jmp    2219 <mm_extend_vmem+0x25c>
				pm_res = mm_alloc_pm(new_pmem, prs, 128);
    2149:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    214d:	89 c1                	mov    ecx,eax
    214f:	48 8d 85 c0 f7 ff ff 	lea    rax,[rbp-0x840]
    2156:	ba 80 00 00 00       	mov    edx,0x80
    215b:	48 89 c6             	mov    rsi,rax
    215e:	89 cf                	mov    edi,ecx
    2160:	e8 00 00 00 00       	call   2165 <mm_extend_vmem+0x1a8>
    2165:	89 c0                	mov    eax,eax
    2167:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				if (!pm_res) {
    216b:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    2170:	75 4d                	jne    21bf <mm_extend_vmem+0x202>
						/* out of pmem */
						mm_free_vmem(mm, rv + p0c * 4096, p1c);
    2172:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2176:	48 c1 e0 0c          	shl    rax,0xc
    217a:	48 89 c2             	mov    rdx,rax
    217d:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2181:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    2185:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    2189:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    2190:	48 89 ce             	mov    rsi,rcx
    2193:	48 89 c7             	mov    rdi,rax
    2196:	e8 00 00 00 00       	call   219b <mm_extend_vmem+0x1de>
						mm_unmap(mm, rv, p0c);
    219b:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    219f:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    21a3:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    21aa:	48 89 ce             	mov    rsi,rcx
    21ad:	48 89 c7             	mov    rdi,rax
    21b0:	e8 00 00 00 00       	call   21b5 <mm_extend_vmem+0x1f8>
						return NULL;
    21b5:	b8 00 00 00 00       	mov    eax,0x0
    21ba:	e9 86 00 00 00       	jmp    2245 <mm_extend_vmem+0x288>
				}
				if (!mm_map(mm, p1, prs, 128, flg)) {
    21bf:	8b 8d 8c f7 ff ff    	mov    ecx,DWORD PTR [rbp-0x874]
    21c5:	48 8d 95 c0 f7 ff ff 	lea    rdx,[rbp-0x840]
    21cc:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    21d0:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    21d7:	41 89 c8             	mov    r8d,ecx
    21da:	b9 80 00 00 00       	mov    ecx,0x80
    21df:	48 89 c7             	mov    rdi,rax
    21e2:	e8 00 00 00 00       	call   21e7 <mm_extend_vmem+0x22a>
    21e7:	48 85 c0             	test   rax,rax
    21ea:	75 19                	jne    2205 <mm_extend_vmem+0x248>
						/* cannot happen on reserved mem */
						cprintf(KFMT_ERROR, "Error while mapping virtual memory which was already reserved.");
    21ec:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    21f3:	bf 0c 00 00 00       	mov    edi,0xc
    21f8:	b8 00 00 00 00       	mov    eax,0x0
    21fd:	e8 00 00 00 00       	call   2202 <mm_extend_vmem+0x245>
						while (1);
    2202:	90                   	nop
    2203:	eb fd                	jmp    2202 <mm_extend_vmem+0x245>
				} else {
						p1 += pm_res * 4096;
    2205:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2209:	48 c1 e0 0c          	shl    rax,0xc
    220d:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
						p1c += pm_res;
    2211:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2215:	48 01 45 f0          	add    QWORD PTR [rbp-0x10],rax
		while (new_pmem) {
    2219:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    221e:	0f 85 25 ff ff ff    	jne    2149 <mm_extend_vmem+0x18c>
				}
		}
		/* and unmap the old memory */
		mm_unmap(mm, ptr, p0c);
    2224:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2228:	48 8b 8d a0 f7 ff ff 	mov    rcx,QWORD PTR [rbp-0x860]
    222f:	48 8b 85 a8 f7 ff ff 	mov    rax,QWORD PTR [rbp-0x858]
    2236:	48 89 ce             	mov    rsi,rcx
    2239:	48 89 c7             	mov    rdi,rax
    223c:	e8 00 00 00 00       	call   2241 <mm_extend_vmem+0x284>
		return rv;
    2241:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
}
    2245:	c9                   	leave
    2246:	c3                   	ret

0000000000002247 <mm_free_vmem>:

void mm_free_vmem(struct mm* mm, void* virt_address, size_t pg_ct)
{
    2247:	55                   	push   rbp
    2248:	48 89 e5             	mov    rbp,rsp
    224b:	48 83 c4 80          	add    rsp,0xffffffffffffff80
    224f:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    2253:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
    2257:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};
    225b:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
    2263:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0

		/* check every page */
		while (pg_ct--) {
    226b:	e9 55 01 00 00       	jmp    23c5 <mm_free_vmem+0x17e>
				/* first get the references to the structures */
				rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);
    2270:	4c 8d 4d ec          	lea    r9,[rbp-0x14]
    2274:	4c 8d 45 f0          	lea    r8,[rbp-0x10]
    2278:	48 8d 4d d8          	lea    rcx,[rbp-0x28]
    227c:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    2280:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
    2284:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2288:	48 8d 7d c8          	lea    rdi,[rbp-0x38]
    228c:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
    2291:	48 8d 7d d0          	lea    rdi,[rbp-0x30]
    2295:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    2299:	48 89 c7             	mov    rdi,rax
    229c:	e8 00 00 00 00       	call   22a1 <mm_free_vmem+0x5a>
    22a1:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax

				if (rv == 0) { /* present page */
    22a4:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    22a8:	0f 85 ab 00 00 00    	jne    2359 <mm_free_vmem+0x112>
						uint64_t b;
						/* get the physical memory */
						if (!cpu.has_pae)
    22ae:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 22b5 <mm_free_vmem+0x6e>
    22b5:	83 e0 40             	and    eax,0x40
    22b8:	84 c0                	test   al,al
    22ba:	75 14                	jne    22d0 <mm_free_vmem+0x89>
								b = ((struct pte32*)e)->addr * 0x1000;
    22bc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    22c0:	8b 00                	mov    eax,DWORD PTR [rax]
    22c2:	c1 e8 0c             	shr    eax,0xc
    22c5:	c1 e0 0c             	shl    eax,0xc
    22c8:	48 98                	cdqe
    22ca:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    22ce:	eb 2d                	jmp    22fd <mm_free_vmem+0xb6>
						else
								b = ((struct pte64*)e)->addr * 0x1000;
    22d0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    22d4:	48 8b 00             	mov    rax,QWORD PTR [rax]
    22d7:	48 c1 e8 0c          	shr    rax,0xc
    22db:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    22e5:	48 21 d0             	and    rax,rdx
    22e8:	48 c1 e0 0c          	shl    rax,0xc
    22ec:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    22f6:	48 21 d0             	and    rax,rdx
    22f9:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						/* concat if possible */
						if (pr.count) {
    22fd:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2301:	48 85 c0             	test   rax,rax
    2304:	74 41                	je     2347 <mm_free_vmem+0x100>
								if (pr.base + 4096 * pr.count == b)
    2306:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    230a:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    230e:	48 c1 e2 0c          	shl    rdx,0xc
    2312:	48 01 d0             	add    rax,rdx
    2315:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    2319:	75 11                	jne    232c <mm_free_vmem+0xe5>
										pr.count++;
    231b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    231f:	48 83 c0 01          	add    rax,0x1
    2323:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    2327:	e9 91 00 00 00       	jmp    23bd <mm_free_vmem+0x176>
								else {
										/* deallocate */
										mm_free_pm(&pr, 1);
    232c:	48 8d 45 b8          	lea    rax,[rbp-0x48]
    2330:	be 01 00 00 00       	mov    esi,0x1
    2335:	48 89 c7             	mov    rdi,rax
    2338:	e8 00 00 00 00       	call   233d <mm_free_vmem+0xf6>
										pr.count = 0;
    233d:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
    2345:	eb 76                	jmp    23bd <mm_free_vmem+0x176>
								}
						} else {
								pr.base = b;
    2347:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    234b:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
								pr.count = 1;
    234f:	48 c7 45 c0 01 00 00 00 	mov    QWORD PTR [rbp-0x40],0x1
    2357:	eb 64                	jmp    23bd <mm_free_vmem+0x176>
						}
				} else if (e) { /* AOW etc. */
    2359:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    235d:	48 85 c0             	test   rax,rax
    2360:	74 2b                	je     238d <mm_free_vmem+0x146>
						bzero(e, cpu.has_pae ? 8 : 4);
    2362:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2369 <mm_free_vmem+0x122>
    2369:	83 e0 40             	and    eax,0x40
    236c:	84 c0                	test   al,al
    236e:	74 07                	je     2377 <mm_free_vmem+0x130>
    2370:	ba 08 00 00 00       	mov    edx,0x8
    2375:	eb 05                	jmp    237c <mm_free_vmem+0x135>
    2377:	ba 04 00 00 00       	mov    edx,0x4
    237c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2380:	48 89 d6             	mov    rsi,rdx
    2383:	48 89 c7             	mov    rdi,rax
    2386:	e8 00 00 00 00       	call   238b <mm_free_vmem+0x144>
    238b:	eb 30                	jmp    23bd <mm_free_vmem+0x176>
				} else {
						/* invalid address */
						die("Invalid virtual address specified in free_vmem.\n");
    238d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2394:	bf 0c 00 00 00       	mov    edi,0xc
    2399:	b8 00 00 00 00       	mov    eax,0x0
    239e:	e8 00 00 00 00       	call   23a3 <mm_free_vmem+0x15c>
    23a3:	b8 00 00 00 00       	mov    eax,0x0
    23a8:	e8 00 00 00 00       	call   23ad <mm_free_vmem+0x166>
    23ad:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    23b4:	e8 00 00 00 00       	call   23b9 <mm_free_vmem+0x172>
    23b9:	fa                   	cli
    23ba:	f4                   	hlt
    23bb:	eb fd                	jmp    23ba <mm_free_vmem+0x173>
				}

				/* advance */
				virt_address += 4096;
    23bd:	48 81 45 a0 00 10 00 00 	add    QWORD PTR [rbp-0x60],0x1000
		while (pg_ct--) {
    23c5:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    23c9:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    23cd:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
    23d1:	48 85 c0             	test   rax,rax
    23d4:	0f 85 96 fe ff ff    	jne    2270 <mm_free_vmem+0x29>
		}

		/* remove remaining pmem */
		if (pr.count)
    23da:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    23de:	48 85 c0             	test   rax,rax
    23e1:	74 11                	je     23f4 <mm_free_vmem+0x1ad>
				mm_free_pm(&pr, 1);
    23e3:	48 8d 45 b8          	lea    rax,[rbp-0x48]
    23e7:	be 01 00 00 00       	mov    esi,0x1
    23ec:	48 89 c7             	mov    rdi,rax
    23ef:	e8 00 00 00 00       	call   23f4 <mm_free_vmem+0x1ad>
}
    23f4:	90                   	nop
    23f5:	c9                   	leave
    23f6:	c3                   	ret

00000000000023f7 <mm_page_walk>:

int mm_page_walk(struct mm* mm, void* vmem, void** p, void** e, int* lv,
				uint32_t* of, void*** cntr, void*** cntrm)
{
    23f7:	55                   	push   rbp
    23f8:	48 89 e5             	mov    rbp,rsp
    23fb:	48 83 ec 40          	sub    rsp,0x40
    23ff:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    2403:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
    2407:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
    240b:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
    240f:	4c 89 45 d8          	mov    QWORD PTR [rbp-0x28],r8
    2413:	4c 89 4d d0          	mov    QWORD PTR [rbp-0x30],r9
#ifdef __x86_64__
		return mm_page_walk64(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
    2417:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    241b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    241f:	4c 8b 4d d0          	mov    r9,QWORD PTR [rbp-0x30]
    2423:	4c 8b 45 d8          	mov    r8,QWORD PTR [rbp-0x28]
    2427:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
    242b:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    242f:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
    2433:	48 8b 7d 18          	mov    rdi,QWORD PTR [rbp+0x18]
    2437:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
    243c:	48 8b 7d 10          	mov    rdi,QWORD PTR [rbp+0x10]
    2440:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    2444:	48 89 c7             	mov    rdi,rax
    2447:	e8 00 00 00 00       	call   244c <mm_page_walk+0x55>
		if (cpu.has_pae)
				return mm_page_walk36(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
		else
				return mm_page_walk32(mm->ctx, vmem, p, e, lv, of, cntr, cntrm);
#endif
}
    244c:	c9                   	leave
    244d:	c3                   	ret

000000000000244e <mm_page_get_pmem>:

uint64_t mm_page_get_pmem(struct mm* mm, void* virt_address)
{
    244e:	55                   	push   rbp
    244f:	48 89 e5             	mov    rbp,rsp
    2452:	48 83 ec 60          	sub    rsp,0x60
    2456:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    245a:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
		int lv, rv; uint32_t of; void *p, *e;
		void **cntr, **cntrm;
		struct page_range pr = {0, 0};
    245e:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
    2466:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0

		/* first get the references to the structures */
		rv = mm_page_walk(mm, virt_address, &p, &e, &lv, &of, &cntr, &cntrm);
    246e:	4c 8d 4d f4          	lea    r9,[rbp-0xc]
    2472:	4c 8d 45 f8          	lea    r8,[rbp-0x8]
    2476:	48 8d 4d e0          	lea    rcx,[rbp-0x20]
    247a:	48 8d 55 e8          	lea    rdx,[rbp-0x18]
    247e:	48 8b 75 b0          	mov    rsi,QWORD PTR [rbp-0x50]
    2482:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2486:	48 8d 7d d0          	lea    rdi,[rbp-0x30]
    248a:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
    248f:	48 8d 7d d8          	lea    rdi,[rbp-0x28]
    2493:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    2497:	48 89 c7             	mov    rdi,rax
    249a:	e8 00 00 00 00       	call   249f <mm_page_get_pmem+0x51>
    249f:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax

		if (!rv)
    24a2:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    24a6:	75 0c                	jne    24b4 <mm_page_get_pmem+0x66>
				return (uint64_t)-1;
    24a8:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
    24af:	e9 91 00 00 00       	jmp    2545 <mm_page_get_pmem+0xf7>
		else if (!lv) {
    24b4:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    24b7:	85 c0                	test   eax,eax
    24b9:	75 49                	jne    2504 <mm_page_get_pmem+0xb6>
				if (cpu.has_pae)
    24bb:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 24c2 <mm_page_get_pmem+0x74>
    24c2:	83 e0 40             	and    eax,0x40
    24c5:	84 c0                	test   al,al
    24c7:	74 2b                	je     24f4 <mm_page_get_pmem+0xa6>
						return ((struct pte64*)e)->addr * 0x1000;
    24c9:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    24cd:	48 8b 00             	mov    rax,QWORD PTR [rax]
    24d0:	48 c1 e8 0c          	shr    rax,0xc
    24d4:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    24de:	48 21 d0             	and    rax,rdx
    24e1:	48 c1 e0 0c          	shl    rax,0xc
    24e5:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    24ef:	48 21 d0             	and    rax,rdx
    24f2:	eb 51                	jmp    2545 <mm_page_get_pmem+0xf7>
				else
						return ((struct pte32*)e)->addr * 0x1000;
    24f4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    24f8:	8b 00                	mov    eax,DWORD PTR [rax]
    24fa:	c1 e8 0c             	shr    eax,0xc
    24fd:	c1 e0 0c             	shl    eax,0xc
    2500:	48 98                	cdqe
    2502:	eb 41                	jmp    2545 <mm_page_get_pmem+0xf7>
		} else { /* ignore PAT bit */
				if (cpu.has_pae)
    2504:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 250b <mm_page_get_pmem+0xbd>
    250b:	83 e0 40             	and    eax,0x40
    250e:	84 c0                	test   al,al
    2510:	74 22                	je     2534 <mm_page_get_pmem+0xe6>
						return (((struct pte64*)e)->addr & ~1ull) * 0x1000;
    2512:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2516:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2519:	48 c1 e8 0c          	shr    rax,0xc
    251d:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    2527:	48 21 d0             	and    rax,rdx
    252a:	48 83 e0 fe          	and    rax,0xfffffffffffffffe
    252e:	48 c1 e0 0c          	shl    rax,0xc
    2532:	eb 11                	jmp    2545 <mm_page_get_pmem+0xf7>
				else
						return (((struct pte32*)e)->addr & ~1) * 0x1000;
    2534:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2538:	8b 00                	mov    eax,DWORD PTR [rax]
    253a:	c1 e8 0c             	shr    eax,0xc
    253d:	83 e0 fe             	and    eax,0xfffffffe
    2540:	c1 e0 0c             	shl    eax,0xc
    2543:	48 98                	cdqe
		}
}
    2545:	c9                   	leave
    2546:	c3                   	ret

0000000000002547 <mm_handle_pagefault>:

int mm_handle_pagefault(struct mm* mm, void* eip, uint32_t seg_error, void* cr2)
{
    2547:	55                   	push   rbp
    2548:	48 89 e5             	mov    rbp,rsp
    254b:	48 81 ec e0 00 00 00 	sub    rsp,0xe0
    2552:	48 89 bd 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rdi
    2559:	48 89 b5 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rsi
    2560:	89 95 3c ff ff ff    	mov    DWORD PTR [rbp-0xc4],edx
    2566:	48 89 8d 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rcx
		extern struct kio_region kb_reg; /* for I/O diag */
		int lv, rv; uint32_t of; struct pte64 *p, *e; struct pte32 *ps, *es;
		void **cntr, **cntrm;

		/* first get the references to the structures */
		rv = mm_page_walk(mm, cr2, &p, &e, &lv, &of, &cntr, &cntrm);
    256d:	4c 8d 4d 98          	lea    r9,[rbp-0x68]
    2571:	4c 8d 45 9c          	lea    r8,[rbp-0x64]
    2575:	48 8d 4d 88          	lea    rcx,[rbp-0x78]
    2579:	48 8d 55 90          	lea    rdx,[rbp-0x70]
    257d:	48 8b b5 30 ff ff ff 	mov    rsi,QWORD PTR [rbp-0xd0]
    2584:	48 8b 85 48 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb8]
    258b:	48 8d bd 78 ff ff ff 	lea    rdi,[rbp-0x88]
    2592:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
    2597:	48 8d 7d 80          	lea    rdi,[rbp-0x80]
    259b:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    259f:	48 89 c7             	mov    rdi,rax
    25a2:	e8 00 00 00 00       	call   25a7 <mm_handle_pagefault+0x60>
    25a7:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
		ps = (void*)p; es = (void*)e;
    25aa:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    25ae:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    25b2:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    25b6:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax

		/* then check the error code */
		/* bits: 0=present, 1=write, 2=user, 3=res, 4=nx */

		if (seg_error & 1) { /* some sort of access violation */
    25ba:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    25c0:	83 e0 01             	and    eax,0x1
    25c3:	85 c0                	test   eax,eax
    25c5:	0f 84 44 04 00 00    	je     2a0f <mm_handle_pagefault+0x4c8>
				if (seg_error & 8) { /* reserved bits */
    25cb:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    25d1:	83 e0 08             	and    eax,0x8
    25d4:	85 c0                	test   eax,eax
    25d6:	0f 84 c3 00 00 00    	je     269f <mm_handle_pagefault+0x158>
						uint32_t hi, lo;
						cprintf(KFMT_ERROR, "Page lookup through %p contained entries"
    25dc:	48 8b 85 30 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd0]
    25e3:	48 89 c2             	mov    rdx,rax
    25e6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    25ed:	bf 0c 00 00 00       	mov    edi,0xc
    25f2:	b8 00 00 00 00       	mov    eax,0x0
    25f7:	e8 00 00 00 00       	call   25fc <mm_handle_pagefault+0xb5>
								" which have reserved bits set. This indicates"
								" either page table corruption or sloppy programming.\n", cr2);
						printf("seg_error: %08x\n", seg_error);
    25fc:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    2602:	89 c6                	mov    esi,eax
    2604:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    260b:	b8 00 00 00 00       	mov    eax,0x0
    2610:	e8 00 00 00 00       	call   2615 <mm_handle_pagefault+0xce>
						printf("level=%d, entry=%u\n", lv, of);
    2615:	8b 55 98             	mov    edx,DWORD PTR [rbp-0x68]
    2618:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    261b:	89 c6                	mov    esi,eax
    261d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2624:	b8 00 00 00 00       	mov    eax,0x0
    2629:	e8 00 00 00 00       	call   262e <mm_handle_pagefault+0xe7>
						if (cpu.has_pae)
    262e:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2635 <mm_handle_pagefault+0xee>
    2635:	83 e0 40             	and    eax,0x40
    2638:	84 c0                	test   al,al
    263a:	74 1d                	je     2659 <mm_handle_pagefault+0x112>
								printf("entry: %016llx\n", *(uint64_t*)e);
    263c:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2640:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2643:	48 89 c6             	mov    rsi,rax
    2646:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    264d:	b8 00 00 00 00       	mov    eax,0x0
    2652:	e8 00 00 00 00       	call   2657 <mm_handle_pagefault+0x110>
    2657:	eb 19                	jmp    2672 <mm_handle_pagefault+0x12b>
						else
								printf("entry: %08x\n", *(uint32_t*)es);
    2659:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    265d:	8b 00                	mov    eax,DWORD PTR [rax]
    265f:	89 c6                	mov    esi,eax
    2661:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2668:	b8 00 00 00 00       	mov    eax,0x0
    266d:	e8 00 00 00 00       	call   2672 <mm_handle_pagefault+0x12b>
						/* Show MSR */
						asm ("rdmsr" : "=a" (lo), "=d" (hi) : "c" (0xc0000080));
    2672:	b8 80 00 00 c0       	mov    eax,0xc0000080
    2677:	89 c1                	mov    ecx,eax
    2679:	0f 32                	rdmsr
    267b:	89 45 a4             	mov    DWORD PTR [rbp-0x5c],eax
    267e:	89 55 a0             	mov    DWORD PTR [rbp-0x60],edx
						printf("MSR: %08x%08x\n", hi, lo);
    2681:	8b 55 a4             	mov    edx,DWORD PTR [rbp-0x5c]
    2684:	8b 45 a0             	mov    eax,DWORD PTR [rbp-0x60]
    2687:	89 c6                	mov    esi,eax
    2689:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2690:	b8 00 00 00 00       	mov    eax,0x0
    2695:	e8 00 00 00 00       	call   269a <mm_handle_pagefault+0x153>
    269a:	e9 da 05 00 00       	jmp    2c79 <mm_handle_pagefault+0x732>
				} else { /* regular access error */
						uint64_t pm; int w, u, x, tlb = 0;
    269f:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
						const char* errstr; uint32_t avl;

						/* get the info */
						if (!cpu.has_pae) {
    26a6:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 26ad <mm_handle_pagefault+0x166>
    26ad:	83 e0 40             	and    eax,0x40
    26b0:	84 c0                	test   al,al
    26b2:	75 56                	jne    270a <mm_handle_pagefault+0x1c3>
								pm = es->addr * 0x1000;
    26b4:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    26b8:	8b 00                	mov    eax,DWORD PTR [rax]
    26ba:	c1 e8 0c             	shr    eax,0xc
    26bd:	c1 e0 0c             	shl    eax,0xc
    26c0:	48 98                	cdqe
    26c2:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
								x = 1;
    26c6:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1
								w = es->w;
    26cd:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    26d1:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    26d4:	d0 e8                	shr    al,1
    26d6:	83 e0 01             	and    eax,0x1
    26d9:	0f b6 c0             	movzx  eax,al
    26dc:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								u = es->u;
    26df:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    26e3:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    26e6:	c0 e8 02             	shr    al,0x2
    26e9:	83 e0 01             	and    eax,0x1
    26ec:	0f b6 c0             	movzx  eax,al
    26ef:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
								avl = es->ign;
    26f2:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    26f6:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    26fa:	d0 e8                	shr    al,1
    26fc:	83 e0 07             	and    eax,0x7
    26ff:	0f b6 c0             	movzx  eax,al
    2702:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
    2705:	e9 93 00 00 00       	jmp    279d <mm_handle_pagefault+0x256>
						} else {
								pm = e->addr * 0x1000;
    270a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    270e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2711:	48 c1 e8 0c          	shr    rax,0xc
    2715:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    271f:	48 21 d0             	and    rax,rdx
    2722:	48 c1 e0 0c          	shl    rax,0xc
    2726:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    2730:	48 21 d0             	and    rax,rdx
    2733:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
								x = !e->xd;
    2737:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    273b:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
    273f:	83 e0 80             	and    eax,0xffffff80
    2742:	84 c0                	test   al,al
    2744:	0f 94 c0             	sete   al
    2747:	0f b6 c0             	movzx  eax,al
    274a:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
								w = e->w;
    274d:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2751:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2754:	d0 e8                	shr    al,1
    2756:	83 e0 01             	and    eax,0x1
    2759:	0f b6 c0             	movzx  eax,al
    275c:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								u = e->u;
    275f:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2763:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2766:	c0 e8 02             	shr    al,0x2
    2769:	83 e0 01             	and    eax,0x1
    276c:	0f b6 c0             	movzx  eax,al
    276f:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
								avl = e->ign | (e->ign2 << 3);
    2772:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2776:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
    277a:	d0 e8                	shr    al,1
    277c:	83 e0 07             	and    eax,0x7
    277f:	0f b6 d0             	movzx  edx,al
    2782:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2786:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    278a:	66 c1 e8 04          	shr    ax,0x4
    278e:	66 25 ff 07          	and    ax,0x7ff
    2792:	0f b7 c0             	movzx  eax,ax
    2795:	c1 e0 03             	shl    eax,0x3
    2798:	09 d0                	or     eax,edx
    279a:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
						}
						/* create the errstr */
						if (seg_error & 16) {
    279d:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    27a3:	83 e0 10             	and    eax,0x10
    27a6:	85 c0                	test   eax,eax
    27a8:	74 1f                	je     27c9 <mm_handle_pagefault+0x282>
								if (x) { /* check for NX in directoy */
    27aa:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    27ae:	74 0c                	je     27bc <mm_handle_pagefault+0x275>
										tlb = 1;
    27b0:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [rbp-0x18],0x1
    27b7:	e9 31 01 00 00       	jmp    28ed <mm_handle_pagefault+0x3a6>
								} else
										errstr = "no execute";
    27bc:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    27c4:	e9 24 01 00 00       	jmp    28ed <mm_handle_pagefault+0x3a6>
						} else if (seg_error & 4) {
    27c9:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    27cf:	83 e0 04             	and    eax,0x4
    27d2:	85 c0                	test   eax,eax
    27d4:	74 1f                	je     27f5 <mm_handle_pagefault+0x2ae>
								if (u)
    27d6:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    27da:	74 0c                	je     27e8 <mm_handle_pagefault+0x2a1>
										tlb = 1;
    27dc:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [rbp-0x18],0x1
    27e3:	e9 05 01 00 00       	jmp    28ed <mm_handle_pagefault+0x3a6>
								else
										errstr = "kernel";
    27e8:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    27f0:	e9 f8 00 00 00       	jmp    28ed <mm_handle_pagefault+0x3a6>
						} else if (seg_error & 2) {
    27f5:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    27fb:	83 e0 02             	and    eax,0x2
    27fe:	85 c0                	test   eax,eax
    2800:	0f 84 e7 00 00 00    	je     28ed <mm_handle_pagefault+0x3a6>
								if (w) /* we assume consistent directories */
    2806:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    280a:	74 0c                	je     2818 <mm_handle_pagefault+0x2d1>
										tlb = 1;
    280c:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [rbp-0x18],0x1
    2813:	e9 d5 00 00 00       	jmp    28ed <mm_handle_pagefault+0x3a6>
								else if (avl & 1) { /* COW */
    2818:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    281b:	83 e0 01             	and    eax,0x1
    281e:	85 c0                	test   eax,eax
    2820:	0f 84 bf 00 00 00    	je     28e5 <mm_handle_pagefault+0x39e>
										size_t pg_ct = 1; struct page_range pr;
    2826:	48 c7 45 a8 01 00 00 00 	mov    QWORD PTR [rbp-0x58],0x1
										if (lv > 0) {
    282e:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    2831:	85 c0                	test   eax,eax
    2833:	7e 30                	jle    2865 <mm_handle_pagefault+0x31e>
												die("COW on large pages not implemented yet\n");
    2835:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    283c:	bf 0c 00 00 00       	mov    edi,0xc
    2841:	b8 00 00 00 00       	mov    eax,0x0
    2846:	e8 00 00 00 00       	call   284b <mm_handle_pagefault+0x304>
    284b:	b8 00 00 00 00       	mov    eax,0x0
    2850:	e8 00 00 00 00       	call   2855 <mm_handle_pagefault+0x30e>
    2855:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    285c:	e8 00 00 00 00       	call   2861 <mm_handle_pagefault+0x31a>
    2861:	fa                   	cli
    2862:	f4                   	hlt
    2863:	eb fd                	jmp    2862 <mm_handle_pagefault+0x31b>
										}
										if (mm_alloc_pm(pg_ct, &pr, 1)) {
    2865:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2869:	89 c1                	mov    ecx,eax
    286b:	48 8d 85 68 ff ff ff 	lea    rax,[rbp-0x98]
    2872:	ba 01 00 00 00       	mov    edx,0x1
    2877:	48 89 c6             	mov    rsi,rax
    287a:	89 cf                	mov    edi,ecx
    287c:	e8 00 00 00 00       	call   2881 <mm_handle_pagefault+0x33a>
    2881:	85 c0                	test   eax,eax
    2883:	74 30                	je     28b5 <mm_handle_pagefault+0x36e>
												/* FIXME: Shootdown needed? No stale data would cause
												 * another COW and this can be detected in the PF handler. */
												die("COW not implemented\n");
    2885:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    288c:	bf 0c 00 00 00       	mov    edi,0xc
    2891:	b8 00 00 00 00       	mov    eax,0x0
    2896:	e8 00 00 00 00       	call   289b <mm_handle_pagefault+0x354>
    289b:	b8 00 00 00 00       	mov    eax,0x0
    28a0:	e8 00 00 00 00       	call   28a5 <mm_handle_pagefault+0x35e>
    28a5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28ac:	e8 00 00 00 00       	call   28b1 <mm_handle_pagefault+0x36a>
    28b1:	fa                   	cli
    28b2:	f4                   	hlt
    28b3:	eb fd                	jmp    28b2 <mm_handle_pagefault+0x36b>
										} else {
												die("unable to allocate memory for COW\n");
    28b5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    28bc:	bf 0c 00 00 00       	mov    edi,0xc
    28c1:	b8 00 00 00 00       	mov    eax,0x0
    28c6:	e8 00 00 00 00       	call   28cb <mm_handle_pagefault+0x384>
    28cb:	b8 00 00 00 00       	mov    eax,0x0
    28d0:	e8 00 00 00 00       	call   28d5 <mm_handle_pagefault+0x38e>
    28d5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28dc:	e8 00 00 00 00       	call   28e1 <mm_handle_pagefault+0x39a>
    28e1:	fa                   	cli
    28e2:	f4                   	hlt
    28e3:	eb fd                	jmp    28e2 <mm_handle_pagefault+0x39b>
										}
								} else
										errstr = "read only";
    28e5:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
						}

						if (tlb) {
    28ed:	83 7d e8 00          	cmp    DWORD PTR [rbp-0x18],0x0
    28f1:	74 5f                	je     2952 <mm_handle_pagefault+0x40b>
								uint8_t id = 0;
    28f3:	c6 45 db 00          	mov    BYTE PTR [rbp-0x25],0x0
								if (nproc > 1)
    28f7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 28fd <mm_handle_pagefault+0x3b6>
    28fd:	83 f8 01             	cmp    eax,0x1
    2900:	76 0f                	jbe    2911 <mm_handle_pagefault+0x3ca>
										id = smp_processor_id();
    2902:	b8 00 00 00 00       	mov    eax,0x0
    2907:	e8 f4 d6 ff ff       	call   0 <per_cpu_ptr>
    290c:	8b 00                	mov    eax,DWORD PTR [rax]
    290e:	88 45 db             	mov    BYTE PTR [rbp-0x25],al
								rprintf(&kb_reg, "[%u] TLB fl: %p\n", id, cr2);
    2911:	0f b6 45 db          	movzx  eax,BYTE PTR [rbp-0x25]
    2915:	48 8b 95 30 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xd0]
    291c:	48 89 d1             	mov    rcx,rdx
    291f:	89 c2                	mov    edx,eax
    2921:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2928:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    292f:	b8 00 00 00 00       	mov    eax,0x0
    2934:	e8 00 00 00 00       	call   2939 <mm_handle_pagefault+0x3f2>
								flush_tlb_single(cr2);
    2939:	48 8b 85 30 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd0]
    2940:	48 89 c7             	mov    rdi,rax
    2943:	e8 d3 d6 ff ff       	call   1b <flush_tlb_single>
								return 0;
    2948:	b8 00 00 00 00       	mov    eax,0x0
    294d:	e9 2c 03 00 00       	jmp    2c7e <mm_handle_pagefault+0x737>
						}

						/* print the error */
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
								" but is not allowed to do so as page is marked as %s\n",
								eip, (seg_error & 2) ? "write to" : ((seg_error & 16) ?
    2952:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    2958:	83 e0 02             	and    eax,0x2
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
    295b:	85 c0                	test   eax,eax
    295d:	75 1f                	jne    297e <mm_handle_pagefault+0x437>
								eip, (seg_error & 2) ? "write to" : ((seg_error & 16) ?
    295f:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
    2965:	83 e0 10             	and    eax,0x10
								"fetch instructions from": "read from"),
    2968:	85 c0                	test   eax,eax
    296a:	74 09                	je     2975 <mm_handle_pagefault+0x42e>
    296c:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2973:	eb 10                	jmp    2985 <mm_handle_pagefault+0x43e>
    2975:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    297c:	eb 07                	jmp    2985 <mm_handle_pagefault+0x43e>
						cprintf(KFMT_ERROR, "code at %p tried to %s virtual address %p"
    297e:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2985:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    2989:	48 8b 8d 30 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xd0]
    2990:	48 8b 95 40 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xc0]
    2997:	49 89 f1             	mov    r9,rsi
    299a:	49 89 c8             	mov    r8,rcx
    299d:	48 89 c1             	mov    rcx,rax
    29a0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    29a7:	bf 0c 00 00 00       	mov    edi,0xc
    29ac:	b8 00 00 00 00       	mov    eax,0x0
    29b1:	e8 00 00 00 00       	call   29b6 <mm_handle_pagefault+0x46f>
								cr2, errstr);
						printf("The page is %s and present\n", lv ? (lv > 1 ? "huge" : "large") : "regular");
    29b6:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    29b9:	85 c0                	test   eax,eax
    29bb:	74 1a                	je     29d7 <mm_handle_pagefault+0x490>
    29bd:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    29c0:	83 f8 01             	cmp    eax,0x1
    29c3:	7e 09                	jle    29ce <mm_handle_pagefault+0x487>
    29c5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    29cc:	eb 10                	jmp    29de <mm_handle_pagefault+0x497>
    29ce:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    29d5:	eb 07                	jmp    29de <mm_handle_pagefault+0x497>
    29d7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    29de:	48 89 c6             	mov    rsi,rax
    29e1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29e8:	b8 00 00 00 00       	mov    eax,0x0
    29ed:	e8 00 00 00 00       	call   29f2 <mm_handle_pagefault+0x4ab>
						printf("it points to physical memory at %#.16llx\n", pm);
    29f2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    29f6:	48 89 c6             	mov    rsi,rax
    29f9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a00:	b8 00 00 00 00       	mov    eax,0x0
    2a05:	e8 00 00 00 00       	call   2a0a <mm_handle_pagefault+0x4c3>
    2a0a:	e9 6a 02 00 00       	jmp    2c79 <mm_handle_pagefault+0x732>
				}
		} else { /* encountered nonpresent page */
				uint64_t flags = 0;
    2a0f:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
				/* get flag bits */
				if (!cpu.has_pae) { /* pte32 */
    2a17:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2a1e <mm_handle_pagefault+0x4d7>
    2a1e:	83 e0 40             	and    eax,0x40
    2a21:	84 c0                	test   al,al
    2a23:	75 45                	jne    2a6a <mm_handle_pagefault+0x523>
						if (es) /* there's sth. */
    2a25:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    2a2a:	74 0e                	je     2a3a <mm_handle_pagefault+0x4f3>
								flags |= *(uint32_t*)es;
    2a2c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2a30:	8b 00                	mov    eax,DWORD PTR [rax]
    2a32:	89 c0                	mov    eax,eax
    2a34:	48 09 45 d0          	or     QWORD PTR [rbp-0x30],rax
    2a38:	eb 76                	jmp    2ab0 <mm_handle_pagefault+0x569>
						else
								die("level 2 missing\n");
    2a3a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2a41:	bf 0c 00 00 00       	mov    edi,0xc
    2a46:	b8 00 00 00 00       	mov    eax,0x0
    2a4b:	e8 00 00 00 00       	call   2a50 <mm_handle_pagefault+0x509>
    2a50:	b8 00 00 00 00       	mov    eax,0x0
    2a55:	e8 00 00 00 00       	call   2a5a <mm_handle_pagefault+0x513>
    2a5a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a61:	e8 00 00 00 00       	call   2a66 <mm_handle_pagefault+0x51f>
    2a66:	fa                   	cli
    2a67:	f4                   	hlt
    2a68:	eb fd                	jmp    2a67 <mm_handle_pagefault+0x520>
				} else {
						if (e)
    2a6a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2a6e:	48 85 c0             	test   rax,rax
    2a71:	74 0d                	je     2a80 <mm_handle_pagefault+0x539>
								flags |= *(uint64_t*)e;
    2a73:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2a77:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2a7a:	48 09 45 d0          	or     QWORD PTR [rbp-0x30],rax
    2a7e:	eb 30                	jmp    2ab0 <mm_handle_pagefault+0x569>
						else
								die("level 2 or 4 missing\n");
    2a80:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2a87:	bf 0c 00 00 00       	mov    edi,0xc
    2a8c:	b8 00 00 00 00       	mov    eax,0x0
    2a91:	e8 00 00 00 00       	call   2a96 <mm_handle_pagefault+0x54f>
    2a96:	b8 00 00 00 00       	mov    eax,0x0
    2a9b:	e8 00 00 00 00       	call   2aa0 <mm_handle_pagefault+0x559>
    2aa0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2aa7:	e8 00 00 00 00       	call   2aac <mm_handle_pagefault+0x565>
    2aac:	fa                   	cli
    2aad:	f4                   	hlt
    2aae:	eb fd                	jmp    2aad <mm_handle_pagefault+0x566>
				}

				/* check for known codes */
				flags >>= 1;
    2ab0:	48 d1 6d d0          	shr    QWORD PTR [rbp-0x30],1
				/* CAUTION: Swap IDs have to keep AVL field free */
				if (flags & (1 << 11)) { /* allocate on access */
    2ab4:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2ab8:	25 00 08 00 00       	and    eax,0x800
    2abd:	48 85 c0             	test   rax,rax
    2ac0:	0f 84 60 01 00 00    	je     2c26 <mm_handle_pagefault+0x6df>
						size_t pg_ct = 1; struct page_range pr;
    2ac6:	48 c7 45 b0 01 00 00 00 	mov    QWORD PTR [rbp-0x50],0x1
						if (lv > 0) {
    2ace:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    2ad1:	85 c0                	test   eax,eax
    2ad3:	7e 30                	jle    2b05 <mm_handle_pagefault+0x5be>
								/* TODO: cont alloc & large pages */
								die("no AOA large pages implemented yet!\n");
    2ad5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2adc:	bf 0c 00 00 00       	mov    edi,0xc
    2ae1:	b8 00 00 00 00       	mov    eax,0x0
    2ae6:	e8 00 00 00 00       	call   2aeb <mm_handle_pagefault+0x5a4>
    2aeb:	b8 00 00 00 00       	mov    eax,0x0
    2af0:	e8 00 00 00 00       	call   2af5 <mm_handle_pagefault+0x5ae>
    2af5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2afc:	e8 00 00 00 00       	call   2b01 <mm_handle_pagefault+0x5ba>
    2b01:	fa                   	cli
    2b02:	f4                   	hlt
    2b03:	eb fd                	jmp    2b02 <mm_handle_pagefault+0x5bb>
						}
						/* alloc & print info */
						if (mm_alloc_pm(pg_ct, &pr, 1)) {
    2b05:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2b09:	89 c1                	mov    ecx,eax
    2b0b:	48 8d 85 58 ff ff ff 	lea    rax,[rbp-0xa8]
    2b12:	ba 01 00 00 00       	mov    edx,0x1
    2b17:	48 89 c6             	mov    rsi,rax
    2b1a:	89 cf                	mov    edi,ecx
    2b1c:	e8 00 00 00 00       	call   2b21 <mm_handle_pagefault+0x5da>
    2b21:	85 c0                	test   eax,eax
    2b23:	0f 84 cd 00 00 00    	je     2bf6 <mm_handle_pagefault+0x6af>
								/* level0 -> no new pointers */
								if (!cpu.has_pae) {
    2b29:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2b30 <mm_handle_pagefault+0x5e9>
    2b30:	83 e0 40             	and    eax,0x40
    2b33:	84 c0                	test   al,al
    2b35:	75 32                	jne    2b69 <mm_handle_pagefault+0x622>
										es->addr = (uint32_t)(pr.base / 4096);
    2b37:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2b3e:	48 c1 e8 0c          	shr    rax,0xc
    2b42:	25 ff ff 0f 00       	and    eax,0xfffff
    2b47:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    2b4b:	c1 e0 0c             	shl    eax,0xc
    2b4e:	89 c1                	mov    ecx,eax
    2b50:	8b 02                	mov    eax,DWORD PTR [rdx]
    2b52:	25 ff 0f 00 00       	and    eax,0xfff
    2b57:	09 c8                	or     eax,ecx
    2b59:	89 02                	mov    DWORD PTR [rdx],eax
										es->p = 1;
    2b5b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2b5f:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    2b62:	83 ca 01             	or     edx,0x1
    2b65:	88 10                	mov    BYTE PTR [rax],dl
    2b67:	eb 52                	jmp    2bbb <mm_handle_pagefault+0x674>
								} else {
										e->addr = pr.base / 4096;
    2b69:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2b70:	48 c1 e8 0c          	shr    rax,0xc
    2b74:	48 89 c1             	mov    rcx,rax
    2b77:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b7b:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    2b85:	48 21 d1             	and    rcx,rdx
    2b88:	48 ba ff ff ff ff ff 00 00 00 	movabs rdx,0xffffffffff
    2b92:	48 21 ca             	and    rdx,rcx
    2b95:	48 c1 e2 0c          	shl    rdx,0xc
    2b99:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    2b9c:	48 be ff 0f 00 00 00 00 f0 ff 	movabs rsi,0xfff0000000000fff
    2ba6:	48 21 f1             	and    rcx,rsi
    2ba9:	48 09 ca             	or     rdx,rcx
    2bac:	48 89 10             	mov    QWORD PTR [rax],rdx
										e->p = 1;
    2baf:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2bb3:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    2bb6:	83 ca 01             	or     edx,0x1
    2bb9:	88 10                	mov    BYTE PTR [rax],dl
								}
								flush_tlb_single(cr2);
    2bbb:	48 8b 85 30 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd0]
    2bc2:	48 89 c7             	mov    rdi,rax
    2bc5:	e8 51 d4 ff ff       	call   1b <flush_tlb_single>
								rprintf(&kb_reg, "MM AOW: %p\n", cr2);
    2bca:	48 8b 85 30 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd0]
    2bd1:	48 89 c2             	mov    rdx,rax
    2bd4:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2bdb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2be2:	b8 00 00 00 00       	mov    eax,0x0
    2be7:	e8 00 00 00 00       	call   2bec <mm_handle_pagefault+0x6a5>
								return 0;
    2bec:	b8 00 00 00 00       	mov    eax,0x0
    2bf1:	e9 88 00 00 00       	jmp    2c7e <mm_handle_pagefault+0x737>
						} else {
								die("Out of memory for AOA\n");
    2bf6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2bfd:	bf 0c 00 00 00       	mov    edi,0xc
    2c02:	b8 00 00 00 00       	mov    eax,0x0
    2c07:	e8 00 00 00 00       	call   2c0c <mm_handle_pagefault+0x6c5>
    2c0c:	b8 00 00 00 00       	mov    eax,0x0
    2c11:	e8 00 00 00 00       	call   2c16 <mm_handle_pagefault+0x6cf>
    2c16:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c1d:	e8 00 00 00 00       	call   2c22 <mm_handle_pagefault+0x6db>
    2c22:	fa                   	cli
    2c23:	f4                   	hlt
    2c24:	eb fd                	jmp    2c23 <mm_handle_pagefault+0x6dc>
						}
				} else {
						/* swapped with ID */
						cprintf(KFMT_INFO, "Swapping in single page with id %llu\n", flags);
    2c26:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2c2a:	48 89 c2             	mov    rdx,rax
    2c2d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2c34:	bf 0b 00 00 00       	mov    edi,0xb
    2c39:	b8 00 00 00 00       	mov    eax,0x0
    2c3e:	e8 00 00 00 00       	call   2c43 <mm_handle_pagefault+0x6fc>
						cprintf(KFMT_ERROR, "which is not implemented\n");
    2c43:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2c4a:	bf 0c 00 00 00       	mov    edi,0xc
    2c4f:	b8 00 00 00 00       	mov    eax,0x0
    2c54:	e8 00 00 00 00       	call   2c59 <mm_handle_pagefault+0x712>
						printf("level=%d, entry=%u, ptr=%p\n", lv, of, cr2);
    2c59:	8b 55 98             	mov    edx,DWORD PTR [rbp-0x68]
    2c5c:	8b 45 9c             	mov    eax,DWORD PTR [rbp-0x64]
    2c5f:	48 8b 8d 30 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xd0]
    2c66:	89 c6                	mov    esi,eax
    2c68:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c6f:	b8 00 00 00 00       	mov    eax,0x0
    2c74:	e8 00 00 00 00       	call   2c79 <mm_handle_pagefault+0x732>
		// --------------
		// Codes with access violation on present pages: 3 avl bits
		// 0 = regular, i.e. invalid
		// 1 = copy on write
		*/
		return 1;
    2c79:	b8 01 00 00 00       	mov    eax,0x1
}
    2c7e:	c9                   	leave
    2c7f:	c3                   	ret

0000000000002c80 <print_stacktrace>:

const char* elf_get_closest_symbol(void* ptr, size_t* offset);
void print_stacktrace()
{
    2c80:	55                   	push   rbp
    2c81:	48 89 e5             	mov    rbp,rsp
    2c84:	53                   	push   rbx
    2c85:	48 83 ec 78          	sub    rsp,0x78
				struct sf* prev;
				void* ret_addr;
				void* args[4];
		} __attribute__((packed)) *fp;
		static int stc = 0;
		stc++;
    2c89:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2c8f <print_stacktrace+0xf>
    2c8f:	83 c0 01             	add    eax,0x1
    2c92:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 2c98 <print_stacktrace+0x18>
		if (stc == 1) {
    2c98:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2c9e <print_stacktrace+0x1e>
    2c9e:	83 f8 01             	cmp    eax,0x1
    2ca1:	0f 85 09 01 00 00    	jne    2db0 <print_stacktrace+0x130>
print_st:
    2ca7:	90                   	nop
				/* get ebp into C code */
#ifdef __x86_64__
				__asm__("mov %%rbp, %[fp]" : /* output */ [fp] "=r" (fp));
    2ca8:	48 89 e8             	mov    rax,rbp
    2cab:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
#else
				__asm__("movl %%ebp, %[fp]" : /* output */ [fp] "=r" (fp));
#endif
				/* do the backtrace from ebp to ebp */
				printf("performing stacktrace:\n");
    2caf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2cb6:	b8 00 00 00 00       	mov    eax,0x0
    2cbb:	e8 00 00 00 00       	call   2cc0 <print_stacktrace+0x40>
#ifdef __x86_64__
				printf("RBP              ARG-1             ARG-2             ARG-3             ARG-4            FROM\n");
    2cc0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2cc7:	b8 00 00 00 00       	mov    eax,0x0
    2ccc:	e8 00 00 00 00       	call   2cd1 <print_stacktrace+0x51>
#else
				printf("EBP      ARG-1     ARG-2     ARG-3     ARG-4    FROM\n");
#endif
				do {
						size_t of; const char* sym;
						printf("%p %p %p %p %p %p\n", fp, fp->args[0], fp->args[1],
    2cd1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2cd5:	48 8b 70 08          	mov    rsi,QWORD PTR [rax+0x8]
    2cd9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2cdd:	4c 8b 40 28          	mov    r8,QWORD PTR [rax+0x28]
    2ce1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ce5:	48 8b 78 20          	mov    rdi,QWORD PTR [rax+0x20]
    2ce9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ced:	48 8b 48 18          	mov    rcx,QWORD PTR [rax+0x18]
    2cf1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2cf5:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    2cf9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2cfd:	48 89 34 24          	mov    QWORD PTR [rsp],rsi
    2d01:	4d 89 c1             	mov    r9,r8
    2d04:	49 89 f8             	mov    r8,rdi
    2d07:	48 89 c6             	mov    rsi,rax
    2d0a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2d11:	b8 00 00 00 00       	mov    eax,0x0
    2d16:	e8 00 00 00 00       	call   2d1b <print_stacktrace+0x9b>
										fp->args[2], fp->args[3], fp->ret_addr);
						sym = (const char*)elf_get_closest_symbol(fp->ret_addr, &of);
    2d1b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2d1f:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2d23:	48 8d 55 b8          	lea    rdx,[rbp-0x48]
    2d27:	48 89 d6             	mov    rsi,rdx
    2d2a:	48 89 c7             	mov    rdi,rax
    2d2d:	e8 00 00 00 00       	call   2d32 <print_stacktrace+0xb2>
    2d32:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
						cprintf(KFMT_INFO, "called from %p (%s%+#lx)\n", fp->ret_addr, sym, of);
    2d36:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    2d3a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2d3e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2d42:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    2d46:	49 89 c8             	mov    r8,rcx
    2d49:	48 89 d1             	mov    rcx,rdx
    2d4c:	48 89 c2             	mov    rdx,rax
    2d4f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2d56:	bf 0b 00 00 00       	mov    edi,0xb
    2d5b:	b8 00 00 00 00       	mov    eax,0x0
    2d60:	e8 00 00 00 00       	call   2d65 <print_stacktrace+0xe5>
						extern void _start();
						if (fp->ret_addr - 5 == (void*)&_start)
    2d65:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2d69:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2d6d:	48 83 e8 05          	sub    rax,0x5
    2d71:	48 3d 00 00 00 00    	cmp    rax,0x0
    2d77:	74 25                	je     2d9e <print_stacktrace+0x11e>
								break; /* only until call to kmain */
						else if (!fp->ret_addr)
    2d79:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2d7d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2d81:	48 85 c0             	test   rax,rax
    2d84:	74 1b                	je     2da1 <print_stacktrace+0x121>
								break;
						fp = fp->prev;
    2d86:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2d8a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2d8d:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				} while (fp);
    2d91:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2d96:	0f 85 35 ff ff ff    	jne    2cd1 <print_stacktrace+0x51>
    2d9c:	eb 04                	jmp    2da2 <print_stacktrace+0x122>
								break; /* only until call to kmain */
    2d9e:	90                   	nop
    2d9f:	eb 01                	jmp    2da2 <print_stacktrace+0x122>
								break;
    2da1:	90                   	nop
				framebuffer_redraw(&fb_initial);
    2da2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2da9:	e8 00 00 00 00       	call   2dae <print_stacktrace+0x12e>
    2dae:	eb 30                	jmp    2de0 <print_stacktrace+0x160>
		} else
				die("stacktrace loop!\n");
    2db0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2db7:	bf 0c 00 00 00       	mov    edi,0xc
    2dbc:	b8 00 00 00 00       	mov    eax,0x0
    2dc1:	e8 00 00 00 00       	call   2dc6 <print_stacktrace+0x146>
    2dc6:	b8 00 00 00 00       	mov    eax,0x0
    2dcb:	e8 00 00 00 00       	call   2dd0 <print_stacktrace+0x150>
    2dd0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2dd7:	e8 00 00 00 00       	call   2ddc <print_stacktrace+0x15c>
    2ddc:	fa                   	cli
    2ddd:	f4                   	hlt
    2dde:	eb fd                	jmp    2ddd <print_stacktrace+0x15d>
		/* now offer basic diag */
print_help:
		printf("Debug diagnostics mode with following commands:\n"
    2de0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2de7:	b8 00 00 00 00       	mov    eax,0x0
    2dec:	e8 00 00 00 00       	call   2df1 <print_stacktrace+0x171>
				"\tm                   Display symbol map\n"
				"\tk                   Reprint the stack trace\n"
				"\th(elp)              Display this help message\n"
				"\th(a)lt              Turns off the computer\n"
				"\tl Address           Find symbol below/at Address\n");
		framebuffer_redraw(&fb_initial);
    2df1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2df8:	e8 00 00 00 00       	call   2dfd <print_stacktrace+0x17d>
		while (1) {
				char* str = 0; size_t n = 0;
    2dfd:	48 c7 45 b0 00 00 00 00 	mov    QWORD PTR [rbp-0x50],0x0
    2e05:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
				printf("enter command:\n");
    2e0d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e14:	b8 00 00 00 00       	mov    eax,0x0
    2e19:	e8 00 00 00 00       	call   2e1e <print_stacktrace+0x19e>
				framebuffer_redraw(&fb_initial);
    2e1e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e25:	e8 00 00 00 00       	call   2e2a <print_stacktrace+0x1aa>
				getline(&str, &n);
    2e2a:	48 8d 55 a8          	lea    rdx,[rbp-0x58]
    2e2e:	48 8d 45 b0          	lea    rax,[rbp-0x50]
    2e32:	48 89 d6             	mov    rsi,rdx
    2e35:	48 89 c7             	mov    rdi,rax
    2e38:	e8 00 00 00 00       	call   2e3d <print_stacktrace+0x1bd>
				if (str) {
    2e3d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e41:	48 85 c0             	test   rax,rax
    2e44:	74 b7                	je     2dfd <print_stacktrace+0x17d>
						if (strlen(str))
    2e46:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e4a:	48 89 c7             	mov    rdi,rax
    2e4d:	e8 00 00 00 00       	call   2e52 <print_stacktrace+0x1d2>
    2e52:	48 85 c0             	test   rax,rax
    2e55:	74 1a                	je     2e71 <print_stacktrace+0x1f1>
								str[strlen(str) - 1] = '\0';
    2e57:	48 8b 5d b0          	mov    rbx,QWORD PTR [rbp-0x50]
    2e5b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e5f:	48 89 c7             	mov    rdi,rax
    2e62:	e8 00 00 00 00       	call   2e67 <print_stacktrace+0x1e7>
    2e67:	48 83 e8 01          	sub    rax,0x1
    2e6b:	48 01 d8             	add    rax,rbx
    2e6e:	c6 00 00             	mov    BYTE PTR [rax],0x0
						if (strcmp(str, "r") == 0)
    2e71:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e75:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2e7c:	48 89 c7             	mov    rdi,rax
    2e7f:	e8 00 00 00 00       	call   2e84 <print_stacktrace+0x204>
    2e84:	85 c0                	test   eax,eax
    2e86:	75 16                	jne    2e9e <print_stacktrace+0x21e>
								printf("registers: \n");
    2e88:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e8f:	b8 00 00 00 00       	mov    eax,0x0
    2e94:	e8 00 00 00 00       	call   2e99 <print_stacktrace+0x219>
    2e99:	e9 f4 01 00 00       	jmp    3092 <print_stacktrace+0x412>
						else if (strcmp(str, "k") == 0)
    2e9e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2ea2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2ea9:	48 89 c7             	mov    rdi,rax
    2eac:	e8 00 00 00 00       	call   2eb1 <print_stacktrace+0x231>
    2eb1:	85 c0                	test   eax,eax
    2eb3:	75 05                	jne    2eba <print_stacktrace+0x23a>
    2eb5:	e9 ee fd ff ff       	jmp    2ca8 <print_stacktrace+0x28>
								goto print_st;
						else if (strcmp(str, "m") == 0)
    2eba:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2ebe:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2ec5:	48 89 c7             	mov    rdi,rax
    2ec8:	e8 00 00 00 00       	call   2ecd <print_stacktrace+0x24d>
    2ecd:	85 c0                	test   eax,eax
    2ecf:	75 16                	jne    2ee7 <print_stacktrace+0x267>
								printf("Symbol map: \n");
    2ed1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ed8:	b8 00 00 00 00       	mov    eax,0x0
    2edd:	e8 00 00 00 00       	call   2ee2 <print_stacktrace+0x262>
    2ee2:	e9 ab 01 00 00       	jmp    3092 <print_stacktrace+0x412>
						else if (strncmp(str, "l ", 2) == 0) {
    2ee7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2eeb:	ba 02 00 00 00       	mov    edx,0x2
    2ef0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2ef7:	48 89 c7             	mov    rdi,rax
    2efa:	e8 00 00 00 00       	call   2eff <print_stacktrace+0x27f>
    2eff:	85 c0                	test   eax,eax
    2f01:	75 56                	jne    2f59 <print_stacktrace+0x2d9>
								long int addr = strtol(str + 2, NULL, 0);
    2f03:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2f07:	48 83 c0 02          	add    rax,0x2
    2f0b:	ba 00 00 00 00       	mov    edx,0x0
    2f10:	be 00 00 00 00       	mov    esi,0x0
    2f15:	48 89 c7             	mov    rdi,rax
    2f18:	e8 00 00 00 00       	call   2f1d <print_stacktrace+0x29d>
    2f1d:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
								const char* sym; size_t of;
								sym = (const char*)elf_get_closest_symbol((void*)addr, &of);
    2f21:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2f25:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
    2f29:	48 89 d6             	mov    rsi,rdx
    2f2c:	48 89 c7             	mov    rdi,rax
    2f2f:	e8 00 00 00 00       	call   2f34 <print_stacktrace+0x2b4>
    2f34:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
								printf("Address is located at %s%+#lx\n", sym, of);
    2f38:	48 8b 55 a0          	mov    rdx,QWORD PTR [rbp-0x60]
    2f3c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2f40:	48 89 c6             	mov    rsi,rax
    2f43:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2f4a:	b8 00 00 00 00       	mov    eax,0x0
    2f4f:	e8 00 00 00 00       	call   2f54 <print_stacktrace+0x2d4>
    2f54:	e9 39 01 00 00       	jmp    3092 <print_stacktrace+0x412>
						} else if (strncmp(str, "db ", 3) == 0) {
    2f59:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2f5d:	ba 03 00 00 00       	mov    edx,0x3
    2f62:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2f69:	48 89 c7             	mov    rdi,rax
    2f6c:	e8 00 00 00 00       	call   2f71 <print_stacktrace+0x2f1>
    2f71:	85 c0                	test   eax,eax
    2f73:	75 69                	jne    2fde <print_stacktrace+0x35e>
								char* end;
								long int addr = strtol(str + 3, &end, 0), cap = 512;
    2f75:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2f79:	48 8d 48 03          	lea    rcx,[rax+0x3]
    2f7d:	48 8d 45 98          	lea    rax,[rbp-0x68]
    2f81:	ba 00 00 00 00       	mov    edx,0x0
    2f86:	48 89 c6             	mov    rsi,rax
    2f89:	48 89 cf             	mov    rdi,rcx
    2f8c:	e8 00 00 00 00       	call   2f91 <print_stacktrace+0x311>
    2f91:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    2f95:	48 c7 45 e0 00 02 00 00 	mov    QWORD PTR [rbp-0x20],0x200
								if (*end == ' ')
    2f9d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2fa1:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2fa4:	3c 20                	cmp    al,0x20
    2fa6:	75 1e                	jne    2fc6 <print_stacktrace+0x346>
										cap = strtol(end + 1, NULL, 0);
    2fa8:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2fac:	48 83 c0 01          	add    rax,0x1
    2fb0:	ba 00 00 00 00       	mov    edx,0x0
    2fb5:	be 00 00 00 00       	mov    esi,0x0
    2fba:	48 89 c7             	mov    rdi,rax
    2fbd:	e8 00 00 00 00       	call   2fc2 <print_stacktrace+0x342>
    2fc2:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								memdump((void*)addr, cap);
    2fc6:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    2fca:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2fce:	48 89 d6             	mov    rsi,rdx
    2fd1:	48 89 c7             	mov    rdi,rax
    2fd4:	e8 00 00 00 00       	call   2fd9 <print_stacktrace+0x359>
    2fd9:	e9 b4 00 00 00       	jmp    3092 <print_stacktrace+0x412>
						} else if (strcmp(str, "dpt") == 0) {
    2fde:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2fe2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2fe9:	48 89 c7             	mov    rdi,rax
    2fec:	e8 00 00 00 00       	call   2ff1 <print_stacktrace+0x371>
    2ff1:	85 c0                	test   eax,eax
    2ff3:	75 16                	jne    300b <print_stacktrace+0x38b>
								printf("dumping page table\n");
    2ff5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ffc:	b8 00 00 00 00       	mov    eax,0x0
    3001:	e8 00 00 00 00       	call   3006 <print_stacktrace+0x386>
    3006:	e9 87 00 00 00       	jmp    3092 <print_stacktrace+0x412>
						} else if (strcmp(str, "help") == 0 || strcmp(str, "h") == 0)
    300b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    300f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3016:	48 89 c7             	mov    rdi,rax
    3019:	e8 00 00 00 00       	call   301e <print_stacktrace+0x39e>
    301e:	85 c0                	test   eax,eax
    3020:	0f 84 ba fd ff ff    	je     2de0 <print_stacktrace+0x160>
    3026:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    302a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3031:	48 89 c7             	mov    rdi,rax
    3034:	e8 00 00 00 00       	call   3039 <print_stacktrace+0x3b9>
    3039:	85 c0                	test   eax,eax
    303b:	75 05                	jne    3042 <print_stacktrace+0x3c2>
    303d:	e9 9e fd ff ff       	jmp    2de0 <print_stacktrace+0x160>
								goto print_help;
						else if (strcmp(str, "halt") == 0 || strcmp(str, "hlt") == 0)
    3042:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3046:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    304d:	48 89 c7             	mov    rdi,rax
    3050:	e8 00 00 00 00       	call   3055 <print_stacktrace+0x3d5>
    3055:	85 c0                	test   eax,eax
    3057:	74 17                	je     3070 <print_stacktrace+0x3f0>
    3059:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    305d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3064:	48 89 c7             	mov    rdi,rax
    3067:	e8 00 00 00 00       	call   306c <print_stacktrace+0x3ec>
    306c:	85 c0                	test   eax,eax
    306e:	75 0a                	jne    307a <print_stacktrace+0x3fa>
								pc_shutdown();
    3070:	b8 00 00 00 00       	mov    eax,0x0
    3075:	e8 00 00 00 00       	call   307a <print_stacktrace+0x3fa>
						else
								printf("unknown command \"%s\"\n", str);
    307a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    307e:	48 89 c6             	mov    rsi,rax
    3081:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3088:	b8 00 00 00 00       	mov    eax,0x0
    308d:	e8 00 00 00 00       	call   3092 <print_stacktrace+0x412>
						kfree(str);
    3092:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    3096:	48 89 c7             	mov    rdi,rax
    3099:	e8 00 00 00 00       	call   309e <print_stacktrace+0x41e>
		while (1) {
    309e:	e9 5a fd ff ff       	jmp    2dfd <print_stacktrace+0x17d>
