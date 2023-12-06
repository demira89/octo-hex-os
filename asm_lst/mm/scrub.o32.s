
mm/scrub.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 10             	sub    esp,0x10
   6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
   c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
   f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
  12:	c9                   	leave
  13:	c3                   	ret

00000014 <mm_scrub_single_page>:
{
  14:	55                   	push   ebp
  15:	89 e5                	mov    ebp,esp
  17:	83 ec 38             	sub    esp,0x38
  1a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  1d:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
  20:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  23:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		void* ptr, *map; struct page_range pr = { pm, 1 };
  26:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
  29:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
  2c:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
  2f:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
  32:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
		if (cur_percpu > VM_MM_PER_CPU_BASE)
  39:	a1 00 00 00 00       	mov    eax,ds:0x0
  3e:	3d 00 00 00 fb       	cmp    eax,0xfb000000
  43:	76 0d                	jbe    52 <mm_scrub_single_page+0x3e>
				ptr = per_cpu_ptr()->mm_ctx.scrub_page;
  45:	e8 b6 ff ff ff       	call   0 <per_cpu_ptr>
  4a:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
  4d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
  50:	eb 08                	jmp    5a <mm_scrub_single_page+0x46>
				ptr = cur_percpu;
  52:	a1 00 00 00 00       	mov    eax,ds:0x0
  57:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		map = mm_map(&mm_kernel, ptr, &pr, 1, MMGR_MAP_WRITE /* no TLB shootdown */
  5a:	83 ec 0c             	sub    esp,0xc
  5d:	68 14 01 00 00       	push   0x114
  62:	6a 01                	push   0x1
  64:	8d 45 e4             	lea    eax,[ebp-0x1c]
  67:	50                   	push   eax
  68:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
  6b:	68 00 00 00 00       	push   0x0
  70:	e8 fc ff ff ff       	call   71 <mm_scrub_single_page+0x5d>
  75:	83 c4 20             	add    esp,0x20
  78:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!map)
  7b:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
  7f:	75 2b                	jne    ac <mm_scrub_single_page+0x98>
				die("Unable to scrub!\n");
  81:	83 ec 08             	sub    esp,0x8
  84:	68 00 00 00 00       	push   0x0
  89:	6a 0c                	push   0xc
  8b:	e8 fc ff ff ff       	call   8c <mm_scrub_single_page+0x78>
  90:	83 c4 10             	add    esp,0x10
  93:	e8 fc ff ff ff       	call   94 <mm_scrub_single_page+0x80>
  98:	83 ec 0c             	sub    esp,0xc
  9b:	68 00 00 00 00       	push   0x0
  a0:	e8 fc ff ff ff       	call   a1 <mm_scrub_single_page+0x8d>
  a5:	83 c4 10             	add    esp,0x10
  a8:	fa                   	cli
  a9:	f4                   	hlt
  aa:	eb fd                	jmp    a9 <mm_scrub_single_page+0x95>
		bzero(map, 4096);
  ac:	83 ec 08             	sub    esp,0x8
  af:	68 00 10 00 00       	push   0x1000
  b4:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
  b7:	e8 fc ff ff ff       	call   b8 <mm_scrub_single_page+0xa4>
  bc:	83 c4 10             	add    esp,0x10
		mm_unmap(&mm_kernel, map, 1);
  bf:	83 ec 04             	sub    esp,0x4
  c2:	6a 01                	push   0x1
  c4:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
  c7:	68 00 00 00 00       	push   0x0
  cc:	e8 fc ff ff ff       	call   cd <mm_scrub_single_page+0xb9>
  d1:	83 c4 10             	add    esp,0x10
}
  d4:	90                   	nop
  d5:	c9                   	leave
  d6:	c3                   	ret

