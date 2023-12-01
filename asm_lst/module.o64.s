
module.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <memcpy>:
						}
				}
		}
}

const char* get_section_type_string(Elf32_Word tp)
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 28          	sub    rsp,0x28
       8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
       c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      10:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
{
      14:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      18:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (tp == SHT_PROGBITS)
      1c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      20:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				return "PROGBITS";
      24:	eb 1d                	jmp    43 <memcpy+0x43>
		else if (tp == SHT_SYMTAB)
      26:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      2a:	48 8d 42 01          	lea    rax,[rdx+0x1]
      2e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      36:	48 8d 48 01          	lea    rcx,[rax+0x1]
      3a:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      3e:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      41:	88 10                	mov    BYTE PTR [rax],dl
				return "PROGBITS";
      43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      47:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      4b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      4f:	48 85 c0             	test   rax,rax
      52:	75 d2                	jne    26 <memcpy+0x26>
				return "SYMTAB";
      54:	90                   	nop
      55:	90                   	nop
      56:	c9                   	leave
      57:	c3                   	ret

0000000000000058 <elf_fetch_string>:
{
      58:	55                   	push   rbp
      59:	48 89 e5             	mov    rbp,rsp
      5c:	48 83 ec 18          	sub    rsp,0x18
      60:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
      64:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
      68:	89 d0                	mov    eax,edx
      6a:	89 4d e8             	mov    DWORD PTR [rbp-0x18],ecx
      6d:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
		if (!shdr[strtab].sh_size)
      71:	0f b7 55 ec          	movzx  edx,WORD PTR [rbp-0x14]
      75:	48 89 d0             	mov    rax,rdx
      78:	48 c1 e0 02          	shl    rax,0x2
      7c:	48 01 d0             	add    rax,rdx
      7f:	48 c1 e0 03          	shl    rax,0x3
      83:	48 89 c2             	mov    rdx,rax
      86:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      8a:	48 01 d0             	add    rax,rdx
      8d:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
      90:	85 c0                	test   eax,eax
      92:	75 0c                	jne    a0 <elf_fetch_string+0x48>
				return "";
      94:	48 c7 c0 00 00 00 00 	mov    rax,0x0
      9b:	e9 88 00 00 00       	jmp    128 <elf_fetch_string+0xd0>
		if (shdr[strtab].sh_type != SHT_STRTAB)
      a0:	0f b7 55 ec          	movzx  edx,WORD PTR [rbp-0x14]
      a4:	48 89 d0             	mov    rax,rdx
      a7:	48 c1 e0 02          	shl    rax,0x2
      ab:	48 01 d0             	add    rax,rdx
      ae:	48 c1 e0 03          	shl    rax,0x3
      b2:	48 89 c2             	mov    rdx,rax
      b5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      b9:	48 01 d0             	add    rax,rdx
      bc:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
      bf:	83 f8 03             	cmp    eax,0x3
      c2:	74 09                	je     cd <elf_fetch_string+0x75>
				return "no STRTAB referenced";
      c4:	48 c7 c0 00 00 00 00 	mov    rax,0x0
      cb:	eb 5b                	jmp    128 <elf_fetch_string+0xd0>
		if (str >= shdr[strtab].sh_size)
      cd:	0f b7 55 ec          	movzx  edx,WORD PTR [rbp-0x14]
      d1:	48 89 d0             	mov    rax,rdx
      d4:	48 c1 e0 02          	shl    rax,0x2
      d8:	48 01 d0             	add    rax,rdx
      db:	48 c1 e0 03          	shl    rax,0x3
      df:	48 89 c2             	mov    rdx,rax
      e2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      e6:	48 01 d0             	add    rax,rdx
      e9:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
      ec:	39 45 e8             	cmp    DWORD PTR [rbp-0x18],eax
      ef:	72 09                	jb     fa <elf_fetch_string+0xa2>
				return "STRTAB entry out of range";
      f1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
      f8:	eb 2e                	jmp    128 <elf_fetch_string+0xd0>
		return ((char*)hdr + shdr[strtab].sh_offset) + str;
      fa:	0f b7 55 ec          	movzx  edx,WORD PTR [rbp-0x14]
      fe:	48 89 d0             	mov    rax,rdx
     101:	48 c1 e0 02          	shl    rax,0x2
     105:	48 01 d0             	add    rax,rdx
     108:	48 c1 e0 03          	shl    rax,0x3
     10c:	48 89 c2             	mov    rdx,rax
     10f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     113:	48 01 d0             	add    rax,rdx
     116:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     119:	89 c2                	mov    edx,eax
     11b:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     11e:	48 01 c2             	add    rdx,rax
     121:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     125:	48 01 d0             	add    rax,rdx
}
     128:	c9                   	leave
     129:	c3                   	ret

000000000000012a <elf_dump_symtab>:
{
     12a:	55                   	push   rbp
     12b:	48 89 e5             	mov    rbp,rsp
     12e:	48 83 ec 60          	sub    rsp,0x60
     132:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
     136:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
     13a:	89 d0                	mov    eax,edx
     13c:	66 89 45 ac          	mov    WORD PTR [rbp-0x54],ax
		void* ptr = ((void*)hdr + shdr[symtab].sh_offset);
     140:	0f b7 55 ac          	movzx  edx,WORD PTR [rbp-0x54]
     144:	48 89 d0             	mov    rax,rdx
     147:	48 c1 e0 02          	shl    rax,0x2
     14b:	48 01 d0             	add    rax,rdx
     14e:	48 c1 e0 03          	shl    rax,0x3
     152:	48 89 c2             	mov    rdx,rax
     155:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     159:	48 01 d0             	add    rax,rdx
     15c:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     15f:	89 c2                	mov    edx,eax
     161:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     165:	48 01 d0             	add    rax,rdx
     168:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		size_t i, ct = shdr[symtab].sh_size / shdr[symtab].sh_entsize;
     16c:	0f b7 55 ac          	movzx  edx,WORD PTR [rbp-0x54]
     170:	48 89 d0             	mov    rax,rdx
     173:	48 c1 e0 02          	shl    rax,0x2
     177:	48 01 d0             	add    rax,rdx
     17a:	48 c1 e0 03          	shl    rax,0x3
     17e:	48 89 c2             	mov    rdx,rax
     181:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     185:	48 01 d0             	add    rax,rdx
     188:	8b 48 14             	mov    ecx,DWORD PTR [rax+0x14]
     18b:	0f b7 55 ac          	movzx  edx,WORD PTR [rbp-0x54]
     18f:	48 89 d0             	mov    rax,rdx
     192:	48 c1 e0 02          	shl    rax,0x2
     196:	48 01 d0             	add    rax,rdx
     199:	48 c1 e0 03          	shl    rax,0x3
     19d:	48 89 c2             	mov    rdx,rax
     1a0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     1a4:	48 01 d0             	add    rax,rdx
     1a7:	8b 78 24             	mov    edi,DWORD PTR [rax+0x24]
     1aa:	89 c8                	mov    eax,ecx
     1ac:	ba 00 00 00 00       	mov    edx,0x0
     1b1:	f7 f7                	div    edi
     1b3:	89 c0                	mov    eax,eax
     1b5:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		if (ct <= 1)
     1b9:	48 83 7d c8 01       	cmp    QWORD PTR [rbp-0x38],0x1
     1be:	0f 86 c9 02 00 00    	jbe    48d <elf_dump_symtab+0x363>
		printf("dumping symtab with %lu entries\n", ct);
     1c4:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     1c8:	48 89 c6             	mov    rsi,rax
     1cb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     1d2:	b8 00 00 00 00       	mov    eax,0x0
     1d7:	e8 00 00 00 00       	call   1dc <elf_dump_symtab+0xb2>
		printf("   Num:    Value  Size Type    Bind   Section  Name\n");
     1dc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     1e3:	b8 00 00 00 00       	mov    eax,0x0
     1e8:	e8 00 00 00 00       	call   1ed <elf_dump_symtab+0xc3>
		for (i = 1; i < ct; i++) {
     1ed:	48 c7 45 f8 01 00 00 00 	mov    QWORD PTR [rbp-0x8],0x1
     1f5:	e9 83 02 00 00       	jmp    47d <elf_dump_symtab+0x353>
				Elf32_Sym* s = (ptr + i * shdr[symtab].sh_entsize);
     1fa:	0f b7 55 ac          	movzx  edx,WORD PTR [rbp-0x54]
     1fe:	48 89 d0             	mov    rax,rdx
     201:	48 c1 e0 02          	shl    rax,0x2
     205:	48 01 d0             	add    rax,rdx
     208:	48 c1 e0 03          	shl    rax,0x3
     20c:	48 89 c2             	mov    rdx,rax
     20f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     213:	48 01 d0             	add    rax,rdx
     216:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
     219:	89 c0                	mov    eax,eax
     21b:	48 0f af 45 f8       	imul   rax,QWORD PTR [rbp-0x8]
     220:	48 89 c2             	mov    rdx,rax
     223:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     227:	48 01 d0             	add    rax,rdx
     22a:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				char *name = "STN_UNDEF", *sec, *stp, *stb;
     22e:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				if (s->st_name)
     236:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     23a:	8b 00                	mov    eax,DWORD PTR [rax]
     23c:	85 c0                	test   eax,eax
     23e:	74 3c                	je     27c <elf_dump_symtab+0x152>
						name = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
     240:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     244:	8b 08                	mov    ecx,DWORD PTR [rax]
     246:	0f b7 55 ac          	movzx  edx,WORD PTR [rbp-0x54]
     24a:	48 89 d0             	mov    rax,rdx
     24d:	48 c1 e0 02          	shl    rax,0x2
     251:	48 01 d0             	add    rax,rdx
     254:	48 c1 e0 03          	shl    rax,0x3
     258:	48 89 c2             	mov    rdx,rax
     25b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     25f:	48 01 d0             	add    rax,rdx
     262:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     265:	0f b7 d0             	movzx  edx,ax
     268:	48 8b 75 b0          	mov    rsi,QWORD PTR [rbp-0x50]
     26c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     270:	48 89 c7             	mov    rdi,rax
     273:	e8 00 00 00 00       	call   278 <elf_dump_symtab+0x14e>
     278:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				if (ELF32_ST_TYPE(s->st_info) == STT_NOTYPE)
     27c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     280:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     284:	0f b6 c0             	movzx  eax,al
     287:	83 e0 0f             	and    eax,0xf
     28a:	85 c0                	test   eax,eax
     28c:	75 0d                	jne    29b <elf_dump_symtab+0x171>
						stp = "NOTYPE ";
     28e:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     296:	e9 99 00 00 00       	jmp    334 <elf_dump_symtab+0x20a>
				else if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
     29b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     29f:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     2a3:	0f b6 c0             	movzx  eax,al
     2a6:	83 e0 0f             	and    eax,0xf
     2a9:	83 f8 01             	cmp    eax,0x1
     2ac:	75 0a                	jne    2b8 <elf_dump_symtab+0x18e>
						stp = "OBJECT ";
     2ae:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     2b6:	eb 7c                	jmp    334 <elf_dump_symtab+0x20a>
				else if (ELF32_ST_TYPE(s->st_info) == STT_FUNC)
     2b8:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     2bc:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     2c0:	0f b6 c0             	movzx  eax,al
     2c3:	83 e0 0f             	and    eax,0xf
     2c6:	83 f8 02             	cmp    eax,0x2
     2c9:	75 0a                	jne    2d5 <elf_dump_symtab+0x1ab>
						stp = "FUNC   ";
     2cb:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     2d3:	eb 5f                	jmp    334 <elf_dump_symtab+0x20a>
				else if (ELF32_ST_TYPE(s->st_info) == STT_SECTION)
     2d5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     2d9:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     2dd:	0f b6 c0             	movzx  eax,al
     2e0:	83 e0 0f             	and    eax,0xf
     2e3:	83 f8 03             	cmp    eax,0x3
     2e6:	75 0a                	jne    2f2 <elf_dump_symtab+0x1c8>
						stp = "SECTION";
     2e8:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     2f0:	eb 42                	jmp    334 <elf_dump_symtab+0x20a>
				else if (ELF32_ST_TYPE(s->st_info) == STT_FILE)
     2f2:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     2f6:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     2fa:	0f b6 c0             	movzx  eax,al
     2fd:	83 e0 0f             	and    eax,0xf
     300:	83 f8 04             	cmp    eax,0x4
     303:	75 0a                	jne    30f <elf_dump_symtab+0x1e5>
						stp = "FILE   ";
     305:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     30d:	eb 25                	jmp    334 <elf_dump_symtab+0x20a>
				else if (ELF32_ST_TYPE(s->st_info) >= 13/*STT_LOPROC*/ &&
     30f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     313:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     317:	0f b6 c0             	movzx  eax,al
     31a:	83 e0 0f             	and    eax,0xf
     31d:	83 f8 0c             	cmp    eax,0xc
     320:	76 0a                	jbe    32c <elf_dump_symtab+0x202>
						stp = "PROC   ";
     322:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     32a:	eb 08                	jmp    334 <elf_dump_symtab+0x20a>
						stp = "UNKNOWN";
     32c:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
				if (ELF32_ST_BIND(s->st_info) == STB_LOCAL)
     334:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     338:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     33c:	c0 e8 04             	shr    al,0x4
     33f:	84 c0                	test   al,al
     341:	75 0a                	jne    34d <elf_dump_symtab+0x223>
						stb = "LOCAL ";
     343:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
     34b:	eb 62                	jmp    3af <elf_dump_symtab+0x285>
				else if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL)
     34d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     351:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     355:	c0 e8 04             	shr    al,0x4
     358:	3c 01                	cmp    al,0x1
     35a:	75 0a                	jne    366 <elf_dump_symtab+0x23c>
						stb = "GLOBAL";
     35c:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
     364:	eb 49                	jmp    3af <elf_dump_symtab+0x285>
				else if (ELF32_ST_BIND(s->st_info) == STB_WEAK)
     366:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     36a:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     36e:	c0 e8 04             	shr    al,0x4
     371:	3c 02                	cmp    al,0x2
     373:	75 0a                	jne    37f <elf_dump_symtab+0x255>
						stb = "WEAK  ";
     375:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
     37d:	eb 30                	jmp    3af <elf_dump_symtab+0x285>
				else if (ELF32_ST_BIND(s->st_info) >= 13 &&
     37f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     383:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     387:	c0 e8 04             	shr    al,0x4
     38a:	3c 0c                	cmp    al,0xc
     38c:	76 19                	jbe    3a7 <elf_dump_symtab+0x27d>
						ELF32_ST_BIND(s->st_info) <= 15)
     38e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     392:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     396:	c0 e8 04             	shr    al,0x4
				else if (ELF32_ST_BIND(s->st_info) >= 13 &&
     399:	3c 0f                	cmp    al,0xf
     39b:	77 0a                	ja     3a7 <elf_dump_symtab+0x27d>
						stb = "PROC  ";
     39d:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
     3a5:	eb 08                	jmp    3af <elf_dump_symtab+0x285>
						stb = "UNK   ";
     3a7:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
				if (s->st_shndx == SHN_ABS)
     3af:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     3b3:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     3b7:	66 83 f8 f1          	cmp    ax,0xfff1
     3bb:	75 0a                	jne    3c7 <elf_dump_symtab+0x29d>
						sec = "ABS     ";
     3bd:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     3c5:	eb 73                	jmp    43a <elf_dump_symtab+0x310>
				else if (s->st_shndx == SHN_COMMON)
     3c7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     3cb:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     3cf:	66 83 f8 f2          	cmp    ax,0xfff2
     3d3:	75 0a                	jne    3df <elf_dump_symtab+0x2b5>
						sec = "COMMON  ";
     3d5:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     3dd:	eb 5b                	jmp    43a <elf_dump_symtab+0x310>
				else if (s->st_shndx == SHN_UNDEF)
     3df:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     3e3:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     3e7:	66 85 c0             	test   ax,ax
     3ea:	75 0a                	jne    3f6 <elf_dump_symtab+0x2cc>
						sec = "UNDEF   ";
     3ec:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     3f4:	eb 44                	jmp    43a <elf_dump_symtab+0x310>
						sec = elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name);
     3f6:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     3fa:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     3fe:	0f b7 d0             	movzx  edx,ax
     401:	48 89 d0             	mov    rax,rdx
     404:	48 c1 e0 02          	shl    rax,0x2
     408:	48 01 d0             	add    rax,rdx
     40b:	48 c1 e0 03          	shl    rax,0x3
     40f:	48 89 c2             	mov    rdx,rax
     412:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     416:	48 01 d0             	add    rax,rdx
     419:	8b 08                	mov    ecx,DWORD PTR [rax]
     41b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     41f:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
     423:	0f b7 d0             	movzx  edx,ax
     426:	48 8b 75 b0          	mov    rsi,QWORD PTR [rbp-0x50]
     42a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     42e:	48 89 c7             	mov    rdi,rax
     431:	e8 00 00 00 00       	call   436 <elf_dump_symtab+0x30c>
     436:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				printf("%6lu: %08u %5u %s %s %8.8s %.13s\n", i, s->st_value, s->st_size,
     43a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     43e:	8b 48 08             	mov    ecx,DWORD PTR [rax+0x8]
     441:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     445:	8b 50 04             	mov    edx,DWORD PTR [rax+0x4]
     448:	48 8b 7d d8          	mov    rdi,QWORD PTR [rbp-0x28]
     44c:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
     450:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     454:	ff 75 f0             	push   QWORD PTR [rbp-0x10]
     457:	ff 75 e8             	push   QWORD PTR [rbp-0x18]
     45a:	49 89 f9             	mov    r9,rdi
     45d:	49 89 f0             	mov    r8,rsi
     460:	48 89 c6             	mov    rsi,rax
     463:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     46a:	b8 00 00 00 00       	mov    eax,0x0
     46f:	e8 00 00 00 00       	call   474 <elf_dump_symtab+0x34a>
     474:	48 83 c4 10          	add    rsp,0x10
		for (i = 1; i < ct; i++) {
     478:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     47d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     481:	48 3b 45 c8          	cmp    rax,QWORD PTR [rbp-0x38]
     485:	0f 82 6f fd ff ff    	jb     1fa <elf_dump_symtab+0xd0>
     48b:	eb 01                	jmp    48e <elf_dump_symtab+0x364>
				return;
     48d:	90                   	nop
}
     48e:	c9                   	leave
     48f:	c3                   	ret

0000000000000490 <elf_rel_type_string>:
{
     490:	55                   	push   rbp
     491:	48 89 e5             	mov    rbp,rsp
     494:	48 83 ec 08          	sub    rsp,0x8
     498:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		switch (t) {
     49b:	83 7d fc 0a          	cmp    DWORD PTR [rbp-0x4],0xa
     49f:	77 70                	ja     511 <elf_rel_type_string+0x81>
     4a1:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     4a4:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     4ac:	ff e0                	jmp    rax
				return "R_386_NONE";
     4ae:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4b5:	eb 61                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_32";
     4b7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4be:	eb 58                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_PC32";
     4c0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4c7:	eb 4f                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_GOT32";
     4c9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4d0:	eb 46                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_PLT32";
     4d2:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4d9:	eb 3d                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_COPY";
     4db:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4e2:	eb 34                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_GLOB_DAT";
     4e4:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4eb:	eb 2b                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_JMP_SLOT";
     4ed:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4f4:	eb 22                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_RELATIVE";
     4f6:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4fd:	eb 19                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_GOTOFF";
     4ff:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     506:	eb 10                	jmp    518 <elf_rel_type_string+0x88>
				return "R_386_GOTPC";
     508:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     50f:	eb 07                	jmp    518 <elf_rel_type_string+0x88>
				return "UNKNOWN";
     511:	48 c7 c0 00 00 00 00 	mov    rax,0x0
}
     518:	c9                   	leave
     519:	c3                   	ret

000000000000051a <elf_dump_rel>:
{
     51a:	55                   	push   rbp
     51b:	48 89 e5             	mov    rbp,rsp
     51e:	41 54                	push   r12
     520:	53                   	push   rbx
     521:	48 81 ec 90 00 00 00 	sub    rsp,0x90
     528:	48 89 bd 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdi
     52f:	48 89 b5 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rsi
     536:	89 d0                	mov    eax,edx
     538:	66 89 85 6c ff ff ff 	mov    WORD PTR [rbp-0x94],ax
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
     53f:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     546:	48 89 d0             	mov    rax,rdx
     549:	48 c1 e0 02          	shl    rax,0x2
     54d:	48 01 d0             	add    rax,rdx
     550:	48 c1 e0 03          	shl    rax,0x3
     554:	48 89 c2             	mov    rdx,rax
     557:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     55e:	48 01 d0             	add    rax,rdx
     561:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     564:	89 c2                	mov    edx,eax
     566:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     56d:	48 01 d0             	add    rax,rdx
     570:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
     574:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     57b:	48 89 d0             	mov    rax,rdx
     57e:	48 c1 e0 02          	shl    rax,0x2
     582:	48 01 d0             	add    rax,rdx
     585:	48 c1 e0 03          	shl    rax,0x3
     589:	48 89 c2             	mov    rdx,rax
     58c:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     593:	48 01 d0             	add    rax,rdx
     596:	8b 48 14             	mov    ecx,DWORD PTR [rax+0x14]
     599:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     5a0:	48 89 d0             	mov    rax,rdx
     5a3:	48 c1 e0 02          	shl    rax,0x2
     5a7:	48 01 d0             	add    rax,rdx
     5aa:	48 c1 e0 03          	shl    rax,0x3
     5ae:	48 89 c2             	mov    rdx,rax
     5b1:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     5b8:	48 01 d0             	add    rax,rdx
     5bb:	8b 58 24             	mov    ebx,DWORD PTR [rax+0x24]
     5be:	89 c8                	mov    eax,ecx
     5c0:	ba 00 00 00 00       	mov    edx,0x0
     5c5:	f7 f3                	div    ebx
     5c7:	89 c0                	mov    eax,eax
     5c9:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		if (!ct)
     5cd:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
     5d2:	0f 84 71 04 00 00    	je     a49 <elf_dump_rel+0x52f>
		sptr = (void*)hdr + shdr[shdr[rel].sh_info].sh_offset;
     5d8:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     5df:	48 89 d0             	mov    rax,rdx
     5e2:	48 c1 e0 02          	shl    rax,0x2
     5e6:	48 01 d0             	add    rax,rdx
     5e9:	48 c1 e0 03          	shl    rax,0x3
     5ed:	48 89 c2             	mov    rdx,rax
     5f0:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     5f7:	48 01 d0             	add    rax,rdx
     5fa:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
     5fd:	89 c2                	mov    edx,eax
     5ff:	48 89 d0             	mov    rax,rdx
     602:	48 c1 e0 02          	shl    rax,0x2
     606:	48 01 d0             	add    rax,rdx
     609:	48 c1 e0 03          	shl    rax,0x3
     60d:	48 89 c2             	mov    rdx,rax
     610:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     617:	48 01 d0             	add    rax,rdx
     61a:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     61d:	89 c2                	mov    edx,eax
     61f:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     626:	48 01 d0             	add    rax,rdx
     629:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
     62d:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     634:	48 89 d0             	mov    rax,rdx
     637:	48 c1 e0 02          	shl    rax,0x2
     63b:	48 01 d0             	add    rax,rdx
     63e:	48 c1 e0 03          	shl    rax,0x3
     642:	48 89 c2             	mov    rdx,rax
     645:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     64c:	48 01 d0             	add    rax,rdx
     64f:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     652:	89 c2                	mov    edx,eax
     654:	48 89 d0             	mov    rax,rdx
     657:	48 c1 e0 02          	shl    rax,0x2
     65b:	48 01 d0             	add    rax,rdx
     65e:	48 c1 e0 03          	shl    rax,0x3
     662:	48 89 c2             	mov    rdx,rax
     665:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     66c:	48 01 d0             	add    rax,rdx
     66f:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     672:	89 c2                	mov    edx,eax
     674:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     67b:	48 01 d0             	add    rax,rdx
     67e:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
		stb = shdr + shdr[rel].sh_link;
     682:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     689:	48 89 d0             	mov    rax,rdx
     68c:	48 c1 e0 02          	shl    rax,0x2
     690:	48 01 d0             	add    rax,rdx
     693:	48 c1 e0 03          	shl    rax,0x3
     697:	48 89 c2             	mov    rdx,rax
     69a:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     6a1:	48 01 d0             	add    rax,rdx
     6a4:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     6a7:	89 c2                	mov    edx,eax
     6a9:	48 89 d0             	mov    rax,rdx
     6ac:	48 c1 e0 02          	shl    rax,0x2
     6b0:	48 01 d0             	add    rax,rdx
     6b3:	48 c1 e0 03          	shl    rax,0x3
     6b7:	48 89 c2             	mov    rdx,rax
     6ba:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     6c1:	48 01 d0             	add    rax,rdx
     6c4:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		printf("dumping relocations with %lu entries\n", ct);
     6c8:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6cc:	48 89 c6             	mov    rsi,rax
     6cf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     6d6:	b8 00 00 00 00       	mov    eax,0x0
     6db:	e8 00 00 00 00       	call   6e0 <elf_dump_rel+0x1c6>
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     6e0:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     6e7:	48 89 d0             	mov    rax,rdx
     6ea:	48 c1 e0 02          	shl    rax,0x2
     6ee:	48 01 d0             	add    rax,rdx
     6f1:	48 c1 e0 03          	shl    rax,0x3
     6f5:	48 89 c2             	mov    rdx,rax
     6f8:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     6ff:	48 01 d0             	add    rax,rdx
     702:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
     705:	89 c2                	mov    edx,eax
     707:	48 89 d0             	mov    rax,rdx
     70a:	48 c1 e0 02          	shl    rax,0x2
     70e:	48 01 d0             	add    rax,rdx
     711:	48 c1 e0 03          	shl    rax,0x3
     715:	48 89 c2             	mov    rdx,rax
     718:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     71f:	48 01 d0             	add    rax,rdx
		printf("relocations apply to section %s\n", elf_fetch_string(hdr,
     722:	8b 08                	mov    ecx,DWORD PTR [rax]
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     724:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     72b:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
		printf("relocations apply to section %s\n", elf_fetch_string(hdr,
     72f:	0f b7 d0             	movzx  edx,ax
     732:	48 8b b5 70 ff ff ff 	mov    rsi,QWORD PTR [rbp-0x90]
     739:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     740:	48 89 c7             	mov    rdi,rax
     743:	e8 00 00 00 00       	call   748 <elf_dump_rel+0x22e>
     748:	48 89 c6             	mov    rsi,rax
     74b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     752:	b8 00 00 00 00       	mov    eax,0x0
     757:	e8 00 00 00 00       	call   75c <elf_dump_rel+0x242>
		printf("   Num:   Offset Type              Field SyNdx SymbolName\n");
     75c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     763:	b8 00 00 00 00       	mov    eax,0x0
     768:	e8 00 00 00 00       	call   76d <elf_dump_rel+0x253>
		for (i = 0; i < ct; i++) {
     76d:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     775:	e9 bf 02 00 00       	jmp    a39 <elf_dump_rel+0x51f>
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
     77a:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     781:	48 89 d0             	mov    rax,rdx
     784:	48 c1 e0 02          	shl    rax,0x2
     788:	48 01 d0             	add    rax,rdx
     78b:	48 c1 e0 03          	shl    rax,0x3
     78f:	48 89 c2             	mov    rdx,rax
     792:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     799:	48 01 d0             	add    rax,rdx
     79c:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
     79f:	89 c0                	mov    eax,eax
     7a1:	48 0f af 45 e8       	imul   rax,QWORD PTR [rbp-0x18]
     7a6:	48 89 c2             	mov    rdx,rax
     7a9:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     7ad:	48 01 d0             	add    rax,rdx
     7b0:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
     7b4:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     7b8:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     7bb:	c1 e8 08             	shr    eax,0x8
     7be:	89 c2                	mov    edx,eax
     7c0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     7c4:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
     7c7:	0f af c2             	imul   eax,edx
     7ca:	89 c2                	mov    edx,eax
     7cc:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     7d0:	48 01 d0             	add    rax,rdx
     7d3:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
				const char* sn; char dat[] = "DAT: ........";
     7d7:	48 b8 44 41 54 3a 20 2e 2e 2e 	movabs rax,0x2e2e2e203a544144
     7e1:	48 89 45 86          	mov    QWORD PTR [rbp-0x7a],rax
     7e5:	48 b8 2e 2e 2e 2e 2e 2e 2e 00 	movabs rax,0x2e2e2e2e2e2e2e
     7ef:	48 89 45 8c          	mov    QWORD PTR [rbp-0x74],rax
				if (s->st_name)
     7f3:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     7f7:	8b 00                	mov    eax,DWORD PTR [rax]
     7f9:	85 c0                	test   eax,eax
     7fb:	74 2f                	je     82c <elf_dump_rel+0x312>
						sn = elf_fetch_string(hdr, shdr, stb->sh_link, s->st_name);
     7fd:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     801:	8b 08                	mov    ecx,DWORD PTR [rax]
     803:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     807:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     80a:	0f b7 d0             	movzx  edx,ax
     80d:	48 8b b5 70 ff ff ff 	mov    rsi,QWORD PTR [rbp-0x90]
     814:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     81b:	48 89 c7             	mov    rdi,rax
     81e:	e8 00 00 00 00       	call   823 <elf_dump_rel+0x309>
     823:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     827:	e9 a7 01 00 00       	jmp    9d3 <elf_dump_rel+0x4b9>
				else if ((shdr[s->st_shndx].sh_flags & SHF_WRITE) == 0
     82c:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     830:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     834:	0f b7 d0             	movzx  edx,ax
     837:	48 89 d0             	mov    rax,rdx
     83a:	48 c1 e0 02          	shl    rax,0x2
     83e:	48 01 d0             	add    rax,rdx
     841:	48 c1 e0 03          	shl    rax,0x3
     845:	48 89 c2             	mov    rdx,rax
     848:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     84f:	48 01 d0             	add    rax,rdx
     852:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
     855:	83 e0 01             	and    eax,0x1
     858:	85 c0                	test   eax,eax
     85a:	0f 85 23 01 00 00    	jne    983 <elf_dump_rel+0x469>
						&& shdr[s->st_shndx].sh_flags & SHF_ALLOC
     860:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     864:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     868:	0f b7 d0             	movzx  edx,ax
     86b:	48 89 d0             	mov    rax,rdx
     86e:	48 c1 e0 02          	shl    rax,0x2
     872:	48 01 d0             	add    rax,rdx
     875:	48 c1 e0 03          	shl    rax,0x3
     879:	48 89 c2             	mov    rdx,rax
     87c:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     883:	48 01 d0             	add    rax,rdx
     886:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
     889:	83 e0 02             	and    eax,0x2
     88c:	85 c0                	test   eax,eax
     88e:	0f 84 ef 00 00 00    	je     983 <elf_dump_rel+0x469>
						&& (shdr[s->st_shndx].sh_flags & SHF_EXECINSTR) == 0) {
     894:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     898:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     89c:	0f b7 d0             	movzx  edx,ax
     89f:	48 89 d0             	mov    rax,rdx
     8a2:	48 c1 e0 02          	shl    rax,0x2
     8a6:	48 01 d0             	add    rax,rdx
     8a9:	48 c1 e0 03          	shl    rax,0x3
     8ad:	48 89 c2             	mov    rdx,rax
     8b0:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     8b7:	48 01 d0             	add    rax,rdx
     8ba:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
     8bd:	83 e0 04             	and    eax,0x4
     8c0:	85 c0                	test   eax,eax
     8c2:	0f 85 bb 00 00 00    	jne    983 <elf_dump_rel+0x469>
						const char* c = (void*)hdr + shdr[s->st_shndx].sh_offset;
     8c8:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     8cc:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     8d0:	0f b7 d0             	movzx  edx,ax
     8d3:	48 89 d0             	mov    rax,rdx
     8d6:	48 c1 e0 02          	shl    rax,0x2
     8da:	48 01 d0             	add    rax,rdx
     8dd:	48 c1 e0 03          	shl    rax,0x3
     8e1:	48 89 c2             	mov    rdx,rax
     8e4:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     8eb:	48 01 d0             	add    rax,rdx
     8ee:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     8f1:	89 c2                	mov    edx,eax
     8f3:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     8fa:	48 01 d0             	add    rax,rdx
     8fd:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
						uint32_t of = *(uint32_t*)(sptr + r->r_offset), j;
     901:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     905:	8b 00                	mov    eax,DWORD PTR [rax]
     907:	89 c2                	mov    edx,eax
     909:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     90d:	48 01 d0             	add    rax,rdx
     910:	8b 00                	mov    eax,DWORD PTR [rax]
     912:	89 45 94             	mov    DWORD PTR [rbp-0x6c],eax
						for (j = 0; j < 8; j++)
     915:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
     91c:	eb 55                	jmp    973 <elf_dump_rel+0x459>
								if (isprint(c[of + j]))
     91e:	8b 55 94             	mov    edx,DWORD PTR [rbp-0x6c]
     921:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     924:	01 d0                	add    eax,edx
     926:	89 c2                	mov    edx,eax
     928:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     92c:	48 01 d0             	add    rax,rdx
     92f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     932:	0f be c0             	movsx  eax,al
     935:	89 c7                	mov    edi,eax
     937:	e8 00 00 00 00       	call   93c <elf_dump_rel+0x422>
     93c:	85 c0                	test   eax,eax
     93e:	74 22                	je     962 <elf_dump_rel+0x448>
										dat[j + 5] = c[of + j];
     940:	8b 55 94             	mov    edx,DWORD PTR [rbp-0x6c]
     943:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     946:	01 d0                	add    eax,edx
     948:	89 c2                	mov    edx,eax
     94a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     94e:	48 01 d0             	add    rax,rdx
     951:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
     954:	83 c2 05             	add    edx,0x5
     957:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     95a:	89 d2                	mov    edx,edx
     95c:	88 44 15 86          	mov    BYTE PTR [rbp+rdx*1-0x7a],al
     960:	eb 0d                	jmp    96f <elf_dump_rel+0x455>
										dat[j + 5] = '.';
     962:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     965:	83 c0 05             	add    eax,0x5
     968:	89 c0                	mov    eax,eax
     96a:	c6 44 05 86 2e       	mov    BYTE PTR [rbp+rax*1-0x7a],0x2e
						for (j = 0; j < 8; j++)
     96f:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1
     973:	83 7d dc 07          	cmp    DWORD PTR [rbp-0x24],0x7
     977:	76 a5                	jbe    91e <elf_dump_rel+0x404>
						sn = dat;
     979:	48 8d 45 86          	lea    rax,[rbp-0x7a]
     97d:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						&& (shdr[s->st_shndx].sh_flags & SHF_EXECINSTR) == 0) {
     981:	eb 50                	jmp    9d3 <elf_dump_rel+0x4b9>
						sn = elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name);
     983:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     987:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     98b:	0f b7 d0             	movzx  edx,ax
     98e:	48 89 d0             	mov    rax,rdx
     991:	48 c1 e0 02          	shl    rax,0x2
     995:	48 01 d0             	add    rax,rdx
     998:	48 c1 e0 03          	shl    rax,0x3
     99c:	48 89 c2             	mov    rdx,rax
     99f:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     9a6:	48 01 d0             	add    rax,rdx
     9a9:	8b 08                	mov    ecx,DWORD PTR [rax]
     9ab:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     9b2:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
     9b6:	0f b7 d0             	movzx  edx,ax
     9b9:	48 8b b5 70 ff ff ff 	mov    rsi,QWORD PTR [rbp-0x90]
     9c0:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     9c7:	48 89 c7             	mov    rdi,rax
     9ca:	e8 00 00 00 00       	call   9cf <elf_dump_rel+0x4b5>
     9cf:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
					*(uint32_t*)(sptr + r->r_offset), ELF32_R_SYM(r->r_info), sn);
     9d3:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     9d7:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     9da:	c1 e8 08             	shr    eax,0x8
     9dd:	41 89 c4             	mov    r12d,eax
					*(uint32_t*)(sptr + r->r_offset), ELF32_R_SYM(r->r_info), sn);
     9e0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     9e4:	8b 00                	mov    eax,DWORD PTR [rax]
     9e6:	89 c2                	mov    edx,eax
     9e8:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     9ec:	48 01 d0             	add    rax,rdx
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     9ef:	8b 18                	mov    ebx,DWORD PTR [rax]
					elf_rel_type_string(ELF32_R_TYPE(r->r_info)),
     9f1:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     9f5:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     9f8:	0f b6 c0             	movzx  eax,al
     9fb:	89 c7                	mov    edi,eax
     9fd:	e8 00 00 00 00       	call   a02 <elf_dump_rel+0x4e8>
     a02:	48 89 c1             	mov    rcx,rax
     a05:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     a09:	8b 10                	mov    edx,DWORD PTR [rax]
     a0b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a0f:	48 83 ec 08          	sub    rsp,0x8
     a13:	ff 75 e0             	push   QWORD PTR [rbp-0x20]
     a16:	45 89 e1             	mov    r9d,r12d
     a19:	41 89 d8             	mov    r8d,ebx
     a1c:	48 89 c6             	mov    rsi,rax
     a1f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a26:	b8 00 00 00 00       	mov    eax,0x0
     a2b:	e8 00 00 00 00       	call   a30 <elf_dump_rel+0x516>
     a30:	48 83 c4 10          	add    rsp,0x10
		for (i = 0; i < ct; i++) {
     a34:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     a39:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a3d:	48 3b 45 c8          	cmp    rax,QWORD PTR [rbp-0x38]
     a41:	0f 82 33 fd ff ff    	jb     77a <elf_dump_rel+0x260>
     a47:	eb 01                	jmp    a4a <elf_dump_rel+0x530>
				return;
     a49:	90                   	nop
}
     a4a:	48 8d 65 f0          	lea    rsp,[rbp-0x10]
     a4e:	5b                   	pop    rbx
     a4f:	41 5c                	pop    r12
     a51:	5d                   	pop    rbp
     a52:	c3                   	ret

0000000000000a53 <elf_relocate_section>:
{
     a53:	55                   	push   rbp
     a54:	48 89 e5             	mov    rbp,rsp
     a57:	48 83 ec 70          	sub    rsp,0x70
     a5b:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
     a5f:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
     a63:	89 d0                	mov    eax,edx
     a65:	66 89 45 9c          	mov    WORD PTR [rbp-0x64],ax
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
     a69:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     a6d:	48 89 d0             	mov    rax,rdx
     a70:	48 c1 e0 02          	shl    rax,0x2
     a74:	48 01 d0             	add    rax,rdx
     a77:	48 c1 e0 03          	shl    rax,0x3
     a7b:	48 89 c2             	mov    rdx,rax
     a7e:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     a82:	48 01 d0             	add    rax,rdx
     a85:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     a88:	89 c2                	mov    edx,eax
     a8a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     a8e:	48 01 d0             	add    rax,rdx
     a91:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
     a95:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     a99:	48 89 d0             	mov    rax,rdx
     a9c:	48 c1 e0 02          	shl    rax,0x2
     aa0:	48 01 d0             	add    rax,rdx
     aa3:	48 c1 e0 03          	shl    rax,0x3
     aa7:	48 89 c2             	mov    rdx,rax
     aaa:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     aae:	48 01 d0             	add    rax,rdx
     ab1:	8b 48 14             	mov    ecx,DWORD PTR [rax+0x14]
     ab4:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     ab8:	48 89 d0             	mov    rax,rdx
     abb:	48 c1 e0 02          	shl    rax,0x2
     abf:	48 01 d0             	add    rax,rdx
     ac2:	48 c1 e0 03          	shl    rax,0x3
     ac6:	48 89 c2             	mov    rdx,rax
     ac9:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     acd:	48 01 d0             	add    rax,rdx
     ad0:	8b 78 24             	mov    edi,DWORD PTR [rax+0x24]
     ad3:	89 c8                	mov    eax,ecx
     ad5:	ba 00 00 00 00       	mov    edx,0x0
     ada:	f7 f7                	div    edi
     adc:	89 c0                	mov    eax,eax
     ade:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		if (!ct)
     ae2:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     ae7:	0f 84 cb 02 00 00    	je     db8 <elf_relocate_section+0x365>
		sptr = (void*)shdr[shdr[rel].sh_info].sh_addr; /* vma */
     aed:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     af1:	48 89 d0             	mov    rax,rdx
     af4:	48 c1 e0 02          	shl    rax,0x2
     af8:	48 01 d0             	add    rax,rdx
     afb:	48 c1 e0 03          	shl    rax,0x3
     aff:	48 89 c2             	mov    rdx,rax
     b02:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b06:	48 01 d0             	add    rax,rdx
     b09:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
     b0c:	89 c2                	mov    edx,eax
     b0e:	48 89 d0             	mov    rax,rdx
     b11:	48 c1 e0 02          	shl    rax,0x2
     b15:	48 01 d0             	add    rax,rdx
     b18:	48 c1 e0 03          	shl    rax,0x3
     b1c:	48 89 c2             	mov    rdx,rax
     b1f:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b23:	48 01 d0             	add    rax,rdx
     b26:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
     b29:	89 c0                	mov    eax,eax
     b2b:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
     b2f:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     b33:	48 89 d0             	mov    rax,rdx
     b36:	48 c1 e0 02          	shl    rax,0x2
     b3a:	48 01 d0             	add    rax,rdx
     b3d:	48 c1 e0 03          	shl    rax,0x3
     b41:	48 89 c2             	mov    rdx,rax
     b44:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b48:	48 01 d0             	add    rax,rdx
     b4b:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     b4e:	89 c2                	mov    edx,eax
     b50:	48 89 d0             	mov    rax,rdx
     b53:	48 c1 e0 02          	shl    rax,0x2
     b57:	48 01 d0             	add    rax,rdx
     b5a:	48 c1 e0 03          	shl    rax,0x3
     b5e:	48 89 c2             	mov    rdx,rax
     b61:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b65:	48 01 d0             	add    rax,rdx
     b68:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     b6b:	89 c2                	mov    edx,eax
     b6d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     b71:	48 01 d0             	add    rax,rdx
     b74:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		stb = shdr + shdr[rel].sh_link;
     b78:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     b7c:	48 89 d0             	mov    rax,rdx
     b7f:	48 c1 e0 02          	shl    rax,0x2
     b83:	48 01 d0             	add    rax,rdx
     b86:	48 c1 e0 03          	shl    rax,0x3
     b8a:	48 89 c2             	mov    rdx,rax
     b8d:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b91:	48 01 d0             	add    rax,rdx
     b94:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     b97:	89 c2                	mov    edx,eax
     b99:	48 89 d0             	mov    rax,rdx
     b9c:	48 c1 e0 02          	shl    rax,0x2
     ba0:	48 01 d0             	add    rax,rdx
     ba3:	48 c1 e0 03          	shl    rax,0x3
     ba7:	48 89 c2             	mov    rdx,rax
     baa:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     bae:	48 01 d0             	add    rax,rdx
     bb1:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     bb5:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     bb9:	48 89 d0             	mov    rax,rdx
     bbc:	48 c1 e0 02          	shl    rax,0x2
     bc0:	48 01 d0             	add    rax,rdx
     bc3:	48 c1 e0 03          	shl    rax,0x3
     bc7:	48 89 c2             	mov    rdx,rax
     bca:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     bce:	48 01 d0             	add    rax,rdx
     bd1:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
     bd4:	89 c2                	mov    edx,eax
     bd6:	48 89 d0             	mov    rax,rdx
     bd9:	48 c1 e0 02          	shl    rax,0x2
     bdd:	48 01 d0             	add    rax,rdx
     be0:	48 c1 e0 03          	shl    rax,0x3
     be4:	48 89 c2             	mov    rdx,rax
     be7:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     beb:	48 01 d0             	add    rax,rdx
		sbprintf("%lu relocations apply to section %s\n", ct, elf_fetch_string(hdr,
     bee:	8b 08                	mov    ecx,DWORD PTR [rax]
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     bf0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     bf4:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
		sbprintf("%lu relocations apply to section %s\n", ct, elf_fetch_string(hdr,
     bf8:	0f b7 d0             	movzx  edx,ax
     bfb:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
     bff:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     c03:	48 89 c7             	mov    rdi,rax
     c06:	e8 00 00 00 00       	call   c0b <elf_relocate_section+0x1b8>
     c0b:	48 89 c2             	mov    rdx,rax
     c0e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     c12:	48 89 c6             	mov    rsi,rax
     c15:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c1c:	b8 00 00 00 00       	mov    eax,0x0
     c21:	e8 00 00 00 00       	call   c26 <elf_relocate_section+0x1d3>
		for (i = 0; i < ct; i++) {
     c26:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     c2e:	e9 75 01 00 00       	jmp    da8 <elf_relocate_section+0x355>
				Elf32_Addr val = 0;
     c33:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x0
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
     c3a:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     c3e:	48 89 d0             	mov    rax,rdx
     c41:	48 c1 e0 02          	shl    rax,0x2
     c45:	48 01 d0             	add    rax,rdx
     c48:	48 c1 e0 03          	shl    rax,0x3
     c4c:	48 89 c2             	mov    rdx,rax
     c4f:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     c53:	48 01 d0             	add    rax,rdx
     c56:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
     c59:	89 c0                	mov    eax,eax
     c5b:	48 0f af 45 f8       	imul   rax,QWORD PTR [rbp-0x8]
     c60:	48 89 c2             	mov    rdx,rax
     c63:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c67:	48 01 d0             	add    rax,rdx
     c6a:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				void** pptr = (void**)(sptr + r->r_offset);
     c6e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     c72:	8b 00                	mov    eax,DWORD PTR [rax]
     c74:	89 c2                	mov    edx,eax
     c76:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     c7a:	48 01 d0             	add    rax,rdx
     c7d:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
     c81:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     c85:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     c88:	c1 e8 08             	shr    eax,0x8
     c8b:	89 c2                	mov    edx,eax
     c8d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     c91:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
     c94:	0f af c2             	imul   eax,edx
     c97:	89 c2                	mov    edx,eax
     c99:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     c9d:	48 01 d0             	add    rax,rdx
     ca0:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				if (ELF32_R_SYM(r->r_info) == 0/*STN_UNDEF*/)
     ca4:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     ca8:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     cab:	c1 e8 08             	shr    eax,0x8
     cae:	85 c0                	test   eax,eax
     cb0:	75 08                	jne    cba <elf_relocate_section+0x267>
						s = NULL;
     cb2:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				if (s && !s->st_value) {
     cba:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     cbf:	74 24                	je     ce5 <elf_relocate_section+0x292>
     cc1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     cc5:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     cc8:	85 c0                	test   eax,eax
     cca:	75 19                	jne    ce5 <elf_relocate_section+0x292>
						cprintf(KFMT_ERROR, "tried to relocate reference to undefined symbol\n");
     ccc:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     cd3:	bf 0c 00 00 00       	mov    edi,0xc
     cd8:	b8 00 00 00 00       	mov    eax,0x0
     cdd:	e8 00 00 00 00       	call   ce2 <elf_relocate_section+0x28f>
						while (1);
     ce2:	90                   	nop
     ce3:	eb fd                	jmp    ce2 <elf_relocate_section+0x28f>
						val = s->st_value;
     ce5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     ce9:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     cec:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				if (shdr[rel].sh_type == SHT_RELA) {
     cef:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     cf3:	48 89 d0             	mov    rax,rdx
     cf6:	48 c1 e0 02          	shl    rax,0x2
     cfa:	48 01 d0             	add    rax,rdx
     cfd:	48 c1 e0 03          	shl    rax,0x3
     d01:	48 89 c2             	mov    rdx,rax
     d04:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     d08:	48 01 d0             	add    rax,rdx
     d0b:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     d0e:	83 f8 04             	cmp    eax,0x4
     d11:	75 19                	jne    d2c <elf_relocate_section+0x2d9>
						cprintf(KFMT_ERROR, "RELA relocations not implemented\n");
     d13:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     d1a:	bf 0c 00 00 00       	mov    edi,0xc
     d1f:	b8 00 00 00 00       	mov    eax,0x0
     d24:	e8 00 00 00 00       	call   d29 <elf_relocate_section+0x2d6>
						while (1);
     d29:	90                   	nop
     d2a:	eb fd                	jmp    d29 <elf_relocate_section+0x2d6>
						switch (ELF32_R_TYPE(r->r_info)) {
     d2c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     d30:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     d33:	0f b6 c0             	movzx  eax,al
     d36:	83 f8 06             	cmp    eax,0x6
     d39:	77 4e                	ja     d89 <elf_relocate_section+0x336>
     d3b:	89 c0                	mov    eax,eax
     d3d:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     d45:	ff e0                	jmp    rax
								*pptr = (size_t)val + *pptr;
     d47:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d4b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     d4e:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d51:	48 01 c2             	add    rdx,rax
     d54:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d58:	48 89 10             	mov    QWORD PTR [rax],rdx
								break;
     d5b:	eb 46                	jmp    da3 <elf_relocate_section+0x350>
								*pptr = (size_t)val + *pptr - (size_t)pptr;
     d5d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d61:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     d64:	8b 4d c4             	mov    ecx,DWORD PTR [rbp-0x3c]
     d67:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d6b:	48 29 c1             	sub    rcx,rax
     d6e:	48 01 ca             	add    rdx,rcx
     d71:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d75:	48 89 10             	mov    QWORD PTR [rax],rdx
								break;
     d78:	eb 29                	jmp    da3 <elf_relocate_section+0x350>
								*pptr = (void*)val;
     d7a:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d7d:	48 89 c2             	mov    rdx,rax
     d80:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d84:	48 89 10             	mov    QWORD PTR [rax],rdx
								break;
     d87:	eb 1a                	jmp    da3 <elf_relocate_section+0x350>
								cprintf(KFMT_ERROR, "relocation type not implemented\n");
     d89:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     d90:	bf 0c 00 00 00       	mov    edi,0xc
     d95:	b8 00 00 00 00       	mov    eax,0x0
     d9a:	e8 00 00 00 00       	call   d9f <elf_relocate_section+0x34c>
								while (1);
     d9f:	90                   	nop
     da0:	eb fd                	jmp    d9f <elf_relocate_section+0x34c>
								break;
     da2:	90                   	nop
		for (i = 0; i < ct; i++) {
     da3:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     da8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     dac:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
     db0:	0f 82 7d fe ff ff    	jb     c33 <elf_relocate_section+0x1e0>
     db6:	eb 01                	jmp    db9 <elf_relocate_section+0x366>
				return;
     db8:	90                   	nop
}
     db9:	c9                   	leave
     dba:	c3                   	ret

0000000000000dbb <get_section_type_string>:
{
     dbb:	55                   	push   rbp
     dbc:	48 89 e5             	mov    rbp,rsp
     dbf:	48 83 ec 08          	sub    rsp,0x8
     dc3:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		if (tp == SHT_PROGBITS)
     dc6:	83 7d fc 01          	cmp    DWORD PTR [rbp-0x4],0x1
     dca:	75 0c                	jne    dd8 <get_section_type_string+0x1d>
				return "PROGBITS";
     dcc:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     dd3:	e9 d2 00 00 00       	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_SYMTAB)
     dd8:	83 7d fc 02          	cmp    DWORD PTR [rbp-0x4],0x2
     ddc:	75 0c                	jne    dea <get_section_type_string+0x2f>
				return "SYMTAB";
     dde:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     de5:	e9 c0 00 00 00       	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_DYNSYM)
     dea:	83 7d fc 0b          	cmp    DWORD PTR [rbp-0x4],0xb
     dee:	75 0c                	jne    dfc <get_section_type_string+0x41>
				return "DYNSYM";
     df0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     df7:	e9 ae 00 00 00       	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_STRTAB)
     dfc:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
     e00:	75 0c                	jne    e0e <get_section_type_string+0x53>
				return "STRTAB";
     e02:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e09:	e9 9c 00 00 00       	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_RELA)
     e0e:	83 7d fc 04          	cmp    DWORD PTR [rbp-0x4],0x4
     e12:	75 0c                	jne    e20 <get_section_type_string+0x65>
				return "RELA";
     e14:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e1b:	e9 8a 00 00 00       	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_HASH)
     e20:	83 7d fc 05          	cmp    DWORD PTR [rbp-0x4],0x5
     e24:	75 09                	jne    e2f <get_section_type_string+0x74>
				return "HASH";
     e26:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e2d:	eb 7b                	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_DYNAMIC)
     e2f:	83 7d fc 06          	cmp    DWORD PTR [rbp-0x4],0x6
     e33:	75 09                	jne    e3e <get_section_type_string+0x83>
				return "DYNAMIC";
     e35:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e3c:	eb 6c                	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_NOTE)
     e3e:	83 7d fc 07          	cmp    DWORD PTR [rbp-0x4],0x7
     e42:	75 09                	jne    e4d <get_section_type_string+0x92>
				return "NOTE";
     e44:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e4b:	eb 5d                	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_NOBITS)
     e4d:	83 7d fc 08          	cmp    DWORD PTR [rbp-0x4],0x8
     e51:	75 09                	jne    e5c <get_section_type_string+0xa1>
				return "NOBITS";
     e53:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e5a:	eb 4e                	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_REL)
     e5c:	83 7d fc 09          	cmp    DWORD PTR [rbp-0x4],0x9
     e60:	75 09                	jne    e6b <get_section_type_string+0xb0>
				return "REL";
     e62:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e69:	eb 3f                	jmp    eaa <get_section_type_string+0xef>
		else if (tp == SHT_SHLIB)
     e6b:	83 7d fc 0a          	cmp    DWORD PTR [rbp-0x4],0xa
     e6f:	75 09                	jne    e7a <get_section_type_string+0xbf>
				return "SHLIB";
     e71:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e78:	eb 30                	jmp    eaa <get_section_type_string+0xef>
		else if (tp >= SHT_LOPROC && tp <= SHT_HIPROC)
     e7a:	81 7d fc ff ff ff 6f 	cmp    DWORD PTR [rbp-0x4],0x6fffffff
     e81:	76 10                	jbe    e93 <get_section_type_string+0xd8>
     e83:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     e86:	85 c0                	test   eax,eax
     e88:	78 09                	js     e93 <get_section_type_string+0xd8>
				return "PROC";
     e8a:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e91:	eb 17                	jmp    eaa <get_section_type_string+0xef>
		else if (tp >= SHT_LOUSER && tp <= SHT_HIUSER)
     e93:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     e96:	85 c0                	test   eax,eax
     e98:	79 09                	jns    ea3 <get_section_type_string+0xe8>
				return "USER";
     e9a:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ea1:	eb 07                	jmp    eaa <get_section_type_string+0xef>
		else
				return "RESERVED";
     ea3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
}
     eaa:	c9                   	leave
     eab:	c3                   	ret

0000000000000eac <elf_store_global_symbol>:

void elf_store_global_symbol(const char* name, void* vma, char type, int is_weak)
{
     eac:	55                   	push   rbp
     ead:	48 89 e5             	mov    rbp,rsp
     eb0:	48 83 ec 40          	sub    rsp,0x40
     eb4:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     eb8:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
     ebc:	89 d0                	mov    eax,edx
     ebe:	89 4d c8             	mov    DWORD PTR [rbp-0x38],ecx
     ec1:	88 45 cc             	mov    BYTE PTR [rbp-0x34],al
		struct symbol_list* sl = gs_lst;
     ec4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ecb <elf_store_global_symbol+0x1f>
     ecb:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		size_t i = 0; int wrt = 0;
     ecf:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     ed7:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
		if (!sl)
     ede:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     ee3:	0f 84 a1 02 00 00    	je     118a <elf_store_global_symbol+0x2de>
				return;

		if (!name) {
     ee9:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     eee:	0f 85 c2 01 00 00    	jne    10b6 <elf_store_global_symbol+0x20a>
				cprintf(KFMT_WARN, "elf_store_global_symbol called for symbol "
     ef4:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
     ef8:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
     efc:	48 89 d1             	mov    rcx,rdx
     eff:	89 c2                	mov    edx,eax
     f01:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f08:	bf 0e 00 00 00       	mov    edi,0xe
     f0d:	b8 00 00 00 00       	mov    eax,0x0
     f12:	e8 00 00 00 00       	call   f17 <elf_store_global_symbol+0x6b>
								"of type %c with name \"\" at %p\n", type, vma);
		}

		/* search for existng definition and give an offset to which to write to */
		while (sl) {
     f17:	e9 9a 01 00 00       	jmp    10b6 <elf_store_global_symbol+0x20a>
				if (!sl->entries[i].name)
     f1c:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     f20:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f24:	48 89 d0             	mov    rax,rdx
     f27:	48 01 c0             	add    rax,rax
     f2a:	48 01 d0             	add    rax,rdx
     f2d:	48 c1 e0 03          	shl    rax,0x3
     f31:	48 01 c8             	add    rax,rcx
     f34:	48 83 c0 08          	add    rax,0x8
     f38:	48 8b 00             	mov    rax,QWORD PTR [rax]
     f3b:	48 85 c0             	test   rax,rax
     f3e:	0f 84 7f 01 00 00    	je     10c3 <elf_store_global_symbol+0x217>
						break;
				if (strcmp(name, sl->entries[i].name) == 0) {
     f44:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     f48:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f4c:	48 89 d0             	mov    rax,rdx
     f4f:	48 01 c0             	add    rax,rax
     f52:	48 01 d0             	add    rax,rdx
     f55:	48 c1 e0 03          	shl    rax,0x3
     f59:	48 01 c8             	add    rax,rcx
     f5c:	48 83 c0 08          	add    rax,0x8
     f60:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     f63:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     f67:	48 89 d6             	mov    rsi,rdx
     f6a:	48 89 c7             	mov    rdi,rax
     f6d:	e8 00 00 00 00       	call   f72 <elf_store_global_symbol+0xc6>
     f72:	85 c0                	test   eax,eax
     f74:	0f 85 bf 00 00 00    	jne    1039 <elf_store_global_symbol+0x18d>
						/* found a first match */
						if (sl->entries[i].type == type) {
     f7a:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     f7e:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f82:	48 89 d0             	mov    rax,rdx
     f85:	48 01 c0             	add    rax,rax
     f88:	48 01 d0             	add    rax,rdx
     f8b:	48 c1 e0 03          	shl    rax,0x3
     f8f:	48 01 c8             	add    rax,rcx
     f92:	48 83 c0 10          	add    rax,0x10
     f96:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     f99:	38 45 cc             	cmp    BYTE PTR [rbp-0x34],al
     f9c:	0f 85 97 00 00 00    	jne    1039 <elf_store_global_symbol+0x18d>
								if (is_weak) /* use existing symbol definition */
     fa2:	83 7d c8 00          	cmp    DWORD PTR [rbp-0x38],0x0
     fa6:	0f 85 e1 01 00 00    	jne    118d <elf_store_global_symbol+0x2e1>
										return;
								cprintf(KFMT_WARN, "overwriting symbol %s defined at %p with "
     fac:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     fb0:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     fb4:	48 89 d0             	mov    rax,rdx
     fb7:	48 01 c0             	add    rax,rax
     fba:	48 01 d0             	add    rax,rdx
     fbd:	48 c1 e0 03          	shl    rax,0x3
     fc1:	48 01 c8             	add    rax,rcx
     fc4:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     fc7:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
     fcb:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     fcf:	48 89 d0             	mov    rax,rdx
     fd2:	48 01 c0             	add    rax,rax
     fd5:	48 01 d0             	add    rax,rdx
     fd8:	48 c1 e0 03          	shl    rax,0x3
     fdc:	48 01 f0             	add    rax,rsi
     fdf:	48 83 c0 08          	add    rax,0x8
     fe3:	48 8b 00             	mov    rax,QWORD PTR [rax]
     fe6:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
     fea:	49 89 d0             	mov    r8,rdx
     fed:	48 89 c2             	mov    rdx,rax
     ff0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     ff7:	bf 0e 00 00 00       	mov    edi,0xe
     ffc:	b8 00 00 00 00       	mov    eax,0x0
    1001:	e8 00 00 00 00       	call   1006 <elf_store_global_symbol+0x15a>
									"symbol at %p\n", sl->entries[i].name, sl->entries[i].vma, vma);
								kfree(sl->entries[i].name); /* just in case */
    1006:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    100a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    100e:	48 89 d0             	mov    rax,rdx
    1011:	48 01 c0             	add    rax,rax
    1014:	48 01 d0             	add    rax,rdx
    1017:	48 c1 e0 03          	shl    rax,0x3
    101b:	48 01 c8             	add    rax,rcx
    101e:	48 83 c0 08          	add    rax,0x8
    1022:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1025:	48 89 c7             	mov    rdi,rax
    1028:	e8 00 00 00 00       	call   102d <elf_store_global_symbol+0x181>
								wrt = 1;
    102d:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1
								break; /* only overwrite full matches */
    1034:	e9 8b 00 00 00       	jmp    10c4 <elf_store_global_symbol+0x218>
						}
				}
				if (++i == 64) {
    1039:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    103e:	48 83 7d f0 40       	cmp    QWORD PTR [rbp-0x10],0x40
    1043:	75 71                	jne    10b6 <elf_store_global_symbol+0x20a>
						if (sl->next) {
    1045:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1049:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    1050:	48 85 c0             	test   rax,rax
    1053:	74 19                	je     106e <elf_store_global_symbol+0x1c2>
								sl = sl->next;
    1055:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1059:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    1060:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
								i = 0;
    1064:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    106c:	eb 48                	jmp    10b6 <elf_store_global_symbol+0x20a>
						} else {
								/* allocate space for the next one and quit the loop */
								i = 0;
    106e:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
								sl = sl->next = kmalloc(sizeof(struct symbol_list));
    1076:	bf 08 06 00 00       	mov    edi,0x608
    107b:	e8 00 00 00 00       	call   1080 <elf_store_global_symbol+0x1d4>
    1080:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1084:	48 89 82 00 06 00 00 	mov    QWORD PTR [rdx+0x600],rax
    108b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    108f:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    1096:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
								if (!sl)
    109a:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    109f:	0f 84 eb 00 00 00    	je     1190 <elf_store_global_symbol+0x2e4>
										return;
								sl->next = NULL; /* IMPORTANT! as kmalloc != cmalloc */
    10a5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10a9:	48 c7 80 00 06 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x600],0x0
								break;
    10b4:	eb 0e                	jmp    10c4 <elf_store_global_symbol+0x218>
		while (sl) {
    10b6:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    10bb:	0f 85 5b fe ff ff    	jne    f1c <elf_store_global_symbol+0x70>
    10c1:	eb 01                	jmp    10c4 <elf_store_global_symbol+0x218>
						break;
    10c3:	90                   	nop
						}
				}
		}

		/* now write the new definition */
		sl->entries[i].name = strdup(name);
    10c4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    10c8:	48 89 c7             	mov    rdi,rax
    10cb:	e8 00 00 00 00       	call   10d0 <elf_store_global_symbol+0x224>
    10d0:	48 89 c1             	mov    rcx,rax
    10d3:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
    10d7:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    10db:	48 89 d0             	mov    rax,rdx
    10de:	48 01 c0             	add    rax,rax
    10e1:	48 01 d0             	add    rax,rdx
    10e4:	48 c1 e0 03          	shl    rax,0x3
    10e8:	48 01 f0             	add    rax,rsi
    10eb:	48 83 c0 08          	add    rax,0x8
    10ef:	48 89 08             	mov    QWORD PTR [rax],rcx
		sl->entries[i].type = type;
    10f2:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    10f6:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    10fa:	48 89 d0             	mov    rax,rdx
    10fd:	48 01 c0             	add    rax,rax
    1100:	48 01 d0             	add    rax,rdx
    1103:	48 c1 e0 03          	shl    rax,0x3
    1107:	48 01 c8             	add    rax,rcx
    110a:	48 8d 50 10          	lea    rdx,[rax+0x10]
    110e:	0f b6 45 cc          	movzx  eax,BYTE PTR [rbp-0x34]
    1112:	88 02                	mov    BYTE PTR [rdx],al
		sl->entries[i].vma = vma;
    1114:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1118:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    111c:	48 89 d0             	mov    rax,rdx
    111f:	48 01 c0             	add    rax,rax
    1122:	48 01 d0             	add    rax,rdx
    1125:	48 c1 e0 03          	shl    rax,0x3
    1129:	48 8d 14 01          	lea    rdx,[rcx+rax*1]
    112d:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1131:	48 89 02             	mov    QWORD PTR [rdx],rax
		/* and null-terminate if last */
		if (++i < 64 && !wrt) {
    1134:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    1139:	48 83 7d f0 3f       	cmp    QWORD PTR [rbp-0x10],0x3f
    113e:	77 51                	ja     1191 <elf_store_global_symbol+0x2e5>
    1140:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    1144:	75 4b                	jne    1191 <elf_store_global_symbol+0x2e5>
				sl->entries[i].name = NULL;
    1146:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    114a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    114e:	48 89 d0             	mov    rax,rdx
    1151:	48 01 c0             	add    rax,rax
    1154:	48 01 d0             	add    rax,rdx
    1157:	48 c1 e0 03          	shl    rax,0x3
    115b:	48 01 c8             	add    rax,rcx
    115e:	48 83 c0 08          	add    rax,0x8
    1162:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				sl->entries[i].vma = NULL;
    1169:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    116d:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1171:	48 89 d0             	mov    rax,rdx
    1174:	48 01 c0             	add    rax,rax
    1177:	48 01 d0             	add    rax,rdx
    117a:	48 c1 e0 03          	shl    rax,0x3
    117e:	48 01 c8             	add    rax,rcx
    1181:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
    1188:	eb 07                	jmp    1191 <elf_store_global_symbol+0x2e5>
				return;
    118a:	90                   	nop
    118b:	eb 04                	jmp    1191 <elf_store_global_symbol+0x2e5>
										return;
    118d:	90                   	nop
    118e:	eb 01                	jmp    1191 <elf_store_global_symbol+0x2e5>
										return;
    1190:	90                   	nop
		}
}
    1191:	c9                   	leave
    1192:	c3                   	ret

0000000000001193 <elf_locate_global_symbol>:

Elf32_Addr elf_locate_global_symbol(const char* name, char type)
{
    1193:	55                   	push   rbp
    1194:	48 89 e5             	mov    rbp,rsp
    1197:	48 83 ec 20          	sub    rsp,0x20
    119b:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    119f:	89 f0                	mov    eax,esi
    11a1:	88 45 e4             	mov    BYTE PTR [rbp-0x1c],al
		struct symbol_list* sl = gs_lst;
    11a4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 11ab <elf_locate_global_symbol+0x18>
    11ab:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		size_t i = 0;
    11af:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (!sl)
    11b7:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    11bc:	0f 85 12 01 00 00    	jne    12d4 <elf_locate_global_symbol+0x141>
				return (Elf32_Addr)NULL;
    11c2:	b8 00 00 00 00       	mov    eax,0x0
    11c7:	e9 1b 01 00 00       	jmp    12e7 <elf_locate_global_symbol+0x154>

		while (sl) {
				if (!sl->entries[i].name)
    11cc:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    11d0:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    11d4:	48 89 d0             	mov    rax,rdx
    11d7:	48 01 c0             	add    rax,rax
    11da:	48 01 d0             	add    rax,rdx
    11dd:	48 c1 e0 03          	shl    rax,0x3
    11e1:	48 01 c8             	add    rax,rcx
    11e4:	48 83 c0 08          	add    rax,0x8
    11e8:	48 8b 00             	mov    rax,QWORD PTR [rax]
    11eb:	48 85 c0             	test   rax,rax
    11ee:	0f 84 ed 00 00 00    	je     12e1 <elf_locate_global_symbol+0x14e>
						break; /* end of list */
				if (strcmp(sl->entries[i].name, name) == 0) {
    11f4:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    11f8:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    11fc:	48 89 d0             	mov    rax,rdx
    11ff:	48 01 c0             	add    rax,rax
    1202:	48 01 d0             	add    rax,rdx
    1205:	48 c1 e0 03          	shl    rax,0x3
    1209:	48 01 c8             	add    rax,rcx
    120c:	48 83 c0 08          	add    rax,0x8
    1210:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1213:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1217:	48 89 d6             	mov    rsi,rdx
    121a:	48 89 c7             	mov    rdi,rax
    121d:	e8 00 00 00 00       	call   1222 <elf_locate_global_symbol+0x8f>
    1222:	85 c0                	test   eax,eax
    1224:	0f 85 87 00 00 00    	jne    12b1 <elf_locate_global_symbol+0x11e>
						/* found a match candidate */
						if (sl->entries[i].type == type) /* exact match */
    122a:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    122e:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1232:	48 89 d0             	mov    rax,rdx
    1235:	48 01 c0             	add    rax,rax
    1238:	48 01 d0             	add    rax,rdx
    123b:	48 c1 e0 03          	shl    rax,0x3
    123f:	48 01 c8             	add    rax,rcx
    1242:	48 83 c0 10          	add    rax,0x10
    1246:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1249:	38 45 e4             	cmp    BYTE PTR [rbp-0x1c],al
    124c:	75 1d                	jne    126b <elf_locate_global_symbol+0xd8>
								return (Elf32_Addr)sl->entries[i].vma;
    124e:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1252:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1256:	48 89 d0             	mov    rax,rdx
    1259:	48 01 c0             	add    rax,rax
    125c:	48 01 d0             	add    rax,rdx
    125f:	48 c1 e0 03          	shl    rax,0x3
    1263:	48 01 c8             	add    rax,rcx
    1266:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1269:	eb 7c                	jmp    12e7 <elf_locate_global_symbol+0x154>
						else if (sl->entries[i].type == 'B' && type == 'D')
    126b:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    126f:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1273:	48 89 d0             	mov    rax,rdx
    1276:	48 01 c0             	add    rax,rax
    1279:	48 01 d0             	add    rax,rdx
    127c:	48 c1 e0 03          	shl    rax,0x3
    1280:	48 01 c8             	add    rax,rcx
    1283:	48 83 c0 10          	add    rax,0x10
    1287:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    128a:	3c 42                	cmp    al,0x42
    128c:	75 23                	jne    12b1 <elf_locate_global_symbol+0x11e>
    128e:	80 7d e4 44          	cmp    BYTE PTR [rbp-0x1c],0x44
    1292:	75 1d                	jne    12b1 <elf_locate_global_symbol+0x11e>
								return (Elf32_Addr)sl->entries[i].vma; /* compatible */
    1294:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1298:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    129c:	48 89 d0             	mov    rax,rdx
    129f:	48 01 c0             	add    rax,rax
    12a2:	48 01 d0             	add    rax,rdx
    12a5:	48 c1 e0 03          	shl    rax,0x3
    12a9:	48 01 c8             	add    rax,rcx
    12ac:	48 8b 00             	mov    rax,QWORD PTR [rax]
    12af:	eb 36                	jmp    12e7 <elf_locate_global_symbol+0x154>
				}

				if (++i == 64) {
    12b1:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    12b6:	48 83 7d f0 40       	cmp    QWORD PTR [rbp-0x10],0x40
    12bb:	75 17                	jne    12d4 <elf_locate_global_symbol+0x141>
						sl = sl->next;
    12bd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12c1:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    12c8:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						i = 0;
    12cc:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		while (sl) {
    12d4:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    12d9:	0f 85 ed fe ff ff    	jne    11cc <elf_locate_global_symbol+0x39>
    12df:	eb 01                	jmp    12e2 <elf_locate_global_symbol+0x14f>
						break; /* end of list */
    12e1:	90                   	nop
				}
		}

		/* no match found */
		return (Elf32_Addr)NULL;
    12e2:	b8 00 00 00 00       	mov    eax,0x0
}
    12e7:	c9                   	leave
    12e8:	c3                   	ret

00000000000012e9 <locate_module_function>:

void* locate_module_function(char* name)
{
    12e9:	55                   	push   rbp
    12ea:	48 89 e5             	mov    rbp,rsp
    12ed:	48 83 ec 30          	sub    rsp,0x30
    12f1:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		Elf32_Addr rv;
		rv = elf_locate_global_symbol(name, 'T');
    12f5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    12f9:	be 54 00 00 00       	mov    esi,0x54
    12fe:	48 89 c7             	mov    rdi,rax
    1301:	e8 00 00 00 00       	call   1306 <locate_module_function+0x1d>
    1306:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (!rv)
    1309:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    130d:	75 14                	jne    1323 <locate_module_function+0x3a>
				rv = elf_locate_global_symbol(name, 'D');
    130f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1313:	be 44 00 00 00       	mov    esi,0x44
    1318:	48 89 c7             	mov    rdi,rax
    131b:	e8 00 00 00 00       	call   1320 <locate_module_function+0x37>
    1320:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (!rv) {
    1323:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1327:	0f 85 9a 00 00 00    	jne    13c7 <locate_module_function+0xde>
				struct symbol_list* sl = gs_lst;
    132d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1334 <locate_module_function+0x4b>
    1334:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				size_t i = 0;
    1338:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
				while (sl) {
    1340:	eb 7a                	jmp    13bc <locate_module_function+0xd3>
						printf("%s %c\n", sl->entries[i].name, sl->entries[i].type);
    1342:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    1346:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    134a:	48 89 d0             	mov    rax,rdx
    134d:	48 01 c0             	add    rax,rax
    1350:	48 01 d0             	add    rax,rdx
    1353:	48 c1 e0 03          	shl    rax,0x3
    1357:	48 01 c8             	add    rax,rcx
    135a:	48 83 c0 10          	add    rax,0x10
    135e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1361:	0f be c8             	movsx  ecx,al
    1364:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
    1368:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    136c:	48 89 d0             	mov    rax,rdx
    136f:	48 01 c0             	add    rax,rax
    1372:	48 01 d0             	add    rax,rdx
    1375:	48 c1 e0 03          	shl    rax,0x3
    1379:	48 01 f0             	add    rax,rsi
    137c:	48 83 c0 08          	add    rax,0x8
    1380:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1383:	89 ca                	mov    edx,ecx
    1385:	48 89 c6             	mov    rsi,rax
    1388:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    138f:	b8 00 00 00 00       	mov    eax,0x0
    1394:	e8 00 00 00 00       	call   1399 <locate_module_function+0xb0>
						if (++i == 64) {
    1399:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    139e:	48 83 7d e8 40       	cmp    QWORD PTR [rbp-0x18],0x40
    13a3:	75 17                	jne    13bc <locate_module_function+0xd3>
								sl = sl->next;
    13a5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13a9:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    13b0:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
								i = 0;
    13b4:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
				while (sl) {
    13bc:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    13c1:	0f 85 7b ff ff ff    	jne    1342 <locate_module_function+0x59>
						}
				}
		}
		return (void*)rv;
    13c7:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    13ca:	c9                   	leave
    13cb:	c3                   	ret

00000000000013cc <store_module_info>:

void store_module_info(struct module_info* mi)
{
    13cc:	55                   	push   rbp
    13cd:	48 89 e5             	mov    rbp,rsp
    13d0:	48 83 ec 20          	sub    rsp,0x20
    13d4:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    13d8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 13df <store_module_info+0x13>
    13df:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		do {
				for (int i = 0; i < 7; i++)
    13e3:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
    13ea:	e9 b9 00 00 00       	jmp    14a8 <store_module_info+0xdc>
						if (!mc->ptrs[i]) {
    13ef:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13f3:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    13f6:	48 63 d2             	movsxd rdx,edx
    13f9:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    13fd:	48 85 c0             	test   rax,rax
    1400:	0f 85 9e 00 00 00    	jne    14a4 <store_module_info+0xd8>
								mc->ptrs[i] = kmalloc(sizeof(struct module_info));
    1406:	bf 68 00 00 00       	mov    edi,0x68
    140b:	e8 00 00 00 00       	call   1410 <store_module_info+0x44>
    1410:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1414:	8b 4d f4             	mov    ecx,DWORD PTR [rbp-0xc]
    1417:	48 63 c9             	movsxd rcx,ecx
    141a:	48 89 04 ca          	mov    QWORD PTR [rdx+rcx*8],rax
								if (!mc->ptrs[i])
    141e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1422:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1425:	48 63 d2             	movsxd rdx,edx
    1428:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    142c:	48 85 c0             	test   rax,rax
    142f:	0f 84 d7 00 00 00    	je     150c <store_module_info+0x140>
										return;
								memcpy(mc->ptrs[i], mi, sizeof(struct module_info));
    1435:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1439:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    143c:	48 63 d2             	movsxd rdx,edx
    143f:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    1443:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    1447:	ba 68 00 00 00       	mov    edx,0x68
    144c:	48 89 ce             	mov    rsi,rcx
    144f:	48 89 c7             	mov    rdi,rax
    1452:	e8 a9 eb ff ff       	call   0 <memcpy>
								for (int j = 0; j < 4; j++)
    1457:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
    145e:	eb 3c                	jmp    149c <store_module_info+0xd0>
										mod_tbl.sz_secs[j] += mi->sz_secs[j];
    1460:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    1463:	48 98                	cdqe
    1465:	48 83 c0 04          	add    rax,0x4
    1469:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    1471:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1475:	8b 4d f0             	mov    ecx,DWORD PTR [rbp-0x10]
    1478:	48 63 c9             	movsxd rcx,ecx
    147b:	48 83 c1 08          	add    rcx,0x8
    147f:	48 8b 44 c8 08       	mov    rax,QWORD PTR [rax+rcx*8+0x8]
    1484:	48 01 c2             	add    rdx,rax
    1487:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    148a:	48 98                	cdqe
    148c:	48 83 c0 04          	add    rax,0x4
    1490:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
								for (int j = 0; j < 4; j++)
    1498:	83 45 f0 01          	add    DWORD PTR [rbp-0x10],0x1
    149c:	83 7d f0 03          	cmp    DWORD PTR [rbp-0x10],0x3
    14a0:	7e be                	jle    1460 <store_module_info+0x94>
								return;
    14a2:	eb 69                	jmp    150d <store_module_info+0x141>
				for (int i = 0; i < 7; i++)
    14a4:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    14a8:	83 7d f4 06          	cmp    DWORD PTR [rbp-0xc],0x6
    14ac:	0f 8e 3d ff ff ff    	jle    13ef <store_module_info+0x23>
						}
				if (!mc->next) {
    14b2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14b6:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    14ba:	48 85 c0             	test   rax,rax
    14bd:	75 34                	jne    14f3 <store_module_info+0x127>
						mc->next = kmalloc(sizeof(struct module_info_container));
    14bf:	bf 40 00 00 00       	mov    edi,0x40
    14c4:	e8 00 00 00 00       	call   14c9 <store_module_info+0xfd>
    14c9:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    14cd:	48 89 42 38          	mov    QWORD PTR [rdx+0x38],rax
						if (mc->next)
    14d1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14d5:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    14d9:	48 85 c0             	test   rax,rax
    14dc:	74 15                	je     14f3 <store_module_info+0x127>
								bzero(mc->next, sizeof(struct module_info_container));
    14de:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14e2:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    14e6:	be 40 00 00 00       	mov    esi,0x40
    14eb:	48 89 c7             	mov    rdi,rax
    14ee:	e8 00 00 00 00       	call   14f3 <store_module_info+0x127>
				}
		} while ((mc = mc->next));
    14f3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14f7:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    14fb:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    14ff:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1504:	0f 85 d9 fe ff ff    	jne    13e3 <store_module_info+0x17>
    150a:	eb 01                	jmp    150d <store_module_info+0x141>
										return;
    150c:	90                   	nop
}
    150d:	c9                   	leave
    150e:	c3                   	ret

000000000000150f <list_modules>:

void list_modules()
{
    150f:	55                   	push   rbp
    1510:	48 89 e5             	mov    rbp,rsp
    1513:	48 83 ec 20          	sub    rsp,0x20
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    1517:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 151e <list_modules+0xf>
    151e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		printf("Module                     Size\n");
    1522:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1529:	b8 00 00 00 00       	mov    eax,0x0
    152e:	e8 00 00 00 00       	call   1533 <list_modules+0x24>
		do {
				for (int i = 0; i < 7; i++)
    1533:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
    153a:	eb 6a                	jmp    15a6 <list_modules+0x97>
						if (mc->ptrs[i]) {
    153c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1540:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1543:	48 63 d2             	movsxd rdx,edx
    1546:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    154a:	48 85 c0             	test   rax,rax
    154d:	74 5f                	je     15ae <list_modules+0x9f>
								struct module_info* mi = mc->ptrs[i];
    154f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1553:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1556:	48 63 d2             	movsxd rdx,edx
    1559:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    155d:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    1561:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1565:	48 8b 50 48          	mov    rdx,QWORD PTR [rax+0x48]
											mi->sz_secs[1] + mi->sz_secs[2] + mi->sz_secs[3]);
    1569:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    156d:	48 8b 40 50          	mov    rax,QWORD PTR [rax+0x50]
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    1571:	48 01 c2             	add    rdx,rax
											mi->sz_secs[1] + mi->sz_secs[2] + mi->sz_secs[3]);
    1574:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1578:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    157c:	48 01 c2             	add    rdx,rax
    157f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1583:	48 8b 40 60          	mov    rax,QWORD PTR [rax+0x60]
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    1587:	48 01 c2             	add    rdx,rax
    158a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    158e:	48 89 c6             	mov    rsi,rax
    1591:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1598:	b8 00 00 00 00       	mov    eax,0x0
    159d:	e8 00 00 00 00       	call   15a2 <list_modules+0x93>
				for (int i = 0; i < 7; i++)
    15a2:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    15a6:	83 7d f4 06          	cmp    DWORD PTR [rbp-0xc],0x6
    15aa:	7e 90                	jle    153c <list_modules+0x2d>
    15ac:	eb 01                	jmp    15af <list_modules+0xa0>
						} else
								break;
    15ae:	90                   	nop
		} while ((mc = mc->next));
    15af:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15b3:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    15b7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    15bb:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    15c0:	0f 85 6d ff ff ff    	jne    1533 <list_modules+0x24>
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    15c6:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 15cd <list_modules+0xbe>
						mod_tbl.sz_secs[1] + mod_tbl.sz_secs[2] + mod_tbl.sz_secs[3]);
    15cd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 15d4 <list_modules+0xc5>
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    15d4:	48 01 c2             	add    rdx,rax
						mod_tbl.sz_secs[1] + mod_tbl.sz_secs[2] + mod_tbl.sz_secs[3]);
    15d7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 15de <list_modules+0xcf>
    15de:	48 01 c2             	add    rdx,rax
    15e1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 15e8 <list_modules+0xd9>
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    15e8:	48 01 d0             	add    rax,rdx
    15eb:	48 89 c6             	mov    rsi,rax
    15ee:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    15f5:	b8 00 00 00 00       	mov    eax,0x0
    15fa:	e8 00 00 00 00       	call   15ff <list_modules+0xf0>
}
    15ff:	90                   	nop
    1600:	c9                   	leave
    1601:	c3                   	ret

0000000000001602 <list_module_info>:

void list_module_info(const char* name)
{
    1602:	55                   	push   rbp
    1603:	48 89 e5             	mov    rbp,rsp
    1606:	48 83 ec 30          	sub    rsp,0x30
    160a:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    160e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1615 <list_module_info+0x13>
    1615:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		do {
				for (int i = 0; i < 7; i++)
    1619:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
    1620:	e9 2a 01 00 00       	jmp    174f <list_module_info+0x14d>
						if (mc->ptrs[i]) {
    1625:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1629:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    162c:	48 63 d2             	movsxd rdx,edx
    162f:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    1633:	48 85 c0             	test   rax,rax
    1636:	0f 84 1f 01 00 00    	je     175b <list_module_info+0x159>
								struct module_info* mi = mc->ptrs[i];
    163c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1640:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1643:	48 63 d2             	movsxd rdx,edx
    1646:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    164a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
								if (strcmp(mi->mi_name, name) == 0) {
    164e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1652:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1656:	48 89 d6             	mov    rsi,rdx
    1659:	48 89 c7             	mov    rdi,rax
    165c:	e8 00 00 00 00       	call   1661 <list_module_info+0x5f>
    1661:	85 c0                	test   eax,eax
    1663:	0f 85 e2 00 00 00    	jne    174b <list_module_info+0x149>
										printf("module %s resides at:\n", name);
    1669:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    166d:	48 89 c6             	mov    rsi,rax
    1670:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1677:	b8 00 00 00 00       	mov    eax,0x0
    167c:	e8 00 00 00 00       	call   1681 <list_module_info+0x7f>
										printf("SECTION     .text    .data  .rodata     .bss\n");
    1681:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1688:	b8 00 00 00 00       	mov    eax,0x0
    168d:	e8 00 00 00 00       	call   1692 <list_module_info+0x90>
										printf("OFFSET   %p %p %p %p\n", mi->vm_ofs[0],
    1692:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1696:	48 8b 70 40          	mov    rsi,QWORD PTR [rax+0x40]
    169a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    169e:	48 8b 48 38          	mov    rcx,QWORD PTR [rax+0x38]
    16a2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16a6:	48 8b 50 30          	mov    rdx,QWORD PTR [rax+0x30]
    16aa:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16ae:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    16b2:	49 89 f0             	mov    r8,rsi
    16b5:	48 89 c6             	mov    rsi,rax
    16b8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    16bf:	b8 00 00 00 00       	mov    eax,0x0
    16c4:	e8 00 00 00 00       	call   16c9 <list_module_info+0xc7>
												mi->vm_ofs[1], mi->vm_ofs[2], mi->vm_ofs[3]);
										printf("SIZE     %8lu %8lu %8lu %8lu\n", mi->sz_secs[0],
    16c9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16cd:	48 8b 70 60          	mov    rsi,QWORD PTR [rax+0x60]
    16d1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16d5:	48 8b 48 58          	mov    rcx,QWORD PTR [rax+0x58]
    16d9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16dd:	48 8b 50 50          	mov    rdx,QWORD PTR [rax+0x50]
    16e1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16e5:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    16e9:	49 89 f0             	mov    r8,rsi
    16ec:	48 89 c6             	mov    rsi,rax
    16ef:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    16f6:	b8 00 00 00 00       	mov    eax,0x0
    16fb:	e8 00 00 00 00       	call   1700 <list_module_info+0xfe>
												mi->sz_secs[1], mi->sz_secs[2], mi->sz_secs[3]);
										printf("with the two functions\n");
    1700:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1707:	b8 00 00 00 00       	mov    eax,0x0
    170c:	e8 00 00 00 00       	call   1711 <list_module_info+0x10f>
										printf("module_init     at %p and\n", mi->mi_init);
    1711:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1715:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1719:	48 89 c6             	mov    rsi,rax
    171c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1723:	b8 00 00 00 00       	mov    eax,0x0
    1728:	e8 00 00 00 00       	call   172d <list_module_info+0x12b>
										printf("module_cleanup  at %p\n", mi->mi_cleanup);
    172d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1731:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1735:	48 89 c6             	mov    rsi,rax
    1738:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    173f:	b8 00 00 00 00       	mov    eax,0x0
    1744:	e8 00 00 00 00       	call   1749 <list_module_info+0x147>
										return;
    1749:	eb 40                	jmp    178b <list_module_info+0x189>
				for (int i = 0; i < 7; i++)
    174b:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    174f:	83 7d f4 06          	cmp    DWORD PTR [rbp-0xc],0x6
    1753:	0f 8e cc fe ff ff    	jle    1625 <list_module_info+0x23>
    1759:	eb 01                	jmp    175c <list_module_info+0x15a>
								}
						} else
								break;
    175b:	90                   	nop
		} while ((mc = mc->next));
    175c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1760:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    1764:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1768:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    176d:	0f 85 a6 fe ff ff    	jne    1619 <list_module_info+0x17>
		printf("modinfo: ERROR: Module %s not found.\n", name);
    1773:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1777:	48 89 c6             	mov    rsi,rax
    177a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1781:	b8 00 00 00 00       	mov    eax,0x0
    1786:	e8 00 00 00 00       	call   178b <list_module_info+0x189>
}
    178b:	c9                   	leave
    178c:	c3                   	ret

000000000000178d <elf_get_closest_symbol>:

const char* elf_get_closest_symbol(void* ptr, size_t* offset)
{
    178d:	55                   	push   rbp
    178e:	48 89 e5             	mov    rbp,rsp
    1791:	48 83 ec 30          	sub    rsp,0x30
    1795:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1799:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		struct symbol_list* sl = gs_lst;
    179d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17a4 <elf_get_closest_symbol+0x17>
    17a4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		size_t i = 0; const char* rv = ""; void* base = NULL;
    17a8:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    17b0:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    17b8:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		if (!sl) {
    17c0:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    17c5:	0f 85 c8 00 00 00    	jne    1893 <elf_get_closest_symbol+0x106>
				*offset = (size_t)ptr;
    17cb:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    17cf:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    17d3:	48 89 10             	mov    QWORD PTR [rax],rdx
				return "";
    17d6:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    17dd:	e9 d5 00 00 00       	jmp    18b7 <elf_get_closest_symbol+0x12a>
		}

		while (sl) {
				if (sl->entries[i].vma <= ptr && sl->entries[i].vma > base) {
    17e2:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    17e6:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    17ea:	48 89 d0             	mov    rax,rdx
    17ed:	48 01 c0             	add    rax,rax
    17f0:	48 01 d0             	add    rax,rdx
    17f3:	48 c1 e0 03          	shl    rax,0x3
    17f7:	48 01 c8             	add    rax,rcx
    17fa:	48 8b 00             	mov    rax,QWORD PTR [rax]
    17fd:	48 39 45 d8          	cmp    QWORD PTR [rbp-0x28],rax
    1801:	72 6d                	jb     1870 <elf_get_closest_symbol+0xe3>
    1803:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1807:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    180b:	48 89 d0             	mov    rax,rdx
    180e:	48 01 c0             	add    rax,rax
    1811:	48 01 d0             	add    rax,rdx
    1814:	48 c1 e0 03          	shl    rax,0x3
    1818:	48 01 c8             	add    rax,rcx
    181b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    181e:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
    1822:	73 4c                	jae    1870 <elf_get_closest_symbol+0xe3>
						/* found a new one */
						rv = sl->entries[i].name;
    1824:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1828:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    182c:	48 89 d0             	mov    rax,rdx
    182f:	48 01 c0             	add    rax,rax
    1832:	48 01 d0             	add    rax,rdx
    1835:	48 c1 e0 03          	shl    rax,0x3
    1839:	48 01 c8             	add    rax,rcx
    183c:	48 83 c0 08          	add    rax,0x8
    1840:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1843:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						base = sl->entries[i].vma;
    1847:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    184b:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    184f:	48 89 d0             	mov    rax,rdx
    1852:	48 01 c0             	add    rax,rax
    1855:	48 01 d0             	add    rax,rdx
    1858:	48 c1 e0 03          	shl    rax,0x3
    185c:	48 01 c8             	add    rax,rcx
    185f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1862:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						if (base == ptr) /* abort on first exact match */
    1866:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    186a:	48 3b 45 d8          	cmp    rax,QWORD PTR [rbp-0x28]
    186e:	74 30                	je     18a0 <elf_get_closest_symbol+0x113>
								break;
				}
				if (++i == 64) {
    1870:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    1875:	48 83 7d f0 40       	cmp    QWORD PTR [rbp-0x10],0x40
    187a:	75 17                	jne    1893 <elf_get_closest_symbol+0x106>
						sl = sl->next;
    187c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1880:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    1887:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						i = 0;
    188b:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		while (sl) {
    1893:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1898:	0f 85 44 ff ff ff    	jne    17e2 <elf_get_closest_symbol+0x55>
    189e:	eb 01                	jmp    18a1 <elf_get_closest_symbol+0x114>
								break;
    18a0:	90                   	nop
				}
		}

		*offset = ptr - base;
    18a1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    18a5:	48 2b 45 e0          	sub    rax,QWORD PTR [rbp-0x20]
    18a9:	48 89 c2             	mov    rdx,rax
    18ac:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    18b0:	48 89 10             	mov    QWORD PTR [rax],rdx
		return rv;
    18b3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
}
    18b7:	c9                   	leave
    18b8:	c3                   	ret

00000000000018b9 <elf_resolve_symbols>:

/* bss_vmem is in/out parameter which points to the top of bss after call */
void elf_resolve_symbols(Elf32_Ehdr* hdr, Elf32_Shdr* shdr, Elf32_Half symtab, void** bss_vmem, struct module_info* mi)
{
    18b9:	55                   	push   rbp
    18ba:	48 89 e5             	mov    rbp,rsp
    18bd:	41 54                	push   r12
    18bf:	53                   	push   rbx
    18c0:	48 81 ec 90 00 00 00 	sub    rsp,0x90
    18c7:	48 89 7d 88          	mov    QWORD PTR [rbp-0x78],rdi
    18cb:	48 89 75 80          	mov    QWORD PTR [rbp-0x80],rsi
    18cf:	89 d0                	mov    eax,edx
    18d1:	48 89 8d 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rcx
    18d8:	4c 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],r8
    18df:	66 89 85 7c ff ff ff 	mov    WORD PTR [rbp-0x84],ax
		void* ptr = ((void*)hdr + shdr[symtab].sh_offset);
    18e6:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    18ed:	48 89 d0             	mov    rax,rdx
    18f0:	48 c1 e0 02          	shl    rax,0x2
    18f4:	48 01 d0             	add    rax,rdx
    18f7:	48 c1 e0 03          	shl    rax,0x3
    18fb:	48 89 c2             	mov    rdx,rax
    18fe:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1902:	48 01 d0             	add    rax,rdx
    1905:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1908:	89 c2                	mov    edx,eax
    190a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    190e:	48 01 d0             	add    rax,rdx
    1911:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		size_t i, ct = shdr[symtab].sh_size / shdr[symtab].sh_entsize;
    1915:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    191c:	48 89 d0             	mov    rax,rdx
    191f:	48 c1 e0 02          	shl    rax,0x2
    1923:	48 01 d0             	add    rax,rdx
    1926:	48 c1 e0 03          	shl    rax,0x3
    192a:	48 89 c2             	mov    rdx,rax
    192d:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1931:	48 01 d0             	add    rax,rdx
    1934:	8b 48 14             	mov    ecx,DWORD PTR [rax+0x14]
    1937:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    193e:	48 89 d0             	mov    rax,rdx
    1941:	48 c1 e0 02          	shl    rax,0x2
    1945:	48 01 d0             	add    rax,rdx
    1948:	48 c1 e0 03          	shl    rax,0x3
    194c:	48 89 c2             	mov    rdx,rax
    194f:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1953:	48 01 d0             	add    rax,rdx
    1956:	8b 58 24             	mov    ebx,DWORD PTR [rax+0x24]
    1959:	89 c8                	mov    eax,ecx
    195b:	ba 00 00 00 00       	mov    edx,0x0
    1960:	f7 f3                	div    ebx
    1962:	89 c0                	mov    eax,eax
    1964:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		if (ct <= 1)
    1968:	48 83 7d c8 01       	cmp    QWORD PTR [rbp-0x38],0x1
    196d:	0f 86 6f 07 00 00    	jbe    20e2 <elf_resolve_symbols+0x829>
				return;
		sbprintf("Resolving symbols in symtab with %lu entries\n", ct);
    1973:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1977:	48 89 c6             	mov    rsi,rax
    197a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1981:	b8 00 00 00 00       	mov    eax,0x0
    1986:	e8 00 00 00 00       	call   198b <elf_resolve_symbols+0xd2>
		for (i = 1; i < ct; i++) {
    198b:	48 c7 45 e8 01 00 00 00 	mov    QWORD PTR [rbp-0x18],0x1
    1993:	e9 3a 07 00 00       	jmp    20d2 <elf_resolve_symbols+0x819>
				Elf32_Sym* s = (ptr + i * shdr[symtab].sh_entsize);
    1998:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    199f:	48 89 d0             	mov    rax,rdx
    19a2:	48 c1 e0 02          	shl    rax,0x2
    19a6:	48 01 d0             	add    rax,rdx
    19a9:	48 c1 e0 03          	shl    rax,0x3
    19ad:	48 89 c2             	mov    rdx,rax
    19b0:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    19b4:	48 01 d0             	add    rax,rdx
    19b7:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    19ba:	89 c0                	mov    eax,eax
    19bc:	48 0f af 45 e8       	imul   rax,QWORD PTR [rbp-0x18]
    19c1:	48 89 c2             	mov    rdx,rax
    19c4:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    19c8:	48 01 d0             	add    rax,rdx
    19cb:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				if (s->st_shndx == SHN_UNDEF) {
    19cf:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    19d3:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    19d7:	66 85 c0             	test   ax,ax
    19da:	0f 85 de 00 00 00    	jne    1abe <elf_resolve_symbols+0x205>
						char* sn, tp = 'T';
    19e0:	c6 45 e7 54          	mov    BYTE PTR [rbp-0x19],0x54
						/* unresolved symbol -> find in map */
						sbprintf("using external symbol with name %s\n",
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
    19e4:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    19e8:	8b 08                	mov    ecx,DWORD PTR [rax]
    19ea:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    19f1:	48 89 d0             	mov    rax,rdx
    19f4:	48 c1 e0 02          	shl    rax,0x2
    19f8:	48 01 d0             	add    rax,rdx
    19fb:	48 c1 e0 03          	shl    rax,0x3
    19ff:	48 89 c2             	mov    rdx,rax
    1a02:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1a06:	48 01 d0             	add    rax,rdx
    1a09:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1a0c:	0f b7 d0             	movzx  edx,ax
    1a0f:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1a13:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1a17:	48 89 c7             	mov    rdi,rax
    1a1a:	e8 00 00 00 00       	call   1a1f <elf_resolve_symbols+0x166>
    1a1f:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
						sbprintf("using external symbol with name %s\n",
    1a23:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1a27:	48 89 c6             	mov    rsi,rax
    1a2a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1a31:	b8 00 00 00 00       	mov    eax,0x0
    1a36:	e8 00 00 00 00       	call   1a3b <elf_resolve_symbols+0x182>
						if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    1a3b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1a3f:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1a43:	0f b6 c0             	movzx  eax,al
    1a46:	83 e0 0f             	and    eax,0xf
    1a49:	83 f8 01             	cmp    eax,0x1
    1a4c:	75 04                	jne    1a52 <elf_resolve_symbols+0x199>
								tp = 'D';
    1a4e:	c6 45 e7 44          	mov    BYTE PTR [rbp-0x19],0x44
						s->st_value = elf_locate_global_symbol(sn, tp);
    1a52:	0f be 55 e7          	movsx  edx,BYTE PTR [rbp-0x19]
    1a56:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1a5a:	89 d6                	mov    esi,edx
    1a5c:	48 89 c7             	mov    rdi,rax
    1a5f:	e8 00 00 00 00       	call   1a64 <elf_resolve_symbols+0x1ab>
    1a64:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1a68:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
						if (!s->st_value) {
    1a6b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1a6f:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1a72:	85 c0                	test   eax,eax
    1a74:	75 26                	jne    1a9c <elf_resolve_symbols+0x1e3>
								cprintf(KFMT_ERROR, "unresolved external symbol %c \"%s\"\n", tp, sn);
    1a76:	0f be 45 e7          	movsx  eax,BYTE PTR [rbp-0x19]
    1a7a:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    1a7e:	48 89 d1             	mov    rcx,rdx
    1a81:	89 c2                	mov    edx,eax
    1a83:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1a8a:	bf 0c 00 00 00       	mov    edi,0xc
    1a8f:	b8 00 00 00 00       	mov    eax,0x0
    1a94:	e8 00 00 00 00       	call   1a99 <elf_resolve_symbols+0x1e0>
								while (1);
    1a99:	90                   	nop
    1a9a:	eb fd                	jmp    1a99 <elf_resolve_symbols+0x1e0>
						} else
								sbprintf("\twhich was resolved to %p\n", (void*)s->st_value);
    1a9c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1aa0:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1aa3:	89 c0                	mov    eax,eax
    1aa5:	48 89 c6             	mov    rsi,rax
    1aa8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1aaf:	b8 00 00 00 00       	mov    eax,0x0
    1ab4:	e8 00 00 00 00       	call   1ab9 <elf_resolve_symbols+0x200>
    1ab9:	e9 0f 06 00 00       	jmp    20cd <elf_resolve_symbols+0x814>
				} else if (s->st_shndx == SHN_COMMON) {
    1abe:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1ac2:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1ac6:	66 83 f8 f2          	cmp    ax,0xfff2
    1aca:	0f 85 04 02 00 00    	jne    1cd4 <elf_resolve_symbols+0x41b>
						char* sn, tp = 'D'; Elf32_Addr ad = (Elf32_Addr)NULL;
    1ad0:	c6 45 af 44          	mov    BYTE PTR [rbp-0x51],0x44
    1ad4:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [rbp-0x20],0x0
						sbprintf("Common symbol with size %u and alignment %u with name %s\n",
										s->st_size, s->st_value,
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
    1adb:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1adf:	8b 08                	mov    ecx,DWORD PTR [rax]
    1ae1:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1ae8:	48 89 d0             	mov    rax,rdx
    1aeb:	48 c1 e0 02          	shl    rax,0x2
    1aef:	48 01 d0             	add    rax,rdx
    1af2:	48 c1 e0 03          	shl    rax,0x3
    1af6:	48 89 c2             	mov    rdx,rax
    1af9:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1afd:	48 01 d0             	add    rax,rdx
    1b00:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1b03:	0f b7 d0             	movzx  edx,ax
    1b06:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1b0a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1b0e:	48 89 c7             	mov    rdi,rax
    1b11:	e8 00 00 00 00       	call   1b16 <elf_resolve_symbols+0x25d>
    1b16:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
						sbprintf("Common symbol with size %u and alignment %u with name %s\n",
    1b1a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b1e:	8b 50 04             	mov    edx,DWORD PTR [rax+0x4]
    1b21:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b25:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1b28:	48 8b 4d a0          	mov    rcx,QWORD PTR [rbp-0x60]
    1b2c:	89 c6                	mov    esi,eax
    1b2e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1b35:	b8 00 00 00 00       	mov    eax,0x0
    1b3a:	e8 00 00 00 00       	call   1b3f <elf_resolve_symbols+0x286>
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1b3f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b43:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1b47:	c0 e8 04             	shr    al,0x4
    1b4a:	3c 01                	cmp    al,0x1
    1b4c:	74 0f                	je     1b5d <elf_resolve_symbols+0x2a4>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1b4e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b52:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1b56:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1b59:	3c 02                	cmp    al,0x2
    1b5b:	75 32                	jne    1b8f <elf_resolve_symbols+0x2d6>
								/* lookup on global symtab */
								ad = elf_locate_global_symbol(sn, tp);
    1b5d:	0f be 55 af          	movsx  edx,BYTE PTR [rbp-0x51]
    1b61:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    1b65:	89 d6                	mov    esi,edx
    1b67:	48 89 c7             	mov    rdi,rax
    1b6a:	e8 00 00 00 00       	call   1b6f <elf_resolve_symbols+0x2b6>
    1b6f:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
								if (ad)
    1b72:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    1b76:	74 17                	je     1b8f <elf_resolve_symbols+0x2d6>
										sbprintf("global definition found at %p\n", (void*)ad);
    1b78:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    1b7b:	48 89 c6             	mov    rsi,rax
    1b7e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1b85:	b8 00 00 00 00       	mov    eax,0x0
    1b8a:	e8 00 00 00 00       	call   1b8f <elf_resolve_symbols+0x2d6>
						}
						/* lookup on symtab or else allocate */
						if (!ad) {
    1b8f:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    1b93:	0f 85 2c 01 00 00    	jne    1cc5 <elf_resolve_symbols+0x40c>
								/* allocate rw bss (dumb align) */
								if ((size_t)*bss_vmem % (size_t)s->st_value) {
    1b99:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1ba0:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1ba3:	48 89 c2             	mov    rdx,rax
    1ba6:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1baa:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1bad:	89 c1                	mov    ecx,eax
    1baf:	48 89 d0             	mov    rax,rdx
    1bb2:	ba 00 00 00 00       	mov    edx,0x0
    1bb7:	48 f7 f1             	div    rcx
    1bba:	48 89 d0             	mov    rax,rdx
    1bbd:	48 85 c0             	test   rax,rax
    1bc0:	0f 84 98 00 00 00    	je     1c5e <elf_resolve_symbols+0x3a5>
										*bss_vmem += s->st_value - ((size_t)*bss_vmem % s->st_value);
    1bc6:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1bcd:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1bd0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1bd4:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1bd7:	89 c6                	mov    esi,eax
    1bd9:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1be0:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1be3:	48 89 c2             	mov    rdx,rax
    1be6:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1bea:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1bed:	89 c7                	mov    edi,eax
    1bef:	48 89 d0             	mov    rax,rdx
    1bf2:	ba 00 00 00 00       	mov    edx,0x0
    1bf7:	48 f7 f7             	div    rdi
    1bfa:	48 89 f0             	mov    rax,rsi
    1bfd:	48 29 d0             	sub    rax,rdx
    1c00:	48 8d 14 01          	lea    rdx,[rcx+rax*1]
    1c04:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1c0b:	48 89 10             	mov    QWORD PTR [rax],rdx
										s->st_value = (Elf32_Addr)*bss_vmem;
    1c0e:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1c15:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1c18:	89 c2                	mov    edx,eax
    1c1a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c1e:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
										*bss_vmem += s->st_size;
    1c21:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1c28:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1c2b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c2f:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1c32:	89 c0                	mov    eax,eax
    1c34:	48 01 c2             	add    rdx,rax
    1c37:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1c3e:	48 89 10             	mov    QWORD PTR [rax],rdx
										sbprintf("will be allocated at %p\n", (void*)s->st_value);
    1c41:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c45:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1c48:	89 c0                	mov    eax,eax
    1c4a:	48 89 c6             	mov    rsi,rax
    1c4d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c54:	b8 00 00 00 00       	mov    eax,0x0
    1c59:	e8 00 00 00 00       	call   1c5e <elf_resolve_symbols+0x3a5>
								}
								/* publish the location if applicable */
								if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1c5e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c62:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1c66:	c0 e8 04             	shr    al,0x4
    1c69:	3c 01                	cmp    al,0x1
    1c6b:	74 13                	je     1c80 <elf_resolve_symbols+0x3c7>
												ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1c6d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c71:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1c75:	c0 e8 04             	shr    al,0x4
								if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1c78:	3c 02                	cmp    al,0x2
    1c7a:	0f 85 4d 04 00 00    	jne    20cd <elf_resolve_symbols+0x814>
										elf_store_global_symbol(sn, (void*)s->st_value, tp,
													   	(ELF32_ST_BIND(s->st_info) == STB_WEAK));
    1c80:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c84:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
										elf_store_global_symbol(sn, (void*)s->st_value, tp,
    1c88:	c0 e8 04             	shr    al,0x4
    1c8b:	3c 02                	cmp    al,0x2
    1c8d:	0f 94 c0             	sete   al
    1c90:	0f b6 c8             	movzx  ecx,al
    1c93:	0f be 55 af          	movsx  edx,BYTE PTR [rbp-0x51]
    1c97:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c9b:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1c9e:	89 c0                	mov    eax,eax
    1ca0:	48 89 c6             	mov    rsi,rax
    1ca3:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    1ca7:	48 89 c7             	mov    rdi,rax
    1caa:	e8 00 00 00 00       	call   1caf <elf_resolve_symbols+0x3f6>
										sbprintf("and is global\n");
    1caf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1cb6:	b8 00 00 00 00       	mov    eax,0x0
    1cbb:	e8 00 00 00 00       	call   1cc0 <elf_resolve_symbols+0x407>
    1cc0:	e9 08 04 00 00       	jmp    20cd <elf_resolve_symbols+0x814>
								}
						} else
								s->st_value = ad;
    1cc5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1cc9:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
    1ccc:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
    1ccf:	e9 f9 03 00 00       	jmp    20cd <elf_resolve_symbols+0x814>
				} else if (s->st_shndx < SHN_LORESERVE) {
    1cd4:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1cd8:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1cdc:	66 3d ff fe          	cmp    ax,0xfeff
    1ce0:	0f 87 c9 02 00 00    	ja     1faf <elf_resolve_symbols+0x6f6>
						/* local symbol so get virtual address for relocations */
						if (!(shdr[s->st_shndx].sh_flags & SHF_ALLOC))
    1ce6:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1cea:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1cee:	0f b7 d0             	movzx  edx,ax
    1cf1:	48 89 d0             	mov    rax,rdx
    1cf4:	48 c1 e0 02          	shl    rax,0x2
    1cf8:	48 01 d0             	add    rax,rdx
    1cfb:	48 c1 e0 03          	shl    rax,0x3
    1cff:	48 89 c2             	mov    rdx,rax
    1d02:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1d06:	48 01 d0             	add    rax,rdx
    1d09:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1d0c:	83 e0 02             	and    eax,0x2
    1d0f:	85 c0                	test   eax,eax
    1d11:	0f 84 b5 03 00 00    	je     20cc <elf_resolve_symbols+0x813>
								continue; /* skip symbols in unused sections */
						s->st_value += shdr[s->st_shndx].sh_addr;
    1d17:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d1b:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
    1d1e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d22:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1d26:	0f b7 d0             	movzx  edx,ax
    1d29:	48 89 d0             	mov    rax,rdx
    1d2c:	48 c1 e0 02          	shl    rax,0x2
    1d30:	48 01 d0             	add    rax,rdx
    1d33:	48 c1 e0 03          	shl    rax,0x3
    1d37:	48 89 c2             	mov    rdx,rax
    1d3a:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1d3e:	48 01 d0             	add    rax,rdx
    1d41:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    1d44:	8d 14 01             	lea    edx,[rcx+rax*1]
    1d47:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d4b:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
						sbprintf("symbol %s from %s defined at vmem=%p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
							  			(void*)s->st_value);
    1d4e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d52:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1d55:	89 c0                	mov    eax,eax
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1d57:	49 89 c4             	mov    r12,rax
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
    1d5a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d5e:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1d62:	0f b7 d0             	movzx  edx,ax
    1d65:	48 89 d0             	mov    rax,rdx
    1d68:	48 c1 e0 02          	shl    rax,0x2
    1d6c:	48 01 d0             	add    rax,rdx
    1d6f:	48 c1 e0 03          	shl    rax,0x3
    1d73:	48 89 c2             	mov    rdx,rax
    1d76:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1d7a:	48 01 d0             	add    rax,rdx
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1d7d:	8b 08                	mov    ecx,DWORD PTR [rax]
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
    1d7f:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1d83:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1d87:	0f b7 d0             	movzx  edx,ax
    1d8a:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1d8e:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1d92:	48 89 c7             	mov    rdi,rax
    1d95:	e8 00 00 00 00       	call   1d9a <elf_resolve_symbols+0x4e1>
    1d9a:	48 89 c3             	mov    rbx,rax
    1d9d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1da1:	8b 08                	mov    ecx,DWORD PTR [rax]
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
    1da3:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1daa:	48 89 d0             	mov    rax,rdx
    1dad:	48 c1 e0 02          	shl    rax,0x2
    1db1:	48 01 d0             	add    rax,rdx
    1db4:	48 c1 e0 03          	shl    rax,0x3
    1db8:	48 89 c2             	mov    rdx,rax
    1dbb:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1dbf:	48 01 d0             	add    rax,rdx
    1dc2:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1dc5:	0f b7 d0             	movzx  edx,ax
    1dc8:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1dcc:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1dd0:	48 89 c7             	mov    rdi,rax
    1dd3:	e8 00 00 00 00       	call   1dd8 <elf_resolve_symbols+0x51f>
    1dd8:	4c 89 e1             	mov    rcx,r12
    1ddb:	48 89 da             	mov    rdx,rbx
    1dde:	48 89 c6             	mov    rsi,rax
    1de1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1de8:	b8 00 00 00 00       	mov    eax,0x0
    1ded:	e8 00 00 00 00       	call   1df2 <elf_resolve_symbols+0x539>
						if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_init") == 0) {
    1df2:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1df6:	8b 08                	mov    ecx,DWORD PTR [rax]
    1df8:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1dff:	48 89 d0             	mov    rax,rdx
    1e02:	48 c1 e0 02          	shl    rax,0x2
    1e06:	48 01 d0             	add    rax,rdx
    1e09:	48 c1 e0 03          	shl    rax,0x3
    1e0d:	48 89 c2             	mov    rdx,rax
    1e10:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1e14:	48 01 d0             	add    rax,rdx
    1e17:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1e1a:	0f b7 d0             	movzx  edx,ax
    1e1d:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1e21:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1e25:	48 89 c7             	mov    rdi,rax
    1e28:	e8 00 00 00 00       	call   1e2d <elf_resolve_symbols+0x574>
    1e2d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1e34:	48 89 c7             	mov    rdi,rax
    1e37:	e8 00 00 00 00       	call   1e3c <elf_resolve_symbols+0x583>
    1e3c:	85 c0                	test   eax,eax
    1e3e:	75 3b                	jne    1e7b <elf_resolve_symbols+0x5c2>
								mi->mi_init = (mod_init)s->st_value;
    1e40:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1e44:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1e47:	89 c0                	mov    eax,eax
    1e49:	48 89 c2             	mov    rdx,rax
    1e4c:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1e53:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
								sbprintf("found global entry module_init at %p\n", mi->mi_init);
    1e57:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1e5e:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1e62:	48 89 c6             	mov    rsi,rax
    1e65:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e6c:	b8 00 00 00 00       	mov    eax,0x0
    1e71:	e8 00 00 00 00       	call   1e76 <elf_resolve_symbols+0x5bd>
    1e76:	e9 84 00 00 00       	jmp    1eff <elf_resolve_symbols+0x646>
						} else if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_cleanup") == 0) {
    1e7b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1e7f:	8b 08                	mov    ecx,DWORD PTR [rax]
    1e81:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1e88:	48 89 d0             	mov    rax,rdx
    1e8b:	48 c1 e0 02          	shl    rax,0x2
    1e8f:	48 01 d0             	add    rax,rdx
    1e92:	48 c1 e0 03          	shl    rax,0x3
    1e96:	48 89 c2             	mov    rdx,rax
    1e99:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1e9d:	48 01 d0             	add    rax,rdx
    1ea0:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1ea3:	0f b7 d0             	movzx  edx,ax
    1ea6:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1eaa:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1eae:	48 89 c7             	mov    rdi,rax
    1eb1:	e8 00 00 00 00       	call   1eb6 <elf_resolve_symbols+0x5fd>
    1eb6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1ebd:	48 89 c7             	mov    rdi,rax
    1ec0:	e8 00 00 00 00       	call   1ec5 <elf_resolve_symbols+0x60c>
    1ec5:	85 c0                	test   eax,eax
    1ec7:	75 36                	jne    1eff <elf_resolve_symbols+0x646>
								mi->mi_cleanup = (mod_cleanup)s->st_value;
    1ec9:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1ecd:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1ed0:	89 c0                	mov    eax,eax
    1ed2:	48 89 c2             	mov    rdx,rax
    1ed5:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1edc:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
								sbprintf("found global exit module_cleanup at %p\n", mi->mi_cleanup);
    1ee0:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1ee7:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1eeb:	48 89 c6             	mov    rsi,rax
    1eee:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1ef5:	b8 00 00 00 00       	mov    eax,0x0
    1efa:	e8 00 00 00 00       	call   1eff <elf_resolve_symbols+0x646>
						}
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1eff:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f03:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1f07:	c0 e8 04             	shr    al,0x4
    1f0a:	3c 01                	cmp    al,0x1
    1f0c:	74 13                	je     1f21 <elf_resolve_symbols+0x668>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1f0e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f12:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1f16:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1f19:	3c 02                	cmp    al,0x2
    1f1b:	0f 85 ac 01 00 00    	jne    20cd <elf_resolve_symbols+0x814>
								/* exported symbol -> to global symtab */
								char tp = 'T', *sn;
    1f21:	c6 45 df 54          	mov    BYTE PTR [rbp-0x21],0x54
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    1f25:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f29:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1f2d:	0f b6 c0             	movzx  eax,al
    1f30:	83 e0 0f             	and    eax,0xf
    1f33:	83 f8 01             	cmp    eax,0x1
    1f36:	75 04                	jne    1f3c <elf_resolve_symbols+0x683>
										tp = 'D';
    1f38:	c6 45 df 44          	mov    BYTE PTR [rbp-0x21],0x44
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
    1f3c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f40:	8b 08                	mov    ecx,DWORD PTR [rax]
    1f42:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1f49:	48 89 d0             	mov    rax,rdx
    1f4c:	48 c1 e0 02          	shl    rax,0x2
    1f50:	48 01 d0             	add    rax,rdx
    1f53:	48 c1 e0 03          	shl    rax,0x3
    1f57:	48 89 c2             	mov    rdx,rax
    1f5a:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1f5e:	48 01 d0             	add    rax,rdx
    1f61:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1f64:	0f b7 d0             	movzx  edx,ax
    1f67:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1f6b:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1f6f:	48 89 c7             	mov    rdi,rax
    1f72:	e8 00 00 00 00       	call   1f77 <elf_resolve_symbols+0x6be>
    1f77:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
    1f7b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f7f:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1f83:	c0 e8 04             	shr    al,0x4
    1f86:	3c 02                	cmp    al,0x2
    1f88:	0f 94 c0             	sete   al
    1f8b:	0f b6 c8             	movzx  ecx,al
    1f8e:	0f be 55 df          	movsx  edx,BYTE PTR [rbp-0x21]
    1f92:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f96:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1f99:	89 c0                	mov    eax,eax
    1f9b:	48 89 c6             	mov    rsi,rax
    1f9e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1fa2:	48 89 c7             	mov    rdi,rax
    1fa5:	e8 00 00 00 00       	call   1faa <elf_resolve_symbols+0x6f1>
    1faa:	e9 1e 01 00 00       	jmp    20cd <elf_resolve_symbols+0x814>
						}
				} else if (s->st_shndx == SHN_ABS) {
    1faf:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1fb3:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1fb7:	66 83 f8 f1          	cmp    ax,0xfff1
    1fbb:	0f 85 0c 01 00 00    	jne    20cd <elf_resolve_symbols+0x814>
						sbprintf("absolute symbol with name %s and value %p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
							  			(void*)s->st_value);
    1fc1:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1fc5:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1fc8:	89 c0                	mov    eax,eax
						sbprintf("absolute symbol with name %s and value %p\n",
    1fca:	48 89 c3             	mov    rbx,rax
    1fcd:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1fd1:	8b 08                	mov    ecx,DWORD PTR [rax]
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
    1fd3:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1fda:	48 89 d0             	mov    rax,rdx
    1fdd:	48 c1 e0 02          	shl    rax,0x2
    1fe1:	48 01 d0             	add    rax,rdx
    1fe4:	48 c1 e0 03          	shl    rax,0x3
    1fe8:	48 89 c2             	mov    rdx,rax
    1feb:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1fef:	48 01 d0             	add    rax,rdx
    1ff2:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
						sbprintf("absolute symbol with name %s and value %p\n",
    1ff5:	0f b7 d0             	movzx  edx,ax
    1ff8:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1ffc:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2000:	48 89 c7             	mov    rdi,rax
    2003:	e8 00 00 00 00       	call   2008 <elf_resolve_symbols+0x74f>
    2008:	48 89 da             	mov    rdx,rbx
    200b:	48 89 c6             	mov    rsi,rax
    200e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2015:	b8 00 00 00 00       	mov    eax,0x0
    201a:	e8 00 00 00 00       	call   201f <elf_resolve_symbols+0x766>
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    201f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2023:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    2027:	c0 e8 04             	shr    al,0x4
    202a:	3c 01                	cmp    al,0x1
    202c:	74 13                	je     2041 <elf_resolve_symbols+0x788>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    202e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2032:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    2036:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    2039:	3c 02                	cmp    al,0x2
    203b:	0f 85 8c 00 00 00    	jne    20cd <elf_resolve_symbols+0x814>
								char tp = 'T', *sn;
    2041:	c6 45 de 54          	mov    BYTE PTR [rbp-0x22],0x54
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    2045:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2049:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    204d:	0f b6 c0             	movzx  eax,al
    2050:	83 e0 0f             	and    eax,0xf
    2053:	83 f8 01             	cmp    eax,0x1
    2056:	75 04                	jne    205c <elf_resolve_symbols+0x7a3>
										tp = 'D';
    2058:	c6 45 de 44          	mov    BYTE PTR [rbp-0x22],0x44
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
    205c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2060:	8b 08                	mov    ecx,DWORD PTR [rax]
    2062:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    2069:	48 89 d0             	mov    rax,rdx
    206c:	48 c1 e0 02          	shl    rax,0x2
    2070:	48 01 d0             	add    rax,rdx
    2073:	48 c1 e0 03          	shl    rax,0x3
    2077:	48 89 c2             	mov    rdx,rax
    207a:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    207e:	48 01 d0             	add    rax,rdx
    2081:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    2084:	0f b7 d0             	movzx  edx,ax
    2087:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    208b:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    208f:	48 89 c7             	mov    rdi,rax
    2092:	e8 00 00 00 00       	call   2097 <elf_resolve_symbols+0x7de>
    2097:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
    209b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    209f:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    20a3:	c0 e8 04             	shr    al,0x4
    20a6:	3c 02                	cmp    al,0x2
    20a8:	0f 94 c0             	sete   al
    20ab:	0f b6 c8             	movzx  ecx,al
    20ae:	0f be 55 de          	movsx  edx,BYTE PTR [rbp-0x22]
    20b2:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20b6:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    20b9:	89 c0                	mov    eax,eax
    20bb:	48 89 c6             	mov    rsi,rax
    20be:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    20c2:	48 89 c7             	mov    rdi,rax
    20c5:	e8 00 00 00 00       	call   20ca <elf_resolve_symbols+0x811>
    20ca:	eb 01                	jmp    20cd <elf_resolve_symbols+0x814>
								continue; /* skip symbols in unused sections */
    20cc:	90                   	nop
		for (i = 1; i < ct; i++) {
    20cd:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    20d2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    20d6:	48 3b 45 c8          	cmp    rax,QWORD PTR [rbp-0x38]
    20da:	0f 82 b8 f8 ff ff    	jb     1998 <elf_resolve_symbols+0xdf>
    20e0:	eb 01                	jmp    20e3 <elf_resolve_symbols+0x82a>
				return;
    20e2:	90                   	nop
						}
				}
		}
}
    20e3:	48 81 c4 90 00 00 00 	add    rsp,0x90
    20ea:	5b                   	pop    rbx
    20eb:	41 5c                	pop    r12
    20ed:	5d                   	pop    rbp
    20ee:	c3                   	ret

00000000000020ef <load_elf>:

/*#define ELF_DIAG*/

enum elferr load_elf(void* mem, uint32_t sz, struct module_info* mi)
{
    20ef:	55                   	push   rbp
    20f0:	48 89 e5             	mov    rbp,rsp
    20f3:	53                   	push   rbx
    20f4:	48 81 ec 68 01 00 00 	sub    rsp,0x168
    20fb:	48 89 bd a8 fe ff ff 	mov    QWORD PTR [rbp-0x158],rdi
    2102:	89 b5 a4 fe ff ff    	mov    DWORD PTR [rbp-0x15c],esi
    2108:	48 89 95 98 fe ff ff 	mov    QWORD PTR [rbp-0x168],rdx
		Elf32_Ehdr* hdr = (Elf32_Ehdr*)mem;
    210f:	48 8b 85 a8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x158]
    2116:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		Elf32_Shdr* shdr; size_t i;

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, 4) != 0)
    211a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    211e:	ba 04 00 00 00       	mov    edx,0x4
    2123:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    212a:	48 89 c7             	mov    rdi,rax
    212d:	e8 00 00 00 00       	call   2132 <load_elf+0x43>
    2132:	85 c0                	test   eax,eax
    2134:	74 0a                	je     2140 <load_elf+0x51>
				return ELF_WRONG_MAGIC;
    2136:	b8 01 00 00 00       	mov    eax,0x1
    213b:	e9 78 0e 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (hdr->e_ident[EI_CLASS] != ELFCLASS32)
    2140:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2144:	0f b6 40 04          	movzx  eax,BYTE PTR [rax+0x4]
    2148:	3c 01                	cmp    al,0x1
    214a:	74 0a                	je     2156 <load_elf+0x67>
				return ELF_NOT_CLASS32;
    214c:	b8 02 00 00 00       	mov    eax,0x2
    2151:	e9 62 0e 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
    2156:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    215a:	0f b6 40 05          	movzx  eax,BYTE PTR [rax+0x5]
    215e:	3c 01                	cmp    al,0x1
    2160:	74 0a                	je     216c <load_elf+0x7d>
				return ELF_NOT_LE;
    2162:	b8 03 00 00 00       	mov    eax,0x3
    2167:	e9 4c 0e 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
    216c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2170:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
    2174:	3c 01                	cmp    al,0x1
    2176:	74 0a                	je     2182 <load_elf+0x93>
				return ELF_VERSION_NOT_SUPPORTED;
    2178:	b8 05 00 00 00       	mov    eax,0x5
    217d:	e9 36 0e 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
    2182:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2186:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
    218a:	84 c0                	test   al,al
    218c:	74 0a                	je     2198 <load_elf+0xa9>
				return ELF_WRONG_OSABI;
    218e:	b8 06 00 00 00       	mov    eax,0x6
    2193:	e9 20 0e 00 00       	jmp    2fb8 <load_elf+0xec9>

		/* matching ELF32 found -> check for object file */
		if (hdr->e_type != ET_REL)
    2198:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    219c:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    21a0:	66 83 f8 01          	cmp    ax,0x1
    21a4:	74 0a                	je     21b0 <load_elf+0xc1>
				return ELF_NOT_REL;
    21a6:	b8 07 00 00 00       	mov    eax,0x7
    21ab:	e9 08 0e 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (hdr->e_machine != EM_386)
    21b0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21b4:	0f b7 40 12          	movzx  eax,WORD PTR [rax+0x12]
    21b8:	66 83 f8 03          	cmp    ax,0x3
    21bc:	74 0a                	je     21c8 <load_elf+0xd9>
				return ELF_NOT_386;
    21be:	b8 08 00 00 00       	mov    eax,0x8
    21c3:	e9 f0 0d 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (hdr->e_ehsize != sizeof(*hdr))
    21c8:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21cc:	0f b7 40 28          	movzx  eax,WORD PTR [rax+0x28]
    21d0:	66 83 f8 34          	cmp    ax,0x34
    21d4:	74 0a                	je     21e0 <load_elf+0xf1>
				return ELF_INCOMPATIBLE_HEADER;
    21d6:	b8 09 00 00 00       	mov    eax,0x9
    21db:	e9 d8 0d 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (hdr->e_phnum)
    21e0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21e4:	0f b7 40 2c          	movzx  eax,WORD PTR [rax+0x2c]
    21e8:	66 85 c0             	test   ax,ax
    21eb:	74 0a                	je     21f7 <load_elf+0x108>
				return ELF_CONTAINS_PROG_HEADERS;
    21ed:	b8 0a 00 00 00       	mov    eax,0xa
    21f2:	e9 c1 0d 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (!hdr->e_shnum)
    21f7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21fb:	0f b7 40 30          	movzx  eax,WORD PTR [rax+0x30]
    21ff:	66 85 c0             	test   ax,ax
    2202:	75 0a                	jne    220e <load_elf+0x11f>
				return ELF_NO_SECTIONS_DEFINED;
    2204:	b8 0b 00 00 00       	mov    eax,0xb
    2209:	e9 aa 0d 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (hdr->e_shentsize != sizeof(Elf32_Shdr))
    220e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2212:	0f b7 40 2e          	movzx  eax,WORD PTR [rax+0x2e]
    2216:	66 83 f8 28          	cmp    ax,0x28
    221a:	74 0a                	je     2226 <load_elf+0x137>
				return ELF_WRONG_SHDR_SIZE;
    221c:	b8 0c 00 00 00       	mov    eax,0xc
    2221:	e9 92 0d 00 00       	jmp    2fb8 <load_elf+0xec9>
		if (hdr->e_shstrndx == SHN_UNDEF)
    2226:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    222a:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
    222e:	66 85 c0             	test   ax,ax
    2231:	75 0a                	jne    223d <load_elf+0x14e>
				return ELF_NO_SECTION_STRTAB;
    2233:	b8 0d 00 00 00       	mov    eax,0xd
    2238:	e9 7b 0d 00 00       	jmp    2fb8 <load_elf+0xec9>

		/* set the initial offsets */
		for (i = 0; i < 4; i++)
    223d:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2245:	eb 25                	jmp    226c <load_elf+0x17d>
				mi->vm_ofs[i] = mod_tbl.vm_ofs[i];
    2247:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    224b:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    2253:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    225a:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    225e:	48 83 c1 04          	add    rcx,0x4
    2262:	48 89 54 c8 08       	mov    QWORD PTR [rax+rcx*8+0x8],rdx
		for (i = 0; i < 4; i++)
    2267:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    226c:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
    2271:	76 d4                	jbe    2247 <load_elf+0x158>

		/* now first allocate the sections in memory */
		shdr = mem + hdr->e_shoff;
    2273:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2277:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    227a:	89 c2                	mov    edx,eax
    227c:	48 8b 85 a8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x158]
    2283:	48 01 d0             	add    rax,rdx
    2286:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		for (i = 0; i < hdr->e_shnum; i++) {
    228a:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2292:	e9 a6 07 00 00       	jmp    2a3d <load_elf+0x94e>
				if (shdr[i].sh_type == SHT_NULL)
    2297:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    229b:	48 89 d0             	mov    rax,rdx
    229e:	48 c1 e0 02          	shl    rax,0x2
    22a2:	48 01 d0             	add    rax,rdx
    22a5:	48 c1 e0 03          	shl    rax,0x3
    22a9:	48 89 c2             	mov    rdx,rax
    22ac:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22b0:	48 01 d0             	add    rax,rdx
    22b3:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    22b6:	85 c0                	test   eax,eax
    22b8:	0f 84 79 07 00 00    	je     2a37 <load_elf+0x948>
						continue;

				/* only allocate alloc section */
				if (shdr[i].sh_flags & SHF_ALLOC) {
    22be:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    22c2:	48 89 d0             	mov    rax,rdx
    22c5:	48 c1 e0 02          	shl    rax,0x2
    22c9:	48 01 d0             	add    rax,rdx
    22cc:	48 c1 e0 03          	shl    rax,0x3
    22d0:	48 89 c2             	mov    rdx,rax
    22d3:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22d7:	48 01 d0             	add    rax,rdx
    22da:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    22dd:	83 e0 02             	and    eax,0x2
    22e0:	85 c0                	test   eax,eax
    22e2:	0f 84 50 07 00 00    	je     2a38 <load_elf+0x949>
						size_t pg_ct; struct page_range pr[10];
						Elf32_Word algn = shdr[i].sh_addralign;
    22e8:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    22ec:	48 89 d0             	mov    rax,rdx
    22ef:	48 c1 e0 02          	shl    rax,0x2
    22f3:	48 01 d0             	add    rax,rdx
    22f6:	48 c1 e0 03          	shl    rax,0x3
    22fa:	48 89 c2             	mov    rdx,rax
    22fd:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2301:	48 01 d0             	add    rax,rdx
    2304:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    2307:	89 45 84             	mov    DWORD PTR [rbp-0x7c],eax
						Elf32_Addr addr; void* mapaddr; int reuse = 0;
    230a:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0
						Elf32_Off ofs = shdr[i].sh_offset;
    2311:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2315:	48 89 d0             	mov    rax,rdx
    2318:	48 c1 e0 02          	shl    rax,0x2
    231c:	48 01 d0             	add    rax,rdx
    231f:	48 c1 e0 03          	shl    rax,0x3
    2323:	48 89 c2             	mov    rdx,rax
    2326:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    232a:	48 01 d0             	add    rax,rdx
    232d:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    2330:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
						enum mt_sec sct;

						pg_ct = shdr[i].sh_size / 4096 + ((shdr[i].sh_size % 4096) ? 1 : 0);
    2333:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2337:	48 89 d0             	mov    rax,rdx
    233a:	48 c1 e0 02          	shl    rax,0x2
    233e:	48 01 d0             	add    rax,rdx
    2341:	48 c1 e0 03          	shl    rax,0x3
    2345:	48 89 c2             	mov    rdx,rax
    2348:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    234c:	48 01 d0             	add    rax,rdx
    234f:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    2352:	c1 e8 0c             	shr    eax,0xc
    2355:	89 c1                	mov    ecx,eax
    2357:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    235b:	48 89 d0             	mov    rax,rdx
    235e:	48 c1 e0 02          	shl    rax,0x2
    2362:	48 01 d0             	add    rax,rdx
    2365:	48 c1 e0 03          	shl    rax,0x3
    2369:	48 89 c2             	mov    rdx,rax
    236c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2370:	48 01 d0             	add    rax,rdx
    2373:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    2376:	25 ff 0f 00 00       	and    eax,0xfff
    237b:	85 c0                	test   eax,eax
    237d:	74 07                	je     2386 <load_elf+0x297>
    237f:	b8 01 00 00 00       	mov    eax,0x1
    2384:	eb 05                	jmp    238b <load_elf+0x29c>
    2386:	b8 00 00 00 00       	mov    eax,0x0
    238b:	01 c8                	add    eax,ecx
    238d:	89 c0                	mov    eax,eax
    238f:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						/* get the section type */
						if (shdr[i].sh_flags & SHF_WRITE) {
    2393:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2397:	48 89 d0             	mov    rax,rdx
    239a:	48 c1 e0 02          	shl    rax,0x2
    239e:	48 01 d0             	add    rax,rdx
    23a1:	48 c1 e0 03          	shl    rax,0x3
    23a5:	48 89 c2             	mov    rdx,rax
    23a8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    23ac:	48 01 d0             	add    rax,rdx
    23af:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    23b2:	83 e0 01             	and    eax,0x1
    23b5:	85 c0                	test   eax,eax
    23b7:	74 66                	je     241f <load_elf+0x330>
								/* TODO: C-o-w bss */
								if (shdr[i].sh_flags & SHF_EXECINSTR)
    23b9:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    23bd:	48 89 d0             	mov    rax,rdx
    23c0:	48 c1 e0 02          	shl    rax,0x2
    23c4:	48 01 d0             	add    rax,rdx
    23c7:	48 c1 e0 03          	shl    rax,0x3
    23cb:	48 89 c2             	mov    rdx,rax
    23ce:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    23d2:	48 01 d0             	add    rax,rdx
    23d5:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    23d8:	83 e0 04             	and    eax,0x4
    23db:	85 c0                	test   eax,eax
    23dd:	74 0a                	je     23e9 <load_elf+0x2fa>
										return ELF_SECTION_RWX;
    23df:	b8 0e 00 00 00       	mov    eax,0xe
    23e4:	e9 cf 0b 00 00       	jmp    2fb8 <load_elf+0xec9>
								if (shdr[i].sh_type == SHT_NOBITS)
    23e9:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    23ed:	48 89 d0             	mov    rax,rdx
    23f0:	48 c1 e0 02          	shl    rax,0x2
    23f4:	48 01 d0             	add    rax,rdx
    23f7:	48 c1 e0 03          	shl    rax,0x3
    23fb:	48 89 c2             	mov    rdx,rax
    23fe:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2402:	48 01 d0             	add    rax,rdx
    2405:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2408:	83 f8 08             	cmp    eax,0x8
    240b:	75 09                	jne    2416 <load_elf+0x327>
										sct = MT_SEC_BSS;
    240d:	c7 45 c4 03 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x3
    2414:	eb 77                	jmp    248d <load_elf+0x39e>
								else
										sct = MT_SEC_DATA;
    2416:	c7 45 c4 01 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x1
    241d:	eb 6e                	jmp    248d <load_elf+0x39e>
						} else if (shdr[i].sh_flags & SHF_EXECINSTR)
    241f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2423:	48 89 d0             	mov    rax,rdx
    2426:	48 c1 e0 02          	shl    rax,0x2
    242a:	48 01 d0             	add    rax,rdx
    242d:	48 c1 e0 03          	shl    rax,0x3
    2431:	48 89 c2             	mov    rdx,rax
    2434:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2438:	48 01 d0             	add    rax,rdx
    243b:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    243e:	83 e0 04             	and    eax,0x4
    2441:	85 c0                	test   eax,eax
    2443:	74 09                	je     244e <load_elf+0x35f>
								sct = MT_SEC_TEXT;
    2445:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x0
    244c:	eb 3f                	jmp    248d <load_elf+0x39e>
						else {
								/* rodata, robss? */
								if (shdr[i].sh_type == SHT_NOBITS) {
    244e:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2452:	48 89 d0             	mov    rax,rdx
    2455:	48 c1 e0 02          	shl    rax,0x2
    2459:	48 01 d0             	add    rax,rdx
    245c:	48 c1 e0 03          	shl    rax,0x3
    2460:	48 89 c2             	mov    rdx,rax
    2463:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2467:	48 01 d0             	add    rax,rdx
    246a:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    246d:	83 f8 08             	cmp    eax,0x8
    2470:	75 14                	jne    2486 <load_elf+0x397>
										printf("Implement zero page!\n");
    2472:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2479:	b8 00 00 00 00       	mov    eax,0x0
    247e:	e8 00 00 00 00       	call   2483 <load_elf+0x394>
										while (1); /* c-o-w? nope! */
    2483:	90                   	nop
    2484:	eb fd                	jmp    2483 <load_elf+0x394>
								}
								sct = MT_SEC_RODATA;
    2486:	c7 45 c4 02 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x2
						}
						/* get the raw (unaligned) address */
						addr = (Elf32_Addr)mod_tbl.vm_ofs[sct] + mi->sz_secs[sct];
    248d:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    2490:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2498:	89 c1                	mov    ecx,eax
    249a:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    24a1:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    24a4:	48 83 c2 08          	add    rdx,0x8
    24a8:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    24ad:	01 c8                	add    eax,ecx
    24af:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
						mbprintf("unaligned address for %s: %p\n", elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[i].sh_name), (void*)addr);
    24b2:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    24b5:	48 89 c3             	mov    rbx,rax
    24b8:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    24bc:	48 89 d0             	mov    rax,rdx
    24bf:	48 c1 e0 02          	shl    rax,0x2
    24c3:	48 01 d0             	add    rax,rdx
    24c6:	48 c1 e0 03          	shl    rax,0x3
    24ca:	48 89 c2             	mov    rdx,rax
    24cd:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    24d1:	48 01 d0             	add    rax,rdx
    24d4:	8b 08                	mov    ecx,DWORD PTR [rax]
    24d6:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    24da:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
    24de:	0f b7 d0             	movzx  edx,ax
    24e1:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    24e5:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    24e9:	48 89 c7             	mov    rdi,rax
    24ec:	e8 00 00 00 00       	call   24f1 <load_elf+0x402>
    24f1:	48 89 da             	mov    rdx,rbx
    24f4:	48 89 c6             	mov    rsi,rax
    24f7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    24fe:	b8 00 00 00 00       	mov    eax,0x0
    2503:	e8 00 00 00 00       	call   2508 <load_elf+0x419>

						/* now do the alignment calculations */
						if (addr % algn)
    2508:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    250b:	ba 00 00 00 00       	mov    edx,0x0
    2510:	f7 75 84             	div    DWORD PTR [rbp-0x7c]
    2513:	89 d0                	mov    eax,edx
    2515:	85 c0                	test   eax,eax
    2517:	74 13                	je     252c <load_elf+0x43d>
								addr += algn - addr % algn;
    2519:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    251c:	ba 00 00 00 00       	mov    edx,0x0
    2521:	f7 75 84             	div    DWORD PTR [rbp-0x7c]
    2524:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    2527:	29 d0                	sub    eax,edx
    2529:	01 45 dc             	add    DWORD PTR [rbp-0x24],eax
						if (algn < 0x1000 && (addr % 4096)) {
    252c:	81 7d 84 ff 0f 00 00 	cmp    DWORD PTR [rbp-0x7c],0xfff
    2533:	77 7a                	ja     25af <load_elf+0x4c0>
    2535:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2538:	25 ff 0f 00 00       	and    eax,0xfff
    253d:	85 c0                	test   eax,eax
    253f:	74 6e                	je     25af <load_elf+0x4c0>
								/* maybe save up to a single page by reusing an existing one of the same module */
								size_t ovs = shdr[i].sh_size % 4096; /* "oversize" */
    2541:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2545:	48 89 d0             	mov    rax,rdx
    2548:	48 c1 e0 02          	shl    rax,0x2
    254c:	48 01 d0             	add    rax,rdx
    254f:	48 c1 e0 03          	shl    rax,0x3
    2553:	48 89 c2             	mov    rdx,rax
    2556:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    255a:	48 01 d0             	add    rax,rdx
    255d:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    2560:	89 c0                	mov    eax,eax
    2562:	25 ff 0f 00 00       	and    eax,0xfff
    2567:	48 89 85 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rax
								if (ovs && ovs < (4096 - (addr % 4096))) {
    256e:	48 83 bd 78 ff ff ff 00 	cmp    QWORD PTR [rbp-0x88],0x0
    2576:	74 37                	je     25af <load_elf+0x4c0>
    2578:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    257b:	25 ff 0f 00 00       	and    eax,0xfff
    2580:	ba 00 10 00 00       	mov    edx,0x1000
    2585:	29 c2                	sub    edx,eax
    2587:	89 d0                	mov    eax,edx
    2589:	48 39 85 78 ff ff ff 	cmp    QWORD PTR [rbp-0x88],rax
    2590:	73 1d                	jae    25af <load_elf+0x4c0>
										/* oversize fits into existing page */
										mbprintf("reuse\n");
    2592:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2599:	b8 00 00 00 00       	mov    eax,0x0
    259e:	e8 00 00 00 00       	call   25a3 <load_elf+0x4b4>
										pg_ct--;
    25a3:	48 83 6d e0 01       	sub    QWORD PTR [rbp-0x20],0x1
										reuse = 1;
    25a8:	c7 45 cc 01 00 00 00 	mov    DWORD PTR [rbp-0x34],0x1
								}
						}
						if (addr % 4096)
    25af:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    25b2:	25 ff 0f 00 00       	and    eax,0xfff
    25b7:	85 c0                	test   eax,eax
    25b9:	74 6a                	je     2625 <load_elf+0x536>
								if (reuse) /* first use partially present page */
    25bb:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    25bf:	74 15                	je     25d6 <load_elf+0x4e7>
										mapaddr = (void*)(addr + 4096 - addr % 4096);
    25c1:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    25c4:	25 00 f0 ff ff       	and    eax,0xfffff000
    25c9:	05 00 10 00 00       	add    eax,0x1000
    25ce:	89 c0                	mov    eax,eax
    25d0:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    25d4:	eb 56                	jmp    262c <load_elf+0x53d>
								else { /* alignment leaves page partially unused */
										mapaddr = (void*)(addr - addr % 4096);
    25d6:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    25d9:	25 00 f0 ff ff       	and    eax,0xfffff000
    25de:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
										if (pg_ct * 4096 < shdr[i].sh_size + addr % 4096)
    25e2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    25e6:	48 c1 e0 0c          	shl    rax,0xc
    25ea:	48 89 c1             	mov    rcx,rax
    25ed:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    25f1:	48 89 d0             	mov    rax,rdx
    25f4:	48 c1 e0 02          	shl    rax,0x2
    25f8:	48 01 d0             	add    rax,rdx
    25fb:	48 c1 e0 03          	shl    rax,0x3
    25ff:	48 89 c2             	mov    rdx,rax
    2602:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2606:	48 01 d0             	add    rax,rdx
    2609:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    260c:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    260f:	81 e2 ff 0f 00 00    	and    edx,0xfff
    2615:	01 d0                	add    eax,edx
    2617:	89 c0                	mov    eax,eax
    2619:	48 39 c1             	cmp    rcx,rax
    261c:	73 0e                	jae    262c <load_elf+0x53d>
												pg_ct++; /* adjust space accordingly */
    261e:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
    2623:	eb 07                	jmp    262c <load_elf+0x53d>
								}
						else
								mapaddr = (void*)addr;
    2625:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2628:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax

						shdr[i].sh_addr = addr;
    262c:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2630:	48 89 d0             	mov    rax,rdx
    2633:	48 c1 e0 02          	shl    rax,0x2
    2637:	48 01 d0             	add    rax,rdx
    263a:	48 c1 e0 03          	shl    rax,0x3
    263e:	48 89 c2             	mov    rdx,rax
    2641:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2645:	48 01 c2             	add    rdx,rax
    2648:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    264b:	89 42 0c             	mov    DWORD PTR [rdx+0xc],eax
						mbprintf("aligned address: %p\n", (void*)addr);
    264e:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2651:	48 89 c6             	mov    rsi,rax
    2654:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    265b:	b8 00 00 00 00       	mov    eax,0x0
    2660:	e8 00 00 00 00       	call   2665 <load_elf+0x576>
						if (!mi->vm_ofs[sct])
    2665:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    266c:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    266f:	48 83 c2 04          	add    rdx,0x4
    2673:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    2678:	48 85 c0             	test   rax,rax
    267b:	75 19                	jne    2696 <load_elf+0x5a7>
								mi->vm_ofs[sct] = (void*)addr;
    267d:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2680:	48 89 c1             	mov    rcx,rax
    2683:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    268a:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    268d:	48 83 c2 04          	add    rdx,0x4
    2691:	48 89 4c d0 08       	mov    QWORD PTR [rax+rdx*8+0x8],rcx
						mi->sz_secs[sct] += shdr[i].sh_size;
    2696:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    269d:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    26a0:	48 83 c2 08          	add    rdx,0x8
    26a4:	48 8b 4c d0 08       	mov    rcx,QWORD PTR [rax+rdx*8+0x8]
    26a9:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    26ad:	48 89 d0             	mov    rax,rdx
    26b0:	48 c1 e0 02          	shl    rax,0x2
    26b4:	48 01 d0             	add    rax,rdx
    26b7:	48 c1 e0 03          	shl    rax,0x3
    26bb:	48 89 c2             	mov    rdx,rax
    26be:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    26c2:	48 01 d0             	add    rax,rdx
    26c5:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    26c8:	89 c0                	mov    eax,eax
    26ca:	48 01 c1             	add    rcx,rax
    26cd:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    26d4:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    26d7:	48 83 c2 08          	add    rdx,0x8
    26db:	48 89 4c d0 08       	mov    QWORD PTR [rax+rdx*8+0x8],rcx

						/* fill the half-used page (if PROGBITS) */
						if (((void*)addr < mapaddr) && (shdr[i].sh_type != SHT_NOBITS)) {
    26e0:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    26e3:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
    26e7:	0f 83 a2 00 00 00    	jae    278f <load_elf+0x6a0>
    26ed:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    26f1:	48 89 d0             	mov    rax,rdx
    26f4:	48 c1 e0 02          	shl    rax,0x2
    26f8:	48 01 d0             	add    rax,rdx
    26fb:	48 c1 e0 03          	shl    rax,0x3
    26ff:	48 89 c2             	mov    rdx,rax
    2702:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2706:	48 01 d0             	add    rax,rdx
    2709:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    270c:	83 f8 08             	cmp    eax,0x8
    270f:	74 7e                	je     278f <load_elf+0x6a0>
								size_t n = (size_t)mapaddr - (size_t)addr;
    2711:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2715:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2718:	48 29 c2             	sub    rdx,rax
    271b:	48 89 95 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rdx
								n = min(n, shdr[i].sh_size);
    2722:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2726:	48 89 d0             	mov    rax,rdx
    2729:	48 c1 e0 02          	shl    rax,0x2
    272d:	48 01 d0             	add    rax,rdx
    2730:	48 c1 e0 03          	shl    rax,0x3
    2734:	48 89 c2             	mov    rdx,rax
    2737:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    273b:	48 01 d0             	add    rax,rdx
    273e:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    2741:	89 c2                	mov    edx,eax
    2743:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    274a:	48 39 d0             	cmp    rax,rdx
    274d:	48 0f 47 c2          	cmova  rax,rdx
    2751:	48 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rax
								memcpy((void*)addr, (void*)hdr + ofs, n);
    2758:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    275b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    275f:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    2763:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2766:	48 89 c7             	mov    rdi,rax
    2769:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    2770:	48 89 c2             	mov    rdx,rax
    2773:	48 89 ce             	mov    rsi,rcx
    2776:	e8 85 d8 ff ff       	call   0 <memcpy>
								ofs += n;
    277b:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    2782:	01 45 c8             	add    DWORD PTR [rbp-0x38],eax
								addr += n;
    2785:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    278c:	01 45 dc             	add    DWORD PTR [rbp-0x24],eax
						}
						/* allocate the physical memory and map it to virtual memory */
						mbprintf("allocating %lu pages for size=%u\n", pg_ct, shdr[i].sh_size);
    278f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2793:	48 89 d0             	mov    rax,rdx
    2796:	48 c1 e0 02          	shl    rax,0x2
    279a:	48 01 d0             	add    rax,rdx
    279d:	48 c1 e0 03          	shl    rax,0x3
    27a1:	48 89 c2             	mov    rdx,rax
    27a4:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    27a8:	48 01 d0             	add    rax,rdx
    27ab:	8b 50 14             	mov    edx,DWORD PTR [rax+0x14]
    27ae:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    27b2:	48 89 c6             	mov    rsi,rax
    27b5:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    27bc:	b8 00 00 00 00       	mov    eax,0x0
    27c1:	e8 00 00 00 00       	call   27c6 <load_elf+0x6d7>
						while (pg_ct) {
    27c6:	e9 5f 02 00 00       	jmp    2a2a <load_elf+0x93b>
								int flags = MMGR_MAP_KERNEL, remap = 0;
    27cb:	c7 45 c0 08 00 00 00 	mov    DWORD PTR [rbp-0x40],0x8
    27d2:	c7 85 6c ff ff ff 00 00 00 00 	mov    DWORD PTR [rbp-0x94],0x0
								size_t np = mm_alloc_pm(pg_ct, pr, countof(pr));
    27dc:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    27e0:	89 c1                	mov    ecx,eax
    27e2:	48 8d 85 b0 fe ff ff 	lea    rax,[rbp-0x150]
    27e9:	ba 0a 00 00 00       	mov    edx,0xa
    27ee:	48 89 c6             	mov    rsi,rax
    27f1:	89 cf                	mov    edi,ecx
    27f3:	e8 00 00 00 00       	call   27f8 <load_elf+0x709>
    27f8:	89 c0                	mov    eax,eax
    27fa:	48 89 85 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rax
								if (shdr[i].sh_flags & SHF_EXECINSTR)
    2801:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2805:	48 89 d0             	mov    rax,rdx
    2808:	48 c1 e0 02          	shl    rax,0x2
    280c:	48 01 d0             	add    rax,rdx
    280f:	48 c1 e0 03          	shl    rax,0x3
    2813:	48 89 c2             	mov    rdx,rax
    2816:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    281a:	48 01 d0             	add    rax,rdx
    281d:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2820:	83 e0 04             	and    eax,0x4
    2823:	85 c0                	test   eax,eax
    2825:	74 04                	je     282b <load_elf+0x73c>
										flags |= MMGR_MAP_EXECUTE;
    2827:	83 4d c0 02          	or     DWORD PTR [rbp-0x40],0x2
								if (shdr[i].sh_flags & SHF_WRITE)
    282b:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    282f:	48 89 d0             	mov    rax,rdx
    2832:	48 c1 e0 02          	shl    rax,0x2
    2836:	48 01 d0             	add    rax,rdx
    2839:	48 c1 e0 03          	shl    rax,0x3
    283d:	48 89 c2             	mov    rdx,rax
    2840:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2844:	48 01 d0             	add    rax,rdx
    2847:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    284a:	83 e0 01             	and    eax,0x1
    284d:	85 c0                	test   eax,eax
    284f:	74 06                	je     2857 <load_elf+0x768>
										flags |= MMGR_MAP_WRITE;
    2851:	83 4d c0 04          	or     DWORD PTR [rbp-0x40],0x4
    2855:	eb 28                	jmp    287f <load_elf+0x790>
								else if (shdr[i].sh_type != SHT_NOBITS) {
    2857:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    285b:	48 89 d0             	mov    rax,rdx
    285e:	48 c1 e0 02          	shl    rax,0x2
    2862:	48 01 d0             	add    rax,rdx
    2865:	48 c1 e0 03          	shl    rax,0x3
    2869:	48 89 c2             	mov    rdx,rax
    286c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2870:	48 01 d0             	add    rax,rdx
    2873:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2876:	83 f8 08             	cmp    eax,0x8
    2879:	74 04                	je     287f <load_elf+0x790>
										flags |= MMGR_MAP_WRITE;
    287b:	83 4d c0 04          	or     DWORD PTR [rbp-0x40],0x4
								}

								mbprintf("mapping %lu pages to %p\n", np, mapaddr);
    287f:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2883:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    288a:	48 89 c6             	mov    rsi,rax
    288d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2894:	b8 00 00 00 00       	mov    eax,0x0
    2899:	e8 00 00 00 00       	call   289e <load_elf+0x7af>
								if (mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags) != mapaddr) {
    289e:	8b 4d c0             	mov    ecx,DWORD PTR [rbp-0x40]
    28a1:	48 8d 95 b0 fe ff ff 	lea    rdx,[rbp-0x150]
    28a8:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    28ac:	41 89 c8             	mov    r8d,ecx
    28af:	b9 0a 00 00 00       	mov    ecx,0xa
    28b4:	48 89 c6             	mov    rsi,rax
    28b7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28be:	e8 00 00 00 00       	call   28c3 <load_elf+0x7d4>
    28c3:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    28c7:	74 14                	je     28dd <load_elf+0x7ee>
										printf("unexpected error mapping pmem to vmem\n");
    28c9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28d0:	b8 00 00 00 00       	mov    eax,0x0
    28d5:	e8 00 00 00 00       	call   28da <load_elf+0x7eb>
										while (1);
    28da:	90                   	nop
    28db:	eb fd                	jmp    28da <load_elf+0x7eb>
								}
								/* copy data if present */
								if (shdr[i].sh_type != SHT_NOBITS) {
    28dd:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    28e1:	48 89 d0             	mov    rax,rdx
    28e4:	48 c1 e0 02          	shl    rax,0x2
    28e8:	48 01 d0             	add    rax,rdx
    28eb:	48 c1 e0 03          	shl    rax,0x3
    28ef:	48 89 c2             	mov    rdx,rax
    28f2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    28f6:	48 01 d0             	add    rax,rdx
    28f9:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    28fc:	83 f8 08             	cmp    eax,0x8
    28ff:	0f 84 0b 01 00 00    	je     2a10 <load_elf+0x921>
										size_t n = min(np * 4096, shdr[i].sh_size - (ofs - shdr[i].sh_offset));
    2905:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2909:	48 89 d0             	mov    rax,rdx
    290c:	48 c1 e0 02          	shl    rax,0x2
    2910:	48 01 d0             	add    rax,rdx
    2913:	48 c1 e0 03          	shl    rax,0x3
    2917:	48 89 c2             	mov    rdx,rax
    291a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    291e:	48 01 d0             	add    rax,rdx
    2921:	8b 48 14             	mov    ecx,DWORD PTR [rax+0x14]
    2924:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2928:	48 89 d0             	mov    rax,rdx
    292b:	48 c1 e0 02          	shl    rax,0x2
    292f:	48 01 d0             	add    rax,rdx
    2932:	48 c1 e0 03          	shl    rax,0x3
    2936:	48 89 c2             	mov    rdx,rax
    2939:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    293d:	48 01 d0             	add    rax,rdx
    2940:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    2943:	2b 45 c8             	sub    eax,DWORD PTR [rbp-0x38]
    2946:	01 c8                	add    eax,ecx
    2948:	89 c2                	mov    edx,eax
    294a:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    2951:	48 c1 e0 0c          	shl    rax,0xc
    2955:	48 39 c2             	cmp    rdx,rax
    2958:	48 0f 46 c2          	cmovbe rax,rdx
    295c:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
										mbprintf("n=%lu, ofs=%u\n", n, ofs);
    2960:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    2963:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2967:	48 89 c6             	mov    rsi,rax
    296a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2971:	b8 00 00 00 00       	mov    eax,0x0
    2976:	e8 00 00 00 00       	call   297b <load_elf+0x88c>
										if ((void*)addr > mapaddr)
    297b:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    297e:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    2982:	73 0e                	jae    2992 <load_elf+0x8a3>
												n -= (size_t)addr - (size_t)mapaddr;
    2984:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2988:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    298b:	48 29 c2             	sub    rdx,rax
    298e:	48 01 55 b8          	add    QWORD PTR [rbp-0x48],rdx
										memcpy((void*)addr, (void*)hdr + ofs, n);
    2992:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    2995:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2999:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    299d:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    29a0:	48 89 c7             	mov    rdi,rax
    29a3:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    29a7:	48 89 c2             	mov    rdx,rax
    29aa:	48 89 ce             	mov    rsi,rcx
    29ad:	e8 4e d6 ff ff       	call   0 <memcpy>
										mbprintf("copying %lu bytes to %p\n", n, (void*)addr);
    29b2:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    29b5:	48 89 c2             	mov    rdx,rax
    29b8:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    29bc:	48 89 c6             	mov    rsi,rax
    29bf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29c6:	b8 00 00 00 00       	mov    eax,0x0
    29cb:	e8 00 00 00 00       	call   29d0 <load_elf+0x8e1>
										ofs += n;
    29d0:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    29d4:	01 45 c8             	add    DWORD PTR [rbp-0x38],eax
										addr += n;
    29d7:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    29db:	01 45 dc             	add    DWORD PTR [rbp-0x24],eax
										if (remap) {
    29de:	83 bd 6c ff ff ff 00 	cmp    DWORD PTR [rbp-0x94],0x0
    29e5:	74 29                	je     2a10 <load_elf+0x921>
												flags &= ~MMGR_MAP_WRITE;
    29e7:	83 65 c0 fb          	and    DWORD PTR [rbp-0x40],0xfffffffb
												mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags);
    29eb:	8b 4d c0             	mov    ecx,DWORD PTR [rbp-0x40]
    29ee:	48 8d 95 b0 fe ff ff 	lea    rdx,[rbp-0x150]
    29f5:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    29f9:	41 89 c8             	mov    r8d,ecx
    29fc:	b9 0a 00 00 00       	mov    ecx,0xa
    2a01:	48 89 c6             	mov    rsi,rax
    2a04:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a0b:	e8 00 00 00 00       	call   2a10 <load_elf+0x921>
										}
								}
								mapaddr += np * 4096;
    2a10:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    2a17:	48 c1 e0 0c          	shl    rax,0xc
    2a1b:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
								pg_ct -= np;
    2a1f:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    2a26:	48 29 45 e0          	sub    QWORD PTR [rbp-0x20],rax
						while (pg_ct) {
    2a2a:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    2a2f:	0f 85 96 fd ff ff    	jne    27cb <load_elf+0x6dc>
    2a35:	eb 01                	jmp    2a38 <load_elf+0x949>
						continue;
    2a37:	90                   	nop
		for (i = 0; i < hdr->e_shnum; i++) {
    2a38:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2a3d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2a41:	0f b7 40 30          	movzx  eax,WORD PTR [rax+0x30]
    2a45:	0f b7 c0             	movzx  eax,ax
    2a48:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    2a4c:	0f 82 45 f8 ff ff    	jb     2297 <load_elf+0x1a8>
				}
#endif
		}

		/* Now determine the symbol values*/
		for (i = 0; i < hdr->e_shnum; i++)
    2a52:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2a5a:	e9 9d 01 00 00       	jmp    2bfc <load_elf+0xb0d>
				if (shdr[i].sh_type == SHT_SYMTAB) {
    2a5f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2a63:	48 89 d0             	mov    rax,rdx
    2a66:	48 c1 e0 02          	shl    rax,0x2
    2a6a:	48 01 d0             	add    rax,rdx
    2a6d:	48 c1 e0 03          	shl    rax,0x3
    2a71:	48 89 c2             	mov    rdx,rax
    2a74:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2a78:	48 01 d0             	add    rax,rdx
    2a7b:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2a7e:	83 f8 02             	cmp    eax,0x2
    2a81:	0f 85 70 01 00 00    	jne    2bf7 <load_elf+0xb08>
						void* vm_bss = mi->vm_ofs[MT_SEC_BSS] + mi->sz_secs[MT_SEC_BSS];
    2a87:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2a8e:	48 8b 50 40          	mov    rdx,QWORD PTR [rax+0x40]
    2a92:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2a99:	48 8b 40 60          	mov    rax,QWORD PTR [rax+0x60]
    2a9d:	48 01 d0             	add    rax,rdx
    2aa0:	48 89 85 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rax
						void* vm_aold = vm_bss + (((size_t)vm_bss % 4096) ? (4096 - ((size_t)vm_bss % 4096)) : 0);
    2aa7:	48 8b 95 58 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xa8]
    2aae:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2ab5:	25 ff 0f 00 00       	and    eax,0xfff
    2aba:	48 85 c0             	test   rax,rax
    2abd:	74 19                	je     2ad8 <load_elf+0x9e9>
    2abf:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2ac6:	25 ff 0f 00 00       	and    eax,0xfff
    2acb:	48 89 c1             	mov    rcx,rax
    2ace:	b8 00 10 00 00       	mov    eax,0x1000
    2ad3:	48 29 c8             	sub    rax,rcx
    2ad6:	eb 05                	jmp    2add <load_elf+0x9ee>
    2ad8:	b8 00 00 00 00       	mov    eax,0x0
    2add:	48 01 d0             	add    rax,rdx
    2ae0:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
						elf_resolve_symbols(hdr, shdr, i, &vm_bss, mi);
    2ae4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2ae8:	0f b7 d0             	movzx  edx,ax
    2aeb:	48 8b bd 98 fe ff ff 	mov    rdi,QWORD PTR [rbp-0x168]
    2af2:	48 8d 8d 58 ff ff ff 	lea    rcx,[rbp-0xa8]
    2af9:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    2afd:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2b01:	49 89 f8             	mov    r8,rdi
    2b04:	48 89 c7             	mov    rdi,rax
    2b07:	e8 00 00 00 00       	call   2b0c <load_elf+0xa1d>
						if (vm_bss > vm_aold) {
    2b0c:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2b13:	48 39 45 90          	cmp    QWORD PTR [rbp-0x70],rax
    2b17:	0f 83 da 00 00 00    	jae    2bf7 <load_elf+0xb08>
								size_t pgc = 0; struct page_range pr[10];
    2b1d:	48 c7 45 88 00 00 00 00 	mov    QWORD PTR [rbp-0x78],0x0
								/* allocate new bss sections */
								pgc = vm_bss - vm_aold;
    2b25:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2b2c:	48 2b 45 90          	sub    rax,QWORD PTR [rbp-0x70]
    2b30:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								pgc = pgc / 4096 + (pgc % 4096) ? 1 : 0;
    2b34:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b38:	48 c1 e8 0c          	shr    rax,0xc
    2b3c:	48 89 c2             	mov    rdx,rax
    2b3f:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b43:	25 ff 0f 00 00       	and    eax,0xfff
    2b48:	48 01 d0             	add    rax,rdx
    2b4b:	48 85 c0             	test   rax,rax
    2b4e:	0f 95 c0             	setne  al
    2b51:	0f b6 c0             	movzx  eax,al
    2b54:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								if (mm_alloc_pm(pgc, pr, 10) == pgc) {
    2b58:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b5c:	89 c1                	mov    ecx,eax
    2b5e:	48 8d 85 b0 fe ff ff 	lea    rax,[rbp-0x150]
    2b65:	ba 0a 00 00 00       	mov    edx,0xa
    2b6a:	48 89 c6             	mov    rsi,rax
    2b6d:	89 cf                	mov    edi,ecx
    2b6f:	e8 00 00 00 00       	call   2b74 <load_elf+0xa85>
    2b74:	89 c0                	mov    eax,eax
    2b76:	48 39 45 88          	cmp    QWORD PTR [rbp-0x78],rax
    2b7a:	75 67                	jne    2be3 <load_elf+0xaf4>
										/* success */
										if (!mm_map(&mm_kernel, vm_aold, pr, 10, MMGR_MAP_WRITE | MMGR_MAP_KERNEL)) {
    2b7c:	48 8d 95 b0 fe ff ff 	lea    rdx,[rbp-0x150]
    2b83:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2b87:	41 b8 0c 00 00 00    	mov    r8d,0xc
    2b8d:	b9 0a 00 00 00       	mov    ecx,0xa
    2b92:	48 89 c6             	mov    rsi,rax
    2b95:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2b9c:	e8 00 00 00 00       	call   2ba1 <load_elf+0xab2>
    2ba1:	48 85 c0             	test   rax,rax
    2ba4:	75 1b                	jne    2bc1 <load_elf+0xad2>
												printf("unable to map new bss pages to %p\n", vm_aold);
    2ba6:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2baa:	48 89 c6             	mov    rsi,rax
    2bad:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2bb4:	b8 00 00 00 00       	mov    eax,0x0
    2bb9:	e8 00 00 00 00       	call   2bbe <load_elf+0xacf>
												while (1);
    2bbe:	90                   	nop
    2bbf:	eb fd                	jmp    2bbe <load_elf+0xacf>
										}
										mi->sz_secs[MT_SEC_BSS] = vm_bss - mi->vm_ofs[MT_SEC_BSS];
    2bc1:	48 8b 95 58 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xa8]
    2bc8:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2bcf:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    2bd3:	48 29 c2             	sub    rdx,rax
    2bd6:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2bdd:	48 89 50 60          	mov    QWORD PTR [rax+0x60],rdx
    2be1:	eb 14                	jmp    2bf7 <load_elf+0xb08>
								} else {
										printf("failed to extend bss section\n");
    2be3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2bea:	b8 00 00 00 00       	mov    eax,0x0
    2bef:	e8 00 00 00 00       	call   2bf4 <load_elf+0xb05>
										while (1);
    2bf4:	90                   	nop
    2bf5:	eb fd                	jmp    2bf4 <load_elf+0xb05>
		for (i = 0; i < hdr->e_shnum; i++)
    2bf7:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2bfc:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2c00:	0f b7 40 30          	movzx  eax,WORD PTR [rax+0x30]
    2c04:	0f b7 c0             	movzx  eax,ax
    2c07:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    2c0b:	0f 82 4e fe ff ff    	jb     2a5f <load_elf+0x970>
								}
						}
				}

		/* and perform the relocations */
		for (i = 0; i < hdr->e_shnum; i++)
    2c11:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2c19:	e9 a6 02 00 00       	jmp    2ec4 <load_elf+0xdd5>
				if (shdr[i].sh_type == SHT_REL || shdr[i].sh_type == SHT_RELA) {
    2c1e:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2c22:	48 89 d0             	mov    rax,rdx
    2c25:	48 c1 e0 02          	shl    rax,0x2
    2c29:	48 01 d0             	add    rax,rdx
    2c2c:	48 c1 e0 03          	shl    rax,0x3
    2c30:	48 89 c2             	mov    rdx,rax
    2c33:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2c37:	48 01 d0             	add    rax,rdx
    2c3a:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2c3d:	83 f8 09             	cmp    eax,0x9
    2c40:	74 28                	je     2c6a <load_elf+0xb7b>
    2c42:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2c46:	48 89 d0             	mov    rax,rdx
    2c49:	48 c1 e0 02          	shl    rax,0x2
    2c4d:	48 01 d0             	add    rax,rdx
    2c50:	48 c1 e0 03          	shl    rax,0x3
    2c54:	48 89 c2             	mov    rdx,rax
    2c57:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2c5b:	48 01 d0             	add    rax,rdx
    2c5e:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2c61:	83 f8 04             	cmp    eax,0x4
    2c64:	0f 85 55 02 00 00    	jne    2ebf <load_elf+0xdd0>
						if (shdr[shdr[i].sh_info].sh_flags & SHF_ALLOC) {
    2c6a:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2c6e:	48 89 d0             	mov    rax,rdx
    2c71:	48 c1 e0 02          	shl    rax,0x2
    2c75:	48 01 d0             	add    rax,rdx
    2c78:	48 c1 e0 03          	shl    rax,0x3
    2c7c:	48 89 c2             	mov    rdx,rax
    2c7f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2c83:	48 01 d0             	add    rax,rdx
    2c86:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2c89:	89 c2                	mov    edx,eax
    2c8b:	48 89 d0             	mov    rax,rdx
    2c8e:	48 c1 e0 02          	shl    rax,0x2
    2c92:	48 01 d0             	add    rax,rdx
    2c95:	48 c1 e0 03          	shl    rax,0x3
    2c99:	48 89 c2             	mov    rdx,rax
    2c9c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2ca0:	48 01 d0             	add    rax,rdx
    2ca3:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2ca6:	83 e0 02             	and    eax,0x2
    2ca9:	85 c0                	test   eax,eax
    2cab:	0f 84 0e 02 00 00    	je     2ebf <load_elf+0xdd0>
								void* vm_begin = (void*)shdr[shdr[i].sh_info].sh_addr;
    2cb1:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2cb5:	48 89 d0             	mov    rax,rdx
    2cb8:	48 c1 e0 02          	shl    rax,0x2
    2cbc:	48 01 d0             	add    rax,rdx
    2cbf:	48 c1 e0 03          	shl    rax,0x3
    2cc3:	48 89 c2             	mov    rdx,rax
    2cc6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2cca:	48 01 d0             	add    rax,rdx
    2ccd:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2cd0:	89 c2                	mov    edx,eax
    2cd2:	48 89 d0             	mov    rax,rdx
    2cd5:	48 c1 e0 02          	shl    rax,0x2
    2cd9:	48 01 d0             	add    rax,rdx
    2cdc:	48 c1 e0 03          	shl    rax,0x3
    2ce0:	48 89 c2             	mov    rdx,rax
    2ce3:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2ce7:	48 01 d0             	add    rax,rdx
    2cea:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    2ced:	89 c0                	mov    eax,eax
    2cef:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
								size_t pgc = shdr[shdr[i].sh_info].sh_size;
    2cf3:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2cf7:	48 89 d0             	mov    rax,rdx
    2cfa:	48 c1 e0 02          	shl    rax,0x2
    2cfe:	48 01 d0             	add    rax,rdx
    2d01:	48 c1 e0 03          	shl    rax,0x3
    2d05:	48 89 c2             	mov    rdx,rax
    2d08:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2d0c:	48 01 d0             	add    rax,rdx
    2d0f:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2d12:	89 c2                	mov    edx,eax
    2d14:	48 89 d0             	mov    rax,rdx
    2d17:	48 c1 e0 02          	shl    rax,0x2
    2d1b:	48 01 d0             	add    rax,rdx
    2d1e:	48 c1 e0 03          	shl    rax,0x3
    2d22:	48 89 c2             	mov    rdx,rax
    2d25:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2d29:	48 01 d0             	add    rax,rdx
    2d2c:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    2d2f:	89 c0                	mov    eax,eax
    2d31:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
								pgc = pgc / 4096 + ((pgc % 4096) ? 1 : 0);
    2d35:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2d39:	48 c1 e8 0c          	shr    rax,0xc
    2d3d:	48 89 c2             	mov    rdx,rax
    2d40:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2d44:	25 ff 0f 00 00       	and    eax,0xfff
    2d49:	48 85 c0             	test   rax,rax
    2d4c:	74 07                	je     2d55 <load_elf+0xc66>
    2d4e:	b8 01 00 00 00       	mov    eax,0x1
    2d53:	eb 05                	jmp    2d5a <load_elf+0xc6b>
    2d55:	b8 00 00 00 00       	mov    eax,0x0
    2d5a:	48 01 d0             	add    rax,rdx
    2d5d:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
								printf("performing relocations on section %s:\n",
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[shdr[i].sh_info].sh_name));
    2d61:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2d65:	48 89 d0             	mov    rax,rdx
    2d68:	48 c1 e0 02          	shl    rax,0x2
    2d6c:	48 01 d0             	add    rax,rdx
    2d6f:	48 c1 e0 03          	shl    rax,0x3
    2d73:	48 89 c2             	mov    rdx,rax
    2d76:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2d7a:	48 01 d0             	add    rax,rdx
    2d7d:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2d80:	89 c2                	mov    edx,eax
    2d82:	48 89 d0             	mov    rax,rdx
    2d85:	48 c1 e0 02          	shl    rax,0x2
    2d89:	48 01 d0             	add    rax,rdx
    2d8c:	48 c1 e0 03          	shl    rax,0x3
    2d90:	48 89 c2             	mov    rdx,rax
    2d93:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2d97:	48 01 d0             	add    rax,rdx
								printf("performing relocations on section %s:\n",
    2d9a:	8b 08                	mov    ecx,DWORD PTR [rax]
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[shdr[i].sh_info].sh_name));
    2d9c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2da0:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
								printf("performing relocations on section %s:\n",
    2da4:	0f b7 d0             	movzx  edx,ax
    2da7:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    2dab:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2daf:	48 89 c7             	mov    rdi,rax
    2db2:	e8 00 00 00 00       	call   2db7 <load_elf+0xcc8>
    2db7:	48 89 c6             	mov    rsi,rax
    2dba:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2dc1:	b8 00 00 00 00       	mov    eax,0x0
    2dc6:	e8 00 00 00 00       	call   2dcb <load_elf+0xcdc>
								/* unguard the section */
								printf("modifying %lu pages at %p\n", pgc, vm_begin);
    2dcb:	48 8b 55 a0          	mov    rdx,QWORD PTR [rbp-0x60]
    2dcf:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2dd3:	48 89 c6             	mov    rsi,rax
    2dd6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ddd:	b8 00 00 00 00       	mov    eax,0x0
    2de2:	e8 00 00 00 00       	call   2de7 <load_elf+0xcf8>
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
    2de7:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2deb:	48 89 d0             	mov    rax,rdx
    2dee:	48 c1 e0 02          	shl    rax,0x2
    2df2:	48 01 d0             	add    rax,rdx
    2df5:	48 c1 e0 03          	shl    rax,0x3
    2df9:	48 89 c2             	mov    rdx,rax
    2dfc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2e00:	48 01 d0             	add    rax,rdx
    2e03:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2e06:	89 c2                	mov    edx,eax
    2e08:	48 89 d0             	mov    rax,rdx
    2e0b:	48 c1 e0 02          	shl    rax,0x2
    2e0f:	48 01 d0             	add    rax,rdx
    2e12:	48 c1 e0 03          	shl    rax,0x3
    2e16:	48 89 c2             	mov    rdx,rax
    2e19:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2e1d:	48 01 d0             	add    rax,rdx
    2e20:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2e23:	83 e0 01             	and    eax,0x1
    2e26:	85 c0                	test   eax,eax
    2e28:	75 1c                	jne    2e46 <load_elf+0xd57>
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_SET);
    2e2a:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    2e2e:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    2e32:	b9 04 10 00 00       	mov    ecx,0x1004
    2e37:	48 89 c6             	mov    rsi,rax
    2e3a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e41:	e8 00 00 00 00       	call   2e46 <load_elf+0xd57>
								/* relocate */
								elf_relocate_section(hdr, shdr, i);
    2e46:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2e4a:	0f b7 d0             	movzx  edx,ax
    2e4d:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    2e51:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e55:	48 89 ce             	mov    rsi,rcx
    2e58:	48 89 c7             	mov    rdi,rax
    2e5b:	e8 00 00 00 00       	call   2e60 <load_elf+0xd71>
								/* reguard the section */
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
    2e60:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2e64:	48 89 d0             	mov    rax,rdx
    2e67:	48 c1 e0 02          	shl    rax,0x2
    2e6b:	48 01 d0             	add    rax,rdx
    2e6e:	48 c1 e0 03          	shl    rax,0x3
    2e72:	48 89 c2             	mov    rdx,rax
    2e75:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2e79:	48 01 d0             	add    rax,rdx
    2e7c:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2e7f:	89 c2                	mov    edx,eax
    2e81:	48 89 d0             	mov    rax,rdx
    2e84:	48 c1 e0 02          	shl    rax,0x2
    2e88:	48 01 d0             	add    rax,rdx
    2e8b:	48 c1 e0 03          	shl    rax,0x3
    2e8f:	48 89 c2             	mov    rdx,rax
    2e92:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2e96:	48 01 d0             	add    rax,rdx
    2e99:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2e9c:	83 e0 01             	and    eax,0x1
    2e9f:	85 c0                	test   eax,eax
    2ea1:	75 1c                	jne    2ebf <load_elf+0xdd0>
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_UNSET);
    2ea3:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    2ea7:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    2eab:	b9 04 20 00 00       	mov    ecx,0x2004
    2eb0:	48 89 c6             	mov    rsi,rax
    2eb3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2eba:	e8 00 00 00 00       	call   2ebf <load_elf+0xdd0>
		for (i = 0; i < hdr->e_shnum; i++)
    2ebf:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2ec4:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2ec8:	0f b7 40 30          	movzx  eax,WORD PTR [rax+0x30]
    2ecc:	0f b7 c0             	movzx  eax,ax
    2ecf:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    2ed3:	0f 82 45 fd ff ff    	jb     2c1e <load_elf+0xb2f>
						}
				}

		/* page-align for the next module */
		/* DBG: and insert a guard-page */
		for (i = 0; i < 4; i++) {
    2ed9:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2ee1:	e9 c2 00 00 00       	jmp    2fa8 <load_elf+0xeb9>
				if (mi->sz_secs[i]) {
    2ee6:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2eed:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2ef1:	48 83 c2 08          	add    rdx,0x8
    2ef5:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    2efa:	48 85 c0             	test   rax,rax
    2efd:	0f 84 a0 00 00 00    	je     2fa3 <load_elf+0xeb4>
						mod_tbl.vm_ofs[i] = mi->vm_ofs[i] + mi->sz_secs[i];
    2f03:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2f0a:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2f0e:	48 83 c2 04          	add    rdx,0x4
    2f12:	48 8b 54 d0 08       	mov    rdx,QWORD PTR [rax+rdx*8+0x8]
    2f17:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2f1e:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    2f22:	48 83 c1 08          	add    rcx,0x8
    2f26:	48 8b 44 c8 08       	mov    rax,QWORD PTR [rax+rcx*8+0x8]
    2f2b:	48 01 c2             	add    rdx,rax
    2f2e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f32:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						if ((size_t)mod_tbl.vm_ofs[i] % 4096) {
    2f3a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f3e:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2f46:	25 ff 0f 00 00       	and    eax,0xfff
    2f4b:	48 85 c0             	test   rax,rax
    2f4e:	74 34                	je     2f84 <load_elf+0xe95>
								/* section align */
								mod_tbl.vm_ofs[i] += 4096 - (size_t)mod_tbl.vm_ofs[i] % 4096;
    2f50:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f54:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    2f5c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f60:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2f68:	25 ff 0f 00 00       	and    eax,0xfff
    2f6d:	b9 00 10 00 00       	mov    ecx,0x1000
    2f72:	48 29 c1             	sub    rcx,rax
    2f75:	48 01 ca             	add    rdx,rcx
    2f78:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f7c:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						}
						/* add guard page */
						mod_tbl.vm_ofs[i] += 4096;
    2f84:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f88:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2f90:	48 8d 90 00 10 00 00 	lea    rdx,[rax+0x1000]
    2f97:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f9b:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
		for (i = 0; i < 4; i++) {
    2fa3:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2fa8:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
    2fad:	0f 86 33 ff ff ff    	jbe    2ee6 <load_elf+0xdf7>
				}
		}

		return ELF_OK;
    2fb3:	b8 00 00 00 00       	mov    eax,0x0
}
    2fb8:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    2fbc:	c9                   	leave
    2fbd:	c3                   	ret

0000000000002fbe <get_elferr_string>:

const char* get_elferr_string(enum elferr e)
{
    2fbe:	55                   	push   rbp
    2fbf:	48 89 e5             	mov    rbp,rsp
    2fc2:	48 83 ec 08          	sub    rsp,0x8
    2fc6:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		switch (e) {
    2fc9:	83 7d fc 11          	cmp    DWORD PTR [rbp-0x4],0x11
    2fcd:	0f 87 af 00 00 00    	ja     3082 <get_elferr_string+0xc4>
    2fd3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2fd6:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2fde:	ff e0                	jmp    rax
		case ELF_WRONG_MAGIC:
				return "not ELF file";
    2fe0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2fe7:	e9 9d 00 00 00       	jmp    3089 <get_elferr_string+0xcb>
		case ELF_NOT_CLASS32:
				return "not a 32-bit ELF file";
    2fec:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2ff3:	e9 91 00 00 00       	jmp    3089 <get_elferr_string+0xcb>
		case ELF_NOMEM:
				return "out of memory";
    2ff8:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2fff:	e9 85 00 00 00       	jmp    3089 <get_elferr_string+0xcb>
		case ELF_NOT_LE:
				return "not a little-endian file";
    3004:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    300b:	eb 7c                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_VERSION_NOT_SUPPORTED:
				return "unsupported ELF version";
    300d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3014:	eb 73                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_WRONG_OSABI:
				return "unsupported OS ABI";
    3016:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    301d:	eb 6a                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_NOT_REL:
				return "modules have to be relocatable object files";
    301f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3026:	eb 61                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_NOT_386:
				return "only i386 modules can be loaded";
    3028:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    302f:	eb 58                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_INCOMPATIBLE_HEADER:
				return "unexpected size of ELF header";
    3031:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3038:	eb 4f                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_CONTAINS_PROG_HEADERS:
				return "ELF contains program heades (no object file)";
    303a:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3041:	eb 46                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_NO_SECTIONS_DEFINED:
				return "ELF contains no defined sections";
    3043:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    304a:	eb 3d                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_WRONG_SHDR_SIZE:
				return "no matching ELF section header size";
    304c:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3053:	eb 34                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_NO_SECTION_STRTAB:
				return "no ELF STRTAB for section names";
    3055:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    305c:	eb 2b                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_SECTION_RWX:
				return "module contains rwx secton";
    305e:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3065:	eb 22                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_GSTAB_ALREADY_PRESENT:
				return "the global symbol table has already been loaded";
    3067:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    306e:	eb 19                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_STRING_PARSE_NUMBER:
				return "the string parser expected a number but found none";
    3070:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3077:	eb 10                	jmp    3089 <get_elferr_string+0xcb>
		case ELF_PARSE_FORMAT_NOT_NM:
				return "the provided symbol mapping file is not in the nm format";
    3079:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3080:	eb 07                	jmp    3089 <get_elferr_string+0xcb>
		default:
				return "unknown";
    3082:	48 c7 c0 00 00 00 00 	mov    rax,0x0
		}
}
    3089:	c9                   	leave
    308a:	c3                   	ret

000000000000308b <elf_parse_global_symtab>:

enum elferr elf_parse_global_symtab(void* addr, size_t sz)
{
    308b:	55                   	push   rbp
    308c:	48 89 e5             	mov    rbp,rsp
    308f:	48 83 ec 50          	sub    rsp,0x50
    3093:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    3097:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
		const char* str = (const char*)addr; size_t cap = 64;
    309b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    309f:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
    30a3:	48 c7 45 f8 40 00 00 00 	mov    QWORD PTR [rbp-0x8],0x40
		struct symbol_list* sl;
		if (gs_lst)
    30ab:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 30b2 <elf_parse_global_symtab+0x27>
    30b2:	48 85 c0             	test   rax,rax
    30b5:	74 0a                	je     30c1 <elf_parse_global_symtab+0x36>
				return ELF_GSTAB_ALREADY_PRESENT;
    30b7:	b8 0f 00 00 00       	mov    eax,0xf
    30bc:	e9 eb 02 00 00       	jmp    33ac <elf_parse_global_symtab+0x321>

		/* allocate the initial capacity */
		sl = gs_lst = kmalloc(sizeof(struct symbol_list));
    30c1:	bf 08 06 00 00       	mov    edi,0x608
    30c6:	e8 00 00 00 00       	call   30cb <elf_parse_global_symtab+0x40>
    30cb:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 30d2 <elf_parse_global_symtab+0x47>
    30d2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 30d9 <elf_parse_global_symtab+0x4e>
    30d9:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!sl)
    30dd:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    30e2:	75 0a                	jne    30ee <elf_parse_global_symtab+0x63>
				return ELF_NOMEM;
    30e4:	b8 04 00 00 00       	mov    eax,0x4
    30e9:	e9 be 02 00 00       	jmp    33ac <elf_parse_global_symtab+0x321>
		sl->next = NULL;
    30ee:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    30f2:	48 c7 80 00 06 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x600],0x0

		while ((size_t)((void*)str - addr) < sz) {
    30fd:	e9 3a 02 00 00       	jmp    333c <elf_parse_global_symtab+0x2b1>
				const char* s1 = str; char *s2; char tp = ' ';
    3102:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3106:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    310a:	c6 45 e7 20          	mov    BYTE PTR [rbp-0x19],0x20
				long val = strtol(str, (char**)&str, 16);
    310e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3112:	48 8d 4d c8          	lea    rcx,[rbp-0x38]
    3116:	ba 10 00 00 00       	mov    edx,0x10
    311b:	48 89 ce             	mov    rsi,rcx
    311e:	48 89 c7             	mov    rdi,rax
    3121:	e8 00 00 00 00       	call   3126 <elf_parse_global_symtab+0x9b>
    3126:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				
				if (s1 == str)
    312a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    312e:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    3132:	75 0a                	jne    313e <elf_parse_global_symtab+0xb3>
						return ELF_STRING_PARSE_NUMBER;
    3134:	b8 10 00 00 00       	mov    eax,0x10
    3139:	e9 6e 02 00 00       	jmp    33ac <elf_parse_global_symtab+0x321>
				if (*str++ != ' ')
    313e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3142:	48 8d 50 01          	lea    rdx,[rax+0x1]
    3146:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    314a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    314d:	3c 20                	cmp    al,0x20
    314f:	74 0a                	je     315b <elf_parse_global_symtab+0xd0>
						return ELF_PARSE_FORMAT_NOT_NM;
    3151:	b8 11 00 00 00       	mov    eax,0x11
    3156:	e9 51 02 00 00       	jmp    33ac <elf_parse_global_symtab+0x321>
				tp = *str++;
    315b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    315f:	48 8d 50 01          	lea    rdx,[rax+0x1]
    3163:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    3167:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    316a:	88 45 e7             	mov    BYTE PTR [rbp-0x19],al
				if (*str++ != ' ')
    316d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3171:	48 8d 50 01          	lea    rdx,[rax+0x1]
    3175:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    3179:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    317c:	3c 20                	cmp    al,0x20
    317e:	74 0a                	je     318a <elf_parse_global_symtab+0xff>
						return ELF_PARSE_FORMAT_NOT_NM;
    3180:	b8 11 00 00 00       	mov    eax,0x11
    3185:	e9 22 02 00 00       	jmp    33ac <elf_parse_global_symtab+0x321>
				s1 = strchr(str, '\n');
    318a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    318e:	be 0a 00 00 00       	mov    esi,0xa
    3193:	48 89 c7             	mov    rdi,rax
    3196:	e8 00 00 00 00       	call   319b <elf_parse_global_symtab+0x110>
    319b:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!s1) {
    319f:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    31a4:	75 20                	jne    31c6 <elf_parse_global_symtab+0x13b>
						printf("strchr!\n");
    31a6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    31ad:	b8 00 00 00 00       	mov    eax,0x0
    31b2:	e8 00 00 00 00       	call   31b7 <elf_parse_global_symtab+0x12c>
						s1 = (const char*)(addr + sz);
    31b7:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    31bb:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    31bf:	48 01 d0             	add    rax,rdx
    31c2:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				}
				s2 = strndup(str, s1 - str);
    31c6:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    31ca:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    31ce:	48 29 c2             	sub    rdx,rax
    31d1:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    31d5:	48 89 d6             	mov    rsi,rdx
    31d8:	48 89 c7             	mov    rdi,rax
    31db:	e8 00 00 00 00       	call   31e0 <elf_parse_global_symtab+0x155>
    31e0:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax

				/*printf("symbol at %p: \"%s\" type %c\n", (void*)val, s2, tp);------------------*/
				if (strcmp(s2, "printf") == 0)
    31e4:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    31e8:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    31ef:	48 89 c7             	mov    rdi,rax
    31f2:	e8 00 00 00 00       	call   31f7 <elf_parse_global_symtab+0x16c>
    31f7:	85 c0                	test   eax,eax
    31f9:	75 52                	jne    324d <elf_parse_global_symtab+0x1c2>
						if (&printf != (void*)val) {
    31fb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    31ff:	48 3d 00 00 00 00    	cmp    rax,0x0
    3205:	74 46                	je     324d <elf_parse_global_symtab+0x1c2>
								cprintf(KFMT_WARN, "WARNING! Loaded outdated symtab!\n");
    3207:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    320e:	bf 0e 00 00 00       	mov    edi,0xe
    3213:	b8 00 00 00 00       	mov    eax,0x0
    3218:	e8 00 00 00 00       	call   321d <elf_parse_global_symtab+0x192>
								printf("printf is located at %p but symtab says it's at %p\n",
    321d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3221:	48 89 c2             	mov    rdx,rax
    3224:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    322b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3232:	b8 00 00 00 00       	mov    eax,0x0
    3237:	e8 00 00 00 00       	call   323c <elf_parse_global_symtab+0x1b1>
												&printf, (void*)val);
								printf("expect modules to fail randomly as the\n"
    323c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3243:	b8 00 00 00 00       	mov    eax,0x0
    3248:	e8 00 00 00 00       	call   324d <elf_parse_global_symtab+0x1c2>
									   "symbols used therein will not be resolved correctly\n");
						}

				/* expand the capacity if needed */
				if (!cap) {
    324d:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    3252:	75 5b                	jne    32af <elf_parse_global_symtab+0x224>
						sl->next = kmalloc(sizeof(struct symbol_list));
    3254:	bf 08 06 00 00       	mov    edi,0x608
    3259:	e8 00 00 00 00       	call   325e <elf_parse_global_symtab+0x1d3>
    325e:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3262:	48 89 82 00 06 00 00 	mov    QWORD PTR [rdx+0x600],rax
						if (!sl) {
    3269:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    326e:	75 19                	jne    3289 <elf_parse_global_symtab+0x1fe>
								cprintf(KFMT_ERROR, "Out of memory for parsing global symbol table\n");
    3270:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3277:	bf 0c 00 00 00       	mov    edi,0xc
    327c:	b8 00 00 00 00       	mov    eax,0x0
    3281:	e8 00 00 00 00       	call   3286 <elf_parse_global_symtab+0x1fb>
								while (1);
    3286:	90                   	nop
    3287:	eb fd                	jmp    3286 <elf_parse_global_symtab+0x1fb>
						}
						sl = sl->next;
    3289:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    328d:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    3294:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						sl->next = NULL;
    3298:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    329c:	48 c7 80 00 06 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x600],0x0
						cap = 64;
    32a7:	48 c7 45 f8 40 00 00 00 	mov    QWORD PTR [rbp-0x8],0x40
				}

				/* store the two values */
				sl->entries[64 - cap].name = s2;
    32af:	b8 40 00 00 00       	mov    eax,0x40
    32b4:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    32b8:	48 89 c2             	mov    rdx,rax
    32bb:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    32bf:	48 89 d0             	mov    rax,rdx
    32c2:	48 01 c0             	add    rax,rax
    32c5:	48 01 d0             	add    rax,rdx
    32c8:	48 c1 e0 03          	shl    rax,0x3
    32cc:	48 01 c8             	add    rax,rcx
    32cf:	48 8d 50 08          	lea    rdx,[rax+0x8]
    32d3:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    32d7:	48 89 02             	mov    QWORD PTR [rdx],rax
				sl->entries[64 - cap].vma = (void*)val;
    32da:	b8 40 00 00 00       	mov    eax,0x40
    32df:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    32e3:	48 89 c2             	mov    rdx,rax
    32e6:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
    32ea:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
    32ee:	48 89 d0             	mov    rax,rdx
    32f1:	48 01 c0             	add    rax,rax
    32f4:	48 01 d0             	add    rax,rdx
    32f7:	48 c1 e0 03          	shl    rax,0x3
    32fb:	48 01 f0             	add    rax,rsi
    32fe:	48 89 08             	mov    QWORD PTR [rax],rcx
				sl->entries[64 - cap].type = tp;
    3301:	b8 40 00 00 00       	mov    eax,0x40
    3306:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    330a:	48 89 c2             	mov    rdx,rax
    330d:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    3311:	48 89 d0             	mov    rax,rdx
    3314:	48 01 c0             	add    rax,rax
    3317:	48 01 d0             	add    rax,rdx
    331a:	48 c1 e0 03          	shl    rax,0x3
    331e:	48 01 c8             	add    rax,rcx
    3321:	48 8d 50 10          	lea    rdx,[rax+0x10]
    3325:	0f b6 45 e7          	movzx  eax,BYTE PTR [rbp-0x19]
    3329:	88 02                	mov    BYTE PTR [rdx],al
				cap--;
    332b:	48 83 6d f8 01       	sub    QWORD PTR [rbp-0x8],0x1
				/* and advance */
				str = s1 + 1;
    3330:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3334:	48 83 c0 01          	add    rax,0x1
    3338:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		while ((size_t)((void*)str - addr) < sz) {
    333c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3340:	48 2b 45 b8          	sub    rax,QWORD PTR [rbp-0x48]
    3344:	48 3b 45 b0          	cmp    rax,QWORD PTR [rbp-0x50]
    3348:	0f 82 b4 fd ff ff    	jb     3102 <elf_parse_global_symtab+0x77>
		}

		/* zero-terminate not fully used lists */
		if (cap) {
    334e:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    3353:	74 52                	je     33a7 <elf_parse_global_symtab+0x31c>
				sl->entries[64 - cap].name = NULL;
    3355:	b8 40 00 00 00       	mov    eax,0x40
    335a:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    335e:	48 89 c2             	mov    rdx,rax
    3361:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    3365:	48 89 d0             	mov    rax,rdx
    3368:	48 01 c0             	add    rax,rax
    336b:	48 01 d0             	add    rax,rdx
    336e:	48 c1 e0 03          	shl    rax,0x3
    3372:	48 01 c8             	add    rax,rcx
    3375:	48 83 c0 08          	add    rax,0x8
    3379:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				sl->entries[64 - cap].vma = NULL;
    3380:	b8 40 00 00 00       	mov    eax,0x40
    3385:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    3389:	48 89 c2             	mov    rdx,rax
    338c:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    3390:	48 89 d0             	mov    rax,rdx
    3393:	48 01 c0             	add    rax,rax
    3396:	48 01 d0             	add    rax,rdx
    3399:	48 c1 e0 03          	shl    rax,0x3
    339d:	48 01 c8             	add    rax,rcx
    33a0:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
		}
		return ELF_OK;
    33a7:	b8 00 00 00 00       	mov    eax,0x0
}
    33ac:	c9                   	leave
    33ad:	c3                   	ret

