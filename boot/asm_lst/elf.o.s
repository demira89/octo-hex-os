
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
  94:	e9 68 01 00 00       	jmp    201 <elf_offset+0x189>
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
  d5:	e9 23 01 00 00       	jmp    1fd <elf_offset+0x185>
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
  f8:	72 2d                	jb     127 <elf_offset+0xaf>
						void* rv = (void*)(pr[i].base + o);
  fa:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
  fd:	89 d0                	mov    eax,edx
  ff:	01 c0                	add    eax,eax
 101:	01 d0                	add    eax,edx
 103:	c1 e0 02             	shl    eax,0x2
 106:	89 c2                	mov    edx,eax
 108:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 10b:	01 d0                	add    eax,edx
 10d:	8b 08                	mov    ecx,DWORD PTR [eax]
 10f:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
 112:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 115:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 118:	01 c8                	add    eax,ecx
 11a:	11 da                	adc    edx,ebx
 11c:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						return rv;
 11f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 122:	e9 eb 00 00 00       	jmp    212 <elf_offset+0x19a>
				} else if (i + 1 < prc) {
 127:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 12a:	83 c0 01             	add    eax,0x1
 12d:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
 130:	0f 8e c0 00 00 00    	jle    1f6 <elf_offset+0x17e>
						/* cont? */
						if (pr[i].base + bc == pr[i + 1].base) {
 136:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 139:	89 d0                	mov    eax,edx
 13b:	01 c0                	add    eax,eax
 13d:	01 d0                	add    eax,edx
 13f:	c1 e0 02             	shl    eax,0x2
 142:	89 c2                	mov    edx,eax
 144:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 147:	01 d0                	add    eax,edx
 149:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 14c:	8b 00                	mov    eax,DWORD PTR [eax]
 14e:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
 151:	bb 00 00 00 00       	mov    ebx,0x0
 156:	01 c1                	add    ecx,eax
 158:	11 d3                	adc    ebx,edx
 15a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 15d:	8d 50 01             	lea    edx,[eax+0x1]
 160:	89 d0                	mov    eax,edx
 162:	01 c0                	add    eax,eax
 164:	01 d0                	add    eax,edx
 166:	c1 e0 02             	shl    eax,0x2
 169:	89 c2                	mov    edx,eax
 16b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 16e:	01 d0                	add    eax,edx
 170:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 173:	8b 00                	mov    eax,DWORD PTR [eax]
 175:	89 cf                	mov    edi,ecx
 177:	89 c6                	mov    esi,eax
 179:	89 d9                	mov    ecx,ebx
 17b:	89 f8                	mov    eax,edi
 17d:	31 f0                	xor    eax,esi
 17f:	31 ca                	xor    edx,ecx
 181:	09 d0                	or     eax,edx
 183:	75 6a                	jne    1ef <elf_offset+0x177>
								bc += pr[i + 1].count * 4096;
 185:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 188:	8d 50 01             	lea    edx,[eax+0x1]
 18b:	89 d0                	mov    eax,edx
 18d:	01 c0                	add    eax,eax
 18f:	01 d0                	add    eax,edx
 191:	c1 e0 02             	shl    eax,0x2
 194:	89 c2                	mov    edx,eax
 196:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 199:	01 d0                	add    eax,edx
 19b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 19e:	c1 e0 0c             	shl    eax,0xc
 1a1:	01 45 e8             	add    DWORD PTR [ebp-0x18],eax
								if (o + len <= bc)
 1a4:	8b 4d 18             	mov    ecx,DWORD PTR [ebp+0x18]
 1a7:	bb 00 00 00 00       	mov    ebx,0x0
 1ac:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 1af:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 1b2:	01 c8                	add    eax,ecx
 1b4:	11 da                	adc    edx,ebx
 1b6:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
 1b9:	bb 00 00 00 00       	mov    ebx,0x0
 1be:	39 c1                	cmp    ecx,eax
 1c0:	19 d3                	sbb    ebx,edx
 1c2:	72 24                	jb     1e8 <elf_offset+0x170>
										return (void*)(pr[i].base + o);
 1c4:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 1c7:	89 d0                	mov    eax,edx
 1c9:	01 c0                	add    eax,eax
 1cb:	01 d0                	add    eax,edx
 1cd:	c1 e0 02             	shl    eax,0x2
 1d0:	89 c2                	mov    edx,eax
 1d2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 1d5:	01 d0                	add    eax,edx
 1d7:	8b 08                	mov    ecx,DWORD PTR [eax]
 1d9:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
 1dc:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 1df:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 1e2:	01 c8                	add    eax,ecx
 1e4:	11 da                	adc    edx,ebx
 1e6:	eb 2a                	jmp    212 <elf_offset+0x19a>
								else
										return 0;
 1e8:	b8 00 00 00 00       	mov    eax,0x0
 1ed:	eb 23                	jmp    212 <elf_offset+0x19a>
						} else
								return 0;
 1ef:	b8 00 00 00 00       	mov    eax,0x0
 1f4:	eb 1c                	jmp    212 <elf_offset+0x19a>
				} else
						return 0;
 1f6:	b8 00 00 00 00       	mov    eax,0x0
 1fb:	eb 15                	jmp    212 <elf_offset+0x19a>
		for (int i = 0; i < prc; i++) {
 1fd:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
 201:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 204:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
 207:	0f 8c 8c fe ff ff    	jl     99 <elf_offset+0x21>
		}
		return 0;
 20d:	b8 00 00 00 00       	mov    eax,0x0
}
 212:	83 c4 1c             	add    esp,0x1c
 215:	5b                   	pop    ebx
 216:	5e                   	pop    esi
 217:	5f                   	pop    edi
 218:	5d                   	pop    ebp
 219:	c3                   	ret