000000d7 <mm_scrub_pages>:
{
  d7:	55                   	push   ebp
  d8:	89 e5                	mov    ebp,esp
  da:	83 ec 38             	sub    esp,0x38
		size_t j, k, l, np = 0, npl = 0;
  dd:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
  e4:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (fmm[i].reclaimable_pages) {
  eb:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
  f1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  f4:	6b c0 38             	imul   eax,eax,0x38
  f7:	01 d0                	add    eax,edx
  f9:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
  fc:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
  ff:	89 c1                	mov    ecx,eax
 101:	89 c8                	mov    eax,ecx
 103:	09 d0                	or     eax,edx
 105:	0f 84 91 00 00 00    	je     19c <mm_scrub_pages+0xc5>
				uint64_t ofs = 0; size_t ct = 0;
 10b:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
 112:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
 119:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
				struct pmu* rc = (void*)fmm[i].rcp;
 120:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
 126:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 129:	6b c0 38             	imul   eax,eax,0x38
 12c:	01 d0                	add    eax,edx
 12e:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
 131:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
 134:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				struct pmu* pu = (void*)fmm[i].pmu;
 137:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
 13d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 140:	6b c0 38             	imul   eax,eax,0x38
 143:	01 d0                	add    eax,edx
 145:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
 148:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 14b:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				for (j = 0; j < 4; j++)
 14e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
 155:	eb 3f                	jmp    196 <mm_scrub_pages+0xbf>
						if (rc->free_ct[j]) { /* reclaimable count */
 157:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 15a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 15d:	0f b7 44 50 08       	movzx  eax,WORD PTR [eax+edx*2+0x8]
 162:	66 85 c0             	test   ax,ax
 165:	74 2b                	je     192 <mm_scrub_pages+0xbb>
								die("iii");
 167:	83 ec 08             	sub    esp,0x8
 16a:	68 12 00 00 00       	push   0x12
 16f:	6a 0c                	push   0xc
 171:	e8 fc ff ff ff       	call   172 <mm_scrub_pages+0x9b>
 176:	83 c4 10             	add    esp,0x10
 179:	e8 fc ff ff ff       	call   17a <mm_scrub_pages+0xa3>
 17e:	83 ec 0c             	sub    esp,0xc
 181:	68 00 00 00 00       	push   0x0
 186:	e8 fc ff ff ff       	call   187 <mm_scrub_pages+0xb0>
 18b:	83 c4 10             	add    esp,0x10
 18e:	fa                   	cli
 18f:	f4                   	hlt
 190:	eb fd                	jmp    18f <mm_scrub_pages+0xb8>
				for (j = 0; j < 4; j++)
 192:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
 196:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
 19a:	76 bb                	jbe    157 <mm_scrub_pages+0x80>
done:
 19c:	90                   	nop
		if (np) {
 19d:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
 1a1:	74 18                	je     1bb <mm_scrub_pages+0xe4>
				rprintf(&kb_reg, "scrubbed %u pages\n", np);
 1a3:	83 ec 04             	sub    esp,0x4
 1a6:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
 1a9:	68 16 00 00 00       	push   0x16
 1ae:	68 00 00 00 00       	push   0x0
 1b3:	e8 fc ff ff ff       	call   1b4 <mm_scrub_pages+0xdd>
 1b8:	83 c4 10             	add    esp,0x10
		return np;
 1bb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
 1be:	c9                   	leave
 1bf:	c3                   	ret

000001c0 <mm_page_scrub>:
{
 1c0:	55                   	push   ebp
 1c1:	89 e5                	mov    ebp,esp
 1c3:	83 ec 18             	sub    esp,0x18
		size_t i, lm = 128;
 1c6:	c7 45 f0 80 00 00 00 	mov    DWORD PTR [ebp-0x10],0x80
		for (i = fm_begin; i < fm_ofs && lm; i++) {
 1cd:	a1 00 00 00 00       	mov    eax,ds:0x0
 1d2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
 1d5:	eb 18                	jmp    1ef <mm_page_scrub+0x2f>
				lm -= mm_scrub_pages(i, lm);
 1d7:	83 ec 08             	sub    esp,0x8
 1da:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
 1dd:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 1e0:	e8 fc ff ff ff       	call   1e1 <mm_page_scrub+0x21>
 1e5:	83 c4 10             	add    esp,0x10
 1e8:	29 45 f0             	sub    DWORD PTR [ebp-0x10],eax
		for (i = fm_begin; i < fm_ofs && lm; i++) {
 1eb:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
 1ef:	a1 00 00 00 00       	mov    eax,ds:0x0
 1f4:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
 1f7:	73 06                	jae    1ff <mm_page_scrub+0x3f>
 1f9:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
 1fd:	75 d8                	jne    1d7 <mm_page_scrub+0x17>
		return (lm != 128);
 1ff:	81 7d f0 80 00 00 00 	cmp    DWORD PTR [ebp-0x10],0x80
 206:	0f 95 c0             	setne  al
 209:	0f b6 c0             	movzx  eax,al
}
 20c:	c9                   	leave
 20d:	c3                   	ret
