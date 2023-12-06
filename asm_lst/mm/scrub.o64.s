
mm/scrub.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <per_cpu_ptr>:
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
   4:	48 83 ec 10          	sub    rsp,0x10
   8:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
  11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
  15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  19:	c9                   	leave
  1a:	c3                   	ret

000000000000001b <mm_scrub_single_page>:
{
  1b:	55                   	push   rbp
  1c:	48 89 e5             	mov    rbp,rsp
  1f:	48 83 ec 30          	sub    rsp,0x30
  23:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		void* ptr, *map; struct page_range pr = { pm, 1 };
  27:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
  2b:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
  2f:	48 c7 45 e8 01 00 00 00 	mov    QWORD PTR [rbp-0x18],0x1
		if (cur_percpu > VM_MM_PER_CPU_BASE)
  37:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3e <mm_scrub_single_page+0x23>
  3e:	48 3d 00 00 00 fb    	cmp    rax,0xfffffffffb000000
  44:	76 14                	jbe    5a <mm_scrub_single_page+0x3f>
				ptr = per_cpu_ptr()->mm_ctx.scrub_page;
  46:	b8 00 00 00 00       	mov    eax,0x0
  4b:	e8 b0 ff ff ff       	call   0 <per_cpu_ptr>
  50:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
  54:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
  58:	eb 0b                	jmp    65 <mm_scrub_single_page+0x4a>
				ptr = cur_percpu;
  5a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 61 <mm_scrub_single_page+0x46>
  61:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		map = mm_map(&mm_kernel, ptr, &pr, 1, MMGR_MAP_WRITE /* no TLB shootdown */
  65:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
  69:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  6d:	41 b8 14 01 00 00    	mov    r8d,0x114
  73:	b9 01 00 00 00       	mov    ecx,0x1
  78:	48 89 c6             	mov    rsi,rax
  7b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  82:	e8 00 00 00 00       	call   87 <mm_scrub_single_page+0x6c>
  87:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!map)
  8b:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
  90:	75 30                	jne    c2 <mm_scrub_single_page+0xa7>
				die("Unable to scrub!\n");
  92:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
  99:	bf 0c 00 00 00       	mov    edi,0xc
  9e:	b8 00 00 00 00       	mov    eax,0x0
  a3:	e8 00 00 00 00       	call   a8 <mm_scrub_single_page+0x8d>
  a8:	b8 00 00 00 00       	mov    eax,0x0
  ad:	e8 00 00 00 00       	call   b2 <mm_scrub_single_page+0x97>
  b2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  b9:	e8 00 00 00 00       	call   be <mm_scrub_single_page+0xa3>
  be:	fa                   	cli
  bf:	f4                   	hlt
  c0:	eb fd                	jmp    bf <mm_scrub_single_page+0xa4>
		bzero(map, 4096);
  c2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  c6:	be 00 10 00 00       	mov    esi,0x1000
  cb:	48 89 c7             	mov    rdi,rax
  ce:	e8 00 00 00 00       	call   d3 <mm_scrub_single_page+0xb8>
		mm_unmap(&mm_kernel, map, 1);
  d3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  d7:	ba 01 00 00 00       	mov    edx,0x1
  dc:	48 89 c6             	mov    rsi,rax
  df:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  e6:	e8 00 00 00 00       	call   eb <mm_scrub_single_page+0xd0>
}
  eb:	90                   	nop
  ec:	c9                   	leave
  ed:	c3                   	ret