0000021a <map_elf64>:

/* elf64 format files */
uint64_t map_elf64(uint32_t pct, struct page_range* pr, int prc)
{
 21a:	55                   	push   ebp
 21b:	89 e5                	mov    ebp,esp
 21d:	57                   	push   edi
 21e:	56                   	push   esi
 21f:	53                   	push   ebx
 220:	81 ec cc 01 00 00    	sub    esp,0x1cc
		Elf64_Addr rv;
		Elf64_Ehdr* hdr = (Elf64_Ehdr*)pr->base;
 226:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 229:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 22c:	8b 00                	mov    eax,DWORD PTR [eax]
 22e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		Elf64_Shdr* shdr; size_t i;
		Elf64_Phdr* phdr;

		puts("ELF64 mapping");
 231:	83 ec 0c             	sub    esp,0xc
 234:	68 00 00 00 00       	push   0x0
 239:	e8 fc ff ff ff       	call   23a <map_elf64+0x20>
 23e:	83 c4 10             	add    esp,0x10

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, SELFMAG) != 0)
 241:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 244:	83 ec 04             	sub    esp,0x4
 247:	6a 04                	push   0x4
 249:	68 0e 00 00 00       	push   0xe
 24e:	50                   	push   eax
 24f:	e8 fc ff ff ff       	call   250 <map_elf64+0x36>
 254:	83 c4 10             	add    esp,0x10
 257:	85 c0                	test   eax,eax
 259:	74 0f                	je     26a <map_elf64+0x50>
				return -1;
 25b:	b8 ff ff ff ff       	mov    eax,0xffffffff
 260:	ba ff ff ff ff       	mov    edx,0xffffffff
 265:	e9 72 03 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (hdr->e_ident[EI_CLASS] != ELFCLASS64)
 26a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 26d:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
 271:	3c 02                	cmp    al,0x2
 273:	74 0f                	je     284 <map_elf64+0x6a>
				return -1;
 275:	b8 ff ff ff ff       	mov    eax,0xffffffff
 27a:	ba ff ff ff ff       	mov    edx,0xffffffff
 27f:	e9 58 03 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
 284:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 287:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
 28b:	3c 01                	cmp    al,0x1
 28d:	74 0f                	je     29e <map_elf64+0x84>
				return -1;
 28f:	b8 ff ff ff ff       	mov    eax,0xffffffff
 294:	ba ff ff ff ff       	mov    edx,0xffffffff
 299:	e9 3e 03 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
 29e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 2a1:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
 2a5:	3c 01                	cmp    al,0x1
 2a7:	74 0f                	je     2b8 <map_elf64+0x9e>
				return -1;
 2a9:	b8 ff ff ff ff       	mov    eax,0xffffffff
 2ae:	ba ff ff ff ff       	mov    edx,0xffffffff
 2b3:	e9 24 03 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
 2b8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 2bb:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
 2bf:	84 c0                	test   al,al
 2c1:	74 0f                	je     2d2 <map_elf64+0xb8>
				return -1;
 2c3:	b8 ff ff ff ff       	mov    eax,0xffffffff
 2c8:	ba ff ff ff ff       	mov    edx,0xffffffff
 2cd:	e9 0a 03 00 00       	jmp    5dc <map_elf64+0x3c2>

		/* matching ELF64 found -> check for object file */
		if (hdr->e_type != ET_EXEC)
 2d2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 2d5:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
 2d9:	66 83 f8 02          	cmp    ax,0x2
 2dd:	74 0f                	je     2ee <map_elf64+0xd4>
				return -1;
 2df:	b8 ff ff ff ff       	mov    eax,0xffffffff
 2e4:	ba ff ff ff ff       	mov    edx,0xffffffff
 2e9:	e9 ee 02 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (hdr->e_machine != EM_X86_64)
 2ee:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 2f1:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
 2f5:	66 83 f8 3e          	cmp    ax,0x3e
 2f9:	74 0f                	je     30a <map_elf64+0xf0>
				return -1;
 2fb:	b8 ff ff ff ff       	mov    eax,0xffffffff
 300:	ba ff ff ff ff       	mov    edx,0xffffffff
 305:	e9 d2 02 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (hdr->e_ehsize != sizeof(*hdr))
 30a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 30d:	0f b7 40 34          	movzx  eax,WORD PTR [eax+0x34]
 311:	66 83 f8 40          	cmp    ax,0x40
 315:	74 0f                	je     326 <map_elf64+0x10c>
				return -1;
 317:	b8 ff ff ff ff       	mov    eax,0xffffffff
 31c:	ba ff ff ff ff       	mov    edx,0xffffffff
 321:	e9 b6 02 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (!hdr->e_phnum) /* PH count */
 326:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 329:	0f b7 40 38          	movzx  eax,WORD PTR [eax+0x38]
 32d:	66 85 c0             	test   ax,ax
 330:	75 0f                	jne    341 <map_elf64+0x127>
				return -1;
 332:	b8 ff ff ff ff       	mov    eax,0xffffffff
 337:	ba ff ff ff ff       	mov    edx,0xffffffff
 33c:	e9 9b 02 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (!hdr->e_shnum) /* section count */
 341:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 344:	0f b7 40 3c          	movzx  eax,WORD PTR [eax+0x3c]
 348:	66 85 c0             	test   ax,ax
 34b:	75 0f                	jne    35c <map_elf64+0x142>
				return -1;
 34d:	b8 ff ff ff ff       	mov    eax,0xffffffff
 352:	ba ff ff ff ff       	mov    edx,0xffffffff
 357:	e9 80 02 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (hdr->e_shentsize != sizeof(Elf64_Shdr))
 35c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 35f:	0f b7 40 3a          	movzx  eax,WORD PTR [eax+0x3a]
 363:	66 83 f8 40          	cmp    ax,0x40
 367:	74 0f                	je     378 <map_elf64+0x15e>
				return -1;
 369:	b8 ff ff ff ff       	mov    eax,0xffffffff
 36e:	ba ff ff ff ff       	mov    edx,0xffffffff
 373:	e9 64 02 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (hdr->e_phentsize != sizeof(Elf64_Phdr))
 378:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 37b:	0f b7 40 36          	movzx  eax,WORD PTR [eax+0x36]
 37f:	66 83 f8 38          	cmp    ax,0x38
 383:	74 0f                	je     394 <map_elf64+0x17a>
				return -1;
 385:	b8 ff ff ff ff       	mov    eax,0xffffffff
 38a:	ba ff ff ff ff       	mov    edx,0xffffffff
 38f:	e9 48 02 00 00       	jmp    5dc <map_elf64+0x3c2>
		if (hdr->e_shstrndx == SHN_UNDEF)
 394:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 397:	0f b7 40 3e          	movzx  eax,WORD PTR [eax+0x3e]
 39b:	66 85 c0             	test   ax,ax
 39e:	75 0f                	jne    3af <map_elf64+0x195>
				return -1; /* no strtab (needed for symbols) */
 3a0:	b8 ff ff ff ff       	mov    eax,0xffffffff
 3a5:	ba ff ff ff ff       	mov    edx,0xffffffff
 3aa:	e9 2d 02 00 00       	jmp    5dc <map_elf64+0x3c2>

		rv = hdr->e_entry;
 3af:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 3b2:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
 3b5:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 3b8:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 3bb:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx

		/* interprete the program headers */
		/* (only suitable for specially prepared (aligned) images)
		 * created by the Makefile for the kernel.elf file. */
		for (i = 0; i < hdr->e_phnum; i++) {
 3be:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
 3c5:	e9 f9 01 00 00       	jmp    5c3 <map_elf64+0x3a9>
				struct page_range pr2[32]; size_t pr2c = 32;
 3ca:	c7 45 d4 20 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x20
				phdr = elf_offset(pr, prc, hdr->e_phoff
 3d1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 3d4:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
 3d7:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
						+ i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
 3da:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 3dd:	6b c9 38             	imul   ecx,ecx,0x38
 3e0:	bb 00 00 00 00       	mov    ebx,0x0
				phdr = elf_offset(pr, prc, hdr->e_phoff
 3e5:	01 c8                	add    eax,ecx
 3e7:	11 da                	adc    edx,ebx
 3e9:	83 ec 0c             	sub    esp,0xc
 3ec:	6a 38                	push   0x38
 3ee:	52                   	push   edx
 3ef:	50                   	push   eax
 3f0:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 3f3:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 3f6:	e8 fc ff ff ff       	call   3f7 <map_elf64+0x1dd>
 3fb:	83 c4 20             	add    esp,0x20
 3fe:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				if (!phdr) {
 401:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
 405:	75 13                	jne    41a <map_elf64+0x200>
						puts("Phdr spans multiple pages: Impelemnt copying.");
 407:	83 ec 0c             	sub    esp,0xc
 40a:	68 14 00 00 00       	push   0x14
 40f:	e8 fc ff ff ff       	call   410 <map_elf64+0x1f6>
 414:	83 c4 10             	add    esp,0x10
						while (1);
 417:	90                   	nop
 418:	eb fd                	jmp    417 <map_elf64+0x1fd>
				}
				/* show its contents */
				switch (phdr->p_type) {
 41a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 41d:	8b 00                	mov    eax,DWORD PTR [eax]
 41f:	83 f8 01             	cmp    eax,0x1
 422:	74 10                	je     434 <map_elf64+0x21a>
 424:	3d 51 e5 74 64       	cmp    eax,0x6474e551
 429:	0f 84 8f 01 00 00    	je     5be <map_elf64+0x3a4>
						}
						case PT_GNU_STACK:
									  /* maybe save stack align */
								break;
						default: /* ignore */
								break;
 42f:	e9 8b 01 00 00       	jmp    5bf <map_elf64+0x3a5>
								putstr("FOFS ");
 434:	83 ec 0c             	sub    esp,0xc
 437:	68 42 00 00 00       	push   0x42
 43c:	e8 fc ff ff ff       	call   43d <map_elf64+0x223>
 441:	83 c4 10             	add    esp,0x10
								put64(phdr->p_offset);
 444:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 447:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
 44a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 44d:	83 ec 08             	sub    esp,0x8
 450:	52                   	push   edx
 451:	50                   	push   eax
 452:	e8 fc ff ff ff       	call   453 <map_elf64+0x239>
 457:	83 c4 10             	add    esp,0x10
								putstr(" -> VMEM ");
 45a:	83 ec 0c             	sub    esp,0xc
 45d:	68 48 00 00 00       	push   0x48
 462:	e8 fc ff ff ff       	call   463 <map_elf64+0x249>
 467:	83 c4 10             	add    esp,0x10
								put64(phdr->p_vaddr);
 46a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 46d:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
 470:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
 473:	83 ec 08             	sub    esp,0x8
 476:	52                   	push   edx
 477:	50                   	push   eax
 478:	e8 fc ff ff ff       	call   479 <map_elf64+0x25f>
 47d:	83 c4 10             	add    esp,0x10
								putstr(" SZ: ");
 480:	83 ec 0c             	sub    esp,0xc
 483:	68 52 00 00 00       	push   0x52
 488:	e8 fc ff ff ff       	call   489 <map_elf64+0x26f>
 48d:	83 c4 10             	add    esp,0x10
								put64(phdr->p_memsz);
 490:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 493:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
 496:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 499:	83 ec 08             	sub    esp,0x8
 49c:	52                   	push   edx
 49d:	50                   	push   eax
 49e:	e8 fc ff ff ff       	call   49f <map_elf64+0x285>
 4a3:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_R ? " R" : "  ");
 4a6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 4a9:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 4ac:	83 e0 04             	and    eax,0x4
 4af:	85 c0                	test   eax,eax
 4b1:	74 07                	je     4ba <map_elf64+0x2a0>
 4b3:	b8 58 00 00 00       	mov    eax,0x58
 4b8:	eb 05                	jmp    4bf <map_elf64+0x2a5>
 4ba:	b8 5b 00 00 00       	mov    eax,0x5b
 4bf:	83 ec 0c             	sub    esp,0xc
 4c2:	50                   	push   eax
 4c3:	e8 fc ff ff ff       	call   4c4 <map_elf64+0x2aa>
 4c8:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_W ? "W" : " ");
 4cb:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 4ce:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 4d1:	83 e0 02             	and    eax,0x2
 4d4:	85 c0                	test   eax,eax
 4d6:	74 07                	je     4df <map_elf64+0x2c5>
 4d8:	b8 5e 00 00 00       	mov    eax,0x5e
 4dd:	eb 05                	jmp    4e4 <map_elf64+0x2ca>
 4df:	b8 60 00 00 00       	mov    eax,0x60
 4e4:	83 ec 0c             	sub    esp,0xc
 4e7:	50                   	push   eax
 4e8:	e8 fc ff ff ff       	call   4e9 <map_elf64+0x2cf>
 4ed:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_X ? "X" : " ");
 4f0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 4f3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 4f6:	83 e0 01             	and    eax,0x1
 4f9:	85 c0                	test   eax,eax
 4fb:	74 07                	je     504 <map_elf64+0x2ea>
 4fd:	b8 62 00 00 00       	mov    eax,0x62
 502:	eb 05                	jmp    509 <map_elf64+0x2ef>
 504:	b8 60 00 00 00       	mov    eax,0x60
 509:	83 ec 0c             	sub    esp,0xc
 50c:	50                   	push   eax
 50d:	e8 fc ff ff ff       	call   50e <map_elf64+0x2f4>
 512:	83 c4 10             	add    esp,0x10
								put_nl();
 515:	e8 fc ff ff ff       	call   516 <map_elf64+0x2fc>
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
 51a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 51d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								mm_perform_mapping(2, phdr->p_offset, pr, prc,
 520:	83 e0 02             	and    eax,0x2
 523:	89 c2                	mov    edx,eax
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
 525:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 528:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
								mm_perform_mapping(2, phdr->p_offset, pr, prc,
 52b:	83 e0 01             	and    eax,0x1
 52e:	89 85 44 fe ff ff    	mov    DWORD PTR [ebp-0x1bc],eax
 534:	8b 5d d4             	mov    ebx,DWORD PTR [ebp-0x2c]
 537:	89 9d 40 fe ff ff    	mov    DWORD PTR [ebp-0x1c0],ebx
 53d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 540:	8b 58 28             	mov    ebx,DWORD PTR [eax+0x28]
 543:	8b 70 2c             	mov    esi,DWORD PTR [eax+0x2c]
 546:	89 9d 38 fe ff ff    	mov    DWORD PTR [ebp-0x1c8],ebx
 54c:	89 b5 3c fe ff ff    	mov    DWORD PTR [ebp-0x1c4],esi
 552:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 555:	8b 70 20             	mov    esi,DWORD PTR [eax+0x20]
 558:	8b 78 24             	mov    edi,DWORD PTR [eax+0x24]
 55b:	89 b5 30 fe ff ff    	mov    DWORD PTR [ebp-0x1d0],esi
 561:	89 bd 34 fe ff ff    	mov    DWORD PTR [ebp-0x1cc],edi
 567:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 56a:	8b 70 10             	mov    esi,DWORD PTR [eax+0x10]
 56d:	8b 78 14             	mov    edi,DWORD PTR [eax+0x14]
 570:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 573:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
 576:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
 579:	83 ec 04             	sub    esp,0x4
 57c:	52                   	push   edx
 57d:	ff b5 44 fe ff ff    	push   DWORD PTR [ebp-0x1bc]
 583:	ff b5 40 fe ff ff    	push   DWORD PTR [ebp-0x1c0]
 589:	8d 85 50 fe ff ff    	lea    eax,[ebp-0x1b0]
 58f:	50                   	push   eax
 590:	ff b5 3c fe ff ff    	push   DWORD PTR [ebp-0x1c4]
 596:	ff b5 38 fe ff ff    	push   DWORD PTR [ebp-0x1c8]
 59c:	ff b5 34 fe ff ff    	push   DWORD PTR [ebp-0x1cc]
 5a2:	ff b5 30 fe ff ff    	push   DWORD PTR [ebp-0x1d0]
 5a8:	57                   	push   edi
 5a9:	56                   	push   esi
 5aa:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 5ad:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 5b0:	53                   	push   ebx
 5b1:	51                   	push   ecx
 5b2:	6a 02                	push   0x2
 5b4:	e8 fc ff ff ff       	call   5b5 <map_elf64+0x39b>
 5b9:	83 c4 40             	add    esp,0x40
								break;
 5bc:	eb 01                	jmp    5bf <map_elf64+0x3a5>
								break;
 5be:	90                   	nop
		for (i = 0; i < hdr->e_phnum; i++) {
 5bf:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
 5c3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 5c6:	0f b7 40 38          	movzx  eax,WORD PTR [eax+0x38]
 5ca:	0f b7 c0             	movzx  eax,ax
 5cd:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
 5d0:	0f 82 f4 fd ff ff    	jb     3ca <map_elf64+0x1b0>
				}
		}

		/* TODO: and also preserve the symbol table */
		return rv;
 5d6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 5d9:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
}
 5dc:	8d 65 f4             	lea    esp,[ebp-0xc]
 5df:	5b                   	pop    ebx
 5e0:	5e                   	pop    esi
 5e1:	5f                   	pop    edi
 5e2:	5d                   	pop    ebp
 5e3:	c3                   	ret

