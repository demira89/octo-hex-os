
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
       5:	83 ec 10             	sub    esp,0x10
		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
       8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       b:	8d 50 0a             	lea    edx,[eax+0xa]
       e:	b8 ff ff ff ff       	mov    eax,0xffffffff
      13:	b9 fe ff ff ff       	mov    ecx,0xfffffffe
      18:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [edx],cx
      1d:	0f 94 c0             	sete   al
      20:	83 f0 01             	xor    eax,0x1
      23:	84 c0                	test   al,al
      25:	74 07                	je     2e <mm_init_pmu+0x2e>
				return -1;
      27:	b8 ff ff ff ff       	mov    eax,0xffffffff
      2c:	eb 68                	jmp    96 <mm_init_pmu+0x96>

		/* we're free to initialize (all full) */
		__builtin_memset(p->entries, 0xff, sizeof(p->entries));
      2e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      31:	83 c0 10             	add    eax,0x10
      34:	b9 f0 0f 00 00       	mov    ecx,0xff0
      39:	bb ff ff ff ff       	mov    ebx,0xffffffff
      3e:	89 18                	mov    DWORD PTR [eax],ebx
      40:	89 5c 08 fc          	mov    DWORD PTR [eax+ecx*1-0x4],ebx
      44:	8d 50 04             	lea    edx,[eax+0x4]
      47:	83 e2 fc             	and    edx,0xfffffffc
      4a:	29 d0                	sub    eax,edx
      4c:	01 c1                	add    ecx,eax
      4e:	83 e1 fc             	and    ecx,0xfffffffc
      51:	c1 e9 02             	shr    ecx,0x2
      54:	89 d7                	mov    edi,edx
      56:	89 d8                	mov    eax,ebx
      58:	f3 ab                	rep stos DWORD PTR es:[edi],eax

		/* now release */
		bzero(p->locks, sizeof(p->locks));
      5a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      5d:	c7 44 24 04 08 00 00 00 	mov    DWORD PTR [esp+0x4],0x8
      65:	89 04 24             	mov    DWORD PTR [esp],eax
      68:	e8 fc ff ff ff       	call   69 <mm_init_pmu+0x69>
		p->free_ct[3] = 0;
      6d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      70:	66 c7 40 0e 00 00    	mov    WORD PTR [eax+0xe],0x0
		p->free_ct[2] = 0;
      76:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      79:	66 c7 40 0c 00 00    	mov    WORD PTR [eax+0xc],0x0
		p->free_ct[1] = 0;
      7f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      82:	66 c7 40 0a 00 00    	mov    WORD PTR [eax+0xa],0x0
		p->free_ct[0] = 0;
      88:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      8b:	66 c7 40 08 00 00    	mov    WORD PTR [eax+0x8],0x0
		return 0;
      91:	b8 00 00 00 00       	mov    eax,0x0
}
      96:	83 c4 10             	add    esp,0x10
      99:	5b                   	pop    ebx
      9a:	5f                   	pop    edi
      9b:	5d                   	pop    ebp
      9c:	c3                   	ret

0000009d <mm_init_rcp>:

