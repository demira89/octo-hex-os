
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
     3eb:	48 83 ec 70          	sub    rsp,0x70
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
     4a4:	e9 c8 01 00 00       	jmp    671 <mm_pmue_get_range+0x28a>
				/* test each bit */
				asm goto("bt %0, %1\n"
     4a9:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     4ac:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     4b0:	0f a3 02             	bt     DWORD PTR [rdx],eax
     4b3:	0f 82 a2 01 00 00    	jb     65b <mm_pmue_get_range+0x274>
						 "jc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : carry);

				/* we've got a free entry at i */
				if (lvl > 0) {
     4b9:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     4bd:	0f 84 c7 00 00 00    	je     58a <mm_pmue_get_range+0x1a3>
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
     4f3:	48 8b 7d 28          	mov    rdi,QWORD PTR [rbp+0x28]
     4f7:	48 89 7c 24 18       	mov    QWORD PTR [rsp+0x18],rdi
     4fc:	48 8d 7d d4          	lea    rdi,[rbp-0x2c]
     500:	48 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],rdi
     505:	48 8b 7d 18          	mov    rdi,QWORD PTR [rbp+0x18]
     509:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
     50e:	8b 7d 10             	mov    edi,DWORD PTR [rbp+0x10]
     511:	89 3c 24             	mov    DWORD PTR [rsp],edi
     514:	48 89 c7             	mov    rdi,rax
     517:	e8 00 00 00 00       	call   51c <mm_pmue_get_range+0x135>
     51c:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
								lvl - 1, pg_ct, pr, pr_ct, n_pr, &bs, base);
						/* set counts */
						rv += rv2;
     51f:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     522:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
						pg_ct -= rv2;
     525:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     528:	29 45 b8             	sub    DWORD PTR [rbp-0x48],eax
						pr += *n_pr - prr;
     52b:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     52f:	8b 00                	mov    eax,DWORD PTR [rax]
     531:	2b 45 dc             	sub    eax,DWORD PTR [rbp-0x24]
     534:	89 c0                	mov    eax,eax
     536:	48 c1 e0 04          	shl    rax,0x4
     53a:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
						pr_ct -= *n_pr - prr;
     53e:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     542:	8b 00                	mov    eax,DWORD PTR [rax]
     544:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
     547:	29 c2                	sub    edx,eax
     549:	01 55 10             	add    DWORD PTR [rbp+0x10],edx
						/* update by checking bits set in range */
						if (bs == 2) {
     54c:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     54f:	83 f8 02             	cmp    eax,0x2
     552:	75 19                	jne    56d <mm_pmue_get_range+0x186>
								asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     554:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     557:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     55b:	0f ab 02             	bts    DWORD PTR [rdx],eax
								(*bsir)++;
     55e:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     562:	8b 00                	mov    eax,DWORD PTR [rax]
     564:	8d 50 01             	lea    edx,[rax+0x1]
     567:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     56b:	89 10                	mov    DWORD PTR [rax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct & !rv2))
     56d:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     571:	0f 84 06 01 00 00    	je     67d <mm_pmue_get_range+0x296>
     577:	8b 45 10             	mov    eax,DWORD PTR [rbp+0x10]
     57a:	0b 45 d8             	or     eax,DWORD PTR [rbp-0x28]
     57d:	85 c0                	test   eax,eax
     57f:	0f 84 f8 00 00 00    	je     67d <mm_pmue_get_range+0x296>
						/* check for done */
						if (!pg_ct)
								break;

				}
				continue;
     585:	e9 e2 00 00 00       	jmp    66c <mm_pmue_get_range+0x285>
						uint64_t b = base + i * 4096, bp = 1;
     58a:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     58d:	c1 e0 0c             	shl    eax,0xc
     590:	89 c2                	mov    edx,eax
     592:	48 8b 45 28          	mov    rax,QWORD PTR [rbp+0x28]
     596:	48 01 d0             	add    rax,rdx
     599:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     59d:	48 c7 45 e8 01 00 00 00 	mov    QWORD PTR [rbp-0x18],0x1
						asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     5a5:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     5a8:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     5ac:	0f ab 02             	bts    DWORD PTR [rdx],eax
						if (*n_pr)
     5af:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     5b3:	8b 00                	mov    eax,DWORD PTR [rax]
     5b5:	85 c0                	test   eax,eax
     5b7:	74 22                	je     5db <mm_pmue_get_range+0x1f4>
								bp = pr[-1].base + 4096 * pr[-1].count;
     5b9:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     5bd:	48 83 e8 10          	sub    rax,0x10
     5c1:	48 8b 00             	mov    rax,QWORD PTR [rax]
     5c4:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     5c8:	48 83 ea 10          	sub    rdx,0x10
     5cc:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
     5d0:	48 c1 e2 0c          	shl    rdx,0xc
     5d4:	48 01 d0             	add    rax,rdx
     5d7:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (b == bp)
     5db:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     5df:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
     5e3:	75 16                	jne    5fb <mm_pmue_get_range+0x214>
								pr[-1].count++;
     5e5:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     5e9:	48 83 e8 10          	sub    rax,0x10
     5ed:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     5f1:	48 83 c2 01          	add    rdx,0x1
     5f5:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     5f9:	eb 41                	jmp    63c <mm_pmue_get_range+0x255>
								if (!pr_ct) { /* rollback */
     5fb:	83 7d 10 00          	cmp    DWORD PTR [rbp+0x10],0x0
     5ff:	75 0c                	jne    60d <mm_pmue_get_range+0x226>
										asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     601:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     604:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     608:	0f bb 02             	btc    DWORD PTR [rdx],eax
										break;
     60b:	eb 70                	jmp    67d <mm_pmue_get_range+0x296>
								pr->base = b;
     60d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     611:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     615:	48 89 10             	mov    QWORD PTR [rax],rdx
								pr->count = 1;
     618:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     61c:	48 c7 40 08 01 00 00 00 	mov    QWORD PTR [rax+0x8],0x1
								pr_ct--;
     624:	83 6d 10 01          	sub    DWORD PTR [rbp+0x10],0x1
								(*n_pr)++;
     628:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     62c:	8b 00                	mov    eax,DWORD PTR [rax]
     62e:	8d 50 01             	lea    edx,[rax+0x1]
     631:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     635:	89 10                	mov    DWORD PTR [rax],edx
								pr++;
     637:	48 83 45 b0 10       	add    QWORD PTR [rbp-0x50],0x10
						rv++;
     63c:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
						pg_ct--;
     640:	83 6d b8 01          	sub    DWORD PTR [rbp-0x48],0x1
						(*bsir)++;
     644:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     648:	8b 00                	mov    eax,DWORD PTR [rax]
     64a:	8d 50 01             	lea    edx,[rax+0x1]
     64d:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     651:	89 10                	mov    DWORD PTR [rax],edx
						if (!pg_ct)
     653:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     657:	75 13                	jne    66c <mm_pmue_get_range+0x285>
								break;
     659:	eb 22                	jmp    67d <mm_pmue_get_range+0x296>

carry:
				(*bsir)++;
     65b:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     65f:	8b 00                	mov    eax,DWORD PTR [rax]
     661:	8d 50 01             	lea    edx,[rax+0x1]
     664:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     668:	89 10                	mov    DWORD PTR [rax],edx
     66a:	eb 01                	jmp    66d <mm_pmue_get_range+0x286>
				continue;
     66c:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
     66d:	83 45 f0 01          	add    DWORD PTR [rbp-0x10],0x1
     671:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     674:	39 45 c0             	cmp    DWORD PTR [rbp-0x40],eax
     677:	0f 83 2c fe ff ff    	jae    4a9 <mm_pmue_get_range+0xc2>
		}

		return rv;
     67d:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     680:	c9                   	leave
     681:	c3                   	ret

0000000000000682 <mm_rcpe_get_range>:

