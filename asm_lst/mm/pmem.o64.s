
mm/pmem.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <mm_init_pmu>:
uint64_t pm_zero = 0;

/*************   PHYSICAL MEMORY ALLOCATION   *********************************/
/* returns nonzero if locked */
int mm_init_pmu(struct pmu* p)
{
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 10          	sub    rsp,0x10
       8:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
       c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      10:	48 8d 50 0a          	lea    rdx,[rax+0xa]
      14:	b8 ff ff ff ff       	mov    eax,0xffffffff
      19:	b9 fe ff ff ff       	mov    ecx,0xfffffffe
      1e:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [rdx],cx
      23:	0f 94 c0             	sete   al
      26:	83 f0 01             	xor    eax,0x1
      29:	84 c0                	test   al,al
      2b:	74 0a                	je     37 <mm_init_pmu+0x37>
				return -1;
      2d:	b8 ff ff ff ff       	mov    eax,0xffffffff
      32:	e9 82 00 00 00       	jmp    b9 <mm_init_pmu+0xb9>

		/* we're free to initialize (all full) */
		__builtin_memset(p->entries, 0xff, sizeof(p->entries));
      37:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      3b:	48 83 c0 10          	add    rax,0x10
      3f:	b9 f0 0f 00 00       	mov    ecx,0xff0
      44:	48 c7 c6 ff ff ff ff 	mov    rsi,0xffffffffffffffff
      4b:	48 89 30             	mov    QWORD PTR [rax],rsi
      4e:	89 ca                	mov    edx,ecx
      50:	48 01 c2             	add    rdx,rax
      53:	48 83 c2 08          	add    rdx,0x8
      57:	48 89 72 f0          	mov    QWORD PTR [rdx-0x10],rsi
      5b:	48 8d 50 08          	lea    rdx,[rax+0x8]
      5f:	48 83 e2 f8          	and    rdx,0xfffffffffffffff8
      63:	48 29 d0             	sub    rax,rdx
      66:	01 c1                	add    ecx,eax
      68:	83 e1 f8             	and    ecx,0xfffffff8
      6b:	89 c8                	mov    eax,ecx
      6d:	c1 e8 03             	shr    eax,0x3
      70:	89 c1                	mov    ecx,eax
      72:	48 89 d7             	mov    rdi,rdx
      75:	48 89 f0             	mov    rax,rsi
      78:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax

		/* now release */
		bzero(p->locks, sizeof(p->locks));
      7b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      7f:	be 08 00 00 00       	mov    esi,0x8
      84:	48 89 c7             	mov    rdi,rax
      87:	e8 00 00 00 00       	call   8c <mm_init_pmu+0x8c>
		p->free_ct[3] = 0;
      8c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      90:	66 c7 40 0e 00 00    	mov    WORD PTR [rax+0xe],0x0
		p->free_ct[2] = 0;
      96:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      9a:	66 c7 40 0c 00 00    	mov    WORD PTR [rax+0xc],0x0
		p->free_ct[1] = 0;
      a0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      a4:	66 c7 40 0a 00 00    	mov    WORD PTR [rax+0xa],0x0
		p->free_ct[0] = 0;
      aa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      ae:	66 c7 40 08 00 00    	mov    WORD PTR [rax+0x8],0x0
		return 0;
      b4:	b8 00 00 00 00       	mov    eax,0x0
}
      b9:	c9                   	leave
      ba:	c3                   	ret

00000000000000bb <mm_init_rcp>:

/* returns nonzero if locked */
int mm_init_rcp(struct pmu* p)
{
      bb:	55                   	push   rbp
      bc:	48 89 e5             	mov    rbp,rsp
      bf:	48 83 ec 40          	sub    rsp,0x40
      c3:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
		uint16_t rem, fc[4] = { 4096, 4096, 4096, 4096 };
      c7:	66 c7 45 d8 00 10    	mov    WORD PTR [rbp-0x28],0x1000
      cd:	66 c7 45 da 00 10    	mov    WORD PTR [rbp-0x26],0x1000
      d3:	66 c7 45 dc 00 10    	mov    WORD PTR [rbp-0x24],0x1000
      d9:	66 c7 45 de 00 10    	mov    WORD PTR [rbp-0x22],0x1000

		/* check for parallel init */
		if (!__sync_bool_compare_and_swap(&p->free_ct[1], 0xffff, 0xfffe))
      df:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
      e3:	48 8d 50 0a          	lea    rdx,[rax+0xa]
      e7:	b8 ff ff ff ff       	mov    eax,0xffffffff
      ec:	b9 fe ff ff ff       	mov    ecx,0xfffffffe
      f1:	66 f0 0f b1 0a       	lock cmpxchg WORD PTR [rdx],cx
      f6:	0f 94 c0             	sete   al
      f9:	83 f0 01             	xor    eax,0x1
      fc:	84 c0                	test   al,al
      fe:	74 0a                	je     10a <mm_init_rcp+0x4f>
				return -1;
     100:	b8 ff ff ff ff       	mov    eax,0xffffffff
     105:	e9 db 02 00 00       	jmp    3e5 <mm_init_rcp+0x32a>

		/* check if last */
		rem = p->free_ct[3];
     10a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     10e:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     112:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax

		if (rem != 0xffff) {
     116:	66 83 7d fe ff       	cmp    WORD PTR [rbp-0x2],0xffff
     11b:	0f 84 3a 02 00 00    	je     35b <mm_init_rcp+0x2a0>
				for (size_t i = 0; i < 4; i++) {
     121:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     129:	e9 20 02 00 00       	jmp    34e <mm_init_rcp+0x293>
						if (rem >= 4096) { /* still easy */
     12e:	66 81 7d fe ff 0f    	cmp    WORD PTR [rbp-0x2],0xfff
     134:	76 64                	jbe    19a <mm_init_rcp+0xdf>
								/* set everything reclaimable */
								__builtin_memset(&p->entries[i], 0xff,
     136:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     13a:	48 89 d0             	mov    rax,rdx
     13d:	48 c1 e0 08          	shl    rax,0x8
     141:	48 29 d0             	sub    rax,rdx
     144:	48 c1 e0 02          	shl    rax,0x2
     148:	48 8d 50 10          	lea    rdx,[rax+0x10]
     14c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     150:	48 01 d0             	add    rax,rdx
     153:	b9 fc 03 00 00       	mov    ecx,0x3fc
     158:	48 c7 c6 ff ff ff ff 	mov    rsi,0xffffffffffffffff
     15f:	48 89 30             	mov    QWORD PTR [rax],rsi
     162:	89 ca                	mov    edx,ecx
     164:	48 01 c2             	add    rdx,rax
     167:	48 83 c2 08          	add    rdx,0x8
     16b:	48 89 72 f0          	mov    QWORD PTR [rdx-0x10],rsi
     16f:	48 8d 50 08          	lea    rdx,[rax+0x8]
     173:	48 83 e2 f8          	and    rdx,0xfffffffffffffff8
     177:	48 29 d0             	sub    rax,rdx
     17a:	01 c1                	add    ecx,eax
     17c:	83 e1 f8             	and    ecx,0xfffffff8
     17f:	89 c8                	mov    eax,ecx
     181:	c1 e8 03             	shr    eax,0x3
     184:	89 c1                	mov    ecx,eax
     186:	48 89 d7             	mov    rdi,rdx
     189:	48 89 f0             	mov    rax,rsi
     18c:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
												sizeof(p->entries[i]));
								/* advance */
								rem -= 4096;
     18f:	66 81 6d fe 00 10    	sub    WORD PTR [rbp-0x2],0x1000
     195:	e9 af 01 00 00       	jmp    349 <mm_init_rcp+0x28e>
						} else {
								/* fill partially (0, 2, 7) */
								for (uint16_t j = 0, of = 0; j < 128; of += 32, j++) {
     19a:	66 c7 45 ee 00 00    	mov    WORD PTR [rbp-0x12],0x0
     1a0:	66 c7 45 ec 00 00    	mov    WORD PTR [rbp-0x14],0x0
     1a6:	eb 78                	jmp    220 <mm_init_rcp+0x165>
										uint32_t val = 0;
     1a8:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
										if (rem > of) {
     1af:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     1b3:	66 39 45 ec          	cmp    WORD PTR [rbp-0x14],ax
     1b7:	73 31                	jae    1ea <mm_init_rcp+0x12f>
												if (rem - of >= 32) /* set full */
     1b9:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
     1bd:	0f b7 45 ec          	movzx  eax,WORD PTR [rbp-0x14]
     1c1:	29 c2                	sub    edx,eax
     1c3:	83 fa 1f             	cmp    edx,0x1f
     1c6:	7e 09                	jle    1d1 <mm_init_rcp+0x116>
														val = 0xffffffff;
     1c8:	c7 45 e8 ff ff ff ff 	mov    DWORD PTR [rbp-0x18],0xffffffff
     1cf:	eb 19                	jmp    1ea <mm_init_rcp+0x12f>
												else /* set partial */
														val = (1 << (rem - of)) - 1;
     1d1:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
     1d5:	0f b7 45 ec          	movzx  eax,WORD PTR [rbp-0x14]
     1d9:	29 c2                	sub    edx,eax
     1db:	b8 01 00 00 00       	mov    eax,0x1
     1e0:	89 d1                	mov    ecx,edx
     1e2:	d3 e0                	shl    eax,cl
     1e4:	83 e8 01             	sub    eax,0x1
     1e7:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
										}
										p->entries[i].lvl0[j] = val;
     1ea:	0f b7 45 ee          	movzx  eax,WORD PTR [rbp-0x12]
     1ee:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
     1f2:	48 63 f0             	movsxd rsi,eax
     1f5:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     1f9:	48 89 d0             	mov    rax,rdx
     1fc:	48 c1 e0 08          	shl    rax,0x8
     200:	48 29 d0             	sub    rax,rdx
     203:	48 01 f0             	add    rax,rsi
     206:	48 8d 50 04          	lea    rdx,[rax+0x4]
     20a:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     20d:	89 04 91             	mov    DWORD PTR [rcx+rdx*4],eax
								for (uint16_t j = 0, of = 0; j < 128; of += 32, j++) {
     210:	66 83 45 ec 20       	add    WORD PTR [rbp-0x14],0x20
     215:	0f b7 45 ee          	movzx  eax,WORD PTR [rbp-0x12]
     219:	83 c0 01             	add    eax,0x1
     21c:	66 89 45 ee          	mov    WORD PTR [rbp-0x12],ax
     220:	66 83 7d ee 7f       	cmp    WORD PTR [rbp-0x12],0x7f
     225:	76 81                	jbe    1a8 <mm_init_rcp+0xed>
								}
								for (uint16_t j = 0, of = 0; j < 32; of += 128, j++) {
     227:	66 c7 45 e6 00 00    	mov    WORD PTR [rbp-0x1a],0x0
     22d:	66 c7 45 e4 00 00    	mov    WORD PTR [rbp-0x1c],0x0
     233:	e9 a5 00 00 00       	jmp    2dd <mm_init_rcp+0x222>
										uint32_t val = 0;
     238:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [rbp-0x20],0x0
										if (rem > of) {
     23f:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     243:	66 39 45 e4          	cmp    WORD PTR [rbp-0x1c],ax
     247:	73 5b                	jae    2a4 <mm_init_rcp+0x1e9>
												if (rem - of >= 128)
     249:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
     24d:	0f b7 45 e4          	movzx  eax,WORD PTR [rbp-0x1c]
     251:	29 c2                	sub    edx,eax
     253:	83 fa 7f             	cmp    edx,0x7f
     256:	7e 09                	jle    261 <mm_init_rcp+0x1a6>
														val = 0xffffffff;
     258:	c7 45 e0 ff ff ff ff 	mov    DWORD PTR [rbp-0x20],0xffffffff
     25f:	eb 43                	jmp    2a4 <mm_init_rcp+0x1e9>
												else /* set partial */
														val = (1 << rdiv(rem - of, 4)) - 1;
     261:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
     265:	0f b7 45 e4          	movzx  eax,WORD PTR [rbp-0x1c]
     269:	29 c2                	sub    edx,eax
     26b:	89 d0                	mov    eax,edx
     26d:	8d 50 03             	lea    edx,[rax+0x3]
     270:	85 c0                	test   eax,eax
     272:	0f 48 c2             	cmovs  eax,edx
     275:	c1 f8 02             	sar    eax,0x2
     278:	89 c1                	mov    ecx,eax
     27a:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
     27e:	0f b7 45 e4          	movzx  eax,WORD PTR [rbp-0x1c]
     282:	29 c2                	sub    edx,eax
     284:	89 d0                	mov    eax,edx
     286:	83 e0 03             	and    eax,0x3
     289:	85 c0                	test   eax,eax
     28b:	0f 95 c0             	setne  al
     28e:	0f b6 c0             	movzx  eax,al
     291:	01 c8                	add    eax,ecx
     293:	ba 01 00 00 00       	mov    edx,0x1
     298:	89 c1                	mov    ecx,eax
     29a:	d3 e2                	shl    edx,cl
     29c:	89 d0                	mov    eax,edx
     29e:	83 e8 01             	sub    eax,0x1
     2a1:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
										}
										p->entries[i].lvl2[j] = val;
     2a4:	0f b7 45 e6          	movzx  eax,WORD PTR [rbp-0x1a]
     2a8:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
     2ac:	48 63 f0             	movsxd rsi,eax
     2af:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     2b3:	48 89 d0             	mov    rax,rdx
     2b6:	48 c1 e0 08          	shl    rax,0x8
     2ba:	48 29 d0             	sub    rax,rdx
     2bd:	48 01 f0             	add    rax,rsi
     2c0:	48 8d 90 c4 00 00 00 	lea    rdx,[rax+0xc4]
     2c7:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
     2ca:	89 04 91             	mov    DWORD PTR [rcx+rdx*4],eax
								for (uint16_t j = 0, of = 0; j < 32; of += 128, j++) {
     2cd:	66 83 6d e4 80       	sub    WORD PTR [rbp-0x1c],0xff80
     2d2:	0f b7 45 e6          	movzx  eax,WORD PTR [rbp-0x1a]
     2d6:	83 c0 01             	add    eax,0x1
     2d9:	66 89 45 e6          	mov    WORD PTR [rbp-0x1a],ax
     2dd:	66 83 7d e6 1f       	cmp    WORD PTR [rbp-0x1a],0x1f
     2e2:	0f 86 50 ff ff ff    	jbe    238 <mm_init_rcp+0x17d>
								}
								p->entries[i].lvl7 = (1 << rdiv(rem, 32)) - 1;
     2e8:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     2ec:	66 c1 e8 05          	shr    ax,0x5
     2f0:	0f b7 d0             	movzx  edx,ax
     2f3:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     2f7:	83 e0 1f             	and    eax,0x1f
     2fa:	66 85 c0             	test   ax,ax
     2fd:	0f 95 c0             	setne  al
     300:	0f b6 c0             	movzx  eax,al
     303:	01 d0                	add    eax,edx
     305:	ba 01 00 00 00       	mov    edx,0x1
     30a:	89 c1                	mov    ecx,eax
     30c:	d3 e2                	shl    edx,cl
     30e:	89 d0                	mov    eax,edx
     310:	83 e8 01             	sub    eax,0x1
     313:	89 c6                	mov    esi,eax
     315:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
     319:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     31d:	48 89 d0             	mov    rax,rdx
     320:	48 c1 e0 08          	shl    rax,0x8
     324:	48 29 d0             	sub    rax,rdx
     327:	48 c1 e0 02          	shl    rax,0x2
     32b:	48 01 c8             	add    rax,rcx
     32e:	48 05 08 04 00 00    	add    rax,0x408
     334:	89 30                	mov    DWORD PTR [rax],esi

								/* advance */
								fc[i] = rem;
     336:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     33a:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
     33e:	66 89 54 45 d8       	mov    WORD PTR [rbp+rax*2-0x28],dx
								rem = 0;
     343:	66 c7 45 fe 00 00    	mov    WORD PTR [rbp-0x2],0x0
				for (size_t i = 0; i < 4; i++) {
     349:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
     34e:	48 83 7d f0 03       	cmp    QWORD PTR [rbp-0x10],0x3
     353:	0f 86 d5 fd ff ff    	jbe    12e <mm_init_rcp+0x73>
     359:	eb 44                	jmp    39f <mm_init_rcp+0x2e4>
						}
				}
		} else /* very easy: everything is reclaimable */
				__builtin_memset(p->entries, 0xff, sizeof(p->entries));
     35b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     35f:	48 83 c0 10          	add    rax,0x10
     363:	b9 f0 0f 00 00       	mov    ecx,0xff0
     368:	48 c7 c6 ff ff ff ff 	mov    rsi,0xffffffffffffffff
     36f:	48 89 30             	mov    QWORD PTR [rax],rsi
     372:	89 ca                	mov    edx,ecx
     374:	48 01 c2             	add    rdx,rax
     377:	48 83 c2 08          	add    rdx,0x8
     37b:	48 89 72 f0          	mov    QWORD PTR [rdx-0x10],rsi
     37f:	48 8d 50 08          	lea    rdx,[rax+0x8]
     383:	48 83 e2 f8          	and    rdx,0xfffffffffffffff8
     387:	48 29 d0             	sub    rax,rdx
     38a:	01 c1                	add    ecx,eax
     38c:	83 e1 f8             	and    ecx,0xfffffff8
     38f:	89 c8                	mov    eax,ecx
     391:	c1 e8 03             	shr    eax,0x3
     394:	89 c1                	mov    ecx,eax
     396:	48 89 d7             	mov    rdi,rdx
     399:	48 89 f0             	mov    rax,rsi
     39c:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax

		/* now release */
		bzero(p->locks, sizeof(p->locks));
     39f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     3a3:	be 08 00 00 00       	mov    esi,0x8
     3a8:	48 89 c7             	mov    rdi,rax
     3ab:	e8 00 00 00 00       	call   3b0 <mm_init_rcp+0x2f5>
		p->free_ct[3] = fc[3];
     3b0:	0f b7 55 de          	movzx  edx,WORD PTR [rbp-0x22]
     3b4:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     3b8:	66 89 50 0e          	mov    WORD PTR [rax+0xe],dx
		p->free_ct[2] = fc[2];
     3bc:	0f b7 55 dc          	movzx  edx,WORD PTR [rbp-0x24]
     3c0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     3c4:	66 89 50 0c          	mov    WORD PTR [rax+0xc],dx
		p->free_ct[1] = fc[1];
     3c8:	0f b7 55 da          	movzx  edx,WORD PTR [rbp-0x26]
     3cc:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     3d0:	66 89 50 0a          	mov    WORD PTR [rax+0xa],dx
		p->free_ct[0] = fc[0];
     3d4:	0f b7 55 d8          	movzx  edx,WORD PTR [rbp-0x28]
     3d8:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     3dc:	66 89 50 08          	mov    WORD PTR [rax+0x8],dx
		return 0;
     3e0:	b8 00 00 00 00       	mov    eax,0x0
}
     3e5:	c9                   	leave
     3e6:	c3                   	ret

00000000000003e7 <mm_pmue_get_range>:
/* assume caller know about locking and has made the right reservations
 * for us to operate freely on the range given by the limits. */
uint32_t mm_pmue_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bsir, uint64_t base)
{
     3e7:	55                   	push   rbp
     3e8:	48 89 e5             	mov    rbp,rsp
     3eb:	48 83 ec 50          	sub    rsp,0x50
     3ef:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     3f3:	89 75 c4             	mov    DWORD PTR [rbp-0x3c],esi
     3f6:	89 55 c0             	mov    DWORD PTR [rbp-0x40],edx
     3f9:	89 4d bc             	mov    DWORD PTR [rbp-0x44],ecx
     3fc:	44 89 45 b8          	mov    DWORD PTR [rbp-0x48],r8d
     400:	4c 89 4d b0          	mov    QWORD PTR [rbp-0x50],r9
		uint32_t* bitfield, rv = 0;
     404:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0

		/* set the reference */
		switch (lvl) {
     40b:	83 7d bc 07          	cmp    DWORD PTR [rbp-0x44],0x7
     40f:	0f 87 87 00 00 00    	ja     49c <mm_pmue_get_range+0xb5>
     415:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
     418:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     420:	ff e0                	jmp    rax
				case 7:
						bitfield = &p->lvl7;
     422:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     426:	48 05 f8 03 00 00    	add    rax,0x3f8
     42c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     430:	eb 6c                	jmp    49e <mm_pmue_get_range+0xb7>
				case 6:
						bitfield = p->lvl6;
     432:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     436:	48 05 f0 03 00 00    	add    rax,0x3f0
     43c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     440:	eb 5c                	jmp    49e <mm_pmue_get_range+0xb7>
				case 5:
						bitfield = p->lvl5;
     442:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     446:	48 05 e0 03 00 00    	add    rax,0x3e0
     44c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     450:	eb 4c                	jmp    49e <mm_pmue_get_range+0xb7>
				case 4:
						bitfield = p->lvl4;
     452:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     456:	48 05 c0 03 00 00    	add    rax,0x3c0
     45c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     460:	eb 3c                	jmp    49e <mm_pmue_get_range+0xb7>
				case 3:
						bitfield = p->lvl3;
     462:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     466:	48 05 80 03 00 00    	add    rax,0x380
     46c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     470:	eb 2c                	jmp    49e <mm_pmue_get_range+0xb7>
				case 2:
						bitfield = p->lvl2;
     472:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     476:	48 05 00 03 00 00    	add    rax,0x300
     47c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     480:	eb 1c                	jmp    49e <mm_pmue_get_range+0xb7>
				case 1:
						bitfield = p->lvl1;
     482:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     486:	48 05 00 02 00 00    	add    rax,0x200
     48c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     490:	eb 0c                	jmp    49e <mm_pmue_get_range+0xb7>
				case 0:
						bitfield = p->lvl0;
     492:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     496:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     49a:	eb 02                	jmp    49e <mm_pmue_get_range+0xb7>
				default:
						while (1);
     49c:	eb fe                	jmp    49c <mm_pmue_get_range+0xb5>
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
     49e:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     4a1:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
     4a4:	e9 ba 01 00 00       	jmp    663 <mm_pmue_get_range+0x27c>
				/* test each bit */
				asm goto("bt %0, %1\n"
     4a9:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     4ac:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     4b0:	0f a3 02             	bt     DWORD PTR [rdx],eax
     4b3:	0f 82 94 01 00 00    	jb     64d <mm_pmue_get_range+0x266>
						 "jc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : carry);

				/* we've got a free entry at i */
				if (lvl > 0) {
     4b9:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     4bd:	0f 84 b9 00 00 00    	je     57c <mm_pmue_get_range+0x195>
						uint32_t rv2, prr = *n_pr, bs = 0;
     4c3:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     4c7:	8b 00                	mov    eax,DWORD PTR [rax]
     4c9:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
     4cc:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [rbp-0x2c],0x0
						/* go deeper */
						rv2 = mm_pmue_get_range(p, i * 2, i * 2 + 1,
     4d3:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
     4d6:	8d 48 ff             	lea    ecx,[rax-0x1]
     4d9:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     4dc:	01 c0                	add    eax,eax
     4de:	8d 50 01             	lea    edx,[rax+0x1]
     4e1:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     4e4:	8d 34 00             	lea    esi,[rax+rax*1]
     4e7:	4c 8b 4d b0          	mov    r9,QWORD PTR [rbp-0x50]
     4eb:	44 8b 45 b8          	mov    r8d,DWORD PTR [rbp-0x48]
     4ef:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     4f3:	ff 75 28             	push   QWORD PTR [rbp+0x28]
     4f6:	48 8d 7d d4          	lea    rdi,[rbp-0x2c]
     4fa:	57                   	push   rdi
     4fb:	ff 75 18             	push   QWORD PTR [rbp+0x18]
     4fe:	8b 7d 10             	mov    edi,DWORD PTR [rbp+0x10]
     501:	57                   	push   rdi
     502:	48 89 c7             	mov    rdi,rax
     505:	e8 00 00 00 00       	call   50a <mm_pmue_get_range+0x123>
     50a:	48 83 c4 20          	add    rsp,0x20
     50e:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
								lvl - 1, pg_ct, pr, pr_ct, n_pr, &bs, base);
						/* set counts */
						rv += rv2;
     511:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     514:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
						pg_ct -= rv2;
     517:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     51a:	29 45 b8             	sub    DWORD PTR [rbp-0x48],eax
						pr += *n_pr - prr;
     51d:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     521:	8b 00                	mov    eax,DWORD PTR [rax]
     523:	2b 45 dc             	sub    eax,DWORD PTR [rbp-0x24]
     526:	89 c0                	mov    eax,eax
     528:	48 c1 e0 04          	shl    rax,0x4
     52c:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
						pr_ct -= *n_pr - prr;
     530:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     534:	8b 00                	mov    eax,DWORD PTR [rax]
     536:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
     539:	29 c2                	sub    edx,eax
     53b:	01 55 10             	add    DWORD PTR [rbp+0x10],edx
						/* update by checking bits set in range */
						if (bs == 2) {
     53e:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     541:	83 f8 02             	cmp    eax,0x2
     544:	75 19                	jne    55f <mm_pmue_get_range+0x178>
								asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     546:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     549:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     54d:	0f ab 02             	bts    DWORD PTR [rdx],eax
								(*bsir)++;
     550:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     554:	8b 00                	mov    eax,DWORD PTR [rax]
     556:	8d 50 01             	lea    edx,[rax+0x1]
     559:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     55d:	89 10                	mov    DWORD PTR [rax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct & !rv2))
     55f:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     563:	0f 84 06 01 00 00    	je     66f <mm_pmue_get_range+0x288>
     569:	8b 45 10             	mov    eax,DWORD PTR [rbp+0x10]
     56c:	0b 45 d8             	or     eax,DWORD PTR [rbp-0x28]
     56f:	85 c0                	test   eax,eax
     571:	0f 84 f8 00 00 00    	je     66f <mm_pmue_get_range+0x288>
						/* check for done */
						if (!pg_ct)
								break;

				}
				continue;
     577:	e9 e2 00 00 00       	jmp    65e <mm_pmue_get_range+0x277>
						uint64_t b = base + i * 4096, bp = 1;
     57c:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     57f:	c1 e0 0c             	shl    eax,0xc
     582:	89 c2                	mov    edx,eax
     584:	48 8b 45 28          	mov    rax,QWORD PTR [rbp+0x28]
     588:	48 01 d0             	add    rax,rdx
     58b:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     58f:	48 c7 45 e8 01 00 00 00 	mov    QWORD PTR [rbp-0x18],0x1
						asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     597:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     59a:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     59e:	0f ab 02             	bts    DWORD PTR [rdx],eax
						if (*n_pr)
     5a1:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     5a5:	8b 00                	mov    eax,DWORD PTR [rax]
     5a7:	85 c0                	test   eax,eax
     5a9:	74 22                	je     5cd <mm_pmue_get_range+0x1e6>
								bp = pr[-1].base + 4096 * pr[-1].count;
     5ab:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     5af:	48 83 e8 10          	sub    rax,0x10
     5b3:	48 8b 00             	mov    rax,QWORD PTR [rax]
     5b6:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     5ba:	48 83 ea 10          	sub    rdx,0x10
     5be:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
     5c2:	48 c1 e2 0c          	shl    rdx,0xc
     5c6:	48 01 d0             	add    rax,rdx
     5c9:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (b == bp)
     5cd:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5d1:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
     5d5:	75 16                	jne    5ed <mm_pmue_get_range+0x206>
								pr[-1].count++;
     5d7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     5db:	48 83 e8 10          	sub    rax,0x10
     5df:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     5e3:	48 83 c2 01          	add    rdx,0x1
     5e7:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     5eb:	eb 41                	jmp    62e <mm_pmue_get_range+0x247>
								if (!pr_ct) { /* rollback */
     5ed:	83 7d 10 00          	cmp    DWORD PTR [rbp+0x10],0x0
     5f1:	75 0c                	jne    5ff <mm_pmue_get_range+0x218>
										asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     5f3:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     5f6:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     5fa:	0f bb 02             	btc    DWORD PTR [rdx],eax
										break;
     5fd:	eb 70                	jmp    66f <mm_pmue_get_range+0x288>
								pr->base = b;
     5ff:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     603:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     607:	48 89 10             	mov    QWORD PTR [rax],rdx
								pr->count = 1;
     60a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     60e:	48 c7 40 08 01 00 00 00 	mov    QWORD PTR [rax+0x8],0x1
								pr_ct--;
     616:	83 6d 10 01          	sub    DWORD PTR [rbp+0x10],0x1
								(*n_pr)++;
     61a:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     61e:	8b 00                	mov    eax,DWORD PTR [rax]
     620:	8d 50 01             	lea    edx,[rax+0x1]
     623:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     627:	89 10                	mov    DWORD PTR [rax],edx
								pr++;
     629:	48 83 45 b0 10       	add    QWORD PTR [rbp-0x50],0x10
						rv++;
     62e:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
						pg_ct--;
     632:	83 6d b8 01          	sub    DWORD PTR [rbp-0x48],0x1
						(*bsir)++;
     636:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     63a:	8b 00                	mov    eax,DWORD PTR [rax]
     63c:	8d 50 01             	lea    edx,[rax+0x1]
     63f:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     643:	89 10                	mov    DWORD PTR [rax],edx
						if (!pg_ct)
     645:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     649:	75 13                	jne    65e <mm_pmue_get_range+0x277>
								break;
     64b:	eb 22                	jmp    66f <mm_pmue_get_range+0x288>

carry:
				(*bsir)++;
     64d:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     651:	8b 00                	mov    eax,DWORD PTR [rax]
     653:	8d 50 01             	lea    edx,[rax+0x1]
     656:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     65a:	89 10                	mov    DWORD PTR [rax],edx
     65c:	eb 01                	jmp    65f <mm_pmue_get_range+0x278>
				continue;
     65e:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
     65f:	83 45 f0 01          	add    DWORD PTR [rbp-0x10],0x1
     663:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     666:	39 45 c0             	cmp    DWORD PTR [rbp-0x40],eax
     669:	0f 83 3a fe ff ff    	jae    4a9 <mm_pmue_get_range+0xc2>
		}

		return rv;
     66f:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     672:	c9                   	leave
     673:	c3                   	ret

0000000000000674 <mm_rcpe_get_range>:

uint32_t mm_rcpe_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bfir, uint64_t base)
{
     674:	55                   	push   rbp
     675:	48 89 e5             	mov    rbp,rsp
     678:	48 83 ec 50          	sub    rsp,0x50
     67c:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     680:	89 75 c4             	mov    DWORD PTR [rbp-0x3c],esi
     683:	89 55 c0             	mov    DWORD PTR [rbp-0x40],edx
     686:	89 4d bc             	mov    DWORD PTR [rbp-0x44],ecx
     689:	44 89 45 b8          	mov    DWORD PTR [rbp-0x48],r8d
     68d:	4c 89 4d b0          	mov    QWORD PTR [rbp-0x50],r9
		uint32_t* bitfield, rv = 0;
     691:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0

		/* set the reference */
		switch (lvl) {
     698:	83 7d bc 07          	cmp    DWORD PTR [rbp-0x44],0x7
     69c:	74 14                	je     6b2 <mm_rcpe_get_range+0x3e>
     69e:	83 7d bc 07          	cmp    DWORD PTR [rbp-0x44],0x7
     6a2:	77 3a                	ja     6de <mm_rcpe_get_range+0x6a>
     6a4:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     6a8:	74 28                	je     6d2 <mm_rcpe_get_range+0x5e>
     6aa:	83 7d bc 02          	cmp    DWORD PTR [rbp-0x44],0x2
     6ae:	74 12                	je     6c2 <mm_rcpe_get_range+0x4e>
     6b0:	eb 2c                	jmp    6de <mm_rcpe_get_range+0x6a>
				case 7:
						bitfield = &p->lvl7;
     6b2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6b6:	48 05 f8 03 00 00    	add    rax,0x3f8
     6bc:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     6c0:	eb 1e                	jmp    6e0 <mm_rcpe_get_range+0x6c>
				case 2:
						bitfield = p->lvl2;
     6c2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6c6:	48 05 00 03 00 00    	add    rax,0x300
     6cc:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     6d0:	eb 0e                	jmp    6e0 <mm_rcpe_get_range+0x6c>
				case 0:
						bitfield = p->lvl0;
     6d2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6d6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     6da:	eb 04                	jmp    6e0 <mm_rcpe_get_range+0x6c>
     6dc:	eb 00                	jmp    6de <mm_rcpe_get_range+0x6a>
				default:
						while (1);
     6de:	eb fc                	jmp    6dc <mm_rcpe_get_range+0x68>
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
     6e0:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     6e3:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
     6e6:	e9 ff 01 00 00       	jmp    8ea <mm_rcpe_get_range+0x276>
				/* test each bit */
				asm goto("bt %0, %1\n"
     6eb:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     6ee:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     6f2:	0f a3 02             	bt     DWORD PTR [rdx],eax
     6f5:	0f 83 d9 01 00 00    	jae    8d4 <mm_rcpe_get_range+0x260>
						 "jnc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : nocarry);

				/* we've got a reclaimable entry at i */
				if (lvl > 0) {
     6fb:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     6ff:	0f 84 f2 00 00 00    	je     7f7 <mm_rcpe_get_range+0x183>
						uint32_t rv2, prr = *n_pr, bf = 0, mul;
     705:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     709:	8b 00                	mov    eax,DWORD PTR [rax]
     70b:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
     70e:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [rbp-0x30],0x0
						mul = (lvl == 2) ? 4 : 32;
     715:	83 7d bc 02          	cmp    DWORD PTR [rbp-0x44],0x2
     719:	75 07                	jne    722 <mm_rcpe_get_range+0xae>
     71b:	b8 04 00 00 00       	mov    eax,0x4
     720:	eb 05                	jmp    727 <mm_rcpe_get_range+0xb3>
     722:	b8 20 00 00 00       	mov    eax,0x20
     727:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
						/* go deeper */
						rv2 = mm_rcpe_get_range(p, i * mul, (i + 1) * mul - 1,
     72a:	83 7d bc 02          	cmp    DWORD PTR [rbp-0x44],0x2
     72e:	75 08                	jne    738 <mm_rcpe_get_range+0xc4>
     730:	41 ba 00 00 00 00    	mov    r10d,0x0
     736:	eb 06                	jmp    73e <mm_rcpe_get_range+0xca>
     738:	41 ba 02 00 00 00    	mov    r10d,0x2
     73e:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     741:	83 c0 01             	add    eax,0x1
     744:	0f af 45 d8          	imul   eax,DWORD PTR [rbp-0x28]
     748:	8d 50 ff             	lea    edx,[rax-0x1]
     74b:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     74e:	0f af 45 d8          	imul   eax,DWORD PTR [rbp-0x28]
     752:	89 c6                	mov    esi,eax
     754:	4c 8b 45 b0          	mov    r8,QWORD PTR [rbp-0x50]
     758:	8b 7d b8             	mov    edi,DWORD PTR [rbp-0x48]
     75b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     75f:	ff 75 28             	push   QWORD PTR [rbp+0x28]
     762:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
     766:	51                   	push   rcx
     767:	ff 75 18             	push   QWORD PTR [rbp+0x18]
     76a:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
     76d:	51                   	push   rcx
     76e:	4d 89 c1             	mov    r9,r8
     771:	41 89 f8             	mov    r8d,edi
     774:	44 89 d1             	mov    ecx,r10d
     777:	48 89 c7             	mov    rdi,rax
     77a:	e8 00 00 00 00       	call   77f <mm_rcpe_get_range+0x10b>
     77f:	48 83 c4 20          	add    rsp,0x20
     783:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
								(lvl == 2) ? 0 : 2, pg_ct, pr, pr_ct, n_pr, &bf, base);
						/* set counts */
						rv += rv2;
     786:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     789:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
						pg_ct -= rv2;
     78c:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     78f:	29 45 b8             	sub    DWORD PTR [rbp-0x48],eax
						pr += *n_pr - prr;
     792:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     796:	8b 00                	mov    eax,DWORD PTR [rax]
     798:	2b 45 dc             	sub    eax,DWORD PTR [rbp-0x24]
     79b:	89 c0                	mov    eax,eax
     79d:	48 c1 e0 04          	shl    rax,0x4
     7a1:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
						pr_ct -= *n_pr - prr;
     7a5:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     7a9:	8b 00                	mov    eax,DWORD PTR [rax]
     7ab:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
     7ae:	29 c2                	sub    edx,eax
     7b0:	01 55 10             	add    DWORD PTR [rbp+0x10],edx
						/* update by checking bits free in range */
						if (bf == mul) {
     7b3:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     7b6:	39 45 d8             	cmp    DWORD PTR [rbp-0x28],eax
     7b9:	75 19                	jne    7d4 <mm_rcpe_get_range+0x160>
								asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     7bb:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     7be:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     7c2:	0f bb 02             	btc    DWORD PTR [rdx],eax
								(*bfir)++;
     7c5:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     7c9:	8b 00                	mov    eax,DWORD PTR [rax]
     7cb:	8d 50 01             	lea    edx,[rax+0x1]
     7ce:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     7d2:	89 10                	mov    DWORD PTR [rax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct && !rv2))
     7d4:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     7d8:	0f 84 18 01 00 00    	je     8f6 <mm_rcpe_get_range+0x282>
     7de:	83 7d 10 00          	cmp    DWORD PTR [rbp+0x10],0x0
     7e2:	0f 85 fd 00 00 00    	jne    8e5 <mm_rcpe_get_range+0x271>
     7e8:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
     7ec:	0f 84 04 01 00 00    	je     8f6 <mm_rcpe_get_range+0x282>
						mm_scrub_single_page(b);
						/* check for done */
						if (!pg_ct)
								break;
				}
				continue;
     7f2:	e9 ee 00 00 00       	jmp    8e5 <mm_rcpe_get_range+0x271>
						uint64_t b = base + i * 4096, bp = 1;
     7f7:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     7fa:	c1 e0 0c             	shl    eax,0xc
     7fd:	89 c2                	mov    edx,eax
     7ff:	48 8b 45 28          	mov    rax,QWORD PTR [rbp+0x28]
     803:	48 01 d0             	add    rax,rdx
     806:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     80a:	48 c7 45 e8 01 00 00 00 	mov    QWORD PTR [rbp-0x18],0x1
						asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     812:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     815:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     819:	0f bb 02             	btc    DWORD PTR [rdx],eax
						if (*n_pr)
     81c:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     820:	8b 00                	mov    eax,DWORD PTR [rax]
     822:	85 c0                	test   eax,eax
     824:	74 22                	je     848 <mm_rcpe_get_range+0x1d4>
								bp = pr[-1].base + 4096 * pr[-1].count;
     826:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     82a:	48 83 e8 10          	sub    rax,0x10
     82e:	48 8b 00             	mov    rax,QWORD PTR [rax]
     831:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     835:	48 83 ea 10          	sub    rdx,0x10
     839:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
     83d:	48 c1 e2 0c          	shl    rdx,0xc
     841:	48 01 d0             	add    rax,rdx
     844:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (b == bp)
     848:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     84c:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
     850:	75 16                	jne    868 <mm_rcpe_get_range+0x1f4>
								pr[-1].count++;
     852:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     856:	48 83 e8 10          	sub    rax,0x10
     85a:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     85e:	48 83 c2 01          	add    rdx,0x1
     862:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     866:	eb 41                	jmp    8a9 <mm_rcpe_get_range+0x235>
								if (!pr_ct) { /* rollback */
     868:	83 7d 10 00          	cmp    DWORD PTR [rbp+0x10],0x0
     86c:	75 0c                	jne    87a <mm_rcpe_get_range+0x206>
										asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     86e:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     871:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     875:	0f ab 02             	bts    DWORD PTR [rdx],eax
										break;
     878:	eb 7c                	jmp    8f6 <mm_rcpe_get_range+0x282>
								pr->base = b;
     87a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     87e:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     882:	48 89 10             	mov    QWORD PTR [rax],rdx
								pr->count = 1;
     885:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     889:	48 c7 40 08 01 00 00 00 	mov    QWORD PTR [rax+0x8],0x1
								pr_ct--;
     891:	83 6d 10 01          	sub    DWORD PTR [rbp+0x10],0x1
								(*n_pr)++;
     895:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     899:	8b 00                	mov    eax,DWORD PTR [rax]
     89b:	8d 50 01             	lea    edx,[rax+0x1]
     89e:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     8a2:	89 10                	mov    DWORD PTR [rax],edx
								pr++;
     8a4:	48 83 45 b0 10       	add    QWORD PTR [rbp-0x50],0x10
						rv++;
     8a9:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
						pg_ct--;
     8ad:	83 6d b8 01          	sub    DWORD PTR [rbp-0x48],0x1
						(*bfir)++;
     8b1:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     8b5:	8b 00                	mov    eax,DWORD PTR [rax]
     8b7:	8d 50 01             	lea    edx,[rax+0x1]
     8ba:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     8be:	89 10                	mov    DWORD PTR [rax],edx
						mm_scrub_single_page(b);
     8c0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     8c4:	48 89 c7             	mov    rdi,rax
     8c7:	e8 00 00 00 00       	call   8cc <mm_rcpe_get_range+0x258>
						if (!pg_ct)
     8cc:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     8d0:	75 13                	jne    8e5 <mm_rcpe_get_range+0x271>
								break;
     8d2:	eb 22                	jmp    8f6 <mm_rcpe_get_range+0x282>

nocarry:
				(*bfir)++;
     8d4:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     8d8:	8b 00                	mov    eax,DWORD PTR [rax]
     8da:	8d 50 01             	lea    edx,[rax+0x1]
     8dd:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     8e1:	89 10                	mov    DWORD PTR [rax],edx
     8e3:	eb 01                	jmp    8e6 <mm_rcpe_get_range+0x272>
				continue;
     8e5:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
     8e6:	83 45 f0 01          	add    DWORD PTR [rbp-0x10],0x1
     8ea:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     8ed:	39 45 c0             	cmp    DWORD PTR [rbp-0x40],eax
     8f0:	0f 83 f5 fd ff ff    	jae    6eb <mm_rcpe_get_range+0x77>
		}

		return rv;
     8f6:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     8f9:	c9                   	leave
     8fa:	c3                   	ret

00000000000008fb <mm_fmrc_get>:

/* is used to really set entries in a pmu/rcp */
uint32_t mm_fmrc_get(struct pmu* p, uint32_t idx, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr, uint64_t base)
{
     8fb:	55                   	push   rbp
     8fc:	48 89 e5             	mov    rbp,rsp
     8ff:	48 83 ec 50          	sub    rsp,0x50
     903:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     907:	89 75 c4             	mov    DWORD PTR [rbp-0x3c],esi
     90a:	89 55 c0             	mov    DWORD PTR [rbp-0x40],edx
     90d:	89 4d bc             	mov    DWORD PTR [rbp-0x44],ecx
     910:	4c 89 45 b0          	mov    QWORD PTR [rbp-0x50],r8
     914:	44 89 4d b8          	mov    DWORD PTR [rbp-0x48],r9d
		size_t i; uint32_t msk = 0x00000003, rv = 0;
     918:	c7 45 f4 03 00 00 00 	mov    DWORD PTR [rbp-0xc],0x3
     91f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
		struct pmue* e = &p->entries[idx];
     926:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
     929:	48 89 d0             	mov    rax,rdx
     92c:	48 c1 e0 08          	shl    rax,0x8
     930:	48 29 d0             	sub    rax,rdx
     933:	48 c1 e0 02          	shl    rax,0x2
     937:	48 8d 50 10          	lea    rdx,[rax+0x10]
     93b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     93f:	48 01 d0             	add    rax,rdx
     942:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		/* lock is 2 lvl7 bits wide (256 pages) so use it sparingly */

		/* first skip all full/empty lvl7 ranges (2 at a time) */
		uint32_t prc = 0;
     946:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [rbp-0x2c],0x0
		for (i = 0; i < 16; i++) {
     94d:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     955:	e9 7b 01 00 00       	jmp    ad5 <mm_fmrc_get+0x1da>
				uint8_t bt = ((e->lvl7 & msk) >> 2 * i);
     95a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     95e:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [rax+0x3f8]
     964:	23 45 f4             	and    eax,DWORD PTR [rbp-0xc]
     967:	89 c2                	mov    edx,eax
     969:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     96d:	01 c0                	add    eax,eax
     96f:	89 c1                	mov    ecx,eax
     971:	d3 ea                	shr    edx,cl
     973:	89 d0                	mov    eax,edx
     975:	88 45 df             	mov    BYTE PTR [rbp-0x21],al
				if (free ? (bt != 3) : (bt)) { /* all set/unset */
     978:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     97c:	74 09                	je     987 <mm_fmrc_get+0x8c>
     97e:	80 7d df 03          	cmp    BYTE PTR [rbp-0x21],0x3
     982:	0f 95 c0             	setne  al
     985:	eb 07                	jmp    98e <mm_fmrc_get+0x93>
     987:	80 7d df 00          	cmp    BYTE PTR [rbp-0x21],0x0
     98b:	0f 95 c0             	setne  al
     98e:	84 c0                	test   al,al
     990:	0f 84 35 01 00 00    	je     acb <mm_fmrc_get+0x1d0>
						uint32_t rv2 = 0, pcc = prc, bsir = 0;
     996:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
     99d:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     9a0:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
     9a3:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [rbp-0x30],0x0
						/* some bits set: try to lock */
						asm goto("lock bts %0, %1\n"
							"jc %l2\n" : : "r" (idx * 16 + 2 * i),
     9aa:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     9ad:	c1 e0 04             	shl    eax,0x4
     9b0:	89 c2                	mov    edx,eax
     9b2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9b6:	48 01 c0             	add    rax,rax
     9b9:	48 01 c2             	add    rdx,rax
						asm goto("lock bts %0, %1\n"
     9bc:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     9c0:	f0 48 0f ab 10       	lock bts QWORD PTR [rax],rdx
     9c5:	0f 82 01 01 00 00    	jb     acc <mm_fmrc_get+0x1d1>
							"m" (*p->locks) : "cc" : carry);

						/* we hold the lock (else jump to carry) */
						if (free)
     9cb:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     9cf:	74 48                	je     a19 <mm_fmrc_get+0x11e>
								rv2 = mm_pmue_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
     9d1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9d5:	01 c0                	add    eax,eax
     9d7:	8d 50 01             	lea    edx,[rax+0x1]
     9da:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9de:	8d 34 00             	lea    esi,[rax+rax*1]
     9e1:	4c 8b 45 b0          	mov    r8,QWORD PTR [rbp-0x50]
     9e5:	8b 7d c0             	mov    edi,DWORD PTR [rbp-0x40]
     9e8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     9ec:	ff 75 18             	push   QWORD PTR [rbp+0x18]
     9ef:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
     9f3:	51                   	push   rcx
     9f4:	48 8d 4d d4          	lea    rcx,[rbp-0x2c]
     9f8:	51                   	push   rcx
     9f9:	8b 4d b8             	mov    ecx,DWORD PTR [rbp-0x48]
     9fc:	51                   	push   rcx
     9fd:	4d 89 c1             	mov    r9,r8
     a00:	41 89 f8             	mov    r8d,edi
     a03:	b9 07 00 00 00       	mov    ecx,0x7
     a08:	48 89 c7             	mov    rdi,rax
     a0b:	e8 00 00 00 00       	call   a10 <mm_fmrc_get+0x115>
     a10:	48 83 c4 20          	add    rsp,0x20
     a14:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
     a17:	eb 46                	jmp    a5f <mm_fmrc_get+0x164>
										pr, pr_ct, &prc, &bsir, base);
						else
								rv2 = mm_rcpe_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
     a19:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a1d:	01 c0                	add    eax,eax
     a1f:	8d 50 01             	lea    edx,[rax+0x1]
     a22:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a26:	8d 34 00             	lea    esi,[rax+rax*1]
     a29:	4c 8b 45 b0          	mov    r8,QWORD PTR [rbp-0x50]
     a2d:	8b 7d c0             	mov    edi,DWORD PTR [rbp-0x40]
     a30:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     a34:	ff 75 18             	push   QWORD PTR [rbp+0x18]
     a37:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
     a3b:	51                   	push   rcx
     a3c:	48 8d 4d d4          	lea    rcx,[rbp-0x2c]
     a40:	51                   	push   rcx
     a41:	8b 4d b8             	mov    ecx,DWORD PTR [rbp-0x48]
     a44:	51                   	push   rcx
     a45:	4d 89 c1             	mov    r9,r8
     a48:	41 89 f8             	mov    r8d,edi
     a4b:	b9 07 00 00 00       	mov    ecx,0x7
     a50:	48 89 c7             	mov    rdi,rax
     a53:	e8 00 00 00 00       	call   a58 <mm_fmrc_get+0x15d>
     a58:	48 83 c4 20          	add    rsp,0x20
     a5c:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
										pr, pr_ct, &prc, &bsir, base);
						pr_ct -= prc - pcc;
     a5f:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     a62:	8b 55 d8             	mov    edx,DWORD PTR [rbp-0x28]
     a65:	29 c2                	sub    edx,eax
     a67:	01 55 b8             	add    DWORD PTR [rbp-0x48],edx
						pr += prc - pcc;
     a6a:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     a6d:	2b 45 d8             	sub    eax,DWORD PTR [rbp-0x28]
     a70:	89 c0                	mov    eax,eax
     a72:	48 c1 e0 04          	shl    rax,0x4
     a76:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
						*n_pr += prc - pcc;
     a7a:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     a7e:	8b 10                	mov    edx,DWORD PTR [rax]
     a80:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     a83:	2b 45 d8             	sub    eax,DWORD PTR [rbp-0x28]
     a86:	01 c2                	add    edx,eax
     a88:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     a8c:	89 10                	mov    DWORD PTR [rax],edx
						rv += rv2;
     a8e:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     a91:	01 45 f0             	add    DWORD PTR [rbp-0x10],eax
						pg_ct -= rv2;
     a94:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     a97:	29 45 c0             	sub    DWORD PTR [rbp-0x40],eax

						/* release lock */
						asm("btr %0, %1\n" : : "r" (idx * 16 + 2 * i),
     a9a:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     a9d:	c1 e0 04             	shl    eax,0x4
     aa0:	89 c2                	mov    edx,eax
     aa2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     aa6:	48 01 c0             	add    rax,rax
     aa9:	48 01 c2             	add    rdx,rax
     aac:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     ab0:	48 0f b3 10          	btr    QWORD PTR [rax],rdx
							"m" (*p->locks) : "cc");

						if (!pg_ct || (!pr_ct && !rv2))
     ab4:	83 7d c0 00          	cmp    DWORD PTR [rbp-0x40],0x0
     ab8:	74 0c                	je     ac6 <mm_fmrc_get+0x1cb>
     aba:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     abe:	75 0c                	jne    acc <mm_fmrc_get+0x1d1>
     ac0:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     ac4:	75 06                	jne    acc <mm_fmrc_get+0x1d1>
								return rv;
     ac6:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     ac9:	eb 18                	jmp    ae3 <mm_fmrc_get+0x1e8>
				}
carry:
     acb:	90                   	nop
				/* advance */
				msk <<= 2;
     acc:	c1 65 f4 02          	shl    DWORD PTR [rbp-0xc],0x2
		for (i = 0; i < 16; i++) {
     ad0:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     ad5:	48 83 7d f8 0f       	cmp    QWORD PTR [rbp-0x8],0xf
     ada:	0f 86 7a fe ff ff    	jbe    95a <mm_fmrc_get+0x5f>
		}

		return rv;
     ae0:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
}
     ae3:	c9                   	leave
     ae4:	c3                   	ret

0000000000000ae5 <mm_fmrc_alloc_pm>:

/* used for getting pages which are marked as free/reclaimable */
uint32_t mm_fmrc_alloc_pm(struct fme* fm, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr)
{
     ae5:	55                   	push   rbp
     ae6:	48 89 e5             	mov    rbp,rsp
     ae9:	48 83 ec 70          	sub    rsp,0x70
     aed:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
     af1:	89 75 b4             	mov    DWORD PTR [rbp-0x4c],esi
     af4:	89 55 b0             	mov    DWORD PTR [rbp-0x50],edx
     af7:	48 89 4d a8          	mov    QWORD PTR [rbp-0x58],rcx
     afb:	44 89 45 a4          	mov    DWORD PTR [rbp-0x5c],r8d
     aff:	4c 89 4d 98          	mov    QWORD PTR [rbp-0x68],r9
		uint32_t rv = 0; uint64_t base = fm->base;
     b03:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     b0a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     b0e:	48 8b 00             	mov    rax,QWORD PTR [rax]
     b11:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		size_t i, j; uint64_t mem = (free ? fm->pmu : fm->rcp);
     b15:	83 7d b0 00          	cmp    DWORD PTR [rbp-0x50],0x0
     b19:	74 0a                	je     b25 <mm_fmrc_alloc_pm+0x40>
     b1b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     b1f:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
     b23:	eb 08                	jmp    b2d <mm_fmrc_alloc_pm+0x48>
     b25:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     b29:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
     b2d:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax

		for (i = 0; i < fm->ec; i++) {
     b31:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     b39:	e9 30 01 00 00       	jmp    c6e <mm_fmrc_alloc_pm+0x189>
				struct pmu* p = (void*)(size_t)mem;
     b3e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b42:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				/* skip if above limit */
				/*if (mem + 4096 > 0x100000000)
						break; - no idea what that was */ 

				/* operate on pmu/rcp */
				if (p->free_ct[0] == 0xffff) {
     b46:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b4a:	0f b7 40 08          	movzx  eax,WORD PTR [rax+0x8]
     b4e:	66 83 f8 ff          	cmp    ax,0xffff
     b52:	75 2f                	jne    b83 <mm_fmrc_alloc_pm+0x9e>
						if (free) {
     b54:	83 7d b0 00          	cmp    DWORD PTR [rbp-0x50],0x0
     b58:	74 15                	je     b6f <mm_fmrc_alloc_pm+0x8a>
								if (mm_init_pmu(p))
     b5a:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b5e:	48 89 c7             	mov    rdi,rax
     b61:	e8 00 00 00 00       	call   b66 <mm_fmrc_alloc_pm+0x81>
     b66:	85 c0                	test   eax,eax
     b68:	74 19                	je     b83 <mm_fmrc_alloc_pm+0x9e>
										continue; /* if locked */
     b6a:	e9 fa 00 00 00       	jmp    c69 <mm_fmrc_alloc_pm+0x184>
						} else {
								if (mm_init_rcp(p))
     b6f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b73:	48 89 c7             	mov    rdi,rax
     b76:	e8 00 00 00 00       	call   b7b <mm_fmrc_alloc_pm+0x96>
     b7b:	85 c0                	test   eax,eax
     b7d:	0f 85 e5 00 00 00    	jne    c68 <mm_fmrc_alloc_pm+0x183>
										continue; /* if locked */
						}
				}

				/* check for free/reclaimable counts */
				for (j = 0; j < 4; j++) {
     b83:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     b8b:	e9 cb 00 00 00       	jmp    c5b <mm_fmrc_alloc_pm+0x176>
						if (p->free_ct[j] > 0) {
     b90:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b94:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     b98:	0f b7 44 50 08       	movzx  eax,WORD PTR [rax+rdx*2+0x8]
     b9d:	66 85 c0             	test   ax,ax
     ba0:	0f 84 a8 00 00 00    	je     c4e <mm_fmrc_alloc_pm+0x169>
								uint32_t rv2, np = 0;
     ba6:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [rbp-0x38],0x0
								/* operate on lock */
								rv2 = mm_fmrc_get(p, j, pg_ct, free, pr,
     bad:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     bb1:	41 89 c2             	mov    r10d,eax
     bb4:	44 8b 45 a4          	mov    r8d,DWORD PTR [rbp-0x5c]
     bb8:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
     bbc:	8b 4d b0             	mov    ecx,DWORD PTR [rbp-0x50]
     bbf:	8b 55 b4             	mov    edx,DWORD PTR [rbp-0x4c]
     bc2:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     bc6:	ff 75 f0             	push   QWORD PTR [rbp-0x10]
     bc9:	48 8d 75 c8          	lea    rsi,[rbp-0x38]
     bcd:	56                   	push   rsi
     bce:	45 89 c1             	mov    r9d,r8d
     bd1:	49 89 f8             	mov    r8,rdi
     bd4:	44 89 d6             	mov    esi,r10d
     bd7:	48 89 c7             	mov    rdi,rax
     bda:	e8 00 00 00 00       	call   bdf <mm_fmrc_alloc_pm+0xfa>
     bdf:	48 83 c4 10          	add    rsp,0x10
     be3:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
												pr_ct, &np, base);

								*n_pr += np;
     be6:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     bea:	8b 10                	mov    edx,DWORD PTR [rax]
     bec:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     bef:	01 c2                	add    edx,eax
     bf1:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     bf5:	89 10                	mov    DWORD PTR [rax],edx
								pr_ct -= np;
     bf7:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     bfa:	29 45 a4             	sub    DWORD PTR [rbp-0x5c],eax
								pr += np;
     bfd:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c00:	89 c0                	mov    eax,eax
     c02:	48 c1 e0 04          	shl    rax,0x4
     c06:	48 01 45 a8          	add    QWORD PTR [rbp-0x58],rax
								rv += rv2;
     c0a:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     c0d:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
								pg_ct -= rv2;
     c10:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     c13:	29 45 b4             	sub    DWORD PTR [rbp-0x4c],eax
								/* update count */
								p->free_ct[j] -= rv2;
     c16:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     c1a:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     c1e:	0f b7 44 50 08       	movzx  eax,WORD PTR [rax+rdx*2+0x8]
     c23:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
     c26:	29 d0                	sub    eax,edx
     c28:	89 c1                	mov    ecx,eax
     c2a:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     c2e:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     c32:	66 89 4c 50 08       	mov    WORD PTR [rax+rdx*2+0x8],cx
								/* exit if done or list exhausted (and no extension) */
								if (!pg_ct || (!pr_ct && !rv2))
     c37:	83 7d b4 00          	cmp    DWORD PTR [rbp-0x4c],0x0
     c3b:	74 0c                	je     c49 <mm_fmrc_alloc_pm+0x164>
     c3d:	83 7d a4 00          	cmp    DWORD PTR [rbp-0x5c],0x0
     c41:	75 0b                	jne    c4e <mm_fmrc_alloc_pm+0x169>
     c43:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
     c47:	75 05                	jne    c4e <mm_fmrc_alloc_pm+0x169>
										return rv;
     c49:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     c4c:	eb 35                	jmp    c83 <mm_fmrc_alloc_pm+0x19e>
						}

						/* advance base */
						base += 4096 * 4096;
     c4e:	48 81 45 f0 00 00 00 01 	add    QWORD PTR [rbp-0x10],0x1000000
				for (j = 0; j < 4; j++) {
     c56:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
     c5b:	48 83 7d e0 03       	cmp    QWORD PTR [rbp-0x20],0x3
     c60:	0f 86 2a ff ff ff    	jbe    b90 <mm_fmrc_alloc_pm+0xab>
     c66:	eb 01                	jmp    c69 <mm_fmrc_alloc_pm+0x184>
										continue; /* if locked */
     c68:	90                   	nop
		for (i = 0; i < fm->ec; i++) {
     c69:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     c6e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     c72:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     c76:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
     c7a:	0f 82 be fe ff ff    	jb     b3e <mm_fmrc_alloc_pm+0x59>
				}
		}

		return rv;
     c80:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
     c83:	c9                   	leave
     c84:	c3                   	ret

0000000000000c85 <mm_alloc_pm>:

uint32_t mm_alloc_pm(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct)
{
     c85:	55                   	push   rbp
     c86:	48 89 e5             	mov    rbp,rsp
     c89:	48 83 ec 30          	sub    rsp,0x30
     c8d:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi
     c90:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
     c94:	89 55 d8             	mov    DWORD PTR [rbp-0x28],edx
		size_t i; uint32_t rv = 0, r2 = 0, pr_o = 0;
     c97:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
     c9e:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
     ca5:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [rbp-0x1c],0x0

retry:
		for (i = fm_begin; i < fm_ofs; i++) {
     cac:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # cb3 <mm_alloc_pm+0x2e>
     cb3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     cb7:	e9 ba 01 00 00       	jmp    e76 <mm_alloc_pm+0x1f1>
				/* skip if scrubbing is needed */
				if (!r2 && !fmm[i].free_pages)
     cbc:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
     cc0:	75 27                	jne    ce9 <mm_alloc_pm+0x64>
     cc2:	b9 00 40 02 00       	mov    ecx,0x24000
     cc7:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     ccb:	48 89 d0             	mov    rax,rdx
     cce:	48 c1 e0 03          	shl    rax,0x3
     cd2:	48 29 d0             	sub    rax,rdx
     cd5:	48 c1 e0 03          	shl    rax,0x3
     cd9:	48 01 c8             	add    rax,rcx
     cdc:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     ce0:	48 85 c0             	test   rax,rax
     ce3:	0f 84 84 01 00 00    	je     e6d <mm_alloc_pm+0x1e8>
						continue;

				/* collect free pages */
				if (fmm[i].free_pages) {
     ce9:	b9 00 40 02 00       	mov    ecx,0x24000
     cee:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     cf2:	48 89 d0             	mov    rax,rdx
     cf5:	48 c1 e0 03          	shl    rax,0x3
     cf9:	48 29 d0             	sub    rax,rdx
     cfc:	48 c1 e0 03          	shl    rax,0x3
     d00:	48 01 c8             	add    rax,rcx
     d03:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     d07:	48 85 c0             	test   rax,rax
     d0a:	0f 84 9f 00 00 00    	je     daf <mm_alloc_pm+0x12a>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 1, pr + pr_o,
     d10:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     d13:	8b 55 d8             	mov    edx,DWORD PTR [rbp-0x28]
     d16:	89 d6                	mov    esi,edx
     d18:	29 c6                	sub    esi,eax
     d1a:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     d1d:	89 c0                	mov    eax,eax
     d1f:	48 c1 e0 04          	shl    rax,0x4
     d23:	48 89 c2             	mov    rdx,rax
     d26:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     d2a:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
     d2e:	bf 00 40 02 00       	mov    edi,0x24000
     d33:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     d37:	48 89 d0             	mov    rax,rdx
     d3a:	48 c1 e0 03          	shl    rax,0x3
     d3e:	48 29 d0             	sub    rax,rdx
     d41:	48 c1 e0 03          	shl    rax,0x3
     d45:	48 01 c7             	add    rdi,rax
     d48:	48 8d 55 e4          	lea    rdx,[rbp-0x1c]
     d4c:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     d4f:	49 89 d1             	mov    r9,rdx
     d52:	41 89 f0             	mov    r8d,esi
     d55:	ba 01 00 00 00       	mov    edx,0x1
     d5a:	89 c6                	mov    esi,eax
     d5c:	e8 00 00 00 00       	call   d61 <mm_alloc_pm+0xdc>
     d61:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
     d64:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     d67:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
						pg_ct -= rv2;
     d6a:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     d6d:	29 45 dc             	sub    DWORD PTR [rbp-0x24],eax
						__sync_sub_and_fetch(&fmm[i].free_pages, rv2);
     d70:	8b 4d ec             	mov    ecx,DWORD PTR [rbp-0x14]
     d73:	be 00 40 02 00       	mov    esi,0x24000
     d78:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     d7c:	48 89 d0             	mov    rax,rdx
     d7f:	48 c1 e0 03          	shl    rax,0x3
     d83:	48 29 d0             	sub    rax,rdx
     d86:	48 c1 e0 03          	shl    rax,0x3
     d8a:	48 01 f0             	add    rax,rsi
     d8d:	48 83 c0 10          	add    rax,0x10
     d91:	f0 48 29 08          	lock sub QWORD PTR [rax],rcx
						if (pg_ct && !r2) /* skip scrub for now */
     d95:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     d99:	74 0a                	je     da5 <mm_alloc_pm+0x120>
     d9b:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
     d9f:	0f 84 cb 00 00 00    	je     e70 <mm_alloc_pm+0x1eb>
								continue;
						else if (!pg_ct)
     da5:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     da9:	0f 84 f0 00 00 00    	je     e9f <mm_alloc_pm+0x21a>
								goto done;
				}

				/* check for reclaimable */
				if (r2 && fmm[i].reclaimable_pages) {
     daf:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
     db3:	0f 84 b8 00 00 00    	je     e71 <mm_alloc_pm+0x1ec>
     db9:	b9 00 40 02 00       	mov    ecx,0x24000
     dbe:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     dc2:	48 89 d0             	mov    rax,rdx
     dc5:	48 c1 e0 03          	shl    rax,0x3
     dc9:	48 29 d0             	sub    rax,rdx
     dcc:	48 c1 e0 03          	shl    rax,0x3
     dd0:	48 01 c8             	add    rax,rcx
     dd3:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     dd7:	48 85 c0             	test   rax,rax
     dda:	0f 84 91 00 00 00    	je     e71 <mm_alloc_pm+0x1ec>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 0, pr + pr_o,
     de0:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     de3:	8b 55 d8             	mov    edx,DWORD PTR [rbp-0x28]
     de6:	89 d6                	mov    esi,edx
     de8:	29 c6                	sub    esi,eax
     dea:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     ded:	89 c0                	mov    eax,eax
     def:	48 c1 e0 04          	shl    rax,0x4
     df3:	48 89 c2             	mov    rdx,rax
     df6:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     dfa:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
     dfe:	bf 00 40 02 00       	mov    edi,0x24000
     e03:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     e07:	48 89 d0             	mov    rax,rdx
     e0a:	48 c1 e0 03          	shl    rax,0x3
     e0e:	48 29 d0             	sub    rax,rdx
     e11:	48 c1 e0 03          	shl    rax,0x3
     e15:	48 01 c7             	add    rdi,rax
     e18:	48 8d 55 e4          	lea    rdx,[rbp-0x1c]
     e1c:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     e1f:	49 89 d1             	mov    r9,rdx
     e22:	41 89 f0             	mov    r8d,esi
     e25:	ba 00 00 00 00       	mov    edx,0x0
     e2a:	89 c6                	mov    esi,eax
     e2c:	e8 00 00 00 00       	call   e31 <mm_alloc_pm+0x1ac>
     e31:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
     e34:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     e37:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
						pg_ct -= rv2;
     e3a:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     e3d:	29 45 dc             	sub    DWORD PTR [rbp-0x24],eax
						__sync_sub_and_fetch(&fmm[i].reclaimable_pages, rv2);
     e40:	8b 4d e8             	mov    ecx,DWORD PTR [rbp-0x18]
     e43:	be 00 40 02 00       	mov    esi,0x24000
     e48:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     e4c:	48 89 d0             	mov    rax,rdx
     e4f:	48 c1 e0 03          	shl    rax,0x3
     e53:	48 29 d0             	sub    rax,rdx
     e56:	48 c1 e0 03          	shl    rax,0x3
     e5a:	48 01 f0             	add    rax,rsi
     e5d:	48 83 c0 18          	add    rax,0x18
     e61:	f0 48 29 08          	lock sub QWORD PTR [rax],rcx
						if (!pg_ct)
     e65:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     e69:	74 37                	je     ea2 <mm_alloc_pm+0x21d>
     e6b:	eb 04                	jmp    e71 <mm_alloc_pm+0x1ec>
						continue;
     e6d:	90                   	nop
     e6e:	eb 01                	jmp    e71 <mm_alloc_pm+0x1ec>
								continue;
     e70:	90                   	nop
		for (i = fm_begin; i < fm_ofs; i++) {
     e71:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     e76:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # e7d <mm_alloc_pm+0x1f8>
     e7d:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
     e81:	0f 82 35 fe ff ff    	jb     cbc <mm_alloc_pm+0x37>
								goto done;
				}
		}

		/* scrub enabled */
		if (pg_ct && !r2) {
     e87:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     e8b:	74 18                	je     ea5 <mm_alloc_pm+0x220>
     e8d:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
     e91:	75 12                	jne    ea5 <mm_alloc_pm+0x220>
				r2 = 1;
     e93:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [rbp-0x10],0x1
				goto retry;
     e9a:	e9 0d fe ff ff       	jmp    cac <mm_alloc_pm+0x27>
								goto done;
     e9f:	90                   	nop
     ea0:	eb 04                	jmp    ea6 <mm_alloc_pm+0x221>
								goto done;
     ea2:	90                   	nop
     ea3:	eb 01                	jmp    ea6 <mm_alloc_pm+0x221>
		}

done:
     ea5:	90                   	nop
		if (!rv) { /* OOM */
     ea6:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
     eaa:	75 03                	jne    eaf <mm_alloc_pm+0x22a>
				while (1);
     eac:	90                   	nop
     ead:	eb fd                	jmp    eac <mm_alloc_pm+0x227>
				die("OOM");
		}

		/* null-terminate */
		if (pr_o < pr_ct) {
     eaf:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     eb2:	3b 45 d8             	cmp    eax,DWORD PTR [rbp-0x28]
     eb5:	73 35                	jae    eec <mm_alloc_pm+0x267>
				pr[pr_o].base = 0;
     eb7:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     eba:	89 c0                	mov    eax,eax
     ebc:	48 c1 e0 04          	shl    rax,0x4
     ec0:	48 89 c2             	mov    rdx,rax
     ec3:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     ec7:	48 01 d0             	add    rax,rdx
     eca:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				pr[pr_o].count = 0;
     ed1:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     ed4:	89 c0                	mov    eax,eax
     ed6:	48 c1 e0 04          	shl    rax,0x4
     eda:	48 89 c2             	mov    rdx,rax
     edd:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     ee1:	48 01 d0             	add    rax,rdx
     ee4:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		}
		return rv;
     eec:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     eef:	c9                   	leave
     ef0:	c3                   	ret

0000000000000ef1 <mm_alloc_pm_flg>:

/* rcp: higher-levels<=>Exists; pmu: higher-levels: completely used */
uint32_t mm_alloc_pm_flg(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct, int flg)
{
     ef1:	55                   	push   rbp
     ef2:	48 89 e5             	mov    rbp,rsp
     ef5:	48 83 ec 20          	sub    rsp,0x20
     ef9:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
     efc:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     f00:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
     f03:	89 4d ec             	mov    DWORD PTR [rbp-0x14],ecx
		die("not implemented\n");
     f06:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f0d:	bf 0c 00 00 00       	mov    edi,0xc
     f12:	b8 00 00 00 00       	mov    eax,0x0
     f17:	e8 00 00 00 00       	call   f1c <mm_alloc_pm_flg+0x2b>
     f1c:	b8 00 00 00 00       	mov    eax,0x0
     f21:	e8 00 00 00 00       	call   f26 <mm_alloc_pm_flg+0x35>
     f26:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f2d:	e8 00 00 00 00       	call   f32 <mm_alloc_pm_flg+0x41>
     f32:	fa                   	cli
     f33:	f4                   	hlt
     f34:	eb fd                	jmp    f33 <mm_alloc_pm_flg+0x42>

0000000000000f36 <psr.0>:

void pmue_set_range(struct pmue* e, uint16_t start, uint16_t end, int unset, int is_rcp)
{
		/* we also have to consider the values at the fringes,
		 * as start & end don't have to be perfectly aligned. */
		void psr(uint32_t* lv, uint32_t* pr, uint16_t div, uint16_t div2) {
     f36:	55                   	push   rbp
     f37:	48 89 e5             	mov    rbp,rsp
     f3a:	48 83 ec 50          	sub    rsp,0x50
     f3e:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     f42:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
     f46:	89 c8                	mov    eax,ecx
     f48:	66 89 55 bc          	mov    WORD PTR [rbp-0x44],dx
     f4c:	66 89 45 b8          	mov    WORD PTR [rbp-0x48],ax
     f50:	4c 89 d6             	mov    rsi,r10
     f53:	4c 89 55 b0          	mov    QWORD PTR [rbp-0x50],r10
				uint16_t i, j;
				if (pr) { /* align start & end to boundaries and set fringe values */
     f57:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
     f5c:	74 30                	je     f8e <psr.0+0x58>
						die("fringes!\n"); /* TODO: fix it */
     f5e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f65:	bf 0c 00 00 00       	mov    edi,0xc
     f6a:	b8 00 00 00 00       	mov    eax,0x0
     f6f:	e8 00 00 00 00       	call   f74 <psr.0+0x3e>
     f74:	b8 00 00 00 00       	mov    eax,0x0
     f79:	e8 00 00 00 00       	call   f7e <psr.0+0x48>
     f7e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f85:	e8 00 00 00 00       	call   f8a <psr.0+0x54>
     f8a:	fa                   	cli
     f8b:	f4                   	hlt
     f8c:	eb fd                	jmp    f8b <psr.0+0x55>
				}
				for (i = start / div; i <= end / div; i++) {
     f8e:	0f b7 46 06          	movzx  eax,WORD PTR [rsi+0x6]
     f92:	ba 00 00 00 00       	mov    edx,0x0
     f97:	66 f7 75 bc          	div    WORD PTR [rbp-0x44]
     f9b:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
     f9f:	e9 d2 02 00 00       	jmp    1276 <psr.0+0x340>
						int lwr = (i * div >= start); /* starts at bit0 */
     fa4:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
     fa8:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
     fac:	0f af d0             	imul   edx,eax
     faf:	0f b7 46 06          	movzx  eax,WORD PTR [rsi+0x6]
     fb3:	0f b7 c0             	movzx  eax,ax
     fb6:	39 c2                	cmp    edx,eax
     fb8:	0f 9d c0             	setge  al
     fbb:	0f b6 c0             	movzx  eax,al
     fbe:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
						int hgr = (end - i * div >= div); /* goes until bit 31 */
     fc1:	0f b7 46 04          	movzx  eax,WORD PTR [rsi+0x4]
     fc5:	0f b7 c8             	movzx  ecx,ax
     fc8:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
     fcc:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
     fd0:	0f af c2             	imul   eax,edx
     fd3:	29 c1                	sub    ecx,eax
     fd5:	89 ca                	mov    edx,ecx
     fd7:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
     fdb:	39 c2                	cmp    edx,eax
     fdd:	0f 9d c0             	setge  al
     fe0:	0f b6 c0             	movzx  eax,al
     fe3:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
						if (lwr && hgr) {
     fe6:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
     fea:	74 32                	je     101e <psr.0+0xe8>
     fec:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
     ff0:	74 2c                	je     101e <psr.0+0xe8>
								lv[i] = unset ? 0 : 0xffffffff;
     ff2:	8b 06                	mov    eax,DWORD PTR [rsi]
     ff4:	85 c0                	test   eax,eax
     ff6:	74 07                	je     fff <psr.0+0xc9>
     ff8:	b9 00 00 00 00       	mov    ecx,0x0
     ffd:	eb 05                	jmp    1004 <psr.0+0xce>
     fff:	b9 ff ff ff ff       	mov    ecx,0xffffffff
    1004:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1008:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1010:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1014:	48 01 d0             	add    rax,rdx
    1017:	89 08                	mov    DWORD PTR [rax],ecx
								continue;
    1019:	e9 4d 02 00 00       	jmp    126b <psr.0+0x335>
						} else if (lwr) {
    101e:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    1022:	0f 84 ac 00 00 00    	je     10d4 <psr.0+0x19e>
								uint8_t bit = (end - i * div) * 32 / div + 1;
    1028:	0f b7 46 04          	movzx  eax,WORD PTR [rsi+0x4]
    102c:	0f b7 c8             	movzx  ecx,ax
    102f:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    1033:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    1037:	0f af c2             	imul   eax,edx
    103a:	29 c1                	sub    ecx,eax
    103c:	89 ca                	mov    edx,ecx
    103e:	89 d0                	mov    eax,edx
    1040:	c1 e0 05             	shl    eax,0x5
    1043:	0f b7 7d bc          	movzx  edi,WORD PTR [rbp-0x44]
    1047:	99                   	cdq
    1048:	f7 ff                	idiv   edi
    104a:	83 c0 01             	add    eax,0x1
    104d:	88 45 db             	mov    BYTE PTR [rbp-0x25],al
								uint32_t mask = (1 << bit) - 1;
    1050:	0f b6 45 db          	movzx  eax,BYTE PTR [rbp-0x25]
    1054:	ba 01 00 00 00       	mov    edx,0x1
    1059:	89 c1                	mov    ecx,eax
    105b:	d3 e2                	shl    edx,cl
    105d:	89 d0                	mov    eax,edx
    105f:	83 e8 01             	sub    eax,0x1
    1062:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
								lv[i] &= ~mask;
    1065:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1069:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1071:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1075:	48 01 d0             	add    rax,rdx
    1078:	8b 10                	mov    edx,DWORD PTR [rax]
    107a:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    107d:	f7 d0                	not    eax
    107f:	89 c1                	mov    ecx,eax
    1081:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1085:	48 8d 3c 85 00 00 00 00 	lea    rdi,[rax*4+0x0]
    108d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1091:	48 01 f8             	add    rax,rdi
    1094:	21 ca                	and    edx,ecx
    1096:	89 10                	mov    DWORD PTR [rax],edx
								if (!unset)
    1098:	8b 06                	mov    eax,DWORD PTR [rsi]
    109a:	85 c0                	test   eax,eax
    109c:	0f 85 c9 01 00 00    	jne    126b <psr.0+0x335>
										lv[i] |= mask;
    10a2:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    10a6:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    10ae:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10b2:	48 01 d0             	add    rax,rdx
    10b5:	8b 00                	mov    eax,DWORD PTR [rax]
    10b7:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    10bb:	48 8d 0c 95 00 00 00 00 	lea    rcx,[rdx*4+0x0]
    10c3:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    10c7:	48 01 ca             	add    rdx,rcx
    10ca:	0b 45 d4             	or     eax,DWORD PTR [rbp-0x2c]
    10cd:	89 02                	mov    DWORD PTR [rdx],eax
    10cf:	e9 97 01 00 00       	jmp    126b <psr.0+0x335>
						} else if (hgr) {
    10d4:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    10d8:	0f 84 a8 00 00 00    	je     1186 <psr.0+0x250>
								uint8_t bit = (start - i * div) * 32 / div;
    10de:	0f b7 46 06          	movzx  eax,WORD PTR [rsi+0x6]
    10e2:	0f b7 c8             	movzx  ecx,ax
    10e5:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    10e9:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    10ed:	0f af c2             	imul   eax,edx
    10f0:	29 c1                	sub    ecx,eax
    10f2:	89 ca                	mov    edx,ecx
    10f4:	89 d0                	mov    eax,edx
    10f6:	c1 e0 05             	shl    eax,0x5
    10f9:	0f b7 7d bc          	movzx  edi,WORD PTR [rbp-0x44]
    10fd:	99                   	cdq
    10fe:	f7 ff                	idiv   edi
    1100:	88 45 e3             	mov    BYTE PTR [rbp-0x1d],al
								uint32_t mask = ~((1 << bit) - 1);
    1103:	0f b6 45 e3          	movzx  eax,BYTE PTR [rbp-0x1d]
    1107:	ba 01 00 00 00       	mov    edx,0x1
    110c:	89 c1                	mov    ecx,eax
    110e:	d3 e2                	shl    edx,cl
    1110:	89 d0                	mov    eax,edx
    1112:	f7 d8                	neg    eax
    1114:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
								lv[i] &= ~mask;
    1117:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    111b:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1123:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1127:	48 01 d0             	add    rax,rdx
    112a:	8b 10                	mov    edx,DWORD PTR [rax]
    112c:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    112f:	f7 d0                	not    eax
    1131:	89 c1                	mov    ecx,eax
    1133:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1137:	48 8d 3c 85 00 00 00 00 	lea    rdi,[rax*4+0x0]
    113f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1143:	48 01 f8             	add    rax,rdi
    1146:	21 ca                	and    edx,ecx
    1148:	89 10                	mov    DWORD PTR [rax],edx
								if (!unset)
    114a:	8b 06                	mov    eax,DWORD PTR [rsi]
    114c:	85 c0                	test   eax,eax
    114e:	0f 85 17 01 00 00    	jne    126b <psr.0+0x335>
										lv[i] |= mask;
    1154:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1158:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1160:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1164:	48 01 d0             	add    rax,rdx
    1167:	8b 00                	mov    eax,DWORD PTR [rax]
    1169:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    116d:	48 8d 0c 95 00 00 00 00 	lea    rcx,[rdx*4+0x0]
    1175:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1179:	48 01 ca             	add    rdx,rcx
    117c:	0b 45 dc             	or     eax,DWORD PTR [rbp-0x24]
    117f:	89 02                	mov    DWORD PTR [rdx],eax
    1181:	e9 e5 00 00 00       	jmp    126b <psr.0+0x335>
						} else {
								/* in-between */
								uint8_t b1 = (end - i * div) * 32 / div + 1;
    1186:	0f b7 46 04          	movzx  eax,WORD PTR [rsi+0x4]
    118a:	0f b7 c8             	movzx  ecx,ax
    118d:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    1191:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    1195:	0f af c2             	imul   eax,edx
    1198:	29 c1                	sub    ecx,eax
    119a:	89 ca                	mov    edx,ecx
    119c:	89 d0                	mov    eax,edx
    119e:	c1 e0 05             	shl    eax,0x5
    11a1:	0f b7 7d bc          	movzx  edi,WORD PTR [rbp-0x44]
    11a5:	99                   	cdq
    11a6:	f7 ff                	idiv   edi
    11a8:	83 c0 01             	add    eax,0x1
    11ab:	88 45 f3             	mov    BYTE PTR [rbp-0xd],al
								uint8_t b2 = (start - i * div) * 32 / div;
    11ae:	0f b7 46 06          	movzx  eax,WORD PTR [rsi+0x6]
    11b2:	0f b7 c8             	movzx  ecx,ax
    11b5:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    11b9:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    11bd:	0f af c2             	imul   eax,edx
    11c0:	29 c1                	sub    ecx,eax
    11c2:	89 ca                	mov    edx,ecx
    11c4:	89 d0                	mov    eax,edx
    11c6:	c1 e0 05             	shl    eax,0x5
    11c9:	0f b7 7d bc          	movzx  edi,WORD PTR [rbp-0x44]
    11cd:	99                   	cdq
    11ce:	f7 ff                	idiv   edi
    11d0:	88 45 f2             	mov    BYTE PTR [rbp-0xe],al
								uint32_t m1 = (1 << b1) - 1;
    11d3:	0f b6 45 f3          	movzx  eax,BYTE PTR [rbp-0xd]
    11d7:	ba 01 00 00 00       	mov    edx,0x1
    11dc:	89 c1                	mov    ecx,eax
    11de:	d3 e2                	shl    edx,cl
    11e0:	89 d0                	mov    eax,edx
    11e2:	83 e8 01             	sub    eax,0x1
    11e5:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
								uint32_t m2 = ~((1 << b2) - 1);
    11e8:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe]
    11ec:	ba 01 00 00 00       	mov    edx,0x1
    11f1:	89 c1                	mov    ecx,eax
    11f3:	d3 e2                	shl    edx,cl
    11f5:	89 d0                	mov    eax,edx
    11f7:	f7 d8                	neg    eax
    11f9:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
								uint32_t mask = m1 & m2;
    11fc:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    11ff:	23 45 e8             	and    eax,DWORD PTR [rbp-0x18]
    1202:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
								lv[i] &= ~mask;
    1205:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1209:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1211:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1215:	48 01 d0             	add    rax,rdx
    1218:	8b 10                	mov    edx,DWORD PTR [rax]
    121a:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    121d:	f7 d0                	not    eax
    121f:	89 c1                	mov    ecx,eax
    1221:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1225:	48 8d 3c 85 00 00 00 00 	lea    rdi,[rax*4+0x0]
    122d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1231:	48 01 f8             	add    rax,rdi
    1234:	21 ca                	and    edx,ecx
    1236:	89 10                	mov    DWORD PTR [rax],edx
								if (!unset)
    1238:	8b 06                	mov    eax,DWORD PTR [rsi]
    123a:	85 c0                	test   eax,eax
    123c:	75 2d                	jne    126b <psr.0+0x335>
										lv[i] |= mask;
    123e:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1242:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    124a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    124e:	48 01 d0             	add    rax,rdx
    1251:	8b 00                	mov    eax,DWORD PTR [rax]
    1253:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    1257:	48 8d 0c 95 00 00 00 00 	lea    rcx,[rdx*4+0x0]
    125f:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1263:	48 01 ca             	add    rdx,rcx
    1266:	0b 45 e4             	or     eax,DWORD PTR [rbp-0x1c]
    1269:	89 02                	mov    DWORD PTR [rdx],eax
				for (i = start / div; i <= end / div; i++) {
    126b:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    126f:	83 c0 01             	add    eax,0x1
    1272:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
    1276:	0f b7 46 04          	movzx  eax,WORD PTR [rsi+0x4]
    127a:	ba 00 00 00 00       	mov    edx,0x0
    127f:	66 f7 75 bc          	div    WORD PTR [rbp-0x44]
    1283:	66 3b 45 fe          	cmp    ax,WORD PTR [rbp-0x2]
    1287:	0f 83 17 fd ff ff    	jae    fa4 <psr.0+0x6e>
						}
				}
		}
    128d:	90                   	nop
    128e:	90                   	nop
    128f:	c9                   	leave
    1290:	c3                   	ret

0000000000001291 <pmue_set_range>:
{
    1291:	55                   	push   rbp
    1292:	48 89 e5             	mov    rbp,rsp
    1295:	48 83 ec 30          	sub    rsp,0x30
    1299:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    129d:	89 d0                	mov    eax,edx
    129f:	89 4d dc             	mov    DWORD PTR [rbp-0x24],ecx
    12a2:	44 89 45 d8          	mov    DWORD PTR [rbp-0x28],r8d
    12a6:	89 f2                	mov    edx,esi
    12a8:	66 89 55 e4          	mov    WORD PTR [rbp-0x1c],dx
    12ac:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
void pmue_set_range(struct pmue* e, uint16_t start, uint16_t end, int unset, int is_rcp)
    12b0:	48 8d 45 10          	lea    rax,[rbp+0x10]
    12b4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    12b8:	0f b7 45 e4          	movzx  eax,WORD PTR [rbp-0x1c]
    12bc:	66 89 45 f6          	mov    WORD PTR [rbp-0xa],ax
    12c0:	0f b7 45 e0          	movzx  eax,WORD PTR [rbp-0x20]
    12c4:	66 89 45 f4          	mov    WORD PTR [rbp-0xc],ax
    12c8:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    12cb:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
		psr(e->lvl0, NULL, 32, 0);
    12ce:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    12d2:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    12d6:	49 89 d2             	mov    r10,rdx
    12d9:	b9 00 00 00 00       	mov    ecx,0x0
    12de:	ba 20 00 00 00       	mov    edx,0x20
    12e3:	be 00 00 00 00       	mov    esi,0x0
    12e8:	48 89 c7             	mov    rdi,rax
    12eb:	e8 46 fc ff ff       	call   f36 <psr.0>
		if (!is_rcp)
    12f0:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    12f4:	75 28                	jne    131e <pmue_set_range+0x8d>
				psr(e->lvl1, e->lvl0, 64, 32);
    12f6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    12fa:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    12fe:	48 8d ba 00 02 00 00 	lea    rdi,[rdx+0x200]
    1305:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    1309:	49 89 d2             	mov    r10,rdx
    130c:	b9 20 00 00 00       	mov    ecx,0x20
    1311:	ba 40 00 00 00       	mov    edx,0x40
    1316:	48 89 c6             	mov    rsi,rax
    1319:	e8 18 fc ff ff       	call   f36 <psr.0>
		psr(e->lvl2, is_rcp ? e->lvl0 : e->lvl1, 128, is_rcp ? 32 : 64);
    131e:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    1322:	74 07                	je     132b <pmue_set_range+0x9a>
    1324:	b9 20 00 00 00       	mov    ecx,0x20
    1329:	eb 05                	jmp    1330 <pmue_set_range+0x9f>
    132b:	b9 40 00 00 00       	mov    ecx,0x40
    1330:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    1334:	74 06                	je     133c <pmue_set_range+0xab>
    1336:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    133a:	eb 0a                	jmp    1346 <pmue_set_range+0xb5>
    133c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1340:	48 05 00 02 00 00    	add    rax,0x200
    1346:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    134a:	48 8d ba 00 03 00 00 	lea    rdi,[rdx+0x300]
    1351:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    1355:	49 89 d2             	mov    r10,rdx
    1358:	ba 80 00 00 00       	mov    edx,0x80
    135d:	48 89 c6             	mov    rsi,rax
    1360:	e8 d1 fb ff ff       	call   f36 <psr.0>
		if (!is_rcp) {
    1365:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    1369:	0f 85 b8 00 00 00    	jne    1427 <pmue_set_range+0x196>
				psr(e->lvl3, e->lvl2, 256, 128);
    136f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1373:	48 8d b0 00 03 00 00 	lea    rsi,[rax+0x300]
    137a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    137e:	48 05 80 03 00 00    	add    rax,0x380
    1384:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    1388:	49 89 d2             	mov    r10,rdx
    138b:	b9 80 00 00 00       	mov    ecx,0x80
    1390:	ba 00 01 00 00       	mov    edx,0x100
    1395:	48 89 c7             	mov    rdi,rax
    1398:	e8 99 fb ff ff       	call   f36 <psr.0>
				psr(e->lvl4, e->lvl3, 512, 256);
    139d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13a1:	48 8d b0 80 03 00 00 	lea    rsi,[rax+0x380]
    13a8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13ac:	48 05 c0 03 00 00    	add    rax,0x3c0
    13b2:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    13b6:	49 89 d2             	mov    r10,rdx
    13b9:	b9 00 01 00 00       	mov    ecx,0x100
    13be:	ba 00 02 00 00       	mov    edx,0x200
    13c3:	48 89 c7             	mov    rdi,rax
    13c6:	e8 6b fb ff ff       	call   f36 <psr.0>
				psr(e->lvl5, e->lvl4, 1024, 512);
    13cb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13cf:	48 8d b0 c0 03 00 00 	lea    rsi,[rax+0x3c0]
    13d6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13da:	48 05 e0 03 00 00    	add    rax,0x3e0
    13e0:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    13e4:	49 89 d2             	mov    r10,rdx
    13e7:	b9 00 02 00 00       	mov    ecx,0x200
    13ec:	ba 00 04 00 00       	mov    edx,0x400
    13f1:	48 89 c7             	mov    rdi,rax
    13f4:	e8 3d fb ff ff       	call   f36 <psr.0>
				psr(e->lvl6, e->lvl5, 2048, 1024);
    13f9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13fd:	48 8d b0 e0 03 00 00 	lea    rsi,[rax+0x3e0]
    1404:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1408:	48 05 f0 03 00 00    	add    rax,0x3f0
    140e:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    1412:	49 89 d2             	mov    r10,rdx
    1415:	b9 00 04 00 00       	mov    ecx,0x400
    141a:	ba 00 08 00 00       	mov    edx,0x800
    141f:	48 89 c7             	mov    rdi,rax
    1422:	e8 0f fb ff ff       	call   f36 <psr.0>
		}
		psr(&e->lvl7, is_rcp ? e->lvl2 : e->lvl6, 4096, is_rcp ? 128 : 2048);
    1427:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    142b:	74 07                	je     1434 <pmue_set_range+0x1a3>
    142d:	b9 80 00 00 00       	mov    ecx,0x80
    1432:	eb 05                	jmp    1439 <pmue_set_range+0x1a8>
    1434:	b9 00 08 00 00       	mov    ecx,0x800
    1439:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    143d:	74 0c                	je     144b <pmue_set_range+0x1ba>
    143f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1443:	48 05 00 03 00 00    	add    rax,0x300
    1449:	eb 0a                	jmp    1455 <pmue_set_range+0x1c4>
    144b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    144f:	48 05 f0 03 00 00    	add    rax,0x3f0
    1455:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1459:	48 8d ba f8 03 00 00 	lea    rdi,[rdx+0x3f8]
    1460:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    1464:	49 89 d2             	mov    r10,rdx
    1467:	ba 00 10 00 00       	mov    edx,0x1000
    146c:	48 89 c6             	mov    rsi,rax
    146f:	e8 c2 fa ff ff       	call   f36 <psr.0>
}
    1474:	90                   	nop
    1475:	c9                   	leave
    1476:	c3                   	ret

0000000000001477 <pmu_set_range>:

/* rcp: 7,2,0 set if any below; pmu all, set if all below are used */
void pmu_set_range(struct pmu* pm, uint16_t start, uint16_t end, int unset, int is_rcp)
{
    1477:	55                   	push   rbp
    1478:	48 89 e5             	mov    rbp,rsp
    147b:	48 83 ec 40          	sub    rsp,0x40
    147f:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1483:	89 d0                	mov    eax,edx
    1485:	89 4d cc             	mov    DWORD PTR [rbp-0x34],ecx
    1488:	44 89 45 c8          	mov    DWORD PTR [rbp-0x38],r8d
    148c:	89 f2                	mov    edx,esi
    148e:	66 89 55 d4          	mov    WORD PTR [rbp-0x2c],dx
    1492:	66 89 45 d0          	mov    WORD PTR [rbp-0x30],ax
		struct pmue* e; uint16_t fc = 0;
    1496:	66 c7 45 fe 00 00    	mov    WORD PTR [rbp-0x2],0x0
		/* we have to lock for keeping higher levels consistent 
		 * else we could do without as we own the ranges exclusively. */

redo:
		/* lock is 64 bit wide 4x16 (2 lvl7 bits per bit) */
		for (uint16_t i = start / 256; i <= end / 256; i++) {
    149c:	0f b7 45 d4          	movzx  eax,WORD PTR [rbp-0x2c]
    14a0:	66 c1 e8 08          	shr    ax,0x8
    14a4:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
    14a8:	e9 2b 01 00 00       	jmp    15d8 <pmu_set_range+0x161>
				uint16_t o = i * 256, p1, p2;
    14ad:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    14b1:	c1 e0 08             	shl    eax,0x8
    14b4:	66 89 45 fa          	mov    WORD PTR [rbp-0x6],ax
				e = pm->entries + i / 16;
    14b8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    14bc:	48 8d 48 10          	lea    rcx,[rax+0x10]
    14c0:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    14c4:	66 c1 e8 04          	shr    ax,0x4
    14c8:	0f b7 d0             	movzx  edx,ax
    14cb:	48 89 d0             	mov    rax,rdx
    14ce:	48 c1 e0 08          	shl    rax,0x8
    14d2:	48 29 d0             	sub    rax,rdx
    14d5:	48 c1 e0 02          	shl    rax,0x2
    14d9:	48 01 c8             	add    rax,rcx
    14dc:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				/* first check if we can skip */
				if (is_rcp) {
    14e0:	83 7d c8 00          	cmp    DWORD PTR [rbp-0x38],0x0
    14e4:	74 2b                	je     1511 <pmu_set_range+0x9a>
						if (unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
    14e6:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    14ea:	74 4f                	je     153b <pmu_set_range+0xc4>
    14ec:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    14f0:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [rax+0x3f8]
    14f6:	0f b7 55 fc          	movzx  edx,WORD PTR [rbp-0x4]
    14fa:	83 e2 0f             	and    edx,0xf
    14fd:	be 03 00 00 00       	mov    esi,0x3
    1502:	89 d1                	mov    ecx,edx
    1504:	d3 e6                	shl    esi,cl
    1506:	89 f2                	mov    edx,esi
    1508:	39 d0                	cmp    eax,edx
    150a:	75 2f                	jne    153b <pmu_set_range+0xc4>
								continue; /* unsafe as lock was not
    150c:	e9 bc 00 00 00       	jmp    15cd <pmu_set_range+0x156>
						 * checked (could be set concurrently). But 
						 * this is not relevant as it'd be user error. */
				} else {
						if (!unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
    1511:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    1515:	75 24                	jne    153b <pmu_set_range+0xc4>
    1517:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    151b:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [rax+0x3f8]
    1521:	0f b7 55 fc          	movzx  edx,WORD PTR [rbp-0x4]
    1525:	83 e2 0f             	and    edx,0xf
    1528:	be 03 00 00 00       	mov    esi,0x3
    152d:	89 d1                	mov    ecx,edx
    152f:	d3 e6                	shl    esi,cl
    1531:	89 f2                	mov    edx,esi
    1533:	39 d0                	cmp    eax,edx
    1535:	0f 84 91 00 00 00    	je     15cc <pmu_set_range+0x155>
								continue; /* already all set */
				}

				/* then try to acquire the lock */
				asm goto("lock bts %0, %1\n"
					"jc %l2\n" : : "r" (2 * i),
    153b:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    153f:	8d 14 00             	lea    edx,[rax+rax*1]
				asm goto("lock bts %0, %1\n"
    1542:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1546:	f0 0f ab 10          	lock bts DWORD PTR [rax],edx
    154a:	72 73                	jb     15bf <pmu_set_range+0x148>
					"m" (*pm->locks) : "cc" : carry);
				/* calculate the range */
				p1 = max(o, start);
    154c:	0f b7 55 d4          	movzx  edx,WORD PTR [rbp-0x2c]
    1550:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
    1554:	66 39 c2             	cmp    dx,ax
    1557:	0f 43 c2             	cmovae eax,edx
    155a:	66 89 45 ee          	mov    WORD PTR [rbp-0x12],ax
				p2 = min(o + 256, end);
    155e:	0f b7 55 d0          	movzx  edx,WORD PTR [rbp-0x30]
    1562:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
    1566:	05 00 01 00 00       	add    eax,0x100
    156b:	39 c2                	cmp    edx,eax
    156d:	0f 4e c2             	cmovle eax,edx
    1570:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
				p1 -= (i / 4) * 4096;
    1574:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1578:	66 c1 e8 02          	shr    ax,0x2
    157c:	c1 e0 0c             	shl    eax,0xc
    157f:	66 29 45 ee          	sub    WORD PTR [rbp-0x12],ax
				p2 -= (i / 4) * 4096;
    1583:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1587:	66 c1 e8 02          	shr    ax,0x2
    158b:	c1 e0 0c             	shl    eax,0xc
    158e:	66 29 45 ec          	sub    WORD PTR [rbp-0x14],ax
				/* we now hold the lock so modify the acutal entry */
				pmue_set_range(e, p1, p2, unset, is_rcp);
    1592:	0f b7 55 ec          	movzx  edx,WORD PTR [rbp-0x14]
    1596:	0f b7 75 ee          	movzx  esi,WORD PTR [rbp-0x12]
    159a:	8b 7d c8             	mov    edi,DWORD PTR [rbp-0x38]
    159d:	8b 4d cc             	mov    ecx,DWORD PTR [rbp-0x34]
    15a0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    15a4:	41 89 f8             	mov    r8d,edi
    15a7:	48 89 c7             	mov    rdi,rax
    15aa:	e8 00 00 00 00       	call   15af <pmu_set_range+0x138>

				/* release it */
				asm("btr %0, %1\n" : : "r" (2 * i),
    15af:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    15b3:	8d 14 00             	lea    edx,[rax+rax*1]
    15b6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    15ba:	0f b3 10             	btr    DWORD PTR [rax],edx
					"m" (*pm->locks) : "cc");
				continue;
    15bd:	eb 0e                	jmp    15cd <pmu_set_range+0x156>

carry: 			/* lock failed */
				fc++; /* set failure count and continue (retry later) */
    15bf:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    15c3:	83 c0 01             	add    eax,0x1
    15c6:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
    15ca:	eb 01                	jmp    15cd <pmu_set_range+0x156>
								continue; /* already all set */
    15cc:	90                   	nop
		for (uint16_t i = start / 256; i <= end / 256; i++) {
    15cd:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    15d1:	83 c0 01             	add    eax,0x1
    15d4:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
    15d8:	0f b7 45 d0          	movzx  eax,WORD PTR [rbp-0x30]
    15dc:	66 c1 e8 08          	shr    ax,0x8
    15e0:	66 3b 45 fc          	cmp    ax,WORD PTR [rbp-0x4]
    15e4:	0f 83 c3 fe ff ff    	jae    14ad <pmu_set_range+0x36>
		}

		if (fc) { /* busy loop as these locks are held for ns */
    15ea:	66 83 7d fe 00       	cmp    WORD PTR [rbp-0x2],0x0
    15ef:	74 0b                	je     15fc <pmu_set_range+0x185>
				fc = 0;
    15f1:	66 c7 45 fe 00 00    	mov    WORD PTR [rbp-0x2],0x0
				goto redo;
    15f7:	e9 a0 fe ff ff       	jmp    149c <pmu_set_range+0x25>
		}
}
    15fc:	90                   	nop
    15fd:	c9                   	leave
    15fe:	c3                   	ret

00000000000015ff <mm_free_pm>:

void mm_free_pm(struct page_range* pr, uint32_t pr_ct)
{
    15ff:	55                   	push   rbp
    1600:	48 89 e5             	mov    rbp,rsp
    1603:	48 83 ec 60          	sub    rsp,0x60
    1607:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    160b:	89 75 a4             	mov    DWORD PTR [rbp-0x5c],esi
		for (uint32_t i = 0; i < pr_ct; i++) {
    160e:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    1615:	e9 61 01 00 00       	jmp    177b <mm_free_pm+0x17c>
				struct fme* fm; struct pmu* rc;
				uint64_t ofs, fp, lp;
				for (fm = fmm + fm_begin; fm < fmm + fm_ofs; fm++)
    161a:	b9 00 40 02 00       	mov    ecx,0x24000
    161f:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 1626 <mm_free_pm+0x27>
    1626:	48 89 d0             	mov    rax,rdx
    1629:	48 c1 e0 03          	shl    rax,0x3
    162d:	48 29 d0             	sub    rax,rdx
    1630:	48 c1 e0 03          	shl    rax,0x3
    1634:	48 01 c8             	add    rax,rcx
    1637:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    163b:	eb 36                	jmp    1673 <mm_free_pm+0x74>
						if (pr->base >= fm->base && pr->base < fm->base + fm->size)
    163d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1641:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1644:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1648:	48 8b 00             	mov    rax,QWORD PTR [rax]
    164b:	48 39 c2             	cmp    rdx,rax
    164e:	72 1e                	jb     166e <mm_free_pm+0x6f>
    1650:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1654:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1657:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    165b:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    165e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1662:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1666:	48 01 c8             	add    rax,rcx
    1669:	48 39 c2             	cmp    rdx,rax
    166c:	72 2a                	jb     1698 <mm_free_pm+0x99>
				for (fm = fmm + fm_begin; fm < fmm + fm_ofs; fm++)
    166e:	48 83 45 f0 38       	add    QWORD PTR [rbp-0x10],0x38
    1673:	b9 00 40 02 00       	mov    ecx,0x24000
    1678:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 167f <mm_free_pm+0x80>
    167f:	48 89 d0             	mov    rax,rdx
    1682:	48 c1 e0 03          	shl    rax,0x3
    1686:	48 29 d0             	sub    rax,rdx
    1689:	48 c1 e0 03          	shl    rax,0x3
    168d:	48 01 c8             	add    rax,rcx
    1690:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    1694:	72 a7                	jb     163d <mm_free_pm+0x3e>
    1696:	eb 01                	jmp    1699 <mm_free_pm+0x9a>
								break; /* just assume integrity */
    1698:	90                   	nop
				ofs = pr->base - fm->base;
    1699:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    169d:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    16a0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    16a4:	48 8b 00             	mov    rax,QWORD PTR [rax]
    16a7:	48 29 c2             	sub    rdx,rax
    16aa:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
				rc = (struct pmu*)fm->rcp;
    16ae:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    16b2:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    16b6:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				/* set first and last page */
				fp = ofs / 4096;
    16ba:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    16be:	48 c1 e8 0c          	shr    rax,0xc
    16c2:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				lp = fp + pr->count - 1;
    16c6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    16ca:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    16ce:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    16d2:	48 01 d0             	add    rax,rdx
    16d5:	48 83 e8 01          	sub    rax,0x1
    16d9:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax

				for (uint32_t idx = fp / 4096 / 4; idx <= lp / 4096 / 4; idx++) {
    16dd:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    16e1:	48 c1 e8 0e          	shr    rax,0xe
    16e5:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
    16e8:	eb 79                	jmp    1763 <mm_free_pm+0x164>
						uint16_t s, e; uint64_t o = idx * 4096 * 4;
    16ea:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    16ed:	c1 e0 0e             	shl    eax,0xe
    16f0:	89 c0                	mov    eax,eax
    16f2:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
						/* get the limits */
						s = (fp > o ? fp - o : 0);
    16f6:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    16fa:	48 39 45 c0          	cmp    QWORD PTR [rbp-0x40],rax
    16fe:	73 12                	jae    1712 <mm_free_pm+0x113>
    1700:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1704:	89 c2                	mov    edx,eax
    1706:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    170a:	89 c1                	mov    ecx,eax
    170c:	89 d0                	mov    eax,edx
    170e:	29 c8                	sub    eax,ecx
    1710:	eb 05                	jmp    1717 <mm_free_pm+0x118>
    1712:	b8 00 00 00 00       	mov    eax,0x0
    1717:	66 89 45 be          	mov    WORD PTR [rbp-0x42],ax
						e = max(lp - o, 4096 * 4 - 1);
    171b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    171f:	48 2b 45 c0          	sub    rax,QWORD PTR [rbp-0x40]
    1723:	ba ff 3f 00 00       	mov    edx,0x3fff
    1728:	48 39 d0             	cmp    rax,rdx
    172b:	48 0f 42 c2          	cmovb  rax,rdx
    172f:	66 89 45 bc          	mov    WORD PTR [rbp-0x44],ax
						/* set the rcp */
						pmu_set_range(&rc[idx], s, e, 0, 1);
    1733:	0f b7 55 bc          	movzx  edx,WORD PTR [rbp-0x44]
    1737:	0f b7 45 be          	movzx  eax,WORD PTR [rbp-0x42]
    173b:	8b 4d ec             	mov    ecx,DWORD PTR [rbp-0x14]
    173e:	48 89 ce             	mov    rsi,rcx
    1741:	48 c1 e6 0c          	shl    rsi,0xc
    1745:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
    1749:	48 8d 3c 0e          	lea    rdi,[rsi+rcx*1]
    174d:	41 b8 01 00 00 00    	mov    r8d,0x1
    1753:	b9 00 00 00 00       	mov    ecx,0x0
    1758:	89 c6                	mov    esi,eax
    175a:	e8 00 00 00 00       	call   175f <mm_free_pm+0x160>
				for (uint32_t idx = fp / 4096 / 4; idx <= lp / 4096 / 4; idx++) {
    175f:	83 45 ec 01          	add    DWORD PTR [rbp-0x14],0x1
    1763:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1766:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    176a:	48 c1 ea 0e          	shr    rdx,0xe
    176e:	48 39 c2             	cmp    rdx,rax
    1771:	0f 83 73 ff ff ff    	jae    16ea <mm_free_pm+0xeb>
		for (uint32_t i = 0; i < pr_ct; i++) {
    1777:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    177b:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    177e:	3b 45 a4             	cmp    eax,DWORD PTR [rbp-0x5c]
    1781:	0f 82 93 fe ff ff    	jb     161a <mm_free_pm+0x1b>
				}
		}
}
    1787:	90                   	nop
    1788:	90                   	nop
    1789:	c9                   	leave
    178a:	c3                   	ret

000000000000178b <mm_create_ctx>:
void *cur_pmu = VM_PMU_BASE, *cur_rcp = VM_RCP_BASE;
void* cur_percpu = VM_MM_PER_CPU_BASE;
struct mm mm_kernel; uint64_t pm_count = 0;

struct mm_cpu_ctx mm_create_ctx()
{
    178b:	55                   	push   rbp
    178c:	48 89 e5             	mov    rbp,rsp
    178f:	48 83 ec 10          	sub    rsp,0x10
		struct mm_cpu_ctx rv = {0};
    1793:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    179b:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		rv.cur_mm = &mm_kernel;
    17a3:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		rv.scrub_page = __sync_fetch_and_add(&cur_percpu, 4096);
    17ab:	b8 00 10 00 00       	mov    eax,0x1000
    17b0:	f0 48 0f c1 05 00 00 00 00 	lock xadd QWORD PTR [rip+0x0],rax        # 17b9 <mm_create_ctx+0x2e>
    17b9:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (cur_percpu >= VM_MM_PER_CPU_LIMIT) {
    17bd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17c4 <mm_create_ctx+0x39>
    17c4:	48 3d ff ff ff fb    	cmp    rax,0xfffffffffbffffff
    17ca:	76 30                	jbe    17fc <mm_create_ctx+0x71>
				die("Out of MM percpu context slots.\n");
    17cc:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    17d3:	bf 0c 00 00 00       	mov    edi,0xc
    17d8:	b8 00 00 00 00       	mov    eax,0x0
    17dd:	e8 00 00 00 00       	call   17e2 <mm_create_ctx+0x57>
    17e2:	b8 00 00 00 00       	mov    eax,0x0
    17e7:	e8 00 00 00 00       	call   17ec <mm_create_ctx+0x61>
    17ec:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    17f3:	e8 00 00 00 00       	call   17f8 <mm_create_ctx+0x6d>
    17f8:	fa                   	cli
    17f9:	f4                   	hlt
    17fa:	eb fd                	jmp    17f9 <mm_create_ctx+0x6e>
		}
		return rv;
    17fc:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1800:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
}
    1804:	c9                   	leave
    1805:	c3                   	ret

0000000000001806 <mm_fm_init>:
/* full mapping & init of high elements */
void mm_fm_init(struct fme* fm)
{
    1806:	55                   	push   rbp
    1807:	48 89 e5             	mov    rbp,rsp
    180a:	48 83 ec 70          	sub    rsp,0x70
    180e:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
		uint64_t b = fm->base - 2 * fm->ec * 4096, b1;
    1812:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1816:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1819:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    181d:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1821:	48 c1 e0 0d          	shl    rax,0xd
    1825:	48 89 c2             	mov    rdx,rax
    1828:	48 89 c8             	mov    rax,rcx
    182b:	48 29 d0             	sub    rax,rdx
    182e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		uint64_t ec2 = (uint64_t)fm->ec; b1 = b + fm->ec * 4096;
    1832:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1836:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    183a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    183e:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1842:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1846:	48 c1 e0 0c          	shl    rax,0xc
    184a:	48 89 c2             	mov    rdx,rax
    184d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1851:	48 01 d0             	add    rax,rdx
    1854:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		struct pmu *p, *r; struct page_range pr; uint16_t rec;
		uint32_t lst = 0;
    1858:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [rbp-0x1c],0x0

		/* get the limit */
		rec = (fm->size / 4096) % 16384;
    185f:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1863:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1867:	48 c1 e8 0c          	shr    rax,0xc
    186b:	66 25 ff 3f          	and    ax,0x3fff
    186f:	66 89 45 ca          	mov    WORD PTR [rbp-0x36],ax
		if (rec)
    1873:	66 83 7d ca 00       	cmp    WORD PTR [rbp-0x36],0x0
    1878:	74 0f                	je     1889 <mm_fm_init+0x83>
				lst = (fm->size / 4096) / 16384;
    187a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    187e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1882:	48 c1 e8 1a          	shr    rax,0x1a
    1886:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax

		/* before preemption -> no sync needed */
		fm->pmu = (uint64_t)cur_pmu;
    1889:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1890 <mm_fm_init+0x8a>
    1890:	48 89 c2             	mov    rdx,rax
    1893:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1897:	48 89 50 28          	mov    QWORD PTR [rax+0x28],rdx
		fm->rcp = (uint64_t)cur_rcp;
    189b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18a2 <mm_fm_init+0x9c>
    18a2:	48 89 c2             	mov    rdx,rax
    18a5:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    18a9:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		p = cur_pmu; r = cur_rcp;
    18ad:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18b4 <mm_fm_init+0xae>
    18b4:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    18b8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18bf <mm_fm_init+0xb9>
    18bf:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
		pm_count += fm->size;
    18c3:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    18c7:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    18cb:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18d2 <mm_fm_init+0xcc>
    18d2:	48 01 d0             	add    rax,rdx
    18d5:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 18dc <mm_fm_init+0xd6>
	
		/* cap sizes */
		if ((VM_PMU_LIMIT - cur_pmu < ec2 * 4096)
    18dc:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18e3 <mm_fm_init+0xdd>
    18e3:	48 c7 c2 00 00 00 fd 	mov    rdx,0xfffffffffd000000
    18ea:	48 29 c2             	sub    rdx,rax
    18ed:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    18f1:	48 c1 e0 0c          	shl    rax,0xc
    18f5:	48 39 c2             	cmp    rdx,rax
    18f8:	72 1e                	jb     1918 <mm_fm_init+0x112>
			|| (VM_RCP_LIMIT - cur_rcp < ec2 * 4096)) {
    18fa:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1901 <mm_fm_init+0xfb>
    1901:	48 c7 c2 00 00 00 fe 	mov    rdx,0xfffffffffe000000
    1908:	48 29 c2             	sub    rdx,rax
    190b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    190f:	48 c1 e0 0c          	shl    rax,0xc
    1913:	48 39 c2             	cmp    rdx,rax
    1916:	73 71                	jae    1989 <mm_fm_init+0x183>
				/* we should cap and inform the user */
				ec2 = (VM_PMU_LIMIT - cur_pmu) / 4096; /* only on PMUs as LIMITS are identical*/
    1918:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 191f <mm_fm_init+0x119>
    191f:	48 c7 c2 00 00 00 fd 	mov    rdx,0xfffffffffd000000
    1926:	48 29 c2             	sub    rdx,rax
    1929:	48 89 d0             	mov    rax,rdx
    192c:	48 8d 90 ff 0f 00 00 	lea    rdx,[rax+0xfff]
    1933:	48 85 c0             	test   rax,rax
    1936:	48 0f 48 c2          	cmovs  rax,rdx
    193a:	48 c1 f8 0c          	sar    rax,0xc
    193e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
								fm->ec - ec2, (fm->ec - ec2) * 64);
    1942:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1946:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    194a:	48 2b 45 e8          	sub    rax,QWORD PTR [rbp-0x18]
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
    194e:	48 c1 e0 06          	shl    rax,0x6
    1952:	48 89 c2             	mov    rdx,rax
								fm->ec - ec2, (fm->ec - ec2) * 64);
    1955:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1959:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
    195d:	48 2b 45 e8          	sub    rax,QWORD PTR [rbp-0x18]
    1961:	48 89 d1             	mov    rcx,rdx
    1964:	48 89 c2             	mov    rdx,rax
    1967:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    196e:	bf 0e 00 00 00       	mov    edi,0xe
    1973:	b8 00 00 00 00       	mov    eax,0x0
    1978:	e8 00 00 00 00       	call   197d <mm_fm_init+0x177>
				fm->ec = ec2;
    197d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1981:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1985:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
		}
		/* and advance */
		cur_pmu += ec2 * 4096;
    1989:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1990 <mm_fm_init+0x18a>
    1990:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1994:	48 c1 e2 0c          	shl    rdx,0xc
    1998:	48 01 d0             	add    rax,rdx
    199b:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 19a2 <mm_fm_init+0x19c>
		cur_rcp += ec2 * 4096;
    19a2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 19a9 <mm_fm_init+0x1a3>
    19a9:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    19ad:	48 c1 e2 0c          	shl    rdx,0xc
    19b1:	48 01 d0             	add    rax,rdx
    19b4:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 19bb <mm_fm_init+0x1b5>

		/* skip completely if neccessary */
		if (!ec2)
    19bb:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    19c0:	0f 84 61 01 00 00    	je     1b27 <mm_fm_init+0x321>
				return;

		/* map & init the pmus */
		pr.base = b;
    19c6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19ca:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
		pr.count = ec2;
    19ce:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    19d2:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		mm_map(&mm_kernel, p, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
    19d6:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
    19da:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    19de:	41 b8 0c 00 00 00    	mov    r8d,0xc
    19e4:	b9 01 00 00 00       	mov    ecx,0x1
    19e9:	48 89 c6             	mov    rsi,rax
    19ec:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    19f3:	e8 00 00 00 00       	call   19f8 <mm_fm_init+0x1f2>
		pr.base = b1;
    19f8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    19fc:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
		pr.count = ec2;
    1a00:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a04:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		mm_map(&mm_kernel, r, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
    1a08:	48 8d 55 a0          	lea    rdx,[rbp-0x60]
    1a0c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1a10:	41 b8 0c 00 00 00    	mov    r8d,0xc
    1a16:	b9 01 00 00 00       	mov    ecx,0x1
    1a1b:	48 89 c6             	mov    rsi,rax
    1a1e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1a25:	e8 00 00 00 00       	call   1a2a <mm_fm_init+0x224>

		/* now init the leftovers */
		for (uint64_t i = 0; i < ec2; i++) {
    1a2a:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    1a32:	e9 e0 00 00 00       	jmp    1b17 <mm_fm_init+0x311>
				struct pmu* pt = NULL; int rd = 0;
    1a37:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    1a3f:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0
				/* check for exception */
				if (b > 0x100000000 - 4096)
    1a46:	b8 00 f0 ff ff       	mov    eax,0xfffff000
    1a4b:	48 3b 45 f8          	cmp    rax,QWORD PTR [rbp-0x8]
    1a4f:	73 18                	jae    1a69 <mm_fm_init+0x263>
						pt = &p[i];
    1a51:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a55:	48 c1 e0 0c          	shl    rax,0xc
    1a59:	48 89 c2             	mov    rdx,rax
    1a5c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1a60:	48 01 d0             	add    rax,rdx
    1a63:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    1a67:	eb 01                	jmp    1a6a <mm_fm_init+0x264>

redo:
    1a69:	90                   	nop
				/* initialize */
				if (pt) {
    1a6a:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
    1a6f:	74 5e                	je     1acf <mm_fm_init+0x2c9>
						/* clear the locks */
						bzero(pt->locks, sizeof(pt->locks));
    1a71:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1a75:	be 08 00 00 00       	mov    esi,0x8
    1a7a:	48 89 c7             	mov    rdi,rax
    1a7d:	e8 00 00 00 00       	call   1a82 <mm_fm_init+0x27c>
						/* invalidate the counts and put rec in the last one */
						pt->free_ct[0] = 0xffff;
    1a82:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1a86:	66 c7 40 08 ff ff    	mov    WORD PTR [rax+0x8],0xffff
						pt->free_ct[1] = 0xffff;
    1a8c:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1a90:	66 c7 40 0a ff ff    	mov    WORD PTR [rax+0xa],0xffff
						pt->free_ct[2] = 0xffff;
    1a96:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1a9a:	66 c7 40 0c ff ff    	mov    WORD PTR [rax+0xc],0xffff
						if (rec)
    1aa0:	66 83 7d ca 00       	cmp    WORD PTR [rbp-0x36],0x0
    1aa5:	74 1e                	je     1ac5 <mm_fm_init+0x2bf>
								pt->free_ct[3] = (i == lst) ? rec : 0xffff;
    1aa7:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1aaa:	48 39 45 d8          	cmp    QWORD PTR [rbp-0x28],rax
    1aae:	75 06                	jne    1ab6 <mm_fm_init+0x2b0>
    1ab0:	0f b7 45 ca          	movzx  eax,WORD PTR [rbp-0x36]
    1ab4:	eb 05                	jmp    1abb <mm_fm_init+0x2b5>
    1ab6:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1abb:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1abf:	66 89 42 0e          	mov    WORD PTR [rdx+0xe],ax
    1ac3:	eb 0a                	jmp    1acf <mm_fm_init+0x2c9>
						else
								pt->free_ct[3] = 0xffff;
    1ac5:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1ac9:	66 c7 40 0e ff ff    	mov    WORD PTR [rax+0xe],0xffff
				}

				/* check for second run */
				if (!rd && (b1 > 0x100000000 - 4096)) {
    1acf:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    1ad3:	75 2d                	jne    1b02 <mm_fm_init+0x2fc>
    1ad5:	b8 00 f0 ff ff       	mov    eax,0xfffff000
    1ada:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    1ade:	73 22                	jae    1b02 <mm_fm_init+0x2fc>
						pt = &r[i];
    1ae0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ae4:	48 c1 e0 0c          	shl    rax,0xc
    1ae8:	48 89 c2             	mov    rdx,rax
    1aeb:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1aef:	48 01 d0             	add    rax,rdx
    1af2:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						rd = 1;
    1af6:	c7 45 cc 01 00 00 00 	mov    DWORD PTR [rbp-0x34],0x1
						goto redo;
    1afd:	e9 68 ff ff ff       	jmp    1a6a <mm_fm_init+0x264>
				}

				/* advance */
				b += 4096;
    1b02:	48 81 45 f8 00 10 00 00 	add    QWORD PTR [rbp-0x8],0x1000
				b1 += 4096;
    1b0a:	48 81 45 f0 00 10 00 00 	add    QWORD PTR [rbp-0x10],0x1000
		for (uint64_t i = 0; i < ec2; i++) {
    1b12:	48 83 45 d8 01       	add    QWORD PTR [rbp-0x28],0x1
    1b17:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1b1b:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
    1b1f:	0f 82 12 ff ff ff    	jb     1a37 <mm_fm_init+0x231>
    1b25:	eb 01                	jmp    1b28 <mm_fm_init+0x322>
				return;
    1b27:	90                   	nop
		}
}
    1b28:	c9                   	leave
    1b29:	c3                   	ret

0000000000001b2a <mmgr_reinit>:

void mmgr_reinit()
{
    1b2a:	55                   	push   rbp
    1b2b:	48 89 e5             	mov    rbp,rsp
    1b2e:	48 83 ec 10          	sub    rsp,0x10
		uint32_t* ptr = FM_FREE_MEMORY_MAP;
    1b32:	48 c7 45 f0 00 40 02 00 	mov    QWORD PTR [rbp-0x10],0x24000
		while (ptr);
    1b3a:	90                   	nop
    1b3b:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    1b40:	75 f9                	jne    1b3b <mmgr_reinit+0x11>
		fm_ofs = ptr[-1];
    1b42:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b46:	48 83 e8 04          	sub    rax,0x4
    1b4a:	8b 00                	mov    eax,DWORD PTR [rax]
    1b4c:	89 c0                	mov    eax,eax
    1b4e:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1b55 <mmgr_reinit+0x2b>
		fm_begin = ptr[-2];
    1b55:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b59:	48 83 e8 08          	sub    rax,0x8
    1b5d:	8b 00                	mov    eax,DWORD PTR [rax]
    1b5f:	89 c0                	mov    eax,eax
    1b61:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1b68 <mmgr_reinit+0x3e>
		rm_count = ptr[-3];
    1b68:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b6c:	48 83 e8 0c          	sub    rax,0xc
    1b70:	8b 00                	mov    eax,DWORD PTR [rax]
    1b72:	89 c0                	mov    eax,eax
    1b74:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1b7b <mmgr_reinit+0x51>
		pm_zero = *(uint64_t*)(ptr - 5);
    1b7b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b7f:	48 8b 40 ec          	mov    rax,QWORD PTR [rax-0x14]
    1b83:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1b8a <mmgr_reinit+0x60>
		mm_kernel.cr3 = *(uint64_t*)(ptr - 7);
    1b8a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b8e:	48 8b 40 e4          	mov    rax,QWORD PTR [rax-0x1c]
    1b92:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1b99 <mmgr_reinit+0x6f>
		mm_kernel.ctx = FM_VIRTUAL_MAPPING;
    1b99:	48 c7 05 00 00 00 00 00 80 02 00 	mov    QWORD PTR [rip+0x0],0x28000        # 1ba4 <mmgr_reinit+0x7a>
		mm_kernel.qnd_ptr = VM_QND_BASE;
    1ba4:	48 b8 00 00 00 00 00 f0 ff ff 	movabs rax,0xfffff00000000000
    1bae:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1bb5 <mmgr_reinit+0x8b>
		else
				mf_map = &mm_map32;
#endif

		/* map the pmus & initialize high pmus */
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    1bb5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1bbc <mmgr_reinit+0x92>
    1bbc:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1bc0:	eb 27                	jmp    1be9 <mmgr_reinit+0xbf>
				mm_fm_init(fmm + i);
    1bc2:	b9 00 40 02 00       	mov    ecx,0x24000
    1bc7:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1bcb:	48 89 d0             	mov    rax,rdx
    1bce:	48 c1 e0 03          	shl    rax,0x3
    1bd2:	48 29 d0             	sub    rax,rdx
    1bd5:	48 c1 e0 03          	shl    rax,0x3
    1bd9:	48 01 c8             	add    rax,rcx
    1bdc:	48 89 c7             	mov    rdi,rax
    1bdf:	e8 00 00 00 00       	call   1be4 <mmgr_reinit+0xba>
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    1be4:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    1be9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1bf0 <mmgr_reinit+0xc6>
    1bf0:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    1bf4:	72 cc                	jb     1bc2 <mmgr_reinit+0x98>
		//if (cpu.e_has_nx)
		//		enable_nx();

		/* allocate the heap */
		void init_kernel_heap();
		while (ptr);
    1bf6:	90                   	nop
    1bf7:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    1bfc:	75 f9                	jne    1bf7 <mmgr_reinit+0xcd>
		init_kernel_heap();
    1bfe:	b8 00 00 00 00       	mov    eax,0x0
    1c03:	e8 00 00 00 00       	call   1c08 <mmgr_reinit+0xde>
		void flush_tlb_full();
		flush_tlb_full();
    1c08:	b8 00 00 00 00       	mov    eax,0x0
    1c0d:	e8 00 00 00 00       	call   1c12 <mmgr_reinit+0xe8>
}
    1c12:	90                   	nop
    1c13:	c9                   	leave
    1c14:	c3                   	ret

0000000000001c15 <pmue_dump>:

void pmue_dump(struct pmue* pu, int level)
{
    1c15:	55                   	push   rbp
    1c16:	48 89 e5             	mov    rbp,rsp
    1c19:	48 83 ec 30          	sub    rsp,0x30
    1c1d:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1c21:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
		size_t i, ne; uint32_t* lv;
		if (level >= 0 && level <= 7) {
    1c24:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    1c28:	0f 88 f2 01 00 00    	js     1e20 <pmue_dump+0x20b>
    1c2e:	83 7d d4 07          	cmp    DWORD PTR [rbp-0x2c],0x7
    1c32:	0f 8f e8 01 00 00    	jg     1e20 <pmue_dump+0x20b>
				if (level == 0)
    1c38:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    1c3c:	75 15                	jne    1c53 <pmue_dump+0x3e>
						(lv = pu->lvl0), ne = 128;
    1c3e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c42:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1c46:	48 c7 45 f0 80 00 00 00 	mov    QWORD PTR [rbp-0x10],0x80
				if (level == 0)
    1c4e:	e9 d0 00 00 00       	jmp    1d23 <pmue_dump+0x10e>
				else if (level == 1)
    1c53:	83 7d d4 01          	cmp    DWORD PTR [rbp-0x2c],0x1
    1c57:	75 1b                	jne    1c74 <pmue_dump+0x5f>
						(lv = pu->lvl1), ne = 64;
    1c59:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c5d:	48 05 00 02 00 00    	add    rax,0x200
    1c63:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1c67:	48 c7 45 f0 40 00 00 00 	mov    QWORD PTR [rbp-0x10],0x40
				if (level == 0)
    1c6f:	e9 af 00 00 00       	jmp    1d23 <pmue_dump+0x10e>
				else if (level == 2)
    1c74:	83 7d d4 02          	cmp    DWORD PTR [rbp-0x2c],0x2
    1c78:	75 1b                	jne    1c95 <pmue_dump+0x80>
						(lv = pu->lvl2), ne = 32;
    1c7a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c7e:	48 05 00 03 00 00    	add    rax,0x300
    1c84:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1c88:	48 c7 45 f0 20 00 00 00 	mov    QWORD PTR [rbp-0x10],0x20
				if (level == 0)
    1c90:	e9 8e 00 00 00       	jmp    1d23 <pmue_dump+0x10e>
				else if (level == 3)
    1c95:	83 7d d4 03          	cmp    DWORD PTR [rbp-0x2c],0x3
    1c99:	75 18                	jne    1cb3 <pmue_dump+0x9e>
						(lv = pu->lvl3), ne = 16;
    1c9b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c9f:	48 05 80 03 00 00    	add    rax,0x380
    1ca5:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1ca9:	48 c7 45 f0 10 00 00 00 	mov    QWORD PTR [rbp-0x10],0x10
				if (level == 0)
    1cb1:	eb 70                	jmp    1d23 <pmue_dump+0x10e>
				else if (level == 4)
    1cb3:	83 7d d4 04          	cmp    DWORD PTR [rbp-0x2c],0x4
    1cb7:	75 18                	jne    1cd1 <pmue_dump+0xbc>
						(lv = pu->lvl4), ne = 8;
    1cb9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1cbd:	48 05 c0 03 00 00    	add    rax,0x3c0
    1cc3:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1cc7:	48 c7 45 f0 08 00 00 00 	mov    QWORD PTR [rbp-0x10],0x8
				if (level == 0)
    1ccf:	eb 52                	jmp    1d23 <pmue_dump+0x10e>
				else if (level == 5)
    1cd1:	83 7d d4 05          	cmp    DWORD PTR [rbp-0x2c],0x5
    1cd5:	75 18                	jne    1cef <pmue_dump+0xda>
						(lv = pu->lvl5), ne = 4;
    1cd7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1cdb:	48 05 e0 03 00 00    	add    rax,0x3e0
    1ce1:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1ce5:	48 c7 45 f0 04 00 00 00 	mov    QWORD PTR [rbp-0x10],0x4
				if (level == 0)
    1ced:	eb 34                	jmp    1d23 <pmue_dump+0x10e>
				else if (level == 6)
    1cef:	83 7d d4 06          	cmp    DWORD PTR [rbp-0x2c],0x6
    1cf3:	75 18                	jne    1d0d <pmue_dump+0xf8>
						(lv = pu->lvl6), ne = 2;
    1cf5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1cf9:	48 05 f0 03 00 00    	add    rax,0x3f0
    1cff:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1d03:	48 c7 45 f0 02 00 00 00 	mov    QWORD PTR [rbp-0x10],0x2
				if (level == 0)
    1d0b:	eb 16                	jmp    1d23 <pmue_dump+0x10e>
				else
						(lv = &pu->lvl7), ne = 1;
    1d0d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d11:	48 05 f8 03 00 00    	add    rax,0x3f8
    1d17:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1d1b:	48 c7 45 f0 01 00 00 00 	mov    QWORD PTR [rbp-0x10],0x1
				if (level == 0)
    1d23:	90                   	nop
		} else
				return;
		printf("pmue/rcpe (at %p) lvl%d entries:\n", pu, level);
    1d24:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    1d27:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d2b:	48 89 c6             	mov    rsi,rax
    1d2e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d35:	b8 00 00 00 00       	mov    eax,0x0
    1d3a:	e8 00 00 00 00       	call   1d3f <pmue_dump+0x12a>
		for (i = 0; i < ne; i += 6) {
    1d3f:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    1d47:	e9 c4 00 00 00       	jmp    1e10 <pmue_dump+0x1fb>
				if (ne - i >= 6) {
    1d4c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1d50:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    1d54:	48 83 f8 05          	cmp    rax,0x5
    1d58:	76 62                	jbe    1dbc <pmue_dump+0x1a7>
						printf("%08x %08x %08x %08x %08x %08x\n",
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d5a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d5e:	48 83 c0 14          	add    rax,0x14
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d62:	8b 30                	mov    esi,DWORD PTR [rax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d64:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d68:	48 83 c0 10          	add    rax,0x10
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d6c:	44 8b 00             	mov    r8d,DWORD PTR [rax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d6f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d73:	48 83 c0 0c          	add    rax,0xc
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d77:	8b 38                	mov    edi,DWORD PTR [rax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d79:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d7d:	48 83 c0 08          	add    rax,0x8
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d81:	8b 08                	mov    ecx,DWORD PTR [rax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d83:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d87:	48 83 c0 04          	add    rax,0x4
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d8b:	8b 10                	mov    edx,DWORD PTR [rax]
    1d8d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d91:	8b 00                	mov    eax,DWORD PTR [rax]
    1d93:	48 83 ec 08          	sub    rsp,0x8
    1d97:	56                   	push   rsi
    1d98:	45 89 c1             	mov    r9d,r8d
    1d9b:	41 89 f8             	mov    r8d,edi
    1d9e:	89 c6                	mov    esi,eax
    1da0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1da7:	b8 00 00 00 00       	mov    eax,0x0
    1dac:	e8 00 00 00 00       	call   1db1 <pmue_dump+0x19c>
    1db1:	48 83 c4 10          	add    rsp,0x10
						lv += 6;
    1db5:	48 83 45 e8 18       	add    QWORD PTR [rbp-0x18],0x18
    1dba:	eb 4f                	jmp    1e0b <pmue_dump+0x1f6>
				} else {
						size_t j;
						for (j = 0; j < ne - i; j++)
    1dbc:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    1dc4:	eb 2d                	jmp    1df3 <pmue_dump+0x1de>
								printf("%08x ", lv[j]);
    1dc6:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1dca:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1dd2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1dd6:	48 01 d0             	add    rax,rdx
    1dd9:	8b 00                	mov    eax,DWORD PTR [rax]
    1ddb:	89 c6                	mov    esi,eax
    1ddd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1de4:	b8 00 00 00 00       	mov    eax,0x0
    1de9:	e8 00 00 00 00       	call   1dee <pmue_dump+0x1d9>
						for (j = 0; j < ne - i; j++)
    1dee:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
    1df3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1df7:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    1dfb:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
    1dff:	72 c5                	jb     1dc6 <pmue_dump+0x1b1>
						putchar('\n');
    1e01:	bf 0a 00 00 00       	mov    edi,0xa
    1e06:	e8 00 00 00 00       	call   1e0b <pmue_dump+0x1f6>
		for (i = 0; i < ne; i += 6) {
    1e0b:	48 83 45 f8 06       	add    QWORD PTR [rbp-0x8],0x6
    1e10:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1e14:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    1e18:	0f 82 2e ff ff ff    	jb     1d4c <pmue_dump+0x137>
    1e1e:	eb 01                	jmp    1e21 <pmue_dump+0x20c>
				return;
    1e20:	90                   	nop
				}
		}
}
    1e21:	c9                   	leave
    1e22:	c3                   	ret

0000000000001e23 <pmu_dump>:
void pmu_dump(struct pmu* pu, int level)
{
    1e23:	55                   	push   rbp
    1e24:	48 89 e5             	mov    rbp,rsp
    1e27:	48 83 ec 20          	sub    rsp,0x20
    1e2b:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1e2f:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		printf("dumping pmu/rcp (at %p)\n", pu);
    1e32:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e36:	48 89 c6             	mov    rsi,rax
    1e39:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e40:	b8 00 00 00 00       	mov    eax,0x0
    1e45:	e8 00 00 00 00       	call   1e4a <pmu_dump+0x27>
		for (int i = 0; i < 4; i++)
    1e4a:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    1e51:	eb 30                	jmp    1e83 <pmu_dump+0x60>
				pmue_dump(&pu->entries[i], level);
    1e53:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1e56:	48 63 d0             	movsxd rdx,eax
    1e59:	48 89 d0             	mov    rax,rdx
    1e5c:	48 c1 e0 08          	shl    rax,0x8
    1e60:	48 29 d0             	sub    rax,rdx
    1e63:	48 c1 e0 02          	shl    rax,0x2
    1e67:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1e6b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e6f:	48 01 c2             	add    rdx,rax
    1e72:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1e75:	89 c6                	mov    esi,eax
    1e77:	48 89 d7             	mov    rdi,rdx
    1e7a:	e8 00 00 00 00       	call   1e7f <pmu_dump+0x5c>
		for (int i = 0; i < 4; i++)
    1e7f:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    1e83:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
    1e87:	7e ca                	jle    1e53 <pmu_dump+0x30>
}
    1e89:	90                   	nop
    1e8a:	90                   	nop
    1e8b:	c9                   	leave
    1e8c:	c3                   	ret

0000000000001e8d <mm_dump_pmu>:
void mm_dump_pmu(size_t fm, size_t n, int is_rcp)
{
    1e8d:	55                   	push   rbp
    1e8e:	48 89 e5             	mov    rbp,rsp
    1e91:	48 83 ec 40          	sub    rsp,0x40
    1e95:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1e99:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
    1e9d:	89 55 cc             	mov    DWORD PTR [rbp-0x34],edx
		struct pmu* pu;
		if (is_rcp == 2) {
    1ea0:	83 7d cc 02          	cmp    DWORD PTR [rbp-0x34],0x2
    1ea4:	0f 85 2b 01 00 00    	jne    1fd5 <mm_dump_pmu+0x148>
				/* user talk */
				printf("Free mem map contains %lu entries\n", fm_ofs);
    1eaa:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1eb1 <mm_dump_pmu+0x24>
    1eb1:	48 89 c6             	mov    rsi,rax
    1eb4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1ebb:	b8 00 00 00 00       	mov    eax,0x0
    1ec0:	e8 00 00 00 00       	call   1ec5 <mm_dump_pmu+0x38>
				printf("Enumerating maps:\n");
    1ec5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1ecc:	b8 00 00 00 00       	mov    eax,0x0
    1ed1:	e8 00 00 00 00       	call   1ed6 <mm_dump_pmu+0x49>
				for (n = 0; n < fm_ofs; n++) {
    1ed6:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    1ede:	e9 dc 00 00 00       	jmp    1fbf <mm_dump_pmu+0x132>
						size_t cr = 0, cu = 0;
    1ee3:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1eeb:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
						struct pmu* pu;
						printf("Map %lu: %016llx-%016llx\n", n,
								fmm[n].base, fmm[n].base + fmm[n].size);
    1ef3:	b9 00 40 02 00       	mov    ecx,0x24000
    1ef8:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1efc:	48 89 d0             	mov    rax,rdx
    1eff:	48 c1 e0 03          	shl    rax,0x3
    1f03:	48 29 d0             	sub    rax,rdx
    1f06:	48 c1 e0 03          	shl    rax,0x3
    1f0a:	48 01 c8             	add    rax,rcx
    1f0d:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1f10:	be 00 40 02 00       	mov    esi,0x24000
    1f15:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1f19:	48 89 d0             	mov    rax,rdx
    1f1c:	48 c1 e0 03          	shl    rax,0x3
    1f20:	48 29 d0             	sub    rax,rdx
    1f23:	48 c1 e0 03          	shl    rax,0x3
    1f27:	48 01 f0             	add    rax,rsi
    1f2a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
						printf("Map %lu: %016llx-%016llx\n", n,
    1f2e:	48 01 c1             	add    rcx,rax
								fmm[n].base, fmm[n].base + fmm[n].size);
    1f31:	be 00 40 02 00       	mov    esi,0x24000
    1f36:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1f3a:	48 89 d0             	mov    rax,rdx
    1f3d:	48 c1 e0 03          	shl    rax,0x3
    1f41:	48 29 d0             	sub    rax,rdx
    1f44:	48 c1 e0 03          	shl    rax,0x3
    1f48:	48 01 f0             	add    rax,rsi
						printf("Map %lu: %016llx-%016llx\n", n,
    1f4b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1f4e:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1f52:	48 89 c6             	mov    rsi,rax
    1f55:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1f5c:	b8 00 00 00 00       	mov    eax,0x0
    1f61:	e8 00 00 00 00       	call   1f66 <mm_dump_pmu+0xd9>
						pu = (void*)fmm[n].pmu;
    1f66:	b9 00 40 02 00       	mov    ecx,0x24000
    1f6b:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1f6f:	48 89 d0             	mov    rax,rdx
    1f72:	48 c1 e0 03          	shl    rax,0x3
    1f76:	48 29 d0             	sub    rax,rdx
    1f79:	48 c1 e0 03          	shl    rax,0x3
    1f7d:	48 01 c8             	add    rax,rcx
    1f80:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    1f84:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						printf("\tEntry count: %llu\n", fmm[n].ec);
    1f88:	b9 00 40 02 00       	mov    ecx,0x24000
    1f8d:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1f91:	48 89 d0             	mov    rax,rdx
    1f94:	48 c1 e0 03          	shl    rax,0x3
    1f98:	48 29 d0             	sub    rax,rdx
    1f9b:	48 c1 e0 03          	shl    rax,0x3
    1f9f:	48 01 c8             	add    rax,rcx
    1fa2:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1fa6:	48 89 c6             	mov    rsi,rax
    1fa9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1fb0:	b8 00 00 00 00       	mov    eax,0x0
    1fb5:	e8 00 00 00 00       	call   1fba <mm_dump_pmu+0x12d>
				for (n = 0; n < fm_ofs; n++) {
    1fba:	48 83 45 d0 01       	add    QWORD PTR [rbp-0x30],0x1
    1fbf:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1fc6 <mm_dump_pmu+0x139>
    1fc6:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    1fca:	0f 82 13 ff ff ff    	jb     1ee3 <mm_dump_pmu+0x56>
				}
				return;
    1fd0:	e9 30 01 00 00       	jmp    2105 <mm_dump_pmu+0x278>
		}
		if (fm > fm_ofs) {
    1fd5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1fdc <mm_dump_pmu+0x14f>
    1fdc:	48 3b 45 d8          	cmp    rax,QWORD PTR [rbp-0x28]
    1fe0:	73 16                	jae    1ff8 <mm_dump_pmu+0x16b>
				printf("FM out of range\n");
    1fe2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1fe9:	b8 00 00 00 00       	mov    eax,0x0
    1fee:	e8 00 00 00 00       	call   1ff3 <mm_dump_pmu+0x166>
				return;
    1ff3:	e9 0d 01 00 00       	jmp    2105 <mm_dump_pmu+0x278>
		}
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
						(uint32_t)fmm[fm].free_pages,
						(uint32_t)fmm[fm].reclaimable_pages);
    1ff8:	b9 00 40 02 00       	mov    ecx,0x24000
    1ffd:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    2001:	48 89 d0             	mov    rax,rdx
    2004:	48 c1 e0 03          	shl    rax,0x3
    2008:	48 29 d0             	sub    rax,rdx
    200b:	48 c1 e0 03          	shl    rax,0x3
    200f:	48 01 c8             	add    rax,rcx
    2012:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
    2016:	89 c1                	mov    ecx,eax
						(uint32_t)fmm[fm].free_pages,
    2018:	be 00 40 02 00       	mov    esi,0x24000
    201d:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    2021:	48 89 d0             	mov    rax,rdx
    2024:	48 c1 e0 03          	shl    rax,0x3
    2028:	48 29 d0             	sub    rax,rdx
    202b:	48 c1 e0 03          	shl    rax,0x3
    202f:	48 01 f0             	add    rax,rsi
    2032:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
    2036:	89 c2                	mov    edx,eax
    2038:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    203c:	48 89 c6             	mov    rsi,rax
    203f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2046:	b8 00 00 00 00       	mov    eax,0x0
    204b:	e8 00 00 00 00       	call   2050 <mm_dump_pmu+0x1c3>
		if (is_rcp)
    2050:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    2054:	74 24                	je     207a <mm_dump_pmu+0x1ed>
				pu = (void*)fmm[fm].rcp;
    2056:	b9 00 40 02 00       	mov    ecx,0x24000
    205b:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    205f:	48 89 d0             	mov    rax,rdx
    2062:	48 c1 e0 03          	shl    rax,0x3
    2066:	48 29 d0             	sub    rax,rdx
    2069:	48 c1 e0 03          	shl    rax,0x3
    206d:	48 01 c8             	add    rax,rcx
    2070:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    2074:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    2078:	eb 22                	jmp    209c <mm_dump_pmu+0x20f>
		else
				pu = (void*)fmm[fm].pmu;
    207a:	b9 00 40 02 00       	mov    ecx,0x24000
    207f:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    2083:	48 89 d0             	mov    rax,rdx
    2086:	48 c1 e0 03          	shl    rax,0x3
    208a:	48 29 d0             	sub    rax,rdx
    208d:	48 c1 e0 03          	shl    rax,0x3
    2091:	48 01 c8             	add    rax,rcx
    2094:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    2098:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (n > fmm[fm].ec)
    209c:	b9 00 40 02 00       	mov    ecx,0x24000
    20a1:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    20a5:	48 89 d0             	mov    rax,rdx
    20a8:	48 c1 e0 03          	shl    rax,0x3
    20ac:	48 29 d0             	sub    rax,rdx
    20af:	48 c1 e0 03          	shl    rax,0x3
    20b3:	48 01 c8             	add    rax,rcx
    20b6:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    20ba:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
    20be:	73 11                	jae    20d1 <mm_dump_pmu+0x244>
				printf("PMU index out of range\n");
    20c0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    20c7:	b8 00 00 00 00       	mov    eax,0x0
    20cc:	e8 00 00 00 00       	call   20d1 <mm_dump_pmu+0x244>
		pu += n;
    20d1:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    20d5:	48 c1 e0 0c          	shl    rax,0xc
    20d9:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		pmu_dump(pu, 0);
    20dd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20e1:	be 00 00 00 00       	mov    esi,0x0
    20e6:	48 89 c7             	mov    rdi,rax
    20e9:	e8 00 00 00 00       	call   20ee <mm_dump_pmu+0x261>
		if (is_rcp)
    20ee:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    20f2:	74 11                	je     2105 <mm_dump_pmu+0x278>
				pmu_dump(pu, 2);
    20f4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    20f8:	be 02 00 00 00       	mov    esi,0x2
    20fd:	48 89 c7             	mov    rdi,rax
    2100:	e8 00 00 00 00       	call   2105 <mm_dump_pmu+0x278>
}
    2105:	c9                   	leave
    2106:	c3                   	ret
