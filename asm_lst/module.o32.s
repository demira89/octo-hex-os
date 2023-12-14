
module.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
const char* get_section_type_string(Elf32_Word tp)
{
		if (tp == SHT_PROGBITS)
				return "PROGBITS";
		else if (tp == SHT_SYMTAB)
				return "SYMTAB";
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
		else if (tp == SHT_DYNSYM)
       6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				return "DYNSYM";
       c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
       f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		else if (tp == SHT_STRTAB)
      12:	eb 17                	jmp    2b <memcpy+0x2b>
				return "STRTAB";
      14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      17:	8d 42 01             	lea    eax,[edx+0x1]
      1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      20:	8d 48 01             	lea    ecx,[eax+0x1]
      23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      29:	88 10                	mov    BYTE PTR [eax],dl
		else if (tp == SHT_STRTAB)
      2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      2e:	8d 50 ff             	lea    edx,[eax-0x1]
      31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      34:	85 c0                	test   eax,eax
      36:	75 dc                	jne    14 <memcpy+0x14>
		else if (tp == SHT_RELA)
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
      dc:	83 ec 54             	sub    esp,0x54
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
     146:	0f 86 94 02 00 00    	jbe    3e0 <elf_dump_symtab+0x308>
		printf("dumping symtab with %lu entries\n", ct);
     14c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     14f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     153:	c7 04 24 30 00 00 00 	mov    DWORD PTR [esp],0x30
     15a:	e8 fc ff ff ff       	call   15b <elf_dump_symtab+0x83>
		printf("   Num:    Value  Size Type    Bind   Section  Name\n");
     15f:	c7 04 24 54 00 00 00 	mov    DWORD PTR [esp],0x54
     166:	e8 fc ff ff ff       	call   167 <elf_dump_symtab+0x8f>
		for (i = 1; i < ct; i++) {
     16b:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
     172:	e9 5b 02 00 00       	jmp    3d2 <elf_dump_symtab+0x2fa>
				Elf32_Sym* s = (ptr + i * shdr[symtab].sh_entsize);
     177:	0f b7 55 d4          	movzx  edx,WORD PTR [ebp-0x2c]
     17b:	89 d0                	mov    eax,edx
     17d:	c1 e0 02             	shl    eax,0x2
     180:	01 d0                	add    eax,edx
     182:	c1 e0 03             	shl    eax,0x3
     185:	89 c2                	mov    edx,eax
     187:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     18a:	01 d0                	add    eax,edx
     18c:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     18f:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
     193:	89 c2                	mov    edx,eax
     195:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     198:	01 d0                	add    eax,edx
     19a:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				char *name = "STN_UNDEF", *sec, *stp, *stb;
     19d:	c7 45 f0 89 00 00 00 	mov    DWORD PTR [ebp-0x10],0x89
				if (s->st_name)
     1a4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     1a7:	8b 00                	mov    eax,DWORD PTR [eax]
     1a9:	85 c0                	test   eax,eax
     1ab:	74 3d                	je     1ea <elf_dump_symtab+0x112>
						name = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
     1ad:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     1b0:	8b 08                	mov    ecx,DWORD PTR [eax]
     1b2:	0f b7 55 d4          	movzx  edx,WORD PTR [ebp-0x2c]
     1b6:	89 d0                	mov    eax,edx
     1b8:	c1 e0 02             	shl    eax,0x2
     1bb:	01 d0                	add    eax,edx
     1bd:	c1 e0 03             	shl    eax,0x3
     1c0:	89 c2                	mov    edx,eax
     1c2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1c5:	01 d0                	add    eax,edx
     1c7:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
     1ca:	0f b7 c0             	movzx  eax,ax
     1cd:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     1d1:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     1d5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1d8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     1dc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1df:	89 04 24             	mov    DWORD PTR [esp],eax
     1e2:	e8 fc ff ff ff       	call   1e3 <elf_dump_symtab+0x10b>
     1e7:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (ELF32_ST_TYPE(s->st_info) == STT_NOTYPE)
     1ea:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     1ed:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     1f1:	0f b6 c0             	movzx  eax,al
     1f4:	83 e0 0f             	and    eax,0xf
     1f7:	85 c0                	test   eax,eax
     1f9:	75 0c                	jne    207 <elf_dump_symtab+0x12f>
						stp = "NOTYPE ";
     1fb:	c7 45 e8 93 00 00 00 	mov    DWORD PTR [ebp-0x18],0x93
     202:	e9 8e 00 00 00       	jmp    295 <elf_dump_symtab+0x1bd>
				else if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
     207:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     20a:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     20e:	0f b6 c0             	movzx  eax,al
     211:	83 e0 0f             	and    eax,0xf
     214:	83 f8 01             	cmp    eax,0x1
     217:	75 09                	jne    222 <elf_dump_symtab+0x14a>
						stp = "OBJECT ";
     219:	c7 45 e8 9b 00 00 00 	mov    DWORD PTR [ebp-0x18],0x9b
     220:	eb 73                	jmp    295 <elf_dump_symtab+0x1bd>
				else if (ELF32_ST_TYPE(s->st_info) == STT_FUNC)
     222:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     225:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     229:	0f b6 c0             	movzx  eax,al
     22c:	83 e0 0f             	and    eax,0xf
     22f:	83 f8 02             	cmp    eax,0x2
     232:	75 09                	jne    23d <elf_dump_symtab+0x165>
						stp = "FUNC   ";
     234:	c7 45 e8 a3 00 00 00 	mov    DWORD PTR [ebp-0x18],0xa3
     23b:	eb 58                	jmp    295 <elf_dump_symtab+0x1bd>
				else if (ELF32_ST_TYPE(s->st_info) == STT_SECTION)
     23d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     240:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     244:	0f b6 c0             	movzx  eax,al
     247:	83 e0 0f             	and    eax,0xf
     24a:	83 f8 03             	cmp    eax,0x3
     24d:	75 09                	jne    258 <elf_dump_symtab+0x180>
						stp = "SECTION";
     24f:	c7 45 e8 ab 00 00 00 	mov    DWORD PTR [ebp-0x18],0xab
     256:	eb 3d                	jmp    295 <elf_dump_symtab+0x1bd>
				else if (ELF32_ST_TYPE(s->st_info) == STT_FILE)
     258:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     25b:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     25f:	0f b6 c0             	movzx  eax,al
     262:	83 e0 0f             	and    eax,0xf
     265:	83 f8 04             	cmp    eax,0x4
     268:	75 09                	jne    273 <elf_dump_symtab+0x19b>
						stp = "FILE   ";
     26a:	c7 45 e8 b3 00 00 00 	mov    DWORD PTR [ebp-0x18],0xb3
     271:	eb 22                	jmp    295 <elf_dump_symtab+0x1bd>
				else if (ELF32_ST_TYPE(s->st_info) >= 13/*STT_LOPROC*/ &&
     273:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     276:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     27a:	0f b6 c0             	movzx  eax,al
     27d:	83 e0 0f             	and    eax,0xf
     280:	83 f8 0c             	cmp    eax,0xc
     283:	76 09                	jbe    28e <elf_dump_symtab+0x1b6>
						stp = "PROC   ";
     285:	c7 45 e8 bb 00 00 00 	mov    DWORD PTR [ebp-0x18],0xbb
     28c:	eb 07                	jmp    295 <elf_dump_symtab+0x1bd>
						stp = "UNKNOWN";
     28e:	c7 45 e8 c3 00 00 00 	mov    DWORD PTR [ebp-0x18],0xc3
				if (ELF32_ST_BIND(s->st_info) == STB_LOCAL)
     295:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     298:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     29c:	c0 e8 04             	shr    al,0x4
     29f:	84 c0                	test   al,al
     2a1:	75 09                	jne    2ac <elf_dump_symtab+0x1d4>
						stb = "LOCAL ";
     2a3:	c7 45 e4 cb 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xcb
     2aa:	eb 5a                	jmp    306 <elf_dump_symtab+0x22e>
				else if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL)
     2ac:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     2af:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     2b3:	c0 e8 04             	shr    al,0x4
     2b6:	3c 01                	cmp    al,0x1
     2b8:	75 09                	jne    2c3 <elf_dump_symtab+0x1eb>
						stb = "GLOBAL";
     2ba:	c7 45 e4 d2 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xd2
     2c1:	eb 43                	jmp    306 <elf_dump_symtab+0x22e>
				else if (ELF32_ST_BIND(s->st_info) == STB_WEAK)
     2c3:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     2c6:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     2ca:	c0 e8 04             	shr    al,0x4
     2cd:	3c 02                	cmp    al,0x2
     2cf:	75 09                	jne    2da <elf_dump_symtab+0x202>
						stb = "WEAK  ";
     2d1:	c7 45 e4 d9 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xd9
     2d8:	eb 2c                	jmp    306 <elf_dump_symtab+0x22e>
				else if (ELF32_ST_BIND(s->st_info) >= 13 &&
     2da:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     2dd:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     2e1:	c0 e8 04             	shr    al,0x4
     2e4:	3c 0c                	cmp    al,0xc
     2e6:	76 17                	jbe    2ff <elf_dump_symtab+0x227>
						ELF32_ST_BIND(s->st_info) <= 15)
     2e8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     2eb:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     2ef:	c0 e8 04             	shr    al,0x4
				else if (ELF32_ST_BIND(s->st_info) >= 13 &&
     2f2:	3c 0f                	cmp    al,0xf
     2f4:	77 09                	ja     2ff <elf_dump_symtab+0x227>
						stb = "PROC  ";
     2f6:	c7 45 e4 e0 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xe0
     2fd:	eb 07                	jmp    306 <elf_dump_symtab+0x22e>
						stb = "UNK   ";
     2ff:	c7 45 e4 e7 00 00 00 	mov    DWORD PTR [ebp-0x1c],0xe7
				if (s->st_shndx == SHN_ABS)
     306:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     309:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     30d:	66 83 f8 f1          	cmp    ax,0xfff1
     311:	75 09                	jne    31c <elf_dump_symtab+0x244>
						sec = "ABS     ";
     313:	c7 45 ec ee 00 00 00 	mov    DWORD PTR [ebp-0x14],0xee
     31a:	eb 6f                	jmp    38b <elf_dump_symtab+0x2b3>
				else if (s->st_shndx == SHN_COMMON)
     31c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     31f:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     323:	66 83 f8 f2          	cmp    ax,0xfff2
     327:	75 09                	jne    332 <elf_dump_symtab+0x25a>
						sec = "COMMON  ";
     329:	c7 45 ec f7 00 00 00 	mov    DWORD PTR [ebp-0x14],0xf7
     330:	eb 59                	jmp    38b <elf_dump_symtab+0x2b3>
				else if (s->st_shndx == SHN_UNDEF)
     332:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     335:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     339:	66 85 c0             	test   ax,ax
     33c:	75 09                	jne    347 <elf_dump_symtab+0x26f>
						sec = "UNDEF   ";
     33e:	c7 45 ec 00 01 00 00 	mov    DWORD PTR [ebp-0x14],0x100
     345:	eb 44                	jmp    38b <elf_dump_symtab+0x2b3>
						sec = elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name);
     347:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     34a:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     34e:	0f b7 d0             	movzx  edx,ax
     351:	89 d0                	mov    eax,edx
     353:	c1 e0 02             	shl    eax,0x2
     356:	01 d0                	add    eax,edx
     358:	c1 e0 03             	shl    eax,0x3
     35b:	89 c2                	mov    edx,eax
     35d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     360:	01 d0                	add    eax,edx
     362:	8b 10                	mov    edx,DWORD PTR [eax]
     364:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     367:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     36b:	0f b7 c0             	movzx  eax,ax
     36e:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     372:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     376:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     379:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     37d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     380:	89 04 24             	mov    DWORD PTR [esp],eax
     383:	e8 fc ff ff ff       	call   384 <elf_dump_symtab+0x2ac>
     388:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				printf("%6lu: %08u %5u %s %s %8.8s %.13s\n", i, s->st_value, s->st_size,
     38b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     38e:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     391:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     394:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     397:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     39a:	89 4c 24 1c          	mov    DWORD PTR [esp+0x1c],ecx
     39e:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     3a1:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
     3a5:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     3a8:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     3ac:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     3af:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
     3b3:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     3b7:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     3bb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3be:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     3c2:	c7 04 24 0c 01 00 00 	mov    DWORD PTR [esp],0x10c
     3c9:	e8 fc ff ff ff       	call   3ca <elf_dump_symtab+0x2f2>
		for (i = 1; i < ct; i++) {
     3ce:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     3d2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3d5:	3b 45 dc             	cmp    eax,DWORD PTR [ebp-0x24]
     3d8:	0f 82 99 fd ff ff    	jb     177 <elf_dump_symtab+0x9f>
     3de:	eb 01                	jmp    3e1 <elf_dump_symtab+0x309>
				return;
     3e0:	90                   	nop
}
     3e1:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     3e4:	c9                   	leave
     3e5:	c3                   	ret

000003e6 <elf_rel_type_string>:
{
     3e6:	55                   	push   ebp
     3e7:	89 e5                	mov    ebp,esp
		switch (t) {
     3e9:	83 7d 08 0a          	cmp    DWORD PTR [ebp+0x8],0xa
     3ed:	77 5c                	ja     44b <elf_rel_type_string+0x65>
     3ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3f2:	c1 e0 02             	shl    eax,0x2
     3f5:	05 b8 01 00 00       	add    eax,0x1b8
     3fa:	8b 00                	mov    eax,DWORD PTR [eax]
     3fc:	ff e0                	jmp    eax
				return "R_386_NONE";
     3fe:	b8 2e 01 00 00       	mov    eax,0x12e
     403:	eb 4b                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_32";
     405:	b8 39 01 00 00       	mov    eax,0x139
     40a:	eb 44                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_PC32";
     40c:	b8 42 01 00 00       	mov    eax,0x142
     411:	eb 3d                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_GOT32";
     413:	b8 4d 01 00 00       	mov    eax,0x14d
     418:	eb 36                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_PLT32";
     41a:	b8 59 01 00 00       	mov    eax,0x159
     41f:	eb 2f                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_COPY";
     421:	b8 65 01 00 00       	mov    eax,0x165
     426:	eb 28                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_GLOB_DAT";
     428:	b8 70 01 00 00       	mov    eax,0x170
     42d:	eb 21                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_JMP_SLOT";
     42f:	b8 7f 01 00 00       	mov    eax,0x17f
     434:	eb 1a                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_RELATIVE";
     436:	b8 8e 01 00 00       	mov    eax,0x18e
     43b:	eb 13                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_GOTOFF";
     43d:	b8 9d 01 00 00       	mov    eax,0x19d
     442:	eb 0c                	jmp    450 <elf_rel_type_string+0x6a>
				return "R_386_GOTPC";
     444:	b8 aa 01 00 00       	mov    eax,0x1aa
     449:	eb 05                	jmp    450 <elf_rel_type_string+0x6a>
				return "UNKNOWN";
     44b:	b8 c3 00 00 00       	mov    eax,0xc3
}
     450:	5d                   	pop    ebp
     451:	c3                   	ret

00000452 <elf_dump_rel>:
{
     452:	55                   	push   ebp
     453:	89 e5                	mov    ebp,esp
     455:	56                   	push   esi
     456:	53                   	push   ebx
     457:	83 ec 70             	sub    esp,0x70
     45a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     45d:	66 89 45 b4          	mov    WORD PTR [ebp-0x4c],ax
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
     461:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     465:	89 d0                	mov    eax,edx
     467:	c1 e0 02             	shl    eax,0x2
     46a:	01 d0                	add    eax,edx
     46c:	c1 e0 03             	shl    eax,0x3
     46f:	89 c2                	mov    edx,eax
     471:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     474:	01 d0                	add    eax,edx
     476:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     479:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     47c:	01 d0                	add    eax,edx
     47e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
     481:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     485:	89 d0                	mov    eax,edx
     487:	c1 e0 02             	shl    eax,0x2
     48a:	01 d0                	add    eax,edx
     48c:	c1 e0 03             	shl    eax,0x3
     48f:	89 c2                	mov    edx,eax
     491:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     494:	01 d0                	add    eax,edx
     496:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     499:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     49d:	89 d0                	mov    eax,edx
     49f:	c1 e0 02             	shl    eax,0x2
     4a2:	01 d0                	add    eax,edx
     4a4:	c1 e0 03             	shl    eax,0x3
     4a7:	89 c2                	mov    edx,eax
     4a9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     4ac:	01 d0                	add    eax,edx
     4ae:	8b 58 24             	mov    ebx,DWORD PTR [eax+0x24]
     4b1:	89 c8                	mov    eax,ecx
     4b3:	ba 00 00 00 00       	mov    edx,0x0
     4b8:	f7 f3                	div    ebx
     4ba:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!ct)
     4bd:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
     4c1:	0f 84 72 03 00 00    	je     839 <elf_dump_rel+0x3e7>
		sptr = (void*)hdr + shdr[shdr[rel].sh_info].sh_offset;
     4c7:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     4cb:	89 d0                	mov    eax,edx
     4cd:	c1 e0 02             	shl    eax,0x2
     4d0:	01 d0                	add    eax,edx
     4d2:	c1 e0 03             	shl    eax,0x3
     4d5:	89 c2                	mov    edx,eax
     4d7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     4da:	01 d0                	add    eax,edx
     4dc:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     4df:	89 d0                	mov    eax,edx
     4e1:	c1 e0 02             	shl    eax,0x2
     4e4:	01 d0                	add    eax,edx
     4e6:	c1 e0 03             	shl    eax,0x3
     4e9:	89 c2                	mov    edx,eax
     4eb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     4ee:	01 d0                	add    eax,edx
     4f0:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     4f3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4f6:	01 d0                	add    eax,edx
     4f8:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
     4fb:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     4ff:	89 d0                	mov    eax,edx
     501:	c1 e0 02             	shl    eax,0x2
     504:	01 d0                	add    eax,edx
     506:	c1 e0 03             	shl    eax,0x3
     509:	89 c2                	mov    edx,eax
     50b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     50e:	01 d0                	add    eax,edx
     510:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     513:	89 d0                	mov    eax,edx
     515:	c1 e0 02             	shl    eax,0x2
     518:	01 d0                	add    eax,edx
     51a:	c1 e0 03             	shl    eax,0x3
     51d:	89 c2                	mov    edx,eax
     51f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     522:	01 d0                	add    eax,edx
     524:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     527:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     52a:	01 d0                	add    eax,edx
     52c:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		stb = shdr + shdr[rel].sh_link;
     52f:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     533:	89 d0                	mov    eax,edx
     535:	c1 e0 02             	shl    eax,0x2
     538:	01 d0                	add    eax,edx
     53a:	c1 e0 03             	shl    eax,0x3
     53d:	89 c2                	mov    edx,eax
     53f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     542:	01 d0                	add    eax,edx
     544:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     547:	89 d0                	mov    eax,edx
     549:	c1 e0 02             	shl    eax,0x2
     54c:	01 d0                	add    eax,edx
     54e:	c1 e0 03             	shl    eax,0x3
     551:	89 c2                	mov    edx,eax
     553:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     556:	01 d0                	add    eax,edx
     558:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		printf("dumping relocations with %lu entries\n", ct);
     55b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     55e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     562:	c7 04 24 e4 01 00 00 	mov    DWORD PTR [esp],0x1e4
     569:	e8 fc ff ff ff       	call   56a <elf_dump_rel+0x118>
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     56e:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     572:	89 d0                	mov    eax,edx
     574:	c1 e0 02             	shl    eax,0x2
     577:	01 d0                	add    eax,edx
     579:	c1 e0 03             	shl    eax,0x3
     57c:	89 c2                	mov    edx,eax
     57e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     581:	01 d0                	add    eax,edx
     583:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     586:	89 d0                	mov    eax,edx
     588:	c1 e0 02             	shl    eax,0x2
     58b:	01 d0                	add    eax,edx
     58d:	c1 e0 03             	shl    eax,0x3
     590:	89 c2                	mov    edx,eax
     592:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     595:	01 d0                	add    eax,edx
		printf("relocations apply to section %s\n", elf_fetch_string(hdr,
     597:	8b 10                	mov    edx,DWORD PTR [eax]
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     599:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     59c:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
		printf("relocations apply to section %s\n", elf_fetch_string(hdr,
     5a0:	0f b7 c0             	movzx  eax,ax
     5a3:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     5a7:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     5ab:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5ae:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     5b2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5b5:	89 04 24             	mov    DWORD PTR [esp],eax
     5b8:	e8 fc ff ff ff       	call   5b9 <elf_dump_rel+0x167>
     5bd:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     5c1:	c7 04 24 0c 02 00 00 	mov    DWORD PTR [esp],0x20c
     5c8:	e8 fc ff ff ff       	call   5c9 <elf_dump_rel+0x177>
		printf("   Num:   Offset Type              Field SyNdx SymbolName\n");
     5cd:	c7 04 24 30 02 00 00 	mov    DWORD PTR [esp],0x230
     5d4:	e8 fc ff ff ff       	call   5d5 <elf_dump_rel+0x183>
		for (i = 0; i < ct; i++) {
     5d9:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     5e0:	e9 46 02 00 00       	jmp    82b <elf_dump_rel+0x3d9>
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
     5e5:	0f b7 55 b4          	movzx  edx,WORD PTR [ebp-0x4c]
     5e9:	89 d0                	mov    eax,edx
     5eb:	c1 e0 02             	shl    eax,0x2
     5ee:	01 d0                	add    eax,edx
     5f0:	c1 e0 03             	shl    eax,0x3
     5f3:	89 c2                	mov    edx,eax
     5f5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5f8:	01 d0                	add    eax,edx
     5fa:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     5fd:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
     601:	89 c2                	mov    edx,eax
     603:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     606:	01 d0                	add    eax,edx
     608:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
     60b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     60e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     611:	c1 e8 08             	shr    eax,0x8
     614:	89 c2                	mov    edx,eax
     616:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     619:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     61c:	0f af d0             	imul   edx,eax
     61f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     622:	01 d0                	add    eax,edx
     624:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				const char* sn; char dat[] = "DAT: ........";
     627:	c7 45 ba 44 41 54 3a 	mov    DWORD PTR [ebp-0x46],0x3a544144
     62e:	c7 45 be 20 2e 2e 2e 	mov    DWORD PTR [ebp-0x42],0x2e2e2e20
     635:	c7 45 c2 2e 2e 2e 2e 	mov    DWORD PTR [ebp-0x3e],0x2e2e2e2e
     63c:	66 c7 45 c6 2e 00    	mov    WORD PTR [ebp-0x3a],0x2e
				if (s->st_name)
     642:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     645:	8b 00                	mov    eax,DWORD PTR [eax]
     647:	85 c0                	test   eax,eax
     649:	74 30                	je     67b <elf_dump_rel+0x229>
						sn = elf_fetch_string(hdr, shdr, stb->sh_link, s->st_name);
     64b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     64e:	8b 10                	mov    edx,DWORD PTR [eax]
     650:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     653:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
     656:	0f b7 c0             	movzx  eax,ax
     659:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     65d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     661:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     664:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     668:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     66b:	89 04 24             	mov    DWORD PTR [esp],eax
     66e:	e8 fc ff ff ff       	call   66f <elf_dump_rel+0x21d>
     673:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
     676:	e9 55 01 00 00       	jmp    7d0 <elf_dump_rel+0x37e>
				else if ((shdr[s->st_shndx].sh_flags & SHF_WRITE) == 0
     67b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     67e:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     682:	0f b7 d0             	movzx  edx,ax
     685:	89 d0                	mov    eax,edx
     687:	c1 e0 02             	shl    eax,0x2
     68a:	01 d0                	add    eax,edx
     68c:	c1 e0 03             	shl    eax,0x3
     68f:	89 c2                	mov    edx,eax
     691:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     694:	01 d0                	add    eax,edx
     696:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     699:	83 e0 01             	and    eax,0x1
     69c:	85 c0                	test   eax,eax
     69e:	0f 85 e8 00 00 00    	jne    78c <elf_dump_rel+0x33a>
						&& shdr[s->st_shndx].sh_flags & SHF_ALLOC
     6a4:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     6a7:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     6ab:	0f b7 d0             	movzx  edx,ax
     6ae:	89 d0                	mov    eax,edx
     6b0:	c1 e0 02             	shl    eax,0x2
     6b3:	01 d0                	add    eax,edx
     6b5:	c1 e0 03             	shl    eax,0x3
     6b8:	89 c2                	mov    edx,eax
     6ba:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6bd:	01 d0                	add    eax,edx
     6bf:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     6c2:	83 e0 02             	and    eax,0x2
     6c5:	85 c0                	test   eax,eax
     6c7:	0f 84 bf 00 00 00    	je     78c <elf_dump_rel+0x33a>
						&& (shdr[s->st_shndx].sh_flags & SHF_EXECINSTR) == 0) {
     6cd:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     6d0:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     6d4:	0f b7 d0             	movzx  edx,ax
     6d7:	89 d0                	mov    eax,edx
     6d9:	c1 e0 02             	shl    eax,0x2
     6dc:	01 d0                	add    eax,edx
     6de:	c1 e0 03             	shl    eax,0x3
     6e1:	89 c2                	mov    edx,eax
     6e3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6e6:	01 d0                	add    eax,edx
     6e8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     6eb:	83 e0 04             	and    eax,0x4
     6ee:	85 c0                	test   eax,eax
     6f0:	0f 85 96 00 00 00    	jne    78c <elf_dump_rel+0x33a>
						const char* c = (void*)hdr + shdr[s->st_shndx].sh_offset;
     6f6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     6f9:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     6fd:	0f b7 d0             	movzx  edx,ax
     700:	89 d0                	mov    eax,edx
     702:	c1 e0 02             	shl    eax,0x2
     705:	01 d0                	add    eax,edx
     707:	c1 e0 03             	shl    eax,0x3
     70a:	89 c2                	mov    edx,eax
     70c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     70f:	01 d0                	add    eax,edx
     711:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     714:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     717:	01 d0                	add    eax,edx
     719:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
						uint32_t of = *(uint32_t*)(sptr + r->r_offset), j;
     71c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     71f:	8b 10                	mov    edx,DWORD PTR [eax]
     721:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     724:	01 d0                	add    eax,edx
     726:	8b 00                	mov    eax,DWORD PTR [eax]
     728:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						for (j = 0; j < 8; j++)
     72b:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     732:	eb 4a                	jmp    77e <elf_dump_rel+0x32c>
								if (isprint(c[of + j]))
     734:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
     737:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     73a:	01 c2                	add    edx,eax
     73c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     73f:	01 d0                	add    eax,edx
     741:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     744:	0f be c0             	movsx  eax,al
     747:	89 04 24             	mov    DWORD PTR [esp],eax
     74a:	e8 fc ff ff ff       	call   74b <elf_dump_rel+0x2f9>
     74f:	85 c0                	test   eax,eax
     751:	74 1c                	je     76f <elf_dump_rel+0x31d>
										dat[j + 5] = c[of + j];
     753:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
     756:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     759:	01 c2                	add    edx,eax
     75b:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     75e:	01 d0                	add    eax,edx
     760:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     763:	83 c2 05             	add    edx,0x5
     766:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     769:	88 44 15 ba          	mov    BYTE PTR [ebp+edx*1-0x46],al
     76d:	eb 0b                	jmp    77a <elf_dump_rel+0x328>
										dat[j + 5] = '.';
     76f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     772:	83 c0 05             	add    eax,0x5
     775:	c6 44 05 ba 2e       	mov    BYTE PTR [ebp+eax*1-0x46],0x2e
						for (j = 0; j < 8; j++)
     77a:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     77e:	83 7d ec 07          	cmp    DWORD PTR [ebp-0x14],0x7
     782:	76 b0                	jbe    734 <elf_dump_rel+0x2e2>
						sn = dat;
     784:	8d 45 ba             	lea    eax,[ebp-0x46]
     787:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						&& (shdr[s->st_shndx].sh_flags & SHF_EXECINSTR) == 0) {
     78a:	eb 44                	jmp    7d0 <elf_dump_rel+0x37e>
						sn = elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name);
     78c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     78f:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     793:	0f b7 d0             	movzx  edx,ax
     796:	89 d0                	mov    eax,edx
     798:	c1 e0 02             	shl    eax,0x2
     79b:	01 d0                	add    eax,edx
     79d:	c1 e0 03             	shl    eax,0x3
     7a0:	89 c2                	mov    edx,eax
     7a2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     7a5:	01 d0                	add    eax,edx
     7a7:	8b 10                	mov    edx,DWORD PTR [eax]
     7a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7ac:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
     7b0:	0f b7 c0             	movzx  eax,ax
     7b3:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     7b7:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     7bb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     7be:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     7c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7c5:	89 04 24             	mov    DWORD PTR [esp],eax
     7c8:	e8 fc ff ff ff       	call   7c9 <elf_dump_rel+0x377>
     7cd:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
					*(uint32_t*)(sptr + r->r_offset), ELF32_R_SYM(r->r_info), sn);
     7d0:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     7d3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     7d6:	c1 e8 08             	shr    eax,0x8
     7d9:	89 c6                	mov    esi,eax
					*(uint32_t*)(sptr + r->r_offset), ELF32_R_SYM(r->r_info), sn);
     7db:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     7de:	8b 10                	mov    edx,DWORD PTR [eax]
     7e0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     7e3:	01 d0                	add    eax,edx
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     7e5:	8b 18                	mov    ebx,DWORD PTR [eax]
					elf_rel_type_string(ELF32_R_TYPE(r->r_info)),
     7e7:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     7ea:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     7ed:	0f b6 c0             	movzx  eax,al
     7f0:	89 04 24             	mov    DWORD PTR [esp],eax
     7f3:	e8 fc ff ff ff       	call   7f4 <elf_dump_rel+0x3a2>
     7f8:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     7fb:	8b 12                	mov    edx,DWORD PTR [edx]
     7fd:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     800:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
     804:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
     808:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
     80c:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
     810:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     814:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     817:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     81b:	c7 04 24 6b 02 00 00 	mov    DWORD PTR [esp],0x26b
     822:	e8 fc ff ff ff       	call   823 <elf_dump_rel+0x3d1>
		for (i = 0; i < ct; i++) {
     827:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     82b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     82e:	3b 45 e4             	cmp    eax,DWORD PTR [ebp-0x1c]
     831:	0f 82 ae fd ff ff    	jb     5e5 <elf_dump_rel+0x193>
     837:	eb 01                	jmp    83a <elf_dump_rel+0x3e8>
				return;
     839:	90                   	nop
}
     83a:	83 c4 70             	add    esp,0x70
     83d:	5b                   	pop    ebx
     83e:	5e                   	pop    esi
     83f:	5d                   	pop    ebp
     840:	c3                   	ret

00000841 <elf_relocate_section>:
{
     841:	55                   	push   ebp
     842:	89 e5                	mov    ebp,esp
     844:	53                   	push   ebx
     845:	83 ec 54             	sub    esp,0x54
     848:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     84b:	66 89 45 c4          	mov    WORD PTR [ebp-0x3c],ax
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
     84f:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     853:	89 d0                	mov    eax,edx
     855:	c1 e0 02             	shl    eax,0x2
     858:	01 d0                	add    eax,edx
     85a:	c1 e0 03             	shl    eax,0x3
     85d:	89 c2                	mov    edx,eax
     85f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     862:	01 d0                	add    eax,edx
     864:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     867:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     86a:	01 d0                	add    eax,edx
     86c:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
     86f:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     873:	89 d0                	mov    eax,edx
     875:	c1 e0 02             	shl    eax,0x2
     878:	01 d0                	add    eax,edx
     87a:	c1 e0 03             	shl    eax,0x3
     87d:	89 c2                	mov    edx,eax
     87f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     882:	01 d0                	add    eax,edx
     884:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     887:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     88b:	89 d0                	mov    eax,edx
     88d:	c1 e0 02             	shl    eax,0x2
     890:	01 d0                	add    eax,edx
     892:	c1 e0 03             	shl    eax,0x3
     895:	89 c2                	mov    edx,eax
     897:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     89a:	01 d0                	add    eax,edx
     89c:	8b 58 24             	mov    ebx,DWORD PTR [eax+0x24]
     89f:	89 c8                	mov    eax,ecx
     8a1:	ba 00 00 00 00       	mov    edx,0x0
     8a6:	f7 f3                	div    ebx
     8a8:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (!ct)
     8ab:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     8af:	0f 84 41 02 00 00    	je     af6 <elf_relocate_section+0x2b5>
		sptr = (void*)shdr[shdr[rel].sh_info].sh_addr; /* vma */
     8b5:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     8b9:	89 d0                	mov    eax,edx
     8bb:	c1 e0 02             	shl    eax,0x2
     8be:	01 d0                	add    eax,edx
     8c0:	c1 e0 03             	shl    eax,0x3
     8c3:	89 c2                	mov    edx,eax
     8c5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8c8:	01 d0                	add    eax,edx
     8ca:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     8cd:	89 d0                	mov    eax,edx
     8cf:	c1 e0 02             	shl    eax,0x2
     8d2:	01 d0                	add    eax,edx
     8d4:	c1 e0 03             	shl    eax,0x3
     8d7:	89 c2                	mov    edx,eax
     8d9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8dc:	01 d0                	add    eax,edx
     8de:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     8e1:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
     8e4:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     8e8:	89 d0                	mov    eax,edx
     8ea:	c1 e0 02             	shl    eax,0x2
     8ed:	01 d0                	add    eax,edx
     8ef:	c1 e0 03             	shl    eax,0x3
     8f2:	89 c2                	mov    edx,eax
     8f4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     8f7:	01 d0                	add    eax,edx
     8f9:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     8fc:	89 d0                	mov    eax,edx
     8fe:	c1 e0 02             	shl    eax,0x2
     901:	01 d0                	add    eax,edx
     903:	c1 e0 03             	shl    eax,0x3
     906:	89 c2                	mov    edx,eax
     908:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     90b:	01 d0                	add    eax,edx
     90d:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
     910:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     913:	01 d0                	add    eax,edx
     915:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		stb = shdr + shdr[rel].sh_link;
     918:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     91c:	89 d0                	mov    eax,edx
     91e:	c1 e0 02             	shl    eax,0x2
     921:	01 d0                	add    eax,edx
     923:	c1 e0 03             	shl    eax,0x3
     926:	89 c2                	mov    edx,eax
     928:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     92b:	01 d0                	add    eax,edx
     92d:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     930:	89 d0                	mov    eax,edx
     932:	c1 e0 02             	shl    eax,0x2
     935:	01 d0                	add    eax,edx
     937:	c1 e0 03             	shl    eax,0x3
     93a:	89 c2                	mov    edx,eax
     93c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     93f:	01 d0                	add    eax,edx
     941:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     944:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     948:	89 d0                	mov    eax,edx
     94a:	c1 e0 02             	shl    eax,0x2
     94d:	01 d0                	add    eax,edx
     94f:	c1 e0 03             	shl    eax,0x3
     952:	89 c2                	mov    edx,eax
     954:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     957:	01 d0                	add    eax,edx
     959:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
     95c:	89 d0                	mov    eax,edx
     95e:	c1 e0 02             	shl    eax,0x2
     961:	01 d0                	add    eax,edx
     963:	c1 e0 03             	shl    eax,0x3
     966:	89 c2                	mov    edx,eax
     968:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     96b:	01 d0                	add    eax,edx
		sbprintf("%lu relocations apply to section %s\n", ct, elf_fetch_string(hdr,
     96d:	8b 10                	mov    edx,DWORD PTR [eax]
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     96f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     972:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
		sbprintf("%lu relocations apply to section %s\n", ct, elf_fetch_string(hdr,
     976:	0f b7 c0             	movzx  eax,ax
     979:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     97d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     981:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     984:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     988:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     98b:	89 04 24             	mov    DWORD PTR [esp],eax
     98e:	e8 fc ff ff ff       	call   98f <elf_relocate_section+0x14e>
     993:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     997:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     99a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     99e:	c7 04 24 8c 02 00 00 	mov    DWORD PTR [esp],0x28c
     9a5:	e8 fc ff ff ff       	call   9a6 <elf_relocate_section+0x165>
		for (i = 0; i < ct; i++) {
     9aa:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     9b1:	e9 32 01 00 00       	jmp    ae8 <elf_relocate_section+0x2a7>
				Elf32_Addr val = 0;
     9b6:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
     9bd:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     9c1:	89 d0                	mov    eax,edx
     9c3:	c1 e0 02             	shl    eax,0x2
     9c6:	01 d0                	add    eax,edx
     9c8:	c1 e0 03             	shl    eax,0x3
     9cb:	89 c2                	mov    edx,eax
     9cd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9d0:	01 d0                	add    eax,edx
     9d2:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     9d5:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
     9d9:	89 c2                	mov    edx,eax
     9db:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     9de:	01 d0                	add    eax,edx
     9e0:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				void** pptr = (void**)(sptr + r->r_offset);
     9e3:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     9e6:	8b 10                	mov    edx,DWORD PTR [eax]
     9e8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     9eb:	01 d0                	add    eax,edx
     9ed:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
     9f0:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     9f3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     9f6:	c1 e8 08             	shr    eax,0x8
     9f9:	89 c2                	mov    edx,eax
     9fb:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     9fe:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
     a01:	0f af d0             	imul   edx,eax
     a04:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     a07:	01 d0                	add    eax,edx
     a09:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (ELF32_R_SYM(r->r_info) == 0/*STN_UNDEF*/)
     a0c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     a0f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a12:	c1 e8 08             	shr    eax,0x8
     a15:	85 c0                	test   eax,eax
     a17:	75 07                	jne    a20 <elf_relocate_section+0x1df>
						s = NULL;
     a19:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (s && !s->st_value) {
     a20:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     a24:	74 21                	je     a47 <elf_relocate_section+0x206>
     a26:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a29:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a2c:	85 c0                	test   eax,eax
     a2e:	75 17                	jne    a47 <elf_relocate_section+0x206>
						cprintf(KFMT_ERROR, "tried to relocate reference to undefined symbol\n");
     a30:	c7 44 24 04 b4 02 00 00 	mov    DWORD PTR [esp+0x4],0x2b4
     a38:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     a3f:	e8 fc ff ff ff       	call   a40 <elf_relocate_section+0x1ff>
						while (1);
     a44:	90                   	nop
     a45:	eb fd                	jmp    a44 <elf_relocate_section+0x203>
						val = s->st_value;
     a47:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     a4a:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a4d:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				if (shdr[rel].sh_type == SHT_RELA) {
     a50:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
     a54:	89 d0                	mov    eax,edx
     a56:	c1 e0 02             	shl    eax,0x2
     a59:	01 d0                	add    eax,edx
     a5b:	c1 e0 03             	shl    eax,0x3
     a5e:	89 c2                	mov    edx,eax
     a60:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a63:	01 d0                	add    eax,edx
     a65:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a68:	83 f8 04             	cmp    eax,0x4
     a6b:	75 17                	jne    a84 <elf_relocate_section+0x243>
						cprintf(KFMT_ERROR, "RELA relocations not implemented\n");
     a6d:	c7 44 24 04 e8 02 00 00 	mov    DWORD PTR [esp+0x4],0x2e8
     a75:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     a7c:	e8 fc ff ff ff       	call   a7d <elf_relocate_section+0x23c>
						while (1);
     a81:	90                   	nop
     a82:	eb fd                	jmp    a81 <elf_relocate_section+0x240>
						switch (ELF32_R_TYPE(r->r_info)) {
     a84:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     a87:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     a8a:	0f b6 c0             	movzx  eax,al
     a8d:	83 f8 06             	cmp    eax,0x6
     a90:	77 3a                	ja     acc <elf_relocate_section+0x28b>
     a92:	8b 04 85 30 03 00 00 	mov    eax,DWORD PTR [eax*4+0x330]
     a99:	ff e0                	jmp    eax
								*pptr = (size_t)val + *pptr;
     a9b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a9e:	8b 10                	mov    edx,DWORD PTR [eax]
     aa0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     aa3:	01 c2                	add    edx,eax
     aa5:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     aa8:	89 10                	mov    DWORD PTR [eax],edx
								break;
     aaa:	eb 38                	jmp    ae4 <elf_relocate_section+0x2a3>
								*pptr = (size_t)val + *pptr - (size_t)pptr;
     aac:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     aaf:	8b 10                	mov    edx,DWORD PTR [eax]
     ab1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     ab4:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
     ab7:	29 c1                	sub    ecx,eax
     ab9:	01 ca                	add    edx,ecx
     abb:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     abe:	89 10                	mov    DWORD PTR [eax],edx
								break;
     ac0:	eb 22                	jmp    ae4 <elf_relocate_section+0x2a3>
								*pptr = (void*)val;
     ac2:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     ac5:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     ac8:	89 10                	mov    DWORD PTR [eax],edx
								break;
     aca:	eb 18                	jmp    ae4 <elf_relocate_section+0x2a3>
								cprintf(KFMT_ERROR, "relocation type not implemented\n");
     acc:	c7 44 24 04 0c 03 00 00 	mov    DWORD PTR [esp+0x4],0x30c
     ad4:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     adb:	e8 fc ff ff ff       	call   adc <elf_relocate_section+0x29b>
								while (1);
     ae0:	90                   	nop
     ae1:	eb fd                	jmp    ae0 <elf_relocate_section+0x29f>
								break;
     ae3:	90                   	nop
		for (i = 0; i < ct; i++) {
     ae4:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     ae8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     aeb:	3b 45 e8             	cmp    eax,DWORD PTR [ebp-0x18]
     aee:	0f 82 c2 fe ff ff    	jb     9b6 <elf_relocate_section+0x175>
     af4:	eb 01                	jmp    af7 <elf_relocate_section+0x2b6>
				return;
     af6:	90                   	nop
}
     af7:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     afa:	c9                   	leave
     afb:	c3                   	ret

00000afc <get_section_type_string>:
{
     afc:	55                   	push   ebp
     afd:	89 e5                	mov    ebp,esp
		if (tp == SHT_PROGBITS)
     aff:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
     b03:	75 0a                	jne    b0f <get_section_type_string+0x13>
				return "PROGBITS";
     b05:	b8 4c 03 00 00       	mov    eax,0x34c
     b0a:	e9 b5 00 00 00       	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_SYMTAB)
     b0f:	83 7d 08 02          	cmp    DWORD PTR [ebp+0x8],0x2
     b13:	75 0a                	jne    b1f <get_section_type_string+0x23>
				return "SYMTAB";
     b15:	b8 55 03 00 00       	mov    eax,0x355
     b1a:	e9 a5 00 00 00       	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_DYNSYM)
     b1f:	83 7d 08 0b          	cmp    DWORD PTR [ebp+0x8],0xb
     b23:	75 0a                	jne    b2f <get_section_type_string+0x33>
				return "DYNSYM";
     b25:	b8 5c 03 00 00       	mov    eax,0x35c
     b2a:	e9 95 00 00 00       	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_STRTAB)
     b2f:	83 7d 08 03          	cmp    DWORD PTR [ebp+0x8],0x3
     b33:	75 0a                	jne    b3f <get_section_type_string+0x43>
				return "STRTAB";
     b35:	b8 63 03 00 00       	mov    eax,0x363
     b3a:	e9 85 00 00 00       	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_RELA)
     b3f:	83 7d 08 04          	cmp    DWORD PTR [ebp+0x8],0x4
     b43:	75 07                	jne    b4c <get_section_type_string+0x50>
				return "RELA";
     b45:	b8 6a 03 00 00       	mov    eax,0x36a
     b4a:	eb 78                	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_HASH)
     b4c:	83 7d 08 05          	cmp    DWORD PTR [ebp+0x8],0x5
     b50:	75 07                	jne    b59 <get_section_type_string+0x5d>
				return "HASH";
     b52:	b8 6f 03 00 00       	mov    eax,0x36f
     b57:	eb 6b                	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_DYNAMIC)
     b59:	83 7d 08 06          	cmp    DWORD PTR [ebp+0x8],0x6
     b5d:	75 07                	jne    b66 <get_section_type_string+0x6a>
				return "DYNAMIC";
     b5f:	b8 74 03 00 00       	mov    eax,0x374
     b64:	eb 5e                	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_NOTE)
     b66:	83 7d 08 07          	cmp    DWORD PTR [ebp+0x8],0x7
     b6a:	75 07                	jne    b73 <get_section_type_string+0x77>
				return "NOTE";
     b6c:	b8 7c 03 00 00       	mov    eax,0x37c
     b71:	eb 51                	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_NOBITS)
     b73:	83 7d 08 08          	cmp    DWORD PTR [ebp+0x8],0x8
     b77:	75 07                	jne    b80 <get_section_type_string+0x84>
				return "NOBITS";
     b79:	b8 81 03 00 00       	mov    eax,0x381
     b7e:	eb 44                	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_REL)
     b80:	83 7d 08 09          	cmp    DWORD PTR [ebp+0x8],0x9
     b84:	75 07                	jne    b8d <get_section_type_string+0x91>
				return "REL";
     b86:	b8 88 03 00 00       	mov    eax,0x388
     b8b:	eb 37                	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp == SHT_SHLIB)
     b8d:	83 7d 08 0a          	cmp    DWORD PTR [ebp+0x8],0xa
     b91:	75 07                	jne    b9a <get_section_type_string+0x9e>
				return "SHLIB";
     b93:	b8 8c 03 00 00       	mov    eax,0x38c
     b98:	eb 2a                	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp >= SHT_LOPROC && tp <= SHT_HIPROC)
     b9a:	81 7d 08 ff ff ff 6f 	cmp    DWORD PTR [ebp+0x8],0x6fffffff
     ba1:	76 0e                	jbe    bb1 <get_section_type_string+0xb5>
     ba3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ba6:	85 c0                	test   eax,eax
     ba8:	78 07                	js     bb1 <get_section_type_string+0xb5>
				return "PROC";
     baa:	b8 92 03 00 00       	mov    eax,0x392
     baf:	eb 13                	jmp    bc4 <get_section_type_string+0xc8>
		else if (tp >= SHT_LOUSER && tp <= SHT_HIUSER)
     bb1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bb4:	85 c0                	test   eax,eax
     bb6:	79 07                	jns    bbf <get_section_type_string+0xc3>
				return "USER";
     bb8:	b8 97 03 00 00       	mov    eax,0x397
     bbd:	eb 05                	jmp    bc4 <get_section_type_string+0xc8>
		else
				return "RESERVED";
     bbf:	b8 9c 03 00 00       	mov    eax,0x39c
}
     bc4:	5d                   	pop    ebp
     bc5:	c3                   	ret

00000bc6 <elf_store_global_symbol>:

void elf_store_global_symbol(const char* name, void* vma, char type, int is_weak)
{
     bc6:	55                   	push   ebp
     bc7:	89 e5                	mov    ebp,esp
     bc9:	53                   	push   ebx
     bca:	83 ec 44             	sub    esp,0x44
     bcd:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     bd0:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		struct symbol_list* sl = gs_lst;
     bd3:	a1 00 00 00 00       	mov    eax,ds:0x0
     bd8:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		size_t i = 0; int wrt = 0;
     bdb:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     be2:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (!sl)
     be9:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     bed:	0f 84 27 02 00 00    	je     e1a <elf_store_global_symbol+0x254>
				return;

		if (!name) {
     bf3:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     bf7:	0f 85 79 01 00 00    	jne    d76 <elf_store_global_symbol+0x1b0>
				cprintf(KFMT_WARN, "elf_store_global_symbol called for symbol "
     bfd:	0f be 45 e4          	movsx  eax,BYTE PTR [ebp-0x1c]
     c01:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     c04:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     c08:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     c0c:	c7 44 24 04 a8 03 00 00 	mov    DWORD PTR [esp+0x4],0x3a8
     c14:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
     c1b:	e8 fc ff ff ff       	call   c1c <elf_store_global_symbol+0x56>
								"of type %c with name \"\" at %p\n", type, vma);
		}

		/* search for existng definition and give an offset to which to write to */
		while (sl) {
     c20:	e9 51 01 00 00       	jmp    d76 <elf_store_global_symbol+0x1b0>
				if (!sl->entries[i].name)
     c25:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c28:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c2b:	89 d0                	mov    eax,edx
     c2d:	01 c0                	add    eax,eax
     c2f:	01 d0                	add    eax,edx
     c31:	c1 e0 02             	shl    eax,0x2
     c34:	01 c8                	add    eax,ecx
     c36:	83 c0 04             	add    eax,0x4
     c39:	8b 00                	mov    eax,DWORD PTR [eax]
     c3b:	85 c0                	test   eax,eax
     c3d:	0f 84 3f 01 00 00    	je     d82 <elf_store_global_symbol+0x1bc>
						break;
				if (strcmp(name, sl->entries[i].name) == 0) {
     c43:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c46:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c49:	89 d0                	mov    eax,edx
     c4b:	01 c0                	add    eax,eax
     c4d:	01 d0                	add    eax,edx
     c4f:	c1 e0 02             	shl    eax,0x2
     c52:	01 c8                	add    eax,ecx
     c54:	83 c0 04             	add    eax,0x4
     c57:	8b 00                	mov    eax,DWORD PTR [eax]
     c59:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     c5d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c60:	89 04 24             	mov    DWORD PTR [esp],eax
     c63:	e8 fc ff ff ff       	call   c64 <elf_store_global_symbol+0x9e>
     c68:	85 c0                	test   eax,eax
     c6a:	0f 85 99 00 00 00    	jne    d09 <elf_store_global_symbol+0x143>
						/* found a first match */
						if (sl->entries[i].type == type) {
     c70:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c73:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c76:	89 d0                	mov    eax,edx
     c78:	01 c0                	add    eax,eax
     c7a:	01 d0                	add    eax,edx
     c7c:	c1 e0 02             	shl    eax,0x2
     c7f:	01 c8                	add    eax,ecx
     c81:	83 c0 08             	add    eax,0x8
     c84:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     c87:	38 45 e4             	cmp    BYTE PTR [ebp-0x1c],al
     c8a:	75 7d                	jne    d09 <elf_store_global_symbol+0x143>
								if (is_weak) /* use existing symbol definition */
     c8c:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     c90:	0f 85 87 01 00 00    	jne    e1d <elf_store_global_symbol+0x257>
										return;
								cprintf(KFMT_WARN, "overwriting symbol %s defined at %p with "
     c96:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     c99:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     c9c:	89 d0                	mov    eax,edx
     c9e:	01 c0                	add    eax,eax
     ca0:	01 d0                	add    eax,edx
     ca2:	c1 e0 02             	shl    eax,0x2
     ca5:	01 c8                	add    eax,ecx
     ca7:	8b 08                	mov    ecx,DWORD PTR [eax]
     ca9:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
     cac:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     caf:	89 d0                	mov    eax,edx
     cb1:	01 c0                	add    eax,eax
     cb3:	01 d0                	add    eax,edx
     cb5:	c1 e0 02             	shl    eax,0x2
     cb8:	01 d8                	add    eax,ebx
     cba:	83 c0 04             	add    eax,0x4
     cbd:	8b 00                	mov    eax,DWORD PTR [eax]
     cbf:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     cc2:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
     cc6:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     cca:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     cce:	c7 44 24 04 f4 03 00 00 	mov    DWORD PTR [esp+0x4],0x3f4
     cd6:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
     cdd:	e8 fc ff ff ff       	call   cde <elf_store_global_symbol+0x118>
									"symbol at %p\n", sl->entries[i].name, sl->entries[i].vma, vma);
								kfree(sl->entries[i].name); /* just in case */
     ce2:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     ce5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     ce8:	89 d0                	mov    eax,edx
     cea:	01 c0                	add    eax,eax
     cec:	01 d0                	add    eax,edx
     cee:	c1 e0 02             	shl    eax,0x2
     cf1:	01 c8                	add    eax,ecx
     cf3:	83 c0 04             	add    eax,0x4
     cf6:	8b 00                	mov    eax,DWORD PTR [eax]
     cf8:	89 04 24             	mov    DWORD PTR [esp],eax
     cfb:	e8 fc ff ff ff       	call   cfc <elf_store_global_symbol+0x136>
								wrt = 1;
     d00:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
								break; /* only overwrite full matches */
     d07:	eb 7a                	jmp    d83 <elf_store_global_symbol+0x1bd>
						}
				}
				if (++i == 64) {
     d09:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     d0d:	83 7d f0 40          	cmp    DWORD PTR [ebp-0x10],0x40
     d11:	75 63                	jne    d76 <elf_store_global_symbol+0x1b0>
						if (sl->next) {
     d13:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d16:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     d1c:	85 c0                	test   eax,eax
     d1e:	74 15                	je     d35 <elf_store_global_symbol+0x16f>
								sl = sl->next;
     d20:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d23:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     d29:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								i = 0;
     d2c:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     d33:	eb 41                	jmp    d76 <elf_store_global_symbol+0x1b0>
						} else {
								/* allocate space for the next one and quit the loop */
								i = 0;
     d35:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
								sl = sl->next = kmalloc(sizeof(struct symbol_list));
     d3c:	c7 04 24 04 03 00 00 	mov    DWORD PTR [esp],0x304
     d43:	e8 fc ff ff ff       	call   d44 <elf_store_global_symbol+0x17e>
     d48:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     d4b:	89 82 00 03 00 00    	mov    DWORD PTR [edx+0x300],eax
     d51:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d54:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     d5a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								if (!sl)
     d5d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     d61:	0f 84 b9 00 00 00    	je     e20 <elf_store_global_symbol+0x25a>
										return;
								sl->next = NULL; /* IMPORTANT! as kmalloc != cmalloc */
     d67:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     d6a:	c7 80 00 03 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x300],0x0
								break;
     d74:	eb 0d                	jmp    d83 <elf_store_global_symbol+0x1bd>
		while (sl) {
     d76:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     d7a:	0f 85 a5 fe ff ff    	jne    c25 <elf_store_global_symbol+0x5f>
     d80:	eb 01                	jmp    d83 <elf_store_global_symbol+0x1bd>
						break;
     d82:	90                   	nop
						}
				}
		}

		/* now write the new definition */
		sl->entries[i].name = strdup(name);
     d83:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d86:	89 04 24             	mov    DWORD PTR [esp],eax
     d89:	e8 fc ff ff ff       	call   d8a <elf_store_global_symbol+0x1c4>
     d8e:	89 c1                	mov    ecx,eax
     d90:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
     d93:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     d96:	89 d0                	mov    eax,edx
     d98:	01 c0                	add    eax,eax
     d9a:	01 d0                	add    eax,edx
     d9c:	c1 e0 02             	shl    eax,0x2
     d9f:	01 d8                	add    eax,ebx
     da1:	83 c0 04             	add    eax,0x4
     da4:	89 08                	mov    DWORD PTR [eax],ecx
		sl->entries[i].type = type;
     da6:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     da9:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     dac:	89 d0                	mov    eax,edx
     dae:	01 c0                	add    eax,eax
     db0:	01 d0                	add    eax,edx
     db2:	c1 e0 02             	shl    eax,0x2
     db5:	01 c8                	add    eax,ecx
     db7:	8d 50 08             	lea    edx,[eax+0x8]
     dba:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
     dbe:	88 02                	mov    BYTE PTR [edx],al
		sl->entries[i].vma = vma;
     dc0:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     dc3:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     dc6:	89 d0                	mov    eax,edx
     dc8:	01 c0                	add    eax,eax
     dca:	01 d0                	add    eax,edx
     dcc:	c1 e0 02             	shl    eax,0x2
     dcf:	8d 14 01             	lea    edx,[ecx+eax*1]
     dd2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     dd5:	89 02                	mov    DWORD PTR [edx],eax
		/* and null-terminate if last */
		if (++i < 64 && !wrt) {
     dd7:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     ddb:	83 7d f0 3f          	cmp    DWORD PTR [ebp-0x10],0x3f
     ddf:	77 40                	ja     e21 <elf_store_global_symbol+0x25b>
     de1:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     de5:	75 3a                	jne    e21 <elf_store_global_symbol+0x25b>
				sl->entries[i].name = NULL;
     de7:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     dea:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     ded:	89 d0                	mov    eax,edx
     def:	01 c0                	add    eax,eax
     df1:	01 d0                	add    eax,edx
     df3:	c1 e0 02             	shl    eax,0x2
     df6:	01 c8                	add    eax,ecx
     df8:	83 c0 04             	add    eax,0x4
     dfb:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				sl->entries[i].vma = NULL;
     e01:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e04:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     e07:	89 d0                	mov    eax,edx
     e09:	01 c0                	add    eax,eax
     e0b:	01 d0                	add    eax,edx
     e0d:	c1 e0 02             	shl    eax,0x2
     e10:	01 c8                	add    eax,ecx
     e12:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
     e18:	eb 07                	jmp    e21 <elf_store_global_symbol+0x25b>
				return;
     e1a:	90                   	nop
     e1b:	eb 04                	jmp    e21 <elf_store_global_symbol+0x25b>
										return;
     e1d:	90                   	nop
     e1e:	eb 01                	jmp    e21 <elf_store_global_symbol+0x25b>
										return;
     e20:	90                   	nop
		}
}
     e21:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     e24:	c9                   	leave
     e25:	c3                   	ret

00000e26 <elf_locate_global_symbol>:

Elf32_Addr elf_locate_global_symbol(const char* name, char type)
{
     e26:	55                   	push   ebp
     e27:	89 e5                	mov    ebp,esp
     e29:	83 ec 38             	sub    esp,0x38
     e2c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e2f:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		struct symbol_list* sl = gs_lst;
     e32:	a1 00 00 00 00       	mov    eax,ds:0x0
     e37:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		size_t i = 0;
     e3a:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		if (!sl)
     e41:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     e45:	0f 85 d5 00 00 00    	jne    f20 <elf_locate_global_symbol+0xfa>
				return (Elf32_Addr)NULL;
     e4b:	b8 00 00 00 00       	mov    eax,0x0
     e50:	e9 dd 00 00 00       	jmp    f32 <elf_locate_global_symbol+0x10c>

		while (sl) {
				if (!sl->entries[i].name)
     e55:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e58:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     e5b:	89 d0                	mov    eax,edx
     e5d:	01 c0                	add    eax,eax
     e5f:	01 d0                	add    eax,edx
     e61:	c1 e0 02             	shl    eax,0x2
     e64:	01 c8                	add    eax,ecx
     e66:	83 c0 04             	add    eax,0x4
     e69:	8b 00                	mov    eax,DWORD PTR [eax]
     e6b:	85 c0                	test   eax,eax
     e6d:	0f 84 b9 00 00 00    	je     f2c <elf_locate_global_symbol+0x106>
						break; /* end of list */
				if (strcmp(sl->entries[i].name, name) == 0) {
     e73:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e76:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     e79:	89 d0                	mov    eax,edx
     e7b:	01 c0                	add    eax,eax
     e7d:	01 d0                	add    eax,edx
     e7f:	c1 e0 02             	shl    eax,0x2
     e82:	01 c8                	add    eax,ecx
     e84:	83 c0 04             	add    eax,0x4
     e87:	8b 00                	mov    eax,DWORD PTR [eax]
     e89:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     e8c:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     e90:	89 04 24             	mov    DWORD PTR [esp],eax
     e93:	e8 fc ff ff ff       	call   e94 <elf_locate_global_symbol+0x6e>
     e98:	85 c0                	test   eax,eax
     e9a:	75 67                	jne    f03 <elf_locate_global_symbol+0xdd>
						/* found a match candidate */
						if (sl->entries[i].type == type) /* exact match */
     e9c:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e9f:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     ea2:	89 d0                	mov    eax,edx
     ea4:	01 c0                	add    eax,eax
     ea6:	01 d0                	add    eax,edx
     ea8:	c1 e0 02             	shl    eax,0x2
     eab:	01 c8                	add    eax,ecx
     ead:	83 c0 08             	add    eax,0x8
     eb0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     eb3:	38 45 e4             	cmp    BYTE PTR [ebp-0x1c],al
     eb6:	75 15                	jne    ecd <elf_locate_global_symbol+0xa7>
								return (Elf32_Addr)sl->entries[i].vma;
     eb8:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     ebb:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     ebe:	89 d0                	mov    eax,edx
     ec0:	01 c0                	add    eax,eax
     ec2:	01 d0                	add    eax,edx
     ec4:	c1 e0 02             	shl    eax,0x2
     ec7:	01 c8                	add    eax,ecx
     ec9:	8b 00                	mov    eax,DWORD PTR [eax]
     ecb:	eb 65                	jmp    f32 <elf_locate_global_symbol+0x10c>
						else if (sl->entries[i].type == 'B' && type == 'D')
     ecd:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     ed0:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     ed3:	89 d0                	mov    eax,edx
     ed5:	01 c0                	add    eax,eax
     ed7:	01 d0                	add    eax,edx
     ed9:	c1 e0 02             	shl    eax,0x2
     edc:	01 c8                	add    eax,ecx
     ede:	83 c0 08             	add    eax,0x8
     ee1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     ee4:	3c 42                	cmp    al,0x42
     ee6:	75 1b                	jne    f03 <elf_locate_global_symbol+0xdd>
     ee8:	80 7d e4 44          	cmp    BYTE PTR [ebp-0x1c],0x44
     eec:	75 15                	jne    f03 <elf_locate_global_symbol+0xdd>
								return (Elf32_Addr)sl->entries[i].vma; /* compatible */
     eee:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     ef1:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     ef4:	89 d0                	mov    eax,edx
     ef6:	01 c0                	add    eax,eax
     ef8:	01 d0                	add    eax,edx
     efa:	c1 e0 02             	shl    eax,0x2
     efd:	01 c8                	add    eax,ecx
     eff:	8b 00                	mov    eax,DWORD PTR [eax]
     f01:	eb 2f                	jmp    f32 <elf_locate_global_symbol+0x10c>
				}

				if (++i == 64) {
     f03:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     f07:	83 7d f0 40          	cmp    DWORD PTR [ebp-0x10],0x40
     f0b:	75 13                	jne    f20 <elf_locate_global_symbol+0xfa>
						sl = sl->next;
     f0d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f10:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     f16:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						i = 0;
     f19:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		while (sl) {
     f20:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     f24:	0f 85 2b ff ff ff    	jne    e55 <elf_locate_global_symbol+0x2f>
     f2a:	eb 01                	jmp    f2d <elf_locate_global_symbol+0x107>
						break; /* end of list */
     f2c:	90                   	nop
				}
		}

		/* no match found */
		return (Elf32_Addr)NULL;
     f2d:	b8 00 00 00 00       	mov    eax,0x0
}
     f32:	c9                   	leave
     f33:	c3                   	ret

00000f34 <locate_module_function>:

void* locate_module_function(char* name)
{
     f34:	55                   	push   ebp
     f35:	89 e5                	mov    ebp,esp
     f37:	53                   	push   ebx
     f38:	83 ec 24             	sub    esp,0x24
		Elf32_Addr rv;
		rv = elf_locate_global_symbol(name, 'T');
     f3b:	c7 44 24 04 54 00 00 00 	mov    DWORD PTR [esp+0x4],0x54
     f43:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f46:	89 04 24             	mov    DWORD PTR [esp],eax
     f49:	e8 fc ff ff ff       	call   f4a <locate_module_function+0x16>
     f4e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv)
     f51:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     f55:	75 16                	jne    f6d <locate_module_function+0x39>
				rv = elf_locate_global_symbol(name, 'D');
     f57:	c7 44 24 04 44 00 00 00 	mov    DWORD PTR [esp+0x4],0x44
     f5f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f62:	89 04 24             	mov    DWORD PTR [esp],eax
     f65:	e8 fc ff ff ff       	call   f66 <locate_module_function+0x32>
     f6a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!rv) {
     f6d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     f71:	75 78                	jne    feb <locate_module_function+0xb7>
				struct symbol_list* sl = gs_lst;
     f73:	a1 00 00 00 00       	mov    eax,ds:0x0
     f78:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				size_t i = 0;
     f7b:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				while (sl) {
     f82:	eb 61                	jmp    fe5 <locate_module_function+0xb1>
						printf("%s %c\n", sl->entries[i].name, sl->entries[i].type);
     f84:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
     f87:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     f8a:	89 d0                	mov    eax,edx
     f8c:	01 c0                	add    eax,eax
     f8e:	01 d0                	add    eax,edx
     f90:	c1 e0 02             	shl    eax,0x2
     f93:	01 c8                	add    eax,ecx
     f95:	83 c0 08             	add    eax,0x8
     f98:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     f9b:	0f be c8             	movsx  ecx,al
     f9e:	8b 5d f0             	mov    ebx,DWORD PTR [ebp-0x10]
     fa1:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     fa4:	89 d0                	mov    eax,edx
     fa6:	01 c0                	add    eax,eax
     fa8:	01 d0                	add    eax,edx
     faa:	c1 e0 02             	shl    eax,0x2
     fad:	01 d8                	add    eax,ebx
     faf:	83 c0 04             	add    eax,0x4
     fb2:	8b 00                	mov    eax,DWORD PTR [eax]
     fb4:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     fb8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     fbc:	c7 04 24 2b 04 00 00 	mov    DWORD PTR [esp],0x42b
     fc3:	e8 fc ff ff ff       	call   fc4 <locate_module_function+0x90>
						if (++i == 64) {
     fc8:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     fcc:	83 7d ec 40          	cmp    DWORD PTR [ebp-0x14],0x40
     fd0:	75 13                	jne    fe5 <locate_module_function+0xb1>
								sl = sl->next;
     fd2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     fd5:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
     fdb:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								i = 0;
     fde:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				while (sl) {
     fe5:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     fe9:	75 99                	jne    f84 <locate_module_function+0x50>
						}
				}
		}
		return (void*)rv;
     feb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
     fee:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     ff1:	c9                   	leave
     ff2:	c3                   	ret

00000ff3 <store_module_info>:

void store_module_info(struct module_info* mi)
{
     ff3:	55                   	push   ebp
     ff4:	89 e5                	mov    ebp,esp
     ff6:	83 ec 28             	sub    esp,0x28
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
     ff9:	a1 20 00 00 00       	mov    eax,ds:0x20
     ffe:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		do {
				for (int i = 0; i < 7; i++)
    1001:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1008:	e9 99 00 00 00       	jmp    10a6 <store_module_info+0xb3>
						if (!mc->ptrs[i]) {
    100d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1010:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1013:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    1016:	85 c0                	test   eax,eax
    1018:	0f 85 84 00 00 00    	jne    10a2 <store_module_info+0xaf>
								mc->ptrs[i] = kmalloc(sizeof(struct module_info));
    101e:	c7 04 24 3c 00 00 00 	mov    DWORD PTR [esp],0x3c
    1025:	e8 fc ff ff ff       	call   1026 <store_module_info+0x33>
    102a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    102d:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    1030:	89 04 8a             	mov    DWORD PTR [edx+ecx*4],eax
								if (!mc->ptrs[i])
    1033:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1036:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1039:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    103c:	85 c0                	test   eax,eax
    103e:	0f 84 bd 00 00 00    	je     1101 <store_module_info+0x10e>
										return;
								memcpy(mc->ptrs[i], mi, sizeof(struct module_info));
    1044:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1047:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    104a:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    104d:	c7 44 24 08 3c 00 00 00 	mov    DWORD PTR [esp+0x8],0x3c
    1055:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1058:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    105c:	89 04 24             	mov    DWORD PTR [esp],eax
    105f:	e8 9c ef ff ff       	call   0 <memcpy>
								for (int j = 0; j < 4; j++)
    1064:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    106b:	eb 2d                	jmp    109a <store_module_info+0xa7>
										mod_tbl.sz_secs[j] += mi->sz_secs[j];
    106d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1070:	83 c0 04             	add    eax,0x4
    1073:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    107a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    107d:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1080:	83 c1 08             	add    ecx,0x8
    1083:	8b 44 88 0c          	mov    eax,DWORD PTR [eax+ecx*4+0xc]
    1087:	01 c2                	add    edx,eax
    1089:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    108c:	83 c0 04             	add    eax,0x4
    108f:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
								for (int j = 0; j < 4; j++)
    1096:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    109a:	83 7d ec 03          	cmp    DWORD PTR [ebp-0x14],0x3
    109e:	7e cd                	jle    106d <store_module_info+0x7a>
								return;
    10a0:	eb 60                	jmp    1102 <store_module_info+0x10f>
				for (int i = 0; i < 7; i++)
    10a2:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    10a6:	83 7d f0 06          	cmp    DWORD PTR [ebp-0x10],0x6
    10aa:	0f 8e 5d ff ff ff    	jle    100d <store_module_info+0x1a>
						}
				if (!mc->next) {
    10b0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10b3:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    10b6:	85 c0                	test   eax,eax
    10b8:	75 32                	jne    10ec <store_module_info+0xf9>
						mc->next = kmalloc(sizeof(struct module_info_container));
    10ba:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
    10c1:	e8 fc ff ff ff       	call   10c2 <store_module_info+0xcf>
    10c6:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    10c9:	89 42 1c             	mov    DWORD PTR [edx+0x1c],eax
						if (mc->next)
    10cc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10cf:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    10d2:	85 c0                	test   eax,eax
    10d4:	74 16                	je     10ec <store_module_info+0xf9>
								bzero(mc->next, sizeof(struct module_info_container));
    10d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10d9:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    10dc:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
    10e4:	89 04 24             	mov    DWORD PTR [esp],eax
    10e7:	e8 fc ff ff ff       	call   10e8 <store_module_info+0xf5>
				}
		} while ((mc = mc->next));
    10ec:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10ef:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    10f2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    10f5:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    10f9:	0f 85 02 ff ff ff    	jne    1001 <store_module_info+0xe>
    10ff:	eb 01                	jmp    1102 <store_module_info+0x10f>
										return;
    1101:	90                   	nop
}
    1102:	c9                   	leave
    1103:	c3                   	ret

00001104 <list_modules>:

void list_modules()
{
    1104:	55                   	push   ebp
    1105:	89 e5                	mov    ebp,esp
    1107:	83 ec 28             	sub    esp,0x28
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    110a:	a1 20 00 00 00       	mov    eax,ds:0x20
    110f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		printf("Module                     Size\n");
    1112:	c7 04 24 34 04 00 00 	mov    DWORD PTR [esp],0x434
    1119:	e8 fc ff ff ff       	call   111a <list_modules+0x16>
		do {
				for (int i = 0; i < 7; i++)
    111e:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1125:	eb 52                	jmp    1179 <list_modules+0x75>
						if (mc->ptrs[i]) {
    1127:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    112a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    112d:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    1130:	85 c0                	test   eax,eax
    1132:	74 4d                	je     1181 <list_modules+0x7d>
								struct module_info* mi = mc->ptrs[i];
    1134:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1137:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    113a:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    113d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    1140:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1143:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
											mi->sz_secs[1] + mi->sz_secs[2] + mi->sz_secs[3]);
    1146:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1149:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    114c:	01 c2                	add    edx,eax
											mi->sz_secs[1] + mi->sz_secs[2] + mi->sz_secs[3]);
    114e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1151:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    1154:	01 c2                	add    edx,eax
    1156:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1159:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    115c:	01 c2                	add    edx,eax
    115e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1161:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1165:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1169:	c7 04 24 55 04 00 00 	mov    DWORD PTR [esp],0x455
    1170:	e8 fc ff ff ff       	call   1171 <list_modules+0x6d>
				for (int i = 0; i < 7; i++)
    1175:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1179:	83 7d f0 06          	cmp    DWORD PTR [ebp-0x10],0x6
    117d:	7e a8                	jle    1127 <list_modules+0x23>
    117f:	eb 01                	jmp    1182 <list_modules+0x7e>
						} else
								break;
    1181:	90                   	nop
		} while ((mc = mc->next));
    1182:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1185:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1188:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    118b:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    118f:	75 8d                	jne    111e <list_modules+0x1a>
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    1191:	8b 15 10 00 00 00    	mov    edx,DWORD PTR ds:0x10
						mod_tbl.sz_secs[1] + mod_tbl.sz_secs[2] + mod_tbl.sz_secs[3]);
    1197:	a1 14 00 00 00       	mov    eax,ds:0x14
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    119c:	01 c2                	add    edx,eax
						mod_tbl.sz_secs[1] + mod_tbl.sz_secs[2] + mod_tbl.sz_secs[3]);
    119e:	a1 18 00 00 00       	mov    eax,ds:0x18
    11a3:	01 c2                	add    edx,eax
    11a5:	a1 1c 00 00 00       	mov    eax,ds:0x1c
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    11aa:	01 d0                	add    eax,edx
    11ac:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    11b0:	c7 04 24 61 04 00 00 	mov    DWORD PTR [esp],0x461
    11b7:	e8 fc ff ff ff       	call   11b8 <list_modules+0xb4>
}
    11bc:	90                   	nop
    11bd:	c9                   	leave
    11be:	c3                   	ret

000011bf <list_module_info>:

void list_module_info(const char* name)
{
    11bf:	55                   	push   ebp
    11c0:	89 e5                	mov    ebp,esp
    11c2:	53                   	push   ebx
    11c3:	83 ec 34             	sub    esp,0x34
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    11c6:	a1 20 00 00 00       	mov    eax,ds:0x20
    11cb:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		do {
				for (int i = 0; i < 7; i++)
    11ce:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    11d5:	e9 fc 00 00 00       	jmp    12d6 <list_module_info+0x117>
						if (mc->ptrs[i]) {
    11da:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11dd:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    11e0:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    11e3:	85 c0                	test   eax,eax
    11e5:	0f 84 f7 00 00 00    	je     12e2 <list_module_info+0x123>
								struct module_info* mi = mc->ptrs[i];
    11eb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11ee:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    11f1:	8b 04 90             	mov    eax,DWORD PTR [eax+edx*4]
    11f4:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								if (strcmp(mi->mi_name, name) == 0) {
    11f7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    11fa:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    11fd:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1201:	89 04 24             	mov    DWORD PTR [esp],eax
    1204:	e8 fc ff ff ff       	call   1205 <list_module_info+0x46>
    1209:	85 c0                	test   eax,eax
    120b:	0f 85 c1 00 00 00    	jne    12d2 <list_module_info+0x113>
										printf("module %s resides at:\n", name);
    1211:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1214:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1218:	c7 04 24 7d 04 00 00 	mov    DWORD PTR [esp],0x47d
    121f:	e8 fc ff ff ff       	call   1220 <list_module_info+0x61>
										printf("SECTION     .text    .data  .rodata     .bss\n");
    1224:	c7 04 24 94 04 00 00 	mov    DWORD PTR [esp],0x494
    122b:	e8 fc ff ff ff       	call   122c <list_module_info+0x6d>
										printf("OFFSET   %p %p %p %p\n", mi->vm_ofs[0],
    1230:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1233:	8b 58 28             	mov    ebx,DWORD PTR [eax+0x28]
    1236:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1239:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
    123c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    123f:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    1242:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1245:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1248:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    124c:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1250:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1254:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1258:	c7 04 24 c2 04 00 00 	mov    DWORD PTR [esp],0x4c2
    125f:	e8 fc ff ff ff       	call   1260 <list_module_info+0xa1>
												mi->vm_ofs[1], mi->vm_ofs[2], mi->vm_ofs[3]);
										printf("SIZE     %8lu %8lu %8lu %8lu\n", mi->sz_secs[0],
    1264:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1267:	8b 58 38             	mov    ebx,DWORD PTR [eax+0x38]
    126a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    126d:	8b 48 34             	mov    ecx,DWORD PTR [eax+0x34]
    1270:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1273:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    1276:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1279:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    127c:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    1280:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1284:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1288:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    128c:	c7 04 24 d8 04 00 00 	mov    DWORD PTR [esp],0x4d8
    1293:	e8 fc ff ff ff       	call   1294 <list_module_info+0xd5>
												mi->sz_secs[1], mi->sz_secs[2], mi->sz_secs[3]);
										printf("with the two functions\n");
    1298:	c7 04 24 f6 04 00 00 	mov    DWORD PTR [esp],0x4f6
    129f:	e8 fc ff ff ff       	call   12a0 <list_module_info+0xe1>
										printf("module_init     at %p and\n", mi->mi_init);
    12a4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    12a7:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    12aa:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    12ae:	c7 04 24 0e 05 00 00 	mov    DWORD PTR [esp],0x50e
    12b5:	e8 fc ff ff ff       	call   12b6 <list_module_info+0xf7>
										printf("module_cleanup  at %p\n", mi->mi_cleanup);
    12ba:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    12bd:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    12c0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    12c4:	c7 04 24 29 05 00 00 	mov    DWORD PTR [esp],0x529
    12cb:	e8 fc ff ff ff       	call   12cc <list_module_info+0x10d>
										return;
    12d0:	eb 37                	jmp    1309 <list_module_info+0x14a>
				for (int i = 0; i < 7; i++)
    12d2:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    12d6:	83 7d f0 06          	cmp    DWORD PTR [ebp-0x10],0x6
    12da:	0f 8e fa fe ff ff    	jle    11da <list_module_info+0x1b>
    12e0:	eb 01                	jmp    12e3 <list_module_info+0x124>
								}
						} else
								break;
    12e2:	90                   	nop
		} while ((mc = mc->next));
    12e3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12e6:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    12e9:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    12ec:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    12f0:	0f 85 d8 fe ff ff    	jne    11ce <list_module_info+0xf>
		printf("modinfo: ERROR: Module %s not found.\n", name);
    12f6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12f9:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    12fd:	c7 04 24 40 05 00 00 	mov    DWORD PTR [esp],0x540
    1304:	e8 fc ff ff ff       	call   1305 <list_module_info+0x146>
}
    1309:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    130c:	c9                   	leave
    130d:	c3                   	ret

0000130e <elf_get_closest_symbol>:

const char* elf_get_closest_symbol(void* ptr, size_t* offset)
{
    130e:	55                   	push   ebp
    130f:	89 e5                	mov    ebp,esp
    1311:	83 ec 10             	sub    esp,0x10
		struct symbol_list* sl = gs_lst;
    1314:	a1 00 00 00 00       	mov    eax,ds:0x0
    1319:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		size_t i = 0; const char* rv = ""; void* base = NULL;
    131c:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
    1323:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    132a:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		if (!sl) {
    1331:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
    1335:	0f 85 96 00 00 00    	jne    13d1 <elf_get_closest_symbol+0xc3>
				*offset = (size_t)ptr;
    133b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    133e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1341:	89 10                	mov    DWORD PTR [eax],edx
				return "";
    1343:	b8 00 00 00 00       	mov    eax,0x0
    1348:	e9 a1 00 00 00       	jmp    13ee <elf_get_closest_symbol+0xe0>
		}

		while (sl) {
				if (sl->entries[i].vma <= ptr && sl->entries[i].vma > base) {
    134d:	8b 4d fc             	mov    ecx,DWORD PTR [ebp-0x4]
    1350:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
    1353:	89 d0                	mov    eax,edx
    1355:	01 c0                	add    eax,eax
    1357:	01 d0                	add    eax,edx
    1359:	c1 e0 02             	shl    eax,0x2
    135c:	01 c8                	add    eax,ecx
    135e:	8b 00                	mov    eax,DWORD PTR [eax]
    1360:	39 45 08             	cmp    DWORD PTR [ebp+0x8],eax
    1363:	72 4f                	jb     13b4 <elf_get_closest_symbol+0xa6>
    1365:	8b 4d fc             	mov    ecx,DWORD PTR [ebp-0x4]
    1368:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
    136b:	89 d0                	mov    eax,edx
    136d:	01 c0                	add    eax,eax
    136f:	01 d0                	add    eax,edx
    1371:	c1 e0 02             	shl    eax,0x2
    1374:	01 c8                	add    eax,ecx
    1376:	8b 00                	mov    eax,DWORD PTR [eax]
    1378:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    137b:	73 37                	jae    13b4 <elf_get_closest_symbol+0xa6>
						/* found a new one */
						rv = sl->entries[i].name;
    137d:	8b 4d fc             	mov    ecx,DWORD PTR [ebp-0x4]
    1380:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
    1383:	89 d0                	mov    eax,edx
    1385:	01 c0                	add    eax,eax
    1387:	01 d0                	add    eax,edx
    1389:	c1 e0 02             	shl    eax,0x2
    138c:	01 c8                	add    eax,ecx
    138e:	83 c0 04             	add    eax,0x4
    1391:	8b 00                	mov    eax,DWORD PTR [eax]
    1393:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						base = sl->entries[i].vma;
    1396:	8b 4d fc             	mov    ecx,DWORD PTR [ebp-0x4]
    1399:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
    139c:	89 d0                	mov    eax,edx
    139e:	01 c0                	add    eax,eax
    13a0:	01 d0                	add    eax,edx
    13a2:	c1 e0 02             	shl    eax,0x2
    13a5:	01 c8                	add    eax,ecx
    13a7:	8b 00                	mov    eax,DWORD PTR [eax]
    13a9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if (base == ptr) /* abort on first exact match */
    13ac:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    13af:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
    13b2:	74 29                	je     13dd <elf_get_closest_symbol+0xcf>
								break;
				}
				if (++i == 64) {
    13b4:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
    13b8:	83 7d f8 40          	cmp    DWORD PTR [ebp-0x8],0x40
    13bc:	75 13                	jne    13d1 <elf_get_closest_symbol+0xc3>
						sl = sl->next;
    13be:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
    13c1:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
    13c7:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						i = 0;
    13ca:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
		while (sl) {
    13d1:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
    13d5:	0f 85 72 ff ff ff    	jne    134d <elf_get_closest_symbol+0x3f>
    13db:	eb 01                	jmp    13de <elf_get_closest_symbol+0xd0>
								break;
    13dd:	90                   	nop
				}
		}

		*offset = ptr - base;
    13de:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13e1:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    13e4:	89 c2                	mov    edx,eax
    13e6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    13e9:	89 10                	mov    DWORD PTR [eax],edx
		return rv;
    13eb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    13ee:	c9                   	leave
    13ef:	c3                   	ret

000013f0 <elf_resolve_symbols>:

/* bss_vmem is in/out parameter which points to the top of bss after call */
void elf_resolve_symbols(Elf32_Ehdr* hdr, Elf32_Shdr* shdr, Elf32_Half symtab, void** bss_vmem, struct module_info* mi)
{
    13f0:	55                   	push   ebp
    13f1:	89 e5                	mov    ebp,esp
    13f3:	56                   	push   esi
    13f4:	53                   	push   ebx
    13f5:	83 ec 50             	sub    esp,0x50
    13f8:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    13fb:	66 89 45 c4          	mov    WORD PTR [ebp-0x3c],ax
		void* ptr = ((void*)hdr + shdr[symtab].sh_offset);
    13ff:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1403:	89 d0                	mov    eax,edx
    1405:	c1 e0 02             	shl    eax,0x2
    1408:	01 d0                	add    eax,edx
    140a:	c1 e0 03             	shl    eax,0x3
    140d:	89 c2                	mov    edx,eax
    140f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1412:	01 d0                	add    eax,edx
    1414:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
    1417:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    141a:	01 d0                	add    eax,edx
    141c:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		size_t i, ct = shdr[symtab].sh_size / shdr[symtab].sh_entsize;
    141f:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1423:	89 d0                	mov    eax,edx
    1425:	c1 e0 02             	shl    eax,0x2
    1428:	01 d0                	add    eax,edx
    142a:	c1 e0 03             	shl    eax,0x3
    142d:	89 c2                	mov    edx,eax
    142f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1432:	01 d0                	add    eax,edx
    1434:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
    1437:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    143b:	89 d0                	mov    eax,edx
    143d:	c1 e0 02             	shl    eax,0x2
    1440:	01 d0                	add    eax,edx
    1442:	c1 e0 03             	shl    eax,0x3
    1445:	89 c2                	mov    edx,eax
    1447:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    144a:	01 d0                	add    eax,edx
    144c:	8b 70 24             	mov    esi,DWORD PTR [eax+0x24]
    144f:	89 c8                	mov    eax,ecx
    1451:	ba 00 00 00 00       	mov    edx,0x0
    1456:	f7 f6                	div    esi
    1458:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		if (ct <= 1)
    145b:	83 7d e0 01          	cmp    DWORD PTR [ebp-0x20],0x1
    145f:	0f 86 a7 06 00 00    	jbe    1b0c <elf_resolve_symbols+0x71c>
				return;
		sbprintf("Resolving symbols in symtab with %lu entries\n", ct);
    1465:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1468:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    146c:	c7 04 24 68 05 00 00 	mov    DWORD PTR [esp],0x568
    1473:	e8 fc ff ff ff       	call   1474 <elf_resolve_symbols+0x84>
		for (i = 1; i < ct; i++) {
    1478:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
    147f:	e9 7a 06 00 00       	jmp    1afe <elf_resolve_symbols+0x70e>
				Elf32_Sym* s = (ptr + i * shdr[symtab].sh_entsize);
    1484:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1488:	89 d0                	mov    eax,edx
    148a:	c1 e0 02             	shl    eax,0x2
    148d:	01 d0                	add    eax,edx
    148f:	c1 e0 03             	shl    eax,0x3
    1492:	89 c2                	mov    edx,eax
    1494:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1497:	01 d0                	add    eax,edx
    1499:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    149c:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
    14a0:	89 c2                	mov    edx,eax
    14a2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    14a5:	01 d0                	add    eax,edx
    14a7:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				if (s->st_shndx == SHN_UNDEF) {
    14aa:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    14ad:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    14b1:	66 85 c0             	test   ax,ax
    14b4:	0f 85 ce 00 00 00    	jne    1588 <elf_resolve_symbols+0x198>
						char* sn, tp = 'T';
    14ba:	c6 45 f3 54          	mov    BYTE PTR [ebp-0xd],0x54
						/* unresolved symbol -> find in map */
						sbprintf("using external symbol with name %s\n",
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
    14be:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    14c1:	8b 08                	mov    ecx,DWORD PTR [eax]
    14c3:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    14c7:	89 d0                	mov    eax,edx
    14c9:	c1 e0 02             	shl    eax,0x2
    14cc:	01 d0                	add    eax,edx
    14ce:	c1 e0 03             	shl    eax,0x3
    14d1:	89 c2                	mov    edx,eax
    14d3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    14d6:	01 d0                	add    eax,edx
    14d8:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    14db:	0f b7 c0             	movzx  eax,ax
    14de:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    14e2:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    14e6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    14e9:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    14ed:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14f0:	89 04 24             	mov    DWORD PTR [esp],eax
    14f3:	e8 fc ff ff ff       	call   14f4 <elf_resolve_symbols+0x104>
    14f8:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						sbprintf("using external symbol with name %s\n",
    14fb:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    14fe:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1502:	c7 04 24 98 05 00 00 	mov    DWORD PTR [esp],0x598
    1509:	e8 fc ff ff ff       	call   150a <elf_resolve_symbols+0x11a>
						if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    150e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1511:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1515:	0f b6 c0             	movzx  eax,al
    1518:	83 e0 0f             	and    eax,0xf
    151b:	83 f8 01             	cmp    eax,0x1
    151e:	75 04                	jne    1524 <elf_resolve_symbols+0x134>
								tp = 'D';
    1520:	c6 45 f3 44          	mov    BYTE PTR [ebp-0xd],0x44
						s->st_value = elf_locate_global_symbol(sn, tp);
    1524:	0f be 45 f3          	movsx  eax,BYTE PTR [ebp-0xd]
    1528:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    152c:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    152f:	89 04 24             	mov    DWORD PTR [esp],eax
    1532:	e8 fc ff ff ff       	call   1533 <elf_resolve_symbols+0x143>
    1537:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    153a:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
						if (!s->st_value) {
    153d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1540:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1543:	85 c0                	test   eax,eax
    1545:	75 26                	jne    156d <elf_resolve_symbols+0x17d>
								cprintf(KFMT_ERROR, "unresolved external symbol %c \"%s\"\n", tp, sn);
    1547:	0f be 45 f3          	movsx  eax,BYTE PTR [ebp-0xd]
    154b:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    154e:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1552:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1556:	c7 44 24 04 bc 05 00 00 	mov    DWORD PTR [esp+0x4],0x5bc
    155e:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1565:	e8 fc ff ff ff       	call   1566 <elf_resolve_symbols+0x176>
								while (1);
    156a:	90                   	nop
    156b:	eb fd                	jmp    156a <elf_resolve_symbols+0x17a>
						} else
								sbprintf("\twhich was resolved to %p\n", (void*)s->st_value);
    156d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1570:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1573:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1577:	c7 04 24 e0 05 00 00 	mov    DWORD PTR [esp],0x5e0
    157e:	e8 fc ff ff ff       	call   157f <elf_resolve_symbols+0x18f>
    1583:	e9 72 05 00 00       	jmp    1afa <elf_resolve_symbols+0x70a>
				} else if (s->st_shndx == SHN_COMMON) {
    1588:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    158b:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    158f:	66 83 f8 f2          	cmp    ax,0xfff2
    1593:	0f 85 b4 01 00 00    	jne    174d <elf_resolve_symbols+0x35d>
						char* sn, tp = 'D'; Elf32_Addr ad = (Elf32_Addr)NULL;
    1599:	c6 45 d3 44          	mov    BYTE PTR [ebp-0x2d],0x44
    159d:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						sbprintf("Common symbol with size %u and alignment %u with name %s\n",
										s->st_size, s->st_value,
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
    15a4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    15a7:	8b 08                	mov    ecx,DWORD PTR [eax]
    15a9:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    15ad:	89 d0                	mov    eax,edx
    15af:	c1 e0 02             	shl    eax,0x2
    15b2:	01 d0                	add    eax,edx
    15b4:	c1 e0 03             	shl    eax,0x3
    15b7:	89 c2                	mov    edx,eax
    15b9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    15bc:	01 d0                	add    eax,edx
    15be:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    15c1:	0f b7 c0             	movzx  eax,ax
    15c4:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    15c8:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    15cc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    15cf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    15d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15d6:	89 04 24             	mov    DWORD PTR [esp],eax
    15d9:	e8 fc ff ff ff       	call   15da <elf_resolve_symbols+0x1ea>
    15de:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
						sbprintf("Common symbol with size %u and alignment %u with name %s\n",
    15e1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    15e4:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    15e7:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    15ea:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    15ed:	8b 4d cc             	mov    ecx,DWORD PTR [ebp-0x34]
    15f0:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    15f4:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    15f8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    15fc:	c7 04 24 fc 05 00 00 	mov    DWORD PTR [esp],0x5fc
    1603:	e8 fc ff ff ff       	call   1604 <elf_resolve_symbols+0x214>
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1608:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    160b:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    160f:	c0 e8 04             	shr    al,0x4
    1612:	3c 01                	cmp    al,0x1
    1614:	74 0e                	je     1624 <elf_resolve_symbols+0x234>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1616:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1619:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    161d:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1620:	3c 02                	cmp    al,0x2
    1622:	75 2f                	jne    1653 <elf_resolve_symbols+0x263>
								/* lookup on global symtab */
								ad = elf_locate_global_symbol(sn, tp);
    1624:	0f be 45 d3          	movsx  eax,BYTE PTR [ebp-0x2d]
    1628:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    162c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    162f:	89 04 24             	mov    DWORD PTR [esp],eax
    1632:	e8 fc ff ff ff       	call   1633 <elf_resolve_symbols+0x243>
    1637:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								if (ad)
    163a:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    163e:	74 13                	je     1653 <elf_resolve_symbols+0x263>
										sbprintf("global definition found at %p\n", (void*)ad);
    1640:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1643:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1647:	c7 04 24 38 06 00 00 	mov    DWORD PTR [esp],0x638
    164e:	e8 fc ff ff ff       	call   164f <elf_resolve_symbols+0x25f>
						}
						/* lookup on symtab or else allocate */
						if (!ad) {
    1653:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1657:	0f 85 e2 00 00 00    	jne    173f <elf_resolve_symbols+0x34f>
								/* allocate rw bss (dumb align) */
								if ((size_t)*bss_vmem % (size_t)s->st_value) {
    165d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1660:	8b 00                	mov    eax,DWORD PTR [eax]
    1662:	89 c2                	mov    edx,eax
    1664:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1667:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    166a:	89 d0                	mov    eax,edx
    166c:	ba 00 00 00 00       	mov    edx,0x0
    1671:	f7 f1                	div    ecx
    1673:	89 d0                	mov    eax,edx
    1675:	85 c0                	test   eax,eax
    1677:	74 62                	je     16db <elf_resolve_symbols+0x2eb>
										*bss_vmem += s->st_value - ((size_t)*bss_vmem % s->st_value);
    1679:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    167c:	8b 08                	mov    ecx,DWORD PTR [eax]
    167e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1681:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1684:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1687:	8b 00                	mov    eax,DWORD PTR [eax]
    1689:	89 c2                	mov    edx,eax
    168b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    168e:	8b 70 04             	mov    esi,DWORD PTR [eax+0x4]
    1691:	89 d0                	mov    eax,edx
    1693:	ba 00 00 00 00       	mov    edx,0x0
    1698:	f7 f6                	div    esi
    169a:	89 d8                	mov    eax,ebx
    169c:	29 d0                	sub    eax,edx
    169e:	8d 14 01             	lea    edx,[ecx+eax*1]
    16a1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    16a4:	89 10                	mov    DWORD PTR [eax],edx
										s->st_value = (Elf32_Addr)*bss_vmem;
    16a6:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    16a9:	8b 00                	mov    eax,DWORD PTR [eax]
    16ab:	89 c2                	mov    edx,eax
    16ad:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16b0:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										*bss_vmem += s->st_size;
    16b3:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    16b6:	8b 10                	mov    edx,DWORD PTR [eax]
    16b8:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16bb:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    16be:	01 c2                	add    edx,eax
    16c0:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    16c3:	89 10                	mov    DWORD PTR [eax],edx
										sbprintf("will be allocated at %p\n", (void*)s->st_value);
    16c5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16c8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    16cb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    16cf:	c7 04 24 57 06 00 00 	mov    DWORD PTR [esp],0x657
    16d6:	e8 fc ff ff ff       	call   16d7 <elf_resolve_symbols+0x2e7>
								}
								/* publish the location if applicable */
								if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    16db:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16de:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    16e2:	c0 e8 04             	shr    al,0x4
    16e5:	3c 01                	cmp    al,0x1
    16e7:	74 12                	je     16fb <elf_resolve_symbols+0x30b>
												ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    16e9:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16ec:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    16f0:	c0 e8 04             	shr    al,0x4
								if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    16f3:	3c 02                	cmp    al,0x2
    16f5:	0f 85 ff 03 00 00    	jne    1afa <elf_resolve_symbols+0x70a>
										elf_store_global_symbol(sn, (void*)s->st_value, tp,
													   	(ELF32_ST_BIND(s->st_info) == STB_WEAK));
    16fb:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16fe:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
										elf_store_global_symbol(sn, (void*)s->st_value, tp,
    1702:	c0 e8 04             	shr    al,0x4
    1705:	3c 02                	cmp    al,0x2
    1707:	0f 94 c0             	sete   al
    170a:	0f b6 d0             	movzx  edx,al
    170d:	0f be 45 d3          	movsx  eax,BYTE PTR [ebp-0x2d]
    1711:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    1714:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    1717:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    171b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    171f:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    1723:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1726:	89 04 24             	mov    DWORD PTR [esp],eax
    1729:	e8 fc ff ff ff       	call   172a <elf_resolve_symbols+0x33a>
										sbprintf("and is global\n");
    172e:	c7 04 24 70 06 00 00 	mov    DWORD PTR [esp],0x670
    1735:	e8 fc ff ff ff       	call   1736 <elf_resolve_symbols+0x346>
    173a:	e9 bb 03 00 00       	jmp    1afa <elf_resolve_symbols+0x70a>
								}
						} else
								s->st_value = ad;
    173f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1742:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1745:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    1748:	e9 ad 03 00 00       	jmp    1afa <elf_resolve_symbols+0x70a>
				} else if (s->st_shndx < SHN_LORESERVE) {
    174d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1750:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    1754:	66 3d ff fe          	cmp    ax,0xfeff
    1758:	0f 87 88 02 00 00    	ja     19e6 <elf_resolve_symbols+0x5f6>
						/* local symbol so get virtual address for relocations */
						if (!(shdr[s->st_shndx].sh_flags & SHF_ALLOC))
    175e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1761:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    1765:	0f b7 d0             	movzx  edx,ax
    1768:	89 d0                	mov    eax,edx
    176a:	c1 e0 02             	shl    eax,0x2
    176d:	01 d0                	add    eax,edx
    176f:	c1 e0 03             	shl    eax,0x3
    1772:	89 c2                	mov    edx,eax
    1774:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1777:	01 d0                	add    eax,edx
    1779:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    177c:	83 e0 02             	and    eax,0x2
    177f:	85 c0                	test   eax,eax
    1781:	0f 84 72 03 00 00    	je     1af9 <elf_resolve_symbols+0x709>
								continue; /* skip symbols in unused sections */
						s->st_value += shdr[s->st_shndx].sh_addr;
    1787:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    178a:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    178d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1790:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    1794:	0f b7 d0             	movzx  edx,ax
    1797:	89 d0                	mov    eax,edx
    1799:	c1 e0 02             	shl    eax,0x2
    179c:	01 d0                	add    eax,edx
    179e:	c1 e0 03             	shl    eax,0x3
    17a1:	89 c2                	mov    edx,eax
    17a3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17a6:	01 d0                	add    eax,edx
    17a8:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    17ab:	8d 14 01             	lea    edx,[ecx+eax*1]
    17ae:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    17b1:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
						sbprintf("symbol %s from %s defined at vmem=%p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
							  			(void*)s->st_value);
    17b4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    17b7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    17ba:	89 c6                	mov    esi,eax
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
    17bc:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    17bf:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    17c3:	0f b7 d0             	movzx  edx,ax
    17c6:	89 d0                	mov    eax,edx
    17c8:	c1 e0 02             	shl    eax,0x2
    17cb:	01 d0                	add    eax,edx
    17cd:	c1 e0 03             	shl    eax,0x3
    17d0:	89 c2                	mov    edx,eax
    17d2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17d5:	01 d0                	add    eax,edx
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    17d7:	8b 10                	mov    edx,DWORD PTR [eax]
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
    17d9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17dc:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    17e0:	0f b7 c0             	movzx  eax,ax
    17e3:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    17e7:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    17eb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17ee:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    17f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17f5:	89 04 24             	mov    DWORD PTR [esp],eax
    17f8:	e8 fc ff ff ff       	call   17f9 <elf_resolve_symbols+0x409>
    17fd:	89 c3                	mov    ebx,eax
    17ff:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1802:	8b 08                	mov    ecx,DWORD PTR [eax]
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
    1804:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1808:	89 d0                	mov    eax,edx
    180a:	c1 e0 02             	shl    eax,0x2
    180d:	01 d0                	add    eax,edx
    180f:	c1 e0 03             	shl    eax,0x3
    1812:	89 c2                	mov    edx,eax
    1814:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1817:	01 d0                	add    eax,edx
    1819:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    181c:	0f b7 c0             	movzx  eax,ax
    181f:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1823:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1827:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    182a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    182e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1831:	89 04 24             	mov    DWORD PTR [esp],eax
    1834:	e8 fc ff ff ff       	call   1835 <elf_resolve_symbols+0x445>
    1839:	89 74 24 0c          	mov    DWORD PTR [esp+0xc],esi
    183d:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
    1841:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1845:	c7 04 24 80 06 00 00 	mov    DWORD PTR [esp],0x680
    184c:	e8 fc ff ff ff       	call   184d <elf_resolve_symbols+0x45d>
						if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_init") == 0) {
    1851:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1854:	8b 08                	mov    ecx,DWORD PTR [eax]
    1856:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    185a:	89 d0                	mov    eax,edx
    185c:	c1 e0 02             	shl    eax,0x2
    185f:	01 d0                	add    eax,edx
    1861:	c1 e0 03             	shl    eax,0x3
    1864:	89 c2                	mov    edx,eax
    1866:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1869:	01 d0                	add    eax,edx
    186b:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    186e:	0f b7 c0             	movzx  eax,ax
    1871:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1875:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1879:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    187c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1880:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1883:	89 04 24             	mov    DWORD PTR [esp],eax
    1886:	e8 fc ff ff ff       	call   1887 <elf_resolve_symbols+0x497>
    188b:	c7 44 24 04 a6 06 00 00 	mov    DWORD PTR [esp+0x4],0x6a6
    1893:	89 04 24             	mov    DWORD PTR [esp],eax
    1896:	e8 fc ff ff ff       	call   1897 <elf_resolve_symbols+0x4a7>
    189b:	85 c0                	test   eax,eax
    189d:	75 26                	jne    18c5 <elf_resolve_symbols+0x4d5>
								mi->mi_init = (mod_init)s->st_value;
    189f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    18a2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    18a5:	89 c2                	mov    edx,eax
    18a7:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    18aa:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
								sbprintf("found global entry module_init at %p\n", mi->mi_init);
    18ad:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    18b0:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    18b3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    18b7:	c7 04 24 b4 06 00 00 	mov    DWORD PTR [esp],0x6b4
    18be:	e8 fc ff ff ff       	call   18bf <elf_resolve_symbols+0x4cf>
    18c3:	eb 72                	jmp    1937 <elf_resolve_symbols+0x547>
						} else if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_cleanup") == 0) {
    18c5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    18c8:	8b 08                	mov    ecx,DWORD PTR [eax]
    18ca:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    18ce:	89 d0                	mov    eax,edx
    18d0:	c1 e0 02             	shl    eax,0x2
    18d3:	01 d0                	add    eax,edx
    18d5:	c1 e0 03             	shl    eax,0x3
    18d8:	89 c2                	mov    edx,eax
    18da:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18dd:	01 d0                	add    eax,edx
    18df:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    18e2:	0f b7 c0             	movzx  eax,ax
    18e5:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    18e9:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    18ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18f0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    18f4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18f7:	89 04 24             	mov    DWORD PTR [esp],eax
    18fa:	e8 fc ff ff ff       	call   18fb <elf_resolve_symbols+0x50b>
    18ff:	c7 44 24 04 da 06 00 00 	mov    DWORD PTR [esp+0x4],0x6da
    1907:	89 04 24             	mov    DWORD PTR [esp],eax
    190a:	e8 fc ff ff ff       	call   190b <elf_resolve_symbols+0x51b>
    190f:	85 c0                	test   eax,eax
    1911:	75 24                	jne    1937 <elf_resolve_symbols+0x547>
								mi->mi_cleanup = (mod_cleanup)s->st_value;
    1913:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1916:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1919:	89 c2                	mov    edx,eax
    191b:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    191e:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
								sbprintf("found global exit module_cleanup at %p\n", mi->mi_cleanup);
    1921:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    1924:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1927:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    192b:	c7 04 24 ec 06 00 00 	mov    DWORD PTR [esp],0x6ec
    1932:	e8 fc ff ff ff       	call   1933 <elf_resolve_symbols+0x543>
						}
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1937:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    193a:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    193e:	c0 e8 04             	shr    al,0x4
    1941:	3c 01                	cmp    al,0x1
    1943:	74 12                	je     1957 <elf_resolve_symbols+0x567>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1945:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1948:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    194c:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    194f:	3c 02                	cmp    al,0x2
    1951:	0f 85 a3 01 00 00    	jne    1afa <elf_resolve_symbols+0x70a>
								/* exported symbol -> to global symtab */
								char tp = 'T', *sn;
    1957:	c6 45 eb 54          	mov    BYTE PTR [ebp-0x15],0x54
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    195b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    195e:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1962:	0f b6 c0             	movzx  eax,al
    1965:	83 e0 0f             	and    eax,0xf
    1968:	83 f8 01             	cmp    eax,0x1
    196b:	75 04                	jne    1971 <elf_resolve_symbols+0x581>
										tp = 'D';
    196d:	c6 45 eb 44          	mov    BYTE PTR [ebp-0x15],0x44
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
    1971:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1974:	8b 08                	mov    ecx,DWORD PTR [eax]
    1976:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    197a:	89 d0                	mov    eax,edx
    197c:	c1 e0 02             	shl    eax,0x2
    197f:	01 d0                	add    eax,edx
    1981:	c1 e0 03             	shl    eax,0x3
    1984:	89 c2                	mov    edx,eax
    1986:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1989:	01 d0                	add    eax,edx
    198b:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    198e:	0f b7 c0             	movzx  eax,ax
    1991:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1995:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1999:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    199c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    19a0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19a3:	89 04 24             	mov    DWORD PTR [esp],eax
    19a6:	e8 fc ff ff ff       	call   19a7 <elf_resolve_symbols+0x5b7>
    19ab:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
    19ae:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    19b1:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    19b5:	c0 e8 04             	shr    al,0x4
    19b8:	3c 02                	cmp    al,0x2
    19ba:	0f 94 c0             	sete   al
    19bd:	0f b6 d0             	movzx  edx,al
    19c0:	0f be 45 eb          	movsx  eax,BYTE PTR [ebp-0x15]
    19c4:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    19c7:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    19ca:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    19ce:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    19d2:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    19d6:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    19d9:	89 04 24             	mov    DWORD PTR [esp],eax
    19dc:	e8 fc ff ff ff       	call   19dd <elf_resolve_symbols+0x5ed>
    19e1:	e9 14 01 00 00       	jmp    1afa <elf_resolve_symbols+0x70a>
						}
				} else if (s->st_shndx == SHN_ABS) {
    19e6:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    19e9:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
    19ed:	66 83 f8 f1          	cmp    ax,0xfff1
    19f1:	0f 85 03 01 00 00    	jne    1afa <elf_resolve_symbols+0x70a>
						sbprintf("absolute symbol with name %s and value %p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
							  			(void*)s->st_value);
    19f7:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    19fa:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
						sbprintf("absolute symbol with name %s and value %p\n",
    19fd:	89 c3                	mov    ebx,eax
    19ff:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1a02:	8b 08                	mov    ecx,DWORD PTR [eax]
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
    1a04:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1a08:	89 d0                	mov    eax,edx
    1a0a:	c1 e0 02             	shl    eax,0x2
    1a0d:	01 d0                	add    eax,edx
    1a0f:	c1 e0 03             	shl    eax,0x3
    1a12:	89 c2                	mov    edx,eax
    1a14:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a17:	01 d0                	add    eax,edx
    1a19:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
						sbprintf("absolute symbol with name %s and value %p\n",
    1a1c:	0f b7 c0             	movzx  eax,ax
    1a1f:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1a23:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1a27:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a2a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a2e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a31:	89 04 24             	mov    DWORD PTR [esp],eax
    1a34:	e8 fc ff ff ff       	call   1a35 <elf_resolve_symbols+0x645>
    1a39:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
    1a3d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a41:	c7 04 24 14 07 00 00 	mov    DWORD PTR [esp],0x714
    1a48:	e8 fc ff ff ff       	call   1a49 <elf_resolve_symbols+0x659>
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1a4d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1a50:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1a54:	c0 e8 04             	shr    al,0x4
    1a57:	3c 01                	cmp    al,0x1
    1a59:	74 12                	je     1a6d <elf_resolve_symbols+0x67d>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1a5b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1a5e:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1a62:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1a65:	3c 02                	cmp    al,0x2
    1a67:	0f 85 8d 00 00 00    	jne    1afa <elf_resolve_symbols+0x70a>
								char tp = 'T', *sn;
    1a6d:	c6 45 ea 54          	mov    BYTE PTR [ebp-0x16],0x54
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    1a71:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1a74:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1a78:	0f b6 c0             	movzx  eax,al
    1a7b:	83 e0 0f             	and    eax,0xf
    1a7e:	83 f8 01             	cmp    eax,0x1
    1a81:	75 04                	jne    1a87 <elf_resolve_symbols+0x697>
										tp = 'D';
    1a83:	c6 45 ea 44          	mov    BYTE PTR [ebp-0x16],0x44
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
    1a87:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1a8a:	8b 08                	mov    ecx,DWORD PTR [eax]
    1a8c:	0f b7 55 c4          	movzx  edx,WORD PTR [ebp-0x3c]
    1a90:	89 d0                	mov    eax,edx
    1a92:	c1 e0 02             	shl    eax,0x2
    1a95:	01 d0                	add    eax,edx
    1a97:	c1 e0 03             	shl    eax,0x3
    1a9a:	89 c2                	mov    edx,eax
    1a9c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a9f:	01 d0                	add    eax,edx
    1aa1:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    1aa4:	0f b7 c0             	movzx  eax,ax
    1aa7:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1aab:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1aaf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ab2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1ab6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ab9:	89 04 24             	mov    DWORD PTR [esp],eax
    1abc:	e8 fc ff ff ff       	call   1abd <elf_resolve_symbols+0x6cd>
    1ac1:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
    1ac4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1ac7:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    1acb:	c0 e8 04             	shr    al,0x4
    1ace:	3c 02                	cmp    al,0x2
    1ad0:	0f 94 c0             	sete   al
    1ad3:	0f b6 d0             	movzx  edx,al
    1ad6:	0f be 45 ea          	movsx  eax,BYTE PTR [ebp-0x16]
    1ada:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    1add:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
    1ae0:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1ae4:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1ae8:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    1aec:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1aef:	89 04 24             	mov    DWORD PTR [esp],eax
    1af2:	e8 fc ff ff ff       	call   1af3 <elf_resolve_symbols+0x703>
    1af7:	eb 01                	jmp    1afa <elf_resolve_symbols+0x70a>
								continue; /* skip symbols in unused sections */
    1af9:	90                   	nop
		for (i = 1; i < ct; i++) {
    1afa:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1afe:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1b01:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    1b04:	0f 82 7a f9 ff ff    	jb     1484 <elf_resolve_symbols+0x94>
    1b0a:	eb 01                	jmp    1b0d <elf_resolve_symbols+0x71d>
				return;
    1b0c:	90                   	nop
						}
				}
		}
}
    1b0d:	83 c4 50             	add    esp,0x50
    1b10:	5b                   	pop    ebx
    1b11:	5e                   	pop    esi
    1b12:	5d                   	pop    ebp
    1b13:	c3                   	ret

00001b14 <load_elf>:

/*#define ELF_DIAG*/

enum elferr load_elf(void* mem, uint32_t sz, struct module_info* mi)
{
    1b14:	55                   	push   ebp
    1b15:	89 e5                	mov    ebp,esp
    1b17:	53                   	push   ebx
    1b18:	81 ec f4 00 00 00    	sub    esp,0xf4
		Elf32_Ehdr* hdr = (Elf32_Ehdr*)mem;
    1b1e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b21:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
		Elf32_Shdr* shdr; size_t i;

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, 4) != 0)
    1b24:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1b27:	c7 44 24 08 04 00 00 00 	mov    DWORD PTR [esp+0x8],0x4
    1b2f:	c7 44 24 04 3f 07 00 00 	mov    DWORD PTR [esp+0x4],0x73f
    1b37:	89 04 24             	mov    DWORD PTR [esp],eax
    1b3a:	e8 fc ff ff ff       	call   1b3b <load_elf+0x27>
    1b3f:	85 c0                	test   eax,eax
    1b41:	74 0a                	je     1b4d <load_elf+0x39>
				return ELF_WRONG_MAGIC;
    1b43:	b8 01 00 00 00       	mov    eax,0x1
    1b48:	e9 f5 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (hdr->e_ident[EI_CLASS] != ELFCLASS32)
    1b4d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1b50:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
    1b54:	3c 01                	cmp    al,0x1
    1b56:	74 0a                	je     1b62 <load_elf+0x4e>
				return ELF_NOT_CLASS32;
    1b58:	b8 02 00 00 00       	mov    eax,0x2
    1b5d:	e9 e0 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
    1b62:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1b65:	0f b6 40 05          	movzx  eax,BYTE PTR [eax+0x5]
    1b69:	3c 01                	cmp    al,0x1
    1b6b:	74 0a                	je     1b77 <load_elf+0x63>
				return ELF_NOT_LE;
    1b6d:	b8 03 00 00 00       	mov    eax,0x3
    1b72:	e9 cb 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
    1b77:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1b7a:	0f b6 40 06          	movzx  eax,BYTE PTR [eax+0x6]
    1b7e:	3c 01                	cmp    al,0x1
    1b80:	74 0a                	je     1b8c <load_elf+0x78>
				return ELF_VERSION_NOT_SUPPORTED;
    1b82:	b8 05 00 00 00       	mov    eax,0x5
    1b87:	e9 b6 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
    1b8c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1b8f:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    1b93:	84 c0                	test   al,al
    1b95:	74 0a                	je     1ba1 <load_elf+0x8d>
				return ELF_WRONG_OSABI;
    1b97:	b8 06 00 00 00       	mov    eax,0x6
    1b9c:	e9 a1 0b 00 00       	jmp    2742 <load_elf+0xc2e>

		/* matching ELF32 found -> check for object file */
		if (hdr->e_type != ET_REL)
    1ba1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1ba4:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
    1ba8:	66 83 f8 01          	cmp    ax,0x1
    1bac:	74 0a                	je     1bb8 <load_elf+0xa4>
				return ELF_NOT_REL;
    1bae:	b8 07 00 00 00       	mov    eax,0x7
    1bb3:	e9 8a 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (hdr->e_machine != EM_386)
    1bb8:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1bbb:	0f b7 40 12          	movzx  eax,WORD PTR [eax+0x12]
    1bbf:	66 83 f8 03          	cmp    ax,0x3
    1bc3:	74 0a                	je     1bcf <load_elf+0xbb>
				return ELF_NOT_386;
    1bc5:	b8 08 00 00 00       	mov    eax,0x8
    1bca:	e9 73 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (hdr->e_ehsize != sizeof(*hdr))
    1bcf:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1bd2:	0f b7 40 28          	movzx  eax,WORD PTR [eax+0x28]
    1bd6:	66 83 f8 34          	cmp    ax,0x34
    1bda:	74 0a                	je     1be6 <load_elf+0xd2>
				return ELF_INCOMPATIBLE_HEADER;
    1bdc:	b8 09 00 00 00       	mov    eax,0x9
    1be1:	e9 5c 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (hdr->e_phnum)
    1be6:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1be9:	0f b7 40 2c          	movzx  eax,WORD PTR [eax+0x2c]
    1bed:	66 85 c0             	test   ax,ax
    1bf0:	74 0a                	je     1bfc <load_elf+0xe8>
				return ELF_CONTAINS_PROG_HEADERS;
    1bf2:	b8 0a 00 00 00       	mov    eax,0xa
    1bf7:	e9 46 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (!hdr->e_shnum)
    1bfc:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1bff:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    1c03:	66 85 c0             	test   ax,ax
    1c06:	75 0a                	jne    1c12 <load_elf+0xfe>
				return ELF_NO_SECTIONS_DEFINED;
    1c08:	b8 0b 00 00 00       	mov    eax,0xb
    1c0d:	e9 30 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (hdr->e_shentsize != sizeof(Elf32_Shdr))
    1c12:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1c15:	0f b7 40 2e          	movzx  eax,WORD PTR [eax+0x2e]
    1c19:	66 83 f8 28          	cmp    ax,0x28
    1c1d:	74 0a                	je     1c29 <load_elf+0x115>
				return ELF_WRONG_SHDR_SIZE;
    1c1f:	b8 0c 00 00 00       	mov    eax,0xc
    1c24:	e9 19 0b 00 00       	jmp    2742 <load_elf+0xc2e>
		if (hdr->e_shstrndx == SHN_UNDEF)
    1c29:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1c2c:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
    1c30:	66 85 c0             	test   ax,ax
    1c33:	75 0a                	jne    1c3f <load_elf+0x12b>
				return ELF_NO_SECTION_STRTAB;
    1c35:	b8 0d 00 00 00       	mov    eax,0xd
    1c3a:	e9 03 0b 00 00       	jmp    2742 <load_elf+0xc2e>

		/* set the initial offsets */
		for (i = 0; i < 4; i++)
    1c3f:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1c46:	eb 1b                	jmp    1c63 <load_elf+0x14f>
				mi->vm_ofs[i] = mod_tbl.vm_ofs[i];
    1c48:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c4b:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    1c52:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c55:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    1c58:	83 c1 04             	add    ecx,0x4
    1c5b:	89 54 88 0c          	mov    DWORD PTR [eax+ecx*4+0xc],edx
		for (i = 0; i < 4; i++)
    1c5f:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1c63:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    1c67:	76 df                	jbe    1c48 <load_elf+0x134>

		/* now first allocate the sections in memory */
		shdr = mem + hdr->e_shoff;
    1c69:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1c6c:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    1c6f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c72:	01 d0                	add    eax,edx
    1c74:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
		for (i = 0; i < hdr->e_shnum; i++) {
    1c77:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1c7e:	e9 3d 06 00 00       	jmp    22c0 <load_elf+0x7ac>
				if (shdr[i].sh_type == SHT_NULL)
    1c83:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1c86:	89 d0                	mov    eax,edx
    1c88:	c1 e0 02             	shl    eax,0x2
    1c8b:	01 d0                	add    eax,edx
    1c8d:	c1 e0 03             	shl    eax,0x3
    1c90:	89 c2                	mov    edx,eax
    1c92:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1c95:	01 d0                	add    eax,edx
    1c97:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c9a:	85 c0                	test   eax,eax
    1c9c:	0f 84 19 06 00 00    	je     22bb <load_elf+0x7a7>
						continue;

				/* only allocate alloc section */
				if (shdr[i].sh_flags & SHF_ALLOC) {
    1ca2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1ca5:	89 d0                	mov    eax,edx
    1ca7:	c1 e0 02             	shl    eax,0x2
    1caa:	01 d0                	add    eax,edx
    1cac:	c1 e0 03             	shl    eax,0x3
    1caf:	89 c2                	mov    edx,eax
    1cb1:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1cb4:	01 d0                	add    eax,edx
    1cb6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1cb9:	83 e0 02             	and    eax,0x2
    1cbc:	85 c0                	test   eax,eax
    1cbe:	0f 84 f8 05 00 00    	je     22bc <load_elf+0x7a8>
						size_t pg_ct; struct page_range pr[10];
						Elf32_Word algn = shdr[i].sh_addralign;
    1cc4:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1cc7:	89 d0                	mov    eax,edx
    1cc9:	c1 e0 02             	shl    eax,0x2
    1ccc:	01 d0                	add    eax,edx
    1cce:	c1 e0 03             	shl    eax,0x3
    1cd1:	89 c2                	mov    edx,eax
    1cd3:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1cd6:	01 d0                	add    eax,edx
    1cd8:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1cdb:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
						Elf32_Addr addr; void* mapaddr; int reuse = 0;
    1cde:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
						Elf32_Off ofs = shdr[i].sh_offset;
    1ce5:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1ce8:	89 d0                	mov    eax,edx
    1cea:	c1 e0 02             	shl    eax,0x2
    1ced:	01 d0                	add    eax,edx
    1cef:	c1 e0 03             	shl    eax,0x3
    1cf2:	89 c2                	mov    edx,eax
    1cf4:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1cf7:	01 d0                	add    eax,edx
    1cf9:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1cfc:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						enum mt_sec sct;

						pg_ct = shdr[i].sh_size / 4096 + ((shdr[i].sh_size % 4096) ? 1 : 0);
    1cff:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1d02:	89 d0                	mov    eax,edx
    1d04:	c1 e0 02             	shl    eax,0x2
    1d07:	01 d0                	add    eax,edx
    1d09:	c1 e0 03             	shl    eax,0x3
    1d0c:	89 c2                	mov    edx,eax
    1d0e:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1d11:	01 d0                	add    eax,edx
    1d13:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1d16:	c1 e8 0c             	shr    eax,0xc
    1d19:	89 c1                	mov    ecx,eax
    1d1b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1d1e:	89 d0                	mov    eax,edx
    1d20:	c1 e0 02             	shl    eax,0x2
    1d23:	01 d0                	add    eax,edx
    1d25:	c1 e0 03             	shl    eax,0x3
    1d28:	89 c2                	mov    edx,eax
    1d2a:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1d2d:	01 d0                	add    eax,edx
    1d2f:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1d32:	25 ff 0f 00 00       	and    eax,0xfff
    1d37:	85 c0                	test   eax,eax
    1d39:	74 07                	je     1d42 <load_elf+0x22e>
    1d3b:	b8 01 00 00 00       	mov    eax,0x1
    1d40:	eb 05                	jmp    1d47 <load_elf+0x233>
    1d42:	b8 00 00 00 00       	mov    eax,0x0
    1d47:	01 c8                	add    eax,ecx
    1d49:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						/* get the section type */
						if (shdr[i].sh_flags & SHF_WRITE) {
    1d4c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1d4f:	89 d0                	mov    eax,edx
    1d51:	c1 e0 02             	shl    eax,0x2
    1d54:	01 d0                	add    eax,edx
    1d56:	c1 e0 03             	shl    eax,0x3
    1d59:	89 c2                	mov    edx,eax
    1d5b:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1d5e:	01 d0                	add    eax,edx
    1d60:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1d63:	83 e0 01             	and    eax,0x1
    1d66:	85 c0                	test   eax,eax
    1d68:	74 56                	je     1dc0 <load_elf+0x2ac>
								/* TODO: C-o-w bss */
								if (shdr[i].sh_flags & SHF_EXECINSTR)
    1d6a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1d6d:	89 d0                	mov    eax,edx
    1d6f:	c1 e0 02             	shl    eax,0x2
    1d72:	01 d0                	add    eax,edx
    1d74:	c1 e0 03             	shl    eax,0x3
    1d77:	89 c2                	mov    edx,eax
    1d79:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1d7c:	01 d0                	add    eax,edx
    1d7e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1d81:	83 e0 04             	and    eax,0x4
    1d84:	85 c0                	test   eax,eax
    1d86:	74 0a                	je     1d92 <load_elf+0x27e>
										return ELF_SECTION_RWX;
    1d88:	b8 0e 00 00 00       	mov    eax,0xe
    1d8d:	e9 b0 09 00 00       	jmp    2742 <load_elf+0xc2e>
								if (shdr[i].sh_type == SHT_NOBITS)
    1d92:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1d95:	89 d0                	mov    eax,edx
    1d97:	c1 e0 02             	shl    eax,0x2
    1d9a:	01 d0                	add    eax,edx
    1d9c:	c1 e0 03             	shl    eax,0x3
    1d9f:	89 c2                	mov    edx,eax
    1da1:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1da4:	01 d0                	add    eax,edx
    1da6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1da9:	83 f8 08             	cmp    eax,0x8
    1dac:	75 09                	jne    1db7 <load_elf+0x2a3>
										sct = MT_SEC_BSS;
    1dae:	c7 45 dc 03 00 00 00 	mov    DWORD PTR [ebp-0x24],0x3
    1db5:	eb 62                	jmp    1e19 <load_elf+0x305>
								else
										sct = MT_SEC_DATA;
    1db7:	c7 45 dc 01 00 00 00 	mov    DWORD PTR [ebp-0x24],0x1
    1dbe:	eb 59                	jmp    1e19 <load_elf+0x305>
						} else if (shdr[i].sh_flags & SHF_EXECINSTR)
    1dc0:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1dc3:	89 d0                	mov    eax,edx
    1dc5:	c1 e0 02             	shl    eax,0x2
    1dc8:	01 d0                	add    eax,edx
    1dca:	c1 e0 03             	shl    eax,0x3
    1dcd:	89 c2                	mov    edx,eax
    1dcf:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1dd2:	01 d0                	add    eax,edx
    1dd4:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1dd7:	83 e0 04             	and    eax,0x4
    1dda:	85 c0                	test   eax,eax
    1ddc:	74 09                	je     1de7 <load_elf+0x2d3>
								sct = MT_SEC_TEXT;
    1dde:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1de5:	eb 32                	jmp    1e19 <load_elf+0x305>
						else {
								/* rodata, robss? */
								if (shdr[i].sh_type == SHT_NOBITS) {
    1de7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1dea:	89 d0                	mov    eax,edx
    1dec:	c1 e0 02             	shl    eax,0x2
    1def:	01 d0                	add    eax,edx
    1df1:	c1 e0 03             	shl    eax,0x3
    1df4:	89 c2                	mov    edx,eax
    1df6:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1df9:	01 d0                	add    eax,edx
    1dfb:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1dfe:	83 f8 08             	cmp    eax,0x8
    1e01:	75 0f                	jne    1e12 <load_elf+0x2fe>
										printf("Implement zero page!\n");
    1e03:	c7 04 24 44 07 00 00 	mov    DWORD PTR [esp],0x744
    1e0a:	e8 fc ff ff ff       	call   1e0b <load_elf+0x2f7>
										while (1); /* c-o-w? nope! */
    1e0f:	90                   	nop
    1e10:	eb fd                	jmp    1e0f <load_elf+0x2fb>
								}
								sct = MT_SEC_RODATA;
    1e12:	c7 45 dc 02 00 00 00 	mov    DWORD PTR [ebp-0x24],0x2
						}
						/* get the raw (unaligned) address */
						addr = (Elf32_Addr)mod_tbl.vm_ofs[sct] + mi->sz_secs[sct];
    1e19:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1e1c:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    1e23:	89 c1                	mov    ecx,eax
    1e25:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1e28:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1e2b:	83 c2 08             	add    edx,0x8
    1e2e:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    1e32:	01 c8                	add    eax,ecx
    1e34:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						mbprintf("unaligned address for %s: %p\n", elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[i].sh_name), (void*)addr);
    1e37:	8b 5d ec             	mov    ebx,DWORD PTR [ebp-0x14]
    1e3a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1e3d:	89 d0                	mov    eax,edx
    1e3f:	c1 e0 02             	shl    eax,0x2
    1e42:	01 d0                	add    eax,edx
    1e44:	c1 e0 03             	shl    eax,0x3
    1e47:	89 c2                	mov    edx,eax
    1e49:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1e4c:	01 d0                	add    eax,edx
    1e4e:	8b 10                	mov    edx,DWORD PTR [eax]
    1e50:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1e53:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
    1e57:	0f b7 c0             	movzx  eax,ax
    1e5a:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1e5e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1e62:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1e65:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e69:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1e6c:	89 04 24             	mov    DWORD PTR [esp],eax
    1e6f:	e8 fc ff ff ff       	call   1e70 <load_elf+0x35c>
    1e74:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
    1e78:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e7c:	c7 04 24 5a 07 00 00 	mov    DWORD PTR [esp],0x75a
    1e83:	e8 fc ff ff ff       	call   1e84 <load_elf+0x370>

						/* now do the alignment calculations */
						if (addr % algn)
    1e88:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e8b:	ba 00 00 00 00       	mov    edx,0x0
    1e90:	f7 75 b8             	div    DWORD PTR [ebp-0x48]
    1e93:	89 d0                	mov    eax,edx
    1e95:	85 c0                	test   eax,eax
    1e97:	74 13                	je     1eac <load_elf+0x398>
								addr += algn - addr % algn;
    1e99:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1e9c:	ba 00 00 00 00       	mov    edx,0x0
    1ea1:	f7 75 b8             	div    DWORD PTR [ebp-0x48]
    1ea4:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    1ea7:	29 d0                	sub    eax,edx
    1ea9:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
						if (algn < 0x1000 && (addr % 4096)) {
    1eac:	81 7d b8 ff 0f 00 00 	cmp    DWORD PTR [ebp-0x48],0xfff
    1eb3:	77 5e                	ja     1f13 <load_elf+0x3ff>
    1eb5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1eb8:	25 ff 0f 00 00       	and    eax,0xfff
    1ebd:	85 c0                	test   eax,eax
    1ebf:	74 52                	je     1f13 <load_elf+0x3ff>
								/* maybe save up to a single page by reusing an existing one of the same module */
								size_t ovs = shdr[i].sh_size % 4096; /* "oversize" */
    1ec1:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1ec4:	89 d0                	mov    eax,edx
    1ec6:	c1 e0 02             	shl    eax,0x2
    1ec9:	01 d0                	add    eax,edx
    1ecb:	c1 e0 03             	shl    eax,0x3
    1ece:	89 c2                	mov    edx,eax
    1ed0:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1ed3:	01 d0                	add    eax,edx
    1ed5:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1ed8:	25 ff 0f 00 00       	and    eax,0xfff
    1edd:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
								if (ovs && ovs < (4096 - (addr % 4096))) {
    1ee0:	83 7d b4 00          	cmp    DWORD PTR [ebp-0x4c],0x0
    1ee4:	74 2d                	je     1f13 <load_elf+0x3ff>
    1ee6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ee9:	25 ff 0f 00 00       	and    eax,0xfff
    1eee:	89 c2                	mov    edx,eax
    1ef0:	b8 00 10 00 00       	mov    eax,0x1000
    1ef5:	29 d0                	sub    eax,edx
    1ef7:	39 45 b4             	cmp    DWORD PTR [ebp-0x4c],eax
    1efa:	73 17                	jae    1f13 <load_elf+0x3ff>
										/* oversize fits into existing page */
										mbprintf("reuse\n");
    1efc:	c7 04 24 78 07 00 00 	mov    DWORD PTR [esp],0x778
    1f03:	e8 fc ff ff ff       	call   1f04 <load_elf+0x3f0>
										pg_ct--;
    1f08:	83 6d f0 01          	sub    DWORD PTR [ebp-0x10],0x1
										reuse = 1;
    1f0c:	c7 45 e4 01 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x1
								}
						}
						if (addr % 4096)
    1f13:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1f16:	25 ff 0f 00 00       	and    eax,0xfff
    1f1b:	85 c0                	test   eax,eax
    1f1d:	74 57                	je     1f76 <load_elf+0x462>
								if (reuse) /* first use partially present page */
    1f1f:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1f23:	74 12                	je     1f37 <load_elf+0x423>
										mapaddr = (void*)(addr + 4096 - addr % 4096);
    1f25:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1f28:	25 00 f0 ff ff       	and    eax,0xfffff000
    1f2d:	05 00 10 00 00       	add    eax,0x1000
    1f32:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1f35:	eb 45                	jmp    1f7c <load_elf+0x468>
								else { /* alignment leaves page partially unused */
										mapaddr = (void*)(addr - addr % 4096);
    1f37:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1f3a:	25 00 f0 ff ff       	and    eax,0xfffff000
    1f3f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
										if (pg_ct * 4096 < shdr[i].sh_size + addr % 4096)
    1f42:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1f45:	c1 e0 0c             	shl    eax,0xc
    1f48:	89 c1                	mov    ecx,eax
    1f4a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1f4d:	89 d0                	mov    eax,edx
    1f4f:	c1 e0 02             	shl    eax,0x2
    1f52:	01 d0                	add    eax,edx
    1f54:	c1 e0 03             	shl    eax,0x3
    1f57:	89 c2                	mov    edx,eax
    1f59:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1f5c:	01 d0                	add    eax,edx
    1f5e:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1f61:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1f64:	81 e2 ff 0f 00 00    	and    edx,0xfff
    1f6a:	01 d0                	add    eax,edx
    1f6c:	39 c1                	cmp    ecx,eax
    1f6e:	73 0c                	jae    1f7c <load_elf+0x468>
												pg_ct++; /* adjust space accordingly */
    1f70:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1f74:	eb 06                	jmp    1f7c <load_elf+0x468>
								}
						else
								mapaddr = (void*)addr;
    1f76:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1f79:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax

						shdr[i].sh_addr = addr;
    1f7c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1f7f:	89 d0                	mov    eax,edx
    1f81:	c1 e0 02             	shl    eax,0x2
    1f84:	01 d0                	add    eax,edx
    1f86:	c1 e0 03             	shl    eax,0x3
    1f89:	89 c2                	mov    edx,eax
    1f8b:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1f8e:	01 c2                	add    edx,eax
    1f90:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1f93:	89 42 0c             	mov    DWORD PTR [edx+0xc],eax
						mbprintf("aligned address: %p\n", (void*)addr);
    1f96:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1f99:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1f9d:	c7 04 24 7f 07 00 00 	mov    DWORD PTR [esp],0x77f
    1fa4:	e8 fc ff ff ff       	call   1fa5 <load_elf+0x491>
						if (!mi->vm_ofs[sct])
    1fa9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1fac:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1faf:	83 c2 04             	add    edx,0x4
    1fb2:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    1fb6:	85 c0                	test   eax,eax
    1fb8:	75 10                	jne    1fca <load_elf+0x4b6>
								mi->vm_ofs[sct] = (void*)addr;
    1fba:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1fbd:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1fc0:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
    1fc3:	83 c1 04             	add    ecx,0x4
    1fc6:	89 54 88 0c          	mov    DWORD PTR [eax+ecx*4+0xc],edx
						mi->sz_secs[sct] += shdr[i].sh_size;
    1fca:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1fcd:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1fd0:	83 c2 08             	add    edx,0x8
    1fd3:	8b 4c 90 0c          	mov    ecx,DWORD PTR [eax+edx*4+0xc]
    1fd7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1fda:	89 d0                	mov    eax,edx
    1fdc:	c1 e0 02             	shl    eax,0x2
    1fdf:	01 d0                	add    eax,edx
    1fe1:	c1 e0 03             	shl    eax,0x3
    1fe4:	89 c2                	mov    edx,eax
    1fe6:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1fe9:	01 d0                	add    eax,edx
    1feb:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1fee:	01 c1                	add    ecx,eax
    1ff0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ff3:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1ff6:	83 c2 08             	add    edx,0x8
    1ff9:	89 4c 90 0c          	mov    DWORD PTR [eax+edx*4+0xc],ecx

						/* fill the half-used page (if PROGBITS) */
						if (((void*)addr < mapaddr) && (shdr[i].sh_type != SHT_NOBITS)) {
    1ffd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2000:	3b 45 e8             	cmp    eax,DWORD PTR [ebp-0x18]
    2003:	73 72                	jae    2077 <load_elf+0x563>
    2005:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2008:	89 d0                	mov    eax,edx
    200a:	c1 e0 02             	shl    eax,0x2
    200d:	01 d0                	add    eax,edx
    200f:	c1 e0 03             	shl    eax,0x3
    2012:	89 c2                	mov    edx,eax
    2014:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2017:	01 d0                	add    eax,edx
    2019:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    201c:	83 f8 08             	cmp    eax,0x8
    201f:	74 56                	je     2077 <load_elf+0x563>
								size_t n = (size_t)mapaddr - (size_t)addr;
    2021:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2024:	2b 45 ec             	sub    eax,DWORD PTR [ebp-0x14]
    2027:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
								n = min(n, shdr[i].sh_size);
    202a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    202d:	89 d0                	mov    eax,edx
    202f:	c1 e0 02             	shl    eax,0x2
    2032:	01 d0                	add    eax,edx
    2034:	c1 e0 03             	shl    eax,0x3
    2037:	89 c2                	mov    edx,eax
    2039:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    203c:	01 d0                	add    eax,edx
    203e:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2041:	8b 55 b0             	mov    edx,DWORD PTR [ebp-0x50]
    2044:	39 c2                	cmp    edx,eax
    2046:	0f 46 c2             	cmovbe eax,edx
    2049:	89 45 b0             	mov    DWORD PTR [ebp-0x50],eax
								memcpy((void*)addr, (void*)hdr + ofs, n);
    204c:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    204f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2052:	8d 0c 02             	lea    ecx,[edx+eax*1]
    2055:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2058:	8b 55 b0             	mov    edx,DWORD PTR [ebp-0x50]
    205b:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    205f:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    2063:	89 04 24             	mov    DWORD PTR [esp],eax
    2066:	e8 95 df ff ff       	call   0 <memcpy>
								ofs += n;
    206b:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    206e:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
								addr += n;
    2071:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    2074:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
						}
						/* allocate the physical memory and map it to virtual memory */
						mbprintf("allocating %lu pages for size=%u\n", pg_ct, shdr[i].sh_size);
    2077:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    207a:	89 d0                	mov    eax,edx
    207c:	c1 e0 02             	shl    eax,0x2
    207f:	01 d0                	add    eax,edx
    2081:	c1 e0 03             	shl    eax,0x3
    2084:	89 c2                	mov    edx,eax
    2086:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2089:	01 d0                	add    eax,edx
    208b:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    208e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2092:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2095:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2099:	c7 04 24 94 07 00 00 	mov    DWORD PTR [esp],0x794
    20a0:	e8 fc ff ff ff       	call   20a1 <load_elf+0x58d>
						while (pg_ct) {
    20a5:	e9 05 02 00 00       	jmp    22af <load_elf+0x79b>
								int flags = MMGR_MAP_KERNEL, remap = 0;
    20aa:	c7 45 d8 08 00 00 00 	mov    DWORD PTR [ebp-0x28],0x8
    20b1:	c7 45 ac 00 00 00 00 	mov    DWORD PTR [ebp-0x54],0x0
								size_t np = mm_alloc_pm(pg_ct, pr, countof(pr));
    20b8:	c7 44 24 08 0a 00 00 00 	mov    DWORD PTR [esp+0x8],0xa
    20c0:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    20c6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    20ca:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    20cd:	89 04 24             	mov    DWORD PTR [esp],eax
    20d0:	e8 fc ff ff ff       	call   20d1 <load_elf+0x5bd>
    20d5:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
								if (shdr[i].sh_flags & SHF_EXECINSTR)
    20d8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    20db:	89 d0                	mov    eax,edx
    20dd:	c1 e0 02             	shl    eax,0x2
    20e0:	01 d0                	add    eax,edx
    20e2:	c1 e0 03             	shl    eax,0x3
    20e5:	89 c2                	mov    edx,eax
    20e7:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    20ea:	01 d0                	add    eax,edx
    20ec:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    20ef:	83 e0 04             	and    eax,0x4
    20f2:	85 c0                	test   eax,eax
    20f4:	74 04                	je     20fa <load_elf+0x5e6>
										flags |= MMGR_MAP_EXECUTE;
    20f6:	83 4d d8 02          	or     DWORD PTR [ebp-0x28],0x2
								if (shdr[i].sh_flags & SHF_WRITE)
    20fa:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    20fd:	89 d0                	mov    eax,edx
    20ff:	c1 e0 02             	shl    eax,0x2
    2102:	01 d0                	add    eax,edx
    2104:	c1 e0 03             	shl    eax,0x3
    2107:	89 c2                	mov    edx,eax
    2109:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    210c:	01 d0                	add    eax,edx
    210e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2111:	83 e0 01             	and    eax,0x1
    2114:	85 c0                	test   eax,eax
    2116:	74 06                	je     211e <load_elf+0x60a>
										flags |= MMGR_MAP_WRITE;
    2118:	83 4d d8 04          	or     DWORD PTR [ebp-0x28],0x4
    211c:	eb 20                	jmp    213e <load_elf+0x62a>
								else if (shdr[i].sh_type != SHT_NOBITS) {
    211e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2121:	89 d0                	mov    eax,edx
    2123:	c1 e0 02             	shl    eax,0x2
    2126:	01 d0                	add    eax,edx
    2128:	c1 e0 03             	shl    eax,0x3
    212b:	89 c2                	mov    edx,eax
    212d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2130:	01 d0                	add    eax,edx
    2132:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2135:	83 f8 08             	cmp    eax,0x8
    2138:	74 04                	je     213e <load_elf+0x62a>
										flags |= MMGR_MAP_WRITE;
    213a:	83 4d d8 04          	or     DWORD PTR [ebp-0x28],0x4
								}

								mbprintf("mapping %lu pages to %p\n", np, mapaddr);
    213e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2141:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2145:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2148:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    214c:	c7 04 24 b6 07 00 00 	mov    DWORD PTR [esp],0x7b6
    2153:	e8 fc ff ff ff       	call   2154 <load_elf+0x640>
								if (mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags) != mapaddr) {
    2158:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    215b:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    215f:	c7 44 24 0c 0a 00 00 00 	mov    DWORD PTR [esp+0xc],0xa
    2167:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    216d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2171:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2174:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2178:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    217f:	e8 fc ff ff ff       	call   2180 <load_elf+0x66c>
    2184:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
    2187:	74 0f                	je     2198 <load_elf+0x684>
										printf("unexpected error mapping pmem to vmem\n");
    2189:	c7 04 24 d0 07 00 00 	mov    DWORD PTR [esp],0x7d0
    2190:	e8 fc ff ff ff       	call   2191 <load_elf+0x67d>
										while (1);
    2195:	90                   	nop
    2196:	eb fd                	jmp    2195 <load_elf+0x681>
								}
								/* copy data if present */
								if (shdr[i].sh_type != SHT_NOBITS) {
    2198:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    219b:	89 d0                	mov    eax,edx
    219d:	c1 e0 02             	shl    eax,0x2
    21a0:	01 d0                	add    eax,edx
    21a2:	c1 e0 03             	shl    eax,0x3
    21a5:	89 c2                	mov    edx,eax
    21a7:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    21aa:	01 d0                	add    eax,edx
    21ac:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    21af:	83 f8 08             	cmp    eax,0x8
    21b2:	0f 84 e8 00 00 00    	je     22a0 <load_elf+0x78c>
										size_t n = min(np * 4096, shdr[i].sh_size - (ofs - shdr[i].sh_offset));
    21b8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    21bb:	89 d0                	mov    eax,edx
    21bd:	c1 e0 02             	shl    eax,0x2
    21c0:	01 d0                	add    eax,edx
    21c2:	c1 e0 03             	shl    eax,0x3
    21c5:	89 c2                	mov    edx,eax
    21c7:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    21ca:	01 d0                	add    eax,edx
    21cc:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
    21cf:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    21d2:	89 d0                	mov    eax,edx
    21d4:	c1 e0 02             	shl    eax,0x2
    21d7:	01 d0                	add    eax,edx
    21d9:	c1 e0 03             	shl    eax,0x3
    21dc:	89 c2                	mov    edx,eax
    21de:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    21e1:	01 d0                	add    eax,edx
    21e3:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    21e6:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
    21e9:	8d 14 01             	lea    edx,[ecx+eax*1]
    21ec:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    21ef:	c1 e0 0c             	shl    eax,0xc
    21f2:	39 c2                	cmp    edx,eax
    21f4:	0f 46 c2             	cmovbe eax,edx
    21f7:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
										mbprintf("n=%lu, ofs=%u\n", n, ofs);
    21fa:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    21fd:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2201:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2204:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2208:	c7 04 24 f7 07 00 00 	mov    DWORD PTR [esp],0x7f7
    220f:	e8 fc ff ff ff       	call   2210 <load_elf+0x6fc>
										if ((void*)addr > mapaddr)
    2214:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2217:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
    221a:	73 09                	jae    2225 <load_elf+0x711>
												n -= (size_t)addr - (size_t)mapaddr;
    221c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    221f:	2b 45 ec             	sub    eax,DWORD PTR [ebp-0x14]
    2222:	01 45 d4             	add    DWORD PTR [ebp-0x2c],eax
										memcpy((void*)addr, (void*)hdr + ofs, n);
    2225:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2228:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    222b:	8d 0c 02             	lea    ecx,[edx+eax*1]
    222e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2231:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2234:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2238:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    223c:	89 04 24             	mov    DWORD PTR [esp],eax
    223f:	e8 bc dd ff ff       	call   0 <memcpy>
										mbprintf("copying %lu bytes to %p\n", n, (void*)addr);
    2244:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2247:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    224b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    224e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2252:	c7 04 24 06 08 00 00 	mov    DWORD PTR [esp],0x806
    2259:	e8 fc ff ff ff       	call   225a <load_elf+0x746>
										ofs += n;
    225e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2261:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
										addr += n;
    2264:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2267:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
										if (remap) {
    226a:	83 7d ac 00          	cmp    DWORD PTR [ebp-0x54],0x0
    226e:	74 30                	je     22a0 <load_elf+0x78c>
												flags &= ~MMGR_MAP_WRITE;
    2270:	83 65 d8 fb          	and    DWORD PTR [ebp-0x28],0xfffffffb
												mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags);
    2274:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2277:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    227b:	c7 44 24 0c 0a 00 00 00 	mov    DWORD PTR [esp+0xc],0xa
    2283:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    2289:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    228d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2290:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2294:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    229b:	e8 fc ff ff ff       	call   229c <load_elf+0x788>
										}
								}
								mapaddr += np * 4096;
    22a0:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    22a3:	c1 e0 0c             	shl    eax,0xc
    22a6:	01 45 e8             	add    DWORD PTR [ebp-0x18],eax
								pg_ct -= np;
    22a9:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    22ac:	29 45 f0             	sub    DWORD PTR [ebp-0x10],eax
						while (pg_ct) {
    22af:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    22b3:	0f 85 f1 fd ff ff    	jne    20aa <load_elf+0x596>
    22b9:	eb 01                	jmp    22bc <load_elf+0x7a8>
						continue;
    22bb:	90                   	nop
		for (i = 0; i < hdr->e_shnum; i++) {
    22bc:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    22c0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    22c3:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    22c7:	0f b7 c0             	movzx  eax,ax
    22ca:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    22cd:	0f 82 b0 f9 ff ff    	jb     1c83 <load_elf+0x16f>
				}
#endif
		}

		/* Now determine the symbol values*/
		for (i = 0; i < hdr->e_shnum; i++)
    22d3:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    22da:	e9 4f 01 00 00       	jmp    242e <load_elf+0x91a>
				if (shdr[i].sh_type == SHT_SYMTAB) {
    22df:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    22e2:	89 d0                	mov    eax,edx
    22e4:	c1 e0 02             	shl    eax,0x2
    22e7:	01 d0                	add    eax,edx
    22e9:	c1 e0 03             	shl    eax,0x3
    22ec:	89 c2                	mov    edx,eax
    22ee:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    22f1:	01 d0                	add    eax,edx
    22f3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22f6:	83 f8 02             	cmp    eax,0x2
    22f9:	0f 85 2b 01 00 00    	jne    242a <load_elf+0x916>
						void* vm_bss = mi->vm_ofs[MT_SEC_BSS] + mi->sz_secs[MT_SEC_BSS];
    22ff:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2302:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
    2305:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2308:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    230b:	01 d0                	add    eax,edx
    230d:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
						void* vm_aold = vm_bss + (((size_t)vm_bss % 4096) ? (4096 - ((size_t)vm_bss % 4096)) : 0);
    2310:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    2313:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    2316:	25 ff 0f 00 00       	and    eax,0xfff
    231b:	85 c0                	test   eax,eax
    231d:	74 13                	je     2332 <load_elf+0x81e>
    231f:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    2322:	25 ff 0f 00 00       	and    eax,0xfff
    2327:	89 c1                	mov    ecx,eax
    2329:	b8 00 10 00 00       	mov    eax,0x1000
    232e:	29 c8                	sub    eax,ecx
    2330:	eb 05                	jmp    2337 <load_elf+0x823>
    2332:	b8 00 00 00 00       	mov    eax,0x0
    2337:	01 d0                	add    eax,edx
    2339:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
						elf_resolve_symbols(hdr, shdr, i, &vm_bss, mi);
    233c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    233f:	0f b7 c0             	movzx  eax,ax
    2342:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    2345:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    2349:	8d 55 a4             	lea    edx,[ebp-0x5c]
    234c:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2350:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2354:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2357:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    235b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    235e:	89 04 24             	mov    DWORD PTR [esp],eax
    2361:	e8 fc ff ff ff       	call   2362 <load_elf+0x84e>
						if (vm_bss > vm_aold) {
    2366:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    2369:	39 45 c0             	cmp    DWORD PTR [ebp-0x40],eax
    236c:	0f 83 b8 00 00 00    	jae    242a <load_elf+0x916>
								size_t pgc = 0; struct page_range pr[10];
    2372:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
								/* allocate new bss sections */
								pgc = vm_bss - vm_aold;
    2379:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    237c:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    237f:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
								pgc = pgc / 4096 + (pgc % 4096) ? 1 : 0;
    2382:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    2385:	c1 e8 0c             	shr    eax,0xc
    2388:	89 c2                	mov    edx,eax
    238a:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    238d:	25 ff 0f 00 00       	and    eax,0xfff
    2392:	01 d0                	add    eax,edx
    2394:	85 c0                	test   eax,eax
    2396:	0f 95 c0             	setne  al
    2399:	0f b6 c0             	movzx  eax,al
    239c:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
								if (mm_alloc_pm(pgc, pr, 10) == pgc) {
    239f:	c7 44 24 08 0a 00 00 00 	mov    DWORD PTR [esp+0x8],0xa
    23a7:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    23ad:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    23b1:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    23b4:	89 04 24             	mov    DWORD PTR [esp],eax
    23b7:	e8 fc ff ff ff       	call   23b8 <load_elf+0x8a4>
    23bc:	39 45 bc             	cmp    DWORD PTR [ebp-0x44],eax
    23bf:	75 5a                	jne    241b <load_elf+0x907>
										/* success */
										if (!mm_map(&mm_kernel, vm_aold, pr, 10, MMGR_MAP_WRITE | MMGR_MAP_KERNEL)) {
    23c1:	c7 44 24 10 0c 00 00 00 	mov    DWORD PTR [esp+0x10],0xc
    23c9:	c7 44 24 0c 0a 00 00 00 	mov    DWORD PTR [esp+0xc],0xa
    23d1:	8d 85 2c ff ff ff    	lea    eax,[ebp-0xd4]
    23d7:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    23db:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    23de:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    23e2:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    23e9:	e8 fc ff ff ff       	call   23ea <load_elf+0x8d6>
    23ee:	85 c0                	test   eax,eax
    23f0:	75 16                	jne    2408 <load_elf+0x8f4>
												printf("unable to map new bss pages to %p\n", vm_aold);
    23f2:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    23f5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    23f9:	c7 04 24 20 08 00 00 	mov    DWORD PTR [esp],0x820
    2400:	e8 fc ff ff ff       	call   2401 <load_elf+0x8ed>
												while (1);
    2405:	90                   	nop
    2406:	eb fd                	jmp    2405 <load_elf+0x8f1>
										}
										mi->sz_secs[MT_SEC_BSS] = vm_bss - mi->vm_ofs[MT_SEC_BSS];
    2408:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    240b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    240e:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2411:	29 c2                	sub    edx,eax
    2413:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2416:	89 50 38             	mov    DWORD PTR [eax+0x38],edx
    2419:	eb 0f                	jmp    242a <load_elf+0x916>
								} else {
										printf("failed to extend bss section\n");
    241b:	c7 04 24 43 08 00 00 	mov    DWORD PTR [esp],0x843
    2422:	e8 fc ff ff ff       	call   2423 <load_elf+0x90f>
										while (1);
    2427:	90                   	nop
    2428:	eb fd                	jmp    2427 <load_elf+0x913>
		for (i = 0; i < hdr->e_shnum; i++)
    242a:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    242e:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2431:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    2435:	0f b7 c0             	movzx  eax,ax
    2438:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    243b:	0f 82 9e fe ff ff    	jb     22df <load_elf+0x7cb>
								}
						}
				}

		/* and perform the relocations */
		for (i = 0; i < hdr->e_shnum; i++)
    2441:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2448:	e9 33 02 00 00       	jmp    2680 <load_elf+0xb6c>
				if (shdr[i].sh_type == SHT_REL || shdr[i].sh_type == SHT_RELA) {
    244d:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2450:	89 d0                	mov    eax,edx
    2452:	c1 e0 02             	shl    eax,0x2
    2455:	01 d0                	add    eax,edx
    2457:	c1 e0 03             	shl    eax,0x3
    245a:	89 c2                	mov    edx,eax
    245c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    245f:	01 d0                	add    eax,edx
    2461:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2464:	83 f8 09             	cmp    eax,0x9
    2467:	74 20                	je     2489 <load_elf+0x975>
    2469:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    246c:	89 d0                	mov    eax,edx
    246e:	c1 e0 02             	shl    eax,0x2
    2471:	01 d0                	add    eax,edx
    2473:	c1 e0 03             	shl    eax,0x3
    2476:	89 c2                	mov    edx,eax
    2478:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    247b:	01 d0                	add    eax,edx
    247d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2480:	83 f8 04             	cmp    eax,0x4
    2483:	0f 85 f3 01 00 00    	jne    267c <load_elf+0xb68>
						if (shdr[shdr[i].sh_info].sh_flags & SHF_ALLOC) {
    2489:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    248c:	89 d0                	mov    eax,edx
    248e:	c1 e0 02             	shl    eax,0x2
    2491:	01 d0                	add    eax,edx
    2493:	c1 e0 03             	shl    eax,0x3
    2496:	89 c2                	mov    edx,eax
    2498:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    249b:	01 d0                	add    eax,edx
    249d:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    24a0:	89 d0                	mov    eax,edx
    24a2:	c1 e0 02             	shl    eax,0x2
    24a5:	01 d0                	add    eax,edx
    24a7:	c1 e0 03             	shl    eax,0x3
    24aa:	89 c2                	mov    edx,eax
    24ac:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    24af:	01 d0                	add    eax,edx
    24b1:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    24b4:	83 e0 02             	and    eax,0x2
    24b7:	85 c0                	test   eax,eax
    24b9:	0f 84 bd 01 00 00    	je     267c <load_elf+0xb68>
								void* vm_begin = (void*)shdr[shdr[i].sh_info].sh_addr;
    24bf:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    24c2:	89 d0                	mov    eax,edx
    24c4:	c1 e0 02             	shl    eax,0x2
    24c7:	01 d0                	add    eax,edx
    24c9:	c1 e0 03             	shl    eax,0x3
    24cc:	89 c2                	mov    edx,eax
    24ce:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    24d1:	01 d0                	add    eax,edx
    24d3:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    24d6:	89 d0                	mov    eax,edx
    24d8:	c1 e0 02             	shl    eax,0x2
    24db:	01 d0                	add    eax,edx
    24dd:	c1 e0 03             	shl    eax,0x3
    24e0:	89 c2                	mov    edx,eax
    24e2:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    24e5:	01 d0                	add    eax,edx
    24e7:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    24ea:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
								size_t pgc = shdr[shdr[i].sh_info].sh_size;
    24ed:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    24f0:	89 d0                	mov    eax,edx
    24f2:	c1 e0 02             	shl    eax,0x2
    24f5:	01 d0                	add    eax,edx
    24f7:	c1 e0 03             	shl    eax,0x3
    24fa:	89 c2                	mov    edx,eax
    24fc:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    24ff:	01 d0                	add    eax,edx
    2501:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    2504:	89 d0                	mov    eax,edx
    2506:	c1 e0 02             	shl    eax,0x2
    2509:	01 d0                	add    eax,edx
    250b:	c1 e0 03             	shl    eax,0x3
    250e:	89 c2                	mov    edx,eax
    2510:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2513:	01 d0                	add    eax,edx
    2515:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2518:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
								pgc = pgc / 4096 + ((pgc % 4096) ? 1 : 0);
    251b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    251e:	c1 e8 0c             	shr    eax,0xc
    2521:	89 c2                	mov    edx,eax
    2523:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2526:	25 ff 0f 00 00       	and    eax,0xfff
    252b:	85 c0                	test   eax,eax
    252d:	74 07                	je     2536 <load_elf+0xa22>
    252f:	b8 01 00 00 00       	mov    eax,0x1
    2534:	eb 05                	jmp    253b <load_elf+0xa27>
    2536:	b8 00 00 00 00       	mov    eax,0x0
    253b:	01 d0                	add    eax,edx
    253d:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
								printf("performing relocations on section %s:\n",
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[shdr[i].sh_info].sh_name));
    2540:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2543:	89 d0                	mov    eax,edx
    2545:	c1 e0 02             	shl    eax,0x2
    2548:	01 d0                	add    eax,edx
    254a:	c1 e0 03             	shl    eax,0x3
    254d:	89 c2                	mov    edx,eax
    254f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2552:	01 d0                	add    eax,edx
    2554:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    2557:	89 d0                	mov    eax,edx
    2559:	c1 e0 02             	shl    eax,0x2
    255c:	01 d0                	add    eax,edx
    255e:	c1 e0 03             	shl    eax,0x3
    2561:	89 c2                	mov    edx,eax
    2563:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2566:	01 d0                	add    eax,edx
								printf("performing relocations on section %s:\n",
    2568:	8b 10                	mov    edx,DWORD PTR [eax]
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[shdr[i].sh_info].sh_name));
    256a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    256d:	0f b7 40 32          	movzx  eax,WORD PTR [eax+0x32]
								printf("performing relocations on section %s:\n",
    2571:	0f b7 c0             	movzx  eax,ax
    2574:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2578:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    257c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    257f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2583:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2586:	89 04 24             	mov    DWORD PTR [esp],eax
    2589:	e8 fc ff ff ff       	call   258a <load_elf+0xa76>
    258e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2592:	c7 04 24 64 08 00 00 	mov    DWORD PTR [esp],0x864
    2599:	e8 fc ff ff ff       	call   259a <load_elf+0xa86>
								/* unguard the section */
								printf("modifying %lu pages at %p\n", pgc, vm_begin);
    259e:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    25a1:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    25a5:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    25a8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    25ac:	c7 04 24 8b 08 00 00 	mov    DWORD PTR [esp],0x88b
    25b3:	e8 fc ff ff ff       	call   25b4 <load_elf+0xaa0>
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
    25b8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    25bb:	89 d0                	mov    eax,edx
    25bd:	c1 e0 02             	shl    eax,0x2
    25c0:	01 d0                	add    eax,edx
    25c2:	c1 e0 03             	shl    eax,0x3
    25c5:	89 c2                	mov    edx,eax
    25c7:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    25ca:	01 d0                	add    eax,edx
    25cc:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    25cf:	89 d0                	mov    eax,edx
    25d1:	c1 e0 02             	shl    eax,0x2
    25d4:	01 d0                	add    eax,edx
    25d6:	c1 e0 03             	shl    eax,0x3
    25d9:	89 c2                	mov    edx,eax
    25db:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    25de:	01 d0                	add    eax,edx
    25e0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    25e3:	83 e0 01             	and    eax,0x1
    25e6:	85 c0                	test   eax,eax
    25e8:	75 22                	jne    260c <load_elf+0xaf8>
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_SET);
    25ea:	c7 44 24 0c 04 10 00 00 	mov    DWORD PTR [esp+0xc],0x1004
    25f2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    25f5:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    25f9:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    25fc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2600:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2607:	e8 fc ff ff ff       	call   2608 <load_elf+0xaf4>
								/* relocate */
								elf_relocate_section(hdr, shdr, i);
    260c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    260f:	0f b7 c0             	movzx  eax,ax
    2612:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2616:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2619:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    261d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2620:	89 04 24             	mov    DWORD PTR [esp],eax
    2623:	e8 fc ff ff ff       	call   2624 <load_elf+0xb10>
								/* reguard the section */
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
    2628:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    262b:	89 d0                	mov    eax,edx
    262d:	c1 e0 02             	shl    eax,0x2
    2630:	01 d0                	add    eax,edx
    2632:	c1 e0 03             	shl    eax,0x3
    2635:	89 c2                	mov    edx,eax
    2637:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    263a:	01 d0                	add    eax,edx
    263c:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    263f:	89 d0                	mov    eax,edx
    2641:	c1 e0 02             	shl    eax,0x2
    2644:	01 d0                	add    eax,edx
    2646:	c1 e0 03             	shl    eax,0x3
    2649:	89 c2                	mov    edx,eax
    264b:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    264e:	01 d0                	add    eax,edx
    2650:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2653:	83 e0 01             	and    eax,0x1
    2656:	85 c0                	test   eax,eax
    2658:	75 22                	jne    267c <load_elf+0xb68>
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_UNSET);
    265a:	c7 44 24 0c 04 20 00 00 	mov    DWORD PTR [esp+0xc],0x2004
    2662:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2665:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2669:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    266c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2670:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2677:	e8 fc ff ff ff       	call   2678 <load_elf+0xb64>
		for (i = 0; i < hdr->e_shnum; i++)
    267c:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    2680:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2683:	0f b7 40 30          	movzx  eax,WORD PTR [eax+0x30]
    2687:	0f b7 c0             	movzx  eax,ax
    268a:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    268d:	0f 82 ba fd ff ff    	jb     244d <load_elf+0x939>
						}
				}

		/* page-align for the next module */
		/* DBG: and insert a guard-page */
		for (i = 0; i < 4; i++) {
    2693:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    269a:	e9 94 00 00 00       	jmp    2733 <load_elf+0xc1f>
				if (mi->sz_secs[i]) {
    269f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    26a2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    26a5:	83 c2 08             	add    edx,0x8
    26a8:	8b 44 90 0c          	mov    eax,DWORD PTR [eax+edx*4+0xc]
    26ac:	85 c0                	test   eax,eax
    26ae:	74 7f                	je     272f <load_elf+0xc1b>
						mod_tbl.vm_ofs[i] = mi->vm_ofs[i] + mi->sz_secs[i];
    26b0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    26b3:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    26b6:	83 c2 04             	add    edx,0x4
    26b9:	8b 54 90 0c          	mov    edx,DWORD PTR [eax+edx*4+0xc]
    26bd:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    26c0:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    26c3:	83 c1 08             	add    ecx,0x8
    26c6:	8b 44 88 0c          	mov    eax,DWORD PTR [eax+ecx*4+0xc]
    26ca:	01 c2                	add    edx,eax
    26cc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    26cf:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						if ((size_t)mod_tbl.vm_ofs[i] % 4096) {
    26d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    26d9:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    26e0:	25 ff 0f 00 00       	and    eax,0xfff
    26e5:	85 c0                	test   eax,eax
    26e7:	74 2c                	je     2715 <load_elf+0xc01>
								/* section align */
								mod_tbl.vm_ofs[i] += 4096 - (size_t)mod_tbl.vm_ofs[i] % 4096;
    26e9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    26ec:	8b 14 85 00 00 00 00 	mov    edx,DWORD PTR [eax*4+0x0]
    26f3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    26f6:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    26fd:	25 ff 0f 00 00       	and    eax,0xfff
    2702:	b9 00 10 00 00       	mov    ecx,0x1000
    2707:	29 c1                	sub    ecx,eax
    2709:	01 ca                	add    edx,ecx
    270b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    270e:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
						}
						/* add guard page */
						mod_tbl.vm_ofs[i] += 4096;
    2715:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2718:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
    271f:	8d 90 00 10 00 00    	lea    edx,[eax+0x1000]
    2725:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2728:	89 14 85 00 00 00 00 	mov    DWORD PTR [eax*4+0x0],edx
		for (i = 0; i < 4; i++) {
    272f:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    2733:	83 7d f4 03          	cmp    DWORD PTR [ebp-0xc],0x3
    2737:	0f 86 62 ff ff ff    	jbe    269f <load_elf+0xb8b>
				}
		}

		return ELF_OK;
    273d:	b8 00 00 00 00       	mov    eax,0x0
}
    2742:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2745:	c9                   	leave
    2746:	c3                   	ret

00002747 <get_elferr_string>:

const char* get_elferr_string(enum elferr e)
{
    2747:	55                   	push   ebp
    2748:	89 e5                	mov    ebp,esp
		switch (e) {
    274a:	83 7d 08 11          	cmp    DWORD PTR [ebp+0x8],0x11
    274e:	0f 87 86 00 00 00    	ja     27da <get_elferr_string+0x93>
    2754:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2757:	c1 e0 02             	shl    eax,0x2
    275a:	05 e4 0a 00 00       	add    eax,0xae4
    275f:	8b 00                	mov    eax,DWORD PTR [eax]
    2761:	ff e0                	jmp    eax
		case ELF_WRONG_MAGIC:
				return "not ELF file";
    2763:	b8 a6 08 00 00       	mov    eax,0x8a6
    2768:	eb 75                	jmp    27df <get_elferr_string+0x98>
		case ELF_NOT_CLASS32:
				return "not a 32-bit ELF file";
    276a:	b8 b3 08 00 00       	mov    eax,0x8b3
    276f:	eb 6e                	jmp    27df <get_elferr_string+0x98>
		case ELF_NOMEM:
				return "out of memory";
    2771:	b8 c9 08 00 00       	mov    eax,0x8c9
    2776:	eb 67                	jmp    27df <get_elferr_string+0x98>
		case ELF_NOT_LE:
				return "not a little-endian file";
    2778:	b8 d7 08 00 00       	mov    eax,0x8d7
    277d:	eb 60                	jmp    27df <get_elferr_string+0x98>
		case ELF_VERSION_NOT_SUPPORTED:
				return "unsupported ELF version";
    277f:	b8 f0 08 00 00       	mov    eax,0x8f0
    2784:	eb 59                	jmp    27df <get_elferr_string+0x98>
		case ELF_WRONG_OSABI:
				return "unsupported OS ABI";
    2786:	b8 08 09 00 00       	mov    eax,0x908
    278b:	eb 52                	jmp    27df <get_elferr_string+0x98>
		case ELF_NOT_REL:
				return "modules have to be relocatable object files";
    278d:	b8 1c 09 00 00       	mov    eax,0x91c
    2792:	eb 4b                	jmp    27df <get_elferr_string+0x98>
		case ELF_NOT_386:
				return "only i386 modules can be loaded";
    2794:	b8 48 09 00 00       	mov    eax,0x948
    2799:	eb 44                	jmp    27df <get_elferr_string+0x98>
		case ELF_INCOMPATIBLE_HEADER:
				return "unexpected size of ELF header";
    279b:	b8 68 09 00 00       	mov    eax,0x968
    27a0:	eb 3d                	jmp    27df <get_elferr_string+0x98>
		case ELF_CONTAINS_PROG_HEADERS:
				return "ELF contains program heades (no object file)";
    27a2:	b8 88 09 00 00       	mov    eax,0x988
    27a7:	eb 36                	jmp    27df <get_elferr_string+0x98>
		case ELF_NO_SECTIONS_DEFINED:
				return "ELF contains no defined sections";
    27a9:	b8 b8 09 00 00       	mov    eax,0x9b8
    27ae:	eb 2f                	jmp    27df <get_elferr_string+0x98>
		case ELF_WRONG_SHDR_SIZE:
				return "no matching ELF section header size";
    27b0:	b8 dc 09 00 00       	mov    eax,0x9dc
    27b5:	eb 28                	jmp    27df <get_elferr_string+0x98>
		case ELF_NO_SECTION_STRTAB:
				return "no ELF STRTAB for section names";
    27b7:	b8 00 0a 00 00       	mov    eax,0xa00
    27bc:	eb 21                	jmp    27df <get_elferr_string+0x98>
		case ELF_SECTION_RWX:
				return "module contains rwx secton";
    27be:	b8 20 0a 00 00       	mov    eax,0xa20
    27c3:	eb 1a                	jmp    27df <get_elferr_string+0x98>
		case ELF_GSTAB_ALREADY_PRESENT:
				return "the global symbol table has already been loaded";
    27c5:	b8 3c 0a 00 00       	mov    eax,0xa3c
    27ca:	eb 13                	jmp    27df <get_elferr_string+0x98>
		case ELF_STRING_PARSE_NUMBER:
				return "the string parser expected a number but found none";
    27cc:	b8 6c 0a 00 00       	mov    eax,0xa6c
    27d1:	eb 0c                	jmp    27df <get_elferr_string+0x98>
		case ELF_PARSE_FORMAT_NOT_NM:
				return "the provided symbol mapping file is not in the nm format";
    27d3:	b8 a0 0a 00 00       	mov    eax,0xaa0
    27d8:	eb 05                	jmp    27df <get_elferr_string+0x98>
		default:
				return "unknown";
    27da:	b8 d9 0a 00 00       	mov    eax,0xad9
		}
}
    27df:	5d                   	pop    ebp
    27e0:	c3                   	ret

000027e1 <elf_parse_global_symtab>:

enum elferr elf_parse_global_symtab(void* addr, size_t sz)
{
    27e1:	55                   	push   ebp
    27e2:	89 e5                	mov    ebp,esp
    27e4:	53                   	push   ebx
    27e5:	83 ec 34             	sub    esp,0x34
		const char* str = (const char*)addr; size_t cap = 64;
    27e8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    27eb:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    27ee:	c7 45 f4 40 00 00 00 	mov    DWORD PTR [ebp-0xc],0x40
		struct symbol_list* sl;
		if (gs_lst)
    27f5:	a1 00 00 00 00       	mov    eax,ds:0x0
    27fa:	85 c0                	test   eax,eax
    27fc:	74 0a                	je     2808 <elf_parse_global_symtab+0x27>
				return ELF_GSTAB_ALREADY_PRESENT;
    27fe:	b8 0f 00 00 00       	mov    eax,0xf
    2803:	e9 7c 02 00 00       	jmp    2a84 <elf_parse_global_symtab+0x2a3>

		/* allocate the initial capacity */
		sl = gs_lst = kmalloc(sizeof(struct symbol_list));
    2808:	c7 04 24 04 03 00 00 	mov    DWORD PTR [esp],0x304
    280f:	e8 fc ff ff ff       	call   2810 <elf_parse_global_symtab+0x2f>
    2814:	a3 00 00 00 00       	mov    ds:0x0,eax
    2819:	a1 00 00 00 00       	mov    eax,ds:0x0
    281e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!sl)
    2821:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2825:	75 0a                	jne    2831 <elf_parse_global_symtab+0x50>
				return ELF_NOMEM;
    2827:	b8 04 00 00 00       	mov    eax,0x4
    282c:	e9 53 02 00 00       	jmp    2a84 <elf_parse_global_symtab+0x2a3>
		sl->next = NULL;
    2831:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2834:	c7 80 00 03 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x300],0x0

		while ((size_t)((void*)str - addr) < sz) {
    283e:	e9 e8 01 00 00       	jmp    2a2b <elf_parse_global_symtab+0x24a>
				const char* s1 = str; char *s2; char tp = ' ';
    2843:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2846:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2849:	c6 45 eb 20          	mov    BYTE PTR [ebp-0x15],0x20
				long val = strtol(str, (char**)&str, 16);
    284d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2850:	c7 44 24 08 10 00 00 00 	mov    DWORD PTR [esp+0x8],0x10
    2858:	8d 55 dc             	lea    edx,[ebp-0x24]
    285b:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    285f:	89 04 24             	mov    DWORD PTR [esp],eax
    2862:	e8 fc ff ff ff       	call   2863 <elf_parse_global_symtab+0x82>
    2867:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				
				if (s1 == str)
    286a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    286d:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
    2870:	75 0a                	jne    287c <elf_parse_global_symtab+0x9b>
						return ELF_STRING_PARSE_NUMBER;
    2872:	b8 10 00 00 00       	mov    eax,0x10
    2877:	e9 08 02 00 00       	jmp    2a84 <elf_parse_global_symtab+0x2a3>
				if (*str++ != ' ')
    287c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    287f:	8d 50 01             	lea    edx,[eax+0x1]
    2882:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    2885:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2888:	3c 20                	cmp    al,0x20
    288a:	74 0a                	je     2896 <elf_parse_global_symtab+0xb5>
						return ELF_PARSE_FORMAT_NOT_NM;
    288c:	b8 11 00 00 00       	mov    eax,0x11
    2891:	e9 ee 01 00 00       	jmp    2a84 <elf_parse_global_symtab+0x2a3>
				tp = *str++;
    2896:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2899:	8d 50 01             	lea    edx,[eax+0x1]
    289c:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    289f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    28a2:	88 45 eb             	mov    BYTE PTR [ebp-0x15],al
				if (*str++ != ' ')
    28a5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    28a8:	8d 50 01             	lea    edx,[eax+0x1]
    28ab:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    28ae:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    28b1:	3c 20                	cmp    al,0x20
    28b3:	74 0a                	je     28bf <elf_parse_global_symtab+0xde>
						return ELF_PARSE_FORMAT_NOT_NM;
    28b5:	b8 11 00 00 00       	mov    eax,0x11
    28ba:	e9 c5 01 00 00       	jmp    2a84 <elf_parse_global_symtab+0x2a3>
				s1 = strchr(str, '\n');
    28bf:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    28c2:	c7 44 24 04 0a 00 00 00 	mov    DWORD PTR [esp+0x4],0xa
    28ca:	89 04 24             	mov    DWORD PTR [esp],eax
    28cd:	e8 fc ff ff ff       	call   28ce <elf_parse_global_symtab+0xed>
    28d2:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!s1) {
    28d5:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    28d9:	75 17                	jne    28f2 <elf_parse_global_symtab+0x111>
						printf("strchr!\n");
    28db:	c7 04 24 2c 0b 00 00 	mov    DWORD PTR [esp],0xb2c
    28e2:	e8 fc ff ff ff       	call   28e3 <elf_parse_global_symtab+0x102>
						s1 = (const char*)(addr + sz);
    28e7:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    28ea:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    28ed:	01 d0                	add    eax,edx
    28ef:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				}
				s2 = strndup(str, s1 - str);
    28f2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    28f5:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    28f8:	29 c2                	sub    edx,eax
    28fa:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    28fd:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2901:	89 04 24             	mov    DWORD PTR [esp],eax
    2904:	e8 fc ff ff ff       	call   2905 <elf_parse_global_symtab+0x124>
    2909:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax

				/*printf("symbol at %p: \"%s\" type %c\n", (void*)val, s2, tp);------------------*/
				if (strcmp(s2, "printf") == 0)
    290c:	c7 44 24 04 35 0b 00 00 	mov    DWORD PTR [esp+0x4],0xb35
    2914:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2917:	89 04 24             	mov    DWORD PTR [esp],eax
    291a:	e8 fc ff ff ff       	call   291b <elf_parse_global_symtab+0x13a>
    291f:	85 c0                	test   eax,eax
    2921:	75 45                	jne    2968 <elf_parse_global_symtab+0x187>
						if (&printf != (void*)val) {
    2923:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2926:	3d 00 00 00 00       	cmp    eax,0x0
    292b:	74 3b                	je     2968 <elf_parse_global_symtab+0x187>
								cprintf(KFMT_WARN, "WARNING! Loaded outdated symtab!\n");
    292d:	c7 44 24 04 3c 0b 00 00 	mov    DWORD PTR [esp+0x4],0xb3c
    2935:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    293c:	e8 fc ff ff ff       	call   293d <elf_parse_global_symtab+0x15c>
								printf("printf is located at %p but symtab says it's at %p\n",
    2941:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2944:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2948:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2950:	c7 04 24 60 0b 00 00 	mov    DWORD PTR [esp],0xb60
    2957:	e8 fc ff ff ff       	call   2958 <elf_parse_global_symtab+0x177>
												&printf, (void*)val);
								printf("expect modules to fail randomly as the\n"
    295c:	c7 04 24 94 0b 00 00 	mov    DWORD PTR [esp],0xb94
    2963:	e8 fc ff ff ff       	call   2964 <elf_parse_global_symtab+0x183>
									   "symbols used therein will not be resolved correctly\n");
						}

				/* expand the capacity if needed */
				if (!cap) {
    2968:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    296c:	75 52                	jne    29c0 <elf_parse_global_symtab+0x1df>
						sl->next = kmalloc(sizeof(struct symbol_list));
    296e:	c7 04 24 04 03 00 00 	mov    DWORD PTR [esp],0x304
    2975:	e8 fc ff ff ff       	call   2976 <elf_parse_global_symtab+0x195>
    297a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    297d:	89 82 00 03 00 00    	mov    DWORD PTR [edx+0x300],eax
						if (!sl) {
    2983:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2987:	75 17                	jne    29a0 <elf_parse_global_symtab+0x1bf>
								cprintf(KFMT_ERROR, "Out of memory for parsing global symbol table\n");
    2989:	c7 44 24 04 f0 0b 00 00 	mov    DWORD PTR [esp+0x4],0xbf0
    2991:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2998:	e8 fc ff ff ff       	call   2999 <elf_parse_global_symtab+0x1b8>
								while (1);
    299d:	90                   	nop
    299e:	eb fd                	jmp    299d <elf_parse_global_symtab+0x1bc>
						}
						sl = sl->next;
    29a0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    29a3:	8b 80 00 03 00 00    	mov    eax,DWORD PTR [eax+0x300]
    29a9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						sl->next = NULL;
    29ac:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    29af:	c7 80 00 03 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x300],0x0
						cap = 64;
    29b9:	c7 45 f4 40 00 00 00 	mov    DWORD PTR [ebp-0xc],0x40
				}

				/* store the two values */
				sl->entries[64 - cap].name = s2;
    29c0:	b8 40 00 00 00       	mov    eax,0x40
    29c5:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    29c8:	89 c2                	mov    edx,eax
    29ca:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    29cd:	89 d0                	mov    eax,edx
    29cf:	01 c0                	add    eax,eax
    29d1:	01 d0                	add    eax,edx
    29d3:	c1 e0 02             	shl    eax,0x2
    29d6:	01 c8                	add    eax,ecx
    29d8:	8d 50 04             	lea    edx,[eax+0x4]
    29db:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    29de:	89 02                	mov    DWORD PTR [edx],eax
				sl->entries[64 - cap].vma = (void*)val;
    29e0:	b8 40 00 00 00       	mov    eax,0x40
    29e5:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    29e8:	89 c2                	mov    edx,eax
    29ea:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    29ed:	8b 5d f0             	mov    ebx,DWORD PTR [ebp-0x10]
    29f0:	89 d0                	mov    eax,edx
    29f2:	01 c0                	add    eax,eax
    29f4:	01 d0                	add    eax,edx
    29f6:	c1 e0 02             	shl    eax,0x2
    29f9:	01 d8                	add    eax,ebx
    29fb:	89 08                	mov    DWORD PTR [eax],ecx
				sl->entries[64 - cap].type = tp;
    29fd:	b8 40 00 00 00       	mov    eax,0x40
    2a02:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    2a05:	89 c2                	mov    edx,eax
    2a07:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    2a0a:	89 d0                	mov    eax,edx
    2a0c:	01 c0                	add    eax,eax
    2a0e:	01 d0                	add    eax,edx
    2a10:	c1 e0 02             	shl    eax,0x2
    2a13:	01 c8                	add    eax,ecx
    2a15:	8d 50 08             	lea    edx,[eax+0x8]
    2a18:	0f b6 45 eb          	movzx  eax,BYTE PTR [ebp-0x15]
    2a1c:	88 02                	mov    BYTE PTR [edx],al
				cap--;
    2a1e:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
				/* and advance */
				str = s1 + 1;
    2a22:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2a25:	83 c0 01             	add    eax,0x1
    2a28:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		while ((size_t)((void*)str - addr) < sz) {
    2a2b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2a2e:	2b 45 08             	sub    eax,DWORD PTR [ebp+0x8]
    2a31:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    2a34:	0f 82 09 fe ff ff    	jb     2843 <elf_parse_global_symtab+0x62>
		}

		/* zero-terminate not fully used lists */
		if (cap) {
    2a3a:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2a3e:	74 3f                	je     2a7f <elf_parse_global_symtab+0x29e>
				sl->entries[64 - cap].name = NULL;
    2a40:	b8 40 00 00 00       	mov    eax,0x40
    2a45:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    2a48:	89 c2                	mov    edx,eax
    2a4a:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    2a4d:	89 d0                	mov    eax,edx
    2a4f:	01 c0                	add    eax,eax
    2a51:	01 d0                	add    eax,edx
    2a53:	c1 e0 02             	shl    eax,0x2
    2a56:	01 c8                	add    eax,ecx
    2a58:	83 c0 04             	add    eax,0x4
    2a5b:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				sl->entries[64 - cap].vma = NULL;
    2a61:	b8 40 00 00 00       	mov    eax,0x40
    2a66:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    2a69:	89 c2                	mov    edx,eax
    2a6b:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    2a6e:	89 d0                	mov    eax,edx
    2a70:	01 c0                	add    eax,eax
    2a72:	01 d0                	add    eax,edx
    2a74:	c1 e0 02             	shl    eax,0x2
    2a77:	01 c8                	add    eax,ecx
    2a79:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		}
		return ELF_OK;
    2a7f:	b8 00 00 00 00       	mov    eax,0x0
}
    2a84:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2a87:	c9                   	leave
    2a88:	c3                   	ret

