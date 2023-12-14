
elf.o:     file format elf32-i386


Disassembly of section .text:

00000000 <putb>:
//				buffer++;
//		}
//}

void putb(uint8_t bt)
{
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 28             	sub    esp,0x28
   6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   9:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		char st[3];
		for (int i = 0; i < 2; i++) {
   c:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
  13:	eb 47                	jmp    5c <putb+0x5c>
				char c = i ? (bt & 0xf) : (bt >> 4);
  15:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
  19:	74 09                	je     24 <putb+0x24>
  1b:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
  1f:	83 e0 0f             	and    eax,0xf
  22:	eb 07                	jmp    2b <putb+0x2b>
  24:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
  28:	c0 e8 04             	shr    al,0x4
  2b:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
				if (c > 9)
  2e:	80 7d f3 09          	cmp    BYTE PTR [ebp-0xd],0x9
  32:	7e 0c                	jle    40 <putb+0x40>
						c = 'a' + c - 10;
  34:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
  38:	83 c0 57             	add    eax,0x57
  3b:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
  3e:	eb 0a                	jmp    4a <putb+0x4a>
				else
						c = '0' + c;
  40:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
  44:	83 c0 30             	add    eax,0x30
  47:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
				st[i] = c;
  4a:	8d 55 f0             	lea    edx,[ebp-0x10]
  4d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  50:	01 c2                	add    edx,eax
  52:	0f b6 45 f3          	movzx  eax,BYTE PTR [ebp-0xd]
  56:	88 02                	mov    BYTE PTR [edx],al
		for (int i = 0; i < 2; i++) {
  58:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
  5c:	83 7d f4 01          	cmp    DWORD PTR [ebp-0xc],0x1
  60:	7e b3                	jle    15 <putb+0x15>
		}
		st[2] = 0;
  62:	c6 45 f2 00          	mov    BYTE PTR [ebp-0xe],0x0
		putstr(st);
  66:	83 ec 0c             	sub    esp,0xc
  69:	8d 45 f0             	lea    eax,[ebp-0x10]
  6c:	50                   	push   eax
  6d:	e8 fc ff ff ff       	call   6e <putb+0x6e>
  72:	83 c4 10             	add    esp,0x10
}
  75:	90                   	nop
  76:	c9                   	leave
  77:	c3                   	ret

00000078 <elf_offset>:
//		}
//}

/* returns null if structure spans non-cont. pages */
void* elf_offset(struct page_range* pr, int prc, Elf64_Off o, size_t len)
{
  78:	55                   	push   ebp
  79:	89 e5                	mov    ebp,esp
  7b:	57                   	push   edi
  7c:	56                   	push   esi
  7d:	53                   	push   ebx
  7e:	83 ec 1c             	sub    esp,0x1c
  81:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
  84:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
  87:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
  8a:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		for (int i = 0; i < prc; i++) {
  8d:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
  94:	e9 62 01 00 00       	jmp    1fb <elf_offset+0x183>
				size_t bc = pr[i].count * 4096;
  99:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
  9c:	89 d0                	mov    eax,edx
  9e:	01 c0                	add    eax,eax
  a0:	01 d0                	add    eax,edx
  a2:	c1 e0 02             	shl    eax,0x2
  a5:	89 c2                	mov    edx,eax
  a7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  aa:	01 d0                	add    eax,edx
  ac:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
  af:	c1 e0 0c             	shl    eax,0xc
  b2:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (bc <= o) { /* no in this part */
  b5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
  b8:	ba 00 00 00 00       	mov    edx,0x0
  bd:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
  c0:	39 45 d8             	cmp    DWORD PTR [ebp-0x28],eax
  c3:	19 d1                	sbb    ecx,edx
  c5:	72 13                	jb     da <elf_offset+0x62>
						o -= bc;
  c7:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
  ca:	ba 00 00 00 00       	mov    edx,0x0
  cf:	29 45 d8             	sub    DWORD PTR [ebp-0x28],eax
  d2:	19 55 dc             	sbb    DWORD PTR [ebp-0x24],edx
						continue;
  d5:	e9 1d 01 00 00       	jmp    1f7 <elf_offset+0x17f>
				}
				if (o + len <= bc) { /* same range */
  da:	8b 4d 18             	mov    ecx,DWORD PTR [ebp+0x18]
  dd:	bb 00 00 00 00       	mov    ebx,0x0
  e2:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
  e5:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
  e8:	01 c8                	add    eax,ecx
  ea:	11 da                	adc    edx,ebx
  ec:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
  ef:	bb 00 00 00 00       	mov    ebx,0x0
  f4:	39 c1                	cmp    ecx,eax
  f6:	19 d3                	sbb    ebx,edx
  f8:	72 2a                	jb     124 <elf_offset+0xac>
						void* rv = (void*)(size_t)(pr[i].base + o);
  fa:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
  fd:	89 d0                	mov    eax,edx
  ff:	01 c0                	add    eax,eax
 101:	01 d0                	add    eax,edx
 103:	c1 e0 02             	shl    eax,0x2
 106:	89 c2                	mov    edx,eax
 108:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 10b:	01 d0                	add    eax,edx
 10d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 110:	8b 00                	mov    eax,DWORD PTR [eax]
 112:	89 c2                	mov    edx,eax
 114:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 117:	01 d0                	add    eax,edx
 119:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						return rv;
 11c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 11f:	e9 e8 00 00 00       	jmp    20c <elf_offset+0x194>
				} else if (i + 1 < prc) {
 124:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 127:	83 c0 01             	add    eax,0x1
 12a:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
 12d:	0f 8e bd 00 00 00    	jle    1f0 <elf_offset+0x178>
						/* cont? */
						if (pr[i].base + bc == pr[i + 1].base) {
 133:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 136:	89 d0                	mov    eax,edx
 138:	01 c0                	add    eax,eax
 13a:	01 d0                	add    eax,edx
 13c:	c1 e0 02             	shl    eax,0x2
 13f:	89 c2                	mov    edx,eax
 141:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 144:	01 d0                	add    eax,edx
 146:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 149:	8b 00                	mov    eax,DWORD PTR [eax]
 14b:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
 14e:	bb 00 00 00 00       	mov    ebx,0x0
 153:	01 c1                	add    ecx,eax
 155:	11 d3                	adc    ebx,edx
 157:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 15a:	8d 50 01             	lea    edx,[eax+0x1]
 15d:	89 d0                	mov    eax,edx
 15f:	01 c0                	add    eax,eax
 161:	01 d0                	add    eax,edx
 163:	c1 e0 02             	shl    eax,0x2
 166:	89 c2                	mov    edx,eax
 168:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 16b:	01 d0                	add    eax,edx
 16d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 170:	8b 00                	mov    eax,DWORD PTR [eax]
 172:	89 cf                	mov    edi,ecx
 174:	89 c6                	mov    esi,eax
 176:	89 d9                	mov    ecx,ebx
 178:	89 f8                	mov    eax,edi
 17a:	31 f0                	xor    eax,esi
 17c:	31 ca                	xor    edx,ecx
 17e:	09 d0                	or     eax,edx
 180:	75 67                	jne    1e9 <elf_offset+0x171>
								bc += pr[i + 1].count * 4096;
 182:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 185:	8d 50 01             	lea    edx,[eax+0x1]
 188:	89 d0                	mov    eax,edx
 18a:	01 c0                	add    eax,eax
 18c:	01 d0                	add    eax,edx
 18e:	c1 e0 02             	shl    eax,0x2
 191:	89 c2                	mov    edx,eax
 193:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 196:	01 d0                	add    eax,edx
 198:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 19b:	c1 e0 0c             	shl    eax,0xc
 19e:	01 45 e8             	add    DWORD PTR [ebp-0x18],eax
								if (o + len <= bc)
 1a1:	8b 4d 18             	mov    ecx,DWORD PTR [ebp+0x18]
 1a4:	bb 00 00 00 00       	mov    ebx,0x0
 1a9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 1ac:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 1af:	01 c8                	add    eax,ecx
 1b1:	11 da                	adc    edx,ebx
 1b3:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
 1b6:	bb 00 00 00 00       	mov    ebx,0x0
 1bb:	39 c1                	cmp    ecx,eax
 1bd:	19 d3                	sbb    ebx,edx
 1bf:	72 21                	jb     1e2 <elf_offset+0x16a>
										return (void*)(size_t)(pr[i].base + o);
 1c1:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 1c4:	89 d0                	mov    eax,edx
 1c6:	01 c0                	add    eax,eax
 1c8:	01 d0                	add    eax,edx
 1ca:	c1 e0 02             	shl    eax,0x2
 1cd:	89 c2                	mov    edx,eax
 1cf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 1d2:	01 d0                	add    eax,edx
 1d4:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 1d7:	8b 00                	mov    eax,DWORD PTR [eax]
 1d9:	89 c2                	mov    edx,eax
 1db:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 1de:	01 d0                	add    eax,edx
 1e0:	eb 2a                	jmp    20c <elf_offset+0x194>
								else
										return 0;
 1e2:	b8 00 00 00 00       	mov    eax,0x0
 1e7:	eb 23                	jmp    20c <elf_offset+0x194>
						} else
								return 0;
 1e9:	b8 00 00 00 00       	mov    eax,0x0
 1ee:	eb 1c                	jmp    20c <elf_offset+0x194>
				} else
						return 0;
 1f0:	b8 00 00 00 00       	mov    eax,0x0
 1f5:	eb 15                	jmp    20c <elf_offset+0x194>
		for (int i = 0; i < prc; i++) {
 1f7:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
 1fb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 1fe:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
 201:	0f 8c 92 fe ff ff    	jl     99 <elf_offset+0x21>
		}
		return 0;
 207:	b8 00 00 00 00       	mov    eax,0x0
}
 20c:	83 c4 1c             	add    esp,0x1c
 20f:	5b                   	pop    ebx
 210:	5e                   	pop    esi
 211:	5f                   	pop    edi
 212:	5d                   	pop    ebp
 213:	c3                   	ret

00000214 <map_elf64>:

/* elf64 format files */
uint64_t map_elf64(uint32_t pct, struct page_range* pr, int prc)
{
 214:	55                   	push   ebp
 215:	89 e5                	mov    ebp,esp
 217:	57                   	push   edi
 218:	56                   	push   esi
 219:	53                   	push   ebx
 21a:	81 ec cc 01 00 00    	sub    esp,0x1cc
		Elf64_Addr rv;
		Elf64_Ehdr* hdr = (Elf64_Ehdr*)(size_t)pr->base;
 220:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 223:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 226:	8b 00                	mov    eax,DWORD PTR [eax]
 228:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		/*Elf64_Shdr* shdr; not needed */ size_t i;
		Elf64_Phdr* phdr;

		putstr("ELF64 mapping"); put32(pct); puts(" pages");
 22b:	83 ec 0c             	sub    esp,0xc
 22e:	68 00 00 00 00       	push   0x0
 233:	e8 fc ff ff ff       	call   234 <map_elf64+0x20>
 238:	83 c4 10             	add    esp,0x10
 23b:	83 ec 0c             	sub    esp,0xc
 23e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 241:	e8 fc ff ff ff       	call   242 <map_elf64+0x2e>
 246:	83 c4 10             	add    esp,0x10
 249:	83 ec 0c             	sub    esp,0xc
 24c:	68 0e 00 00 00       	push   0xe
 251:	e8 fc ff ff ff       	call   252 <map_elf64+0x3e>
 256:	83 c4 10             	add    esp,0x10

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, SELFMAG) != 0)
 259:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 25c:	83 ec 04             	sub    esp,0x4
 25f:	6a 04                	push   0x4
 261:	68 15 00 00 00       	push   0x15
 266:	50                   	push   eax
 267:	e8 fc ff ff ff       	call   268 <map_elf64+0x54>
 26c:	83 c4 10             	add    esp,0x10
 26f:	85 c0                	test   eax,eax
 271:	74 0f                	je     282 <map_elf64+0x6e>
				return -1;
 273:	b8 ff ff ff ff       	mov    eax,0xffffffff
 278:	ba ff ff ff ff       	mov    edx,0xffffffff
 27d:	e9 72 03 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (hdr->e_ident[EI_CLASS] != ELFCLASS64)
 282:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 285:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
 289:	3c 02                	cmp    al,0x2
 28b:	74 0f                	je     29c <map_elf64+0x88>
				return -1;
 28d:	b8 ff ff ff ff       	mov    eax,0xffffffff
 292:	ba ff ff ff ff       	mov    edx,0xffffffff
 297:	e9 58 03 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
 29c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 29f:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
 2a3:	3c 01                	cmp    al,0x1
 2a5:	74 0f                	je     2b6 <map_elf64+0xa2>
				return -1;
 2a7:	b8 ff ff ff ff       	mov    eax,0xffffffff
 2ac:	ba ff ff ff ff       	mov    edx,0xffffffff
 2b1:	e9 3e 03 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
 2b6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 2b9:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
 2bd:	3c 01                	cmp    al,0x1
 2bf:	74 0f                	je     2d0 <map_elf64+0xbc>
				return -1;
 2c1:	b8 ff ff ff ff       	mov    eax,0xffffffff
 2c6:	ba ff ff ff ff       	mov    edx,0xffffffff
 2cb:	e9 24 03 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
 2d0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 2d3:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
 2d7:	84 c0                	test   al,al
 2d9:	74 0f                	je     2ea <map_elf64+0xd6>
				return -1;
 2db:	b8 ff ff ff ff       	mov    eax,0xffffffff
 2e0:	ba ff ff ff ff       	mov    edx,0xffffffff
 2e5:	e9 0a 03 00 00       	jmp    5f4 <map_elf64+0x3e0>

		/* matching ELF64 found -> check for object file */
		if (hdr->e_type != ET_EXEC)
 2ea:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 2ed:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
 2f1:	66 83 f8 02          	cmp    ax,0x2
 2f5:	74 0f                	je     306 <map_elf64+0xf2>
				return -1;
 2f7:	b8 ff ff ff ff       	mov    eax,0xffffffff
 2fc:	ba ff ff ff ff       	mov    edx,0xffffffff
 301:	e9 ee 02 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (hdr->e_machine != EM_X86_64)
 306:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 309:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
 30d:	66 83 f8 3e          	cmp    ax,0x3e
 311:	74 0f                	je     322 <map_elf64+0x10e>
				return -1;
 313:	b8 ff ff ff ff       	mov    eax,0xffffffff
 318:	ba ff ff ff ff       	mov    edx,0xffffffff
 31d:	e9 d2 02 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (hdr->e_ehsize != sizeof(*hdr))
 322:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 325:	0f b7 40 34          	movzx  eax,WORD PTR [eax+0x34]
 329:	66 83 f8 40          	cmp    ax,0x40
 32d:	74 0f                	je     33e <map_elf64+0x12a>
				return -1;
 32f:	b8 ff ff ff ff       	mov    eax,0xffffffff
 334:	ba ff ff ff ff       	mov    edx,0xffffffff
 339:	e9 b6 02 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (!hdr->e_phnum) /* PH count */
 33e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 341:	0f b7 40 38          	movzx  eax,WORD PTR [eax+0x38]
 345:	66 85 c0             	test   ax,ax
 348:	75 0f                	jne    359 <map_elf64+0x145>
				return -1;
 34a:	b8 ff ff ff ff       	mov    eax,0xffffffff
 34f:	ba ff ff ff ff       	mov    edx,0xffffffff
 354:	e9 9b 02 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (!hdr->e_shnum) /* section count */
 359:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 35c:	0f b7 40 3c          	movzx  eax,WORD PTR [eax+0x3c]
 360:	66 85 c0             	test   ax,ax
 363:	75 0f                	jne    374 <map_elf64+0x160>
				return -1;
 365:	b8 ff ff ff ff       	mov    eax,0xffffffff
 36a:	ba ff ff ff ff       	mov    edx,0xffffffff
 36f:	e9 80 02 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (hdr->e_shentsize != sizeof(Elf64_Shdr))
 374:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 377:	0f b7 40 3a          	movzx  eax,WORD PTR [eax+0x3a]
 37b:	66 83 f8 40          	cmp    ax,0x40
 37f:	74 0f                	je     390 <map_elf64+0x17c>
				return -1;
 381:	b8 ff ff ff ff       	mov    eax,0xffffffff
 386:	ba ff ff ff ff       	mov    edx,0xffffffff
 38b:	e9 64 02 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (hdr->e_phentsize != sizeof(Elf64_Phdr))
 390:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 393:	0f b7 40 36          	movzx  eax,WORD PTR [eax+0x36]
 397:	66 83 f8 38          	cmp    ax,0x38
 39b:	74 0f                	je     3ac <map_elf64+0x198>
				return -1;
 39d:	b8 ff ff ff ff       	mov    eax,0xffffffff
 3a2:	ba ff ff ff ff       	mov    edx,0xffffffff
 3a7:	e9 48 02 00 00       	jmp    5f4 <map_elf64+0x3e0>
		if (hdr->e_shstrndx == SHN_UNDEF)
 3ac:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 3af:	0f b7 40 3e          	movzx  eax,WORD PTR [eax+0x3e]
 3b3:	66 85 c0             	test   ax,ax
 3b6:	75 0f                	jne    3c7 <map_elf64+0x1b3>
				return -1; /* no strtab (needed for symbols) */
 3b8:	b8 ff ff ff ff       	mov    eax,0xffffffff
 3bd:	ba ff ff ff ff       	mov    edx,0xffffffff
 3c2:	e9 2d 02 00 00       	jmp    5f4 <map_elf64+0x3e0>

		rv = hdr->e_entry;
 3c7:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 3ca:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
 3cd:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 3d0:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 3d3:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx

		/* interprete the program headers */
		/* (only suitable for specially prepared (aligned) images)
		 * created by the Makefile for the kernel.elf file. */
		for (i = 0; i < hdr->e_phnum; i++) {
 3d6:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
 3dd:	e9 f9 01 00 00       	jmp    5db <map_elf64+0x3c7>
				struct page_range pr2[32]; size_t pr2c = 32;
 3e2:	c7 45 d4 20 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x20
				phdr = elf_offset(pr, prc, hdr->e_phoff
 3e9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 3ec:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
 3ef:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
						+ i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
 3f2:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 3f5:	6b c9 38             	imul   ecx,ecx,0x38
 3f8:	bb 00 00 00 00       	mov    ebx,0x0
				phdr = elf_offset(pr, prc, hdr->e_phoff
 3fd:	01 c8                	add    eax,ecx
 3ff:	11 da                	adc    edx,ebx
 401:	83 ec 0c             	sub    esp,0xc
 404:	6a 38                	push   0x38
 406:	52                   	push   edx
 407:	50                   	push   eax
 408:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 40b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 40e:	e8 fc ff ff ff       	call   40f <map_elf64+0x1fb>
 413:	83 c4 20             	add    esp,0x20
 416:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				if (!phdr) {
 419:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
 41d:	75 13                	jne    432 <map_elf64+0x21e>
						puts("Phdr spans multiple pages: Impelemnt copying.");
 41f:	83 ec 0c             	sub    esp,0xc
 422:	68 1c 00 00 00       	push   0x1c
 427:	e8 fc ff ff ff       	call   428 <map_elf64+0x214>
 42c:	83 c4 10             	add    esp,0x10
						while (1);
 42f:	90                   	nop
 430:	eb fd                	jmp    42f <map_elf64+0x21b>
				}
				/* show its contents */
				switch (phdr->p_type) {
 432:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 435:	8b 00                	mov    eax,DWORD PTR [eax]
 437:	83 f8 01             	cmp    eax,0x1
 43a:	74 10                	je     44c <map_elf64+0x238>
 43c:	3d 51 e5 74 64       	cmp    eax,0x6474e551
 441:	0f 84 8f 01 00 00    	je     5d6 <map_elf64+0x3c2>
						}
						case PT_GNU_STACK:
									  /* maybe save stack align */
								break;
						default: /* ignore */
								break;
 447:	e9 8b 01 00 00       	jmp    5d7 <map_elf64+0x3c3>
								putstr("FOFS ");
 44c:	83 ec 0c             	sub    esp,0xc
 44f:	68 4a 00 00 00       	push   0x4a
 454:	e8 fc ff ff ff       	call   455 <map_elf64+0x241>
 459:	83 c4 10             	add    esp,0x10
								put64(phdr->p_offset);
 45c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 45f:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 462:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 465:	83 ec 08             	sub    esp,0x8
 468:	52                   	push   edx
 469:	50                   	push   eax
 46a:	e8 fc ff ff ff       	call   46b <map_elf64+0x257>
 46f:	83 c4 10             	add    esp,0x10
								putstr(" -> VMEM ");
 472:	83 ec 0c             	sub    esp,0xc
 475:	68 50 00 00 00       	push   0x50
 47a:	e8 fc ff ff ff       	call   47b <map_elf64+0x267>
 47f:	83 c4 10             	add    esp,0x10
								put64(phdr->p_vaddr);
 482:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 485:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
 488:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 48b:	83 ec 08             	sub    esp,0x8
 48e:	52                   	push   edx
 48f:	50                   	push   eax
 490:	e8 fc ff ff ff       	call   491 <map_elf64+0x27d>
 495:	83 c4 10             	add    esp,0x10
								putstr(" SZ: ");
 498:	83 ec 0c             	sub    esp,0xc
 49b:	68 5a 00 00 00       	push   0x5a
 4a0:	e8 fc ff ff ff       	call   4a1 <map_elf64+0x28d>
 4a5:	83 c4 10             	add    esp,0x10
								put64(phdr->p_memsz);
 4a8:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 4ab:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
 4ae:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 4b1:	83 ec 08             	sub    esp,0x8
 4b4:	52                   	push   edx
 4b5:	50                   	push   eax
 4b6:	e8 fc ff ff ff       	call   4b7 <map_elf64+0x2a3>
 4bb:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_R ? " R" : "  ");
 4be:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 4c1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 4c4:	83 e0 04             	and    eax,0x4
 4c7:	85 c0                	test   eax,eax
 4c9:	74 07                	je     4d2 <map_elf64+0x2be>
 4cb:	b8 60 00 00 00       	mov    eax,0x60
 4d0:	eb 05                	jmp    4d7 <map_elf64+0x2c3>
 4d2:	b8 63 00 00 00       	mov    eax,0x63
 4d7:	83 ec 0c             	sub    esp,0xc
 4da:	50                   	push   eax
 4db:	e8 fc ff ff ff       	call   4dc <map_elf64+0x2c8>
 4e0:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_W ? "W" : " ");
 4e3:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 4e6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 4e9:	83 e0 02             	and    eax,0x2
 4ec:	85 c0                	test   eax,eax
 4ee:	74 07                	je     4f7 <map_elf64+0x2e3>
 4f0:	b8 66 00 00 00       	mov    eax,0x66
 4f5:	eb 05                	jmp    4fc <map_elf64+0x2e8>
 4f7:	b8 68 00 00 00       	mov    eax,0x68
 4fc:	83 ec 0c             	sub    esp,0xc
 4ff:	50                   	push   eax
 500:	e8 fc ff ff ff       	call   501 <map_elf64+0x2ed>
 505:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_X ? "X" : " ");
 508:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 50b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 50e:	83 e0 01             	and    eax,0x1
 511:	85 c0                	test   eax,eax
 513:	74 07                	je     51c <map_elf64+0x308>
 515:	b8 6a 00 00 00       	mov    eax,0x6a
 51a:	eb 05                	jmp    521 <map_elf64+0x30d>
 51c:	b8 68 00 00 00       	mov    eax,0x68
 521:	83 ec 0c             	sub    esp,0xc
 524:	50                   	push   eax
 525:	e8 fc ff ff ff       	call   526 <map_elf64+0x312>
 52a:	83 c4 10             	add    esp,0x10
								put_nl();
 52d:	e8 fc ff ff ff       	call   52e <map_elf64+0x31a>
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
 532:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 535:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								mm_perform_mapping(2, phdr->p_offset, pr, prc,
 538:	83 e0 02             	and    eax,0x2
 53b:	89 c2                	mov    edx,eax
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
 53d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 540:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								mm_perform_mapping(2, phdr->p_offset, pr, prc,
 543:	83 e0 01             	and    eax,0x1
 546:	89 85 44 fe ff ff    	mov    DWORD PTR [ebp-0x1bc],eax
 54c:	8b 5d d4             	mov    ebx,DWORD PTR [ebp-0x2c]
 54f:	89 9d 40 fe ff ff    	mov    DWORD PTR [ebp-0x1c0],ebx
 555:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 558:	8b 58 28             	mov    ebx,DWORD PTR [eax+0x28]
 55b:	8b 70 2c             	mov    esi,DWORD PTR [eax+0x2c]
 55e:	89 9d 38 fe ff ff    	mov    DWORD PTR [ebp-0x1c8],ebx
 564:	89 b5 3c fe ff ff    	mov    DWORD PTR [ebp-0x1c4],esi
 56a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 56d:	8b 70 20             	mov    esi,DWORD PTR [eax+0x20]
 570:	8b 78 24             	mov    edi,DWORD PTR [eax+0x24]
 573:	89 b5 30 fe ff ff    	mov    DWORD PTR [ebp-0x1d0],esi
 579:	89 bd 34 fe ff ff    	mov    DWORD PTR [ebp-0x1cc],edi
 57f:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 582:	8b 70 10             	mov    esi,DWORD PTR [eax+0x10]
 585:	8b 78 14             	mov    edi,DWORD PTR [eax+0x14]
 588:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 58b:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
 58e:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
 591:	83 ec 04             	sub    esp,0x4
 594:	52                   	push   edx
 595:	ff b5 44 fe ff ff    	push   DWORD PTR [ebp-0x1bc]
 59b:	ff b5 40 fe ff ff    	push   DWORD PTR [ebp-0x1c0]
 5a1:	8d 85 50 fe ff ff    	lea    eax,[ebp-0x1b0]
 5a7:	50                   	push   eax
 5a8:	ff b5 3c fe ff ff    	push   DWORD PTR [ebp-0x1c4]
 5ae:	ff b5 38 fe ff ff    	push   DWORD PTR [ebp-0x1c8]
 5b4:	ff b5 34 fe ff ff    	push   DWORD PTR [ebp-0x1cc]
 5ba:	ff b5 30 fe ff ff    	push   DWORD PTR [ebp-0x1d0]
 5c0:	57                   	push   edi
 5c1:	56                   	push   esi
 5c2:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 5c5:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 5c8:	53                   	push   ebx
 5c9:	51                   	push   ecx
 5ca:	6a 02                	push   0x2
 5cc:	e8 fc ff ff ff       	call   5cd <map_elf64+0x3b9>
 5d1:	83 c4 40             	add    esp,0x40
								break;
 5d4:	eb 01                	jmp    5d7 <map_elf64+0x3c3>
								break;
 5d6:	90                   	nop
		for (i = 0; i < hdr->e_phnum; i++) {
 5d7:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
 5db:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 5de:	0f b7 40 38          	movzx  eax,WORD PTR [eax+0x38]
 5e2:	0f b7 c0             	movzx  eax,ax
 5e5:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
 5e8:	0f 82 f4 fd ff ff    	jb     3e2 <map_elf64+0x1ce>
				}
		}

		/* TODO: and also preserve the symbol table */
		return rv;
 5ee:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 5f1:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
}
 5f4:	8d 65 f4             	lea    esp,[ebp-0xc]
 5f7:	5b                   	pop    ebx
 5f8:	5e                   	pop    esi
 5f9:	5f                   	pop    edi
 5fa:	5d                   	pop    ebp
 5fb:	c3                   	ret

000005fc <map_elf32>:

/* elf32 format files */
uint64_t map_elf32(int mode, uint32_t pct, struct page_range* pr, int prc)
{
 5fc:	55                   	push   ebp
 5fd:	89 e5                	mov    ebp,esp
 5ff:	57                   	push   edi
 600:	56                   	push   esi
 601:	53                   	push   ebx
 602:	81 ec cc 01 00 00    	sub    esp,0x1cc
		Elf32_Addr rv;
		Elf32_Ehdr* hdr = (Elf32_Ehdr*)(size_t)pr->base;
 608:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 60b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 60e:	8b 00                	mov    eax,DWORD PTR [eax]
 610:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		/*Elf32_Shdr* shdr; not needed*/ size_t i;
		Elf32_Phdr* phdr;

		putstr("ELF32 mapping"); put32(pct); puts(" pages");
 613:	83 ec 0c             	sub    esp,0xc
 616:	68 6c 00 00 00       	push   0x6c
 61b:	e8 fc ff ff ff       	call   61c <map_elf32+0x20>
 620:	83 c4 10             	add    esp,0x10
 623:	83 ec 0c             	sub    esp,0xc
 626:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 629:	e8 fc ff ff ff       	call   62a <map_elf32+0x2e>
 62e:	83 c4 10             	add    esp,0x10
 631:	83 ec 0c             	sub    esp,0xc
 634:	68 0e 00 00 00       	push   0xe
 639:	e8 fc ff ff ff       	call   63a <map_elf32+0x3e>
 63e:	83 c4 10             	add    esp,0x10

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, SELFMAG) != 0)
 641:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 644:	83 ec 04             	sub    esp,0x4
 647:	6a 04                	push   0x4
 649:	68 15 00 00 00       	push   0x15
 64e:	50                   	push   eax
 64f:	e8 fc ff ff ff       	call   650 <map_elf32+0x54>
 654:	83 c4 10             	add    esp,0x10
 657:	85 c0                	test   eax,eax
 659:	74 0f                	je     66a <map_elf32+0x6e>
				return -1;
 65b:	b8 ff ff ff ff       	mov    eax,0xffffffff
 660:	ba ff ff ff ff       	mov    edx,0xffffffff
 665:	e9 7f 03 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (hdr->e_ident[EI_CLASS] != ELFCLASS32)
 66a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 66d:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
 671:	3c 01                	cmp    al,0x1
 673:	74 0f                	je     684 <map_elf32+0x88>
				return -1;
 675:	b8 ff ff ff ff       	mov    eax,0xffffffff
 67a:	ba ff ff ff ff       	mov    edx,0xffffffff
 67f:	e9 65 03 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
 684:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 687:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
 68b:	3c 01                	cmp    al,0x1
 68d:	74 0f                	je     69e <map_elf32+0xa2>
				return -1;
 68f:	b8 ff ff ff ff       	mov    eax,0xffffffff
 694:	ba ff ff ff ff       	mov    edx,0xffffffff
 699:	e9 4b 03 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
 69e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6a1:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
 6a5:	3c 01                	cmp    al,0x1
 6a7:	74 0f                	je     6b8 <map_elf32+0xbc>
				return -1;
 6a9:	b8 ff ff ff ff       	mov    eax,0xffffffff
 6ae:	ba ff ff ff ff       	mov    edx,0xffffffff
 6b3:	e9 31 03 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
 6b8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6bb:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
 6bf:	84 c0                	test   al,al
 6c1:	74 0f                	je     6d2 <map_elf32+0xd6>
				return -1;
 6c3:	b8 ff ff ff ff       	mov    eax,0xffffffff
 6c8:	ba ff ff ff ff       	mov    edx,0xffffffff
 6cd:	e9 17 03 00 00       	jmp    9e9 <map_elf32+0x3ed>

		/* matching ELF32 found -> check for object file */
		if (hdr->e_type != ET_EXEC)
 6d2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6d5:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
 6d9:	66 83 f8 02          	cmp    ax,0x2
 6dd:	74 0f                	je     6ee <map_elf32+0xf2>
				return -1;
 6df:	b8 ff ff ff ff       	mov    eax,0xffffffff
 6e4:	ba ff ff ff ff       	mov    edx,0xffffffff
 6e9:	e9 fb 02 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (hdr->e_machine != EM_386)
 6ee:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6f1:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
 6f5:	66 83 f8 03          	cmp    ax,0x3
 6f9:	74 0f                	je     70a <map_elf32+0x10e>
				return -1;
 6fb:	b8 ff ff ff ff       	mov    eax,0xffffffff
 700:	ba ff ff ff ff       	mov    edx,0xffffffff
 705:	e9 df 02 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (hdr->e_ehsize != sizeof(*hdr))
 70a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 70d:	0f b7 40 28          	movzx  eax,WORD PTR [eax+0x28]
 711:	66 83 f8 34          	cmp    ax,0x34
 715:	74 0f                	je     726 <map_elf32+0x12a>
				return -1;
 717:	b8 ff ff ff ff       	mov    eax,0xffffffff
 71c:	ba ff ff ff ff       	mov    edx,0xffffffff
 721:	e9 c3 02 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (!hdr->e_phnum) /* PH count */
 726:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 729:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
 72d:	66 85 c0             	test   ax,ax
 730:	75 0f                	jne    741 <map_elf32+0x145>
				return -1;
 732:	b8 ff ff ff ff       	mov    eax,0xffffffff
 737:	ba ff ff ff ff       	mov    edx,0xffffffff
 73c:	e9 a8 02 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (!hdr->e_shnum) /* section count */
 741:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 744:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
 748:	66 85 c0             	test   ax,ax
 74b:	75 0f                	jne    75c <map_elf32+0x160>
				return -1;
 74d:	b8 ff ff ff ff       	mov    eax,0xffffffff
 752:	ba ff ff ff ff       	mov    edx,0xffffffff
 757:	e9 8d 02 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (hdr->e_shentsize != sizeof(Elf32_Shdr))
 75c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 75f:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
 763:	66 83 f8 28          	cmp    ax,0x28
 767:	74 0f                	je     778 <map_elf32+0x17c>
				return -1;
 769:	b8 ff ff ff ff       	mov    eax,0xffffffff
 76e:	ba ff ff ff ff       	mov    edx,0xffffffff
 773:	e9 71 02 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (hdr->e_phentsize != sizeof(Elf32_Phdr))
 778:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 77b:	0f b7 40 2a          	movzx  eax,WORD PTR [eax+0x2a]
 77f:	66 83 f8 20          	cmp    ax,0x20
 783:	74 0f                	je     794 <map_elf32+0x198>
				return -1;
 785:	b8 ff ff ff ff       	mov    eax,0xffffffff
 78a:	ba ff ff ff ff       	mov    edx,0xffffffff
 78f:	e9 55 02 00 00       	jmp    9e9 <map_elf32+0x3ed>
		if (hdr->e_shstrndx == SHN_UNDEF)
 794:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 797:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
 79b:	66 85 c0             	test   ax,ax
 79e:	75 0f                	jne    7af <map_elf32+0x1b3>
				return -1; /* no strtab (needed for symbols) */
 7a0:	b8 ff ff ff ff       	mov    eax,0xffffffff
 7a5:	ba ff ff ff ff       	mov    edx,0xffffffff
 7aa:	e9 3a 02 00 00       	jmp    9e9 <map_elf32+0x3ed>

		rv = hdr->e_entry;
 7af:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 7b2:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 7b5:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		/* interprete the program headers */
		/* (only suitable for specially prepared (aligned) images)
		 * created by the Makefile for the kernel.elf file. */
		for (i = 0; i < hdr->e_phnum; i++) {
 7b8:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
 7bf:	e9 0a 02 00 00       	jmp    9ce <map_elf32+0x3d2>
				struct page_range pr2[32]; size_t pr2c = 32;
 7c4:	c7 45 d8 20 00 00 00 	mov    DWORD PTR [ebp-0x28],0x20
				bzero(pr2, sizeof(pr2));
 7cb:	83 ec 08             	sub    esp,0x8
 7ce:	68 80 01 00 00       	push   0x180
 7d3:	8d 85 54 fe ff ff    	lea    eax,[ebp-0x1ac]
 7d9:	50                   	push   eax
 7da:	e8 fc ff ff ff       	call   7db <map_elf32+0x1df>
 7df:	83 c4 10             	add    esp,0x10
				phdr = elf_offset(pr, prc, hdr->e_phoff
 7e2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 7e5:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
						+ i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
 7e8:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 7eb:	c1 e2 05             	shl    edx,0x5
 7ee:	01 d0                	add    eax,edx
				phdr = elf_offset(pr, prc, hdr->e_phoff
 7f0:	ba 00 00 00 00       	mov    edx,0x0
 7f5:	83 ec 0c             	sub    esp,0xc
 7f8:	6a 20                	push   0x20
 7fa:	52                   	push   edx
 7fb:	50                   	push   eax
 7fc:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 7ff:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 802:	e8 fc ff ff ff       	call   803 <map_elf32+0x207>
 807:	83 c4 20             	add    esp,0x20
 80a:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				if (!phdr) {
 80d:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
 811:	75 13                	jne    826 <map_elf32+0x22a>
						puts("Phdr spans multiple pages: Impelemnt copying.");
 813:	83 ec 0c             	sub    esp,0xc
 816:	68 1c 00 00 00       	push   0x1c
 81b:	e8 fc ff ff ff       	call   81c <map_elf32+0x220>
 820:	83 c4 10             	add    esp,0x10
						while (1);
 823:	90                   	nop
 824:	eb fd                	jmp    823 <map_elf32+0x227>
				}
				/* show its contents */
				switch (phdr->p_type) {
 826:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 829:	8b 00                	mov    eax,DWORD PTR [eax]
 82b:	83 f8 01             	cmp    eax,0x1
 82e:	74 10                	je     840 <map_elf32+0x244>
 830:	3d 51 e5 74 64       	cmp    eax,0x6474e551
 835:	0f 84 8e 01 00 00    	je     9c9 <map_elf32+0x3cd>
						}
						case PT_GNU_STACK:
									  /* maybe save stack align */
								break;
						default: /* ignore */
								break;
 83b:	e9 8a 01 00 00       	jmp    9ca <map_elf32+0x3ce>
								putstr("FOFS ");
 840:	83 ec 0c             	sub    esp,0xc
 843:	68 4a 00 00 00       	push   0x4a
 848:	e8 fc ff ff ff       	call   849 <map_elf32+0x24d>
 84d:	83 c4 10             	add    esp,0x10
								put32(phdr->p_offset);
 850:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 853:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 856:	83 ec 0c             	sub    esp,0xc
 859:	50                   	push   eax
 85a:	e8 fc ff ff ff       	call   85b <map_elf32+0x25f>
 85f:	83 c4 10             	add    esp,0x10
								putstr(" -> VMEM ");
 862:	83 ec 0c             	sub    esp,0xc
 865:	68 50 00 00 00       	push   0x50
 86a:	e8 fc ff ff ff       	call   86b <map_elf32+0x26f>
 86f:	83 c4 10             	add    esp,0x10
								put32(phdr->p_vaddr);
 872:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 875:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 878:	83 ec 0c             	sub    esp,0xc
 87b:	50                   	push   eax
 87c:	e8 fc ff ff ff       	call   87d <map_elf32+0x281>
 881:	83 c4 10             	add    esp,0x10
								putstr(" SZ: ");
 884:	83 ec 0c             	sub    esp,0xc
 887:	68 5a 00 00 00       	push   0x5a
 88c:	e8 fc ff ff ff       	call   88d <map_elf32+0x291>
 891:	83 c4 10             	add    esp,0x10
								put32(phdr->p_memsz);
 894:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 897:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
 89a:	83 ec 0c             	sub    esp,0xc
 89d:	50                   	push   eax
 89e:	e8 fc ff ff ff       	call   89f <map_elf32+0x2a3>
 8a3:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_R ? " R" : "  ");
 8a6:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 8a9:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 8ac:	83 e0 04             	and    eax,0x4
 8af:	85 c0                	test   eax,eax
 8b1:	74 07                	je     8ba <map_elf32+0x2be>
 8b3:	b8 60 00 00 00       	mov    eax,0x60
 8b8:	eb 05                	jmp    8bf <map_elf32+0x2c3>
 8ba:	b8 63 00 00 00       	mov    eax,0x63
 8bf:	83 ec 0c             	sub    esp,0xc
 8c2:	50                   	push   eax
 8c3:	e8 fc ff ff ff       	call   8c4 <map_elf32+0x2c8>
 8c8:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_W ? "W" : " ");
 8cb:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 8ce:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 8d1:	83 e0 02             	and    eax,0x2
 8d4:	85 c0                	test   eax,eax
 8d6:	74 07                	je     8df <map_elf32+0x2e3>
 8d8:	b8 66 00 00 00       	mov    eax,0x66
 8dd:	eb 05                	jmp    8e4 <map_elf32+0x2e8>
 8df:	b8 68 00 00 00       	mov    eax,0x68
 8e4:	83 ec 0c             	sub    esp,0xc
 8e7:	50                   	push   eax
 8e8:	e8 fc ff ff ff       	call   8e9 <map_elf32+0x2ed>
 8ed:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_X ? "X" : " ");
 8f0:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 8f3:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 8f6:	83 e0 01             	and    eax,0x1
 8f9:	85 c0                	test   eax,eax
 8fb:	74 07                	je     904 <map_elf32+0x308>
 8fd:	b8 6a 00 00 00       	mov    eax,0x6a
 902:	eb 05                	jmp    909 <map_elf32+0x30d>
 904:	b8 68 00 00 00       	mov    eax,0x68
 909:	83 ec 0c             	sub    esp,0xc
 90c:	50                   	push   eax
 90d:	e8 fc ff ff ff       	call   90e <map_elf32+0x312>
 912:	83 c4 10             	add    esp,0x10
								put_nl();
 915:	e8 fc ff ff ff       	call   916 <map_elf32+0x31a>
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
 91a:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 91d:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 920:	83 e0 02             	and    eax,0x2
 923:	89 c2                	mov    edx,eax
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
 925:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 928:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 92b:	83 e0 01             	and    eax,0x1
 92e:	89 85 44 fe ff ff    	mov    DWORD PTR [ebp-0x1bc],eax
 934:	8b 5d d8             	mov    ebx,DWORD PTR [ebp-0x28]
 937:	89 9d 40 fe ff ff    	mov    DWORD PTR [ebp-0x1c0],ebx
												phdr->p_vaddr, phdr->p_filesz, phdr->p_memsz, pr2, pr2c,
 93d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 940:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 943:	89 85 38 fe ff ff    	mov    DWORD PTR [ebp-0x1c8],eax
 949:	c7 85 3c fe ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x1c4],0x0
												phdr->p_vaddr, phdr->p_filesz, phdr->p_memsz, pr2, pr2c,
 953:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 956:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 959:	89 85 30 fe ff ff    	mov    DWORD PTR [ebp-0x1d0],eax
 95f:	c7 85 34 fe ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x1cc],0x0
												phdr->p_vaddr, phdr->p_filesz, phdr->p_memsz, pr2, pr2c,
 969:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 96c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 96f:	89 c6                	mov    esi,eax
 971:	bf 00 00 00 00       	mov    edi,0x0
 976:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 979:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 97c:	89 c1                	mov    ecx,eax
 97e:	bb 00 00 00 00       	mov    ebx,0x0
 983:	83 ec 04             	sub    esp,0x4
 986:	52                   	push   edx
 987:	ff b5 44 fe ff ff    	push   DWORD PTR [ebp-0x1bc]
 98d:	ff b5 40 fe ff ff    	push   DWORD PTR [ebp-0x1c0]
 993:	8d 85 54 fe ff ff    	lea    eax,[ebp-0x1ac]
 999:	50                   	push   eax
 99a:	ff b5 3c fe ff ff    	push   DWORD PTR [ebp-0x1c4]
 9a0:	ff b5 38 fe ff ff    	push   DWORD PTR [ebp-0x1c8]
 9a6:	ff b5 34 fe ff ff    	push   DWORD PTR [ebp-0x1cc]
 9ac:	ff b5 30 fe ff ff    	push   DWORD PTR [ebp-0x1d0]
 9b2:	57                   	push   edi
 9b3:	56                   	push   esi
 9b4:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 9b7:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 9ba:	53                   	push   ebx
 9bb:	51                   	push   ecx
 9bc:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 9bf:	e8 fc ff ff ff       	call   9c0 <map_elf32+0x3c4>
 9c4:	83 c4 40             	add    esp,0x40
								break;
 9c7:	eb 01                	jmp    9ca <map_elf32+0x3ce>
								break;
 9c9:	90                   	nop
		for (i = 0; i < hdr->e_phnum; i++) {
 9ca:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
 9ce:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 9d1:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
 9d5:	0f b7 c0             	movzx  eax,ax
 9d8:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
 9db:	0f 82 e3 fd ff ff    	jb     7c4 <map_elf32+0x1c8>
				}
		}

		/* TODO: and also preserve the symbol table */
		return rv;
 9e1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 9e4:	ba 00 00 00 00       	mov    edx,0x0
}
 9e9:	8d 65 f4             	lea    esp,[ebp-0xc]
 9ec:	5b                   	pop    ebx
 9ed:	5e                   	pop    esi
 9ee:	5f                   	pop    edi
 9ef:	5d                   	pop    ebp
 9f0:	c3                   	ret

