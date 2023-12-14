
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
  17:	83 ec 58             	sub    esp,0x58
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
  5a:	c7 44 24 10 14 01 00 00 	mov    DWORD PTR [esp+0x10],0x114
  62:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
  6a:	8d 45 e4             	lea    eax,[ebp-0x1c]
  6d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
  71:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  74:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
  78:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
  7f:	e8 fc ff ff ff       	call   80 <mm_scrub_single_page+0x6c>
  84:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!map)
  87:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
  8b:	75 29                	jne    b6 <mm_scrub_single_page+0xa2>
				die("Unable to scrub!\n");
  8d:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
  95:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
  9c:	e8 fc ff ff ff       	call   9d <mm_scrub_single_page+0x89>
  a1:	e8 fc ff ff ff       	call   a2 <mm_scrub_single_page+0x8e>
  a6:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
  ad:	e8 fc ff ff ff       	call   ae <mm_scrub_single_page+0x9a>
  b2:	fa                   	cli
  b3:	f4                   	hlt
  b4:	eb fd                	jmp    b3 <mm_scrub_single_page+0x9f>
		bzero(map, 4096);
  b6:	c7 44 24 04 00 10 00 00 	mov    DWORD PTR [esp+0x4],0x1000
  be:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  c1:	89 04 24             	mov    DWORD PTR [esp],eax
  c4:	e8 fc ff ff ff       	call   c5 <mm_scrub_single_page+0xb1>
		mm_unmap(&mm_kernel, map, 1);
  c9:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
  d1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  d4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
  d8:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
  df:	e8 fc ff ff ff       	call   e0 <mm_scrub_single_page+0xcc>
}
  e4:	90                   	nop
  e5:	c9                   	leave
  e6:	c3                   	ret

000000e7 <mm_scrub_pages>:
{
  e7:	55                   	push   ebp
  e8:	89 e5                	mov    ebp,esp
  ea:	83 ec 48             	sub    esp,0x48
		size_t j, k, l, np = 0, npl = 0;
  ed:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
  f4:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (fmm[i].reclaimable_pages) {
  fb:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
 101:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 104:	6b c0 38             	imul   eax,eax,0x38
 107:	01 d0                	add    eax,edx
 109:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
 10c:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 10f:	89 c1                	mov    ecx,eax
 111:	89 c8                	mov    eax,ecx
 113:	09 d0                	or     eax,edx
 115:	0f 84 8f 00 00 00    	je     1aa <mm_scrub_pages+0xc3>
				uint64_t ofs = 0; size_t ct = 0;
 11b:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
 122:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
 129:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
				struct pmu* rc = (void*)fmm[i].rcp;
 130:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
 136:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 139:	6b c0 38             	imul   eax,eax,0x38
 13c:	01 d0                	add    eax,edx
 13e:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
 141:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
 144:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				struct pmu* pu = (void*)fmm[i].pmu;
 147:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
 14d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 150:	6b c0 38             	imul   eax,eax,0x38
 153:	01 d0                	add    eax,edx
 155:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
 158:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 15b:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				for (j = 0; j < 4; j++)
 15e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
 165:	eb 3d                	jmp    1a4 <mm_scrub_pages+0xbd>
						if (rc->free_ct[j]) { /* reclaimable count */
 167:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 16a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 16d:	0f b7 44 50 08       	movzx  eax,WORD PTR [eax+edx*2+0x8]
 172:	66 85 c0             	test   ax,ax
 175:	74 29                	je     1a0 <mm_scrub_pages+0xb9>
								die("iii");
 177:	c7 44 24 04 12 00 00 00 	mov    DWORD PTR [esp+0x4],0x12
 17f:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
 186:	e8 fc ff ff ff       	call   187 <mm_scrub_pages+0xa0>
 18b:	e8 fc ff ff ff       	call   18c <mm_scrub_pages+0xa5>
 190:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 197:	e8 fc ff ff ff       	call   198 <mm_scrub_pages+0xb1>
 19c:	fa                   	cli
 19d:	f4                   	hlt
 19e:	eb fd                	jmp    19d <mm_scrub_pages+0xb6>
				for (j = 0; j < 4; j++)
 1a0:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
 1a4:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
 1a8:	76 bd                	jbe    167 <mm_scrub_pages+0x80>
done:
 1aa:	90                   	nop
		if (np) {
 1ab:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
 1af:	74 1b                	je     1cc <mm_scrub_pages+0xe5>
				rprintf(&kb_reg, "scrubbed %u pages\n", np);
 1b1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 1b4:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 1b8:	c7 44 24 04 16 00 00 00 	mov    DWORD PTR [esp+0x4],0x16
 1c0:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 1c7:	e8 fc ff ff ff       	call   1c8 <mm_scrub_pages+0xe1>
		return np;
 1cc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
 1cf:	c9                   	leave
 1d0:	c3                   	ret

000001d1 <mm_page_scrub>:
{
 1d1:	55                   	push   ebp
 1d2:	89 e5                	mov    ebp,esp
 1d4:	83 ec 28             	sub    esp,0x28
		size_t i, lm = 128;
 1d7:	c7 45 f0 80 00 00 00 	mov    DWORD PTR [ebp-0x10],0x80
		for (i = fm_begin; i < fm_ofs && lm; i++) {
 1de:	a1 00 00 00 00       	mov    eax,ds:0x0
 1e3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
 1e6:	eb 19                	jmp    201 <mm_page_scrub+0x30>
				lm -= mm_scrub_pages(i, lm);
 1e8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 1eb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 1ef:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 1f2:	89 04 24             	mov    DWORD PTR [esp],eax
 1f5:	e8 fc ff ff ff       	call   1f6 <mm_page_scrub+0x25>
 1fa:	29 45 f0             	sub    DWORD PTR [ebp-0x10],eax
		for (i = fm_begin; i < fm_ofs && lm; i++) {
 1fd:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
 201:	a1 00 00 00 00       	mov    eax,ds:0x0
 206:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
 209:	73 06                	jae    211 <mm_page_scrub+0x40>
 20b:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
 20f:	75 d7                	jne    1e8 <mm_page_scrub+0x17>
		return (lm != 128);
 211:	81 7d f0 80 00 00 00 	cmp    DWORD PTR [ebp-0x10],0x80
 218:	0f 95 c0             	setne  al
 21b:	0f b6 c0             	movzx  eax,al
}
 21e:	c9                   	leave
 21f:	c3                   	ret
