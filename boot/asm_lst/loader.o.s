
loader.o:     file format elf32-i386


Disassembly of section .text:

00000000 <read_lba_sector>:
void* const data = FM_SECTOR_DATA;
uint64_t loaded_sector = 0xffffffffffffff;
extern void* rm_read_sector;

int read_lba_sector(uint64_t ofs)
{
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	53                   	push   ebx
   4:	83 ec 0c             	sub    esp,0xc
   7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
   d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  10:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (loaded_sector == ofs)
  13:	a1 00 00 00 00       	mov    eax,ds:0x0
  18:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
  1e:	89 c1                	mov    ecx,eax
  20:	89 c8                	mov    eax,ecx
  22:	33 45 f0             	xor    eax,DWORD PTR [ebp-0x10]
  25:	33 55 f4             	xor    edx,DWORD PTR [ebp-0xc]
  28:	09 d0                	or     eax,edx
  2a:	75 07                	jne    33 <read_lba_sector+0x33>
				return 0;
  2c:	b8 00 00 00 00       	mov    eax,0x0
  31:	eb 32                	jmp    65 <read_lba_sector+0x65>
								 "push %2\n"
								 "call rm_read_sector\n"
								 "mov %%eax, %0\n"
								 "add $8, %%esp"
					: "=rm" (rv)
					: "irm" ((uint32_t)(ofs & 0xffffffff)),
  33:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
					"irm" ((uint32_t)(ofs >> 32)));
  36:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  39:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
  3c:	89 d0                	mov    eax,edx
  3e:	31 d2                	xor    edx,edx
				__asm__ volatile("push %1\n"
  40:	51                   	push   ecx
  41:	50                   	push   eax
  42:	e8 fc ff ff ff       	call   43 <read_lba_sector+0x43>
  47:	89 c0                	mov    eax,eax
  49:	83 c4 08             	add    esp,0x8
  4c:	89 c3                	mov    ebx,eax
				if (rv == 0)
  4e:	85 db                	test   ebx,ebx
  50:	75 11                	jne    63 <read_lba_sector+0x63>
						loaded_sector = ofs;
  52:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  55:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
  58:	a3 00 00 00 00       	mov    ds:0x0,eax
  5d:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
				return rv;
  63:	89 d8                	mov    eax,ebx
		}
}
  65:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
  68:	c9                   	leave
  69:	c3                   	ret

0000006a <put16s>:

void put16s(uint16_t num)
{
  6a:	55                   	push   ebp
  6b:	89 e5                	mov    ebp,esp
  6d:	83 ec 28             	sub    esp,0x28
  70:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  73:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
		char buf[] = "0000 ";
  77:	c7 45 ed 30 30 30 30 	mov    DWORD PTR [ebp-0x13],0x30303030
  7e:	66 c7 45 f1 20 00    	mov    WORD PTR [ebp-0xf],0x20
		for (int i = 0; i < 4; i++) {
  84:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
  8b:	eb 3e                	jmp    cb <put16s+0x61>
				char c = (num >> 12);
  8d:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
  91:	66 c1 e8 0c          	shr    ax,0xc
  95:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
				if (c > 9)
  98:	80 7d f3 09          	cmp    BYTE PTR [ebp-0xd],0x9
  9c:	7e 0c                	jle    aa <put16s+0x40>
						c = 'a' + (c - 10);
  9e:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
  a2:	83 c0 57             	add    eax,0x57
  a5:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
  a8:	eb 0a                	jmp    b4 <put16s+0x4a>
				else
						c = '0' + c;
  aa:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
  ae:	83 c0 30             	add    eax,0x30
  b1:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
				buf[i] = c;
  b4:	8d 55 ed             	lea    edx,[ebp-0x13]
  b7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  ba:	01 c2                	add    edx,eax
  bc:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
  c0:	88 02                	mov    BYTE PTR [edx],al
				num <<= 4;
  c2:	66 c1 65 e4 04       	shl    WORD PTR [ebp-0x1c],0x4
		for (int i = 0; i < 4; i++) {
  c7:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
  cb:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
  cf:	7e bc                	jle    8d <put16s+0x23>
		}
		putstr(buf);
  d1:	83 ec 0c             	sub    esp,0xc
  d4:	8d 45 ed             	lea    eax,[ebp-0x13]
  d7:	50                   	push   eax
  d8:	e8 fc ff ff ff       	call   d9 <put16s+0x6f>
  dd:	83 c4 10             	add    esp,0x10
}
  e0:	90                   	nop
  e1:	c9                   	leave
  e2:	c3                   	ret

000000e3 <get_next_cluster>:

BPB* bpb = (void*)FM_FAT16_BPB;

uint16_t get_next_cluster(uint16_t clst)
{
  e3:	55                   	push   ebp
  e4:	89 e5                	mov    ebp,esp
  e6:	57                   	push   edi
  e7:	56                   	push   esi
  e8:	53                   	push   ebx
  e9:	83 ec 1c             	sub    esp,0x1c
  ec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  ef:	66 89 45 dc          	mov    WORD PTR [ebp-0x24],ax
		uint64_t fat1_ofs;

		/* calculate the sector offset into the first FAT */
		fat1_ofs = p0->lba + bpb->iResSect + (((uint32_t)clst * 2) / bpb->iSectSize);
  f3:	a1 00 00 00 00       	mov    eax,ds:0x0
  f8:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
  fb:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
  fe:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
 104:	0f b7 49 0e          	movzx  ecx,WORD PTR [ecx+0xe]
 108:	0f b7 c9             	movzx  ecx,cx
 10b:	89 ce                	mov    esi,ecx
 10d:	bf 00 00 00 00       	mov    edi,0x0
 112:	01 f0                	add    eax,esi
 114:	11 fa                	adc    edx,edi
 116:	89 c1                	mov    ecx,eax
 118:	89 d3                	mov    ebx,edx
 11a:	0f b7 45 dc          	movzx  eax,WORD PTR [ebp-0x24]
 11e:	8d 34 00             	lea    esi,[eax+eax*1]
 121:	a1 00 00 00 00       	mov    eax,ds:0x0
 126:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 12a:	0f b7 f8             	movzx  edi,ax
 12d:	89 f0                	mov    eax,esi
 12f:	ba 00 00 00 00       	mov    edx,0x0
 134:	f7 f7                	div    edi
 136:	ba 00 00 00 00       	mov    edx,0x0
 13b:	01 c8                	add    eax,ecx
 13d:	11 da                	adc    edx,ebx
 13f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 142:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		/* read the FAT sector if necessary */
		read_lba_sector(fat1_ofs);
 145:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
 148:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
 14b:	e8 fc ff ff ff       	call   14c <get_next_cluster+0x69>
 150:	83 c4 08             	add    esp,0x8

		/* return the next cluster number found at FAT sector + offset */
		return *(uint16_t*)((char*)data + ((size_t)clst * 2) % bpb->iSectSize);
 153:	bb 00 20 06 00       	mov    ebx,0x62000
 158:	0f b7 45 dc          	movzx  eax,WORD PTR [ebp-0x24]
 15c:	8d 14 00             	lea    edx,[eax+eax*1]
 15f:	a1 00 00 00 00       	mov    eax,ds:0x0
 164:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 168:	0f b7 c8             	movzx  ecx,ax
 16b:	89 d0                	mov    eax,edx
 16d:	ba 00 00 00 00       	mov    edx,0x0
 172:	f7 f1                	div    ecx
 174:	89 d0                	mov    eax,edx
 176:	01 d8                	add    eax,ebx
 178:	0f b7 00             	movzx  eax,WORD PTR [eax]
}
 17b:	8d 65 f4             	lea    esp,[ebp-0xc]
 17e:	5b                   	pop    ebx
 17f:	5e                   	pop    esi
 180:	5f                   	pop    edi
 181:	5d                   	pop    ebp
 182:	c3                   	ret

00000183 <fat16_read>:

int fat16_read(uint16_t* clst, int cct, uint32_t sz, struct page_range* pr, int prc)
{
 183:	55                   	push   ebp
 184:	89 e5                	mov    ebp,esp
 186:	57                   	push   edi
 187:	56                   	push   esi
 188:	53                   	push   ebx
 189:	83 ec 34             	sub    esp,0x34
		uint64_t data_ofs; int i; void* dst = 0;
 18c:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
		size_t dst_sz = 0;
 193:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0

		/* calculate the data offset */
		data_ofs = p0->lba + bpb->iResSect + bpb->iFatCnt * bpb->iFatSize;
 19a:	a1 00 00 00 00       	mov    eax,ds:0x0
 19f:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 1a2:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 1a5:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
 1ab:	0f b7 49 0e          	movzx  ecx,WORD PTR [ecx+0xe]
 1af:	0f b7 c9             	movzx  ecx,cx
 1b2:	89 ce                	mov    esi,ecx
 1b4:	bf 00 00 00 00       	mov    edi,0x0
 1b9:	01 f0                	add    eax,esi
 1bb:	11 fa                	adc    edx,edi
 1bd:	89 c1                	mov    ecx,eax
 1bf:	89 d3                	mov    ebx,edx
 1c1:	a1 00 00 00 00       	mov    eax,ds:0x0
 1c6:	0f b6 40 10          	movzx  eax,BYTE PTR [eax+0x10]
 1ca:	0f b6 d0             	movzx  edx,al
 1cd:	a1 00 00 00 00       	mov    eax,ds:0x0
 1d2:	0f b7 40 16          	movzx  eax,WORD PTR [eax+0x16]
 1d6:	0f b7 c0             	movzx  eax,ax
 1d9:	0f af c2             	imul   eax,edx
 1dc:	99                   	cdq
 1dd:	01 c8                	add    eax,ecx
 1df:	11 da                	adc    edx,ebx
 1e1:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 1e4:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		data_ofs += (i = bpb->iRootSize * 32) / bpb->iSectSize;
 1e7:	a1 00 00 00 00       	mov    eax,ds:0x0
 1ec:	0f b7 40 11          	movzx  eax,WORD PTR [eax+0x11]
 1f0:	0f b7 c0             	movzx  eax,ax
 1f3:	c1 e0 05             	shl    eax,0x5
 1f6:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
 1f9:	a1 00 00 00 00       	mov    eax,ds:0x0
 1fe:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 202:	0f b7 d8             	movzx  ebx,ax
 205:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 208:	99                   	cdq
 209:	f7 fb                	idiv   ebx
 20b:	99                   	cdq
 20c:	01 45 e8             	add    DWORD PTR [ebp-0x18],eax
 20f:	11 55 ec             	adc    DWORD PTR [ebp-0x14],edx
		if (i % bpb->iSectSize)
 212:	a1 00 00 00 00       	mov    eax,ds:0x0
 217:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 21b:	0f b7 c8             	movzx  ecx,ax
 21e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 221:	99                   	cdq
 222:	f7 f9                	idiv   ecx
 224:	89 d0                	mov    eax,edx
 226:	85 c0                	test   eax,eax
 228:	74 08                	je     232 <fat16_read+0xaf>
				data_ofs++;
 22a:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
 22e:	83 55 ec 00          	adc    DWORD PTR [ebp-0x14],0x0

		/* read the data */
		for (i = 0; i < cct; i++) {
 232:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
 239:	e9 18 01 00 00       	jmp    356 <fat16_read+0x1d3>
				uint32_t j;
				uint64_t lba = data_ofs + (clst[i] - 2) * bpb->iClustSize;
 23e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 241:	8d 14 00             	lea    edx,[eax+eax*1]
 244:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 247:	01 d0                	add    eax,edx
 249:	0f b7 00             	movzx  eax,WORD PTR [eax]
 24c:	0f b7 c0             	movzx  eax,ax
 24f:	8d 50 fe             	lea    edx,[eax-0x2]
 252:	a1 00 00 00 00       	mov    eax,ds:0x0
 257:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
 25b:	0f b6 c0             	movzx  eax,al
 25e:	0f af c2             	imul   eax,edx
 261:	89 c1                	mov    ecx,eax
 263:	89 c3                	mov    ebx,eax
 265:	c1 fb 1f             	sar    ebx,0x1f
 268:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 26b:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 26e:	01 c8                	add    eax,ecx
 270:	11 da                	adc    edx,ebx
 272:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 275:	89 55 c4             	mov    DWORD PTR [ebp-0x3c],edx
				for (j = 0; j < bpb->iClustSize; j++) {
 278:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
 27f:	e9 b9 00 00 00       	jmp    33d <fat16_read+0x1ba>
						size_t ct = sz > bpb->iSectSize ? bpb->iSectSize : sz;
 284:	a1 00 00 00 00       	mov    eax,ds:0x0
 289:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 28d:	0f b7 c0             	movzx  eax,ax
 290:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
 293:	39 c2                	cmp    edx,eax
 295:	0f 46 c2             	cmovbe eax,edx
 298:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
						char *p1 = dst, *p2 = data;
 29b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 29e:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 2a1:	c7 45 cc 00 20 06 00 	mov    DWORD PTR [ebp-0x34],0x62000
						read_lba_sector(lba + j);
 2a8:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
 2ab:	bb 00 00 00 00       	mov    ebx,0x0
 2b0:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 2b3:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 2b6:	01 c8                	add    eax,ecx
 2b8:	11 da                	adc    edx,ebx
 2ba:	52                   	push   edx
 2bb:	50                   	push   eax
 2bc:	e8 fc ff ff ff       	call   2bd <fat16_read+0x13a>
 2c1:	83 c4 08             	add    esp,0x8
						while (ct--) {
 2c4:	eb 60                	jmp    326 <fat16_read+0x1a3>
								if (!dst || !dst_sz) {
 2c6:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
 2ca:	74 06                	je     2d2 <fat16_read+0x14f>
 2cc:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
 2d0:	75 35                	jne    307 <fat16_read+0x184>
										if (!prc)
 2d2:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
 2d6:	75 0a                	jne    2e2 <fat16_read+0x15f>
												return -1;
 2d8:	b8 ff ff ff ff       	mov    eax,0xffffffff
 2dd:	e9 85 00 00 00       	jmp    367 <fat16_read+0x1e4>
										dst = (void*)pr->base;
 2e2:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2e5:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 2e8:	8b 00                	mov    eax,DWORD PTR [eax]
 2ea:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
										dst_sz = pr->count * 4096;
 2ed:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2f0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 2f3:	c1 e0 0c             	shl    eax,0xc
 2f6:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
										pr++; prc--;
 2f9:	83 45 14 0c          	add    DWORD PTR [ebp+0x14],0xc
 2fd:	83 6d 18 01          	sub    DWORD PTR [ebp+0x18],0x1
										p1 = dst;
 301:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 304:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
								}
								*p1++ = *p2++;
 307:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
 30a:	8d 42 01             	lea    eax,[edx+0x1]
 30d:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
 310:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 313:	8d 48 01             	lea    ecx,[eax+0x1]
 316:	89 4d d0             	mov    DWORD PTR [ebp-0x30],ecx
 319:	0f b6 12             	movzx  edx,BYTE PTR [edx]
 31c:	88 10                	mov    BYTE PTR [eax],dl
								dst_sz--;
 31e:	83 6d dc 01          	sub    DWORD PTR [ebp-0x24],0x1
								sz--;
 322:	83 6d 10 01          	sub    DWORD PTR [ebp+0x10],0x1
						while (ct--) {
 326:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 329:	8d 50 ff             	lea    edx,[eax-0x1]
 32c:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
 32f:	85 c0                	test   eax,eax
 331:	75 93                	jne    2c6 <fat16_read+0x143>
						}
						dst = (void*)p1;
 333:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 336:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				for (j = 0; j < bpb->iClustSize; j++) {
 339:	83 45 d8 01          	add    DWORD PTR [ebp-0x28],0x1
 33d:	a1 00 00 00 00       	mov    eax,ds:0x0
 342:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
 346:	0f b6 c0             	movzx  eax,al
 349:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
 34c:	0f 82 32 ff ff ff    	jb     284 <fat16_read+0x101>
		for (i = 0; i < cct; i++) {
 352:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
 356:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 359:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
 35c:	0f 8c dc fe ff ff    	jl     23e <fat16_read+0xbb>
				}
		}

		return 0;
 362:	b8 00 00 00 00       	mov    eax,0x0
}
 367:	8d 65 f4             	lea    esp,[ebp-0xc]
 36a:	5b                   	pop    ebx
 36b:	5e                   	pop    esi
 36c:	5f                   	pop    edi
 36d:	5d                   	pop    ebp
 36e:	c3                   	ret

0000036f <fat16_fill_cluster_table>:

int fat16_fill_cluster_table(uint16_t* clst, uint16_t clust, uint32_t sz, size_t* ct)
{
 36f:	55                   	push   ebp
 370:	89 e5                	mov    ebp,esp
 372:	83 ec 28             	sub    esp,0x28
 375:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 378:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
		size_t i = 0;
 37c:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		while ((clust & 0xfff0) != 0xfff0) {
 383:	e9 bf 00 00 00       	jmp    447 <fat16_fill_cluster_table+0xd8>
				clst[i++] = clust;
 388:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 38b:	8d 50 01             	lea    edx,[eax+0x1]
 38e:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
 391:	8d 14 00             	lea    edx,[eax+eax*1]
 394:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 397:	01 c2                	add    edx,eax
 399:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
 39d:	66 89 02             	mov    WORD PTR [edx],ax
				if ((i - 1) * bpb->iSectSize * bpb->iClustSize > sz)
 3a0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 3a3:	8d 50 ff             	lea    edx,[eax-0x1]
 3a6:	a1 00 00 00 00       	mov    eax,ds:0x0
 3ab:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 3af:	0f b7 c0             	movzx  eax,ax
 3b2:	0f af d0             	imul   edx,eax
 3b5:	a1 00 00 00 00       	mov    eax,ds:0x0
 3ba:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
 3be:	0f b6 c0             	movzx  eax,al
 3c1:	0f af c2             	imul   eax,edx
 3c4:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
 3c7:	73 0a                	jae    3d3 <fat16_fill_cluster_table+0x64>
			   			return 1;
 3c9:	b8 01 00 00 00       	mov    eax,0x1
 3ce:	e9 ce 00 00 00       	jmp    4a1 <fat16_fill_cluster_table+0x132>
				else if (i + 1 == 0xffff && ((clust & 0xfff0) != 0xfff0))
 3d3:	81 7d f4 fe ff 00 00 	cmp    DWORD PTR [ebp-0xc],0xfffe
 3da:	75 1a                	jne    3f6 <fat16_fill_cluster_table+0x87>
 3dc:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
 3e0:	25 f0 ff 00 00       	and    eax,0xfff0
 3e5:	3d f0 ff 00 00       	cmp    eax,0xfff0
 3ea:	74 0a                	je     3f6 <fat16_fill_cluster_table+0x87>
						return 2;
 3ec:	b8 02 00 00 00       	mov    eax,0x2
 3f1:	e9 ab 00 00 00       	jmp    4a1 <fat16_fill_cluster_table+0x132>
				else if (i * bpb->iSectSize * bpb->iClustSize < sz && ((clust & 0xfff0) == 0xfff0))
 3f6:	a1 00 00 00 00       	mov    eax,ds:0x0
 3fb:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 3ff:	0f b7 c0             	movzx  eax,ax
 402:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
 406:	89 c2                	mov    edx,eax
 408:	a1 00 00 00 00       	mov    eax,ds:0x0
 40d:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
 411:	0f b6 c0             	movzx  eax,al
 414:	0f af c2             	imul   eax,edx
 417:	3b 45 10             	cmp    eax,DWORD PTR [ebp+0x10]
 41a:	73 17                	jae    433 <fat16_fill_cluster_table+0xc4>
 41c:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
 420:	25 f0 ff 00 00       	and    eax,0xfff0
 425:	3d f0 ff 00 00       	cmp    eax,0xfff0
 42a:	75 07                	jne    433 <fat16_fill_cluster_table+0xc4>
						return 3;
 42c:	b8 03 00 00 00       	mov    eax,0x3
 431:	eb 6e                	jmp    4a1 <fat16_fill_cluster_table+0x132>
				clust = get_next_cluster(clust);
 433:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
 437:	83 ec 04             	sub    esp,0x4
 43a:	50                   	push   eax
 43b:	e8 fc ff ff ff       	call   43c <fat16_fill_cluster_table+0xcd>
 440:	83 c4 08             	add    esp,0x8
 443:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
		while ((clust & 0xfff0) != 0xfff0) {
 447:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
 44b:	25 f0 ff 00 00       	and    eax,0xfff0
 450:	3d f0 ff 00 00       	cmp    eax,0xfff0
 455:	0f 85 2d ff ff ff    	jne    388 <fat16_fill_cluster_table+0x19>
		}

		*ct = i;
 45b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 45e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 461:	89 10                	mov    DWORD PTR [eax],edx
		for (i = 0; i < *ct; i++)
 463:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
 46a:	eb 21                	jmp    48d <fat16_fill_cluster_table+0x11e>
				put16s(clst[i]);
 46c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 46f:	8d 14 00             	lea    edx,[eax+eax*1]
 472:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 475:	01 d0                	add    eax,edx
 477:	0f b7 00             	movzx  eax,WORD PTR [eax]
 47a:	0f b7 c0             	movzx  eax,ax
 47d:	83 ec 0c             	sub    esp,0xc
 480:	50                   	push   eax
 481:	e8 fc ff ff ff       	call   482 <fat16_fill_cluster_table+0x113>
 486:	83 c4 10             	add    esp,0x10
		for (i = 0; i < *ct; i++)
 489:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
 48d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 490:	8b 00                	mov    eax,DWORD PTR [eax]
 492:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
 495:	72 d5                	jb     46c <fat16_fill_cluster_table+0xfd>
		put_nl();
 497:	e8 fc ff ff ff       	call   498 <fat16_fill_cluster_table+0x129>
		return 0;
 49c:	b8 00 00 00 00       	mov    eax,0x0
}
 4a1:	c9                   	leave
 4a2:	c3                   	ret

000004a3 <write_fn>:

/* write 8.3 fn */
void write_fn(void** pp, const char* fn)
{
 4a3:	55                   	push   ebp
 4a4:	89 e5                	mov    ebp,esp
 4a6:	83 ec 10             	sub    esp,0x10
		char* str = *pp;
 4a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 4ac:	8b 00                	mov    eax,DWORD PTR [eax]
 4ae:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		size_t i;
		for (i = 0; i < 11; i++) {
 4b1:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
 4b8:	eb 3c                	jmp    4f6 <write_fn+0x53>
				if (i == 7)
 4ba:	83 7d f8 07          	cmp    DWORD PTR [ebp-0x8],0x7
 4be:	75 0c                	jne    4cc <write_fn+0x29>
						*str++ = '.';
 4c0:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 4c3:	8d 50 01             	lea    edx,[eax+0x1]
 4c6:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
 4c9:	c6 00 2e             	mov    BYTE PTR [eax],0x2e
				if (fn[i] != ' ')
 4cc:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 4cf:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
 4d2:	01 d0                	add    eax,edx
 4d4:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 4d7:	3c 20                	cmp    al,0x20
 4d9:	74 17                	je     4f2 <write_fn+0x4f>
						*str++ = fn[i];
 4db:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 4de:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
 4e1:	8d 0c 02             	lea    ecx,[edx+eax*1]
 4e4:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 4e7:	8d 50 01             	lea    edx,[eax+0x1]
 4ea:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
 4ed:	0f b6 11             	movzx  edx,BYTE PTR [ecx]
 4f0:	88 10                	mov    BYTE PTR [eax],dl
		for (i = 0; i < 11; i++) {
 4f2:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
 4f6:	83 7d f8 0a          	cmp    DWORD PTR [ebp-0x8],0xa
 4fa:	76 be                	jbe    4ba <write_fn+0x17>
		}
		*str++ = '\0';
 4fc:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 4ff:	8d 50 01             	lea    edx,[eax+0x1]
 502:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
 505:	c6 00 00             	mov    BYTE PTR [eax],0x0
		*pp = str;
 508:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 50b:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
 50e:	89 10                	mov    DWORD PTR [eax],edx
}
 510:	90                   	nop
 511:	c9                   	leave
 512:	c3                   	ret

00000513 <fill_cluster_table>:

void fill_cluster_table(uint16_t* clst, uint16_t start, uint32_t size, size_t* j)
{
 513:	55                   	push   ebp
 514:	89 e5                	mov    ebp,esp
 516:	83 ec 28             	sub    esp,0x28
 519:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 51c:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
		int rv;
		rv = fat16_fill_cluster_table(clst, start, size, j);
 520:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
 524:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 527:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 52a:	50                   	push   eax
 52b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 52e:	e8 fc ff ff ff       	call   52f <fill_cluster_table+0x1c>
 533:	83 c4 10             	add    esp,0x10
 536:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (rv == 1) {
 539:	83 7d f4 01          	cmp    DWORD PTR [ebp-0xc],0x1
 53d:	75 13                	jne    552 <fill_cluster_table+0x3f>
				puts("damaged FAT. unable to read file.");
 53f:	83 ec 0c             	sub    esp,0xc
 542:	68 04 00 00 00       	push   0x4
 547:	e8 fc ff ff ff       	call   548 <fill_cluster_table+0x35>
 54c:	83 c4 10             	add    esp,0x10
				while (1);
 54f:	90                   	nop
 550:	eb fd                	jmp    54f <fill_cluster_table+0x3c>
		} else if (rv == 2) {
 552:	83 7d f4 02          	cmp    DWORD PTR [ebp-0xc],0x2
 556:	75 13                	jne    56b <fill_cluster_table+0x58>
				puts("file is larger than allowed. unable to continue loading.");
 558:	83 ec 0c             	sub    esp,0xc
 55b:	68 28 00 00 00       	push   0x28
 560:	e8 fc ff ff ff       	call   561 <fill_cluster_table+0x4e>
 565:	83 c4 10             	add    esp,0x10
				while (1);
 568:	90                   	nop
 569:	eb fd                	jmp    568 <fill_cluster_table+0x55>
		} else if (rv == 3) {
 56b:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
 56f:	75 13                	jne    584 <fill_cluster_table+0x71>
				puts("file ends prematurely. damaged FAT likely. halting.");
 571:	83 ec 0c             	sub    esp,0xc
 574:	68 64 00 00 00       	push   0x64
 579:	e8 fc ff ff ff       	call   57a <fill_cluster_table+0x67>
 57e:	83 c4 10             	add    esp,0x10
				while (1);
 581:	90                   	nop
 582:	eb fd                	jmp    581 <fill_cluster_table+0x6e>
		}
}
 584:	90                   	nop
 585:	c9                   	leave
 586:	c3                   	ret

00000587 <fl_load_images>:

/* we're still w/o paging in 32-bit PM and can switch easily to BIOS */
uint64_t fl_load_images(int mode)
{
 587:	55                   	push   ebp
 588:	89 e5                	mov    ebp,esp
 58a:	57                   	push   edi
 58b:	56                   	push   esi
 58c:	53                   	push   ebx
 58d:	83 ec 1c             	sub    esp,0x1c
		uint64_t rv;

		/* read the BPB of the first partition */
		read_lba_sector(p0->lba);
 590:	a1 00 00 00 00       	mov    eax,ds:0x0
 595:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 598:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 59b:	52                   	push   edx
 59c:	50                   	push   eax
 59d:	e8 fc ff ff ff       	call   59e <fl_load_images+0x17>
 5a2:	83 c4 08             	add    esp,0x8
		__builtin_memcpy(bpb, FM_SECTOR_DATA, 512);
 5a5:	a1 00 00 00 00       	mov    eax,ds:0x0
 5aa:	bb 00 20 06 00       	mov    ebx,0x62000
 5af:	ba 00 02 00 00       	mov    edx,0x200
 5b4:	8b 0b                	mov    ecx,DWORD PTR [ebx]
 5b6:	89 08                	mov    DWORD PTR [eax],ecx
 5b8:	8b 4c 13 fc          	mov    ecx,DWORD PTR [ebx+edx*1-0x4]
 5bc:	89 4c 10 fc          	mov    DWORD PTR [eax+edx*1-0x4],ecx
 5c0:	8d 78 04             	lea    edi,[eax+0x4]
 5c3:	83 e7 fc             	and    edi,0xfffffffc
 5c6:	29 f8                	sub    eax,edi
 5c8:	29 c3                	sub    ebx,eax
 5ca:	01 c2                	add    edx,eax
 5cc:	83 e2 fc             	and    edx,0xfffffffc
 5cf:	89 d0                	mov    eax,edx
 5d1:	c1 e8 02             	shr    eax,0x2
 5d4:	89 de                	mov    esi,ebx
 5d6:	89 c1                	mov    ecx,eax
 5d8:	f3 a5                	rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]

		/* and then load the kernel and the modules */
		uint64_t early_entry(int mode);
		rv = early_entry(mode);
 5da:	83 ec 0c             	sub    esp,0xc
 5dd:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 5e0:	e8 fc ff ff ff       	call   5e1 <fl_load_images+0x5a>
 5e5:	83 c4 10             	add    esp,0x10
 5e8:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
 5eb:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx

		/* and then jump into rv */
		return rv;
 5ee:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 5f1:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
}
 5f4:	8d 65 f4             	lea    esp,[ebp-0xc]
 5f7:	5b                   	pop    ebx
 5f8:	5e                   	pop    esi
 5f9:	5f                   	pop    edi
 5fa:	5d                   	pop    ebp
 5fb:	c3                   	ret

000005fc <get_f>:
		struct fdat* prev;
		struct fdat* next;
} *fils = 0, *mods = 0;

void* get_f()
{
 5fc:	55                   	push   ebp
 5fd:	89 e5                	mov    ebp,esp
 5ff:	83 ec 10             	sub    esp,0x10
		static void* ptr = (void*)FM_FAT16_FILES;
		void* rv = ptr;
 602:	a1 14 00 00 00       	mov    eax,ds:0x14
 607:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		ptr += sizeof(struct fdat);
 60a:	a1 14 00 00 00       	mov    eax,ds:0x14
 60f:	83 c0 1c             	add    eax,0x1c
 612:	a3 14 00 00 00       	mov    ds:0x14,eax
		return rv;
 617:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
}
 61a:	c9                   	leave
 61b:	c3                   	ret

0000061c <early_entry>:

uint64_t early_entry(int mode)
{
 61c:	55                   	push   ebp
 61d:	89 e5                	mov    ebp,esp
 61f:	53                   	push   ebx
 620:	81 ec c4 01 00 00    	sub    esp,0x1c4
		char* ptr = FM_SECTOR_DATA, *fn; uint16_t* clst = FM_FAT16_CLSTRS;
 626:	c7 45 e0 00 20 06 00 	mov    DWORD PTR [ebp-0x20],0x62000
 62d:	c7 45 dc 00 24 06 00 	mov    DWORD PTR [ebp-0x24],0x62400
		uint32_t i, bs, ct; uint64_t rv = 0;
 634:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
 63b:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
		struct fdat *mf = 0, *kf = 0;
 642:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 649:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
		void call_int15(uint32_t mus);

		puts("MyOS built on " __DATE__ " " __TIME__ );
 650:	83 ec 0c             	sub    esp,0xc
 653:	68 98 00 00 00       	push   0x98
 658:	e8 fc ff ff ff       	call   659 <early_entry+0x3d>
 65d:	83 c4 10             	add    esp,0x10
		puts("listing root directory contents of boot drive:");
 660:	83 ec 0c             	sub    esp,0xc
 663:	68 bc 00 00 00       	push   0xbc
 668:	e8 fc ff ff ff       	call   669 <early_entry+0x4d>
 66d:	83 c4 10             	add    esp,0x10
		call_int15(1000000); /* delay 1000ms */
 670:	83 ec 0c             	sub    esp,0xc
 673:	68 40 42 0f 00       	push   0xf4240
 678:	e8 fc ff ff ff       	call   679 <early_entry+0x5d>
 67d:	83 c4 10             	add    esp,0x10
		//for (i = 0; i < 0xffffffff / 4; i++); /* mega dangerous */

		puts("SIZE       CLSTR NAME    EXT");
 680:	83 ec 0c             	sub    esp,0xc
 683:	68 eb 00 00 00       	push   0xeb
 688:	e8 fc ff ff ff       	call   689 <early_entry+0x6d>
 68d:	83 c4 10             	add    esp,0x10
		ct = bpb->iRootSize * 32; /* normally FAT16 224*32 */
 690:	a1 00 00 00 00       	mov    eax,ds:0x0
 695:	0f b7 40 11          	movzx  eax,WORD PTR [eax+0x11]
 699:	0f b7 c0             	movzx  eax,ax
 69c:	c1 e0 05             	shl    eax,0x5
 69f:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
		ct = ct / bpb->iSectSize + (ct % bpb->iSectSize) ? 1 : 0; /*  */
 6a2:	a1 00 00 00 00       	mov    eax,ds:0x0
 6a7:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 6ab:	0f b7 d8             	movzx  ebx,ax
 6ae:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
 6b1:	ba 00 00 00 00       	mov    edx,0x0
 6b6:	f7 f3                	div    ebx
 6b8:	89 c3                	mov    ebx,eax
 6ba:	a1 00 00 00 00       	mov    eax,ds:0x0
 6bf:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 6c3:	0f b7 c8             	movzx  ecx,ax
 6c6:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
 6c9:	ba 00 00 00 00       	mov    edx,0x0
 6ce:	f7 f1                	div    ecx
 6d0:	89 d0                	mov    eax,edx
 6d2:	01 d8                	add    eax,ebx
 6d4:	85 c0                	test   eax,eax
 6d6:	0f 95 c0             	setne  al
 6d9:	0f b6 c0             	movzx  eax,al
 6dc:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
		bs = bpb->iResSect + bpb->iFatCnt * bpb->iFatSize;
 6df:	a1 00 00 00 00       	mov    eax,ds:0x0
 6e4:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
 6e8:	0f b7 c8             	movzx  ecx,ax
 6eb:	a1 00 00 00 00       	mov    eax,ds:0x0
 6f0:	0f b6 40 10          	movzx  eax,BYTE PTR [eax+0x10]
 6f4:	0f b6 d0             	movzx  edx,al
 6f7:	a1 00 00 00 00       	mov    eax,ds:0x0
 6fc:	0f b7 40 16          	movzx  eax,WORD PTR [eax+0x16]
 700:	0f b7 c0             	movzx  eax,ax
 703:	0f af c2             	imul   eax,edx
 706:	01 c8                	add    eax,ecx
 708:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
		nput32(bpb->iSectSize, 10);
 70b:	a1 00 00 00 00       	mov    eax,ds:0x0
 710:	0f b7 40 0b          	movzx  eax,WORD PTR [eax+0xb]
 714:	0f b7 c0             	movzx  eax,ax
 717:	83 ec 08             	sub    esp,0x8
 71a:	6a 0a                	push   0xa
 71c:	50                   	push   eax
 71d:	e8 fc ff ff ff       	call   71e <early_entry+0x102>
 722:	83 c4 10             	add    esp,0x10
		/* reads every root directory sector */
		for (i = 0; i < ct; i++) {
 725:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 72c:	e9 90 01 00 00       	jmp    8c1 <early_entry+0x2a5>
				puts("r");
 731:	83 ec 0c             	sub    esp,0xc
 734:	68 08 01 00 00       	push   0x108
 739:	e8 fc ff ff ff       	call   73a <early_entry+0x11e>
 73e:	83 c4 10             	add    esp,0x10
				read_lba_sector(p0->lba + bs + i);
 741:	a1 00 00 00 00       	mov    eax,ds:0x0
 746:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 749:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 74c:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
 74f:	bb 00 00 00 00       	mov    ebx,0x0
 754:	01 c8                	add    eax,ecx
 756:	11 da                	adc    edx,ebx
 758:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
 75b:	bb 00 00 00 00       	mov    ebx,0x0
 760:	01 c8                	add    eax,ecx
 762:	11 da                	adc    edx,ebx
 764:	83 ec 08             	sub    esp,0x8
 767:	52                   	push   edx
 768:	50                   	push   eax
 769:	e8 fc ff ff ff       	call   76a <early_entry+0x14e>
 76e:	83 c4 10             	add    esp,0x10
				puts("d");
 771:	83 ec 0c             	sub    esp,0xc
 774:	68 0a 01 00 00       	push   0x10a
 779:	e8 fc ff ff ff       	call   77a <early_entry+0x15e>
 77e:	83 c4 10             	add    esp,0x10
				/* and iterates over the entries */
				for (fn = ptr; fn < ptr + 0x200; fn += 32) {
 781:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 784:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
 787:	e9 20 01 00 00       	jmp    8ac <early_entry+0x290>
						if (fn[11] == 0x0f) { /* LFN */
 78c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 78f:	83 c0 0b             	add    eax,0xb
 792:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 795:	3c 0f                	cmp    al,0xf
 797:	0f 84 0a 01 00 00    	je     8a7 <early_entry+0x28b>
								continue;
						}
						if (*fn) { /* which are present */
 79d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 7a0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 7a3:	84 c0                	test   al,al
 7a5:	0f 84 f4 00 00 00    	je     89f <early_entry+0x283>
								struct fdat* f;
								f = get_f();
 7ab:	e8 fc ff ff ff       	call   7ac <early_entry+0x190>
 7b0:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
								fn[11] = '\0';
 7b3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 7b6:	83 c0 0b             	add    eax,0xb
 7b9:	c6 00 00             	mov    BYTE PTR [eax],0x0
								__builtin_memcpy(f->fn, fn, 11);
 7bc:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 7bf:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 7c2:	8b 0a                	mov    ecx,DWORD PTR [edx]
 7c4:	89 08                	mov    DWORD PTR [eax],ecx
 7c6:	8b 4a 04             	mov    ecx,DWORD PTR [edx+0x4]
 7c9:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
 7cc:	8b 52 07             	mov    edx,DWORD PTR [edx+0x7]
 7cf:	89 50 07             	mov    DWORD PTR [eax+0x7],edx
								f->clst = *(uint16_t*)(fn + 0x1a);
 7d2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 7d5:	0f b7 50 1a          	movzx  edx,WORD PTR [eax+0x1a]
 7d9:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 7dc:	66 89 50 10          	mov    WORD PTR [eax+0x10],dx
								f->size = *(uint32_t*)(fn + 0x1c);
 7e0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 7e3:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
 7e6:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 7e9:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
								if (fils) {
 7ec:	a1 00 00 00 00       	mov    eax,ds:0x0
 7f1:	85 c0                	test   eax,eax
 7f3:	74 33                	je     828 <early_entry+0x20c>
										f->next = fils;
 7f5:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
 7fb:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 7fe:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
										f->prev = fils->prev;
 801:	a1 00 00 00 00       	mov    eax,ds:0x0
 806:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
 809:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 80c:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
										f->prev->next = f;
 80f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 812:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
 815:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
 818:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
										fils->prev = f;
 81b:	a1 00 00 00 00       	mov    eax,ds:0x0
 820:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
 823:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
 826:	eb 1d                	jmp    845 <early_entry+0x229>
								} else {
										f->prev = f->next = f;
 828:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 82b:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
 82e:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
 831:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 834:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 837:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 83a:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
										fils = f;
 83d:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 840:	a3 00 00 00 00       	mov    ds:0x0,eax
								}
								nput32(f->size, 10);
 845:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 848:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 84b:	83 ec 08             	sub    esp,0x8
 84e:	6a 0a                	push   0xa
 850:	50                   	push   eax
 851:	e8 fc ff ff ff       	call   852 <early_entry+0x236>
 856:	83 c4 10             	add    esp,0x10
								putstr(" ");
 859:	83 ec 0c             	sub    esp,0xc
 85c:	68 0c 01 00 00       	push   0x10c
 861:	e8 fc ff ff ff       	call   862 <early_entry+0x246>
 866:	83 c4 10             	add    esp,0x10
								put16s(f->clst);
 869:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
 86c:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
 870:	0f b7 c0             	movzx  eax,ax
 873:	83 ec 0c             	sub    esp,0xc
 876:	50                   	push   eax
 877:	e8 fc ff ff ff       	call   878 <early_entry+0x25c>
 87c:	83 c4 10             	add    esp,0x10
								putstr(" ");
 87f:	83 ec 0c             	sub    esp,0xc
 882:	68 0c 01 00 00       	push   0x10c
 887:	e8 fc ff ff ff       	call   888 <early_entry+0x26c>
 88c:	83 c4 10             	add    esp,0x10
								puts(fn);
 88f:	83 ec 0c             	sub    esp,0xc
 892:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 895:	e8 fc ff ff ff       	call   896 <early_entry+0x27a>
 89a:	83 c4 10             	add    esp,0x10
 89d:	eb 09                	jmp    8a8 <early_entry+0x28c>
								//printf("%11u %5u %s\n", f->size, f->clst, fn);
						} else {
								i = ct;
 89f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
 8a2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								break;
 8a5:	eb 16                	jmp    8bd <early_entry+0x2a1>
								continue;
 8a7:	90                   	nop
				for (fn = ptr; fn < ptr + 0x200; fn += 32) {
 8a8:	83 45 f4 20          	add    DWORD PTR [ebp-0xc],0x20
 8ac:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 8af:	05 00 02 00 00       	add    eax,0x200
 8b4:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
 8b7:	0f 82 cf fe ff ff    	jb     78c <early_entry+0x170>
		for (i = 0; i < ct; i++) {
 8bd:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
 8c1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 8c4:	3b 45 cc             	cmp    eax,DWORD PTR [ebp-0x34]
 8c7:	0f 82 64 fe ff ff    	jb     731 <early_entry+0x115>
						}
				}
		}
		put_nl();
 8cd:	e8 fc ff ff ff       	call   8ce <early_entry+0x2b2>
		call_int15(1000000); /* delay 1000ms */
 8d2:	83 ec 0c             	sub    esp,0xc
 8d5:	68 40 42 0f 00       	push   0xf4240
 8da:	e8 fc ff ff ff       	call   8db <early_entry+0x2bf>
 8df:	83 c4 10             	add    esp,0x10

		if (!fils)
 8e2:	a1 00 00 00 00       	mov    eax,ds:0x0
 8e7:	85 c0                	test   eax,eax
 8e9:	0f 84 d7 00 00 00    	je     9c6 <early_entry+0x3aa>
				goto abrt;
		/* now check for the presence of MODULES.MOD and K64.ELF */
		for (struct fdat* f = fils; ; f = f->next) {
 8ef:	a1 00 00 00 00       	mov    eax,ds:0x0
 8f4:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (strncmp(f->fn, "MODULES MOD", 11) == 0)
 8f7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 8fa:	83 ec 04             	sub    esp,0x4
 8fd:	6a 0b                	push   0xb
 8ff:	68 0e 01 00 00       	push   0x10e
 904:	50                   	push   eax
 905:	e8 fc ff ff ff       	call   906 <early_entry+0x2ea>
 90a:	83 c4 10             	add    esp,0x10
 90d:	85 c0                	test   eax,eax
 90f:	75 08                	jne    919 <early_entry+0x2fd>
						mf = f;
 911:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 914:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
 917:	eb 76                	jmp    98f <early_entry+0x373>
				else if (!mode && strncmp(f->fn, "KERNEL32ELF", 11) == 0)
 919:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
 91d:	75 22                	jne    941 <early_entry+0x325>
 91f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 922:	83 ec 04             	sub    esp,0x4
 925:	6a 0b                	push   0xb
 927:	68 1a 01 00 00       	push   0x11a
 92c:	50                   	push   eax
 92d:	e8 fc ff ff ff       	call   92e <early_entry+0x312>
 932:	83 c4 10             	add    esp,0x10
 935:	85 c0                	test   eax,eax
 937:	75 08                	jne    941 <early_entry+0x325>
						kf = f;
 939:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 93c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 93f:	eb 4e                	jmp    98f <early_entry+0x373>
				else if (mode == 1 && strncmp(f->fn, "KERNEL36ELF", 11) == 0)
 941:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
 945:	75 22                	jne    969 <early_entry+0x34d>
 947:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 94a:	83 ec 04             	sub    esp,0x4
 94d:	6a 0b                	push   0xb
 94f:	68 26 01 00 00       	push   0x126
 954:	50                   	push   eax
 955:	e8 fc ff ff ff       	call   956 <early_entry+0x33a>
 95a:	83 c4 10             	add    esp,0x10
 95d:	85 c0                	test   eax,eax
 95f:	75 08                	jne    969 <early_entry+0x34d>
						kf = f;
 961:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 964:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 967:	eb 26                	jmp    98f <early_entry+0x373>
				else if (mode == 2 && strncmp(f->fn, "KERNEL64ELF", 11) == 0)
 969:	83 7d 08 02          	cmp    DWORD PTR [ebp+0x8],0x2
 96d:	75 20                	jne    98f <early_entry+0x373>
 96f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 972:	83 ec 04             	sub    esp,0x4
 975:	6a 0b                	push   0xb
 977:	68 32 01 00 00       	push   0x132
 97c:	50                   	push   eax
 97d:	e8 fc ff ff ff       	call   97e <early_entry+0x362>
 982:	83 c4 10             	add    esp,0x10
 985:	85 c0                	test   eax,eax
 987:	75 06                	jne    98f <early_entry+0x373>
						kf = f;
 989:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 98c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (f->next == fils || (mf && kf))
 98f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 992:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 995:	a1 00 00 00 00       	mov    eax,ds:0x0
 99a:	39 c2                	cmp    edx,eax
 99c:	74 1a                	je     9b8 <early_entry+0x39c>
 99e:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 9a2:	74 06                	je     9aa <early_entry+0x38e>
 9a4:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
 9a8:	75 0e                	jne    9b8 <early_entry+0x39c>
		for (struct fdat* f = fils; ; f = f->next) {
 9aa:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 9ad:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 9b0:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (strncmp(f->fn, "MODULES MOD", 11) == 0)
 9b3:	e9 3f ff ff ff       	jmp    8f7 <early_entry+0x2db>
						break;
		}
		/* and abort if missing */
		if (!kf || !mf) {
 9b8:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
 9bc:	74 0b                	je     9c9 <early_entry+0x3ad>
 9be:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
 9c2:	75 19                	jne    9dd <early_entry+0x3c1>
abrt:
 9c4:	eb 03                	jmp    9c9 <early_entry+0x3ad>
				goto abrt;
 9c6:	90                   	nop
 9c7:	eb 01                	jmp    9ca <early_entry+0x3ae>
abrt:
 9c9:	90                   	nop
				puts("Unable to locate boot files in root directory. Halting...");
 9ca:	83 ec 0c             	sub    esp,0xc
 9cd:	68 40 01 00 00       	push   0x140
 9d2:	e8 fc ff ff ff       	call   9d3 <early_entry+0x3b7>
 9d7:	83 c4 10             	add    esp,0x10
				while (1);
 9da:	90                   	nop
 9db:	eb fd                	jmp    9da <early_entry+0x3be>
		/* read the kernel image */
		{
				size_t cct; uint32_t sz, pc;
				struct page_range prs[32];

				fill_cluster_table(clst, kf->clst, kf->size, &cct);
 9dd:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 9e0:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 9e3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 9e6:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
 9ea:	0f b7 c0             	movzx  eax,ax
 9ed:	8d 4d b8             	lea    ecx,[ebp-0x48]
 9f0:	51                   	push   ecx
 9f1:	52                   	push   edx
 9f2:	50                   	push   eax
 9f3:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
 9f6:	e8 fc ff ff ff       	call   9f7 <early_entry+0x3db>
 9fb:	83 c4 10             	add    esp,0x10
				/* get the memory */
				sz = kf->size / 4096 + ((kf->size % 4096) ? 1 : 0);
 9fe:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 a01:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 a04:	c1 e8 0c             	shr    eax,0xc
 a07:	89 c2                	mov    edx,eax
 a09:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 a0c:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 a0f:	25 ff 0f 00 00       	and    eax,0xfff
 a14:	85 c0                	test   eax,eax
 a16:	74 07                	je     a1f <early_entry+0x403>
 a18:	b8 01 00 00 00       	mov    eax,0x1
 a1d:	eb 05                	jmp    a24 <early_entry+0x408>
 a1f:	b8 00 00 00 00       	mov    eax,0x0
 a24:	01 d0                	add    eax,edx
 a26:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				pc = mm_alloc_pm(sz, prs, 32);
 a29:	83 ec 04             	sub    esp,0x4
 a2c:	6a 20                	push   0x20
 a2e:	8d 85 38 fe ff ff    	lea    eax,[ebp-0x1c8]
 a34:	50                   	push   eax
 a35:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
 a38:	e8 fc ff ff ff       	call   a39 <early_entry+0x41d>
 a3d:	83 c4 10             	add    esp,0x10
 a40:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				if (pc != sz) {
 a43:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
 a46:	3b 45 c4             	cmp    eax,DWORD PTR [ebp-0x3c]
 a49:	74 13                	je     a5e <early_entry+0x442>
						puts("unable to allocate memory for kernel image.");
 a4b:	83 ec 0c             	sub    esp,0xc
 a4e:	68 7c 01 00 00       	push   0x17c
 a53:	e8 fc ff ff ff       	call   a54 <early_entry+0x438>
 a58:	83 c4 10             	add    esp,0x10
						while (1);
 a5b:	90                   	nop
 a5c:	eb fd                	jmp    a5b <early_entry+0x43f>
				}

				if (fat16_read(clst, cct, kf->size, prs, 32)) {
 a5e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 a61:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 a64:	8b 55 b8             	mov    edx,DWORD PTR [ebp-0x48]
 a67:	89 d1                	mov    ecx,edx
 a69:	83 ec 0c             	sub    esp,0xc
 a6c:	6a 20                	push   0x20
 a6e:	8d 95 38 fe ff ff    	lea    edx,[ebp-0x1c8]
 a74:	52                   	push   edx
 a75:	50                   	push   eax
 a76:	51                   	push   ecx
 a77:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
 a7a:	e8 fc ff ff ff       	call   a7b <early_entry+0x45f>
 a7f:	83 c4 20             	add    esp,0x20
 a82:	85 c0                	test   eax,eax
 a84:	74 13                	je     a99 <early_entry+0x47d>
						puts("failed reading kernel. halting...");
 a86:	83 ec 0c             	sub    esp,0xc
 a89:	68 a8 01 00 00       	push   0x1a8
 a8e:	e8 fc ff ff ff       	call   a8f <early_entry+0x473>
 a93:	83 c4 10             	add    esp,0x10
						while (1);
 a96:	90                   	nop
 a97:	eb fd                	jmp    a96 <early_entry+0x47a>
			 	} else
						puts("done reading kernel.");
 a99:	83 ec 0c             	sub    esp,0xc
 a9c:	68 ca 01 00 00       	push   0x1ca
 aa1:	e8 fc ff ff ff       	call   aa2 <early_entry+0x486>
 aa6:	83 c4 10             	add    esp,0x10

				/* and map it correctly */
				uint64_t map_elf_image(int, uint32_t, struct page_range*, int);
				rv = map_elf_image(mode, sz, prs, 32);
 aa9:	6a 20                	push   0x20
 aab:	8d 85 38 fe ff ff    	lea    eax,[ebp-0x1c8]
 ab1:	50                   	push   eax
 ab2:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
 ab5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 ab8:	e8 fc ff ff ff       	call   ab9 <early_entry+0x49d>
 abd:	83 c4 10             	add    esp,0x10
 ac0:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 ac3:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
//		}
//
//		/* now select the video mode */
//		void vga_init();
//		vga_init();
		return rv;
 ac6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 ac9:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
}
 acc:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
 acf:	c9                   	leave
 ad0:	c3                   	ret
