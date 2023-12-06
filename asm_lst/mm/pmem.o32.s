
mm/pmem.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <mm_init_pmu>:
uint64_t pm_zero = 0;

/*************   PHYSICAL MEMORY ALLOCATION   *********************************/
/* returns nonzero if locked */
int mm_init_pmu(struct pmu* p)
{
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	57                   	push   edi
       4:	53                   	push   ebx
		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
       5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       8:	8d 50 0a             	lea    edx,[eax+0xa]
       b:	b8 ff ff ff ff       	mov    eax,0xffffffff
      10:	b9 fe ff ff ff       	mov    ecx,0xfffffffe
      15:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [edx],cx
      1a:	0f 94 c0             	sete   al
      1d:	83 f0 01             	xor    eax,0x1
      20:	84 c0                	test   al,al
      22:	74 07                	je     2b <mm_init_pmu+0x2b>
				return -1;
      24:	b8 ff ff ff ff       	mov    eax,0xffffffff
      29:	eb 66                	jmp    91 <mm_init_pmu+0x91>

		/* we're free to initialize (all full) */
		__builtin_memset(p->entries, 0xff, sizeof(p->entries));
      2b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      2e:	83 c0 10             	add    eax,0x10
      31:	b9 f0 0f 00 00       	mov    ecx,0xff0
      36:	bb ff ff ff ff       	mov    ebx,0xffffffff
      3b:	89 18                	mov    DWORD PTR [eax],ebx
      3d:	89 5c 08 fc          	mov    DWORD PTR [eax+ecx*1-0x4],ebx
      41:	8d 50 04             	lea    edx,[eax+0x4]
      44:	83 e2 fc             	and    edx,0xfffffffc
      47:	29 d0                	sub    eax,edx
      49:	01 c1                	add    ecx,eax
      4b:	83 e1 fc             	and    ecx,0xfffffffc
      4e:	c1 e9 02             	shr    ecx,0x2
      51:	89 d7                	mov    edi,edx
      53:	89 d8                	mov    eax,ebx
      55:	f3 ab                	rep stos DWORD PTR es:[edi],eax

		/* now release */
		bzero(p->locks, sizeof(p->locks));
      57:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      5a:	83 ec 08             	sub    esp,0x8
      5d:	6a 08                	push   0x8
      5f:	50                   	push   eax
      60:	e8 fc ff ff ff       	call   61 <mm_init_pmu+0x61>
      65:	83 c4 10             	add    esp,0x10
		p->free_ct[3] = 0;
      68:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      6b:	66 c7 40 0e 00 00    	mov    WORD PTR [eax+0xe],0x0
		p->free_ct[2] = 0;
      71:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      74:	66 c7 40 0c 00 00    	mov    WORD PTR [eax+0xc],0x0
		p->free_ct[1] = 0;
      7a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      7d:	66 c7 40 0a 00 00    	mov    WORD PTR [eax+0xa],0x0
		p->free_ct[0] = 0;
      83:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      86:	66 c7 40 08 00 00    	mov    WORD PTR [eax+0x8],0x0
		return 0;
      8c:	b8 00 00 00 00       	mov    eax,0x0
}
      91:	8d 65 f8             	lea    esp,[ebp-0x8]
      94:	5b                   	pop    ebx
      95:	5f                   	pop    edi
      96:	5d                   	pop    ebp
      97:	c3                   	ret

00000098 <mm_init_rcp>:

/* returns nonzero if locked */
int mm_init_rcp(struct pmu* p)
{
      98:	55                   	push   ebp
      99:	89 e5                	mov    ebp,esp
      9b:	57                   	push   edi
      9c:	53                   	push   ebx
      9d:	83 ec 20             	sub    esp,0x20
		uint16_t rem, fc[4] = { 4096, 4096, 4096, 4096 };
      a0:	66 c7 45 d8 00 10    	mov    WORD PTR [ebp-0x28],0x1000
      a6:	66 c7 45 da 00 10    	mov    WORD PTR [ebp-0x26],0x1000
      ac:	66 c7 45 dc 00 10    	mov    WORD PTR [ebp-0x24],0x1000
      b2:	66 c7 45 de 00 10    	mov    WORD PTR [ebp-0x22],0x1000

		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
      b8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      bb:	8d 50 0a             	lea    edx,[eax+0xa]
      be:	b8 ff ff ff ff       	mov    eax,0xffffffff
      c3:	b9 fe ff ff ff       	mov    ecx,0xfffffffe
      c8:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [edx],cx
      cd:	0f 94 c0             	sete   al
      d0:	83 f0 01             	xor    eax,0x1
      d3:	84 c0                	test   al,al
      d5:	74 0a                	je     e1 <mm_init_rcp+0x49>
				return -1;
      d7:	b8 ff ff ff ff       	mov    eax,0xffffffff
      dc:	e9 78 02 00 00       	jmp    359 <mm_init_rcp+0x2c1>

		/* check if last */
		rem = p->free_ct[3];
      e1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      e4:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
      e8:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax

		if (rem != 0xffff) {
      ec:	66 83 7d f6 ff       	cmp    WORD PTR [ebp-0xa],0xffff
      f1:	0f 84 f4 01 00 00    	je     2eb <mm_init_rcp+0x253>
				for (size_t i = 0; i < 4; i++) {
      f7:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
      fe:	e9 dc 01 00 00       	jmp    2df <mm_init_rcp+0x247>
						if (rem >= 4096) { /* still easy */
     103:	66 81 7d f6 ff 0f    	cmp    WORD PTR [ebp-0xa],0xfff
     109:	76 42                	jbe    14d <mm_init_rcp+0xb5>
								/* set everything reclaimable */
								__builtin_memset(&p->entries[i], 0xff,
     10b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     10e:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
     114:	8d 50 10             	lea    edx,[eax+0x10]
     117:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     11a:	01 d0                	add    eax,edx
     11c:	b9 fc 03 00 00       	mov    ecx,0x3fc
     121:	bb ff ff ff ff       	mov    ebx,0xffffffff
     126:	89 18                	mov    DWORD PTR [eax],ebx
     128:	89 5c 08 fc          	mov    DWORD PTR [eax+ecx*1-0x4],ebx
     12c:	8d 50 04             	lea    edx,[eax+0x4]
     12f:	83 e2 fc             	and    edx,0xfffffffc
     132:	29 d0                	sub    eax,edx
     134:	01 c1                	add    ecx,eax
     136:	83 e1 fc             	and    ecx,0xfffffffc
     139:	c1 e9 02             	shr    ecx,0x2
     13c:	89 d7                	mov    edi,edx
     13e:	89 d8                	mov    eax,ebx
     140:	f3 ab                	rep stos DWORD PTR es:[edi],eax
												sizeof(p->entries[i]));
								/* advance */
								rem -= 4096;
     142:	66 81 6d f6 00 10    	sub    WORD PTR [ebp-0xa],0x1000
     148:	e9 8e 01 00 00       	jmp    2db <mm_init_rcp+0x243>
						} else {
								/* fill partially (0, 2, 7) */
								for (uint16_t j = 0, of = 0; j < 128; of += 32, j++) {
     14d:	66 c7 45 ee 00 00    	mov    WORD PTR [ebp-0x12],0x0
     153:	66 c7 45 ec 00 00    	mov    WORD PTR [ebp-0x14],0x0
     159:	eb 6e                	jmp    1c9 <mm_init_rcp+0x131>
										uint32_t val = 0;
     15b:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
										if (rem > of) {
     162:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     166:	66 39 45 ec          	cmp    WORD PTR [ebp-0x14],ax
     16a:	73 31                	jae    19d <mm_init_rcp+0x105>
												if (rem - of >= 32) /* set full */
     16c:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     170:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
     174:	29 c2                	sub    edx,eax
     176:	83 fa 1f             	cmp    edx,0x1f
     179:	7e 09                	jle    184 <mm_init_rcp+0xec>
														val = 0xffffffff;
     17b:	c7 45 e8 ff ff ff ff 	mov    DWORD PTR [ebp-0x18],0xffffffff
     182:	eb 19                	jmp    19d <mm_init_rcp+0x105>
												else /* set partial */
														val = (1 << (rem - of)) - 1;
     184:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     188:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
     18c:	29 c2                	sub    edx,eax
     18e:	b8 01 00 00 00       	mov    eax,0x1
     193:	89 d1                	mov    ecx,edx
     195:	d3 e0                	shl    eax,cl
     197:	83 e8 01             	sub    eax,0x1
     19a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										}
										p->entries[i].lvl0[j] = val;
     19d:	0f b7 5d ee          	movzx  ebx,WORD PTR [ebp-0x12]
     1a1:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     1a4:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     1a7:	89 d0                	mov    eax,edx
     1a9:	c1 e0 08             	shl    eax,0x8
     1ac:	29 d0                	sub    eax,edx
     1ae:	01 d8                	add    eax,ebx
     1b0:	8d 50 04             	lea    edx,[eax+0x4]
     1b3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     1b6:	89 04 91             	mov    DWORD PTR [ecx+edx*4],eax
								for (uint16_t j = 0, of = 0; j < 128; of += 32, j++) {
     1b9:	66 83 45 ec 20       	add    WORD PTR [ebp-0x14],0x20
     1be:	0f b7 45 ee          	movzx  eax,WORD PTR [ebp-0x12]
     1c2:	83 c0 01             	add    eax,0x1
     1c5:	66 89 45 ee          	mov    WORD PTR [ebp-0x12],ax
     1c9:	66 83 7d ee 7f       	cmp    WORD PTR [ebp-0x12],0x7f
     1ce:	76 8b                	jbe    15b <mm_init_rcp+0xc3>
								}
								for (uint16_t j = 0, of = 0; j < 32; of += 128, j++) {
     1d0:	66 c7 45 e6 00 00    	mov    WORD PTR [ebp-0x1a],0x0
     1d6:	66 c7 45 e4 00 00    	mov    WORD PTR [ebp-0x1c],0x0
     1dc:	e9 9b 00 00 00       	jmp    27c <mm_init_rcp+0x1e4>
										uint32_t val = 0;
     1e1:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
										if (rem > of) {
     1e8:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     1ec:	66 39 45 e4          	cmp    WORD PTR [ebp-0x1c],ax
     1f0:	73 5b                	jae    24d <mm_init_rcp+0x1b5>
												if (rem - of >= 128)
     1f2:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     1f6:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     1fa:	29 c2                	sub    edx,eax
     1fc:	83 fa 7f             	cmp    edx,0x7f
     1ff:	7e 09                	jle    20a <mm_init_rcp+0x172>
														val = 0xffffffff;
     201:	c7 45 e0 ff ff ff ff 	mov    DWORD PTR [ebp-0x20],0xffffffff
     208:	eb 43                	jmp    24d <mm_init_rcp+0x1b5>
												else /* set partial */
														val = (1 << rdiv(rem - of, 4)) - 1;
     20a:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     20e:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     212:	29 c2                	sub    edx,eax
     214:	89 d0                	mov    eax,edx
     216:	8d 50 03             	lea    edx,[eax+0x3]
     219:	85 c0                	test   eax,eax
     21b:	0f 48 c2             	cmovs  eax,edx
     21e:	c1 f8 02             	sar    eax,0x2
     221:	89 c1                	mov    ecx,eax
     223:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     227:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     22b:	29 c2                	sub    edx,eax
     22d:	89 d0                	mov    eax,edx
     22f:	83 e0 03             	and    eax,0x3
     232:	85 c0                	test   eax,eax
     234:	0f 95 c0             	setne  al
     237:	0f b6 c0             	movzx  eax,al
     23a:	01 c8                	add    eax,ecx
     23c:	ba 01 00 00 00       	mov    edx,0x1
     241:	89 c1                	mov    ecx,eax
     243:	d3 e2                	shl    edx,cl
     245:	89 d0                	mov    eax,edx
     247:	83 e8 01             	sub    eax,0x1
     24a:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
										}
										p->entries[i].lvl2[j] = val;
     24d:	0f b7 5d e6          	movzx  ebx,WORD PTR [ebp-0x1a]
     251:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     254:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     257:	89 d0                	mov    eax,edx
     259:	c1 e0 08             	shl    eax,0x8
     25c:	29 d0                	sub    eax,edx
     25e:	01 d8                	add    eax,ebx
     260:	8d 90 c4 00 00 00    	lea    edx,[eax+0xc4]
     266:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     269:	89 04 91             	mov    DWORD PTR [ecx+edx*4],eax
								for (uint16_t j = 0, of = 0; j < 32; of += 128, j++) {
     26c:	66 83 6d e4 80       	sub    WORD PTR [ebp-0x1c],0xff80
     271:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
     275:	83 c0 01             	add    eax,0x1
     278:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
     27c:	66 83 7d e6 1f       	cmp    WORD PTR [ebp-0x1a],0x1f
     281:	0f 86 5a ff ff ff    	jbe    1e1 <mm_init_rcp+0x149>
								}
								p->entries[i].lvl7 = (1 << rdiv(rem, 32)) - 1;
     287:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     28b:	66 c1 e8 05          	shr    ax,0x5
     28f:	0f b7 d0             	movzx  edx,ax
     292:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     296:	83 e0 1f             	and    eax,0x1f
     299:	66 85 c0             	test   ax,ax
     29c:	0f 95 c0             	setne  al
     29f:	0f b6 c0             	movzx  eax,al
     2a2:	01 d0                	add    eax,edx
     2a4:	ba 01 00 00 00       	mov    edx,0x1
     2a9:	89 c1                	mov    ecx,eax
     2ab:	d3 e2                	shl    edx,cl
     2ad:	89 d0                	mov    eax,edx
     2af:	83 e8 01             	sub    eax,0x1
     2b2:	89 c1                	mov    ecx,eax
     2b4:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     2b7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2ba:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
     2c0:	01 d0                	add    eax,edx
     2c2:	05 08 04 00 00       	add    eax,0x408
     2c7:	89 08                	mov    DWORD PTR [eax],ecx

								/* advance */
								fc[i] = rem;
     2c9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2cc:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     2d0:	66 89 54 45 d8       	mov    WORD PTR [ebp+eax*2-0x28],dx
								rem = 0;
     2d5:	66 c7 45 f6 00 00    	mov    WORD PTR [ebp-0xa],0x0
				for (size_t i = 0; i < 4; i++) {
     2db:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     2df:	83 7d f0 03          	cmp    DWORD PTR [ebp-0x10],0x3
     2e3:	0f 86 1a fe ff ff    	jbe    103 <mm_init_rcp+0x6b>
     2e9:	eb 2c                	jmp    317 <mm_init_rcp+0x27f>
						}
				}
		} else /* very easy: everything is reclaimable */
				__builtin_memset(p->entries, 0xff, sizeof(p->entries));
     2eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2ee:	83 c0 10             	add    eax,0x10
     2f1:	b9 f0 0f 00 00       	mov    ecx,0xff0
     2f6:	bb ff ff ff ff       	mov    ebx,0xffffffff
     2fb:	89 18                	mov    DWORD PTR [eax],ebx
     2fd:	89 5c 08 fc          	mov    DWORD PTR [eax+ecx*1-0x4],ebx
     301:	8d 50 04             	lea    edx,[eax+0x4]
     304:	83 e2 fc             	and    edx,0xfffffffc
     307:	29 d0                	sub    eax,edx
     309:	01 c1                	add    ecx,eax
     30b:	83 e1 fc             	and    ecx,0xfffffffc
     30e:	c1 e9 02             	shr    ecx,0x2
     311:	89 d7                	mov    edi,edx
     313:	89 d8                	mov    eax,ebx
     315:	f3 ab                	rep stos DWORD PTR es:[edi],eax

		/* now release */
		bzero(p->locks, sizeof(p->locks));
     317:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     31a:	83 ec 08             	sub    esp,0x8
     31d:	6a 08                	push   0x8
     31f:	50                   	push   eax
     320:	e8 fc ff ff ff       	call   321 <mm_init_rcp+0x289>
     325:	83 c4 10             	add    esp,0x10
		p->free_ct[3] = fc[3];
     328:	0f b7 55 de          	movzx  edx,WORD PTR [ebp-0x22]
     32c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     32f:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
		p->free_ct[2] = fc[2];
     333:	0f b7 55 dc          	movzx  edx,WORD PTR [ebp-0x24]
     337:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     33a:	66 89 50 0c          	mov    WORD PTR [eax+0xc],dx
		p->free_ct[1] = fc[1];
     33e:	0f b7 55 da          	movzx  edx,WORD PTR [ebp-0x26]
     342:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     345:	66 89 50 0a          	mov    WORD PTR [eax+0xa],dx
		p->free_ct[0] = fc[0];
     349:	0f b7 55 d8          	movzx  edx,WORD PTR [ebp-0x28]
     34d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     350:	66 89 50 08          	mov    WORD PTR [eax+0x8],dx
		return 0;
     354:	b8 00 00 00 00       	mov    eax,0x0
}
     359:	8d 65 f8             	lea    esp,[ebp-0x8]
     35c:	5b                   	pop    ebx
     35d:	5f                   	pop    edi
     35e:	5d                   	pop    ebp
     35f:	c3                   	ret

00000360 <mm_pmue_get_range>:
/* assume caller know about locking and has made the right reservations
 * for us to operate freely on the range given by the limits. */
uint32_t mm_pmue_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bsir, uint64_t base)
{
     360:	55                   	push   ebp
     361:	89 e5                	mov    ebp,esp
     363:	53                   	push   ebx
     364:	83 ec 44             	sub    esp,0x44
     367:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
     36a:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
     36d:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
     370:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		uint32_t* bitfield, rv = 0;
     373:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0

		/* set the reference */
		switch (lvl) {
     37a:	83 7d 14 07          	cmp    DWORD PTR [ebp+0x14],0x7
     37e:	77 72                	ja     3f2 <mm_pmue_get_range+0x92>
     380:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     383:	c1 e0 02             	shl    eax,0x2
     386:	05 0c 00 00 00       	add    eax,0xc
     38b:	8b 00                	mov    eax,DWORD PTR [eax]
     38d:	ff e0                	jmp    eax
				case 7:
						bitfield = &p->lvl7;
     38f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     392:	05 f8 03 00 00       	add    eax,0x3f8
     397:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     39a:	eb 58                	jmp    3f4 <mm_pmue_get_range+0x94>
				case 6:
						bitfield = p->lvl6;
     39c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     39f:	05 f0 03 00 00       	add    eax,0x3f0
     3a4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3a7:	eb 4b                	jmp    3f4 <mm_pmue_get_range+0x94>
				case 5:
						bitfield = p->lvl5;
     3a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3ac:	05 e0 03 00 00       	add    eax,0x3e0
     3b1:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3b4:	eb 3e                	jmp    3f4 <mm_pmue_get_range+0x94>
				case 4:
						bitfield = p->lvl4;
     3b6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3b9:	05 c0 03 00 00       	add    eax,0x3c0
     3be:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3c1:	eb 31                	jmp    3f4 <mm_pmue_get_range+0x94>
				case 3:
						bitfield = p->lvl3;
     3c3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3c6:	05 80 03 00 00       	add    eax,0x380
     3cb:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3ce:	eb 24                	jmp    3f4 <mm_pmue_get_range+0x94>
				case 2:
						bitfield = p->lvl2;
     3d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3d3:	05 00 03 00 00       	add    eax,0x300
     3d8:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3db:	eb 17                	jmp    3f4 <mm_pmue_get_range+0x94>
				case 1:
						bitfield = p->lvl1;
     3dd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3e0:	05 00 02 00 00       	add    eax,0x200
     3e5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3e8:	eb 0a                	jmp    3f4 <mm_pmue_get_range+0x94>
				case 0:
						bitfield = p->lvl0;
     3ea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3ed:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3f0:	eb 02                	jmp    3f4 <mm_pmue_get_range+0x94>
				default:
						while (1);
     3f2:	eb fe                	jmp    3f2 <mm_pmue_get_range+0x92>
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
     3f4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     3f7:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     3fa:	e9 c7 01 00 00       	jmp    5c6 <mm_pmue_get_range+0x266>
				/* test each bit */
				asm goto("bt %0, %1\n"
     3ff:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     402:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     405:	0f a3 02             	bt     DWORD PTR [edx],eax
     408:	0f 82 a4 01 00 00    	jb     5b2 <mm_pmue_get_range+0x252>
						 "jc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : carry);

				/* we've got a free entry at i */
				if (lvl > 0) {
     40e:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     412:	0f 84 b7 00 00 00    	je     4cf <mm_pmue_get_range+0x16f>
						uint32_t rv2, prr = *n_pr, bs = 0;
     418:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     41b:	8b 00                	mov    eax,DWORD PTR [eax]
     41d:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     420:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
						/* go deeper */
						rv2 = mm_pmue_get_range(p, i * 2, i * 2 + 1,
     427:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     42a:	8d 58 ff             	lea    ebx,[eax-0x1]
     42d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     430:	01 c0                	add    eax,eax
     432:	8d 48 01             	lea    ecx,[eax+0x1]
     435:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     438:	8d 14 00             	lea    edx,[eax+eax*1]
     43b:	83 ec 04             	sub    esp,0x4
     43e:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
     441:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     444:	8d 45 cc             	lea    eax,[ebp-0x34]
     447:	50                   	push   eax
     448:	ff 75 24             	push   DWORD PTR [ebp+0x24]
     44b:	ff 75 20             	push   DWORD PTR [ebp+0x20]
     44e:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
     451:	ff 75 18             	push   DWORD PTR [ebp+0x18]
     454:	53                   	push   ebx
     455:	51                   	push   ecx
     456:	52                   	push   edx
     457:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     45a:	e8 fc ff ff ff       	call   45b <mm_pmue_get_range+0xfb>
     45f:	83 c4 30             	add    esp,0x30
     462:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
								lvl - 1, pg_ct, pr, pr_ct, n_pr, &bs, base);
						/* set counts */
						rv += rv2;
     465:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     468:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
     46b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     46e:	29 45 18             	sub    DWORD PTR [ebp+0x18],eax
						pr += *n_pr - prr;
     471:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     474:	8b 00                	mov    eax,DWORD PTR [eax]
     476:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
     479:	89 c2                	mov    edx,eax
     47b:	89 d0                	mov    eax,edx
     47d:	01 c0                	add    eax,eax
     47f:	01 d0                	add    eax,edx
     481:	c1 e0 02             	shl    eax,0x2
     484:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
						pr_ct -= *n_pr - prr;
     487:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     48a:	8b 00                	mov    eax,DWORD PTR [eax]
     48c:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     48f:	29 c2                	sub    edx,eax
     491:	01 55 20             	add    DWORD PTR [ebp+0x20],edx
						/* update by checking bits set in range */
						if (bs == 2) {
     494:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     497:	83 f8 02             	cmp    eax,0x2
     49a:	75 16                	jne    4b2 <mm_pmue_get_range+0x152>
								asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     49c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     49f:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     4a2:	0f ab 02             	bts    DWORD PTR [edx],eax
								(*bsir)++;
     4a5:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     4a8:	8b 00                	mov    eax,DWORD PTR [eax]
     4aa:	8d 50 01             	lea    edx,[eax+0x1]
     4ad:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     4b0:	89 10                	mov    DWORD PTR [eax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct & !rv2))
     4b2:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     4b6:	0f 84 16 01 00 00    	je     5d2 <mm_pmue_get_range+0x272>
     4bc:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     4bf:	0b 45 d0             	or     eax,DWORD PTR [ebp-0x30]
     4c2:	85 c0                	test   eax,eax
     4c4:	0f 84 08 01 00 00    	je     5d2 <mm_pmue_get_range+0x272>
						/* check for done */
						if (!pg_ct)
								break;

				}
				continue;
     4ca:	e9 f2 00 00 00       	jmp    5c1 <mm_pmue_get_range+0x261>
						uint64_t b = base + i * 4096, bp = 1;
     4cf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     4d2:	c1 e0 0c             	shl    eax,0xc
     4d5:	89 c1                	mov    ecx,eax
     4d7:	bb 00 00 00 00       	mov    ebx,0x0
     4dc:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     4df:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     4e2:	01 c8                	add    eax,ecx
     4e4:	11 da                	adc    edx,ebx
     4e6:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     4e9:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     4ec:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
     4f3:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     4fa:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     4fd:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     500:	0f ab 02             	bts    DWORD PTR [edx],eax
						if (*n_pr)
     503:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     506:	8b 00                	mov    eax,DWORD PTR [eax]
     508:	85 c0                	test   eax,eax
     50a:	74 26                	je     532 <mm_pmue_get_range+0x1d2>
								bp = pr[-1].base + 4096 * pr[-1].count;
     50c:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     50f:	83 e8 0c             	sub    eax,0xc
     512:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     515:	8b 00                	mov    eax,DWORD PTR [eax]
     517:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
     51a:	83 e9 0c             	sub    ecx,0xc
     51d:	8b 49 08             	mov    ecx,DWORD PTR [ecx+0x8]
     520:	c1 e1 0c             	shl    ecx,0xc
     523:	bb 00 00 00 00       	mov    ebx,0x0
     528:	01 c8                	add    eax,ecx
     52a:	11 da                	adc    edx,ebx
     52c:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     52f:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						if (b == bp)
     532:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     535:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     538:	89 c1                	mov    ecx,eax
     53a:	89 c8                	mov    eax,ecx
     53c:	33 45 e0             	xor    eax,DWORD PTR [ebp-0x20]
     53f:	33 55 e4             	xor    edx,DWORD PTR [ebp-0x1c]
     542:	09 d0                	or     eax,edx
     544:	75 11                	jne    557 <mm_pmue_get_range+0x1f7>
								pr[-1].count++;
     546:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     549:	83 e8 0c             	sub    eax,0xc
     54c:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     54f:	83 c2 01             	add    edx,0x1
     552:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
     555:	eb 3e                	jmp    595 <mm_pmue_get_range+0x235>
								if (!pr_ct) { /* rollback */
     557:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     55b:	75 0b                	jne    568 <mm_pmue_get_range+0x208>
										asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     55d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     560:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     563:	0f bb 02             	btc    DWORD PTR [edx],eax
										break;
     566:	eb 6a                	jmp    5d2 <mm_pmue_get_range+0x272>
								pr->base = b;
     568:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
     56b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     56e:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     571:	89 01                	mov    DWORD PTR [ecx],eax
     573:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								pr->count = 1;
     576:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     579:	c7 40 08 01 00 00 00 	mov    DWORD PTR [eax+0x8],0x1
								pr_ct--;
     580:	83 6d 20 01          	sub    DWORD PTR [ebp+0x20],0x1
								(*n_pr)++;
     584:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     587:	8b 00                	mov    eax,DWORD PTR [eax]
     589:	8d 50 01             	lea    edx,[eax+0x1]
     58c:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     58f:	89 10                	mov    DWORD PTR [eax],edx
								pr++;
     591:	83 45 1c 0c          	add    DWORD PTR [ebp+0x1c],0xc
						rv++;
     595:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
						pg_ct--;
     599:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
						(*bsir)++;
     59d:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     5a0:	8b 00                	mov    eax,DWORD PTR [eax]
     5a2:	8d 50 01             	lea    edx,[eax+0x1]
     5a5:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     5a8:	89 10                	mov    DWORD PTR [eax],edx
						if (!pg_ct)
     5aa:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     5ae:	75 11                	jne    5c1 <mm_pmue_get_range+0x261>
								break;
     5b0:	eb 20                	jmp    5d2 <mm_pmue_get_range+0x272>

carry:
				(*bsir)++;
     5b2:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     5b5:	8b 00                	mov    eax,DWORD PTR [eax]
     5b7:	8d 50 01             	lea    edx,[eax+0x1]
     5ba:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     5bd:	89 10                	mov    DWORD PTR [eax],edx
     5bf:	eb 01                	jmp    5c2 <mm_pmue_get_range+0x262>
				continue;
     5c1:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
     5c2:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     5c6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     5c9:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
     5cc:	0f 83 2d fe ff ff    	jae    3ff <mm_pmue_get_range+0x9f>
		}

		return rv;
     5d2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     5d5:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     5d8:	c9                   	leave
     5d9:	c3                   	ret

000005da <mm_rcpe_get_range>:

uint32_t mm_rcpe_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bfir, uint64_t base)
{
     5da:	55                   	push   ebp
     5db:	89 e5                	mov    ebp,esp
     5dd:	53                   	push   ebx
     5de:	83 ec 44             	sub    esp,0x44
     5e1:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
     5e4:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
     5e7:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
     5ea:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		uint32_t* bitfield, rv = 0;
     5ed:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0

		/* set the reference */
		switch (lvl) {
     5f4:	83 7d 14 07          	cmp    DWORD PTR [ebp+0x14],0x7
     5f8:	74 14                	je     60e <mm_rcpe_get_range+0x34>
     5fa:	83 7d 14 07          	cmp    DWORD PTR [ebp+0x14],0x7
     5fe:	77 32                	ja     632 <mm_rcpe_get_range+0x58>
     600:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     604:	74 22                	je     628 <mm_rcpe_get_range+0x4e>
     606:	83 7d 14 02          	cmp    DWORD PTR [ebp+0x14],0x2
     60a:	74 0f                	je     61b <mm_rcpe_get_range+0x41>
     60c:	eb 24                	jmp    632 <mm_rcpe_get_range+0x58>
				case 7:
						bitfield = &p->lvl7;
     60e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     611:	05 f8 03 00 00       	add    eax,0x3f8
     616:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     619:	eb 19                	jmp    634 <mm_rcpe_get_range+0x5a>
				case 2:
						bitfield = p->lvl2;
     61b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     61e:	05 00 03 00 00       	add    eax,0x300
     623:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     626:	eb 0c                	jmp    634 <mm_rcpe_get_range+0x5a>
				case 0:
						bitfield = p->lvl0;
     628:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     62b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     62e:	eb 04                	jmp    634 <mm_rcpe_get_range+0x5a>
     630:	eb 00                	jmp    632 <mm_rcpe_get_range+0x58>
				default:
						while (1);
     632:	eb fc                	jmp    630 <mm_rcpe_get_range+0x56>
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
     634:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     637:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     63a:	e9 05 02 00 00       	jmp    844 <mm_rcpe_get_range+0x26a>
				/* test each bit */
				asm goto("bt %0, %1\n"
     63f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     642:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     645:	0f a3 02             	bt     DWORD PTR [edx],eax
     648:	0f 83 e2 01 00 00    	jae    830 <mm_rcpe_get_range+0x256>
						 "jnc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : nocarry);

				/* we've got a reclaimable entry at i */
				if (lvl > 0) {
     64e:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     652:	0f 84 e4 00 00 00    	je     73c <mm_rcpe_get_range+0x162>
						uint32_t rv2, prr = *n_pr, bf = 0, mul;
     658:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     65b:	8b 00                	mov    eax,DWORD PTR [eax]
     65d:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     660:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
						mul = (lvl == 2) ? 4 : 32;
     667:	83 7d 14 02          	cmp    DWORD PTR [ebp+0x14],0x2
     66b:	75 07                	jne    674 <mm_rcpe_get_range+0x9a>
     66d:	b8 04 00 00 00       	mov    eax,0x4
     672:	eb 05                	jmp    679 <mm_rcpe_get_range+0x9f>
     674:	b8 20 00 00 00       	mov    eax,0x20
     679:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
						/* go deeper */
						rv2 = mm_rcpe_get_range(p, i * mul, (i + 1) * mul - 1,
     67c:	83 7d 14 02          	cmp    DWORD PTR [ebp+0x14],0x2
     680:	75 07                	jne    689 <mm_rcpe_get_range+0xaf>
     682:	bb 00 00 00 00       	mov    ebx,0x0
     687:	eb 05                	jmp    68e <mm_rcpe_get_range+0xb4>
     689:	bb 02 00 00 00       	mov    ebx,0x2
     68e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     691:	83 c0 01             	add    eax,0x1
     694:	0f af 45 d0          	imul   eax,DWORD PTR [ebp-0x30]
     698:	8d 48 ff             	lea    ecx,[eax-0x1]
     69b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     69e:	0f af 45 d0          	imul   eax,DWORD PTR [ebp-0x30]
     6a2:	83 ec 04             	sub    esp,0x4
     6a5:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
     6a8:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     6ab:	8d 55 c8             	lea    edx,[ebp-0x38]
     6ae:	52                   	push   edx
     6af:	ff 75 24             	push   DWORD PTR [ebp+0x24]
     6b2:	ff 75 20             	push   DWORD PTR [ebp+0x20]
     6b5:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
     6b8:	ff 75 18             	push   DWORD PTR [ebp+0x18]
     6bb:	53                   	push   ebx
     6bc:	51                   	push   ecx
     6bd:	50                   	push   eax
     6be:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     6c1:	e8 fc ff ff ff       	call   6c2 <mm_rcpe_get_range+0xe8>
     6c6:	83 c4 30             	add    esp,0x30
     6c9:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
								(lvl == 2) ? 0 : 2, pg_ct, pr, pr_ct, n_pr, &bf, base);
						/* set counts */
						rv += rv2;
     6cc:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     6cf:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
     6d2:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     6d5:	29 45 18             	sub    DWORD PTR [ebp+0x18],eax
						pr += *n_pr - prr;
     6d8:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     6db:	8b 00                	mov    eax,DWORD PTR [eax]
     6dd:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
     6e0:	89 c2                	mov    edx,eax
     6e2:	89 d0                	mov    eax,edx
     6e4:	01 c0                	add    eax,eax
     6e6:	01 d0                	add    eax,edx
     6e8:	c1 e0 02             	shl    eax,0x2
     6eb:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
						pr_ct -= *n_pr - prr;
     6ee:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     6f1:	8b 00                	mov    eax,DWORD PTR [eax]
     6f3:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     6f6:	29 c2                	sub    edx,eax
     6f8:	01 55 20             	add    DWORD PTR [ebp+0x20],edx
						/* update by checking bits free in range */
						if (bf == mul) {
     6fb:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     6fe:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
     701:	75 16                	jne    719 <mm_rcpe_get_range+0x13f>
								asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     703:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     706:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     709:	0f bb 02             	btc    DWORD PTR [edx],eax
								(*bfir)++;
     70c:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     70f:	8b 00                	mov    eax,DWORD PTR [eax]
     711:	8d 50 01             	lea    edx,[eax+0x1]
     714:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     717:	89 10                	mov    DWORD PTR [eax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct && !rv2))
     719:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     71d:	0f 84 2d 01 00 00    	je     850 <mm_rcpe_get_range+0x276>
     723:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     727:	0f 85 12 01 00 00    	jne    83f <mm_rcpe_get_range+0x265>
     72d:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
     731:	0f 84 19 01 00 00    	je     850 <mm_rcpe_get_range+0x276>
						mm_scrub_single_page(b);
						/* check for done */
						if (!pg_ct)
								break;
				}
				continue;
     737:	e9 03 01 00 00       	jmp    83f <mm_rcpe_get_range+0x265>
						uint64_t b = base + i * 4096, bp = 1;
     73c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     73f:	c1 e0 0c             	shl    eax,0xc
     742:	89 c1                	mov    ecx,eax
     744:	bb 00 00 00 00       	mov    ebx,0x0
     749:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     74c:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     74f:	01 c8                	add    eax,ecx
     751:	11 da                	adc    edx,ebx
     753:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     756:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     759:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
     760:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     767:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     76a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     76d:	0f bb 02             	btc    DWORD PTR [edx],eax
						if (*n_pr)
     770:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     773:	8b 00                	mov    eax,DWORD PTR [eax]
     775:	85 c0                	test   eax,eax
     777:	74 26                	je     79f <mm_rcpe_get_range+0x1c5>
								bp = pr[-1].base + 4096 * pr[-1].count;
     779:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     77c:	83 e8 0c             	sub    eax,0xc
     77f:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     782:	8b 00                	mov    eax,DWORD PTR [eax]
     784:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
     787:	83 e9 0c             	sub    ecx,0xc
     78a:	8b 49 08             	mov    ecx,DWORD PTR [ecx+0x8]
     78d:	c1 e1 0c             	shl    ecx,0xc
     790:	bb 00 00 00 00       	mov    ebx,0x0
     795:	01 c8                	add    eax,ecx
     797:	11 da                	adc    edx,ebx
     799:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     79c:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						if (b == bp)
     79f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     7a2:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     7a5:	89 c1                	mov    ecx,eax
     7a7:	89 c8                	mov    eax,ecx
     7a9:	33 45 e0             	xor    eax,DWORD PTR [ebp-0x20]
     7ac:	33 55 e4             	xor    edx,DWORD PTR [ebp-0x1c]
     7af:	09 d0                	or     eax,edx
     7b1:	75 11                	jne    7c4 <mm_rcpe_get_range+0x1ea>
								pr[-1].count++;
     7b3:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     7b6:	83 e8 0c             	sub    eax,0xc
     7b9:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     7bc:	83 c2 01             	add    edx,0x1
     7bf:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
     7c2:	eb 3e                	jmp    802 <mm_rcpe_get_range+0x228>
								if (!pr_ct) { /* rollback */
     7c4:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     7c8:	75 0b                	jne    7d5 <mm_rcpe_get_range+0x1fb>
										asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     7ca:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     7cd:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     7d0:	0f ab 02             	bts    DWORD PTR [edx],eax
										break;
     7d3:	eb 7b                	jmp    850 <mm_rcpe_get_range+0x276>
								pr->base = b;
     7d5:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
     7d8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     7db:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     7de:	89 01                	mov    DWORD PTR [ecx],eax
     7e0:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								pr->count = 1;
     7e3:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     7e6:	c7 40 08 01 00 00 00 	mov    DWORD PTR [eax+0x8],0x1
								pr_ct--;
     7ed:	83 6d 20 01          	sub    DWORD PTR [ebp+0x20],0x1
								(*n_pr)++;
     7f1:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     7f4:	8b 00                	mov    eax,DWORD PTR [eax]
     7f6:	8d 50 01             	lea    edx,[eax+0x1]
     7f9:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     7fc:	89 10                	mov    DWORD PTR [eax],edx
								pr++;
     7fe:	83 45 1c 0c          	add    DWORD PTR [ebp+0x1c],0xc
						rv++;
     802:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
						pg_ct--;
     806:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
						(*bfir)++;
     80a:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     80d:	8b 00                	mov    eax,DWORD PTR [eax]
     80f:	8d 50 01             	lea    edx,[eax+0x1]
     812:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     815:	89 10                	mov    DWORD PTR [eax],edx
						mm_scrub_single_page(b);
     817:	83 ec 08             	sub    esp,0x8
     81a:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
     81d:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
     820:	e8 fc ff ff ff       	call   821 <mm_rcpe_get_range+0x247>
     825:	83 c4 10             	add    esp,0x10
						if (!pg_ct)
     828:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     82c:	75 11                	jne    83f <mm_rcpe_get_range+0x265>
								break;
     82e:	eb 20                	jmp    850 <mm_rcpe_get_range+0x276>

nocarry:
				(*bfir)++;
     830:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     833:	8b 00                	mov    eax,DWORD PTR [eax]
     835:	8d 50 01             	lea    edx,[eax+0x1]
     838:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     83b:	89 10                	mov    DWORD PTR [eax],edx
     83d:	eb 01                	jmp    840 <mm_rcpe_get_range+0x266>
				continue;
     83f:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
     840:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     844:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     847:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
     84a:	0f 83 ef fd ff ff    	jae    63f <mm_rcpe_get_range+0x65>
		}

		return rv;
     850:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     853:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     856:	c9                   	leave
     857:	c3                   	ret

00000858 <mm_fmrc_get>:

/* is used to really set entries in a pmu/rcp */
uint32_t mm_fmrc_get(struct pmu* p, uint32_t idx, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr, uint64_t base)
{
     858:	55                   	push   ebp
     859:	89 e5                	mov    ebp,esp
     85b:	83 ec 48             	sub    esp,0x48
     85e:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     861:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
     864:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     867:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		size_t i; uint32_t msk = 0x00000003, rv = 0;
     86a:	c7 45 f0 03 00 00 00 	mov    DWORD PTR [ebp-0x10],0x3
     871:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		struct pmue* e = &p->entries[idx];
     878:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     87b:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
     881:	8d 50 10             	lea    edx,[eax+0x10]
     884:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     887:	01 d0                	add    eax,edx
     889:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		/* lock is 2 lvl7 bits wide (256 pages) so use it sparingly */

		/* first skip all full/empty lvl7 ranges (2 at a time) */
		uint32_t prc = 0;
     88c:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
		for (i = 0; i < 16; i++) {
     893:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     89a:	e9 5e 01 00 00       	jmp    9fd <mm_fmrc_get+0x1a5>
				uint8_t bt = ((e->lvl7 & msk) >> 2 * i);
     89f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     8a2:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [eax+0x3f8]
     8a8:	23 45 f0             	and    eax,DWORD PTR [ebp-0x10]
     8ab:	89 c2                	mov    edx,eax
     8ad:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8b0:	01 c0                	add    eax,eax
     8b2:	89 c1                	mov    ecx,eax
     8b4:	d3 ea                	shr    edx,cl
     8b6:	89 d0                	mov    eax,edx
     8b8:	88 45 e3             	mov    BYTE PTR [ebp-0x1d],al
				if (free ? (bt != 3) : (bt)) { /* all set/unset */
     8bb:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     8bf:	74 09                	je     8ca <mm_fmrc_get+0x72>
     8c1:	80 7d e3 03          	cmp    BYTE PTR [ebp-0x1d],0x3
     8c5:	0f 95 c0             	setne  al
     8c8:	eb 07                	jmp    8d1 <mm_fmrc_get+0x79>
     8ca:	80 7d e3 00          	cmp    BYTE PTR [ebp-0x1d],0x0
     8ce:	0f 95 c0             	setne  al
     8d1:	84 c0                	test   al,al
     8d3:	0f 84 1b 01 00 00    	je     9f4 <mm_fmrc_get+0x19c>
						uint32_t rv2 = 0, pcc = prc, bsir = 0;
     8d9:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     8e0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     8e3:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     8e6:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
						/* some bits set: try to lock */
						asm goto("lock bts %0, %1\n"
							"jc %l2\n" : : "r" (idx * 16 + 2 * i),
     8ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8f0:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     8f7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8fa:	01 d0                	add    eax,edx
     8fc:	8d 14 00             	lea    edx,[eax+eax*1]
						asm goto("lock bts %0, %1\n"
     8ff:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     902:	f0 0f ab 10          	lock bts DWORD PTR [eax],edx
     906:	0f 82 e9 00 00 00    	jb     9f5 <mm_fmrc_get+0x19d>
							"m" (*p->locks) : "cc" : carry);

						/* we hold the lock (else jump to carry) */
						if (free)
     90c:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     910:	74 3c                	je     94e <mm_fmrc_get+0xf6>
								rv2 = mm_pmue_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
     912:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     915:	01 c0                	add    eax,eax
     917:	8d 48 01             	lea    ecx,[eax+0x1]
     91a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     91d:	8d 14 00             	lea    edx,[eax+eax*1]
     920:	83 ec 04             	sub    esp,0x4
     923:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
     926:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     929:	8d 45 d4             	lea    eax,[ebp-0x2c]
     92c:	50                   	push   eax
     92d:	8d 45 d8             	lea    eax,[ebp-0x28]
     930:	50                   	push   eax
     931:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
     934:	ff 75 18             	push   DWORD PTR [ebp+0x18]
     937:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     93a:	6a 07                	push   0x7
     93c:	51                   	push   ecx
     93d:	52                   	push   edx
     93e:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     941:	e8 fc ff ff ff       	call   942 <mm_fmrc_get+0xea>
     946:	83 c4 30             	add    esp,0x30
     949:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     94c:	eb 3a                	jmp    988 <mm_fmrc_get+0x130>
										pr, pr_ct, &prc, &bsir, base);
						else
								rv2 = mm_rcpe_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
     94e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     951:	01 c0                	add    eax,eax
     953:	8d 48 01             	lea    ecx,[eax+0x1]
     956:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     959:	8d 14 00             	lea    edx,[eax+eax*1]
     95c:	83 ec 04             	sub    esp,0x4
     95f:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
     962:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     965:	8d 45 d4             	lea    eax,[ebp-0x2c]
     968:	50                   	push   eax
     969:	8d 45 d8             	lea    eax,[ebp-0x28]
     96c:	50                   	push   eax
     96d:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
     970:	ff 75 18             	push   DWORD PTR [ebp+0x18]
     973:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     976:	6a 07                	push   0x7
     978:	51                   	push   ecx
     979:	52                   	push   edx
     97a:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     97d:	e8 fc ff ff ff       	call   97e <mm_fmrc_get+0x126>
     982:	83 c4 30             	add    esp,0x30
     985:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										pr, pr_ct, &prc, &bsir, base);
						pr_ct -= prc - pcc;
     988:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     98b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     98e:	29 c2                	sub    edx,eax
     990:	01 55 1c             	add    DWORD PTR [ebp+0x1c],edx
						pr += prc - pcc;
     993:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     996:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
     999:	89 c2                	mov    edx,eax
     99b:	89 d0                	mov    eax,edx
     99d:	01 c0                	add    eax,eax
     99f:	01 d0                	add    eax,edx
     9a1:	c1 e0 02             	shl    eax,0x2
     9a4:	01 45 18             	add    DWORD PTR [ebp+0x18],eax
						*n_pr += prc - pcc;
     9a7:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     9aa:	8b 10                	mov    edx,DWORD PTR [eax]
     9ac:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     9af:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
     9b2:	01 c2                	add    edx,eax
     9b4:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     9b7:	89 10                	mov    DWORD PTR [eax],edx
						rv += rv2;
     9b9:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     9bc:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
						pg_ct -= rv2;
     9bf:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     9c2:	29 45 10             	sub    DWORD PTR [ebp+0x10],eax

						/* release lock */
						asm("btr %0, %1\n" : : "r" (idx * 16 + 2 * i),
     9c5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9c8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     9cf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9d2:	01 d0                	add    eax,edx
     9d4:	8d 14 00             	lea    edx,[eax+eax*1]
     9d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9da:	0f b3 10             	btr    DWORD PTR [eax],edx
							"m" (*p->locks) : "cc");

						if (!pg_ct || (!pr_ct && !rv2))
     9dd:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     9e1:	74 0c                	je     9ef <mm_fmrc_get+0x197>
     9e3:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
     9e7:	75 0c                	jne    9f5 <mm_fmrc_get+0x19d>
     9e9:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     9ed:	75 06                	jne    9f5 <mm_fmrc_get+0x19d>
								return rv;
     9ef:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     9f2:	eb 16                	jmp    a0a <mm_fmrc_get+0x1b2>
				}
carry:
     9f4:	90                   	nop
				/* advance */
				msk <<= 2;
     9f5:	c1 65 f0 02          	shl    DWORD PTR [ebp-0x10],0x2
		for (i = 0; i < 16; i++) {
     9f9:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     9fd:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
     a01:	0f 86 98 fe ff ff    	jbe    89f <mm_fmrc_get+0x47>
		}

		return rv;
     a07:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
     a0a:	c9                   	leave
     a0b:	c3                   	ret

00000a0c <mm_fmrc_alloc_pm>:

/* used for getting pages which are marked as free/reclaimable */
uint32_t mm_fmrc_alloc_pm(struct fme* fm, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr)
{
     a0c:	55                   	push   ebp
     a0d:	89 e5                	mov    ebp,esp
     a0f:	53                   	push   ebx
     a10:	83 ec 34             	sub    esp,0x34
		uint32_t rv = 0; uint64_t base = fm->base;
     a13:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     a1a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a1d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     a20:	8b 00                	mov    eax,DWORD PTR [eax]
     a22:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     a25:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		size_t i, j; uint64_t mem = (free ? fm->pmu : fm->rcp);
     a28:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     a2c:	74 0b                	je     a39 <mm_fmrc_alloc_pm+0x2d>
     a2e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a31:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
     a34:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     a37:	eb 09                	jmp    a42 <mm_fmrc_alloc_pm+0x36>
     a39:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a3c:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
     a3f:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
     a42:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     a45:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx

		for (i = 0; i < fm->ec; i++) {
     a48:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
     a4f:	e9 1b 01 00 00       	jmp    b6f <mm_fmrc_alloc_pm+0x163>
				struct pmu* p = (void*)(size_t)mem;
     a54:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     a57:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				/* skip if above limit */
				/*if (mem + 4096 > 0x100000000)
						break; - no idea what that was */ 

				/* operate on pmu/rcp */
				if (p->free_ct[0] == 0xffff) {
     a5a:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     a5d:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
     a61:	66 83 f8 ff          	cmp    ax,0xffff
     a65:	75 33                	jne    a9a <mm_fmrc_alloc_pm+0x8e>
						if (free) {
     a67:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     a6b:	74 17                	je     a84 <mm_fmrc_alloc_pm+0x78>
								if (mm_init_pmu(p))
     a6d:	83 ec 0c             	sub    esp,0xc
     a70:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     a73:	e8 fc ff ff ff       	call   a74 <mm_fmrc_alloc_pm+0x68>
     a78:	83 c4 10             	add    esp,0x10
     a7b:	85 c0                	test   eax,eax
     a7d:	74 1b                	je     a9a <mm_fmrc_alloc_pm+0x8e>
										continue; /* if locked */
     a7f:	e9 e7 00 00 00       	jmp    b6b <mm_fmrc_alloc_pm+0x15f>
						} else {
								if (mm_init_rcp(p))
     a84:	83 ec 0c             	sub    esp,0xc
     a87:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     a8a:	e8 fc ff ff ff       	call   a8b <mm_fmrc_alloc_pm+0x7f>
     a8f:	83 c4 10             	add    esp,0x10
     a92:	85 c0                	test   eax,eax
     a94:	0f 85 d0 00 00 00    	jne    b6a <mm_fmrc_alloc_pm+0x15e>
										continue; /* if locked */
						}
				}

				/* check for free/reclaimable counts */
				for (j = 0; j < 4; j++) {
     a9a:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
     aa1:	e9 b8 00 00 00       	jmp    b5e <mm_fmrc_alloc_pm+0x152>
						if (p->free_ct[j] > 0) {
     aa6:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     aa9:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     aac:	0f b7 44 50 08       	movzx  eax,WORD PTR [eax+edx*2+0x8]
     ab1:	66 85 c0             	test   ax,ax
     ab4:	0f 84 95 00 00 00    	je     b4f <mm_fmrc_alloc_pm+0x143>
								uint32_t rv2, np = 0;
     aba:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
								/* operate on lock */
								rv2 = mm_fmrc_get(p, j, pg_ct, free, pr,
     ac1:	83 ec 0c             	sub    esp,0xc
     ac4:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     ac7:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
     aca:	8d 45 cc             	lea    eax,[ebp-0x34]
     acd:	50                   	push   eax
     ace:	ff 75 18             	push   DWORD PTR [ebp+0x18]
     ad1:	ff 75 14             	push   DWORD PTR [ebp+0x14]
     ad4:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     ad7:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     ada:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     add:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     ae0:	e8 fc ff ff ff       	call   ae1 <mm_fmrc_alloc_pm+0xd5>
     ae5:	83 c4 30             	add    esp,0x30
     ae8:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
												pr_ct, &np, base);

								*n_pr += np;
     aeb:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     aee:	8b 10                	mov    edx,DWORD PTR [eax]
     af0:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     af3:	01 c2                	add    edx,eax
     af5:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     af8:	89 10                	mov    DWORD PTR [eax],edx
								pr_ct -= np;
     afa:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     afd:	29 45 18             	sub    DWORD PTR [ebp+0x18],eax
								pr += np;
     b00:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     b03:	89 d0                	mov    eax,edx
     b05:	01 c0                	add    eax,eax
     b07:	01 d0                	add    eax,edx
     b09:	c1 e0 02             	shl    eax,0x2
     b0c:	01 45 14             	add    DWORD PTR [ebp+0x14],eax
								rv += rv2;
     b0f:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     b12:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
								pg_ct -= rv2;
     b15:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     b18:	29 45 0c             	sub    DWORD PTR [ebp+0xc],eax
								/* update count */
								p->free_ct[j] -= rv2;
     b1b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     b1e:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     b21:	0f b7 44 50 08       	movzx  eax,WORD PTR [eax+edx*2+0x8]
     b26:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     b29:	29 d0                	sub    eax,edx
     b2b:	89 c1                	mov    ecx,eax
     b2d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     b30:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     b33:	66 89 4c 50 08       	mov    WORD PTR [eax+edx*2+0x8],cx
								/* exit if done or list exhausted (and no extension) */
								if (!pg_ct || (!pr_ct && !rv2))
     b38:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     b3c:	74 0c                	je     b4a <mm_fmrc_alloc_pm+0x13e>
     b3e:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     b42:	75 0b                	jne    b4f <mm_fmrc_alloc_pm+0x143>
     b44:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
     b48:	75 05                	jne    b4f <mm_fmrc_alloc_pm+0x143>
										return rv;
     b4a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b4d:	eb 3e                	jmp    b8d <mm_fmrc_alloc_pm+0x181>
						}

						/* advance base */
						base += 4096 * 4096;
     b4f:	81 45 e8 00 00 00 01 	add    DWORD PTR [ebp-0x18],0x1000000
     b56:	83 55 ec 00          	adc    DWORD PTR [ebp-0x14],0x0
				for (j = 0; j < 4; j++) {
     b5a:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
     b5e:	83 7d e0 03          	cmp    DWORD PTR [ebp-0x20],0x3
     b62:	0f 86 3e ff ff ff    	jbe    aa6 <mm_fmrc_alloc_pm+0x9a>
     b68:	eb 01                	jmp    b6b <mm_fmrc_alloc_pm+0x15f>
										continue; /* if locked */
     b6a:	90                   	nop
		for (i = 0; i < fm->ec; i++) {
     b6b:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
     b6f:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     b72:	bb 00 00 00 00       	mov    ebx,0x0
     b77:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b7a:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
     b7d:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     b80:	39 c1                	cmp    ecx,eax
     b82:	19 d3                	sbb    ebx,edx
     b84:	0f 82 ca fe ff ff    	jb     a54 <mm_fmrc_alloc_pm+0x48>
				}
		}

		return rv;
     b8a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
     b8d:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     b90:	c9                   	leave
     b91:	c3                   	ret

00000b92 <mm_alloc_pm>:

uint32_t mm_alloc_pm(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct)
{
     b92:	55                   	push   ebp
     b93:	89 e5                	mov    ebp,esp
     b95:	56                   	push   esi
     b96:	53                   	push   ebx
     b97:	83 ec 30             	sub    esp,0x30
		size_t i; uint32_t rv = 0, r2 = 0, pr_o = 0;
     b9a:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     ba1:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     ba8:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0

retry:
		for (i = fm_begin; i < fm_ofs; i++) {
     baf:	a1 00 00 00 00       	mov    eax,ds:0x0
     bb4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     bb7:	e9 c1 01 00 00       	jmp    d7d <mm_alloc_pm+0x1eb>
				/* skip if scrubbing is needed */
				if (!r2 && !fmm[i].free_pages)
     bbc:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     bc0:	75 1f                	jne    be1 <mm_alloc_pm+0x4f>
     bc2:	ba 00 40 02 00       	mov    edx,0x24000
     bc7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     bca:	6b c0 38             	imul   eax,eax,0x38
     bcd:	01 d0                	add    eax,edx
     bcf:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     bd2:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     bd5:	89 c1                	mov    ecx,eax
     bd7:	89 c8                	mov    eax,ecx
     bd9:	09 d0                	or     eax,edx
     bdb:	0f 84 94 01 00 00    	je     d75 <mm_alloc_pm+0x1e3>
						continue;

				/* collect free pages */
				if (fmm[i].free_pages) {
     be1:	ba 00 40 02 00       	mov    edx,0x24000
     be6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     be9:	6b c0 38             	imul   eax,eax,0x38
     bec:	01 d0                	add    eax,edx
     bee:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     bf1:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     bf4:	89 c1                	mov    ecx,eax
     bf6:	89 c8                	mov    eax,ecx
     bf8:	09 d0                	or     eax,edx
     bfa:	0f 84 af 00 00 00    	je     caf <mm_alloc_pm+0x11d>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 1, pr + pr_o,
     c00:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     c03:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     c06:	89 d3                	mov    ebx,edx
     c08:	29 c3                	sub    ebx,eax
     c0a:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     c0d:	89 d0                	mov    eax,edx
     c0f:	01 c0                	add    eax,eax
     c11:	01 d0                	add    eax,edx
     c13:	c1 e0 02             	shl    eax,0x2
     c16:	89 c2                	mov    edx,eax
     c18:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c1b:	8d 0c 02             	lea    ecx,[edx+eax*1]
     c1e:	ba 00 40 02 00       	mov    edx,0x24000
     c23:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c26:	6b c0 38             	imul   eax,eax,0x38
     c29:	01 c2                	add    edx,eax
     c2b:	83 ec 08             	sub    esp,0x8
     c2e:	8d 45 e0             	lea    eax,[ebp-0x20]
     c31:	50                   	push   eax
     c32:	53                   	push   ebx
     c33:	51                   	push   ecx
     c34:	6a 01                	push   0x1
     c36:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     c39:	52                   	push   edx
     c3a:	e8 fc ff ff ff       	call   c3b <mm_alloc_pm+0xa9>
     c3f:	83 c4 20             	add    esp,0x20
     c42:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
     c45:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     c48:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
     c4b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     c4e:	29 45 08             	sub    DWORD PTR [ebp+0x8],eax
						__sync_sub_and_fetch(&fmm[i].free_pages, rv2);
     c51:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     c54:	ba 00 00 00 00       	mov    edx,0x0
     c59:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
     c5c:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
     c5f:	ba 00 40 02 00       	mov    edx,0x24000
     c64:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c67:	6b c0 38             	imul   eax,eax,0x38
     c6a:	01 d0                	add    eax,edx
     c6c:	8d 70 10             	lea    esi,[eax+0x10]
     c6f:	8b 06                	mov    eax,DWORD PTR [esi]
     c71:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
     c74:	89 c1                	mov    ecx,eax
     c76:	89 d3                	mov    ebx,edx
     c78:	2b 4d c8             	sub    ecx,DWORD PTR [ebp-0x38]
     c7b:	1b 5d cc             	sbb    ebx,DWORD PTR [ebp-0x34]
     c7e:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
     c81:	89 5d d4             	mov    DWORD PTR [ebp-0x2c],ebx
     c84:	8b 5d d0             	mov    ebx,DWORD PTR [ebp-0x30]
     c87:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     c8a:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
     c8e:	0f 94 c1             	sete   cl
     c91:	84 c9                	test   cl,cl
     c93:	74 df                	je     c74 <mm_alloc_pm+0xe2>
						if (pg_ct && !r2) /* skip scrub for now */
     c95:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     c99:	74 0a                	je     ca5 <mm_alloc_pm+0x113>
     c9b:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     c9f:	0f 84 d3 00 00 00    	je     d78 <mm_alloc_pm+0x1e6>
								continue;
						else if (!pg_ct)
     ca5:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     ca9:	0f 84 f4 00 00 00    	je     da3 <mm_alloc_pm+0x211>
								goto done;
				}

				/* check for reclaimable */
				if (r2 && fmm[i].reclaimable_pages) {
     caf:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     cb3:	0f 84 c0 00 00 00    	je     d79 <mm_alloc_pm+0x1e7>
     cb9:	ba 00 40 02 00       	mov    edx,0x24000
     cbe:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     cc1:	6b c0 38             	imul   eax,eax,0x38
     cc4:	01 d0                	add    eax,edx
     cc6:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     cc9:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
     ccc:	89 c1                	mov    ecx,eax
     cce:	89 c8                	mov    eax,ecx
     cd0:	09 d0                	or     eax,edx
     cd2:	0f 84 a1 00 00 00    	je     d79 <mm_alloc_pm+0x1e7>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 0, pr + pr_o,
     cd8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     cdb:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     cde:	89 d3                	mov    ebx,edx
     ce0:	29 c3                	sub    ebx,eax
     ce2:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     ce5:	89 d0                	mov    eax,edx
     ce7:	01 c0                	add    eax,eax
     ce9:	01 d0                	add    eax,edx
     ceb:	c1 e0 02             	shl    eax,0x2
     cee:	89 c2                	mov    edx,eax
     cf0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     cf3:	8d 0c 02             	lea    ecx,[edx+eax*1]
     cf6:	ba 00 40 02 00       	mov    edx,0x24000
     cfb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     cfe:	6b c0 38             	imul   eax,eax,0x38
     d01:	01 c2                	add    edx,eax
     d03:	83 ec 08             	sub    esp,0x8
     d06:	8d 45 e0             	lea    eax,[ebp-0x20]
     d09:	50                   	push   eax
     d0a:	53                   	push   ebx
     d0b:	51                   	push   ecx
     d0c:	6a 00                	push   0x0
     d0e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     d11:	52                   	push   edx
     d12:	e8 fc ff ff ff       	call   d13 <mm_alloc_pm+0x181>
     d17:	83 c4 20             	add    esp,0x20
     d1a:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
     d1d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d20:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
     d23:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d26:	29 45 08             	sub    DWORD PTR [ebp+0x8],eax
						__sync_sub_and_fetch(&fmm[i].reclaimable_pages, rv2);
     d29:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d2c:	ba 00 00 00 00       	mov    edx,0x0
     d31:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
     d34:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
     d37:	ba 00 40 02 00       	mov    edx,0x24000
     d3c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d3f:	6b c0 38             	imul   eax,eax,0x38
     d42:	01 d0                	add    eax,edx
     d44:	8d 70 18             	lea    esi,[eax+0x18]
     d47:	8b 06                	mov    eax,DWORD PTR [esi]
     d49:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
     d4c:	89 c1                	mov    ecx,eax
     d4e:	89 d3                	mov    ebx,edx
     d50:	2b 4d c8             	sub    ecx,DWORD PTR [ebp-0x38]
     d53:	1b 5d cc             	sbb    ebx,DWORD PTR [ebp-0x34]
     d56:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
     d59:	89 5d d4             	mov    DWORD PTR [ebp-0x2c],ebx
     d5c:	8b 5d d0             	mov    ebx,DWORD PTR [ebp-0x30]
     d5f:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     d62:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
     d66:	0f 94 c1             	sete   cl
     d69:	84 c9                	test   cl,cl
     d6b:	74 df                	je     d4c <mm_alloc_pm+0x1ba>
						if (!pg_ct)
     d6d:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     d71:	74 33                	je     da6 <mm_alloc_pm+0x214>
     d73:	eb 04                	jmp    d79 <mm_alloc_pm+0x1e7>
						continue;
     d75:	90                   	nop
     d76:	eb 01                	jmp    d79 <mm_alloc_pm+0x1e7>
								continue;
     d78:	90                   	nop
		for (i = fm_begin; i < fm_ofs; i++) {
     d79:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     d7d:	a1 00 00 00 00       	mov    eax,ds:0x0
     d82:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
     d85:	0f 82 31 fe ff ff    	jb     bbc <mm_alloc_pm+0x2a>
								goto done;
				}
		}

		/* scrub enabled */
		if (pg_ct && !r2) {
     d8b:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     d8f:	74 18                	je     da9 <mm_alloc_pm+0x217>
     d91:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     d95:	75 12                	jne    da9 <mm_alloc_pm+0x217>
				r2 = 1;
     d97:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
				goto retry;
     d9e:	e9 0c fe ff ff       	jmp    baf <mm_alloc_pm+0x1d>
								goto done;
     da3:	90                   	nop
     da4:	eb 04                	jmp    daa <mm_alloc_pm+0x218>
								goto done;
     da6:	90                   	nop
     da7:	eb 01                	jmp    daa <mm_alloc_pm+0x218>
		}

done:
     da9:	90                   	nop
		if (!rv) { /* OOM */
     daa:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     dae:	75 03                	jne    db3 <mm_alloc_pm+0x221>
				while (1);
     db0:	90                   	nop
     db1:	eb fd                	jmp    db0 <mm_alloc_pm+0x21e>
				die("OOM");
		}

		/* null-terminate */
		if (pr_o < pr_ct) {
     db3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     db6:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
     db9:	73 3a                	jae    df5 <mm_alloc_pm+0x263>
				pr[pr_o].base = 0;
     dbb:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     dbe:	89 d0                	mov    eax,edx
     dc0:	01 c0                	add    eax,eax
     dc2:	01 d0                	add    eax,edx
     dc4:	c1 e0 02             	shl    eax,0x2
     dc7:	89 c2                	mov    edx,eax
     dc9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     dcc:	01 d0                	add    eax,edx
     dce:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     dd4:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
				pr[pr_o].count = 0;
     ddb:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     dde:	89 d0                	mov    eax,edx
     de0:	01 c0                	add    eax,eax
     de2:	01 d0                	add    eax,edx
     de4:	c1 e0 02             	shl    eax,0x2
     de7:	89 c2                	mov    edx,eax
     de9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     dec:	01 d0                	add    eax,edx
     dee:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
		}
		return rv;
     df5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     df8:	8d 65 f8             	lea    esp,[ebp-0x8]
     dfb:	5b                   	pop    ebx
     dfc:	5e                   	pop    esi
     dfd:	5d                   	pop    ebp
     dfe:	c3                   	ret

00000dff <mm_alloc_pm_flg>:

/* rcp: higher-levels<=>Exists; pmu: higher-levels: completely used */
uint32_t mm_alloc_pm_flg(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct, int flg)
{
     dff:	55                   	push   ebp
     e00:	89 e5                	mov    ebp,esp
     e02:	83 ec 08             	sub    esp,0x8
		die("not implemented\n");
     e05:	83 ec 08             	sub    esp,0x8
     e08:	68 2c 00 00 00       	push   0x2c
     e0d:	6a 0c                	push   0xc
     e0f:	e8 fc ff ff ff       	call   e10 <mm_alloc_pm_flg+0x11>
     e14:	83 c4 10             	add    esp,0x10
     e17:	e8 fc ff ff ff       	call   e18 <mm_alloc_pm_flg+0x19>
     e1c:	83 ec 0c             	sub    esp,0xc
     e1f:	68 00 00 00 00       	push   0x0
     e24:	e8 fc ff ff ff       	call   e25 <mm_alloc_pm_flg+0x26>
     e29:	83 c4 10             	add    esp,0x10
     e2c:	fa                   	cli
     e2d:	f4                   	hlt
     e2e:	eb fd                	jmp    e2d <mm_alloc_pm_flg+0x2e>

00000e30 <psr.0>:

void pmue_set_range(struct pmue* e, uint16_t start, uint16_t end, int unset, int is_rcp)
{
		/* we also have to consider the values at the fringes,
		 * as start & end don't have to be perfectly aligned. */
		void psr(uint32_t* lv, uint32_t* pr, uint16_t div, uint16_t div2) {
     e30:	55                   	push   ebp
     e31:	89 e5                	mov    ebp,esp
     e33:	56                   	push   esi
     e34:	53                   	push   ebx
     e35:	83 ec 40             	sub    esp,0x40
     e38:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     e3b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     e3e:	66 89 55 c4          	mov    WORD PTR [ebp-0x3c],dx
     e42:	66 89 45 c0          	mov    WORD PTR [ebp-0x40],ax
     e46:	89 cb                	mov    ebx,ecx
     e48:	89 4d bc             	mov    DWORD PTR [ebp-0x44],ecx
				uint16_t i, j;
				if (pr) { /* align start & end to boundaries and set fringe values */
     e4b:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     e4f:	74 2b                	je     e7c <psr.0+0x4c>
						die("fringes!\n"); /* TODO: fix it */
     e51:	83 ec 08             	sub    esp,0x8
     e54:	68 3d 00 00 00       	push   0x3d
     e59:	6a 0c                	push   0xc
     e5b:	e8 fc ff ff ff       	call   e5c <psr.0+0x2c>
     e60:	83 c4 10             	add    esp,0x10
     e63:	e8 fc ff ff ff       	call   e64 <psr.0+0x34>
     e68:	83 ec 0c             	sub    esp,0xc
     e6b:	68 00 00 00 00       	push   0x0
     e70:	e8 fc ff ff ff       	call   e71 <psr.0+0x41>
     e75:	83 c4 10             	add    esp,0x10
     e78:	fa                   	cli
     e79:	f4                   	hlt
     e7a:	eb fd                	jmp    e79 <psr.0+0x49>
				}
				for (i = start / div; i <= end / div; i++) {
     e7c:	0f b7 43 06          	movzx  eax,WORD PTR [ebx+0x6]
     e80:	ba 00 00 00 00       	mov    edx,0x0
     e85:	66 f7 75 c4          	div    WORD PTR [ebp-0x3c]
     e89:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
     e8d:	e9 ab 02 00 00       	jmp    113d <psr.0+0x30d>
						int lwr = (i * div >= start); /* starts at bit0 */
     e92:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     e96:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
     e9a:	0f af d0             	imul   edx,eax
     e9d:	0f b7 43 06          	movzx  eax,WORD PTR [ebx+0x6]
     ea1:	0f b7 c0             	movzx  eax,ax
     ea4:	39 c2                	cmp    edx,eax
     ea6:	0f 9d c0             	setge  al
     ea9:	0f b6 c0             	movzx  eax,al
     eac:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						int hgr = (end - i * div >= div); /* goes until bit 31 */
     eaf:	0f b7 43 04          	movzx  eax,WORD PTR [ebx+0x4]
     eb3:	0f b7 c8             	movzx  ecx,ax
     eb6:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     eba:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
     ebe:	0f af c2             	imul   eax,edx
     ec1:	29 c1                	sub    ecx,eax
     ec3:	89 ca                	mov    edx,ecx
     ec5:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
     ec9:	39 c2                	cmp    edx,eax
     ecb:	0f 9d c0             	setge  al
     ece:	0f b6 c0             	movzx  eax,al
     ed1:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						if (lwr && hgr) {
     ed4:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     ed8:	74 2f                	je     f09 <psr.0+0xd9>
     eda:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     ede:	74 29                	je     f09 <psr.0+0xd9>
								lv[i] = unset ? 0 : 0xffffffff;
     ee0:	8b 03                	mov    eax,DWORD PTR [ebx]
     ee2:	85 c0                	test   eax,eax
     ee4:	74 07                	je     eed <psr.0+0xbd>
     ee6:	b9 00 00 00 00       	mov    ecx,0x0
     eeb:	eb 05                	jmp    ef2 <psr.0+0xc2>
     eed:	b9 ff ff ff ff       	mov    ecx,0xffffffff
     ef2:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     ef6:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     efd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f00:	01 d0                	add    eax,edx
     f02:	89 08                	mov    DWORD PTR [eax],ecx
								continue;
     f04:	e9 29 02 00 00       	jmp    1132 <psr.0+0x302>
						} else if (lwr) {
     f09:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     f0d:	0f 84 a0 00 00 00    	je     fb3 <psr.0+0x183>
								uint8_t bit = (end - i * div) * 32 / div + 1;
     f13:	0f b7 43 04          	movzx  eax,WORD PTR [ebx+0x4]
     f17:	0f b7 c8             	movzx  ecx,ax
     f1a:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     f1e:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
     f22:	0f af c2             	imul   eax,edx
     f25:	29 c1                	sub    ecx,eax
     f27:	89 ca                	mov    edx,ecx
     f29:	89 d0                	mov    eax,edx
     f2b:	c1 e0 05             	shl    eax,0x5
     f2e:	0f b7 75 c4          	movzx  esi,WORD PTR [ebp-0x3c]
     f32:	99                   	cdq
     f33:	f7 fe                	idiv   esi
     f35:	83 c0 01             	add    eax,0x1
     f38:	88 45 d3             	mov    BYTE PTR [ebp-0x2d],al
								uint32_t mask = (1 << bit) - 1;
     f3b:	0f b6 45 d3          	movzx  eax,BYTE PTR [ebp-0x2d]
     f3f:	ba 01 00 00 00       	mov    edx,0x1
     f44:	89 c1                	mov    ecx,eax
     f46:	d3 e2                	shl    edx,cl
     f48:	89 d0                	mov    eax,edx
     f4a:	83 e8 01             	sub    eax,0x1
     f4d:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
								lv[i] &= ~mask;
     f50:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     f54:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     f5b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f5e:	01 d0                	add    eax,edx
     f60:	8b 10                	mov    edx,DWORD PTR [eax]
     f62:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     f65:	f7 d0                	not    eax
     f67:	89 c1                	mov    ecx,eax
     f69:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     f6d:	8d 34 85 00 00 00 00 	lea    esi,[eax*4+0x0]
     f74:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f77:	01 f0                	add    eax,esi
     f79:	21 ca                	and    edx,ecx
     f7b:	89 10                	mov    DWORD PTR [eax],edx
								if (!unset)
     f7d:	8b 03                	mov    eax,DWORD PTR [ebx]
     f7f:	85 c0                	test   eax,eax
     f81:	0f 85 ab 01 00 00    	jne    1132 <psr.0+0x302>
										lv[i] |= mask;
     f87:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     f8b:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     f92:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f95:	01 d0                	add    eax,edx
     f97:	8b 00                	mov    eax,DWORD PTR [eax]
     f99:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     f9d:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
     fa4:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     fa7:	01 ca                	add    edx,ecx
     fa9:	0b 45 cc             	or     eax,DWORD PTR [ebp-0x34]
     fac:	89 02                	mov    DWORD PTR [edx],eax
     fae:	e9 7f 01 00 00       	jmp    1132 <psr.0+0x302>
						} else if (hgr) {
     fb3:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     fb7:	0f 84 9c 00 00 00    	je     1059 <psr.0+0x229>
								uint8_t bit = (start - i * div) * 32 / div;
     fbd:	0f b7 43 06          	movzx  eax,WORD PTR [ebx+0x6]
     fc1:	0f b7 c8             	movzx  ecx,ax
     fc4:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     fc8:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
     fcc:	0f af c2             	imul   eax,edx
     fcf:	29 c1                	sub    ecx,eax
     fd1:	89 ca                	mov    edx,ecx
     fd3:	89 d0                	mov    eax,edx
     fd5:	c1 e0 05             	shl    eax,0x5
     fd8:	0f b7 75 c4          	movzx  esi,WORD PTR [ebp-0x3c]
     fdc:	99                   	cdq
     fdd:	f7 fe                	idiv   esi
     fdf:	88 45 db             	mov    BYTE PTR [ebp-0x25],al
								uint32_t mask = ~((1 << bit) - 1);
     fe2:	0f b6 45 db          	movzx  eax,BYTE PTR [ebp-0x25]
     fe6:	ba 01 00 00 00       	mov    edx,0x1
     feb:	89 c1                	mov    ecx,eax
     fed:	d3 e2                	shl    edx,cl
     fef:	89 d0                	mov    eax,edx
     ff1:	f7 d8                	neg    eax
     ff3:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								lv[i] &= ~mask;
     ff6:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     ffa:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    1001:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1004:	01 d0                	add    eax,edx
    1006:	8b 10                	mov    edx,DWORD PTR [eax]
    1008:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    100b:	f7 d0                	not    eax
    100d:	89 c1                	mov    ecx,eax
    100f:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    1013:	8d 34 85 00 00 00 00 	lea    esi,[eax*4+0x0]
    101a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    101d:	01 f0                	add    eax,esi
    101f:	21 ca                	and    edx,ecx
    1021:	89 10                	mov    DWORD PTR [eax],edx
								if (!unset)
    1023:	8b 03                	mov    eax,DWORD PTR [ebx]
    1025:	85 c0                	test   eax,eax
    1027:	0f 85 05 01 00 00    	jne    1132 <psr.0+0x302>
										lv[i] |= mask;
    102d:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    1031:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    1038:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    103b:	01 d0                	add    eax,edx
    103d:	8b 00                	mov    eax,DWORD PTR [eax]
    103f:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    1043:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    104a:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    104d:	01 ca                	add    edx,ecx
    104f:	0b 45 d4             	or     eax,DWORD PTR [ebp-0x2c]
    1052:	89 02                	mov    DWORD PTR [edx],eax
    1054:	e9 d9 00 00 00       	jmp    1132 <psr.0+0x302>
						} else {
								/* in-between */
								uint8_t b1 = (end - i * div) * 32 / div + 1;
    1059:	0f b7 43 04          	movzx  eax,WORD PTR [ebx+0x4]
    105d:	0f b7 c8             	movzx  ecx,ax
    1060:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    1064:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
    1068:	0f af c2             	imul   eax,edx
    106b:	29 c1                	sub    ecx,eax
    106d:	89 ca                	mov    edx,ecx
    106f:	89 d0                	mov    eax,edx
    1071:	c1 e0 05             	shl    eax,0x5
    1074:	0f b7 75 c4          	movzx  esi,WORD PTR [ebp-0x3c]
    1078:	99                   	cdq
    1079:	f7 fe                	idiv   esi
    107b:	83 c0 01             	add    eax,0x1
    107e:	88 45 eb             	mov    BYTE PTR [ebp-0x15],al
								uint8_t b2 = (start - i * div) * 32 / div;
    1081:	0f b7 43 06          	movzx  eax,WORD PTR [ebx+0x6]
    1085:	0f b7 c8             	movzx  ecx,ax
    1088:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    108c:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
    1090:	0f af c2             	imul   eax,edx
    1093:	29 c1                	sub    ecx,eax
    1095:	89 ca                	mov    edx,ecx
    1097:	89 d0                	mov    eax,edx
    1099:	c1 e0 05             	shl    eax,0x5
    109c:	0f b7 75 c4          	movzx  esi,WORD PTR [ebp-0x3c]
    10a0:	99                   	cdq
    10a1:	f7 fe                	idiv   esi
    10a3:	88 45 ea             	mov    BYTE PTR [ebp-0x16],al
								uint32_t m1 = (1 << b1) - 1;
    10a6:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    10aa:	ba 01 00 00 00       	mov    edx,0x1
    10af:	89 c1                	mov    ecx,eax
    10b1:	d3 e2                	shl    edx,cl
    10b3:	89 d0                	mov    eax,edx
    10b5:	83 e8 01             	sub    eax,0x1
    10b8:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								uint32_t m2 = ~((1 << b2) - 1);
    10bb:	0f b6 45 ea          	movzx  eax,BYTE PTR [ebp-0x16]
    10bf:	ba 01 00 00 00       	mov    edx,0x1
    10c4:	89 c1                	mov    ecx,eax
    10c6:	d3 e2                	shl    edx,cl
    10c8:	89 d0                	mov    eax,edx
    10ca:	f7 d8                	neg    eax
    10cc:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								uint32_t mask = m1 & m2;
    10cf:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    10d2:	23 45 e0             	and    eax,DWORD PTR [ebp-0x20]
    10d5:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
								lv[i] &= ~mask;
    10d8:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    10dc:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    10e3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10e6:	01 d0                	add    eax,edx
    10e8:	8b 10                	mov    edx,DWORD PTR [eax]
    10ea:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    10ed:	f7 d0                	not    eax
    10ef:	89 c1                	mov    ecx,eax
    10f1:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    10f5:	8d 34 85 00 00 00 00 	lea    esi,[eax*4+0x0]
    10fc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10ff:	01 f0                	add    eax,esi
    1101:	21 ca                	and    edx,ecx
    1103:	89 10                	mov    DWORD PTR [eax],edx
								if (!unset)
    1105:	8b 03                	mov    eax,DWORD PTR [ebx]
    1107:	85 c0                	test   eax,eax
    1109:	75 27                	jne    1132 <psr.0+0x302>
										lv[i] |= mask;
    110b:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    110f:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    1116:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1119:	01 d0                	add    eax,edx
    111b:	8b 00                	mov    eax,DWORD PTR [eax]
    111d:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    1121:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    1128:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    112b:	01 ca                	add    edx,ecx
    112d:	0b 45 dc             	or     eax,DWORD PTR [ebp-0x24]
    1130:	89 02                	mov    DWORD PTR [edx],eax
				for (i = start / div; i <= end / div; i++) {
    1132:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    1136:	83 c0 01             	add    eax,0x1
    1139:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
    113d:	0f b7 43 04          	movzx  eax,WORD PTR [ebx+0x4]
    1141:	ba 00 00 00 00       	mov    edx,0x0
    1146:	66 f7 75 c4          	div    WORD PTR [ebp-0x3c]
    114a:	66 3b 45 f6          	cmp    ax,WORD PTR [ebp-0xa]
    114e:	0f 83 3e fd ff ff    	jae    e92 <psr.0+0x62>
						}
				}
		}
    1154:	90                   	nop
    1155:	90                   	nop
    1156:	8d 65 f8             	lea    esp,[ebp-0x8]
    1159:	5b                   	pop    ebx
    115a:	5e                   	pop    esi
    115b:	5d                   	pop    ebp
    115c:	c3                   	ret

0000115d <pmue_set_range>:
{
    115d:	55                   	push   ebp
    115e:	89 e5                	mov    ebp,esp
    1160:	53                   	push   ebx
    1161:	83 ec 24             	sub    esp,0x24
    1164:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1167:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    116a:	66 89 55 e4          	mov    WORD PTR [ebp-0x1c],dx
    116e:	66 89 45 e0          	mov    WORD PTR [ebp-0x20],ax
void pmue_set_range(struct pmue* e, uint16_t start, uint16_t end, int unset, int is_rcp)
    1172:	8d 45 08             	lea    eax,[ebp+0x8]
    1175:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1178:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    117c:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
    1180:	0f b7 45 e0          	movzx  eax,WORD PTR [ebp-0x20]
    1184:	66 89 45 f0          	mov    WORD PTR [ebp-0x10],ax
    1188:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    118b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		psr(e->lvl0, NULL, 32, 0);
    118e:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1191:	8d 45 ec             	lea    eax,[ebp-0x14]
    1194:	6a 00                	push   0x0
    1196:	6a 20                	push   0x20
    1198:	6a 00                	push   0x0
    119a:	52                   	push   edx
    119b:	89 c1                	mov    ecx,eax
    119d:	e8 8e fc ff ff       	call   e30 <psr.0>
    11a2:	83 c4 10             	add    esp,0x10
		if (!is_rcp)
    11a5:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    11a9:	75 1f                	jne    11ca <pmue_set_range+0x6d>
				psr(e->lvl1, e->lvl0, 64, 32);
    11ab:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    11ae:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11b1:	8d 88 00 02 00 00    	lea    ecx,[eax+0x200]
    11b7:	8d 45 ec             	lea    eax,[ebp-0x14]
    11ba:	6a 20                	push   0x20
    11bc:	6a 40                	push   0x40
    11be:	52                   	push   edx
    11bf:	51                   	push   ecx
    11c0:	89 c1                	mov    ecx,eax
    11c2:	e8 69 fc ff ff       	call   e30 <psr.0>
    11c7:	83 c4 10             	add    esp,0x10
		psr(e->lvl2, is_rcp ? e->lvl0 : e->lvl1, 128, is_rcp ? 32 : 64);
    11ca:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    11ce:	74 07                	je     11d7 <pmue_set_range+0x7a>
    11d0:	bb 20 00 00 00       	mov    ebx,0x20
    11d5:	eb 05                	jmp    11dc <pmue_set_range+0x7f>
    11d7:	bb 40 00 00 00       	mov    ebx,0x40
    11dc:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    11e0:	74 05                	je     11e7 <pmue_set_range+0x8a>
    11e2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11e5:	eb 08                	jmp    11ef <pmue_set_range+0x92>
    11e7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11ea:	05 00 02 00 00       	add    eax,0x200
    11ef:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    11f2:	8d 8a 00 03 00 00    	lea    ecx,[edx+0x300]
    11f8:	8d 55 ec             	lea    edx,[ebp-0x14]
    11fb:	53                   	push   ebx
    11fc:	68 80 00 00 00       	push   0x80
    1201:	50                   	push   eax
    1202:	51                   	push   ecx
    1203:	89 d1                	mov    ecx,edx
    1205:	e8 26 fc ff ff       	call   e30 <psr.0>
    120a:	83 c4 10             	add    esp,0x10
		if (!is_rcp) {
    120d:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    1211:	0f 85 ac 00 00 00    	jne    12c3 <pmue_set_range+0x166>
				psr(e->lvl3, e->lvl2, 256, 128);
    1217:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    121a:	8d 88 00 03 00 00    	lea    ecx,[eax+0x300]
    1220:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1223:	8d 90 80 03 00 00    	lea    edx,[eax+0x380]
    1229:	8d 45 ec             	lea    eax,[ebp-0x14]
    122c:	68 80 00 00 00       	push   0x80
    1231:	68 00 01 00 00       	push   0x100
    1236:	51                   	push   ecx
    1237:	52                   	push   edx
    1238:	89 c1                	mov    ecx,eax
    123a:	e8 f1 fb ff ff       	call   e30 <psr.0>
    123f:	83 c4 10             	add    esp,0x10
				psr(e->lvl4, e->lvl3, 512, 256);
    1242:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1245:	8d 88 80 03 00 00    	lea    ecx,[eax+0x380]
    124b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    124e:	8d 90 c0 03 00 00    	lea    edx,[eax+0x3c0]
    1254:	8d 45 ec             	lea    eax,[ebp-0x14]
    1257:	68 00 01 00 00       	push   0x100
    125c:	68 00 02 00 00       	push   0x200
    1261:	51                   	push   ecx
    1262:	52                   	push   edx
    1263:	89 c1                	mov    ecx,eax
    1265:	e8 c6 fb ff ff       	call   e30 <psr.0>
    126a:	83 c4 10             	add    esp,0x10
				psr(e->lvl5, e->lvl4, 1024, 512);
    126d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1270:	8d 88 c0 03 00 00    	lea    ecx,[eax+0x3c0]
    1276:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1279:	8d 90 e0 03 00 00    	lea    edx,[eax+0x3e0]
    127f:	8d 45 ec             	lea    eax,[ebp-0x14]
    1282:	68 00 02 00 00       	push   0x200
    1287:	68 00 04 00 00       	push   0x400
    128c:	51                   	push   ecx
    128d:	52                   	push   edx
    128e:	89 c1                	mov    ecx,eax
    1290:	e8 9b fb ff ff       	call   e30 <psr.0>
    1295:	83 c4 10             	add    esp,0x10
				psr(e->lvl6, e->lvl5, 2048, 1024);
    1298:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    129b:	8d 88 e0 03 00 00    	lea    ecx,[eax+0x3e0]
    12a1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12a4:	8d 90 f0 03 00 00    	lea    edx,[eax+0x3f0]
    12aa:	8d 45 ec             	lea    eax,[ebp-0x14]
    12ad:	68 00 04 00 00       	push   0x400
    12b2:	68 00 08 00 00       	push   0x800
    12b7:	51                   	push   ecx
    12b8:	52                   	push   edx
    12b9:	89 c1                	mov    ecx,eax
    12bb:	e8 70 fb ff ff       	call   e30 <psr.0>
    12c0:	83 c4 10             	add    esp,0x10
		}
		psr(&e->lvl7, is_rcp ? e->lvl2 : e->lvl6, 4096, is_rcp ? 128 : 2048);
    12c3:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    12c7:	74 07                	je     12d0 <pmue_set_range+0x173>
    12c9:	bb 80 00 00 00       	mov    ebx,0x80
    12ce:	eb 05                	jmp    12d5 <pmue_set_range+0x178>
    12d0:	bb 00 08 00 00       	mov    ebx,0x800
    12d5:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    12d9:	74 0a                	je     12e5 <pmue_set_range+0x188>
    12db:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12de:	05 00 03 00 00       	add    eax,0x300
    12e3:	eb 08                	jmp    12ed <pmue_set_range+0x190>
    12e5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12e8:	05 f0 03 00 00       	add    eax,0x3f0
    12ed:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    12f0:	8d 8a f8 03 00 00    	lea    ecx,[edx+0x3f8]
    12f6:	8d 55 ec             	lea    edx,[ebp-0x14]
    12f9:	53                   	push   ebx
    12fa:	68 00 10 00 00       	push   0x1000
    12ff:	50                   	push   eax
    1300:	51                   	push   ecx
    1301:	89 d1                	mov    ecx,edx
    1303:	e8 28 fb ff ff       	call   e30 <psr.0>
    1308:	83 c4 10             	add    esp,0x10
}
    130b:	90                   	nop
    130c:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    130f:	c9                   	leave
    1310:	c3                   	ret

00001311 <pmu_set_range>:

/* rcp: 7,2,0 set if any below; pmu all, set if all below are used */
void pmu_set_range(struct pmu* pm, uint16_t start, uint16_t end, int unset, int is_rcp)
{
    1311:	55                   	push   ebp
    1312:	89 e5                	mov    ebp,esp
    1314:	53                   	push   ebx
    1315:	83 ec 24             	sub    esp,0x24
    1318:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    131b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    131e:	66 89 55 e4          	mov    WORD PTR [ebp-0x1c],dx
    1322:	66 89 45 e0          	mov    WORD PTR [ebp-0x20],ax
		struct pmue* e; uint16_t fc = 0;
    1326:	66 c7 45 f6 00 00    	mov    WORD PTR [ebp-0xa],0x0
		/* we have to lock for keeping higher levels consistent 
		 * else we could do without as we own the ranges exclusively. */

redo:
		/* lock is 64 bit wide 4x16 (2 lvl7 bits per bit) */
		for (uint16_t i = start / 256; i <= end / 256; i++) {
    132c:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1330:	66 c1 e8 08          	shr    ax,0x8
    1334:	66 89 45 f4          	mov    WORD PTR [ebp-0xc],ax
    1338:	e9 1c 01 00 00       	jmp    1459 <pmu_set_range+0x148>
				uint16_t o = i * 256, p1, p2;
    133d:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    1341:	c1 e0 08             	shl    eax,0x8
    1344:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
				e = pm->entries + i / 16;
    1348:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    134b:	8d 50 10             	lea    edx,[eax+0x10]
    134e:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    1352:	66 c1 e8 04          	shr    ax,0x4
    1356:	0f b7 c0             	movzx  eax,ax
    1359:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
    135f:	01 d0                	add    eax,edx
    1361:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				/* first check if we can skip */
				if (is_rcp) {
    1364:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    1368:	74 2a                	je     1394 <pmu_set_range+0x83>
						if (unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
    136a:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    136e:	74 4d                	je     13bd <pmu_set_range+0xac>
    1370:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1373:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [eax+0x3f8]
    1379:	0f b7 55 f4          	movzx  edx,WORD PTR [ebp-0xc]
    137d:	83 e2 0f             	and    edx,0xf
    1380:	bb 03 00 00 00       	mov    ebx,0x3
    1385:	89 d1                	mov    ecx,edx
    1387:	d3 e3                	shl    ebx,cl
    1389:	89 da                	mov    edx,ebx
    138b:	39 d0                	cmp    eax,edx
    138d:	75 2e                	jne    13bd <pmu_set_range+0xac>
								continue; /* unsafe as lock was not
    138f:	e9 ba 00 00 00       	jmp    144e <pmu_set_range+0x13d>
						 * checked (could be set concurrently). But 
						 * this is not relevant as it'd be user error. */
				} else {
						if (!unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
    1394:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    1398:	75 23                	jne    13bd <pmu_set_range+0xac>
    139a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    139d:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [eax+0x3f8]
    13a3:	0f b7 55 f4          	movzx  edx,WORD PTR [ebp-0xc]
    13a7:	83 e2 0f             	and    edx,0xf
    13aa:	bb 03 00 00 00       	mov    ebx,0x3
    13af:	89 d1                	mov    ecx,edx
    13b1:	d3 e3                	shl    ebx,cl
    13b3:	89 da                	mov    edx,ebx
    13b5:	39 d0                	cmp    eax,edx
    13b7:	0f 84 90 00 00 00    	je     144d <pmu_set_range+0x13c>
								continue; /* already all set */
				}

				/* then try to acquire the lock */
				asm goto("lock bts %0, %1\n"
					"jc %l2\n" : : "r" (2 * i),
    13bd:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    13c1:	8d 14 00             	lea    edx,[eax+eax*1]
				asm goto("lock bts %0, %1\n"
    13c4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13c7:	f0 0f ab 10          	lock bts DWORD PTR [eax],edx
    13cb:	72 73                	jb     1440 <pmu_set_range+0x12f>
					"m" (*pm->locks) : "cc" : carry);
				/* calculate the range */
				p1 = max(o, start);
    13cd:	0f b7 55 e4          	movzx  edx,WORD PTR [ebp-0x1c]
    13d1:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
    13d5:	66 39 c2             	cmp    dx,ax
    13d8:	0f 43 c2             	cmovae eax,edx
    13db:	66 89 45 ea          	mov    WORD PTR [ebp-0x16],ax
				p2 = min(o + 256, end);
    13df:	0f b7 55 e0          	movzx  edx,WORD PTR [ebp-0x20]
    13e3:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
    13e7:	05 00 01 00 00       	add    eax,0x100
    13ec:	39 c2                	cmp    edx,eax
    13ee:	0f 4e c2             	cmovle eax,edx
    13f1:	66 89 45 e8          	mov    WORD PTR [ebp-0x18],ax
				p1 -= (i / 4) * 4096;
    13f5:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    13f9:	66 c1 e8 02          	shr    ax,0x2
    13fd:	c1 e0 0c             	shl    eax,0xc
    1400:	66 29 45 ea          	sub    WORD PTR [ebp-0x16],ax
				p2 -= (i / 4) * 4096;
    1404:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    1408:	66 c1 e8 02          	shr    ax,0x2
    140c:	c1 e0 0c             	shl    eax,0xc
    140f:	66 29 45 e8          	sub    WORD PTR [ebp-0x18],ax
				/* we now hold the lock so modify the acutal entry */
				pmue_set_range(e, p1, p2, unset, is_rcp);
    1413:	0f b7 55 e8          	movzx  edx,WORD PTR [ebp-0x18]
    1417:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
    141b:	83 ec 0c             	sub    esp,0xc
    141e:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    1421:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    1424:	52                   	push   edx
    1425:	50                   	push   eax
    1426:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    1429:	e8 fc ff ff ff       	call   142a <pmu_set_range+0x119>
    142e:	83 c4 20             	add    esp,0x20

				/* release it */
				asm("btr %0, %1\n" : : "r" (2 * i),
    1431:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    1435:	8d 14 00             	lea    edx,[eax+eax*1]
    1438:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    143b:	0f b3 10             	btr    DWORD PTR [eax],edx
					"m" (*pm->locks) : "cc");
				continue;
    143e:	eb 0e                	jmp    144e <pmu_set_range+0x13d>

carry: 			/* lock failed */
				fc++; /* set failure count and continue (retry later) */
    1440:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    1444:	83 c0 01             	add    eax,0x1
    1447:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
    144b:	eb 01                	jmp    144e <pmu_set_range+0x13d>
								continue; /* already all set */
    144d:	90                   	nop
		for (uint16_t i = start / 256; i <= end / 256; i++) {
    144e:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    1452:	83 c0 01             	add    eax,0x1
    1455:	66 89 45 f4          	mov    WORD PTR [ebp-0xc],ax
    1459:	0f b7 45 e0          	movzx  eax,WORD PTR [ebp-0x20]
    145d:	66 c1 e8 08          	shr    ax,0x8
    1461:	66 3b 45 f4          	cmp    ax,WORD PTR [ebp-0xc]
    1465:	0f 83 d2 fe ff ff    	jae    133d <pmu_set_range+0x2c>
		}

		if (fc) { /* busy loop as these locks are held for ns */
    146b:	66 83 7d f6 00       	cmp    WORD PTR [ebp-0xa],0x0
    1470:	74 0b                	je     147d <pmu_set_range+0x16c>
				fc = 0;
    1472:	66 c7 45 f6 00 00    	mov    WORD PTR [ebp-0xa],0x0
				goto redo;
    1478:	e9 af fe ff ff       	jmp    132c <pmu_set_range+0x1b>
		}
}
    147d:	90                   	nop
    147e:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1481:	c9                   	leave
    1482:	c3                   	ret

00001483 <mm_free_pm>:

void mm_free_pm(struct page_range* pr, uint32_t pr_ct)
{
    1483:	55                   	push   ebp
    1484:	89 e5                	mov    ebp,esp
    1486:	57                   	push   edi
    1487:	56                   	push   esi
    1488:	53                   	push   ebx
    1489:	83 ec 5c             	sub    esp,0x5c
		for (uint32_t i = 0; i < pr_ct; i++) {
    148c:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    1493:	e9 98 01 00 00       	jmp    1630 <mm_free_pm+0x1ad>
				struct fme* fm; struct pmu* rc;
				uint64_t ofs, fp, lp;
				for (fm = fmm + fm_begin; fm < fmm + fm_ofs; fm++)
    1498:	ba 00 40 02 00       	mov    edx,0x24000
    149d:	a1 00 00 00 00       	mov    eax,ds:0x0
    14a2:	6b c0 38             	imul   eax,eax,0x38
    14a5:	01 d0                	add    eax,edx
    14a7:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    14aa:	eb 41                	jmp    14ed <mm_free_pm+0x6a>
						if (pr->base >= fm->base && pr->base < fm->base + fm->size)
    14ac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14af:	8b 08                	mov    ecx,DWORD PTR [eax]
    14b1:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    14b4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    14b7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    14ba:	8b 00                	mov    eax,DWORD PTR [eax]
    14bc:	39 c1                	cmp    ecx,eax
    14be:	89 de                	mov    esi,ebx
    14c0:	19 d6                	sbb    esi,edx
    14c2:	72 25                	jb     14e9 <mm_free_pm+0x66>
    14c4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14c7:	8b 08                	mov    ecx,DWORD PTR [eax]
    14c9:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    14cc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    14cf:	8b 30                	mov    esi,DWORD PTR [eax]
    14d1:	8b 78 04             	mov    edi,DWORD PTR [eax+0x4]
    14d4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    14d7:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    14da:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    14dd:	01 f0                	add    eax,esi
    14df:	11 fa                	adc    edx,edi
    14e1:	39 c1                	cmp    ecx,eax
    14e3:	89 df                	mov    edi,ebx
    14e5:	19 d7                	sbb    edi,edx
    14e7:	72 1a                	jb     1503 <mm_free_pm+0x80>
				for (fm = fmm + fm_begin; fm < fmm + fm_ofs; fm++)
    14e9:	83 45 e0 38          	add    DWORD PTR [ebp-0x20],0x38
    14ed:	ba 00 40 02 00       	mov    edx,0x24000
    14f2:	a1 00 00 00 00       	mov    eax,ds:0x0
    14f7:	6b c0 38             	imul   eax,eax,0x38
    14fa:	01 d0                	add    eax,edx
    14fc:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    14ff:	72 ab                	jb     14ac <mm_free_pm+0x29>
    1501:	eb 01                	jmp    1504 <mm_free_pm+0x81>
								break; /* just assume integrity */
    1503:	90                   	nop
				ofs = pr->base - fm->base;
    1504:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1507:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    150a:	8b 00                	mov    eax,DWORD PTR [eax]
    150c:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    150f:	8b 59 04             	mov    ebx,DWORD PTR [ecx+0x4]
    1512:	8b 09                	mov    ecx,DWORD PTR [ecx]
    1514:	29 c8                	sub    eax,ecx
    1516:	19 da                	sbb    edx,ebx
    1518:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    151b:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				rc = (struct pmu*)fm->rcp;
    151e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1521:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    1524:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1527:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				/* set first and last page */
				fp = ofs / 4096;
    152a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    152d:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1530:	0f ac d0 0c          	shrd   eax,edx,0xc
    1534:	c1 ea 0c             	shr    edx,0xc
    1537:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    153a:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
				lp = fp + pr->count - 1;
    153d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1540:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1543:	89 c1                	mov    ecx,eax
    1545:	bb 00 00 00 00       	mov    ebx,0x0
    154a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    154d:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1550:	01 c8                	add    eax,ecx
    1552:	11 da                	adc    edx,ebx
    1554:	83 c0 ff             	add    eax,0xffffffff
    1557:	83 d2 ff             	adc    edx,0xffffffff
    155a:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    155d:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx

				for (uint32_t idx = fp / 4096 / 4; idx <= lp / 4096 / 4; idx++) {
    1560:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1563:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1566:	0f ac d0 0e          	shrd   eax,edx,0xe
    156a:	c1 ea 0e             	shr    edx,0xe
    156d:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1570:	e9 96 00 00 00       	jmp    160b <mm_free_pm+0x188>
						uint16_t s, e; uint64_t o = idx * 4096 * 4;
    1575:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1578:	c1 e0 0e             	shl    eax,0xe
    157b:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    157e:	c7 45 b4 00 00 00 00 	mov    DWORD PTR [ebp-0x4c],0x0
						/* get the limits */
						s = (fp > o ? fp - o : 0);
    1585:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1588:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    158b:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    158e:	39 45 b0             	cmp    DWORD PTR [ebp-0x50],eax
    1591:	19 d1                	sbb    ecx,edx
    1593:	73 10                	jae    15a5 <mm_free_pm+0x122>
    1595:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1598:	89 c2                	mov    edx,eax
    159a:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    159d:	89 c1                	mov    ecx,eax
    159f:	89 d0                	mov    eax,edx
    15a1:	29 c8                	sub    eax,ecx
    15a3:	eb 05                	jmp    15aa <mm_free_pm+0x127>
    15a5:	b8 00 00 00 00       	mov    eax,0x0
    15aa:	66 89 45 ae          	mov    WORD PTR [ebp-0x52],ax
						e = max(lp - o, 4096 * 4 - 1);
    15ae:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    15b1:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    15b4:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    15b7:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    15ba:	b9 ff 3f 00 00       	mov    ecx,0x3fff
    15bf:	bb 00 00 00 00       	mov    ebx,0x0
    15c4:	39 c8                	cmp    eax,ecx
    15c6:	89 d6                	mov    esi,edx
    15c8:	19 de                	sbb    esi,ebx
    15ca:	89 cf                	mov    edi,ecx
    15cc:	0f 43 f8             	cmovae edi,eax
    15cf:	89 7d a0             	mov    DWORD PTR [ebp-0x60],edi
    15d2:	0f 43 da             	cmovae ebx,edx
    15d5:	89 5d a4             	mov    DWORD PTR [ebp-0x5c],ebx
    15d8:	0f b7 45 a0          	movzx  eax,WORD PTR [ebp-0x60]
    15dc:	66 89 45 ac          	mov    WORD PTR [ebp-0x54],ax
						/* set the rcp */
						pmu_set_range(&rc[idx], s, e, 0, 1);
    15e0:	0f b7 55 ac          	movzx  edx,WORD PTR [ebp-0x54]
    15e4:	0f b7 45 ae          	movzx  eax,WORD PTR [ebp-0x52]
    15e8:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    15eb:	89 cb                	mov    ebx,ecx
    15ed:	c1 e3 0c             	shl    ebx,0xc
    15f0:	8b 4d cc             	mov    ecx,DWORD PTR [ebp-0x34]
    15f3:	01 d9                	add    ecx,ebx
    15f5:	83 ec 0c             	sub    esp,0xc
    15f8:	6a 01                	push   0x1
    15fa:	6a 00                	push   0x0
    15fc:	52                   	push   edx
    15fd:	50                   	push   eax
    15fe:	51                   	push   ecx
    15ff:	e8 fc ff ff ff       	call   1600 <mm_free_pm+0x17d>
    1604:	83 c4 20             	add    esp,0x20
				for (uint32_t idx = fp / 4096 / 4; idx <= lp / 4096 / 4; idx++) {
    1607:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
    160b:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    160e:	bb 00 00 00 00       	mov    ebx,0x0
    1613:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1616:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1619:	0f ac d0 0e          	shrd   eax,edx,0xe
    161d:	c1 ea 0e             	shr    edx,0xe
    1620:	39 c8                	cmp    eax,ecx
    1622:	89 d0                	mov    eax,edx
    1624:	19 d8                	sbb    eax,ebx
    1626:	0f 83 49 ff ff ff    	jae    1575 <mm_free_pm+0xf2>
		for (uint32_t i = 0; i < pr_ct; i++) {
    162c:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    1630:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1633:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    1636:	0f 82 5c fe ff ff    	jb     1498 <mm_free_pm+0x15>
				}
		}
}
    163c:	90                   	nop
    163d:	90                   	nop
    163e:	8d 65 f4             	lea    esp,[ebp-0xc]
    1641:	5b                   	pop    ebx
    1642:	5e                   	pop    esi
    1643:	5f                   	pop    edi
    1644:	5d                   	pop    ebp
    1645:	c3                   	ret

00001646 <mm_create_ctx>:
void *cur_pmu = VM_PMU_BASE, *cur_rcp = VM_RCP_BASE;
void* cur_percpu = VM_MM_PER_CPU_BASE;
struct mm mm_kernel; uint64_t pm_count = 0;

struct mm_cpu_ctx mm_create_ctx()
{
    1646:	55                   	push   ebp
    1647:	89 e5                	mov    ebp,esp
    1649:	83 ec 18             	sub    esp,0x18
		struct mm_cpu_ctx rv = {0};
    164c:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1653:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		rv.cur_mm = &mm_kernel;
    165a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		rv.scrub_page = __sync_fetch_and_add(&cur_percpu, 4096);
    1661:	b8 00 10 00 00       	mov    eax,0x1000
    1666:	f0 0f c1 05 00 00 00 00 	lock xadd DWORD PTR ds:0x0,eax
    166e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (cur_percpu >= VM_MM_PER_CPU_LIMIT) {
    1671:	a1 00 00 00 00       	mov    eax,ds:0x0
    1676:	3d ff ff ff fb       	cmp    eax,0xfbffffff
    167b:	76 2b                	jbe    16a8 <mm_create_ctx+0x62>
				die("Out of MM percpu context slots.\n");
    167d:	83 ec 08             	sub    esp,0x8
    1680:	68 48 00 00 00       	push   0x48
    1685:	6a 0c                	push   0xc
    1687:	e8 fc ff ff ff       	call   1688 <mm_create_ctx+0x42>
    168c:	83 c4 10             	add    esp,0x10
    168f:	e8 fc ff ff ff       	call   1690 <mm_create_ctx+0x4a>
    1694:	83 ec 0c             	sub    esp,0xc
    1697:	68 00 00 00 00       	push   0x0
    169c:	e8 fc ff ff ff       	call   169d <mm_create_ctx+0x57>
    16a1:	83 c4 10             	add    esp,0x10
    16a4:	fa                   	cli
    16a5:	f4                   	hlt
    16a6:	eb fd                	jmp    16a5 <mm_create_ctx+0x5f>
		}
		return rv;
    16a8:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    16ab:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    16ae:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    16b1:	89 01                	mov    DWORD PTR [ecx],eax
    16b3:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
}
    16b6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16b9:	c9                   	leave
    16ba:	c2 04 00             	ret    0x4

000016bd <mm_fm_init>:
/* full mapping & init of high elements */
void mm_fm_init(struct fme* fm)
{
    16bd:	55                   	push   ebp
    16be:	89 e5                	mov    ebp,esp
    16c0:	57                   	push   edi
    16c1:	56                   	push   esi
    16c2:	53                   	push   ebx
    16c3:	83 ec 5c             	sub    esp,0x5c
		uint64_t b = fm->base - 2 * fm->ec * 4096, b1;
    16c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16c9:	8b 08                	mov    ecx,DWORD PTR [eax]
    16cb:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    16ce:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16d1:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    16d4:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    16d7:	0f a4 c2 0d          	shld   edx,eax,0xd
    16db:	c1 e0 0d             	shl    eax,0xd
    16de:	89 c6                	mov    esi,eax
    16e0:	89 d7                	mov    edi,edx
    16e2:	89 c8                	mov    eax,ecx
    16e4:	89 da                	mov    edx,ebx
    16e6:	29 f0                	sub    eax,esi
    16e8:	19 fa                	sbb    edx,edi
    16ea:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    16ed:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		uint64_t ec2 = (uint64_t)fm->ec; b1 = b + fm->ec * 4096;
    16f0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16f3:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    16f6:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    16f9:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    16fc:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
    16ff:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1702:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1705:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1708:	0f a4 c2 0c          	shld   edx,eax,0xc
    170c:	c1 e0 0c             	shl    eax,0xc
    170f:	89 c1                	mov    ecx,eax
    1711:	89 d3                	mov    ebx,edx
    1713:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1716:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1719:	01 c8                	add    eax,ecx
    171b:	11 da                	adc    edx,ebx
    171d:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1720:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		struct pmu *p, *r; struct page_range pr; uint16_t rec;
		uint32_t lst = 0;
    1723:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0

		/* get the limit */
		rec = (fm->size / 4096) % 16384;
    172a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    172d:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1730:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1733:	0f ac d0 0c          	shrd   eax,edx,0xc
    1737:	c1 ea 0c             	shr    edx,0xc
    173a:	66 25 ff 3f          	and    ax,0x3fff
    173e:	66 89 45 b6          	mov    WORD PTR [ebp-0x4a],ax
		if (rec)
    1742:	66 83 7d b6 00       	cmp    WORD PTR [ebp-0x4a],0x0
    1747:	74 13                	je     175c <mm_fm_init+0x9f>
				lst = (fm->size / 4096) / 16384;
    1749:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    174c:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    174f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1752:	0f ac d0 1a          	shrd   eax,edx,0x1a
    1756:	c1 ea 1a             	shr    edx,0x1a
    1759:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax

		/* before preemption -> no sync needed */
		fm->pmu = (uint64_t)cur_pmu;
    175c:	a1 00 00 00 00       	mov    eax,ds:0x0
    1761:	99                   	cdq
    1762:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1765:	89 41 28             	mov    DWORD PTR [ecx+0x28],eax
    1768:	89 51 2c             	mov    DWORD PTR [ecx+0x2c],edx
		fm->rcp = (uint64_t)cur_rcp;
    176b:	a1 00 00 00 00       	mov    eax,ds:0x0
    1770:	99                   	cdq
    1771:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1774:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
    1777:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
		p = cur_pmu; r = cur_rcp;
    177a:	a1 00 00 00 00       	mov    eax,ds:0x0
    177f:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    1782:	a1 00 00 00 00       	mov    eax,ds:0x0
    1787:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pm_count += fm->size;
    178a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    178d:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    1790:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    1793:	a1 00 00 00 00       	mov    eax,ds:0x0
    1798:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    179e:	01 c8                	add    eax,ecx
    17a0:	11 da                	adc    edx,ebx
    17a2:	a3 00 00 00 00       	mov    ds:0x0,eax
    17a7:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
	
		/* cap sizes */
		if ((VM_PMU_LIMIT - cur_pmu < ec2 * 4096)
    17ad:	a1 00 00 00 00       	mov    eax,ds:0x0
    17b2:	ba 00 00 00 fd       	mov    edx,0xfd000000
    17b7:	29 c2                	sub    edx,eax
    17b9:	89 d1                	mov    ecx,edx
    17bb:	89 d3                	mov    ebx,edx
    17bd:	c1 fb 1f             	sar    ebx,0x1f
    17c0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    17c3:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    17c6:	0f a4 c2 0c          	shld   edx,eax,0xc
    17ca:	c1 e0 0c             	shl    eax,0xc
    17cd:	39 c1                	cmp    ecx,eax
    17cf:	19 d3                	sbb    ebx,edx
    17d1:	72 28                	jb     17fb <mm_fm_init+0x13e>
			|| (VM_RCP_LIMIT - cur_rcp < ec2 * 4096)) {
    17d3:	a1 00 00 00 00       	mov    eax,ds:0x0
    17d8:	ba 00 00 00 fe       	mov    edx,0xfe000000
    17dd:	29 c2                	sub    edx,eax
    17df:	89 d1                	mov    ecx,edx
    17e1:	89 d3                	mov    ebx,edx
    17e3:	c1 fb 1f             	sar    ebx,0x1f
    17e6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    17e9:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    17ec:	0f a4 c2 0c          	shld   edx,eax,0xc
    17f0:	c1 e0 0c             	shl    eax,0xc
    17f3:	39 c1                	cmp    ecx,eax
    17f5:	89 df                	mov    edi,ebx
    17f7:	19 d7                	sbb    edi,edx
    17f9:	73 71                	jae    186c <mm_fm_init+0x1af>
				/* we should cap and inform the user */
				ec2 = (VM_PMU_LIMIT - cur_pmu) / 4096; /* only on PMUs as LIMITS are identical*/
    17fb:	a1 00 00 00 00       	mov    eax,ds:0x0
    1800:	ba 00 00 00 fd       	mov    edx,0xfd000000
    1805:	29 c2                	sub    edx,eax
    1807:	89 d0                	mov    eax,edx
    1809:	8d 90 ff 0f 00 00    	lea    edx,[eax+0xfff]
    180f:	85 c0                	test   eax,eax
    1811:	0f 48 c2             	cmovs  eax,edx
    1814:	c1 f8 0c             	sar    eax,0xc
    1817:	99                   	cdq
    1818:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    181b:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
								fm->ec - ec2, (fm->ec - ec2) * 64);
    181e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1821:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1824:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1827:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
    182a:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
    182d:	0f a4 c2 06          	shld   edx,eax,0x6
    1831:	c1 e0 06             	shl    eax,0x6
    1834:	89 c1                	mov    ecx,eax
    1836:	89 d3                	mov    ebx,edx
								fm->ec - ec2, (fm->ec - ec2) * 64);
    1838:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    183b:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    183e:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
    1841:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
    1844:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
    1847:	83 ec 08             	sub    esp,0x8
    184a:	53                   	push   ebx
    184b:	51                   	push   ecx
    184c:	52                   	push   edx
    184d:	50                   	push   eax
    184e:	68 6c 00 00 00       	push   0x6c
    1853:	6a 0e                	push   0xe
    1855:	e8 fc ff ff ff       	call   1856 <mm_fm_init+0x199>
    185a:	83 c4 20             	add    esp,0x20
				fm->ec = ec2;
    185d:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1860:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1863:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1866:	89 41 20             	mov    DWORD PTR [ecx+0x20],eax
    1869:	89 51 24             	mov    DWORD PTR [ecx+0x24],edx
		}
		/* and advance */
		cur_pmu += ec2 * 4096;
    186c:	a1 00 00 00 00       	mov    eax,ds:0x0
    1871:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    1874:	c1 e2 0c             	shl    edx,0xc
    1877:	01 d0                	add    eax,edx
    1879:	a3 00 00 00 00       	mov    ds:0x0,eax
		cur_rcp += ec2 * 4096;
    187e:	a1 00 00 00 00       	mov    eax,ds:0x0
    1883:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    1886:	c1 e2 0c             	shl    edx,0xc
    1889:	01 d0                	add    eax,edx
    188b:	a3 00 00 00 00       	mov    ds:0x0,eax

		/* skip completely if neccessary */
		if (!ec2)
    1890:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1893:	0b 45 d4             	or     eax,DWORD PTR [ebp-0x2c]
    1896:	0f 84 74 01 00 00    	je     1a10 <mm_fm_init+0x353>
				return;

		/* map & init the pmus */
		pr.base = b;
    189c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    189f:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    18a2:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    18a5:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		pr.count = ec2;
    18a8:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    18ab:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
		mm_map(&mm_kernel, p, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
    18ae:	83 ec 0c             	sub    esp,0xc
    18b1:	6a 0c                	push   0xc
    18b3:	6a 01                	push   0x1
    18b5:	8d 45 a0             	lea    eax,[ebp-0x60]
    18b8:	50                   	push   eax
    18b9:	ff 75 b0             	push   DWORD PTR [ebp-0x50]
    18bc:	68 00 00 00 00       	push   0x0
    18c1:	e8 fc ff ff ff       	call   18c2 <mm_fm_init+0x205>
    18c6:	83 c4 20             	add    esp,0x20
		pr.base = b1;
    18c9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    18cc:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    18cf:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    18d2:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		pr.count = ec2;
    18d5:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    18d8:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
		mm_map(&mm_kernel, r, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
    18db:	83 ec 0c             	sub    esp,0xc
    18de:	6a 0c                	push   0xc
    18e0:	6a 01                	push   0x1
    18e2:	8d 45 a0             	lea    eax,[ebp-0x60]
    18e5:	50                   	push   eax
    18e6:	ff 75 ac             	push   DWORD PTR [ebp-0x54]
    18e9:	68 00 00 00 00       	push   0x0
    18ee:	e8 fc ff ff ff       	call   18ef <mm_fm_init+0x232>
    18f3:	83 c4 20             	add    esp,0x20

		/* now init the leftovers */
		for (uint64_t i = 0; i < ec2; i++) {
    18f6:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [ebp-0x40],0x0
    18fd:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x0
    1904:	e9 f1 00 00 00       	jmp    19fa <mm_fm_init+0x33d>
				struct pmu* pt = NULL; int rd = 0;
    1909:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
    1910:	c7 45 b8 00 00 00 00 	mov    DWORD PTR [ebp-0x48],0x0
				/* check for exception */
				if (b > 0x100000000 - 4096)
    1917:	ba 00 f0 ff ff       	mov    edx,0xfffff000
    191c:	b8 00 00 00 00       	mov    eax,0x0
    1921:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
    1924:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
    1927:	73 12                	jae    193b <mm_fm_init+0x27e>
						pt = &p[i];
    1929:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    192c:	c1 e0 0c             	shl    eax,0xc
    192f:	89 c2                	mov    edx,eax
    1931:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    1934:	01 d0                	add    eax,edx
    1936:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    1939:	eb 01                	jmp    193c <mm_fm_init+0x27f>

redo:
    193b:	90                   	nop
				/* initialize */
				if (pt) {
    193c:	83 7d bc 00          	cmp    DWORD PTR [ebp-0x44],0x0
    1940:	74 66                	je     19a8 <mm_fm_init+0x2eb>
						/* clear the locks */
						bzero(pt->locks, sizeof(pt->locks));
    1942:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1945:	83 ec 08             	sub    esp,0x8
    1948:	6a 08                	push   0x8
    194a:	50                   	push   eax
    194b:	e8 fc ff ff ff       	call   194c <mm_fm_init+0x28f>
    1950:	83 c4 10             	add    esp,0x10
						/* invalidate the counts and put rec in the last one */
						pt->free_ct[0] = 0xffff;
    1953:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1956:	66 c7 40 08 ff ff    	mov    WORD PTR [eax+0x8],0xffff
						pt->free_ct[1] = 0xffff;
    195c:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    195f:	66 c7 40 0a ff ff    	mov    WORD PTR [eax+0xa],0xffff
						pt->free_ct[2] = 0xffff;
    1965:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1968:	66 c7 40 0c ff ff    	mov    WORD PTR [eax+0xc],0xffff
						if (rec)
    196e:	66 83 7d b6 00       	cmp    WORD PTR [ebp-0x4a],0x0
    1973:	74 2a                	je     199f <mm_fm_init+0x2e2>
								pt->free_ct[3] = (i == lst) ? rec : 0xffff;
    1975:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1978:	ba 00 00 00 00       	mov    edx,0x0
    197d:	89 c1                	mov    ecx,eax
    197f:	89 c8                	mov    eax,ecx
    1981:	33 45 c0             	xor    eax,DWORD PTR [ebp-0x40]
    1984:	33 55 c4             	xor    edx,DWORD PTR [ebp-0x3c]
    1987:	09 d0                	or     eax,edx
    1989:	75 06                	jne    1991 <mm_fm_init+0x2d4>
    198b:	0f b7 45 b6          	movzx  eax,WORD PTR [ebp-0x4a]
    198f:	eb 05                	jmp    1996 <mm_fm_init+0x2d9>
    1991:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1996:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1999:	66 89 42 0e          	mov    WORD PTR [edx+0xe],ax
    199d:	eb 09                	jmp    19a8 <mm_fm_init+0x2eb>
						else
								pt->free_ct[3] = 0xffff;
    199f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    19a2:	66 c7 40 0e ff ff    	mov    WORD PTR [eax+0xe],0xffff
				}

				/* check for second run */
				if (!rd && (b1 > 0x100000000 - 4096)) {
    19a8:	83 7d b8 00          	cmp    DWORD PTR [ebp-0x48],0x0
    19ac:	75 2e                	jne    19dc <mm_fm_init+0x31f>
    19ae:	ba 00 f0 ff ff       	mov    edx,0xfffff000
    19b3:	b8 00 00 00 00       	mov    eax,0x0
    19b8:	3b 55 d8             	cmp    edx,DWORD PTR [ebp-0x28]
    19bb:	1b 45 dc             	sbb    eax,DWORD PTR [ebp-0x24]
    19be:	73 1c                	jae    19dc <mm_fm_init+0x31f>
						pt = &r[i];
    19c0:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    19c3:	c1 e0 0c             	shl    eax,0xc
    19c6:	89 c2                	mov    edx,eax
    19c8:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    19cb:	01 d0                	add    eax,edx
    19cd:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
						rd = 1;
    19d0:	c7 45 b8 01 00 00 00 	mov    DWORD PTR [ebp-0x48],0x1
						goto redo;
    19d7:	e9 60 ff ff ff       	jmp    193c <mm_fm_init+0x27f>
				}

				/* advance */
				b += 4096;
    19dc:	81 45 e0 00 10 00 00 	add    DWORD PTR [ebp-0x20],0x1000
    19e3:	83 55 e4 00          	adc    DWORD PTR [ebp-0x1c],0x0
				b1 += 4096;
    19e7:	81 45 d8 00 10 00 00 	add    DWORD PTR [ebp-0x28],0x1000
    19ee:	83 55 dc 00          	adc    DWORD PTR [ebp-0x24],0x0
		for (uint64_t i = 0; i < ec2; i++) {
    19f2:	83 45 c0 01          	add    DWORD PTR [ebp-0x40],0x1
    19f6:	83 55 c4 00          	adc    DWORD PTR [ebp-0x3c],0x0
    19fa:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    19fd:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1a00:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    1a03:	89 d0                	mov    eax,edx
    1a05:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
    1a08:	0f 82 fb fe ff ff    	jb     1909 <mm_fm_init+0x24c>
    1a0e:	eb 01                	jmp    1a11 <mm_fm_init+0x354>
				return;
    1a10:	90                   	nop
		}
}
    1a11:	8d 65 f4             	lea    esp,[ebp-0xc]
    1a14:	5b                   	pop    ebx
    1a15:	5e                   	pop    esi
    1a16:	5f                   	pop    edi
    1a17:	5d                   	pop    ebp
    1a18:	c3                   	ret

00001a19 <mmgr_reinit>:

void mmgr_reinit()
{
    1a19:	55                   	push   ebp
    1a1a:	89 e5                	mov    ebp,esp
    1a1c:	83 ec 18             	sub    esp,0x18
		uint32_t* ptr = FM_FREE_MEMORY_MAP;
    1a1f:	c7 45 f0 00 40 02 00 	mov    DWORD PTR [ebp-0x10],0x24000
		while (ptr);
    1a26:	90                   	nop
    1a27:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1a2b:	75 fa                	jne    1a27 <mmgr_reinit+0xe>
		fm_ofs = ptr[-1];
    1a2d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a30:	83 e8 04             	sub    eax,0x4
    1a33:	8b 00                	mov    eax,DWORD PTR [eax]
    1a35:	a3 00 00 00 00       	mov    ds:0x0,eax
		fm_begin = ptr[-2];
    1a3a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a3d:	83 e8 08             	sub    eax,0x8
    1a40:	8b 00                	mov    eax,DWORD PTR [eax]
    1a42:	a3 00 00 00 00       	mov    ds:0x0,eax
		rm_count = ptr[-3];
    1a47:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a4a:	83 e8 0c             	sub    eax,0xc
    1a4d:	8b 00                	mov    eax,DWORD PTR [eax]
    1a4f:	a3 00 00 00 00       	mov    ds:0x0,eax
		pm_zero = *(uint64_t*)(ptr - 5);
    1a54:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a57:	8b 50 f0             	mov    edx,DWORD PTR [eax-0x10]
    1a5a:	8b 40 ec             	mov    eax,DWORD PTR [eax-0x14]
    1a5d:	a3 00 00 00 00       	mov    ds:0x0,eax
    1a62:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		mm_kernel.cr3 = *(uint64_t*)(ptr - 7);
    1a68:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a6b:	8b 50 e8             	mov    edx,DWORD PTR [eax-0x18]
    1a6e:	8b 40 e4             	mov    eax,DWORD PTR [eax-0x1c]
    1a71:	a3 00 00 00 00       	mov    ds:0x0,eax
    1a76:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		mm_kernel.ctx = FM_VIRTUAL_MAPPING;
    1a7c:	c7 05 08 00 00 00 00 80 02 00 	mov    DWORD PTR ds:0x8,0x28000
		mm_kernel.qnd_ptr = VM_QND_BASE;
    1a86:	c7 05 0c 00 00 00 00 00 00 90 	mov    DWORD PTR ds:0xc,0x90000000
#ifndef __x86_64__ /* PAE? */
		extern void* mf_map;
		extern void* mm_map36;
		extern void* mm_map32;
		if (ptr[-8] == 1) /* PAE */
    1a90:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a93:	83 e8 20             	sub    eax,0x20
    1a96:	8b 00                	mov    eax,DWORD PTR [eax]
    1a98:	83 f8 01             	cmp    eax,0x1
    1a9b:	75 0c                	jne    1aa9 <mmgr_reinit+0x90>
				mf_map = &mm_map36;
    1a9d:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
    1aa7:	eb 0a                	jmp    1ab3 <mmgr_reinit+0x9a>
		else
				mf_map = &mm_map32;
    1aa9:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
#endif

		/* map the pmus & initialize high pmus */
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    1ab3:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ab8:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1abb:	eb 1d                	jmp    1ada <mmgr_reinit+0xc1>
				mm_fm_init(fmm + i);
    1abd:	ba 00 40 02 00       	mov    edx,0x24000
    1ac2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1ac5:	6b c0 38             	imul   eax,eax,0x38
    1ac8:	01 d0                	add    eax,edx
    1aca:	83 ec 0c             	sub    esp,0xc
    1acd:	50                   	push   eax
    1ace:	e8 fc ff ff ff       	call   1acf <mmgr_reinit+0xb6>
    1ad3:	83 c4 10             	add    esp,0x10
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    1ad6:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1ada:	a1 00 00 00 00       	mov    eax,ds:0x0
    1adf:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    1ae2:	72 d9                	jb     1abd <mmgr_reinit+0xa4>
		//if (cpu.e_has_nx)
		//		enable_nx();

		/* allocate the heap */
		void init_kernel_heap();
		while (ptr);
    1ae4:	90                   	nop
    1ae5:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1ae9:	75 fa                	jne    1ae5 <mmgr_reinit+0xcc>
		init_kernel_heap();
    1aeb:	e8 fc ff ff ff       	call   1aec <mmgr_reinit+0xd3>
		void flush_tlb_full();
		flush_tlb_full();
    1af0:	e8 fc ff ff ff       	call   1af1 <mmgr_reinit+0xd8>
}
    1af5:	90                   	nop
    1af6:	c9                   	leave
    1af7:	c3                   	ret

00001af8 <pmue_dump>:

void pmue_dump(struct pmue* pu, int level)
{
    1af8:	55                   	push   ebp
    1af9:	89 e5                	mov    ebp,esp
    1afb:	57                   	push   edi
    1afc:	56                   	push   esi
    1afd:	53                   	push   ebx
    1afe:	83 ec 1c             	sub    esp,0x1c
		size_t i, ne; uint32_t* lv;
		if (level >= 0 && level <= 7) {
    1b01:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1b05:	0f 88 a3 01 00 00    	js     1cae <pmue_dump+0x1b6>
    1b0b:	83 7d 0c 07          	cmp    DWORD PTR [ebp+0xc],0x7
    1b0f:	0f 8f 99 01 00 00    	jg     1cae <pmue_dump+0x1b6>
				if (level == 0)
    1b15:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1b19:	75 12                	jne    1b2d <pmue_dump+0x35>
						(lv = pu->lvl0), ne = 128;
    1b1b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b1e:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1b21:	c7 45 e0 80 00 00 00 	mov    DWORD PTR [ebp-0x20],0x80
				if (level == 0)
    1b28:	e9 b1 00 00 00       	jmp    1bde <pmue_dump+0xe6>
				else if (level == 1)
    1b2d:	83 7d 0c 01          	cmp    DWORD PTR [ebp+0xc],0x1
    1b31:	75 17                	jne    1b4a <pmue_dump+0x52>
						(lv = pu->lvl1), ne = 64;
    1b33:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b36:	05 00 02 00 00       	add    eax,0x200
    1b3b:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1b3e:	c7 45 e0 40 00 00 00 	mov    DWORD PTR [ebp-0x20],0x40
				if (level == 0)
    1b45:	e9 94 00 00 00       	jmp    1bde <pmue_dump+0xe6>
				else if (level == 2)
    1b4a:	83 7d 0c 02          	cmp    DWORD PTR [ebp+0xc],0x2
    1b4e:	75 14                	jne    1b64 <pmue_dump+0x6c>
						(lv = pu->lvl2), ne = 32;
    1b50:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b53:	05 00 03 00 00       	add    eax,0x300
    1b58:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1b5b:	c7 45 e0 20 00 00 00 	mov    DWORD PTR [ebp-0x20],0x20
				if (level == 0)
    1b62:	eb 7a                	jmp    1bde <pmue_dump+0xe6>
				else if (level == 3)
    1b64:	83 7d 0c 03          	cmp    DWORD PTR [ebp+0xc],0x3
    1b68:	75 14                	jne    1b7e <pmue_dump+0x86>
						(lv = pu->lvl3), ne = 16;
    1b6a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b6d:	05 80 03 00 00       	add    eax,0x380
    1b72:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1b75:	c7 45 e0 10 00 00 00 	mov    DWORD PTR [ebp-0x20],0x10
				if (level == 0)
    1b7c:	eb 60                	jmp    1bde <pmue_dump+0xe6>
				else if (level == 4)
    1b7e:	83 7d 0c 04          	cmp    DWORD PTR [ebp+0xc],0x4
    1b82:	75 14                	jne    1b98 <pmue_dump+0xa0>
						(lv = pu->lvl4), ne = 8;
    1b84:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b87:	05 c0 03 00 00       	add    eax,0x3c0
    1b8c:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1b8f:	c7 45 e0 08 00 00 00 	mov    DWORD PTR [ebp-0x20],0x8
				if (level == 0)
    1b96:	eb 46                	jmp    1bde <pmue_dump+0xe6>
				else if (level == 5)
    1b98:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
    1b9c:	75 14                	jne    1bb2 <pmue_dump+0xba>
						(lv = pu->lvl5), ne = 4;
    1b9e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ba1:	05 e0 03 00 00       	add    eax,0x3e0
    1ba6:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1ba9:	c7 45 e0 04 00 00 00 	mov    DWORD PTR [ebp-0x20],0x4
				if (level == 0)
    1bb0:	eb 2c                	jmp    1bde <pmue_dump+0xe6>
				else if (level == 6)
    1bb2:	83 7d 0c 06          	cmp    DWORD PTR [ebp+0xc],0x6
    1bb6:	75 14                	jne    1bcc <pmue_dump+0xd4>
						(lv = pu->lvl6), ne = 2;
    1bb8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bbb:	05 f0 03 00 00       	add    eax,0x3f0
    1bc0:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1bc3:	c7 45 e0 02 00 00 00 	mov    DWORD PTR [ebp-0x20],0x2
				if (level == 0)
    1bca:	eb 12                	jmp    1bde <pmue_dump+0xe6>
				else
						(lv = &pu->lvl7), ne = 1;
    1bcc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bcf:	05 f8 03 00 00       	add    eax,0x3f8
    1bd4:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1bd7:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
				if (level == 0)
    1bde:	90                   	nop
		} else
				return;
		printf("pmue/rcpe (at %p) lvl%d entries:\n", pu, level);
    1bdf:	83 ec 04             	sub    esp,0x4
    1be2:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1be5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1be8:	68 9c 00 00 00       	push   0x9c
    1bed:	e8 fc ff ff ff       	call   1bee <pmue_dump+0xf6>
    1bf2:	83 c4 10             	add    esp,0x10
		for (i = 0; i < ne; i += 6) {
    1bf5:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    1bfc:	e9 9f 00 00 00       	jmp    1ca0 <pmue_dump+0x1a8>
				if (ne - i >= 6) {
    1c01:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c04:	2b 45 e4             	sub    eax,DWORD PTR [ebp-0x1c]
    1c07:	83 f8 05             	cmp    eax,0x5
    1c0a:	76 49                	jbe    1c55 <pmue_dump+0x15d>
						printf("%08x %08x %08x %08x %08x %08x\n",
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1c0c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c0f:	83 c0 14             	add    eax,0x14
						printf("%08x %08x %08x %08x %08x %08x\n",
    1c12:	8b 38                	mov    edi,DWORD PTR [eax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1c14:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c17:	83 c0 10             	add    eax,0x10
						printf("%08x %08x %08x %08x %08x %08x\n",
    1c1a:	8b 30                	mov    esi,DWORD PTR [eax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1c1c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c1f:	83 c0 0c             	add    eax,0xc
						printf("%08x %08x %08x %08x %08x %08x\n",
    1c22:	8b 18                	mov    ebx,DWORD PTR [eax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1c24:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c27:	83 c0 08             	add    eax,0x8
						printf("%08x %08x %08x %08x %08x %08x\n",
    1c2a:	8b 08                	mov    ecx,DWORD PTR [eax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1c2c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c2f:	83 c0 04             	add    eax,0x4
						printf("%08x %08x %08x %08x %08x %08x\n",
    1c32:	8b 10                	mov    edx,DWORD PTR [eax]
    1c34:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c37:	8b 00                	mov    eax,DWORD PTR [eax]
    1c39:	83 ec 04             	sub    esp,0x4
    1c3c:	57                   	push   edi
    1c3d:	56                   	push   esi
    1c3e:	53                   	push   ebx
    1c3f:	51                   	push   ecx
    1c40:	52                   	push   edx
    1c41:	50                   	push   eax
    1c42:	68 c0 00 00 00       	push   0xc0
    1c47:	e8 fc ff ff ff       	call   1c48 <pmue_dump+0x150>
    1c4c:	83 c4 20             	add    esp,0x20
						lv += 6;
    1c4f:	83 45 dc 18          	add    DWORD PTR [ebp-0x24],0x18
    1c53:	eb 47                	jmp    1c9c <pmue_dump+0x1a4>
				} else {
						size_t j;
						for (j = 0; j < ne - i; j++)
    1c55:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    1c5c:	eb 26                	jmp    1c84 <pmue_dump+0x18c>
								printf("%08x ", lv[j]);
    1c5e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1c61:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    1c68:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c6b:	01 d0                	add    eax,edx
    1c6d:	8b 00                	mov    eax,DWORD PTR [eax]
    1c6f:	83 ec 08             	sub    esp,0x8
    1c72:	50                   	push   eax
    1c73:	68 df 00 00 00       	push   0xdf
    1c78:	e8 fc ff ff ff       	call   1c79 <pmue_dump+0x181>
    1c7d:	83 c4 10             	add    esp,0x10
						for (j = 0; j < ne - i; j++)
    1c80:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    1c84:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c87:	2b 45 e4             	sub    eax,DWORD PTR [ebp-0x1c]
    1c8a:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
    1c8d:	72 cf                	jb     1c5e <pmue_dump+0x166>
						putchar('\n');
    1c8f:	83 ec 0c             	sub    esp,0xc
    1c92:	6a 0a                	push   0xa
    1c94:	e8 fc ff ff ff       	call   1c95 <pmue_dump+0x19d>
    1c99:	83 c4 10             	add    esp,0x10
		for (i = 0; i < ne; i += 6) {
    1c9c:	83 45 e4 06          	add    DWORD PTR [ebp-0x1c],0x6
    1ca0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1ca3:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    1ca6:	0f 82 55 ff ff ff    	jb     1c01 <pmue_dump+0x109>
    1cac:	eb 01                	jmp    1caf <pmue_dump+0x1b7>
				return;
    1cae:	90                   	nop
				}
		}
}
    1caf:	8d 65 f4             	lea    esp,[ebp-0xc]
    1cb2:	5b                   	pop    ebx
    1cb3:	5e                   	pop    esi
    1cb4:	5f                   	pop    edi
    1cb5:	5d                   	pop    ebp
    1cb6:	c3                   	ret

00001cb7 <pmu_dump>:
void pmu_dump(struct pmu* pu, int level)
{
    1cb7:	55                   	push   ebp
    1cb8:	89 e5                	mov    ebp,esp
    1cba:	83 ec 18             	sub    esp,0x18
		printf("dumping pmu/rcp (at %p)\n", pu);
    1cbd:	83 ec 08             	sub    esp,0x8
    1cc0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1cc3:	68 e5 00 00 00       	push   0xe5
    1cc8:	e8 fc ff ff ff       	call   1cc9 <pmu_dump+0x12>
    1ccd:	83 c4 10             	add    esp,0x10
		for (int i = 0; i < 4; i++)
    1cd0:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1cd7:	eb 24                	jmp    1cfd <pmu_dump+0x46>
				pmue_dump(&pu->entries[i], level);
    1cd9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1cdc:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
    1ce2:	8d 50 10             	lea    edx,[eax+0x10]
    1ce5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ce8:	01 d0                	add    eax,edx
    1cea:	83 ec 08             	sub    esp,0x8
    1ced:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1cf0:	50                   	push   eax
    1cf1:	e8 fc ff ff ff       	call   1cf2 <pmu_dump+0x3b>
    1cf6:	83 c4 10             	add    esp,0x10
		for (int i = 0; i < 4; i++)
    1cf9:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1cfd:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    1d01:	7e d6                	jle    1cd9 <pmu_dump+0x22>
}
    1d03:	90                   	nop
    1d04:	90                   	nop
    1d05:	c9                   	leave
    1d06:	c3                   	ret

00001d07 <mm_dump_pmu>:
void mm_dump_pmu(size_t fm, size_t n, int is_rcp)
{
    1d07:	55                   	push   ebp
    1d08:	89 e5                	mov    ebp,esp
    1d0a:	53                   	push   ebx
    1d0b:	83 ec 14             	sub    esp,0x14
		struct pmu* pu;
		if (is_rcp == 2) {
    1d0e:	83 7d 10 02          	cmp    DWORD PTR [ebp+0x10],0x2
    1d12:	0f 85 e4 00 00 00    	jne    1dfc <mm_dump_pmu+0xf5>
				/* user talk */
				printf("Free mem map contains %lu entries\n", fm_ofs);
    1d18:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d1d:	83 ec 08             	sub    esp,0x8
    1d20:	50                   	push   eax
    1d21:	68 00 01 00 00       	push   0x100
    1d26:	e8 fc ff ff ff       	call   1d27 <mm_dump_pmu+0x20>
    1d2b:	83 c4 10             	add    esp,0x10
				printf("Enumerating maps:\n");
    1d2e:	83 ec 0c             	sub    esp,0xc
    1d31:	68 23 01 00 00       	push   0x123
    1d36:	e8 fc ff ff ff       	call   1d37 <mm_dump_pmu+0x30>
    1d3b:	83 c4 10             	add    esp,0x10
				for (n = 0; n < fm_ofs; n++) {
    1d3e:	c7 45 0c 00 00 00 00 	mov    DWORD PTR [ebp+0xc],0x0
    1d45:	e9 9f 00 00 00       	jmp    1de9 <mm_dump_pmu+0xe2>
						size_t cr = 0, cu = 0;
    1d4a:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1d51:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						struct pmu* pu;
						printf("Map %lu: %016llx-%016llx\n", n,
								fmm[n].base, fmm[n].base + fmm[n].size);
    1d58:	ba 00 40 02 00       	mov    edx,0x24000
    1d5d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d60:	6b c0 38             	imul   eax,eax,0x38
    1d63:	01 d0                	add    eax,edx
    1d65:	8b 08                	mov    ecx,DWORD PTR [eax]
    1d67:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1d6a:	ba 00 40 02 00       	mov    edx,0x24000
    1d6f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d72:	6b c0 38             	imul   eax,eax,0x38
    1d75:	01 d0                	add    eax,edx
    1d77:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1d7a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
						printf("Map %lu: %016llx-%016llx\n", n,
    1d7d:	01 c1                	add    ecx,eax
    1d7f:	11 d3                	adc    ebx,edx
								fmm[n].base, fmm[n].base + fmm[n].size);
    1d81:	ba 00 40 02 00       	mov    edx,0x24000
    1d86:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d89:	6b c0 38             	imul   eax,eax,0x38
    1d8c:	01 d0                	add    eax,edx
						printf("Map %lu: %016llx-%016llx\n", n,
    1d8e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1d91:	8b 00                	mov    eax,DWORD PTR [eax]
    1d93:	83 ec 08             	sub    esp,0x8
    1d96:	53                   	push   ebx
    1d97:	51                   	push   ecx
    1d98:	52                   	push   edx
    1d99:	50                   	push   eax
    1d9a:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1d9d:	68 36 01 00 00       	push   0x136
    1da2:	e8 fc ff ff ff       	call   1da3 <mm_dump_pmu+0x9c>
    1da7:	83 c4 20             	add    esp,0x20
						pu = (void*)fmm[n].pmu;
    1daa:	ba 00 40 02 00       	mov    edx,0x24000
    1daf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1db2:	6b c0 38             	imul   eax,eax,0x38
    1db5:	01 d0                	add    eax,edx
    1db7:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    1dba:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    1dbd:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						printf("\tEntry count: %llu\n", fmm[n].ec);
    1dc0:	ba 00 40 02 00       	mov    edx,0x24000
    1dc5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1dc8:	6b c0 38             	imul   eax,eax,0x38
    1dcb:	01 d0                	add    eax,edx
    1dcd:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1dd0:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1dd3:	83 ec 04             	sub    esp,0x4
    1dd6:	52                   	push   edx
    1dd7:	50                   	push   eax
    1dd8:	68 50 01 00 00       	push   0x150
    1ddd:	e8 fc ff ff ff       	call   1dde <mm_dump_pmu+0xd7>
    1de2:	83 c4 10             	add    esp,0x10
				for (n = 0; n < fm_ofs; n++) {
    1de5:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    1de9:	a1 00 00 00 00       	mov    eax,ds:0x0
    1dee:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
    1df1:	0f 82 53 ff ff ff    	jb     1d4a <mm_dump_pmu+0x43>
				}
				return;
    1df7:	e9 ef 00 00 00       	jmp    1eeb <mm_dump_pmu+0x1e4>
		}
		if (fm > fm_ofs) {
    1dfc:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e01:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    1e04:	73 15                	jae    1e1b <mm_dump_pmu+0x114>
				printf("FM out of range\n");
    1e06:	83 ec 0c             	sub    esp,0xc
    1e09:	68 64 01 00 00       	push   0x164
    1e0e:	e8 fc ff ff ff       	call   1e0f <mm_dump_pmu+0x108>
    1e13:	83 c4 10             	add    esp,0x10
				return;
    1e16:	e9 d0 00 00 00       	jmp    1eeb <mm_dump_pmu+0x1e4>
		}
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
						(uint32_t)fmm[fm].free_pages,
						(uint32_t)fmm[fm].reclaimable_pages);
    1e1b:	ba 00 40 02 00       	mov    edx,0x24000
    1e20:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e23:	6b c0 38             	imul   eax,eax,0x38
    1e26:	01 d0                	add    eax,edx
    1e28:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    1e2b:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
    1e2e:	89 c1                	mov    ecx,eax
						(uint32_t)fmm[fm].free_pages,
    1e30:	ba 00 40 02 00       	mov    edx,0x24000
    1e35:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e38:	6b c0 38             	imul   eax,eax,0x38
    1e3b:	01 d0                	add    eax,edx
    1e3d:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    1e40:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
    1e43:	51                   	push   ecx
    1e44:	50                   	push   eax
    1e45:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1e48:	68 78 01 00 00       	push   0x178
    1e4d:	e8 fc ff ff ff       	call   1e4e <mm_dump_pmu+0x147>
    1e52:	83 c4 10             	add    esp,0x10
		if (is_rcp)
    1e55:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1e59:	74 18                	je     1e73 <mm_dump_pmu+0x16c>
				pu = (void*)fmm[fm].rcp;
    1e5b:	ba 00 40 02 00       	mov    edx,0x24000
    1e60:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e63:	6b c0 38             	imul   eax,eax,0x38
    1e66:	01 d0                	add    eax,edx
    1e68:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    1e6b:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1e6e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1e71:	eb 16                	jmp    1e89 <mm_dump_pmu+0x182>
		else
				pu = (void*)fmm[fm].pmu;
    1e73:	ba 00 40 02 00       	mov    edx,0x24000
    1e78:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e7b:	6b c0 38             	imul   eax,eax,0x38
    1e7e:	01 d0                	add    eax,edx
    1e80:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    1e83:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    1e86:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (n > fmm[fm].ec)
    1e89:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    1e8c:	bb 00 00 00 00       	mov    ebx,0x0
    1e91:	ba 00 40 02 00       	mov    edx,0x24000
    1e96:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e99:	6b c0 38             	imul   eax,eax,0x38
    1e9c:	01 d0                	add    eax,edx
    1e9e:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1ea1:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1ea4:	39 c8                	cmp    eax,ecx
    1ea6:	89 d0                	mov    eax,edx
    1ea8:	19 d8                	sbb    eax,ebx
    1eaa:	73 10                	jae    1ebc <mm_dump_pmu+0x1b5>
				printf("PMU index out of range\n");
    1eac:	83 ec 0c             	sub    esp,0xc
    1eaf:	68 99 01 00 00       	push   0x199
    1eb4:	e8 fc ff ff ff       	call   1eb5 <mm_dump_pmu+0x1ae>
    1eb9:	83 c4 10             	add    esp,0x10
		pu += n;
    1ebc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ebf:	c1 e0 0c             	shl    eax,0xc
    1ec2:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		pmu_dump(pu, 0);
    1ec5:	83 ec 08             	sub    esp,0x8
    1ec8:	6a 00                	push   0x0
    1eca:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1ecd:	e8 fc ff ff ff       	call   1ece <mm_dump_pmu+0x1c7>
    1ed2:	83 c4 10             	add    esp,0x10
		if (is_rcp)
    1ed5:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1ed9:	74 10                	je     1eeb <mm_dump_pmu+0x1e4>
				pmu_dump(pu, 2);
    1edb:	83 ec 08             	sub    esp,0x8
    1ede:	6a 02                	push   0x2
    1ee0:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1ee3:	e8 fc ff ff ff       	call   1ee4 <mm_dump_pmu+0x1dd>
    1ee8:	83 c4 10             	add    esp,0x10
}
    1eeb:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1eee:	c9                   	leave
    1eef:	c3                   	ret