00000000000033ae <load_modules>:

void load_modules()
{
    33ae:	55                   	push   rbp
    33af:	48 89 e5             	mov    rbp,rsp
    33b2:	48 81 ec 90 00 00 00 	sub    rsp,0x90
		void* mem = (void*)0x200000;
    33b9:	48 c7 45 f8 00 00 20 00 	mov    QWORD PTR [rbp-0x8],0x200000
		uint32_t mct = *(uint32_t*)mem;
    33c1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    33c5:	8b 00                	mov    eax,DWORD PTR [rax]
    33c7:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		enum elferr ee;
		mem += sizeof(uint32_t);
    33ca:	48 83 45 f8 04       	add    QWORD PTR [rbp-0x8],0x4

		if (strcmp(mem, "LD.MAP") != 0) {
    33cf:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    33d3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    33da:	48 89 c7             	mov    rdi,rax
    33dd:	e8 00 00 00 00       	call   33e2 <load_modules+0x34>
    33e2:	85 c0                	test   eax,eax
    33e4:	74 19                	je     33ff <load_modules+0x51>
				cprintf(KFMT_ERROR, "first file has to be global symbol map\n");
    33e6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    33ed:	bf 0c 00 00 00       	mov    edi,0xc
    33f2:	b8 00 00 00 00       	mov    eax,0x0
    33f7:	e8 00 00 00 00       	call   33fc <load_modules+0x4e>
				while (1);
    33fc:	90                   	nop
    33fd:	eb fd                	jmp    33fc <load_modules+0x4e>
		} else
				mem += 7;
    33ff:	48 83 45 f8 07       	add    QWORD PTR [rbp-0x8],0x7
		/* parse the kernel symbol table supplied in nm format */
		if ((ee = elf_parse_global_symtab(mem + sizeof(uint32_t), *(uint32_t*)mem))) {
    3404:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3408:	8b 00                	mov    eax,DWORD PTR [rax]
    340a:	89 c2                	mov    edx,eax
    340c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3410:	48 83 c0 04          	add    rax,0x4
    3414:	48 89 d6             	mov    rsi,rdx
    3417:	48 89 c7             	mov    rdi,rax
    341a:	e8 00 00 00 00       	call   341f <load_modules+0x71>
    341f:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
    3422:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    3426:	74 57                	je     347f <load_modules+0xd1>
				cprintf(KFMT_ERROR, "Failed to parse global kernel symbol table ("
    3428:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    342f:	bf 0c 00 00 00       	mov    edi,0xc
    3434:	b8 00 00 00 00       	mov    eax,0x0
    3439:	e8 00 00 00 00       	call   343e <load_modules+0x90>
					   "file ld.map in root directory)\n");
				cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
    343e:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    3441:	89 c7                	mov    edi,eax
    3443:	e8 00 00 00 00       	call   3448 <load_modules+0x9a>
    3448:	48 89 c2             	mov    rdx,rax
    344b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3452:	bf 0c 00 00 00       	mov    edi,0xc
    3457:	b8 00 00 00 00       	mov    eax,0x0
    345c:	e8 00 00 00 00       	call   3461 <load_modules+0xb3>
				memdump(mem + sizeof(uint32_t), *(uint32_t*)mem);
    3461:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3465:	8b 00                	mov    eax,DWORD PTR [rax]
    3467:	89 c2                	mov    edx,eax
    3469:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    346d:	48 83 c0 04          	add    rax,0x4
    3471:	48 89 d6             	mov    rsi,rdx
    3474:	48 89 c7             	mov    rdi,rax
    3477:	e8 00 00 00 00       	call   347c <load_modules+0xce>
				while (1);
    347c:	90                   	nop
    347d:	eb fd                	jmp    347c <load_modules+0xce>
		}
		mem += sizeof(uint32_t) + *(uint32_t*)mem;
    347f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3483:	8b 00                	mov    eax,DWORD PTR [rax]
    3485:	89 c0                	mov    eax,eax
    3487:	48 83 c0 04          	add    rax,0x4
    348b:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		mct--;
    348f:	83 6d f4 01          	sub    DWORD PTR [rbp-0xc],0x1

		/* try to load each module */
		while (mct--) {
    3493:	e9 ff 01 00 00       	jmp    3697 <load_modules+0x2e9>
				const char* name = (const char*)mem;
    3498:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    349c:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				uint32_t sz;
				struct module_info mi = {0};
    34a0:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
    34a7:	b8 00 00 00 00       	mov    eax,0x0
    34ac:	b9 0d 00 00 00       	mov    ecx,0xd
    34b1:	48 89 d7             	mov    rdi,rdx
    34b4:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
				mem += strlen(name) + 1;
    34b7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    34bb:	48 89 c7             	mov    rdi,rax
    34be:	e8 00 00 00 00       	call   34c3 <load_modules+0x115>
    34c3:	48 83 c0 01          	add    rax,0x1
    34c7:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
				sz = *(uint32_t*)mem;
    34cb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    34cf:	8b 00                	mov    eax,DWORD PTR [rax]
    34d1:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
				mem += sizeof(uint32_t);
    34d4:	48 83 45 f8 04       	add    QWORD PTR [rbp-0x8],0x4
				strncpy(mi.mi_name, name, 20);
    34d9:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    34dd:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    34e4:	ba 14 00 00 00       	mov    edx,0x14
    34e9:	48 89 ce             	mov    rsi,rcx
    34ec:	48 89 c7             	mov    rdi,rax
    34ef:	e8 00 00 00 00       	call   34f4 <load_modules+0x146>
				printf("loading module %.20s...\n", mi.mi_name);
    34f4:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    34fb:	48 89 c6             	mov    rsi,rax
    34fe:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3505:	b8 00 00 00 00       	mov    eax,0x0
    350a:	e8 00 00 00 00       	call   350f <load_modules+0x161>
				if ((ee = load_elf(mem, sz, &mi))) {
    350f:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
    3516:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
    3519:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    351d:	89 ce                	mov    esi,ecx
    351f:	48 89 c7             	mov    rdi,rax
    3522:	e8 00 00 00 00       	call   3527 <load_modules+0x179>
    3527:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
    352a:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    352e:	74 43                	je     3573 <load_modules+0x1c5>
						cprintf(KFMT_ERROR, "Failed to load ELF module at %p\n", mem);
    3530:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3534:	48 89 c2             	mov    rdx,rax
    3537:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    353e:	bf 0c 00 00 00       	mov    edi,0xc
    3543:	b8 00 00 00 00       	mov    eax,0x0
    3548:	e8 00 00 00 00       	call   354d <load_modules+0x19f>
						cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
    354d:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    3550:	89 c7                	mov    edi,eax
    3552:	e8 00 00 00 00       	call   3557 <load_modules+0x1a9>
    3557:	48 89 c2             	mov    rdx,rax
    355a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3561:	bf 0c 00 00 00       	mov    edi,0xc
    3566:	b8 00 00 00 00       	mov    eax,0x0
    356b:	e8 00 00 00 00       	call   3570 <load_modules+0x1c2>
						while (1);
    3570:	90                   	nop
    3571:	eb fd                	jmp    3570 <load_modules+0x1c2>
				} else {
						int errc;
						cprintf(KFMT_INFO, "loaded module at the following offsets and sizes:\n");
    3573:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    357a:	bf 0b 00 00 00       	mov    edi,0xb
    357f:	b8 00 00 00 00       	mov    eax,0x0
    3584:	e8 00 00 00 00       	call   3589 <load_modules+0x1db>
						cprintf(KFMT_INFO, ".text    %p %11lu\n", mi.vm_ofs[0], mi.sz_secs[0]);
    3589:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    358d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3591:	48 89 d1             	mov    rcx,rdx
    3594:	48 89 c2             	mov    rdx,rax
    3597:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    359e:	bf 0b 00 00 00       	mov    edi,0xb
    35a3:	b8 00 00 00 00       	mov    eax,0x0
    35a8:	e8 00 00 00 00       	call   35ad <load_modules+0x1ff>
						cprintf(KFMT_INFO, ".data    %p %11lu\n", mi.vm_ofs[1], mi.sz_secs[1]);
    35ad:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    35b1:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    35b5:	48 89 d1             	mov    rcx,rdx
    35b8:	48 89 c2             	mov    rdx,rax
    35bb:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    35c2:	bf 0b 00 00 00       	mov    edi,0xb
    35c7:	b8 00 00 00 00       	mov    eax,0x0
    35cc:	e8 00 00 00 00       	call   35d1 <load_modules+0x223>
						cprintf(KFMT_INFO, ".rodata  %p %11lu\n", mi.vm_ofs[2], mi.sz_secs[2]);
    35d1:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    35d5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    35d9:	48 89 d1             	mov    rcx,rdx
    35dc:	48 89 c2             	mov    rdx,rax
    35df:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    35e6:	bf 0b 00 00 00       	mov    edi,0xb
    35eb:	b8 00 00 00 00       	mov    eax,0x0
    35f0:	e8 00 00 00 00       	call   35f5 <load_modules+0x247>
						cprintf(KFMT_INFO, ".bss     %p %11lu\n", mi.vm_ofs[3], mi.sz_secs[3]);
    35f5:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    35f9:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    35fd:	48 89 d1             	mov    rcx,rdx
    3600:	48 89 c2             	mov    rdx,rax
    3603:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    360a:	bf 0b 00 00 00       	mov    edi,0xb
    360f:	b8 00 00 00 00       	mov    eax,0x0
    3614:	e8 00 00 00 00       	call   3619 <load_modules+0x26b>
						cprintf(KFMT_INFO, "calling module_init()...\n");
    3619:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3620:	bf 0b 00 00 00       	mov    edi,0xb
    3625:	b8 00 00 00 00       	mov    eax,0x0
    362a:	e8 00 00 00 00       	call   362f <load_modules+0x281>
						errc = mi.mi_init();
    362f:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    3633:	b8 00 00 00 00       	mov    eax,0x0
    3638:	ff d2                	call   rdx
    363a:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
						if (errc) {
    363d:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    3641:	74 1e                	je     3661 <load_modules+0x2b3>
								cprintf(KFMT_ERROR, "init failed with error %d\n", errc);
    3643:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    3646:	89 c2                	mov    edx,eax
    3648:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    364f:	bf 0c 00 00 00       	mov    edi,0xc
    3654:	b8 00 00 00 00       	mov    eax,0x0
    3659:	e8 00 00 00 00       	call   365e <load_modules+0x2b0>
								while (1);
    365e:	90                   	nop
    365f:	eb fd                	jmp    365e <load_modules+0x2b0>
						} else {
								cprintf(KFMT_OK, "successfully initialized module \"%s\"\n", mi.mi_name);
    3661:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    3668:	48 89 c2             	mov    rdx,rax
    366b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3672:	bf 0a 00 00 00       	mov    edi,0xa
    3677:	b8 00 00 00 00       	mov    eax,0x0
    367c:	e8 00 00 00 00       	call   3681 <load_modules+0x2d3>
								store_module_info(&mi);
    3681:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    3688:	48 89 c7             	mov    rdi,rax
    368b:	e8 00 00 00 00       	call   3690 <load_modules+0x2e2>
						}
				}

				mem += sz;
    3690:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    3693:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		while (mct--) {
    3697:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    369a:	8d 50 ff             	lea    edx,[rax-0x1]
    369d:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
    36a0:	85 c0                	test   eax,eax
    36a2:	0f 85 f0 fd ff ff    	jne    3498 <load_modules+0xea>
		}

		printf("done loading kernel modules\n");
    36a8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36af:	b8 00 00 00 00       	mov    eax,0x0
    36b4:	e8 00 00 00 00       	call   36b9 <load_modules+0x30b>
}
    36b9:	90                   	nop
    36ba:	c9                   	leave
    36bb:	c3                   	ret