/* returns nonzero if locked */
int mm_init_rcp(struct pmu* p)
{
      9d:	55                   	push   ebp
      9e:	89 e5                	mov    ebp,esp
      a0:	57                   	push   edi
      a1:	53                   	push   ebx
      a2:	83 ec 30             	sub    esp,0x30
		uint16_t rem, fc[4] = { 4096, 4096, 4096, 4096 };
      a5:	66 c7 45 d8 00 10    	mov    WORD PTR [ebp-0x28],0x1000
      ab:	66 c7 45 da 00 10    	mov    WORD PTR [ebp-0x26],0x1000
      b1:	66 c7 45 dc 00 10    	mov    WORD PTR [ebp-0x24],0x1000
      b7:	66 c7 45 de 00 10    	mov    WORD PTR [ebp-0x22],0x1000

		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
      bd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      c0:	8d 50 0a             	lea    edx,[eax+0xa]
      c3:	b8 ff ff ff ff       	mov    eax,0xffffffff
      c8:	b9 fe ff ff ff       	mov    ecx,0xfffffffe
      cd:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [edx],cx
      d2:	0f 94 c0             	sete   al
      d5:	83 f0 01             	xor    eax,0x1
      d8:	84 c0                	test   al,al
      da:	74 0a                	je     e6 <mm_init_rcp+0x49>
				return -1;
      dc:	b8 ff ff ff ff       	mov    eax,0xffffffff
      e1:	e9 7a 02 00 00       	jmp    360 <mm_init_rcp+0x2c3>

		/* check if last */
		rem = p->free_ct[3];
      e6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      e9:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
      ed:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax

		if (rem != 0xffff) {
      f1:	66 83 7d f6 ff       	cmp    WORD PTR [ebp-0xa],0xffff
      f6:	0f 84 f4 01 00 00    	je     2f0 <mm_init_rcp+0x253>
				for (size_t i = 0; i < 4; i++) {
      fc:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     103:	e9 dc 01 00 00       	jmp    2e4 <mm_init_rcp+0x247>
						if (rem >= 4096) { /* still easy */
     108:	66 81 7d f6 ff 0f    	cmp    WORD PTR [ebp-0xa],0xfff
     10e:	76 42                	jbe    152 <mm_init_rcp+0xb5>
								/* set everything reclaimable */
								__builtin_memset(&p->entries[i], 0xff,
     110:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     113:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
     119:	8d 50 10             	lea    edx,[eax+0x10]
     11c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     11f:	01 d0                	add    eax,edx
     121:	b9 fc 03 00 00       	mov    ecx,0x3fc
     126:	bb ff ff ff ff       	mov    ebx,0xffffffff
     12b:	89 18                	mov    DWORD PTR [eax],ebx
     12d:	89 5c 08 fc          	mov    DWORD PTR [eax+ecx*1-0x4],ebx
     131:	8d 50 04             	lea    edx,[eax+0x4]
     134:	83 e2 fc             	and    edx,0xfffffffc
     137:	29 d0                	sub    eax,edx
     139:	01 c1                	add    ecx,eax
     13b:	83 e1 fc             	and    ecx,0xfffffffc
     13e:	c1 e9 02             	shr    ecx,0x2
     141:	89 d7                	mov    edi,edx
     143:	89 d8                	mov    eax,ebx
     145:	f3 ab                	rep stos DWORD PTR es:[edi],eax
												sizeof(p->entries[i]));
								/* advance */
								rem -= 4096;
     147:	66 81 6d f6 00 10    	sub    WORD PTR [ebp-0xa],0x1000
     14d:	e9 8e 01 00 00       	jmp    2e0 <mm_init_rcp+0x243>
						} else {
								/* fill partially (0, 2, 7) */
								for (uint16_t j = 0, of = 0; j < 128; of += 32, j++) {
     152:	66 c7 45 ee 00 00    	mov    WORD PTR [ebp-0x12],0x0
     158:	66 c7 45 ec 00 00    	mov    WORD PTR [ebp-0x14],0x0
     15e:	eb 6e                	jmp    1ce <mm_init_rcp+0x131>
										uint32_t val = 0;
     160:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
										if (rem > of) {
     167:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     16b:	66 39 45 ec          	cmp    WORD PTR [ebp-0x14],ax
     16f:	73 31                	jae    1a2 <mm_init_rcp+0x105>
												if (rem - of >= 32) /* set full */
     171:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     175:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
     179:	29 c2                	sub    edx,eax
     17b:	83 fa 1f             	cmp    edx,0x1f
     17e:	7e 09                	jle    189 <mm_init_rcp+0xec>
														val = 0xffffffff;
     180:	c7 45 e8 ff ff ff ff 	mov    DWORD PTR [ebp-0x18],0xffffffff
     187:	eb 19                	jmp    1a2 <mm_init_rcp+0x105>
												else /* set partial */
														val = (1 << (rem - of)) - 1;
     189:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     18d:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
     191:	29 c2                	sub    edx,eax
     193:	b8 01 00 00 00       	mov    eax,0x1
     198:	89 d1                	mov    ecx,edx
     19a:	d3 e0                	shl    eax,cl
     19c:	83 e8 01             	sub    eax,0x1
     19f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										}
										p->entries[i].lvl0[j] = val;
     1a2:	0f b7 5d ee          	movzx  ebx,WORD PTR [ebp-0x12]
     1a6:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     1a9:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     1ac:	89 d0                	mov    eax,edx
     1ae:	c1 e0 08             	shl    eax,0x8
     1b1:	29 d0                	sub    eax,edx
     1b3:	01 d8                	add    eax,ebx
     1b5:	8d 50 04             	lea    edx,[eax+0x4]
     1b8:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     1bb:	89 04 91             	mov    DWORD PTR [ecx+edx*4],eax
								for (uint16_t j = 0, of = 0; j < 128; of += 32, j++) {
     1be:	66 83 45 ec 20       	add    WORD PTR [ebp-0x14],0x20
     1c3:	0f b7 45 ee          	movzx  eax,WORD PTR [ebp-0x12]
     1c7:	83 c0 01             	add    eax,0x1
     1ca:	66 89 45 ee          	mov    WORD PTR [ebp-0x12],ax
     1ce:	66 83 7d ee 7f       	cmp    WORD PTR [ebp-0x12],0x7f
     1d3:	76 8b                	jbe    160 <mm_init_rcp+0xc3>
								}
								for (uint16_t j = 0, of = 0; j < 32; of += 128, j++) {
     1d5:	66 c7 45 e6 00 00    	mov    WORD PTR [ebp-0x1a],0x0
     1db:	66 c7 45 e4 00 00    	mov    WORD PTR [ebp-0x1c],0x0
     1e1:	e9 9b 00 00 00       	jmp    281 <mm_init_rcp+0x1e4>
										uint32_t val = 0;
     1e6:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
										if (rem > of) {
     1ed:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     1f1:	66 39 45 e4          	cmp    WORD PTR [ebp-0x1c],ax
     1f5:	73 5b                	jae    252 <mm_init_rcp+0x1b5>
												if (rem - of >= 128)
     1f7:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     1fb:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     1ff:	29 c2                	sub    edx,eax
     201:	83 fa 7f             	cmp    edx,0x7f
     204:	7e 09                	jle    20f <mm_init_rcp+0x172>
														val = 0xffffffff;
     206:	c7 45 e0 ff ff ff ff 	mov    DWORD PTR [ebp-0x20],0xffffffff
     20d:	eb 43                	jmp    252 <mm_init_rcp+0x1b5>
												else /* set partial */
														val = (1 << rdiv(rem - of, 4)) - 1;
     20f:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     213:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     217:	29 c2                	sub    edx,eax
     219:	89 d0                	mov    eax,edx
     21b:	8d 50 03             	lea    edx,[eax+0x3]
     21e:	85 c0                	test   eax,eax
     220:	0f 48 c2             	cmovs  eax,edx
     223:	c1 f8 02             	sar    eax,0x2
     226:	89 c1                	mov    ecx,eax
     228:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     22c:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     230:	29 c2                	sub    edx,eax
     232:	89 d0                	mov    eax,edx
     234:	83 e0 03             	and    eax,0x3
     237:	85 c0                	test   eax,eax
     239:	0f 95 c0             	setne  al
     23c:	0f b6 c0             	movzx  eax,al
     23f:	01 c8                	add    eax,ecx
     241:	ba 01 00 00 00       	mov    edx,0x1
     246:	89 c1                	mov    ecx,eax
     248:	d3 e2                	shl    edx,cl
     24a:	89 d0                	mov    eax,edx
     24c:	83 e8 01             	sub    eax,0x1
     24f:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
										}
										p->entries[i].lvl2[j] = val;
     252:	0f b7 5d e6          	movzx  ebx,WORD PTR [ebp-0x1a]
     256:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     259:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     25c:	89 d0                	mov    eax,edx
     25e:	c1 e0 08             	shl    eax,0x8
     261:	29 d0                	sub    eax,edx
     263:	01 d8                	add    eax,ebx
     265:	8d 90 c4 00 00 00    	lea    edx,[eax+0xc4]
     26b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     26e:	89 04 91             	mov    DWORD PTR [ecx+edx*4],eax
								for (uint16_t j = 0, of = 0; j < 32; of += 128, j++) {
     271:	66 83 6d e4 80       	sub    WORD PTR [ebp-0x1c],0xff80
     276:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
     27a:	83 c0 01             	add    eax,0x1
     27d:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
     281:	66 83 7d e6 1f       	cmp    WORD PTR [ebp-0x1a],0x1f
     286:	0f 86 5a ff ff ff    	jbe    1e6 <mm_init_rcp+0x149>
								}
								p->entries[i].lvl7 = (1 << rdiv(rem, 32)) - 1;
     28c:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     290:	66 c1 e8 05          	shr    ax,0x5
     294:	0f b7 d0             	movzx  edx,ax
     297:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     29b:	83 e0 1f             	and    eax,0x1f
     29e:	66 85 c0             	test   ax,ax
     2a1:	0f 95 c0             	setne  al
     2a4:	0f b6 c0             	movzx  eax,al
     2a7:	01 d0                	add    eax,edx
     2a9:	ba 01 00 00 00       	mov    edx,0x1
     2ae:	89 c1                	mov    ecx,eax
     2b0:	d3 e2                	shl    edx,cl
     2b2:	89 d0                	mov    eax,edx
     2b4:	83 e8 01             	sub    eax,0x1
     2b7:	89 c1                	mov    ecx,eax
     2b9:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     2bc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2bf:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
     2c5:	01 d0                	add    eax,edx
     2c7:	05 08 04 00 00       	add    eax,0x408
     2cc:	89 08                	mov    DWORD PTR [eax],ecx

								/* advance */
								fc[i] = rem;
     2ce:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     2d1:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     2d5:	66 89 54 45 d8       	mov    WORD PTR [ebp+eax*2-0x28],dx
								rem = 0;
     2da:	66 c7 45 f6 00 00    	mov    WORD PTR [ebp-0xa],0x0
				for (size_t i = 0; i < 4; i++) {
     2e0:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     2e4:	83 7d f0 03          	cmp    DWORD PTR [ebp-0x10],0x3
     2e8:	0f 86 1a fe ff ff    	jbe    108 <mm_init_rcp+0x6b>
     2ee:	eb 2c                	jmp    31c <mm_init_rcp+0x27f>
						}
				}
		} else /* very easy: everything is reclaimable */
				__builtin_memset(p->entries, 0xff, sizeof(p->entries));
     2f0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2f3:	83 c0 10             	add    eax,0x10
     2f6:	b9 f0 0f 00 00       	mov    ecx,0xff0
     2fb:	bb ff ff ff ff       	mov    ebx,0xffffffff
     300:	89 18                	mov    DWORD PTR [eax],ebx
     302:	89 5c 08 fc          	mov    DWORD PTR [eax+ecx*1-0x4],ebx
     306:	8d 50 04             	lea    edx,[eax+0x4]
     309:	83 e2 fc             	and    edx,0xfffffffc
     30c:	29 d0                	sub    eax,edx
     30e:	01 c1                	add    ecx,eax
     310:	83 e1 fc             	and    ecx,0xfffffffc
     313:	c1 e9 02             	shr    ecx,0x2
     316:	89 d7                	mov    edi,edx
     318:	89 d8                	mov    eax,ebx
     31a:	f3 ab                	rep stos DWORD PTR es:[edi],eax

		/* now release */
		bzero(p->locks, sizeof(p->locks));
     31c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     31f:	c7 44 24 04 08 00 00 00 	mov    DWORD PTR [esp+0x4],0x8
     327:	89 04 24             	mov    DWORD PTR [esp],eax
     32a:	e8 fc ff ff ff       	call   32b <mm_init_rcp+0x28e>
		p->free_ct[3] = fc[3];
     32f:	0f b7 55 de          	movzx  edx,WORD PTR [ebp-0x22]
     333:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     336:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
		p->free_ct[2] = fc[2];
     33a:	0f b7 55 dc          	movzx  edx,WORD PTR [ebp-0x24]
     33e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     341:	66 89 50 0c          	mov    WORD PTR [eax+0xc],dx
		p->free_ct[1] = fc[1];
     345:	0f b7 55 da          	movzx  edx,WORD PTR [ebp-0x26]
     349:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     34c:	66 89 50 0a          	mov    WORD PTR [eax+0xa],dx
		p->free_ct[0] = fc[0];
     350:	0f b7 55 d8          	movzx  edx,WORD PTR [ebp-0x28]
     354:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     357:	66 89 50 08          	mov    WORD PTR [eax+0x8],dx
		return 0;
     35b:	b8 00 00 00 00       	mov    eax,0x0
}
     360:	83 c4 30             	add    esp,0x30
     363:	5b                   	pop    ebx
     364:	5f                   	pop    edi
     365:	5d                   	pop    ebp
     366:	c3                   	ret

00000367 <mm_pmue_get_range>:
/* assume caller know about locking and has made the right reservations
 * for us to operate freely on the range given by the limits. */
uint32_t mm_pmue_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bsir, uint64_t base)
{
     367:	55                   	push   ebp
     368:	89 e5                	mov    ebp,esp
     36a:	56                   	push   esi
     36b:	53                   	push   ebx
     36c:	83 ec 70             	sub    esp,0x70
     36f:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
     372:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
     375:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
     378:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		uint32_t* bitfield, rv = 0;
     37b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0

		/* set the reference */
		switch (lvl) {
     382:	83 7d 14 07          	cmp    DWORD PTR [ebp+0x14],0x7
     386:	77 72                	ja     3fa <mm_pmue_get_range+0x93>
     388:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     38b:	c1 e0 02             	shl    eax,0x2
     38e:	05 0c 00 00 00       	add    eax,0xc
     393:	8b 00                	mov    eax,DWORD PTR [eax]
     395:	ff e0                	jmp    eax
				case 7:
						bitfield = &p->lvl7;
     397:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     39a:	05 f8 03 00 00       	add    eax,0x3f8
     39f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3a2:	eb 58                	jmp    3fc <mm_pmue_get_range+0x95>
				case 6:
						bitfield = p->lvl6;
     3a4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3a7:	05 f0 03 00 00       	add    eax,0x3f0
     3ac:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3af:	eb 4b                	jmp    3fc <mm_pmue_get_range+0x95>
				case 5:
						bitfield = p->lvl5;
     3b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3b4:	05 e0 03 00 00       	add    eax,0x3e0
     3b9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3bc:	eb 3e                	jmp    3fc <mm_pmue_get_range+0x95>
				case 4:
						bitfield = p->lvl4;
     3be:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3c1:	05 c0 03 00 00       	add    eax,0x3c0
     3c6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3c9:	eb 31                	jmp    3fc <mm_pmue_get_range+0x95>
				case 3:
						bitfield = p->lvl3;
     3cb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3ce:	05 80 03 00 00       	add    eax,0x380
     3d3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3d6:	eb 24                	jmp    3fc <mm_pmue_get_range+0x95>
				case 2:
						bitfield = p->lvl2;
     3d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3db:	05 00 03 00 00       	add    eax,0x300
     3e0:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3e3:	eb 17                	jmp    3fc <mm_pmue_get_range+0x95>
				case 1:
						bitfield = p->lvl1;
     3e5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3e8:	05 00 02 00 00       	add    eax,0x200
     3ed:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3f0:	eb 0a                	jmp    3fc <mm_pmue_get_range+0x95>
				case 0:
						bitfield = p->lvl0;
     3f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3f5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     3f8:	eb 02                	jmp    3fc <mm_pmue_get_range+0x95>
				default:
						while (1);
     3fa:	eb fe                	jmp    3fa <mm_pmue_get_range+0x93>
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
     3fc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     3ff:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     402:	e9 e8 01 00 00       	jmp    5ef <mm_pmue_get_range+0x288>
				/* test each bit */
				asm goto("bt %0, %1\n"
     407:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     40a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     40d:	0f a3 02             	bt     DWORD PTR [edx],eax
     410:	0f 82 c5 01 00 00    	jb     5db <mm_pmue_get_range+0x274>
						 "jc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : carry);

				/* we've got a free entry at i */
				if (lvl > 0) {
     416:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     41a:	0f 84 d8 00 00 00    	je     4f8 <mm_pmue_get_range+0x191>
						uint32_t rv2, prr = *n_pr, bs = 0;
     420:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     423:	8b 00                	mov    eax,DWORD PTR [eax]
     425:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     428:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
						/* go deeper */
						rv2 = mm_pmue_get_range(p, i * 2, i * 2 + 1,
     42f:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     432:	8d 70 ff             	lea    esi,[eax-0x1]
     435:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     438:	01 c0                	add    eax,eax
     43a:	8d 58 01             	lea    ebx,[eax+0x1]
     43d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     440:	8d 0c 00             	lea    ecx,[eax+eax*1]
     443:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     446:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     449:	89 44 24 24          	mov    DWORD PTR [esp+0x24],eax
     44d:	89 54 24 28          	mov    DWORD PTR [esp+0x28],edx
     451:	8d 45 cc             	lea    eax,[ebp-0x34]
     454:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
     458:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     45b:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
     45f:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     462:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
     466:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     469:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
     46d:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     470:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
     474:	89 74 24 0c          	mov    DWORD PTR [esp+0xc],esi
     478:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
     47c:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
     480:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     483:	89 04 24             	mov    DWORD PTR [esp],eax
     486:	e8 fc ff ff ff       	call   487 <mm_pmue_get_range+0x120>
     48b:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
								lvl - 1, pg_ct, pr, pr_ct, n_pr, &bs, base);
						/* set counts */
						rv += rv2;
     48e:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     491:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
     494:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     497:	29 45 18             	sub    DWORD PTR [ebp+0x18],eax
						pr += *n_pr - prr;
     49a:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     49d:	8b 00                	mov    eax,DWORD PTR [eax]
     49f:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
     4a2:	89 c2                	mov    edx,eax
     4a4:	89 d0                	mov    eax,edx
     4a6:	01 c0                	add    eax,eax
     4a8:	01 d0                	add    eax,edx
     4aa:	c1 e0 02             	shl    eax,0x2
     4ad:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
						pr_ct -= *n_pr - prr;
     4b0:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     4b3:	8b 00                	mov    eax,DWORD PTR [eax]
     4b5:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     4b8:	29 c2                	sub    edx,eax
     4ba:	01 55 20             	add    DWORD PTR [ebp+0x20],edx
						/* update by checking bits set in range */
						if (bs == 2) {
     4bd:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     4c0:	83 f8 02             	cmp    eax,0x2
     4c3:	75 16                	jne    4db <mm_pmue_get_range+0x174>
								asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     4c5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     4c8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     4cb:	0f ab 02             	bts    DWORD PTR [edx],eax
								(*bsir)++;
     4ce:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     4d1:	8b 00                	mov    eax,DWORD PTR [eax]
     4d3:	8d 50 01             	lea    edx,[eax+0x1]
     4d6:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     4d9:	89 10                	mov    DWORD PTR [eax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct & !rv2))
     4db:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     4df:	0f 84 16 01 00 00    	je     5fb <mm_pmue_get_range+0x294>
     4e5:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     4e8:	0b 45 d0             	or     eax,DWORD PTR [ebp-0x30]
     4eb:	85 c0                	test   eax,eax
     4ed:	0f 84 08 01 00 00    	je     5fb <mm_pmue_get_range+0x294>
						/* check for done */
						if (!pg_ct)
								break;

				}
				continue;
     4f3:	e9 f2 00 00 00       	jmp    5ea <mm_pmue_get_range+0x283>
						uint64_t b = base + i * 4096, bp = 1;
     4f8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     4fb:	c1 e0 0c             	shl    eax,0xc
     4fe:	89 c1                	mov    ecx,eax
     500:	bb 00 00 00 00       	mov    ebx,0x0
     505:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     508:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     50b:	01 c8                	add    eax,ecx
     50d:	11 da                	adc    edx,ebx
     50f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     512:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     515:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
     51c:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     523:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     526:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     529:	0f ab 02             	bts    DWORD PTR [edx],eax
						if (*n_pr)
     52c:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     52f:	8b 00                	mov    eax,DWORD PTR [eax]
     531:	85 c0                	test   eax,eax
     533:	74 26                	je     55b <mm_pmue_get_range+0x1f4>
								bp = pr[-1].base + 4096 * pr[-1].count;
     535:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     538:	83 e8 0c             	sub    eax,0xc
     53b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     53e:	8b 00                	mov    eax,DWORD PTR [eax]
     540:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
     543:	83 e9 0c             	sub    ecx,0xc
     546:	8b 49 08             	mov    ecx,DWORD PTR [ecx+0x8]
     549:	c1 e1 0c             	shl    ecx,0xc
     54c:	bb 00 00 00 00       	mov    ebx,0x0
     551:	01 c8                	add    eax,ecx
     553:	11 da                	adc    edx,ebx
     555:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     558:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						if (b == bp)
     55b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     55e:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     561:	89 c1                	mov    ecx,eax
     563:	89 c8                	mov    eax,ecx
     565:	33 45 e0             	xor    eax,DWORD PTR [ebp-0x20]
     568:	33 55 e4             	xor    edx,DWORD PTR [ebp-0x1c]
     56b:	09 d0                	or     eax,edx
     56d:	75 11                	jne    580 <mm_pmue_get_range+0x219>
								pr[-1].count++;
     56f:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     572:	83 e8 0c             	sub    eax,0xc
     575:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     578:	83 c2 01             	add    edx,0x1
     57b:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
     57e:	eb 3e                	jmp    5be <mm_pmue_get_range+0x257>
								if (!pr_ct) { /* rollback */
     580:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     584:	75 0b                	jne    591 <mm_pmue_get_range+0x22a>
										asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     586:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     589:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     58c:	0f bb 02             	btc    DWORD PTR [edx],eax
										break;
     58f:	eb 6a                	jmp    5fb <mm_pmue_get_range+0x294>
								pr->base = b;
     591:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
     594:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     597:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     59a:	89 01                	mov    DWORD PTR [ecx],eax
     59c:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								pr->count = 1;
     59f:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     5a2:	c7 40 08 01 00 00 00 	mov    DWORD PTR [eax+0x8],0x1
								pr_ct--;
     5a9:	83 6d 20 01          	sub    DWORD PTR [ebp+0x20],0x1
								(*n_pr)++;
     5ad:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     5b0:	8b 00                	mov    eax,DWORD PTR [eax]
     5b2:	8d 50 01             	lea    edx,[eax+0x1]
     5b5:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     5b8:	89 10                	mov    DWORD PTR [eax],edx
								pr++;
     5ba:	83 45 1c 0c          	add    DWORD PTR [ebp+0x1c],0xc
						rv++;
     5be:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
						pg_ct--;
     5c2:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
						(*bsir)++;
     5c6:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     5c9:	8b 00                	mov    eax,DWORD PTR [eax]
     5cb:	8d 50 01             	lea    edx,[eax+0x1]
     5ce:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     5d1:	89 10                	mov    DWORD PTR [eax],edx
						if (!pg_ct)
     5d3:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     5d7:	75 11                	jne    5ea <mm_pmue_get_range+0x283>
								break;
     5d9:	eb 20                	jmp    5fb <mm_pmue_get_range+0x294>

carry:
				(*bsir)++;
     5db:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     5de:	8b 00                	mov    eax,DWORD PTR [eax]
     5e0:	8d 50 01             	lea    edx,[eax+0x1]
     5e3:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     5e6:	89 10                	mov    DWORD PTR [eax],edx
     5e8:	eb 01                	jmp    5eb <mm_pmue_get_range+0x284>
				continue;
     5ea:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
     5eb:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     5ef:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     5f2:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
     5f5:	0f 83 0c fe ff ff    	jae    407 <mm_pmue_get_range+0xa0>
		}

		return rv;
     5fb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     5fe:	83 c4 70             	add    esp,0x70
     601:	5b                   	pop    ebx
     602:	5e                   	pop    esi
     603:	5d                   	pop    ebp
     604:	c3                   	ret

00000605 <mm_rcpe_get_range>:

uint32_t mm_rcpe_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bfir, uint64_t base)
{
     605:	55                   	push   ebp
     606:	89 e5                	mov    ebp,esp
     608:	56                   	push   esi
     609:	53                   	push   ebx
     60a:	83 ec 70             	sub    esp,0x70
     60d:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
     610:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
     613:	8b 45 30             	mov    eax,DWORD PTR [ebp+0x30]
     616:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		uint32_t* bitfield, rv = 0;
     619:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0

		/* set the reference */
		switch (lvl) {
     620:	83 7d 14 07          	cmp    DWORD PTR [ebp+0x14],0x7
     624:	74 14                	je     63a <mm_rcpe_get_range+0x35>
     626:	83 7d 14 07          	cmp    DWORD PTR [ebp+0x14],0x7
     62a:	77 32                	ja     65e <mm_rcpe_get_range+0x59>
     62c:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     630:	74 22                	je     654 <mm_rcpe_get_range+0x4f>
     632:	83 7d 14 02          	cmp    DWORD PTR [ebp+0x14],0x2
     636:	74 0f                	je     647 <mm_rcpe_get_range+0x42>
     638:	eb 24                	jmp    65e <mm_rcpe_get_range+0x59>
				case 7:
						bitfield = &p->lvl7;
     63a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     63d:	05 f8 03 00 00       	add    eax,0x3f8
     642:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     645:	eb 19                	jmp    660 <mm_rcpe_get_range+0x5b>
				case 2:
						bitfield = p->lvl2;
     647:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     64a:	05 00 03 00 00       	add    eax,0x300
     64f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     652:	eb 0c                	jmp    660 <mm_rcpe_get_range+0x5b>
				case 0:
						bitfield = p->lvl0;
     654:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     657:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
     65a:	eb 04                	jmp    660 <mm_rcpe_get_range+0x5b>
     65c:	eb 00                	jmp    65e <mm_rcpe_get_range+0x59>
				default:
						while (1);
     65e:	eb fc                	jmp    65c <mm_rcpe_get_range+0x57>
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
     660:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     663:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     666:	e9 29 02 00 00       	jmp    894 <mm_rcpe_get_range+0x28f>
				/* test each bit */
				asm goto("bt %0, %1\n"
     66b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     66e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     671:	0f a3 02             	bt     DWORD PTR [edx],eax
     674:	0f 83 06 02 00 00    	jae    880 <mm_rcpe_get_range+0x27b>
						 "jnc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : nocarry);

				/* we've got a reclaimable entry at i */
				if (lvl > 0) {
     67a:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     67e:	0f 84 07 01 00 00    	je     78b <mm_rcpe_get_range+0x186>
						uint32_t rv2, prr = *n_pr, bf = 0, mul;
     684:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     687:	8b 00                	mov    eax,DWORD PTR [eax]
     689:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     68c:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
						mul = (lvl == 2) ? 4 : 32;
     693:	83 7d 14 02          	cmp    DWORD PTR [ebp+0x14],0x2
     697:	75 07                	jne    6a0 <mm_rcpe_get_range+0x9b>
     699:	b8 04 00 00 00       	mov    eax,0x4
     69e:	eb 05                	jmp    6a5 <mm_rcpe_get_range+0xa0>
     6a0:	b8 20 00 00 00       	mov    eax,0x20
     6a5:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
						/* go deeper */
						rv2 = mm_rcpe_get_range(p, i * mul, (i + 1) * mul - 1,
     6a8:	83 7d 14 02          	cmp    DWORD PTR [ebp+0x14],0x2
     6ac:	75 07                	jne    6b5 <mm_rcpe_get_range+0xb0>
     6ae:	be 00 00 00 00       	mov    esi,0x0
     6b3:	eb 05                	jmp    6ba <mm_rcpe_get_range+0xb5>
     6b5:	be 02 00 00 00       	mov    esi,0x2
     6ba:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     6bd:	83 c0 01             	add    eax,0x1
     6c0:	0f af 45 d0          	imul   eax,DWORD PTR [ebp-0x30]
     6c4:	8d 58 ff             	lea    ebx,[eax-0x1]
     6c7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     6ca:	0f af 45 d0          	imul   eax,DWORD PTR [ebp-0x30]
     6ce:	89 c1                	mov    ecx,eax
     6d0:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     6d3:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     6d6:	89 44 24 24          	mov    DWORD PTR [esp+0x24],eax
     6da:	89 54 24 28          	mov    DWORD PTR [esp+0x28],edx
     6de:	8d 45 c8             	lea    eax,[ebp-0x38]
     6e1:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
     6e5:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     6e8:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
     6ec:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     6ef:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
     6f3:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     6f6:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
     6fa:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     6fd:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
     701:	89 74 24 0c          	mov    DWORD PTR [esp+0xc],esi
     705:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
     709:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
     70d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     710:	89 04 24             	mov    DWORD PTR [esp],eax
     713:	e8 fc ff ff ff       	call   714 <mm_rcpe_get_range+0x10f>
     718:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
								(lvl == 2) ? 0 : 2, pg_ct, pr, pr_ct, n_pr, &bf, base);
						/* set counts */
						rv += rv2;
     71b:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     71e:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
     721:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     724:	29 45 18             	sub    DWORD PTR [ebp+0x18],eax
						pr += *n_pr - prr;
     727:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     72a:	8b 00                	mov    eax,DWORD PTR [eax]
     72c:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
     72f:	89 c2                	mov    edx,eax
     731:	89 d0                	mov    eax,edx
     733:	01 c0                	add    eax,eax
     735:	01 d0                	add    eax,edx
     737:	c1 e0 02             	shl    eax,0x2
     73a:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
						pr_ct -= *n_pr - prr;
     73d:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     740:	8b 00                	mov    eax,DWORD PTR [eax]
     742:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     745:	29 c2                	sub    edx,eax
     747:	01 55 20             	add    DWORD PTR [ebp+0x20],edx
						/* update by checking bits free in range */
						if (bf == mul) {
     74a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     74d:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
     750:	75 16                	jne    768 <mm_rcpe_get_range+0x163>
								asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     752:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     755:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     758:	0f bb 02             	btc    DWORD PTR [edx],eax
								(*bfir)++;
     75b:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     75e:	8b 00                	mov    eax,DWORD PTR [eax]
     760:	8d 50 01             	lea    edx,[eax+0x1]
     763:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     766:	89 10                	mov    DWORD PTR [eax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct && !rv2))
     768:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     76c:	0f 84 2e 01 00 00    	je     8a0 <mm_rcpe_get_range+0x29b>
     772:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     776:	0f 85 13 01 00 00    	jne    88f <mm_rcpe_get_range+0x28a>
     77c:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
     780:	0f 84 1a 01 00 00    	je     8a0 <mm_rcpe_get_range+0x29b>
						mm_scrub_single_page(b);
						/* check for done */
						if (!pg_ct)
								break;
				}
				continue;
     786:	e9 04 01 00 00       	jmp    88f <mm_rcpe_get_range+0x28a>
						uint64_t b = base + i * 4096, bp = 1;
     78b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     78e:	c1 e0 0c             	shl    eax,0xc
     791:	89 c1                	mov    ecx,eax
     793:	bb 00 00 00 00       	mov    ebx,0x0
     798:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     79b:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     79e:	01 c8                	add    eax,ecx
     7a0:	11 da                	adc    edx,ebx
     7a2:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     7a5:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     7a8:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
     7af:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     7b6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     7b9:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     7bc:	0f bb 02             	btc    DWORD PTR [edx],eax
						if (*n_pr)
     7bf:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     7c2:	8b 00                	mov    eax,DWORD PTR [eax]
     7c4:	85 c0                	test   eax,eax
     7c6:	74 26                	je     7ee <mm_rcpe_get_range+0x1e9>
								bp = pr[-1].base + 4096 * pr[-1].count;
     7c8:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     7cb:	83 e8 0c             	sub    eax,0xc
     7ce:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     7d1:	8b 00                	mov    eax,DWORD PTR [eax]
     7d3:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
     7d6:	83 e9 0c             	sub    ecx,0xc
     7d9:	8b 49 08             	mov    ecx,DWORD PTR [ecx+0x8]
     7dc:	c1 e1 0c             	shl    ecx,0xc
     7df:	bb 00 00 00 00       	mov    ebx,0x0
     7e4:	01 c8                	add    eax,ecx
     7e6:	11 da                	adc    edx,ebx
     7e8:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     7eb:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
						if (b == bp)
     7ee:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     7f1:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     7f4:	89 c1                	mov    ecx,eax
     7f6:	89 c8                	mov    eax,ecx
     7f8:	33 45 e0             	xor    eax,DWORD PTR [ebp-0x20]
     7fb:	33 55 e4             	xor    edx,DWORD PTR [ebp-0x1c]
     7fe:	09 d0                	or     eax,edx
     800:	75 11                	jne    813 <mm_rcpe_get_range+0x20e>
								pr[-1].count++;
     802:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     805:	83 e8 0c             	sub    eax,0xc
     808:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     80b:	83 c2 01             	add    edx,0x1
     80e:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
     811:	eb 3e                	jmp    851 <mm_rcpe_get_range+0x24c>
								if (!pr_ct) { /* rollback */
     813:	83 7d 20 00          	cmp    DWORD PTR [ebp+0x20],0x0
     817:	75 0b                	jne    824 <mm_rcpe_get_range+0x21f>
										asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     819:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     81c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     81f:	0f ab 02             	bts    DWORD PTR [edx],eax
										break;
     822:	eb 7c                	jmp    8a0 <mm_rcpe_get_range+0x29b>
								pr->base = b;
     824:	8b 4d 1c             	mov    ecx,DWORD PTR [ebp+0x1c]
     827:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     82a:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     82d:	89 01                	mov    DWORD PTR [ecx],eax
     82f:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
								pr->count = 1;
     832:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     835:	c7 40 08 01 00 00 00 	mov    DWORD PTR [eax+0x8],0x1
								pr_ct--;
     83c:	83 6d 20 01          	sub    DWORD PTR [ebp+0x20],0x1
								(*n_pr)++;
     840:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     843:	8b 00                	mov    eax,DWORD PTR [eax]
     845:	8d 50 01             	lea    edx,[eax+0x1]
     848:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     84b:	89 10                	mov    DWORD PTR [eax],edx
								pr++;
     84d:	83 45 1c 0c          	add    DWORD PTR [ebp+0x1c],0xc
						rv++;
     851:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
						pg_ct--;
     855:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
						(*bfir)++;
     859:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     85c:	8b 00                	mov    eax,DWORD PTR [eax]
     85e:	8d 50 01             	lea    edx,[eax+0x1]
     861:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     864:	89 10                	mov    DWORD PTR [eax],edx
						mm_scrub_single_page(b);
     866:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     869:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     86c:	89 04 24             	mov    DWORD PTR [esp],eax
     86f:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     873:	e8 fc ff ff ff       	call   874 <mm_rcpe_get_range+0x26f>
						if (!pg_ct)
     878:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     87c:	75 11                	jne    88f <mm_rcpe_get_range+0x28a>
								break;
     87e:	eb 20                	jmp    8a0 <mm_rcpe_get_range+0x29b>

nocarry:
				(*bfir)++;
     880:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     883:	8b 00                	mov    eax,DWORD PTR [eax]
     885:	8d 50 01             	lea    edx,[eax+0x1]
     888:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     88b:	89 10                	mov    DWORD PTR [eax],edx
     88d:	eb 01                	jmp    890 <mm_rcpe_get_range+0x28b>
				continue;
     88f:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
     890:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     894:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     897:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
     89a:	0f 83 cb fd ff ff    	jae    66b <mm_rcpe_get_range+0x66>
		}

		return rv;
     8a0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     8a3:	83 c4 70             	add    esp,0x70
     8a6:	5b                   	pop    ebx
     8a7:	5e                   	pop    esi
     8a8:	5d                   	pop    ebp
     8a9:	c3                   	ret

000008aa <mm_fmrc_get>:

/* is used to really set entries in a pmu/rcp */
uint32_t mm_fmrc_get(struct pmu* p, uint32_t idx, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr, uint64_t base)
{
     8aa:	55                   	push   ebp
     8ab:	89 e5                	mov    ebp,esp
     8ad:	53                   	push   ebx
     8ae:	83 ec 74             	sub    esp,0x74
     8b1:	8b 45 24             	mov    eax,DWORD PTR [ebp+0x24]
     8b4:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
     8b7:	8b 45 28             	mov    eax,DWORD PTR [ebp+0x28]
     8ba:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		size_t i; uint32_t msk = 0x00000003, rv = 0;
     8bd:	c7 45 f0 03 00 00 00 	mov    DWORD PTR [ebp-0x10],0x3
     8c4:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		struct pmue* e = &p->entries[idx];
     8cb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8ce:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
     8d4:	8d 50 10             	lea    edx,[eax+0x10]
     8d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8da:	01 d0                	add    eax,edx
     8dc:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		/* lock is 2 lvl7 bits wide (256 pages) so use it sparingly */

		/* first skip all full/empty lvl7 ranges (2 at a time) */
		uint32_t prc = 0;
     8df:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
		for (i = 0; i < 16; i++) {
     8e6:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     8ed:	e9 a4 01 00 00       	jmp    a96 <mm_fmrc_get+0x1ec>
				uint8_t bt = ((e->lvl7 & msk) >> 2 * i);
     8f2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     8f5:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [eax+0x3f8]
     8fb:	23 45 f0             	and    eax,DWORD PTR [ebp-0x10]
     8fe:	89 c2                	mov    edx,eax
     900:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     903:	01 c0                	add    eax,eax
     905:	89 c1                	mov    ecx,eax
     907:	d3 ea                	shr    edx,cl
     909:	89 d0                	mov    eax,edx
     90b:	88 45 e3             	mov    BYTE PTR [ebp-0x1d],al
				if (free ? (bt != 3) : (bt)) { /* all set/unset */
     90e:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     912:	74 09                	je     91d <mm_fmrc_get+0x73>
     914:	80 7d e3 03          	cmp    BYTE PTR [ebp-0x1d],0x3
     918:	0f 95 c0             	setne  al
     91b:	eb 07                	jmp    924 <mm_fmrc_get+0x7a>
     91d:	80 7d e3 00          	cmp    BYTE PTR [ebp-0x1d],0x0
     921:	0f 95 c0             	setne  al
     924:	84 c0                	test   al,al
     926:	0f 84 61 01 00 00    	je     a8d <mm_fmrc_get+0x1e3>
						uint32_t rv2 = 0, pcc = prc, bsir = 0;
     92c:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
     933:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     936:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     939:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
						/* some bits set: try to lock */
						asm goto("lock bts %0, %1\n"
							"jc %l2\n" : : "r" (idx * 16 + 2 * i),
     940:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     943:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     94a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     94d:	01 d0                	add    eax,edx
     94f:	8d 14 00             	lea    edx,[eax+eax*1]
						asm goto("lock bts %0, %1\n"
     952:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     955:	f0 0f ab 10          	lock bts DWORD PTR [eax],edx
     959:	0f 82 2f 01 00 00    	jb     a8e <mm_fmrc_get+0x1e4>
							"m" (*p->locks) : "cc" : carry);

						/* we hold the lock (else jump to carry) */
						if (free)
     95f:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     963:	74 5f                	je     9c4 <mm_fmrc_get+0x11a>
								rv2 = mm_pmue_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
     965:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     968:	01 c0                	add    eax,eax
     96a:	8d 58 01             	lea    ebx,[eax+0x1]
     96d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     970:	8d 0c 00             	lea    ecx,[eax+eax*1]
     973:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     976:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     979:	89 44 24 24          	mov    DWORD PTR [esp+0x24],eax
     97d:	89 54 24 28          	mov    DWORD PTR [esp+0x28],edx
     981:	8d 45 d4             	lea    eax,[ebp-0x2c]
     984:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
     988:	8d 45 d8             	lea    eax,[ebp-0x28]
     98b:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
     98f:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     992:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
     996:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     999:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
     99d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     9a0:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
     9a4:	c7 44 24 0c 07 00 00 00 	mov    DWORD PTR [esp+0xc],0x7
     9ac:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
     9b0:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
     9b4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     9b7:	89 04 24             	mov    DWORD PTR [esp],eax
     9ba:	e8 fc ff ff ff       	call   9bb <mm_fmrc_get+0x111>
     9bf:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     9c2:	eb 5d                	jmp    a21 <mm_fmrc_get+0x177>
										pr, pr_ct, &prc, &bsir, base);
						else
								rv2 = mm_rcpe_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
     9c4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9c7:	01 c0                	add    eax,eax
     9c9:	8d 58 01             	lea    ebx,[eax+0x1]
     9cc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     9cf:	8d 0c 00             	lea    ecx,[eax+eax*1]
     9d2:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
     9d5:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
     9d8:	89 44 24 24          	mov    DWORD PTR [esp+0x24],eax
     9dc:	89 54 24 28          	mov    DWORD PTR [esp+0x28],edx
     9e0:	8d 45 d4             	lea    eax,[ebp-0x2c]
     9e3:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
     9e7:	8d 45 d8             	lea    eax,[ebp-0x28]
     9ea:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
     9ee:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     9f1:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
     9f5:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     9f8:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
     9fc:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     9ff:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
     a03:	c7 44 24 0c 07 00 00 00 	mov    DWORD PTR [esp+0xc],0x7
     a0b:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
     a0f:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
     a13:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     a16:	89 04 24             	mov    DWORD PTR [esp],eax
     a19:	e8 fc ff ff ff       	call   a1a <mm_fmrc_get+0x170>
     a1e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										pr, pr_ct, &prc, &bsir, base);
						pr_ct -= prc - pcc;
     a21:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     a24:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     a27:	29 c2                	sub    edx,eax
     a29:	01 55 1c             	add    DWORD PTR [ebp+0x1c],edx
						pr += prc - pcc;
     a2c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     a2f:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
     a32:	89 c2                	mov    edx,eax
     a34:	89 d0                	mov    eax,edx
     a36:	01 c0                	add    eax,eax
     a38:	01 d0                	add    eax,edx
     a3a:	c1 e0 02             	shl    eax,0x2
     a3d:	01 45 18             	add    DWORD PTR [ebp+0x18],eax
						*n_pr += prc - pcc;
     a40:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     a43:	8b 10                	mov    edx,DWORD PTR [eax]
     a45:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     a48:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
     a4b:	01 c2                	add    edx,eax
     a4d:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     a50:	89 10                	mov    DWORD PTR [eax],edx
						rv += rv2;
     a52:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     a55:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
						pg_ct -= rv2;
     a58:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     a5b:	29 45 10             	sub    DWORD PTR [ebp+0x10],eax

						/* release lock */
						asm("btr %0, %1\n" : : "r" (idx * 16 + 2 * i),
     a5e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a61:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
     a68:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a6b:	01 d0                	add    eax,edx
     a6d:	8d 14 00             	lea    edx,[eax+eax*1]
     a70:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a73:	0f b3 10             	btr    DWORD PTR [eax],edx
							"m" (*p->locks) : "cc");

						if (!pg_ct || (!pr_ct && !rv2))
     a76:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     a7a:	74 0c                	je     a88 <mm_fmrc_get+0x1de>
     a7c:	83 7d 1c 00          	cmp    DWORD PTR [ebp+0x1c],0x0
     a80:	75 0c                	jne    a8e <mm_fmrc_get+0x1e4>
     a82:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     a86:	75 06                	jne    a8e <mm_fmrc_get+0x1e4>
								return rv;
     a88:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     a8b:	eb 16                	jmp    aa3 <mm_fmrc_get+0x1f9>
				}
carry:
     a8d:	90                   	nop
				/* advance */
				msk <<= 2;
     a8e:	c1 65 f0 02          	shl    DWORD PTR [ebp-0x10],0x2
		for (i = 0; i < 16; i++) {
     a92:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     a96:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
     a9a:	0f 86 52 fe ff ff    	jbe    8f2 <mm_fmrc_get+0x48>
		}

		return rv;
     aa0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
     aa3:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     aa6:	c9                   	leave
     aa7:	c3                   	ret

00000aa8 <mm_fmrc_alloc_pm>:

/* used for getting pages which are marked as free/reclaimable */
uint32_t mm_fmrc_alloc_pm(struct fme* fm, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr)
{
     aa8:	55                   	push   ebp
     aa9:	89 e5                	mov    ebp,esp
     aab:	53                   	push   ebx
     aac:	83 ec 64             	sub    esp,0x64
		uint32_t rv = 0; uint64_t base = fm->base;
     aaf:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     ab6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ab9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     abc:	8b 00                	mov    eax,DWORD PTR [eax]
     abe:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     ac1:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		size_t i, j; uint64_t mem = (free ? fm->pmu : fm->rcp);
     ac4:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     ac8:	74 0b                	je     ad5 <mm_fmrc_alloc_pm+0x2d>
     aca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     acd:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
     ad0:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
     ad3:	eb 09                	jmp    ade <mm_fmrc_alloc_pm+0x36>
     ad5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ad8:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
     adb:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
     ade:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
     ae1:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx

		for (i = 0; i < fm->ec; i++) {
     ae4:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
     aeb:	e9 31 01 00 00       	jmp    c21 <mm_fmrc_alloc_pm+0x179>
				struct pmu* p = (void*)(size_t)mem;
     af0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     af3:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				/* skip if above limit */
				/*if (mem + 4096 > 0x100000000)
						break; - no idea what that was */ 

				/* operate on pmu/rcp */
				if (p->free_ct[0] == 0xffff) {
     af6:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     af9:	0f b7 40 08          	movzx  eax,WORD PTR [eax+0x8]
     afd:	66 83 f8 ff          	cmp    ax,0xffff
     b01:	75 2d                	jne    b30 <mm_fmrc_alloc_pm+0x88>
						if (free) {
     b03:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     b07:	74 14                	je     b1d <mm_fmrc_alloc_pm+0x75>
								if (mm_init_pmu(p))
     b09:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     b0c:	89 04 24             	mov    DWORD PTR [esp],eax
     b0f:	e8 fc ff ff ff       	call   b10 <mm_fmrc_alloc_pm+0x68>
     b14:	85 c0                	test   eax,eax
     b16:	74 18                	je     b30 <mm_fmrc_alloc_pm+0x88>
										continue; /* if locked */
     b18:	e9 00 01 00 00       	jmp    c1d <mm_fmrc_alloc_pm+0x175>
						} else {
								if (mm_init_rcp(p))
     b1d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     b20:	89 04 24             	mov    DWORD PTR [esp],eax
     b23:	e8 fc ff ff ff       	call   b24 <mm_fmrc_alloc_pm+0x7c>
     b28:	85 c0                	test   eax,eax
     b2a:	0f 85 ec 00 00 00    	jne    c1c <mm_fmrc_alloc_pm+0x174>
										continue; /* if locked */
						}
				}

				/* check for free/reclaimable counts */
				for (j = 0; j < 4; j++) {
     b30:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
     b37:	e9 d4 00 00 00       	jmp    c10 <mm_fmrc_alloc_pm+0x168>
						if (p->free_ct[j] > 0) {
     b3c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     b3f:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     b42:	0f b7 44 50 08       	movzx  eax,WORD PTR [eax+edx*2+0x8]
     b47:	66 85 c0             	test   ax,ax
     b4a:	0f 84 b1 00 00 00    	je     c01 <mm_fmrc_alloc_pm+0x159>
								uint32_t rv2, np = 0;
     b50:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
								/* operate on lock */
								rv2 = mm_fmrc_get(p, j, pg_ct, free, pr,
     b57:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     b5a:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     b5d:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
     b61:	89 54 24 20          	mov    DWORD PTR [esp+0x20],edx
     b65:	8d 45 cc             	lea    eax,[ebp-0x34]
     b68:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
     b6c:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     b6f:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
     b73:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     b76:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
     b7a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     b7d:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
     b81:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b84:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     b88:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b8b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     b8f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     b92:	89 04 24             	mov    DWORD PTR [esp],eax
     b95:	e8 fc ff ff ff       	call   b96 <mm_fmrc_alloc_pm+0xee>
     b9a:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
												pr_ct, &np, base);

								*n_pr += np;
     b9d:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     ba0:	8b 10                	mov    edx,DWORD PTR [eax]
     ba2:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     ba5:	01 c2                	add    edx,eax
     ba7:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     baa:	89 10                	mov    DWORD PTR [eax],edx
								pr_ct -= np;
     bac:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     baf:	29 45 18             	sub    DWORD PTR [ebp+0x18],eax
								pr += np;
     bb2:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     bb5:	89 d0                	mov    eax,edx
     bb7:	01 c0                	add    eax,eax
     bb9:	01 d0                	add    eax,edx
     bbb:	c1 e0 02             	shl    eax,0x2
     bbe:	01 45 14             	add    DWORD PTR [ebp+0x14],eax
								rv += rv2;
     bc1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     bc4:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
								pg_ct -= rv2;
     bc7:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     bca:	29 45 0c             	sub    DWORD PTR [ebp+0xc],eax
								/* update count */
								p->free_ct[j] -= rv2;
     bcd:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     bd0:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     bd3:	0f b7 44 50 08       	movzx  eax,WORD PTR [eax+edx*2+0x8]
     bd8:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     bdb:	29 d0                	sub    eax,edx
     bdd:	89 c1                	mov    ecx,eax
     bdf:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     be2:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     be5:	66 89 4c 50 08       	mov    WORD PTR [eax+edx*2+0x8],cx
								/* exit if done or list exhausted (and no extension) */
								if (!pg_ct || (!pr_ct && !rv2))
     bea:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     bee:	74 0c                	je     bfc <mm_fmrc_alloc_pm+0x154>
     bf0:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
     bf4:	75 0b                	jne    c01 <mm_fmrc_alloc_pm+0x159>
     bf6:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
     bfa:	75 05                	jne    c01 <mm_fmrc_alloc_pm+0x159>
										return rv;
     bfc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     bff:	eb 3e                	jmp    c3f <mm_fmrc_alloc_pm+0x197>
						}

						/* advance base */
						base += 4096 * 4096;
     c01:	81 45 e8 00 00 00 01 	add    DWORD PTR [ebp-0x18],0x1000000
     c08:	83 55 ec 00          	adc    DWORD PTR [ebp-0x14],0x0
				for (j = 0; j < 4; j++) {
     c0c:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
     c10:	83 7d e0 03          	cmp    DWORD PTR [ebp-0x20],0x3
     c14:	0f 86 22 ff ff ff    	jbe    b3c <mm_fmrc_alloc_pm+0x94>
     c1a:	eb 01                	jmp    c1d <mm_fmrc_alloc_pm+0x175>
										continue; /* if locked */
     c1c:	90                   	nop
		for (i = 0; i < fm->ec; i++) {
     c1d:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
     c21:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     c24:	bb 00 00 00 00       	mov    ebx,0x0
     c29:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c2c:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
     c2f:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
     c32:	39 c1                	cmp    ecx,eax
     c34:	19 d3                	sbb    ebx,edx
     c36:	0f 82 b4 fe ff ff    	jb     af0 <mm_fmrc_alloc_pm+0x48>
				}
		}

		return rv;
     c3c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
     c3f:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     c42:	c9                   	leave
     c43:	c3                   	ret

00000c44 <mm_alloc_pm>:

uint32_t mm_alloc_pm(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct)
{
     c44:	55                   	push   ebp
     c45:	89 e5                	mov    ebp,esp
     c47:	56                   	push   esi
     c48:	53                   	push   ebx
     c49:	83 ec 50             	sub    esp,0x50
		size_t i; uint32_t rv = 0, r2 = 0, pr_o = 0;
     c4c:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     c53:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     c5a:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0

retry:
		for (i = fm_begin; i < fm_ofs; i++) {
     c61:	a1 00 00 00 00       	mov    eax,ds:0x0
     c66:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     c69:	e9 df 01 00 00       	jmp    e4d <mm_alloc_pm+0x209>
				/* skip if scrubbing is needed */
				if (!r2 && !fmm[i].free_pages)
     c6e:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     c72:	75 1f                	jne    c93 <mm_alloc_pm+0x4f>
     c74:	ba 00 40 02 00       	mov    edx,0x24000
     c79:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c7c:	6b c0 38             	imul   eax,eax,0x38
     c7f:	01 d0                	add    eax,edx
     c81:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     c84:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     c87:	89 c1                	mov    ecx,eax
     c89:	89 c8                	mov    eax,ecx
     c8b:	09 d0                	or     eax,edx
     c8d:	0f 84 b2 01 00 00    	je     e45 <mm_alloc_pm+0x201>
						continue;

				/* collect free pages */
				if (fmm[i].free_pages) {
     c93:	ba 00 40 02 00       	mov    edx,0x24000
     c98:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c9b:	6b c0 38             	imul   eax,eax,0x38
     c9e:	01 d0                	add    eax,edx
     ca0:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
     ca3:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     ca6:	89 c1                	mov    ecx,eax
     ca8:	89 c8                	mov    eax,ecx
     caa:	09 d0                	or     eax,edx
     cac:	0f 84 be 00 00 00    	je     d70 <mm_alloc_pm+0x12c>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 1, pr + pr_o,
     cb2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     cb5:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     cb8:	89 d3                	mov    ebx,edx
     cba:	29 c3                	sub    ebx,eax
     cbc:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     cbf:	89 d0                	mov    eax,edx
     cc1:	01 c0                	add    eax,eax
     cc3:	01 d0                	add    eax,edx
     cc5:	c1 e0 02             	shl    eax,0x2
     cc8:	89 c2                	mov    edx,eax
     cca:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ccd:	8d 0c 02             	lea    ecx,[edx+eax*1]
     cd0:	ba 00 40 02 00       	mov    edx,0x24000
     cd5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     cd8:	6b c0 38             	imul   eax,eax,0x38
     cdb:	01 c2                	add    edx,eax
     cdd:	8d 45 e0             	lea    eax,[ebp-0x20]
     ce0:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
     ce4:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
     ce8:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     cec:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
     cf4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cf7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     cfb:	89 14 24             	mov    DWORD PTR [esp],edx
     cfe:	e8 fc ff ff ff       	call   cff <mm_alloc_pm+0xbb>
     d03:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
     d06:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     d09:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
     d0c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     d0f:	29 45 08             	sub    DWORD PTR [ebp+0x8],eax
						__sync_sub_and_fetch(&fmm[i].free_pages, rv2);
     d12:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     d15:	ba 00 00 00 00       	mov    edx,0x0
     d1a:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
     d1d:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
     d20:	ba 00 40 02 00       	mov    edx,0x24000
     d25:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d28:	6b c0 38             	imul   eax,eax,0x38
     d2b:	01 d0                	add    eax,edx
     d2d:	8d 70 10             	lea    esi,[eax+0x10]
     d30:	8b 06                	mov    eax,DWORD PTR [esi]
     d32:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
     d35:	89 c1                	mov    ecx,eax
     d37:	89 d3                	mov    ebx,edx
     d39:	2b 4d c8             	sub    ecx,DWORD PTR [ebp-0x38]
     d3c:	1b 5d cc             	sbb    ebx,DWORD PTR [ebp-0x34]
     d3f:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
     d42:	89 5d d4             	mov    DWORD PTR [ebp-0x2c],ebx
     d45:	8b 5d d0             	mov    ebx,DWORD PTR [ebp-0x30]
     d48:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     d4b:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
     d4f:	0f 94 c1             	sete   cl
     d52:	84 c9                	test   cl,cl
     d54:	74 df                	je     d35 <mm_alloc_pm+0xf1>
						if (pg_ct && !r2) /* skip scrub for now */
     d56:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     d5a:	74 0a                	je     d66 <mm_alloc_pm+0x122>
     d5c:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     d60:	0f 84 e2 00 00 00    	je     e48 <mm_alloc_pm+0x204>
								continue;
						else if (!pg_ct)
     d66:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     d6a:	0f 84 03 01 00 00    	je     e73 <mm_alloc_pm+0x22f>
								goto done;
				}

				/* check for reclaimable */
				if (r2 && fmm[i].reclaimable_pages) {
     d70:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     d74:	0f 84 cf 00 00 00    	je     e49 <mm_alloc_pm+0x205>
     d7a:	ba 00 40 02 00       	mov    edx,0x24000
     d7f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d82:	6b c0 38             	imul   eax,eax,0x38
     d85:	01 d0                	add    eax,edx
     d87:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     d8a:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
     d8d:	89 c1                	mov    ecx,eax
     d8f:	89 c8                	mov    eax,ecx
     d91:	09 d0                	or     eax,edx
     d93:	0f 84 b0 00 00 00    	je     e49 <mm_alloc_pm+0x205>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 0, pr + pr_o,
     d99:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     d9c:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     d9f:	89 d3                	mov    ebx,edx
     da1:	29 c3                	sub    ebx,eax
     da3:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     da6:	89 d0                	mov    eax,edx
     da8:	01 c0                	add    eax,eax
     daa:	01 d0                	add    eax,edx
     dac:	c1 e0 02             	shl    eax,0x2
     daf:	89 c2                	mov    edx,eax
     db1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     db4:	8d 0c 02             	lea    ecx,[edx+eax*1]
     db7:	ba 00 40 02 00       	mov    edx,0x24000
     dbc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     dbf:	6b c0 38             	imul   eax,eax,0x38
     dc2:	01 c2                	add    edx,eax
     dc4:	8d 45 e0             	lea    eax,[ebp-0x20]
     dc7:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
     dcb:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
     dcf:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     dd3:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
     ddb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     dde:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     de2:	89 14 24             	mov    DWORD PTR [esp],edx
     de5:	e8 fc ff ff ff       	call   de6 <mm_alloc_pm+0x1a2>
     dea:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
     ded:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     df0:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
						pg_ct -= rv2;
     df3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     df6:	29 45 08             	sub    DWORD PTR [ebp+0x8],eax
						__sync_sub_and_fetch(&fmm[i].reclaimable_pages, rv2);
     df9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     dfc:	ba 00 00 00 00       	mov    edx,0x0
     e01:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
     e04:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
     e07:	ba 00 40 02 00       	mov    edx,0x24000
     e0c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e0f:	6b c0 38             	imul   eax,eax,0x38
     e12:	01 d0                	add    eax,edx
     e14:	8d 70 18             	lea    esi,[eax+0x18]
     e17:	8b 06                	mov    eax,DWORD PTR [esi]
     e19:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
     e1c:	89 c1                	mov    ecx,eax
     e1e:	89 d3                	mov    ebx,edx
     e20:	2b 4d c8             	sub    ecx,DWORD PTR [ebp-0x38]
     e23:	1b 5d cc             	sbb    ebx,DWORD PTR [ebp-0x34]
     e26:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
     e29:	89 5d d4             	mov    DWORD PTR [ebp-0x2c],ebx
     e2c:	8b 5d d0             	mov    ebx,DWORD PTR [ebp-0x30]
     e2f:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     e32:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
     e36:	0f 94 c1             	sete   cl
     e39:	84 c9                	test   cl,cl
     e3b:	74 df                	je     e1c <mm_alloc_pm+0x1d8>
						if (!pg_ct)
     e3d:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     e41:	74 33                	je     e76 <mm_alloc_pm+0x232>
     e43:	eb 04                	jmp    e49 <mm_alloc_pm+0x205>
						continue;
     e45:	90                   	nop
     e46:	eb 01                	jmp    e49 <mm_alloc_pm+0x205>
								continue;
     e48:	90                   	nop
		for (i = fm_begin; i < fm_ofs; i++) {
     e49:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     e4d:	a1 00 00 00 00       	mov    eax,ds:0x0
     e52:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
     e55:	0f 82 13 fe ff ff    	jb     c6e <mm_alloc_pm+0x2a>
								goto done;
				}
		}

		/* scrub enabled */
		if (pg_ct && !r2) {
     e5b:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     e5f:	74 18                	je     e79 <mm_alloc_pm+0x235>
     e61:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     e65:	75 12                	jne    e79 <mm_alloc_pm+0x235>
				r2 = 1;
     e67:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
				goto retry;
     e6e:	e9 ee fd ff ff       	jmp    c61 <mm_alloc_pm+0x1d>
								goto done;
     e73:	90                   	nop
     e74:	eb 04                	jmp    e7a <mm_alloc_pm+0x236>
								goto done;
     e76:	90                   	nop
     e77:	eb 01                	jmp    e7a <mm_alloc_pm+0x236>
		}

done:
     e79:	90                   	nop
		if (!rv) { /* OOM */
     e7a:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     e7e:	75 03                	jne    e83 <mm_alloc_pm+0x23f>
				while (1);
     e80:	90                   	nop
     e81:	eb fd                	jmp    e80 <mm_alloc_pm+0x23c>
				die("OOM");
		}

		/* null-terminate */
		if (pr_o < pr_ct) {
     e83:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     e86:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
     e89:	73 3a                	jae    ec5 <mm_alloc_pm+0x281>
				pr[pr_o].base = 0;
     e8b:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     e8e:	89 d0                	mov    eax,edx
     e90:	01 c0                	add    eax,eax
     e92:	01 d0                	add    eax,edx
     e94:	c1 e0 02             	shl    eax,0x2
     e97:	89 c2                	mov    edx,eax
     e99:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e9c:	01 d0                	add    eax,edx
     e9e:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     ea4:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
				pr[pr_o].count = 0;
     eab:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     eae:	89 d0                	mov    eax,edx
     eb0:	01 c0                	add    eax,eax
     eb2:	01 d0                	add    eax,edx
     eb4:	c1 e0 02             	shl    eax,0x2
     eb7:	89 c2                	mov    edx,eax
     eb9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ebc:	01 d0                	add    eax,edx
     ebe:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
		}
		return rv;
     ec5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     ec8:	83 c4 50             	add    esp,0x50
     ecb:	5b                   	pop    ebx
     ecc:	5e                   	pop    esi
     ecd:	5d                   	pop    ebp
     ece:	c3                   	ret

00000ecf <mm_alloc_pm_flg>:

/* rcp: higher-levels<=>Exists; pmu: higher-levels: completely used */
uint32_t mm_alloc_pm_flg(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct, int flg)
{
     ecf:	55                   	push   ebp
     ed0:	89 e5                	mov    ebp,esp
     ed2:	83 ec 18             	sub    esp,0x18
		die("not implemented\n");
     ed5:	c7 44 24 04 2c 00 00 00 	mov    DWORD PTR [esp+0x4],0x2c
     edd:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     ee4:	e8 fc ff ff ff       	call   ee5 <mm_alloc_pm_flg+0x16>
     ee9:	e8 fc ff ff ff       	call   eea <mm_alloc_pm_flg+0x1b>
     eee:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     ef5:	e8 fc ff ff ff       	call   ef6 <mm_alloc_pm_flg+0x27>
     efa:	fa                   	cli
     efb:	f4                   	hlt
     efc:	eb fd                	jmp    efb <mm_alloc_pm_flg+0x2c>

00000efe <psr.0>:

void pmue_set_range(struct pmue* e, uint16_t start, uint16_t end, int unset, int is_rcp)
{
		/* we also have to consider the values at the fringes,
		 * as start & end don't have to be perfectly aligned. */
		void psr(uint32_t* lv, uint32_t* pr, uint16_t div, uint16_t div2) {
     efe:	55                   	push   ebp
     eff:	89 e5                	mov    ebp,esp
     f01:	56                   	push   esi
     f02:	53                   	push   ebx
     f03:	83 ec 50             	sub    esp,0x50
     f06:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     f09:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f0c:	66 89 55 c4          	mov    WORD PTR [ebp-0x3c],dx
     f10:	66 89 45 c0          	mov    WORD PTR [ebp-0x40],ax
     f14:	89 cb                	mov    ebx,ecx
     f16:	89 4d bc             	mov    DWORD PTR [ebp-0x44],ecx
				uint16_t i, j;
				if (pr) { /* align start & end to boundaries and set fringe values */
     f19:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     f1d:	74 29                	je     f48 <psr.0+0x4a>
						die("fringes!\n"); /* TODO: fix it */
     f1f:	c7 44 24 04 3d 00 00 00 	mov    DWORD PTR [esp+0x4],0x3d
     f27:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     f2e:	e8 fc ff ff ff       	call   f2f <psr.0+0x31>
     f33:	e8 fc ff ff ff       	call   f34 <psr.0+0x36>
     f38:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     f3f:	e8 fc ff ff ff       	call   f40 <psr.0+0x42>
     f44:	fa                   	cli
     f45:	f4                   	hlt
     f46:	eb fd                	jmp    f45 <psr.0+0x47>
				}
				for (i = start / div; i <= end / div; i++) {
     f48:	0f b7 43 06          	movzx  eax,WORD PTR [ebx+0x6]
     f4c:	ba 00 00 00 00       	mov    edx,0x0
     f51:	66 f7 75 c4          	div    WORD PTR [ebp-0x3c]
     f55:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
     f59:	e9 ab 02 00 00       	jmp    1209 <psr.0+0x30b>
						int lwr = (i * div >= start); /* starts at bit0 */
     f5e:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     f62:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
     f66:	0f af d0             	imul   edx,eax
     f69:	0f b7 43 06          	movzx  eax,WORD PTR [ebx+0x6]
     f6d:	0f b7 c0             	movzx  eax,ax
     f70:	39 c2                	cmp    edx,eax
     f72:	0f 9d c0             	setge  al
     f75:	0f b6 c0             	movzx  eax,al
     f78:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						int hgr = (end - i * div >= div); /* goes until bit 31 */
     f7b:	0f b7 43 04          	movzx  eax,WORD PTR [ebx+0x4]
     f7f:	0f b7 c8             	movzx  ecx,ax
     f82:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     f86:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
     f8a:	0f af c2             	imul   eax,edx
     f8d:	29 c1                	sub    ecx,eax
     f8f:	89 ca                	mov    edx,ecx
     f91:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
     f95:	39 c2                	cmp    edx,eax
     f97:	0f 9d c0             	setge  al
     f9a:	0f b6 c0             	movzx  eax,al
     f9d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						if (lwr && hgr) {
     fa0:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     fa4:	74 2f                	je     fd5 <psr.0+0xd7>
     fa6:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     faa:	74 29                	je     fd5 <psr.0+0xd7>
								lv[i] = unset ? 0 : 0xffffffff;
     fac:	8b 03                	mov    eax,DWORD PTR [ebx]
     fae:	85 c0                	test   eax,eax
     fb0:	74 07                	je     fb9 <psr.0+0xbb>
     fb2:	b9 00 00 00 00       	mov    ecx,0x0
     fb7:	eb 05                	jmp    fbe <psr.0+0xc0>
     fb9:	b9 ff ff ff ff       	mov    ecx,0xffffffff
     fbe:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     fc2:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     fc9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     fcc:	01 d0                	add    eax,edx
     fce:	89 08                	mov    DWORD PTR [eax],ecx
								continue;
     fd0:	e9 29 02 00 00       	jmp    11fe <psr.0+0x300>
						} else if (lwr) {
     fd5:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     fd9:	0f 84 a0 00 00 00    	je     107f <psr.0+0x181>
								uint8_t bit = (end - i * div) * 32 / div + 1;
     fdf:	0f b7 43 04          	movzx  eax,WORD PTR [ebx+0x4]
     fe3:	0f b7 c8             	movzx  ecx,ax
     fe6:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
     fea:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
     fee:	0f af c2             	imul   eax,edx
     ff1:	29 c1                	sub    ecx,eax
     ff3:	89 ca                	mov    edx,ecx
     ff5:	89 d0                	mov    eax,edx
     ff7:	c1 e0 05             	shl    eax,0x5
     ffa:	0f b7 75 c4          	movzx  esi,WORD PTR [ebp-0x3c]
     ffe:	99                   	cdq
     fff:	f7 fe                	idiv   esi
    1001:	83 c0 01             	add    eax,0x1
    1004:	88 45 d3             	mov    BYTE PTR [ebp-0x2d],al
								uint32_t mask = (1 << bit) - 1;
    1007:	0f b6 45 d3          	movzx  eax,BYTE PTR [ebp-0x2d]
    100b:	ba 01 00 00 00       	mov    edx,0x1
    1010:	89 c1                	mov    ecx,eax
    1012:	d3 e2                	shl    edx,cl
    1014:	89 d0                	mov    eax,edx
    1016:	83 e8 01             	sub    eax,0x1
    1019:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
								lv[i] &= ~mask;
    101c:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    1020:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    1027:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    102a:	01 d0                	add    eax,edx
    102c:	8b 10                	mov    edx,DWORD PTR [eax]
    102e:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1031:	f7 d0                	not    eax
    1033:	89 c1                	mov    ecx,eax
    1035:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    1039:	8d 34 85 00 00 00 00 	lea    esi,[eax*4+0x0]
    1040:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1043:	01 f0                	add    eax,esi
    1045:	21 ca                	and    edx,ecx
    1047:	89 10                	mov    DWORD PTR [eax],edx
								if (!unset)
    1049:	8b 03                	mov    eax,DWORD PTR [ebx]
    104b:	85 c0                	test   eax,eax
    104d:	0f 85 ab 01 00 00    	jne    11fe <psr.0+0x300>
										lv[i] |= mask;
    1053:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    1057:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    105e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1061:	01 d0                	add    eax,edx
    1063:	8b 00                	mov    eax,DWORD PTR [eax]
    1065:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    1069:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    1070:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1073:	01 ca                	add    edx,ecx
    1075:	0b 45 cc             	or     eax,DWORD PTR [ebp-0x34]
    1078:	89 02                	mov    DWORD PTR [edx],eax
    107a:	e9 7f 01 00 00       	jmp    11fe <psr.0+0x300>
						} else if (hgr) {
    107f:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1083:	0f 84 9c 00 00 00    	je     1125 <psr.0+0x227>
								uint8_t bit = (start - i * div) * 32 / div;
    1089:	0f b7 43 06          	movzx  eax,WORD PTR [ebx+0x6]
    108d:	0f b7 c8             	movzx  ecx,ax
    1090:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    1094:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
    1098:	0f af c2             	imul   eax,edx
    109b:	29 c1                	sub    ecx,eax
    109d:	89 ca                	mov    edx,ecx
    109f:	89 d0                	mov    eax,edx
    10a1:	c1 e0 05             	shl    eax,0x5
    10a4:	0f b7 75 c4          	movzx  esi,WORD PTR [ebp-0x3c]
    10a8:	99                   	cdq
    10a9:	f7 fe                	idiv   esi
    10ab:	88 45 db             	mov    BYTE PTR [ebp-0x25],al
								uint32_t mask = ~((1 << bit) - 1);
    10ae:	0f b6 45 db          	movzx  eax,BYTE PTR [ebp-0x25]
    10b2:	ba 01 00 00 00       	mov    edx,0x1
    10b7:	89 c1                	mov    ecx,eax
    10b9:	d3 e2                	shl    edx,cl
    10bb:	89 d0                	mov    eax,edx
    10bd:	f7 d8                	neg    eax
    10bf:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								lv[i] &= ~mask;
    10c2:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    10c6:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    10cd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10d0:	01 d0                	add    eax,edx
    10d2:	8b 10                	mov    edx,DWORD PTR [eax]
    10d4:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    10d7:	f7 d0                	not    eax
    10d9:	89 c1                	mov    ecx,eax
    10db:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    10df:	8d 34 85 00 00 00 00 	lea    esi,[eax*4+0x0]
    10e6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10e9:	01 f0                	add    eax,esi
    10eb:	21 ca                	and    edx,ecx
    10ed:	89 10                	mov    DWORD PTR [eax],edx
								if (!unset)
    10ef:	8b 03                	mov    eax,DWORD PTR [ebx]
    10f1:	85 c0                	test   eax,eax
    10f3:	0f 85 05 01 00 00    	jne    11fe <psr.0+0x300>
										lv[i] |= mask;
    10f9:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    10fd:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    1104:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1107:	01 d0                	add    eax,edx
    1109:	8b 00                	mov    eax,DWORD PTR [eax]
    110b:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    110f:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    1116:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1119:	01 ca                	add    edx,ecx
    111b:	0b 45 d4             	or     eax,DWORD PTR [ebp-0x2c]
    111e:	89 02                	mov    DWORD PTR [edx],eax
    1120:	e9 d9 00 00 00       	jmp    11fe <psr.0+0x300>
						} else {
								/* in-between */
								uint8_t b1 = (end - i * div) * 32 / div + 1;
    1125:	0f b7 43 04          	movzx  eax,WORD PTR [ebx+0x4]
    1129:	0f b7 c8             	movzx  ecx,ax
    112c:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    1130:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
    1134:	0f af c2             	imul   eax,edx
    1137:	29 c1                	sub    ecx,eax
    1139:	89 ca                	mov    edx,ecx
    113b:	89 d0                	mov    eax,edx
    113d:	c1 e0 05             	shl    eax,0x5
    1140:	0f b7 75 c4          	movzx  esi,WORD PTR [ebp-0x3c]
    1144:	99                   	cdq
    1145:	f7 fe                	idiv   esi
    1147:	83 c0 01             	add    eax,0x1
    114a:	88 45 eb             	mov    BYTE PTR [ebp-0x15],al
								uint8_t b2 = (start - i * div) * 32 / div;
    114d:	0f b7 43 06          	movzx  eax,WORD PTR [ebx+0x6]
    1151:	0f b7 c8             	movzx  ecx,ax
    1154:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    1158:	0f b7 45 c4          	movzx  eax,WORD PTR [ebp-0x3c]
    115c:	0f af c2             	imul   eax,edx
    115f:	29 c1                	sub    ecx,eax
    1161:	89 ca                	mov    edx,ecx
    1163:	89 d0                	mov    eax,edx
    1165:	c1 e0 05             	shl    eax,0x5
    1168:	0f b7 75 c4          	movzx  esi,WORD PTR [ebp-0x3c]
    116c:	99                   	cdq
    116d:	f7 fe                	idiv   esi
    116f:	88 45 ea             	mov    BYTE PTR [ebp-0x16],al
								uint32_t m1 = (1 << b1) - 1;
    1172:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    1176:	ba 01 00 00 00       	mov    edx,0x1
    117b:	89 c1                	mov    ecx,eax
    117d:	d3 e2                	shl    edx,cl
    117f:	89 d0                	mov    eax,edx
    1181:	83 e8 01             	sub    eax,0x1
    1184:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								uint32_t m2 = ~((1 << b2) - 1);
    1187:	0f b6 45 ea          	movzx  eax,BYTE PTR [ebp-0x16]
    118b:	ba 01 00 00 00       	mov    edx,0x1
    1190:	89 c1                	mov    ecx,eax
    1192:	d3 e2                	shl    edx,cl
    1194:	89 d0                	mov    eax,edx
    1196:	f7 d8                	neg    eax
    1198:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								uint32_t mask = m1 & m2;
    119b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    119e:	23 45 e0             	and    eax,DWORD PTR [ebp-0x20]
    11a1:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
								lv[i] &= ~mask;
    11a4:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    11a8:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    11af:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11b2:	01 d0                	add    eax,edx
    11b4:	8b 10                	mov    edx,DWORD PTR [eax]
    11b6:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    11b9:	f7 d0                	not    eax
    11bb:	89 c1                	mov    ecx,eax
    11bd:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    11c1:	8d 34 85 00 00 00 00 	lea    esi,[eax*4+0x0]
    11c8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11cb:	01 f0                	add    eax,esi
    11cd:	21 ca                	and    edx,ecx
    11cf:	89 10                	mov    DWORD PTR [eax],edx
								if (!unset)
    11d1:	8b 03                	mov    eax,DWORD PTR [ebx]
    11d3:	85 c0                	test   eax,eax
    11d5:	75 27                	jne    11fe <psr.0+0x300>
										lv[i] |= mask;
    11d7:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    11db:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    11e2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11e5:	01 d0                	add    eax,edx
    11e7:	8b 00                	mov    eax,DWORD PTR [eax]
    11e9:	0f b7 55 f6          	movzx  edx,WORD PTR [ebp-0xa]
    11ed:	8d 0c 95 00 00 00 00 	lea    ecx,[edx*4+0x0]
    11f4:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    11f7:	01 ca                	add    edx,ecx
    11f9:	0b 45 dc             	or     eax,DWORD PTR [ebp-0x24]
    11fc:	89 02                	mov    DWORD PTR [edx],eax
				for (i = start / div; i <= end / div; i++) {
    11fe:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    1202:	83 c0 01             	add    eax,0x1
    1205:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
    1209:	0f b7 43 04          	movzx  eax,WORD PTR [ebx+0x4]
    120d:	ba 00 00 00 00       	mov    edx,0x0
    1212:	66 f7 75 c4          	div    WORD PTR [ebp-0x3c]
    1216:	66 3b 45 f6          	cmp    ax,WORD PTR [ebp-0xa]
    121a:	0f 83 3e fd ff ff    	jae    f5e <psr.0+0x60>
						}
				}
		}
    1220:	90                   	nop
    1221:	90                   	nop
    1222:	83 c4 50             	add    esp,0x50
    1225:	5b                   	pop    ebx
    1226:	5e                   	pop    esi
    1227:	5d                   	pop    ebp
    1228:	c3                   	ret

00001229 <pmue_set_range>:
{
    1229:	55                   	push   ebp
    122a:	89 e5                	mov    ebp,esp
    122c:	53                   	push   ebx
    122d:	83 ec 34             	sub    esp,0x34
    1230:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1233:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1236:	66 89 55 e4          	mov    WORD PTR [ebp-0x1c],dx
    123a:	66 89 45 e0          	mov    WORD PTR [ebp-0x20],ax
void pmue_set_range(struct pmue* e, uint16_t start, uint16_t end, int unset, int is_rcp)
    123e:	8d 45 08             	lea    eax,[ebp+0x8]
    1241:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1244:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    1248:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
    124c:	0f b7 45 e0          	movzx  eax,WORD PTR [ebp-0x20]
    1250:	66 89 45 f0          	mov    WORD PTR [ebp-0x10],ax
    1254:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1257:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		psr(e->lvl0, NULL, 32, 0);
    125a:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    125d:	8d 45 ec             	lea    eax,[ebp-0x14]
    1260:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    1268:	c7 44 24 08 20 00 00 00 	mov    DWORD PTR [esp+0x8],0x20
    1270:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1278:	89 14 24             	mov    DWORD PTR [esp],edx
    127b:	89 c1                	mov    ecx,eax
    127d:	e8 7c fc ff ff       	call   efe <psr.0>
		if (!is_rcp)
    1282:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    1286:	75 2d                	jne    12b5 <pmue_set_range+0x8c>
				psr(e->lvl1, e->lvl0, 64, 32);
    1288:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    128b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    128e:	8d 88 00 02 00 00    	lea    ecx,[eax+0x200]
    1294:	8d 45 ec             	lea    eax,[ebp-0x14]
    1297:	c7 44 24 0c 20 00 00 00 	mov    DWORD PTR [esp+0xc],0x20
    129f:	c7 44 24 08 40 00 00 00 	mov    DWORD PTR [esp+0x8],0x40
    12a7:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    12ab:	89 0c 24             	mov    DWORD PTR [esp],ecx
    12ae:	89 c1                	mov    ecx,eax
    12b0:	e8 49 fc ff ff       	call   efe <psr.0>
		psr(e->lvl2, is_rcp ? e->lvl0 : e->lvl1, 128, is_rcp ? 32 : 64);
    12b5:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    12b9:	74 07                	je     12c2 <pmue_set_range+0x99>
    12bb:	bb 20 00 00 00       	mov    ebx,0x20
    12c0:	eb 05                	jmp    12c7 <pmue_set_range+0x9e>
    12c2:	bb 40 00 00 00       	mov    ebx,0x40
    12c7:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    12cb:	74 05                	je     12d2 <pmue_set_range+0xa9>
    12cd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12d0:	eb 08                	jmp    12da <pmue_set_range+0xb1>
    12d2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12d5:	05 00 02 00 00       	add    eax,0x200
    12da:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    12dd:	8d 8a 00 03 00 00    	lea    ecx,[edx+0x300]
    12e3:	8d 55 ec             	lea    edx,[ebp-0x14]
    12e6:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    12ea:	c7 44 24 08 80 00 00 00 	mov    DWORD PTR [esp+0x8],0x80
    12f2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    12f6:	89 0c 24             	mov    DWORD PTR [esp],ecx
    12f9:	89 d1                	mov    ecx,edx
    12fb:	e8 fe fb ff ff       	call   efe <psr.0>
		if (!is_rcp) {
    1300:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    1304:	0f 85 cc 00 00 00    	jne    13d6 <pmue_set_range+0x1ad>
				psr(e->lvl3, e->lvl2, 256, 128);
    130a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    130d:	8d 88 00 03 00 00    	lea    ecx,[eax+0x300]
    1313:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1316:	8d 90 80 03 00 00    	lea    edx,[eax+0x380]
    131c:	8d 45 ec             	lea    eax,[ebp-0x14]
    131f:	c7 44 24 0c 80 00 00 00 	mov    DWORD PTR [esp+0xc],0x80
    1327:	c7 44 24 08 00 01 00 00 	mov    DWORD PTR [esp+0x8],0x100
    132f:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    1333:	89 14 24             	mov    DWORD PTR [esp],edx
    1336:	89 c1                	mov    ecx,eax
    1338:	e8 c1 fb ff ff       	call   efe <psr.0>
				psr(e->lvl4, e->lvl3, 512, 256);
    133d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1340:	8d 88 80 03 00 00    	lea    ecx,[eax+0x380]
    1346:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1349:	8d 90 c0 03 00 00    	lea    edx,[eax+0x3c0]
    134f:	8d 45 ec             	lea    eax,[ebp-0x14]
    1352:	c7 44 24 0c 00 01 00 00 	mov    DWORD PTR [esp+0xc],0x100
    135a:	c7 44 24 08 00 02 00 00 	mov    DWORD PTR [esp+0x8],0x200
    1362:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    1366:	89 14 24             	mov    DWORD PTR [esp],edx
    1369:	89 c1                	mov    ecx,eax
    136b:	e8 8e fb ff ff       	call   efe <psr.0>
				psr(e->lvl5, e->lvl4, 1024, 512);
    1370:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1373:	8d 88 c0 03 00 00    	lea    ecx,[eax+0x3c0]
    1379:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    137c:	8d 90 e0 03 00 00    	lea    edx,[eax+0x3e0]
    1382:	8d 45 ec             	lea    eax,[ebp-0x14]
    1385:	c7 44 24 0c 00 02 00 00 	mov    DWORD PTR [esp+0xc],0x200
    138d:	c7 44 24 08 00 04 00 00 	mov    DWORD PTR [esp+0x8],0x400
    1395:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    1399:	89 14 24             	mov    DWORD PTR [esp],edx
    139c:	89 c1                	mov    ecx,eax
    139e:	e8 5b fb ff ff       	call   efe <psr.0>
				psr(e->lvl6, e->lvl5, 2048, 1024);
    13a3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13a6:	8d 88 e0 03 00 00    	lea    ecx,[eax+0x3e0]
    13ac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13af:	8d 90 f0 03 00 00    	lea    edx,[eax+0x3f0]
    13b5:	8d 45 ec             	lea    eax,[ebp-0x14]
    13b8:	c7 44 24 0c 00 04 00 00 	mov    DWORD PTR [esp+0xc],0x400
    13c0:	c7 44 24 08 00 08 00 00 	mov    DWORD PTR [esp+0x8],0x800
    13c8:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    13cc:	89 14 24             	mov    DWORD PTR [esp],edx
    13cf:	89 c1                	mov    ecx,eax
    13d1:	e8 28 fb ff ff       	call   efe <psr.0>
		}
		psr(&e->lvl7, is_rcp ? e->lvl2 : e->lvl6, 4096, is_rcp ? 128 : 2048);
    13d6:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    13da:	74 07                	je     13e3 <pmue_set_range+0x1ba>
    13dc:	bb 80 00 00 00       	mov    ebx,0x80
    13e1:	eb 05                	jmp    13e8 <pmue_set_range+0x1bf>
    13e3:	bb 00 08 00 00       	mov    ebx,0x800
    13e8:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    13ec:	74 0a                	je     13f8 <pmue_set_range+0x1cf>
    13ee:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13f1:	05 00 03 00 00       	add    eax,0x300
    13f6:	eb 08                	jmp    1400 <pmue_set_range+0x1d7>
    13f8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13fb:	05 f0 03 00 00       	add    eax,0x3f0
    1400:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1403:	8d 8a f8 03 00 00    	lea    ecx,[edx+0x3f8]
    1409:	8d 55 ec             	lea    edx,[ebp-0x14]
    140c:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    1410:	c7 44 24 08 00 10 00 00 	mov    DWORD PTR [esp+0x8],0x1000
    1418:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    141c:	89 0c 24             	mov    DWORD PTR [esp],ecx
    141f:	89 d1                	mov    ecx,edx
    1421:	e8 d8 fa ff ff       	call   efe <psr.0>
}
    1426:	90                   	nop
    1427:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    142a:	c9                   	leave
    142b:	c3                   	ret

0000142c <pmu_set_range>:

/* rcp: 7,2,0 set if any below; pmu all, set if all below are used */
void pmu_set_range(struct pmu* pm, uint16_t start, uint16_t end, int unset, int is_rcp)
{
    142c:	55                   	push   ebp
    142d:	89 e5                	mov    ebp,esp
    142f:	53                   	push   ebx
    1430:	83 ec 44             	sub    esp,0x44
    1433:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1436:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1439:	66 89 55 e4          	mov    WORD PTR [ebp-0x1c],dx
    143d:	66 89 45 e0          	mov    WORD PTR [ebp-0x20],ax
		struct pmue* e; uint16_t fc = 0;
    1441:	66 c7 45 f6 00 00    	mov    WORD PTR [ebp-0xa],0x0
		/* we have to lock for keeping higher levels consistent 
		 * else we could do without as we own the ranges exclusively. */

redo:
		/* lock is 64 bit wide 4x16 (2 lvl7 bits per bit) */
		for (uint16_t i = start / 256; i <= end / 256; i++) {
    1447:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    144b:	66 c1 e8 08          	shr    ax,0x8
    144f:	66 89 45 f4          	mov    WORD PTR [ebp-0xc],ax
    1453:	e9 27 01 00 00       	jmp    157f <pmu_set_range+0x153>
				uint16_t o = i * 256, p1, p2;
    1458:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    145c:	c1 e0 08             	shl    eax,0x8
    145f:	66 89 45 f2          	mov    WORD PTR [ebp-0xe],ax
				e = pm->entries + i / 16;
    1463:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1466:	8d 50 10             	lea    edx,[eax+0x10]
    1469:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    146d:	66 c1 e8 04          	shr    ax,0x4
    1471:	0f b7 c0             	movzx  eax,ax
    1474:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
    147a:	01 d0                	add    eax,edx
    147c:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				/* first check if we can skip */
				if (is_rcp) {
    147f:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    1483:	74 2a                	je     14af <pmu_set_range+0x83>
						if (unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
    1485:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    1489:	74 4d                	je     14d8 <pmu_set_range+0xac>
    148b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    148e:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [eax+0x3f8]
    1494:	0f b7 55 f4          	movzx  edx,WORD PTR [ebp-0xc]
    1498:	83 e2 0f             	and    edx,0xf
    149b:	bb 03 00 00 00       	mov    ebx,0x3
    14a0:	89 d1                	mov    ecx,edx
    14a2:	d3 e3                	shl    ebx,cl
    14a4:	89 da                	mov    edx,ebx
    14a6:	39 d0                	cmp    eax,edx
    14a8:	75 2e                	jne    14d8 <pmu_set_range+0xac>
								continue; /* unsafe as lock was not
    14aa:	e9 c5 00 00 00       	jmp    1574 <pmu_set_range+0x148>
						 * checked (could be set concurrently). But 
						 * this is not relevant as it'd be user error. */
				} else {
						if (!unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
    14af:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    14b3:	75 23                	jne    14d8 <pmu_set_range+0xac>
    14b5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    14b8:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [eax+0x3f8]
    14be:	0f b7 55 f4          	movzx  edx,WORD PTR [ebp-0xc]
    14c2:	83 e2 0f             	and    edx,0xf
    14c5:	bb 03 00 00 00       	mov    ebx,0x3
    14ca:	89 d1                	mov    ecx,edx
    14cc:	d3 e3                	shl    ebx,cl
    14ce:	89 da                	mov    edx,ebx
    14d0:	39 d0                	cmp    eax,edx
    14d2:	0f 84 9b 00 00 00    	je     1573 <pmu_set_range+0x147>
								continue; /* already all set */
				}

				/* then try to acquire the lock */
				asm goto("lock bts %0, %1\n"
					"jc %l2\n" : : "r" (2 * i),
    14d8:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    14dc:	8d 14 00             	lea    edx,[eax+eax*1]
				asm goto("lock bts %0, %1\n"
    14df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14e2:	f0 0f ab 10          	lock bts DWORD PTR [eax],edx
    14e6:	72 7e                	jb     1566 <pmu_set_range+0x13a>
					"m" (*pm->locks) : "cc" : carry);
				/* calculate the range */
				p1 = max(o, start);
    14e8:	0f b7 55 e4          	movzx  edx,WORD PTR [ebp-0x1c]
    14ec:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
    14f0:	66 39 c2             	cmp    dx,ax
    14f3:	0f 43 c2             	cmovae eax,edx
    14f6:	66 89 45 ea          	mov    WORD PTR [ebp-0x16],ax
				p2 = min(o + 256, end);
    14fa:	0f b7 55 e0          	movzx  edx,WORD PTR [ebp-0x20]
    14fe:	0f b7 45 f2          	movzx  eax,WORD PTR [ebp-0xe]
    1502:	05 00 01 00 00       	add    eax,0x100
    1507:	39 c2                	cmp    edx,eax
    1509:	0f 4e c2             	cmovle eax,edx
    150c:	66 89 45 e8          	mov    WORD PTR [ebp-0x18],ax
				p1 -= (i / 4) * 4096;
    1510:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    1514:	66 c1 e8 02          	shr    ax,0x2
    1518:	c1 e0 0c             	shl    eax,0xc
    151b:	66 29 45 ea          	sub    WORD PTR [ebp-0x16],ax
				p2 -= (i / 4) * 4096;
    151f:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    1523:	66 c1 e8 02          	shr    ax,0x2
    1527:	c1 e0 0c             	shl    eax,0xc
    152a:	66 29 45 e8          	sub    WORD PTR [ebp-0x18],ax
				/* we now hold the lock so modify the acutal entry */
				pmue_set_range(e, p1, p2, unset, is_rcp);
    152e:	0f b7 55 e8          	movzx  edx,WORD PTR [ebp-0x18]
    1532:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
    1536:	8b 4d 18             	mov    ecx,DWORD PTR [ebp+0x18]
    1539:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    153d:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
    1540:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1544:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1548:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    154c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    154f:	89 04 24             	mov    DWORD PTR [esp],eax
    1552:	e8 fc ff ff ff       	call   1553 <pmu_set_range+0x127>

				/* release it */
				asm("btr %0, %1\n" : : "r" (2 * i),
    1557:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    155b:	8d 14 00             	lea    edx,[eax+eax*1]
    155e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1561:	0f b3 10             	btr    DWORD PTR [eax],edx
					"m" (*pm->locks) : "cc");
				continue;
    1564:	eb 0e                	jmp    1574 <pmu_set_range+0x148>

carry: 			/* lock failed */
				fc++; /* set failure count and continue (retry later) */
    1566:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
    156a:	83 c0 01             	add    eax,0x1
    156d:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
    1571:	eb 01                	jmp    1574 <pmu_set_range+0x148>
								continue; /* already all set */
    1573:	90                   	nop
		for (uint16_t i = start / 256; i <= end / 256; i++) {
    1574:	0f b7 45 f4          	movzx  eax,WORD PTR [ebp-0xc]
    1578:	83 c0 01             	add    eax,0x1
    157b:	66 89 45 f4          	mov    WORD PTR [ebp-0xc],ax
    157f:	0f b7 45 e0          	movzx  eax,WORD PTR [ebp-0x20]
    1583:	66 c1 e8 08          	shr    ax,0x8
    1587:	66 3b 45 f4          	cmp    ax,WORD PTR [ebp-0xc]
    158b:	0f 83 c7 fe ff ff    	jae    1458 <pmu_set_range+0x2c>
		}

		if (fc) { /* busy loop as these locks are held for ns */
    1591:	66 83 7d f6 00       	cmp    WORD PTR [ebp-0xa],0x0
    1596:	74 0b                	je     15a3 <pmu_set_range+0x177>
				fc = 0;
    1598:	66 c7 45 f6 00 00    	mov    WORD PTR [ebp-0xa],0x0
				goto redo;
    159e:	e9 a4 fe ff ff       	jmp    1447 <pmu_set_range+0x1b>
		}
}
    15a3:	90                   	nop
    15a4:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    15a7:	c9                   	leave
    15a8:	c3                   	ret

000015a9 <mm_free_pm>:

void mm_free_pm(struct page_range* pr, uint32_t pr_ct)
{
    15a9:	55                   	push   ebp
    15aa:	89 e5                	mov    ebp,esp
    15ac:	57                   	push   edi
    15ad:	56                   	push   esi
    15ae:	53                   	push   ebx
    15af:	83 ec 7c             	sub    esp,0x7c
		for (uint32_t i = 0; i < pr_ct; i++) {
    15b2:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    15b9:	e9 a6 01 00 00       	jmp    1764 <mm_free_pm+0x1bb>
				struct fme* fm; struct pmu* rc;
				uint64_t ofs, fp, lp;
				for (fm = fmm + fm_begin; fm < fmm + fm_ofs; fm++)
    15be:	ba 00 40 02 00       	mov    edx,0x24000
    15c3:	a1 00 00 00 00       	mov    eax,ds:0x0
    15c8:	6b c0 38             	imul   eax,eax,0x38
    15cb:	01 d0                	add    eax,edx
    15cd:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    15d0:	eb 41                	jmp    1613 <mm_free_pm+0x6a>
						if (pr->base >= fm->base && pr->base < fm->base + fm->size)
    15d2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15d5:	8b 08                	mov    ecx,DWORD PTR [eax]
    15d7:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    15da:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    15dd:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    15e0:	8b 00                	mov    eax,DWORD PTR [eax]
    15e2:	39 c1                	cmp    ecx,eax
    15e4:	89 de                	mov    esi,ebx
    15e6:	19 d6                	sbb    esi,edx
    15e8:	72 25                	jb     160f <mm_free_pm+0x66>
    15ea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15ed:	8b 08                	mov    ecx,DWORD PTR [eax]
    15ef:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    15f2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    15f5:	8b 30                	mov    esi,DWORD PTR [eax]
    15f7:	8b 78 04             	mov    edi,DWORD PTR [eax+0x4]
    15fa:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    15fd:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1600:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1603:	01 f0                	add    eax,esi
    1605:	11 fa                	adc    edx,edi
    1607:	39 c1                	cmp    ecx,eax
    1609:	89 df                	mov    edi,ebx
    160b:	19 d7                	sbb    edi,edx
    160d:	72 1a                	jb     1629 <mm_free_pm+0x80>
				for (fm = fmm + fm_begin; fm < fmm + fm_ofs; fm++)
    160f:	83 45 e0 38          	add    DWORD PTR [ebp-0x20],0x38
    1613:	ba 00 40 02 00       	mov    edx,0x24000
    1618:	a1 00 00 00 00       	mov    eax,ds:0x0
    161d:	6b c0 38             	imul   eax,eax,0x38
    1620:	01 d0                	add    eax,edx
    1622:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    1625:	72 ab                	jb     15d2 <mm_free_pm+0x29>
    1627:	eb 01                	jmp    162a <mm_free_pm+0x81>
								break; /* just assume integrity */
    1629:	90                   	nop
				ofs = pr->base - fm->base;
    162a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    162d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1630:	8b 00                	mov    eax,DWORD PTR [eax]
    1632:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    1635:	8b 59 04             	mov    ebx,DWORD PTR [ecx+0x4]
    1638:	8b 09                	mov    ecx,DWORD PTR [ecx]
    163a:	29 c8                	sub    eax,ecx
    163c:	19 da                	sbb    edx,ebx
    163e:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    1641:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				rc = (struct pmu*)fm->rcp;
    1644:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1647:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    164a:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    164d:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				/* set first and last page */
				fp = ofs / 4096;
    1650:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1653:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1656:	0f ac d0 0c          	shrd   eax,edx,0xc
    165a:	c1 ea 0c             	shr    edx,0xc
    165d:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    1660:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
				lp = fp + pr->count - 1;
    1663:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1666:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1669:	89 c1                	mov    ecx,eax
    166b:	bb 00 00 00 00       	mov    ebx,0x0
    1670:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1673:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1676:	01 c8                	add    eax,ecx
    1678:	11 da                	adc    edx,ebx
    167a:	83 c0 ff             	add    eax,0xffffffff
    167d:	83 d2 ff             	adc    edx,0xffffffff
    1680:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    1683:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx

				for (uint32_t idx = fp / 4096 / 4; idx <= lp / 4096 / 4; idx++) {
    1686:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1689:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    168c:	0f ac d0 0e          	shrd   eax,edx,0xe
    1690:	c1 ea 0e             	shr    edx,0xe
    1693:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1696:	e9 a4 00 00 00       	jmp    173f <mm_free_pm+0x196>
						uint16_t s, e; uint64_t o = idx * 4096 * 4;
    169b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    169e:	c1 e0 0e             	shl    eax,0xe
    16a1:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    16a4:	c7 45 b4 00 00 00 00 	mov    DWORD PTR [ebp-0x4c],0x0
						/* get the limits */
						s = (fp > o ? fp - o : 0);
    16ab:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    16ae:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    16b1:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    16b4:	39 45 b0             	cmp    DWORD PTR [ebp-0x50],eax
    16b7:	19 d1                	sbb    ecx,edx
    16b9:	73 10                	jae    16cb <mm_free_pm+0x122>
    16bb:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    16be:	89 c2                	mov    edx,eax
    16c0:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    16c3:	89 c1                	mov    ecx,eax
    16c5:	89 d0                	mov    eax,edx
    16c7:	29 c8                	sub    eax,ecx
    16c9:	eb 05                	jmp    16d0 <mm_free_pm+0x127>
    16cb:	b8 00 00 00 00       	mov    eax,0x0
    16d0:	66 89 45 ae          	mov    WORD PTR [ebp-0x52],ax
						e = max(lp - o, 4096 * 4 - 1);
    16d4:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    16d7:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    16da:	2b 45 b0             	sub    eax,DWORD PTR [ebp-0x50]
    16dd:	1b 55 b4             	sbb    edx,DWORD PTR [ebp-0x4c]
    16e0:	b9 ff 3f 00 00       	mov    ecx,0x3fff
    16e5:	bb 00 00 00 00       	mov    ebx,0x0
    16ea:	39 c8                	cmp    eax,ecx
    16ec:	89 d6                	mov    esi,edx
    16ee:	19 de                	sbb    esi,ebx
    16f0:	89 cf                	mov    edi,ecx
    16f2:	0f 43 f8             	cmovae edi,eax
    16f5:	89 7d a0             	mov    DWORD PTR [ebp-0x60],edi
    16f8:	0f 43 da             	cmovae ebx,edx
    16fb:	89 5d a4             	mov    DWORD PTR [ebp-0x5c],ebx
    16fe:	0f b7 45 a0          	movzx  eax,WORD PTR [ebp-0x60]
    1702:	66 89 45 ac          	mov    WORD PTR [ebp-0x54],ax
						/* set the rcp */
						pmu_set_range(&rc[idx], s, e, 0, 1);
    1706:	0f b7 55 ac          	movzx  edx,WORD PTR [ebp-0x54]
    170a:	0f b7 45 ae          	movzx  eax,WORD PTR [ebp-0x52]
    170e:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    1711:	89 cb                	mov    ebx,ecx
    1713:	c1 e3 0c             	shl    ebx,0xc
    1716:	8b 4d cc             	mov    ecx,DWORD PTR [ebp-0x34]
    1719:	01 d9                	add    ecx,ebx
    171b:	c7 44 24 10 01 00 00 00 	mov    DWORD PTR [esp+0x10],0x1
    1723:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    172b:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    172f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1733:	89 0c 24             	mov    DWORD PTR [esp],ecx
    1736:	e8 fc ff ff ff       	call   1737 <mm_free_pm+0x18e>
				for (uint32_t idx = fp / 4096 / 4; idx <= lp / 4096 / 4; idx++) {
    173b:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
    173f:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    1742:	bb 00 00 00 00       	mov    ebx,0x0
    1747:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    174a:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    174d:	0f ac d0 0e          	shrd   eax,edx,0xe
    1751:	c1 ea 0e             	shr    edx,0xe
    1754:	39 c8                	cmp    eax,ecx
    1756:	89 d0                	mov    eax,edx
    1758:	19 d8                	sbb    eax,ebx
    175a:	0f 83 3b ff ff ff    	jae    169b <mm_free_pm+0xf2>
		for (uint32_t i = 0; i < pr_ct; i++) {
    1760:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    1764:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1767:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    176a:	0f 82 4e fe ff ff    	jb     15be <mm_free_pm+0x15>
				}
		}
}
    1770:	90                   	nop
    1771:	90                   	nop
    1772:	83 c4 7c             	add    esp,0x7c
    1775:	5b                   	pop    ebx
    1776:	5e                   	pop    esi
    1777:	5f                   	pop    edi
    1778:	5d                   	pop    ebp
    1779:	c3                   	ret

0000177a <mm_create_ctx>:
void *cur_pmu = VM_PMU_BASE, *cur_rcp = VM_RCP_BASE;
void* cur_percpu = VM_MM_PER_CPU_BASE;
struct mm mm_kernel; uint64_t pm_count = 0;

struct mm_cpu_ctx mm_create_ctx()
{
    177a:	55                   	push   ebp
    177b:	89 e5                	mov    ebp,esp
    177d:	83 ec 28             	sub    esp,0x28
		struct mm_cpu_ctx rv = {0};
    1780:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1787:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		rv.cur_mm = &mm_kernel;
    178e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		rv.scrub_page = __sync_fetch_and_add(&cur_percpu, 4096);
    1795:	b8 00 10 00 00       	mov    eax,0x1000
    179a:	f0 0f c1 05 00 00 00 00 	lock xadd DWORD PTR ds:0x0,eax
    17a2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (cur_percpu >= VM_MM_PER_CPU_LIMIT) {
    17a5:	a1 00 00 00 00       	mov    eax,ds:0x0
    17aa:	3d ff ff ff fb       	cmp    eax,0xfbffffff
    17af:	76 29                	jbe    17da <mm_create_ctx+0x60>
				die("Out of MM percpu context slots.\n");
    17b1:	c7 44 24 04 48 00 00 00 	mov    DWORD PTR [esp+0x4],0x48
    17b9:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    17c0:	e8 fc ff ff ff       	call   17c1 <mm_create_ctx+0x47>
    17c5:	e8 fc ff ff ff       	call   17c6 <mm_create_ctx+0x4c>
    17ca:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    17d1:	e8 fc ff ff ff       	call   17d2 <mm_create_ctx+0x58>
    17d6:	fa                   	cli
    17d7:	f4                   	hlt
    17d8:	eb fd                	jmp    17d7 <mm_create_ctx+0x5d>
		}
		return rv;
    17da:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    17dd:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    17e0:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    17e3:	89 01                	mov    DWORD PTR [ecx],eax
    17e5:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
}
    17e8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17eb:	c9                   	leave
    17ec:	c2 04 00             	ret    0x4

000017ef <mm_fm_init>:
/* full mapping & init of high elements */
void mm_fm_init(struct fme* fm)
{
    17ef:	55                   	push   ebp
    17f0:	89 e5                	mov    ebp,esp
    17f2:	57                   	push   edi
    17f3:	56                   	push   esi
    17f4:	53                   	push   ebx
    17f5:	83 ec 7c             	sub    esp,0x7c
		uint64_t b = fm->base - 2 * fm->ec * 4096, b1;
    17f8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17fb:	8b 08                	mov    ecx,DWORD PTR [eax]
    17fd:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1800:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1803:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1806:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1809:	0f a4 c2 0d          	shld   edx,eax,0xd
    180d:	c1 e0 0d             	shl    eax,0xd
    1810:	89 c6                	mov    esi,eax
    1812:	89 d7                	mov    edi,edx
    1814:	89 c8                	mov    eax,ecx
    1816:	89 da                	mov    edx,ebx
    1818:	29 f0                	sub    eax,esi
    181a:	19 fa                	sbb    edx,edi
    181c:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    181f:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		uint64_t ec2 = (uint64_t)fm->ec; b1 = b + fm->ec * 4096;
    1822:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1825:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1828:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    182b:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    182e:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
    1831:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1834:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1837:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    183a:	0f a4 c2 0c          	shld   edx,eax,0xc
    183e:	c1 e0 0c             	shl    eax,0xc
    1841:	89 c1                	mov    ecx,eax
    1843:	89 d3                	mov    ebx,edx
    1845:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1848:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    184b:	01 c8                	add    eax,ecx
    184d:	11 da                	adc    edx,ebx
    184f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1852:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		struct pmu *p, *r; struct page_range pr; uint16_t rec;
		uint32_t lst = 0;
    1855:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0

		/* get the limit */
		rec = (fm->size / 4096) % 16384;
    185c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    185f:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1862:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1865:	0f ac d0 0c          	shrd   eax,edx,0xc
    1869:	c1 ea 0c             	shr    edx,0xc
    186c:	66 25 ff 3f          	and    ax,0x3fff
    1870:	66 89 45 b6          	mov    WORD PTR [ebp-0x4a],ax
		if (rec)
    1874:	66 83 7d b6 00       	cmp    WORD PTR [ebp-0x4a],0x0
    1879:	74 13                	je     188e <mm_fm_init+0x9f>
				lst = (fm->size / 4096) / 16384;
    187b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    187e:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1881:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1884:	0f ac d0 1a          	shrd   eax,edx,0x1a
    1888:	c1 ea 1a             	shr    edx,0x1a
    188b:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax

		/* before preemption -> no sync needed */
		fm->pmu = (uint64_t)cur_pmu;
    188e:	a1 00 00 00 00       	mov    eax,ds:0x0
    1893:	99                   	cdq
    1894:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1897:	89 41 28             	mov    DWORD PTR [ecx+0x28],eax
    189a:	89 51 2c             	mov    DWORD PTR [ecx+0x2c],edx
		fm->rcp = (uint64_t)cur_rcp;
    189d:	a1 00 00 00 00       	mov    eax,ds:0x0
    18a2:	99                   	cdq
    18a3:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    18a6:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
    18a9:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
		p = cur_pmu; r = cur_rcp;
    18ac:	a1 00 00 00 00       	mov    eax,ds:0x0
    18b1:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
    18b4:	a1 00 00 00 00       	mov    eax,ds:0x0
    18b9:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		pm_count += fm->size;
    18bc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18bf:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
    18c2:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    18c5:	a1 00 00 00 00       	mov    eax,ds:0x0
    18ca:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    18d0:	01 c8                	add    eax,ecx
    18d2:	11 da                	adc    edx,ebx
    18d4:	a3 00 00 00 00       	mov    ds:0x0,eax
    18d9:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
	
		/* cap sizes */
		if ((VM_PMU_LIMIT - cur_pmu < ec2 * 4096)
    18df:	a1 00 00 00 00       	mov    eax,ds:0x0
    18e4:	ba 00 00 00 fd       	mov    edx,0xfd000000
    18e9:	29 c2                	sub    edx,eax
    18eb:	89 d1                	mov    ecx,edx
    18ed:	89 d3                	mov    ebx,edx
    18ef:	c1 fb 1f             	sar    ebx,0x1f
    18f2:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    18f5:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    18f8:	0f a4 c2 0c          	shld   edx,eax,0xc
    18fc:	c1 e0 0c             	shl    eax,0xc
    18ff:	39 c1                	cmp    ecx,eax
    1901:	19 d3                	sbb    ebx,edx
    1903:	72 28                	jb     192d <mm_fm_init+0x13e>
			|| (VM_RCP_LIMIT - cur_rcp < ec2 * 4096)) {
    1905:	a1 00 00 00 00       	mov    eax,ds:0x0
    190a:	ba 00 00 00 fe       	mov    edx,0xfe000000
    190f:	29 c2                	sub    edx,eax
    1911:	89 d1                	mov    ecx,edx
    1913:	89 d3                	mov    ebx,edx
    1915:	c1 fb 1f             	sar    ebx,0x1f
    1918:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    191b:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    191e:	0f a4 c2 0c          	shld   edx,eax,0xc
    1922:	c1 e0 0c             	shl    eax,0xc
    1925:	39 c1                	cmp    ecx,eax
    1927:	89 df                	mov    edi,ebx
    1929:	19 d7                	sbb    edi,edx
    192b:	73 7f                	jae    19ac <mm_fm_init+0x1bd>
				/* we should cap and inform the user */
				ec2 = (VM_PMU_LIMIT - cur_pmu) / 4096; /* only on PMUs as LIMITS are identical*/
    192d:	a1 00 00 00 00       	mov    eax,ds:0x0
    1932:	ba 00 00 00 fd       	mov    edx,0xfd000000
    1937:	29 c2                	sub    edx,eax
    1939:	89 d0                	mov    eax,edx
    193b:	8d 90 ff 0f 00 00    	lea    edx,[eax+0xfff]
    1941:	85 c0                	test   eax,eax
    1943:	0f 48 c2             	cmovs  eax,edx
    1946:	c1 f8 0c             	sar    eax,0xc
    1949:	99                   	cdq
    194a:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    194d:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
								fm->ec - ec2, (fm->ec - ec2) * 64);
    1950:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1953:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1956:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1959:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
    195c:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
    195f:	0f a4 c2 06          	shld   edx,eax,0x6
    1963:	c1 e0 06             	shl    eax,0x6
    1966:	89 c1                	mov    ecx,eax
    1968:	89 d3                	mov    ebx,edx
								fm->ec - ec2, (fm->ec - ec2) * 64);
    196a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    196d:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1970:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
    1973:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
    1976:	1b 55 d4             	sbb    edx,DWORD PTR [ebp-0x2c]
    1979:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    197d:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    1981:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1985:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1989:	c7 44 24 04 6c 00 00 00 	mov    DWORD PTR [esp+0x4],0x6c
    1991:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    1998:	e8 fc ff ff ff       	call   1999 <mm_fm_init+0x1aa>
				fm->ec = ec2;
    199d:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    19a0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    19a3:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    19a6:	89 41 20             	mov    DWORD PTR [ecx+0x20],eax
    19a9:	89 51 24             	mov    DWORD PTR [ecx+0x24],edx
		}
		/* and advance */
		cur_pmu += ec2 * 4096;
    19ac:	a1 00 00 00 00       	mov    eax,ds:0x0
    19b1:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    19b4:	c1 e2 0c             	shl    edx,0xc
    19b7:	01 d0                	add    eax,edx
    19b9:	a3 00 00 00 00       	mov    ds:0x0,eax
		cur_rcp += ec2 * 4096;
    19be:	a1 00 00 00 00       	mov    eax,ds:0x0
    19c3:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    19c6:	c1 e2 0c             	shl    edx,0xc
    19c9:	01 d0                	add    eax,edx
    19cb:	a3 00 00 00 00       	mov    ds:0x0,eax

		/* skip completely if neccessary */
		if (!ec2)
    19d0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    19d3:	0b 45 d4             	or     eax,DWORD PTR [ebp-0x2c]
    19d6:	0f 84 94 01 00 00    	je     1b70 <mm_fm_init+0x381>
				return;

		/* map & init the pmus */
		pr.base = b;
    19dc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    19df:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    19e2:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    19e5:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		pr.count = ec2;
    19e8:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    19eb:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
		mm_map(&mm_kernel, p, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
    19ee:	c7 44 24 10 0c 00 00 00 	mov    DWORD PTR [esp+0x10],0xc
    19f6:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    19fe:	8d 45 a0             	lea    eax,[ebp-0x60]
    1a01:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1a05:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    1a08:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a0c:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1a13:	e8 fc ff ff ff       	call   1a14 <mm_fm_init+0x225>
		pr.base = b1;
    1a18:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1a1b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1a1e:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
    1a21:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
		pr.count = ec2;
    1a24:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1a27:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
		mm_map(&mm_kernel, r, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
    1a2a:	c7 44 24 10 0c 00 00 00 	mov    DWORD PTR [esp+0x10],0xc
    1a32:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    1a3a:	8d 45 a0             	lea    eax,[ebp-0x60]
    1a3d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1a41:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    1a44:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a48:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1a4f:	e8 fc ff ff ff       	call   1a50 <mm_fm_init+0x261>

		/* now init the leftovers */
		for (uint64_t i = 0; i < ec2; i++) {
    1a54:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [ebp-0x40],0x0
    1a5b:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x0
    1a62:	e9 f3 00 00 00       	jmp    1b5a <mm_fm_init+0x36b>
				struct pmu* pt = NULL; int rd = 0;
    1a67:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
    1a6e:	c7 45 b8 00 00 00 00 	mov    DWORD PTR [ebp-0x48],0x0
				/* check for exception */
				if (b > 0x100000000 - 4096)
    1a75:	ba 00 f0 ff ff       	mov    edx,0xfffff000
    1a7a:	b8 00 00 00 00       	mov    eax,0x0
    1a7f:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
    1a82:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
    1a85:	73 12                	jae    1a99 <mm_fm_init+0x2aa>
						pt = &p[i];
    1a87:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1a8a:	c1 e0 0c             	shl    eax,0xc
    1a8d:	89 c2                	mov    edx,eax
    1a8f:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    1a92:	01 d0                	add    eax,edx
    1a94:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    1a97:	eb 01                	jmp    1a9a <mm_fm_init+0x2ab>

redo:
    1a99:	90                   	nop
				/* initialize */
				if (pt) {
    1a9a:	83 7d bc 00          	cmp    DWORD PTR [ebp-0x44],0x0
    1a9e:	74 68                	je     1b08 <mm_fm_init+0x319>
						/* clear the locks */
						bzero(pt->locks, sizeof(pt->locks));
    1aa0:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1aa3:	c7 44 24 04 08 00 00 00 	mov    DWORD PTR [esp+0x4],0x8
    1aab:	89 04 24             	mov    DWORD PTR [esp],eax
    1aae:	e8 fc ff ff ff       	call   1aaf <mm_fm_init+0x2c0>
						/* invalidate the counts and put rec in the last one */
						pt->free_ct[0] = 0xffff;
    1ab3:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1ab6:	66 c7 40 08 ff ff    	mov    WORD PTR [eax+0x8],0xffff
						pt->free_ct[1] = 0xffff;
    1abc:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1abf:	66 c7 40 0a ff ff    	mov    WORD PTR [eax+0xa],0xffff
						pt->free_ct[2] = 0xffff;
    1ac5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1ac8:	66 c7 40 0c ff ff    	mov    WORD PTR [eax+0xc],0xffff
						if (rec)
    1ace:	66 83 7d b6 00       	cmp    WORD PTR [ebp-0x4a],0x0
    1ad3:	74 2a                	je     1aff <mm_fm_init+0x310>
								pt->free_ct[3] = (i == lst) ? rec : 0xffff;
    1ad5:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1ad8:	ba 00 00 00 00       	mov    edx,0x0
    1add:	89 c1                	mov    ecx,eax
    1adf:	89 c8                	mov    eax,ecx
    1ae1:	33 45 c0             	xor    eax,DWORD PTR [ebp-0x40]
    1ae4:	33 55 c4             	xor    edx,DWORD PTR [ebp-0x3c]
    1ae7:	09 d0                	or     eax,edx
    1ae9:	75 06                	jne    1af1 <mm_fm_init+0x302>
    1aeb:	0f b7 45 b6          	movzx  eax,WORD PTR [ebp-0x4a]
    1aef:	eb 05                	jmp    1af6 <mm_fm_init+0x307>
    1af1:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1af6:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    1af9:	66 89 42 0e          	mov    WORD PTR [edx+0xe],ax
    1afd:	eb 09                	jmp    1b08 <mm_fm_init+0x319>
						else
								pt->free_ct[3] = 0xffff;
    1aff:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    1b02:	66 c7 40 0e ff ff    	mov    WORD PTR [eax+0xe],0xffff
				}

				/* check for second run */
				if (!rd && (b1 > 0x100000000 - 4096)) {
    1b08:	83 7d b8 00          	cmp    DWORD PTR [ebp-0x48],0x0
    1b0c:	75 2e                	jne    1b3c <mm_fm_init+0x34d>
    1b0e:	ba 00 f0 ff ff       	mov    edx,0xfffff000
    1b13:	b8 00 00 00 00       	mov    eax,0x0
    1b18:	3b 55 d8             	cmp    edx,DWORD PTR [ebp-0x28]
    1b1b:	1b 45 dc             	sbb    eax,DWORD PTR [ebp-0x24]
    1b1e:	73 1c                	jae    1b3c <mm_fm_init+0x34d>
						pt = &r[i];
    1b20:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1b23:	c1 e0 0c             	shl    eax,0xc
    1b26:	89 c2                	mov    edx,eax
    1b28:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    1b2b:	01 d0                	add    eax,edx
    1b2d:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
						rd = 1;
    1b30:	c7 45 b8 01 00 00 00 	mov    DWORD PTR [ebp-0x48],0x1
						goto redo;
    1b37:	e9 5e ff ff ff       	jmp    1a9a <mm_fm_init+0x2ab>
				}

				/* advance */
				b += 4096;
    1b3c:	81 45 e0 00 10 00 00 	add    DWORD PTR [ebp-0x20],0x1000
    1b43:	83 55 e4 00          	adc    DWORD PTR [ebp-0x1c],0x0
				b1 += 4096;
    1b47:	81 45 d8 00 10 00 00 	add    DWORD PTR [ebp-0x28],0x1000
    1b4e:	83 55 dc 00          	adc    DWORD PTR [ebp-0x24],0x0
		for (uint64_t i = 0; i < ec2; i++) {
    1b52:	83 45 c0 01          	add    DWORD PTR [ebp-0x40],0x1
    1b56:	83 55 c4 00          	adc    DWORD PTR [ebp-0x3c],0x0
    1b5a:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1b5d:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1b60:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    1b63:	89 d0                	mov    eax,edx
    1b65:	1b 45 d4             	sbb    eax,DWORD PTR [ebp-0x2c]
    1b68:	0f 82 f9 fe ff ff    	jb     1a67 <mm_fm_init+0x278>
    1b6e:	eb 01                	jmp    1b71 <mm_fm_init+0x382>
				return;
    1b70:	90                   	nop
		}
}
    1b71:	83 c4 7c             	add    esp,0x7c
    1b74:	5b                   	pop    ebx
    1b75:	5e                   	pop    esi
    1b76:	5f                   	pop    edi
    1b77:	5d                   	pop    ebp
    1b78:	c3                   	ret

00001b79 <mmgr_reinit>:

void mmgr_reinit()
{
    1b79:	55                   	push   ebp
    1b7a:	89 e5                	mov    ebp,esp
    1b7c:	83 ec 28             	sub    esp,0x28
		uint32_t* ptr = FM_FREE_MEMORY_MAP;
    1b7f:	c7 45 f0 00 40 02 00 	mov    DWORD PTR [ebp-0x10],0x24000
		fm_ofs = ptr[-1];
    1b86:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b89:	83 e8 04             	sub    eax,0x4
    1b8c:	8b 00                	mov    eax,DWORD PTR [eax]
    1b8e:	a3 00 00 00 00       	mov    ds:0x0,eax
		fm_begin = ptr[-2];
    1b93:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b96:	83 e8 08             	sub    eax,0x8
    1b99:	8b 00                	mov    eax,DWORD PTR [eax]
    1b9b:	a3 00 00 00 00       	mov    ds:0x0,eax
		rm_count = ptr[-3];
    1ba0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ba3:	83 e8 0c             	sub    eax,0xc
    1ba6:	8b 00                	mov    eax,DWORD PTR [eax]
    1ba8:	a3 00 00 00 00       	mov    ds:0x0,eax
		pm_zero = *(uint64_t*)(ptr - 5);
    1bad:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1bb0:	8b 50 f0             	mov    edx,DWORD PTR [eax-0x10]
    1bb3:	8b 40 ec             	mov    eax,DWORD PTR [eax-0x14]
    1bb6:	a3 00 00 00 00       	mov    ds:0x0,eax
    1bbb:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		mm_kernel.cr3 = *(uint64_t*)(ptr - 7);
    1bc1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1bc4:	8b 50 e8             	mov    edx,DWORD PTR [eax-0x18]
    1bc7:	8b 40 e4             	mov    eax,DWORD PTR [eax-0x1c]
    1bca:	a3 00 00 00 00       	mov    ds:0x0,eax
    1bcf:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		mm_kernel.ctx = FM_VIRTUAL_MAPPING;
    1bd5:	c7 05 08 00 00 00 00 80 02 00 	mov    DWORD PTR ds:0x8,0x28000
		mm_kernel.qnd_ptr = VM_QND_BASE;
    1bdf:	c7 05 0c 00 00 00 00 00 00 90 	mov    DWORD PTR ds:0xc,0x90000000
#ifndef __x86_64__ /* PAE? */
		extern void* mf_map;
		extern void* mm_map36;
		extern void* mm_map32;
		if (ptr[-8] == 1) /* PAE */
    1be9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1bec:	83 e8 20             	sub    eax,0x20
    1bef:	8b 00                	mov    eax,DWORD PTR [eax]
    1bf1:	83 f8 01             	cmp    eax,0x1
    1bf4:	75 0c                	jne    1c02 <mmgr_reinit+0x89>
				mf_map = &mm_map36;
    1bf6:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
    1c00:	eb 0a                	jmp    1c0c <mmgr_reinit+0x93>
		else
				mf_map = &mm_map32;
    1c02:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x0,0x0
#endif

		/* map the pmus & initialize high pmus */
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    1c0c:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c11:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1c14:	eb 19                	jmp    1c2f <mmgr_reinit+0xb6>
				mm_fm_init(fmm + i);
    1c16:	ba 00 40 02 00       	mov    edx,0x24000
    1c1b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c1e:	6b c0 38             	imul   eax,eax,0x38
    1c21:	01 d0                	add    eax,edx
    1c23:	89 04 24             	mov    DWORD PTR [esp],eax
    1c26:	e8 fc ff ff ff       	call   1c27 <mmgr_reinit+0xae>
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    1c2b:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1c2f:	a1 00 00 00 00       	mov    eax,ds:0x0
    1c34:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    1c37:	72 dd                	jb     1c16 <mmgr_reinit+0x9d>
		//if (cpu.e_has_nx)
		//		enable_nx();

		/* allocate the heap */
		void init_kernel_heap();
		init_kernel_heap();
    1c39:	e8 fc ff ff ff       	call   1c3a <mmgr_reinit+0xc1>
		void flush_tlb_full();
		flush_tlb_full();
    1c3e:	e8 fc ff ff ff       	call   1c3f <mmgr_reinit+0xc6>
}
    1c43:	90                   	nop
    1c44:	c9                   	leave
    1c45:	c3                   	ret

00001c46 <pmue_dump>:

void pmue_dump(struct pmue* pu, int level)
{
    1c46:	55                   	push   ebp
    1c47:	89 e5                	mov    ebp,esp
    1c49:	57                   	push   edi
    1c4a:	56                   	push   esi
    1c4b:	53                   	push   ebx
    1c4c:	83 ec 3c             	sub    esp,0x3c
		size_t i, ne; uint32_t* lv;
		if (level >= 0 && level <= 7) {
    1c4f:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1c53:	0f 88 b3 01 00 00    	js     1e0c <pmue_dump+0x1c6>
    1c59:	83 7d 0c 07          	cmp    DWORD PTR [ebp+0xc],0x7
    1c5d:	0f 8f a9 01 00 00    	jg     1e0c <pmue_dump+0x1c6>
				if (level == 0)
    1c63:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1c67:	75 12                	jne    1c7b <pmue_dump+0x35>
						(lv = pu->lvl0), ne = 128;
    1c69:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c6c:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1c6f:	c7 45 e0 80 00 00 00 	mov    DWORD PTR [ebp-0x20],0x80
				if (level == 0)
    1c76:	e9 b1 00 00 00       	jmp    1d2c <pmue_dump+0xe6>
				else if (level == 1)
    1c7b:	83 7d 0c 01          	cmp    DWORD PTR [ebp+0xc],0x1
    1c7f:	75 17                	jne    1c98 <pmue_dump+0x52>
						(lv = pu->lvl1), ne = 64;
    1c81:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c84:	05 00 02 00 00       	add    eax,0x200
    1c89:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1c8c:	c7 45 e0 40 00 00 00 	mov    DWORD PTR [ebp-0x20],0x40
				if (level == 0)
    1c93:	e9 94 00 00 00       	jmp    1d2c <pmue_dump+0xe6>
				else if (level == 2)
    1c98:	83 7d 0c 02          	cmp    DWORD PTR [ebp+0xc],0x2
    1c9c:	75 14                	jne    1cb2 <pmue_dump+0x6c>
						(lv = pu->lvl2), ne = 32;
    1c9e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ca1:	05 00 03 00 00       	add    eax,0x300
    1ca6:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1ca9:	c7 45 e0 20 00 00 00 	mov    DWORD PTR [ebp-0x20],0x20
				if (level == 0)
    1cb0:	eb 7a                	jmp    1d2c <pmue_dump+0xe6>
				else if (level == 3)
    1cb2:	83 7d 0c 03          	cmp    DWORD PTR [ebp+0xc],0x3
    1cb6:	75 14                	jne    1ccc <pmue_dump+0x86>
						(lv = pu->lvl3), ne = 16;
    1cb8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cbb:	05 80 03 00 00       	add    eax,0x380
    1cc0:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1cc3:	c7 45 e0 10 00 00 00 	mov    DWORD PTR [ebp-0x20],0x10
				if (level == 0)
    1cca:	eb 60                	jmp    1d2c <pmue_dump+0xe6>
				else if (level == 4)
    1ccc:	83 7d 0c 04          	cmp    DWORD PTR [ebp+0xc],0x4
    1cd0:	75 14                	jne    1ce6 <pmue_dump+0xa0>
						(lv = pu->lvl4), ne = 8;
    1cd2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cd5:	05 c0 03 00 00       	add    eax,0x3c0
    1cda:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1cdd:	c7 45 e0 08 00 00 00 	mov    DWORD PTR [ebp-0x20],0x8
				if (level == 0)
    1ce4:	eb 46                	jmp    1d2c <pmue_dump+0xe6>
				else if (level == 5)
    1ce6:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
    1cea:	75 14                	jne    1d00 <pmue_dump+0xba>
						(lv = pu->lvl5), ne = 4;
    1cec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cef:	05 e0 03 00 00       	add    eax,0x3e0
    1cf4:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1cf7:	c7 45 e0 04 00 00 00 	mov    DWORD PTR [ebp-0x20],0x4
				if (level == 0)
    1cfe:	eb 2c                	jmp    1d2c <pmue_dump+0xe6>
				else if (level == 6)
    1d00:	83 7d 0c 06          	cmp    DWORD PTR [ebp+0xc],0x6
    1d04:	75 14                	jne    1d1a <pmue_dump+0xd4>
						(lv = pu->lvl6), ne = 2;
    1d06:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d09:	05 f0 03 00 00       	add    eax,0x3f0
    1d0e:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1d11:	c7 45 e0 02 00 00 00 	mov    DWORD PTR [ebp-0x20],0x2
				if (level == 0)
    1d18:	eb 12                	jmp    1d2c <pmue_dump+0xe6>
				else
						(lv = &pu->lvl7), ne = 1;
    1d1a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d1d:	05 f8 03 00 00       	add    eax,0x3f8
    1d22:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1d25:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
				if (level == 0)
    1d2c:	90                   	nop
		} else
				return;
		printf("pmue/rcpe (at %p) lvl%d entries:\n", pu, level);
    1d2d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d30:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1d34:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d37:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1d3b:	c7 04 24 9c 00 00 00 	mov    DWORD PTR [esp],0x9c
    1d42:	e8 fc ff ff ff       	call   1d43 <pmue_dump+0xfd>
		for (i = 0; i < ne; i += 6) {
    1d47:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    1d4e:	e9 ab 00 00 00       	jmp    1dfe <pmue_dump+0x1b8>
				if (ne - i >= 6) {
    1d53:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1d56:	2b 45 e4             	sub    eax,DWORD PTR [ebp-0x1c]
    1d59:	83 f8 05             	cmp    eax,0x5
    1d5c:	76 57                	jbe    1db5 <pmue_dump+0x16f>
						printf("%08x %08x %08x %08x %08x %08x\n",
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d5e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d61:	83 c0 14             	add    eax,0x14
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d64:	8b 38                	mov    edi,DWORD PTR [eax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d66:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d69:	83 c0 10             	add    eax,0x10
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d6c:	8b 30                	mov    esi,DWORD PTR [eax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d6e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d71:	83 c0 0c             	add    eax,0xc
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d74:	8b 18                	mov    ebx,DWORD PTR [eax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d76:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d79:	83 c0 08             	add    eax,0x8
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d7c:	8b 08                	mov    ecx,DWORD PTR [eax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d7e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d81:	83 c0 04             	add    eax,0x4
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d84:	8b 10                	mov    edx,DWORD PTR [eax]
    1d86:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d89:	8b 00                	mov    eax,DWORD PTR [eax]
    1d8b:	89 7c 24 18          	mov    DWORD PTR [esp+0x18],edi
    1d8f:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    1d93:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    1d97:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1d9b:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1d9f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1da3:	c7 04 24 c0 00 00 00 	mov    DWORD PTR [esp],0xc0
    1daa:	e8 fc ff ff ff       	call   1dab <pmue_dump+0x165>
						lv += 6;
    1daf:	83 45 dc 18          	add    DWORD PTR [ebp-0x24],0x18
    1db3:	eb 45                	jmp    1dfa <pmue_dump+0x1b4>
				} else {
						size_t j;
						for (j = 0; j < ne - i; j++)
    1db5:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    1dbc:	eb 25                	jmp    1de3 <pmue_dump+0x19d>
								printf("%08x ", lv[j]);
    1dbe:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1dc1:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
    1dc8:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1dcb:	01 d0                	add    eax,edx
    1dcd:	8b 00                	mov    eax,DWORD PTR [eax]
    1dcf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1dd3:	c7 04 24 df 00 00 00 	mov    DWORD PTR [esp],0xdf
    1dda:	e8 fc ff ff ff       	call   1ddb <pmue_dump+0x195>
						for (j = 0; j < ne - i; j++)
    1ddf:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
    1de3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1de6:	2b 45 e4             	sub    eax,DWORD PTR [ebp-0x1c]
    1de9:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
    1dec:	72 d0                	jb     1dbe <pmue_dump+0x178>
						putchar('\n');
    1dee:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    1df5:	e8 fc ff ff ff       	call   1df6 <pmue_dump+0x1b0>
		for (i = 0; i < ne; i += 6) {
    1dfa:	83 45 e4 06          	add    DWORD PTR [ebp-0x1c],0x6
    1dfe:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1e01:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    1e04:	0f 82 49 ff ff ff    	jb     1d53 <pmue_dump+0x10d>
    1e0a:	eb 01                	jmp    1e0d <pmue_dump+0x1c7>
				return;
    1e0c:	90                   	nop
				}
		}
}
    1e0d:	83 c4 3c             	add    esp,0x3c
    1e10:	5b                   	pop    ebx
    1e11:	5e                   	pop    esi
    1e12:	5f                   	pop    edi
    1e13:	5d                   	pop    ebp
    1e14:	c3                   	ret

00001e15 <pmu_dump>:
void pmu_dump(struct pmu* pu, int level)
{
    1e15:	55                   	push   ebp
    1e16:	89 e5                	mov    ebp,esp
    1e18:	83 ec 28             	sub    esp,0x28
		printf("dumping pmu/rcp (at %p)\n", pu);
    1e1b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e1e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e22:	c7 04 24 e5 00 00 00 	mov    DWORD PTR [esp],0xe5
    1e29:	e8 fc ff ff ff       	call   1e2a <pmu_dump+0x15>
		for (int i = 0; i < 4; i++)
    1e2e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1e35:	eb 24                	jmp    1e5b <pmu_dump+0x46>
				pmue_dump(&pu->entries[i], level);
    1e37:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1e3a:	69 c0 fc 03 00 00    	imul   eax,eax,0x3fc
    1e40:	8d 50 10             	lea    edx,[eax+0x10]
    1e43:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e46:	01 c2                	add    edx,eax
    1e48:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e4b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e4f:	89 14 24             	mov    DWORD PTR [esp],edx
    1e52:	e8 fc ff ff ff       	call   1e53 <pmu_dump+0x3e>
		for (int i = 0; i < 4; i++)
    1e57:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1e5b:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    1e5f:	7e d6                	jle    1e37 <pmu_dump+0x22>
}
    1e61:	90                   	nop
    1e62:	90                   	nop
    1e63:	c9                   	leave
    1e64:	c3                   	ret

00001e65 <mm_dump_pmu>:
void mm_dump_pmu(size_t fm, size_t n, int is_rcp)
{
    1e65:	55                   	push   ebp
    1e66:	89 e5                	mov    ebp,esp
    1e68:	53                   	push   ebx
    1e69:	83 ec 34             	sub    esp,0x34
		struct pmu* pu;
		if (is_rcp == 2) {
    1e6c:	83 7d 10 02          	cmp    DWORD PTR [ebp+0x10],0x2
    1e70:	0f 85 ed 00 00 00    	jne    1f63 <mm_dump_pmu+0xfe>
				/* user talk */
				printf("Free mem map contains %lu entries\n", fm_ofs);
    1e76:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e7b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e7f:	c7 04 24 00 01 00 00 	mov    DWORD PTR [esp],0x100
    1e86:	e8 fc ff ff ff       	call   1e87 <mm_dump_pmu+0x22>
				printf("Enumerating maps:\n");
    1e8b:	c7 04 24 23 01 00 00 	mov    DWORD PTR [esp],0x123
    1e92:	e8 fc ff ff ff       	call   1e93 <mm_dump_pmu+0x2e>
				for (n = 0; n < fm_ofs; n++) {
    1e97:	c7 45 0c 00 00 00 00 	mov    DWORD PTR [ebp+0xc],0x0
    1e9e:	e9 ad 00 00 00       	jmp    1f50 <mm_dump_pmu+0xeb>
						size_t cr = 0, cu = 0;
    1ea3:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1eaa:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						struct pmu* pu;
						printf("Map %lu: %016llx-%016llx\n", n,
								fmm[n].base, fmm[n].base + fmm[n].size);
    1eb1:	ba 00 40 02 00       	mov    edx,0x24000
    1eb6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1eb9:	6b c0 38             	imul   eax,eax,0x38
    1ebc:	01 d0                	add    eax,edx
    1ebe:	8b 08                	mov    ecx,DWORD PTR [eax]
    1ec0:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1ec3:	ba 00 40 02 00       	mov    edx,0x24000
    1ec8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ecb:	6b c0 38             	imul   eax,eax,0x38
    1ece:	01 d0                	add    eax,edx
    1ed0:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1ed3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
						printf("Map %lu: %016llx-%016llx\n", n,
    1ed6:	01 c1                	add    ecx,eax
    1ed8:	11 d3                	adc    ebx,edx
								fmm[n].base, fmm[n].base + fmm[n].size);
    1eda:	ba 00 40 02 00       	mov    edx,0x24000
    1edf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ee2:	6b c0 38             	imul   eax,eax,0x38
    1ee5:	01 d0                	add    eax,edx
						printf("Map %lu: %016llx-%016llx\n", n,
    1ee7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1eea:	8b 00                	mov    eax,DWORD PTR [eax]
    1eec:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    1ef0:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    1ef4:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1ef8:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1efc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1eff:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1f03:	c7 04 24 36 01 00 00 	mov    DWORD PTR [esp],0x136
    1f0a:	e8 fc ff ff ff       	call   1f0b <mm_dump_pmu+0xa6>
						pu = (void*)fmm[n].pmu;
    1f0f:	ba 00 40 02 00       	mov    edx,0x24000
    1f14:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f17:	6b c0 38             	imul   eax,eax,0x38
    1f1a:	01 d0                	add    eax,edx
    1f1c:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    1f1f:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    1f22:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						printf("\tEntry count: %llu\n", fmm[n].ec);
    1f25:	ba 00 40 02 00       	mov    edx,0x24000
    1f2a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f2d:	6b c0 38             	imul   eax,eax,0x38
    1f30:	01 d0                	add    eax,edx
    1f32:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    1f35:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1f38:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1f3c:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1f40:	c7 04 24 50 01 00 00 	mov    DWORD PTR [esp],0x150
    1f47:	e8 fc ff ff ff       	call   1f48 <mm_dump_pmu+0xe3>
				for (n = 0; n < fm_ofs; n++) {
    1f4c:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    1f50:	a1 00 00 00 00       	mov    eax,ds:0x0
    1f55:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
    1f58:	0f 82 45 ff ff ff    	jb     1ea3 <mm_dump_pmu+0x3e>
				}
				return;
    1f5e:	e9 f6 00 00 00       	jmp    2059 <mm_dump_pmu+0x1f4>
		}
		if (fm > fm_ofs) {
    1f63:	a1 00 00 00 00       	mov    eax,ds:0x0
    1f68:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    1f6b:	73 11                	jae    1f7e <mm_dump_pmu+0x119>
				printf("FM out of range\n");
    1f6d:	c7 04 24 64 01 00 00 	mov    DWORD PTR [esp],0x164
    1f74:	e8 fc ff ff ff       	call   1f75 <mm_dump_pmu+0x110>
				return;
    1f79:	e9 db 00 00 00       	jmp    2059 <mm_dump_pmu+0x1f4>
		}
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
						(uint32_t)fmm[fm].free_pages,
						(uint32_t)fmm[fm].reclaimable_pages);
    1f7e:	ba 00 40 02 00       	mov    edx,0x24000
    1f83:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f86:	6b c0 38             	imul   eax,eax,0x38
    1f89:	01 d0                	add    eax,edx
    1f8b:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    1f8e:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
    1f91:	89 c1                	mov    ecx,eax
						(uint32_t)fmm[fm].free_pages,
    1f93:	ba 00 40 02 00       	mov    edx,0x24000
    1f98:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f9b:	6b c0 38             	imul   eax,eax,0x38
    1f9e:	01 d0                	add    eax,edx
    1fa0:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    1fa3:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
    1fa6:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1faa:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1fae:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1fb1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1fb5:	c7 04 24 78 01 00 00 	mov    DWORD PTR [esp],0x178
    1fbc:	e8 fc ff ff ff       	call   1fbd <mm_dump_pmu+0x158>
		if (is_rcp)
    1fc1:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1fc5:	74 18                	je     1fdf <mm_dump_pmu+0x17a>
				pu = (void*)fmm[fm].rcp;
    1fc7:	ba 00 40 02 00       	mov    edx,0x24000
    1fcc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1fcf:	6b c0 38             	imul   eax,eax,0x38
    1fd2:	01 d0                	add    eax,edx
    1fd4:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    1fd7:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1fda:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1fdd:	eb 16                	jmp    1ff5 <mm_dump_pmu+0x190>
		else
				pu = (void*)fmm[fm].pmu;
    1fdf:	ba 00 40 02 00       	mov    edx,0x24000
    1fe4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1fe7:	6b c0 38             	imul   eax,eax,0x38
    1fea:	01 d0                	add    eax,edx
    1fec:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    1fef:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    1ff2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (n > fmm[fm].ec)
    1ff5:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    1ff8:	bb 00 00 00 00       	mov    ebx,0x0
    1ffd:	ba 00 40 02 00       	mov    edx,0x24000
    2002:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2005:	6b c0 38             	imul   eax,eax,0x38
    2008:	01 d0                	add    eax,edx
    200a:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    200d:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2010:	39 c8                	cmp    eax,ecx
    2012:	89 d0                	mov    eax,edx
    2014:	19 d8                	sbb    eax,ebx
    2016:	73 0c                	jae    2024 <mm_dump_pmu+0x1bf>
				printf("PMU index out of range\n");
    2018:	c7 04 24 99 01 00 00 	mov    DWORD PTR [esp],0x199
    201f:	e8 fc ff ff ff       	call   2020 <mm_dump_pmu+0x1bb>
		pu += n;
    2024:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2027:	c1 e0 0c             	shl    eax,0xc
    202a:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		pmu_dump(pu, 0);
    202d:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2035:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2038:	89 04 24             	mov    DWORD PTR [esp],eax
    203b:	e8 fc ff ff ff       	call   203c <mm_dump_pmu+0x1d7>
		if (is_rcp)
    2040:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    2044:	74 13                	je     2059 <mm_dump_pmu+0x1f4>
				pmu_dump(pu, 2);
    2046:	c7 44 24 04 02 00 00 00 	mov    DWORD PTR [esp+0x4],0x2
    204e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2051:	89 04 24             	mov    DWORD PTR [esp],eax
    2054:	e8 fc ff ff ff       	call   2055 <mm_dump_pmu+0x1f0>
}
    2059:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    205c:	c9                   	leave
    205d:	c3                   	ret