000005e4 <map_elf32>:

/* elf32 format files */
uint64_t map_elf32(int mode, uint32_t pct, struct page_range* pr, int prc)
{
 5e4:	55                   	push   ebp
 5e5:	89 e5                	mov    ebp,esp
 5e7:	57                   	push   edi
 5e8:	56                   	push   esi
 5e9:	53                   	push   ebx
 5ea:	81 ec cc 01 00 00    	sub    esp,0x1cc
		Elf32_Addr rv;
		Elf32_Ehdr* hdr = (Elf32_Ehdr*)(size_t)pr->base;
 5f0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 5f3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 5f6:	8b 00                	mov    eax,DWORD PTR [eax]
 5f8:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		Elf32_Shdr* shdr; size_t i;
		Elf32_Phdr* phdr;

		puts("ELF32 mapping");
 5fb:	83 ec 0c             	sub    esp,0xc
 5fe:	68 64 00 00 00       	push   0x64
 603:	e8 fc ff ff ff       	call   604 <map_elf32+0x20>
 608:	83 c4 10             	add    esp,0x10

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, SELFMAG) != 0)
 60b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 60e:	83 ec 04             	sub    esp,0x4
 611:	6a 04                	push   0x4
 613:	68 0e 00 00 00       	push   0xe
 618:	50                   	push   eax
 619:	e8 fc ff ff ff       	call   61a <map_elf32+0x36>
 61e:	83 c4 10             	add    esp,0x10
 621:	85 c0                	test   eax,eax
 623:	74 0f                	je     634 <map_elf32+0x50>
				return -1;
 625:	b8 ff ff ff ff       	mov    eax,0xffffffff
 62a:	ba ff ff ff ff       	mov    edx,0xffffffff
 62f:	e9 7f 03 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (hdr->e_ident[EI_CLASS] != ELFCLASS32)
 634:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 637:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
 63b:	3c 01                	cmp    al,0x1
 63d:	74 0f                	je     64e <map_elf32+0x6a>
				return -1;
 63f:	b8 ff ff ff ff       	mov    eax,0xffffffff
 644:	ba ff ff ff ff       	mov    edx,0xffffffff
 649:	e9 65 03 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
 64e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 651:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
 655:	3c 01                	cmp    al,0x1
 657:	74 0f                	je     668 <map_elf32+0x84>
				return -1;
 659:	b8 ff ff ff ff       	mov    eax,0xffffffff
 65e:	ba ff ff ff ff       	mov    edx,0xffffffff
 663:	e9 4b 03 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
 668:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 66b:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
 66f:	3c 01                	cmp    al,0x1
 671:	74 0f                	je     682 <map_elf32+0x9e>
				return -1;
 673:	b8 ff ff ff ff       	mov    eax,0xffffffff
 678:	ba ff ff ff ff       	mov    edx,0xffffffff
 67d:	e9 31 03 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
 682:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 685:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
 689:	84 c0                	test   al,al
 68b:	74 0f                	je     69c <map_elf32+0xb8>
				return -1;
 68d:	b8 ff ff ff ff       	mov    eax,0xffffffff
 692:	ba ff ff ff ff       	mov    edx,0xffffffff
 697:	e9 17 03 00 00       	jmp    9b3 <map_elf32+0x3cf>

		/* matching ELF32 found -> check for object file */
		if (hdr->e_type != ET_EXEC)
 69c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 69f:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
 6a3:	66 83 f8 02          	cmp    ax,0x2
 6a7:	74 0f                	je     6b8 <map_elf32+0xd4>
				return -1;
 6a9:	b8 ff ff ff ff       	mov    eax,0xffffffff
 6ae:	ba ff ff ff ff       	mov    edx,0xffffffff
 6b3:	e9 fb 02 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (hdr->e_machine != EM_386)
 6b8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6bb:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
 6bf:	66 83 f8 03          	cmp    ax,0x3
 6c3:	74 0f                	je     6d4 <map_elf32+0xf0>
				return -1;
 6c5:	b8 ff ff ff ff       	mov    eax,0xffffffff
 6ca:	ba ff ff ff ff       	mov    edx,0xffffffff
 6cf:	e9 df 02 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (hdr->e_ehsize != sizeof(*hdr))
 6d4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6d7:	0f b7 40 28          	movzx  eax,WORD PTR [eax+0x28]
 6db:	66 83 f8 34          	cmp    ax,0x34
 6df:	74 0f                	je     6f0 <map_elf32+0x10c>
				return -1;
 6e1:	b8 ff ff ff ff       	mov    eax,0xffffffff
 6e6:	ba ff ff ff ff       	mov    edx,0xffffffff
 6eb:	e9 c3 02 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (!hdr->e_phnum) /* PH count */
 6f0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6f3:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
 6f7:	66 85 c0             	test   ax,ax
 6fa:	75 0f                	jne    70b <map_elf32+0x127>
				return -1;
 6fc:	b8 ff ff ff ff       	mov    eax,0xffffffff
 701:	ba ff ff ff ff       	mov    edx,0xffffffff
 706:	e9 a8 02 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (!hdr->e_shnum) /* section count */
 70b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 70e:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
 712:	66 85 c0             	test   ax,ax
 715:	75 0f                	jne    726 <map_elf32+0x142>
				return -1;
 717:	b8 ff ff ff ff       	mov    eax,0xffffffff
 71c:	ba ff ff ff ff       	mov    edx,0xffffffff
 721:	e9 8d 02 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (hdr->e_shentsize != sizeof(Elf32_Shdr))
 726:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 729:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
 72d:	66 83 f8 28          	cmp    ax,0x28
 731:	74 0f                	je     742 <map_elf32+0x15e>
				return -1;
 733:	b8 ff ff ff ff       	mov    eax,0xffffffff
 738:	ba ff ff ff ff       	mov    edx,0xffffffff
 73d:	e9 71 02 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (hdr->e_phentsize != sizeof(Elf32_Phdr))
 742:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 745:	0f b7 40 2a          	movzx  eax,WORD PTR [eax+0x2a]
 749:	66 83 f8 20          	cmp    ax,0x20
 74d:	74 0f                	je     75e <map_elf32+0x17a>
				return -1;
 74f:	b8 ff ff ff ff       	mov    eax,0xffffffff
 754:	ba ff ff ff ff       	mov    edx,0xffffffff
 759:	e9 55 02 00 00       	jmp    9b3 <map_elf32+0x3cf>
		if (hdr->e_shstrndx == SHN_UNDEF)
 75e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 761:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
 765:	66 85 c0             	test   ax,ax
 768:	75 0f                	jne    779 <map_elf32+0x195>
				return -1; /* no strtab (needed for symbols) */
 76a:	b8 ff ff ff ff       	mov    eax,0xffffffff
 76f:	ba ff ff ff ff       	mov    edx,0xffffffff
 774:	e9 3a 02 00 00       	jmp    9b3 <map_elf32+0x3cf>

		rv = hdr->e_entry;
 779:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 77c:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 77f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax

		/* interprete the program headers */
		/* (only suitable for specially prepared (aligned) images)
		 * created by the Makefile for the kernel.elf file. */
		for (i = 0; i < hdr->e_phnum; i++) {
 782:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
 789:	e9 0a 02 00 00       	jmp    998 <map_elf32+0x3b4>
				struct page_range pr2[32]; size_t pr2c = 32;
 78e:	c7 45 d8 20 00 00 00 	mov    DWORD PTR [ebp-0x28],0x20
				bzero(pr2, sizeof(pr2));
 795:	83 ec 08             	sub    esp,0x8
 798:	68 80 01 00 00       	push   0x180
 79d:	8d 85 54 fe ff ff    	lea    eax,[ebp-0x1ac]
 7a3:	50                   	push   eax
 7a4:	e8 fc ff ff ff       	call   7a5 <map_elf32+0x1c1>
 7a9:	83 c4 10             	add    esp,0x10
				phdr = elf_offset(pr, prc, hdr->e_phoff
 7ac:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 7af:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
						+ i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
 7b2:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 7b5:	c1 e2 05             	shl    edx,0x5
 7b8:	01 d0                	add    eax,edx
				phdr = elf_offset(pr, prc, hdr->e_phoff
 7ba:	ba 00 00 00 00       	mov    edx,0x0
 7bf:	83 ec 0c             	sub    esp,0xc
 7c2:	6a 20                	push   0x20
 7c4:	52                   	push   edx
 7c5:	50                   	push   eax
 7c6:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 7c9:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 7cc:	e8 fc ff ff ff       	call   7cd <map_elf32+0x1e9>
 7d1:	83 c4 20             	add    esp,0x20
 7d4:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				if (!phdr) {
 7d7:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
 7db:	75 13                	jne    7f0 <map_elf32+0x20c>
						puts("Phdr spans multiple pages: Impelemnt copying.");
 7dd:	83 ec 0c             	sub    esp,0xc
 7e0:	68 14 00 00 00       	push   0x14
 7e5:	e8 fc ff ff ff       	call   7e6 <map_elf32+0x202>
 7ea:	83 c4 10             	add    esp,0x10
						while (1);
 7ed:	90                   	nop
 7ee:	eb fd                	jmp    7ed <map_elf32+0x209>
				}
				/* show its contents */
				switch (phdr->p_type) {
 7f0:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 7f3:	8b 00                	mov    eax,DWORD PTR [eax]
 7f5:	83 f8 01             	cmp    eax,0x1
 7f8:	74 10                	je     80a <map_elf32+0x226>
 7fa:	3d 51 e5 74 64       	cmp    eax,0x6474e551
 7ff:	0f 84 8e 01 00 00    	je     993 <map_elf32+0x3af>
						}
						case PT_GNU_STACK:
									  /* maybe save stack align */
								break;
						default: /* ignore */
								break;
 805:	e9 8a 01 00 00       	jmp    994 <map_elf32+0x3b0>
								putstr("FOFS ");
 80a:	83 ec 0c             	sub    esp,0xc
 80d:	68 42 00 00 00       	push   0x42
 812:	e8 fc ff ff ff       	call   813 <map_elf32+0x22f>
 817:	83 c4 10             	add    esp,0x10
								put32(phdr->p_offset);
 81a:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 81d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 820:	83 ec 0c             	sub    esp,0xc
 823:	50                   	push   eax
 824:	e8 fc ff ff ff       	call   825 <map_elf32+0x241>
 829:	83 c4 10             	add    esp,0x10
								putstr(" -> VMEM ");
 82c:	83 ec 0c             	sub    esp,0xc
 82f:	68 48 00 00 00       	push   0x48
 834:	e8 fc ff ff ff       	call   835 <map_elf32+0x251>
 839:	83 c4 10             	add    esp,0x10
								put32(phdr->p_vaddr);
 83c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 83f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 842:	83 ec 0c             	sub    esp,0xc
 845:	50                   	push   eax
 846:	e8 fc ff ff ff       	call   847 <map_elf32+0x263>
 84b:	83 c4 10             	add    esp,0x10
								putstr(" SZ: ");
 84e:	83 ec 0c             	sub    esp,0xc
 851:	68 52 00 00 00       	push   0x52
 856:	e8 fc ff ff ff       	call   857 <map_elf32+0x273>
 85b:	83 c4 10             	add    esp,0x10
								put32(phdr->p_memsz);
 85e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 861:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
 864:	83 ec 0c             	sub    esp,0xc
 867:	50                   	push   eax
 868:	e8 fc ff ff ff       	call   869 <map_elf32+0x285>
 86d:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_R ? " R" : "  ");
 870:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 873:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 876:	83 e0 04             	and    eax,0x4
 879:	85 c0                	test   eax,eax
 87b:	74 07                	je     884 <map_elf32+0x2a0>
 87d:	b8 58 00 00 00       	mov    eax,0x58
 882:	eb 05                	jmp    889 <map_elf32+0x2a5>
 884:	b8 5b 00 00 00       	mov    eax,0x5b
 889:	83 ec 0c             	sub    esp,0xc
 88c:	50                   	push   eax
 88d:	e8 fc ff ff ff       	call   88e <map_elf32+0x2aa>
 892:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_W ? "W" : " ");
 895:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 898:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 89b:	83 e0 02             	and    eax,0x2
 89e:	85 c0                	test   eax,eax
 8a0:	74 07                	je     8a9 <map_elf32+0x2c5>
 8a2:	b8 5e 00 00 00       	mov    eax,0x5e
 8a7:	eb 05                	jmp    8ae <map_elf32+0x2ca>
 8a9:	b8 60 00 00 00       	mov    eax,0x60
 8ae:	83 ec 0c             	sub    esp,0xc
 8b1:	50                   	push   eax
 8b2:	e8 fc ff ff ff       	call   8b3 <map_elf32+0x2cf>
 8b7:	83 c4 10             	add    esp,0x10
								putstr(phdr->p_flags & PF_X ? "X" : " ");
 8ba:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 8bd:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
 8c0:	83 e0 01             	and    eax,0x1
 8c3:	85 c0                	test   eax,eax
 8c5:	74 07                	je     8ce <map_elf32+0x2ea>
 8c7:	b8 62 00 00 00       	mov    eax,0x62
 8cc:	eb 05                	jmp    8d3 <map_elf32+0x2ef>
 8ce:	b8 60 00 00 00       	mov    eax,0x60
 8d3:	83 ec 0c             	sub    esp,0xc
 8d6:	50                   	push   eax
 8d7:	e8 fc ff ff ff       	call   8d8 <map_elf32+0x2f4>
 8dc:	83 c4 10             	add    esp,0x10
								put_nl();
 8df:	e8 fc ff ff ff       	call   8e0 <map_elf32+0x2fc>
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
 8e4:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 8e7:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 8ea:	83 e0 02             	and    eax,0x2
 8ed:	89 c2                	mov    edx,eax
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
 8ef:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 8f2:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 8f5:	83 e0 01             	and    eax,0x1
 8f8:	89 85 44 fe ff ff    	mov    DWORD PTR [ebp-0x1bc],eax
 8fe:	8b 5d d8             	mov    ebx,DWORD PTR [ebp-0x28]
 901:	89 9d 40 fe ff ff    	mov    DWORD PTR [ebp-0x1c0],ebx
												phdr->p_vaddr, phdr->p_filesz, phdr->p_memsz, pr2, pr2c,
 907:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 90a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 90d:	89 85 38 fe ff ff    	mov    DWORD PTR [ebp-0x1c8],eax
 913:	c7 85 3c fe ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x1c4],0x0
												phdr->p_vaddr, phdr->p_filesz, phdr->p_memsz, pr2, pr2c,
 91d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 920:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 923:	89 85 30 fe ff ff    	mov    DWORD PTR [ebp-0x1d0],eax
 929:	c7 85 34 fe ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x1cc],0x0
												phdr->p_vaddr, phdr->p_filesz, phdr->p_memsz, pr2, pr2c,
 933:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 936:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
 939:	89 c6                	mov    esi,eax
 93b:	bf 00 00 00 00       	mov    edi,0x0
 940:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
 943:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 946:	89 c1                	mov    ecx,eax
 948:	bb 00 00 00 00       	mov    ebx,0x0
 94d:	83 ec 04             	sub    esp,0x4
 950:	52                   	push   edx
 951:	ff b5 44 fe ff ff    	push   DWORD PTR [ebp-0x1bc]
 957:	ff b5 40 fe ff ff    	push   DWORD PTR [ebp-0x1c0]
 95d:	8d 85 54 fe ff ff    	lea    eax,[ebp-0x1ac]
 963:	50                   	push   eax
 964:	ff b5 3c fe ff ff    	push   DWORD PTR [ebp-0x1c4]
 96a:	ff b5 38 fe ff ff    	push   DWORD PTR [ebp-0x1c8]
 970:	ff b5 34 fe ff ff    	push   DWORD PTR [ebp-0x1cc]
 976:	ff b5 30 fe ff ff    	push   DWORD PTR [ebp-0x1d0]
 97c:	57                   	push   edi
 97d:	56                   	push   esi
 97e:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 981:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 984:	53                   	push   ebx
 985:	51                   	push   ecx
 986:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 989:	e8 fc ff ff ff       	call   98a <map_elf32+0x3a6>
 98e:	83 c4 40             	add    esp,0x40
								break;
 991:	eb 01                	jmp    994 <map_elf32+0x3b0>
								break;
 993:	90                   	nop
		for (i = 0; i < hdr->e_phnum; i++) {
 994:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
 998:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 99b:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
 99f:	0f b7 c0             	movzx  eax,ax
 9a2:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
 9a5:	0f 82 e3 fd ff ff    	jb     78e <map_elf32+0x1aa>
				}
		}

		/* TODO: and also preserve the symbol table */
		return rv;
 9ab:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 9ae:	ba 00 00 00 00       	mov    edx,0x0
}
 9b3:	8d 65 f4             	lea    esp,[ebp-0xc]
 9b6:	5b                   	pop    ebx
 9b7:	5e                   	pop    esi
 9b8:	5f                   	pop    edi
 9b9:	5d                   	pop    ebp
 9ba:	c3                   	ret