00000000000000ee <mm_scrub_pages>:
{
  ee:	55                   	push   rbp
  ef:	48 89 e5             	mov    rbp,rsp
  f2:	48 83 ec 50          	sub    rsp,0x50
  f6:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
  fa:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
		size_t j, k, l, np = 0, npl = 0;
  fe:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
 106:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		if (fmm[i].reclaimable_pages) {
 10e:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 115 <mm_scrub_pages+0x27>
 115:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
 119:	48 89 d0             	mov    rax,rdx
 11c:	48 c1 e0 03          	shl    rax,0x3
 120:	48 29 d0             	sub    rax,rdx
 123:	48 c1 e0 03          	shl    rax,0x3
 127:	48 01 c8             	add    rax,rcx
 12a:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
 12e:	48 85 c0             	test   rax,rax
 131:	0f 84 b0 00 00 00    	je     1e7 <mm_scrub_pages+0xf9>
				uint64_t ofs = 0; size_t ct = 0;
 137:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
 13f:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
				struct pmu* rc = (void*)fmm[i].rcp;
 147:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 14e <mm_scrub_pages+0x60>
 14e:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
 152:	48 89 d0             	mov    rax,rdx
 155:	48 c1 e0 03          	shl    rax,0x3
 159:	48 29 d0             	sub    rax,rdx
 15c:	48 c1 e0 03          	shl    rax,0x3
 160:	48 01 c8             	add    rax,rcx
 163:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
 167:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				struct pmu* pu = (void*)fmm[i].pmu;
 16b:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 172 <mm_scrub_pages+0x84>
 172:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
 176:	48 89 d0             	mov    rax,rdx
 179:	48 c1 e0 03          	shl    rax,0x3
 17d:	48 29 d0             	sub    rax,rdx
 180:	48 c1 e0 03          	shl    rax,0x3
 184:	48 01 c8             	add    rax,rcx
 187:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
 18b:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				for (j = 0; j < 4; j++)
 18f:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
 197:	eb 47                	jmp    1e0 <mm_scrub_pages+0xf2>
						if (rc->free_ct[j]) { /* reclaimable count */
 199:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
 19d:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
 1a1:	0f b7 44 50 08       	movzx  eax,WORD PTR [rax+rdx*2+0x8]
 1a6:	66 85 c0             	test   ax,ax
 1a9:	74 30                	je     1db <mm_scrub_pages+0xed>
								die("iii");
 1ab:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 1b2:	bf 0c 00 00 00       	mov    edi,0xc
 1b7:	b8 00 00 00 00       	mov    eax,0x0
 1bc:	e8 00 00 00 00       	call   1c1 <mm_scrub_pages+0xd3>
 1c1:	b8 00 00 00 00       	mov    eax,0x0
 1c6:	e8 00 00 00 00       	call   1cb <mm_scrub_pages+0xdd>
 1cb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 1d2:	e8 00 00 00 00       	call   1d7 <mm_scrub_pages+0xe9>
 1d7:	fa                   	cli
 1d8:	f4                   	hlt
 1d9:	eb fd                	jmp    1d8 <mm_scrub_pages+0xea>
				for (j = 0; j < 4; j++)
 1db:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
 1e0:	48 83 7d f8 03       	cmp    QWORD PTR [rbp-0x8],0x3
 1e5:	76 b2                	jbe    199 <mm_scrub_pages+0xab>
done:
 1e7:	90                   	nop
		if (np) {
 1e8:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
 1ed:	74 1f                	je     20e <mm_scrub_pages+0x120>
				rprintf(&kb_reg, "scrubbed %u pages\n", np);
 1ef:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 1f3:	48 89 c2             	mov    rdx,rax
 1f6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 1fd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 204:	b8 00 00 00 00       	mov    eax,0x0
 209:	e8 00 00 00 00       	call   20e <mm_scrub_pages+0x120>
		return np;
 20e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
}
 212:	c9                   	leave
 213:	c3                   	ret

0000000000000214 <mm_page_scrub>:
{
 214:	55                   	push   rbp
 215:	48 89 e5             	mov    rbp,rsp
 218:	48 83 ec 10          	sub    rsp,0x10
		size_t i, lm = 128;
 21c:	48 c7 45 f0 80 00 00 00 	mov    QWORD PTR [rbp-0x10],0x80
		for (i = fm_begin; i < fm_ofs && lm; i++) {
 224:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 22b <mm_page_scrub+0x17>
 22b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
 22f:	eb 1c                	jmp    24d <mm_page_scrub+0x39>
				lm -= mm_scrub_pages(i, lm);
 231:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
 235:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 239:	48 89 d6             	mov    rsi,rdx
 23c:	48 89 c7             	mov    rdi,rax
 23f:	e8 00 00 00 00       	call   244 <mm_page_scrub+0x30>
 244:	48 29 45 f0          	sub    QWORD PTR [rbp-0x10],rax
		for (i = fm_begin; i < fm_ofs && lm; i++) {
 248:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
 24d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 254 <mm_page_scrub+0x40>
 254:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
 258:	73 07                	jae    261 <mm_page_scrub+0x4d>
 25a:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
 25f:	75 d0                	jne    231 <mm_page_scrub+0x1d>
		return (lm != 128);
 261:	48 81 7d f0 80 00 00 00 	cmp    QWORD PTR [rbp-0x10],0x80
 269:	0f 95 c0             	setne  al
 26c:	0f b6 c0             	movzx  eax,al
}
 26f:	c9                   	leave
 270:	c3                   	ret
