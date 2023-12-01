
module.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
						}
				}
		}
}

const char* get_section_type_string(Elf32_Word tp)
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
{
       6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (tp == SHT_PROGBITS)
       c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
       f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
				return "PROGBITS";
      12:	eb 17                	jmp    2b <memcpy+0x2b>
		else if (tp == SHT_SYMTAB)
      14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      17:	8d 42 01             	lea    eax,[edx+0x1]
      1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      20:	8d 48 01             	lea    ecx,[eax+0x1]
      23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      29:	88 10                	mov    BYTE PTR [eax],dl
				return "PROGBITS";
      2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      2e:	8d 50 ff             	lea    edx,[eax-0x1]
      31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      34:	85 c0                	test   eax,eax
      36:	75 dc                	jne    14 <memcpy+0x14>
				return "SYMTAB";
      38:	90                   	nop
      39:	90                   	nop
      3a:	c9                   	leave
      3b:	c3                   	ret

0000003c <elf_fetch_string>:
{
      3c:	55                   	push   ebp
      3d:	89 e5                	mov    ebp,esp
      3f:	83 ec 04             	sub    esp,0x4
      42:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      45:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		if (!shdr[strtab].sh_size)
      49:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      4d:	89 d0                	mov    eax,edx
      4f:	c1 e0 02             	shl    eax,0x2
      52:	01 d0                	add    eax,edx
      54:	c1 e0 03             	shl    eax,0x3
      57:	89 c2                	mov    edx,eax
      59:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      5c:	01 d0                	add    eax,edx
      5e:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
      61:	85 c0                	test   eax,eax
      63:	75 07                	jne    6c <elf_fetch_string+0x30>
				return "";
      65:	b8 00 00 00 00       	mov    eax,0x0
      6a:	eb 6a                	jmp    d6 <elf_fetch_string+0x9a>
		if (shdr[strtab].sh_type != SHT_STRTAB)
      6c:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      70:	89 d0                	mov    eax,edx
      72:	c1 e0 02             	shl    eax,0x2
      75:	01 d0                	add    eax,edx
      77:	c1 e0 03             	shl    eax,0x3
      7a:	89 c2                	mov    edx,eax
      7c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      7f:	01 d0                	add    eax,edx
      81:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
      84:	83 f8 03             	cmp    eax,0x3
      87:	74 07                	je     90 <elf_fetch_string+0x54>
				return "no STRTAB referenced";
      89:	b8 01 00 00 00       	mov    eax,0x1
      8e:	eb 46                	jmp    d6 <elf_fetch_string+0x9a>
		if (str >= shdr[strtab].sh_size)
      90:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      94:	89 d0                	mov    eax,edx
      96:	c1 e0 02             	shl    eax,0x2
      99:	01 d0                	add    eax,edx
      9b:	c1 e0 03             	shl    eax,0x3
      9e:	89 c2                	mov    edx,eax
      a0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      a3:	01 d0                	add    eax,edx
      a5:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
      a8:	39 45 14             	cmp    DWORD PTR [ebp+0x14],eax
      ab:	72 07                	jb     b4 <elf_fetch_string+0x78>
				return "STRTAB entry out of range";
      ad:	b8 16 00 00 00       	mov    eax,0x16
      b2:	eb 22                	jmp    d6 <elf_fetch_string+0x9a>
		return ((char*)hdr + shdr[strtab].sh_offset) + str;
      b4:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      b8:	89 d0                	mov    eax,edx
      ba:	c1 e0 02             	shl    eax,0x2
      bd:	01 d0                	add    eax,edx
      bf:	c1 e0 03             	shl    eax,0x3
      c2:	89 c2                	mov    edx,eax
      c4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      c7:	01 d0                	add    eax,edx
      c9:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
      cc:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
      cf:	01 c2                	add    edx,eax
      d1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      d4:	01 d0                	add    eax,edx
}
      d6:	c9                   	leave
      d7:	c3                   	ret

000000d8 <elf_dump_symtab>:
{
      d8:	55                   	push   ebp
      d9:	89 e5                	mov    ebp,esp
      db:	53                   	push   ebx
      dc:	83 ec 34             	sub    esp,0x34
      df:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      e2:	66 89 45 d4          	mov    WORD PTR [ebp-0x2c],ax
		void* ptr = ((void*)hdr + shdr[symtab].sh_offset);
      e6:	0f b7 55 d4          	movzx  edx,WORD PTR [ebp-0x2c]
      ea:	89 d0                	mov    eax,edx
      ec:	c1 e0 02             	shl    eax,0x2
      ef:	01 d0                	add    eax,edx
      f1:	c1 e0 03             	shl    eax,0x3
      f4:	89 c2                	mov    edx,eax
      f6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      f9:	01 d0                	add    eax,edx
      fb:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
      fe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     101:	01 d0                	add    eax,edx
     103:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		size_t i, ct = shdr[symtab].sh_size / shdr[symtab].sh_entsize;
     106:	0f b7 55 d4          	movzx  edx,WORD PTR [ebp-0x2c]
     10a:	89 d0                	mov    eax,edx
     10c:	c1 e0 02             	shl    eax,0x2
     10f:	01 d0                	add    eax,edx
     111:	c1 e0 03             	shl    eax,0x3
     114:	89 c2                	mov    edx,eax
     116:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     119:	01 d0                	add    eax,edx
     11b:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     11e:	0f b7 55 d4          	movzx  edx,WORD PTR [ebp-0x2c]
     122:	89 d0                	mov    eax,edx
     124:	c1 e0 02             	shl    eax,0x2
     127:	01 d0                	add    eax,edx
     129:	c1 e0 03             	shl    eax,0x3
     12c:	89 c2                	mov    edx,eax
     12e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     131:	01 d0                	add    eax,edx
     133:	8b 58 24             	mov    ebx,DWORD PTR [eax+0x24]
     136:	89 c8                	mov    eax,ecx
     138:	ba 00 00 00 00       	mov    edx,0x0
     13d:	f7 f3                	div    ebx
     13f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (ct <= 1)
     142:	83 7d dc 01          	cmp    DWORD PTR [ebp-0x24],0x1
     146:	0f 86 6b 02 00 00    	jbe    3b7 <elf_dump_symtab+0x2df>
		printf("dumping symtab with %lu entries\n", ct);
     14c:	83 ec 08             	sub    esp,0x8
     14f:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
     152:	68 30 00 00 00       	push   0x30
     157:	e8 fc ff ff ff       	call   158 <elf_dump_symtab+0x80>
     15c:	83 c4 10             	add    esp,0x10
		printf("   Num:    Value  Size Type    Bind   Section  Name\n");
     15f:	83 ec 0c             	sub    esp,0xc
     162:	68 54 00 00 00       	push   0x54
     167:	e8 fc ff ff ff       	call   168 <elf_dump_symtab+0x90>
     16c:	83 c4 10             	add    esp,0x10
		for (i = 1; i < ct; i++) {
     16f:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
     176:	e9 2e 02 00 00       	jmp    3a9 <elf_dump_symtab+0x2d1>
				Elf32_Sym* s = (ptr + i * shdr[symtab].sh_entsize);
     17b:	0f b7 55 d4          	movzx  edx,WORD PTR [ebp-0x2c]
     17f:	89 d0                	mov    eax,edx
     181:	c1 e0 02             	shl    eax,0x2
     184:	01 d0                	add    eax,edx
     186:	c1 e0 03             	shl    eax,0x3
     189:	89 c2                	mov    edx,eax
     18b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     18e:	01 d0                	add    eax,edx
     190:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     193:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
     197:	89 c2                	mov    edx,eax
     199:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     19c:	01 d0                	add    eax,edx
     19e:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				char *name = "STN_UNDEF", *sec, *stp, *stb;
     1a1:	c7 45 f0 89 00 00 00 	mov    DWORD PTR [ebp-0x10],0x89
				if (s->st_name)
     1a8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     1ab:	8b 00                	mov    eax,DWORD PTR [eax]
     1ad:	85 c0                	test   eax,eax
     1af:	74 33                	je     1e4 <elf_dump_symtab+0x10c>
						name = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
     1b1:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     1b4:	8b 08                	mov    ecx,DWORD PTR [eax]
     1b6:	0f b7 55 d4          	movzx  edx,WORD PTR [ebp-0x2c]
     1ba:	89 d0                	mov    eax,edx
     1bc:	c1 e0 02             	shl    eax,0x2
     1bf:	01 d0                	add    eax,edx
     1c1:	c1 e0 03             	shl    eax,0x3
     1c4:	89 c2                	mov    edx,eax
     1c6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1c9:	01 d0                	add    eax,edx
     1cb:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
     1ce:	0f b7 c0             	movzx  eax,ax
     1d1:	51                   	push   ecx
     1d2:	50                   	push   eax
     1d3:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     1d6:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     1d9:	e8 fc ff ff ff       	call   1da <elf_dump_symtab+0x102>
     1de:	83 c4 10             	add    esp,0x10
     1e1:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (ELF32_ST_TYPE(s->st_info) == STT_NOTYPE)
     1e4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     1e7:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     1eb:	0f b6 c0             	movzx  eax,al
     1ee:	83 e0 0f             	and    eax,0xf
     1f1:	85 c0                	test   eax,eax
     1f3:	75 0c                	jne    201 <elf_dump_symtab+0x129>
						stp = "NOTYPE ";
     1f5:	c7 45 e8 93 00 00 00 	mov    DWORD PTR [ebp-0x18],0x93
     1fc:	e9 8e 00 00 00       	jmp    28f <elf_dump_symtab+0x1b7>
				else if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
     201:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     204:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     208:	0f b6 c0             	movzx  eax,al
     20b:	83 e0 0f             	and    eax,0xf
     20e:	83 f8 01             	cmp    eax,0x1
     211:	75 09                	jne    21c <elf_dump_symtab+0x144>
						stp = "OBJECT ";
     213:	c7 45 e8 9b 00 00 00 	mov    DWORD PTR [ebp-0x18],0x9b
     21a:	eb 73                	jmp    28f <elf_dump_symtab+0x1b7>
				else if (ELF32_ST_TYPE(s->st_info) == STT_FUNC)
     21c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     21f:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     223:	0f b6 c0             	movzx  eax,al
     226:	83 e0 0f             	and    eax,0xf
     229:	83 f8 02             	cmp    eax,0x2
     22c:	75 09                	jne    237 <elf_dump_symtab+0x15f>
						stp = "FUNC   ";
     22e:	c7 45 e8 a3 00 00 00 	mov    DWORD PTR [ebp-0x18],0xa3
     235:	eb 58                	jmp    28f <elf_dump_symtab+0x1b7>
				else if (ELF32_ST_TYPE(s->st_info) == STT_SECTION)
     237:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     23a:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     23e:	0f b6 c0             	movzx  eax,al
     241:	83 e0 0f             	and    eax,0xf
     244:	83 f8 03             	cmp    eax,0x3
     247:	75 09                	jne    252 <elf_dump_symtab+0x17a>
						stp = "SECTION";
     249:	c7 45 e8 ab 00 00 00 	mov    DWORD PTR [ebp-0x18],0xab
     250:	eb 3d                	jmp    28f <elf_dump_symtab+0x1b7>
				else if (ELF32_ST_TYPE(s->st_info) == STT_FILE)
     252:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     255:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     259:	0f b6 c0             	movzx  eax,al
     25c:	83 e0 0f             	and    eax,0xf
     25f:	83 f8 04             	cmp    eax,0x4
     262:	75 09                	jne    26d <elf_dump_symtab+0x195>
						stp = "FILE   ";
     264:	c7 45 e8 b3 00 00 00 	mov    DWORD PTR [ebp-0x18],0xb3
     26b:	eb 22                	jmp    28f <elf_dump_symtab+0x1b7>
				else if (ELF32_ST_TYPE(s->st_info) >= 13/*STT_LOPROC*/ &&
     26d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     270:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     274:	0f b6 c0             	movzx  eax,al
     277:	83 e0 0f             	and    eax,0xf
     27a:	83 f8 0c             	cmp    eax,0xc
     27d:	76 09                	jbe    288 <elf_dump_symtab+0x1b0>
						stp = "PROC   ";
     27f:	c7 45 e8 bb 00 00 00 	mov    DWORD PTR [ebp-0x18],0xbb
     286:	eb 07                	jmp    28f <elf_dump_symtab+0x1b7>
						stp = "UNKNOWN";
     288:	c7 45 e8 c3 00 00 00 	mov    DWORD PTR [ebp-0x18],0xc3
				if (ELF32_ST_BIND(s->st_info) == STB_LOCAL)
     28f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     292:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     296:	c0 e8 04             	shr    al,0x4
     299:	84 c0                	test   al,al
     29b:	75 09                	jne    2a6 <elf_dump_symtab+0x1ce>
						stb = "LOCAL ";
     29d:	c7 45 e4 cb 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xcb
     2a4:	eb 5a                	jmp    300 <elf_dump_symtab+0x228>
				else if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL)
     2a6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     2a9:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     2ad:	c0 e8 04             	shr    al,0x4
     2b0:	3c 01                	cmp    al,0x1
     2b2:	75 09                	jne    2bd <elf_dump_symtab+0x1e5>
						stb = "GLOBAL";
     2b4:	c7 45 e4 d2 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xd2
     2bb:	eb 43                	jmp    300 <elf_dump_symtab+0x228>
				else if (ELF32_ST_BIND(s->st_info) == STB_WEAK)
     2bd:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     2c0:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     2c4:	c0 e8 04             	shr    al,0x4
     2c7:	3c 02                	cmp    al,0x2
     2c9:	75 09                	jne    2d4 <elf_dump_symtab+0x1fc>
						stb = "WEAK  ";
     2cb:	c7 45 e4 d9 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xd9
     2d2:	eb 2c                	jmp    300 <elf_dump_symtab+0x228>
				else if (ELF32_ST_BIND(s->st_info) >= 13 &&
     2d4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     2d7:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     2db:	c0 e8 04             	shr    al,0x4
     2de:	3c 0c                	cmp    al,0xc
     2e0:	76 17                	jbe    2f9 <elf_dump_symtab+0x221>
						ELF32_ST_BIND(s->st_info) <= 15)
     2e2:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     2e5:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     2e9:	c0 e8 04             	shr    al,0x4
				else if (ELF32_ST_BIND(s->st_info) >= 13 &&
     2ec:	3c 0f                	cmp    al,0xf
     2ee:	77 09                	ja     2f9 <elf_dump_symtab+0x221>
						stb = "PROC  ";
     2f0:	c7 45 e4 e0 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xe0
     2f7:	eb 07                	jmp    300 <elf_dump_symtab+0x228>
						stb = "UNK   ";
     2f9:	c7 45 e4 e7 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xe7
				if (s->st_shndx == SHN_ABS)
     300:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     303:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     307:	66 83 f8 f1          	cmp    ax,0xfff1
     30b:	75 09                	jne    316 <elf_dump_symtab+0x23e>
						sec = "ABS     ";
     30d:	c7 45 ec ee 00 00 00 	mov    DWORD PTR [ebp-0x14],0xee
     314:	eb 65                	jmp    37b <elf_dump_symtab+0x2a3>
				else if (s->st_shndx == SHN_COMMON)
     316:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     319:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     31d:	66 83 f8 f2          	cmp    ax,0xfff2
     321:	75 09                	jne    32c <elf_dump_symtab+0x254>
						sec = "COMMON  ";
     323:	c7 45 ec f7 00 00 00 	mov    DWORD PTR [ebp-0x14],0xf7
     32a:	eb 4f                	jmp    37b <elf_dump_symtab+0x2a3>
				else if (s->st_shndx == SHN_UNDEF)
     32c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     32f:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     333:	66 85 c0             	test   ax,ax
     336:	75 09                	jne    341 <elf_dump_symtab+0x269>
						sec = "UNDEF   ";
     338:	c7 45 ec 00 01 00 00 	mov    DWORD PTR [ebp-0x14],0x100
     33f:	eb 3a                	jmp    37b <elf_dump_symtab+0x2a3>
						sec = elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name);
     341:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     344:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     348:	0f b7 d0             	movzx  edx,ax
     34b:	89 d0                	mov    eax,edx
     34d:	c1 e0 02             	shl    eax,0x2
     350:	01 d0                	add    eax,edx
     352:	c1 e0 03             	shl    eax,0x3
     355:	89 c2                	mov    edx,eax
     357:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     35a:	01 d0                	add    eax,edx
     35c:	8b 10                	mov    edx,DWORD PTR [eax]
     35e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     361:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     365:	0f b7 c0             	movzx  eax,ax
     368:	52                   	push   edx
     369:	50                   	push   eax
     36a:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     36d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     370:	e8 fc ff ff ff       	call   371 <elf_dump_symtab+0x299>
     375:	83 c4 10             	add    esp,0x10
     378:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				printf("%6lu: %08u %5u %s %s %8.8s %.13s\n", i, s->st_value, s->st_size,
     37b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     37e:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     381:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     384:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     387:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     38a:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     38d:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     390:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
     393:	52                   	push   edx
     394:	50                   	push   eax
     395:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     398:	68 0c 01 00 00       	push   0x10c
     39d:	e8 fc ff ff ff       	call   39e <elf_dump_symtab+0x2c6>
     3a2:	83 c4 20             	add    esp,0x20
		for (i = 1; i < ct; i++) {
     3a5:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     3a9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3ac:	3b 45 dc             	cmp    eax,DWORD PTR [ebp-0x24]
     3af:	0f 82 c6 fd ff ff    	jb     17b <elf_dump_symtab+0xa3>
     3b5:	eb 01                	jmp    3b8 <elf_dump_symtab+0x2e0>
				return;
     3b7:	90                   	nop
}
     3b8:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     3bb:	c9                   	leave
     3bc:	c3                   	ret

000003bd <elf_rel_type_string>:
{
     3bd:	55                   	push   ebp
     3be:	89 e5                	mov    ebp,esp
		switch (t) {
     3c0:	83 7d 08 0a          	cmp    DWORD PTR [ebp+0x8],0xa
     3c4:	77 5c                	ja     422 <elf_rel_type_string+0x65>
     3c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3c9:	c1 e0 02             	shl    eax,0x2
     3cc:	05 b8 01 00 00       	add    eax,0x1b8
     3d1:	8b 00                	mov    eax,DWORD PTR [eax]
     3d3:	ff e0                	jmp    eax
				return "R_386_NONE";
     3d5:	b8 2e 01 00 00       	mov    eax,0x12e
     3da:	eb 4b                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_32";
     3dc:	b8 39 01 00 00       	mov    eax,0x139
     3e1:	eb 44                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_PC32";
     3e3:	b8 42 01 00 00       	mov    eax,0x142
     3e8:	eb 3d                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_GOT32";
     3ea:	b8 4d 01 00 00       	mov    eax,0x14d
     3ef:	eb 36                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_PLT32";
     3f1:	b8 59 01 00 00       	mov    eax,0x159
     3f6:	eb 2f                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_COPY";
     3f8:	b8 65 01 00 00       	mov    eax,0x165
     3fd:	eb 28                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_GLOB_DAT";
     3ff:	b8 70 01 00 00       	mov    eax,0x170
     404:	eb 21                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_JMP_SLOT";
     406:	b8 7f 01 00 00       	mov    eax,0x17f
     40b:	eb 1a                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_RELATIVE";
     40d:	b8 8e 01 00 00       	mov    eax,0x18e
     412:	eb 13                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_GOTOFF";
     414:	b8 9d 01 00 00       	mov    eax,0x19d
     419:	eb 0c                	jmp    427 <elf_rel_type_string+0x6a>
				return "R_386_GOTPC";
     41b:	b8 aa 01 00 00       	mov    eax,0x1aa
     420:	eb 05                	jmp    427 <elf_rel_type_string+0x6a>
				return "UNKNOWN";
     422:	b8 c3 00 00 00       	mov    eax,0xc3
}
     427:	5d                   	pop    ebp
     428:	c3                   	ret

00000429 <elf_dump_rel>:
{
     429:	55                   	push   ebp
     42a:	89 e5                	mov    ebp,esp
     42c:	56                   	push   esi
     42d:	53                   	push   ebx
     42e:	83 ec 50             	sub    esp,0x50
     431:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     434:	66 89 45 b4          	mov    WORD PTR [ebp-0x4c],ax
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
     438:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     43c:	89 d0                	mov    eax,edx
     43e:	c1 e0 02             	shl    eax,0x2
     441:	01 d0                	add    eax,edx
     443:	c1 e0 03             	shl    eax,0x3
     446:	89 c2                	mov    edx,eax
     448:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     44b:	01 d0                	add    eax,edx
     44d:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     450:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     453:	01 d0                	add    eax,edx
     455:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
     458:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     45c:	89 d0                	mov    eax,edx
     45e:	c1 e0 02             	shl    eax,0x2
     461:	01 d0                	add    eax,edx
     463:	c1 e0 03             	shl    eax,0x3
     466:	89 c2                	mov    edx,eax
     468:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     46b:	01 d0                	add    eax,edx
     46d:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     470:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     474:	89 d0                	mov    eax,edx
     476:	c1 e0 02             	shl    eax,0x2
     479:	01 d0                	add    eax,edx
     47b:	c1 e0 03             	shl    eax,0x3
     47e:	89 c2                	mov    edx,eax
     480:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     483:	01 d0                	add    eax,edx
     485:	8b 58 24             	mov    ebx,DWORD PTR [eax+0x24]
     488:	89 c8                	mov    eax,ecx
     48a:	ba 00 00 00 00       	mov    edx,0x0
     48f:	f7 f3                	div    ebx
     491:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!ct)
     494:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
     498:	0f 84 51 03 00 00    	je     7ef <elf_dump_rel+0x3c6>
		sptr = (void*)hdr + shdr[shdr[rel].sh_info].sh_offset;
     49e:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     4a2:	89 d0                	mov    eax,edx
     4a4:	c1 e0 02             	shl    eax,0x2
     4a7:	01 d0                	add    eax,edx
     4a9:	c1 e0 03             	shl    eax,0x3
     4ac:	89 c2                	mov    edx,eax
     4ae:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     4b1:	01 d0                	add    eax,edx
     4b3:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     4b6:	89 d0                	mov    eax,edx
     4b8:	c1 e0 02             	shl    eax,0x2
     4bb:	01 d0                	add    eax,edx
     4bd:	c1 e0 03             	shl    eax,0x3
     4c0:	89 c2                	mov    edx,eax
     4c2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     4c5:	01 d0                	add    eax,edx
     4c7:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     4ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4cd:	01 d0                	add    eax,edx
     4cf:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
     4d2:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     4d6:	89 d0                	mov    eax,edx
     4d8:	c1 e0 02             	shl    eax,0x2
     4db:	01 d0                	add    eax,edx
     4dd:	c1 e0 03             	shl    eax,0x3
     4e0:	89 c2                	mov    edx,eax
     4e2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     4e5:	01 d0                	add    eax,edx
     4e7:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     4ea:	89 d0                	mov    eax,edx
     4ec:	c1 e0 02             	shl    eax,0x2
     4ef:	01 d0                	add    eax,edx
     4f1:	c1 e0 03             	shl    eax,0x3
     4f4:	89 c2                	mov    edx,eax
     4f6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     4f9:	01 d0                	add    eax,edx
     4fb:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     4fe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     501:	01 d0                	add    eax,edx
     503:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		stb = shdr + shdr[rel].sh_link;
     506:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     50a:	89 d0                	mov    eax,edx
     50c:	c1 e0 02             	shl    eax,0x2
     50f:	01 d0                	add    eax,edx
     511:	c1 e0 03             	shl    eax,0x3
     514:	89 c2                	mov    edx,eax
     516:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     519:	01 d0                	add    eax,edx
     51b:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     51e:	89 d0                	mov    eax,edx
     520:	c1 e0 02             	shl    eax,0x2
     523:	01 d0                	add    eax,edx
     525:	c1 e0 03             	shl    eax,0x3
     528:	89 c2                	mov    edx,eax
     52a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     52d:	01 d0                	add    eax,edx
     52f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		printf("dumping relocations with %lu entries\n", ct);
     532:	83 ec 08             	sub    esp,0x8
     535:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     538:	68 e4 01 00 00       	push   0x1e4
     53d:	e8 fc ff ff ff       	call   53e <elf_dump_rel+0x115>
     542:	83 c4 10             	add    esp,0x10
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     545:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     549:	89 d0                	mov    eax,edx
     54b:	c1 e0 02             	shl    eax,0x2
     54e:	01 d0                	add    eax,edx
     550:	c1 e0 03             	shl    eax,0x3
     553:	89 c2                	mov    edx,eax
     555:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     558:	01 d0                	add    eax,edx
     55a:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     55d:	89 d0                	mov    eax,edx
     55f:	c1 e0 02             	shl    eax,0x2
     562:	01 d0                	add    eax,edx
     564:	c1 e0 03             	shl    eax,0x3
     567:	89 c2                	mov    edx,eax
     569:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     56c:	01 d0                	add    eax,edx
		printf("relocations apply to section %s\n", elf_fetch_string(hdr,
     56e:	8b 10                	mov    edx,DWORD PTR [eax]
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     570:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     573:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
		printf("relocations apply to section %s\n", elf_fetch_string(hdr,
     577:	0f b7 c0             	movzx  eax,ax
     57a:	52                   	push   edx
     57b:	50                   	push   eax
     57c:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     57f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     582:	e8 fc ff ff ff       	call   583 <elf_dump_rel+0x15a>
     587:	83 c4 10             	add    esp,0x10
     58a:	83 ec 08             	sub    esp,0x8
     58d:	50                   	push   eax
     58e:	68 0c 02 00 00       	push   0x20c
     593:	e8 fc ff ff ff       	call   594 <elf_dump_rel+0x16b>
     598:	83 c4 10             	add    esp,0x10
		printf("   Num:   Offset Type              Field SyNdx SymbolName\n");
     59b:	83 ec 0c             	sub    esp,0xc
     59e:	68 30 02 00 00       	push   0x230
     5a3:	e8 fc ff ff ff       	call   5a4 <elf_dump_rel+0x17b>
     5a8:	83 c4 10             	add    esp,0x10
		for (i = 0; i < ct; i++) {
     5ab:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     5b2:	e9 2a 02 00 00       	jmp    7e1 <elf_dump_rel+0x3b8>
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
     5b7:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     5bb:	89 d0                	mov    eax,edx
     5bd:	c1 e0 02             	shl    eax,0x2
     5c0:	01 d0                	add    eax,edx
     5c2:	c1 e0 03             	shl    eax,0x3
     5c5:	89 c2                	mov    edx,eax
     5c7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5ca:	01 d0                	add    eax,edx
     5cc:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     5cf:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
     5d3:	89 c2                	mov    edx,eax
     5d5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     5d8:	01 d0                	add    eax,edx
     5da:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
     5dd:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     5e0:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     5e3:	c1 e8 08             	shr    eax,0x8
     5e6:	89 c2                	mov    edx,eax
     5e8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     5eb:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     5ee:	0f af d0             	imul   edx,eax
     5f1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5f4:	01 d0                	add    eax,edx
     5f6:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				const char* sn; char dat[] = "DAT: ........";
     5f9:	c7 45 ba 44 41 54 3a 	mov    DWORD PTR [ebp-0x46],0x3a544144
     600:	c7 45 be 20 2e 2e 2e 	mov    DWORD PTR [ebp-0x42],0x2e2e2e20
     607:	c7 45 c2 2e 2e 2e 2e 	mov    DWORD PTR [ebp-0x3e],0x2e2e2e2e
     60e:	66 c7 45 c6 2e 00    	mov    WORD PTR [ebp-0x3a],0x2e
				if (s->st_name)
     614:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     617:	8b 00                	mov    eax,DWORD PTR [eax]
     619:	85 c0                	test   eax,eax
     61b:	74 26                	je     643 <elf_dump_rel+0x21a>
						sn = elf_fetch_string(hdr, shdr, stb->sh_link, s->st_name);
     61d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     620:	8b 10                	mov    edx,DWORD PTR [eax]
     622:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     625:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
     628:	0f b7 c0             	movzx  eax,ax
     62b:	52                   	push   edx
     62c:	50                   	push   eax
     62d:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     630:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     633:	e8 fc ff ff ff       	call   634 <elf_dump_rel+0x20b>
     638:	83 c4 10             	add    esp,0x10
     63b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     63e:	e9 4f 01 00 00       	jmp    792 <elf_dump_rel+0x369>
				else if ((shdr[s->st_shndx].sh_flags & SHF_WRITE) == 0
     643:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     646:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     64a:	0f b7 d0             	movzx  edx,ax
     64d:	89 d0                	mov    eax,edx
     64f:	c1 e0 02             	shl    eax,0x2
     652:	01 d0                	add    eax,edx
     654:	c1 e0 03             	shl    eax,0x3
     657:	89 c2                	mov    edx,eax
     659:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     65c:	01 d0                	add    eax,edx
     65e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     661:	83 e0 01             	and    eax,0x1
     664:	85 c0                	test   eax,eax
     666:	0f 85 ec 00 00 00    	jne    758 <elf_dump_rel+0x32f>
						&& shdr[s->st_shndx].sh_flags & SHF_ALLOC
     66c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     66f:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     673:	0f b7 d0             	movzx  edx,ax
     676:	89 d0                	mov    eax,edx
     678:	c1 e0 02             	shl    eax,0x2
     67b:	01 d0                	add    eax,edx
     67d:	c1 e0 03             	shl    eax,0x3
     680:	89 c2                	mov    edx,eax
     682:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     685:	01 d0                	add    eax,edx
     687:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     68a:	83 e0 02             	and    eax,0x2
     68d:	85 c0                	test   eax,eax
     68f:	0f 84 c3 00 00 00    	je     758 <elf_dump_rel+0x32f>
						&& (shdr[s->st_shndx].sh_flags & SHF_EXECINSTR) == 0) {
     695:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     698:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     69c:	0f b7 d0             	movzx  edx,ax
     69f:	89 d0                	mov    eax,edx
     6a1:	c1 e0 02             	shl    eax,0x2
     6a4:	01 d0                	add    eax,edx
     6a6:	c1 e0 03             	shl    eax,0x3
     6a9:	89 c2                	mov    edx,eax
     6ab:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6ae:	01 d0                	add    eax,edx
     6b0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     6b3:	83 e0 04             	and    eax,0x4
     6b6:	85 c0                	test   eax,eax
     6b8:	0f 85 9a 00 00 00    	jne    758 <elf_dump_rel+0x32f>
						const char* c = (void*)hdr + shdr[s->st_shndx].sh_offset;
     6be:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     6c1:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     6c5:	0f b7 d0             	movzx  edx,ax
     6c8:	89 d0                	mov    eax,edx
     6ca:	c1 e0 02             	shl    eax,0x2
     6cd:	01 d0                	add    eax,edx
     6cf:	c1 e0 03             	shl    eax,0x3
     6d2:	89 c2                	mov    edx,eax
     6d4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6d7:	01 d0                	add    eax,edx
     6d9:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     6dc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6df:	01 d0                	add    eax,edx
     6e1:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
						uint32_t of = *(uint32_t*)(sptr + r->r_offset), j;
     6e4:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     6e7:	8b 10                	mov    edx,DWORD PTR [eax]
     6e9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     6ec:	01 d0                	add    eax,edx
     6ee:	8b 00                	mov    eax,DWORD PTR [eax]
     6f0:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						for (j = 0; j < 8; j++)
     6f3:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     6fa:	eb 4e                	jmp    74a <elf_dump_rel+0x321>
								if (isprint(c[of + j]))
     6fc:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
     6ff:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     702:	01 c2                	add    edx,eax
     704:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     707:	01 d0                	add    eax,edx
     709:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     70c:	0f be c0             	movsx  eax,al
     70f:	83 ec 0c             	sub    esp,0xc
     712:	50                   	push   eax
     713:	e8 fc ff ff ff       	call   714 <elf_dump_rel+0x2eb>
     718:	83 c4 10             	add    esp,0x10
     71b:	85 c0                	test   eax,eax
     71d:	74 1c                	je     73b <elf_dump_rel+0x312>
										dat[j + 5] = c[of + j];
     71f:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
     722:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     725:	01 c2                	add    edx,eax
     727:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     72a:	01 d0                	add    eax,edx
     72c:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     72f:	83 c2 05             	add    edx,0x5
     732:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     735:	88 44 15 ba          	mov    BYTE PTR [ebp+edx*1-0x46],al
     739:	eb 0b                	jmp    746 <elf_dump_rel+0x31d>
										dat[j + 5] = '.';
     73b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     73e:	83 c0 05             	add    eax,0x5
     741:	c6 44 05 ba 2e       	mov    BYTE PTR [ebp+eax*1-0x46],0x2e
						for (j = 0; j < 8; j++)
     746:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     74a:	83 7d ec 07          	cmp    DWORD PTR [ebp-0x14],0x7
     74e:	76 ac                	jbe    6fc <elf_dump_rel+0x2d3>
						sn = dat;
     750:	8d 45 ba             	lea    eax,[ebp-0x46]
     753:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						&& (shdr[s->st_shndx].sh_flags & SHF_EXECINSTR) == 0) {
     756:	eb 3a                	jmp    792 <elf_dump_rel+0x369>
						sn = elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name);
     758:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     75b:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     75f:	0f b7 d0             	movzx  edx,ax
     762:	89 d0                	mov    eax,edx
     764:	c1 e0 02             	shl    eax,0x2
     767:	01 d0                	add    eax,edx
     769:	c1 e0 03             	shl    eax,0x3
     76c:	89 c2                	mov    edx,eax
     76e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     771:	01 d0                	add    eax,edx
     773:	8b 10                	mov    edx,DWORD PTR [eax]
     775:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     778:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     77c:	0f b7 c0             	movzx  eax,ax
     77f:	52                   	push   edx
     780:	50                   	push   eax
     781:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     784:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     787:	e8 fc ff ff ff       	call   788 <elf_dump_rel+0x35f>
     78c:	83 c4 10             	add    esp,0x10
     78f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
					*(uint32_t*)(sptr + r->r_offset), ELF32_R_SYM(r->r_info), sn);
     792:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     795:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     798:	c1 e8 08             	shr    eax,0x8
     79b:	89 c6                	mov    esi,eax
					*(uint32_t*)(sptr + r->r_offset), ELF32_R_SYM(r->r_info), sn);
     79d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     7a0:	8b 10                	mov    edx,DWORD PTR [eax]
     7a2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7a5:	01 d0                	add    eax,edx
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     7a7:	8b 18                	mov    ebx,DWORD PTR [eax]
					elf_rel_type_string(ELF32_R_TYPE(r->r_info)),
     7a9:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     7ac:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     7af:	0f b6 c0             	movzx  eax,al
     7b2:	83 ec 0c             	sub    esp,0xc
     7b5:	50                   	push   eax
     7b6:	e8 fc ff ff ff       	call   7b7 <elf_dump_rel+0x38e>
     7bb:	83 c4 10             	add    esp,0x10
     7be:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     7c1:	8b 12                	mov    edx,DWORD PTR [edx]
     7c3:	83 ec 04             	sub    esp,0x4
     7c6:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     7c9:	56                   	push   esi
     7ca:	53                   	push   ebx
     7cb:	50                   	push   eax
     7cc:	52                   	push   edx
     7cd:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     7d0:	68 6b 02 00 00       	push   0x26b
     7d5:	e8 fc ff ff ff       	call   7d6 <elf_dump_rel+0x3ad>
     7da:	83 c4 20             	add    esp,0x20
		for (i = 0; i < ct; i++) {
     7dd:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     7e1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7e4:	3b 45 e4             	cmp    eax,DWORD PTR [ebp-0x1c]
     7e7:	0f 82 ca fd ff ff    	jb     5b7 <elf_dump_rel+0x18e>
     7ed:	eb 01                	jmp    7f0 <elf_dump_rel+0x3c7>
				return;
     7ef:	90                   	nop
}
     7f0:	8d 65 f8             	lea    esp,[ebp-0x8]
     7f3:	5b                   	pop    ebx
     7f4:	5e                   	pop    esi
     7f5:	5d                   	pop    ebp
     7f6:	c3                   	ret

000007f7 <elf_relocate_section>:
{
     7f7:	55                   	push   ebp
     7f8:	89 e5                	mov    ebp,esp
     7fa:	53                   	push   ebx
     7fb:	83 ec 44             	sub    esp,0x44
     7fe:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     801:	66 89 45 c4          	mov    WORD PTR [ebp-0x3c],ax
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
     805:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     809:	89 d0                	mov    eax,edx
     80b:	c1 e0 02             	shl    eax,0x2
     80e:	01 d0                	add    eax,edx
     810:	c1 e0 03             	shl    eax,0x3
     813:	89 c2                	mov    edx,eax
     815:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     818:	01 d0                	add    eax,edx
     81a:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     81d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     820:	01 d0                	add    eax,edx
     822:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
     825:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     829:	89 d0                	mov    eax,edx
     82b:	c1 e0 02             	shl    eax,0x2
     82e:	01 d0                	add    eax,edx
     830:	c1 e0 03             	shl    eax,0x3
     833:	89 c2                	mov    edx,eax
     835:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     838:	01 d0                	add    eax,edx
     83a:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     83d:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     841:	89 d0                	mov    eax,edx
     843:	c1 e0 02             	shl    eax,0x2
     846:	01 d0                	add    eax,edx
     848:	c1 e0 03             	shl    eax,0x3
     84b:	89 c2                	mov    edx,eax
     84d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     850:	01 d0                	add    eax,edx
     852:	8b 58 24             	mov    ebx,DWORD PTR [eax+0x24]
     855:	89 c8                	mov    eax,ecx
     857:	ba 00 00 00 00       	mov    edx,0x0
     85c:	f7 f3                	div    ebx
     85e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (!ct)
     861:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     865:	0f 84 2e 02 00 00    	je     a99 <elf_relocate_section+0x2a2>
		sptr = (void*)shdr[shdr[rel].sh_info].sh_addr; /* vma */
     86b:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     86f:	89 d0                	mov    eax,edx
     871:	c1 e0 02             	shl    eax,0x2
     874:	01 d0                	add    eax,edx
     876:	c1 e0 03             	shl    eax,0x3
     879:	89 c2                	mov    edx,eax
     87b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     87e:	01 d0                	add    eax,edx
     880:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     883:	89 d0                	mov    eax,edx
     885:	c1 e0 02             	shl    eax,0x2
     888:	01 d0                	add    eax,edx
     88a:	c1 e0 03             	shl    eax,0x3
     88d:	89 c2                	mov    edx,eax
     88f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     892:	01 d0                	add    eax,edx
     894:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     897:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
     89a:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     89e:	89 d0                	mov    eax,edx
     8a0:	c1 e0 02             	shl    eax,0x2
     8a3:	01 d0                	add    eax,edx
     8a5:	c1 e0 03             	shl    eax,0x3
     8a8:	89 c2                	mov    edx,eax
     8aa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8ad:	01 d0                	add    eax,edx
     8af:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     8b2:	89 d0                	mov    eax,edx
     8b4:	c1 e0 02             	shl    eax,0x2
     8b7:	01 d0                	add    eax,edx
     8b9:	c1 e0 03             	shl    eax,0x3
     8bc:	89 c2                	mov    edx,eax
     8be:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8c1:	01 d0                	add    eax,edx
     8c3:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     8c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8c9:	01 d0                	add    eax,edx
     8cb:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		stb = shdr + shdr[rel].sh_link;
     8ce:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     8d2:	89 d0                	mov    eax,edx
     8d4:	c1 e0 02             	shl    eax,0x2
     8d7:	01 d0                	add    eax,edx
     8d9:	c1 e0 03             	shl    eax,0x3
     8dc:	89 c2                	mov    edx,eax
     8de:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8e1:	01 d0                	add    eax,edx
     8e3:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     8e6:	89 d0                	mov    eax,edx
     8e8:	c1 e0 02             	shl    eax,0x2
     8eb:	01 d0                	add    eax,edx
     8ed:	c1 e0 03             	shl    eax,0x3
     8f0:	89 c2                	mov    edx,eax
     8f2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8f5:	01 d0                	add    eax,edx
     8f7:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     8fa:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     8fe:	89 d0                	mov    eax,edx
     900:	c1 e0 02             	shl    eax,0x2
     903:	01 d0                	add    eax,edx
     905:	c1 e0 03             	shl    eax,0x3
     908:	89 c2                	mov    edx,eax
     90a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     90d:	01 d0                	add    eax,edx
     90f:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     912:	89 d0                	mov    eax,edx
     914:	c1 e0 02             	shl    eax,0x2
     917:	01 d0                	add    eax,edx
     919:	c1 e0 03             	shl    eax,0x3
     91c:	89 c2                	mov    edx,eax
     91e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     921:	01 d0                	add    eax,edx
		sbprintf("%lu relocations apply to section %s\n", ct, elf_fetch_string(hdr,
     923:	8b 10                	mov    edx,DWORD PTR [eax]
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     925:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     928:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
		sbprintf("%lu relocations apply to section %s\n", ct, elf_fetch_string(hdr,
     92c:	0f b7 c0             	movzx  eax,ax
     92f:	52                   	push   edx
     930:	50                   	push   eax
     931:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     934:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     937:	e8 fc ff ff ff       	call   938 <elf_relocate_section+0x141>
     93c:	83 c4 10             	add    esp,0x10
     93f:	83 ec 04             	sub    esp,0x4
     942:	50                   	push   eax
     943:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
     946:	68 8c 02 00 00       	push   0x28c
     94b:	e8 fc ff ff ff       	call   94c <elf_relocate_section+0x155>
     950:	83 c4 10             	add    esp,0x10
		for (i = 0; i < ct; i++) {
     953:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     95a:	e9 2c 01 00 00       	jmp    a8b <elf_relocate_section+0x294>
				Elf32_Addr val = 0;
     95f:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
     966:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     96a:	89 d0                	mov    eax,edx
     96c:	c1 e0 02             	shl    eax,0x2
     96f:	01 d0                	add    eax,edx
     971:	c1 e0 03             	shl    eax,0x3
     974:	89 c2                	mov    edx,eax
     976:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     979:	01 d0                	add    eax,edx
     97b:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     97e:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
     982:	89 c2                	mov    edx,eax
     984:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     987:	01 d0                	add    eax,edx
     989:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				void** pptr = (void**)(sptr + r->r_offset);
     98c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     98f:	8b 10                	mov    edx,DWORD PTR [eax]
     991:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     994:	01 d0                	add    eax,edx
     996:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
     999:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     99c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     99f:	c1 e8 08             	shr    eax,0x8
     9a2:	89 c2                	mov    edx,eax
     9a4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     9a7:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     9aa:	0f af d0             	imul   edx,eax
     9ad:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     9b0:	01 d0                	add    eax,edx
     9b2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (ELF32_R_SYM(r->r_info) == 0/*STN_UNDEF*/)
     9b5:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     9b8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     9bb:	c1 e8 08             	shr    eax,0x8
     9be:	85 c0                	test   eax,eax
     9c0:	75 07                	jne    9c9 <elf_relocate_section+0x1d2>
						s = NULL;
     9c2:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (s && !s->st_value) {
     9c9:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     9cd:	74 1f                	je     9ee <elf_relocate_section+0x1f7>
     9cf:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     9d2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     9d5:	85 c0                	test   eax,eax
     9d7:	75 15                	jne    9ee <elf_relocate_section+0x1f7>
						cprintf(KFMT_ERROR, "tried to relocate reference to undefined symbol\n");
     9d9:	83 ec 08             	sub    esp,0x8
     9dc:	68 b4 02 00 00       	push   0x2b4
     9e1:	6a 0c                	push   0xc
     9e3:	e8 fc ff ff ff       	call   9e4 <elf_relocate_section+0x1ed>
     9e8:	83 c4 10             	add    esp,0x10
						while (1);
     9eb:	90                   	nop
     9ec:	eb fd                	jmp    9eb <elf_relocate_section+0x1f4>
						val = s->st_value;
     9ee:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     9f1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     9f4:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				if (shdr[rel].sh_type == SHT_RELA) {
     9f7:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     9fb:	89 d0                	mov    eax,edx
     9fd:	c1 e0 02             	shl    eax,0x2
     a00:	01 d0                	add    eax,edx
     a02:	c1 e0 03             	shl    eax,0x3
     a05:	89 c2                	mov    edx,eax
     a07:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a0a:	01 d0                	add    eax,edx
     a0c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a0f:	83 f8 04             	cmp    eax,0x4
     a12:	75 15                	jne    a29 <elf_relocate_section+0x232>
						cprintf(KFMT_ERROR, "RELA relocations not implemented\n");
     a14:	83 ec 08             	sub    esp,0x8
     a17:	68 e8 02 00 00       	push   0x2e8
     a1c:	6a 0c                	push   0xc
     a1e:	e8 fc ff ff ff       	call   a1f <elf_relocate_section+0x228>
     a23:	83 c4 10             	add    esp,0x10
						while (1);
     a26:	90                   	nop
     a27:	eb fd                	jmp    a26 <elf_relocate_section+0x22f>
						switch (ELF32_R_TYPE(r->r_info)) {
     a29:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     a2c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a2f:	0f b6 c0             	movzx  eax,al
     a32:	83 f8 06             	cmp    eax,0x6
     a35:	77 3a                	ja     a71 <elf_relocate_section+0x27a>
     a37:	8b 04 85 30 03 00 00 	mov    eax,DWORD PTR [eax*4+0x330]
     a3e:	ff e0                	jmp    eax
								*pptr = (size_t)val + *pptr;
     a40:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a43:	8b 10                	mov    edx,DWORD PTR [eax]
     a45:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     a48:	01 c2                	add    edx,eax
     a4a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a4d:	89 10                	mov    DWORD PTR [eax],edx
								break;
     a4f:	eb 36                	jmp    a87 <elf_relocate_section+0x290>
								*pptr = (size_t)val + *pptr - (size_t)pptr;
     a51:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a54:	8b 10                	mov    edx,DWORD PTR [eax]
     a56:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a59:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
     a5c:	29 c1                	sub    ecx,eax
     a5e:	01 ca                	add    edx,ecx
     a60:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a63:	89 10                	mov    DWORD PTR [eax],edx
								break;
     a65:	eb 20                	jmp    a87 <elf_relocate_section+0x290>
								*pptr = (void*)val;
     a67:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     a6a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a6d:	89 10                	mov    DWORD PTR [eax],edx
								break;
     a6f:	eb 16                	jmp    a87 <elf_relocate_section+0x290>
								cprintf(KFMT_ERROR, "relocation type not implemented\n");
     a71:	83 ec 08             	sub    esp,0x8
     a74:	68 0c 03 00 00       	push   0x30c
     a79:	6a 0c                	push   0xc
     a7b:	e8 fc ff ff ff       	call   a7c <elf_relocate_section+0x285>
     a80:	83 c4 10             	add    esp,0x10
								while (1);
     a83:	90                   	nop
     a84:	eb fd                	jmp    a83 <elf_relocate_section+0x28c>
								break;
     a86:	90                   	nop
		for (i = 0; i < ct; i++) {
     a87:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     a8b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     a8e:	3b 45 e8             	cmp    eax,DWORD PTR [ebp-0x18]
     a91:	0f 82 c8 fe ff ff    	jb     95f <elf_relocate_section+0x168>
     a97:	eb 01                	jmp    a9a <elf_relocate_section+0x2a3>
				return;
     a99:	90                   	nop
}
     a9a:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     a9d:	c9                   	leave
     a9e:	c3                   	ret

00000a9f <get_section_type_string>:
{
     a9f:	55                   	push   ebp
     aa0:	89 e5                	mov    ebp,esp
		if (tp == SHT_PROGBITS)
     aa2:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
     aa6:	75 0a                	jne    ab2 <get_section_type_string+0x13>
				return "PROGBITS";
     aa8:	b8 4c 03 00 00       	mov    eax,0x34c
     aad:	e9 b5 00 00 00       	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_SYMTAB)
     ab2:	83 7d 08 02          	cmp    DWORD PTR [ebp+0x8],0x2
     ab6:	75 0a                	jne    ac2 <get_section_type_string+0x23>
				return "SYMTAB";
     ab8:	b8 55 03 00 00       	mov    eax,0x355
     abd:	e9 a5 00 00 00       	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_DYNSYM)
     ac2:	83 7d 08 0b          	cmp    DWORD PTR [ebp+0x8],0xb
     ac6:	75 0a                	jne    ad2 <get_section_type_string+0x33>
				return "DYNSYM";
     ac8:	b8 5c 03 00 00       	mov    eax,0x35c
     acd:	e9 95 00 00 00       	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_STRTAB)
     ad2:	83 7d 08 03          	cmp    DWORD PTR [ebp+0x8],0x3
     ad6:	75 0a                	jne    ae2 <get_section_type_string+0x43>
				return "STRTAB";
     ad8:	b8 63 03 00 00       	mov    eax,0x363
     add:	e9 85 00 00 00       	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_RELA)
     ae2:	83 7d 08 04          	cmp    DWORD PTR [ebp+0x8],0x4
     ae6:	75 07                	jne    aef <get_section_type_string+0x50>
				return "RELA";
     ae8:	b8 6a 03 00 00       	mov    eax,0x36a
     aed:	eb 78                	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_HASH)
     aef:	83 7d 08 05          	cmp    DWORD PTR [ebp+0x8],0x5
     af3:	75 07                	jne    afc <get_section_type_string+0x5d>
				return "HASH";
     af5:	b8 6f 03 00 00       	mov    eax,0x36f
     afa:	eb 6b                	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_DYNAMIC)
     afc:	83 7d 08 06          	cmp    DWORD PTR [ebp+0x8],0x6
     b00:	75 07                	jne    b09 <get_section_type_string+0x6a>
				return "DYNAMIC";
     b02:	b8 74 03 00 00       	mov    eax,0x374
     b07:	eb 5e                	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_NOTE)
     b09:	83 7d 08 07          	cmp    DWORD PTR [ebp+0x8],0x7
     b0d:	75 07                	jne    b16 <get_section_type_string+0x77>
				return "NOTE";
     b0f:	b8 7c 03 00 00       	mov    eax,0x37c
     b14:	eb 51                	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_NOBITS)
     b16:	83 7d 08 08          	cmp    DWORD PTR [ebp+0x8],0x8
     b1a:	75 07                	jne    b23 <get_section_type_string+0x84>
				return "NOBITS";
     b1c:	b8 81 03 00 00       	mov    eax,0x381
     b21:	eb 44                	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_REL)
     b23:	83 7d 08 09          	cmp    DWORD PTR [ebp+0x8],0x9
     b27:	75 07                	jne    b30 <get_section_type_string+0x91>
				return "REL";
     b29:	b8 88 03 00 00       	mov    eax,0x388
     b2e:	eb 37                	jmp    b67 <get_section_type_string+0xc8>
		else if (tp == SHT_SHLIB)
     b30:	83 7d 08 0a          	cmp    DWORD PTR [ebp+0x8],0xa
     b34:	75 07                	jne    b3d <get_section_type_string+0x9e>
				return "SHLIB";
     b36:	b8 8c 03 00 00       	mov    eax,0x38c
     b3b:	eb 2a                	jmp    b67 <get_section_type_string+0xc8>
		else if (tp >= SHT_LOPROC && tp <= SHT_HIPROC)
     b3d:	81 7d 08 ff ff ff 6f 	cmp    DWORD PTR [ebp+0x8],0x6fffffff
     b44:	76 0e                	jbe    b54 <get_section_type_string+0xb5>
     b46:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b49:	85 c0                	test   eax,eax
     b4b:	78 07                	js     b54 <get_section_type_string+0xb5>
				return "PROC";
     b4d:	b8 92 03 00 00       	mov    eax,0x392
     b52:	eb 13                	jmp    b67 <get_section_type_string+0xc8>
		else if (tp >= SHT_LOUSER && tp <= SHT_HIUSER)
     b54:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b57:	85 c0                	test   eax,eax
     b59:	79 07                	jns    b62 <get_section_type_string+0xc3>
				return "USER";
     b5b:	b8 97 03 00 00       	mov    eax,0x397
     b60:	eb 05                	jmp    b67 <get_section_type_string+0xc8>
		else
				return "RESERVED";
     b62:	b8 9c 03 00 00       	mov    eax,0x39c
}
     b67:	5d                   	pop    ebp
     b68:	c3                   	ret

00000b69 <elf_store_global_symbol>:

void elf_store_global_symbol(const char* name, void* vma, char type, int is_weak)
{
     b69:	55                   	push   ebp
     b6a:	89 e5                	mov    ebp,esp
     b6c:	53                   	push   ebx
     b6d:	83 ec 24             	sub    esp,0x24
     b70:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     b73:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		struct symbol_list* sl = gs_lst;
     b76:	a1 00 00 00 00       	mov    eax,ds:0x0
     b7b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		size_t i = 0; int wrt = 0;
     b7e:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     b85:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (!sl)
     b8c:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     b90:	0f 84 1a 02 00 00    	je     db0 <elf_store_global_symbol+0x247>
				return;

		if (!name) {
     b96:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     b9a:	0f 85 69 01 00 00    	jne    d09 <elf_store_global_symbol+0x1a0>
				cprintf(KFMT_WARN, "elf_store_global_symbol called for symbol "
     ba0:	0f be 45 e4          	movsx  eax,BYTE PTR [ebp-0x1c]
     ba4:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     ba7:	50                   	push   eax
     ba8:	68 a8 03 00 00       	push   0x3a8
     bad:	6a 0e                	push   0xe
     baf:	e8 fc ff ff ff       	call   bb0 <elf_store_global_symbol+0x47>
     bb4:	83 c4 10             	add    esp,0x10
								"of type %c with name \"\" at %p\n", type, vma);
		}

		/* search for existng definition and give an offset to which to write to */
		while (sl) {
     bb7:	e9 4d 01 00 00       	jmp    d09 <elf_store_global_symbol+0x1a0>
				if (!sl->entries[i].name)
     bbc:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     bbf:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     bc2:	89 d0                	mov    eax,edx
     bc4:	01 c0                	add    eax,eax
     bc6:	01 d0                	add    eax,edx
     bc8:	c1 e0 02             	shl    eax,0x2
     bcb:	01 c8                	add    eax,ecx
     bcd:	83 c0 04             	add    eax,0x4
     bd0:	8b 00                	mov    eax,DWORD PTR [eax]
     bd2:	85 c0                	test   eax,eax
     bd4:	0f 84 3b 01 00 00    	je     d15 <elf_store_global_symbol+0x1ac>
						break;
				if (strcmp(name, sl->entries[i].name) == 0) {
     bda:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     bdd:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     be0:	89 d0                	mov    eax,edx
     be2:	01 c0                	add    eax,eax
     be4:	01 d0                	add    eax,edx
     be6:	c1 e0 02             	shl    eax,0x2
     be9:	01 c8                	add    eax,ecx
     beb:	83 c0 04             	add    eax,0x4
     bee:	8b 00                	mov    eax,DWORD PTR [eax]
     bf0:	83 ec 08             	sub    esp,0x8
     bf3:	50                   	push   eax
     bf4:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     bf7:	e8 fc ff ff ff       	call   bf8 <elf_store_global_symbol+0x8f>
     bfc:	83 c4 10             	add    esp,0x10
     bff:	85 c0                	test   eax,eax
     c01:	0f 85 91 00 00 00    	jne    c98 <elf_store_global_symbol+0x12f>
						/* found a first match */
						if (sl->entries[i].type == type) {
     c07:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c0a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c0d:	89 d0                	mov    eax,edx
     c0f:	01 c0                	add    eax,eax
     c11:	01 d0                	add    eax,edx
     c13:	c1 e0 02             	shl    eax,0x2
     c16:	01 c8                	add    eax,ecx
     c18:	83 c0 08             	add    eax,0x8
     c1b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     c1e:	38 45 e4             	cmp    BYTE PTR [ebp-0x1c],al
     c21:	75 75                	jne    c98 <elf_store_global_symbol+0x12f>
								if (is_weak) /* use existing symbol definition */
     c23:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     c27:	0f 85 86 01 00 00    	jne    db3 <elf_store_global_symbol+0x24a>
										return;
								cprintf(KFMT_WARN, "overwriting symbol %s defined at %p with "
     c2d:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c30:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c33:	89 d0                	mov    eax,edx
     c35:	01 c0                	add    eax,eax
     c37:	01 d0                	add    eax,edx
     c39:	c1 e0 02             	shl    eax,0x2
     c3c:	01 c8                	add    eax,ecx
     c3e:	8b 08                	mov    ecx,DWORD PTR [eax]
     c40:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
     c43:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c46:	89 d0                	mov    eax,edx
     c48:	01 c0                	add    eax,eax
     c4a:	01 d0                	add    eax,edx
     c4c:	c1 e0 02             	shl    eax,0x2
     c4f:	01 d8                	add    eax,ebx
     c51:	83 c0 04             	add    eax,0x4
     c54:	8b 00                	mov    eax,DWORD PTR [eax]
     c56:	83 ec 0c             	sub    esp,0xc
     c59:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     c5c:	51                   	push   ecx
     c5d:	50                   	push   eax
     c5e:	68 f4 03 00 00       	push   0x3f4
     c63:	6a 0e                	push   0xe
     c65:	e8 fc ff ff ff       	call   c66 <elf_store_global_symbol+0xfd>
     c6a:	83 c4 20             	add    esp,0x20
									"symbol at %p\n", sl->entries[i].name, sl->entries[i].vma, vma);
								kfree(sl->entries[i].name); /* just in case */
     c6d:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c70:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c73:	89 d0                	mov    eax,edx
     c75:	01 c0                	add    eax,eax
     c77:	01 d0                	add    eax,edx
     c79:	c1 e0 02             	shl    eax,0x2
     c7c:	01 c8                	add    eax,ecx
     c7e:	83 c0 04             	add    eax,0x4
     c81:	8b 00                	mov    eax,DWORD PTR [eax]
     c83:	83 ec 0c             	sub    esp,0xc
     c86:	50                   	push   eax
     c87:	e8 fc ff ff ff       	call   c88 <elf_store_global_symbol+0x11f>
     c8c:	83 c4 10             	add    esp,0x10
								wrt = 1;
     c8f:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
								break; /* only overwrite full matches */
     c96:	eb 7e                	jmp    d16 <elf_store_global_symbol+0x1ad>
						}
				}
				if (++i == 64) {
     c98:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     c9c:	83 7d f0 40          	cmp    DWORD PTR [ebp-0x10],0x40
     ca0:	75 67                	jne    d09 <elf_store_global_symbol+0x1a0>
						if (sl->next) {
     ca2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ca5:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     cab:	85 c0                	test   eax,eax
     cad:	74 15                	je     cc4 <elf_store_global_symbol+0x15b>
								sl = sl->next;
     caf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     cb2:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     cb8:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								i = 0;
     cbb:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     cc2:	eb 45                	jmp    d09 <elf_store_global_symbol+0x1a0>
						} else {
								/* allocate space for the next one and quit the loop */
								i = 0;
     cc4:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
								sl = sl->next = kmalloc(sizeof(struct symbol_list));
     ccb:	83 ec 0c             	sub    esp,0xc
     cce:	68 04 03 00 00       	push   0x304
     cd3:	e8 fc ff ff ff       	call   cd4 <elf_store_global_symbol+0x16b>
     cd8:	83 c4 10             	add    esp,0x10
     cdb:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     cde:	89 82 00 03 00 00    	mov    DWORD PTR [edx+0x300],eax
     ce4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ce7:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     ced:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								if (!sl)
     cf0:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     cf4:	0f 84 bc 00 00 00    	je     db6 <elf_store_global_symbol+0x24d>
										return;
								sl->next = NULL; /* IMPORTANT! as kmalloc != cmalloc */
     cfa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     cfd:	c7 80 00 03 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x300],0x0
								break;
     d07:	eb 0d                	jmp    d16 <elf_store_global_symbol+0x1ad>
		while (sl) {
     d09:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     d0d:	0f 85 a9 fe ff ff    	jne    bbc <elf_store_global_symbol+0x53>
     d13:	eb 01                	jmp    d16 <elf_store_global_symbol+0x1ad>
						break;
     d15:	90                   	nop
						}
				}
		}

		/* now write the new definition */
		sl->entries[i].name = strdup(name);
     d16:	83 ec 0c             	sub    esp,0xc
     d19:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     d1c:	e8 fc ff ff ff       	call   d1d <elf_store_global_symbol+0x1b4>
     d21:	83 c4 10             	add    esp,0x10
     d24:	89 c1                	mov    ecx,eax
     d26:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
     d29:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d2c:	89 d0                	mov    eax,edx
     d2e:	01 c0                	add    eax,eax
     d30:	01 d0                	add    eax,edx
     d32:	c1 e0 02             	shl    eax,0x2
     d35:	01 d8                	add    eax,ebx
     d37:	83 c0 04             	add    eax,0x4
     d3a:	89 08                	mov    DWORD PTR [eax],ecx
		sl->entries[i].type = type;
     d3c:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     d3f:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d42:	89 d0                	mov    eax,edx
     d44:	01 c0                	add    eax,eax
     d46:	01 d0                	add    eax,edx
     d48:	c1 e0 02             	shl    eax,0x2
     d4b:	01 c8                	add    eax,ecx
     d4d:	8d 50 08             	lea    edx,[eax+0x8]
     d50:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
     d54:	88 02                	mov    BYTE PTR [edx],al
		sl->entries[i].vma = vma;
     d56:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     d59:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d5c:	89 d0                	mov    eax,edx
     d5e:	01 c0                	add    eax,eax
     d60:	01 d0                	add    eax,edx
     d62:	c1 e0 02             	shl    eax,0x2
     d65:	8d 14 01             	lea    edx,[ecx+eax*1]
     d68:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     d6b:	89 02                	mov    DWORD PTR [edx],eax
		/* and null-terminate if last */
		if (++i < 64 && !wrt) {
     d6d:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     d71:	83 7d f0 3f          	cmp    DWORD PTR [ebp-0x10],0x3f
     d75:	77 40                	ja     db7 <elf_store_global_symbol+0x24e>
     d77:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     d7b:	75 3a                	jne    db7 <elf_store_global_symbol+0x24e>
				sl->entries[i].name = NULL;
     d7d:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     d80:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d83:	89 d0                	mov    eax,edx
     d85:	01 c0                	add    eax,eax
     d87:	01 d0                	add    eax,edx
     d89:	c1 e0 02             	shl    eax,0x2
     d8c:	01 c8                	add    eax,ecx
     d8e:	83 c0 04             	add    eax,0x4
     d91:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				sl->entries[i].vma = NULL;
     d97:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     d9a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d9d:	89 d0                	mov    eax,edx
     d9f:	01 c0                	add    eax,eax
     da1:	01 d0                	add    eax,edx
     da3:	c1 e0 02             	shl    eax,0x2
     da6:	01 c8                	add    eax,ecx
     da8:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     dae:	eb 07                	jmp    db7 <elf_store_global_symbol+0x24e>
				return;
     db0:	90                   	nop
     db1:	eb 04                	jmp    db7 <elf_store_global_symbol+0x24e>
										return;
     db3:	90                   	nop
     db4:	eb 01                	jmp    db7 <elf_store_global_symbol+0x24e>
										return;
     db6:	90                   	nop
		}
}
     db7:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     dba:	c9                   	leave
     dbb:	c3                   	ret

00000dbc <elf_locate_global_symbol>:

Elf32_Addr elf_locate_global_symbol(const char* name, char type)
{
     dbc:	55                   	push   ebp
     dbd:	89 e5                	mov    ebp,esp
     dbf:	83 ec 28             	sub    esp,0x28
     dc2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     dc5:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		struct symbol_list* sl = gs_lst;
     dc8:	a1 00 00 00 00       	mov    eax,ds:0x0
     dcd:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		size_t i = 0;
     dd0:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		if (!sl)
     dd7:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     ddb:	0f 85 d5 00 00 00    	jne    eb6 <elf_locate_global_symbol+0xfa>
				return (Elf32_Addr)NULL;
     de1:	b8 00 00 00 00       	mov    eax,0x0
     de6:	e9 dd 00 00 00       	jmp    ec8 <elf_locate_global_symbol+0x10c>

		while (sl) {
				if (!sl->entries[i].name)
     deb:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     dee:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     df1:	89 d0                	mov    eax,edx
     df3:	01 c0                	add    eax,eax
     df5:	01 d0                	add    eax,edx
     df7:	c1 e0 02             	shl    eax,0x2
     dfa:	01 c8                	add    eax,ecx
     dfc:	83 c0 04             	add    eax,0x4
     dff:	8b 00                	mov    eax,DWORD PTR [eax]
     e01:	85 c0                	test   eax,eax
     e03:	0f 84 b9 00 00 00    	je     ec2 <elf_locate_global_symbol+0x106>
						break; /* end of list */
				if (strcmp(sl->entries[i].name, name) == 0) {
     e09:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e0c:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     e0f:	89 d0                	mov    eax,edx
     e11:	01 c0                	add    eax,eax
     e13:	01 d0                	add    eax,edx
     e15:	c1 e0 02             	shl    eax,0x2
     e18:	01 c8                	add    eax,ecx
     e1a:	83 c0 04             	add    eax,0x4
     e1d:	8b 00                	mov    eax,DWORD PTR [eax]
     e1f:	83 ec 08             	sub    esp,0x8
     e22:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     e25:	50                   	push   eax
     e26:	e8 fc ff ff ff       	call   e27 <elf_locate_global_symbol+0x6b>
     e2b:	83 c4 10             	add    esp,0x10
     e2e:	85 c0                	test   eax,eax
     e30:	75 67                	jne    e99 <elf_locate_global_symbol+0xdd>
						/* found a match candidate */
						if (sl->entries[i].type == type) /* exact match */
     e32:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e35:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     e38:	89 d0                	mov    eax,edx
     e3a:	01 c0                	add    eax,eax
     e3c:	01 d0                	add    eax,edx
     e3e:	c1 e0 02             	shl    eax,0x2
     e41:	01 c8                	add    eax,ecx
     e43:	83 c0 08             	add    eax,0x8
     e46:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     e49:	38 45 e4             	cmp    BYTE PTR [ebp-0x1c],al
     e4c:	75 15                	jne    e63 <elf_locate_global_symbol+0xa7>
								return (Elf32_Addr)sl->entries[i].vma;
     e4e:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e51:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     e54:	89 d0                	mov    eax,edx
     e56:	01 c0                	add    eax,eax
     e58:	01 d0                	add    eax,edx
     e5a:	c1 e0 02             	shl    eax,0x2
     e5d:	01 c8                	add    eax,ecx
     e5f:	8b 00                	mov    eax,DWORD PTR [eax]
     e61:	eb 65                	jmp    ec8 <elf_locate_global_symbol+0x10c>
						else if (sl->entries[i].type == 'B' && type == 'D')
     e63:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e66:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     e69:	89 d0                	mov    eax,edx
     e6b:	01 c0                	add    eax,eax
     e6d:	01 d0                	add    eax,edx
     e6f:	c1 e0 02             	shl    eax,0x2
     e72:	01 c8                	add    eax,ecx
     e74:	83 c0 08             	add    eax,0x8
     e77:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     e7a:	3c 42                	cmp    al,0x42
     e7c:	75 1b                	jne    e99 <elf_locate_global_symbol+0xdd>
     e7e:	80 7d e4 44          	cmp    BYTE PTR [ebp-0x1c],0x44
     e82:	75 15                	jne    e99 <elf_locate_global_symbol+0xdd>
								return (Elf32_Addr)sl->entries[i].vma; /* compatible */
     e84:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e87:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     e8a:	89 d0                	mov    eax,edx
     e8c:	01 c0                	add    eax,eax
     e8e:	01 d0                	add    eax,edx
     e90:	c1 e0 02             	shl    eax,0x2
     e93:	01 c8                	add    eax,ecx
     e95:	8b 00                	mov    eax,DWORD PTR [eax]
     e97:	eb 2f                	jmp    ec8 <elf_locate_global_symbol+0x10c>
				}

				if (++i == 64) {
     e99:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     e9d:	83 7d f0 40          	cmp    DWORD PTR [ebp-0x10],0x40
     ea1:	75 13                	jne    eb6 <elf_locate_global_symbol+0xfa>
						sl = sl->next;
     ea3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ea6:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     eac:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						i = 0;
     eaf:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		while (sl) {
     eb6:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     eba:	0f 85 2b ff ff ff    	jne    deb <elf_locate_global_symbol+0x2f>
     ec0:	eb 01                	jmp    ec3 <elf_locate_global_symbol+0x107>
						break; /* end of list */
     ec2:	90                   	nop
				}
		}

		/* no match found */
		return (Elf32_Addr)NULL;
     ec3:	b8 00 00 00 00       	mov    eax,0x0
}
     ec8:	c9                   	leave
     ec9:	c3                   	ret

00000eca <locate_module_function>:

void* locate_module_function(char* name)
{
     eca:	55                   	push   ebp
     ecb:	89 e5                	mov    ebp,esp
     ecd:	53                   	push   ebx
     ece:	83 ec 14             	sub    esp,0x14
		Elf32_Addr rv;
		rv = elf_locate_global_symbol(name, 'T');
     ed1:	83 ec 08             	sub    esp,0x8
     ed4:	6a 54                	push   0x54
     ed6:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     ed9:	e8 fc ff ff ff       	call   eda <locate_module_function+0x10>
     ede:	83 c4 10             	add    esp,0x10
     ee1:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv)
     ee4:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     ee8:	75 13                	jne    efd <locate_module_function+0x33>
				rv = elf_locate_global_symbol(name, 'D');
     eea:	83 ec 08             	sub    esp,0x8
     eed:	6a 44                	push   0x44
     eef:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     ef2:	e8 fc ff ff ff       	call   ef3 <locate_module_function+0x29>
     ef7:	83 c4 10             	add    esp,0x10
     efa:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv) {
     efd:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     f01:	75 76                	jne    f79 <locate_module_function+0xaf>
				struct symbol_list* sl = gs_lst;
     f03:	a1 00 00 00 00       	mov    eax,ds:0x0
     f08:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				size_t i = 0;
     f0b:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				while (sl) {
     f12:	eb 5f                	jmp    f73 <locate_module_function+0xa9>
						printf("%s %c\n", sl->entries[i].name, sl->entries[i].type);
     f14:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     f17:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     f1a:	89 d0                	mov    eax,edx
     f1c:	01 c0                	add    eax,eax
     f1e:	01 d0                	add    eax,edx
     f20:	c1 e0 02             	shl    eax,0x2
     f23:	01 c8                	add    eax,ecx
     f25:	83 c0 08             	add    eax,0x8
     f28:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     f2b:	0f be c8             	movsx  ecx,al
     f2e:	8b 5d f0             	mov    ebx,DWORD PTR [ebp-0x10]
     f31:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     f34:	89 d0                	mov    eax,edx
     f36:	01 c0                	add    eax,eax
     f38:	01 d0                	add    eax,edx
     f3a:	c1 e0 02             	shl    eax,0x2
     f3d:	01 d8                	add    eax,ebx
     f3f:	83 c0 04             	add    eax,0x4
     f42:	8b 00                	mov    eax,DWORD PTR [eax]
     f44:	83 ec 04             	sub    esp,0x4
     f47:	51                   	push   ecx
     f48:	50                   	push   eax
     f49:	68 2b 04 00 00       	push   0x42b
     f4e:	e8 fc ff ff ff       	call   f4f <locate_module_function+0x85>
     f53:	83 c4 10             	add    esp,0x10
						if (++i == 64) {
     f56:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     f5a:	83 7d ec 40          	cmp    DWORD PTR [ebp-0x14],0x40
     f5e:	75 13                	jne    f73 <locate_module_function+0xa9>
								sl = sl->next;
     f60:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     f63:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     f69:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								i = 0;
     f6c:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				while (sl) {
     f73:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     f77:	75 9b                	jne    f14 <locate_module_function+0x4a>
						}
				}
		}
		return (void*)rv;
     f79:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
     f7c:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     f7f:	c9                   	leave
     f80:	c3                   	ret

00000f81 <store_module_info>:

void store_module_info(struct module_info* mi)
{
     f81:	55                   	push   ebp
     f82:	89 e5                	mov    ebp,esp
     f84:	83 ec 18             	sub    esp,0x18
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
     f87:	a1 20 00 00 00       	mov    eax,ds:0x20
     f8c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		do {
				for (int i = 0; i < 7; i++)
     f8f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     f96:	e9 90 00 00 00       	jmp    102b <store_module_info+0xaa>
						if (!mc->ptrs[i]) {
     f9b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f9e:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     fa1:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
     fa4:	85 c0                	test   eax,eax
     fa6:	75 7f                	jne    1027 <store_module_info+0xa6>
								mc->ptrs[i] = kmalloc(sizeof(struct module_info));
     fa8:	83 ec 0c             	sub    esp,0xc
     fab:	6a 3c                	push   0x3c
     fad:	e8 fc ff ff ff       	call   fae <store_module_info+0x2d>
     fb2:	83 c4 10             	add    esp,0x10
     fb5:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     fb8:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     fbb:	89 04 8a             	mov    DWORD PTR [edx+ecx*4],eax
								if (!mc->ptrs[i])
     fbe:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     fc1:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     fc4:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
     fc7:	85 c0                	test   eax,eax
     fc9:	0f 84 b6 00 00 00    	je     1085 <store_module_info+0x104>
										return;
								memcpy(mc->ptrs[i], mi, sizeof(struct module_info));
     fcf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     fd2:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     fd5:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
     fd8:	83 ec 04             	sub    esp,0x4
     fdb:	6a 3c                	push   0x3c
     fdd:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     fe0:	50                   	push   eax
     fe1:	e8 1a f0 ff ff       	call   0 <memcpy>
     fe6:	83 c4 10             	add    esp,0x10
								for (int j = 0; j < 4; j++)
     fe9:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     ff0:	eb 2d                	jmp    101f <store_module_info+0x9e>
										mod_tbl.sz_secs[j] += mi->sz_secs[j];
     ff2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     ff5:	83 c0 04             	add    eax,0x4
     ff8:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
     fff:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1002:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1005:	83 c1 08             	add    ecx,0x8
    1008:	8b 44 88 0c          	mov    eax,DWORD PTR [eax+ecx*4+0xc]
    100c:	01 c2                	add    edx,eax
    100e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1011:	83 c0 04             	add    eax,0x4
    1014:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
								for (int j = 0; j < 4; j++)
    101b:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    101f:	83 7d ec 03          	cmp    DWORD PTR [ebp-0x14],0x3
    1023:	7e cd                	jle    ff2 <store_module_info+0x71>
								return;
    1025:	eb 5f                	jmp    1086 <store_module_info+0x105>
				for (int i = 0; i < 7; i++)
    1027:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    102b:	83 7d f0 06          	cmp    DWORD PTR [ebp-0x10],0x6
    102f:	0f 8e 66 ff ff ff    	jle    f9b <store_module_info+0x1a>
						}
				if (!mc->next) {
    1035:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1038:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    103b:	85 c0                	test   eax,eax
    103d:	75 31                	jne    1070 <store_module_info+0xef>
						mc->next = kmalloc(sizeof(struct module_info_container));
    103f:	83 ec 0c             	sub    esp,0xc
    1042:	6a 20                	push   0x20
    1044:	e8 fc ff ff ff       	call   1045 <store_module_info+0xc4>
    1049:	83 c4 10             	add    esp,0x10
    104c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    104f:	89 42 1c             	mov    DWORD PTR [edx+0x1c],eax
						if (mc->next)
    1052:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1055:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1058:	85 c0                	test   eax,eax
    105a:	74 14                	je     1070 <store_module_info+0xef>
								bzero(mc->next, sizeof(struct module_info_container));
    105c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    105f:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1062:	83 ec 08             	sub    esp,0x8
    1065:	6a 20                	push   0x20
    1067:	50                   	push   eax
    1068:	e8 fc ff ff ff       	call   1069 <store_module_info+0xe8>
    106d:	83 c4 10             	add    esp,0x10
				}
		} while ((mc = mc->next));
    1070:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1073:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1076:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1079:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    107d:	0f 85 0c ff ff ff    	jne    f8f <store_module_info+0xe>
    1083:	eb 01                	jmp    1086 <store_module_info+0x105>
										return;
    1085:	90                   	nop
}
    1086:	c9                   	leave
    1087:	c3                   	ret

00001088 <list_modules>:

void list_modules()
{
    1088:	55                   	push   ebp
    1089:	89 e5                	mov    ebp,esp
    108b:	83 ec 18             	sub    esp,0x18
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    108e:	a1 20 00 00 00       	mov    eax,ds:0x20
    1093:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		printf("Module                     Size\n");
    1096:	83 ec 0c             	sub    esp,0xc
    1099:	68 34 04 00 00       	push   0x434
    109e:	e8 fc ff ff ff       	call   109f <list_modules+0x17>
    10a3:	83 c4 10             	add    esp,0x10
		do {
				for (int i = 0; i < 7; i++)
    10a6:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    10ad:	eb 50                	jmp    10ff <list_modules+0x77>
						if (mc->ptrs[i]) {
    10af:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10b2:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    10b5:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    10b8:	85 c0                	test   eax,eax
    10ba:	74 4b                	je     1107 <list_modules+0x7f>
								struct module_info* mi = mc->ptrs[i];
    10bc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10bf:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    10c2:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    10c5:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    10c8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10cb:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
											mi->sz_secs[1] + mi->sz_secs[2] + mi->sz_secs[3]);
    10ce:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10d1:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    10d4:	01 c2                	add    edx,eax
											mi->sz_secs[1] + mi->sz_secs[2] + mi->sz_secs[3]);
    10d6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10d9:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    10dc:	01 c2                	add    edx,eax
    10de:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10e1:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    10e4:	01 c2                	add    edx,eax
    10e6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    10e9:	83 ec 04             	sub    esp,0x4
    10ec:	52                   	push   edx
    10ed:	50                   	push   eax
    10ee:	68 55 04 00 00       	push   0x455
    10f3:	e8 fc ff ff ff       	call   10f4 <list_modules+0x6c>
    10f8:	83 c4 10             	add    esp,0x10
				for (int i = 0; i < 7; i++)
    10fb:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    10ff:	83 7d f0 06          	cmp    DWORD PTR [ebp-0x10],0x6
    1103:	7e aa                	jle    10af <list_modules+0x27>
    1105:	eb 01                	jmp    1108 <list_modules+0x80>
						} else
								break;
    1107:	90                   	nop
		} while ((mc = mc->next));
    1108:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    110b:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    110e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1111:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1115:	75 8f                	jne    10a6 <list_modules+0x1e>
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    1117:	8b 15 10 00 00 00    	mov    edx,DWORD PTR ds:0x10
						mod_tbl.sz_secs[1] + mod_tbl.sz_secs[2] + mod_tbl.sz_secs[3]);
    111d:	a1 14 00 00 00       	mov    eax,ds:0x14
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    1122:	01 c2                	add    edx,eax
						mod_tbl.sz_secs[1] + mod_tbl.sz_secs[2] + mod_tbl.sz_secs[3]);
    1124:	a1 18 00 00 00       	mov    eax,ds:0x18
    1129:	01 c2                	add    edx,eax
    112b:	a1 1c 00 00 00       	mov    eax,ds:0x1c
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    1130:	01 d0                	add    eax,edx
    1132:	83 ec 08             	sub    esp,0x8
    1135:	50                   	push   eax
    1136:	68 61 04 00 00       	push   0x461
    113b:	e8 fc ff ff ff       	call   113c <list_modules+0xb4>
    1140:	83 c4 10             	add    esp,0x10
}
    1143:	90                   	nop
    1144:	c9                   	leave
    1145:	c3                   	ret

00001146 <list_module_info>:

void list_module_info(const char* name)
{
    1146:	55                   	push   ebp
    1147:	89 e5                	mov    ebp,esp
    1149:	53                   	push   ebx
    114a:	83 ec 14             	sub    esp,0x14
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    114d:	a1 20 00 00 00       	mov    eax,ds:0x20
    1152:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		do {
				for (int i = 0; i < 7; i++)
    1155:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    115c:	e9 f6 00 00 00       	jmp    1257 <list_module_info+0x111>
						if (mc->ptrs[i]) {
    1161:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1164:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1167:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    116a:	85 c0                	test   eax,eax
    116c:	0f 84 f1 00 00 00    	je     1263 <list_module_info+0x11d>
								struct module_info* mi = mc->ptrs[i];
    1172:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1175:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1178:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    117b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								if (strcmp(mi->mi_name, name) == 0) {
    117e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1181:	83 ec 08             	sub    esp,0x8
    1184:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1187:	50                   	push   eax
    1188:	e8 fc ff ff ff       	call   1189 <list_module_info+0x43>
    118d:	83 c4 10             	add    esp,0x10
    1190:	85 c0                	test   eax,eax
    1192:	0f 85 bb 00 00 00    	jne    1253 <list_module_info+0x10d>
										printf("module %s resides at:\n", name);
    1198:	83 ec 08             	sub    esp,0x8
    119b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    119e:	68 7d 04 00 00       	push   0x47d
    11a3:	e8 fc ff ff ff       	call   11a4 <list_module_info+0x5e>
    11a8:	83 c4 10             	add    esp,0x10
										printf("SECTION     .text    .data  .rodata     .bss\n");
    11ab:	83 ec 0c             	sub    esp,0xc
    11ae:	68 94 04 00 00       	push   0x494
    11b3:	e8 fc ff ff ff       	call   11b4 <list_module_info+0x6e>
    11b8:	83 c4 10             	add    esp,0x10
										printf("OFFSET   %p %p %p %p\n", mi->vm_ofs[0],
    11bb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11be:	8b 58 28             	mov    ebx,DWORD PTR [eax+0x28]
    11c1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11c4:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
    11c7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11ca:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    11cd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11d0:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    11d3:	83 ec 0c             	sub    esp,0xc
    11d6:	53                   	push   ebx
    11d7:	51                   	push   ecx
    11d8:	52                   	push   edx
    11d9:	50                   	push   eax
    11da:	68 c2 04 00 00       	push   0x4c2
    11df:	e8 fc ff ff ff       	call   11e0 <list_module_info+0x9a>
    11e4:	83 c4 20             	add    esp,0x20
												mi->vm_ofs[1], mi->vm_ofs[2], mi->vm_ofs[3]);
										printf("SIZE     %8lu %8lu %8lu %8lu\n", mi->sz_secs[0],
    11e7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11ea:	8b 58 38             	mov    ebx,DWORD PTR [eax+0x38]
    11ed:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11f0:	8b 48 34             	mov    ecx,DWORD PTR [eax+0x34]
    11f3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11f6:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    11f9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11fc:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    11ff:	83 ec 0c             	sub    esp,0xc
    1202:	53                   	push   ebx
    1203:	51                   	push   ecx
    1204:	52                   	push   edx
    1205:	50                   	push   eax
    1206:	68 d8 04 00 00       	push   0x4d8
    120b:	e8 fc ff ff ff       	call   120c <list_module_info+0xc6>
    1210:	83 c4 20             	add    esp,0x20
												mi->sz_secs[1], mi->sz_secs[2], mi->sz_secs[3]);
										printf("with the two functions\n");
    1213:	83 ec 0c             	sub    esp,0xc
    1216:	68 f6 04 00 00       	push   0x4f6
    121b:	e8 fc ff ff ff       	call   121c <list_module_info+0xd6>
    1220:	83 c4 10             	add    esp,0x10
										printf("module_init     at %p and\n", mi->mi_init);
    1223:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1226:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1229:	83 ec 08             	sub    esp,0x8
    122c:	50                   	push   eax
    122d:	68 0e 05 00 00       	push   0x50e
    1232:	e8 fc ff ff ff       	call   1233 <list_module_info+0xed>
    1237:	83 c4 10             	add    esp,0x10
										printf("module_cleanup  at %p\n", mi->mi_cleanup);
    123a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    123d:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1240:	83 ec 08             	sub    esp,0x8
    1243:	50                   	push   eax
    1244:	68 29 05 00 00       	push   0x529
    1249:	e8 fc ff ff ff       	call   124a <list_module_info+0x104>
    124e:	83 c4 10             	add    esp,0x10
										return;
    1251:	eb 37                	jmp    128a <list_module_info+0x144>
				for (int i = 0; i < 7; i++)
    1253:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1257:	83 7d f0 06          	cmp    DWORD PTR [ebp-0x10],0x6
    125b:	0f 8e 00 ff ff ff    	jle    1161 <list_module_info+0x1b>
    1261:	eb 01                	jmp    1264 <list_module_info+0x11e>
								}
						} else
								break;
    1263:	90                   	nop
		} while ((mc = mc->next));
    1264:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1267:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    126a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    126d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1271:	0f 85 de fe ff ff    	jne    1155 <list_module_info+0xf>
		printf("modinfo: ERROR: Module %s not found.\n", name);
    1277:	83 ec 08             	sub    esp,0x8
    127a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    127d:	68 40 05 00 00       	push   0x540
    1282:	e8 fc ff ff ff       	call   1283 <list_module_info+0x13d>
    1287:	83 c4 10             	add    esp,0x10
}
    128a:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    128d:	c9                   	leave
    128e:	c3                   	ret

0000128f <elf_get_closest_symbol>:

const char* elf_get_closest_symbol(void* ptr, size_t* offset)
{
    128f:	55                   	push   ebp
    1290:	89 e5                	mov    ebp,esp
    1292:	83 ec 10             	sub    esp,0x10
		struct symbol_list* sl = gs_lst;
    1295:	a1 00 00 00 00       	mov    eax,ds:0x0
    129a:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		size_t i = 0; const char* rv = ""; void* base = NULL;
    129d:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
    12a4:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    12ab:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		if (!sl) {
    12b2:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
    12b6:	0f 85 96 00 00 00    	jne    1352 <elf_get_closest_symbol+0xc3>
				*offset = (size_t)ptr;
    12bc:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    12bf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    12c2:	89 10                	mov    DWORD PTR [eax],edx
				return "";
    12c4:	b8 00 00 00 00       	mov    eax,0x0
    12c9:	e9 a1 00 00 00       	jmp    136f <elf_get_closest_symbol+0xe0>
		}

		while (sl) {
				if (sl->entries[i].vma <= ptr && sl->entries[i].vma > base) {
    12ce:	8b 4d fc             	mov    ecx,DWORD PTR [ebp-0x4]
    12d1:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
    12d4:	89 d0                	mov    eax,edx
    12d6:	01 c0                	add    eax,eax
    12d8:	01 d0                	add    eax,edx
    12da:	c1 e0 02             	shl    eax,0x2
    12dd:	01 c8                	add    eax,ecx
    12df:	8b 00                	mov    eax,DWORD PTR [eax]
    12e1:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    12e4:	72 4f                	jb     1335 <elf_get_closest_symbol+0xa6>
    12e6:	8b 4d fc             	mov    ecx,DWORD PTR [ebp-0x4]
    12e9:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
    12ec:	89 d0                	mov    eax,edx
    12ee:	01 c0                	add    eax,eax
    12f0:	01 d0                	add    eax,edx
    12f2:	c1 e0 02             	shl    eax,0x2
    12f5:	01 c8                	add    eax,ecx
    12f7:	8b 00                	mov    eax,DWORD PTR [eax]
    12f9:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    12fc:	73 37                	jae    1335 <elf_get_closest_symbol+0xa6>
						/* found a new one */
						rv = sl->entries[i].name;
    12fe:	8b 4d fc             	mov    ecx,DWORD PTR [ebp-0x4]
    1301:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
    1304:	89 d0                	mov    eax,edx
    1306:	01 c0                	add    eax,eax
    1308:	01 d0                	add    eax,edx
    130a:	c1 e0 02             	shl    eax,0x2
    130d:	01 c8                	add    eax,ecx
    130f:	83 c0 04             	add    eax,0x4
    1312:	8b 00                	mov    eax,DWORD PTR [eax]
    1314:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						base = sl->entries[i].vma;
    1317:	8b 4d fc             	mov    ecx,DWORD PTR [ebp-0x4]
    131a:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
    131d:	89 d0                	mov    eax,edx
    131f:	01 c0                	add    eax,eax
    1321:	01 d0                	add    eax,edx
    1323:	c1 e0 02             	shl    eax,0x2
    1326:	01 c8                	add    eax,ecx
    1328:	8b 00                	mov    eax,DWORD PTR [eax]
    132a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if (base == ptr) /* abort on first exact match */
    132d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1330:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    1333:	74 29                	je     135e <elf_get_closest_symbol+0xcf>
								break;
				}
				if (++i == 64) {
    1335:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
    1339:	83 7d f8 40          	cmp    DWORD PTR [ebp-0x8],0x40
    133d:	75 13                	jne    1352 <elf_get_closest_symbol+0xc3>
						sl = sl->next;
    133f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    1342:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
    1348:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						i = 0;
    134b:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
		while (sl) {
    1352:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
    1356:	0f 85 72 ff ff ff    	jne    12ce <elf_get_closest_symbol+0x3f>
    135c:	eb 01                	jmp    135f <elf_get_closest_symbol+0xd0>
								break;
    135e:	90                   	nop
				}
		}

		*offset = ptr - base;
    135f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1362:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    1365:	89 c2                	mov    edx,eax
    1367:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    136a:	89 10                	mov    DWORD PTR [eax],edx
		return rv;
    136c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    136f:	c9                   	leave
    1370:	c3                   	ret

00001371 <elf_resolve_symbols>:

/* bss_vmem is in/out parameter which points to the top of bss after call */
void elf_resolve_symbols(Elf32_Ehdr* hdr, Elf32_Shdr* shdr, Elf32_Half symtab, void** bss_vmem, struct module_info* mi)
{
    1371:	55                   	push   ebp
    1372:	89 e5                	mov    ebp,esp
    1374:	56                   	push   esi
    1375:	53                   	push   ebx
    1376:	83 ec 40             	sub    esp,0x40
    1379:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    137c:	66 89 45 c4          	mov    WORD PTR [ebp-0x3c],ax
		void* ptr = ((void*)hdr + shdr[symtab].sh_offset);
    1380:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1384:	89 d0                	mov    eax,edx
    1386:	c1 e0 02             	shl    eax,0x2
    1389:	01 d0                	add    eax,edx
    138b:	c1 e0 03             	shl    eax,0x3
    138e:	89 c2                	mov    edx,eax
    1390:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1393:	01 d0                	add    eax,edx
    1395:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
    1398:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    139b:	01 d0                	add    eax,edx
    139d:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		size_t i, ct = shdr[symtab].sh_size / shdr[symtab].sh_entsize;
    13a0:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    13a4:	89 d0                	mov    eax,edx
    13a6:	c1 e0 02             	shl    eax,0x2
    13a9:	01 d0                	add    eax,edx
    13ab:	c1 e0 03             	shl    eax,0x3
    13ae:	89 c2                	mov    edx,eax
    13b0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    13b3:	01 d0                	add    eax,edx
    13b5:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
    13b8:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    13bc:	89 d0                	mov    eax,edx
    13be:	c1 e0 02             	shl    eax,0x2
    13c1:	01 d0                	add    eax,edx
    13c3:	c1 e0 03             	shl    eax,0x3
    13c6:	89 c2                	mov    edx,eax
    13c8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    13cb:	01 d0                	add    eax,edx
    13cd:	8b 70 24             	mov    esi,DWORD PTR [eax+0x24]
    13d0:	89 c8                	mov    eax,ecx
    13d2:	ba 00 00 00 00       	mov    edx,0x0
    13d7:	f7 f6                	div    esi
    13d9:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		if (ct <= 1)
    13dc:	83 7d e0 01          	cmp    DWORD PTR [ebp-0x20],0x1
    13e0:	0f 86 1a 06 00 00    	jbe    1a00 <elf_resolve_symbols+0x68f>
				return;
		sbprintf("Resolving symbols in symtab with %lu entries\n", ct);
    13e6:	83 ec 08             	sub    esp,0x8
    13e9:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    13ec:	68 68 05 00 00       	push   0x568
    13f1:	e8 fc ff ff ff       	call   13f2 <elf_resolve_symbols+0x81>
    13f6:	83 c4 10             	add    esp,0x10
		for (i = 1; i < ct; i++) {
    13f9:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
    1400:	e9 ed 05 00 00       	jmp    19f2 <elf_resolve_symbols+0x681>
				Elf32_Sym* s = (ptr + i * shdr[symtab].sh_entsize);
    1405:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1409:	89 d0                	mov    eax,edx
    140b:	c1 e0 02             	shl    eax,0x2
    140e:	01 d0                	add    eax,edx
    1410:	c1 e0 03             	shl    eax,0x3
    1413:	89 c2                	mov    edx,eax
    1415:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1418:	01 d0                	add    eax,edx
    141a:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    141d:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
    1421:	89 c2                	mov    edx,eax
    1423:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1426:	01 d0                	add    eax,edx
    1428:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				if (s->st_shndx == SHN_UNDEF) {
    142b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    142e:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    1432:	66 85 c0             	test   ax,ax
    1435:	0f 85 b9 00 00 00    	jne    14f4 <elf_resolve_symbols+0x183>
						char* sn, tp = 'T';
    143b:	c6 45 f3 54          	mov    BYTE PTR [ebp-0xd],0x54
						/* unresolved symbol -> find in map */
						sbprintf("using external symbol with name %s\n",
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
    143f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1442:	8b 08                	mov    ecx,DWORD PTR [eax]
    1444:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1448:	89 d0                	mov    eax,edx
    144a:	c1 e0 02             	shl    eax,0x2
    144d:	01 d0                	add    eax,edx
    144f:	c1 e0 03             	shl    eax,0x3
    1452:	89 c2                	mov    edx,eax
    1454:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1457:	01 d0                	add    eax,edx
    1459:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    145c:	0f b7 c0             	movzx  eax,ax
    145f:	51                   	push   ecx
    1460:	50                   	push   eax
    1461:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1464:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1467:	e8 fc ff ff ff       	call   1468 <elf_resolve_symbols+0xf7>
    146c:	83 c4 10             	add    esp,0x10
    146f:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						sbprintf("using external symbol with name %s\n",
    1472:	83 ec 08             	sub    esp,0x8
    1475:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    1478:	68 98 05 00 00       	push   0x598
    147d:	e8 fc ff ff ff       	call   147e <elf_resolve_symbols+0x10d>
    1482:	83 c4 10             	add    esp,0x10
						if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    1485:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1488:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    148c:	0f b6 c0             	movzx  eax,al
    148f:	83 e0 0f             	and    eax,0xf
    1492:	83 f8 01             	cmp    eax,0x1
    1495:	75 04                	jne    149b <elf_resolve_symbols+0x12a>
								tp = 'D';
    1497:	c6 45 f3 44          	mov    BYTE PTR [ebp-0xd],0x44
						s->st_value = elf_locate_global_symbol(sn, tp);
    149b:	0f be 45 f3          	movsx  eax,BYTE PTR [ebp-0xd]
    149f:	83 ec 08             	sub    esp,0x8
    14a2:	50                   	push   eax
    14a3:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    14a6:	e8 fc ff ff ff       	call   14a7 <elf_resolve_symbols+0x136>
    14ab:	83 c4 10             	add    esp,0x10
    14ae:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    14b1:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
						if (!s->st_value) {
    14b4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    14b7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    14ba:	85 c0                	test   eax,eax
    14bc:	75 1a                	jne    14d8 <elf_resolve_symbols+0x167>
								cprintf(KFMT_ERROR, "unresolved external symbol %c \"%s\"\n", tp, sn);
    14be:	0f be 45 f3          	movsx  eax,BYTE PTR [ebp-0xd]
    14c2:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    14c5:	50                   	push   eax
    14c6:	68 bc 05 00 00       	push   0x5bc
    14cb:	6a 0c                	push   0xc
    14cd:	e8 fc ff ff ff       	call   14ce <elf_resolve_symbols+0x15d>
    14d2:	83 c4 10             	add    esp,0x10
								while (1);
    14d5:	90                   	nop
    14d6:	eb fd                	jmp    14d5 <elf_resolve_symbols+0x164>
						} else
								sbprintf("\twhich was resolved to %p\n", (void*)s->st_value);
    14d8:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    14db:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    14de:	83 ec 08             	sub    esp,0x8
    14e1:	50                   	push   eax
    14e2:	68 e0 05 00 00       	push   0x5e0
    14e7:	e8 fc ff ff ff       	call   14e8 <elf_resolve_symbols+0x177>
    14ec:	83 c4 10             	add    esp,0x10
    14ef:	e9 fa 04 00 00       	jmp    19ee <elf_resolve_symbols+0x67d>
				} else if (s->st_shndx == SHN_COMMON) {
    14f4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    14f7:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    14fb:	66 83 f8 f2          	cmp    ax,0xfff2
    14ff:	0f 85 9e 01 00 00    	jne    16a3 <elf_resolve_symbols+0x332>
						char* sn, tp = 'D'; Elf32_Addr ad = (Elf32_Addr)NULL;
    1505:	c6 45 d3 44          	mov    BYTE PTR [ebp-0x2d],0x44
    1509:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						sbprintf("Common symbol with size %u and alignment %u with name %s\n",
										s->st_size, s->st_value,
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
    1510:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1513:	8b 08                	mov    ecx,DWORD PTR [eax]
    1515:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1519:	89 d0                	mov    eax,edx
    151b:	c1 e0 02             	shl    eax,0x2
    151e:	01 d0                	add    eax,edx
    1520:	c1 e0 03             	shl    eax,0x3
    1523:	89 c2                	mov    edx,eax
    1525:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1528:	01 d0                	add    eax,edx
    152a:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    152d:	0f b7 c0             	movzx  eax,ax
    1530:	51                   	push   ecx
    1531:	50                   	push   eax
    1532:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1535:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1538:	e8 fc ff ff ff       	call   1539 <elf_resolve_symbols+0x1c8>
    153d:	83 c4 10             	add    esp,0x10
    1540:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
						sbprintf("Common symbol with size %u and alignment %u with name %s\n",
    1543:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1546:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1549:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    154c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    154f:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1552:	52                   	push   edx
    1553:	50                   	push   eax
    1554:	68 fc 05 00 00       	push   0x5fc
    1559:	e8 fc ff ff ff       	call   155a <elf_resolve_symbols+0x1e9>
    155e:	83 c4 10             	add    esp,0x10
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1561:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1564:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1568:	c0 e8 04             	shr    al,0x4
    156b:	3c 01                	cmp    al,0x1
    156d:	74 0e                	je     157d <elf_resolve_symbols+0x20c>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    156f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1572:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1576:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1579:	3c 02                	cmp    al,0x2
    157b:	75 30                	jne    15ad <elf_resolve_symbols+0x23c>
								/* lookup on global symtab */
								ad = elf_locate_global_symbol(sn, tp);
    157d:	0f be 45 d3          	movsx  eax,BYTE PTR [ebp-0x2d]
    1581:	83 ec 08             	sub    esp,0x8
    1584:	50                   	push   eax
    1585:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1588:	e8 fc ff ff ff       	call   1589 <elf_resolve_symbols+0x218>
    158d:	83 c4 10             	add    esp,0x10
    1590:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								if (ad)
    1593:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1597:	74 14                	je     15ad <elf_resolve_symbols+0x23c>
										sbprintf("global definition found at %p\n", (void*)ad);
    1599:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    159c:	83 ec 08             	sub    esp,0x8
    159f:	50                   	push   eax
    15a0:	68 38 06 00 00       	push   0x638
    15a5:	e8 fc ff ff ff       	call   15a6 <elf_resolve_symbols+0x235>
    15aa:	83 c4 10             	add    esp,0x10
						}
						/* lookup on symtab or else allocate */
						if (!ad) {
    15ad:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    15b1:	0f 85 de 00 00 00    	jne    1695 <elf_resolve_symbols+0x324>
								/* allocate rw bss (dumb align) */
								if ((size_t)*bss_vmem % (size_t)s->st_value) {
    15b7:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    15ba:	8b 00                	mov    eax,DWORD PTR [eax]
    15bc:	89 c2                	mov    edx,eax
    15be:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    15c1:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    15c4:	89 d0                	mov    eax,edx
    15c6:	ba 00 00 00 00       	mov    edx,0x0
    15cb:	f7 f1                	div    ecx
    15cd:	89 d0                	mov    eax,edx
    15cf:	85 c0                	test   eax,eax
    15d1:	74 63                	je     1636 <elf_resolve_symbols+0x2c5>
										*bss_vmem += s->st_value - ((size_t)*bss_vmem % s->st_value);
    15d3:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    15d6:	8b 08                	mov    ecx,DWORD PTR [eax]
    15d8:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    15db:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    15de:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    15e1:	8b 00                	mov    eax,DWORD PTR [eax]
    15e3:	89 c2                	mov    edx,eax
    15e5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    15e8:	8b 70 04             	mov    esi,DWORD PTR [eax+0x4]
    15eb:	89 d0                	mov    eax,edx
    15ed:	ba 00 00 00 00       	mov    edx,0x0
    15f2:	f7 f6                	div    esi
    15f4:	89 d8                	mov    eax,ebx
    15f6:	29 d0                	sub    eax,edx
    15f8:	8d 14 01             	lea    edx,[ecx+eax*1]
    15fb:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    15fe:	89 10                	mov    DWORD PTR [eax],edx
										s->st_value = (Elf32_Addr)*bss_vmem;
    1600:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1603:	8b 00                	mov    eax,DWORD PTR [eax]
    1605:	89 c2                	mov    edx,eax
    1607:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    160a:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										*bss_vmem += s->st_size;
    160d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1610:	8b 10                	mov    edx,DWORD PTR [eax]
    1612:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1615:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1618:	01 c2                	add    edx,eax
    161a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    161d:	89 10                	mov    DWORD PTR [eax],edx
										sbprintf("will be allocated at %p\n", (void*)s->st_value);
    161f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1622:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1625:	83 ec 08             	sub    esp,0x8
    1628:	50                   	push   eax
    1629:	68 57 06 00 00       	push   0x657
    162e:	e8 fc ff ff ff       	call   162f <elf_resolve_symbols+0x2be>
    1633:	83 c4 10             	add    esp,0x10
								}
								/* publish the location if applicable */
								if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1636:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1639:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    163d:	c0 e8 04             	shr    al,0x4
    1640:	3c 01                	cmp    al,0x1
    1642:	74 12                	je     1656 <elf_resolve_symbols+0x2e5>
												ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1644:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1647:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    164b:	c0 e8 04             	shr    al,0x4
								if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    164e:	3c 02                	cmp    al,0x2
    1650:	0f 85 98 03 00 00    	jne    19ee <elf_resolve_symbols+0x67d>
										elf_store_global_symbol(sn, (void*)s->st_value, tp,
													   	(ELF32_ST_BIND(s->st_info) == STB_WEAK));
    1656:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1659:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
										elf_store_global_symbol(sn, (void*)s->st_value, tp,
    165d:	c0 e8 04             	shr    al,0x4
    1660:	3c 02                	cmp    al,0x2
    1662:	0f 94 c0             	sete   al
    1665:	0f b6 d0             	movzx  edx,al
    1668:	0f be 45 d3          	movsx  eax,BYTE PTR [ebp-0x2d]
    166c:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    166f:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    1672:	52                   	push   edx
    1673:	50                   	push   eax
    1674:	51                   	push   ecx
    1675:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1678:	e8 fc ff ff ff       	call   1679 <elf_resolve_symbols+0x308>
    167d:	83 c4 10             	add    esp,0x10
										sbprintf("and is global\n");
    1680:	83 ec 0c             	sub    esp,0xc
    1683:	68 70 06 00 00       	push   0x670
    1688:	e8 fc ff ff ff       	call   1689 <elf_resolve_symbols+0x318>
    168d:	83 c4 10             	add    esp,0x10
    1690:	e9 59 03 00 00       	jmp    19ee <elf_resolve_symbols+0x67d>
								}
						} else
								s->st_value = ad;
    1695:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1698:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    169b:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    169e:	e9 4b 03 00 00       	jmp    19ee <elf_resolve_symbols+0x67d>
				} else if (s->st_shndx < SHN_LORESERVE) {
    16a3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16a6:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    16aa:	66 3d ff fe          	cmp    ax,0xfeff
    16ae:	0f 87 49 02 00 00    	ja     18fd <elf_resolve_symbols+0x58c>
						/* local symbol so get virtual address for relocations */
						if (!(shdr[s->st_shndx].sh_flags & SHF_ALLOC))
    16b4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16b7:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    16bb:	0f b7 d0             	movzx  edx,ax
    16be:	89 d0                	mov    eax,edx
    16c0:	c1 e0 02             	shl    eax,0x2
    16c3:	01 d0                	add    eax,edx
    16c5:	c1 e0 03             	shl    eax,0x3
    16c8:	89 c2                	mov    edx,eax
    16ca:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    16cd:	01 d0                	add    eax,edx
    16cf:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    16d2:	83 e0 02             	and    eax,0x2
    16d5:	85 c0                	test   eax,eax
    16d7:	0f 84 10 03 00 00    	je     19ed <elf_resolve_symbols+0x67c>
								continue; /* skip symbols in unused sections */
						s->st_value += shdr[s->st_shndx].sh_addr;
    16dd:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16e0:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    16e3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16e6:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    16ea:	0f b7 d0             	movzx  edx,ax
    16ed:	89 d0                	mov    eax,edx
    16ef:	c1 e0 02             	shl    eax,0x2
    16f2:	01 d0                	add    eax,edx
    16f4:	c1 e0 03             	shl    eax,0x3
    16f7:	89 c2                	mov    edx,eax
    16f9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    16fc:	01 d0                	add    eax,edx
    16fe:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1701:	8d 14 01             	lea    edx,[ecx+eax*1]
    1704:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1707:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						sbprintf("symbol %s from %s defined at vmem=%p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
							  			(void*)s->st_value);
    170a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    170d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1710:	89 c6                	mov    esi,eax
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
    1712:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1715:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    1719:	0f b7 d0             	movzx  edx,ax
    171c:	89 d0                	mov    eax,edx
    171e:	c1 e0 02             	shl    eax,0x2
    1721:	01 d0                	add    eax,edx
    1723:	c1 e0 03             	shl    eax,0x3
    1726:	89 c2                	mov    edx,eax
    1728:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    172b:	01 d0                	add    eax,edx
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    172d:	8b 10                	mov    edx,DWORD PTR [eax]
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
    172f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1732:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1736:	0f b7 c0             	movzx  eax,ax
    1739:	52                   	push   edx
    173a:	50                   	push   eax
    173b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    173e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1741:	e8 fc ff ff ff       	call   1742 <elf_resolve_symbols+0x3d1>
    1746:	83 c4 10             	add    esp,0x10
    1749:	89 c3                	mov    ebx,eax
    174b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    174e:	8b 08                	mov    ecx,DWORD PTR [eax]
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
    1750:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1754:	89 d0                	mov    eax,edx
    1756:	c1 e0 02             	shl    eax,0x2
    1759:	01 d0                	add    eax,edx
    175b:	c1 e0 03             	shl    eax,0x3
    175e:	89 c2                	mov    edx,eax
    1760:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1763:	01 d0                	add    eax,edx
    1765:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1768:	0f b7 c0             	movzx  eax,ax
    176b:	51                   	push   ecx
    176c:	50                   	push   eax
    176d:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1770:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1773:	e8 fc ff ff ff       	call   1774 <elf_resolve_symbols+0x403>
    1778:	83 c4 10             	add    esp,0x10
    177b:	56                   	push   esi
    177c:	53                   	push   ebx
    177d:	50                   	push   eax
    177e:	68 80 06 00 00       	push   0x680
    1783:	e8 fc ff ff ff       	call   1784 <elf_resolve_symbols+0x413>
    1788:	83 c4 10             	add    esp,0x10
						if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_init") == 0) {
    178b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    178e:	8b 08                	mov    ecx,DWORD PTR [eax]
    1790:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1794:	89 d0                	mov    eax,edx
    1796:	c1 e0 02             	shl    eax,0x2
    1799:	01 d0                	add    eax,edx
    179b:	c1 e0 03             	shl    eax,0x3
    179e:	89 c2                	mov    edx,eax
    17a0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17a3:	01 d0                	add    eax,edx
    17a5:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    17a8:	0f b7 c0             	movzx  eax,ax
    17ab:	51                   	push   ecx
    17ac:	50                   	push   eax
    17ad:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    17b0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    17b3:	e8 fc ff ff ff       	call   17b4 <elf_resolve_symbols+0x443>
    17b8:	83 c4 10             	add    esp,0x10
    17bb:	83 ec 08             	sub    esp,0x8
    17be:	68 a6 06 00 00       	push   0x6a6
    17c3:	50                   	push   eax
    17c4:	e8 fc ff ff ff       	call   17c5 <elf_resolve_symbols+0x454>
    17c9:	83 c4 10             	add    esp,0x10
    17cc:	85 c0                	test   eax,eax
    17ce:	75 27                	jne    17f7 <elf_resolve_symbols+0x486>
								mi->mi_init = (mod_init)s->st_value;
    17d0:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    17d3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    17d6:	89 c2                	mov    edx,eax
    17d8:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    17db:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
								sbprintf("found global entry module_init at %p\n", mi->mi_init);
    17de:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    17e1:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    17e4:	83 ec 08             	sub    esp,0x8
    17e7:	50                   	push   eax
    17e8:	68 b4 06 00 00       	push   0x6b4
    17ed:	e8 fc ff ff ff       	call   17ee <elf_resolve_symbols+0x47d>
    17f2:	83 c4 10             	add    esp,0x10
    17f5:	eb 6a                	jmp    1861 <elf_resolve_symbols+0x4f0>
						} else if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_cleanup") == 0) {
    17f7:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    17fa:	8b 08                	mov    ecx,DWORD PTR [eax]
    17fc:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1800:	89 d0                	mov    eax,edx
    1802:	c1 e0 02             	shl    eax,0x2
    1805:	01 d0                	add    eax,edx
    1807:	c1 e0 03             	shl    eax,0x3
    180a:	89 c2                	mov    edx,eax
    180c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    180f:	01 d0                	add    eax,edx
    1811:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1814:	0f b7 c0             	movzx  eax,ax
    1817:	51                   	push   ecx
    1818:	50                   	push   eax
    1819:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    181c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    181f:	e8 fc ff ff ff       	call   1820 <elf_resolve_symbols+0x4af>
    1824:	83 c4 10             	add    esp,0x10
    1827:	83 ec 08             	sub    esp,0x8
    182a:	68 da 06 00 00       	push   0x6da
    182f:	50                   	push   eax
    1830:	e8 fc ff ff ff       	call   1831 <elf_resolve_symbols+0x4c0>
    1835:	83 c4 10             	add    esp,0x10
    1838:	85 c0                	test   eax,eax
    183a:	75 25                	jne    1861 <elf_resolve_symbols+0x4f0>
								mi->mi_cleanup = (mod_cleanup)s->st_value;
    183c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    183f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1842:	89 c2                	mov    edx,eax
    1844:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    1847:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
								sbprintf("found global exit module_cleanup at %p\n", mi->mi_cleanup);
    184a:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    184d:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1850:	83 ec 08             	sub    esp,0x8
    1853:	50                   	push   eax
    1854:	68 ec 06 00 00       	push   0x6ec
    1859:	e8 fc ff ff ff       	call   185a <elf_resolve_symbols+0x4e9>
    185e:	83 c4 10             	add    esp,0x10
						}
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1861:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1864:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1868:	c0 e8 04             	shr    al,0x4
    186b:	3c 01                	cmp    al,0x1
    186d:	74 12                	je     1881 <elf_resolve_symbols+0x510>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    186f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1872:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1876:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1879:	3c 02                	cmp    al,0x2
    187b:	0f 85 6d 01 00 00    	jne    19ee <elf_resolve_symbols+0x67d>
								/* exported symbol -> to global symtab */
								char tp = 'T', *sn;
    1881:	c6 45 eb 54          	mov    BYTE PTR [ebp-0x15],0x54
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    1885:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1888:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    188c:	0f b6 c0             	movzx  eax,al
    188f:	83 e0 0f             	and    eax,0xf
    1892:	83 f8 01             	cmp    eax,0x1
    1895:	75 04                	jne    189b <elf_resolve_symbols+0x52a>
										tp = 'D';
    1897:	c6 45 eb 44          	mov    BYTE PTR [ebp-0x15],0x44
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
    189b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    189e:	8b 08                	mov    ecx,DWORD PTR [eax]
    18a0:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    18a4:	89 d0                	mov    eax,edx
    18a6:	c1 e0 02             	shl    eax,0x2
    18a9:	01 d0                	add    eax,edx
    18ab:	c1 e0 03             	shl    eax,0x3
    18ae:	89 c2                	mov    edx,eax
    18b0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18b3:	01 d0                	add    eax,edx
    18b5:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    18b8:	0f b7 c0             	movzx  eax,ax
    18bb:	51                   	push   ecx
    18bc:	50                   	push   eax
    18bd:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    18c0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    18c3:	e8 fc ff ff ff       	call   18c4 <elf_resolve_symbols+0x553>
    18c8:	83 c4 10             	add    esp,0x10
    18cb:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
    18ce:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    18d1:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    18d5:	c0 e8 04             	shr    al,0x4
    18d8:	3c 02                	cmp    al,0x2
    18da:	0f 94 c0             	sete   al
    18dd:	0f b6 d0             	movzx  edx,al
    18e0:	0f be 45 eb          	movsx  eax,BYTE PTR [ebp-0x15]
    18e4:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    18e7:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    18ea:	52                   	push   edx
    18eb:	50                   	push   eax
    18ec:	51                   	push   ecx
    18ed:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    18f0:	e8 fc ff ff ff       	call   18f1 <elf_resolve_symbols+0x580>
    18f5:	83 c4 10             	add    esp,0x10
    18f8:	e9 f1 00 00 00       	jmp    19ee <elf_resolve_symbols+0x67d>
						}
				} else if (s->st_shndx == SHN_ABS) {
    18fd:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1900:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    1904:	66 83 f8 f1          	cmp    ax,0xfff1
    1908:	0f 85 e0 00 00 00    	jne    19ee <elf_resolve_symbols+0x67d>
						sbprintf("absolute symbol with name %s and value %p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
							  			(void*)s->st_value);
    190e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1911:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
						sbprintf("absolute symbol with name %s and value %p\n",
    1914:	89 c3                	mov    ebx,eax
    1916:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1919:	8b 08                	mov    ecx,DWORD PTR [eax]
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
    191b:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    191f:	89 d0                	mov    eax,edx
    1921:	c1 e0 02             	shl    eax,0x2
    1924:	01 d0                	add    eax,edx
    1926:	c1 e0 03             	shl    eax,0x3
    1929:	89 c2                	mov    edx,eax
    192b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    192e:	01 d0                	add    eax,edx
    1930:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
						sbprintf("absolute symbol with name %s and value %p\n",
    1933:	0f b7 c0             	movzx  eax,ax
    1936:	51                   	push   ecx
    1937:	50                   	push   eax
    1938:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    193b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    193e:	e8 fc ff ff ff       	call   193f <elf_resolve_symbols+0x5ce>
    1943:	83 c4 10             	add    esp,0x10
    1946:	83 ec 04             	sub    esp,0x4
    1949:	53                   	push   ebx
    194a:	50                   	push   eax
    194b:	68 14 07 00 00       	push   0x714
    1950:	e8 fc ff ff ff       	call   1951 <elf_resolve_symbols+0x5e0>
    1955:	83 c4 10             	add    esp,0x10
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1958:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    195b:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    195f:	c0 e8 04             	shr    al,0x4
    1962:	3c 01                	cmp    al,0x1
    1964:	74 0e                	je     1974 <elf_resolve_symbols+0x603>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1966:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1969:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    196d:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1970:	3c 02                	cmp    al,0x2
    1972:	75 7a                	jne    19ee <elf_resolve_symbols+0x67d>
								char tp = 'T', *sn;
    1974:	c6 45 ea 54          	mov    BYTE PTR [ebp-0x16],0x54
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    1978:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    197b:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    197f:	0f b6 c0             	movzx  eax,al
    1982:	83 e0 0f             	and    eax,0xf
    1985:	83 f8 01             	cmp    eax,0x1
    1988:	75 04                	jne    198e <elf_resolve_symbols+0x61d>
										tp = 'D';
    198a:	c6 45 ea 44          	mov    BYTE PTR [ebp-0x16],0x44
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
    198e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1991:	8b 08                	mov    ecx,DWORD PTR [eax]
    1993:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1997:	89 d0                	mov    eax,edx
    1999:	c1 e0 02             	shl    eax,0x2
    199c:	01 d0                	add    eax,edx
    199e:	c1 e0 03             	shl    eax,0x3
    19a1:	89 c2                	mov    edx,eax
    19a3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19a6:	01 d0                	add    eax,edx
    19a8:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    19ab:	0f b7 c0             	movzx  eax,ax
    19ae:	51                   	push   ecx
    19af:	50                   	push   eax
    19b0:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    19b3:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    19b6:	e8 fc ff ff ff       	call   19b7 <elf_resolve_symbols+0x646>
    19bb:	83 c4 10             	add    esp,0x10
    19be:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
    19c1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    19c4:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    19c8:	c0 e8 04             	shr    al,0x4
    19cb:	3c 02                	cmp    al,0x2
    19cd:	0f 94 c0             	sete   al
    19d0:	0f b6 d0             	movzx  edx,al
    19d3:	0f be 45 ea          	movsx  eax,BYTE PTR [ebp-0x16]
    19d7:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    19da:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    19dd:	52                   	push   edx
    19de:	50                   	push   eax
    19df:	51                   	push   ecx
    19e0:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    19e3:	e8 fc ff ff ff       	call   19e4 <elf_resolve_symbols+0x673>
    19e8:	83 c4 10             	add    esp,0x10
    19eb:	eb 01                	jmp    19ee <elf_resolve_symbols+0x67d>
								continue; /* skip symbols in unused sections */
    19ed:	90                   	nop
		for (i = 1; i < ct; i++) {
    19ee:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    19f2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    19f5:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    19f8:	0f 82 07 fa ff ff    	jb     1405 <elf_resolve_symbols+0x94>
    19fe:	eb 01                	jmp    1a01 <elf_resolve_symbols+0x690>
				return;
    1a00:	90                   	nop
						}
				}
		}
}
    1a01:	8d 65 f8             	lea    esp,[ebp-0x8]
    1a04:	5b                   	pop    ebx
    1a05:	5e                   	pop    esi
    1a06:	5d                   	pop    ebp
    1a07:	c3                   	ret

00001a08 <load_elf>:

/*#define ELF_DIAG*/

enum elferr load_elf(void* mem, uint32_t sz, struct module_info* mi)
{
    1a08:	55                   	push   ebp
    1a09:	89 e5                	mov    ebp,esp
    1a0b:	53                   	push   ebx
    1a0c:	81 ec d4 00 00 00    	sub    esp,0xd4
		Elf32_Ehdr* hdr = (Elf32_Ehdr*)mem;
    1a12:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a15:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		Elf32_Shdr* shdr; size_t i;

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, 4) != 0)
    1a18:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1a1b:	83 ec 04             	sub    esp,0x4
    1a1e:	6a 04                	push   0x4
    1a20:	68 3f 07 00 00       	push   0x73f
    1a25:	50                   	push   eax
    1a26:	e8 fc ff ff ff       	call   1a27 <load_elf+0x1f>
    1a2b:	83 c4 10             	add    esp,0x10
    1a2e:	85 c0                	test   eax,eax
    1a30:	74 0a                	je     1a3c <load_elf+0x34>
				return ELF_WRONG_MAGIC;
    1a32:	b8 01 00 00 00       	mov    eax,0x1
    1a37:	e9 7f 0b 00 00       	jmp    25bb <load_elf+0xbb3>
		if (hdr->e_ident[EI_CLASS] != ELFCLASS32)
    1a3c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1a3f:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
    1a43:	3c 01                	cmp    al,0x1
    1a45:	74 0a                	je     1a51 <load_elf+0x49>
				return ELF_NOT_CLASS32;
    1a47:	b8 02 00 00 00       	mov    eax,0x2
    1a4c:	e9 6a 0b 00 00       	jmp    25bb <load_elf+0xbb3>
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
    1a51:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1a54:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
    1a58:	3c 01                	cmp    al,0x1
    1a5a:	74 0a                	je     1a66 <load_elf+0x5e>
				return ELF_NOT_LE;
    1a5c:	b8 03 00 00 00       	mov    eax,0x3
    1a61:	e9 55 0b 00 00       	jmp    25bb <load_elf+0xbb3>
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
    1a66:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1a69:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
    1a6d:	3c 01                	cmp    al,0x1
    1a6f:	74 0a                	je     1a7b <load_elf+0x73>
				return ELF_VERSION_NOT_SUPPORTED;
    1a71:	b8 05 00 00 00       	mov    eax,0x5
    1a76:	e9 40 0b 00 00       	jmp    25bb <load_elf+0xbb3>
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
    1a7b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1a7e:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    1a82:	84 c0                	test   al,al
    1a84:	74 0a                	je     1a90 <load_elf+0x88>
				return ELF_WRONG_OSABI;
    1a86:	b8 06 00 00 00       	mov    eax,0x6
    1a8b:	e9 2b 0b 00 00       	jmp    25bb <load_elf+0xbb3>

		/* matching ELF32 found -> check for object file */
		if (hdr->e_type != ET_REL)
    1a90:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1a93:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
    1a97:	66 83 f8 01          	cmp    ax,0x1
    1a9b:	74 0a                	je     1aa7 <load_elf+0x9f>
				return ELF_NOT_REL;
    1a9d:	b8 07 00 00 00       	mov    eax,0x7
    1aa2:	e9 14 0b 00 00       	jmp    25bb <load_elf+0xbb3>
		if (hdr->e_machine != EM_386)
    1aa7:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1aaa:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
    1aae:	66 83 f8 03          	cmp    ax,0x3
    1ab2:	74 0a                	je     1abe <load_elf+0xb6>
				return ELF_NOT_386;
    1ab4:	b8 08 00 00 00       	mov    eax,0x8
    1ab9:	e9 fd 0a 00 00       	jmp    25bb <load_elf+0xbb3>
		if (hdr->e_ehsize != sizeof(*hdr))
    1abe:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1ac1:	0f b7 40 28          	movzx  eax,WORD PTR [eax+0x28]
    1ac5:	66 83 f8 34          	cmp    ax,0x34
    1ac9:	74 0a                	je     1ad5 <load_elf+0xcd>
				return ELF_INCOMPATIBLE_HEADER;
    1acb:	b8 09 00 00 00       	mov    eax,0x9
    1ad0:	e9 e6 0a 00 00       	jmp    25bb <load_elf+0xbb3>
		if (hdr->e_phnum)
    1ad5:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1ad8:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    1adc:	66 85 c0             	test   ax,ax
    1adf:	74 0a                	je     1aeb <load_elf+0xe3>
				return ELF_CONTAINS_PROG_HEADERS;
    1ae1:	b8 0a 00 00 00       	mov    eax,0xa
    1ae6:	e9 d0 0a 00 00       	jmp    25bb <load_elf+0xbb3>
		if (!hdr->e_shnum)
    1aeb:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1aee:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    1af2:	66 85 c0             	test   ax,ax
    1af5:	75 0a                	jne    1b01 <load_elf+0xf9>
				return ELF_NO_SECTIONS_DEFINED;
    1af7:	b8 0b 00 00 00       	mov    eax,0xb
    1afc:	e9 ba 0a 00 00       	jmp    25bb <load_elf+0xbb3>
		if (hdr->e_shentsize != sizeof(Elf32_Shdr))
    1b01:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1b04:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    1b08:	66 83 f8 28          	cmp    ax,0x28
    1b0c:	74 0a                	je     1b18 <load_elf+0x110>
				return ELF_WRONG_SHDR_SIZE;
    1b0e:	b8 0c 00 00 00       	mov    eax,0xc
    1b13:	e9 a3 0a 00 00       	jmp    25bb <load_elf+0xbb3>
		if (hdr->e_shstrndx == SHN_UNDEF)
    1b18:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1b1b:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
    1b1f:	66 85 c0             	test   ax,ax
    1b22:	75 0a                	jne    1b2e <load_elf+0x126>
				return ELF_NO_SECTION_STRTAB;
    1b24:	b8 0d 00 00 00       	mov    eax,0xd
    1b29:	e9 8d 0a 00 00       	jmp    25bb <load_elf+0xbb3>

		/* set the initial offsets */
		for (i = 0; i < 4; i++)
    1b2e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1b35:	eb 1b                	jmp    1b52 <load_elf+0x14a>
				mi->vm_ofs[i] = mod_tbl.vm_ofs[i];
    1b37:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1b3a:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    1b41:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b44:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    1b47:	83 c1 04             	add    ecx,0x4
    1b4a:	89 54 88 0c          	mov    DWORD PTR [eax+ecx*4+0xc],edx
		for (i = 0; i < 4; i++)
    1b4e:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1b52:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    1b56:	76 df                	jbe    1b37 <load_elf+0x12f>

		/* now first allocate the sections in memory */
		shdr = mem + hdr->e_shoff;
    1b58:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1b5b:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    1b5e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b61:	01 d0                	add    eax,edx
    1b63:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
		for (i = 0; i < hdr->e_shnum; i++) {
    1b66:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1b6d:	e9 08 06 00 00       	jmp    217a <load_elf+0x772>
				if (shdr[i].sh_type == SHT_NULL)
    1b72:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1b75:	89 d0                	mov    eax,edx
    1b77:	c1 e0 02             	shl    eax,0x2
    1b7a:	01 d0                	add    eax,edx
    1b7c:	c1 e0 03             	shl    eax,0x3
    1b7f:	89 c2                	mov    edx,eax
    1b81:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1b84:	01 d0                	add    eax,edx
    1b86:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b89:	85 c0                	test   eax,eax
    1b8b:	0f 84 e4 05 00 00    	je     2175 <load_elf+0x76d>
						continue;

				/* only allocate alloc section */
				if (shdr[i].sh_flags & SHF_ALLOC) {
    1b91:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1b94:	89 d0                	mov    eax,edx
    1b96:	c1 e0 02             	shl    eax,0x2
    1b99:	01 d0                	add    eax,edx
    1b9b:	c1 e0 03             	shl    eax,0x3
    1b9e:	89 c2                	mov    edx,eax
    1ba0:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1ba3:	01 d0                	add    eax,edx
    1ba5:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1ba8:	83 e0 02             	and    eax,0x2
    1bab:	85 c0                	test   eax,eax
    1bad:	0f 84 c3 05 00 00    	je     2176 <load_elf+0x76e>
						size_t pg_ct; struct page_range pr[10];
						Elf32_Word algn = shdr[i].sh_addralign;
    1bb3:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1bb6:	89 d0                	mov    eax,edx
    1bb8:	c1 e0 02             	shl    eax,0x2
    1bbb:	01 d0                	add    eax,edx
    1bbd:	c1 e0 03             	shl    eax,0x3
    1bc0:	89 c2                	mov    edx,eax
    1bc2:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1bc5:	01 d0                	add    eax,edx
    1bc7:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1bca:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
						Elf32_Addr addr; void* mapaddr; int reuse = 0;
    1bcd:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						Elf32_Off ofs = shdr[i].sh_offset;
    1bd4:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1bd7:	89 d0                	mov    eax,edx
    1bd9:	c1 e0 02             	shl    eax,0x2
    1bdc:	01 d0                	add    eax,edx
    1bde:	c1 e0 03             	shl    eax,0x3
    1be1:	89 c2                	mov    edx,eax
    1be3:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1be6:	01 d0                	add    eax,edx
    1be8:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1beb:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						enum mt_sec sct;

						pg_ct = shdr[i].sh_size / 4096 + ((shdr[i].sh_size % 4096) ? 1 : 0);
    1bee:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1bf1:	89 d0                	mov    eax,edx
    1bf3:	c1 e0 02             	shl    eax,0x2
    1bf6:	01 d0                	add    eax,edx
    1bf8:	c1 e0 03             	shl    eax,0x3
    1bfb:	89 c2                	mov    edx,eax
    1bfd:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1c00:	01 d0                	add    eax,edx
    1c02:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1c05:	c1 e8 0c             	shr    eax,0xc
    1c08:	89 c1                	mov    ecx,eax
    1c0a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1c0d:	89 d0                	mov    eax,edx
    1c0f:	c1 e0 02             	shl    eax,0x2
    1c12:	01 d0                	add    eax,edx
    1c14:	c1 e0 03             	shl    eax,0x3
    1c17:	89 c2                	mov    edx,eax
    1c19:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1c1c:	01 d0                	add    eax,edx
    1c1e:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1c21:	25 ff 0f 00 00       	and    eax,0xfff
    1c26:	85 c0                	test   eax,eax
    1c28:	74 07                	je     1c31 <load_elf+0x229>
    1c2a:	b8 01 00 00 00       	mov    eax,0x1
    1c2f:	eb 05                	jmp    1c36 <load_elf+0x22e>
    1c31:	b8 00 00 00 00       	mov    eax,0x0
    1c36:	01 c8                	add    eax,ecx
    1c38:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						/* get the section type */
						if (shdr[i].sh_flags & SHF_WRITE) {
    1c3b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1c3e:	89 d0                	mov    eax,edx
    1c40:	c1 e0 02             	shl    eax,0x2
    1c43:	01 d0                	add    eax,edx
    1c45:	c1 e0 03             	shl    eax,0x3
    1c48:	89 c2                	mov    edx,eax
    1c4a:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1c4d:	01 d0                	add    eax,edx
    1c4f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1c52:	83 e0 01             	and    eax,0x1
    1c55:	85 c0                	test   eax,eax
    1c57:	74 56                	je     1caf <load_elf+0x2a7>
								/* TODO: C-o-w bss */
								if (shdr[i].sh_flags & SHF_EXECINSTR)
    1c59:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1c5c:	89 d0                	mov    eax,edx
    1c5e:	c1 e0 02             	shl    eax,0x2
    1c61:	01 d0                	add    eax,edx
    1c63:	c1 e0 03             	shl    eax,0x3
    1c66:	89 c2                	mov    edx,eax
    1c68:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1c6b:	01 d0                	add    eax,edx
    1c6d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1c70:	83 e0 04             	and    eax,0x4
    1c73:	85 c0                	test   eax,eax
    1c75:	74 0a                	je     1c81 <load_elf+0x279>
										return ELF_SECTION_RWX;
    1c77:	b8 0e 00 00 00       	mov    eax,0xe
    1c7c:	e9 3a 09 00 00       	jmp    25bb <load_elf+0xbb3>
								if (shdr[i].sh_type == SHT_NOBITS)
    1c81:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1c84:	89 d0                	mov    eax,edx
    1c86:	c1 e0 02             	shl    eax,0x2
    1c89:	01 d0                	add    eax,edx
    1c8b:	c1 e0 03             	shl    eax,0x3
    1c8e:	89 c2                	mov    edx,eax
    1c90:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1c93:	01 d0                	add    eax,edx
    1c95:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c98:	83 f8 08             	cmp    eax,0x8
    1c9b:	75 09                	jne    1ca6 <load_elf+0x29e>
										sct = MT_SEC_BSS;
    1c9d:	c7 45 dc 03 00 00 00 	mov    DWORD PTR [ebp-0x24],0x3
    1ca4:	eb 66                	jmp    1d0c <load_elf+0x304>
								else
										sct = MT_SEC_DATA;
    1ca6:	c7 45 dc 01 00 00 00 	mov    DWORD PTR [ebp-0x24],0x1
    1cad:	eb 5d                	jmp    1d0c <load_elf+0x304>
						} else if (shdr[i].sh_flags & SHF_EXECINSTR)
    1caf:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1cb2:	89 d0                	mov    eax,edx
    1cb4:	c1 e0 02             	shl    eax,0x2
    1cb7:	01 d0                	add    eax,edx
    1cb9:	c1 e0 03             	shl    eax,0x3
    1cbc:	89 c2                	mov    edx,eax
    1cbe:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1cc1:	01 d0                	add    eax,edx
    1cc3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1cc6:	83 e0 04             	and    eax,0x4
    1cc9:	85 c0                	test   eax,eax
    1ccb:	74 09                	je     1cd6 <load_elf+0x2ce>
								sct = MT_SEC_TEXT;
    1ccd:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1cd4:	eb 36                	jmp    1d0c <load_elf+0x304>
						else {
								/* rodata, robss? */
								if (shdr[i].sh_type == SHT_NOBITS) {
    1cd6:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1cd9:	89 d0                	mov    eax,edx
    1cdb:	c1 e0 02             	shl    eax,0x2
    1cde:	01 d0                	add    eax,edx
    1ce0:	c1 e0 03             	shl    eax,0x3
    1ce3:	89 c2                	mov    edx,eax
    1ce5:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1ce8:	01 d0                	add    eax,edx
    1cea:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ced:	83 f8 08             	cmp    eax,0x8
    1cf0:	75 13                	jne    1d05 <load_elf+0x2fd>
										printf("Implement zero page!\n");
    1cf2:	83 ec 0c             	sub    esp,0xc
    1cf5:	68 44 07 00 00       	push   0x744
    1cfa:	e8 fc ff ff ff       	call   1cfb <load_elf+0x2f3>
    1cff:	83 c4 10             	add    esp,0x10
										while (1); /* c-o-w? nope! */
    1d02:	90                   	nop
    1d03:	eb fd                	jmp    1d02 <load_elf+0x2fa>
								}
								sct = MT_SEC_RODATA;
    1d05:	c7 45 dc 02 00 00 00 	mov    DWORD PTR [ebp-0x24],0x2
						}
						/* get the raw (unaligned) address */
						addr = (Elf32_Addr)mod_tbl.vm_ofs[sct] + mi->sz_secs[sct];
    1d0c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d0f:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1d16:	89 c1                	mov    ecx,eax
    1d18:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d1b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1d1e:	83 c2 08             	add    edx,0x8
    1d21:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    1d25:	01 c8                	add    eax,ecx
    1d27:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						mbprintf("unaligned address for %s: %p\n", elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[i].sh_name), (void*)addr);
    1d2a:	8b 5d ec             	mov    ebx,DWORD PTR [ebp-0x14]
    1d2d:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1d30:	89 d0                	mov    eax,edx
    1d32:	c1 e0 02             	shl    eax,0x2
    1d35:	01 d0                	add    eax,edx
    1d37:	c1 e0 03             	shl    eax,0x3
    1d3a:	89 c2                	mov    edx,eax
    1d3c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1d3f:	01 d0                	add    eax,edx
    1d41:	8b 10                	mov    edx,DWORD PTR [eax]
    1d43:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1d46:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
    1d4a:	0f b7 c0             	movzx  eax,ax
    1d4d:	52                   	push   edx
    1d4e:	50                   	push   eax
    1d4f:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1d52:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    1d55:	e8 fc ff ff ff       	call   1d56 <load_elf+0x34e>
    1d5a:	83 c4 10             	add    esp,0x10
    1d5d:	83 ec 04             	sub    esp,0x4
    1d60:	53                   	push   ebx
    1d61:	50                   	push   eax
    1d62:	68 5a 07 00 00       	push   0x75a
    1d67:	e8 fc ff ff ff       	call   1d68 <load_elf+0x360>
    1d6c:	83 c4 10             	add    esp,0x10

						/* now do the alignment calculations */
						if (addr % algn)
    1d6f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1d72:	ba 00 00 00 00       	mov    edx,0x0
    1d77:	f7 75 b8             	div    DWORD PTR [ebp-0x48]
    1d7a:	89 d0                	mov    eax,edx
    1d7c:	85 c0                	test   eax,eax
    1d7e:	74 13                	je     1d93 <load_elf+0x38b>
								addr += algn - addr % algn;
    1d80:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1d83:	ba 00 00 00 00       	mov    edx,0x0
    1d88:	f7 75 b8             	div    DWORD PTR [ebp-0x48]
    1d8b:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1d8e:	29 d0                	sub    eax,edx
    1d90:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
						if (algn < 0x1000 && (addr % 4096)) {
    1d93:	81 7d b8 ff 0f 00 00 	cmp    DWORD PTR [ebp-0x48],0xfff
    1d9a:	77 62                	ja     1dfe <load_elf+0x3f6>
    1d9c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1d9f:	25 ff 0f 00 00       	and    eax,0xfff
    1da4:	85 c0                	test   eax,eax
    1da6:	74 56                	je     1dfe <load_elf+0x3f6>
								/* maybe save up to a single page by reusing an existing one of the same module */
								size_t ovs = shdr[i].sh_size % 4096; /* "oversize" */
    1da8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1dab:	89 d0                	mov    eax,edx
    1dad:	c1 e0 02             	shl    eax,0x2
    1db0:	01 d0                	add    eax,edx
    1db2:	c1 e0 03             	shl    eax,0x3
    1db5:	89 c2                	mov    edx,eax
    1db7:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1dba:	01 d0                	add    eax,edx
    1dbc:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1dbf:	25 ff 0f 00 00       	and    eax,0xfff
    1dc4:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
								if (ovs && ovs < (4096 - (addr % 4096))) {
    1dc7:	83 7d b4 00          	cmp    DWORD PTR [ebp-0x4c],0x0
    1dcb:	74 31                	je     1dfe <load_elf+0x3f6>
    1dcd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1dd0:	25 ff 0f 00 00       	and    eax,0xfff
    1dd5:	89 c2                	mov    edx,eax
    1dd7:	b8 00 10 00 00       	mov    eax,0x1000
    1ddc:	29 d0                	sub    eax,edx
    1dde:	39 45 b4             	cmp    DWORD PTR [ebp-0x4c],eax
    1de1:	73 1b                	jae    1dfe <load_elf+0x3f6>
										/* oversize fits into existing page */
										mbprintf("reuse\n");
    1de3:	83 ec 0c             	sub    esp,0xc
    1de6:	68 78 07 00 00       	push   0x778
    1deb:	e8 fc ff ff ff       	call   1dec <load_elf+0x3e4>
    1df0:	83 c4 10             	add    esp,0x10
										pg_ct--;
    1df3:	83 6d f0 01          	sub    DWORD PTR [ebp-0x10],0x1
										reuse = 1;
    1df7:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
								}
						}
						if (addr % 4096)
    1dfe:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e01:	25 ff 0f 00 00       	and    eax,0xfff
    1e06:	85 c0                	test   eax,eax
    1e08:	74 57                	je     1e61 <load_elf+0x459>
								if (reuse) /* first use partially present page */
    1e0a:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1e0e:	74 12                	je     1e22 <load_elf+0x41a>
										mapaddr = (void*)(addr + 4096 - addr % 4096);
    1e10:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e13:	25 00 f0 ff ff       	and    eax,0xfffff000
    1e18:	05 00 10 00 00       	add    eax,0x1000
    1e1d:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1e20:	eb 45                	jmp    1e67 <load_elf+0x45f>
								else { /* alignment leaves page partially unused */
										mapaddr = (void*)(addr - addr % 4096);
    1e22:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e25:	25 00 f0 ff ff       	and    eax,0xfffff000
    1e2a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										if (pg_ct * 4096 < shdr[i].sh_size + addr % 4096)
    1e2d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1e30:	c1 e0 0c             	shl    eax,0xc
    1e33:	89 c1                	mov    ecx,eax
    1e35:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1e38:	89 d0                	mov    eax,edx
    1e3a:	c1 e0 02             	shl    eax,0x2
    1e3d:	01 d0                	add    eax,edx
    1e3f:	c1 e0 03             	shl    eax,0x3
    1e42:	89 c2                	mov    edx,eax
    1e44:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1e47:	01 d0                	add    eax,edx
    1e49:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1e4c:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1e4f:	81 e2 ff 0f 00 00    	and    edx,0xfff
    1e55:	01 d0                	add    eax,edx
    1e57:	39 c1                	cmp    ecx,eax
    1e59:	73 0c                	jae    1e67 <load_elf+0x45f>
												pg_ct++; /* adjust space accordingly */
    1e5b:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1e5f:	eb 06                	jmp    1e67 <load_elf+0x45f>
								}
						else
								mapaddr = (void*)addr;
    1e61:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e64:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

						shdr[i].sh_addr = addr;
    1e67:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1e6a:	89 d0                	mov    eax,edx
    1e6c:	c1 e0 02             	shl    eax,0x2
    1e6f:	01 d0                	add    eax,edx
    1e71:	c1 e0 03             	shl    eax,0x3
    1e74:	89 c2                	mov    edx,eax
    1e76:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1e79:	01 c2                	add    edx,eax
    1e7b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e7e:	89 42 0c             	mov    DWORD PTR [edx+0xc],eax
						mbprintf("aligned address: %p\n", (void*)addr);
    1e81:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e84:	83 ec 08             	sub    esp,0x8
    1e87:	50                   	push   eax
    1e88:	68 7f 07 00 00       	push   0x77f
    1e8d:	e8 fc ff ff ff       	call   1e8e <load_elf+0x486>
    1e92:	83 c4 10             	add    esp,0x10
						if (!mi->vm_ofs[sct])
    1e95:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1e98:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1e9b:	83 c2 04             	add    edx,0x4
    1e9e:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    1ea2:	85 c0                	test   eax,eax
    1ea4:	75 10                	jne    1eb6 <load_elf+0x4ae>
								mi->vm_ofs[sct] = (void*)addr;
    1ea6:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1ea9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1eac:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    1eaf:	83 c1 04             	add    ecx,0x4
    1eb2:	89 54 88 0c          	mov    DWORD PTR [eax+ecx*4+0xc],edx
						mi->sz_secs[sct] += shdr[i].sh_size;
    1eb6:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1eb9:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1ebc:	83 c2 08             	add    edx,0x8
    1ebf:	8b 4c 90 0c          	mov    ecx,DWORD PTR [eax+edx*4+0xc]
    1ec3:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1ec6:	89 d0                	mov    eax,edx
    1ec8:	c1 e0 02             	shl    eax,0x2
    1ecb:	01 d0                	add    eax,edx
    1ecd:	c1 e0 03             	shl    eax,0x3
    1ed0:	89 c2                	mov    edx,eax
    1ed2:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1ed5:	01 d0                	add    eax,edx
    1ed7:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1eda:	01 c1                	add    ecx,eax
    1edc:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1edf:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1ee2:	83 c2 08             	add    edx,0x8
    1ee5:	89 4c 90 0c          	mov    DWORD PTR [eax+edx*4+0xc],ecx

						/* fill the half-used page (if PROGBITS) */
						if (((void*)addr < mapaddr) && (shdr[i].sh_type != SHT_NOBITS)) {
    1ee9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1eec:	3b 45 e8             	cmp    eax,DWORD PTR [ebp-0x18]
    1eef:	73 6e                	jae    1f5f <load_elf+0x557>
    1ef1:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1ef4:	89 d0                	mov    eax,edx
    1ef6:	c1 e0 02             	shl    eax,0x2
    1ef9:	01 d0                	add    eax,edx
    1efb:	c1 e0 03             	shl    eax,0x3
    1efe:	89 c2                	mov    edx,eax
    1f00:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1f03:	01 d0                	add    eax,edx
    1f05:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1f08:	83 f8 08             	cmp    eax,0x8
    1f0b:	74 52                	je     1f5f <load_elf+0x557>
								size_t n = (size_t)mapaddr - (size_t)addr;
    1f0d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1f10:	2b 45 ec             	sub    eax,DWORD PTR [ebp-0x14]
    1f13:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
								n = min(n, shdr[i].sh_size);
    1f16:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1f19:	89 d0                	mov    eax,edx
    1f1b:	c1 e0 02             	shl    eax,0x2
    1f1e:	01 d0                	add    eax,edx
    1f20:	c1 e0 03             	shl    eax,0x3
    1f23:	89 c2                	mov    edx,eax
    1f25:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1f28:	01 d0                	add    eax,edx
    1f2a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1f2d:	8b 55 b0             	mov    edx,DWORD PTR [ebp-0x50]
    1f30:	39 c2                	cmp    edx,eax
    1f32:	0f 46 c2             	cmovbe eax,edx
    1f35:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
								memcpy((void*)addr, (void*)hdr + ofs, n);
    1f38:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    1f3b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1f3e:	01 c2                	add    edx,eax
    1f40:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1f43:	83 ec 04             	sub    esp,0x4
    1f46:	ff 75 b0             	push   DWORD PTR [ebp-0x50]
    1f49:	52                   	push   edx
    1f4a:	50                   	push   eax
    1f4b:	e8 b0 e0 ff ff       	call   0 <memcpy>
    1f50:	83 c4 10             	add    esp,0x10
								ofs += n;
    1f53:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    1f56:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
								addr += n;
    1f59:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    1f5c:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
						}
						/* allocate the physical memory and map it to virtual memory */
						mbprintf("allocating %lu pages for size=%u\n", pg_ct, shdr[i].sh_size);
    1f5f:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1f62:	89 d0                	mov    eax,edx
    1f64:	c1 e0 02             	shl    eax,0x2
    1f67:	01 d0                	add    eax,edx
    1f69:	c1 e0 03             	shl    eax,0x3
    1f6c:	89 c2                	mov    edx,eax
    1f6e:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1f71:	01 d0                	add    eax,edx
    1f73:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1f76:	83 ec 04             	sub    esp,0x4
    1f79:	50                   	push   eax
    1f7a:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1f7d:	68 94 07 00 00       	push   0x794
    1f82:	e8 fc ff ff ff       	call   1f83 <load_elf+0x57b>
    1f87:	83 c4 10             	add    esp,0x10
						while (pg_ct) {
    1f8a:	e9 da 01 00 00       	jmp    2169 <load_elf+0x761>
								int flags = MMGR_MAP_KERNEL, remap = 0;
    1f8f:	c7 45 d8 08 00 00 00 	mov    DWORD PTR [ebp-0x28],0x8
    1f96:	c7 45 ac 00 00 00 00 	mov    DWORD PTR [ebp-0x54],0x0
								size_t np = mm_alloc_pm(pg_ct, pr, countof(pr));
    1f9d:	83 ec 04             	sub    esp,0x4
    1fa0:	6a 0a                	push   0xa
    1fa2:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    1fa8:	50                   	push   eax
    1fa9:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1fac:	e8 fc ff ff ff       	call   1fad <load_elf+0x5a5>
    1fb1:	83 c4 10             	add    esp,0x10
    1fb4:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
								if (shdr[i].sh_flags & SHF_EXECINSTR)
    1fb7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1fba:	89 d0                	mov    eax,edx
    1fbc:	c1 e0 02             	shl    eax,0x2
    1fbf:	01 d0                	add    eax,edx
    1fc1:	c1 e0 03             	shl    eax,0x3
    1fc4:	89 c2                	mov    edx,eax
    1fc6:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1fc9:	01 d0                	add    eax,edx
    1fcb:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1fce:	83 e0 04             	and    eax,0x4
    1fd1:	85 c0                	test   eax,eax
    1fd3:	74 04                	je     1fd9 <load_elf+0x5d1>
										flags |= MMGR_MAP_EXECUTE;
    1fd5:	83 4d d8 02          	or     DWORD PTR [ebp-0x28],0x2
								if (shdr[i].sh_flags & SHF_WRITE)
    1fd9:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1fdc:	89 d0                	mov    eax,edx
    1fde:	c1 e0 02             	shl    eax,0x2
    1fe1:	01 d0                	add    eax,edx
    1fe3:	c1 e0 03             	shl    eax,0x3
    1fe6:	89 c2                	mov    edx,eax
    1fe8:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1feb:	01 d0                	add    eax,edx
    1fed:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1ff0:	83 e0 01             	and    eax,0x1
    1ff3:	85 c0                	test   eax,eax
    1ff5:	74 06                	je     1ffd <load_elf+0x5f5>
										flags |= MMGR_MAP_WRITE;
    1ff7:	83 4d d8 04          	or     DWORD PTR [ebp-0x28],0x4
    1ffb:	eb 20                	jmp    201d <load_elf+0x615>
								else if (shdr[i].sh_type != SHT_NOBITS) {
    1ffd:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2000:	89 d0                	mov    eax,edx
    2002:	c1 e0 02             	shl    eax,0x2
    2005:	01 d0                	add    eax,edx
    2007:	c1 e0 03             	shl    eax,0x3
    200a:	89 c2                	mov    edx,eax
    200c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    200f:	01 d0                	add    eax,edx
    2011:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2014:	83 f8 08             	cmp    eax,0x8
    2017:	74 04                	je     201d <load_elf+0x615>
										flags |= MMGR_MAP_WRITE;
    2019:	83 4d d8 04          	or     DWORD PTR [ebp-0x28],0x4
								}

								mbprintf("mapping %lu pages to %p\n", np, mapaddr);
    201d:	83 ec 04             	sub    esp,0x4
    2020:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    2023:	ff 75 a8             	push   DWORD PTR [ebp-0x58]
    2026:	68 b6 07 00 00       	push   0x7b6
    202b:	e8 fc ff ff ff       	call   202c <load_elf+0x624>
    2030:	83 c4 10             	add    esp,0x10
								if (mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags) != mapaddr) {
    2033:	83 ec 0c             	sub    esp,0xc
    2036:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    2039:	6a 0a                	push   0xa
    203b:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    2041:	50                   	push   eax
    2042:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    2045:	68 00 00 00 00       	push   0x0
    204a:	e8 fc ff ff ff       	call   204b <load_elf+0x643>
    204f:	83 c4 20             	add    esp,0x20
    2052:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
    2055:	74 13                	je     206a <load_elf+0x662>
										printf("unexpected error mapping pmem to vmem\n");
    2057:	83 ec 0c             	sub    esp,0xc
    205a:	68 d0 07 00 00       	push   0x7d0
    205f:	e8 fc ff ff ff       	call   2060 <load_elf+0x658>
    2064:	83 c4 10             	add    esp,0x10
										while (1);
    2067:	90                   	nop
    2068:	eb fd                	jmp    2067 <load_elf+0x65f>
								}
								/* copy data if present */
								if (shdr[i].sh_type != SHT_NOBITS) {
    206a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    206d:	89 d0                	mov    eax,edx
    206f:	c1 e0 02             	shl    eax,0x2
    2072:	01 d0                	add    eax,edx
    2074:	c1 e0 03             	shl    eax,0x3
    2077:	89 c2                	mov    edx,eax
    2079:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    207c:	01 d0                	add    eax,edx
    207e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2081:	83 f8 08             	cmp    eax,0x8
    2084:	0f 84 d0 00 00 00    	je     215a <load_elf+0x752>
										size_t n = min(np * 4096, shdr[i].sh_size - (ofs - shdr[i].sh_offset));
    208a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    208d:	89 d0                	mov    eax,edx
    208f:	c1 e0 02             	shl    eax,0x2
    2092:	01 d0                	add    eax,edx
    2094:	c1 e0 03             	shl    eax,0x3
    2097:	89 c2                	mov    edx,eax
    2099:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    209c:	01 d0                	add    eax,edx
    209e:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
    20a1:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    20a4:	89 d0                	mov    eax,edx
    20a6:	c1 e0 02             	shl    eax,0x2
    20a9:	01 d0                	add    eax,edx
    20ab:	c1 e0 03             	shl    eax,0x3
    20ae:	89 c2                	mov    edx,eax
    20b0:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    20b3:	01 d0                	add    eax,edx
    20b5:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    20b8:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
    20bb:	8d 14 01             	lea    edx,[ecx+eax*1]
    20be:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    20c1:	c1 e0 0c             	shl    eax,0xc
    20c4:	39 c2                	cmp    edx,eax
    20c6:	0f 46 c2             	cmovbe eax,edx
    20c9:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
										mbprintf("n=%lu, ofs=%u\n", n, ofs);
    20cc:	83 ec 04             	sub    esp,0x4
    20cf:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    20d2:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    20d5:	68 f7 07 00 00       	push   0x7f7
    20da:	e8 fc ff ff ff       	call   20db <load_elf+0x6d3>
    20df:	83 c4 10             	add    esp,0x10
										if ((void*)addr > mapaddr)
    20e2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    20e5:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
    20e8:	73 09                	jae    20f3 <load_elf+0x6eb>
												n -= (size_t)addr - (size_t)mapaddr;
    20ea:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    20ed:	2b 45 ec             	sub    eax,DWORD PTR [ebp-0x14]
    20f0:	01 45 d4             	add    DWORD PTR [ebp-0x2c],eax
										memcpy((void*)addr, (void*)hdr + ofs, n);
    20f3:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    20f6:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    20f9:	01 c2                	add    edx,eax
    20fb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    20fe:	83 ec 04             	sub    esp,0x4
    2101:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    2104:	52                   	push   edx
    2105:	50                   	push   eax
    2106:	e8 f5 de ff ff       	call   0 <memcpy>
    210b:	83 c4 10             	add    esp,0x10
										mbprintf("copying %lu bytes to %p\n", n, (void*)addr);
    210e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2111:	83 ec 04             	sub    esp,0x4
    2114:	50                   	push   eax
    2115:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    2118:	68 06 08 00 00       	push   0x806
    211d:	e8 fc ff ff ff       	call   211e <load_elf+0x716>
    2122:	83 c4 10             	add    esp,0x10
										ofs += n;
    2125:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2128:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
										addr += n;
    212b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    212e:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
										if (remap) {
    2131:	83 7d ac 00          	cmp    DWORD PTR [ebp-0x54],0x0
    2135:	74 23                	je     215a <load_elf+0x752>
												flags &= ~MMGR_MAP_WRITE;
    2137:	83 65 d8 fb          	and    DWORD PTR [ebp-0x28],0xfffffffb
												mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags);
    213b:	83 ec 0c             	sub    esp,0xc
    213e:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    2141:	6a 0a                	push   0xa
    2143:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    2149:	50                   	push   eax
    214a:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    214d:	68 00 00 00 00       	push   0x0
    2152:	e8 fc ff ff ff       	call   2153 <load_elf+0x74b>
    2157:	83 c4 20             	add    esp,0x20
										}
								}
								mapaddr += np * 4096;
    215a:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    215d:	c1 e0 0c             	shl    eax,0xc
    2160:	01 45 e8             	add    DWORD PTR [ebp-0x18],eax
								pg_ct -= np;
    2163:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2166:	29 45 f0             	sub    DWORD PTR [ebp-0x10],eax
						while (pg_ct) {
    2169:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    216d:	0f 85 1c fe ff ff    	jne    1f8f <load_elf+0x587>
    2173:	eb 01                	jmp    2176 <load_elf+0x76e>
						continue;
    2175:	90                   	nop
		for (i = 0; i < hdr->e_shnum; i++) {
    2176:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    217a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    217d:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    2181:	0f b7 c0             	movzx  eax,ax
    2184:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    2187:	0f 82 e5 f9 ff ff    	jb     1b72 <load_elf+0x16a>
				}
#endif
		}

		/* Now determine the symbol values*/
		for (i = 0; i < hdr->e_shnum; i++)
    218d:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2194:	e9 33 01 00 00       	jmp    22cc <load_elf+0x8c4>
				if (shdr[i].sh_type == SHT_SYMTAB) {
    2199:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    219c:	89 d0                	mov    eax,edx
    219e:	c1 e0 02             	shl    eax,0x2
    21a1:	01 d0                	add    eax,edx
    21a3:	c1 e0 03             	shl    eax,0x3
    21a6:	89 c2                	mov    edx,eax
    21a8:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    21ab:	01 d0                	add    eax,edx
    21ad:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    21b0:	83 f8 02             	cmp    eax,0x2
    21b3:	0f 85 0f 01 00 00    	jne    22c8 <load_elf+0x8c0>
						void* vm_bss = mi->vm_ofs[MT_SEC_BSS] + mi->sz_secs[MT_SEC_BSS];
    21b9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    21bc:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
    21bf:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    21c2:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    21c5:	01 d0                	add    eax,edx
    21c7:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
						void* vm_aold = vm_bss + (((size_t)vm_bss % 4096) ? (4096 - ((size_t)vm_bss % 4096)) : 0);
    21ca:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    21cd:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    21d0:	25 ff 0f 00 00       	and    eax,0xfff
    21d5:	85 c0                	test   eax,eax
    21d7:	74 13                	je     21ec <load_elf+0x7e4>
    21d9:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    21dc:	25 ff 0f 00 00       	and    eax,0xfff
    21e1:	89 c1                	mov    ecx,eax
    21e3:	b8 00 10 00 00       	mov    eax,0x1000
    21e8:	29 c8                	sub    eax,ecx
    21ea:	eb 05                	jmp    21f1 <load_elf+0x7e9>
    21ec:	b8 00 00 00 00       	mov    eax,0x0
    21f1:	01 d0                	add    eax,edx
    21f3:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
						elf_resolve_symbols(hdr, shdr, i, &vm_bss, mi);
    21f6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    21f9:	0f b7 c0             	movzx  eax,ax
    21fc:	83 ec 0c             	sub    esp,0xc
    21ff:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    2202:	8d 55 a4             	lea    edx,[ebp-0x5c]
    2205:	52                   	push   edx
    2206:	50                   	push   eax
    2207:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    220a:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    220d:	e8 fc ff ff ff       	call   220e <load_elf+0x806>
    2212:	83 c4 20             	add    esp,0x20
						if (vm_bss > vm_aold) {
    2215:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    2218:	39 45 c0             	cmp    DWORD PTR [ebp-0x40],eax
    221b:	0f 83 a7 00 00 00    	jae    22c8 <load_elf+0x8c0>
								size_t pgc = 0; struct page_range pr[10];
    2221:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
								/* allocate new bss sections */
								pgc = vm_bss - vm_aold;
    2228:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    222b:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    222e:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
								pgc = pgc / 4096 + (pgc % 4096) ? 1 : 0;
    2231:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2234:	c1 e8 0c             	shr    eax,0xc
    2237:	89 c2                	mov    edx,eax
    2239:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    223c:	25 ff 0f 00 00       	and    eax,0xfff
    2241:	01 d0                	add    eax,edx
    2243:	85 c0                	test   eax,eax
    2245:	0f 95 c0             	setne  al
    2248:	0f b6 c0             	movzx  eax,al
    224b:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
								if (mm_alloc_pm(pgc, pr, 10) == pgc) {
    224e:	83 ec 04             	sub    esp,0x4
    2251:	6a 0a                	push   0xa
    2253:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    2259:	50                   	push   eax
    225a:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    225d:	e8 fc ff ff ff       	call   225e <load_elf+0x856>
    2262:	83 c4 10             	add    esp,0x10
    2265:	39 45 bc             	cmp    DWORD PTR [ebp-0x44],eax
    2268:	75 4b                	jne    22b5 <load_elf+0x8ad>
										/* success */
										if (!mm_map(&mm_kernel, vm_aold, pr, 10, MMGR_MAP_WRITE | MMGR_MAP_KERNEL)) {
    226a:	83 ec 0c             	sub    esp,0xc
    226d:	6a 0c                	push   0xc
    226f:	6a 0a                	push   0xa
    2271:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    2277:	50                   	push   eax
    2278:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
    227b:	68 00 00 00 00       	push   0x0
    2280:	e8 fc ff ff ff       	call   2281 <load_elf+0x879>
    2285:	83 c4 20             	add    esp,0x20
    2288:	85 c0                	test   eax,eax
    228a:	75 16                	jne    22a2 <load_elf+0x89a>
												printf("unable to map new bss pages to %p\n", vm_aold);
    228c:	83 ec 08             	sub    esp,0x8
    228f:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
    2292:	68 20 08 00 00       	push   0x820
    2297:	e8 fc ff ff ff       	call   2298 <load_elf+0x890>
    229c:	83 c4 10             	add    esp,0x10
												while (1);
    229f:	90                   	nop
    22a0:	eb fd                	jmp    229f <load_elf+0x897>
										}
										mi->sz_secs[MT_SEC_BSS] = vm_bss - mi->vm_ofs[MT_SEC_BSS];
    22a2:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    22a5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    22a8:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    22ab:	29 c2                	sub    edx,eax
    22ad:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    22b0:	89 50 38             	mov    DWORD PTR [eax+0x38],edx
    22b3:	eb 13                	jmp    22c8 <load_elf+0x8c0>
								} else {
										printf("failed to extend bss section\n");
    22b5:	83 ec 0c             	sub    esp,0xc
    22b8:	68 43 08 00 00       	push   0x843
    22bd:	e8 fc ff ff ff       	call   22be <load_elf+0x8b6>
    22c2:	83 c4 10             	add    esp,0x10
										while (1);
    22c5:	90                   	nop
    22c6:	eb fd                	jmp    22c5 <load_elf+0x8bd>
		for (i = 0; i < hdr->e_shnum; i++)
    22c8:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    22cc:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    22cf:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    22d3:	0f b7 c0             	movzx  eax,ax
    22d6:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    22d9:	0f 82 ba fe ff ff    	jb     2199 <load_elf+0x791>
								}
						}
				}

		/* and perform the relocations */
		for (i = 0; i < hdr->e_shnum; i++)
    22df:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    22e6:	e9 0e 02 00 00       	jmp    24f9 <load_elf+0xaf1>
				if (shdr[i].sh_type == SHT_REL || shdr[i].sh_type == SHT_RELA) {
    22eb:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    22ee:	89 d0                	mov    eax,edx
    22f0:	c1 e0 02             	shl    eax,0x2
    22f3:	01 d0                	add    eax,edx
    22f5:	c1 e0 03             	shl    eax,0x3
    22f8:	89 c2                	mov    edx,eax
    22fa:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    22fd:	01 d0                	add    eax,edx
    22ff:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2302:	83 f8 09             	cmp    eax,0x9
    2305:	74 20                	je     2327 <load_elf+0x91f>
    2307:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    230a:	89 d0                	mov    eax,edx
    230c:	c1 e0 02             	shl    eax,0x2
    230f:	01 d0                	add    eax,edx
    2311:	c1 e0 03             	shl    eax,0x3
    2314:	89 c2                	mov    edx,eax
    2316:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2319:	01 d0                	add    eax,edx
    231b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    231e:	83 f8 04             	cmp    eax,0x4
    2321:	0f 85 ce 01 00 00    	jne    24f5 <load_elf+0xaed>
						if (shdr[shdr[i].sh_info].sh_flags & SHF_ALLOC) {
    2327:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    232a:	89 d0                	mov    eax,edx
    232c:	c1 e0 02             	shl    eax,0x2
    232f:	01 d0                	add    eax,edx
    2331:	c1 e0 03             	shl    eax,0x3
    2334:	89 c2                	mov    edx,eax
    2336:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2339:	01 d0                	add    eax,edx
    233b:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    233e:	89 d0                	mov    eax,edx
    2340:	c1 e0 02             	shl    eax,0x2
    2343:	01 d0                	add    eax,edx
    2345:	c1 e0 03             	shl    eax,0x3
    2348:	89 c2                	mov    edx,eax
    234a:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    234d:	01 d0                	add    eax,edx
    234f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2352:	83 e0 02             	and    eax,0x2
    2355:	85 c0                	test   eax,eax
    2357:	0f 84 98 01 00 00    	je     24f5 <load_elf+0xaed>
								void* vm_begin = (void*)shdr[shdr[i].sh_info].sh_addr;
    235d:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2360:	89 d0                	mov    eax,edx
    2362:	c1 e0 02             	shl    eax,0x2
    2365:	01 d0                	add    eax,edx
    2367:	c1 e0 03             	shl    eax,0x3
    236a:	89 c2                	mov    edx,eax
    236c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    236f:	01 d0                	add    eax,edx
    2371:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    2374:	89 d0                	mov    eax,edx
    2376:	c1 e0 02             	shl    eax,0x2
    2379:	01 d0                	add    eax,edx
    237b:	c1 e0 03             	shl    eax,0x3
    237e:	89 c2                	mov    edx,eax
    2380:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2383:	01 d0                	add    eax,edx
    2385:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2388:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
								size_t pgc = shdr[shdr[i].sh_info].sh_size;
    238b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    238e:	89 d0                	mov    eax,edx
    2390:	c1 e0 02             	shl    eax,0x2
    2393:	01 d0                	add    eax,edx
    2395:	c1 e0 03             	shl    eax,0x3
    2398:	89 c2                	mov    edx,eax
    239a:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    239d:	01 d0                	add    eax,edx
    239f:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    23a2:	89 d0                	mov    eax,edx
    23a4:	c1 e0 02             	shl    eax,0x2
    23a7:	01 d0                	add    eax,edx
    23a9:	c1 e0 03             	shl    eax,0x3
    23ac:	89 c2                	mov    edx,eax
    23ae:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    23b1:	01 d0                	add    eax,edx
    23b3:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    23b6:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
								pgc = pgc / 4096 + ((pgc % 4096) ? 1 : 0);
    23b9:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    23bc:	c1 e8 0c             	shr    eax,0xc
    23bf:	89 c2                	mov    edx,eax
    23c1:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    23c4:	25 ff 0f 00 00       	and    eax,0xfff
    23c9:	85 c0                	test   eax,eax
    23cb:	74 07                	je     23d4 <load_elf+0x9cc>
    23cd:	b8 01 00 00 00       	mov    eax,0x1
    23d2:	eb 05                	jmp    23d9 <load_elf+0x9d1>
    23d4:	b8 00 00 00 00       	mov    eax,0x0
    23d9:	01 d0                	add    eax,edx
    23db:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
								printf("performing relocations on section %s:\n",
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[shdr[i].sh_info].sh_name));
    23de:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    23e1:	89 d0                	mov    eax,edx
    23e3:	c1 e0 02             	shl    eax,0x2
    23e6:	01 d0                	add    eax,edx
    23e8:	c1 e0 03             	shl    eax,0x3
    23eb:	89 c2                	mov    edx,eax
    23ed:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    23f0:	01 d0                	add    eax,edx
    23f2:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    23f5:	89 d0                	mov    eax,edx
    23f7:	c1 e0 02             	shl    eax,0x2
    23fa:	01 d0                	add    eax,edx
    23fc:	c1 e0 03             	shl    eax,0x3
    23ff:	89 c2                	mov    edx,eax
    2401:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2404:	01 d0                	add    eax,edx
								printf("performing relocations on section %s:\n",
    2406:	8b 10                	mov    edx,DWORD PTR [eax]
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[shdr[i].sh_info].sh_name));
    2408:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    240b:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
								printf("performing relocations on section %s:\n",
    240f:	0f b7 c0             	movzx  eax,ax
    2412:	52                   	push   edx
    2413:	50                   	push   eax
    2414:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    2417:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    241a:	e8 fc ff ff ff       	call   241b <load_elf+0xa13>
    241f:	83 c4 10             	add    esp,0x10
    2422:	83 ec 08             	sub    esp,0x8
    2425:	50                   	push   eax
    2426:	68 64 08 00 00       	push   0x864
    242b:	e8 fc ff ff ff       	call   242c <load_elf+0xa24>
    2430:	83 c4 10             	add    esp,0x10
								/* unguard the section */
								printf("modifying %lu pages at %p\n", pgc, vm_begin);
    2433:	83 ec 04             	sub    esp,0x4
    2436:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    2439:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    243c:	68 8b 08 00 00       	push   0x88b
    2441:	e8 fc ff ff ff       	call   2442 <load_elf+0xa3a>
    2446:	83 c4 10             	add    esp,0x10
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
    2449:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    244c:	89 d0                	mov    eax,edx
    244e:	c1 e0 02             	shl    eax,0x2
    2451:	01 d0                	add    eax,edx
    2453:	c1 e0 03             	shl    eax,0x3
    2456:	89 c2                	mov    edx,eax
    2458:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    245b:	01 d0                	add    eax,edx
    245d:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    2460:	89 d0                	mov    eax,edx
    2462:	c1 e0 02             	shl    eax,0x2
    2465:	01 d0                	add    eax,edx
    2467:	c1 e0 03             	shl    eax,0x3
    246a:	89 c2                	mov    edx,eax
    246c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    246f:	01 d0                	add    eax,edx
    2471:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2474:	83 e0 01             	and    eax,0x1
    2477:	85 c0                	test   eax,eax
    2479:	75 18                	jne    2493 <load_elf+0xa8b>
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_SET);
    247b:	68 04 10 00 00       	push   0x1004
    2480:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    2483:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    2486:	68 00 00 00 00       	push   0x0
    248b:	e8 fc ff ff ff       	call   248c <load_elf+0xa84>
    2490:	83 c4 10             	add    esp,0x10
								/* relocate */
								elf_relocate_section(hdr, shdr, i);
    2493:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2496:	0f b7 c0             	movzx  eax,ax
    2499:	83 ec 04             	sub    esp,0x4
    249c:	50                   	push   eax
    249d:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    24a0:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    24a3:	e8 fc ff ff ff       	call   24a4 <load_elf+0xa9c>
    24a8:	83 c4 10             	add    esp,0x10
								/* reguard the section */
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
    24ab:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    24ae:	89 d0                	mov    eax,edx
    24b0:	c1 e0 02             	shl    eax,0x2
    24b3:	01 d0                	add    eax,edx
    24b5:	c1 e0 03             	shl    eax,0x3
    24b8:	89 c2                	mov    edx,eax
    24ba:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    24bd:	01 d0                	add    eax,edx
    24bf:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    24c2:	89 d0                	mov    eax,edx
    24c4:	c1 e0 02             	shl    eax,0x2
    24c7:	01 d0                	add    eax,edx
    24c9:	c1 e0 03             	shl    eax,0x3
    24cc:	89 c2                	mov    edx,eax
    24ce:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    24d1:	01 d0                	add    eax,edx
    24d3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    24d6:	83 e0 01             	and    eax,0x1
    24d9:	85 c0                	test   eax,eax
    24db:	75 18                	jne    24f5 <load_elf+0xaed>
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_UNSET);
    24dd:	68 04 20 00 00       	push   0x2004
    24e2:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    24e5:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    24e8:	68 00 00 00 00       	push   0x0
    24ed:	e8 fc ff ff ff       	call   24ee <load_elf+0xae6>
    24f2:	83 c4 10             	add    esp,0x10
		for (i = 0; i < hdr->e_shnum; i++)
    24f5:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    24f9:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    24fc:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    2500:	0f b7 c0             	movzx  eax,ax
    2503:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    2506:	0f 82 df fd ff ff    	jb     22eb <load_elf+0x8e3>
						}
				}

		/* page-align for the next module */
		/* DBG: and insert a guard-page */
		for (i = 0; i < 4; i++) {
    250c:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2513:	e9 94 00 00 00       	jmp    25ac <load_elf+0xba4>
				if (mi->sz_secs[i]) {
    2518:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    251b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    251e:	83 c2 08             	add    edx,0x8
    2521:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    2525:	85 c0                	test   eax,eax
    2527:	74 7f                	je     25a8 <load_elf+0xba0>
						mod_tbl.vm_ofs[i] = mi->vm_ofs[i] + mi->sz_secs[i];
    2529:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    252c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    252f:	83 c2 04             	add    edx,0x4
    2532:	8b 54 90 0c          	mov    edx,DWORD PTR [eax+edx*4+0xc]
    2536:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2539:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    253c:	83 c1 08             	add    ecx,0x8
    253f:	8b 44 88 0c          	mov    eax,DWORD PTR [eax+ecx*4+0xc]
    2543:	01 c2                	add    edx,eax
    2545:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2548:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						if ((size_t)mod_tbl.vm_ofs[i] % 4096) {
    254f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2552:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    2559:	25 ff 0f 00 00       	and    eax,0xfff
    255e:	85 c0                	test   eax,eax
    2560:	74 2c                	je     258e <load_elf+0xb86>
								/* section align */
								mod_tbl.vm_ofs[i] += 4096 - (size_t)mod_tbl.vm_ofs[i] % 4096;
    2562:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2565:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    256c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    256f:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    2576:	25 ff 0f 00 00       	and    eax,0xfff
    257b:	b9 00 10 00 00       	mov    ecx,0x1000
    2580:	29 c1                	sub    ecx,eax
    2582:	01 ca                	add    edx,ecx
    2584:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2587:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						}
						/* add guard page */
						mod_tbl.vm_ofs[i] += 4096;
    258e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2591:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    2598:	8d 90 00 10 00 00    	lea    edx,[eax+0x1000]
    259e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    25a1:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
		for (i = 0; i < 4; i++) {
    25a8:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    25ac:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    25b0:	0f 86 62 ff ff ff    	jbe    2518 <load_elf+0xb10>
				}
		}

		return ELF_OK;
    25b6:	b8 00 00 00 00       	mov    eax,0x0
}
    25bb:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    25be:	c9                   	leave
    25bf:	c3                   	ret

000025c0 <get_elferr_string>:

const char* get_elferr_string(enum elferr e)
{
    25c0:	55                   	push   ebp
    25c1:	89 e5                	mov    ebp,esp
		switch (e) {
    25c3:	83 7d 08 11          	cmp    DWORD PTR [ebp+0x8],0x11
    25c7:	0f 87 86 00 00 00    	ja     2653 <get_elferr_string+0x93>
    25cd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25d0:	c1 e0 02             	shl    eax,0x2
    25d3:	05 e4 0a 00 00       	add    eax,0xae4
    25d8:	8b 00                	mov    eax,DWORD PTR [eax]
    25da:	ff e0                	jmp    eax
		case ELF_WRONG_MAGIC:
				return "not ELF file";
    25dc:	b8 a6 08 00 00       	mov    eax,0x8a6
    25e1:	eb 75                	jmp    2658 <get_elferr_string+0x98>
		case ELF_NOT_CLASS32:
				return "not a 32-bit ELF file";
    25e3:	b8 b3 08 00 00       	mov    eax,0x8b3
    25e8:	eb 6e                	jmp    2658 <get_elferr_string+0x98>
		case ELF_NOMEM:
				return "out of memory";
    25ea:	b8 c9 08 00 00       	mov    eax,0x8c9
    25ef:	eb 67                	jmp    2658 <get_elferr_string+0x98>
		case ELF_NOT_LE:
				return "not a little-endian file";
    25f1:	b8 d7 08 00 00       	mov    eax,0x8d7
    25f6:	eb 60                	jmp    2658 <get_elferr_string+0x98>
		case ELF_VERSION_NOT_SUPPORTED:
				return "unsupported ELF version";
    25f8:	b8 f0 08 00 00       	mov    eax,0x8f0
    25fd:	eb 59                	jmp    2658 <get_elferr_string+0x98>
		case ELF_WRONG_OSABI:
				return "unsupported OS ABI";
    25ff:	b8 08 09 00 00       	mov    eax,0x908
    2604:	eb 52                	jmp    2658 <get_elferr_string+0x98>
		case ELF_NOT_REL:
				return "modules have to be relocatable object files";
    2606:	b8 1c 09 00 00       	mov    eax,0x91c
    260b:	eb 4b                	jmp    2658 <get_elferr_string+0x98>
		case ELF_NOT_386:
				return "only i386 modules can be loaded";
    260d:	b8 48 09 00 00       	mov    eax,0x948
    2612:	eb 44                	jmp    2658 <get_elferr_string+0x98>
		case ELF_INCOMPATIBLE_HEADER:
				return "unexpected size of ELF header";
    2614:	b8 68 09 00 00       	mov    eax,0x968
    2619:	eb 3d                	jmp    2658 <get_elferr_string+0x98>
		case ELF_CONTAINS_PROG_HEADERS:
				return "ELF contains program heades (no object file)";
    261b:	b8 88 09 00 00       	mov    eax,0x988
    2620:	eb 36                	jmp    2658 <get_elferr_string+0x98>
		case ELF_NO_SECTIONS_DEFINED:
				return "ELF contains no defined sections";
    2622:	b8 b8 09 00 00       	mov    eax,0x9b8
    2627:	eb 2f                	jmp    2658 <get_elferr_string+0x98>
		case ELF_WRONG_SHDR_SIZE:
				return "no matching ELF section header size";
    2629:	b8 dc 09 00 00       	mov    eax,0x9dc
    262e:	eb 28                	jmp    2658 <get_elferr_string+0x98>
		case ELF_NO_SECTION_STRTAB:
				return "no ELF STRTAB for section names";
    2630:	b8 00 0a 00 00       	mov    eax,0xa00
    2635:	eb 21                	jmp    2658 <get_elferr_string+0x98>
		case ELF_SECTION_RWX:
				return "module contains rwx secton";
    2637:	b8 20 0a 00 00       	mov    eax,0xa20
    263c:	eb 1a                	jmp    2658 <get_elferr_string+0x98>
		case ELF_GSTAB_ALREADY_PRESENT:
				return "the global symbol table has already been loaded";
    263e:	b8 3c 0a 00 00       	mov    eax,0xa3c
    2643:	eb 13                	jmp    2658 <get_elferr_string+0x98>
		case ELF_STRING_PARSE_NUMBER:
				return "the string parser expected a number but found none";
    2645:	b8 6c 0a 00 00       	mov    eax,0xa6c
    264a:	eb 0c                	jmp    2658 <get_elferr_string+0x98>
		case ELF_PARSE_FORMAT_NOT_NM:
				return "the provided symbol mapping file is not in the nm format";
    264c:	b8 a0 0a 00 00       	mov    eax,0xaa0
    2651:	eb 05                	jmp    2658 <get_elferr_string+0x98>
		default:
				return "unknown";
    2653:	b8 d9 0a 00 00       	mov    eax,0xad9
		}
}
    2658:	5d                   	pop    ebp
    2659:	c3                   	ret

0000265a <elf_parse_global_symtab>:

enum elferr elf_parse_global_symtab(void* addr, size_t sz)
{
    265a:	55                   	push   ebp
    265b:	89 e5                	mov    ebp,esp
    265d:	53                   	push   ebx
    265e:	83 ec 24             	sub    esp,0x24
		const char* str = (const char*)addr; size_t cap = 64;
    2661:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2664:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    2667:	c7 45 f4 40 00 00 00 	mov    DWORD PTR [ebp-0xc],0x40
		struct symbol_list* sl;
		if (gs_lst)
    266e:	a1 00 00 00 00       	mov    eax,ds:0x0
    2673:	85 c0                	test   eax,eax
    2675:	74 0a                	je     2681 <elf_parse_global_symtab+0x27>
				return ELF_GSTAB_ALREADY_PRESENT;
    2677:	b8 0f 00 00 00       	mov    eax,0xf
    267c:	e9 80 02 00 00       	jmp    2901 <elf_parse_global_symtab+0x2a7>

		/* allocate the initial capacity */
		sl = gs_lst = kmalloc(sizeof(struct symbol_list));
    2681:	83 ec 0c             	sub    esp,0xc
    2684:	68 04 03 00 00       	push   0x304
    2689:	e8 fc ff ff ff       	call   268a <elf_parse_global_symtab+0x30>
    268e:	83 c4 10             	add    esp,0x10
    2691:	a3 00 00 00 00       	mov    ds:0x0,eax
    2696:	a1 00 00 00 00       	mov    eax,ds:0x0
    269b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!sl)
    269e:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    26a2:	75 0a                	jne    26ae <elf_parse_global_symtab+0x54>
				return ELF_NOMEM;
    26a4:	b8 04 00 00 00       	mov    eax,0x4
    26a9:	e9 53 02 00 00       	jmp    2901 <elf_parse_global_symtab+0x2a7>
		sl->next = NULL;
    26ae:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    26b1:	c7 80 00 03 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x300],0x0

		while ((size_t)((void*)str - addr) < sz) {
    26bb:	e9 e8 01 00 00       	jmp    28a8 <elf_parse_global_symtab+0x24e>
				const char* s1 = str; char *s2; char tp = ' ';
    26c0:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    26c3:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    26c6:	c6 45 eb 20          	mov    BYTE PTR [ebp-0x15],0x20
				long val = strtol(str, (char**)&str, 16);
    26ca:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    26cd:	83 ec 04             	sub    esp,0x4
    26d0:	6a 10                	push   0x10
    26d2:	8d 55 dc             	lea    edx,[ebp-0x24]
    26d5:	52                   	push   edx
    26d6:	50                   	push   eax
    26d7:	e8 fc ff ff ff       	call   26d8 <elf_parse_global_symtab+0x7e>
    26dc:	83 c4 10             	add    esp,0x10
    26df:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				
				if (s1 == str)
    26e2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    26e5:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
    26e8:	75 0a                	jne    26f4 <elf_parse_global_symtab+0x9a>
						return ELF_STRING_PARSE_NUMBER;
    26ea:	b8 10 00 00 00       	mov    eax,0x10
    26ef:	e9 0d 02 00 00       	jmp    2901 <elf_parse_global_symtab+0x2a7>
				if (*str++ != ' ')
    26f4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    26f7:	8d 50 01             	lea    edx,[eax+0x1]
    26fa:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    26fd:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2700:	3c 20                	cmp    al,0x20
    2702:	74 0a                	je     270e <elf_parse_global_symtab+0xb4>
						return ELF_PARSE_FORMAT_NOT_NM;
    2704:	b8 11 00 00 00       	mov    eax,0x11
    2709:	e9 f3 01 00 00       	jmp    2901 <elf_parse_global_symtab+0x2a7>
				tp = *str++;
    270e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2711:	8d 50 01             	lea    edx,[eax+0x1]
    2714:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    2717:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    271a:	88 45 eb             	mov    BYTE PTR [ebp-0x15],al
				if (*str++ != ' ')
    271d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2720:	8d 50 01             	lea    edx,[eax+0x1]
    2723:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    2726:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2729:	3c 20                	cmp    al,0x20
    272b:	74 0a                	je     2737 <elf_parse_global_symtab+0xdd>
						return ELF_PARSE_FORMAT_NOT_NM;
    272d:	b8 11 00 00 00       	mov    eax,0x11
    2732:	e9 ca 01 00 00       	jmp    2901 <elf_parse_global_symtab+0x2a7>
				s1 = strchr(str, '\n');
    2737:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    273a:	83 ec 08             	sub    esp,0x8
    273d:	6a 0a                	push   0xa
    273f:	50                   	push   eax
    2740:	e8 fc ff ff ff       	call   2741 <elf_parse_global_symtab+0xe7>
    2745:	83 c4 10             	add    esp,0x10
    2748:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!s1) {
    274b:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    274f:	75 1b                	jne    276c <elf_parse_global_symtab+0x112>
						printf("strchr!\n");
    2751:	83 ec 0c             	sub    esp,0xc
    2754:	68 2c 0b 00 00       	push   0xb2c
    2759:	e8 fc ff ff ff       	call   275a <elf_parse_global_symtab+0x100>
    275e:	83 c4 10             	add    esp,0x10
						s1 = (const char*)(addr + sz);
    2761:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    2764:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2767:	01 d0                	add    eax,edx
    2769:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				}
				s2 = strndup(str, s1 - str);
    276c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    276f:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    2772:	29 c2                	sub    edx,eax
    2774:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2777:	83 ec 08             	sub    esp,0x8
    277a:	52                   	push   edx
    277b:	50                   	push   eax
    277c:	e8 fc ff ff ff       	call   277d <elf_parse_global_symtab+0x123>
    2781:	83 c4 10             	add    esp,0x10
    2784:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax

				/*printf("symbol at %p: \"%s\" type %c\n", (void*)val, s2, tp);------------------*/
				if (strcmp(s2, "printf") == 0)
    2787:	83 ec 08             	sub    esp,0x8
    278a:	68 35 0b 00 00       	push   0xb35
    278f:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    2792:	e8 fc ff ff ff       	call   2793 <elf_parse_global_symtab+0x139>
    2797:	83 c4 10             	add    esp,0x10
    279a:	85 c0                	test   eax,eax
    279c:	75 45                	jne    27e3 <elf_parse_global_symtab+0x189>
						if (&printf != (void*)val) {
    279e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    27a1:	3d 00 00 00 00       	cmp    eax,0x0
    27a6:	74 3b                	je     27e3 <elf_parse_global_symtab+0x189>
								cprintf(KFMT_WARN, "WARNING! Loaded outdated symtab!\n");
    27a8:	83 ec 08             	sub    esp,0x8
    27ab:	68 3c 0b 00 00       	push   0xb3c
    27b0:	6a 0e                	push   0xe
    27b2:	e8 fc ff ff ff       	call   27b3 <elf_parse_global_symtab+0x159>
    27b7:	83 c4 10             	add    esp,0x10
								printf("printf is located at %p but symtab says it's at %p\n",
    27ba:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    27bd:	83 ec 04             	sub    esp,0x4
    27c0:	50                   	push   eax
    27c1:	68 00 00 00 00       	push   0x0
    27c6:	68 60 0b 00 00       	push   0xb60
    27cb:	e8 fc ff ff ff       	call   27cc <elf_parse_global_symtab+0x172>
    27d0:	83 c4 10             	add    esp,0x10
												&printf, (void*)val);
								printf("expect modules to fail randomly as the\n"
    27d3:	83 ec 0c             	sub    esp,0xc
    27d6:	68 94 0b 00 00       	push   0xb94
    27db:	e8 fc ff ff ff       	call   27dc <elf_parse_global_symtab+0x182>
    27e0:	83 c4 10             	add    esp,0x10
									   "symbols used therein will not be resolved correctly\n");
						}

				/* expand the capacity if needed */
				if (!cap) {
    27e3:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    27e7:	75 54                	jne    283d <elf_parse_global_symtab+0x1e3>
						sl->next = kmalloc(sizeof(struct symbol_list));
    27e9:	83 ec 0c             	sub    esp,0xc
    27ec:	68 04 03 00 00       	push   0x304
    27f1:	e8 fc ff ff ff       	call   27f2 <elf_parse_global_symtab+0x198>
    27f6:	83 c4 10             	add    esp,0x10
    27f9:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    27fc:	89 82 00 03 00 00    	mov    DWORD PTR [edx+0x300],eax
						if (!sl) {
    2802:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2806:	75 15                	jne    281d <elf_parse_global_symtab+0x1c3>
								cprintf(KFMT_ERROR, "Out of memory for parsing global symbol table\n");
    2808:	83 ec 08             	sub    esp,0x8
    280b:	68 f0 0b 00 00       	push   0xbf0
    2810:	6a 0c                	push   0xc
    2812:	e8 fc ff ff ff       	call   2813 <elf_parse_global_symtab+0x1b9>
    2817:	83 c4 10             	add    esp,0x10
								while (1);
    281a:	90                   	nop
    281b:	eb fd                	jmp    281a <elf_parse_global_symtab+0x1c0>
						}
						sl = sl->next;
    281d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2820:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
    2826:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						sl->next = NULL;
    2829:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    282c:	c7 80 00 03 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x300],0x0
						cap = 64;
    2836:	c7 45 f4 40 00 00 00 	mov    DWORD PTR [ebp-0xc],0x40
				}

				/* store the two values */
				sl->entries[64 - cap].name = s2;
    283d:	b8 40 00 00 00       	mov    eax,0x40
    2842:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    2845:	89 c2                	mov    edx,eax
    2847:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    284a:	89 d0                	mov    eax,edx
    284c:	01 c0                	add    eax,eax
    284e:	01 d0                	add    eax,edx
    2850:	c1 e0 02             	shl    eax,0x2
    2853:	01 c8                	add    eax,ecx
    2855:	8d 50 04             	lea    edx,[eax+0x4]
    2858:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    285b:	89 02                	mov    DWORD PTR [edx],eax
				sl->entries[64 - cap].vma = (void*)val;
    285d:	b8 40 00 00 00       	mov    eax,0x40
    2862:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    2865:	89 c2                	mov    edx,eax
    2867:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    286a:	8b 5d f0             	mov    ebx,DWORD PTR [ebp-0x10]
    286d:	89 d0                	mov    eax,edx
    286f:	01 c0                	add    eax,eax
    2871:	01 d0                	add    eax,edx
    2873:	c1 e0 02             	shl    eax,0x2
    2876:	01 d8                	add    eax,ebx
    2878:	89 08                	mov    DWORD PTR [eax],ecx
				sl->entries[64 - cap].type = tp;
    287a:	b8 40 00 00 00       	mov    eax,0x40
    287f:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    2882:	89 c2                	mov    edx,eax
    2884:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    2887:	89 d0                	mov    eax,edx
    2889:	01 c0                	add    eax,eax
    288b:	01 d0                	add    eax,edx
    288d:	c1 e0 02             	shl    eax,0x2
    2890:	01 c8                	add    eax,ecx
    2892:	8d 50 08             	lea    edx,[eax+0x8]
    2895:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    2899:	88 02                	mov    BYTE PTR [edx],al
				cap--;
    289b:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
				/* and advance */
				str = s1 + 1;
    289f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    28a2:	83 c0 01             	add    eax,0x1
    28a5:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		while ((size_t)((void*)str - addr) < sz) {
    28a8:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    28ab:	2b 45 08             	sub    eax,DWORD PTR [ebp+0x8]
    28ae:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    28b1:	0f 82 09 fe ff ff    	jb     26c0 <elf_parse_global_symtab+0x66>
		}

		/* zero-terminate not fully used lists */
		if (cap) {
    28b7:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    28bb:	74 3f                	je     28fc <elf_parse_global_symtab+0x2a2>
				sl->entries[64 - cap].name = NULL;
    28bd:	b8 40 00 00 00       	mov    eax,0x40
    28c2:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    28c5:	89 c2                	mov    edx,eax
    28c7:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    28ca:	89 d0                	mov    eax,edx
    28cc:	01 c0                	add    eax,eax
    28ce:	01 d0                	add    eax,edx
    28d0:	c1 e0 02             	shl    eax,0x2
    28d3:	01 c8                	add    eax,ecx
    28d5:	83 c0 04             	add    eax,0x4
    28d8:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				sl->entries[64 - cap].vma = NULL;
    28de:	b8 40 00 00 00       	mov    eax,0x40
    28e3:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    28e6:	89 c2                	mov    edx,eax
    28e8:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    28eb:	89 d0                	mov    eax,edx
    28ed:	01 c0                	add    eax,eax
    28ef:	01 d0                	add    eax,edx
    28f1:	c1 e0 02             	shl    eax,0x2
    28f4:	01 c8                	add    eax,ecx
    28f6:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		}
		return ELF_OK;
    28fc:	b8 00 00 00 00       	mov    eax,0x0
}
    2901:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2904:	c9                   	leave
    2905:	c3                   	ret

00002906 <load_modules>:

void load_modules()
{
    2906:	55                   	push   ebp
    2907:	89 e5                	mov    ebp,esp
    2909:	57                   	push   edi
    290a:	83 ec 64             	sub    esp,0x64
		void* mem = (void*)0x200000;
    290d:	c7 45 f4 00 00 20 00 	mov    DWORD PTR [ebp-0xc],0x200000
		uint32_t mct = *(uint32_t*)mem;
    2914:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2917:	8b 00                	mov    eax,DWORD PTR [eax]
    2919:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		enum elferr ee;
		mem += sizeof(uint32_t);
    291c:	83 45 f4 04          	add    DWORD PTR [ebp-0xc],0x4

		if (strcmp(mem, "LD.MAP") != 0) {
    2920:	83 ec 08             	sub    esp,0x8
    2923:	68 1f 0c 00 00       	push   0xc1f
    2928:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    292b:	e8 fc ff ff ff       	call   292c <load_modules+0x26>
    2930:	83 c4 10             	add    esp,0x10
    2933:	85 c0                	test   eax,eax
    2935:	74 15                	je     294c <load_modules+0x46>
				cprintf(KFMT_ERROR, "first file has to be global symbol map\n");
    2937:	83 ec 08             	sub    esp,0x8
    293a:	68 28 0c 00 00       	push   0xc28
    293f:	6a 0c                	push   0xc
    2941:	e8 fc ff ff ff       	call   2942 <load_modules+0x3c>
    2946:	83 c4 10             	add    esp,0x10
				while (1);
    2949:	90                   	nop
    294a:	eb fd                	jmp    2949 <load_modules+0x43>
		} else
				mem += 7;
    294c:	83 45 f4 07          	add    DWORD PTR [ebp-0xc],0x7
		/* parse the kernel symbol table supplied in nm format */
		if ((ee = elf_parse_global_symtab(mem + sizeof(uint32_t), *(uint32_t*)mem))) {
    2950:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2953:	8b 00                	mov    eax,DWORD PTR [eax]
    2955:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2958:	83 c2 04             	add    edx,0x4
    295b:	83 ec 08             	sub    esp,0x8
    295e:	50                   	push   eax
    295f:	52                   	push   edx
    2960:	e8 fc ff ff ff       	call   2961 <load_modules+0x5b>
    2965:	83 c4 10             	add    esp,0x10
    2968:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    296b:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    296f:	74 4e                	je     29bf <load_modules+0xb9>
				cprintf(KFMT_ERROR, "Failed to parse global kernel symbol table ("
    2971:	83 ec 08             	sub    esp,0x8
    2974:	68 50 0c 00 00       	push   0xc50
    2979:	6a 0c                	push   0xc
    297b:	e8 fc ff ff ff       	call   297c <load_modules+0x76>
    2980:	83 c4 10             	add    esp,0x10
					   "file ld.map in root directory)\n");
				cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
    2983:	83 ec 0c             	sub    esp,0xc
    2986:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    2989:	e8 fc ff ff ff       	call   298a <load_modules+0x84>
    298e:	83 c4 10             	add    esp,0x10
    2991:	83 ec 04             	sub    esp,0x4
    2994:	50                   	push   eax
    2995:	68 9c 0c 00 00       	push   0xc9c
    299a:	6a 0c                	push   0xc
    299c:	e8 fc ff ff ff       	call   299d <load_modules+0x97>
    29a1:	83 c4 10             	add    esp,0x10
				memdump(mem + sizeof(uint32_t), *(uint32_t*)mem);
    29a4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    29a7:	8b 00                	mov    eax,DWORD PTR [eax]
    29a9:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    29ac:	83 c2 04             	add    edx,0x4
    29af:	83 ec 08             	sub    esp,0x8
    29b2:	50                   	push   eax
    29b3:	52                   	push   edx
    29b4:	e8 fc ff ff ff       	call   29b5 <load_modules+0xaf>
    29b9:	83 c4 10             	add    esp,0x10
				while (1);
    29bc:	90                   	nop
    29bd:	eb fd                	jmp    29bc <load_modules+0xb6>
		}
		mem += sizeof(uint32_t) + *(uint32_t*)mem;
    29bf:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    29c2:	8b 00                	mov    eax,DWORD PTR [eax]
    29c4:	83 c0 04             	add    eax,0x4
    29c7:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		mct--;
    29ca:	83 6d f0 01          	sub    DWORD PTR [ebp-0x10],0x1

		/* try to load each module */
		while (mct--) {
    29ce:	e9 87 01 00 00       	jmp    2b5a <load_modules+0x254>
				const char* name = (const char*)mem;
    29d3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    29d6:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				uint32_t sz;
				struct module_info mi = {0};
    29d9:	8d 55 a4             	lea    edx,[ebp-0x5c]
    29dc:	b8 00 00 00 00       	mov    eax,0x0
    29e1:	b9 0f 00 00 00       	mov    ecx,0xf
    29e6:	89 d7                	mov    edi,edx
    29e8:	f3 ab                	rep stos DWORD PTR es:[edi],eax
				mem += strlen(name) + 1;
    29ea:	83 ec 0c             	sub    esp,0xc
    29ed:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    29f0:	e8 fc ff ff ff       	call   29f1 <load_modules+0xeb>
    29f5:	83 c4 10             	add    esp,0x10
    29f8:	83 c0 01             	add    eax,0x1
    29fb:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
				sz = *(uint32_t*)mem;
    29fe:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a01:	8b 00                	mov    eax,DWORD PTR [eax]
    2a03:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				mem += sizeof(uint32_t);
    2a06:	83 45 f4 04          	add    DWORD PTR [ebp-0xc],0x4
				strncpy(mi.mi_name, name, 20);
    2a0a:	83 ec 04             	sub    esp,0x4
    2a0d:	6a 14                	push   0x14
    2a0f:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    2a12:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2a15:	50                   	push   eax
    2a16:	e8 fc ff ff ff       	call   2a17 <load_modules+0x111>
    2a1b:	83 c4 10             	add    esp,0x10
				printf("loading module %.20s...\n", mi.mi_name);
    2a1e:	83 ec 08             	sub    esp,0x8
    2a21:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2a24:	50                   	push   eax
    2a25:	68 a8 0c 00 00       	push   0xca8
    2a2a:	e8 fc ff ff ff       	call   2a2b <load_modules+0x125>
    2a2f:	83 c4 10             	add    esp,0x10
				if ((ee = load_elf(mem, sz, &mi))) {
    2a32:	83 ec 04             	sub    esp,0x4
    2a35:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2a38:	50                   	push   eax
    2a39:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    2a3c:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2a3f:	e8 fc ff ff ff       	call   2a40 <load_modules+0x13a>
    2a44:	83 c4 10             	add    esp,0x10
    2a47:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2a4a:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2a4e:	74 39                	je     2a89 <load_modules+0x183>
						cprintf(KFMT_ERROR, "Failed to load ELF module at %p\n", mem);
    2a50:	83 ec 04             	sub    esp,0x4
    2a53:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2a56:	68 c4 0c 00 00       	push   0xcc4
    2a5b:	6a 0c                	push   0xc
    2a5d:	e8 fc ff ff ff       	call   2a5e <load_modules+0x158>
    2a62:	83 c4 10             	add    esp,0x10
						cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
    2a65:	83 ec 0c             	sub    esp,0xc
    2a68:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    2a6b:	e8 fc ff ff ff       	call   2a6c <load_modules+0x166>
    2a70:	83 c4 10             	add    esp,0x10
    2a73:	83 ec 04             	sub    esp,0x4
    2a76:	50                   	push   eax
    2a77:	68 9c 0c 00 00       	push   0xc9c
    2a7c:	6a 0c                	push   0xc
    2a7e:	e8 fc ff ff ff       	call   2a7f <load_modules+0x179>
    2a83:	83 c4 10             	add    esp,0x10
						while (1);
    2a86:	90                   	nop
    2a87:	eb fd                	jmp    2a86 <load_modules+0x180>
				} else {
						int errc;
						cprintf(KFMT_INFO, "loaded module at the following offsets and sizes:\n");
    2a89:	83 ec 08             	sub    esp,0x8
    2a8c:	68 e8 0c 00 00       	push   0xce8
    2a91:	6a 0b                	push   0xb
    2a93:	e8 fc ff ff ff       	call   2a94 <load_modules+0x18e>
    2a98:	83 c4 10             	add    esp,0x10
						cprintf(KFMT_INFO, ".text    %p %11lu\n", mi.vm_ofs[0], mi.sz_secs[0]);
    2a9b:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2a9e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    2aa1:	52                   	push   edx
    2aa2:	50                   	push   eax
    2aa3:	68 1b 0d 00 00       	push   0xd1b
    2aa8:	6a 0b                	push   0xb
    2aaa:	e8 fc ff ff ff       	call   2aab <load_modules+0x1a5>
    2aaf:	83 c4 10             	add    esp,0x10
						cprintf(KFMT_INFO, ".data    %p %11lu\n", mi.vm_ofs[1], mi.sz_secs[1]);
    2ab2:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2ab5:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2ab8:	52                   	push   edx
    2ab9:	50                   	push   eax
    2aba:	68 2e 0d 00 00       	push   0xd2e
    2abf:	6a 0b                	push   0xb
    2ac1:	e8 fc ff ff ff       	call   2ac2 <load_modules+0x1bc>
    2ac6:	83 c4 10             	add    esp,0x10
						cprintf(KFMT_INFO, ".rodata  %p %11lu\n", mi.vm_ofs[2], mi.sz_secs[2]);
    2ac9:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2acc:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2acf:	52                   	push   edx
    2ad0:	50                   	push   eax
    2ad1:	68 41 0d 00 00       	push   0xd41
    2ad6:	6a 0b                	push   0xb
    2ad8:	e8 fc ff ff ff       	call   2ad9 <load_modules+0x1d3>
    2add:	83 c4 10             	add    esp,0x10
						cprintf(KFMT_INFO, ".bss     %p %11lu\n", mi.vm_ofs[3], mi.sz_secs[3]);
    2ae0:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2ae3:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2ae6:	52                   	push   edx
    2ae7:	50                   	push   eax
    2ae8:	68 54 0d 00 00       	push   0xd54
    2aed:	6a 0b                	push   0xb
    2aef:	e8 fc ff ff ff       	call   2af0 <load_modules+0x1ea>
    2af4:	83 c4 10             	add    esp,0x10
						cprintf(KFMT_INFO, "calling module_init()...\n");
    2af7:	83 ec 08             	sub    esp,0x8
    2afa:	68 67 0d 00 00       	push   0xd67
    2aff:	6a 0b                	push   0xb
    2b01:	e8 fc ff ff ff       	call   2b02 <load_modules+0x1fc>
    2b06:	83 c4 10             	add    esp,0x10
						errc = mi.mi_init();
    2b09:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    2b0c:	ff d0                	call   eax
    2b0e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						if (errc) {
    2b11:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    2b15:	74 18                	je     2b2f <load_modules+0x229>
								cprintf(KFMT_ERROR, "init failed with error %d\n", errc);
    2b17:	83 ec 04             	sub    esp,0x4
    2b1a:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    2b1d:	68 81 0d 00 00       	push   0xd81
    2b22:	6a 0c                	push   0xc
    2b24:	e8 fc ff ff ff       	call   2b25 <load_modules+0x21f>
    2b29:	83 c4 10             	add    esp,0x10
								while (1);
    2b2c:	90                   	nop
    2b2d:	eb fd                	jmp    2b2c <load_modules+0x226>
						} else {
								cprintf(KFMT_OK, "successfully initialized module \"%s\"\n", mi.mi_name);
    2b2f:	83 ec 04             	sub    esp,0x4
    2b32:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2b35:	50                   	push   eax
    2b36:	68 9c 0d 00 00       	push   0xd9c
    2b3b:	6a 0a                	push   0xa
    2b3d:	e8 fc ff ff ff       	call   2b3e <load_modules+0x238>
    2b42:	83 c4 10             	add    esp,0x10
								store_module_info(&mi);
    2b45:	83 ec 0c             	sub    esp,0xc
    2b48:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2b4b:	50                   	push   eax
    2b4c:	e8 fc ff ff ff       	call   2b4d <load_modules+0x247>
    2b51:	83 c4 10             	add    esp,0x10
						}
				}

				mem += sz;
    2b54:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2b57:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		while (mct--) {
    2b5a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2b5d:	8d 50 ff             	lea    edx,[eax-0x1]
    2b60:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    2b63:	85 c0                	test   eax,eax
    2b65:	0f 85 68 fe ff ff    	jne    29d3 <load_modules+0xcd>
		}

		printf("done loading kernel modules\n");
    2b6b:	83 ec 0c             	sub    esp,0xc
    2b6e:	68 c2 0d 00 00       	push   0xdc2
    2b73:	e8 fc ff ff ff       	call   2b74 <load_modules+0x26e>
    2b78:	83 c4 10             	add    esp,0x10
}
    2b7b:	90                   	nop
    2b7c:	8b 7d fc             	mov    edi,DWORD PTR [ebp-0x4]
    2b7f:	c9                   	leave
    2b80:	c3                   	ret