000009bb <map_elf_image>:

uint64_t map_elf_image(int mode, uint32_t pct, struct page_range* pr, int prc)
{
 9bb:	55                   	push   ebp
 9bc:	89 e5                	mov    ebp,esp
 9be:	83 ec 18             	sub    esp,0x18
//		}
		/* we don't have to perform relocations as we deal with
		 * an executable image with program headers. We only
		 * have to (possibly) move the individual sections to
		 * different memory pages and map them accordingly. */
		if (mode == 2)
 9c1:	83 7d 08 02          	cmp    DWORD PTR [ebp+0x8],0x2
 9c5:	75 1c                	jne    9e3 <map_elf_image+0x28>
				rv = map_elf64(pct, pr, prc);
 9c7:	83 ec 04             	sub    esp,0x4
 9ca:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 9cd:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 9d0:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 9d3:	e8 fc ff ff ff       	call   9d4 <map_elf_image+0x19>
 9d8:	83 c4 10             	add    esp,0x10
 9db:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 9de:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
 9e1:	eb 1a                	jmp    9fd <map_elf_image+0x42>
		else
				rv = map_elf32(mode, pct, pr, prc);
 9e3:	ff 75 14             	push   DWORD PTR [ebp+0x14]
 9e6:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 9e9:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 9ec:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 9ef:	e8 fc ff ff ff       	call   9f0 <map_elf_image+0x35>
 9f4:	83 c4 10             	add    esp,0x10
 9f7:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 9fa:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		return rv;
 9fd:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 a00:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
}
 a03:	c9                   	leave
 a04:	c3                   	ret