000009f1 <map_elf_image>:

uint64_t map_elf_image(int mode, uint32_t pct, struct page_range* pr, int prc)
{
 9f1:	55                   	push   ebp
 9f2:	89 e5                	mov    ebp,esp
 9f4:	83 ec 18             	sub    esp,0x18
//		}
		/* we don't have to perform relocations as we deal with
		 * an executable image with program headers. We only
		 * have to (possibly) move the individual sections to
		 * different memory pages and map them accordingly. */
		if (mode == 2)
 9f7:	83 7d 08 02          	cmp    DWORD PTR [ebp+0x8],0x2
 9fb:	75 1c                	jne    a19 <map_elf_image+0x28>
				rv = map_elf64(pct, pr, prc);
 9fd:	83 ec 04             	sub    esp,0x4
 a00:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 a03:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 a06:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 a09:	e8 fc ff ff ff       	call   a0a <map_elf_image+0x19>
 a0e:	83 c4 10             	add    esp,0x10
 a11:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 a14:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
 a17:	eb 1a                	jmp    a33 <map_elf_image+0x42>
		else
				rv = map_elf32(mode, pct, pr, prc);
 a19:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 a1c:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 a1f:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 a22:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 a25:	e8 fc ff ff ff       	call   a26 <map_elf_image+0x35>
 a2a:	83 c4 10             	add    esp,0x10
 a2d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 a30:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		return rv;
 a33:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 a36:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
}
 a39:	c9                   	leave
 a3a:	c3                   	ret