00002a89 <load_modules>:

void load_modules()
{
    2a89:	55                   	push   ebp
    2a8a:	89 e5                	mov    ebp,esp
    2a8c:	57                   	push   edi
    2a8d:	83 ec 74             	sub    esp,0x74
		void* mem = (void*)0x200000;
    2a90:	c7 45 f4 00 00 20 00 	mov    DWORD PTR [ebp-0xc],0x200000
		uint32_t mct = *(uint32_t*)mem;
    2a97:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a9a:	8b 00                	mov    eax,DWORD PTR [eax]
    2a9c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		enum elferr ee;
		mem += sizeof(uint32_t);
    2a9f:	83 45 f4 04          	add    DWORD PTR [ebp-0xc],0x4

		if (strcmp(mem, "LD.MAP") != 0) {
    2aa3:	c7 44 24 04 1f 0c 00 00 	mov    DWORD PTR [esp+0x4],0xc1f
    2aab:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2aae:	89 04 24             	mov    DWORD PTR [esp],eax
    2ab1:	e8 fc ff ff ff       	call   2ab2 <load_modules+0x29>
    2ab6:	85 c0                	test   eax,eax
    2ab8:	74 17                	je     2ad1 <load_modules+0x48>
				cprintf(KFMT_ERROR, "first file has to be global symbol map\n");
    2aba:	c7 44 24 04 28 0c 00 00 	mov    DWORD PTR [esp+0x4],0xc28
    2ac2:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2ac9:	e8 fc ff ff ff       	call   2aca <load_modules+0x41>
				while (1);
    2ace:	90                   	nop
    2acf:	eb fd                	jmp    2ace <load_modules+0x45>
		} else
				mem += 7;
    2ad1:	83 45 f4 07          	add    DWORD PTR [ebp-0xc],0x7
		/* parse the kernel symbol table supplied in nm format */
		if ((ee = elf_parse_global_symtab(mem + sizeof(uint32_t), *(uint32_t*)mem))) {
    2ad5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2ad8:	8b 00                	mov    eax,DWORD PTR [eax]
    2ada:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2add:	83 c2 04             	add    edx,0x4
    2ae0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2ae4:	89 14 24             	mov    DWORD PTR [esp],edx
    2ae7:	e8 fc ff ff ff       	call   2ae8 <load_modules+0x5f>
    2aec:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2aef:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2af3:	74 51                	je     2b46 <load_modules+0xbd>
				cprintf(KFMT_ERROR, "Failed to parse global kernel symbol table ("
    2af5:	c7 44 24 04 50 0c 00 00 	mov    DWORD PTR [esp+0x4],0xc50
    2afd:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2b04:	e8 fc ff ff ff       	call   2b05 <load_modules+0x7c>
					   "file ld.map in root directory)\n");
				cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
    2b09:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2b0c:	89 04 24             	mov    DWORD PTR [esp],eax
    2b0f:	e8 fc ff ff ff       	call   2b10 <load_modules+0x87>
    2b14:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2b18:	c7 44 24 04 9c 0c 00 00 	mov    DWORD PTR [esp+0x4],0xc9c
    2b20:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2b27:	e8 fc ff ff ff       	call   2b28 <load_modules+0x9f>
				memdump(mem + sizeof(uint32_t), *(uint32_t*)mem);
    2b2c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2b2f:	8b 00                	mov    eax,DWORD PTR [eax]
    2b31:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2b34:	83 c2 04             	add    edx,0x4
    2b37:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b3b:	89 14 24             	mov    DWORD PTR [esp],edx
    2b3e:	e8 fc ff ff ff       	call   2b3f <load_modules+0xb6>
				while (1);
    2b43:	90                   	nop
    2b44:	eb fd                	jmp    2b43 <load_modules+0xba>
		}
		mem += sizeof(uint32_t) + *(uint32_t*)mem;
    2b46:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2b49:	8b 00                	mov    eax,DWORD PTR [eax]
    2b4b:	83 c0 04             	add    eax,0x4
    2b4e:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		mct--;
    2b51:	83 6d f0 01          	sub    DWORD PTR [ebp-0x10],0x1

		/* try to load each module */
		while (mct--) {
    2b55:	e9 cc 01 00 00       	jmp    2d26 <load_modules+0x29d>
				const char* name = (const char*)mem;
    2b5a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2b5d:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				uint32_t sz;
				struct module_info mi = {0};
    2b60:	8d 55 a4             	lea    edx,[ebp-0x5c]
    2b63:	b8 00 00 00 00       	mov    eax,0x0
    2b68:	b9 0f 00 00 00       	mov    ecx,0xf
    2b6d:	89 d7                	mov    edi,edx
    2b6f:	f3 ab                	rep stos DWORD PTR es:[edi],eax
				mem += strlen(name) + 1;
    2b71:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2b74:	89 04 24             	mov    DWORD PTR [esp],eax
    2b77:	e8 fc ff ff ff       	call   2b78 <load_modules+0xef>
    2b7c:	83 c0 01             	add    eax,0x1
    2b7f:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
				sz = *(uint32_t*)mem;
    2b82:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2b85:	8b 00                	mov    eax,DWORD PTR [eax]
    2b87:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				mem += sizeof(uint32_t);
    2b8a:	83 45 f4 04          	add    DWORD PTR [ebp-0xc],0x4
				strncpy(mi.mi_name, name, 20);
    2b8e:	c7 44 24 08 14 00 00 00 	mov    DWORD PTR [esp+0x8],0x14
    2b96:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2b99:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b9d:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2ba0:	89 04 24             	mov    DWORD PTR [esp],eax
    2ba3:	e8 fc ff ff ff       	call   2ba4 <load_modules+0x11b>
				printf("loading module %.20s...\n", mi.mi_name);
    2ba8:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2bab:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2baf:	c7 04 24 a8 0c 00 00 	mov    DWORD PTR [esp],0xca8
    2bb6:	e8 fc ff ff ff       	call   2bb7 <load_modules+0x12e>
				if ((ee = load_elf(mem, sz, &mi))) {
    2bbb:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2bbe:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2bc2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2bc5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2bc9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2bcc:	89 04 24             	mov    DWORD PTR [esp],eax
    2bcf:	e8 fc ff ff ff       	call   2bd0 <load_modules+0x147>
    2bd4:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2bd7:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2bdb:	74 41                	je     2c1e <load_modules+0x195>
						cprintf(KFMT_ERROR, "Failed to load ELF module at %p\n", mem);
    2bdd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2be0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2be4:	c7 44 24 04 c4 0c 00 00 	mov    DWORD PTR [esp+0x4],0xcc4
    2bec:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2bf3:	e8 fc ff ff ff       	call   2bf4 <load_modules+0x16b>
						cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
    2bf8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2bfb:	89 04 24             	mov    DWORD PTR [esp],eax
    2bfe:	e8 fc ff ff ff       	call   2bff <load_modules+0x176>
    2c03:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2c07:	c7 44 24 04 9c 0c 00 00 	mov    DWORD PTR [esp+0x4],0xc9c
    2c0f:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2c16:	e8 fc ff ff ff       	call   2c17 <load_modules+0x18e>
						while (1);
    2c1b:	90                   	nop
    2c1c:	eb fd                	jmp    2c1b <load_modules+0x192>
				} else {
						int errc;
						cprintf(KFMT_INFO, "loaded module at the following offsets and sizes:\n");
    2c1e:	c7 44 24 04 e8 0c 00 00 	mov    DWORD PTR [esp+0x4],0xce8
    2c26:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2c2d:	e8 fc ff ff ff       	call   2c2e <load_modules+0x1a5>
						cprintf(KFMT_INFO, ".text    %p %11lu\n", mi.vm_ofs[0], mi.sz_secs[0]);
    2c32:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2c35:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    2c38:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2c3c:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2c40:	c7 44 24 04 1b 0d 00 00 	mov    DWORD PTR [esp+0x4],0xd1b
    2c48:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2c4f:	e8 fc ff ff ff       	call   2c50 <load_modules+0x1c7>
						cprintf(KFMT_INFO, ".data    %p %11lu\n", mi.vm_ofs[1], mi.sz_secs[1]);
    2c54:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2c57:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2c5a:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2c5e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2c62:	c7 44 24 04 2e 0d 00 00 	mov    DWORD PTR [esp+0x4],0xd2e
    2c6a:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2c71:	e8 fc ff ff ff       	call   2c72 <load_modules+0x1e9>
						cprintf(KFMT_INFO, ".rodata  %p %11lu\n", mi.vm_ofs[2], mi.sz_secs[2]);
    2c76:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2c79:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2c7c:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2c80:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2c84:	c7 44 24 04 41 0d 00 00 	mov    DWORD PTR [esp+0x4],0xd41
    2c8c:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2c93:	e8 fc ff ff ff       	call   2c94 <load_modules+0x20b>
						cprintf(KFMT_INFO, ".bss     %p %11lu\n", mi.vm_ofs[3], mi.sz_secs[3]);
    2c98:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2c9b:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2c9e:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2ca2:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2ca6:	c7 44 24 04 54 0d 00 00 	mov    DWORD PTR [esp+0x4],0xd54
    2cae:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2cb5:	e8 fc ff ff ff       	call   2cb6 <load_modules+0x22d>
						cprintf(KFMT_INFO, "calling module_init()...\n");
    2cba:	c7 44 24 04 67 0d 00 00 	mov    DWORD PTR [esp+0x4],0xd67
    2cc2:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    2cc9:	e8 fc ff ff ff       	call   2cca <load_modules+0x241>
						errc = mi.mi_init();
    2cce:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    2cd1:	ff d0                	call   eax
    2cd3:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						if (errc) {
    2cd6:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    2cda:	74 1e                	je     2cfa <load_modules+0x271>
								cprintf(KFMT_ERROR, "init failed with error %d\n", errc);
    2cdc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2cdf:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2ce3:	c7 44 24 04 81 0d 00 00 	mov    DWORD PTR [esp+0x4],0xd81
    2ceb:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2cf2:	e8 fc ff ff ff       	call   2cf3 <load_modules+0x26a>
								while (1);
    2cf7:	90                   	nop
    2cf8:	eb fd                	jmp    2cf7 <load_modules+0x26e>
						} else {
								cprintf(KFMT_OK, "successfully initialized module \"%s\"\n", mi.mi_name);
    2cfa:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2cfd:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2d01:	c7 44 24 04 9c 0d 00 00 	mov    DWORD PTR [esp+0x4],0xd9c
    2d09:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    2d10:	e8 fc ff ff ff       	call   2d11 <load_modules+0x288>
								store_module_info(&mi);
    2d15:	8d 45 a4             	lea    eax,[ebp-0x5c]
    2d18:	89 04 24             	mov    DWORD PTR [esp],eax
    2d1b:	e8 fc ff ff ff       	call   2d1c <load_modules+0x293>
						}
				}

				mem += sz;
    2d20:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2d23:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		while (mct--) {
    2d26:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2d29:	8d 50 ff             	lea    edx,[eax-0x1]
    2d2c:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    2d2f:	85 c0                	test   eax,eax
    2d31:	0f 85 23 fe ff ff    	jne    2b5a <load_modules+0xd1>
		}

		printf("done loading kernel modules\n");
    2d37:	c7 04 24 c2 0d 00 00 	mov    DWORD PTR [esp],0xdc2
    2d3e:	e8 fc ff ff ff       	call   2d3f <load_modules+0x2b6>
}
    2d43:	90                   	nop
    2d44:	8b 7d fc             	mov    edi,DWORD PTR [ebp-0x4]
    2d47:	c9                   	leave
    2d48:	c3                   	ret