uint32_t mm_rcpe_get_range(struct pmue* p, uint32_t b, uint32_t e, uint32_t lvl,
				uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct,
				uint32_t* n_pr, uint32_t* bfir, uint64_t base)
{
     682:	55                   	push   rbp
     683:	48 89 e5             	mov    rbp,rsp
     686:	48 83 ec 70          	sub    rsp,0x70
     68a:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     68e:	89 75 c4             	mov    DWORD PTR [rbp-0x3c],esi
     691:	89 55 c0             	mov    DWORD PTR [rbp-0x40],edx
     694:	89 4d bc             	mov    DWORD PTR [rbp-0x44],ecx
     697:	44 89 45 b8          	mov    DWORD PTR [rbp-0x48],r8d
     69b:	4c 89 4d b0          	mov    QWORD PTR [rbp-0x50],r9
		uint32_t* bitfield, rv = 0;
     69f:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0

		/* set the reference */
		switch (lvl) {
     6a6:	83 7d bc 07          	cmp    DWORD PTR [rbp-0x44],0x7
     6aa:	74 14                	je     6c0 <mm_rcpe_get_range+0x3e>
     6ac:	83 7d bc 07          	cmp    DWORD PTR [rbp-0x44],0x7
     6b0:	77 3a                	ja     6ec <mm_rcpe_get_range+0x6a>
     6b2:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     6b6:	74 28                	je     6e0 <mm_rcpe_get_range+0x5e>
     6b8:	83 7d bc 02          	cmp    DWORD PTR [rbp-0x44],0x2
     6bc:	74 12                	je     6d0 <mm_rcpe_get_range+0x4e>
     6be:	eb 2c                	jmp    6ec <mm_rcpe_get_range+0x6a>
				case 7:
						bitfield = &p->lvl7;
     6c0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6c4:	48 05 f8 03 00 00    	add    rax,0x3f8
     6ca:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     6ce:	eb 1e                	jmp    6ee <mm_rcpe_get_range+0x6c>
				case 2:
						bitfield = p->lvl2;
     6d0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6d4:	48 05 00 03 00 00    	add    rax,0x300
     6da:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     6de:	eb 0e                	jmp    6ee <mm_rcpe_get_range+0x6c>
				case 0:
						bitfield = p->lvl0;
     6e0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6e4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						break;
     6e8:	eb 04                	jmp    6ee <mm_rcpe_get_range+0x6c>
     6ea:	eb 00                	jmp    6ec <mm_rcpe_get_range+0x6a>
				default:
						while (1);
     6ec:	eb fc                	jmp    6ea <mm_rcpe_get_range+0x68>
						break;
		}

		/* now do the bt trick */
		for (uint32_t i = b; i <= e; i++) {
     6ee:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     6f1:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
     6f4:	e9 0d 02 00 00       	jmp    906 <mm_rcpe_get_range+0x284>
				/* test each bit */
				asm goto("bt %0, %1\n"
     6f9:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     6fc:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     700:	0f a3 02             	bt     DWORD PTR [rdx],eax
     703:	0f 83 e7 01 00 00    	jae    8f0 <mm_rcpe_get_range+0x26e>
						 "jnc %l2\n"
						 : : "r" (i), "m" (*bitfield) : "cc" : nocarry);

				/* we've got a reclaimable entry at i */
				if (lvl > 0) {
     709:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     70d:	0f 84 00 01 00 00    	je     813 <mm_rcpe_get_range+0x191>
						uint32_t rv2, prr = *n_pr, bf = 0, mul;
     713:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     717:	8b 00                	mov    eax,DWORD PTR [rax]
     719:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
     71c:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [rbp-0x30],0x0
						mul = (lvl == 2) ? 4 : 32;
     723:	83 7d bc 02          	cmp    DWORD PTR [rbp-0x44],0x2
     727:	75 07                	jne    730 <mm_rcpe_get_range+0xae>
     729:	b8 04 00 00 00       	mov    eax,0x4
     72e:	eb 05                	jmp    735 <mm_rcpe_get_range+0xb3>
     730:	b8 20 00 00 00       	mov    eax,0x20
     735:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
						/* go deeper */
						rv2 = mm_rcpe_get_range(p, i * mul, (i + 1) * mul - 1,
     738:	83 7d bc 02          	cmp    DWORD PTR [rbp-0x44],0x2
     73c:	75 08                	jne    746 <mm_rcpe_get_range+0xc4>
     73e:	41 ba 00 00 00 00    	mov    r10d,0x0
     744:	eb 06                	jmp    74c <mm_rcpe_get_range+0xca>
     746:	41 ba 02 00 00 00    	mov    r10d,0x2
     74c:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     74f:	83 c0 01             	add    eax,0x1
     752:	0f af 45 d8          	imul   eax,DWORD PTR [rbp-0x28]
     756:	8d 50 ff             	lea    edx,[rax-0x1]
     759:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     75c:	0f af 45 d8          	imul   eax,DWORD PTR [rbp-0x28]
     760:	89 c6                	mov    esi,eax
     762:	4c 8b 45 b0          	mov    r8,QWORD PTR [rbp-0x50]
     766:	8b 7d b8             	mov    edi,DWORD PTR [rbp-0x48]
     769:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     76d:	48 8b 4d 28          	mov    rcx,QWORD PTR [rbp+0x28]
     771:	48 89 4c 24 18       	mov    QWORD PTR [rsp+0x18],rcx
     776:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
     77a:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
     77f:	48 8b 4d 18          	mov    rcx,QWORD PTR [rbp+0x18]
     783:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
     788:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
     78b:	89 0c 24             	mov    DWORD PTR [rsp],ecx
     78e:	4d 89 c1             	mov    r9,r8
     791:	41 89 f8             	mov    r8d,edi
     794:	44 89 d1             	mov    ecx,r10d
     797:	48 89 c7             	mov    rdi,rax
     79a:	e8 00 00 00 00       	call   79f <mm_rcpe_get_range+0x11d>
     79f:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
								(lvl == 2) ? 0 : 2, pg_ct, pr, pr_ct, n_pr, &bf, base);
						/* set counts */
						rv += rv2;
     7a2:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     7a5:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
						pg_ct -= rv2;
     7a8:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     7ab:	29 45 b8             	sub    DWORD PTR [rbp-0x48],eax
						pr += *n_pr - prr;
     7ae:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     7b2:	8b 00                	mov    eax,DWORD PTR [rax]
     7b4:	2b 45 dc             	sub    eax,DWORD PTR [rbp-0x24]
     7b7:	89 c0                	mov    eax,eax
     7b9:	48 c1 e0 04          	shl    rax,0x4
     7bd:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
						pr_ct -= *n_pr - prr;
     7c1:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     7c5:	8b 00                	mov    eax,DWORD PTR [rax]
     7c7:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
     7ca:	29 c2                	sub    edx,eax
     7cc:	01 55 10             	add    DWORD PTR [rbp+0x10],edx
						/* update by checking bits free in range */
						if (bf == mul) {
     7cf:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     7d2:	39 45 d8             	cmp    DWORD PTR [rbp-0x28],eax
     7d5:	75 19                	jne    7f0 <mm_rcpe_get_range+0x16e>
								asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     7d7:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     7da:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     7de:	0f bb 02             	btc    DWORD PTR [rdx],eax
								(*bfir)++;
     7e1:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     7e5:	8b 00                	mov    eax,DWORD PTR [rax]
     7e7:	8d 50 01             	lea    edx,[rax+0x1]
     7ea:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     7ee:	89 10                	mov    DWORD PTR [rax],edx
						}

						/* and quit if done */
						if (!pg_ct || (!pr_ct && !rv2))
     7f0:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     7f4:	0f 84 18 01 00 00    	je     912 <mm_rcpe_get_range+0x290>
     7fa:	83 7d 10 00          	cmp    DWORD PTR [rbp+0x10],0x0
     7fe:	0f 85 fd 00 00 00    	jne    901 <mm_rcpe_get_range+0x27f>
     804:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
     808:	0f 84 04 01 00 00    	je     912 <mm_rcpe_get_range+0x290>
						mm_scrub_single_page(b);
						/* check for done */
						if (!pg_ct)
								break;
				}
				continue;
     80e:	e9 ee 00 00 00       	jmp    901 <mm_rcpe_get_range+0x27f>
						uint64_t b = base + i * 4096, bp = 1;
     813:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     816:	c1 e0 0c             	shl    eax,0xc
     819:	89 c2                	mov    edx,eax
     81b:	48 8b 45 28          	mov    rax,QWORD PTR [rbp+0x28]
     81f:	48 01 d0             	add    rax,rdx
     822:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     826:	48 c7 45 e8 01 00 00 00 	mov    QWORD PTR [rbp-0x18],0x1
						asm("btc %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     82e:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     831:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     835:	0f bb 02             	btc    DWORD PTR [rdx],eax
						if (*n_pr)
     838:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     83c:	8b 00                	mov    eax,DWORD PTR [rax]
     83e:	85 c0                	test   eax,eax
     840:	74 22                	je     864 <mm_rcpe_get_range+0x1e2>
								bp = pr[-1].base + 4096 * pr[-1].count;
     842:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     846:	48 83 e8 10          	sub    rax,0x10
     84a:	48 8b 00             	mov    rax,QWORD PTR [rax]
     84d:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
     851:	48 83 ea 10          	sub    rdx,0x10
     855:	48 8b 52 08          	mov    rdx,QWORD PTR [rdx+0x8]
     859:	48 c1 e2 0c          	shl    rdx,0xc
     85d:	48 01 d0             	add    rax,rdx
     860:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (b == bp)
     864:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     868:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
     86c:	75 16                	jne    884 <mm_rcpe_get_range+0x202>
								pr[-1].count++;
     86e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     872:	48 83 e8 10          	sub    rax,0x10
     876:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     87a:	48 83 c2 01          	add    rdx,0x1
     87e:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     882:	eb 41                	jmp    8c5 <mm_rcpe_get_range+0x243>
								if (!pr_ct) { /* rollback */
     884:	83 7d 10 00          	cmp    DWORD PTR [rbp+0x10],0x0
     888:	75 0c                	jne    896 <mm_rcpe_get_range+0x214>
										asm("bts %0, %1\n" : : "r" (i), "m" (*bitfield) : "cc");
     88a:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     88d:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     891:	0f ab 02             	bts    DWORD PTR [rdx],eax
										break;
     894:	eb 7c                	jmp    912 <mm_rcpe_get_range+0x290>
								pr->base = b;
     896:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     89a:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     89e:	48 89 10             	mov    QWORD PTR [rax],rdx
								pr->count = 1;
     8a1:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     8a5:	48 c7 40 08 01 00 00 00 	mov    QWORD PTR [rax+0x8],0x1
								pr_ct--;
     8ad:	83 6d 10 01          	sub    DWORD PTR [rbp+0x10],0x1
								(*n_pr)++;
     8b1:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     8b5:	8b 00                	mov    eax,DWORD PTR [rax]
     8b7:	8d 50 01             	lea    edx,[rax+0x1]
     8ba:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
     8be:	89 10                	mov    DWORD PTR [rax],edx
								pr++;
     8c0:	48 83 45 b0 10       	add    QWORD PTR [rbp-0x50],0x10
						rv++;
     8c5:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
						pg_ct--;
     8c9:	83 6d b8 01          	sub    DWORD PTR [rbp-0x48],0x1
						(*bfir)++;
     8cd:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     8d1:	8b 00                	mov    eax,DWORD PTR [rax]
     8d3:	8d 50 01             	lea    edx,[rax+0x1]
     8d6:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     8da:	89 10                	mov    DWORD PTR [rax],edx
						mm_scrub_single_page(b);
     8dc:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     8e0:	48 89 c7             	mov    rdi,rax
     8e3:	e8 00 00 00 00       	call   8e8 <mm_rcpe_get_range+0x266>
						if (!pg_ct)
     8e8:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     8ec:	75 13                	jne    901 <mm_rcpe_get_range+0x27f>
								break;
     8ee:	eb 22                	jmp    912 <mm_rcpe_get_range+0x290>

nocarry:
				(*bfir)++;
     8f0:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     8f4:	8b 00                	mov    eax,DWORD PTR [rax]
     8f6:	8d 50 01             	lea    edx,[rax+0x1]
     8f9:	48 8b 45 20          	mov    rax,QWORD PTR [rbp+0x20]
     8fd:	89 10                	mov    DWORD PTR [rax],edx
     8ff:	eb 01                	jmp    902 <mm_rcpe_get_range+0x280>
				continue;
     901:	90                   	nop
		for (uint32_t i = b; i <= e; i++) {
     902:	83 45 f0 01          	add    DWORD PTR [rbp-0x10],0x1
     906:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     909:	39 45 c0             	cmp    DWORD PTR [rbp-0x40],eax
     90c:	0f 83 e7 fd ff ff    	jae    6f9 <mm_rcpe_get_range+0x77>
		}

		return rv;
     912:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     915:	c9                   	leave
     916:	c3                   	ret

0000000000000917 <mm_fmrc_get>:

/* is used to really set entries in a pmu/rcp */
uint32_t mm_fmrc_get(struct pmu* p, uint32_t idx, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr, uint64_t base)
{
     917:	55                   	push   rbp
     918:	48 89 e5             	mov    rbp,rsp
     91b:	48 83 ec 70          	sub    rsp,0x70
     91f:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     923:	89 75 c4             	mov    DWORD PTR [rbp-0x3c],esi
     926:	89 55 c0             	mov    DWORD PTR [rbp-0x40],edx
     929:	89 4d bc             	mov    DWORD PTR [rbp-0x44],ecx
     92c:	4c 89 45 b0          	mov    QWORD PTR [rbp-0x50],r8
     930:	44 89 4d b8          	mov    DWORD PTR [rbp-0x48],r9d
		size_t i; uint32_t msk = 0x00000003, rv = 0;
     934:	c7 45 f4 03 00 00 00 	mov    DWORD PTR [rbp-0xc],0x3
     93b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
		struct pmue* e = &p->entries[idx];
     942:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
     945:	48 89 d0             	mov    rax,rdx
     948:	48 c1 e0 08          	shl    rax,0x8
     94c:	48 29 d0             	sub    rax,rdx
     94f:	48 c1 e0 02          	shl    rax,0x2
     953:	48 8d 50 10          	lea    rdx,[rax+0x10]
     957:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     95b:	48 01 d0             	add    rax,rdx
     95e:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		/* lock is 2 lvl7 bits wide (256 pages) so use it sparingly */

		/* first skip all full/empty lvl7 ranges (2 at a time) */
		uint32_t prc = 0;
     962:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [rbp-0x2c],0x0
		for (i = 0; i < 16; i++) {
     969:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     971:	e9 93 01 00 00       	jmp    b09 <mm_fmrc_get+0x1f2>
				uint8_t bt = ((e->lvl7 & msk) >> 2 * i);
     976:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     97a:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [rax+0x3f8]
     980:	23 45 f4             	and    eax,DWORD PTR [rbp-0xc]
     983:	89 c2                	mov    edx,eax
     985:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     989:	01 c0                	add    eax,eax
     98b:	89 c1                	mov    ecx,eax
     98d:	d3 ea                	shr    edx,cl
     98f:	89 d0                	mov    eax,edx
     991:	88 45 df             	mov    BYTE PTR [rbp-0x21],al
				if (free ? (bt != 3) : (bt)) { /* all set/unset */
     994:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     998:	74 09                	je     9a3 <mm_fmrc_get+0x8c>
     99a:	80 7d df 03          	cmp    BYTE PTR [rbp-0x21],0x3
     99e:	0f 95 c0             	setne  al
     9a1:	eb 07                	jmp    9aa <mm_fmrc_get+0x93>
     9a3:	80 7d df 00          	cmp    BYTE PTR [rbp-0x21],0x0
     9a7:	0f 95 c0             	setne  al
     9aa:	84 c0                	test   al,al
     9ac:	0f 84 4d 01 00 00    	je     aff <mm_fmrc_get+0x1e8>
						uint32_t rv2 = 0, pcc = prc, bsir = 0;
     9b2:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
     9b9:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     9bc:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
     9bf:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [rbp-0x30],0x0
						/* some bits set: try to lock */
						asm goto("lock bts %0, %1\n"
							"jc %l2\n" : : "r" (idx * 16 + 2 * i),
     9c6:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     9c9:	c1 e0 04             	shl    eax,0x4
     9cc:	89 c2                	mov    edx,eax
     9ce:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9d2:	48 01 c0             	add    rax,rax
     9d5:	48 01 c2             	add    rdx,rax
						asm goto("lock bts %0, %1\n"
     9d8:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     9dc:	f0 48 0f ab 10       	lock bts QWORD PTR [rax],rdx
     9e1:	0f 82 19 01 00 00    	jb     b00 <mm_fmrc_get+0x1e9>
							"m" (*p->locks) : "cc" : carry);

						/* we hold the lock (else jump to carry) */
						if (free)
     9e7:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0
     9eb:	74 54                	je     a41 <mm_fmrc_get+0x12a>
								rv2 = mm_pmue_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
     9ed:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9f1:	01 c0                	add    eax,eax
     9f3:	8d 50 01             	lea    edx,[rax+0x1]
     9f6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     9fa:	8d 34 00             	lea    esi,[rax+rax*1]
     9fd:	4c 8b 45 b0          	mov    r8,QWORD PTR [rbp-0x50]
     a01:	8b 7d c0             	mov    edi,DWORD PTR [rbp-0x40]
     a04:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     a08:	48 8b 4d 18          	mov    rcx,QWORD PTR [rbp+0x18]
     a0c:	48 89 4c 24 18       	mov    QWORD PTR [rsp+0x18],rcx
     a11:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
     a15:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
     a1a:	48 8d 4d d4          	lea    rcx,[rbp-0x2c]
     a1e:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
     a23:	8b 4d b8             	mov    ecx,DWORD PTR [rbp-0x48]
     a26:	89 0c 24             	mov    DWORD PTR [rsp],ecx
     a29:	4d 89 c1             	mov    r9,r8
     a2c:	41 89 f8             	mov    r8d,edi
     a2f:	b9 07 00 00 00       	mov    ecx,0x7
     a34:	48 89 c7             	mov    rdi,rax
     a37:	e8 00 00 00 00       	call   a3c <mm_fmrc_get+0x125>
     a3c:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
     a3f:	eb 52                	jmp    a93 <mm_fmrc_get+0x17c>
										pr, pr_ct, &prc, &bsir, base);
						else
								rv2 = mm_rcpe_get_range(e, i * 2, i * 2 + 1, 7, pg_ct,
     a41:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a45:	01 c0                	add    eax,eax
     a47:	8d 50 01             	lea    edx,[rax+0x1]
     a4a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     a4e:	8d 34 00             	lea    esi,[rax+rax*1]
     a51:	4c 8b 45 b0          	mov    r8,QWORD PTR [rbp-0x50]
     a55:	8b 7d c0             	mov    edi,DWORD PTR [rbp-0x40]
     a58:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     a5c:	48 8b 4d 18          	mov    rcx,QWORD PTR [rbp+0x18]
     a60:	48 89 4c 24 18       	mov    QWORD PTR [rsp+0x18],rcx
     a65:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
     a69:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
     a6e:	48 8d 4d d4          	lea    rcx,[rbp-0x2c]
     a72:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
     a77:	8b 4d b8             	mov    ecx,DWORD PTR [rbp-0x48]
     a7a:	89 0c 24             	mov    DWORD PTR [rsp],ecx
     a7d:	4d 89 c1             	mov    r9,r8
     a80:	41 89 f8             	mov    r8d,edi
     a83:	b9 07 00 00 00       	mov    ecx,0x7
     a88:	48 89 c7             	mov    rdi,rax
     a8b:	e8 00 00 00 00       	call   a90 <mm_fmrc_get+0x179>
     a90:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
										pr, pr_ct, &prc, &bsir, base);
						pr_ct -= prc - pcc;
     a93:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     a96:	8b 55 d8             	mov    edx,DWORD PTR [rbp-0x28]
     a99:	29 c2                	sub    edx,eax
     a9b:	01 55 b8             	add    DWORD PTR [rbp-0x48],edx
						pr += prc - pcc;
     a9e:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     aa1:	2b 45 d8             	sub    eax,DWORD PTR [rbp-0x28]
     aa4:	89 c0                	mov    eax,eax
     aa6:	48 c1 e0 04          	shl    rax,0x4
     aaa:	48 01 45 b0          	add    QWORD PTR [rbp-0x50],rax
						*n_pr += prc - pcc;
     aae:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     ab2:	8b 10                	mov    edx,DWORD PTR [rax]
     ab4:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     ab7:	2b 45 d8             	sub    eax,DWORD PTR [rbp-0x28]
     aba:	01 c2                	add    edx,eax
     abc:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     ac0:	89 10                	mov    DWORD PTR [rax],edx
						rv += rv2;
     ac2:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     ac5:	01 45 f0             	add    DWORD PTR [rbp-0x10],eax
						pg_ct -= rv2;
     ac8:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     acb:	29 45 c0             	sub    DWORD PTR [rbp-0x40],eax

						/* release lock */
						asm("btr %0, %1\n" : : "r" (idx * 16 + 2 * i),
     ace:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     ad1:	c1 e0 04             	shl    eax,0x4
     ad4:	89 c2                	mov    edx,eax
     ad6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ada:	48 01 c0             	add    rax,rax
     add:	48 01 c2             	add    rdx,rax
     ae0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     ae4:	48 0f b3 10          	btr    QWORD PTR [rax],rdx
							"m" (*p->locks) : "cc");

						if (!pg_ct || (!pr_ct && !rv2))
     ae8:	83 7d c0 00          	cmp    DWORD PTR [rbp-0x40],0x0
     aec:	74 0c                	je     afa <mm_fmrc_get+0x1e3>
     aee:	83 7d b8 00          	cmp    DWORD PTR [rbp-0x48],0x0
     af2:	75 0c                	jne    b00 <mm_fmrc_get+0x1e9>
     af4:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     af8:	75 06                	jne    b00 <mm_fmrc_get+0x1e9>
								return rv;
     afa:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     afd:	eb 18                	jmp    b17 <mm_fmrc_get+0x200>
				}
carry:
     aff:	90                   	nop
				/* advance */
				msk <<= 2;
     b00:	c1 65 f4 02          	shl    DWORD PTR [rbp-0xc],0x2
		for (i = 0; i < 16; i++) {
     b04:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     b09:	48 83 7d f8 0f       	cmp    QWORD PTR [rbp-0x8],0xf
     b0e:	0f 86 62 fe ff ff    	jbe    976 <mm_fmrc_get+0x5f>
		}

		return rv;
     b14:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
}
     b17:	c9                   	leave
     b18:	c3                   	ret

0000000000000b19 <mm_fmrc_alloc_pm>:

/* used for getting pages which are marked as free/reclaimable */
uint32_t mm_fmrc_alloc_pm(struct fme* fm, uint32_t pg_ct, int free,
				struct page_range* pr, uint32_t pr_ct, uint32_t* n_pr)
{
     b19:	55                   	push   rbp
     b1a:	48 89 e5             	mov    rbp,rsp
     b1d:	48 83 c4 80          	add    rsp,0xffffffffffffff80
     b21:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
     b25:	89 75 b4             	mov    DWORD PTR [rbp-0x4c],esi
     b28:	89 55 b0             	mov    DWORD PTR [rbp-0x50],edx
     b2b:	48 89 4d a8          	mov    QWORD PTR [rbp-0x58],rcx
     b2f:	44 89 45 a4          	mov    DWORD PTR [rbp-0x5c],r8d
     b33:	4c 89 4d 98          	mov    QWORD PTR [rbp-0x68],r9
		uint32_t rv = 0; uint64_t base = fm->base;
     b37:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     b3e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     b42:	48 8b 00             	mov    rax,QWORD PTR [rax]
     b45:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		size_t i, j; uint64_t mem = (free ? fm->pmu : fm->rcp);
     b49:	83 7d b0 00          	cmp    DWORD PTR [rbp-0x50],0x0
     b4d:	74 0a                	je     b59 <mm_fmrc_alloc_pm+0x40>
     b4f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     b53:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
     b57:	eb 08                	jmp    b61 <mm_fmrc_alloc_pm+0x48>
     b59:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     b5d:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
     b61:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax

		for (i = 0; i < fm->ec; i++) {
     b65:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     b6d:	e9 35 01 00 00       	jmp    ca7 <mm_fmrc_alloc_pm+0x18e>
				struct pmu* p = (void*)(size_t)mem;
     b72:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b76:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				/* skip if above limit */
				/*if (mem + 4096 > 0x100000000)
						break; - no idea what that was */ 

				/* operate on pmu/rcp */
				if (p->free_ct[0] == 0xffff) {
     b7a:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b7e:	0f b7 40 08          	movzx  eax,WORD PTR [rax+0x8]
     b82:	66 83 f8 ff          	cmp    ax,0xffff
     b86:	75 2f                	jne    bb7 <mm_fmrc_alloc_pm+0x9e>
						if (free) {
     b88:	83 7d b0 00          	cmp    DWORD PTR [rbp-0x50],0x0
     b8c:	74 15                	je     ba3 <mm_fmrc_alloc_pm+0x8a>
								if (mm_init_pmu(p))
     b8e:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     b92:	48 89 c7             	mov    rdi,rax
     b95:	e8 00 00 00 00       	call   b9a <mm_fmrc_alloc_pm+0x81>
     b9a:	85 c0                	test   eax,eax
     b9c:	74 19                	je     bb7 <mm_fmrc_alloc_pm+0x9e>
										continue; /* if locked */
     b9e:	e9 ff 00 00 00       	jmp    ca2 <mm_fmrc_alloc_pm+0x189>
						} else {
								if (mm_init_rcp(p))
     ba3:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     ba7:	48 89 c7             	mov    rdi,rax
     baa:	e8 00 00 00 00       	call   baf <mm_fmrc_alloc_pm+0x96>
     baf:	85 c0                	test   eax,eax
     bb1:	0f 85 ea 00 00 00    	jne    ca1 <mm_fmrc_alloc_pm+0x188>
										continue; /* if locked */
						}
				}

				/* check for free/reclaimable counts */
				for (j = 0; j < 4; j++) {
     bb7:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     bbf:	e9 d0 00 00 00       	jmp    c94 <mm_fmrc_alloc_pm+0x17b>
						if (p->free_ct[j] > 0) {
     bc4:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     bc8:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     bcc:	0f b7 44 50 08       	movzx  eax,WORD PTR [rax+rdx*2+0x8]
     bd1:	66 85 c0             	test   ax,ax
     bd4:	0f 84 ad 00 00 00    	je     c87 <mm_fmrc_alloc_pm+0x16e>
								uint32_t rv2, np = 0;
     bda:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [rbp-0x38],0x0
								/* operate on lock */
								rv2 = mm_fmrc_get(p, j, pg_ct, free, pr,
     be1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     be5:	41 89 c2             	mov    r10d,eax
     be8:	44 8b 45 a4          	mov    r8d,DWORD PTR [rbp-0x5c]
     bec:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
     bf0:	8b 4d b0             	mov    ecx,DWORD PTR [rbp-0x50]
     bf3:	8b 55 b4             	mov    edx,DWORD PTR [rbp-0x4c]
     bf6:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     bfa:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
     bfe:	48 89 74 24 08       	mov    QWORD PTR [rsp+0x8],rsi
     c03:	48 8d 75 c8          	lea    rsi,[rbp-0x38]
     c07:	48 89 34 24          	mov    QWORD PTR [rsp],rsi
     c0b:	45 89 c1             	mov    r9d,r8d
     c0e:	49 89 f8             	mov    r8,rdi
     c11:	44 89 d6             	mov    esi,r10d
     c14:	48 89 c7             	mov    rdi,rax
     c17:	e8 00 00 00 00       	call   c1c <mm_fmrc_alloc_pm+0x103>
     c1c:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
												pr_ct, &np, base);

								*n_pr += np;
     c1f:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     c23:	8b 10                	mov    edx,DWORD PTR [rax]
     c25:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c28:	01 c2                	add    edx,eax
     c2a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     c2e:	89 10                	mov    DWORD PTR [rax],edx
								pr_ct -= np;
     c30:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c33:	29 45 a4             	sub    DWORD PTR [rbp-0x5c],eax
								pr += np;
     c36:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
     c39:	89 c0                	mov    eax,eax
     c3b:	48 c1 e0 04          	shl    rax,0x4
     c3f:	48 01 45 a8          	add    QWORD PTR [rbp-0x58],rax
								rv += rv2;
     c43:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     c46:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
								pg_ct -= rv2;
     c49:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     c4c:	29 45 b4             	sub    DWORD PTR [rbp-0x4c],eax
								/* update count */
								p->free_ct[j] -= rv2;
     c4f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     c53:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     c57:	0f b7 44 50 08       	movzx  eax,WORD PTR [rax+rdx*2+0x8]
     c5c:	8b 55 cc             	mov    edx,DWORD PTR [rbp-0x34]
     c5f:	29 d0                	sub    eax,edx
     c61:	89 c1                	mov    ecx,eax
     c63:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     c67:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     c6b:	66 89 4c 50 08       	mov    WORD PTR [rax+rdx*2+0x8],cx
								/* exit if done or list exhausted (and no extension) */
								if (!pg_ct || (!pr_ct && !rv2))
     c70:	83 7d b4 00          	cmp    DWORD PTR [rbp-0x4c],0x0
     c74:	74 0c                	je     c82 <mm_fmrc_alloc_pm+0x169>
     c76:	83 7d a4 00          	cmp    DWORD PTR [rbp-0x5c],0x0
     c7a:	75 0b                	jne    c87 <mm_fmrc_alloc_pm+0x16e>
     c7c:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
     c80:	75 05                	jne    c87 <mm_fmrc_alloc_pm+0x16e>
										return rv;
     c82:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     c85:	eb 35                	jmp    cbc <mm_fmrc_alloc_pm+0x1a3>
						}

						/* advance base */
						base += 4096 * 4096;
     c87:	48 81 45 f0 00 00 00 01 	add    QWORD PTR [rbp-0x10],0x1000000
				for (j = 0; j < 4; j++) {
     c8f:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
     c94:	48 83 7d e0 03       	cmp    QWORD PTR [rbp-0x20],0x3
     c99:	0f 86 25 ff ff ff    	jbe    bc4 <mm_fmrc_alloc_pm+0xab>
     c9f:	eb 01                	jmp    ca2 <mm_fmrc_alloc_pm+0x189>
										continue; /* if locked */
     ca1:	90                   	nop
		for (i = 0; i < fm->ec; i++) {
     ca2:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     ca7:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     cab:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     caf:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
     cb3:	0f 82 b9 fe ff ff    	jb     b72 <mm_fmrc_alloc_pm+0x59>
				}
		}

		return rv;
     cb9:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
     cbc:	c9                   	leave
     cbd:	c3                   	ret

0000000000000cbe <mm_alloc_pm>:

uint32_t mm_alloc_pm(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct)
{
     cbe:	55                   	push   rbp
     cbf:	48 89 e5             	mov    rbp,rsp
     cc2:	48 83 ec 30          	sub    rsp,0x30
     cc6:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi
     cc9:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
     ccd:	89 55 d8             	mov    DWORD PTR [rbp-0x28],edx
		size_t i; uint32_t rv = 0, r2 = 0, pr_o = 0;
     cd0:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
     cd7:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
     cde:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [rbp-0x1c],0x0

retry:
		for (i = fm_begin; i < fm_ofs; i++) {
     ce5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # cec <mm_alloc_pm+0x2e>
     cec:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     cf0:	e9 ba 01 00 00       	jmp    eaf <mm_alloc_pm+0x1f1>
				/* skip if scrubbing is needed */
				if (!r2 && !fmm[i].free_pages)
     cf5:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
     cf9:	75 27                	jne    d22 <mm_alloc_pm+0x64>
     cfb:	b9 00 40 02 00       	mov    ecx,0x24000
     d00:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     d04:	48 89 d0             	mov    rax,rdx
     d07:	48 c1 e0 03          	shl    rax,0x3
     d0b:	48 29 d0             	sub    rax,rdx
     d0e:	48 c1 e0 03          	shl    rax,0x3
     d12:	48 01 c8             	add    rax,rcx
     d15:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     d19:	48 85 c0             	test   rax,rax
     d1c:	0f 84 84 01 00 00    	je     ea6 <mm_alloc_pm+0x1e8>
						continue;

				/* collect free pages */
				if (fmm[i].free_pages) {
     d22:	b9 00 40 02 00       	mov    ecx,0x24000
     d27:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     d2b:	48 89 d0             	mov    rax,rdx
     d2e:	48 c1 e0 03          	shl    rax,0x3
     d32:	48 29 d0             	sub    rax,rdx
     d35:	48 c1 e0 03          	shl    rax,0x3
     d39:	48 01 c8             	add    rax,rcx
     d3c:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     d40:	48 85 c0             	test   rax,rax
     d43:	0f 84 9f 00 00 00    	je     de8 <mm_alloc_pm+0x12a>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 1, pr + pr_o,
     d49:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     d4c:	8b 55 d8             	mov    edx,DWORD PTR [rbp-0x28]
     d4f:	89 d6                	mov    esi,edx
     d51:	29 c6                	sub    esi,eax
     d53:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     d56:	89 c0                	mov    eax,eax
     d58:	48 c1 e0 04          	shl    rax,0x4
     d5c:	48 89 c2             	mov    rdx,rax
     d5f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     d63:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
     d67:	bf 00 40 02 00       	mov    edi,0x24000
     d6c:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     d70:	48 89 d0             	mov    rax,rdx
     d73:	48 c1 e0 03          	shl    rax,0x3
     d77:	48 29 d0             	sub    rax,rdx
     d7a:	48 c1 e0 03          	shl    rax,0x3
     d7e:	48 01 c7             	add    rdi,rax
     d81:	48 8d 55 e4          	lea    rdx,[rbp-0x1c]
     d85:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     d88:	49 89 d1             	mov    r9,rdx
     d8b:	41 89 f0             	mov    r8d,esi
     d8e:	ba 01 00 00 00       	mov    edx,0x1
     d93:	89 c6                	mov    esi,eax
     d95:	e8 00 00 00 00       	call   d9a <mm_alloc_pm+0xdc>
     d9a:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
     d9d:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     da0:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
						pg_ct -= rv2;
     da3:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     da6:	29 45 dc             	sub    DWORD PTR [rbp-0x24],eax
						__sync_sub_and_fetch(&fmm[i].free_pages, rv2);
     da9:	8b 4d ec             	mov    ecx,DWORD PTR [rbp-0x14]
     dac:	be 00 40 02 00       	mov    esi,0x24000
     db1:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     db5:	48 89 d0             	mov    rax,rdx
     db8:	48 c1 e0 03          	shl    rax,0x3
     dbc:	48 29 d0             	sub    rax,rdx
     dbf:	48 c1 e0 03          	shl    rax,0x3
     dc3:	48 01 f0             	add    rax,rsi
     dc6:	48 83 c0 10          	add    rax,0x10
     dca:	f0 48 29 08          	lock sub QWORD PTR [rax],rcx
						if (pg_ct && !r2) /* skip scrub for now */
     dce:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     dd2:	74 0a                	je     dde <mm_alloc_pm+0x120>
     dd4:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
     dd8:	0f 84 cb 00 00 00    	je     ea9 <mm_alloc_pm+0x1eb>
								continue;
						else if (!pg_ct)
     dde:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     de2:	0f 84 f0 00 00 00    	je     ed8 <mm_alloc_pm+0x21a>
								goto done;
				}

				/* check for reclaimable */
				if (r2 && fmm[i].reclaimable_pages) {
     de8:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
     dec:	0f 84 b8 00 00 00    	je     eaa <mm_alloc_pm+0x1ec>
     df2:	b9 00 40 02 00       	mov    ecx,0x24000
     df7:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     dfb:	48 89 d0             	mov    rax,rdx
     dfe:	48 c1 e0 03          	shl    rax,0x3
     e02:	48 29 d0             	sub    rax,rdx
     e05:	48 c1 e0 03          	shl    rax,0x3
     e09:	48 01 c8             	add    rax,rcx
     e0c:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     e10:	48 85 c0             	test   rax,rax
     e13:	0f 84 91 00 00 00    	je     eaa <mm_alloc_pm+0x1ec>
						uint32_t rv2;
						rv2 = mm_fmrc_alloc_pm(fmm + i, pg_ct, 0, pr + pr_o,
     e19:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     e1c:	8b 55 d8             	mov    edx,DWORD PTR [rbp-0x28]
     e1f:	89 d6                	mov    esi,edx
     e21:	29 c6                	sub    esi,eax
     e23:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     e26:	89 c0                	mov    eax,eax
     e28:	48 c1 e0 04          	shl    rax,0x4
     e2c:	48 89 c2             	mov    rdx,rax
     e2f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     e33:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
     e37:	bf 00 40 02 00       	mov    edi,0x24000
     e3c:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     e40:	48 89 d0             	mov    rax,rdx
     e43:	48 c1 e0 03          	shl    rax,0x3
     e47:	48 29 d0             	sub    rax,rdx
     e4a:	48 c1 e0 03          	shl    rax,0x3
     e4e:	48 01 c7             	add    rdi,rax
     e51:	48 8d 55 e4          	lea    rdx,[rbp-0x1c]
     e55:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     e58:	49 89 d1             	mov    r9,rdx
     e5b:	41 89 f0             	mov    r8d,esi
     e5e:	ba 00 00 00 00       	mov    edx,0x0
     e63:	89 c6                	mov    esi,eax
     e65:	e8 00 00 00 00       	call   e6a <mm_alloc_pm+0x1ac>
     e6a:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
										pr_ct - pr_o, &pr_o);
						rv += rv2;
     e6d:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     e70:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
						pg_ct -= rv2;
     e73:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     e76:	29 45 dc             	sub    DWORD PTR [rbp-0x24],eax
						__sync_sub_and_fetch(&fmm[i].reclaimable_pages, rv2);
     e79:	8b 4d e8             	mov    ecx,DWORD PTR [rbp-0x18]
     e7c:	be 00 40 02 00       	mov    esi,0x24000
     e81:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     e85:	48 89 d0             	mov    rax,rdx
     e88:	48 c1 e0 03          	shl    rax,0x3
     e8c:	48 29 d0             	sub    rax,rdx
     e8f:	48 c1 e0 03          	shl    rax,0x3
     e93:	48 01 f0             	add    rax,rsi
     e96:	48 83 c0 18          	add    rax,0x18
     e9a:	f0 48 29 08          	lock sub QWORD PTR [rax],rcx
						if (!pg_ct)
     e9e:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     ea2:	74 37                	je     edb <mm_alloc_pm+0x21d>
     ea4:	eb 04                	jmp    eaa <mm_alloc_pm+0x1ec>
						continue;
     ea6:	90                   	nop
     ea7:	eb 01                	jmp    eaa <mm_alloc_pm+0x1ec>
								continue;
     ea9:	90                   	nop
		for (i = fm_begin; i < fm_ofs; i++) {
     eaa:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     eaf:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # eb6 <mm_alloc_pm+0x1f8>
     eb6:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
     eba:	0f 82 35 fe ff ff    	jb     cf5 <mm_alloc_pm+0x37>
								goto done;
				}
		}

		/* scrub enabled */
		if (pg_ct && !r2) {
     ec0:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     ec4:	74 18                	je     ede <mm_alloc_pm+0x220>
     ec6:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
     eca:	75 12                	jne    ede <mm_alloc_pm+0x220>
				r2 = 1;
     ecc:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [rbp-0x10],0x1
				goto retry;
     ed3:	e9 0d fe ff ff       	jmp    ce5 <mm_alloc_pm+0x27>
								goto done;
     ed8:	90                   	nop
     ed9:	eb 04                	jmp    edf <mm_alloc_pm+0x221>
								goto done;
     edb:	90                   	nop
     edc:	eb 01                	jmp    edf <mm_alloc_pm+0x221>
		}

done:
     ede:	90                   	nop
		if (!rv) { /* OOM */
     edf:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
     ee3:	75 03                	jne    ee8 <mm_alloc_pm+0x22a>
				while (1);
     ee5:	90                   	nop
     ee6:	eb fd                	jmp    ee5 <mm_alloc_pm+0x227>
				die("OOM");
		}

		/* null-terminate */
		if (pr_o < pr_ct) {
     ee8:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     eeb:	3b 45 d8             	cmp    eax,DWORD PTR [rbp-0x28]
     eee:	73 35                	jae    f25 <mm_alloc_pm+0x267>
				pr[pr_o].base = 0;
     ef0:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     ef3:	89 c0                	mov    eax,eax
     ef5:	48 c1 e0 04          	shl    rax,0x4
     ef9:	48 89 c2             	mov    rdx,rax
     efc:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     f00:	48 01 d0             	add    rax,rdx
     f03:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				pr[pr_o].count = 0;
     f0a:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     f0d:	89 c0                	mov    eax,eax
     f0f:	48 c1 e0 04          	shl    rax,0x4
     f13:	48 89 c2             	mov    rdx,rax
     f16:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     f1a:	48 01 d0             	add    rax,rdx
     f1d:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		}
		return rv;
     f25:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     f28:	c9                   	leave
     f29:	c3                   	ret

0000000000000f2a <mm_alloc_pm_flg>:

/* rcp: higher-levels<=>Exists; pmu: higher-levels: completely used */
uint32_t mm_alloc_pm_flg(uint32_t pg_ct, struct page_range* pr, uint32_t pr_ct, int flg)
{
     f2a:	55                   	push   rbp
     f2b:	48 89 e5             	mov    rbp,rsp
     f2e:	48 83 ec 20          	sub    rsp,0x20
     f32:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
     f35:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     f39:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
     f3c:	89 4d ec             	mov    DWORD PTR [rbp-0x14],ecx
		die("not implemented\n");
     f3f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f46:	bf 0c 00 00 00       	mov    edi,0xc
     f4b:	b8 00 00 00 00       	mov    eax,0x0
     f50:	e8 00 00 00 00       	call   f55 <mm_alloc_pm_flg+0x2b>
     f55:	b8 00 00 00 00       	mov    eax,0x0
     f5a:	e8 00 00 00 00       	call   f5f <mm_alloc_pm_flg+0x35>
     f5f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     f66:	e8 00 00 00 00       	call   f6b <mm_alloc_pm_flg+0x41>
     f6b:	fa                   	cli
     f6c:	f4                   	hlt
     f6d:	eb fd                	jmp    f6c <mm_alloc_pm_flg+0x42>

0000000000000f6f <psr.0>:

void pmue_set_range(struct pmue* e, uint16_t start, uint16_t end, int unset, int is_rcp)
{
		/* we also have to consider the values at the fringes,
		 * as start & end don't have to be perfectly aligned. */
		void psr(uint32_t* lv, uint32_t* pr, uint16_t div, uint16_t div2) {
     f6f:	55                   	push   rbp
     f70:	48 89 e5             	mov    rbp,rsp
     f73:	48 83 ec 50          	sub    rsp,0x50
     f77:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     f7b:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
     f7f:	89 c8                	mov    eax,ecx
     f81:	66 89 55 bc          	mov    WORD PTR [rbp-0x44],dx
     f85:	66 89 45 b8          	mov    WORD PTR [rbp-0x48],ax
     f89:	4c 89 d6             	mov    rsi,r10
     f8c:	4c 89 55 b0          	mov    QWORD PTR [rbp-0x50],r10
				uint16_t i, j;
				if (pr) { /* align start & end to boundaries and set fringe values */
     f90:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
     f95:	74 30                	je     fc7 <psr.0+0x58>
						die("fringes!\n"); /* TODO: fix it */
     f97:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f9e:	bf 0c 00 00 00       	mov    edi,0xc
     fa3:	b8 00 00 00 00       	mov    eax,0x0
     fa8:	e8 00 00 00 00       	call   fad <psr.0+0x3e>
     fad:	b8 00 00 00 00       	mov    eax,0x0
     fb2:	e8 00 00 00 00       	call   fb7 <psr.0+0x48>
     fb7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     fbe:	e8 00 00 00 00       	call   fc3 <psr.0+0x54>
     fc3:	fa                   	cli
     fc4:	f4                   	hlt
     fc5:	eb fd                	jmp    fc4 <psr.0+0x55>
				}
				for (i = start / div; i <= end / div; i++) {
     fc7:	0f b7 46 06          	movzx  eax,WORD PTR [rsi+0x6]
     fcb:	ba 00 00 00 00       	mov    edx,0x0
     fd0:	66 f7 75 bc          	div    WORD PTR [rbp-0x44]
     fd4:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
     fd8:	e9 d2 02 00 00       	jmp    12af <psr.0+0x340>
						int lwr = (i * div >= start); /* starts at bit0 */
     fdd:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
     fe1:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
     fe5:	0f af d0             	imul   edx,eax
     fe8:	0f b7 46 06          	movzx  eax,WORD PTR [rsi+0x6]
     fec:	0f b7 c0             	movzx  eax,ax
     fef:	39 c2                	cmp    edx,eax
     ff1:	0f 9d c0             	setge  al
     ff4:	0f b6 c0             	movzx  eax,al
     ff7:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
						int hgr = (end - i * div >= div); /* goes until bit 31 */
     ffa:	0f b7 46 04          	movzx  eax,WORD PTR [rsi+0x4]
     ffe:	0f b7 c8             	movzx  ecx,ax
    1001:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    1005:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    1009:	0f af c2             	imul   eax,edx
    100c:	29 c1                	sub    ecx,eax
    100e:	89 ca                	mov    edx,ecx
    1010:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    1014:	39 c2                	cmp    edx,eax
    1016:	0f 9d c0             	setge  al
    1019:	0f b6 c0             	movzx  eax,al
    101c:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
						if (lwr && hgr) {
    101f:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    1023:	74 32                	je     1057 <psr.0+0xe8>
    1025:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    1029:	74 2c                	je     1057 <psr.0+0xe8>
								lv[i] = unset ? 0 : 0xffffffff;
    102b:	8b 06                	mov    eax,DWORD PTR [rsi]
    102d:	85 c0                	test   eax,eax
    102f:	74 07                	je     1038 <psr.0+0xc9>
    1031:	b9 00 00 00 00       	mov    ecx,0x0
    1036:	eb 05                	jmp    103d <psr.0+0xce>
    1038:	b9 ff ff ff ff       	mov    ecx,0xffffffff
    103d:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1041:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1049:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    104d:	48 01 d0             	add    rax,rdx
    1050:	89 08                	mov    DWORD PTR [rax],ecx
								continue;
    1052:	e9 4d 02 00 00       	jmp    12a4 <psr.0+0x335>
						} else if (lwr) {
    1057:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    105b:	0f 84 ac 00 00 00    	je     110d <psr.0+0x19e>
								uint8_t bit = (end - i * div) * 32 / div + 1;
    1061:	0f b7 46 04          	movzx  eax,WORD PTR [rsi+0x4]
    1065:	0f b7 c8             	movzx  ecx,ax
    1068:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    106c:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    1070:	0f af c2             	imul   eax,edx
    1073:	29 c1                	sub    ecx,eax
    1075:	89 ca                	mov    edx,ecx
    1077:	89 d0                	mov    eax,edx
    1079:	c1 e0 05             	shl    eax,0x5
    107c:	0f b7 7d bc          	movzx  edi,WORD PTR [rbp-0x44]
    1080:	99                   	cdq
    1081:	f7 ff                	idiv   edi
    1083:	83 c0 01             	add    eax,0x1
    1086:	88 45 db             	mov    BYTE PTR [rbp-0x25],al
								uint32_t mask = (1 << bit) - 1;
    1089:	0f b6 45 db          	movzx  eax,BYTE PTR [rbp-0x25]
    108d:	ba 01 00 00 00       	mov    edx,0x1
    1092:	89 c1                	mov    ecx,eax
    1094:	d3 e2                	shl    edx,cl
    1096:	89 d0                	mov    eax,edx
    1098:	83 e8 01             	sub    eax,0x1
    109b:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
								lv[i] &= ~mask;
    109e:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    10a2:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    10aa:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10ae:	48 01 d0             	add    rax,rdx
    10b1:	8b 10                	mov    edx,DWORD PTR [rax]
    10b3:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    10b6:	f7 d0                	not    eax
    10b8:	89 c1                	mov    ecx,eax
    10ba:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    10be:	48 8d 3c 85 00 00 00 00 	lea    rdi,[rax*4+0x0]
    10c6:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10ca:	48 01 f8             	add    rax,rdi
    10cd:	21 ca                	and    edx,ecx
    10cf:	89 10                	mov    DWORD PTR [rax],edx
								if (!unset)
    10d1:	8b 06                	mov    eax,DWORD PTR [rsi]
    10d3:	85 c0                	test   eax,eax
    10d5:	0f 85 c9 01 00 00    	jne    12a4 <psr.0+0x335>
										lv[i] |= mask;
    10db:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    10df:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    10e7:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10eb:	48 01 d0             	add    rax,rdx
    10ee:	8b 00                	mov    eax,DWORD PTR [rax]
    10f0:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    10f4:	48 8d 0c 95 00 00 00 00 	lea    rcx,[rdx*4+0x0]
    10fc:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1100:	48 01 ca             	add    rdx,rcx
    1103:	0b 45 d4             	or     eax,DWORD PTR [rbp-0x2c]
    1106:	89 02                	mov    DWORD PTR [rdx],eax
    1108:	e9 97 01 00 00       	jmp    12a4 <psr.0+0x335>
						} else if (hgr) {
    110d:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    1111:	0f 84 a8 00 00 00    	je     11bf <psr.0+0x250>
								uint8_t bit = (start - i * div) * 32 / div;
    1117:	0f b7 46 06          	movzx  eax,WORD PTR [rsi+0x6]
    111b:	0f b7 c8             	movzx  ecx,ax
    111e:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    1122:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    1126:	0f af c2             	imul   eax,edx
    1129:	29 c1                	sub    ecx,eax
    112b:	89 ca                	mov    edx,ecx
    112d:	89 d0                	mov    eax,edx
    112f:	c1 e0 05             	shl    eax,0x5
    1132:	0f b7 7d bc          	movzx  edi,WORD PTR [rbp-0x44]
    1136:	99                   	cdq
    1137:	f7 ff                	idiv   edi
    1139:	88 45 e3             	mov    BYTE PTR [rbp-0x1d],al
								uint32_t mask = ~((1 << bit) - 1);
    113c:	0f b6 45 e3          	movzx  eax,BYTE PTR [rbp-0x1d]
    1140:	ba 01 00 00 00       	mov    edx,0x1
    1145:	89 c1                	mov    ecx,eax
    1147:	d3 e2                	shl    edx,cl
    1149:	89 d0                	mov    eax,edx
    114b:	f7 d8                	neg    eax
    114d:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
								lv[i] &= ~mask;
    1150:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1154:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    115c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1160:	48 01 d0             	add    rax,rdx
    1163:	8b 10                	mov    edx,DWORD PTR [rax]
    1165:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1168:	f7 d0                	not    eax
    116a:	89 c1                	mov    ecx,eax
    116c:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1170:	48 8d 3c 85 00 00 00 00 	lea    rdi,[rax*4+0x0]
    1178:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    117c:	48 01 f8             	add    rax,rdi
    117f:	21 ca                	and    edx,ecx
    1181:	89 10                	mov    DWORD PTR [rax],edx
								if (!unset)
    1183:	8b 06                	mov    eax,DWORD PTR [rsi]
    1185:	85 c0                	test   eax,eax
    1187:	0f 85 17 01 00 00    	jne    12a4 <psr.0+0x335>
										lv[i] |= mask;
    118d:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1191:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1199:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    119d:	48 01 d0             	add    rax,rdx
    11a0:	8b 00                	mov    eax,DWORD PTR [rax]
    11a2:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    11a6:	48 8d 0c 95 00 00 00 00 	lea    rcx,[rdx*4+0x0]
    11ae:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    11b2:	48 01 ca             	add    rdx,rcx
    11b5:	0b 45 dc             	or     eax,DWORD PTR [rbp-0x24]
    11b8:	89 02                	mov    DWORD PTR [rdx],eax
    11ba:	e9 e5 00 00 00       	jmp    12a4 <psr.0+0x335>
						} else {
								/* in-between */
								uint8_t b1 = (end - i * div) * 32 / div + 1;
    11bf:	0f b7 46 04          	movzx  eax,WORD PTR [rsi+0x4]
    11c3:	0f b7 c8             	movzx  ecx,ax
    11c6:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    11ca:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    11ce:	0f af c2             	imul   eax,edx
    11d1:	29 c1                	sub    ecx,eax
    11d3:	89 ca                	mov    edx,ecx
    11d5:	89 d0                	mov    eax,edx
    11d7:	c1 e0 05             	shl    eax,0x5
    11da:	0f b7 7d bc          	movzx  edi,WORD PTR [rbp-0x44]
    11de:	99                   	cdq
    11df:	f7 ff                	idiv   edi
    11e1:	83 c0 01             	add    eax,0x1
    11e4:	88 45 f3             	mov    BYTE PTR [rbp-0xd],al
								uint8_t b2 = (start - i * div) * 32 / div;
    11e7:	0f b7 46 06          	movzx  eax,WORD PTR [rsi+0x6]
    11eb:	0f b7 c8             	movzx  ecx,ax
    11ee:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    11f2:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
    11f6:	0f af c2             	imul   eax,edx
    11f9:	29 c1                	sub    ecx,eax
    11fb:	89 ca                	mov    edx,ecx
    11fd:	89 d0                	mov    eax,edx
    11ff:	c1 e0 05             	shl    eax,0x5
    1202:	0f b7 7d bc          	movzx  edi,WORD PTR [rbp-0x44]
    1206:	99                   	cdq
    1207:	f7 ff                	idiv   edi
    1209:	88 45 f2             	mov    BYTE PTR [rbp-0xe],al
								uint32_t m1 = (1 << b1) - 1;
    120c:	0f b6 45 f3          	movzx  eax,BYTE PTR [rbp-0xd]
    1210:	ba 01 00 00 00       	mov    edx,0x1
    1215:	89 c1                	mov    ecx,eax
    1217:	d3 e2                	shl    edx,cl
    1219:	89 d0                	mov    eax,edx
    121b:	83 e8 01             	sub    eax,0x1
    121e:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
								uint32_t m2 = ~((1 << b2) - 1);
    1221:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe]
    1225:	ba 01 00 00 00       	mov    edx,0x1
    122a:	89 c1                	mov    ecx,eax
    122c:	d3 e2                	shl    edx,cl
    122e:	89 d0                	mov    eax,edx
    1230:	f7 d8                	neg    eax
    1232:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
								uint32_t mask = m1 & m2;
    1235:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1238:	23 45 e8             	and    eax,DWORD PTR [rbp-0x18]
    123b:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
								lv[i] &= ~mask;
    123e:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    1242:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    124a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    124e:	48 01 d0             	add    rax,rdx
    1251:	8b 10                	mov    edx,DWORD PTR [rax]
    1253:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1256:	f7 d0                	not    eax
    1258:	89 c1                	mov    ecx,eax
    125a:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    125e:	48 8d 3c 85 00 00 00 00 	lea    rdi,[rax*4+0x0]
    1266:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    126a:	48 01 f8             	add    rax,rdi
    126d:	21 ca                	and    edx,ecx
    126f:	89 10                	mov    DWORD PTR [rax],edx
								if (!unset)
    1271:	8b 06                	mov    eax,DWORD PTR [rsi]
    1273:	85 c0                	test   eax,eax
    1275:	75 2d                	jne    12a4 <psr.0+0x335>
										lv[i] |= mask;
    1277:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    127b:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1283:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1287:	48 01 d0             	add    rax,rdx
    128a:	8b 00                	mov    eax,DWORD PTR [rax]
    128c:	0f b7 55 fe          	movzx  edx,WORD PTR [rbp-0x2]
    1290:	48 8d 0c 95 00 00 00 00 	lea    rcx,[rdx*4+0x0]
    1298:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    129c:	48 01 ca             	add    rdx,rcx
    129f:	0b 45 e4             	or     eax,DWORD PTR [rbp-0x1c]
    12a2:	89 02                	mov    DWORD PTR [rdx],eax
				for (i = start / div; i <= end / div; i++) {
    12a4:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    12a8:	83 c0 01             	add    eax,0x1
    12ab:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
    12af:	0f b7 46 04          	movzx  eax,WORD PTR [rsi+0x4]
    12b3:	ba 00 00 00 00       	mov    edx,0x0
    12b8:	66 f7 75 bc          	div    WORD PTR [rbp-0x44]
    12bc:	66 3b 45 fe          	cmp    ax,WORD PTR [rbp-0x2]
    12c0:	0f 83 17 fd ff ff    	jae    fdd <psr.0+0x6e>
						}
				}
		}
    12c6:	90                   	nop
    12c7:	90                   	nop
    12c8:	c9                   	leave
    12c9:	c3                   	ret

00000000000012ca <pmue_set_range>:
{
    12ca:	55                   	push   rbp
    12cb:	48 89 e5             	mov    rbp,rsp
    12ce:	48 83 ec 30          	sub    rsp,0x30
    12d2:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    12d6:	89 d0                	mov    eax,edx
    12d8:	89 4d dc             	mov    DWORD PTR [rbp-0x24],ecx
    12db:	44 89 45 d8          	mov    DWORD PTR [rbp-0x28],r8d
    12df:	89 f2                	mov    edx,esi
    12e1:	66 89 55 e4          	mov    WORD PTR [rbp-0x1c],dx
    12e5:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
void pmue_set_range(struct pmue* e, uint16_t start, uint16_t end, int unset, int is_rcp)
    12e9:	48 8d 45 10          	lea    rax,[rbp+0x10]
    12ed:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    12f1:	0f b7 45 e4          	movzx  eax,WORD PTR [rbp-0x1c]
    12f5:	66 89 45 f6          	mov    WORD PTR [rbp-0xa],ax
    12f9:	0f b7 45 e0          	movzx  eax,WORD PTR [rbp-0x20]
    12fd:	66 89 45 f4          	mov    WORD PTR [rbp-0xc],ax
    1301:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1304:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
		psr(e->lvl0, NULL, 32, 0);
    1307:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    130b:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    130f:	49 89 d2             	mov    r10,rdx
    1312:	b9 00 00 00 00       	mov    ecx,0x0
    1317:	ba 20 00 00 00       	mov    edx,0x20
    131c:	be 00 00 00 00       	mov    esi,0x0
    1321:	48 89 c7             	mov    rdi,rax
    1324:	e8 46 fc ff ff       	call   f6f <psr.0>
		if (!is_rcp)
    1329:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    132d:	75 28                	jne    1357 <pmue_set_range+0x8d>
				psr(e->lvl1, e->lvl0, 64, 32);
    132f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1333:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1337:	48 8d ba 00 02 00 00 	lea    rdi,[rdx+0x200]
    133e:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    1342:	49 89 d2             	mov    r10,rdx
    1345:	b9 20 00 00 00       	mov    ecx,0x20
    134a:	ba 40 00 00 00       	mov    edx,0x40
    134f:	48 89 c6             	mov    rsi,rax
    1352:	e8 18 fc ff ff       	call   f6f <psr.0>
		psr(e->lvl2, is_rcp ? e->lvl0 : e->lvl1, 128, is_rcp ? 32 : 64);
    1357:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    135b:	74 07                	je     1364 <pmue_set_range+0x9a>
    135d:	b9 20 00 00 00       	mov    ecx,0x20
    1362:	eb 05                	jmp    1369 <pmue_set_range+0x9f>
    1364:	b9 40 00 00 00       	mov    ecx,0x40
    1369:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    136d:	74 06                	je     1375 <pmue_set_range+0xab>
    136f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1373:	eb 0a                	jmp    137f <pmue_set_range+0xb5>
    1375:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1379:	48 05 00 02 00 00    	add    rax,0x200
    137f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1383:	48 8d ba 00 03 00 00 	lea    rdi,[rdx+0x300]
    138a:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    138e:	49 89 d2             	mov    r10,rdx
    1391:	ba 80 00 00 00       	mov    edx,0x80
    1396:	48 89 c6             	mov    rsi,rax
    1399:	e8 d1 fb ff ff       	call   f6f <psr.0>
		if (!is_rcp) {
    139e:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    13a2:	0f 85 b8 00 00 00    	jne    1460 <pmue_set_range+0x196>
				psr(e->lvl3, e->lvl2, 256, 128);
    13a8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13ac:	48 8d b0 00 03 00 00 	lea    rsi,[rax+0x300]
    13b3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13b7:	48 05 80 03 00 00    	add    rax,0x380
    13bd:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    13c1:	49 89 d2             	mov    r10,rdx
    13c4:	b9 80 00 00 00       	mov    ecx,0x80
    13c9:	ba 00 01 00 00       	mov    edx,0x100
    13ce:	48 89 c7             	mov    rdi,rax
    13d1:	e8 99 fb ff ff       	call   f6f <psr.0>
				psr(e->lvl4, e->lvl3, 512, 256);
    13d6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13da:	48 8d b0 80 03 00 00 	lea    rsi,[rax+0x380]
    13e1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13e5:	48 05 c0 03 00 00    	add    rax,0x3c0
    13eb:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    13ef:	49 89 d2             	mov    r10,rdx
    13f2:	b9 00 01 00 00       	mov    ecx,0x100
    13f7:	ba 00 02 00 00       	mov    edx,0x200
    13fc:	48 89 c7             	mov    rdi,rax
    13ff:	e8 6b fb ff ff       	call   f6f <psr.0>
				psr(e->lvl5, e->lvl4, 1024, 512);
    1404:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1408:	48 8d b0 c0 03 00 00 	lea    rsi,[rax+0x3c0]
    140f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1413:	48 05 e0 03 00 00    	add    rax,0x3e0
    1419:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    141d:	49 89 d2             	mov    r10,rdx
    1420:	b9 00 02 00 00       	mov    ecx,0x200
    1425:	ba 00 04 00 00       	mov    edx,0x400
    142a:	48 89 c7             	mov    rdi,rax
    142d:	e8 3d fb ff ff       	call   f6f <psr.0>
				psr(e->lvl6, e->lvl5, 2048, 1024);
    1432:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1436:	48 8d b0 e0 03 00 00 	lea    rsi,[rax+0x3e0]
    143d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1441:	48 05 f0 03 00 00    	add    rax,0x3f0
    1447:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    144b:	49 89 d2             	mov    r10,rdx
    144e:	b9 00 04 00 00       	mov    ecx,0x400
    1453:	ba 00 08 00 00       	mov    edx,0x800
    1458:	48 89 c7             	mov    rdi,rax
    145b:	e8 0f fb ff ff       	call   f6f <psr.0>
		}
		psr(&e->lvl7, is_rcp ? e->lvl2 : e->lvl6, 4096, is_rcp ? 128 : 2048);
    1460:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    1464:	74 07                	je     146d <pmue_set_range+0x1a3>
    1466:	b9 80 00 00 00       	mov    ecx,0x80
    146b:	eb 05                	jmp    1472 <pmue_set_range+0x1a8>
    146d:	b9 00 08 00 00       	mov    ecx,0x800
    1472:	83 7d d8 00          	cmp    DWORD PTR [rbp-0x28],0x0
    1476:	74 0c                	je     1484 <pmue_set_range+0x1ba>
    1478:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    147c:	48 05 00 03 00 00    	add    rax,0x300
    1482:	eb 0a                	jmp    148e <pmue_set_range+0x1c4>
    1484:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1488:	48 05 f0 03 00 00    	add    rax,0x3f0
    148e:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1492:	48 8d ba f8 03 00 00 	lea    rdi,[rdx+0x3f8]
    1499:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
    149d:	49 89 d2             	mov    r10,rdx
    14a0:	ba 00 10 00 00       	mov    edx,0x1000
    14a5:	48 89 c6             	mov    rsi,rax
    14a8:	e8 c2 fa ff ff       	call   f6f <psr.0>
}
    14ad:	90                   	nop
    14ae:	c9                   	leave
    14af:	c3                   	ret

00000000000014b0 <pmu_set_range>:

/* rcp: 7,2,0 set if any below; pmu all, set if all below are used */
void pmu_set_range(struct pmu* pm, uint16_t start, uint16_t end, int unset, int is_rcp)
{
    14b0:	55                   	push   rbp
    14b1:	48 89 e5             	mov    rbp,rsp
    14b4:	48 83 ec 40          	sub    rsp,0x40
    14b8:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    14bc:	89 d0                	mov    eax,edx
    14be:	89 4d cc             	mov    DWORD PTR [rbp-0x34],ecx
    14c1:	44 89 45 c8          	mov    DWORD PTR [rbp-0x38],r8d
    14c5:	89 f2                	mov    edx,esi
    14c7:	66 89 55 d4          	mov    WORD PTR [rbp-0x2c],dx
    14cb:	66 89 45 d0          	mov    WORD PTR [rbp-0x30],ax
		struct pmue* e; uint16_t fc = 0;
    14cf:	66 c7 45 fe 00 00    	mov    WORD PTR [rbp-0x2],0x0
		/* we have to lock for keeping higher levels consistent 
		 * else we could do without as we own the ranges exclusively. */

redo:
		/* lock is 64 bit wide 4x16 (2 lvl7 bits per bit) */
		for (uint16_t i = start / 256; i <= end / 256; i++) {
    14d5:	0f b7 45 d4          	movzx  eax,WORD PTR [rbp-0x2c]
    14d9:	66 c1 e8 08          	shr    ax,0x8
    14dd:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
    14e1:	e9 2b 01 00 00       	jmp    1611 <pmu_set_range+0x161>
				uint16_t o = i * 256, p1, p2;
    14e6:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    14ea:	c1 e0 08             	shl    eax,0x8
    14ed:	66 89 45 fa          	mov    WORD PTR [rbp-0x6],ax
				e = pm->entries + i / 16;
    14f1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    14f5:	48 8d 48 10          	lea    rcx,[rax+0x10]
    14f9:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    14fd:	66 c1 e8 04          	shr    ax,0x4
    1501:	0f b7 d0             	movzx  edx,ax
    1504:	48 89 d0             	mov    rax,rdx
    1507:	48 c1 e0 08          	shl    rax,0x8
    150b:	48 29 d0             	sub    rax,rdx
    150e:	48 c1 e0 02          	shl    rax,0x2
    1512:	48 01 c8             	add    rax,rcx
    1515:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				/* first check if we can skip */
				if (is_rcp) {
    1519:	83 7d c8 00          	cmp    DWORD PTR [rbp-0x38],0x0
    151d:	74 2b                	je     154a <pmu_set_range+0x9a>
						if (unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
    151f:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    1523:	74 4f                	je     1574 <pmu_set_range+0xc4>
    1525:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1529:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [rax+0x3f8]
    152f:	0f b7 55 fc          	movzx  edx,WORD PTR [rbp-0x4]
    1533:	83 e2 0f             	and    edx,0xf
    1536:	be 03 00 00 00       	mov    esi,0x3
    153b:	89 d1                	mov    ecx,edx
    153d:	d3 e6                	shl    esi,cl
    153f:	89 f2                	mov    edx,esi
    1541:	39 d0                	cmp    eax,edx
    1543:	75 2f                	jne    1574 <pmu_set_range+0xc4>
								continue; /* unsafe as lock was not
    1545:	e9 bc 00 00 00       	jmp    1606 <pmu_set_range+0x156>
						 * checked (could be set concurrently). But 
						 * this is not relevant as it'd be user error. */
				} else {
						if (!unset && (e->lvl7 ^ (3 << (i % 16))) == 0)
    154a:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    154e:	75 24                	jne    1574 <pmu_set_range+0xc4>
    1550:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1554:	8b 80 f8 03 00 00    	mov    eax,DWORD PTR [rax+0x3f8]
    155a:	0f b7 55 fc          	movzx  edx,WORD PTR [rbp-0x4]
    155e:	83 e2 0f             	and    edx,0xf
    1561:	be 03 00 00 00       	mov    esi,0x3
    1566:	89 d1                	mov    ecx,edx
    1568:	d3 e6                	shl    esi,cl
    156a:	89 f2                	mov    edx,esi
    156c:	39 d0                	cmp    eax,edx
    156e:	0f 84 91 00 00 00    	je     1605 <pmu_set_range+0x155>
								continue; /* already all set */
				}

				/* then try to acquire the lock */
				asm goto("lock bts %0, %1\n"
					"jc %l2\n" : : "r" (2 * i),
    1574:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    1578:	8d 14 00             	lea    edx,[rax+rax*1]
				asm goto("lock bts %0, %1\n"
    157b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    157f:	f0 0f ab 10          	lock bts DWORD PTR [rax],edx
    1583:	72 73                	jb     15f8 <pmu_set_range+0x148>
					"m" (*pm->locks) : "cc" : carry);
				/* calculate the range */
				p1 = max(o, start);
    1585:	0f b7 55 d4          	movzx  edx,WORD PTR [rbp-0x2c]
    1589:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
    158d:	66 39 c2             	cmp    dx,ax
    1590:	0f 43 c2             	cmovae eax,edx
    1593:	66 89 45 ee          	mov    WORD PTR [rbp-0x12],ax
				p2 = min(o + 256, end);
    1597:	0f b7 55 d0          	movzx  edx,WORD PTR [rbp-0x30]
    159b:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
    159f:	05 00 01 00 00       	add    eax,0x100
    15a4:	39 c2                	cmp    edx,eax
    15a6:	0f 4e c2             	cmovle eax,edx
    15a9:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
				p1 -= (i / 4) * 4096;
    15ad:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    15b1:	66 c1 e8 02          	shr    ax,0x2
    15b5:	c1 e0 0c             	shl    eax,0xc
    15b8:	66 29 45 ee          	sub    WORD PTR [rbp-0x12],ax
				p2 -= (i / 4) * 4096;
    15bc:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    15c0:	66 c1 e8 02          	shr    ax,0x2
    15c4:	c1 e0 0c             	shl    eax,0xc
    15c7:	66 29 45 ec          	sub    WORD PTR [rbp-0x14],ax
				/* we now hold the lock so modify the acutal entry */
				pmue_set_range(e, p1, p2, unset, is_rcp);
    15cb:	0f b7 55 ec          	movzx  edx,WORD PTR [rbp-0x14]
    15cf:	0f b7 75 ee          	movzx  esi,WORD PTR [rbp-0x12]
    15d3:	8b 7d c8             	mov    edi,DWORD PTR [rbp-0x38]
    15d6:	8b 4d cc             	mov    ecx,DWORD PTR [rbp-0x34]
    15d9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    15dd:	41 89 f8             	mov    r8d,edi
    15e0:	48 89 c7             	mov    rdi,rax
    15e3:	e8 00 00 00 00       	call   15e8 <pmu_set_range+0x138>

				/* release it */
				asm("btr %0, %1\n" : : "r" (2 * i),
    15e8:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    15ec:	8d 14 00             	lea    edx,[rax+rax*1]
    15ef:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    15f3:	0f b3 10             	btr    DWORD PTR [rax],edx
					"m" (*pm->locks) : "cc");
				continue;
    15f6:	eb 0e                	jmp    1606 <pmu_set_range+0x156>

carry: 			/* lock failed */
				fc++; /* set failure count and continue (retry later) */
    15f8:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
    15fc:	83 c0 01             	add    eax,0x1
    15ff:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
    1603:	eb 01                	jmp    1606 <pmu_set_range+0x156>
								continue; /* already all set */
    1605:	90                   	nop
		for (uint16_t i = start / 256; i <= end / 256; i++) {
    1606:	0f b7 45 fc          	movzx  eax,WORD PTR [rbp-0x4]
    160a:	83 c0 01             	add    eax,0x1
    160d:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
    1611:	0f b7 45 d0          	movzx  eax,WORD PTR [rbp-0x30]
    1615:	66 c1 e8 08          	shr    ax,0x8
    1619:	66 3b 45 fc          	cmp    ax,WORD PTR [rbp-0x4]
    161d:	0f 83 c3 fe ff ff    	jae    14e6 <pmu_set_range+0x36>
		}

		if (fc) { /* busy loop as these locks are held for ns */
    1623:	66 83 7d fe 00       	cmp    WORD PTR [rbp-0x2],0x0
    1628:	74 0b                	je     1635 <pmu_set_range+0x185>
				fc = 0;
    162a:	66 c7 45 fe 00 00    	mov    WORD PTR [rbp-0x2],0x0
				goto redo;
    1630:	e9 a0 fe ff ff       	jmp    14d5 <pmu_set_range+0x25>
		}
}
    1635:	90                   	nop
    1636:	c9                   	leave
    1637:	c3                   	ret

0000000000001638 <mm_free_pm>:

void mm_free_pm(struct page_range* pr, uint32_t pr_ct)
{
    1638:	55                   	push   rbp
    1639:	48 89 e5             	mov    rbp,rsp
    163c:	48 83 ec 60          	sub    rsp,0x60
    1640:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    1644:	89 75 a4             	mov    DWORD PTR [rbp-0x5c],esi
		for (uint32_t i = 0; i < pr_ct; i++) {
    1647:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    164e:	e9 61 01 00 00       	jmp    17b4 <mm_free_pm+0x17c>
				struct fme* fm; struct pmu* rc;
				uint64_t ofs, fp, lp;
				for (fm = fmm + fm_begin; fm < fmm + fm_ofs; fm++)
    1653:	b9 00 40 02 00       	mov    ecx,0x24000
    1658:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 165f <mm_free_pm+0x27>
    165f:	48 89 d0             	mov    rax,rdx
    1662:	48 c1 e0 03          	shl    rax,0x3
    1666:	48 29 d0             	sub    rax,rdx
    1669:	48 c1 e0 03          	shl    rax,0x3
    166d:	48 01 c8             	add    rax,rcx
    1670:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    1674:	eb 36                	jmp    16ac <mm_free_pm+0x74>
						if (pr->base >= fm->base && pr->base < fm->base + fm->size)
    1676:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    167a:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    167d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1681:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1684:	48 39 c2             	cmp    rdx,rax
    1687:	72 1e                	jb     16a7 <mm_free_pm+0x6f>
    1689:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    168d:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1690:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1694:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1697:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    169b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    169f:	48 01 c8             	add    rax,rcx
    16a2:	48 39 c2             	cmp    rdx,rax
    16a5:	72 2a                	jb     16d1 <mm_free_pm+0x99>
				for (fm = fmm + fm_begin; fm < fmm + fm_ofs; fm++)
    16a7:	48 83 45 f0 38       	add    QWORD PTR [rbp-0x10],0x38
    16ac:	b9 00 40 02 00       	mov    ecx,0x24000
    16b1:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 16b8 <mm_free_pm+0x80>
    16b8:	48 89 d0             	mov    rax,rdx
    16bb:	48 c1 e0 03          	shl    rax,0x3
    16bf:	48 29 d0             	sub    rax,rdx
    16c2:	48 c1 e0 03          	shl    rax,0x3
    16c6:	48 01 c8             	add    rax,rcx
    16c9:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    16cd:	72 a7                	jb     1676 <mm_free_pm+0x3e>
    16cf:	eb 01                	jmp    16d2 <mm_free_pm+0x9a>
								break; /* just assume integrity */
    16d1:	90                   	nop
				ofs = pr->base - fm->base;
    16d2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    16d6:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    16d9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    16dd:	48 8b 00             	mov    rax,QWORD PTR [rax]
    16e0:	48 29 c2             	sub    rdx,rax
    16e3:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
				rc = (struct pmu*)fm->rcp;
    16e7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    16eb:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    16ef:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				/* set first and last page */
				fp = ofs / 4096;
    16f3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    16f7:	48 c1 e8 0c          	shr    rax,0xc
    16fb:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
				lp = fp + pr->count - 1;
    16ff:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1703:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    1707:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    170b:	48 01 d0             	add    rax,rdx
    170e:	48 83 e8 01          	sub    rax,0x1
    1712:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax

				for (uint32_t idx = fp / 4096 / 4; idx <= lp / 4096 / 4; idx++) {
    1716:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    171a:	48 c1 e8 0e          	shr    rax,0xe
    171e:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
    1721:	eb 79                	jmp    179c <mm_free_pm+0x164>
						uint16_t s, e; uint64_t o = idx * 4096 * 4;
    1723:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1726:	c1 e0 0e             	shl    eax,0xe
    1729:	89 c0                	mov    eax,eax
    172b:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
						/* get the limits */
						s = (fp > o ? fp - o : 0);
    172f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1733:	48 39 45 c0          	cmp    QWORD PTR [rbp-0x40],rax
    1737:	73 12                	jae    174b <mm_free_pm+0x113>
    1739:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    173d:	89 c2                	mov    edx,eax
    173f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1743:	89 c1                	mov    ecx,eax
    1745:	89 d0                	mov    eax,edx
    1747:	29 c8                	sub    eax,ecx
    1749:	eb 05                	jmp    1750 <mm_free_pm+0x118>
    174b:	b8 00 00 00 00       	mov    eax,0x0
    1750:	66 89 45 be          	mov    WORD PTR [rbp-0x42],ax
						e = max(lp - o, 4096 * 4 - 1);
    1754:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1758:	48 2b 45 c0          	sub    rax,QWORD PTR [rbp-0x40]
    175c:	ba ff 3f 00 00       	mov    edx,0x3fff
    1761:	48 39 d0             	cmp    rax,rdx
    1764:	48 0f 42 c2          	cmovb  rax,rdx
    1768:	66 89 45 bc          	mov    WORD PTR [rbp-0x44],ax
						/* set the rcp */
						pmu_set_range(&rc[idx], s, e, 0, 1);
    176c:	0f b7 55 bc          	movzx  edx,WORD PTR [rbp-0x44]
    1770:	0f b7 45 be          	movzx  eax,WORD PTR [rbp-0x42]
    1774:	8b 4d ec             	mov    ecx,DWORD PTR [rbp-0x14]
    1777:	48 89 ce             	mov    rsi,rcx
    177a:	48 c1 e6 0c          	shl    rsi,0xc
    177e:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
    1782:	48 8d 3c 0e          	lea    rdi,[rsi+rcx*1]
    1786:	41 b8 01 00 00 00    	mov    r8d,0x1
    178c:	b9 00 00 00 00       	mov    ecx,0x0
    1791:	89 c6                	mov    esi,eax
    1793:	e8 00 00 00 00       	call   1798 <mm_free_pm+0x160>
				for (uint32_t idx = fp / 4096 / 4; idx <= lp / 4096 / 4; idx++) {
    1798:	83 45 ec 01          	add    DWORD PTR [rbp-0x14],0x1
    179c:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    179f:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    17a3:	48 c1 ea 0e          	shr    rdx,0xe
    17a7:	48 39 c2             	cmp    rdx,rax
    17aa:	0f 83 73 ff ff ff    	jae    1723 <mm_free_pm+0xeb>
		for (uint32_t i = 0; i < pr_ct; i++) {
    17b0:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    17b4:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    17b7:	3b 45 a4             	cmp    eax,DWORD PTR [rbp-0x5c]
    17ba:	0f 82 93 fe ff ff    	jb     1653 <mm_free_pm+0x1b>
				}
		}
}
    17c0:	90                   	nop
    17c1:	90                   	nop
    17c2:	c9                   	leave
    17c3:	c3                   	ret

00000000000017c4 <mm_create_ctx>:
void *cur_pmu = VM_PMU_BASE, *cur_rcp = VM_RCP_BASE;
void* cur_percpu = VM_MM_PER_CPU_BASE;
struct mm mm_kernel; uint64_t pm_count = 0;

struct mm_cpu_ctx mm_create_ctx()
{
    17c4:	55                   	push   rbp
    17c5:	48 89 e5             	mov    rbp,rsp
    17c8:	48 83 ec 10          	sub    rsp,0x10
		struct mm_cpu_ctx rv = {0};
    17cc:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    17d4:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		rv.cur_mm = &mm_kernel;
    17dc:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		rv.scrub_page = __sync_fetch_and_add(&cur_percpu, 4096);
    17e4:	b8 00 10 00 00       	mov    eax,0x1000
    17e9:	f0 48 0f c1 05 00 00 00 00 	lock xadd QWORD PTR [rip+0x0],rax        # 17f2 <mm_create_ctx+0x2e>
    17f2:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (cur_percpu >= VM_MM_PER_CPU_LIMIT) {
    17f6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17fd <mm_create_ctx+0x39>
    17fd:	48 3d ff ff ff fb    	cmp    rax,0xfffffffffbffffff
    1803:	76 30                	jbe    1835 <mm_create_ctx+0x71>
				die("Out of MM percpu context slots.\n");
    1805:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    180c:	bf 0c 00 00 00       	mov    edi,0xc
    1811:	b8 00 00 00 00       	mov    eax,0x0
    1816:	e8 00 00 00 00       	call   181b <mm_create_ctx+0x57>
    181b:	b8 00 00 00 00       	mov    eax,0x0
    1820:	e8 00 00 00 00       	call   1825 <mm_create_ctx+0x61>
    1825:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    182c:	e8 00 00 00 00       	call   1831 <mm_create_ctx+0x6d>
    1831:	fa                   	cli
    1832:	f4                   	hlt
    1833:	eb fd                	jmp    1832 <mm_create_ctx+0x6e>
		}
		return rv;
    1835:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1839:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
}
    183d:	c9                   	leave
    183e:	c3                   	ret

000000000000183f <mm_fm_init>:
/* full mapping & init of high elements */
void mm_fm_init(struct fme* fm)
{
    183f:	55                   	push   rbp
    1840:	48 89 e5             	mov    rbp,rsp
    1843:	48 83 ec 70          	sub    rsp,0x70
    1847:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
		uint64_t b = fm->base - 2 * fm->ec * 4096, b1;
    184b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    184f:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1852:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1856:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    185a:	48 c1 e0 0d          	shl    rax,0xd
    185e:	48 89 c2             	mov    rdx,rax
    1861:	48 89 c8             	mov    rax,rcx
    1864:	48 29 d0             	sub    rax,rdx
    1867:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		uint64_t ec2 = (uint64_t)fm->ec; b1 = b + fm->ec * 4096;
    186b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    186f:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1873:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1877:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    187b:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    187f:	48 c1 e0 0c          	shl    rax,0xc
    1883:	48 89 c2             	mov    rdx,rax
    1886:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    188a:	48 01 d0             	add    rax,rdx
    188d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		struct pmu *p, *r; struct page_range pr; uint16_t rec;
		uint32_t lst = 0;
    1891:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [rbp-0x1c],0x0

		/* get the limit */
		rec = (fm->size / 4096) % 16384;
    1898:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    189c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    18a0:	48 c1 e8 0c          	shr    rax,0xc
    18a4:	66 25 ff 3f          	and    ax,0x3fff
    18a8:	66 89 45 ca          	mov    WORD PTR [rbp-0x36],ax
		if (rec)
    18ac:	66 83 7d ca 00       	cmp    WORD PTR [rbp-0x36],0x0
    18b1:	74 0f                	je     18c2 <mm_fm_init+0x83>
				lst = (fm->size / 4096) / 16384;
    18b3:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    18b7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    18bb:	48 c1 e8 1a          	shr    rax,0x1a
    18bf:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax

		/* before preemption -> no sync needed */
		fm->pmu = (uint64_t)cur_pmu;
    18c2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18c9 <mm_fm_init+0x8a>
    18c9:	48 89 c2             	mov    rdx,rax
    18cc:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    18d0:	48 89 50 28          	mov    QWORD PTR [rax+0x28],rdx
		fm->rcp = (uint64_t)cur_rcp;
    18d4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18db <mm_fm_init+0x9c>
    18db:	48 89 c2             	mov    rdx,rax
    18de:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    18e2:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		p = cur_pmu; r = cur_rcp;
    18e6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18ed <mm_fm_init+0xae>
    18ed:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    18f1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18f8 <mm_fm_init+0xb9>
    18f8:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
		pm_count += fm->size;
    18fc:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1900:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    1904:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 190b <mm_fm_init+0xcc>
    190b:	48 01 d0             	add    rax,rdx
    190e:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1915 <mm_fm_init+0xd6>
	
		/* cap sizes */
		if ((VM_PMU_LIMIT - cur_pmu < ec2 * 4096)
    1915:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 191c <mm_fm_init+0xdd>
    191c:	48 c7 c2 00 00 00 fd 	mov    rdx,0xfffffffffd000000
    1923:	48 29 c2             	sub    rdx,rax
    1926:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    192a:	48 c1 e0 0c          	shl    rax,0xc
    192e:	48 39 c2             	cmp    rdx,rax
    1931:	72 1e                	jb     1951 <mm_fm_init+0x112>
			|| (VM_RCP_LIMIT - cur_rcp < ec2 * 4096)) {
    1933:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 193a <mm_fm_init+0xfb>
    193a:	48 c7 c2 00 00 00 fe 	mov    rdx,0xfffffffffe000000
    1941:	48 29 c2             	sub    rdx,rax
    1944:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1948:	48 c1 e0 0c          	shl    rax,0xc
    194c:	48 39 c2             	cmp    rdx,rax
    194f:	73 71                	jae    19c2 <mm_fm_init+0x183>
				/* we should cap and inform the user */
				ec2 = (VM_PMU_LIMIT - cur_pmu) / 4096; /* only on PMUs as LIMITS are identical*/
    1951:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1958 <mm_fm_init+0x119>
    1958:	48 c7 c2 00 00 00 fd 	mov    rdx,0xfffffffffd000000
    195f:	48 29 c2             	sub    rdx,rax
    1962:	48 89 d0             	mov    rax,rdx
    1965:	48 8d 90 ff 0f 00 00 	lea    rdx,[rax+0xfff]
    196c:	48 85 c0             	test   rax,rax
    196f:	48 0f 48 c2          	cmovs  rax,rdx
    1973:	48 c1 f8 0c          	sar    rax,0xc
    1977:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
								fm->ec - ec2, (fm->ec - ec2) * 64);
    197b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    197f:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1983:	48 2b 45 e8          	sub    rax,QWORD PTR [rbp-0x18]
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
    1987:	48 c1 e0 06          	shl    rax,0x6
    198b:	48 89 c2             	mov    rdx,rax
								fm->ec - ec2, (fm->ec - ec2) * 64);
    198e:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1992:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
				cprintf(KFMT_WARN, "%llu PMUs discarded -> %lluM of memory lost\n",
    1996:	48 2b 45 e8          	sub    rax,QWORD PTR [rbp-0x18]
    199a:	48 89 d1             	mov    rcx,rdx
    199d:	48 89 c2             	mov    rdx,rax
    19a0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    19a7:	bf 0e 00 00 00       	mov    edi,0xe
    19ac:	b8 00 00 00 00       	mov    eax,0x0
    19b1:	e8 00 00 00 00       	call   19b6 <mm_fm_init+0x177>
				fm->ec = ec2;
    19b6:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    19ba:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    19be:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
		}
		/* and advance */
		cur_pmu += ec2 * 4096;
    19c2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 19c9 <mm_fm_init+0x18a>
    19c9:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    19cd:	48 c1 e2 0c          	shl    rdx,0xc
    19d1:	48 01 d0             	add    rax,rdx
    19d4:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 19db <mm_fm_init+0x19c>
		cur_rcp += ec2 * 4096;
    19db:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 19e2 <mm_fm_init+0x1a3>
    19e2:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    19e6:	48 c1 e2 0c          	shl    rdx,0xc
    19ea:	48 01 d0             	add    rax,rdx
    19ed:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 19f4 <mm_fm_init+0x1b5>

		/* skip completely if neccessary */
		if (!ec2)
    19f4:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    19f9:	0f 84 61 01 00 00    	je     1b60 <mm_fm_init+0x321>
				return;

		/* map & init the pmus */
		pr.base = b;
    19ff:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a03:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		pr.count = ec2;
    1a07:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a0b:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		mm_map(&mm_kernel, p, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
    1a0f:	48 8d 55 a8          	lea    rdx,[rbp-0x58]
    1a13:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1a17:	41 b8 0c 00 00 00    	mov    r8d,0xc
    1a1d:	b9 01 00 00 00       	mov    ecx,0x1
    1a22:	48 89 c6             	mov    rsi,rax
    1a25:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1a2c:	e8 00 00 00 00       	call   1a31 <mm_fm_init+0x1f2>
		pr.base = b1;
    1a31:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1a35:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		pr.count = ec2;
    1a39:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1a3d:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		mm_map(&mm_kernel, r, &pr, 1, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
    1a41:	48 8d 55 a8          	lea    rdx,[rbp-0x58]
    1a45:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1a49:	41 b8 0c 00 00 00    	mov    r8d,0xc
    1a4f:	b9 01 00 00 00       	mov    ecx,0x1
    1a54:	48 89 c6             	mov    rsi,rax
    1a57:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1a5e:	e8 00 00 00 00       	call   1a63 <mm_fm_init+0x224>

		/* now init the leftovers */
		for (uint64_t i = 0; i < ec2; i++) {
    1a63:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    1a6b:	e9 e0 00 00 00       	jmp    1b50 <mm_fm_init+0x311>
				struct pmu* pt = NULL; int rd = 0;
    1a70:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    1a78:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0
				/* check for exception */
				if (b > 0x100000000 - 4096)
    1a7f:	b8 00 f0 ff ff       	mov    eax,0xfffff000
    1a84:	48 3b 45 f8          	cmp    rax,QWORD PTR [rbp-0x8]
    1a88:	73 18                	jae    1aa2 <mm_fm_init+0x263>
						pt = &p[i];
    1a8a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a8e:	48 c1 e0 0c          	shl    rax,0xc
    1a92:	48 89 c2             	mov    rdx,rax
    1a95:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1a99:	48 01 d0             	add    rax,rdx
    1a9c:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    1aa0:	eb 01                	jmp    1aa3 <mm_fm_init+0x264>

redo:
    1aa2:	90                   	nop
				/* initialize */
				if (pt) {
    1aa3:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
    1aa8:	74 5e                	je     1b08 <mm_fm_init+0x2c9>
						/* clear the locks */
						bzero(pt->locks, sizeof(pt->locks));
    1aaa:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1aae:	be 08 00 00 00       	mov    esi,0x8
    1ab3:	48 89 c7             	mov    rdi,rax
    1ab6:	e8 00 00 00 00       	call   1abb <mm_fm_init+0x27c>
						/* invalidate the counts and put rec in the last one */
						pt->free_ct[0] = 0xffff;
    1abb:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1abf:	66 c7 40 08 ff ff    	mov    WORD PTR [rax+0x8],0xffff
						pt->free_ct[1] = 0xffff;
    1ac5:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1ac9:	66 c7 40 0a ff ff    	mov    WORD PTR [rax+0xa],0xffff
						pt->free_ct[2] = 0xffff;
    1acf:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1ad3:	66 c7 40 0c ff ff    	mov    WORD PTR [rax+0xc],0xffff
						if (rec)
    1ad9:	66 83 7d ca 00       	cmp    WORD PTR [rbp-0x36],0x0
    1ade:	74 1e                	je     1afe <mm_fm_init+0x2bf>
								pt->free_ct[3] = (i == lst) ? rec : 0xffff;
    1ae0:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1ae3:	48 39 45 d8          	cmp    QWORD PTR [rbp-0x28],rax
    1ae7:	75 06                	jne    1aef <mm_fm_init+0x2b0>
    1ae9:	0f b7 45 ca          	movzx  eax,WORD PTR [rbp-0x36]
    1aed:	eb 05                	jmp    1af4 <mm_fm_init+0x2b5>
    1aef:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1af4:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1af8:	66 89 42 0e          	mov    WORD PTR [rdx+0xe],ax
    1afc:	eb 0a                	jmp    1b08 <mm_fm_init+0x2c9>
						else
								pt->free_ct[3] = 0xffff;
    1afe:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1b02:	66 c7 40 0e ff ff    	mov    WORD PTR [rax+0xe],0xffff
				}

				/* check for second run */
				if (!rd && (b1 > 0x100000000 - 4096)) {
    1b08:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    1b0c:	75 2d                	jne    1b3b <mm_fm_init+0x2fc>
    1b0e:	b8 00 f0 ff ff       	mov    eax,0xfffff000
    1b13:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    1b17:	73 22                	jae    1b3b <mm_fm_init+0x2fc>
						pt = &r[i];
    1b19:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1b1d:	48 c1 e0 0c          	shl    rax,0xc
    1b21:	48 89 c2             	mov    rdx,rax
    1b24:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1b28:	48 01 d0             	add    rax,rdx
    1b2b:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						rd = 1;
    1b2f:	c7 45 cc 01 00 00 00 	mov    DWORD PTR [rbp-0x34],0x1
						goto redo;
    1b36:	e9 68 ff ff ff       	jmp    1aa3 <mm_fm_init+0x264>
				}

				/* advance */
				b += 4096;
    1b3b:	48 81 45 f8 00 10 00 00 	add    QWORD PTR [rbp-0x8],0x1000
				b1 += 4096;
    1b43:	48 81 45 f0 00 10 00 00 	add    QWORD PTR [rbp-0x10],0x1000
		for (uint64_t i = 0; i < ec2; i++) {
    1b4b:	48 83 45 d8 01       	add    QWORD PTR [rbp-0x28],0x1
    1b50:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1b54:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
    1b58:	0f 82 12 ff ff ff    	jb     1a70 <mm_fm_init+0x231>
    1b5e:	eb 01                	jmp    1b61 <mm_fm_init+0x322>
				return;
    1b60:	90                   	nop
		}
}
    1b61:	c9                   	leave
    1b62:	c3                   	ret

0000000000001b63 <mmgr_reinit>:

void mmgr_reinit()
{
    1b63:	55                   	push   rbp
    1b64:	48 89 e5             	mov    rbp,rsp
    1b67:	48 83 ec 10          	sub    rsp,0x10
		uint32_t* ptr = FM_FREE_MEMORY_MAP;
    1b6b:	48 c7 45 f0 00 40 02 00 	mov    QWORD PTR [rbp-0x10],0x24000
		fm_ofs = ptr[-1];
    1b73:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b77:	48 83 e8 04          	sub    rax,0x4
    1b7b:	8b 00                	mov    eax,DWORD PTR [rax]
    1b7d:	89 c0                	mov    eax,eax
    1b7f:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1b86 <mmgr_reinit+0x23>
		fm_begin = ptr[-2];
    1b86:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b8a:	48 83 e8 08          	sub    rax,0x8
    1b8e:	8b 00                	mov    eax,DWORD PTR [rax]
    1b90:	89 c0                	mov    eax,eax
    1b92:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1b99 <mmgr_reinit+0x36>
		rm_count = ptr[-3];
    1b99:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1b9d:	48 83 e8 0c          	sub    rax,0xc
    1ba1:	8b 00                	mov    eax,DWORD PTR [rax]
    1ba3:	89 c0                	mov    eax,eax
    1ba5:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1bac <mmgr_reinit+0x49>
		pm_zero = *(uint64_t*)(ptr - 5);
    1bac:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1bb0:	48 8b 40 ec          	mov    rax,QWORD PTR [rax-0x14]
    1bb4:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1bbb <mmgr_reinit+0x58>
		mm_kernel.cr3 = *(uint64_t*)(ptr - 7);
    1bbb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1bbf:	48 8b 40 e4          	mov    rax,QWORD PTR [rax-0x1c]
    1bc3:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1bca <mmgr_reinit+0x67>
		mm_kernel.ctx = FM_VIRTUAL_MAPPING;
    1bca:	48 c7 05 00 00 00 00 00 80 02 00 	mov    QWORD PTR [rip+0x0],0x28000        # 1bd5 <mmgr_reinit+0x72>
		mm_kernel.qnd_ptr = VM_QND_BASE;
    1bd5:	48 b8 00 00 00 00 00 f0 ff ff 	movabs rax,0xfffff00000000000
    1bdf:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 1be6 <mmgr_reinit+0x83>
		else
				mf_map = &mm_map32;
#endif

		/* map the pmus & initialize high pmus */
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    1be6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1bed <mmgr_reinit+0x8a>
    1bed:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1bf1:	eb 27                	jmp    1c1a <mmgr_reinit+0xb7>
				mm_fm_init(fmm + i);
    1bf3:	b9 00 40 02 00       	mov    ecx,0x24000
    1bf8:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1bfc:	48 89 d0             	mov    rax,rdx
    1bff:	48 c1 e0 03          	shl    rax,0x3
    1c03:	48 29 d0             	sub    rax,rdx
    1c06:	48 c1 e0 03          	shl    rax,0x3
    1c0a:	48 01 c8             	add    rax,rcx
    1c0d:	48 89 c7             	mov    rdi,rax
    1c10:	e8 00 00 00 00       	call   1c15 <mmgr_reinit+0xb2>
		for (size_t i = fm_begin; i < fm_ofs; i++) {
    1c15:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    1c1a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1c21 <mmgr_reinit+0xbe>
    1c21:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    1c25:	72 cc                	jb     1bf3 <mmgr_reinit+0x90>
		//if (cpu.e_has_nx)
		//		enable_nx();

		/* allocate the heap */
		void init_kernel_heap();
		init_kernel_heap();
    1c27:	b8 00 00 00 00       	mov    eax,0x0
    1c2c:	e8 00 00 00 00       	call   1c31 <mmgr_reinit+0xce>
		void flush_tlb_full();
		flush_tlb_full();
    1c31:	b8 00 00 00 00       	mov    eax,0x0
    1c36:	e8 00 00 00 00       	call   1c3b <mmgr_reinit+0xd8>
}
    1c3b:	90                   	nop
    1c3c:	c9                   	leave
    1c3d:	c3                   	ret

0000000000001c3e <pmue_dump>:

void pmue_dump(struct pmue* pu, int level)
{
    1c3e:	55                   	push   rbp
    1c3f:	48 89 e5             	mov    rbp,rsp
    1c42:	48 83 ec 40          	sub    rsp,0x40
    1c46:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1c4a:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
		size_t i, ne; uint32_t* lv;
		if (level >= 0 && level <= 7) {
    1c4d:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    1c51:	0f 88 ec 01 00 00    	js     1e43 <pmue_dump+0x205>
    1c57:	83 7d d4 07          	cmp    DWORD PTR [rbp-0x2c],0x7
    1c5b:	0f 8f e2 01 00 00    	jg     1e43 <pmue_dump+0x205>
				if (level == 0)
    1c61:	83 7d d4 00          	cmp    DWORD PTR [rbp-0x2c],0x0
    1c65:	75 15                	jne    1c7c <pmue_dump+0x3e>
						(lv = pu->lvl0), ne = 128;
    1c67:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c6b:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1c6f:	48 c7 45 f0 80 00 00 00 	mov    QWORD PTR [rbp-0x10],0x80
				if (level == 0)
    1c77:	e9 d0 00 00 00       	jmp    1d4c <pmue_dump+0x10e>
				else if (level == 1)
    1c7c:	83 7d d4 01          	cmp    DWORD PTR [rbp-0x2c],0x1
    1c80:	75 1b                	jne    1c9d <pmue_dump+0x5f>
						(lv = pu->lvl1), ne = 64;
    1c82:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c86:	48 05 00 02 00 00    	add    rax,0x200
    1c8c:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1c90:	48 c7 45 f0 40 00 00 00 	mov    QWORD PTR [rbp-0x10],0x40
				if (level == 0)
    1c98:	e9 af 00 00 00       	jmp    1d4c <pmue_dump+0x10e>
				else if (level == 2)
    1c9d:	83 7d d4 02          	cmp    DWORD PTR [rbp-0x2c],0x2
    1ca1:	75 1b                	jne    1cbe <pmue_dump+0x80>
						(lv = pu->lvl2), ne = 32;
    1ca3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ca7:	48 05 00 03 00 00    	add    rax,0x300
    1cad:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1cb1:	48 c7 45 f0 20 00 00 00 	mov    QWORD PTR [rbp-0x10],0x20
				if (level == 0)
    1cb9:	e9 8e 00 00 00       	jmp    1d4c <pmue_dump+0x10e>
				else if (level == 3)
    1cbe:	83 7d d4 03          	cmp    DWORD PTR [rbp-0x2c],0x3
    1cc2:	75 18                	jne    1cdc <pmue_dump+0x9e>
						(lv = pu->lvl3), ne = 16;
    1cc4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1cc8:	48 05 80 03 00 00    	add    rax,0x380
    1cce:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1cd2:	48 c7 45 f0 10 00 00 00 	mov    QWORD PTR [rbp-0x10],0x10
				if (level == 0)
    1cda:	eb 70                	jmp    1d4c <pmue_dump+0x10e>
				else if (level == 4)
    1cdc:	83 7d d4 04          	cmp    DWORD PTR [rbp-0x2c],0x4
    1ce0:	75 18                	jne    1cfa <pmue_dump+0xbc>
						(lv = pu->lvl4), ne = 8;
    1ce2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ce6:	48 05 c0 03 00 00    	add    rax,0x3c0
    1cec:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1cf0:	48 c7 45 f0 08 00 00 00 	mov    QWORD PTR [rbp-0x10],0x8
				if (level == 0)
    1cf8:	eb 52                	jmp    1d4c <pmue_dump+0x10e>
				else if (level == 5)
    1cfa:	83 7d d4 05          	cmp    DWORD PTR [rbp-0x2c],0x5
    1cfe:	75 18                	jne    1d18 <pmue_dump+0xda>
						(lv = pu->lvl5), ne = 4;
    1d00:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d04:	48 05 e0 03 00 00    	add    rax,0x3e0
    1d0a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1d0e:	48 c7 45 f0 04 00 00 00 	mov    QWORD PTR [rbp-0x10],0x4
				if (level == 0)
    1d16:	eb 34                	jmp    1d4c <pmue_dump+0x10e>
				else if (level == 6)
    1d18:	83 7d d4 06          	cmp    DWORD PTR [rbp-0x2c],0x6
    1d1c:	75 18                	jne    1d36 <pmue_dump+0xf8>
						(lv = pu->lvl6), ne = 2;
    1d1e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d22:	48 05 f0 03 00 00    	add    rax,0x3f0
    1d28:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1d2c:	48 c7 45 f0 02 00 00 00 	mov    QWORD PTR [rbp-0x10],0x2
				if (level == 0)
    1d34:	eb 16                	jmp    1d4c <pmue_dump+0x10e>
				else
						(lv = &pu->lvl7), ne = 1;
    1d36:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d3a:	48 05 f8 03 00 00    	add    rax,0x3f8
    1d40:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1d44:	48 c7 45 f0 01 00 00 00 	mov    QWORD PTR [rbp-0x10],0x1
				if (level == 0)
    1d4c:	90                   	nop
		} else
				return;
		printf("pmue/rcpe (at %p) lvl%d entries:\n", pu, level);
    1d4d:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    1d50:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1d54:	48 89 c6             	mov    rsi,rax
    1d57:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d5e:	b8 00 00 00 00       	mov    eax,0x0
    1d63:	e8 00 00 00 00       	call   1d68 <pmue_dump+0x12a>
		for (i = 0; i < ne; i += 6) {
    1d68:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    1d70:	e9 be 00 00 00       	jmp    1e33 <pmue_dump+0x1f5>
				if (ne - i >= 6) {
    1d75:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1d79:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    1d7d:	48 83 f8 05          	cmp    rax,0x5
    1d81:	76 5c                	jbe    1ddf <pmue_dump+0x1a1>
						printf("%08x %08x %08x %08x %08x %08x\n",
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d83:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d87:	48 83 c0 14          	add    rax,0x14
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d8b:	8b 30                	mov    esi,DWORD PTR [rax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d8d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d91:	48 83 c0 10          	add    rax,0x10
						printf("%08x %08x %08x %08x %08x %08x\n",
    1d95:	44 8b 00             	mov    r8d,DWORD PTR [rax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1d98:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d9c:	48 83 c0 0c          	add    rax,0xc
						printf("%08x %08x %08x %08x %08x %08x\n",
    1da0:	8b 38                	mov    edi,DWORD PTR [rax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1da2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1da6:	48 83 c0 08          	add    rax,0x8
						printf("%08x %08x %08x %08x %08x %08x\n",
    1daa:	8b 08                	mov    ecx,DWORD PTR [rax]
								lv[0], lv[1], lv[2], lv[3], lv[4], lv[5]);
    1dac:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1db0:	48 83 c0 04          	add    rax,0x4
						printf("%08x %08x %08x %08x %08x %08x\n",
    1db4:	8b 10                	mov    edx,DWORD PTR [rax]
    1db6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1dba:	8b 00                	mov    eax,DWORD PTR [rax]
    1dbc:	89 34 24             	mov    DWORD PTR [rsp],esi
    1dbf:	45 89 c1             	mov    r9d,r8d
    1dc2:	41 89 f8             	mov    r8d,edi
    1dc5:	89 c6                	mov    esi,eax
    1dc7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1dce:	b8 00 00 00 00       	mov    eax,0x0
    1dd3:	e8 00 00 00 00       	call   1dd8 <pmue_dump+0x19a>
						lv += 6;
    1dd8:	48 83 45 e8 18       	add    QWORD PTR [rbp-0x18],0x18
    1ddd:	eb 4f                	jmp    1e2e <pmue_dump+0x1f0>
				} else {
						size_t j;
						for (j = 0; j < ne - i; j++)
    1ddf:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    1de7:	eb 2d                	jmp    1e16 <pmue_dump+0x1d8>
								printf("%08x ", lv[j]);
    1de9:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1ded:	48 8d 14 85 00 00 00 00 	lea    rdx,[rax*4+0x0]
    1df5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1df9:	48 01 d0             	add    rax,rdx
    1dfc:	8b 00                	mov    eax,DWORD PTR [rax]
    1dfe:	89 c6                	mov    esi,eax
    1e00:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e07:	b8 00 00 00 00       	mov    eax,0x0
    1e0c:	e8 00 00 00 00       	call   1e11 <pmue_dump+0x1d3>
						for (j = 0; j < ne - i; j++)
    1e11:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
    1e16:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1e1a:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    1e1e:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
    1e22:	72 c5                	jb     1de9 <pmue_dump+0x1ab>
						putchar('\n');
    1e24:	bf 0a 00 00 00       	mov    edi,0xa
    1e29:	e8 00 00 00 00       	call   1e2e <pmue_dump+0x1f0>
		for (i = 0; i < ne; i += 6) {
    1e2e:	48 83 45 f8 06       	add    QWORD PTR [rbp-0x8],0x6
    1e33:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1e37:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    1e3b:	0f 82 34 ff ff ff    	jb     1d75 <pmue_dump+0x137>
    1e41:	eb 01                	jmp    1e44 <pmue_dump+0x206>
				return;
    1e43:	90                   	nop
				}
		}
}
    1e44:	c9                   	leave
    1e45:	c3                   	ret

0000000000001e46 <pmu_dump>:
void pmu_dump(struct pmu* pu, int level)
{
    1e46:	55                   	push   rbp
    1e47:	48 89 e5             	mov    rbp,rsp
    1e4a:	48 83 ec 20          	sub    rsp,0x20
    1e4e:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1e52:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		printf("dumping pmu/rcp (at %p)\n", pu);
    1e55:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e59:	48 89 c6             	mov    rsi,rax
    1e5c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e63:	b8 00 00 00 00       	mov    eax,0x0
    1e68:	e8 00 00 00 00       	call   1e6d <pmu_dump+0x27>
		for (int i = 0; i < 4; i++)
    1e6d:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    1e74:	eb 30                	jmp    1ea6 <pmu_dump+0x60>
				pmue_dump(&pu->entries[i], level);
    1e76:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1e79:	48 63 d0             	movsxd rdx,eax
    1e7c:	48 89 d0             	mov    rax,rdx
    1e7f:	48 c1 e0 08          	shl    rax,0x8
    1e83:	48 29 d0             	sub    rax,rdx
    1e86:	48 c1 e0 02          	shl    rax,0x2
    1e8a:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1e8e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e92:	48 01 c2             	add    rdx,rax
    1e95:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1e98:	89 c6                	mov    esi,eax
    1e9a:	48 89 d7             	mov    rdi,rdx
    1e9d:	e8 00 00 00 00       	call   1ea2 <pmu_dump+0x5c>
		for (int i = 0; i < 4; i++)
    1ea2:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    1ea6:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
    1eaa:	7e ca                	jle    1e76 <pmu_dump+0x30>
}
    1eac:	90                   	nop
    1ead:	90                   	nop
    1eae:	c9                   	leave
    1eaf:	c3                   	ret

0000000000001eb0 <mm_dump_pmu>:
void mm_dump_pmu(size_t fm, size_t n, int is_rcp)
{
    1eb0:	55                   	push   rbp
    1eb1:	48 89 e5             	mov    rbp,rsp
    1eb4:	48 83 ec 40          	sub    rsp,0x40
    1eb8:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1ebc:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
    1ec0:	89 55 cc             	mov    DWORD PTR [rbp-0x34],edx
		struct pmu* pu;
		if (is_rcp == 2) {
    1ec3:	83 7d cc 02          	cmp    DWORD PTR [rbp-0x34],0x2
    1ec7:	0f 85 2b 01 00 00    	jne    1ff8 <mm_dump_pmu+0x148>
				/* user talk */
				printf("Free mem map contains %lu entries\n", fm_ofs);
    1ecd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1ed4 <mm_dump_pmu+0x24>
    1ed4:	48 89 c6             	mov    rsi,rax
    1ed7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1ede:	b8 00 00 00 00       	mov    eax,0x0
    1ee3:	e8 00 00 00 00       	call   1ee8 <mm_dump_pmu+0x38>
				printf("Enumerating maps:\n");
    1ee8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1eef:	b8 00 00 00 00       	mov    eax,0x0
    1ef4:	e8 00 00 00 00       	call   1ef9 <mm_dump_pmu+0x49>
				for (n = 0; n < fm_ofs; n++) {
    1ef9:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    1f01:	e9 dc 00 00 00       	jmp    1fe2 <mm_dump_pmu+0x132>
						size_t cr = 0, cu = 0;
    1f06:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1f0e:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
						struct pmu* pu;
						printf("Map %lu: %016llx-%016llx\n", n,
								fmm[n].base, fmm[n].base + fmm[n].size);
    1f16:	b9 00 40 02 00       	mov    ecx,0x24000
    1f1b:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1f1f:	48 89 d0             	mov    rax,rdx
    1f22:	48 c1 e0 03          	shl    rax,0x3
    1f26:	48 29 d0             	sub    rax,rdx
    1f29:	48 c1 e0 03          	shl    rax,0x3
    1f2d:	48 01 c8             	add    rax,rcx
    1f30:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1f33:	be 00 40 02 00       	mov    esi,0x24000
    1f38:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1f3c:	48 89 d0             	mov    rax,rdx
    1f3f:	48 c1 e0 03          	shl    rax,0x3
    1f43:	48 29 d0             	sub    rax,rdx
    1f46:	48 c1 e0 03          	shl    rax,0x3
    1f4a:	48 01 f0             	add    rax,rsi
    1f4d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
						printf("Map %lu: %016llx-%016llx\n", n,
    1f51:	48 01 c1             	add    rcx,rax
								fmm[n].base, fmm[n].base + fmm[n].size);
    1f54:	be 00 40 02 00       	mov    esi,0x24000
    1f59:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1f5d:	48 89 d0             	mov    rax,rdx
    1f60:	48 c1 e0 03          	shl    rax,0x3
    1f64:	48 29 d0             	sub    rax,rdx
    1f67:	48 c1 e0 03          	shl    rax,0x3
    1f6b:	48 01 f0             	add    rax,rsi
						printf("Map %lu: %016llx-%016llx\n", n,
    1f6e:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1f71:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1f75:	48 89 c6             	mov    rsi,rax
    1f78:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1f7f:	b8 00 00 00 00       	mov    eax,0x0
    1f84:	e8 00 00 00 00       	call   1f89 <mm_dump_pmu+0xd9>
						pu = (void*)fmm[n].pmu;
    1f89:	b9 00 40 02 00       	mov    ecx,0x24000
    1f8e:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1f92:	48 89 d0             	mov    rax,rdx
    1f95:	48 c1 e0 03          	shl    rax,0x3
    1f99:	48 29 d0             	sub    rax,rdx
    1f9c:	48 c1 e0 03          	shl    rax,0x3
    1fa0:	48 01 c8             	add    rax,rcx
    1fa3:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    1fa7:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						printf("\tEntry count: %llu\n", fmm[n].ec);
    1fab:	b9 00 40 02 00       	mov    ecx,0x24000
    1fb0:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1fb4:	48 89 d0             	mov    rax,rdx
    1fb7:	48 c1 e0 03          	shl    rax,0x3
    1fbb:	48 29 d0             	sub    rax,rdx
    1fbe:	48 c1 e0 03          	shl    rax,0x3
    1fc2:	48 01 c8             	add    rax,rcx
    1fc5:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1fc9:	48 89 c6             	mov    rsi,rax
    1fcc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1fd3:	b8 00 00 00 00       	mov    eax,0x0
    1fd8:	e8 00 00 00 00       	call   1fdd <mm_dump_pmu+0x12d>
				for (n = 0; n < fm_ofs; n++) {
    1fdd:	48 83 45 d0 01       	add    QWORD PTR [rbp-0x30],0x1
    1fe2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1fe9 <mm_dump_pmu+0x139>
    1fe9:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    1fed:	0f 82 13 ff ff ff    	jb     1f06 <mm_dump_pmu+0x56>
				}
				return;
    1ff3:	e9 30 01 00 00       	jmp    2128 <mm_dump_pmu+0x278>
		}
		if (fm > fm_ofs) {
    1ff8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1fff <mm_dump_pmu+0x14f>
    1fff:	48 3b 45 d8          	cmp    rax,QWORD PTR [rbp-0x28]
    2003:	73 16                	jae    201b <mm_dump_pmu+0x16b>
				printf("FM out of range\n");
    2005:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    200c:	b8 00 00 00 00       	mov    eax,0x0
    2011:	e8 00 00 00 00       	call   2016 <mm_dump_pmu+0x166>
				return;
    2016:	e9 0d 01 00 00       	jmp    2128 <mm_dump_pmu+0x278>
		}
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
						(uint32_t)fmm[fm].free_pages,
						(uint32_t)fmm[fm].reclaimable_pages);
    201b:	b9 00 40 02 00       	mov    ecx,0x24000
    2020:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    2024:	48 89 d0             	mov    rax,rdx
    2027:	48 c1 e0 03          	shl    rax,0x3
    202b:	48 29 d0             	sub    rax,rdx
    202e:	48 c1 e0 03          	shl    rax,0x3
    2032:	48 01 c8             	add    rax,rcx
    2035:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
    2039:	89 c1                	mov    ecx,eax
						(uint32_t)fmm[fm].free_pages,
    203b:	be 00 40 02 00       	mov    esi,0x24000
    2040:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    2044:	48 89 d0             	mov    rax,rdx
    2047:	48 c1 e0 03          	shl    rax,0x3
    204b:	48 29 d0             	sub    rax,rdx
    204e:	48 c1 e0 03          	shl    rax,0x3
    2052:	48 01 f0             	add    rax,rsi
    2055:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
		printf("FM %lu: free=%u, reclaimable=%u\n", fm,
    2059:	89 c2                	mov    edx,eax
    205b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    205f:	48 89 c6             	mov    rsi,rax
    2062:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2069:	b8 00 00 00 00       	mov    eax,0x0
    206e:	e8 00 00 00 00       	call   2073 <mm_dump_pmu+0x1c3>
		if (is_rcp)
    2073:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    2077:	74 24                	je     209d <mm_dump_pmu+0x1ed>
				pu = (void*)fmm[fm].rcp;
    2079:	b9 00 40 02 00       	mov    ecx,0x24000
    207e:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    2082:	48 89 d0             	mov    rax,rdx
    2085:	48 c1 e0 03          	shl    rax,0x3
    2089:	48 29 d0             	sub    rax,rdx
    208c:	48 c1 e0 03          	shl    rax,0x3
    2090:	48 01 c8             	add    rax,rcx
    2093:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    2097:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    209b:	eb 22                	jmp    20bf <mm_dump_pmu+0x20f>
		else
				pu = (void*)fmm[fm].pmu;
    209d:	b9 00 40 02 00       	mov    ecx,0x24000
    20a2:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    20a6:	48 89 d0             	mov    rax,rdx
    20a9:	48 c1 e0 03          	shl    rax,0x3
    20ad:	48 29 d0             	sub    rax,rdx
    20b0:	48 c1 e0 03          	shl    rax,0x3
    20b4:	48 01 c8             	add    rax,rcx
    20b7:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    20bb:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (n > fmm[fm].ec)
    20bf:	b9 00 40 02 00       	mov    ecx,0x24000
    20c4:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    20c8:	48 89 d0             	mov    rax,rdx
    20cb:	48 c1 e0 03          	shl    rax,0x3
    20cf:	48 29 d0             	sub    rax,rdx
    20d2:	48 c1 e0 03          	shl    rax,0x3
    20d6:	48 01 c8             	add    rax,rcx
    20d9:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    20dd:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
    20e1:	73 11                	jae    20f4 <mm_dump_pmu+0x244>
				printf("PMU index out of range\n");
    20e3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    20ea:	b8 00 00 00 00       	mov    eax,0x0
    20ef:	e8 00 00 00 00       	call   20f4 <mm_dump_pmu+0x244>
		pu += n;
    20f4:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    20f8:	48 c1 e0 0c          	shl    rax,0xc
    20fc:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		pmu_dump(pu, 0);
    2100:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2104:	be 00 00 00 00       	mov    esi,0x0
    2109:	48 89 c7             	mov    rdi,rax
    210c:	e8 00 00 00 00       	call   2111 <mm_dump_pmu+0x261>
		if (is_rcp)
    2111:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    2115:	74 11                	je     2128 <mm_dump_pmu+0x278>
				pmu_dump(pu, 2);
    2117:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    211b:	be 02 00 00 00       	mov    esi,0x2
    2120:	48 89 c7             	mov    rdi,rax
    2123:	e8 00 00 00 00       	call   2128 <mm_dump_pmu+0x278>
}
    2128:	c9                   	leave
    2129:	c3                   	ret
